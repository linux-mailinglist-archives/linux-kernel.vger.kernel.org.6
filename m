Return-Path: <linux-kernel+bounces-294241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29232958B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D6E1F23B33
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457EC193067;
	Tue, 20 Aug 2024 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pxM/7lmu"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA8C194A5C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167485; cv=none; b=CZJwrZhxjDU0DmoZz/j+Nfq8JOlJRg/9VI2RlIce0+IOz5Isqdh0U88aUurIKPexiX9+j1CABrLZOQJV3xROx/0Q8KWqqbBxmyZX/KtKF4K/kRrTiuJx3wizhA1dHatyplh6JxaGPmEdg5pb37DXTR3iRwkOkoj8Vlp5cFp6s3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167485; c=relaxed/simple;
	bh=hu9iNDPYCG2l1/0+La0H2CMxvE1QMiMSu720ozrvTZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDae96gOMvT3f58RcflsZmWDNxeXwQbS0EmI+Yfnhuqgw3J3/jmjC1SkjS6rUgQGSOhwU7wn5slphlaGX+KZS729CRP1JgKFK0Z9G0du4MaoMJDlaLrleMRmH79p5jkoY0oeswiqAftxCXZv3T8hFRBLzxQIBTY4VR5vTm2tM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pxM/7lmu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3eda6603cso3263291a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724167483; x=1724772283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr28cnDKR2hf/rAx6taoMNDeMkJdk5A7shPnifntETA=;
        b=pxM/7lmuiGqzr/zUshtnGFfQkyvLuVaz7yPjhaJEmd8uuRkgNSwT7fMfCdOIErGam/
         PZorWFMMbtH9qEWaQaLEsmIn+gJTj2z+T4Lzo1kQvY/5wb2ytOZW+DxVUJdy74zkotob
         hJO5z+T3LytlnOxaEtxv6jt5RdTMlpSjCuRCQn4paQnFzlRIOGAKGMnbfAUnfJt3P8VF
         AMJFFtgT/1OIcXL6IrSHWsw6Zlo8bmCuAddIUCnIproMBOmeg5W0kff96AZ7En71H8N3
         kFFnTG27KjX0Z31r5txLa2oOOFmtFe87JqtFLqRuw+AOnDAtOPglQV4zx9WCX8uYo90J
         1NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167483; x=1724772283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kr28cnDKR2hf/rAx6taoMNDeMkJdk5A7shPnifntETA=;
        b=HX1527uqfdmbocrQWC1i7SHWof6V7/krfH9wXJ+3sOr9wqVhfCQW0ZQGUJjQ+aesAw
         JtbSTTA2kaPIKt9PUkgWDQBe7ojv6yT8CkjJ7vKaXrFICG5G2xBrRtRXUm3fy5kNDfUm
         fNQAhgobYVXk3WMw6WYmbYL8oXhwyQ9YNI4NRB0bxtH3VUD7XpK9AIsB8QWS8jji+MFr
         NpNFTK9VRFZmdCWSmRJbwdzGRuIZvmi/wheqQ/JLkwrNYUC/YQFofiiHPh71LSO/DlOF
         d8ADw6iLCS11UyeEPixOvOi0MmpsRQlGlR9RSeR6uBR3ACXEBv3Hu8MHIV9x8vCxaadv
         wp1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsVPC7/ipJWKxngjcOqOdWxI6WhZu/EH8BGAKnjmTj3ukUd1ubxhqyRAxxcJfj1o95PmPwN2wq4xCTWHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOPYt3Nzsno6+9L43ZkxIe4P3zfNIAwGCdAkoGaL43HfAE64Tl
	UMDTJZ20pYXCbmk4kjoL+6fptM5AoOV4o+CQCGgYSn5G/TwATgOmO5tbP6304HU=
X-Google-Smtp-Source: AGHT+IEs+fOb8xDUxhVr88hKMN1WaP41Ow4SfW38HuzsBc7du8pwa4fzv0vfZ+kCiB5hdUxcmpZEpA==
X-Received: by 2002:a17:90b:4b47:b0:2d3:ce98:9dd5 with SMTP id 98e67ed59e1d1-2d3e00f1bb8mr15020623a91.43.1724167483047;
        Tue, 20 Aug 2024 08:24:43 -0700 (PDT)
Received: from jesse-desktop.ba.rivosinc.com (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d40bea7cb3sm7258157a91.25.2024.08.20.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:24:42 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 3/6] RISC-V: Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED
Date: Tue, 20 Aug 2024 11:24:21 -0400
Message-ID: <20240820152424.1973078-4-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240820152424.1973078-1-jesse@rivosinc.com>
References: <20240820152424.1973078-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED to allow
for the addition of RISCV_VECTOR_MISALIGNED in a later patch.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
V2 -> V3:
 - New patch
V3 -> V4:
 - No changes
V4 -> V5:
 - No changes
V5 -> V6:
 - fix accidental moving of check_unaligned_access_emulated_all_cpus out of the #ifdef
V6 -> V7:
 - No changes
V7 -> V8:
 - Rebase onto fixes
V8 -> V9:
 - No changes
---
 arch/riscv/Kconfig                    | 6 +++---
 arch/riscv/include/asm/cpufeature.h   | 2 +-
 arch/riscv/include/asm/entry-common.h | 2 +-
 arch/riscv/kernel/Makefile            | 4 ++--
 arch/riscv/kernel/fpu.S               | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0f3cd7c3a436..e9295a56b3a5 100644
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
index 06d407f1b30b..71442b22efc8 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -64,8 +64,8 @@ obj-y	+= probes/
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
2.45.2


