Return-Path: <linux-kernel+bounces-282242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D160C94E143
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEEB28111F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C207E535A3;
	Sun, 11 Aug 2024 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="n2eJqBjx"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC32595
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723380286; cv=none; b=sE0AcdhO5j3yaLyrchugBXw6JKGtspRdmoXkaY4ET5CQ4fuzgTGsYHuBjLQrPxvpyaoChI2K5rFggIkb4XJEYYWM7JIhND6ClTxzMIDL0wZkDtyFdiq1HXDbtPfVjk9GP306Qb7zNm0YBD1K5NQHC1TKeAldJz7nmmBw2yDlJxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723380286; c=relaxed/simple;
	bh=sesvEee18dwRt3cIJ+hLneGB5UAlHER6cAkjwgrUOJw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=U6OpzfbqZHSFjzp9wsIWCiTq7EygrwCMidvNpM5Y2p+tYKnckj2TuLqjjgS0p65Ov8O36tQmGcYbFMovXvty1DJNCwuF+apFfZnKCS9TtUYICGLSWR+k6hrT2YNA0lJWPiyuCIhtQv42DPiounBmwSDbXdpQ/QJu+hb3bju8SeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=n2eJqBjx; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723380279; bh=GVesS+DUxXAO4L86pxod1vaWfcsklw2LEZA1rB8UzJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n2eJqBjxFVCnYDYo64a3vR0eUC/hPqCkGJVxGK+JQMs30e/TfFuoR2DiI3WEWjXax
	 3wp+BG+djdRVuB0zxGSDeQsRTnAMlZzjqYENhM/0scZ/4AgRUVYz+LCKe0Kkx1Db7r
	 KpYmwLtk7VRAx70x2Hjk9Qdo/aJV+yDOwk/9a5o8=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 9A42347B; Sun, 11 Aug 2024 20:38:36 +0800
X-QQ-mid: xmsmtpt1723379916tew6ok5ds
Message-ID: <tencent_0E503C2F3660964436144B5A74DD779D6709@qq.com>
X-QQ-XMAILINFO: MesT5uKpDagVlCR/nLjyJ1uir7RnivMOx+W0q1rTeXU/A7XJ3+wDrGVxHah4yT
	 2AwVcwT6cxZKjqvYMtYflTEOqBzrTZ4tOu8EXZlWajwJ96MpvaXW6Wnw4GwHgy8j+pcY2UsnxMzP
	 45R/CCII3OrueZ59B9zLMZT8yjeaZy6Odf7VifXMRvEOvqJ+2Ef8Goi3gALH9xltHPPZ98UN27iK
	 nmmcOR3g7iotIiJtjkuqxUHMkgQiuf0hDB6FJ4FjOA9jwFjj6q+XnYaWCS2z8pLcRrw4IVpI8FDM
	 Wu/0O0gAFvRsSPIMZiXKnT071OeXNg20Dm2Fdlgv+iL+lw4Ny/dHaL0iz18I9Yz3f1aB/CI/tP2c
	 8QW3EZCLeJTXEzMijX1hkHjwDK4xgEgZpXGEuEG8zijya1636a1LCaTWGjW59R8rKpAwv78jRoTw
	 Ch0Ch3ISOUSC973GwIUaJA3065SRDus50k/vwLlnHuhdXdZhsuhsnzmlPPO/x1oovcTfsvv7Mb/l
	 s+oemG+wHLYLoovLXOVyZ0LMWfScrwyfBL7bpYap02TekLIeasodJjHShmXCCrsz9sFe8jlc0A3l
	 Jmd3hGJV0/xylzePktqFwBorWNUr/TYVBXKtpBlpCStqQg1u4sDskub6skEC+hsIXSA3X2dLJHyU
	 giYQWoWeagWxhPzM4x2ADX1qULnm2I3wIKibl9kLkFx5iEyvw28fHE7e66sUrrjwWkjTJ7e9w2u9
	 wrKXv6LwsxXrjh/AnlsEk7D+9gBx4K0Ysnr+70B8WHJAZyZwxDAka9O+CwcXcvVVnaps9+Up828n
	 ywpvP3wogx7fdbE88sGWYUhan34on5+/Eyh2z6Wk1VGXISdQGWdXEoBk2Zsi1b8cxfeCT8ETYOcZ
	 oNciUo0puOc5odLgUeowENkf/BO8skwplj3RyDmAsHAyLrXlWkrNy0+lLTF3suBQhHGb6rvijBFy
	 OTcwxxwMQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Sun, 11 Aug 2024 20:38:37 +0800
X-OQ-MSGID: <20240811123836.3359462-2-eadavis@qq.com>
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

diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..5112cf69bce2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -394,6 +394,7 @@ int filemap_fdatawrite_wbc(struct address_space *mapping,
 		return 0;
 
 	wbc_attach_fdatawrite_inode(wbc, mapping->host);
+	printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 	ret = do_writepages(mapping, wbc);
 	wbc_detach_inode(wbc);
 	return ret;
@@ -427,17 +428,20 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 		.range_end = end,
 	};
 
+	printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 	return filemap_fdatawrite_wbc(mapping, &wbc);
 }
 
 static inline int __filemap_fdatawrite(struct address_space *mapping,
 	int sync_mode)
 {
+	printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 	return __filemap_fdatawrite_range(mapping, 0, LLONG_MAX, sync_mode);
 }
 
 int filemap_fdatawrite(struct address_space *mapping)
 {
+	printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 	return __filemap_fdatawrite(mapping, WB_SYNC_ALL);
 }
 EXPORT_SYMBOL(filemap_fdatawrite);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 4430ac68e4c4..f76ce90a5396 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2687,6 +2687,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 			/* deal with chardevs and other special files */
 			ret = 0;
 		}
+		printk("ret: %d, ino: %lx, comm: %s, %s\n", ret, mapping->host->i_ino, current->comm, __func__);
 		if (ret != -ENOMEM || wbc->sync_mode != WB_SYNC_ALL)
 			break;
 
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index a97ceb105cd8..7768cc70439d 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -34,6 +34,7 @@ static void v9fs_begin_writeback(struct netfs_io_request *wreq)
 {
 	struct p9_fid *fid;
 
+	printk("ino: %lx, %s\n", wreq->inode->i_ino, __func__);
 	fid = v9fs_fid_find_inode(wreq->inode, true, INVALID_UID, true);
 	if (!fid) {
 		WARN_ONCE(1, "folio expected an open fid inode->i_ino=%lx\n",
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076..2705474f5fcb 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -215,10 +215,13 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		 inode, filp, fid ? fid->fid : -1);
 
 	if (fid) {
-		if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRITE))
+		if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRITE)) {
+			printk("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
 			retval = filemap_fdatawrite(inode->i_mapping);
+		}
 
 		spin_lock(&inode->i_lock);
+		printk("del, ino: %lx, ino sync: %d, comm: %s, %s\n", inode->i_ino, inode->i_state & I_SYNC, current->comm, __func__);
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
 		put_err = p9_fid_put(fid);
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 348cc90bf9c5..a3c32b7de2f5 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -44,6 +44,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	struct p9_fid *fid;
 	int omode;
 
+	pr_info("ino: %lx, %s\n", inode->i_ino, __func__);
 	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
 	v9ses = v9fs_inode2v9ses(inode);
 	if (v9fs_proto_dotl(v9ses))
@@ -461,6 +462,7 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 
 	p9_debug(P9_DEBUG_MMAP, "filp :%p\n", filp);
+	pr_info("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
 
 	if (!(v9ses->cache & CACHE_WRITEBACK)) {
 		p9_debug(P9_DEBUG_CACHE, "(read-only mmap mode)");
@@ -477,6 +479,7 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 static vm_fault_t
 v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 {
+	printk("comm: %s, %s\n", current->comm, __func__);
 	return netfs_page_mkwrite(vmf, NULL);
 }
 
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index fd72fc38c8f5..99f42ce8de15 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -355,6 +355,7 @@ void v9fs_evict_inode(struct inode *inode)
 		netfs_clear_inode_writeback(inode, &version);
 
 		clear_inode(inode);
+		printk("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
 		filemap_fdatawrite(&inode->i_data);
 
 #ifdef CONFIG_9P_FSCACHE
@@ -1034,6 +1035,7 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
 
 	/* Write all dirty data */
 	if (d_is_reg(dentry)) {
+		printk("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
 		retval = filemap_fdatawrite(inode->i_mapping);
 		if (retval)
 			p9_debug(P9_DEBUG_ERROR,
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index c61b97bd13b9..68b3ced3f3b1 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -518,6 +518,7 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 
 	/* Write all dirty data */
 	if (S_ISREG(inode->i_mode)) {
+		printk("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
 		retval = filemap_fdatawrite(inode->i_mapping);
 		if (retval < 0)
 			p9_debug(P9_DEBUG_ERROR,
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 9258d30cffe3..87d14dfa9017 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -35,6 +35,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include "internal.h"
+#include <linux/backing-dev.h>
 
 /*
  * Kill all dirty folios in the event of an unrecoverable error, starting with
@@ -503,6 +504,15 @@ int netfs_writepages(struct address_space *mapping,
 	struct folio *folio;
 	int error = 0;
 
+	if (!mapping_can_writeback(mapping) ||
+	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
+		printk("ino %lx can not wb: %d or mapping tagged :%d, %s\n",
+			mapping->host->i_ino, mapping_can_writeback(mapping),
+			mapping_tagged(mapping, PAGECACHE_TAG_DIRTY),
+			__func__);
+		return 0;
+	}
+
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		mutex_lock(&ictx->wb_lock);
 	else if (!mutex_trylock(&ictx->wb_lock))
@@ -522,6 +532,8 @@ int netfs_writepages(struct address_space *mapping,
 	trace_netfs_write(wreq, netfs_write_trace_writeback);
 	netfs_stat(&netfs_n_wh_writepages);
 
+	printk("ino state: %lu, ino: %lx, comm: %s, folio: %p, %s\n", wreq->inode->i_state,
+			wreq->inode->i_ino, current->comm, folio, __func__);
 	do {
 		_debug("wbiter %lx %llx", folio->index, wreq->start + wreq->submitted);
 


