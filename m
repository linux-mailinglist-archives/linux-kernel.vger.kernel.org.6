Return-Path: <linux-kernel+bounces-541453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B37A5A4BD0B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA5517A5855
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8290F1F3BBD;
	Mon,  3 Mar 2025 10:53:42 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8E1F30B3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999222; cv=none; b=uT5ze9QnTU2Nx5MjN/wXjImae68JhvNlVx/8+TK4Uf0tMFvIl2tKZOpehGUQWe36dsc9HcoV4dQPDXXqK3QLDKudbta9sscL34CegTQvxNfeL93BPLrfgmL8gPeJU0wpqVJGRp2TuxR/b9wR05ScdJiJNha7HQ5aUJ4NpQq4tNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999222; c=relaxed/simple;
	bh=IxLafNvvFttrmOiNrSQRs+lSseO4cQaIwe4/IL5N2Gk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcOSPehZwhWR92LWY0r5QH4TOv1V2GALCEwERVL5cOz+MLcuqeqmS/sC5J3DCfxuUeOr5uu2PYwB0YDjjvwBZ4KXnbtDJ4piTd04zogqEmsozbpnacPQnox02rVs0ffztay3T3VvkESKN7olBwsgPYXU+ZaSvOm1R/lwvAbTxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 523ArPdi092378;
	Mon, 3 Mar 2025 18:53:25 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Z5wXR4r0zz2K8nM6;
	Mon,  3 Mar 2025 18:48:39 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 3 Mar 2025 18:53:22 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vincent.guittot@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>, <di.shen@unisoc.com>,
        <xuewen.yan94@gmail.com>
Subject: [RFC PATCH V2 2/3] sched/fair: Do not consider the sched-delayed task when yield
Date: Mon, 3 Mar 2025 18:52:40 +0800
Message-ID: <20250303105241.17251-3-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303105241.17251-1-xuewen.yan@unisoc.com>
References: <20250303105241.17251-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 523ArPdi092378

When task call sched_yield, if there is only one task in rq,
it is no need to yield, however now, the rq->nr_running include
the sched-delayed tasks which are indeed not runnable tasks.
So sub the sched-delayed tasks when check the nr-running.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a354f29c4f6f..8797f6872155 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8992,7 +8992,7 @@ static void yield_task_fair(struct rq *rq)
 	/*
 	 * Are we the only task in the tree?
 	 */
-	if (unlikely(rq->nr_running == 1))
+	if (unlikely((rq->nr_running - cfs_h_nr_delayed(rq)) == 1))
 		return;
 
 	clear_buddies(cfs_rq, se);
-- 
2.25.1


