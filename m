Return-Path: <linux-kernel+bounces-308624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7572E965FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E26D2B278D2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6875918FDD2;
	Fri, 30 Aug 2024 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7P1obs1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3A18E742
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015169; cv=none; b=irJduOwfwEqnRgciUMqAtNmR32nNSHOkF0bCdVVgT8lSj4LMv/tEpPUBtNmUaTMGFWFLY4QOZPZgfRyt9ArWqfZSGeY1dp2yQKiBu6d3V5DkVN34QgQFKk9/WMD5KTpcgsmcZPpFzWDwZh0mUICgtjr3fkGJ4ucIqffRTHo/CKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015169; c=relaxed/simple;
	bh=FTNxL7e/JKQ9rEkZvlMHczZsUneiqRibtUpAmYHVFFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lx0KJtOas2MXi21hZmOm+G5WDYIG9yvHhccqNxu21uu3CgodZ6gJsjhbQh71ZyJWgdemKqYKvtT/R54/pg066rq/Txl7MjnV/8CMilQvF9jlnmxHEY3oAsalbL2EP9cqn+q9khsPenZurBCAFbgEUDuhrTWRoz9sxG9kdlh7jr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7P1obs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322F0C4CEC4;
	Fri, 30 Aug 2024 10:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725015169;
	bh=FTNxL7e/JKQ9rEkZvlMHczZsUneiqRibtUpAmYHVFFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7P1obs1V5Vc87D51Oop8cXBsIVaPtItCUFC7837z2X8p7k92epsouaXcmnc1waAN
	 2pP2ZDO7xH2ngDh8hd1hCEVFl3vDWY4MpS79tH2TB/RpP01QH+/ufJnjndmQd2m7IN
	 7NTvLaZ7hBzIRVZuXUBJaHwNcv+IuKl8gs06bthN0EibAlNLPt66jyAiqPqq5mLons
	 SVgU0HFJtJH911S/PBK39qkxfi70tTxp7afft0cSCNhgNl2dmoMhCzHG7i2gsvdngQ
	 s5XJI0fo+htEzgIYb7TnCg7rOKgfakNPP3krxXf3ELTcEN3CHUFA71VS6tshJIdn2l
	 vHKaOKEpLZc/w==
Date: Fri, 30 Aug 2024 00:52:48 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	kernel-team@meta.com
Subject: [PATCH 2/2 sched_ext/for-6.12] sched_ext: Use ktime_get_ns() instead
 of rq_clock_task() in touch_core_sched()
Message-ID: <ZtGkgCEkgNLzjxUC@slm.duckdns.org>
References: <ZtGkPKgoE5BeI7fN@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtGkPKgoE5BeI7fN@slm.duckdns.org>

Since sched_ext: Unpin and repin rq lock from balance_scx(), sched_ext's
balance path terminates rq_pin in the outermost function. This is simpler
and in line with what other balance functions are doing but it loses control
over rq->clock_update_flags which makes assert_clock_udpated() trigger if
other CPUs pins the rq lock.

The only place this matters is touch_core_sched() which uses the timestamp
to order tasks from sibling rq's. For now, switch to ktime_get_ns(). Later,
it'd be better to use per-core dispatch sequence number.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 3cf78c5d01d6 ("sched_ext: Unpin and repin rq lock from balance_scx()")
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/ext.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1453,13 +1453,20 @@ static void schedule_deferred(struct rq
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
+	 * TODO: ktime_get_ns() is used because rq_clock_task() can't be used as
+	 * SCX balance path doesn't pin the rq. As this is used to determine
+	 * ordering between tasks of sibling CPUs, it'd be better to use
+	 * per-core dispatch sequence instead.
 	 */
 	if (!sched_core_disabled())
-		p->scx.core_sched_at = rq_clock_task(rq);
+		p->scx.core_sched_at = ktime_get_ns();
 #endif
 }
 
@@ -1476,7 +1483,6 @@ static void touch_core_sched(struct rq *
 static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
 {
 	lockdep_assert_rq_held(rq);
-	assert_clock_updated(rq);
 
 #ifdef CONFIG_SCHED_CORE
 	if (SCX_HAS_OP(core_sched_before))

