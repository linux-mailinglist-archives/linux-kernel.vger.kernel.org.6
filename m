Return-Path: <linux-kernel+bounces-268679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8A69427C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3D61F2207C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5861A71E9;
	Wed, 31 Jul 2024 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="w5pZtxi8"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044849644
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410652; cv=none; b=guYBKqggRJa8l++Ys8MQOb8KjeICDgjWVhDJimoBlSSJwmsP05gYmrcj9ZkIAQgAAuuN/6NaBnSZNTRUgqbay21MkB3qiJhfMfR/rVOP4H+JN8nNi/4u9zQJe5MzTpZ/YPCgL17ejZMkZp7mlrzvPbPSXjcdBQJ4v8hW1Ut+o8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410652; c=relaxed/simple;
	bh=qFIA7MQ6Y/pej4TDx5fmgdlHGqXrkV8G9+sAeDh6+E8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ehZiOmM2q3zswtybJO4/aJD0q/hAoiWvdDgNGb+B0tzd4iuUaEzv60GvuG0ZUdrFAhtS9eYJ68QMrGa0voL//IuvVOi+plP71iMbnfpilHRcbl1onJUTBHA7eKXhLGY3MzeJIl0YG8SwoadcFpXMzhuaWfTRVmUMKF9s9bNHYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=w5pZtxi8; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso65519541fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722410648; x=1723015448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4XEkcH/k055fjEkxInfrnU37BtyQRrpfdUKb2KmHLI0=;
        b=w5pZtxi8BGcSbgC9Gfq2UQ+hvdadD2WcTGKto0qjbJcfYMQOoZFS/E72JJCBNiS6+m
         +eEYKT6nAlpZlFuf7nijMJQyRNcGaK+4vlzBogJBdC4rHp1hpv/07tYQlLbdYe51npuS
         MCTKco5z1GuT9rhRG5cLwg4CqcfA8VieNWcFdOQ04iolib7uqmd6piSPvsxW3nsIWnJ7
         FPY0RoxfE4e8iZgrq+Psk9VQGzbEhIhOeZtsP6FIcZ/JHzD7OJzUW3XX0+gvH7sD+bjh
         XBrq61wRM/UuNSPQEmmVKK8Tgf2p5RcLocAXGUvNF/eafGgVmb5Ki0hTcFouMLchWhRZ
         PWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722410648; x=1723015448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XEkcH/k055fjEkxInfrnU37BtyQRrpfdUKb2KmHLI0=;
        b=BNCp+NagpzWitMbbrFRdozCq84zKD8Cxk0F9A9hkUtBmJX4mR4o+yDuqcnfL0JjD9p
         dNOxFFhDBfXKB+WDCv02Qbcb+mOUfJWKRkY/6BvudDqvXn78WgzGg0HCEDdIhHke+Z0r
         MbCI2rx6TG6eeVoQUxE49I8hBScLdr+ULNRwA3xIpJGdfkDZVBA0NOXPZZvOJJy/BQyS
         eUaYZvuEazpOhxrLkyL841Eq8PAdyaIOsKpL9WgDgnzdYxfKGA5CVsptLThI1GZsRaxa
         qSCUc2jGaPsXGzpbt7b6ljMrmLA8WkrRe8f5ws4MG2kTtzagvbbXdTgzZo+tL5wy37Rl
         uVHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+25L8wQj/7ktXqo4nC3+haNACZkaU+ir6dYMob4PKSWD+2v1pi2eDjuc0D4umuDI899D2rn5S86TeRsnUNwSNL/Saj7pDrC3WucK3
X-Gm-Message-State: AOJu0YyUMCP+DYWweD1O78iuqdTPL9DcxoxuJ6oppv6XW9QLdLStNroN
	VRKY+wx7nL3t09TuWEo/vW/lde1EC9/TVT60OA2lszLaqBp8qjBteYVT2XLp/JI=
X-Google-Smtp-Source: AGHT+IFUu/TAKJpoCZRx6pt/JYQm0PBZfuQkxnnENTxesjAVIWWsosjIBVLI4RqCcJMR34ar/hYuOw==
X-Received: by 2002:a2e:9d87:0:b0:2f0:1bb6:dbce with SMTP id 38308e7fff4ca-2f12ee5af77mr90747341fa.41.1722410647587;
        Wed, 31 Jul 2024 00:24:07 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bac614esm10131295e9.24.2024.07.31.00.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:24:07 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 00/13] Zacas/Zabha support and qspinlocks
Date: Wed, 31 Jul 2024 09:23:52 +0200
Message-Id: <20240731072405.197046-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements [cmp]xchgXX() macros using Zacas and Zabha extensions
and finally uses those newly introduced macros to add support for
qspinlocks: note that this implementation of qspinlocks satisfies the
forward progress guarantee.

It also uses Ziccrse to provide the qspinlock implementation.

Thanks to Guo and Leonardo for their work!

v3: https://lore.kernel.org/linux-riscv/20240717061957.140712-1-alexghiti@rivosinc.com/
v2: https://lore.kernel.org/linux-riscv/20240626130347.520750-1-alexghiti@rivosinc.com/
v1: https://lore.kernel.org/linux-riscv/20240528151052.313031-1-alexghiti@rivosinc.com/

Changes in v4:
- rename sc_sfx into sc_cas_sfx in _arch_cmpxchg (Drew)
- cmpxchg() depends on 64BIT (Drew)
- rename xX register into tX (Drew)
- cas operations require the old value in rd, make this assignment more explicit
  as it seems to confuse people (Drew, Andrea)
- Fix ticket/queued configs build errors (Andrea)
- riscv_spinlock_init() is only needed for combo spinlocks but implement it
  anyway to inform of the type of spinlocks used (Andrea)
- Add RB from Guo
- Add NONPORTABLE to RISCV_QUEUED_SPINLOCKS (Samuel)
- Add a link to Guo's qspinlocks results on the sophgo platform
- Reorder ZICCRSE (Samuel)
- Use riscv_has_extention_unlikely() instead of direct asm goto, which is way
  cleaner and fixes the llvm 16 bug
- add dependency on RISCV_ALTERNATIVES in kconfig
- Rebase on top of 6.11, add patches to fix header circular dependency and
  to fix build_bug()

Changes in v3:
- Fix patch 4 to restrict the optimization to fully ordered AMO (Andrea)
- Move RISCV_ISA_EXT_ZABHA definition to patch 4 (Andrea)
- !Zacas at build time => no CAS from Zabha too (Andrea)
- drop patch 7 "riscv: Improve amoswap.X use in xchg()" (Andrea)
- Switch lr/sc and cas order (Guo)
- Combo spinlocks do not depend on Zabha
- Add a Kconfig for ticket/queued/combo (Guo)
- Use Ziccrse (Guo)

Changes in v2:
- Add patch for Zabha dtbinding (Conor)
- Fix cmpxchg128() build warnings missed in v1
- Make arch_cmpxchg128() fully ordered
- Improve Kconfig help texts for both extensions (Conor)
- Fix Makefile dependencies by requiring TOOLCHAIN_HAS_XXX (Nathan)
- Fix compilation errors when the toolchain does not support the
  extensions (Nathan)
- Fix C23 warnings about label at the end of coumpound statements (Nathan)
- Fix Zabha and !Zacas configurations (Andrea)
- Add COMBO spinlocks (Guo)
- Improve amocas fully ordered operations by using .aqrl semantics and
  removing the fence rw, rw (Andrea)
- Rebase on top "riscv: Fix fully ordered LR/SC xchg[8|16]() implementations"
- Add ARCH_WEAK_RELEASE_ACQUIRE (Andrea)
- Remove the extension version in march for LLVM since it is only required
  for experimental extensions (Nathan)
- Fix cmpxchg128() implementation by adding both registers of a pair
  in the list of input/output operands

Alexandre Ghiti (11):
  riscv: Move cpufeature.h macros into their own header
  riscv: Do not fail to build on byte/halfword operations with Zawrs
  riscv: Implement cmpxchg32/64() using Zacas
  dt-bindings: riscv: Add Zabha ISA extension description
  riscv: Implement cmpxchg8/16() using Zabha
  riscv: Improve zacas fully-ordered cmpxchg()
  riscv: Implement arch_cmpxchg128() using Zacas
  riscv: Implement xchg8/16() using Zabha
  riscv: Add ISA extension parsing for Ziccrse
  dt-bindings: riscv: Add Ziccrse ISA extension description
  riscv: Add qspinlock support

Guo Ren (2):
  asm-generic: ticket-lock: Reuse arch_spinlock_t of qspinlock
  asm-generic: ticket-lock: Add separate ticket-lock.h

 .../devicetree/bindings/riscv/extensions.yaml |  12 +
 .../locking/queued-spinlocks/arch-support.txt |   2 +-
 arch/riscv/Kconfig                            |  64 +++++
 arch/riscv/Makefile                           |   6 +
 arch/riscv/include/asm/Kbuild                 |   4 +-
 arch/riscv/include/asm/cmpxchg.h              | 264 ++++++++++++------
 arch/riscv/include/asm/cpufeature-macros.h    |  66 +++++
 arch/riscv/include/asm/cpufeature.h           |  56 +---
 arch/riscv/include/asm/hwcap.h                |   2 +
 arch/riscv/include/asm/spinlock.h             |  43 +++
 arch/riscv/kernel/cpufeature.c                |   2 +
 arch/riscv/kernel/setup.c                     |  38 +++
 include/asm-generic/qspinlock.h               |   2 +
 include/asm-generic/spinlock.h                |  87 +-----
 include/asm-generic/spinlock_types.h          |  12 +-
 include/asm-generic/ticket_spinlock.h         | 105 +++++++
 16 files changed, 533 insertions(+), 232 deletions(-)
 create mode 100644 arch/riscv/include/asm/cpufeature-macros.h
 create mode 100644 arch/riscv/include/asm/spinlock.h
 create mode 100644 include/asm-generic/ticket_spinlock.h

-- 
2.39.2


