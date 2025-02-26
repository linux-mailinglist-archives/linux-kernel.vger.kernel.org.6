Return-Path: <linux-kernel+bounces-534533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2F0A4682C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D96516C314
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E597D2253FC;
	Wed, 26 Feb 2025 17:36:30 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD44224B0B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591390; cv=none; b=GG7JxJRhJ0quufxX8sdc2v4fNTAO49383F/ZrmPBRjB9rOT2yTQNykncXcYjyNozAzNuRr6ixzvat69qOcmmrbj4nRoy+d5ZsbxJG7x1OZouMwhkXjARxdVTD36Fbg9NCM+DIMZ2m9Cj+CZbucCzlD7P9uQfNPTOJ+xoq0XroQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591390; c=relaxed/simple;
	bh=e+i6rV8bnvdaOdZMGG8E7aVduGGJr6r/p7P1kLeU6TA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bK0hfjhTjQutrKXuSYb6bT+Kr1EZGt1nbnS9NKeMPr7ScMr/mTwtvNRLB9m1HJeBqnScpCnQ7CFk1ab5ItTb7eFT6pGUtUsawFI0N9H/6PXpPELut5JcV7N4m/uChXcPg1jJeO9MnyrMUJ1l36H7pHtEmFYpaZ7/VNtppGP0vQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso1501585ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740591388; x=1741196188;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+q4GdZWiHBa/CThULyd8lsKbAHJG3bjf0bUeD0uC9yM=;
        b=Y1J+vAlyM5P5olN0eo8FKlF8EF5NnkIENS8K2OdKkf60tiinksHaDGfKwENzLzgHnk
         ElHnCK0pLi/OPMwa4qyIo6UvWGWQGlr/BvnA1RMc0tlxxLDxvjgt0WfIv+WeJOWcp1gq
         ywUjtcDLR73OsUHCxExxA/xwOWn3Afb6qgawcY0bUZxwJxsuR6xzuqhsrhVxzpM49qY0
         87S/C9UbPDeSInekp9paRzDjOcCewN+JQ6vVelCeYoVvMqa9G3Z35SSFTjrg3QnZGAVA
         5jEIpNb1AjaXBsGdP3lPULVF/+YeQXC7L9frxolvBqLEWHdN6xiYPVTEcuOcss/4JpZI
         J4JA==
X-Forwarded-Encrypted: i=1; AJvYcCXxxPFdulgz/XCxGSWdtFB7T2SGRr/J5bd4pOrXvQgSMysAQhsSg3QXAtH3EsVeWjMlKZ8WTxy7XnoN3y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9wQEX7d4nvOup/2EytoUSMnbOLVljbTX0t08ugkAlPYdDK35
	tBO+32JlUB1ax9zXqCMr2B4Iok1o5PdwJLgZ9K9qin3WNKjXQt13/l+o4ilnMnJuV+vBCi7pqIg
	bJTazB4dA5hQLGzELF3F9hgBI5wEXDBkDaay2hbl+7gShxqaFnxcAs5o=
X-Google-Smtp-Source: AGHT+IH8OscwrueCtU/1Y4FWyajXUpY58peZNa4sv9HhOUyxIaP6pZYNMQLX6O72LReQtrsEHkmAVi5EovNuV4Av1NOnZFXXQI+7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cc:b0:3d3:dcac:909c with SMTP id
 e9e14a558f8ab-3d3dcac942emr5762105ab.18.1740591388070; Wed, 26 Feb 2025
 09:36:28 -0800 (PST)
Date: Wed, 26 Feb 2025 09:36:28 -0800
In-Reply-To: <6776570e.050a0220.3a8527.0036.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bf511c.050a0220.38b081.0263.GAE@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in __kvm_gpc_refresh (3)
From: syzbot <syzbot+cde12433b6c56f55d9ed@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e5d3fd687aac Add linux-next specific files for 20250218
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11e1003f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e945b2fe8e5992f
dashboard link: https://syzkaller.appspot.com/bug?extid=cde12433b6c56f55d9ed
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145af7a4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e966e4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef079ccd2725/disk-e5d3fd68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/99f2123d6831/vmlinux-e5d3fd68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eadfc9520358/bzImage-e5d3fd68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cde12433b6c56f55d9ed@syzkaller.appspotmail.com

kvm_intel: L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5835 at arch/x86/kvm/../../../virt/kvm/pfncache.c:267 __kvm_gpc_refresh+0x11ff/0x1380 virt/kvm/pfncache.c:267
Modules linked in:
CPU: 1 UID: 0 PID: 5835 Comm: syz-executor401 Not tainted 6.14.0-rc3-next-20250218-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:__kvm_gpc_refresh+0x11ff/0x1380 virt/kvm/pfncache.c:267
Code: c6 05 69 55 f0 0e 01 48 c7 c7 89 2e 2b 8e be 24 04 00 00 48 c7 c2 a0 eb 21 8c e8 3c 36 66 00 e9 78 f1 ff ff e8 62 c0 8a 00 90 <0f> 0b 90 41 be ea ff ff ff e9 51 fe ff ff e8 4e c0 8a 00 90 0f 0b
RSP: 0018:ffffc9000406f140 EFLAGS: 00010293
RAX: ffffffff81373e7e RBX: ffffffffffffff01 RCX: ffff888035118000
RDX: 0000000000000000 RSI: ffff888000000000 RDI: ffff887fffffffff
RBP: ffffc9000406f2d0 R08: ffffffff81372d49 R09: 1ffffffff207b48e
R10: dffffc0000000000 R11: fffffbfff207b48f R12: ffff887fffffffff
R13: dffffc0000000000 R14: ffff888000000000 R15: ffffc900030f73f8
FS:  0000555565e72380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005654f4befc30 CR3: 000000007ecca000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvm_gpc_refresh+0xc6/0x110 virt/kvm/pfncache.c:382
 kvm_xen_set_evtchn+0x165/0x230 arch/x86/kvm/xen.c:1933
 kvm_xen_hvm_evtchn_send+0x1fa/0x370 arch/x86/kvm/xen.c:2013
 kvm_arch_vm_ioctl+0xe4d/0x17c0 arch/x86/kvm/x86.c:7262
 kvm_vm_ioctl+0x876/0xd70 virt/kvm/kvm_main.c:5285
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2a11846429
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff5d46cb48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000400000000000 RCX: 00007f2a11846429
RDX: 0000400000000180 RSI: 00000000400caed0 RDI: 0000000000000001
RBP: 00007f2a118b9610 R08: 00007fff5d46cd18 R09: 00007fff5d46cd18
R10: 00007fff5d46cd18 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff5d46cd08 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

