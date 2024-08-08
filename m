Return-Path: <linux-kernel+bounces-279079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAF794B8B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8181C242A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E1C1891D4;
	Thu,  8 Aug 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QkfdTxoV"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D8162A02
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104860; cv=none; b=RiL/fHgyXA1b1gdjv/GOV7cwXOoeLUbcSJRByBQACkZ7X38/DyBx8JmdBZW4SGzihseptPBZQwQGjx+JB/lLy4ezTLM2lbfFVRxhYl+c7aakQqsoxpskdDl+zVavFj+k/hsBnsDvaV31zfvUjH80Txo6sl/IMJNdnkk+ZeMMjN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104860; c=relaxed/simple;
	bh=tY6bbfFt9kbUHGhmllp9mAmE0haYFgF41fV6r5dPbVg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NIRBgK7DN85rQrUEZPwbIRWipkGNpr23bf9aseMWvSYOfP1AsCiOnGX7KNv1qxga1oCdBB1HI03QGjKuuE/1yJQP1PxsGqeqBgq2TYH7X0/G5k6Yd5i5ztPC4wmumZylhQWInwlM3fqTEQl/E2OQ10hot19LctCVKei5adxumF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QkfdTxoV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd65aaac27so12493505ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 01:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723104857; x=1723709657; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L06iRpcXp4wDOtq52LfqR0JCUA0KWw53oMcDFbT/jsk=;
        b=QkfdTxoVui6Z59wHQi/8MjPRUnanj67nhpA7dpQX+IDgBX5SRfUN6r7MW6lXphLzYM
         kEvVQjyKP7grsRhkeZIvhaEARlt0Vod5RfTd641i9xoHsvopMiHGUimYgLjkjqxGBn0v
         9dhnU/XS+bSV9Zyq3FIJ7ju1RLaL4RXXcCI+qHtb8eMxK/O9IHHzjXd0Q9YIXTIYiUYo
         CWpwq/dK/hNTQ2h8liNIMaRpNGtNx9FK4lKIuMc/bSXIbc7Z205jKxTxkGFm4l7AWHub
         HAlxj1owci29X5TwQyIT0y3pUUpyXdNsa/flI11FNCIbdcrcvNrMKYcqsz7YPRdTtXZs
         yYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723104857; x=1723709657;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L06iRpcXp4wDOtq52LfqR0JCUA0KWw53oMcDFbT/jsk=;
        b=txvXcLh1M2QrQeh9acuVtmSFJHps11LMsTT+/OAKfqJT2VRz3YUswmi+h7HqLaSokD
         ulNxbGWMsMhqDpc2UG5/gPg66SCIDLILe/SAS+Ahu4YOQIaK5E4K1zvAfklDd7T9V8HM
         idA73x53NwlP1paChrStv3ckZEg8wlA7ocITeIB/N4yPfKioBM3T/KeWrB2oXi0Ch+5R
         0bKG08As2V3/2QSVAM9Rl0+42xMVHUnFHq72c/Cl/HaZ2n+rejrkIZtKnYoRum1SlGYO
         k97AIJ+JVnmQ1XDVqqag8GC31hgCSubSGR4Byw6v33WWy+0fUxf5MWIlCdLBO4c+fiQ1
         bpew==
X-Gm-Message-State: AOJu0YzrujaYlWUxRA8Iug/P5fxsmT7ozNrcA9rjwjCOrf37AXSLvKi1
	iAWdBmPSohanepJx3+fEP1oLYua3Q2QnwSZI6R87DWMp7T9nTB+pbQYc+RkqYZ8FoALL2ktQPCM
	oQK/B+PIG3IjW59bmqserpdXZljnAdaKH3uSikj1CBTjWnOOP+/FHpMwOUHH4/Ebr1kG2003qHY
	w839kAuyxltf0WY59MhubEHeysiZS4w3mtYp4WF3WLFe9fNvdFHP3pYw==
X-Google-Smtp-Source: AGHT+IExV3OPKIR8JzFCixCb8ACKBz3qNOqbDKw7Xw+FuNSf4ZKD+4Q38oowFAWILoK8vzCKRreVZA==
X-Received: by 2002:a17:902:e5c3:b0:1f2:fcc0:66f with SMTP id d9443c01a7336-20096d523d5mr16005225ad.31.1723104857346;
        Thu, 08 Aug 2024 01:14:17 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592b65c5sm118803795ad.292.2024.08.08.01.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 01:14:17 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 1/1] riscv-aplic: manually set pending for the pre-existing interrupts
Date: Thu,  8 Aug 2024 16:14:11 +0800
Message-Id: <20240808081412.24553-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The section 4.5.2 of the RISC-V AIA specification says that any write
to a sourcecfg register of an APLIC might (or might not) cause the
corresponding interrupt-pending bit to be set to one if the rectified
input value is high (= 1) under the new source mode.

If an interrupt is asserted before the driver configs its interrupt
type to APLIC, it's pending bit will not be set except a relevant
write to a setip or setipnum register. When we write the interrupt
type to sourcecfg register, if the APLIC device doesn't check and
update the pending bit, the interrupt might never becomes pending.

For the level interrupts forwarded by MSI, we can manually set the
pending bit if the interrupts have been asserted before the interrupt
type configuration.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Vincent Chen <vincent.chen@sifive.com>
---
 drivers/irqchip/irq-riscv-aplic-main.c |  4 ++++
 drivers/irqchip/irq-riscv-aplic-main.h |  1 +
 drivers/irqchip/irq-riscv-aplic-msi.c  | 17 +++++++++++------
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index 28dd175b5764..46c44d96123c 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -58,6 +58,10 @@ int aplic_irq_set_type(struct irq_data *d, unsigned int type)
 	sourcecfg += (d->hwirq - 1) * sizeof(u32);
 	writel(val, sourcecfg);
 
+	/* manually set pending for the asserting interrupts */
+	if (!priv->nr_idcs)
+		aplic_retrigger_asserting_irq(d);
+
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq-riscv-aplic-main.h
index 4393927d8c80..c2be66f379b1 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.h
+++ b/drivers/irqchip/irq-riscv-aplic-main.h
@@ -34,6 +34,7 @@ struct aplic_priv {
 
 void aplic_irq_unmask(struct irq_data *d);
 void aplic_irq_mask(struct irq_data *d);
+void aplic_retrigger_asserting_irq(struct irq_data *d);
 int aplic_irq_set_type(struct irq_data *d, unsigned int type);
 int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
 			      unsigned long *hwirq, unsigned int *type);
diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index 028444af48bd..eaf4d730a49a 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -32,15 +32,10 @@ static void aplic_msi_irq_unmask(struct irq_data *d)
 	aplic_irq_unmask(d);
 }
 
-static void aplic_msi_irq_eoi(struct irq_data *d)
+void aplic_retrigger_asserting_irq(struct irq_data *d)
 {
 	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
 
-	/*
-	 * EOI handling is required only for level-triggered interrupts
-	 * when APLIC is in MSI mode.
-	 */
-
 	switch (irqd_get_trigger_type(d)) {
 	case IRQ_TYPE_LEVEL_LOW:
 	case IRQ_TYPE_LEVEL_HIGH:
@@ -59,6 +54,16 @@ static void aplic_msi_irq_eoi(struct irq_data *d)
 	}
 }
 
+static void aplic_msi_irq_eoi(struct irq_data *d)
+{
+	/*
+	 * EOI handling is required only for level-triggered interrupts
+	 * when APLIC is in MSI mode.
+	 */
+
+	aplic_retrigger_asserting_irq(d);
+}
+
 static void aplic_msi_write_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	unsigned int group_index, hart_index, guest_index, val;
-- 
2.17.1


