Return-Path: <linux-kernel+bounces-287744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF12952C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFA71C235FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFF920FA85;
	Thu, 15 Aug 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eNbIQsEv"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78428201266
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713903; cv=none; b=JBeEwTnyIzuZqRTCyBFMEQT5G1nwv3Udt7cN3eiUF6pwUdh4SInalTZJU3COCWkqQpt7h1Mt0JnnxGYc1+rCvrAy9x3281Mmti5lxJExjY/4Mnfl5dEO8xIEqSn7lolMPmhszZKjSAcf750URJ+GPkvFqhgl+7D9Ft/LNRvEsMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713903; c=relaxed/simple;
	bh=WQyGP3ArX26n53a7N84tK4GY62m6jwfx6zeJykj/kFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FQWzMaZEUq8UkSfk5mIjZ3H+eWlCll9sN28nLKfRDq+jBLKXMQ2rruKA8yh9bD5lD7hD1aSvtt46IY+ZuNR6Kfp/XCideLZI/PwokPL25pJX3/tnxWFcycbptqpG7pRuY7HPX205LysIVpTIAAPV/wSzpt/Fdy9VM3J9XwSmA6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=eNbIQsEv; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0416B3F366
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713901;
	bh=Cr6mS4vM8svS+Y0pvJjPEy2yIGPChWIqWWxar373974=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=eNbIQsEvZldRwn49O7RMTs8/4A1+0NbR22unjmkn9RNI2PSOTYrZpPgH6JlItTBh4
	 NdG8u+Rtjsvvjz76ZBCR0tUjzfwy9zsfy/O/vfEMlXY1HL7giQVAR8+I6q0xJOxdcF
	 Ga/zKXVbxIzfEHq1M7vbs2PZgB0Eu7q1xmDueTqQk1U+mDhzw63XgLiq/POYtihnFy
	 j68cltb2J8miKV82LhGCLITraIAbYyFC8sGoUgLIDCBDRE4KaNORk6T5QsGbzMFbKT
	 Sg9B5Pvci6+2eMTt2J5xPFBbI+eKkyHJ8V3NqgNJNTVnZHI01GhQL8noWY9LMdxwUL
	 pRQ2JR7Z5oSQg==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7ac5d81e2dso56127066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713900; x=1724318700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr6mS4vM8svS+Y0pvJjPEy2yIGPChWIqWWxar373974=;
        b=uct9INnIiBO1H+0SYNoeMcY0wDToy3AD/HurMFjZnTyRXcrAz1dhhZgDnuSSNF8brx
         nVHIT+qtEzXRbXaM+RsMzVS8H467/RAinqMEIDaysFkkXEcyrD5EQWSWPpVMix1q7IYY
         XIvBWUVTz4naFFeFGrWceAuuax4GRLNU6vgD+eY5M7yVQGXOTyKUQGXjeyLmIU7pV4ah
         X1WWKNjqkBBeJugTwtl6ciqyk5OMeS72fZVXP++WSObVrxklfrnseP/LCPbTp/8gujfM
         fL9debNuxDSA1BPZDr1QhBMl+fuM4LTPhjlrNjHK7Z3/T78ujC971uqHszKBamGOfDS5
         Uf9g==
X-Forwarded-Encrypted: i=1; AJvYcCVSYf9viIlZS2FSuNb2iXhim+1CEM0ymBnb/aWjmnFQuorb8HeepN+4pL3bq99ZtfNH+9tbFHukMWCfZcVEPprY+R4J0J00T3XZpEk+
X-Gm-Message-State: AOJu0YzMJ0Bei05Yu9H27De6Nm1NQqhUgVVj2heiOaOorDDPzzkrdVFD
	Xtu+npcYMm7eKIV/IT2bFSjn4Vbmam+fQfYwo3y1ZCP1HTUYpedo8ceY/KAhfGKnfByXkCCJuW5
	HH0ALDEGbExlVWm9IA7+XI2/XG8y1gsmFk81IWVWQ8PVxV4FRY/nJ5aoY9XR5clWi3NNaBZQ0cN
	qEZw==
X-Received: by 2002:a17:907:3f89:b0:a7a:a33e:47b7 with SMTP id a640c23a62f3a-a83670722aemr419369166b.69.1723713900164;
        Thu, 15 Aug 2024 02:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEghyVaXn5Dbtn6avz2ju4iyCpDYekR/UIUNfpUCzBfAEqAmdPwUCKFJ/4+cn52QZhbpY2Qjw==
X-Received: by 2002:a17:907:3f89:b0:a7a:a33e:47b7 with SMTP id a640c23a62f3a-a83670722aemr419367866b.69.1723713899831;
        Thu, 15 Aug 2024 02:24:59 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:24:59 -0700 (PDT)
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
Subject: [PATCH v3 06/11] fs/fuse: support idmapped ->setattr op
Date: Thu, 15 Aug 2024 11:24:23 +0200
Message-Id: <20240815092429.103356-7-aleksandr.mikhalitsyn@canonical.com>
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

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v2:
	- pass idmap in more cases to make code easier to understand
---
 fs/fuse/dir.c    | 32 +++++++++++++++++++++-----------
 fs/fuse/file.c   |  2 +-
 fs/fuse/fuse_i.h |  4 ++--
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index cd3b91b60cae..c50f951596dd 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1771,17 +1771,27 @@ static bool update_mtime(unsigned ivalid, bool trust_local_mtime)
 	return true;
 }
 
-static void iattr_to_fattr(struct fuse_conn *fc, struct iattr *iattr,
-			   struct fuse_setattr_in *arg, bool trust_local_cmtime)
+static void iattr_to_fattr(struct mnt_idmap *idmap, struct fuse_conn *fc,
+			   struct iattr *iattr, struct fuse_setattr_in *arg,
+			   bool trust_local_cmtime)
 {
 	unsigned ivalid = iattr->ia_valid;
 
 	if (ivalid & ATTR_MODE)
 		arg->valid |= FATTR_MODE,   arg->mode = iattr->ia_mode;
-	if (ivalid & ATTR_UID)
-		arg->valid |= FATTR_UID,    arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
-	if (ivalid & ATTR_GID)
-		arg->valid |= FATTR_GID,    arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
+
+	if (ivalid & ATTR_UID) {
+		kuid_t fsuid = from_vfsuid(idmap, fc->user_ns, iattr->ia_vfsuid);
+		arg->valid |= FATTR_UID;
+		arg->uid = from_kuid(fc->user_ns, fsuid);
+	}
+
+	if (ivalid & ATTR_GID) {
+		kgid_t fsgid = from_vfsgid(idmap, fc->user_ns, iattr->ia_vfsgid);
+		arg->valid |= FATTR_GID;
+		arg->gid = from_kgid(fc->user_ns, fsgid);
+	}
+
 	if (ivalid & ATTR_SIZE)
 		arg->valid |= FATTR_SIZE,   arg->size = iattr->ia_size;
 	if (ivalid & ATTR_ATIME) {
@@ -1901,8 +1911,8 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
  * vmtruncate() doesn't allow for this case, so do the rlimit checking
  * and the actual truncation by hand.
  */
-int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
-		    struct file *file)
+int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		    struct iattr *attr, struct file *file)
 {
 	struct inode *inode = d_inode(dentry);
 	struct fuse_mount *fm = get_fuse_mount(inode);
@@ -1922,7 +1932,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
 
-	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	err = setattr_prepare(idmap, dentry, attr);
 	if (err)
 		return err;
 
@@ -1981,7 +1991,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 
 	memset(&inarg, 0, sizeof(inarg));
 	memset(&outarg, 0, sizeof(outarg));
-	iattr_to_fattr(fc, attr, &inarg, trust_local_cmtime);
+	iattr_to_fattr(idmap, fc, attr, &inarg, trust_local_cmtime);
 	if (file) {
 		struct fuse_file *ff = file->private_data;
 		inarg.valid |= FATTR_FH;
@@ -2116,7 +2126,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	if (!attr->ia_valid)
 		return 0;
 
-	ret = fuse_do_setattr(entry, attr, file);
+	ret = fuse_do_setattr(idmap, entry, attr, file);
 	if (!ret) {
 		/*
 		 * If filesystem supports acls it may have updated acl xattrs in
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..562bdf8d5976 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2966,7 +2966,7 @@ static void fuse_do_truncate(struct file *file)
 	attr.ia_file = file;
 	attr.ia_valid |= ATTR_FILE;
 
-	fuse_do_setattr(file_dentry(file), &attr, file);
+	fuse_do_setattr(file_mnt_idmap(file), file_dentry(file), &attr, file);
 }
 
 static inline loff_t fuse_round_up(struct fuse_conn *fc, loff_t off)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d06934e70cc5..883151a44d72 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1333,8 +1333,8 @@ bool fuse_write_update_attr(struct inode *inode, loff_t pos, ssize_t written);
 int fuse_flush_times(struct inode *inode, struct fuse_file *ff);
 int fuse_write_inode(struct inode *inode, struct writeback_control *wbc);
 
-int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
-		    struct file *file);
+int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		    struct iattr *attr, struct file *file);
 
 void fuse_set_initialized(struct fuse_conn *fc);
 
-- 
2.34.1


