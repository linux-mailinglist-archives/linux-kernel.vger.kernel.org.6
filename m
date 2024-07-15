Return-Path: <linux-kernel+bounces-252308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93670931164
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5032B2195C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1B2186E4A;
	Mon, 15 Jul 2024 09:39:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0B199A2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036344; cv=none; b=ZyHzDmAD2iPEPA8l6woSEoy/mTqZydROu8P5SnrjOgwFyO7N7xd+RHNjLKzrIESA9lmGkgpJMRWMF7VwarLQ87ykeojIpX378ZOhh6qBtFo8P26gd4OU+pyBKvArVywWKsN/yYmW13LztmuGIwGZ7XMFTeY663Rd327jQXHUteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036344; c=relaxed/simple;
	bh=6AEFsEKsUpb3ypyZKuMf5kxPW8bAHxcQFHyJjL6wH2A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DvtePUDAcYNKxQxc0aH9mD3y7NnoXzQ0coD4Rm6I/dOpQxWEeIyEwY+J1eFrkIebqx9JSxBUNKcnvAD06OBTo/GqMVCNZRt/56u9dyir7v6IZYU39T+OMGrCiDt+TFM44MCL33cfvfEO91cEF0YmkiQtFxrhrDI8orho5CDEzDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-804888d4610so401987639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721036342; x=1721641142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcOH2YNv6hTES5H04pSUoFFYdg1HVD4+kUaPv0gv/gg=;
        b=pKDZKBOfCF2884WrO+VG+7qOsHZc+/4SGWRBl30z7/SDk+AEzciceBfDd4ezgW2ZT0
         vN6qKKmZROEZ7OpirqrTQ4x5bNxM2b76wBbelxryf9MBPyLJfVpZsXWNrDSSElQQPNvb
         HzV3rhjLGgMGrnEyvyyi5frOM5X22o751GnIujyAkOH49kgyug5GT+uV6S4Sxc/Q9qJk
         dHE4E/0pf7QxSOph2rL1CphOHRKlk/G6D1V07p8gFmTshRcV9HyN5qaUw5ttDZMVbgKS
         UEWKMT2GTE5xOfkkODEahx7lmd0U4sWfLkYTNOUtS8zt49SK1ECWOJSBN/NHmXjtu7V8
         VmuA==
X-Forwarded-Encrypted: i=1; AJvYcCWKmUaFcQP2xnrzHzodjjkbcw6i9rDZd+Yhf9WXKClvLOX0NSwnlI130i+kfMVv+kNICPQbo7hyD5ph86I3CBVWffddEk4YYlDAU+UL
X-Gm-Message-State: AOJu0YzEM7OxCpMAnEomIQ3Mw5lz7l8CTJqka53Yu+2Jz7ua2n8aXrga
	uDtlwfz4tMr2VlF2k7qJwLHqwWr/4J7bLsSv1gvo9DhUqDRRpVRwpVBiEE+VSbo1YsiBezwRwR9
	OUYUw2CJtj0zXpg9KVbK7oRN4n+3ZMcuXJ6zfT7nAs7cr7z/htYOBweE=
X-Google-Smtp-Source: AGHT+IFrlSJY1FG0Owvf6CuER66QjwPTccB1f2ttggO/MPp1ib+Gotd1cg74fnU3aWRlbhsUxLjPd1CkR1ZRVPgTGhFVwhcR66MV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda4:0:b0:382:2f47:a82e with SMTP id
 e9e14a558f8ab-38e60f2ad3bmr10009865ab.1.1721036342629; Mon, 15 Jul 2024
 02:39:02 -0700 (PDT)
Date: Mon, 15 Jul 2024 02:39:02 -0700
In-Reply-To: <8f3f2481-c970-4019-b39d-6f0d280ba147@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d92e6a061d45ffa3@google.com>
Subject: Re: [syzbot] [ntfs3?] general protection fault in run_is_mapped_full
From: syzbot <syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in run_is_mapped_full

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS sector size (1024) and media sector size (512).
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 6004 Comm: syz.0.15 Not tainted 6.10.0-rc1-syzkaller-00034-geb95678ee930 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:run_lookup fs/ntfs3/run.c:39 [inline]
RIP: 0010:run_is_mapped_full+0x35/0x480 fs/ntfs3/run.c:173
Code: 41 54 53 48 83 ec 30 41 89 d4 41 89 f6 49 89 fd 49 bf 00 00 00 00 00 fc ff df e8 36 e5 a7 fe 49 8d 5d 08 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 6c 9c 0d ff 48 8b 1b 31 ff 48 89
RSP: 0018:ffffc9000329f758 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: ffff88807b0c5a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000329fb18 R08: ffffffff82e4ba0a R09: ffffffff82ee0999
R10: 0000000000000002 R11: ffff88807b0c5a00 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f826d7ef6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb79d6ff095 CR3: 000000007ccc0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 attr_load_runs fs/ntfs3/attrib.c:69 [inline]
 attr_set_size+0xfdf/0x4300 fs/ntfs3/attrib.c:502
 ntfs_create_inode+0x252d/0x37f0 fs/ntfs3/inode.c:1719
 ntfs_symlink+0xde/0x110 fs/ntfs3/namei.c:199
 vfs_symlink+0x137/0x2e0 fs/namei.c:4489
 do_symlinkat+0x222/0x3a0 fs/namei.c:4515
 __do_sys_symlinkat fs/namei.c:4531 [inline]
 __se_sys_symlinkat fs/namei.c:4528 [inline]
 __x64_sys_symlinkat+0x99/0xb0 fs/namei.c:4528
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f826c975bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f826d7ef048 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00007f826cb03f60 RCX: 00007f826c975bd9
RDX: 0000000020000440 RSI: 0000000000000006 RDI: 0000000020000340
RBP: 00007f826c9e4e60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f826cb03f60 R15: 00007ffc50a8ce78
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:run_lookup fs/ntfs3/run.c:39 [inline]
RIP: 0010:run_is_mapped_full+0x35/0x480 fs/ntfs3/run.c:173
Code: 41 54 53 48 83 ec 30 41 89 d4 41 89 f6 49 89 fd 49 bf 00 00 00 00 00 fc ff df e8 36 e5 a7 fe 49 8d 5d 08 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 6c 9c 0d ff 48 8b 1b 31 ff 48 89
RSP: 0018:ffffc9000329f758 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: ffff88807b0c5a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000329fb18 R08: ffffffff82e4ba0a R09: ffffffff82ee0999
R10: 0000000000000002 R11: ffff88807b0c5a00 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f826d7ef6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f826cb000a0 CR3: 000000007ccc0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	41 54                	push   %r12
   2:	53                   	push   %rbx
   3:	48 83 ec 30          	sub    $0x30,%rsp
   7:	41 89 d4             	mov    %edx,%r12d
   a:	41 89 f6             	mov    %esi,%r14d
   d:	49 89 fd             	mov    %rdi,%r13
  10:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  17:	fc ff df
  1a:	e8 36 e5 a7 fe       	call   0xfea7e555
  1f:	49 8d 5d 08          	lea    0x8(%r13),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 6c 9c 0d ff       	call   0xff0d9ca5
  39:	48 8b 1b             	mov    (%rbx),%rbx
  3c:	31 ff                	xor    %edi,%edi
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


Tested on:

commit:         eb95678e fs/ntfs3: Keep runs for $MFT::$ATTR_DATA and ..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16543f85980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f1c94a15f7c9744
dashboard link: https://syzkaller.appspot.com/bug?extid=9af29acd8f27fbce94bc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

