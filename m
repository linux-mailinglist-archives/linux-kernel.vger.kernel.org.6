Return-Path: <linux-kernel+bounces-280962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAB794D16C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4103B1C2074A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26451195FF0;
	Fri,  9 Aug 2024 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zI9QZYAj"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF75195F17
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210673; cv=none; b=Ul/24oYaxdb8pmmP+qn+z1j36xn6kOECBgGescCTFstAaDq7Ic5UcZQnCunThwSqNmOvv2n2LJr2TxnwEKVcXGslonSylgHXCOThYiRWHcdokCAtF7UuMsmvHwAeIRYTGVlmQolWrPAYVIH638oR2sEEfi/y+AXK31YuZgzEn0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210673; c=relaxed/simple;
	bh=PAcLBYgLXxQlseW67WcdzZp7NcTtkO702BLSOkmlbug=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gBAceK14pJ9uRQZNlLKP12U/X7j7Q0wc9lVRrlZdAY3Ab8aL8i+f6Lkl4z/3CN3Uwrt2L+G0FQrQlU5t30LeHlXkrEFdPOQFSsdGRHHozMhNwyEKjUb3QcsRYbeOP1Qt7exGcUmBbh4Vanogz4GHqnobsX2UCopWpMdwna1xeKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zI9QZYAj; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723210362; bh=a7g7MAmVQugUGu4gsVTWl5rzfrncKGvXT/LqNNUDPqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zI9QZYAj4P7PKry4d2RYfsTBjwIMOle06WMG+/R8PoRhYzA5vVxSaBd4b3/VPT0jG
	 7m9gzn284Gvz4YcZqrIdJhPggYv5NJG6JWt40wcx0dHRKshTiiP7azrFCjkzpW61QC
	 lrQGASNnFVQMBxzYP1ZmSUjXA4qfDbzGuYQ1YIGY=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 828184D6; Fri, 09 Aug 2024 21:32:40 +0800
X-QQ-mid: xmsmtpt1723210360tm0qmauxf
Message-ID: <tencent_9A6ECA0CBEA7CC46CD92DA86534992EEDF06@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NoCOkBpGdTuBu8s6uToopfpVUEdzzvsAibmIVWccYkaWbozjnv8m
	 ZfmE/K+Gwy2VoiTv8PokOxuYcJHaHZhMqxE1QE6b9Mkoo+bRiKMnNsHj2ceSGA6+unwvYz7/YWuA
	 0PzkIlMAm/L+P3SYyGogeTHtp6Zufpy0SUtCulzCy6F1GilCk7vt7wxVd4b1iH1+PODV++8QTxcH
	 wvZM5cqRe3WW2LS5rN5gLypkzJ7w/ArheaFeDN2FrtZtIKUa9s5WiKH9W7Cf9HrQOMF2BjNr7ghJ
	 zPYO5EbmHs/1GieuaolT6XbruWsWVSjg8ykfLEVukqHs2gsvuA/6f31ED2I3usGFgYrRV/wYLvaC
	 tu6mSWXOL6WiaS1l0IkjvBK3pj8PLbjJMagbf+6ok+xdnYx+DBNcRai0+ZefzPaD/EmAAB+UDBAf
	 Xs8Mk8zbJEs9kvsNbMDCmeqXquM/C4JxdgAaoyBTeAmxSunw5MovN+zfhncks+TvdBUlPwzYML+C
	 sW2c/vya8LgGiIZaXuG90amEj9XnVyXpDNO527NqyfED8G2n5FIU/lFyENU1grp/NFwW5URX5DGu
	 BfMZCqWURP0G3mDo9YJSH41K0gS6KOFToF95kzjl6dAtMoq1DolInjzWAgSDOeIt9siKyoSuho5w
	 gdWoQpAyR3pMtGqk07nIp11b+ss5ous42we7itJq7Azo1/UfsUxDEcjes9KY9XiuDe0AZH++tqls
	 QsELmCWnBwh4Ml0+2bNljzlHgvdJndM2/+bUTZvawBSn+NPppJxRWKM92jp//T+2zYzFatRX0EkN
	 Vv8c608Lzvhy1lnK6NhjJt/thJRwXTJn2tbHmUU2OXdNTzgwYyh+Gb/h3vblGmpPbuXjyro6+Xk+
	 dlUclD0LRtxj7NEv6Pd5Huy4Vji0l5RrTb8SjcDecGDivp5VPzm4BBrufCou2AwwZQkm18kObR/4
	 SJ/Em7MTLmlY9ohVVj+vUZB31+FIHh6pWzQFU0trA=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Fri,  9 Aug 2024 21:32:40 +0800
X-OQ-MSGID: <20240809133239.1724686-2-eadavis@qq.com>
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


