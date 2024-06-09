Return-Path: <linux-kernel+bounces-207301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE10E901547
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 11:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBBF1F21762
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 09:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213FD1CD26;
	Sun,  9 Jun 2024 09:15:41 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0865258
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717924540; cv=none; b=hbgJoZ6DecvRXcQ1rDIwPljfk0IckDYvDaF7iBY8UN9xBdk517idb0YPGLyeaFgyqOre+jrdFUAV9nopYsXqH20xNjziaYIxBAcvhYGeEnBt5h75AoX6fxpz6xkh1LT9eAEiCMrk9DaTSs5SgEnduCvP3clviOyK+uLq2hI9OaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717924540; c=relaxed/simple;
	bh=J89eN+nsv1LOTu+NpSxVQN546rR1ATPCZ4A5JMNE6cY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uNWM9ZG0T9LleIFhRq86lx/4uOf//2IcVD+cNAHl6aWjzZp7LvvOYIF6CMd5wZ/tUbWZzJpsQraojr92LNtCIh8bjV2/ju2GO+nuedcztYTlaq8k8U8Em+EL0FGv1J921r9sJ+ndNqykis4RYkzzImOu4tebPiv+v4wD4Xt+kxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7eb4c4378c0so393294639f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 02:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717924538; x=1718529338;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCsiZCKTneAVXR4L4MJh3qWE+iaVc/isJ8aFs0Tt/3k=;
        b=omtnoLr7HwBuJ4vYH4NWrTPP1WSlMyYkyFz6HOD1Gs7+tFMTRyteojNuUgQesJ1fLv
         OlfoLPfczCsE5VXnXo9rf0b4mW9vyQuvykbziv7eDKsytlW4teFcBBXXITMBKHAr8ePH
         VHeZXJ7YokW/yYaRWwq61pecBY6PPyV69942trs+6RVd/bOhLcUHCwWSd7V38zDTzcbz
         ir69cMqsVatRSF8zsC10ejgOUvFXoX2imKZJeFm6BVXN+I00UPlimdVTcjbLXz1MlI0H
         2hFw7H354by9langzs5jxYmuUeoTeFNdrXZ+sYjZwal55HdmFLiRkMyTimNDJxITBzUV
         daow==
X-Gm-Message-State: AOJu0YxH0QQ3lp97LH6t6pFa9CPI/ctUciuD7zhmOxS70rVdH9shpjWU
	k5Smp/19gTnx1+2YylvnY9p+7gE24ynvkjOIuacQyJXWeFqU4WvS4H/zgC4ivBE2hp6bVy9OlcS
	VeQrTt2S6babpy7lAq7d5hx/9oCfDP5ALJ4wPK4fzxvA3YBnkzjpz1DEvUQ==
X-Google-Smtp-Source: AGHT+IFZpaSGTWaDSRZDGom/0alwnMlljFCINS+7Ou5UYZD0m/PhKImfBR4VA4Jt3S3emW6EYXMYiQ02qu3jc2pvfzJlBVvjnVDH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d17:b0:7eb:7e0c:d172 with SMTP id
 ca18e2360f4ac-7eb7e0cd4fbmr10295339f.3.1717924538373; Sun, 09 Jun 2024
 02:15:38 -0700 (PDT)
Date: Sun, 09 Jun 2024 02:15:38 -0700
In-Reply-To: <0000000000005ad04005ee48897f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc66f6061a71790c@google.com>
Subject: Re: [syzbot] Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_revalidate_dentry
From: syzbot <syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_revalidate_dentry
Author: chao@kernel.org

On 2023/2/10 20:21, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    8c89ecf5c13b kmsan: silence -Wmissing-prototypes warnings
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b53fff480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=91d3152219aa6b45
> dashboard link: https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1409f0b3480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c76993480000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fa537cffb53c/disk-8c89ecf5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5b9d03c04a3e/vmlinux-8c89ecf5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/55c166dec3af/bzImage-8c89ecf5.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/b234e4e5c704/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 771ed66105de

---
  fs/hfs/inode.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 8c34798a0715..744e10b46904 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -200,6 +200,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
  	HFS_I(inode)->flags = 0;
  	HFS_I(inode)->rsrc_inode = NULL;
  	HFS_I(inode)->fs_blocks = 0;
+	HFS_I(inode)->tz_secondswest = sys_tz.tz_minuteswest * 60;
  	if (S_ISDIR(mode)) {
  		inode->i_size = 2;
  		HFS_SB(sb)->folder_count++;
@@ -275,6 +276,8 @@ void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
  	for (count = 0, i = 0; i < 3; i++)
  		count += be16_to_cpu(ext[i].count);
  	HFS_I(inode)->first_blocks = count;
+	HFS_I(inode)->cached_start = 0;
+	HFS_I(inode)->cached_blocks = 0;

  	inode->i_size = HFS_I(inode)->phys_size = log_size;
  	HFS_I(inode)->fs_blocks = (log_size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
-- 



