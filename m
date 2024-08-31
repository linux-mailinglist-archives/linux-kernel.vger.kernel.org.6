Return-Path: <linux-kernel+bounces-309715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75621966F95
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516271C21C5C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B521531D2;
	Sat, 31 Aug 2024 05:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etSZMK9h"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0121E2E405;
	Sat, 31 Aug 2024 05:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725083876; cv=none; b=cpcCQ/zw133l17kQgCml482v+4ffHIhTnCyq7WyABQbP7ZimbylCdGz4swc2vJlYI/8quu6ailnK5GpcKvjraFvxJGj0dAFmbL7KEt/Warfh87DFHTtQJQExzSlzXb3YxJIiOqK3WA7IWeJwqq65qiDvwTvG8V9iYHfwSFrTyyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725083876; c=relaxed/simple;
	bh=i1wHNYB9L1TbZMmb7JXpPz2IK/BYlwoGeSiZU2nrtps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zzd3cvhq3YWNomtikLcqvct9FLH16rR/FT259YRMbmabtj4N+7vU8b4DZ1AbzQ2reFDSKryVfkrZI7Bjw4Ku2ZIgQff5fy5yIpfhetT98anQpjqWi93NN0hEtoadC+Jn10T6JQlaFmjWg5oZZRzpnybW8pxRgprGnxsmEIUG0tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etSZMK9h; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1435783a12.0;
        Fri, 30 Aug 2024 22:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725083874; x=1725688674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c61KzTihCjzePgzXbL4oR36fnoTGJU/hUcEWcyWz+t4=;
        b=etSZMK9h89sVc4rJc25tqQk0cOa9e2+e3JtFwfU/qBvsr6Ai5y8nIGJnXTdcYRV5zB
         yujTXZODJx65BsV2pvIBc/9tJVl/V5cudLgDdz2uThpfHn2EQmKXotFvrx+Q4XFfjp03
         IbCU9U7xuNr+bUwQ1oyTsJPFSwhGcFTxU1PAtCeYh0u79VCOw11RWDkncSIU6v18uLKH
         ywKV0n7PgzK+eOBnvkw/v3TP806nPX/3kJmlkPCfNFD97M0ne6BSsakIzPJrQ0Aa5qv2
         VYR/9jsRfwdRKhyPnyIdTT2eX6VUYGPtvBH2LYr7G1CDTwpzKKIgCW1w6Yt0UIVBgS5i
         5kpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725083874; x=1725688674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c61KzTihCjzePgzXbL4oR36fnoTGJU/hUcEWcyWz+t4=;
        b=rcpeAijyQAFmCgOkZK9Z6HgqVjKa2WCsZprST4cCSwOgMHEY137oxDTQoBIeO6GtJC
         Y/LBMf061byMDvdEYp8KD5efNCYdjrBGIARR9I8/mLxk+S4nCcGNgSYky5WCPMJ5qEY4
         z5TC4Lbb4eijxut5LsiKOX1d2VcX80Rlrg6gIDF8qfqVLUDxH8Z7m/yh81Gu1pmbNBY4
         asbV+08P3wAJTMJZ3xtdY4VVHKHmMYAYIxhVOOYaA8rhvXAJq7ROlbNy2/5LSe4vIoek
         N1D1cdmE3CVNWgsxhxj4GyFM2/gequkOCimbOgZvWbGzdVpoK2y3B5djuNUQEAFWUkG6
         K0lA==
X-Forwarded-Encrypted: i=1; AJvYcCVQry3haUpkvOUgkokHvZlxI1HjZe9qr6UJIU5KwvzW1T8m+tQyLu5E8353eNPtNJGQ2GiRXZUatD3b@vger.kernel.org, AJvYcCXJPsdo5umUXlhr2OZb+e1w/X3sXr2lDfD+yNDWhpSXZGBfVjRNMq13udGTCFyYTx8eQwzOQG0h7haMkSMv@vger.kernel.org
X-Gm-Message-State: AOJu0YyyBclYnEu/78TZr83cvYNEFTW1Pi1a1jdrgOR7W5z4t92sPBIt
	5SIMVDjPj7HKlud/tltU9opi3XKMb6f9jbvR5tDQkljU74rE3U6N
X-Google-Smtp-Source: AGHT+IEYvysVPYow9FSPEgYtUv10qvcbs0XqkpUYakMhxEFHJy0yARyeKD5B3eznnVOi1c96X+YK3w==
X-Received: by 2002:a05:6a20:d487:b0:1c4:bbb8:4d02 with SMTP id adf61e73a8af0-1cece5d12cemr2073712637.37.1725083874173;
        Fri, 30 Aug 2024 22:57:54 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2053aa8cb4asm12027045ad.271.2024.08.30.22.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 22:57:53 -0700 (PDT)
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
	devicetree@vger.kernel.org,
	konrad.dybcio@somainline.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 4/4] irqchip/apple-aic: Only access system registers on SoCs which provide them
Date: Sat, 31 Aug 2024 13:48:20 +0800
Message-ID: <20240831055605.3542-6-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240831055605.3542-1-towinchenmi@gmail.com>
References: <20240831055605.3542-1-towinchenmi@gmail.com>
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
As part of the restriction, the IPI-always-ack path in aic_handle_fiq()
has been removed. If the code path were to be reached, the system is
fast IPI capable and one of the fast IPI compatibles should be used
instead.

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


