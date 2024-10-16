Return-Path: <linux-kernel+bounces-367340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F979A0123
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7995E1C220B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D0C18DF69;
	Wed, 16 Oct 2024 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="b/FJqPl6"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A118C92C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059195; cv=none; b=PzNlH+8tF33NLyklC2cfTrbVtvFQmMGMUjyOwkXP6ZqX6XaPrQE1JLkqCD7f7oNpYow6TREA9JMQ4gVNkJgqTgdZG/uPGHZIK+hHdPz/wJkQta5CmX+6xu8WQ1vQ67m4gi5d8B1ba5sXr6fn+Ods3VqHS+G5J8l0RyGR1PHsoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059195; c=relaxed/simple;
	bh=OeBIRXFLN6KyYLbclqAOLd5sE2xJ3+latuhKxT2j+XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZQdD26MkkGnYmN25d1tnSqFJ3WiSovqOfGWpQftYSTK0K6Y1cCXdouZE9dCQyHZcn7R0SlgeP71yobcPvnB0NicV8wmCtJKDeXTEoqmMFJg4rZJHobf7+PDCzUMsB2IXpqBp3ZSDVbU8cW1OcW4kv9u3Ii1uPfyLDOSmpvgMlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=b/FJqPl6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a14cb0147so354472366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729059191; x=1729663991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StS7Bd9wyPSpg655xcrWiCkyycmPYijDXix7NMpAQ1k=;
        b=b/FJqPl6K1IWQE42OR691In6DCDiSB+eLVmscdCFCHb+PCNzB9COJKBjalSkWYatfS
         Mx0UuyeQMGcbI4qwISia+Ll9hxTejVXSkB7ACFO5gdVOIRlhlcGmk1aiaUt0uPxGiM0e
         MmEiw3YCbl0GPNIGw+OcUsAjxOKLrAnUMRD5DbNOrNthvP1lfGZX5fbtBxZpyIiie0VM
         mzX6hx8weBVG8VWbF4KjkC2tr+m57oxU08B7Ejiascj9Mick2UOkZEd5n7mz1C4QaTS9
         PJ/Gf9qvbQxwLxK14pt2dbmXLpuj+1uNOf+wbaILybdDAz/jFj+SRd1rinhcs8Zpe0DP
         bQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729059191; x=1729663991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StS7Bd9wyPSpg655xcrWiCkyycmPYijDXix7NMpAQ1k=;
        b=XXJ7UFtG2jYpaI2/TOFg6AKzCCHLrEGErVvWd/B/R+hBa4MMc+t3+kDofjLpZNRwBq
         Xb0ztil/v1jKM5pJ7cIWIXQU2aVKtL98LHO1oSG/m20wiPoADfzCZFa9uN+pVsuZeUtD
         KLkb0nz5XyXvHYmk3vhEyysuISIvSPtwMMKiDLz88+IoCqfpNOXLDQlO/j9oRHNk6RcY
         pO7s5GGYlQ7nZeRK+PkITY4KM/pn9t5KiCKyzCTP8RFZxSObM3JqXRgWEAcpTt8NxCaz
         MWpNWpsSQJJ/R0mBvOIfhhDiQ4c5z+E/046QldkVFVPcVsZ4CaJKwEDy3SdMCQqkG3nf
         pVbg==
X-Forwarded-Encrypted: i=1; AJvYcCVC57YfOy9xJGn5PucD/TAOdi79gfoybajOUghc75GkWOo0Qk9WFd2luMYcZqOmnpJ9Rk5eWUFuY6EFUG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaOQX6EQZTINghnSbREEQjrpq5rmbFmWTjMksEjLY7IGAxsRlx
	zP+gCIFR4KMZ8aqYdKqUoWDdhn+kL4B5uS3lG4ryQXivHmgLw0NxBmAyt+sSfHI=
X-Google-Smtp-Source: AGHT+IFmR5oPcuSaLmdqQM+ujKJxxJ/XTNRbE8R9d0OwdjvSr2XYhYTzoakGgRMlb6bDJUr6CFH6IQ==
X-Received: by 2002:a17:907:9288:b0:a99:f167:47c7 with SMTP id a640c23a62f3a-a9a34e275a6mr221987266b.55.1729059191479;
        Tue, 15 Oct 2024 23:13:11 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 23:13:11 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 20/37] arm: gic-v3-its: Implement of_xlate
Date: Wed, 16 Oct 2024 08:04:06 +0200
Message-ID: <20241016060523.888804-21-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Translate IRQs by implementing of_xlate() as required by
irq_get_by_index() to parse interrupt properties.

Map DT interrupts to ARM GIC interrupts as follows:

- Interrupt numbers ID32-ID1019 are used for SPIs
- ID0-ID15 are used for SGIs
- ID16-ID31 are used for PPIs

TEST: Booted on qemu sbsa-ref that has a GICV3.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
Changelog v9:
- Require at least 3 interrupt-cells
- Map SPI interrupts to ID32+
- Map PPI interrupts to ID16+
---
 arch/arm/lib/gic-v3-its.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 22fa46a341..58f8bf864f 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -4,9 +4,11 @@
  */
 #include <cpu_func.h>
 #include <dm.h>
+#include <irq.h>
 #include <asm/gic.h>
 #include <asm/gic-v3.h>
 #include <asm/io.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
@@ -163,8 +165,30 @@ static const struct udevice_id gic_v3_ids[] = {
 	{}
 };
 
+static int arm_gic_v3_of_xlate(struct irq *irq, struct ofnode_phandle_args *args)
+{
+	if (args->args_count < 3) {
+		log_debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	if (args->args[0] == GIC_SPI)
+		irq->id = args->args[1] + 32;
+	else
+		irq->id = args->args[1] + 16;
+
+	irq->flags = args->args[2];
+
+	return 0;
+}
+
+static const struct irq_ops arm_gic_v3_ops = {
+	.of_xlate		=  arm_gic_v3_of_xlate,
+};
+
 U_BOOT_DRIVER(arm_gic_v3) = {
 	.name		= "gic-v3",
 	.id		= UCLASS_IRQ,
 	.of_match	= gic_v3_ids,
+	.ops		= &arm_gic_v3_ops,
 };
-- 
2.46.2


