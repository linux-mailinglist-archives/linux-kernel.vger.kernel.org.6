Return-Path: <linux-kernel+bounces-282183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6413894E094
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D03281749
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 08:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9332E83F;
	Sun, 11 Aug 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="aTACvCwZ"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F5208D1
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723366270; cv=none; b=rFXqiU5oGWHnn9lu9oa2U6iVmW5nfbjEMnx+jWpTAUQhmCUfchCGhWIQqEKtS0mS7q9ssqWjqsjoPtIMkAE/p1gbb2P7jC7g9pqEaG1ikefv2z0+5w/nXhzKwMhMUurtETcCcAJQgsfWMgVGSQogE/0bXCcGg8d8f6wcdIRgmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723366270; c=relaxed/simple;
	bh=nQtxJ8tXqX9eIfxO0oeLwNTn99IcboT/y25QiuUccWE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uyn4vYijZRgu3bzdyv/fvh4cxZGw9O603TgcwFLHDKZVOCn2QvIVH/dMkmb+URy3dMN/Vo0t4eIncS9hkYm8n6H0GV71DfJDsPG6VrJ8mKxjigXIiCZH3767AdPd+Z81cRxVCEY9DC3QNV1x3C7rsVRbtHC8CKmRMAJiERpbNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=aTACvCwZ; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723366262; bh=5XwnirZqnAHB+sv3byZNcIsXIIDMKnqE6jhhz5ZVJbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aTACvCwZo3u2PvojXnUnjxXrOa+7W3Jll8YUDlCDA2pNKvVU4LCZUth0mfrTwMT1Y
	 G6MXviff4hZMUbVocH/fy+fQoTvxzsdAioYyw0k1FgTh4cKayViXwZgxsRDP0fLlsX
	 pIE7mpqVPIb6HZEFbHesEdqIE5Cmu+RnwULe/Cns=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id AA6B7425; Sun, 11 Aug 2024 16:42:38 +0800
X-QQ-mid: xmsmtpt1723365758tbrjzburu
Message-ID: <tencent_ED33039E0E1BA24BEE1B67250DBA58BBC408@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0aOUSGa4SqXoiJlPMqzQ6cBqMPVrQjiu/pVEC7F6Jc222hNZHXuf
	 TIvTVDfwunyRAJtFdSUpSpKTDYNbGaV46ZCkKjZ2kxMLSdSzDpNab3BeycHtzh1O1cFLXMPGk1pL
	 uph7r0dniEisFXcScqpPI/vn+5FCPcR1BnZSlBUUnbi6tDVLqxyQ3av0eMjuOKjc1CV7hnySJuDA
	 0jbMT/7LaBRgC+Zxs+6p5bGsWPXpghRHixC6NNo14EAN3un1bIjr3oAg6/4hbcW+6zsCmjnNnfTM
	 fXaabhhGAuyvRa6PnzeTrfSH7Zx+sWryg8YG2T7xARIMT9/34biAZNXR/YDF86qesrzIw1ttqvrG
	 zEjP5R7QWKYLPbVBowO7R8aMikIYMl/+807/Pa4kTs9lf5tUer1jOayppoVTfV4NxV73UoRvn5fL
	 cumAlRRClsPA6zRudUZAUVb7XPQalyVvR9sk/aRmOYhh7W+EpPAXyt0Vwqm5jw3BZItYCoUnjnDd
	 Q3u8viTg+3Dtd7e8sN7vIpEj21gjRILVMb6QN981XrLSpDjrmP5zg0FKi7TI8jOtRS9OQU9IwDWW
	 AausapoTXxbHZPVpfWvWG2O2qju+/SEBieQBe+IPEqDkoXGskkaIAK5BKRJI3JGZmKm+rZaTWviv
	 SUMOhYmf9JenhxjxyPtD9DjATigpKFYnsl5Ma5yVVCINfUiDUibRY+jIetzDjmmGDR7BqVMZvQmd
	 B499O3QSPqEKgJH9MN5OBddrwQLt4Gw1bKOZ00XsHy3a64mZ81szo91tgHLKRAkgvfHpGz3qjU53
	 y/vjZnCC/DicRNUF+Wl28sfN8wdsUMaBkN37DOgSxEi4+sQvHv/ZWTVRUvi6Dm53/uOj+DAxzTgc
	 0lJLnsfiTeALWRcuFr2JgKZie1UQdcS2LrkfdVPPRTN5DJOa1YlpLvd+BwN1Q+vqHcXyThnsFE
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Sun, 11 Aug 2024 16:42:39 +0800
X-OQ-MSGID: <20240811084238.3131800-2-eadavis@qq.com>
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

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index a688d4c75d99..fab0714e1324 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -602,6 +602,7 @@ ssize_t netfs_buffered_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			 test_bit(NETFS_ICTX_UNBUFFERED, &ictx->flags)))
 		return -EINVAL;
 
+	pr_info("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
 	ret = netfs_start_io_read(inode);
 	if (ret == 0) {
 		ret = filemap_read(iocb, iter, 0);
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 4726c315453c..63d85b6421e9 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -192,6 +192,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	    ) {
 		wbc_attach_fdatawrite_inode(&wbc, mapping->host);
 
+		printk("ino: %lx, in state: %lu, comm: %s, %s\n", inode->i_ino, inode->i_state, current->comm, __func__);
 		ret = filemap_write_and_wait_range(mapping, pos, pos + iter->count);
 		if (ret < 0) {
 			wbc_detach_inode(&wbc);
@@ -510,6 +511,7 @@ ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	netfs_end_io_write(inode);
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
+	printk("ino: %lx, in state: %lu, comm: %s, %s\n", inode->i_ino, inode->i_state, current->comm, __func__);
 	return ret;
 }
 EXPORT_SYMBOL(netfs_file_write_iter);
@@ -555,6 +557,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 	group = netfs_folio_group(folio);
 	if (group != netfs_group && group != NETFS_FOLIO_COPY_TO_CACHE) {
 		folio_unlock(folio);
+		printk("ino: %lx, in state: %lu, comm: %s, %s\n", inode->i_ino, inode->i_state, current->comm, __func__);
 		err = filemap_fdatawrite_range(mapping,
 					       folio_pos(folio),
 					       folio_pos(folio) + folio_size(folio));
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 88f2adfab75e..c19963e9627b 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -170,6 +170,7 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			if (filemap_invalidate_inode(inode, true, pos, end))
 				goto out;
 	} else {
+		printk("ino: %lx, in state: %lu, comm: %s, %s\n", inode->i_ino, inode->i_state, current->comm, __func__);
 		ret = filemap_write_and_wait_range(mapping, pos, end);
 		if (ret < 0)
 			goto out;
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 9258d30cffe3..106eb5b287e9 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -522,6 +522,8 @@ int netfs_writepages(struct address_space *mapping,
 	trace_netfs_write(wreq, netfs_write_trace_writeback);
 	netfs_stat(&netfs_n_wh_writepages);
 
+	printk("ino state: %lu, ino: %lx, comm: %s, folio: %p, %s\n", wreq->inode->i_state,
+			wreq->inode->i_ino, current->comm, folio, __func__);
 	do {
 		_debug("wbiter %lx %llx", folio->index, wreq->start + wreq->submitted);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..37229eeaf628 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -394,6 +394,7 @@ int filemap_fdatawrite_wbc(struct address_space *mapping,
 		return 0;
 
 	wbc_attach_fdatawrite_inode(wbc, mapping->host);
+	printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 	ret = do_writepages(mapping, wbc);
 	wbc_detach_inode(wbc);
 	return ret;
@@ -427,12 +428,14 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
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
 
@@ -445,6 +448,7 @@ EXPORT_SYMBOL(filemap_fdatawrite);
 int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 				loff_t end)
 {
+	printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
 }
 EXPORT_SYMBOL(filemap_fdatawrite_range);
@@ -682,6 +686,7 @@ int filemap_write_and_wait_range(struct address_space *mapping,
 		return 0;
 
 	if (mapping_needs_writeback(mapping)) {
+		printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 		err = __filemap_fdatawrite_range(mapping, lstart, lend,
 						 WB_SYNC_ALL);
 		/*
@@ -785,6 +790,7 @@ int file_write_and_wait_range(struct file *file, loff_t lstart, loff_t lend)
 		return 0;
 
 	if (mapping_needs_writeback(mapping)) {
+		printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 		err = __filemap_fdatawrite_range(mapping, lstart, lend,
 						 WB_SYNC_ALL);
 		/* See comment of filemap_write_and_wait() */
@@ -2708,6 +2714,7 @@ int kiocb_write_and_wait(struct kiocb *iocb, size_t count)
 		return 0;
 	}
 
+	printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 	return filemap_write_and_wait_range(mapping, pos, end);
 }
 EXPORT_SYMBOL_GPL(kiocb_write_and_wait);
@@ -2775,6 +2782,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		struct address_space *mapping = file->f_mapping;
 		struct inode *inode = mapping->host;
 
+		printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 		retval = kiocb_write_and_wait(iocb, count);
 		if (retval < 0)
 			return retval;
@@ -4227,6 +4235,7 @@ int filemap_invalidate_inode(struct inode *inode, bool flush,
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
 


