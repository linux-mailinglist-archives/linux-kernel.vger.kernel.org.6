Return-Path: <linux-kernel+bounces-282133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5701B94E003
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 06:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A940D281C20
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23749171BB;
	Sun, 11 Aug 2024 04:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wTaXN3/9"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43A2572
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 04:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723352170; cv=none; b=cNapAdRgX6UuJjvZDH8qLzntawUBjMtOuDcyenp6oBicdnhER/gxppYigQTx/rgJ7d4CNRVM/wvUqPWNS/05jgm+9j9nEQ62/70v5Oe6sEytdp8LhncEb13tKLocXLEsAqD8P1mjtZKcVUlEWZX4kCuI5RetOyHnE0a0btwgtd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723352170; c=relaxed/simple;
	bh=Vz8Kwq5reUBIKlhhCOOHjMye+z5JuFEP3wCQxzqOon8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=KrFV0GkzYYw/J7UK7OaIwjLPGUHvBKfwP5qN+nTwL7hChPLCa5Np30at+r0PlJmHfVpN9tA7/GpC7NqaM0F+g2lSK7iOoBOOOdec2XyBtO/MwvzxnHZs4NOsQOwz8+FLLTiE2r5pBUTirkqRG3H7dWGhE6uWREk3AG1+ZbQMRT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wTaXN3/9; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723352156; bh=1d/Pa7L9RMz4/IPF83ub21ldEnUxmIYS5oTi791UEzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wTaXN3/9l6YidR7uMa5KRrV3hxpHN8Y/ElEsoK3VVU2lp3Eq1PA+/jpNzgHOM398X
	 cGY9PJgO/HucEHt7uXNn+zOIWP7eQeAXFJ6zurT3H+ghs1kg04KQap/7kJzsMzdHbf
	 sERCV/TsPGhjJmNNmvwaUVY1EYyL/9jTdE0QEbDs=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id C743C6F7; Sun, 11 Aug 2024 12:49:52 +0800
X-QQ-mid: xmsmtpt1723351792t5kvx24ho
Message-ID: <tencent_E50D86925ADD975D9F19124F878D82259407@qq.com>
X-QQ-XMAILINFO: M0PjjqbLT90wjYbeoWL1romV8hHwRA/xuwZme9sYYSPs7j9T5bYCNYYe6BFxdE
	 fSztQVxJg3fydp2RyoRnOCSVZJwuV4UbmHEwgqjKvv74r9Mfy6PAWyh2o1w90ieSAd7MBC4t7OV3
	 Q7o+tj+GiR310FGjV2Ydj9bn/+O9htbmlflLW8FH+SkSTmU+dMCnvNGLOhXp3xZfGd27dAu7cSmd
	 JHv1LbXcmIj5WyyeqaxzJI2a0ml1p69QT8We9dwQIf3cal0rHVBpnSwRbFWvOfrHYx2yXmVgSOc6
	 gJ9pKqevEH4MBoNG1RD1ORAxOwdfD5W0KQ3EXk4rOv9iuzaZ14cm7GfCfSRc2S5KUXuZ/Fh4zbY/
	 xlzi19xQFv3PDGY26ZRyzP3N+w9pIzuuDfiqniF84TipChROQyreZ60/ZC0oSzrvCB3uO3952afM
	 2xdVQbZiNx9loslS0mNORvWuVaIpUEZ9hEVkr8/MoKT506I5VFdtrBNuQ5yBm9YAYgFVJGfnYCRY
	 hfxE9lEmW393Lth++Ahbvxb10qwbAoKbtERLq7Cna7tlQAOi7doeeDF/XWwGs2+HVaWfIyhfAa6x
	 TeXRLFAX8bMkvrXMdHDgpQ5sBDIUP/8Xs19tCsSxz480ySQJdlphhQqpBQNvXIkllnoqmEtjdIKP
	 l6p6rraAuxZuCO2Yv4vRjT8ERGUvLPRjhmPWxYS/9UozkYcjUyH6yLf6YeTR/1PoxC4aYv7FVvlC
	 VVUXxoSY11DXER2Mx/2ixNCmaYKNQLKf9qKV2Gsvmun/QBFl/M4FpgdG/d7vkZoJ3Muzk8Vcp/xa
	 1GP0aInXufo6e3Nyw6e1Vu8gpTaSz2gaMoCiimq/YZJ7snxINPslOUlScMVafZOSGhzZvvLWmO8J
	 b0s27n/7kz/KBKMRS50aChaxSGiWnAEBG352HAYturG+vbKxdpivqdFY182npj6A==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Sun, 11 Aug 2024 12:49:52 +0800
X-OQ-MSGID: <20240811044952.2909018-2-eadavis@qq.com>
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
+	printk("ino: %lx, in state: %lu, comm: %s, %s\n", inode->i_ino, inode->state, current->comm, __func__);
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


