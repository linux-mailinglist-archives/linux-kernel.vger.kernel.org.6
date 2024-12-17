Return-Path: <linux-kernel+bounces-448789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 875FE9F4579
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35D716C772
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661AE1D54E3;
	Tue, 17 Dec 2024 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkVbMJ9B"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427EA29
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421695; cv=none; b=s2Nc57jrPzQmE7dcBfoU9hlVn4WXDlskEACFhAp7rVJxrjd71S3lqBSaKnfywDU4fnGNracQc0jf9KiUcFL8ng2nYdphaCk16TiDgO5k+odc8mMW0uILDmJiEfemLxsBlWK9d/OKEPe9WNgYEQ6Q06Olu8phxTO090iyexm9yrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421695; c=relaxed/simple;
	bh=KpFhqRJ2llPZe5zlFQJlvEHwc7R5SS3sqpjwModW+HE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y8gXBElLW7K6IsD3H+C+Zmt5fXsRV/z+euWARYvQrJX/sBA6c3BN5KEth+3smlWC3CsZQAHn2Ugc0UzXQAc/piwsNR97wrkgatZmdxUAjlssb+ALFHXeSCnu+YR5spLSXM86C2Th5S1E5XW8nSaqFedooJdEGrvCLsvgrQ5adLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BkVbMJ9B; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21681a2c0d5so43072775ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734421693; x=1735026493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uzkj+oZY7b1p5AsRN5+ESM/ySLflwyn0YjSlF+T1L78=;
        b=BkVbMJ9BKRc8eCZQ8SAawHVsSdKXUQaaXb6pDw4E3lrdqdiXnOjpldMLJIwvzhRXX/
         rSLBj5/Aw6Tj0NYGAK2CsCQg8Q+Rh6NT2gAceSdVsNOCAJAFeilqPH1X4xh2cpmpwet0
         DrUz1m2PTcA1U+1IPvrX6GMGsPAKBLoy/mdApOUW4i/JgHHLgBO/Jm9nRKWyMebqhysw
         IIOMLqaJUf6juAuZwuSso6rIJvmfd4swxPBaLEwzr/LBOcpLt3KFcR3k6yNGcNKtB4Cm
         kZvUB/FWTxPU1Df0ipU/CJaq9LQYo35SH8FnSdw0UEOHISca/P22qFSEVD55lbkgQV8g
         GrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734421693; x=1735026493;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uzkj+oZY7b1p5AsRN5+ESM/ySLflwyn0YjSlF+T1L78=;
        b=tIj1sD8cgf5GrZetpCscrRlH1Q3EKp+fpeCvoygp8U0AMNdYl7HVQyyryxqFZf8bd7
         sr5GiDBZ/k/bZRfFB7DC3TiGtvmMKTG3GkV4Do7Rojb75pgYzvjrdIVVz3cWjz6ACLor
         WfKMKs3SVRT7vGgjXGtTI/OOb7q97jum5twXczC/1rcjTBuS55c1Qmk2TLqBcKaw4ON1
         mhrlxKHhp87EmWyWat0SqlqBiok5Qof24oMsFI6Egk80S9WFQLLCDq10+9DBtUoBFf1E
         WptMwWvZxc5dPIMrM+0ET424U4D4+dRDGx3/VbwFOz4WhwDGG/EpG7QSd8mFkvcEzRf5
         xOmA==
X-Forwarded-Encrypted: i=1; AJvYcCXSQoPVNfNZx08t8KT+h0a0LqpoBFrOo0GjvAxA3tl8QK8hIWB/r6oi5V1XP5wRd6b5cW3AUfC57Eerh9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8TyetmAGPs3BkmGDd3onTifGLUjVNAGCLlakP0EmeZ8KCTKqv
	5AIO0i+z73g5rHvKb0tX8TnN3hoOkhz4qfWWwuCmqwl48mYBYGh6XXGA1Ihcz4e5UyQA0p+CbJz
	Uf6DJVQ==
X-Google-Smtp-Source: AGHT+IHbbz8nZkTFLf6hTF6u5LTYLcTNscnGFWNr9QPUKimMKeYt53bAQZ/OkXRDqvVZT0L1PDMv0rGQgFzz
X-Received: from pjbsc8.prod.google.com ([2002:a17:90b:5108:b0:2ef:85ba:108f])
 (user=chullee job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d12:b0:2ee:ed1c:e451
 with SMTP id 98e67ed59e1d1-2f28fb67922mr24903726a91.15.1734421693371; Mon, 16
 Dec 2024 23:48:13 -0800 (PST)
Date: Mon, 16 Dec 2024 23:47:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217074730.1166912-1-chullee@google.com>
Subject: [PATCH] f2fs: Introduce linear search for dentries
From: Daniel Lee <chullee@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, 
	open list <linux-kernel@vger.kernel.org>, --dry-run@google.com
Cc: Daniel Lee <chullee@google.com>
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


