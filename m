Return-Path: <linux-kernel+bounces-384233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CB29B28A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD947B21E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59331917F6;
	Mon, 28 Oct 2024 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S115dEfh"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FBF19066B;
	Mon, 28 Oct 2024 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099899; cv=none; b=lnaoudB3+RxyqaaFPPAspHpDgQ3PANt5MWcR1NY6I3h84dycET4U7kp658ICu/SunZ0ZVU0k5JuZTaPSRhU7eYeOn4nBR61M5Cmp8iQcOuGX24gzWu8hsBL8mj5VUQO61Po8NBCFmYh5piXdVx/RKSMcf3fFIV1vb5Z271zbAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099899; c=relaxed/simple;
	bh=J3lvfNu94j/hIu8zW/nlNeCHxY5XSNW9+1XkAp2wfNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+DtUEJPuXmHmgloF/+1uJ0bEEjIxXiA8J4h6PAf8bK/B1WeGQRozTF+GImwSvn163ysSBeeo38k2zw6X9XwJJBryQuQS/ZsM1MriFa42rFSNRqFp5TykPsy2XZdKb6OIHdLXnhPMd6Vg5XEfkKiDcppWRVEmpIBj622gW28a00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S115dEfh; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so3205437a12.0;
        Mon, 28 Oct 2024 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730099897; x=1730704697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uizG+AQKjMiNSyY0/c5FnD4O0HivvPLaMjzCzg5Rho=;
        b=S115dEfh8OGDUNuYNs2GUQ6XjT6JAcVeQwoSYvV5gbRP8xzh4TJxi64qTosEr6PP0q
         YaoBBJiPeOG2E9ga9+K+hhOwsx+G3bHsXSGGYgmbAs91PKP+2ARd9SFVTFisQuh9GKrT
         n8cH95nyAYgSXJG3b+fEotgP3rmhYs/4m8Nj4+1Oe639uvkvORQh9mYtOhhD/BNdOINb
         QNMcw2oa5ttzd49Xr2hhNbiebURTBc6Rok9P1gP6U404JtfDia6igHcx8T+GvQ9ec0n8
         U3baScOZUEb1pLWHjraQWcN2MvKJKwrhCN6k4w+i8vpEfq9W/O3ELZW5u/dmq8VcH0MX
         +2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730099897; x=1730704697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uizG+AQKjMiNSyY0/c5FnD4O0HivvPLaMjzCzg5Rho=;
        b=KRDEPCdXBWLgsCk15NAdy50q/qDy8ccQFWSQ2sS595drdprYAf2CCCsZSChnEEiKkm
         nXOUVjKV0VWrAAdH6CuugRkDOFIxBbUwmN2RGzWimDnFD+x0pn15+oE2Sb7iewqrnJwo
         YlnQ9vyTBj8DJha/CZCV8d1HmXwpMFjNxTiTL2T2O6Do7QGyY2xgBqDW7ztalcNxYVgB
         IKs+B5j743Lo/l6wMZYAR+v7eN5fmEVy9dAYm8/gEOHIfpj5zO+8qvlQumZwTKrO9vtA
         XOVesKCkqbSB39gZapDEffyvz1u+r34QhLipzmkAnDgryi4QPRjKzOD3Wf+HqgFN2MH+
         Ag6A==
X-Forwarded-Encrypted: i=1; AJvYcCVizEm3luvuahx3fJIgrAlf/n1Zd5eW/lRVcyWjFr3nRV8Jr84wFZkniyKqTro12uEMsJf/Aa5fYmmk0dkL@vger.kernel.org, AJvYcCX2G35jtT4UFnyNoo4e7L7Dx+NAe7VdzORKg8GeGWtTEAoi1YBfLFFlYv6u1iC7WDUaidw7UH5r62QT@vger.kernel.org
X-Gm-Message-State: AOJu0YyxgW0R54fnxrevTkxPV/asEDQmiFlVf5szWt45tVEN0MgDU5lR
	Jmgy44jXnANcppZx1rLVcGf1xyzPTd7SvAJ17QmGmbVU37z8ysGp
X-Google-Smtp-Source: AGHT+IHNfSRs9MLweGhcUMEkHy9O8xX5ZL+PQe11n4eSXAbVgAxJpcl9qI0OLy2nv3XOv1wiXZAMEA==
X-Received: by 2002:a05:6a20:d807:b0:1d4:fc75:8d48 with SMTP id adf61e73a8af0-1d9a83ab0bemr8870713637.3.1730099896702;
        Mon, 28 Oct 2024 00:18:16 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205793189esm5056118b3a.58.2024.10.28.00.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:18:16 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andybnac@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/3] riscv: add ISA extension parsing for bfloat16 ISA extension
Date: Mon, 28 Oct 2024 15:17:42 +0800
Message-ID: <20241028071746.869740-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028071746.869740-1-inochiama@gmail.com>
References: <20241028071746.869740-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add parsing for Zfbmin, Zvfbfmin, Zvfbfwma ISA extension which
were ratified in 4dc23d62 ("Added Chapter title to BF16") of
the riscv-isa-manual.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/include/asm/hwcap.h | 3 +++
 arch/riscv/kernel/cpufeature.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 46d9de54179e..97657fb63af6 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -93,6 +93,9 @@
 #define RISCV_ISA_EXT_ZCMOP		84
 #define RISCV_ISA_EXT_ZAWRS		85
 #define RISCV_ISA_EXT_SVVPTC		86
+#define RISCV_ISA_EXT_ZFBFMIN		87
+#define RISCV_ISA_EXT_ZVFBFMIN		88
+#define RISCV_ISA_EXT_ZVFBFWMA		89
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3a8eeaa9310c..1b286f5bc591 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -325,6 +325,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
 	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
+	__RISCV_ISA_EXT_DATA(zfbfmin, RISCV_ISA_EXT_ZFBFMIN),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
 	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
 	__RISCV_ISA_EXT_DATA(zca, RISCV_ISA_EXT_ZCA),
@@ -357,6 +358,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_SUPERSET(zve64d, RISCV_ISA_EXT_ZVE64D, riscv_zve64d_exts),
 	__RISCV_ISA_EXT_SUPERSET(zve64f, RISCV_ISA_EXT_ZVE64F, riscv_zve64f_exts),
 	__RISCV_ISA_EXT_SUPERSET(zve64x, RISCV_ISA_EXT_ZVE64X, riscv_zve64x_exts),
+	__RISCV_ISA_EXT_DATA(zvfbfmin, RISCV_ISA_EXT_ZVFBFMIN),
+	__RISCV_ISA_EXT_DATA(zvfbfwma, RISCV_ISA_EXT_ZVFBFWMA),
 	__RISCV_ISA_EXT_DATA(zvfh, RISCV_ISA_EXT_ZVFH),
 	__RISCV_ISA_EXT_DATA(zvfhmin, RISCV_ISA_EXT_ZVFHMIN),
 	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
-- 
2.47.0


