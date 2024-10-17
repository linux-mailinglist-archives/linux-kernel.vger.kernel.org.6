Return-Path: <linux-kernel+bounces-369266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01A69A1B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37C21C245B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AE51CBE9E;
	Thu, 17 Oct 2024 06:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SdydwfLG"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2066.outbound.protection.outlook.com [40.107.103.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38911C2447;
	Thu, 17 Oct 2024 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147886; cv=fail; b=iqB8UknsYlWNzrGx9FtnsFnse9F3FyAw+Uay649jcvl7Ej9hizulAoIFDxbg8iN6Y37lLTOiDLqCwqGFvUQPiFrjoqlqRzAeDWgPyY9CjtSLxu27ZyATekoSjPY7if8sldZL+jkuKIaXHIZlpQQKhujESupneepxpIG3kAmEGk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147886; c=relaxed/simple;
	bh=y8Ppxl90zorPlqLUk38jXQH/WPGiq4hxJL6TkOoxBgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a1M76z3C6j9FDgEtcU/g+HKRUOKkGjck4xgb891q+9q1QJi/Y4+S6lQQynWlEibHq1uUUNSwnFvZBBSh5L5OuxoEz7qPrGhfHkEBKXhxF/JJ/RCJGl6GHjLV4k13kMC0RcRegX56UjxpgAlPmLzrWO9qzhfEW9FhF2Vo+Ecl1WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SdydwfLG; arc=fail smtp.client-ip=40.107.103.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vm6ckfTWMfcmZIkyapzEidfPVExtG9FFp3OMgfHBbTrqRQlXH8a4r8hCkCX8NNHYaH5tE3tbtgXdp9KWfzELSy4wAQ1uyGSI56FcC493hiFwDfnJBwIZB4ef6K0ALcHC/Vzwn0cDZDSv9rksEnSLf7fD2GvzpivFa9DG0h6wDZF28AWnil/MWKg4WmC/UgdR79QRaNp0sS+xtfmUhSziWUupfq28T271+rIUXwV4d/mx9js0j3wGj48Hvm7dUhMlzGRWxUkUlYjBF5FuZeTROfHzBX6UlKlmeza/hrSj6+PltxOc9wmdQAd+aHQQscB7G83lG1q9A9nE1YU0X6brTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2HNXhTaV09438FPwaxBxpX3LsGkzxD1G2+lVD0T40c=;
 b=co+XkK1TcQij8G2Sj2LJcwLXe1x9h6XyQL3+aWe1JXKKcxkOxNgAzyvNV2MMvLYKmfZ7pyeylDv2o3ssuoRCTk+c9X4kuBL6vNm7MpSh/1PCK88b9jGFJ+LkrNy8iHQNTaIdbAZcFarvfqrB5so+Y523/+Yf2JfBouQNoMWoSV5fD+GNkmBYf+wu+bvOQGQintdH9nmcs3JVQrpLhpPf2tn+fITBLYvkzs2KzD5eaXFXukHmJQ1Cd5qWfz/RKRe4Q0Tw/yKEDDFyFG7qeflQhFu93muWOOYHgfzr48OtiNQ51gCuO2ijPjHkdC4NiSLBEXfskWZ2HpJqbGSj5N76mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2HNXhTaV09438FPwaxBxpX3LsGkzxD1G2+lVD0T40c=;
 b=SdydwfLGWbpHOHUwd2rDmDu6tOXEHdFl1TzVn++xe860OP1yolpMrtdJNgUh86jJqsvbJxYvW9xvEFlvQKjWC9npczVyg8HU5yU/HR6/pIHB8DZVnpj7MLH5n88XYIMW84JQGwNWXq/GcSB/goUZt5DTdZjRv+c8RVoyRpMBnqBC986Bqo9X1WbRRU3A/EfAq0gvTse4uAa0oDhXu2N9BDXd8iHx788NWYS+lAnjOrJarKxegTKkCwY1vuDOke58jxRsphaz1kDWFkXlHP/sRwlpdxgyVCcblknUH2QtKTEogVo8P1b57IJulRA0ZGJ/18h2TtGEo1YfeOUb+c84rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by VI2PR04MB10148.eurprd04.prod.outlook.com (2603:10a6:800:224::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 06:51:21 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 06:51:20 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] dt-bindings: clock: Add i.MX91 clock support
Date: Thu, 17 Oct 2024 15:51:36 -0700
Message-Id: <20241017225137.1158924-4-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017225137.1158924-1-pengfei.li_1@nxp.com>
References: <20241017225137.1158924-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|VI2PR04MB10148:EE_
X-MS-Office365-Filtering-Correlation-Id: 1792b837-6f83-490b-a131-08dcee781bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SSWqSZSZ9FHU+D1YeEzb0z1L4cVhLrCAqJeqiGRbNIyCYWYLlZP91Zs4+3t6?=
 =?us-ascii?Q?8hrk3vgDdwHGuZPuG0UvaRzJRKyMtDCGXzUCIAEFi+sXVIV/AgZk/6mFaEaP?=
 =?us-ascii?Q?QRhp8F/whK+m0Y73wzouOfQIx0vXAxbVs8KDl8ZNEISIOe5QCB8RNp/sZDcR?=
 =?us-ascii?Q?hO/QL7YsCQJWD6lQ3vO0lNXcPnkbUd02i/7RBGA4rfMYq+qLYJCCgxMsCuPv?=
 =?us-ascii?Q?VL5KbpGiO33lBUZXdWGFVO4IajE3ObAidQoRMeCrhsGfYLEVwSFkEFB71UHS?=
 =?us-ascii?Q?eFaHQ5Yq2g6oFUX/bE2fKB0RIubDhG6EO+Nb+x6z0sVanqR9TcDrkGGB7IvP?=
 =?us-ascii?Q?lC/n2uexgyZ/xLrftdLoPOvqmLTt2Ok2/I1RaO0MDZctPObwBRae44bOa1Zh?=
 =?us-ascii?Q?9pjmUO2XwGDk5zXXvTOSYYhrBU4abLnf8WN+GF6Dxbz9VlEH/gX0ljLnMPNd?=
 =?us-ascii?Q?SgQLIz6a2d9ShS/whguflm0m4VB79Ou2wIXYsIulhKRht03BdJBYJ3YaB0Nj?=
 =?us-ascii?Q?FJ6dm+NuKuL6fMdchPGXCeQ+uK3VK3Tfr2ayicUA5hMoUxyjPMmxF3iqnzET?=
 =?us-ascii?Q?KrYpLqSZ+HHhYVdne1Unq1aX8uGTrirdm4fKnbN7k2D39C2FhH/q8sOgMwYv?=
 =?us-ascii?Q?2+7P1U4C/NAt5NPldEKOpqWqPhaFLiUhYgCDjrTTf4USTbenL0cMlWw71ckE?=
 =?us-ascii?Q?Sx0632t+thwdHTuVEQmn4StLSJMgERsCiRF5HhSwPQ3BOR3h536FL6VsQad5?=
 =?us-ascii?Q?HjApaXK3UlXYjVSnsMboCpzbXQS+JLLIi0pPkGy51wBWztP7C0u6hHMHPab7?=
 =?us-ascii?Q?Vy2yC9PVdeTro1pZQVLISvzvZbKsDyG/MhiC+oGUzDxuWkcylXRD8xg9Su58?=
 =?us-ascii?Q?D4thJ693n75p2skTSL7QdweMkXIG5cdjGD+JE4yvca0V9u1CfPQjvZgoadcW?=
 =?us-ascii?Q?AiJB3OXhB66EL3ycdoPE4U+Kzd4QiXydvHxFcqBxAgdfE2tsb5LWbAxXIsC2?=
 =?us-ascii?Q?u5v6PzKtduQguyer5T8LkmLVB4RZ5NIovwrFPBe+WtetyxQCZ1+lFW47BARo?=
 =?us-ascii?Q?xAYEvhtks3HquBmsVshkv783RPrZMSwRQg1CDK2+YXWCjtvx/3f+kEMZ879p?=
 =?us-ascii?Q?6sJqttAL6IJ6B9ai/qQKmWH1CMwcBI26WnAxkab1X2z2RVnNVWTq5Lq9lP7W?=
 =?us-ascii?Q?a2Y/A2oANYoFR96eNyqocKi/AqwpaMkMwrDLaVEONaeT0sSRQHPKURbTKZKY?=
 =?us-ascii?Q?9I5YleQVAzemQlnJBsb2k+VsTiXJfXr8lP5wv7sADGs2szhFRV3ig/BqYz4l?=
 =?us-ascii?Q?3N6D9DqI8I9+S6r6lHgyFunSu7ypXSuwAvF07N9jrHWg61S+Kz56knMXnvNH?=
 =?us-ascii?Q?cbvu9ao0V86/0q1YiXRcAlaBY6sY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?35gecdnO0AkyhbcSMi/8+/mveT7e+wtg7bhK3qxx/54zpDHuRioWQUL61PEI?=
 =?us-ascii?Q?tik661k+AhsggLBXOhNs0F6Y+luPaFu2WAC1m8a752aYsrAXUVfecOwMkRPs?=
 =?us-ascii?Q?w+xqdilzgasFLzXQWBHCPehAtoefcWc6dWErxilb7SGSZp3RTT4UkZ9PrHBw?=
 =?us-ascii?Q?5wubQpA8fcty89xNB7k+uQwcQClnI9QG/fPtOvUbJxj96nBFQb/Rb1SpI+My?=
 =?us-ascii?Q?SkRPh28FvVmuggMOUaswXVfnzFuK70wzxEDMfaR6JHggfvKMkSd450zt2k/d?=
 =?us-ascii?Q?K+nibZAuaqU94DzBVdhX1XjS24dQ2MQpGI/Gjrjo7QvU/ouVOuVJBd4I1med?=
 =?us-ascii?Q?4wBseaxCio5PkNyRFKo64vdA5uTcHrk9gU9DiXsQzj/Tli/C8bjzwhyF9E/m?=
 =?us-ascii?Q?d0plHuxI2fb0tpSZ1G1VnuYssPNPefGQmnTpmvsg0w2JLa4PJ24oV39gVMVO?=
 =?us-ascii?Q?JSZtZqlWhjssCX2LuYh2z5+UBuGuaOAlaNf0/6tP8IPr7wVm5Ti342B49LhI?=
 =?us-ascii?Q?blWrbiEOdGpeIdjTpVdjenxNYA2ybY0w1EfDDe/GLz8bhEXTjcGoUbxJXTbx?=
 =?us-ascii?Q?Q5tGJH0T35lnmWjny0+KlnhQPiUxVUaSuu/JMzSPj4gJt2f3LOlMTJp/c8Hp?=
 =?us-ascii?Q?NusttHjcnEeKMDTVqgvn3AyYbUupegm5+Zh+ae0VYaKw10GdRKw/d/K6sNJn?=
 =?us-ascii?Q?7Jfh7cPifBv0rVMdEGv7MqWihXf6/eQ9MQBDN9mmcgaf2rRxjGVwMD0/TsZC?=
 =?us-ascii?Q?mqFgX5l7u3aRyjoy5rP0VMWip7wg1jLLoUd+s4XNjtou7v7cFbnkUJQX/dVN?=
 =?us-ascii?Q?fDa1Zd9zN3vZWgghd4zoHWTU369CJZhFoDoapCNYln1v43NkA3WHH60TwFbI?=
 =?us-ascii?Q?uomuTIXwiTnaioZoHB4T+tAY4jY2cLeDdtma6X6CV6BpqYxQgHAZmVD/fVL1?=
 =?us-ascii?Q?vJ5o2hx5AxeUqA33HBFmHBVF3GYydPb429Q3VZX/DuJ/PydlIOEmhXoaWAg5?=
 =?us-ascii?Q?20ibjQJegmAaVWEiccX+OCyE/vDbku7r1h/Q3dWis4afg+XXhrB13CvtEFqy?=
 =?us-ascii?Q?uEQ1gFF9XfGW5SSJDxuNANo4UMMFCeHTpLKeV+4x1A4EyilNUJjicsIlxC8z?=
 =?us-ascii?Q?3gPsGtCXWXhYq7jEGdmRyv3KW80LeByuPkI4g6PKTRxJC3OlbnWlMmEjehgB?=
 =?us-ascii?Q?/7bXm0KBc7PQRkocvRNFFAD00GDQOQJJs7jUfx0ZkJMUU8g6+A+uZHhGBDqN?=
 =?us-ascii?Q?i0cqkcUXovai86phb5Su/QgVT4vgAKZnBjQ5YbwdcYr/RHO7ZBAVbJaXMsQs?=
 =?us-ascii?Q?uANrSHsYW0RW4Cmsz8pNuxorfKk+ViU3RVKh0kGd/kuMTOPeKVs5RVSOJ2QJ?=
 =?us-ascii?Q?uaIQwvw8EFuTr5IgJOOfqmHRRxEsmtHSmKAL8RsNlbcEuAvPiurT1F2cpC+s?=
 =?us-ascii?Q?SuiSEFljmPKp3J+rbUxi3Xfe+8lyoMWSehNbRjcYXxvD1SAaqQfo5kFLzMTn?=
 =?us-ascii?Q?dqWOFJi8bGjpk4u/IwpY2+vPTtYDnWIDTuN0/5ZajionXhpfcj5FLI4ahXMw?=
 =?us-ascii?Q?dZTt+lBYVhuuncX2t218rFCwYXU6qUIbwsQ0I0Sg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1792b837-6f83-490b-a131-08dcee781bac
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:51:20.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/GR/EKMqHU0VewwMtUGVXhLbp5A/KkDAN2YQ4haA8Nf377LSx0BQ8cuSfRZ7nlUek5XogLLqQrvp62FMT2JhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10148

i.MX91 has similar Clock Control Module(CCM) design as i.MX93, only add
few new clock compared to i.MX93.
Add a new compatible string and some new clocks for i.MX91.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/clock/imx93-clock.yaml | 1 +
 include/dt-bindings/clock/imx93-clock.h                  | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
index ccb53c6b96c1..98c0800732ef 100644
--- a/Documentation/devicetree/bindings/clock/imx93-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
@@ -16,6 +16,7 @@ description: |
 properties:
   compatible:
     enum:
+      - fsl,imx91-ccm
       - fsl,imx93-ccm
 
   reg:
diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index a1d0b326bb6b..6c685067288b 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -204,5 +204,10 @@
 #define IMX93_CLK_A55_SEL		199
 #define IMX93_CLK_A55_CORE		200
 #define IMX93_CLK_PDM_IPG		201
+#define IMX91_CLK_ENET1_QOS_TSN     202
+#define IMX91_CLK_ENET_TIMER        203
+#define IMX91_CLK_ENET2_REGULAR     204
+#define IMX91_CLK_ENET2_REGULAR_GATE		205
+#define IMX91_CLK_ENET1_QOS_TSN_GATE		206
 
 #endif
-- 
2.34.1


