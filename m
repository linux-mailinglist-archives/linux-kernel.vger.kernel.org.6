Return-Path: <linux-kernel+bounces-199964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DB38FA844
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE55928BEF8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2E51386B9;
	Tue,  4 Jun 2024 02:23:27 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07353BE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 02:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717467806; cv=none; b=MkdY2le12DZVHDb0WPiePQdwr/XW6dz0wlA/ZENKC+YRidqngLh5kynYvWVQCtKxJDn7AChmGx87WM9XRp9vO5VTk+xtqvl9Ooveg/QgNoPNNvvaMS9iA5elDuC3RsK9q/BpDfrCQI6GItJ9rHl3jEn/KWoPFxRWp6saz+bwmbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717467806; c=relaxed/simple;
	bh=PFA4yFsUfUp2ef+U8bZYG3BcqyZr2x50xxUIz7B2WBM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gOGyhRnov9VjWC1A3YcQ55LfUHwgUM3kOTxXkoyD3iXl8BqxjKTXS6rYC3rj4hRTLXcBYIdH79MdrYiN+6q44J++aCjDDcdyFufLSAA08C/o7E4eztOCMYqi2xAxgVSo+J3w3+1au/rtsD7M56uG4+q+/HnfFs28r6FZGkgdrpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7ead5f29d93so441029439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 19:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717467804; x=1718072604;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KnvBbhLgw3ykl4/EWV2UjLKuh8Wl4nUC86g+G8Z780M=;
        b=HMfchXmX5Er249o5o7dsjpchlVdwoY0ltxEmUDBXz0zqvf/w3nxmWcczpUkePCWTN0
         XLh6VJGEQtjyi+3dzzjEOJ2tdfneC2rgJAt26kybTLMjKf2hkRCmQeO4yhZUGSxZtIV8
         wexlqhkjPtng3C3ylolKaoWvR+P2CvgyZBKQ3k4YJes38qcymzrimoE+w0gsY8oQj6Y3
         T5mExFfuahNmQfTtkYcmY/53otCM1AM1VA0HOP13GNlD0i07dwdpxsZISHpOAKfZ7LND
         C6r7XjhvqokMUHaNa4wLa8JzyiLGCf1mZhfIACfby8kuL9lnxMQVvqie+Nu0lISvhYlX
         bWOw==
X-Forwarded-Encrypted: i=1; AJvYcCUUCsZqKjaiO/FWpCq5+XfEMVGCHIdQ5xBoyDpsu//h494K28QfJv+JevtKX2YIGvdSIr3OOBQLuDKQE+rp8Z5I66HRiwdBNEd5vViV
X-Gm-Message-State: AOJu0Yxson6dSAuA7d6zSOKwj6t+gHRajafNYVe/TYgajUfknB1sXB7m
	fF1gbgJxPc0x6Bx4bOf0AHW9r/+PNfID6bjZFrHqPvqXTVA/58pKL6+xuaYHj0qrqL8/uVdLOZG
	1+JVNytdkfdyZ7abLqFCN6fIH8MOZ6+1YIwOozYy854y6tQRfqmwmCBQ=
X-Google-Smtp-Source: AGHT+IEaAouq3noXywR7xOD/Ca7BV/pLgrt88/Td/P3uw9YesZAEvaHq6/CnsB+bu8Vh0J7cw1KCj2u8yzSvB1ESUFP6WrS/Hm1Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d0b:b0:7de:d6a0:d9c4 with SMTP id
 ca18e2360f4ac-7eafff3deecmr78281639f.2.1717467804505; Mon, 03 Jun 2024
 19:23:24 -0700 (PDT)
Date: Mon, 03 Jun 2024 19:23:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066aa68061a072231@google.com>
Subject: [syzbot] [maple-tree?] BUG: unable to handle kernel paging request in mas_walk
From: syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128638ba980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd6024aedb15e15c
dashboard link: https://syzkaller.appspot.com/bug?extid=c67d06ab25a9bc4adf35
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106f71aa980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b4ffc6980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4a4be1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75957361122b/vmlinux-4a4be1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c766b0ec377/Image-4a4be1ad.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 00700000077b9b78
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
[00700000077b9b78] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3186 Comm: syz-executor162 Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
Hardware name: linux,dummy-virt (DT)
pstate: 81400009 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : ma_data_end lib/maple_tree.c:1419 [inline]
pc : mtree_range_walk lib/maple_tree.c:2771 [inline]
pc : mas_state_walk lib/maple_tree.c:3678 [inline]
pc : mas_walk+0x194/0x328 lib/maple_tree.c:4909
lr : lock_vma_under_rcu+0x58/0x134 mm/memory.c:5840
sp : ffff800088cabd50
x29: ffff800088cabd50 x28: f2f0000005e50000 x27: 0000000000000000
x26: 0000000000000004 x25: f7f0000005c03900 x24: 0000000082000007
x23: 0000ffff82687800 x22: 0000000000000354 x21: 0000ffff82687800
x20: 0000ffff82687800 x19: ffff800088cabeb0 x18: ff7ffffffffffbff
x17: 0000aaaadab2dc00 x16: 1e4e000000ef7371 x15: 0000000000000001
x14: ffffffffffffffff x13: 0000000000000000 x12: ffff800081e3d1e8
x11: 0000000000000001 x10: f2700000077b9b8c x9 : f2700000077b9b00
x8 : 0000ffff82687800 x7 : 0000000000000001 x6 : 000000000000000e
x5 : 0000000000000001 x4 : ffff800088cabd78 x3 : 0000aaaadab2dc00
x2 : 000000000000000e x1 : 000000000000000f x0 : f2700000077b9b08
Call trace:
 ma_data_end lib/maple_tree.c:1418 [inline]
 mtree_range_walk lib/maple_tree.c:2771 [inline]
 mas_state_walk lib/maple_tree.c:3678 [inline]
 mas_walk+0x194/0x328 lib/maple_tree.c:4909
 do_page_fault+0xd4/0x480 arch/arm64/mm/fault.c:567
 do_translation_fault+0xac/0xbc arch/arm64/mm/fault.c:690
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:826
 el0_ia+0xa4/0x118 arch/arm64/kernel/entry-common.c:598
 el0t_64_sync_handler+0xd0/0x12c arch/arm64/kernel/entry-common.c:736
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: 91002120 51000426 92401cc2 12001cc6 (f8627802) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	91002120 	add	x0, x9, #0x8
   4:	51000426 	sub	w6, w1, #0x1
   8:	92401cc2 	and	x2, x6, #0xff
   c:	12001cc6 	and	w6, w6, #0xff
* 10:	f8627802 	ldr	x2, [x0, x2, lsl #3] <-- trapping instruction


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

