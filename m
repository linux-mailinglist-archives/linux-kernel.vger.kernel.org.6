Return-Path: <linux-kernel+bounces-538531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4087A499D4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22C0F7A7770
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BBD26AABD;
	Fri, 28 Feb 2025 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXokxL6B"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190418468
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746992; cv=none; b=R7l4LhmhSdfN/g07QJQyWirXMkMGN9SnyFE4917BqAj7AgOzpV8CG4/vnIRSJ+dWegm0Qy80o8H5P6mlkRobpE6IcRqEogDet90E4dJ1ZeFSGjtFSpeCZAn5XbBIc6Ih08z9uXAS6HU5NTjewAGqcrbMfND0sm6rA015D7emjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746992; c=relaxed/simple;
	bh=5pYG09BI/FScw9Yxy9QDJaCp6VH4md7A1XoDAT/MQ2w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CloRvbuNcljAHboA6AgLAhWLT1Iv6MJjUlHQIzZBLVXHM2CL8Pjtd2u038/7+bek5ktafa55Wz9o6WGNrRMMR70G9JCe7Rd6TyKbGqMoNk2uF8XqQ/q+9cijF9ezyPLSHE+q9iQjmPLpnjs0OpJtVn08OYvRuG8PPbrZ7ToSk/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hXokxL6B; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5452e6f2999so2070812e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740746988; x=1741351788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k9ZVSga6lwI98W0bLvyFgnwGf/I1aLNhuhYX32VhGps=;
        b=hXokxL6BlU3MKUEucc4PCvjnPxVZaq6Vr0/3elJhrFqs8FpyAttGQBT+jBEsjwsg1G
         6l/bFwZkZ2Ma2GJIx88oHP4ygIsS3Z8Tw/8/hjJyQ1z6SduzaKkpQH9AboLTVPImej73
         ktg1OfF73baoQWiiNEzHzL8tjjgGeVmPgydHZdkRcZecWv4vbHZvDdjtuVXHGHDqhIJr
         GwTDs6pdfv3Mss2YLJuXl2vFL8fkVSTI9NN61e10rtMtNvvcw95lnuyntcpVV5flgQxi
         HmVmw6FSJ/hS3EvuSeW4ny4gf07JsNx9xMU5gqfnbEmEhPbR4l0o9AFl6rKRky62TPGT
         0jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746988; x=1741351788;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k9ZVSga6lwI98W0bLvyFgnwGf/I1aLNhuhYX32VhGps=;
        b=rBg7A69AZFXwVBTXw7/iS88/7l5ZtHJRXlkOPMGrhLzvka+I4wF5iMlDhUfwMJhDHG
         bmglH8MGPY1APLJea56qZsBZFVWPCY8i8qe71KKi2cKbLGqFo82SzOxR8CZj1s0MKKPe
         bPsqz3I326/n51Mr5fs23O/3ivigG0INzu0Db3Q8diENKPZfyxk0M5SU6xV8YAdQc6pL
         KKWDZsT3vUi8pFTWpA9BoziXMuIkDrdft/nTHyxhc7p+3JALvXr3AXoexAFieu6FIIk+
         ivO7l1ctuqM2zw2j6NOMwC1t+3wqBXJ/F4GVfYQ9bljAEx32KsDix9W+rHLeQa8ZV974
         aJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCWelZRhU5iE5Swb40DPc2+nU1ZNSAUw4sFuL+T/p7iCTSikgM8ulIZg7Ar+0PtZeu5v1+DdrvSbVICgR3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrwg7KrGPqU9VaRq1AbcOdW0c9+f7uXRKFQyaboWrX3iYxm44G
	kV8LsryAUD90Mi8si6TkqFBn8fZQnpaEUaXUiZvVroWDv4L8XvCl1AmcGPXLpeeQiGVB9Qrm4TO
	RpFlNF+r6+R9KwHF4G/xF8jfom4G6a+yZZTg5tBCwcTxnDmCcL4w=
X-Gm-Gg: ASbGncvqBXxpj0mrsPCGBUS8cmczXoUiLGGmTJcjLjXn+8Gkzuyb/05u+aWqCtOZ2jI
	kL4V2Nec+oT9tyt2zO3QEVOLRzEPUP2vdRLIGERCaM05fGE9VwBmiKSlVTiy/wZLLScFw3aUbc8
	qbbeDP4zc=
X-Google-Smtp-Source: AGHT+IHv83YpGHio3+QUhR9YCHOCFGwkWFesxurjw0y4ui3gJWLrfpdRDm9UFJwwj67jhbgnlPAfU8P+mtTd204EoWM=
X-Received: by 2002:a05:6512:701:b0:549:4e7e:d397 with SMTP id
 2adb3069b0e04-5494e7ed39amr937756e87.0.1740746987344; Fri, 28 Feb 2025
 04:49:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 13:49:36 +0100
X-Gm-Features: AQ5f1Jr1JCLHNsD1t1m2zbNIWF1lepmNOrK6kS2jMjpmw7TZR5By60X1siM-XvU
Message-ID: <CACRpkdZCiiMTwf7eGJJ9aCKFOC3_xTGv1JKQUijjyp+_++cZ_A@mail.gmail.com>
Subject: [GIT PULL] Generic entry for ARM
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Russell,

please consider pulling the following git branch for generic entry,
see below.

This branch was just harvested from my own v5 patch series on
lore with b4 am -t 20250225-arm-generic-entry-v5-0-2f02313653e5@linaro.org
then git am on top of v6.14-rc1, so you can do the same if you
prefer.

It's possible to squash patches, even all of them into one
big all-or-nothing patch, given the not very gradual nature generic
entry conversion seems to have.

Main upsides and downsides are in the signed tag.

I don't know who the most important stakeholders are, but I guess
the context tracker maintainer (Paul McKenney) and the people working
on generic entry (tglx) could have a say on how important this is, or isn't.

I think it's pretty neat.

Yours,
Linus Walleij

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/arm-generic-entry-for-v6.15

for you to fetch changes up to 98b8e133458a3feefdf882ea16fb7f1f576a49e5:

  ARM: entry: Reimplement local restart in C (2025-02-28 13:40:44 +0100)

----------------------------------------------------------------
Main upsides:

- Using the same common entry as used by x86_64, RISCV, S390
  and Loongarch, probably soon also ARM64.

- Moves ARM away from the obsoleted context tracker entry points
  user_enter_callable() and user_exit_callable() are now only used
  by ARM, CSKY and Xtensa.

- Solves a few lockdep warnings in the process.

- Converts a bit of assembly into C.

Main downside:

- Slightly increased system call overhead, around 6% in
  measurements.

----------------------------------------------------------------
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
      ARM: entry: Reimplement local restart in C

 arch/arm/Kconfig                    |   1 +
 arch/arm/include/asm/entry-common.h |  66 ++++++++++++
 arch/arm/include/asm/entry.h        |  14 +++
 arch/arm/include/asm/ptrace.h       |   8 +-
 arch/arm/include/asm/signal.h       |   4 -
 arch/arm/include/asm/stacktrace.h   |   2 +-
 arch/arm/include/asm/switch_to.h    |   4 +
 arch/arm/include/asm/syscall.h      |   7 ++
 arch/arm/include/asm/thread_info.h  |  22 ++--
 arch/arm/include/asm/traps.h        |   5 +-
 arch/arm/include/uapi/asm/ptrace.h  |   2 +
 arch/arm/kernel/Makefile            |   5 +-
 arch/arm/kernel/asm-offsets.c       |   1 +
 arch/arm/kernel/entry-armv.S        |  82 ++++-----------
 arch/arm/kernel/entry-common.S      | 198 +++++++++++++-----------------------
 arch/arm/kernel/entry-header.S      | 100 ++----------------
 arch/arm/kernel/entry.c             | 120 ++++++++++++++++++++++
 arch/arm/kernel/irq.c               |   6 ++
 arch/arm/kernel/irq.h               |   2 +
 arch/arm/kernel/process.c           |  25 ++++-
 arch/arm/kernel/ptrace.c            |  81 +--------------
 arch/arm/kernel/signal.c            |  68 +++----------
 arch/arm/kernel/syscall.c           |  59 +++++++++++
 arch/arm/kernel/traps.c             |  30 +-----
 arch/arm/mm/abort-ev4.S             |   2 +-
 arch/arm/mm/abort-ev4t.S            |   2 +-
 arch/arm/mm/abort-ev5t.S            |   4 +-
 arch/arm/mm/abort-ev5tj.S           |   6 +-
 arch/arm/mm/abort-ev6.S             |   2 +-
 arch/arm/mm/abort-ev7.S             |   2 +-
 arch/arm/mm/abort-lv4t.S            |  36 +++----
 arch/arm/mm/abort-macro.S           |   2 +-
 arch/arm/mm/abort-nommu.S           |   2 +-
 arch/arm/mm/fault.c                 |   4 +-
 arch/arm/mm/fault.h                 |   8 +-
 arch/arm/mm/pabort-legacy.S         |   2 +-
 arch/arm/mm/pabort-v6.S             |   2 +-
 arch/arm/mm/pabort-v7.S             |   2 +-
 38 files changed, 484 insertions(+), 504 deletions(-)
 create mode 100644 arch/arm/include/asm/entry-common.h
 create mode 100644 arch/arm/include/asm/entry.h
 create mode 100644 arch/arm/kernel/entry.c
 create mode 100644 arch/arm/kernel/irq.h
 create mode 100644 arch/arm/kernel/syscall.c

