Return-Path: <linux-kernel+bounces-344161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2883B98A592
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D914F281D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46C31917D7;
	Mon, 30 Sep 2024 13:40:34 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85818FC89
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703634; cv=none; b=BTy5pKshvkPktlQlNlLptgTmoztjfEPd4sHkprg/W24nXDndyFXFDJH9Iy1/jNMkgqkg6niv3NN8LLEHyDPg1fYnwgZH5WL+t950WScbSK//8KZSk2nGO24/inLUnRW9w37KYJR2mcpglyRMvXhU7V1bYhwpgxzGbt2WOyXjpMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703634; c=relaxed/simple;
	bh=xTmKBwtSoHwYhm2BkIMCxTW8TAEs6GMTKBklXSGAM6g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YUYQ9e6CgudqAlA+oLcolWp38bZnXxcWQhgDE0UPtc3Ih7CWIhyy0L7k3wUWRQBF+Mm2YKDptBhPotmOZjKVhmAO9A4E2SVR+yaGd+eUy4nrRZ3nYZIggFAHBx4iTlmoDZSrqNkqmcRuj9wtEFyVkdKlklV61m+bR5KjKQVZsdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1a6d8bb03so65746015ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 06:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703630; x=1728308430;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ww1t5+M4tl8GtMFFCaXNxZDxMXkvRcWNQLbhwTybYo=;
        b=Z1d3qyN8tficfOZW95nUNCyR5DQ+k3CmoU017E+Df0u0eOqhCstGuD2p1pyaHiDDSQ
         EhUStEHkEoj0ytMOl1Hqum2om6se9t54TFOo8akmUAMS9bkQaCfwkxa0+6OPn/QbQVEE
         cIZZKizYpaazRneoBM3406zyNenBDygT/msqpUKIPCB8gLneMu8a6gI5eGBxe16N5Tau
         OHOCd77y3piWbhIiUN27nZUQeqIKkswZPvY8zQ1J3yVeqEdlqZgbFcu2r0BhVbVa7Two
         sDFMsiVFGQGGmDqDIK1et+gwX7uil3e2SCcwQK0cboEBt1fG9M/S9L05c29AzeXNcajm
         lncA==
X-Forwarded-Encrypted: i=1; AJvYcCVO5J8hwWy4r2YZZdDYY35HW4bJatS8AMCSa6PMu8nCar0yAh6+UxMEGihfl6vy2BMRrUkcghumFoDDQcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNMq/jtew1nCJHBxK72t2pn/e949+CapMMcDNt5TUoyYq+vIkx
	K2f/ovmGV0ifOysUg3rUCQb+s4o5LQQUthn7NpJQ9qd3LyIVMjbCiHT1utlYPaJl5BlZxaLDqMw
	3Ul2gPrELILEJxDUGgveU89YgGQaHFxh+G6wDDI5gQiaxIF4hZa1NUws=
X-Google-Smtp-Source: AGHT+IGrKOUfAoR84r5Uk6ZI6PdsuuLkPdaJ3B14SRBX7ML9/1lqDbmCQZinY0wWEga7C0QjkxM6kftYu334EhKi+xwY1jVQeKf/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ce:b0:3a2:91f:497b with SMTP id
 e9e14a558f8ab-3a34517e85dmr95069955ab.13.1727703630504; Mon, 30 Sep 2024
 06:40:30 -0700 (PDT)
Date: Mon, 30 Sep 2024 06:40:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66faaa4e.050a0220.aab67.0032.GAE@google.com>
Subject: [syzbot] [mm?] KASAN: out-of-bounds Read in copy_from_kernel_nofault
From: syzbot <syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cea5425829f7 Add linux-next specific files for 20240930
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14eccea9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41a28720ed564c6a
dashboard link: https://syzkaller.appspot.com/bug?extid=61123a5daeb9f7454599
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/566995596f19/disk-cea54258.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e7c506c1c71d/vmlinux-cea54258.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7fcb4468b8c0/bzImage-cea54258.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: out-of-bounds in instrument_memcpy_before include/linux/instrumented.h:163 [inline]
BUG: KASAN: out-of-bounds in copy_from_kernel_nofault+0x7a/0x2f0 mm/maccess.c:35
Read of size 6 at addr fffffffffffffffd by task syz.1.54/5558

CPU: 1 UID: 0 PID: 5558 Comm: syz.1.54 Not tainted 6.12.0-rc1-next-20240930-syzkaller #0
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
RIP: 0033:0x7f5e6c17dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5e6d02a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f5e6c335f80 RCX: 00007f5e6c17dff9
RDX: 000000000000003b RSI: 0000000020000240 RDI: 000000000000000a
RBP: 00007f5e6c1f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f5e6c335f80 R15: 00007ffdc493ae58
 </TASK>

Memory state around the buggy address:
 fffffffffffffe80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffffffffff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffffffffffff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 5558 Comm: syz.1.54 Not tainted 6.12.0-rc1-next-20240930-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:kasan_metadata_fetch_row+0x12/0x30 mm/kasan/report_generic.c:186
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ee 03 48 b8 00 00 00 00 00 fc ff df <48> 8b 0c 06 48 8b 44 06 08 48 89 47 08 48 89 0f c3 cc cc cc cc 66
RSP: 0018:ffffc900049976d8 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 78f03800465e2000
RDX: ffffc900045d9000 RSI: 0000000000000000 RDI: ffffc90004997710
RBP: ffffc90004997758 R08: ffffffff8bc0f2d3 R09: 0000000000000020
R10: dffffc0000000000 R11: fffff52000932ee1 R12: ffffc90004997710
R13: 0000000000000080 R14: ffffffffffffff80 R15: ffffc900049976f0
FS:  00007f5e6d02a6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558b7a5808 CR3: 000000003075e000 CR4: 00000000003526f0
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
RIP: 0033:0x7f5e6c17dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5e6d02a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f5e6c335f80 RCX: 00007f5e6c17dff9
RDX: 000000000000003b RSI: 0000000020000240 RDI: 000000000000000a
RBP: 00007f5e6c1f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f5e6c335f80 R15: 00007ffdc493ae58
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_metadata_fetch_row+0x12/0x30 mm/kasan/report_generic.c:186
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ee 03 48 b8 00 00 00 00 00 fc ff df <48> 8b 0c 06 48 8b 44 06 08 48 89 47 08 48 89 0f c3 cc cc cc cc 66
RSP: 0018:ffffc900049976d8 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 78f03800465e2000
RDX: ffffc900045d9000 RSI: 0000000000000000 RDI: ffffc90004997710
RBP: ffffc90004997758 R08: ffffffff8bc0f2d3 R09: 0000000000000020
R10: dffffc0000000000 R11: fffff52000932ee1 R12: ffffc90004997710
R13: 0000000000000080 R14: ffffffffffffff80 R15: ffffc900049976f0
FS:  00007f5e6d02a6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558b7a5808 CR3: 000000003075e000 CR4: 00000000003526f0
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
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

