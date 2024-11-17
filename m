Return-Path: <linux-kernel+bounces-412245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA83E9D05DC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 21:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665481F21B5D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 20:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5512F1DBB0D;
	Sun, 17 Nov 2024 20:32:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880D18054
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731875526; cv=none; b=t/TCS1NcvLz9J6Lvyfrie5B2lrCUfzI5PuqC73h630nFNzymxoF9R1mBVG60I+bXeOqAWXupEbthP2OeG11minBNk43UPNxZb1t+p7cR+TKql5JCZsV5PuxPRHDTR9fb+grPIus2uwKmXDD92MA2sJNK/lkIyV8QIDaFdsCK9dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731875526; c=relaxed/simple;
	bh=D8toqR4O4QUeV5NU+EdpcQqKak4o58Qx7E4TAcub92U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sQGGGHc0BMTRNEa2nAO9toaSaZhOW4SsqZeYZWZbc5AAr4rjqka7+rfxbaF50qA/7MYmWrx/T+LlinxQsdDspWUNHZikEZXUYxuF5RyzHT3bGceUreFRzV4+MFWzsdcNQiO7X80heFkAmumTdXoT3r7nGu58TIIOtOK2EPIB3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6c01d8df2so31718765ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731875524; x=1732480324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1YK7w+KRmdpD5JFpX8rEO+otJ9PzEo2psTEZ5U9a5k=;
        b=tjILK+a3/yzwTzFDsOQ8Ouv8bJx/JImB0j3X/V2lnzVgc45R7R0xjYnPWLrzw1VCwd
         H0L4tmWQn4cDtQwA87n+lFP1keAL4lRk79lfufvKz+ccMnH1R3OdYPyrO//tBYHcljek
         yU2gs+YAhcNMjFmozlZjcBa2pvjgfcByWUT1BPgAtnF4swjEuy/Cyy2d6ASRC7jmxzmK
         F+J0mh2piHjga3hlfx7c54LiZOWpKmLOgKV6x6u7TofvJgRs0s7qCmFH43epu4//JENp
         LDEqr8KE+JwdQfU0jTbFX6LwRiurDaWbyGank0iZZYEbgYahFuGfc6OJ39HlR8/Zqwtj
         S1gw==
X-Forwarded-Encrypted: i=1; AJvYcCXLa6CUrg5ZwNS4l85TK5VaU8++X9drFu9CA0uvkCPd7LJeiL6F8dE01zpbm22AUfnm+8Lyjh9huDhVi78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgiZ2es7/q+LJhX6Kjpg2OCBG6/rS2x9aUwkcRxDQFRpDky5um
	Jx6wxVa83P4pM9pX2m1iHG3wUYxKGkgcUnCkDelfJAbcBrHBGrSkmJZYzrgzv9kr6ywe6IznXPo
	8n9uJHbCZC0gWfOTug6be+/uaL3HWZlw4s4oCk/DakjpiV66IMuEV8IY=
X-Google-Smtp-Source: AGHT+IGk2B59q5yVgCbwvWM9c68NEYhedHemrCuf3qia2BrlpT7vi/zTYuG3BlCRKHwsj414JltAWXmmSKH7rtrEKYu3Tn/hNfaE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2165:b0:3a7:158d:6398 with SMTP id
 e9e14a558f8ab-3a746ffd503mr66754815ab.7.1731875524480; Sun, 17 Nov 2024
 12:32:04 -0800 (PST)
Date: Sun, 17 Nov 2024 12:32:04 -0800
In-Reply-To: <4842ef8c-bcf1-4cb8-942a-68591332c948@lucifer.local>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673a52c4.050a0220.87769.0015.GAE@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in mas_store_prealloc
From: syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, jannh@google.com, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in mas_store_prealloc

 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Unable to handle kernel paging request at virtual address dfff800000000001
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000001] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 UID: 0 PID: 16112 Comm: syz.0.4215 Not tainted 6.12.0-rc7-syzkaller-00234-g887407160d72 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mt_slot_locked lib/maple_tree.c:795 [inline]
pc : mas_slot_locked lib/maple_tree.c:808 [inline]
pc : mas_store_prealloc+0x870/0x1068 lib/maple_tree.c:5514
lr : mt_slot_locked lib/maple_tree.c:795 [inline]
lr : mas_slot_locked lib/maple_tree.c:808 [inline]
lr : mas_store_prealloc+0x778/0x1068 lib/maple_tree.c:5514
sp : ffff80009c667440
x29: ffff80009c667560 x28: ffff80009c6674c0 x27: dfff800000000000
x26: ffff7000138cce94 x25: 0000000000000008 x24: 0000000000000000
x23: 0000000000000008 x22: ffff0000dc74f840 x21: 0000000000000008
x20: ffff80009c6678e0 x19: 0000000000000000 x18: 0000000000000008
x17: 0000000000000000 x16: ffff800080585ea8 x15: 0000000000000009
x14: 1ffff000138cce99 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7000138ccea2 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000001 x7 : 0000000000000000 x6 : 00000000003bbda8
x5 : ffff80009c6665f8 x4 : 0000000000000008 x3 : ffff80008b4208f0
x2 : ffffffffffffffc0 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 mt_slot_locked lib/maple_tree.c:795 [inline] (P)
 mas_slot_locked lib/maple_tree.c:808 [inline] (P)
 mas_store_prealloc+0x870/0x1068 lib/maple_tree.c:5514 (P)
 mt_slot_locked lib/maple_tree.c:795 [inline] (L)
 mas_slot_locked lib/maple_tree.c:808 [inline] (L)
 mas_store_prealloc+0x778/0x1068 lib/maple_tree.c:5514 (L)
 vma_iter_store+0x2e8/0x81c mm/vma.h:476
 __mmap_region mm/mmap.c:1513 [inline]
 mmap_region+0x1650/0x1d44 mm/mmap.c:1603
 do_mmap+0x8c4/0xfac mm/mmap.c:496
 vm_mmap_pgoff+0x1a0/0x38c mm/util.c:588
 ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:542
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: 393b2668 972c43de 8b180ef5 d343fea8 (387b6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	393b2668 	strb	w8, [x19, #3785]
   4:	972c43de 	bl	0xfffffffffcb10f7c
   8:	8b180ef5 	add	x21, x23, x24, lsl #3
   c:	d343fea8 	lsr	x8, x21, #3
* 10:	387b6908 	ldrb	w8, [x8, x27] <-- trapping instruction


Tested on:

commit:         88740716 Merge remote-tracking branch 'iommu/arm/smmu'..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15aed378580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1eb85a42cb8ccec
dashboard link: https://syzkaller.appspot.com/bug?extid=bc6bfc25a68b7a020ee1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.

