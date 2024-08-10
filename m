Return-Path: <linux-kernel+bounces-281663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F2494D99D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 02:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E07B22E56
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8363C208A0;
	Sat, 10 Aug 2024 00:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="v24um/Ny"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB0F4E2
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 00:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723251286; cv=none; b=iJuY30ZClg3JphpZbm3PhWfCGx9csbdFVEUW2IFUtRLKhCQQEsxJydGt6VG+BN/eQK3NsdUu2XnIujT0ZiU22WGGghYgHLwsowrJR8Px95+dKcju9Wfy3wLCucNSKRHBG2C9VtJDHYaRwn/LiWrnuY9y57fTkQDKhgkadHF6LYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723251286; c=relaxed/simple;
	bh=7cRJrl5wQuohSTzCb8fPAI4AGpDp+QggM1KXzuN5B64=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=WAYN1ustyJ0hVhtkgcKjHWE+bOgKO1wxLK4P3pvLyuHizmVfIhdnjT9J4RnSYhAaMFYMtEaN22CeGcIDYzZonvsg+114x7FVmQ0eJ1122o9H42V2/Jmyq3jlK6z+LfXVhw/R3lFMOVvjqYvXkxiSw0m02Kp4HozwkCkROghCntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=v24um/Ny; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723251281; bh=r/WsXibmHtWs+etp3lJCFZEn7OjmYy/BtWGgvMU2x+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=v24um/NyfMUCUAjGRab1wov2P7AIXC1dMVjD12C2W9KDtwlCSKNOyzEEA1kWE8xI9
	 IDbCZ4zCE7kbVhJMEyGGRrWwpK7i9LZwaYiI6UWePtxp46+OXdSb4eXW40R/OiP123
	 9Bs+qZ5itWPuqW742HiKTvDG5QFQ3+KsR3xljCT4=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id DA711025; Sat, 10 Aug 2024 08:54:39 +0800
X-QQ-mid: xmsmtpt1723251279tk0ux6l0g
Message-ID: <tencent_234974A3B3644C9769777466C1F365636505@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J28UJmJ5Eq3ofD6J339VhREomeSY7etbky76f48q6/WmNZv36v3W
	 lEXR6YFoLcP4bLZtre0tgUWsT/z+cUXHDvqO8nCdSjjOQhx3aIQkb8Ak9Q54RLIs266Ik4ibDzH8
	 VrncjUX9OZmT+9x2KxpXyDS6zNAhl768dKqEgdSo5m6NGmp3zu+CbaELNvXgCYRcdGFC5S2xOpb7
	 um51Iv1tVvPqCv0cAg8HTDyuBcNSb3vm28ZCyhfHBkrqo7hpGsO2gMpC+ktldkdLsQ/pcD5aaOJV
	 9tKNxRy+SdXKSKYq4WUgmQaaxm49pQyWYny+oITC3njwinP9E+qDEURNE46RdMzxhwuR/F228vPg
	 PuMnXdX2MCgipCsJEuVUvP6LWMrhpz0gMdVHFqj7LJhRsIg0qsk1NM4EeuSHFoRsodwW1dun1bll
	 ZO8qWUzSGNKWkuqZrAe+9my7ewKmMcO3VvoDCcRsMtkDl8b0U6rroNB7KxGhH73XqgWjYNK0fgPq
	 sQ7c0ikjHborL7IJIS41/bPMt4s7R/glyHvrCwGH7FborHnq820hdwdyCifssW+Ah6ZxAkagmgkL
	 Hks7XJE+UXpHk9rli31CD+36qbJEfcduv6jVib1iKHQef5UpKl2f02bXDW89T/OxX3gzpZVEFqgs
	 IvcYH7KVRQN47GaiopI9iLkeAxXFwGDH4AY7Wo2aI3oiApF1Vp5xnfEnlakgEU8dNFxAO3NRmELq
	 s+SoYjoZICbFWNTA+pYHP29b5KMdolc2h21YrkdFuTVx+dpsRHI4eDmCrmDFGduc2pvjrs+EH9IS
	 CRG5OZcE5G7B8MiQHZamHv9tlwGtfvB2d3NuFLm1/RYvq3yAd8plaoF+fic5qoAGyD1BR2du83fl
	 qdum6cDCCjXzTSCw6TH9ExVrTLvinZSWk6HU+la3//HDYOA5WQGG79squ1k2FyQQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Sat, 10 Aug 2024 08:54:39 +0800
X-OQ-MSGID: <20240810005438.1870896-2-eadavis@qq.com>
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
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 9258d30cffe3..60472069907e 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -502,6 +502,7 @@ int netfs_writepages(struct address_space *mapping,
 	struct netfs_io_request *wreq = NULL;
 	struct folio *folio;
 	int error = 0;
+	static DEFINE_MUTEX(wlock);
 
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		mutex_lock(&ictx->wb_lock);
@@ -522,12 +523,18 @@ int netfs_writepages(struct address_space *mapping,
 	trace_netfs_write(wreq, netfs_write_trace_writeback);
 	netfs_stat(&netfs_n_wh_writepages);
 
+	printk("sync: %d, tb-sync: %d, ino: %lx, %s\n", wreq->inode->i_state & I_SYNC,
+			test_bit(I_SYNC, &wreq->inode->i_state),
+			wreq->inode->i_ino, __func__);
+	mutex_lock(&wlock);
+	wreq->inode->i_state |= I_SYNC;
 	do {
 		_debug("wbiter %lx %llx", folio->index, wreq->start + wreq->submitted);
 
 		/* It appears we don't have to handle cyclic writeback wrapping. */
 		WARN_ON_ONCE(wreq && folio_pos(folio) < wreq->start + wreq->submitted);
 
+		printk("ino: %lx, folio: %p, %s\n", wreq->inode->i_ino, folio, __func__);
 		if (netfs_folio_group(folio) != NETFS_FOLIO_COPY_TO_CACHE &&
 		    unlikely(!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))) {
 			set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
@@ -538,6 +545,8 @@ int netfs_writepages(struct address_space *mapping,
 		if (error < 0)
 			break;
 	} while ((folio = writeback_iter(mapping, wbc, folio, &error)));
+	wreq->inode->i_state &= ~I_SYNC;
+	mutex_unlock(&wlock);
 
 	for (int s = 0; s < NR_IO_STREAMS; s++)
 		netfs_issue_write(wreq, &wreq->io_streams[s]);


