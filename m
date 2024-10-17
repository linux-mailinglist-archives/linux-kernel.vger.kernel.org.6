Return-Path: <linux-kernel+bounces-370463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6E69A2D05
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF25C1C2717C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C6721D16C;
	Thu, 17 Oct 2024 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Se8TbPjx"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EAF21BAE5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191642; cv=none; b=AWLJr8T+iB9so1kPX9VYuLDOF7d3te2PB0snJvI0IbidON4ud7UEErU+IccP68owqHoShUNmb4TYo9lDu3IimJRTX2yhv9S8SSM0Bx2Qh7JhiwBVDB3qKsoSuCxCi0yUr7RrL2qCifwwt0reiwsItI2DwpTB8CnmQGusQccmApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191642; c=relaxed/simple;
	bh=XUHd6q8abuhFDFUEmwM4v+byZDCJ4HjMO3zgXw11AGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3NA/woJEEaHoHsWiOGdsQ9szT3qg/TQMO5BNl01t0C5hrFxCER27mFpAGrTZUXgKrrfWlmWISb008pwcVZqEm0jWzNu4ks0omZx3x95Jtk6jd1b61HkKU0VaGtl0sA/ecMsfhEXpVY8iozObUVh03PDvNuHF64oVZFDpbLbv9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Se8TbPjx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c805a0753so11772605ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729191637; x=1729796437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogonrlLXVsX6M3+rlqKepY1dG9PkImghSSy1s/qibR0=;
        b=Se8TbPjxqItGLvLSv0BEzrHgqLwPQo8sCodfhtPi3P1OuDWZ5KCG4vQmzOoVT5AZmS
         0fqDWIrHuibcLQzvNIJ78GbrIcXT8OXUKt3TpXRP4vFxynMILvk4195hLaqsAsSHvH14
         PB7iL0cdQ16iurW+v7ve+aFsLeiMAyUf2n4UGk4v2UDnz/wSp8R8o3UcSSwUfxbKZdD/
         F3RAj4SQyn6AITMX9RuEtv4IdJf6bLfKOZfCu2WSJzP38UbpnixVSnTGtdbRqK/SXqb0
         /rEbf7LOIqQwh0N/Yj2SpmV/lsOfRCCKwYzM8UgQBowonSj6GOK4vOepLZReadMVV8j2
         hnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191637; x=1729796437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogonrlLXVsX6M3+rlqKepY1dG9PkImghSSy1s/qibR0=;
        b=PQ1VLisRJ+99EH0lN+XeuWWpbsNk4LactZdL8X5GGWkzhwN89hqqZIim8wQIjM9pjl
         S75ECWPwyQZmnntXEB9HlL4MJ+raJahFk5gibuFJJZ9xIKGzPc5MT+fb6Ef4bVOSPbAv
         MypY/McFFwNttj2KEiteNjSkyBDYHMyg2/UhOKUB8PHxkhWFtURnfQhwIrZaWtZ+E22R
         b7+RVjYGwavhGxOaJwXbGueliR+o8fgQmVaMHLw3GZ6RkP8dx9VdGkLvRjo2QCxuGiYO
         LKZFQgDkUHd4s+ltoeEWIwxA0p4IgQRsSY8FLa65v4Kzh1RuODjEXn3hztllmm5rPvSO
         7U2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV79xqQTEtcT2Wkv0YDMDO4ZRhN4VXRcwQUVmKEEPLU71Jq4nhA89o20Zlkp32s1jTmgh8cSaMAg9vTOEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvUsYI1NKy8UKdGDjpHJ+VQeH90Zmh1dBZoR9ufE1gorfaXFWr
	AnYoGnW0HrNoj6Q9sleaoIeZTmv/ult/+SvQFubCYAjT1jVQSUihyxrzSfmbEJs=
X-Google-Smtp-Source: AGHT+IGtsotcPt9N7zM25wfsZRy04iqy+fteSW/madU0GyC6QM/RMEa7M8aYdsNK2J6fNpkiAn+1Eg==
X-Received: by 2002:a17:903:2283:b0:20b:a10c:9bdf with SMTP id d9443c01a7336-20d27ed02f5mr114467135ad.32.1729191637057;
        Thu, 17 Oct 2024 12:00:37 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55d7bf9a8sm217766a91.13.2024.10.17.12.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:00:36 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 17 Oct 2024 12:00:20 -0700
Subject: [PATCH v10 3/6] RISC-V: Replace RISCV_MISALIGNED with
 RISCV_SCALAR_MISALIGNED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-jesse_unaligned_vector-v10-3-5b33500160f8@rivosinc.com>
References: <20241017-jesse_unaligned_vector-v10-0-5b33500160f8@rivosinc.com>
In-Reply-To: <20241017-jesse_unaligned_vector-v10-0-5b33500160f8@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Evan Green <evan@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Jesse Taube <jesse@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4308; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=oS5AxBPQyGJnJ4mjuTj84YXbYf1uYCdG7DZp3yT92dA=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7pg3BmmAxGrqwuXpP2u2O/hcdE5z/hSYtyy5/c1Hk+bc
 HrfznPnOkpZGMQ4GGTFFFl4rjUwt97RLzsqWjYBZg4rE8gQBi5OAZiIwQyG/8m/1d+IHFCcXPB7
 6tKovL0HObaLWEg9Squ+sWm12I99sVWMDBv/mM+7mt7aIR9h8aaI8XXG15ceOW1ZZ/6ZMZz88e/
 KKVYA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

From: Jesse Taube <jesse@rivosinc.com>

Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED to allow
for the addition of RISCV_VECTOR_MISALIGNED in a later patch.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 arch/riscv/Kconfig                    | 6 +++---
 arch/riscv/include/asm/cpufeature.h   | 2 +-
 arch/riscv/include/asm/entry-common.h | 2 +-
 arch/riscv/kernel/Makefile            | 4 ++--
 arch/riscv/kernel/fpu.S               | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 939ea7f6a228..2d963d4a26d7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -765,7 +765,7 @@ config THREAD_SIZE_ORDER
 	  Specify the Pages of thread stack size (from 4KB to 64KB), which also
 	  affects irq stack size, which is equal to thread stack size.
 
-config RISCV_MISALIGNED
+config RISCV_SCALAR_MISALIGNED
 	bool
 	select SYSCTL_ARCH_UNALIGN_ALLOW
 	help
@@ -782,7 +782,7 @@ choice
 
 config RISCV_PROBE_UNALIGNED_ACCESS
 	bool "Probe for hardware unaligned access support"
-	select RISCV_MISALIGNED
+	select RISCV_SCALAR_MISALIGNED
 	help
 	  During boot, the kernel will run a series of tests to determine the
 	  speed of unaligned accesses. This probing will dynamically determine
@@ -793,7 +793,7 @@ config RISCV_PROBE_UNALIGNED_ACCESS
 
 config RISCV_EMULATED_UNALIGNED_ACCESS
 	bool "Emulate unaligned access where system support is missing"
-	select RISCV_MISALIGNED
+	select RISCV_SCALAR_MISALIGNED
 	help
 	  If unaligned memory accesses trap into the kernel as they are not
 	  supported by the system, the kernel will emulate the unaligned
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index dfa5cdddd367..ccc6cf141c20 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -59,7 +59,7 @@ void riscv_user_isa_enable(void);
 #define __RISCV_ISA_EXT_SUPERSET_VALIDATE(_name, _id, _sub_exts, _validate) \
 	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _validate)
 
-#if defined(CONFIG_RISCV_MISALIGNED)
+#if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
 bool check_unaligned_access_emulated_all_cpus(void);
 void check_unaligned_access_emulated(struct work_struct *work __always_unused);
 void unaligned_emulation_finish(void);
diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index 2293e535f865..0a4e3544c877 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -25,7 +25,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 void handle_page_fault(struct pt_regs *regs);
 void handle_break(struct pt_regs *regs);
 
-#ifdef CONFIG_RISCV_MISALIGNED
+#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
 int handle_misaligned_load(struct pt_regs *regs);
 int handle_misaligned_store(struct pt_regs *regs);
 #else
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 7f88cc4931f5..45624c5ea86c 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -68,8 +68,8 @@ obj-y	+= probes/
 obj-y	+= tests/
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
-obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
-obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
+obj-$(CONFIG_RISCV_SCALAR_MISALIGNED)	+= traps_misaligned.o
+obj-$(CONFIG_RISCV_SCALAR_MISALIGNED)	+= unaligned_access_speed.o
 obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)	+= copy-unaligned.o
 
 obj-$(CONFIG_FPU)		+= fpu.o
diff --git a/arch/riscv/kernel/fpu.S b/arch/riscv/kernel/fpu.S
index 327cf527dd7e..f74f6b60e347 100644
--- a/arch/riscv/kernel/fpu.S
+++ b/arch/riscv/kernel/fpu.S
@@ -170,7 +170,7 @@ SYM_FUNC_END(__fstate_restore)
 	__access_func(f31)
 
 
-#ifdef CONFIG_RISCV_MISALIGNED
+#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
 
 /*
  * Disable compressed instructions set to keep a constant offset between FP
@@ -224,4 +224,4 @@ SYM_FUNC_START(get_f64_reg)
 	fp_access_epilogue
 SYM_FUNC_END(get_f64_reg)
 
-#endif /* CONFIG_RISCV_MISALIGNED */
+#endif /* CONFIG_RISCV_SCALAR_MISALIGNED */

-- 
2.45.0


