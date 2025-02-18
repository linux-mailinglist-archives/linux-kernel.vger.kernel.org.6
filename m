Return-Path: <linux-kernel+bounces-520335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8D9A3A8B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85A83A663E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CEB1D47B4;
	Tue, 18 Feb 2025 20:25:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B181C7018
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910305; cv=none; b=Xwg5I3GMtMaiep6I7HzVzR6dX+KITjKa8oOvT/sjJHomXY3Tx9PQcfdx4Yxw/vNHTUVT1aF6bHrRNKYFbp7Dat/MfOR8AU1wl0tKLuTHEbmzD0tyCeaf+qr+EEy9Jaibn2+Hb7xF3ZX79ZXnEKRdW+YV+RCIVcK7vQ1lFl9CtsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910305; c=relaxed/simple;
	bh=K/4csQkLxCjzNwOWH+Ssn6tsCq1oMWzz19TKXOOa2y4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pg6Y/Qgv569nQ/Fcd28/PmM/LthUnugtrRuF0gbVB2ct8eCNnGJCW0TQVPidXVS/edWKFDnDm3ybdG7KqJRADljUDXrfoU5/zqmj/sLeA8iz5zSnVIgaTbuaPfoYdo3H/A80bv0lvgoUvJPjoMLYj8KJe/tAa+/uXlTpuDOi1es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2a6102c1aso32599975ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739910302; x=1740515102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8r9sc6OzcSBAxyuSRSyB9xeJjZ3iNaxuy0Cr/uWAkc=;
        b=hUq9XxJS9eVd13IWIeuq/I5iiYzv6U0bbuX4gATuNig5SD4dc8zfuF0t4al5cssrmx
         fjshunIKUqG6PU9luWayWtMlOQpCZqpxMdF4aauJMg6zY3i7RqZEea/r+au5O/eyyuck
         yqWYHhsmzh8qkA4c5w26OtpIkKnHG/U98mhXmL6K+RTdpgxfvZ/6HZ7cd7r15CuoTaJQ
         Z6RrE+DPkld2ZIqKbRfeIGa/98s5is+6lF60TX8s7lujyhscLkPbJL2zd+3bacSFf9iB
         go4j0Rlm5nIRS/TrGOrZKxm0hw/wnSPARuyaFn2bqCJnbchthU+GKcDz1iyf6eQA0vCe
         HHzQ==
X-Gm-Message-State: AOJu0YxJyo+4Efncgttv8p527keNFBl9S8DsPQyJILHLCzcCBAYyUpHk
	vx4SyRKUVAmtDKxsAmtyISzCtL47KvwHOvVmkGT3BlHY9HQvxuxGshWFoXgs5ACBGda3HXoGJ87
	CwqCzMF2g0Lo7FxJ8lUgXxjoSC+THLUNYv0Pt+iEwzYhBZrpy8vKup7c=
X-Google-Smtp-Source: AGHT+IE5KoxwWs8vvoXBhbdKC/I7g1TVUo4lVt8EP9Weco6ptflM8EdTM0F2L7kanqa1QNuBqPf5bnI1ef6lTFfpI1SGrPCbM7cW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1523:b0:3d1:95c5:40a5 with SMTP id
 e9e14a558f8ab-3d2b512eca5mr9873725ab.0.1739910302677; Tue, 18 Feb 2025
 12:25:02 -0800 (PST)
Date: Tue, 18 Feb 2025 12:25:02 -0800
In-Reply-To: <180B5E33-351D-4A3F-8948-02AF10DBA3D8@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b4ec9e.050a0220.14d86d.000e.GAE@google.com>
Subject: Re: [syzbot] [mm?] [bcachefs?] WARNING in lock_list_lru_of_memcg
From: syzbot <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in call_rcu

Oops: general protection fault, probably for non-canonical address 0xef11a50f048e916c: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0x788d487824748b60-0x788d487824748b67]
CPU: 0 UID: 0 PID: 5968 Comm: modprobe Not tainted 6.14.0-rc3-syzkaller-g6537cfb395f3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:lookup_object lib/debugobjects.c:423 [inline]
RIP: 0010:lookup_object_or_alloc lib/debugobjects.c:662 [inline]
RIP: 0010:debug_object_activate+0x1bd/0x580 lib/debugobjects.c:820
Code: 89 df e8 06 d5 2c fd 48 89 5c 24 30 4c 8b 3b 45 31 e4 eb 06 4d 8b 3f 41 ff c4 4d 85 ff 74 40 49 8d 5f 18 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 d4 d4 2c fd 48 8b 44 24 10 48 39
RSP: 0018:ffffc9000d09f2c0 EFLAGS: 00010006
RAX: 0f11a90f048e916c RBX: 788d487824748b60 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffffc9000d09f1a0
RBP: ffffc9000d09f3d0 R08: 0000000000000003 R09: fffff52001a13e34
R10: dffffc0000000000 R11: fffff52001a13e34 R12: 0000000000000001
R13: 1ffff92001a13e60 R14: dffffc0000000000 R15: 788d487824748b48
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f7221a9008 CR3: 0000000053bc0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_rcu_head_queue kernel/rcu/rcu.h:224 [inline]
 __call_rcu_common kernel/rcu/tree.c:3050 [inline]
 call_rcu+0x97/0xac0 kernel/rcu/tree.c:3172
 remove_vma mm/vma.c:419 [inline]
 vms_complete_munmap_vmas+0x65b/0x8f0 mm/vma.c:1202
 do_vmi_align_munmap+0x5ef/0x6f0 mm/vma.c:1445
 do_vmi_munmap+0x24e/0x2d0 mm/vma.c:1493
 __vm_munmap+0x372/0x510 mm/vma.c:2951
 elf_map fs/binfmt_elf.c:389 [inline]
 elf_load+0x2d6/0x700 fs/binfmt_elf.c:414
 load_elf_interp+0x440/0xac0 fs/binfmt_elf.c:681
 load_elf_binary+0x1a87/0x2820 fs/binfmt_elf.c:1241
 search_binary_handler fs/exec.c:1775 [inline]
 exec_binprm fs/exec.c:1807 [inline]
 bprm_execve+0x979/0x1430 fs/exec.c:1859
 kernel_execve+0x931/0xa50 fs/exec.c:2026
 call_usermodehelper_exec_async+0x237/0x380 kernel/umh.c:109
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:lookup_object lib/debugobjects.c:423 [inline]
RIP: 0010:lookup_object_or_alloc lib/debugobjects.c:662 [inline]
RIP: 0010:debug_object_activate+0x1bd/0x580 lib/debugobjects.c:820
Code: 89 df e8 06 d5 2c fd 48 89 5c 24 30 4c 8b 3b 45 31 e4 eb 06 4d 8b 3f 41 ff c4 4d 85 ff 74 40 49 8d 5f 18 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 d4 d4 2c fd 48 8b 44 24 10 48 39
RSP: 0018:ffffc9000d09f2c0 EFLAGS: 00010006
RAX: 0f11a90f048e916c RBX: 788d487824748b60 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffffc9000d09f1a0
RBP: ffffc9000d09f3d0 R08: 0000000000000003 R09: fffff52001a13e34
R10: dffffc0000000000 R11: fffff52001a13e34 R12: 0000000000000001
R13: 1ffff92001a13e60 R14: dffffc0000000000 R15: 788d487824748b48
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f7221a9008 CR3: 0000000053bc0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 df                	mov    %ebx,%edi
   2:	e8 06 d5 2c fd       	call   0xfd2cd50d
   7:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
   c:	4c 8b 3b             	mov    (%rbx),%r15
   f:	45 31 e4             	xor    %r12d,%r12d
  12:	eb 06                	jmp    0x1a
  14:	4d 8b 3f             	mov    (%r15),%r15
  17:	41 ff c4             	inc    %r12d
  1a:	4d 85 ff             	test   %r15,%r15
  1d:	74 40                	je     0x5f
  1f:	49 8d 5f 18          	lea    0x18(%r15),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 d4 d4 2c fd       	call   0xfd2cd50d
  39:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  3e:	48                   	rex.W
  3f:	39                   	.byte 0x39


Tested on:

commit:         6537cfb3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13732498580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=38a0cbd267eff2d286ff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f8e5b0580000


