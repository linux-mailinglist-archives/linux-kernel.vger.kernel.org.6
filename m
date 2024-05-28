Return-Path: <linux-kernel+bounces-191790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A6A8D1421
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343471F22CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B6853802;
	Tue, 28 May 2024 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="Z3IwiPGH"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F4BDF6B;
	Tue, 28 May 2024 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716876093; cv=none; b=ZdRMSwaGExaBri5gTjrL5qxu7q2Qv5tHj8gnkFhG9L33pzbVo0SUQBJhEraAZz7vlINN0KtuoTW/AxUG4FIBjmKzZvtcu9FpmgOPI936uW1B8tsEvSiJUTYJj4MxyiJyQ0RtmdJDs0CjsK+Z1aTphDvEI+uTDC1/DHJ8FUzSY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716876093; c=relaxed/simple;
	bh=Aj6ZEloQ7TGWFbC9hV7OJYu8DaeDxAmztOXuBG5e3Dg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGYsKMe5dlPnhKYLDSR0LPuxlg5afHAEZqHygG8yx1SM5cc/AlY3PYmQ/3qrAP3uK0vR+qQ5EXCr/2kU1FSimO4ydpMq4z1CeRUp8QxiuuUthY/Xb0tldL9pV79UhomdCbMz2oPSYlNI5YtxeLoDh9EoSuetgELsOfiTWpKwDGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=Z3IwiPGH; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1716876088;
	bh=KBVyImWpeZHdu4aPyc3yhLETL2QmY4feLaTa2cP3xtA=; l=3479;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Z3IwiPGHJ8w5mU0ISgeLfiwLIq70elbFFuVQo0RoCbNWt7AzpF0EoFqYJOPp4dek2
	 UrdSgQC4z9lLvGuQ/MwrEASj8NJ4t8XfsBwGyIrscBAupUMKLOJJIIWVe79JaW2fyx
	 Xg1QIKKQTW/gRbiKEoG3f4Y/NtZNBvhWK05nZ/ZtIcbyE2WZbc1Pd18BRmtarZwZmY
	 ZWhaTBaMMH9OTByFzp2WC/H72dNkZWsmNMch2QgLNi0OuOK+v/EqAwELafWAJUPd+F
	 q9x8BD+Qw1v/S1agqmROGv/MK0EvaxBvCp/pyki22WOS+yYaeMg87D0tqg+DE1/GfO
	 2RdDJfOd98mCg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213211:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 28 May 2024 14:01:20 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 14:01:20 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 14:01:20 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <cy_huang@richtek.com>
Subject: [RESEND 1/4] regulator: rtq2208: Fix invalid memory access when devm_of_regulator_put_matches is called
Date: Tue, 28 May 2024 14:01:13 +0800
Message-ID: <4ce8c4f16f1cf3aa4e5f36c0694dd3c5ccf3cd1c.1716870419.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1716870419.git.alina_yu@richtek.com>
References: <cover.1716870419.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

In this patch, a software bug has been fixed.
rtq2208_ldo_match is no longer a local variable.
It prevents invalid memory access when devm_of_regulator_put_matches
 is called.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
 drivers/regulator/rtq2208-regulator.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index b90e53d..c31b6dc 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -228,6 +228,11 @@ static const struct regulator_ops rtq2208_regulator_ldo_ops = {
 	.set_suspend_disable = rtq2208_set_suspend_disable,
 };
 
+static struct of_regulator_match rtq2208_ldo_match[] = {
+	{.name = "ldo2", },
+	{.name = "ldo1", },
+};
+
 static unsigned int rtq2208_of_map_mode(unsigned int mode)
 {
 	switch (mode) {
@@ -322,8 +327,7 @@ static irqreturn_t rtq2208_irq_handler(int irqno, void *devid)
 	return IRQ_HANDLED;
 }
 
-static int rtq2208_of_get_fixed_voltage(struct device *dev,
-					struct of_regulator_match *rtq2208_ldo_match, int n_fixed)
+static int rtq2208_of_get_ldo_dvs_ability(struct device *dev)
 {
 	struct device_node *np;
 	struct of_regulator_match *match;
@@ -338,14 +342,14 @@ static int rtq2208_of_get_fixed_voltage(struct device *dev,
 	if (!np)
 		np = dev->of_node;
 
-	ret = of_regulator_match(dev, np, rtq2208_ldo_match, n_fixed);
+	ret = of_regulator_match(dev, np, rtq2208_ldo_match, ARRAY_SIZE(rtq2208_ldo_match));
 
 	of_node_put(np);
 
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < n_fixed; i++) {
+	for (i = 0; i < ARRAY_SIZE(rtq2208_ldo_match); i++) {
 		match = rtq2208_ldo_match + i;
 		init_data = match->init_data;
 		rdesc = (struct rtq2208_regulator_desc *)match->driver_data;
@@ -388,8 +392,7 @@ static const struct linear_range rtq2208_vout_range[] = {
 	REGULATOR_LINEAR_RANGE(1310000, 181, 255, 10000),
 };
 
-static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, int mtp_sel,
-					int idx, struct of_regulator_match *rtq2208_ldo_match, int *ldo_idx)
+static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, int mtp_sel, int idx)
 {
 	struct regulator_desc *desc;
 	static const struct {
@@ -461,8 +464,7 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
 static int rtq2208_parse_regulator_dt_data(int n_regulator, const unsigned int *regulator_idx_table,
 		struct rtq2208_regulator_desc *rdesc[RTQ2208_LDO_MAX], struct device *dev)
 {
-	struct of_regulator_match rtq2208_ldo_match[2];
-	int mtp_sel, ret, i, idx, ldo_idx = 0;
+	int mtp_sel, i, idx, ret;
 
 	/* get mtp_sel0 or mtp_sel1 */
 	mtp_sel = device_property_read_bool(dev, "richtek,mtp-sel-high");
@@ -474,7 +476,7 @@ static int rtq2208_parse_regulator_dt_data(int n_regulator, const unsigned int *
 		if (!rdesc[i])
 			return -ENOMEM;
 
-		rtq2208_init_regulator_desc(rdesc[i], mtp_sel, idx, rtq2208_ldo_match, &ldo_idx);
+		rtq2208_init_regulator_desc(rdesc[i], mtp_sel, idx);
 
 		/* init ldo dvs ability */
 		if (idx >= RTQ2208_LDO2)
@@ -482,7 +484,7 @@ static int rtq2208_parse_regulator_dt_data(int n_regulator, const unsigned int *
 	}
 
 	/* init ldo fixed_uV */
-	ret = rtq2208_of_get_fixed_voltage(dev, rtq2208_ldo_match, ldo_idx);
+	ret = rtq2208_of_get_ldo_dvs_ability(dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get ldo fixed_uV\n");
 
-- 
2.7.4


