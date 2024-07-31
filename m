Return-Path: <linux-kernel+bounces-268372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0D49423D5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DD41F24F87
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E926DDBE;
	Wed, 31 Jul 2024 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jdb3KJbv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30494C80
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722385835; cv=none; b=a88wtivkwt3ZU5wjpVthRt8dWt/Y3BzMuF31ROoonSFkhmEiv61g/yEPBocveRI6z/+bMhcn+qlIRE4IJEhPKAS9IkRvckNanDMAJNx5wHpPPXbCrTu7fo5FTYFIGYKXQp+Ij7RoYs56pdJsLtZPArn8zhPjp4H0SGqfrq1cVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722385835; c=relaxed/simple;
	bh=6iC7cqHHEWf0XvOJNVvsLe4YM0JKB2yPfC3YrzQWYqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N7CV4PWNvJXJwPMZm1SEb93sCOis1bsI3g6wFUe6Sy/jBydqMmujy1YCRHsqtL94rZUegT6DQkZJqy5zTukBS/lzN5NEWoPxGxcNwkdSepWrua9ykr/ELInjfvBpD9EoNTojoPcbE9UHdcMFNi0K2nudScOPNxuDoeQ1yAYTIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jdb3KJbv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722385834; x=1753921834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6iC7cqHHEWf0XvOJNVvsLe4YM0JKB2yPfC3YrzQWYqU=;
  b=Jdb3KJbvSViaFST+9wk0YJU7pKdFN9LM311h0GnCB6PmDVJivUxbI2DR
   JFQyMkrI+0E4JDIpAHyj866nQapp0vT+9TSOFVvB+xQWkiL4rDC/h6hij
   WmuGEyMwUv8K+zQ1N+j0wxe493hO8yVG9OZUvFO+JLhQpEVSwEFgEAL/f
   GPyvDQxLB/GvrB6+MIBrXe9YduqlWl6sJXKk4+zCUp+PqpqrdgT59OvpW
   lMPklXdwWU4V5AdQvTJvMvPCC1oSTF311Su8y/zCvN/jThdBBxSisn24S
   0Gur054oAb6dCh7O47LZq1NOYeXfa7IHGvUmdwBWv5JSREkbDCxQmdht4
   w==;
X-CSE-ConnectionGUID: omd0BrHwQH6YsH0a8SZ7cQ==
X-CSE-MsgGUID: owDuSsMoQtmymrQQ260puQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="23156087"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="23156087"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 17:30:31 -0700
X-CSE-ConnectionGUID: U8SOASvxQPis1+P4kIkyhg==
X-CSE-MsgGUID: Y++OagSdRQuU43mO7bkTyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="77781799"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 17:30:31 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	christian.koenig@amd.com,
	ltuikov89@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH v2 3/5] workqueue: Add interface for user-defined workqueue lockdep map
Date: Tue, 30 Jul 2024 17:31:17 -0700
Message-Id: <20240731003119.2422940-4-matthew.brost@intel.com>
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

Add an interface for a user-defined workqueue lockdep map, which is
helpful when multiple workqueues are created for the same purpose. This
also helps avoid leaking lockdep maps on each workqueue creation.

Implement a new internal workqueue flag, __WQ_USER_OWNED_LOCKDEP, to
indicate that the user will set up the workqueue lockdep map using the
new function alloc_workqueue_lockdep_map. Also add helper macro
alloc_ordered_workqueue_lockdep_map.

v2:
 - Add alloc_workqueue_lockdep_map (Tejun)

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 include/linux/workqueue.h | 25 +++++++++++++++++++++++++
 kernel/workqueue.c        | 28 ++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index d9968bfc8eac..1707870ef7c5 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -406,6 +406,7 @@ enum wq_flags {
 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
+	__WQ_USER_OWNED_LOCKDEP	= 1 << 19, /* internal: workqueue has user owned lockdep map */
 
 	/* BH wq only allows the following flags */
 	__WQ_BH_ALLOWS		= WQ_BH | WQ_HIGHPRI,
@@ -507,6 +508,30 @@ void workqueue_softirq_dead(unsigned int cpu);
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
+ * Same as alloc_workqueue but with the a user-defined lockdep_map. Useful for
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
+#define alloc_ordered_workqueue_lockdep_map(fmt, flags, lockdep_map, args...)	\
+	alloc_workqueue_lockdep_map(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, lockdep_map, ##args)
+#endif
+
 /**
  * alloc_ordered_workqueue - allocate an ordered workqueue
  * @fmt: printf format for the name of the workqueue
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b3fa4d044f69..e1361dedbe06 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4795,11 +4795,17 @@ static void wq_init_lockdep(struct workqueue_struct *wq)
 
 static void wq_unregister_lockdep(struct workqueue_struct *wq)
 {
+	if (wq->flags & __WQ_USER_OWNED_LOCKDEP)
+		return;
+
 	lockdep_unregister_key(&wq->key);
 }
 
 static void wq_free_lockdep(struct workqueue_struct *wq)
 {
+	if (wq->flags & __WQ_USER_OWNED_LOCKDEP)
+		return;
+
 	if (wq->lock_name != wq->name)
 		kfree(wq->lock_name);
 }
@@ -5792,6 +5798,28 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
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
+	wq = __alloc_workqueue(fmt, flags | __WQ_USER_OWNED_LOCKDEP, max_active, args);
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


