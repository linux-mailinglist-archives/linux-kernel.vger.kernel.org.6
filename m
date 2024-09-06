Return-Path: <linux-kernel+bounces-319047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD3496F6F8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5CE285F55
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26531D1F50;
	Fri,  6 Sep 2024 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tyLOlEJn"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1B1D04A0
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633309; cv=none; b=G6PGCoK0g+fC4dVVmLTBn3L5G78Kj0s3iINnl8eFpq1GcX6fDcRR/YeYwfqZWj8FMZbOBmgQ7AZBwMbj4Jw5+RjYKD14F1rq7DsRMKtLY0u5Mb5wBAnKnWY5lUhHXaNIxsSoXum6HDdUh5qCxwPXkB0zjTBy6HWKi3m22bIlmvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633309; c=relaxed/simple;
	bh=pVyeI53BAtbh5enSOiGTuRtOeJujA6YmS7qvQrPKloA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UHnhL5FkKQPJ6L0QFC1iFqTl3VMIjtFFXgYwGsTMvbAckafcnInV9UHq8fEcICPzhVQbbagpVga1pa8iM8+YE3uqOZ3bpudv5aQxP/GyLufmomxtJX9F2wh+KMGd3PQcY/6toFwzEhMsfS2J3hI6L+ureSbxTDbDvhn4Y4Pq1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tyLOlEJn; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E8EB93F31C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725633304;
	bh=o9Smb8VRV1ALrUS2xWCuzXJx0BOoYi7JpBVsIPpJlNY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=tyLOlEJnKb574mLLiOkYhmeRyepVkQkX/Ny4y2vWIyYyK84jeaWaM7YGOjwrmzc8H
	 SsmvcCrP+v2R+CJfVQflEJYN5mXnJaF0Ceko35danvguMO3g/BHZ9wSTqwOh90YDS3
	 cR8KQVUgRFiTcjg+N16o5SU4lvrftdcZu+UL+XGMm07YRDBKZZAg3Sibr8sdH1LGeH
	 vxmH/oRPtA0ePEPSdvtdjXh1CuJkrOhAXBBkG1GszUPeOUe+NDyOWLVLgdNsA8HPpa
	 Csj2UvYIwrZUMP3hXTP5/fxjh1WVqyd78GcnJbbxsBzo7VqvWU4woPvbTLZo2u6LzH
	 C0MsIy0P9O/Sg==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c251a09953so1838509a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633304; x=1726238104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9Smb8VRV1ALrUS2xWCuzXJx0BOoYi7JpBVsIPpJlNY=;
        b=POCTX7kQVbYikFi+xhCv/BkbPIBXGp3pmlnP6xjL6KmPVsR5HSJftPS7nONxJHzYLp
         IMe/ar6gGbFfXvf+8CFBqCDC6//Rcvkeo/0zzoTLPaWXSPcYFjggEfezGAF5YQLikwHj
         HAEVcA70IYWK+8/3moYwdx0pMuKFiD1VbidYE9HwDxNdqOfgvJBrKDOkzfJ+XaNaRQw6
         RkLnUx7JOVNfIV2MGdjl5dY7gRTpbsgSUj4h/n15tALGBAsUpmyVqWQhrK6q2XYmgYVV
         7KOIL3IcAW9jkZ9JhDxDwDmjpkHsXJ9xEpFOI3YHwBVAad6LR6U1j8yser7JD+mUXVNm
         7ziQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoWaCDKoKmvqM421X7rpn3ujMY3CeVRVwdBbVyNYtXfLt1Os4xrSrklXFpQ5zEKzfXVAbsMRkMFJNtzkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3YDL64WtG+c8IY09LrX0tLRfD9E9kSPznrDs08UJIb42c9qBM
	yZ5SC+f3USszDI7hRlIvdh48W92nDHT1SD1Z/aa8jwRbw7m9oIC2YhFm9CNuru7fzjVypwNzQB0
	pujNTyZld+QLdw3QJsOelVUVQSrf0Wf3NSeQ2YMEPVM5Ld8bToC+yQctfAkEDPPDOuaERaumzBh
	Fhvw==
X-Received: by 2002:a17:907:7ea1:b0:a8b:6ee7:ba2c with SMTP id a640c23a62f3a-a8b70ee9409mr95232766b.16.1725633303902;
        Fri, 06 Sep 2024 07:35:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq+QzPT0AotRdUG7m3aR9DwpSnlsT/1bn2AVIT0R1FNm00fG4lHyE7UR/ERIjg3FcMUZEWlQ==
X-Received: by 2002:a17:907:7ea1:b0:a8b:6ee7:ba2c with SMTP id a640c23a62f3a-a8b70ee9409mr95230666b.16.1725633303290;
        Fri, 06 Sep 2024 07:35:03 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236cee0sm281787466b.101.2024.09.06.07.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:35:02 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] fs/fuse: introduce and use fuse_simple_idmap_request() helper
Date: Fri,  6 Sep 2024 16:34:51 +0200
Message-Id: <20240906143453.179506-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's convert all existing callers properly.

No functional changes intended.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dax.c     |  4 ++--
 fs/fuse/dev.c     |  6 +++---
 fs/fuse/dir.c     | 26 +++++++++++++-------------
 fs/fuse/file.c    | 32 ++++++++++++++++----------------
 fs/fuse/fuse_i.h  | 18 ++++++++++++++++--
 fs/fuse/inode.c   |  6 +++---
 fs/fuse/ioctl.c   |  2 +-
 fs/fuse/readdir.c |  4 ++--
 fs/fuse/xattr.c   |  8 ++++----
 9 files changed, 60 insertions(+), 46 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 6d8368d66dd4..12ef91d170bb 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -207,7 +207,7 @@ static int fuse_setup_one_mapping(struct inode *inode, unsigned long start_idx,
 	args.in_numargs = 1;
 	args.in_args[0].size = sizeof(inarg);
 	args.in_args[0].value = &inarg;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (err < 0)
 		return err;
 	dmap->writable = writable;
@@ -245,7 +245,7 @@ static int fuse_send_removemapping(struct inode *inode,
 	args.in_args[0].value = inargp;
 	args.in_args[1].size = inargp->count * sizeof(*remove_one);
 	args.in_args[1].value = remove_one;
-	return fuse_simple_request(NULL, fm, &args);
+	return fuse_simple_request(fm, &args);
 }
 
 static int dmap_removemapping_list(struct inode *inode, unsigned int num,
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5ca2ab48527e..04a6490a587c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -539,9 +539,9 @@ static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
 		__set_bit(FR_ASYNC, &req->flags);
 }
 
-ssize_t fuse_simple_request(struct mnt_idmap *idmap,
-			    struct fuse_mount *fm,
-			    struct fuse_args *args)
+ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
+			      struct fuse_mount *fm,
+			      struct fuse_args *args)
 {
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_req *req;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 99f9948bf68b..491e112819be 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -230,7 +230,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 		parent = dget_parent(entry);
 		fuse_lookup_init(fm->fc, &args, get_node_id(d_inode(parent)),
 				 &entry->d_name, &outarg);
-		ret = fuse_simple_request(NULL, fm, &args);
+		ret = fuse_simple_request(fm, &args);
 		dput(parent);
 		/* Zero nodeid is same as -ENOENT */
 		if (!ret && !outarg.nodeid)
@@ -383,7 +383,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	attr_version = fuse_get_attr_version(fm->fc);
 
 	fuse_lookup_init(fm->fc, &args, nodeid, name, outarg);
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	/* Zero nodeid is same as -ENOENT, but with valid timeout */
 	if (err || !outarg->nodeid)
 		goto out_put_forget;
@@ -677,7 +677,7 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	if (err)
 		goto out_free_ff;
 
-	err = fuse_simple_request(idmap, fm, &args);
+	err = fuse_simple_idmap_request(idmap, fm, &args);
 	free_ext_value(&args);
 	if (err)
 		goto out_free_ff;
@@ -809,7 +809,7 @@ static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
 			goto out_put_forget_req;
 	}
 
-	err = fuse_simple_request(idmap, fm, args);
+	err = fuse_simple_idmap_request(idmap, fm, args);
 	free_ext_value(args);
 	if (err)
 		goto out_put_forget_req;
@@ -994,7 +994,7 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 	args.in_numargs = 1;
 	args.in_args[0].size = entry->d_name.len + 1;
 	args.in_args[0].value = entry->d_name.name;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (!err) {
 		fuse_dir_changed(dir);
 		fuse_entry_unlinked(entry);
@@ -1017,7 +1017,7 @@ static int fuse_rmdir(struct inode *dir, struct dentry *entry)
 	args.in_numargs = 1;
 	args.in_args[0].size = entry->d_name.len + 1;
 	args.in_args[0].value = entry->d_name.name;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (!err) {
 		fuse_dir_changed(dir);
 		fuse_entry_unlinked(entry);
@@ -1047,7 +1047,7 @@ static int fuse_rename_common(struct mnt_idmap *idmap, struct inode *olddir, str
 	args.in_args[1].value = oldent->d_name.name;
 	args.in_args[2].size = newent->d_name.len + 1;
 	args.in_args[2].value = newent->d_name.name;
-	err = fuse_simple_request(idmap, fm, &args);
+	err = fuse_simple_idmap_request(idmap, fm, &args);
 	if (!err) {
 		/* ctime changes */
 		fuse_update_ctime(d_inode(oldent));
@@ -1222,7 +1222,7 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (err)
 		return err;
 
@@ -1280,7 +1280,7 @@ static int fuse_do_getattr(struct mnt_idmap *idmap, struct inode *inode,
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (!err) {
 		if (fuse_invalid_attr(&outarg.attr) ||
 		    inode_wrong_type(inode, outarg.attr.mode)) {
@@ -1492,7 +1492,7 @@ static int fuse_access(struct inode *inode, int mask)
 	args.in_numargs = 1;
 	args.in_args[0].size = sizeof(inarg);
 	args.in_args[0].value = &inarg;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
 		fm->fc->no_access = 1;
 		err = 0;
@@ -1604,7 +1604,7 @@ static int fuse_readlink_page(struct inode *inode, struct page *page)
 	ap.args.page_zeroing = true;
 	ap.args.out_numargs = 1;
 	ap.args.out_args[0].size = desc.length;
-	res = fuse_simple_request(NULL, fm, &ap.args);
+	res = fuse_simple_request(fm, &ap.args);
 
 	fuse_invalidate_atime(inode);
 
@@ -1889,7 +1889,7 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
 	}
 	fuse_setattr_fill(fm->fc, &args, inode, &inarg, &outarg);
 
-	return fuse_simple_request(NULL, fm, &args);
+	return fuse_simple_request(fm, &args);
 }
 
 /*
@@ -2002,7 +2002,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			inarg.valid |= FATTR_KILL_SUIDGID;
 	}
 	fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (err) {
 		if (err == -EINTR)
 			fuse_invalidate_attr(inode);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ca553d7a7c9e..b8afeca12487 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -48,7 +48,7 @@ static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 	args.out_args[0].size = sizeof(*outargp);
 	args.out_args[0].value = outargp;
 
-	return fuse_simple_request(NULL, fm, &args);
+	return fuse_simple_request(fm, &args);
 }
 
 struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release)
@@ -111,7 +111,7 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 		if (!args) {
 			/* Do nothing when server does not implement 'open' */
 		} else if (sync) {
-			fuse_simple_request(NULL, ff->fm, args);
+			fuse_simple_request(ff->fm, args);
 			fuse_release_end(ff->fm, args, 0);
 		} else {
 			args->end = fuse_release_end;
@@ -539,7 +539,7 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	args.in_args[0].value = &inarg;
 	args.force = true;
 
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
 		fm->fc->no_flush = 1;
 		err = 0;
@@ -572,7 +572,7 @@ int fuse_fsync_common(struct file *file, loff_t start, loff_t end,
 	args.in_numargs = 1;
 	args.in_args[0].size = sizeof(inarg);
 	args.in_args[0].value = &inarg;
-	return fuse_simple_request(NULL, fm, &args);
+	return fuse_simple_request(fm, &args);
 }
 
 static int fuse_fsync(struct file *file, loff_t start, loff_t end,
@@ -814,7 +814,7 @@ static ssize_t fuse_send_read(struct fuse_io_args *ia, loff_t pos, size_t count,
 	if (ia->io->async)
 		return fuse_async_req_send(fm, ia, count);
 
-	return fuse_simple_request(NULL, fm, &ia->ap.args);
+	return fuse_simple_request(fm, &ia->ap.args);
 }
 
 static void fuse_read_update_size(struct inode *inode, loff_t size,
@@ -878,7 +878,7 @@ static int fuse_do_readpage(struct file *file, struct page *page)
 		desc.length--;
 
 	fuse_read_args_fill(&ia, file, pos, desc.length, FUSE_READ);
-	res = fuse_simple_request(NULL, fm, &ia.ap.args);
+	res = fuse_simple_request(fm, &ia.ap.args);
 	if (res < 0)
 		return res;
 	/*
@@ -976,7 +976,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 		if (!err)
 			return;
 	} else {
-		res = fuse_simple_request(NULL, fm, &ap->args);
+		res = fuse_simple_request(fm, &ap->args);
 		err = res < 0 ? res : 0;
 	}
 	fuse_readpages_end(fm, &ap->args, err);
@@ -1101,7 +1101,7 @@ static ssize_t fuse_send_write(struct fuse_io_args *ia, loff_t pos,
 	if (ia->io->async)
 		return fuse_async_req_send(fm, ia, count);
 
-	err = fuse_simple_request(NULL, fm, &ia->ap.args);
+	err = fuse_simple_request(fm, &ia->ap.args);
 	if (!err && ia->write.out.size > count)
 		err = -EIO;
 
@@ -1147,7 +1147,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	if (fm->fc->handle_killpriv_v2 && !capable(CAP_FSETID))
 		ia->write.in.write_flags |= FUSE_WRITE_KILL_SUIDGID;
 
-	err = fuse_simple_request(NULL, fm, &ap->args);
+	err = fuse_simple_request(fm, &ap->args);
 	if (!err && ia->write.out.size > count)
 		err = -EIO;
 
@@ -2662,7 +2662,7 @@ static int fuse_getlk(struct file *file, struct file_lock *fl)
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (!err)
 		err = convert_fuse_file_lock(fm->fc, &outarg.lk, fl);
 
@@ -2686,7 +2686,7 @@ static int fuse_setlk(struct file *file, struct file_lock *fl, int flock)
 	}
 
 	fuse_lk_fill(&args, file, fl, opcode, pid_nr, flock, &inarg);
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 
 	/* locking is restartable */
 	if (err == -EINTR)
@@ -2760,7 +2760,7 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS)
 		fm->fc->no_bmap = 1;
 
@@ -2792,7 +2792,7 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (err) {
 		if (err == -ENOSYS) {
 			fm->fc->no_lseek = 1;
@@ -2925,7 +2925,7 @@ __poll_t fuse_file_poll(struct file *file, poll_table *wait)
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 
 	if (!err)
 		return demangle_poll(outarg.revents);
@@ -3147,7 +3147,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	args.in_numargs = 1;
 	args.in_args[0].size = sizeof(inarg);
 	args.in_args[0].value = &inarg;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
 		fm->fc->no_fallocate = 1;
 		err = -EOPNOTSUPP;
@@ -3259,7 +3259,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
 		fc->no_copy_file_range = 1;
 		err = -EOPNOTSUPP;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7dd0661aeab6..b2c7834f21b5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1147,8 +1147,22 @@ void __exit fuse_ctl_cleanup(void);
 /**
  * Simple request sending that does request allocation and freeing
  */
-ssize_t fuse_simple_request(struct mnt_idmap *idmap, struct fuse_mount *fm,
-			    struct fuse_args *args);
+ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
+			      struct fuse_mount *fm,
+			      struct fuse_args *args);
+
+static inline ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
+{
+	return __fuse_simple_request(NULL, fm, args);
+}
+
+static inline ssize_t fuse_simple_idmap_request(struct mnt_idmap *idmap,
+						struct fuse_mount *fm,
+						struct fuse_args *args)
+{
+	return __fuse_simple_request(idmap, fm, args);
+}
+
 int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 			   gfp_t gfp_flags);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d7edb3fb829f..fd3321e29a3e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -586,7 +586,7 @@ static void fuse_send_destroy(struct fuse_mount *fm)
 		args.opcode = FUSE_DESTROY;
 		args.force = true;
 		args.nocreds = true;
-		fuse_simple_request(NULL, fm, &args);
+		fuse_simple_request(fm, &args);
 	}
 }
 
@@ -624,7 +624,7 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 	args.out_numargs = 1;
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (!err)
 		convert_fuse_statfs(buf, &outarg.st);
 	return err;
@@ -713,7 +713,7 @@ static int fuse_sync_fs(struct super_block *sb, int wait)
 	args.nodeid = get_node_id(sb->s_root->d_inode);
 	args.out_numargs = 0;
 
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
 		fc->sync_fs = 0;
 		err = 0;
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index b40dd931167d..572ce8a82ceb 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -18,7 +18,7 @@ static ssize_t fuse_send_ioctl(struct fuse_mount *fm, struct fuse_args *args,
 	args->out_args[0].size = sizeof(*outarg);
 	args->out_args[0].value = outarg;
 
-	ret = fuse_simple_request(NULL, fm, args);
+	ret = fuse_simple_request(fm, args);
 
 	/* Translate ENOSYS, which shouldn't be returned from fs */
 	if (ret == -ENOSYS)
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index e8a093289421..0377b6dc24c8 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -279,7 +279,7 @@ static void fuse_force_forget(struct file *file, u64 nodeid)
 	args.force = true;
 	args.noreply = true;
 
-	fuse_simple_request(NULL, fm, &args);
+	fuse_simple_request(fm, &args);
 	/* ignore errors */
 }
 
@@ -358,7 +358,7 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 				    FUSE_READDIR);
 	}
 	locked = fuse_lock_inode(inode);
-	res = fuse_simple_request(NULL, fm, &ap->args);
+	res = fuse_simple_request(fm, &ap->args);
 	fuse_unlock_inode(inode, locked);
 	if (res >= 0) {
 		if (!res) {
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 0a9b60de3668..9f568d345c51 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -37,7 +37,7 @@ int fuse_setxattr(struct inode *inode, const char *name, const void *value,
 	args.in_args[1].value = name;
 	args.in_args[2].size = size;
 	args.in_args[2].value = value;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
 		fm->fc->no_setxattr = 1;
 		err = -EOPNOTSUPP;
@@ -79,7 +79,7 @@ ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
 		args.out_args[0].size = sizeof(outarg);
 		args.out_args[0].value = &outarg;
 	}
-	ret = fuse_simple_request(NULL, fm, &args);
+	ret = fuse_simple_request(fm, &args);
 	if (!ret && !size)
 		ret = min_t(size_t, outarg.size, XATTR_SIZE_MAX);
 	if (ret == -ENOSYS) {
@@ -141,7 +141,7 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size)
 		args.out_args[0].size = sizeof(outarg);
 		args.out_args[0].value = &outarg;
 	}
-	ret = fuse_simple_request(NULL, fm, &args);
+	ret = fuse_simple_request(fm, &args);
 	if (!ret && !size)
 		ret = min_t(size_t, outarg.size, XATTR_LIST_MAX);
 	if (ret > 0 && size)
@@ -167,7 +167,7 @@ int fuse_removexattr(struct inode *inode, const char *name)
 	args.in_numargs = 1;
 	args.in_args[0].size = strlen(name) + 1;
 	args.in_args[0].value = name;
-	err = fuse_simple_request(NULL, fm, &args);
+	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
 		fm->fc->no_removexattr = 1;
 		err = -EOPNOTSUPP;
-- 
2.34.1


