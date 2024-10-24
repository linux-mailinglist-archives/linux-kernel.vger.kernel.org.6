Return-Path: <linux-kernel+bounces-379442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4B49ADEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADF9285B96
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0E51CB53A;
	Thu, 24 Oct 2024 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dwcah5wN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C041C8FC6;
	Thu, 24 Oct 2024 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757504; cv=none; b=IqfRPDcvG0Sf+teglBPLZOockchBXnNQoicYMEkhpC2U3Jlt/5P1OnYg96Tj+RgPyj/XSh4BnTieuxHK6sWyE3A/jToN/0wCaPvNbiFGEpZUbbOe6Jjh/FC3KsyzvPm/SfWL1n/rx8f29u5EP8iSZK7KGJzbn337OM/+jQyfIh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757504; c=relaxed/simple;
	bh=dzJ4vVJ7UwJg8xh45+nLAaEVKIwrSDfo4sT4b83/7eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XNRRs/HAGC5zFWMeXI7aMdSmrhRA2BdLRlCBVBrACz3lmjX07cT1opoI3L6SceHRLfGS0UbhcbjGSTkS5b3eFELpddnu8MZ4MpudHATHZeaxVmTAWHHjjtUWA07fS69G1jecTjx1FXk5aJ48nn3rVVWODs2HKKKgin50WkzkuTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dwcah5wN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729757503; x=1761293503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dzJ4vVJ7UwJg8xh45+nLAaEVKIwrSDfo4sT4b83/7eo=;
  b=Dwcah5wN84+exTP3jo4wDrDqJHyjz4uedvNNK06XgMTLIlKQc0au4ZMt
   yPcRkq6OYHn/rjPs/OKSxcJm5rL+qo4qNC6nEouXxveWZn0q0pasm7JB3
   HjOWCIxROYiraDV4vp110bZBS0gW/2tTqJcuH74DlG/M/XqfL4yL10jI9
   NlAXeS1IaLQwHSL/nCsINbE/8K8ECj4dh67DsDl+/GtJde76QAvKX8vdu
   6XJWZoiORWTl1ROTvk6o9vPGeLTx7JthvihmCyVdH7+NbgmvAUMoJpZe0
   JT2Jy7yl6MUGLSVIWEaXvaEgJnZWy1VW/OUFaoPg9m9zBZQaDFKDXKWYh
   Q==;
X-CSE-ConnectionGUID: xXKTRHWURlWPnLdfINZI2w==
X-CSE-MsgGUID: K0cKMWbrSaKHVspvMgCOHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29501096"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29501096"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 01:11:42 -0700
X-CSE-ConnectionGUID: rM03qj+nT0SqH/7G8uuMxw==
X-CSE-MsgGUID: DUuLeHowQnmIP1RyNrp0oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80690882"
Received: from shsensorbuild.sh.intel.com ([10.239.133.18])
  by orviesa006.jf.intel.com with ESMTP; 24 Oct 2024 01:11:37 -0700
From: Even Xu <even.xu@intel.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	corbet@lwn.net
Cc: linux-input@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Rui Zhang <rui1.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 16/22] HID: intel-thc-hid: intel-quickspi: Add PM implementation
Date: Thu, 24 Oct 2024 16:10:17 +0800
Message-Id: <20241024081023.1468951-17-even.xu@intel.com>
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

Implement THC QuickSPI driver power management callbacks.

Co-developed-by: Xinpeng Sun <xinpeng.sun@intel.com>
Signed-off-by: Xinpeng Sun <xinpeng.sun@intel.com>
Signed-off-by: Even Xu <even.xu@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel-quickspi/pci-quickspi.c             | 246 ++++++++++++++++++
 .../intel-quickspi/quickspi-dev.h             |   8 +
 .../intel-quickspi/quickspi-hid.c             |   8 +
 3 files changed, 262 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 0dae1a07b728..fe3c4748c8e9 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 
 #include "intel-thc-dev.h"
 #include "intel-thc-hw.h"
@@ -277,6 +278,10 @@ static irqreturn_t quickspi_irq_thread_handler(int irq, void *dev_id)
 	if (qsdev->state == QUICKSPI_DISABLED)
 		return IRQ_HANDLED;
 
+	ret = pm_runtime_resume_and_get(qsdev->dev);
+	if (ret)
+		return IRQ_HANDLED;
+
 	int_mask = thc_interrupt_handler(qsdev->thc_hw);
 
 	if (int_mask & BIT(THC_FATAL_ERR_INT) || int_mask & BIT(THC_TXN_ERR_INT)) {
@@ -314,6 +319,9 @@ static irqreturn_t quickspi_irq_thread_handler(int irq, void *dev_id)
 		if (try_recover(qsdev))
 			qsdev->state = QUICKSPI_DISABLED;
 
+	pm_runtime_mark_last_busy(qsdev->dev);
+	pm_runtime_put_autosuspend(qsdev->dev);
+
 	return IRQ_HANDLED;
 }
 
@@ -630,6 +638,13 @@ static int quickspi_probe(struct pci_dev *pdev,
 		goto dma_deinit;
 	}
 
+	/* Enable runtime power management */
+	pm_runtime_use_autosuspend(qsdev->dev);
+	pm_runtime_set_autosuspend_delay(qsdev->dev, DEFAULT_AUTO_SUSPEND_DELAY_MS);
+	pm_runtime_mark_last_busy(qsdev->dev);
+	pm_runtime_put_noidle(qsdev->dev);
+	pm_runtime_put_autosuspend(qsdev->dev);
+
 	dev_dbg(&pdev->dev, "QuickSPI probe success\n");
 
 	return 0;
@@ -666,6 +681,8 @@ static void quickspi_remove(struct pci_dev *pdev)
 	quickspi_hid_remove(qsdev);
 	quickspi_dma_deinit(qsdev);
 
+	pm_runtime_get_noresume(qsdev->dev);
+
 	quickspi_dev_deinit(qsdev);
 
 	pcim_iounmap_regions(pdev, BIT(0));
@@ -696,6 +713,234 @@ static void quickspi_shutdown(struct pci_dev *pdev)
 	quickspi_dev_deinit(qsdev);
 }
 
+static int quickspi_suspend(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quickspi_device *qsdev;
+	int ret;
+
+	qsdev = pci_get_drvdata(pdev);
+	if (!qsdev)
+		return -ENODEV;
+
+	ret = quickspi_set_power(qsdev, HIDSPI_SLEEP);
+	if (ret)
+		return ret;
+
+	ret = thc_interrupt_quiesce(qsdev->thc_hw, true);
+	if (ret)
+		return ret;
+
+	thc_interrupt_enable(qsdev->thc_hw, false);
+
+	thc_dma_unconfigure(qsdev->thc_hw);
+
+	return 0;
+}
+
+static int quickspi_resume(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quickspi_device *qsdev;
+	int ret;
+
+	qsdev = pci_get_drvdata(pdev);
+	if (!qsdev)
+		return -ENODEV;
+
+	ret = thc_port_select(qsdev->thc_hw, THC_PORT_TYPE_SPI);
+	if (ret)
+		return ret;
+
+	thc_interrupt_config(qsdev->thc_hw);
+
+	thc_interrupt_enable(qsdev->thc_hw, true);
+
+	ret = thc_dma_configure(qsdev->thc_hw);
+	if (ret)
+		return ret;
+
+	ret = thc_interrupt_quiesce(qsdev->thc_hw, false);
+	if (ret)
+		return ret;
+
+	ret = quickspi_set_power(qsdev, HIDSPI_ON);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int quickspi_freeze(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quickspi_device *qsdev;
+	int ret;
+
+	qsdev = pci_get_drvdata(pdev);
+	if (!qsdev)
+		return -ENODEV;
+
+	ret = thc_interrupt_quiesce(qsdev->thc_hw, true);
+	if (ret)
+		return ret;
+
+	thc_interrupt_enable(qsdev->thc_hw, false);
+
+	thc_dma_unconfigure(qsdev->thc_hw);
+
+	return 0;
+}
+
+static int quickspi_thaw(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quickspi_device *qsdev;
+	int ret;
+
+	qsdev = pci_get_drvdata(pdev);
+	if (!qsdev)
+		return -ENODEV;
+
+	ret = thc_dma_configure(qsdev->thc_hw);
+	if (ret)
+		return ret;
+
+	thc_interrupt_enable(qsdev->thc_hw, true);
+
+	ret = thc_interrupt_quiesce(qsdev->thc_hw, false);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int quickspi_poweroff(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quickspi_device *qsdev;
+	int ret;
+
+	qsdev = pci_get_drvdata(pdev);
+	if (!qsdev)
+		return -ENODEV;
+
+	ret = thc_interrupt_quiesce(qsdev->thc_hw, true);
+	if (ret)
+		return ret;
+
+	thc_interrupt_enable(qsdev->thc_hw, false);
+
+	thc_ltr_unconfig(qsdev->thc_hw);
+
+	quickspi_dma_deinit(qsdev);
+
+	return 0;
+}
+
+static int quickspi_restore(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quickspi_device *qsdev;
+	int ret;
+
+	qsdev = pci_get_drvdata(pdev);
+	if (!qsdev)
+		return -ENODEV;
+
+	/* Reconfig THC HW when back from hibernate */
+	ret = thc_port_select(qsdev->thc_hw, THC_PORT_TYPE_SPI);
+	if (ret)
+		return ret;
+
+	thc_spi_input_output_address_config(qsdev->thc_hw,
+					    qsdev->input_report_hdr_addr,
+					    qsdev->input_report_bdy_addr,
+					    qsdev->output_report_addr);
+
+	ret = thc_spi_read_config(qsdev->thc_hw, qsdev->spi_freq_val,
+				  qsdev->spi_read_io_mode,
+				  qsdev->spi_read_opcode,
+				  qsdev->spi_packet_size);
+	if (ret)
+		return ret;
+
+	ret = thc_spi_write_config(qsdev->thc_hw, qsdev->spi_freq_val,
+				   qsdev->spi_write_io_mode,
+				   qsdev->spi_write_opcode,
+				   qsdev->spi_packet_size,
+				   qsdev->performance_limit);
+	if (ret)
+		return ret;
+
+	thc_interrupt_config(qsdev->thc_hw);
+
+	thc_interrupt_enable(qsdev->thc_hw, true);
+
+	ret = thc_interrupt_quiesce(qsdev->thc_hw, false);
+	if (ret)
+		return ret;
+
+	/* TIC may lose power, needs go through reset flow */
+	ret = reset_tic(qsdev);
+	if (ret)
+		return ret;
+
+	ret = thc_dma_configure(qsdev->thc_hw);
+	if (ret)
+		return ret;
+
+	thc_ltr_config(qsdev->thc_hw,
+		       qsdev->active_ltr_val,
+		       qsdev->low_power_ltr_val);
+
+	thc_change_ltr_mode(qsdev->thc_hw, THC_LTR_MODE_ACTIVE);
+
+	return 0;
+}
+
+static int quickspi_runtime_suspend(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quickspi_device *qsdev;
+
+	qsdev = pci_get_drvdata(pdev);
+	if (!qsdev)
+		return -ENODEV;
+
+	thc_change_ltr_mode(qsdev->thc_hw, THC_LTR_MODE_LP);
+
+	pci_save_state(pdev);
+
+	return 0;
+}
+
+static int quickspi_runtime_resume(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quickspi_device *qsdev;
+
+	qsdev = pci_get_drvdata(pdev);
+	if (!qsdev)
+		return -ENODEV;
+
+	thc_change_ltr_mode(qsdev->thc_hw, THC_LTR_MODE_ACTIVE);
+
+	return 0;
+}
+
+static const struct dev_pm_ops quickspi_pm_ops = {
+	.suspend = quickspi_suspend,
+	.resume = quickspi_resume,
+	.freeze = quickspi_freeze,
+	.thaw = quickspi_thaw,
+	.poweroff = quickspi_poweroff,
+	.restore = quickspi_restore,
+	.runtime_suspend = quickspi_runtime_suspend,
+	.runtime_resume = quickspi_runtime_resume,
+	.runtime_idle = NULL,
+};
+
 static const struct pci_device_id quickspi_pci_tbl[] = {
 	{PCI_DEVICE_DATA(INTEL, THC_MTL_DEVICE_ID_SPI_PORT1, &mtl), },
 	{PCI_DEVICE_DATA(INTEL, THC_MTL_DEVICE_ID_SPI_PORT2, &mtl), },
@@ -711,6 +956,7 @@ static struct pci_driver quickspi_driver = {
 	.probe = quickspi_probe,
 	.remove = quickspi_remove,
 	.shutdown = quickspi_shutdown,
+	.driver.pm = &quickspi_pm_ops,
 	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 };
 
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
index 15219875f604..1535baa2ee80 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -43,6 +43,14 @@
 #define MAX_PACKET_SIZE_VALUE_MTL			128
 #define MAX_PACKET_SIZE_VALUE_LNL			256
 
+/*
+ * THC uses runtime auto suspend to dynamically switch between THC active LTR
+ * and low power LTR to save CPU power.
+ * Default value is 5000ms, that means if no touch event in this time, THC will
+ * change to low power LTR mode.
+ */
+#define DEFAULT_AUTO_SUSPEND_DELAY_MS			5000
+
 enum quickspi_dev_state {
 	QUICKSPI_NONE,
 	QUICKSPI_RESETING,
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
index 2553d4b42b51..ad52e402c28a 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
@@ -3,6 +3,7 @@
 
 #include <linux/hid.h>
 #include <linux/input.h>
+#include <linux/pm_runtime.h>
 
 #include "quickspi-dev.h"
 #include "quickspi-hid.h"
@@ -54,6 +55,10 @@ static int quickspi_hid_raw_request(struct hid_device *hid,
 	struct quickspi_device *qsdev = hid->driver_data;
 	int ret = 0;
 
+	ret = pm_runtime_resume_and_get(qsdev->dev);
+	if (ret)
+		return ret;
+
 	switch (reqtype) {
 	case HID_REQ_GET_REPORT:
 		ret = quickspi_get_report(qsdev, rtype, reportnum, buf);
@@ -66,6 +71,9 @@ static int quickspi_hid_raw_request(struct hid_device *hid,
 		break;
 	}
 
+	pm_runtime_mark_last_busy(qsdev->dev);
+	pm_runtime_put_autosuspend(qsdev->dev);
+
 	return ret;
 }
 
-- 
2.40.1


