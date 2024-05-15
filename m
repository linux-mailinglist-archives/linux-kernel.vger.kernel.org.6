Return-Path: <linux-kernel+bounces-180068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC4B8C69AE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA751F21FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3CA156227;
	Wed, 15 May 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT4xbhif"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17D155A5D
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786895; cv=none; b=knj9y5f05z3UP4D9ud10Gam4ya5QrabGHlvTOXPwqXouVZZ3WfoY4eXkVLodUFRHUog8T4kgRTjWg7xZY3gvOdkUcUmTj+jec57q3PM7OEVUZ3eRpPauke0HfXfNCEqK9J4oqUSyMALvX6+OlrKD206bd98Fwdm3pVEkKof7sr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786895; c=relaxed/simple;
	bh=R6gVY7FVJaWS0Na7LhBOOOlMaTUNdeLkTe6U83u8smg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FFFo2MOc9R83jR46Ygs7sHps0ySgRfDLXX42WexdW6NJ4yhH74dR9RuqttiwE6L9MayxDO2uTweyLKGIUZoUcPhKT5dBH6WL84N0589QU0jztSlt1d+6t2rjLm8KQH7eUlNHh4XpGWR2/xUDFshlBq7tvxaCcHuQyvqqR5Goprg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT4xbhif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EFDC116B1;
	Wed, 15 May 2024 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715786895;
	bh=R6gVY7FVJaWS0Na7LhBOOOlMaTUNdeLkTe6U83u8smg=;
	h=From:To:Cc:Subject:Date:From;
	b=UT4xbhifLvilw/tyGq9/SEMwftyR9mEvCNmSuPuXisidVr6LSQYLj1hiVWXnI7kgd
	 ydICc2Gob3VhLE+77o2B6+hxv7nOr1EtugcZQT8pq//4rWo9FUSxZKlleOGq+/XLmG
	 AcYY/EwY2ybMIwfQk9szSBiPxPn4yfrn3sF6SbgU0uV66Wtu22kS/NFYk0yDoWP5Vn
	 wR76OixfYOv1YE9C34Gn82ePnXQkCcwxXzSFSgmtbA+/SuliLXaP0HzpyoPN0ER1MR
	 e/2522wxsS5nXvmxJR2UgwFcrTdIfLB5/OtKfiKzNYDu6YFalLZqJzJUkOiQi9cv9r
	 0R6Dz5jdLXbkQ==
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] RISC-V: separate Zbb optimisations requiring and not requiring toolchain support
Date: Wed, 15 May 2024 16:27:40 +0100
Message-ID: <20240515-hedging-passage-44fd394ab1be@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8907; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=XwP4n1lKCC0d/1n1H9SYTARGbDfq2MDy76bBXq3ujYY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGkuV7Jf8e6LclK/6OP/ZK7/J5PpK27PklcVXrXjcrfvB NVlMasaO0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjARJT2GvzJtxe078iu++y5y SdsyhSmYedPmtWynt9R+1TWSORf28CTD/3q/HRoGT6e/s0spnT9twvX7Hemf7ujOTjvX8WW59aE MGxYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

It seems a bit ridiculous to require toolchain support for BPF to
assemble Zbb instructions, so introduce hidden a Kconfig option that
controls the use of any toolchain-requiring optimisations while support
is available.

Zbb support has always depended on alternatives, so while adjusting the
config options guarding optimisations, remove any checks for
whether or not alternatives are enabled.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

This patch stems out of a conversation about Zba optimisations in BPF.
I'm not super sold on the approach in all honesty, even though we
recently had a conversation about respecting the Kconfig options - but
at this point I'd be convinced to just add some wording to the Kconfig
options mentioning that BPF optimisations are excluded.
Having hidden options that mean someone can turn what on what they
think are Zbb optimisations but not actually get any cos their toolchain
doesn't support it seems crap to me. I don't wanna add another
user-visible option for that situation cos I wanna try to minimise the
extent of our extension-related Kconfig options, not blow them up like
Augustus Gloop!

Cheers,
Conor.

CC: xiao.w.wang@intel.com
CC: Andrew Jones <ajones@ventanamicro.com>
CC: pulehui@huawei.com
CC: Charlie Jenkins <charlie@rivosinc.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Conor Dooley <conor.dooley@microchip.com>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 arch/riscv/Kconfig                    | 15 ++++++++++++---
 arch/riscv/include/asm/arch_hweight.h |  4 ++--
 arch/riscv/include/asm/bitops.h       |  4 ++--
 arch/riscv/include/asm/checksum.h     |  3 +--
 arch/riscv/lib/csum.c                 |  9 +++------
 arch/riscv/lib/strcmp.S               |  4 ++--
 arch/riscv/lib/strlen.S               |  4 ++--
 arch/riscv/lib/strncmp.S              |  4 ++--
 8 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e927b52b420c..f216a52ed181 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -605,14 +605,23 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
 	def_bool $(as-instr, .option arch$(comma) +v$(comma) +zvkb)
 	depends on AS_HAS_OPTION_ARCH
 
-config RISCV_ISA_ZBB
-	bool "Zbb extension support for bit manipulation instructions"
+config RISCV_ISA_ZBB_ALT
+	def_bool RISCV_ISA_ZBB
 	depends on TOOLCHAIN_HAS_ZBB
 	depends on RISCV_ALTERNATIVE
+	help
+	  This option controls whether or not we build optimisations that
+	  depend on toolchain support. It's automatically enabled whenever the
+	  toolchain in use supports assembling Zbb instructions and
+	  RISCV_ISA_ZBB is set.
+
+config RISCV_ISA_ZBB
+	bool "Zbb extension support for bit manipulation instructions"
 	default y
 	help
 	   Add support for enabling optimisations in the kernel when the
-	   Zbb extension is detected at boot.
+	   Zbb extension is detected at boot. Some optimisations may
+	   additionally depend on toolchain support for Zbb.
 
 	   The Zbb extension provides instructions to accelerate a number
 	   of bit-specific operations (count bit population, sign extending,
diff --git a/arch/riscv/include/asm/arch_hweight.h b/arch/riscv/include/asm/arch_hweight.h
index 85b2c443823e..a677f6b82228 100644
--- a/arch/riscv/include/asm/arch_hweight.h
+++ b/arch/riscv/include/asm/arch_hweight.h
@@ -19,7 +19,7 @@
 
 static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
-#ifdef CONFIG_RISCV_ISA_ZBB
+#ifdef CONFIG_RISCV_ISA_ZBB_ALT
 	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 				      RISCV_ISA_EXT_ZBB, 1)
 			  : : : : legacy);
@@ -50,7 +50,7 @@ static inline unsigned int __arch_hweight8(unsigned int w)
 #if BITS_PER_LONG == 64
 static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
-# ifdef CONFIG_RISCV_ISA_ZBB
+# ifdef CONFIG_RISCV_ISA_ZBB_ALT
 	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 				      RISCV_ISA_EXT_ZBB, 1)
 			  : : : : legacy);
diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index 880606b0469a..3ed810a6123d 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -15,7 +15,7 @@
 #include <asm/barrier.h>
 #include <asm/bitsperlong.h>
 
-#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
+#if !defined(CONFIG_RISCV_ISA_ZBB_ALT) || defined(NO_ALTERNATIVE)
 #include <asm-generic/bitops/__ffs.h>
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/ffs.h>
@@ -175,7 +175,7 @@ static __always_inline int variable_fls(unsigned int x)
 	 variable_fls(x_);					\
 })
 
-#endif /* !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE) */
+#endif /* !defined(CONFIG_RISCV_ISA_ZBB_ALT) || defined(NO_ALTERNATIVE) */
 
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/fls64.h>
diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
index 88e6f1499e88..956224ea8199 100644
--- a/arch/riscv/include/asm/checksum.h
+++ b/arch/riscv/include/asm/checksum.h
@@ -49,8 +49,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
 	 * worth checking if supported without Alternatives.
 	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
-	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT)) {
 		unsigned long fold_temp;
 
 		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index 7fb12c59e571..7a97394c252b 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -44,8 +44,7 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	 * Zbb support saves 4 instructions, so not worth checking without
 	 * alternatives if supported
 	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
-	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT)) {
 		unsigned long fold_temp;
 
 		/*
@@ -161,8 +160,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 	 * Zbb support saves 6 instructions, so not worth checking without
 	 * alternatives if supported
 	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
-	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT)) {
 		unsigned long fold_temp;
 
 		/*
@@ -248,8 +246,7 @@ do_csum_no_alignment(const unsigned char *buff, int len)
 	 * Zbb support saves 6 instructions, so not worth checking without
 	 * alternatives if supported
 	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
-	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT)) {
 		unsigned long fold_temp;
 
 		/*
diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
index 687b2bea5c43..a4dd2ac306f1 100644
--- a/arch/riscv/lib/strcmp.S
+++ b/arch/riscv/lib/strcmp.S
@@ -8,7 +8,7 @@
 /* int strcmp(const char *cs, const char *ct) */
 SYM_FUNC_START(strcmp)
 
-	ALTERNATIVE("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
+	ALTERNATIVE("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB_ALT)
 
 	/*
 	 * Returns
@@ -43,7 +43,7 @@ SYM_FUNC_START(strcmp)
  * The code was published as part of the bitmanip manual
  * in Appendix A.
  */
-#ifdef CONFIG_RISCV_ISA_ZBB
+#ifdef CONFIG_RISCV_ISA_ZBB_ALT
 strcmp_zbb:
 
 .option push
diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
index 8ae3064e45ff..3ab1310a7b83 100644
--- a/arch/riscv/lib/strlen.S
+++ b/arch/riscv/lib/strlen.S
@@ -8,7 +8,7 @@
 /* int strlen(const char *s) */
 SYM_FUNC_START(strlen)
 
-	ALTERNATIVE("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
+	ALTERNATIVE("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB_ALT)
 
 	/*
 	 * Returns
@@ -33,7 +33,7 @@ SYM_FUNC_START(strlen)
 /*
  * Variant of strlen using the ZBB extension if available
  */
-#ifdef CONFIG_RISCV_ISA_ZBB
+#ifdef CONFIG_RISCV_ISA_ZBB_ALT
 strlen_zbb:
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
index aba5b3148621..aeed830804d7 100644
--- a/arch/riscv/lib/strncmp.S
+++ b/arch/riscv/lib/strncmp.S
@@ -8,7 +8,7 @@
 /* int strncmp(const char *cs, const char *ct, size_t count) */
 SYM_FUNC_START(strncmp)
 
-	ALTERNATIVE("nop", "j strncmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
+	ALTERNATIVE("nop", "j strncmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB_ALT)
 
 	/*
 	 * Returns
@@ -46,7 +46,7 @@ SYM_FUNC_START(strncmp)
 /*
  * Variant of strncmp using the ZBB extension if available
  */
-#ifdef CONFIG_RISCV_ISA_ZBB
+#ifdef CONFIG_RISCV_ISA_ZBB_ALT
 strncmp_zbb:
 
 .option push
-- 
2.43.0


