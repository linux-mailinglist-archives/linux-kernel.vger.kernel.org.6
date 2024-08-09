Return-Path: <linux-kernel+bounces-281606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 761BD94D8BA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D70DBB23BA2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E05416D9AB;
	Fri,  9 Aug 2024 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTF1t9l2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAAE16C683
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723242469; cv=none; b=VNz9KXA7Av+7uwv/eGujI5DT0lDrNx+59Ws/Wjs5BZgK4gcqqxQsBqSle0hiJapLzg3g9vITeI+mn8sY+enIWNn2c5Bq5bvcH2z9fphyQxI9/TNwZ3aP1OKn6418S5KFbG6vly95Yg4Kf/6g8WyaEQcV8e/vP8n4PdpLaj+ymTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723242469; c=relaxed/simple;
	bh=vBcSLoAHnTlPr0DGOVnoBXIz4sPiLaWiqyEvFFFmiIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=efUScLReSRqYr66QjEDOsfs6vRZBS/kP5R6A2Bk0ss/m+EQorqko62fhNDfo6m2d2fJB+XAxkvhHpi674VFRzZ7QoFOWKONNLQmNbErFnJk7OSLxfPDM+L4BWi3tollpP8WGWGPa+aKLU1cQ5Nah7/oohd9LJJC2yOngHEfY6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jTF1t9l2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723242468; x=1754778468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vBcSLoAHnTlPr0DGOVnoBXIz4sPiLaWiqyEvFFFmiIY=;
  b=jTF1t9l2LRbvMCQxSFqmdJ97nGZEhiX2p8JVQDsTUSvQ97iyNE9bzEOO
   VIWc2r690+c2BjCiasaajQ7zhjkNgSlC34Ctymdkg4iimQpJRgEZAJBl9
   LkGM4yrBUk8qYrzn/1qnq9/9qBggp0B2jSAd3sLgBsqBd/sXtQf6xkmMs
   EfOR1wfiVSscGkP5E22JMcmD/Hoc/rj4LzCn1URkZzDEQyP7ML/KeDYFZ
   FvRMIM6ew6oENaej/JpTBZOYiD7pVs1LiY5aZpvbAijejJZLfYdOmIOz8
   WnEsGBnfi429Dj9JFRqEofXC4JG6ZLaMl8HaGSujpkp38jLxgo+z/3gmR
   Q==;
X-CSE-ConnectionGUID: Z80eygzRSl6bgZKLJMqfsQ==
X-CSE-MsgGUID: E6WhIum/QvCoYcmR4YnVnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="25229653"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="25229653"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 15:27:43 -0700
X-CSE-ConnectionGUID: qsRtHUBhTtW4Cm8kiOMtUA==
X-CSE-MsgGUID: GHxpiMNHT+OIgHLHQyakJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="62641784"
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
Subject: [PATCH v3 3/5] workqueue: Add interface for user-defined workqueue lockdep map
Date: Fri,  9 Aug 2024 15:28:25 -0700
Message-Id: <20240809222827.3211998-4-matthew.brost@intel.com>
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

Add an interface for a user-defined workqueue lockdep map, which is
helpful when multiple workqueues are created for the same purpose. This
also helps avoid leaking lockdep maps on each workqueue creation.

v2:
 - Add alloc_workqueue_lockdep_map (Tejun)
v3:
 - Drop __WQ_USER_OWNED_LOCKDEP (Tejun)
 - static inline alloc_ordered_workqueue_lockdep_map (Tejun)

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 include/linux/workqueue.h | 52 +++++++++++++++++++++++++++++++++++++++
 kernel/workqueue.c        | 28 +++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 4eb8f9563136..8ccbf510880b 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -507,6 +507,58 @@ void workqueue_softirq_dead(unsigned int cpu);
 __printf(1, 4) struct workqueue_struct *
 alloc_workqueue(const char *fmt, unsigned int flags, int max_active, ...);
 
+#ifdef CONFIG_LOCKDEP
+/**
+ * alloc_workqueue_lockdep_map - allocate a workqueue with user-defined lockdep_map
+ * @fmt: printf format for the name of the workqueue
+ * @flags: WQ_* flags
+ * @max_active: max in-flight work items, 0 for default
+ * @lockdep_map: user-defined lockdep_map
+ * @...: args for @fmt
+ *
+ * Same as alloc_workqueue but with the a user-define lockdep_map. Useful for
+ * workqueues created with the same purpose and to avoid leaking a lockdep_map
+ * on each workqueue creation.
+ *
+ * RETURNS:
+ * Pointer to the allocated workqueue on success, %NULL on failure.
+ */
+__printf(1, 5) struct workqueue_struct *
+alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
+			    struct lockdep_map *lockdep_map, ...);
+
+/**
+ * alloc_ordered_workqueue_lockdep_map - allocate an ordered workqueue with
+ * user-defined lockdep_map
+ *
+ * @fmt: printf format for the name of the workqueue
+ * @flags: WQ_* flags (only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningful)
+ * @lockdep_map: user-defined lockdep_map
+ * @args: args for @fmt
+ *
+ * Same as alloc_ordered_workqueue but with the a user-define lockdep_map.
+ * Useful for workqueues created with the same purpose and to avoid leaking a
+ * lockdep_map on each workqueue creation.
+ *
+ * RETURNS:
+ * Pointer to the allocated workqueue on success, %NULL on failure.
+ */
+__printf(1, 4) static inline struct workqueue_struct *
+alloc_ordered_workqueue_lockdep_map(const char *fmt, unsigned int flags,
+				    struct lockdep_map *lockdep_map, ...)
+{
+	struct workqueue_struct *wq;
+	va_list args;
+
+	va_start(args, lockdep_map);
+	wq = alloc_workqueue_lockdep_map(fmt, WQ_UNBOUND | __WQ_ORDERED | flags,
+					 1, lockdep_map, args);
+	va_end(args);
+
+	return wq;
+}
+#endif
+
 /**
  * alloc_ordered_workqueue - allocate an ordered workqueue
  * @fmt: printf format for the name of the workqueue
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 24df85589dc0..f4b50a995e99 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4775,11 +4775,17 @@ static void wq_init_lockdep(struct workqueue_struct *wq)
 
 static void wq_unregister_lockdep(struct workqueue_struct *wq)
 {
+	if (wq->lockdep_map != &wq->__lockdep_map)
+		return;
+
 	lockdep_unregister_key(&wq->key);
 }
 
 static void wq_free_lockdep(struct workqueue_struct *wq)
 {
+	if (wq->lockdep_map != &wq->__lockdep_map)
+		return;
+
 	if (wq->lock_name != wq->name)
 		kfree(wq->lock_name);
 }
@@ -5756,6 +5762,28 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 }
 EXPORT_SYMBOL_GPL(alloc_workqueue);
 
+#ifdef CONFIG_LOCKDEP
+__printf(1, 5)
+struct workqueue_struct *
+alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags,
+			    int max_active, struct lockdep_map *lockdep_map, ...)
+{
+	struct workqueue_struct *wq;
+	va_list args;
+
+	va_start(args, lockdep_map);
+	wq = __alloc_workqueue(fmt, flags, max_active, args);
+	va_end(args);
+	if (!wq)
+		return NULL;
+
+	wq->lockdep_map = lockdep_map;
+
+	return wq;
+}
+EXPORT_SYMBOL_GPL(alloc_workqueue_lockdep_map);
+#endif
+
 static bool pwq_busy(struct pool_workqueue *pwq)
 {
 	int i;
-- 
2.34.1


