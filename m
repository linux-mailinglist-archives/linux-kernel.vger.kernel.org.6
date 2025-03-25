Return-Path: <linux-kernel+bounces-574761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A35BA6E996
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A503AC011
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BEA1FECBF;
	Tue, 25 Mar 2025 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DUYc5vz4"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C5381732;
	Tue, 25 Mar 2025 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742884187; cv=fail; b=M/G9bLg4PIV1yE+Ey9cfdt7ukXU1JYD+kkI1mxapH+xoz5qOuVmYMU27Qb92ziLT/6/YFaWQc7wsVge1G0uXsHkvNSgH2tBTftTr6PW6DoZhzi+nnCfN6Nb1FtTQSO652R/uTsxBldYjt42gLdkd47aAZbGhr7d5ZQ0dZTvjpMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742884187; c=relaxed/simple;
	bh=tP9b1lYlvvPMkYubcADZnw+L1BFYvZd3w2gU43qvzN8=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TwhPWCk5OYe9hK1P2ROP1roSDQJMnr1RdDZkQsftR7OYllODmew+OycnGOzR8VWki3QrvzBpclaT9alT7lCxWb6T1yrjgbiuRPKhmOx10jBftqa857thr/fLGdi8lXlp0FXO4xZwpFhV6LMCXR04L5q4oWmNI02YFn4+EAleTnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DUYc5vz4; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3EjYFiV6zO35rsVEEzVaG6szh0ViQlMW2zsPwP6f5A2h0G7dZIMACIubGMoLBfWiR2h+cZBLo+w5rmVwc0nI2IkkXbSL0ZI0iAkhhO816wCbll1VR+AAK4ETbzADbbP+NCB/Hlf8YJGozJT1RTV1y7JRfx/AjB0qZ/DOHUyqh64H1JB8h6Euw7ZYXhbB6BxQuMrQaNXPMVW3Lxx6WsB2/Qw0M47k3hAZDPfc+083mHe9rgtAZ+IUA1dKIneK5sZXNrTipYXBBcFYsAXBIpg6kw1bgwDWBNAL49V5UVVZlY+1r58O4cQV8JPyTFoF8Qo/LfLymVgEWFH4/BU9NlC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSmXI2R2sDMb38uF6CZfNW+U2i7rrSu6CKzVeKQZxTA=;
 b=l5sOjcyM/rHg070NbngiVU+dAmqGLR+JJ/GUgPSkaKGZzQ4ufjhhZOBBh4lxHPef8YONKquNLG3Y8Wy0gahA9N/2qUjrjOj2ohenmK8QcbXMCQ/EOZz/P8LnOVdVPiA7Psa+IzMTffS7niKfAS/b+4v0WnQpEavr7SQ5jjoJnePRGNjdAwgwZLxLXnbY1LdHAl8WZ7dCzpC46MFQEtlqB7sdY0iZZVz5E2zzbzDcNwiLKaBUyxaVwvKtSTWFKmKzaLSoIiLEGBYJrYzJvEOd5YLrcNof91euTnRZNFCc0lDjP5Qt5L/zI8abItTHe72H8XaewmtH2LgkwjWXecd4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSmXI2R2sDMb38uF6CZfNW+U2i7rrSu6CKzVeKQZxTA=;
 b=DUYc5vz4zzL//MEciO0fDMA7hsVsRPM7+51/ui0Ee6slDmM+RLIOX141asUirKdxK5jdnMy29ZFDNlSFWFNoSMrvxfujXWqVDacxb2CityV5hI4TJVIwTdSFNqyuLGuSa69nrKRbntDsz3CB8GS+A9gj7ntQdWZqbx0+U0Jh8v49o5RKHR2vvicV4FO2KtiYO0R/XlsMmHBAbOvFxspvQy9pkHrnfYPTssHL0cIw3D6mGkvZMDe+bcnvhO+XUC61d5AIKPF3uctJ/ZpDQvQW6r76EUX7CIZaIMAvqfZ4o4GT5MI+flotrYtOiuBPcIM5D/JhgEH88ovAHKhuUka13g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AS8PR04MB8184.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 06:29:41 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 06:29:41 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: fsl,mqs: Reference common DAI properties
Date: Tue, 25 Mar 2025 14:27:51 +0800
Message-Id: <20250325062751.3296913-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AS8PR04MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa6a9ce-770f-46d4-dc49-08dd6b666c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Bq9E2uxxCwtOIwX8WZ5XfRyuXVbiw1uFETZUZYrs3HuJuHa10QFMZfo1kg9?=
 =?us-ascii?Q?ei29Qi3g74LKXng/Vtj9N6kg4paijX8nCHzn6m5lpO6Oxh4Kbu/B86tCRu29?=
 =?us-ascii?Q?Rlo3S/e8E6FxkGIHANBDB4fKNiZl+eEm06vyjFvJC6q4wG24zNT/5oQ7IEf7?=
 =?us-ascii?Q?1qGhgvqglySM7Du5k4ZHNSF+RdscFEDhE71HbmgvCt5JpuSderFReZ8FizFE?=
 =?us-ascii?Q?/2TPv0rqt8avCuUM2iISRdry/3NkBlD1D54ZXQcVA30IApZX/DfFR9N5mD5L?=
 =?us-ascii?Q?JE0Ok1RK8XGOTYpudDcH4/J6vrfdJjNWGZOexIxTRQNyilGnRBMLzgJW1fmQ?=
 =?us-ascii?Q?0pU5kWS5GWqz0rvRqankVlwMXXMPSAd7c+j6xJAHvFwQWaEv7DJU4KjFKOqC?=
 =?us-ascii?Q?6zkEbTU+q5J/Mu7g5Bg68+dpP3GqvDXqWbu2HL0gtX4VHBuFJFLixPL56JL4?=
 =?us-ascii?Q?9NFTvrqeZz3cPNgsIF1qY+gTCJsHBR99G0q7h6aX3+Y7oqrfFh+3zO6q80QE?=
 =?us-ascii?Q?5O4GPGhzyofF5M9dboQkE9EX73T6F/oSbBC7DzfxQiyGTowJQHwDNHR0n+X7?=
 =?us-ascii?Q?L5BMNOUiSycjMopcCe8dFnaBrQbJc9gqQ2R6dGqu6wI3ZyNfzxvFgxqxWOVC?=
 =?us-ascii?Q?vezAd9f/k/YfDVXBbDnXKJRf+QuytaGg1ZoVG9Ct0h3QWgOa9HFOMQiKa4TU?=
 =?us-ascii?Q?houz8QWv67jY+2uxBdrzxRLQgG2wt7IwtfSLeO4ahRP4dqx1d6YaSTDpHtSj?=
 =?us-ascii?Q?MGOyrr9wwGjCttiZ3eRijXtwuzslvTqSpTafme5yQYSmw01EYD+hShlBpPSx?=
 =?us-ascii?Q?gUzpc7vipJHcfYpjdXt0PC6qoPy7sbxeNu0IjC7pAz9m/811x9FnPvwnDbKF?=
 =?us-ascii?Q?hGnNZwG3N5AmVaUUoHQubHPgaNYBg3/2WLqhUpm7Z5FrV9+MRLbURCNdLhiP?=
 =?us-ascii?Q?pHq1OADQeRd2sAfcSpIfqGibJS1XJwZdY8G/SQMLgoKgek+EHC08ntIhMFgk?=
 =?us-ascii?Q?zreMctmvdM7bV2jfdrUopLloKu/ggjiZM4bKE3k5jRS5O3AKHm/CCqBS/GQ9?=
 =?us-ascii?Q?AQBPtSZSFulFJ9g2i6L45i2Iz41+lbENm+gwODTl5I+3JGAbdWruV1uVhKej?=
 =?us-ascii?Q?0O9/37uSsLcUgfpRDfAgnGpG0i65rI6k/l3Qvnu8Y5ZV3ynDuHYHA5UGNVO0?=
 =?us-ascii?Q?Hleit96jQ4lPeX7cz9sixE3St9cYA3GzTWjwFNwgD+ZxBMurVOi2bHtEcP2T?=
 =?us-ascii?Q?2TE/SL+cWj2nzgbCYJ+gqAik+SXXxOvr/tCE1vOa+8Bi7+uIu16mA9zGiNTn?=
 =?us-ascii?Q?hm3pv5FaiBKuJYRrM9FMiVulh/wDYSLm59JYjiWBD/q9YYoo0yvf2jePhKpD?=
 =?us-ascii?Q?695XbYuWZvzbhDGciXirH/3emhAo39Z2Ps63CnQQy/dVSCxp4EykG/B5HWcd?=
 =?us-ascii?Q?bnn03Cm6ENtFpsyKFpZ3OuBydTWc97sM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fNievtGJD/Rg5L/XvxSoLNe7WcUgCTHNJZLL9oIMRwY7rSunTZLKaE8iLmPZ?=
 =?us-ascii?Q?UZS2fHsCzdMD7NA+DiuhT8+m9p2JzQ8dOjYnXiHmoBtlEYUoPmI/0WIZpO1S?=
 =?us-ascii?Q?2e3uB51e7dhkzixFyLoMotFfb6wQkIAX+okKC1FJxdxaW5NYCLtJoSAOtDsk?=
 =?us-ascii?Q?1NGsGprr8w1Di4ZehVRI4uA5cPyjEq6RVR9s0ha+fRqR8dtDm5/xTY2I35pX?=
 =?us-ascii?Q?k1ZBp6XyvqEAdhnS0/GsPZmIyAz3V3Jk4Y+qUQfBQ+qAU4aKAOUfztnc1/BV?=
 =?us-ascii?Q?N+AxcAQ2vImZ5T5OgoaaHqu9Vj7NjXzdrnkli1dlTaJfrpr+wepwZijA4Rg6?=
 =?us-ascii?Q?uGqKDLjJjYiFBoliBbGR3ELkSwqq1yjd5JB0MSYDmfunWQdJM9AYH0IEPa7d?=
 =?us-ascii?Q?V1jxpNJAm/e67hKrkYKTsnio24t8fkwebEkbq4tJR8hJ9LFt3OqKDcHAu+4b?=
 =?us-ascii?Q?k0i4aca6ny+ySEcI4khw1cbtCq0Qiu91bbdDj664usS/spuSQb6yOLKl1OWN?=
 =?us-ascii?Q?3K/P5iNYmRUxkOMhBCcPsUKnUvh6MA6IO501JYaGR+D116a3gwDpqStditcV?=
 =?us-ascii?Q?CgzJF/4XHF461jMJhxj5xH1tPjlNMoqwdkQb2tp7rPbTkwaDazy/Q8rqs9ON?=
 =?us-ascii?Q?SHQ7zf7dWZXAvP6elicgFXgLXwiOLc4Ecpob4dPOW6m4F05pcvmMk29DHZwp?=
 =?us-ascii?Q?RqSrFpyMK3U11CD0Tq9qNrTbVongvfpOlaJogTfeBNT+EqEHt5bsuEe8gyaw?=
 =?us-ascii?Q?LlpGBRo4yNJesTRKO745nlB1GOLMZjyW+ZVCRz57ERMfFD8QVZvYi+fyhBpd?=
 =?us-ascii?Q?VIbUKRKHNhqqD6HTKqLHHo1ZaYUnP10D7r+e7vXCRKuH/NeS7NLBcTnzUK9g?=
 =?us-ascii?Q?SgLcTsJ8zgn8P/0svAhKAbzEfkEjzUd7Khc2wNRGvmcnDZvEAbtHhadSkb1z?=
 =?us-ascii?Q?2z2e8FqGsNbVPOEIVZlm59CzKsj77O+4kUgsuZMurXTBgCdWaBKbs5bE/t11?=
 =?us-ascii?Q?Ksh3v4Hdr9ayKtdyl0W0mAKU/qJghgwnUaWDSpj1YygJO4PJ8ybpVPATrum6?=
 =?us-ascii?Q?o5vpOWnuMfvrKn0expfjHy37E1wWD1ZWgEGbGYGqGiZVhE01fo0RPQlqb2a5?=
 =?us-ascii?Q?t7p8Jht28ySDRvSxXQAvnjmfiM4Pe6A1gyHXa9YKuHMataArtooHqdGJQ8Pk?=
 =?us-ascii?Q?nhD8j+KK6mKCeq7K7hQb9d1UwJEYwUUoqTknKnCyJMmhJGVEKpd7Ul8NPRlU?=
 =?us-ascii?Q?4T0+twlkus3GNwhpt7w8YrIcSHd3oE57DR53LoYr2PIxj2tycUeaMYb6W+/x?=
 =?us-ascii?Q?2sC2ruJ900AP6oND0fddCejyq2icJqT4tEVXcH5HEov9TJfBnXZyf7/OFdEc?=
 =?us-ascii?Q?tVZHMTQGsBEfhUvoFaU7k8NRGMo2dikb2isA2a8sYwcIN8OzdaTF8ayIafV5?=
 =?us-ascii?Q?C4WZTJt1XY6Y3RboTCNGAI1EnrKAefWZAs1QrwapNF8BaE02TKeEsqpDTHMp?=
 =?us-ascii?Q?Qk6/JR4KXvNB4VBZqwKfcGt23pKPx3F4kkThLrISFTBWSqCJs5Ta/bBrPqO+?=
 =?us-ascii?Q?1VMKjwn2WGmYE6qx6UZnoR+6n+89brTA6XnxT2xG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa6a9ce-770f-46d4-dc49-08dd6b666c9f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 06:29:41.3690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAoCM+4AaZhUcypaTbV4UzVWJ6V0iNnPs/jXZlwPE73xvK9urkxBKvfSch7OkaG2pm5L9uYxviecnDuPBZ3A4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8184

Reference the dai-common.yaml schema to allow '#sound-dai-cells' and
"sound-name-prefix' to be used.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,mqs.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,mqs.yaml b/Documentation/devicetree/bindings/sound/fsl,mqs.yaml
index 8c22e8348b14..99e7372abd0c 100644
--- a/Documentation/devicetree/bindings/sound/fsl,mqs.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,mqs.yaml
@@ -55,6 +55,7 @@ required:
   - clock-names
 
 allOf:
+  - $ref: dai-common.yaml#
   - if:
       properties:
         compatible:
@@ -86,7 +87,7 @@ allOf:
       required:
         - gpr
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1


