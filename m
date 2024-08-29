Return-Path: <linux-kernel+bounces-306519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE5D964009
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FB52825E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5528318DF7A;
	Thu, 29 Aug 2024 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6Av/IbM"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1918EFED;
	Thu, 29 Aug 2024 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923642; cv=none; b=T/+7Ay2w3MOA9SXZlW/t73KO7beOavMcHY2vfWlHxofOHE2vdKa5CttNgwF9Z63Q4yt2ZBLxn/zsFv+rYp4DLak9OXit49cIjNrM3BQvFIr4eeBuAAXoNRwPicn6WTEhie6sA/AaoQ2HMz+ldjyXq/QXImjxBpMN4bY8NDt6rKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923642; c=relaxed/simple;
	bh=YNsEAs5CokucoiIhAZcn3ok3wIhCSgF0riXfmwuVRHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNzCrcoRWdLMbiLQxeTxuDPKpHTwEu8KF61lysvbgVJfrs5jXWbi1KOfhcN22ZLDX6yD16vy7wQ9s0+4TtnU9HmmojfbfStaK86+yV630d0vgqXUZQ7TLLoLtfSBl6HFBsTxrWdW84owGxBwfNw16tV7azGdehcioIQQC6t1t+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6Av/IbM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2020ac89cabso4339105ad.1;
        Thu, 29 Aug 2024 02:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724923640; x=1725528440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eGSx27JcX0pDUTDyQY+9iXqRUjb43ZGaILimNXE8xk=;
        b=h6Av/IbMSExxJArz10gL9MgOEwEA1WFK77TBtPuzE5Sc99gbXGcPJR3eZRxNcXo69y
         9FNMc2ssx394ZTbd9xvm2SetUccfLMbDuicy18/nOaMM3ZFM5BriHspJE0NPqPm4/sWK
         eZsNHPRZk6Sfcd3mjSO+CGflvUz/q2BERVK9HKGSa49Y17dE4ytZrUoSWZneaL9Uj7at
         sNLX2I+hlLajSMMBhaCJPPy2gmUUmZimBY5n+GlbfM1fYlvNtJQBEgvCIqhwj8CUC4On
         QMXheb1WRcI8Css7fqAntUTB5QVmx7HJaagjBeMcMorsyt+ozVKgBulPeYJPcZFl86y5
         UCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923640; x=1725528440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eGSx27JcX0pDUTDyQY+9iXqRUjb43ZGaILimNXE8xk=;
        b=t/0PDwEgcekSp9h5nQELnIV0GY4SURyhM9gNndP6XyyJxaoh5PPWI+ozjaub0Njva5
         VMP1RPnyiX/ywKQifbATdEpU0j3bPbJtc77YM/Of3Zt6Bm2QZ3MDoFsdO0pP1uckn9cJ
         Lh291omp4lhSnXETKJLdTsbigkJ9hYnCNrm6MWa18bONyGvLrbB6Dj95dkA8QrC/87yh
         kJdlBZEidDu2tBmeSxmDYei9EQ6eKyGjJZkmEK4b9wVBCRotZjspTEG7I0wDvougiKcL
         ppbLnAdWv2ldvZfz+bsGjAcFbN6lVDydeqgH2DEbm0yApiYuvFndsTcKzPfme+evKxCI
         vA+g==
X-Forwarded-Encrypted: i=1; AJvYcCUdR3sLNmpbHgTYRrgE+Pmy3tGfCmXFZKNHuR+Co0asGbK9J65iWQCA1wKbp6SWfKIFSLagufS2602U@vger.kernel.org, AJvYcCWyMYZafcw5yCwiw374nfnjRfRIoYP4YjdlCi9lbyXRN46LUwz50k2V+Pyi/ne0/qIBbm41QGVPYAxxUmuT@vger.kernel.org
X-Gm-Message-State: AOJu0YwV5BkLgX2yjzpFH3xDuxp+8JDhdSUMx3HPb9gu4X4rSdUDQF1v
	DWvf0wP5pJqHtFy/C//Sjk9X+xMEEUUJCDhJDPKFuPzGxNPCOoL8
X-Google-Smtp-Source: AGHT+IEKUoxDuqT/4bjh7520aySEhnZ1arjlxKlqJuEFhxlHhQmG4atig6hIsfRUrkQ+FFxR+vzDFQ==
X-Received: by 2002:a17:902:ccc7:b0:202:11ab:ccf4 with SMTP id d9443c01a7336-2050c215845mr22583185ad.6.1724923640331;
        Thu, 29 Aug 2024 02:27:20 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20515552b6dsm7469245ad.249.2024.08.29.02.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:27:20 -0700 (PDT)
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
	Nick Chan <towinchenmi@gmail.com>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH 2/3] irqchip/apple-aic: Only access IPI sysregs when use_fast_ipi is true
Date: Thu, 29 Aug 2024 17:03:12 +0800
Message-ID: <20240829092610.89731-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829092610.89731-1-towinchenmi@gmail.com>
References: <20240829092610.89731-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting from the A11 (T8015) SoC, Apple introuced system registers for
fast IPI and UNCORE PMC control. These sysregs do not exist on earlier
A7-A10 SoCs and trying to access them results in an instant crash.

Restrict sysreg access within the AIC driver to configurations where
use_fast_ipi is true to allow AIC to function properly on A7-A10 SoCs.

While at it, remove the IPI-always-ack path on aic_handle_fiq. If we are
able to reach there, we are on an IPI-capable system and should be using
one of the IPI-capable compatibles, anyway.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/irqchip/irq-apple-aic.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 5c534d9fd2b0..626aaeafa96c 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -234,6 +234,7 @@ enum fiq_hwirq {
 	AIC_NR_FIQ
 };
 
+/* True if UNCORE/UNCORE2 and Sn_... IPI registers are present and used (A11+) */
 static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
 
 struct aic_info {
@@ -532,13 +533,9 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 	 * we check for everything here, even things we don't support yet.
 	 */
 
-	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
-		if (static_branch_likely(&use_fast_ipi)) {
-			aic_handle_ipi(regs);
-		} else {
-			pr_err_ratelimited("Fast IPI fired. Acking.\n");
-			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
-		}
+	if (static_branch_likely(&use_fast_ipi) &&
+	    (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING)) {
+		aic_handle_ipi(regs);
 	}
 
 	if (TIMER_FIRING(read_sysreg(cntp_ctl_el0)))
@@ -574,8 +571,9 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
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
@@ -811,7 +809,8 @@ static int aic_init_cpu(unsigned int cpu)
 	/* Mask all hard-wired per-CPU IRQ/FIQ sources */
 
 	/* Pending Fast IPI FIQs */
-	write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+	if (static_branch_likely(&use_fast_ipi))
+		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
 
 	/* Timer FIQs */
 	sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
@@ -832,8 +831,9 @@ static int aic_init_cpu(unsigned int cpu)
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


