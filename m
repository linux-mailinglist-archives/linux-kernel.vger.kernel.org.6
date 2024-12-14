Return-Path: <linux-kernel+bounces-445779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CFC9F1B7F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21597A04C1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29D9DDCD;
	Sat, 14 Dec 2024 00:50:24 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87B5D515
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137424; cv=none; b=Cf+dhkqPYcbvKGquPv+5W08KoeArLYVLVKklPnw1FMU/2yiv7Wwx/FU9Wuu9QhbsmnLa5YlIU+XDIaZMhoTPb2whdyVVnLEORcXXI4l4J7g9nlh0x86VIdtelIdzDIv7hnPtoC3sFn0UfWaYdy0vkuW/MgjsNZIJBbXOdUpwXU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137424; c=relaxed/simple;
	bh=KumtALtdchXW0ARe81cF++rA2me7Btw48nQOHsjRUFI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FVVG+t2TpfmK7BIB9i9aCzYPR4rQKyDCvlmt4Oo94vwNmG1S58MHD1RRSoriIYaFLsFs/lK7X3F3fCg0a3f7TaS0JEKaG0V09nsbsHVDaOxwV7K4X5701Et9ozAOlrWnxXi+0NbcCaSFQ0ehuKzpUw7ZmnP40u59EsT1hgwwVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-844ee1661c9so154291739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137422; x=1734742222;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBLcU77vbmh0JWc6/g8EnwEOkvr08+fPCnf/UWJ2z/k=;
        b=i01OYi7/CX0iKmsIgJM9+c2iB3PKlEYEaFFq/oeXIc4IrLzIPUy6cmVuULZ+hc1qfb
         mfodBZ84xZ2OEklHxWzLzpIZDWdi6q3MNuQQHhz1h38CqWei0GXYzarnPNmC4zzhlXib
         B4ROPG381eOHQ7IAylHA3pq50xLqGe1MeS49yhNoAD3LP7tQyLuDR3RtKpe48jVKqdhf
         V5nnGetZTD4W44+hI3++zufMSGhNp78+VxlRtZ2UWEExQzN8GEi/BACWrufXKtdt7tRy
         tDqFKMdfv2vhGEfDs9ZrELMhvsbSegb+kKY5PIC4Y/U7XMv6Evy4Fvfm3MvF+DgOrvYR
         Bjcg==
X-Forwarded-Encrypted: i=1; AJvYcCXEkeldytnvACIpmjhRjd7NbyKBsJmTSiEE2AmeS03p17amWS0gF1hLipncb6UE4YZh0bk0lWYwLAkb12Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJfd0wen4SYN+G6n3XtQ98Ais9qjpXo21czHqH+2H2XYIDAr+
	eEuB/evCMtkrEkllSNWw+TZAXnDdktNAv10O4sYzg0Dhld7UeEZGSa2xZ/FlmZxsFzRBAqMpEh+
	N9CwN5FKJ6+iiM/O08PbkRQsMi58bwaDIVZD9J5MwEvnXj3hoWms1r8E=
X-Google-Smtp-Source: AGHT+IEZs0zqBvel2J7o7SU5ibN0aq8rTNSCje/SGK9RjrxXSqkh2wKXDjfbYTC3ZSBRmrYmXpge0CnYcZN8Y9o7C41lD4RswOWJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1845:b0:3a7:e732:472a with SMTP id
 e9e14a558f8ab-3afed372bd5mr44103305ab.2.1734137422148; Fri, 13 Dec 2024
 16:50:22 -0800 (PST)
Date: Fri, 13 Dec 2024 16:50:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675cd64e.050a0220.37aaf.00bb.GAE@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in new_curseg (2)
From: syzbot <syzbot+15669ec8c35ddf6c3d43@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7cb1b4663150 Merge tag 'locking_urgent_for_v6.13_rc3' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103bc544580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=15669ec8c35ddf6c3d43
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-7cb1b466.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13e083329dab/vmlinux-7cb1b466.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fe3847d08513/bzImage-7cb1b466.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+15669ec8c35ddf6c3d43@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.c:2746!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5323 Comm: syz.0.0 Not tainted 6.13.0-rc2-syzkaller-00018-g7cb1b4663150 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:get_new_segment fs/f2fs/segment.c:2746 [inline]
RIP: 0010:new_curseg+0x1f52/0x1f70 fs/f2fs/segment.c:2876
Code: fe fd e9 1a fa ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 4c fa ff ff 48 89 df e8 59 37 fe fd e9 3f fa ff ff e8 0f d8 97 fd 90 <0f> 0b e8 07 d8 97 fd 90 0f 0b e8 ff d7 97 fd 90 0f 0b e8 f7 d7 97
RSP: 0018:ffffc9000d22f528 EFLAGS: 00010293
RAX: ffffffff84078631 RBX: 0000000000000018 RCX: ffff88801cf80000
RDX: 0000000000000000 RSI: 0000000000000018 RDI: 0000000000000018
RBP: dffffc0000000000 R08: ffffffff84077465 R09: fffff52001a45e94
R10: dffffc0000000000 R11: fffff52001a45e94 R12: 0000000000000018
R13: ffff888011d6d101 R14: 0000000000000018 R15: ffff888052d722d8
FS:  00007ff3577bc6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc8f62ba00 CR3: 000000004320a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __allocate_new_segment+0x1ce/0x940 fs/f2fs/segment.c:3210
 f2fs_allocate_new_section fs/f2fs/segment.c:3224 [inline]
 f2fs_allocate_pinning_section+0xfa/0x4e0 fs/f2fs/segment.c:3238
 f2fs_expand_inode_data+0x696/0xca0 fs/f2fs/file.c:1830
 f2fs_fallocate+0x537/0xa10 fs/f2fs/file.c:1940
 vfs_fallocate+0x569/0x6e0 fs/open.c:327
 do_vfs_ioctl+0x258c/0x2e40 fs/ioctl.c:885
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0x80/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff357d7ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff3577bc058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff357f46160 RCX: 00007ff357d7ff19
RDX: 00000000200000c0 RSI: 0000000040305828 RDI: 0000000000000004
RBP: 00007ff357df3cc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ff357f46160 R15: 00007ffc8f62c1e8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:get_new_segment fs/f2fs/segment.c:2746 [inline]
RIP: 0010:new_curseg+0x1f52/0x1f70 fs/f2fs/segment.c:2876
Code: fe fd e9 1a fa ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 4c fa ff ff 48 89 df e8 59 37 fe fd e9 3f fa ff ff e8 0f d8 97 fd 90 <0f> 0b e8 07 d8 97 fd 90 0f 0b e8 ff d7 97 fd 90 0f 0b e8 f7 d7 97
RSP: 0018:ffffc9000d22f528 EFLAGS: 00010293
RAX: ffffffff84078631 RBX: 0000000000000018 RCX: ffff88801cf80000
RDX: 0000000000000000 RSI: 0000000000000018 RDI: 0000000000000018
RBP: dffffc0000000000 R08: ffffffff84077465 R09: fffff52001a45e94
R10: dffffc0000000000 R11: fffff52001a45e94 R12: 0000000000000018
R13: ffff888011d6d101 R14: 0000000000000018 R15: ffff888052d722d8
FS:  00007ff3577bc6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc8f62ba00 CR3: 000000004320a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

