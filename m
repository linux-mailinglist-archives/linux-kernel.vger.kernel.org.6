Return-Path: <linux-kernel+bounces-370898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4088F9A336B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6073BB23394
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AB116F27F;
	Fri, 18 Oct 2024 03:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kCjEHpWR"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D1126C10;
	Fri, 18 Oct 2024 03:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729222628; cv=fail; b=OEc/oFoBAMU+kgM7tNc/Vjlz8toi3Nk0kTSbzYY9SQOKFWiuqJFbuk4WR81KLV3pmydYFrMJa9wEyYSUWzI8uQMgfxUySZsvyT7UXlOQbb24Ld7PmP+0vXz16mqWQfRX4wuWbRIlV0iapKCqLVoVQPKhJFDaeN2s3fRZt5+gs4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729222628; c=relaxed/simple;
	bh=cG+8ut0FpZeAdYiAH61ZEq0Tia4Cqyqoe/o2gMz1ki8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qNKEStWjVCLuP14pva54q7NoZfegFq1VAQWZhA4LCXI23vAswzKk2FQ69qjI9FZm2QnnfAG+uhySBHzhrvydeFFuDNyEfv/UWwM7KNMv6bKNkAkMQ3QgR/3o0T/Z5FMOQMHfZopkUfzsQ7dDAiRq03YbONw9VsjF811eaA4pnmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kCjEHpWR; arc=fail smtp.client-ip=40.107.22.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOS8QR6dvCYqzgq1CW9GDetRmQvmlpnKiU3iGivHaBn/yIbHaxUnObAHyI7jvUJmcmCHw4Xuyuv6BZH3P2e4BqN9TmP91IN9bQ58Az4RVLZYpMgMx1vpe5yhW7il9lxyYKJ1Y4TY2df8zTZdTSDfdAsnKi9edYje4SwH2ZHaSz7Hl22ruQ12S+XjrKFh7f7QTHTyE6pVpJjmIM3hNBFBx1WQ3HkptDthV/mu2WiS9RQ6Brx8CB7oll97+CEpGf9JVZDTUObANAvVYycafMtw3AWk6/GCxKQ3qZnASpob5RCGxRRarJX56+d67Hmg3gJ2BmIcIp4TAVBLIENGXv20UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fx+pXnVIWjmTkAzgtdFATrPA2IqUyZwp1FvqwaMef9U=;
 b=E3/WBQGTN+eBNUxS1FxmZoQoMqXHf5dngEk5jfaApXspTF3C5n2P5k4VntkGa/XeUErIUQ4eF8uymN8qhA5CECddGs79Zo9HfKQwnXNvBf26I9fzHsGFvzM9D73tfqtwyQNiDByS9tITdEOcvA946BAIOmhlzkv/2JptbAL1do9kXXqvJY9sAJBSsz7mLAP9+6FE7DhxyIGfrtnwVyodE7m4oHkQXhmD/AnjKKdUwHODS7AaAch2UK2X2pu+mYt3vmtf/tL8crHODc+1FjAnxF7RdpVkM7JL1YZkyZWxv8czz7RU3411LeL1700/MX14b3vXE1+3hBsKmD1f0Vwj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx+pXnVIWjmTkAzgtdFATrPA2IqUyZwp1FvqwaMef9U=;
 b=kCjEHpWRcTdnumxGYpSOmW3ymzvL1K4gh2PRWgCl+X7bvjA88hwrqavAVIBKllGyM3inyMgzUvLsthi4EeTT3NIOSDxlGuUt3YI5vo2L/9I59KzVIvAriLIq/6LkXszuYXd076dliMBq7Mt/mAvuy2YdCSQj5mt8uZoiNTmjFv09w7917XO3SJUTBsmF0vosjbHOmf5CTrbXIsnadJDSx28Q7KgWS8nNffrZLcaN2nzrPDcwGKR5iuDxjGe5B6S3WENtw+ONpdyUgQaI6WRR/DpB6UX87ASl/hKR7my2sK2Qn5cS7HQ8ZMrABcJN7EnQYm+33DZjjz60R/CKzcl6bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com (2603:10a6:208:5::22)
 by PAXPR04MB8110.eurprd04.prod.outlook.com (2603:10a6:102:1bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 03:37:02 +0000
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0]) by AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0%4]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 03:37:02 +0000
From: carlos.song@nxp.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	haibo.chen@nxp.com,
	frank.li@nxp.com
Subject: [PATCH 1/5] arm64: dts: imx8qxp: Add LPSPI alias
Date: Fri, 18 Oct 2024 11:45:28 +0800
Message-Id: <20241018034532.2552325-2-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018034532.2552325-1-carlos.song@nxp.com>
References: <20241018034532.2552325-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To AM0PR0402MB3937.eurprd04.prod.outlook.com (2603:10a6:208:5::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3937:EE_|PAXPR04MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 084f3545-af89-414e-2b6f-08dcef2616b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZErD0UzetipNyBdM44CSvgyeAFGUaJjPyU08gkiWCDj1y9FQCI4P/ZDpPc5b?=
 =?us-ascii?Q?VxBMv4ikAnFsgR9XnxOiu3cdOlefPHm1XOxGGC/WUKwLjtegrIrvr35qY5bj?=
 =?us-ascii?Q?WxSV374tUtlMOaH8Cq7FqVUB+qLRZDlnTY2uLL3z/2aBBZnYlPfQLx1myGKu?=
 =?us-ascii?Q?I202b0JgDhPLWOkMed8W/5m2d2RKXyp2PBnEAghmM2kcze7vatJnxsaKyjVk?=
 =?us-ascii?Q?bM0r7JgU6tfl/tSBg4AjYZvBmyfRudY2tcVKz/Ib5P/6XcWUKGV+zJbO3Dbc?=
 =?us-ascii?Q?xssYdktv7FEgoloBgd869IQJ7OfnHpVe7EiXZHO2fR4r8U3oCy5XDs2F8cdo?=
 =?us-ascii?Q?8VAg2wtQZfQDs2ZoCr6sdDwIhf3bg1AsiWgEZ5b4mHzlrRQygRH37lgdPZTo?=
 =?us-ascii?Q?QAvVKapd3s2MZ3QUfIg95HSQoBI8AXY8nlv/9NSekJdsu3ubal/rt7PK394S?=
 =?us-ascii?Q?WqBhZyPMHuYE3XzjEoNaHURawAZVQVtPXxF72Cxu9kbsa5c6H8LkZY2I0XUZ?=
 =?us-ascii?Q?g7C+/6J4/K8wIy01/QDtHZK4EOhQg8yoMWTzJMQoevBnStRidSy5SM/vCeLK?=
 =?us-ascii?Q?m4yAi1au/teR07m5ulvoqgVxsVfSAOH7o8m1AsLqFXVCr8EhG03reCY9CpFs?=
 =?us-ascii?Q?jAVpv7p8XKSs5JrrSBH1kpUbGBdS8K0Ek6b34zzEa1W+iZMPlhvX/cfNAXMW?=
 =?us-ascii?Q?G+b1w3D8YM5AgqQoMO+4MXcisDyWgNuqxoHGg9uUkuhP49UJncj2QDprUvnM?=
 =?us-ascii?Q?mIzL66k2vEpQxcb/nH+grblr4pVj6/Ein0oNNulkcKGZ7jmhH7iiGG2cpJtw?=
 =?us-ascii?Q?TPgE/WJAY4emQADCpJnUcnhbhyJVruDHpIjwZaLQCZ6pfyDkAJE2SZJO7D4B?=
 =?us-ascii?Q?h2d7YbhqahBgE4+g5vCjtzwU157rbUgxgwZOJQiBN+nPyyOFPhVa6C3oEeTE?=
 =?us-ascii?Q?V9CTOGRMPE97Frd1lgnZl93YrrxGBFKA6EnMUOBRda+XcRifb+LzX4Jlmfll?=
 =?us-ascii?Q?1EOJxGDDk9sj/szqsnLUGXovWo0tlgNxu8sL0xIry0oBXclLj7Mxmu9Y5NXN?=
 =?us-ascii?Q?21l51HUEnsb0GCpUr5uK7Weg8A8OZr5GcLDckdFr3XzJ8Ab+60WoyO5K5o7z?=
 =?us-ascii?Q?6xXX5nE92iMIWVWhi+1OgwGU6hHzChMew+LGfOXb5eYjk3JPLxt2RjtFTRmy?=
 =?us-ascii?Q?eSuUByb4imygnhpQuEcUbbpX3gQ9Mfh2bx1vNOml1kQI4I5iaZzfKg0WZiKI?=
 =?us-ascii?Q?HDBcnclUYzOGVBJ232rlYid4jx4z+DeR/VeUvFd67F4KkXmKpr9yF9rRQ8D2?=
 =?us-ascii?Q?ETlfZu8ZFS5YkybypRi0SFJuJp9Oeo3JzZcb1E/tY18HyL3yERMyPfZ0YqFq?=
 =?us-ascii?Q?cbFtItE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3937.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?arhSaYO7pQv8ajger6vHNt/opx151Hw14DTNhwCxIPBfuERtGgIW1Wv/OC5K?=
 =?us-ascii?Q?F2jkdnVOQLiQXeI7bbZrwNHmvfnAV+rH2BDnchTwyXJbd/dqJ5z5WV5p8j5u?=
 =?us-ascii?Q?SNHhC3NvnPrd5HPSvnZhNPT4uO4YPP0znNXaQ//h0sVS+jCI9lVlB8667HHD?=
 =?us-ascii?Q?kKlKFKTd+JUrcrtryzPwcD4pDPii4ecIF6cyvVei+PfmUlLPUQVdKIzD3H/L?=
 =?us-ascii?Q?5xV6ta49dy3DMdyaaH/PePpIyGV30skQKePdK7WGP1mBq4zb0k1VR9tsTanv?=
 =?us-ascii?Q?ljGfLTru1FPYQ6U7D+dQwn3ufQLEpGY4rhtvVqUvz4zwZhVfci0Fcgz+gUwQ?=
 =?us-ascii?Q?IIOokHQq4G6cWhEt09To+VEkEN4OOEZ73Pv2SG/2KM5Us0MuNXPnXImgp5iO?=
 =?us-ascii?Q?OP5B0eig95Z7bFVD9Y7a4PTMj/111JP+EollQqXhh5KmhwQXjtMAxuP6hn3J?=
 =?us-ascii?Q?LCd6Hhfn2sj1iVzRPrHfZkB568WTw8Vy+sWUyRX3CzgUQcM/GDOUTciIwz28?=
 =?us-ascii?Q?f+o2uSVIZBWo/YoJO3yovHZuQsHiI5E1EFuDdhfPOwimaPm5VjFArvgxEP+s?=
 =?us-ascii?Q?8+1qQ0sqGctSB3d7n4sJV95xatnPp6q61lLDfwgoyN8HM9DPFo97uH/erl+z?=
 =?us-ascii?Q?iIQj/7xFw2hY1bBTW3bBeSAtZ2+UOAE6B2uTpSwc+U5fkV8DgAor0CQErnHl?=
 =?us-ascii?Q?+XVz/pueyZ0PGoRW9I4xXZDhrng9pk0BJ69JWQrMJBQps0Nwr+RWsbILFAVD?=
 =?us-ascii?Q?XCxl6+/zMPGdJthjq4jp0cVA3x2hbZez6FDMxeblV9nNuJzs6ma32OOLYK6S?=
 =?us-ascii?Q?TbEYPRrlLEHMX7n6jtBx4g4IVU3A7bqHfUwcCHowYZhw13SEvsV5IYU38uuw?=
 =?us-ascii?Q?LN3Ymzw5NCT17oZ+EfrGv1AidRynk0urMsxtfx6WT5oamAHGJOvoYhg5GYA2?=
 =?us-ascii?Q?rmU9BFxgIaN357ycu45eagjxOaZA6z3Z89RhnstMBdfBt++yBjas5MEHKuSZ?=
 =?us-ascii?Q?xV9eTe0+aRncxPi6/gfRB4DFp6EUbOUTmxJufzNgj5SoyD3tNZRGPxDI3rqF?=
 =?us-ascii?Q?Hs/Jkh2T/5rq+1ClsbXS0n5Q1mJLlv2lUGmSS32FjPSWQUwQjhnymltIn82T?=
 =?us-ascii?Q?lpeIAW08Dw0m2Eyzq8WPfxHAKHiFyAnuilLYGoTM56SsdfyFGOllKTGwl3Uf?=
 =?us-ascii?Q?9WR696RZpPG/UBWyMD4dvyt5pZMUDV5yYEblWQ7m/4uPvaGnEMKkG+QLcsHL?=
 =?us-ascii?Q?nb9njNHv3AP/36W6JDr3+S6WnvROOqaEv6JvYbRGIEf0TKSHchDx5nZnPYDY?=
 =?us-ascii?Q?6g2Xu5vUPHOqXmzfqot/qUyBHUnZZq5TGDWWsmrfLaPjVlrAJyJ/fxL2c+eM?=
 =?us-ascii?Q?y2jD5aC5FJrtabPVwG6DArQgjqKYJGFh0ElT2CjmxWTsxz1okcmvoso2ytSH?=
 =?us-ascii?Q?GG9gaxyQ/R7tg6beuvWrrMyuEKBgwD0S8rYmMIVAdJTAh6BiX/muXS6H6JED?=
 =?us-ascii?Q?sNAf/nBvaw8mzOks6Q2ISkHwSlPyoWco/cKaGO9NHcSgu+NlYtyMB7wKyURC?=
 =?us-ascii?Q?XpwpcwrCu3T0Ztz0oASEwOW2Ogbf8O1z0oji1pZa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084f3545-af89-414e-2b6f-08dcef2616b2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3937.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 03:36:45.2849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+/ionjLDxOiJ+aDZYdMog9pCOd/3JaQGrzq/lM0nMFMBbkXS/rawg6+vsBE+rfpzXV9kZgYIqPoU26pPhMHQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8110

From: Carlos Song <carlos.song@nxp.com>

Add i.MX8QXP LPSPI alias for kernel LPSPI driver usage.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 0313f295de2e..9ac146d84ab4 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -46,6 +46,10 @@ aliases {
 		serial1 = &lpuart1;
 		serial2 = &lpuart2;
 		serial3 = &lpuart3;
+		spi0 = &lpspi0;
+		spi1 = &lpspi1;
+		spi2 = &lpspi2;
+		spi3 = &lpspi3;
 		vpu-core0 = &vpu_core0;
 		vpu-core1 = &vpu_core1;
 	};
-- 
2.34.1


