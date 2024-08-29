Return-Path: <linux-kernel+bounces-306727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B600596429B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2561F210F0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C042191F65;
	Thu, 29 Aug 2024 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBKJWqw+"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522D41917DD;
	Thu, 29 Aug 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929536; cv=none; b=QKrwnTObghZ67yVHGVPRE9JpaGghQtRsJf0HoRRGytyraMfNw6f4S1xC+IMjMROW1m/etlPEbNsAny02/oepFhpwkE6bARwrJ6TRaKnjfJFip6TKYm6Hun4vbLBaF2dhBU082vlCHtgo3xbPWhJqV4fTpczlf7OKXxLbM5qvnW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929536; c=relaxed/simple;
	bh=GsymrVXVYO+dO7YPnEgbp7GbzajeB94SocfoMFoRvQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uN+WTL7nGIoHGUafQjfQHHLnD0kOheJfEzsbOJ/rmWvxgo3e8IPTk5k1CUAVuIv80pGyIL2XNdzpkeUgKsv9uF29JgGqu3/HR4uH5NE8rVMffnDk+rfE/KlRosg5NySiUEaqiExs+0uWl7WlDbrTa24P0l8kZWqbjyQOXTa05+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBKJWqw+; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39d2256ee95so1793295ab.2;
        Thu, 29 Aug 2024 04:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724929534; x=1725534334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IMpDPXDzGDzNLDUQoG0T+dbS2HtKvxhLaW4H3a0SWA=;
        b=DBKJWqw+iRjW+4ffwfd4vrWOdhPE7T9oyLSY0ETgmgedOyjT3YMwsRDJyM3zPtDZf1
         3R8WObnvnyCKJ8ax+EHKS/rZIFDh8x9vctw0VcrFpvYbLlOVyDXDnjsvbMN5cm6KDxPx
         CMnjC1d4sJevXre89N599j+2YDWQCtwFTHxseQe4nuP5WzW6qU8Sd0IGu0aOrXuX+2ay
         DvEVELtIYGdptg+H12N2n5xx4P+evekX+4RnX2YOtebn6yB94Yom9w/DI1nPdkiXuO1b
         05WXaaJA2wrgwDgoGRqeDpmYHNCNnIIrWx70mihFDuOhnqiLK7i4k9XolM1/YgvcX8sL
         Be5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724929534; x=1725534334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IMpDPXDzGDzNLDUQoG0T+dbS2HtKvxhLaW4H3a0SWA=;
        b=wMpw71lSLsuOYoOKMXiC4zZ678Wp8R8RcAHbpWOYc/68DSzybZz0+h/wzwQTwLl7E8
         ew2Q9SUfNpEOCPncyriXGnHIz1+mLcffPm/GhOits1yFpxSCR1llMGFi/fB+6zLxORvn
         gOeiJutKJta+wCD6KOqOu41goFMlm5692zyrFTRitscdra0Hc42oQiM/0WnjIWOGMOAA
         6QwhiNt+yvUeOvWIhQh395RZ8xzYHVIiUHUSYA4Dv2HIklalg1w76bFk5Dv6sbg9HHb6
         UebuuYQqgCr41w7yMPmLpRxVTLo2BtBopAeuqq9vT9Zem4ZYPZfD1F44n3VIQMCip3h/
         OgXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtfB61m+f+Ikh6sSUBx+tBGUlfF2Jlhf2DwsM0DnoskANnNP/sYsZR12hzgI+rzMWk565CSrFFOItk@vger.kernel.org, AJvYcCWMK295C7i+CKFV8JbE4+B8Ik4vx+lNc52i8efnWEXUA8yZD6JuZoVeerYsSHHMbz3Axkb0uMHzu3sdg9oZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyKioKMiRf3QGF4H7Myg4y3rxNRVIVANhI5MW8h39UTp3yznYse
	12ZDsyRo+qvY0FrAC9CplAPM2H8T/jRtU/QlPxEMg0hNoRei0zscmkU9K6dgw5A=
X-Google-Smtp-Source: AGHT+IFYAL99M0w1KDBpEHhep4dtC4BZqLVTkjCxoeojjokRbvlVxXXPnm1VO8JCrwFH6dbpOIGYzQ==
X-Received: by 2002:a05:6e02:4b2:b0:39d:4c8a:370d with SMTP id e9e14a558f8ab-39f37837f5fmr24973345ab.18.1724929534467;
        Thu, 29 Aug 2024 04:05:34 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e5576cc7sm906671b3a.32.2024.08.29.04.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:05:34 -0700 (PDT)
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
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH RESEND 3/3] irqchip/apple-aic: Add a new "Global fast IPIs only" feature level
Date: Thu, 29 Aug 2024 19:02:17 +0800
Message-ID: <20240829110436.46052-4-towinchenmi@gmail.com>
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

Starting with the A11 (T8015) SoC, Apple began using arm64 sysregs for
fast IPIs. However, on A11, there is no such things as "Local" fast IPIs,
as the SYS_IMP_APL_IPI_RR_LOCAL_EL1 register does not seem to exist.

Add a new feature level, used by the compatible "apple,t8015-aic",
controlled by a static branch key named use_local_fast_ipi. When
use_fast_ipi is true and use_local_fast_ipi is false, fast IPIs are used
but all IPIs goes through the register SYS_IMP_APL_IPI_RR_GLOBAL_EL1, as
"global" IPIs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/irqchip/irq-apple-aic.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 626aaeafa96c..1640074af2e1 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -236,6 +236,8 @@ enum fiq_hwirq {
 
 /* True if UNCORE/UNCORE2 and Sn_... IPI registers are present and used (A11+) */
 static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
+/* True if SYS_IMP_APL_IPI_RR_LOCAL_EL1 exists (M1+) */
+static DEFINE_STATIC_KEY_TRUE(use_local_fast_ipi);
 
 struct aic_info {
 	int version;
@@ -253,6 +255,7 @@ struct aic_info {
 
 	/* Features */
 	bool fast_ipi;
+	bool local_fast_ipi;
 };
 
 static const struct aic_info aic1_info __initconst = {
@@ -271,6 +274,16 @@ static const struct aic_info aic1_fipi_info __initconst = {
 	.fast_ipi	= true,
 };
 
+static const struct aic_info aic1_local_fipi_info __initconst = {
+	.version	= 1,
+
+	.event		= AIC_EVENT,
+	.target_cpu	= AIC_TARGET_CPU,
+
+	.fast_ipi	= true,
+	.local_fast_ipi = true,
+};
+
 static const struct aic_info aic2_info __initconst = {
 	.version	= 2,
 
@@ -282,6 +295,10 @@ static const struct aic_info aic2_info __initconst = {
 static const struct of_device_id aic_info_match[] = {
 	{
 		.compatible = "apple,t8103-aic",
+		.data = &aic1_local_fipi_info,
+	},
+	{
+		.compatible = "apple,t8015-aic",
 		.data = &aic1_fipi_info,
 	},
 	{
@@ -748,7 +765,8 @@ static void aic_ipi_send_fast(int cpu)
 	u64 cluster = MPIDR_CLUSTER(mpidr);
 	u64 idx = MPIDR_CPU(mpidr);
 
-	if (MPIDR_CLUSTER(my_mpidr) == cluster)
+	if (static_branch_likely(&use_local_fast_ipi) &&
+	    MPIDR_CLUSTER(my_mpidr) == cluster)
 		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx),
 			       SYS_IMP_APL_IPI_RR_LOCAL_EL1);
 	else
@@ -992,6 +1010,11 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	else
 		static_branch_disable(&use_fast_ipi);
 
+	if (irqc->info.local_fast_ipi)
+		static_branch_enable(&use_local_fast_ipi);
+	else
+		static_branch_disable(&use_local_fast_ipi);
+
 	irqc->info.die_stride = off - start_off;
 
 	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
-- 
2.46.0


