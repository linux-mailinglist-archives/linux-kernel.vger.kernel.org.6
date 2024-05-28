Return-Path: <linux-kernel+bounces-192153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D1B8D1929
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473882886E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED45116C682;
	Tue, 28 May 2024 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LANNEXZ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646C16C457
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716894688; cv=none; b=ca6nHqs/GI7YswdWFhSWzuKOem7pDPwUI1WLMcc42+Bg0BZ8EWp77NwWxsoOIw1TF6t74vOTQS+6701elmm+sLdz7WlC12eSV4aMF4CmHygvEU9xMWjCTGmHIzUMnTs0NTSVl4DS6UJZ5rMdpU43dQ6px0cwoloUhhLDXHXgaa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716894688; c=relaxed/simple;
	bh=Lew/GJirKVQbNgT/9lPrUyM7EIKflfRQ9AxvZBFWPnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+o3kfz7bmAmP9lSlymTYrz32pkNC0wCuTQ1EjeuP0ZUVQpnzoGOH7Xkm66OjBIIeBYw6PUP7nNRpC0xjhR5mQ18FBEx3QYfy9Afi4bhrP3d/oAr5xDplGKeLzXF4HTBHvuoeEG8lIPCQMUFAxY4aS4LRNbe7pB3/Ha/tiXBUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LANNEXZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE77C32782;
	Tue, 28 May 2024 11:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716894687;
	bh=Lew/GJirKVQbNgT/9lPrUyM7EIKflfRQ9AxvZBFWPnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LANNEXZ7aUsYYWjUrQr2uHL/XRNPWZ/LWpPgntHHP4Q6cdBkWWcMbnWINSdhrr7uM
	 x+I983sWtQSPh3BJ48ib6KPW0FwjNC0LzUFcliU8KO/HPtQhr1ldoSoEmPsPplOz4u
	 xiF8/oD8JxUmC5veg/14QqoliEdm4ID8OzIBgTe9UCc+cmRPy0Api6xKmG6hlq56by
	 Zm8Jh7bsyu2+jEzp5QOjrZyuNFV9mf2duShRA1KS8iww+cRHKSQIbmqkETezunLMyq
	 ZIfBjiorC6Dm2l7dtVgCEuME2DBpifzCmYmTOeNsPd6LMOjLxVMeyGvG6kpjAbVGYR
	 d3gnI8exHjobQ==
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
Subject: [PATCH v3 2/2] RISC-V: separate Zbb optimisations requiring and not requiring toolchain support
Date: Tue, 28 May 2024 12:11:12 +0100
Message-ID: <20240528-opossum-flavorful-3411811b87e2@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528-applaud-violin-facef8d9d846@spud>
References: <20240528-applaud-violin-facef8d9d846@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8645; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=H/d6fdfeBMe9MAi4ZkmXDzXqLDI7KeHtYyBfqezcFjg=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmhuy+UWcxm8Tt92aJj8z1D49LFKt4Wof0BKaI20Sx1h Rkb1X50lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCKb7zD8dzaWSTF98pFv/ee+ 85+yp5yY+v/+8x0Zru7sC7Xycp0e5jH8ldptGcO8Seska7qq5TedQyrBkTbVcyRuW23eeIRBfMp SHgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

It seems a bit ridiculous to require toolchain support for BPF to
assemble Zbb instructions, so move the dependency on toolchain support
for Zbb optimisations out of the Kconfig option and to the callsites.

Zbb support has always depended on alternatives, so while adjusting the
config options guarding optimisations, remove any checks for
whether or not alternatives are enabled.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v2/v3:
- Per Drew's suggestion, drop the stub Kconfig option and instead push
  out the toolchain dependency to the relevant callsites.
- Delete a bunch of comments about only attempting Zbb if alternatives
  are available, since they always are.
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
index 3b702e6cc051..a91c53b096e8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -613,12 +613,12 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
 
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
index 85b2c443823e..b94db541901a 100644
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
index 880606b0469a..6966d00c3a8a 100644
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
index 88e6f1499e88..da378856f1d5 100644
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
index 7fb12c59e571..9408f50ca59a 100644
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
index 687b2bea5c43..204fb1c184f3 100644
--- a/arch/riscv/lib/strcmp.S
+++ b/arch/riscv/lib/strcmp.S
@@ -8,7 +8,8 @@
 /* int strcmp(const char *cs, const char *ct) */
 SYM_FUNC_START(strcmp)
 
-	ALTERNATIVE("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
+	__ALTERNATIVE_CFG("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB,
+		IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB))
 
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
index 8ae3064e45ff..84909807d988 100644
--- a/arch/riscv/lib/strlen.S
+++ b/arch/riscv/lib/strlen.S
@@ -8,7 +8,8 @@
 /* int strlen(const char *s) */
 SYM_FUNC_START(strlen)
 
-	ALTERNATIVE("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
+	__ALTERNATIVE_CFG("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB,
+		IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB))
 
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
index aba5b3148621..87e7c83c1672 100644
--- a/arch/riscv/lib/strncmp.S
+++ b/arch/riscv/lib/strncmp.S
@@ -8,7 +8,8 @@
 /* int strncmp(const char *cs, const char *ct, size_t count) */
 SYM_FUNC_START(strncmp)
 
-	ALTERNATIVE("nop", "j strncmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
+	__ALTERNATIVE_CFG("nop", "j strncmp_zbb", 0, RISCV_ISA_EXT_ZBB,
+		IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB))
 
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
2.43.0


