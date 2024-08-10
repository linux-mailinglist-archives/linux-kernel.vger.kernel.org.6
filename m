Return-Path: <linux-kernel+bounces-281726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DE494DA5E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 05:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A910A283701
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 03:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E96D135A53;
	Sat, 10 Aug 2024 03:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YDDHUkBK"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9DEEB3
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 03:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723261732; cv=none; b=UJgQLy7YbigKOf861PYfjMwsKbfDoE1QMyrZG5ZsjkneiHGF7DHUvv5IM5p2/ebOncELjSeJIJmw4h1tZ5YUtdRX21rrgY5/oJeg/UQjdKZmefgivYTAjD5G9E3ygZd12VFDEDp71ikmIcSSoubLY9rO4JktTxHsHPQ2thF8LDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723261732; c=relaxed/simple;
	bh=d9LFjw1su2R5czW1B6e1X1Jls1HasvrqpiiTSKw1/kg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gQJ5Y6mBVoOLQTzx0xNXKv/6LCBsuARybNh7hv0H9LrC0SLkiUx3mqGqShBZBAi1/Ppo4N2iL6TAPNbUyhHa66DKkbv+Tke1bke2GTIbWse/cwDvO4CalhY6VE18XlKmbsP3eGK7HPdKmHCcx6gwDuRnsKldibz5AQOLIBeUVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YDDHUkBK; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723261723; bh=5TNiJYiaH49VQEtXlARhtbpG4o2M7Wtfz+jq+EA4Wjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YDDHUkBKdjKJ8YjiVWzL6ZelX7UyaXyNKpkxx7z2L5CYhpDDJoWQWIOdn7RTRpvle
	 5bFWnJUOZb17KhEj/+VQ+FsH2IeWZDyzjiEABLx6ae6NaR7kc50SisNbdYqj1VdLeu
	 T6cgs9FdBB6KUllYpVyyqKBYl6heaus8Gwy9b1cA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 91635801; Sat, 10 Aug 2024 11:36:22 +0800
X-QQ-mid: xmsmtpt1723260982tbksuejlu
Message-ID: <tencent_656F489598E922EF0ACE8479566E702EF90A@qq.com>
X-QQ-XMAILINFO: M0PjjqbLT90wjYbeoWL1ronkpG1DFDzBCPJ4X5cCP1t38YhyYj4LdYVgYdNfS7
	 wrMyxok0zOsdPFk7/TCp0pm2I1wa7q89XuTySJ2neApLAW5aWRsCj/WGj37qFtqxXXpS+XRxmpd/
	 GsT4tTJgPe4kMnkZrsx6Ra2InJRf7VRoPHsi24qeaoLD9pyoMk1NiPWhM2y708JRH8Kqx3X/ky4c
	 eJoBqwJeDKFNZD83KZxVI3/YDg853UNMjaLR9k1fBR7wpaOGcKMJin2tjOUrGrKQ8zyRGHzu+fyG
	 lhEw7nZsHphQ91CoUSlZ45cq/iX5JFWuzezLU5Mk3masWf58w19dSsWa1d67lbe4Gwwt2M1zpYx2
	 DPtoB2qPHp+O1WzX90bVoyLBo7dPk8a94/GTrKaocGSP3fEAxE9CKOQhxBkdyhE9y+Mzg4lKhhEk
	 XXhKlsDbF19EQuKbAavEz9TawbL86YGIbjVYSm+84nrLzSlUCr/G1oW8miUd76oyjlMUgU0r+Gam
	 EhnpIPHf069PSfzDN9PU02bbC75QS9EFybZZe+W3J3OpNzUaJOGg0AyeILthYJvH0cwPJaBm/foH
	 oZq+ei15oikPqCp+qlV8NcM9POON4zwyIsUJw7Age5+WApMUus3V/CWzWzV+NKHedJ5BzDbiALPg
	 PuE32fuwc1CeNwPiu7617xsPNh5JDpSdgTNq2Kt9jV0WyOP4ZDGHZys4L4J7DsWE7vNNyq1ErMgQ
	 fQk7tyPT8gMYO5rDfBXLQXhJgDdF8Faxe16MKKm41Fv1Ut5NxZz5R4+xdNDP8T6zSbGQ1QujDdYu
	 ttcfu8n58/c6FcnbJYcdsP/q83ly4xPIFt3wLgCtKOnM/X3vVEh/SdqkjpfTNlBJnRfgebQt41Fl
	 d/aPIkymOXIGkgf40n3OLvisHKpc1J+YehORS/9MuWZr335OI0oKUlOgXmB2edOrhueTYqF3+SA7
	 5699M9pS0=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Date: Sat, 10 Aug 2024 11:36:23 +0800
X-OQ-MSGID: <20240810033622.2033271-2-eadavis@qq.com>
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


