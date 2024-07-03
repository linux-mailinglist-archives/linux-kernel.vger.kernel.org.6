Return-Path: <linux-kernel+bounces-239420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B5A925F85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CF91C22E8A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4825C17557E;
	Wed,  3 Jul 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WIBagvox"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B66F13C3D3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008068; cv=none; b=CycJbisoxX7wEMEpo+JxaEGuKJUvhBpku1DK7XR+NwTZgIwCT5Mt46yZV32N4r8a2ecrTYShP8Aal3vwUj9INLGxKMFs8BkPESNaiNAppizYRbKronKOfl8pSV0BQPuL+L4N/Q76Zgt7te0fOkcFYbTyyHyOtRYXwMuUgGjplFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008068; c=relaxed/simple;
	bh=KBVPJJTZqkrCJKuo/Xo8HPhne3rj0hMqCQBr2l8rphI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eE3Qk44NRDcg1xqEW8XWQy32HF7QQplvTj36tKndT7bsHSr4PqJDwM8xgOZRnoV40iC46JGsihH0NX+uQUBzAQSRwNEG2MkJ5ZKAguBqPYfVRfJbrsvcSHo1j5ehXW+998Wt3994OCf4fIoE2yu4gJHZch1LUfwXBRtJzjvBWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WIBagvox; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720008057; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Mh46ks6775Y0MdbnW5K/y+3bA++N8lJEpXTZKZh0gJI=;
	b=WIBagvoxrb87tuh5Ni4GqCFjdgfJ1PU2Q1eG15ARUKVRuqixsD4VKOAO254umyNtFPEzhu07IIOWuX9rFqbAfkoI2sQuIpfnjwHxakCtRa6f9Wb6oHtjM8u9iRRU/qdcAx2cmAklcnK1kEA8VkF6taThikYia9MORwvxDc48aR4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W9mSOKS_1720008052;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9mSOKS_1720008052)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 20:00:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/4] erofs: convert z_erofs_pcluster_readmore() to folios
Date: Wed,  3 Jul 2024 20:00:48 +0800
Message-ID: <20240703120051.3653452-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike `pagecache_get_page()`, `__filemap_get_folio()` returns error
pointers instead of NULL, thus switching to `IS_ERR_OR_NULL`.

Apart from that, it's just a straightforward conversion.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h | 14 +++++---------
 fs/erofs/zdata.c    | 15 +++++++--------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0c1b44ac9524..9a72fcbc0b30 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -312,17 +312,13 @@ static inline unsigned int erofs_inode_datalayout(unsigned int ifmt)
 	return (ifmt >> EROFS_I_DATALAYOUT_BIT) & EROFS_I_DATALAYOUT_MASK;
 }
 
-/*
- * Different from grab_cache_page_nowait(), reclaiming is never triggered
- * when allocating new pages.
- */
-static inline
-struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
-					  pgoff_t index)
+/* reclaiming is never triggered when allocating new folios. */
+static inline struct folio *erofs_grab_folio_nowait(struct address_space *as,
+						    pgoff_t index)
 {
-	return pagecache_get_page(mapping, index,
+	return __filemap_get_folio(as, index,
 			FGP_LOCK|FGP_CREAT|FGP_NOFS|FGP_NOWAIT,
-			readahead_gfp_mask(mapping) & ~__GFP_RECLAIM);
+			readahead_gfp_mask(as) & ~__GFP_RECLAIM);
 }
 
 /* Has a disk mapping */
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d6fe002a4a71..14cf96fcefe4 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1767,7 +1767,6 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 		end = round_up(end, PAGE_SIZE);
 	} else {
 		end = round_up(map->m_la, PAGE_SIZE);
-
 		if (!map->m_llen)
 			return;
 	}
@@ -1775,15 +1774,15 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 	cur = map->m_la + map->m_llen - 1;
 	while ((cur >= end) && (cur < i_size_read(inode))) {
 		pgoff_t index = cur >> PAGE_SHIFT;
-		struct page *page;
+		struct folio *folio;
 
-		page = erofs_grab_cache_page_nowait(inode->i_mapping, index);
-		if (page) {
-			if (PageUptodate(page))
-				unlock_page(page);
+		folio = erofs_grab_folio_nowait(inode->i_mapping, index);
+		if (!IS_ERR_OR_NULL(folio)) {
+			if (folio_test_uptodate(folio))
+				folio_unlock(folio);
 			else
-				z_erofs_scan_folio(f, page_folio(page), !!rac);
-			put_page(page);
+				z_erofs_scan_folio(f, folio, !!rac);
+			folio_put(folio);
 		}
 
 		if (cur < PAGE_SIZE)
-- 
2.43.5


