Return-Path: <linux-kernel+bounces-511002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09891A324B7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD9B7A3A85
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291E320A5DB;
	Wed, 12 Feb 2025 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IzPTTpW+"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAF7271839
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359390; cv=none; b=IOEey4edmV5XCHv2xQn9yDJA/zNiGCJo4xThMsLaNXvkYl3S9gjbwyjXIQy8W7hBRK5WNnv8e/BefaUzcsmh3xAVgdwuAkoN2n7NvABdVu7piwQMUpxuMHQ7W6HHY1cIQqm5iJ9zx8oyu7ol/OtqrmxOQIPK4ZqyETiof2hz0OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359390; c=relaxed/simple;
	bh=s8NY8/Ssdau6WyGgxH2KsFaLC/XPe9NQOgAblsxMZD0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WUmqHt8LBekAG2yei53yCEUclQeAHbgHVTmffcjsZWVyCKTyhbt1nmE5KnvXsBzwBIe7guyxZkN86QcFrUW5CY7Zoj8VdvvXKjkp3G5lT8CCNJquejwle4cqpVHE4Nj/gMOUNxm/wXQW5pNM5VU594WAD7RA2dno2l4XI1qui8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IzPTTpW+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54504a6955aso3743544e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359386; x=1739964186; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sXGvP6JipV+8uUkai1pZ0JQN3eZ7gykFyofKu5Tpi/M=;
        b=IzPTTpW+zfi5Nrr93ciRaVYP6g8OXweei3//AKXutF2YaYwkGOnFYQGWFBuSiuywqZ
         IyEnDhOt9olCdtzl5nioHPBg/GkvUL0IELcXeUGb0PqCDQEmhAcs0N9nOxBkpwh9qrgx
         EXrjFAU1jM1Voh3rQiSBkMNDkyV1d3KRWcIjh7iJHKsn57qeYHZwQhIvzl3U3okWaWDL
         WDianrj+nhxzOUWcSjXlvfe+F7sxQbdGXXvgMSgK37iL/jO3gL12tq3yq6SkXSpyilhm
         rskU1qFxjYOQ8EPPChknl8/rfBN02ViL7RqOW1uZ3KID0m3pI9j3PPl/ImUP9Kxy7Y3Z
         zo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359386; x=1739964186;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXGvP6JipV+8uUkai1pZ0JQN3eZ7gykFyofKu5Tpi/M=;
        b=WjLOOBTRSyjU22B1bsnWS778y/KO82eKjs0U8ynnnmymumgP7hpZHIcOZ8hHSaUPVx
         zHah/Y7QqqUzjit3IExnz8saeKL8JB0wqITMhUDp2Lq1cGA9Yz/rEftA2/xAdMaS2wP3
         YlNvjNJe1ILn/7RTcYcdovbX3Fi5DlRXdAyvf6iL8Dz4fyHKN1LPSnoUvFTlGBHKPGt/
         zldJDwUkTsWsiFrDuFUdW4hKVM4nUkIMHSlMoRUG+NRhGiXAWWeuNbnZJrPASOIU8U79
         axTWY0xIIXZ/+pUDtnrMS2SMzgDVkhr8ZTwJ9iGSDhjO85ysvCf3DJBezFoViETr3xjx
         hUlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXWkPTLVpNt0VAaFa7Pl3V2veh0ClMopePBurFa4ZUkvG4rs84IgyFg1W8hofDFErYUZGpjroYULTNA5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWO886ZTs8TliDkRmx0z5JYLra8kpqIwre/O4HW3jxOUDHVxHu
	4yAGI4nv6RLc3pKiQ22TSCUn46GdnQTnPplCZR3TowTZNqbkIvLcvlateAqtg+I=
X-Gm-Gg: ASbGncukoEAeNiRBRWJXg0RBKaoX4BmctAHK6XvhPCzUGOk5SsnAc2ZQHD6oxsH7SgV
	LbXDP/erEU6pbjbRSaWfOh0R2Auar794JHrNvs+QtkA6kkcuvAn4wkKAphqnZ030lj56CqnJY3t
	TNRve9qXeWAutDjk/BCBFftzbsWA4cRrVe1wPgnkCS4fLheVc4/mLNG8XFVgH1xTf05L5/SqOFm
	QEJ04dIyt5UaO+qGXuZJZlRuVLyTr4VJZzIRqETt9de9iE0LASXbrdXK+437GQjuPNhBu6L2/D2
	8TJO9Yp6EknYimZY2JtpCBDSIQ==
X-Google-Smtp-Source: AGHT+IGfW6UuSv4ugNHZKr/TSO63oKM0CCCS12M+6yxNTE3BJ4hH4kgYgHngRtagJ1WK92UvO2ed3w==
X-Received: by 2002:a05:6512:b8b:b0:545:17b:3cf5 with SMTP id 2adb3069b0e04-545181a9513mr874187e87.47.1739359385949;
        Wed, 12 Feb 2025 03:23:05 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:05 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 00/31] ARM: Switch to generic entry
Date: Wed, 12 Feb 2025 12:22:54 +0100
Message-Id: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI+ErGcC/23OTQrCMBAF4KtI1kbySxpX3kNcJM2kDWgqSQmW0
 rubFgTFLt/A+97MKEMKkNH5MKMEJeQwxBrE8YDa3sQOcHA1I0aYIJpwbNIDdxBrq8UQxzRh4ww
 VkqvGWkC190zgw2szr7ea+5DHIU3bRKHrddMooWRHKxQTbLXwQlJHGmUv9xBNGk5D6tDKFfZFM
 L1HsEpIxSXVxoLnzR/BP4SsT6g9gldCgPS8pdJZ5n6IZVnetw14NTkBAAA=
X-Change-ID: 20240903-arm-generic-entry-ada145378bbe
To: Dmitry Vyukov <dvyukov@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

First non-RFC version.

This patch series converts a slew of ARM assembly into the
corresponding C code, step by step moving the codebase
closer to the expectations of the generic entry code,
and as a last step switches ARM over to the generic
entry code, and an RFC patch fixes a bunch of warnings
from lockdep and the context tracker.

This was inspired by Jinjie Ruans similar work for ARM64.

The low-level assembly calls into arch/arm/kernel/syscall.c
to invoke syscalls from userspace, and to the functions listed
in arch/arm/kernel/entry.c for any other transitions to
and from userspace. Looking at these functions and the
call sites in the assembly on the final result should give
a pretty good idea about how this works, and what the
generic entry expects from an architecture.

This was successfully booted on ARMv7m as well: the v7m
avoids the interrupt path in the generic entry, because it
never called the context tracker to begin with. It uses
the common path for syscalls however and this works just
fine. Adding proper context tracking to the ARMv7m IRQs is
probably a good idea but a separate issue altogether.

There is a git branch you can pull in and test (v6.14-rc1
based):
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/log/?h=b4/arm-generic-entry-v6.14-rc1

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
  and the three warnings I see on Vexpress boots with mainline
  goes away after this patch set, but I am no expert in lockdep
  so I cannot really tell if this is a real improvement.
  The patches does make ARM lockdep clean.

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

Both downsides are more or less unavoidable side effects
if you just want to use the non-deprecated context tracking,
as that involves calling into C from every exception,
without exceptions.

Testing:

- Booted into Versatile Express QEMU (ARMv7), Ux500 full
  graphic UI (PostmarketOS Phosh, ARMv7 on hardware,
  Gemini ARMv4 on hardware. No special issues.

- Tested some ptrace/strace obviously, such as issuing
  several instances of "ptrace find /" and let this scroll
  by in the terminal over some 10 minutes or so.

- Turned on RCU torture tests and ran for a while. Seems
  stable and the test outputs look normal.

- Ran stress-ng, works fine.

- Booted with "lockdep" (CONFIG_PROVE_LOCKING). The ARM32
  mainline produce 3 warnings at boot and those go away
  after these patches. I haven't looked closer at what
  it was that I inadvertedly fixed here, but I suspect the
  current context tracking has the same issues as what
  I fix in the RFC patch.

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

v6.14-rc1 vexpress_defconfig, best invocation:

     Total time: 146.546 [sec]
      14.654698 usecs/op
         68,237 ops/sec

v6.14-rc1 vexpress_defconfig, and this patch set, worst invocation:

     Total time: 156.263 [sec]
      15.626398 usecs/op
         63,994 ops/sec

Here we see a performance degradation of around 6-7% operations/sec
for a vexpress dualcore defconfig in the best vs worst case. (This
isn't statistically correct, the effect is likely smaller.)

Debians stock kernel was noticably faster, so I investigated what
causes this. It turns out that the big performance hog for syscalls
is actually PAN which cause an order of magnitude syscall performance
decrease, and I think Debian armhf simply turns this off. Consistent
tests with PAN disabled also see around 6-7% on that performance
figure.

To conclude if any of this was due to the new context tracking,
at one point I tested to patch back the old context tracking on top
of generic entry. This is hardly something that can be recommended,
and anyway showed no noticeable overhead difference.

Open questions:

- I need to test with an OABI rootfs.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v4:
- Rebased on v6.14-rc1, marked non-RFC.
- Tested on ARMv7m, it works.
- Fixed a bug where I missed to handle syscall "-1" which
  when tracing means "skip syscall". This took some time to
  find, taking up much of my debug time despite being so
  obvious :/
- Added stubs for PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP.
- No feedback on the "fast syscall restart" so I conclude
  that this is some ARM oddity, if it is needed for
  performance (i.e. a workload constantly restarting syscalls)
  we should look at recreating it inside the generic entry
  code.
- After discussing with Ard about the IRQ stacks, altered
  the irqstack handling to just assume IRQ stack or overflow
  stack is in use if we are not on the main thread stack.
- Unmark the patch to block IRQs in early IRQ context as
  "RFC": when doing proper context tracking this is likely
  plain necessary. Block IRQs in the early assembly entry
  directly in CPSR instead of later in the exception handler.
- New cleanup patch in the tail of the patch series.
- Link to v3: https://lore.kernel.org/r/20250107-arm-generic-entry-v3-0-4e5f3c15db2d@linaro.org

Changes in v3:
- Rewrote the code in entry.c so the IRQ handler saves pt_regs
  calls IRQ handler (including switching to IRQ stack!) and
  restores pt_regs in one function instead of one entry and
  one exit function. This is what every other arch using
  generic entry is doing, and we should do it too.
- The rewrite solved the caveat warnings from the previous patch
  set which was blatantly not SMP safe :/
- Rewrite the data abort and prefetch abort handlers in a
  separate patch which we may squash in the end, but this makes
  the patch set easier to review.
- Drop a pointless patch rewriting the NMI handlers in C, it's
  better to just patch into the end result in the last patch,
  as we're replacing handle_fiq_as_nmi().
- Syscall C invocations have to be tagged __ADDRESSABLE() in order
  not to upset KCFI: the file is only referenced in both ends by
  assembly so we need to point this out to the compiler.
- Link to v2: https://lore.kernel.org/r/20241029-arm-generic-entry-v2-0-573519abef38@linaro.org

Changes in v2:
- Performance impact measurements have been provided.
- Link to v1: https://lore.kernel.org/r/20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org

---
Linus Walleij (31):
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
      ARM: irq: Add irqstack helper
      ARM: entry: Convert to generic entry
      ARM: entry: Handle dabt, pabt, and und as interrupts
      ARM: entry: Block IRQs in early IRQ context
      ARM: entry: Straighten syscall returns

 arch/arm/Kconfig                    |   1 +
 arch/arm/include/asm/entry-common.h |  66 +++++++++++
 arch/arm/include/asm/entry.h        |  14 +++
 arch/arm/include/asm/ptrace.h       |   8 +-
 arch/arm/include/asm/signal.h       |   4 -
 arch/arm/include/asm/stacktrace.h   |   2 +-
 arch/arm/include/asm/switch_to.h    |   4 +
 arch/arm/include/asm/syscall.h      |   7 ++
 arch/arm/include/asm/thread_info.h  |  18 +--
 arch/arm/include/asm/traps.h        |   5 +-
 arch/arm/include/uapi/asm/ptrace.h  |   2 +
 arch/arm/kernel/Makefile            |   5 +-
 arch/arm/kernel/asm-offsets.c       |   1 +
 arch/arm/kernel/entry-armv.S        |  82 ++++----------
 arch/arm/kernel/entry-common.S      | 218 +++++++++++++-----------------------
 arch/arm/kernel/entry-header.S      | 100 ++---------------
 arch/arm/kernel/entry.c             | 120 ++++++++++++++++++++
 arch/arm/kernel/irq.c               |   6 +
 arch/arm/kernel/irq.h               |   2 +
 arch/arm/kernel/process.c           |  25 ++++-
 arch/arm/kernel/ptrace.c            |  81 +-------------
 arch/arm/kernel/signal.c            |  57 +---------
 arch/arm/kernel/syscall.c           |  37 ++++++
 arch/arm/kernel/traps.c             |  30 +----
 arch/arm/mm/abort-ev4.S             |   2 +-
 arch/arm/mm/abort-ev4t.S            |   2 +-
 arch/arm/mm/abort-ev5t.S            |   4 +-
 arch/arm/mm/abort-ev5tj.S           |   6 +-
 arch/arm/mm/abort-ev6.S             |   2 +-
 arch/arm/mm/abort-ev7.S             |   2 +-
 arch/arm/mm/abort-lv4t.S            |  36 +++---
 arch/arm/mm/abort-macro.S           |   2 +-
 arch/arm/mm/abort-nommu.S           |   2 +-
 arch/arm/mm/fault.c                 |   4 +-
 arch/arm/mm/fault.h                 |   8 +-
 arch/arm/mm/pabort-legacy.S         |   2 +-
 arch/arm/mm/pabort-v6.S             |   2 +-
 arch/arm/mm/pabort-v7.S             |   2 +-
 38 files changed, 456 insertions(+), 515 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20240903-arm-generic-entry-ada145378bbe

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


