Return-Path: <linux-kernel+bounces-309277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E37966871
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFF9285308
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9B51BB6BA;
	Fri, 30 Aug 2024 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVMBEr60"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD0914E2E9
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040483; cv=none; b=IVEHYlRRZFcuUZNmDkPZAl2vG8nZNPlYhUNHgd2py3ttiOm1EkQyfY2Xpv9BfWMgnb3MSqCeGRWNOJHTmjFZzvdA6cdVpXZIgGHYso3DewoFpuWrFa14oE7/29a7FTf4nDiXwPbGyK1AiFNgqtMIi++3ZMApDf16SVGL+i9Tho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040483; c=relaxed/simple;
	bh=jCpD2gyvMgL1BvHORsb+KEChwrLBbDvA5bPpM1f4bvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmUo3vUnAlPjOJxCmEaK2pQHpTCAJ0nPrczVlVxzvMxIhRU79KQIcOafDCO0gwIZjXMzmfD2mieo3Sd+OPnbcPeSYXbn0138u+8FKsSn6kbBrjTdYa03cKTaB7F99xGSw8TWkLat4pxUZON7PaozfUL8g3dktgtPv7ZYssUAzRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVMBEr60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C94C4CEC2;
	Fri, 30 Aug 2024 17:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725040482;
	bh=jCpD2gyvMgL1BvHORsb+KEChwrLBbDvA5bPpM1f4bvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVMBEr60K70d0Dikm2unKIVkQq2qJhoISMiD91rLfYBlHM1DAVocRTFqqhtusPOLi
	 EsF5KjlObCx7YW1+Dk51MOJM3D7g7RlB9/iQhjp4Ckdg3IPGpAswCW1isistt0Fvq7
	 Mnr305VsbmNZ5Ry7GCXWLFO9QJf8OAe5Sbwon1IinYT6aMJUel2hHomIyAwLhHdbV8
	 ShwtT4pmPNU63QJzUy071KzF9nW2pMWfwk3Z9kI6IB2WuSqETNyScg4ApRmP6VghMa
	 bEA3uZ83uSK/phojBVUgQBS8ZyAqyIcVY6ce0k+7TTu856y8SD5Nj4HEaranJhFeX6
	 PbVdzZ8Nyihtg==
Date: Fri, 30 Aug 2024 07:54:41 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	kernel-team@meta.com
Subject: [PATCH v2 2/2 sched_ext/for-6.12] sched_ext: Use sched_clock_cpu()
 instead of rq_clock_task() in touch_core_sched()
Message-ID: <ZtIHYe4DgGlu8k1n@slm.duckdns.org>
References: <ZtGkPKgoE5BeI7fN@slm.duckdns.org>
 <ZtGkgCEkgNLzjxUC@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtGkgCEkgNLzjxUC@slm.duckdns.org>

Since 3cf78c5d01d6 ("sched_ext: Unpin and repin rq lock from
balance_scx()"), sched_ext's balance path terminates rq_pin in the outermost
function. This is simpler and in line with what other balance functions are
doing but it loses control over rq->clock_update_flags which makes
assert_clock_udpated() trigger if other CPUs pins the rq lock.

The only place this matters is touch_core_sched() which uses the timestamp
to order tasks from sibling rq's. Switch to sched_clock_cpu(). Later, it may
be better to use per-core dispatch sequence number.

v2: Use sched_clock_cpu() instead of ktime_get_ns() per David.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 3cf78c5d01d6 ("sched_ext: Unpin and repin rq lock from balance_scx()")
Cc: David Vernet <void@manifault.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/ext.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1453,13 +1453,18 @@ static void schedule_deferred(struct rq
  */
 static void touch_core_sched(struct rq *rq, struct task_struct *p)
 {
+	lockdep_assert_rq_held(rq);
+
 #ifdef CONFIG_SCHED_CORE
 	/*
 	 * It's okay to update the timestamp spuriously. Use
 	 * sched_core_disabled() which is cheaper than enabled().
+	 *
+	 * As this is used to determine ordering between tasks of sibling CPUs,
+	 * it may be better to use per-core dispatch sequence instead.
 	 */
 	if (!sched_core_disabled())
-		p->scx.core_sched_at = rq_clock_task(rq);
+		p->scx.core_sched_at = sched_clock_cpu(cpu_of(rq));
 #endif
 }
 
@@ -1476,7 +1481,6 @@ static void touch_core_sched(struct rq *
 static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
 {
 	lockdep_assert_rq_held(rq);
-	assert_clock_updated(rq);
 
 #ifdef CONFIG_SCHED_CORE
 	if (SCX_HAS_OP(core_sched_before))

