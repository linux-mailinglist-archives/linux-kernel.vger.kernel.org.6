Return-Path: <linux-kernel+bounces-171572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 167C88BE5F9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC0DB2A05C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAC615FCEB;
	Tue,  7 May 2024 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Fl5dYrOK"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C715FA95
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091973; cv=none; b=Mv9dAZV0AwQhQvEdd+SEiYsuffz2UNVdBuyNmzlv2Xsc2kMqlVa5HN0rUUpWJiVOh7TIcqbLdTBYGvK9M4hJiZDoG7B1LXCv1j7nOQhSTgOWOjJxi52BQXb/bhQw5/kbhV9WGapYlZefVS7gmyK7yBZ5mn6Y1WvsCNgv5lLFryM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091973; c=relaxed/simple;
	bh=VZxNS2OxyzYq3m1acYYqTvZC3vZEhXDPbe+Lr3aCwho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=S4UoNbmg2SBn8i14jI0/rlcQPmowDTJfwp0VxGwAQt31J6ODwL5tej5mrjXqYweC8sfAJr/rTvrutOeGpwumbw7O41kka80HAXQv2Hiw/tOnBv43sxPmTgzotv8qZbGe2etM0xcT+tNAOGKLBNePPrLpTZl4oHhGZRk+SRBCu4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Fl5dYrOK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f490b5c23bso719980b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715091970; x=1715696770; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0jz4ENNoetocqIssCS0B2oXUtzcTlnoT1WDoFLx5sIU=;
        b=Fl5dYrOKtK/1LYFWcio9ytUp7A3TIApjuT985xUUgG/PaHbSI7PTDKI36QylG8fBve
         i3oLdUPMNsEw5iZCJK61cx2yS7Gn8OrYmBFOO2T9y2YnqrceOVvuh8NcRG3ps+LK2EBC
         LoK/7G+XPm38FYZMK6zOhSP2qudhsxcr0Ui8I3U39Q7OquWIbgfiGkCWqktTKMTOdlLD
         ahnV+yFL6CLXxbq0PXRe/6tEcMX4t73esGF1q6DNWVTfNtZ0e1NoKifEclkI5gcFIhxW
         VYKpFTmvWQNh/1XEdmb7yyuTBoJyIWo4nTcbodbPoa7msmC8SF5uBWzjxJ5aW+kl2y5G
         MPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091970; x=1715696770;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jz4ENNoetocqIssCS0B2oXUtzcTlnoT1WDoFLx5sIU=;
        b=beM4Brs6RKCCoISyxs3/+kO55vJkbZS7BE5dQM8iJRGJbWGC0j5+qUdA/ZfqK0le3L
         uuYFx7lRx1dNknc8QhwMQn42wsfFS406f8uhEYks+6dX0iUC0Ar3tQc5SPisQuve2GTz
         8OFf5sv55duC0k7M0eFCe3qi8cND7WS+N1fR/FxXOHTu9c9Xj8vKiwmZKHEKCEqa8Syw
         JexZXzaza22fkqCaCUPG55cU+Bzbc9O6h5H+HW2yGhw6CFKw+SS6y3LkfHdYeixio65w
         jYtrgEkO80LK5En5uKUG2xaQotRSOgsBBYZLkRh0+00+OJGztEAzqNVld4VVVIjDXL7N
         nwcg==
X-Forwarded-Encrypted: i=1; AJvYcCXN2GV9Qj8s+3R1/Dyr5vmArN0zNcRXAnwZtLokVyO+R07A+WjumJ6d0wG/kJCDtL3eBgeQuDHf3+WqNHwBFE9UDdDWHv6guN445AFX
X-Gm-Message-State: AOJu0YwXfHJ7v25nZW64XqtXTOs7cy4DTR4fM7cr+Laz95wOHLEYmdyY
	awvxc5x2A+x6Z15PFAu5mAhNq7y7aDynaxwJlLYYuzNsyvqLMgxBiiLcgYZvFJE=
X-Google-Smtp-Source: AGHT+IFFwJydlhv8Eo1uigoZzco+8G3QZGbkY7AV3d8a5KKB5Jnd/eMaJgfIknHgv405ntAxsJkBlA==
X-Received: by 2002:a05:6a20:9c97:b0:1af:9ee6:25c4 with SMTP id mj23-20020a056a209c9700b001af9ee625c4mr8750903pzb.42.1715091970500;
        Tue, 07 May 2024 07:26:10 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i22-20020aa79096000000b006f44bcbe7e3sm7687554pfa.201.2024.05.07.07.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:26:10 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH RFC RESEND 2/6] iommu/riscv: Support HPM and interrupt handling
Date: Tue,  7 May 2024 22:25:56 +0800
Message-Id: <20240507142600.23844-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240507142600.23844-1-zong.li@sifive.com>
References: <20240507142600.23844-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch initialize the pmu stuff and uninitialize it when driver
removing. The interrupt handling is also provided, this handler need to
be primary handler instead of thread function, because pt_regs is empty
when threading the IRQ, but pt_regs is necessary by perf_event_overflow.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c | 59 +++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index ec701fde520f..e0bf74a9c64d 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -526,6 +526,56 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * IOMMU Hardware performance monitor
+ */
+
+/* HPM interrupt primary handler */
+static irqreturn_t riscv_iommu_hpm_irq_handler(int irq, void *dev_id)
+{
+	struct riscv_iommu_device *iommu = (struct riscv_iommu_device *)dev_id;
+
+	/* Process pmu irq */
+	riscv_iommu_pmu_handle_irq(&iommu->pmu);
+
+	/* Clear performance monitoring interrupt pending */
+	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_PMIP);
+
+	return IRQ_HANDLED;
+}
+
+/* HPM initialization */
+static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
+{
+	int rc;
+
+	if (!(iommu->caps & RISCV_IOMMU_CAP_HPM))
+		return 0;
+
+	/*
+	 * pt_regs is empty when threading the IRQ, but pt_regs is necessary
+	 * by perf_event_overflow. Use primary handler instead of thread
+	 * function for PM IRQ.
+	 */
+	rc = devm_request_irq(iommu->dev, iommu->irqs[RISCV_IOMMU_IPSR_PMIP],
+			      riscv_iommu_hpm_irq_handler, 0, NULL, iommu);
+	if (rc)
+		return rc;
+
+	return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(iommu->dev));
+}
+
+/* HPM uninitialization */
+static void riscv_iommu_hpm_disable(struct riscv_iommu_device *iommu)
+{
+	if (!(iommu->caps & RISCV_IOMMU_CAP_HPM))
+		return;
+
+	devm_free_irq(iommu->dev, iommu->irqs[RISCV_IOMMU_IPSR_PMIP], iommu);
+
+	riscv_iommu_pmu_uninit(&iommu->pmu);
+}
+
 /* Lookup and initialize device context info structure. */
 static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
 						 unsigned int devid)
@@ -1551,6 +1601,9 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
 	riscv_iommu_queue_disable(&iommu->cmdq);
 	riscv_iommu_queue_disable(&iommu->fltq);
+
+	if (iommu->caps & RISCV_IOMMU_CAP_HPM)
+		riscv_iommu_pmu_uninit(&iommu->pmu);
 }
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu)
@@ -1590,6 +1643,10 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	if (rc)
 		goto err_queue_disable;
 
+	rc = riscv_iommu_hpm_enable(iommu);
+	if (rc)
+		goto err_hpm_disable;
+
 	rc = iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-iommu@%s",
 				    dev_name(iommu->dev));
 	if (rc) {
@@ -1608,6 +1665,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
 err_iodir_off:
+	riscv_iommu_hpm_disable(iommu);
+err_hpm_disable:
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
 err_queue_disable:
 	riscv_iommu_queue_disable(&iommu->fltq);
-- 
2.17.1


