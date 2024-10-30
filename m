Return-Path: <linux-kernel+bounces-389036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F7D9B67C7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0281F22B88
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D362170B3;
	Wed, 30 Oct 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="btR0bnor"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7342561D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301954; cv=none; b=HclgfAAhlmjY63Se8jcWSWGzBpS194GkdgSN2nA81C87q5xWaxRs8l++cZLt1zqQm/v1ICNePNarfX7bIL0M087dXhW8RT2hb4z2R33K+sZ/gbTwttFZi9RYg6I2YoiYX1QmdLveJGfCcgy+t9SlbA3u/BCfxl1zSWQ4Y8/HPOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301954; c=relaxed/simple;
	bh=6Ks3e9Uk/ZKTYxD4/YEDl9B2m8TpBp0jREYyDCrsFkM=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=k9s6aCBu+nLWVlUT/TGDKiuBHBJt0QMMAiN9npVHgGAgjHTuQm9kIcdmH3ivR5WoAFUtfvZhprJNm6AJvrdq+0HEbnO1rXWYkdlzjSN3RxbCHvjLFwe8gWKqKfDfTgp2O5UChmIOgzbo/KLlGmN3zun4NPhbPjq3pN0/o3A19rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=btR0bnor; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=iqBunzPUDSWv3TKKN/Q/5ZZ4v9ZwJa4KftzK5/fKuWc=; b=btR0bnorRWdwLKz1MGOsuEd/ou
	oj2sqnQakVQSdB1C9HeduNVlxBJ/uRs1yDCshMNBVhVZv5al0xqbMbQSv1FQwvqVPoVYI/ZY61ZEd
	pxbbLjHFg19ManLBbu3oFSOXHOX1z4Z3NE6SUjA7IyAqp7MLKmpGkhHzpKEtz1rEpX9AAW/XLxdAS
	f1MLCWpTQWKwcemPBzOX86/l9cXxN7bQQ6a9bZqXfSmBpcBKx5/xGXAVUnn3HEY9RZrFe8iZ5mXtJ
	HcIdwUbHmlaMnX9gRldFuPkXLqSMcXynI1JVaIdraULxeAhrR5394k1U3UHuUOMtLp1IZdnw4HojT
	Rxl9vVYg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AZs-0000000DYqU-2VEh;
	Wed, 30 Oct 2024 15:25:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DB0B6300B40; Wed, 30 Oct 2024 16:25:43 +0100 (CET)
Message-Id: <20241030152142.372771313@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 30 Oct 2024 16:12:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 void@manifault.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] sched/ext: Fix scx vs sched_delayed
References: <20241030151255.300069509@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Commit 98442f0ccd82 ("sched: Fix delayed_dequeue vs
switched_from_fair()") forgot about scx :/

Fixes: 98442f0ccd82 ("sched: Fix delayed_dequeue vs switched_from_fair()")
Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241030104934.GK14555@noisy.programming.kicks-ass.net
---
 kernel/sched/ext.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4489,11 +4489,16 @@ static void scx_ops_disable_workfn(struc
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
+		const struct sched_class *new_class =
+			__setscheduler_class(p->policy, p->prio);
 		struct sched_enq_and_set_ctx ctx;
 
+		if (old_class != new_class && p->se.sched_delayed)
+			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
-		p->sched_class = __setscheduler_class(p->policy, p->prio);
+		p->sched_class = new_class;
 		check_class_changing(task_rq(p), p, old_class);
 
 		sched_enq_and_set_task(&ctx);
@@ -5199,12 +5204,17 @@ static int scx_ops_enable(struct sched_e
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
+		const struct sched_class *new_class =
+			__setscheduler_class(p->policy, p->prio);
 		struct sched_enq_and_set_ctx ctx;
 
+		if (old_class != new_class && p->se.sched_delayed)
+			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEE_DELAYED);
+
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
 		p->scx.slice = SCX_SLICE_DFL;
-		p->sched_class = __setscheduler_class(p->policy, p->prio);
+		p->sched_class = new_class;
 		check_class_changing(task_rq(p), p, old_class);
 
 		sched_enq_and_set_task(&ctx);



