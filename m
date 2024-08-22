Return-Path: <linux-kernel+bounces-297009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD9095B1D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241832825D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C17F17C211;
	Thu, 22 Aug 2024 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cTUrA7Cq"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010032.outbound.protection.outlook.com [52.101.128.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914615572C;
	Thu, 22 Aug 2024 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319482; cv=fail; b=IBSabfnCjHmXP8sVQfGMjYaPbPY3YptlZSATV84KblBy0sCNZaU9kYYwRNPB4JtSAfVWqvPdVt957TF14fbyhw2yoMSWKYknHnC2xb0F79G/V5ASS6PZlixnhlj/WWXkN+022LHqHWXOBq5oJpIDVzd9R0ntbuZF/tNSgSirJ+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319482; c=relaxed/simple;
	bh=qREbto2vrHDM07hy9EqBa+918xWYwPkzWZyZUhUtzXc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FV3xeuN2vMzSvZWQYrSKzqg6s6/X6mpoz88KLacQNDwjSVBg8gr9IpLtUUSF6iv9MPB1pAjuhzkdg/3ckydHQLO2FwOp1JDfrrxYOqupDF+LWh+Bk+yYGnADedo2bAvY5ujkVD1yJNzU+LlOQNC5oRvAJZnpJz04QIDhOPlq+Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cTUrA7Cq; arc=fail smtp.client-ip=52.101.128.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTIgpKlShpfruRPiFJxEhWz45jB+RSvJNIHGIpuVPmCJpWadf9VNkHFGYz3yw86+Of4cej0ZtF1ttiovWio8QW8OQjGk+7QAntvJ82vI8wFE1CC25jrUSW5hBX8sT6SmPe0wMa7lEC9K+A7e7NA4TQf2Isaa2+cgMnbroPkyNLTcftI0bdOm/m11qEGfbVtW8VzjlJkxTEmD5EPIkd6Yddj5EXtHnUcavU98L5ywkwOUBS4lFtIR7tL17n6q9J+W5ofw0cfPzPDGxENZu/s3H/W1z12inDB1AvnUX1JhvrB4t6UGBNFcMGUUlUc9aR3Pv56S09Zhx/W3BoExzCXnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeecfOJ+S+bvgslxe330KSYK96rKrdRIOMpMQ4qjwp4=;
 b=jg6ff3wce1PR1ceZ6gxKux6XaJXqbWlVy+xTKfXLZdpY8qadZ+WXZeK6XAPYnziv5o/sFAwKlNO/dXxzjGJKkL/jML9TGfB/+PsCAsg7zvJbcnX/4ZonJkKPWth6mZOQALKvDRFHowMpvZt4VcWF9ThyZDV9JwEW5Vh9Ca4ZXYOMlvQ6X0b+tQMkv16ZSAd/gKDpKbM2XoBbeHcVrl/UzOWEKFotXTiFB3aMzeKPqXCkzn5vt9o7QtBUUU15iL2ve62TwCUohuLS0OD1CSt8iBv7kn40Lhpx1LhSgf9ihsjESXMW1faSPG/cMtsQPc5A5skXNKzV/MKynpaa8blk9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeecfOJ+S+bvgslxe330KSYK96rKrdRIOMpMQ4qjwp4=;
 b=cTUrA7CqwUhcOE2qP8FFa2wjBk4wh20HQUXMBCug0Sb6NENqMEaaH5bI7JkhLSAvmEarESdyYAZwIncO2dfRDbgzXOYoWeTs9Suhg0a+JnaVAN74Ytas+IB1NKFrcSwA2eeBIexAQ7wCWb0WWZqIZD35nsycxSIoRdP9uo815fff7OnYnnbxO1pYcyGZLLnsPPktBuwOcJGPtG10LfrwQz8E3WvaBa+lYTv5BH0fPoywdVdoOYnq3ggAit+x3fGahmrTAVURPwmDdS+TGu8gblAzbILztiSQZ1s+75EBm0IdtnU8ebvzPKR+AZLOhXH17anr5y8Y/CN8hp4dVvnA9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by TYZPR06MB7315.apcprd06.prod.outlook.com (2603:1096:405:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 22 Aug
 2024 09:37:56 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 09:37:55 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Wu Bo <bo.wu@vivo.com>,
	linux-sound@vger.kernel.org,
	Wu Bo <wubo.oduw@gmail.com>
Subject: [PATCH] ASoC: dwc: change to use devm_clk_get_enabled() helpers
Date: Thu, 22 Aug 2024 03:52:49 -0600
Message-Id: <20240822095249.1642713-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|TYZPR06MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: d2834d25-e9fd-486b-826e-08dcc28e19b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y8wa0evJniQwNw5GrVEwArqN++/be2y0cp41wlavgAYeYzGGWXe5D2I2jrF/?=
 =?us-ascii?Q?iTkkx1IL2WByeCOaUoNFFAoXzxnL/2dj3aRtny+OEEj42gosHeaaWMOysBrQ?=
 =?us-ascii?Q?6PsW9WCBwTml+qmogllCiCFj3/XlXOX+deT+z9wMxIOj9evE2s3egtBmUVOW?=
 =?us-ascii?Q?0mK3p8rAHjmgwOFJJqq9jSL4ejwAGHotYdNN/NFEmY1Me4OiZqqUeIkQcgKv?=
 =?us-ascii?Q?CWeDwvTRBXm56M76kvEPKyfOMgvK6bDqwxvc/KnYoklypnRqRFfJmIWj+CoD?=
 =?us-ascii?Q?Bh1Oz8wajuJGUpuMlMEsi2xqLwAlcmxP1MCH6yHX8UkW5t2RTYLZyBWudH85?=
 =?us-ascii?Q?qeKeXx39De+p/UKq6ZlfIoMxc6CDCkL8wb4a9dY8QPXX43UcNuZwuyoxGE/y?=
 =?us-ascii?Q?welWoyw+J4EBkEDxKZ3O/krbPxABjF3PvYvO1jYiVWTZD8UPJXey7jrXbun3?=
 =?us-ascii?Q?9UqaIZj1Tx1tAiXhvo6NCMzaGipje+G7kDynzsKO9mMTeMi2SzMsd4X5bsB3?=
 =?us-ascii?Q?C8p6HhTFuGDTv1ZRleNFFnqWjnxykEbXVO+InA0nhxpBUgco/UDEjb5zbL7V?=
 =?us-ascii?Q?n820yg2oc3dC0PMnfcbM/JPshoERMvBcea20sKmGfcb4zR0Nba2VOgOxahsh?=
 =?us-ascii?Q?SsWwG4NjXKmE1/2yImCPT7aEaiIzaqBkBC8jrDLKuGv+irfAy5tCBtgToHm4?=
 =?us-ascii?Q?LuNdlWgfFdO06sQ7IMoM2F0dVNnc0axAyilXlwycIg2cduTVObqMSslzL2ML?=
 =?us-ascii?Q?TvoPHJmUVLG8vlQpV/Dxe/k0iVkcip9j9UXFUphYaQ7vIs6eMIoWZ03/SXa7?=
 =?us-ascii?Q?2K0FhdYsNDbugTHtp9eRZaaOK7UXGKvF0UERIQQNTy/iQSRWA/9lcaBAbpjr?=
 =?us-ascii?Q?mM1dhFjjFNekgbxkHhoGNTbgC+ZqrHwhN+M7Ew3qpOpmmENwWLiWrZi8KE42?=
 =?us-ascii?Q?kSudriZtUOCK7BZ34VFRK/UKbQNcYc5yFzz9L1GCUXHrHo/ARmyoE+niEgX2?=
 =?us-ascii?Q?JTszq1xgl42GO4pFJc26vZIF3KCzOoV+w7zC5LCyu8iJWZIl8FUrqK02vldu?=
 =?us-ascii?Q?oxQ/bikOdtdfgG1eGUTC/raOWUtPCHg7JNqPK4oXmE8hnC1GWMniaAEAXhzc?=
 =?us-ascii?Q?Iomi6uitQzLUAgQpegaCE+Qm3V3PA6nPzBBKUKRdFT+E1SU7DfBhBagEomY8?=
 =?us-ascii?Q?Yp549dI9r6WK8AvJjc0rV8g65dLUuQ1aypriUkAieG6S5A0X7T5LsBNkKC7O?=
 =?us-ascii?Q?XyNM4N8W45LGK0RDAMimQG7fINLsGDmCD28ljkVwzNduOLtKLP/cA+sSOEcE?=
 =?us-ascii?Q?d/LeNO2sNjXjkaeLx+lgrwR+L/NGArzV4Stm8UBqHSa7bAZBcaeyJSB0mCdX?=
 =?us-ascii?Q?rvsCLfTM/XviZvZRlG3Zb8TGHWHmTPklUvzQIeZ95AnI3xtimw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EBVV3WXClg4ZlkDzx4RoIGpWhQU18FeDQr82S7ZgEOtWFy96oYuNXYV1wYdk?=
 =?us-ascii?Q?sFMvKFBP9x+ws2YBrI2WThd0x18aSDCoxVMlO2hzdl5+X9sCSPdtFV0rJQQw?=
 =?us-ascii?Q?L5074AG7bwfqNKM++hrjwVid7Hn+q0Dbh/0iZYsx4UILnHAnxXtckbYCgTCi?=
 =?us-ascii?Q?577yss7dCVgrU1d7DtmEU0Ek5y1uewwgRPI6VVY4sxcEOuFalIyIcprAvdyj?=
 =?us-ascii?Q?8M3g7NDf5X37HeDMXi30ql/s9j5Fc+EnqkWHEyLocsW5Tve/xGgYBjPTeCOk?=
 =?us-ascii?Q?clT7xcPXei3WbpUTYyJ3IgL+nwRIIrWWe12DBlEgy+TtkrTMosseF+hR7g+N?=
 =?us-ascii?Q?ZDTezG390bPj5uFdy4mOc58ZGswYF5bC8hqArl+VWrT3sdQ18H6SnUEgyw24?=
 =?us-ascii?Q?lRM6dhk7brYDqiK9nAQAIa+ScCtJ+rDRowHRJ7hztlDhAmEm9fvxu/cYDilP?=
 =?us-ascii?Q?w4Xt70qDyjbJiG+c6fNDIpe1MCFe5qZB94OJ5if2Y7JsItZOKhiUXfWb55wJ?=
 =?us-ascii?Q?nTQRGZaQ47ptD4QVd0CZbcE76f0r5/b7HbJdrSXTLATGqcwQy/yHF8/wftJJ?=
 =?us-ascii?Q?H0Gflt4/ts4rvLXmTdsZAazDfSyVtpXc6hzxuqXO/FSUcexJxZ0Q41IDMFT9?=
 =?us-ascii?Q?JloxRuSYZ58oNjSdsT/IpaBKbZ5417x62IWve6stBRtE/kC0c68ZcgaMqPGZ?=
 =?us-ascii?Q?DA5qcHNNisZvcwcR6V4qCKIDPoP/eXkg6BTh6wMV8JgYdbqk2laMVvVW9WMS?=
 =?us-ascii?Q?J+iXfp0gkj2ruEbb2A5N7+0oIx1iklbGKMMeZYoMbdqHeJJ7ovVX07MbJyli?=
 =?us-ascii?Q?hd0K9ukj5GGkoOlVs2UT9s7LK4Uxisn5BTo2aEcjZH5HmnpihUhUL57FJyyd?=
 =?us-ascii?Q?K2VLPAnpznyVQDP0/HbE7ptLjBisnAlTumfkb25TJy4fS/GlzHp7FTEG/vZf?=
 =?us-ascii?Q?kA9IRa9mFSKIiXKGeeVyeArs9tywb05ydXCWwMfNwpZC8ROUeGfUdPLrMWat?=
 =?us-ascii?Q?rBF3O4P4tjtYOFLfa0p32+/tqqISVmAO+mvni2chtcVIu/xZXT+sNpoCii+y?=
 =?us-ascii?Q?AIEc56hEOuLThOMyxyBnX8bJ2yMxgn+eNpa+Pv9Rj6n0nDHm4N1yrjC8oFq8?=
 =?us-ascii?Q?tYQn+pm73llKH1UujnBhJDHP2l9SB2mQQfPqGkIr674gogxQuOZNaB/w9HXY?=
 =?us-ascii?Q?hJEtO7UJy7tgjHPeXa5X1YqnwaeS8cV4BIqGwJHnUDu2yEUQnk/h1llDAOb6?=
 =?us-ascii?Q?qVSUXO5/vv98ERFAOPKZU9RPqZ8+RhVwtWqsp1NMYyFeYQQfPgb0Xctj4F8b?=
 =?us-ascii?Q?Jg7XmZwO9pV587F/xLSZQWLlesdyRq2OwkHbiCzK3TauN+xEU5HfrNvbW9fr?=
 =?us-ascii?Q?720HLCfRMGrI0Dsk1YGGJ2iol79G6YTvGoj576x5V194pjr7khFqKBUK2Ph+?=
 =?us-ascii?Q?83zACjLJ9DAbmBiyoOR1sinYQ856ILZ5h48obOsBdgXY4+drDF+CVpafnU7A?=
 =?us-ascii?Q?ieXDu4wc/MXYfU1Q1u/WfE2Um95+L3wjEibqJuA9Ar9k6FkjmDhkSWfosKXZ?=
 =?us-ascii?Q?UWbKn6DX/SKwF+2qRgc603ViTGDZSbOh9IE5UASa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2834d25-e9fd-486b-826e-08dcc28e19b1
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 09:37:55.4566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADC5tMFr3F+OHGj0XepGZ2EIo7DLaoD+Z98AQpgTiWhPopna6k19YVjeFNYsM6pYcfDrXj3vGbvUaAL+tPLLAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7315

Make the code cleaner and avoid call clk_disable_unprepare()

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 sound/soc/dwc/dwc-i2s.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index c04466f5492e..e6a5eebe5bc9 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -995,16 +995,12 @@ static int dw_i2s_probe(struct platform_device *pdev)
 				goto err_assert_reset;
 			}
 		}
-		dev->clk = devm_clk_get(&pdev->dev, clk_id);
+		dev->clk = devm_clk_get_enabled(&pdev->dev, clk_id);
 
 		if (IS_ERR(dev->clk)) {
 			ret = PTR_ERR(dev->clk);
 			goto err_assert_reset;
 		}
-
-		ret = clk_prepare_enable(dev->clk);
-		if (ret < 0)
-			goto err_assert_reset;
 	}
 
 	dev_set_drvdata(&pdev->dev, dev);
@@ -1012,7 +1008,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 					 dw_i2s_dai, 1);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "not able to register dai\n");
-		goto err_clk_disable;
+		goto err_assert_reset;
 	}
 
 	if (!pdata || dev->is_jh7110) {
@@ -1030,16 +1026,13 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "could not register pcm: %d\n",
 					ret);
-			goto err_clk_disable;
+			goto err_assert_reset;
 		}
 	}
 
 	pm_runtime_enable(&pdev->dev);
 	return 0;
 
-err_clk_disable:
-	if (dev->capability & DW_I2S_MASTER)
-		clk_disable_unprepare(dev->clk);
 err_assert_reset:
 	reset_control_assert(dev->reset);
 	return ret;
@@ -1049,9 +1042,6 @@ static void dw_i2s_remove(struct platform_device *pdev)
 {
 	struct dw_i2s_dev *dev = dev_get_drvdata(&pdev->dev);
 
-	if (dev->capability & DW_I2S_MASTER)
-		clk_disable_unprepare(dev->clk);
-
 	reset_control_assert(dev->reset);
 	pm_runtime_disable(&pdev->dev);
 }
-- 
2.25.1


