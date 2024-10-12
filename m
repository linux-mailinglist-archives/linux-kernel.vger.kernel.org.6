Return-Path: <linux-kernel+bounces-362223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C36AD99B25C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82CC32843D0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B380A14A604;
	Sat, 12 Oct 2024 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGM7KrL4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C18145B0F;
	Sat, 12 Oct 2024 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728723369; cv=none; b=thxLh0XFHLFyzE5u6vHqnUMECl9Dk1yvH3RZp3Vyoc6de9xwWg4ATRmMqi3JcX4Lw1jHDWOvRM8ZG4/1JTqM/duEwq8OSQ92Baf6iufD5Rt/Xh4YYB7b79R4CJSe4JHlsafGKryHVkc8Q//grindgkOe2tuL2NjfsEBjg3+ghRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728723369; c=relaxed/simple;
	bh=vATFG8shnKFunaoRDxD/P8NZHqYAHDJ9fb/RllpA1AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pA/9Ha4KEgmnyXDZ7VsiLUta5oxv8qPd24wPSe42qUhGBLMBPb2w9ZRvYV9WkOXOPjpyCi7j8eRJvvcNqsdiAgRwX9vqK3km2cien5DAouSxRnzXz6Xjdkejq+/eSPZL913ylNKML1MWWknBmF3Bw1CkXrG+VCnvCyx0V/Py9+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGM7KrL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E2BC4CEC6;
	Sat, 12 Oct 2024 08:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728723368;
	bh=vATFG8shnKFunaoRDxD/P8NZHqYAHDJ9fb/RllpA1AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGM7KrL4N5/OP7emMj86K2M/s1JgawQo7tZrreEC8AnsusjkN7fKEKtEbBjy+L6Px
	 MmfLM2+1v/fmuFd1ulfeJw6ws8RdwQDdiblm8liSrfPlT6KH4eYaMXSrZjCCtSt67P
	 cB3NVxV/V/aI8P9Se2uXVFvUZiQYxjVMdmHEIFqrU/xiZlZ+HP1ZAFfqfRHEkARfOP
	 gTnSc08UJ7ZYcydAkj4ajgVtBMAYGzkRRbX1O3KQXnBhalDheAVyjXhsgqiVn/qpwN
	 BaEWJ8w4bDgZc3DX7fF/3RSSd9NVkdext6MnSmqj47b1rHrsdDQtuwzffcGn46Tfb6
	 BNJC36DxUurqw==
Received: by pali.im (Postfix)
	id 0AA2F7BD; Sat, 12 Oct 2024 10:56:03 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] cifs: Add support for creating NFS-style symlinks
Date: Sat, 12 Oct 2024 10:56:01 +0200
Message-Id: <20241012085601.694-1-pali@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241012085252.560-1-pali@kernel.org>
References: <20241012085252.560-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CIFS client is currently able to parse NFS-style symlinks, but is not able
to create them. This functionality is useful when the mounted SMB share is
used also by Windows NFS server (on Windows Server 2012 or new). It allows
interop of symlinks between SMB share mounted by Linux CIFS client and same
export from Windows NFS server mounted by some NFS client.

New symlinks would be created in NFS-style only in case the mount option
-o reparse=nfs is specified, which is not by default. So default CIFS
mounts are not affected by this change.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/smb/client/reparse.c | 47 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 57320a4c4d79..cd12704cae0c 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -406,6 +406,8 @@ static int create_native_socket(const unsigned int xid, struct inode *inode,
 
 static int nfs_set_reparse_buf(struct reparse_posix_data *buf,
 			       mode_t mode, dev_t dev,
+			       __le16 *symname_utf16,
+			       int symname_utf16_len,
 			       struct kvec *iov)
 {
 	u64 type;
@@ -416,13 +418,18 @@ static int nfs_set_reparse_buf(struct reparse_posix_data *buf,
 	switch ((type = reparse_mode_nfs_type(mode))) {
 	case NFS_SPECFILE_BLK:
 	case NFS_SPECFILE_CHR:
-		dlen = sizeof(__le64);
+		dlen = 2 * sizeof(__le32);
+		((__le32 *)buf->DataBuffer)[0] = MAJOR(dev);
+		((__le32 *)buf->DataBuffer)[1] = MINOR(dev);
+		break;
+	case NFS_SPECFILE_LNK:
+		dlen = symname_utf16_len;
+		memcpy(buf->DataBuffer, symname_utf16, symname_utf16_len);
 		break;
 	case NFS_SPECFILE_FIFO:
 	case NFS_SPECFILE_SOCK:
 		dlen = 0;
 		break;
-	case NFS_SPECFILE_LNK: /* TODO: add support for NFS symlinks */
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -432,8 +439,6 @@ static int nfs_set_reparse_buf(struct reparse_posix_data *buf,
 	buf->InodeType = cpu_to_le64(type);
 	buf->ReparseDataLength = cpu_to_le16(len + dlen -
 					     sizeof(struct reparse_data_buffer));
-	*(__le64 *)buf->DataBuffer = cpu_to_le64(((u64)MINOR(dev) << 32) |
-						 MAJOR(dev));
 	iov->iov_base = buf;
 	iov->iov_len = len + dlen;
 	return 0;
@@ -444,21 +449,42 @@ static int mknod_nfs(unsigned int xid, struct inode *inode,
 		     const char *full_path, umode_t mode, dev_t dev,
 		     const char *symname)
 {
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct cifs_open_info_data data;
-	struct reparse_posix_data *p;
+	struct reparse_posix_data *p = NULL;
+	__le16 *symname_utf16 = NULL;
+	int symname_utf16_len = 0;
 	struct inode *new;
 	struct kvec iov;
 	__u8 buf[sizeof(*p) + sizeof(__le64)];
 	int rc;
 
-	p = (struct reparse_posix_data *)buf;
-	rc = nfs_set_reparse_buf(p, mode, dev, &iov);
+	if (S_ISLNK(mode)) {
+		symname_utf16 = cifs_strndup_to_utf16(symname, strlen(symname),
+						      &symname_utf16_len,
+						      cifs_sb->local_nls,
+						      NO_MAP_UNI_RSVD);
+		if (!symname_utf16) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		symname_utf16_len -= 2; /* symlink is without trailing wide-nul */
+		p = kzalloc(sizeof(*p) + symname_utf16_len, GFP_KERNEL);
+		if (!p) {
+			rc = -ENOMEM;
+			goto out;
+		}
+	} else {
+		p = (struct reparse_posix_data *)buf;
+	}
+	rc = nfs_set_reparse_buf(p, mode, dev, symname_utf16, symname_utf16_len, &iov);
 	if (rc)
-		return rc;
+		goto out;
 
 	data = (struct cifs_open_info_data) {
 		.reparse_point = true,
 		.reparse = { .tag = IO_REPARSE_TAG_NFS, .posix = p, },
+		.symlink_target = kstrdup(symname, GFP_KERNEL),
 	};
 
 	new = smb2_get_reparse_inode(&data, inode->i_sb, xid,
@@ -468,6 +494,11 @@ static int mknod_nfs(unsigned int xid, struct inode *inode,
 	else
 		rc = PTR_ERR(new);
 	cifs_free_open_info(&data);
+out:
+	if (S_ISLNK(mode)) {
+		kfree(symname_utf16);
+		kfree(p);
+	}
 	return rc;
 }
 
-- 
2.20.1


