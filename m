Return-Path: <linux-kernel+bounces-417929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509139D5AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FFD28504F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFF918595E;
	Fri, 22 Nov 2024 08:17:26 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E01632C6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732263445; cv=none; b=n9BjRx9e3neFdXEewXC0QqDFhueHSW4XR4kagWwlXp6AWWIECug+rNHL1aMYcnkICKiRvCrBY5wXWJbvm3n1rVvM7yfXFyuXYVT3QQQxcrTtJ1e/4uyaA7GyBO3TSbXiPWvnchXQCtHlED6h4IJyuPEkJlllL8YUMd+3k67WVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732263445; c=relaxed/simple;
	bh=3vFOxaKedha/59jJlm3ITFbYh7rb6koNnLB0+YGjGSM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kgbgqtNx2uAQdr8ZcfecQ89EmsQHjnUPBzkxVFBnSp7gaG2d2F+h6TClyIzF9k09FG9PgiNKyTZP4Uv/hdgIV9jZpFoUmXub5wm1aKDYsYr2+bq1GVlXvdDWq6eeQC5zpmqK4taJl8/yo7rh3YGwLeeEgRAnf7pH9hWcuNa+bZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ab1b39ab1so212875539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732263443; x=1732868243;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0MRpk5xv2WCyhfmudvJroTTAQoMh7C7HH7zoi1D7/40=;
        b=hHLwwDpwbjtv3XGZiVa+kyPQTuK+Wj5wxy3jg8phRc3o4/l5D+v6swUaEBPK0Pi0ub
         GrDDvSaib+RK/N3AyEInEhgOG4/YMPSgm9L0YDfzLNaOj0DZBhXq3erOOVYIoPwPcVhP
         vRBsWEWePHadOnjZEe+Wdm2xwUSF2Eg62mQGULtmMVkswIIjfmWy5K6KScuJnDIyqMiS
         v6vCvk6uDLXPfhf709Nx53CSy+8vjXvNRKtL6aBIYUrQkctHgTza80jSkZZirQEDKuFW
         /exD2+U8+7BGeNTqNDvmmvgDhThsIXtS5GU+DTEsgNy7WR4s5lJcRBzMx1dof/izDzMU
         rAgg==
X-Forwarded-Encrypted: i=1; AJvYcCVqfL8a2AIEGrmH5hL3Hg+3MKdD2crJrtOl+4BzRJ7Fk3hrVqvhXgVhCepWBjUSn0ivUBLh7J7C5nWFh50=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiBPU8aTILrCmzPHGfaqoZ7aco8n5IazmHjVRH6hwdqFBR7HrC
	Hr09aaRy9EcrdkOy2/A7yjPSFJ4vizbjaCWnUMWBebqhrG1+d4nNrXiWQmaBDs/b7NIxg1zGkZO
	+PM0/mhpBz2r+n+SyvY8fEPH+txCqHmYqe/yOqXlUiiLvHaYgGK1JfnU=
X-Google-Smtp-Source: AGHT+IFyqxSDQPGumN/PWYl6igiz/SuS4VlxJER0NndOrSv5TpQoqo7daanfWoyQnCf/EEh56guJRdmlD4U0ynEIZsfF2j89dWgK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cd:b0:3a7:81a4:a558 with SMTP id
 e9e14a558f8ab-3a79ab7e7b6mr29532525ab.0.1732263443338; Fri, 22 Nov 2024
 00:17:23 -0800 (PST)
Date: Fri, 22 Nov 2024 00:17:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67403e13.050a0220.3c9d61.018d.GAE@google.com>
Subject: [syzbot] [iommu?] WARNING in iommufd_device_unbind
From: syzbot <syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c6d64479d609 Merge tag 'pull-statx' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129a0ae8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3b3b2f3eaae51f9
dashboard link: https://syzkaller.appspot.com/bug?extid=c92878e123785b1fa2db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17da1bf7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d212f6bb1af/disk-c6d64479.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21a14342211b/vmlinux-c6d64479.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f96c41f3e4a6/bzImage-c6d64479.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com

iommufd: Time out waiting for iommufd object to become free
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6050 at drivers/iommu/iommufd/iommufd_private.h:208 iommufd_object_destroy_user drivers/iommu/iommufd/iommufd_private.h:208 [inline]
WARNING: CPU: 1 PID: 6050 at drivers/iommu/iommufd/iommufd_private.h:208 iommufd_device_unbind+0x81/0xa0 drivers/iommu/iommufd/device.c:280
Modules linked in:
CPU: 1 UID: 0 PID: 6050 Comm: syz.3.18 Not tainted 6.12.0-syzkaller-00239-gc6d64479d609 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:iommufd_object_destroy_user drivers/iommu/iommufd/iommufd_private.h:208 [inline]
RIP: 0010:iommufd_device_unbind+0x81/0xa0 drivers/iommu/iommufd/device.c:280
Code: 00 e8 83 76 01 00 89 c3 31 ff 89 c6 e8 b8 85 43 fc 85 db 75 0f e8 6f 81 43 fc 5b 41 5e 41 5f c3 cc cc cc cc e8 60 81 43 fc 90 <0f> 0b 90 eb eb 89 f9 80 e1 07 80 c1 03 38 c1 7c b8 e8 d9 44 aa fc
RSP: 0018:ffffc90003017c38 EFLAGS: 00010293
RAX: ffffffff85516f50 RBX: 00000000fffffff0 RCX: ffff88802c693c00
RDX: 0000000000000000 RSI: 00000000fffffff0 RDI: 0000000000000000
RBP: ffffc90003017d70 R08: ffffffff85516f38 R09: 1ffff11005b9b140
R10: dffffc0000000000 R11: ffffed1005b9b141 R12: ffff888034149718
R13: ffff888034149700 R14: ffff888028d2c400 R15: dffffc0000000000
FS:  00007f2573c136c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c001633e80 CR3: 0000000032fda000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iommufd_selftest_destroy+0x95/0xe0 drivers/iommu/iommufd/selftest.c:1439
 iommufd_object_remove+0x3b6/0x530 drivers/iommu/iommufd/main.c:211
 iommufd_fops_ioctl+0x4d6/0x5a0 drivers/iommu/iommufd/main.c:424
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2572d7e759
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2573c13038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2572f36058 RCX: 00007f2572d7e759
RDX: 0000000020000400 RSI: 0000000000003b80 RDI: 0000000000000003
RBP: 00007f2572df175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f2572f36058 R15: 00007ffefd725ea8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

