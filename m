Return-Path: <linux-kernel+bounces-281748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4C694DAC2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 06:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1C31C20FEC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 04:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B439D13B59A;
	Sat, 10 Aug 2024 04:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="X/YJQCs0"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BDF322A
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723265612; cv=none; b=DRV7t8WpceI//FWeDmP8ypU7RCaMDKaGnC8F9tTke5NLIsZfBaqQYGEgxL4gUn3L6v2UBZ3mtp2amD2boHECPGJD5Ne05czaURcLxoVOYINoccNheAud38/guKvd3EOj+AJp1+QUextDAEB0j476vhiSeGUCGJdHnhgeI/5ECeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723265612; c=relaxed/simple;
	bh=5f0qeeSszFvRVbcTgLnsjCJjYoB3d6mSUz9AxBjjdWU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=O2JT8SlZDU/QjcMorwx3FW5rBgq8XGNyO7jDfKRq9zuOhPW556gpDxIqUHAC5LGdKDUkB0xk7hkBQ6ixoNS0T1yUhenPaqh8+IHRY+e0GpWPtozTgT2yk0cJ0elUw43onUJ9FnzJnewAgpNg+tmgH7EUtFAuoRFt1oToHem0KJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=X/YJQCs0; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723265603; bh=2ceWokxa+vxK8OmlUFNF7/jD96ugSbiGnWqQfKR+S44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X/YJQCs0ntsvTyl0IB7LMYM5ZZsB2+JxR3WbGpIO4X51KtLPCXNK6Ij3MSIzeyjOq
	 t9i845EiOwOC3onTMB0Ukuok/Xn2E0uYMtSfsMGG4O79uCfr7PnbNLO/rV6+4LCWGo
	 umbJNB/GVxsQko7PTI59wF92vXtc+FDL+R30TdWA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id D562765A; Sat, 10 Aug 2024 12:53:22 +0800
X-QQ-mid: xmsmtpt1723265602toe2imrfd
Message-ID: <tencent_A4D16DD09714EB42ECAACD247A966CA42C0A@qq.com>
X-QQ-XMAILINFO: MmuCfgcSBfHxR82oft0Sp4zyFrp7S/C1/69UvTod/YWdIgzERTIidFolZCy94G
	 MR1IMamHCejMTtFyRrEuD89HbHqoPQBrw1nPfy457NKcS55S0s1/7o8eeiHfxI1wvB6DDTX4RtAf
	 R9f3MGyTV5XmIo3thhDmUVRgjvYctNKxps+WOdVpdIY0EBJveUQ/VtmMwdHz0HPsezE3UCASxH67
	 1PvMa4Rlk0kFm2HDZdZ9JmR7bBVtA5IYzPkFDeewloaQ2wlllb44DTS+1v6Gp9aZsxrNTsGnNQ57
	 PeX8FjiSQUo8MXHK8QI9xGMFsK2K4++XixhKwx70R2V0YxWpViunavCF0/btkqMLbRkhMZFf5XWG
	 h3/R8S9fVXEfMMHA17tGBg2g8Bm9lX5E7ZUajhXOmTySm+PnBeaWcSn9yTB+GR0cLUhUDs03OIYP
	 GXHsORiJ3BCWnypMBIHgzsLv1LVREQ+oHoX/2qSfI+D1qqaxVUOQ863pHE0BKRXn8cptm8NgURvI
	 F3sHqf/hRPp81ph5B+DlfNN5KMw0vO/gmO+lgYLJNyd3VG6AxQ/inRXAKfwFD6qCs0CsSlWdrzIX
	 A7CIrisxpwBqu+6duPK4G5OlTk4xp5sU4ljh9TZtlhrJUy4Lv1Lz5KDirkIvDOJHdoX/hU0lxrpA
	 Xqjk44GpFjfiw5XRADaso4vFhsT3R5nezNl147vvn379YP2Pm+Tdti8OIex9UpANm7BBzreEFS6B
	 1M+gcE9b5ly6xLLwc/iif92JOPGaKOLQ8BnyF/Ax0LOnA4b4ijRPRsBX+7PJ2koCg3+ke3Y9C9h2
	 zhD297wDVDWMB6Rq4+m9DMLzdXdw9SFjQVIyeKd3ngbMBnSo8/7SKULBYW1TFUyEFacMClXfFWEk
	 2ClzPqjJDUcSB1bJgnSQ4KUUyarH3ReDTgGY75l9dgF0DtBseHv2g9tmSyNbVYy1c0nxH7xiAh1k
	 +cypyzzaB3/V0mkX1CY+g0HBx6TfzeK7Z3KBtFxks=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Sat, 10 Aug 2024 12:53:22 +0800
X-OQ-MSGID: <20240810045321.2108023-2-eadavis@qq.com>
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
index 9258d30cffe3..4c03b8911375 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -522,12 +522,19 @@ int netfs_writepages(struct address_space *mapping,
 	trace_netfs_write(wreq, netfs_write_trace_writeback);
 	netfs_stat(&netfs_n_wh_writepages);
 
+	unsigned long  i_state = wreq->inode->i_state;
+	wreq->inode->i_state |= I_SYNC;
+	printk("doing sync: %d, before sync: %d, ino: %lx, comm: %s, %s\n", wreq->inode->i_state & I_SYNC,
+			i_state & I_SYNC,
+			wreq->inode->i_ino, current->comm, __func__);
+
 	do {
 		_debug("wbiter %lx %llx", folio->index, wreq->start + wreq->submitted);
 
 		/* It appears we don't have to handle cyclic writeback wrapping. */
 		WARN_ON_ONCE(wreq && folio_pos(folio) < wreq->start + wreq->submitted);
 
+		printk("ino: %lx, folio: %p, %s\n", wreq->inode->i_ino, folio, __func__);
 		if (netfs_folio_group(folio) != NETFS_FOLIO_COPY_TO_CACHE &&
 		    unlikely(!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))) {
 			set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
@@ -538,6 +545,9 @@ int netfs_writepages(struct address_space *mapping,
 		if (error < 0)
 			break;
 	} while ((folio = writeback_iter(mapping, wbc, folio, &error)));
+	wreq->inode->i_state &= ~I_SYNC;
+	printk("end sync: %d, ino: %lx, comm: %s, error: %d, %s\n", wreq->inode->i_state & I_SYNC,
+			wreq->inode->i_ino, current->comm, error, __func__);
 
 	for (int s = 0; s < NR_IO_STREAMS; s++)
 		netfs_issue_write(wreq, &wreq->io_streams[s]);


