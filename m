Return-Path: <linux-kernel+bounces-375426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA31A9A95CB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2A61F23BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763A612FF72;
	Tue, 22 Oct 2024 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XpGTOORg"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DA3126C08
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562358; cv=none; b=lBIrv3brwoJwxncYDJ7cNMcX0HaBG25A5cPmk++Wn+gnNd5YCGoA6qQxBHuLzuuSFOLwrve6J2OBMNLb6NSM49ro3jrqKfB3aVGfTYAJoMSknEfysaC9Ehaya/nfM+uqkhinc4BThOBas9+i7JdQqe8PXwsm4OaB/uNMs8DcrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562358; c=relaxed/simple;
	bh=TzyrsFCUyH+ZbEjiW+A6aFlvAuuT7k2jZ3jHgMSI0a4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eA32+A+dyFi605a3Qk0hkW3ZOl+3YyikD79QPs+OHVWBZGjYD4MCnriJaxGAZ4w5UrbU3fOOwEjngKKK4iedm7t3qCunRBhLJR2h3WmSqfRWUs7UQuU0p8cjHYagCCmRClH4rB5LYy9HrueHH6vBlxTDH6uat5GDs79vuj8MMiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XpGTOORg; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2dcf4b153so3723402a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729562356; x=1730167156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e65ANAnizaofFjgpIDXOaUasil0HVOGTLixFGnIEx4s=;
        b=XpGTOORg/YeHyl8eGoGXhL5RnuC/KdjaMBHBXe/m6rDP0KPV2iYUCUW+JT91RIo8EX
         nXaorTQ3Ox8C/BP8rZ+2dsSlio6JH1fBNPwgEwBGfdwuubPh5SnGWgA4Pebl0fEthBGx
         F80QrwC0tbg/bXHRylEoK7WAP41y6rDDMXZ2av4sERYFgy+2lssZCt5xYgCogKdKBY0Y
         1wHW4vvHoQO5UD2Jhmid2fh8HfaSMnP8BYa0l+JSIfEtQ/uScmPHA7t39JWNyw05HuPG
         8ZK8D4yEVppFHUTwcDFKXCWv0FkBCu3sZUzFeeX9yqjLq0i4je7/75Ew7rdf2pkO8EBp
         KGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729562356; x=1730167156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e65ANAnizaofFjgpIDXOaUasil0HVOGTLixFGnIEx4s=;
        b=jG8MTV6Cquqb/3qnsFXIaP3Kuj71aIY38jKBrPg4LJT4wVfMTuuRg1XwTlHAQRBXTt
         yRrkh/j07DlTdUxHcmROrB6/OYm/bnGEKDCAa+HH/eqszI46ilQbrDFHZReNcSp89tpX
         ubtLpfXUp2aHQmqXowwZAhn3muBYNECDFmDMRmbQwsUQHntpAjlXivLa32JLR3sYoIJ+
         bwwsax2c5aRovpk6rFUWSyBM8vji2nHnOlkz8YrYenWx9704JByLwyUNXqJWYrswzM5B
         UT1On+pSHiTp9CdmcQPiZ/dyU6FuQ9Mw1PkTUdOENRcAItIszudG51UDREBHycqW88sq
         Cmcg==
X-Forwarded-Encrypted: i=1; AJvYcCWf8VzeOods2U3VP/Q8Q7pHRXDr1LI0pdj6vSsw8FcghdfkiJ0pCDURy/acoyAcI9bxCD77hDzFbfrJMcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVr4jarMk5Z9KhQvrsVifP8JLVfiCkAVb924zY6wTharLqb+c
	+/plYFfmoMuOv1bSCRRaUr22HEzQ9skCpQQ/yQk5gmcrmcah0hfohVcyjNue4i4=
X-Google-Smtp-Source: AGHT+IEXsyYj+KgjHmYUKoNKrCcxY4nPfOvA/Yp1hV7DCU8lwbKfMca2QJF0T6KgMVKIPzFYrhGr9A==
X-Received: by 2002:a05:6a20:d81b:b0:1d9:20cf:2c24 with SMTP id adf61e73a8af0-1d96b71566fmr2363833637.29.1729562356331;
        Mon, 21 Oct 2024 18:59:16 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffdcsm3600710b3a.46.2024.10.21.18.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 18:59:15 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com
Cc: llvm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 0/9] kasan: RISC-V support for KASAN_SW_TAGS using pointer masking
Date: Mon, 21 Oct 2024 18:57:08 -0700
Message-ID: <20241022015913.3524425-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series implements support for software tag-based KASAN using the
RISC-V pointer masking extension[1], which supports 7 and/or 16-bit
tags. This implementation uses 7-bit tags, so it is compatible with
either hardware mode. Patch 4 adds supports for KASAN_SW_TAGS with tag
widths other than 8 bits.

Pointer masking is an optional ISA extension, and it must be enabled
using an SBI call to firmware on each CPU. If the SBI call fails on the
boot CPU, KASAN is globally disabled. Patch 2 adds support for boot-time
disabling of KASAN_SW_TAGS, and patch 3 adds support for runtime control
of stack tagging.

Patch 1 is an optimization that could be applied separately. It is
included here because it affects the selection of KASAN_SHADOW_OFFSET.

This implementation currently passes the KASAN KUnit test suite:

  # kasan: pass:64 fail:0 skip:9 total:73
  # Totals: pass:64 fail:0 skip:9 total:73
  ok 1 kasan

One workaround is required to pass the vmalloc_percpu test. I have to
shrink the initial percpu area to force the use of a KASAN-tagged percpu
area in the test (depending on .config, this workaround is also needed
on arm64 without this series applied, so it is not a new issue):

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index b6321fc49159..26b97c79ad7c 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -43,7 +43,7 @@
 #ifdef CONFIG_RANDOM_KMALLOC_CACHES
 #define PERCPU_DYNAMIC_SIZE_SHIFT      12
 #else
-#define PERCPU_DYNAMIC_SIZE_SHIFT      10
+#define PERCPU_DYNAMIC_SIZE_SHIFT      8
 #endif

When running with hardware or firmware that doesn't support pointer
masking, the kernel still boots successfully:

  kasan: test: Can't run KASAN tests with KASAN disabled
      # kasan:     # failed to initialize (-1)
  not ok 1 kasan

This series can be tested by applying patch series to LLVM[2] and
QEMU[3], and using the master branch of OpenSBI[4].

[1]: https://github.com/riscv/riscv-j-extension/raw/d70011dde6c2/zjpm-spec.pdf
[2]: https://github.com/SiFiveHolland/llvm-project/commits/up/riscv64-kernel-hwasan
[3]: https://lore.kernel.org/qemu-devel/20240511101053.1875596-1-me@deliversmonkey.space/
[4]: https://github.com/riscv-software-src/opensbi/commit/1cb234b1c9ed

Changes in v2:
 - Improve the explanation for how KASAN_SHADOW_END is derived
 - Update the range check in kasan_non_canonical_hook()
 - Split the generic and RISC-V parts of stack tag generation control
   to avoid breaking bisectability
 - Add a patch to call kasan_non_canonical_hook() on riscv
 - Fix build error with KASAN_GENERIC
 - Use symbolic definitons for SBI firmware features call
 - Update indentation in scripts/Makefile.kasan
 - Use kasan_params to set hwasan-generate-tags-with-calls=1

Clément Léger (1):
  riscv: Add SBI Firmware Features extension definitions

Samuel Holland (8):
  kasan: sw_tags: Use arithmetic shift for shadow computation
  kasan: sw_tags: Check kasan_flag_enabled at runtime
  kasan: sw_tags: Support outline stack tag generation
  kasan: sw_tags: Support tag widths less than 8 bits
  riscv: mm: Log potential KASAN shadow alias
  riscv: Do not rely on KASAN to define the memory layout
  riscv: Align the sv39 linear map to 16 GiB
  riscv: Implement KASAN_SW_TAGS

 Documentation/arch/riscv/vm-layout.rst | 10 ++---
 Documentation/dev-tools/kasan.rst      | 14 +++---
 arch/arm64/Kconfig                     | 10 ++---
 arch/arm64/include/asm/kasan.h         |  6 ++-
 arch/arm64/include/asm/memory.h        | 17 ++++++-
 arch/arm64/include/asm/uaccess.h       |  1 +
 arch/arm64/mm/kasan_init.c             |  7 ++-
 arch/riscv/Kconfig                     |  4 +-
 arch/riscv/include/asm/cache.h         |  4 ++
 arch/riscv/include/asm/kasan.h         | 29 +++++++++++-
 arch/riscv/include/asm/page.h          | 21 +++++++--
 arch/riscv/include/asm/pgtable.h       |  6 +++
 arch/riscv/include/asm/sbi.h           | 28 ++++++++++++
 arch/riscv/include/asm/tlbflush.h      |  4 +-
 arch/riscv/kernel/setup.c              |  6 +++
 arch/riscv/kernel/smpboot.c            |  8 +++-
 arch/riscv/lib/Makefile                |  2 +
 arch/riscv/lib/kasan_sw_tags.S         | 61 ++++++++++++++++++++++++++
 arch/riscv/mm/fault.c                  |  3 ++
 arch/riscv/mm/init.c                   |  2 +-
 arch/riscv/mm/kasan_init.c             | 32 +++++++++++++-
 arch/riscv/mm/physaddr.c               |  4 ++
 include/linux/kasan-enabled.h          | 15 +++----
 include/linux/kasan-tags.h             | 13 +++---
 include/linux/kasan.h                  | 10 ++++-
 mm/kasan/hw_tags.c                     | 10 -----
 mm/kasan/kasan.h                       |  2 +
 mm/kasan/report.c                      | 22 ++++++++--
 mm/kasan/sw_tags.c                     |  9 ++++
 mm/kasan/tags.c                        | 10 +++++
 scripts/Makefile.kasan                 |  5 +++
 scripts/gdb/linux/mm.py                |  5 ++-
 32 files changed, 313 insertions(+), 67 deletions(-)
 create mode 100644 arch/riscv/lib/kasan_sw_tags.S

-- 
2.45.1


