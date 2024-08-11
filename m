Return-Path: <linux-kernel+bounces-282279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2726894E18F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 16:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEAEC1C2101B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35F41494B3;
	Sun, 11 Aug 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="dURXMFVR"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C41E885
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723385116; cv=none; b=QCHMSZOfwnmFTRBzbD19jbkySkrSM3evafCgXD6fyJwUJHOqbpyi+xWSu/U4i76ADO2XQbFIvaZTheeWzncpm45IwM28K8+ObRwoXPkCZ+rlowZ/Dizz2+MLSictaH5KhAQco7hZuTW4c5TcNsBbkZhXD4qyNPxdSxleD7KwXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723385116; c=relaxed/simple;
	bh=IXuv7sgHsKJvbLAjHB5fl11pS4vhGDCY4ZGPqDZTOVY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=beCX2hpxvcQugHPz++Wa30lal1zq89Dlz/8gIjSxfBGKU5oZ8QfaXe00ULTxk8jHKO1SB7LHeaolYqER4iyc1riL0Guvj9kOEdr3TjBahD0ZHzvBXfO825gsNgFGqbbpvx6pb8/w3UpbHYTHS42navWh0GSV3RiHdfQrdUiTMBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=dURXMFVR; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723385101; bh=pNjGrAhKi5HHLYcEEyksj9eTeSONWd2J/V5nOcvkW0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dURXMFVRTQR8i6wMrLDOi9jJS8zV+UzaHjSLFNeTO9PMGqM9P8obwoK+Z7BJKir1N
	 LAaAWwJ+NrD7ZA9ktMduUshzDBY1OM9jVEyq35z4kzR/Nr2+sVoWZPAXTQn6QxNMah
	 mRjA7Fgr8EySsHFrg62Y5k5siRiDZ0wmJ/zQtfhc=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 13B8A661; Sun, 11 Aug 2024 22:04:59 +0800
X-QQ-mid: xmsmtpt1723385099t5i59pe7p
Message-ID: <tencent_9BD4192E4F948D96A5F58DC9925C5DAADD07@qq.com>
X-QQ-XMAILINFO: MW5hkHoBpWXybMPdnzGb1tApSD5zmeg98QNcUm5+zPcondf7MxqKDZbHvE0TP/
	 9xDrXr1/qAOTnEk86iuP+yid+NjrjS7b6+DjiRjn47Sq76iCgvkyhm5zwGWxWBUVBpph0wfJlhck
	 M2dLo+RGIz3NS8h5JZPS9WnX9BgErQKeBov1x3bjq/7wf7kJs60eYfHTSnUDTdKGJuPPpt7DqjYZ
	 BB9r32t/z5zYOf9Ny3bYkD0lC4YDacWtu9qVy8sI2rrudLSDYuSse+qQdCqiX22gYBjRRWYujd6z
	 yrEe9EDphM5OZEM8zqAHXdQaavURF1S5mEy4IynJLXq2rAHrt0dc8jXec4+lYuf46CDzJfqAteZ9
	 PkSneylDX9XEMruU2iNeKatJQ517hOcDXDmHdzeT8QZFfzeR7N72yXPKOywl8WDL4vSRnrdffmYx
	 NGmL2Ed9ExAnjoLtiIWN7kjwVxGAqnhmuIoeoTUeLpuQtsowyuSDUtLVlQ8eO9oRraMvVJv8KF1+
	 v6K3gsDTsg29Nb3OJ4wcXZQonjwJ3O4U0zc5zyXgk1RU4hEmng/Wj8QMkLdh+VPSKX0BjC5oYhU2
	 9ey22KujLwuaUNEaJdgoV0Nt87cClAA2MClqLl5gJFHKxHqS14tKoQ56/2N7HyXlK88XFq9O+Dwd
	 ccWArH5vPz43TqIxaRLkq3N9jIvfRGnXeKysaBmOMdhW4jTLH60/+IfH9qXDYKe2hI1ZX7O8vxto
	 g11md+FW855qqwRjyopHujvB0PkG6mZZH3MGSv826klv/HhMd6Qhumh9qHILHGRaeSOgDJoBZpaU
	 3o73Dk1nUUADPHO4u3vxYHai6WtINEpT+5B+m01SL3o/l/nkfAQHvKHTshIhaC6dquijs5ERKTlT
	 jvf4no2m/F37BdOmcajpwwa+5knwIviAvdXQNR07cABx8U4QcQ93fHy9kdpnQnkblZzsIT7jTLGy
	 jOcfLRcssk1FFVVQZjzxxOxI6dDxTL3WEJJruABpw=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Sun, 11 Aug 2024 22:05:00 +0800
X-OQ-MSGID: <20240811140459.3440544-2-eadavis@qq.com>
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
index 4430ac68e4c4..ddb16ce699ba 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2687,6 +2687,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 			/* deal with chardevs and other special files */
 			ret = 0;
 		}
+		printk("ret: %d, ino: %lx, comm: %s, %s\n", ret, mapping->host->i_ino, current->comm, __func__);
 		if (ret != -ENOMEM || wbc->sync_mode != WB_SYNC_ALL)
 			break;
 
@@ -2797,6 +2798,9 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
 		folio_account_dirtied(folio, mapping);
 		__xa_set_mark(&mapping->i_pages, folio_index(folio),
 				PAGECACHE_TAG_DIRTY);
+		printk("ino: %lx, comm: %s, mapping tagged :%d, %s\n",
+			mapping->host->i_ino,
+			current->comm, mapping_tagged(mapping, PAGECACHE_TAG_DIRTY), __func__);
 	}
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 }
@@ -2828,6 +2832,9 @@ bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
 		return false;
 	}
 
+	printk("ino: %lx, comm: %s, mapping tagged :%d, %s\n",
+		mapping->host->i_ino,
+		current->comm, mapping_tagged(mapping, PAGECACHE_TAG_DIRTY), __func__);
 	__folio_mark_dirty(folio, mapping, !folio_test_private(folio));
 	folio_memcg_unlock(folio);
 
@@ -2859,6 +2866,9 @@ bool folio_redirty_for_writepage(struct writeback_control *wbc,
 	bool ret;
 
 	wbc->pages_skipped += nr;
+	printk("ino: %lx, comm: %s, mapping tagged :%d, %s\n",
+		mapping->host->i_ino,
+		current->comm, mapping_tagged(mapping, PAGECACHE_TAG_DIRTY), __func__);
 	ret = filemap_dirty_folio(mapping, folio);
 	if (mapping && mapping_can_writeback(mapping)) {
 		struct inode *inode = mapping->host;
@@ -3148,8 +3158,12 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 		 */
 		if (mapping->host && !on_wblist)
 			sb_mark_inode_writeback(mapping->host);
-		if (!folio_test_dirty(folio))
+		if (!folio_test_dirty(folio)) {
 			xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
+			printk("ino: %lx, comm: %s, mapping tagged :%d, %s\n",
+			mapping->host->i_ino,
+			current->comm, mapping_tagged(mapping, PAGECACHE_TAG_DIRTY), __func__);
+		}
 		if (!keep_write)
 			xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
 		xas_unlock_irqrestore(&xas, flags);


