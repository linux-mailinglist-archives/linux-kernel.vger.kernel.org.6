Return-Path: <linux-kernel+bounces-365080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EB399DD3F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4152E1F23181
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1336172BD5;
	Tue, 15 Oct 2024 04:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gf4uaJZO"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBEB4428
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 04:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728967822; cv=none; b=Do2PGVHG29HD3ShP61VDO9SzaX90++5TcwYVHy8WiA7ipFKX0tt3Qzm971/V/82quc9R9THO2iwt8TzrpT6QHXhXRv943OcdgdXi9TYqCydxkLc4UYeXMUnA9lbwOKCq+vFtpcXNv6z2BpNSB0RT2jRmdOe4Tyc1RiQreeNiPKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728967822; c=relaxed/simple;
	bh=k6Kv3lKI80jc4q0HshBLsWjzwBMvbttBxLCVbkm6Tok=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=eaA3mlxlzWDqJ9X5Fjaz2947LPBYpXIfd0GBF8/wZyREc8kbRF/G9wEOiDcOPKjndK+VufN3y9KSIow93UmgkeiFLbhWaiBYZEvVkPxx8joCXEaQwczbjJ+UqCr6pG9q5DQeXC7XntcZbr7VSrgcv1gIF1XrexHLctaV96RTdM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gf4uaJZO; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728967812; bh=YHRkU0CiN5ncRK2HdxA/z4C8I36aZYKlBbJ6eiOEQKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gf4uaJZO8VFtokNnHlaHbmrT+tKn5hB3DwiH/8NswSsQOSbkEKkmm96GYQc+E4u+N
	 CRIeYwCmipoeCasGfZtfa+O85MUqo6hrEfIWxnCCtj8mBkZPK4Wa+/3LMCyxxdsJME
	 odIjCpWWH2s0kazo4KXHII4n3lmhjocqzQe3JVBk=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id C8518C73; Tue, 15 Oct 2024 12:50:05 +0800
X-QQ-mid: xmsmtpt1728967805tzhy9bh7f
Message-ID: <tencent_7C86DFB364837BA979A3B0A44CF768577205@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIew+Fm4chwnmYQ763zfiiYi98bnmAItmG6QXG0FygBfZpgHxuZUr
	 UQKy/IGB3wkihFzF0abOdwTctwgf2hpOK/N8solYpTQRMWufteIpwa465+7jNu+Grww4zfc4jcmZ
	 QwYU48fEo6TPh2S4xDtLp1P5suqcxODXqQjp/30ATgpBWW5BEUy80r3k/3S+2tbHcTAQIapD+Nbo
	 kzUVd1q6dSqZqYh3Zjgha7JjJnj9Fl8PYRvOOlBVpW6eDlMjL7ZZRs42bBmJjb7edILhHQnj0CYh
	 xo/hjWpVLlRz8UTehamEid9fIUXDACBz9KkWagRK1HhkPzgYe5I52tfCYsfedRkVacXdq7OdKR4L
	 R3vlp0uV6oYq/owh0raJ+LGn7hXcrDYwVOcQ+p1Qy01CDG9ApBeIOTXfOFmptE/lUIcp9zRjgLB3
	 z6hGF2HOaVFKkmHd7oae/TZQJAenMZbh5pn/qWMlCi0tceLYHzcl1sRrHiTT/4zsAISK7jl8iOjH
	 qknuX1v1ALWWkOGAS59KvWqpckIEW2SoHN9uGcQqm6g18ISh6dM11kJACT7SYyp5tIsNfHCmUdQU
	 oTzaAm3y66JZYK+EpnTdRtln5IRvlWeJWtGHSr8OxGznm6nu9avNEWppHrP6J6p4KMUsHjsE/rKO
	 J1EEibNBkVs62rzJP5ntQ5FkhEsJgZwHVu8PLsfmAnbK2FP0+SnvxhCB9AWTY9S8hOiaWlQOijS1
	 L4y/tErBFSlbEojcxNQGg4+Dfv2OYZ4+34ltWHKhn6UlpoGbBYcyyjFI/p4tV0L6344lOO4Lans0
	 CvEwCYfsKCDmAIStnfifZQWU6Q3nUJaFPz2uTzi+Rj+wsG+9oT/akUv+eGTnq9Qz1/JccU8Wi6dr
	 20G8kdBzzpV3+nbePqacO2giXvTo86GufUCSXMJ8OPoaGNp0xBSyp5Sqd850Nz7xDcCCEnrF2h
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: guohui.study@gmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	lizhi.xu@windriver.com,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com,
	willy@infradead.org
Subject: [PATCH] jfs: Fix null-ptr-deref in write_special_inodes
Date: Tue, 15 Oct 2024 12:50:05 +0800
X-OQ-MSGID: <20241015045004.3908269-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CAHOo4gKf2mjPX8oAxCBUc74=+OToMdu6pe6iALGCOmXjToFaKw@mail.gmail.com>
References: <CAHOo4gKf2mjPX8oAxCBUc74=+OToMdu6pe6iALGCOmXjToFaKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a race condition when accessing ipimap and ipbmap.

        CPU1                              CPU2
	====                              ====
	jfs_umount
	sbi->ipimap = NULL;               lmLogSync
	sbi->ipbmap = NULL;               write_special_inodes
	lmLogClose			  writer(sbi->ipbmap->i_mapping);
					  writer(sbi->ipimap->i_mapping);

The jfs umount and lmLogSync compete to access ipimap and ipbmap, resulting in
null pointer access to ipimap and ipbmap when executing write_special_inodes.

We can fix it by first closing the log in jfs umount, and then releasing
ipimap/ipbmap.

Reported-by: Hui Guo<guohui.study@gmail.com>
Link: https://lore.kernel.org/all/CAHOo4gKf2mjPX8oAxCBUc74=+OToMdu6pe6iALGCOmXjToFaKw@mail.gmail.com/
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/jfs/jfs_umount.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/jfs/jfs_umount.c b/fs/jfs/jfs_umount.c
index 8ec43f53f686..c5fda516ca85 100644
--- a/fs/jfs/jfs_umount.c
+++ b/fs/jfs/jfs_umount.c
@@ -42,7 +42,7 @@ int jfs_umount(struct super_block *sb)
 	struct inode *ipaimap = sbi->ipaimap;
 	struct inode *ipaimap2 = sbi->ipaimap2;
 	struct jfs_log *log;
-	int rc = 0;
+	int rc = 0, sb_update = 0;
 
 	jfs_info("UnMount JFS: sb:0x%p", sb);
 
@@ -51,11 +51,19 @@ int jfs_umount(struct super_block *sb)
 	 *
 	 * if mounted read-write and log based recovery was enabled
 	 */
-	if ((log = sbi->log))
+	if ((log = sbi->log)) {
 		/*
 		 * Wait for outstanding transactions to be written to log:
 		 */
 		jfs_flush_journal(log, 2);
+		/*
+		 * close log:
+		 *
+		 * remove file system from log active file system list.
+		 */
+		rc = lmLogClose(sb);
+		sb_update = 1;
+	}
 
 	/*
 	 * close fileset inode allocation map (aka fileset inode)
@@ -103,15 +111,8 @@ int jfs_umount(struct super_block *sb)
 	 * consistent state) and log superblock active file system
 	 * list (to signify skip logredo()).
 	 */
-	if (log) {		/* log = NULL if read-only mount */
+	if (sb_update) {		/* log = NULL if read-only mount */
 		updateSuper(sb, FM_CLEAN);
-
-		/*
-		 * close log:
-		 *
-		 * remove file system from log active file system list.
-		 */
-		rc = lmLogClose(sb);
 	}
 	jfs_info("UnMount JFS Complete: rc = %d", rc);
 	return rc;
-- 
2.43.0


