Return-Path: <linux-kernel+bounces-252914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C849319D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C683B21703
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAB54E1C8;
	Mon, 15 Jul 2024 17:49:52 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124154918
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721065792; cv=none; b=Kch6F2kY4zvzDDC22q6ENwaqvonHWBI05qgsEmY/DpjELgP+slPWw026o9cQ4O3oyX4PPZw2RPG1QXNxwD0QGXGDEJAHRzj5oOE2GfGM+dPZ5AZIV1yq0REVlXnZmkLRpfJxvykkWXyDipXkydspr2I6XLWoWSOdOFm7UW3tYLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721065792; c=relaxed/simple;
	bh=sFFsFDmZYy8eaGMnk0gLw4In2PnVa9NoGh3a6s13kbA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oMxqONKo87Ne4ozAnucPDG/Ro99Y50qX1ijK1S/ZfbhZIbhGfmrYPYCQqLu0xhwmPJaor+dMK2L1bLlCPhzDltC4YLRX3qDB83Vd1uEBj8TDZ169ZeBc7hyileqsWFONDC+ytj6oz/dHliTQeEqnnpUpOu+Tw7C+xofOQL8gXvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sTPpV-000000003Pp-2e0M;
	Mon, 15 Jul 2024 13:49:41 -0400
Date: Mon, 15 Jul 2024 13:49:41 -0400
From: Rik van Riel <riel@surriel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 neeraj.upadhyay@kernel.org, mingo@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH] smp: print only local CPU info when sched_clock goes 
 backward
Message-ID: <20240715134941.7ac59eb9@imladris.surriel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

About 40% of all csd_lock warnings observed in our fleet appear to
be due to sched_clock() going backward in time (usually only a little
bit), resulting in ts0 being larger than ts2.

When the local CPU is at fault, we should print out a message reflecting
that, rather than trying to get the remote CPU's stack trace.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index f085ebcdf9e7..5656ef63ea82 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -237,6 +237,14 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
 		return false;
 
+	if (ts0 > ts2) {
+		/* Our own sched_clock went backward; don't blame another CPU. */
+		ts_delta = ts0 - ts2;
+		pr_alert("sched_clock on CPU %d went backward by %llu ns\n", raw_smp_processor_id(), ts_delta);
+		*ts1 = ts2;
+		return false;
+	}
+
 	firsttime = !*bug_id;
 	if (firsttime)
 		*bug_id = atomic_inc_return(&csd_bug_count);
-- 
2.45.2


