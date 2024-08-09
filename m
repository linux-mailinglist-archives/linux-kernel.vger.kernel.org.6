Return-Path: <linux-kernel+bounces-281607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B4094D8BB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68BAB23C93
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A175116D9B1;
	Fri,  9 Aug 2024 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghUO1NiO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6295A16C861
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723242469; cv=none; b=ZlXTVqMJMMmyx/5dkkmoTZt9T7tJulotv71GQfWfrF133fR+uudg85CH4gW+7szgtaeJ2m3tvjUvPrTWYACik62d7ICU35KcSA4/GuTVNRhOdDXTB3yrQgVt/vF2okFParAJLOb8U+pdsI6p7MO5Yea6crYcrUmsTSBQNryzBWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723242469; c=relaxed/simple;
	bh=5NsFxeHz5H781GU70fSvGb8d+biJ1SrQI5t3Iz1xhm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eD0FNQ5qVaEvtoFca3gi/Ip6VJQxC/DA3NYdxhKkhOqLvrJSWRxW50+C/afkS57qYACks/hbcaw0rsTz1fHr/gDHcfGdNr+kLq830Tnd1i2jo/vZRQBILZnh6CwQcOwu3/ic9bGP2xkD7b4RNnGO3D4X+jsilDeSpPWyQmSjFkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghUO1NiO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723242468; x=1754778468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5NsFxeHz5H781GU70fSvGb8d+biJ1SrQI5t3Iz1xhm4=;
  b=ghUO1NiOIpXLRchriMO1l2Te5ZK6ROME6qQXItK1jRQo8W9z7XmcSN5I
   P3CKt/YZVAUjkcgIXJDIZHfn7ykqV6mJCIq/0NFpdZSoqym3HNLRJ1lIF
   qjsLVL1z+H1wG2wFyGLXAOrrtHC+kSOkJciRHZ1WkejcObHHHaL3TGKQs
   1A2/gZMsS06fles3OB1DzU4ertDUrXSVBHXEt+hPtsKBAVwfcahXae3r7
   bhRpjalFGs71z3KSCG6MLNYg8BTKIbOmUwMXzuZYAXCWaPyVdt4DXBalh
   obt9KDzIKHlmP0ppm5L2X1D+UpK5ADM0dItbrKRzzPNI+YNhmZ6jySO+o
   A==;
X-CSE-ConnectionGUID: 28QRXm80SDCtjjbK339EsQ==
X-CSE-MsgGUID: V6m187ZbSk6DNP6stEHlDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="25229647"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="25229647"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 15:27:43 -0700
X-CSE-ConnectionGUID: FOR7/2yKRCiAdYThcoZIyA==
X-CSE-MsgGUID: gVoIWKkETiKThh1mDYVCPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="62641783"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 15:27:43 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	christian.koenig@amd.com,
	ltuikov89@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH v3 2/5] workqueue: Change workqueue lockdep map to pointer
Date: Fri,  9 Aug 2024 15:28:24 -0700
Message-Id: <20240809222827.3211998-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809222827.3211998-1-matthew.brost@intel.com>
References: <20240809222827.3211998-1-matthew.brost@intel.com>
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
index 90a98c9b0ac6..24df85589dc0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -364,7 +364,8 @@ struct workqueue_struct {
 #ifdef CONFIG_LOCKDEP
 	char			*lock_name;
 	struct lock_class_key	key;
-	struct lockdep_map	lockdep_map;
+	struct lockdep_map	__lockdep_map;
+	struct lockdep_map	*lockdep_map;
 #endif
 	char			name[WQ_NAME_LEN]; /* I: workqueue name */
 
@@ -3203,7 +3204,7 @@ __acquires(&pool->lock)
 	lockdep_start_depth = lockdep_depth(current);
 	/* see drain_dead_softirq_workfn() */
 	if (!bh_draining)
-		lock_map_acquire(&pwq->wq->lockdep_map);
+		lock_map_acquire(pwq->wq->lockdep_map);
 	lock_map_acquire(&lockdep_map);
 	/*
 	 * Strictly speaking we should mark the invariant state without holding
@@ -3237,7 +3238,7 @@ __acquires(&pool->lock)
 	pwq->stats[PWQ_STAT_COMPLETED]++;
 	lock_map_release(&lockdep_map);
 	if (!bh_draining)
-		lock_map_release(&pwq->wq->lockdep_map);
+		lock_map_release(pwq->wq->lockdep_map);
 
 	if (unlikely((worker->task && in_atomic()) ||
 		     lockdep_depth(current) != lockdep_start_depth ||
@@ -3873,8 +3874,8 @@ static void touch_wq_lockdep_map(struct workqueue_struct *wq)
 	if (wq->flags & WQ_BH)
 		local_bh_disable();
 
-	lock_map_acquire(&wq->lockdep_map);
-	lock_map_release(&wq->lockdep_map);
+	lock_map_acquire(wq->lockdep_map);
+	lock_map_release(wq->lockdep_map);
 
 	if (wq->flags & WQ_BH)
 		local_bh_enable();
@@ -3908,7 +3909,7 @@ void __flush_workqueue(struct workqueue_struct *wq)
 	struct wq_flusher this_flusher = {
 		.list = LIST_HEAD_INIT(this_flusher.list),
 		.flush_color = -1,
-		.done = COMPLETION_INITIALIZER_ONSTACK_MAP(this_flusher.done, wq->lockdep_map),
+		.done = COMPLETION_INITIALIZER_ONSTACK_MAP(this_flusher.done, (*wq->lockdep_map)),
 	};
 	int next_color;
 
@@ -4768,7 +4769,8 @@ static void wq_init_lockdep(struct workqueue_struct *wq)
 		lock_name = wq->name;
 
 	wq->lock_name = lock_name;
-	lockdep_init_map(&wq->lockdep_map, lock_name, &wq->key, 0);
+	wq->lockdep_map = &wq->__lockdep_map;
+	lockdep_init_map(wq->lockdep_map, lock_name, &wq->key, 0);
 }
 
 static void wq_unregister_lockdep(struct workqueue_struct *wq)
-- 
2.34.1


