Return-Path: <linux-kernel+bounces-211448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64699051BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29AF8B21758
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94CD16F286;
	Wed, 12 Jun 2024 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTTeqstW"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73B16E89A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193382; cv=none; b=hzmm/dz1yL7vjsAOf3VkeHahpXisXd3L+SzqjOuehMpzW/SmCid01/FphhWCdTnhp5iWlgijLEF+mI+g7++1rCS5hRKjCekcCHfNi6nVz8PfNYeTjwpuKTgctdVAGvg0hn929BauhJozEyWditRX2QKsU4ligU2FqNWV/+r4yVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193382; c=relaxed/simple;
	bh=ih5AJrCqPTCJQZA/5rtiMzGoQtgEs24xcX/phtL61j4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uc36LEWetCDUI3rV1wh8/3zEYsmk6slekjRRz0XUrqmP9ofQOd6lWUwBhH3vqu1ON2LYx1ZUsasl/1pi30f7kx2MMI9vfBiX7DQLgF0FqqwVgy4kBQRc1RfFC0nNIadUBh+MV655t8G5Dz4lyA+mTlB1X5tTLl47IJyOy8pacAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kTTeqstW; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4ed0abe8580so157602e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718193380; x=1718798180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lKqMNmjLehqXl9hKngHIvENc+offRMdAWIWztPSPA1k=;
        b=kTTeqstWerzx44PXZfarsx8cJDBh4gbxny6zFe7capt3Pt18B5IK6BEK7u/eGZ/Kpg
         8yzc1BiUL4r/4iqy0nja8lnrFNMMdHuWCpXwPtBULZxnmAt2tAwDN/4Kljmt6joxwqqu
         cGxr/h/mkTeRCgg2tWN+O98hBKGDn0RVT8J7d8ZBgpw26NwUnEM4Bje65eNE5JXYhpQf
         ObSGLA8eFWBMZ1/n41T6EhsZ5EBdEPp0XJ69ZtssuESl05ldVdCU0/pySQPim71afkLG
         wqYfBHucH7Af05fRcql89BzXpgYy4sV0vpPj9Djc7NrwP1MN49tUxGRvzFRUBw7fPByu
         CBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718193380; x=1718798180;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKqMNmjLehqXl9hKngHIvENc+offRMdAWIWztPSPA1k=;
        b=UtMm3QeL3FDmCK6+gdbpOk5lhIxOtO/z1+FkvoxMTEvO+kZ2c1zQUtfLESm7Q9WC51
         3g4219iw186oIXNhKLHbKBsraFokAMXCuZHxmzz9xwystJ7ELfCFYvAnODM7L5TOunlS
         XT++URuQ6hm7wmZcBbHGQWUhc+hf8d5LLdEV/lGJ/Nx6bXqudq2ynA+ygK2nF0qS5NgE
         kZPdjaqDwTfXEsyaquOn7zo3jHlQVpspkrSJDx7H91RMNjzQ3LCpBIZVIPjNejmodJY1
         RK3kf+knLc2n9376W2xoPHOTa1lVgLMSbWh/2arnlfzb5muDgLJSZBsZJ8NIsOuL0jLp
         7veg==
X-Forwarded-Encrypted: i=1; AJvYcCUjIlLMIVMlLET4emYWsSRFUYOjZl++7fRJpB6ZBLJjLuV9M9WwBr0SVEF13/OMkUlhfvLVcmpJW347e5UcHMapFRuqkvGkQ02XZKFQ
X-Gm-Message-State: AOJu0YwytH5n4yP//ZmdHbNTY5PcmfoTLUt9MaXTWSp3tPG5tiy2+bss
	Kq+UoxheKTDL2k5iw5DyAd660GBYuGtOzRMxA395T8f2HG/NrCO1zD8QWcPfmD9G5bLn5RfPpzR
	872LoIUlpzouM73x3r45Ex4piLvk++fCQRTHUdw==
X-Google-Smtp-Source: AGHT+IFVaHxb2i2+ZEBimsyMtxvlQ7W9AsaBSe0Ua67yYEKTDDgUcRjfZ83FJLzhA8nEctdnwReUFjpNh9jFHNa0TQo=
X-Received: by 2002:a05:6122:3087:b0:4eb:5fb9:166f with SMTP id
 71dfb90a1353d-4ed07b09883mr1852690e0c.7.1718193379725; Wed, 12 Jun 2024
 04:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 12 Jun 2024 17:26:08 +0530
Message-ID: <CA+G9fYv57AhE8CX+T_-OP_yi8tzNXpzS_OGZvjyKKgMDKUN4UA@mail.gmail.com>
Subject: Bad FPU state detected at restore_fpregs_from_fpstate, reinitializing
 FPU registers. WARNING: at arch/x86/mm/extable.c:127 fixup_exception
To: X86 ML <x86@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following kernel warnings are noticed on i386 running Linux next-20240612
tag while booting the ftrace enabled kernel.
This is always reproducible kernel warning with i386.
 ( when running the i386 kernel on an x86 machine I always do this)

Extra Kconfig:
 CONFIG_FTRACE_SYSCALLS=y

Bad FPU state detected at restore_fpregs_from_fpstate+0x3d/0x74,
reinitializing FPU registers.
WARNING: CPU: 0 PID: 1 at arch/x86/mm/extable.c:127 fixup_exception+0x41e/0x45c

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The detailed test log and build log links provided in the bottom of this email.

Boot:
-------
Linux version 6.10.0-rc3-next-20240612 (tuxmake@tuxmake)
(i686-linux-gnu-gcc (Debian 13.2.0-12) 13.2.0, GNU ld (GNU Binutils
for Debian) 2.42) #1 SMP PREEMPT_DYNAMIC @1718178142
...
[   15.714445] Run /sbin/init as init process
[   15.728653] ------------[ cut here ]------------
[   15.733278] Bad FPU state detected at
restore_fpregs_from_fpstate+0x3d/0x74, reinitializing FPU registers.
[   15.733285] WARNING: CPU: 1 PID: 1 at arch/x86/mm/extable.c:127
fixup_exception (arch/x86/mm/extable.c:127 (discriminator 2)
arch/x86/mm/extable.c:340 (discriminator 2))
[   15.733289] Modules linked in:
[   15.733291] CPU: 1 PID: 1 Comm: init Not tainted 6.10.0-rc3-next-20240612 #1
[   15.733293] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.7 12/07/2021
[   15.733294] EIP: fixup_exception (arch/x86/mm/extable.c:127
(discriminator 2) arch/x86/mm/extable.c:340 (discriminator 2))
[ 15.733296] Code: e8 03 ed 00 00 0f 0b eb cb 0f 0b ba 4c 59 53 d2 eb
b6 b2 01 88 15 c0 d3 38 d2 89 44 24 04 c7 04 24 d8 17 fd d1 e8 de ec
00 00 <0f> 0b e9 ee fd ff ff 8d b4 26 00 00 00 00 0f 0b ba 4c 59 53 d2
e9
All code
========
   0: e8 03 ed 00 00        callq  0xed08
   5: 0f 0b                ud2
   7: eb cb                jmp    0xffffffffffffffd4
   9: 0f 0b                ud2
   b: ba 4c 59 53 d2        mov    $0xd253594c,%edx
  10: eb b6                jmp    0xffffffffffffffc8
  12: b2 01                mov    $0x1,%dl
  14: 88 15 c0 d3 38 d2    mov    %dl,-0x2dc72c40(%rip)        #
0xffffffffd238d3da
  1a: 89 44 24 04          mov    %eax,0x4(%rsp)
  1e: c7 04 24 d8 17 fd d1 movl   $0xd1fd17d8,(%rsp)
  25: e8 de ec 00 00        callq  0xed08
  2a:* 0f 0b                ud2    <-- trapping instruction
  2c: e9 ee fd ff ff        jmpq   0xfffffffffffffe1f
  31: 8d b4 26 00 00 00 00 lea    0x0(%rsi,%riz,1),%esi
  38: 0f 0b                ud2
  3a: ba 4c 59 53 d2        mov    $0xd253594c,%edx
  3f: e9                    .byte 0xe9

Code starting with the faulting instruction
===========================================
   0: 0f 0b                ud2
   2: e9 ee fd ff ff        jmpq   0xfffffffffffffdf5
   7: 8d b4 26 00 00 00 00 lea    0x0(%rsi,%riz,1),%esi
   e: 0f 0b                ud2
  10: ba 4c 59 53 d2        mov    $0xd253594c,%edx
  15: e9                    .byte 0xe9
[   15.733298] EAX: 0000005e EBX: d2159678 ECX: 00000000 EDX: 00000002
[   15.733299] ESI: c11efee8 EDI: 0000000d EBP: c11efe50 ESP: c11efdd0
[   15.733300] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010086
[   15.733302] CR0: 80050033 CR2: bfec4aab CR3: 02abc000 CR4: 003506d0
[   15.733303] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   15.733304] DR6: fffe0ff0 DR7: 00000400
[   15.733304] Call Trace:
[   15.733306] ? show_regs (arch/x86/kernel/dumpstack.c:479)
[   15.733308] ? fixup_exception (arch/x86/mm/extable.c:127
(discriminator 2) arch/x86/mm/extable.c:340 (discriminator 2))
[   15.733310] ? __warn (kernel/panic.c:742)
[   15.733313] ? fixup_exception (arch/x86/mm/extable.c:127
(discriminator 2) arch/x86/mm/extable.c:340 (discriminator 2))
[   15.733314] ? fixup_exception (arch/x86/mm/extable.c:127
(discriminator 2) arch/x86/mm/extable.c:340 (discriminator 2))
[   15.733316] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[   15.733320] ? exc_overflow (arch/x86/kernel/traps.c:252)
[   15.733321] ? handle_bug (arch/x86/kernel/traps.c:218)
[   15.733323] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
[   15.733324] ? console_unlock (kernel/printk/printk.c:3137 (discriminator 1))
[   15.733326] ? handle_exception (arch/x86/entry/entry_32.S:1054)
[   15.733329] ? software_resume (kernel/power/hibernate.c:1024)
[   15.733332] ? set_pages_rw (arch/x86/mm/pat/set_memory.c:2356)
[   15.733334] ? exc_overflow (arch/x86/kernel/traps.c:252)
[   15.733336] ? fixup_exception (arch/x86/mm/extable.c:127
(discriminator 2) arch/x86/mm/extable.c:340 (discriminator 2))
[   15.733337] ? set_pages_rw (arch/x86/mm/pat/set_memory.c:2356)
[   15.733340] ? exc_overflow (arch/x86/kernel/traps.c:252)
[   15.733341] ? fixup_exception (arch/x86/mm/extable.c:127
(discriminator 2) arch/x86/mm/extable.c:340 (discriminator 2))
[   15.733342] ? restore_fpregs_from_fpstate (arch/x86/kernel/fpu/core.c:198)
[   15.733344] ? mt_find (lib/maple_tree.c:6956)
[   15.733347] ? get_random_u32 (arch/x86/include/asm/irqflags.h:42
arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135
drivers/char/random.c:532)
[   15.733349] ? _raw_spin_unlock
(include/linux/spinlock_api_smp.h:143 (discriminator 3)
kernel/locking/spinlock.c:186 (discriminator 3))
[   15.733350] ? finalize_exec (fs/exec.c:1497)
[   15.733352] ? trace_preempt_on (kernel/trace/trace_preemptirq.c:105)
[   15.733354] ? finalize_exec (fs/exec.c:1497)
[   15.733355] ? exc_bounds (arch/x86/kernel/traps.c:644)
[   15.733356] exc_general_protection (arch/x86/kernel/traps.c:618
(discriminator 1) arch/x86/kernel/traps.c:678 (discriminator 1)
arch/x86/kernel/traps.c:644 (discriminator 1))
[   15.733357] ? finalize_exec (fs/exec.c:1497)
[   15.733359] ? exc_bounds (arch/x86/kernel/traps.c:644)
[   15.733361] handle_exception (arch/x86/entry/entry_32.S:1054)
[   15.733363] EIP: restore_fpregs_from_fpstate (arch/x86/kernel/fpu/core.c:198)
[ 15.733364] Code: 7d fc 89 ca eb 09 cc cc cc db e2 0f 77 db 03 3e 8d
74 26 00 8b 3d ac 82 0b d2 8b 0d a8 82 0b d2 21 fa 8d 7b 40 21 c8 0f
c7 1f <8b> 5d f8 8b 7d fc 89 ec 5d c3 2e 8d 74 26 00 3e 8d 74 26 00 0f
ae
All code
========
   0: 7d fc                jge    0xfffffffffffffffe
   2: 89 ca                mov    %ecx,%edx
   4: eb 09                jmp    0xf
   6: cc                    int3
   7: cc                    int3
   8: cc                    int3
   9: db e2                fnclex
   b: 0f 77                emms
   d: db 03                fildl  (%rbx)
   f: 3e 8d 74 26 00        lea    %ds:0x0(%rsi,%riz,1),%esi
  14: 8b 3d ac 82 0b d2    mov    -0x2df47d54(%rip),%edi        #
0xffffffffd20b82c6
  1a: 8b 0d a8 82 0b d2    mov    -0x2df47d58(%rip),%ecx        #
0xffffffffd20b82c8
  20: 21 fa                and    %edi,%edx
  22: 8d 7b 40              lea    0x40(%rbx),%edi
  25: 21 c8                and    %ecx,%eax
  27: 0f c7 1f              xrstors (%rdi)
  2a:* 8b 5d f8              mov    -0x8(%rbp),%ebx <-- trapping instruction
  2d: 8b 7d fc              mov    -0x4(%rbp),%edi
  30: 89 ec                mov    %ebp,%esp
  32: 5d                    pop    %rbp
  33: c3                    retq
  34: 2e 8d 74 26 00        lea    %cs:0x0(%rsi,%riz,1),%esi
  39: 3e 8d 74 26 00        lea    %ds:0x0(%rsi,%riz,1),%esi
  3e: 0f                    .byte 0xf
  3f: ae                    scas   %es:(%rdi),%al

Code starting with the faulting instruction
===========================================
   0: 8b 5d f8              mov    -0x8(%rbp),%ebx
   3: 8b 7d fc              mov    -0x4(%rbp),%edi
   6: 89 ec                mov    %ebp,%esp
   8: 5d                    pop    %rbp
   9: c3                    retq
   a: 2e 8d 74 26 00        lea    %cs:0x0(%rsi,%riz,1),%esi
   f: 3e 8d 74 26 00        lea    %ds:0x0(%rsi,%riz,1),%esi
  14: 0f                    .byte 0xf
  15: ae                    scas   %es:(%rdi),%al
[   15.733366] EAX: 0000001f EBX: c12288e0 ECX: 0000001f EDX: 00000000
[   15.733367] ESI: c1228000 EDI: c1228920 EBP: c11eff4c ESP: c11eff44
[   15.733368] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
[   15.733369] ? __do_sys_newstat (fs/stat.c:439)
[   15.733372] ? exc_bounds (arch/x86/kernel/traps.c:644)
[   15.733373] ? exc_bounds (arch/x86/kernel/traps.c:644)
[   15.733374] ? restore_fpregs_from_fpstate
(arch/x86/kernel/fpu/xstate.h:209 arch/x86/kernel/fpu/core.c:191)
[   15.733376] fpregs_restore_userregs
(arch/x86/kernel/fpu/context.h:49 (discriminator 4)
arch/x86/kernel/fpu/context.h:76 (discriminator 4))
[   15.733378] switch_fpu_return (arch/x86/kernel/fpu/core.c:802)
[   15.733380] syscall_exit_to_user_mode
(arch/x86/include/asm/entry-common.h:58
include/linux/entry-common.h:330 kernel/entry/common.c:207
kernel/entry/common.c:218)
[   15.733382] ? rest_init (init/main.c:1459)
[   15.733383] ? kernel_init (init/main.c:1397 init/main.c:1523)
[   15.733385] ? rest_init (init/main.c:1459)
[   15.733387] ret_from_fork (arch/x86/kernel/process.c:154)
[   15.733388] ? rest_init (init/main.c:1459)
[   15.733390] ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
[   15.733391] entry_INT80_32 (arch/x86/entry/entry_32.S:944)
[   15.733393] EIP: 0xb7f175b0
[ 15.733396] Code: Unable to access opcode bytes at 0xb7f17586.

Code starting with the faulting instruction
===========================================
[   15.733396] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
[   15.733397] ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: bfec49b0
[   15.733398] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000200
[   15.733400] ---[ end trace 0000000000000000 ]---
[   16.074973] ------------[ cut here ]------------
[   16.079626] WARNING: CPU: 1 PID: 1 at
arch/x86/kernel/fpu/xstate.h:195 save_fpregs_to_fpstate
(arch/x86/kernel/fpu/xstate.h:195 (discriminator 1)
arch/x86/kernel/fpu/core.c:128 (discriminator 1))
[   16.079629] Modules linked in:
[   16.079630] CPU: 1 PID: 1 Comm: init Tainted: G        W
6.10.0-rc3-next-20240612 #1
[   16.079632] Tainted: [W]=WARN
[   16.079632] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.7 12/07/2021
[   16.079633] EIP: save_fpregs_to_fpstate
(arch/x86/kernel/fpu/xstate.h:195 (discriminator 1)
arch/x86/kernel/fpu/core.c:128 (discriminator 1))
[ 16.079634] Code: f8 8b 7d fc 89 ec 5d c3 66 90 8b 40 08 dd 70 40 9b
8b 43 08 dd 60 40 8b 5d f8 8b 7d fc 89 ec 5d c3 2e 8d b4 26 00 00 00
00 90 <0f> 0b eb 9b 8d 74 26 00 0f 0b eb 87 3e 8d 74 26 00 55 89 e5 83
ec
All code
========
   0: f8                    clc
   1: 8b 7d fc              mov    -0x4(%rbp),%edi
   4: 89 ec                mov    %ebp,%esp
   6: 5d                    pop    %rbp
   7: c3                    retq
   8: 66 90                xchg   %ax,%ax
   a: 8b 40 08              mov    0x8(%rax),%eax
   d: dd 70 40              fnsave 0x40(%rax)
  10: 9b                    fwait
  11: 8b 43 08              mov    0x8(%rbx),%eax
  14: dd 60 40              frstor 0x40(%rax)
  17: 8b 5d f8              mov    -0x8(%rbp),%ebx
  1a: 8b 7d fc              mov    -0x4(%rbp),%edi
  1d: 89 ec                mov    %ebp,%esp
  1f: 5d                    pop    %rbp
  20: c3                    retq
  21: 2e 8d b4 26 00 00 00 lea    %cs:0x0(%rsi,%riz,1),%esi
  28: 00
  29: 90                    nop
  2a:* 0f 0b                ud2    <-- trapping instruction
  2c: eb 9b                jmp    0xffffffffffffffc9
  2e: 8d 74 26 00          lea    0x0(%rsi,%riz,1),%esi
  32: 0f 0b                ud2
  34: eb 87                jmp    0xffffffffffffffbd
  36: 3e 8d 74 26 00        lea    %ds:0x0(%rsi,%riz,1),%esi
  3b: 55                    push   %rbp
  3c: 89 e5                mov    %esp,%ebp
  3e: 83                    .byte 0x83
  3f: ec                    in     (%dx),%al

Code starting with the faulting instruction
===========================================
   0: 0f 0b                ud2
   2: eb 9b                jmp    0xffffffffffffff9f
   4: 8d 74 26 00          lea    0x0(%rsi,%riz,1),%esi
   8: 0f 0b                ud2
   a: eb 87                jmp    0xffffffffffffff93
   c: 3e 8d 74 26 00        lea    %ds:0x0(%rsi,%riz,1),%esi
  11: 55                    push   %rbp
  12: 89 e5                mov    %esp,%ebp
  14: 83                    .byte 0x83
  15: ec                    in     (%dx),%al
[   16.079636] EAX: 0000001f EBX: c12288a0 ECX: c12288e0 EDX: 00000000
[   16.079637] ESI: c1228000 EDI: fffffff2 EBP: c1221ed0 ESP: c1221ec8
[   16.079637] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010082
[   16.079639] CR0: 80050033 CR2: b7f17586 CR3: 02abc000 CR4: 003506d0
[   16.079640] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   16.079640] DR6: fffe0ff0 DR7: 00000400
[   16.079641] Call Trace:
[   16.079641] ---[ end trace 0000000000000000 ]---

metadata:
---
git_describe: next-20240612
git_ref: master
git_rep: ohttps://gitlab.com/Linaro/lkft/mirrors/next/linux-next
git_sha: 03d44168cbd7fc57d5de56a3730427db758fc7f6
arch: i386
toolchain: gcc-13

Links:
----
- https://lkft.validation.linaro.org/scheduler/job/7658521#L1067
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240612/testrun/24277698/suite/log-parser-boot/test/check-kernel-warning-ff46c8024e8b2af96107ccfc90c52489f57275260d87c4955245aefd26dd9d60/details/
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2hlo6h03yVTVuYB6mf8ZHEdZISJ/


--
Linaro LKFT
https://lkft.linaro.org

