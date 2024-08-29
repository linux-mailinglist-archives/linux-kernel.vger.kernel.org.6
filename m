Return-Path: <linux-kernel+bounces-306520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A848896400B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52FC91F219F9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C901118F2FE;
	Thu, 29 Aug 2024 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXeiLH94"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E5218E371;
	Thu, 29 Aug 2024 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923647; cv=none; b=d+6EFvf4JwJ5mICUVQpaHqHg8qEQtoEsA/SqU6P3jHAtgNU5nmfoLv7Vm5zThBERQq0Cp9oiG0uAmS9tMRsfB1U1DgNGkPfAiARlqHBh4M+bDG4Qe21LWI4RTnMqRsVID7q8Lx03IuHNkVOTJsIY7koTOSk63/tz3IzjGCyPahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923647; c=relaxed/simple;
	bh=F8sxoW9XyGEiKGmU0+ncsNzA7kTIPGiGyUdz0ED2O5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3eH6bPeKy3ZXZspArmoW/Ostr8HPcGuFZlOMmo8rLnS+O9xynZ6U2PgC9r7eYVtFixZy1H1MQqzYFePmufoLm5gq+OMVb/f+kINbp9ndNJG7L7KPWTtWvINWa0Z4qbszpzbTm+FrQ/H4dhLYgI8cC4U4ah/Igpb887/lqzCXmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXeiLH94; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201fba05363so3879025ad.3;
        Thu, 29 Aug 2024 02:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724923644; x=1725528444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ouhe0enBFjJUZqCtUzq8PmMdBjKDokZmZ4h8nJcgYbU=;
        b=bXeiLH94qeSucQEqlJCSnUxSr+nytBSKqGIBabrIfCA8KEl1tq14OK1JbsLB9owzQ2
         znTMUbLn3+LGK0itY0ch1mhYKkT8AV9KurVBy44sb89TDLUuAS/+SClqTofMkEy8iPhj
         1ilctZE4G4ieMfieqNxAaH/YIO2tET8oBNMT8hCf8dLFUr9ZdFXwXsLRwtHx0EM4IZJ7
         jZ8Uy5DS7Wpfo9dTlnl3e82EVd4H8KU5rPO5F1k4No4OLyRgr7scYqSbYso+DDnpbG/U
         6OyklJNJYx+yyhVlft4GyeSBOuQz8RQVO0Je+xKKa5Yxwc6qwKwvBx0RTgYxIQXMPpEy
         xzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923644; x=1725528444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ouhe0enBFjJUZqCtUzq8PmMdBjKDokZmZ4h8nJcgYbU=;
        b=GFZ5d8SkV7UwMpuHzbzAINaGNt5NDFxtFFiS37rzFSwFISN7tvxkVDsKhtCMldsGPG
         QW5hNjjywoyoeX2AdIlocqWc+JNnzu+IGVKw9psbbmvU04CeONGVrO868jDeytoLaZXl
         HwBeuOQqVOQuPqlpZMA92L2fE1+FvmQDU0Y8U75fkZy9bMHXWigxeMMv6cW3XlF8w3nD
         40LpgIzyzqYECjAIb0sAldt3bvutMjWEwjRQYN7nRBCUJ7emLYuATmZOOTQcXqFrcdNC
         sVbLmj0SZ4Fe34kT/l9gBiTXWvMuFx0MgIZuR1bbIa4N3nqhjyCq6ZNTgG07ti2nIkhr
         LZUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaxNM0sYtW2oEuB6kzl4xzxjha+J9NXjwd51mMl93oSyAIRvZseGbq+VJc4DUwbWEIc7Wq5E+QxdnK@vger.kernel.org, AJvYcCXEhDfv2QoEODCSfZf7exPCa5+rQiUdO1LTOg59FFojUNeEhgZnpo9n11BK6tIFxca16CzMprrL8U1/sC0C@vger.kernel.org
X-Gm-Message-State: AOJu0YwBqTVTfaTyQIPttUIl/G2zTEBaZxS2Exmn0K5jR1J3iTIhIgTU
	7WhvzYMn/Y0GTuFYD+eHtqfd6aQkFOxogdFrnRNJo99CjupHkmpl
X-Google-Smtp-Source: AGHT+IFrjUhQikLTv2qTwmStFWCrqusJSIZnC40sneETVUkJPqzLcvKuQheZLvCXJHwrdHmRDZZe5w==
X-Received: by 2002:a17:902:d584:b0:203:a0b4:3e28 with SMTP id d9443c01a7336-2050c377592mr23038675ad.27.1724923644039;
        Thu, 29 Aug 2024 02:27:24 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20515552b6dsm7469245ad.249.2024.08.29.02.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:27:23 -0700 (PDT)
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
Subject: [PATCH 3/3] irqchip/apple-aic: Add a new "Global fast IPIs only" feature level
Date: Thu, 29 Aug 2024 17:03:13 +0800
Message-ID: <20240829092610.89731-4-towinchenmi@gmail.com>
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
index 626aaeafa96c..9248ecff42a3 100644
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
+		MPIDR_CLUSTER(my_mpidr) == cluster)
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


