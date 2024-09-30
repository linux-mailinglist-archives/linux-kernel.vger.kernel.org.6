Return-Path: <linux-kernel+bounces-343497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43389989BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B4EB21183
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3266015C15E;
	Mon, 30 Sep 2024 07:39:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B204594C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681966; cv=none; b=iZqBMf/PiYCvw7YW86HIgsG0ZftQrQb2Q+PZuTwQQGrHBDsHXDWmIYULNsuY0FGohSPXRsSFKOVpQCcJPBnsrhdVKtlZVznuXjm+NVekwLCFsfhISvVTUhbb9AAuDMCS2g00oEkVrwP2eryoATH/z7F97qeHFHyCKX7xu2shvHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681966; c=relaxed/simple;
	bh=ppeDP3ZfKktrbcpJpF4u33fVNgpQ2NsHwd5SApx42zs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r142+rFFKSMwI0MASl52MktaBTQEOIUKtuyKKZFwwDMyiLe48XWZnoqYim0vkxoz1Zab2xjFqYXj0ykmgpnw4r1bBSZjV4dS4DFWywEW7zYY0fTQ+9hejDPFu/Zzr1V0Uwmwa3Nx8xW7Uyx9bnM6kJDzSIQNIAqDEAuwWJcidVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0cd6a028bso39842095ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727681964; x=1728286764;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GgLUVNbUEZz2+hkyr6hqgwa5F9rxcG2NTv3X8io4PaY=;
        b=WwvqdqN3J0w81p9tHAYdV05Igiy70eXv/BHfD2LuSRDsoneP0JlRFfEN/qjWV8Bz9t
         BwmyFHiJKabVBBl010XUPCVfCurSDSPmFA9FXL4/7evg5N0IOwii8GA+9GLQts1m/pQu
         vk/nM0Pmgao+2o81F4eKOXmLTks4dBvTGpJGKv1bHmFEMVglGvg70V2jRZHUHi+BAxWK
         HiXgFKehtX0l/G4O58s4c7sev/H0iw3IsHDArtgMufsyiF9EDPVuDtl/i+HJH08CqfzO
         kxusYEkoxOMk9j2sFVh0p7NmKq/hMSmyFtwHE9N4Wax1llQnzxwsGa2L7u8Wt4ikUwzi
         34iA==
X-Forwarded-Encrypted: i=1; AJvYcCXysOXg/K1XOLqzg4TA/baO9JPmCV+hhlaSWG82t6LMM8yCp7QHjY+B7jM/BMWwBRuNIPo1+yocFn0gFGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9QpK8xRNpgOeIPBqEexJ59nmaJco3hrAFUywLCkIb4mLRRux
	g2NshZraBc4t7WOhHRcXCl2QTDYSdrZSSLOsiWMEpK2WYdHvezQ9QPhSM3cCVQFb7E1v9Jz3glL
	1EqZQzmSMvdJx1wnjMQgOXjgNN26nfcYBU7pPjgkKCRoE6C5Y01FFnqQ=
X-Google-Smtp-Source: AGHT+IF2Up2eQssBjfsdXdQYa1tD7f4uNpLEUg57ZzwwTQ53d02C8KNLE4KcxLLjqfCZSxdeao8XMcZ0Qu4/yhTe6XkO36kEJ0WO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198f:b0:3a2:7651:9878 with SMTP id
 e9e14a558f8ab-3a345179e49mr88406515ab.12.1727681964556; Mon, 30 Sep 2024
 00:39:24 -0700 (PDT)
Date: Mon, 30 Sep 2024 00:39:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fa55ac.050a0220.aab67.002a.GAE@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in exec_mmap / vms_clear_ptes
From: syzbot <syzbot+d207c41e97001109b49d@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e7ed34365879 Merge tag 'mailbox-v6.12' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15238ea9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bfe37bd3f5983d6
dashboard link: https://syzkaller.appspot.com/bug?extid=d207c41e97001109b49d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c86c1297298e/disk-e7ed3436.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8313c0846b3b/vmlinux-e7ed3436.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8af10d85db09/bzImage-e7ed3436.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d207c41e97001109b49d@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in exec_mmap / vms_clear_ptes

write to 0xffff888102fbaae8 of 8 bytes by task 3004 on cpu 1:
 update_hiwater_rss include/linux/mm.h:2655 [inline]
 vms_clear_ptes+0x1a7/0x300 mm/vma.c:1088
 vms_complete_munmap_vmas+0x170/0x480 mm/vma.c:1140
 do_vmi_align_munmap+0x349/0x390 mm/vma.c:1349
 do_vmi_munmap+0x1eb/0x230 mm/vma.c:1397
 __vm_munmap+0xfd/0x220 mm/mmap.c:1600
 __do_sys_munmap mm/mmap.c:1617 [inline]
 __se_sys_munmap mm/mmap.c:1614 [inline]
 __x64_sys_munmap+0x36/0x40 mm/mmap.c:1614
 x64_sys_call+0xd32/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:12
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888102fbaae8 of 8 bytes by task 5494 on cpu 0:
 get_mm_hiwater_rss include/linux/mm.h:2642 [inline]
 setmax_mm_hiwater_rss include/linux/mm.h:2672 [inline]
 exec_mmap+0x2d0/0x440 fs/exec.c:1012
 begin_new_exec+0xaf9/0x10b0 fs/exec.c:1280
 load_elf_binary+0x63b/0x19e0 fs/binfmt_elf.c:996
 search_binary_handler fs/exec.c:1752 [inline]
 exec_binprm fs/exec.c:1794 [inline]
 bprm_execve+0x4e6/0xc30 fs/exec.c:1845
 do_execveat_common+0x793/0x800 fs/exec.c:1952
 do_execve fs/exec.c:2026 [inline]
 __do_sys_execve fs/exec.c:2102 [inline]
 __se_sys_execve fs/exec.c:2097 [inline]
 __x64_sys_execve+0x5a/0x70 fs/exec.c:2097
 x64_sys_call+0x1277/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:60
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x000000000000022b -> 0x000000000000024b

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 5494 Comm: dhcpcd Not tainted 6.11.0-syzkaller-12113-ge7ed34365879 #0
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

