Return-Path: <linux-kernel+bounces-379429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DEF9ADE91
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725B01F2340E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F034F1B392B;
	Thu, 24 Oct 2024 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnEI+xjE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301BB1AF0CB;
	Thu, 24 Oct 2024 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757467; cv=none; b=fW7+rZCgGXWjrqltkZqCJKelf98PdSLI5deCqm580qEgaWjzitbi5dJfabLk0J5uJyDJxzoVfmtWKXxHnMivqdiDMmEfH6DTsPm35RK5q9WivP54jIfAa4r2WcZtBfNLp4oy5bauttNSG55vozX7zuBgl9MphzwtzPmWkN0VolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757467; c=relaxed/simple;
	bh=1XJsBS1LT3ck3XELtE6Cfnyf3BM6hYOMjaKwmJkmQFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WgbngGV3cbIciVEa5kjLUtCRXE4mBxzbjFUu/VO4TDtf9j7cga3baNjTvpH6u4hcn5H6dyi9bqTn3ZTsoGh/0ngRYlNTkHyZzCKRng+ANzYWzeWZt5MY6LCP/SAOA6ibIBbCioJcOKjFm+QHYr1XrNai+lkM7wl5N0OBtamwnqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnEI+xjE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729757465; x=1761293465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1XJsBS1LT3ck3XELtE6Cfnyf3BM6hYOMjaKwmJkmQFw=;
  b=ZnEI+xjEGOXgPdQ/RoX+COhHOPSAshpWi+hYZc/N0gVMVyxM2RXxmgC5
   pAbycs3kGD3Q56p2R7TzVFOnuhq71oacz6bWcl9HVKwj1Hv+Zwg/fx+dj
   SpmzYCBolcCAdbM3Mu2Cv3j+a2PTbNsED1XxNFXQtdPle36qLutMGJv9o
   K3j9hE2Bq/RpSywwJiNG6hu32E8PXrVxWSZGMCBpEv5GPh547iFp47M/6
   62s7l/H93XIgEQUwXClPiQJRxvI6a2MR8bFbzWcfgqW78USvY5lSn4xHV
   96ZAzdLDCeRFzfD1uEs6nLrPmy9jVR5KDwtDbYS13L0mZzagCMaKBpUt/
   w==;
X-CSE-ConnectionGUID: TOGn02bpR12xFCIZxcsutw==
X-CSE-MsgGUID: 9W0da3H9RAaiE1kpOPt1OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29500991"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29500991"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 01:11:04 -0700
X-CSE-ConnectionGUID: IHSQYPyoRCe5BdKbGjG1QQ==
X-CSE-MsgGUID: 4QXMjVzvTlKo9OsypBHbLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80690732"
Received: from shsensorbuild.sh.intel.com ([10.239.133.18])
  by orviesa006.jf.intel.com with ESMTP; 24 Oct 2024 01:11:00 -0700
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
Subject: [PATCH v1 04/22] HID: intel-thc-hid: intel-thc: Add THC PIO operation APIs
Date: Thu, 24 Oct 2024 16:10:05 +0800
Message-Id: <20241024081023.1468951-5-even.xu@intel.com>
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

THC PIO (programmed I/O) operations are very similar with general
SPI/I2C read/write operation to access external slave device on the bus
through internal FIFO.

THC PIO operations are split into 4 steps:
1. prepare: configure hardware with correct opcode, slave address, and
            fill the PIO FIFO
2. start: set start bit to issue a bus send/receive
3. wait: wait for bus sending/receiving completion
4. complete: check send/receive data in FIFO and return

Co-developed-by: Even Xu <even.xu@intel.com>
Signed-off-by: Even Xu <even.xu@intel.com>
Signed-off-by: Xinpeng Sun <xinpeng.sun@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel-thc-hid/intel-thc/intel-thc-dev.c   | 245 ++++++++++++++++++
 .../intel-thc-hid/intel-thc/intel-thc-dev.h   |  24 ++
 .../intel-thc-hid/intel-thc/intel-thc-hw.h    |  23 ++
 3 files changed, 292 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
index d77603e4c01e..0571b8270716 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
@@ -1,9 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2024 Intel Corporation */
 
+#include <linux/bitfield.h>
 #include <linux/regmap.h>
 
 #include "intel-thc-dev.h"
+#include "intel-thc-hw.h"
 
 static int thc_regmap_read(void *context, unsigned int reg,
 			   unsigned int *val)
@@ -76,10 +78,253 @@ struct thc_device *thc_dev_init(struct device *device, void __iomem *mem_addr)
 		return ERR_PTR(ret);
 	}
 
+	mutex_init(&thc_dev->thc_bus_lock);
+
 	return thc_dev;
 }
 EXPORT_SYMBOL_NS_GPL(thc_dev_init, INTEL_THC);
 
+static int prepare_pio(const struct thc_device *dev, const u8 pio_op,
+		       const u32 address, const u32 size)
+{
+	u32 sts, ctrl, addr, mask;
+
+	regmap_read(dev->thc_regmap, THC_M_PRT_SW_SEQ_STS_OFFSET, &sts);
+
+	/* Check if THC previous PIO still in progress */
+	if (sts & THC_M_PRT_SW_SEQ_STS_THC_SS_CIP) {
+		dev_err_once(dev->dev, "THC PIO is still busy!\n");
+		return -EBUSY;
+	}
+
+	/* Clear error bit and complete bit in state register */
+	sts |= THC_M_PRT_SW_SEQ_STS_THC_SS_ERR |
+	       THC_M_PRT_SW_SEQ_STS_TSSDONE;
+	regmap_write(dev->thc_regmap, THC_M_PRT_SW_SEQ_STS_OFFSET, sts);
+
+	/* Set PIO data size, opcode and interrupt capability */
+	ctrl = FIELD_PREP(THC_M_PRT_SW_SEQ_CNTRL_THC_SS_BC, size) |
+	       FIELD_PREP(THC_M_PRT_SW_SEQ_CNTRL_THC_SS_CMD, pio_op);
+	if (dev->pio_int_supported)
+		ctrl |= THC_M_PRT_SW_SEQ_CNTRL_THC_SS_CD_IE;
+
+	mask = THC_M_PRT_SW_SEQ_CNTRL_THC_SS_BC |
+	       THC_M_PRT_SW_SEQ_CNTRL_THC_SS_CMD |
+	       THC_M_PRT_SW_SEQ_CNTRL_THC_SS_CD_IE;
+	regmap_write_bits(dev->thc_regmap,
+			  THC_M_PRT_SW_SEQ_CNTRL_OFFSET, mask, ctrl);
+
+	/* Set PIO target address */
+	addr = FIELD_PREP(THC_M_PRT_SW_SEQ_DATA0_ADDR_THC_SW_SEQ_DATA0_ADDR, address);
+	mask = THC_M_PRT_SW_SEQ_DATA0_ADDR_THC_SW_SEQ_DATA0_ADDR;
+	regmap_write_bits(dev->thc_regmap,
+			  THC_M_PRT_SW_SEQ_DATA0_ADDR_OFFSET, mask, addr);
+	return 0;
+}
+
+static void pio_start(const struct thc_device *dev,
+		      u32 size_in_bytes, const u32 *buffer)
+{
+	if (size_in_bytes && buffer)
+		regmap_bulk_write(dev->thc_regmap, THC_M_PRT_SW_SEQ_DATA1_OFFSET,
+				  buffer, size_in_bytes / sizeof(u32));
+
+	/* Enable Start bit */
+	regmap_write_bits(dev->thc_regmap,
+			  THC_M_PRT_SW_SEQ_CNTRL_OFFSET,
+			  THC_M_PRT_SW_SEQ_CNTRL_TSSGO,
+			  THC_M_PRT_SW_SEQ_CNTRL_TSSGO);
+}
+
+static int pio_complete(const struct thc_device *dev,
+			u32 *buffer, u32 *size)
+{
+	u32 sts, ctrl;
+
+	regmap_read(dev->thc_regmap, THC_M_PRT_SW_SEQ_STS_OFFSET, &sts);
+	if (sts & THC_M_PRT_SW_SEQ_STS_THC_SS_ERR) {
+		dev_err_once(dev->dev, "PIO operation error\n");
+		return -EBUSY;
+	}
+
+	if (buffer && size) {
+		regmap_read(dev->thc_regmap, THC_M_PRT_SW_SEQ_CNTRL_OFFSET, &ctrl);
+		*size = FIELD_GET(THC_M_PRT_SW_SEQ_CNTRL_THC_SS_BC, ctrl);
+
+		regmap_bulk_read(dev->thc_regmap, THC_M_PRT_SW_SEQ_DATA1_OFFSET,
+				 buffer, *size / sizeof(u32));
+	}
+
+	sts |= THC_M_PRT_SW_SEQ_STS_THC_SS_ERR | THC_M_PRT_SW_SEQ_STS_TSSDONE;
+	regmap_write(dev->thc_regmap, THC_M_PRT_SW_SEQ_STS_OFFSET, sts);
+	return 0;
+}
+
+static int pio_wait(const struct thc_device *dev)
+{
+	u32 sts = 0;
+	int ret;
+
+	ret = regmap_read_poll_timeout(dev->thc_regmap, THC_M_PRT_SW_SEQ_STS_OFFSET, sts,
+				       !(sts & THC_M_PRT_SW_SEQ_STS_THC_SS_CIP ||
+				       !(sts & THC_M_PRT_SW_SEQ_STS_TSSDONE)),
+				       THC_REGMAP_POLLING_INTERVAL_US, THC_PIO_DONE_TIMEOUT_US);
+	if (ret)
+		dev_err_once(dev->dev, "Timeout while polling PIO operation done\n");
+
+	return ret;
+}
+
+/**
+ * thc_tic_pio_read - Read data from touch device by PIO
+ *
+ * @dev: The pointer of THC private device context
+ * @address: Slave address for the PIO operation
+ * @size: Expected read data size
+ * @actual_size: The pointer of the actual data size read from touch device
+ * @buffer: The pointer of data buffer to store the data read from touch device
+ *
+ * Return: 0 on success, other error codes on failed.
+ */
+int thc_tic_pio_read(struct thc_device *dev, const u32 address,
+		     const u32 size, u32 *actual_size, u32 *buffer)
+{
+	u8 opcode;
+	int ret;
+
+	if (size <= 0 || !actual_size || !buffer) {
+		dev_err(dev->dev, "Invalid input parameters, size %u, actual_size %p, buffer %p\n",
+			size, actual_size, buffer);
+		return -EINVAL;
+	}
+
+	if (mutex_lock_interruptible(&dev->thc_bus_lock))
+		return -EINTR;
+
+	opcode = (dev->port_type == THC_PORT_TYPE_SPI) ?
+		 THC_PIO_OP_SPI_TIC_READ : THC_PIO_OP_I2C_TIC_READ;
+
+	ret = prepare_pio(dev, opcode, address, size);
+	if (ret < 0)
+		goto end;
+
+	pio_start(dev, 0, NULL);
+
+	ret = pio_wait(dev);
+	if (ret < 0)
+		goto end;
+
+	ret = pio_complete(dev, buffer, actual_size);
+
+end:
+	mutex_unlock(&dev->thc_bus_lock);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(thc_tic_pio_read, INTEL_THC);
+
+/**
+ * thc_tic_pio_write - Write data to touch device by PIO
+ *
+ * @dev: The pointer of THC private device context
+ * @address: Slave address for the PIO operation
+ * @size: PIO write data size
+ * @buffer: The pointer of the write data buffer
+ *
+ * Return: 0 on success, other error codes on failed.
+ */
+int thc_tic_pio_write(struct thc_device *dev, const u32 address,
+		      const u32 size, const u32 *buffer)
+{
+	u8 opcode;
+	int ret;
+
+	if (size <= 0 || !buffer) {
+		dev_err(dev->dev, "Invalid input parameters, size %u, buffer %p\n",
+			size, buffer);
+		return -EINVAL;
+	}
+
+	if (mutex_lock_interruptible(&dev->thc_bus_lock))
+		return -EINTR;
+
+	opcode = (dev->port_type == THC_PORT_TYPE_SPI) ?
+		 THC_PIO_OP_SPI_TIC_WRITE : THC_PIO_OP_I2C_TIC_WRITE;
+
+	ret = prepare_pio(dev, opcode, address, size);
+	if (ret < 0)
+		goto end;
+
+	pio_start(dev, size, buffer);
+
+	ret = pio_wait(dev);
+	if (ret < 0)
+		goto end;
+
+	ret = pio_complete(dev, NULL, NULL);
+
+end:
+	mutex_unlock(&dev->thc_bus_lock);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(thc_tic_pio_write, INTEL_THC);
+
+/**
+ * thc_tic_pio_write_and_read - Write data followed by read data by PIO
+ *
+ * @dev: The pointer of THC private device context
+ * @address: Slave address for the PIO operation
+ * @write_size: PIO write data size
+ * @write_buffer: The pointer of the write data buffer
+ * @read_size: Expected PIO read data size
+ * @actual_size: The pointer of the actual read data size
+ * @read_buffer: The pointer of PIO read data buffer
+ *
+ * Return: 0 on success, other error codes on failed.
+ */
+int thc_tic_pio_write_and_read(struct thc_device *dev, const u32 address,
+			       const u32 write_size, const u32 *write_buffer,
+			       const u32 read_size, u32 *actual_size, u32 *read_buffer)
+{
+	u32 i2c_ctrl, mask;
+	int ret;
+
+	if (dev->port_type == THC_PORT_TYPE_SPI) {
+		dev_err(dev->dev, "SPI port type doesn't support pio write and read!");
+		return -EINVAL;
+	}
+
+	if (mutex_lock_interruptible(&dev->thc_bus_lock))
+		return -EINTR;
+
+	/* Config i2c PIO write and read sequence */
+	i2c_ctrl = FIELD_PREP(THC_M_PRT_SW_SEQ_I2C_WR_CNTRL_THC_PIO_I2C_WBC, write_size);
+	mask = THC_M_PRT_SW_SEQ_I2C_WR_CNTRL_THC_PIO_I2C_WBC;
+
+	regmap_write_bits(dev->thc_regmap, THC_M_PRT_SW_SEQ_I2C_WR_CNTRL_OFFSET,
+			  mask, i2c_ctrl);
+
+	regmap_write_bits(dev->thc_regmap, THC_M_PRT_SW_SEQ_I2C_WR_CNTRL_OFFSET,
+			  THC_M_PRT_SW_SEQ_I2C_WR_CNTRL_THC_I2C_RW_PIO_EN,
+			  THC_M_PRT_SW_SEQ_I2C_WR_CNTRL_THC_I2C_RW_PIO_EN);
+
+	ret = prepare_pio(dev, THC_PIO_OP_I2C_TIC_WRITE_AND_READ, address, read_size);
+	if (ret < 0)
+		goto end;
+
+	pio_start(dev, write_size, write_buffer);
+
+	ret = pio_wait(dev);
+	if (ret < 0)
+		goto end;
+
+	ret = pio_complete(dev, read_buffer, actual_size);
+
+end:
+	mutex_unlock(&dev->thc_bus_lock);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(thc_tic_pio_write_and_read, INTEL_THC);
+
 MODULE_AUTHOR("Xinpeng Sun <xinpeng.sun@intel.com>");
 MODULE_AUTHOR("Even Xu <even.xu@intel.com>");
 
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
index 7060f0a36cbd..88a9f606a6a9 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
@@ -5,21 +5,45 @@
 #define _INTEL_THC_DEV_H_
 
 #include <linux/cdev.h>
+#include <linux/mutex.h>
 
 #define THC_REGMAP_COMMON_OFFSET  0x10
 #define THC_REGMAP_MMIO_OFFSET    0x1000
 
+/*
+ * THC Port type
+ * @THC_PORT_TYPE_SPI: This port is used for HIDSPI
+ * @THC_PORT_TYPE_I2C: This port is used for HIDI2C
+ */
+enum thc_port_type {
+	THC_PORT_TYPE_SPI = 0,
+	THC_PORT_TYPE_I2C = 1,
+};
+
 /**
  * struct thc_device - THC private device struct
  * @thc_regmap: MMIO regmap structure for accessing THC registers
  * @mmio_addr: MMIO registers address
+ * @thc_bus_lock: mutex locker for THC config
+ * @port_type: port type of THC port instance
+ * @pio_int_supported: PIO interrupt supported flag
  */
 struct thc_device {
 	struct device *dev;
 	struct regmap *thc_regmap;
 	void __iomem *mmio_addr;
+	struct mutex thc_bus_lock;
+	enum thc_port_type port_type;
+	bool pio_int_supported;
 };
 
 struct thc_device *thc_dev_init(struct device *device, void __iomem *mem_addr);
+int thc_tic_pio_read(struct thc_device *dev, const u32 address,
+		     const u32 size, u32 *actual_size, u32 *buffer);
+int thc_tic_pio_write(struct thc_device *dev, const u32 address,
+		      const u32 size, const u32 *buffer);
+int thc_tic_pio_write_and_read(struct thc_device *dev, const u32 address,
+			       const u32 write_size, const u32 *write_buffer,
+			       const u32 read_size, u32 *actual_size, u32 *read_buffer);
 
 #endif /* _INTEL_THC_DEV_H_ */
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
index 77b275a400d5..9f5f39dcedcd 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
@@ -633,4 +633,27 @@
 
 #define THC_M_PRT_SW_DMA_PRD_TABLE_LEN_THC_M_PRT_SW_DMA_PRD_TABLE_LEN	GENMASK(23, 0)
 
+#define THC_REGMAP_POLLING_INTERVAL_US		10 /* 10us */
+#define THC_PIO_DONE_TIMEOUT_US			USEC_PER_SEC /* 1s */
+
+/*
+ * THC PIO opcode default value
+ * @THC_PIO_OP_SPI_TIC_READ: THC opcode for SPI PIO read
+ * @THC_PIO_OP_SPI_TIC_WRITE: THC opcode for SPI PIO write
+ * @THC_PIO_OP_I2C_SUBSYSTEM_READ: THC opcode for read I2C subsystem registers
+ * @THC_PIO_OP_I2C_SUBSYSTEM_WRITE: THC opcode for write I2C subsystem registers
+ * @THC_PIO_OP_I2C_TIC_READ: THC opcode for read I2C device
+ * @THC_PIO_OP_I2C_TIC_WRITE: THC opcode for write I2C device
+ * @THC_PIO_OP_I2C_TIC_WRITE_AND_READ: THC opcode for write followed by read I2C device
+ */
+enum thc_pio_opcode {
+	THC_PIO_OP_SPI_TIC_READ = 0x4,
+	THC_PIO_OP_SPI_TIC_WRITE = 0x6,
+	THC_PIO_OP_I2C_SUBSYSTEM_READ = 0x12,
+	THC_PIO_OP_I2C_SUBSYSTEM_WRITE = 0x13,
+	THC_PIO_OP_I2C_TIC_READ = 0x14,
+	THC_PIO_OP_I2C_TIC_WRITE = 0x18,
+	THC_PIO_OP_I2C_TIC_WRITE_AND_READ = 0x1C,
+};
+
 #endif /* _INTEL_THC_HW_H_  */
-- 
2.40.1


