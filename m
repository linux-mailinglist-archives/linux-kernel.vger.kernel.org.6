Return-Path: <linux-kernel+bounces-343105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1FC9896D1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F98C2816A1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 18:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EFA5A117;
	Sun, 29 Sep 2024 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="aF6iNB1s"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C455E53
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727635792; cv=none; b=njS4UqRMPqPZs8cWO+lOBQySYxKdqimat8reedwCDRLfWmT0yCd0OMZkrF7d8z2he87UmiJ59j+r2+6TDZRjDp4kR6EgnF78qC3bdkDAFi3LuNWgGaqVC0wmLewuO4z/KiWDSUJIIliBY7HFwOBXbYXtaxsQIqYCS6p+2lPDF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727635792; c=relaxed/simple;
	bh=HSgZHjpfMSEUAaHPbtmW38GrkjE1wstyCx1kFpRJAZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9bG/zVedbV3+GUX4K2PkRGH1/MUoC9DQNCvmhX3PSmqOAlc/2sanSv9fzsR+dbFoPihCvJy4LvrUBx+d80pXp+SsjPneBLZ+Jggs0n4/WdS7Q7IGHXk9+/guVW0g6VXn9h0y6uBmrprDiQdfp6IB2LAdEmpNPwgtcUcfwfn1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=aF6iNB1s; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id CEC82889C3;
	Sun, 29 Sep 2024 20:49:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727635789;
	bh=9RY84qC1scSDwKcW+cs79Xu5AySZgFm9QJ4CQR1nE0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aF6iNB1sQyThpr8kVouxr1+yWkYDMkYK+Z3s/N1O4U7wX3sGFbrECqKW0gUsI6rID
	 gOXSWukFd2wI7F7ZL1Rqwcjy3AlHfIYGtt3HWjbBV9aWQG0uAQNSr3Ewqx4Eb56vNr
	 yszYIs5I8nagQrIKzz4YLZhe9XkBIndxxx+2qXGTMN1XdkoWM0Y+ZT5aQyO1poP+Cw
	 h2KgnCEp8CVTpivjiIZWq++MAAdc6yFuLDV1qx3lDi34JlS1hHTNeOLXrK+uu0la/Z
	 8x9FHrcXRKrfqlvqaI3ld0DaNdvBnZOy8ShjGqnFL4DZy8P5IbHVJDsWrGQnd9AqJM
	 n35Vr6lbt9BMQ==
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
Subject: [PATCH v4 2/3] soc: imx8m: Remove global soc_uid
Date: Sun, 29 Sep 2024 20:49:17 +0200
Message-ID: <20240929184930.73049-2-marex@denx.de>
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

The static global soc_uid is only ever used as kasprintf() parameter in
imx8m_soc_probe(). Pass pointer to local u64 variable to .soc_revision()
callback instead and let the .soc_revision() callback fill in the content.
Remove the unnecessary static global variable.

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
V3: New patch
V4: No change
---
 drivers/soc/imx/soc-imx8m.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 5ea8887828c06..966593320e28d 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -30,11 +30,9 @@
 
 struct imx8_soc_data {
 	char *name;
-	int (*soc_revision)(u32 *socrev);
+	int (*soc_revision)(u32 *socrev, u64 *socuid);
 };
 
-static u64 soc_uid;
-
 #ifdef CONFIG_HAVE_ARM_SMCCC
 static u32 imx8mq_soc_revision_from_atf(void)
 {
@@ -51,7 +49,7 @@ static u32 imx8mq_soc_revision_from_atf(void)
 static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
 #endif
 
-static int imx8mq_soc_revision(u32 *socrev)
+static int imx8mq_soc_revision(u32 *socrev, u64 *socuid)
 {
 	struct device_node *np;
 	void __iomem *ocotp_base;
@@ -89,9 +87,9 @@ static int imx8mq_soc_revision(u32 *socrev)
 			rev = REV_B1;
 	}
 
-	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
-	soc_uid <<= 32;
-	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
+	*socuid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
+	*socuid <<= 32;
+	*socuid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
 
 	*socrev = rev;
 
@@ -109,7 +107,7 @@ static int imx8mq_soc_revision(u32 *socrev)
 	return ret;
 }
 
-static int imx8mm_soc_uid(void)
+static int imx8mm_soc_uid(u64 *socuid)
 {
 	void __iomem *ocotp_base;
 	struct device_node *np;
@@ -136,9 +134,9 @@ static int imx8mm_soc_uid(void)
 
 	clk_prepare_enable(clk);
 
-	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
-	soc_uid <<= 32;
-	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
+	*socuid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
+	*socuid <<= 32;
+	*socuid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
 
 	clk_disable_unprepare(clk);
 	clk_put(clk);
@@ -151,7 +149,7 @@ static int imx8mm_soc_uid(void)
 	return ret;
 }
 
-static int imx8mm_soc_revision(u32 *socrev)
+static int imx8mm_soc_revision(u32 *socrev, u64 *socuid)
 {
 	struct device_node *np;
 	void __iomem *anatop_base;
@@ -172,7 +170,7 @@ static int imx8mm_soc_revision(u32 *socrev)
 	iounmap(anatop_base);
 	of_node_put(np);
 
-	return imx8mm_soc_uid();
+	return imx8mm_soc_uid(socuid);
 
 err_iomap:
 	of_node_put(np);
@@ -215,10 +213,11 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 static int imx8m_soc_probe(struct platform_device *pdev)
 {
 	struct soc_device_attribute *soc_dev_attr;
-	struct soc_device *soc_dev;
+	const struct imx8_soc_data *data;
 	const struct of_device_id *id;
+	struct soc_device *soc_dev;
 	u32 soc_rev = 0;
-	const struct imx8_soc_data *data;
+	u64 soc_uid = 0;
 	int ret;
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
@@ -241,7 +240,7 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 	if (data) {
 		soc_dev_attr->soc_id = data->name;
 		if (data->soc_revision) {
-			ret = data->soc_revision(&soc_rev);
+			ret = data->soc_revision(&soc_rev, &soc_uid);
 			if (ret)
 				goto free_soc;
 		}
-- 
2.45.2


