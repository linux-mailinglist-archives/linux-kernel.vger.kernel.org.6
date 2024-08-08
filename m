Return-Path: <linux-kernel+bounces-279706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAB494C0B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD1D1F224A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0423918F2DB;
	Thu,  8 Aug 2024 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EdC08DlP"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3CA18C355
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130092; cv=none; b=mdFqiSppsSp/Wf2iz8GfWjNbLXNqi1YXCYSR0R3BOgqCQ4lCM3POqu4mar8kLYv+DcVvhMf+Unc7r6mWMQTQjH25GJVFimiRJt6DpPzQsoj57+OOO+Qxa7oDgGDEzWQwz58Gz76s/ptDfKTBxb9pG7RLtfwXURqaLQh1nyJHqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130092; c=relaxed/simple;
	bh=KdQLsjzG1wkzomU//cbukGuZkB4zo7Q1VYeC2qHE2hs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YdpDUexHLC4CnfbmvOnE/W9bXVNm6My1o/5gTfVt2x9TkknSoX3q7d4NsLa4YfCTeBy5ixooqs9iuLNCo4VmvYM4k9y88l8kfIkvWtAG6trGlggTdsnWowgdI5WAxwZ+QOlltryrX9eNFxwmDfJvBwu2XdKc0Ga/UCs4Dno80jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EdC08DlP; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723130084; bh=CpuzaSrDDLBS33V82twzhqpDZtSatD3oTui1fl6tZgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EdC08DlPb49zR6zvW5nAbMNwgr94Z4KO4jSP0uS8oEY10dIzXWD24Fs12TyHfV9Hc
	 1mwQzYFgZk1dtQ/wmHPdWsoU03dj5Tj14kVkCi2vU1ReA3PY0lkjezbAmbIzl1q1Au
	 29EeirxOCyb7/uXK9bI4tFV943l2xllyfqSPcUeE=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 9833843; Thu, 08 Aug 2024 23:02:24 +0800
X-QQ-mid: xmsmtpt1723129344twgmkz6q9
Message-ID: <tencent_1609A06ED7AEFD4C9827C7C6D352D4866106@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH3Hd9Afrt5jqDCczphILyRQAAge74n6JeL+P7SDL2hnp6KRW0aBm
	 5t3w7YVinXTYaqbvkKvt1+3ctg3Hk9KSKKVef5iJ++vATrVVyvs2Xiw2ystNk6g/aC9cjVKvPAIg
	 riaPRe/ShNvddxZoyGs3L5m2gYq1HAjXgCU7stqs0P3/Ny1Ft7RBiqBUUcvt9R1wFEy8zAgRoEV2
	 +FEta3y+sNm8dawh79demu7gYp+LaNF/CzLAZ3DMIdec47/WgH5vT1wCpYQnpXz1IFCr2rdGl3cT
	 D9GQAd5J4EkkXqjN45Tny8Lo88UXT57FG0q8+ahSArJLr0YE2FbdZAIoCrMVcJwmo/W54VZwCtKx
	 2S/JNX3ebNujivGWWWsdCgRX4pqN8SkKy7+qoFGKkg4h4lpuaTivECKHpENF2PmUtnA9VXljKv0h
	 lZ4YKYxy69ZsKLosy9cbuKyWbLwe6vIYfhR52Y1QQeodt7ZMg/br0gDXdd5ht8Q0d5ZrX/Gb7Ykg
	 p+wG1o947yThe1F5J3vuYFT+UM/iJDoOx6T/gkYFqZ73GGeTZTD04SWWs7navKGtW5aGPQ19clbH
	 XT1DMdgE0CgBS2pzGmNJSob+d8UXXTULxLQhTMnfjRtazAHA0+3hx0przRBxlRXM0rjKNCiROJXz
	 /QAQX+/pVhI8iVbJurdTJK6DUa7nOYTA/opnROL4bTWfmZPKA+YqrRXznhHvknLDsxYPPkSWuaZl
	 1Ha7sxdLU05rxpWhxFYwa7IypfAEdDxbf2zWOFKHv+a9uFMWoxCu8Xc6u8Ar9YPhodmIe9dw7RNh
	 /X2dy8TzQuqJL1TiG8+BC8hWE9C7jjmeFpyNTcI/PoJmAlJXiNf5JeW/jWSuwMUTMYOGDw9q/TGs
	 OC9mhtn/PmJrND2pVvZ1RVXSwbM4QXlsYqaVz3ufTvNKbemVy+9H8bsQYxpOE+TYQFlNHVc0b9
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Thu,  8 Aug 2024 23:02:24 +0800
X-OQ-MSGID: <20240808150223.1502852-2-eadavis@qq.com>
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

diff --git a/fs/file_table.c b/fs/file_table.c
index ca7843dde56d..3d7a59961ff6 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -418,6 +418,7 @@ static void __fput(struct file *file)
 		if (file->f_op->fasync)
 			file->f_op->fasync(-1, file, 0);
 	}
+	printk("ino: %lx, %s\n", inode->i_ino, __func__);
 	if (file->f_op->release)
 		file->f_op->release(inode, file);
 	if (unlikely(S_ISCHR(inode->i_mode) && inode->i_cdev != NULL &&
diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index de009a33e0e2..7a08750da902 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -67,6 +67,7 @@ struct p9_fid *v9fs_fid_find_inode(struct inode *inode, bool want_writeable,
 
 	spin_lock(&inode->i_lock);
 	h = (struct hlist_head *)&inode->i_private;
+	printk("ino: %p, inode fid list is empty: %d, %s\n", inode, hlist_empty(h), __func__);
 	hlist_for_each_entry(fid, h, ilist) {
 		if (any || uid_eq(fid->uid, uid)) {
 			if (want_writeable && !v9fs_is_writeable(fid->mode)) {
@@ -132,8 +133,10 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 		}
 		spin_unlock(&dentry->d_lock);
 	} else {
-		if (dentry->d_inode)
+		if (dentry->d_inode) {
+			printk("ino: %lx, %s\n", dentry->d_inode->i_ino, __func__);
 			ret = v9fs_fid_find_inode(dentry->d_inode, false, uid, any);
+		}
 	}
 
 	return ret;
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index a97ceb105cd8..a022263265fd 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -34,6 +34,7 @@ static void v9fs_begin_writeback(struct netfs_io_request *wreq)
 {
 	struct p9_fid *fid;
 
+	printk("ino: %lx, %s\n", wreq->inode->i_ino, __func__);
 	fid = v9fs_fid_find_inode(wreq->inode, true, INVALID_UID, true);
 	if (!fid) {
 		WARN_ONCE(1, "folio expected an open fid inode->i_ino=%lx\n",
@@ -105,6 +106,7 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 			goto no_fid;
 		p9_fid_get(fid);
 	} else {
+		printk("ino: %lx, %s\n", rreq->inode->i_ino, __func__);
 		fid = v9fs_fid_find_inode(rreq->inode, writing, INVALID_UID, true);
 		if (!fid)
 			goto no_fid;
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


