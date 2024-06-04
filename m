Return-Path: <linux-kernel+bounces-200065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8BC8FAA0F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC82C1C2257C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8513DDA3;
	Tue,  4 Jun 2024 05:39:28 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6E727735
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717479568; cv=none; b=T7+nR8uinsb6VFuLblMty9z5kTHJOcYgyOrYMNx7pp6AcSfhaRAmX6cU0tmZiuJ16SXhGwT7sBeRobUIuW/GnNtM/FMhwX+L7wBbmRTiSAFoE0aBHrPdKK3rw28hiRS19tr4+0hJgU3VhbC6x0LL8GqcfbjZ122nZ+f1jp112yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717479568; c=relaxed/simple;
	bh=DP0Diu3u5dW17JqsREAYc5x2tqljQBPulKwfjF7e10I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TnW7DLfn9hUIVvBuHBloDXqYCxAIMQdUdS+Qnfy+q702opAbCIhoobSKP2YB5du6cldCRLPJtT2+voCIsFa3gwByCG7c+MTKQnz1ZLQ+kQCf+cpD97BN/G9cMk/Zxtwygdq52eDQBuC8Q9iYyb+Sw42LV4hj0NeyUi2E1+jxSus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-374914d7836so28947385ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 22:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717479565; x=1718084365;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKmB1VONM4QwOdWJQfYon8OCcxyErH7Ftju5sm9mcnw=;
        b=n7A8mJp0QnyOo5qiehDAU5vgcSL1VBqMccHlDoWk6Up6zp0sGOOjGnMOwmmfd2b8qE
         9C/B5RC64c/0wUccnIjwTxMHLeWB6Hn44hmTMNrCiIL4bKDgQNSLY2bwnt9v8suFEia5
         +rdzcHDbVO/UnSgLgb7w8Wlt6AMh7GvbyElIR6Vrxl+rhyJCYtzFsUMi+0PfXjn7BeEv
         lsCT4tduwj6RvHlX70aoe1tpF+d4+T8gp6uE7MiPEAHB+oeaEEXkxOO7RtMRCN7C50H1
         lzjMIl+fL9GEc7fVJdJfgdwm49aNSLeZ6syRujEVR/UzrAzkIq69N7CZ/n9IN5BBY0n5
         L0pA==
X-Forwarded-Encrypted: i=1; AJvYcCVADH0+ANLixvg9x/J7WUgnNkYKscalrmNGv+BeSXCPNYCNAnaUnbtDQiK23ODdaGuH/zImKSE7vONOO4xPrvEhvKZdw7M6eUvKiUvz
X-Gm-Message-State: AOJu0YwWHyS2kB2+ui0rFvdM+1ChTLSqTMD63RUheq5phw9DpB+rLnXd
	htc0UCLwQb4Igj+7DVB/8l+keV3lSuBrRPQxh6bnInzE/aZA+6xZ2lAGOAHNfPX2jf3wIV1PEGT
	jfMHsmJNmXXIsoRRKUfUHcumHyy0Ws3qEWdXQI1O/yX6USnznH5tpOvA=
X-Google-Smtp-Source: AGHT+IFrQqy277ly3SM0zvWpppgIdULssGcN9HiGF4n+H+oqXBN3mUZgfKS9+mgFLj/1oE7ENyASa5pZ23YPXysY6GAchd+Qfebt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e08:b0:371:e497:209 with SMTP id
 e9e14a558f8ab-3748b96cb76mr9364455ab.1.1717479565721; Mon, 03 Jun 2024
 22:39:25 -0700 (PDT)
Date: Mon, 03 Jun 2024 22:39:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c9194061a09dffa@google.com>
Subject: [syzbot] [mm?] BUG: unable to handle kernel NULL pointer dereference
 in __swap_duplicate
From: syzbot <syzbot+bf8cb7ae183cd5693ad9@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e4e206980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd6024aedb15e15c
dashboard link: https://syzkaller.appspot.com/bug?extid=bf8cb7ae183cd5693ad9
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11673ed2980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150a3de6980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4a4be1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75957361122b/vmlinux-4a4be1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c766b0ec377/Image-4a4be1ad.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf8cb7ae183cd5693ad9@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000058
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 52-bit VAs, pgdp=00000000455f8880
[0000000000000058] pgd=0800000046e35003, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3190 Comm: syz-executor681 Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
Hardware name: linux,dummy-virt (DT)
pstate: 81400009 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : lock_cluster mm/swapfile.c:356 [inline]
pc : lock_cluster_or_swap_info mm/swapfile.c:380 [inline]
pc : __swap_duplicate+0x3c/0x178 mm/swapfile.c:3339
lr : swap_duplicate+0x2c/0x54 mm/swapfile.c:3407
sp : ffff800088dd3910
x29: ffff800088dd3910 x28: fff0000006e8cc88 x27: f0f0000006d3bb40
x26: 0000000000000000 x25: fdf0000005ab3900 x24: fcf00000060bf0c0
x23: 0000000000000001 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000080 x19: 0000000000000000 x18: 0000000000000001
x17: 0000000000000000 x16: 1f9e000000c1afc1 x15: 0000000000000001
x14: 0000000000000002 x13: 0000000000000000 x12: 0000000000071c09
x11: 0000000000000000 x10: 0000ffffced91000 x9 : 00000000000000f7
x8 : 0000000000000038 x7 : 0000000000000026 x6 : 0000000200100173
x5 : ffff800088dd3900 x4 : 0000000000000080 x3 : ffff8000828a1ad8
x2 : 0000000000000002 x1 : 0000000000000001 x0 : 0800000000000000
Call trace:
 swp_offset include/linux/swapops.h:109 [inline]
 __swap_duplicate+0x3c/0x178 mm/swapfile.c:3338
 swap_duplicate+0x2c/0x54 mm/swapfile.c:3407
 copy_nonpresent_pte mm/memory.c:793 [inline]
 copy_pte_range mm/memory.c:1129 [inline]
 copy_pmd_range mm/memory.c:1240 [inline]
 copy_pud_range mm/memory.c:1277 [inline]
 copy_p4d_range mm/memory.c:1301 [inline]
 copy_page_range+0x1154/0x20a0 mm/memory.c:1399
 dup_mmap kernel/fork.c:751 [inline]
 dup_mm kernel/fork.c:1688 [inline]
 copy_mm+0x420/0x7d4 kernel/fork.c:1737
 copy_process+0xc30/0x1484 kernel/fork.c:2390
 kernel_clone+0x64/0x360 kernel/fork.c:2797
 __do_sys_clone+0x70/0xa8 kernel/fork.c:2940
 __se_sys_clone kernel/fork.c:2908 [inline]
 __arm64_sys_clone+0x20/0x2c kernel/fork.c:2908
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:152
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: b0012ee3 912b6063 f8627875 9240e413 (f9402ea2) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	b0012ee3 	adrp	x3, 0x25dd000
   4:	912b6063 	add	x3, x3, #0xad8
   8:	f8627875 	ldr	x21, [x3, x2, lsl #3]
   c:	9240e413 	and	x19, x0, #0x3ffffffffffffff
* 10:	f9402ea2 	ldr	x2, [x21, #88] <-- trapping instruction


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

