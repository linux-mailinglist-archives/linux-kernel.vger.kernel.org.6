Return-Path: <linux-kernel+bounces-281071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8396D94D2B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7F7282AF6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA29198833;
	Fri,  9 Aug 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZIpqrbZo"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F61F197A96
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215239; cv=none; b=LDqxh+3HeDahdzsIa42BkrvhQ1Fo47iYklOuymN4cMZsu67HcvCrVByqkJkM4P+RCPh10Cw37JkjU0owZfKhXo8eWOpHX34ej98S7GNVWAZ5jYcnTGDl+067UzOodGMMEnY/MscXvajBviZO0bTMH8x1s9Fc6jpdolobM1hukDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215239; c=relaxed/simple;
	bh=zCfyFMMs6JDyXlKiwJJVRwVbrxEpXMpBTusDmiA49dY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Z861HoNRlfUGKDpND3GKc/X4VDhUYC4BY+LYIwH+lMPadpl2pcMmqS/4z9X8iCGhUwDxUDlWrkMjpuT6ZVbeeYWSFx0M/cRVw7ffN33ZZjHfQKW1VKsv0wi3FrFz4GyJjGvgicDUhvXA/IUWLT5pGjJ/I6g4eq9EjmCFL14DJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZIpqrbZo; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723215233; bh=zgl3qk9KQa1/i7bu8KrOi+ywWNvE+L0korxbls4p3yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZIpqrbZoDTqMJ1+npm1FHDjnnUweS3FTQbuk5NHKURX+t4hjxI3ip3gzPP5ndhhMG
	 zxT8GDSsfuAw+wLfYZV1t1eSe3qH7VEhW4NxB7CQ7ggh/H5/XbuwwbfDKOoMl0XzXI
	 vBoYHdGhaSxi652l9+c2cDwka+g0a3mN/DBAjIRA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id D25AC0D5; Fri, 09 Aug 2024 22:52:37 +0800
X-QQ-mid: xmsmtpt1723215157tn0aj36o6
Message-ID: <tencent_156C4BC27437768B67523DE3362496023609@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieHkho6IlFVeYcNXyoLOxFIrielE3TvcH0bb1bkiYTWDO6e4YYvA
	 aVZYuj3/ZpR2cyWtkKVCHnHODPSqea8SBdNTi3WXk76KelXCS+KJR8jvhtYa/ZmuCAMk0gFBqjmI
	 KLS5+bC9ixSVpXSDuKqExNNZAhxD5ZJOZrbFcTzWPu1VKRNsSJEplmInTexfukCcG70dU7Te3f9x
	 btWokNVF7K5CRzd/BfiPqGQT0UQlbEzf+SBjE95XVfqjD1JGWZ21HKHEeeznYinIcwp7MVtfvu/C
	 qx2/jTwPBxZVCUm2r55r+31B45uAgkYDsOAhGZZE53968ZRLrfLedZB6nsm0lg29k58bgs5Y1wnN
	 lWhWGBuHtegAmJWWENrXZB+Kw7C/Fsuej4En+XY3ycxsDtuvTbdbWVUuqDP81Oa5ECAFM4lkpHcS
	 upPwqsWdmYGyxcurzKg6UBMPpRWMNZDEJuhE6PWke5gZbdK6JDsgTA13xRFzAbhkXLPUCMErsMox
	 Btlh3ERUWlEWck5zgdrlDHRRD9yKMAsR8bQIg+yVx/Ylq79il8SWLWo/vKaRivR1iBjWFg4pFHCg
	 Ntl/G7yIVbFb8ra/pbTvBBzWq33CkdNbfplkjDJNMeIZM7OsTUFBQwhVe7/Qij1RKdwh2wgQsBIi
	 hZ1g9NYGxo9LmD0AkNWD44NvMmGCOPfdq5K9BMAKCqQDessG2rzN8YQbZiD6zRbVOwxdgx488pTc
	 11e7qUfQ6d5ilMVCXJJ1KVLf1/8a6Ph9ep/SH+pXxZuJxD7ZoAtZ0fuhyx2ufcz4FUN9FtR+7Jbt
	 lKPBhfPFpR0wFiZmBxBg/6/PtzezQVR9tCA56N1JKNPFjhr9qhGUTPaGPYsq7ALOogb0kRWkEygS
	 EtRgHNhCrrpT9A3Qsypj21ssQhV54iDh7quz8aID7X7sipPSqy3CqiFoIRbZWDH2ptB6Ot30kekn
	 fEjQLQCGez21MZabOlfZh0doUnpOLUbvM9hvmojf8=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Fri,  9 Aug 2024 22:52:38 +0800
X-OQ-MSGID: <20240809145237.1800974-2-eadavis@qq.com>
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
index e0d34e4e9076..0ce9ab0d9a9d 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -219,6 +219,15 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 			retval = filemap_fdatawrite(inode->i_mapping);
 
 		spin_lock(&inode->i_lock);
+		printk("del, ino: %lx, ino sync: %d, %s\n", inode->i_ino, inode->i_state & I_SYNC, __func__);
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
index 348cc90bf9c5..002c3f7f0ba3 100644
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
+	if (security_file_permission(file, MAY_WRITE)) {
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
index 9258d30cffe3..ce6f3c3d04a3 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -522,12 +522,17 @@ int netfs_writepages(struct address_space *mapping,
 	trace_netfs_write(wreq, netfs_write_trace_writeback);
 	netfs_stat(&netfs_n_wh_writepages);
 
+	printk("sync: %d, tb-sync: %d, ino: %lx, %s\n", wreq->inode->i_state & I_SYNC,
+			test_bit(I_SYNC, &wreq->inode->i_state),
+			wreq->inode->i_ino, __func__);
+	wreq->inode->i_state |= I_SYNC;
 	do {
 		_debug("wbiter %lx %llx", folio->index, wreq->start + wreq->submitted);
 
 		/* It appears we don't have to handle cyclic writeback wrapping. */
 		WARN_ON_ONCE(wreq && folio_pos(folio) < wreq->start + wreq->submitted);
 
+		printk("ino: %lx, folio: %p, %s\n", wreq->inode->i_ino, folio, __func__);
 		if (netfs_folio_group(folio) != NETFS_FOLIO_COPY_TO_CACHE &&
 		    unlikely(!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))) {
 			set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
@@ -538,6 +543,7 @@ int netfs_writepages(struct address_space *mapping,
 		if (error < 0)
 			break;
 	} while ((folio = writeback_iter(mapping, wbc, folio, &error)));
+	wreq->inode->i_state &= ~I_SYNC;
 
 	for (int s = 0; s < NR_IO_STREAMS; s++)
 		netfs_issue_write(wreq, &wreq->io_streams[s]);


