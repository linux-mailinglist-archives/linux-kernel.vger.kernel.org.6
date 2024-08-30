Return-Path: <linux-kernel+bounces-308256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88F2965964
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39427281A32
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8091662E9;
	Fri, 30 Aug 2024 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hRHkGL9G"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010059.outbound.protection.outlook.com [52.101.128.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9D15099A
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005179; cv=fail; b=HXD0JGUjSLjx1Reg9/30oEv6Ekc3QHKTL1GxycK3gE/e1MmjLwOEel8mCklWzc0Fyi+4nIzGojf2VCfZzcYFff7TpyZVQ3Nuoea2iEPCwqHkCArNNuvmm028vVAfsetYj0M0WJj4vi8MdiJ3cmk3XOTfGwSJp8Z+U4c8ZoGBdeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005179; c=relaxed/simple;
	bh=u2ek8y3q9sTMpcGtzREvcLbztR40Q+08NzHG6P4Ku1M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YS2Y95XviFxDtZgdZ/Sk2Oqyv8//4Z+WJk/cqQDp+yoKAi2DG1B8kjcc8A8n8NMETLkf+cu78gGucD1WCZ/Ga2YNkTvL+XXa3XHm1IqHaBmRqyKX/GOTNr3v4wyySqZLb8WQUEMMbWwT5NyA8Rso3sGyy8AN/hYjZjKS1S6iyh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hRHkGL9G; arc=fail smtp.client-ip=52.101.128.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBb8SoXB3xCc3YWuR9b20lTqhcnbhjaTcFgmqAAyC4lL28hto8uidPT8yC9G4qIgtQgwSKwT6yU4ZU/bsHAKXJPR91GTneQq1AjRbTRx/zkVTrap3CShh3t1/Qb+/9g7OY4BQ3cAHrIUMCL5t9PaCNR87+gkbKrI4SoGb35m5Vxjeae/X6ms6QADfUN89tZWCI7Lz6+l2TDz9UrgjgwDtHNsLIgxMnEAKZt9DJ2TLem9m+7pkAyID/MyqHXjZmNPPs3mbottO4c8QOwhXf1B8dv861XUulFm+gEwStso8nj1AYCX0D0aEIg1CzbVkkhY8rIEraL1fQR28Oi5mKJtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXE5wezqWjyqsrOsoPZyI6FDRd62p7BbR1uAaf8NKAE=;
 b=P8GdtyC5SCM3WYCAazQlDp0rnmohWAuIMPUFNjQ2iWd5VO0RnaOV9E3m4lIN5fZBdyghlBNfYwvk+YjNnjTlqtDMG6XMh7bYPNi2t8RLmTBb4SOm3jPsAgoS+NnieNtMTp4WBR+MDJaEM3MT0cA0c8zVpnmGh1vEFTL7Y1EhxYvhPk/Le+VbLRdx2B7mXGMyWUrXoKIJ4YoDQEF0tYdmM1Wa+yLMPK5qjnTo/AQ/Rbm50/z9clvyHyimJhxGehGLhqOPrLyvyGKVtvnzxyiLr44fjb3hI7SbG7pSEZCNLuxEleMAvwgFcegfErXZwqAuTzr/509lU0MoO0JsB9xDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXE5wezqWjyqsrOsoPZyI6FDRd62p7BbR1uAaf8NKAE=;
 b=hRHkGL9GlH16qTBWCeKRe/UgAVhZ/7QPag7DCA0zNU7IbNbzBXVmfuUd2m4r7YaV2ymFogp/oVgSjmRejy0+H1mJbUyFUnfzaYvgHgjx7IfF97OeKxg2G8LXTEHmLFFVfdvYloLyBBqCPr/zfKxEH6ttdaUlZSRaGRekEefIQhUsBYS/9iFirFZSSo/3oVOn+jWV2XPQ4TdOUhbgw8sG0nvTldFqpEvNz91KE0gTeFlwaNMi4Jxiv1caX2WoKfpSpyB8jLb0wN74EjZ30os6kbZfPLAVNQZgaiV/++J4SRqZ/B/jGXXqEOUOWT1jDwVssGSgkuT4GHZaFc+V+UJZ4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SI2PR06MB5388.apcprd06.prod.outlook.com (2603:1096:4:1ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 08:06:13 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 08:06:13 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v2] soc: mediatek: Simplify with dev_err_probe()
Date: Fri, 30 Aug 2024 16:05:38 +0800
Message-Id: <20240830080538.376200-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0325.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::8) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SI2PR06MB5388:EE_
X-MS-Office365-Filtering-Correlation-Id: c44db92b-bac8-4319-7c80-08dcc8ca9d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z9SK3Jtnjj9K/V/qxxtMC8WGvGlTFTVySIR2I9kUPzwYh4fLZHQZeJJVAOLn?=
 =?us-ascii?Q?hJ7Z61dlOSd4AnxEsSL5WGvh9Dl4cNNrGTGd5VinUgOMQrkhV2Jbk4dSvlxR?=
 =?us-ascii?Q?U/ijsbRBOCWlJqdMsiymrWyKJASg8sDWN3kXH8g/X7AVZzYC8Cupqbq8aoIA?=
 =?us-ascii?Q?+KOw2rMGElMzRGk3GjfcT/Qv6OV3uvXgOgPOPzpDfLEBDpQFdRfwXWR2F3sq?=
 =?us-ascii?Q?8ODaRoB7rdOXuwmQ0huo4CCRk3nYE2zg96LKl6Rep7fZ1OPksDociWfyWxC0?=
 =?us-ascii?Q?pWOU/ST4qhMiCYmYB/pzzdso3ShCtAcVimRRS05T8Mb42L48fQ+tGSA1Ivk9?=
 =?us-ascii?Q?C+9Podnt7aAdpl8vsApc2ECulzFSC1RoZz1aUrmu4cgwsmrcs8f40n9oHDgI?=
 =?us-ascii?Q?2k/iYItHIVeWR/mIYceSmpRDTVOJHcd4fJRER7VL1i+kjirxTY4uNgrie6WW?=
 =?us-ascii?Q?t1fyqpDSODB9n0AYKWJu6+2Wfxs3z/h0chix7uqVScUNKigmrcQPxr/QuoUI?=
 =?us-ascii?Q?+vcHjLwIkNur9G7uKqK9Q5fmOhDFRT2ROAD3s0sAyqLSCi2Cb6+udIWbH6Fz?=
 =?us-ascii?Q?SToSGabuHODK6PQbnkDxTp5Ij78r9HTy9LEBP3dnyO3vBBcB8VtDqC7R5Lk0?=
 =?us-ascii?Q?ETK5MPFT+/dOhs4rH2kVvHVw0Q1jdTZOORO0mX9rxEZNSBgdJ1OCDhcvTF++?=
 =?us-ascii?Q?2s3TLaYhgIpXutuxsqNY7AXrM3LQxZP2aZh2l676Wrdbw0ti8DlpFljiN+0u?=
 =?us-ascii?Q?Oq0yhlWZ1zzoFyeKLwdluqmkxUXX+bbFwuPIDMVNXsuuzQs4qkw/NJPexf0S?=
 =?us-ascii?Q?rEcpN+SMMOrg1txVTVXrHQmJPXz9Q3lqPLd0kgeslqw9sOkjcZTnnCNC1Gm9?=
 =?us-ascii?Q?slwmyqsrsSOZvuaXw2KlfKm2bwkfbnjAEW6DjW2Kb3CA5u4aooxKZRFgTTHt?=
 =?us-ascii?Q?6rzI3VT33geBQ7FGUdXYoMZtVbgQ31KYlhDFQmpveDnxZpe4SwwKWbTOakGp?=
 =?us-ascii?Q?N+ujYSwGmVVmkS/GFyUO4MWtNfr6r5eMQtyAzjrrm2oBU1t7T+nwUPsDgmr3?=
 =?us-ascii?Q?wtW7po9izqhBHyAxueRe8NXFfWkgVqqgC5nkemeVtLx29F+shq+eydjihc0U?=
 =?us-ascii?Q?+F0ltV9PQzRunWQciacuAO4BgHSP0mw2sgC9llFwphVzzz7A+yHNamibKnyh?=
 =?us-ascii?Q?ZpTAbs2qHQcCb0x7SbJXwtQhj7B8Y56BNUn8jJ65R0Tnzcams6pvMPwIfs7D?=
 =?us-ascii?Q?6K4xZ3xFHWWFLMYIZS8W7AOXpfdqLLenEcJ0udhhJJZtRLL/Z/Ws2SJ2XQUG?=
 =?us-ascii?Q?JsrT/ZRhBK1+2HBP35hdDaB7ZZJsG4BB8ZRUYizBCLpIAyxwdbX7DVuZJ+Yq?=
 =?us-ascii?Q?ifb08xX3NSUZiRXiGdewKfVLo3V4/KBsD+V/hQ36J+MY0NPsNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lk7ks60wm320soYlA50Bdk5Pr8VyqkUwzWVP/mWftOymZ8L+5wzTt9iof2m0?=
 =?us-ascii?Q?akyabuvXES9QhdyAgzZGH5fLd2LOu/V7Nw4SkqLPniYYwXWujjL7ToPiC4dE?=
 =?us-ascii?Q?ViCYtDeixDrMchN61MQj7IznFuYd9JGqZziDQVlMkl6OEcwE3Ie2gaE6VHf9?=
 =?us-ascii?Q?ZYvm/p3rO5UGzl7AMc+4KaRUC+Wj2JXKAWEiW5EVtdhA0H38nd8bL6Qy2uBT?=
 =?us-ascii?Q?Xc9z3lM2FvTqfEzWiQ20neTXETD5yHWoH+DSWwudsYoRVeevM48aSMRcr9dd?=
 =?us-ascii?Q?nUUWzGZvWRAkM2gEEPb28029Den6aMvbNpKKv/z9nKP+0wJ1U9NAZmXPrVgi?=
 =?us-ascii?Q?uV6G5YFdp7kYAg+V46btFa4qSKqdK/eKkRUQGSoS7ocAHTlWO0TJUv+BbX+m?=
 =?us-ascii?Q?2rD3EoEjDIh4FkS4QHhK7tpIIC6fWkQ4vrhe31feWWsLmD7UDeOMUiX8VTze?=
 =?us-ascii?Q?Js+aeww4jlNs/u5I/VeKDkRjDl05EGSNvW1J8Z38r+x910KBVjvV9lbVWZ+x?=
 =?us-ascii?Q?qPS7TrqJwAx4tZs6FpVTwvtW8nL8uhO7i3UuIxhMTxi4jzxQrbi9Ndl5vqHN?=
 =?us-ascii?Q?TZ8RlbLnqduQhS8aYxyueyoE/bBB9W2WB8TTuyS5oY5ieqbwaddFyjQ9fQWS?=
 =?us-ascii?Q?oa9Wb17ewzrLHjZNI7II2pHHsGBPc7nM64tAjWpPvaovosa0h58sJi9lYPxA?=
 =?us-ascii?Q?zuzy/OfokiPDmgy88csr/573tRMY9Fb4G8f44tlqH/KnA0KLUflptfqhhIXO?=
 =?us-ascii?Q?p6O/hP5x5tkquXXKqnsWfFXGZMZpAW0n9b29C45CfurrVbiOLM7CKJ5VrJYR?=
 =?us-ascii?Q?sFNseR0cfx9PheC/7fSOAVJ2EtCDD+RUHs2QFudkhIKxpNjfbNbihYOTRJxG?=
 =?us-ascii?Q?p6rZ/R5OdQ7kBlf7UbBN4xitQ9JiCNFNpIRKMjVXcj2PDZPtosRFsgOm54y+?=
 =?us-ascii?Q?Mc1uoHEEzSKzqGWYpLpCKW/EdVMB6Wvn6vWgxH3Zd0vuY/hR8ddAqzEvDopg?=
 =?us-ascii?Q?vBmZmVRt2zquF1EhqZ+31owiHMAT0vIc6FTj5joERr50a6iuG+s4MM6uo0RQ?=
 =?us-ascii?Q?snCtaAh7hB0emzWw3sZLxfi0+5z+Plju9+vqVXe9ooeT5/KG/Q2M5TSimRMJ?=
 =?us-ascii?Q?n/hdccRCr+dWOVhICXxcRlqaJzW+0eukfLtFIeGzvbwzH5ZPJp/EjF/gQRtN?=
 =?us-ascii?Q?+ydgEzhT2zz7ExzkNcwzLHjwFsBHFOXlheFBZ0jArDZBVzsJnKZ7FD5KcjE1?=
 =?us-ascii?Q?JbAJuspZzl6Ac7Jv2LfbxtVBnNodWwiHbqOAMBRMtoQLVY7phgMucJIbdlFs?=
 =?us-ascii?Q?YF88rz2r3WnHf+m1XFwBhHUTPmz6etmVOj6zB4RUSyuoiapoa7ahiYyMMulA?=
 =?us-ascii?Q?asftv+z1rzo3OeRg75ta4MNwsm9TNLTogeSDhEEJU1lk2GyPeqkTHB7a8Fem?=
 =?us-ascii?Q?jN5G1F5KsHUjltK2/aFqIhM84/vzjy6yWCTWeSVoqKjrftDFjs6a/PJINYYm?=
 =?us-ascii?Q?T2Bst5Xr4TEIBdiIb/CIaGECr8pE3BwD//08VupcMAfhZMjWNfGLc3eGGSc2?=
 =?us-ascii?Q?gJwMp22rMkqn4muBtPQW6/YeBUOhhkzcitXZK24l?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44db92b-bac8-4319-7c80-08dcc8ca9d52
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:06:12.9635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKhkd4anX4TQzy4cWUbnHSyVA8MP1+WDh9IkotwKAKjmasmXbpgEhf+OUMaEKBLVifMXtrDbeQuDFxYqoFXo/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5388

Using dev_err_probe() to simplify the error path and unify a 
message template.

Using this helper is totally fine even if err is known to never
be -EPROBE_DEFER.

The benefit compared to a normal dev_err() is the standardized format
of the error code, it being emitted symbolically and the fact that
the error code is returned which allows more compact error paths.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---

Changes in v2:
- Get rid of `ret = PTR_ERR(mmsys->regs);`.

 drivers/soc/mediatek/mtk-mmsys.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 938240714e54..a6e0c41c10ab 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -397,11 +397,9 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mmsys->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(mmsys->regs)) {
-		ret = PTR_ERR(mmsys->regs);
-		dev_err(dev, "Failed to ioremap mmsys registers: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(mmsys->regs))
+		return dev_err_probe(dev, PTR_ERR(mmsys->regs),
+					"Failed to ioremap mmsys registers");
 
 	mmsys->data = of_device_get_match_data(&pdev->dev);
 
@@ -413,10 +411,9 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 		mmsys->rcdev.ops = &mtk_mmsys_reset_ops;
 		mmsys->rcdev.of_node = pdev->dev.of_node;
 		ret = devm_reset_controller_register(&pdev->dev, &mmsys->rcdev);
-		if (ret) {
-			dev_err(&pdev->dev, "Couldn't register mmsys reset controller: %d\n", ret);
-			return ret;
-		}
+		if (ret)
+			dev_err_probe(&pdev->dev, ret,
+					"Couldn't register mmsys reset controller");
 	}
 
 	/* CMDQ is optional */
-- 
2.34.1


