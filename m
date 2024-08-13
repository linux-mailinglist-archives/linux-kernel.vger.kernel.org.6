Return-Path: <linux-kernel+bounces-284084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA594FCC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE27A1F23B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88801F95A;
	Tue, 13 Aug 2024 04:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GEDyl3nM"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2089.outbound.protection.outlook.com [40.107.249.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F891F959;
	Tue, 13 Aug 2024 04:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523658; cv=fail; b=PAjrfL6F1JbpWhYY1BXKiYh4lmWKbmipM3PNdjMuer61+q0zXi7zzqJe3W0iuCVWmLFhsSTvc1DWpYdd27cXbZ2JwQdwKqN7deq662gGaaXcb8k27xqclP/eKuMi292lgE/007ukaeSdKC5kU9BNu1DqOpxkV/I7q/QqgvUySew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523658; c=relaxed/simple;
	bh=hPRGEHG5X4idGu7+jA+7unQ1Q0STfYLVJ5H7n5Qu3/A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kBLxebj4oETXbiGuIKDvUWjRD8MO0LhOACbo1bxs9CRTvkL9Xj9wNyCSuom4vxba7/KMxcCT/FTP5CvDKXbRVHTwf5J0DifPLLhum7RfdNJSVwlNCLzn9ZlqG5xcDPlF1Ehg6jd9Go18ZYNX1UZZd1WIoW9du6sJLC0y6NWdlXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GEDyl3nM; arc=fail smtp.client-ip=40.107.249.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxxdYX+TUiIKh+vpFJhISF7I2crTQmAE+jF1S5VuozMPL/vZHBf5XK79mBNSNdI8OmdbMww9wPL7i8NHBODIV1STvutMp1/YkAf0kKdQokPUpmApa3HxUp5k+a1rfKymAJ1Up9CCfH7aEW4xn/BsIxL7w76AqkeVF7QiEVWwdHQqoT6cLHz0XINuMsm6DRdH9tkkNGFryGrql9Dg2VjFgVs8oXn5FRbKOYIoE+77QDwK/AFFldmhVdWmyojFWTvsbESb0PLfybjAlLuMLZN0tb7HG6n+mI/RXMs8mxwkKphjIyTN3TWh6JLnECUJlUwjYyHIvoChdCwIp4n4iZO8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSWDOKr2iMpyKnL4ZhVwTy9KqejKfyVBQzhhe7kbyeA=;
 b=WNQ6YpauX0H0dkRN+AlnQhoBltvHo9Zy3ZM5XWJN5jD+sWdyTXngEZZdUw98hj86svmHHY6tWXEJm1MLVnRY376/YQbyPeUxix57+viScgsV9270kgbeYzR5Mj31afmBxDMn3y/TqYKof0fcxrc4WW+p2Qbcn/HixJjFEcxtTYRZExT64FBcjdBBlJT1Bk1uq4mSQOdHRYW1p3uHEaTWiMWdDXjMDYWLBn8am8/H2wtKE+kAs7d9t4ng1aj+EypoDx8hQcwFFi5E8e98fd64G4XKWTz64F5elYYShotOYs/LN9BctILF9tfRrCbYiSR4eoVnNaw556aL9VlZ9MrEEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSWDOKr2iMpyKnL4ZhVwTy9KqejKfyVBQzhhe7kbyeA=;
 b=GEDyl3nMTFFg69E1n3fOX2xu+jsq3+hzUbFDPNsmXAhIS8QGPd37u2Aa3qebQhypLbVQJ2Sy3444qy5VDEBf8yl9iEzN2tmoLMCrDlgemiq9KnSVlWaRRD3Akjn+g5WVFmnaVZ0Ey5vZzhD/QejbWreJSnifcJrMvc1v0PX1EyM8mbJx4ycEFrX7EQ+l4e5EGk77Crl29dwWqC///zefgI/RpYX9lm0jOv7EwhOQlBSpYlBy5kNxCCOnLrzcaAYnrxfFGvrR5gyXnQDpbyE4JSF2tsLR5s+WTg1l/12y1l5ffZQ9COogdVDc3uIfkXsdDnyn4tMHxs8x4V0SPuYY+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:34:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:34:12 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org (open list:NXP PTN5150A CC LOGIC AND EXTCON DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: extcon: ptn5150: add child node port
Date: Tue, 13 Aug 2024 00:33:53 -0400
Message-Id: <20240813043353.3853595-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: 018d938d-eca2-4ea6-dbe0-08dcbb512e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UKZXPQRIy+dXy1qDyQO5fqyvwZjlX4YDR8dfV4xP2cX9OtP9GLo+x1tK6xIY?=
 =?us-ascii?Q?+RJ0JOSthlEldSk5DV0ufJ10YV3fg8wPYU4DVDBlqRAvsFsUwtRfgD3zPXdX?=
 =?us-ascii?Q?ILIe/Q1t8LsAVRQfypMgKglz6zlpGJ+0fuwAXYo7MY1qC3kk/KV0Dpft+oOr?=
 =?us-ascii?Q?kbeBmJGOytskcl2sCN0+G7BaI5hXvv9P6jfmg4M/Qfqs+dh8zLqULm94jFCO?=
 =?us-ascii?Q?HhHstdRnuDXf/z8OlguVSkMEktpHOKkRArTL01COJSQD4nFtUjv8LQ12aQ8G?=
 =?us-ascii?Q?uIDcsAskP+/q7MSc0azDP5UsJTIKNp+kY3cPSNZJ+fwdKGFfnngftVDBsoQi?=
 =?us-ascii?Q?28r5suaugmIJtmn5+Vim9fCZGsQUmtsI9qQQYW7duD2Qv3dSyb0eVEHJoWtP?=
 =?us-ascii?Q?YVWGMAS4ur6RjBo+4NhggxTZ3FTPYDczOhAPlWTTONNTRSjKhQkTB9GlUMrw?=
 =?us-ascii?Q?QbibD/7id++tTU0na29hA6drUJagrtiW40+3wjP4NL9zcBqFh1gb1szG3yaU?=
 =?us-ascii?Q?p8qyOY5vMY/XAc+IeNCOAHQEyIyJ4lChiHD+TsJcIXArAg4IfRtV6wUW3Zms?=
 =?us-ascii?Q?gfD7H1wVmsTgMYFVQq32esrjsMUWlZOQp+LrSniV3Ly9z7AZBpetMJ7+atio?=
 =?us-ascii?Q?J3N7YWDldcDItd2hs57OV1H5tJlpMmPotdeQcBgXGmm+f1ihBjxi7sbrpWaO?=
 =?us-ascii?Q?zbxdZ16WOEUhnbTlmEl+BTZxUJZ8XV3Y9zLCM4zP8zgce8cp49Iw2lqsxU6U?=
 =?us-ascii?Q?UeZzf1Qd3bhSK84Ajl35RuqcQT/o/OPLtKFB5GGCrvHdwLzNuP4zU1T4d2zP?=
 =?us-ascii?Q?8pXy3bmGnGCm+47ZSKUmV76VTL5RKgxoRdybHvQZyH6o2gWwHBGJ2E0RMcua?=
 =?us-ascii?Q?ldB8YJPgQoAKyE89HeBrctn8sA++GhXhgbOUgER67DC2TkdyvxXO+6egh3te?=
 =?us-ascii?Q?G5n6mATchxhh9dmi/GqdZ4c617xbvpDQCALF7cIRxWMltluDEi7HwLEPuC0v?=
 =?us-ascii?Q?YJmziJq4/86Db83QirlBYFfrRucMgQyL2fSh/JV6LatpFZK5PfaKQa4u5d9S?=
 =?us-ascii?Q?kGj097GILv1+Iig9DZj85QOGa4ZehEe+iAqutUwb2tbJqVA8XvtTm+kIUnhZ?=
 =?us-ascii?Q?Ii1WTNNMqYUsAzjWDZKS2v+WYNsuGT3wX1Yqx0pYH6bL6fDNH9LyreEUTjw1?=
 =?us-ascii?Q?f74DE+0l76zssmr3N8nK7WHFFyRRS30T/lWyN+FeExoBuMiw+idOmuLoabm5?=
 =?us-ascii?Q?oUUh4pP0zZ3yd6fu4L3IM22OqQ/FmuAXRB8bMAaKe7bXluyVORiUmnsvCV+Y?=
 =?us-ascii?Q?5TP3OlFdIx40RYLmyHH4hazY9z4scQ3xwdKUFQy1C2FF5R8yXtkJ3vIK6phy?=
 =?us-ascii?Q?k/1OqSg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QUYR+BM2f31folbU07+oxzzzm63rz0wIdYEfmGpmBfpGWcwz0ZH4s1RXunVc?=
 =?us-ascii?Q?OPDYbtQ2I692gc89G7mcmuften+YGY+pzECUDxJ9DrbFHijSea3RHIVGB5RK?=
 =?us-ascii?Q?lVOe/rrzW+T0SM7RTxiVKhZRGkoBdMtWA1HXknHk69BltSyHGaut95K/YYSI?=
 =?us-ascii?Q?kGsbk78eROZtSzYyYoFDUCCMn9EYrb5DyQglKyp1vrTV4PhsHdPVUJrZTRf6?=
 =?us-ascii?Q?E5y2SdnF2rdqtCMranjG68smdri/qzjmifIPB69ocjZNpyQW26EJgmVIDgxY?=
 =?us-ascii?Q?PNu9noRagly3jeI1Rzw82TdFUQo1W+e+gD8HC7rS91fhGfxM1+grVGbBllba?=
 =?us-ascii?Q?Cl5yBITg8gTVplcifIe5pu1H5SLax737pOZJWEvRwfqCiT0QDlDDLV3o0QAR?=
 =?us-ascii?Q?yUursREa1yG9JQi8GreTtJptNdg1SzBPRov56sdNaRR4rKBkoz10MkX80kEx?=
 =?us-ascii?Q?sdeE9JzMw8ynYHdVwGgWVzVJ6RRDu2QOzjNRJ6fOXtKKJTZW3p0xkNnmvq7u?=
 =?us-ascii?Q?tRoUxr37vvBMhyRdU5R5wECKAYw2K1UJ0VOplmYgg7umm7Vqw4cupKsSD3/M?=
 =?us-ascii?Q?FsVmGJ0mY0Dan8YcF2nkre4muOsxjoyy7X4nPZT0UXcZ3XqSLsWN1KV0SIIK?=
 =?us-ascii?Q?LJQSNkWS1+mkQKCgvBir8gmPhaIrtjLydA1OqbsUNEtuhDWWTW/807rSGLzh?=
 =?us-ascii?Q?Gig9OI7fBv+Wu0sZBf7K3F1cchsuq2fW9C9yN9BXjL7INqm+g9blPKmi1qnw?=
 =?us-ascii?Q?Zgj1RyyzTXW9g3+LWQN7SUSEFsfgixpXLhzCkzdxYRynoUw3ChOEL6bRdMyS?=
 =?us-ascii?Q?xhXv92KLLyQldKh42MkWVmCO/uWuN6h4xgcdjdhV0oa555Vde6vQLFl7Vkhv?=
 =?us-ascii?Q?GxAOhyd72XxWjzfK5busSVFswnuIChDaoh6lRSihViAKd79cGJjETBOQTjvD?=
 =?us-ascii?Q?sqxnA/uTDJxSisOIaRojCnCg7yXOpNbKb3mh6bqekTpBKITDR8WnMnqDgGJE?=
 =?us-ascii?Q?8vGr78AokOiwCB650TMLpPC5Syggs2EDYzRjarNeJT47L9M1dDbP83tSjqSQ?=
 =?us-ascii?Q?cQns1xOiVETH/XN7ROJDulz+pPyfJTbc1qSTPAfqhmHy9SRjuU4St5assTbY?=
 =?us-ascii?Q?ToF5ol9RuZ0qE6GCRJ+3hQqRmqBGDLrJNfSgfyhkV6kZwC897Kr5Y+BOSiSV?=
 =?us-ascii?Q?fg2orlxDEOiKgHdBFKmEhTE2wn9oklhmDNKQlysi9mcNIcpdDmUBeV8ZfpH/?=
 =?us-ascii?Q?aBvWhxGBWCTV7bScXNgFrjel1GGlp5OShJUk3NJxweRnsnTocLg4z5CNDvzC?=
 =?us-ascii?Q?BN/5wh73SjfOnhmCd7Q8wVT/XJkvbVqbJtKUdNmKw8jwOdTrZxu9i+wn9FlE?=
 =?us-ascii?Q?Qbzl9UvdR+jotanTJrJ96XG5gCmqdu2GfXH+N3m+mup96+jhstP0i++mRgBd?=
 =?us-ascii?Q?3Pe+ACDJMQWa2thcYr+0RPDmzztRavnOemnaN/BbrrolfVz4STb5vwYtRU0+?=
 =?us-ascii?Q?zGlVvM2EvgI6r7hV/y/PPy/Neqthbib+j3XdPh8/RjVFsTbdGO/gQb+sRDfE?=
 =?us-ascii?Q?lPSWFP/i+lEdW+FeFeU1FfLsy1Yzx5J6aigL6pmo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018d938d-eca2-4ea6-dbe0-08dcbb512e11
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:34:12.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6azRi+yg0Ia9bzbdDMilt4fdpJFGZjmIpEG1ke4VDqM1PnB2ij2znmQOQ9uwfGnE8l6F8Qx6bFg0cQAX2fnTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

Add child node 'port' to allow connect to usb controller to do role-switch.

Fix below warning:
arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb: typec@3d: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/extcon/extcon-ptn5150.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
index d5cfa32ea52dd..28c34d78708cb 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
+++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
@@ -37,6 +37,11 @@ properties:
       GPIO pin (output) used to control VBUS. If skipped, no such control
       takes place.
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      A port node to link the usb controller for the dual role switch.
+
 required:
   - compatible
   - interrupts
-- 
2.34.1


