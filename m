Return-Path: <linux-kernel+bounces-169097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BC88BC315
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 20:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7061C209A0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6283F50297;
	Sun,  5 May 2024 18:37:37 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3BC3D551
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714934256; cv=none; b=pCOieqUykpAUcm4DpAFXSAGRUwLory9nEkQXTX4TU5Vw10Qq9dTpFSrxBzWIsR/fqezWNBTFTfEC29uNdmXpb8r0Md9zyXEq46GDafPQZUUMfaJfoEdZHSo8Sbr3kfXYaOpvD7EAmzTybcvJwNP9hDLmHHdVPj8zLcgHdnjavqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714934256; c=relaxed/simple;
	bh=rIHGdQFdNWPnE6F0SLsy4gSSPDodFev6wOR692pv7HY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NEXdASVQEdbpf6RdXpOyLkPTErVWvE0QV6R4/VqZ9afTIJ2wf7dQj5QXfFiikNBIcVUbnNL4bIPYEpsTNyxMV9Ir+6v3ISTZ8yWaEsSeKqkWujLhQU9wQkR60TNQz9dFkyo089vND6CnhLpRAADNkM7TIbp1GlmhGaYSdMvDrsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7dee81b7e97so162280539f.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 11:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714934254; x=1715539054;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxrQansCNFWHc22V6bE5WpRINUbEc687WN0kd8ydpBE=;
        b=SWuF9yEQpRE66ARSkP2/ys3KPX7H8u9AdBsczWdGvhW4cb876RS0BUNij05UQNV2c+
         9By42aWBBdrbmEjgZ8T+TdYDAGGcI4vtGXyNktwO3vKqk+xs6mCefgXBqPve9CaCQBex
         MkJbskXcciN7M28I4J+Kw67ZNUS2qwXBQFWcpZAbOZeB0SHINUKPlNhMUEHhwnlZecSD
         3GjVp5KVFptcoLQqjPHTNXBgXiMB0Fkbdl0e88z9SR0FkUM31KDWomHXKrv+lxRfbc1f
         pHKDyIrllVboridBY6mLCVvrWnX4JxN4ImmnLYLMDWz/Oq4PqHY2tHNr/1ayGsemTlIM
         HvCw==
X-Forwarded-Encrypted: i=1; AJvYcCUWcC9Z9iH5jPwrr8qzSwci+sXyS0kQ7RyJsD9getsIJL/zVWv4P5dYKAGh2yZp0cupYKXE69+f7WiyC8qf8/AA5CH+kjAst7SUFp/5
X-Gm-Message-State: AOJu0Ywnpz0KzpUsuQFMcpCMi7eMrEUJhj9xu37xJNJhsSQ49MDEtaYD
	6OpmUQnaGll6cX4JM37pqBEoUvrMaxswBCEfqyebzsQFL+s0l7VqQhg7GC/V/gnYTm3xZlaZXaO
	rqPYxzGEicX8PLckCTDtyL8JlTFCMd6zA+bNTMAelt1Y1iOA4uOjY0Bc=
X-Google-Smtp-Source: AGHT+IF0nDmC6C4A2nmk8PCZfGjKVxH5NPBrFN7saYH2CUg/rtkVIrtnYgfmcQsHgPXzLIlVrgQG0eVbKV/6+e46EuU50rp74tvS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8c1c:b0:488:1050:6a2f with SMTP id
 jl28-20020a0566388c1c00b0048810506a2fmr280474jab.5.1714934254556; Sun, 05 May
 2024 11:37:34 -0700 (PDT)
Date: Sun, 05 May 2024 11:37:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e6b300617b93f6d@google.com>
Subject: [syzbot] [mm?] general protection fault in __pte_offset_map_lock
From: syzbot <syzbot+f96e045d95fe10c0e800@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6a71d2909427 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12fa897f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fca646cf17cc616b
dashboard link: https://syzkaller.appspot.com/bug?extid=f96e045d95fe10c0e800
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159169df180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15396354980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c77d21fa1405/disk-6a71d290.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/429fcd369816/vmlinux-6a71d290.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d3d8a4b85112/Image-6a71d290.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f96e045d95fe10c0e800@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address ffff7fbff7e00005
KASAN: probably wild-memory-access in range [0xfffffdffbf000028-0xfffffdffbf00002f]
Mem abort info:
  ESR = 0x0000000096000007
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x07: level 3 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001ad5bd000
[ffff7fbff7e00005] pgd=0000000000000000, p4d=1000000233f68003, pud=1000000233f67003, pmd=1000000233f66003, pte=0000000000000000
Internal error: Oops: 0000000096000007 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 9675 Comm: syz-executor299 Not tainted 6.9.0-rc4-syzkaller-g6a71d2909427 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 80401005 (Nzcv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : ptlock_ptr include/linux/mm.h:2889 [inline]
pc : pte_lockptr include/linux/mm.h:2913 [inline]
pc : __pte_offset_map_lock+0x15c/0x2ac mm/pgtable-generic.c:372
lr : __pte_offset_map_lock+0xe0/0x2ac
sp : ffff80009ff26ea0
x29: ffff80009ff26f60 x28: fffeffffc0000000 x27: 0000000020e00000
x26: fffffdffbf000028 x25: ffff700013fe4ddc x24: ffff80009ff26f00
x23: 1ffff00013fe4de4 x22: ffff80009ff26f20 x21: ffff0000d0854838
x20: dfff800000000000 x19: 0000000000000000 x18: 1fffe00018c6a29c
x17: ffff80008ee7d000 x16: ffff80008ae725bc x15: 0000000000000002
x14: ffff80008ee80668 x13: dfff800000000000 x12: 00000000afeb9c68
x11: 1fffe0001a10a907 x10: ffffc1ffc0000000 x9 : 0000000000000000
x8 : 1fffffbff7e00005 x7 : ffff800080952aac x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000002
x2 : 0000000000000008 x1 : 0000000000000000 x0 : ffff80008e8179a0
Call trace:
 ptlock_ptr include/linux/mm.h:2889 [inline]
 pte_lockptr include/linux/mm.h:2913 [inline]
 __pte_offset_map_lock+0x15c/0x2ac mm/pgtable-generic.c:372
 pte_offset_map_lock include/linux/mm.h:2978 [inline]
 zap_pte_range mm/memory.c:1584 [inline]
 zap_pmd_range mm/memory.c:1722 [inline]
 zap_pud_range mm/memory.c:1751 [inline]
 zap_p4d_range mm/memory.c:1772 [inline]
 unmap_page_range+0x8a8/0x2f5c mm/memory.c:1793
 unmap_single_vma mm/memory.c:1839 [inline]
 unmap_vmas+0x378/0x598 mm/memory.c:1883
 exit_mmap+0x214/0xd74 mm/mmap.c:3267
 __mmput+0xec/0x390 kernel/fork.c:1345
 mmput+0x70/0xac kernel/fork.c:1367
 exit_mm+0x148/0x210 kernel/exit.c:569
 do_exit+0x468/0x1ac8 kernel/exit.c:865
 do_group_exit+0x194/0x22c kernel/exit.c:1027
 get_signal+0x1414/0x1530 kernel/signal.c:2911
 do_signal+0x238/0x3e8c arch/arm64/kernel/signal.c:1308
 do_notify_resume+0x74/0x1f4 arch/arm64/kernel/entry-common.c:148
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:713
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: aa09a908 8b481b48 9100a11a d343ff48 (38746908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa09a908 	orr	x8, x8, x9, lsl #42
   4:	8b481b48 	add	x8, x26, x8, lsr #6
   8:	9100a11a 	add	x26, x8, #0x28
   c:	d343ff48 	lsr	x8, x26, #3
* 10:	38746908 	ldrb	w8, [x8, x20] <-- trapping instruction


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

