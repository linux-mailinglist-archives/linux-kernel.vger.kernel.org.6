Return-Path: <linux-kernel+bounces-557776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF89A5DD84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18F51899996
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247E524889A;
	Wed, 12 Mar 2025 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkiDmvnq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A4D2475C7;
	Wed, 12 Mar 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785158; cv=none; b=Sf++50vFBiCM2Q+qvXViT3AoR/vn1XOrfSJdr2g4Ae67QvDVJsNvPktR7Re9c87FPTfdBvcPdCxym+DMfDKz08/05SEB3+zVbwQ70x60GKUrTwe4Urkokbp+QWdGxfgxHDSAaDfo1+CT3j8ehhGnpSvQ0I7m8Jn/Vp/hep1SlkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785158; c=relaxed/simple;
	bh=xkOp2BaIgw0BM3o1uELdVRZMOl4451Gr2m0DRPMGLxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzgjX1Gd2Q9g1tlQSVt4mFW7cjbf1BqwoUTvVSf5o4sFhYOzHn+Q6tUWQpWdOMbpPC6k0Ccd8iVYDq0MbM+F5HOMdSU2v5Rhu9eUxry/Nxdrn8BPlu/yxgMCvZTN+ULwcIH2oQpylW6BSYSBM5jJDMxJIl6Qu6CmOR/6wraUDHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkiDmvnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34F7C4CEEC;
	Wed, 12 Mar 2025 13:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741785158;
	bh=xkOp2BaIgw0BM3o1uELdVRZMOl4451Gr2m0DRPMGLxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OkiDmvnqnTuOBnS+MAXFe1bqeQbq4IsCwOOXNv1kpxFpYbu5vRUTNMI0A8Y39tpmE
	 wJLU+fGnQ7rqtQTlpIQjhZagJuMLEONluVyoaXtTVst2ZHdFQ9hjGWtfbzdLYUzkUj
	 /sZp4ALR78NuHGGD3A3k8NtDK4MGpON7VbcKkaxLw1oIrFcZkMUsOtfyOhw7el+pOz
	 byG3g0mpzm4DtXA5Ca/kCLShOamtQHu86lzqEXO0vTroIYN2DU7aEY6TvipiAXlB8s
	 V1VnKF5gSBhPXIghwaFmUTab9SkG4tCZ7F/zfGfUo4eGc/sFzqydty5mVyg0HtR4HF
	 gO7GyhIpNMieA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] RISC-V: add vector crypto extension validation checks
Date: Wed, 12 Mar 2025 13:11:45 +0000
Message-ID: <20250312-entertain-shaking-b664142c2f99@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250312-abide-pancreas-3576b8c44d2c@spud>
References: <20250312-abide-pancreas-3576b8c44d2c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6063; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=tR4ZBY/tPFJNw/u11KBQNT7sDrigssjsfjm1n/+8umY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOkXO4QfZq6Zf73/W652Te/6jeGh513/6+Rsjdu4du7k2 Hp+5x0ZHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhIbCbDP7Vpq6y2qXg+mZmV uUmy9myPmeL+Ou00F7G2qkOhr3WerWX4Kzxr6+f/F+45aR/8tN7sZMnHKtHmG2qHt7x5W9Yi9fP MRwYA
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

The Unpriv spec states:
| The Zvknhb and Zvbc Vector Crypto Extensions --and accordingly the
| composite extensions Zvkn, Zvknc, Zvkng, and Zvksc-- require a Zve64x
| base, or application ("V") base Vector Extension. All of the other
| Vector Crypto Extensions can be built on any embedded (Zve*) or
| application ("V") base Vector Extension.

While this could be used as the basis for checking that the correct base
for individual crypto extensions, but that's not really the kernel's job
in my opinion and it is sufficient to leave that sort of precision to
the dt-bindings. The kernel only needs to make sure that vector, in some
form, is available.

Link: https://github.com/riscv/riscv-isa-manual/blob/main/src/vector-crypto.adoc#extensions-overview
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/cpufeature.c | 49 +++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index dbea6ed3f4da..4fa951e9f1cf 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -141,6 +141,23 @@ static int riscv_ext_vector_float_validate(const struct riscv_isa_ext_data *data
 	return 0;
 }
 
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
+	if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZVE32X))
+		return -EPROBE_DEFER;
+
+	return 0;
+}
+
 static int riscv_ext_zca_depends(const struct riscv_isa_ext_data *data,
 				 const unsigned long *isa_bitmap)
 {
@@ -400,8 +417,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
 	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
 	__RISCV_ISA_EXT_DATA(ztso, RISCV_ISA_EXT_ZTSO),
-	__RISCV_ISA_EXT_SUPERSET(zvbb, RISCV_ISA_EXT_ZVBB, riscv_zvbb_exts),
-	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zvbb, RISCV_ISA_EXT_ZVBB, riscv_zvbb_exts, riscv_ext_vector_crypto_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zvbc, RISCV_ISA_EXT_ZVBC, riscv_ext_vector_crypto_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zve32f, RISCV_ISA_EXT_ZVE32F, riscv_zve32f_exts, riscv_ext_vector_float_validate),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zve32x, RISCV_ISA_EXT_ZVE32X, riscv_ext_vector_x_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zve64d, RISCV_ISA_EXT_ZVE64D, riscv_zve64d_exts, riscv_ext_vector_float_validate),
@@ -409,20 +426,20 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zve64x, RISCV_ISA_EXT_ZVE64X, riscv_zve64x_exts, riscv_ext_vector_x_validate),
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
 	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
 	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
-- 
2.45.2


