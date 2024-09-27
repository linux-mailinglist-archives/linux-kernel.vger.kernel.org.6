Return-Path: <linux-kernel+bounces-342107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36749988AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678741C22F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFA11C2312;
	Fri, 27 Sep 2024 18:59:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E4E15B57C
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463546; cv=none; b=jRZfwzAk1+0NSabXvCos6Omgz1luzX0ko+cpAMpGSBaSgf2OFM3jps2Ch5zq/makaBnfxXqXDx8tzOXD6YjrQfe5w7609hE9H/JjAn2oifgrH6VUTtBXBQxP+5eCqTM3iV7XoLBxeclFGunNrqomaCYjCyYE4Ty0J4HtuFipjeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463546; c=relaxed/simple;
	bh=ky0Qt5OUyJliJOveB+7uwkeqJHQ34/da2gDj0EVdVh8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lF72ZhY5rqNqeJ1pLtpfwcKEtHLsUzHDtA92IAx5FZY6R/NiUn2qxW1z6MjXjYLBkfyi9A5VpF/XU0cLY4P/jAMQJFVXjQJTcUuww1uboHD5rj6t2A89uHZh4tbGl0i8kQ2RlcurfSUwLEwzO44ekewyUYIHWQxJf9Dvm55lbFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cd682f1d2so318560139f.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463544; x=1728068344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dTrhEW4JbtxGsv9/ziMsjoJhu8gsQrCpGygXIu/nBQ=;
        b=gV0W9SL8zfiPkEqR7+oB3R84Ix0Kle1mjZsNoOadizFe00BCUJ0Y03yfV1w+9PpAhh
         SbwKiO3bDm8sl+0Uk9RGUjH4gzVB8ScpGZvBhiNznTFFW4hrWxOe+bq4W5XW1CtOR1Zq
         Wa+CmReqKAdEGzbCF9h5qYuHMRz8UM0qv856Ij9vJQ/JD+Fde4mEYgeLZ/npCmVGZhdE
         UYvWFAIgGBjbnNAZFCBMCxVqiJwmCw9y9vFSm2MWgL6de+KMsjnGJk/HfgZ9Mpp4DMJ6
         STWDK2EGW73TGqpt/sfnrTksUpbomH4q+TwadnrXqGmNCeZfb7i5Gx2X2ofgBpcoeQV0
         S7EA==
X-Forwarded-Encrypted: i=1; AJvYcCWm+5EF3LXyjL0Axcx1lvX41XJc035ugMBLPdZzWkzWAJq5mnTAZSWb0nwUbUvQa4rlEZhgen4fsiJKbo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/RR445vCu2Cm2v1caRpNrIwuqa4qL1wEAMOeZv2UUZ05vWJHO
	KQjI2Jd+54l+Ahd+aex3JW6txFaoXKeS6Q3ZQVu3ngcNMmLdOP7eROcXOx7fA+2xROd5H7BBWkj
	zX/LhAOZbnxn7MRklsu0EOojh5V6bYF0EZMLTrLeaLlrHdm0PPdtuZqY=
X-Google-Smtp-Source: AGHT+IFqa7yF6ECvwnlAxi3NdjJ+CnDzIfbmLXO7BSnSZm+8+qYvYSHemIaLjKJV7fVtke5qcGUD3IsXyAqMg5c4+lgltsFxaoGO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164b:b0:3a0:9ea3:8d79 with SMTP id
 e9e14a558f8ab-3a3451bbd54mr45858575ab.16.1727463544448; Fri, 27 Sep 2024
 11:59:04 -0700 (PDT)
Date: Fri, 27 Sep 2024 11:59:04 -0700
In-Reply-To: <20240927165132.17289-1-rbrasga@uci.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f70078.050a0220.46d20.0024.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in ext4_ioctl
From: syzbot <syzbot+a3c8e9ac9f9d77240afd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	rbrasga@uci.edu, skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com, 
	tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: locking bug in ext4_ioctl

loop0: detected capacity change from 0 to 512
ext4 filesystem being mounted at /root/syzkaller-testdir500386566/syzkaller.6PgxEV/36/bus supports timestamps until 2038-01-19 (0x7fffffff)
------------[ cut here ]------------
Looking for class "&ei->i_data_sem" with key init_once.__key.799, but found a different class "&ei->i_data_sem" with the same key
WARNING: CPU: 1 PID: 5815 at kernel/locking/lockdep.c:939 look_up_lock_class+0xdc/0x170 kernel/locking/lockdep.c:936
Modules linked in:
CPU: 1 UID: 0 PID: 5815 Comm: syz-executor.0 Not tainted 6.11.0-syzkaller-11673-geee280841e1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:look_up_lock_class+0xdc/0x170 kernel/locking/lockdep.c:936
Code: 01 0f 85 8a 00 00 00 c6 05 b3 f8 46 04 01 90 49 8b 16 49 8b 76 18 48 8b 8b b8 00 00 00 48 c7 c7 60 ea ea 8b e8 75 2c bf f5 90 <0f> 0b 90 90 eb 61 90 e8 08 44 18 f9 e8 53 5e de f5 48 c7 c7 a0 e9
RSP: 0018:ffffc900049ef4f0 EFLAGS: 00010046
RAX: 3592bb3d4927ad00 RBX: ffffffff931c0730 RCX: ffff888027c18000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900049ef600 R08: ffffffff8155a9c2 R09: 1ffff1101722519a
R10: dffffc0000000000 R11: ffffed101722519b R12: ffff888077aadbb0
R13: ffff888077aadbb0 R14: ffff888077aadbb0 R15: ffffffff94d9f1c1
FS:  00007f214c1256c0(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000e000 CR3: 0000000027aec000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0x102/0x980 kernel/locking/lockdep.c:1290
 __lock_acquire+0xf0/0x2050 kernel/locking/lockdep.c:5074
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1695
 swap_inode_boot_loader fs/ext4/ioctl.c:432 [inline]
 __ext4_ioctl fs/ext4/ioctl.c:1436 [inline]
 ext4_ioctl+0x4124/0x5590 fs/ext4/ioctl.c:1626
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f214b47dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f214c1250c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f214b5abf80 RCX: 00007f214b47dea9
RDX: 0000000000000000 RSI: 0000000000006611 RDI: 0000000000000004
RBP: 00007f214b4ca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f214b5abf80 R15: 00007fff61b66448
 </TASK>


Tested on:

commit:         eee28084 Merge tag 'mm-hotfixes-stable-2024-09-27-09-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161cde27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e73c530afb43e82
dashboard link: https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17082507980000


