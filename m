Return-Path: <linux-kernel+bounces-379430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BBB9ADE93
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF8BEB251B3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8E41B3943;
	Thu, 24 Oct 2024 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBpCU+mE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00AC1B3921;
	Thu, 24 Oct 2024 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757469; cv=none; b=FFn15v90R4YT3HWDGQnsIXa06Te460WchFcmm/z0QMcIYTHUYf69ItC6xd/5PrK04jwt9pQOZ3j10CBsfsXD5ibrxZauZgS7K/Lwr43qOdXqLk6wc6v/GL/WaRtHNMeUnh1e2ibEci3uO5elo3MnF/wJjEVRx7RHhVMtqmzRekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757469; c=relaxed/simple;
	bh=eOX4NyiGfdQip6h9XMok0AkWnPC3Qx9h8Mcyt7i9TA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V0/n9XxfBOjdkh3cHhN+jhCi0or0VGMQtKDGvPCejMCu4oIvayI/QVKvXh7YFY1XAcgckLO9uWllGTfDkD72ZKR/42xgJMSitWaZXcIm4ZgFHUBN2M7w8FV52w3dEgkBGaxRLpADV6ewPtcQIiwx9V90cJ40q7vBckq6LQ3qUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBpCU+mE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729757467; x=1761293467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eOX4NyiGfdQip6h9XMok0AkWnPC3Qx9h8Mcyt7i9TA8=;
  b=lBpCU+mEinsYHavS4G7gbWBEj0frj0UF3ndL1GNSwjih6z1dDKKbKmD8
   oYM+2gbGwBv8XVjIjLFnnCkNFlgQ5Nw+35TZ2/wTJbBGHEW2YhX5lnr3f
   hgqJOq/CoFFcDZsNnkS6CLAy+ygShl1fVJWSCJxxStQ+BDVXgwp1D3b2v
   uVA02Uff4pKPJOxNbtYChAnumqSKn8wWLI+vkVobv1nvQbmIJVW4tSUSB
   KZBFAy7GIumD4UeVrXj9F15VcVRXlzdBGe33VbwmwjZSpuqIeKk0qsYSr
   fq1AieQAn92DXaf1P5FXUO/Dk+p+EyeHrDh+WKRVV60kr/EWlZdZ0q2dc
   Q==;
X-CSE-ConnectionGUID: XDEOAMJuQxyI/Tlx/trPpA==
X-CSE-MsgGUID: 2NdtX0FWT3Sz4m4cbkvDGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29501002"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29501002"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 01:11:06 -0700
X-CSE-ConnectionGUID: VE7tUM8uSBWAMXyC3W1rCg==
X-CSE-MsgGUID: WcqGn/wRRwiFPSqJbSOthQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80690748"
Received: from shsensorbuild.sh.intel.com ([10.239.133.18])
  by orviesa006.jf.intel.com with ESMTP; 24 Oct 2024 01:11:03 -0700
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
Subject: [PATCH v1 05/22] HID: intel-thc-hid: intel-thc: Add APIs for interrupt
Date: Thu, 24 Oct 2024 16:10:06 +0800
Message-Id: <20241024081023.1468951-6-even.xu@intel.com>
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

Add THC interrupt operation interfaces, such as interrupt configure,
global interrupt enable/disable, external touch device GPIO interrupt
quiesce and unquiesce.

Co-developed-by: Even Xu <even.xu@intel.com>
Signed-off-by: Even Xu <even.xu@intel.com>
Signed-off-by: Xinpeng Sun <xinpeng.sun@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel-thc-hid/intel-thc/intel-thc-dev.c   | 219 ++++++++++++++++++
 .../intel-thc-hid/intel-thc/intel-thc-dev.h   |   5 +
 .../intel-thc-hid/intel-thc/intel-thc-hw.h    |  17 ++
 3 files changed, 241 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
index 0571b8270716..317eb21a22ec 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
@@ -325,6 +325,225 @@ int thc_tic_pio_write_and_read(struct thc_device *dev, const u32 address,
 }
 EXPORT_SYMBOL_NS_GPL(thc_tic_pio_write_and_read, INTEL_THC);
 
+/**
+ * thc_interrupt_config - Configure THC interrupts
+ *
+ * @dev: The pointer of THC private device context
+ */
+void thc_interrupt_config(struct thc_device *dev)
+{
+	u32 mbits, mask, r_dma_ctrl_1;
+
+	/* Clear Error reporting interrupt status bits */
+	mbits = THC_M_PRT_INT_STATUS_TXN_ERR_INT_STS |
+		THC_M_PRT_INT_STATUS_FATAL_ERR_INT_STS;
+	regmap_write_bits(dev->thc_regmap,
+			  THC_M_PRT_INT_STATUS_OFFSET,
+			  mbits, mbits);
+
+	/* Enable Error Reporting Interrupts */
+	mbits = THC_M_PRT_INT_EN_TXN_ERR_INT_EN |
+		THC_M_PRT_INT_EN_FATAL_ERR_INT_EN |
+		THC_M_PRT_INT_EN_BUF_OVRRUN_ERR_INT_EN;
+	regmap_write_bits(dev->thc_regmap,
+			  THC_M_PRT_INT_EN_OFFSET,
+			  mbits, mbits);
+
+	/* Clear PIO Interrupt status bits */
+	mbits = THC_M_PRT_SW_SEQ_STS_THC_SS_ERR |
+		THC_M_PRT_SW_SEQ_STS_TSSDONE;
+	regmap_write_bits(dev->thc_regmap,
+			  THC_M_PRT_SW_SEQ_STS_OFFSET,
+			  mbits, mbits);
+
+	/* Read Interrupts */
+	regmap_read(dev->thc_regmap,
+		    THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
+		    &r_dma_ctrl_1);
+	/* Disable RxDMA1 */
+	r_dma_ctrl_1 &= ~THC_M_PRT_READ_DMA_CNTRL_IE_EOF;
+	regmap_write(dev->thc_regmap,
+		     THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
+		     r_dma_ctrl_1);
+
+	/* Ack EOF Interrupt RxDMA1 */
+	mbits = THC_M_PRT_READ_DMA_INT_STS_EOF_INT_STS;
+	/* Ack NonDMA Interrupt */
+	mbits |= THC_M_PRT_READ_DMA_INT_STS_NONDMA_INT_STS;
+	regmap_write_bits(dev->thc_regmap,
+			  THC_M_PRT_READ_DMA_INT_STS_1_OFFSET,
+			  mbits, mbits);
+
+	/* Ack EOF Interrupt RxDMA2 */
+	regmap_write_bits(dev->thc_regmap,
+			  THC_M_PRT_READ_DMA_INT_STS_2_OFFSET,
+			  THC_M_PRT_READ_DMA_INT_STS_EOF_INT_STS,
+			  THC_M_PRT_READ_DMA_INT_STS_EOF_INT_STS);
+
+	/* Write Interrupts */
+	/* Disable TxDMA */
+	regmap_write_bits(dev->thc_regmap,
+			  THC_M_PRT_WRITE_DMA_CNTRL_OFFSET,
+			  THC_M_PRT_WRITE_DMA_CNTRL_THC_WRDMA_IE_IOC_DMACPL,
+			  0);
+
+	/* Clear TxDMA interrupt status bits */
+	mbits = THC_M_PRT_WRITE_INT_STS_THC_WRDMA_ERROR_STS;
+	mbits |=  THC_M_PRT_WRITE_INT_STS_THC_WRDMA_IOC_STS;
+	regmap_write_bits(dev->thc_regmap,
+			  THC_M_PRT_WRITE_INT_STS_OFFSET,
+			  mbits, mbits);
+
+	/* Enable Non-DMA device inband interrupt */
+	r_dma_ctrl_1 |= THC_M_PRT_READ_DMA_CNTRL_IE_NDDI;
+	regmap_write(dev->thc_regmap,
+		     THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
+		     r_dma_ctrl_1);
+
+	if (dev->port_type == THC_PORT_TYPE_SPI) {
+		/* Edge triggered interrupt */
+		regmap_write_bits(dev->thc_regmap, THC_M_PRT_TSEQ_CNTRL_1_OFFSET,
+				  THC_M_PRT_TSEQ_CNTRL_1_INT_EDG_DET_EN,
+				  THC_M_PRT_TSEQ_CNTRL_1_INT_EDG_DET_EN);
+	} else {
+		/* Level triggered interrupt */
+		regmap_write_bits(dev->thc_regmap, THC_M_PRT_TSEQ_CNTRL_1_OFFSET,
+				  THC_M_PRT_TSEQ_CNTRL_1_INT_EDG_DET_EN, 0);
+
+		mbits = THC_M_PRT_INT_EN_THC_I2C_IC_MST_ON_HOLD_INT_EN |
+			THC_M_PRT_INT_EN_THC_I2C_IC_SCL_STUCK_AT_LOW_DET_INT_EN |
+			THC_M_PRT_INT_EN_THC_I2C_IC_TX_ABRT_INT_EN |
+			THC_M_PRT_INT_EN_THC_I2C_IC_TX_OVER_INT_EN |
+			THC_M_PRT_INT_EN_THC_I2C_IC_RX_FULL_INT_EN |
+			THC_M_PRT_INT_EN_THC_I2C_IC_RX_OVER_INT_EN |
+			THC_M_PRT_INT_EN_THC_I2C_IC_RX_UNDER_INT_EN;
+		regmap_write_bits(dev->thc_regmap, THC_M_PRT_INT_EN_OFFSET,
+				  mbits, mbits);
+	}
+
+	thc_set_pio_interrupt_support(dev, false);
+
+	/* HIDSPI specific settings */
+	if (dev->port_type == THC_PORT_TYPE_SPI) {
+		mbits = FIELD_PREP(THC_M_PRT_DEVINT_CFG_1_THC_M_PRT_INTTYP_OFFSET,
+				   THC_BIT_OFFSET_INTERRUPT_TYPE) |
+			FIELD_PREP(THC_M_PRT_DEVINT_CFG_1_THC_M_PRT_INTTYP_LEN,
+				   THC_BIT_LENGTH_INTERRUPT_TYPE) |
+			FIELD_PREP(THC_M_PRT_DEVINT_CFG_1_THC_M_PRT_EOF_OFFSET,
+				   THC_BIT_OFFSET_LAST_FRAGMENT_FLAG) |
+			FIELD_PREP(THC_M_PRT_DEVINT_CFG_1_THC_M_PRT_INTTYP_DATA_VAL,
+				   THC_BITMASK_INVALID_TYPE_DATA);
+		mask = THC_M_PRT_DEVINT_CFG_1_THC_M_PRT_INTTYP_OFFSET |
+		       THC_M_PRT_DEVINT_CFG_1_THC_M_PRT_INTTYP_LEN |
+		       THC_M_PRT_DEVINT_CFG_1_THC_M_PRT_EOF_OFFSET |
+		       THC_M_PRT_DEVINT_CFG_1_THC_M_PRT_INTTYP_DATA_VAL;
+		regmap_write_bits(dev->thc_regmap, THC_M_PRT_DEVINT_CFG_1_OFFSET,
+				  mask, mbits);
+
+		mbits = FIELD_PREP(THC_M_PRT_DEVINT_CFG_2_THC_M_PRT_UFSIZE_OFFSET,
+				   THC_BIT_OFFSET_MICROFRAME_SIZE) |
+			FIELD_PREP(THC_M_PRT_DEVINT_CFG_2_THC_M_PRT_UFSIZE_LEN,
+				   THC_BIT_LENGTH_MICROFRAME_SIZE) |
+			FIELD_PREP(THC_M_PRT_DEVINT_CFG_2_THC_M_PRT_UFSIZE_UNIT,
+				   THC_UNIT_MICROFRAME_SIZE) |
+			THC_M_PRT_DEVINT_CFG_2_THC_M_PRT_FTYPE_IGNORE |
+			THC_M_PRT_DEVINT_CFG_2_THC_M_PRT_FTYPE_VAL;
+		mask = THC_M_PRT_DEVINT_CFG_2_THC_M_PRT_UFSIZE_OFFSET |
+		       THC_M_PRT_DEVINT_CFG_2_THC_M_PRT_UFSIZE_LEN |
+		       THC_M_PRT_DEVINT_CFG_2_THC_M_PRT_UFSIZE_UNIT |
+		       THC_M_PRT_DEVINT_CFG_2_THC_M_PRT_FTYPE_IGNORE |
+		       THC_M_PRT_DEVINT_CFG_2_THC_M_PRT_FTYPE_VAL;
+		regmap_write_bits(dev->thc_regmap, THC_M_PRT_DEVINT_CFG_2_OFFSET,
+				  mask, mbits);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(thc_interrupt_config, INTEL_THC);
+
+/**
+ * thc_int_trigger_type_select - Select THC interrupt trigger type
+ *
+ * @dev: the pointer of THC private device context
+ * @edge_trigger: determine the interrupt is edge triggered or level triggered
+ */
+void thc_int_trigger_type_select(struct thc_device *dev, bool edge_trigger)
+{
+	regmap_write_bits(dev->thc_regmap, THC_M_PRT_TSEQ_CNTRL_1_OFFSET,
+			  THC_M_PRT_TSEQ_CNTRL_1_INT_EDG_DET_EN,
+			  edge_trigger ? THC_M_PRT_TSEQ_CNTRL_1_INT_EDG_DET_EN : 0);
+}
+EXPORT_SYMBOL_NS_GPL(thc_int_trigger_type_select, INTEL_THC);
+
+/**
+ * thc_interrupt_enable - Enable or disable THC interrupt
+ *
+ * @dev: the pointer of THC private device context
+ * @int_enable: the flag to control THC interrupt enable or disable
+ */
+void thc_interrupt_enable(struct thc_device *dev, bool int_enable)
+{
+	regmap_write_bits(dev->thc_regmap, THC_M_PRT_INT_EN_OFFSET,
+			  THC_M_PRT_INT_EN_GBL_INT_EN,
+			  int_enable ? THC_M_PRT_INT_EN_GBL_INT_EN : 0);
+}
+EXPORT_SYMBOL_NS_GPL(thc_interrupt_enable, INTEL_THC);
+
+/**
+ * thc_interrupt_quiesce - Quiesce or unquiesce external touch device interrupt
+ *
+ * @dev: the pointer of THC private device context
+ * @int_quiesce: the flag to determine quiesce or unquiesce device interrupt
+ *
+ * Return: 0 on success, other error codes on failed
+ */
+int thc_interrupt_quiesce(const struct thc_device *dev, bool int_quiesce)
+{
+	u32 ctrl;
+	int ret;
+
+	regmap_read(dev->thc_regmap, THC_M_PRT_CONTROL_OFFSET, &ctrl);
+	if (!(ctrl & THC_M_PRT_CONTROL_THC_DEVINT_QUIESCE_HW_STS) && !int_quiesce) {
+		dev_warn(dev->dev, "THC interrupt already unquiesce\n");
+		return 0;
+	}
+
+	/* Quiesce device interrupt - Set quiesce bit and waiting for THC HW to ACK */
+	if (int_quiesce) {
+		regmap_write_bits(dev->thc_regmap, THC_M_PRT_CONTROL_OFFSET,
+				  THC_M_PRT_CONTROL_THC_DEVINT_QUIESCE_EN,
+				  THC_M_PRT_CONTROL_THC_DEVINT_QUIESCE_EN);
+	}
+
+	ret = regmap_read_poll_timeout(dev->thc_regmap, THC_M_PRT_CONTROL_OFFSET, ctrl,
+				       ctrl & THC_M_PRT_CONTROL_THC_DEVINT_QUIESCE_HW_STS,
+				       THC_REGMAP_POLLING_INTERVAL_US, THC_QUIESCE_EN_TIMEOUT_US);
+	if (ret) {
+		dev_err_once(dev->dev,
+			     "Timeout while waiting THC enter into interrupt quiesce state\n");
+		return ret;
+	}
+
+	/* Unquiesce device interrupt - Clear the quiesce bit */
+	if (!int_quiesce) {
+		ctrl &= ~THC_M_PRT_CONTROL_THC_DEVINT_QUIESCE_EN;
+		regmap_write(dev->thc_regmap, THC_M_PRT_CONTROL_OFFSET, ctrl);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(thc_interrupt_quiesce, INTEL_THC);
+
+/**
+ * thc_set_pio_interrupt_support - Determine PIO interrupt is supported or not
+ *
+ * @dev: The pointer of THC private device context
+ * @supported: The flag to determine enabling PIO interrupt or not
+ */
+void thc_set_pio_interrupt_support(struct thc_device *dev, bool supported)
+{
+	dev->pio_int_supported = supported;
+}
+EXPORT_SYMBOL_NS_GPL(thc_set_pio_interrupt_support, INTEL_THC);
+
 MODULE_AUTHOR("Xinpeng Sun <xinpeng.sun@intel.com>");
 MODULE_AUTHOR("Even Xu <even.xu@intel.com>");
 
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
index 88a9f606a6a9..bef48c25c195 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
@@ -45,5 +45,10 @@ int thc_tic_pio_write(struct thc_device *dev, const u32 address,
 int thc_tic_pio_write_and_read(struct thc_device *dev, const u32 address,
 			       const u32 write_size, const u32 *write_buffer,
 			       const u32 read_size, u32 *actual_size, u32 *read_buffer);
+void thc_interrupt_config(struct thc_device *dev);
+void thc_int_trigger_type_select(struct thc_device *dev, bool edge_trigger);
+void thc_interrupt_enable(struct thc_device *dev, bool int_enable);
+void thc_set_pio_interrupt_support(struct thc_device *dev, bool supported);
+int thc_interrupt_quiesce(const struct thc_device *dev, bool int_quiesce);
 
 #endif /* _INTEL_THC_DEV_H_ */
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
index 9f5f39dcedcd..d4b67b81e954 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
@@ -636,6 +636,23 @@
 #define THC_REGMAP_POLLING_INTERVAL_US		10 /* 10us */
 #define THC_PIO_DONE_TIMEOUT_US			USEC_PER_SEC /* 1s */
 
+/* Default configures for HIDSPI */
+#define THC_BIT_OFFSET_INTERRUPT_TYPE		4
+/* input_report_type is 4 bits for HIDSPI */
+#define THC_BIT_LENGTH_INTERRUPT_TYPE		4
+/* Last fragment indicator is bit 15 for HIDSPI */
+#define THC_BIT_OFFSET_LAST_FRAGMENT_FLAG	22
+#define THC_BIT_OFFSET_MICROFRAME_SIZE		8
+/* input_report_length is 14 bits for HIDSPI */
+#define THC_BIT_LENGTH_MICROFRAME_SIZE		14
+/* MFS unit in power of 2 */
+#define THC_UNIT_MICROFRAME_SIZE		2
+#define THC_BITMASK_INTERRUPT_TYPE_DATA		1
+#define THC_BITMASK_INVALID_TYPE_DATA		2
+
+/* Interrupt Quiesce default timeout value */
+#define THC_QUIESCE_EN_TIMEOUT_US		USEC_PER_SEC /* 1s */
+
 /*
  * THC PIO opcode default value
  * @THC_PIO_OP_SPI_TIC_READ: THC opcode for SPI PIO read
-- 
2.40.1


