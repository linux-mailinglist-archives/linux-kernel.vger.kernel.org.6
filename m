Return-Path: <linux-kernel+bounces-394760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFDE9BB38D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C2F280A07
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83571B21A8;
	Mon,  4 Nov 2024 11:35:35 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C9D185B4D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720135; cv=none; b=j2GCFETxADVpPcXrmdjb0rWZyCyBVJUxHEUocm8gE0Q2v2Cm8AatkZ3BlK5Tq2weyvSo2YvpvbCeEkBmSn7O1xH+pppHF155Bhg7+XjCuHlMPrF5Oqsl+FtuHanXhZ+NlzP/vMCzGleC9qkfus7ux0X8n5efvPHOgOvgSLXuUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720135; c=relaxed/simple;
	bh=OHBG4OEwX/Wpld6uz4ZI6uDEOqFujz/C2wKViIpLh2A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Axd6JB8VINQueM0YEMBqRYnYUSonIyMcUHxW7ojqgmdDASQvyJbAOhpWifuWZnDtltBlhgmBacb7nO+R4prcWB+tvXK8UXsqRm5Bv9+lX5AuIjwRBgQxfsFk+4eTiEMtqHRQYSUpCUqU12JhtRkGaA9o2G+zCEmTY/Cw/GS8PmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6c01d8df2so14169975ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730720133; x=1731324933;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UptIliFZChOeMXB7Ne+Yu8LqoPvW5e985cSbeic1VQ=;
        b=YCp2MJoC9IzfNM1ai2NfQiFMnex4iADITv4TGo5yJNxkqIy/+anFGuK+SHZB5xTPsT
         3l8LSfNEwB6pLAZ++oYXixNa+wr87APmZu3KFd3vfTz7wLmBxzgdYY7C1PHz9qRQg/+f
         9MZQVbDtYrs+p/C0j0f8CLHl6Edl0jyTWUD8K7xJ9/wMDf9gTiLTMbd/EadTFRxwCql1
         eSWNOtwJC+4N+GZU9q+jXKfaoMfyv1+Lod7V5vxi6bqK9ZDZTwwVhRmi7cezlRfBnBrO
         RZnerixXS4WqjafzIto9p+U6VyoPIMnNjjPz4K+1ow2jJ8idoeHOejDNY580ZYc1jROC
         Z0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWDjbd0XXerE+gt4/QMCIrWbuFZBet26orlnh0ciasNGGVYild7Na/Z+nyCSqU6jTajUkom3pnkn5Dlxcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/4JoDiHMxIUtEMb5W3tzXtQyPcNdxrGbjBjofRL/WFcm27UNQ
	/842SDdPul+KlTWnTcrHwxX8hocffGwUyVNHk1YbqhLKUEoQiUIItCcdq212Qe+JnvkY+6rrjz2
	cKCMhNUhceawP1mhcL8mQzaBrts6QRFIklPVir0VHZT0cRb/I1m+VVGU=
X-Google-Smtp-Source: AGHT+IEiKhr737ZJnP5j9aALAImq5N1qcIG+8qAYeuNodyWOd8c3v18+XqUrwTqqRG2tEnoHpr+n1NH1PUKrB9XZ/RGcTNAJtTR1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:339f:b0:3a0:9c04:8047 with SMTP id
 e9e14a558f8ab-3a6a94a3944mr111711025ab.6.1730720132927; Mon, 04 Nov 2024
 03:35:32 -0800 (PST)
Date: Mon, 04 Nov 2024 03:35:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6728b184.050a0220.35b515.01bc.GAE@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in folios_put_refs / need_mlock_drain (2)
From: syzbot <syzbot+716d26ee203ef06cc21d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a33ab3f94f51 Merge tag 'kbuild-fixes-v6.12-2' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15968740580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd88d664711c92e2
dashboard link: https://syzkaller.appspot.com/bug?extid=716d26ee203ef06cc21d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/343e78270f3d/disk-a33ab3f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/519a20c354c1/vmlinux-a33ab3f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad9fc0bdb450/bzImage-a33ab3f9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+716d26ee203ef06cc21d@syzkaller.appspotmail.com

EXT4-fs (loop3): unmounting filesystem 00000000-0000-0000-0000-000000000000.
==================================================================
BUG: KCSAN: data-race in folios_put_refs / need_mlock_drain

write to 0xffff888237c2b590 of 1 bytes by task 4698 on cpu 0:
 folio_batch_reinit include/linux/pagevec.h:50 [inline]
 folios_put_refs+0x26d/0x2b0 mm/swap.c:1001
 folios_put include/linux/mm.h:1537 [inline]
 mlock_folio_batch+0x319d/0x31d0 mm/mlock.c:209
 mlock_folio+0x1b7/0x210 mm/mlock.c:259
 mlock_vma_folio mm/internal.h:881 [inline]
 __folio_add_anon_rmap mm/rmap.c:1352 [inline]
 folio_add_anon_rmap_ptes+0x219/0x220 mm/rmap.c:1375
 remove_migration_pte+0x5cb/0x960 mm/migrate.c:332
 rmap_walk_anon+0x28f/0x440 mm/rmap.c:2638
 rmap_walk+0x5b/0x70 mm/rmap.c:2716
 remove_migration_ptes mm/migrate.c:372 [inline]
 migrate_folio_move mm/migrate.c:1387 [inline]
 migrate_pages_batch+0x13a3/0x1950 mm/migrate.c:1897
 migrate_pages_sync mm/migrate.c:1963 [inline]
 migrate_pages+0xff1/0x1820 mm/migrate.c:2072
 do_mbind mm/mempolicy.c:1390 [inline]
 kernel_mbind mm/mempolicy.c:1533 [inline]
 __do_sys_mbind mm/mempolicy.c:1607 [inline]
 __se_sys_mbind+0xf76/0x1160 mm/mempolicy.c:1603
 __x64_sys_mbind+0x78/0x90 mm/mempolicy.c:1603
 x64_sys_call+0x2b4d/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:238
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888237c2b590 of 1 bytes by task 3315 on cpu 1:
 folio_batch_count include/linux/pagevec.h:56 [inline]
 need_mlock_drain+0x30/0x50 mm/mlock.c:235
 cpu_needs_drain mm/swap.c:792 [inline]
 __lru_add_drain_all+0x22a/0x3f0 mm/swap.c:880
 lru_add_drain_all+0x10/0x20 mm/swap.c:896
 invalidate_bdev+0x47/0x70 block/bdev.c:101
 ext4_put_super+0x571/0x840 fs/ext4/super.c:1349
 generic_shutdown_super+0xe5/0x220 fs/super.c:642
 kill_block_super+0x2a/0x70 fs/super.c:1710
 ext4_kill_sb+0x44/0x80 fs/ext4/super.c:7320
 deactivate_locked_super+0x7d/0x1c0 fs/super.c:473
 deactivate_super+0x9f/0xb0 fs/super.c:506
 cleanup_mnt+0x268/0x2e0 fs/namespace.c:1373
 __cleanup_mnt+0x19/0x20 fs/namespace.c:1380
 task_work_run+0x13a/0x1a0 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x01 -> 0x00

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 3315 Comm: syz-executor Not tainted 6.12.0-rc5-syzkaller-00330-ga33ab3f94f51 #0
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

