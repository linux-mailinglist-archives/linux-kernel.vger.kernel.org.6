Return-Path: <linux-kernel+bounces-310078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A919A967484
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 05:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D81B1F21F21
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 03:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F0F3DBBF;
	Sun,  1 Sep 2024 03:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itg8iIy0"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA092BAE2;
	Sun,  1 Sep 2024 03:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725162169; cv=none; b=aGInCX8MKrwiqQSeWYOgnFK6A6b7QKxc1vPthrl7Xzi02lf+P84US0QOVYAw3AhVStUI3kXKAwq1hKm0SzOxGB+uno24U7jCPLHSBJpfFIzli1uBaAJk4vZD2dkILBodeUOqseJ+vYOpC29W8zxpVdPCXFf+khVwUKgUIv/y/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725162169; c=relaxed/simple;
	bh=NO2N9/KhoJcrA+Vj6BknOwBwT+s8n97n7WgqObtyrfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx26tA4y4vqZqpwo3vXkHFE52hiTPuVg97EQg4WrAEVv8Bgr1sT095c7GvjRS+W4chXyLFINEbddFnXMFgC68eiSzLo24pAD9xH7il/eaF/j4+t9aPBWIHVIumZOoI4HDsJKfigzY6djL/FbyHphlsBfGeK6gExYEfMHxsj+CbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itg8iIy0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-716609a0e2bso1833470b3a.0;
        Sat, 31 Aug 2024 20:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725162167; x=1725766967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8P/VLH/bkCVi0Kmx8/pRYs60oDjzwE57I92YjRqe88o=;
        b=itg8iIy0x7HBssGyM/oilhwwBylATlq8iWqmAPi6FvVn29jiZHcGgmnNmpwQUCP/bD
         toOMhEFeSkBigsaunjoqKYyBGk3qRutAJ7YITOmpGYcmhTmrKqFOdcLoyV6M0c/dTE1g
         JOlisbzwS2zX9rYJnLvKxZ7iDnijfrSOLBUUJVpDkFmbH0DndZekDSYvhsbHSZqVUYOH
         2wjUz8o4IxJa2rzjbanicKnOnI8WMML1+EyxdQBsLw0jSVhgjA/kVH78RfZPPhwO3XdR
         3wKhYw0Is/kX9O4Zi1RVh2O58QXiDaj1vB/yIMwLN31L28SjBlt7S5MI1aGLbDEDaFi0
         IFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725162167; x=1725766967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8P/VLH/bkCVi0Kmx8/pRYs60oDjzwE57I92YjRqe88o=;
        b=YhwNZbhnYSYEtHt17K6Tvk60SI0TQKzJnd2Z4RKmwag6TY1esZqBxhnrh92mi1Jqku
         vzk+mhha6HU28Q82kbw8pINa2yzTqIXDPIsPX0XY7h7Afmc9ZxyACD/jZ/N7k1ffC4+2
         qARYDvY4KU+J81D/Qz0i2m30wCj2Cx23hYxtWzwlLn0EBr1Wp/TEwJd4/qmqDWRuvQVi
         ZXiiKw3hpJ1f5QMQPs4oUMiLm1kR4C8ipyQ+3kc5Eo7cAmgaWZK7GxB0vsTikr7zDIT6
         3FT1WVlQVDx4W46wsw/hKtMuQlJ3wQITLAHMJdVSPd0GroH/Y4mZZxNzvQpSqsm+9703
         T95Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCsZhW8WL86ET3vQ4DUgCbGIagffPviIsJ7tHLvnXF6fv52EKUs9ygR4gFWJ4gfvW69Rar6qDro61Exth9@vger.kernel.org, AJvYcCWWPOwN8qVsxY3wRVRdicnYTsGb30DO1RMbuTKUsVh6Un9ZK7iJIcJn3exDmMjVa1yToHO7G92/FzbI@vger.kernel.org
X-Gm-Message-State: AOJu0YyM8/MJl80QagJtuEvrgZNYZZt+DJ1Y+2gWp92ALuG7P7NMZNEC
	HvI1nNdPKoKz6c5OhO3XrbQ4ZuJUT83IF0kQppZCTMvsQYuTSE5h
X-Google-Smtp-Source: AGHT+IFhht1qKXBiPs9HIAzfuSOxGKr51cNM8GUgWfxyXslOI4NWrGfhD0H/m6YtWxDBqqE9Ki9wQA==
X-Received: by 2002:a05:6a00:928d:b0:706:5cd9:655d with SMTP id d2e1a72fcca58-715dfc3a4f1mr12316514b3a.22.1725162167046;
        Sat, 31 Aug 2024 20:42:47 -0700 (PDT)
Received: from localhost.localdomain ([49.130.72.113])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e55771ccsm4826767b3a.43.2024.08.31.20.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 20:42:46 -0700 (PDT)
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
Subject: [PATCH v3 3/4] irqchip/apple-aic: Add a new "Global fast IPIs only" feature level
Date: Sun,  1 Sep 2024 11:40:06 +0800
Message-ID: <20240901034143.12731-4-towinchenmi@gmail.com>
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

Starting with the A11 (T8015) SoC, Apple began using arm64 sysregs for
fast IPIs. However, on A11, there is no such things as "Local" fast IPIs,
as the SYS_IMP_APL_IPI_RR_LOCAL_EL1 register does not seem to exist.

Add a new feature level, used by the compatible "apple,t8015-aic",
controlled by a static branch key named use_local_fast_ipi. When
use_fast_ipi is true and use_local_fast_ipi is false, fast IPIs are used
but all IPIs goes through the register SYS_IMP_APL_IPI_RR_GLOBAL_EL1, as
"global" IPIs.

Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/irqchip/irq-apple-aic.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 8d81d5fb3c50..01a3c79054f5 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -235,6 +235,8 @@ enum fiq_hwirq {
 };
 
 static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
+/* True if SYS_IMP_APL_IPI_RR_LOCAL_EL1 exists for local fast IPIs (M1+) */
+static DEFINE_STATIC_KEY_TRUE(use_local_fast_ipi);
 
 struct aic_info {
 	int version;
@@ -252,6 +254,7 @@ struct aic_info {
 
 	/* Features */
 	bool fast_ipi;
+	bool local_fast_ipi;
 };
 
 static const struct aic_info aic1_info __initconst = {
@@ -270,17 +273,32 @@ static const struct aic_info aic1_fipi_info __initconst = {
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
 
 	.irq_cfg	= AIC2_IRQ_CFG,
 
 	.fast_ipi	= true,
+	.local_fast_ipi = true,
 };
 
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
@@ -750,7 +768,8 @@ static void aic_ipi_send_fast(int cpu)
 	u64 cluster = MPIDR_CLUSTER(mpidr);
 	u64 idx = MPIDR_CPU(mpidr);
 
-	if (MPIDR_CLUSTER(my_mpidr) == cluster)
+	if (static_branch_likely(&use_local_fast_ipi) &&
+	    MPIDR_CLUSTER(my_mpidr) == cluster)
 		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx),
 			       SYS_IMP_APL_IPI_RR_LOCAL_EL1);
 	else
@@ -990,6 +1009,9 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	if (!irqc->info.fast_ipi)
 		static_branch_disable(&use_fast_ipi);
 
+	if (!irqc->info.local_fast_ipi)
+		static_branch_disable(&use_local_fast_ipi);
+
 	irqc->info.die_stride = off - start_off;
 
 	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
-- 
2.46.0


