Return-Path: <linux-kernel+bounces-386741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F8F9B4794
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC321F24228
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF9A20607B;
	Tue, 29 Oct 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoJn68l2"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5622038D9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199171; cv=none; b=fpr3hMVIGSZfQ/KjmX8gcH4UQOpVIyuglOZ0CM1tp0bnayPOOUMPpU5nF4ScX3it3UQqMJUKWXuvnljAUQj62OfMuVWRmLeFWd2arowFuy5gLNkuWZZwAJWBtVkLJfaEdflclglsqmbuzlUeiT1Uc4ph/lcfOdSmrYUWuSy0xDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199171; c=relaxed/simple;
	bh=4/Jg0Blz8c010FIFryeYK/NT+zGIM0dqexAARfgpd1I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YG/HrwudlIbpEQ7ua1bzQCvcXhQ/udyHo94a6wHwQeX6OBeLzqNCPGl2yiDTNqD8E5axa7vVS/cDX+Pp73TL4P+lOqxH/wH6Ob935BOuUshtJa7iw0EXpj8b0MZvfEW7uVkvS2hf17L+XRCqZ3zt+Pk8wtDyGoEh6MGMwwGLFxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QoJn68l2; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e7e73740so4414228e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199166; x=1730803966; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pOU2at/tY3wxqYqK5srfwiMdhD8Qv79B8bwqyosCpDo=;
        b=QoJn68l2SG1eh0M1FSmkHqJbgJLHYy5tP1ldPkdq7y5EFrMThwhV/aK6BrUi38/99G
         oLcjhKJmu1/KCc7tbgmxnvba5UOhXkSKdlAvFzWFb4JX8RHVQMAXz5wZDpXkEldNdw5T
         cM0xdmL5JyYOxOJV7Xn41ON8au3H0a1GFGXIPnNpAn9SpE4JpE9G+bV6Cyq+Vs38DUYa
         vOnJ6YaJXv4JZfifCWrhvpar+jwL5Oo03ZkWtCMp2GDMTrWYAEIIo1wLgg4BAgjbeihY
         b+UNZDz7mzYaCN3iKItzZFZfvtC9ZfVBFvcpYUFBFf22C6P3aPQAw1Hbb+Om+Vx2Tufc
         8dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199166; x=1730803966;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOU2at/tY3wxqYqK5srfwiMdhD8Qv79B8bwqyosCpDo=;
        b=QXur/ENizM7xe5xs/Ee7F2ke6AsM7JxOw5pCVvyanL/V/moXA/5GiwQxoNZnIHJj/g
         EtZqyXv7NronOzGlDbFJbq/vG/3OXpFer4jKKgo+xPGpf4AcRzoP6nFpF7iTPcjOooZJ
         A7TcE21kLufi66wC4yI3bqRMlV7czHbwVdhQm6JqgwfjYxFH9thG5i2yp9kYdlsC2+2D
         IpIBSNcYUmMDTNEj3jIns+3aGl+k4JgBSSer6cJa3ouf18MmEG3NnWve6Q/5XCl++Syd
         bOvEvns8TJW7+aBAWQjLQhdqb4skK0VDvHtIyHxuf7qhETYWk3waA+vVmPoXIBS6o7rZ
         8QIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrpU8ukWuNoyasqGwP6TsODe3ImUtMUFdZW5iZbDog7S5b+ynT5BCmHID8pyt02K0peyjfEU/pgmXPjsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgcmXXaOsTB4/xHFlIe6YGHjo9XI7KQqknsPO4VlaJivx/5Q40
	H1uilWWzAI+cTeYGKuPPectnxv1eTCi+Q/I3JkgU2OgDF6/iFlbuIdlbrVzWOQo=
X-Google-Smtp-Source: AGHT+IGZsGrI+Wje0AWMboh61HWlxN5Py1N1bq48j9U0oZT95pWYVIQhjG50/1Fk/KCarp30cbOBoQ==
X-Received: by 2002:a05:6512:1113:b0:539:faef:35ec with SMTP id 2adb3069b0e04-53b34a32081mr5099260e87.49.1730199166240;
        Tue, 29 Oct 2024 03:52:46 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:52:45 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH RFC v2 00/28] ARM: Switch to generic entry
Date: Tue, 29 Oct 2024 11:52:40 +0100
Message-Id: <20241029-arm-generic-entry-v2-0-573519abef38@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHm+IGcC/22NwQqDMBBEf6XsuVs2GlF7KhT6Ab0WD4muGmiTs
 hGpiP/e1HOPM8N7s0JkcRzhfFhBeHbRBZ9CdjxAOxo/MLouZcgo01RTjkZeOLBPVIvsJ1nQdEb
 pIi8raxkS9xbu3Wd3PuB+u0KTytHFKciy/8xqn35KRYr+KGeFhLbWvS5UR1VpL0/njYRTkAGab
 du++u6slrgAAAA=
To: Oleg Nesterov <oleg@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

This patch series converts a slew of ARM assembly into the
corresponding C code, step by step moving the codebase
closer to the expectations of the generic entry code,
and as a last step switches ARM over to the generic
entry code.

This was inspired by Jinjie Ruans similar work for ARM64.

The low-level assembly calls into arch/arm/kernel/syscall.c
to invoke syscalls from userspace, and to the functions listed
in arch/arm/kernel/entry.c for any other transitions to
and from userspace. Looking at these functions and the
call sites in the assembly on the final result should give
a pretty good idea about how this works, and what the
generic entry expects from an architecture.

To test the code the following seccomp patch is needed
on older ARM systems:
https://lore.kernel.org/lkml/20241022-seccomp-compile-error-v2-1-c9f08a4f8ebb@linaro.org/
(patch queued by Kees Cook)

There is a git branch you can pull in and test (v6.12-rc1
based):
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/log/?h=b4/arm-generic-entry-v6.12-rc1

Upsides:

- Same code paths as x86, S390, RISCV, Loongarch and probably
  soon ARM64 is used for the ARM systems. This includes some
  instrumentation stubs helping out with things we haven't
  even started to look at such as kmsan and live patching (!).

- By introducing the new callbacks to C, we can move away
  from the deprecated (and I think partly unmaintained) context
  tracking mechanism for RCU (user_exit_callable(),
  user_enter_callable()) in favor of what everyone else
  is using, i.e. calling rcu_irq_enter_check_tick() on
  IRQ entry. If we do not go with this patch set we can
  perhaps look into a separate patch just switching ARM32
  to the new context tracking, as tests show the performance
  impact appears negligible for this.

- I think also lockdep is now behaving more according to
  expectations (the lockdep calls in ARM64 and generic entry
  seems different and more fine-granular from the ARM32 code)
  but I am no expert in lockdep so I cannot really tell if
  this is a real improvement.

Downsides:

- I had to remove the "fast syscall restart" from Al Viro.
  I don't know how much it will affect performance, but
  if this is something we must have, let's try to make
  the solution generic, i.e. add fast syscall restart in
  the generic entry code.

- The "superfast return to userspace" using just very
  small assembly snippets to get back to userspace on
  e.g. IRQs if and only if no instrumentation was compiled
  in, is no longer possible, since we unconditionally
  call into code written in C. I *think* this accounts
  for the majority of the ~3-4% performance impact (see
  measurements below).

Testing:

- Booted into Versatile Express QEMU (ARMv7), Ux500 full
  graphic UI (PostmarketOS Phosh, ARMv7 on hardware,
  Gemini ARMv4 on hardware. No special issues.

- Tested some ptrace/strace obviously, such as issuing
  several instances of "ptrace find /" and let this scroll
  by in the terminal over some 10 minutes or so.

- Turned on RCU torture tests and ran for a while. Seems
  stable and the test outputs look normal.

- Ran stress-ng, which triggers the idle bug below that also
  appear during boot.

Performance impact:

The changes were tested using the standard syscall overhead
testing oneliner:

  perf bench syscall all

This executes 10,000,000 getppid() in sequence and measures
the time taken for this to complete. The numbers vary a bit
but they are consistent.

In QEMU I tested with Vexpress and two CPU cores (-M vexpress-a15
-m 2G -smp cpus=2). DRM graphics and framebuffer was activated to
give a bit of background IRQ activity (vsync interrupts).

I ran the perf command three times on each configuration, and
picked the one iteration where the original code performed the
best, and the one where the patches kernel performed the worst, to
get a worst-case comparison.

v6.12-rc1 vexpress_defconfig, best invocation:

     Total time: 150.723 [sec]
      15.072301 usecs/op
         66,346 ops/sec

v6.12-rc1 vexpress_defconfig, and this patch set, worst invocation:

     Total time: 158.746 [sec]
      15.874603 usecs/op
         62,993 ops/sec

Here we see a performance degradation of around 4% operations/sec
for a vexpress dualcore defconfig.

Debians stock kernel was noticably faster, so I investigated what
causes this. It turns out that the big performance hog for syscalls
is actually PAN, and I think Debian armhf simply turns this off.
So I re-did the tests with CONFIG_ARM_PAN turned off to emulate the
impact on stock Debian:

v6.12-rc1 vexpress_defconfig, !PAN, best invocation:

     Total time: 38.022 [sec]
       3.802206 usecs/op
        263,005 ops/sec

v6.12-rc1 vexpress_defconfig, !PAN and this patch set, worst
invocation:

     Total time: 39.015 [sec]
       3.901549 usecs/op
        256,308 ops/sec

Again we see around 4% (well just 3% actually). The overhead seems
a little less pronounced when not using PAN.

To conclude if any of this was due to the new context tracking,
I tested to patch back the old context tracking on top of generic
entry. This is hardly something that can be recommended, and anyway
showed no noticeable overhead difference.

Caveats

- This comes up during boot and stress-ng runs:

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 0 at kernel/context_tracking.c:128
  ct_kernel_exit+0xf8/0x100
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc1+ #31
  Hardware name: ARM-Versatile Express
  (...)

  It is emitted in kernel/context_tracking.c, ct_kernel_exit():
  WARN_ON_ONCE(ct_nmi_nesting() != CT_NESTING_IRQ_NONIDLE);

  The kernel contains the following comment in ct_irq_enter():

  "If your architecture's idle loop does do upcalls to user mode (or
  does anything else that results in unbalanced calls to the
  irq_enter() and irq_exit() functions), RCU will give you what you
  deserve, good and hard. But very infrequently and
  irreproducibly.

  Use things like work queues to work around this limitation.

  You have been warned."

  Stern language, some actual help to pinpoint the problem so I
  can work on it would be appreciated.

  Inserting prints reveals that the ct_nmi_nesting() often
  deviates from CT_NESTING_IRQ_NONIDLE at ct_kernel_exit() by
  a few multiple of 2 counts up or down.

Open questions:

- Generic entry requires PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP
  to be defined. I added them but don't even know what they
  do or if generic entry magically adds support for them
  (probably not) so I need help here.

- I need Al Viro's input on how to deal with the "fast syscall
  restart" that I bluntly deleted, if we need to reincarnate it
  in the generic entry or what we shall do here.

- I need to test with an OABI rootfs.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Performance impact measurements have been provided.
- Link to v1: https://lore.kernel.org/r/20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org

---
Linus Walleij (28):
      ARM: Prepare includes for generic entry
      ARM: ptrace: Split report_syscall()
      ARM: entry: Skip ret_slow_syscall label
      ARM: process: Rewrite ret_from_fork i C
      ARM: process: Remove local restart
      ARM: entry: Invoke syscalls using C
      ARM: entry: Rewrite two asm calls in C
      ARM: entry: Move trace entry to C function
      ARM: entry: save the syscall sp in thread_info
      ARM: entry: move all tracing invocation to C
      ARM: entry: Merge the common and trace entry code
      ARM: entry: Rename syscall invocation
      ARM: entry: Create user_mode_enter/exit
      ARM: entry: Drop trace argument from usr_entry macro
      ARM: entry: Separate call path for syscall SWI entry
      ARM: entry: Drop argument to asm_irqentry macros
      ARM: entry: Implement syscall_exit_to_user_mode()
      ARM: entry: Drop the superfast ret_fast_syscall
      ARM: entry: Remove fast and offset register restore
      ARM: entry: Untangle ret_fast_syscall/to_user
      ARM: entry: Do not double-call exit functions
      ARM: entry: Move work processing to C
      ARM: entry: Stop exiting syscalls like IRQs
      ARM: entry: Complete syscall and IRQ transition to C
      ARM: entry: Create irqentry calls from kernel mode
      ARM: entry: Move in-kernel hardirq tracing to C
      ARM: entry: Add FIQ/NMI C callbacks
      ARM: entry: Convert to generic entry

 arch/arm/Kconfig                    |   1 +
 arch/arm/include/asm/entry-common.h |  66 ++++++++++++
 arch/arm/include/asm/entry.h        |  17 +++
 arch/arm/include/asm/ptrace.h       |   8 +-
 arch/arm/include/asm/signal.h       |   4 -
 arch/arm/include/asm/stacktrace.h   |   2 +-
 arch/arm/include/asm/switch_to.h    |   4 +
 arch/arm/include/asm/syscall.h      |   7 ++
 arch/arm/include/asm/thread_info.h  |  18 +---
 arch/arm/include/asm/traps.h        |   2 +-
 arch/arm/include/uapi/asm/ptrace.h  |   2 +
 arch/arm/kernel/Makefile            |   5 +-
 arch/arm/kernel/asm-offsets.c       |   1 +
 arch/arm/kernel/entry-armv.S        |  39 +++----
 arch/arm/kernel/entry-common.S      | 202 ++++++++++++++----------------------
 arch/arm/kernel/entry-header.S      | 108 +++++--------------
 arch/arm/kernel/entry.c             |  59 +++++++++++
 arch/arm/kernel/process.c           |  22 +++-
 arch/arm/kernel/ptrace.c            |  76 --------------
 arch/arm/kernel/signal.c            |  57 ++--------
 arch/arm/kernel/syscall.c           |  31 ++++++
 arch/arm/kernel/traps.c             |   2 +-
 22 files changed, 349 insertions(+), 384 deletions(-)
---
base-commit: 67bc0ffd4658eb91d061a6efa83da65ec838c2ac
change-id: 20240903-arm-generic-entry-ada145378bbe

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


