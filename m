Return-Path: <linux-kernel+bounces-286698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92773951DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B87A1F221D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C6D1BA87F;
	Wed, 14 Aug 2024 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="t+SPgvIy"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A91B4C5B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647424; cv=none; b=omc2T6riS0+ezQo1t/pObBhyRdbkPjjaSKJ2IngyiTPWKEmDEiaNQ7ec9N3lgi2hNbUVlKTDfG1MVxasxvq/Vo3/J2MTSI35A4aS0zdZ6tUQGOyt25+b6JxW71SndN3x8xmaZF8VVePNa4VpGXlpRCU/c/TjjSOxpyL2wqIfev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647424; c=relaxed/simple;
	bh=5pWcmcs4C4F2bDx2rFvnxrIHD+0/MF7FaV+eBwdogtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3u/MASliq9izsB/kB8TTlFuwYuxii6mYBHONsPJd8IZkyhIapqAim5YVstMnOIf0FhEOT4uUb/yjS+GqTAegSuxxlgcAPLRHOzSZ4c4zOCHHNw5pladnJJeAV08N2Gf3r1N8DegkJmzeLTgBPmpFypEVBWzQ7d7Gcl2p1uxXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=t+SPgvIy; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CD3024596D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723647417;
	bh=gWgIkbru9J14+uAT7SsXnPIjWj2SSXnesiQDy0WXkBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=t+SPgvIymmnM+VFNQySpGHBW4q4lHLyUAQiJfLZ/0vTnaRq/O2mrlh6o3/KrlE7n0
	 WgqEixP6yVxBlQVEzWZF0TPv+E1m4+qy+eEWe4lxUzF49+2Xjykusca7jJIKNsUnIl
	 tbWOdsnWZs60E7Y11qz6hsrQyw1f4BEoUqJzqXxh2HeL9+9A6xSpCkUakLDGBAWtQQ
	 MhQJ5SrciC5QMv6Wy9qo8YcdP5hRksCIuWVN8ncoE/PpnDDAi+1PP30E7unOCdVs8I
	 Wm3LJN+8dmcS87hVJJc349DzU3gKfoA56OK2M6bRXEnXBUxNmfZArnkwLrC+74h2ZT
	 vrOXdwjExaMqQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7aa5885be3so497160066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647412; x=1724252212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWgIkbru9J14+uAT7SsXnPIjWj2SSXnesiQDy0WXkBA=;
        b=pQLtEGuTQ3JVaAvKFGaZc2KBq797Bm0kh6+PyA6DY+lTmF+oAkEvVKC2ZBMcBHd6zQ
         WL4DWPLwqMJBtMbVmTAHg3omg/hR/IDu7BSVqP/mwrBDfbOWDr6rU6Cs7DPw0kB2cThs
         unaPncpZ4b85j+NI6Lv+BUWOC8FwhfZpkSD+f/9anUFjf3i0g3xZ2d/H8+bBAWmlKZSq
         zNNwiHnmq5eLHPMOiq03p3nOwAF9crz+WaPkTCz+8kB0UAd8+B1XlZWyvLjjD5+lyFJs
         d0ISIJ8q7fAm01gxOUtxZbHANyUSCSuip+91EGuJTKp+Mbcs15oVvRmUg23hcVIsiLdY
         nqyQ==
X-Gm-Message-State: AOJu0YwbQIzypxYDLPUVscU8WMmwpeTjyR0O1lYuSwsSDdQLMKqn557m
	6YwHd1m1fPII6aElGqCuMh9dwTvBRSZDMEMr/Q0UcaWEi8QXZe4VvsvjDolUT5Z+FLNUSfRLuSp
	YEq92F2HGS3vvtdIyHv+XwCCHZAkJT1uQyqeYFl/PGKZjpY+kzbbyKUnzqYaDfxsefGj/g6xwck
	JaH8EaEWnPzA==
X-Received: by 2002:a17:907:e211:b0:a7d:edb2:21f5 with SMTP id a640c23a62f3a-a8366c30b5bmr210882966b.12.1723647411981;
        Wed, 14 Aug 2024 07:56:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh6y5MIdajZhV+9ZDD5gd/Pe4FLfBYyKgl9kFrMLGCKwzpnlebrJ2F89sA/4+Bqhck6YeZgQ==
X-Received: by 2002:a17:907:e211:b0:a7d:edb2:21f5 with SMTP id a640c23a62f3a-a8366c30b5bmr210879766b.12.1723647411267;
        Wed, 14 Aug 2024 07:56:51 -0700 (PDT)
Received: from stitch.. ([2a01:4262:1ab:c:bbf4:eba3:898f:7501])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411bdcbsm182316866b.105.2024.08.14.07.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:56:50 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Anup Patel <apatel@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v1 8/9] Revert "irqchip/sifive-plic: Use dev_xyz() in-place of pr_xyz()"
Date: Wed, 14 Aug 2024 16:56:40 +0200
Message-ID: <20240814145642.344485-9-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 25d862e183d4efeb5e8b9843d783c90aaae4b14a.

This is a prerequisite to reverting the patch converting the PLIC into a
platform driver. Unfortunately this breaks booting the Allwinner D1 SoC.

Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/irqchip/irq-sifive-plic.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 7cf06bbb3098..ac274e1166c3 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 SiFive
  * Copyright (C) 2018 Christoph Hellwig
  */
+#define pr_fmt(fmt) "plic: " fmt
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -376,10 +377,9 @@ static void plic_handle_irq(struct irq_desc *desc)
 	while ((hwirq = readl(claim))) {
 		int err = generic_handle_domain_irq(handler->priv->irqdomain,
 						    hwirq);
-		if (unlikely(err)) {
-			dev_warn_ratelimited(handler->priv->dev,
-					     "can't find mapping for hwirq %lu\n", hwirq);
-		}
+		if (unlikely(err))
+			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
+					hwirq);
 	}
 
 	chained_irq_exit(chip, desc);
@@ -407,7 +407,7 @@ static int plic_starting_cpu(unsigned int cpu)
 		enable_percpu_irq(plic_parent_irq,
 				  irq_get_trigger_type(plic_parent_irq));
 	else
-		dev_warn(handler->priv->dev, "cpu%d: parent irq not available\n", cpu);
+		pr_warn("cpu%d: parent irq not available\n", cpu);
 	plic_set_threshold(handler, PLIC_ENABLE_THRESHOLD);
 
 	return 0;
@@ -483,7 +483,7 @@ static int plic_probe(struct platform_device *pdev)
 		unsigned long hartid;
 
 		if (of_irq_parse_one(to_of_node(dev->fwnode), i, &parent)) {
-			dev_err(dev, "failed to parse parent for context %d.\n", i);
+			pr_err("failed to parse parent for context %d.\n", i);
 			continue;
 		}
 
@@ -506,13 +506,13 @@ static int plic_probe(struct platform_device *pdev)
 
 		error = riscv_of_parent_hartid(parent.np, &hartid);
 		if (error < 0) {
-			dev_warn(dev, "failed to parse hart ID for context %d.\n", i);
+			pr_warn("failed to parse hart ID for context %d.\n", i);
 			continue;
 		}
 
 		cpu = riscv_hartid_to_cpuid(hartid);
 		if (cpu < 0) {
-			dev_warn(dev, "Invalid cpuid for context %d\n", i);
+			pr_warn("Invalid cpuid for context %d\n", i);
 			continue;
 		}
 
@@ -531,7 +531,7 @@ static int plic_probe(struct platform_device *pdev)
 		 */
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		if (handler->present) {
-			dev_warn(dev, "handler already present for context %d.\n", i);
+			pr_warn("handler already present for context %d.\n", i);
 			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
 			goto done;
 		}
@@ -581,8 +581,8 @@ static int plic_probe(struct platform_device *pdev)
 		}
 	}
 
-	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
-		 nr_irqs, nr_handlers, nr_contexts);
+	pr_info("%pOFP: mapped %d interrupts with %d handlers for %d contexts.\n",
+		to_of_node(dev->fwnode), nr_irqs, nr_handlers, nr_contexts);
 	return 0;
 
 out_free_enable_reg:
-- 
2.43.0


