Return-Path: <linux-kernel+bounces-239419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31F1925F81
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0C51F2585D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B6613776F;
	Wed,  3 Jul 2024 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="moZKxYPC"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B71799F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008066; cv=none; b=ZAKbvwZNsy8/vkUgvgvYYVBEXnuY/NXH+ptXFbtMjY9p3+o14zY6WShdiA7uUfXsErtFA3vHuUhYWJBTS/LOCohVqOJvbul5a3oNFz3lnMVuniGVysReplTzd510ef1t/EAX6jM0+CdboRvCaKHt9A7FBodp5o3gx7BPqSV/oAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008066; c=relaxed/simple;
	bh=PJNqnHRNjbAmcodtqFt2m8PjSDxf+QLuaASGsAPclzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYJtE0PUBnhP2GuSTcr5Fn9ImaXlWlbGTn3nXvs+b2ZsX/le+1QaateBUB1qhe3sLVrdHo54vKZsx5Bha0tcOHOk2+E1ntAqNrf5uIygaDkTOn8I3MVx/PbV9zwrUZmhhO0wlEZlpatFhCNHCkZmY3wTzErzl8UTnEVMf7edvD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=moZKxYPC; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720008058; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1i4erAiWQKdAm3mPcp8cVYibLOdhqUaMMMiBWx4rFII=;
	b=moZKxYPC8BMLnMGSCI+5N3ZXrj7DXrKxLLXLZETzsKTwkYoKvaZXg09n6y5BVQeLsSynLc5co1Kr1AXZKQQqkWTIQrNOmwVwZiAi+5YAZsmTP69b2EPXt1gGVRbv0+5ibD8KoQsvZjnceartTrsM6IwW9qoX4MjQIEMQWw8OmOc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W9mSOML_1720008057;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9mSOML_1720008057)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 20:00:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/4] erofs: convert z_erofs_read_fragment() to folios
Date: Wed,  3 Jul 2024 20:00:49 +0800
Message-ID: <20240703120051.3653452-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240703120051.3653452-1-hsiangkao@linux.alibaba.com>
References: <20240703120051.3653452-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a straight-forward conversion.  No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 14cf96fcefe4..4b1715d8c122 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -925,7 +925,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	fe->pcl = NULL;
 }
 
-static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
+static int z_erofs_read_fragment(struct super_block *sb, struct folio *folio,
 			unsigned int cur, unsigned int end, erofs_off_t pos)
 {
 	struct inode *packed_inode = EROFS_SB(sb)->packed_inode;
@@ -938,14 +938,13 @@ static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
 
 	buf.mapping = packed_inode->i_mapping;
 	for (; cur < end; cur += cnt, pos += cnt) {
-		cnt = min_t(unsigned int, end - cur,
-			    sb->s_blocksize - erofs_blkoff(sb, pos));
+		cnt = min(end - cur, sb->s_blocksize - erofs_blkoff(sb, pos));
 		src = erofs_bread(&buf, pos, EROFS_KMAP);
 		if (IS_ERR(src)) {
 			erofs_put_metabuf(&buf);
 			return PTR_ERR(src);
 		}
-		memcpy_to_page(page, cur, src, cnt);
+		memcpy_to_folio(folio, cur, src, cnt);
 	}
 	erofs_put_metabuf(&buf);
 	return 0;
@@ -959,7 +958,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *fe,
 	const loff_t offset = folio_pos(folio);
 	const unsigned int bs = i_blocksize(inode), fs = folio_size(folio);
 	bool tight = true, exclusive;
-	unsigned int cur, end, len, split;
+	unsigned int cur, end, split;
 	int err = 0;
 
 	z_erofs_onlinefolio_init(folio);
@@ -989,9 +988,9 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *fe,
 	if (map->m_flags & EROFS_MAP_FRAGMENT) {
 		erofs_off_t fpos = offset + cur - map->m_la;
 
-		len = min_t(unsigned int, map->m_llen - fpos, end - cur);
-		err = z_erofs_read_fragment(inode->i_sb, &folio->page, cur,
-			cur + len, EROFS_I(inode)->z_fragmentoff + fpos);
+		err = z_erofs_read_fragment(inode->i_sb, folio, cur,
+				cur + min(map->m_llen - fpos, end - cur),
+				EROFS_I(inode)->z_fragmentoff + fpos);
 		if (err)
 			goto out;
 		tight = false;
-- 
2.43.5


