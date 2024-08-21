Return-Path: <linux-kernel+bounces-295468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5F0959B57
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7ADC283971
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91388188A3A;
	Wed, 21 Aug 2024 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OoZulL+u"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2050.outbound.protection.outlook.com [40.107.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908E3158D8F;
	Wed, 21 Aug 2024 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242275; cv=fail; b=Ktw/KXY9WfSYlqKn4YtbRXHbfFwrNeLvviWoQvriDeaxeO/avTd7hNo7QxMp4S3rhgfc1ox0jA1lx2Oc26cbO7LjJjTjVYjyeDvjYxseYURUcqcIx0DfhvT8psFDwqLsRChCvwWco7Vj7i6FQf3mUhxxCs0b2aKpLQqoy4iEPsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242275; c=relaxed/simple;
	bh=YVBSjMz4xvwGs2PRVw+m14n4Yy0III8Kgb+kgRG7l0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DAQHcN9Bd453qaiEMEtAgTQbbG0hVBGTyhFwFB/5GH3KijLfID/4swq4fuFROSdrb226KAZCJCFR9v1sARrRC0MYIKPEgblWGm7pt0d5gAKj1PXMcoM+DSvRPKrb5hhUjcYF81/X0Dj7nKRytzuwg+oFnC9tTiKPn5C3qpJf5Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OoZulL+u; arc=fail smtp.client-ip=40.107.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIGqMSQI4FtsGeQts0B9orMyMYNvf2MXqmIsbBdiw5QL/hjPURES4rrELABbJSuZGD37hWnIvPk1PCTY3ZhTzk/FWKVqlWZ/K1pB26gUtt2yThV+IY1wQP1ZSgYjOiwMQgYs8BTKaolLCo8iyHD8YMfNw1cBNkrJiXzUQfTlzFAKXRH5Z/HJOgzTahr3Nol8d4K1X/Uk3HCqSbQWRp+YArsGIbwE/rn+2/LwmI0F4WhE+w0qlLbFjleOPNcYLa69tpJ9Tr20DDBWb7X3zHHoS6dAZqD2d1EuGt0vpeQAxijYY1DzuQLEtL8i4XG/8nMHtvW8eholfzYaHmI+jeAIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgIF22dr9N5cHfSHqoggAe1n8qmCyyRhjhPVgM+gwNc=;
 b=vHN/ogeC7NPigPHNFMwmD+7g+lXjDVzBjR4stMgTzNl4OoOJlbcozGVPNB8KtB8KUJfD3Wdqfc1vpCiQz90Sm581vsoLuEQKR83oi0wU74u3dIQZ17xqztCtlULAo2lD7vXbbPC2cVaWuyIRyrV23si8DEsf/CskKG/bQOjq0jDMpTFnS+FNaFLy8rq/UIh2XaZ94hd8BvhZYUCe1mzE1KsgpZo39ptjOnKEatTHp3p+jlJf5doGh9gT1Ah2nB5ZukN5jA7ojhwrfWtUIVgTTPREUXzHoAxM6AayGJjXu2GF+tGyXPN+su2dPNr3xrqthUmA1EAtZQ32cZ4sspGXcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgIF22dr9N5cHfSHqoggAe1n8qmCyyRhjhPVgM+gwNc=;
 b=OoZulL+uTWumfWc8HzV8MHItsOG5DAfgskbfniYySl1z/eo/5C6HE/52cdGtGQDD/IZEh9F6MZ4RG8Z5JzulXjL0LpSbB5WTOkoP5Q9KZVonHiC0/2E0t2nDNGBs7/nPJGsFJLFSmI9/j2m683f1cHws0bFR3aLopbBZ/qBrtYchEuW56oLS8t7CHfwMyULG702YEb0q+bT8NDjRmALbosxkAsYLWzdXqgUBOL5QPC7fkkhjtB/y76+nNfMz78xwfbJ8jyy0usXdHIL0PuUwUuueypti6RSIzAb20YF5pJAmDkP53XyVjmZL8psF5iFi2LQ3i8pEnSDoVovDlrdCig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by JH0PR06MB7128.apcprd06.prod.outlook.com (2603:1096:990:8e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 12:11:09 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%4]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 12:11:09 +0000
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
	Lei Liu <liulei.rjpt@vivo.com>,
	linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH 1/5] usb: aspeed_udc: Use devm_clk_get_enabled() helpers
Date: Wed, 21 Aug 2024 20:10:39 +0800
Message-Id: <20240821121048.31566-2-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821121048.31566-1-liulei.rjpt@vivo.com>
References: <20240821121048.31566-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0069.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::17) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|JH0PR06MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: a71ba735-f780-4049-fe91-08dcc1da5765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|921020|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YgW+4BWxsATBQCwZ28GjJ9yp+yM0cJJNe0IR2XLv15UNKefH60xFCxdmy0Nh?=
 =?us-ascii?Q?G/hir6K4E+KTc1qulfim0/Xb91f/5wGZlSdPKXWNqe2U6OsOA4RMXzKeGzhI?=
 =?us-ascii?Q?0X8b5z2TWB4GirqfDCkeEY0lk6b0//m4HO69KDu7oSG8qwWY585O+OAhYRPQ?=
 =?us-ascii?Q?tk3dD8HBe7XO438VAI0thc055N9H5VJGLuqnRu7AVlNrjN8v7ZWFojKlu9rV?=
 =?us-ascii?Q?GZPgiVoSMGevH0j9g1XCw2lkzcU47lIO0Yp9pnYVcqiIC15ot4f0r/S6IDsu?=
 =?us-ascii?Q?j6HHyZtgvKRzTFaIFY840pm13yyetutQcaKPYmCrtE9mb1i49uN9/CJWfoza?=
 =?us-ascii?Q?o48jTc1GyD3wTGcWAZ/Sb34LHXTaCQObUMclBzZlotNxqZubmwvqti3c/cFV?=
 =?us-ascii?Q?iPXyPdGkhAZ70feaUdYY2D3lUEvtGrRl8zshxSoPgOgPzTIBGP4qWF74K57Z?=
 =?us-ascii?Q?86eIMfkbi6Ej5MnzQ+AzpIO5tV4amwQyDKhpGn7AcJDPl4JQAr/zdYVniSIP?=
 =?us-ascii?Q?BATJIvNS0LrccOpaC8v93npCqf7zRwEuEAvlVyBqKaSx9B4/k+BET2raE//2?=
 =?us-ascii?Q?vTet5kkr6E8gXpfHjW08o8MEa88DYvp4w9lPzd90lA1wvHCbmyXkMV74dl4F?=
 =?us-ascii?Q?EInNscChD/xUdHgrfoQwOPZa2suPz5k57OAG/7kmGIS1hlMMt8YIC0MyJjmp?=
 =?us-ascii?Q?ECf8cZ9eglQFxKGDiNUJGmuHe1FSqx6Uy0aKZiTdB2yB7RWZ1D+k7u1TTiIs?=
 =?us-ascii?Q?ST800tLkvrFqVxnZ1AHiv7r7tPoA+3eIWqkF51rRfsdoEohAVpZ9aAwZB8L+?=
 =?us-ascii?Q?nVdin+5Q1+mR+fsZm5gH8IoGSF07i5f7MaLn/tnnZSmWBHNQlsld55DqavF6?=
 =?us-ascii?Q?gDufox4+bXC6IJtOVC3xl4SJqTtXgvQkW+LnMDQGbnko0kySkU8ydfxypI1B?=
 =?us-ascii?Q?In5yQ1HGQM8tIcme2gfaULdJktPrY573bgwcpZ92r3SA+ZufxhbK+ZHLe1Xx?=
 =?us-ascii?Q?3gqOlpAvuvn/IxCFIfkfnRxta9xNgUvFHat4qDiVBZgDmUqAIBPahcOGBwNG?=
 =?us-ascii?Q?aZOOfC/XH67G8BIhONYJ7edv4uLH9EBjqaThEEAYDW9QaUiqznTZ9/gcgQsg?=
 =?us-ascii?Q?lGgMqlA6nVuYmnL6cdNwU2o8etPQ2b6MPtapSBojDvRb+/7Xu6Q9o+PSmDus?=
 =?us-ascii?Q?wsK+/1rtsXR4S7la1+uKWtUkGq/sVnIqahD5alwA45cmwv6PKVwnKIjUIBsV?=
 =?us-ascii?Q?R5e8pX45wwyIz+dgjt6Zs/84DN3EVW4ISl4Ud2ZZFi9+AUYQ7bQ4YBbTOjIm?=
 =?us-ascii?Q?Wq8IlYhT/QBzJXhd23tmzb89I9EqyQVVggH9Qehrs32Yj6z66ocEKjemaxaJ?=
 =?us-ascii?Q?qoze7KkBmy5MYOx4wb0pbgK1YZ294jKTY5fSjNkU5mRx6a3sJD0HltWyVszf?=
 =?us-ascii?Q?25miq0q2vsae0eohq6iKBmgzAyn+aijJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(921020)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h0xa+xf4L1iQ4W0D8b6CW6didjiJeL2U+nkCobc/SiyKvpUnAR7cnU/I7fOJ?=
 =?us-ascii?Q?X49OWfwFI7IQmT1NQCcXxN68laGZYxIitmOnG9MaJYMG0lnGzkhZOjYv3+TE?=
 =?us-ascii?Q?XBxO5Gt7eVtjyYXLcZm5G62VWG2mgYkYuF0d9MNIwB1vMBOt1TLZ6pvnT9+p?=
 =?us-ascii?Q?fCl31/gdXvCx1hkZJVu3U/Jaz8LyTiUx2VoD59PnfpA5Rplu6EbILJyvlYxv?=
 =?us-ascii?Q?0MyOZV4DE859GmPO+tcRySJIYO8hMem+cP7tpVmFVgPOt3tAe85rjbcVXXco?=
 =?us-ascii?Q?Gbpql+cPl7INEC38LNPfnI5ftQtVQm1hJo+5YQiFr7ByCE6MfGK8qRPah6g3?=
 =?us-ascii?Q?DRaqjIMUCtS4TJdPG1U8EXxtm2aWN160nQlw6rTriTgU/oc1L1wfG5+ghHQk?=
 =?us-ascii?Q?n94IjqDqO/njSOIrRFCyfcy8FGoehqk4LVIchkyzGTTsZHAsUYKFy7PYu5+Q?=
 =?us-ascii?Q?1JdyO9Z5dhvPYe6yMdxBws+/WGlYx/zrZalBgydblPQsVAx38PENOR8OBaNC?=
 =?us-ascii?Q?O8gHZpAyxEXYqK58b7Zf4igzdYC58awKgaIlq9yxg0rpq2KX1xrADH5NFMEd?=
 =?us-ascii?Q?p3Y/nEWnmuZpKMYAri2jiIenU2l3FpSOR+AVu3EWqPIQWR8BY8Ly9Dab6Vys?=
 =?us-ascii?Q?i8n6s9EKGaZA+H1u5OxJ/lp5PjuH/C/2unVleIZYwPluMmj/Ep5X2CIvElj+?=
 =?us-ascii?Q?snf+XTKJfzY5hKlEvOkGUChhpKrnOKdNaXVOM7v3c0W5dE0Ri6pFwHCo6q13?=
 =?us-ascii?Q?9FNA6AE0gZFhLuJy0m4uUWAp7nAP38RBiF7T7gA0LUvv+dWR/XvctGthlJLu?=
 =?us-ascii?Q?VlYJRznXNICW+Bc5bXUfxYQ2egEUy24XPWWCDlz9aBJzW7BqOWStQV/IypO8?=
 =?us-ascii?Q?JCgxnDMf1DJ38W8bsggFOP0zaWyKzMLhkI9ScKSve3oi+EbUuWqDTMoPXhXJ?=
 =?us-ascii?Q?085Xo3bNXw/Qc/cWjlv8r0VH8Xi+PylZaoGj2wPVfjEVas2t29HJIau5uzmj?=
 =?us-ascii?Q?v0+XGPeceCRXIch0aYpJdK8cx1ENTarConiiRe6UDmlo3LUdxoIlWpH4PAiW?=
 =?us-ascii?Q?mAL8om8l2hJVLuUQwfk6i3cNdCW+AEqiqDKt62bgglGcNZYjNBpbMKjF8g/j?=
 =?us-ascii?Q?zikIKlaad2k2bVe9hn+xA4G8fVWPvI0E8BoSjZuBaCesI4tyjbP/bOeB/q8N?=
 =?us-ascii?Q?HeXtHSvQxjsiuE/gb57cX/3KEl0C9fbTqW/2eu23yT8DAWOQpLquhYVX8Q6C?=
 =?us-ascii?Q?YwMzeCqprxjC5wHkXkwcbA3mLc8adMqygLEsGyswYm/2CSSsnnaCuC1UBkjW?=
 =?us-ascii?Q?g0tWxC+WrKSTjFnoDBVUicjJsmWKdPB6EonAgzTT01Ox/G7zmIcA59+Nq5cN?=
 =?us-ascii?Q?L/cO8IzcN4PcUQSlYYGVrDfNOEZn7GBzL7taOCVLb4zUG7goiXVT3atb05oX?=
 =?us-ascii?Q?B1HbD8uZwFvGET/G+tnlDwJ9zR2rTJpXDYTqm8nCidCpyWufGvzCkJ+cxhtY?=
 =?us-ascii?Q?tcd4h00VUy41EiuPsVHbh3ury9Tr/Dpc1Evd8ULayGUN7ESNIkHmsMnQCS5J?=
 =?us-ascii?Q?OheVDNTYb8GAE3BPKmVblBlQo7MTU36mOn0+4wR0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71ba735-f780-4049-fe91-08dcc1da5765
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:11:09.5550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfcVD8M+Rdf7enup5eShrMsZIcs+ONMRfLlK6OH24CnafequLQ2VguOBzPxlyo6YgWPii9x3vr7qpxdTosHYQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7128

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


