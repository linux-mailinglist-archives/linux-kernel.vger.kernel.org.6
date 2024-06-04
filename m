Return-Path: <linux-kernel+bounces-200921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114F08FB692
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3385C1C2099A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF3E13D503;
	Tue,  4 Jun 2024 15:06:47 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F0846D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513606; cv=none; b=n/pTtN7p94U/3OIG5czsg8KN4xvRLfOXr6raFV4An11p+z63Rp99nXHVfg2Si9hvLajf5ocb/J1RqeP2QmAOCyX09YAIEmkbgvxjgDp+E3tPdi+lyVWq9PdZwB49GbXRqQQhGRJknfbkzLc+mR/Q7XMRUDt3O1KyX2FoY/URYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513606; c=relaxed/simple;
	bh=9gyJDOtgkTIHqAQ+NVULRII3P8qJUO2R5927zJ32Bk4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BNwmzY0KYh94E4FrhLuGCgPS3zO1oWrs+iDAcOUjSZ48s4g9vZQ3gXxLFOdFFMNR9b7tiIBJpj3MZP5jixib4C9txnXPkgkl2z8ynwV/ls6gDEidiDmWskMwno47qM9T0BfSYPuVjUyUlECclVmJFYS1pGwmaviMospOX5rM9rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e8e2ea7b4bso743920039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 08:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717513604; x=1718118404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Gu6towcYHBY1dP/fAn0yjbpkodENXFFfZuNjXnHN3Q=;
        b=hqARrcVnvw80875FLtW7ugRpUCilgAnO+4spBnbU9PeMB+EzNEtz//PIXXIiCFTZzG
         KBkJkknnGo7TJ7C/G2H5Tgwag/aL5WThNqI6U8dQHHXmtQ2B1BeVrQ9AqA2KSxqyv1wI
         3VPElQssyictXByWDTrR2N1qrKuC+5dnVsr3JLfUCCoXqLyqZdcWRRdH2BgShMoV9JrO
         xsvs5zDz+yw8xvlt6P3mQ6JRpd99UGf3htoXbTc4HyJlB4EK/3MGZWRWQXtQ/L5gmknT
         P7jA637Or9UwEMtGevhrtClQmAzSY1EMjYwMnhBNmpXXhWYnapePMK9E5xslu6vq84+b
         vtig==
X-Gm-Message-State: AOJu0YyXWHEkCOpJGy8Lbp7OouKK/VmmB3Bv6nC0fi1+zShfdr7PXOhe
	GU0cZA8ZhsUjXqWZvzoX7O/il3cjU4RR8iC5YPu08Bx3rGcrjB6fIBznFjPIhCWkWU+6yufdGHn
	e/mdJPhsW1dZqeMU+Wih0xDQdDkUJWl8qP96u2vI9vu23E2AR3M0/leVv1g==
X-Google-Smtp-Source: AGHT+IHkXDgx3DzFfMmxJ0iuVz8/LfbnTjCEnotu7Qwuo2C5O1TznHwDorVMw3khPARJoy+sajHlkCTnQMjqR/EJ1fJxIbEZ1H1/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d0b:b0:7de:d6a0:d9c4 with SMTP id
 ca18e2360f4ac-7eafff3deecmr90372539f.2.1717513603628; Tue, 04 Jun 2024
 08:06:43 -0700 (PDT)
Date: Tue, 04 Jun 2024 08:06:43 -0700
In-Reply-To: <00000000000066aa68061a072231@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003dd1f6061a11ccae@google.com>
Subject: Re: [syzbot] Re: [syzbot] [maple-tree?] BUG: unable to handle kernel
 paging request in mas_walk
From: syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [maple-tree?] BUG: unable to handle kernel paging request in mas_walk
Author: liam.howlett@oracle.com

* syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com> [240603 22:23]:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=128638ba980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bd6024aedb15e15c
> dashboard link: https://syzkaller.appspot.com/bug?extid=c67d06ab25a9bc4adf35
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106f71aa980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b4ffc6980000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4a4be1ad.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/75957361122b/vmlinux-4a4be1ad.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6c766b0ec377/Image-4a4be1ad.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com
> 
> Unable to handle kernel paging request at virtual address 00700000077b9b78

#syz test: git://git.infradead.org/users/jedix/linux-maple.git syz_20240603

> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [00700000077b9b78] address between user and kernel address ranges
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 PID: 3186 Comm: syz-executor162 Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 81400009 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> pc : ma_data_end lib/maple_tree.c:1419 [inline]
> pc : mtree_range_walk lib/maple_tree.c:2771 [inline]
> pc : mas_state_walk lib/maple_tree.c:3678 [inline]
> pc : mas_walk+0x194/0x328 lib/maple_tree.c:4909
> lr : lock_vma_under_rcu+0x58/0x134 mm/memory.c:5840
> sp : ffff800088cabd50
> x29: ffff800088cabd50 x28: f2f0000005e50000 x27: 0000000000000000
> x26: 0000000000000004 x25: f7f0000005c03900 x24: 0000000082000007
> x23: 0000ffff82687800 x22: 0000000000000354 x21: 0000ffff82687800
> x20: 0000ffff82687800 x19: ffff800088cabeb0 x18: ff7ffffffffffbff
> x17: 0000aaaadab2dc00 x16: 1e4e000000ef7371 x15: 0000000000000001
> x14: ffffffffffffffff x13: 0000000000000000 x12: ffff800081e3d1e8
> x11: 0000000000000001 x10: f2700000077b9b8c x9 : f2700000077b9b00
> x8 : 0000ffff82687800 x7 : 0000000000000001 x6 : 000000000000000e
> x5 : 0000000000000001 x4 : ffff800088cabd78 x3 : 0000aaaadab2dc00
> x2 : 000000000000000e x1 : 000000000000000f x0 : f2700000077b9b08
> Call trace:
>  ma_data_end lib/maple_tree.c:1418 [inline]
>  mtree_range_walk lib/maple_tree.c:2771 [inline]
>  mas_state_walk lib/maple_tree.c:3678 [inline]
>  mas_walk+0x194/0x328 lib/maple_tree.c:4909
>  do_page_fault+0xd4/0x480 arch/arm64/mm/fault.c:567
>  do_translation_fault+0xac/0xbc arch/arm64/mm/fault.c:690
>  do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:826
>  el0_ia+0xa4/0x118 arch/arm64/kernel/entry-common.c:598
>  el0t_64_sync_handler+0xd0/0x12c arch/arm64/kernel/entry-common.c:736
>  el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
> Code: 91002120 51000426 92401cc2 12001cc6 (f8627802) 
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	91002120 	add	x0, x9, #0x8
>    4:	51000426 	sub	w6, w1, #0x1
>    8:	92401cc2 	and	x2, x6, #0xff
>    c:	12001cc6 	and	w6, w6, #0xff
> * 10:	f8627802 	ldr	x2, [x0, x2, lsl #3] <-- trapping instruction
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

