Return-Path: <linux-kernel+bounces-389665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5E09B6F80
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D0D283F62
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097A321765C;
	Wed, 30 Oct 2024 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHBkmIJb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE541CF287
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324500; cv=none; b=j24YE9sn9heTX5PwfTwpQZZvjnWQMhjDKfpPhrZKGB4FpXy9ckHVOSvtq9PaTtAUKw87JG5nAd4450Ngebpi+mALClTBWvaUBMQHmoq9sAdCrWjgUZ2GCQQ1K7gD6s2ZUOkke8Erd7/9AcKVh3RKBHahFLpztbEt1O74F1ldUuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324500; c=relaxed/simple;
	bh=waECcke9CWgo4JYP30sxFkwCmrEoc2PnlefBuJeOBG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XYbh2W+Ra9jwvBKovj4p/3F1EJvkRaCMkQUrN4W00rcpcH51PAOG+Hu02YROlCPHrjKncCky1ckOLaWQL/JdccE6SnZQ+jlMF7pVM+cFlqoYpf63calg7TBJlfLZMcyREph/WuAhqM84uJgo98c3JzjhfFIrqrr2xwsFNOIZKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHBkmIJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A337C4CECE;
	Wed, 30 Oct 2024 21:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730324500;
	bh=waECcke9CWgo4JYP30sxFkwCmrEoc2PnlefBuJeOBG0=;
	h=Date:From:To:Cc:Subject:From;
	b=jHBkmIJbWs0Q4Bo3NOud1PmuVbAGcb1GjD1KLbIOKtbfH5RWiRNJ/jbG7PPzfTJ8/
	 u74H/iCeV7rU6YFYVGSnbCEthW6HRosOrBLvqeWw02/nx0AQfCnZNF3IH/5oVrqcyh
	 9iYRUSsdUqY3+COciYM52O5ISeGVAu3WSPFzDa5B1ZHSm9+9bnvVyjbgCG7MLNNfbB
	 a7shUVTwu/I1K7QxsNZynPk7a/7QoEQtf/CozQiHOS/ktzi2UlfrvzsXQOGGeZAsJI
	 0Lz42yEsNHuXl1z6Cd5AKjFJcypj6FgzzDpTUnIHLWzax1XB6ao4Qv3/WkBtW24YAx
	 kH+FehG8q3H7A==
Date: Wed, 30 Oct 2024 11:41:39 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@meta.com, kernel-team@meta.com,
	Ingo Molnar <mingo@redhat.com>
Subject: [PATCH sched_ext/for-6.12-fixes] sched_ext: Call
 __balance_callbacks() from __scx_task_iter_rq_unlock()
Message-ID: <ZyKoE9RUulWtYpEh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While tasks are being iterated to be switched in and out of SCX,
__scx_task_iter_rq_unlock() is called to unlock rq. As
sched_class->switched_from() and friends may schedule balance callbacks,
they should be executed before moving onto the next task.

This brekage is currently theoretical as only RT and DL schedule balance
callbacks on class switches and SCX only switches from/to fair.

Make __balance_callbacks() global and call it from
__scx_task_iter_rq_unlock().

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20241030154551.GN14555@noisy.programming.kicks-ass.net
---
Hello,

If this looks okay, I'll route it through sched_ext/for-6.12-fixes.

Thanks.

 kernel/sched/core.c  |    8 +-------
 kernel/sched/ext.c   |    2 ++
 kernel/sched/sched.h |    5 +++++
 3 files changed, 8 insertions(+), 7 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5028,7 +5028,7 @@ struct balance_callback *splice_balance_
 	return __splice_balance_callbacks(rq, true);
 }
 
-static void __balance_callbacks(struct rq *rq)
+void __balance_callbacks(struct rq *rq)
 {
 	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
 }
@@ -5044,12 +5044,6 @@ void balance_callbacks(struct rq *rq, st
 	}
 }
 
-#else
-
-static inline void __balance_callbacks(struct rq *rq)
-{
-}
-
 #endif
 
 static inline void
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1315,6 +1315,8 @@ static void scx_task_iter_start(struct s
 static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
 {
 	if (iter->locked) {
+		/* ->switched_from() may have scheduled balance callbacks */
+		__balance_callbacks(iter->rq);
 		task_rq_unlock(iter->rq, iter->locked, &iter->rf);
 		iter->locked = NULL;
 	}
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3908,6 +3908,7 @@ extern void check_class_changed(struct r
 #ifdef CONFIG_SMP
 extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
 extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
+extern void __balance_callbacks(struct rq *rq);
 #else
 
 static inline struct balance_callback *splice_balance_callbacks(struct rq *rq)
@@ -3919,6 +3920,10 @@ static inline void balance_callbacks(str
 {
 }
 
+static inline void __balance_callbacks(struct rq *rq)
+{
+}
+
 #endif
 
 #ifdef CONFIG_SCHED_CLASS_EXT

