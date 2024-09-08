Return-Path: <linux-kernel+bounces-320248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918AD9707F8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC507282508
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA04171099;
	Sun,  8 Sep 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gZwVqYtc"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243AF170836
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804441; cv=none; b=rEkQFp141ZcmSCy4ImTXBQ+VhhZUn/sk7LBVRthP6mIG93Yl86VVLdKjUswI4Ao3s6nzhez1bjAUEhgaiIuMpnPebTZ2uzm99GlBdZlkmUaGh46vnpkLBf0tq3NykcWK3Tyq6iakOmGb8MW7xQn9rkSRl9QO98SbIDm+jCjqEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804441; c=relaxed/simple;
	bh=gMwj85pB7Gl01P8y2LOkEt1m1asUOHHDXxzYdMCulbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A14nBVJEtVkUPmM58IFDoIZkqPgY3CB3+MJd7p+VRFWCyB7Dj70vcjh9j+y73Es0FArKd6xqy1X/czo7TpStJvkx+PxOx9uZx/VNmAqMwrm5eYy3pCdXuTVC75UXbDjP1xlGtBHxerBa/gF+HOEBcUR+kD+J1K96/KfSCuTbDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gZwVqYtc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb1e3b449so1179525e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725804437; x=1726409237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnHpTlMy8PKbCha0o0D1VFUrpGJyJX2GaCuCOV7xSpE=;
        b=gZwVqYtcJr0fm1Bg+XYDHZoarjNGF0ZuUIdPwKCUp5Bzs2RXzO/9MLA6R/AdhWF37E
         /RRmC8rXX1bf+oe8ktZ22BRPtB01hz4Tcq1fWUoB0Y36oM6zoBti3SFN/cxIX8Mqzv/X
         rR2RVaPMiaYGuMv15bsaRwFYDMUgAWS3dzjY4Eysm8QOIFTt8x7kJxlfz843a+rg5Yhv
         4StSNqy9LlOAWG+praBNXfeLmL3moFQvpwEJaDQExQ2Tw0fT5BtmqYLax8iSeG2CBRWN
         eWvBmDHZPveEq1ie77jcNEX+UtuoULoU0U1Bxl1UlaQ1/Sbv0l9S/m2WBtuNZIIca9r/
         RlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725804437; x=1726409237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnHpTlMy8PKbCha0o0D1VFUrpGJyJX2GaCuCOV7xSpE=;
        b=id/ne67lXVY8b8qctsjhibIc7z+Ol2FIvcT8VzAyOKKn62YxKX9IWW6FPpbYwJF6x7
         O+v+/DDEBnoDozLkhUiVusAgHlTJTWdpoiuc2NrD7eJeDFEWsjfTtme+9q5sXx6WufEl
         6iSaUsKMqNPNjKQcQbpEW1WtP0SDCIaIbKoywKvGjrQmJ+DKQpL1qD/wWJHaeizo/Q1F
         cqv5jWQriKpd1sgZ91R41p1hzqtjOfDnxdfbD5ts+WQKQZQGqbWQcGc6Ho82HFtk8pHW
         l6XFcfzFO8o3QFAmQ+lcT3EsdP6yrrGbhye2adVbj8utYdbE3yDA94ybqtRuM1M5+Qtq
         k4MA==
X-Forwarded-Encrypted: i=1; AJvYcCUI7elaejLre+UtV+n/LM4OpcxPgoejG3P4ZmtIu95HQ4XXTw2Ly1p3Pkqr7ycnkG/Jbov9JNPCe7Qz964=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgLGLUu/WRSIt6gdekpzz7IdUWuyawXDvsYJMM0OKThh93IxUl
	BGC7a3HfZlftnKYDsY+D3ahWzYSZf310Iw2wiXBlVvCSFsK5xovHYBBcnIFi8kQ=
X-Google-Smtp-Source: AGHT+IEESgZ+WmZEnwkW/95HyfkyQrgtLBWzFYQAhPcB2oWUrSMpmeqxZwQVZtmBHJt0Z7Qqw8kgtA==
X-Received: by 2002:a05:600c:3582:b0:42c:aeee:d8ed with SMTP id 5b1f17b1804b1-42caeeed92dmr13227105e9.7.1725804436463;
        Sun, 08 Sep 2024 07:07:16 -0700 (PDT)
Received: from localhost.localdomain ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc074599sm4863371a91.31.2024.09.08.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 07:07:15 -0700 (PDT)
From: Heming Zhao <heming.zhao@suse.com>
To: joseph.qi@linux.alibaba.com,
	glass.su@suse.com
Cc: Heming Zhao <heming.zhao@suse.com>,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] ocfs2: give ocfs2 the ability to reclaim suballoc free bg
Date: Sun,  8 Sep 2024 22:07:03 +0800
Message-Id: <20240908140705.19169-2-heming.zhao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240908140705.19169-1-heming.zhao@suse.com>
References: <20240908140705.19169-1-heming.zhao@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current ocfs2 code can't reclaim suballocator block group space.
This cause ocfs2 to hold onto a lot of space in some cases. for example,
when creating lots of small files, the space is held/managed by
'//inode_alloc'. After the user deletes all the small files, the space
never returns to '//global_bitmap'. This issue prevents ocfs2 from
providing the needed space even when there is enough free space in a
small ocfs2 volume.
This patch gives ocfs2 the ability to reclaim suballoc free space when
the block group is freed. For performance reasons, this patch keeps
the first suballocator block group.

Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Reviewed-by: Su Yue <glass.su@suse.com>
---
 fs/ocfs2/suballoc.c | 302 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 292 insertions(+), 10 deletions(-)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index f7b483f0de2a..d62010166c34 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -294,6 +294,68 @@ static int ocfs2_validate_group_descriptor(struct super_block *sb,
 	return ocfs2_validate_gd_self(sb, bh, 0);
 }
 
+/*
+ * hint gd may already be released in _ocfs2_free_suballoc_bits(),
+ * we first check gd descriptor signature, then do the
+ * ocfs2_read_group_descriptor() jobs.
+ *
+ * When the group descriptor is invalid, we return 'rc=0' and
+ * '*released=1'. The caller should handle this case. Otherwise,
+ * we return the real error code.
+ */
+static int ocfs2_read_hint_group_descriptor(struct inode *inode,
+			struct ocfs2_dinode *di, u64 gd_blkno,
+			struct buffer_head **bh, int *released)
+{
+	int rc;
+	struct buffer_head *tmp = *bh;
+	struct ocfs2_group_desc *gd;
+
+	*released = 0;
+
+	rc = ocfs2_read_block(INODE_CACHE(inode), gd_blkno, &tmp, NULL);
+	if (rc)
+		goto out;
+
+	gd = (struct ocfs2_group_desc *) tmp->b_data;
+	if (!OCFS2_IS_VALID_GROUP_DESC(gd)) {
+		/*
+		 * Invalid gd cache was set in ocfs2_read_block(),
+		 * which will affect block_group allocation.
+		 * Path:
+		 * ocfs2_reserve_suballoc_bits
+		 *  ocfs2_block_group_alloc
+		 *   ocfs2_block_group_alloc_contig
+		 *    ocfs2_set_new_buffer_uptodate
+		 */
+		ocfs2_remove_from_cache(INODE_CACHE(inode), tmp);
+		*released = 1; /* we return 'rc=0' for this case */
+		goto free_bh;
+	}
+
+	/* below jobs same with ocfs2_read_group_descriptor() */
+	if (!buffer_jbd(tmp)) {
+		rc = ocfs2_validate_group_descriptor(inode->i_sb, tmp);
+		if (rc)
+			goto free_bh;
+	}
+
+	rc = ocfs2_validate_gd_parent(inode->i_sb, di, tmp, 0);
+	if (rc)
+		goto free_bh;
+
+	/* If ocfs2_read_block() got us a new bh, pass it up. */
+	if (!*bh)
+		*bh = tmp;
+
+	return rc;
+
+free_bh:
+	brelse(tmp);
+out:
+	return rc;
+}
+
 int ocfs2_read_group_descriptor(struct inode *inode, struct ocfs2_dinode *di,
 				u64 gd_blkno, struct buffer_head **bh)
 {
@@ -1722,7 +1784,7 @@ static int ocfs2_search_one_group(struct ocfs2_alloc_context *ac,
 				  u32 bits_wanted,
 				  u32 min_bits,
 				  struct ocfs2_suballoc_result *res,
-				  u16 *bits_left)
+				  u16 *bits_left, int *released)
 {
 	int ret;
 	struct buffer_head *group_bh = NULL;
@@ -1730,9 +1792,11 @@ static int ocfs2_search_one_group(struct ocfs2_alloc_context *ac,
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)ac->ac_bh->b_data;
 	struct inode *alloc_inode = ac->ac_inode;
 
-	ret = ocfs2_read_group_descriptor(alloc_inode, di,
-					  res->sr_bg_blkno, &group_bh);
-	if (ret < 0) {
+	ret = ocfs2_read_hint_group_descriptor(alloc_inode, di,
+				res->sr_bg_blkno, &group_bh, released);
+	if (*released) {
+		return 0;
+	} else if (ret < 0) {
 		mlog_errno(ret);
 		return ret;
 	}
@@ -1934,7 +1998,7 @@ static int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *ac,
 				     u32 min_bits,
 				     struct ocfs2_suballoc_result *res)
 {
-	int status;
+	int status, released;
 	u16 victim, i;
 	u16 bits_left = 0;
 	u64 hint = ac->ac_last_group;
@@ -1961,6 +2025,7 @@ static int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *ac,
 		goto bail;
 	}
 
+	/* the hint bg may already be released, we quiet search this group. */
 	res->sr_bg_blkno = hint;
 	if (res->sr_bg_blkno) {
 		/* Attempt to short-circuit the usual search mechanism
@@ -1968,7 +2033,12 @@ static int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *ac,
 		 * allocation group. This helps us maintain some
 		 * contiguousness across allocations. */
 		status = ocfs2_search_one_group(ac, handle, bits_wanted,
-						min_bits, res, &bits_left);
+						min_bits, res, &bits_left,
+						&released);
+		if (released) {
+			res->sr_bg_blkno = 0;
+			goto chain_search;
+		}
 		if (!status)
 			goto set_hint;
 		if (status < 0 && status != -ENOSPC) {
@@ -1976,7 +2046,7 @@ static int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *ac,
 			goto bail;
 		}
 	}
-
+chain_search:
 	cl = (struct ocfs2_chain_list *) &fe->id2.i_chain;
 
 	victim = ocfs2_find_victim_chain(cl);
@@ -2077,6 +2147,12 @@ int ocfs2_claim_metadata(handle_t *handle,
 	return status;
 }
 
+/*
+ * after ocfs2 has the ability to release block group unused space,
+ * the ->ip_last_used_group may be invalid. so this function returns
+ * ac->ac_last_group need to verify.
+ * refer the 'hint' in ocfs2_claim_suballoc_bits() for more details.
+ */
 static void ocfs2_init_inode_ac_group(struct inode *dir,
 				      struct buffer_head *parent_di_bh,
 				      struct ocfs2_alloc_context *ac)
@@ -2514,6 +2590,197 @@ static int ocfs2_block_group_clear_bits(handle_t *handle,
 	return status;
 }
 
+/*
+ * Reclaim the suballocator managed space to main bitmap.
+ * This function first works on the suballocator then switch to the
+ * main bitmap.
+ *
+ * handle: The transaction handle
+ * alloc_inode: The suballoc inode
+ * alloc_bh: The buffer_head of suballoc inode
+ * group_bh: The group descriptor buffer_head of suballocator managed.
+ *           Caller should release the input group_bh.
+ */
+static int _reclaim_to_main_bm(handle_t *handle,
+			struct inode *alloc_inode,
+			struct buffer_head *alloc_bh,
+			struct buffer_head *group_bh)
+{
+	int idx, status = 0;
+	int i, next_free_rec, len = 0;
+	__le16 old_bg_contig_free_bits = 0;
+	u16 start_bit;
+	u32 tmp_used;
+	u64 bg_blkno, start_blk;
+	unsigned int count;
+	struct ocfs2_chain_rec *rec;
+	struct buffer_head *main_bm_bh = NULL;
+	struct inode *main_bm_inode = NULL;
+	struct ocfs2_super *osb = OCFS2_SB(alloc_inode->i_sb);
+	struct ocfs2_dinode *fe = (struct ocfs2_dinode *) alloc_bh->b_data;
+	struct ocfs2_chain_list *cl = &fe->id2.i_chain;
+	struct ocfs2_group_desc *group = (struct ocfs2_group_desc *) group_bh->b_data;
+
+	idx = le16_to_cpu(group->bg_chain);
+	rec = &(cl->cl_recs[idx]);
+
+	status = ocfs2_extend_trans(handle,
+				ocfs2_calc_group_alloc_credits(osb->sb,
+						 le16_to_cpu(cl->cl_cpg)));
+	if (status) {
+		mlog_errno(status);
+		goto bail;
+	}
+	status = ocfs2_journal_access_di(handle, INODE_CACHE(alloc_inode),
+					 alloc_bh, OCFS2_JOURNAL_ACCESS_WRITE);
+	if (status < 0) {
+		mlog_errno(status);
+		goto bail;
+	}
+
+	/*
+	 * Only clear the suballocator rec item in-place.
+	 *
+	 * If idx is not the last, we don't compress (remove the empty item)
+	 * the cl_recs[]. If not, we need to do lots jobs.
+	 *
+	 * Compress cl_recs[] code example:
+	 * if (idx != cl->cl_next_free_rec - 1)
+	 * 	memmove(&cl->cl_recs[idx], &cl->cl_recs[idx + 1],
+	 * 		sizeof(struct ocfs2_chain_rec) *
+	 * 		(cl->cl_next_free_rec - idx - 1));
+	 * for(i = idx; i < cl->cl_next_free_rec-1; i++) {
+	 * 	group->bg_chain = "later group->bg_chain";
+	 * 	group->bg_blkno = xxx;
+	 * 	... ...
+	 * }
+	 */
+
+	tmp_used = le32_to_cpu(fe->id1.bitmap1.i_total);
+	fe->id1.bitmap1.i_total = cpu_to_le32(tmp_used - le32_to_cpu(rec->c_total));
+
+	/* Substraction 1 for the block group itself */
+	tmp_used = le32_to_cpu(fe->id1.bitmap1.i_used);
+	fe->id1.bitmap1.i_used = cpu_to_le32(tmp_used - 1);
+
+	tmp_used = le32_to_cpu(fe->i_clusters);
+	fe->i_clusters = cpu_to_le32(tmp_used - le16_to_cpu(cl->cl_cpg));
+
+	spin_lock(&OCFS2_I(alloc_inode)->ip_lock);
+	OCFS2_I(alloc_inode)->ip_clusters -= le32_to_cpu(fe->i_clusters);
+	fe->i_size = cpu_to_le64(ocfs2_clusters_to_bytes(alloc_inode->i_sb,
+					     le32_to_cpu(fe->i_clusters)));
+	spin_unlock(&OCFS2_I(alloc_inode)->ip_lock);
+	i_size_write(alloc_inode, le64_to_cpu(fe->i_size));
+	alloc_inode->i_blocks = ocfs2_inode_sector_count(alloc_inode);
+
+	ocfs2_journal_dirty(handle, alloc_bh);
+	ocfs2_update_inode_fsync_trans(handle, alloc_inode, 0);
+
+	start_blk = le64_to_cpu(rec->c_blkno);
+	count = le32_to_cpu(rec->c_total) / le16_to_cpu(cl->cl_bpc);
+
+	/*
+	 * If the rec is the last one, let's compress the chain list by
+	 * removing the empty cl_recs[] at the end.
+	 */
+	next_free_rec = le16_to_cpu(cl->cl_next_free_rec);
+	if (idx == (next_free_rec - 1)) {
+		len++; /* the last item should be counted first */
+		for (i = (next_free_rec - 2); i > 0; i--) {
+			if (cl->cl_recs[i].c_free == cl->cl_recs[i].c_total)
+				len++;
+			else
+				break;
+		}
+	}
+	le16_add_cpu(&cl->cl_next_free_rec, -len);
+
+	rec->c_free = 0;
+	rec->c_total = 0;
+	rec->c_blkno = 0;
+	ocfs2_remove_from_cache(INODE_CACHE(alloc_inode), group_bh);
+	memset(group, 0, sizeof(struct ocfs2_group_desc));
+
+	/* prepare job for reclaim clusters */
+	main_bm_inode = ocfs2_get_system_file_inode(osb,
+						    GLOBAL_BITMAP_SYSTEM_INODE,
+						    OCFS2_INVALID_SLOT);
+	if (!main_bm_inode)
+		goto bail; /* ignore the error in reclaim path */
+
+	inode_lock(main_bm_inode);
+
+	status = ocfs2_inode_lock(main_bm_inode, &main_bm_bh, 1);
+	if (status < 0)
+		goto free_bm_inode; /* ignore the error in reclaim path */
+
+	ocfs2_block_to_cluster_group(main_bm_inode, start_blk, &bg_blkno,
+				     &start_bit);
+	fe = (struct ocfs2_dinode *) main_bm_bh->b_data;
+	cl = &fe->id2.i_chain;
+	/* reuse group_bh, caller will release the input group_bh */
+	group_bh = NULL;
+
+	/* reclaim clusters to global_bitmap */
+	status = ocfs2_read_group_descriptor(main_bm_inode, fe, bg_blkno,
+					     &group_bh);
+	if (status < 0) {
+		mlog_errno(status);
+		goto free_bm_bh;
+	}
+	group = (struct ocfs2_group_desc *) group_bh->b_data;
+
+	if ((count + start_bit) > le16_to_cpu(group->bg_bits)) {
+		ocfs2_error(alloc_inode->i_sb,
+			"reclaim length (%d) beyands block group length (%d)",
+			count + start_bit, le16_to_cpu(group->bg_bits));
+		goto free_group_bh;
+	}
+
+	old_bg_contig_free_bits = group->bg_contig_free_bits;
+	status = ocfs2_block_group_clear_bits(handle, main_bm_inode,
+					      group, group_bh,
+					      start_bit, count, 0,
+					      _ocfs2_clear_bit);
+	if (status < 0) {
+		mlog_errno(status);
+		goto free_group_bh;
+	}
+
+	status = ocfs2_journal_access_di(handle, INODE_CACHE(main_bm_inode),
+					 main_bm_bh, OCFS2_JOURNAL_ACCESS_WRITE);
+	if (status < 0) {
+		mlog_errno(status);
+		ocfs2_block_group_set_bits(handle, main_bm_inode, group, group_bh,
+				start_bit, count,
+				le16_to_cpu(old_bg_contig_free_bits), 1);
+		goto free_group_bh;
+	}
+
+	idx = le16_to_cpu(group->bg_chain);
+	rec = &(cl->cl_recs[idx]);
+
+	le32_add_cpu(&rec->c_free, count);
+	tmp_used = le32_to_cpu(fe->id1.bitmap1.i_used);
+	fe->id1.bitmap1.i_used = cpu_to_le32(tmp_used - count);
+	ocfs2_journal_dirty(handle, main_bm_bh);
+
+free_group_bh:
+	brelse(group_bh);
+
+free_bm_bh:
+	ocfs2_inode_unlock(main_bm_inode, 1);
+	brelse(main_bm_bh);
+
+free_bm_inode:
+	inode_unlock(main_bm_inode);
+	iput(main_bm_inode);
+
+bail:
+	return status;
+}
+
 /*
  * expects the suballoc inode to already be locked.
  */
@@ -2526,12 +2793,13 @@ static int _ocfs2_free_suballoc_bits(handle_t *handle,
 				     void (*undo_fn)(unsigned int bit,
 						     unsigned long *bitmap))
 {
-	int status = 0;
+	int idx, status = 0;
 	u32 tmp_used;
 	struct ocfs2_dinode *fe = (struct ocfs2_dinode *) alloc_bh->b_data;
 	struct ocfs2_chain_list *cl = &fe->id2.i_chain;
 	struct buffer_head *group_bh = NULL;
 	struct ocfs2_group_desc *group;
+	struct ocfs2_chain_rec *rec;
 	__le16 old_bg_contig_free_bits = 0;
 
 	/* The alloc_bh comes from ocfs2_free_dinode() or
@@ -2577,12 +2845,26 @@ static int _ocfs2_free_suballoc_bits(handle_t *handle,
 		goto bail;
 	}
 
-	le32_add_cpu(&cl->cl_recs[le16_to_cpu(group->bg_chain)].c_free,
-		     count);
+	idx = le16_to_cpu(group->bg_chain);
+	rec = &(cl->cl_recs[idx]);
+
+	le32_add_cpu(&rec->c_free, count);
 	tmp_used = le32_to_cpu(fe->id1.bitmap1.i_used);
 	fe->id1.bitmap1.i_used = cpu_to_le32(tmp_used - count);
 	ocfs2_journal_dirty(handle, alloc_bh);
 
+	/*
+	 * Reclaim suballocator free space.
+	 * Bypass: global_bitmap, not empty rec, first rec in cl_recs[]
+	 */
+	if (ocfs2_is_cluster_bitmap(alloc_inode) ||
+	    (le32_to_cpu(rec->c_free) != (le32_to_cpu(rec->c_total) - 1)) ||
+	    (le16_to_cpu(cl->cl_next_free_rec) == 1)) {
+		goto bail;
+	}
+
+	_reclaim_to_main_bm(handle, alloc_inode, alloc_bh, group_bh);
+
 bail:
 	brelse(group_bh);
 	return status;
-- 
2.35.3


