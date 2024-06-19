Return-Path: <linux-kernel+bounces-221102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E95C090EDBB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73299287079
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABF414A4E2;
	Wed, 19 Jun 2024 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eJxoeBpu"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B255B14D705
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803283; cv=none; b=RLjZe9ePN8Ern/I3Ql9w0isFO1T6osNqXZkhHMIacw1UyYJxbddCZ7Uau5FXdNudJKIsAkmy7Y4HQshWs6T8v5JZZD2n/LzR1PLuI5RjlcSm47BD42DAGGbmHDZbAxXWQjHSskk+r93UE7YCylClhIg1LxW6DPRY/K9xiR2sYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803283; c=relaxed/simple;
	bh=2+nO4TeztEual3RVUxelmvqwlyjbOX+V59+LOpNievY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnBKu39aYhfxQ43H9c9WS9bEweTs1D3QwEqdGIM9rSSVebuODN3Tz9Z9jgiIziwJWMRBatTNVovx9si4c4E3yHDe5kjfztIXeN9ftK+StyPSK6kuvFLOGgto9bf0OM1Wc5hX46NUFeSm2UoOVosDm7JGMoEkqWCHkCGJlzzQG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eJxoeBpu; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9l89Q011739;
	Wed, 19 Jun 2024 06:21:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
	3bJ1zQ9O3EXWK4Y351ZA8wb4OM4l25ofRcRxhnG3hg=; b=eJxoeBpuVVsPvA793
	J4QRjswLMh3ZGCxgaQVbu6Y+liV2+b23J2BlYIMGvBKO5fP5R9s2NnZKnjav7pwR
	ZlwYjvQdgza3REsRfciXvRwhkMGl40YjMQxFI0MJDFtkH7SDigyVtAeRiB6Hl18C
	lBH8nRYj3DDT8Xaqdoi0VHoUpltwf5M/UEQlEyUsslftujC/+of3ut7VOGDxL3ok
	BtDMICHV2eSy2a7EdWEyD4AzM3Phnsf2wv6TlVOeH86I3SLeQLc78VkIJsKuWOWZ
	pilmsvsFLt6+7tCgWK/IRVCVqvwYEXTPukolaEBw/VzN99jjzaRB26cSaylPipmX
	3cyfA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yuw0jrn81-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 06:21:15 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 06:21:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 06:21:14 -0700
Received: from localhost.localdomain (unknown [10.28.36.156])
	by maili.marvell.com (Postfix) with ESMTP id 7853C3F7044;
	Wed, 19 Jun 2024 06:21:12 -0700 (PDT)
From: Vamsi Attunuru <vattunuru@marvell.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC: <vattunuru@marvell.com>, <jerinj@marvell.com>, <schalla@marvell.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI administrative driver
Date: Wed, 19 Jun 2024 06:21:09 -0700
Message-ID: <20240619132109.3168940-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c43e2c24-cd5b-44c2-a997-5f324f58746c@app.fastmail.com>
References: <c43e2c24-cd5b-44c2-a997-5f324f58746c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cV5LitUhFG6t1EEe-4EzxUPCwHa5a4UB
X-Proofpoint-ORIG-GUID: cV5LitUhFG6t1EEe-4EzxUPCwHa5a4UB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01

Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's physical
function which initializes DPI DMA hardware's global configuration and
enables hardware mailbox channels between physical function (PF) and
it's virtual functions (VF). VF device drivers (User space drivers) use
this hw mailbox to communicate any required device configuration on it's
respective VF device. Accordingly, this DPI PF driver provisions the
VF device resources.

At the hardware level, the DPI physical function (PF) acts as a management
interface to setup the VF device resources, VF devices are only provisioned
to handle or control the actual DMA Engine's data transfer capabilities.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
Reviewed-by: Srujana Challa <schalla@marvell.com>
---
Changes V8 -> V9:
- Addressed minor comments

Changes V7 -> V8:
- Used bit shift operations to access mbox msg fields
- Removed bitfields in mailbox msg structure

Changes V6 -> V7:
- Updated documentation with required references
- Addressed V6 review comments

Changes V5 -> V6:
- Updated documentation
- Fixed data types in uapi file

Changes V4 -> V5:
- Fixed license and data types in uapi file

Changes V3 -> V4:
- Moved ioctl definations to .h file
- Fixed structure alignements which are passed in ioctl

Changes V2 -> V3:
- Added ioctl operation to the fops
- Used managed version of kzalloc & request_irq
- Addressed miscellaneous comments

Changes V1 -> V2:
- Fixed return values and busy-wait loops
- Merged .h file into .c file
- Fixed directory structure
- Removed module params
- Registered the device as misc device

 Documentation/misc-devices/index.rst          |   1 +
 Documentation/misc-devices/mrvl_cn10k_dpi.rst |  52 ++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   5 +
 drivers/misc/Kconfig                          |  14 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/mrvl_cn10k_dpi.c                 | 664 ++++++++++++++++++
 include/uapi/misc/mrvl_cn10k_dpi.h            |  39 +
 8 files changed, 777 insertions(+)

diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 2d0ce9138588..8c5b226d8313 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -21,6 +21,7 @@ fit into other categories.
    isl29003
    lis3lv02d
    max6875
+   mrvl_cn10k_dpi
    oxsemi-tornado
    pci-endpoint-test
    spear-pcie-gadget
diff --git a/Documentation/misc-devices/mrvl_cn10k_dpi.rst b/Documentation/misc-devices/mrvl_cn10k_dpi.rst
new file mode 100644
index 000000000000..a75e372723d8
--- /dev/null
+++ b/Documentation/misc-devices/mrvl_cn10k_dpi.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================================
+Marvell CN10K DMA packet interface (DPI) driver
+===============================================
+
+Overview
+========
+
+DPI is a DMA packet interface hardware block in Marvell's CN10K silicon.
+DPI hardware comprises a physical function (PF), its virtual functions,
+mailbox logic, and a set of DMA engines & DMA command queues.
+
+DPI PF function is an administrative function which services the mailbox
+requests from its VF functions and provisions DMA engine resources to
+it's VF functions.
+
+mrvl_cn10k_dpi.ko misc driver loads on DPI PF device and services the
+mailbox commands submitted by the VF devices and accordingly initializes
+the DMA engines and VF device's DMA command queues. Also, driver creates
+/dev/mrvl-cn10k-dpi node to set DMA engine and PEM (PCIe interface) port
+attributes like fifo length, molr, mps & mrrs.
+
+DPI PF driver is just an administrative driver to setup its VF device's
+queues and provisions the hardware resources, it cannot initiate any
+DMA operations. Only VF devices are provisioned with DMA capabilities.
+
+Driver location
+===============
+
+drivers/misc/mrvl_cn10k_dpi.c
+
+Driver IOCTLs
+=============
+
+:c:macro::`DPI_MPS_MRRS_CFG`
+ioctl that sets max payload size & max read request size parameters of
+a pem port to which DMA engines are wired.
+
+
+:c:macro::`DPI_ENGINE_CFG`
+ioctl that sets DMA engine's fifo sizes & max outstanding load request
+thresholds.
+
+User space code example
+=======================
+
+DPI VF devices are probed and accessed from user space applications using
+vfio-pci driver. Below is a sample dpi dma application to demonstrate on
+how applications use mailbox and ioctl services from DPI PF kernel driver.
+
+https://github.com/MarvellEmbeddedProcessors/dpi-sample-app
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a141e8e65c5d..def539770439 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -362,6 +362,7 @@ Code  Seq#    Include File                                           Comments
 0xB6  all    linux/fpga-dfl.h
 0xB7  all    uapi/linux/remoteproc_cdev.h                            <mailto:linux-remoteproc@vger.kernel.org>
 0xB7  all    uapi/linux/nsfs.h                                       <mailto:Andrei Vagin <avagin@openvz.org>>
+0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h                              Marvell CN10K DPI driver
 0xC0  00-0F  linux/usb/iowarrior.h
 0xCA  00-0F  uapi/misc/cxl.h
 0xCA  10-2F  uapi/misc/ocxl.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 24d372f7653e..4e250f1bd2be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13470,6 +13470,11 @@ S:	Supported
 F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
 F:	drivers/mmc/host/sdhci-xenon*
 
+MARVELL OCTEON CN10K DPI DRIVER
+M:	Vamsi Attunuru <vattunuru@marvell.com>
+S:	Supported
+F:	drivers/misc/mrvl_cn10k_dpi.c
+
 MATROX FRAMEBUFFER DRIVER
 L:	linux-fbdev@vger.kernel.org
 S:	Orphan
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index faf983680040..965641017a62 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -585,6 +585,20 @@ config NSM
 	  To compile this driver as a module, choose M here.
 	  The module will be called nsm.
 
+config MARVELL_CN10K_DPI
+	tristate "Octeon CN10K DPI driver"
+	depends on ARM64 && PCI
+	help
+	  Enables Octeon CN10K DMA packet interface (DPI) driver which
+	  intializes DPI hardware's physical function (PF) device's
+	  global configuration and its virtual function (VFs) resource
+	  configuration to enable DMA transfers. DPI PF device does not
+	  have any data movement functionality, it only serves VF's
+	  resource configuration requests.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mrvl_cn10k_dpi.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 153a3f4837e8..852a7e3a5472 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -69,3 +69,4 @@ obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
 obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
 obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
 obj-$(CONFIG_NSM)		+= nsm.o
+obj-$(CONFIG_MARVELL_CN10K_DPI)	+= mrvl_cn10k_dpi.o
diff --git a/drivers/misc/mrvl_cn10k_dpi.c b/drivers/misc/mrvl_cn10k_dpi.c
new file mode 100644
index 000000000000..058a86901e7c
--- /dev/null
+++ b/drivers/misc/mrvl_cn10k_dpi.c
@@ -0,0 +1,664 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell Octeon CN10K DPI driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/compat.h>
+#include <linux/delay.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+#include <uapi/misc/mrvl_cn10k_dpi.h>
+
+/* PCI device IDs */
+#define PCI_DEVID_MRVL_CN10K_DPI_PF	0xA080
+#define PCI_SUBDEVID_MRVL_CN10K_DPI_PF	0xB900
+
+/* PCI BAR Number */
+#define PCI_DPI_CFG_BAR	0
+
+/* MSI-X interrupts */
+#define DPI_MAX_REQQ_INT	0x20
+#define DPI_MAX_CC_INT		0x40
+
+/* MBOX MSI-X interrupt vector index */
+#define DPI_MBOX_PF_VF_INT_IDX	0x75
+
+#define DPI_MAX_IRQS (DPI_MBOX_PF_VF_INT_IDX + 1)
+
+#define DPI_MAX_VFS	0x20
+
+#define DPI_MAX_ENG_FIFO_SZ	0x20
+#define DPI_MAX_ENG_MOLR	0x400
+
+#define DPI_DMA_IDS_DMA_NPA_PF_FUNC(x)	FIELD_PREP(GENMASK_ULL(31, 16), x)
+#define DPI_DMA_IDS_INST_STRM(x)	FIELD_PREP(GENMASK_ULL(47, 40), x)
+#define DPI_DMA_IDS_DMA_STRM(x)		FIELD_PREP(GENMASK_ULL(39, 32), x)
+#define DPI_DMA_ENG_EN_MOLR(x)		FIELD_PREP(GENMASK_ULL(41, 32), x)
+#define DPI_EBUS_PORTX_CFG_MPS(x)	FIELD_PREP(GENMASK(6, 4), x)
+#define DPI_DMA_IDS_DMA_SSO_PF_FUNC(x)	FIELD_PREP(GENMASK(15, 0), x)
+#define DPI_DMA_IDS2_INST_AURA(x)	FIELD_PREP(GENMASK(19, 0), x)
+#define DPI_DMA_IBUFF_CSIZE_CSIZE(x)	FIELD_PREP(GENMASK(13, 0), x)
+#define DPI_EBUS_PORTX_CFG_MRRS(x)	FIELD_PREP(GENMASK(2, 0), x)
+#define DPI_ENG_BUF_BLKS(x)		FIELD_PREP(GENMASK(5, 0), x)
+#define DPI_DMA_CONTROL_DMA_ENB		GENMASK_ULL(53, 48)
+
+#define DPI_DMA_CONTROL_O_MODE		BIT_ULL(14)
+#define DPI_DMA_CONTROL_LDWB		BIT_ULL(32)
+#define DPI_DMA_CONTROL_WQECSMODE1	BIT_ULL(37)
+#define DPI_DMA_CONTROL_ZBWCSEN		BIT_ULL(39)
+#define DPI_DMA_CONTROL_WQECSOFF(ofst)	(((u64)ofst) << 40)
+#define DPI_DMA_CONTROL_WQECSDIS	BIT_ULL(47)
+#define DPI_DMA_CONTROL_PKT_EN		BIT_ULL(56)
+#define DPI_DMA_IBUFF_CSIZE_NPA_FREE	BIT(16)
+
+#define DPI_CTL_EN			BIT_ULL(0)
+#define DPI_DMA_CC_INT			BIT_ULL(0)
+#define DPI_DMA_QRST			BIT_ULL(0)
+
+#define DPI_REQQ_INT_INSTRFLT		BIT_ULL(0)
+#define DPI_REQQ_INT_RDFLT		BIT_ULL(1)
+#define DPI_REQQ_INT_WRFLT		BIT_ULL(2)
+#define DPI_REQQ_INT_CSFLT		BIT_ULL(3)
+#define DPI_REQQ_INT_INST_DBO		BIT_ULL(4)
+#define DPI_REQQ_INT_INST_ADDR_NULL	BIT_ULL(5)
+#define DPI_REQQ_INT_INST_FILL_INVAL	BIT_ULL(6)
+#define DPI_REQQ_INT_INSTR_PSN		BIT_ULL(7)
+
+#define DPI_REQQ_INT \
+	(DPI_REQQ_INT_INSTRFLT		| \
+	DPI_REQQ_INT_RDFLT		| \
+	DPI_REQQ_INT_WRFLT		| \
+	DPI_REQQ_INT_CSFLT		| \
+	DPI_REQQ_INT_INST_DBO		| \
+	DPI_REQQ_INT_INST_ADDR_NULL	| \
+	DPI_REQQ_INT_INST_FILL_INVAL	| \
+	DPI_REQQ_INT_INSTR_PSN)
+
+#define DPI_PF_RAS_EBI_DAT_PSN	BIT_ULL(0)
+#define DPI_PF_RAS_NCB_DAT_PSN	BIT_ULL(1)
+#define DPI_PF_RAS_NCB_CMD_PSN	BIT_ULL(2)
+
+#define DPI_PF_RAS_INT \
+	(DPI_PF_RAS_EBI_DAT_PSN  | \
+	 DPI_PF_RAS_NCB_DAT_PSN  | \
+	 DPI_PF_RAS_NCB_CMD_PSN)
+
+/* Message fields in word_l of DPI mailbox structure */
+#define DPI_MBOX_VFID(msg)		FIELD_GET(GENMASK_ULL(7, 0), msg)
+#define DPI_MBOX_CMD(msg)		FIELD_GET(GENMASK_ULL(11, 8), msg)
+#define DPI_MBOX_CBUF_SIZE(msg)		FIELD_GET(GENMASK_ULL(27, 12), msg)
+#define DPI_MBOX_CBUF_AURA(msg)		FIELD_GET(GENMASK_ULL(47, 28), msg)
+#define DPI_MBOX_SSO_PFFUNC(msg)	FIELD_GET(GENMASK_ULL(63, 48), msg)
+
+/* Message fields in word_h of DPI mailbox structure */
+#define DPI_MBOX_NPA_PFFUNC(msg)	FIELD_GET(GENMASK_ULL(15, 0), msg)
+#define DPI_MBOX_WQES_COMPL(msg)	FIELD_GET(GENMASK_ULL(16, 16), msg)
+#define DPI_MBOX_WQES_OFFSET(msg)	FIELD_GET(GENMASK_ULL(23, 17), msg)
+
+#define DPI_DMAX_IBUFF_CSIZE(x)	(0x0ULL | ((x) << 11))
+#define DPI_DMAX_IDS(x)		(0x18ULL | ((x) << 11))
+#define DPI_DMAX_IDS2(x)	(0x20ULL | ((x) << 11))
+#define DPI_DMAX_QRST(x)	(0x30ULL | ((x) << 11))
+
+#define DPI_CTL				0x10010ULL
+#define DPI_DMA_CONTROL			0x10018ULL
+#define DPI_PF_RAS			0x10308ULL
+#define DPI_PF_RAS_ENA_W1C		0x10318ULL
+#define DPI_MBOX_VF_PF_INT		0x16300ULL
+#define DPI_MBOX_VF_PF_INT_W1S		0x16308ULL
+#define DPI_MBOX_VF_PF_INT_ENA_W1C	0x16310ULL
+#define DPI_MBOX_VF_PF_INT_ENA_W1S	0x16318ULL
+
+#define DPI_DMA_ENGX_EN(x)		(0x10040ULL | ((x) << 3))
+#define DPI_ENGX_BUF(x)			(0x100C0ULL | ((x) << 3))
+#define DPI_EBUS_PORTX_CFG(x)		(0x10100ULL | ((x) << 3))
+#define DPI_DMA_CCX_INT(x)		(0x11000ULL | ((x) << 3))
+#define DPI_DMA_CCX_INT_ENA_W1C(x)	(0x11800ULL | ((x) << 3))
+#define DPI_REQQX_INT(x)		(0x12C00ULL | ((x) << 5))
+#define DPI_REQQX_INT_ENA_W1C(x)	(0x13800ULL | ((x) << 5))
+#define DPI_MBOX_PF_VF_DATA0(x)		(0x16000ULL | ((x) << 4))
+#define DPI_MBOX_PF_VF_DATA1(x)		(0x16008ULL | ((x) << 4))
+
+#define DPI_WCTL_FIF_THR	0x17008ULL
+
+#define DPI_EBUS_MAX_PORTS	2
+
+#define DPI_EBUS_MRRS_MIN	128
+#define DPI_EBUS_MRRS_MAX	1024
+#define DPI_EBUS_MPS_MIN	128
+#define DPI_EBUS_MPS_MAX	1024
+#define DPI_WCTL_FIFO_THRESHOLD	0x30
+
+#define DPI_QUEUE_OPEN		0x1
+#define DPI_QUEUE_CLOSE		0x2
+#define DPI_REG_DUMP		0x3
+#define DPI_GET_REG_CFG		0x4
+#define DPI_QUEUE_OPEN_V2	0x5
+
+enum dpi_mbox_rsp_type {
+	DPI_MBOX_TYPE_CMD,
+	DPI_MBOX_TYPE_RSP_ACK,
+	DPI_MBOX_TYPE_RSP_NACK,
+};
+
+struct dpivf_config {
+	u32 aura;
+	u16 csize;
+	u16 sso_pf_func;
+	u16 npa_pf_func;
+};
+
+struct dpipf_vf {
+	struct dpivf_config vf_config;
+	bool setup_done;
+	u8 this_vfid;
+};
+
+/* DPI device mailbox */
+struct dpi_mbox {
+	struct work_struct work;
+	/* lock to serialize mbox requests */
+	struct mutex lock;
+	struct dpipf *pf;
+	u8 __iomem *pf_vf_data_reg;
+	u8 __iomem *vf_pf_data_reg;
+};
+
+struct dpipf {
+	struct miscdevice miscdev;
+	void __iomem *reg_base;
+	struct pci_dev *pdev;
+	struct dpipf_vf vf[DPI_MAX_VFS];
+	/* Mailbox to talk to VFs */
+	struct dpi_mbox *mbox[DPI_MAX_VFS];
+};
+
+struct dpi_mbox_message {
+	uint64_t word_l;
+	uint64_t word_h;
+};
+
+static inline void dpi_reg_write(struct dpipf *dpi, u64 offset, u64 val)
+{
+	writeq(val, dpi->reg_base + offset);
+}
+
+static inline u64 dpi_reg_read(struct dpipf *dpi, u64 offset)
+{
+	return readq(dpi->reg_base + offset);
+}
+
+static void dpi_wqe_cs_offset(struct dpipf *dpi, u8 offset)
+{
+	u64 reg;
+
+	reg = dpi_reg_read(dpi, DPI_DMA_CONTROL);
+	reg &= ~DPI_DMA_CONTROL_WQECSDIS;
+	reg |= DPI_DMA_CONTROL_ZBWCSEN | DPI_DMA_CONTROL_WQECSMODE1;
+	reg |= DPI_DMA_CONTROL_WQECSOFF(offset);
+	dpi_reg_write(dpi, DPI_DMA_CONTROL, reg);
+}
+
+static int dpi_queue_init(struct dpipf *dpi, struct dpipf_vf *dpivf, u8 vf)
+{
+	u16 sso_pf_func = dpivf->vf_config.sso_pf_func;
+	u16 npa_pf_func = dpivf->vf_config.npa_pf_func;
+	u16 csize = dpivf->vf_config.csize;
+	u32 aura = dpivf->vf_config.aura;
+	unsigned long timeout;
+	u64 reg;
+
+	dpi_reg_write(dpi, DPI_DMAX_QRST(vf), DPI_DMA_QRST);
+
+	/* Wait for a maximum of 3 sec */
+	timeout = jiffies + msecs_to_jiffies(3000);
+	while (!time_after(jiffies, timeout)) {
+		reg = dpi_reg_read(dpi, DPI_DMAX_QRST(vf));
+		if (!(reg & DPI_DMA_QRST))
+			break;
+
+		/* Reset would take time for the request cache to drain */
+		usleep_range(500, 1000);
+	}
+
+	if (reg & DPI_DMA_QRST) {
+		dev_err(&dpi->pdev->dev, "Queue reset failed\n");
+		return -EBUSY;
+	}
+
+	dpi_reg_write(dpi, DPI_DMAX_IDS2(vf), 0);
+	dpi_reg_write(dpi, DPI_DMAX_IDS(vf), 0);
+
+	reg = DPI_DMA_IBUFF_CSIZE_CSIZE(csize) | DPI_DMA_IBUFF_CSIZE_NPA_FREE;
+	dpi_reg_write(dpi, DPI_DMAX_IBUFF_CSIZE(vf), reg);
+
+	reg = dpi_reg_read(dpi, DPI_DMAX_IDS2(vf));
+	reg |= DPI_DMA_IDS2_INST_AURA(aura);
+	dpi_reg_write(dpi, DPI_DMAX_IDS2(vf), reg);
+
+	reg = dpi_reg_read(dpi, DPI_DMAX_IDS(vf));
+	reg |= DPI_DMA_IDS_DMA_NPA_PF_FUNC(npa_pf_func);
+	reg |= DPI_DMA_IDS_DMA_SSO_PF_FUNC(sso_pf_func);
+	reg |= DPI_DMA_IDS_DMA_STRM(vf + 1);
+	reg |= DPI_DMA_IDS_INST_STRM(vf + 1);
+	dpi_reg_write(dpi, DPI_DMAX_IDS(vf), reg);
+
+	return 0;
+}
+
+static void dpi_queue_fini(struct dpipf *dpi, u8 vf)
+{
+	dpi_reg_write(dpi, DPI_DMAX_QRST(vf), DPI_DMA_QRST);
+
+	/* Reset IDS and IDS2 registers */
+	dpi_reg_write(dpi, DPI_DMAX_IDS2(vf), 0);
+	dpi_reg_write(dpi, DPI_DMAX_IDS(vf), 0);
+}
+
+static irqreturn_t dpi_mbox_intr_handler(int irq, void *data)
+{
+	struct dpipf *dpi = data;
+	u64 reg;
+	u32 vf;
+
+	reg = dpi_reg_read(dpi, DPI_MBOX_VF_PF_INT);
+	if (reg) {
+		for (vf = 0; vf < pci_num_vf(dpi->pdev); vf++) {
+			if (reg & BIT_ULL(vf))
+				schedule_work(&dpi->mbox[vf]->work);
+		}
+		dpi_reg_write(dpi, DPI_MBOX_VF_PF_INT, reg);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int queue_config(struct dpipf *dpi, struct dpipf_vf *dpivf, struct dpi_mbox_message *msg)
+{
+	int ret = 0;
+
+	switch (DPI_MBOX_CMD(msg->word_l)) {
+	case DPI_QUEUE_OPEN:
+	case DPI_QUEUE_OPEN_V2:
+		dpivf->vf_config.aura = DPI_MBOX_CBUF_AURA(msg->word_l);
+		dpivf->vf_config.csize = DPI_MBOX_CMD(msg->word_l) == DPI_QUEUE_OPEN ?
+					 DPI_MBOX_CBUF_SIZE(msg->word_l) >> 3 :
+					 DPI_MBOX_CBUF_SIZE(msg->word_l);
+		dpivf->vf_config.sso_pf_func = DPI_MBOX_SSO_PFFUNC(msg->word_l);
+		dpivf->vf_config.npa_pf_func = DPI_MBOX_NPA_PFFUNC(msg->word_h);
+		ret = dpi_queue_init(dpi, dpivf, DPI_MBOX_VFID(msg->word_l));
+		if (!ret) {
+			if (DPI_MBOX_WQES_COMPL(msg->word_h))
+				dpi_wqe_cs_offset(dpi, DPI_MBOX_WQES_OFFSET(msg->word_h));
+			dpivf->setup_done = true;
+		}
+		break;
+	case DPI_QUEUE_CLOSE:
+		memset(&dpivf->vf_config, 0, sizeof(struct dpivf_config));
+		dpi_queue_fini(dpi, DPI_MBOX_VFID(msg->word_l));
+		dpivf->setup_done = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static void dpi_pfvf_mbox_work(struct work_struct *work)
+{
+	struct dpi_mbox *mbox = container_of(work, struct dpi_mbox, work);
+	struct dpi_mbox_message msg;
+	struct dpipf_vf *dpivf;
+	struct dpipf *dpi;
+	int vfid, ret;
+
+	dpi = mbox->pf;
+	memset(&msg, 0, sizeof(msg));
+
+	mutex_lock(&mbox->lock);
+	msg.word_l = readq(mbox->vf_pf_data_reg);
+	if (msg.word_l == (u64)-1)
+		goto exit;
+
+	vfid = DPI_MBOX_VFID(msg.word_l);
+	if (vfid >= pci_num_vf(dpi->pdev))
+		goto exit;
+
+	dpivf = &dpi->vf[vfid];
+	msg.word_h = readq(mbox->pf_vf_data_reg);
+
+	ret = queue_config(dpi, dpivf, &msg);
+	if (ret < 0)
+		writeq(DPI_MBOX_TYPE_RSP_NACK, mbox->pf_vf_data_reg);
+	else
+		writeq(DPI_MBOX_TYPE_RSP_ACK, mbox->pf_vf_data_reg);
+exit:
+	mutex_unlock(&mbox->lock);
+}
+
+/* Setup registers for a PF mailbox */
+static void dpi_setup_mbox_regs(struct dpipf *dpi, int vf)
+{
+	struct dpi_mbox *mbox = dpi->mbox[vf];
+
+	mbox->pf_vf_data_reg = dpi->reg_base + DPI_MBOX_PF_VF_DATA0(vf);
+	mbox->vf_pf_data_reg = dpi->reg_base + DPI_MBOX_PF_VF_DATA1(vf);
+}
+
+static int dpi_pfvf_mbox_setup(struct dpipf *dpi)
+{
+	int vf;
+
+	for (vf = 0; vf < DPI_MAX_VFS; vf++) {
+		dpi->mbox[vf] = devm_kzalloc(&dpi->pdev->dev, sizeof(*dpi->mbox[vf]), GFP_KERNEL);
+
+		if (!dpi->mbox[vf])
+			return -ENOMEM;
+
+		mutex_init(&dpi->mbox[vf]->lock);
+		INIT_WORK(&dpi->mbox[vf]->work, dpi_pfvf_mbox_work);
+		dpi->mbox[vf]->pf = dpi;
+		dpi_setup_mbox_regs(dpi, vf);
+	}
+
+	return 0;
+}
+
+static void dpi_pfvf_mbox_destroy(struct dpipf *dpi)
+{
+	unsigned int vf;
+
+	for (vf = 0; vf < DPI_MAX_VFS; vf++) {
+		if (work_pending(&dpi->mbox[vf]->work))
+			cancel_work_sync(&dpi->mbox[vf]->work);
+
+		dpi->mbox[vf] = NULL;
+	}
+}
+
+static void dpi_init(struct dpipf *dpi)
+{
+	unsigned int engine, port;
+	u8 mrrs_val, mps_val;
+	u64 reg;
+
+	for (engine = 0; engine < DPI_MAX_ENGINES; engine++) {
+		if (engine == 4 || engine == 5)
+			reg = DPI_ENG_BUF_BLKS(16);
+		else
+			reg = DPI_ENG_BUF_BLKS(8);
+
+		dpi_reg_write(dpi, DPI_ENGX_BUF(engine), reg);
+	}
+
+	reg = DPI_DMA_CONTROL_ZBWCSEN | DPI_DMA_CONTROL_PKT_EN | DPI_DMA_CONTROL_LDWB |
+	      DPI_DMA_CONTROL_O_MODE | DPI_DMA_CONTROL_DMA_ENB;
+
+	dpi_reg_write(dpi, DPI_DMA_CONTROL, reg);
+	dpi_reg_write(dpi, DPI_CTL, DPI_CTL_EN);
+
+	mrrs_val = 2; /* 512B */
+	mps_val = 1; /* 256B */
+
+	for (port = 0; port < DPI_EBUS_MAX_PORTS; port++) {
+		reg = dpi_reg_read(dpi, DPI_EBUS_PORTX_CFG(port));
+		reg &= ~(DPI_EBUS_PORTX_CFG_MRRS(7) | DPI_EBUS_PORTX_CFG_MPS(7));
+		reg |= DPI_EBUS_PORTX_CFG_MPS(mps_val) | DPI_EBUS_PORTX_CFG_MRRS(mrrs_val);
+		dpi_reg_write(dpi, DPI_EBUS_PORTX_CFG(port), reg);
+	}
+
+	dpi_reg_write(dpi, DPI_WCTL_FIF_THR, DPI_WCTL_FIFO_THRESHOLD);
+}
+
+static void dpi_fini(struct dpipf *dpi)
+{
+	unsigned int engine;
+
+	for (engine = 0; engine < DPI_MAX_ENGINES; engine++)
+		dpi_reg_write(dpi, DPI_ENGX_BUF(engine), 0);
+
+	dpi_reg_write(dpi, DPI_DMA_CONTROL, 0);
+	dpi_reg_write(dpi, DPI_CTL, 0);
+}
+
+static void dpi_free_irq_vectors(void *pdev)
+{
+	pci_free_irq_vectors((struct pci_dev *)pdev);
+}
+
+static int dpi_irq_init(struct dpipf *dpi)
+{
+	struct pci_dev *pdev = dpi->pdev;
+	struct device *dev = &pdev->dev;
+	int i, ret;
+
+	/* Clear all RAS interrupts */
+	dpi_reg_write(dpi, DPI_PF_RAS, DPI_PF_RAS_INT);
+
+	/* Clear all RAS interrupt enable bits */
+	dpi_reg_write(dpi, DPI_PF_RAS_ENA_W1C, DPI_PF_RAS_INT);
+
+	for (i = 0; i < DPI_MAX_REQQ_INT; i++) {
+		dpi_reg_write(dpi, DPI_REQQX_INT(i), DPI_REQQ_INT);
+		dpi_reg_write(dpi, DPI_REQQX_INT_ENA_W1C(i), DPI_REQQ_INT);
+	}
+
+	for (i = 0; i < DPI_MAX_CC_INT; i++) {
+		dpi_reg_write(dpi, DPI_DMA_CCX_INT(i), DPI_DMA_CC_INT);
+		dpi_reg_write(dpi, DPI_DMA_CCX_INT_ENA_W1C(i), DPI_DMA_CC_INT);
+	}
+
+	ret = pci_alloc_irq_vectors(pdev, DPI_MAX_IRQS, DPI_MAX_IRQS, PCI_IRQ_MSIX);
+	if (ret != DPI_MAX_IRQS) {
+		dev_err(dev, "DPI: Failed to alloc %d msix irqs\n", DPI_MAX_IRQS);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, dpi_free_irq_vectors, pdev);
+	if (ret) {
+		dev_err(dev, "DPI: Failed to add irq free action\n");
+		return ret;
+	}
+
+	ret = devm_request_irq(dev, pci_irq_vector(pdev, DPI_MBOX_PF_VF_INT_IDX),
+			       dpi_mbox_intr_handler, 0, "dpi-mbox", dpi);
+	if (ret) {
+		dev_err(dev, "DPI: request_irq failed for mbox; err=%d\n", ret);
+		return ret;
+	}
+
+	dpi_reg_write(dpi, DPI_MBOX_VF_PF_INT_ENA_W1S, GENMASK_ULL(31, 0));
+
+	return 0;
+}
+
+static int dpi_mps_mrrs_config(struct dpipf *dpi, void __user *arg)
+{
+	struct dpi_mps_mrrs_cfg cfg;
+	u8 mrrs_val, mps_val;
+	u64 reg;
+
+	if (copy_from_user(&cfg, arg, sizeof(struct dpi_mps_mrrs_cfg)))
+		return -EFAULT;
+
+	if (cfg.max_read_req_sz < DPI_EBUS_MRRS_MIN || cfg.max_read_req_sz > DPI_EBUS_MRRS_MAX ||
+	    !is_power_of_2(cfg.max_read_req_sz))
+		return -EINVAL;
+
+	if (cfg.max_payload_sz < DPI_EBUS_MPS_MIN || cfg.max_payload_sz > DPI_EBUS_MPS_MAX ||
+	    !is_power_of_2(cfg.max_payload_sz))
+		return -EINVAL;
+
+	if (cfg.port >= DPI_EBUS_MAX_PORTS)
+		return -EINVAL;
+
+	mrrs_val = fls(cfg.max_read_req_sz >> 8);
+	mps_val = fls(cfg.max_payload_sz >> 8);
+
+	reg = dpi_reg_read(dpi, DPI_EBUS_PORTX_CFG(cfg.port));
+	reg &= ~(DPI_EBUS_PORTX_CFG_MRRS(0x7) | DPI_EBUS_PORTX_CFG_MPS(0x7));
+	reg |= DPI_EBUS_PORTX_CFG_MPS(mps_val) | DPI_EBUS_PORTX_CFG_MRRS(mrrs_val);
+	dpi_reg_write(dpi, DPI_EBUS_PORTX_CFG(cfg.port), reg);
+
+	return 0;
+}
+
+static int dpi_engine_config(struct dpipf *dpi, void __user *arg)
+{
+	struct dpi_engine_cfg cfg;
+	unsigned int engine;
+	u8 *eng_buf;
+	u64 reg;
+
+	if (copy_from_user(&cfg, arg, sizeof(struct dpi_engine_cfg)))
+		return -EFAULT;
+
+	eng_buf = (u8 *)&cfg.fifo_mask;
+
+	for (engine = 0; engine < DPI_MAX_ENGINES; engine++) {
+		if (eng_buf[engine] > DPI_MAX_ENG_FIFO_SZ)
+			return -EINVAL;
+		dpi_reg_write(dpi, DPI_ENGX_BUF(engine), eng_buf[engine]);
+
+		if (cfg.update_molr) {
+			if (cfg.molr[engine] > DPI_MAX_ENG_MOLR)
+				return -EINVAL;
+			reg = DPI_DMA_ENG_EN_MOLR(cfg.molr[engine]);
+			dpi_reg_write(dpi, DPI_DMA_ENGX_EN(engine), reg);
+		}
+	}
+
+	return 0;
+}
+
+static long dpi_dev_ioctl(struct file *fptr, unsigned int cmd, unsigned long data)
+{
+	void __user *arg = (void __user *)data;
+	struct dpipf *dpi;
+	int ret;
+
+	dpi = container_of(fptr->private_data, struct dpipf, miscdev);
+
+	switch (cmd) {
+	case DPI_MPS_MRRS_CFG:
+		ret = dpi_mps_mrrs_config(dpi, arg);
+		break;
+	case DPI_ENGINE_CFG:
+		ret = dpi_engine_config(dpi, arg);
+		break;
+	default:
+		ret = -ENOTTY;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations dpi_device_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = dpi_dev_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+};
+
+static int dpi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct dpipf *dpi;
+	int ret;
+
+	dpi = devm_kzalloc(dev, sizeof(*dpi), GFP_KERNEL);
+	if (!dpi)
+		return -ENOMEM;
+
+	dpi->pdev = pdev;
+
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		dev_err(dev, "DPI: Failed to enable PCI device\n");
+		return ret;
+	}
+
+	ret = pcim_iomap_regions(pdev, BIT(0) | BIT(4), KBUILD_MODNAME);
+	if (ret) {
+		dev_err(dev, "DPI: Failed to request MMIO region\n");
+		return ret;
+	}
+
+	dpi->reg_base = pcim_iomap_table(pdev)[PCI_DPI_CFG_BAR];
+
+	/* Initialize global PF registers */
+	dpi_init(dpi);
+
+	/* Setup PF-VF mailbox */
+	ret = dpi_pfvf_mbox_setup(dpi);
+	if (ret) {
+		dev_err(dev, "DPI: Failed to setup pf-vf mbox\n");
+		goto err_dpi_fini;
+	}
+
+	/* Register interrupts */
+	ret = dpi_irq_init(dpi);
+	if (ret) {
+		dev_err(dev, "DPI: Failed to initialize irq vectors\n");
+		goto err_dpi_mbox_free;
+	}
+
+	pci_set_drvdata(pdev, dpi);
+	dpi->miscdev.minor = MISC_DYNAMIC_MINOR;
+	dpi->miscdev.name = KBUILD_MODNAME;
+	dpi->miscdev.fops = &dpi_device_fops;
+	dpi->miscdev.parent = dev;
+
+	ret = misc_register(&dpi->miscdev);
+	if (ret) {
+		dev_err(dev, "DPI: Failed to register misc device\n");
+		goto err_dpi_mbox_free;
+	}
+
+	return 0;
+
+err_dpi_mbox_free:
+	dpi_pfvf_mbox_destroy(dpi);
+err_dpi_fini:
+	dpi_fini(dpi);
+	return ret;
+}
+
+static void dpi_remove(struct pci_dev *pdev)
+{
+	struct dpipf *dpi = pci_get_drvdata(pdev);
+
+	misc_deregister(&dpi->miscdev);
+	pci_sriov_configure_simple(pdev, 0);
+	dpi_pfvf_mbox_destroy(dpi);
+	dpi_fini(dpi);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static const struct pci_device_id dpi_id_table[] = {
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_MRVL_CN10K_DPI_PF,
+			 PCI_VENDOR_ID_CAVIUM, PCI_SUBDEVID_MRVL_CN10K_DPI_PF) },
+	{ 0, }  /* end of table */
+};
+
+static struct pci_driver dpi_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = dpi_id_table,
+	.probe = dpi_probe,
+	.remove = dpi_remove,
+	.sriov_configure = pci_sriov_configure_simple,
+};
+
+module_pci_driver(dpi_driver);
+MODULE_DEVICE_TABLE(pci, dpi_id_table);
+MODULE_AUTHOR("Marvell.");
+MODULE_DESCRIPTION("Marvell Octeon CN10K DPI Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/misc/mrvl_cn10k_dpi.h b/include/uapi/misc/mrvl_cn10k_dpi.h
new file mode 100644
index 000000000000..8a352361df94
--- /dev/null
+++ b/include/uapi/misc/mrvl_cn10k_dpi.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Marvell Octeon CN10K DPI driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#ifndef __MRVL_CN10K_DPI_H__
+#define __MRVL_CN10K_DPI_H__
+
+#include <linux/types.h>
+
+#define DPI_MAX_ENGINES 6
+
+struct dpi_mps_mrrs_cfg {
+	__u16 max_read_req_sz; /* Max read request size */
+	__u16 max_payload_sz;  /* Max payload size */
+	__u16 port; /* Ebus port */
+	__u16 rsvd; /* Reserved */
+};
+
+struct dpi_engine_cfg {
+	__u64 fifo_mask; /* FIFO size mask in KBytes */
+	__u16 molr[DPI_MAX_ENGINES]; /* Max outstanding load requests */
+	__u16 update_molr; /* '1' to update engine MOLR */
+	__u16 rsvd; /* Reserved */
+};
+
+/* DPI ioctl numbers */
+#define DPI_MAGIC_NUM	0xB8
+
+/* Set MPS & MRRS parameters */
+#define DPI_MPS_MRRS_CFG _IOW(DPI_MAGIC_NUM, 1, struct dpi_mps_mrrs_cfg)
+
+/* Set Engine FIFO configuration */
+#define DPI_ENGINE_CFG   _IOW(DPI_MAGIC_NUM, 2, struct dpi_engine_cfg)
+
+#endif /* __MRVL_CN10K_DPI_H__ */
-- 
2.25.1


