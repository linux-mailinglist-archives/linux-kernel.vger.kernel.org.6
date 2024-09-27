Return-Path: <linux-kernel+bounces-341551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C0988188
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47D88B244AA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2521BAEEE;
	Fri, 27 Sep 2024 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bQuI9oTC"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D3A1BB6A0
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430144; cv=none; b=EqnklnhilXgi1Bz55lxDLZwvT+zL9ObCrWANZ7XadL0g+BbKyNEryyXiJuN0P1cv3M+YZOuGBuH+oMCijFa2ie5LcBxqoQzKpFeTd+hu7vfWFjDyVcLNp+ZUAadmOl8vzaYLa+bQjLRZuyosyjdV/DB108eMKuSk2JtkeK9RfLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430144; c=relaxed/simple;
	bh=4BUX8I1k6t9BHKUlOSeBXUH2SpXe9YBPKOaEX62xhck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=XaPeq9bfdDJ7nXMFnxS/OH7bTsnUXJuiCr2H7/6auC+H/H7PMUlOQt72kCnx11CIHotqU/YVfQYcw/Fvu3sBeKrld8iGOh7iyfKbTP4QDvBOAr0WLaBBkROajPZUbMDfS8kkOAJ+ex5j/54DJf35deuOvh1p4A7lX9K3xLtgx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bQuI9oTC; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240927094215euoutp02d9d5e5049066cfc49da895d343421e31~5EI5PMkRI0682006820euoutp02V
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:42:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240927094215euoutp02d9d5e5049066cfc49da895d343421e31~5EI5PMkRI0682006820euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727430135;
	bh=JLer4Lqu4MEQe7zRCZwllFyQaZeHkjWiMfeckrSE3dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQuI9oTChw1p5w/K26MF8dB1RYbbjKDJq7L0m7NqT4/uOyUm3gt8tzHGFN7FtsqAF
	 sHlABIqCSfFne79RQe+yt35HHXF5g2AobDfDFu0g5ux2OIY4SaYSAo76ZcgjU2k37M
	 GXs5MiKBoGwNOjN6//P0Uv5TAaXnKsVYZjmuDK/c=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240927094215eucas1p278ff0e4bb806f1a69e2b436594582699~5EI46Q2Kc2825128251eucas1p2u;
	Fri, 27 Sep 2024 09:42:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E4.CF.09624.6FD76F66; Fri, 27
	Sep 2024 10:42:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240927094214eucas1p272cf99b40344f501cbbfaa91c929c709~5EI4OPoH70186301863eucas1p2W;
	Fri, 27 Sep 2024 09:42:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240927094214eusmtrp297611290da9cc8b786a67137aa6ab3b1~5EI4Nkw3F2855228552eusmtrp2M;
	Fri, 27 Sep 2024 09:42:14 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-b8-66f67df6d21d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 6C.33.14621.6FD76F66; Fri, 27
	Sep 2024 10:42:14 +0100 (BST)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240927094213eusmtip2799f5e74f39c8cce7aeed3f5c51179fc~5EI3aQGIG1990319903eusmtip2G;
	Fri, 27 Sep 2024 09:42:13 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH RFC v2 1/3] mailbox: Introduce support for T-head TH1520
 Mailbox driver
Date: Fri, 27 Sep 2024 11:42:05 +0200
Message-Id: <20240927094207.1650085-2-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927094207.1650085-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djPc7rfa7+lGZx3tNj6exa7xZq955gs
	5h85x2px79IWJosXextZLK6tmMtu8XLWPTaLy7vmsFls+9zCZrH2yF12i/Vf5zNZvLzcw2zR
	Novf4v+eHewWLfunsDjwe7x5+ZLF43DHF3aPnbPusntsWtXJ5rF5Sb1Hy9pjTB7v911l8+jb
	sorR41LzdXaPz5vkAriiuGxSUnMyy1KL9O0SuDJ2vOYtmDaNsWLOpE0sDYzPa7oYOTkkBEwk
	9u+ZxNbFyMUhJLCCUeLJ053sEM4XRolDm/ewQDifGSVe3XjKCtPy+cNTRojEckaJ1o0tUC1v
	GCWOTbnDDFLFJmAk8WD5fFaQhIjAO0aJSdduM4E4zAK9jBJT985kAqkSFoiU2PZqLthcFgFV
	iSu3djGC2LwC9hIb/r9ig9gnL7H/4FmwqZwCDhKfl75hhagRlDg58wkLiM0MVNO8dTYzyAIJ
	gdmcEp0nTjNDNLtIdD5/DWULS7w6voUdwpaR+L9zPhOEnS/xYOsnqJoaiZ09x6Fsa4k7534B
	HcEBtEBTYv0ufRBTQsBRYveROgiTT+LGW0GIC/gkJm2bzgwR5pXoaBOCmKEmMbWnF27nuRXb
	oHZ6SCxdfoVxAqPiLCS/zELyyyyEtQsYmVcxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIE
	JrrT/45/2sE499VHvUOMTByMhxglOJiVRHitzn1NE+JNSaysSi3Kjy8qzUktPsQozcGiJM6r
	miKfKiSQnliSmp2aWpBaBJNl4uCUamCa7r6l+G1uf4Rp96XPbovOTHrMP3Vd6p3pkV99XZNX
	fDkc9jfYfd+0vrLnbzTZzlySmXA8J3np5DyLuf1fHp/f1ri+oCjGfJtiyN7/cm9KzIvOT7ES
	2NDMMnVG2jrzPZvycwV6OrdsZ7Gu8FVI/yrt4LEuekeyymTz72k/bgT9idLbVTlz4uWT4hIS
	W+YEn+e3O8u9ya5m0fIXZnE1W42KOq17w6/Mls2YY7aAxWTXzdym1Xttr/y1lVx60HCxoNSV
	L9tMzjdrP954RzX2++1leXIK0nabNM8mfzQtePCnQrc/5ffz1kb3Z6+OJVsqPry8fMfWqdUf
	umy+Hg6wM9Fa/3Pp73Xdk+NWTau7oshfrcRSnJFoqMVcVJwIACWioEjjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xe7rfar+lGbzaymex9fcsdos1e88x
	Wcw/co7V4t6lLUwWL/Y2slhcWzGX3eLlrHtsFpd3zWGz2Pa5hc1i7ZG77Bbrv85nsnh5uYfZ
	om0Wv8X/PTvYLVr2T2Fx4Pd48/Ili8fhji/sHjtn3WX32LSqk81j85J6j5a1x5g83u+7yubR
	t2UVo8el5uvsHp83yQVwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZ
	pKTmZJalFunbJehl7HjNWzBtGmPFnEmbWBoYn9d0MXJySAiYSHz+8JSxi5GLQ0hgKaPE9Qkn
	2SASMhLXul+yQNjCEn+udbFBFL1ilFi+/B0rSIJNwEjiwfL5rCAJEYE/QN3P3oCNYhaYyChx
	c+59IIeDQ1ggXOJcKw9IA4uAqsSVW7sYQWxeAXuJDf9fQW2Tl9h/8CwziM0p4CDxeekbsAVC
	QDUdR/ezQ9QLSpyc+QTsImag+uats5knMArMQpKahSS1gJFpFaNIamlxbnpusaFecWJucWle
	ul5yfu4mRmBUbjv2c/MOxnmvPuodYmTiYDzEKMHBrCTCa3Xua5oQb0piZVVqUX58UWlOavEh
	RlOguycyS4km5wPTQl5JvKGZgamhiZmlgamlmbGSOK/b5fNpQgLpiSWp2ampBalFMH1MHJxS
	DUyTJkbcl9U7zPtmyprd+/i7zta98+rOqIt51rf93K7wY23PcqZJqwRb8dm9eXHASsv19aHd
	Drbr5r2b+G/GnNUv5jTvkpr2O9Vs9ZzUtdVmaQxyC/+xnxLJyV/96UimvLrE5Cl3VgZ/+vbu
	q+jD2yuUZHnzf+9Yttrh37c/URu8yzgP6Mcu3X73fN0PlXtzTTcejSs8Z7hjPuds+04Dx27F
	aZbr5E1EmirO73068UaB9QnHt7aF5gpfhdVer5cR1YmIWi3aNve/AcvqmvdMjo3qnAYV2jpv
	o1PPmXhwN/QdW2y5+eDHmXK/ArOn6bRvu3lITzD7tJ2joMBMK8a0o9kn62f+E38ivF75yZlV
	qY/4lViKMxINtZiLihMBPo3KTVMDAAA=
X-CMS-MailID: 20240927094214eucas1p272cf99b40344f501cbbfaa91c929c709
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240927094214eucas1p272cf99b40344f501cbbfaa91c929c709
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240927094214eucas1p272cf99b40344f501cbbfaa91c929c709
References: <20240927094207.1650085-1-m.wilczynski@samsung.com>
	<CGME20240927094214eucas1p272cf99b40344f501cbbfaa91c929c709@eucas1p2.samsung.com>

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
 drivers/mailbox/mailbox-th1520.c | 551 +++++++++++++++++++++++++++++++
 4 files changed, 564 insertions(+)
 create mode 100644 drivers/mailbox/mailbox-th1520.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 00716c1faff6..df4d7be6cf35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19945,6 +19945,7 @@ T:	git https://github.com/pdp7/linux.git
 F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c
+F:	drivers/mailbox/mailbox-th1520.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 
 RNBD BLOCK DRIVERS
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 4eed97295927..1c87a6b6b607 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -294,4 +294,14 @@ config QCOM_IPCC
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
index 000000000000..cb77d0912368
--- /dev/null
+++ b/drivers/mailbox/mailbox-th1520.c
@@ -0,0 +1,551 @@
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
+#define TH_1520_MBOX_STA			0x0
+#define TH_1520_MBOX_CLR			0x4
+#define TH_1520_MBOX_MASK			0xc
+
+/* Transmit/receive data register:
+ * INFO0 ~ INFO6
+ */
+#define TH_1520_MBOX_INFO_NUM			8
+#define TH_1520_MBOX_DATA_INFO_NUM		7
+#define TH_1520_MBOX_INFO0			0x14
+/* Transmit ack register: INFO7 */
+#define TH_1520_MBOX_INFO7			0x30
+
+/* Generate remote icu IRQ Register */
+#define TH_1520_MBOX_GEN			0x10
+#define TH_1520_MBOX_GEN_RX_DATA		BIT(6)
+#define TH_1520_MBOX_GEN_TX_ACK			BIT(7)
+
+#define TH_1520_MBOX_CHAN_RES_SIZE		0x1000
+#define TH_1520_MBOX_CHANS			4
+#define TH_1520_MBOX_CHAN_NAME_SIZE		20
+
+#define TH_1520_MBOX_ACK_MAGIC			0xdeadbeaf
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
+	TH_1520_MBOX_ICU_CPU0, /* 910T */
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
+	enum th1520_mbox_icu_cpu_id cur_icu_cpu_id;
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
+static struct th1520_mbox_priv *to_th1520_mbox_priv(struct mbox_controller *mbox)
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
+			  u32 clr)
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
+				  u32 offs, bool is_remote)
+{
+	if (is_remote)
+		iowrite32(val, cp->comm_remote_base + offs);
+	else
+		iowrite32(val, cp->comm_local_base + offs);
+}
+
+static u32 th1520_mbox_chan_read(struct th1520_mbox_con_priv *cp, u32 offs,
+				bool is_remote)
+{
+	if (is_remote)
+		return ioread32(cp->comm_remote_base + offs);
+	else
+		return ioread32(cp->comm_local_base + offs);
+}
+
+static void th1520_mbox_chan_rmw(struct th1520_mbox_con_priv *cp, u32 off,
+				u32 set, u32 clr, bool is_remote)
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
+static void th1520_mbox_chan_rd_data(struct th1520_mbox_con_priv *cp, void *data,
+				    bool is_remote)
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
+static void th1520_mbox_chan_wr_data(struct th1520_mbox_con_priv *cp, void *data,
+				    bool is_remote)
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
+				   bool is_remote)
+{
+	u32 off = TH_1520_MBOX_INFO7;
+	u32 *arg = data;
+
+	th1520_mbox_chan_write(cp, *arg, off, is_remote);
+}
+
+static int th1520_mbox_chan_id_to_mapbit(struct th1520_mbox_con_priv *cp)
+{
+	struct th1520_mbox_priv *priv = to_th1520_mbox_priv(cp->chan->mbox);
+	int mapbit = 0;
+	int i;
+
+	for (i = 0; i < TH_1520_MBOX_CHANS; i++) {
+		if (i == cp->idx)
+			return mapbit;
+
+		if (i != priv->cur_icu_cpu_id)
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
+					    TH_1520_MBOX_GEN_TX_ACK, 0, true);
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
+			    true);
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
+	/* clear the chan mask */
+	mask_bit = th1520_mbox_chan_id_to_mapbit(cp);
+	th1520_mbox_rmw(priv, TH_1520_MBOX_MASK, 0, BIT(mask_bit));
+
+	free_irq(priv->irq, chan);
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
+					  const struct of_phandle_args *sp)
+{
+	struct th1520_mbox_priv *priv = to_th1520_mbox_priv(mbox);
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
+	if (chan == priv->cur_icu_cpu_id) {
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
+static int th1520_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct th1520_mbox_priv *priv;
+	struct resource *res;
+	unsigned int remote_idx = 0;
+	unsigned int i;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (of_property_read_u32(np, "thead,icu-cpu-id", &priv->cur_icu_cpu_id)) {
+		dev_err(dev, "thead,icu-cpu-id is missing\n");
+		return -EINVAL;
+	}
+
+	if (priv->cur_icu_cpu_id != TH_1520_MBOX_ICU_CPU0 &&
+	    priv->cur_icu_cpu_id != TH_1520_MBOX_ICU_CPU3) {
+		dev_err(dev, "thead,icu-cpu-id is invalid\n");
+		return -EINVAL;
+	}
+
+	priv->dev = dev;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "local");
+	priv->local_icu[TH_1520_MBOX_ICU_CPU0] = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->local_icu[TH_1520_MBOX_ICU_CPU0]))
+		return PTR_ERR(priv->local_icu[TH_1520_MBOX_ICU_CPU0]);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "remote-icu0");
+	priv->remote_icu[0] = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->remote_icu[0]))
+		return PTR_ERR(priv->remote_icu[0]);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "remote-icu1");
+	priv->remote_icu[1] = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->remote_icu[1]))
+		return PTR_ERR(priv->remote_icu[1]);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "remote-icu2");
+	priv->remote_icu[2] = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->remote_icu[2]))
+		return PTR_ERR(priv->remote_icu[2]);
+
+	priv->local_icu[TH_1520_MBOX_ICU_CPU1] =
+		priv->local_icu[TH_1520_MBOX_ICU_CPU0] + TH_1520_MBOX_CHAN_RES_SIZE;
+	priv->local_icu[TH_1520_MBOX_ICU_CPU2] =
+		priv->local_icu[TH_1520_MBOX_ICU_CPU1] + TH_1520_MBOX_CHAN_RES_SIZE;
+	priv->local_icu[TH_1520_MBOX_ICU_CPU3] =
+		priv->local_icu[TH_1520_MBOX_ICU_CPU2] + TH_1520_MBOX_CHAN_RES_SIZE;
+
+	priv->cur_cpu_ch_base = priv->local_icu[priv->cur_icu_cpu_id];
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
+		if (i != priv->cur_icu_cpu_id) {
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
+MODULE_DESCRIPTION("Thead Light mailbox IPC driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


