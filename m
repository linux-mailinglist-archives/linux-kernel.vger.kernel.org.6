Return-Path: <linux-kernel+bounces-407439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CDB9C6D70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5926A1F21714
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048CF1FE0EB;
	Wed, 13 Nov 2024 11:09:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D91C8776
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496166; cv=none; b=M2y0z3Nbx/ydKiiBuMpZbjn0iHKs22f+GwrELj2sGMu+JNKJyYeUUI8NzaLBVYEgemklm+0PoKUo8eTtHgkWBdbLvgs8skObCiVUx3m3kS+7hbjQzXVmtUAF0weKkxOL7KUziytskeLWA+ck5XzmB8FBvL/SVrrrmyeWShowey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496166; c=relaxed/simple;
	bh=Z3n0MkozxdLvDabgHIO27oKJv54AUTi6ImE4McQ8nvc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oEGxvH9lqhYIei0lORNCaVYESkXJTsjzcgg5yT+1bxdXMsCgGsKSHJEYCym54o3zNOLtthmz2PJXvRUyYDNprIKP+PiPSEcWXsajhGsx/ziCQvMcSvITBvUnaBKcKZpIseEXPF/4Y4NvtbUcyA/c9a4cgJCDlfRUK40AT4fGtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6bce8a678so75589085ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496164; x=1732100964;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GfF/G9cnhwvMUP6H86DXf6nG/Ikj1CW47KP+JSx0ZUY=;
        b=S6qyTr7uOHM/uNUFNhcwiEt1kmyEgWnChC9yOW0TjLkspP5Tt0vQySdPZTE94jqUog
         +QIkuwt4FtUKzcLlnubyhCjFuVcYlhebAWYJK1vBm68s0yuZtzn45jhnnC9OdWHQUqMM
         3PnmafPFkFvLnD0ea/zYC5PS1SY6+/juAKJmmVBnczwMrzHXce6Dx2XYsySSh7nmwfAP
         NYWpne5qkaCSSXLWPLk2hsfaCIpDFT7/Cj991QvkkBvh8dZCVdWfG6Ez82/JAQA8OUgQ
         hhfMJSO3vIQs1YFpw5+VkqSsLvlFgpMtfEPY05hmbBJphKWiduwjES2kDDYcCvCvLgVc
         +7uA==
X-Forwarded-Encrypted: i=1; AJvYcCUYQ3J865NNJzAynD4Zq56uvIIck0wwyYZP9f/HpTFJkjpbe074WY8I9SI7dFEYR9LCGkIWLIHEsopsNI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz0pJnCExYAtU1yXAYwBG1Kjr8+mopq/zq+5Ubq3/IpiYwDyPZ
	XVp05EPnwqHwxQ6QMkyEgU25OMHzEdBx7Ao9C1WWgfmo0liDw3eo5hcMn1Xp7GzbEdOLkcJnRbS
	HeToBBOKGIXiwGiClkWo+9PnT51V3KeZEH0PwcQeO1dN9s/LQUFfl6mI=
X-Google-Smtp-Source: AGHT+IHH1eyWXxHDHBiknKLp7TDtXntCXptfR6oLh09ETCyVRiQRAfUcnSjHx6Bs2IAd6A3TKNf03NFvySsx+hBeJnI3k3I6O6My
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe3:b0:3a0:a070:b81 with SMTP id
 e9e14a558f8ab-3a71578efe5mr22795055ab.23.1731496164388; Wed, 13 Nov 2024
 03:09:24 -0800 (PST)
Date: Wed, 13 Nov 2024 03:09:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673488e4.050a0220.1324f8.0019.GAE@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in mprotect_fixup / page_vma_mapped_walk
From: syzbot <syzbot+d7f40a3262f9ec8994ed@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3022e9d00ebe Merge tag 'sched_ext-for-6.12-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a441a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=29fedde79f609854
dashboard link: https://syzkaller.appspot.com/bug?extid=d7f40a3262f9ec8994ed
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/12ca7a216979/disk-3022e9d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3afa2bcfd596/vmlinux-3022e9d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a91dd258e5ba/bzImage-3022e9d0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7f40a3262f9ec8994ed@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in mprotect_fixup / page_vma_mapped_walk

write to 0xffff888114e57160 of 8 bytes by task 3992 on cpu 0:
 vm_flags_init include/linux/mm.h:862 [inline]
 vm_flags_reset include/linux/mm.h:874 [inline]
 mprotect_fixup+0x419/0x5e0 mm/mprotect.c:677
 do_mprotect_pkey+0x653/0x960 mm/mprotect.c:838
 __do_sys_mprotect mm/mprotect.c:859 [inline]
 __se_sys_mprotect mm/mprotect.c:856 [inline]
 __x64_sys_mprotect+0x48/0x60 mm/mprotect.c:856
 x64_sys_call+0x26cf/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:11
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888114e57160 of 8 bytes by task 3979 on cpu 1:
 is_vm_hugetlb_page include/linux/hugetlb_inline.h:11 [inline]
 page_vma_mapped_walk+0xa3/0x9f0 mm/page_vma_mapped.c:188
 remove_migration_pte+0x6f9/0x9c0 mm/migrate.c:253
 rmap_walk_anon+0x28f/0x440 mm/rmap.c:2635
 rmap_walk+0x5b/0x70 mm/rmap.c:2713
 remove_migration_ptes mm/migrate.c:373 [inline]
 migrate_folio_move mm/migrate.c:1388 [inline]
 migrate_pages_batch+0x1374/0x1910 mm/migrate.c:1898
 migrate_pages_sync mm/migrate.c:1964 [inline]
 migrate_pages+0xff1/0x1820 mm/migrate.c:2073
 do_mbind mm/mempolicy.c:1390 [inline]
 kernel_mbind mm/mempolicy.c:1533 [inline]
 __do_sys_mbind mm/mempolicy.c:1607 [inline]
 __se_sys_mbind+0xf76/0x1160 mm/mempolicy.c:1603
 __x64_sys_mbind+0x78/0x90 mm/mempolicy.c:1603
 x64_sys_call+0x2b4d/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:238
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000100077 -> 0x0000000000100070

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 3979 Comm: syz.3.175 Not tainted 6.12.0-rc7-syzkaller-00012-g3022e9d00ebe #0
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

