Return-Path: <linux-kernel+bounces-264463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8811493E3A0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 06:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042371F21A1D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 04:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A96C7470;
	Sun, 28 Jul 2024 04:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yXk5urij"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674324A15
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 04:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722142122; cv=none; b=hLlqCxw0IDOVQLUqPX/svhuTK/vREBnfHs16T2QwYAynO1GTz4Z9xJ1QMGHzK9KlJEZBzWl5ur1nEOvw28MNxsnlxpxVKA3VN9BFJdYjMjV/7BzCpaO0QmE6xUCeB0UQ0qCtFvF0/+pouaWTSohb7G6cAm3OLYNgBos6sPXkwI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722142122; c=relaxed/simple;
	bh=lf5QdCR/wRknHse07/64JMfLc2dzGZywJjbsgCLem0o=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=s2fIzFPBhMzPGtDNzxyogKln5PPfbQWwHrN7iP4zsUtSSHQNhBBZH5bx5GM6XU22/oGg8JBGIi3z2tYe63VOF28WMGaijqeAwqxHDBRxRLxPn1eeo3YKQbmEuhYuGeQu4f/FuuBhkGa1rQuDtnhhfBRfjWvSUZy/GS5qiD9cUpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yXk5urij; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722141809; bh=5DD63uWSQglgDIOPUoC5O2eJeY8tKZela+FtFpTl7uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yXk5urijNzpd4WMBysynglXjyQybok6pcnFEkEYDxpmX+MIKL9uXpYRt6IZQRabp2
	 thEV9S68AEa3unk4Ec7sGAmjSTzLshCj3R3QiQY1fWYkAdOgEOCQldk0h+vKG7YirP
	 5UGs3jQbnPxmw94UzU2K173Pk2Eu6TSa+c80+2cw=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id ADB28651; Sun, 28 Jul 2024 12:43:27 +0800
X-QQ-mid: xmsmtpt1722141807teov126qz
Message-ID: <tencent_697761F76E26CD3369437B6979E3ADC45A05@qq.com>
X-QQ-XMAILINFO: ONlpkpkodDvsnF1Nh3DFomQ4ds4W0ND8Un4B/DZRAtuuHA5Ysp0+SV1lDGJysn
	 oV+UX1s6kPTaz5HfPpSdJ4s79hzc5xnQrg1jsOd6xntaimtM3LC0p7UqMuYZvPcvj5BOEb3KOMEO
	 XZ6x/UCukn5GGqzLk1TTctN6enaU5K5q9F49ykQuK6DB2Zv+v5b9Na4gO0ek+bSZvGjZFC7++SbR
	 2mzuiCKEnzYvxhuCWI6uBPhd/Xzgd8rO2pqAdq+cHuNlzysQU4zXXZ6M1jKEo5BKT6hQ2NF/5+T6
	 CCvBnC3tNQVX6VcIj8GcHCVlNq9OJ9CuDP7Qz604Q6xC14XEAX8iY4+zM4TxyySIXYBoB5VHpH6d
	 sH2ASjLcMsGJ2XAnrB+xhO5ugXAap5wqXgowJvyVjlSFMu7uRlduQVT2Xk5GhKa9xxXLJTnQYAYM
	 ZkCIqVtooKzvFg34ysty2r8C5Z0p9brr+e1LkW66GLMUAVov8FNho5UKYVr0mMaKBowN6MzL6le9
	 pUGVF/5R1C1NeOmeigMUTVg6AM5f/zdTbrd1bQXCEMzLAOGIp+0eMcFvSuvSPf/UVt2PC34Azd1+
	 3vTK7KNtsijqj28h6G+t45VRnG/fASpx0z5OdTGv3pg8cyd+RbGCHtrkq5Uy53I7bQFpCrVVORq7
	 s5pCQ0AzsyoAYri3iXzz0mHzZmt0bKfHxHSmnuyFBkAXloihp7SguEGpkcjUaT5a38S3CXmE/ioT
	 Co/VJtvm0UlYXiuIKrlOb0sHZoSurHOeYyLw3pz1IuS8vT917i5nHdqtRNKYg4Hq3iV8toYc1N+j
	 zkLZOh2pxz0nd7gdM7YKQBbmvbZDg0gjIRuaF53OlZxxQz79XeRxbirUnKbr9NB+mfCFzSOF6Tb2
	 Z0f2M6Imv3rSs/xeemB+OUOm2exPRNaZY2y0E6Tn40
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a14d8ac9af3a2a4fd0c8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_folio_end_all_writers
Date: Sun, 28 Jul 2024 12:43:28 +0800
X-OQ-MSGID: <20240728044327.3348445-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000008a971a061dde1f74@google.com>
References: <0000000000008a971a061dde1f74@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in cow_file_range, only ret == 0 means succuess

#syz test: upstream b1bc554e009e

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d62c96f00ff8..8253717cf2fd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -762,7 +762,8 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
 		return ret;
 	}
 
-	extent_clear_unlock_delalloc(inode, offset, end, NULL, &cached,
+	if (ret == 0)
+		extent_clear_unlock_delalloc(inode, offset, end, NULL, &cached,
 				     clear_flags,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
 				     PAGE_END_WRITEBACK);
@@ -1043,8 +1044,16 @@ static void compress_file_range(struct btrfs_work *work)
 		ret = cow_file_range_inline(inode, start, end, total_compressed,
 					    compress_type, folios[0], false);
 	if (ret <= 0) {
-		if (ret < 0)
+		if (ret < 0) {
+			unsigned long clear_flags = EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
+					 EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING | EXTENT_LOCKED;
 			mapping_set_error(mapping, -EIO);
+			extent_clear_unlock_delalloc(inode, start, end, NULL, NULL,
+				     clear_flags,
+				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
+				     PAGE_END_WRITEBACK);
+		}
+	return ret;
 		goto free_pages;
 	}
 
@@ -1361,7 +1370,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		/* lets try to make an inline extent */
 		ret = cow_file_range_inline(inode, start, end, 0,
 					    BTRFS_COMPRESS_NONE, NULL, false);
-		if (ret <= 0) {
+		if (ret == 0) {
 			/*
 			 * We succeeded, return 1 so the caller knows we're done
 			 * with this page and already handled the IO.
@@ -1369,8 +1378,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 * If there was an error then cow_file_range_inline() has
 			 * already done the cleanup.
 			 */
-			if (ret == 0)
-				ret = 1;
+			ret = 1;
 			goto done;
 		}
 	}


