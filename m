Return-Path: <linux-kernel+bounces-399353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93589BFDD2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3745AB22D58
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06801925A6;
	Thu,  7 Nov 2024 05:47:45 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166A18D64B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 05:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958465; cv=none; b=c0SU66d9hbJWsVTqEKnSxIFDCVV3u3Fja5Th3Oj8MiyVKzsAckdGeybBt0NH3Co1t8aQ623T4qL8d+pw7k22QNUtVjqHtFQD/Q/LyYkqTW6PCCKhZyE+HSmHYpYbEqQZ0ZAFiPmQpAs1zYO/SvA38Zy/6LGsnsb7a7L2GYtpsEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958465; c=relaxed/simple;
	bh=OK01S6hxHKG5yenUZGo2yfIOcDfuvgKRIKlGZWv4Ixw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mEU+1XLOrHQVCVSRotNAxn4t6jAxODjKbTUJPNMJmnzHG7+wZh3yfeK7sjrmWPIUkz2SNvf8bwpZHEkW5zJSHYL/HLrRgxAdeBH9s51ETgjjs/2S00vL2rkPey59NAI8Sy3LPand5sBVCr6W7iIHqLrMpSec4quNfMiq8H2uERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83abb164a4fso69219139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 21:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730958463; x=1731563263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMiWLyJenFUrrN6ZaAKL3lFtJbS9mteu/DkyKFAzTTg=;
        b=HWpHSUT961st13fGvW+rwafzaK8iypTowoMnqR/XsWd8XAucOqWFgfpUo0sJY1Vxa2
         Zb8Vk+/wM/eIlxxj5xn8QxTYIUrNwGWs/1SFoDgV3mN84MiU27vwcbZ0NxerAIZfNvrQ
         4tbyCoI3GwAMjl+FZ7Q1WNWI+LTxdiZe8mHYBe/Rp6q4D5eS6sqiVsu5+QPh9W4k4sVQ
         di4DfvBkMDdUqcX+BhLQ5GNWYyloYFyXLot8wnEeww3W1MONFQHEXePFpkDDRg/f0ljr
         UtB+gqgiGWTft5MYW5S0X9J9I+h4NiEKcabASzfbXeSodyL8NaK2/H1QjAHVHd2yxV4b
         mu5Q==
X-Gm-Message-State: AOJu0YzCQFC1yLNXB86vs+vG02PsMsBUyeLGu62H/lKPAW5DenzUJGG9
	oOC6g9SWfl+K69pWL8bPvkf36iUi1NK0LhegEmEaftcpPmXPZhqO2Ix1h9dRZp2bixCtXfi67bR
	lbi1Z3gocuwpMxlreTGLt62YpLTKBuEye0rxZZoaJhxGl1GJZkGqHIAY=
X-Google-Smtp-Source: AGHT+IGziXa+CX1YEw9Zw27i3Tc+BdhB9DnpgW2d1k6SZiRwki6hapS1lfC8q0ElXFF3XmrUh1UlDAdBtx4vNL7TxTr5fZTJqj5C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a87:b0:3a4:e9b3:22a7 with SMTP id
 e9e14a558f8ab-3a6ecfbe928mr927075ab.0.1730958462842; Wed, 06 Nov 2024
 21:47:42 -0800 (PST)
Date: Wed, 06 Nov 2024 21:47:42 -0800
In-Reply-To: <671fbcd6.050a0220.21b2f.000a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672c547e.050a0220.350062.0289.GAE@google.com>
Subject: Re: [syzbot] Re: kernel BUG in clear_inode()
From: syzbot <syzbot+ac2116e48989e84a2893@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: kernel BUG in clear_inode()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ff7afaeca1a15fbeaa2c4795ee806c0667bd77b2

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index a360b24ed320..debfc1389cb3 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -3029,14 +3029,23 @@ static void duplicateIXtree(struct super_block *sb, s64 blkno,
  *
  * RETURN VALUES:
  *	0	- success
- *	-ENOMEM	- insufficient memory
+ *	-EINVAL	- unexpected inode type
  */
 static int copy_from_dinode(struct dinode * dip, struct inode *ip)
 {
 	struct jfs_inode_info *jfs_ip = JFS_IP(ip);
 	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
+	int fileset = le32_to_cpu(dip->di_fileset);
+
+	switch (fileset) {
+	case AGGR_RESERVED_I: case AGGREGATE_I: case BMAP_I:
+	case LOG_I: case BADBLOCK_I: case FILESYSTEM_I:
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	jfs_ip->fileset = le32_to_cpu(dip->di_fileset);
+	jfs_ip->fileset = fileset;
 	jfs_ip->mode2 = le32_to_cpu(dip->di_mode);
 	jfs_set_inode_flags(ip);
 
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index d68a4e6ac345..845abc598334 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1467,8 +1467,14 @@ static struct dentry *jfs_lookup(struct inode *dip, struct dentry *dentry, unsig
 		ip = ERR_PTR(rc);
 	} else {
 		ip = jfs_iget(dip->i_sb, inum);
-		if (IS_ERR(ip))
-			jfs_err("jfs_lookup: iget failed on inum %d", (uint)inum);
+		if (IS_ERR(ip)) {
+			long err = PTR_ERR(ip);
+
+			jfs_err("%s: iget failed on inum %d with error"
+				" %ld, consider running 'jfs_fsck -f /dev/%s'",
+				__func__, (uint)inum, err, dip->i_sb->s_id);
+			return ERR_PTR(err);
+		}
 	}
 
 	return d_splice_alias(ip, dentry);
-- 
2.47.0


