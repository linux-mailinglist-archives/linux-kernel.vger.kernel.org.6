Return-Path: <linux-kernel+bounces-282222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C037F94E107
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330201F214AC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE90747F6C;
	Sun, 11 Aug 2024 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="p8LJDIRb"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D0A11CB8
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723377956; cv=none; b=D8dWJ6pOmmefeOcegMa0sXMnjh5pj10pX+9ozaK91+Ues7YJXVBBPbGF0z8XaqZTViRcgB+L3NCPEkixkY8tTt18j/IMWJIZwO91nvN6KgCZpf4Z9ylA5qq4y0DmpGahjc1TCeKmzvEgdA7ZSrD5r1A7Hc6890jtciRfDT9Mw4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723377956; c=relaxed/simple;
	bh=lmidz4kHGxoJFuZgwOJ61v0/McihbBcZ5iQosUICRMM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=FGMCeRIGfPzmKxbG10pmRmq1xtLKMp3DpixmHVV6BjE6emvheiZ6lVKlEFc6bQYMV0VAw/2K+z+oMylsKoK1f+qOwrl4+ZV7T+o5nwtj/uG6ZoEuCOQUiToiMwkr8jd/X1Bam1raK3XQfed8/1BHNVyzXBPROjfAR0gP95Lc/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=p8LJDIRb; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723377942; bh=WKA3I4BM/FneDtE0BqdduIfIibMtzz0wOHLtqf8MxHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=p8LJDIRbbGQjPUfCSpAz0diyKu58cZSo3lioUDaJxLICLHgyUepDGmm6VPQ/X6kD5
	 eUwJc5fX5U5KNk0yi2AjQ7m+ziynnyfhMRPGh5QUA7R6G5Wd4m58GMvCwCu+ZbtZgq
	 owuXKmYUehj37EDwdRkEnc3EoasWJuvJu7YXx/ao=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id E5F86030; Sun, 11 Aug 2024 19:57:31 +0800
X-QQ-mid: xmsmtpt1723377451tppkssyzn
Message-ID: <tencent_2006D092E8066B89AEEEC42ECC4CBA27D806@qq.com>
X-QQ-XMAILINFO: NSTsyPg8kQQYrubKTbTj741KTcVEBH/dXW6dO6JKCaow1RNCxRrXzy41Ia8EVk
	 Xm0t2FfhgPuCtKzuuMopNMoYj6npAQnnVomaYtURunCnO7U/wgmAu2sJv7bfIgBorbzo0x5X9ZOP
	 5g0srb1+KwG75Y5ZL5W9kQPNPmMpCIU1XsjxB1gvBYfQFa/xPxjSuR/EFqjvMJuhXaYfXjWDafbg
	 ZTDeTR2t/N+HwJ43BXj4rbQpIF1zEEuZaFelBP7tQjElbdnVTYw0L1z4Pki1rKGx4ozn5XGev7MC
	 IFKZQwv08Fv16PHYWgKJkaWytrU3SPoeI2T3OOVDUUSAHLURG5wBCh0Tfz3Cb+447ul52znPgJAO
	 tjC1JKXh6t1nK0LCxc3OfeyqWbuC9IvSj8quxfKnakZD26bcdRAVojjKjfrZh6G8t227dcuDFQQ0
	 UEUqAqAXembK0KCpj/8F/GsPrvol+2iG5Q9nmyeiaNCSfN21EtUSPOArrPKmuzQzcnRNMjTwIut5
	 zWf7WFMnCI30X7MSQpEI8s2w7nJWoECLb/ploIJBtJXgDMR3Vl60xBXFUSdM8cgZrz6M5+sXs6CD
	 ltyXrzA5qaP7Yw9N7Ix2wHy30Q/GAg629m5IxTZjW3OPxLnmv93dR3p0sf4H8IPLh+OFUqQQ8XRO
	 tHvhjUjb2mLnf7SkDAjpvBdhecuRjl01k/3xJsbULwNc25cDpQ1cVPA6gm+DCHDyfoKo3LfBvACr
	 Zp0arRfhJRc/qGhpmK0SYZShVKfe8Q+QWb+rMlOruibqOS2t5+DlPfRrGjI76Utr4UUlGxjL7ETZ
	 NJZRtFc19C547/cN7778GRDSAf6FGa3IooidDnYkO0w4KyaHKTqFa3vQUFjdE07mxRC9RzRoD445
	 Ybm9ZeeMYxPVMgBwA8RuDS+7C5SAG0SofhsT8ZHVick/FZ6veN8WQQ8IkKpw6z9gkcWieVDuGifm
	 eOuf1E3UA=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Sun, 11 Aug 2024 19:57:32 +0800
X-OQ-MSGID: <20240811115731.3316634-2-eadavis@qq.com>
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
 
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 9258d30cffe3..fd72d75e00cb 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -503,6 +503,15 @@ int netfs_writepages(struct address_space *mapping,
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
@@ -522,6 +531,8 @@ int netfs_writepages(struct address_space *mapping,
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


