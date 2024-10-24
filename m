Return-Path: <linux-kernel+bounces-380335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DA89AEC81
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716F51F2481E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4F61F4FBC;
	Thu, 24 Oct 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3ui7CS+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17AB1D9A49
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788466; cv=none; b=K3tN6CX5m1eS8CkIVbsiV1sXpr3eQLtRgV0x7yolf/KmuYuqM4s3UjCA5qCdhueLziY/kkQ7Vv3+vC486iSIPvWvqosXSunQ6lrpi7Mc5XA4NFFOkQRFV94wkrOgrwuy0m3tv+ixJkmvBIFm2XpsuqofTaim69Oxcu6/ZswDGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788466; c=relaxed/simple;
	bh=aIvLjn3rOlgO5kyHARTds1WHTCY8VeelPcVbk96WdUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YEgMkAIkIVHOlKW+mSRZGDmq8061nngh5BidTy5wPzYDCADDHQXhWCSXwVXFT+hO4/lJ3Of++v9M5/26p/zvQ5SJ+GTdmj/IfheBqdb3UJsavbmWWVwRQrqjMkRJYfuctviWrbNXBa+fHMI3A9eXJk6Ntp4fV27GcPwhX5E3Wls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3ui7CS+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729788462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/JTZR9cb5cIdJfIIUCqp1j5ZogzOe/S5Pl1mQcHwweA=;
	b=D3ui7CS+Lzk5EJOnpmVjItQGcsDh6gAqMTawuD9GPAMYQdchLVBFTzB0O64FwDBRkcIsAT
	+xd8mC0cgTrw9lVYcVEfL2zZohBR0piibsaP5tfEBsCFcw1VTyIkAtd+r6adYHH4Dt0qve
	h1MzxtTy0WLZMmOxX0qU/kpBFs9P5is=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-ajdoLRDqPuiyl5zILneRhQ-1; Thu, 24 Oct 2024 12:47:41 -0400
X-MC-Unique: ajdoLRDqPuiyl5zILneRhQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315a0f25afso9139675e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788458; x=1730393258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JTZR9cb5cIdJfIIUCqp1j5ZogzOe/S5Pl1mQcHwweA=;
        b=QniHQUiiJLShE2hyEBqQbSY3xLgNCF4iQkVj8/xcNqAuQuUDlgPkSzjShPyuh9wDR5
         y8AExDevT6RnEUAgzyzzjjCbo2/kfOwBmfcouwXjjzIo+C6mUTC2/ZBn4IcY+WBuFVaH
         4+8XUfhc/i88GG511kyfuNe4tEp+pZ43cflBHmR/hisl2jkV78EUEamIPjD7MdWV0mZm
         HJtTgEzSZz1Aax1M46jZ+mHo28ed0qwvRh52zf7YJqqhnVdHCvCZ40YkE9a3/KNMsUbm
         Ed7XTdSnKuZnJwYlp8Ga9bMFRhOHjznLwfLcG9/7DawdlzUrJT+azXzWu8A2Jdiz6MrK
         evjA==
X-Gm-Message-State: AOJu0Yxb3K8sIWVDILBuxinusHOjkGx2QKhgcFjBev90KFLFsX6miC2Q
	anvThEJVhsdrSvycm4G5DAm4CurNzWsr5z5fr8HYhjtGylUuedaQIflUimHfw+G0sO7oOd4/ZB1
	/Y08R6+06h+fDOf8H7oRFArQE2+Xq1KOkqOm0vd2P3EUPSEZvV3hYSDT3yf0g4HdJTLRbcQCs0W
	h5l8DaACa/gwkTA1CS8BloR7Rh1tHKnCa6EKPlwc4uwtg=
X-Received: by 2002:a05:600c:1552:b0:42c:b750:1a1e with SMTP id 5b1f17b1804b1-4318beb62e6mr23540955e9.0.1729788457967;
        Thu, 24 Oct 2024 09:47:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8xUNh7GrXyQK8HUgeXdRxCTth5F82XB1Lm2v2D9E3I4zBK+iNWsA7VZ8jlV1lWVrXQcR0yg==
X-Received: by 2002:a05:600c:1552:b0:42c:b750:1a1e with SMTP id 5b1f17b1804b1-4318beb62e6mr23540585e9.0.1729788457304;
        Thu, 24 Oct 2024 09:47:37 -0700 (PDT)
Received: from localhost (p200300cfd711bbb70201b57cf9d739d5.dip0.t-ipconnect.de. [2003:cf:d711:bbb7:201:b57c:f9d7:39d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bd68c7sm51480805e9.7.2024.10.24.09.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:47:36 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Hanna Czenczek <hreitz@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] virtio-fs: Query rootmode during mount
Date: Thu, 24 Oct 2024 18:47:24 +0200
Message-ID: <20241024164726.77485-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During mount, receive the root inode's mode (e.g. whether it is a
directory or a regular file) via GETATTR.

Currently, the only way to set this mode to anything but S_IFDIR is by
passing the mode's numerical value via the 'rootmode' mount option.
This is done automatically by libfuse, so users generally do not need to
worry about it.

For virtio-fs, no such option exists.  We could add it, but then users
would need to manually set it: In case of virtio-fs, the server runs on
a separate system, so it cannot issue mount() itself, leaving it a
manual operation for the user.  So instead, Miklos suggested to simply
ask the virtio-fs server (virtiofsd) for this rootmode.

We can do this via a GETATTR call during mount(): virtio_fs_fill_super()
currently submits INIT in the background.  To do a GETATTR, we need to
instead await the INIT reply (i.e. do a synchronous request), and then
do GETATTR afterwards on the root inode.

To be able to issue INIT (and GETATTR), we need to at least partially
initialize the super_block structure, which is currently done via
fuse_fill_super_common().  However, the last part of that function sets
up the root inode, which we will now have to delay until we have the
GETATTR result.  Therefore, we split fuse_fill_super_common() in two:
One part (initializing the super_block) we run before INIT+GETATTR, the
other (setting up the root inode) we run afterwards.

Note that this patch only changes virtio-fs's behavior.  For other FUSE
filesystems, we will continue to rely on the 'rootmode' mount option
instead of issuing GETATTR during mount(): It is reasonable for a FUSE
server to issue the mount() system call in the same thread that will
later process FUSE requests.  Blocking on a FUSE request (INIT and
GETATTR) during mount() would then cause a deadlock.

Also, using the 'rootmode' mount option in case of non-virtio-fs FUSE
filesystems just works well, there is no need to change it.

Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
Sorry for the delay, I wanted to find out whether I could come up with a
good way of testing that all non-virtio-fs filesystems will be
unaffected.  Unfortunately I didn't, so I really only tested manually
that e.g. sshfs works as before (also qemu's FUSE export as an example
for an S_IFREG root node).
---
 fs/fuse/fuse_i.h    | 35 +++++++++++++++++++++--
 fs/fuse/dir.c       | 28 ++++++++++++++++++
 fs/fuse/inode.c     | 70 ++++++++++++++++++++++++++++++++++-----------
 fs/fuse/virtio_fs.c | 38 +++++++++++++++++++++---
 4 files changed, 148 insertions(+), 23 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e6cc3d552b13..1312705ecb16 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -936,6 +936,9 @@ struct fuse_mount {
 	/* Entry on fc->mounts */
 	struct list_head fc_entry;
 	struct rcu_head rcu;
+
+	/* Whether this is a submount */
+	bool submount;
 };
 
 static inline struct fuse_mount *get_fuse_mount_super(struct super_block *sb)
@@ -1219,15 +1222,43 @@ struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc);
 struct fuse_dev *fuse_dev_alloc(void);
 void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
 void fuse_dev_free(struct fuse_dev *fud);
-void fuse_send_init(struct fuse_mount *fm);
 
 /**
- * Fill in superblock and initialize fuse connection
+ * Send INIT request
+ * @fm: FUSE mount
+ * @await_reply: If true, send a synchronous request, awaiting the server's
+ *		 reply.  Otherwise, just submit the request, not awaiting a
+ *		 reply; it will then be processed in the background once it
+ *		 arrives.
+ */
+void fuse_send_init(struct fuse_mount *fm, bool await_reply);
+
+/**
+ * Query the root inode's mode via GETATTR from the server; for use with
+ * fuse_make_root_inode()
+ * @fm: FUSE mount
+ * @rootmode: on success, receives the root inode's mode
+ */
+int fuse_get_rootmode(struct fuse_mount *fm, unsigned int *rootmode);
+
+/**
+ * Fill in superblock, without creating the root inode
  * @sb: partially-initialized superblock to fill in
  * @ctx: mount context
  */
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx);
 
+/**
+ * Create the root inode and initialize fuse connection, completing
+ * initialization of the superblock
+ * @sb: almost-initialized superblock (from fuse_fill_super_common()) to
+ *	complete
+ * @ctx: mount context
+ * @mode: inode mode of the root inode
+ */
+int fuse_make_root_inode(struct super_block *sb, struct fuse_fs_context *ctx,
+			 unsigned int mode);
+
 /*
  * Remove the mount from the connection
  *
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 54104dd48af7..36fc899c5acc 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1297,6 +1297,34 @@ static int fuse_do_getattr(struct mnt_idmap *idmap, struct inode *inode,
 	return err;
 }
 
+int fuse_get_rootmode(struct fuse_mount *fm, unsigned int *rootmode)
+{
+	int res;
+	struct fuse_getattr_in inarg;
+	struct fuse_attr_out outarg;
+	FUSE_ARGS(args);
+
+	memset(&inarg, 0, sizeof(inarg));
+	memset(&outarg, 0, sizeof(outarg));
+	args.opcode = FUSE_GETATTR;
+	args.nodeid = FUSE_ROOT_ID;
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	args.out_numargs = 1;
+	args.out_args[0].size = sizeof(outarg);
+	args.out_args[0].value = &outarg;
+	res = fuse_simple_request(fm, &args);
+	if (!res) {
+		if (fuse_invalid_attr(&outarg.attr))
+			res = -EIO;
+		else
+			*rootmode = outarg.attr.mode;
+	}
+	return res;
+}
+EXPORT_SYMBOL_GPL(fuse_get_rootmode);
+
 static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 				struct file *file, struct kstat *stat,
 				u32 request_mask, unsigned int flags)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fd3321e29a3e..3e19b92928ad 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1378,10 +1378,11 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 	wake_up_all(&fc->blocked_waitq);
 }
 
-void fuse_send_init(struct fuse_mount *fm)
+void fuse_send_init(struct fuse_mount *fm, bool await_reply)
 {
 	struct fuse_init_args *ia;
 	u64 flags;
+	ssize_t ret;
 
 	ia = kzalloc(sizeof(*ia), GFP_KERNEL | __GFP_NOFAIL);
 
@@ -1431,7 +1432,18 @@ void fuse_send_init(struct fuse_mount *fm)
 	ia->args.nocreds = true;
 	ia->args.end = process_init_reply;
 
-	if (fuse_simple_background(fm, &ia->args, GFP_KERNEL) != 0)
+	if (await_reply)
+		ret = fuse_simple_request(fm, &ia->args);
+	else
+		ret = fuse_simple_background(fm, &ia->args, GFP_KERNEL);
+
+	/*
+	 * Errors from fuse_simple_request() may mean that we failed to submit
+	 * the request, or may be error codes from the server, which would have
+	 * been processed already.  Either way, ensure that we always call
+	 * process_init_reply() at least once.
+	 */
+	if (ret < 0)
 		process_init_reply(fm, &ia->args, -ENOTCONN);
 }
 EXPORT_SYMBOL_GPL(fuse_send_init);
@@ -1653,6 +1665,7 @@ static int fuse_get_tree_submount(struct fs_context *fsc)
 	if (!fm)
 		return -ENOMEM;
 
+	fm->submount = true;
 	fm->fc = fuse_conn_get(fc);
 	fsc->s_fs_info = fm;
 	sb = sget_fc(fsc, NULL, set_anon_super_fc);
@@ -1694,8 +1707,6 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	struct fuse_dev *fud = NULL;
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	struct fuse_conn *fc = fm->fc;
-	struct inode *root;
-	struct dentry *root_dentry;
 	int err;
 
 	err = -EINVAL;
@@ -1752,8 +1763,36 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
 
+	err = -EINVAL;
+	if (ctx->fudptr) {
+		if (*ctx->fudptr)
+			goto err_dev_free;
+		*ctx->fudptr = fud;
+	}
+	return 0;
+
+ err_dev_free:
+	if (fud)
+		fuse_dev_free(fud);
+ err_free_dax:
+	if (IS_ENABLED(CONFIG_FUSE_DAX))
+		fuse_dax_conn_free(fc);
+ err:
+	return err;
+}
+EXPORT_SYMBOL_GPL(fuse_fill_super_common);
+
+int fuse_make_root_inode(struct super_block *sb, struct fuse_fs_context *ctx,
+			 unsigned int mode)
+{
+	struct fuse_mount *fm = get_fuse_mount_super(sb);
+	struct fuse_conn *fc = fm->fc;
+	struct inode *root;
+	struct dentry *root_dentry;
+	int err;
+
 	err = -ENOMEM;
-	root = fuse_get_root_inode(sb, ctx->rootmode);
+	root = fuse_get_root_inode(sb, mode);
 	sb->s_d_op = &fuse_root_dentry_operations;
 	root_dentry = d_make_root(root);
 	if (!root_dentry)
@@ -1762,18 +1801,12 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	sb->s_d_op = &fuse_dentry_operations;
 
 	mutex_lock(&fuse_mutex);
-	err = -EINVAL;
-	if (ctx->fudptr && *ctx->fudptr)
-		goto err_unlock;
-
 	err = fuse_ctl_add_conn(fc);
 	if (err)
 		goto err_unlock;
 
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
-	if (ctx->fudptr)
-		*ctx->fudptr = fud;
 	mutex_unlock(&fuse_mutex);
 	return 0;
 
@@ -1781,15 +1814,15 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	mutex_unlock(&fuse_mutex);
 	dput(root_dentry);
  err_dev_free:
-	if (fud)
-		fuse_dev_free(fud);
- err_free_dax:
+	if (ctx->fudptr && *ctx->fudptr) {
+		fuse_dev_free(*ctx->fudptr);
+		*ctx->fudptr = NULL;
+	}
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_conn_free(fc);
- err:
 	return err;
 }
-EXPORT_SYMBOL_GPL(fuse_fill_super_common);
+EXPORT_SYMBOL_GPL(fuse_make_root_inode);
 
 static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 {
@@ -1810,11 +1843,14 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	ctx->fudptr = &ctx->file->private_data;
 
 	err = fuse_fill_super_common(sb, ctx);
+	if (err)
+		return err;
+	err = fuse_make_root_inode(sb, ctx, ctx->rootmode);
 	if (err)
 		return err;
 	/* file->private_data shall be visible on all CPUs after this */
 	smp_mb();
-	fuse_send_init(get_fuse_mount_super(sb));
+	fuse_send_init(get_fuse_mount_super(sb), false);
 	return 0;
 }
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6404a189e989..ae6e9ee15556 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1541,6 +1541,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 	struct virtio_fs *fs = fc->iq.priv;
 	struct fuse_fs_context *ctx = fsc->fs_private;
 	unsigned int i;
+	unsigned int rootmode;
 	int err;
 
 	virtio_fs_ctx_set_defaults(ctx);
@@ -1577,6 +1578,12 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 		}
 		ctx->dax_dev = fs->dax_dev;
 	}
+
+	/*
+	 * Begin sb initialization, fuse_send_init() and process_init_reply()
+	 * need it.  Cannot create the root inode yet, we need to wait for the
+	 * INIT reply to know its inode mode.
+	 */
 	err = fuse_fill_super_common(sb, ctx);
 	if (err < 0)
 		goto err_free_fuse_devs;
@@ -1589,12 +1596,27 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 
 	/* Previous unmount will stop all queues. Start these again */
 	virtio_fs_start_all_queues(fs);
-	fuse_send_init(fm);
+	fuse_send_init(fm, true);
+
+	err = fuse_get_rootmode(fm, &rootmode);
+	/* On error, fall back to the default (probably S_IFDIR) */
+	if (err < 0)
+		rootmode = ctx->rootmode;
+
+	err = fuse_make_root_inode(sb, ctx, rootmode);
+	if (err < 0)
+		goto err_free_fuse_devs;
+
 	mutex_unlock(&virtio_fs_mutex);
 	return 0;
 
 err_free_fuse_devs:
-	virtio_fs_free_devs(fs);
+	/*
+	 * After INIT, virtio_fs_conn_destroy() will be called by
+	 * virtio_kill_sb(), so there is no need to clean up here
+	 */
+	if (!fc->initialized)
+		virtio_fs_free_devs(fs);
 err:
 	mutex_unlock(&virtio_fs_mutex);
 	return err;
@@ -1635,8 +1657,16 @@ static void virtio_kill_sb(struct super_block *sb)
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	bool last;
 
-	/* If mount failed, we can still be called without any fc */
-	if (sb->s_root) {
+	/*
+	 * Only destroy the connection after full initialization, i.e.
+	 * once s_root is set (see commit d534d31d6a45d).
+	 * One exception: For virtio-fs, we call INIT before s_root is
+	 * set so we can determine the root node's mode.  We must call
+	 * DESTROY after INIT.  So if an error occurs during that time
+	 * window (specifically in fuse_make_root_inode()), we still
+	 * need to call virtio_fs_conn_destroy() here.
+	 */
+	if (sb->s_root || (fm->fc && fm->fc->initialized && !fm->submount)) {
 		last = fuse_mount_remove(fm);
 		if (last)
 			virtio_fs_conn_destroy(fm);
-- 
2.47.0


