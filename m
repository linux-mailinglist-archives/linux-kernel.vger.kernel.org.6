Return-Path: <linux-kernel+bounces-256468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAB5934EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486C31F245B0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC45413E021;
	Thu, 18 Jul 2024 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvKxonYn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EB3DDB8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721312237; cv=none; b=ZfH5UdzYyC4sHSqJ80Xhxra2zWbmApAXrDiIyXCtrEFeNCcKM/64U90gCHJ31DLMN2ZK5htCZFtuF0x/V9RTiiZN2GnocUiZOnTza9s3nI9G+ctFc/XERFuxeQi1Arz+oUevfatC6vl2eTloheScE+0qmacAcIw31Mij/7ZGJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721312237; c=relaxed/simple;
	bh=qmkoa0q0oGuCyfhSBDWWBuYmpol2ziAXepxaf+jmjtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sWe21C677xO3kTHuzoVdZCS2NrY4wNymCLd28VkafzaoHckLZ1Ps6fo+rj4BGeSlDIT00EymucEFzuRDPJygB0uKpZsRgEbfHfv4NtiX4Z2dpeytwFc2EHMuKf8G9ouoE3iTD6JV1Ge60/pIdvf4NVLIu+BqB4mIYP2em7ELRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvKxonYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4793C116B1;
	Thu, 18 Jul 2024 14:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721312236;
	bh=qmkoa0q0oGuCyfhSBDWWBuYmpol2ziAXepxaf+jmjtY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=TvKxonYnaj4ZIwx7EAavZYsO0RWwzPMZoBtSAeX5qC7eI5QFPeGeCcbski0sIJvBR
	 Lw5U4H0aciwwsSKfR7CUaq6CYB5S2MRfMnwTP3u53xEHVxlS7M0xzuGigv6777rcGk
	 5YKdMT+HSZTcMZuPGqPfgv6sD2wYyeYd5FPgGgClmahhUGYMjXBzQgbxHfNfpoYbRQ
	 hX3HTtwG15rFArWo9BGTfzxyDSes9zo7/jjdPqgu6315kw49E02quD37vUAQMp8PyH
	 ab9cxpRpZmC9RUHsDdmfKRl089oOz3+7MDX6y5jxluOXlkgS2SuVh5b9PYzIhsjMR6
	 O/VXm94YvMQfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925FDC3DA49;
	Thu, 18 Jul 2024 14:17:16 +0000 (UTC)
From: "Jason-JH.Lin via B4 Relay" <devnull+jason-jh.lin.mediatek.com@kernel.org>
Date: Thu, 18 Jul 2024 22:17:04 +0800
Subject: [PATCH v3] mailbox: mtk-cmdq: Move devm_mbox_controller_register()
 after devm_pm_runtime_enable()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-mtk-cmdq-fixup-v3-1-e3cbb75bb950@mediatek.com>
X-B4-Tracking: v=1; b=H4sIAN8jmWYC/23O3w6CIBgF8FdxXIfjj6B21Xu0LhAx0QADYzXnu
 4d20da6POfb+e1bQFBeqwCO2QK8ijpoZ1OghwzIXtirgrpNGRBEClTiCpp5hNK0d9jp52OCBaJ
 lzRlSNW9AGk1epcMOni8p9zrMzr92P+Kt/VAcU8wQJzwnjFQIYjiI4Cwc+vym7cmoVotZjbl0B
 mxOJN/tnzciSULHm4ZKxIjg6EdY1/UNa5RY+esAAAA=
To: Jassi Brar <jassisinghbrar@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>, 
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721312235; l=3031;
 i=jason-jh.lin@mediatek.com; s=20240718; h=from:subject:message-id;
 bh=OFADgvXE3QyzUSfck3fA9qrQhD5Lvasr7wyTfx6OG4A=;
 b=6FSYmXDRSQheDTXmSlRWEShpwc9Bzr17pepSJ9sUgZUmdH6S4CdDDAapAQq9YQeCzDzg91/vl
 qcs9jRp7ZPRDbuscIGzljw/fUMu+iB9GNXBvlBZCS3ZsYEPYuO6ndc8
X-Developer-Key: i=jason-jh.lin@mediatek.com; a=ed25519;
 pk=7Hn+BnFBlPrluT5ks5tKVWb3f7O/bMBs6qEemVJwqOo=
X-Endpoint-Received: by B4 Relay for jason-jh.lin@mediatek.com/20240718
 with auth_id=187
X-Original-From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Reply-To: jason-jh.lin@mediatek.com

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

When mtk-cmdq unbinds, a WARN_ON message with condition
pm_runtime_get_sync() < 0 occurs.

According to the call tracei below:
  cmdq_mbox_shutdown
  mbox_free_channel
  mbox_controller_unregister
  __devm_mbox_controller_unregister
  ...

The root cause can be deduced to be calling pm_runtime_get_sync() after
calling pm_runtime_disable() as observed below:
1. CMDQ driver uses devm_mbox_controller_register() in cmdq_probe()
   to bind the cmdq device to the mbox_controller, so
   devm_mbox_controller_unregister() will automatically unregister
   the device bound to the mailbox controller when the device-managed
   resource is removed. That means devm_mbox_controller_unregister()
   and cmdq_mbox_shoutdown() will be called after cmdq_remove().
2. CMDQ driver also uses devm_pm_runtime_enable() in cmdq_probe() after
   devm_mbox_controller_register(), so that devm_pm_runtime_disable()
   will be called after cmdq_remove(), but before
   devm_mbox_controller_unregister().

To fix this problem, cmdq_probe() needs to move
devm_mbox_controller_register() after devm_pm_runtime_enable() to make
devm_pm_runtime_disable() be called after
devm_mbox_controller_unregister().

Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
Changes in v3:
- Remove redundant message in b4 cover letter.
- Remove the change of cmdq_remove() in v1
- Link to v2: https://lore.kernel.org/r/20240718-mtk-cmdq-fixup-v2-1-f6bb3c052a60@mediatek.com

Changes in v2:
- Change to move the calling sequence of devm_mbox_controller_register()
  and devm_pm_runtime_enable().
- Link to v1: https://lore.kernel.org/r/20240613150626.25280-1-jason-jh.lin@mediatek.com
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index f1dfce9e27f5..4bff73532085 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -689,12 +689,6 @@ static int cmdq_probe(struct platform_device *pdev)
 		cmdq->mbox.chans[i].con_priv = (void *)&cmdq->thread[i];
 	}
 
-	err = devm_mbox_controller_register(dev, &cmdq->mbox);
-	if (err < 0) {
-		dev_err(dev, "failed to register mailbox: %d\n", err);
-		return err;
-	}
-
 	platform_set_drvdata(pdev, cmdq);
 
 	WARN_ON(clk_bulk_prepare(cmdq->pdata->gce_num, cmdq->clocks));
@@ -722,6 +716,12 @@ static int cmdq_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(dev, CMDQ_MBOX_AUTOSUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
+	err = devm_mbox_controller_register(dev, &cmdq->mbox);
+	if (err < 0) {
+		dev_err(dev, "failed to register mailbox: %d\n", err);
+		return err;
+	}
+
 	return 0;
 }
 

---
base-commit: 797012914d2d031430268fe512af0ccd7d8e46ef
change-id: 20240718-mtk-cmdq-fixup-40379650e96b

Best regards,
-- 
Jason-JH.Lin <jason-jh.lin@mediatek.com>



