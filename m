Return-Path: <linux-kernel+bounces-571421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA281A6BCED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710333AD283
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2551A256B;
	Fri, 21 Mar 2025 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Buxz0rvg"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013058.outbound.protection.outlook.com [52.101.67.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C486719CC20;
	Fri, 21 Mar 2025 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567186; cv=fail; b=fKYM+eQjvhE47LYU5OQvf22LSUV+Dtnex5ZO2zCUnwY7IXsqNzplzSkDZVSh6Cc1cpZWsn2QGqNTokmgssTEfr0P2/IbUdFWXjkczfW09uao0SBisdpw0j3vmIhC5Gbw9NEiBQY2Wzqrk0NYZ1HlIIJiwHumHquNGaymnEod020=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567186; c=relaxed/simple;
	bh=34FKGbtHN+nZmrUTP2Abds4hcBVFhHTKoeh9myNQfFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HA88vIUCKTpeT8giXsC4/Kuw1qOXN+EikydGA8uDXwAq1O1Lvf9wnyMldjBYLSqeFKf+HRmBYMun1fVS6dlYvoFCHHyBD4n5eFSurGI1JM8lbLFmuCuw4MUt7X0I8fD8Q043EdwY3Xk8Eg65NMObW20JleA4/1M3hHxtAopNLRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Buxz0rvg; arc=fail smtp.client-ip=52.101.67.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF3n2xk4JWktzJrZbVn2Za/eopodvfB0fiv2kkOG6dZ5QLBWoIyT2mXBcaoNc32hcd0VY0nzoB3cWU+F8fT+X/69OGyhaVCtvkBJxzUuSgy8wtqRQyKoKJWKnMYjiIyfrMvIjsFeDFA4/Xtp62CuomTQ8Oo60Ttcx3Mn2sO54GoUyierhQqU1NppOpUBr4Swjrbzv4RT7EjZw8TR1boOSJr2bWp/foiRfgyU7x5eHfGIwKWSW3byZTm/ixaYO0S7Qsrj5+pcS/ISPYl5HYiXCrWVG94FYkR6UL/QBZUN+kpdMhtVHrk+/eOidfJ0qu5dNoX3Qu0jLUARUTZX/7dd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNzWX/IcDeJNyL5VsXyGRekJJgX/6YRIR0yRi8CoWTE=;
 b=prOLD68wrG7/Fm3HXT+ppYYhMI+QPLLX8N+CnwewuTaGNWZihbSqtuNW9yn1Llqu4g/lZtRzNTzNm4xNQBGLJ59mdi121VmG2vPTaDbaI3xqV+XcrAb5yDMjnQ26Y3hAnrrElD9yD30TpTEpc6fRolgXdKSkWnceFTNTejP2IkbIUwLmVwPqhqhazUEzbHKbmf5w/4igcuSTdaZQLU+KYMfY1FnCH0MaYg1uWRWEsc4nwHfYC93DCOE9V2c4XBIqrMwBFT8JuN1jy6SLMIJ5fDfsRtclmbJXChRJpmN1T26lut8cf7ZzOTq3VLxIkQ4bz9l3EmPLYxdn31DKJL50nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNzWX/IcDeJNyL5VsXyGRekJJgX/6YRIR0yRi8CoWTE=;
 b=Buxz0rvgPvXzytlJQKuIMi1ZpK7ey9lBTjYHgSI3EGxzhGl0NCwhyxy7Hdx03JzY6WlMGMDlCupk5mRy5X/VxLp2w/bUNdiGEJSPBMXFk2xyruZJEt5zSTw1uG+Ntva/moTiDI8h+eG7PtbVUC9ej0KZT3VNjYhI9i6y7enbpLhVf6eSm61CeE6lp4aX/6hSCFzzhO15FZm9phLYljnj50d9WB8cg/p0IayGY48W4Hbs/knj9qIP+zYypQaa7C2tpJF7Ff6YhHq1O2CBBQWw+CXGr7WMpzh40I3bPt+orZMfMR8vSXEv4T9ql5jB37crOc+TIKhzVTMcJ6xR07u6wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by DUZPR04MB10061.eurprd04.prod.outlook.com (2603:10a6:10:4df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 14:26:18 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 14:26:17 +0000
From: florin.leotescu@oss.nxp.com
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com,
	carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	festevam@gmail.com,
	Florin Leotescu <florin.leotescu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 2/3] hwmon: emc2305: Add OF support
Date: Fri, 21 Mar 2025 16:33:07 +0200
Message-Id: <20250321143308.4008623-3-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321143308.4008623-1-florin.leotescu@oss.nxp.com>
References: <20250321143308.4008623-1-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0005.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::14) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|DUZPR04MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd1c23a-20ed-4a4d-8309-08dd688457dc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?bUV58rD3UcBmH9ry0zYMZudBAJ0wn3F8s8+r7KOXPZFeP4LCxYwLCYh8ka?=
 =?iso-8859-1?Q?+P2rp9iNEu1a49DcpmCJGzfiJJ0tU1Isa0++TzsrPQd3uCDwU3rIbYYtsu?=
 =?iso-8859-1?Q?oFnonbVAFrl2kd+xmDUhhkouHAVA51Ac2GnmyX8dDM8LLshmaheQsaXof8?=
 =?iso-8859-1?Q?wHRXUQ0Kdkzb5ptP74tqdr4qADeFoiV+DGtlx6Wa3tkORNV/V9wgZ1eexA?=
 =?iso-8859-1?Q?egCj3LEH9Z4dGdyBIzv9oCuacokoXm6kow77uGKqUiyOhVkMY3FvWxzsUD?=
 =?iso-8859-1?Q?5XY96HvQJNFRcDVMfMmA5A3obwKQJWTrc4HnH6sx27wkZX81UDCzBqnyiK?=
 =?iso-8859-1?Q?FTn46ZW9XnAc7hf7Mp8k3ReVDWaI6q95q9DC4P2h0EAGv+7NUcq0ZSIvIA?=
 =?iso-8859-1?Q?HzSSVCODsR3Y5lVpvM/SKuypQbw/CnYd18h/X5eEXXAd+7kO5RRXn0MgR8?=
 =?iso-8859-1?Q?7fapB58aSdjNtE4EeQyY3fAZT4xLVBEc82dlbj50ArqOCqoqI3OpKZMR1g?=
 =?iso-8859-1?Q?pTzGhbCbwVYB9eoCyDZd3kHMn/XFJccR2oFLV2giSfXGxaFn34zRcOHCXu?=
 =?iso-8859-1?Q?UhURz78MZ+0Mlh5eRP9M4Vp2FSP5q7X8DYIdLIvdukHvo3x0d0xlwOf6c1?=
 =?iso-8859-1?Q?um7Hozyx685OSMhOuP1GebeujtSJOFdBWtXpD4fLL9DSyMGlGwJ4JdaQch?=
 =?iso-8859-1?Q?IGFlcfHUYjRMcT97upzLdYjBFfjqp0sb+bpv4czlvBWYOl9Ek1H6jJwRjo?=
 =?iso-8859-1?Q?t3qpL95JcQ3Qxd+4hX3WDmSJLFYIgQTunN/LI9tG0aJQWca10RLFjE0gFS?=
 =?iso-8859-1?Q?92/heSWDgvXKxeZnWaFxtmQjLWp6ZZeIF6tNd5OWII5rmb/Bk3xWdiFmJK?=
 =?iso-8859-1?Q?zWy+U5wNxfYJJfKuzxE8LTQABznhaZ1QTQElFiDG0vtlQq2rVKcPe4dB9N?=
 =?iso-8859-1?Q?XyoMBtn7TSafn9N1Xv2NG8z1lvn7JHR8qj2WcaRM397pJExla83mWbQl1n?=
 =?iso-8859-1?Q?/gqX73cgXaqR5OcxPFTy0jDUxIaYNzdh6vBTTT+x7wVotAm5YeJbJe4WQ4?=
 =?iso-8859-1?Q?HnTXmq+QxGrL7Fml7Aw1LeT/Pw3QiSiUqTZKwsjxDHZuyH7q/Jl72rb0uq?=
 =?iso-8859-1?Q?m5INX5hlDopaczDrgwno5dKfTWDMNPaWCHsP0fr3cM3gIXWwg1OGDZ/FM4?=
 =?iso-8859-1?Q?t/n30KH/q8z5itrUJwK574RFVy/bJPfyLck0mzAW/GQcsIe/fxAgh23rUX?=
 =?iso-8859-1?Q?bBiS7QJDhsFnqd+qSxNU13Dbi+TgxttnvwR3PnIuclGAvNqiYHuUix65rJ?=
 =?iso-8859-1?Q?tNFT0DZ78FjMyxby2vRGJQGe1jFInSElX6cSfWO72pmeR5lvRjpHl2srjJ?=
 =?iso-8859-1?Q?fT/4P4GiK/nL2q1RPZnHOwgxtBwOInOkS/bgYJc9PbJGedxwI8OjY+gJuQ?=
 =?iso-8859-1?Q?/WxHmdNe1Zp83SmN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?kct2V0RKDIU1KjE/ZDBym9IvzomMaKflxGbv/08km6muS71mxNkoI7Td2S?=
 =?iso-8859-1?Q?m5kD1AepEe3eUt5o4x8zsMrqIguSgC+px23K3tDMwGANvMyTyjD00IQ/BC?=
 =?iso-8859-1?Q?e2Xen7WODQwxSxWL8QaKzpz9FaS0qSdZvINF765g+6uBNO704nQ/g3awjY?=
 =?iso-8859-1?Q?B0DdV0k/dNIzyiLewXU+HSPLSYPViw3X7IFgiwPUDwRyWamBxHOJ+8xgiP?=
 =?iso-8859-1?Q?ab5rDS/EbnefyUsuc/IKFvLb0AdGTsCFsYGZPcwhUI2UWG+SYiScwa0GYW?=
 =?iso-8859-1?Q?6LTMKfK6RYsvADqeaJFANoaNs0h6PjPxJaJXcZ8HIiFayEmfVKXjI4K3lu?=
 =?iso-8859-1?Q?WRXj4t6XFX+I+PXAyO9uhFedOeyqaFc8vIiFWvB+GTq/d4YiIH0ds2C9z3?=
 =?iso-8859-1?Q?pv52SZ/RS+NHw/L43nEVQHek7YcAcR/likiB29uQRqejO11EtmXVFLZ7JP?=
 =?iso-8859-1?Q?q6DlMwZM5a7tehG2oH4jcF0sfOHf3xl93d5x/HPLx6lfRRKDyNc9pHKxsz?=
 =?iso-8859-1?Q?0vJz+EAeFvtcxp/eFp4GhvtfzIJxWesi23AkjdtfqjVUsvwCrJ1POWSU1x?=
 =?iso-8859-1?Q?e/wX4TnNyOp76smKikaz7qWp47Llubopmmjj/t5+pDn5Oz9ZH9SvSwL60m?=
 =?iso-8859-1?Q?h8TJSBDP0oy/9H3/dW/OOHkp1qxv2p5xHzNMZYdLcdBT2yfaHIWmyPFcHD?=
 =?iso-8859-1?Q?OgzsoHW14tuyrhe0OasWcLTYY/oCStLzeqiKgS99l2JQ3N9I6kN4EvJzYw?=
 =?iso-8859-1?Q?c4mGPtgNfvja0CTjf1xwqH1IjbasA/iN/aOu4P6w+C3CeoFjZLDHexKhk9?=
 =?iso-8859-1?Q?CEE5xFXzdicMW9A2wpVHhQL/kS5UWQC58iMZvZ/QAVuVVJ8i8FmJl15S1Q?=
 =?iso-8859-1?Q?DwzN+ughDt9s1rPg+Ym4Rn9gehFqA8FlNecV1Are3tyb6S6/2U7W83m+qh?=
 =?iso-8859-1?Q?INPeWAMGfA+/7xd3Hip95Rdspoji+1yJjFAhs8WazCIPeEczyOB9OdRBRv?=
 =?iso-8859-1?Q?ZJ0WHe//fbncEMGdBm5z2pjMGIXEkcQbhusyMUbF7LKnecsEx+ZdNBkqDS?=
 =?iso-8859-1?Q?YVkpXL6+1NbDBn4/dD7JcrRMvTdf/mzbApmoaQAFDmqYTTgC9bC6kKW2qN?=
 =?iso-8859-1?Q?RvRG827zlae1iSxHm6S0LDA0Kjvs+Mar9n+jjskh9MtYFS4T5Qpw29h7c9?=
 =?iso-8859-1?Q?QJ3CU0w0BEls+X9jyStIV2rCm5/McmBRoIhdKXb1rAgOk7/iXHO86Mv9vU?=
 =?iso-8859-1?Q?+I/ntyaEGWXeByu9JqxyJJeenRy3rmd+rk6LltLlII3u62uso54O20bh05?=
 =?iso-8859-1?Q?53G25s5z7+3aIgrfP8JMpJb7/DKRY5K8GHI3SSP3lSdu7KBuqpv3WHee59?=
 =?iso-8859-1?Q?Mqk/erChYYxKsymbsKtuWZfe7D7x1bsfXP1WTxAoZoPCy8TvvPnmT81BF7?=
 =?iso-8859-1?Q?KKbvoL3LQWpHjocawGWgV0idSDOwmq8JggkGe3/dFBiN0Wjn9vRUorQY08?=
 =?iso-8859-1?Q?u+ytIVzs4obhAG2mk3xgwxPra9uN80V3a0J2jpKBk3ihUNAdEZEuQrDdWX?=
 =?iso-8859-1?Q?GA2vxcY6FMheZsGYxp54NFX6+FJ69ExWSe+9NQcAmmzTNrnGGWCm2Yujq9?=
 =?iso-8859-1?Q?6k6o60hXchZJx0fxnrAxMPoDG+7KjpZQS3Gp2JpVapdLqKNtfpUtc5fQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd1c23a-20ed-4a4d-8309-08dd688457dc
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 14:26:17.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B02uCeANOgqBhwlxY8Xn1oQlDGctWKJq/iZyi4gHfA00KAeh4obdhLdWfsINjrOXmflzCwX+OKi/lEI/Aa4s6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10061

From: Florin Leotescu <florin.leotescu@nxp.com>

Introduce OF support for Microchip emc2305 pwm fan controller.

Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/hwmon/emc2305.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index 4d39fbd83769..f8a4c76fcadd 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -607,9 +607,16 @@ static void emc2305_remove(struct i2c_client *client)
 		emc2305_unset_tz(dev);
 }
 
+static const struct of_device_id of_emc2305_match_table[] = {
+	{ .compatible = "microchip,emc2305", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_emc2305_match_table);
+
 static struct i2c_driver emc2305_driver = {
 	.driver = {
 		.name = "emc2305",
+		.of_match_table = of_emc2305_match_table,
 	},
 	.probe = emc2305_probe,
 	.remove	  = emc2305_remove,
-- 
2.34.1


