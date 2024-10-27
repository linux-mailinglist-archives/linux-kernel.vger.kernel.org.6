Return-Path: <linux-kernel+bounces-383555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AF59B1D40
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EFF1C20B98
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4758413AA2A;
	Sun, 27 Oct 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TbLNQk6c"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA440849
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730025262; cv=none; b=KduUSQ/mcxYqggWm1vO6OeKIB4XC/oVLnAysReOn6oxt0Ktf4AGbxePVwUxOAadhUlOf6mdKvIKlv19s01XNimNPEZlOI4M20TkiObkgIT3rayFRr7PqQ9LFI7nFFtp36kXwChrjDleae/Y+nUqnEUPWyqsCowhDXLWViESFfcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730025262; c=relaxed/simple;
	bh=U0vfj/fwewTx0ExeELi3naIzm3Hi1n3wU/yakDeXY2I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jClkr4aDtJFXBl5hsFjMltbOIHFkuQtCulAsPSZJSvKA3eceR1ww0/4gUuW7vLgqyQEo1z4UHkO1JUgSdMfxC0RKtqEorDOwSqqI7AuFZYVM1nxoMpt4dzkSGkmfwX8BcmvK2K7dFt+R5LGDJ+K5jFkCDDAimWy9dzRtE4aTd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TbLNQk6c; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730025248; bh=OrpPFq18HK2qa08dC8eIQcGtK5Q4KDtY8NgS9AsiREM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TbLNQk6cK0cOONf9MTXS65NA2/2RpmtXlyphW1/PRIR7nFZLkIokN2Jbqdq4g8WYM
	 ZbeiZ8uE3M3nySDukyKqDj7Qg0YZyj3n0IZ6JHB4rfCUDLs5J8S3u7DNXsJu89WWnX
	 FPH6Eu8/m9VLqJ3d97jxLyrrdCZ+0DdhkVpGLJ+0=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 6B61EA36; Sun, 27 Oct 2024 18:26:54 +0800
X-QQ-mid: xmsmtpt1730024814tk9f89o9v
Message-ID: <tencent_982EDE6ECA0C9127E346D612C6866189AC06@qq.com>
X-QQ-XMAILINFO: OZ7HbAk7YCRi/z1HqGAjuVhQk92IL8gc80BRxjv0jpEyzR7+jlPVCT5ScxYFqd
	 Nco9zdZUOhxSvKEFwYTSz1WuTWYYtQfnZZBcUZ8aqwd1UgC/ZOLqcydqUh8Ft3+Q6+XowvUZ5QJu
	 29Tqgl2I07XkYX6EDBGYSp6QXcnr9GOFYfG/rUDiV9iitB6mN18mI5pGZ1VEfr0+xQb8K7TfoPkA
	 3mYfHoNynttZJXyb+YSrGEhZFiX5EItYXO9DjyEWesDN19eX8SHTBd+qw6u4MZLeLZiSGuJzPKHk
	 Cr+u6CDVEZeZ8HPtpYduIzsjjOn2jA+TaEpnRWjb/N95PiI0gaopJzXSAFeJU0aTtDspNYK0gB9k
	 //4VxBNich3D/EoB0DwmqPlxc+m425zgpim58T/sLliiyLbzDAIS8DcaQJ0NmlQSKmeT202lr8hO
	 n468TFUelmbirQZMSrIwZfy6mlb1rSwtfMtXY56BnB7h4mKCmbZ1zzIqeL2KwTIafVgb/1cXWDLh
	 593kMBIbXNNMfznmlcDom/N8ttG/6bGrj9drtb7FY1CQb2UmKkjhnjPu3uIGWurhU+2IDvR4oQ8a
	 Dd2BaCglc9HjcD+Jby1/mO3q/xhna0yFD44Jp9nxEMaqYxLa6Qj4l90QJnJNyzOiLAksK801xSUB
	 J3BMidgBZDVrH0jsUdAV/NpKxeXCAxxbAxnoytNM2SemJjOqyzZmzcfpd5Ly7Lt8sTOc+ZS3AAEB
	 WpIcsf03koEQr8G1rR6PlCcrTABgBIvGdfP8TDh0MQzd3OJR/t1PtmE7ZxvDYObyWwNELqUX4z32
	 ovdbkaeuS/Q0gOPmSLJC3zcPrLqbQur5u6DNyP+zBWbmyM+TQW149LXx7F1sXmIlnTsjOu5lvEnD
	 okFbB1oJxAXYTmNJ8ggqCfl5IgVE1YKflcHrtAS8a16XPjZMz8rV0Wvd7XTUwkH2h5xVCJUandgb
	 0HgMMpA/+mCjhgTpyRCOgwz1w19FX+S5aBqjohKA7FVL5fd5Fp0vSl51fl9K+uMkysI5Lip6o=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Write in ext4_insert_dentry
Date: Sun, 27 Oct 2024 18:26:54 +0800
X-OQ-MSGID: <20241027102653.1835908-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <671c2223.050a0220.2fdf0c.021c.GAE@google.com>
References: <671c2223.050a0220.2fdf0c.021c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check next directory entry space if it is too smaller than file name exit dentry insert and return -EINVAL 

#syz test

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..dbd062f80c22 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2834,7 +2834,7 @@ extern int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 			     void *buf, int buf_size,
 			     struct ext4_filename *fname,
 			     struct ext4_dir_entry_2 **dest_de);
-void ext4_insert_dentry(struct inode *dir, struct inode *inode,
+int ext4_insert_dentry(struct inode *dir, struct inode *inode,
 			struct ext4_dir_entry_2 *de,
 			int buf_size,
 			struct ext4_filename *fname);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..e318b13459d1 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1022,7 +1022,9 @@ static int ext4_add_dirent_to_inline(handle_t *handle,
 					    EXT4_JTR_NONE);
 	if (err)
 		return err;
-	ext4_insert_dentry(dir, inode, de, inline_size, fname);
+	err = ext4_insert_dentry(dir, inode, de, inline_size, fname);
+	if (err)
+		return err;
 
 	ext4_show_inline_dir(dir, iloc->bh, inline_start, inline_size);
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 790db7eac6c2..4ce1b207a4c0 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2084,24 +2084,38 @@ int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 	return 0;
 }
 
-void ext4_insert_dentry(struct inode *dir,
+int ext4_check_next_dentry(struct inode *dir,
 			struct inode *inode,
 			struct ext4_dir_entry_2 *de,
 			int buf_size,
 			struct ext4_filename *fname)
 {
-
 	int nlen, rlen;
 
 	nlen = ext4_dir_rec_len(de->name_len, dir);
 	rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
 	if (de->inode) {
-		struct ext4_dir_entry_2 *de1 =
+		struct ext4_dir_entry_2 *nde =
 			(struct ext4_dir_entry_2 *)((char *)de + nlen);
-		de1->rec_len = ext4_rec_len_to_disk(rlen - nlen, buf_size);
+		nde->rec_len = ext4_rec_len_to_disk(rlen - nlen, buf_size);
 		de->rec_len = ext4_rec_len_to_disk(nlen, buf_size);
-		de = de1;
+		de = nde;
+		rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
+		return fname_len(fname) > rlen - EXT4_BASE_DIR_LEN;
 	}
+
+	return 0;
+}
+
+int ext4_insert_dentry(struct inode *dir,
+			struct inode *inode,
+			struct ext4_dir_entry_2 *de,
+			int buf_size,
+			struct ext4_filename *fname)
+{
+	if (ext4_check_next_dentry(dir, inode, de, buf_size, fname))
+		return -EINVAL;
+
 	de->file_type = EXT4_FT_UNKNOWN;
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext4_set_de_type(inode->i_sb, de, inode->i_mode);
@@ -2114,6 +2128,8 @@ void ext4_insert_dentry(struct inode *dir,
 		EXT4_DIRENT_HASHES(de)->minor_hash =
 						cpu_to_le32(hinfo->minor_hash);
 	}
+
+	return 0;
 }
 
 /*
@@ -2151,7 +2167,11 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 	}
 
 	/* By now the buffer is marked for journaling */
-	ext4_insert_dentry(dir, inode, de, blocksize, fname);
+	err = ext4_insert_dentry(dir, inode, de, blocksize, fname);
+	if (err) {
+		ext4_std_error(dir->i_sb, err);
+		return err;
+	}
 
 	/*
 	 * XXX shouldn't update any times until successful


