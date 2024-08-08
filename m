Return-Path: <linux-kernel+bounces-279372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8028694BC73
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959B71C21FDA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE33D18B498;
	Thu,  8 Aug 2024 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TtsIFwg2"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73D718B486
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117473; cv=none; b=kefWU7p+Wt1aR8ewQKwzJU7l0JUi+yNclMYSvUKlvulQKrfJzRdd5tU84JlnQg7AMa0yqVPFhEM0Vi7yNPsFFDEyEa2XrI2kB5DK+HCcMt4SJHN5OcZu6MZbxgqnPPRV2h8xQ+tkwQdcHAK3sHaR7rEb4HRdDcZqdNiWpnU8Dbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117473; c=relaxed/simple;
	bh=QgU7UXkJC6Rt+BWyGmqdsNOUSAzdtPXRmOlQ8vu4pjM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XQzFNs9fVjWzisXVaF6BKmTyoHenBfQYYEKwAKpdmi6WfWXnB+IHqF9+CJpa74O2diOJTy0Q0JvmKwhIG9233nqPTMEyM2gc3j9MYOsaDsK657Sf1z+zD3bvjIVXNZzgot1h7bfC8UGCUROnPeoP7Tx/bgddpMDsC5ntJzGr9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TtsIFwg2; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723117465; bh=b7gRcWoA+BN+7i2mCePrjVznEOKNCmTQ5s7sIeXZzhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TtsIFwg2lL1e5TGaGnCuqYXZTmXWxRcQRwk7BPPv94dAgI3j0ve5W0A+MwfyMXu0g
	 4UwLhy+oR5pYvr+IwVt/OeYtoNE89f3OJ3v/VAMLRptam8uvlDJ6iAxfDI73g4CH+F
	 TVcxR+RbRecXmCAt8I9HQZT6f5mViY6IWMXRFkTg=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id B17372B5; Thu, 08 Aug 2024 19:44:23 +0800
X-QQ-mid: xmsmtpt1723117463tu7c4vzdo
Message-ID: <tencent_F967B76846D6B362E37D496623ACA4433705@qq.com>
X-QQ-XMAILINFO: MDu3ByXbImtOFHNdTCVp7TWCsO8wAySFAJlS7KI6D7C2B0hAXGwye95D9caxI/
	 /45KH2prQby1upqFhCuJcXDP+NhP8WARcI+5wzbC/dI10zzo5kI0wrs2L06ic4wuDqPqSchloDBx
	 VgrP/tXb9RpcBq03aMk2i2GtwF99zqmXjVOHCTAysbKV7Nt3wK2nQDj91RaqgdjgMaFLo8j1DK+3
	 fO4Mpa3WGLQZiDTeFQTYYAcgvG4cHU9/ROP4GftgLKJbI2OfXBb3bVM8dHHUeRuXizm77CMR3NUe
	 XIKL/9Txjx16m7qFt42nCGYgfUVPg7IrNdVuszmJosjBseXo4V0k9DzrNOcpfW5vN5/DdsyvqFRf
	 aF/ScJ4xfFsJqPay+edbHJxA09NTWNsX3dH93uvaTUJK5vl9iWYtEdKvUyl+ktFyWGfwUimd7rER
	 5UjY4eRATGHvqHfH2mHE+yLpynLqyA47qkYgg9tmUd+NSypufqz7BxqhN/dIa7pJ2lr7x5LSF3XL
	 TRvk4VZZKVCVb561jjmFL5P659EmruHMZ8s0BtDJT6A2FTtQugTGkgGzNkj2/6MnEFuR1enlJH6b
	 xqDyTHMafv9s8SDcL5wPnsX6QSM43QvCcv7UeAOGvQeEZk6zj+ckeVArUKW9mZNu9xLHRuFURKZw
	 ZIv8kg3SBGblRxuW0y8DIodHwLz+37VXgY+4yTH5XPuy5AEGwEKqwQ6zSt0/ZY2I/NrOJ2AdYhvS
	 PxaVnwi/CT/dC91v93KwD+1nUNUKGkmX4mk/vKh2GmIk/9iR180U0EA5DCLuUP3ADv/EhjcP0kx5
	 CJkjYaktvFKZTHZuqZxRuMYaazGHI9jpGBED0AzpYn3MwcVxQnaSmt/Vj7PaHJWUMYmt1a0GVvnu
	 q2jUDDnaRQiiRdS+taGlDGap8euHA53KuhSXxh1JpwpvVpPbBA6f0Jsc5MrbXa4HhpRMFg7/3cXv
	 2qyzd7ELmBHG5wPN/eYCY8Xqcx9s0m44zGAAirdE85EerfgseMrQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Thu,  8 Aug 2024 19:44:23 +0800
X-OQ-MSGID: <20240808114422.1314774-2-eadavis@qq.com>
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
index 348cc90bf9c5..5329b83829e4 100644
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
@@ -87,8 +90,13 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 				   file->f_mode & FMODE_WRITE);
 #endif
 	v9fs_fid_add_modes(fid, v9ses->flags, v9ses->cache, file->f_flags);
+	printk("2ind: %p, %s\n", inode, __func__);
 	v9fs_open_fid_add(inode, &fid);
 	return 0;
+error:
+	printk("err: %d, ind: %p, %s\n", err, inode, __func__);
+	return err;
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


