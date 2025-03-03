Return-Path: <linux-kernel+bounces-541196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4B0A4B9D8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B9716D48B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877B61F4264;
	Mon,  3 Mar 2025 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVzyrUbo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D241F37CE;
	Mon,  3 Mar 2025 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991665; cv=none; b=c+Za4nr4W1Q1E4MIH3TxYOOprz6VeF3Kv7O8f9WoPegcKatb54a5/+/1eoCmwpQ+GuRj5LGFJ1XilFMdem4O5H82CEoeWeMu4uuxghSY6+ZDsUvVvZMlDt4bIDP90ysGgx+uoyfxKCE80fu6lwSSW4wWG5yjLYptHPMLzyhTwuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991665; c=relaxed/simple;
	bh=wnAZgzZysvwzP6ose3BLkVVzZLfpVRnkxBx4ywaxaog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZiSYjM47jORxAJuMG6/+cIqsLyoAb6HZZwMCU/8Ois62tPf/2ueBasVxUgc9hwHuUI/NfJ8Lv+XOmMovid31sIXFz5vMnAVHJ+9Uc06SkTx824A0r0mqOJzbUej82GWQ3DOAjC11u4XTENNqOg1LJzZixKpfWdZOQP6vP7AGGpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVzyrUbo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740991663; x=1772527663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wnAZgzZysvwzP6ose3BLkVVzZLfpVRnkxBx4ywaxaog=;
  b=EVzyrUboROO9DKUiwWzPIsHdQab5v4rlppgYOvtZOlNH+zqPZuEoI60u
   ceydfJzysWLPEtZy0p8Wuawc/IVgg39ZPOYmNmXaXuQ+iG5yNY8LejgIr
   w7rFViF6jKNWlQmvBzLMy4rptYpqQYnN1Pg6WLQo/s2AnX8Kp6sE3MrlS
   rHE6Wc0W/gIyIMA4RfeKg72/HSsZezG4EGxfmUIe0o0raez9LpJv201eB
   HQDnIF6YV2BSHpeHYvjpkZbPpJo1kcNpsi8dfBb3/TyHHsvYALuIqSOLQ
   VmIoBR/5X8A+N5pNw+vf0oWxF11hGlzV+qwE8LZOdjQxp1y5wbBKKYU7F
   g==;
X-CSE-ConnectionGUID: UR1i6DFpT7mViUX9feuMhQ==
X-CSE-MsgGUID: dwTMYazfRFawzyrM7ITm5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="42112004"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="42112004"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 00:47:39 -0800
X-CSE-ConnectionGUID: ySiWdTsSQJGG+Ckiz8Ho7g==
X-CSE-MsgGUID: b9EPa7AyS3WyQO54PH0Rmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118426825"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa010.fm.intel.com with ESMTP; 03 Mar 2025 00:47:37 -0800
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	ying.huang@linux.alibaba.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v8 12/14] mm: zswap: Simplify acomp_ctx resource allocation/deletion and mutex lock usage.
Date: Mon,  3 Mar 2025 00:47:22 -0800
Message-Id: <20250303084724.6490-13-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250303084724.6490-1-kanchana.p.sridhar@intel.com>
References: <20250303084724.6490-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch modifies the acomp_ctx resources' lifetime to be from pool
creation to deletion. A "bool __online" and "u8 nr_reqs" are added to
"struct crypto_acomp_ctx" which simplify a few things:

1) zswap_pool_create() will initialize all members of each percpu acomp_ctx
   to 0 or NULL and only then initialize the mutex.
2) CPU hotplug will set nr_reqs to 1, allocate resources and set __online
   to true, without locking the mutex.
3) CPU hotunplug will lock the mutex before setting __online to false. It
   will not delete any resources.
4) acomp_ctx_get_cpu_lock() will lock the mutex, then check if __online
   is true, and if so, return the mutex for use in zswap compress and
   decompress ops.
5) CPU onlining after offlining will simply check if either __online or
   nr_reqs are non-0, and return 0 if so, without re-allocating the
   resources.
6) zswap_pool_destroy() will call a newly added zswap_cpu_comp_dealloc() to
   delete the acomp_ctx resources.
7) Common resource deletion code in case of zswap_cpu_comp_prepare()
   errors, and for use in zswap_cpu_comp_dealloc(), is factored into a new
   acomp_ctx_dealloc().

The CPU hot[un]plug callback functions are moved to "pool functions"
accordingly.

The per-cpu memory cost of not deleting the acomp_ctx resources upon CPU
offlining, and only deleting them when the pool is destroyed, is as follows:

    IAA with batching: 64.8 KB
    Software compressors: 8.2 KB

I would appreciate code review comments on whether this memory cost is
acceptable, for the latency improvement that it provides due to a faster
reclaim restart after a CPU hotunplug-hotplug sequence - all that the
hotplug code needs to do is to check if acomp_ctx->nr_reqs is non-0, and
if so, set __online to true and return, and reclaim can proceed.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 273 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 182 insertions(+), 91 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 10f2a16e7586..cff96df1df8b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -144,10 +144,12 @@ bool zswap_never_enabled(void)
 struct crypto_acomp_ctx {
 	struct crypto_acomp *acomp;
 	struct acomp_req *req;
-	struct crypto_wait wait;
 	u8 *buffer;
+	u8 nr_reqs;
+	struct crypto_wait wait;
 	struct mutex mutex;
 	bool is_sleepable;
+	bool __online;
 };
 
 /*
@@ -246,6 +248,122 @@ static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
 **********************************/
 static void __zswap_pool_empty(struct percpu_ref *ref);
 
+static void acomp_ctx_dealloc(struct crypto_acomp_ctx *acomp_ctx)
+{
+	if (!IS_ERR_OR_NULL(acomp_ctx) && acomp_ctx->nr_reqs) {
+
+		if (!IS_ERR_OR_NULL(acomp_ctx->req))
+			acomp_request_free(acomp_ctx->req);
+		acomp_ctx->req = NULL;
+
+		kfree(acomp_ctx->buffer);
+		acomp_ctx->buffer = NULL;
+
+		if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
+			crypto_free_acomp(acomp_ctx->acomp);
+
+		acomp_ctx->nr_reqs = 0;
+	}
+}
+
+static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
+{
+	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
+	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
+	int ret = -ENOMEM;
+
+	/*
+	 * Just to be even more fail-safe against changes in assumptions and/or
+	 * implementation of the CPU hotplug code.
+	 */
+	if (acomp_ctx->__online)
+		return 0;
+
+	if (acomp_ctx->nr_reqs) {
+		acomp_ctx->__online = true;
+		return 0;
+	}
+
+	acomp_ctx->acomp = crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_node(cpu));
+	if (IS_ERR(acomp_ctx->acomp)) {
+		pr_err("could not alloc crypto acomp %s : %ld\n",
+			pool->tfm_name, PTR_ERR(acomp_ctx->acomp));
+		ret = PTR_ERR(acomp_ctx->acomp);
+		goto fail;
+	}
+
+	acomp_ctx->nr_reqs = 1;
+
+	acomp_ctx->req = acomp_request_alloc(acomp_ctx->acomp);
+	if (!acomp_ctx->req) {
+		pr_err("could not alloc crypto acomp_request %s\n",
+		       pool->tfm_name);
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	acomp_ctx->buffer = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
+	if (!acomp_ctx->buffer) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	crypto_init_wait(&acomp_ctx->wait);
+
+	/*
+	 * if the backend of acomp is async zip, crypto_req_done() will wakeup
+	 * crypto_wait_req(); if the backend of acomp is scomp, the callback
+	 * won't be called, crypto_wait_req() will return without blocking.
+	 */
+	acomp_request_set_callback(acomp_ctx->req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &acomp_ctx->wait);
+
+	acomp_ctx->is_sleepable = acomp_is_async(acomp_ctx->acomp);
+
+	acomp_ctx->__online = true;
+
+	return 0;
+
+fail:
+	acomp_ctx_dealloc(acomp_ctx);
+
+	return ret;
+}
+
+static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
+{
+	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
+	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
+
+	mutex_lock(&acomp_ctx->mutex);
+	acomp_ctx->__online = false;
+	mutex_unlock(&acomp_ctx->mutex);
+
+	return 0;
+}
+
+static void zswap_cpu_comp_dealloc(unsigned int cpu, struct hlist_node *node)
+{
+	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
+	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
+
+	/*
+	 * The lifetime of acomp_ctx resources is from pool creation to
+	 * pool deletion.
+	 *
+	 * Reclaims should not be happening because, we get to this routine only
+	 * in two scenarios:
+	 *
+	 * 1) pool creation failures before/during the pool ref initialization.
+	 * 2) we are in the process of releasing the pool, it is off the
+	 *    zswap_pools list and has no references.
+	 *
+	 * Hence, there is no need for locks.
+	 */
+	acomp_ctx->__online = false;
+	acomp_ctx_dealloc(acomp_ctx);
+}
+
 static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 {
 	struct zswap_pool *pool;
@@ -285,13 +403,21 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 		goto error;
 	}
 
-	for_each_possible_cpu(cpu)
-		mutex_init(&per_cpu_ptr(pool->acomp_ctx, cpu)->mutex);
+	for_each_possible_cpu(cpu) {
+		struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
+
+		acomp_ctx->acomp = NULL;
+		acomp_ctx->req = NULL;
+		acomp_ctx->buffer = NULL;
+		acomp_ctx->__online = false;
+		acomp_ctx->nr_reqs = 0;
+		mutex_init(&acomp_ctx->mutex);
+	}
 
 	ret = cpuhp_state_add_instance(CPUHP_MM_ZSWP_POOL_PREPARE,
 				       &pool->node);
 	if (ret)
-		goto error;
+		goto ref_fail;
 
 	/* being the current pool takes 1 ref; this func expects the
 	 * caller to always add the new pool as the current pool
@@ -307,6 +433,9 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	return pool;
 
 ref_fail:
+	for_each_possible_cpu(cpu)
+		zswap_cpu_comp_dealloc(cpu, &pool->node);
+
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 error:
 	if (pool->acomp_ctx)
@@ -361,8 +490,13 @@ static struct zswap_pool *__zswap_pool_create_fallback(void)
 
 static void zswap_pool_destroy(struct zswap_pool *pool)
 {
+	int cpu;
+
 	zswap_pool_debug("destroying", pool);
 
+	for_each_possible_cpu(cpu)
+		zswap_cpu_comp_dealloc(cpu, &pool->node);
+
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 	free_percpu(pool->acomp_ctx);
 
@@ -816,85 +950,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
 /*********************************
 * compressed storage functions
 **********************************/
-static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
-{
-	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
-	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
-	struct crypto_acomp *acomp = NULL;
-	struct acomp_req *req = NULL;
-	u8 *buffer = NULL;
-	int ret;
-
-	buffer = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
-	if (!buffer) {
-		ret = -ENOMEM;
-		goto fail;
-	}
-
-	acomp = crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_node(cpu));
-	if (IS_ERR(acomp)) {
-		pr_err("could not alloc crypto acomp %s : %ld\n",
-				pool->tfm_name, PTR_ERR(acomp));
-		ret = PTR_ERR(acomp);
-		goto fail;
-	}
-
-	req = acomp_request_alloc(acomp);
-	if (!req) {
-		pr_err("could not alloc crypto acomp_request %s\n",
-		       pool->tfm_name);
-		ret = -ENOMEM;
-		goto fail;
-	}
-
-	/*
-	 * Only hold the mutex after completing allocations, otherwise we may
-	 * recurse into zswap through reclaim and attempt to hold the mutex
-	 * again resulting in a deadlock.
-	 */
-	mutex_lock(&acomp_ctx->mutex);
-	crypto_init_wait(&acomp_ctx->wait);
-
-	/*
-	 * if the backend of acomp is async zip, crypto_req_done() will wakeup
-	 * crypto_wait_req(); if the backend of acomp is scomp, the callback
-	 * won't be called, crypto_wait_req() will return without blocking.
-	 */
-	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
-				   crypto_req_done, &acomp_ctx->wait);
-
-	acomp_ctx->buffer = buffer;
-	acomp_ctx->acomp = acomp;
-	acomp_ctx->is_sleepable = acomp_is_async(acomp);
-	acomp_ctx->req = req;
-	mutex_unlock(&acomp_ctx->mutex);
-	return 0;
-
-fail:
-	if (acomp)
-		crypto_free_acomp(acomp);
-	kfree(buffer);
-	return ret;
-}
-
-static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
-{
-	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
-	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
-
-	mutex_lock(&acomp_ctx->mutex);
-	if (!IS_ERR_OR_NULL(acomp_ctx)) {
-		if (!IS_ERR_OR_NULL(acomp_ctx->req))
-			acomp_request_free(acomp_ctx->req);
-		acomp_ctx->req = NULL;
-		if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
-			crypto_free_acomp(acomp_ctx->acomp);
-		kfree(acomp_ctx->buffer);
-	}
-	mutex_unlock(&acomp_ctx->mutex);
-
-	return 0;
-}
 
 static struct crypto_acomp_ctx *acomp_ctx_get_cpu_lock(struct zswap_pool *pool)
 {
@@ -902,16 +957,52 @@ static struct crypto_acomp_ctx *acomp_ctx_get_cpu_lock(struct zswap_pool *pool)
 
 	for (;;) {
 		acomp_ctx = raw_cpu_ptr(pool->acomp_ctx);
-		mutex_lock(&acomp_ctx->mutex);
-		if (likely(acomp_ctx->req))
-			return acomp_ctx;
 		/*
-		 * It is possible that we were migrated to a different CPU after
-		 * getting the per-CPU ctx but before the mutex was acquired. If
-		 * the old CPU got offlined, zswap_cpu_comp_dead() could have
-		 * already freed ctx->req (among other things) and set it to
-		 * NULL. Just try again on the new CPU that we ended up on.
+		 * If the CPU onlining code successfully allocates acomp_ctx resources,
+		 * it sets acomp_ctx->__online to true. Until this happens, we have
+		 * two options:
+		 *
+		 * 1. Return NULL and fail all stores on this CPU.
+		 * 2. Retry, until onlining has finished allocating resources.
+		 *
+		 * In theory, option 1 could be more appropriate, because it
+		 * allows the calling procedure to decide how it wants to handle
+		 * reclaim racing with CPU hotplug. For instance, it might be Ok
+		 * for compress to return an error for the backing swap device
+		 * to store the folio. Decompress could wait until we get a
+		 * valid and locked mutex after onlining has completed. For now,
+		 * we go with option 2 because adding a do-while in
+		 * zswap_decompress() adds latency for software compressors.
+		 *
+		 * Once initialized, the resources will be de-allocated only
+		 * when the pool is destroyed. The acomp_ctx will hold on to the
+		 * resources through CPU offlining/onlining at any time until
+		 * the pool is destroyed.
+		 *
+		 * This prevents races/deadlocks between reclaim and CPU acomp_ctx
+		 * resource allocation that are a dependency for reclaim.
+		 * It further simplifies the interaction with CPU onlining and
+		 * offlining:
+		 *
+		 * - CPU onlining does not take the mutex. It only allocates
+		 *   resources and sets __online to true.
+		 * - CPU offlining acquires the mutex before setting
+		 *   __online to false. If reclaim has acquired the mutex,
+		 *   offlining will have to wait for reclaim to complete before
+		 *   hotunplug can proceed. Further, hotplug merely sets
+		 *   __online to false. It does not delete the acomp_ctx
+		 *   resources.
+		 *
+		 * Option 1 is better than potentially not exiting the earlier
+		 * for (;;) loop because the system is running low on memory
+		 * and/or CPUs are getting offlined for whatever reason. At
+		 * least failing this store will prevent data loss by failing
+		 * zswap_store(), and saving the data in the backing swap device.
 		 */
+		mutex_lock(&acomp_ctx->mutex);
+		if (likely(acomp_ctx->__online))
+			return acomp_ctx;
+
 		mutex_unlock(&acomp_ctx->mutex);
 	}
 }
-- 
2.27.0


