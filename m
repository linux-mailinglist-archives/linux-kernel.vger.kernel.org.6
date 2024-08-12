Return-Path: <linux-kernel+bounces-282988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B0394EB8B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66FB8B21C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96183170A2B;
	Mon, 12 Aug 2024 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QfNNKLLx"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C2316B39A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723460247; cv=none; b=jFV1F8QaxLMtUEtLn400qeZ8PRYjCQ5o3/vE/d8zULG4180WZ/W/8HZC+1/h88+KKesJQToUt3pVuAcsN72RawWKAFk7N2xWxrea8iKmuCYHo3K2WJG0m8XJCAoZuTIWgi8gwGqrj0gwCu0fKfesVzeDGH9qrcRw9qgIJw2/+9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723460247; c=relaxed/simple;
	bh=HLiIXNsdy8em/WxL6L7PchBvVakc0ChOowbbalsqkLg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LV0yPNIjdhybBjG5vlXL0aJer2Qr8xnX58blRxxoWgSYahEkXsDaWaDQz2BEtmvQtedgQ1VJdNsbK6ndM/tIKvYS37Y460Ygi+dWRkiumaOXHtK4RU28pb9tRgsShL9KaezDhxOtAJiQKboRXdDsFWfX3uZHCELHEl1SwcSCEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QfNNKLLx; arc=none smtp.client-ip=43.163.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723459934; bh=c4Tri+QZc4oztXbTPkd1dYATrQ6+3Wocd7p1N3K8Ego=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QfNNKLLxrMbDXA7abkDPBQkEIIAYd9txHIwy7to5DuwXfnuqXO5D2sCn07EFKU+VH
	 Yjp60pIy8x4qeY3gAiKkJeRNMmCPjP0GZJTugSlA2eE0M1jGxAg3Va24CfQVtBi7iH
	 wElgnI9JuWkdQdWWQAFbA17uaCNhxdrXMVrlkJGU=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id D0CAA834; Mon, 12 Aug 2024 18:52:12 +0800
X-QQ-mid: xmsmtpt1723459932ty9umz8ld
Message-ID: <tencent_E325B68DA09221DDA0DD81191A4F878DAC07@qq.com>
X-QQ-XMAILINFO: NhpLzBn2I3Xw0QeAj7A6LJ9dq5cY9SiF8G+18c1+j8z2K4yafspyW2qq3cqMmc
	 xUJ0OxSPhyGW4K096c0LXv1+AfXEjdnnkouQDLOrb5dWcI1Mke59blUbJeAh4mlZLJhngmmbFJOp
	 mK7ao76RcWrILQBShJB91NdcXZpP0mkuspeoQ9uKbBPWdvioAAhKf7axUyFB7mkbR6mvOrXCqdlM
	 luSmjZK1whK7fZN5JwXL7PMHI6/mnHhTknqx6c8N2fef/M2YQLffc1Vz5bi3mskhlLISKmVclWSw
	 Zx+3gRjoZi/ndFIvjospoX0mVj5ilzjF7a2N56Q3rnYDYnGox0EFVdiziV49HXkccn8FfjgGrAHj
	 y5YC1J5iB47sfTDQceD3bXD8wBff6npKIHJ+xy8IMEF28yoSFjjcVZUy+PZqEBSaBLHMiE23PpMR
	 /Tc9xj2yt3upLM+rJsrz8QZ/fy+F+1m8ajKxUHaetODRdF6I06MgKX3bRs4/+ZJ7YLWkvdxuSxqI
	 Ho/FD10sC7mYAxBAKYMNI+FLdLGiYo9QKuq33bC56EhPM9BcnKuUPyWNvkDTmiFcd1x8pYfXxRna
	 3z4v1pxExmwpIuqtY2RSw8VvJCN8z/FnmsbPC+4TMyVTpm3xgQz0rGCaYfxnm+XK3MopSUg+K+vg
	 mTmxx8vPixl1b1PLBzAmg/vkwz3t4eiGRsseHQLMAt13uzYSShasgx4U8rEUdA125+rPEu1DNUs8
	 NMPOJ8Tifku/4Fjs2M+/BebfJd1jkkH0arqT1H0S3q0Mt1tcIY7gQvxA3DsD6zPoAInspwUWSNUx
	 RIu4yhIR1Lem+oKZuvgZVPpXHR9vJutpIulLABn3mJGvQPsc+zIPd7jTgH2Ywr7HLgUPrMyaV084
	 MNo6B9onmyuXeT+qcczc/mfp2+igPF+LaeQPrUxIV6hj2QuEOInUEYN/GkUjIt5Q==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Mon, 12 Aug 2024 18:52:12 +0800
X-OQ-MSGID: <20240812105211.3479523-2-eadavis@qq.com>
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
index 9258d30cffe3..0f3c314d27d3 100644
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
@@ -331,6 +333,7 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	if (fpos >= i_size) {
 		/* mmap beyond eof. */
 		_debug("beyond eof");
+		printk("1 ino: %lx, folio: %p, %s\n", wreq->inode->i_ino, folio, __func__);
 		folio_start_writeback(folio);
 		folio_unlock(folio);
 		wreq->nr_group_rel += netfs_folio_written_back(folio);
@@ -403,8 +406,10 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
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
@@ -503,6 +508,15 @@ int netfs_writepages(struct address_space *mapping,
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
@@ -522,6 +536,8 @@ int netfs_writepages(struct address_space *mapping,
 	trace_netfs_write(wreq, netfs_write_trace_writeback);
 	netfs_stat(&netfs_n_wh_writepages);
 
+	printk("ino state: %lu, ino: %lx, comm: %s, folio: %p, %s\n", wreq->inode->i_state,
+			wreq->inode->i_ino, current->comm, folio, __func__);
 	do {
 		_debug("wbiter %lx %llx", folio->index, wreq->start + wreq->submitted);
 
@@ -551,6 +567,7 @@ int netfs_writepages(struct address_space *mapping,
 	return error;
 
 couldnt_start:
+	printk("ino: %lx, folio: %p, error: %d, %s\n", mapping->host->i_ino, folio, error, __func__);
 	netfs_kill_dirty_pages(mapping, wbc, folio);
 out:
 	mutex_unlock(&ictx->wb_lock);
@@ -600,6 +617,7 @@ int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_c
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
index e0d34e4e9076..84c3d83439d9 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -215,12 +215,18 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		 inode, filp, fid ? fid->fid : -1);
 
 	if (fid) {
-		if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRITE))
-			retval = filemap_fdatawrite(inode->i_mapping);
+		if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRITE)) {
+			printk("ino: %lx, comm: %s, %s\n", inode->i_ino, current->comm, __func__);
+			if (!mapping_tagged(inode->i_mapping, PAGECACHE_TAG_WRITEBACK))
+				retval = filemap_fdatawrite(inode->i_mapping);
+		}
+		printk("del, ino: %lx, ino state: %lu, comm: %s, fid refcount: %d, %s\n", inode->i_ino, inode->i_state, current->comm, refcount_read(&fid->count), __func__);
 
-		spin_lock(&inode->i_lock);
-		hlist_del(&fid->ilist);
-		spin_unlock(&inode->i_lock);
+		if (refcount_read(&fid->count) == 1) {
+			spin_lock(&inode->i_lock);
+			hlist_del(&fid->ilist);
+			spin_unlock(&inode->i_lock);
+		}
 		put_err = p9_fid_put(fid);
 		retval = retval < 0 ? retval : put_err;
 	}
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
index 4430ac68e4c4..043809a4cf9e 100644
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
@@ -2906,6 +2916,7 @@ bool folio_mark_dirty(struct folio *folio)
 		 */
 		if (folio_test_reclaim(folio))
 			folio_clear_reclaim(folio);
+		printk("ino: %lx, folio: %p, %s\n", mapping->host->i_ino, folio, __func__);
 		return mapping->a_ops->dirty_folio(mapping, folio);
 	}
 
@@ -3148,8 +3159,12 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 		 */
 		if (mapping->host && !on_wblist)
 			sb_mark_inode_writeback(mapping->host);
-		if (!folio_test_dirty(folio))
+		if (!folio_test_dirty(folio)) {
 			xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
+			printk("ino: %lx, comm: %s, mapping tagged :%d, folio: %p, %s\n",
+			mapping->host->i_ino,
+			current->comm, mapping_tagged(mapping, PAGECACHE_TAG_DIRTY), folio, __func__);
+		}
 		if (!keep_write)
 			xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
 		xas_unlock_irqrestore(&xas, flags);


