Return-Path: <linux-kernel+bounces-369718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047F19A21A5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282FE1C2196D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C848A1DD535;
	Thu, 17 Oct 2024 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mFCLVh6g"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5F1DD537
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166246; cv=none; b=WcNQO/sv0eGYv+IswYXpeE5VZZnA/IVYXHox0VzCM5b5QlWj0DKTy/zI6npcULMSitE7lM2Fc794Hu42NE1H/9E3IzA+kWR6l7K2rUHNr5O4fy+jxFb4cQ1DW7KoyUZUIq7Ul2AjgCi3PHbgQG+QWiY80GJbbvxXqnq14xaEevE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166246; c=relaxed/simple;
	bh=li2fQgOjpIoeaFM1zMmqeazMs4VMAmc4h2EW5JCYV+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VhS/EddaczSxjNkKeGAQisR56qlDbVBlgX6RpXpOknlRwehPpVKE9A1G+3bRcyFzMwPYmwW03wW9/KOfxYXRCus3C7g+fAuakq/m8CHf7ffqlEMtY3Fl1FdWIFAbwU0HW+4n91WDfY+gFdel6w/0VgIdad/0YUjkcIt372Vf4Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mFCLVh6g; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729166234; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+0k3fKbkmiBfeJSp47PplMF3yEs2JVdVQUW+a1FcgDM=;
	b=mFCLVh6gGWKPOEM8QavFCH3l+5FkwBN+PQbXBd3IUX1bNKxgt/CxqWd/uQ44rFg2asOBs2C42DzIEXWIwmbMz+max6fy8q5ao5oC/Cb3tCrRPvFK3ucNJb2iPq0drl2aYDJMPwOjjrF0c7KwVJAP02d7J+rp/4GbFcTOitAxtH0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHKltBl_1729166227 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 19:57:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Chunhai Guo <guochunhai@vivo.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/3] erofs: get rid of erofs_{find,insert}_workgroup
Date: Thu, 17 Oct 2024 19:57:03 +0800
Message-ID: <20241017115705.877515-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just fold them into the only two callers since
they are simple enough.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h |  5 +----
 fs/erofs/zdata.c    | 38 +++++++++++++++++++++++++---------
 fs/erofs/zutil.c    | 50 +--------------------------------------------
 3 files changed, 30 insertions(+), 63 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4efd578d7c62..8081ee43cd83 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -457,10 +457,7 @@ void erofs_release_pages(struct page **pagepool);
 
 #ifdef CONFIG_EROFS_FS_ZIP
 void erofs_workgroup_put(struct erofs_workgroup *grp);
-struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
-					     pgoff_t index);
-struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
-					       struct erofs_workgroup *grp);
+bool erofs_workgroup_get(struct erofs_workgroup *grp);
 void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
 void erofs_shrinker_register(struct super_block *sb);
 void erofs_shrinker_unregister(struct super_block *sb);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a569ff9dfd04..7423354d6957 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -714,9 +714,10 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
 	struct super_block *sb = fe->inode->i_sb;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	bool ztailpacking = map->m_flags & EROFS_MAP_META;
 	struct z_erofs_pcluster *pcl;
-	struct erofs_workgroup *grp;
+	struct erofs_workgroup *grp, *pre;
 	int err;
 
 	if (!(map->m_flags & EROFS_MAP_ENCODED) ||
@@ -752,15 +753,23 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 		pcl->obj.index = 0;	/* which indicates ztailpacking */
 	} else {
 		pcl->obj.index = erofs_blknr(sb, map->m_pa);
-
-		grp = erofs_insert_workgroup(fe->inode->i_sb, &pcl->obj);
-		if (IS_ERR(grp)) {
-			err = PTR_ERR(grp);
-			goto err_out;
+		while (1) {
+			xa_lock(&sbi->managed_pslots);
+			pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
+					   NULL, grp, GFP_KERNEL);
+			if (!pre || xa_is_err(pre) || erofs_workgroup_get(pre)) {
+				xa_unlock(&sbi->managed_pslots);
+				break;
+			}
+			/* try to legitimize the current in-tree one */
+			xa_unlock(&sbi->managed_pslots);
+			cond_resched();
 		}
-
-		if (grp != &pcl->obj) {
-			fe->pcl = container_of(grp,
+		if (xa_is_err(pre)) {
+			err = xa_err(pre);
+			goto err_out;
+		} else if (pre) {
+			fe->pcl = container_of(pre,
 					struct z_erofs_pcluster, obj);
 			err = -EEXIST;
 			goto err_out;
@@ -789,7 +798,16 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
 
 	if (!(map->m_flags & EROFS_MAP_META)) {
-		grp = erofs_find_workgroup(sb, blknr);
+		while (1) {
+			rcu_read_lock();
+			grp = xa_load(&EROFS_SB(sb)->managed_pslots, blknr);
+			if (erofs_workgroup_get(grp)) {
+				DBG_BUGON(blknr != grp->index);
+				rcu_read_unlock();
+				break;
+			}
+			rcu_read_unlock();
+		}
 	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 37afe2024840..218b0249a482 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -214,7 +214,7 @@ void erofs_release_pages(struct page **pagepool)
 	}
 }
 
-static bool erofs_workgroup_get(struct erofs_workgroup *grp)
+bool erofs_workgroup_get(struct erofs_workgroup *grp)
 {
 	if (lockref_get_not_zero(&grp->lockref))
 		return true;
@@ -231,54 +231,6 @@ static bool erofs_workgroup_get(struct erofs_workgroup *grp)
 	return true;
 }
 
-struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
-					     pgoff_t index)
-{
-	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	struct erofs_workgroup *grp;
-
-repeat:
-	rcu_read_lock();
-	grp = xa_load(&sbi->managed_pslots, index);
-	if (grp) {
-		if (!erofs_workgroup_get(grp)) {
-			/* prefer to relax rcu read side */
-			rcu_read_unlock();
-			goto repeat;
-		}
-
-		DBG_BUGON(index != grp->index);
-	}
-	rcu_read_unlock();
-	return grp;
-}
-
-struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
-					       struct erofs_workgroup *grp)
-{
-	struct erofs_sb_info *const sbi = EROFS_SB(sb);
-	struct erofs_workgroup *pre;
-
-	DBG_BUGON(grp->lockref.count < 1);
-repeat:
-	xa_lock(&sbi->managed_pslots);
-	pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
-			   NULL, grp, GFP_KERNEL);
-	if (pre) {
-		if (xa_is_err(pre)) {
-			pre = ERR_PTR(xa_err(pre));
-		} else if (!erofs_workgroup_get(pre)) {
-			/* try to legitimize the current in-tree one */
-			xa_unlock(&sbi->managed_pslots);
-			cond_resched();
-			goto repeat;
-		}
-		grp = pre;
-	}
-	xa_unlock(&sbi->managed_pslots);
-	return grp;
-}
-
 static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
 {
 	atomic_long_dec(&erofs_global_shrink_cnt);
-- 
2.43.5


