Return-Path: <linux-kernel+bounces-379697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EEB9AE261
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E4D282947
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8E91C4A37;
	Thu, 24 Oct 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNPvhR/3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343A1C4A31
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765205; cv=none; b=dmjFUCLZrODh2B3L7z0wlOONBSXP4607IfjYfbjyQYsD8rkN6rEHAwEAcbmSzLynJbDqr7TodXWyjXsduOc7OTDOX+gGYI9veqHKSaGxf0HFG4F4RlQkSrGX18xZTY7zKiGrSRvD5nMqVZTyutiPehhZgpyul3UpY+HjwfuS048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765205; c=relaxed/simple;
	bh=okUTxSQsbfDd0mY0w4Anaxq4oFcHbfuhQaRm6V5Xv7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T60IYpUv4DiJASRRYS/TcEqIlyQ6qrTCM16kQilchzNLnzoxWt+Sv2TJTfxoWXlYIy95JXGKzcoWNhE3nhZFoqq7LGoEOUYmw0OIZ81y5hTWfussgXYgT6uByr4s1/iVdgrwl+hhy1B1pgE8a5qvTVsfJZby3E6SLaV+5Sj9cu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNPvhR/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4074DC4CEC7;
	Thu, 24 Oct 2024 10:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729765204;
	bh=okUTxSQsbfDd0mY0w4Anaxq4oFcHbfuhQaRm6V5Xv7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sNPvhR/3VZSmnD/sFgE2XuIRgq1japFQOp1GFZCERt/+5obD/vHO7WUdbGQw5O7Up
	 kbzpStu6GO+Y3hNmXDjT0+aEqCbxuhhPlkOX4VcIOtPZ+NakYQqdw8L0viTt3ra+gl
	 V/VMaxpofdDT3QEz9zTvgHyJI9wPde/ptXdH8/GepN9lgwdsOKVvPA+bJADK2ly4XD
	 UNA6QZdL33VUAClHNfljMzXiHR3UxMLtJT4pCVTkZCEO4ShUXEwXlHdHtTH74qAatH
	 ZaXPVBF0Nj6CHG8LidXqxGIhAz7ZvfNyQYa70IqTiVNXltn1wjltFLMSg7PHpWJr0d
	 hfJ/2O6/4uyWA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	xiao.w.wang@intel.com,
	Andrew Jones <ajones@ventanamicro.com>,
	pulehui@huawei.com,
	Charlie Jenkins <charlie@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Pu Lehui <pulehui@huaweicloud.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH v4 2/2] RISC-V: separate Zbb optimisations requiring and not requiring toolchain support
Date: Thu, 24 Oct 2024 11:19:41 +0100
Message-ID: <20241024-chump-freebase-d26b6d81af33@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024-aspire-rectify-9982da6943e5@spud>
References: <20241024-aspire-rectify-9982da6943e5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8431; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=ws3Sn8rIWf7QKVji6bkkCu27FoMbn//tPeHcDFBZFkI=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOlS8g7veMTyhZuqY/hylLJNhOyFJFRYv6c8/nVsiXfCy X/VMn87SlkYxDgYZMUUWRJv97VIrf/jssO55y3MHFYmkCEMXJwCMJErFxj+B603l1Nu0tmgwBvz YNa5/f8T5oqyHXwd1Bvz8Pfz1SkdwQz/4+0vbnhceZ9/c/3zI4EHdWKqn32rqbi3YX5Sp6bIq3u rGAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

It seems a bit ridiculous to require toolchain support for BPF to
assemble Zbb instructions, so move the dependency on toolchain support
for Zbb optimisations out of the Kconfig option and to the callsites.

Zbb support has always depended on alternatives, so while adjusting the
config options guarding optimisations, remove any checks for
whether or not alternatives are enabled.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig                    |  4 ++--
 arch/riscv/include/asm/arch_hweight.h |  6 +++---
 arch/riscv/include/asm/bitops.h       |  4 ++--
 arch/riscv/include/asm/checksum.h     |  3 +--
 arch/riscv/lib/csum.c                 | 21 +++------------------
 arch/riscv/lib/strcmp.S               |  5 +++--
 arch/riscv/lib/strlen.S               |  5 +++--
 arch/riscv/lib/strncmp.S              |  5 +++--
 8 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 278a38c94c5a6..6ec7a500a25ff 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -664,12 +664,12 @@ config RISCV_ISA_ZBA
 
 config RISCV_ISA_ZBB
 	bool "Zbb extension support for bit manipulation instructions"
-	depends on TOOLCHAIN_HAS_ZBB
 	depends on RISCV_ALTERNATIVE
 	default y
 	help
 	   Add support for enabling optimisations in the kernel when the
-	   Zbb extension is detected at boot.
+	   Zbb extension is detected at boot. Some optimisations may
+	   additionally depend on toolchain support for Zbb.
 
 	   The Zbb extension provides instructions to accelerate a number
 	   of bit-specific operations (count bit population, sign extending,
diff --git a/arch/riscv/include/asm/arch_hweight.h b/arch/riscv/include/asm/arch_hweight.h
index 613769b9cdc90..0e7cdbbec8efd 100644
--- a/arch/riscv/include/asm/arch_hweight.h
+++ b/arch/riscv/include/asm/arch_hweight.h
@@ -19,7 +19,7 @@
 
 static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
-#ifdef CONFIG_RISCV_ISA_ZBB
+#if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
 	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 				      RISCV_ISA_EXT_ZBB, 1)
 			  : : : : legacy);
@@ -50,7 +50,7 @@ static inline unsigned int __arch_hweight8(unsigned int w)
 #if BITS_PER_LONG == 64
 static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
-# ifdef CONFIG_RISCV_ISA_ZBB
+#if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
 	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 				      RISCV_ISA_EXT_ZBB, 1)
 			  : : : : legacy);
@@ -64,7 +64,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 	return w;
 
 legacy:
-# endif
+#endif
 	return __sw_hweight64(w);
 }
 #else /* BITS_PER_LONG == 64 */
diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index fae152ea0508d..410e2235d6589 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -15,7 +15,7 @@
 #include <asm/barrier.h>
 #include <asm/bitsperlong.h>
 
-#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
+#if !(defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)) || defined(NO_ALTERNATIVE)
 #include <asm-generic/bitops/__ffs.h>
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/ffs.h>
@@ -175,7 +175,7 @@ static __always_inline int variable_fls(unsigned int x)
 	 variable_fls(x_);					\
 })
 
-#endif /* !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE) */
+#endif /* !(defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)) || defined(NO_ALTERNATIVE) */
 
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/fls64.h>
diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
index 88e6f1499e889..da378856f1d59 100644
--- a/arch/riscv/include/asm/checksum.h
+++ b/arch/riscv/include/asm/checksum.h
@@ -49,8 +49,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
 	 * worth checking if supported without Alternatives.
 	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
-	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
 		unsigned long fold_temp;
 
 		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index 7fb12c59e5719..9408f50ca59a8 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -40,12 +40,7 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	uproto = (__force unsigned int)htonl(proto);
 	sum += uproto;
 
-	/*
-	 * Zbb support saves 4 instructions, so not worth checking without
-	 * alternatives if supported
-	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
-	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
 		unsigned long fold_temp;
 
 		/*
@@ -157,12 +152,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 	csum = do_csum_common(ptr, end, data);
 
 #ifdef CC_HAS_ASM_GOTO_TIED_OUTPUT
-	/*
-	 * Zbb support saves 6 instructions, so not worth checking without
-	 * alternatives if supported
-	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
-	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
 		unsigned long fold_temp;
 
 		/*
@@ -244,12 +234,7 @@ do_csum_no_alignment(const unsigned char *buff, int len)
 	end = (const unsigned long *)(buff + len);
 	csum = do_csum_common(ptr, end, data);
 
-	/*
-	 * Zbb support saves 6 instructions, so not worth checking without
-	 * alternatives if supported
-	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
-	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
 		unsigned long fold_temp;
 
 		/*
diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
index 57a5c00662315..65027e742af15 100644
--- a/arch/riscv/lib/strcmp.S
+++ b/arch/riscv/lib/strcmp.S
@@ -8,7 +8,8 @@
 /* int strcmp(const char *cs, const char *ct) */
 SYM_FUNC_START(strcmp)
 
-	ALTERNATIVE("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
+	__ALTERNATIVE_CFG("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB,
+		IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB))
 
 	/*
 	 * Returns
@@ -43,7 +44,7 @@ SYM_FUNC_START(strcmp)
  * The code was published as part of the bitmanip manual
  * in Appendix A.
  */
-#ifdef CONFIG_RISCV_ISA_ZBB
+#if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
 strcmp_zbb:
 
 .option push
diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
index 962983b73251e..eb4d2b7ed22b6 100644
--- a/arch/riscv/lib/strlen.S
+++ b/arch/riscv/lib/strlen.S
@@ -8,7 +8,8 @@
 /* int strlen(const char *s) */
 SYM_FUNC_START(strlen)
 
-	ALTERNATIVE("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
+	__ALTERNATIVE_CFG("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB,
+		IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB))
 
 	/*
 	 * Returns
@@ -33,7 +34,7 @@ SYM_FUNC_START(strlen)
 /*
  * Variant of strlen using the ZBB extension if available
  */
-#ifdef CONFIG_RISCV_ISA_ZBB
+#if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
 strlen_zbb:
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
index 7b2d0ff9ed6c7..062000c468c83 100644
--- a/arch/riscv/lib/strncmp.S
+++ b/arch/riscv/lib/strncmp.S
@@ -8,7 +8,8 @@
 /* int strncmp(const char *cs, const char *ct, size_t count) */
 SYM_FUNC_START(strncmp)
 
-	ALTERNATIVE("nop", "j strncmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
+	__ALTERNATIVE_CFG("nop", "j strncmp_zbb", 0, RISCV_ISA_EXT_ZBB,
+		IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB))
 
 	/*
 	 * Returns
@@ -46,7 +47,7 @@ SYM_FUNC_START(strncmp)
 /*
  * Variant of strncmp using the ZBB extension if available
  */
-#ifdef CONFIG_RISCV_ISA_ZBB
+#if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
 strncmp_zbb:
 
 .option push
-- 
2.45.2


