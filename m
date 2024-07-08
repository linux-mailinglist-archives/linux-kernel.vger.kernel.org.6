Return-Path: <linux-kernel+bounces-244819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F7392A9E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F8F283070
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571B51CF8A;
	Mon,  8 Jul 2024 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C3qIIK/v"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E579FD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467352; cv=none; b=d5qylckSjOMjDWa0YZGfc7TjTVAaMs9fbtb6fmhjeV2Ka3ji+czYbOnbo8NsB2YI9HVZpMYKmlfcQGT24PKBFtbWfMjI+jnVRvkvuxG6FjIMmMD22yKUmbPrwZ5mmrSPGUqZJe7OjjlAoQ2y12I1tSTH391Y3idORpKo4d3FNvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467352; c=relaxed/simple;
	bh=0OBzSXiRb9v5GMOlfMYcQ/AMJWi6hFBtmioN+HVjr58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aWT5m4QYP4jnvbaQLIBubLw8qCGGrCg7PubquckbowoMLVaOQvNwV9soW0DaZig9Afe6j1Pa509HNsPxCKUHMFnwZngWKSPnd7kvN6fsGV4ZO9TvEN5BQLlq8C97uieuUCC+eQtHT+jg45emALyRftsfDtMiYIFe3ho63pzzypE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C3qIIK/v; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720467349;
	bh=0OBzSXiRb9v5GMOlfMYcQ/AMJWi6hFBtmioN+HVjr58=;
	h=From:Date:Subject:To:Cc:From;
	b=C3qIIK/vnI3mCTcPc66XWoXaZbiz+9uf2fXh1pfWwFj+9suhveLcIMm1kD+ikzZ6F
	 rJ+WtOnd6HbIO9O87WMq8ZLlUaviA0wfEIUf6CSBp3Pfknocos3ri/+mFgqoDRGIwq
	 lex/vwE0ifxWI64BFvO/TCIGzYmtA/QClvxvXazvdTUtdpEVgbS+xF7CMI0JqP0JQw
	 LKQr5IqmKeculWUaVfuSUiAltUW6C1pGRDxQoXcMfTc0lYNPhoT7icMHxFckapUdHP
	 N0mThcI4PV9RIaVPgjEn3XxAZ/SRPLJrYD1k7+IlafnVg/Z1GEiVlUe0ay+m6gKL98
	 nEKBXu8f+lXhA==
Received: from [192.168.1.242] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 497FB378042B;
	Mon,  8 Jul 2024 19:35:47 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 08 Jul 2024 15:35:42 -0400
Subject: [PATCH] nvmem: mtk-efuse: Only register socinfo device if needed
 cells are there
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240708-mtk-socinfo-no-data-probe-err-v1-1-fb2acd3a47bf@collabora.com>
X-B4-Tracking: v=1; b=H4sIAI0/jGYC/x3MQQqEMAwAwK9IzhuoVbHsV2QPtY0aZBtJRQTx7
 xaPc5kLMilThm91gdLBmSUV1J8KwuLTTMixGKyxremNw/++YpbAaRJMgtHvHjeVkZBUMfZd55q
 2icFZKMemNPH5/sPvvh+c3U9+bwAAAA==
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.0

Not every efuse region has cells storing SoC information. Only register
an socinfo device if the required cells are present.

This prevents the pointless process of creating an socinfo device,
probing it with the socinfo driver only to ultimately error out like so

  mtk-socinfo mtk-socinfo.0.auto: error -ENOENT: Failed to get socinfo data
  mtk-socinfo mtk-socinfo.0.auto: probe with driver mtk-socinfo failed with error -2

This issue is observed on the mt8183-kukui-jacuzzi-juniper-sku16
platform, which has two efuse regions, but only one of them contains the
SoC data.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/nvmem/mtk-efuse.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 9caf04667341..79300c91ced2 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -60,6 +60,8 @@ static void mtk_efuse_fixup_dt_cell_info(struct nvmem_device *nvmem,
 		cell->read_post_process = mtk_efuse_gpu_speedbin_pp;
 }
 
+static const char socinfo_data_first_name[] = "socinfo-data1";
+
 static int mtk_efuse_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -69,6 +71,7 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	struct mtk_efuse_priv *priv;
 	const struct mtk_efuse_pdata *pdata;
 	struct platform_device *socinfo;
+	struct device_node *np;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -92,10 +95,16 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
 
-	socinfo = platform_device_register_data(&pdev->dev, "mtk-socinfo",
-						PLATFORM_DEVID_AUTO, NULL, 0);
-	if (IS_ERR(socinfo))
-		dev_info(dev, "MediaTek SoC Information will be unavailable\n");
+	np = of_get_child_by_name(pdev->dev.of_node, socinfo_data_first_name);
+	if (np) {
+		of_node_put(np);
+		socinfo = platform_device_register_data(&pdev->dev, "mtk-socinfo",
+							PLATFORM_DEVID_AUTO, NULL, 0);
+		if (IS_ERR(socinfo))
+			dev_info(dev, "MediaTek SoC Information will be unavailable\n");
+	} else {
+		dev_info(dev, "Efuse region does not contain SoC information - skipping socinfo driver setup\n");
+	}
 
 	platform_set_drvdata(pdev, socinfo);
 	return 0;

---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240708-mtk-socinfo-no-data-probe-err-d7558343dc82

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


