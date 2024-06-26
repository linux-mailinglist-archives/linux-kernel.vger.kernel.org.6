Return-Path: <linux-kernel+bounces-230761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B8A918193
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C65A1F23B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F131802DB;
	Wed, 26 Jun 2024 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ge1Tbcuh"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0D71E52A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407035; cv=none; b=jGCkfg23pgvmFgrZQT9QRZhLUM/HMCZl0/OHVbNeyTMBoLyeJZwezUWj38Pnj6gyOd89DIPY8s/QcRVNp7A8X6mPR6QyVGZw5TQZ8/PT4BT1l+sPsBAkUy/TShguDr92+KxhrNzdCeM+RpGmjVdck59CGXl6AgaXnPhBCImvo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407035; c=relaxed/simple;
	bh=NSGgZUyXn+lVB34ITc38mZyZjEn1cCrrH+ks7gOKByw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZwTIC6DPDUt2wbGiD3yzekIA8by9l00slZISr6xWGbLW/KGfVbmtjJQ6eUFzvHWIazmjR7x298fI3gFptoqiPp8TX/2YErjqScFiKF0nz74iObiXe8eG+EqRNEBTb6yhBs/6APkLTA7WRuSXGaUsS70Y0RCAxiXMgvD55vZ09FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ge1Tbcuh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-424f2b73629so6819535e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719407032; x=1720011832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oqhKGXxgVQtpDeDxTmBY0GRGK3b9WQJ4D/NdPeAScP8=;
        b=Ge1TbcuhBrV+tAoIU7liHmzj+vm6YNncdL/yTNOoFpG5dM8muzIdamlhPvHrmXX/iS
         OcNDDoPl9DXxf8UOAM3cveoPJEh62zUs9dLyy8rxWji40WMXIgdfflGgkKtoC7WkNyrR
         u0T1vHn2vJswaRczqYLxMXrl1QSPDR/8/RO70WVg/lCdKy+gNynXUHY2+Sam4pleHbF3
         PsTEM9em6dHM1yPeTqF2kYp4qTa5juthkUCSQG+blqyGNfeNB2kZ0pGsngCWJGSTZasC
         sgR/dKSlzeIqBqn5+At1JlVgdJ4YqgiVJ6iv1FC9X+LXAuZz4Js+CtABoWxdFdI3QAdY
         4HEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407032; x=1720011832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqhKGXxgVQtpDeDxTmBY0GRGK3b9WQJ4D/NdPeAScP8=;
        b=YnenST9qetUrVo6CA7jnNnHZxPkWvP8YQeoSOip7vfSEWOFtUvrHjqVtnrW15L6riG
         +Z998GFwvheHAerrpBuRNc6v/WTdkX1A0u+mXkMFZEjGzr/JR5LoEUk6B6LT+VpfjvjW
         AUrA9Ehngj+spliCPQeMxgk8/sUtYAjdDaDoaXTpI7IJVqs+MP79cWt8P58jb9MSBlig
         XDUnuAm0IWvEPHp4LiIHwkcOIY0rKEpc3DGM8D6RYvITuqYLWTq0jAERQqsoOM2W6WBd
         pFXMfJRIypGY1FSZyjhhyzdh9wD03/vqRK6kFjLZNFPsExglxaUVns4fobwi0lFny2rW
         7Bsg==
X-Forwarded-Encrypted: i=1; AJvYcCV9sBYfXfWC536ucchZ8OLkHN5OYGLMaBbpbU8tGgGzOOlYtggaSQclSczQZXc4ouLLc5/zjXeIyucLlzEHuVKBnLY473tbowlYYPdc
X-Gm-Message-State: AOJu0Yy4abOVANY5GFleMAZkmI1HjMXYMVve7POPW6ewpnZbx5bovyhI
	X0JFK02yEoXrDdCHH2x4sEKEltm75qoXfPhBEX9QZQa7zY98vBI/Oy7HGr/pLf0=
X-Google-Smtp-Source: AGHT+IFiGsTX5vLxkPVO8Non2VspNfMgpq8c+JsPLrp7qPkiUj2K82s1dz1d1WmsbRzVRpIzAgp9+g==
X-Received: by 2002:a05:6000:174a:b0:364:29ce:b14e with SMTP id ffacd0b85a97d-366e96777a8mr7130622f8f.69.1719407031793;
        Wed, 26 Jun 2024 06:03:51 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663ada0bdesm15693877f8f.113.2024.06.26.06.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:03:51 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
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
Subject: [PATCH v2 00/10] Zacas/Zabha support and qspinlocks
Date: Wed, 26 Jun 2024 15:03:37 +0200
Message-Id: <20240626130347.520750-1-alexghiti@rivosinc.com>
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

Thanks to Guo and Leonardo for their work!

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

Alexandre Ghiti (8):
  riscv: Implement cmpxchg32/64() using Zacas
  dt-bindings: riscv: Add Zabha ISA extension description
  riscv: Implement cmpxchg8/16() using Zabha
  riscv: Improve amocas.X use in cmpxchg()
  riscv: Implement arch_cmpxchg128() using Zacas
  riscv: Implement xchg8/16() using Zabha
  riscv: Improve amoswap.X use in xchg()
  riscv: Add qspinlock support based on Zabha extension

Guo Ren (2):
  asm-generic: ticket-lock: Reuse arch_spinlock_t of qspinlock
  asm-generic: ticket-lock: Add separate ticket-lock.h

 .../devicetree/bindings/riscv/extensions.yaml |   6 +
 .../locking/queued-spinlocks/arch-support.txt |   2 +-
 arch/riscv/Kconfig                            |  45 +++++
 arch/riscv/Makefile                           |   6 +
 arch/riscv/include/asm/Kbuild                 |   4 +-
 arch/riscv/include/asm/cmpxchg.h              | 188 ++++++++++++++----
 arch/riscv/include/asm/hwcap.h                |   1 +
 arch/riscv/include/asm/spinlock.h             |  39 ++++
 arch/riscv/kernel/cpufeature.c                |   1 +
 arch/riscv/kernel/setup.c                     |  21 ++
 include/asm-generic/qspinlock.h               |   2 +
 include/asm-generic/spinlock.h                |  87 +-------
 include/asm-generic/spinlock_types.h          |  12 +-
 include/asm-generic/ticket_spinlock.h         | 105 ++++++++++
 14 files changed, 385 insertions(+), 134 deletions(-)
 create mode 100644 arch/riscv/include/asm/spinlock.h
 create mode 100644 include/asm-generic/ticket_spinlock.h

-- 
2.39.2


