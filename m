Return-Path: <linux-kernel+bounces-449110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3645E9F4A01
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4DE188CF52
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5461E1EF0BE;
	Tue, 17 Dec 2024 11:34:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6B92F5B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435246; cv=none; b=sJmcxfXEkumaMxY4vuNaSHdKtKnFDFYAX/QbStX8mJGTsxCtrRHEtFKHbYbxW9vwTgy6olvVhbVhOn6bDp92F0rRlDHRacBsyC92T3hGclbtWXwEIdVAT2/5/k+16LglSZfJNBB2DeU//B7XVksEH+e0aOYxR9GkVIYpasih8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435246; c=relaxed/simple;
	bh=QkZ/rL1c0MO8J+L0rIr8PZlWLXODhRFtOxOC5sgE1Eg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KnoyK4WQFZutWuf+g9XFbNPx4wTlfZ3/ViOY/DbKgJijahiqzZHxNpthSnrRQexOAtVwUg9wuH74+obIj3MgluGUXxADqW78joLUeAkHJRukxKFO1gLTdaoNYsLf0I04lpdtpcX86dtyM4UXe3kXjFvB8IspAPGwCGfftr9B+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so93644685ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734435244; x=1735040044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bObw2I8fdAzJ1mjNvuseQwhGlRtdo8ULHXsuhmwT3Bs=;
        b=SHWCp6r+PZQ554wgQQa9o/hLrHVTAG6JfymlFOczsFPjaUIqDhKlvKaK/IQHFlwUcv
         QnI2RqT2P56JQ/XXUvobWcdEeLW0ixMAx9RLwRk82RUWJTj/RXq3yPNFNnMDGqcnkKJg
         2oP70a360NZ4PQjlwfP1vRRBd13rPv8pj9vPPcKhWfEM3RmLAyRAZtUJ0XYQ7wzhlIYk
         CiCisp0Kle9cv7uN/uFnyhWzv4P5wM6mTSj8hyXFdX6lqZyZAENW9pLeRH2qUaoyKw1w
         FqVTb5Di60vCzGTb094EdCEarnks+thp9tSD4Ud0K8k2Z/jmFC9gCskPlbIQo2LQDEZb
         3YaA==
X-Forwarded-Encrypted: i=1; AJvYcCXRKc13qbt2ZMTCSEci3L7rz2uIUgSXOQkpDSlSYC4tTFvKaY6hf3uyZsi6ZYNKqaiatBMVdc/0e3N4RbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy6UbyLan2UZ08kywoMe48LnMjH2xTb0bn0237mjMRSMRaNhlh
	czrfMrn/88TMnU5XUpOrBtjj56ocbKfzcJ9/EJE+Xat4m3CEE+HGtKlCHClqCjtKc8YoEDgt/w9
	JpogynnPjFVEjbj+YbHNIHBjkr/9hxZNpJ+xMdReap0gaBINA7HeYXL8=
X-Google-Smtp-Source: AGHT+IFj0s/jkIhWj7+HXVoW8hsp9zYZNaXXFBolRitgVD3elZISwWYH57Ob+4KSzUXTJWUQgmtyiBqQZCqX5hl70wfwPEhdZN0w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3308:b0:3a7:fe8c:b012 with SMTP id
 e9e14a558f8ab-3aff8c92a85mr156196285ab.18.1734435244390; Tue, 17 Dec 2024
 03:34:04 -0800 (PST)
Date: Tue, 17 Dec 2024 03:34:04 -0800
In-Reply-To: <20241217111514.207-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676161ac.050a0220.37aaf.016b.GAE@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in find_lock_task_mm
From: syzbot <syzbot+c2e074db555379260750@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in tomoyo_init_request_info

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000a: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
CPU: 0 UID: 0 PID: 12774 Comm: syz.0.2725 Not tainted 6.13.0-rc3-syzkaller-gf44d154d6e3d-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:tomoyo_init_request_info+0x6f/0x370 security/tomoyo/util.c:1028
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 98 02 00 00 48 8d 7d 50 48 89 6b 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e 5d 02 00 00 48 8d 7b 4b 44 0f b6 6d
RSP: 0018:ffffc9000d0af790 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffc9000d0af808 RCX: 0000000000000000
RDX: 000000000000000a RSI: ffffffff8452d8b7 RDI: 0000000000000050
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc9000d0af808 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000109002 R14: ffff88802d9bae80 R15: 0000000000000006
FS:  00007fb5170df6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb5170def98 CR3: 000000001ff52000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tomoyo_check_open_permission+0x27a/0x3c0 security/tomoyo/file.c:769
 tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
 security_file_open+0x84/0x1e0 security/security.c:3105
 do_dentry_open+0x57e/0x1ea0 fs/open.c:928
 vfs_open+0x82/0x3f0 fs/open.c:1075
 do_open fs/namei.c:3828 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3987
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb516385d19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb5170df038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fb516575fa0 RCX: 00007fb516385d19
RDX: 0000000000189002 RSI: 0000000020000100 RDI: ffffffffffffff9c
RBP: 00007fb516401a20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fb516575fa0 R15: 00007fff07409218
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:tomoyo_init_request_info+0x6f/0x370 security/tomoyo/util.c:1028
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 98 02 00 00 48 8d 7d 50 48 89 6b 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e 5d 02 00 00 48 8d 7b 4b 44 0f b6 6d
RSP: 0018:ffffc9000d0af790 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffc9000d0af808 RCX: 0000000000000000
RDX: 000000000000000a RSI: ffffffff8452d8b7 RDI: 0000000000000050
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc9000d0af808 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000109002 R14: ffff88802d9bae80 R15: 0000000000000006
FS:  00007fb5170df6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b7f5b65950 CR3: 000000001ff52000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 98 02 00 00    	jne    0x2a9
  11:	48 8d 7d 50          	lea    0x50(%rbp),%rdi
  15:	48 89 6b 10          	mov    %rbp,0x10(%rbx)
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 06                	je     0x38
  32:	0f 8e 5d 02 00 00    	jle    0x295
  38:	48 8d 7b 4b          	lea    0x4b(%rbx),%rdi
  3c:	44                   	rex.R
  3d:	0f                   	.byte 0xf
  3e:	b6 6d                	mov    $0x6d,%dh


Tested on:

commit:         f44d154d Merge tag 'soc-fixes-6.13' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126274f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
dashboard link: https://syzkaller.appspot.com/bug?extid=c2e074db555379260750
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15d9560f980000


