Return-Path: <linux-kernel+bounces-339995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37896986D10
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684831C2378D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B83D18DF92;
	Thu, 26 Sep 2024 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CN3HUdxy"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0775A18C006
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333761; cv=none; b=SePch5POBLmC73ZpFrVBdPkGJLyqzx298xQtestXRNQyXdpl3NXJaMc5en3eVBe6chCPfcP5N2kOydlY/sF6tYdyHNz2oap9w/8oc0pPFKQynb+ez5B5aNICDM8/ttwtBGxT1rQhK9/3Z1XU+LkVZLmIYgjKOrMdX8ZLtcCj/bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333761; c=relaxed/simple;
	bh=XxrBvssQCULF7gJT9QV9ETG1rZxqsygfpT3RAP7F+uU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O1GMfEg47Yj3Ij0FO93ExJLXRwD+60a6NaJwfIN170mI8QYPEqd1hb+r4IoTeX7VVbPtQQeipWCi226/+xSueLNZ5jwB97y8QK9aDydTMkawP713O9981gODznYg29YnXmUx1LY4IkDl+j3F8+nBrzVXxdTi2zpBvzXTN9ptipA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CN3HUdxy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so609719b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1727333759; x=1727938559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBjlL5kJGWFBAGi9ogPc+NvNpZhpYyzyT9+ZEo8HCi0=;
        b=CN3HUdxykGrUrbTfLA0xk7l3Ghbfg4zVF7BzeLnUZ8kNAsTpMJXYPWdAYw5+EPVePZ
         1ixzNRiif6mkg3AVtIOVRqVmE3wrZGytd5yIjKaV1af/ZTP/BTXgmTZfWDjokad3Hqj3
         d5kPOWx5N6q7nPU+Cps9q1q1nM85cOmLrWD6gBPZ48g74z0A47uIglEQcCVmuvbwIlKo
         rouOaEcIXBa8sPJXLtAFVTsoyGxysJiUL1uBDinIV0WYF3AHFwR3Qf72/jzDgkGEbDOc
         4Gq5MZq1nu1RJxf4s+tx0M8DgJNhPm+yPoEaOXtpWCBt4eYII+drJEBNDco2Xy+3Ftjt
         jhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333759; x=1727938559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBjlL5kJGWFBAGi9ogPc+NvNpZhpYyzyT9+ZEo8HCi0=;
        b=fYHbFmsMS1SDHMkTu0ZSoYNkTkd3zb6r/OjCy8Oa6lEZ8H5OnA2enciiJlT7SoXePm
         AwThQQO8KZBgyci3pVljLFbeRFve6/YyWiQ2CtK1clOAxj+OSjQkV7eHtNN9WQr9an8N
         7EUIoNa6sb1eoRI5lcpmtQaVqH1bumt4JgArPMVA/4cwpsKWxd72BiFBL0Pt0kNU60Sb
         VwuIANu/hQLN8eK8gugaERl5LHKlqK5TI0ZnhpdvXqqZhf2S0mZ1bnamGf7ZRjwbe9Gw
         P1A5D2rliTt08Sf1p/ZYYiN6wAgFknLYHdBrjJ03tzgq5rkatEz4QIZaA08oIDpUVAjI
         Bclw==
X-Forwarded-Encrypted: i=1; AJvYcCXgU1XnvHdQa5O2NX7ZcK7WYHrWMZIGyp0oGdnkDvZYa57xh7itgEhT97UFZh72UvtUU636rC44oIXjWks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp8ka5LYJ9154O5rqH22R+z7swSqQTWQt9LZYUmhoNvRrSNHzp
	2UcOLAoIeBM0ruQ/RNIXczkLiwyXYhG4LwVz3G8qP4/41j2nly5Om/iskhphOMSKPJFg9QzArOl
	bN3g=
X-Google-Smtp-Source: AGHT+IGRVC/omnADRGlsObbkjgi01W+xceim4yTBxK4kFMLlr9FVYoKLagm1JteCLvHw13sLiTwW3Q==
X-Received: by 2002:a05:6a00:8315:b0:718:d740:b870 with SMTP id d2e1a72fcca58-71b0aa95107mr5923632b3a.2.1727333759199;
        Wed, 25 Sep 2024 23:55:59 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c73120sm3592352a12.68.2024.09.25.23.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:55:58 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: greentime.hu@sifive.com,
	zong.li@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Nick Hu <nick.hu@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 2/3] riscv: Add stimecmp save and restore
Date: Thu, 26 Sep 2024 14:54:17 +0800
Message-Id: <20240926065422.226518-3-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240926065422.226518-1-nick.hu@sifive.com>
References: <20240926065422.226518-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the HW support the SSTC extension, we should save and restore the
stimecmp register while cpu non retention suspend.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 arch/riscv/include/asm/suspend.h | 1 +
 arch/riscv/kernel/suspend.c      | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 4ffb022b097f..4dfdb7134d0e 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -18,6 +18,7 @@ struct suspend_context {
 	unsigned long ie;
 #ifdef CONFIG_MMU
 	unsigned long satp;
+	u64 stimecmp;
 #endif
 };
 
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index c8cec0cc5833..5d9036ea6784 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -30,6 +30,9 @@ void suspend_save_csrs(struct suspend_context *context)
 	 */
 
 #ifdef CONFIG_MMU
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC))
+		context->stimecmp = csr_read_hi_lo(CSR_STIMECMP);
+
 	context->satp = csr_read(CSR_SATP);
 #endif
 }
@@ -43,6 +46,9 @@ void suspend_restore_csrs(struct suspend_context *context)
 	csr_write(CSR_IE, context->ie);
 
 #ifdef CONFIG_MMU
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC))
+		csr_write_hi_lo(CSR_STIMECMP, context->stimecmp);
+
 	csr_write(CSR_SATP, context->satp);
 #endif
 }
-- 
2.34.1


