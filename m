Return-Path: <linux-kernel+bounces-407432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2156E9C6D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0839EB250EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688071FF5F0;
	Wed, 13 Nov 2024 11:05:43 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6E11FF044
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495943; cv=none; b=WQw8z9iiwMFkseBBOaz6bkJBk+ReGVTIEPZFQpWfjm0XZkhCQkbvQdzmAPHHIZGkVnT7ATCaT+GQGAv6JdxEYa5OBGIar2ymbLXrwaKzFxqUTFsIl37zwo+sjjHL/ytCG3nngjOx6IFnyFl778qtnjKPHDY0PfNR1q9kovMHQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495943; c=relaxed/simple;
	bh=RzWcveIveQBeTHMRx6jF/KuQZnbXYfe0jkpozzCaFEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+Nmohn/7csTcWLpmXphwB3OsTdwoB2gSDElSW2oGfpLaU9a+8HB8ZSTgQzLxrDLvldL/MpDXjGbnMd/zIDLlQXUZuSBif02hQvAQReRFxPB6+fw5M0V0nw/OZNSXOgDbIxbHqHqx03xZzKXGWC3Qj7BN3kCnJeganWNMrEHuBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4ADB5Qqb009628;
	Wed, 13 Nov 2024 19:05:26 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XpL5K0yc7z2L0nH8;
	Wed, 13 Nov 2024 19:04:21 +0800 (CST)
Received: from zeshkernups01.spreadtrum.com (10.29.55.99) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 13 Nov 2024 19:05:25 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, Cixi
 Geng <cixi.geng@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>, wenhua lin
	<wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu
	<xiongpeng.wu@unisoc.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>,
        Zhirong Qiu
	<Zhirong.Qiu@unisoc.com>
Subject: [PATCH 1/2] serial: sprd: Add support for sc9632
Date: Wed, 13 Nov 2024 19:05:15 +0800
Message-ID: <20241113110516.2166328-2-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113110516.2166328-1-Wenhua.Lin@unisoc.com>
References: <20241113110516.2166328-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 4ADB5Qqb009628

Due to the platform's new project uart ip upgrade,
the new project's timeout interrupt needs to use bit17
while other projects' timeout interrupt needs to use
bit13, using private data to adapt and be compatible
with all projects.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/tty/serial/sprd_serial.c | 41 ++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 3fc54cc02a1f..882580c3cf37 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -53,10 +53,12 @@
 #define SPRD_IEN_TX_EMPTY	BIT(1)
 #define SPRD_IEN_BREAK_DETECT	BIT(7)
 #define SPRD_IEN_TIMEOUT	BIT(13)
+#define SPRD_IEN_DATA_TIMEOUT	BIT(17)
 
 /* interrupt clear register */
 #define SPRD_ICLR		0x0014
 #define SPRD_ICLR_TIMEOUT	BIT(13)
+#define SPRD_ICLR_DATA_TIMEOUT	BIT(17)
 
 /* line control register */
 #define SPRD_LCR		0x0018
@@ -102,6 +104,7 @@
 #define SPRD_IMSR_TX_FIFO_EMPTY	BIT(1)
 #define SPRD_IMSR_BREAK_DETECT	BIT(7)
 #define SPRD_IMSR_TIMEOUT	BIT(13)
+#define SPRD_IMSR_DATA_TIMEOUT	BIT(17)
 #define SPRD_DEFAULT_SOURCE_CLK	26000000
 
 #define SPRD_RX_DMA_STEP	1
@@ -118,6 +121,12 @@ struct sprd_uart_dma {
 	bool enable;
 };
 
+struct sprd_uart_data {
+	unsigned int timeout_ien;
+	unsigned int timeout_iclr;
+	unsigned int timeout_imsr;
+};
+
 struct sprd_uart_port {
 	struct uart_port port;
 	char name[16];
@@ -126,6 +135,7 @@ struct sprd_uart_port {
 	struct sprd_uart_dma rx_dma;
 	dma_addr_t pos;
 	unsigned char *rx_buf_tail;
+	const struct sprd_uart_data *pdata;
 };
 
 static struct sprd_uart_port *sprd_port[UART_NR_MAX];
@@ -134,6 +144,18 @@ static int sprd_ports_num;
 static int sprd_start_dma_rx(struct uart_port *port);
 static int sprd_tx_dma_config(struct uart_port *port);
 
+static const struct sprd_uart_data sc9836_data = {
+	.timeout_ien = SPRD_IEN_TIMEOUT,
+	.timeout_iclr = SPRD_ICLR_TIMEOUT,
+	.timeout_imsr = SPRD_IMSR_TIMEOUT,
+};
+
+static const struct sprd_uart_data sc9632_data = {
+	.timeout_ien = SPRD_IEN_DATA_TIMEOUT,
+	.timeout_iclr = SPRD_ICLR_DATA_TIMEOUT,
+	.timeout_imsr = SPRD_IMSR_DATA_TIMEOUT,
+};
+
 static inline unsigned int serial_in(struct uart_port *port,
 				     unsigned int offset)
 {
@@ -637,6 +659,8 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
 	unsigned int ims;
+	struct sprd_uart_port *sp =
+		container_of(port, struct sprd_uart_port, port);
 
 	uart_port_lock(port);
 
@@ -647,14 +671,14 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	if (ims & SPRD_IMSR_TIMEOUT)
-		serial_out(port, SPRD_ICLR, SPRD_ICLR_TIMEOUT);
+	if (ims & sp->pdata->timeout_imsr)
+		serial_out(port, SPRD_ICLR, sp->pdata->timeout_iclr);
 
 	if (ims & SPRD_IMSR_BREAK_DETECT)
 		serial_out(port, SPRD_ICLR, SPRD_IMSR_BREAK_DETECT);
 
 	if (ims & (SPRD_IMSR_RX_FIFO_FULL | SPRD_IMSR_BREAK_DETECT |
-		   SPRD_IMSR_TIMEOUT))
+		   sp->pdata->timeout_imsr))
 		sprd_rx(port);
 
 	if (ims & SPRD_IMSR_TX_FIFO_EMPTY)
@@ -729,7 +753,7 @@ static int sprd_startup(struct uart_port *port)
 	/* enable interrupt */
 	uart_port_lock_irqsave(port, &flags);
 	ien = serial_in(port, SPRD_IEN);
-	ien |= SPRD_IEN_BREAK_DETECT | SPRD_IEN_TIMEOUT;
+	ien |= SPRD_IEN_BREAK_DETECT | sp->pdata->timeout_ien;
 	if (!sp->rx_dma.enable)
 		ien |= SPRD_IEN_RX_FULL;
 	serial_out(port, SPRD_IEN, ien);
@@ -1184,6 +1208,12 @@ static int sprd_probe(struct platform_device *pdev)
 
 	up->mapbase = res->start;
 
+	sport->pdata = of_device_get_match_data(&pdev->dev);
+	if (!sport->pdata) {
+		dev_err(&pdev->dev, "get match data failed!\n");
+		return -EINVAL;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -1248,7 +1278,8 @@ static int sprd_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(sprd_pm_ops, sprd_suspend, sprd_resume);
 
 static const struct of_device_id serial_ids[] = {
-	{.compatible = "sprd,sc9836-uart",},
+	{.compatible = "sprd,sc9836-uart", .data = &sc9836_data},
+	{.compatible = "sprd,sc9632-uart", .data = &sc9632_data},
 	{}
 };
 MODULE_DEVICE_TABLE(of, serial_ids);
-- 
2.34.1


