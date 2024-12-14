Return-Path: <linux-kernel+bounces-446121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF99F2014
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C17161AFD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860791A8F7F;
	Sat, 14 Dec 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="U3eLcTQr"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65F19A2B0
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197201; cv=none; b=eA5XYUVA6GoB+ckWvAOJbb7AHgtLI8Qlx9yV7KKQnFBNNujH6cM6hU1rZyrNh1rYNblOLW0LWuIoSvqp4avf7RoRGbTnW4rq6mr6L6Kho1mFwj3VnaVKoyT2i6sxU06aUXwH8eq9laEmk9R0xZdMsi91yMizmgmnp2UUWggOxnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197201; c=relaxed/simple;
	bh=6PIAjGaZKQwEt/EjBHyszo+wahqk5t1wsyFIUnbE8YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MW38z1lKng4u6Kycd2NIx7KNczT6kxo6aW4DKi0NGrPzewKGuINtIxfTPI7b4Mw3cjBTWzeHpYNcnvzChlu47zsUVbYfH/0r2b5YtZ7RD8Qgz5DK5Ppy/yIaeCOfasNKMlFTeyfN7Vzxm3tb6/Ls7Ww/ryNDYV84dUKOXM4pGQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=U3eLcTQr; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea8de14848so1566145a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734197199; x=1734801999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6payGCmGMW/0vjHgpi/115tsc+b1yXaj6IL2K0q/xw=;
        b=U3eLcTQrfxzBR1KNMvEpzH/0wtO8gw8YG/rRa3ohfJbxVNQk04+fD0L+hyNxMOxLS8
         850hysopa4gV//GGNVIHQLFQptWNWbsCHhKVfln97EF2i+atuzw6dvAmf4RQxbp/PlNE
         LW0wFrsXVC74dMxklcQxm7OSRp/96dlKG7R84qUOiyT9z5zDMbcI6kqlfnuSHT870E5U
         ma1DJewotlemKzovmjCQ/XDSbB1LG4VE4ZNDaqjEJ6v28OfUS5xTQD2amS398JtJl79E
         tYXRXerye1BLf38BUtv71uq2odJ10DOrvrieYv5ZcBlncRiabYWHp9sv2HwZIrZeoaDC
         awgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734197199; x=1734801999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6payGCmGMW/0vjHgpi/115tsc+b1yXaj6IL2K0q/xw=;
        b=XP+hK4FThf3ocDRIJFyebJkZr9Llak6bVl8kN/zm6+E0lIWUGzuMRq8VeqWHcp1MNj
         MIcaJ4ITFx/nCPV5/x6cBa0YRpCJV5q/oYCLC5AUrq7K13jiY09H1c7NY/hwPVM6Xvxv
         edZ7zteGlC2yDJa+bEDgyixNTxeNfq5WJjJlhG1qLU0eGfIJ5cXyW0ThX164UTAkNzDo
         2zpJrNcx+GkHKchTh4neplNUTHA8Y6+TusxEbbGP7+xkxZvoa+SHIrVWf/k5xwrPtUgG
         b8N/9GTkM2vttRZ31tWtTtWuBDklxnZFTmeccvWtXNYe9y9wtZsmFF37dQj3QjQRvABO
         QZ7w==
X-Forwarded-Encrypted: i=1; AJvYcCWsPld2PzGFPXxtfBTOTaqQ+5ByQb2Q2JEmmj7v6Bf5ca5KIdmyEWEDvgMcfJxI4molObz8VmwBVW1E/Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTVMFQPB17CJaK7D0GuK3dohm1xlMXQwj4iiXep45be7uaS/kX
	E9ZwYKGddCzxSVRsIjKijQK9o+iYEILSdP6/7j5TsxhKvWIf2YTzlUI2r7qdeOc=
X-Gm-Gg: ASbGncsdDMRIdlntDezHuj+usLkhDMStqTxPsxHGD02RMPsYnURoVv1k5x49zFK0PK6
	Fwb8lmuBGphqpLyeDLE8sORvLNaQG0J4L+JJKMIESq+8KQezhtobptIFJ/8yofrEwlZIh5EMQq7
	GGPB814R6E4YSjt7gPsHMF61kff3LD40er1rZbB5o/YKfOqrxAYpUsYUlfo1xG2jBYQPk07F3+7
	o0x/6N/SFTXgZgxgGrX+4Ed1nTN3nkuaCfhdYeuNOVihiA8c8qTHrm5CwwYU53wNrFdB+H5d3Tu
	drvDqUhjKed5+8o=
X-Google-Smtp-Source: AGHT+IE4G8tF4t4tobhDLydlOHpy74mKHnjdVddbrMVpE78sNcz73JzvON/bt8jZjW3R+eaoP7P0Vw==
X-Received: by 2002:a17:90b:2242:b0:2ee:ba0c:1726 with SMTP id 98e67ed59e1d1-2f2901b253dmr8940041a91.34.1734197199504;
        Sat, 14 Dec 2024 09:26:39 -0800 (PST)
Received: from localhost.localdomain ([223.185.132.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm5049811a91.41.2024.12.14.09.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 09:26:39 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 05/11] genirq: Introduce kconfig option GENERIC_PENDING_IRQ_CHIPFLAGS
Date: Sat, 14 Dec 2024 22:55:43 +0530
Message-ID: <20241214172549.8842-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241214172549.8842-1-apatel@ventanamicro.com>
References: <20241214172549.8842-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Introduce kconfig option GENERIC_PENDING_IRQ_CHIPFLAGS which allows
irq core to set IRQD_MOVE_PCNTXT flag based on IRQCHIP_MOVE_DEFERRED
flag.

This kconfig option will help architectures such as x86 and RISC-V
to mark top-level irqchip instances where irqs can't be moved in
the process context.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 include/linux/irq.h    | 10 ++++++++++
 kernel/irq/Kconfig     |  4 ++++
 kernel/irq/chip.c      | 39 ++++++++++++++++++++++++++++++++++++---
 kernel/irq/irqdomain.c |  1 +
 4 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index fa711f80957b..b689c8fe8d60 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -567,6 +567,7 @@ struct irq_chip {
  *                                    in the suspend path if they are in disabled state
  * IRQCHIP_AFFINITY_PRE_STARTUP:      Default affinity update before startup
  * IRQCHIP_IMMUTABLE:		      Don't ever change anything in this chip
+ * IRQCHIP_MOVE_DEFERRED:             Move the interrupt in actual interrupt context
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED			= (1 <<  0),
@@ -581,6 +582,7 @@ enum {
 	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	= (1 <<  9),
 	IRQCHIP_AFFINITY_PRE_STARTUP		= (1 << 10),
 	IRQCHIP_IMMUTABLE			= (1 << 11),
+	IRQCHIP_MOVE_DEFERRED			= (1 << 12),
 };
 
 #include <linux/irqdesc.h>
@@ -634,6 +636,14 @@ static inline void irq_move_masked_irq(struct irq_data *data) { }
 static inline void irq_force_complete_move(struct irq_desc *desc) { }
 #endif
 
+#if defined(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS)
+void irq_update_pcntxt_flag(unsigned int irq, const struct irq_chip *chip);
+#else
+static inline void irq_update_pcntxt_flag(unsigned int irq, const struct irq_chip *chip)
+{
+}
+#endif
+
 extern int no_irq_affinity;
 
 #ifdef CONFIG_HARDIRQS_SW_RESEND
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 529adb1f5859..6d85a47fbf41 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -31,6 +31,10 @@ config GENERIC_IRQ_EFFECTIVE_AFF_MASK
 config GENERIC_PENDING_IRQ
 	bool
 
+# Deduce delayed migration from top-level interrupt chip flags
+config GENERIC_PENDING_IRQ_CHIPFLAGS
+	bool
+
 # Support for generic irq migrating off cpu before the cpu is offline.
 config GENERIC_IRQ_MIGRATION
 	bool
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 271e9139de77..623959a24464 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -33,6 +33,33 @@ struct irqaction chained_action = {
 	.handler = bad_chained_irq,
 };
 
+#ifdef CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS
+static void __irq_update_pcntxt_flag(struct irq_desc *desc,
+				     const struct irq_chip *chip)
+{
+	if (chip) {
+		if (chip->flags & IRQCHIP_MOVE_DEFERRED)
+			irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
+		else
+			irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
+	}
+}
+
+void irq_update_pcntxt_flag(unsigned int irq, const struct irq_chip *chip)
+{
+	unsigned long flags;
+	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
+
+	__irq_update_pcntxt_flag(desc, chip);
+	irq_put_desc_unlock(desc, flags);
+}
+#else
+static inline void __irq_update_pcntxt_flag(struct irq_desc *desc,
+					    const struct irq_chip *chip)
+{
+}
+#endif
+
 /**
  *	irq_set_chip - set the irq chip for an irq
  *	@irq:	irq number
@@ -47,6 +74,7 @@ int irq_set_chip(unsigned int irq, const struct irq_chip *chip)
 		return -EINVAL;
 
 	desc->irq_data.chip = (struct irq_chip *)(chip ?: &no_irq_chip);
+	__irq_update_pcntxt_flag(desc, chip);
 	irq_put_desc_unlock(desc, flags);
 	/*
 	 * For !CONFIG_SPARSE_IRQ make the irq show up in
@@ -1114,16 +1142,21 @@ void irq_modify_status(unsigned int irq, unsigned long clr, unsigned long set)
 	trigger = irqd_get_trigger_type(&desc->irq_data);
 
 	irqd_clear(&desc->irq_data, IRQD_NO_BALANCING | IRQD_PER_CPU |
-		   IRQD_TRIGGER_MASK | IRQD_LEVEL | IRQD_MOVE_PCNTXT);
+		   IRQD_TRIGGER_MASK | IRQD_LEVEL);
 	if (irq_settings_has_no_balance_set(desc))
 		irqd_set(&desc->irq_data, IRQD_NO_BALANCING);
 	if (irq_settings_is_per_cpu(desc))
 		irqd_set(&desc->irq_data, IRQD_PER_CPU);
-	if (irq_settings_can_move_pcntxt(desc))
-		irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
 	if (irq_settings_is_level(desc))
 		irqd_set(&desc->irq_data, IRQD_LEVEL);
 
+	/* Keep this around until x86 is converted over */
+	if (!IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS)) {
+		irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
+		if (irq_settings_can_move_pcntxt(desc))
+			irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
+	}
+
 	tmp = irq_settings_get_trigger_mask(desc);
 	if (tmp != IRQ_TYPE_NONE)
 		trigger = tmp;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index ec6d8e72d980..ec5fc1d8cebe 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1508,6 +1508,7 @@ int irq_domain_set_hwirq_and_chip(struct irq_domain *domain, unsigned int virq,
 	irq_data->hwirq = hwirq;
 	irq_data->chip = (struct irq_chip *)(chip ? chip : &no_irq_chip);
 	irq_data->chip_data = chip_data;
+	irq_update_pcntxt_flag(virq, chip);
 
 	return 0;
 }
-- 
2.43.0


