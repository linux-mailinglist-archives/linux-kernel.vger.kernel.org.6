Return-Path: <linux-kernel+bounces-544224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B38BCA4DF09
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE5F3A6360
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A16204090;
	Tue,  4 Mar 2025 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zRI6tJ5O"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBA02040A8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094303; cv=none; b=AFeWKcG8lS1qby6NGR/uDhDR3zsgI/KwsEfqq84qZknJfozknwPY9iXXvb6N2R9Yyy/4cWNl4u+t884jgg9Jl83XpoGtu5uGvGrjFpwjEOTPMsQ0qcCrg9wFkUw10Zk4pCV88/XiA0OiIdWDT0QTTGLfEXnlAzUudJqtnziMjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094303; c=relaxed/simple;
	bh=Eqt5zR/YJ5b+Wj94wvEYhKqOmg1PAbLn7HBDDtiqXYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IkqvtTcp7vfMlzu6OUkGEtIyJvUgD4nP9aNItjTK51jJwMcnwmUk6E83M9/I/uzdoaNWPrQiOiDay0KyCLXoC4DdDk18lQmZbMzp4DTTwZT0o2pLQ8udu2Ni21yQGLdhjcFQ9UFx+2SF1X1G8iURyL4Q9wKEGS0kp97QDs4i+WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zRI6tJ5O; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bbb440520so25033285e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741094299; x=1741699099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MW5kUntubaDIQWagA8yaVJ6BvgFmQoLHNp/d0jaynvw=;
        b=zRI6tJ5OorvHsH+0wIorEfWcy3iaIfVdykzQG3DYWgcvwBxZcoCT/vTE6cV1/fs2mo
         dZJuV3q3FWV5sMMTEvJuMBIhrT6jq8LDAPs0jAOkF+x2jsU7L+7bdVLOTaYdPjNcNoqb
         Kcczfh3XIBeSaH5rfsRtRUY+chqnHDYnIgmkQhV9PfmPNiR8jwEoyxKjSLrfF+mcTL1l
         RAJ0ZEeK/oVnN9Fyglwa5CrA1NtMgnUdczUjHghPt51M9SazOpMV+52wAzSV6CLGSQ2I
         7zITX1Kmnq+fEvVfwB0+uN3V6+WVynh8V7Hdzzcv1kGvyFQIih2M92SaTOME8hGxH9Vh
         XBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741094299; x=1741699099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MW5kUntubaDIQWagA8yaVJ6BvgFmQoLHNp/d0jaynvw=;
        b=vKT1NnwE72wCxSKjd09cPNkxPPmGZ0jfiIeZQqqUFDw1Lhjg65tstsMrIgTpOBgu/v
         KB3oRtGsqIkFm4qxdgqvw+Rs+fndKHpk85qb4KQ94+RftjqlcdD1MPwMHkUvstYAvs6q
         yirMdMsYIst0y7+bjFC0Ye0OnxTcSBZQzd+dbf4Il38wzyOdJdVqxziTzbf9ODJYeQY6
         sq5QCmF3vyPF8U+/Q7OcvCRge6uJxdqaRqoeiuB2QLZwH+li6+cMQ9uNo2q1mgO6lnnr
         RpcukEdK/cF20CosxGSSQyYSXmVNeYtMJvvbpJxHADcYCMC3DB3zlETpRX488g+eoPqN
         /BAA==
X-Forwarded-Encrypted: i=1; AJvYcCU5bzZ4WrtrcffaUWTFDDtqC9d55j5TL41ZDgaJXaWz4zJOc3bjCTYqICpx9q72IOACqKrq6b+5NYs7A9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuliWhTQ5mNrFufVOXlOk839CrgSzDjfeMIqPHaPJimpJDLS1a
	T8nHWZnyS2p7vNaLltKDZQDutpiHKu6nZCcgpvZWh+szpxhbNOEYOp/tRaPEhWc=
X-Gm-Gg: ASbGnctMplUP29os8e9PYV6CO1FjDP8JymNxzmRJa+bqPRF4iv/v5fYYI9giXrhf5qv
	zKyxUhNFBRVneGCafWcaRnSy0IRgdNTquao1xGgDFaxDBe9/viJE22A7yU/rct8BvER+/cj4C4p
	t68yhDMgvRTvfOxvWaTX0qUJmkP5IChZpoHgkdf7F4Vv6PxYJowrwvo/f/9EIdtOSGAV0mi978c
	7qlxyAhU1bct473OCeYSk6xA1qvPqbaoUgiUHbs0zVAjQ1I71PGkKsYdTaQmg6idUUMw+ljLD2Y
	xKutkWkdBwcqaXzM79N6wp9jUmFjCSpg9MYUOcebzBUm
X-Google-Smtp-Source: AGHT+IF2PB3JIwFkQ/IoI14wzgDJzP7fz9S7sdWqpHpbFlU2+2ElCaz504decofi9DRWSmcB7J4Qiw==
X-Received: by 2002:a05:600c:4182:b0:43b:ce36:756e with SMTP id 5b1f17b1804b1-43bce3676dbmr16293955e9.12.1741094299293;
        Tue, 04 Mar 2025 05:18:19 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6018:7257:350d:e85e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bad347823sm144931545e9.0.2025.03.04.05.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:18:18 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Russell King <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] irqchip: davinci-cp-intc: remove public header
Date: Tue,  4 Mar 2025 14:18:14 +0100
Message-ID: <20250304131815.86549-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no more users of irq-davinci-cp-intc.h (da830.c doesn't use
any of its symbols). Remove the header and make the driver stop using the
config structure.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm/mach-davinci/da830.c               |  1 -
 drivers/irqchip/irq-davinci-cp-intc.c       | 31 ++++++++-------------
 include/linux/irqchip/irq-davinci-cp-intc.h | 25 -----------------
 3 files changed, 12 insertions(+), 45 deletions(-)
 delete mode 100644 include/linux/irqchip/irq-davinci-cp-intc.h

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 2e497745b624..a044ea5cb4f1 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -11,7 +11,6 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/irqchip/irq-davinci-cp-intc.h>
 
 #include <clocksource/timer-davinci.h>
 
diff --git a/drivers/irqchip/irq-davinci-cp-intc.c b/drivers/irqchip/irq-davinci-cp-intc.c
index f4f8e9fadbbf..42224ca43d5e 100644
--- a/drivers/irqchip/irq-davinci-cp-intc.c
+++ b/drivers/irqchip/irq-davinci-cp-intc.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
-#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -155,23 +154,21 @@ static const struct irq_domain_ops davinci_cp_intc_irq_domain_ops = {
 };
 
 static int __init
-davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
+davinci_cp_intc_do_init(struct resource *res, unsigned int num_irqs,
 			struct device_node *node)
 {
-	unsigned int num_regs = BITS_TO_LONGS(config->num_irqs);
+	unsigned int num_regs = BITS_TO_LONGS(num_irqs);
 	int offset, irq_base;
 	void __iomem *req;
 
-	req = request_mem_region(config->reg.start,
-				 resource_size(&config->reg),
+	req = request_mem_region(res->start, resource_size(res),
 				 "davinci-cp-intc");
 	if (!req) {
 		pr_err("%s: register range busy\n", __func__);
 		return -EBUSY;
 	}
 
-	davinci_cp_intc_base = ioremap(config->reg.start,
-				       resource_size(&config->reg));
+	davinci_cp_intc_base = ioremap(res->start, resource_size(res));
 	if (!davinci_cp_intc_base) {
 		pr_err("%s: unable to ioremap register range\n", __func__);
 		return -EINVAL;
@@ -200,12 +197,12 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET);
 
 	/* Default all priorities to channel 7. */
-	num_regs = (config->num_irqs + 3) >> 2;	/* 4 channels per register */
+	num_regs = (num_irqs + 3) >> 2; /* 4 channels per register */
 	for (offset = 0; offset < num_regs; offset++)
 		davinci_cp_intc_write(0x07070707,
 			DAVINCI_CP_INTC_CHAN_MAP(offset));
 
-	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
+	irq_base = irq_alloc_descs(-1, 0, num_irqs, 0);
 	if (irq_base < 0) {
 		pr_err("%s: unable to allocate interrupt descriptors: %d\n",
 		       __func__, irq_base);
@@ -213,7 +210,7 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 	}
 
 	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
-					node, config->num_irqs, irq_base, 0,
+					node, num_irqs, irq_base, 0,
 					&davinci_cp_intc_irq_domain_ops, NULL);
 
 	if (!davinci_cp_intc_irq_domain) {
@@ -229,31 +226,27 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 	return 0;
 }
 
-int __init davinci_cp_intc_init(const struct davinci_cp_intc_config *config)
-{
-	return davinci_cp_intc_do_init(config, NULL);
-}
-
 static int __init davinci_cp_intc_of_init(struct device_node *node,
 					  struct device_node *parent)
 {
-	struct davinci_cp_intc_config config = { };
+	unsigned int num_irqs;
+	struct resource res;
 	int ret;
 
-	ret = of_address_to_resource(node, 0, &config.reg);
+	ret = of_address_to_resource(node, 0, &res);
 	if (ret) {
 		pr_err("%s: unable to get the register range from device-tree\n",
 		       __func__);
 		return ret;
 	}
 
-	ret = of_property_read_u32(node, "ti,intc-size", &config.num_irqs);
+	ret = of_property_read_u32(node, "ti,intc-size", &num_irqs);
 	if (ret) {
 		pr_err("%s: unable to read the 'ti,intc-size' property\n",
 		       __func__);
 		return ret;
 	}
 
-	return davinci_cp_intc_do_init(&config, node);
+	return davinci_cp_intc_do_init(&res, num_irqs, node);
 }
 IRQCHIP_DECLARE(cp_intc, "ti,cp-intc", davinci_cp_intc_of_init);
diff --git a/include/linux/irqchip/irq-davinci-cp-intc.h b/include/linux/irqchip/irq-davinci-cp-intc.h
deleted file mode 100644
index 8d71ed5b5a61..000000000000
--- a/include/linux/irqchip/irq-davinci-cp-intc.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2019 Texas Instruments
- */
-
-#ifndef _LINUX_IRQ_DAVINCI_CP_INTC_
-#define _LINUX_IRQ_DAVINCI_CP_INTC_
-
-#include <linux/ioport.h>
-
-/**
- * struct davinci_cp_intc_config - configuration data for davinci-cp-intc
- *                                 driver.
- *
- * @reg: register range to map
- * @num_irqs: number of HW interrupts supported by the controller
- */
-struct davinci_cp_intc_config {
-	struct resource reg;
-	unsigned int num_irqs;
-};
-
-int davinci_cp_intc_init(const struct davinci_cp_intc_config *config);
-
-#endif /* _LINUX_IRQ_DAVINCI_CP_INTC_ */
-- 
2.45.2


