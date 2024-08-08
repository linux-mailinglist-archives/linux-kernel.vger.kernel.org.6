Return-Path: <linux-kernel+bounces-279535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8991794BE98
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4628C281E3D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71B018E023;
	Thu,  8 Aug 2024 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BZTuDaSZ"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074118DF7A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124138; cv=none; b=L/lcNqpufbn2fM2sOn22dk9YzvlemOBwdpDaxFYvkpxxBb/uG+j9Dn75djTBdMcMN+vrXnhgBn/jzDzjvU7XDIBH2legBRSK0ClGcPkIVZboOYHvl36+U4UcHMYyiLHfN5lEUoX5IYmf5EzN1q0NOtu6MXA6nCmhzJyD4Emj9Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124138; c=relaxed/simple;
	bh=J/hWT73KQI+n51fwA8L2rgy2UTkZq5a4VUI83YDPfWs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=l2S3oZ7VWD0cRFVFS4hdWgmISj9VP8esproQjp+TL8nMco+4JgVfNSNhsxoEypFNey4hcQ6DYQgpHqV6C245DPoe4fQKyQzzDRukHBf6jQRh16zAvkwbaHMzl666W6+5midcyAsMgOM3FthgukYBCegyCpZJ4VSslsQV/qo8JBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BZTuDaSZ; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723124124; bh=7BXJXkSR8MdMnBz3VBHpQZT5QBUDypOobwnGslmWAAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BZTuDaSZzzC9HxWmMk2gi1xAFALvSHmbeZz4pQUz9j3LABJh70UN2AvZyrh35SH1b
	 HmlqyDWKMObwxD0muq9UFKj/9VGo58cYOQwv3Frjojkt0wSvqeh67N9xVKoU/rtHLF
	 /pIuHxESxL3GmX2Fhg5KnBg0ix78YpKUB9lfNQ5w=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 8D6862BE; Thu, 08 Aug 2024 21:35:22 +0800
X-QQ-mid: xmsmtpt1723124122tkj36qgw5
Message-ID: <tencent_8284976E368C4A38741176FB67D03C6B3609@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uT4YabpzbMOY9T9emyzEp7mnigYC2uIIUuuzwdvyWS09hekbIrFE
	 BpaEh+RENwOECsbZbsXoZ/hdVIvW2zkfZWJw18VdjtqZpJSlcvnxVlfnLtWnzY8ZYy2HVfPwbbpJ
	 cNmy9kBLMSzMdPU4wKLwO1Gl9MLiFmgB4UJ0gtXbJ67IRLc2iGg554jYMTO77F9kl9WP3AJhGM5k
	 XaxmYdca/J9Vn1hcSW6VXkwZsBXqha4A0/eHVSX6zODBVfHYurex8a6hu7N5SKv67RHzSOSnFO4B
	 t3I1/TyoWQkhi2Kz86xh14EM2DzTiZBKE3cyxv9Spc53w3x0Jw/r45zfu31pZx2NvYHLKaEVoyKU
	 5KtAzUD7XJZxII5wPgSUw3baSeahNeATVar704zibZuixwERNRmvUC80eu0CCv1IqlHjvcs0/Tuc
	 gsD02orExPeDs0rApIBmceJWD1J9lCULUDE7TFrbdnK/A/i42hLshUOCXRlWTdH0k4UhBPUDKSP3
	 iZFDjcAj8XBpCdzXc8yqUudAdVoZbldNpjtg0FIxwFJhgVTjpCVXeN6s1zAftvqrcjb3vssJ69bS
	 Eemp8yzjx+oCPLfxH5BURYOjUy/FwOOBOzEkqC1M55AdrSEUpwX9w58jtmpusyHW33vbDXgliIru
	 NUnWu4Euo+9zxiwRkgxLtorV8UHGhLKMqmoRmflK25KpYIq7pSLf3HYVzJsrtNFwbxxlLrsNDi9b
	 cYmoPRN4GWL7Sa1x0aLvU/QG9I/9t5Yjjj4cwxEsHfGcKE+0JcsVe66FDdywGhjcLBOqKt1BEFia
	 8Rg0MF4plBgUlLHAfvt4w+/BZjyIVkdRP4WGdhe5Yd9TOfQoh6fCVbVgV2vr5Jq03PP5WBPFLlr2
	 gEhqUNXI4PmYOH+hvCdzOu74H4RGbTSLZoNbstuDzkttiiXYo8zly77u+miZDx01ZC8PP8XPUC2g
	 AAVr5gK2fQcfK28UvMrkbfTl+aeCP7
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Thu,  8 Aug 2024 21:35:23 +0800
X-OQ-MSGID: <20240808133522.1423164-2-eadavis@qq.com>
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
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076..cf7200ed2553 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -218,6 +218,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRITE))
 			retval = filemap_fdatawrite(inode->i_mapping);
 
+		printk("del, ind: %p, ino: %lu, %s\n", inode, inode->i_ino,  __func__);
 		spin_lock(&inode->i_lock);
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 348cc90bf9c5..abadf3b5fecb 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -44,6 +44,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	struct p9_fid *fid;
 	int omode;
 
+	printk("1ind: %p, file: %p, %s\n", inode, file,  __func__);
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
+	printk("2ind: %p, ino: %lu, %s\n", inode, inode->i_ino,  __func__);
 	v9fs_open_fid_add(inode, &fid);
 	return 0;
+error:
+	printk("err: %d, ind: %p, %s\n", err, inode, __func__);
+	return err;
+
 }
 
 /**
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index c61b97bd13b9..085a788a3262 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -284,9 +284,11 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	}
 #endif
 	v9fs_fid_add_modes(ofid, v9ses->flags, v9ses->cache, flags);
+	printk("2ind: %p, ino: %lu, %s\n", inode, inode->i_ino,  __func__);
 	v9fs_open_fid_add(inode, &ofid);
 	file->f_mode |= FMODE_CREATED;
 out:
+	printk("err: %d, ind: %p, ino: %lu, %s\n", err, inode, inode->i_ino, __func__);
 	p9_fid_put(dfid);
 	p9_fid_put(ofid);
 	p9_fid_put(fid);


