Return-Path: <linux-kernel+bounces-303988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3D3961813
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C7A284B03
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7791D2F7A;
	Tue, 27 Aug 2024 19:38:24 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6AF148FE5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724787503; cv=none; b=u4EJfosYia2G3wq4v8Q5Mwx2o4N+VKMp0eSi1adZ6hzNlK/M0ZAgssrNVDYPxmc9l3X43SfhXgK5vnf1o7yPfSrN7L5Xep4tossxN9fGwN+3894RYd5UFOWE+STN/u7rjrVFbdqJ/ncPqTz+na9wkE/5z4+1Zw+cJesEJLYswbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724787503; c=relaxed/simple;
	bh=hRRen8hsiVzH79Hx4t7DJqiOMmbgkBr9ZFYG4askpvI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Rb2fbBxmO4+FSNIe1jmoQg67p8GNb5s3bjQ/jOunufiSeROXIGclSQOEb2p6qysKgcJPfuac5aXig7cXsmvVCfLImKb0UUoMx0y/8iK6U5KckG9PACfQoaNNIwxQEzt4n22goVQWp/3QuDMxR4ZKoyi8FZDgv5Y/QuLMaTYznvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f8c780fe7so640240839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724787501; x=1725392301;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MoGAwTTThF50UwTxZaULb2S+J/pUejSXceVu5nWlS8=;
        b=qYn0k6N7eCRfb5XWCJpFGDA9lWtfXlOPXOb1e8Z8/tSlxVD1FoOWzmGTCBkBaSfAev
         nOLfzZhMUtZMF+jv27nY4Rg8h7OU97BNM+CbvBDi4DK+pTdToZgPRqXWKQf8Cgo53mz1
         6KBJEmNN3Ssv8RxOODTjam5uwj9FCE4Pq1yaStYWnSxpjgwpZWexrUuSF76Fsi0PYLp9
         Fcg8UBomXSX+0rwilgzuAOxDHPRupot28qSxE3t70JjOsbQBxo6RB1pMyHbUlMSy5zH5
         RgkznMtcrV3IEUA9JOi0C+eRZYMRWLx0A/PEdZuRe7MAjRzj8HywglJzS203QOXtnHse
         8DXg==
X-Forwarded-Encrypted: i=1; AJvYcCW201IjrsvLtbQjz+1ir4AgairlX6kXwcwdkLC060AtcsyQ7587cCxaHGHXg3jqQBfz7HuJznXpXXM72QI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8fz4IymThcy87Y+JRpf9GLMZBG8ONq0UxhTMnOnMmBp0xOyin
	cc5IxGaleZ9VOIa0e37TrtVFltLEWM7IjkTQRLU0fWEAu3WJItZRgxx5QLcyvqi20JLge1ZoiIq
	+pdDkLTceC2Cp2Q++Aw/Z6wB9tLSMviSYMPr9E4F4/+RHqNicu+rTOdU=
X-Google-Smtp-Source: AGHT+IH3q1btqb2/DfGLJTLZYk1YF4oCkopYTNP85guSTDApRnGuq2Ilw3IN/3ThTOJ+EF7G4V0MKCYt7ApdFvntODX8Y/tcNaM4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3404:b0:81f:8d10:6f00 with SMTP id
 ca18e2360f4ac-8278735fbffmr57654239f.2.1724787501285; Tue, 27 Aug 2024
 12:38:21 -0700 (PDT)
Date: Tue, 27 Aug 2024 12:38:21 -0700
In-Reply-To: <ifjwqijv5lpttrcpgckfvmc6koxzsqpghgfyb4umtsrpwshsgq@fxit3gumqhld>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053d3e60620af625f@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in mmap_region
From: syzbot <syzbot+3bca0d9eb36e75bc36ed@syzkaller.appspotmail.com>
To: liam.howlett@oracle.com
Cc: akpm@linux-foundation.org, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

> * syzbot <syzbot+3bca0d9eb36e75bc36ed@syzkaller.appspotmail.com> [240827 13:28]:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    94ede2a3e913 profiling: remove stale percpu flip buffer va..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=122f6d9d980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=8b0cca2f3880513d
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3bca0d9eb36e75bc36ed
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/e10dde6d5041/disk-94ede2a3.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/3bda8d01811d/vmlinux-94ede2a3.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/653dc61d9ae6/bzImage-94ede2a3.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+3bca0d9eb36e75bc36ed@syzkaller.appspotmail.com
>> 
>> kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
>> BUG: unable to handle page fault for address: ffffea000169a5c0
>> #PF: supervisor instruction fetch in kernel mode
>> #PF: error_code(0x0011) - permissions violation
>> PGD 13fff7067 P4D 13fff7067 PUD 13fff6067 PMD 800000013d4001e3 
>> Oops: Oops: 0011 [#1] PREEMPT SMP KASAN NOPTI
>> CPU: 0 UID: 0 PID: 6910 Comm: syz.0.357 Not tainted 6.11.0-rc1-syzkaller-00043-g94ede2a3e913 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
>> RIP: 0010:0xffffea000169a5c0
>> Code: ad de 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 24 00 24 00 00 00 00 00 ff ff ff fd 01 00 00 00 01 e8 e4 2c 80 88 ff ff <00> 00 00 00 00 f0 ff 00 00 00 00 00 00 00 00 00 22 01 00 00 00 00
>> RSP: 0018:ffffc90002e0f8f8 EFLAGS: 00010286
>> RAX: 1ffff1100be13426 RBX: ffff88805f09a130 RCX: dffffc0000000000
>> RDX: ffff88807f842600 RSI: 0000000000000002 RDI: ffff88805f09a120
>> RBP: ffffc90002e0fa30 R08: ffff88802b3aecc7 R09: 1ffff11005675d98
>> R10: dffffc0000000000 R11: ffffea000169a5c0 R12: ffff88807f842600
>> R13: ffff88805f09a120 R14: ffff88802b3aed50 R15: ffff88802b3aecb8
>> FS:  00007f32016ce6c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffea000169a5c0 CR3: 000000005af9c000 CR4: 0000000000350ef0
>> Call Trace:
>>  <TASK>
>>  mmap_region+0x1891/0x2090 mm/mmap.c:3058
>>  do_mmap+0x8f9/0x1010 mm/mmap.c:1468
>>  vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
>>  ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1514
>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f3200977299
>> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007f32016ce048 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
>> RAX: ffffffffffffffda RBX: 00007f3200b06058 RCX: 00007f3200977299
>> RDX: 0000000000000001 RSI: 0000000000003000 RDI: 0000000020000000
>> RBP: 00007f32009e48e6 R08: 0000000000000012 R09: 0000000000000000
>> R10: 0000000000000012 R11: 0000000000000246 R12: 0000000000000000
>> R13: 000000000000006e R14: 00007f3200b06058 R15: 00007ffebfee75d8
>>  </TASK>
>> Modules linked in:
>> CR2: ffffea000169a5c0
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:0xffffea000169a5c0
>> Code: ad de 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 24 00 24 00 00 00 00 00 ff ff ff fd 01 00 00 00 01 e8 e4 2c 80 88 ff ff <00> 00 00 00 00 f0 ff 00 00 00 00 00 00 00 00 00 22 01 00 00 00 00
>> RSP: 0018:ffffc90002e0f8f8 EFLAGS: 00010286
>> RAX: 1ffff1100be13426 RBX: ffff88805f09a130 RCX: dffffc0000000000
>> RDX: ffff88807f842600 RSI: 0000000000000002 RDI: ffff88805f09a120
>> RBP: ffffc90002e0fa30 R08: ffff88802b3aecc7 R09: 1ffff11005675d98
>> R10: dffffc0000000000 R11: ffffea000169a5c0 R12: ffff88807f842600
>> R13: ffff88805f09a120 R14: ffff88802b3aed50 R15: ffff88802b3aecb8
>> FS:  00007f32016ce6c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffea000169a5c0 CR3: 000000005af9c000 CR4: 0000000000350ef0
>> 
>> 
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>> 
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> 
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>
> #syz test: git://git.infradead.org/users/jedix/linux-maple.git 71e79d60d610967946f5b5a9fe12dd239216ac39

This crash does not have a reproducer. I cannot test it.

>
>> 
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>> 
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>> 
>> If you want to undo deduplication, reply with:
>> #syz undup
>> 

