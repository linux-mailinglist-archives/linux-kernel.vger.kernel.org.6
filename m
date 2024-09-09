Return-Path: <linux-kernel+bounces-322207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 001F69725CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 01:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDF01C235DD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB3018E378;
	Mon,  9 Sep 2024 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj/kBj/b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B318E05D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925246; cv=none; b=iqMUUw90DRzRaG6TIpAgGJ1ZAA5f5jnA3VJCj30KjcwnWrKk6j8gsMPmhyKvZoGH++M+jA3ptodlopO77KHTsfVfTWM7hKXXGpqV0JnoQ1J7tQ8pxSSKp/HW3U9VB5DO/4osKoxBi4ReRJA7mz/VYOe62hIMEZozMHy9+ojZ9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925246; c=relaxed/simple;
	bh=liajBIN43Td5fNi9I3NHwEJRLWnyOrvRlOOuuR90kS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fgHdGCx6p3eKD256d8gjB1zD3+LEQDuKMnyoWv/8v8y+ZYhLx3J6+vYhZvlw0VwGZlfAqXavzBF8tHigFdCXu77Wl6Pf28g6/kjLcOxHDAgeGz9p31tCXXb9DitZCdRA5Xk+yph5rkNhs5E+uIlO8yeFVdiM2i4sioIcB6uEL/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj/kBj/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EB5C4CEC5;
	Mon,  9 Sep 2024 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725925246;
	bh=liajBIN43Td5fNi9I3NHwEJRLWnyOrvRlOOuuR90kS8=;
	h=Date:From:To:Cc:Subject:From;
	b=dj/kBj/bWBg1lcu0cYFRPe3T2sBGtbskU3lyUruovtULX/YF3t+l8xl41L73fHcf8
	 +mlrRtOrWqcXJ1sum+7vVGN3K9JMb0n1TkNA3vst4WP7GAcrgz43B4IwH5FYI4Mh0T
	 qB3PH8qQoM8pq/AX/ob2e1eHJlxhsVm6Q5PNth9++n2aL/xA906DPnvgYxgI7/CY56
	 wd6H/So8Mjl6dcP3t+pP8l1yjXGMvcRwBp90cs1dDgiCWocJ42FWnRbthyAs+KMbqP
	 O734Wt91fXqeCd4lLh2wrnigpvxpcl8jGEO+276/dHxJMCBD/IJdGEttUH+5XBLTR9
	 6pUQxtWZApEoQ==
Date: Mon, 9 Sep 2024 13:40:44 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	hodges.daniel.scott@gmail.com, multics69@gmail.com,
	andrea.righi@linux.dev, schatzberg.dan@gmail.com
Subject: [PATCH sched_ext/for-6.12] sched_ext: Don't trigger
 ops.quiescent/runnable() on migrations
Message-ID: <Zt-HfBC0Q-DcUjHm@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A task moving across CPUs should not trigger quiescent/runnable task state
events as the task is staying runnable the whole time and just stopping and
then starting on different CPUs. Suppress quiescent/runnable task state
events if task_on_rq_migrating().

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: David Vernet <void@manifault.com>
Cc: Daniel Hodges <hodges.daniel.scott@gmail.com>
Cc: Changwoo Min <multics69@gmail.com>
Cc: Andrea Righi <andrea.righi@linux.dev>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 kernel/sched/ext.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2050,7 +2050,7 @@ static void enqueue_task_scx(struct rq *
 	rq->scx.nr_running++;
 	add_nr_running(rq, 1);
 
-	if (SCX_HAS_OP(runnable))
+	if (SCX_HAS_OP(runnable) && !task_on_rq_migrating(p))
 		SCX_CALL_OP_TASK(SCX_KF_REST, runnable, p, enq_flags);
 
 	if (enq_flags & SCX_ENQ_WAKEUP)
@@ -2134,7 +2134,7 @@ static bool dequeue_task_scx(struct rq *
 		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, false);
 	}
 
-	if (SCX_HAS_OP(quiescent))
+	if (SCX_HAS_OP(quiescent) && !task_on_rq_migrating(p))
 		SCX_CALL_OP_TASK(SCX_KF_REST, quiescent, p, deq_flags);
 
 	if (deq_flags & SCX_DEQ_SLEEP)


