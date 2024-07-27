Return-Path: <linux-kernel+bounces-264110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2638A93DF0A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C631F22DBB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557A013AA40;
	Sat, 27 Jul 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pas/nqwO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67B455C3E
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078149; cv=none; b=ugudYREeb659N2+OgjBe+VvQRTRziih2OOAB8IdaZMupvGZATg7S90O2dWad0n27m9pzfHVYMHdnP4y86JnqP3prIwJEMBhg752aQW/SM/p/tbZ0dfNT8+S/9aNhNIxl1xu6s+VKVkiFhpqe3X4GpQly+2GB46W9uma1M2sSc+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078149; c=relaxed/simple;
	bh=itOTK8ClA+pTJ/B6S2TzJ7Aj4zf26Rg68UHzyKxe108=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DP/YnJ9QQVL+mBedanzht/5aTmqLqV2ouNL0qJB6oJ9nCZfeCwLqHWcUjhAfwN+T/MghaqfIAGXM2ImvNymNHTlVg5PyyJJH6Cuq36o9SSFB9WXhKf0qd2gEBZ2tqc/D+XVZMmMDPb3T3pBOIT7TEEeu9VSizwVSMb0eJLzzkxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pas/nqwO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Y5Ccj0++8TjNxyCdrumDAmasoET46Cckf/W1eeLKY0g=; b=Pas/nqwOlLXNF1z9srw84pRITK
	wy61UcYWAQYBokTeCDQjkP/j2EZmncaubDVheaAxuClIfHqsoGzC8CN/tMROzmzFKnHjZx1eHjmho
	87i4ks8O9B3cbYxYvAXucU6F1GxIiVgspEB20glkzEVF8SuEKlvQdesMSxEwZnk9vc3Km9rPa2JUv
	Ql2f2Xn95IPodaNAGABd66br8DExQswlXfQh3VTcC2vqNUSip3Bz7wW//1guSLeHwDEDT9QShvwem
	/48ZbYsXVZWmHlCt1cgb5mueQpFkm6RZvPZEr2Mj7VUWIpPC+YBw+6CINlJA+KQg+FI+l6P58FpId
	cUWjq16w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBf-0000000BGJL-2Xv4;
	Sat, 27 Jul 2024 11:02:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 9C49C300CBA; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105028.614707623@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [PATCH 04/24] sched/fair: Cleanup pick_task_fair()s curr
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

With 4c456c9ad334 ("sched/fair: Remove unused 'curr' argument from
pick_next_entity()") curr is no longer being used, so no point in
clearing it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8427,15 +8427,9 @@ static struct task_struct *pick_task_fai
 		return NULL;
 
 	do {
-		struct sched_entity *curr = cfs_rq->curr;
-
 		/* When we pick for a remote RQ, we'll not have done put_prev_entity() */
-		if (curr) {
-			if (curr->on_rq)
-				update_curr(cfs_rq);
-			else
-				curr = NULL;
-		}
+		if (cfs_rq->curr && cfs_rq->curr->on_rq)
+			update_curr(cfs_rq);
 
 		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
 			goto again;



