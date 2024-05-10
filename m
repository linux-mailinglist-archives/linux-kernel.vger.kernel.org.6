Return-Path: <linux-kernel+bounces-175626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E23B8C22D0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A111F216F9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659A016E896;
	Fri, 10 May 2024 11:08:33 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503E716D9B8
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339312; cv=none; b=P1lmIOaHNMmQUJkvUj9/w1HqDYZRioCxJb59XN/rmYVb/NqA9NVPJh0egXgBgdo01ujFPeAXoC2mC7AB2vpvnZwqX5YGK6b7HHxE9zv6tz05nzKQczOC/nd68jWikG6yM79oz3LMZ87be7rtoC9D7LNpUMKRZ7y2L5Gp37FKrsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339312; c=relaxed/simple;
	bh=mthTqTxjW/ABmV9GWJElXotkm7Bia41/clJDZa0PFv8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AzCeBjQVa867psgYSgBu8o2dLXnCy0X6EdNJG8NhVd5ByHtGpBMwuOtKniMgx1TU8QqzyoLFHipdXmHkVaf1fj/kvMlmaZLedqA8nGVHp9kEActiIWHL0jJHGRscE7Xou8jxAIRK8TQ6TTLSpiDqgYW7cixQQPmIkJupIF2QsoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-36cc59b06a1so3853125ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715339310; x=1715944110;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CgOne8gL8gTh/YPgNB/bRh1J8ouQJ3eSp/81eDHHLoU=;
        b=ZDuEf+S4WxN0Uhia2dQgIsALjiPxL5u6+Tch3IdQsDMaIMisaAfTnEWvvgsycoEm6J
         bEdSoJIJ0hBVW24FBFdfR7xQdsGVZryVHifEAanTOYWNU8bAr0+o64lSqGlXskwDQqTO
         ohogAM2ncVjqAxKUymMf2GRZ3qTN1+X/Mx/rRppWAF83Md++Fi0SKy2b0RHY5QQ8hA0E
         E94NzHdXygWzj91+oAGWMbsK1UQsC1cJfDdsCGhTPZVI910nLGNZewAZlmh+g+favLZ4
         h5wkUeYG4IiiVPdRqOHlHdGjuwqasnON97P2AgTzbUDmVIup4hq9umi85xdShuzxJ5jx
         x0yA==
X-Forwarded-Encrypted: i=1; AJvYcCXqztK2ZUKWemziMJcT2YqXg6JrSnX/ihrl/Y/CX5ZuItE6bseACeM4GdCaEQwi0kedho67PV1LV1Sj30yoq/VZkaRFXQwlyFF/tZdm
X-Gm-Message-State: AOJu0Yxr4AkO/Cs846H/8pw51CDCP+CIKbRLbKa03HEYJybTi32y5Mc4
	ihDqIDMuWiAjzXMpzCvxWQNi8MZPlCP1ztp2q2DeID0pCA2B+hJUXTuLAusabt5A4sRQDarSj20
	PJZu/Mjf2icPuyRP21J6EZ5q3b1oiG1DG5uBjsu0xsSGmlBv+2nSLovM=
X-Google-Smtp-Source: AGHT+IGPpSFw3gNXkyId/H9xxhnGz9pZG86FI1OS8Tqr+uiaoK7iSQqqneZI+lMwPmS0bKRy2m4Uyq67M0VytRZMKeydZ+oPRJyM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:4b06:0:b0:36c:5029:1925 with SMTP id
 e9e14a558f8ab-36cc1385589mr779395ab.0.1715339310489; Fri, 10 May 2024
 04:08:30 -0700 (PDT)
Date: Fri, 10 May 2024 04:08:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004574160618178e1e@google.com>
Subject: [syzbot] [kvm?] WARNING in kvm_mmu_notifier_invalidate_range_start (4)
From: syzbot <syzbot+30d8503d558f3d50306b@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2b84edefcad1 Add linux-next specific files for 20240506
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16f76404980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b499929e4aaba1af
dashboard link: https://syzkaller.appspot.com/bug?extid=30d8503d558f3d50306b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a22cf95ee14/disk-2b84edef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f5c45b515282/vmlinux-2b84edef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9bf98258a662/bzImage-2b84edef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30d8503d558f3d50306b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 16762 at arch/x86/kvm/../../../virt/kvm/kvm_main.c:595 __kvm_handle_hva_range arch/x86/kvm/../../../virt/kvm/kvm_main.c:595 [inline]
WARNING: CPU: 0 PID: 16762 at arch/x86/kvm/../../../virt/kvm/kvm_main.c:595 kvm_mmu_notifier_invalidate_range_start+0xa63/0xc10 arch/x86/kvm/../../../virt/kvm/kvm_main.c:787
Modules linked in:
CPU: 0 PID: 16762 Comm: syz-executor.1 Not tainted 6.9.0-rc7-next-20240506-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__kvm_handle_hva_range arch/x86/kvm/../../../virt/kvm/kvm_main.c:595 [inline]
RIP: 0010:kvm_mmu_notifier_invalidate_range_start+0xa63/0xc10 arch/x86/kvm/../../../virt/kvm/kvm_main.c:787
Code: c6 05 fb 42 8b 0e 01 48 c7 c7 80 be c1 8b be 03 04 00 00 48 c7 c2 20 9f c1 8b e8 b8 a6 66 00 e9 f6 f8 ff ff e8 8e f5 89 00 90 <0f> 0b 90 e9 28 ff ff ff e8 80 f5 89 00 90 0f 0b 90 e9 c9 f6 ff ff
RSP: 0018:ffffc9000a29e940 EFLAGS: 00010283
RAX: ffffffff810c23a2 RBX: 0000000020000000 RCX: 0000000000040000
RDX: ffffc9001580a000 RSI: 00000000000039aa RDI: 00000000000039ab
RBP: ffffc9000a29eaf0 R08: ffffffff810c1bb6 R09: 0000000000000000
R10: ffffc9000a29ea40 R11: fffff52001453d4d R12: dffffc0000000000
R13: ffffc9000a29ea40 R14: 0000000020000000 R15: 1ffff92001453dc4
FS:  00007f1c65b3f6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0f815a8000 CR3: 00000000201c0000 CR4: 00000000003526f0
DR0: 000000000000e8ca DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mn_hlist_invalidate_range_start mm/mmu_notifier.c:476 [inline]
 __mmu_notifier_invalidate_range_start+0x45e/0x890 mm/mmu_notifier.c:531
 mmu_notifier_invalidate_range_start include/linux/mmu_notifier.h:439 [inline]
 try_to_unmap_one+0x9a0/0x3290 mm/rmap.c:1664
 rmap_walk_file+0x52f/0x9f0 mm/rmap.c:2669
 try_to_unmap+0x219/0x2e0
 unmap_folio+0x197/0x370 mm/huge_memory.c:2685
 split_huge_page_to_list_to_order+0xbf6/0x1cd0 mm/huge_memory.c:3187
 split_folio_to_list_to_order include/linux/huge_mm.h:581 [inline]
 split_folio_to_order include/linux/huge_mm.h:586 [inline]
 truncate_inode_partial_folio+0x470/0x740 mm/truncate.c:242
 shmem_undo_range+0x9a5/0x1df0 mm/shmem.c:1023
 shmem_truncate_range mm/shmem.c:1114 [inline]
 shmem_fallocate+0x497/0x11f0 mm/shmem.c:3117
 vfs_fallocate+0x564/0x6c0 fs/open.c:330
 madvise_remove mm/madvise.c:1012 [inline]
 madvise_vma_behavior mm/madvise.c:1036 [inline]
 madvise_walk_vmas mm/madvise.c:1268 [inline]
 do_madvise+0x192a/0x44d0 mm/madvise.c:1464
 __do_sys_madvise mm/madvise.c:1481 [inline]
 __se_sys_madvise mm/madvise.c:1479 [inline]
 __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1479
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1c64e7dca9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1c65b3f0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007f1c64fac050 RCX: 00007f1c64e7dca9
RDX: 0000000000000009 RSI: 000000000060000b RDI: 0000000020000000
RBP: 00007f1c64ec947e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f1c64fac050 R15: 00007ffe73a84cc8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

