Return-Path: <linux-kernel+bounces-448793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DD69F458C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2ECF7A516D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DA91D5AD9;
	Tue, 17 Dec 2024 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyPqUH6z"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE9FA29
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422158; cv=none; b=ZFHmsFEf4lgPGwmbcePJYv1c9vYJIsH5mjr0NB1tFmTvzq6g24QEe1SfBqeND8NzFTFjVLFGWeeyXjmo4HsFhvxwCGo5ia0cIe5aJlfrMmI3RWIOTiKRlPxtPXT8Kc+G7yc9aHoB8/Pl3UKLseHY8ruC+Pr36cpqPSGJfg7s+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422158; c=relaxed/simple;
	bh=KpFhqRJ2llPZe5zlFQJlvEHwc7R5SS3sqpjwModW+HE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QMJZ5/8mKVW+P5kjyLTLOAfFkctsVUO4Slv4QUvArRysgkFDILTxzpByN6eBvAipBy/ZjIsvgF1DWAzG+8cwTy5Ri0jTF63um2Z5okuOdVpLhS78lYMC5+NPA+XivjFHVx25k61WDYWJZAKMhpXPYGLuph7z56sD5JgvWCU8Z2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cyPqUH6z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725e6fe074eso7402443b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734422156; x=1735026956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uzkj+oZY7b1p5AsRN5+ESM/ySLflwyn0YjSlF+T1L78=;
        b=cyPqUH6zun+Z8E+oyeTolGcI75lqRE2F/ON3nYBYWL5vcCkSdQheAzPZrskcWBebtP
         JlIbWmBncdDwXkiA2bT9gsPuuK5lccYxxeBhF6P7EKVG+zDvidm1pXki0YxTubHHbpX6
         nUu+iNcF5bVCfstYlpL12JrZ4saP/xYFd38do5IeenzzX39n8eepDc4o1Wp/QTNh2qIH
         eHPDQQf2Y4sdoMCzm8Fiph+RiiBOJlQ6rssV2LFKHM1WnU/qgzyzJQU+QN6mp/fnS6hB
         Q+4jVC+UA5pN+qvIlvN88GRv4pv5E6vxKFNjMr1ala3mFCIxU4Z8g338k3UOLP0vgi28
         yoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734422156; x=1735026956;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uzkj+oZY7b1p5AsRN5+ESM/ySLflwyn0YjSlF+T1L78=;
        b=k4X10Gz0IPN5C/fuP94bIOUVYutcx6cWnaZc5+Q08jQfhdCGGIW6BQ7v2M+WywN+tT
         SYJ2bIt9EJAw7dhKG2EPvauPJ5dFZ9L6mB8/CZJ1S1cic5HLh+V4ppqKVSPx4L4vY9pc
         509WGCDFx6SmV32LUCbT4tRKLyLKlzlpwvAd3DnI3CTL0A72mn7p3xIcvd9OXmESc6tm
         hJnazp1YCH0Bh0nNGngRD8XCfh/KqVxjGqjA0o7veStY+xUZel3cAC6nCNQnwK9BgtQT
         tznjEVx/TdK4uxl9+w21VvqFOiaeHcFNRuv2QotcKIvVx5grduAqDqqmGp+EU+eyCThm
         OXpw==
X-Forwarded-Encrypted: i=1; AJvYcCXKkbB9rs0qvtZW8fq7ES3I4Y6fBtw+nC96B2b967wJIi5RMrLNHINHoGKYt1CTF6owIjiGCotuKuxiAyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymDMe7oVCUCkPnlnYPRtGiUYZcShcQ+X85unpOb/a9bNiNCU8E
	5Cq9zhqsxEG58Hb7QcHTSgnNO700VHgTG3WNRfk7XPjAxLXbbMv0eu6zTOUqbSMrNiUPK3NCqiH
	Nf/uXVA==
X-Google-Smtp-Source: AGHT+IF2ZLNc9VJ2YJ+9NeEf33wUsyKisCQHejynIqB7XOQN3U9wu0RWjogWkI1guDFhQi+tt9OQ7YYD+A1T
X-Received: from pfcg20.prod.google.com ([2002:a05:6a00:23d4:b0:727:3cbd:60ac])
 (user=chullee job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1591:b0:1e1:bdae:e04d
 with SMTP id adf61e73a8af0-1e1dfe2264amr23361219637.36.1734422156154; Mon, 16
 Dec 2024 23:55:56 -0800 (PST)
Date: Mon, 16 Dec 2024 23:55:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217075552.1167994-1-chullee@google.com>
Subject: [PATCH] f2fs: Introduce linear search for dentries
From: Daniel Lee <chullee@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Daniel Lee <chullee@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch addresses an issue where some files in case-insensitive
directories become inaccessible due to changes in how the kernel function,
utf8_casefold(), generates case-folded strings from the commit 5c26d2f1d3f5
("unicode: Don't special case ignorable code points").

F2FS uses these case-folded names to calculate hash values for locating
dentries and stores them on disk. Since utf8_casefold() can produce
different output across kernel versions, stored hash values and newly
calculated hash values may differ. This results in affected files no
longer being found via the hash-based lookup.

To resolve this, the patch introduces a linear search fallback.
If the initial hash-based search fails, F2FS will sequentially scan the
directory entries.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219586
Signed-off-by: Daniel Lee <chullee@google.com>
---
 fs/f2fs/dir.c    | 38 ++++++++++++++++++++++++++++----------
 fs/f2fs/f2fs.h   |  6 ++++--
 fs/f2fs/inline.c |  5 +++--
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 47a5c806cf16..a85d19b4e178 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -175,7 +175,8 @@ static unsigned long dir_block_index(unsigned int level,
 static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 				struct page *dentry_page,
 				const struct f2fs_filename *fname,
-				int *max_slots)
+				int *max_slots,
+				bool use_hash)
 {
 	struct f2fs_dentry_block *dentry_blk;
 	struct f2fs_dentry_ptr d;
@@ -183,7 +184,7 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 	dentry_blk = (struct f2fs_dentry_block *)page_address(dentry_page);
 
 	make_dentry_ptr_block(dir, &d, dentry_blk);
-	return f2fs_find_target_dentry(&d, fname, max_slots);
+	return f2fs_find_target_dentry(&d, fname, max_slots, use_hash);
 }
 
 static inline int f2fs_match_name(const struct inode *dir,
@@ -208,7 +209,8 @@ static inline int f2fs_match_name(const struct inode *dir,
 }
 
 struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
-			const struct f2fs_filename *fname, int *max_slots)
+			const struct f2fs_filename *fname, int *max_slots,
+			bool use_hash)
 {
 	struct f2fs_dir_entry *de;
 	unsigned long bit_pos = 0;
@@ -231,7 +233,7 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
 			continue;
 		}
 
-		if (de->hash_code == fname->hash) {
+		if (!use_hash || de->hash_code == fname->hash) {
 			res = f2fs_match_name(d->inode, fname,
 					      d->filename[bit_pos],
 					      le16_to_cpu(de->name_len));
@@ -258,11 +260,12 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
 static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 					unsigned int level,
 					const struct f2fs_filename *fname,
-					struct page **res_page)
+					struct page **res_page,
+					bool use_hash)
 {
 	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
 	unsigned int nbucket, nblock;
-	unsigned int bidx, end_block;
+	unsigned int bidx, end_block, bucket_no;
 	struct page *dentry_page;
 	struct f2fs_dir_entry *de = NULL;
 	pgoff_t next_pgofs;
@@ -272,8 +275,11 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
 	nblock = bucket_blocks(level);
 
+	bucket_no = use_hash ? le32_to_cpu(fname->hash) % nbucket : 0;
+
+start_find_bucket:
 	bidx = dir_block_index(level, F2FS_I(dir)->i_dir_level,
-			       le32_to_cpu(fname->hash) % nbucket);
+			       bucket_no);
 	end_block = bidx + nblock;
 
 	while (bidx < end_block) {
@@ -290,7 +296,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 			}
 		}
 
-		de = find_in_block(dir, dentry_page, fname, &max_slots);
+		de = find_in_block(dir, dentry_page, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
 			*res_page = ERR_CAST(de);
 			de = NULL;
@@ -307,6 +313,9 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 		bidx++;
 	}
 
+	if (!use_hash && !de && ++bucket_no < nbucket)
+		goto start_find_bucket;
+
 	if (!de && room && F2FS_I(dir)->chash != fname->hash) {
 		F2FS_I(dir)->chash = fname->hash;
 		F2FS_I(dir)->clevel = level;
@@ -323,11 +332,13 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	struct f2fs_dir_entry *de = NULL;
 	unsigned int max_depth;
 	unsigned int level;
+	bool use_hash = true;
 
 	*res_page = NULL;
 
+start_find_entry:
 	if (f2fs_has_inline_dentry(dir)) {
-		de = f2fs_find_in_inline_dir(dir, fname, res_page);
+		de = f2fs_find_in_inline_dir(dir, fname, res_page, use_hash);
 		goto out;
 	}
 
@@ -343,11 +354,18 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	}
 
 	for (level = 0; level < max_depth; level++) {
-		de = find_in_level(dir, level, fname, res_page);
+		de = find_in_level(dir, level, fname, res_page, use_hash);
 		if (de || IS_ERR(*res_page))
 			break;
 	}
+
 out:
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (IS_CASEFOLDED(dir) && !de && use_hash) {
+		use_hash = false;
+		goto start_find_entry;
+	}
+#endif
 	/* This is to increase the speed of f2fs_create */
 	if (!de)
 		F2FS_I(dir)->task = current;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f523dd302bf6..1afebb9c4061 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3588,7 +3588,8 @@ int f2fs_prepare_lookup(struct inode *dir, struct dentry *dentry,
 			struct f2fs_filename *fname);
 void f2fs_free_filename(struct f2fs_filename *fname);
 struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
-			const struct f2fs_filename *fname, int *max_slots);
+			const struct f2fs_filename *fname, int *max_slots,
+			bool use_hash);
 int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			unsigned int start_pos, struct fscrypt_str *fstr);
 void f2fs_do_make_empty_dir(struct inode *inode, struct inode *parent,
@@ -4224,7 +4225,8 @@ int f2fs_write_inline_data(struct inode *inode, struct folio *folio);
 int f2fs_recover_inline_data(struct inode *inode, struct page *npage);
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 					const struct f2fs_filename *fname,
-					struct page **res_page);
+					struct page **res_page,
+					bool use_hash);
 int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
 			struct page *ipage);
 int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index cbd2a0d34804..3e3c35d4c98b 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -352,7 +352,8 @@ int f2fs_recover_inline_data(struct inode *inode, struct page *npage)
 
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 					const struct f2fs_filename *fname,
-					struct page **res_page)
+					struct page **res_page,
+					bool use_hash)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct f2fs_dir_entry *de;
@@ -369,7 +370,7 @@ struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 	inline_dentry = inline_data_addr(dir, ipage);
 
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
-	de = f2fs_find_target_dentry(&d, fname, NULL);
+	de = f2fs_find_target_dentry(&d, fname, NULL, use_hash);
 	unlock_page(ipage);
 	if (IS_ERR(de)) {
 		*res_page = ERR_CAST(de);
-- 
2.47.1.613.gc27f4b7a9f-goog


