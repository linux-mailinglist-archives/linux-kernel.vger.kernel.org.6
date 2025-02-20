Return-Path: <linux-kernel+bounces-524564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A30A3E4AC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C56176419
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827F92638B8;
	Thu, 20 Feb 2025 19:03:26 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031C1B0F33
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078206; cv=none; b=dymqZlh1DWEnsBaV+Zk17I3adFKfCNQrCWJppn4kA+6M2pRVF05gDYD/FKp2q6V/qKl3gfgbgQ6oMqMfAFuWoQzy1TgwrssBbH2XgnDLYGJxRVWAXH6oNTvNZYxRFnytblUModm1K2YcVWbcqID3OrgzCn0h0kO0V6MWXOX2P88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078206; c=relaxed/simple;
	bh=pjaVZ7h2xHDHp+S+7Um3H5KF/jRsSnILJn9vFF6WfBc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F5CbTFzyGzcgEdwyke0sxlBxc7Y3YE/JgrSkmG3MetbsSa+FLFksX1T/uSGQV2VLuQKZpL/PnGlByTSfbHFOMrPbqghvJpynJbJm8DQkBm+LM5n/QX37cd0TzQxoPdVvgykyAMux/qDNU1Q9JgmLC3w/Z40XtasBQmygG4M9gCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d18a1a0f0eso24134375ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740078203; x=1740683003;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBLPdUkUuOxJLmRb6Ixy1bEhg+CsgnET/X0DsxrXVEc=;
        b=npB0f7pu6nn8lslff7gLfM8t28Yv45iTuOLwyoTgqYzKc0OeD/xvFtVQ12QlYGTqqi
         j1SIUu/7FwTZosqOPCDv7B3QsRB1KagyrQ3gGuHlw/g0kbqDjHheXjSmXy0QFOLzlcu2
         YAkMC9ccbKwYijgJwBzWRlV6tSgGJLue+OJbeJZAU8ZzPzO3FljqZ41t1IiEORrvPYe8
         qRi4mS/cFb5OlweiKIHYkQ/POIrqLILwdcxov06jaeBXRtkT8aHuyKMh+uNl/7Hm+5g0
         e6WP1q8PboV81HmZsCjdMiB+AVXLlmFBnH31miXRB/N1Ljh7JrX6DTglBBty3JfIYbHc
         2ygA==
X-Forwarded-Encrypted: i=1; AJvYcCWFffLPH82KmdaZHA8tPA0z+tk7W87mgmewxfSi5WaNFBCKZJb/9zwNoo6D/9TKr8RvPoQhr+FpY2T/Zms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLE8QTHkJs9u4Iy7zw4iyly8QxTOeTLQSZiVZYXMH+5zXN2XYu
	uFGbTKvECYjDq4EF7jQ90Jc78F1F91bC9l7Ve8Evvu4DvDlrM29Ok1yYgHSmVdqflFwZeZxdfMt
	7286g2FRg2C3rNYLSJ0UupnmrkmSV5n6S01HGJoYUcE2ApKbrjkxZPHw=
X-Google-Smtp-Source: AGHT+IGGHCpVZo36dWll5wbmWtcdubDw8cgF/FOwS4Ht+Kr8Yv5c0BNyJPK4JHJv+vkkuj4MwDhAugrx13LJ4m06n+aWDkWzIpW9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3113:b0:3d2:b509:af44 with SMTP id
 e9e14a558f8ab-3d2cae6c9damr2785355ab.8.1740078203139; Thu, 20 Feb 2025
 11:03:23 -0800 (PST)
Date: Thu, 20 Feb 2025 11:03:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b77c7b.050a0220.14d86d.02f5.GAE@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in __unmap_hugepage_range / free_huge_folio
From: syzbot <syzbot+4769dec94e62d3835199@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    87a132e73910 Merge tag 'mm-hotfixes-stable-2025-02-19-17-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f42ba4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce4e433ac2a58cc2
dashboard link: https://syzkaller.appspot.com/bug?extid=4769dec94e62d3835199
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9b9e85cfddf6/disk-87a132e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6199597ac06c/vmlinux-87a132e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80e28e7cab63/bzImage-87a132e7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4769dec94e62d3835199@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __unmap_hugepage_range / free_huge_folio

read-write to 0xffffffff88c2b1f8 of 8 bytes by task 8563 on cpu 0:
 remove_hugetlb_folio mm/hugetlb.c:1540 [inline]
 free_huge_folio+0x81a/0xae0 mm/hugetlb.c:1869
 folios_put_refs+0x1ce/0x2b0 mm/swap.c:975
 free_pages_and_swap_cache+0x3c7/0x400 mm/swap_state.c:334
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:389 [inline]
 tlb_flush_mmu+0x2cf/0x440 mm/mmu_gather.c:396
 zap_pte_range mm/memory.c:1781 [inline]
 zap_pmd_range mm/memory.c:1834 [inline]
 zap_pud_range mm/memory.c:1863 [inline]
 zap_p4d_range mm/memory.c:1884 [inline]
 unmap_page_range+0x21db/0x2660 mm/memory.c:1905
 unmap_single_vma+0x142/0x1d0 mm/memory.c:1951
 unmap_vmas+0x18d/0x2b0 mm/memory.c:1995
 exit_mmap+0x1ae/0x6d0 mm/mmap.c:1284
 __mmput+0x28/0x1d0 kernel/fork.c:1356
 mmput+0x4c/0x60 kernel/fork.c:1378
 exit_mm+0xe4/0x190 kernel/exit.c:570
 do_exit+0x559/0x17f0 kernel/exit.c:925
 do_group_exit+0x142/0x150 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x1f/0x20 kernel/exit.c:1096
 x64_sys_call+0x2db8/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffffffff88c2b1f8 of 8 bytes by task 8570 on cpu 1:
 __unmap_hugepage_range+0xbff/0x18c0 mm/hugetlb.c:5644
 unmap_single_vma+0x1c7/0x1d0 mm/memory.c:1947
 unmap_vmas+0x18d/0x2b0 mm/memory.c:1995
 exit_mmap+0x1ae/0x6d0 mm/mmap.c:1284
 __mmput+0x28/0x1d0 kernel/fork.c:1356
 mmput+0x4c/0x60 kernel/fork.c:1378
 exit_mm+0xe4/0x190 kernel/exit.c:570
 do_exit+0x559/0x17f0 kernel/exit.c:925
 do_group_exit+0x142/0x150 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x1f/0x20 kernel/exit.c:1096
 x64_sys_call+0x2db8/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000000003 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 8570 Comm: syz.4.1159 Not tainted 6.14.0-rc3-syzkaller-00079-g87a132e73910 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
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

