Return-Path: <linux-kernel+bounces-193446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF17D8D2C73
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BDC1C20F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE1615B99F;
	Wed, 29 May 2024 05:34:24 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151176AB8
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960863; cv=none; b=Alo+YYfNP05XU5jF9sCdAYDEdx34c1ztgD0XE7wmC2xnF0zloGfRg3SYGtvc2Z2aoMloP0oSp03suhCHhkVcfpeaHwm9hy4jF5x0LsY6H94T4M1O44vEra6CkophO13uSwLA8AJ3mr+yPHPJWj991K/tG8lzeia9TAO2bOIz9A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960863; c=relaxed/simple;
	bh=CaNnq8k4YQZNdQbbSPcF+Z8xZlP5WMKeXXwmId6Hqek=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lSflqV994YAIoSjl5FbPzsmbuV+vQ2rtnKrZ4mBpDUSwmTYu2fOhbpEfvLK8lp8fqJX+lOpn+n/wk8LNRkSkPZn52hz96I5YzgLLLVUXE/o5I0fXK6KDmxI/3KQwNeZZrr7AXnVf8UIek3C9tyNsUq2MHTlG5/q/Tsxxi1xBy/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3745c784b14so15846825ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716960861; x=1717565661;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrVKq70kkA6vdT3r55THcNAVMBuPTCNTiqIdDEs/nPA=;
        b=McMKAFaLpdGpxrukaQmr1K+eDUh/oSTqnaDxkRjON76XjE70N+4AxZoBySGvLvStj/
         h8sTAmAkEAWTd5QPkNLJekKJgwMI8DhGT5q+cVzOOkM7szt6lWVZvotuLQUWH590mWYF
         VPsU9SKI0YSrUkJTLLltlHLHNO8a8vCOUdvzsGpNFaKMeFqoAow/E6GzCYljUPwIC5r+
         MvEDvttWxoOFzimm1KiMNol3FFyylPQBcCOgSEw0FMhoKbjMH+FA2a9IuntqMry2c/oy
         gkUHygQSdZj4MWrg7huC1U2e9RtvCPr3v7azfoJ9pg2kfI999al5YijdviGbYDQXrbfG
         5Agg==
X-Gm-Message-State: AOJu0YycSORdkE6PEEsF1pzpnorMDEOskBYl8DRBttBUHlfKf7XFSSi/
	Q+0uz9nUA1bljc/DtFvTcsaiZrbm/hhXAmDlluW9jg3sR/S++p4ZW0+ENuufmnDAYWFEjC1LZaV
	m8aq6q/fkKqQAK4t9Cl1aSSMq3UJHfP13rvHPCGR4zqrzEPtONjo9OXi3TA==
X-Google-Smtp-Source: AGHT+IGAVrbHGuaHaP4ioFsVVPhJjrVuuWwH/oRUFTGS2KIUEx47sJDc3Kp5+Vu4/pEXiL1yPmFvSA7rfc+zrThwpvX+oZdLSAuY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b05:b0:36c:5029:1925 with SMTP id
 e9e14a558f8ab-3737b1cbb5dmr9693995ab.0.1716960861285; Tue, 28 May 2024
 22:34:21 -0700 (PDT)
Date: Tue, 28 May 2024 22:34:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003afc580619911a8e@google.com>
Subject: [syzbot] [kernel?] BUG: unable to handle kernel paging request in account_kernel_stack
From: syzbot <syzbot+a30127d9bca2a4c7f8e1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    02c438bbfffe Merge tag 'for-6.10-tag' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170c2784980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=21de3d423116c304
dashboard link: https://syzkaller.appspot.com/bug?extid=a30127d9bca2a4c7f8e1
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ce50d8980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c3a210980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-02c438bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/27e89a0db9ef/vmlinux-02c438bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e281415dcb64/Image-02c438bb.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a30127d9bca2a4c7f8e1@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 007fc1ffc01c13c8
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[007fc1ffc01c13c8] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:

CPU: 0 PID: 3194 Comm: syz-executor208 Not tainted 6.9.0-syzkaller-12220-g02c438bbfffe #0
Hardware name: linux,dummy-virt (DT)
pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : _compound_head include/linux/page-flags.h:245 [inline]
pc : mod_lruvec_page_state include/linux/vmstat.h:567 [inline]
pc : account_kernel_stack.isra.0+0x28/0x70 kernel/fork.c:541
lr : exit_task_stack_account+0x24/0x58 kernel/fork.c:554
sp : ffff80008909bcf0
x29: ffff80008909bcf0
 x28: f1f0000004970000
 x27: f5f0000002ce8000

x26: 0000000000000000
 x25: f1f00000049705a8
 x24: f1f0000004970600

x23: ffff80008909b7d8
 x22: f6f0000007025780
 x21: 00000000fffffffc

x20: f1f0000004970000
 x19: 0000000000000000
 x18: fff07ffffd331000

x17: 0000000000000001
 x16: ffff8000825c1e80
 x15: 0000000000000002

x14: 00000000000003e7
 x13: 0000000000000000
 x12: ffff8000825e0028

x11: 0000000000000001
 x10: 269097da788856a7
 x9 : ba2b45ada449d75b

x8 : f1f00000049711d8
 x7 : 0000000000000004
 x6 : 0000000000000190

x5 : 00000000000f0510
 x4 : 0000000000000041
 x3 : fbf0000006650900

x2 : 0000000000000001
 x1 : 00000000ffffffff
 x0 : ff7fc1ffc01c13c0

Call trace:
 account_kernel_stack.isra.0+0x28/0x70 kernel/fork.c:541
 exit_task_stack_account+0x24/0x58 kernel/fork.c:554
 do_exit+0x580/0x98c kernel/exit.c:915
 do_group_exit+0x34/0x90 kernel/exit.c:1023
 __do_sys_exit_group kernel/exit.c:1034 [inline]
 __se_sys_exit_group kernel/exit.c:1032 [inline]
 pid_child_should_wake+0x0/0x5c kernel/exit.c:1032
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:152
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: a90153f3 d2800013 f94012c3 f8736860 (f9400403) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	a90153f3 	stp	x19, x20, [sp, #16]
   4:	d2800013 	mov	x19, #0x0                   	// #0
   8:	f94012c3 	ldr	x3, [x22, #32]
   c:	f8736860 	ldr	x0, [x3, x19]
* 10:	f9400403 	ldr	x3, [x0, #8] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

