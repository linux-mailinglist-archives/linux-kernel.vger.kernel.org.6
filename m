Return-Path: <linux-kernel+bounces-279341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005FE94BC0D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CF51F220D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B40C187872;
	Thu,  8 Aug 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KuKBFgO0"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7510F9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115713; cv=none; b=c+VNyLL61ORyongYYJlAvGwRaLpFOf1C+36dmvmpkl45xp/xQ/lY/HsUS1fBoo+O5nsb3Z1DpmwL3EPlkAuODLzMkn8Bxg7PT4vcvaC/3AwYFXXBCNvt0t23nhn92VmPzShvhu4K18WAbDO8nTWXgNuSIgyVkRPePWVF8eSLMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115713; c=relaxed/simple;
	bh=VlLbHnoBUvgzo0/4b+vT8l9eZEtlypj9cjmzCtOIy6w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=m1lEJHy0yfe8yJ42cOCTXUsR3TlMTRRcfATEBLJcZx+W/3+OW7X8Zpn07eolvb7CpEE8N3kQBT4COrMM5kpLkhQL87acs2mY0SBq0pXpYL2CLFuMRf7Jx6CtAa26MoDQeCys6jdxfAwONQOHjYOO+Fp8g0oT0gQLI11FviSUHGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KuKBFgO0; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723115406; bh=COkWnKsPsilMoDYNZxGcD82fAVOaCJ/rNNrMju4jH9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KuKBFgO0lz09+ZNKoFz1xMinQgLsS8qLTjdz1xUfcXK7TzN/JpTCurqrE1ebE5w/R
	 gKLdKdM1nEbgAJms1VLZAfbbbjRPGVQcRWO26ffdGkjfggzrnT6tN7hJF3g/Cj/CYF
	 4bQSWQYd6+ErjxQd7GqZXbegnQZgJt/loZVP84Ok=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 2821B01A; Thu, 08 Aug 2024 19:10:02 +0800
X-QQ-mid: xmsmtpt1723115402tlik6e18k
Message-ID: <tencent_1E27F746D652D8C64C49BE6EDBAEEF4CA506@qq.com>
X-QQ-XMAILINFO: MXHIEC8P0R7hR8hvDqbuOHIfCJ9VhHV3iFRHCsmtFCeSb5i5zuCVOjgr2nO2jN
	 RgGI3Hy3Y+XTm6AgfuUjkziyCwUnKxq0MB3/rDek+GyjxTeDob/EFXLvtAchKqeqJYsc94ENoG02
	 aEmQV12oRvKC9JHK4hEhuRv3c1AmXrstuuF6N/7JviudyzC/Bu6zrntPVfYU/ET3JM4r31bIu2nl
	 XyNjGFuF6HSQFQDpHKgy/8fqBSw899nPDE6oVqQh6NRBgrdxh3lFNDfsYQ+OEx5qYVa3XtGxMLLH
	 Dw7miaQy7mmI65rI5wYtTW+Fpzp5iL1T7rPh7z2Sw6pw7vZFg8d8LqGMoaybD85r7Pt9T8zMUXa6
	 rN8aO+rSwSLDRYM64jR0QIapgCdwmw89jqKvJgiACLbUW04yX52VR+pvJAub8dMRT7LDtaVUbpYP
	 gra6lIWnCYJzVz6ePpUZa8eOt5ywOhJUfBWlDOZY+n4GkMtzhwy1Y5Bo6D04xX9SRVJA2bSm3rr8
	 HI8PCK831jmD6IZfT4Kjzh+1f96PAUHHoJ+naZdpJecO8Y4REBnV5/sfOg7Xgf/dI408SlSddooQ
	 0a1WFEyq5WzNJHATHM2P4X0/5JCiBbeya3FaZcQzPt33a90kjdXMPP/LwOEoI2nKNfTSaRit+60F
	 Iiy1zOFmNM+xjVGX1ejuCLT9TI0XgjKAOJSS1/aOR7ITg4NzDMKJ6yK904aqfuejP4jf5xbsmagn
	 DOtPgaKVK6bnZ2M8ou7UyJuInZswFx1W6B5IGKDINh8bu46MB+8LY8RhDFlFdVEfwbHeSjJ6ik7M
	 nfJmz3JjvnXzMu6zH7SwIZxhGdp/u/7jQMa90JC1MA+/X+OZnJwD1Rz9czi0IG0L4VS1lR2HzCLp
	 7lbKoxsjmM0XDMIHenJr+WoaMC2yQdTW+bmq0js6iOav/g2CWWw8RMNsdBdFuZTg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Thu,  8 Aug 2024 19:10:02 +0800
X-OQ-MSGID: <20240808111001.1278041-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000007ec511061f00a7b2@google.com>
References: <0000000000007ec511061f00a7b2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

debug

#syz test: upstream c0ecd6388360

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index de009a33e0e2..a5b716b716d4 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -67,6 +67,7 @@ struct p9_fid *v9fs_fid_find_inode(struct inode *inode, bool want_writeable,
 
 	spin_lock(&inode->i_lock);
 	h = (struct hlist_head *)&inode->i_private;
+	printk("ino: %p, inode fid list is empty: %d, %s\n", inode, hlist_empty(h), __func__);
 	hlist_for_each_entry(fid, h, ilist) {
 		if (any || uid_eq(fid->uid, uid)) {
 			if (want_writeable && !v9fs_is_writeable(fid->mode)) {
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 348cc90bf9c5..0da8ff7f38fb 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -44,6 +44,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	struct p9_fid *fid;
 	int omode;
 
+	printk("1ind: %p, %s\n", inode, __func__);
 	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
 	v9ses = v9fs_inode2v9ses(inode);
 	if (v9fs_proto_dotl(v9ses))
@@ -54,8 +55,10 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	fid = file->private_data;
 	if (!fid) {
 		fid = v9fs_fid_clone(file_dentry(file));
-		if (IS_ERR(fid))
-			return PTR_ERR(fid);
+		if (IS_ERR(fid)) {
+			err = PTR_ERR(fid);
+			goto error;
+		}
 
 		if ((v9ses->cache & CACHE_WRITEBACK) && (omode & P9_OWRITE)) {
 			int writeback_omode = (omode & ~P9_OWRITE) | P9_ORDWR;
@@ -72,7 +75,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 		}
 		if (err < 0) {
 			p9_fid_put(fid);
-			return err;
+			goto error;
 		}
 		if ((file->f_flags & O_APPEND) &&
 			(!v9fs_proto_dotu(v9ses) && !v9fs_proto_dotl(v9ses)))
@@ -87,8 +90,12 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 				   file->f_mode & FMODE_WRITE);
 #endif
 	v9fs_fid_add_modes(fid, v9ses->flags, v9ses->cache, file->f_flags);
+	printk("2ind: %p, %s\n", inode, __func__);
 	v9fs_open_fid_add(inode, &fid);
 	return 0;
+error:
+	printk("err: %d, ind: %p, %s\n", err, inode, __func__);
+
 }
 
 /**
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index fd72fc38c8f5..29a055f2fe7b 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -738,6 +738,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	int p9_omode;
 
+	printk("1ind: %p, %s\n", inode, __func__);
 	if (d_in_lookup(dentry)) {
 		res = v9fs_vfs_lookup(dir, dentry, 0);
 		if (IS_ERR(res))
@@ -781,6 +782,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 #endif
 
 	v9fs_fid_add_modes(fid, v9ses->flags, v9ses->cache, file->f_flags);
+	printk("2ind: %p, %s\n", inode, __func__);
 	v9fs_open_fid_add(inode, &fid);
 
 	file->f_mode |= FMODE_CREATED;
@@ -789,6 +791,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	return err;
 
 error:
+	printk("err: %d, ind: %p, %s\n", err, inode, __func__);
 	p9_fid_put(fid);
 	goto out;
 }
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index c61b97bd13b9..3c4c744af0e8 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -194,6 +194,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	struct posix_acl *pacl = NULL, *dacl = NULL;
 	struct dentry *res = NULL;
 
+	printk("1ind: %p, %s\n", inode, __func__);
 	if (d_in_lookup(dentry)) {
 		res = v9fs_vfs_lookup(dir, dentry, 0);
 		if (IS_ERR(res))
@@ -284,9 +285,11 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	}
 #endif
 	v9fs_fid_add_modes(ofid, v9ses->flags, v9ses->cache, flags);
+	printk("2ind: %p, %s\n", inode, __func__);
 	v9fs_open_fid_add(inode, &ofid);
 	file->f_mode |= FMODE_CREATED;
 out:
+	printk("err: %d, ind: %p, %s\n", err, inode, __func__);
 	p9_fid_put(dfid);
 	p9_fid_put(ofid);
 	p9_fid_put(fid);


