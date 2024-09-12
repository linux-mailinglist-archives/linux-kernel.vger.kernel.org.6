Return-Path: <linux-kernel+bounces-327585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0418297780E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A9B1C247E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501881D31BB;
	Fri, 13 Sep 2024 04:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="N4cU0z/Q"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01rlnn2069.outbound.protection.outlook.com [40.95.53.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A141B1507;
	Fri, 13 Sep 2024 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.53.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726202687; cv=fail; b=DkKmkwVlgdRN+9lewSZb07eO1g0PuGUX7ATj5a4L0d+Y50aC8v0xbIFQytm+2R6Jm4Cl478bJpFVPWRlAtR4wWPDrfi3/ab1jLMjrqxhQnAio++Cvri79jOWLZz47q008XC61Fp0SMYrRIV304/VTf+4qAG5aHDvZRm2NC3NO74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726202687; c=relaxed/simple;
	bh=DtplKbtJPvbYrzp+n9caDwmRbhmbOy9oBZYrtvOqzoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7uubyLGMIi+mascD9op1yuO6S3i4WXj6fuqbUl1tnhWNJTrdV0e8g6t1J3rvQ642MnrBcO7fl1ktEBMYCIrt3IAg/Tc0o4nWlN8omdu7g90bM/T+dHG1qsBPPPQ/5fa3FS3IE7rovFucMs84FKZ78EDwopwu8Roj4Rj16neOkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=N4cU0z/Q; arc=fail smtp.client-ip=40.95.53.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnRg4FO26oCp0YqbtBhPbTN4KQ2KE1ygh6wqv5sUJsIvmfeGh65JgiVFYITQunn83C3NYIr99pbXjzLWfagKncNLA5K1HNvN5bZjlci3HEGZw+YAo4OeNDvIN9QHSbVwnJormFdG7mHb5IVLJ3R8iF3s2doVewX7Tj8TPu9LC9SUOXW8P8hgyJCmiphQegkbD2QcdBv1S4BX1BURAJflbloOoxHF5qT429j8PZYlz2uIasgOb64c3VGWgRSm8cf3meumxtnsZYaKvNCct9ltD9sPqsgvvHRy3lb9akm9MOw2zP8eRE4KAHsphaZUAQ/ew4kHJoyX9UQpzV5qZOnAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gY/VwM51W7Jix8sfRhkDAfFEL23WDjCVpVbOm7Lwv6c=;
 b=yfl8YKR5IdUBryW9lt9dLBabzKfdQ8NnWITezPPfTd6x+AnQBgNPU+g185VWtavpwtNPiIiwrrrACqoBhgITBQqtdBxwia1TzYCaK4DHGgDlvmeSpYS3y7Fgz0p3J4uG0UfH8kxx1rXU2lmQkX+YOpo4nY8ZU4Kx5+KB908DPKxybilcVx11SvontPtbxHEVUkbK5/GJIvK5Itlm2wuCt2yMel7f+qvCHYrRlE+RjcEZy60zgwTGope8YFBs+u59ydgKcoldhLcVyVG69yoA0D+8Xgf4fpU4asXZ1lNHd+uUWuNcpvmu3TijTtbkZriyT/XqzT8iVnGSjGhSGF6D2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY/VwM51W7Jix8sfRhkDAfFEL23WDjCVpVbOm7Lwv6c=;
 b=N4cU0z/Qg8FpR5gweMuq81D4UYkUUF4h73xUedn7mi+gFTq8TEDlZKZaX8rt6T5SV7ImFVTYHXQujsiMiL+hJhCOR4PPXr4u0hSjr0BGQVd86CxfmLPCuR4Pns9c7hZdqfEgf1EMyF0ulpOkazXZNwI1udPmzlpOCI9Svm1EiVw=
Received: from SI2P153CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::13) by
 TYZPR03MB7364.apcprd03.prod.outlook.com (2603:1096:400:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Thu, 12 Sep
 2024 19:10:45 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:140:cafe::20) by SI2P153CA0010.outlook.office365.com
 (2603:1096:4:140::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.7 via Frontend
 Transport; Thu, 12 Sep 2024 19:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:10:45 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 03:10:41 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 03:10:41 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Sep 2024 03:10:40 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 1C3F15F621;
	Thu, 12 Sep 2024 22:10:40 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 15445DC13FC; Thu, 12 Sep 2024 22:10:40 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v28 2/3] reset: npcm: register npcm8xx clock auxiliary bus device
Date: Thu, 12 Sep 2024 22:10:37 +0300
Message-ID: <20240912191038.981105-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912191038.981105-1-tmaimon77@gmail.com>
References: <20240912191038.981105-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|TYZPR03MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f34d21b-8f61-47a7-16e7-08dcd35e9a90
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35950700016|48200799018|82310400026|7093399012|7416014|376014|61400799027|921020|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FqT7hBDPJ31fs5i11a815/p+NayDkeQ3qCv/DXp0U76cWs5I0ELnGgN6EWl5?=
 =?us-ascii?Q?BrtCeUdhZYteev+PuKGnXjmnDiExifM1mjq+tZdOCYGuL0X59HS44HE78hZu?=
 =?us-ascii?Q?VWjw4q/1MtVAZdt1KjvC285iUXgFK4YterCx7ki8p4mCc7PalZiuoAdlmaj0?=
 =?us-ascii?Q?7YyqF43LYnxXZb6jLI3HMoTvegD8jRPH+ZRlVVoAr1ETo41N91QAxaGO1DxY?=
 =?us-ascii?Q?/XazJN1yzooIPjVTGW+nfj5foukPwN4w6VYhZwAuWa+wKWx7rcNFSWgl+yC2?=
 =?us-ascii?Q?Bbqm+87Dp2rx9A11OH8ZW46a5sIURZ5NAwssyN0JGw2UNh/FoKF5TsGvqxmV?=
 =?us-ascii?Q?ueJy1Ethyo55h5Uhl2Om+bu80rmAQFvx6RKgU19EJEebRYBTCFQpWQjYCkA4?=
 =?us-ascii?Q?tPNPn7X/W94ML9w1AhVxN+izF8zPcPk2ylsZ1UpHfYWrMN5+sdhrqN+Qr1jW?=
 =?us-ascii?Q?tLu7CD4bp0U9aVNXS6juHXXrCtksl6A3sbfOkOTSfNvabVFkUQ+ytCSAvw8O?=
 =?us-ascii?Q?MmtHTKbpH+GporOMtYkPvGF2OK4DYY6qgPE802kUuDxGI3QjfSoP/TnmQa7H?=
 =?us-ascii?Q?gW77GQauFiOtVbibN6qEBINXjLS0EYA7FeXTNuI+9+3HZx1wa5RfBLu1aGd4?=
 =?us-ascii?Q?iLBmPsiRrLHKtvjDlE01vnKYdMoaIxigcWCe2WDTRssl0K3AV2q1qM9v1kl6?=
 =?us-ascii?Q?wrFV5dvxN0ioj2r+M1kyHTAwmTu/nz3VOzT2uphSTYuZRZth9F1KmADBIKaz?=
 =?us-ascii?Q?DUQ+7CLH6PHUZITp4lzrTHriiXaEuyIQ2t5TFnQlbYZ3lU6s7OjXwPrqS48F?=
 =?us-ascii?Q?4A0SjlcmY8iXMVdXUaUAVMd5r/+oGgWFJMSU1gm9LQ6vRDcPpGRA0UjljEIq?=
 =?us-ascii?Q?iqf5FhSVns0UzFI/gE7CZLriPeJzoA7QIb+Hh0NDiKKAMQeKaMnNZSabvkVG?=
 =?us-ascii?Q?wnoSEbraSKgRwTShpbtaCfAw69iD8tYrm/+6y7rYM8VxpYDeoy3WPAbwDbmG?=
 =?us-ascii?Q?6/9PWvE/z8fpbhOhXecaml7RLXQp5ZhDbCtjaSN1WvE4cEacNiN/wHzKD7Ox?=
 =?us-ascii?Q?VJciuZ4vh+oJREC6yKtBGYSRxlfqefv5bk8SWOCYlFgpEaYvRTKXzDCZ61Cu?=
 =?us-ascii?Q?dDBXI0kvuDa3I2BPc+KZ0mpJZ8Z0scdmcnIdVz9Z/eab9nzQQ7qZTeVhsp8O?=
 =?us-ascii?Q?FuQYW4/i7IyqAvwSnqW9AgnxAecgzwfsrqzopILw44wFEK4vON1T0J8RWwfd?=
 =?us-ascii?Q?0aBkGgNL15+jwaLKZAziWRflgDH3UglQgogRqGI7lhXunqVpKqVIlJbJ3esY?=
 =?us-ascii?Q?DN9O06fesNJTOjVG1mRc3MHNxYYY8Ecf8SF17cMavOG2p5Y72RXYbov395T4?=
 =?us-ascii?Q?OAzP6pVhHiz7GDwXjc1AkXpBKiZw835qs/B9H6c11M62b/5gZeD9Lo0Z+jVH?=
 =?us-ascii?Q?CWnrA2d42AIabUvzn5Halag9knO18mm16R20jsQNb3Bs7DmRB2FsVwHUR/Uf?=
 =?us-ascii?Q?MOWcdnFe+RRaaEI=3D?=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(35950700016)(48200799018)(82310400026)(7093399012)(7416014)(376014)(61400799027)(921020)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:10:45.2194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f34d21b-8f61-47a7-16e7-08dcd35e9a90
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7364

Add NPCM8xx clock controller auxiliary bus device registration.

The NPCM8xx clock controller is registered as an aux device because the
reset and the clock controller share the same register region.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Tested-by: Benjamin Fair <benjaminfair@google.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/Kconfig               |  1 +
 drivers/reset/reset-npcm.c          | 78 ++++++++++++++++++++++++++++-
 include/soc/nuvoton/clock-npcm8xx.h | 18 +++++++
 3 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100644 include/soc/nuvoton/clock-npcm8xx.h

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 67bce340a87e..c6bf5275cca2 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -157,6 +157,7 @@ config RESET_MESON_AUDIO_ARB
 config RESET_NPCM
 	bool "NPCM BMC Reset Driver" if COMPILE_TEST
 	default ARCH_NPCM
+	select AUXILIARY_BUS
 	help
 	  This enables the reset controller driver for Nuvoton NPCM
 	  BMC SoCs.
diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index 8935ef95a2d1..4f3b9fc58de0 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Nuvoton Technology corporation.
 
+#include <linux/auxiliary_bus.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -10,11 +11,14 @@
 #include <linux/property.h>
 #include <linux/reboot.h>
 #include <linux/reset-controller.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/of_address.h>
 
+#include <soc/nuvoton/clock-npcm8xx.h>
+
 /* NPCM7xx GCR registers */
 #define NPCM_MDLR_OFFSET	0x7C
 #define NPCM7XX_MDLR_USBD0	BIT(9)
@@ -89,6 +93,7 @@ struct npcm_rc_data {
 	const struct npcm_reset_info *info;
 	struct regmap *gcr_regmap;
 	u32 sw_reset_number;
+	struct device *dev;
 	void __iomem *base;
 	spinlock_t lock;
 };
@@ -372,6 +377,67 @@ static const struct reset_control_ops npcm_rc_ops = {
 	.status		= npcm_rc_status,
 };
 
+static void npcm_clock_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static void npcm_clock_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct npcm_clock_adev *rdev = to_npcm_clock_adev(adev);
+
+	kfree(rdev);
+}
+
+static struct auxiliary_device *npcm_clock_adev_alloc(struct npcm_rc_data *rst_data, char *clk_name)
+{
+	struct npcm_clock_adev *rdev;
+	struct auxiliary_device *adev;
+	int ret;
+
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return ERR_PTR(-ENOMEM);
+
+	rdev->base = rst_data->base;
+
+	adev = &rdev->adev;
+	adev->name = clk_name;
+	adev->dev.parent = rst_data->dev;
+	adev->dev.release = npcm_clock_adev_release;
+	adev->id = 555u;
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		kfree(rdev);
+		return ERR_PTR(ret);
+	}
+
+	return adev;
+}
+
+static int npcm8xx_clock_controller_register(struct npcm_rc_data *rst_data, char *clk_name)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = npcm_clock_adev_alloc(rst_data, clk_name);
+	if (IS_ERR(adev))
+		return PTR_ERR(adev);
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(rst_data->dev, npcm_clock_unregister_adev, adev);
+}
+
 static int npcm_rc_probe(struct platform_device *pdev)
 {
 	struct npcm_rc_data *rc;
@@ -392,6 +458,7 @@ static int npcm_rc_probe(struct platform_device *pdev)
 	rc->rcdev.of_node = pdev->dev.of_node;
 	rc->rcdev.of_reset_n_cells = 2;
 	rc->rcdev.of_xlate = npcm_reset_xlate;
+	rc->dev = &pdev->dev;
 
 	ret = devm_reset_controller_register(&pdev->dev, &rc->rcdev);
 	if (ret) {
@@ -408,12 +475,19 @@ static int npcm_rc_probe(struct platform_device *pdev)
 			rc->restart_nb.priority = 192,
 			rc->restart_nb.notifier_call = npcm_rc_restart,
 			ret = register_restart_handler(&rc->restart_nb);
-			if (ret)
+			if (ret) {
 				dev_warn(&pdev->dev, "failed to register restart handler\n");
+				return ret;
+			}
 		}
 	}
 
-	return ret;
+	switch (rc->info->bmc_id) {
+	case BMC_NPCM8XX:
+		return npcm8xx_clock_controller_register(rc, "clk-npcm8xx");
+	default:
+		return 0;
+	}
 }
 
 static struct platform_driver npcm_rc_driver = {
diff --git a/include/soc/nuvoton/clock-npcm8xx.h b/include/soc/nuvoton/clock-npcm8xx.h
new file mode 100644
index 000000000000..1d974e89d8a8
--- /dev/null
+++ b/include/soc/nuvoton/clock-npcm8xx.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SOC_NPCM8XX_CLOCK_H
+#define __SOC_NPCM8XX_CLOCK_H
+
+#include <linux/auxiliary_bus.h>
+#include <linux/container_of.h>
+
+struct npcm_clock_adev {
+	void __iomem *base;
+	struct auxiliary_device adev;
+};
+
+static inline struct npcm_clock_adev *to_npcm_clock_adev(struct auxiliary_device *_adev)
+{
+	return container_of(_adev, struct npcm_clock_adev, adev);
+}
+
+#endif
-- 
2.34.1


