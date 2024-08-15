Return-Path: <linux-kernel+bounces-287740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B61E5952C14
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F7DB251ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330B020010B;
	Thu, 15 Aug 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="q73mGquI"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFAD1EB4B2
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713894; cv=none; b=BHedGs3tfD7eZsnXVenwLBwK2R85G2b8C3uTbnVmv5ibT+zFJ8CBILUoI24GW0EciYCsATiLLYQ8SE6zkI0R79jr8a7LJlJNTzIjcabxL/9DJeC2H91R0JJ/kuv2rrl+d4oBYu4U8+PIZmGOFkp5qzEzHMcsN4IVqMFYPgI7+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713894; c=relaxed/simple;
	bh=3sKR5heXsN3+PDmKkyp9ATdAOr7cyhuezAbCen+o5+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aAZw74gfkDGsRVPLEqydjUNR5ZXrs3lW5HAiK0QZeQjqt1WenGUSSTAn3uIpQBpYWsq+5JReGnEC204YVYaq2aOmXljHcvJMVHG4UbG+6V8aw72hSJgOsfnGjX1G4qX91d4dtBONFstUyp7MvNfEfIcjkKyrjmP9m5XpVAuAI9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=q73mGquI; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CA1553F366
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713890;
	bh=m96HZWLn8OKWP/L3it/bQmtO6VIcFcKI507cIhh46m0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=q73mGquI69OZGNL5MIQiAYWxMsQkln182oyfjfzT3Hy/p+RF76g4EgYMBeHbCvxn4
	 5WabbO05loSFMXCJ2Our2XCTdv0bNrqncrs/b+TJU996uGdWVjfqgD0rKgjAjXbmCA
	 TNDSyDS2g58U9xEbXHJUY4kP7vzLb6QJL9DjYvnXANfpA6cG/lgHWLAOv475RvFA5r
	 kGXMN2gQnkH91qdeiq+uMnQxS75ej0pfikABIpdctCqvjkjGuMHCpptsw4fznV5nJL
	 eFFII03xHx4X5TLiakNW+xnuZbg0pmpD+j50l/VD2g7QYoaCMbwxj18XQmKuO1ZPoG
	 pHqt0mAPZAjXA==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7aa020cef5so58081966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713890; x=1724318690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m96HZWLn8OKWP/L3it/bQmtO6VIcFcKI507cIhh46m0=;
        b=ZsaTxVnysh/XjAcjXvQHBUQuUn2arKz9K3NMqunXeorTvRKP0m3jNwTIfUC02JKLIW
         m1qsPRmyTPe88yiWfpfD9p6sgoTb8Q8uPFizHijIS5I2HZ1VgW5wIk2MXYam9e5ch+nA
         1doOa39nfgj2B5SMNHZ28y+cwRqdTCYXW3FyY2tDN9cJ+XL4FQOD0WtZoZTfUlm+9hVH
         wEfg8ilgJMNHGbT9mJ5EOYIDiysu8XgXNE1Kow634cc93bjpxJo3LrkFL3N5rVDWtVcX
         PPEmatW/xXjgf2qf5o7WD+Yj0buonIDN7Ouf/6BrYNDXjoH8ogElnyuWF/ToemyKx6pU
         VMqg==
X-Forwarded-Encrypted: i=1; AJvYcCUwRctW1CFuLQ0KphNf5HfSkb2WG0fJrZpr41lhkfJUYMJrh4t500CZhp5ueBaAKT419WU71KqenWU7+IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr8csM66skFllrZisOKJEzWd0lb//nT63xrIijHEkWYeynA28c
	Bc40gPGVk1M+rYfPaRRirF8o1HJq0KWPv4cXj0PiSrky1a7WIufwRFwpvaaLZBHeIxxZUK/DlXf
	SAE3FsojdZtDDwjtKjbSSabP0ROWen7wfc4hsG7qYybKsM95PkNksveFIlh/IHfDWrAtivlYgz3
	r5JQ==
X-Received: by 2002:a17:907:e686:b0:a7a:bc34:a4c0 with SMTP id a640c23a62f3a-a8367017958mr340288166b.45.1723713889867;
        Thu, 15 Aug 2024 02:24:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2JvonBW7VByiYt9qrK3OXi7/p00XdZN0Z3eAkYXMajB1mk3hDfAZbiimTYiDiMwXegHifNg==
X-Received: by 2002:a17:907:e686:b0:a7a:bc34:a4c0 with SMTP id a640c23a62f3a-a8367017958mr340286066b.45.1723713889437;
        Thu, 15 Aug 2024 02:24:49 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:24:48 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Seth Forshee <sforshee@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/11] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
Date: Thu, 15 Aug 2024 11:24:19 +0200
Message-Id: <20240815092429.103356-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To properly support vfs idmappings we need to provide
a fuse daemon with the correct owner uid/gid for
inode creation requests like mkdir, mknod, atomic_open,
symlink.

Right now, fuse daemons use req->in.h.uid/req->in.h.gid
to set inode owner. These fields contain fsuid/fsgid of the
syscall's caller. And that's perfectly fine, because inode
owner have to be set to these values. But, for idmapped mounts
it's not the case and caller fsuid/fsgid != inode owner, because
idmapped mounts do nothing with the caller fsuid/fsgid, but
affect inode owner uid/gid. It means that we can't apply vfsid
mapping to caller fsuid/fsgid, but instead we have to introduce
a new fields to store inode owner uid/gid which will be appropriately
transformed.

Christian and I have done the same to support idmapped mounts in
the cephfs recently [1].

[1] 5ccd8530 ("ceph: handle idmapped mounts in create_request_message()")

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c             | 34 +++++++++++++++++++++++++++++++---
 fs/fuse/fuse_i.h          |  3 +++
 fs/fuse/inode.c           |  4 +++-
 include/uapi/linux/fuse.h | 19 +++++++++++++++++++
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2b0d4781f394..30d27d4f3b5a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -572,7 +572,33 @@ static int get_create_supp_group(struct inode *dir, struct fuse_in_arg *ext)
 	return 0;
 }
 
-static int get_create_ext(struct fuse_args *args,
+static int get_owner_uid_gid(struct mnt_idmap *idmap, struct fuse_conn *fc, struct fuse_in_arg *ext)
+{
+	struct fuse_ext_header *xh;
+	struct fuse_owner_uid_gid *owner_creds;
+	u32 owner_creds_len = fuse_ext_size(sizeof(*owner_creds));
+	kuid_t owner_fsuid;
+	kgid_t owner_fsgid;
+
+	xh = extend_arg(ext, owner_creds_len);
+	if (!xh)
+		return -ENOMEM;
+
+	xh->size = owner_creds_len;
+	xh->type = FUSE_EXT_OWNER_UID_GID;
+
+	owner_creds = (struct fuse_owner_uid_gid *) &xh[1];
+
+	owner_fsuid = mapped_fsuid(idmap, fc->user_ns);
+	owner_fsgid = mapped_fsgid(idmap, fc->user_ns);
+	owner_creds->uid = from_kuid(fc->user_ns, owner_fsuid);
+	owner_creds->gid = from_kgid(fc->user_ns, owner_fsgid);
+
+	return 0;
+}
+
+static int get_create_ext(struct mnt_idmap *idmap,
+			  struct fuse_args *args,
 			  struct inode *dir, struct dentry *dentry,
 			  umode_t mode)
 {
@@ -584,6 +610,8 @@ static int get_create_ext(struct fuse_args *args,
 		err = get_security_context(dentry, mode, &ext);
 	if (!err && fc->create_supp_group)
 		err = get_create_supp_group(dir, &ext);
+	if (!err && fc->owner_uid_gid_ext)
+		err = get_owner_uid_gid(idmap, fc, &ext);
 
 	if (!err && ext.size) {
 		WARN_ON(args->in_numargs >= ARRAY_SIZE(args->in_args));
@@ -668,7 +696,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_args[1].size = sizeof(*outopenp);
 	args.out_args[1].value = outopenp;
 
-	err = get_create_ext(&args, dir, entry, mode);
+	err = get_create_ext(&nop_mnt_idmap, &args, dir, entry, mode);
 	if (err)
 		goto out_put_forget_req;
 
@@ -798,7 +826,7 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	args->out_args[0].value = &outarg;
 
 	if (args->opcode != FUSE_LINK) {
-		err = get_create_ext(args, dir, entry, mode);
+		err = get_create_ext(&nop_mnt_idmap, args, dir, entry, mode);
 		if (err)
 			goto out_put_forget_req;
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..d06934e70cc5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -845,6 +845,9 @@ struct fuse_conn {
 	/* Add supplementary group info when creating a new inode */
 	unsigned int create_supp_group:1;
 
+	/* Add owner_{u,g}id info when creating a new inode */
+	unsigned int owner_uid_gid_ext:1;
+
 	/* Does the filesystem support per inode DAX? */
 	unsigned int inode_dax:1;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d8ab4e93916f..6c205731c844 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1343,6 +1343,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_NO_EXPORT_SUPPORT)
 				fm->sb->s_export_op = &fuse_export_fid_operations;
+			if (flags & FUSE_OWNER_UID_GID_EXT)
+				fc->owner_uid_gid_ext = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1390,7 +1392,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_OWNER_UID_GID_EXT;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..d9ecc17fd13b 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -217,6 +217,10 @@
  *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
  *  - add FUSE_NO_EXPORT_SUPPORT init flag
  *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
+ *
+ *  7.41
+ *  - add FUSE_EXT_OWNER_UID_GID
+ *  - add FUSE_OWNER_UID_GID_EXT
  */
 
 #ifndef _LINUX_FUSE_H
@@ -421,6 +425,8 @@ struct fuse_file_lock {
  * FUSE_NO_EXPORT_SUPPORT: explicitly disable export support
  * FUSE_HAS_RESEND: kernel supports resending pending requests, and the high bit
  *		    of the request ID indicates resend requests
+ * FUSE_OWNER_UID_GID_EXT: add inode owner UID/GID info to create, mkdir,
+ *			   symlink and mknod
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -466,6 +472,7 @@ struct fuse_file_lock {
 
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
+#define FUSE_OWNER_UID_GID_EXT	(1ULL << 40)
 
 /**
  * CUSE INIT request/reply flags
@@ -575,11 +582,13 @@ struct fuse_file_lock {
  * extension type
  * FUSE_MAX_NR_SECCTX: maximum value of &fuse_secctx_header.nr_secctx
  * FUSE_EXT_GROUPS: &fuse_supp_groups extension
+ * FUSE_EXT_OWNER_UID_GID: &fuse_owner_uid_gid extension
  */
 enum fuse_ext_type {
 	/* Types 0..31 are reserved for fuse_secctx_header */
 	FUSE_MAX_NR_SECCTX	= 31,
 	FUSE_EXT_GROUPS		= 32,
+	FUSE_EXT_OWNER_UID_GID	= 33,
 };
 
 enum fuse_opcode {
@@ -1186,4 +1195,14 @@ struct fuse_supp_groups {
 	uint32_t	groups[];
 };
 
+/**
+ * struct fuse_owner_uid_gid - Inode owner UID/GID extension
+ * @uid: inode owner UID
+ * @gid: inode owner GID
+ */
+struct fuse_owner_uid_gid {
+	uint32_t	uid;
+	uint32_t	gid;
+};
+
 #endif /* _LINUX_FUSE_H */
-- 
2.34.1


