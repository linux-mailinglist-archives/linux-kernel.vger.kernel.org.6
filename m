Return-Path: <linux-kernel+bounces-289081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911F09541F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231E3286292
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487D382C8E;
	Fri, 16 Aug 2024 06:44:22 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009B82866
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790661; cv=none; b=TCzo9s3+e4vO/tjl3bewzKmA3xKWVca8G+c+oLH5TLnq+A8nPvqDyKZ2L5Kv0DvEjHLPcyBbQ7q0zy5NtbRwi+w+c9Lomj63gq01cQxsoXMa/tBR7pBgeG43GWX8TjyIC6/r8+DVhJcc6NvN4ciU5hwan3k+3u0D1cSgSxO1ags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790661; c=relaxed/simple;
	bh=PpcIqKBtDRHEFZyz3rpMduBzVG6pswX6XHEIYqfNIRk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F6Ti/s9ry5q82h9H7LD9hg4WvfzVcNXs8ARf2DIvizKQKf6GG1orahR9DdTle7u0SgzAdtGhCM/5TFB+dlwqVHC8TEi4xtfaavGRjBaOeF6m/3zkbaOSkMe6rsyqrpvWPGCz7lG9jA/JyOCSSY+H/qqcR0DGXHWqJjf05rmfkY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3cd180ffso17386515ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723790659; x=1724395459;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edCKPVbW/dyCO+FHvSGIncuOWOaLNK8iiJYOX+4kmA4=;
        b=Ym6junWznXw7kzLiTrZXKStkVIlbH7f8+7I6AnUtcUohHWlH96RUrpQBF02X//leck
         A2woyVTGAHc9SBbtbB8WD4McNoACb86LTxrAeCzFywjqdBHAnRNi9RJIzwjG8zHT32OT
         FWFNq17FtEW6bm6CmvH5FP7htanPqJNeI4PfQ9Z+s9L1sU7kJIiF/opdFdczlB9N4dmA
         JZpcllEHVURJ9QYybowy8I85mpv8wNYFmfkJEh580IRO5sHLaYI0o3e23Tvo6JjVjB5z
         CXKUT9e0Ln1Su/AA0VYvM5ZstlPr1u62qJHgGHESVKieDuw5MNskYESl3UdbNANqRvj3
         SPOg==
X-Forwarded-Encrypted: i=1; AJvYcCXxoCU5TqtlZ0nPLO2LK/QqmctdtWgDVWfHH6SQXPcHwXzryhAGco0sB6wux8jZFpIm6a0FO8+TR+1zRlbiKEckPczI9ywX9xtpHOo0
X-Gm-Message-State: AOJu0YyhrV3Em4QH+gOyMIqiONLYfg9UVVzWmMvUlWQE9eHp/rL10Dwf
	0Sndkr7XL3wVzc8SmwRedtgL6lQIt3wZsZaOx6nem1xhu33uCrFJyc62R9FEKrTt183kRv37y/D
	YYP9I24GGT1VYYeFDldktBj28LVZvNAd43HdZomG0HyBeWOKxVfJlL4w=
X-Google-Smtp-Source: AGHT+IFOAtm8alxjQ+dIL9O82uDk0WuLg2fs4gXrTxtm53qt1hT2XiOEaHPvSHNnJJbt+GI9ehEQB39N+raYH0WWoQn4JK/+2qyH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1384:b0:382:feb2:2117 with SMTP id
 e9e14a558f8ab-39d26dc22c3mr1362805ab.6.1723790659217; Thu, 15 Aug 2024
 23:44:19 -0700 (PDT)
Date: Thu, 15 Aug 2024 23:44:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8fba6061fc7494a@google.com>
Subject: [syzbot] [ntfs3?] kernel BUG in zero_user_segments
From: syzbot <syzbot+78eeb671facb19832e95@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9e6869691724 Add linux-next specific files for 20240812
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17cbe35d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=78eeb671facb19832e95
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c473d9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15486c05980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1b086192f50/disk-9e686969.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b457920fb52e/vmlinux-9e686969.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e63ba9cce98a/bzImage-9e686969.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f70931fddf9e/mount_0.gz

Bisection is inconclusive: the first bad commit could be any of:

02d8a3227f49 hostfs: Convert hostfs_write_end() to use a folio
a060d835cf76 fuse: Convert fuse_write_begin() to use a folio
c8dbe54a2e0b jffs2: Convert jffs2_write_end() to use a folio
0ee818cc42fc jffs2: Convert jffs2_write_begin() to use a folio

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=161e0ef3980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78eeb671facb19832e95@syzkaller.appspotmail.com

ntfs3: loop0: Failed to initialize $Extend/$ObjId.
------------[ cut here ]------------
kernel BUG at include/linux/highmem.h:275!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5229 Comm: syz-executor130 Not tainted 6.11.0-rc3-next-20240812-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:zero_user_segments+0x28b/0x290 include/linux/highmem.h:275
Code: 02 02 e9 47 fe ff ff e8 23 30 a8 fe 89 ea be 00 10 00 00 48 c7 c7 30 86 ce 8e e8 e0 7b 02 02 e9 d3 fe ff ff e8 06 30 a8 fe 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc90003a574a0 EFLAGS: 00010293
RAX: ffffffff82eb5e4a RBX: ffffea0001d39440 RCX: ffff888029bd5a00
RDX: 0000000000000000 RSI: 0000000000001001 RDI: 0000000000001000
RBP: 0000000000001000 R08: ffffffff82eb5c85 R09: 1ffffd40003a7288
R10: dffffc0000000000 R11: fffff940003a7289 R12: 0000000000001001
R13: 0000000000000000 R14: 1ffffd40003a7288 R15: 0000000000001001
FS:  0000555572aa0380(0000) GS:ffff8880b9000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007febeca54100 CR3: 0000000077864000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 folio_zero_range include/linux/highmem.h:647 [inline]
 ntfs_extend_initialized_size+0x50b/0x950 fs/ntfs3/file.c:215
 ntfs_extend+0x3fe/0x480 fs/ntfs3/file.c:403
 ntfs_file_write_iter+0x3d1/0x740 fs/ntfs3/file.c:1187
 iter_file_splice_write+0xbd7/0x14e0 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11e/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x58e/0xc90 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x28c/0x3e0 fs/splice.c:1233
 vfs_copy_file_range+0xd37/0x1530 fs/read_write.c:1558
 __do_sys_copy_file_range fs/read_write.c:1612 [inline]
 __se_sys_copy_file_range+0x3f2/0x5d0 fs/read_write.c:1575
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febec9bcdd9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef5b189d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000146
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007febec9bcdd9
RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007febeca505f0 R08: 0000000000000006 R09: 0000000000000000
R10: 00000000200000c0 R11: 0000000000000246 R12: 00007ffef5b18a10
R13: 00007ffef5b18c38 R14: 431bde82d7b634db R15: 00007febeca0603b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:zero_user_segments+0x28b/0x290 include/linux/highmem.h:275
Code: 02 02 e9 47 fe ff ff e8 23 30 a8 fe 89 ea be 00 10 00 00 48 c7 c7 30 86 ce 8e e8 e0 7b 02 02 e9 d3 fe ff ff e8 06 30 a8 fe 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc90003a574a0 EFLAGS: 00010293
RAX: ffffffff82eb5e4a RBX: ffffea0001d39440 RCX: ffff888029bd5a00
RDX: 0000000000000000 RSI: 0000000000001001 RDI: 0000000000001000
RBP: 0000000000001000 R08: ffffffff82eb5c85 R09: 1ffffd40003a7288
R10: dffffc0000000000 R11: fffff940003a7289 R12: 0000000000001001
R13: 0000000000000000 R14: 1ffffd40003a7288 R15: 0000000000001001
FS:  0000555572aa0380(0000) GS:ffff8880b9000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007febeca54100 CR3: 0000000077864000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

