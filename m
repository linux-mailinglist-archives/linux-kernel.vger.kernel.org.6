Return-Path: <linux-kernel+bounces-221284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C641D90F14C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5051F23B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242F5146D53;
	Wed, 19 Jun 2024 14:50:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2BE36B11
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808606; cv=none; b=Mg5NXAVCJHoVp+bQbmsmea59wRYBy1oL7OXHDXtkWdwMIqfmtgIQ1ECGXLNX4RIB1yHOBwSpiBGkq3t6zpXKzhv1cfih1F2uL1z4nY12JduvJy4AlFaKGDr7txIfgIhxETuFkI+9yp+29FEcZv+qabX4QKGrHYicpg1x/eZrLlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808606; c=relaxed/simple;
	bh=uK1P5wfhalaY7+I1v36VGG7UGfvFiKBEgkp5qH/16hw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZPUWpsXyNsTOgUUsNCNLVj8zPflnsv1mWlFRr3y2p4hblVpQHG9bWkDGH21ZWe9kFrMzBfBqOxPSPpL+ooOZ4UxsTfUF+Cpr+VHFIuNkkParEBEK9oxfyc8flkByM+YHMDQthDovDMo0PUar9J6bC7rJSH0jWKdRJMOK75VZrp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-375df29cb12so66187555ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718808604; x=1719413404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OpuwsTaRyizt6ukmLJAGzDnCZjoN8K33L7I69r4c+E=;
        b=sUUy2V9ixy5QlZJ9160SEblQ2WE9kqYNG9+FvQAcBT9Y9+CkB86S0GI1qmqCgr91f1
         Y+PaqJBjT65yoSku+vA8BEyGehM5KwxGsMOSKfUeqIQAm/kMgoR+FZYyOgq8Q7kyRWSC
         l7NMnPAl2t/MwG0/r++6Ub6zVnegiiK/w0Dm4qh7dQL7Y+FJWRE/jHE74ih3gBGjQuEi
         vNoTSW3kiaZ0J+0sIeXHQ2wXLqgvkjUvR0rbWMgkz7gxMQqgcvbksUyGkOQs2xbHD8LG
         r5cyc3Qo3pOqUyUobZQLV1ymYrzWFB7yRGSyGNsRt1uVP+NMOKHwGFGrjiLpzzfrhHHR
         FSJg==
X-Gm-Message-State: AOJu0Yx9Q3lNrKVKUdbo/wsYlRPR1f5UOnoEnoDlTZSRbOHsFAiknqvv
	ZiAu0iwTelwl2sQGennBAkvbMzWDaTOXCTHfqM07sSeopYhWGZr+vW/d8Y629ITdxf76zvSur9f
	wZoNsPLaPHvB7ZSflAom0wE73NPD/IzVREsKr/eoF6zAKkvCTyxe6ZlI=
X-Google-Smtp-Source: AGHT+IFKHX2Rag4vLzQT/jScXdJD7wsLhI2I2VywvkY+QqXMJ7lc/R8kCMDRZIKzK/+3DGMOhPyiVr+Y6smYKev9QN6/Uv6dnDdm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4b:b0:375:a013:729f with SMTP id
 e9e14a558f8ab-3761d7707a1mr1485865ab.4.1718808604178; Wed, 19 Jun 2024
 07:50:04 -0700 (PDT)
Date: Wed, 19 Jun 2024 07:50:04 -0700
In-Reply-To: <PN2PR01MB4891B3CD4C11DCC8DDD854FAFCCF2@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a1500061b3f500f@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in bpf_probe_read_kernel_str
From: syzbot <syzbot+a0fa177e13690b663c74@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in bpf_probe_read_kernel_str

BUG: unable to handle page fault for address: ffffffffff600000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD df36067 P4D df36067 PUD df38067 PMD df5b067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 4523 Comm: udevd Not tainted 6.8.0-rc1-syzkaller-00199-gee0e39a63b78 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:strncpy_from_kernel_nofault+0x8d/0x1d0 mm/maccess.c:91
Code: 00 48 89 d0 48 c1 e8 03 48 89 44 24 10 0f b6 04 28 84 c0 48 89 14 24 0f 85 d9 00 00 00 ff 02 45 31 f6 49 89 df 48 8b 54 24 08 <42> 8a 1c 33 4a 8d 3c 32 48 89 f8 48 c1 e8 03 49 89 ec 0f b6 04 28
RSP: 0018:ffffc9000318f828 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffff600000 RCX: ffff88807b8f3b80
RDX: ffffc9000318f8a0 RSI: ffffffffff600000 RDI: ffffffffff600000
RBP: dffffc0000000000 R08: ffffffff8141da1d R09: 1ffffffff2590c84
R10: dffffc0000000000 R11: ffffffffa00016e8 R12: ffffffffff600000
R13: 0000000000000005 R14: 0000000000000000 R15: ffffffffff600000
FS:  00007f0b374b1c80(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600000 CR3: 000000002981c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_probe_read_kernel_str_common kernel/trace/bpf_trace.c:266 [inline]
 ____bpf_probe_read_kernel_str kernel/trace/bpf_trace.c:275 [inline]
 bpf_probe_read_kernel_str+0x2a/0x70 kernel/trace/bpf_trace.c:272
 bpf_prog_ef3a4661c9d1378e+0x4a/0x4c
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x28e/0x380 mm/slub.c:4396
 tomoyo_realpath_from_path+0xc2/0x5e0 security/tomoyo/realpath.c:250
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x2b7/0x740 security/tomoyo/file.c:822
 tomoyo_path_unlink+0xd0/0x110 security/tomoyo/tomoyo.c:162
 security_path_unlink+0xe1/0x140 security/security.c:1851
 do_unlinkat+0x3e6/0x830 fs/namei.c:4395
 __do_sys_unlink fs/namei.c:4446 [inline]
 __se_sys_unlink fs/namei.c:4444 [inline]
 __x64_sys_unlink+0x49/0x60 fs/namei.c:4444
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f0b37117da7
Code: f0 ff ff 73 01 c3 48 8b 0d 7e 90 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 51 90 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffeacb64188 EFLAGS: 00000202 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: ffffffffffffffff RCX: 00007f0b37117da7
RDX: fffffffffffffe60 RSI: 00007ffeacb64260 RDI: 000055bb027950d8
RBP: 000000000000000b R08: 0000000000000007 R09: 2905dc5b2145fa13
R10: c8f27f571a018b9b R11: 0000000000000202 R12: 0000000000000bb8
R13: 0000000200000001 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: ffffffffff600000
---[ end trace 0000000000000000 ]---
RIP: 0010:strncpy_from_kernel_nofault+0x8d/0x1d0 mm/maccess.c:91
Code: 00 48 89 d0 48 c1 e8 03 48 89 44 24 10 0f b6 04 28 84 c0 48 89 14 24 0f 85 d9 00 00 00 ff 02 45 31 f6 49 89 df 48 8b 54 24 08 <42> 8a 1c 33 4a 8d 3c 32 48 89 f8 48 c1 e8 03 49 89 ec 0f b6 04 28
RSP: 0018:ffffc9000318f828 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffff600000 RCX: ffff88807b8f3b80
RDX: ffffc9000318f8a0 RSI: ffffffffff600000 RDI: ffffffffff600000
RBP: dffffc0000000000 R08: ffffffff8141da1d R09: 1ffffffff2590c84
R10: dffffc0000000000 R11: ffffffffa00016e8 R12: ffffffffff600000
R13: 0000000000000005 R14: 0000000000000000 R15: ffffffffff600000
FS:  00007f0b374b1c80(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600000 CR3: 000000002981c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	d0 48 c1             	rorb   -0x3f(%rax)
   6:	e8 03 48 89 44       	call   0x4489480e
   b:	24 10                	and    $0x10,%al
   d:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax
  11:	84 c0                	test   %al,%al
  13:	48 89 14 24          	mov    %rdx,(%rsp)
  17:	0f 85 d9 00 00 00    	jne    0xf6
  1d:	ff 02                	incl   (%rdx)
  1f:	45 31 f6             	xor    %r14d,%r14d
  22:	49 89 df             	mov    %rbx,%r15
  25:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
* 2a:	42 8a 1c 33          	mov    (%rbx,%r14,1),%bl <-- trapping instruction
  2e:	4a 8d 3c 32          	lea    (%rdx,%r14,1),%rdi
  32:	48 89 f8             	mov    %rdi,%rax
  35:	48 c1 e8 03          	shr    $0x3,%rax
  39:	49 89 ec             	mov    %rbp,%r12
  3c:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax


Tested on:

commit:         ee0e39a6 x86/mm: Move is_vsyscall_vaddr() into asm/vsy..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=15ab2d41980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e23375d0c3afdc8
dashboard link: https://syzkaller.appspot.com/bug?extid=a0fa177e13690b663c74
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

