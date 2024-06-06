Return-Path: <linux-kernel+bounces-204741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5F48FF300
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30F51C216C6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0D9198E6A;
	Thu,  6 Jun 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejJEGdkW"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E517BC9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692797; cv=none; b=D3J/rS+0T/stfVcVutjaL8yeW3gtFm9qZcaFFfwS4pzBTZAqV5BoPZ4XHRd1D9xyL9Jqy3jY/kqJWSPVwdOI5S37Mox4iH8ikMO7syi26+eobjGHpvubok8pxx7PTGf67/lAmjdy0K7CgPDDtuuw5AsX3W8rKRKq4vAEbEiVhnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692797; c=relaxed/simple;
	bh=1UwjUL8jSEj43FkOGQrwOZGMr6VEugwUFzsqE7UM+X8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1ldOVbDyj1l1ouPtXYCeaEvMh/m3+WjWaVKwL7A8Eh/ewmgbJutplrhTZ/cL/lHUbwQP093qNp+G0GxF/eyjfyqU23uG4wICN8bha28IXkXmQv+TZxE8UWY7Sq2IpkYgB6/qfbtKx/AztpF4i/mI5NGfPVeNMItIw0Qi/7z4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejJEGdkW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f6ad2e2f5bso11523085ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 09:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717692796; x=1718297596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc3RMWumHKS+4tAFTa24Td2vGRB/wsUyT746eSPeZQs=;
        b=ejJEGdkWChv9DEnjBy8NVwQIGXOUJY8IPJGemvhpnRO0jnqFV0yiSQqx4xehzFSREX
         sJlia22ZAF3LcDkgU6k/YrDz9yhQuWigseaefywnN6iYZ074Ra3/HIedhtVmYCo6yEeJ
         f8b6ADjzbRmFCCgxy4Nw//pzCeRXJg5WQLYaY5tKDu8RYt1CVKJKlVf5aU12Y0EcOGBX
         a/A6ewtCj+6x8SeflUs/1yvBwOeCOKVk08/GQeR8i8YiwZI10XRu9FlEU8jmufTehzu6
         rNIYloFD/F0S7jDu8ZpljJRwQlZlo33Dabl2W0g0nzbNRJ4yiiMZsSPzyXG2tqC70BuV
         zBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692796; x=1718297596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bc3RMWumHKS+4tAFTa24Td2vGRB/wsUyT746eSPeZQs=;
        b=GsHFpp7IgIvYGG92pYL4bHKKMIv1RVI9er6IzjsUPDg8vLcnTopTTBnM5wNIZeLj62
         94unnPjUHY8/bQeUo4Tnwuyf66RfaYhXaeQmfXIYMsOAErHi36tB/DOdJL3bvlyMpyCc
         TDs3HIPyE7yzC9/5qI/KQ7WQGV3EoNt2Js+d0cWo4r+YFew5wE15K7pW+ipKSvnGIWEd
         14ivgto2QiJjMt8zzmgN9ECt3ePzzyzB5rPyEgtPil1SUyKUv+uhLHV0/z4gvwiS5Eaz
         xPAToyoKs6laXohjMe4m0rGsPpNaTCsT2+DCQCcp43A1I5YWG7k8SLh5cac8zl2Y6ue7
         QKTw==
X-Forwarded-Encrypted: i=1; AJvYcCUXiV52/xV8emp+ZwBal/g6s7C6pTboiTM3VvAPl6Zj56+yg+kndpEfZVbwgaS2WDzS2dQsDDpnD/+nzoIA6pTb9g418AmAFw4vIKhh
X-Gm-Message-State: AOJu0YzfwoR8+YlRiOfDpZW9mXilEkDESy2MqJqnoqprvsEFpR86Kh6Q
	7IYyj6CihQRuTsCeD5hG4uFYovj535+rUTEoAaAU2JfavoeP/U8f
X-Google-Smtp-Source: AGHT+IF7rHojm4FcprtqM5OEnPHWFlJqrlUBB9dJkZGFuwLCow34qLp57nM528tdn+I3P+NDM+HhqQ==
X-Received: by 2002:a17:902:e752:b0:1f6:7fee:8fe0 with SMTP id d9443c01a7336-1f6d03b961cmr2008585ad.67.1717692795511;
        Thu, 06 Jun 2024 09:53:15 -0700 (PDT)
Received: from cbuild.srv.usb0.net (uw2.srv.usb0.net. [185.197.30.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e0490sm17296335ad.187.2024.06.06.09.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:53:15 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: zswap: limit number of zpools based on CPU and RAM
Date: Thu,  6 Jun 2024 16:53:01 +0000
Message-ID: <20240606165303.431215-1-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch limits the number of zpools used by zswap on smaller systems.

Currently, zswap allocates 32 pools unconditionally. This was
implemented to reduce contention on per-zpool locks. However, it incurs
allocation overhead by distributing pages across pools, wasting memory
on systems with fewer CPUs and less RAM.

This patch allocates approximately 2*CPU zpools, with a minimum of 1
zpool for single-CPU systems and up to 32 zpools for systems with 16 or
more CPUs.  This number is sufficient to keep the probability of
busy-waiting by a thread under 40%. The upper limit of 32 zpools remains
unchanged.

For memory, it limits to 1 zpool per 60MB of memory for the 20% default
max pool size limit, assuming the best case with no fragmentation in
zspages. It expects 90% pool usage for zsmalloc.

Signed-off-by: Takero Funaki <flintglass@gmail.com>
---
 mm/zswap.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 4de342a63bc2..e957bfdeaf70 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -124,8 +124,11 @@ static unsigned int zswap_accept_thr_percent = 90; /* of max pool size */
 module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
 		   uint, 0644);
 
-/* Number of zpools in zswap_pool (empirically determined for scalability) */
-#define ZSWAP_NR_ZPOOLS 32
+/*
+ * Number of max zpools in zswap_pool (empirically determined for scalability)
+ * This must be order of 2, for pointer hashing.
+ */
+#define ZSWAP_NR_ZPOOLS_MAX 32
 
 /* Enable/disable memory pressure-based shrinker. */
 static bool zswap_shrinker_enabled = IS_ENABLED(
@@ -157,12 +160,13 @@ struct crypto_acomp_ctx {
  * needs to be verified that it's still valid in the tree.
  */
 struct zswap_pool {
-	struct zpool *zpools[ZSWAP_NR_ZPOOLS];
+	struct zpool *zpools[ZSWAP_NR_ZPOOLS_MAX];
 	struct crypto_acomp_ctx __percpu *acomp_ctx;
 	struct percpu_ref ref;
 	struct list_head list;
 	struct work_struct release_work;
 	struct hlist_node node;
+	unsigned char nr_zpools_order;
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
 };
 
@@ -243,11 +247,55 @@ static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
 		 zpool_get_type((p)->zpools[0]))
 
+static unsigned long zswap_max_pages(void);
+
 /*********************************
 * pool functions
 **********************************/
 static void __zswap_pool_empty(struct percpu_ref *ref);
 
+/*
+ * Estimate the optimal number of zpools based on CPU and memory.
+ *
+ * For CPUs, aim for 40% or lower probability of busy-waiting from a thread,
+ * assuming all cores are accessing zswap concurrently.
+ * The threshold is chosen for the simplicity of the formula:
+ * The probability is 1-(1-(1/pool))^(thr-1). For 40% threshold, this is
+ * approximately pool = 2 * threads rounded up to orders of 2.
+ * Threads \ Pools
+ *      2       4       8       16      32
+ * 2    0.50    0.25 <  0.13    0.06    0.03
+ * 4    0.88    0.58    0.33 <  0.18    0.09
+ * 6    0.97    0.76    0.49    0.28 <  0.15
+ * 8    0.99    0.87    0.61    0.36 <  0.20
+ * 10   1.00    0.92    0.70    0.44    0.25 <
+ * 16   1.00    0.99    0.87    0.62    0.38 <
+ * 18   1.00    0.99    0.90    0.67    0.42
+ *
+ * For memory, expect 90% pool usage for zsmalloc in the best case.
+ * Assuming uniform distribution, we need to store:
+ *   590       : sum of pages_per_zspage
+ *   * 0.5     : about half of zspage is empty if no fragmentation
+ *   / (1-0.9) : 90% target usage
+ *   = 2950    : expected max pages of a zpool,
+ *               equivalent to 60MB RAM for a 20% max_pool_percent.
+ */
+static void __zswap_set_nr_zpools(struct zswap_pool *pool)
+{
+	unsigned long mem = zswap_max_pages();
+	unsigned long cpu = num_online_cpus();
+
+	mem = DIV_ROUND_UP(mem, 2950);
+	mem = min(max(1, mem), ZSWAP_NR_ZPOOLS_MAX);
+
+	if (cpu <= 1)
+		cpu = 1;
+	else
+		cpu = 1 << ilog2(min(cpu * 2, ZSWAP_NR_ZPOOLS_MAX);
+
+	pool->nr_zpools_order = ilog2(min(mem, cpu));
+}
+
 static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 {
 	int i;
@@ -271,7 +319,9 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	if (!pool)
 		return NULL;
 
-	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++) {
+	__zswap_set_nr_zpools(pool);
+
+	for (i = 0; i < (1 << pool->nr_zpools_order); i++) {
 		/* unique name for each pool specifically required by zsmalloc */
 		snprintf(name, 38, "zswap%x",
 			 atomic_inc_return(&zswap_pools_count));
@@ -372,7 +422,7 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 	free_percpu(pool->acomp_ctx);
 
-	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
+	for (i = 0; i < (1 << pool->nr_zpools_order); i++)
 		zpool_destroy_pool(pool->zpools[i]);
 	kfree(pool);
 }
@@ -513,7 +563,7 @@ unsigned long zswap_total_pages(void)
 	list_for_each_entry_rcu(pool, &zswap_pools, list) {
 		int i;
 
-		for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
+		for (i = 0; i < (1 << pool->nr_zpools_order); i++)
 			total += zpool_get_total_pages(pool->zpools[i]);
 	}
 	rcu_read_unlock();
@@ -822,7 +872,10 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 
 static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
 {
-	return entry->pool->zpools[hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOLS))];
+	if (entry->pool->nr_zpools_order == 0)
+		return entry->pool->zpools[0];
+
+	return entry->pool->zpools[hash_ptr(entry, entry->pool->nr_zpools_order)];
 }
 
 /*
-- 
2.43.0


