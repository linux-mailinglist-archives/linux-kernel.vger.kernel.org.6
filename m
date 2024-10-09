Return-Path: <linux-kernel+bounces-356682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7ED996533
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE6E1F26061
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C735D18FC8F;
	Wed,  9 Oct 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJlB3ykK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546F2188929
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465651; cv=none; b=RnIgdWXpNv3dTx1KQz54EyDvemlLeRCr9oH1HzDYqdxgiZzSrrdKpxobh6JHWNU173QZzOZkFXeqTTfY0VUH0EdTArHteNjRI7SW1Y10O/MRztww27pG2ZWwH1N3VzHsTPytelJdHCapSagjf03t6NnRMByBlhm7SH0OuyXXVZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465651; c=relaxed/simple;
	bh=Pd3SHnCEE8moULvhFWXTFLWNeS6Qs4kOTEaFTwtkVqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ks2B67W0sHbpc97mFcoRZjj5Xx35C5yqRouGBeb4jtErsfwvsk82on13anwzJV2vaiD0csz17Ham070Fh/VxpTS4cfjmiKJHkwa6osorc1ztAZ1KWc+yv7npRY4830aiF6rKTiguIADh2B+Q7mt1oMs5Gb9NiUDxtuCfh2VY6+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJlB3ykK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728465649; x=1760001649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pd3SHnCEE8moULvhFWXTFLWNeS6Qs4kOTEaFTwtkVqQ=;
  b=FJlB3ykKcIVQ+n7vQpUPvCmI1LMydh6OXkkuSAlS/ZD38CW651EhgczD
   fDRMTlRfxVpz78tGSAF63bM09pWhfPJrZqNc3oCA1PcpnZd7AKNA/dV1Z
   QuebQ4H4YfpENxpqsWYplcdIG70GoiX/PiU1Sllp+KUo3psVXk3oeqhns
   2MO1ouQRK4mlXJYf0N8wkNfETEG0/IKh4Qy8Or+dJ4v2E0lZ3G7zSwKaf
   VbjvgY5MEUgxqu7jBHmFcf6ueFt5sTBGr23SbL83xqv3gpbH8cvqEyYxj
   9H87qn/bnHoMCjeusIwnKDWxxtIH2iQCYnf96RKnRTqCysXwZBeqq7ocN
   A==;
X-CSE-ConnectionGUID: VX7mL/GJReGCrHiuGKSqMA==
X-CSE-MsgGUID: j0pUF1yjSnyio+ucuiEtyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27911560"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="27911560"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:20:43 -0700
X-CSE-ConnectionGUID: M3tE0CP0Rbm7CoBNBsufWg==
X-CSE-MsgGUID: qnSrorKTRh+L3b2pZjyoOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76625385"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO fedora..) ([10.245.245.243])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:20:40 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Maarten Lankhorst <maarten@lankhorst.se>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] locking/ww_mutex: Adjust to lockdep nest_lock requirements
Date: Wed,  9 Oct 2024 11:20:31 +0200
Message-ID: <20241009092031.6356-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When using mutex_acquire_nest() with a nest_lock, lockdep refcounts the
number of acquired lockdep_maps of mutexes of the same class, and also
keeps a pointer to the first acquired lockdep_map of a class. That pointer
is then used for various comparison-, printing- and checking purposes,
but there is no mechanism to actively ensure that lockdep_map stays in
memory. Instead, a warning is printed if the lockdep_map is freed and
there are still held locks of the same lock class, even if the lockdep_map
itself has been released.

In the context of WW/WD transactions that means that if a user unlocks
and frees a ww_mutex from within an ongoing ww transaction, and that
mutex happens to be the first ww_mutex grabbed in the transaction,
such a warning is printed and there might be a risk of a UAF.

Note that this is only problem when lockdep is enabled and affects only
dereferences of struct lockdep_map.

Adjust to this by adding a fake lockdep_map to the acquired context and
make sure it is the first acquired lockdep map of the associated
ww_mutex class. Then hold it for the duration of the WW/WD transaction.

This has the side effect that trying to lock a ww mutex *without* a
ww_acquire_context but where a such context has been acquire, we'd see
a lockdep splat. The test-ww_mutex.c selftest attempts to do that, so
modify that particular test to not acquire a ww_acquire_context if it
is not going to be used.

v2:
- Lower the number of locks in the test-ww_mutex
  stress(STRESS_ALL) test to accommodate the dummy lock
  introduced in this patch without overflowing lockdep held lock
  references.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Maarten Lankhorst <maarten@lankhorst.se>
Cc: Christian König <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 include/linux/ww_mutex.h       | 14 ++++++++++++++
 kernel/locking/test-ww_mutex.c |  8 +++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index bb763085479a..a401a2f31a77 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -65,6 +65,16 @@ struct ww_acquire_ctx {
 #endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
+	/**
+	 * @first_lock_dep_map: fake lockdep_map for first locked ww_mutex.
+	 *
+	 * lockdep requires the lockdep_map for the first locked ww_mutex
+	 * in a ww transaction to remain in memory until all ww_mutexes of
+	 * the transaction have been unlocked. Ensure this by keeping a
+	 * fake locked ww_mutex lockdep map between ww_acquire_init() and
+	 * ww_acquire_fini().
+	 */
+	struct lockdep_map first_lock_dep_map;
 #endif
 #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
 	unsigned int deadlock_inject_interval;
@@ -146,7 +156,10 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
 	debug_check_no_locks_freed((void *)ctx, sizeof(*ctx));
 	lockdep_init_map(&ctx->dep_map, ww_class->acquire_name,
 			 &ww_class->acquire_key, 0);
+	lockdep_init_map(&ctx->first_lock_dep_map, ww_class->mutex_name,
+			 &ww_class->mutex_key, 0);
 	mutex_acquire(&ctx->dep_map, 0, 0, _RET_IP_);
+	mutex_acquire_nest(&ctx->first_lock_dep_map, 0, 0, &ctx->dep_map, _RET_IP_);
 #endif
 #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
 	ctx->deadlock_inject_interval = 1;
@@ -185,6 +198,7 @@ static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
 static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
+	mutex_release(&ctx->first_lock_dep_map, _THIS_IP_);
 	mutex_release(&ctx->dep_map, _THIS_IP_);
 #endif
 #ifdef DEBUG_WW_MUTEXES
diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 10a5736a21c2..5d58b2c0ef98 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -62,7 +62,8 @@ static int __test_mutex(unsigned int flags)
 	int ret;
 
 	ww_mutex_init(&mtx.mutex, &ww_class);
-	ww_acquire_init(&ctx, &ww_class);
+	if (flags & TEST_MTX_CTX)
+		ww_acquire_init(&ctx, &ww_class);
 
 	INIT_WORK_ONSTACK(&mtx.work, test_mutex_work);
 	init_completion(&mtx.ready);
@@ -90,7 +91,8 @@ static int __test_mutex(unsigned int flags)
 		ret = wait_for_completion_timeout(&mtx.done, TIMEOUT);
 	}
 	ww_mutex_unlock(&mtx.mutex);
-	ww_acquire_fini(&ctx);
+	if (flags & TEST_MTX_CTX)
+		ww_acquire_fini(&ctx);
 
 	if (ret) {
 		pr_err("%s(flags=%x): mutual exclusion failure\n",
@@ -679,7 +681,7 @@ static int __init test_ww_mutex_init(void)
 	if (ret)
 		return ret;
 
-	ret = stress(2047, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
+	ret = stress(2046, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
 	if (ret)
 		return ret;
 
-- 
2.46.0


