Return-Path: <linux-kernel+bounces-299824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5359995DA6B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 03:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCAB1C21739
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20090A947;
	Sat, 24 Aug 2024 01:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PO3XR3jy"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A688BE7
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 01:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724463451; cv=none; b=GFrhjbeMpSRhw6T0Nrp/xqPM5zBPJ8VcHn5jWaaeNQuhuB32bqg+NOVKocfXxMFAnd/ng4ega/MvRGShku3GAzVXbco7YZfUjZg7htlubHtyz0u0WlsAzku75ggeyhTLe4kmDpj4ahPP6ar8jOPKBhA7RQM+X1Du+7QgtVYdf/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724463451; c=relaxed/simple;
	bh=LDC51DMCSwhjyHzH5sQFw2ovKJJDKqaJbvHrdC5EhwM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fpgLiVAprqHBCuIahZoO66mRWm9/XJSDcQMJE4VRuAHxdnDvC13DaUGPehONpbjvE3rAomYZH1v7blJUDh9gbsb6J7zs5T2D/dVroVZB+mvIdawizjYubkwJx/L2cUIvko+yB5JnGVJ9LD5VEdvyHXnEGnDKxV6pigvsHHVQmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=PO3XR3jy; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724463433; bh=mNfhBv4gARmRQJljGOHvDDm1utuzEaCms8vEon2zwKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PO3XR3jyEr+uc0olo6bYdZG3m/4ZHe+5t0jGCpaVe8KNdMjGgI5VyIODBb37DjpUE
	 pmjcMxatHC2+v9Jh52W50cSoE8EdJQr+4AOBNZq+lh5CxihCuWvl8Do7OJGRW2XWLU
	 w1mdDz7yFzb3XNb5S22qSR5ohj2/eDzbkaCO1Z5k=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 94B35417; Sat, 24 Aug 2024 09:37:11 +0800
X-QQ-mid: xmsmtpt1724463431txne2hv45
Message-ID: <tencent_6A26ED06CF0C782A6ECC2CC56E209458EA0A@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+z2/XQPWS9ixD64TI0ciFlWzO8UBlxv4KKTqJJckC01hF5BCswAh
	 HayJZoKFyORHF3gdrLeB3S/YjRUfJvYpPhqXfhG9QzPrr0Mpu41i55J+xa36FIBTf0LDND35+ukU
	 9PdvnNNfOQw4VAdEZ915TZl1s/Q0Exhb7kJyXcRqMIAKmP1ZlPGjfz4odeyxtLXJPQBfeoVhDgrh
	 WdVs5HXN5Ce3qdy6KcvEHuwMQhwCUuwSYHnRgI3Lzp/2fJ0BEbwbZFAx8tV8epJzbhw+3ZJwUfyd
	 Ki+rDqDGTSJMf6YmwyJ5tuQx1eYZdrsdOqrSX1hFA7r3+j+o/gw9VhKPTPsWAdjpoqqK+dNb6sNc
	 Mnl1XjtGTEW4t3Wg2xixXKhJXkyixVbx5BtJAkiOZAKyslXZ07iKTOE1URxJfZTm5ODX0zMmrzza
	 keZZfFXzmtlvrtN9sztBujlKihVvB9aSWl4WLXd7sbezqPqYp4oOuENUEp881AjTJgG3y7xIH0IB
	 PHJyf3A64HAgFC7TEdEa9GFEXEZh+AEU5YR5FDKEBTiEwyRwk52E0vGLv9kXW3etNRDOnZUhlcWp
	 KXlcSp+fO+6yvsZB8kldSV/abNhUslLXtYxGO0ulGmyeE7A04TodKkfXD2bCJrCVkAG72HWmv2JP
	 7IkTEvRW+EXMbIARYgTSDueCCb0PIFQ8PgJ6NtYJoQmaV1lsx4Jm8W1VCo7/laBlIQbV/MjmKIWN
	 76DlkK1HfE0fVXIU3BFFHMIfwjmjDJftrsH3HHogtSqMDKUtMW9IqSIBKvxdJJFtoXzm0VtQ1mHz
	 hGdltn14NFrjRQ9cV0VCXnICo5h7QL+J0AY6XTP8U1k6qFFcVo/OpsSbm+P/4N/sOmGiLiQRerjZ
	 GTJykfweG/oZtswM1bteanjGgh1CutiGXJGhEssio7ZooUYGL4dySIIYF2n6jEHNz/xWRaSRxt
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [jfs?] KASAN: slab-use-after-free Read in dbFreeBits
Date: Sat, 24 Aug 2024 09:37:12 +0800
X-OQ-MSGID: <20240824013711.1192152-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <00000000000012a63d061fccab65@google.com>
References: <00000000000012a63d061fccab65@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sync jfs remount and  jfs ioctrl with s_umount

#syz test: upstream master

diff --git a/fs/jfs/jfs_discard.c b/fs/jfs/jfs_discard.c
index 575cb2ba74fc..5f4b305030ad 100644
--- a/fs/jfs/jfs_discard.c
+++ b/fs/jfs/jfs_discard.c
@@ -65,7 +65,7 @@ void jfs_issue_discard(struct inode *ip, u64 blkno, u64 nblocks)
 int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 {
 	struct inode *ipbmap = JFS_SBI(ip->i_sb)->ipbmap;
-	struct bmap *bmp = JFS_SBI(ip->i_sb)->bmap;
+	struct bmap *bmp;
 	struct super_block *sb = ipbmap->i_sb;
 	int agno, agno_end;
 	u64 start, end, minlen;
@@ -83,10 +83,15 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 	if (minlen == 0)
 		minlen = 1;
 
+	down_read(&sb->s_umount);
+	bmp = JFS_SBI(ip->i_sb)->bmap;
+
 	if (minlen > bmp->db_agsize ||
 	    start >= bmp->db_mapsize ||
-	    range->len < sb->s_blocksize)
+	    range->len < sb->s_blocksize) {
+		up_read(&sb->s_umount);
 		return -EINVAL;
+	}
 
 	if (end >= bmp->db_mapsize)
 		end = bmp->db_mapsize - 1;
@@ -100,6 +105,8 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 		trimmed += dbDiscardAG(ip, agno, minlen);
 		agno++;
 	}
+
+	up_read(&sb->s_umount);
 	range->len = trimmed << sb->s_blocksize_bits;
 
 	return 0;


