Return-Path: <linux-kernel+bounces-206142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8C19004C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AD71F24173
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C50199EA2;
	Fri,  7 Jun 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="leaYPTqa"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2052.outbound.protection.outlook.com [40.107.14.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A18199E85;
	Fri,  7 Jun 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766727; cv=fail; b=oQd2GaNJCpufdyEhB3b1dNwKWOS1Zas4Saq9Cpoxb0E19wkG82iQ5yxVxhAB/D0WIhfTELxo5NO67DhSJNrMEEXf4jYwQAxwXAyu1xPh8dVye/cKRl3rUwQpTp+IjmeQWX7DMYVVoEjUdeGkDkEcBtys75WGJJFGLkLynFSD9Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766727; c=relaxed/simple;
	bh=FBJN82pkz6Pq0b5cwuc8260LZ6GD/ee2+ga83c6yyTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iBdFGxNSs5l5Z2xaKVGESD27fdO7d5zCbV/hwe0yUeORiQAsAgqAawvUJvaJoK8uVTjFJrLjt5Rm36P7CB+OfxXswTx3iS0YjTq2cpeP04itx/xrc05zKG3Zp7iHBru8sUY4tedLsJkMx8Z2pJNm5fNZS0Brt6O0lqivFDsRKkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=leaYPTqa; arc=fail smtp.client-ip=40.107.14.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAsXWKtdaJcAZI3zLKfJC8un8ZagBQ0xdLC+FHibB9ClJxsw6b1nVgzkIlwSxIHiJcIzOn9aINm3x/5RoRH0Do9AwV+BoXDpySrKJEpp6ODaAN3k9AUqG1BBbRnCyuI2eBY+zXPw26U8eYiQVHux+zmXY286dY7WVYteIsKX7LW/ViNlDOfOqGYG4/Dh8UhCs/rfDhme6692zNiUd9GGxxoAo2mo1sx3sQFNZ4AxuyMS6CaNsLXmgfBaUwJYJyMDKxsueymWdPLX7KpRcMAOGPCD63CeZNpcGQnc1cvDWIqJ7yt7jNmV0SCmxm341BNrybHYxsa8bke/gkGvB4Kw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIFtopC6uZy5D4zmlfSuUSyVkgicTvUQocI0PE1CNAY=;
 b=geSItsavhw6CQnXYRtTmjcd6i5J27oO+IqG3eI+wZ9VDujFYEn8sHpEE5CuSAyf91qzbEziRwZV/vG7a6J9Vy1mt/uR6A4Z9V4F7o37y4D91YzaYi2H3dKAZJENOSHlhvshWIIOoeMZmDeZCTz6Kq60gFXSBj94NrdN7JwYI1ehJIyzMM8pGuCvCexshL54bzi1Cd0HszDjVOz9ZJ/CjYy5MqU6jqljiXQR2+oxr5O0gyW+kM+qFBLE8uc3x/534v+P03lB2CsZ5zMrQVdsksOMkHSR0KA5fLDE56Hat6Tmvruy1iK+/vsPrZDafPb1HBT3jnMwSEKJZMqoqMKUEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIFtopC6uZy5D4zmlfSuUSyVkgicTvUQocI0PE1CNAY=;
 b=leaYPTqa4r14bV/7qkK22KoUNiw2hyAzVmVWvizYgBqcPzDr5aK/7/iCoar8KtpJP9mC4oRX3zgbHVC9XxAOJL2bISQPEV2zxGRkHtQbUNe9a2bS1VfF7TfZ8U6aKUdFu0yp4Rm7oW9pzUWd6lhnUwdWXWByKNVfaD3zB0QLErw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB8944.eurprd04.prod.outlook.com (2603:10a6:102:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 13:25:22 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:25:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengfei Li <pengfei.li_1@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 04/15] clk: imx: fracn-gppll: fix fractional part of PLL getting lost
Date: Fri,  7 Jun 2024 21:33:36 +0800
Message-Id: <20240607133347.3291040-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
References: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To DB7PR04MB5948.eurprd04.prod.outlook.com
 (2603:10a6:10:8b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|PAXPR04MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ea0baf-2ebd-41f5-40a5-08dc86f54820
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sBpwXoMRC5mgG6AmZy/yqr9xB763aHueT8AljzJy8hgApGdFBK6SNfNaloYM?=
 =?us-ascii?Q?B15W7eEts8jT3RO1XdWSZsbrUpA15vH6b8jD/8eqkaYiDX1L8Yg83XDQlrKZ?=
 =?us-ascii?Q?8qNAgBLDU020/jk7UQEYo5o4vphd2PCH+AK4pR2Plv7Hm7wnfiOiHpPPU4qf?=
 =?us-ascii?Q?jk0knZ43tK6AD10ie7LdvzgeAAYmYvZm6vUQvYje6C5cjfUNlIYZHNeOZ7Hh?=
 =?us-ascii?Q?4TcjaQWUf+/OiC59BarCQbgTFGI+4LQupG8SykEEs3+fB41ALtSfZvNy5cqK?=
 =?us-ascii?Q?iS82caRJZ9sXauH/F7VSMlMqeiLEFl2GQdHfvuVLe7M0D0aChI+sl95teryd?=
 =?us-ascii?Q?B8wom+GRg+gUQO0wbsF3gFFeRDLVoJvdIFtX0bQ7BD81jiMogisj0UbSp/CV?=
 =?us-ascii?Q?Koc+8hY3JhRorvezr9iBHAJ9+CULFW7tGtmreB+fpknQhXsBA7kvhhNQRdwB?=
 =?us-ascii?Q?K7zdE4kHG2bkGLglQCXTdbE8sCkm8oVxl0IsBkFXFjFLglkd18+9+c/MQPBx?=
 =?us-ascii?Q?HgGHUAKZ0nT+lJaGInDXIl1d0al12frkL7AWd84lK0qRf+tXleQ1FNPshfgB?=
 =?us-ascii?Q?CLgazz8rRbHUx9DEoXOCwiWraSEhFrdGvjv8tDo42t4kM5VVRnN6uPj9TaI/?=
 =?us-ascii?Q?vglmkFGag9z6CSyYtH4bDceaXELfKnuEjjbOxBH1J2ZCf5DxYhSKsO4qY2UW?=
 =?us-ascii?Q?JGDf9M4kMiEDDKRaHgHRh5htKU/so2hko5q22gQ0WJRSqNdiMbaXnkvm7bsc?=
 =?us-ascii?Q?uwhjpxStmDwJBZcJxLSkBrGCxzzN3Krh+hRSoDXel6NXtPyaGIuGMh75bbll?=
 =?us-ascii?Q?rtj1twbJLUmQ3Ro2TYnoyakBkq4C1CpvHVJBE5wjZcFaR5CGyJBPr92dhS7i?=
 =?us-ascii?Q?19D7m25oNegqkh4qWTEcuWt4tEqZTpGPtNBktNAD7WQBZhi9e9awRJgbc7zY?=
 =?us-ascii?Q?8eAelssxJUw/O4y/UCKH741v98viDlp8GeL8HJo4w0UhHd0CpGbZ7vt7ADbH?=
 =?us-ascii?Q?MB3zoVPrbffWJBxF+qD6i2GoT3RsdIhWtQE4zNOcVMVBV76azUIxtInW3ASC?=
 =?us-ascii?Q?yxgAnev102+D6Q7jqEVM/3feIOmPa0oRETQ1fazZkImO9iKP0d6ZnK1U8E0A?=
 =?us-ascii?Q?+pI9DFHKa7LoXDNKvaOx71r5nEus/Ru6gdJvlOiR+vTDh3S+CtIK/furOS8z?=
 =?us-ascii?Q?mQjVS16BLyPYPni8HKTOEIDpAcwbFssFj2b67UJQZVcwAA9bV/yM6x6Uf8+0?=
 =?us-ascii?Q?t4ZDP9CMdoQUeVZIImWp8ckD/dVNFKAgAQcid0gubEmAQl5qrU7JcH/ac6Fy?=
 =?us-ascii?Q?2J0+2dAdIBCGbhiFsqWYIsEobGIxeQU7/pWtC4hZjXnxMAtAx7OzaNIoG8N7?=
 =?us-ascii?Q?q4CPBwY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b6Z/p5xRgk2JEA3mZBmVx+PYS6aBLVSXoUOSyOgFpxqpG1Yu1ECKAMo4niCd?=
 =?us-ascii?Q?3CM4kc6dSylmgyTZeEjfTjG5GFMbS5xBWtZFZOBnNPLvOX3nx3L52Tj53w+q?=
 =?us-ascii?Q?kJeeXtuR6Xkhca6Lwr1WUc2LGqdLNqpJOqZ8HqoI3wDQtJncDVyv/OZ3l+e+?=
 =?us-ascii?Q?1S2jMX4nnZIjTelcMIjaRNdnJNFCb/1WP8YYt9OkbBpAGRLrM6bEvPaUdM6Y?=
 =?us-ascii?Q?hgyMWVSAdgUpjS2w6UWUvxLAAhXO2LkLbh6cy8knbjko6/HvsgjP9Ddrp3U8?=
 =?us-ascii?Q?Gpr+GabXVSBZH5PwzVwbL0jcbaTU7dRCLI2qfEPc0TmW0/FmVcIdMSD1/UNE?=
 =?us-ascii?Q?Mlz7qqNXJO+RTAZSL3GGdVlsRnSvrUDwCQ2JUMQr59m4uBzjor8/Q3ZfFhfK?=
 =?us-ascii?Q?BKy4Z3SJ5EO8oiOPOLkr+u0AtUysUmdwMjNZg932uXqEKi+OosCxBja+aZWT?=
 =?us-ascii?Q?IqiyhNQZPcP+ti+Ma16t2U8k2rhzClPZAU7vPKjVX76nkPQFDxytOIRzaOXm?=
 =?us-ascii?Q?Jf3hv19v9yxRQFD6mn7D9lmrow49T215hVzqPSCJy+Tpx/3M6DJ7f6r5Bq1o?=
 =?us-ascii?Q?sfFcjsruISEKOLt/t7hVq3yIPThVGHVMjiiD/3nfrknI1MVo50d/HGqDUQed?=
 =?us-ascii?Q?Av9gJ5PCAhr48HLGF+uXT0XWL2Zfy1EEwR2W+mm4Oess3u+mW3Q448I+tL5y?=
 =?us-ascii?Q?2VTq/i4/WF054QKIR9wGZ57OzomHrB0TuFK2iL4uH9exvf6XOF8R84ugnvI+?=
 =?us-ascii?Q?QnxfOrgrRh0508/vFxZK9g7LMdrDCDCZa5TmtrHBllvlqjVV+WBKIBXnyDvy?=
 =?us-ascii?Q?IV/A8hHbJCeZDsrGa7Bf2XFxUUtvaSIvZvGqhBOVMZQ7BbngJRyJdB1mJfPp?=
 =?us-ascii?Q?LJ8G5J0Y07mDztMePpH+gUn1Vssy5qY0Oun5cAHC1tlsicsg390f+hZT+AMV?=
 =?us-ascii?Q?+Z3eWRqdRTyVdLE244EpdZP2Mi7ds5CTBx/MZg+GU6xZxhReacv4ugQ0IDGk?=
 =?us-ascii?Q?+V7N/OVY/tlDennov5k9O6Ic0dmQCaBIs4wK3dLfOBCBA+tjOcCuM9zoRc3A?=
 =?us-ascii?Q?0YUsc5GO8HJdrLOlzWKvewexZxI3k3tx64cPF841p9nMmNzJog4HS0yAZlA+?=
 =?us-ascii?Q?8IhkRgIGLTlgcHylEmByiy3j/QAWvqB/qeatd6xWbqGfJ+LldV2iK70PJiUs?=
 =?us-ascii?Q?faopg+x7ZZXVAoS60zjFPBMY7aatGBJf7GmvvkFtX1AN+VMhObX7U/os3Fkl?=
 =?us-ascii?Q?Bx5LvhF5ePOmhQBJ84v4cEsfpDgVAPYK5Ebv+E4tqfqaI1rlNMAwqLBpY60B?=
 =?us-ascii?Q?F1Be6PS43Rp01+OaIqsNlR/PiPQbnjPPCXKFvr0WKHGsNqc0ytiJUkG71XZU?=
 =?us-ascii?Q?kPt+U7ksE0W3wKvvMajDN06yzU3pCtziJDw+w2Z0t4g/xWt4HVvLp7OtmgJ0?=
 =?us-ascii?Q?etVE5jdNj6DlEQ2/arBwco6pLZjBC0pxX8UK0uuNCfot3xYWyG0lDac7YT8b?=
 =?us-ascii?Q?hTyZhhJYi2Ty/b1Ki3TZRCOL3T8vlxZjfgMYXhYiABaGL2enVvivSnrGCVWJ?=
 =?us-ascii?Q?jD7zBXwBxhnsFiwMG1Z0UWqIYQt+kem0Qg+PIJXj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ea0baf-2ebd-41f5-40a5-08dc86f54820
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:25:21.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pvmuUIAxKQZcKHOD1vRMh/wPRsctinR9lMkzV5XsudVCUYyso7XIdHeUtl3gYTq/gGnD4BjeGaUnZlPGT4Q5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8944

From: Pengfei Li <pengfei.li_1@nxp.com>

Fractional part of PLL gets lost after re-enabling the PLL. the
MFN can NOT be automatically loaded when doing frac PLL enable/disable,
So when re-enable PLL, configure mfn explicitly.

Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 44462ab50e51..1becba2b62d0 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -291,6 +291,10 @@ static int clk_fracn_gppll_prepare(struct clk_hw *hw)
 	if (val & POWERUP_MASK)
 		return 0;
 
+	if (pll->flags & CLK_FRACN_GPPLL_FRACN)
+		writel_relaxed(readl_relaxed(pll->base + PLL_NUMERATOR),
+			       pll->base + PLL_NUMERATOR);
+
 	val |= CLKMUX_BYPASS;
 	writel_relaxed(val, pll->base + PLL_CTRL);
 
-- 
2.37.1


