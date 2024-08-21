Return-Path: <linux-kernel+bounces-294764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ECC959245
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CDBB2283E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA9A6F06B;
	Wed, 21 Aug 2024 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kLkTkWCC"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2088.outbound.protection.outlook.com [40.107.215.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431944D112
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724204420; cv=fail; b=Jg/iyBLy6HrqaIlkokpDWJv2Uz/EhDtAElEARZEZlEbXaKO2hj+rr2SmdWkUJRVCVtDf8b38AKGJoOW47ASF28vLw9YfzsGgMT4mz+Z+/moMycNBQylOYoDbpMIaOVQ9CyFPKEGyqOHyOfQ3yH67PGGTX7hsRZDXN1p1w5VOuCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724204420; c=relaxed/simple;
	bh=0TaG8h/6fsCLF/77FgxExlp2yJ2Iv7DmJaGemn/YbMY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Rum/chCZQsCCCYqDy2SkaC9OkB5joMifaQGRR1jHarYjMDg2kKRWwGRaiNfFqgKgk5JCtKKerZMDulKnw7z3+k+HfLnPVpAuQdKcmRByLMkWf1XzYySxySSJEMUyWJkMQVEq+SPrYK+ok7URqsmkH1exfCPCETgELOiJLnm9uEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kLkTkWCC; arc=fail smtp.client-ip=40.107.215.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSxVvau5w2CyphhTdclllF0EV5pIJixGy9Pgpx1ghJZTIA9mEB4jtayvyKM/o/PwxUGE1RpXui4arfpnwPSFmDq35jZZXd85kPorpYNh6JQhRMTrDGH81MwxgOCGUy+jA8r/P1yNtZj2tMYOAgH5/8MATKqTPxeRjBPU7TbW66MTZ5ypBcl56qR26iKqwuDWoSmii3pyOQvuJn2rIaaLq1kD27UMz6lgmZiwkPiqLNRJhAr/46ttaFhWW17k/RNtgYXlwUomi1q/n9kuUXglSBy0syd/IWRriTuPOGVblnd/kg5B0qhvyFvVB23aLMCWFelm61N6zFGcZmhlYY/Dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRbovaQfE6K72+WSFymIBsYZlnccdDGo1zKxw9wyn00=;
 b=A+NC5FFtj3JUaMLma9EKY+8LoM2AfFG7PND0FcnfeyEnCa3P04lRkOMDlMLTxwJcoOwDjGZE16t6eJvr79x/zj6dhHkzGpc3jw1YMdN7P2rUffr5k5PMUS5bkxIGItUXuLrKdMcNFha81GJDQFZjwjoqv7/PbZQH3XZ/tKe25C2LAktg77bwyHezZKyaNty+nylRqZtSc8PWgO6Iwz0qOIUVywt3d7cqixN/WEq95IItWTYC/QTYYT8LlG6aVlZqHpmTF99u0zUEj0PqPGZ3atrxDQoWfnxrkRW0nUloiobiXoTBd76cebAMcKYe5EoMvDunmCXbLmGsdUPG9+Z9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRbovaQfE6K72+WSFymIBsYZlnccdDGo1zKxw9wyn00=;
 b=kLkTkWCCMq6M0gGLjmNshOCMIWI6l94PQGGzkXTNvidd+taGkt+4CmNafLLXT4vQ+y8ocbkEwa3fpgt/JrZEWyt8HpALXEukVshs+hhfZUiAkM3N/vljvdHxKr5lvqIMaZrZmJD0VRXOQrY/iDivb0iO76B1SKe8aQco/4MsD8nYmGku3RHXNxGFSu/7FE3RXOc3xs+/cLRI115ErYd8bwUMediGD0grz5BvBSJUYups2LpME6FssWPlO1mI3TKrG0aAxQJKl7ouXfNDWgxp8aHt82rXToJ6g3/DNAeZwhWm7d3UuEZbJ6vysDsADsxqG0vrRB2Tq99s+aLm8FHBIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by PUZPR06MB6186.apcprd06.prod.outlook.com (2603:1096:301:11e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 01:40:11 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 01:40:11 +0000
From: Huan Yang <link@vivo.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] nvmem: jz4780-efuse: Use devm_clk_get_enabled() helpers
Date: Wed, 21 Aug 2024 09:40:01 +0800
Message-ID: <20240821014001.788676-1-link@vivo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|PUZPR06MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d293b4-2fd4-44bb-3fe0-08dcc182321f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bu/r8Z4f6RRbz1u8+97BK48qVa9aODHmvXYOJjKxo5NOtBDq0Ul7Lo9WcJH/?=
 =?us-ascii?Q?eKL+GvITbmYVGufjqzhSbPY7tkx0ABGtn+ypKS560ZzOhlrg+DJjqtDw2nA/?=
 =?us-ascii?Q?cWmjmEr22Nc8jnji6vSZw1X6/2BPFA4pSKIke1VvNffoGQJHOuYhmlMMA0+6?=
 =?us-ascii?Q?W1T0BHldSH0oHdOi8DoqAKZQgtq5fwoDQcuS17KJup8pJJNWstjV8wut+Ac9?=
 =?us-ascii?Q?gHqR8f1vqFPXlsdHSFnH/s+8tdKUSFC4sbSc5R+0bVHF6X4O+zj4qWy9dzbD?=
 =?us-ascii?Q?EVjnsfaYDzZ595QOiqy8SG9/N7Nfl6N9A/3lJDJIagDtiGxexg3eHcRzmZCH?=
 =?us-ascii?Q?mjvdQQhWp0VEh3d1rXWuXCRBr5GFWXPy8zlDrH8ojSe7ZV8Kj9FhxbwEuh49?=
 =?us-ascii?Q?ZfrihGgagtdRhVCxM/ptIdI16MeeMwfX59bsjwGBLACXjFIZM/JcbwjUyEkl?=
 =?us-ascii?Q?pBjyzVsfUT9kLYIH9MDotAokF4pXwJtZHp4XYVsAduf2sfzZTPQtxkPJCgb0?=
 =?us-ascii?Q?i3ATUtlTnr3B6okTio73KAtJj1YjnXCc2ia+8y4s5jbds1VXNo/+ixpcMxgL?=
 =?us-ascii?Q?Ndv83yHsxX3J7o1cgxNb7CVvY7dD3/ABm7YEiK9Ks5/t5iMJAXh58ommSGTa?=
 =?us-ascii?Q?6Q6tjtiEukyZzu1x4jLpI2Jizx7MKDQjViP9t5fsPA18v88CPs7TSpegA9Ny?=
 =?us-ascii?Q?u9c+j0DCPlOgg+rssTevEoQbm5mitL8EvIZC8avkh63M52cT0kqTEmvgebi/?=
 =?us-ascii?Q?2rRnOcbgTL3XMbluKbMJp59OF5KAPrI74wpM9sv+kDNCqqHGJ13HQpabibFh?=
 =?us-ascii?Q?49TlPNkX7thnaw/shDkpGJ+x7nEuCivuCjjfCccfj/ExGAZ1bQzMmgDf7s8R?=
 =?us-ascii?Q?Mwg/wOzFo2ljYvfJknByXuPHc184yCICFInA2uYXLn3CZ+RhS+Z0geSdTZ8o?=
 =?us-ascii?Q?UXcGLYgcrCzu1RlNkZQX49/MUGGtbybFhqaUYddKCZYF7SM2UxhSP3Wydd+l?=
 =?us-ascii?Q?1AkpuV3lz0ZoV5E+Ohj2BpC2Bh7ZWTp5JrMxmg/iGHh7f69sjvz/NwcKDD8Y?=
 =?us-ascii?Q?41LAdfodhSdxqY1mr2riPHpEdnYRNHFMRkPW1h5a+v8lZnO+/U+ceq//A6AX?=
 =?us-ascii?Q?6THguGLUQzB10eHki49fYqWyNGxX11VxNAR/57TqMEJlVHxGcYp7qosjFXGi?=
 =?us-ascii?Q?rW5meA9WlSkgfgA/mXDwqA2HVmdEPuKtEwK0BShB9c7Rz7BsmW2aLCeUMEfM?=
 =?us-ascii?Q?Iyg5cznZNK3E5j5QLsthls9l6NPe1S1r8my2ExZh4yuZ/mNRBVewA24XLOsm?=
 =?us-ascii?Q?vZIQNPM6095j3kCctFrFDj3ZcvBqqyL4vPVjZoylWx9SmyuxSJOJ14siUyA5?=
 =?us-ascii?Q?vPcePWcdHdrzULj/Rn5mUkchzTjx+JnB4UHji4Se7gzGoOmPlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mVoZW+bgurN29nhjyqNZyR9Mv6y0zgWwLs9uSGLSGBFqk1eFTn7IMxYYsEPx?=
 =?us-ascii?Q?MBRFJbZGppTlqmeIfXDmINxivxcfbCuFoCRGM7pFRDLTD6QUNgA91Yz/vpB0?=
 =?us-ascii?Q?tSkwv/t9xo2T/xDRFfoNhMeIgrJDLu2ObIG69p/GwtIcFR5KkkBLM9jBD1gc?=
 =?us-ascii?Q?SGrvEbYjdrU6vclWqCWBlrRZ5g4F/NlLNNm6VXRV890kWruPdecqAraL/3xu?=
 =?us-ascii?Q?WrPEQpWmfVw9zRsf+BQTqnpNByFT5AE+Mly+wuRKmZZ+zoVchTB+SX6bs/Ee?=
 =?us-ascii?Q?16+i5Md/Kd3x3Jl3CG5MIS2cnrsObekJJrLkyR0dsE/K1ZEoTKtftdyGas8x?=
 =?us-ascii?Q?Iry2C6s0xSJ5j9awZbRCNCZ4UR72NHpaF0AavnuflDrrGu1eIE8UstE+lDIy?=
 =?us-ascii?Q?L8Y4jifWOfCGme+FpMREn1Hvoxx3xP4YWYvAM1YrYi4rgcud8jy7c3OnA8SY?=
 =?us-ascii?Q?GSp4TFjFJt2XGp98xugBMsfOyRuwyxe3RygNXEsANQ87nDZNTVsDAlf6aESR?=
 =?us-ascii?Q?EOGRBT6cITUdqi29m/YVxxYd5ecHM5T1mw9Be4ErspuIZO167pJGOWm9h3h4?=
 =?us-ascii?Q?rnbnbcIMFyA6geqVwBsrKg52aPjLnwhfiF7GuH8JeSHtP6ec4WvVbWOOoGfr?=
 =?us-ascii?Q?GsvmphPacBs9l2w2xKuVtRvNoIrZ5QrzEzN+lwoQgdAPmRbS6JWyoTKCLDr1?=
 =?us-ascii?Q?qGoGDHtke1Pf3mLwzGIwHp26YvAiXv1xB/b0YfngO203R06ARNzhzySnV9uW?=
 =?us-ascii?Q?x392kmaSXc9jvst0wvKDewf7dtty1yeKOzJBfZwxzb/sSFx9Zy6lCTfHOhJV?=
 =?us-ascii?Q?0QDXpLpvUUuqfZIkJvDD/N2TnqQ3NKOXYlDZsoLgNv7JILQujqaXhYfMYdrn?=
 =?us-ascii?Q?EPZ7IuHl4sX4JJF00U0JbldjqpeIRGh4uN4IAn9rrPX1gbhy7A2HsbiazOu/?=
 =?us-ascii?Q?E/A32nu+uOwRyKCkwfO8Idv3lf7p3PB/lS5tgFEnzgyweGSni/8WgqT5S74f?=
 =?us-ascii?Q?BRXBSLDNYSsHE6R+us6CA8jQ9xKDdbQh89AQCmmqdt5w0Kz/EYqHMxYvYefV?=
 =?us-ascii?Q?coinq3S/0RsYWek66KJywwmj6Vmz2mV6jHQhvIZyRHjWnZxbhgECAF0xCOUK?=
 =?us-ascii?Q?qi0ttJtPS71RSIu6mWHTSOGvLTZNTIQYoGaJiKWdwa7vIZI/PeiowHR6P6dZ?=
 =?us-ascii?Q?A4X0oW/G219EDo1kQ5/3aDoiQWT0UB7EVuRZwp6uosfL6B1+senSN4SXkXol?=
 =?us-ascii?Q?Dz1oyioDX9YTUIWjS1uvWVfYekcpSoS2Vf1OsD4iXorhDsRXyu55BunplLkF?=
 =?us-ascii?Q?HlwT5hU8XFdKfWR0y80nQZf75qVB3FqCYuDUC3Uxs1Ody6OFhGnTAUvMy5vB?=
 =?us-ascii?Q?PX7cG7FJ2dkd6lNdwLBL1Lx4q79T/zX/Ro+AUbENf+YFv9QQqCGR11cpGCW6?=
 =?us-ascii?Q?cw8J8lRiBViycpVqmEsRRUvWjG5rSwE0Ey+OraPqOPNWc77IqEJm+MZNnPUM?=
 =?us-ascii?Q?kKCp1Rt0zWt8vdhutxfcslEcXudmIAumls/UAW2aahCF/o4Yyj27OPXcZURA?=
 =?us-ascii?Q?2Yqvyh/hXuh6nF+bM2ZcTqdYlGcRpU6SRuJ6jBZK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d293b4-2fd4-44bb-3fe0-08dcc182321f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 01:40:11.1967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvstqLkwf6JM8imo+uum6YT0FrZAp3o2CdEXwKmpuZimH9FMwPWy3dz6PergE01AoD5sa+k7pwAvjeLkur7hVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6186

The devm_clk_get_enabled() helpers:
     - call devm_clk_get()
     - call clk_prepare_enable() and register what is needed in order to
      call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Due to clk only used when probe, no need to save it into jz4780_efuse.

Signed-off-by: Huan Yang <link@vivo.com>
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v1 -> v2: remove clk pointer from jz4780_efuse

 drivers/nvmem/jz4780-efuse.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/nvmem/jz4780-efuse.c b/drivers/nvmem/jz4780-efuse.c
index 0b01b840edd9..99c43c93f4a5 100644
--- a/drivers/nvmem/jz4780-efuse.c
+++ b/drivers/nvmem/jz4780-efuse.c
@@ -62,7 +62,6 @@
 struct jz4780_efuse {
 	struct device *dev;
 	struct regmap *map;
-	struct clk *clk;
 };
 
 /* main entry point */
@@ -131,11 +130,6 @@ static const struct regmap_config jz4780_efuse_regmap_config = {
 	.max_register = JZ_EFUDATA(7),
 };
 
-static void clk_disable_unprepare_helper(void *clock)
-{
-	clk_disable_unprepare(clock);
-}
-
 static int jz4780_efuse_probe(struct platform_device *pdev)
 {
 	struct nvmem_device *nvmem;
@@ -146,7 +140,7 @@ static int jz4780_efuse_probe(struct platform_device *pdev)
 	unsigned long rd_strobe;
 	struct device *dev = &pdev->dev;
 	void __iomem *regs;
-	int ret;
+	struct clk *clk;
 
 	efuse = devm_kzalloc(dev, sizeof(*efuse), GFP_KERNEL);
 	if (!efuse)
@@ -161,21 +155,11 @@ static int jz4780_efuse_probe(struct platform_device *pdev)
 	if (IS_ERR(efuse->map))
 		return PTR_ERR(efuse->map);
 
-	efuse->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(efuse->clk))
-		return PTR_ERR(efuse->clk);
-
-	ret = clk_prepare_enable(efuse->clk);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       clk_disable_unprepare_helper,
-				       efuse->clk);
-	if (ret < 0)
-		return ret;
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
-	clk_rate = clk_get_rate(efuse->clk);
+	clk_rate = clk_get_rate(clk);
 
 	efuse->dev = dev;
 
-- 
2.45.2


