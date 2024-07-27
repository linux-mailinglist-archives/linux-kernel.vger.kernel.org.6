Return-Path: <linux-kernel+bounces-264108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7D693DF0C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88031F22F77
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C18613AA4D;
	Sat, 27 Jul 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OlXggREI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4558674055
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078149; cv=none; b=odXiaaLvf74e+XHYoK5Yf0Gv7tpmcagwBCOoIPKb128WkWmnTE4unecdyE3g7Dbhj9AXpyUl90+nQNsyu+2wMjuCgN3rOJ7ao4sYnjwwnFN8chEH0Z8pRbg28VrsamJB5Mh71nW9mK1fnsqXSEvww09vMulouQdHCmlykaIyi64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078149; c=relaxed/simple;
	bh=/bt1jsGljwmqXDGhUCqycO9P4j980Pnqs6I+pKCnaeQ=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Wka+d55hrNgO82vSRq07PSxPUa0lyA7h0M40uNgSfsOJmpPUwyRd+VOgOMuCHQBpqyBvdy+qvTYbP1e1DKvysMRc/rDqhQYqTc4CLHkrkJ5LICJbmQ607hMlYOg5ur8+tT/fgwhsRc0XY+iWMxm8/9blhaVJyjtNr6bepoPaML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OlXggREI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=KBYqzmCCXvnBT8Ca4wIXVC+Krpwe0R190Rjd8q21tHM=; b=OlXggREI53hQu8Ybf7Ynld8smL
	5ggNhFVte30x3qcwiB2t62a6jVYOz3TB5F+UgKNYCNEFwds1mGwji/vphe+2xxgpIc7329AdYdKmr
	Lxy+bxyNz/sVSBWBEiG9O+aJEUWWVTKGONa86H1P+RqJoR1wWEKrpr0hVBJd/uADFrXsSZnBKa3bT
	TZqn3mG3GYiAIX8U5yN6+Ifg7cJ4wRQu7NDfgUXaSTQUh9zuTq5+h5NpCyVGw9v6XckADmXW13YCY
	7Tb1ee1E/F9xOvHOu2pNNZFu9LksSMvJcIBN5jgpzmrOWZ3/Zq87IBgdx/ntVnoBErJIHgnuN2EBQ
	R3psUyWg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBh-0000000BGJX-1oRh;
	Sat, 27 Jul 2024 11:02:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E568F306212; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105030.514088302@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:51 +0200
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
Subject: [PATCH 19/24] sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Note that tasks that are kept on the runqueue to burn off negative
lag, are not in fact runnable anymore, they'll get dequeued the moment
they get picked.

As such, don't count this time towards runnable.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c  |    2 ++
 kernel/sched/sched.h |    6 ++++++
 2 files changed, 8 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5388,6 +5388,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 			if (cfs_rq->next == se)
 				cfs_rq->next = NULL;
 			se->sched_delayed = 1;
+			update_load_avg(cfs_rq, se, 0);
 			return false;
 		}
 	}
@@ -6814,6 +6815,7 @@ requeue_delayed_entity(struct sched_enti
 	}
 
 	se->sched_delayed = 0;
+	update_load_avg(cfs_rq, se, 0);
 }
 
 /*
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -816,6 +816,9 @@ static inline void se_update_runnable(st
 
 static inline long se_runnable(struct sched_entity *se)
 {
+	if (se->sched_delayed)
+		return false;
+
 	if (entity_is_task(se))
 		return !!se->on_rq;
 	else
@@ -830,6 +833,9 @@ static inline void se_update_runnable(st
 
 static inline long se_runnable(struct sched_entity *se)
 {
+	if (se->sched_delayed)
+		return false;
+
 	return !!se->on_rq;
 }
 



