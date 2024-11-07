Return-Path: <linux-kernel+bounces-399479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371579BFF74
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89991F2281D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E70A19A2A3;
	Thu,  7 Nov 2024 07:57:30 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1908217DE36
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966249; cv=none; b=DMUjFdvzNeEGdc5mAJC9VSPcyL68mlXXliZOlgo/BvXholOqcJuBGRezfseMgZqWWUalCn80EBLnFtZpj21go+AXLOxd/vHxp6+3BinAK9ZQwcJjgzIIAVwBD4vdZ08dRLl/CCJAmeTorfwGb/M3NIt67I3qDAI5oqlT0CrEMTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966249; c=relaxed/simple;
	bh=SkOy3lw4z+BEiQbqXZ25wJH2RLjfLFsAL5LP4zqZwtw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WlML7L/n5SbgP4x0bfi2yUJq/lMiLQqkWmTtZ3NHrq4w9jg5mKOMzyS4yqgcmSDICYNMEYPdIGs7X+k7Flg0yMy+QDK11yOQfsFmDPKhyP7nZfUSpDyVtxJZ8RGQVge7MIRnK7uohD+SZTmicfGaxRRP0WQxcEl7AUe4ClwCVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83abf723da3so71450539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 23:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730966247; x=1731571047;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fZBO3A2qmgXvpCar68jWRY14mB2eEySgHezDfviWbw=;
        b=uor75gKK1klr6uHOjdQgF7q6tj6VfaX00BHviOtdjDnj3HDwwBsd01Iup5fNSzUQck
         MxdVnddvhiB9xa5LCOo+TQCHTJwsEGqUj8PSUaQ64UjVuHGUs2gH4RkMfan6JvhNAnU1
         FYAqFtdA552ezmym753Z5dH14DbUjTbHk1YW9Ck9SR4hbdugA7V7NMmOtNxWgJhWXUra
         Op5oFTMPRRxCGc3o5UDCIAFoktdGvuhmwdHIxGbFcu7hiR+XRQGFA1+3cXEIqSMtXUeD
         /LCheP7MFrxXxl8IBE4wCiaiEhOvLnnwODMqyNbpcLaemTj9nj7iCVcqOdNBg2lcWbEm
         aLGA==
X-Forwarded-Encrypted: i=1; AJvYcCVkD9en7LvPiQ/rXeibcjsMLKXtj/n1xhZzlAbX2l0l7y9gyJ9tdMFNtfcuh2tPfnMSCkf+D9P0J35qXfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8WKs7FKvX2XMPcE7uPK8XFcJIjnk1lEISP+QDsmpGaEU95wPx
	BcrYC3q8f/0j4Jq75d+96+MIkrlYAcJXmziyFxVSz1e+humXJjJCBTeO1pN4OiynLF5nUgdjZZH
	hpgrK+/ZQgETwPDVOiOUqSapWnRj04gGRRJggkrR3g07k44g5b9cWevA=
X-Google-Smtp-Source: AGHT+IFvqTEQSXR+nOR0mChKX0DlclYirOvHZ8IWJn8/m0k9f3siPs4pMN5E5axPPHoSvU2V2p9zSI2icvFHCvW4s3SsXFGs4S/1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1487:b0:3a6:aa75:5a59 with SMTP id
 e9e14a558f8ab-3a6b0288ce3mr232763965ab.1.1730966247206; Wed, 06 Nov 2024
 23:57:27 -0800 (PST)
Date: Wed, 06 Nov 2024 23:57:27 -0800
In-Reply-To: <000000000000ebc1a306219068a5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672c72e7.050a0220.31356.0002.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in get_pat_info
From: syzbot <syzbot+16b1da89309a06cd0e3a@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, guohui.study@gmail.com, 
	hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7758b206117d Merge tag 'tracefs-v6.12-rc6' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10f6bd5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=921b01cbfd887a9b
dashboard link: https://syzkaller.appspot.com/bug?extid=16b1da89309a06cd0e3a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148adf40580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1704ae30580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4535eeeccbd4/disk-7758b206.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7f34cce38f1/vmlinux-7758b206.xz
kernel image: https://storage.googleapis.com/syzbot-assets/626c3346b3bd/bzImage-7758b206.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+16b1da89309a06cd0e3a@syzkaller.appspotmail.com

Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffccfb961e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fc6265e02e9
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020ff6000
RBP: 0000000000000002 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000013 R11: 0000000000000246 R12: 00007fc626624153
R13: 00007ffccfb96260 R14: 00007fc62662a29c R15: 00007fc626624032
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5831 at arch/x86/mm/pat/memtype.c:983 get_pat_info+0x1eb/0x3f0 arch/x86/mm/pat/memtype.c:983
Modules linked in:
CPU: 0 UID: 0 PID: 5831 Comm: syz-executor181 Not tainted 6.12.0-rc6-syzkaller-00099-g7758b206117d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:get_pat_info+0x1eb/0x3f0 arch/x86/mm/pat/memtype.c:983
Code: 00 00 00 48 89 de e8 c4 e0 50 00 48 83 fb 20 75 13 48 83 7c 24 10 00 0f 84 5e 01 00 00 e8 cd db 50 00 eb 09 e8 c6 db 50 00 90 <0f> 0b 90 b8 ea ff ff ff 48 c7 44 24 20 0e 36 e0 45 48 b9 00 00 00
RSP: 0018:ffffc90003e37020 EFLAGS: 00010293
RAX: ffffffff8143fe3a RBX: 0000000000000000 RCX: ffff88807c4d9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000020
RBP: ffffc90003e37110 R08: ffffffff8143fe1c R09: 1ffffffff2037b8d
R10: dffffc0000000000 R11: fffffbfff2037b8e R12: 1ffff920007c6e08
R13: 1ffff1100f973597 R14: ffffc90003e37060 R15: ffff88807cb9ac98
FS:  0000555586d8f480(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 0000000033636000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 untrack_pfn+0x327/0x640 arch/x86/mm/pat/memtype.c:1085
 unmap_single_vma+0x1f6/0x2b0 mm/memory.c:1834
 zap_page_range_single+0x45c/0x630 mm/memory.c:1935
 remap_pfn_range_notrack+0xc8e/0xe10 mm/memory.c:2708
 remap_pfn_range+0x12c/0x1b0 mm/memory.c:2733
 usbdev_mmap+0x4ba/0x900 drivers/usb/core/devio.c:276
 call_mmap include/linux/fs.h:2172 [inline]
 mmap_region+0x1689/0x2940 mm/mmap.c:1450
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc6265e02e9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffccfb961e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fc6265e02e9
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020ff6000
RBP: 0000000000000002 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000013 R11: 0000000000000246 R12: 00007fc626624153
R13: 00007ffccfb96260 R14: 00007fc62662a29c R15: 00007fc626624032
 </TASK>
----------------
Code disassembly (best guess):
   0:	ff c3                	inc    %ebx
   2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
* 2a:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax <-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 c7 c1 b8 ff ff ff 	mov    $0xffffffffffffffb8,%rcx
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

