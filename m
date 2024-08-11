Return-Path: <linux-kernel+bounces-282207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721A694E0D7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 935E2B218C8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12D4446AF;
	Sun, 11 Aug 2024 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QOzbDHvD"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF3F3FE4A
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723371872; cv=none; b=Z6iWbl/LHpLeIck6HDhVKB4rswrGHnlpsQsbgOuC7Duf3M2VY8I9kUx7MIqMFlMRuAwzImEqy+hAbb5miBtY/aYF6LyCaazbiqTxuGwY7CfONNOkOEd8kf2MMAlXmgIx0sG4RZf+u2AVC7zFUSxYMG9fPnsc9o7r47LSX+wkUOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723371872; c=relaxed/simple;
	bh=FlhAfnPvO872kRxPkXI/gE4EA8psGNOWTgRQp23tqwI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kabNjzKevbWyM0DdWr0nziDdtCUvmynEt5ASpAh1Yu112CDsMh5SOt6D26+J01fWA9xER0zSSLsha4xwOTp3IjD2Mv9lnWfSFQRhPUVlHZe9oM4Yo2c4NefchUSRhvB2S0tDBgtyqYdcq1zya+3W7tx6Z4pJmiD0gmb+9uK/fWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QOzbDHvD; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723371859; bh=Ouaa0Rgiq27w/FgtSyA83C4ZBgL3SfrBjI1bppSqErY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QOzbDHvDbYYH+wIHrrJCKn5ZMvG7uCz57IX22z3/9Xo1IURz/LSXxEasiMS+4+dvy
	 BViQy6zTWV6JGrjkpAJYRYdMYieEg1RRZk+hsHW4EVVZZHueqpEDjHizAqQf1+jiM1
	 zSpLh9MvW1h/4B01cf4wsnfWHXoJZUFxLHhyAstg=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 48829A62; Sun, 11 Aug 2024 18:18:08 +0800
X-QQ-mid: xmsmtpt1723371488t4c9kghuk
Message-ID: <tencent_8CEBCCA4E7D406EF12CD864A49942EFEEE06@qq.com>
X-QQ-XMAILINFO: MZChPk4K8ikNqB/iq2mz4HwOzNiUPP4q7LtaZiSFMuwfWWn5gLECsFrTuDA6xc
	 YCdesmmXScSkOr7+N8Jp1AIgmsUYBL2Kz3v2tZqxkA4rXfxEObYq9XrK9EgoRcj/kB4BHUtfDH/V
	 bY+LXY8pWcOvPMnH3QGEF9J/T8vSOfO0sbbz9mViEZ1lTSJYahpPiUWsy2K4pgq+M9c0cAJInUA0
	 jea+Ostvj1eQ4VGnInq+cowXmkYQBwL7GOyph634tDPcJwJxGInYD8k8IoNqioAVRAv6NzF2vYaH
	 31CVsjEj32JKSj7hQGxuj/n9AJi5lte2VN1zgC7WYMI9QDQZCUh98t6ZD39ImevdUmUXJDqgKe9y
	 HHpyiXpYcC8jf36Tj+gouK0nt3St/sh+2QHOqDWHJGpvit8P+ciZk5whqT5fVXqmlfky28qoaljf
	 bqaapfrb3QePk5C5YVuys8TEtxcsU6vOEg1Hs0N74GjmPMeLHIWP9quoQblzn++eRhsCl/32vRXk
	 kSHcrXelbsC0VQkwY22iueiews3E8H6iyBe7alq4cKiuIi8mQIA6Xdi9/SDuIZRsjlAfbGIc2QQA
	 lhn15Rru+6RjWO0yT7Tc0RTM+SXkl/6dCc7zcruOaIVN8WozU10QC48WrOiKkjEIte152CnJmimh
	 KBl9d0BvHP8ZRM9eidA3eX4pp4/uS2Pl3sw3WX3UUlWHe/5NwXr0SwdW6n2noXfg98ZxYNlmUpYd
	 urcx4CbM51vicJghiBViInym/KCLPxFXDoqLGknxVOjVikALNdBCZ1kV8X6sc/ouZ/gaNUIkRQ1M
	 /WtePXkXhHzJmPpIrC+VtahRvtw89anK7wtMYhMsKqDq+nYePRaF1T5hI1aukBlm41vtRgAJlh8p
	 sbXv5ojCNIm54WyejkIxTIBcd9i8iD/BP+jkf9is6d0eHIGat4iMjick5BwBzJ8Q==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Sun, 11 Aug 2024 18:18:09 +0800
X-OQ-MSGID: <20240811101808.3221970-2-eadavis@qq.com>
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
index fd72fc38c8f5..21fa2246ec09 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -355,6 +355,7 @@ void v9fs_evict_inode(struct inode *inode)
 		netfs_clear_inode_writeback(inode, &version);
 
 		clear_inode(inode);
+		printk("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
 		filemap_fdatawrite(&inode->i_data);
 
 #ifdef CONFIG_9P_FSCACHE
@@ -953,6 +954,7 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		return 0;
 	} else if (v9ses->cache & CACHE_WRITEBACK) {
 		if (S_ISREG(inode->i_mode)) {
+			printk("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
 			int retval = filemap_fdatawrite(inode->i_mapping);
 
 			if (retval)
@@ -1034,6 +1036,7 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
 
 	/* Write all dirty data */
 	if (d_is_reg(dentry)) {
+		printk("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
 		retval = filemap_fdatawrite(inode->i_mapping);
 		if (retval)
 			p9_debug(P9_DEBUG_ERROR,
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index c61b97bd13b9..961becc48888 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -390,6 +390,7 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
 		return 0;
 	} else if (v9ses->cache) {
 		if (S_ISREG(inode->i_mode)) {
+			printk("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
 			int retval = filemap_fdatawrite(inode->i_mapping);
 
 			if (retval)
@@ -518,6 +519,7 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 
 	/* Write all dirty data */
 	if (S_ISREG(inode->i_mode)) {
+		printk("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
 		retval = filemap_fdatawrite(inode->i_mapping);
 		if (retval < 0)
 			p9_debug(P9_DEBUG_ERROR,
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
index d62150418b91..beda9b7b6ccd 100644
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
@@ -445,6 +449,7 @@ EXPORT_SYMBOL(filemap_fdatawrite);
 int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 				loff_t end)
 {
+	printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
 }
 EXPORT_SYMBOL(filemap_fdatawrite_range);
@@ -460,6 +465,7 @@ EXPORT_SYMBOL(filemap_fdatawrite_range);
  */
 int filemap_flush(struct address_space *mapping)
 {
+	printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 	return __filemap_fdatawrite(mapping, WB_SYNC_NONE);
 }
 EXPORT_SYMBOL(filemap_flush);
@@ -682,6 +688,7 @@ int filemap_write_and_wait_range(struct address_space *mapping,
 		return 0;
 
 	if (mapping_needs_writeback(mapping)) {
+		printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 		err = __filemap_fdatawrite_range(mapping, lstart, lend,
 						 WB_SYNC_ALL);
 		/*
@@ -785,6 +792,7 @@ int file_write_and_wait_range(struct file *file, loff_t lstart, loff_t lend)
 		return 0;
 
 	if (mapping_needs_writeback(mapping)) {
+		printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 		err = __filemap_fdatawrite_range(mapping, lstart, lend,
 						 WB_SYNC_ALL);
 		/* See comment of filemap_write_and_wait() */
@@ -2708,6 +2716,7 @@ int kiocb_write_and_wait(struct kiocb *iocb, size_t count)
 		return 0;
 	}
 
+	printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 	return filemap_write_and_wait_range(mapping, pos, end);
 }
 EXPORT_SYMBOL_GPL(kiocb_write_and_wait);
@@ -2775,6 +2784,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		struct address_space *mapping = file->f_mapping;
 		struct inode *inode = mapping->host;
 
+		printk("ino: %lx, comm: %s, %s\n", mapping->host->i_ino, current->comm, __func__);
 		retval = kiocb_write_and_wait(iocb, count);
 		if (retval < 0)
 			return retval;
@@ -4227,6 +4237,7 @@ int filemap_invalidate_inode(struct inode *inode, bool flush,
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
 


