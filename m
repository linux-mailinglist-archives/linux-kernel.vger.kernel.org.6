Return-Path: <linux-kernel+bounces-280834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C966894CFCA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B775282B3A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98094194082;
	Fri,  9 Aug 2024 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QyRzQHWZ"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E451553A2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205227; cv=none; b=L8MMbKbVnnzHlQyxrL7x/ZoL8qy3NEyxYGi3GFcsWK4J3GsNb+vhZlgfz9KLjXUs+GnlTPPnqgQ+6unmg9BS9a55ZblZpJXJvXWRLUbNDc6TkhwKLPOjqePzF25X9tTPtkLUG2K8dv/mf9ncVQ0UhKIBvt2sj1CnJy5f98waBis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205227; c=relaxed/simple;
	bh=yQNr5uu21mbrMW3qH62Z+ChQroa8oSaWtNoVIdl6xPc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Z6SKTZgFgpzGwpKKsvK6SHf5WVt9npDEq79UuKf5iGJ6s6nUT4Z+Oj9wFAW/wLi6Ngt3pt9yEVB1i22p8fw2e8sq28rbdy85izzjgd9FheP16wgf9fAfS5pQVO3fML2cb78ZholIVbE5hkl7ql78gPQC/fs2nm65P67jvsFTR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QyRzQHWZ; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723205215; bh=KhY2EGYfQ1SPKLrsNpbG8vfqYFKj/hHqdfUChkPp0uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QyRzQHWZX+2eHkRogLvF4b1DHiDb/oD4g/s2pWlIISLW0aXEy2Puc9P7MKMhh6UJT
	 5c7VSMA1om4VaPiT6Q4iYRYiYAOyc3+iXBb9P9sQOd3LdoooJv3Qnny2se0BcXxfx4
	 WXKbODiuZwvkBmgKEzecOL/Jy+ZHiCTCtqxy3KyM=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 166822DB; Fri, 09 Aug 2024 20:05:38 +0800
X-QQ-mid: xmsmtpt1723205138tp0xybuq6
Message-ID: <tencent_FABB2C33D59E661B6F4BAB1B3D2538BA2A08@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjNXcpR56+Qf8+XMEkosPjhBX5FLse810VpL0fW7nd+bjYD122sL
	 8ICdg/YbBIgGK5C6oDsBZ+Dg1wvG7iIIWnbNMfvPHRVPXV/7NUqIY7+rsjj0Jn8UKbYyAMZ582OI
	 TQlQ9ciJUYQ84AjlmUpt4GM7yWuF0oRvvMB5jKWLhWxADNA7HaDb87p1eLZPlzqnBm1DfPVA18Rf
	 4Td92HknjYJZ8lJ8HgxPnKhjJnuXoejHFv3CpCPMMyyjxRqjEFbgrpsevZL2KJwYHCgW8NAYpaVi
	 4BbPSR6YnSrB+PQRLo6Im1FSAJ3qtk23SYG1mWzshwRHzOyWRGYHm0vDDsczQmvbjY0cwoLeIvTt
	 /MIV9OffvzEti7WrfXHe7wLoyVvpu4zfQy69Rx5TtF7RZh9yXTOQpkxbWKE82qs1ZP3BeISD69Cw
	 6vAdxHRO7m0P6Mo38Ls8kxd7xbEpO5KNyNfDAOLgqTr3SXQcwgvjkO/cKmyzlSWA4aTwa/tlGuhO
	 qHGT82c+HOH/zkdst7rE6bi35WyIJVDN4B8o+xfIyl9znqFEPPDDftwn5RWDPCIpRtjK751Arr73
	 3Qq3jzxASy+BaO8p9JYpuEzJaWrYOvi/RiqZlykvU4dO81udbCfnj+QccxfexmPOtn4UzcFkInno
	 YSdBnlPjh9F2TW8y3PlorYUy3nMvqM7yo/g6RCb1vNfZgXNXbaLU4OJBnhCZzCfi/ONLzjaAU16h
	 iIuJYD5JyU2IqFXM3sxrnW3oNt5sIfSM94VcOckhHj5CCL9n7VJtF/BiDe0XSY+FmCWvaEoo89Xy
	 ArJ7atRQOhmWPctjYCF51ZtLk24cInBJ0J9BfseR+lkYxz6ZIes1xsqdkxK+RADVJd9taayP4bzn
	 3RT3hAgVxwlRMV7AnyoSaZwGgZUqggC4W7sL6HiX96z/EA1mrLXwZCHNeH1QEL/bQC622k8MFOME
	 kHdInHitfrtvWUgPi5+KtiKR5/rW+KElhZKplSEwniu2f74v4TckonzPDkDhzP
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Fri,  9 Aug 2024 20:05:38 +0800
X-OQ-MSGID: <20240809120537.1636810-2-eadavis@qq.com>
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
 
+		printk("ino: %lx, folio: %p, %s\n", wreq->inode->i_ino, folio, __func__);
 		if (netfs_folio_group(folio) != NETFS_FOLIO_COPY_TO_CACHE &&
 		    unlikely(!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))) {
 			set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);


