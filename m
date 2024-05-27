Return-Path: <linux-kernel+bounces-190168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1DD8CFA7C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1954E1C20FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870B136120;
	Mon, 27 May 2024 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g0yZpjnQ"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AAC2E403;
	Mon, 27 May 2024 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796227; cv=fail; b=D34uI6y4EXuooU6AZUW+/4jsPue4hicfM8PLIuStSo1aTVnJC3oMBCYc2YqF6QDdDo4yXzLPU174Xyokvjm1BPlxWHH+4hp5d6AEk6KRFGEejBUuMPv1SwLzlKJkSM1d1L1vZrtKe4frToFjUTWNpawiwOOFy7DD0JsKp5Pl4M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796227; c=relaxed/simple;
	bh=WR0NNIeUX8GHVKJcjOaokqTy/DiyjvUNxKymcBOOY1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KShF1nnLO9WXxhhoHoWKl0j1gJ3S5HiJmxbTjjDY65rGPymalMJAIvL8iz5ADThn/YFC7FfxjQj//DXmdpGBdXJGYLozF1vDxcYLhCVZ/gpV1xenVZrTitj799C7JownXi8Hy/NeIIJ50RIPK/qyJQ6OhW2AFJaYJekde0i1GWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=g0yZpjnQ; arc=fail smtp.client-ip=40.107.241.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qlf5cQtNmGm/vUcibD3RMxVFjwHfVONAO/zWS87Rzb1XIoRKYVV2P4n5xkUmKggB4odo/Ieq+apB8rwYefnQOYJAHuf1EUgILMzDZR2ROhFBbli3nOt8uDwx/5pAZTnL1LoFB1gHjJfhK7NOYwLbqjtEdWd6L+Ii/tW1Irk+GrZ+YahYK9ELSEt9VzuJM77ekdFOBEMydwsTcXIxIrkfz9NKR3uSWddI8PlJSiqt/ofSCP1oqEtNizGmtIDCfaFOY1cOKb6oyOwcZwOsoYJ9vF9pbNxdi2mKLzJNYVWEwx7ZyZtSfiwvRTxaWewyRV8cTvFSjcdtLfTB8TgOefBTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuwIN6qRtf7KJGto7VvZ0CDP/XVS0gIl4Kbb06ilxg0=;
 b=fBymHh7Jmz6aC8H7SSMLFjg4jNxeKyuJZVzUdGfoftG0do04YcaXfVWC9oukM6n8dfF8VVongv28k8M8j1KnD1ODWr2GXTNypkurn8lab3BrRwtSkK+U0YzpbnfXPrBswuJIx73x+E5V7iGB2g7wT4lw6dkurtFUo/Wj1eiiNpNSPNuwazatzrYB14ousQbXpZCf805f6T+/FCkt1iPOTUF4ws8kt+58KPFnHIiwI7RJYbv8YousKxyyk9OxMJc+PeTcWIpYrG8WHzlDegO7p2YNKi1AfpFEnieG3dXZVhS0bjCSShDxCK8edzkS9FTopkWHfOrryUpXuvQ690+jxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuwIN6qRtf7KJGto7VvZ0CDP/XVS0gIl4Kbb06ilxg0=;
 b=g0yZpjnQq+FhfHdqb5rpXvKcTU+vEo1V4ILFiT8rHeKJSr6Q7ydzY+ZtpepcmopjDH29ycdlCG5RvjsMLuGykMiiZ2jrH71Eceva0lZZ7TBUx50MNE+wUaeWAzZ+bggg4ojSnyMnujDBl+x3xOql9cgZsZ4exLa4ee7nBttMkWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by PAXPR04MB8781.eurprd04.prod.outlook.com (2603:10a6:102:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 07:50:22 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:50:21 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: tharvey@gateworks.com,
	alexander.stein@ew.tq-group.com,
	gregor.herburger@ew.tq-group.com,
	hiago.franco@toradex.com,
	joao.goncalves@toradex.com,
	hvilleneuve@dimonoff.com,
	Markus.Niebel@ew.tq-group.com,
	m.felsch@pengutronix.de,
	m.othacehe@gmail.com,
	bhelgaas@google.com,
	leoyang.li@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	pengfei.li_1@nxp.com
Subject: [PATCH 1/5] dt-bindings: clock: Add i.MX91 clock support
Date: Mon, 27 May 2024 16:51:54 -0700
Message-Id: <20240527235158.1037971-2-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527235158.1037971-1-pengfei.li_1@nxp.com>
References: <20240527235158.1037971-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::22) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|PAXPR04MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: ee18c940-50e7-4a0a-b944-08dc7e21a891
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|366007|52116005|376005|7416005|1800799015|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?4/RFZBW3JT8OIXktEfd0uv5g+Q059Fp/ONoLSeBZv44T2X7H3TA+pfYjg8BE?=
 =?us-ascii?Q?YDMxjPkXSoDghE2qb8XcjB1D2N7K//7vfSbV+XW6BSfU4MZCyH8vG4D+pGd6?=
 =?us-ascii?Q?MgqjZ/StAOe9b6DZcyHu2sXBA5Oetwox9W9mWrVAh9OM0tZ5dGlv7myeSMXN?=
 =?us-ascii?Q?HWyNnSSvRFRUzJP/w0SyRNg/GW/sgmzTIdigpBJjKrAHiiqXzGbYeoniTbxe?=
 =?us-ascii?Q?Dra7YJvWpwOhqIJAL+/XLiKKzH4l1atsr+oMhoaKqRiYqHjCgcIbB+4HZOpa?=
 =?us-ascii?Q?F9CbWwHXo5j2qhm5E/325uIKWjN19NMS0WnV+zAwghy/gUwxHpE0TgKz3rbk?=
 =?us-ascii?Q?vAdMES86UGPJmGYex1ITefxGKwMDrzUFVoQUgRxrnCc+xYeTa62JRKl9QSDc?=
 =?us-ascii?Q?PpKpHi3MNCYG5eEDyDGWFOZdqZ+p8LUvd/Uktsxr2Z+R9yqlJLsJ0+q9ZcPI?=
 =?us-ascii?Q?ffzKcXVnxrviwV+nk3x6TGp0bcthMslmTtv3dhE+k3TgTE25h8Q6/eDPwHQd?=
 =?us-ascii?Q?oOZGmvezcfmYg/UQ4Dpf01s3+ctIfN9wIGYvBx5abPMv0w7xVxZ+S/oosJ5d?=
 =?us-ascii?Q?uWBNuC4vYGibDyJHd9PnSCSxYGydDLxO8OunFLWqi1lhdifunXBeMM5PJIJn?=
 =?us-ascii?Q?vuHiQYUJ5BJOOjy57lm4dRddbs1zqIaqPKhjEDoIsp6c62F+lbSg3H/51Vhe?=
 =?us-ascii?Q?bh5fV9watKqsQNCj4s2k7UgSSICnDiaR6ITuVzDxgQh0DwuQkUlNl0/yhd7S?=
 =?us-ascii?Q?+g45xtQ4KbKtMn8BYmoNDnPm8Ao2alcK3hX9k61kq2L2b4+UdoVnuWt+pD0b?=
 =?us-ascii?Q?NxglhzhXOJHsFMD+ldSFMDBZqRIKV54zD9Qll2REfbDeBMIczCoAYqf8FMXB?=
 =?us-ascii?Q?osc4UCAU/PPq7i8IyrW9bLHwpO8AjSZNV9GnzEh5LAicnAwg2KIhFAzqh+tL?=
 =?us-ascii?Q?3NDkUG3vXYLTpipWCTnXosue6hzW8hH+nox/+CBjs78er5lI5MWk+re823aj?=
 =?us-ascii?Q?N5bA91o6kKY0AFSrnPlBeEhm7tSE48T4hLpVVUuaXyOVA8up0wRZheJ7ED6L?=
 =?us-ascii?Q?HpE6FOcmFh8itVl3Qy0eMhR5SCqgyZkYUd/5ZRGCAGNtV28mf5UEou1DLt9Y?=
 =?us-ascii?Q?eTplp4v5pRh9XmDjjNx7MIq41vmFpW4gZMG8FjPgWcVYZ10aj0WPbmhh7mIE?=
 =?us-ascii?Q?D/e7+urgP/LNoX/Avc3xDfxxNVFOn/pYMv+b17gUFXrNWcKqRB+DCfGG31r6?=
 =?us-ascii?Q?pYTegPQ5Q7TuLs4txZFq61CjYINxs+Vk9W7OzdyK0hEnFu8Gd6j3G1QAV0a5?=
 =?us-ascii?Q?ZvN8qm+iw1kWsNne+hTQAxa5cMIZWDIk9TWqehNeHxCchnaJuLm/MrnvIqvE?=
 =?us-ascii?Q?Jr6ZoeU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(376005)(7416005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?BQr/o33rPQQbe1H9juUFowpQ9F89dChIgWDQ9qIKz2DyMcT0eTi7wcezZ8JS?=
 =?us-ascii?Q?pADwmiOjQ+qYwF+ZSawX+qRFT6eXqh2OjAzYV3FSrGvnNOt7Eh30MtUtvsah?=
 =?us-ascii?Q?QOAincuJb+rUkTnXFxU4W4w4cHWJ+2iNBsZxTT3skNcLV710jRAl5AYYzlDG?=
 =?us-ascii?Q?LlvCfFRr9vF9ZR5xqa9l+tuhYMLTmxRPQYx7nLia4ClfrgfwRq962DzZlCCN?=
 =?us-ascii?Q?9luCo4Y/5QI+jSizZ4q0jGPA+6MdMMuAONJiExZXSi3lAAMUP7oTIs+YE4Kp?=
 =?us-ascii?Q?0UrjW/QWKwmhdJ+BD3W8Pa/tfZdGnnusDIS04Et7hQYjBaiinw+ljKHt47Zs?=
 =?us-ascii?Q?MzmB9KjEafci1ZRMblRk4P6lRiEfqBCHl2pbEuhDtIEOBNb9cySIPW0Z4Y8I?=
 =?us-ascii?Q?PyrQ9TJR2XkJNTAuJkmCVTFMTDe4hBRzoRpHE4DAqaXLg/X0akupzXSmzl10?=
 =?us-ascii?Q?Ik1zfvWI3ri0ja8kRja5rgKbzpdgD1oDpwEfvpAPhJRbO1wYY/3b+iX2bhZl?=
 =?us-ascii?Q?MkssnkbmC55aL4dzhBNqt1E7b+oALctKv7wlavPbQpNH3JxlNCbAiXBGSA/T?=
 =?us-ascii?Q?pOpXHtTrzHTVpi87JR/VTkKYZuERlGVUW+n0c/skzrTVh200mhEF7s2TBfID?=
 =?us-ascii?Q?ASJ6gCRi01B+7KDMGDqfRu2U0yIdRhpotDjWXUgf2DdCuvYfVqTurlyMU3OJ?=
 =?us-ascii?Q?MzXXJcPLzepG8CXUPGZRdGFqagaiJOpjPR8beoWnQAUOv9hn5QWnPiQMCrtU?=
 =?us-ascii?Q?lyM/7JDU/oNoEzw8wDdUdeeoKunMTGHk/mBBd3wjxUuq/nK+KWtCWMkkNFxy?=
 =?us-ascii?Q?Z4YPbCPoZtNzEjcfoAvdgLRqjzPhZg5paSQgOW9tHw4cmBR1dSVGcK5MXkrg?=
 =?us-ascii?Q?0mWCl/J15svlmkvpEMhQeu/QqDB7jVyU3haZbP+hZnvgMOYFIwR77jSTygST?=
 =?us-ascii?Q?6eURpBJb8aq8prPtjBco9HydRLDQAqOoWcYrxjzGjcun3oydr8tO612ZKBSb?=
 =?us-ascii?Q?hMsrPE8B4tmcusf4Bd5SpSFAS7v/DJVsjDfWWDQwHqyWH0NX1OItqY4FmIu9?=
 =?us-ascii?Q?AJBA8wzbcEWNuqEUXEvyKVhqPPjIYNe6uxGtEuBmxBuYLLN9zyi71WyLR0Dp?=
 =?us-ascii?Q?Y3mkOrL0xvxXyqPPy/Y9SpAtMRjr6KkNDBEDSUxCvm7gNmHQ9fE5q+SM82gv?=
 =?us-ascii?Q?N4PlKcRL4vVDEvnGqv7tCkfjUJZyzzcq9ErpCwXviz/9sihSU9GvTxraoLMw?=
 =?us-ascii?Q?wH0rHqhFUVgQ+I758LNQh99+xRfVhvLYDPbK/0NVkGeTTN1X4lQEoOkkSgvG?=
 =?us-ascii?Q?ciPlLunTRXI3OJl0dimkSxupqmZHDPhKGSrBy+lCdU6h83rHPNUbedudFL8a?=
 =?us-ascii?Q?d5Y7f+N1wQzxg4haAXyNo4ABVbCBKf0sR6SeoSjqganvmEjINzrHkExD/tah?=
 =?us-ascii?Q?msTVsXN6Xf+wBb6tKCaSb7zBDSM9Ieh1z8YBxy7FG9K4f6Mz/MkZU7d4kczE?=
 =?us-ascii?Q?yKEKgAnCaahgEya5lE7nYjKF0FkrcgdfrsNeuj6O5SGw6bEWjU5NCJNzDhKO?=
 =?us-ascii?Q?2ooOS2qLOM8mB8Q6QlNIfrqIGw9NS89NAoS9gjT4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee18c940-50e7-4a0a-b944-08dc7e21a891
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 07:50:21.0335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GhWM7/F2tLFv6OT17ZaFiIiAEodaQo5ftpLR79JEZOLlhxjutv+32N4AB215YbTsNJqMADq4qwsN5wYqEPkSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8781

i.MX91 has similar Clock Control Module(CCM) design as i.MX93.
Add a new compatible string for i.MX91.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
---
 Documentation/devicetree/bindings/clock/imx93-clock.yaml | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.34.1


