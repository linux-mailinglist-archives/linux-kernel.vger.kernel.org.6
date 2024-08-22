Return-Path: <linux-kernel+bounces-296582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEC195AC63
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4221C2267F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F8A3BB32;
	Thu, 22 Aug 2024 04:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hnCITiBT"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2047.outbound.protection.outlook.com [40.107.255.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A14A19BB7;
	Thu, 22 Aug 2024 04:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724299681; cv=fail; b=NCtQDp2KTic3L6vGWjR8t+w5Up6crnfs+CKwrJEdXxsZBtqM8XXzEyUC8nBCa6aELxdCqoqe8bYYUV1ZioQsD/H1+y+kJ3XajP9gXswSgifyyyHWURHEyc6V+LSHB3j8MvlDa5F2f9Uu65fKwWNR0MvkyiShWF364hdNx5Fvk6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724299681; c=relaxed/simple;
	bh=YVBSjMz4xvwGs2PRVw+m14n4Yy0III8Kgb+kgRG7l0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+3HBSp3NGDKUuYQGecz2vVMxt3PTQOXrriDIwTlNOiEXbWfKFHmgm03PYigcnFSx9r4BfpiCSURFaKAJAwuex9VbiDh5B/Oll5K2dz99uuzCUqwSFSs/y45AknO8nOj4zUywKnvQcTm5JqWZLPK6mobo1/KvjjMsz9Jszi7l3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hnCITiBT; arc=fail smtp.client-ip=40.107.255.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qslww901ByOe4ecDjGx6l4md+HsCLHRZdAAtrfxU9cFEiIFNW4I83/QwNxREAh/1pVjR795XGgs29PaM7CYWTnuCQj9c+WV+DsE21bUIPHckVuk70CuUG+WU39ywRZoPs1oqedzwNKhnZJ9b96cjAHok1ef547GVP4fvGhc7hP4cRCHVPVwYzoLICyVQK1XHGyO0gCp0J+zxaPFhgoxX5tFD/hWqf3NLQhPn6yRrOVTqCY03vR0V5FBWmCmsG/nY/ZHspthbzZjK0vS+e9/1at8RWTif5V2+C71VnzfhznRSERSqGTKhLpqU029E6iR7R9w+KQ9YsCkqdI53vcoEvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgIF22dr9N5cHfSHqoggAe1n8qmCyyRhjhPVgM+gwNc=;
 b=tGyULwWbx3s8YEo0xvRt+f41YNw1mn5KLSf+7owMfX8/2ohBNbxIzWigEx6lA1oAmGdmM69d1b708Pvcb2+AEoRNL7nVOT961opQnbkKiKTIvj6WefqTqHWBSu/DP/tiGKW6HWdCDCgh9USQ4UY5dmkEgnAiopP8YI1F1KTEAXUqEPzrWEzQJqnF7/afeEgBkuuQiYiqxnmojTyNEPgDZgqQ+VRJP3aRuD851wy72/4FwZOS106IkDUHdG/SW4buYoXp+wdT5nxNJJ58zMaoN5P8NgZxsWS1oWrByrqL0tSqusLBOn7CZWkIFFgEBRpjYwyFAk3x220TWwrrhThGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgIF22dr9N5cHfSHqoggAe1n8qmCyyRhjhPVgM+gwNc=;
 b=hnCITiBT0YZJ3a32H8c5WzkB56wSkvPx2Kq6e8NsvOey2p+YUpQokDoCP3KUlHplGNXasZR+Km2S/kGx9CIRrrfUCAE/ZpYIFxtd61HanpgciafLrfVi1tji4jGZ2mXaNKf5yMyVZ1pGtJwltvtyP01a2U1Jmb92CeTHHheHy02WAjHSab9Bk3BCkNzyjJC8JP1kCmED1kMvTzunhwiwwA5mGIJJ/E4ZRmCbiaxp9BVGZnAHMrK7tgPDylzERLa+RePVhM1dJ0plUhT+jBxl/LL6VcEFVnaJGSBOfDIgm0zV2Io1bRshtNmYaYVdgVkevcG0dBNsLr6/NBf7HkS/aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5620.apcprd06.prod.outlook.com (2603:1096:301:ee::9)
 by TYSPR06MB7134.apcprd06.prod.outlook.com (2603:1096:405:8b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 22 Aug
 2024 04:07:55 +0000
Received: from PUZPR06MB5620.apcprd06.prod.outlook.com
 ([fe80::b771:8e9f:2fb:ee83]) by PUZPR06MB5620.apcprd06.prod.outlook.com
 ([fe80::b771:8e9f:2fb:ee83%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 04:07:55 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Neal Liu <neal_liu@aspeedtech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bin Liu <b-liu@ti.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v1 1/5] usb: aspeed_udc: Use devm_clk_get_enabled() helpers
Date: Thu, 22 Aug 2024 12:07:26 +0800
Message-Id: <20240822040734.29412-2-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822040734.29412-1-liulei.rjpt@vivo.com>
References: <20240822040734.29412-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:404:15::24) To PUZPR06MB5620.apcprd06.prod.outlook.com
 (2603:1096:301:ee::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5620:EE_|TYSPR06MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf2d471-0b40-4824-2370-08dcc2600039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|921020|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PLlU3CTaS+nANiHYu3+9D0mDcIn4sSAar2zFE1razm8WWX+9E6970q7aYVbp?=
 =?us-ascii?Q?YQwn8rN6wXO3W7M5THTjlsGTxNls48GbwmXKfSGHny+SXixbtT/d2zFFifOn?=
 =?us-ascii?Q?qThmORtSLX7+ghUI1HxlRblruCktXaD1fx3CqTyi4tjCIHHMr09J2AMgrM6k?=
 =?us-ascii?Q?ic/myJRPf5GppeCllcTa1hGmiz4O2TrvBIQ6Bdl1U+PQgot4cn9ZuXw7HllX?=
 =?us-ascii?Q?kqrgR3lWjFM9qn/uIg3xnFXdj1mdMpn5NsmOVpYhkrcdFB0SAO95kQBCpfH6?=
 =?us-ascii?Q?qT4ckSrCUxDMc+NwAsQNtIB6/RW3cZnjx894+qkhlK3npFqV0FDThe3bwxGk?=
 =?us-ascii?Q?03sDU5k1ZYTXXoam6bJdxcx7YRTNi3lGL8chPlyYUcl54ho+p6R53MXRlu+F?=
 =?us-ascii?Q?EOMx2OasI9q4OPSkI+CcMC7CrtMsxPYEYYZ4EE5DuOjT6o0twgz4c2AhU9nG?=
 =?us-ascii?Q?Mc3Z+APP+Fhcd4wGuYQGK5ETPrsGS+G5DZiLD5o1zWhT8uTWhuyAon9hrMT1?=
 =?us-ascii?Q?y2RK98T0OfzZ5ynPy93dYUjQd37ANN7gqaVR4UBwse4bwwIb0gcwOPOQ7j+n?=
 =?us-ascii?Q?0GsL9Odqy+61oZviSYOEMBeyLB9MXFGZIW2rbhPnlxy7m9gNUgNFbT1xQT57?=
 =?us-ascii?Q?ZC3XB/N1Y+Mfm3pc+GJPtDNdbtZ4N3bKteMN8k1tfDluegp20CqlD32Fu8Ij?=
 =?us-ascii?Q?gA+DlMqecUFkm1Qpr6okauNeboUUdRrPxYW+Y+SHpOVJuCXckD+kkVsXvKz2?=
 =?us-ascii?Q?G/cokoJyjy5gs9xo4sTTOlhcB/6epU5FJvAJSzVDvl9bvtVHEIch2KoWFBDw?=
 =?us-ascii?Q?dgMQVR7OACUGQc7/sq/IQK/L7NJ92TW4eBYje49ZeVAj8WLmwizIKRoev/Fb?=
 =?us-ascii?Q?frm7+v2dVhDS5Isd9icQAhnIguU1miek6PAjgs0Zo6z6Ih4Vy5jqvWbRzo2o?=
 =?us-ascii?Q?pWYxbiJ0+WQtZbviHt8fSwWjUxganvBQVLZDUYi2ianYpwCVlMKFn/r4tWBN?=
 =?us-ascii?Q?DO3kJrRYcu6tdZPNMmJKGb7iObUzKLb8KG2iTI9bD9RV5UHqI8wK70CE0RGN?=
 =?us-ascii?Q?U5bVTrTgQ+h4h2fl0x+0wkv9bvUqby+Ack6U2u1IlFFgypQZvsUB8cDr8oxb?=
 =?us-ascii?Q?Yqdzpxjw+SHZM4XA0SzIciqvbibGWftKFra+tEcRq2xx9ZA7ZvXdMH2+1wPz?=
 =?us-ascii?Q?gczufkyLVong++dBNjUslZAl8ue4Qggzf8nP5UBUkLatW00rsOfLwtp+a2iD?=
 =?us-ascii?Q?5fzO4co4PnaDeU+tmZgRJpiAQj7BG6Bpay3YocY/hL5VgDhGKfLIRBBglFxP?=
 =?us-ascii?Q?oQ8yFzZVz0TGeUpLX6BEuF8BMBB8E04WP7jcl0/TSC+Kz/AFxqoiekDGCvMA?=
 =?us-ascii?Q?g1X1MV3RLz2ZEL1rt17o7E/k/AK3o57Imle/Ikl+dojBX/mBnOfVXU4IQQsu?=
 =?us-ascii?Q?/rRv5gnCijnd3WmyUrCaxOB9FIRS0MYs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5620.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(921020)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5bEIULdIxDx6ZCI5aY6BnqIQ6h4BMeMbKeQjlkCmqqRjwT2rMIRR+fPuZymR?=
 =?us-ascii?Q?a7LO0l9JnNbtWsEv6SA2Jzd1q6K4fjjx0iGxC+OitpADZEqan3PuqkFN4pXP?=
 =?us-ascii?Q?9tPyuIYwyJmEstJt52abi9LdyNUCPfVlIGVry77v8VBOOuc9ty/U8TdbEd0B?=
 =?us-ascii?Q?B/lKZkPlwEo/eMG0qI11hcjc2YdP8omJ/eo/U0RHd37tVCBBtZ5h/lvX5/BU?=
 =?us-ascii?Q?ADqM+KOAJ7alDPCN9uXTHVWPAt64OHcOpHMpsZwFHRT9glqpQgCiUmtsUaZE?=
 =?us-ascii?Q?0rrXSfWxDGXZ02tPToxMmHAfl822ViAe10Ycjncurc35eFH5uCQe/ESz5Fij?=
 =?us-ascii?Q?o1vHkK85XXdNPlmxVlM9iUgbQhg7HllwiGPxnc3RWjqvIPXh8SN3iYV6bOM9?=
 =?us-ascii?Q?IXeAL8MZzorxPklaH+b6Pgzfjn7KkUvI2W2V3BkAoFvgNdRduBRkym2+XdX3?=
 =?us-ascii?Q?Rt3kehZ6ekcyZO9LowEl0HSm7qBRUdcuKa92WdhFw3PgR176Jz7e72S0H+gx?=
 =?us-ascii?Q?DYRp6kop5b2zElIrTPx7c8LJHbIrlU/G2K79HBgeUKnE09vcNMuLq5xAVSCd?=
 =?us-ascii?Q?+JjIbEjaUQAbfZ9cvt5SXEQh9cjVZ4osz8nItdSsjNvQni/qnrqSRHyZMmLq?=
 =?us-ascii?Q?ytSXNPPszaRxWf2J6fjDgemTv75A1vlDx6JSnY1EZo7UgyuDNCT1rI7vuuy2?=
 =?us-ascii?Q?BcYvXaa8kp4pHJXs2mfkeZchzIgCgc8PBKhBFAe1EXGMr6AaSluWlta38RdH?=
 =?us-ascii?Q?ShTqJlionZLeNh7IE08dnyNHF+Yy6UccYydJIRqODqLwC02AMFBZug4y8U51?=
 =?us-ascii?Q?0ryaIglxlLqy5ju83QmnJHjIJz0O1CaKd/INhhqOCYbvLe+IVQ/WrADO1SnW?=
 =?us-ascii?Q?3xeWoKJL/m2sDOIV9Qvsb2XafYH3oyrPsGPhFjOzOyLqf4PRVqdAQeJ/4PWX?=
 =?us-ascii?Q?vVfJyn5zv28LTLRkleN6RZSBGbRg1d2lmPmw6woHl9/VH2t6DkROv37zCK8r?=
 =?us-ascii?Q?FmWhzU0VXgwUSdiWDreJWPE/dWvrMNbUaMMtM2nQQiKpotd6rxsEOOyw/xl6?=
 =?us-ascii?Q?OiiIWNrvSGCWOwkUUGC5grHlUS9hvxn1rEZhs94J9KGND27iKaC7zbuNOZsa?=
 =?us-ascii?Q?N+JeY6b460Stir+Hmr0kWZnH+vkJGxqAds7jIIMM2XrVqJ+JQkbvzvVc1PMU?=
 =?us-ascii?Q?kLvJUj+FJez/eWHq+iyA89S/xtpJXVlYtDhM2vlDjn9mNhmBd4dtPMnHAPEh?=
 =?us-ascii?Q?RR0T8Ha+LJwecWPTu9aNIKggz0IoXO1OURnjfaJsIWF+3BeX2M4MJ8Eykw2Q?=
 =?us-ascii?Q?N8atquU03w+skgl/jvP9JMp79T1OjeVjfdvT7jxcSKZi6mAd0TeVfpu+p8R2?=
 =?us-ascii?Q?iWUKH5HSbPqJ5vmIwmpZ3LKhRk7TGDIX58u7beeabOIzUTo3WnCupDtOnUbC?=
 =?us-ascii?Q?CdkEzAv3/Vm+CjfTPjFABz32LH06UYb1Zs1i9pTWO1LFD4DxlWyukK2fw7lu?=
 =?us-ascii?Q?7smBUPkAdhAgCoWtyO2/4m1LYqKuh5t2VW7uIDGLSqFqXccPlJG5Tofw3Th+?=
 =?us-ascii?Q?HpE5CVUUdyO7Qq/DstYOAPpYOkLUYDp/5ZNiVYG7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf2d471-0b40-4824-2370-08dcc2600039
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5620.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 04:07:55.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFA0/Bpcx2uFizbSgpsccze4lffF0mKW14iI5U5E4LCWXm3B0DPLXFjo8mAHh6JIC2IRvZN2KZNNNCFluEIGxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7134

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index f4781e611aaa..a362e31f7550 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1459,8 +1459,6 @@ static void ast_udc_remove(struct platform_device *pdev)
 	ctrl = ast_udc_read(udc, AST_UDC_FUNC_CTRL) & ~USB_UPSTREAM_EN;
 	ast_udc_write(udc, ctrl, AST_UDC_FUNC_CTRL);
 
-	clk_disable_unprepare(udc->clk);
-
 	spin_unlock_irqrestore(&udc->lock, flags);
 
 	if (udc->ep0_buf)
@@ -1500,16 +1498,11 @@ static int ast_udc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, udc);
 
-	udc->clk = devm_clk_get(&pdev->dev, NULL);
+	udc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(udc->clk)) {
 		rc = PTR_ERR(udc->clk);
 		goto err;
 	}
-	rc = clk_prepare_enable(udc->clk);
-	if (rc) {
-		dev_err(&pdev->dev, "Failed to enable clock (0x%x)\n", rc);
-		goto err;
-	}
 
 	/* Check if we need to limit the HW to USB1 */
 	max_speed = usb_get_maximum_speed(&pdev->dev);
-- 
2.34.1


