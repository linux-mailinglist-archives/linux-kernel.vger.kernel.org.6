Return-Path: <linux-kernel+bounces-286380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD67D951A43
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C1128102F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105551B29D7;
	Wed, 14 Aug 2024 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="UqoZHq6z"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA5E1B4C23
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635690; cv=none; b=Hc8GtTzsgiRZ7w/ODTSI6zKfm0seoNEaN1yqbzRjET7xG0iDxyIW8Uxy0jpGVEh14EaEt9fRJBWYRqUf9JFOlFDvDlI2m4Q1hR9uQM6qrlp6idX7lWZZPmI4F/Ju2Wh6q6ZGE33jm0t7fd4sRBSNGXdP95rigku73pUO7rS+RlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635690; c=relaxed/simple;
	bh=4eTUDWhrEbeO6LacpkSTpWZsQS6mjvQhzRI0A/zxHU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FYCx6rs771LhtI2xKi0PIgcMpU5PmkO1ZvGTXxHcXThCWm7XUtYcA4HaX2Gv2M3hKL8T+Fxu/tQNXqRpqy8GzSG5yBHd/40NUjmNNc/G8QZp2NHeEurk0plSSiMM293s5lV7XTPu6V75Xl9pLwPF71fBXr8jr3LUeNRm1YytZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=UqoZHq6z; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 624174596C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723635685;
	bh=cuULsUu9z+BvalrO9+cGgsIucfP8fxo4BNYi78/zGSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=UqoZHq6zTGMAi6LaCTItI7q4lizIQQhQ87OCLeZBJfNRKL2TJbG4WnvlXiJkrR4+a
	 RBOQd9Bip3O5PA2VeeWEA2HQSW2k3N822x5NMQPJez0AgIhlZ+HddzByXMVMmjlNYX
	 juLM5fI+FqWXc8ycvm+n+4SM6mVcz2a6qtJNACgmTP538AYuPW8pgoDR/H1edJIn1Z
	 V0lE6KNl4RCWC/1Hd5nEjvIiQXI2dxQe1aKVagoOfQM4R30W5T0/CvR0R29+zkQSr0
	 L/GUMUTaYO3p21SqSZ9Y32bjtgxv4eqjGFN+vEwp1iG14cziuKVf/F3vAAin3L/5RO
	 cMFrjw/iKpRJw==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7a8281dba5so545934566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635685; x=1724240485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuULsUu9z+BvalrO9+cGgsIucfP8fxo4BNYi78/zGSU=;
        b=VIAGkiHBLrYCs8pnIInaqJJqSy12stwt4P5H/o1qNr4DFNcwnkW782E9IUwRHJt1pj
         9TlQWsgO6zp4DJJtQL4jf/SwuziwFYgPMm2yAUxEePXcczsHCBXloVCYpzN5Q5Ak2ryq
         G2f800V9cruYZk6OhaiDUlNtIQhA6hHVAmZ+WU9C2aMbA9kpcxWsv2znuMo4sTQornUT
         OfSxroH+q0Y46cyvuy6tggGo26FNx2dNyAo1i7VrvfPpDpmO+b18H8cxwo2jUVR5GarY
         ElnpYaMtwftgPoZlU+Zyqjepks6cvHuIbJjB9+dEGR2AjkolIPX06yN4SPbDtcQoqkvt
         O/Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVEzK2II0tNIqcBvaFMz+gczlDYuB/2mui2oLkRfzOAAPN5X8reN6Nr19vlzTrvSXpWBjnRXTcz/bImdG4fbegY+t70m5a6fAfFVUZf
X-Gm-Message-State: AOJu0YzjCpUPLOR6B8WS4jkqU7V7tYksjT74IRgGruwABVGz6EgvRS0W
	AiidtQ9kZ02erhN+i85doEC8MXCiORKNacq83k1kwc6sXxH9wAF69mZBwHR7ZdJWpsIWspP8HtZ
	Cm6qLDky5VzZceryV3TJZrtzO2QJ0CcG055i9Grx4uFLRerFr7cmD/bOZiE1tkLPruNLxCE+S+z
	MGYg==
X-Received: by 2002:a17:907:e257:b0:a77:e0ed:8c4 with SMTP id a640c23a62f3a-a8366c10d6emr161899266b.7.1723635684820;
        Wed, 14 Aug 2024 04:41:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSJqi6p3D1QYD5zqxfrHLXoXcCcs9WXjsJL3AnIrFo/DOpEIxIBPJIbf9Ss6W7p94SVwH0Sg==
X-Received: by 2002:a17:907:e257:b0:a77:e0ed:8c4 with SMTP id a640c23a62f3a-a8366c10d6emr161897366b.7.1723635684266;
        Wed, 14 Aug 2024 04:41:24 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa782csm162586166b.60.2024.08.14.04.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:41:23 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] fs/fuse: support idmap for mkdir/mknod/symlink/create
Date: Wed, 14 Aug 2024 13:40:27 +0200
Message-Id: <20240814114034.113953-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have all the infrastructure in place, we just need
to pass an idmapping here.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 30d27d4f3b5a..1e45c6157af4 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -637,9 +637,9 @@ static void free_ext_value(struct fuse_args *args)
  * If the filesystem doesn't support this, then fall back to separate
  * 'mknod' + 'open' requests.
  */
-static int fuse_create_open(struct inode *dir, struct dentry *entry,
-			    struct file *file, unsigned int flags,
-			    umode_t mode, u32 opcode)
+static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
+			    struct dentry *entry, struct file *file,
+			    unsigned int flags, umode_t mode, u32 opcode)
 {
 	int err;
 	struct inode *inode;
@@ -696,7 +696,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_args[1].size = sizeof(*outopenp);
 	args.out_args[1].value = outopenp;
 
-	err = get_create_ext(&nop_mnt_idmap, &args, dir, entry, mode);
+	err = get_create_ext(idmap, &args, dir, entry, mode);
 	if (err)
 		goto out_put_forget_req;
 
@@ -757,6 +757,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			    umode_t mode)
 {
 	int err;
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct dentry *res = NULL;
 
@@ -781,7 +782,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fc->no_create)
 		goto mknod;
 
-	err = fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
+	err = fuse_create_open(idmap, dir, entry, file, flags, mode, FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
@@ -792,7 +793,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	return err;
 
 mknod:
-	err = fuse_mknod(&nop_mnt_idmap, dir, entry, mode, 0);
+	err = fuse_mknod(idmap, dir, entry, mode, 0);
 	if (err)
 		goto out_dput;
 no_open:
@@ -802,9 +803,9 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 /*
  * Code shared between mknod, mkdir, symlink and link
  */
-static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
-			    struct inode *dir, struct dentry *entry,
-			    umode_t mode)
+static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
+			    struct fuse_args *args, struct inode *dir,
+			    struct dentry *entry, umode_t mode)
 {
 	struct fuse_entry_out outarg;
 	struct inode *inode;
@@ -826,7 +827,7 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	args->out_args[0].value = &outarg;
 
 	if (args->opcode != FUSE_LINK) {
-		err = get_create_ext(&nop_mnt_idmap, args, dir, entry, mode);
+		err = get_create_ext(idmap, args, dir, entry, mode);
 		if (err)
 			goto out_put_forget_req;
 	}
@@ -892,13 +893,13 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(fm, &args, dir, entry, mode);
+	return create_new_entry(idmap, fm, &args, dir, entry, mode);
 }
 
 static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *entry, umode_t mode, bool excl)
 {
-	return fuse_mknod(&nop_mnt_idmap, dir, entry, mode, 0);
+	return fuse_mknod(idmap, dir, entry, mode, 0);
 }
 
 static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
@@ -910,7 +911,7 @@ static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	if (fc->no_tmpfile)
 		return -EOPNOTSUPP;
 
-	err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
+	err = fuse_create_open(idmap, dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
 	if (err == -ENOSYS) {
 		fc->no_tmpfile = 1;
 		err = -EOPNOTSUPP;
@@ -937,7 +938,7 @@ static int fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(fm, &args, dir, entry, S_IFDIR);
+	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
 }
 
 static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
@@ -953,7 +954,7 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = entry->d_name.name;
 	args.in_args[1].size = len;
 	args.in_args[1].value = link;
-	return create_new_entry(fm, &args, dir, entry, S_IFLNK);
+	return create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
 }
 
 void fuse_flush_time_update(struct inode *inode)
@@ -1147,7 +1148,7 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = newent->d_name.len + 1;
 	args.in_args[1].value = newent->d_name.name;
-	err = create_new_entry(fm, &args, newdir, newent, inode->i_mode);
+	err = create_new_entry(&nop_mnt_idmap, fm, &args, newdir, newent, inode->i_mode);
 	if (!err)
 		fuse_update_ctime_in_cache(inode);
 	else if (err == -EINTR)
-- 
2.34.1


