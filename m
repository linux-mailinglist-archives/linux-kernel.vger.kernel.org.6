Return-Path: <linux-kernel+bounces-219728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DA790D6FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411ED1C24A53
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6865F15886D;
	Tue, 18 Jun 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ZqfGSJUW"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2170.outbound.protection.outlook.com [40.92.62.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41976158858;
	Tue, 18 Jun 2024 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723600; cv=fail; b=uJaK4E2cJQd4YT2Jk4gqsZxD8KOk5lUhrite2Bgg6bppEoOXRs3DFXJyaVUKmrZ0vPz43Zptd5eJZfeNl7WWR0ls6ZaU8A6GttbA5w/2BsY3WHP4dVFfj2cYZfTng1xgRDzuDz55mtQofO51XzOvsINsraAtQnMC7zdHvwi/TRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723600; c=relaxed/simple;
	bh=jGcRsH+RuJNSMVuAv61pPI4aXoqvjbsVGQFeKhQZIDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=El4MzRGTOrtTDSS7ABt4oEtpiItJeUaVcHNe+08futNp/aUBc8qPyvuRCtYPbOkHsoG7wZ2N+mtJjqsz9dlViUnqDerZFhQek8sp41tnoQbw+86ET2YtO7kNX62yoSILUHiNC5laJXgxFoCfp3n+iAiKUMVVgYU1E0P9GubDOP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ZqfGSJUW; arc=fail smtp.client-ip=40.92.62.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEImUuKuPnQyBSr4eshPHl3KgZi9RoD+xvtVzy37JGp/4f6KuBrTqh3g8KTe9putiOCwMeowlKCP26qqHpV3BBWXRkxjWBc8LUR7MDo0liOeXwpPSjMkbSwz5pqWVd2u7ToZg3fXz5kLVH+y26G2PQbMGmC1pqW+yKBvXgVG68Cg2r+u7CPe0AFTrd7o2deVpXUsIg9JNkuIu3cQSpUze3QKjhhzaKmWQ3Pnjf7bKFBuWm8/1Bue8ouflyzkH03wILzVZH6zxBIi0xbWKLsa0OYQ3wMeI4UlYtan+hfgrG8N/f+90zIje4uuuHUw/912H54OpEFX4vb8gbtzlXjYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qRcENVB/ZWHZrlfBjkPdKJM0m6jFaudlENWzYlhVYE=;
 b=BuOOwacWvHY6ftIhevwZW3gNltQ+GWQ8EdcXOtJAFe7IOq/z0jTcZoAYPtLzJPKczvmNbn8vouu3fwGx4XxaqwCyW2Cp+q5O1YiqRxDigpszvhDUlXUM2VjG/J/R9jEOnd/cOYDKQ/rxSLNWA4RCGCmNuumb+zzsoDkf4nMfEx5Z0tSn1kewMrmqmLml6XXzEzu9DiVEFGnXR4MdDDf76sANtzGjDxH7UblS4AKMfIJ8dJillTA6XaSTjQMvvN78gditOhjte1vckuM+pcLrpgoA8I3ZE5FhBGpLW78rGgTaoiavCwY7X6jA3UNdUaLMoVaUAlH5HSgyxTsnqT+eNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qRcENVB/ZWHZrlfBjkPdKJM0m6jFaudlENWzYlhVYE=;
 b=ZqfGSJUWEdJ33StzHNBEu4wRajFAd3I5S045bWBI1mqBPsxPpmxAowYMvshxsRly0kMmAc1BRpZ5wiZqTxrM4iJ8N1QS3BDKDBFHJTD6c9ufxhOgtStSE0+Newy7HZULQMj8U+MwnaQ6Pc+UvJchtu6PM/qByXhTjT5vQ2+sWXv+/ot9F5kR2bN9c9J5gwvFjiftG5T/FR/zKHpDlcULWptYCQfs0uTVagEIc9jZ0kkDFRCKtrYBKkfRdbwfuLlgB8dfHrjMUVW3FRRKr5J/619vQINpADd3J7AuO1Iua/ziamcaGSC9uOFlC0NOewpM+PsfX2D+AOGEcRIIrZf8nw==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 SY7P282MB5268.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2a9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Tue, 18 Jun 2024 15:13:12 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%2]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 15:13:12 +0000
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
Subject: [PATCH 3/3] mailbox: sophgo: add mailbox driver for cv18x SoCs
Date: Tue, 18 Jun 2024 23:12:35 +0800
Message-ID:
 <SYBP282MB2238F93AB57A398E322644C3C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
References: <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-TMN: [X1/wqH4EahMq5oJ1l9UEVIWlavA4Z7ET]
X-ClientProxiedBy: TYCP286CA0266.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::19) To SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:9b::8)
X-Microsoft-Original-Message-ID: <20240618151235.5846-3-d1581209858@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2238:EE_|SY7P282MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d82d4f6-bea4-4faa-8132-08dc8fa92b51
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|440099025|1710799023;
X-Microsoft-Antispam-Message-Info:
	3lhjfyFgihBlperWGsdED3yguNsI0jDv7BzTn7tHMct7UqaKXbPU/yq0ljG2QejYv1MI3mykyYt1mGJ7bNWAsqfGy8GoBFKjokbQNz+CXNlSN3xEDCk/872H1e9BSXN7hfFc+u2LkSBgab8l4Zd+8YVq7EyOiwqVcrNN3cd0wTwNCrnMz2z8jS5edtMFsTl4yOAORQzUnDmgVMNrZxmuH709W9HreqBkim11e2b57mBFdMLSwR0ngwkJYQ596SSALEqUD/aN2rrqG8OboNnwaaH7BYRdsJkgmQ8L5ySelhpTh/qyKH/uUZ5GGiSY3gkp24fFVXmQlyUPi+Z+JyYHDDZ2Bz8EMv/W96m2wAWkrnw87IWKm7ZCmeKzXmKNQv/+hWizfDIlQ6TN3B5aAaeYUKTkY2ceOZGjGYrkSeqp4Z6/Imysq0LCxMRfeURf884/RmOntX4dQSRo+iBX2/gVUM79uHuwTM/MueDfbXjLbhcuuuFzN0CgKO6NtijRUZqAQT0nTeboD9oZDQiAA0asdXRDPPeivFMdQ06rqwRWj4rB6Xd4Cm45t6M4izwvHPawRUdUKpRLxpAFM2XXVqRdri066jItaMsdZuCPzuCRgS6U1aVl0U7pu7q8jv2s8QiM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HAzbi7G5kX/wrWfjZZUv0yLl8tmJbI+oJMdje336gIQBy7PLPB4TAwBKIoQ5?=
 =?us-ascii?Q?4hnMsmvHGanDd5mvtpVp8py6N8/wTCnrYQP1sEPJELxY61SUDLmtMGEZ8r0p?=
 =?us-ascii?Q?zZO4tGUKFjygcWXU/C6MpvClrfeLZb+vIfwOeHI8kdkjMAD7aBWS43txcgJ9?=
 =?us-ascii?Q?4TAWkNm4Ne9bAgvZ9idYcALrefQTJVFqtPORmPaagz2/IseZuC769Mvd8w4z?=
 =?us-ascii?Q?eaHy96DryokwQdY+JZJ4Ay/VOOstNoZUPyP8beI5TcZex70FRhqWjpVhovIC?=
 =?us-ascii?Q?q2pJ+0EyCKMvoT4ae9OkKwIna4J/v5+WxcdSc8r3Eztvh17lMCukW/vJpCrK?=
 =?us-ascii?Q?Pvb/Y6L50QQxy1vIGb2xZwKOxxpLBi7n4IRzAKdkN3cRg1tJWM4nEhRrNnYn?=
 =?us-ascii?Q?lUuz4usnHB2QhoBRhZAtyvFsY05+e9s1OW2uRwdt9MrgbpT92uZ7RCmlt3cb?=
 =?us-ascii?Q?gEmt1ATTfE3bYq1kGb6TG+NPSYBmxcCWezHMJQabqvgGG/g5YkWL4LZc78G4?=
 =?us-ascii?Q?QZMYXO0nGKg4ft6ZdtoQ1FDYjD9JS+fMJMhzlDrwc9WYYkDBKoiePFwBElE9?=
 =?us-ascii?Q?S5EZXScJvXerbfubYuGw9GlfXS1ZTEUVFghdXyrj6+8SuAGhn1dYZNOCGgKN?=
 =?us-ascii?Q?T9UwyTER2FgZWBDx2zFNoBXHMX1a5vv+N94/OA6ZWylY/i9juJREaiYzghD8?=
 =?us-ascii?Q?8X/icKgbHOwcWgwAKoAn5gXPQrdrk0Cm170Z/MuQBmd6ShANF09gW27OGq1t?=
 =?us-ascii?Q?KnJOgscVYm9DbGBIrcc06Z/Y1LRMvMxN7TARvup2AvsgREVHRMDwFvuTrgqD?=
 =?us-ascii?Q?96JDMcjPvU1PxmuRxcTdbIhAkVTX+8MGdddHNknr2tBwpEj3nLm7FgqAVYSm?=
 =?us-ascii?Q?DFFKnKaLuJpHZ5V0pdMiC/zsv/y5ZB4/Euc8N0L9AKhNQEqvTkU9oororlNL?=
 =?us-ascii?Q?sDMGanq5MaBhHiGBeeSTZ9CcR/yqZ0vXs3XyJ2cH5xD+7Kaa9E/AZX/JZIpk?=
 =?us-ascii?Q?UVNy2B5g0136NqAM0+UtjCu+NuL3lRjXvErrRPnjnxf+W02SlWd10GI5vmoT?=
 =?us-ascii?Q?oHNOK2y93uyqVTt4Z9gnN+hwUOTOQoCmovyromy5aEzDza/r9p8PygQDMGyo?=
 =?us-ascii?Q?SqftzsASCWzn/qKWlFa9Onr48Ql1JtO+/5mnPpnmZQurXAE13ONs33CMifqI?=
 =?us-ascii?Q?Jll3T8gNNmDpIGcL9eH4Pi4IOPzDSK+Wx2L/f+gAG5VnFufylSN98E2KPOU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d82d4f6-bea4-4faa-8132-08dc8fa92b51
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:13:12.1864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB5268

Add mailbox controller driver for cv18x SoCs, tested on mailbox-test
client.

Signed-off-by: Yuntao Dai <d1581209858@live.com>
---
 drivers/mailbox/Kconfig           |  11 ++
 drivers/mailbox/Makefile          |   2 +
 drivers/mailbox/cv1800b-mailbox.c | 181 ++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)
 create mode 100644 drivers/mailbox/cv1800b-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 3b8842c4a..4e5593861 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -286,4 +286,15 @@ config QCOM_IPCC
 	  acts as an interrupt controller for receiving interrupts from clients.
 	  Say Y here if you want to build this driver.
 
+config CV1800B_MBOX
+	tristate "cv1800b mailbox"
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
index 5cf2f54de..71f0f746e 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -62,3 +62,5 @@ obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
 obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
 
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
+
+obj-$(CONFIG_CV1800B_MBOX)	+= cv1800b-mailbox.o
\ No newline at end of file
diff --git a/drivers/mailbox/cv1800b-mailbox.c b/drivers/mailbox/cv1800b-mailbox.c
new file mode 100644
index 000000000..8ef2a5492
--- /dev/null
+++ b/drivers/mailbox/cv1800b-mailbox.c
@@ -0,0 +1,181 @@
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
+struct cv1800b_mbox {
+	struct mbox_controller mbox;
+	struct mbox_chan chans[MAILBOX_MAX_CHAN];
+	u64 *content[MAILBOX_MAX_CHAN];
+	void __iomem *mbox_base;
+	int sendto;
+	int recvid;
+};
+
+static irqreturn_t cv1800b_mbox_isr(int irq, void *dev_id)
+{
+	struct cv1800b_mbox *mbox = (struct cv1800b_mbox *)dev_id;
+	size_t i;
+
+	for (i = 0; i < MAILBOX_MAX_CHAN; i++) {
+		if (mbox->content[i]) {
+			mbox_chan_received_data(&mbox->chans[i],
+						mbox->content[i]);
+			mbox->content[i] = NULL;
+			return IRQ_HANDLED;
+		}
+	}
+	return IRQ_NONE;
+}
+
+static irqreturn_t cv1800b_mbox_irq(int irq, void *dev_id)
+{
+	struct cv1800b_mbox *mbox = (struct cv1800b_mbox *)dev_id;
+	u8 set, valid;
+	u64 *addr;
+	size_t i;
+
+	set = readb(mbox->mbox_base + MBOX_SET_INT_REG(mbox->recvid));
+
+	if (!set)
+		return IRQ_NONE;
+
+	for (i = 0; i < MAILBOX_MAX_CHAN; i++) {
+		valid = set & (1 << i);
+		addr = (u64 *)(mbox->mbox_base + MAILBOX_CONTEXT_OFFSET) + i;
+		if (valid) {
+			mbox->content[i] = addr;
+			writeb(valid, mbox->mbox_base +
+					      MBOX_SET_CLR_REG(mbox->recvid));
+			writeb(~valid,
+			       mbox->mbox_base + MBOX_EN_REG(mbox->recvid));
+			return IRQ_WAKE_THREAD;
+		}
+	}
+
+	return IRQ_NONE;
+}
+
+static int cv1800b_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct cv1800b_mbox *mbox = dev_get_drvdata(chan->mbox->dev);
+	int idx = (int)chan->con_priv;
+	u8 en, valid;
+	u64 *addr = (u64 *)(mbox->mbox_base + MAILBOX_CONTEXT_OFFSET) + idx;
+
+	memcpy_toio(addr, data, 8);
+
+	valid = 1 << idx;
+	writeb(valid, mbox->mbox_base + MBOX_SET_CLR_REG(mbox->sendto));
+	en = readb(mbox->mbox_base + MBOX_EN_REG(mbox->sendto));
+	writeb(en | valid, mbox->mbox_base + MBOX_EN_REG(mbox->sendto));
+	writeb(valid, mbox->mbox_base + MBOX_SET_REG);
+
+	return 0;
+}
+
+static bool cv1800b_last_tx_done(struct mbox_chan *chan)
+{
+	return true;
+}
+
+static const struct mbox_chan_ops cv1800b_mbox_chan_ops = {
+	.send_data = cv1800b_mbox_send_data,
+	.last_tx_done = cv1800b_last_tx_done,
+};
+
+static const struct of_device_id cv1800b_mbox_of_match[] = {
+	{ .compatible = "sophgo,cv1800b-mailbox", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cv1800b_mbox_of_match);
+
+static int cv1800b_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cv1800b_mbox *mb;
+	int irq, idx, err, cpu;
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
+	err = of_property_read_s32(dev->of_node, "sendto", &cpu);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "Failed to find <sendto> in of_node\n");
+
+	mb->sendto = cpu;
+
+	err = of_property_read_s32(dev->of_node, "recvid", &cpu);
+	if (err) {
+		return dev_err_probe(dev, err,
+				     "Failed to find <recvid> in of_node\n");
+	}
+	mb->recvid = cpu;
+
+	mb->mbox.dev = dev;
+	mb->mbox.num_chans = MAILBOX_MAX_CHAN;
+	mb->mbox.chans = mb->chans;
+	mb->mbox.ops = &cv1800b_mbox_chan_ops;
+	mb->mbox.txdone_poll = true;
+
+	irq = platform_get_irq_byname(pdev, "mailbox");
+	err = devm_request_threaded_irq(dev, irq, cv1800b_mbox_irq,
+					cv1800b_mbox_isr, IRQF_ONESHOT,
+					dev_name(&pdev->dev), mb);
+	if (err < 0)
+		return dev_err_probe(dev, err, "Failed to register irq\n");
+
+	for (idx = 0; idx < MAILBOX_MAX_CHAN; idx++)
+		mb->mbox.chans[idx].con_priv = (void *)idx;
+
+	err = devm_mbox_controller_register(dev, &mb->mbox);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register mailbox\n");
+
+	platform_set_drvdata(pdev, mb);
+	return 0;
+}
+
+static struct platform_driver cv1800b_mbox_driver = {
+	.driver = {
+		.name = "cv1800b-mbox",
+		.of_match_table = cv1800b_mbox_of_match,
+	},
+	.probe	= cv1800b_mbox_probe,
+};
+
+module_platform_driver(cv1800b_mbox_driver);
+
+MODULE_DESCRIPTION("cv1800b mailbox driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1


