Return-Path: <linux-kernel+bounces-295469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A70959B59
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A5E2838C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D991531FF;
	Wed, 21 Aug 2024 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BYm4nkVw"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2048.outbound.protection.outlook.com [40.107.255.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0AD18A94F;
	Wed, 21 Aug 2024 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242280; cv=fail; b=mgc6Lqthqn80vUQnZtdvQE0p+9H8QnJfgYxbNF4hZJhWp8CXjowDsiG+uZff/3AyZZqqOTVc4dVS6Sn9/+GLklsmMnRcY7keAqNiuT5Xc5rFKCM7KF3vtQhua2rPoSwoVAYwZsSaVWmlbVm9p0BLCScwvxYq+edROyKdzrh92I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242280; c=relaxed/simple;
	bh=QbQd0cVebdCg6hOjuyzEtFWQa6gfy+hc/K47uVbCoyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P1+8kKZ6XMdNGeNzii0cdZAodkOFUXw812D27OHT7elY9Xo6vNlkgBNCu23UrPHtSSCKhEYFrklAroiDc7Kz+EKhLupxCZMwaf1MZ4Jqu8uIB1ZSI9mG/QmA5DROxYbmTTpTXs6l7Kd5rsISWP+uIj2WUnBowbhRi1k/LZQ8PW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BYm4nkVw; arc=fail smtp.client-ip=40.107.255.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2BH/4odMp5N1Nlt8AQNcS4w3TFfNWMMCSJvh0P8a9qerxOBPHFIL4VQ4fOUQ06P3PRmYK2MZHoJscQPYQ9B6qyYNpTNnsh/XX0WXyudp95b9gNAswf9G4zDMbD3p9g6gP0zsfQ4CWHDTkI4Mt8AhjbAGDUmDMiAFslk3vNN8RDk4NyL+2Zvi+/JP+fe3iR/hxrR4h+sPlu7Qr34/xxdI6g/fgFiN1IpaO+TwzOqaI0FkX0Ds95YQ5SQo/WxUL1KjJuLFfDfLN2z1o43wLiznDQsSb6SKuZfPeaqDiLOdfCkUGdXV15qRlTHSkDcb26lwaTCH90QgpkPjhQfYagptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBLc1uGom2+Ec7CsEI6xiLjlWnYrDRNdD7beWn6v33o=;
 b=ZrCnZB+QqLaIUWSQmUaBwD6BeLVWtxFF5SYPYMUoAy6x0II/mvtRrhymc79zO3wzZ0d0dhxeaxwXHgwe+FpaZG74MFIWhXXLXFaKRLP2tN1jnIWYzrbyB8x9w7Uw1UFYEIbmho/YEM33lDILK0Z3R1cxHMnC/03uhWNqVMrY0uXREqWwgzMvzpjY3Gs7XNfeaaxvkzQzrAWcNmGxuBd3/AqSC8hG/uxA8BqKQeHc9M7oqzwcNHB7y8jM9yYE3nSswKyZ2bWPfG990f45xduxwbrf+3fpx/EG6/HhZ2JvWpiIwQD/u79m2NYGdggpC9m3HT3i0xDrEosiCV7y4DQRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBLc1uGom2+Ec7CsEI6xiLjlWnYrDRNdD7beWn6v33o=;
 b=BYm4nkVwgHTwFWbc2+e6Zs7UMgkp8nL0mofeCT6tMDu0GqhqorWoPuA5vitDX2VEUgD03uknfJF70uHtF67+GqhoCdEoc6JtdURFeXGG0hYF+pxqmGOveEkrRfv9p/42MxwFp6eTU5KP11sT3Oe0QgJ7rpi19wn8w3l2iYp30Fa3ToB54FGG0OItlVJbxT6T+Y7cnKWDeBQBRVOXcj78j2BtYKW7xuRyS/i4snkILnBEDxDn69YI1IBLKZrQzJe/u3PWZa8eAVbCoCsPGyIRDP3yvB9odSg4AYODbZ84E6rthWuQendNZ/qNgZOFF4fK7jsGD7hRq/4xPMK7pgHqYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by JH0PR06MB7128.apcprd06.prod.outlook.com (2603:1096:990:8e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 12:11:16 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%4]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 12:11:16 +0000
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
	Lei Liu <liulei.rjpt@vivo.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH 2/5] usb: pxa27x_udc: Use devm_clk_get_enabled() helpers
Date: Wed, 21 Aug 2024 20:10:40 +0800
Message-Id: <20240821121048.31566-3-liulei.rjpt@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a8499f9f-c4d8-46a7-30fc-08dcc1da5b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|921020|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7WRG9CcCciQKRe/l1OhZyVkEc7+43XVM6AnuCvl62GCu2aRMrt4tE7tNbQdZ?=
 =?us-ascii?Q?Cql/vi91xLdU8/3+PxGT+wa3ehUmev6BTufZVY2NEyhG8thxSLYJDNh6yHHm?=
 =?us-ascii?Q?8moB/jrRjRb/eTpBFlqW+3zB5He9rZmt3y+Do/wIemF/6LIktVAGT8hx7eA3?=
 =?us-ascii?Q?D6TO4wclcleT1HJmRAQ+Np6lP6W/tQbLLycYCsCbHvOqIVZtQxCz4Qi+TVQw?=
 =?us-ascii?Q?taBpJwhcT5KDLVljJCuSrUp7J96RKzkWYHuiOJRDYs6kjiORTbz1VIHvk/0X?=
 =?us-ascii?Q?yphQc3Mr8tRXJQGSwkB78iyFIh+YCf/e5lrTQCPpi1a9g5aY0+qHcw+6cfn5?=
 =?us-ascii?Q?rlo0bQDCAuPqPky8CMN4ksZKokp2vUKgtWUHG0FrxJuzdFq1FV8oSfe8Hd0P?=
 =?us-ascii?Q?iTIqZwHmEyqDhhXAiKkIYLgTlj2jFnGtGfv5HrpneMHrPCdtOPD9JYs9f0nC?=
 =?us-ascii?Q?/SGQsEEUx5cry5CDC0R3nnmfFlA0fDMZ9AynS+Oavj8147ZqeV7RntETggCU?=
 =?us-ascii?Q?e8m6NxmPWx2L702jXDt7CgpffB/Akpc9RUuqOqftPct1imN1y+GyW3h9DUPe?=
 =?us-ascii?Q?MtRdT2Ili3VYFAaNgynTU7P1tvkyUfpuOBni3qmmG+wBOsrPtR3DAWhbR/tH?=
 =?us-ascii?Q?kQj8CFfxUXPhx1P7k/WYvHcQiI2hDRlO+k2+22YGVEh9yC1Ygmfv6kaz34CC?=
 =?us-ascii?Q?D53zdYutA/YWDxwVPP+iONBNp+gVNDV8t2xUSFWqSl2P3FO4mps0UD90MRfm?=
 =?us-ascii?Q?5Iw1HyunYlCtwq3OEv4dnY2Igoh4bJZ/sWqBUWIuqhbL9a+ShCr26Kb/Mg6F?=
 =?us-ascii?Q?Tw/0kCTEA1fkkBWOGI47CV5X7dHWXkDKgMBe67lJoaFo6fprj2rFycfWcW+b?=
 =?us-ascii?Q?6SF4Wd7VHd5O8w1KY5cfln0C5QWf0WALZWgvXxsqyrZktlNUUUToRProne7I?=
 =?us-ascii?Q?kMdEXdAROeP8cD/bafGxum9zckgvWpbyiyjV9Pk1K7a7BoGkhF0ysY51XrPF?=
 =?us-ascii?Q?vOU9i47i8r2o9uIo9O5KP5/RSC4p72qwyvPaQ9XAa5LYjW9wn4wutLYTE8J8?=
 =?us-ascii?Q?E2bxAfVcEpKi2I2GFQNueIbwV3O0ZtuRWxVhAcXqaKT5kVzcCNo9vAllTu05?=
 =?us-ascii?Q?M0VE6oN0i1mvSrjKKQ+iTiP+SxwEunU6krQu+iN+VMfXBpkKju/dAIwFEP5+?=
 =?us-ascii?Q?l+s5C6IIQSg3AnL1FpDlHU3Apgp9XoupWA8+IDwAZchnYIJZJvjAcLTCjJmi?=
 =?us-ascii?Q?1T5+zx1gJXjiQYnzxRavXqn+74qSZOiYTbWp5qSl6eYjBRnncdM6p1hB7dd6?=
 =?us-ascii?Q?TgZastbm/NizcHOZbgH31CzFn3x5KfOQ2/kZnGnDtQNU6elw86fwOsD7mQLW?=
 =?us-ascii?Q?Ck7J/L68/W4ZxC4nlKcA9QEqLfuc548WkvNWmBr+6dCCNQAmhg0OeFVEKxAI?=
 =?us-ascii?Q?Da8qwYPgJYJFQV/HM6yZg5la150uA0sq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(921020)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9fL50Y0CQUpcCPwtF44Kj8BMAd2JeaPowzNTh6JXuC6zBRCOvqa9iG9dlT1o?=
 =?us-ascii?Q?GJpIrhSQyVPLN/bAsnBIb6Lv0WMdZhCtRv8zF0jQlsgvcG4pk439XdS9JGEQ?=
 =?us-ascii?Q?mreByfLdQS8dNV470CYK+XBqZUMoHP9/IyyfbVVHjIa7V5DY0z/6uC13ylO9?=
 =?us-ascii?Q?kbsxAFLQeAkRHP15Otm2YnXh5fCyFeVNGa4qGRC11i65wFbvuVycincHNzqa?=
 =?us-ascii?Q?OwTICpBT6Pjh5NrVJekyLbmBEBq7IM3SZ1rtX5hC4WdTMbWlDik7SXAylgTX?=
 =?us-ascii?Q?7qj5iCHinQJkGEKP62SjGg4X1jkqTpjFrEMcT4sq1s+lsONGL5THTPDjRTHo?=
 =?us-ascii?Q?Wo4DyFl585Nnuj2zTPZ3x3YajJzZymfQs2md+DpVzPzxTeetOnROb91jbDph?=
 =?us-ascii?Q?ibuZqaxEiJROeek5t8ospNxOWpVQqYFRM7kBx7+r/YMczAcWCusu70YzcGrb?=
 =?us-ascii?Q?aJfVv8TTS62IwKOPBHotSlfPD25GVJs1w+5X0WLwRe28xcg8FJbPI2xI8F3a?=
 =?us-ascii?Q?oVjuAHwPiyvyMXxaHyhdd/k7ISqeqwk0ozg0GIUQWq0G95f2hOm+jdhOtzuy?=
 =?us-ascii?Q?GZxRVVpav7XlBsGHBR7pQ7GcSNw3Cby9DzHJ3f848K/N31W+XH912bT6VWRt?=
 =?us-ascii?Q?ZiDh+GZwobSPDv2zKKvLKTCwKRSs/mhCEx7QxvVdOW/EeVqhVIJihGR3B4w9?=
 =?us-ascii?Q?AD4ojwvFIx/gbkvcn1NgggPi6JV12ounnkEF/q+9Mrk0uTsIISxnPXPvppLl?=
 =?us-ascii?Q?75ORFq7A5lTgqbHNeM0JIS4vc711JLMnrhwf9R11UmN8Q8CZjzs1m3Vfdsz1?=
 =?us-ascii?Q?w2PPiX2o/GJlX2n7breLlrEzADHR4DrtOApqbF801wizP59TEciTqpXAoWX3?=
 =?us-ascii?Q?ZtIj8H8XHJVYUvfxssHJfXXJQQScSXNQjmjhu3VxJoqm030MT3QxSWAM3EaG?=
 =?us-ascii?Q?JWdgiJN3UBQXAnltH85WZZ1p+6yvLhqhxGfW2vDv8N+12vjyOXbd7velk4N/?=
 =?us-ascii?Q?qrbJu9pC8CdFNYw0lCLQeIEH0L/tSN3bBrCUzEpTvH48QJjD+u9rM12/ZY95?=
 =?us-ascii?Q?SteVwRFmMmVCcvnbuhRavWJ5f6m8J2UJQmoiniu6S1qQnEUdM0O6+ma+e8kc?=
 =?us-ascii?Q?suyWp5cNO+LL4QJSQDB0gqqZ/JPbHTP1ZxALoAmWapBKQfPz9yytH6zzUIo7?=
 =?us-ascii?Q?pLtDSzSt0aBWcNOR4/9Ka8zKsM/RNpMlwFaxqIAYfgFS5cwG1BFyS3DHRoov?=
 =?us-ascii?Q?VvupgR4w96H9E0J17vsTY1N6heNCGnhcagID3+D2DrbRRQcNchpnT89Y8dsp?=
 =?us-ascii?Q?hS6UONHk1u6F2+2fKBhjOydl9UaQLnas86j2vlUVRDU6kG08WVsJ6fTbCC/2?=
 =?us-ascii?Q?QLkyIYgOq2EDcbZrdJCOMmRMdnc3fj6qMaPhedrP7mXAOXvuuTU3fiVNpzKQ?=
 =?us-ascii?Q?iNBPogvCLQd30YtrQ8cdrdRFjio5EVFHE0cTAQBjSH7H1WKVb2fCK1VfpgmY?=
 =?us-ascii?Q?UdRlfLUIJa/zq2xadX1SddnGFEWO70Ck2FJfGZEOxSmRt7lxo1pW35h8UOjo?=
 =?us-ascii?Q?qQHAFEh4GSAuZAeCxg0uOkVr4YfoDF40eYqgzitE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8499f9f-c4d8-46a7-30fc-08dcc1da5b4d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:11:16.1087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJTKQUcd7Sq8UMJHMpp91olaq6Z2dzT8ME8uJxBdl2+usresG5qzHs3WL2pfEvds7Yz2v0+4ylkfpT0bjnYKsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7128

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 1a6317e4b2a3..6e99e75f1acb 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -2398,14 +2398,10 @@ static int pxa_udc_probe(struct platform_device *pdev)
 	if (udc->gpiod)
 		gpiod_direction_output(udc->gpiod, 0);
 
-	udc->clk = devm_clk_get(&pdev->dev, NULL);
+	udc->clk = clk_prepare_enable(&pdev->dev, NULL);
 	if (IS_ERR(udc->clk))
 		return PTR_ERR(udc->clk);
 
-	retval = clk_prepare(udc->clk);
-	if (retval)
-		return retval;
-
 	udc->vbus_sensed = 0;
 
 	the_controller = udc;
-- 
2.34.1


