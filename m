Return-Path: <linux-kernel+bounces-296584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE4295AC67
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE13B21C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB5C58ABF;
	Thu, 22 Aug 2024 04:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="n58pJQT+"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2048.outbound.protection.outlook.com [40.107.117.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4B956446;
	Thu, 22 Aug 2024 04:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724299693; cv=fail; b=tnViCjzEKxjuaOmllT00+gpFe0jSZEt3x5hwUozTB+aDRyMCcCK83Fs+zcONGq0SrhGqeIDqr8G3vVIm1OK24n18TUppRAKN/vB1La63MH2EoMlAkLbOza70YoC5zPqQSThiBprTxmTFwjBkfGjPDWLR3VmzbqLlV9j/segz0xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724299693; c=relaxed/simple;
	bh=4JEh5659lE4oCzyGydPMyjW1bqFusCVtsG62nasmUeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JLTtsldvvGGDz4XWF4TH5Pvwzv9O6e1ZeIIcQNPRb2rwKHIAYF39rGeh1d+OpA3W3b3QPLfZvlmFY48F7yx5nCd869WTuTcOh0XR45kxHRYTS0njVhc9nu9vLrV5QG+KfG65L76lo1DuSSQRORC/IGOuDgYiuoyvuO2FFAzn8Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=n58pJQT+; arc=fail smtp.client-ip=40.107.117.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJY0TxFP9l1aga34XDLEpSgB/MGy4fh5mr4dPeXdCKyYFpwrFsiQAQHlOV0VIP3q/xdmsdARTh6tTayKjd7tXHfaHigiC8h6AW6urUFSxhtLr3L0o9oehnRHRqSw62rmPOiIw3nKpDrJGoIRk+9hGrM0Pb5DcOmvEos9PtzUyIWc4eUxyCTd6IgQUQZ3wsbu64I4t7DooOjpdf2a8woFYKFpeUPYESjTlcSFdzqGNFIcba8T7KOuYC3XAeJ3f/WS3EBCYGCSZJq6p7t09K/53FKwPK/Dt3VcvHQ6/8oTWbyCyHMyQ87BMsYSqPAdWm8sWoTLYAbVPNmkVCsdef9kAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYwqVf5nC1G106y3/JeoEY92jkLlLo2RAUiFL4iAX5k=;
 b=EApxw6N8ByFqwXgR2oTxdy1+1KnAix0NpgVpOl5R7PefG8FrZFNj2BlFwE30hZI0sKo5pxdaxBVfhhSIX8fXOnuuXcx8fDqvn4hnhMRHS+XMoWc6siqomVWaYTUmv+OB0uYaT8YQxazxYGuABPEh1sKU887i3oRVQe8IqV6lweaJKcBXDMGKs1IltkHjOf9aUO64n1AAt6zVKfGeOOkVaOVvz8mfffxc2iRu3ysvQuOJQybIIgMlk5VhNzmG5qpIhMoC11owtCvvjAEKoTkQWfz9bMFuDuT7uJ8NlDQXotSGc0JYQ/A456jREMjyIxRAeirIg2szKi+LCvmvNDnNCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYwqVf5nC1G106y3/JeoEY92jkLlLo2RAUiFL4iAX5k=;
 b=n58pJQT+uBH1X0M1W57AlaWy9gtH8743ACOYFzqvljKwCUMtcZ5EpvkrWSKZh3/DAYOuVf50dPUOLm1w/N+kSxCC0FTSo0rlRUvkM/3Zzm8Km+DI47wguCS7aOLz7sACSrYZ9cbtjKahn8iFh+8wPTcswl9LCLNfPYL00rW86o+NuZW8p2UNvdIcTlBofjCcYAAkD/ypr6momFkR+rSazSs68jan8jm1DmUeOetukWj2Gn7pZBEFBJjYz3wbf0x5CcW7MsmT2qEAFd/lVJya6+xds9CKUHN/w0EtTUDt5CAWJUc9BEygrDyPliTHBQAipeDysuUKpyXqijG6VvKBAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5620.apcprd06.prod.outlook.com (2603:1096:301:ee::9)
 by TYSPR06MB7134.apcprd06.prod.outlook.com (2603:1096:405:8b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 22 Aug
 2024 04:08:09 +0000
Received: from PUZPR06MB5620.apcprd06.prod.outlook.com
 ([fe80::b771:8e9f:2fb:ee83]) by PUZPR06MB5620.apcprd06.prod.outlook.com
 ([fe80::b771:8e9f:2fb:ee83%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 04:08:09 +0000
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
Subject: [PATCH v1 3/5] usb: r8a66597-udc: Use devm_clk_get_enabled() helpers
Date: Thu, 22 Aug 2024 12:07:28 +0800
Message-Id: <20240822040734.29412-4-liulei.rjpt@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5a89b64a-ee8f-4fd6-1ce8-08dcc2600810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|921020|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PgUAd7ITCpcOY2pJHQauwAkNBIfLZVAeAX9lJ2OJ8LeA+xy+oPN5yHfkRazt?=
 =?us-ascii?Q?oE6RQNVyUZPh/BkJ05C97mSVDSz//ovzdcM4USOBC6/aXzSwSrFBWN0ae0TS?=
 =?us-ascii?Q?/V21QhU+R0zbdX2I7l8RWtlvbWDWcTH4lUUB8z7GQlVghBkDL5l1uDUhulvb?=
 =?us-ascii?Q?n5P2HjNYx8gfTsJiVRoUVxD0G4fdZdgJhWSdOt63PDlvA0YOoaCJAdoYZJb+?=
 =?us-ascii?Q?MfnrvWh32Kf9Ye+2OWOatWrLUeje9LbiTfrQzHIzditn9hnRj1kv9qTLnJNN?=
 =?us-ascii?Q?unuTjQud6qUI3TPzbz/AtkVPMcq8XBUECFjkv0rjMvBBW7tXtmN2eyWsY1Yp?=
 =?us-ascii?Q?LrpcMKRkdujSdci9Z1pyB02+CC3vfFNpXH5oCjY0mOSgMWLKUI07BhgA/gm+?=
 =?us-ascii?Q?2Ff0P9OrSLGofx6ay0+7bRicYIEA5Tswc2gCslD8tI+rdc3WxFgXgsTc7ZxF?=
 =?us-ascii?Q?GCNvPt9i+98CtHj1oOQW6xJw5h5nKN0dwND70pTQDD+iUT/odtgzTkCFWrrm?=
 =?us-ascii?Q?c9Ea7zuvNndrnqXeibZFj/VbP8ggVK/8omG6enjJZUpCW1VDNv9QO3v5pBDv?=
 =?us-ascii?Q?emlU2P4Ow4uH23gnu/Xu7b4jCq9QCO09X0KoJwYXcO/SQmLw0FShTdU/1URJ?=
 =?us-ascii?Q?OmjSM0k6h1Nf50Z414W+THEZM9xA1F4h3K1CiMaSA7LRtj/aO9SWdgAUUbRE?=
 =?us-ascii?Q?LhLi44RA6dUA/q5/QeyvBcERrQ2ZlE+MaQiduJaNMqwzbpTwVgwyJhI9h3oP?=
 =?us-ascii?Q?m+9CGVL85ZqvZqVRT08mYRcBrYbI46E7oT24K1A01xELYZ1lyzfuinUcbR/R?=
 =?us-ascii?Q?V/10Bv1w4fbKcr6q2gydKrbakPd+n11gxOljYALXIte7I27giEekEYUCB/as?=
 =?us-ascii?Q?mUdTH8rc0d7q6Fi446Sm0CqWNg3M2tlAzTSUkSn78uhDTT4oqBtH4f+ioa15?=
 =?us-ascii?Q?vw6XsSRLgTw7s3K4YWVqoyFuLRGxECAyuJ5CM8XMwXorQCRDIwxKJpziarEk?=
 =?us-ascii?Q?22hcYVZ5JkPzbh1XzaOoPlV/N6y0uMg/w5utpJ2F1h8HP/mdAxfjStniiq5v?=
 =?us-ascii?Q?HaHTLv7sIEWyU31MiG/t5c5W0T/9EVvYxz58lFEOGOWDSot8xfwP7DqFw1sp?=
 =?us-ascii?Q?PJ29vV/QPh7odC2X6fo7spgEKPWtvcpqH5hHENTP7b+3P6wOzE43W7a71zLR?=
 =?us-ascii?Q?Owp93m2WBmVSgQ2foAhaOk4jTZCDLAfE673Yp5LYEHRA+HAZYaYuGaGLNsfh?=
 =?us-ascii?Q?R7gNEZ4pdY78VqlAPpNELJX8fbeaJuq3LcL3DAnyYvrZWmuCfpbFBlay8avz?=
 =?us-ascii?Q?Y+3GLaySKzvg0hnMEtdZG8l0zNIMkKNq9IiEAvAEWKmJW/UIdn1yQprPLXsP?=
 =?us-ascii?Q?mgGGYJH2VBcPk/ZrBen/yB6WNBU4KOJOJsP4hyn9qJrzs2eOsSSz0tAijtfR?=
 =?us-ascii?Q?zMgT1kDU64uELKHc8FCGpNp/8hibIdaE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5620.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(921020)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rtv6OEU/slen4I2Zt43y7f8tQQviRcM3wVRlK10uSzDzUzbTCnU22+23jtjw?=
 =?us-ascii?Q?zW1Vg9nbokrgGas43DfjevCaJRGbj2Lc2ApP4bIpkDQJjDXLTtSjnWlPJ78w?=
 =?us-ascii?Q?SyqLOzetQoOh2TkdgI6xwKu1xIwWwxcg/lIy9eI0zmUCT9vsXb+sJRHgVXKz?=
 =?us-ascii?Q?TmkGgsjnjc/696n3RI/j4bJUTWIJ7KZnI5vjtshf7ge4pK8W9BPsvC8wnkQ6?=
 =?us-ascii?Q?EpXUIS5naDD+rQW47XpbJUBg4XRIwheVxdtur8qyxr6SJy4vKkFjbwKT78HL?=
 =?us-ascii?Q?SLGj7EQq7bRdBIou7eDYgX3Ezh2JIyxDuTUd3l3b3qaqJ3aq3VIq2ObYRn4p?=
 =?us-ascii?Q?kwYawTfoldrkHvySJPPy+s668+nuk2W9hc/YVaFHr6XfnaJxbdwgULde0dw2?=
 =?us-ascii?Q?JVpsyfcFdOyZWGW0Y71zaMbi+B+TXMatF+ar2ODiUjvy5YjYqBfBbnhiY0cy?=
 =?us-ascii?Q?3mmjqHdh4BFsnXonpI8k10LIJBBh2n/byfFOH6ETUJeLNXIo8UohWr5cPhK0?=
 =?us-ascii?Q?r09XYZUhys6UaPaZII+9Y65y2D5A82Y+Ucs93oKdmmzuyqmrDg4T7Dy3eP1v?=
 =?us-ascii?Q?BMaubSQ5SwPhXtirnlNBagMug9F8EOP5+4dyr0/BlZ03k40uQYIdVIh6M5CA?=
 =?us-ascii?Q?vn8jSSVrHCiXWa28Q4//yHnKZmefeI1Iy8gbzHlBOV1YI5vxMtanLLU9SLNL?=
 =?us-ascii?Q?KeZL8egGAqK60SK65QZBTbEjy4uL5bVkGgyx62C4LMulH69t2vcDtQf9N1SL?=
 =?us-ascii?Q?IHfpLGemxwYbCeeMtAEi09AKjCy+G7ABBzTbfYVv3Ofgy3g5xFey3ngPTgQD?=
 =?us-ascii?Q?5cJHA0xhAuGJBT1IgDZ9xYVqYwLybbq1tgDYEPAfvNZQ8juzxXDbWBRwSNja?=
 =?us-ascii?Q?JaexdmGzH95fo454XC4rQ3tfghyZYKQoQi54ENdJjAyCk/rOipYj3/Rjl/0Y?=
 =?us-ascii?Q?mvbb9nsOkR5kQkGvEbPK/xR/VlFHUBSKodPemZ1XmTRLH7V95rudMG9v89Ms?=
 =?us-ascii?Q?/Vb6FLsuXP1TiogYeN+T/dKD9sIIEm4AmZUC1GeAAIW1xklQ1fdAExCe8F9g?=
 =?us-ascii?Q?oe5+f1ZDJh56BNHX7qllmOgNB0VERqst7IFV2Wf8cLM+IvcbX2ZGvqui30au?=
 =?us-ascii?Q?Inspw4Hq2W/HJo59cNRirF8C8JzVd8Wxx5bgOh7rK2ZMx0J3aISt4tFDLzMe?=
 =?us-ascii?Q?P7NOj3kTEDpE7xGSqnwO1bMcimKPrVjaBO/W7xd8Us0HBcAIz3QqG+ZXqWTb?=
 =?us-ascii?Q?q/81vVFX+9OzXhYdIsPpgz7UaQZQusTwb20360YR4Id43N1CVvtJAzZlRQEk?=
 =?us-ascii?Q?wEbrsYBJtHfrd2LY4iUhXAHrSsWujYkBaTf+PFAMj8uAg/hf0WAHqom2sBD3?=
 =?us-ascii?Q?iVuhRuVAF+KezXsGqg01TxZMXrJdulw/B92VHGIyQA0lme4Y1MQnDi76Jx/6?=
 =?us-ascii?Q?dUdMEA0BPjDw6HV+OBXV9EoPaBbiq40lc5qszl//uC99RHuP7fgLzu/xCsga?=
 =?us-ascii?Q?HYqSl54UHthALCKMZRf5mhmZp3DIYdPiJEQA2o5fKoaCeE5hXTlCzVA9fww2?=
 =?us-ascii?Q?6WbDGIEqldwK/czC9GG0Zy/7QaPjzVlve5IG2kpM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a89b64a-ee8f-4fd6-1ce8-08dcc2600810
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5620.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 04:08:08.9365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBksq43PQFqqa7wQCuOpoeYrIO8L6Emg1h1UfOSeKcDgNYGEtP2etFhGiDJ+dykoX1OUsq2WAjCo2wF/e4pCTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7134

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/usb/gadget/udc/r8a66597-udc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index db4a10a979f9..bdbe5ead741e 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1812,10 +1812,6 @@ static void r8a66597_remove(struct platform_device *pdev)
 	usb_del_gadget_udc(&r8a66597->gadget);
 	del_timer_sync(&r8a66597->timer);
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-
-	if (r8a66597->pdata->on_chip) {
-		clk_disable_unprepare(r8a66597->clk);
-	}
 }
 
 static void nop_completion(struct usb_ep *ep, struct usb_request *r)
@@ -1876,18 +1872,17 @@ static int r8a66597_probe(struct platform_device *pdev)
 
 	if (r8a66597->pdata->on_chip) {
 		snprintf(clk_name, sizeof(clk_name), "usb%d", pdev->id);
-		r8a66597->clk = devm_clk_get(dev, clk_name);
+		r8a66597->clk = devm_clk_get_enabled(dev, clk_name);
 		if (IS_ERR(r8a66597->clk)) {
 			dev_err(dev, "cannot get clock \"%s\"\n", clk_name);
 			return PTR_ERR(r8a66597->clk);
 		}
-		clk_prepare_enable(r8a66597->clk);
 	}
 
 	if (r8a66597->pdata->sudmac) {
 		ret = r8a66597_sudmac_ioremap(r8a66597, pdev);
 		if (ret < 0)
-			goto clean_up2;
+			goto err_add_udc;
 	}
 
 	disable_controller(r8a66597); /* make sure controller is disabled */
@@ -1896,7 +1891,7 @@ static int r8a66597_probe(struct platform_device *pdev)
 			       udc_name, r8a66597);
 	if (ret < 0) {
 		dev_err(dev, "request_irq error (%d)\n", ret);
-		goto clean_up2;
+		goto err_add_udc;
 	}
 
 	INIT_LIST_HEAD(&r8a66597->gadget.ep_list);
@@ -1939,7 +1934,7 @@ static int r8a66597_probe(struct platform_device *pdev)
 							GFP_KERNEL);
 	if (r8a66597->ep0_req == NULL) {
 		ret = -ENOMEM;
-		goto clean_up2;
+		goto err_add_udc;
 	}
 	r8a66597->ep0_req->complete = nop_completion;
 
@@ -1952,9 +1947,6 @@ static int r8a66597_probe(struct platform_device *pdev)
 
 err_add_udc:
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-clean_up2:
-	if (r8a66597->pdata->on_chip)
-		clk_disable_unprepare(r8a66597->clk);
 
 	if (r8a66597->ep0_req)
 		r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-- 
2.34.1


