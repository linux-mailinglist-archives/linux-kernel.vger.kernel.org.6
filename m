Return-Path: <linux-kernel+bounces-394528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388979BB09F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0104B28233B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4E81B2197;
	Mon,  4 Nov 2024 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W6/2ErFf"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0961AF4C1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714890; cv=none; b=P6o0UqsqqJGVmjcPRb/b8AVYgFWl4zQrQ1ByLdLb9MZJqeSgpdZfpd+3VDHbnLX3U9sVgZAAd6ZUDQGwwHVq527OzkCqBo/ClMBBUztn9vi3uZGXTglRyP21giLTFd/zo+U+atSRzF8f4oJB01kCInSORWerOyCAyeqsPmdIDC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714890; c=relaxed/simple;
	bh=kdPzbMnIcVRajNKEMpnRoDRxvkKW3cJGbMc9mtaVaGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=BP+fnI0zaUd83JYGDZmub3y8plCHTdYh8bZDA2l1gvo7BAWa/zRIRu4Ta/m/eOCKndmvrv5g29zaPoNqdeh9X+tYqJp8Xg1K1/FDcebsB2LiccAvdRZghwYhAUpc2glfM1QPqOC+19z6So1IVObty80StMXDEp6xH8DZMIlIeUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=W6/2ErFf; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241104100800euoutp029376b634795655082cdfeb212897bb61~EvAOr7NqO0342503425euoutp02h
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:08:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241104100800euoutp029376b634795655082cdfeb212897bb61~EvAOr7NqO0342503425euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730714880;
	bh=epMBqPOV6/WJ5cCs2JagFKSycIrunfa+6WLrjOx7VhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6/2ErFfjP4Z2oCL4sqMKuyOnvdZ4lx32+Y9kiU9YC9tX+SIQf0czGVc4aJZPgfXm
	 GyZ1t49ydIz5LwkYoSv4TEmbQpxej9sxzP/1HgAqsjZdJwyP+0peJt4bOzRHfY9uqC
	 leri3/XDq3gAfMeV70bUKdxvRulr59hl5CDS3Nwc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241104100800eucas1p1f022131c9537146d4b35c40419706792~EvAOEjmtB2382123821eucas1p19;
	Mon,  4 Nov 2024 10:08:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id DB.DE.20397.FFC98276; Mon,  4
	Nov 2024 10:08:00 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241104100759eucas1p1251cb0bc0a3c4d621479170a29c454e7~EvANtmmby2023420234eucas1p1m;
	Mon,  4 Nov 2024 10:07:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241104100759eusmtrp1a5ecf17ee96784936f13d72c0da023ef~EvANs2DUq1011310113eusmtrp1U;
	Mon,  4 Nov 2024 10:07:59 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-4f-67289cff942c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.A7.19654.FFC98276; Mon,  4
	Nov 2024 10:07:59 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241104100757eusmtip1022a96e034211d67f2cd933d0d4b9e49~EvALgxBE82730327303eusmtip1g;
	Mon,  4 Nov 2024 10:07:57 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com, samuel.holland@sifive.com,
	emil.renner.berthing@canonical.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, christophe.jaillet@wanadoo.fr, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [PATCH v6 1/3] mailbox: Introduce support for T-head TH1520 Mailbox
 driver
Date: Mon,  4 Nov 2024 11:07:32 +0100
Message-Id: <20241104100734.1276116-2-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104100734.1276116-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7djP87oMczXSDeYfY7TY+nsWu8XWg3NZ
	LdbsPcdkMf/IOVaLe5e2MFlc6lzBaPFibyOLxbUVc9ktXs66x2ZxedccNottn1vYLNYeuctu
	sf7rfCaLl5d7mC3aZvFb/N+zg91i9bkrLBYt+6ewOAh5zGroZfN48/Ili8fhji/sHjtn3WX3
	2LSqk81j85J6j5a1x5g83u+7yubRt2UVo8el5uvsHp83yXl8vrueNYAnissmJTUnsyy1SN8u
	gSujZ/cFtoIZCxkrHtzsY25gPN/K2MXIySEhYCKxf9Yl1i5GLg4hgRWMEs9+HmaGcL4wShx+
	sBIq85lRov39XTaYlp/HvrJBJJYzSpy5/R3KecMo8WriUnaQKjYBI4kHy+eDtYsIrGeSeLZ7
	GViCWWAdo8SnK/YgtrBAqMSM49eZQWwWAVWJldPesILYvAL2EtcvT2GBWCcvsf/gWbAaTgEH
	iV+9X5ggagQlTs58wgIxU16ieetssMMlBHZzSsz+s4wVotlFYsqsB+wQtrDEq+NboGwZidOT
	e6AW5Es82PqJGcKukdjZcxzKtpa4c+4X0GscQAs0Jdbv0ocIO0q87NnODhKWEOCTuPFWEOIE
	PolJ26YzQ4R5JTrahCCq1SSm9vTCLT23YhsThO0h8fvnAcYJjIqzkDwzC8kzsxD2LmBkXsUo
	nlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYIE//O/51B+OKVx/1DjEycTAeYpTgYFYS4Z2X
	qp4uxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc1RT5VSCA9sSQ1OzW1ILUIJsvEwSnVwMT5RHbi
	82U92fe0uuOLL72+cVmr2+jFySny/Lv95xV+W8usIdQjGM3zoeVjzQd7H4E3FU8/yDM9cu61
	kj281Yz9xCFz0QP3J7Y17DRw4Vx9+9cFTk0d57cvNlt5rrq2dWcOh2bPFXWu+0tjXv6rvnti
	Qd/VPbWhr1NYgjcYaMw5PrXiXO5VNvuPa+4U3lpy9JLQ55z9bWf5X350r061aK7y17jbt2kn
	S8lV+/5fwu6Fl5JMWNxmm3yybGicr7x3gVVgZWvgt8n3LWyinzDOC9TsfhdtvlLuQ+9p6/35
	bz9ksVzuS3Xcbcb8WDbLKcfx7pxFHxJ/Lrf76/j6glKGEOOiOkPjB/Nlvnr+qnf/lqvEUpyR
	aKjFXFScCABNh8Di/wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xu7r/52ikG5z9oWyx9fcsdoutB+ey
	WqzZe47JYv6Rc6wW9y5tYbK41LmC0eLF3kYWi2sr5rJbvJx1j83i8q45bBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF6nNXWCxa9k9hcRDymNXQy+bx5uVLFo/DHV/YPXbOusvu
	sWlVJ5vH5iX1Hi1rjzF5vN93lc2jb8sqRo9LzdfZPT5vkvP4fHc9awBPlJ5NUX5pSapCRn5x
	ia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl5Gz+4LbAUzFjJWPLjZx9zA
	eL6VsYuRk0NCwETi57GvbF2MXBxCAksZJX4vO84EkZCRuNb9kgXCFpb4c60LqugVo8T11TfB
	EmwCRhIPls9nBbFFBPYzSbw+WwRSxCywiVHi0sp+dpCEsECwxKQJbWDrWARUJVZOewPWwCtg
	L3H98hSoDfIS+w+eZQaxOQUcJH71fgG7Qgio5uCBPYwQ9YISJ2c+AatnBqpv3jqbeQKjwCwk
	qVlIUgsYmVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExvK2Yz+37GBc+eqj3iFGJg7GQ4wS
	HMxKIrzzUtXThXhTEiurUovy44tKc1KLDzGaAt09kVlKNDkfmEzySuINzQxMDU3MLA1MLc2M
	lcR52a6cTxMSSE8sSc1OTS1ILYLpY+LglGpgKtZe/e3FOykL5hen3jlklfTN8Dj2wfKmB6uY
	R4B4y6OzF177iORf5j5mn2/7urXS5cT9bSoVnY1z5oqvnblZ4cQKYwXm6MBP98WPyDyMCPq9
	eWLn3n9Kz77Hdt5QanrlpRP3qTvoyz/DX3mrTixtWFFq+ibLdenuD0Ky09Rj/nz6vfrt80c/
	n/RoT9t7QTi1seSj+jWt9V+MtEPYdvTO3BQiILZcp+aiiMjk/yJrijrsV357eDBjk/tknZQ3
	7ZsZcq4ZqE3s/rVoZ/fvl4zVH99vsg9cktFsnXaq+1iK8Km6p8tXWO+OtUj81vBg/fr4LJZH
	4hJxJydZvbDaKWbkFDqRqcbrbJsxzzL1tRl7I5RYijMSDbWYi4oTAby9hAxuAwAA
X-CMS-MailID: 20241104100759eucas1p1251cb0bc0a3c4d621479170a29c454e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241104100759eucas1p1251cb0bc0a3c4d621479170a29c454e7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241104100759eucas1p1251cb0bc0a3c4d621479170a29c454e7
References: <20241104100734.1276116-1-m.wilczynski@samsung.com>
	<CGME20241104100759eucas1p1251cb0bc0a3c4d621479170a29c454e7@eucas1p1.samsung.com>

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
 drivers/mailbox/mailbox-th1520.c | 597 +++++++++++++++++++++++++++++++
 4 files changed, 610 insertions(+)
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
index 000000000000..4e84640ac3b8
--- /dev/null
+++ b/drivers/mailbox/mailbox-th1520.c
@@ -0,0 +1,597 @@
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
+static void th1520_disable_clk(void *data)
+{
+	struct th1520_mbox_priv *priv = data;
+
+	clk_bulk_disable_unprepare(ARRAY_SIZE(priv->clocks), priv->clocks);
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
+	ret = devm_add_action_or_reset(dev, th1520_disable_clk, priv);
+	if (ret) {
+		clk_bulk_disable_unprepare(ARRAY_SIZE(priv->clocks), priv->clocks);
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


