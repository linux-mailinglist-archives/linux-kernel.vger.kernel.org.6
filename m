Return-Path: <linux-kernel+bounces-364036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD60D99CA48
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EF1287325
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992F81A76AC;
	Mon, 14 Oct 2024 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iG386QMg"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77311A4F3A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909255; cv=none; b=GA7jHgKqfVb+ROY6KUwihYFUCPiq8xPZ9TkmxVbOOp+eK5AEN7Id/JQWNlVrzqNfSw94oTQxQZCllZlGpLdGd+kLHlWWRoJ4VGIX5COcJa9GfuRVym2n/pdqctYbgXyCZe4LiLKRbgdyw91lArjIWjBryQ7HcD4rM/e1dppJlAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909255; c=relaxed/simple;
	bh=Mxk0VnaDmtvZNroDrj1v8yTaKzwMV4/r/CBpBK36SXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=D+O3v3QyttA02/JzFFL0uSGitJhHRfT8+Ub4/Mw3DlkNZfi3tKKkmtJNelz0Vh0oo1mWAB0HB1D2Deg5deBYHTf+2eQGYnDvcWC6xA4BN2Afzy4BUXNWWPf/LJM6eBwqsk+XCy2ObTCVqNnrN5DrgqKgnp6yphxyrNA4+WvIXIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iG386QMg; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241014123411euoutp02c36d14a82bf55d6c291e75aa8b09d19c~_Uc3S9R1Q1628416284euoutp02n
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:34:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241014123411euoutp02c36d14a82bf55d6c291e75aa8b09d19c~_Uc3S9R1Q1628416284euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728909251;
	bh=+0zbI52pp2pOxdYvil9T/SAnatj8EyaM3AM/pE572dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iG386QMg+ypHmSlgciLqrcC5mf5xjKlBWnDWe1ex9siK0OTu6fhJ7yrXj3cN240hW
	 fZHz9jdQsyQvyg0sN+3cYwTTEm4uno4DPd+7tn5wR9MqIx/f74G/uT9ppbqOdSrpW9
	 IUeVvAl/fgDRkcgoAIxK8U2AqyHlFGbKi9bF196U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241014123411eucas1p2dfa8826b9f8231dbfe6b529eae31c65a~_Uc28MZDB0179101791eucas1p2V;
	Mon, 14 Oct 2024 12:34:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id DD.01.09875.2CF0D076; Mon, 14
	Oct 2024 13:34:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241014123410eucas1p2d4d636b390cd5b426bbf37e493363663~_Uc2a06kh3262332623eucas1p2s;
	Mon, 14 Oct 2024 12:34:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241014123410eusmtrp1bf98363d4ed5f828012551de2a83689e~_Uc2ZcUci1593615936eusmtrp1a;
	Mon, 14 Oct 2024 12:34:10 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-77-670d0fc27b33
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 10.23.19096.2CF0D076; Mon, 14
	Oct 2024 13:34:10 +0100 (BST)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241014123409eusmtip1f3deb20abe7e0320c578b4b7230d96ef~_Uc1pNa9A0627406274eusmtip1k;
	Mon, 14 Oct 2024 12:34:09 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v4 1/3] mailbox: Introduce support for T-head TH1520 Mailbox
 driver
Date: Mon, 14 Oct 2024 14:33:12 +0200
Message-Id: <20241014123314.1231517-2-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014123314.1231517-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djPc7qH+HnTDabfMLPY+nsWu8WaveeY
	LOYfOcdqce/SFiaLF3sbWSyurZjLbvFy1j02i8u75rBZbPvcwmax9shddov1X+czWby83MNs
	0TaL3+L/nh3sFi37p7A48Hu8efmSxeNwxxd2j52z7rJ7bFrVyeaxeUm9R8vaY0we7/ddZfPo
	27KK0eNS83V2j8+b5AK4orhsUlJzMstSi/TtErgyul/sZS1YNYux4sWTGywNjPfruxg5OSQE
	TCSePN/F3MXIxSEksIJRYuWsJSwQzhdGif1XbzJCOJ8ZJR5tPQtUxgHW0nqaByK+nFFi4bct
	UEVvGCXeLd/OCjKXTcBI4sHy+awgCRGBd4wSk67dZgJxmAV6GSWm7p3JBFIlLBAq8f3jZGYQ
	m0VAVeLlhZNsICt4BewlpswSgThQXmL/wbNgJZwCDhJLDuxhAbF5BQQlTs58AmYzA9U0b53N
	DFG/mFPi1c8iiEtdJA798IQIC0u8Or6FHcKWkTg9uYcFws6XeLD1E1RrjcTOnuNQtrXEnXO/
	wK5hFtCUWL9LHyLsKNF8ZRkTxHQ+iRtvBSEO4JOYtG06NHh4JTrahCCq1SSm9vTCLT23YhsT
	hO0hsfvicfYJjIqzkLwyC8krsxD2LmBkXsUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGY
	5k7/O/5lB+PyVx/1DjEycTAeYpTgYFYS4X0/lTNdiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9q
	inyqkEB6YklqdmpqQWoRTJaJg1OqganIu3rxh5Xf15SnPZ3waa2HxOOjD1J7pAW27/juEhk4
	2eHgu52ZYb8verGLpfybtPuh+KujJ9tm2K/Zf2/2sZW2nMxRx/QFJ8g7Cs402f13y3ZOJn4h
	tbTkD9pcxY+DHAoElfcxrjF8Ma38SkfOmuWJ6V+dHjcUbn+9fV6SFTszj3WCsbPdv4cFERtk
	6ydzBM98JTXv97P8eSUfPC/M4f2WfPOUxkHVJVw746cldu59Wujc/fdbe94Hz/nmH5epvOdp
	XxT6WGZX54uECaEv9SdbTudozT7o32XWfjXQxW//07WSDWe6xW/eeTjlJ59Rw+GZD2y/fLmW
	3+bbU3L46I+AY4que4KvKSxkinM/vXuPEktxRqKhFnNRcSIAVzks6+IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xu7qH+HnTDWZsFLXY+nsWu8WaveeY
	LOYfOcdqce/SFiaLF3sbWSyurZjLbvFy1j02i8u75rBZbPvcwmax9shddov1X+czWby83MNs
	0TaL3+L/nh3sFi37p7A48Hu8efmSxeNwxxd2j52z7rJ7bFrVyeaxeUm9R8vaY0we7/ddZfPo
	27KK0eNS83V2j8+b5AK4ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1s
	UlJzMstSi/TtEvQyul/sZS1YNYux4sWTGywNjPfruxg5OCQETCRaT/N0MXJxCAksZZS4tKiR
	rYuREyguI3Gt+yULhC0s8edaFxtE0StGiZUzj7KCJNgEjCQeLJ/PCpIQEfjDKHH92RtGEIdZ
	YCKjxM259xlBqoQFgiWuzD3MDGKzCKhKvLxwkg1kNa+AvcSUWSIQG+Ql9h88C1bCKeAgseTA
	HrDNQkAlnWvegl3EKyAocXLmE7A4M1B989bZzBMYBWYhSc1CklrAyLSKUSS1tDg3PbfYSK84
	Mbe4NC9dLzk/dxMjMCq3Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuF9P5UzXYg3JbGyKrUoP76o
	NCe1+BCjKdDZE5mlRJPzgWkhryTe0MzA1NDEzNLA1NLMWEmcl+3K+TQhgfTEktTs1NSC1CKY
	PiYOTqkGpjynXq5ZDxTe5LH/8Qu4c/3zhP1B7K83vN+w+//NH9VGL1m+2bYu/9/j+23iCZlV
	Tz/MiEisuLdEvkE9Riit73FkiMfpuiqGKWeyGsK79jw+XfV8ntlx9sAN74NjF27YMmGlztyw
	nqMLbhVeqrjSXsCrEbVRtOPW/+sST+PmTRDYf7SFK4L/buqRtHS5bu2c4/N/X73V+GTdgxO7
	XL7sTulpnnzzeCxrf9Wmp8sP7n+of/hp61KegC2V5nysa7nbNneKpjMba+dkvmdd+tFS919k
	S1h2qsCebo81HiJ1is4LU++ZrT71dnvy7NKPUdbzZs4+EnTDLutsSvZsB/47nxYH+L98vubB
	G4fmQt+Hx94qsRRnJBpqMRcVJwIAWNOSD1MDAAA=
X-CMS-MailID: 20241014123410eucas1p2d4d636b390cd5b426bbf37e493363663
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241014123410eucas1p2d4d636b390cd5b426bbf37e493363663
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241014123410eucas1p2d4d636b390cd5b426bbf37e493363663
References: <20241014123314.1231517-1-m.wilczynski@samsung.com>
	<CGME20241014123410eucas1p2d4d636b390cd5b426bbf37e493363663@eucas1p2.samsung.com>

This driver was tested using the drm/imagination GPU driver. It was able
to successfully power on the GPU, by passing a command through mailbox
from E910 core to E902 that's responsible for powering up the GPU. The
GPU driver was able to read the BVC version from control registers,
which confirms it was successfully powered on.

[   33.957467] powervr ffef400000.gpu: [drm] loaded firmware
powervr/rogue_36.52.104.182_v1.fw
[   33.966008] powervr ffef400000.gpu: [drm] FW version v1.0 (build
6621747 OS)
[   38.978542] powervr ffef400000.gpu: [drm] *ERROR* Firmware failed to
boot

Though the driver still fails to boot the firmware, the mailbox driver
works when used with the not-yet-upstreamed firmware AON driver. There
is ongoing work to get the BXM-4-64 supported with the drm/imagination
driver [1], though it's not completed yet.

This work is based on the driver from the vendor kernel [2].

Link: https://gitlab.freedesktop.org/imagination/linux-firmware/-/issues/2 [1]
Link: https://github.com/revyos/thead-kernel.git [2]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS                      |   1 +
 drivers/mailbox/Kconfig          |  10 +
 drivers/mailbox/Makefile         |   2 +
 drivers/mailbox/mailbox-th1520.c | 572 +++++++++++++++++++++++++++++++
 4 files changed, 585 insertions(+)
 create mode 100644 drivers/mailbox/mailbox-th1520.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ad507f49324..0655c6ba5435 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19953,6 +19953,7 @@ T:	git https://github.com/pdp7/linux.git
 F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c
+F:	drivers/mailbox/mailbox-th1520.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 
 RNBD BLOCK DRIVERS
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 6fb995778636..52f8162896f5 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -295,4 +295,14 @@ config QCOM_IPCC
 	  acts as an interrupt controller for receiving interrupts from clients.
 	  Say Y here if you want to build this driver.
 
+config THEAD_TH1520_MBOX
+	tristate "T-head TH1520 Mailbox"
+	depends on ARCH_THEAD || COMPILE_TEST
+	help
+	  Mailbox driver implementation for the Thead TH-1520 platform. Enables
+	  two cores within the SoC to communicate and coordinate by passing
+	  messages. Could be used to communicate between E910 core, on which the
+	  kernel is running, and E902 core used for power management among other
+	  things.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 3c3c27d54c13..5f4f5b0ce2cc 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -64,3 +64,5 @@ obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
 obj-$(CONFIG_QCOM_CPUCP_MBOX)	+= qcom-cpucp-mbox.o
 
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
+
+obj-$(CONFIG_THEAD_TH1520_MBOX)	+= mailbox-th1520.o
diff --git a/drivers/mailbox/mailbox-th1520.c b/drivers/mailbox/mailbox-th1520.c
new file mode 100644
index 000000000000..bf537c4e01a2
--- /dev/null
+++ b/drivers/mailbox/mailbox-th1520.c
@@ -0,0 +1,572 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Alibaba Group Holding Limited.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/* Status Register */
+#define TH_1520_MBOX_STA 0x0
+#define TH_1520_MBOX_CLR 0x4
+#define TH_1520_MBOX_MASK 0xc
+
+/* Transmit/receive data register:
+ * INFO0 ~ INFO6
+ */
+#define TH_1520_MBOX_INFO_NUM 8
+#define TH_1520_MBOX_DATA_INFO_NUM 7
+#define TH_1520_MBOX_INFO0 0x14
+/* Transmit ack register: INFO7 */
+#define TH_1520_MBOX_INFO7 0x30
+
+/* Generate remote icu IRQ Register */
+#define TH_1520_MBOX_GEN 0x10
+#define TH_1520_MBOX_GEN_RX_DATA BIT(6)
+#define TH_1520_MBOX_GEN_TX_ACK BIT(7)
+
+#define TH_1520_MBOX_CHAN_RES_SIZE 0x1000
+#define TH_1520_MBOX_CHANS 4
+#define TH_1520_MBOX_CHAN_NAME_SIZE 20
+
+#define TH_1520_MBOX_ACK_MAGIC 0xdeadbeaf
+
+#ifdef CONFIG_PM_SLEEP
+/* store MBOX context across system-wide suspend/resume transitions */
+struct th1520_mbox_context {
+	u32 intr_mask[TH_1520_MBOX_CHANS - 1];
+};
+#endif
+
+enum th1520_mbox_chan_type {
+	TH_1520_MBOX_TYPE_TXRX, /* Tx & Rx chan */
+	TH_1520_MBOX_TYPE_DB, /* Tx & Rx doorbell */
+};
+
+enum th1520_mbox_icu_cpu_id {
+	TH_1520_MBOX_ICU_KERNEL_CPU0, /* 910T */
+	TH_1520_MBOX_ICU_CPU1, /* 902 */
+	TH_1520_MBOX_ICU_CPU2, /* 906 */
+	TH_1520_MBOX_ICU_CPU3, /* 910R */
+};
+
+struct th1520_mbox_con_priv {
+	enum th1520_mbox_icu_cpu_id idx;
+	enum th1520_mbox_chan_type type;
+	void __iomem *comm_local_base;
+	void __iomem *comm_remote_base;
+	char irq_desc[TH_1520_MBOX_CHAN_NAME_SIZE];
+	struct mbox_chan *chan;
+	struct tasklet_struct txdb_tasklet;
+};
+
+struct th1520_mbox_priv {
+	struct device *dev;
+	void __iomem *local_icu[TH_1520_MBOX_CHANS];
+	void __iomem *remote_icu[TH_1520_MBOX_CHANS - 1];
+	void __iomem *cur_cpu_ch_base;
+	spinlock_t mbox_lock; /* control register lock */
+
+	struct mbox_controller mbox;
+	struct mbox_chan mbox_chans[TH_1520_MBOX_CHANS];
+
+	struct th1520_mbox_con_priv con_priv[TH_1520_MBOX_CHANS];
+	int irq;
+#ifdef CONFIG_PM_SLEEP
+	struct th1520_mbox_context *ctx;
+#endif
+};
+
+static struct th1520_mbox_priv *
+to_th1520_mbox_priv(struct mbox_controller *mbox)
+{
+	return container_of(mbox, struct th1520_mbox_priv, mbox);
+}
+
+static void th1520_mbox_write(struct th1520_mbox_priv *priv, u32 val, u32 offs)
+{
+	iowrite32(val, priv->cur_cpu_ch_base + offs);
+}
+
+static u32 th1520_mbox_read(struct th1520_mbox_priv *priv, u32 offs)
+{
+	return ioread32(priv->cur_cpu_ch_base + offs);
+}
+
+static u32 th1520_mbox_rmw(struct th1520_mbox_priv *priv, u32 off, u32 set,
+			   u32 clr)
+{
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&priv->mbox_lock, flags);
+	val = th1520_mbox_read(priv, off);
+	val &= ~clr;
+	val |= set;
+	th1520_mbox_write(priv, val, off);
+	spin_unlock_irqrestore(&priv->mbox_lock, flags);
+
+	return val;
+}
+
+static void th1520_mbox_chan_write(struct th1520_mbox_con_priv *cp, u32 val,
+				   u32 offs, bool is_remote)
+{
+	if (is_remote)
+		iowrite32(val, cp->comm_remote_base + offs);
+	else
+		iowrite32(val, cp->comm_local_base + offs);
+}
+
+static u32 th1520_mbox_chan_read(struct th1520_mbox_con_priv *cp, u32 offs,
+				 bool is_remote)
+{
+	if (is_remote)
+		return ioread32(cp->comm_remote_base + offs);
+	else
+		return ioread32(cp->comm_local_base + offs);
+}
+
+static void th1520_mbox_chan_rmw(struct th1520_mbox_con_priv *cp, u32 off,
+				 u32 set, u32 clr, bool is_remote)
+{
+	struct th1520_mbox_priv *priv = to_th1520_mbox_priv(cp->chan->mbox);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&priv->mbox_lock, flags);
+	val = th1520_mbox_chan_read(cp, off, is_remote);
+	val &= ~clr;
+	val |= set;
+	th1520_mbox_chan_write(cp, val, off, is_remote);
+	spin_unlock_irqrestore(&priv->mbox_lock, flags);
+}
+
+static void th1520_mbox_chan_rd_data(struct th1520_mbox_con_priv *cp,
+				     void *data, bool is_remote)
+{
+	u32 off = TH_1520_MBOX_INFO0;
+	u32 *arg = data;
+	u32 i;
+
+	/* read info0 ~ info6, totally 28 bytes
+	 * requires data memory size is 28 bytes
+	 */
+	for (i = 0; i < TH_1520_MBOX_DATA_INFO_NUM; i++) {
+		*arg = th1520_mbox_chan_read(cp, off, is_remote);
+		off += 4;
+		arg++;
+	}
+}
+
+static void th1520_mbox_chan_wr_data(struct th1520_mbox_con_priv *cp,
+				     void *data, bool is_remote)
+{
+	u32 off = TH_1520_MBOX_INFO0;
+	u32 *arg = data;
+	u32 i;
+
+	/* write info0 ~ info6, totally 28 bytes
+	 * requires data memory is 28 bytes valid data
+	 */
+	for (i = 0; i < TH_1520_MBOX_DATA_INFO_NUM; i++) {
+		th1520_mbox_chan_write(cp, *arg, off, is_remote);
+		off += 4;
+		arg++;
+	}
+}
+
+static void th1520_mbox_chan_wr_ack(struct th1520_mbox_con_priv *cp, void *data,
+				    bool is_remote)
+{
+	u32 off = TH_1520_MBOX_INFO7;
+	u32 *arg = data;
+
+	th1520_mbox_chan_write(cp, *arg, off, is_remote);
+}
+
+static int th1520_mbox_chan_id_to_mapbit(struct th1520_mbox_con_priv *cp)
+{
+	int mapbit = 0;
+	int i;
+
+	for (i = 0; i < TH_1520_MBOX_CHANS; i++) {
+		if (i == cp->idx)
+			return mapbit;
+
+		if (i != TH_1520_MBOX_ICU_KERNEL_CPU0)
+			mapbit++;
+	}
+
+	if (i == TH_1520_MBOX_CHANS)
+		dev_err(cp->chan->mbox->dev, "convert to mapbit failed\n");
+
+	return 0;
+}
+
+static void th1520_mbox_txdb_tasklet(unsigned long data)
+{
+	struct th1520_mbox_con_priv *cp = (struct th1520_mbox_con_priv *)data;
+
+	mbox_chan_txdone(cp->chan, 0);
+}
+
+static irqreturn_t th1520_mbox_isr(int irq, void *p)
+{
+	struct mbox_chan *chan = p;
+	struct th1520_mbox_priv *priv = to_th1520_mbox_priv(chan->mbox);
+	struct th1520_mbox_con_priv *cp = chan->con_priv;
+	int mapbit = th1520_mbox_chan_id_to_mapbit(cp);
+	u32 sta, dat[TH_1520_MBOX_DATA_INFO_NUM];
+	u32 ack_magic = TH_1520_MBOX_ACK_MAGIC;
+	u32 info0_data, info7_data;
+
+	sta = th1520_mbox_read(priv, TH_1520_MBOX_STA);
+	if (!(sta & BIT(mapbit)))
+		return IRQ_NONE;
+
+	/* clear chan irq bit in STA register */
+	th1520_mbox_rmw(priv, TH_1520_MBOX_CLR, BIT(mapbit), 0);
+
+	/* rx doorbell */
+	if (cp->type == TH_1520_MBOX_TYPE_DB) {
+		mbox_chan_received_data(cp->chan, NULL);
+		return IRQ_HANDLED;
+	}
+
+	/* info0 is the protocol word, should not be zero! */
+	info0_data = th1520_mbox_chan_read(cp, TH_1520_MBOX_INFO0, false);
+	if (info0_data) {
+		/* read info0~info6 data */
+		th1520_mbox_chan_rd_data(cp, dat, false);
+
+		/* clear local info0 */
+		th1520_mbox_chan_write(cp, 0x0, TH_1520_MBOX_INFO0, false);
+
+		/* notify remote cpu */
+		th1520_mbox_chan_wr_ack(cp, &ack_magic, true);
+		/* CPU1 902/906 use polling mode to monitor info7 */
+		if (cp->idx != TH_1520_MBOX_ICU_CPU1 &&
+		    cp->idx != TH_1520_MBOX_ICU_CPU2)
+			th1520_mbox_chan_rmw(cp, TH_1520_MBOX_GEN,
+					     TH_1520_MBOX_GEN_TX_ACK, 0, true);
+
+		/* transfer the data to client */
+		mbox_chan_received_data(chan, (void *)dat);
+	}
+
+	/* info7 magic value mean the real ack signal, not generate bit7 */
+	info7_data = th1520_mbox_chan_read(cp, TH_1520_MBOX_INFO7, false);
+	if (info7_data == TH_1520_MBOX_ACK_MAGIC) {
+		/* clear local info7 */
+		th1520_mbox_chan_write(cp, 0x0, TH_1520_MBOX_INFO7, false);
+
+		/* notify framework the last TX has completed */
+		mbox_chan_txdone(chan, 0);
+	}
+
+	if (!info0_data && !info7_data)
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static int th1520_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct th1520_mbox_con_priv *cp = chan->con_priv;
+
+	if (cp->type == TH_1520_MBOX_TYPE_DB)
+		tasklet_schedule(&cp->txdb_tasklet);
+	else
+		th1520_mbox_chan_wr_data(cp, data, true);
+
+	th1520_mbox_chan_rmw(cp, TH_1520_MBOX_GEN, TH_1520_MBOX_GEN_RX_DATA, 0,
+			     true);
+	return 0;
+}
+
+static int th1520_mbox_startup(struct mbox_chan *chan)
+{
+	struct th1520_mbox_priv *priv = to_th1520_mbox_priv(chan->mbox);
+	struct th1520_mbox_con_priv *cp = chan->con_priv;
+	u32 data[8] = {};
+	int mask_bit;
+	int ret;
+
+	/* clear local and remote generate and info0~info7 */
+	th1520_mbox_chan_rmw(cp, TH_1520_MBOX_GEN, 0x0, 0xff, true);
+	th1520_mbox_chan_rmw(cp, TH_1520_MBOX_GEN, 0x0, 0xff, false);
+	th1520_mbox_chan_wr_ack(cp, &data[7], true);
+	th1520_mbox_chan_wr_ack(cp, &data[7], false);
+	th1520_mbox_chan_wr_data(cp, &data[0], true);
+	th1520_mbox_chan_wr_data(cp, &data[0], false);
+
+	/* enable the chan mask */
+	mask_bit = th1520_mbox_chan_id_to_mapbit(cp);
+	th1520_mbox_rmw(priv, TH_1520_MBOX_MASK, BIT(mask_bit), 0);
+
+	if (cp->type == TH_1520_MBOX_TYPE_DB)
+		/* tx doorbell doesn't have ACK, rx doorbell requires isr */
+		tasklet_init(&cp->txdb_tasklet, th1520_mbox_txdb_tasklet,
+			     (unsigned long)cp);
+
+	/*
+	 * Mixing devm_ managed resources with manual IRQ handling is generally
+	 * discouraged due to potential complexities with resource management,
+	 * especially when dealing with shared interrupts. However, in this case,
+	 * the approach is safe and effective because:
+	 *
+	 * 1. Each mailbox channel requests its IRQ within the .startup() callback
+	 *    and frees it within the .shutdown() callback.
+	 * 2. During device unbinding, the devm_ managed mailbox controller first
+	 *    iterates through all channels, ensuring that their IRQs are freed before
+	 *    any other devm_ resources are released.
+	 *
+	 * This ordering guarantees that no interrupts can be triggered from the device
+	 * while it is being unbound, preventing race conditions and ensuring system
+	 * stability.
+	 */
+	ret = request_irq(priv->irq, th1520_mbox_isr,
+			  IRQF_SHARED | IRQF_NO_SUSPEND, cp->irq_desc, chan);
+	if (ret) {
+		dev_err(priv->dev, "Unable to acquire IRQ %d\n", priv->irq);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void th1520_mbox_shutdown(struct mbox_chan *chan)
+{
+	struct th1520_mbox_priv *priv = to_th1520_mbox_priv(chan->mbox);
+	struct th1520_mbox_con_priv *cp = chan->con_priv;
+	int mask_bit;
+
+	free_irq(priv->irq, chan);
+
+	/* clear the chan mask */
+	mask_bit = th1520_mbox_chan_id_to_mapbit(cp);
+	th1520_mbox_rmw(priv, TH_1520_MBOX_MASK, 0, BIT(mask_bit));
+}
+
+static const struct mbox_chan_ops th1520_mbox_ops = {
+	.send_data = th1520_mbox_send_data,
+	.startup = th1520_mbox_startup,
+	.shutdown = th1520_mbox_shutdown,
+};
+
+static int th1520_mbox_init_generic(struct th1520_mbox_priv *priv)
+{
+#ifdef CONFIG_PM_SLEEP
+	priv->ctx = devm_kzalloc(priv->dev, sizeof(*priv->ctx), GFP_KERNEL);
+	if (!priv->ctx)
+		return -ENOMEM;
+#endif
+	/* Set default configuration */
+	th1520_mbox_write(priv, 0xff, TH_1520_MBOX_CLR);
+	th1520_mbox_write(priv, 0x0, TH_1520_MBOX_MASK);
+	return 0;
+}
+
+static struct mbox_chan *th1520_mbox_xlate(struct mbox_controller *mbox,
+					   const struct of_phandle_args *sp)
+{
+	struct th1520_mbox_con_priv *cp;
+	u32 chan, type;
+
+	if (sp->args_count != 2) {
+		dev_err(mbox->dev, "Invalid argument count %d\n",
+			sp->args_count);
+		return ERR_PTR(-EINVAL);
+	}
+
+	chan = sp->args[0]; /* comm remote channel */
+	type = sp->args[1]; /* comm channel type */
+
+	if (chan >= mbox->num_chans) {
+		dev_err(mbox->dev, "Not supported channel number: %d\n", chan);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (chan == TH_1520_MBOX_ICU_KERNEL_CPU0) {
+		dev_err(mbox->dev, "Cannot communicate with yourself\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (type > TH_1520_MBOX_TYPE_DB) {
+		dev_err(mbox->dev, "Not supported the type for channel[%d]\n",
+			chan);
+		return ERR_PTR(-EINVAL);
+	}
+
+	cp = mbox->chans[chan].con_priv;
+	cp->type = type;
+
+	return &mbox->chans[chan];
+}
+
+static void __iomem *th1520_map_mmio(struct platform_device *pdev,
+				     char *res_name)
+{
+	void __iomem *mapped;
+	struct resource *res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, res_name);
+
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get resource: %s\n", res_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	mapped = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mapped))
+		dev_err(&pdev->dev, "Failed to map resource: %s\n", res_name);
+
+	return mapped;
+}
+
+static int th1520_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct th1520_mbox_priv *priv;
+	unsigned int remote_idx = 0;
+	unsigned int i;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	priv->local_icu[TH_1520_MBOX_ICU_KERNEL_CPU0] =
+		th1520_map_mmio(pdev, "local");
+	if (IS_ERR(priv->local_icu[TH_1520_MBOX_ICU_KERNEL_CPU0]))
+		return PTR_ERR(priv->local_icu[TH_1520_MBOX_ICU_KERNEL_CPU0]);
+
+	priv->remote_icu[0] = th1520_map_mmio(pdev, "remote-icu0");
+	if (IS_ERR(priv->remote_icu[0]))
+		return PTR_ERR(priv->remote_icu[0]);
+
+	priv->remote_icu[1] = th1520_map_mmio(pdev, "remote-icu1");
+	if (IS_ERR(priv->remote_icu[1]))
+		return PTR_ERR(priv->remote_icu[1]);
+
+	priv->remote_icu[2] = th1520_map_mmio(pdev, "remote-icu2");
+	if (IS_ERR(priv->remote_icu[2]))
+		return PTR_ERR(priv->remote_icu[2]);
+
+	priv->local_icu[TH_1520_MBOX_ICU_CPU1] =
+		priv->local_icu[TH_1520_MBOX_ICU_KERNEL_CPU0] +
+		TH_1520_MBOX_CHAN_RES_SIZE;
+	priv->local_icu[TH_1520_MBOX_ICU_CPU2] =
+		priv->local_icu[TH_1520_MBOX_ICU_CPU1] +
+		TH_1520_MBOX_CHAN_RES_SIZE;
+	priv->local_icu[TH_1520_MBOX_ICU_CPU3] =
+		priv->local_icu[TH_1520_MBOX_ICU_CPU2] +
+		TH_1520_MBOX_CHAN_RES_SIZE;
+
+	priv->cur_cpu_ch_base = priv->local_icu[TH_1520_MBOX_ICU_KERNEL_CPU0];
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0)
+		return priv->irq;
+
+	/* init the chans */
+	for (i = 0; i < TH_1520_MBOX_CHANS; i++) {
+		struct th1520_mbox_con_priv *cp = &priv->con_priv[i];
+
+		cp->idx = i;
+		cp->chan = &priv->mbox_chans[i];
+		priv->mbox_chans[i].con_priv = cp;
+		snprintf(cp->irq_desc, sizeof(cp->irq_desc),
+			 "th1520_mbox_chan[%i]", cp->idx);
+
+		cp->comm_local_base = priv->local_icu[i];
+		if (i != TH_1520_MBOX_ICU_KERNEL_CPU0) {
+			cp->comm_remote_base = priv->remote_icu[remote_idx];
+			remote_idx++;
+		}
+	}
+
+	spin_lock_init(&priv->mbox_lock);
+
+	priv->mbox.dev = dev;
+	priv->mbox.ops = &th1520_mbox_ops;
+	priv->mbox.chans = priv->mbox_chans;
+	priv->mbox.num_chans = TH_1520_MBOX_CHANS;
+	priv->mbox.of_xlate = th1520_mbox_xlate;
+	priv->mbox.txdone_irq = true;
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = th1520_mbox_init_generic(priv);
+	if (ret) {
+		dev_err(dev, "Failed to init mailbox context\n");
+		return ret;
+	}
+
+	return devm_mbox_controller_register(dev, &priv->mbox);
+}
+
+static const struct of_device_id th1520_mbox_dt_ids[] = {
+	{ .compatible = "thead,th1520-mbox" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, th1520_mbox_dt_ids);
+
+#ifdef CONFIG_PM_SLEEP
+static int __maybe_unused th1520_mbox_suspend_noirq(struct device *dev)
+{
+	struct th1520_mbox_priv *priv = dev_get_drvdata(dev);
+	struct th1520_mbox_context *ctx = priv->ctx;
+	u32 i;
+	/*
+	 * ONLY interrupt mask bit should be stored and restores.
+	 * INFO data all assumed to be lost.
+	 */
+	for (i = 0; i < TH_1520_MBOX_CHANS; i++) {
+		ctx->intr_mask[i] =
+			ioread32(priv->local_icu[i] + TH_1520_MBOX_MASK);
+	}
+	return 0;
+}
+
+static int __maybe_unused th1520_mbox_resume_noirq(struct device *dev)
+{
+	struct th1520_mbox_priv *priv = dev_get_drvdata(dev);
+	struct th1520_mbox_context *ctx = priv->ctx;
+	u32 i;
+
+	for (i = 0; i < TH_1520_MBOX_CHANS; i++) {
+		iowrite32(ctx->intr_mask[i],
+			  priv->local_icu[i] + TH_1520_MBOX_MASK);
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops th1520_mbox_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(th1520_mbox_suspend_noirq,
+				      th1520_mbox_resume_noirq)
+};
+
+static struct platform_driver th1520_mbox_driver = {
+	.probe		= th1520_mbox_probe,
+	.driver = {
+		.name	= "th1520-mbox",
+		.of_match_table = th1520_mbox_dt_ids,
+		.pm = &th1520_mbox_pm_ops,
+	},
+};
+module_platform_driver(th1520_mbox_driver);
+
+MODULE_DESCRIPTION("Thead TH-1520 mailbox IPC driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


