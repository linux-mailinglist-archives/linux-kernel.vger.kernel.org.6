Return-Path: <linux-kernel+bounces-261836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8977993BCC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC9C1C21316
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F0416DC04;
	Thu, 25 Jul 2024 06:54:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D714C84
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721890445; cv=none; b=NX7+MGnlUUiModRZ5WyFm0JwYRBX7onFZzC8x9aecCtCXOUb+93lx7iriQZ1lADlaBbxDl0tzCiygt+baAHKZliuTr5UlWBL5nTaozeljt3HEmT/LO8BbuH9wzsnuA4GoU/1CTDF97mjVqqiIL8ziEIzR/3q3UAuWAWnyc0mUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721890445; c=relaxed/simple;
	bh=RI4rl7qGQXyq0dIZXfsYQrsZsTYHeGhrcK5qL/gWwkQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pwwl2Ic77mDLF8Yt6Xg4VcdwcjOxqYJKzAWtC9HlitJ7r7G5J/+GYt2Zmaf/couFTgd4Qsokt3jrPuCjxp0uyWX4pY3cMRBHsrQN2455bMaJsaWGj0BEcIUAvVpsinvLAwgDY1Bt3YLLVmWX6mdkRK2zYNzjniNvsklIsE77XeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f66b3d69a8so97222439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 23:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721890443; x=1722495243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNoyADBIdthsBWCUUzyJ+WuklZlEc3Yeyi7NMBXun80=;
        b=s8jPOL6oBrxMAON/g3K3dgQRoLQNlgU6cgbF7PFTu6zfK5dfwH7px92rbFmEsDz/au
         3snvasUUI2Dn5XzyB0pXRuBGQPT+Jy7Awfn1CoJuQlQ36Y77oKx4mBKVs1zpETSrwqGy
         tvxKdY0Rk9a8uUrDIPPeK2K6/TLjDRTRRBQPrVWZ+B/kQPqGCAvqQBLwjShk03p1UTgE
         exumf8MylbcgAO5NAEQmCSQMPB978cSayVYB0T6tnn8hH/aCjy/DP8Zfj1/9BpzeEH66
         sPdjUhaqurM9uuFE4tSmz5RZ2Uhcf1bzIYhXJFN3wX3gFZ5JRxnXkGHDBr582CaiMWaX
         JViA==
X-Gm-Message-State: AOJu0YyWlNOnQqv+txF44uWU5LU0DoRhrDDbiTSDhIfbA3CRD8VPuBfb
	t73p+v51wg8eP98uoJinDUjt7tV05AkEc0tHXVHCdsXvf3V7AE3fZ+eoZ4oqskI+/mcIuceW0L0
	oreWZjjB99GWQY1vQ5gPmeShheFbGF9gkKbaWuIf16/NXjpxnMnZooPY=
X-Google-Smtp-Source: AGHT+IFfCv0stfAEKa/s8QYFWON1awcN5+mvF5zf4lDE1xWm023J1Xul9a2+2PRzTkIv9uN64zSzRGl/LOgGInlhfmYvXMjOnX3P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a9:b0:4c0:a8a5:81df with SMTP id
 8926c6da1cb9f-4c29bc7952fmr104300173.4.1721890443133; Wed, 24 Jul 2024
 23:54:03 -0700 (PDT)
Date: Wed, 24 Jul 2024 23:54:03 -0700
In-Reply-To: <20240725050750.3007233-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000349950061e0cdcdd@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
From: syzbot <syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in f2fs_start_gc_thread

F2FS-fs (loop0): Stopped filesystem due to reason: 0
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 7528 Comm: syz.0.131 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:f2fs_start_gc_thread+0x33a/0x570 fs/f2fs/gc.c:191
Code: 00 00 e8 39 21 a5 fd 4c 89 f7 e8 01 9a 74 fd 43 80 7c 3d 00 00 74 08 4c 89 e7 e8 61 16 08 fe 49 8b 1c 24 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 37 17 08 fe 4c 89 33 48 89 e8 48
RSP: 0018:ffffc9000b0a79d0 EFLAGS: 00010246

RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8bcacd20 RDI: 0000000000000001
RBP: ffff8880233dfd00 R08: ffffffff92fd071f R09: 1ffffffff25fa0e3
R10: dffffc0000000000 R11: fffffbfff25fa0e4 R12: ffff88807ed6d2c8
R13: 1ffff1100fdada59 R14: ffff88801a3bda00 R15: dffffc0000000000
FS:  00007f8ea496c6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c003b37000 CR3: 000000002cdaa000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 f2fs_remount+0x14eb/0x1c20 fs/f2fs/super.c:2440
 reconfigure_super+0x445/0x880 fs/super.c:1072
 vfs_cmd_reconfigure fs/fsopen.c:263 [inline]
 vfs_fsconfig_locked fs/fsopen.c:292 [inline]
 __do_sys_fsconfig fs/fsopen.c:473 [inline]
 __se_sys_fsconfig+0xb6e/0xf80 fs/fsopen.c:345
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8ea3b75b59
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8ea496c048 EFLAGS: 00000246
 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00007f8ea3d05f60 RCX: 00007f8ea3b75b59
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007f8ea3be4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8ea3d05f60 R15: 00007fffaa6511a8
 </TASK>
Modules linked in:
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	e8 39 21 a5 fd       	call   0xfda52140
   7:	4c 89 f7             	mov    %r14,%rdi
   a:	e8 01 9a 74 fd       	call   0xfd749a10
   f:	43 80 7c 3d 00 00    	cmpb   $0x0,0x0(%r13,%r15,1)
  15:	74 08                	je     0x1f
  17:	4c 89 e7             	mov    %r12,%rdi
  1a:	e8 61 16 08 fe       	call   0xfe081680
  1f:	49 8b 1c 24          	mov    (%r12),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 37 17 08 fe       	call   0xfe081770
  39:	4c 89 33             	mov    %r14,(%rbx)
  3c:	48 89 e8             	mov    %rbp,%rax
  3f:	48                   	rex.W


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15fbadb1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=1a8e2b31f2ac9bd3d148
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16adb055980000


