Return-Path: <linux-kernel+bounces-443676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E8A9EFAA3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69F2188350E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DC722913F;
	Thu, 12 Dec 2024 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWRYoT6I"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC46B240395
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026795; cv=none; b=gy5LjPDuYzBwBUDRuncpLLMLKBjDs7+q9B6AXaMOh3OLQvBOGZhxwjzEQQcj12l21qPqEKkXal9CMwUJFDItErl6jezd9qIP6ztGfGKtUeo3qfDfTxUg/enxR/OKtbvIcWDsfrx0aOYjIw+hNZZzCoFKx81pnvHGRf9Rg9mAxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026795; c=relaxed/simple;
	bh=qoHNVUntp7L8V1KYygYeM3r4gqUxbVbBZQoQ48yo1Fk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YhPaXbJSWIuH/MIEPL1hdraLEDxT9fNlyg9S92Yd+hr800Pv5Hnz82/OaHBHu3/jHx7DYAz2W3zQInBvdOwLf7+JaH8CaSk0kVTbYtkAP2gAOVyGtERZ8mXB2lkg6Em2Hux9n0DE/enjfcGq/u4SnauCdPgbGfBQGVdXmTbBWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sWRYoT6I; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434fb9646efso8355995e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026792; x=1734631592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LdunWCve+BzW7qxRXgQ2DWd6pqP346bXuKFqoUe0/0=;
        b=sWRYoT6I5F1mDr5fBWF6UvctjiEhYzRaP5TYy0V7LgJdao43qFsg1en1HadBceYpl0
         IsJsjLQn5oCdqo1JT0cdmpFDJCsXhccsoBcTFG24dpTuSHR26f5P6FAGXo5zVbrEbyNZ
         kbzw6DMdnWI6G0us3ZMaQwsBO5NfYkMjw7u5MWXC/md8X8SdaK6rrCaVuRcNtH5tnHEd
         6v887jQEZLKFwXJZ8uaJcPo1aLr8IPONUjxG/Yz3UmI3e+xQjvn9ctYIWOhiebW/LBUN
         OGKy2Oz1sebS9xKtCZr68Pnf6gBYR7rEHSyuslHCatgS07/ObAgpBOv81BSu1rA9pRyd
         phrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026792; x=1734631592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2LdunWCve+BzW7qxRXgQ2DWd6pqP346bXuKFqoUe0/0=;
        b=fNN0DUWKj8iKgI4GROsDX7Jj4WFjORxYA/sD3hz2L4/0Fok+OYLpBAWD8FgFdAN2go
         nO3M+zm0hOcVzxl9WpAiVAjxcZr9FRXaa4D9UsPXh5nY8MUL6nmG6ZPURj9nbTdJXskT
         PULqA2KjZTDiSHAC50FwaWCcj0pVFYL6DwgJAWUvzGsk2Kukmp9QK7Sru10MzhPb4fFH
         YHUN7HRocHhV/LoiSYWuCjd96AfTDzEpk6188i11mQUWa8N1ndURKyPwJ1DNVyH8WoGi
         2zN6QSZLF+oQG4o9PfthzytS2Jav9AavSxSOWp8lUTB+MZh7FCduqKH3Q7AHVXGalhfo
         7W9g==
X-Forwarded-Encrypted: i=1; AJvYcCVhoHwhK9Ars2m9SwWUgrexLoaEeAwda8nRBUFJFN++roRC7LqphuJHEdkUhLHwcQgVGZ4G8nXgpCOpnCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUGJlKXTvuI5pvFakAD9Pw1pFUxnXrHBckkM7jWajkooOWazx
	MPICpyuCr3LGP+qXcHi9pwZHJdiStG714Jbl1vSF6yLhTeeKwFuZXsxKb0UDXDwjv9plEiESx73
	hVFKLAem+Hw==
X-Google-Smtp-Source: AGHT+IERWZ4NnM7KQcPGdQG43bKrQYNR/UyZnwsqD34WfJRCP7KI0E4FIciOvn+bi06f/klghzOUEL4MFalBog==
X-Received: from wmqd1.prod.google.com ([2002:a05:600c:34c1:b0:434:fe2b:fea7])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5101:b0:434:ffb2:f9df with SMTP id 5b1f17b1804b1-4361c3a6550mr73450045e9.17.1734026792347;
 Thu, 12 Dec 2024 10:06:32 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:16 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-53-smostafa@google.com>
Subject: [RFC PATCH v2 52/58] iommu/arm-smmu-v3-kvm: Add IRQs for the driver
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Handle IRQs from the KVM kernel driver, it should be safe to do it
from the kernel as this a debug feature.

Only GERROR and EVTQ irqs are handled.
Unlike the kernel driver, we don't do much here (no rest in SMMU or
interaction of cmdq) but just printing.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c   |   3 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 138 ++++++++++++++++++
 2 files changed, 139 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
index 2a99873d980f..60f0760f49eb 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -365,7 +365,6 @@ static int smmu_init_registers(struct hyp_arm_smmu_v3_device *smmu)
 	      FIELD_PREP(CR1_QUEUE_IC, CR1_CACHE_WB);
 	writel_relaxed(val, smmu->base + ARM_SMMU_CR1);
 	writel_relaxed(CR2_PTM, smmu->base + ARM_SMMU_CR2);
-	writel_relaxed(0, smmu->base + ARM_SMMU_IRQ_CTRL);
 
 	val = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
 	old = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
@@ -540,7 +539,7 @@ static int smmu_reset_device(struct hyp_arm_smmu_v3_device *smmu)
 		goto err_disable_cmdq;
 
 	/* Enable translation */
-	return smmu_write_cr0(smmu, CR0_SMMUEN | CR0_CMDQEN | CR0_ATSCHK);
+	return smmu_write_cr0(smmu, CR0_SMMUEN | CR0_CMDQEN | CR0_ATSCHK | CR0_EVTQEN);
 
 err_disable_cmdq:
 	return smmu_write_cr0(smmu, 0);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index cbcd8a75d562..674ce2b02a4b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -496,11 +496,107 @@ static bool kvm_arm_smmu_validate_features(struct arm_smmu_device *smmu)
 	return true;
 }
 
+static irqreturn_t kvm_arm_smmu_evt_handler(int irq, void *dev)
+{
+	int i;
+	struct arm_smmu_device *smmu = dev;
+	struct arm_smmu_queue *q = &smmu->evtq.q;
+	struct arm_smmu_ll_queue *llq = &q->llq;
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
+	u64 evt[EVTQ_ENT_DWORDS];
+
+	do {
+		while (!queue_remove_raw(q, evt)) {
+			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
+
+			if (!__ratelimit(&rs))
+				continue;
+
+			dev_info(smmu->dev, "event 0x%02x received:\n", id);
+			for (i = 0; i < ARRAY_SIZE(evt); ++i)
+				dev_info(smmu->dev, "\t0x%016llx\n",
+					 (unsigned long long)evt[i]);
+
+			cond_resched();
+		}
+
+		/*
+		 * Not much we can do on overflow, so scream and pretend we're
+		 * trying harder.
+		 */
+		if (queue_sync_prod_in(q) == -EOVERFLOW)
+			dev_err(smmu->dev, "EVTQ overflow detected -- events lost\n");
+	} while (!queue_empty(llq));
+
+	/* Sync our overflow flag, as we believe we're up to speed */
+	queue_sync_cons_ovf(q);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t kvm_arm_smmu_gerror_handler(int irq, void *dev)
+{
+	u32 gerror, gerrorn, active;
+	struct arm_smmu_device *smmu = dev;
+
+	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+
+	active = gerror ^ gerrorn;
+	if (!(active & GERROR_ERR_MASK))
+		return IRQ_NONE; /* No errors pending */
+
+	dev_warn(smmu->dev,
+		 "unexpected global error reported (0x%08x), this could be serious\n",
+		 active);
+
+	/* There is no API to reconfigure the device at the moment.*/
+	if (active & GERROR_SFM_ERR)
+		dev_err(smmu->dev, "device has entered Service Failure Mode!\n");
+
+	if (active & GERROR_MSI_GERROR_ABT_ERR)
+		dev_warn(smmu->dev, "GERROR MSI write aborted\n");
+
+	if (active & GERROR_MSI_PRIQ_ABT_ERR)
+		dev_warn(smmu->dev, "PRIQ MSI write aborted\n");
+
+	if (active & GERROR_MSI_EVTQ_ABT_ERR)
+		dev_warn(smmu->dev, "EVTQ MSI write aborted\n");
+
+	if (active & GERROR_MSI_CMDQ_ABT_ERR)
+		dev_warn(smmu->dev, "CMDQ MSI write aborted\n");
+
+	if (active & GERROR_PRIQ_ABT_ERR)
+		dev_err(smmu->dev, "PRIQ write aborted -- events may have been lost\n");
+
+	if (active & GERROR_EVTQ_ABT_ERR)
+		dev_err(smmu->dev, "EVTQ write aborted -- events may have been lost\n");
+
+	if (active & GERROR_CMDQ_ERR) {
+		dev_err(smmu->dev, "CMDQ ERR -- Hypervisor cmdq corrupted?\n");
+		BUG();
+	}
+
+	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t kvm_arm_smmu_pri_handler(int irq, void *dev)
+{
+	struct arm_smmu_device *smmu = dev;
+
+	dev_err(smmu->dev, "PRI not supported in KVM driver!\n");
+
+	return IRQ_HANDLED;
+}
+
 static int kvm_arm_smmu_device_reset(struct host_arm_smmu_device *host_smmu)
 {
 	int ret;
 	u32 reg;
 	struct arm_smmu_device *smmu = &host_smmu->smmu;
+	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
 
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
 	if (reg & CR0_SMMUEN)
@@ -522,6 +618,39 @@ static int kvm_arm_smmu_device_reset(struct host_arm_smmu_device *host_smmu)
 	/* Command queue */
 	writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
 
+	/* Event queue */
+	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
+	writel_relaxed(smmu->evtq.q.llq.prod, smmu->base + SZ_64K + ARM_SMMU_EVTQ_PROD);
+	writel_relaxed(smmu->evtq.q.llq.cons, smmu->base + SZ_64K + ARM_SMMU_EVTQ_CONS);
+
+	/* Disable IRQs first */
+	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
+				      ARM_SMMU_IRQ_CTRLACK);
+	if (ret) {
+		dev_err(smmu->dev, "failed to disable irqs\n");
+		return ret;
+	}
+
+	/*
+	 * We don't support combined irqs for now, no specific reason, they are uncommon
+	 * so we just try to avoid bloating the code.
+	 */
+	if (smmu->combined_irq)
+		dev_err(smmu->dev, "Combined irqs not supported by this driver\n");
+	else
+		arm_smmu_setup_unique_irqs(smmu, kvm_arm_smmu_evt_handler,
+					   kvm_arm_smmu_gerror_handler,
+					   kvm_arm_smmu_pri_handler);
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
+
+	/* Enable interrupt generation on the SMMU */
+	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
+				      ARM_SMMU_IRQ_CTRL, ARM_SMMU_IRQ_CTRLACK);
+	if (ret)
+		dev_warn(smmu->dev, "failed to enable irqs\n");
+
 	return 0;
 }
 
@@ -565,6 +694,8 @@ static int kvm_arm_smmu_probe(struct platform_device *pdev)
 	if (IS_ERR(smmu->base))
 		return PTR_ERR(smmu->base);
 
+	arm_smmu_probe_irq(pdev, smmu);
+
 	ret = arm_smmu_device_hw_probe(smmu);
 	if (ret)
 		return ret;
@@ -583,6 +714,13 @@ static int kvm_arm_smmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* evtq */
+	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, smmu->base + SZ_64K,
+				      ARM_SMMU_EVTQ_PROD, ARM_SMMU_EVTQ_CONS,
+				      EVTQ_ENT_DWORDS, "evtq");
+	if (ret)
+		return ret;
+
 	ret = arm_smmu_init_strtab(smmu);
 	if (ret)
 		return ret;
-- 
2.47.0.338.g60cca15819-goog


