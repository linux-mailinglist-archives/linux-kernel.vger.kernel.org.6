Return-Path: <linux-kernel+bounces-231460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3011919902
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FB21F22A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312BE19306F;
	Wed, 26 Jun 2024 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ff5zFS+s"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90504192B9C;
	Wed, 26 Jun 2024 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433566; cv=fail; b=PteURbs7KjT9bDPpsyI6HChk5f7mzlHWk22Z+OMNBQosOza6uWzR3QkLgoWtrmXFY9afD+fq/itySYI95x1dUbYLQdAb7xzJmJ3WopWRfc2alihpODY/oxErwsGSTU+wz2hqAkw2X6gfdiA8k7wu91BZYKmns4yQpyueTBCpIz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433566; c=relaxed/simple;
	bh=tOOD5xuI8F1n2ZGQa4iyg4K5CPd8xD1hhBRWt4azMBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iKimlRw9iUy8U5ggid/YzrkWuYMLrlp7LjWm6wwRoL+nJfgVt8i4tF8TtZHAY3bjelgSr4T8vjaM145q2T4vcghfoXMfQZyMRlkr1SlSMDqZPFyH1g1VufFhBr7krVDjm9g5ifH5V2d0eF/lQ3/j/RLUMMqhpGaA5wFrIHvGfmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ff5zFS+s; arc=fail smtp.client-ip=40.107.249.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfA5MEB0fpjzD86WnhyW1tkp5oipTC2uWHLdCCRycASnXlv1jULaorHiWPS7/Ks419pOEGH6Ma/I1QDUaB3W3KWlcJ6ulPWznCBK1lQ2MZqVuEj1vJ0eSvR7IJDVvrYjZtKzVObrRQws+uhkG8KE9Z+zd7pjdGpreLzS2zbvy5uiaTPEYas0ig7PVuT0cUQxjAi0ORazZ8Wu5Jb/rIMeGuOrCPl84bn1/UiAWBSdV69iJZ/Q7tI84wR+xnLrikZ13XdtCqw6dpctdooUe0R4p4TycWmDx3Ofvhhw+mydPmArpvZeaMSbW9Yv4mmabh7Nz/vFBjRuEthwzgNYpxGbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWzHJKaNVotSUhETyUlQAaE3csZ2M9rmxEF6c4Hiza4=;
 b=enqHaCB2kO7t/vIekc2MzVZuWZbv2LKNW/htxs6giQqmsI2GAiGUYTID6jVPHTYi/TpUPxnL5vtS8/L01gahlGa2HxM2cC7keJqdsV/0a1hO5vsh6/B17SkwW9p8/SDYKkc2eYUAMtSYte+44dyneN/1R/CHfmc3dZcj44dHYDLd3PbI0ADwfd1jM8/NdarhH9SH0YwoaTEym4KsXM61VaUUHMjTnVu55TL6v/mL0vMRbV6LGMXQrv/S/e8PQYwLLG+PLjV8eGxhkFG00+1RHo/ByHE0/sRzsure4Tf+3ke3b7OiwqhOPLV+5ut+UiqbPPkkKMsrwCdb2TKksRt7Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWzHJKaNVotSUhETyUlQAaE3csZ2M9rmxEF6c4Hiza4=;
 b=ff5zFS+sY0gMyuH8qPZhUMOiKRxMzGU2YJMgIrrbC62MvLhPLt+5eEnktxL8MJPTQvEtMGl5Li36hf0YsTDedGnCtVyZ/NGLUs9fLUrLoqxF6AhCDOPw9YCIwXFBYbHKLRxktl0iPElWt2CtgAagY6f91BEsTXVOf/BNYaPrt4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10838.eurprd04.prod.outlook.com (2603:10a6:10:581::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Wed, 26 Jun
 2024 20:26:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:26:01 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 04/13] arm64: dts: fsl-ls1012a: remove property 'snps,host-vbus-glitches'
Date: Wed, 26 Jun 2024 16:25:24 -0400
Message-Id: <20240626202533.2182846-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626202533.2182846-1-Frank.Li@nxp.com>
References: <20240626202533.2182846-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10838:EE_
X-MS-Office365-Filtering-Correlation-Id: 9030df38-029f-463a-0185-08dc961e31d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1/ZGAUG/g2baOjqbYKsZIRUAfP+8QnOk679os5RvFWUyJq8/E8bk+br3yi7a?=
 =?us-ascii?Q?XplqMYMH6Y3REl/0r+Z9yxfRJm4X5KBHmvy56axtsjGxqrkskU4Se4dz+rkh?=
 =?us-ascii?Q?r8EZWduZxoaEPXslpimmhyuCmHMiNgKjULTypuzVD3H2oHXegyGESNnw4jNF?=
 =?us-ascii?Q?nK7m5RubdwGRSWenRYijg+PyIN1ZDpLR4laNqJOMCMqUcXTGJZJIqHo0o9CB?=
 =?us-ascii?Q?sA8PX6Pe2gL7EGNmukhmZhjYtAs1evl32UQdX298NT4mIzQ5qY54E1YYjbp+?=
 =?us-ascii?Q?X2m2rTsdp7ZtBkAV0KCHh1Ya8oFlQnGPGpFWpFAUASbUVmPIlLJKopWZYOuC?=
 =?us-ascii?Q?mQr174sVW5WkxsXBKYKxBfhZt9i4HFthu2q0MDQKwRwd6CM9cE4gVocnHdE9?=
 =?us-ascii?Q?HcR6GVaR5rmPBYTioQXa+hNJI+VvULsJIbAAp7wU77prT2nCkznO7RCtkPXh?=
 =?us-ascii?Q?u2O56wetuRoG2x/GHz93mZDr0mOtKSpsuqLUJlMqmy1RuEk8tFHVwiE2s61r?=
 =?us-ascii?Q?HqX2qPHh6gbk73vpOdfyiNR8DXy27C9uYU5larwTaIvPZfNPGR8VpvS84RBb?=
 =?us-ascii?Q?hWAHFjqgb7tV9dgmOFw4ZDScXANpqa3+5IxkL8YXOBtV3WDKXPuEeFV9H0R6?=
 =?us-ascii?Q?v36zE49rJPzCBeNxVfQpn2lov8Tyv4EK9WnvaBPWnc+rfyn2kkv6kOej4djG?=
 =?us-ascii?Q?lsQ4gZK7toi90TsOurtC2B9bZJyBSc6m0dlqYDuwBfHDl+RRsjPgNiupJ5tn?=
 =?us-ascii?Q?42MTaFTzwFuvdhL7eaMB5cs8qoqxs48c0g96N2IosRbnMobKIhBipqDUxKq0?=
 =?us-ascii?Q?Z7vpB3FmoJmCYJQGTqt1Q7Z8yJlYlm6eRvjkR0X/3zHgjbJr+lCvTmWpEPv/?=
 =?us-ascii?Q?+Lpv+U804JVW9xfyBp2QXwMFCCqwoHvL2cNhXgK2O69VSBcRjtAX5kG7uUpc?=
 =?us-ascii?Q?SJXsTFej/HXcj9uyT2dA8nHdoH/JXa8NxYGmSjmmFH3r5IhY5cZcTo9SIWNU?=
 =?us-ascii?Q?i55+4rD+4i92cEC9ykVlGehSY4KnqiBAHvOg+QycMxVeDlJj5p99p1iQC6M2?=
 =?us-ascii?Q?ahsUrSLAxDwcfcmUAogajg6/w9+csuZzACM2GutcXVp/XdPCMz240GgZbWbQ?=
 =?us-ascii?Q?zkWvkTz7ZJpGOwhapePv5uQlDahpDf8ltJP4o9q4HJ8/AppgpfvzeriuUMFR?=
 =?us-ascii?Q?/7EN/vZNqljxOWZEtmAKp70nf/XGuaLWPu6OOnYgno/oIkZBnAXu8CjDMh/W?=
 =?us-ascii?Q?zINEms9Yue9uKsrnhac5/GZTlZpjxpljLVs2Nq6ClopRbZ9IEmSslssKIjE/?=
 =?us-ascii?Q?LyolBPtQVhzW19cBH3OrPvMu3AdLxNaAIpyrpjsfdqmN48wQXFYNaju8adPB?=
 =?us-ascii?Q?XRClEHY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BednGUlNKru2bOdjSuryzMeNPZhuL6+rvSMKRpAWJterpomOy/CmkGkHngrL?=
 =?us-ascii?Q?Mr/5mEtLdcKSYngsSC6/Uig31RXhoj/KUL186a6U4p+JJKoF5RIgOQBOCYIo?=
 =?us-ascii?Q?/cW8uqWtbcUXo3vhdNreivtXU7IP3m+JMdca+29NCSaB93JmX+hVHMxFzKdr?=
 =?us-ascii?Q?GOk30QeNk+BFT+YLJDDYZVO902j7NuFJya93NRjJpL1UirhiUIdFShbYqUUn?=
 =?us-ascii?Q?li40t7WyHp7l8gw0udtn17MuMJ78aeIsfMR8M5nCVjPtRjzqTUSF5xu8bLPf?=
 =?us-ascii?Q?LofRfHGr5dVCzjf45XGKaRe6WUBhzbvkfkobesGOj5Mccqx/05kjYX78zn8x?=
 =?us-ascii?Q?fbX4Bxanoh6PYinmVVCW9AOTTnVhz4h+rpvhsqzHso2hU4qDvxe5G59mnQIT?=
 =?us-ascii?Q?LZnQKseNgD6Hn9GFkN6NeI2/qaiXvsbzW1+BNTjtL89fJX2ZD1Gon6wOVNBd?=
 =?us-ascii?Q?HBDGFf7SfyLPh3T64n1jVKfXBKd7+48OTMmiiNDXA8Obz1KswvCWqGeLBCne?=
 =?us-ascii?Q?jYWO9/CjlpXwsFaiwLrRPZVq2rN7UwJTSMobb/3QzPBS1DTPZShXDjap5085?=
 =?us-ascii?Q?Ca6xVTAhTgthFJGzT5o+H6aSb3jBUg5Ifdn7CPkJR0v2bMZMNatl//O7F6jt?=
 =?us-ascii?Q?/FEDbMLPahXl9Qfpw2S0ZZSczsz6HgRTmyaa2oCqYGRgeVIrmfaRzENt7kDP?=
 =?us-ascii?Q?wq9Cbj0ZwD9piS0CIaOeco/fh9lXfz6q9ljHwAZ0FHstQn4DkGPXIEoRItcW?=
 =?us-ascii?Q?yEJWVBH7VbAu1L8UiFbxMBCrrLjU8f1KvMClZkeXvdYwrmt3OZ+LgIyvTBQO?=
 =?us-ascii?Q?0ioJ4Kr0MpESG3sky/iXCdXuojz6FGRH+R6Vrs8/hqJExNxSmhF+9FBrqa54?=
 =?us-ascii?Q?6hDidLXwp9f3ff9FWFggq+JkVBA0tmw8Wlso/YD6Jjm7bGtkfzhusSPXte2y?=
 =?us-ascii?Q?ma9ttJC3ulqxZTOCbq+PQgVLtahDkYF3WRYPMwXXy/LPyX0TyJhXoS8WwdBU?=
 =?us-ascii?Q?JZsS8X8Ob3WKUvMr+Wm3+AbkRIr0KRPnFCP/tn2cCJXiqcE9eUp1kuZ1Q9aF?=
 =?us-ascii?Q?8poC+4+1GLgLn8fDjY6f3g8qcp+4gjnjsJLzcCIbuyUXy/6vuVicqkKrEilG?=
 =?us-ascii?Q?1UofikFyDQO8oy2uHKD+AyX1Tryp/xH8kYYyKcibptD8dPxtiNPpQf1yXGeZ?=
 =?us-ascii?Q?tycS7pJ553ihUmhUQuj1yx19XhxQlGClylsPlzSGE7elDDia0hyVmml7tfFR?=
 =?us-ascii?Q?LQf9BJ15kWTopRc0a2FNhFpn44SeegDbsdrx4C5iU44ju9gNSZn7W+D/P1KX?=
 =?us-ascii?Q?otmqBjmbrmoGH5aRMAfcHLxY/KABVqpAuUxrKrcjXvgwbY1ETrnF0IqT9YV1?=
 =?us-ascii?Q?Ny7upQMHewd71imF1Te8UDkWxaiGHmiSJqaVaWlJd8wm1jXwvau21bziqFIq?=
 =?us-ascii?Q?Q3ciYhxneUf7cDn80Nhw9LScP5ijDmo3N37gSI2nJUXYb4PbLkYeJheRZoH9?=
 =?us-ascii?Q?3XsjgWe70MfU8tcaKOXd/ynVSWEHUcC3wW2v4H0Z7D4bAYmBYFfj9Dtiu24S?=
 =?us-ascii?Q?xEAsXWHKwY926OY/ELk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9030df38-029f-463a-0185-08dc961e31d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:26:01.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Si9XWGGELMF6V+S2BdOKBIeEsiljjGhEQKgtPyV+4HxCBtOb26xYz9CRggq9OVhCuIAlXKKqFfNzodiv1kzwIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10838

Workaround already applied unconditional at
commit a6ba1e453174 ("usb: dwc3: apply snps,host-vbus-glitches workaround unconditionally")

Remove it to fix CHECK_DTBS warning:
	usb@2f00000: Unevaluated properties are not allowed ('snps,host-vbus-glitches' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 1b6ab9550cce9..64e14154d5969 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -501,7 +501,6 @@ usb0: usb@2f00000 {
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-			snps,host-vbus-glitches;
 		};
 
 		sata: sata@3200000 {
-- 
2.34.1


