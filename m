Return-Path: <linux-kernel+bounces-318041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC696E785
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4A61C22332
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B846C1EB35;
	Fri,  6 Sep 2024 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYyVfzow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C401FDD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 02:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725588409; cv=none; b=ZI2yUAtv92N10Lr71UB9mQ1GpDPXDvYETe17UcehVUOm9KXP0Wk6VrnVBxZ6n5L6i+nEmRAPqYk//F7xKG2/MRgkGoi3f8DPB5J67gpuhWsED1HNSDbSTP2O975EnLHpFgF8F9veKG3pD+OH+0Iu0ex0IVhmdM+BgmfnFKERrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725588409; c=relaxed/simple;
	bh=w8EOJh7Q0vmzHm+c+IQOyLMNZi7sWZx6oefL4el6QiI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y+z53K74/1H5IxRAQLH9hYudJi3FOCRc0dT3E8G9nR0MktGtHbu/0ItbwE6F0ZQSOqTBgtGF3QxJPckOVStOFqmzxrlgGyBcZXrRlNLQR4lq4MnJGD24QZ8+h4XwoYHBIGu5N9kI4XbsniLF/MlGCzlR43TUayInuNA7yrgtZto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYyVfzow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF4BC4CEC3;
	Fri,  6 Sep 2024 02:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725588408;
	bh=w8EOJh7Q0vmzHm+c+IQOyLMNZi7sWZx6oefL4el6QiI=;
	h=Date:From:To:Cc:Subject:From;
	b=VYyVfzowTuqloujJTyZU2Zm0fyUvWC0xlQbBEHsMx1IfJpA9NsI7SmuNQCAhdXr/R
	 aXk0Rwmb8XNpoqiEtgJKGZqNNoF15/Sd6byxVBEQ1vs4RXGPAvyXG0reCBOoZjiupm
	 E0C+INdqla9bfaR419M1gJhzLXXlp/TYN87cGl9Z9NSXwcvH2LyEC2TjQ0qXYHc4TD
	 AeVH0LEosga3Uh3X1ANvvwICouuAIhEpdDAFgAJ2VcunuUml4MsrKwyIprubPyGNn8
	 qTCy7hNs2VYHJSrp4GQSgy3u0TtBuUDNa3x2QB5scLzbGeYmky3nIEgGvc5my+BXal
	 sNS4bLywL1ROA==
Date: Thu, 5 Sep 2024 16:06:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH sched/core] sched: Warn if a sched_class says yes on
 balance() but no on pick_task()
Message-ID: <Ztpjt5Pz9pJliblL@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If a sched_class says yes on balance() but no on pick_task(),
__pick_next_task() will end up descending to lower sched classes which
haven't been balanced. This can lead to sub-optimal scheduling decisions
and, especially for sched_ext, stalls. Detect the condition and warn.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
This triggers immedately on the current tip/sched/core. Best to apply after
fixing the existing issue.

Thanks.

 kernel/sched/core.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5893,8 +5893,8 @@ static inline void schedule_debug(struct
 	schedstat_inc(this_rq()->sched_count);
 }
 
-static void prev_balance(struct rq *rq, struct task_struct *prev,
-			 struct rq_flags *rf)
+static const struct sched_class *
+prev_balance(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	const struct sched_class *start_class = prev->sched_class;
 	const struct sched_class *class;
@@ -5919,8 +5919,10 @@ static void prev_balance(struct rq *rq,
 	 */
 	for_active_class_range(class, start_class, &idle_sched_class) {
 		if (class->balance && class->balance(rq, prev, rf))
-			break;
+			return class;
 	}
+
+	return &idle_sched_class;
 }
 
 /*
@@ -5929,7 +5931,7 @@ static void prev_balance(struct rq *rq,
 static inline struct task_struct *
 __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	const struct sched_class *class;
+	const struct sched_class *class, *balanced;
 	struct task_struct *p;
 
 	rq->dl_server = NULL;
@@ -5960,23 +5962,29 @@ __pick_next_task(struct rq *rq, struct t
 	}
 
 restart:
-	prev_balance(rq, prev, rf);
+	balanced = prev_balance(rq, prev, rf);
 
 	for_each_active_class(class) {
 		if (class->pick_next_task) {
 			p = class->pick_next_task(rq, prev);
 			if (p)
-				return p;
+				goto picked;
 		} else {
 			p = class->pick_task(rq);
 			if (p) {
 				put_prev_set_next_task(rq, prev, p);
-				return p;
+				goto picked;
 			}
 		}
 	}
 
 	BUG(); /* The idle class should always have a runnable task. */
+
+picked:
+	WARN_ONCE(sched_class_above(balanced, class),
+		  "%ps->balance() returned true but no task, %ps picked instead\n",
+		  balanced, class);
+	return p;
 }
 
 #ifdef CONFIG_SCHED_CORE

