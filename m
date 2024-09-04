Return-Path: <linux-kernel+bounces-314827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7C096B99F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3C7282A69
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E201CFED1;
	Wed,  4 Sep 2024 11:06:53 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A4C1CF7A4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448012; cv=none; b=D/L2n0AxyrUxbdNzNuV4E4QtdnjUPBj1R+HaRrc3YULCYoUfNO+oKAmxaZ62jBzxc1XbeIEJ4raUsV8wrX3BIseyiNmLea6ujb2X4U2oPVkqXwRr3EEzbDxlpDgTHZ6+ydzjKSeNSshFtQGe9lWmV8NGufVI8mIH3/oWVCuyvZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448012; c=relaxed/simple;
	bh=5LzeaJQmPXFY0gy9QCBlRjbPc8ssnZML3nw/RGrMRhQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=D9K2mbb+rLGCr3qDOVWUAhrNXqIgsrQpPZyPxELPecCaRJ2ew25JumKoElwe0407NP/7SWr+vxVoNALFy732/zZRHmD9wcAXyEgZ7lg16W3Ws4ut0+aslxToUULZqqQ94SnE+EaubGjPYQrlF8Rz0aWivvRjGs65H+Mrc/+EYuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f56ac8d88so41047365ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 04:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725448010; x=1726052810;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P62b6v8WPLmSIka/Wy8yNKcSDH3A4O9hYL8Aq+CMlXE=;
        b=nfuoe44mYmmpWBozjMVIcac5If9waAO3KGr4/8GvKETyVcImGyWpPIMaJLRzFWclmQ
         l4OantFb9aY81mOOZ3Vw5Ajpkk+YvXkEdX75cwoL+1bf3IRQS+QFjUZ7d3oB2wxNwSmo
         u3ZV0fJVvfxRDiN+XbCnxxYP+WZEEupA7fSjPmE8USPNyhs/+kpNpQsTVKk9OO/iKIQb
         fWq9GkVKPak67Hw7Ii9F1SfSvuNnGyHBC107quSXv5fqD6aa3CGkIwbifzg6LXvJYmPZ
         7KgqlqtzlEbDugCMsc7+ER1B1esEiPna8UOU3DOcc0woAdE7ahrpgBJnZ6blfI+4IHOU
         as3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWtfNHeVgZF5iwAlqdQakCXEYNA3VyPl+7zTl2VsVfdgdyF8outv3dZMmDjOsCeC713majjNnEK4lLP/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHCF/CVPZNaqsQm5TKbGPgK4cal2+JOpKO4ElRmQ8V2/5idfuV
	T1vWnlc+NJsZaXIGvTivMleKdzdJK1RPIH3RmOJ2aLbXLo1HqeiSPfkMlhboWi2zVP7DwWAmKZE
	R/j5K0YtaN0Zp+Yl6fxVwZ2PabTvVqPeRLHSU3D7loKfD4uj9hp2QUnU=
X-Google-Smtp-Source: AGHT+IHbK8Jr6lKKdsbZ1Q/eQ69lhARy6CNmjDHdsDZI8hIQUqyJLMJZvJ5JDEgSF8+al8FvDo1ZsliJro2SkOIclpZDBJkpc+tY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54a:0:b0:39b:2133:8ee5 with SMTP id
 e9e14a558f8ab-39f40ed447cmr8469195ab.1.1725448010111; Wed, 04 Sep 2024
 04:06:50 -0700 (PDT)
Date: Wed, 04 Sep 2024 04:06:50 -0700
In-Reply-To: <20240904110644.g52vgotsmi4lm56c@quack3>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8b0b30621492b9d@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in jbd2_journal_dirty_metadata
From: syzbot <syzbot+c28d8da3e83b3cc68dc6@syzkaller.appspotmail.com>
To: jack@suse.cz
Cc: jack@suse.com, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

> On Tue 03-09-24 21:50:20, syzbot wrote:
>> syzbot found the following issue on:
>> 
>> HEAD commit:    fb24560f31f9 Merge tag 'lsm-pr-20240830' of git://git.kern..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1739530b980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
>> dashboard link: https://syzkaller.appspot.com/bug?extid=c28d8da3e83b3cc68dc6
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-fb24560f.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/2d39db26a2bc/vmlinux-fb24560f.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/8910481ae16e/bzImage-fb24560f.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+c28d8da3e83b3cc68dc6@syzkaller.appspotmail.com
>> 
>> loop0: detected capacity change from 0 to 32768
>> =======================================================
>> WARNING: The mand mount option has been deprecated and
>>          and is ignored by this kernel. Remove the mand
>>          option from the mount to silence this warning.
>> =======================================================
>> ocfs2: Mounting device (7,0) on (node local, slot 0) with ordered data mode.
>> loop0: detected capacity change from 32768 to 0
>> syz.0.0: attempt to access beyond end of device
>> loop0: rw=0, sector=10576, nr_sectors = 1 limit=0
>> (syz.0.0,5108,0):__ocfs2_xattr_set_value_outside:1385 ERROR: status = -5
>
> Looks like ocfs2 issue, not ext4.
>
> #syz set ocfs2

The specified label "ocfs2" is unknown.
Please use one of the supported labels.

The following labels are suported:
missing-backport, no-reminders, prio: {low, normal, high}, subsystems: {.. see below ..}
The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems?all=true

>
> 								Honza
>
>
>> (syz.0.0,5108,0):ocfs2_xa_set:2261 ERROR: status = -5
>> (syz.0.0,5108,0):__ocfs2_journal_access:705 ERROR: Error -30 getting 1 access to buffer!
>> (syz.0.0,5108,0):ocfs2_journal_access_path:751 ERROR: status = -30
>> (syz.0.0,5108,0):ocfs2_truncate_rec:5443 ERROR: status = -30
>> (syz.0.0,5108,0):ocfs2_remove_extent:5584 ERROR: status = -30
>> (syz.0.0,5108,0):__ocfs2_remove_xattr_range:782 ERROR: status = -30
>> (syz.0.0,5108,0):ocfs2_xattr_shrink_size:836 ERROR: status = -30
>> (syz.0.0,5108,0):__ocfs2_journal_access:705 ERROR: Error -30 getting 1 access to buffer!
>> (syz.0.0,5108,0):ocfs2_xa_prepare_entry:2152 ERROR: status = -30
>> (syz.0.0,5108,0):ocfs2_xa_set:2255 ERROR: status = -30
>> ------------[ cut here ]------------
>> kernel BUG at fs/jbd2/transaction.c:1513!
>> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
>> CPU: 0 UID: 0 PID: 5108 Comm: syz.0.0 Not tainted 6.11.0-rc5-syzkaller-00207-gfb24560f31f9 #0
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>> RIP: 0010:jbd2_journal_dirty_metadata+0xbab/0xc00 fs/jbd2/transaction.c:1512
>> Code: ff e9 74 fc ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c af fc ff ff 4c 89 ef e8 30 27 8a ff e9 a2 fc ff ff e8 66 dc 22 ff 90 <0f> 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 95 fd ff ff 48 89 df e8
>> RSP: 0018:ffffc90002d7ea38 EFLAGS: 00010283
>> RAX: ffffffff8270afca RBX: ffff88801240bca0 RCX: 0000000000040000
>> RDX: ffffc90003092000 RSI: 00000000000081b4 RDI: 00000000000081b5
>> RBP: 1ffff11002481794 R08: 0000000000000003 R09: fffff520005afd38
>> R10: dffffc0000000000 R11: fffff520005afd38 R12: ffff88801240bc98
>> R13: 1ffff110065e591e R14: ffff88801240a000 R15: ffff88801240bc38
>> FS:  00007f28379866c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00000000200010c0 CR3: 000000003ce4c000 CR4: 0000000000350ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <TASK>
>>  ocfs2_journal_dirty+0x156/0x7c0 fs/ocfs2/journal.c:812
>>  ocfs2_xa_journal_dirty fs/ocfs2/xattr.c:1453 [inline]
>>  ocfs2_xa_set+0x225b/0x2b40 fs/ocfs2/xattr.c:2264
>>  ocfs2_xattr_block_set+0x46e/0x3390 fs/ocfs2/xattr.c:2986
>>  __ocfs2_xattr_set_handle+0x67a/0x10a0 fs/ocfs2/xattr.c:3388
>>  ocfs2_xattr_set+0x128c/0x1930 fs/ocfs2/xattr.c:3651
>>  __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
>>  __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
>>  vfs_setxattr+0x221/0x430 fs/xattr.c:321
>>  do_setxattr fs/xattr.c:629 [inline]
>>  path_setxattr+0x37e/0x4d0 fs/xattr.c:658
>>  __do_sys_setxattr fs/xattr.c:676 [inline]
>>  __se_sys_setxattr fs/xattr.c:672 [inline]
>>  __x64_sys_setxattr+0xbb/0xd0 fs/xattr.c:672
>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f2836b79eb9
>> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007f2837986038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
>> RAX: ffffffffffffffda RBX: 00007f2836d15f80 RCX: 00007f2836b79eb9
>> RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000020000080
>> RBP: 00007f2836be793e R08: 0000000000000002 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 0000000000000000 R14: 00007f2836d15f80 R15: 00007ffdcb3dd268
>>  </TASK>
>> Modules linked in:
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:jbd2_journal_dirty_metadata+0xbab/0xc00 fs/jbd2/transaction.c:1512
>> Code: ff e9 74 fc ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c af fc ff ff 4c 89 ef e8 30 27 8a ff e9 a2 fc ff ff e8 66 dc 22 ff 90 <0f> 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 95 fd ff ff 48 89 df e8
>> RSP: 0018:ffffc90002d7ea38 EFLAGS: 00010283
>> RAX: ffffffff8270afca RBX: ffff88801240bca0 RCX: 0000000000040000
>> RDX: ffffc90003092000 RSI: 00000000000081b4 RDI: 00000000000081b5
>> RBP: 1ffff11002481794 R08: 0000000000000003 R09: fffff520005afd38
>> R10: dffffc0000000000 R11: fffff520005afd38 R12: ffff88801240bc98
>> R13: 1ffff110065e591e R14: ffff88801240a000 R15: ffff88801240bc38
>> FS:  00007f28379866c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00000000200010c0 CR3: 000000003ce4c000 CR4: 0000000000350ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

