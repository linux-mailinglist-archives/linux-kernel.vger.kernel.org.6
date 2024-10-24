Return-Path: <linux-kernel+bounces-379858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7641F9AE4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A549B1C23854
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C631D9A49;
	Thu, 24 Oct 2024 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJptutNj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782B71D968E;
	Thu, 24 Oct 2024 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773282; cv=none; b=IdtOPQq6opmKwN+TPVzn4RY/J9usaYUMukgqI0+ndxdi56bgEY5DUOBLGGJjYZsRIzwGa956qyGzaUhjIAumj5qrTf3qrTaH+kzsSu7/Nn8KaUMOsgQRwGjf8gRS+g2o4NorX1+hCaXZj9JHNNCrMBr3TJL3VXbNDeXsJKe/T2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773282; c=relaxed/simple;
	bh=wSLCfX8wndX+rlS9G+CmOUl2Cwte9stfmakvhsfLyUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gf8YXSip+oSHgw0/+bS5pYO9fvHUYlK/Txj/ZYo0QZBKJ0dByyMLYtyge9tt2kZRxv85HX1NynBBM1J1iAXWSe5NDWPECe+xRbNju+2c9k5LutkBdhIvgvI/mjHOBHtNMzE+/WF2rUTr+CMq4MkB9BWWrKco7lpIfEsgUlnaR48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJptutNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0377C4CECC;
	Thu, 24 Oct 2024 12:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729773282;
	bh=wSLCfX8wndX+rlS9G+CmOUl2Cwte9stfmakvhsfLyUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJptutNj5MijtBI9tMs3A1CwAXFGnS8Xtq7G5VnIKvaBVZDYSyyo2PBRt6smOgNwP
	 1RcfX/Kmt8V2Nn/jpLk3AKIqsMB5XelikZMqVSwAcJlCEroRR3M+8jMODx6T62/cLc
	 DVFW5KTylQDIS29154ZuSUYCC/JVORfVJT7VvQg7s/G5VT6DRPK9M2TXxNJ7PvteF4
	 sN2BpJ89g6xCjKw2d52dprCAKOmAQS/ggUyMsNmKTLzKwRZqnXiBBmDXU20/bMm780
	 MVu4xpa7ZZfEzwE8r7rOQEk7M08YoLhcCl53/Hs0VeDOoTvqNVB6JcGKaL1hQkrHDv
	 JXxx5eYtZdqyw==
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
Subject: [PATCH v2 2/5] RISC-V: add f & d extension validation checks
Date: Thu, 24 Oct 2024 13:34:30 +0100
Message-ID: <20241024-only-crepe-64267d0eebe1@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024-fanning-enrage-bcc39f8ed47d@spud>
References: <20241024-fanning-enrage-bcc39f8ed47d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2981; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=UvTI7yQ4XDO7pBfMOp39hyEWkU6sqFWGVmdNeuF8vEc=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOlSdldvG/5Z/lq47UnO8or4cNXwyGtqPHNaZoXnf9iUN n21otXbjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExkXxrDHw537uJ5H1jc//9k utO/bov9ceNitVvn7u2p41zyo61HL5Dhf5WNs8AxESdemY+rLqkJim26lJqhqnVA7OiOq18V7/1 fwgUA
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
index 020b19edee2e8..1326049d2ac3b 100644
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
+	if (!IS_ENABLED(CONFIG_FPU))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int riscv_ext_d_validate(const struct riscv_isa_ext_data *data,
+				const unsigned long *isa_bitmap)
+{
+	if (!IS_ENABLED(CONFIG_FPU))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int riscv_ext_vector_x_validate(const struct riscv_isa_ext_data *data,
 				     const unsigned long *isa_bitmap)
 {
@@ -350,8 +373,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
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
@@ -910,15 +933,6 @@ void __init riscv_fill_hwcap(void)
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


