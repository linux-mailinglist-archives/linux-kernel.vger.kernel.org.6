Return-Path: <linux-kernel+bounces-341048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310F0987AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60F31F22287
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20AE188719;
	Thu, 26 Sep 2024 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="dTL9LEkt"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93018870F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727386677; cv=none; b=EREJrKZqwoKL5DP/DjrHS6GTgBh+raarf69j2/dL86cF0HYH9tNH85MhjfbFuVvhwARyy40tbkUloglTaZAzpFEiy+1L/Ww5BT8KG1b+QJ4lQN2BD6v3+VeoY5APaAWZ+rEjWZpfmUdRm2rRdeu1eJf1T5HqH0oCL+I+1a4XU1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727386677; c=relaxed/simple;
	bh=mOOTmjJgFak8OstM6EF+pCgwVxfcISPhIQWIFUABGzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLcqJkFVF8QnAKa4dhzWjJZuEBziV5rNaXDBsWOaj47s6kdGdFiClMzpHZqZWxRI4buwhX3dF1iX7wr5oOGVdtRN6EbwOqmnHd7ByfbHBCpD8Q0FBAaf55yUyPDMGe3TwA3ooEebHMsaI+6XckDXKT/S034I2ICwAxmdR++bRQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=dTL9LEkt; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 059E388E5F;
	Thu, 26 Sep 2024 23:37:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727386674;
	bh=Ci3z+zFicgJHVVC8r1emilrTM9/2mfcqUshb3qeik/Y=;
	h=From:To:Cc:Subject:Date:From;
	b=dTL9LEktLmLD/mUbrD/qjl2EiWxLVdxZuMtxQYgHCVg5pRnw5bxRF4/66yALmsHOV
	 wCCgmBEbDNqEOrIsDA/veVaLJ7xI/n906ivuPfJFoUnYWH3eh8pLRJtqwtmaH2ydfR
	 nHHicgDvpJLnKr1RdblKjcxthf+Euc6duZZOgwDfOXDLd6U1KYCYIJX16Dq8vZzwED
	 6fyY6AyUv9RdYnjA953N+Djt7QYImPAFag5nGR/tsIDHmfxBZWmNwi2ndi9MZM6MDc
	 xEzbAkNu+rYUWRh6hhKyM5yWY4qlnwXz/gcmLyGZdlEw0P6p1I7rpChaq/vyerggAh
	 JRsLm73UP4tzw==
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
Subject: [PATCH v3 1/2] soc: imx8m: Probe the SoC driver as platform driver
Date: Thu, 26 Sep 2024 23:36:51 +0200
Message-ID: <20240926213729.2882045-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

With driver_async_probe=* on kernel command line, the following trace is
produced because on i.MX8M Plus hardware because the soc-imx8m.c driver
calls of_clk_get_by_name() which returns -EPROBE_DEFER because the clock
driver is not yet probed. This was not detected during regular testing
without driver_async_probe.

Convert the SoC code to platform driver and instantiate a platform device
in its current device_initcall() to probe the platform driver. Rework
.soc_revision callback to always return valid error code and return SoC
revision via parameter. This way, if anything in the .soc_revision callback
return -EPROBE_DEFER, it gets propagated to .probe and the .probe will get
retried later.

"
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1 at drivers/soc/imx/soc-imx8m.c:115 imx8mm_soc_revision+0xdc/0x180
CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-next-20240924-00002-g2062bb554dea #603
Hardware name: DH electronics i.MX8M Plus DHCOM Premium Developer Kit (3) (DT)
pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : imx8mm_soc_revision+0xdc/0x180
lr : imx8mm_soc_revision+0xd0/0x180
sp : ffff8000821fbcc0
x29: ffff8000821fbce0 x28: 0000000000000000 x27: ffff800081810120
x26: ffff8000818a9970 x25: 0000000000000006 x24: 0000000000824311
x23: ffff8000817f42c8 x22: ffff0000df8be210 x21: fffffffffffffdfb
x20: ffff800082780000 x19: 0000000000000001 x18: ffffffffffffffff
x17: ffff800081fff418 x16: ffff8000823e1000 x15: ffff0000c03b65e8
x14: ffff0000c00051b0 x13: ffff800082790000 x12: 0000000000000801
x11: ffff80008278ffff x10: ffff80008209d3a6 x9 : ffff80008062e95c
x8 : ffff8000821fb9a0 x7 : 0000000000000000 x6 : 00000000000080e3
x5 : ffff0000df8c03d8 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : fffffffffffffdfb x0 : fffffffffffffdfb
Call trace:
 imx8mm_soc_revision+0xdc/0x180
 imx8_soc_init+0xb0/0x1e0
 do_one_initcall+0x94/0x1a8
 kernel_init_freeable+0x240/0x2a8
 kernel_init+0x28/0x140
 ret_from_fork+0x10/0x20
---[ end trace 0000000000000000 ]---
SoC: i.MX8MP revision 1.1
"

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
V2: Use the platform device approach instead of late_initcall
V3: Do not register imx8m_soc_driver on non-iMX8M hardware
---
 drivers/soc/imx/soc-imx8m.c | 107 ++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index fe111bae38c8e..5ea8887828c06 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -30,7 +30,7 @@
 
 struct imx8_soc_data {
 	char *name;
-	u32 (*soc_revision)(void);
+	int (*soc_revision)(u32 *socrev);
 };
 
 static u64 soc_uid;
@@ -51,24 +51,29 @@ static u32 imx8mq_soc_revision_from_atf(void)
 static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
 #endif
 
-static u32 __init imx8mq_soc_revision(void)
+static int imx8mq_soc_revision(u32 *socrev)
 {
 	struct device_node *np;
 	void __iomem *ocotp_base;
 	u32 magic;
 	u32 rev;
 	struct clk *clk;
+	int ret;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
 	if (!np)
-		return 0;
+		return -EINVAL;
 
 	ocotp_base = of_iomap(np, 0);
-	WARN_ON(!ocotp_base);
+	if (!ocotp_base) {
+		ret = -EINVAL;
+		goto err_iomap;
+	}
+
 	clk = of_clk_get_by_name(np, NULL);
 	if (IS_ERR(clk)) {
-		WARN_ON(IS_ERR(clk));
-		return 0;
+		ret = PTR_ERR(clk);
+		goto err_clk;
 	}
 
 	clk_prepare_enable(clk);
@@ -88,32 +93,45 @@ static u32 __init imx8mq_soc_revision(void)
 	soc_uid <<= 32;
 	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
 
+	*socrev = rev;
+
 	clk_disable_unprepare(clk);
 	clk_put(clk);
 	iounmap(ocotp_base);
 	of_node_put(np);
 
-	return rev;
+	return 0;
+
+err_clk:
+	iounmap(ocotp_base);
+err_iomap:
+	of_node_put(np);
+	return ret;
 }
 
-static void __init imx8mm_soc_uid(void)
+static int imx8mm_soc_uid(void)
 {
 	void __iomem *ocotp_base;
 	struct device_node *np;
 	struct clk *clk;
+	int ret = 0;
 	u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
 		     IMX8MP_OCOTP_UID_OFFSET : 0;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
 	if (!np)
-		return;
+		return -EINVAL;
 
 	ocotp_base = of_iomap(np, 0);
-	WARN_ON(!ocotp_base);
+	if (!ocotp_base) {
+		ret = -EINVAL;
+		goto err_iomap;
+	}
+
 	clk = of_clk_get_by_name(np, NULL);
 	if (IS_ERR(clk)) {
-		WARN_ON(IS_ERR(clk));
-		return;
+		ret = PTR_ERR(clk);
+		goto err_clk;
 	}
 
 	clk_prepare_enable(clk);
@@ -124,31 +142,41 @@ static void __init imx8mm_soc_uid(void)
 
 	clk_disable_unprepare(clk);
 	clk_put(clk);
+
+err_clk:
 	iounmap(ocotp_base);
+err_iomap:
 	of_node_put(np);
+
+	return ret;
 }
 
-static u32 __init imx8mm_soc_revision(void)
+static int imx8mm_soc_revision(u32 *socrev)
 {
 	struct device_node *np;
 	void __iomem *anatop_base;
-	u32 rev;
+	int ret;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
 	if (!np)
-		return 0;
+		return -EINVAL;
 
 	anatop_base = of_iomap(np, 0);
-	WARN_ON(!anatop_base);
+	if (!anatop_base) {
+		ret = -EINVAL;
+		goto err_iomap;
+	}
 
-	rev = readl_relaxed(anatop_base + ANADIG_DIGPROG_IMX8MM);
+	*socrev = readl_relaxed(anatop_base + ANADIG_DIGPROG_IMX8MM);
 
 	iounmap(anatop_base);
 	of_node_put(np);
 
-	imx8mm_soc_uid();
+	return imx8mm_soc_uid();
 
-	return rev;
+err_iomap:
+	of_node_put(np);
+	return ret;
 }
 
 static const struct imx8_soc_data imx8mq_soc_data = {
@@ -184,7 +212,7 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
 	"unknown"
 
-static int __init imx8_soc_init(void)
+static int imx8m_soc_probe(struct platform_device *pdev)
 {
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
@@ -212,8 +240,11 @@ static int __init imx8_soc_init(void)
 	data = id->data;
 	if (data) {
 		soc_dev_attr->soc_id = data->name;
-		if (data->soc_revision)
-			soc_rev = data->soc_revision();
+		if (data->soc_revision) {
+			ret = data->soc_revision(&soc_rev);
+			if (ret)
+				goto free_soc;
+		}
 	}
 
 	soc_dev_attr->revision = imx8_revision(soc_rev);
@@ -251,6 +282,38 @@ static int __init imx8_soc_init(void)
 	kfree(soc_dev_attr);
 	return ret;
 }
+
+static struct platform_driver imx8m_soc_driver = {
+	.probe = imx8m_soc_probe,
+	.driver = {
+		.name = "imx8m-soc",
+	},
+};
+
+static int __init imx8_soc_init(void)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	/* No match means this is non-i.MX8M hardware, do nothing. */
+	if (!of_match_node(imx8_soc_match, of_root))
+		return 0;
+
+	ret = platform_driver_register(&imx8m_soc_driver);
+	if (ret) {
+		pr_err("Failed to register imx8m-soc platform driver: %d\n", ret);
+		return ret;
+	}
+
+	pdev = platform_device_register_simple("imx8m-soc", -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		pr_err("Failed to register imx8m-soc platform device: %ld\n", PTR_ERR(pdev));
+		platform_driver_unregister(&imx8m_soc_driver);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
 device_initcall(imx8_soc_init);
 MODULE_DESCRIPTION("NXP i.MX8M SoC driver");
 MODULE_LICENSE("GPL");
-- 
2.45.2


