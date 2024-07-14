Return-Path: <linux-kernel+bounces-251869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC52930AD7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 18:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D476A1F21B21
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF6813CA81;
	Sun, 14 Jul 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="SEYR3dUW"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2185.outbound.protection.outlook.com [40.92.63.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F2B13C80A;
	Sun, 14 Jul 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.185
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720975042; cv=fail; b=VJRSeEGqKknwqeIn9Vv861xRcpWNFRcStRkbvtKcwFxubqTwVZGrn4zbhSKlbHqTCq2N8ruCKEPLZNf3w9hNpM1bcv3zuZBfFitQK0IMFM6Mdgr73fzsI6hRUxZruEW046CHpoYd9fdfMEawR05HmVpL0I/1snB9Ysl6f/9hgIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720975042; c=relaxed/simple;
	bh=a6dSf3H5AOfpaczL9Z45X3Kj3uuVwhaFXAsLd3Qh5sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o5HzDrm/Q3rh64d4l9lErK8ivF8bZar9CDcqT2nFC0Ojp2/UBX32g/pn8Sg5vUJF8CVP1dj1XargAU9TXo7XYy1gEgRqhhhS/EbMYWRTNZVykpUeZjeMqsD68r8s8NknFnOKqNYI0WTZMIRklFP2VE+rfvt03SKHDV99avIx8UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=SEYR3dUW; arc=fail smtp.client-ip=40.92.63.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7kGvswOAXGZv1I4M7rek+UWZ8g77ynPsRfVRkh8m6b03U1FUqiJkhmYTpUGrm9JQThandnADs97b+RmHkYIxrReN7bYYVCPpFspo21MGfXDxoCwdlJdX+VeJYXFd7NkKJl2drzJ0il9mWLni8uDtdrCauynKsEuAvDvxGgqEpQ9EAs0YtrG4+3Pbn8TrEZM+SQRQDaxk3erGdGGS5b0EKEiLGNnVENdeuBdrQW6fDO5EK4+Tyt7StefEFGMvrwgzC9Nm7GV/D1A++oiYaocW0b/JTahLQOaxhZwBVR2O2afLSQeyr3QlCFg/7Cz7Y3/JNCLytGpPTDIgFy17ZBWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCtnl71JUoNl2Loro+eZBJCc4y5uYoR5wLyUQFnXc44=;
 b=mU32xdAejAx2bR6/t3GyE4X/t8xqQ22fW3Y+snOeLR2YuHl0hhgXot4Rm94VC8Agqs+OsBanqFZTU18TkCUAMnFO3ITFOj8mz4eZBI35UYrqbzHYevXrR/glp/LOHU79V0FWjSkCddV39GzowbkZuVl8bYnFHyD17AHMNNF9UAsoEt4cWJbfKESGBano6PqHkiA6rrXcPO4AH5HYVLjFvLmzd2NAuY10mIfX6uilN9uV5JgLi/ZJW5CiqaoyTNOoUdO0+hVXREmGWBEj+LU7HkdDBrqGTX9DxA8aUcPUzE4vuwPBX4HLIrrfsgACoLZ/Tir2MlOQuOqeN0wcnzx2ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCtnl71JUoNl2Loro+eZBJCc4y5uYoR5wLyUQFnXc44=;
 b=SEYR3dUWzkbduovRYuLbzJLA10SWijROXvw5Vgk4CyhuobV6NiT7tOh/711vN6clUHEq1e2HP5Cd0prj4g5usa+H0+wrz/Baz21IEqQuLJsnVwY+h7b7cdDK6eUNhmgLFJvQ3QSeFWI4w0h18g7cXdFR1oZ6ce8zRtvF2/XC1LIa1Nix8Wj8L5K0+4iLHXSZrplwHAn4DQDFpDIfh25vKLd1+hEupeBnrNLuZOsiOMXZj503j6+Zg9rxCPBB2H7Lhk6+gAApxIMeeYVC2FwxtDYWZFIt5kRpqBhzge/nrx4TQOC7p4CRhHHdD+t8PhDU62MhzrqlyOyTrcItPLNm1A==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 SYYP282MB0991.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:b5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Sun, 14 Jul 2024 16:37:17 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%4]) with mapi id 15.20.7762.027; Sun, 14 Jul 2024
 16:37:17 +0000
From: Yuntao Dai <d1581209858@live.com>
To: jassisinghbrar@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yuntao Dai <d1581209858@live.com>
Subject: [PATCH v2 3/3] mailbox: sophgo: add mailbox driver for cv18x SoCs
Date: Mon, 15 Jul 2024 00:36:47 +0800
Message-ID:
 <SYBP282MB2238F93565D20F0A5F3EEB6BC4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <SYBP282MB223825D5903777B937A8A377C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
References: <SYBP282MB223825D5903777B937A8A377C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-TMN: [sIWpT/CT1rUzad5OrzMRxPI3pFfF5/RBe06CytinWOg=]
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:9b::8)
X-Microsoft-Original-Message-ID: <20240714163647.10814-3-d1581209858@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2238:EE_|SYYP282MB0991:EE_
X-MS-Office365-Filtering-Correlation-Id: 909bc56b-48c8-40d1-dd6d-08dca4233930
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	1yMAuuX7zu+ef6F2yJ0FgsAucyhP3gTJLlKuWFnFfUsFrsTDeI/koN6q9rPZtVqp58wMzzrkAHP5RtiiGrJLWO6lC8lbqHEv5+luu3zLfM3ojZN3rgf63cys3fKqd3O7f6HVVbPRbDyMXKC3SrOMB3eFqWxXi6HrZMnHpGPDVAv8XwW61Hg97qsf6RVnqJJEIx890zXNY+C9Z9C1EGs8cymXUTl4LRmpcHQXyaT8PLCcxzqpeLWfs3Yc+ZPT/GwMp4nYIp9PC0U6x9oWLfjaEay34Xixh8R0Anw6UaOWVVZs0S3HU9za6/q9ttSq/TS/y9v+dLAd5NJZs5AAUTHsxRzHXRvx1SIDyW8eTzyDATUwzSvM7j2lkOmHwwDIfsEkZ4WoJQsGiCveY04ZKq+mzrTHU6bPtZ+Uym/x9Cx2xt5/NhqCK+nbvH13b/X2PF8jsemcdq2N26dn2d7XFiYDdFkUEG73WZCNfOBbli7V1PMabjSovafsWmsSo4pVs45qaguTNwSCyk97kgmgoAw96zTkNlz2MUzCGI11F+GbA1K2FLOcUdK8VJ4xyLrLZS9cAUfGDGAnb8rL49vr+/jzDQaTnvJ4DjIB454zcDtXTodfIssKs1G7Rn01dUhbFrcxs/1XqhPl3iAJ6IvmrE6V9UJwawbRILI1rvFvcAwxqmeZ45v4IwBEUPYKjP3kwwYW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bsTDqMVh25etUMjMhv6izsoxe/4SWpHf6ZpH5H4XKBYfmdhRMG1lBGoQEF6p?=
 =?us-ascii?Q?Kqd1kTFHKwP8GILFCp7Iowpy1gldl+3OwGypj5DZ3wNon5QbTKzSSAKdOHfP?=
 =?us-ascii?Q?Po9Bv+MPJ0VMQKTj2XfMxnKdrSZmR4a32LYFNBeWg7bKRYoCaNAhQLlHFW5e?=
 =?us-ascii?Q?6GjIsBPBNNktF47XgvJcMAPJyc7/1BO1dD4Y2RK0COlXy+Cmx7cvlMp9lK45?=
 =?us-ascii?Q?fX4PVu9n4xVbML4ELEYG4qx/5OQwUwmqdDAH2g+FxSy8XozXAz2aJucKLNkD?=
 =?us-ascii?Q?nqQYxmYZS59YG4VwWCCY/GIxxF1RsNnSe0zRWH7wRE8cwewnsqd7cTgOXg1x?=
 =?us-ascii?Q?vIurfRdffEUdJoMP390BSS+VJ3EhEzBlz8vMdWOEhc9QVGR+DLcDsCgRQm+S?=
 =?us-ascii?Q?U8Ny/ICC77oED8VosY5u/zB/rNBhb+5+GQsBqeDKlGLJgyIVr+yDIqU8dvDx?=
 =?us-ascii?Q?8nlLYJ80UTOAu5iT+jkKwMJ3ZKjeY8DzvyrKfFe7NemN8CjyZ8ZoXRBv+cOa?=
 =?us-ascii?Q?dfa3+3+LvoF/h0QuE5Cl0YBsFxMv6e4fPp56C5qpijzsz+BEXa7UtAcpMlX/?=
 =?us-ascii?Q?VzOvIyGv3zaX2qEgfz25qL4qSNeUUGJsGDMUkCQ+HazlCBmFUSWrCUgcpTw/?=
 =?us-ascii?Q?pfJpBhKgnUo5To5lfjvJ6VM062zgguvYqGUaUhvZpuQpHMIUOpfGzFoDaoTn?=
 =?us-ascii?Q?/wf1Pk8BOfH3CweK2D/yFb36QvZXCM5j497e2NVrZqGYqbPEBJt20dA0/w68?=
 =?us-ascii?Q?nUIrLEbqdox94O+LEgAmb2pm7tDZCXRMB99oQsnBY3bMf5WlLihdYNXLmJnG?=
 =?us-ascii?Q?BQD4U+fZ2cECOjEAnybAe1IG3gH/2UTMsMaVAcq9sIqeRZfat7MOmioEWGAR?=
 =?us-ascii?Q?M43Y9gM4VcAmOsTc0zXig1+htCLG9MJf5O7w7Zs24RGLL8XOBnq09ygHrdWn?=
 =?us-ascii?Q?IboqKcYz49jSjELB8GXNZuMN3t5pAPLGMzTDURsTIMGOsOz9j52vmamxb8vL?=
 =?us-ascii?Q?peO2kjYuSkwjSnquInmu+5Lpzefe+7Vd1dpmjpANcfskmMmW+wd7ZE/3AqU0?=
 =?us-ascii?Q?6q5zjaYDH9gYL1eItulGK01vfNcDsvRNW6Qe+U65Rml+2/p3EIw4dihq6MDq?=
 =?us-ascii?Q?wFqp1yDE6Iabn4AL5/6/Q5LwiJ0n/I0p++5kV1P5Ly07lMI/h43bvwNUlh3+?=
 =?us-ascii?Q?Vrv+IuRUi8leEPWilAHz+Yfse8e1/r6WODs4w54uqJM8ge1fMKYpYW01hmg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-722bc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 909bc56b-48c8-40d1-dd6d-08dca4233930
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 16:37:17.1676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB0991

Add mailbox controller driver for cv18x SoCs, tested on mailbox-test
client.

Signed-off-by: Yuntao Dai <d1581209858@live.com>
---
 drivers/mailbox/Kconfig          |  11 ++
 drivers/mailbox/Makefile         |   2 +
 drivers/mailbox/cv1800-mailbox.c | 203 +++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 drivers/mailbox/cv1800-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 3b8842c4a..db856ec7e 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -286,4 +286,15 @@ config QCOM_IPCC
 	  acts as an interrupt controller for receiving interrupts from clients.
 	  Say Y here if you want to build this driver.
 
+config CV1800_MBOX
+	tristate "cv1800 mailbox"
+	depends on OF
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  Mailbox driver implementation for Sophgo cv180x SoCs. This driver
+	  can be used to send message between different processors in SoC. Any
+	  processer can write data in a channel, and set co-responding register
+	  to raise interrupt to notice another processor, and it is allowed to
+	  send data to itself.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 5cf2f54de..2c6db8c5c 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -62,3 +62,5 @@ obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
 obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
 
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
+
+obj-$(CONFIG_CV1800_MBOX)	+= cv1800-mailbox.o
\ No newline at end of file
diff --git a/drivers/mailbox/cv1800-mailbox.c b/drivers/mailbox/cv1800-mailbox.c
new file mode 100644
index 000000000..a3b214b4d
--- /dev/null
+++ b/drivers/mailbox/cv1800-mailbox.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kfifo.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define RECV_CPU 2
+
+#define MAILBOX_MAX_CHAN 0x0008
+#define MAILBOX_DONE_OFFSET 0x0002
+#define MAILBOX_CONTEXT_SIZE 0x0040
+#define MAILBOX_CONTEXT_OFFSET 0x0400
+
+#define MBOX_EN_REG(cpu) (cpu << 2)
+#define MBOX_DONE_REG(cpu) ((cpu << 2) + MAILBOX_DONE_OFFSET)
+
+#define MBOX_SET_CLR_REG(cpu) (0x10 + (cpu << 4))
+#define MBOX_SET_INT_REG(cpu) (0x18 + (cpu << 4))
+
+#define MBOX_SET_REG 0x60
+
+/**
+ * cv1800 mailbox channel private data
+ * @idx: index of channel
+ * @cpu: send to which processor
+ */
+struct cv1800_mbox_chan_priv {
+	int idx;
+	int cpu;
+};
+
+struct cv1800_mbox {
+	struct mbox_controller mbox;
+	struct cv1800_mbox_chan_priv priv[MAILBOX_MAX_CHAN];
+	struct mbox_chan chans[MAILBOX_MAX_CHAN];
+	u64 __iomem *content[MAILBOX_MAX_CHAN];
+	void __iomem *mbox_base;
+	int recvid;
+};
+
+static irqreturn_t cv1800_mbox_isr(int irq, void *dev_id)
+{
+	struct cv1800_mbox *mbox = (struct cv1800_mbox *)dev_id;
+	size_t i;
+
+	for (i = 0; i < MAILBOX_MAX_CHAN; i++) {
+		if (mbox->content[i] && mbox->chans[i].cl) {
+			mbox_chan_received_data(&mbox->chans[i],
+						mbox->content[i]);
+			mbox->content[i] = NULL;
+			return IRQ_HANDLED;
+		}
+	}
+	return IRQ_NONE;
+}
+
+static irqreturn_t cv1800_mbox_irq(int irq, void *dev_id)
+{
+	struct cv1800_mbox *mbox = (struct cv1800_mbox *)dev_id;
+	u64 __iomem *addr;
+	u8 set, valid;
+	size_t i;
+
+	set = readb(mbox->mbox_base + MBOX_SET_INT_REG(RECV_CPU));
+
+	if (!set)
+		return IRQ_NONE;
+
+	for (i = 0; i < MAILBOX_MAX_CHAN; i++) {
+		valid = set & (1 << i);
+		addr = (u64 *)(mbox->mbox_base + MAILBOX_CONTEXT_OFFSET) + i;
+		if (valid) {
+			mbox->content[i] = addr;
+			writeb(valid,
+			       mbox->mbox_base + MBOX_SET_CLR_REG(RECV_CPU));
+			writeb(~valid, mbox->mbox_base + MBOX_EN_REG(RECV_CPU));
+			return IRQ_WAKE_THREAD;
+		}
+	}
+
+	return IRQ_NONE;
+}
+
+static int cv1800_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct cv1800_mbox_chan_priv *priv =
+		(struct cv1800_mbox_chan_priv *)chan->con_priv;
+	struct cv1800_mbox *mbox = dev_get_drvdata(chan->mbox->dev);
+	u64 __iomem *addr;
+	u8 en, valid;
+
+	int idx = priv->idx;
+	int cpu = priv->cpu;
+
+	addr = (u64 *)(mbox->mbox_base + MAILBOX_CONTEXT_OFFSET) + idx;
+	memcpy_toio(addr, data, 8);
+
+	valid = 1 << idx;
+	writeb(valid, mbox->mbox_base + MBOX_SET_CLR_REG(cpu));
+	en = readb(mbox->mbox_base + MBOX_EN_REG(cpu));
+	writeb(en | valid, mbox->mbox_base + MBOX_EN_REG(cpu));
+	writeb(valid, mbox->mbox_base + MBOX_SET_REG);
+
+	return 0;
+}
+
+static bool cv1800_last_tx_done(struct mbox_chan *chan)
+{
+	return true;
+}
+
+static const struct mbox_chan_ops cv1800_mbox_chan_ops = {
+	.send_data = cv1800_mbox_send_data,
+	.last_tx_done = cv1800_last_tx_done,
+};
+
+static struct mbox_chan *cv1800_mbox_xlate(struct mbox_controller *mbox,
+					   const struct of_phandle_args *spec)
+{
+	struct cv1800_mbox_chan_priv *priv;
+
+	int idx = spec->args[0];
+	int cpu = spec->args[1];
+
+	if (idx >= mbox->num_chans)
+		return ERR_PTR(-EINVAL);
+
+	priv = mbox->chans[idx].con_priv;
+	priv->cpu = cpu;
+
+	return &mbox->chans[idx];
+}
+
+static const struct of_device_id cv1800_mbox_of_match[] = {
+	{ .compatible = "sophgo,cv1800-mailbox", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cv1800_mbox_of_match);
+
+static int cv1800_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cv1800_mbox *mb;
+	int irq, idx, err;
+
+	if (!dev->of_node)
+		return -ENODEV;
+
+	mb = devm_kzalloc(dev, sizeof(*mb), GFP_KERNEL);
+	if (!mb)
+		return -ENOMEM;
+
+	mb->mbox_base = devm_of_iomap(dev, dev->of_node, 0, NULL);
+	if (IS_ERR(mb->mbox_base))
+		return dev_err_probe(dev, PTR_ERR(mb->mbox_base),
+				     "Failed to map resource\n");
+
+	mb->mbox.dev = dev;
+	mb->mbox.chans = mb->chans;
+	mb->mbox.txdone_poll = true;
+	mb->mbox.ops = &cv1800_mbox_chan_ops;
+	mb->mbox.num_chans = MAILBOX_MAX_CHAN;
+	mb->mbox.of_xlate = cv1800_mbox_xlate;
+
+	irq = platform_get_irq_byname(pdev, "mailbox");
+	err = devm_request_threaded_irq(dev, irq, cv1800_mbox_irq,
+					cv1800_mbox_isr, IRQF_ONESHOT,
+					dev_name(&pdev->dev), mb);
+	if (err < 0)
+		return dev_err_probe(dev, err, "Failed to register irq\n");
+
+	for (idx = 0; idx < MAILBOX_MAX_CHAN; idx++) {
+		mb->priv[idx].idx = idx;
+		mb->mbox.chans[idx].con_priv = &mb->priv[idx];
+	}
+
+	err = devm_mbox_controller_register(dev, &mb->mbox);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register mailbox\n");
+
+	platform_set_drvdata(pdev, mb);
+	return 0;
+}
+
+static struct platform_driver cv1800_mbox_driver = {
+	.driver = {
+		.name = "cv1800-mbox",
+		.of_match_table = cv1800_mbox_of_match,
+	},
+	.probe	= cv1800_mbox_probe,
+};
+
+module_platform_driver(cv1800_mbox_driver);
+
+MODULE_DESCRIPTION("cv1800 mailbox driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1


