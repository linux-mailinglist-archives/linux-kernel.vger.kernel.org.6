Return-Path: <linux-kernel+bounces-252344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BABA09311E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7195728029E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57351187336;
	Mon, 15 Jul 2024 10:01:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A16C8825
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037667; cv=none; b=uWJu6nHd+HYvX5GbMS4LDa6TbNBcXq8CQVHSvOcYX4l+0WcWrdzk8svi48uxZst1oupw2IGMZzY2OCXxixk4bmqlkiN1nmHBYaZqotjA3HqWViXLfCKclbRIdYFQ0MGpnTUu9QRXRdFEz8hFp313r9fvbkIccDZGKqKLzKmD9Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037667; c=relaxed/simple;
	bh=wnaYATdLADJTJLtKHLgK3Bd0JzGlkshIU9ZJlxwJ5g0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YIxxesCT3W+3tC/CyhyuO+hCxNaKMpfmAkfcxB6akG1ynpJjRkbur0E/rSwvJCU3uAQYRAABeT7vhwEiV/fzMMNNzr61UxDBK4mF/x4xXM59vk+E2D2vQzNPOkH4hRtYUKkDOwet0/u4t6bfc6iNTy9jGcrPX2gPHfFGPUyipQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-804825a316bso464319539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721037665; x=1721642465;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1khulkKqWR/ilAnCUDmeV4lwQGtfNxYYSBXfd+v+CG0=;
        b=HXOXbYN7obDMmpRkYB+buPavlIzGjthr6nm7DObOePiByb1FC+ZeLBlmaM416LTZPo
         9GTjyn0rJQ/TFsmxa1LieuNfJV2SPagza4aG1E79ku82SCzFlmh+k4iAGjN4/mUxQ2Va
         2ecLxBlrCmyDQ2OY6js8Au/4GEtZXogrKYz0NayG0Y17vuDOGAY+YW+we6XCDj+ufDtF
         m/QThxBjTBd9lpYgw7v8w5w7eZtophoJWUOlTmKGd3Vvmp/hrJx3k94wWjhx5MjYvWhS
         G9pio3P8Q8tvX736KAl8ldQOFhYV0dwGe2ft8bOTrop6EnmPgpxT2OVxsaCTTwx0St8Q
         S2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVy1yZrVdTiQSlEGa+XrvE/Y7WuY3NKNnBUmdal0fQ4YM8w3QM12ZdA5uw6QfqW9JHcv1LOUY8yXUaGmZTB6H5wQuwgWQwsLus6PUR2
X-Gm-Message-State: AOJu0YzOI6HwLTTFIyg36K1Mcs22m2HBRdKc3cnCCoe9fkjkbe4s+oF8
	H/9yZYC5y04hRDmrJXiy5PQj5I2mPh4Dg564FxXbwTqlwYcastw281qMeWIivd1y0mJiXKbrBHo
	DvaLHAKtDUGdMKFez+Er51wHO8lqW++oz30GH51URp41xLlK7iB+OoLk=
X-Google-Smtp-Source: AGHT+IFn2y59D++CV/axL9D5c4W/G5Ybrwsq9dFOz3Ovmle4PKaDYhCgIcTNz9cwtgLLpHvu7SVUqJtpSXos1TMiQkxzifTblEUR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2709:b0:4c0:9a3e:c263 with SMTP id
 8926c6da1cb9f-4c0b24abdb2mr1481306173.0.1721037665459; Mon, 15 Jul 2024
 03:01:05 -0700 (PDT)
Date: Mon, 15 Jul 2024 03:01:05 -0700
In-Reply-To: <be1ba54b-80a1-4cf2-9a2d-395e87c53a28@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1ee58061d464eb0@google.com>
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
CPU: 0 PID: 5967 Comm: syz.0.15 Not tainted 6.10.0-rc1-syzkaller-00042-g911daf695a74 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:run_lookup fs/ntfs3/run.c:39 [inline]
RIP: 0010:run_is_mapped_full+0x35/0x480 fs/ntfs3/run.c:173
Code: 41 54 53 48 83 ec 30 41 89 d4 41 89 f6 49 89 fd 49 bf 00 00 00 00 00 fc ff df e8 26 da a7 fe 49 8d 5d 08 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 5c 91 0d ff 48 8b 1b 31 ff 48 89
RSP: 0018:ffffc9000325f758 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: ffff88801a3d9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000325fb18 R08: ffffffff82e4ba0a R09: ffffffff82ee14a9
R10: 0000000000000002 R11: ffff88801a3d9e00 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f4560dbd6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f45601000a0 CR3: 000000001d326000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 attr_load_runs fs/ntfs3/attrib.c:69 [inline]
 attr_set_size+0xfdf/0x4300 fs/ntfs3/attrib.c:502
 ntfs_create_inode+0x2482/0x3740 fs/ntfs3/inode.c:1716
 ntfs_symlink+0xde/0x110 fs/ntfs3/namei.c:197
 vfs_symlink+0x137/0x2e0 fs/namei.c:4489
 do_symlinkat+0x222/0x3a0 fs/namei.c:4515
 __do_sys_symlinkat fs/namei.c:4531 [inline]
 __se_sys_symlinkat fs/namei.c:4528 [inline]
 __x64_sys_symlinkat+0x99/0xb0 fs/namei.c:4528
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f455ff75bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4560dbd048 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00007f4560103f60 RCX: 00007f455ff75bd9
RDX: 0000000020000440 RSI: 0000000000000006 RDI: 0000000020000340
RBP: 00007f455ffe4e60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f4560103f60 R15: 00007fff46026838
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:run_lookup fs/ntfs3/run.c:39 [inline]
RIP: 0010:run_is_mapped_full+0x35/0x480 fs/ntfs3/run.c:173
Code: 41 54 53 48 83 ec 30 41 89 d4 41 89 f6 49 89 fd 49 bf 00 00 00 00 00 fc ff df e8 26 da a7 fe 49 8d 5d 08 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 5c 91 0d ff 48 8b 1b 31 ff 48 89
RSP: 0018:ffffc9000325f758 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: ffff88801a3d9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000325fb18 R08: ffffffff82e4ba0a R09: ffffffff82ee14a9
R10: 0000000000000002 R11: ffff88801a3d9e00 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f4560dbd6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f45601000a0 CR3: 000000001d326000 CR4: 00000000003506f0
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
  1a:	e8 26 da a7 fe       	call   0xfea7da45
  1f:	49 8d 5d 08          	lea    0x8(%r13),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 5c 91 0d ff       	call   0xff0d9195
  39:	48 8b 1b             	mov    (%rbx),%rbx
  3c:	31 ff                	xor    %edi,%edi
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


Tested on:

commit:         911daf69 fs/ntfs3: Fix formatting, change comments, re..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1313ace9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f1c94a15f7c9744
dashboard link: https://syzkaller.appspot.com/bug?extid=9af29acd8f27fbce94bc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

