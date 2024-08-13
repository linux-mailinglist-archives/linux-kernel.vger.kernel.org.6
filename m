Return-Path: <linux-kernel+bounces-283938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2F194FAC2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 02:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F441F22B71
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356BE17FF;
	Tue, 13 Aug 2024 00:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="U8A1O5My"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907280B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723509486; cv=none; b=cWzXc0FuqX5ztLrX682U2eJH/kLeXzSDpZGc84xFoK+z1SaDF8rJXDHpzwb8VHY4feliOMK7Q4Jej1JV26aY8Sor/lv9E4+8B98CE8iT/tjerEhwk0lPon16Faxo01ZhTbRm2gJDNRSfK21O0zYdwpgbiLnBZQkyi1ush40vvbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723509486; c=relaxed/simple;
	bh=+s57+tntvyajUcYFGNfZ3PnhBDtpGzGBvHc436/X9+c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XGztkW2IACg7RXfKIrIbbG6dKTtEK7TFsTfDwG4LEL0iImvxFwSXejY/7ESzQz+vFeSDVHmPNM7yMGNudilvekm/OrjA8iJk5Hsc6pEu+L/GUFrdqNJNu6LmXUg1bXXM0WcfBNoXSff3r5hRrc2iNxb8U0Aqk0RYQ6j4W258Ynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=U8A1O5My; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723509473; bh=4xCFSa7ZElTH/do1nCcp6YnxiSdO97aalBJblNLYbVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U8A1O5Myh5l1eQ/tntGFkYE54ymnnIbErQ4XhBFnSWQkO7ZKrsebftK35rPmnpLCg
	 g5q+PTg5dl3O4bT7krtuoQNa3E0PGadq5LQpyS9CXGg1MrfvzQE4dB/z+NEVBtdfxs
	 0Kh5eyOnhZoo0KtGxNx3ElOwWDqn3DwowWxQ8R+I=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 7670D6FC; Tue, 13 Aug 2024 08:29:39 +0800
X-QQ-mid: xmsmtpt1723508979tw592j0bz
Message-ID: <tencent_4F3D01369496AE36884A5875BF762566BE09@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J28UJmJ5Eq3ofbfWB2MDAbdIGlpWVKVPjUDOuurlNwyCICUvCkCC
	 hJIOZWWmIY84/h22V4xE6gM1PvSP2lXc8AQ5RpnJc1TwU5ku4XFJ/NO/2ouUhpopv9uy1oR09nmO
	 iJFq4EDUXBrt4IZ6s4bbTNyQZYc84gjBeXH1fn6hIfcVNceXA/R9etP69KB4RJhcBA65XhJxSvJI
	 xkFMCfnB8Ocu5N2q1NXZCV5/XNABo6y0/EmxOBNBmyYxFC4iKNruVEPhY5zXaXOL8/pJmOK/OYL5
	 b7EJKWSy3MtxSkmA6qB15L5jkdiGBddRNbHsrQ4gqOc6keXiM96eSLg8yGzGOULJjmTM81Hsr+Is
	 32RYWlSqK/Dq3E1Ql2Nee4lUiXy3DvZ53wiOUyL9z0ymevILr8GyDYnmKG+HDWiXGX0TKlcyEMnN
	 i7+Bi+8bUmIMGDTe18PT6OHWNqQwQA82frTs1oJhGNtR7HNqhPF9UQvqoPbXY0qG+1WQl7DxyS3o
	 nFEcs3PKM6wCQx9nykKqopwghhkzVhhcyJRnP/KTWftkahdh/hLRdba0+toQ6sY2/+uzC9W9QewG
	 Mzdr7ZUcYbT+ZhC+t5a8Z+OVWPxjuQQNmp05VEffky4FiNeD7jMioDeHTK3Nu3rHabRfMUspbLJx
	 fyxkb9eJ/lZLMp80RW1LZvIGRdHmoJqtCSSGEeXYMPFpL9SGVoMV18F0wFDDESof8eRWOVJyi0qn
	 bvB8PKHXEJlWUv0iwfUvSQ+mshSSHqJkkzUkivI+GvMwhXdMTBUPHsUgZVErGKOyzWaBkPD8G8i/
	 E2ZFyDlCMGF0oIPid2YXCAIVihxn5xOZobGUIffeb4G7WFvgJPU6UHgiJSVhoXp4wnqzSZ2LZZD1
	 T+o/zIk9YFL4lj81ovnb4yaEnc3m+UfG14Ihf9oT4sD7Ev4b+uUIl2twDkQgErSg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Tue, 13 Aug 2024 08:29:40 +0800
X-OQ-MSGID: <20240813002939.3743136-2-eadavis@qq.com>
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
index a688d4c75d99..533738844f0c 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -110,6 +110,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 			if (wback_to_cache && !WARN_ON_ONCE(folio_get_private(folio) != NULL)) {
 				trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
 				folio_attach_private(folio, NETFS_FOLIO_COPY_TO_CACHE);
+				printk("ino: %lx, folio: %p, %s\n", folio->mapping->host->i_ino, folio, __func__);
 				filemap_dirty_folio(folio->mapping, folio);
 			}
 		}
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 4726c315453c..8e4804f24f06 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -392,6 +392,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 			folio_mark_dirty(folio);
 			folio_unlock(folio);
 		} else {
+			printk("ino: %lx, folio: %p, %s\n", wreq->inode->i_ino, folio, __func__);
 			netfs_advance_writethrough(wreq, &wbc, folio, copied,
 						   offset + copied == flen,
 						   &writethrough);
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 83e644bd518f..cb4b16c8a129 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -28,6 +28,7 @@ bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio)
 
 	_enter("");
 
+	printk("ino: %lx, folio: %p, %s\n", inode->i_ino, folio, __func__);
 	if (!filemap_dirty_folio(mapping, folio))
 		return false;
 	if (!fscache_cookie_valid(cookie))
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 9258d30cffe3..648a7ea6881c 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -35,6 +35,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include "internal.h"
+#include <linux/backing-dev.h>
 
 /*
  * Kill all dirty folios in the event of an unrecoverable error, starting with
@@ -74,6 +75,7 @@ static void netfs_kill_dirty_pages(struct address_space *mapping,
 
 		trace_netfs_folio(folio, why);
 
+		printk("ino: %lx, folio: %p, %s\n", mapping->host->i_ino, folio, __func__);
 		folio_start_writeback(folio);
 		folio_unlock(folio);
 		folio_end_writeback(folio);
@@ -387,6 +389,7 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	} else if (fgroup != wreq->group) {
 		/* We can't write this page to the server yet. */
 		kdebug("wrong group");
+		printk("1 ino: %lx, folio: %p, %s\n", wreq->inode->i_ino, folio, __func__);
 		folio_redirty_for_writepage(wbc, folio);
 		folio_unlock(folio);
 		netfs_issue_write(wreq, upload);
@@ -403,12 +406,15 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	 * from write-through, then the page has already been put into the wb
 	 * state.
 	 */
-	if (wreq->origin == NETFS_WRITEBACK)
+	if (wreq->origin == NETFS_WRITEBACK) {
+		printk("2 ino: %lx, folio: %p, %s\n", wreq->inode->i_ino, folio, __func__);
 		folio_start_writeback(folio);
+	}
 	folio_unlock(folio);
 
 	if (fgroup == NETFS_FOLIO_COPY_TO_CACHE) {
 		if (!fscache_resources_valid(&wreq->cache_resources)) {
+			printk("3 ino: %lx, folio: %p, %s\n", wreq->inode->i_ino, folio, __func__);
 			trace_netfs_folio(folio, netfs_folio_trace_cancel_copy);
 			netfs_issue_write(wreq, upload);
 			netfs_folio_written_back(folio);
@@ -503,6 +509,15 @@ int netfs_writepages(struct address_space *mapping,
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
@@ -522,6 +537,8 @@ int netfs_writepages(struct address_space *mapping,
 	trace_netfs_write(wreq, netfs_write_trace_writeback);
 	netfs_stat(&netfs_n_wh_writepages);
 
+	printk("ino state: %lu, ino: %lx, comm: %s, folio: %p, %s\n", wreq->inode->i_state,
+			wreq->inode->i_ino, current->comm, folio, __func__);
 	do {
 		_debug("wbiter %lx %llx", folio->index, wreq->start + wreq->submitted);
 
@@ -553,6 +570,7 @@ int netfs_writepages(struct address_space *mapping,
 couldnt_start:
 	netfs_kill_dirty_pages(mapping, wbc, folio);
 out:
+	printk("out, ino: %lx, folio: %p, error: %d, %s\n", mapping->host->i_ino, folio, error, __func__);
 	mutex_unlock(&ictx->wb_lock);
 	_leave(" = %d", error);
 	return error;
@@ -600,6 +618,7 @@ int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_c
 			folio_clear_dirty_for_io(folio);
 
 		/* We can make multiple writes to the folio... */
+		printk("ino: %lx, folio: %p, %s\n", wreq->inode->i_ino, folio, __func__);
 		folio_start_writeback(folio);
 		if (wreq->len == 0)
 			trace_netfs_folio(folio, netfs_folio_trace_wthru);
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
index e0d34e4e9076..08aa879896e3 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -215,8 +215,12 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		 inode, filp, fid ? fid->fid : -1);
 
 	if (fid) {
-		if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRITE))
-			retval = filemap_fdatawrite(inode->i_mapping);
+		if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRITE)) {
+			printk("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
+			if (!mapping_tagged(inode->i_mapping, PAGECACHE_TAG_WRITEBACK))
+				retval = filemap_fdatawrite(inode->i_mapping);
+		}
+		printk("del, ino: %lx, ino state: %lu, comm: %s, %s\n", inode->i_ino, inode->i_state, current->comm, __func__);
 
 		spin_lock(&inode->i_lock);
 		hlist_del(&fid->ilist);
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 348cc90bf9c5..5b2a77bf1e5e 100644
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
index 4430ac68e4c4..28a4a7a60446 100644
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
+	printk("ino: %lx, not write folio: %p, nr: %lu, comm: %s, mapping tagged dirty :%d, %s\n",
+		mapping->host->i_ino, folio, nr,
+		current->comm, mapping_tagged(mapping, PAGECACHE_TAG_DIRTY), __func__);
 	ret = filemap_dirty_folio(mapping, folio);
 	if (mapping && mapping_can_writeback(mapping)) {
 		struct inode *inode = mapping->host;


