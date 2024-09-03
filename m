Return-Path: <linux-kernel+bounces-313230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDB996A21C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A6E28A006
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CED198A25;
	Tue,  3 Sep 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FMzhZ5fd"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2BA194C7A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376645; cv=none; b=HZK7/yfpboPTAfpXrFbm0A6vA2mPRyl7Eou+SEhM4rEP3oDMcOABSIvpDOGHklP3AagzGgLbobi4Nn8CJ6zJ7mzd7otzp6bYzZMFHxL0F5SQIMLT74AfdFyEKes0GPyg2XAoDqGqqX5FDizwRea8nIVTqtK53hPorPKOPvGF3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376645; c=relaxed/simple;
	bh=ehliGmnl1/v4OS1SBQ/1Yg/WkwK3kW52iOkryOLCfho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nbwU34IGhjk97ERfPGdTZpM9awCvXzTQAfVVAD9EprRAa0Xx8UZhMGo4/w9zkVpcAyqjSOYh3wWJckLQ2kK3RKk2qFcxIDYMNieHYdOVqrZFJa3Y/M0MMt+Ic/Y0ftEJqrVj0LbjXHwE9Pk4HEoxx9WlVdesqmHR3TXIRdqVUD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FMzhZ5fd; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DCDE83FE20
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376641;
	bh=0EwUiOf4L2/aseOZrM6YVYPxFzCl5APUlbrPGfv+97I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=FMzhZ5fdMLpcaqZyivI941BaUfUrRwNqqMBvai9wiPMw66yfj/BDGgH6dBtlWbniu
	 BiBo+QsO1xUSsRI25NPe0H44Eo9HJ9NaaHpegGtY16xFGt4O1WJgIIN35ffQ8xWiWQ
	 SsLvAy5L9gUbwqioWL7EYR3bbYDhe0stCw4ZkC4vW8bVWLusnpyUXoIeNpwF00P7+Y
	 xzP6ibhRmtX7o0VCXRr0JdLcIHCHVK0uPRvgCICiemDTk6nISRJKDDOu/MrFZi3llF
	 OxB8WMbzJ/Ptw+4xgbCFwEHxasYXML5q1wPV0BUZuOkNiDhMNwQyonxUnQn3YHsfMg
	 fuWI0KfQovHOg==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c25d413306so1883852a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376641; x=1725981441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EwUiOf4L2/aseOZrM6YVYPxFzCl5APUlbrPGfv+97I=;
        b=WFLpqavm5MED8B1boBY6WvfPOr+og4eCXzKAgQC76h5cudYDWEAi0oQKg96PXU784L
         xANOoCHjIo+zHjWWoOpNInEN1NXar0Qhq4S9NFGa0zR3lHs2U1MxW5B0J+GrePZyJ3VB
         63pxbpo2GYAt828ziQH2wX5fcVxdXUlrKB2F8k0miZJh+2Q1gwbKvehwYvSQ3xtmrA25
         fcp0uOqj7CBa3i/Rafgwz8UQlilEbG1kFK1XUmZliD6rS5IWF5JSV66l9UUFYAlcNLAj
         25mmU2IQp0X5XVnNtx2mbyryEAXmWYrX+D6/L6Gm9ZA/sftNpLBM/3PTfM17XBI80wOv
         jK0A==
X-Forwarded-Encrypted: i=1; AJvYcCV8sCRO09ld1qFn2ColcBWb+Z/nakKgjN9tKyzzyJlEq/CjowG+XA0k92BRQZgBtAGT/MQJp9xd4D2AVas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy00JdxuRuNewnb6d04+whSidu5/H5IZ1+rVDAHan6kvlht949Z
	ktfbA8u6qs3uwXDjgxdR3BhmG5OOCRABpORXNR1ZaCgMjZonNkZvRfcR1Gw5lbkYLgpRNTxedtg
	eRBpUz3L68wcBD3fFofumJzSqEiWUfRqs6CQQaiKhTkaa+QS0TnPfePGXwtHoK7IDtUllujKyJ9
	jloA==
X-Received: by 2002:a17:906:6a05:b0:a7a:c106:364f with SMTP id a640c23a62f3a-a89d8848ef5mr664472966b.43.1725376641017;
        Tue, 03 Sep 2024 08:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuhIDZFbjriLVnYlTwRiB6qVXiOIP9ae8CETX4GnhIzLIqUwYrJLE5OqCJ4zuyI2v2otWlOA==
X-Received: by 2002:a17:906:6a05:b0:a7a:c106:364f with SMTP id a640c23a62f3a-a89d8848ef5mr664471266b.43.1725376640573;
        Tue, 03 Sep 2024 08:17:20 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:20 -0700 (PDT)
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
Subject: [PATCH v4 14/15] fs/fuse: allow idmapped mounts
Date: Tue,  3 Sep 2024 17:16:25 +0200
Message-Id: <20240903151626.264609-15-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now we have everything in place and we can allow idmapped mounts
by setting the FS_ALLOW_IDMAP flag. Notice that real availability
of idmapped mounts will depend on the fuse daemon. Fuse daemon
have to set FUSE_ALLOW_IDMAP flag in the FUSE_INIT reply.

To discuss:
- we enable idmapped mounts support only if "default_permissions" mode is enabled,
because otherwise we would need to deal with UID/GID mappings in the userspace side OR
provide the userspace with idmapped req->in.h.uid/req->in.h.gid values which is not
something that we probably want to. Idmapped mounts phylosophy is not about faking
caller uid/gid.

Some extra links and examples:

- libfuse support
https://github.com/mihalicyn/libfuse/commits/idmap_support

- fuse-overlayfs support:
https://github.com/mihalicyn/fuse-overlayfs/commits/idmap_support

- cephfs-fuse conversion example
https://github.com/mihalicyn/ceph/commits/fuse_idmap

- glusterfs conversion example
https://github.com/mihalicyn/glusterfs/commits/fuse_idmap

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v2:
	- simplified and get rid of ->allow_idmap global VFS callback
v3:
	- now use a new SB_I_NOIDMAP flag
v4:
	- small rebase changes
---
 fs/fuse/inode.c           | 12 +++++++++---
 include/uapi/linux/fuse.h | 20 +++++++++++++++++++-
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2e26810066e8..9f9456d3e466 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1343,6 +1343,12 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_NO_EXPORT_SUPPORT)
 				fm->sb->s_export_op = &fuse_export_fid_operations;
+			if (flags & FUSE_ALLOW_IDMAP) {
+				if (fc->default_permissions)
+					fm->sb->s_iflags &= ~SB_I_NOIDMAP;
+				else
+					ok = false;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1390,7 +1396,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
@@ -1980,7 +1986,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
-	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
+	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
 	.init_fs_context = fuse_init_fs_context,
 	.parameters	= fuse_fs_parameters,
 	.kill_sb	= fuse_kill_sb_anon,
@@ -2001,7 +2007,7 @@ static struct file_system_type fuseblk_fs_type = {
 	.init_fs_context = fuse_init_fs_context,
 	.parameters	= fuse_fs_parameters,
 	.kill_sb	= fuse_kill_sb_blk,
-	.fs_flags	= FS_REQUIRES_DEV | FS_HAS_SUBTYPE,
+	.fs_flags	= FS_REQUIRES_DEV | FS_HAS_SUBTYPE | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("fuseblk");
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2ccf38181df2..f1e99458e29e 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -217,6 +217,9 @@
  *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
  *  - add FUSE_NO_EXPORT_SUPPORT init flag
  *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
+ *
+ *  7.41
+ *  - add FUSE_ALLOW_IDMAP
  */
 
 #ifndef _LINUX_FUSE_H
@@ -252,7 +255,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 40
+#define FUSE_KERNEL_MINOR_VERSION 41
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -421,6 +424,7 @@ struct fuse_file_lock {
  * FUSE_NO_EXPORT_SUPPORT: explicitly disable export support
  * FUSE_HAS_RESEND: kernel supports resending pending requests, and the high bit
  *		    of the request ID indicates resend requests
+ * FUSE_ALLOW_IDMAP: allow creation of idmapped mounts
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -466,6 +470,7 @@ struct fuse_file_lock {
 
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
+#define FUSE_ALLOW_IDMAP	(1ULL << 40)
 
 /**
  * CUSE INIT request/reply flags
@@ -984,6 +989,19 @@ struct fuse_fallocate_in {
  */
 #define FUSE_UNIQUE_RESEND (1ULL << 63)
 
+/**
+ * This value will be set by the kernel to
+ * (struct fuse_in_header).{uid,gid} fields in
+ * case when:
+ * - fuse daemon enabled FUSE_ALLOW_IDMAP
+ * - idmapping information is not available and uid/gid
+ *   can not be mapped in accordance with an idmapping.
+ *
+ * Note: an idmapping information always available
+ * for inode creation operations like:
+ * FUSE_MKNOD, FUSE_SYMLINK, FUSE_MKDIR, FUSE_TMPFILE,
+ * FUSE_CREATE and FUSE_RENAME2 (with RENAME_WHITEOUT).
+ */
 #define FUSE_INVALID_UIDGID ((uint32_t)(-1))
 
 struct fuse_in_header {
-- 
2.34.1


