Return-Path: <linux-kernel+bounces-391267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227A19B849A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9435C1F2387E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340681CCEE2;
	Thu, 31 Oct 2024 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kJ3El+7g"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470001CC88C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407666; cv=none; b=pF5pytu/ymqWtMkNZR4Eswo/XooJH39hZWvYwOny6N7xE9NcXAxD83+INzqpgGSwG3w+OAL9xeZyDHsN3Ew5ZWKp1WNl7pxmNUB28acjjgc7ICKCyFfaJGN3YKRvs+1DJ5dpxBCifMGZ0zzjy/CE6zOaDfLfrCXxVbOd0p/WueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407666; c=relaxed/simple;
	bh=p1aGIAIQ30yHRB3g87qsYqrlAnIwusF/8c167MToFEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=dmpRjTgH3CQQJsIsY4GJEbZZe9xJOYVRRDRXMaigVmWt2vPj43mHb49+1SkVIxj38e/PXnSnjQYhH1kurMdEcoZfMjluqOSVne7aooncRcUXUrNKapV/viK6ByFpPETc0zZdeaQ+uxG/qYRiiPHqFAs3F45APP0FKF24SNw1BGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kJ3El+7g; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241031204737euoutp025aaed910826896c31a6913f97f2cdba1~DpJihy7eF2196821968euoutp02u
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:47:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241031204737euoutp025aaed910826896c31a6913f97f2cdba1~DpJihy7eF2196821968euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730407657;
	bh=dkahNnGGCiryvz/YIk3Koma9tzvUz9qNYXCl2UIggEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJ3El+7gWCyM8yvJuOl/JJ+Fzm4klP5dknFIYHORfqwlI7R0HE+XanS4SH+latWaU
	 T27OyvX9HlUXN4vk94aklP7u01kc3Um/Bx83WPbzjpmMCS/2SfIVI9t9HYCy1+xyEH
	 emIvGo6KaGxd5ypWVrBskyppRwNoxXIMYQkLF7lI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241031204735eucas1p1ce4824f17b77238c81aaf374436fe164~DpJhL721h2189621896eucas1p1f;
	Thu, 31 Oct 2024 20:47:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 9D.00.20397.7ECE3276; Thu, 31
	Oct 2024 20:47:35 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241031204734eucas1p1ec2a8a101e805802a851b01d87709061~DpJf4t5bi2174621746eucas1p1T;
	Thu, 31 Oct 2024 20:47:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241031204734eusmtrp2373c40e9c0baaae21f183a7fec87160c~DpJf38rAy1392413924eusmtrp2u;
	Thu, 31 Oct 2024 20:47:34 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-55-6723ece74606
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F7.53.19920.6ECE3276; Thu, 31
	Oct 2024 20:47:34 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241031204733eusmtip1acf139a23240eadc0e8953ee0ee8e5be~DpJfDylTx1276712767eusmtip1q;
	Thu, 31 Oct 2024 20:47:33 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com, samuel.holland@sifive.com,
	emil.renner.berthing@canonical.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v5 1/3] mailbox: Introduce support for T-head TH1520 Mailbox
 driver
Date: Thu, 31 Oct 2024 21:47:21 +0100
Message-Id: <20241031204723.1149912-2-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031204723.1149912-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7rP3yinG7z9oG2x9fcsdos1e88x
	Wcw/co7V4t6lLUwWlzpXMFq82NvIYnFtxVx2i5ez7rFZXN41h81i2+cWNou1R+6yW6z/Op/J
	4uXlHmaLtln8Fv/37GC3WH3uCotFy/4pLA6CHrMaetk83rx8yeJxuOMLu8fOWXfZPTat6mTz
	2Lyk3qNl7TEmj/f7rrJ59G1Zxehxqfk6u8fnTXIB3FFcNimpOZllqUX6dglcGY8P3mcq2LSA
	seJ0fytzA+PfFsYuRk4OCQETiX2d+9m6GLk4hARWMEpMv7ybHcL5wigx8fRpFgjnM6PEic97
	2WBa/p98yQyRWM4o8f1iCyuE84ZR4t3kHlaQKjYBI4kHy+eDJUQE1jNJPNu9DGwws0Avo8TU
	vTOZQKqEBUIlet7cATuFRUBVYvuPx2A7eAXsJbYsXs8CsU9eYv/Bs8wgNqeAg8TsXa3sEDWC
	EidnPgGrYQaqad46G+wmCYHNnBLtx98yQTS7SOxqmMAKYQtLvDq+hR3ClpH4v3M+VE2+xIOt
	n5gh7BqJnT3HoWxriTvnfgEdxAG0QFNi/S59iLCjRO/mo8wgYQkBPokbbwUhTuCTmLRtOlSY
	V6KjTQiiWk1iak8v3NJzK7ZBLfWQmP/qJdMERsVZSJ6ZheSZWQh7FzAyr2IUTy0tzk1PLTbO
	Sy3XK07MLS7NS9dLzs/dxAhMh6f/Hf+6g3HFq496hxiZOBgPMUpwMCuJ8H4oUE4X4k1JrKxK
	LcqPLyrNSS0+xCjNwaIkzquaIp8qJJCeWJKanZpakFoEk2Xi4JRqYOr73iRoxKhf8Xhz82H7
	4CkPb621nPk4c+WviH6Jjcm5JcmBWRJlVdrMGXPOv/SO0tRct0lb0vs0P3PKTUNXJatzbAKe
	Lcd/7Gg++vqSJOvUiB1inzY0T3992PbZC/E32yrazCerXol/suKxYuS3I4pMcw/FRc+wnu9l
	dVi8crVDuuXjNeXJGpze60U/sgs8nfH6hH7k58nHv9orqq88Lj/vz98jsy1+nE3cXH7m5xTh
	p9I2Lufn2blKbvOcFZfkdKn8/UH3M+3ODHWOk1ZNuhTeuv3wWq//c2SUw75MCV9y6JjPvoff
	dnLM041Q8kosMvdobW2QDA3RNxY/d8Tx+rLP5xO/Pj705tbSbSZpMrpKLMUZiYZazEXFiQDP
	27Dn9gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7rP3iinGyy4LGqx9fcsdos1e88x
	Wcw/co7V4t6lLUwWlzpXMFq82NvIYnFtxVx2i5ez7rFZXN41h81i2+cWNou1R+6yW6z/Op/J
	4uXlHmaLtln8Fv/37GC3WH3uCotFy/4pLA6CHrMaetk83rx8yeJxuOMLu8fOWXfZPTat6mTz
	2Lyk3qNl7TEmj/f7rrJ59G1Zxehxqfk6u8fnTXIB3FF6NkX5pSWpChn5xSW2StGGFkZ6hpYW
	ekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GY8P3mcq2LSAseJ0fytzA+PfFsYuRk4OCQET
	if8nXzJ3MXJxCAksZZR4vH4xO0RCRuJa90sWCFtY4s+1LjYQW0jgFaPE03YjEJtNwEjiwfL5
	rCC2iMB+JonXZ4tABjELTGSUuDn3PtgGYYFgifvnrzCB2CwCqhLbfzwGG8QrYC+xZfF6qAXy
	EvsPnmUGsTkFHCRm72plh1hmL3G0dQ87RL2gxMmZT8DqmYHqm7fOZp7AKDALSWoWktQCRqZV
	jCKppcW56bnFhnrFibnFpXnpesn5uZsYgVG77djPzTsY5736qHeIkYmD8RCjBAezkgjvhwLl
	dCHelMTKqtSi/Pii0pzU4kOMpkB3T2SWEk3OB6aNvJJ4QzMDU0MTM0sDU0szYyVxXrfL59OE
	BNITS1KzU1MLUotg+pg4OKUamA7+fPyqS2rlJnbROfPaGmr+sZ+vVV77sObE4k37rjUeyt2h
	U7lIw0lshtqVeUd3x5QINccvnnTo0LnS9/ZdWnrXbv85dFCL377v1Welv8qr5+87xnrHU7Fh
	8aNrP1fG6FjIq651qFNqfXIs8wR31DXzBg2G37tVyo8lT0nuUuFYtT4nt+JnNrNY00GVJZIb
	189bIFy/23ZGZK9aV2TDrCMzG90K241bHXf0J3/wfrz3zxuWWBP7D717Wb3eXpm5oOfNIZmJ
	b1Y+ChFQn/Zn6xLuzJvcBZmRUx78FbRrM/XtNbzqtFEr2PLARwvVWVxP+Mw/Hkg+t+R6cW8t
	i2T8t1yJJc3LFir/XsyT2WM9yV2JpTgj0VCLuag4EQDnxE+RYwMAAA==
X-CMS-MailID: 20241031204734eucas1p1ec2a8a101e805802a851b01d87709061
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241031204734eucas1p1ec2a8a101e805802a851b01d87709061
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241031204734eucas1p1ec2a8a101e805802a851b01d87709061
References: <20241031204723.1149912-1-m.wilczynski@samsung.com>
	<CGME20241031204734eucas1p1ec2a8a101e805802a851b01d87709061@eucas1p1.samsung.com>

This driver was tested using the drm/imagination GPU driver. It was able
to successfully power on the GPU, by passing a command through mailbox
from E910 core to E902 that's responsible for powering up the GPU. The
GPU driver was able to read the BVNC version from control registers,
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
 drivers/mailbox/mailbox-th1520.c | 592 +++++++++++++++++++++++++++++++
 4 files changed, 605 insertions(+)
 create mode 100644 drivers/mailbox/mailbox-th1520.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a27407950242..df36684221ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19818,6 +19818,7 @@ T:	git https://github.com/pdp7/linux.git
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
index 000000000000..d24861025a47
--- /dev/null
+++ b/drivers/mailbox/mailbox-th1520.c
@@ -0,0 +1,592 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Alibaba Group Holding Limited.
+ */
+
+#include <linux/clk.h>
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
+enum th1520_mbox_icu_cpu_id {
+	TH_1520_MBOX_ICU_KERNEL_CPU0, /* 910T */
+	TH_1520_MBOX_ICU_CPU1, /* 902 */
+	TH_1520_MBOX_ICU_CPU2, /* 906 */
+	TH_1520_MBOX_ICU_CPU3, /* 910R */
+};
+
+struct th1520_mbox_con_priv {
+	enum th1520_mbox_icu_cpu_id idx;
+	void __iomem *comm_local_base;
+	void __iomem *comm_remote_base;
+	char irq_desc[TH_1520_MBOX_CHAN_NAME_SIZE];
+	struct mbox_chan *chan;
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
+	struct clk_bulk_data clocks[TH_1520_MBOX_CHANS];
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
+	th1520_mbox_chan_wr_data(cp, data, true);
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
+	u32 chan;
+
+	if (sp->args_count != 1) {
+		dev_err(mbox->dev, "Invalid argument count %d\n",
+			sp->args_count);
+		return ERR_PTR(-EINVAL);
+	}
+
+	chan = sp->args[0]; /* comm remote channel */
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
+	return &mbox->chans[chan];
+}
+
+static void __iomem *th1520_map_mmio(struct platform_device *pdev,
+				     char *res_name, size_t offset)
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
+	mapped = devm_ioremap(&pdev->dev, res->start + offset,
+			      resource_size(res) - offset);
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
+	priv->clocks[0].id = "clk-local";
+	priv->clocks[1].id = "clk-remote-icu0";
+	priv->clocks[2].id = "clk-remote-icu1";
+	priv->clocks[3].id = "clk-remote-icu2";
+
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(priv->clocks),
+				priv->clocks);
+	if (ret) {
+		dev_err(dev, "Failed to get clocks\n");
+		return ret;
+	}
+
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(priv->clocks), priv->clocks);
+	if (ret) {
+		dev_err(dev, "Failed to enable clocks\n");
+		return ret;
+	}
+
+	/*
+	 * The address mappings in the device tree align precisely with those
+	 * outlined in the manual. However, register offsets within these
+	 * mapped regions are irregular, particularly for remote-icu0.
+	 * Consequently, th1520_map_mmio() requires an additional parameter to
+	 * handle this quirk.
+	 */
+	priv->local_icu[TH_1520_MBOX_ICU_KERNEL_CPU0] =
+		th1520_map_mmio(pdev, "local", 0x0);
+	if (IS_ERR(priv->local_icu[TH_1520_MBOX_ICU_KERNEL_CPU0]))
+		return PTR_ERR(priv->local_icu[TH_1520_MBOX_ICU_KERNEL_CPU0]);
+
+	priv->remote_icu[0] = th1520_map_mmio(pdev, "remote-icu0", 0x4000);
+	if (IS_ERR(priv->remote_icu[0]))
+		return PTR_ERR(priv->remote_icu[0]);
+
+	priv->remote_icu[1] = th1520_map_mmio(pdev, "remote-icu1", 0x0);
+	if (IS_ERR(priv->remote_icu[1]))
+		return PTR_ERR(priv->remote_icu[1]);
+
+	priv->remote_icu[2] = th1520_map_mmio(pdev, "remote-icu2", 0x0);
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
+static void th1520_mbox_remove(struct platform_device *pdev)
+{
+	struct th1520_mbox_priv *priv = platform_get_drvdata(pdev);
+
+	clk_bulk_disable_unprepare(ARRAY_SIZE(priv->clocks), priv->clocks);
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
+static int  __maybe_unused th1520_mbox_runtime_suspend(struct device *dev)
+{
+	struct th1520_mbox_priv *priv = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(ARRAY_SIZE(priv->clocks), priv->clocks);
+
+	return 0;
+}
+
+static int __maybe_unused th1520_mbox_runtime_resume(struct device *dev)
+{
+	struct th1520_mbox_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(priv->clocks), priv->clocks);
+	if (ret)
+		dev_err(dev, "Failed to enable clocks in runtime resume\n");
+
+	return ret;
+}
+
+static const struct dev_pm_ops th1520_mbox_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(th1520_mbox_suspend_noirq,
+				      th1520_mbox_resume_noirq)
+#endif
+	SET_RUNTIME_PM_OPS(th1520_mbox_runtime_suspend,
+			   th1520_mbox_runtime_resume, NULL)
+};
+
+static struct platform_driver th1520_mbox_driver = {
+	.probe		= th1520_mbox_probe,
+	.remove		= th1520_mbox_remove,
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


