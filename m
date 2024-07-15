Return-Path: <linux-kernel+bounces-252227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D82931052
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8F11C217F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4FA18D4D7;
	Mon, 15 Jul 2024 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s22hW03L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF4C186294;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032804; cv=none; b=bve1daT34BX1cHxQQUzPQRQeAZ9kV5+Nc9MsnGbxnKDjmuXnUeBEOXKT1KoSwFbaZMmUIXrPuFCKwPNYyEsc0dYNSftTWi/QP3OCx+PI6MKCWs7R3CXXl81jSqgF8O1pBIA2iInjKKAHjcvEZZGXx5n8MoRd+f8fYwOSl4LxpUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032804; c=relaxed/simple;
	bh=TWeaRg+noW1lFeYfIFR9lOmT7O43s2anpkkQpN+Euww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pLDFJqA8FVDNrZHIrMgyabnxWWOjjevlDfwuWwYLsHd9RL87KyViDa4T0Dsxpu4UByEYnnny2e6Llo1hcujbU946U39XD9UfysneXWOmcnWOTrE79P8D0EyldopZ76sGEBMzf1+tMGobmrZu/ELxU5ZdKp6WElM/B4TKad8KfEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s22hW03L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24E79C4AF53;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721032804;
	bh=TWeaRg+noW1lFeYfIFR9lOmT7O43s2anpkkQpN+Euww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s22hW03LA5rt+OpBs74lIft0qjQ2CFpi4Ct9u3OEUlzHVNSzK57Fcj5vo1qtEgDJv
	 0Xp7nLnZ/d/gmU+nC9v7kE1+H6TKvIsHYRTJgzJm5+lVkmVr+pDFsnou8Q9AGbBN5J
	 En/FkC0G4Y/TAXwV2UMz1l2F2XOx5yYSWcxoYI2TqB7blk4PUOcMrmR6bwmr47zojU
	 Htxbwr1p/wZLkLeY2pqS3DivL/EB4qH3JlxRpEdrKbRdHJ50vGMg5hOKXe/a+UKlt9
	 jZP5l1ocPWPEhKB8Wc1nKdq90CYq6p6eK7Yq4EqQGvmOPGN7Te6NSzC2p9MEq9mITv
	 j/syKkYXedkMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EA1C2BD09;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 15 Jul 2024 11:38:25 +0300
Subject: [PATCH v11 21/38] ata: pata_ep93xx: add device tree support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-ep93xx-v11-21-4e924efda795@maquefel.me>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
In-Reply-To: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
To: Sergey Shtylyov <s.shtylyov@omp.ru>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721032799; l=5839;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=NFhw+S6yqjvbTLxtqXwJdogYQOJyOLBy6lAMN4VNI8U=;
 b=2EQ0f3QKhxGo97IgvcsXmqAXJkq7IOjN5v5aGvnhuXjcePbFqhvnvwXGdcqKtkGyrSSNvgkc/A8V
 nnjVi5wFDnc4NERJJGJkoyXbdtNZ/ZOF2S2GSoloIK3pYL8E/UBL
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

- add OF ID match table
- drop platform DMA and filters
- change DMA setup to OF, so we can defer probe

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_ep93xx.c | 80 +++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index c84a20892f1b..13246a92e29f 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -44,8 +44,8 @@
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/ktime.h>
+#include <linux/mod_devicetable.h>
 
-#include <linux/platform_data/dma-ep93xx.h>
 #include <linux/soc/cirrus/ep93xx.h>
 
 #define DRV_NAME	"ep93xx-ide"
@@ -126,7 +126,7 @@ enum {
 };
 
 struct ep93xx_pata_data {
-	const struct platform_device *pdev;
+	struct platform_device *pdev;
 	void __iomem *ide_base;
 	struct ata_timing t;
 	bool iordy;
@@ -135,9 +135,7 @@ struct ep93xx_pata_data {
 	unsigned long udma_out_phys;
 
 	struct dma_chan *dma_rx_channel;
-	struct ep93xx_dma_data dma_rx_data;
 	struct dma_chan *dma_tx_channel;
-	struct ep93xx_dma_data dma_tx_data;
 };
 
 static void ep93xx_pata_clear_regs(void __iomem *base)
@@ -637,20 +635,13 @@ static void ep93xx_pata_release_dma(struct ep93xx_pata_data *drv_data)
 	}
 }
 
-static bool ep93xx_pata_dma_filter(struct dma_chan *chan, void *filter_param)
+static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 {
-	if (ep93xx_dma_chan_is_m2p(chan))
-		return false;
-
-	chan->private = filter_param;
-	return true;
-}
-
-static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
-{
-	const struct platform_device *pdev = drv_data->pdev;
+	struct platform_device *pdev = drv_data->pdev;
+	struct device *dev = &pdev->dev;
 	dma_cap_mask_t mask;
 	struct dma_slave_config conf;
+	int ret;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
@@ -660,22 +651,16 @@ static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	 * to request only one channel, and reprogram it's direction at
 	 * start of new transfer.
 	 */
-	drv_data->dma_rx_data.port = EP93XX_DMA_IDE;
-	drv_data->dma_rx_data.direction = DMA_DEV_TO_MEM;
-	drv_data->dma_rx_data.name = "ep93xx-pata-rx";
-	drv_data->dma_rx_channel = dma_request_channel(mask,
-		ep93xx_pata_dma_filter, &drv_data->dma_rx_data);
-	if (!drv_data->dma_rx_channel)
-		return;
+	drv_data->dma_rx_channel = dma_request_chan(dev, "rx");
+	if (IS_ERR(drv_data->dma_rx_channel))
+		return dev_err_probe(dev, PTR_ERR(drv_data->dma_rx_channel),
+				     "rx DMA setup failed\n");
 
-	drv_data->dma_tx_data.port = EP93XX_DMA_IDE;
-	drv_data->dma_tx_data.direction = DMA_MEM_TO_DEV;
-	drv_data->dma_tx_data.name = "ep93xx-pata-tx";
-	drv_data->dma_tx_channel = dma_request_channel(mask,
-		ep93xx_pata_dma_filter, &drv_data->dma_tx_data);
-	if (!drv_data->dma_tx_channel) {
-		dma_release_channel(drv_data->dma_rx_channel);
-		return;
+	drv_data->dma_tx_channel = dma_request_chan(&pdev->dev, "tx");
+	if (IS_ERR(drv_data->dma_tx_channel)) {
+		ret = dev_err_probe(dev, PTR_ERR(drv_data->dma_tx_channel),
+				    "tx DMA setup failed\n");
+		goto fail_release_rx;
 	}
 
 	/* Configure receive channel direction and source address */
@@ -683,10 +668,10 @@ static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	conf.direction = DMA_DEV_TO_MEM;
 	conf.src_addr = drv_data->udma_in_phys;
 	conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	if (dmaengine_slave_config(drv_data->dma_rx_channel, &conf)) {
-		dev_err(&pdev->dev, "failed to configure rx dma channel\n");
-		ep93xx_pata_release_dma(drv_data);
-		return;
+	ret = dmaengine_slave_config(drv_data->dma_rx_channel, &conf);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to configure rx dma channel");
+		goto fail_release_dma;
 	}
 
 	/* Configure transmit channel direction and destination address */
@@ -694,10 +679,20 @@ static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	conf.direction = DMA_MEM_TO_DEV;
 	conf.dst_addr = drv_data->udma_out_phys;
 	conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	if (dmaengine_slave_config(drv_data->dma_tx_channel, &conf)) {
-		dev_err(&pdev->dev, "failed to configure tx dma channel\n");
-		ep93xx_pata_release_dma(drv_data);
+	ret = dmaengine_slave_config(drv_data->dma_tx_channel, &conf);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to configure tx dma channel");
+		goto fail_release_dma;
 	}
+
+	return 0;
+
+fail_release_rx:
+	dma_release_channel(drv_data->dma_rx_channel);
+fail_release_dma:
+	ep93xx_pata_release_dma(drv_data);
+
+	return ret;
 }
 
 static void ep93xx_pata_dma_start(struct ata_queued_cmd *qc)
@@ -954,7 +949,9 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 	drv_data->ide_base = ide_base;
 	drv_data->udma_in_phys = mem_res->start + IDEUDMADATAIN;
 	drv_data->udma_out_phys = mem_res->start + IDEUDMADATAOUT;
-	ep93xx_pata_dma_init(drv_data);
+	err = ep93xx_pata_dma_init(drv_data);
+	if (err)
+		return err;
 
 	/* allocate host */
 	host = ata_host_alloc(&pdev->dev, 1);
@@ -1021,9 +1018,16 @@ static void ep93xx_pata_remove(struct platform_device *pdev)
 	ep93xx_ide_release_gpio(pdev);
 }
 
+static const struct of_device_id ep93xx_pata_of_ids[] = {
+	{ .compatible = "cirrus,ep9312-pata" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ep93xx_pata_of_ids);
+
 static struct platform_driver ep93xx_pata_platform_driver = {
 	.driver = {
 		.name = DRV_NAME,
+		.of_match_table = ep93xx_pata_of_ids,
 	},
 	.probe = ep93xx_pata_probe,
 	.remove_new = ep93xx_pata_remove,

-- 
2.43.2



