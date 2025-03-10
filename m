Return-Path: <linux-kernel+bounces-553902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B466A5906C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9325616C210
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430D2225A29;
	Mon, 10 Mar 2025 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YT0MHLRA"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0429225408
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600522; cv=none; b=nY9tC2Wmk7OxA2YE6hhkgsAoH+AhND6hNAG+behzxfT4cMMIbhALFcr2IyRnNX8VCO4R+7r31DFQCB7qEKFpxv+0YoLWsTUjoXWIhhHV6gbNLLHZRyzPILQ5RrzDRKdYUFpmSLdrLejIBdl5XBbN3Ezpg6nfvU1h/fehVVEPpdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600522; c=relaxed/simple;
	bh=4O0BS8duQ8hRgCRKbS/GapkPLCFWUBWhUjVnncjM+6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYYl3RpiKlIX8veDOna424Sd9RHuycjvHJLktENfHRrmPJMaeKFx00XQ531awkvNOeNAbcv7zWeYBg6PapGw7VOZncr/adcemZt4WtNN6X1n+PfHnch0Y7+w6460yOIgB9mTETQg+HCF7vcNmqZjhUmdj2+CTGby7w3osMt/Urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YT0MHLRA; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741600512; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8HUn6nXby9y1Idtt+UidKIGNy4BBNN0fCgY5e/PE3Jk=;
	b=YT0MHLRAlgH2Gg4R2V/w6QNBTgcAd6MBGjwn0w0rUxi85HF5FZ5YYPxxdQB8GLxss/5zNRfpm1VZVTV7W6b8mEgldZ15CAgYUOY2ErKm64wxVDjbrCIwaj2MYFcrAqhXav1CXWNt3tMsFBjqKODo7nLe1+P7ngaSo6ArOxvAASI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR1F4-p_1741600511 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:55:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 08/10] erofs: implement encoded extent metadata
Date: Mon, 10 Mar 2025 17:54:58 +0800
Message-ID: <20250310095459.2620647-9-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
References: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the extent metadata parsing described in the previous commit.
For 16-byte and 32-byte extent records, currently it is just a trivial
binary search without considering the last access footprint, but it can
be optimized for better sequential performance later.

Tail fragments are supported, but ztailpacking feature is not
for simplicity.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h |   5 +-
 fs/erofs/zmap.c     | 142 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 135 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f26191fe148b..4ac188d5d894 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -263,7 +263,10 @@ struct erofs_inode {
 			unsigned short z_advise;
 			unsigned char  z_algorithmtype[2];
 			unsigned char  z_lclusterbits;
-			unsigned long  z_tailextent_headlcn;
+			union {
+				u64    z_tailextent_headlcn;
+				u64    z_extents;
+			};
 			erofs_off_t    z_fragmentoff;
 			unsigned short z_idata_size;
 		};
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 25d3fa8e70d8..8de50df05dfe 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -391,7 +391,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 	return 0;
 }
 
-static int z_erofs_do_map_blocks(struct inode *inode,
+static int z_erofs_map_blocks_fo(struct inode *inode,
 				 struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
@@ -409,6 +409,14 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	unsigned long long ofs, end;
 
 	ofs = flags & EROFS_GET_BLOCKS_FINDTAIL ? inode->i_size - 1 : map->m_la;
+	if (fragment && !(flags & EROFS_GET_BLOCKS_FINDTAIL) &&
+	    !vi->z_tailextent_headlcn) {
+		map->m_la = 0;
+		map->m_llen = inode->i_size;
+		map->m_flags = EROFS_MAP_MAPPED |
+			EROFS_MAP_FULL_MAPPED | EROFS_MAP_FRAGMENT;
+		return 0;
+	}
 	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
@@ -526,6 +534,115 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	return err;
 }
 
+static int z_erofs_map_blocks_ext(struct inode *inode,
+				  struct erofs_map_blocks *map, int flags)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct super_block *sb = inode->i_sb;
+	bool interlaced = vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
+	unsigned int recsz = z_erofs_extent_recsize(vi->z_advise);
+	erofs_off_t pos = round_up(Z_EROFS_MAP_HEADER_END(erofs_iloc(inode) +
+				   vi->inode_isize + vi->xattr_isize), recsz);
+	erofs_off_t lend = inode->i_size;
+	erofs_off_t l, r, mid, pa, la, lstart;
+	struct z_erofs_extent *ext;
+	unsigned int fmt;
+	bool last;
+
+	map->m_flags = 0;
+	if (recsz <= offsetof(struct z_erofs_extent, pstart_hi)) {
+		if (recsz <= offsetof(struct z_erofs_extent, pstart_lo)) {
+			ext = erofs_read_metabuf(&map->buf, sb, pos, true);
+			if (IS_ERR(ext))
+				return PTR_ERR(ext);
+			pa = le64_to_cpu(*(__le64 *)ext);
+			pos += sizeof(__le64);
+			lstart = 0;
+		} else {
+			lstart = map->m_la >> vi->z_lclusterbits;
+			pa = EROFS_NULL_ADDR;
+		}
+
+		for (; lstart <= map->m_la; lstart += 1 << vi->z_lclusterbits) {
+			ext = erofs_read_metabuf(&map->buf, sb, pos, true);
+			if (IS_ERR(ext))
+				return PTR_ERR(ext);
+			map->m_plen = le32_to_cpu(ext->plen);
+			if (pa != EROFS_NULL_ADDR) {
+				map->m_pa = pa;
+				pa += map->m_plen & Z_EROFS_EXTENT_PLEN_MASK;
+			} else {
+				map->m_pa = le32_to_cpu(ext->pstart_lo);
+			}
+			pos += recsz;
+		}
+		last = (lstart >= round_up(lend, 1 << vi->z_lclusterbits));
+		lend = min(lstart, lend);
+		lstart -= 1 << vi->z_lclusterbits;
+	} else {
+		lstart = lend;
+		for (l = 0, r = vi->z_extents; l < r; ) {
+			mid = l + (r - l) / 2;
+			ext = erofs_read_metabuf(&map->buf, sb,
+						 pos + mid * recsz, true);
+			if (IS_ERR(ext))
+				return PTR_ERR(ext);
+
+			la = le32_to_cpu(ext->lstart_lo);
+			pa = le32_to_cpu(ext->pstart_lo) |
+				(u64)le32_to_cpu(ext->pstart_hi) << 32;
+			if (recsz > offsetof(struct z_erofs_extent, lstart_hi))
+				la |= (u64)le32_to_cpu(ext->lstart_hi) << 32;
+
+			if (la > map->m_la) {
+				r = mid;
+				lend = la;
+			} else {
+				l = mid + 1;
+				if (map->m_la == la)
+					r = min(l + 1, r);
+				lstart = la;
+				map->m_plen = le32_to_cpu(ext->plen);
+				map->m_pa = pa;
+			}
+		}
+		last = (l >= vi->z_extents);
+	}
+
+	if (lstart < lend) {
+		map->m_la = lstart;
+		if (last && (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
+			map->m_flags |= EROFS_MAP_MAPPED | EROFS_MAP_FRAGMENT;
+			vi->z_fragmentoff = map->m_plen;
+			if (recsz >= offsetof(struct z_erofs_extent, pstart_lo))
+				vi->z_fragmentoff |= map->m_pa << 32;
+		} else if (map->m_plen) {
+			map->m_flags |= EROFS_MAP_MAPPED |
+				EROFS_MAP_FULL_MAPPED | EROFS_MAP_ENCODED;
+			fmt = map->m_plen >> Z_EROFS_EXTENT_PLEN_FMT_BIT;
+			if (fmt)
+				map->m_algorithmformat = fmt - 1;
+			else if (interlaced && !erofs_blkoff(sb, map->m_pa))
+				map->m_algorithmformat =
+					Z_EROFS_COMPRESSION_INTERLACED;
+			else
+				map->m_algorithmformat =
+					Z_EROFS_COMPRESSION_SHIFTED;
+			if (map->m_plen & Z_EROFS_EXTENT_PLEN_PARTIAL)
+				map->m_flags |= EROFS_MAP_PARTIAL_REF;
+			map->m_plen &= Z_EROFS_EXTENT_PLEN_MASK;
+		}
+	}
+	map->m_llen = lend - map->m_la;
+	if (!last && map->m_llen < sb->s_blocksize) {
+		erofs_err(sb, "extent too small %llu @ offset %llu of nid %llu",
+			  map->m_llen, map->m_la, vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+	return 0;
+}
+
 static int z_erofs_fill_inode_lazy(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -570,6 +687,13 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	}
 	vi->z_advise = le16_to_cpu(h->h_advise);
 	vi->z_lclusterbits = sb->s_blocksize_bits + (h->h_clusterbits & 15);
+	if (vi->datalayout == EROFS_INODE_COMPRESSED_FULL &&
+	    (vi->z_advise & Z_EROFS_ADVISE_EXTENTS)) {
+		vi->z_extents = le32_to_cpu(h->h_extents_lo) |
+			((u64)le16_to_cpu(h->h_extents_hi) << 32);
+		goto done;
+	}
+
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
 	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
@@ -609,7 +733,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 			.buf = __EROFS_BUF_INITIALIZER
 		};
 
-		err = z_erofs_do_map_blocks(inode, &map,
+		err = z_erofs_map_blocks_fo(inode, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		erofs_put_metabuf(&map.buf);
 		if (err < 0)
@@ -640,15 +764,11 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 	} else {
 		err = z_erofs_fill_inode_lazy(inode);
 		if (!err) {
-			if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
-			    !vi->z_tailextent_headlcn) {
-				map->m_la = 0;
-				map->m_llen = inode->i_size;
-				map->m_flags = EROFS_MAP_MAPPED |
-					EROFS_MAP_FULL_MAPPED | EROFS_MAP_FRAGMENT;
-			} else {
-				err = z_erofs_do_map_blocks(inode, map, flags);
-			}
+			if (vi->datalayout == EROFS_INODE_COMPRESSED_FULL &&
+			    (vi->z_advise & Z_EROFS_ADVISE_EXTENTS))
+				err = z_erofs_map_blocks_ext(inode, map, flags);
+			else
+				err = z_erofs_map_blocks_fo(inode, map, flags);
 		}
 		if (!err && (map->m_flags & EROFS_MAP_ENCODED) &&
 		    unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
-- 
2.43.5


