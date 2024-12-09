Return-Path: <linux-kernel+bounces-438271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 328FD9E9F3C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42BFB1608A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5A3161311;
	Mon,  9 Dec 2024 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEbwv1mf"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01809433D1
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733771484; cv=none; b=jrruqPkQdK0pR/uOVDK4QEvBWAOUOydouvNeNFf55lzqq1lTCVyEf95EsZuKBtRJDfPl9Log32H5sQ7qLFfBaw6slGeqDVSe+pqS8yZJZrekmA7MFe41EadvGY1HtX9885dnnvabyuYMruDquHa6D5Brcx5ulSWi/rWVES6H4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733771484; c=relaxed/simple;
	bh=eel1TcAEzFjpwPIs8zVBB0Lt5LVuKi385gzv885iqGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h58GZu1YXVWil6PvEjf5QAiGaWqxk0ZFUu2C25qCC7/iVlN7b21zothx7zPNq7R3oLbgz5YbEaCiMsUanYTNEYmgmPHPx33nN3EWaTSFYYLNgMVCd0Mq1HWQE3x3ZTfq91s3Nhzd226ot/BiqQ4662Z/VLIG7ddG4/lJfF02y/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FEbwv1mf; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4affbc4dc74so464393137.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 11:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733771482; x=1734376282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gL8fgGXMKiItT9B/EOZgomxUM87ng+frEpu1NgWWGI=;
        b=FEbwv1mffX8zXkKahk/XEB59i2bzVjf9+x3Q8y87hO0RVrevpu/bw/Z0HQMmaeXOuY
         6xyWyTIXQKU1+KQg8tM238Y+5T1pnXt0IvUrMVXh7qXcji9sZVwKmBr2ree3n/t/51Hd
         3BYg3Fs2rsaJ51I6rTd19pcB1uG2MIF6DPNsU5qEFLslgeTjnr2fyxG0Y21mlcoDXry+
         h/o+J/t1XnoeHD+itrvGXtQyFKqs6u7uFMXdEtTNoVUSOQvU4kvLu+uSd44FS6nThA5u
         HCVJPF+OSfO8cizLettxoN8TFhWVbRgOK69+6qlNSu1pBlF/YLacHyXVaY5HHzXFOw5R
         0cWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733771482; x=1734376282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gL8fgGXMKiItT9B/EOZgomxUM87ng+frEpu1NgWWGI=;
        b=mLnCKXDl+zlKEyHbeX+wJEHzxOWhDM5+4z35psGXA7ghpmKAiQmFWWPphT1wuGSNrj
         nR/h+HEAWytieV5gam+FQpUvTNy0/5dIf0M4RazeffcrZ3gxVZ1gsZb4aRGImKueOja0
         LjeHAnGjdYF+MdoRlHgdUXn4kJw0dsRJsfX1IDYxOOlR5TNtQKZ6NEmpP2S91LNNHO/7
         QzKkLwnjr7zTTRSmRneMMoMvlKv+HdT/yPgqcxpgXyQ9CLx15KkiFrJxMi2SsdLaHRMo
         7yj9y8fwyn3RwowLBuTw7AqjvIrbF4ghwDKJZAYnkY5dTjOvSlR44XngQ3Rrb7zElWkO
         gjkg==
X-Forwarded-Encrypted: i=1; AJvYcCUk8MZ7wBlTnt2Yq4Jdm46irnfmjn0tv3RmLvIYSdAeJP/ddCgCjPRTzCSSVLAJ/JWReKJnmA3CHGIFG9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5XWMKQR/6EUg5jp5OlqlxF1sQ0bORxQlWNBaP8FA1CWF2MvP
	YI/0EIt823dm5wLgabgmhVH93okFBqFXSB+z6S2ZwHV4yFo/w15FPcqVLeDXikLB6fxsbHXWRj9
	CdJ0COTqxlJSyfkjLK9btbryXmVZj+HezU9FyGQaCGJ9tpUXLaA==
X-Gm-Gg: ASbGnculBBP4LqhhxDGS4jG/0AOcB/iBdUer7KAdIlkmcMUFjCm2iAzUNqeSc7mArg8
	dw5gopT6ahI5+z1xpKQz7Wi/eIi/Z5Oqi+WnwrvoixgC84J8+XcNSeNmzFgOKLRb/QnG/
X-Google-Smtp-Source: AGHT+IGSNeSKO9bG0uQ60ztVyxJCqdZK4/whyAFNCYMOPMBjyuYzHnlQvX/t53W8CxyVie3CqSrLJ4F3uHUj89X2f2A=
X-Received: by 2002:a05:6102:290c:b0:4b1:11c6:d3d2 with SMTP id
 ada2fe7eead31-4b111c6e527mr3308109137.27.1733771481621; Mon, 09 Dec 2024
 11:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67571760.050a0220.a30f1.01a9.GAE@google.com>
In-Reply-To: <67571760.050a0220.a30f1.01a9.GAE@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 9 Dec 2024 12:10:45 -0700
Message-ID: <CAOUHufYjydGThaAN2t92LhbWFuYurWY=eQoc4aCF5NGVzNWW-w@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in lru_gen_add_folio
To: syzbot <syzbot+7d6336b144d8db5ad602@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 9:14=E2=80=AFAM syzbot
<syzbot+7d6336b144d8db5ad602@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    af2ea8ab7a54 Add linux-next specific files for 20241205

20241205 has "mm/mglru: rework workingset protection" v1 [1], and the
warning was fixed in v2.

[1] https://lore.kernel.org/linux-mm/20241202032823.2741019-7-yuzhao@google=
.com/


> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1232c3e858000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D76f158395f6f1=
5fd
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7d6336b144d8db5=
ad602
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D179d14df980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13be48f858000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8af0861258fa/dis=
k-af2ea8ab.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ffb38cf7a344/vmlinu=
x-af2ea8ab.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6fbd2e50358a/b=
zImage-af2ea8ab.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/c5bc8f20b5=
e4/mount_13.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+7d6336b144d8db5ad602@syzkaller.appspotmail.com
>
>  reclaim_folio_list+0x13c/0x5f0 mm/vmscan.c:2183
>  reclaim_pages+0x49e/0x5e0 mm/vmscan.c:2220
>  madvise_cold_or_pageout_pte_range+0x1ea8/0x2360 mm/madvise.c:558
>  walk_pmd_range mm/pagewalk.c:130 [inline]
>  walk_pud_range mm/pagewalk.c:226 [inline]
>  walk_p4d_range mm/pagewalk.c:264 [inline]
>  walk_pgd_range+0xc3d/0x17e0 mm/pagewalk.c:305
>  __walk_page_range+0x15f/0x700 mm/pagewalk.c:412
>  walk_page_range_mm+0x58f/0x7c0 mm/pagewalk.c:505
>  madvise_pageout_page_range mm/madvise.c:617 [inline]
>  madvise_pageout mm/madvise.c:644 [inline]
>  madvise_vma_behavior mm/madvise.c:1266 [inline]
>  madvise_walk_vmas mm/madvise.c:1502 [inline]
>  do_madvise+0x3944/0x4d90 mm/madvise.c:1689
>  __do_sys_madvise mm/madvise.c:1705 [inline]
>  __se_sys_madvise mm/madvise.c:1703 [inline]
>  __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1703
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 14073 at ./include/linux/mm_inline.h:265 lru_gen_add=
_folio+0xad2/0xc30 include/linux/mm_inline.h:265
> Modules linked in:
> CPU: 0 UID: 0 PID: 14073 Comm: syz-executor858 Not tainted 6.13.0-rc1-nex=
t-20241205-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> RIP: 0010:lru_gen_add_folio+0xad2/0xc30 include/linux/mm_inline.h:265
> Code: 44 89 c2 ff ba 01 00 00 00 e9 8b fa ff ff e8 35 89 c2 ff 4c 89 ff 4=
8 c7 c6 c0 c8 13 8c e8 c6 41 0c 00 c6 05 f1 32 27 0e 01 90 <0f> 0b 90 e9 82=
 f6 ff ff 89 d9 80 e1 07 38 c1 0f 8c 19 f7 ff ff 48
> RSP: 0018:ffffc9000e786ce0 EFLAGS: 00010046
> RAX: 72f3d3d7c701e600 RBX: ffffea0000cbb548 RCX: ffffc9000e786803
> RDX: 0000000000000003 RSI: ffffffff8c0aa440 RDI: ffffffff8c5fbe80
> RBP: ffffc9000e786dd8 R08: ffffffff9019d9b7 R09: 1ffffffff2033b36
> R10: dffffc0000000000 R11: fffffbfff2033b37 R12: 0000000000000000
> R13: 1ffffd40001976a8 R14: 0000020000000000 R15: ffffea0000cbb540
> FS:  00007f0542a006c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f05432da864 CR3: 000000002eb56000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  lruvec_add_folio include/linux/mm_inline.h:352 [inline]
>  lru_add+0x704/0xdb0 mm/swap.c:154
>  folio_batch_move_lru+0x26b/0x420 mm/swap.c:168
>  __folio_batch_add_and_move+0x5bb/0xd70 mm/swap.c:196
>  filemap_add_folio+0x24e/0x380 mm/filemap.c:987
>  page_cache_ra_unbounded+0x32c/0x720 mm/readahead.c:263
>  do_async_mmap_readahead mm/filemap.c:3212 [inline]
>  filemap_fault+0x818/0x1490 mm/filemap.c:3311
>  __do_fault+0x135/0x390 mm/memory.c:4978
>  do_read_fault mm/memory.c:5393 [inline]
>  do_fault mm/memory.c:5527 [inline]
>  do_pte_missing mm/memory.c:4048 [inline]
>  handle_pte_fault+0x39eb/0x5ee0 mm/memory.c:5872
>  __handle_mm_fault mm/memory.c:6015 [inline]
>  handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6183
>  faultin_page mm/gup.c:1200 [inline]
>  __get_user_pages+0x1b31/0x4370 mm/gup.c:1495
>  populate_vma_page_range+0x264/0x330 mm/gup.c:1933
>  __mm_populate+0x27a/0x460 mm/gup.c:2036
>  mm_populate include/linux/mm.h:3389 [inline]
>  vm_mmap_pgoff+0x303/0x430 mm/util.c:585
>  ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:545
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0543256069
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 1f 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f0542a00158 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 00007f05432d8708 RCX: 00007f0543256069
> RDX: 0000000001000002 RSI: 0000000000b36000 RDI: 0000000020000000
> RBP: 00007f05432d8700 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000028011 R11: 0000000000000246 R12: 00007f05432d870c
> R13: 0000000000000006 R14: 00007ffce0a6ecb0 R15: 00007ffce0a6ed98
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

