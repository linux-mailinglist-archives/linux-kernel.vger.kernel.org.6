Return-Path: <linux-kernel+bounces-393834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1129BA601
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 15:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF211F217BB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 14:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB3117BB1A;
	Sun,  3 Nov 2024 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="z5KILhZ0"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C870820
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730645520; cv=none; b=aP5y5Z5gJ2wsnhk94/zWXQ3HL57cbp+oR1h/3bNlfppg/xFHSuBdgnYNDEDeWr6AyMiihdJR+4N/7UUjLUGofRjQg99jKcTmv87EBI44TLy5g2drMQywXeeihwiPK8I1ZhdGRPeo0tUzMPGMNq4gwuynFewSV4yGH9ZgD4OE64c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730645520; c=relaxed/simple;
	bh=JYh1T1i4AQrEvFqMcUan1Zml1xpl3Q+7dSgH/9JNbyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pVzdfLhHymRhiFoPF5uHaW4DtXUTC4p96scjZhygF79dx2JPctWPX52zcGV7RTvu+4fMAs0q6ett2bKez0Rq5EuBa2KUIRb/YdfaZD1o732a0ZjYU2ub+hDxnrVFDwaEke9Cb/hkZK13XM28K8jKmW3EdgJ1dY70I6PfEr80UnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=z5KILhZ0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43158625112so29005725e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 06:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730645516; x=1731250316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jSppsV7RjjZ1bmxB7W4Mk7Rcpn8dl6Te+yVP1IF48lU=;
        b=z5KILhZ0JNp9KIMtN4YuXPQBt4ixELXpF6PMvG3vhcM5aLbvKilGCwNKZNFHmCq8rm
         79QFb6AilgR0gMdr+xsIONar1h0ffHdnx+vCOsPtANM3XDsfhN32I7nUy6e7viSpBNvV
         zyPGy+7cKybDz1MuUiKypJ3KY4Z/TxNSHeUf8uRfFSatBlGskATFVrNnsScF8wDnnwiN
         KBJAaljPsh5hVf7oCED9lE7F/NmpDz4UEY2iAznkpZ9Tbsnm5Dd/4bvMnoPgiSUH+lNF
         7GujdI257hMnp6waNs9Xo3MGcR6IRquYDNYRnU5nNHzpuzAjRypKAMduH9LbQCUJSt9l
         O/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730645516; x=1731250316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSppsV7RjjZ1bmxB7W4Mk7Rcpn8dl6Te+yVP1IF48lU=;
        b=lYFtSqN/BbVOFA8/q+kRcUHzvm0lKkZ3/A8w5eJgv3sBu6i8HleXq0JpYv8JtSnVMl
         TQvYundpXRW2YpYIdqhzaZxWRV3T83RnaVn4rwub1BJnRdodY6yPf0PGkENl7vpq0QXl
         ko2NvA6Gb4V0GKflSmp49ThwKt1DheyD+M9+965jatJs3aoQRkPgsnPA/zh9FAyxdKcz
         df8fzmUt1oFhvxDX0Atr1YyietJuadhG23RrNzitg27uTp3V991plqiYKf2tQ7ju9VuC
         eBh//9FmcU5MUj2U5xyFGjp0cpnBafOJVAjjNEROl9PR8/RijIV2XEj+FbijXq/94aqO
         Gkqg==
X-Forwarded-Encrypted: i=1; AJvYcCVV5I7/YVvYfX8bMT/f2LLzxfw5/qgybmHtTaeoERDhOX2NBqo+Roc699XyA4HfNU+DltEY6xfnl6H9iLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzV7pngN8qR7uC6e53Z2BncOTl4fJOqj2q5icslBsoNdj2fUA
	KcSWlozDfRuJQk+l+cCrrDH3OK0BCNMv3YUBNyhAUUNwgTuV1LSXjA7VFO9M/ks=
X-Google-Smtp-Source: AGHT+IGjt4U1xHUBvFYLYj0RtN3f0C6NSRnAyUSDbBhxom+UAElrEQDK6qLbjN9NN9sklRU9XdiWmA==
X-Received: by 2002:a05:600c:450d:b0:431:5ba1:a529 with SMTP id 5b1f17b1804b1-4328324b343mr76830645e9.14.1730645515598;
        Sun, 03 Nov 2024 06:51:55 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd91093csm159829025e9.15.2024.11.03.06.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 06:51:54 -0800 (PST)
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
Subject: [PATCH v6 00/13] Zacas/Zabha support and qspinlocks
Date: Sun,  3 Nov 2024 15:51:40 +0100
Message-Id: <20241103145153.105097-1-alexghiti@rivosinc.com>
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

v5: https://lore.kernel.org/linux-riscv/20240818063538.6651-1-alexghiti@rivosinc.com/
v4: https://lore.kernel.org/linux-riscv/20240731072405.197046-1-alexghiti@rivosinc.com/
v3: https://lore.kernel.org/linux-riscv/20240717061957.140712-1-alexghiti@rivosinc.com/
v2: https://lore.kernel.org/linux-riscv/20240626130347.520750-1-alexghiti@rivosinc.com/
v1: https://lore.kernel.org/linux-riscv/20240528151052.313031-1-alexghiti@rivosinc.com/

Changes in v6:
- Rebase on 6.12-rc5
- Fix comment about macros (Drew)
- Add RB from Drew

Changes in v5:
- Remove useless include in cpufeature.h and add required ones (Drew)
- Add RB from Drew
- Add AB from Conor and Peter
- use macros to help readability of arch_cmpxchg_XXX() (Drew)
- restore the build_bug() for size > 8 (Drew)
- Update Ziccrse riscv profile spec version commit hash (Conor)

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
 arch/riscv/Kconfig                            |  69 +++++
 arch/riscv/Makefile                           |   6 +
 arch/riscv/include/asm/Kbuild                 |   4 +-
 arch/riscv/include/asm/cmpxchg.h              | 286 +++++++++++++-----
 arch/riscv/include/asm/cpufeature-macros.h    |  66 ++++
 arch/riscv/include/asm/cpufeature.h           |  61 +---
 arch/riscv/include/asm/hwcap.h                |   2 +
 arch/riscv/include/asm/spinlock.h             |  47 +++
 arch/riscv/kernel/cpufeature.c                |   2 +
 arch/riscv/kernel/setup.c                     |  37 +++
 include/asm-generic/qspinlock.h               |   2 +
 include/asm-generic/spinlock.h                |  87 +-----
 include/asm-generic/spinlock_types.h          |  12 +-
 include/asm-generic/ticket_spinlock.h         | 105 +++++++
 16 files changed, 567 insertions(+), 233 deletions(-)
 create mode 100644 arch/riscv/include/asm/cpufeature-macros.h
 create mode 100644 arch/riscv/include/asm/spinlock.h
 create mode 100644 include/asm-generic/ticket_spinlock.h

-- 
2.39.2


