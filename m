Return-Path: <linux-kernel+bounces-379451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFB39ADEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DD61C21AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7E01D5179;
	Thu, 24 Oct 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gqs0L43R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839891D1512;
	Thu, 24 Oct 2024 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757522; cv=none; b=ullAapHyIUxuQ5RFVmGGezHnxFy5gPyZ8YTcF14sgSBZ70tSOd6NyFy3z50LKWeMaYvE3YXBw5usrpeyu5pD2MpTuEwJfRac0GZF8HKEvG8BKi3vg4NNW6S8bEf3jLswTi11bEW0wVErtF/+VLALBK3m59rm0yoYIy67j3xppgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757522; c=relaxed/simple;
	bh=tNxpycssazDt0iI4wc/OsewbFOkrxnl3tjY/JqZOqco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LT7yBkZf6FBgjPhVoRwcfRnPdeidN28M6QYOGqE6y8bxrl5MnO+s8dVsmBVAyVLkt8QnQe9LvnVCET99NAU3SIpq32nhZ6t+YM+Q0qdvzTXaYTnViZwutsjXCiPAn7donmciLCiQxAVa7y5vwUppP9XlArf3VXK0TQcyUGa+8cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gqs0L43R; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729757520; x=1761293520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tNxpycssazDt0iI4wc/OsewbFOkrxnl3tjY/JqZOqco=;
  b=Gqs0L43RsImtSWoX3Jozzj3oRzkIuBkaTT2eIPqZma3mPuVrwK70PYUE
   27Ey0B12D6GtKycImwKSjFy+N9ccXvfFI7jC67Q6SyWvWmm/2AcbEnDZT
   M7I/wp2eO6kC7GTXSNpZmWnmXMojKhd5tUU8vmEDG/geXBlHPyGMU/q5d
   ktQiVln8ur77+khkmQJekAqkrQiJjBlkMtyHEXfgUQtZt5WH1g0rKsWZX
   Bzq1XnRE5uBRDzqAxTVcwanIRzJfWecq6Ye63RAPzVfC3TphStrKgfz/F
   DBpEXICfgtXL8P2U68OzCThKz99tDMeQQgI5un1DkNF8T5k1xDtkrKYzH
   A==;
X-CSE-ConnectionGUID: koqb8jVTQSCtPh0Q8I3U/w==
X-CSE-MsgGUID: zStqrv5URS6oaEwERm7b0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29501172"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29501172"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 01:12:00 -0700
X-CSE-ConnectionGUID: qvad9TrpTBWU7mNGrDHfVw==
X-CSE-MsgGUID: 3M+Bn78QTG+482BdLL17dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80691101"
Received: from shsensorbuild.sh.intel.com ([10.239.133.18])
  by orviesa006.jf.intel.com with ESMTP; 24 Oct 2024 01:11:57 -0700
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
Subject: [PATCH v1 22/22] HID: intel-thc-hid: intel-quicki2c: Add PM implementation
Date: Thu, 24 Oct 2024 16:10:23 +0800
Message-Id: <20241024081023.1468951-23-even.xu@intel.com>
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

Implement THC QuickI2C driver power management callbacks.

Co-developed-by: Xinpeng Sun <xinpeng.sun@intel.com>
Signed-off-by: Xinpeng Sun <xinpeng.sun@intel.com>
Signed-off-by: Even Xu <even.xu@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel-quicki2c/pci-quicki2c.c             | 233 ++++++++++++++++++
 .../intel-quicki2c/quicki2c-dev.h             |   8 +
 .../intel-quicki2c/quicki2c-hid.c             |   8 +
 3 files changed, 249 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 0c1082f0da34..707d86aed3dc 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -9,6 +9,7 @@
 #include <linux/irqreturn.h>
 #include <linux/pci.h>
 #include <linux/sizes.h>
+#include <linux/pm_runtime.h>
 
 #include "intel-thc-dev.h"
 #include "intel-thc-hw.h"
@@ -289,10 +290,15 @@ static irqreturn_t quicki2c_irq_thread_handler(int irq, void *dev_id)
 	struct quicki2c_device *qcdev = dev_id;
 	int err_recover = 0;
 	int int_mask;
+	int ret;
 
 	if (qcdev->state == QUICKI2C_DISABLED)
 		return IRQ_HANDLED;
 
+	ret = pm_runtime_resume_and_get(qcdev->dev);
+	if (ret)
+		return IRQ_HANDLED;
+
 	int_mask = thc_interrupt_handler(qcdev->thc_hw);
 
 	if (int_mask & BIT(THC_FATAL_ERR_INT) || int_mask & BIT(THC_TXN_ERR_INT) ||
@@ -314,6 +320,9 @@ static irqreturn_t quicki2c_irq_thread_handler(int irq, void *dev_id)
 		if (try_recover(qcdev))
 			qcdev->state = QUICKI2C_DISABLED;
 
+	pm_runtime_mark_last_busy(qcdev->dev);
+	pm_runtime_put_autosuspend(qcdev->dev);
+
 	return IRQ_HANDLED;
 }
 
@@ -637,6 +646,13 @@ static int quicki2c_probe(struct pci_dev *pdev,
 
 	qcdev->state = QUICKI2C_ENABLED;
 
+	/* Enable runtime power management */
+	pm_runtime_use_autosuspend(qcdev->dev);
+	pm_runtime_set_autosuspend_delay(qcdev->dev, DEFAULT_AUTO_SUSPEND_DELAY_MS);
+	pm_runtime_mark_last_busy(qcdev->dev);
+	pm_runtime_put_noidle(qcdev->dev);
+	pm_runtime_put_autosuspend(qcdev->dev);
+
 	dev_dbg(&pdev->dev, "QuickI2C probe success\n");
 
 	return 0;
@@ -673,6 +689,8 @@ static void quicki2c_remove(struct pci_dev *pdev)
 	quicki2c_hid_remove(qcdev);
 	quicki2c_dma_deinit(qcdev);
 
+	pm_runtime_get_noresume(qcdev->dev);
+
 	quicki2c_dev_deinit(qcdev);
 
 	pcim_iounmap_regions(pdev, BIT(0));
@@ -703,6 +721,220 @@ static void quicki2c_shutdown(struct pci_dev *pdev)
 	quicki2c_dev_deinit(qcdev);
 }
 
+static int quicki2c_suspend(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quicki2c_device *qcdev;
+	int ret;
+
+	qcdev = pci_get_drvdata(pdev);
+	if (!qcdev)
+		return -ENODEV;
+
+	/*
+	 * As I2C is THC subsystem, no register auto save/restore support,
+	 * need driver to do that explicitly for every D3 case.
+	 */
+	ret = thc_i2c_subip_regs_save(qcdev->thc_hw);
+	if (ret)
+		return ret;
+
+	ret = thc_interrupt_quiesce(qcdev->thc_hw, true);
+	if (ret)
+		return ret;
+
+	thc_interrupt_enable(qcdev->thc_hw, false);
+
+	thc_dma_unconfigure(qcdev->thc_hw);
+
+	return 0;
+}
+
+static int quicki2c_resume(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quicki2c_device *qcdev;
+	int ret;
+
+	qcdev = pci_get_drvdata(pdev);
+	if (!qcdev)
+		return -ENODEV;
+
+	ret = thc_port_select(qcdev->thc_hw, THC_PORT_TYPE_I2C);
+	if (ret)
+		return ret;
+
+	ret = thc_i2c_subip_regs_restore(qcdev->thc_hw);
+	if (ret)
+		return ret;
+
+	thc_interrupt_config(qcdev->thc_hw);
+
+	thc_interrupt_enable(qcdev->thc_hw, true);
+
+	ret = thc_dma_configure(qcdev->thc_hw);
+	if (ret)
+		return ret;
+
+	ret = thc_interrupt_quiesce(qcdev->thc_hw, false);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int quicki2c_freeze(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quicki2c_device *qcdev;
+	int ret;
+
+	qcdev = pci_get_drvdata(pdev);
+	if (!qcdev)
+		return -ENODEV;
+
+	ret = thc_interrupt_quiesce(qcdev->thc_hw, true);
+	if (ret)
+		return ret;
+
+	thc_interrupt_enable(qcdev->thc_hw, false);
+
+	thc_dma_unconfigure(qcdev->thc_hw);
+
+	return 0;
+}
+
+static int quicki2c_thaw(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quicki2c_device *qcdev;
+	int ret;
+
+	qcdev = pci_get_drvdata(pdev);
+	if (!qcdev)
+		return -ENODEV;
+
+	ret = thc_dma_configure(qcdev->thc_hw);
+	if (ret)
+		return ret;
+
+	thc_interrupt_enable(qcdev->thc_hw, true);
+
+	ret = thc_interrupt_quiesce(qcdev->thc_hw, false);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int quicki2c_poweroff(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quicki2c_device *qcdev;
+	int ret;
+
+	qcdev = pci_get_drvdata(pdev);
+	if (!qcdev)
+		return -ENODEV;
+
+	ret = thc_interrupt_quiesce(qcdev->thc_hw, true);
+	if (ret)
+		return ret;
+
+	thc_interrupt_enable(qcdev->thc_hw, false);
+
+	thc_ltr_unconfig(qcdev->thc_hw);
+
+	quicki2c_dma_deinit(qcdev);
+
+	return 0;
+}
+
+static int quicki2c_restore(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quicki2c_device *qcdev;
+	int ret;
+
+	qcdev = pci_get_drvdata(pdev);
+	if (!qcdev)
+		return -ENODEV;
+
+	/* Reconfig THC HW when back from hibernate */
+	ret = thc_port_select(qcdev->thc_hw, THC_PORT_TYPE_I2C);
+	if (ret)
+		return ret;
+
+	ret = thc_i2c_subip_init(qcdev->thc_hw, qcdev->i2c_slave_addr,
+				 qcdev->i2c_speed_mode,
+				 qcdev->i2c_clock_hcnt,
+				 qcdev->i2c_clock_lcnt);
+	if (ret)
+		return ret;
+
+	thc_interrupt_config(qcdev->thc_hw);
+
+	thc_interrupt_enable(qcdev->thc_hw, true);
+
+	ret = thc_interrupt_quiesce(qcdev->thc_hw, false);
+	if (ret)
+		return ret;
+
+	ret = thc_dma_configure(qcdev->thc_hw);
+	if (ret)
+		return ret;
+
+	thc_ltr_config(qcdev->thc_hw,
+		       qcdev->active_ltr_val,
+		       qcdev->low_power_ltr_val);
+
+	thc_change_ltr_mode(qcdev->thc_hw, THC_LTR_MODE_ACTIVE);
+
+	return 0;
+}
+
+static int quicki2c_runtime_suspend(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quicki2c_device *qcdev;
+
+	qcdev = pci_get_drvdata(pdev);
+	if (!qcdev)
+		return -ENODEV;
+
+	thc_change_ltr_mode(qcdev->thc_hw, THC_LTR_MODE_LP);
+
+	pci_save_state(pdev);
+
+	return 0;
+}
+
+static int quicki2c_runtime_resume(struct device *device)
+{
+	struct pci_dev *pdev = to_pci_dev(device);
+	struct quicki2c_device *qcdev;
+
+	qcdev = pci_get_drvdata(pdev);
+	if (!qcdev)
+		return -ENODEV;
+
+	thc_change_ltr_mode(qcdev->thc_hw, THC_LTR_MODE_ACTIVE);
+
+	return 0;
+}
+
+static const struct dev_pm_ops quicki2c_pm_ops = {
+	.suspend = quicki2c_suspend,
+	.resume = quicki2c_resume,
+	.freeze = quicki2c_freeze,
+	.thaw = quicki2c_thaw,
+	.poweroff = quicki2c_poweroff,
+	.restore = quicki2c_restore,
+	.runtime_suspend = quicki2c_runtime_suspend,
+	.runtime_resume = quicki2c_runtime_resume,
+	.runtime_idle = NULL,
+};
+
 static const struct pci_device_id quicki2c_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, THC_LNL_DEVICE_ID_I2C_PORT1), },
 	{PCI_VDEVICE(INTEL, THC_LNL_DEVICE_ID_I2C_PORT2), },
@@ -716,6 +948,7 @@ static struct pci_driver quicki2c_driver = {
 	.probe = quicki2c_probe,
 	.remove = quicki2c_remove,
 	.shutdown = quicki2c_shutdown,
+	.driver.pm = &quicki2c_pm_ops,
 	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 };
 
diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
index d9fac30da827..00aaf094d2d3 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
@@ -32,6 +32,14 @@
 #define QUICKI2C_DEFAULT_LP_LTR_VALUE		500
 #define QUICKI2C_RPM_TIMEOUT_MS			500
 
+/*
+ * THC uses runtime auto suspend to dynamically switch between THC active LTR
+ * and low power LTR to save CPU power.
+ * Default value is 5000ms, that means if no touch event in this time, THC will
+ * change to low power LTR mode.
+ */
+#define DEFAULT_AUTO_SUSPEND_DELAY_MS			5000
+
 enum quicki2c_dev_state {
 	QUICKI2C_NONE,
 	QUICKI2C_RESETING,
diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
index e8e6f10b7952..5c3ec95bb3fd 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
@@ -3,6 +3,7 @@
 
 #include <linux/hid.h>
 #include <linux/input.h>
+#include <linux/pm_runtime.h>
 
 #include "quicki2c-dev.h"
 #include "quicki2c-hid.h"
@@ -55,6 +56,10 @@ static int quicki2c_hid_raw_request(struct hid_device *hid,
 	struct quicki2c_device *qcdev = hid->driver_data;
 	int ret = 0;
 
+	ret = pm_runtime_resume_and_get(qcdev->dev);
+	if (ret)
+		return ret;
+
 	switch (reqtype) {
 	case HID_REQ_GET_REPORT:
 		ret = quicki2c_get_report(qcdev, rtype, reportnum, buf, len);
@@ -67,6 +72,9 @@ static int quicki2c_hid_raw_request(struct hid_device *hid,
 		break;
 	}
 
+	pm_runtime_mark_last_busy(qcdev->dev);
+	pm_runtime_put_autosuspend(qcdev->dev);
+
 	return ret;
 }
 
-- 
2.40.1


