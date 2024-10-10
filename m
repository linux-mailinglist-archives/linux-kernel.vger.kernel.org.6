Return-Path: <linux-kernel+bounces-358877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B6E998505
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868051C22A62
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88E11C2453;
	Thu, 10 Oct 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/1Cobg6"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08231BE23D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560026; cv=none; b=aYjZ2kK3xyDQrzAHO05DTlYrb2caS2PiJaYAc5vK9YkB7yQZqOwidpTMdid7QVu2b5chs2FtVqOsMM4MTfbBLtpDHqcYyeTZtKeSVhgmf9o6lagpG5jAA20AY5MsWT/EGEdsjAydvhbYYes1am9PsZ7RljhZPRSLeSrrjSXE31U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560026; c=relaxed/simple;
	bh=qoiIkbAz4KJFocl2cDf/q68RonL97tQqXsLm1/NapfA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LQKc2j4gwNL2DgBRzBGjHczn8cENHad2FD9/O2RaFlT5dS1pUYojb9UJyszY7J/xt+HdtW05h+5KHoS99aM6taXJ+5M97HVWtTSaHl5THjvVc4/iNiWIBlSJOMDYD7vQnExMpE4wfYpCh1uYF8JJYs9RWhRY7r+POQKGhP/AYII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z/1Cobg6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a997736106fso105082666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560022; x=1729164822; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jEyuiFWgoMlrQ/8epEbwWJkTaCNZnZTgvo3IasEf6I0=;
        b=Z/1Cobg6u2iDYdwkMwnvI2YyfC/fovxD/kTzMFQuJAFJ6ZGRQuPTBPsnT6dYq3Uyzu
         3M6mQ5LpJK0vlO/4NE5Omo0cebESXOslBUBl7kJ/juBTASKfw8RpRGSyElVZtaxh0o8a
         biYAJsC3cuje10+rexva3hdXwGEooomliHDK+0Bwic15XVuq0/dH9Zwg1wYsso9WSubv
         43UcyVkmaP33Ejn3qf8e7qXuu8MZOuNtP8YKq4xbt5tl0PR5wfMr7t7RBGf1gy/F2ijN
         kFPyIYIVw0yPj76Sp4lO1mw6W94kKyOGsRQFYQaKut5/nYJeK/Sxx9fe+lfnKHJRPlaG
         vKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560022; x=1729164822;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEyuiFWgoMlrQ/8epEbwWJkTaCNZnZTgvo3IasEf6I0=;
        b=eLoJvSB41pTrCRTwgVLmNi0rgXlKUsCXZ6J6dI+kwOJF7hK3mbc1bMsfKRFAn68VAl
         jDS4pDlSd/8tTbWJ/8eOCqc8msM8HLqxJK+QYbf7NMnfX+qDySi7BSzleOFr5OwuGtG7
         0KBYaNShmQR9jVr5ktxsb1AyKbHbyBR1wTrM0zTvz6ul6Nfy/q+bpVF5IP41vhTq2Cjy
         vLvonDd1n4YAiZL1HBGtgej8Qn31Q++s95PPQtgqR8D+oxCy4NT63hH4JYz9yjyMJ4aB
         TLNSlTaTv0NKTg4VZhHztjMIiqFJwtnRf0g0iPfKUy2Rfw/hJEhaTB9WTsfgmQ9N21Sg
         vUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/Uwf9gi8Whcem6o3Gid1iBhU8SWpzeLBUDoa8b+XYLLrcVZd8u0pSCNaUK7mKFEUiVF90zGDKL8JONC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPzYmDGVhCJyfc0KfVfZ4qo2fsn5zral3yERoNHZy3XRNEs1Zf
	P7aFC+yXbmWsV7crsH08EE0fAIOXLIUlXZ2IVLpAc/hYHt892SIsatWuunbfcXo=
X-Google-Smtp-Source: AGHT+IG9UpDR2ovzZ66IthivCf3I31e/FfM2orVk5ZJ1TTBxrgXO95elksQlw3k8TUdTAVU1enx42Q==
X-Received: by 2002:a17:907:1c82:b0:a99:8629:603a with SMTP id a640c23a62f3a-a998d328e6cmr536255766b.57.1728560022136;
        Thu, 10 Oct 2024 04:33:42 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:33:41 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH RFC 00/28] ARM: Switch to generic entry
Date: Thu, 10 Oct 2024 13:33:38 +0200
Message-Id: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJK7B2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNj3cSiXN301DygrmTd1LySokrdxJREQxNTY3OLpKRUJaC+gqLUtMw
 KsJnRSkFuzkqxtbUAH8tUv2gAAAA=
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
https://lore.kernel.org/lkml/20241008-seccomp-compile-error-v1-1-f87de4007095@linaro.org

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
  IRQ entry.

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
  call into code written in C.

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

- perf top doesn't give any output, I don't really know how
  to enble interesting stuff in the kernel to run this
  tool. Help needed.

Potential bugs:

- This comes up during boot and stress-ng runs:

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 0 at kernel/context_tracking.c:128
  ct_kernel_exit+0xf8/0x100
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc1+ #31
  Hardware name: ARM-Versatile Express
  (...)

  It is emitted in kernel/context_tracking.c, ct_kernel_exit():
  WARN_ON_ONCE(ct_nmi_nesting() != CT_NESTING_IRQ_NONIDLE);

  I don't know exactly what's going on here, but it happens right
  after CPU1 is brought online at boot, so there might be some unexpected
  nesting of IPI:s happening when CPU1 is brought up?

Open questions:

- Generic entry requires PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP
  to be defined. I added them but don't even know what they
  do or if generic entry magically adds support for them
  (probably not) so I need help here.

- I need Al Viro's input on how to deal with the "fast syscall
  restart" that I bluntly deleted, if we need to reincarnate it
  in the generic entry or what we shall do here.

- I need to test with an OABI rootfs.

- Performance impact. If this is major I think it's a no-go, we need
  to agree on metrics here however and I need suggestions on what
  to test with.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
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
base-commit: e1dc5c87445c608a99e508fe4d3102e2b32858ef
change-id: 20240903-arm-generic-entry-ada145378bbe

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


