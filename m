Return-Path: <linux-kernel+bounces-288285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 810FF95385C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40A91C20E71
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4093B1B9B54;
	Thu, 15 Aug 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="veV6A0cT"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2053.outbound.protection.outlook.com [40.95.54.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6421B4C2D;
	Thu, 15 Aug 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.54.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739772; cv=fail; b=K2GMTvjQpBfDZFnOZ3SVlloPFilopw2Kht0Jb9yWNcUWGF53uzHzPhz+ZocKlNTgBYXakuXdoBOIFTm7Hs9QGQ3nmCMMwxjlw+mrZFoyUk32SvnpfShFloROLRLu7/tR3zO53pYgjl9qyRWFyvNd30LSTIBTNuy7N5twvLfvZyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739772; c=relaxed/simple;
	bh=SZfdRYxLgqV1D45D0IiQhUdNkwZz+FPvdUUYLfS9B2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYT75WZuHePzbjDi4zKZabvAjo2gdgCxA/cXvbXjV5jXm7jFI5ggCY1vbDx4KZrSDoQqxxjsAQ5jH9ZgGEBMx49ziSKK8HzghfTup0+8ubPlM4F08faa61a/9RkBntLHn+NmOCqUmA1TQtk2PHIuz1ss0k86JNOv0GdTpFoece0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=veV6A0cT; arc=fail smtp.client-ip=40.95.54.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2u+j7ZvpjN5670Ab52St3cnwzqCwgXffKQFmWqQLHtWt4pcZnUykJj8YMx3pRNuJEKtZoa6QaExAt3Kg1nnSK6LiljjoXdVxtEudXQAKUfnD98QYtGBwjoDaxklxyi6xDo8P3o2DITTx44jSfxUwacTpjDEyRdFcCnupFGdBMwJF8I7Iwqh/rzaQd/eE1JVl/TSX4EEhZUqR5e5e+x6Tn8hxCp2pAhjaX1+lrvAqfwGGMKhXFIT7Cd52iLl85FB81UO23hOBMylJciehS4yyniZPrt/pZ9QmZDDB0fqu82MeQA7ACklekKW/bPkolgKTIxpJGypNmzc9uhyCepv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAuEzqHIOSfq8jhfg97/P6te6r/B/zcq/uq1CyQxERk=;
 b=k5+Evl3uGQEtT4bPZbTqG7S/Noxoe3NNkrp3RTPIrQOecbIG12U7i5DUT7dxOre62lGyGppC+t4n7ZRzdI5QQWg5hSKLP+dBPLqD89M/Ry+oaUnzyx+w3+zEtQ4QdCxVNs6o+BUpoqCHPlXiuRfEBbsKxh/b5PSl856SmNuO7Ebzsh9fEaGWfhhYiMUYLkOCb6JjwNmKG/yO6nOCiwIT2U8kgS0WFRo5bR9u/uSfW5MW+ze96eSULqdnslhOUyCE9D+US4Mb/WK9LuC8haw8Fbitgky+yYFhv8IA0bBJV4GylJ2CE7aYCNLfXl4en5sG6JVF5Vx0bSSNcStPKkfwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAuEzqHIOSfq8jhfg97/P6te6r/B/zcq/uq1CyQxERk=;
 b=veV6A0cTOTf2jnde78faumPKLTQ9Kn4BlgObSgV3mqXlT/lD6FkkMeFqGOv3S1RSc3tfpX4MBxzc9ny9ua0dIg319Bb+vke6Ec15+zVYvfaXj+OBC/Fk+LwFfrPvSCRhaBwfsMuIUMjbeokbectoi1Yw1fB4/jW7Xuh5+xKZFpc=
Received: from KL1PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:820:f::15)
 by TYZPR03MB8102.apcprd03.prod.outlook.com (2603:1096:400:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 15:03:00 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:820:f:cafe::ba) by KL1PR0401CA0010.outlook.office365.com
 (2603:1096:820:f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 15:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 175.98.123.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 15:02:58 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 23:02:58 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 23:02:58 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 448A05F5FD;
	Thu, 15 Aug 2024 18:02:57 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 3C360DC0DCE; Thu, 15 Aug 2024 18:02:57 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH RESEND v27 2/3] reset: npcm: register npcm8xx clock auxiliary bus device
Date: Thu, 15 Aug 2024 18:02:54 +0300
Message-ID: <20240815150255.3996258-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815150255.3996258-1-tmaimon77@gmail.com>
References: <20240815150255.3996258-1-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|TYZPR03MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: d35f4334-be24-4070-ba87-08dcbd3b59cb
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|7416014|35950700016|48200799018|7093399012|921020|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oR2ABMUpFT44rFC6HsjPlQA/fbNk+0cG80olngiEAklCKQrb2iw5vefGkRbY?=
 =?us-ascii?Q?X0N71FevOo/sAUa7Nhtk3n/fOO9qfxxChqIpTh7wsYsDKTUyVhI8bVQpqxng?=
 =?us-ascii?Q?kG+MR3DtYi4c2QsGSDuH+n7IXzXk512gfAmWEQEvwihOkC8ppXIq7gLgR6LR?=
 =?us-ascii?Q?PFgHHUP9n1f3d0LvhXpEoeR7BF5jazNzHkpSJkKA/AxwqNP7OzOo0p48MQQd?=
 =?us-ascii?Q?R5SK1y/aDeV3yL5U8djij1ViCIGEXvpNla15d8RDkWgf8lsnIemMNdPD9KB4?=
 =?us-ascii?Q?g4lf05AXmbKzP6gOx56Su6OwUZEzAvpKRHYpXBFoBXm5iAe+7t72p+SQ/G0l?=
 =?us-ascii?Q?wCYYb7Ch+I/3UOttYvEm/+H3o1FORDwgCvvUisO0aGYfmbFXesCz4XcFItJq?=
 =?us-ascii?Q?oGyP2HI0qMVUjDHZY8/8QKZ5R5pgasmF+JviQhoHuRkgpK1Su1msbclDMswQ?=
 =?us-ascii?Q?4ZN4nErZL/aiXyCPy2n/c2jl//GDVW1LEOLbxY4W05tUATOhnObOnPq5YSlU?=
 =?us-ascii?Q?vWK6iu/jdVKhpFU89AY51vouZyiDYp5Lmop7IZMJRx5pjhKzRm19M5ECJHCk?=
 =?us-ascii?Q?Pz6W9P85Qy+vsb7F6kOeG4gQ9BAUp3QlADP0kFt43ePlqwZgiPDZu7nqPYk8?=
 =?us-ascii?Q?KDd+fICT9ojrosphsJEYh5VyfYh59S5h0RelS9rfdArGUqubf94kfwr99Yhu?=
 =?us-ascii?Q?Jjmo6H0/TfcmbxcJbqj324ZZHWrwuOYf0jyEqCUl3LstLVnaFSmQIskOxxaa?=
 =?us-ascii?Q?RnZ8QN+qkMGROQpPaXiEIp43zJlCuPYQP030r4K9OIsR1YJrKouwmSMDPe37?=
 =?us-ascii?Q?KlTTItwdJmMJ7pxyeNEuScqhi8vBafOEPMdiJwd6XsdI4JiTRwvLG5YMqHAb?=
 =?us-ascii?Q?inItPUd0krH9xqyduwo0wldCKjHx922KJjsIv8h3vY3jjRbL7OI9/Dlphn4t?=
 =?us-ascii?Q?jrTrjIpx5fcTOUbkGs7YouiWqx/hekob4m+rdog4zZZNVABwPM6zqFls9EHG?=
 =?us-ascii?Q?1zXNFpK/i5F/uPfPHCLQ11vMeLmK3oKfGb64naw7IZPpEbP2XksTAIKb/UWk?=
 =?us-ascii?Q?DMr2dIdERKJZ4wCyo/XZO1ZB7dl2I+MbmrF8ocNZmT9vuVrxkbWI3j8pE+c/?=
 =?us-ascii?Q?BAX2hljpRVpPzgCgtgxIU4Xwu2+mUNUHkDjYOJt5xivGyv1TyZ6Ge1mmWiFR?=
 =?us-ascii?Q?te7ZJlLYsgIvP/eZHQLdaap/SQt2SbaOaQaZXpu8TPsvfbtZI+jr/eRHX/fe?=
 =?us-ascii?Q?NQOW4gX3hfRO2biaL/f5gdn8cFno/1BRYAG7HOODuHu5V3RbcBIbnsoX+ddK?=
 =?us-ascii?Q?Ty04v1PWEvJbuR+gelPtKZoho5PO5D8/yS9PGcAIb0i44A1UvC7AZuiY7QU+?=
 =?us-ascii?Q?Ns0mcnuZvSeUxr/5ox6X2R8euRJnhS7m+Imk4/OL3yLGmeLnkNCcxfKwopKX?=
 =?us-ascii?Q?emS5vobWAyKWIjHCychQpEJ+fEQAoKiyhZsckIKKX2+rkIrGoHWnO0ReLeHN?=
 =?us-ascii?Q?PISTWUVGbUWmtFw=3D?=
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(7416014)(35950700016)(48200799018)(7093399012)(921020)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 15:02:58.6543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d35f4334-be24-4070-ba87-08dcbd3b59cb
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8102

Add NPCM8xx clock controller auxiliary bus device registration.

The NPCM8xx clock controller is registered as an aux device because the
reset and the clock controller share the same register region.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Tested-by: Benjamin Fair <benjaminfair@google.com>
---
 drivers/reset/Kconfig               |  1 +
 drivers/reset/reset-npcm.c          | 74 ++++++++++++++++++++++++++++-
 include/soc/nuvoton/clock-npcm8xx.h | 16 +++++++
 3 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100755 include/soc/nuvoton/clock-npcm8xx.h

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
index 8935ef95a2d1..aa68b947226a 100644
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
@@ -413,7 +480,12 @@ static int npcm_rc_probe(struct platform_device *pdev)
 		}
 	}
 
-	return ret;
+	switch (rc->info->bmc_id) {
+	case BMC_NPCM8XX:
+		return npcm8xx_clock_controller_register(rc, "clk-npcm8xx");
+	default:
+		return ret;
+	}
 }
 
 static struct platform_driver npcm_rc_driver = {
diff --git a/include/soc/nuvoton/clock-npcm8xx.h b/include/soc/nuvoton/clock-npcm8xx.h
new file mode 100755
index 000000000000..139130e98c51
--- /dev/null
+++ b/include/soc/nuvoton/clock-npcm8xx.h
@@ -0,0 +1,16 @@
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
+#define to_npcm_clock_adev(_adev) \
+	container_of((_adev), struct npcm_clock_adev, adev)
+
+#endif
-- 
2.34.1


