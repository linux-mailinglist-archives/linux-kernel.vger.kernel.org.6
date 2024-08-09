Return-Path: <linux-kernel+bounces-280798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0E694CF5B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2ED1F22625
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DFA192B89;
	Fri,  9 Aug 2024 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AqQviAJl"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45173176AB9
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202971; cv=none; b=o9L34ZkOedqGh/Cnm/2OHTqLDrdXG72x1bGTXs26UfwWkrf5G8kDD2Ogg31pQjGTWjcC8sw+r4mBN7WFD+27puYN5AaPDz2AQjF4wq0ZgFsGaGkIZEPxY2J3I6dG7PmlanJ05OrG74zVfriFrfGzGATgi6lus0jqdmj++WCO9ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202971; c=relaxed/simple;
	bh=3GkGxuAW3CUt8aH+HH+HsvJNGrWdrhZQM4Jb9l76a78=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ONM4C2xZ2stfhEQmsOoIrkkSlldnlTr5wc+BEZu7+zSBwdrcD9U9liE//lQnRxq88ESruWAVlnZtN0v2H/xXea6vo3YrOueoyeuiMybwhJQpHrNSe0QXIbehiaa+gajZj6clG21K/n5p+rHfTNsyCtTT+Tt9H2KwekEYsokyBFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AqQviAJl; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723202660; bh=s348Imu8O8g9ZtfMO5VPVaAIJLhZbBZyvAJGujt6jrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AqQviAJlJuX0KVZMAQWeIfkYfWV7OYqAvwRjybhMjkOe9i51hJddfyVMY9xwM+lKO
	 lRbWr/g10Lro0awjxfPD/Gg1HBCvnBSc7J+DUe3RBjbePYl5FdcmJ/IapqTHWdxySq
	 tQ2iuqgpfKYnxxGuGaJJlwAtxPFexPZGEKY2lyN0=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 61237C7F; Fri, 09 Aug 2024 19:24:18 +0800
X-QQ-mid: xmsmtpt1723202658tn8ld4d06
Message-ID: <tencent_91612968A3A2A44D176F377926C453710305@qq.com>
X-QQ-XMAILINFO: NDz66ktblfzJ3Z6nsq7zVfpmuoxNL7q1js9FT8xNTh51L2xXpfbepf+EA4JRSv
	 Rua9vLpPqIO9AEtyhDF2dwLk3qDekh+gSlxtBesaNrIY4C9QrdyCEoa0MF+mtWtawHfHPPVm/G9I
	 idHMz+Wksquo98yPdLNkvzBDPEvDBcf91k7lHyDgG8DtmWXENgJ2ADLTZHbjw2+OvPsD3YDfJl2U
	 MZdEKk8yADOGNU0g/mFQEQ8ppGE2JRX+rn3slaoy2c68kjy39XJmAh14h95znD2HRwSQaVfUpAD6
	 2cgPbcesBcysT/u4jdKoEIvt4sctMRTK+8px/shctZ8YPuNcf0CD+3ZXQkFg+DZaZwNiJzc2lBew
	 uRspo8HHlTBTtBD6dpJILvATJe1TkCSbZwP0r94Kji0E4X9iWzmnh+E4NqnAnwJU4l+TeGuRT6wP
	 GTXxuWqMYhixuRtZHg9ZjBGQqcNuXKGwxt1kGcO7Gar/bMFPo6wZ6ztQiaGb0mXtEjLU6HpcpFem
	 4UqT/sBlggMcGevM/fHNue4WuUm3Ab545KSIzVFj9Fdx0V9SCNJ9XE+JhOAIshNOfT2wg8fUKwH6
	 DxxuoUhb3KYHswTeCyRn48712mgFQu3dG6nKTdTGxZLowRPlzR872mmUtSqTLAgUz4fC/L4mFUue
	 FjWFcUwv7Qrk599cQXLGGh34qZsXerUBgAphsDqpZnTxdq+XK37iMbqpAcP3ToOL29t2sNpSDl1Y
	 guAQcIYn+QTVTpG9lQ9YPXhia2NgrhPtvx7De+FaKN3WKZ3ioGfeZHW6zEWHRisoD1CbhAQ32+9d
	 ngC40z7JQXGngy7CVwEbT0NNYdGZ7iaXwFuIJn9wTRbTivj2eG3lP2L3yoeF6oDcCSU7mkRPWiZS
	 2KqitbP6aOj7jIj8lUUARn+zTfBUCBJMTzQK1iYZHsm2JqG0mVa13CO2FX9d0vfxOLee/lJN1A
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Fri,  9 Aug 2024 19:24:17 +0800
X-OQ-MSGID: <20240809112416.1595563-2-eadavis@qq.com>
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
+	    security_file_permission(filp, MAY_WRITE)) {
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
index 9258d30cffe3..bab69d871381 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -528,6 +528,7 @@ int netfs_writepages(struct address_space *mapping,
 		/* It appears we don't have to handle cyclic writeback wrapping. */
 		WARN_ON_ONCE(wreq && folio_pos(folio) < wreq->start + wreq->submitted);
 
+		printk("ino: %lx, folio: %p, %s\n", wret->inode->i_ino, folio, __func__);
 		if (netfs_folio_group(folio) != NETFS_FOLIO_COPY_TO_CACHE &&
 		    unlikely(!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))) {
 			set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);


