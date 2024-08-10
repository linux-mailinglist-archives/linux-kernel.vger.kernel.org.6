Return-Path: <linux-kernel+bounces-281717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EE894DA3F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 05:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961951C21259
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 03:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109CF446A1;
	Sat, 10 Aug 2024 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="e5uM41eX"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3291DFEF
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723259099; cv=none; b=ITDo2ezoPSToQQOECwr+bP05UufsE0jTTDLfXAvqP0MIDH3wGVbnByi1yFJDfui7o+q2eXBln1iDIxM60d3j29AohzhL7P6CFLlSeZw2wrQGt4+n7b9Ehp4Y98OXKV/lWeTiK8BIMPw+EbOakEyYImTx8t4KyI9TXcKVS7IxMu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723259099; c=relaxed/simple;
	bh=a+n2chq7GDDziB8UnHBJdV4UnaciuVrR1vmYsk4Wd1I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LWWrR96bG5nZpwqMZF2wJxInKe056GZUFSki/bEIehZzqnVG3TDLw4r9XwZOh5/mU4Z6JQT9IxfikCnaVMjT37m4U7MhRd8eFy0FkVFSwuC5O7PC/R6DwbI1H5h24+XHF7Ub60LCmz/1rhnBID6ioNlRBEjGsD90aIeszCdGMN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=e5uM41eX; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723259092; bh=pxKu+KH/Wuah9nqEGGwHYdMyUoXc/vJ6Ahll6JMFerU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e5uM41eXILadAE4fwNlVwj0aqPNG/6sLhTiYK2eFSe/nBEIcMP5H5S/NSsc5TNF2M
	 fY2T/tx8M6V+kObVWibHAcGg85/MEaU/cc7j1tivJE9Hig9gYna4c9ONAqwKlnvNLK
	 bhj1lwcRA0/54/cfP52RG9oKG7gKfcT8hC3uSuCs=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id E2706276; Sat, 10 Aug 2024 10:56:39 +0800
X-QQ-mid: xmsmtpt1723258599tbomu2s9e
Message-ID: <tencent_F9DE2ED60CB227C5C6FB92F30665498B6E06@qq.com>
X-QQ-XMAILINFO: OaubouGXmhNzNDsCabnRXfwQaqugLHEhvayfaId+wGWk+CDNifyF7YIzg1vI6s
	 bgQLZMO5nhyguQxj7XKlcUbcfOVzxg1qsYKkJmZoCnWXXJF3Wc+s3koxt8QdDtJSFrg8UnqVHN9o
	 qPP3mpx5oPpUUqdkjgZvPOJWyOLUiGM5mHf9vE+ePMfMFeScGwLNOFg1nhY4Nh17UjTZis0YGS/3
	 jj0g4kDjGohLyS+jf5SyFbW+usob+lND6PwtOBcBdwdNg5yDCaO9io0EUWR10I36gZUd5yq2uvLN
	 eapM535PHtbkzXHSzV3jmgVP/14eBggwC7J5uLOJWtYDVFciwkm9j7AlkokNverK79VPw5z8RB5E
	 ops0gYRxWOYMzRRfMlS0EhaCbJ/GQNzU5qeQD0qxtoy0qJIe3tHt/SoVNjWksiikovCZwosK/5Ee
	 LOi0g5TjX35pqNzacWYDlcONS0Jg/r/+XaJxhga8hu81lLuJhhZkw5GZCWbqzh6DF1D5VHGqwgWk
	 mab2tFxSgE49QWZIzFdZnMfAmPns0fR+DXDGC0+V7S+mEl1ZfWNyiMi2fBIu/3O1iXU1IAxbaqUZ
	 AtCA0NTUi8LZozIrBJkD2bzUpcBO9m7i68gHl77ccTSrTNBunC1xKxMHayccR4bYxz9RdyeUzPsg
	 zsE7sSXzJVht1p82lA23F/tqxXZAw9eH7zbzfoRB94MvnNjkS/K/RLkNLVUka+nBa2RuOMGI9vDR
	 CW7zV0jPcKdR9hJnlitc5s2H+pvwrwNNfPls1RVOfgBL3M1cZ1dYYrs5lN53Nfmx5G5Ewef7OK+b
	 jycxpbZljGXhLyCHBnrSKM0QGdMZS+0PQgbxeksCjEupA5z1v0LMzusY98+CeAI9q+K0vrZEHi8w
	 G3RhZq/z1i2EN02T5JSXhMQ1aOwUMimvboTgW1pzq43g1C0jPKybr4K0VX1Gk8OKVWNhr/An/gLX
	 fAkmLQ+A61mYArlNnQOkI1C9nOTsPAikJgh0mxaCg=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Sat, 10 Aug 2024 10:56:40 +0800
X-OQ-MSGID: <20240810025639.1991934-2-eadavis@qq.com>
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

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index de009a33e0e2..b5ccab74bb6f 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
+#include <linux/file.h>
 
 #include "v9fs.h"
 #include "v9fs_vfs.h"
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
index e0d34e4e9076..3fe715ab6efd 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -219,6 +219,15 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 			retval = filemap_fdatawrite(inode->i_mapping);
 
 		spin_lock(&inode->i_lock);
+		printk("del, ino: %lx, ino sync: %d, comm: %s, %s\n", inode->i_ino, inode->i_state & I_SYNC, current->comm, __func__);
+		if (I_SYNC & inode->i_state) {
+			spin_unlock(&inode->i_lock);
+			if (wait_on_bit_timeout(&inode->i_state, I_SYNC,
+						TASK_UNINTERRUPTIBLE, 5 * HZ))
+				return -EBUSY;
+			spin_lock(&inode->i_lock);
+		}
+
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
 		put_err = p9_fid_put(fid);
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 348cc90bf9c5..4d37c1932de4 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
+#include <linux/security.h>
 
 #include "v9fs.h"
 #include "v9fs_vfs.h"
@@ -44,6 +45,12 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	struct p9_fid *fid;
 	int omode;
 
+	if ((file->f_flags & O_RDWR || file->f_flags & O_WRONLY) &&
+	    security_file_permission(file, MAY_WRITE)) {
+		pr_info("file: %p no permission, ino: %lx, %s\n", file, inode->i_ino, __func__);
+		return -EPERM;
+	}
+
 	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
 	v9ses = v9fs_inode2v9ses(inode);
 	if (v9fs_proto_dotl(v9ses))
@@ -397,6 +404,12 @@ v9fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct p9_fid *fid = file->private_data;
+	struct inode *inode = file_inode(file);
+
+	if (security_file_permission(filp, MAY_WRITE)) {
+		pr_info("file: %p no permission, ino: %lx, %s\n", file, inode->i_ino,  __func__);
+		return -EPERM;
+	}
 
 	p9_debug(P9_DEBUG_VFS, "fid %d\n", fid->fid);
 
@@ -460,6 +473,11 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 	struct inode *inode = file_inode(filp);
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 
+	if (security_file_permission(filp, MAY_WRITE)) {
+		pr_info("file: %p no permission, ino: %lx, %s\n", filp, inode->i_ino, __func__);
+		return -EPERM;
+	}
+
 	p9_debug(P9_DEBUG_MMAP, "filp :%p\n", filp);
 
 	if (!(v9ses->cache & CACHE_WRITEBACK)) {
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 9258d30cffe3..4434bf37caa1 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -522,12 +522,23 @@ int netfs_writepages(struct address_space *mapping,
 	trace_netfs_write(wreq, netfs_write_trace_writeback);
 	netfs_stat(&netfs_n_wh_writepages);
 
+	unsigned long  i_state = wreq->inode->i_state;
+	wreq->inode->i_state |= I_SYNC;
+	printk("doing sync: %d, before sync: %d, ino: %lx, comm: %s, %s\n", wreq->inode->i_state & I_SYNC,
+			i_state & I_SYNC,
+			wreq->inode->i_ino, current->comm, __func__);
+	if (i_state & I_SYNC) {
+		error = -EBUSY;
+		goto couldnt_start;
+	}
+
 	do {
 		_debug("wbiter %lx %llx", folio->index, wreq->start + wreq->submitted);
 
 		/* It appears we don't have to handle cyclic writeback wrapping. */
 		WARN_ON_ONCE(wreq && folio_pos(folio) < wreq->start + wreq->submitted);
 
+		printk("ino: %lx, folio: %p, %s\n", wreq->inode->i_ino, folio, __func__);
 		if (netfs_folio_group(folio) != NETFS_FOLIO_COPY_TO_CACHE &&
 		    unlikely(!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))) {
 			set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
@@ -538,6 +549,9 @@ int netfs_writepages(struct address_space *mapping,
 		if (error < 0)
 			break;
 	} while ((folio = writeback_iter(mapping, wbc, folio, &error)));
+	wreq->inode->i_state &= ~I_SYNC;
+	printk("end sync: %d, ino: %lx, comm: %s, error: %d, %s\n", wreq->inode->i_state & I_SYNC,
+			wreq->inode->i_ino, current->comm, error, __func__);
 
 	for (int s = 0; s < NR_IO_STREAMS; s++)
 		netfs_issue_write(wreq, &wreq->io_streams[s]);


