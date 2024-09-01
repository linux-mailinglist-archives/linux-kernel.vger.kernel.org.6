Return-Path: <linux-kernel+bounces-310079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C070D967486
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 05:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508931F21E69
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 03:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FFB482FA;
	Sun,  1 Sep 2024 03:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSMdoGBV"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A263E4CE13;
	Sun,  1 Sep 2024 03:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725162176; cv=none; b=lDEAPFoj6kX37npt/j01av5k77fzdJyOB/G12YF2FVCXmpbZ8iqi3ZyjbewbhvX/8NZnpvbJn6q6tKvsFUb1pASRn5Ii3bJMJGRSpS7VE5hm+dAX1nCEfL4qqMqX4k9nQpEixweuGIngf1QHXMgwulWf6W3tVMejxxVyVBdd0ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725162176; c=relaxed/simple;
	bh=HEoypMU/RIa6lonUS83I89WnGQCeDWA8klVeBbv9qnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjbGH5EpkepdXdlmvuETI5vKXxJWjiTbQ42uyMX51V82CY3/hYFAhd6q5czX5MtALyMJ8RNwMn6+gCLgiOZfbPyOQacffwSoh0pswq3q9LHkSRzsnK8NWswkbhyp5PcALk3hATZeCPeRT/cy/F04tTWUqyerhuluwc6QuccGa0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSMdoGBV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7142448aaf9so2081904b3a.1;
        Sat, 31 Aug 2024 20:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725162173; x=1725766973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Jlw7myxYxrx+WOkTkEU/GjLvfU58jir7qbTQIyRSl8=;
        b=LSMdoGBVsqPvh7RsjH9mwzv2SYlJyeDMqtZLf6rQP5gfsV1clnyURaozGOP6QfKew/
         dxTtMO91devfSXRrS7gGxHfvGKAb4tjCS3PGm2Sgv/09Sp/OgdMev+qO0PXxHCuLIwqL
         c86x+5NwX7X9LDGgo4LZnPBEE9XgKFgizBlb+Pt+eZl4F48yO/ZTaWqJN9DYb/7hqOle
         9djCqOs6g/M9sacndX744KyPoTdzlqysByL2/8/hBArV2Yar16fpkGoXy3awq43/v93A
         weXLHkir4golPYTMORba4///JIQ3Q2LqU9Aqi8xHh0gGHK76owQiKqnjGHUdr0g7IGRH
         N5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725162173; x=1725766973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Jlw7myxYxrx+WOkTkEU/GjLvfU58jir7qbTQIyRSl8=;
        b=u0i/TRHZ/iNwEMEPsUW9oRidcQhmuCZNmYmOWBrQzzjTubK6nLOINsdZBwaEtmPqGg
         dqbhM+ICCAIEfhb1wPsAOvWtbf9jVIXNO6EFRHchTu0eKL31aoLOFX1CL0mIsmOM87nC
         29Q8lQTG5C4N4afrELioDL9ux6z+JtA2TBVtOrd9VHioCz6FOkFMiQGRI4qS/rrJMpk3
         FpkTT2y8e9QXcV/jPBF/tV40RWlnshcf7v4V4399yWSHcvcl1a6vGTC1jUGXoxgdeUZH
         rZ/cfQkX226R3X1IGI8su9y/4AQnj1ZlcgbFoDdbSGv8C+r3fcqv911tU2MjZVq0MUgl
         PLAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI7vSdfsL2T4/sAspz/cTZL9hg1xnOy221zZeZVAkP2wby2XHdGVmCAfFCYPhTXiJPwPDkb8OB0mGt@vger.kernel.org, AJvYcCWTVyXE1k9qS1mwUbN74qEJI9Edbw8Dactf05HG1ZRjCcvUXRM/1nwSaK9C13E4ve8zNic46Xg3c6JSme7f@vger.kernel.org
X-Gm-Message-State: AOJu0YwqyNJHQnMHnr0oiPR4shI1oKSuJrVrQ2JUtOvuvoD789uH2oo5
	WAkUUdfUYxwj90YcvbF3A2Z2WclLp1y7E/Iv6iuvtg1BAYRKO1HL
X-Google-Smtp-Source: AGHT+IHc5YknrxzXlFuucuStWx3gBFqQRQQwKvn1lhHqX/o6iunywxLlE/ficJuzfPbWPY8NggTDHA==
X-Received: by 2002:a05:6a00:1905:b0:712:7512:add9 with SMTP id d2e1a72fcca58-7170a85ab58mr10551336b3a.13.1725162172772;
        Sat, 31 Aug 2024 20:42:52 -0700 (PDT)
Received: from localhost.localdomain ([49.130.72.113])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e55771ccsm4826767b3a.43.2024.08.31.20.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 20:42:52 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	konrad.dybcio@somainline.org,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v3 4/4] irqchip/apple-aic: Only access system registers on SoCs which provide them
Date: Sun,  1 Sep 2024 11:40:07 +0800
Message-ID: <20240901034143.12731-5-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901034143.12731-1-towinchenmi@gmail.com>
References: <20240901034143.12731-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Starting from the A11 (T8015) SoC, Apple introuced system registers for
fast IPI and UNCORE PMC control. These sysregs do not exist on earlier
A7-A10 SoCs and trying to access them results in an instant crash.

Restrict sysreg access within the AIC driver to configurations where
use_fast_ipi is true to allow AIC to function properly on A7-A10 SoCs.

Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Co-developed-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/irqchip/irq-apple-aic.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 01a3c79054f5..a6d812afb10d 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -234,6 +234,7 @@ enum fiq_hwirq {
 	AIC_NR_FIQ
 };
 
+/* True if UNCORE/UNCORE2 and Sn_... IPI registers are present and used (A11+) */
 static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
 /* True if SYS_IMP_APL_IPI_RR_LOCAL_EL1 exists for local fast IPIs (M1+) */
 static DEFINE_STATIC_KEY_TRUE(use_local_fast_ipi);
@@ -550,14 +551,9 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 	 * we check for everything here, even things we don't support yet.
 	 */
 
-	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
-		if (static_branch_likely(&use_fast_ipi)) {
-			aic_handle_ipi(regs);
-		} else {
-			pr_err_ratelimited("Fast IPI fired. Acking.\n");
-			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
-		}
-	}
+	if (static_branch_likely(&use_fast_ipi) &&
+	    (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING))
+		aic_handle_ipi(regs);
 
 	if (TIMER_FIRING(read_sysreg(cntp_ctl_el0)))
 		generic_handle_domain_irq(aic_irqc->hw_domain,
@@ -592,8 +588,9 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 					  AIC_FIQ_HWIRQ(irq));
 	}
 
-	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
-			(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
+	if (static_branch_likely(&use_fast_ipi) &&
+	    (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ) &&
+	    (read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
 		/* Same story with uncore PMCs */
 		pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
 		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
@@ -830,7 +827,8 @@ static int aic_init_cpu(unsigned int cpu)
 	/* Mask all hard-wired per-CPU IRQ/FIQ sources */
 
 	/* Pending Fast IPI FIQs */
-	write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+	if (static_branch_likely(&use_fast_ipi))
+		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
 
 	/* Timer FIQs */
 	sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
@@ -851,8 +849,9 @@ static int aic_init_cpu(unsigned int cpu)
 			   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
 
 	/* Uncore PMC FIQ */
-	sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
-			   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+	if (static_branch_likely(&use_fast_ipi))
+		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
+				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
 
 	/* Commit all of the above */
 	isb();
-- 
2.46.0


