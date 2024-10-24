Return-Path: <linux-kernel+bounces-379440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323669ADEAC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F0E1F21B96
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B071C7617;
	Thu, 24 Oct 2024 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzCqIsSu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B9137930;
	Thu, 24 Oct 2024 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757500; cv=none; b=paFeI8GAUcBodp2utDcRDzYW9PdyjpgR0+OjL/EGG+weHPJOnBZy60QrF0iXeKPCSA/d5cp4BUmBxg6Rx0FHBQjvcweqwonQYmE80XNYskaC2Q/0zJBsK2gvpwHvd3t2ndnaVgPnIj4hKsEDo8L54CkUpOFLhBA8L+dYO7/XVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757500; c=relaxed/simple;
	bh=1xDyONWrEosBcaWVUt6p+44/6e9Dq2BvSWve1d6fXAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jD9JQ5y+RXGtl6RPhdGtvfAicOFpmWSg3W0mkjTPHBMFY7+unBGZLOJr28q/vgJcOeC2I4GK3ztYTYH/cPsNsKJlOtkCkvbjQTxU9sr/U09N2miUVdHeAp1XcrEdTh9P+ROKPgrcTLaL0e8DUbbW/TQVPtuhFSw2wEbReLcV4Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzCqIsSu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729757498; x=1761293498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1xDyONWrEosBcaWVUt6p+44/6e9Dq2BvSWve1d6fXAE=;
  b=hzCqIsSu2bOzqoL/O48pxNQUPIphQmSxrlEs+o4B3Q6V3YN+0s1lpSCA
   HrtG3hHegyIAjK0ePthKNrOjHWv0lFEo8gOAr7y300YsLwOSFE441Q1NI
   8EGguqDxCrZIj+JuM+O++cbwtRUT/n1qC7vas1aNNE+u3ky1i5LQ5qrrQ
   iDis8jKk4yMV2mDcgwjwZxfVFA9jJJmWiZcT2e/iZjHhiApy8Ct1+rT+1
   Bn1QP8XP+imZmlyF7uoF/TREWWVq7hqTOxubHYwEVNy4nTjrq/dxlkkVM
   hQI9O7iq3iZzVEzrgzHwd20hXvWy/26oqO61LVjG3ulRwS6BlVeZQUuC9
   A==;
X-CSE-ConnectionGUID: wacx7p4LR2mLg1vRyY+ivQ==
X-CSE-MsgGUID: GeT7VkWITc6yMOd2XQEhbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29501089"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29501089"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 01:11:38 -0700
X-CSE-ConnectionGUID: olCY5gbnQnCX7lAnvqa1Ww==
X-CSE-MsgGUID: BqGIZjchSiW95HvZwwVK4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80690870"
Received: from shsensorbuild.sh.intel.com ([10.239.133.18])
  by orviesa006.jf.intel.com with ESMTP; 24 Oct 2024 01:11:34 -0700
From: Even Xu <even.xu@intel.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	corbet@lwn.net
Cc: linux-input@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Even Xu <even.xu@intel.com>,
	Rui Zhang <rui1.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 15/22] HID: intel-thc-hid: intel-quickspi: Complete THC QuickSPI driver
Date: Thu, 24 Oct 2024 16:10:16 +0800
Message-Id: <20241024081023.1468951-16-even.xu@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241024081023.1468951-1-even.xu@intel.com>
References: <20241024081023.1468951-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xinpeng Sun <xinpeng.sun@intel.com>

Fully implement QuickSPI driver probe/remove callbacks, interrupt
handler, integrate HIDSPI protocol, enumerate HID device and register
HID device.

Co-developed-by: Even Xu <even.xu@intel.com>
Signed-off-by: Even Xu <even.xu@intel.com>
Signed-off-by: Xinpeng Sun <xinpeng.sun@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel-quickspi/pci-quickspi.c             | 254 ++++++++++++++++++
 1 file changed, 254 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 16789bdb1235..0dae1a07b728 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -14,6 +14,8 @@
 #include "intel-thc-hw.h"
 
 #include "quickspi-dev.h"
+#include "quickspi-hid.h"
+#include "quickspi-protocol.h"
 
 struct quickspi_driver_data mtl = {
 	.max_packet_size_value = MAX_PACKET_SIZE_VALUE_MTL,
@@ -224,6 +226,37 @@ static irqreturn_t quickspi_irq_quick_handler(int irq, void *dev_id)
 	return IRQ_WAKE_THREAD;
 }
 
+/**
+ * try_recover - Try to recovery THC and Device
+ * @qsdev: pointer to quickspi device
+ *
+ * This function is a error handler, called when fatal error happens.
+ * It try to reset Touch Device and re-configure THC to recovery
+ * transferring between Device and THC.
+ *
+ * Return: 0 if successful or error code on failed.
+ */
+static int try_recover(struct quickspi_device *qsdev)
+{
+	int ret;
+
+	ret = reset_tic(qsdev);
+	if (ret) {
+		dev_err(qsdev->dev, "Reset touch device failed, ret = %d\n", ret);
+		return ret;
+	}
+
+	thc_dma_unconfigure(qsdev->thc_hw);
+
+	ret = thc_dma_configure(qsdev->thc_hw);
+	if (ret) {
+		dev_err(qsdev->dev, "Re-configure THC DMA failed, ret = %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * quickspi_irq_thread_handler - IRQ thread handler of quickspi driver
  *
@@ -235,15 +268,52 @@ static irqreturn_t quickspi_irq_quick_handler(int irq, void *dev_id)
 static irqreturn_t quickspi_irq_thread_handler(int irq, void *dev_id)
 {
 	struct quickspi_device *qsdev = dev_id;
+	size_t input_len;
+	int read_finished = 0;
+	int err_recover = 0;
 	int int_mask;
+	int ret;
 
 	if (qsdev->state == QUICKSPI_DISABLED)
 		return IRQ_HANDLED;
 
 	int_mask = thc_interrupt_handler(qsdev->thc_hw);
 
+	if (int_mask & BIT(THC_FATAL_ERR_INT) || int_mask & BIT(THC_TXN_ERR_INT)) {
+		err_recover = 1;
+		goto end;
+	}
+
+	if (int_mask & BIT(THC_NONDMA_INT)) {
+		if (qsdev->state == QUICKSPI_RESETING) {
+			qsdev->reset_ack = true;
+			wake_up_interruptible(&qsdev->reset_ack_wq);
+		} else {
+			qsdev->nondma_int_received = true;
+			wake_up_interruptible(&qsdev->nondma_int_received_wq);
+		}
+	}
+
+	if (int_mask & BIT(THC_RXDMA2_INT)) {
+		while (!read_finished) {
+			ret = thc_rxdma_read(qsdev->thc_hw, THC_RXDMA2, qsdev->input_buf,
+					     &input_len, &read_finished);
+			if (ret) {
+				err_recover = 1;
+				goto end;
+			}
+
+			quickspi_handle_input_data(qsdev, input_len);
+		}
+	}
+
+end:
 	thc_interrupt_enable(qsdev->thc_hw, true);
 
+	if (err_recover)
+		if (try_recover(qsdev))
+			qsdev->state = QUICKSPI_DISABLED;
+
 	return IRQ_HANDLED;
 }
 
@@ -278,6 +348,12 @@ static struct quickspi_device *quickspi_dev_init(struct pci_dev *pdev, void __io
 	qsdev->mem_addr = mem_addr;
 	qsdev->driver_data = (struct quickspi_driver_data *)id->driver_data;
 
+	init_waitqueue_head(&qsdev->reset_ack_wq);
+	init_waitqueue_head(&qsdev->nondma_int_received_wq);
+	init_waitqueue_head(&qsdev->report_desc_got_wq);
+	init_waitqueue_head(&qsdev->get_report_cmpl_wq);
+	init_waitqueue_head(&qsdev->set_report_cmpl_wq);
+
 	/* thc hw init */
 	qsdev->thc_hw = thc_dev_init(qsdev->dev, qsdev->mem_addr);
 	if (IS_ERR(qsdev->thc_hw)) {
@@ -298,6 +374,37 @@ static struct quickspi_device *quickspi_dev_init(struct pci_dev *pdev, void __io
 		return ERR_PTR(ret);
 	}
 
+	/* THC config for input/output address */
+	thc_spi_input_output_address_config(qsdev->thc_hw,
+					    qsdev->input_report_hdr_addr,
+					    qsdev->input_report_bdy_addr,
+					    qsdev->output_report_addr);
+
+	/* THC config for spi read operation */
+	ret = thc_spi_read_config(qsdev->thc_hw, qsdev->spi_freq_val,
+				  qsdev->spi_read_io_mode,
+				  qsdev->spi_read_opcode,
+				  qsdev->spi_packet_size);
+	if (ret) {
+		dev_err(dev, "thc_spi_read_config failed, ret = %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	/* THC config for spi write operation */
+	ret = thc_spi_write_config(qsdev->thc_hw, qsdev->spi_freq_val,
+				   qsdev->spi_write_io_mode,
+				   qsdev->spi_write_opcode,
+				   qsdev->spi_packet_size,
+				   qsdev->performance_limit);
+	if (ret) {
+		dev_err(dev, "thc_spi_write_config failed, ret = %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	thc_ltr_config(qsdev->thc_hw,
+		       qsdev->active_ltr_val,
+		       qsdev->low_power_ltr_val);
+
 	thc_interrupt_config(qsdev->thc_hw);
 
 	thc_interrupt_enable(qsdev->thc_hw, true);
@@ -315,6 +422,101 @@ static struct quickspi_device *quickspi_dev_init(struct pci_dev *pdev, void __io
 static void quickspi_dev_deinit(struct quickspi_device *qsdev)
 {
 	thc_interrupt_enable(qsdev->thc_hw, false);
+	thc_ltr_unconfig(qsdev->thc_hw);
+}
+
+/**
+ * quickspi_dma_init - Configure THC DMA for quickspi device
+ * @qsdev: pointer to the quickspi device structure
+ *
+ * This function uses TIC's parameters(such as max input length, max output
+ * length) to allocate THC DMA buffers and configure THC DMA engines.
+ *
+ * Return: 0 if successful or error code on failed.
+ */
+static int quickspi_dma_init(struct quickspi_device *qsdev)
+{
+	int ret;
+
+	ret = thc_dma_set_max_packet_sizes(qsdev->thc_hw, 0,
+					   le16_to_cpu(qsdev->dev_desc.max_input_len),
+					   le16_to_cpu(qsdev->dev_desc.max_output_len),
+					   0);
+	if (ret)
+		return ret;
+
+	ret = thc_dma_allocate(qsdev->thc_hw);
+	if (ret) {
+		dev_err(qsdev->dev, "Allocate THC DMA buffer failed, ret = %d\n", ret);
+		return ret;
+	}
+
+	/* Enable RxDMA */
+	ret = thc_dma_configure(qsdev->thc_hw);
+	if (ret) {
+		dev_err(qsdev->dev, "Configure THC DMA failed, ret = %d\n", ret);
+		thc_dma_unconfigure(qsdev->thc_hw);
+		thc_dma_release(qsdev->thc_hw);
+		return ret;
+	}
+
+	return ret;
+}
+
+/**
+ * quickspi_dma_deinit - Release THC DMA for quickspi device
+ * @qsdev: pointer to the quickspi device structure
+ *
+ * Stop THC DMA engines and release all DMA buffers.
+ *
+ */
+static void quickspi_dma_deinit(struct quickspi_device *qsdev)
+{
+	thc_dma_unconfigure(qsdev->thc_hw);
+	thc_dma_release(qsdev->thc_hw);
+}
+
+/**
+ * quickspi_alloc_report_buf - Alloc report buffers
+ * @qsdev: pointer to the quickspi device structure
+ *
+ * Allocate report descritpor buffer, it will be used for restore TIC HID
+ * report descritpor.
+ *
+ * Allocate input report buffer, it will be used for receive HID input report
+ * data from TIC.
+ *
+ * Allocate output report buffer, it will be used for store HID output report,
+ * such as set feature.
+ *
+ * Return: 0 if successful or error code on failed.
+ */
+static int quickspi_alloc_report_buf(struct quickspi_device *qsdev)
+{
+	size_t max_report_len;
+	size_t max_input_len;
+
+	qsdev->report_descriptor = devm_kzalloc(qsdev->dev,
+						le16_to_cpu(qsdev->dev_desc.rep_desc_len),
+						GFP_KERNEL);
+	if (!qsdev->report_descriptor)
+		return -ENOMEM;
+
+	max_input_len = max(le16_to_cpu(qsdev->dev_desc.rep_desc_len),
+			    le16_to_cpu(qsdev->dev_desc.max_input_len));
+
+	qsdev->input_buf = devm_kzalloc(qsdev->dev, max_input_len, GFP_KERNEL);
+	if (!qsdev->input_buf)
+		return -ENOMEM;
+
+	max_report_len = max(le16_to_cpu(qsdev->dev_desc.max_output_len),
+			     le16_to_cpu(qsdev->dev_desc.max_input_len));
+
+	qsdev->report_buf = devm_kzalloc(qsdev->dev, max_report_len, GFP_KERNEL);
+	if (!qsdev->report_buf)
+		return -ENOMEM;
+
+	return 0;
 }
 
 /*
@@ -323,6 +525,18 @@ static void quickspi_dev_deinit(struct quickspi_device *qsdev)
  * @pdev: point to pci device
  * @id: point to pci_device_id structure
  *
+ * This function initializes THC and HIDSPI device, the flow is:
+ * - do THC pci device initialization
+ * - query HIDSPI ACPI parameters
+ * - configure THC to HIDSPI mode
+ * - go through HIDSPI enumeration flow
+ *   |- reset HIDSPI device
+ *   |- read device descriptor
+ * - enable THC interrupt and DMA
+ * - read report descriptor
+ * - register HID device
+ * - enable runtime power management
+ *
  * Return 0 if success or error code on failure.
  */
 static int quickspi_probe(struct pci_dev *pdev,
@@ -386,8 +600,42 @@ static int quickspi_probe(struct pci_dev *pdev,
 		goto dev_deinit;
 	}
 
+	ret = reset_tic(qsdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Reset Touch Device failed, ret = %d\n", ret);
+		goto dev_deinit;
+	}
+
+	ret = quickspi_alloc_report_buf(qsdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Alloc report buffers failed, ret= %d\n", ret);
+		goto dev_deinit;
+	}
+
+	ret = quickspi_dma_init(qsdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Setup THC DMA failed, ret= %d\n", ret);
+		goto dev_deinit;
+	}
+
+	ret = quickspi_get_report_descriptor(qsdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Get report descriptor failed, ret = %d\n", ret);
+		goto dma_deinit;
+	}
+
+	ret = quickspi_hid_probe(qsdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register HID device, ret = %d\n", ret);
+		goto dma_deinit;
+	}
+
+	dev_dbg(&pdev->dev, "QuickSPI probe success\n");
+
 	return 0;
 
+dma_deinit:
+	quickspi_dma_deinit(qsdev);
 dev_deinit:
 	quickspi_dev_deinit(qsdev);
 unmap_io_region:
@@ -415,6 +663,9 @@ static void quickspi_remove(struct pci_dev *pdev)
 	if (!qsdev)
 		return;
 
+	quickspi_hid_remove(qsdev);
+	quickspi_dma_deinit(qsdev);
+
 	quickspi_dev_deinit(qsdev);
 
 	pcim_iounmap_regions(pdev, BIT(0));
@@ -439,6 +690,9 @@ static void quickspi_shutdown(struct pci_dev *pdev)
 	if (!qsdev)
 		return;
 
+	/* Must stop DMA before reboot to avoid DMA entering into unknown state */
+	quickspi_dma_deinit(qsdev);
+
 	quickspi_dev_deinit(qsdev);
 }
 
-- 
2.40.1


