Return-Path: <linux-kernel+bounces-400881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602DB9C1397
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0481C22792
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ECF1BC3F;
	Fri,  8 Nov 2024 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otscWSYf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3C17BBF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029168; cv=none; b=G5sKSBwev2zS9SUegehDkfBlslxpyuOC6MV89ft8siM872mj9n0xTvYCX3stvZZoD+xaCytj3ccfHLY6RCMC7ettVzVKT3Tb2uRJky1QiiSW8Y4a66Sb5PrA8aazP8q50blwztdt35QIgzHtdftO3if7EpLT3BQhbvzz9XPAbbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029168; c=relaxed/simple;
	bh=Xc48J3j8pFGdmACryyspUFhTaTgH3SnsHmTKA1qPrKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MtfQB/inPa7qXz9jjiM1zUXJYu9wsQsfGT584cH4q8gWdwT+enMvTRwYkbTUD25jEzi3jLAav6K4/aGZW/N58qpTaK/Jy6l2f6obJhcXgtWrzVAlicJOgFp2rNftCdiuVdNrrqyz6f9rubabWPGuWkXDSM2xwvKDALSOv/j9Hi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otscWSYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D6DC4CECC;
	Fri,  8 Nov 2024 01:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731029167;
	bh=Xc48J3j8pFGdmACryyspUFhTaTgH3SnsHmTKA1qPrKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=otscWSYftslmbZj1FnDbIZDhsQ6dNd7/oQ++yHRWDXVzW7v+xJpgSd0uuC6tDgoLb
	 IQgjQAr17xXj2A25Z+DSWgeDQslE51A3D6AsqyRkV2F3KyuZ4RmiX5fFDMbgUi/XXd
	 H79a/qsrcgFoUHeNgSKhfGkDpNWOcbXNQ3V8G0zfWdbdQFZrmYqAqnB4sHWTdNqg8w
	 mmvEncIEQw8HysLmfZA7E2XaovX+b7EHy1Hfexrko97uyjD0gfFSJcvrNesRM4yEno
	 NJUJ2HzoGUWX97eu0Hiu5FE7AkCIvI7gQH27xWjc4h84Fq80P3AfgQIJyBAgr9Nc7Q
	 xtP6FbL+PEUIQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: [PATCH 3/4] f2fs: fix to adjust appropriate length for fiemap
Date: Fri,  8 Nov 2024 09:25:56 +0800
Message-Id: <20241108012557.572782-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241108012557.572782-1-chao@kernel.org>
References: <20241108012557.572782-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

If user give a file size as "length" parameter for fiemap
operations, but if this size is non-block size aligned,
it will show 2 segments fiemap results even this whole file
is contiguous on disk, such as the following results:

 ./f2fs_io fiemap 0 19034 ylog/analyzer.py
Fiemap: offset = 0 len = 19034
        logical addr.    physical addr.   length           flags
0       0000000000000000 0000000020baa000 0000000000004000 00001000
1       0000000000004000 0000000020bae000 0000000000001000 00001001

after this patch:
./f2fs_io fiemap 0 19034 ylog/analyzer.py
Fiemap: offset = 0 len = 19034
    logical addr.    physical addr.   length           flags
0    0000000000000000 00000000315f3000 0000000000005000 00001001

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/data.c          | 6 +++---
 include/linux/f2fs_fs.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0e8390cbdb5b..69f1cb0490ee 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1938,12 +1938,12 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			goto out;
 	}
 
-	if (F2FS_BYTES_TO_BLK(len) == 0)
-		len = F2FS_BLKSIZE;
-
 	start_blk = F2FS_BYTES_TO_BLK(start);
 	last_blk = F2FS_BYTES_TO_BLK(start + len - 1);
 
+	if (len & F2FS_BLKSIZE_MASK)
+		len = round_up(len, F2FS_BLKSIZE);
+
 next:
 	memset(&map, 0, sizeof(map));
 	map.m_lblk = start_blk;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 3b2ad444c002..c24f8bc01045 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -24,6 +24,7 @@
 #define NEW_ADDR		((block_t)-1)	/* used as block_t addresses */
 #define COMPRESS_ADDR		((block_t)-2)	/* used as compressed data flag */
 
+#define F2FS_BLKSIZE_MASK		(F2FS_BLKSIZE - 1)
 #define F2FS_BYTES_TO_BLK(bytes)	((unsigned long long)(bytes) >> F2FS_BLKSIZE_BITS)
 #define F2FS_BLK_TO_BYTES(blk)		((unsigned long long)(blk) << F2FS_BLKSIZE_BITS)
 #define F2FS_BLK_END_BYTES(blk)		(F2FS_BLK_TO_BYTES(blk + 1) - 1)
-- 
2.40.1


