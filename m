Return-Path: <linux-kernel+bounces-347096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CDF98CDBC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0E91F25B09
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6796D19408D;
	Wed,  2 Oct 2024 07:26:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E941193436
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727853987; cv=none; b=VQaeyWPMT7uXA1Yb48dxR6AvmWt+dSlNhNAE/EcZ2+AjqR8Do6PUidVg0ssiMFYiyecz8KR5HPo4RqVTXOiJHSFNpYQOPsc5apDtRAVYR175Zy9Lumdv3p2P2mNJvWXxZ+F7qp4lcaQVo5VqW5/fbz0ZTk7pEC9GrvYxzYdJwI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727853987; c=relaxed/simple;
	bh=umMswd2F2ohwABWsHIt6LJNdW/sLL9M0uFUVb9NspSU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Dl8nU0WlBPp30K104kiQbxYTTSo8OrXCuopd5RplApilgKrXG+KAsJWkwOubvlRTY0RAS8oeaFBxZoeJs+D+VTxheuDgBbD48SNTN3iDUvlNHtLtfHhgxLU2csAGEVrvmsVhphXP88fAsZARI8ffMH51lyfBh49wYTFLmh3me+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3453139c0so71463065ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 00:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727853984; x=1728458784;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LbbE8eh5cTmPIqT26Qz6vKp4nWVe300giiz3mIwwiEo=;
        b=q/ug7GJ04NJY8VBTQdyKKNo6n/GRZ4vQ+0F0VZE1N6KyxDfbcm9R4Caz2ghlFWn2/X
         rz6uLOEy0O4WK9jpFhwCMDDDvRuzAnqh8HZDdCvMKpeeHuuiJ2JmiPr9oGXkDh0ui8Zc
         GHaHw2FxVMTdnSsDvZoKyCGB77QpRGJk0yVA0gQM6H7N33cTY+YaXpgUShxTmtnAXMKe
         vWtpiGyxBLuy4pF5ABwjHqWrmraAF7al2DTh9QZ3Ka9AESlMPianJHagxc03isdFvdk+
         jgXBrdBnmpzIgZHSSSnM32LVzm90l41fhv5rtNHXNfJoeBoYbQQJjArhdfq+yfCRWi+C
         Wxkw==
X-Forwarded-Encrypted: i=1; AJvYcCWpG+H4okoQcOexWWOq1P0PXBe5oEM/AJCcHooGpgwoH+goh2skFvUX5QhvDdyWijnW3MgQp8IjQ1+z5BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOK3ZYy5r7VPaeN8ZJXKLDOMayYOqrw1BX9+Ma6iDYcD2dOKNL
	H5YUPrf+lF5VqGh3hHC6tFSQFJsmwC35VyJR+fGRgBHVjcTcrkqFlmJWttnxXK+/yFjU0wqWwVC
	32AQfLH4x5mYIic5cQ/sXXdOzZrFGe+Ve3ELijPh0wVchD3XC6BwvHkc=
X-Google-Smtp-Source: AGHT+IE4OLPhL0tnMdKOg7rG2jCk6XNPx7YtSwZuhpA8OoVM0aBCYJVq5ocbOfSDByGdjonexhXz+646W2RSMza6S9b/KN8pbJhz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:3a3:4164:eec9 with SMTP id
 e9e14a558f8ab-3a36592dd12mr20437755ab.14.1727853984390; Wed, 02 Oct 2024
 00:26:24 -0700 (PDT)
Date: Wed, 02 Oct 2024 00:26:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fcf5a0.050a0220.f28ec.04fa.GAE@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in __delete_from_swap_cache / __try_to_reclaim_swap
From: syzbot <syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10fb8307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13af6e9c27c7bbbf
dashboard link: https://syzkaller.appspot.com/bug?extid=fa43f1b63e3aa6f66329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e728901b4154/disk-e32cde8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e662806fa232/vmlinux-e32cde8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed885d1a3f98/bzImage-e32cde8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __delete_from_swap_cache / __try_to_reclaim_swap

write to 0xffffea0004c90328 of 8 bytes by task 5186 on cpu 0:
 __delete_from_swap_cache+0x1f0/0x290 mm/swap_state.c:163
 delete_from_swap_cache+0x72/0xe0 mm/swap_state.c:243
 folio_free_swap+0x1d8/0x1f0 mm/swapfile.c:1850
 free_swap_cache mm/swap_state.c:293 [inline]
 free_pages_and_swap_cache+0x1fc/0x410 mm/swap_state.c:325
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x2cf/0x440 mm/mmu_gather.c:373
 zap_pte_range mm/memory.c:1700 [inline]
 zap_pmd_range mm/memory.c:1739 [inline]
 zap_pud_range mm/memory.c:1768 [inline]
 zap_p4d_range mm/memory.c:1789 [inline]
 unmap_page_range+0x1f3c/0x22d0 mm/memory.c:1810
 unmap_single_vma+0x142/0x1d0 mm/memory.c:1856
 unmap_vmas+0x18d/0x2b0 mm/memory.c:1900
 exit_mmap+0x18a/0x690 mm/mmap.c:1864
 __mmput+0x28/0x1b0 kernel/fork.c:1347
 mmput+0x4c/0x60 kernel/fork.c:1369
 exit_mm+0xe4/0x190 kernel/exit.c:571
 do_exit+0x55e/0x17f0 kernel/exit.c:926
 do_group_exit+0x102/0x150 kernel/exit.c:1088
 get_signal+0xf2a/0x1070 kernel/signal.c:2917
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x59/0x130 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffffea0004c90328 of 8 bytes by task 5189 on cpu 1:
 __try_to_reclaim_swap+0x9d/0x510 mm/swapfile.c:198
 free_swap_and_cache_nr+0x45d/0x8a0 mm/swapfile.c:1915
 zap_pte_range mm/memory.c:1656 [inline]
 zap_pmd_range mm/memory.c:1739 [inline]
 zap_pud_range mm/memory.c:1768 [inline]
 zap_p4d_range mm/memory.c:1789 [inline]
 unmap_page_range+0xcf8/0x22d0 mm/memory.c:1810
 unmap_single_vma+0x142/0x1d0 mm/memory.c:1856
 unmap_vmas+0x18d/0x2b0 mm/memory.c:1900
 exit_mmap+0x18a/0x690 mm/mmap.c:1864
 __mmput+0x28/0x1b0 kernel/fork.c:1347
 mmput+0x4c/0x60 kernel/fork.c:1369
 exit_mm+0xe4/0x190 kernel/exit.c:571
 do_exit+0x55e/0x17f0 kernel/exit.c:926
 __do_sys_exit kernel/exit.c:1055 [inline]
 __se_sys_exit kernel/exit.c:1053 [inline]
 __x64_sys_exit+0x1f/0x20 kernel/exit.c:1053
 x64_sys_call+0x2d46/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:61
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000000242 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 5189 Comm: syz.1.320 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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

