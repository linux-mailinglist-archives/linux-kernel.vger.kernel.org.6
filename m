Return-Path: <linux-kernel+bounces-306726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85071964298
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9CE1C21F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140E71917FA;
	Thu, 29 Aug 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUV1oSJg"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25BF1917C8;
	Thu, 29 Aug 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929533; cv=none; b=kYbvMF2pdLWSIkmmzOyetwDG5jasBt44LR683fnPEii0MpMZTXaqSV0ldHWyTrBeSgnJ6s10I+lSZLm5Z4q3jUIBDUhjt0fC9c9e6lAGq5G/B247gBRWPjlatvWy/R4FYu0pD2wX3JoU2P/pZCseRgBeKFdOBqFo//erRpyOydA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929533; c=relaxed/simple;
	bh=YNsEAs5CokucoiIhAZcn3ok3wIhCSgF0riXfmwuVRHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koLeji3hbK6d5GYWl7Jl+4NTs2SRVHzan50lOaEbmKSQqRQ+baYQSnWUZbOPfF3I3Puy2uPsB2INIUaiCo1+hlbhvJhNE7jd9f/nGKiwM06hJo3vf1tVZE6p2A+wLEZxKautwiw9zm6ttJKI/rIz+CjmVaz/Yat6xKAJH2+dFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUV1oSJg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7143ae1b48fso327285b3a.1;
        Thu, 29 Aug 2024 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724929531; x=1725534331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eGSx27JcX0pDUTDyQY+9iXqRUjb43ZGaILimNXE8xk=;
        b=iUV1oSJgoGQrQ0rqzDyM0KF0+njeoaqJ4u7h1BxZIS8Yg/o9DuFprjj8X7TsbFsIJO
         ZIAvd/gvy1v7IvYgNCSh4bKvIuIUBmokzbkPXi8ml07POql1GjCJ4l5GWPiwuky3u/oV
         2seBjOFJpbIY3uX4CryuNIMAczxUcf2nr3ZPNwPZJcboAYJB7+3gx8MqetonCO2BM1vS
         lHS5R7t0B+Dy3aAg9QFsIZC/O4RJOjD9b+qBMcCwXmptdgJLeB1ARL1BiBPjp6rT7Dl9
         5n18ZKkBmmEj4J4QO9/YMTTiPDWqLq7/crvyuPcW2qehVezl/5ITkFWlXaPlYeECAL2b
         VQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724929531; x=1725534331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eGSx27JcX0pDUTDyQY+9iXqRUjb43ZGaILimNXE8xk=;
        b=Zu4HCnGzLyTDVwqqAimgK1GlRKdbbKnAUWSjsPhXy6kzPRLb+NWUhw1rTzwHddjeiS
         g24/szXa+IOfqlHI3sCI1GF+4YFA5YSmCNRQiMPMn27UzzCMkEyLZ7LKO0XLdR8BjI83
         2sWTY19Y529CiCOWwCPu8cmIQYaba9ogLJykMfvaysApbe9mD5AyyJY5zFWBGWTPGlnT
         IeNn+uQrVVGdnU/hPiNU6Ra4Doi7PL6ybpobpoa/dOVohoygeJKk1bw8dbvof4ODuh1M
         Caj/P7073qD9vdNVfOzgBM6qk5mgqWCAnERS3B3+mYUZJ+CkTBsaGRfgKEEPyEyMdMuX
         zqpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Qj2939shS+qM4PFWahOR1TUL/Sg2daHD3ijr8qzX0FSgT+kdSvlbRXrWllQKOR2KniX5N1fporKafIrn@vger.kernel.org, AJvYcCWt1NAFBBD9Tj2PEnNHKcr31g5juPKiSg9HQGLRXXs3My1rVUONDj6y+7l6qdXx0at2enbDoK9xdL96@vger.kernel.org
X-Gm-Message-State: AOJu0YxVLUqljXn0Y4ntizREVfga6UVFz0uDVDn/VzKFYT0CRhQ5KOO9
	/JMD06eCjUInrJkR12gQElC1adWr+YCO0JGO/93GDujW+1yUhu61
X-Google-Smtp-Source: AGHT+IGpRch0t0zQ2dsUBSE7fPI0Pg93inIyw/ybrn3xmOWgd/6H5CjnHko+G2tx5xUtsaBGE5M2bQ==
X-Received: by 2002:a05:6a00:23d6:b0:706:b10c:548a with SMTP id d2e1a72fcca58-715dfc8b955mr2267911b3a.22.1724929530925;
        Thu, 29 Aug 2024 04:05:30 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e5576cc7sm906671b3a.32.2024.08.29.04.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:05:30 -0700 (PDT)
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
Subject: [PATCH RESEND 2/3] irqchip/apple-aic: Only access IPI sysregs when use_fast_ipi is true
Date: Thu, 29 Aug 2024 19:02:16 +0800
Message-ID: <20240829110436.46052-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829110436.46052-1-towinchenmi@gmail.com>
References: <20240829110436.46052-1-towinchenmi@gmail.com>
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


