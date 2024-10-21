Return-Path: <linux-kernel+bounces-373607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528DC9A5957
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 05:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AC51C20AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 03:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E668519938D;
	Mon, 21 Oct 2024 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="izkmAZFN"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D0F3BBEA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729482822; cv=none; b=sJC33N8NGzI/YilP4fjvNZVemXo77ywqepqAOslOhNyBQVwUpmEbs63rzjjIoKxsvDNXWAredYOaB1CLojzp4w+ytKcJEawywIGLuyptaqDSIiz5rDJmorsWpGwgzFVsMR8I/13EW7NqwtMpXWYhaS+HIBjFIPJ1NCWRyWY5f5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729482822; c=relaxed/simple;
	bh=J338/cmNanTZc6QmSGhzV/cBf5PIVFuT9lueIVMjqTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtQ03qDA+//PFIeYxdHeEwjo0KuXaPrhDyn1XfvIGrxZ3GTeRQHuwFUcDroS7Ly+rjbw1Eqaq872TDfQOlYGuzgTyaajlMdjSJNX879EV97z+oDwvxaiHegXwnUZemHnmj15pJwGr6jtyTTIAVmu455fGSNGJQ1tj8INIFE8waM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=izkmAZFN; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729482811; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=2aMzbVTS0mfKCMqfqugAqebcL0+UK7T9EHfLv6Jyg+4=;
	b=izkmAZFNOEsvyrF61oeao6IMgr17eaVluU4VQ70IGTx1Kt5BGiJMjYIVOsf9mbxXHgTKUVsPrJjeU1MZRm3JehzPtE6OwvsF07p07jhNlO9T6h8JbVfIIU86pk5KOgULaASN5b44SzMM/xWggF1nhy5nakDtXhHf/SdlAUhB2bQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHUg8cA_1729482810 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Oct 2024 11:53:31 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Chunhai Guo <guochunhai@vivo.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 2/3] erofs: move erofs_workgroup operations into zdata.c
Date: Mon, 21 Oct 2024 11:53:22 +0800
Message-ID: <20241021035323.3280682-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241021035323.3280682-1-hsiangkao@linux.alibaba.com>
References: <20241021035323.3280682-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move related helpers into zdata.c as an intermediate step of getting
rid of `struct erofs_workgroup`, and rename:

 erofs_workgroup_put => z_erofs_put_pcluster
 erofs_workgroup_get => z_erofs_get_pcluster
 erofs_try_to_release_workgroup => erofs_try_to_release_pcluster
 erofs_shrink_workstation => z_erofs_shrink_scan

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h |   8 ++--
 fs/erofs/zdata.c    | 102 ++++++++++++++++++++++++++++++++++++++---
 fs/erofs/zutil.c    | 107 +++-----------------------------------------
 3 files changed, 105 insertions(+), 112 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 8081ee43cd83..5fa7ac0575b2 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -456,17 +456,15 @@ static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
 void erofs_release_pages(struct page **pagepool);
 
 #ifdef CONFIG_EROFS_FS_ZIP
-void erofs_workgroup_put(struct erofs_workgroup *grp);
-bool erofs_workgroup_get(struct erofs_workgroup *grp);
-void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
+extern atomic_long_t erofs_global_shrink_cnt;
 void erofs_shrinker_register(struct super_block *sb);
 void erofs_shrinker_unregister(struct super_block *sb);
 int __init erofs_init_shrinker(void);
 void erofs_exit_shrinker(void);
 int __init z_erofs_init_subsystem(void);
 void z_erofs_exit_subsystem(void);
-int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
-					struct erofs_workgroup *egrp);
+unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
+				  unsigned long nr_shrink);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags);
 void *z_erofs_get_gbuf(unsigned int requiredpages);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bb1b73d99d07..578e6f3612a7 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -587,8 +587,8 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 }
 
 /* (erofs_shrinker) disconnect cached encoded data with pclusters */
-int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
-					struct erofs_workgroup *grp)
+static int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
+					       struct erofs_workgroup *grp)
 {
 	struct z_erofs_pcluster *const pcl =
 		container_of(grp, struct z_erofs_pcluster, obj);
@@ -710,6 +710,23 @@ static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
 	return ret;
 }
 
+static bool z_erofs_get_pcluster(struct erofs_workgroup *grp)
+{
+	if (lockref_get_not_zero(&grp->lockref))
+		return true;
+
+	spin_lock(&grp->lockref.lock);
+	if (__lockref_is_dead(&grp->lockref)) {
+		spin_unlock(&grp->lockref.lock);
+		return false;
+	}
+
+	if (!grp->lockref.count++)
+		atomic_long_dec(&erofs_global_shrink_cnt);
+	spin_unlock(&grp->lockref.lock);
+	return true;
+}
+
 static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
@@ -757,7 +774,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 			xa_lock(&sbi->managed_pslots);
 			pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
 					   NULL, grp, GFP_KERNEL);
-			if (!pre || xa_is_err(pre) || erofs_workgroup_get(pre)) {
+			if (!pre || xa_is_err(pre) || z_erofs_get_pcluster(pre)) {
 				xa_unlock(&sbi->managed_pslots);
 				break;
 			}
@@ -801,7 +818,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 		while (1) {
 			rcu_read_lock();
 			grp = xa_load(&EROFS_SB(sb)->managed_pslots, blknr);
-			if (!grp || erofs_workgroup_get(grp)) {
+			if (!grp || z_erofs_get_pcluster(grp)) {
 				DBG_BUGON(grp && blknr != grp->index);
 				rcu_read_unlock();
 				break;
@@ -869,7 +886,7 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
 			struct z_erofs_pcluster, rcu));
 }
 
-void erofs_workgroup_free_rcu(struct erofs_workgroup *grp)
+static void erofs_workgroup_free_rcu(struct erofs_workgroup *grp)
 {
 	struct z_erofs_pcluster *const pcl =
 		container_of(grp, struct z_erofs_pcluster, obj);
@@ -877,6 +894,77 @@ void erofs_workgroup_free_rcu(struct erofs_workgroup *grp)
 	call_rcu(&pcl->rcu, z_erofs_rcu_callback);
 }
 
+static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+					  struct erofs_workgroup *grp)
+{
+	int free = false;
+
+	spin_lock(&grp->lockref.lock);
+	if (grp->lockref.count)
+		goto out;
+
+	/*
+	 * Note that all cached folios should be detached before deleted from
+	 * the XArray.  Otherwise some folios could be still attached to the
+	 * orphan old pcluster when the new one is available in the tree.
+	 */
+	if (erofs_try_to_free_all_cached_folios(sbi, grp))
+		goto out;
+
+	/*
+	 * It's impossible to fail after the pcluster is freezed, but in order
+	 * to avoid some race conditions, add a DBG_BUGON to observe this.
+	 */
+	DBG_BUGON(__xa_erase(&sbi->managed_pslots, grp->index) != grp);
+
+	lockref_mark_dead(&grp->lockref);
+	free = true;
+out:
+	spin_unlock(&grp->lockref.lock);
+	if (free) {
+		atomic_long_dec(&erofs_global_shrink_cnt);
+		erofs_workgroup_free_rcu(grp);
+	}
+	return free;
+}
+
+unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
+				  unsigned long nr_shrink)
+{
+	struct erofs_workgroup *grp;
+	unsigned int freed = 0;
+	unsigned long index;
+
+	xa_lock(&sbi->managed_pslots);
+	xa_for_each(&sbi->managed_pslots, index, grp) {
+		/* try to shrink each valid pcluster */
+		if (!erofs_try_to_release_pcluster(sbi, grp))
+			continue;
+		xa_unlock(&sbi->managed_pslots);
+
+		++freed;
+		if (!--nr_shrink)
+			return freed;
+		xa_lock(&sbi->managed_pslots);
+	}
+	xa_unlock(&sbi->managed_pslots);
+	return freed;
+}
+
+static void z_erofs_put_pcluster(struct z_erofs_pcluster *pcl)
+{
+	struct erofs_workgroup *grp = &pcl->obj;
+
+	if (lockref_put_or_lock(&grp->lockref))
+		return;
+
+	DBG_BUGON(__lockref_is_dead(&grp->lockref));
+	if (grp->lockref.count == 1)
+		atomic_long_inc(&erofs_global_shrink_cnt);
+	--grp->lockref.count;
+	spin_unlock(&grp->lockref.lock);
+}
+
 static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 {
 	struct z_erofs_pcluster *pcl = fe->pcl;
@@ -895,7 +983,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
-		erofs_workgroup_put(&pcl->obj);
+		z_erofs_put_pcluster(pcl);
 
 	fe->pcl = NULL;
 }
@@ -1327,7 +1415,7 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		if (z_erofs_is_inline_pcluster(be.pcl))
 			z_erofs_free_pcluster(be.pcl);
 		else
-			erofs_workgroup_put(&be.pcl->obj);
+			z_erofs_put_pcluster(be.pcl);
 	}
 	return err;
 }
diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 218b0249a482..75704f58ecfa 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             https://www.huawei.com/
+ * Copyright (C) 2024 Alibaba Cloud
  */
 #include "internal.h"
 
@@ -19,13 +20,12 @@ static unsigned int z_erofs_gbuf_count, z_erofs_gbuf_nrpages,
 module_param_named(global_buffers, z_erofs_gbuf_count, uint, 0444);
 module_param_named(reserved_pages, z_erofs_rsv_nrpages, uint, 0444);
 
-static atomic_long_t erofs_global_shrink_cnt;	/* for all mounted instances */
-/* protected by 'erofs_sb_list_lock' */
-static unsigned int shrinker_run_no;
+atomic_long_t erofs_global_shrink_cnt;	/* for all mounted instances */
 
-/* protects the mounted 'erofs_sb_list' */
+/* protects `erofs_sb_list_lock` and the mounted `erofs_sb_list` */
 static DEFINE_SPINLOCK(erofs_sb_list_lock);
 static LIST_HEAD(erofs_sb_list);
+static unsigned int shrinker_run_no;
 static struct shrinker *erofs_shrinker_info;
 
 static unsigned int z_erofs_gbuf_id(void)
@@ -214,97 +214,6 @@ void erofs_release_pages(struct page **pagepool)
 	}
 }
 
-bool erofs_workgroup_get(struct erofs_workgroup *grp)
-{
-	if (lockref_get_not_zero(&grp->lockref))
-		return true;
-
-	spin_lock(&grp->lockref.lock);
-	if (__lockref_is_dead(&grp->lockref)) {
-		spin_unlock(&grp->lockref.lock);
-		return false;
-	}
-
-	if (!grp->lockref.count++)
-		atomic_long_dec(&erofs_global_shrink_cnt);
-	spin_unlock(&grp->lockref.lock);
-	return true;
-}
-
-static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
-{
-	atomic_long_dec(&erofs_global_shrink_cnt);
-	erofs_workgroup_free_rcu(grp);
-}
-
-void erofs_workgroup_put(struct erofs_workgroup *grp)
-{
-	if (lockref_put_or_lock(&grp->lockref))
-		return;
-
-	DBG_BUGON(__lockref_is_dead(&grp->lockref));
-	if (grp->lockref.count == 1)
-		atomic_long_inc(&erofs_global_shrink_cnt);
-	--grp->lockref.count;
-	spin_unlock(&grp->lockref.lock);
-}
-
-static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
-					   struct erofs_workgroup *grp)
-{
-	int free = false;
-
-	spin_lock(&grp->lockref.lock);
-	if (grp->lockref.count)
-		goto out;
-
-	/*
-	 * Note that all cached pages should be detached before deleted from
-	 * the XArray. Otherwise some cached pages could be still attached to
-	 * the orphan old workgroup when the new one is available in the tree.
-	 */
-	if (erofs_try_to_free_all_cached_folios(sbi, grp))
-		goto out;
-
-	/*
-	 * It's impossible to fail after the workgroup is freezed,
-	 * however in order to avoid some race conditions, add a
-	 * DBG_BUGON to observe this in advance.
-	 */
-	DBG_BUGON(__xa_erase(&sbi->managed_pslots, grp->index) != grp);
-
-	lockref_mark_dead(&grp->lockref);
-	free = true;
-out:
-	spin_unlock(&grp->lockref.lock);
-	if (free)
-		__erofs_workgroup_free(grp);
-	return free;
-}
-
-static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
-					      unsigned long nr_shrink)
-{
-	struct erofs_workgroup *grp;
-	unsigned int freed = 0;
-	unsigned long index;
-
-	xa_lock(&sbi->managed_pslots);
-	xa_for_each(&sbi->managed_pslots, index, grp) {
-		/* try to shrink each valid workgroup */
-		if (!erofs_try_to_release_workgroup(sbi, grp))
-			continue;
-		xa_unlock(&sbi->managed_pslots);
-
-		++freed;
-		if (!--nr_shrink)
-			return freed;
-		xa_lock(&sbi->managed_pslots);
-	}
-	xa_unlock(&sbi->managed_pslots);
-	return freed;
-}
-
 void erofs_shrinker_register(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
@@ -321,8 +230,8 @@ void erofs_shrinker_unregister(struct super_block *sb)
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
 	mutex_lock(&sbi->umount_mutex);
-	/* clean up all remaining workgroups in memory */
-	erofs_shrink_workstation(sbi, ~0UL);
+	/* clean up all remaining pclusters in memory */
+	z_erofs_shrink_scan(sbi, ~0UL);
 
 	spin_lock(&erofs_sb_list_lock);
 	list_del(&sbi->list);
@@ -370,9 +279,7 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 
 		spin_unlock(&erofs_sb_list_lock);
 		sbi->shrinker_run_no = run_no;
-
-		freed += erofs_shrink_workstation(sbi, nr - freed);
-
+		freed += z_erofs_shrink_scan(sbi, nr - freed);
 		spin_lock(&erofs_sb_list_lock);
 		/* Get the next list element before we move this one */
 		p = p->next;
-- 
2.43.5


