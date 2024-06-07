Return-Path: <linux-kernel+bounces-206152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125309004DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB1028FC3A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D15319B3CA;
	Fri,  7 Jun 2024 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="L4lbsM2S"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9498A19B3C1;
	Fri,  7 Jun 2024 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766783; cv=fail; b=XT8zhb+F/RxulV3Zdt4Sc51XkksARJxibZOu13HXyZw7KeXS06KiKvVtMUcxvydwIeDrijpbx8ssbzj5sjd3ItT08NomY8MOmeCQEo6Gx/y5wL2EIdBjzW3HpP6W75rpVJqvMpldP2NjjP1vIudpk76WqaQWkZV5x1kwq3hj96c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766783; c=relaxed/simple;
	bh=iZV0LRzWKN22yHxc6nFw3hup6WjXSOj5tbmG1Ry62yI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ICqYhHTPayTFyUHp89TG4rsnTkq5+7hu4bv2+G6SILwhrGKkEbIFRq90qtE8Gl/9qFoRJbHBQfB9VMfo4FiR+E656l+H87vT19zYWQCepTYCLpgo1sF4t8//IT5XffTMuyawaUNvoiYECysgT+w92EZx5PwCaRtmSpe/yoHNbQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=L4lbsM2S; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxYfWaannZwfVLIP2omKXojg696AeLtEbjauKeS0nrF13pb5wZ2Vg4y1IZ72cP0OuBKrAG8LL2ayDzbRaLLkbNIQSSiOIOfbUlv2BnMqR+p19Wroo7flg8Hgri+DPglPO2mc4Y8G/JHCimvnRqCHuBGVO41qVuY+jLEX7DCt8SMEsiT/JoIyB6pEZMgBV50hUHkRLPnpZLjaKs1gy81GLXrVnzNhYXI9cFzt6a+GKOofOhDjWsqWfCzTOMg9I5SaufJ7P9JHI0yvuXLJ7bR7cBx0HP3n/FUfgc4Rx6Fk/GMos/pMp14YbKRtPNdROxQAwJp9H6JSrE/lKteUKstQIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfmgVgc5egBUleBsLKC3hlNMM+P22q8xHoHwc+LrEik=;
 b=eQ5bEVmq9oPXV3tudolOUYfjTUxrg5PUJkLWpIqDzbh5/Hs/PHgBY+khAdQOYhLgN+pxuhgy+T1MV3V5xDJ6olpgwBvj+fFtF86dYNZ1pZD3+EgR/mS3FrXIM6V3+y+1DR18Sg3qKB2RZJwfJzq8xcdFQnzuFREv8elnhQZbQXBqvp+MC9gMjTTMCvToa08KywkffpbGE+mggKQ5N/3Usy+DfLEtfsT3O3yXXSPRuH5St4UzdZT0JK825XyZKb1378y9XFFI1mzl7h1aKE0M9N6vPwG6f9zyoDWJF0ZgCL5Xdhkf4mCzmi5qc7WXd90mo55qbKvy1i0txHQonEmESg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfmgVgc5egBUleBsLKC3hlNMM+P22q8xHoHwc+LrEik=;
 b=L4lbsM2SFsTabCJ1fIoKlNfbMR2GCmwqYoZbK1YX0Q/No49kZQKNt6/bN/NywkM1Bdat2GNTWJit6ypBx4Viz600HbcW29odqsXSbTE2I6oCxgGa2dU9NOiwevH6e3PqxCr2oyZBQFgPtNxrdw94FPkCkANGmrcVTIL6Wm5aZlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 13:26:18 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:26:18 +0000
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
	Peng Fan <peng.fan@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V3 15/15] clk: imx: fracn-gppll: update rate table
Date: Fri,  7 Jun 2024 21:33:47 +0800
Message-Id: <20240607133347.3291040-16-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|DU2PR04MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: dc879646-acb0-45ec-2458-08dc86f569b6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|7416005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MV4e87BOiRIMh3BBkF6LGRtvv8SD5aSD9rpIVAzUzG8n6plkv8cgeZodMp4Q?=
 =?us-ascii?Q?pjN3RF7bJBDP6iQiYwqTVoWQyJdsWFL8xna+N1E4Gs9yw1q0k0nTM8+8xMFq?=
 =?us-ascii?Q?Qs1uLG8WF8PvTjpXTnBECNTdYDA9CTOHWlYPWzL1Bi8xV8sP1znZ/ZUucamN?=
 =?us-ascii?Q?RvcLdJ93hN64VI6F/NCd9eQEprVfhvHbof4okVmMwQpL8MjhTN5NcPQHUUaH?=
 =?us-ascii?Q?8yIwS7Bwn8mP++0RSTzGFH/3tX48wBV+9eN2xIq8sMEcyYH5xGtaQCPs/z8t?=
 =?us-ascii?Q?SnCgTRdkhRrcs4GJhthZbN7TCTm7M9GlwaNzF+LJBmdRbYj5iPtoBLM5u/1g?=
 =?us-ascii?Q?xn3fO1+ad/7GmltNHelEZpvJlw53ypgb5NKI+QsYqzWePMgcP2Rq3COcM6MB?=
 =?us-ascii?Q?HSQz9JRt/6aXFp4glL+d8wcOcm1ube3oAJZu42cT0YKS0MH4CXa+6A5n4CTY?=
 =?us-ascii?Q?w6TL7xKk3lubN9J2NsHG3/L+FeCTl9FawYBXSsMap8LrvD+wKKdbt7Z0AQd9?=
 =?us-ascii?Q?BIp06CkgVEQmUWori0vrv9KVH+nWO8PDpBlDkIR6D1Iayd9CeVwVGbDTyWOB?=
 =?us-ascii?Q?1TXjiAblv5Q9z9AUdQIW8NDHuPP9lZduJaIcLr+caiMS/tcBxf18ONLGimFp?=
 =?us-ascii?Q?r9O8T9uWOXAM5Ke1x+pp0FN1hIgCJLPJFBhkVXhzrmnmDsNf+xZoAmyU++zd?=
 =?us-ascii?Q?cSOL3YNth+ponTzJlvwkfLYgBBf2ZJet7g52KZUl4l3a14uNWRTfQY+gD6Xl?=
 =?us-ascii?Q?w91y0mMGeaNLnI/PAw2tH4QirDsHD/FPcsdQLucBCncsT7dYoJr4W8zM1QsA?=
 =?us-ascii?Q?RFOJ/Sm5yRf3e2UDj/974kS9efSXZPGRegBFnLgao2QYdX1X2iiN90I3kDK7?=
 =?us-ascii?Q?kuTa/PMzdJ/HuofnuSLqsatMYcwwihPgKdGDwShqWAyh7cKGmL/gErPU8Ij5?=
 =?us-ascii?Q?2UNm/xw+fsgo55AB+XmNZn6lEYFkBYcn3it6j5VvDgkUdfHTGwyGX7OihoRh?=
 =?us-ascii?Q?HtL5dsBIR+533PnckVnuGk0yNQqoD5qplDPLkVHmoWMmQteIJeIPTz4ehfqW?=
 =?us-ascii?Q?1usm62og9UI92Bn30MA0G6J7l2vUFHey+Q/lgwaDPO1zlYJbAoS3uRrrg6sr?=
 =?us-ascii?Q?+TzKnnr2pkZBKcDLtchS5Iw6+34LFqI1Kz1C8/oUS0a+zxYMjPdKP1Bjs2gt?=
 =?us-ascii?Q?/Otdxh+cnFY2zB7IFVvzL3p0+7TmHxN2qNDoqIo9R0BN/jmJT7AsJwpWs/Vt?=
 =?us-ascii?Q?js9W3ypem9ifF4ER/cD3YmR6+UKFh9IQEjwbzgDrbv80FajWSo8H2y05kLPJ?=
 =?us-ascii?Q?zWKtA9L/yWngz8WFtOT7mrrChKv4hpHMesqDZey5KgnvWEe68ekK4yEhIae+?=
 =?us-ascii?Q?TYYThr4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J8+CmM/rwt6aVLWVchwwfPINCzydELCb1nqTFj1NNiMpKXax5nFN86Q2xtcg?=
 =?us-ascii?Q?mEFQvV7q5kmiA11Xwn8rklcw9MrsFJly5gbrP3m6rJAUGfLMHA2t5O3mFwHa?=
 =?us-ascii?Q?9UtzddLG14n8liLGd3zHtzEV3Dc7r+SafWpMeP2J1QV4bD6RGKjptZ8PNw0t?=
 =?us-ascii?Q?NY/T+jJJ3Zc7y5C9VtVTdfBb5e99Ty+IZLBcm2pAQnB3JgE7vus7oB63DLL7?=
 =?us-ascii?Q?A+Rdx5p3TnXK5edMra5t8l9b86PI9Dbwsus0f++1yw1I3Qn+JqaY/9ha1HfN?=
 =?us-ascii?Q?rx4tH6+3MUY60lSYBTfVRYdjMtgtkomxpNcUyxZKReCrKx04Nfg4rDxsuwbl?=
 =?us-ascii?Q?6ZEunspKttxBRZHkq2gN9y+L0KRSTFoBg6UzX4g1rdHACOkWr2wm/d815iWZ?=
 =?us-ascii?Q?/0/AnN5cZdI/10sN8JLVw3KmDpM+TkIo/pq7RijpS1a5LpNE+SK1c2PVle+i?=
 =?us-ascii?Q?fqtxjV2Akh98q4toJIb8aTij696JgU/THI+KdlAqNAJYBEevd0bDZ3Us0nJd?=
 =?us-ascii?Q?FV15ad7+VBoU7anHhq9Pdr3sT3cD/VZT6H14cJ/wM0QwYp593uAh6FTHVMeK?=
 =?us-ascii?Q?MiIU0zlRbJC04m9mZUYPf57AfUraXzPIMVwsrNGggCnjIC4aY8yob1CUY3+p?=
 =?us-ascii?Q?FUVckVoFbsPJx8m69rKfmM+p/hWN8tMmuG+S9uVxe99IB4jrscFU1DIGZLYD?=
 =?us-ascii?Q?c3zhbyioZ2tWNMaproKDUrw/PwxwmmnU/lSdyt8j222Y4g/YFtkWmbs5I0R6?=
 =?us-ascii?Q?9ihohMeW5XhpEAkT0Iwf1xn57PuCTpkP2XgkHS434Nauw9i/p61mQciMq2HF?=
 =?us-ascii?Q?3Jipmofjt2xtxypEmBmSEQXDNr2HCoHmZj1QOMjAI7EOiwqE5+JxqZ6S+DkD?=
 =?us-ascii?Q?Q/9UZ0esVkHZH/+j9w9zRyFFdEb4MM76JkkEjMBExkCedYa4tInsGUOE44KU?=
 =?us-ascii?Q?rTjNXqu2Lc+FA7I5wPo7zMlwpgDcYy2Nr8h08eIgYGbZbXu70TjWs8iKpulZ?=
 =?us-ascii?Q?iNfZaOaQdlPjuhaw75iryfRwHourBdAfmUX2Sg/nBlDPfB+dB/7vRcfH0hhs?=
 =?us-ascii?Q?wFJ0LxMZhn51IlGAyoPHfID8fdyu4uP98q9rLNPREGCCO+1Zqr8VxB3XQm2l?=
 =?us-ascii?Q?Mr3bKP9+0T/W+7+M7V/UdvaTQkl3hvIRh9cvxf2Ja0HNnspamonB97VD3C6D?=
 =?us-ascii?Q?PxAGlqE47U5Lnpv59vY5kR8JCDEGxllrAHuuZhac1h7MSuRpQZqZBp6Z17dd?=
 =?us-ascii?Q?dJaH21oOt54coyUCulUuGlxERaKs/DDluCm0JHHcpAfqNu35ZEA7iaJtDXFj?=
 =?us-ascii?Q?/AM9dYY0fq70RxR1qMDAYo4mW0lFt5dhwQ5+LBxOiDpWq6yf6LSxy/5PYtAD?=
 =?us-ascii?Q?PLVxICPQdPjI2fTcCj5pV//qwbVXCPHOA20PRmngtVnlhfWNlmUgQZdT770T?=
 =?us-ascii?Q?Owk781N9zWBXio88LP9iCc9lIu0vxTFOYvYOElC4FuvpHbdmPdShzh89ahxh?=
 =?us-ascii?Q?/lsp7vWdsEUhEgo5ZqclAZXE0XbwaKYH0Fkudyx1A0RjBoFoQtd24e0v6HGt?=
 =?us-ascii?Q?p7/NVwzcF3bSYagpcy5ZtSwjHIIb1Zh48etrDR/W?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc879646-acb0-45ec-2458-08dc86f569b6
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:26:18.3036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arc0hHvTLiifFgfEYKAKZtmBEJdYwwBZkzf3ODDADXvRplay2rKOif7Hg7Yrp5V74CjdkhAUWpDmBCpTgd3NBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9020

From: Peng Fan <peng.fan@nxp.com>

- Add 1039.5MHz clock for video PLL to fulfill the LVDS display
  148.5MHz * 7 requirement
- Add 800MHz clock for ARM PLL

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 1becba2b62d0..591e0364ee5c 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -78,6 +78,7 @@ struct clk_fracn_gppll {
  * The Fvco should be in range 2.5Ghz to 5Ghz
  */
 static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
+	PLL_FRACN_GP(1039500000U, 173, 25, 100, 1, 4),
 	PLL_FRACN_GP(650000000U, 162, 50, 100, 0, 6),
 	PLL_FRACN_GP(594000000U, 198, 0, 1, 0, 8),
 	PLL_FRACN_GP(560000000U, 140, 0, 1, 0, 6),
@@ -106,6 +107,7 @@ static const struct imx_fracn_gppll_rate_table int_tbl[] = {
 	PLL_FRACN_GP_INTEGER(1700000000U, 141, 1, 2),
 	PLL_FRACN_GP_INTEGER(1400000000U, 175, 1, 3),
 	PLL_FRACN_GP_INTEGER(900000000U, 150, 1, 4),
+	PLL_FRACN_GP_INTEGER(800000000U, 200, 1, 6),
 };
 
 struct imx_fracn_gppll_clk imx_fracn_gppll_integer = {
-- 
2.37.1


