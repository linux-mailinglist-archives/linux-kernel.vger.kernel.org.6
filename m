Return-Path: <linux-kernel+bounces-282016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 993E094DE50
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 21:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D07282C7F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 19:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283DB13D51A;
	Sat, 10 Aug 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gER3hwxT"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB8713C83A
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723319604; cv=none; b=faB3aRkr6HT1Xh1M+l5LGl0xECgQSq+kx0Ay07ct6TYPTFH0ivyZRIVGZ6eZo2JFJj9mHXCyx8ddZel/wRbOI9U4YxL1E46qjpU0XI/n8QB/t8f5ox87PIHdpSnsitlVK7r1eeTHIWpkBgBT6wIWOdyiF8UyWVoZppr6bNOnVMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723319604; c=relaxed/simple;
	bh=BHIU2InSC64hLrVrzlFekZ0somTwM/HyiGBUHzA7vAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R/3pyTs/Sbpb++xIhxM+5L8rgmexjkg33tLJH6NFo/mFAvIPOsNNZBB81rjq4NBydZy7aeazPaHxJb8bkoax/c+Efh5+7bMoI6wZM1kKUOzTYnoWufOX9jAop1YZEt2JWHqaKiPOm3gHJdRaanAxoaS8rv1Gfb/Bu/Adg1pFH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gER3hwxT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d213dff499so60860a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723319602; x=1723924402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RT/8SZgyxy/IdolTekKRVwjoG2TSesGN9ly9JHx/q30=;
        b=gER3hwxT61qgFIf3YE/JPvCQyiu+Tt7LiVmeTb5mzq6pumcJF2UIDewy/m7ykOzMbq
         eNH7UnikQ0lVWcM0rbf//wLZrXo8WxPd1jf+suVVgWC+qJZEBElNXRg282E0UaON4Roo
         Bg8e941BuhXigsHTYYab9fPzd2Vc0L31wByeY7KGafkMKSIe4rDUcuzC0QR3Xfd/8pUy
         JE5KLzn69i54yY014to0ZPcUzw/yC7DOx9ePmVfEvT8zo77IhVbS8CFIDICgaebAx7QC
         fOjx9lm2+tTl9KDQb0e8v7EIIeyKZai4po4/MHogQJUVcL0XJqri4aolD3qHSk7gRHgv
         TvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723319602; x=1723924402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RT/8SZgyxy/IdolTekKRVwjoG2TSesGN9ly9JHx/q30=;
        b=HAwUY+J3zHa9/t2cEWmJnuFAC4fJesl3/yc7oYqFmw74Hg+ZnhJIVyj4rrOtY9Snfp
         0EpC99XLvqD5zw5y2fujUuf7S5ub9TLTs0gDe9Ij6nRII9NYQ/G/5+2oHImzynMk3shb
         LALXyI0z820TYxGvmoDdb2VfwfRXFrKF7wDDVwRdHtxgvGDx7GVcIUAUPqQMm9DHMGPL
         OGZlhW+eVDupkZKM9rcu0LbVdihxjoySZJdFtdUoGvNzezomV2ZYhZZ+mkwYj9NFJHZJ
         DCOqcy+vj/+OsG1PUHtljzf0GHaE/mAzThAeq7MGZb0OjEV7EnM69HR1OiSkynXNoxfw
         k8sA==
X-Forwarded-Encrypted: i=1; AJvYcCWvamFT+ZEaI2npRRkxPhqqvasFiuirzlzldNxvZ6T0sVZtyVS474j9CuAn8nn8z0uvG1BdeglUvnH16+bVWNfIVrxxvOgbOpBXa+D5
X-Gm-Message-State: AOJu0YyXqFcigNfJtEo+uFXaO8LyIXnxTzRhSP1aoTlGadm36/dLin6z
	IgJKUB9xffj44fvO7b4NJypDPnHXLx7tGzhwdanGF1U1ncCjGDxt
X-Google-Smtp-Source: AGHT+IEyegN8ne/NBe7gxuyhDgh79XREsz5HAjvumAutY7om9XUbSM263saQc/jYpgj7FaBCSg9lHw==
X-Received: by 2002:a17:902:d491:b0:1fd:d6d8:134a with SMTP id d9443c01a7336-200ae69dc2bmr40423735ad.11.1723319601970;
        Sat, 10 Aug 2024 12:53:21 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb3a8desm14596535ad.281.2024.08.10.12.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 12:53:21 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: jserv@ccns.ncku.edu.tw,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] ocfs2: Remove custom swap functions in favor of built-in sort swap
Date: Sun, 11 Aug 2024 03:53:16 +0800
Message-Id: <20240810195316.186504-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The custom swap functions used in ocfs2 do not perform any special
operations and can be replaced with the built-in swap function of sort.
This change not only reduces code size but also improves efficiency,
especially in scenarios where CONFIG_RETPOLINE is enabled, as it makes
indirect function calls more expensive.

By using the built-in swap, we avoid these costly indirect function
calls, leading to better performance.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Note: Build test only.

 fs/ocfs2/dir.c          | 12 +-----------
 fs/ocfs2/refcounttree.c | 13 +++----------
 fs/ocfs2/xattr.c        | 15 +++------------
 3 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index f0beb173dbba..fa5d0819a997 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -3511,16 +3511,6 @@ static int dx_leaf_sort_cmp(const void *a, const void *b)
 	return 0;
 }
 
-static void dx_leaf_sort_swap(void *a, void *b, int size)
-{
-	struct ocfs2_dx_entry *entry1 = a;
-	struct ocfs2_dx_entry *entry2 = b;
-
-	BUG_ON(size != sizeof(*entry1));
-
-	swap(*entry1, *entry2);
-}
-
 static int ocfs2_dx_leaf_same_major(struct ocfs2_dx_leaf *dx_leaf)
 {
 	struct ocfs2_dx_entry_list *dl_list = &dx_leaf->dl_list;
@@ -3781,7 +3771,7 @@ static int ocfs2_dx_dir_rebalance(struct ocfs2_super *osb, struct inode *dir,
 	 */
 	sort(dx_leaf->dl_list.de_entries, num_used,
 	     sizeof(struct ocfs2_dx_entry), dx_leaf_sort_cmp,
-	     dx_leaf_sort_swap);
+	     NULL);
 
 	ocfs2_journal_dirty(handle, dx_leaf_bh);
 
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 1f303b1adf1a..4f85508538fc 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -1392,13 +1392,6 @@ static int cmp_refcount_rec_by_cpos(const void *a, const void *b)
 	return 0;
 }
 
-static void swap_refcount_rec(void *a, void *b, int size)
-{
-	struct ocfs2_refcount_rec *l = a, *r = b;
-
-	swap(*l, *r);
-}
-
 /*
  * The refcount cpos are ordered by their 64bit cpos,
  * But we will use the low 32 bit to be the e_cpos in the b-tree.
@@ -1474,7 +1467,7 @@ static int ocfs2_divide_leaf_refcount_block(struct buffer_head *ref_leaf_bh,
 	 */
 	sort(&rl->rl_recs, le16_to_cpu(rl->rl_used),
 	     sizeof(struct ocfs2_refcount_rec),
-	     cmp_refcount_rec_by_low_cpos, swap_refcount_rec);
+	     cmp_refcount_rec_by_low_cpos, NULL);
 
 	ret = ocfs2_find_refcount_split_pos(rl, &cpos, &split_index);
 	if (ret) {
@@ -1499,11 +1492,11 @@ static int ocfs2_divide_leaf_refcount_block(struct buffer_head *ref_leaf_bh,
 
 	sort(&rl->rl_recs, le16_to_cpu(rl->rl_used),
 	     sizeof(struct ocfs2_refcount_rec),
-	     cmp_refcount_rec_by_cpos, swap_refcount_rec);
+	     cmp_refcount_rec_by_cpos, NULL);
 
 	sort(&new_rl->rl_recs, le16_to_cpu(new_rl->rl_used),
 	     sizeof(struct ocfs2_refcount_rec),
-	     cmp_refcount_rec_by_cpos, swap_refcount_rec);
+	     cmp_refcount_rec_by_cpos, NULL);
 
 	*split_cpos = cpos;
 	return 0;
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 35c0cc2a51af..0e58a5ce539e 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -4167,15 +4167,6 @@ static int cmp_xe(const void *a, const void *b)
 	return 0;
 }
 
-static void swap_xe(void *a, void *b, int size)
-{
-	struct ocfs2_xattr_entry *l = a, *r = b, tmp;
-
-	tmp = *l;
-	memcpy(l, r, sizeof(struct ocfs2_xattr_entry));
-	memcpy(r, &tmp, sizeof(struct ocfs2_xattr_entry));
-}
-
 /*
  * When the ocfs2_xattr_block is filled up, new bucket will be created
  * and all the xattr entries will be moved to the new bucket.
@@ -4241,7 +4232,7 @@ static void ocfs2_cp_xattr_block_to_bucket(struct inode *inode,
 	trace_ocfs2_cp_xattr_block_to_bucket_end(offset, size, off_change);
 
 	sort(target + offset, count, sizeof(struct ocfs2_xattr_entry),
-	     cmp_xe, swap_xe);
+	     cmp_xe, NULL);
 }
 
 /*
@@ -4436,7 +4427,7 @@ static int ocfs2_defrag_xattr_bucket(struct inode *inode,
 	 */
 	sort(entries, le16_to_cpu(xh->xh_count),
 	     sizeof(struct ocfs2_xattr_entry),
-	     cmp_xe_offset, swap_xe);
+	     cmp_xe_offset, NULL);
 
 	/* Move all name/values to the end of the bucket. */
 	xe = xh->xh_entries;
@@ -4478,7 +4469,7 @@ static int ocfs2_defrag_xattr_bucket(struct inode *inode,
 	/* sort the entries by their name_hash. */
 	sort(entries, le16_to_cpu(xh->xh_count),
 	     sizeof(struct ocfs2_xattr_entry),
-	     cmp_xe, swap_xe);
+	     cmp_xe, NULL);
 
 	buf = bucket_buf;
 	for (i = 0; i < bucket->bu_blocks; i++, buf += blocksize)
-- 
2.34.1


