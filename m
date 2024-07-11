Return-Path: <linux-kernel+bounces-249914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C16B792F189
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D661C22F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7391A0729;
	Thu, 11 Jul 2024 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e448ae8Z"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8113A868
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735207; cv=none; b=Z77V5/1+qvIz0wLVMGTQbC1UBJWxfYdu5WGbJ4KURBQglopymZhNecx/MAWP68JsCxFTY+PAadEnHdLMw1PmEB4DkjF/Sm1ZAWXrrcYIGAXgXID80rjSW8rS9AQSDBeWhHnSH9j2DkubhKErfuxN0/NFb/igcFXcVhH3S7OTJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735207; c=relaxed/simple;
	bh=pfCDGF8keLM5aPUqrUsGlT4loVO7m16an3Y85a7tH6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4/q8jJLhXQyhRHMlcXQK2N0/0pYhk0RWK7bvQDlkF1M+WJpIPgVeVSq1o8D00c/A6NWSRnBvq79iBGNqAjb58U5lj+eKf8YZo0U3u0kXH2fHe41VFD2dVNOTW8BwEYCqwcIk4fCHi/CJUhlSanGNRec54f4CEnIecICF8z2qMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e448ae8Z; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b1808dee9so1089026b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720735205; x=1721340005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kJJ78M9DJ/3XjOw3vvvRZ7PzINUaxwHfYx+BpMkyk0=;
        b=e448ae8Zjnz+802E3j5ab0oyjRVyVwTgUguWks/w8X0ykgugvwkphOxCYlkBa7vr9p
         dXucB+hAZ33NVI8EEVu3HPAVBZ0VG3YkOs2MBpurxAf5kljJxibmX4Qrg+P4kFEQDv5e
         o2or84T+NXymD/tsbZBRhM7D6bY5+1GoWzZYKwro7qIz76XxL5sRy3yt01h6sujwnuI/
         Czd7F7NCd2UolUz/JvCN3C+J5tN1RPCXJPTWy4DFuFGDLGV+eXBbgeziyfogkIFXRrgK
         TJdkNIdSls15ByDBvHOePiRQ3B6jTIC7JZs1l+eVJonejZyuDJJSW/Pdw0h9Zm+wq/RN
         YiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720735205; x=1721340005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kJJ78M9DJ/3XjOw3vvvRZ7PzINUaxwHfYx+BpMkyk0=;
        b=bXkDTbscoAOm96GFK/4fxDX0VzjPn6IyOYwDEGkjHH1GdxyM0gXMsz78ac618cS1Ps
         QH4xLcW0yFAVzTp/HuwUIBAzFPuwZy3mRYlCtWIQsti7LqMq+b8gkPhIfqEwM2tdEvge
         mJx1CRHFCtwfS1+r9q5SBsJWyv4ZH1WLD5nrrWLqpWb3t7EttORXa0wVosQANUQm/p/3
         j/vadRtITFbbacnxY/cS89DpV0L0WvMCJdjD0rA6J+2MCmwrqfcqXnNf8wfR9APSjPIN
         jdJSX/Pg/KjsrNvhsGCPwAw/BYEbd8//hJpM3JyRWvoe/3zmakNx4Npl2eiKTw3ibqxQ
         U77Q==
X-Forwarded-Encrypted: i=1; AJvYcCWL+hDttE+5bb0G+L0ZvhRYdXiMIqNFo7OzmDCUtMNeinzPC1YUTuiWrQrkNLg/efHrI54XEyHdssyhVM8vXZJuTSbRM3zsprM3520p
X-Gm-Message-State: AOJu0YzNFXPZSNEHSyNlRJhWg6jPkDPDYaF8rDiHwSzV1VyI+gIlnuTP
	b+BBEmGjDWe3YWboL/XOPoP4h/LSVP/x0HqCFxXsFAdVsWOW0eKJScVo4TigeEY=
X-Google-Smtp-Source: AGHT+IGCRaQSLPQesi7EOhjSZ7CmfA2mWlibxmsfRsVL+D3SOaSzPbZ5wSzr2qwFqtsmhsCMyJ1BHA==
X-Received: by 2002:a05:6a20:4f1e:b0:1c3:b2db:4ddd with SMTP id adf61e73a8af0-1c3b2db4e19mr3370833637.13.1720735205129;
        Thu, 11 Jul 2024 15:00:05 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43898b10sm6169431b3a.7.2024.07.11.14.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 15:00:04 -0700 (PDT)
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
Subject: [PATCH v4 4/7] RISC-V: Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED
Date: Thu, 11 Jul 2024 17:58:43 -0400
Message-ID: <20240711215846.834365-5-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711215846.834365-1-jesse@rivosinc.com>
References: <20240711215846.834365-1-jesse@rivosinc.com>
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
---
V2 -> V3:
 - New patch
V3 -> V4:
 - No changes
---
 arch/riscv/Kconfig                    | 6 +++---
 arch/riscv/include/asm/cpufeature.h   | 2 +-
 arch/riscv/include/asm/entry-common.h | 2 +-
 arch/riscv/kernel/Makefile            | 4 ++--
 arch/riscv/kernel/fpu.S               | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b94176e25be1..34d24242e37a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -717,7 +717,7 @@ config THREAD_SIZE_ORDER
 	  Specify the Pages of thread stack size (from 4KB to 64KB), which also
 	  affects irq stack size, which is equal to thread stack size.
 
-config RISCV_MISALIGNED
+config RISCV_SCALAR_MISALIGNED
 	bool
 	select SYSCTL_ARCH_UNALIGN_ALLOW
 	help
@@ -734,7 +734,7 @@ choice
 
 config RISCV_PROBE_UNALIGNED_ACCESS
 	bool "Probe for hardware unaligned access support"
-	select RISCV_MISALIGNED
+	select RISCV_SCALAR_MISALIGNED
 	help
 	  During boot, the kernel will run a series of tests to determine the
 	  speed of unaligned accesses. This probing will dynamically determine
@@ -745,7 +745,7 @@ config RISCV_PROBE_UNALIGNED_ACCESS
 
 config RISCV_EMULATED_UNALIGNED_ACCESS
 	bool "Emulate unaligned access where system support is missing"
-	select RISCV_MISALIGNED
+	select RISCV_SCALAR_MISALIGNED
 	help
 	  If unaligned memory accesses trap into the kernel as they are not
 	  supported by the system, the kernel will emulate the unaligned
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 347805446151..0ed7d99c14dd 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -33,8 +33,8 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
 
 void riscv_user_isa_enable(void);
 
-#if defined(CONFIG_RISCV_MISALIGNED)
 bool check_unaligned_access_emulated_all_cpus(void);
+#if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
 void unaligned_emulation_finish(void);
 bool unaligned_ctl_available(void);
 DECLARE_PER_CPU(long, misaligned_access_speed);
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
index 5b243d46f4b1..8d4e7d40e42f 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -62,8 +62,8 @@ obj-y	+= probes/
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


