Return-Path: <linux-kernel+bounces-281753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8018394DACB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 07:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28E11C2112D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 05:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B441311B5;
	Sat, 10 Aug 2024 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tC921Vkr"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02E21CD37
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723266077; cv=none; b=nBByRJl+pk8K+3Xz/bM3Hm3ouCHHTZ+3HhTm0A+z3lzUprY5IBCf1Ac5Uvtsgd1HQYbmXUMuu5/TyS7jdF6sa2UgPOzJY9aWjkfvNH2bDKDi1ukA6LB+jfdxyv1qn7wc0AggpFP3RXc1gqePlqSp3MOmbBQH7KaFfbyJ0gzugLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723266077; c=relaxed/simple;
	bh=W/x1kTg/W03lX3XO7DXybywD1PVtoShkqxLDPJudPBA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kaTPJimo8blX0uVqx96JR4b+2ejDja34YVHqA8KyU8YngLjK4iYJyAVAA7nyxIQvPS8kdxJep/LLyd6tekOgAHfJYP63QaZzErAsY7bOucGeaEUPBQAQflLly7JBJGDBMdt/PNmaXOeFk59E/RxY1scdJqATBtoKqBWaUs9Dmpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tC921Vkr; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723266067; bh=rESwxL2foN+gTOOrJzXsPD28kV2jL54G1Ier0aU7sc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tC921VkrDpuKg4/7IEssDxgV4LyKcM9LEJfnZRDoZ0caaRr6ENdJ+NK3DAyCF7D+T
	 rP38ShzXrr0Zq7OVSfrD47rnqO+jb4luDlnmw+ywhsKee971F2s5TNRJnqL+rJuc7G
	 Ts2drLM4dcLjj53i/oaMjLIqWq/N0BuXeQrDCq3Y=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id DC115C90; Sat, 10 Aug 2024 12:55:01 +0800
X-QQ-mid: xmsmtpt1723265701t7sj5q2nz
Message-ID: <tencent_741B7B2507BA67BBF633729E061B244B3808@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+z/lyYWoIZvGMCSomaLI5hgGxpTYumVva/VhSBC149c/IT4fKygn
	 GBi9bi3PuvFWq+vu98JOFgmi5Y2kSnuvoJbq5yd2aSCEDa25KiIqrHbPBf/9ZdmTJrhlmWzaWOw7
	 3QHvOIdA9gAKYukNv7TvybjT4p2yLX7dH6u6k+u/ZQ6A1JjrhM7Ycxw3XPuFrSQmioHOz5/0Y2Ht
	 te7Ev1Cg3LzmJFDrjLe+AMI1SXucsmAJSjVG+1uGeWr1Z6WAVMiX3dstLuheLG52ai5IorVf6G5e
	 SkM54eNOGz5Wp40X6ER4lNHoeIyrjz7tEKQjLoVxr4dHdVrQ/andpO3gXF/kgZqxOaaDdkqbjlCI
	 2NKB83z/gNKLjVr51AptWF3mSbOKbO+znPpgLyhpgrmE6t6DSdoO1kQVmAZXma2DwGK8Ojwc7OOT
	 ihheXe4FpoOxppoSdZFnN0NrjXO4j5zncAmiD/vl8bT6tgfph5UiSA078X6lVxwC9V1lXxPywFlN
	 HspCPSItTm8YLExWJYOYbr+X+mIHBBsXoBtTmALInI0IdcJNcyCSPvKkioZV3eJrV8BmgYQVOV+q
	 BJ2IH2/INha7bJF2j/GiITr8kP0oDJlHw6IKDMrWV/FMLt/7BimElRQ4dwxZjv5jmbW5IZJu5QL2
	 UnjRc8iwPa2TgeBGk4q2e1LpYDWNZgke6j2JDJdAoLi/CTQlftW9S2yGU0Dh2InP0O7ygZphA3ch
	 mm/DsKcB0XdEyDsBl2T0Wo5giz64eUnPGngWcCnXKVvR9HzUJAE6tEQhTRi88kzpGeLOWkUmYRmM
	 mC58ahkr3/4FqLpuiYmUMxAXAjmx8uE+nv6zngRbcXg21YitkOHMM1cwavrm4jeI0WJA5HtZP/Y3
	 v2Kd/FOhOaV5vmTntexAWvw/WB8u9/GCLiJXRgAvDY1i25xDg7bHPYsus9e/Ay/OTN9Ge51pksKs
	 2AjJpWnAKFCkMNCUSttDN9BZoZ4Xum8Z8pbj35v7w=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Sat, 10 Aug 2024 12:55:01 +0800
X-OQ-MSGID: <20240810045500.2108796-2-eadavis@qq.com>
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
index 348cc90bf9c5..ed319921a898 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
+#include <linux/security.h>
 
 #include "v9fs.h"
 #include "v9fs_vfs.h"
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


