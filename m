Return-Path: <linux-kernel+bounces-244160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A6D929FFD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FAA1F2507C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C974E59164;
	Mon,  8 Jul 2024 10:15:20 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF61D2E3F2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433720; cv=none; b=uN88l7WljA+qku50PjXjNRnmGS9QdokekO0fWK6ZeWljE2aE9yFaNwFP6aYJECBE8ThBlc78tI/GcQeGXBTNloYj8Fi1bPfeNe2fjODMTB4k4nN8yCppu+pF9fB6dm3o2Mnp96d5cqVX4QryaS8fBbm7lJ7ospcLyS1eTNlE/cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433720; c=relaxed/simple;
	bh=P+A8E0zkZTYhke4a2Ujh2jGsSdr3lzUCZCw10OWxTsQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dEk1HniuNuIc2KI0G6e7XqbKLI8Lim+lKzfk2dzrhkZqZeM8hyAJueR8TFMe/xeY8WOowOtIl+2SObWpSi4ZTSn8s6EHpIMgvZmqsjC0D54bS3lEHnPtgHcp4jGHF7A3VMJLhZsyJZ0VcoXWjHC8AtRz8YrKfa9/AEWvJcQm8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7fb19ed628aso200996639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 03:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720433718; x=1721038518;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mGfZ/xlazb6vQbChhVhL7rFha/pF23EZgGn4WVNLNJs=;
        b=BsH4OnXSCetg0LbeEK87rPH7CpvtAP4BdE8y4otVMMPOeEv45s4Y8YBQaxYvbvqh9u
         SFj9G+6pcVOUjMIhgNMbnHmgpvxStwIdHJX1w0bzm07dX0tG0P2xEcFxCVT0Ev1jw2gf
         YvgWVbgri2iU0sEQ47vTlPAo1jVtkA9b+Qvpx/KqxKBIHvonGu/jUQ39QhMA08KVtxV0
         E4+mS3lLJteGfftAf6IMilpLGY2HwXh+CBbK64S9huEBAYrv6+8EC1G2sI/xwTm90bUg
         RhUTYWoNRWaPFOSpO0r/+aY7R0JP6Xvr1bttz/f8vbqAH3s8DvQFir1Zvg1kqb1K+u/W
         OVuw==
X-Forwarded-Encrypted: i=1; AJvYcCVUoKTw2FjrdGC8Pxwh4SeYNMT3z2jZ/tVfbYTkEARgEIaBlOI2B/vPj2+uBwmdlRWaqWhOwH02F6lr13+pQotsYTrz65B5ZWTH767A
X-Gm-Message-State: AOJu0YxoRiECPoKpckrA132VpdOA3BQhTiHen8LiexsIqB8HvxpXc5TH
	/4UZ0dTUQk7KLFxokhIiZuLFbCMNBbDkGaa0waqvI54UofAIWmH4ffIxuhE8skUJ6oUk7dq7c69
	ayZWRws0bxE8JmNnblfBXB5ymcqC4ViWG8+SHlLebVlQKeQYvms36m70=
X-Google-Smtp-Source: AGHT+IE0zhQknJ2gUGYF46ymFvAofXGJ2CUZ/XwesLS/ICqk5AxE8wI617eYEMR2Ohhzx5PgJ8iIAL+Jdhd1k/W88KDxH3qBnYce
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:370c:b0:4c0:a8a5:81dc with SMTP id
 8926c6da1cb9f-4c0a8a58dc1mr86879173.6.1720433717767; Mon, 08 Jul 2024
 03:15:17 -0700 (PDT)
Date: Mon, 08 Jul 2024 03:15:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b85eb061cb9b0fc@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in __swap_writepage /
 scan_swap_map_slots (2)
From: syzbot <syzbot+da25887cc13da6bf3b8c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    256abd8e550c Linux 6.10-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106f73b9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d41a21b8562873d8
dashboard link: https://syzkaller.appspot.com/bug?extid=da25887cc13da6bf3b8c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb12c934492f/disk-256abd8e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a25b9e666500/vmlinux-256abd8e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef2e7d0332d0/bzImage-256abd8e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da25887cc13da6bf3b8c@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __swap_writepage / scan_swap_map_slots

read-write to 0xffff888103c5ee10 of 8 bytes by task 12496 on cpu 0:
 scan_swap_map_slots+0x51/0x10e0 mm/swapfile.c:868
 get_swap_pages+0x30b/0x480 mm/swapfile.c:1115
 folio_alloc_swap+0x3b7/0x490 mm/swap_slots.c:346
 shmem_writepage+0x43e/0x970 mm/shmem.c:1493
 pageout mm/vmscan.c:660 [inline]
 shrink_folio_list+0x194f/0x2560 mm/vmscan.c:1341
 shrink_inactive_list mm/vmscan.c:1944 [inline]
 shrink_list mm/vmscan.c:2179 [inline]
 shrink_lruvec+0xbd9/0x15f0 mm/vmscan.c:5703
 shrink_node_memcgs mm/vmscan.c:5889 [inline]
 shrink_node+0x9d1/0x13c0 mm/vmscan.c:5924
 shrink_zones mm/vmscan.c:6168 [inline]
 do_try_to_free_pages+0x3c6/0xc50 mm/vmscan.c:6230
 try_to_free_mem_cgroup_pages+0x1eb/0x4e0 mm/vmscan.c:6545
 try_charge_memcg+0x27a/0xcd0 mm/memcontrol.c:2944
 try_charge mm/memcontrol.c:3092 [inline]
 charge_memcg mm/memcontrol.c:7495 [inline]
 __mem_cgroup_charge+0x63/0x100 mm/memcontrol.c:7510
 mem_cgroup_charge include/linux/memcontrol.h:691 [inline]
 shmem_alloc_and_add_folio mm/shmem.c:1677 [inline]
 shmem_get_folio_gfp+0x480/0xb70 mm/shmem.c:2055
 shmem_get_folio mm/shmem.c:2160 [inline]
 shmem_write_begin+0xa0/0x1c0 mm/shmem.c:2743
 generic_perform_write+0x1d5/0x410 mm/filemap.c:4015
 shmem_file_write_iter+0xc8/0xf0 mm/shmem.c:2919
 __kernel_write_iter+0x24f/0x4e0 fs/read_write.c:523
 dump_emit_page fs/coredump.c:893 [inline]
 dump_user_range+0x3a7/0x550 fs/coredump.c:954
 elf_core_dump+0x1aeb/0x1c30 fs/binfmt_elf.c:2083
 do_coredump+0xff6/0x1860 fs/coredump.c:767
 get_signal+0xdc1/0x1080 kernel/signal.c:2894
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x94/0x130 kernel/entry/common.c:231
 irqentry_exit+0x12/0x50 kernel/entry/common.c:334
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

read to 0xffff888103c5ee10 of 8 bytes by task 12516 on cpu 1:
 __swap_writepage+0x88/0xc50 mm/page_io.c:387
 swap_writepage+0xa9/0x160 mm/page_io.c:209
 shmem_writepage+0x7be/0x970 mm/shmem.c:1518
 pageout mm/vmscan.c:660 [inline]
 shrink_folio_list+0x194f/0x2560 mm/vmscan.c:1341
 shrink_inactive_list mm/vmscan.c:1944 [inline]
 shrink_list mm/vmscan.c:2179 [inline]
 shrink_lruvec+0xbd9/0x15f0 mm/vmscan.c:5703
 shrink_node_memcgs mm/vmscan.c:5889 [inline]
 shrink_node+0x9d1/0x13c0 mm/vmscan.c:5924
 shrink_zones mm/vmscan.c:6168 [inline]
 do_try_to_free_pages+0x3c6/0xc50 mm/vmscan.c:6230
 try_to_free_mem_cgroup_pages+0x1eb/0x4e0 mm/vmscan.c:6545
 try_charge_memcg+0x27a/0xcd0 mm/memcontrol.c:2944
 try_charge mm/memcontrol.c:3092 [inline]
 charge_memcg mm/memcontrol.c:7495 [inline]
 __mem_cgroup_charge+0x63/0x100 mm/memcontrol.c:7510
 mem_cgroup_charge include/linux/memcontrol.h:691 [inline]
 shmem_alloc_and_add_folio mm/shmem.c:1677 [inline]
 shmem_get_folio_gfp+0x480/0xb70 mm/shmem.c:2055
 shmem_get_folio mm/shmem.c:2160 [inline]
 shmem_write_begin+0xa0/0x1c0 mm/shmem.c:2743
 generic_perform_write+0x1d5/0x410 mm/filemap.c:4015
 shmem_file_write_iter+0xc8/0xf0 mm/shmem.c:2919
 __kernel_write_iter+0x24f/0x4e0 fs/read_write.c:523
 dump_emit_page fs/coredump.c:893 [inline]
 dump_user_range+0x3a7/0x550 fs/coredump.c:954
 elf_core_dump+0x1aeb/0x1c30 fs/binfmt_elf.c:2083
 do_coredump+0xff6/0x1860 fs/coredump.c:767
 get_signal+0xdc1/0x1080 kernel/signal.c:2894
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x94/0x130 kernel/entry/common.c:231
 irqentry_exit+0x12/0x50 kernel/entry/common.c:334
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

value changed: 0x0000000000004083 -> 0x0000000000008083

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 12516 Comm: syz.2.2868 Not tainted 6.10.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
==================================================================


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

