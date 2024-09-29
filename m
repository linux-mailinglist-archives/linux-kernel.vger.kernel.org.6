Return-Path: <linux-kernel+bounces-343106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FEB9896D2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A911F2816D5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 18:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8AF6F073;
	Sun, 29 Sep 2024 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ubHk2b61"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318675674E
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727635793; cv=none; b=GA7n+35xr2EBBsIifq2fi5cKjUGnshaXUvQi14YTriP35/d2gTucfQRgug2jS84HYWC6buFnFOXQkWIaM3o42FRonB2bPUSTFGUIHNwUHoQx+TQrO3wTkhbSoVEi3Y5k7K6KtqXbL2rX5/jq/moykO8nCRmY3dLmiSUJ5feukdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727635793; c=relaxed/simple;
	bh=B7/KaFQq2GGfCeeZMHfwfdxhGMr7ff35trV4LdggHCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghaS4LIuLXTnZozSyveK9gRc0jyT3pv2y4CB5eGGdwQ1mwBLashAYKOuP3Ke7lhTjNJBrYW9xVsuDouejUejNqgAIYK6qSixVjBQ1V/qqsyTvsRGpphs9grCxBw2sUt7WMd+nEinfS+B8ZkOBRFK/IoGggZA+6KduLvCFbwEnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ubHk2b61; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3F9F188D3C;
	Sun, 29 Sep 2024 20:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727635789;
	bh=225SC1QrwOQ+gLLPOL+9stIQHBSkjHANJcaIx4swrK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubHk2b61JJ814nIk+PlY85LkQ76cMVbqDt5F9WKNNbmCIIEnjN07T4xGVgh9L1axb
	 hHyXCjhdiuJ8OgumotvXH3ljhA9eAN8q5/FZ72f7StY6ZVC8RAO1on6lvMSQPCtPeA
	 osakBcNjJajCajzJuUaX2thUCs0rGlq1QjgKKqD3uk7efCnUs2xcsGxCRFswmGhJPP
	 BWjjo/tf4eF1JRsmTK64ijc23ees9AfJQr6PytQ/uu+oomZnU8qKbKCFYo2HjJ/T/c
	 mW86VgU8h4Hi4c2+R9m2mYLy4ZFr1le19U7iienRdAGlhooXXqeHoYOlQ7sKGuCXKK
	 rNsdiiheFp/mg==
From: Marek Vasut <marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@dh-electronics.com,
	Marek Vasut <marex@denx.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Saravana Kannan <saravanak@google.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] soc: imx8m: Use devm_* to simplify probe failure handling
Date: Sun, 29 Sep 2024 20:49:18 +0200
Message-ID: <20240929184930.73049-3-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240929184930.73049-1-marex@denx.de>
References: <20240929184930.73049-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Use device managed functions to simplify handling of failures during
probe. Remove fail paths which are no longer necessary.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
V4: New patch
---
 drivers/soc/imx/soc-imx8m.c | 92 ++++++++++++-------------------------
 1 file changed, 29 insertions(+), 63 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 966593320e28d..8ac7658e3d525 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -51,22 +51,20 @@ static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
 
 static int imx8mq_soc_revision(u32 *socrev, u64 *socuid)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
 	void __iomem *ocotp_base;
 	u32 magic;
 	u32 rev;
 	struct clk *clk;
 	int ret;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
 	if (!np)
 		return -EINVAL;
 
 	ocotp_base = of_iomap(np, 0);
-	if (!ocotp_base) {
-		ret = -EINVAL;
-		goto err_iomap;
-	}
+	if (!ocotp_base)
+		return -EINVAL;
 
 	clk = of_clk_get_by_name(np, NULL);
 	if (IS_ERR(clk)) {
@@ -96,35 +94,30 @@ static int imx8mq_soc_revision(u32 *socrev, u64 *socuid)
 	clk_disable_unprepare(clk);
 	clk_put(clk);
 	iounmap(ocotp_base);
-	of_node_put(np);
 
 	return 0;
 
 err_clk:
 	iounmap(ocotp_base);
-err_iomap:
-	of_node_put(np);
 	return ret;
 }
 
 static int imx8mm_soc_uid(u64 *socuid)
 {
+	struct device_node *np __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
 	void __iomem *ocotp_base;
-	struct device_node *np;
 	struct clk *clk;
 	int ret = 0;
 	u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
 		     IMX8MP_OCOTP_UID_OFFSET : 0;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
 	if (!np)
 		return -EINVAL;
 
 	ocotp_base = of_iomap(np, 0);
-	if (!ocotp_base) {
-		ret = -EINVAL;
-		goto err_iomap;
-	}
+	if (!ocotp_base)
+		return -EINVAL;
 
 	clk = of_clk_get_by_name(np, NULL);
 	if (IS_ERR(clk)) {
@@ -143,38 +136,27 @@ static int imx8mm_soc_uid(u64 *socuid)
 
 err_clk:
 	iounmap(ocotp_base);
-err_iomap:
-	of_node_put(np);
-
 	return ret;
 }
 
 static int imx8mm_soc_revision(u32 *socrev, u64 *socuid)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
 	void __iomem *anatop_base;
-	int ret;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
 	if (!np)
 		return -EINVAL;
 
 	anatop_base = of_iomap(np, 0);
-	if (!anatop_base) {
-		ret = -EINVAL;
-		goto err_iomap;
-	}
+	if (!anatop_base)
+		return -EINVAL;
 
 	*socrev = readl_relaxed(anatop_base + ANADIG_DIGPROG_IMX8MM);
 
 	iounmap(anatop_base);
-	of_node_put(np);
 
 	return imx8mm_soc_uid(socuid);
-
-err_iomap:
-	of_node_put(np);
-	return ret;
 }
 
 static const struct imx8_soc_data imx8mq_soc_data = {
@@ -205,22 +187,23 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 	{ }
 };
 
-#define imx8_revision(soc_rev) \
-	soc_rev ? \
-	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
+#define imx8_revision(dev, soc_rev) \
+	(soc_rev) ? \
+	devm_kasprintf((dev), GFP_KERNEL, "%d.%d", ((soc_rev) >> 4) & 0xf, (soc_rev) & 0xf) : \
 	"unknown"
 
 static int imx8m_soc_probe(struct platform_device *pdev)
 {
 	struct soc_device_attribute *soc_dev_attr;
 	const struct imx8_soc_data *data;
+	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
 	struct soc_device *soc_dev;
 	u32 soc_rev = 0;
 	u64 soc_uid = 0;
 	int ret;
 
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	soc_dev_attr = devm_kzalloc(dev, sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
@@ -228,13 +211,11 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 
 	ret = of_property_read_string(of_root, "model", &soc_dev_attr->machine);
 	if (ret)
-		goto free_soc;
+		return ret;
 
 	id = of_match_node(imx8_soc_match, of_root);
-	if (!id) {
-		ret = -ENODEV;
-		goto free_soc;
-	}
+	if (!id)
+		return -ENODEV;
 
 	data = id->data;
 	if (data) {
@@ -242,27 +223,21 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 		if (data->soc_revision) {
 			ret = data->soc_revision(&soc_rev, &soc_uid);
 			if (ret)
-				goto free_soc;
+				return ret;
 		}
 	}
 
-	soc_dev_attr->revision = imx8_revision(soc_rev);
-	if (!soc_dev_attr->revision) {
-		ret = -ENOMEM;
-		goto free_soc;
-	}
+	soc_dev_attr->revision = imx8_revision(dev, soc_rev);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
 
-	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
-	if (!soc_dev_attr->serial_number) {
-		ret = -ENOMEM;
-		goto free_rev;
-	}
+	soc_dev_attr->serial_number = devm_kasprintf(dev, GFP_KERNEL, "%016llX", soc_uid);
+	if (!soc_dev_attr->serial_number)
+		return -ENOMEM;
 
 	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev)) {
-		ret = PTR_ERR(soc_dev);
-		goto free_serial_number;
-	}
+	if (IS_ERR(soc_dev))
+		return PTR_ERR(soc_dev);
 
 	pr_info("SoC: %s revision %s\n", soc_dev_attr->soc_id,
 		soc_dev_attr->revision);
@@ -271,15 +246,6 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
 
 	return 0;
-
-free_serial_number:
-	kfree(soc_dev_attr->serial_number);
-free_rev:
-	if (strcmp(soc_dev_attr->revision, "unknown"))
-		kfree(soc_dev_attr->revision);
-free_soc:
-	kfree(soc_dev_attr);
-	return ret;
 }
 
 static struct platform_driver imx8m_soc_driver = {
-- 
2.45.2


