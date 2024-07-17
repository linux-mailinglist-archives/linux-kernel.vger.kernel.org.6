Return-Path: <linux-kernel+bounces-254717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E09336C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC5F28366E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5357182DF;
	Wed, 17 Jul 2024 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="t4eieDr8"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3115A8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197203; cv=none; b=bEvO+TNO9cZBfRLHyTtPFoNnmtf+vmr7UoZgwxjJ4DRHXuDTBGqvEtz2a7nHox062eyhlPniQv+mKtK0VJs7GEZ7u/pP9q3Ip0LN1uuVbdvTKxA1pz+me2hLLgJbGJNY8gD+8ZnSnfgSPr9a/GLCkyumIEgkjTlgZ2zLuZI+nc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197203; c=relaxed/simple;
	bh=j9srs9nAnpbXPq4+gRRVXvcW0EdC9DSG3MCGvVineuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZOppn/SguEVKxkE41VlL+QQb/YTtnZyC7EfCb+5TWutbiIjZImABVb6p2YOD40O0cwMdFFNtJ/WnXWsBQ6UoiLbSjSz4tW3WfYRACEg1gBo0d2R8C9zRoPGkE1C9/YYYqOiQnv7Ez+K00aZmptRE5eBPHQ2lf0fV8Mc5p6dqEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=t4eieDr8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36794da7c96so2010273f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721197200; x=1721802000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yhNEaA58GnjE0ZOg3aM00z4yK1KZNxci32RzU98eyS0=;
        b=t4eieDr8SAJwiGyP9IOICgreABHtfHAssAGaLi2xHMNRAsY7SYsKxcde2VMsel53s9
         Psg8OjV5bEQDkyn4qC15IBhmvvwpxwAg5HoHsc2ItkAWdA/EwZ8+TizR3jnCnLpvUfsz
         RMHIBlNP2MVk50PwiaunkcMlWVniz7Ai7sJLGDlycY22Ym+2lioHZBXFwmLeVEGjTGT5
         6G6sGKf5TE6sti7Ezaq+WlKxnW7W0wfFKHPGUZyWg7zC8cMCR9zNj0SZIi9HwV7zpWHS
         Nnj8PD92pRQ1+SklzN59CoazjotwCKMRzzHUuERgTCZvQDtpuiaLzkeyzkv+4dkdLYES
         bcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197200; x=1721802000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhNEaA58GnjE0ZOg3aM00z4yK1KZNxci32RzU98eyS0=;
        b=hfCR0fW93dxpoxHgbe0/sX9wi6UL5h4ICtEr5/Gf8fpxUWiKYwNkaAOHmpm06faDvB
         WlndabSnxk25pXWmiRu2gShp5B2+3NzzOV2OLV7Pj5kiWVpf5i3ufse9uwvXbf7xQr2v
         NjhDuElsGpWhio7D9WEkuxpW+BFLvfyW1RkHLBRsnGg/eLLlmC02pfckDlar3krFylXY
         qEtJ+7Pn//gCSFd1AoVHEnFbYWUTj2OTJIlKuluN38Ryfc+F7tq0oPnGyAuVlm05aj5L
         WuUdSuoGRSQPf1xxLWRqd434DpIITu0utAc79twsAKZnakb52mjfAIPdtkg4L8VEdyh3
         bXww==
X-Forwarded-Encrypted: i=1; AJvYcCWRfKjOH1KHY3vKmOQKpW0aC9Dp/PWVdDxV5OVFfp8NGHYEWjhPArpTdGX7WUG4EdVTQW0fa/VC52IzVRj7q3Epf8aByYnWmnFC+CkE
X-Gm-Message-State: AOJu0YyIkqDELDISNFLhYLu5Uqc5eNX/Vls885cKwCwHDF9eR7M4fpws
	5BVOACOVHhVHimTh0MTGCAkk6VoZKtTxr6UwolTjOO4zyX4NG6aNgcKzGCRkats=
X-Google-Smtp-Source: AGHT+IH2Ub3+EknL1gUx1NfUraNKSGCuOCbZvlC/zfL0v4oiDuPs02HhZpBSCOUPP41ekb0rzD3Bvw==
X-Received: by 2002:adf:ef4a:0:b0:367:f05a:8f6c with SMTP id ffacd0b85a97d-368317935f2mr456419f8f.57.1721197199838;
        Tue, 16 Jul 2024 23:19:59 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db0f18bsm10755605f8f.117.2024.07.16.23.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:19:59 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 00/11] Zacas/Zabha support and qspinlocks
Date: Wed, 17 Jul 2024 08:19:46 +0200
Message-Id: <20240717061957.140712-1-alexghiti@rivosinc.com>
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

v2: https://lore.kernel.org/linux-riscv/20240626130347.520750-1-alexghiti@rivosinc.com/
v1: https://lore.kernel.org/linux-riscv/20240528151052.313031-1-alexghiti@rivosinc.com/

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

Alexandre Ghiti (9):
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

 .../devicetree/bindings/riscv/extensions.yaml |  12 ++
 .../locking/queued-spinlocks/arch-support.txt |   2 +-
 arch/riscv/Kconfig                            |  64 +++++++
 arch/riscv/Makefile                           |   6 +
 arch/riscv/include/asm/Kbuild                 |   4 +-
 arch/riscv/include/asm/cmpxchg.h              | 173 +++++++++++++++---
 arch/riscv/include/asm/hwcap.h                |   2 +
 arch/riscv/include/asm/spinlock.h             |  39 ++++
 arch/riscv/kernel/cpufeature.c                |   2 +
 arch/riscv/kernel/setup.c                     |  33 ++++
 include/asm-generic/qspinlock.h               |   2 +
 include/asm-generic/spinlock.h                |  87 +--------
 include/asm-generic/spinlock_types.h          |  12 +-
 include/asm-generic/ticket_spinlock.h         | 105 +++++++++++
 14 files changed, 424 insertions(+), 119 deletions(-)
 create mode 100644 arch/riscv/include/asm/spinlock.h
 create mode 100644 include/asm-generic/ticket_spinlock.h

-- 
2.39.2


