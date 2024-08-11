Return-Path: <linux-kernel+bounces-282158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F123B94E046
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 08:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49DA4B20FA0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 06:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6D41BC58;
	Sun, 11 Aug 2024 06:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zZ4kWNZe"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7EB199A2
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723357553; cv=none; b=LBT80sIzs5K7fP2nRiiUqsFC8ElHfJNKHlFxh2CfNc3joXJ6ZT8LYON+6xk8ytCMPVEddvWtFI3+K7+aEvcDrtLy8h0fSQZDrRX84ikZBVIEQTsjyFdZ01loNaJo5K6xNZpoed8vOZQA1DgSuGGMcCywIejCS2GklRixeD837Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723357553; c=relaxed/simple;
	bh=K+704m1s984oFPPbXPoYz4S3+dli3L0TlMwC3f+vFAI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RmxIXXayEFmlgBq8+DgXxgod+BZJ3DXLMzRZ37ZseKqQutLO0hDaxlewvW6fc9qGajSNrNLcXihbEs9AfW2x3R40YluwDA+4yR5WbRgHUT7KdbuhtLr7McATouOD1ciOh8tiUHv5tBvu+wm+/tZt7bq3eVEi/fsuZ03QN0jmrv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zZ4kWNZe; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723357242; bh=Ra2IsJYZNAS46gJ/dNa6MPCoW90vVTwLlMIWbdKmNkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zZ4kWNZedWlYApODxgxkk4U1bBRwVKjYkBb8O+XOBqjl0tlqSKkup2Um7GFPnzHjB
	 dmjpebxEHnfKRY007FRPH+H48lWG700q/FFmuqR1XxbpLGpN6uJ9DBjQKWjMi04MOH
	 r840QHJQRcJE85yYgzPjLVntsVQfLKOFGZgc0o/c=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 39EA3224; Sun, 11 Aug 2024 14:14:30 +0800
X-QQ-mid: xmsmtpt1723356870tq8jgqfdj
Message-ID: <tencent_3CCDF07B166EF42FD96D8C946CE932ED960A@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+z2/XQPWS9ixDOMCDaJSPICTqOPXOfFmdqoEreYXqa1ZBPZeAQqW
	 oojZmgHa7NiTX3xYxaqQfEwJ5q6VhwSJNq4pD3Uzr/IB/4qAOar5rvlQvak4Elk9xoQ/FMprZomy
	 7b3kOkCEJFUbSWliBAdJ3ls9AjkviPumjSyFkcmtQhjsvEnw+SWToMHEMUxC6q1nMZE2sxh6fdFr
	 o4YnEz7LVIIugPivW6/IyXuFwt85NoDQy9YH5HZo5joR3RIWiinOIFhyZJQo/U8J+j7xNGhWPuyn
	 jIB3bvDYrAJqtyH73hEYcL2cCOOOu71bUx89XhhqJek+mtH5KjlyUWNVcfEsOxNCHoGW91kazXuB
	 +oIqtAn4rzeEC20M27xYKOlgkG71dGpUhw/4rBr6Xxul8PNiSNCblPlRS0QhIllq9HTt8uCixioF
	 2NNsMq5b9EJPnGKty5XgYAMGCQZ5SlXELBHgZ++s4CN0LRL1k/kKS3S87ifXpD2BwSfvWn2anSwG
	 JHGCg+SiZKacVGZ2W5IZxzaaGXLk6MrrmZzqqIFCxq3sMjYq7lIMcbaXPcTQiDdvsSJCeAVQJvv5
	 4NiuCkp70m8dVP+k2FwTduxefdsc3TWW+V0tFdE+bpp+BWWYoxSNVW0KDbPiDyLAKI8MIC0Tfa47
	 kKWltLopmgV8G41VD0VJZVy1TPQoPxSXgwFcli8iGp2k4p+4uNbqLzq//ChkjeL25P0O7/tePmF4
	 p+8+JF+dnzAq+cdOJJfXdXtgA5THL4PBzhIlROVDzE9BtL9oRjlE7tZG8MkM3ymBMcoL0wSU42iP
	 rdBmgEOuWjxyvJJ/LpZ5wH2x0P2s8scYcu7x4TAye9R6njrLgIfQPl2/nCqUsAAfh0TE9yKjLCNp
	 Re64UXVbqM1cteBgDM2QugdXOu/2r4xx50lMVB1jmS2O5m6v3wG2/A7u9OuRjM6RZipq4L2mdc
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Sun, 11 Aug 2024 14:14:31 +0800
X-OQ-MSGID: <20240811061430.2984968-2-eadavis@qq.com>
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
index d62150418b91..f854a3fe0335 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -394,6 +394,7 @@ int filemap_fdatawrite_wbc(struct address_space *mapping,
 		return 0;
 
 	wbc_attach_fdatawrite_inode(wbc, mapping->host);
+	printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 	ret = do_writepages(mapping, wbc);
 	wbc_detach_inode(wbc);
 	return ret;
@@ -427,6 +428,7 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 		.range_end = end,
 	};
 
+	printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 	return filemap_fdatawrite_wbc(mapping, &wbc);
 }
 
@@ -4227,6 +4229,7 @@ int filemap_invalidate_inode(struct inode *inode, bool flush,
 			.range_end	= end,
 		};
 
+		printk("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
 		filemap_fdatawrite_wbc(mapping, &wbc);
 	}
 
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
 
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 4726c315453c..b7877f5c6bb0 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -510,6 +510,7 @@ ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	netfs_end_io_write(inode);
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
+	printk("ino: %lx, in state: %lu, comm: %s, %s\n", inode->i_ino, inode->i_state, current->comm, __func__);
 	return ret;
 }
 EXPORT_SYMBOL(netfs_file_write_iter);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 9258d30cffe3..2720943c47ba 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -522,6 +522,8 @@ int netfs_writepages(struct address_space *mapping,
 	trace_netfs_write(wreq, netfs_write_trace_writeback);
 	netfs_stat(&netfs_n_wh_writepages);
 
+	printk("ino state: %lu, ino: %lx, comm: %s, folio: %p, %s\n", wreq->inode->i_state,
+			wreq->inode->i_ino, current->comm, folio, __func__);
 	do {
 		_debug("wbiter %lx %llx", folio->index, wreq->start + wreq->submitted);
 
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
index e0d34e4e9076..73cff02644b2 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -219,6 +219,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 			retval = filemap_fdatawrite(inode->i_mapping);
 
 		spin_lock(&inode->i_lock);
+		printk("del, ino: %lx, ino sync: %d, comm: %s, %s\n", inode->i_ino, inode->i_state & I_SYNC, current->comm, __func__);
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
 		put_err = p9_fid_put(fid);
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 348cc90bf9c5..0ebcd847f2b0 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -44,6 +44,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	struct p9_fid *fid;
 	int omode;
 
+	pr_info("ino: %lx, %s\n", inode->i_ino, __func__);
 	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
 	v9ses = v9fs_inode2v9ses(inode);
 	if (v9fs_proto_dotl(v9ses))
@@ -397,12 +398,14 @@ v9fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct p9_fid *fid = file->private_data;
+	struct inode *inode = file_inode(file);
 
 	p9_debug(P9_DEBUG_VFS, "fid %d\n", fid->fid);
 
 	if (fid->mode & (P9L_DIRECT | P9L_NOWRITECACHE))
 		return netfs_unbuffered_write_iter(iocb, from);
 
+	pr_info("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
 	p9_debug(P9_DEBUG_CACHE, "(cached)\n");
 	return netfs_file_write_iter(iocb, from);
 }
@@ -461,6 +464,7 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 
 	p9_debug(P9_DEBUG_MMAP, "filp :%p\n", filp);
+	pr_info("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
 
 	if (!(v9ses->cache & CACHE_WRITEBACK)) {
 		p9_debug(P9_DEBUG_CACHE, "(read-only mmap mode)");


