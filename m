Return-Path: <linux-kernel+bounces-347921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829C698E07C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65290B2E1CE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5011D0F5A;
	Wed,  2 Oct 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrXVaB5C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291531940B0;
	Wed,  2 Oct 2024 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885519; cv=none; b=PrlSzcUauGBQSynnbianiIKJwhjrqicw1i++IPdkLMTMD5Tq4X7qEieFB5RwMbnD92Wzak/CzbYkPGsjs1Cr89gO7v3uhtXa59lODhgOAzl93/Uk1I2qkIuRe4M40vAAJ9bTYqYM3ai0wFbWL810gj4KZzldh1xkYLPJMDJYtkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885519; c=relaxed/simple;
	bh=2V7RQodDQlu18TItxPVAqFSEQ7zomNY1W4Cl2ro6hcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujsBwvOc+eorN/i8gXE1SNBNVlmH1eXpM1ZyeThixyjhMSLYb5w1Bxh9336hdstrWb0sRYlSFVWiBp2QBg4UFGHPpUqaHb+H6QGN8eR02wAPrdAiwj20WusLE9E5cvyecQXlS0r4bHlYlSFRmFc7h/6ih4Du4oiSMGbBEpo9X8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrXVaB5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870DFC4CEC2;
	Wed,  2 Oct 2024 16:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727885518;
	bh=2V7RQodDQlu18TItxPVAqFSEQ7zomNY1W4Cl2ro6hcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XrXVaB5CED/nhYA5Q/3Og8em4VXoI/axEVQ0pCdADT0T6RWOvU5KyDnLLxxTar0t0
	 QVp/upr2xZWCUA6xy783qWnyt61/MZtyGkwGqrlAgkJNsQ0A5AYeXuldH41EZvH3fH
	 pWTC2a+NvLEZw447rCewKckVfvseLZ3WEYuZ269QrFcJ1q2pGSEUCAGsLUK8jTrwUY
	 nt0dIGWOdifuiveeF8chOd8HZj/HUjwXiWR0LwEMlhnOogqsTo+Gew4DM6knHcDl9t
	 IuahGUXbfHaGe0r/uG1bPmhGHJFzE9A2IEZ5Cqose4cZ2xR7yRpV11zX0yEa4Rc3Wz
	 +iQ3KBNCgoBBw==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC v1 1/5] RISC-V: add vector crypto extension validation checks
Date: Wed,  2 Oct 2024 17:10:54 +0100
Message-ID: <20241002-utensil-ought-744ce828d19c@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002-defeat-pavestone-73d712895f0b@spud>
References: <20241002-defeat-pavestone-73d712895f0b@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10624; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Rlx86YTL8DYCeziwBL4DaUepyEPqXhOxmfx2dG/JjxY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl/C/oDJle7N5w0Yp3xuWDxnPQwG37ea5t/cbdW1U24s 8Ex/Vt8RykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACayio2R4UVPmJb+p+7QtKQ5 z9cqLDE/8NQrtnuiMsvSLT5rQt6wJzD8Dzq07G+B9OO8za+aLmqf0d/pN1P4c4DPEuH1L5iZzy7 fxgoA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Using Clement's new validation callbacks, support checking that
dependencies have been satisfied for the vector crpyto extensions.
Currently riscv_isa_extension_available(<vector crypto>) will return
true on systems that support the extensions but vector itself has been
disabled by the kernel, adding validation callbacks will prevent such a
scenario from occuring and make the behaviour of the extension detection
functions more consistent with user expectations - it's not expected to
have to check for vector AND the specific crypto extension.

The 1.0.0 Vector crypto spec states:
	The Zvknhb and Zvbc Vector Crypto Extensions --and accordingly
	the composite extensions Zvkn and Zvks-- require a Zve64x base,
	or application ("V") base Vector Extension. All of the other
	Vector Crypto Extensions can be built on any embedded (Zve*) or
	application ("V") base Vector Extension.
and this could be used as the basis for checking that the correct base
for individual crypto extensions, but that's not really the kernel's job
in my opinion and it is sufficient to leave that sort of precision to
the dt-bindings. The kernel only needs to make sure that vector, in some
form, is available.

Since vector will now be disabled proactively, there's no need to clear
the bit in elf_hwcap in riscv_fill_hwcap() any longer.

Link: https://github.com/riscv/riscv-crypto/releases/tag/v1.0.0
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/cpufeature.h |   3 +
 arch/riscv/kernel/cpufeature.c      | 111 ++++++++++++++++++----------
 2 files changed, 76 insertions(+), 38 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 45f9c1171a486..1de408c3deee7 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -51,6 +51,9 @@ void riscv_user_isa_enable(void);
 #define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
 	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, \
 			    ARRAY_SIZE(_bundled_exts), NULL)
+#define __RISCV_ISA_EXT_BUNDLE_VALIDATE(_name, _bundled_exts, _validate) \
+	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, \
+			    ARRAY_SIZE(_bundled_exts), _validate)
 
 /* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
 #define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 8f20607adb406..84a2ad2581cb0 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -101,6 +101,53 @@ static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
 	return 0;
 }
 
+static int riscv_ext_vector_x_validate(const struct riscv_isa_ext_data *data,
+				     const unsigned long *isa_bitmap)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_V))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int riscv_ext_vector_float_validate(const struct riscv_isa_ext_data *data,
+					   const unsigned long *isa_bitmap)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_V))
+		return -EINVAL;
+
+	if (IS_ENABLED(CONFIG_FPU))
+		return -EINVAL;
+
+	/*
+	 * The kernel doesn't support systems that don't implement both of
+	 * F and D, so if any of the vector extensions that do floating point
+	 * are to be usable, both floating point extensions need to be usable.
+	 */
+	if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int riscv_ext_vector_crypto_validate(const struct riscv_isa_ext_data *data,
+					    const unsigned long *isa_bitmap)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_V))
+		return -EINVAL;
+
+	/*
+	 * It isn't the kernel's job to check that the binding is correct, so
+	 * it should be enough to check that any of the vector extensions are
+	 * enabled, which in-turn means that vector is usable in this kernel
+	 */
+	//TODO check that enough resolve rounds exist to make this work
+	if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZVE32X))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int riscv_ext_zca_depends(const struct riscv_isa_ext_data *data,
 				 const unsigned long *isa_bitmap)
 {
@@ -308,12 +355,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
 	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
 	__RISCV_ISA_EXT_SUPERSET(c, RISCV_ISA_EXT_c, riscv_c_exts),
-	__RISCV_ISA_EXT_SUPERSET(v, RISCV_ISA_EXT_v, riscv_v_exts),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(v, RISCV_ISA_EXT_v, riscv_v_exts, riscv_ext_vector_float_validate),
 	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
-	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts,
-					  riscv_ext_zicbom_validate),
-	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
-					  riscv_ext_zicboz_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts, riscv_ext_zicbom_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts, riscv_ext_zicboz_validate),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
@@ -339,40 +384,40 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
 	__RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
 	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
-	__RISCV_ISA_EXT_BUNDLE(zk, riscv_zk_bundled_exts),
-	__RISCV_ISA_EXT_BUNDLE(zkn, riscv_zkn_bundled_exts),
+	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zk, riscv_zk_bundled_exts, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zkn, riscv_zkn_bundled_exts, riscv_ext_vector_crypto_validate),
 	__RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
 	__RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
 	__RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
 	__RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
-	__RISCV_ISA_EXT_BUNDLE(zks, riscv_zks_bundled_exts),
+	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zks, riscv_zks_bundled_exts, riscv_ext_vector_crypto_validate),
 	__RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
 	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
 	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
 	__RISCV_ISA_EXT_DATA(ztso, RISCV_ISA_EXT_ZTSO),
 	__RISCV_ISA_EXT_SUPERSET(zvbb, RISCV_ISA_EXT_ZVBB, riscv_zvbb_exts),
-	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
-	__RISCV_ISA_EXT_SUPERSET(zve32f, RISCV_ISA_EXT_ZVE32F, riscv_zve32f_exts),
-	__RISCV_ISA_EXT_DATA(zve32x, RISCV_ISA_EXT_ZVE32X),
-	__RISCV_ISA_EXT_SUPERSET(zve64d, RISCV_ISA_EXT_ZVE64D, riscv_zve64d_exts),
-	__RISCV_ISA_EXT_SUPERSET(zve64f, RISCV_ISA_EXT_ZVE64F, riscv_zve64f_exts),
-	__RISCV_ISA_EXT_SUPERSET(zve64x, RISCV_ISA_EXT_ZVE64X, riscv_zve64x_exts),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zvbc, RISCV_ISA_EXT_ZVBC, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zve32f, RISCV_ISA_EXT_ZVE32F, riscv_zve32f_exts, riscv_ext_vector_float_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zve32x, RISCV_ISA_EXT_ZVE32X, riscv_ext_vector_x_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zve64d, RISCV_ISA_EXT_ZVE64D, riscv_zve64d_exts, riscv_ext_vector_float_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zve64f, RISCV_ISA_EXT_ZVE64F, riscv_zve64f_exts, riscv_ext_vector_float_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zve64x, RISCV_ISA_EXT_ZVE64X, riscv_zve64x_exts, riscv_ext_vector_x_validate),
 	__RISCV_ISA_EXT_DATA(zvfh, RISCV_ISA_EXT_ZVFH),
 	__RISCV_ISA_EXT_DATA(zvfhmin, RISCV_ISA_EXT_ZVFHMIN),
-	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
-	__RISCV_ISA_EXT_DATA(zvkg, RISCV_ISA_EXT_ZVKG),
-	__RISCV_ISA_EXT_BUNDLE(zvkn, riscv_zvkn_bundled_exts),
-	__RISCV_ISA_EXT_BUNDLE(zvknc, riscv_zvknc_bundled_exts),
-	__RISCV_ISA_EXT_DATA(zvkned, RISCV_ISA_EXT_ZVKNED),
-	__RISCV_ISA_EXT_BUNDLE(zvkng, riscv_zvkng_bundled_exts),
-	__RISCV_ISA_EXT_DATA(zvknha, RISCV_ISA_EXT_ZVKNHA),
-	__RISCV_ISA_EXT_DATA(zvknhb, RISCV_ISA_EXT_ZVKNHB),
-	__RISCV_ISA_EXT_BUNDLE(zvks, riscv_zvks_bundled_exts),
-	__RISCV_ISA_EXT_BUNDLE(zvksc, riscv_zvksc_bundled_exts),
-	__RISCV_ISA_EXT_DATA(zvksed, RISCV_ISA_EXT_ZVKSED),
-	__RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
-	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
-	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zvkb, RISCV_ISA_EXT_ZVKB, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zvkg, RISCV_ISA_EXT_ZVKG, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zvkn, riscv_zvkn_bundled_exts, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zvknc, riscv_zvknc_bundled_exts, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zvkned, RISCV_ISA_EXT_ZVKNED, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zvkng, riscv_zvkng_bundled_exts, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zvknha, RISCV_ISA_EXT_ZVKNHA, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zvknhb, RISCV_ISA_EXT_ZVKNHB, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zvks, riscv_zvks_bundled_exts, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zvksc, riscv_zvksc_bundled_exts, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zvksed, RISCV_ISA_EXT_ZVKSED, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zvksh, RISCV_ISA_EXT_ZVKSH, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zvksg, riscv_zvksg_bundled_exts, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zvkt, RISCV_ISA_EXT_ZVKT, riscv_ext_vector_crypto_validate),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
@@ -883,16 +928,6 @@ void __init riscv_fill_hwcap(void)
 		riscv_v_setup_vsize();
 	}
 
-	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
-		/*
-		 * ISA string in device tree might have 'v' flag, but
-		 * CONFIG_RISCV_ISA_V is disabled in kernel.
-		 * Clear V flag in elf_hwcap if CONFIG_RISCV_ISA_V is disabled.
-		 */
-		if (!IS_ENABLED(CONFIG_RISCV_ISA_V))
-			elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
-	}
-
 	memset(print_str, 0, sizeof(print_str));
 	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
 		if (riscv_isa[0] & BIT_MASK(i))
-- 
2.45.2


