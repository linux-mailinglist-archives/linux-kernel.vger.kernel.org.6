Return-Path: <linux-kernel+bounces-345189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE7898B2EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532381C22C18
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA401B4C26;
	Tue,  1 Oct 2024 04:22:25 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE61922F3
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 04:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727756544; cv=none; b=C7KE1ZWsnKBHnKALBJh62vmb9rLJIYLO7LZZrS74JMO7gl1do/APF2E+0Kh++DwZ1Poe7Bvq95RU3pMwDisaGHqbgFVYCl5ldXlMa4POae2nURAVEgZFVBWYXCWh+v9sm7wDnHDXk7cPmTqqJscTAMc+fyYpbBWNvVnaQdyO63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727756544; c=relaxed/simple;
	bh=sIvcpuiD/FD4qqbjxk+UcEQImaDwZsRbIsWlgwBM5Ug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NrQmlDTa4AeijCDW1I3tsnBTxBd2OIrIcOvOUHt7GG/aWVMTkBTiYjlAZjP3fan/PUl3QsIuMo6KHgusR19p5G/2KHkMfDD12RPiSQc/UA2Vdo5NYM2ZBCSmV0fP9JrzVU7OD1mIJ9HIVjVXq1DfJl+lI7BGonCXwvdkOldbUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a342620d49so44879345ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 21:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727756542; x=1728361342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QavWdL1DyjcU9R+8l7PWa0/oB0XBaOASOBlkuITxzss=;
        b=FKTQYkrQJITRUfnQt4GpkIv4lQGY4nsuNoNt5gXre9eUirN6OISZvsgeD2kkymjRVV
         YUcl6bA4/W+GaHTH9d+eoOVLIxvxjZ1P2TA0Wl/IGyvJb0fxBbadn29rkQkHW05ixbwR
         JP6iqIEN7W93Y4aT9WaRu5B7Mo2Y6kSx79xdbjq8az2+3RKDoySkK9NHwhF3B5Lity6g
         uItAB5peMKQmAyAnoKdBvuGjPAStJRrMd3xncQ8v9qGObLCC9AEf8GaGp7Erbrg0I4UN
         2cPXbwfOIEpx5Xh0uGn33UQOdk03IGgV5FpbIpX+5iRJcCVqc5PnEKPwe5WoZ8pZvN/Z
         Otdg==
X-Forwarded-Encrypted: i=1; AJvYcCXQn4uZ6itVu04CXbpeyfaSd2UtEbDbC8+xC/QfxzaMpZyeyjDImK3sz/JFmO/txYe2Sewky8tFTWpxDVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSSAWQISg1HG0Gu8+smGQM4Io3klC9Z2H2sKrXQ6R0BwGyuDpR
	IWfAQahgwaKFvA71WK1fYx7jlkdV8vR4GGaOB9YkcD8XVBpXcZv1XUJ7cU54KaiZpfbZVlllwlr
	xM/ya7gVkGO+R6OZiX20bEPrjtA6iW7FqTsLV2dA0A/uDntEsv74pftA=
X-Google-Smtp-Source: AGHT+IF4H7CI1ajJU1w+s0nH1jCKg1b7FSFol6ScnpEOEMLHAww9D+Znb+D3cmIvw7wBsYMY8z/GlzQTiOvcoBUXonWJUfkMWHQw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c266:0:b0:3a0:8ecb:a1dc with SMTP id
 e9e14a558f8ab-3a34517fac8mr122063455ab.15.1727756542256; Mon, 30 Sep 2024
 21:22:22 -0700 (PDT)
Date: Mon, 30 Sep 2024 21:22:22 -0700
In-Reply-To: <66faaa4e.050a0220.aab67.0032.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fb78fe.050a0220.6bad9.004b.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: out-of-bounds Read in copy_from_kernel_nofault
From: syzbot <syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, snovitoll@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    cea5425829f7 Add linux-next specific files for 20240930
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1250fd07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41a28720ed564c6a
dashboard link: https://syzkaller.appspot.com/bug?extid=61123a5daeb9f7454599
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153c439f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1603f127980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/566995596f19/disk-cea54258.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e7c506c1c71d/vmlinux-cea54258.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7fcb4468b8c0/bzImage-cea54258.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: out-of-bounds in instrument_memcpy_before include/linux/instrumented.h:163 [inline]
BUG: KASAN: out-of-bounds in copy_from_kernel_nofault+0x7a/0x2f0 mm/maccess.c:35
Read of size 6 at addr fffffffffffffffd by task syz-executor167/5229

CPU: 1 UID: 0 PID: 5229 Comm: syz-executor167 Not tainted 6.12.0-rc1-next-20240930-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_memcpy_before include/linux/instrumented.h:163 [inline]
 copy_from_kernel_nofault+0x7a/0x2f0 mm/maccess.c:35
 bpf_probe_read_kernel_common include/linux/bpf.h:2960 [inline]
 ____bpf_probe_read_kernel kernel/trace/bpf_trace.c:239 [inline]
 bpf_probe_read_kernel+0x2a/0x70 kernel/trace/bpf_trace.c:236
 bpf_prog_fe7b69aea4fa28bf+0x43/0x45
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x4b1/0xa90 net/bpf/test_run.c:431
 bpf_prog_test_run_xdp+0x7da/0x11e0 net/bpf/test_run.c:1319
 bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
 __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f50ec364bb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed45c06d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f50ec364bb9
RDX: 000000000000003b RSI: 0000000020000240 RDI: 000000000000000a
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Memory state around the buggy address:
 fffffffffffffe80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffffffffff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffffffffffff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 5229 Comm: syz-executor167 Not tainted 6.12.0-rc1-next-20240930-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:kasan_metadata_fetch_row+0x12/0x30 mm/kasan/report_generic.c:186
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ee 03 48 b8 00 00 00 00 00 fc ff df <48> 8b 0c 06 48 8b 44 06 08 48 89 47 08 48 89 0f c3 cc cc cc cc 66
RSP: 0018:ffffc90002f5f6d8 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: cc1757ac84471d00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90002f5f710
RBP: ffffc90002f5f758 R08: ffffffff8bc0f2d3 R09: 0000000000000020
R10: dffffc0000000000 R11: fffff520005ebee1 R12: ffffc90002f5f710
R13: 0000000000000080 R14: ffffffffffffff80 R15: ffffc90002f5f6f0
FS:  000055558e6ce380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f50ec3db0d0 CR3: 0000000073e8a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 print_memory_metadata mm/kasan/report.c:464 [inline]
 print_report+0x4df/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_memcpy_before include/linux/instrumented.h:163 [inline]
 copy_from_kernel_nofault+0x7a/0x2f0 mm/maccess.c:35
 bpf_probe_read_kernel_common include/linux/bpf.h:2960 [inline]
 ____bpf_probe_read_kernel kernel/trace/bpf_trace.c:239 [inline]
 bpf_probe_read_kernel+0x2a/0x70 kernel/trace/bpf_trace.c:236
 bpf_prog_fe7b69aea4fa28bf+0x43/0x45
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x4b1/0xa90 net/bpf/test_run.c:431
 bpf_prog_test_run_xdp+0x7da/0x11e0 net/bpf/test_run.c:1319
 bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
 __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f50ec364bb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed45c06d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f50ec364bb9
RDX: 000000000000003b RSI: 0000000020000240 RDI: 000000000000000a
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_metadata_fetch_row+0x12/0x30 mm/kasan/report_generic.c:186
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ee 03 48 b8 00 00 00 00 00 fc ff df <48> 8b 0c 06 48 8b 44 06 08 48 89 47 08 48 89 0f c3 cc cc cc cc 66
RSP: 0018:ffffc90002f5f6d8 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: cc1757ac84471d00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90002f5f710
RBP: ffffc90002f5f758 R08: ffffffff8bc0f2d3 R09: 0000000000000020
R10: dffffc0000000000 R11: fffff520005ebee1 R12: ffffc90002f5f710
R13: 0000000000000080 R14: ffffffffffffff80 R15: ffffc90002f5f6f0
FS:  000055558e6ce380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f50ec3db0d0 CR3: 0000000073e8a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   7:	00
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	66 0f 1f 00          	nopw   (%rax)
  1c:	48 c1 ee 03          	shr    $0x3,%rsi
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	48 8b 0c 06          	mov    (%rsi,%rax,1),%rcx <-- trapping instruction
  2e:	48 8b 44 06 08       	mov    0x8(%rsi,%rax,1),%rax
  33:	48 89 47 08          	mov    %rax,0x8(%rdi)
  37:	48 89 0f             	mov    %rcx,(%rdi)
  3a:	c3                   	ret
  3b:	cc                   	int3
  3c:	cc                   	int3
  3d:	cc                   	int3
  3e:	cc                   	int3
  3f:	66                   	data16


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

