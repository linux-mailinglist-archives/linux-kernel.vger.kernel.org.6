Return-Path: <linux-kernel+bounces-347922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3723498E04A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AD7284F47
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B6B1D12E5;
	Wed,  2 Oct 2024 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2+ayXHh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11801D0E1F;
	Wed,  2 Oct 2024 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885524; cv=none; b=Adf1utmbmnnhrkBaA0ueqyuo25tZW/l+/kZXEOStY+Jl/2SWQ31GArn5ymdTLCzxKrIMoeEn/AYZW5OcuYhHj3FvPuDxMD3ceqfmIA4SQv7YlH6OgrciQ0WVCkpIA8eb/vLtN+Has04nDGtNR7nFRmFjdCOZq8LZYMQ5Y8aBvy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885524; c=relaxed/simple;
	bh=mCRekBHgNwFBX1KL6AOZHvr9N4tmriuM/RvTA6+DVm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0pLlZyr2dI7wLiJTXSHL0UKvBe/PQrE3k/uMjq8Ej3p1aQEd2cJpaYKBrSHA9GOkR6XrfQlkjLhYZ/3DI8+n5QYecx3DuUoIq1BPQu5U61iyG2qkwi3kwv3q/0saWDzMWGUo67lIZXphjR5k1sg3TNmuoiaKgtQc+fT4Mu0oak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2+ayXHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83E8C4CECD;
	Wed,  2 Oct 2024 16:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727885524;
	bh=mCRekBHgNwFBX1KL6AOZHvr9N4tmriuM/RvTA6+DVm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2+ayXHhUHPTjpTt4zczWxCqmEwZRf0lUqAhCKLgTv1C+CV+x5ZC4iHkqVY57zvb1
	 56su9G7BVXOlnkE5Pja9an0r74+kM/pXmKK4WaHNQCPAz+Fmn6Vs431gBlfmRecWti
	 0SxdL2k/acijFAKrRPctzPMvRon4hLuik0YEn2UxLWaqQuByCFpYHCiPCTJBmHL1Y+
	 4u0YDRLBgDkO9CRMryfxb5mWrt9k/DNLsRoO8D+NOiZItjO2v2CsmpaKP32RH8qBWT
	 sjnZryNz41EOCsOl+n8cTBdDD9Q3B1Vav1iqrsnDIAK9USZJLr50hgyHBI2uEoumWq
	 1iV8G+kKgIHTA==
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
Subject: [RFC v1 2/5] RISC-V: add f & d extension validation checks
Date: Wed,  2 Oct 2024 17:10:55 +0100
Message-ID: <20241002-stuffed-trance-1323386dd80b@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002-defeat-pavestone-73d712895f0b@spud>
References: <20241002-defeat-pavestone-73d712895f0b@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2979; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=xf019LNZCscq0WBMmHr1I5lt/oOvG/GepcaYsq7GDK8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl/C/rF/wSseBJ8bplFDMueWds53hmbbDvbfkr7ofC/0 6xSug+LOkpZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRyz8ZGSYKK63+uab/k2ft rYlFF9Ms/t11XNMck/63fWFOz7aWUFuG/6WhgqGFXKeWnNW4dTPpbtnONzvev91wZlZYn+2hRe5 nsvgA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Using Clement's new validation callbacks, support checking that
dependencies have been satisfied for the floating point extensions.

The check for "d" might be slightly confusingly shorter than that of "f",
despite "d" depending on "f". This is because the requirement that a
hart supporting double precision must also support single precision,
should be validated by dt-bindings etc, not the kernel but lack of
support for single precision only is a limitation of the kernel.

Since vector will now be disabled proactively, there's no need to clear
the bit in elf_hwcap in riscv_fill_hwcap() any longer.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/cpufeature.c | 36 +++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 84a2ad2581cb0..b8a22ee76c2ef 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -101,6 +101,29 @@ static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
 	return 0;
 }
 
+static int riscv_ext_f_validate(const struct riscv_isa_ext_data *data,
+				const unsigned long *isa_bitmap)
+{
+	if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d)) {
+		pr_warn_once("This kernel does not support systems with F but not D\n");
+		return -EINVAL;
+	}
+
+	if (IS_ENABLED(CONFIG_FPU))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int riscv_ext_d_validate(const struct riscv_isa_ext_data *data,
+				const unsigned long *isa_bitmap)
+{
+	if (IS_ENABLED(CONFIG_FPU))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int riscv_ext_vector_x_validate(const struct riscv_isa_ext_data *data,
 				     const unsigned long *isa_bitmap)
 {
@@ -351,8 +374,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(i, RISCV_ISA_EXT_i),
 	__RISCV_ISA_EXT_DATA(m, RISCV_ISA_EXT_m),
 	__RISCV_ISA_EXT_DATA(a, RISCV_ISA_EXT_a),
-	__RISCV_ISA_EXT_DATA(f, RISCV_ISA_EXT_f),
-	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
+	__RISCV_ISA_EXT_DATA_VALIDATE(f, RISCV_ISA_EXT_f, riscv_ext_f_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(d, RISCV_ISA_EXT_d, riscv_ext_d_validate),
 	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
 	__RISCV_ISA_EXT_SUPERSET(c, RISCV_ISA_EXT_c, riscv_c_exts),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(v, RISCV_ISA_EXT_v, riscv_v_exts, riscv_ext_vector_float_validate),
@@ -912,15 +935,6 @@ void __init riscv_fill_hwcap(void)
 		}
 	}
 
-	/*
-	 * We don't support systems with F but without D, so mask those out
-	 * here.
-	 */
-	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
-		pr_info("This kernel does not support systems with F but not D\n");
-		elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
-	}
-
 	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_ZVE32X)) {
 		/*
 		 * This cannot fail when called on the boot hart
-- 
2.45.2


