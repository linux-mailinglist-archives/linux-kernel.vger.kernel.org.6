Return-Path: <linux-kernel+bounces-531808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC67EA44543
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D539188E7C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7125117B500;
	Tue, 25 Feb 2025 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNdJ35RA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233D1624ED
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499344; cv=none; b=tzgZPG9e82RQTejQZ2sE4nmwly4N9GW6j2y+kzNYMXoFpucfuXxkaMCO3DVhTei5UD3ySf96tOGD/+0OGg0dbtCKgLMOG7EP0TPVZWYgU++TD9M+QCl1tsBrUsnhgSLf9twWhiqISf6292vvAxShl5CskPSeay1j0MQJzv7+0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499344; c=relaxed/simple;
	bh=jBX7JjJtGYlRqtaYcdsSwMXApNfuBBtxd8zXzYZwW6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TYYs2LpNTeUcWE2i1v7RMHU+fK7k45w8CdYP73g+ZPOq0HIyOlwk1T6M8mDKRzxMmGKXeunylzvsGnJGXh3uDdyWRj0z/mhoy4d32ZzoJhUPT4oDOV/5i2YcukBUeHANDQgQ2G+tIg+dmRYEGB5T20oSSLGlFRKZnnI8cP7bDLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNdJ35RA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F2AC4CEDD;
	Tue, 25 Feb 2025 16:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740499344;
	bh=jBX7JjJtGYlRqtaYcdsSwMXApNfuBBtxd8zXzYZwW6Q=;
	h=Date:From:To:Cc:Subject:From;
	b=MNdJ35RAeZ2UPj96tI17pQUCXuKhk366eq4YgbYb0AE5e3YIDqK+tjJn9ciqUwCzF
	 wMSk0WmkDQB4Na9B794TTOFLpbD4Y9shNG65qJNEwT/Ef0FWalBdvCdqFCRRr1L/9O
	 Uz6/WODLScilfwYyDrod5SRNqn5n/3gzVIIMk1/UND0YWPptgvLXd8gMbj0eyh7hN+
	 orfS8Sc1gCyNwFLE4Z3p8ddvAnFV8vPfJIdfay9olvKDjMqJA8aon6OrthXCJAsYUu
	 AjPa6iR7yL3NgxyEsXJ6IKXiil1eTDB7t3eK+mDL6WV3T9uc4fxzTPAZkESnR+ZJtI
	 UqWdUWpbeU2Tw==
Date: Tue, 25 Feb 2025 06:02:23 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: [PATCH sched_ext/for-6.14-fixes] sched_ext: Fix pick_task_scx()
 picking non-queued tasks when it's called without balance()
Message-ID: <Z73pjysZYNEIbkiy@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

a6250aa251ea ("sched_ext: Handle cases where pick_task_scx() is called
without preceding balance_scx()") added a workaround to handle the cases
where pick_task_scx() is called without prececing balance_scx() which is due
to a fair class bug where pick_taks_fair() may return NULL after a true
return from balance_fair().

The workaround detects when pick_task_scx() is called without preceding
balance_scx() and emulates SCX_RQ_BAL_KEEP and triggers kicking to avoid
stalling. Unfortunately, the workaround code was testing whether @prev was
on SCX to decide whether to keep the task running. This is incorrect as the
task may be on SCX but no longer runnable.

This could lead to a non-runnable task to be returned from pick_task_scx()
which cause interesting confusions and failures. e.g. A common failure mode
is the task ending up with (!on_rq && on_cpu) state which can cause
potential wakers to busy loop, which can easily lead to deadlocks.

Fix it by testing whether @prev has SCX_TASK_QUEUED set. This makes
$prev_on_scx only used in one place. Open code the usage and improve the
comment while at it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Pat Cody <patcody@meta.com>
Fixes: a6250aa251ea ("sched_ext: Handle cases where pick_task_scx() is called without preceding balance_scx()")
Cc: stable@vger.kernel.org # v6.12+
---
 kernel/sched/ext.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5a81d9a1e31f..0f1da199cfc7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3117,7 +3117,6 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 {
 	struct task_struct *prev = rq->curr;
 	struct task_struct *p;
-	bool prev_on_scx = prev->sched_class == &ext_sched_class;
 	bool keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
 	bool kick_idle = false;
 
@@ -3137,14 +3136,18 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 	 * if pick_task_scx() is called without preceding balance_scx().
 	 */
 	if (unlikely(rq->scx.flags & SCX_RQ_BAL_PENDING)) {
-		if (prev_on_scx) {
+		if (prev->scx.flags & SCX_TASK_QUEUED) {
 			keep_prev = true;
 		} else {
 			keep_prev = false;
 			kick_idle = true;
 		}
-	} else if (unlikely(keep_prev && !prev_on_scx)) {
-		/* only allowed during transitions */
+	} else if (unlikely(keep_prev &&
+			    prev->sched_class != &ext_sched_class)) {
+		/*
+		 * Can happen while enabling as SCX_RQ_BAL_PENDING assertion is
+		 * conditional on scx_enabled() and may have been skipped.
+		 */
 		WARN_ON_ONCE(scx_ops_enable_state() == SCX_OPS_ENABLED);
 		keep_prev = false;
 	}

