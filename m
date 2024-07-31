Return-Path: <linux-kernel+bounces-268371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A34899423D4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E2B1F24FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF40946F;
	Wed, 31 Jul 2024 00:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcKRlcs6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC04431
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722385834; cv=none; b=i4WOIvA6jsUdeIiR8lpu6cyM/vyHIF8pmPHZ+mPMHhCFmGwUa/mG1xxC4uG99LFMvXgc7ly/ptCahj1LrN7HFzpsl83pLyA4IGpy+n8dcsrUo8BC7Dupeb7UjNRv0y5+VSCk42uxZStrHnqSPC4vRLFNYQNFh2IW4DEa+cHbIP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722385834; c=relaxed/simple;
	bh=9VB0D6qtSFvrmgUitG4lhcQZt2t0l9f3P97TzqnDp48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FBVFMFCaKlJgm2BwtULI8xZrfjHsoXDhvqHmreG96qokjz91I59J3wF+2Wub6O6s9TfZoCzkCarIKB67zWjs83Bn8JCA4zkHMDiXojE4egqMU4J3yW8m6dFZwYN/us5VcqTJqgERtwZMm1FosTZQk4Y5ivAn/JCu+gWT0djqe0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcKRlcs6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722385833; x=1753921833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9VB0D6qtSFvrmgUitG4lhcQZt2t0l9f3P97TzqnDp48=;
  b=TcKRlcs6ssD0GsX2/AirsAYZnp8lyx/EWNmbxkTyTiQFy3Vcrr1g6d71
   Vv4AKamw2iwLoSz9wIJ7tRtMOTIOQ0wKHg2utU6mYPDx9djpM+rSArLnz
   4YZTfwKN+TDr/SLzWJjS1q/szR6dTe0hf779C8njnTuqToD+Wokw6FO97
   y4BFkl9TD7EB6pqcyxGqg4i0YqB3DccvjGBKQE9plX/db+cvAVa/uQew/
   0XvfrXM8vhogCEhx4tUYZonHZ83RztXz2ha5VQNpZZEe99pBSHsKp2HfA
   ZWUY1b2gxKfzYLXIhwfEAWZ9EhUb+K5DYnVJHCGpL8srCPbdFe/M6hI6L
   g==;
X-CSE-ConnectionGUID: CbMv86vkTtWmn/taEh8/UA==
X-CSE-MsgGUID: kLppy/odR4u0A5U4Xqn9Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="23156081"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="23156081"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 17:30:31 -0700
X-CSE-ConnectionGUID: PcAjtUvuSueJEW9URfTEwQ==
X-CSE-MsgGUID: zkV+Pj5MRvqcGWfBoTaUkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="77781798"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 17:30:30 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	christian.koenig@amd.com,
	ltuikov89@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH v2 2/5] workqueue: Change workqueue lockdep map to pointer
Date: Tue, 30 Jul 2024 17:31:16 -0700
Message-Id: <20240731003119.2422940-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731003119.2422940-1-matthew.brost@intel.com>
References: <20240731003119.2422940-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Will help enable user-defined lockdep maps for workqueues.

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 kernel/workqueue.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c9bdd6a23a2b..b3fa4d044f69 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -366,7 +366,8 @@ struct workqueue_struct {
 #ifdef CONFIG_LOCKDEP
 	char			*lock_name;
 	struct lock_class_key	key;
-	struct lockdep_map	lockdep_map;
+	struct lockdep_map	__lockdep_map;
+	struct lockdep_map	*lockdep_map;
 #endif
 	char			name[WQ_NAME_LEN]; /* I: workqueue name */
 
@@ -3220,7 +3221,7 @@ __acquires(&pool->lock)
 	lockdep_start_depth = lockdep_depth(current);
 	/* see drain_dead_softirq_workfn() */
 	if (!bh_draining)
-		lock_map_acquire(&pwq->wq->lockdep_map);
+		lock_map_acquire(pwq->wq->lockdep_map);
 	lock_map_acquire(&lockdep_map);
 	/*
 	 * Strictly speaking we should mark the invariant state without holding
@@ -3254,7 +3255,7 @@ __acquires(&pool->lock)
 	pwq->stats[PWQ_STAT_COMPLETED]++;
 	lock_map_release(&lockdep_map);
 	if (!bh_draining)
-		lock_map_release(&pwq->wq->lockdep_map);
+		lock_map_release(pwq->wq->lockdep_map);
 
 	if (unlikely((worker->task && in_atomic()) ||
 		     lockdep_depth(current) != lockdep_start_depth ||
@@ -3892,8 +3893,8 @@ static void touch_wq_lockdep_map(struct workqueue_struct *wq)
 	if (wq->flags & WQ_BH)
 		local_bh_disable();
 
-	lock_map_acquire(&wq->lockdep_map);
-	lock_map_release(&wq->lockdep_map);
+	lock_map_acquire(wq->lockdep_map);
+	lock_map_release(wq->lockdep_map);
 
 	if (wq->flags & WQ_BH)
 		local_bh_enable();
@@ -3927,7 +3928,7 @@ void __flush_workqueue(struct workqueue_struct *wq)
 	struct wq_flusher this_flusher = {
 		.list = LIST_HEAD_INIT(this_flusher.list),
 		.flush_color = -1,
-		.done = COMPLETION_INITIALIZER_ONSTACK_MAP(this_flusher.done, wq->lockdep_map),
+		.done = COMPLETION_INITIALIZER_ONSTACK_MAP(this_flusher.done, (*wq->lockdep_map)),
 	};
 	int next_color;
 
@@ -4788,7 +4789,8 @@ static void wq_init_lockdep(struct workqueue_struct *wq)
 		lock_name = wq->name;
 
 	wq->lock_name = lock_name;
-	lockdep_init_map(&wq->lockdep_map, lock_name, &wq->key, 0);
+	wq->lockdep_map = &wq->__lockdep_map;
+	lockdep_init_map(wq->lockdep_map, lock_name, &wq->key, 0);
 }
 
 static void wq_unregister_lockdep(struct workqueue_struct *wq)
-- 
2.34.1


