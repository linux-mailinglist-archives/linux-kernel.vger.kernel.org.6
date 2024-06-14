Return-Path: <linux-kernel+bounces-215011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A33908D48
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8C61C21395
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5563FF9F0;
	Fri, 14 Jun 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eXlgTSok"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225819441
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374935; cv=none; b=UcAc+tO9eHr43ZVzkKZ8MKJV18XJMWu5NDuk2EJaFp7/u9jQehv1jDreie0KCUV0qxeVItpVo2sc9v8a4U0zdB+U/RGWaXpkhQmHVF8L+qAbdhKUzp8SLzTccW4eY2Id4DJlEoQZIZcgmS3lNedmrbHGx0Q3kqpGamhgMTzHYio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374935; c=relaxed/simple;
	bh=AFqoKum5maZXoq29R1hOtMdbeMl8SDzKa1SfdPLj4w8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sEiPY/InjFwaiTDKFWwjdgpubpqd4FRm86u3CfRKA4GVe3xYkge3theE1FA4Dxrkm7knDlGKdxUau9VI+y5XxVFu6aiPMKBNZWNUzMOOF+RdSOAVDgB2eVCdI89xkFaasRuHXgHkIdW62jniXCmqYGgdloXaV+SiMqZyOaPPP9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=eXlgTSok; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6c7cdec83so19211725ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374933; x=1718979733; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tlFDKoGPkyb3nGW5qL4azlR55hFLQbYBhLCB+CenNg8=;
        b=eXlgTSokqviq1/nMstq/JL7UJmJ9gArRjzutdDf+qxhddYor+VNDeP9hfOgZqmAOyS
         /6wAaCXSpKf7pngRxOTpFk/mzXmURFDtLBMCzIP+v2LlJXwqmBiWMt/kuAoAipjoRBB+
         1AOZwN9slrpHx50zloTb+zTzsUZg5kflHEB7SVBH+snx6ywa/upsgjJF8+TXgWSuDk1a
         IyivfiMhzZWYW01kkq+Mpiaa3rd2nqY+iDLbRdIzgKB266NM5zS7R4syNCq03+wDG8WM
         c09/dl+sRQ8NWCnFzrBXkZuQ5J8NgSQslWFUcmXkhGqPkmBCwM1sr8/jK80XcpEv2BwB
         NugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374933; x=1718979733;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlFDKoGPkyb3nGW5qL4azlR55hFLQbYBhLCB+CenNg8=;
        b=omdKrp58d+Riigv8OzxgezaA9N01XfgSC83oCOD0b521Rl9cBhsGEUAmvHeOwPIXHE
         eXOTsjuispcaSwLBdUS4/85KeQcngUsXGATVM4tNrL0i4oZ6Kc1a2TC2BFSlpF7ghVFT
         Av0QuExPJXjuWcr9SIL3ge5crgaftuf8xXsnB4PqxvaglVzeG00tiMXXI1/Cz4Mz44d7
         Y/KOGztKQDJmat1wvTKR6AK1198ZVvBQo2NAb4WlIZOvJ55KX/TZI53T1St99Gvy0BB5
         RVlS/QXCBLqCXlS55zHtxktJliZYw0EDz7sI9G5IvbkqQlJ2f4E9uWyzAEWrKBKAhjJ/
         N7ow==
X-Forwarded-Encrypted: i=1; AJvYcCWEm1UoOrCWjkplM4MJ55jElTr6RAT5R2MljQhzW7Yyv2DDzsC0VMY90KAHEVdwOsvi526NXw5k1bZWOY6/YGdg9J7/eW3Tm1FP8As7
X-Gm-Message-State: AOJu0Yw4ttc7/MVe5WbLDV4lXG2AEKf+MVt0d9ECN2wkz/s64QihS8qa
	sDYhCmqVltAeJH3X8JLC91x0XsQoX4kRfBsMv3yDF4UfIqVcBb/rXkn17SF9NfwP5HO1ns7ESvT
	K7d8=
X-Google-Smtp-Source: AGHT+IE4q8GqM7rVw79GCJsFYmYJxenhwqq3dMfDvs+NWax7S8ItEx42VF35t3MI4KJSDGoZTtuT2g==
X-Received: by 2002:a17:902:7883:b0:1f7:35e0:5af4 with SMTP id d9443c01a7336-1f8627e18bcmr22056005ad.30.1718374933563;
        Fri, 14 Jun 2024 07:22:13 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:13 -0700 (PDT)
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
Subject: [RFC PATCH v2 02/10] iommu/riscv: support HPM and interrupt handling
Date: Fri, 14 Jun 2024 22:21:48 +0800
Message-Id: <20240614142156.29420-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
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
 drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 8b6a64c1ad8d..1716b2251f38 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -540,6 +540,62 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
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
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
+		return 0;
+
+	/*
+	 * pt_regs is empty when threading the IRQ, but pt_regs is necessary
+	 * by perf_event_overflow. Use primary handler instead of thread
+	 * function for PM IRQ.
+	 *
+	 * Set the IRQF_ONESHOT flag because this IRQ might be shared with
+	 * other threaded IRQs by other queues.
+	 */
+	rc = devm_request_irq(iommu->dev,
+			      iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IPSR_PMIP)],
+			      riscv_iommu_hpm_irq_handler, IRQF_ONESHOT | IRQF_SHARED, NULL, iommu);
+	if (rc)
+		return rc;
+
+	return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(iommu->dev));
+}
+
+/* HPM uninitialization */
+static void riscv_iommu_hpm_disable(struct riscv_iommu_device *iommu)
+{
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
+		return;
+
+	devm_free_irq(iommu->dev,
+		      iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IPSR_PMIP)],
+		      iommu);
+
+	riscv_iommu_pmu_uninit(&iommu->pmu);
+}
+
 /* Lookup and initialize device context info structure. */
 static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
 						 unsigned int devid)
@@ -1612,6 +1668,9 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
 	riscv_iommu_queue_disable(&iommu->cmdq);
 	riscv_iommu_queue_disable(&iommu->fltq);
+
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_pmu_uninit(&iommu->pmu);
 }
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu)
@@ -1651,6 +1710,10 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	if (rc)
 		goto err_queue_disable;
 
+	rc = riscv_iommu_hpm_enable(iommu);
+	if (rc)
+		goto err_hpm_disable;
+
 	rc = iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-iommu@%s",
 				    dev_name(iommu->dev));
 	if (rc) {
@@ -1669,6 +1732,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
 err_iodir_off:
+	riscv_iommu_hpm_disable(iommu);
+err_hpm_disable:
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
 err_queue_disable:
 	riscv_iommu_queue_disable(&iommu->fltq);
-- 
2.17.1


