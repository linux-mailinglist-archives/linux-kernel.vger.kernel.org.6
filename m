Return-Path: <linux-kernel+bounces-436719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD069E89F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0541616EF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F11991A1;
	Mon,  9 Dec 2024 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sl/9QT74"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2069.outbound.protection.outlook.com [40.107.247.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F5F1990CF;
	Mon,  9 Dec 2024 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733715688; cv=fail; b=FSD5RCTPyWgTQ/u4uYJQ65likZj+VygTnfy0VbxttTVxBFUmgGl6/KJI8TNZjngTE71mnkvEMOK8rEsF5oQhMZu1iHRy/Tlllfg53f8W5i+vHuM++dAhVd9btib1e6McqZMa2VNmm8Mam5VZKdv81nvB46rt2aIXn1Mq6OnatH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733715688; c=relaxed/simple;
	bh=4PfnsDhTPwICIKU6pZop81+6XOLqcjITHMF8O5XLKwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s3NIeXyMxvY4TAzO3HajuWxt/3AkLldX3VgNRc6bBsaZ7XBHMOnHqFSw7b1+IPyL4hqWL99YBTeUkUWcZRMoT6/cb2GBVGtzmIB9hVEYpKwlrxEXTIVS+OAPsN+be1LDxznvAx+URI5pwuomNxymGnfLwpLovWaulRxFAGMt0bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sl/9QT74; arc=fail smtp.client-ip=40.107.247.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlMFP6KOm/ZHdswgxn8Uh2Sq/ZFhVH9fXruEkpdLvlgyOa+g1iW+8CdnyHRSRDJrFh6/SnoxbCIQaeH70DEMRjRokOXMdmfQQPpzuHETaSooNDh0QLukHhqHjtDHLiTnOgztlOK23R5Ye0Xa/bcRsLUNO9ydU5X9rYG1tEb7u7pBwnf49Sd8RnzHXPsobf7g8CbSaoE1eZr9sjXRkMdsTc8710E1EsNe2aECqxiqYc8hMjmBpjsR5dCLsJZfuoAu0RniOQIkKAwAija8KCN7byQTakfxNNqSVHCEM4s3RFwUaXiYHV87aGZN8W3Y6cqh5/kUwgvubgDTzQlf/wCQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMW39ZGp+HxIvg64bg8olQiYCojx0O0M5SZxclcteEs=;
 b=psOZCpPHCIhX1C2Jd1DUVQSkGrpP/0qY2e2LcYuVMQaf1Le27ElAjrabQF3K34XCt2haYpuKG3HGxUoIfCVAtk0Ek8EMBBKvQI/twxZY3m5NO9++1DJaRJM2WnF0xQCmjJUw6L71brpQ4iO2TtiVMFq0MGpdHGj0K4twL0P8gGJnn15bzHtx9bGnUNKV9M1TyubcfuV7/ROFLdaA4yS7/lPjviRM+501KZeyQ3m5Fpk3A9smhgMULxefIZfV+spmX6DCzIwgkil49WIo8JRCVX3YAOHPr8XzUCUZr9E/LMp2Wo7Gl/53uPqhVtJzDVMx4+0JQSRzTXIDV48fpbflQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMW39ZGp+HxIvg64bg8olQiYCojx0O0M5SZxclcteEs=;
 b=Sl/9QT74clt+A3EmRJT0rFlQDSuawaW4jyIlXw2jjPqhwkogEugC3MyEKINcJHvzXTURKGPjBMbAtYLFjTrj0Cobz9I2q//jJHB5b3v3J73kKTrEUKE20L1VEQiS8o0UAXLcf/ECnshtAPykS0LHUvs8CaKFoM+KWxQzLxtWK2UnH/ufx+RItjTvd2M6BNzea/ttJ38VZ9kTdFh21f0fnf5iu3kiR0voJfVFCTrmKVwmKk+Yj5MJ8b6TzgXgC0IepQqC2w+oBsnRnrpNum+Q0LBEGFoPE3AHT+Rmlxo7US2KYWsLCgF5B78UpSP+/5TegTMUfWVaj25KnsgGoN5Tgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA4PR04MB9438.eurprd04.prod.outlook.com (2603:10a6:102:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 9 Dec
 2024 03:41:23 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%6]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 03:41:23 +0000
From: Liu Ying <victor.liu@nxp.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: p.zabel@pengutronix.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	tglx@linutronix.de,
	vkoul@kernel.org,
	kishon@kernel.org,
	aisheng.dong@nxp.com,
	agx@sigxcpu.org,
	francesco@dolcini.it,
	frank.li@nxp.com,
	dmitry.baryshkov@linaro.org,
	u.kleine-koenig@baylibre.com
Subject: [DO NOT MERGE PATCH v6 14/19] dt-bindings: phy: mixel, mipi-dsi-phy: Allow assigned-clock* properties
Date: Mon,  9 Dec 2024 11:39:18 +0800
Message-Id: <20241209033923.3009629-15-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209033923.3009629-1-victor.liu@nxp.com>
References: <20241209033923.3009629-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA4PR04MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc64892-9ad3-4642-7125-08dd18035a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dBJxsg3okXuPPpa0BOKv1YBBAocMl1KGSQMYUHL5TmFLO4U7YsoQoJjQtETt?=
 =?us-ascii?Q?zFtdv/pKmuHHeUA5+RIb/trq7vjLJUKcIWZ3zOSAKdzbY1ZtGaF7x5lNI3t7?=
 =?us-ascii?Q?DJQGJJL5U9NCeqeQfLmUPk15SaCQ75Ys8sKmjgkaJYaiGdWhwKficyjdY52a?=
 =?us-ascii?Q?XnUpR9P/KnRpv3D7ifY+Idsdqp3iibbTtjaQKPacRKS3nultjHxQk+HHphgc?=
 =?us-ascii?Q?gYgnQ5fS5CW2Uz5g2fAK832RUdnkCf8JYH976ivt6Tbhc/EDryVLcKeNEl4R?=
 =?us-ascii?Q?EIyeUmUOV4BMI2JM5MNcJQxp7tHFy3f4iDDyhd1KUlsX7uJ5vXu8wiZEIhAO?=
 =?us-ascii?Q?jpLRa+e/DLzNiejfosdE9RjXLUHXo0zMtlJhnqgfe27HZ+8fMJVT3CoC2K2/?=
 =?us-ascii?Q?wk9ZoPpwL1jsKxZsCpiLbkim/4Rcle9wp0Ol2Kqlr8VwV6HRu46gVjxukHtE?=
 =?us-ascii?Q?1Piz5BjVr6UBqy9zjPqPxIImgLT55jgxP+LK0ppIMXFncVQqaVTE4Mv7pRd3?=
 =?us-ascii?Q?+pE/uul2pWb1g4ryKBev+0V80RLoMLk2tPV1tgnqgNmYtCqJlS880u5FtN0R?=
 =?us-ascii?Q?mLh7HxiZMFl+Ydn5gldnCmEgkJ/IuYq3+Vz9THHCYvUXbIFWQZO52H90LhDN?=
 =?us-ascii?Q?RRwGylD9EaMDRgYPjTeZKw5OXNk67FitOKWbXImvtEhg1RPZJDfoCyQRnjYh?=
 =?us-ascii?Q?l9PcAnL++L0XSI1ZQY6vUW/k1KDJDNmEXcaMCcrW8pFvJvD216LGPlyNOp9B?=
 =?us-ascii?Q?fdN1AVZShpnEYe595KcrAbAJkJr0isWLb4Or4as5lZwB/fIoV3Wpnx2itZRD?=
 =?us-ascii?Q?HmxRHtUN0isuWHVYLduwWsoPcjNhhhL4AOjuTw5x9sZ5jYBAb0P8KarOiopW?=
 =?us-ascii?Q?KapwPhxQnE5FtIn4ktjvH89aEE7yQnhwSdaQK5lPNLZkyGCaw6bP/+0KdbkK?=
 =?us-ascii?Q?iUYdF6zs+iPEtQ0HLsLJHjx3CLLAt0bLUytXGYsTFeJtUWd/FFy1V/hnsmHL?=
 =?us-ascii?Q?c33d/EB1DYrkgwcMTxw1nlEB3RRmyv1979SKMyWqeQGlhDXSiYK1jITERnDg?=
 =?us-ascii?Q?yvUfQOchZ8Py7I3HgbL4iorYoC5a9HHfgqGGAB1ct9F43j34GgLZopbIxxoC?=
 =?us-ascii?Q?RctLxUkxoUrUpkEKe0/RICwMc2iasQe+9fkE0Iyjpz2YPtXXhw4u4lKYBYLA?=
 =?us-ascii?Q?+iCaLR8hWG8LJO4KPfbu3Cvz/kcdM5pDtvpyNLfrc7UJGvNtsA3qu4Kz5vNY?=
 =?us-ascii?Q?sZdwMWEdvddmoCXDaOohvjfWImGF+j/veT+NnQSUSKL6yKq1q3x6rj0j0zog?=
 =?us-ascii?Q?b1SDjNxa8jjgzXzPy8nlU+U90oTT/oQBO28XDj9ans9XwZHxSMpg63n/PdRX?=
 =?us-ascii?Q?/q/WG7YKIKslUFlSQ29Q9aF6ZlIxoYvbbeGznIibYiRqSPYzTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xEVtUWm71o/OiKc3nM9mPYtVcrkP3nIi+jy+2R8X9n6UjYJfvGgb0EuMOQX6?=
 =?us-ascii?Q?OXPvw0+74UUM/ovRWDtYiP4w2FWXdrYsO6XJQWSEFmCoYIo1wbM2zKuOGvrh?=
 =?us-ascii?Q?UwW8GCGCx+h3RxE4AJN68JuhROf3+b2iGe6Sl7uUNsdtfnVwTB5SnS6npKuv?=
 =?us-ascii?Q?z1/N+f7+sVcrshaW6BNxyhNyLzjbgc7aOfvbnhzbADdcaRadpoICv/6qClfv?=
 =?us-ascii?Q?OFjErRwjDBq7sVQa2BCuD/JK+nGvn3bmIS008YQc0kUlhwNCqNUScDtUQuRl?=
 =?us-ascii?Q?QY9nnBm0ySu2+FRD4d++IP0Du8zqFW6b0/wxlaKvreYe01NbCeKyNMLqNw7M?=
 =?us-ascii?Q?jEUUwTlrSDbciNfnG8IhJHe6leECFSoFqoAOKcUcCZ9vZ7JSx7k8kkX/Zl/X?=
 =?us-ascii?Q?xTXNAelO8A8gkOm3E4wlNC5cutvGqgaLGD3gfget16LvDYjiV/UlsArQ+3eN?=
 =?us-ascii?Q?+9w9z2WLrXpqwsCrL4FulNxxYEXLwtd5T8Eso48rP7bcPEZMNNK2v5Igaj4Q?=
 =?us-ascii?Q?Rj4MtwFAx7vZHyBsjjfeAufKYZ6gdf1Pw/OI826IOcM5seR2Yx7qwutnTQoj?=
 =?us-ascii?Q?COWKhNgidWj/eZXj2N2By+jXEz7Sxa0dZJtxt1ZudEU243o8OCr0IuaO78Ji?=
 =?us-ascii?Q?A9BBacLqzuosHm1AuJpORxVbRxyal2CqvIH0T6EhqmDGl4b+C5LoGQDvpEUr?=
 =?us-ascii?Q?YE0p9y0I9ASPTIWh9p1wPayPVCaR0oOQq9YT6kvJl7f92p5+vxV7i53Y+K3b?=
 =?us-ascii?Q?G9IuHH16tlGO7igtMc1XYFxUnox/rB+LD+zaFf/RIo7SdpJufMx4AgkHpuKP?=
 =?us-ascii?Q?l7wiAvMGJlDwVU0iR1hjf7sMzyuwH/qvRD7hp8317Ro0FKtxHSmN0bRTpLjs?=
 =?us-ascii?Q?IVP24XRYRe5uk80aGejB3B2ofd6NinEqeaJSZpXpp1Ga7Vq5qgTExPkDPtRU?=
 =?us-ascii?Q?MuioHBzemiAhuFcxSSrD88XTnWve6SrhOOqtpoV8n0iUKCzcUndz0No4hahP?=
 =?us-ascii?Q?j4QU7rjMdacqbiXs9+7J0AHUVXdNhoWrIlpBfaTEcri4oSAzHgQkFx0H5SDD?=
 =?us-ascii?Q?tNz5vDWmjFWdMoJWxvUDRSImHr/mGLqnTzDZ3oV0gjuJ67UJwG48b4oV3j35?=
 =?us-ascii?Q?HHsaj/u+H8J1QDK9HRoHdithArASFHQwbi/Lbn3+oq64Pn0XJyqZl5FCIf1p?=
 =?us-ascii?Q?hn9mXLYkIJS5TA9AzfDTnKo3MjGqh3IUzgE/Mwto6d1wj+O/zCnwpLf6nWC+?=
 =?us-ascii?Q?6yY3wyGzy0GEdvVbTCTqzYcBQPPiYO2ZMrKp3QCI9aDGV98c/SkTXkCD2Arc?=
 =?us-ascii?Q?z24i+ryIQXYsiICkFJ+vrr2MyvawvZjQpg4qc5sDl9ddFU1nlADvwqWYjA5M?=
 =?us-ascii?Q?RVClgBx43TJ5rk1XBvl3BauKe2GsCOBQ8nZzLAgqgc9YGSA1NJl3d81F0woh?=
 =?us-ascii?Q?f5VsSLBnUuSomNbgHsnjOvg0xH7vValBuv4sAWZIyGQ/Svdjz/fd6VMbc++i?=
 =?us-ascii?Q?8DElam2GA0jc3qNEQPjLTAAUnXoq7Aexw7Ok/2GwfeO30xNUvMjw0hFJSns6?=
 =?us-ascii?Q?QR4ZKGEWEBTqjDO0o+MlZSJ9G0fpVVHhiCDM/cY2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc64892-9ad3-4642-7125-08dd18035a2c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 03:41:23.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TumBtqq9E4pSxpFdHV+SjLcih7TWqF+WFbvJHGUqrP7+1NiMdbkh62tfySXtDV8KgdMj58uQIw4BB6ne8hugA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9438

assigned-clock* properties can be used by default now, so allow them.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v6:
* No change.

v5:
* No change.

v4:
* No change.

v3:
* No change.

v2:
* New patch as needed by MIPI/LVDS subsystems device tree.

 .../devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml          | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
index 3c28ec50f097..286a4fcc977d 100644
--- a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
@@ -72,11 +72,6 @@ allOf:
           contains:
             const: fsl,imx8qxp-mipi-dphy
     then:
-      properties:
-        assigned-clocks: false
-        assigned-clock-parents: false
-        assigned-clock-rates: false
-
       required:
         - fsl,syscon
 
-- 
2.34.1


