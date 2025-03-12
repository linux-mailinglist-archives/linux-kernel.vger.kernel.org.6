Return-Path: <linux-kernel+bounces-557777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E39FDA5DD8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D231636C1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7CC24501D;
	Wed, 12 Mar 2025 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/7U7xrO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E93E24A069;
	Wed, 12 Mar 2025 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785161; cv=none; b=VUKd62EZoe9scNph2GD1oUCaZVY5lYSJMUGfSyjtp+D+e/JS9WI/ZikgXFFBXVV9eOMgyedGWD1vOZxrzqIeiTAn7jPSemoriWL84qvNMzHZkfHYBztMyfeXCZrI/xrQldSNxzk53aQ7fgelabe9oMKJ+cn1x1hOurV+IXj12RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785161; c=relaxed/simple;
	bh=HIf+aPICbUrXbjs2m8V10w71t0JwLVu4gn/Zh9Vui6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXUlmTvn3hGJkribHt6HAK2+DXmt6um4VKQSlo0ka7h2LYMXpAJN8iRzWlyVks27AS7EKsgag3dAYsTqMmFAzXoNtLyeXpIpTPC7GxR+/uvMpnj92MgheqFZ8y4oJzNDNfz7L1dnkYvis5vugPEeHY+ChxRhNZg9OB7NBl5hmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/7U7xrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8A3C4CEE3;
	Wed, 12 Mar 2025 13:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741785161;
	bh=HIf+aPICbUrXbjs2m8V10w71t0JwLVu4gn/Zh9Vui6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/7U7xrO8SKIhGKp0vrJKwgKaMM3jhDpRWOoJb1UhpNTgsMm0yB0GXpvskk6IyaOZ
	 UFeBgwll87+nxaeu0tuVnGgdujgT/eMsEX4BBOlAAl1/uWRTCQiBMxa7+jC2tLmscs
	 muqY5FWrg5z6JUVmdS1FdgODyPaKISB0hIAYlKoqvUNdwPUU3PWm9t2qtOYah8YCXM
	 vBb0DEB60YbY5B8htZ123AarHOyEr1EaedPrLu3NzJm+q/FXtiNT99mOHJhKzihidD
	 thQM/KuY4Xv3G+n8DPlPJy3NMSz2wK1qa6qgC/lzpeapnuaZFxYfsUxv31velrDxWM
	 yx9pEyJ8MNe3g==
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
Subject: [PATCH v4 3/6] RISC-V: add f & d extension validation checks
Date: Wed, 12 Mar 2025 13:11:46 +0000
Message-ID: <20250312-reptile-platinum-62ee0f444a32@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250312-abide-pancreas-3576b8c44d2c@spud>
References: <20250312-abide-pancreas-3576b8c44d2c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=4ovnGd2xVakirrIacf77VjQZZtTzzTmY7fwuG+fgLn8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOkXO4T1d0x6HKlXwPm9tnz55sVHd1vWVrFVXY16r2m1N jxjU/D0jlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEyk9TQjw+baa+aeUyYq7pix Kf7J9t9Ts2cU5n78dlzzWZbx19h3O9YxMjwwEGKflxHXdFFlxaEpYuf/a7W8daj7VCwb8LLPRya 3jxkA
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

Tested-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/cpufeature.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 4fa951e9f1cf..21d3cf361e0a 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -109,6 +109,33 @@ static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
 	return 0;
 }
 
+static int riscv_ext_f_validate(const struct riscv_isa_ext_data *data,
+				const unsigned long *isa_bitmap)
+{
+	if (!IS_ENABLED(CONFIG_FPU))
+		return -EINVAL;
+
+	/*
+	 * Due to extension ordering, d is checked before f, so no deferral
+	 * is required.
+	 */
+	if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d)) {
+		pr_warn_once("This kernel does not support systems with F but not D\n");
+		return -EINVAL;
+	}
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
@@ -371,8 +398,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
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
-- 
2.45.2


