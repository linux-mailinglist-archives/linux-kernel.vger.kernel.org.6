Return-Path: <linux-kernel+bounces-172597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397EA8BF423
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8B62839B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F51B944E;
	Wed,  8 May 2024 01:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dIBbIyi1"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2E8BEC
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 01:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132202; cv=none; b=OugU/773zk2FA3KGOuS8gQzay6XS5MHC2bVbOAcXNPLXjerShEWM4cOUYVFS/j4+FbrldgfYUPwiJk1+E8czNCL0rZb2frAr2154BvGJj6V4DfdnmOQsN0qK8+kOo84Cpcugy6EhTG80WnUaxcfCbj0yNTk+4rCOo+2AAwtJFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132202; c=relaxed/simple;
	bh=JLgbatqmIExlBnuCq3aANbOE8Onz3/4vLKRdWZjAJIg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aypaJhUGDifOCPpILK5mXI2kHcUmPcXU72xeTC14MpBisoCtCcJmW32vNq50has/8N3TaRV8Q5dLuuI+U4jKgykk+bZJvkEErvPD0Rv1PgX4e+R04EwnV44BFBu8yretbr3xF9KoUOEJPfV+MhDS3g3vshkNEnYhn+EaYz18GPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dIBbIyi1; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-60585faa69fso253844a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 18:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715132200; x=1715737000; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+7QlTjnxppzA5Udx+bzDo8JE3hSKFTseR43SNN1UptE=;
        b=dIBbIyi1hZUqfa9cSBwJy3TH+ZwSIkis6WZZRp+dPwBDhtmgvn7HDGHzOAmrgKssoB
         KuAJ5IDg5ZYgjPHOYzMD8D2F7fMMT/rhvqbdm2wf/qCwDBPHWXw9QJDUiWOMDG+pBU5r
         eB6Z4az3eAWzoZTgkG9oZSeAUFQxd0uDBZb8SyBe/VF7l1mlhnekagIhu+Sz2qWGaw4V
         XczIrsll84AJsUFU14NchzA1yTbbn14lXudD2g6NhxSXpnx23lftxz1UZNZJs8SV3f1B
         9mT7uQd076OVSjE1kmm2jEKuwVi4eRnzCHt2jTZTO5tG/kOGVHbAJ5ITdzhvLEPsj0Vp
         u+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715132200; x=1715737000;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7QlTjnxppzA5Udx+bzDo8JE3hSKFTseR43SNN1UptE=;
        b=HfJ5Iw0XTZQuRiWEtnCL7AAbrZDxNd08QQvxk4MFFe2x/A+1YZugGcDwKm1niAx5Ri
         YM7fYzVH9EptbKb+LCGhQeS4kZKAawedu3+/SSivgOElWXMwiOHWYXV7rPRsrnFXJ/73
         xq96QJ4LPvnyOVKFiJQ6YngLxO6P+H+Dk/HGAkEt6F43ji1wNOsHjdbn0F2uNXJC2/gM
         841BfJwUiEuOS5CJO/qyWAJMTmvehxJn2dYr2XpPR4XrE84Z3ruzpCyfSXb95ROL3Dup
         plT0P6upAqHuZqM7q4r1PVl76VcHelDs8+xfOxyn9ZYcrIs4giOYkAujvkqB1yMOppBz
         Q5QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWchGFmhcsdazFZhsqwMJKNjWUwAJo/u4UbN51wAE0s8nmJYenX0ZV7GLF+ljdlihU9H+JmQw1E+FWjzfFAmYk1o0c1JXzSw0lnr2gP
X-Gm-Message-State: AOJu0YypMP1g2AihHrJeYiZ7mDYq8QW6e4RiJ19hlS1GKA0Rb9zetKoG
	cRgvFegtOh7G172M7Dy6GS+0iuq+4c4JWb++cNzCESpFxFDlqS4wCvqOoxr6wNY=
X-Google-Smtp-Source: AGHT+IGBUMwgwED594JfXAPKf75mxxw8xGyD68Kq1T2yA2i8v2BD/Iit1PYfzguaf0S8GcMHvm4ZFA==
X-Received: by 2002:a17:90a:d790:b0:2af:33a6:f820 with SMTP id 98e67ed59e1d1-2b611378d9fmr1997613a91.1.1715132200272;
        Tue, 07 May 2024 18:36:40 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863a265sm171994a91.10.2024.05.07.18.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 18:36:39 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/8] riscv: Support compiling the kernel with more
 extensions
Date: Tue, 07 May 2024 18:36:26 -0700
Message-Id: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABrXOmYC/4WNUQ6CMBBEr0L225qyUA1+cQ9DiGlX2YgtaUnFk
 N7dggfw801m3qwQyDMFuBQreIoc2NkMeChADzf7IMEmM6DEWtbYCO1eE4/UP8lbGvs3z0NPy0x
 2WwbRoDG5WZkKFWTJ5OnOy35w7TIPHGbnP/tfLLf0p1by9E8dSyGF0qh0WdVaNufWc3SBrT7mJ
 XQppS+UkX6CzwAAAA==
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Song Liu <song@kernel.org>, 
 Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>, Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715132198; l=3278;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=JLgbatqmIExlBnuCq3aANbOE8Onz3/4vLKRdWZjAJIg=;
 b=KiyA7L0KVvS1JXAVEqaLEplXpWMoEL9cajQs3TtOugD7mQ62ZP7TAKqfmSj3ujpal1dMogWjs
 utnjYrKD1D3Bkd7DacIU9Ge0j4MDOYapJ08pOkqHW8T3bLIMCqV5aoC
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The kernel currently has the restriction that it can only be compiled
with the extensions that are hardcoded in arch/risc/Makefile.

Any extension that is not listed in the Makefile can still be used by
explicitly writing the assembly and using alternative patching.

This series introduces Kconfig options that allow the kernel to be
compiled with additional extensions.

The motivation for this patch is the performance improvements that come
along with compiling the kernel with these extra instructions. Allowing
the compiler to emit arbitrary Zb* instructions achieves a 4.9%
reduction of dynamic instruction count for a test ran in Spike that
boots the kernel and runs a user space program that prints to the
console.

Additionally, alternatives that check if an extension is supported can
be eliminated when the Kconfig options to assume hardware support is
enabled.

This series is based on the wording changes from Conor in:

https://lore.kernel.org/lkml/20240424-tabby-plural-5f1d9fe44f47@spud/T/

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Eliminate references to incorrect config in Svpbmt patch (Jess)
- Add motivation to cover letter (Conor)
- Remove "v" from march
- Correct the ifdef for vector
- Correct the ifdef for Svnapot
- Link to v1: https://lore.kernel.org/r/20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com

---
Charlie Jenkins (8):
      riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_C Kconfig option
      riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_V Kconfig option
      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT Kconfig option
      riscv: Move RISCV_ISA_SVPBMT to Kconfig.isa
      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBB Kconfig option
      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBA Kconfig option
      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBC Kconfig option
      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBS Kconfig option

 arch/riscv/Kconfig                    | 133 +-----------
 arch/riscv/Kconfig.isa                | 393 ++++++++++++++++++++++++++++++++++
 arch/riscv/Makefile                   |  14 +-
 arch/riscv/crypto/Kconfig             |  14 +-
 arch/riscv/include/asm/arch_hweight.h |  33 +--
 arch/riscv/include/asm/checksum.h     |  18 +-
 arch/riscv/include/asm/pgtable.h      |   3 +-
 arch/riscv/include/asm/simd.h         |   3 +
 arch/riscv/include/asm/vector.h       |   3 +-
 arch/riscv/kernel/cpufeature.c        |   3 +-
 arch/riscv/kernel/head.S              |   8 +-
 arch/riscv/kernel/probes/uprobes.c    |   2 +-
 arch/riscv/kernel/process.c           |  12 +-
 arch/riscv/kernel/ptrace.c            |   6 +
 arch/riscv/lib/csum.c                 |  48 ++---
 arch/riscv/lib/riscv_v_helpers.c      |   1 -
 arch/riscv/lib/strcmp.S               |   4 +-
 arch/riscv/lib/strlen.S               |   4 +-
 arch/riscv/lib/strncmp.S              |   4 +-
 arch/riscv/lib/uaccess_vector.S       |   2 +
 arch/riscv/lib/xor.S                  |   2 +
 arch/riscv/net/bpf_jit.h              |   8 +-
 22 files changed, 509 insertions(+), 209 deletions(-)
---
base-commit: 2f47357557b7aa98d9d9002688aae480864ca3f6
change-id: 20240429-compile_kernel_with_extensions-92dd2403d325
-- 
- Charlie


