Return-Path: <linux-kernel+bounces-437990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B7B9E9B55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC80B281237
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E44139D05;
	Mon,  9 Dec 2024 16:14:27 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C413233139
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760866; cv=none; b=l4G/3ciS4aGPODoc4v0mf0trSGHsk1p0NcdN2Xo20wxCqQ6xhPn4/SzpiWtEO9EeZ9DaAGWDIR+ky0nYr5dGwSNLotwIxWt3z0M+ITNZYtrWUbRQeIqBFG2XxvPjxnr6QZNdfLtdbMlA+VBz+owDBJDDlh2Zqx7R4/h3VnGqRHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760866; c=relaxed/simple;
	bh=4vtcAbPpTa/5/HOf1A9ub/YxsZCfHDXVX4gcjpZFtp4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UIjs5HZGP9RGdNgKMD3BQjc05OKWsGW5t69bEzIFy8KPseZXeZkD2tb0HwSauELA+lQFnCU0+KCTuXfzViLJAl+uzh8+xUYD2UX3ld1WcBk+xR6UIncqlS1JjI2Bio5rX/WsZJkFm4IvQNg8fxX5TmQZpr0vL9zdAihIqKCTZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-843eac1b9dbso416212739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733760864; x=1734365664;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ix/TQpre3i6g0/sJMa3Z1qkPrRMZy1XlPhIuSUvim88=;
        b=geIRj9UNCX/c99EeDhBhDvJ96cWCitLjgNlm3WtJD9293zCTd6Lu8Fs0bUa8Iadw6j
         wkI8OdAi9ZACIhwUxr/7ezaLPC51RvuZ9QVKQqvHFkfrFUyhH3G9Ojv/aOSG9VoC8eEV
         BK0OTAEBC5on9+NukH0iFpHR4rfkz8E2fIWYTD7xf7coKJ6Wm03rRvqS8/Bpzja/XH1q
         aRKGJTnUtiVwk4ojFdte7x80lDLw83sURdso0iE2A+kox7U/2shrpDRylHFVy33Be/tD
         E1+WuRO8X0dWWpRyfODXxt5PgY6goesnLs909xstMb1u8G5U1wapexHCNGm12ztrTqsK
         ZkZg==
X-Forwarded-Encrypted: i=1; AJvYcCVsLofmEdqPgmfXpJpMXLRXmkQ2kZN5UO5ZyFA//0RiEiHawdlqR6CQiOK2MbkSMHuMzo5gX4KLR/elcrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTmc8aLGf7kWD2co4ZJ4Pe1vp80SK5zKP3iG0zBjJ8mET7pVDx
	hPFcZ2q0osq548b4XL9h1kFRGsmPVZUBAsIxXebJoRR0nMyf2JB3ZcGf/4gswnWw1+HidpKoJlo
	/SHIqZqwyUZ6mDIar5pMQ19bdhuYsGnhgDCDOmOOmzAOV448g60iG6j8=
X-Google-Smtp-Source: AGHT+IEyLkPKzk1t8zOiO5CRL0nwH6Rlx2RI3zs8mg8isIi0g8PHi+a+xJ/tAJIHA6Ano4hIqTW7M6O9yPHJXI8qDbEwbMlXdras
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:341c:b0:83a:9820:f26b with SMTP id
 ca18e2360f4ac-844b514454cmr157812939f.2.1733760864394; Mon, 09 Dec 2024
 08:14:24 -0800 (PST)
Date: Mon, 09 Dec 2024 08:14:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67571760.050a0220.a30f1.01a9.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in lru_gen_add_folio
From: syzbot <syzbot+7d6336b144d8db5ad602@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    af2ea8ab7a54 Add linux-next specific files for 20241205
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1232c3e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76f158395f6f15fd
dashboard link: https://syzkaller.appspot.com/bug?extid=7d6336b144d8db5ad602
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179d14df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13be48f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8af0861258fa/disk-af2ea8ab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ffb38cf7a344/vmlinux-af2ea8ab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6fbd2e50358a/bzImage-af2ea8ab.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c5bc8f20b5e4/mount_13.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7d6336b144d8db5ad602@syzkaller.appspotmail.com

 reclaim_folio_list+0x13c/0x5f0 mm/vmscan.c:2183
 reclaim_pages+0x49e/0x5e0 mm/vmscan.c:2220
 madvise_cold_or_pageout_pte_range+0x1ea8/0x2360 mm/madvise.c:558
 walk_pmd_range mm/pagewalk.c:130 [inline]
 walk_pud_range mm/pagewalk.c:226 [inline]
 walk_p4d_range mm/pagewalk.c:264 [inline]
 walk_pgd_range+0xc3d/0x17e0 mm/pagewalk.c:305
 __walk_page_range+0x15f/0x700 mm/pagewalk.c:412
 walk_page_range_mm+0x58f/0x7c0 mm/pagewalk.c:505
 madvise_pageout_page_range mm/madvise.c:617 [inline]
 madvise_pageout mm/madvise.c:644 [inline]
 madvise_vma_behavior mm/madvise.c:1266 [inline]
 madvise_walk_vmas mm/madvise.c:1502 [inline]
 do_madvise+0x3944/0x4d90 mm/madvise.c:1689
 __do_sys_madvise mm/madvise.c:1705 [inline]
 __se_sys_madvise mm/madvise.c:1703 [inline]
 __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1703
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
------------[ cut here ]------------
WARNING: CPU: 0 PID: 14073 at ./include/linux/mm_inline.h:265 lru_gen_add_folio+0xad2/0xc30 include/linux/mm_inline.h:265
Modules linked in:
CPU: 0 UID: 0 PID: 14073 Comm: syz-executor858 Not tainted 6.13.0-rc1-next-20241205-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:lru_gen_add_folio+0xad2/0xc30 include/linux/mm_inline.h:265
Code: 44 89 c2 ff ba 01 00 00 00 e9 8b fa ff ff e8 35 89 c2 ff 4c 89 ff 48 c7 c6 c0 c8 13 8c e8 c6 41 0c 00 c6 05 f1 32 27 0e 01 90 <0f> 0b 90 e9 82 f6 ff ff 89 d9 80 e1 07 38 c1 0f 8c 19 f7 ff ff 48
RSP: 0018:ffffc9000e786ce0 EFLAGS: 00010046
RAX: 72f3d3d7c701e600 RBX: ffffea0000cbb548 RCX: ffffc9000e786803
RDX: 0000000000000003 RSI: ffffffff8c0aa440 RDI: ffffffff8c5fbe80
RBP: ffffc9000e786dd8 R08: ffffffff9019d9b7 R09: 1ffffffff2033b36
R10: dffffc0000000000 R11: fffffbfff2033b37 R12: 0000000000000000
R13: 1ffffd40001976a8 R14: 0000020000000000 R15: ffffea0000cbb540
FS:  00007f0542a006c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f05432da864 CR3: 000000002eb56000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lruvec_add_folio include/linux/mm_inline.h:352 [inline]
 lru_add+0x704/0xdb0 mm/swap.c:154
 folio_batch_move_lru+0x26b/0x420 mm/swap.c:168
 __folio_batch_add_and_move+0x5bb/0xd70 mm/swap.c:196
 filemap_add_folio+0x24e/0x380 mm/filemap.c:987
 page_cache_ra_unbounded+0x32c/0x720 mm/readahead.c:263
 do_async_mmap_readahead mm/filemap.c:3212 [inline]
 filemap_fault+0x818/0x1490 mm/filemap.c:3311
 __do_fault+0x135/0x390 mm/memory.c:4978
 do_read_fault mm/memory.c:5393 [inline]
 do_fault mm/memory.c:5527 [inline]
 do_pte_missing mm/memory.c:4048 [inline]
 handle_pte_fault+0x39eb/0x5ee0 mm/memory.c:5872
 __handle_mm_fault mm/memory.c:6015 [inline]
 handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6183
 faultin_page mm/gup.c:1200 [inline]
 __get_user_pages+0x1b31/0x4370 mm/gup.c:1495
 populate_vma_page_range+0x264/0x330 mm/gup.c:1933
 __mm_populate+0x27a/0x460 mm/gup.c:2036
 mm_populate include/linux/mm.h:3389 [inline]
 vm_mmap_pgoff+0x303/0x430 mm/util.c:585
 ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:545
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0543256069
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0542a00158 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f05432d8708 RCX: 00007f0543256069
RDX: 0000000001000002 RSI: 0000000000b36000 RDI: 0000000020000000
RBP: 00007f05432d8700 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000028011 R11: 0000000000000246 R12: 00007f05432d870c
R13: 0000000000000006 R14: 00007ffce0a6ecb0 R15: 00007ffce0a6ed98
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

