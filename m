Return-Path: <linux-kernel+bounces-572898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACBCA6D00D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECFE1891B23
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EC113E02D;
	Sun, 23 Mar 2025 16:49:27 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BC835893
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742748567; cv=none; b=l5acAGSKP30umlRf2FjjPdRePJUuaIIAM1kkyK0SaqG3mXPi8+UGpIKmL8aN8ZF1ZvgH/tAH6pdLZZrPGJ69NVKCLgYvb/LuB8allMVdVu7sGzLPuHZ/cPdWRsiBqHJPSJetlITJnAzU8zb6ErqtL7ouO1lwvKrONYtHKYV5K8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742748567; c=relaxed/simple;
	bh=HS9eJlp/CFEP7vi77KNVQ0mi0+14uVSUP0fxcO5xndQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ygovr1UiiPxTOBAvapret8w2patFixpH3XSfpPVQ0lYloDhJMOqFzOEdJov2PU6D4jL+0YxuRcNUQ3tLY+2S8Z1Sr+wrpqq28ltUV1cdMnkUKelrleIrpkvwGhF6WfA+OlnFXKUvvphvnWAL4Htq38y0s6e7Ebwptunw3OVXSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d5a9e7dd5aso2897565ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 09:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742748564; x=1743353364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1K/68S4OqioDylsGfQbj1ArMhhEArjI36Bsf8QVhEk=;
        b=LybDtI51uS7L6Mz4W0Nm3EY9Wvzd9zXQez+iODNIwAUt2Z/S63ZZmNiRThFK0LOKLU
         VdKsjYJ4MF5f5ugsaek2+q9e95oSd5iRC0Ha2XhkxZk3lhDwB9MAjA9wwl94Q8naOqpS
         qyYbAyWDyr8lEQHw6ekW02I/RGV30Uy+O0ugCAqbtkxGY0pcHPUV4R3dXzh++8+m/e+U
         WOVtxj5lp+/JO9Ls/nYDQQl5ahcduRUblw5DxWHvnDcFKqCpLHKfgOAwsWCBxJi7P8bF
         ykK28fvA3iDjYOyRb+a0Lwd88TkZcj6hV2EXNfmOEJWwn1pTb8vrgX5tqQBZG8wXhVKD
         RURw==
X-Forwarded-Encrypted: i=1; AJvYcCVvdUqH4OdY1F9B35vG8FUi4SdMtWf4tcWN4dld8o4cYUMLMrNXELbHwOi9vaeil79pmSWEq0LZ7Qs9smw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxloBpH/cj8eNK+fA1uG5F3ichGBx6DJ95su2ju86CVKK0UuT0V
	/j7Osq20RgsHwfDxtGnJryGB+0/gXux9fmxs19VM9oo+OY9+c5DDLM12vbk69B/MmGR6vju3hnh
	fqGeAeANvSjp326GoXxS0QT4y+CfKP5PlABVyaUY2/vhBkeO1LGo24OA=
X-Google-Smtp-Source: AGHT+IEgm/UDkvAHeiJntjWmyHAaiY4bPxTPEsPq5BclJIAfecGG+wxA+hvJ52EYob3UYEBcxZOUKD+4WnWBzPPHFY7BV3GbhdKR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cf:b0:3d4:2362:98d8 with SMTP id
 e9e14a558f8ab-3d5960cd0dcmr100813435ab.2.1742748564374; Sun, 23 Mar 2025
 09:49:24 -0700 (PDT)
Date: Sun, 23 Mar 2025 09:49:24 -0700
In-Reply-To: <67dc67f0.050a0220.25ae54.001e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e03b94.050a0220.31a16b.0061.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in vma_merge_existing_range
From: syzbot <syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, pfalcato@suse.de, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    586de92313fc Merge tag 'i2c-for-6.14-rc8' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=162b7e98580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e330e9768b5b8ff
dashboard link: https://syzkaller.appspot.com/bug?extid=20ed41006cf9d842c2b5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1196f3b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d3dc4c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3cb302fb058e/disk-586de923.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d42da95fefe/vmlinux-586de923.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5a9e686ee97d/bzImage-586de923.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com

RSP: 002b:00007fb22df1c208 EFLAGS: 00000246 ORIG_RAX: 0000000000000013
RAX: 0000000000000020 RBX: 00007fb22dfeb3c8 RCX: 00007fb22df69099
RDX: 0000000000000006 RSI: 0000200000000240 RDI: 0000000000000003
RBP: 00007fb22dfeb3c0 R08: 00007fb22df1bfa7 R09: 0000000000000033
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb22dfb8284
R13: 00007fb22df1c210 R14: 0000000000000001 R15: 0000200000000240
 </TASK>
BUG: unable to handle page fault for address: fffffffffffffff4
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD df84067 P4D df84067 PUD df86067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5822 Comm: syz-executor515 Not tainted 6.14.0-rc7-syzkaller-00205-g586de92313fc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:vma_merge_existing_range+0x266/0x2070 mm/vma.c:734
Code: e8 0f 47 ac ff 48 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 1c 19 00 00 48 8b 04 24 48 8b 74 24 08 <4c> 8b 38 4c 89 ff e8 4f 41 ac ff 48 8b 44 24 08 49 39 c7 0f 83 db
RSP: 0018:ffffc900034d7950 EFLAGS: 00010246
RAX: fffffffffffffff4 RBX: ffffc900034d7ab0 RCX: ffffffff820db0e5
RDX: 1ffffffffffffffe RSI: 0000200000807000 RDI: 0000000000000005
RBP: 0000200000ce2000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: ffffc900034d7ad0 R14: ffff8880349961f0 R15: ffff8880122a6e00
FS:  00007fb22df1c6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff4 CR3: 000000007d69e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vma_modify.constprop.0+0x87/0x410 mm/vma.c:1517
 vma_modify_flags_uffd+0x241/0x2e0 mm/vma.c:1598
 userfaultfd_clear_vma+0x91/0x130 mm/userfaultfd.c:1906
 userfaultfd_release_all+0x2ae/0x4c0 mm/userfaultfd.c:2024
 userfaultfd_release+0xf4/0x1c0 fs/userfaultfd.c:865
 __fput+0x3ff/0xb70 fs/file_table.c:464
 task_work_run+0x14e/0x250 kernel/task_work.c:227
 ptrace_notify+0x10e/0x130 kernel/signal.c:2522
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work kernel/entry/common.c:173 [inline]
 syscall_exit_to_user_mode_prepare+0x126/0x290 kernel/entry/common.c:200
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x11/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb22df69099
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 1b 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb22df1c208 EFLAGS: 00000246 ORIG_RAX: 0000000000000013
RAX: 0000000000000020 RBX: 00007fb22dfeb3c8 RCX: 00007fb22df69099
RDX: 0000000000000006 RSI: 0000200000000240 RDI: 0000000000000003
RBP: 00007fb22dfeb3c0 R08: 00007fb22df1bfa7 R09: 0000000000000033
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb22dfb8284
R13: 00007fb22df1c210 R14: 0000000000000001 R15: 0000200000000240
 </TASK>
Modules linked in:
CR2: fffffffffffffff4
---[ end trace 0000000000000000 ]---
RIP: 0010:vma_merge_existing_range+0x266/0x2070 mm/vma.c:734
Code: e8 0f 47 ac ff 48 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 1c 19 00 00 48 8b 04 24 48 8b 74 24 08 <4c> 8b 38 4c 89 ff e8 4f 41 ac ff 48 8b 44 24 08 49 39 c7 0f 83 db
RSP: 0018:ffffc900034d7950 EFLAGS: 00010246
RAX: fffffffffffffff4 RBX: ffffc900034d7ab0 RCX: ffffffff820db0e5
RDX: 1ffffffffffffffe RSI: 0000200000807000 RDI: 0000000000000005
RBP: 0000200000ce2000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: ffffc900034d7ad0 R14: ffff8880349961f0 R15: ffff8880122a6e00
FS:  00007fb22df1c6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff4 CR3: 000000007d69e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 0f 47 ac ff       	call   0xffac4714
   5:	48 8b 14 24          	mov    (%rsp),%rdx
   9:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  10:	fc ff df
  13:	48 c1 ea 03          	shr    $0x3,%rdx
  17:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  1b:	0f 85 1c 19 00 00    	jne    0x193d
  21:	48 8b 04 24          	mov    (%rsp),%rax
  25:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
* 2a:	4c 8b 38             	mov    (%rax),%r15 <-- trapping instruction
  2d:	4c 89 ff             	mov    %r15,%rdi
  30:	e8 4f 41 ac ff       	call   0xffac4184
  35:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  3a:	49 39 c7             	cmp    %rax,%r15
  3d:	0f                   	.byte 0xf
  3e:	83                   	.byte 0x83
  3f:	db                   	.byte 0xdb


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

