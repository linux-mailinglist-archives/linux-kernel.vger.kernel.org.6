Return-Path: <linux-kernel+bounces-170558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8A88BD921
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9232839C5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B76441D;
	Tue,  7 May 2024 01:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XkEOTxCu"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA95139F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046162; cv=none; b=MfgyT+IbWoqHU1DZwcNjwHAaC9oI9myXFnEvLCUjJj4njaAFIdbFIe6tvqmwq+0d9vFKwFeoQsRSZ0FWLCactWggIEUVAp7Crceo1biP6YJgPj5R04zhjaiiIfGXK8PghmwRYhjLio6iifrNsSaJRwjdx+3E9FCYxCcwKg+GTQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046162; c=relaxed/simple;
	bh=/eyv0Uh2ao8q/bbCKgaJAmKK76ClX1vXa+kTgtkDk4c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XgUW/9kSwdMhkpL7iyQk/d2NDx1K2W32G/OaR7vGoKHkIe61e26tsnlpLyS4ARaI2VqXmg+GMK08e2YZwlqvTu0w6xFW3JRNDo6Jk/fvUDPUn1oOPAGwbFkEq+AtVTUXCS0CxTAlaWkwitEn/3+5uV7LNZxph/nNS0YzhoO3UM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XkEOTxCu; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so2080754a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 18:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715046160; x=1715650960; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kmnHN/SbAxxSeuYauq4GFP+atQwPE2aK0TJawlfr8WY=;
        b=XkEOTxCuXVkG+UZJbM5r6L4oKJ/Hq9FQjPSR2Vr+JG/0R9uzL8Q3lmI8G+PpRe2SjU
         Gtyw9V2IBxUa5hV9T2ILb9V67BdjOdqHeGZGNS3G7n+Fnm0eX1mZ9UwNOl3NSbgOk4O9
         8rBWRf0cPd9uKnEMGMarKIJX6+Xue+J1F878mbdrTSlwQCCIWrLcKEkRzYbZtSKKLTZe
         S9y0j4ps1hcb6GHZECMyzRGZcGrjy2CBX/sIu2pvAPJ4P13lp6nin2kixPhWyF563pow
         Y1hOplYB6d69MhlO3i72LOennKTdqoBBgpalaGKpDG5qrnzBgZyehw2WZD91zrc6f0Us
         8APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715046160; x=1715650960;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmnHN/SbAxxSeuYauq4GFP+atQwPE2aK0TJawlfr8WY=;
        b=w3dXV14l7SxoLPSssKzMgtXD85ootJwgkhOgY3goYAFtk9nr9sVrzhHapEF+0xzZ3Y
         9pPxu3y1RQuOu4cgg1+6a3eeDkSCv+fCZ/aEsuCigRycSLnnjM5lrfvpw3XpNa0+TOru
         VD6DLn6lLuMIE5DO1SuZyfsgWjauwLqSNk1qqZpuSKmDPzy1s3VmZOjiI73xlXHr1suv
         NcNc1wJ7tzb29nvN69mzmTiKaPH3U9xP6vKF/mUEProwhfyCrIXPaA1/CB0jMBPQscnb
         kzs0sZ7iczhXWEFP+dHkmj0aBvt4zBfSqfkz94IZZi9wOkyh60Sv0BOnHZBid5pXyBrV
         mScA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ9baeWrMwvhlnYC3odfNymwK7uZKXAAagvfDWyLTZVx7t9vY1ki9pjbRUtHRrmcyO9RJX31VzsYoymV+hFykQpJdPqtmVrWv75BFu
X-Gm-Message-State: AOJu0YxEMK2rMDW8/eS9THWxxsTqmCzZYKTntOK4mYUPo+SzqbIXDQjV
	UhMshv2RuGcE8J0AmTHKnwsMEtQE/pvAdYxx5F2SNIlvZjOrMQ53KC2jOGSFLVs=
X-Google-Smtp-Source: AGHT+IE0M9Ne2m5CBxBpp6YYkoWQr4AJkn2GuDCP4nYJ95FEwyKQnMMDfx/AtsUhX+F61kOl4bttmw==
X-Received: by 2002:a17:90a:8b06:b0:2a0:86b6:2e9 with SMTP id y6-20020a17090a8b0600b002a086b602e9mr10020425pjn.12.1715046159681;
        Mon, 06 May 2024 18:42:39 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b001eb3f705ddasm8915311plx.255.2024.05.06.18.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 18:42:38 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/8] riscv: Support compiling the kernel with extensions
Date: Mon, 06 May 2024 18:40:41 -0700
Message-Id: <20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJqGOWYC/x2N0QpAQBBFf0XzbIvBA78ibbIXE5Z2hZJ/tzyeu
 ueemzycwFMV3eRwiJfVBkjjiLqxtQOUmMDECedJzqXq1mWTGXqCs5j1Kfuoce2wn+lVycaEZWY
 yLiicbA69XH+gbp7nBagfprBwAAAA
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Song Liu <song@kernel.org>, 
 Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715046158; l=2314;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=/eyv0Uh2ao8q/bbCKgaJAmKK76ClX1vXa+kTgtkDk4c=;
 b=7D+qgX0wTyxP5R4CiXE4WQlV8S07UxtizOQpdZPXGhFlYIF6E1TQkJdxRfTACJNmPgOoZ+540
 Fzf+vg3R3/8D+wfd8q6L1LW0Zaga53p6QxlWTgyYdVzaxd39POjVVAZ
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The kernel currently has the restriction that it can only be compiled
with the extensions that are hardcoded in arch/risc/Makefile.

Any extension that is not listed in the Makefile can still be used by
explicitly writing the assembly and using alternative patching.

This series introduces Kconfig options that allow the kernel to be
compiled with additional extensions.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (8):
      riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_C Kconfig option
      riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_V Kconfig option
      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT Kconfig option
      riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT Kconfig option
      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBB Kconfig option
      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBA Kconfig option
      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBC Kconfig option
      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBS Kconfig option

 arch/riscv/Kconfig                    | 135 +-----------
 arch/riscv/Kconfig.isa                | 393 ++++++++++++++++++++++++++++++++++
 arch/riscv/Makefile                   |  15 +-
 arch/riscv/crypto/Kconfig             |  14 +-
 arch/riscv/include/asm/arch_hweight.h |  33 +--
 arch/riscv/include/asm/checksum.h     |  18 +-
 arch/riscv/include/asm/pgtable.h      |   3 +-
 arch/riscv/include/asm/simd.h         |   3 +
 arch/riscv/include/asm/vector.h       |   3 +-
 arch/riscv/kernel/cpufeature.c        |   3 +-
 arch/riscv/kernel/head.S              |   8 +-
 arch/riscv/kernel/probes/uprobes.c    |   2 +-
 arch/riscv/kernel/process.c           |  14 +-
 arch/riscv/kernel/ptrace.c            |   6 +
 arch/riscv/lib/csum.c                 |  48 ++---
 arch/riscv/lib/riscv_v_helpers.c      |   1 -
 arch/riscv/lib/strcmp.S               |   4 +-
 arch/riscv/lib/strlen.S               |   4 +-
 arch/riscv/lib/strncmp.S              |   4 +-
 arch/riscv/lib/uaccess_vector.S       |   2 +
 arch/riscv/lib/xor.S                  |   2 +
 arch/riscv/net/bpf_jit.h              |   8 +-
 22 files changed, 511 insertions(+), 212 deletions(-)
---
base-commit: 2f47357557b7aa98d9d9002688aae480864ca3f6
change-id: 20240429-compile_kernel_with_extensions-92dd2403d325
-- 
- Charlie


