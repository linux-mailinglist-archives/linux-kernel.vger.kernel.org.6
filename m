Return-Path: <linux-kernel+bounces-206141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1449004C4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91AA1C249B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80641993B0;
	Fri,  7 Jun 2024 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kIQpiHIY"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93511993A9;
	Fri,  7 Jun 2024 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766722; cv=fail; b=WP74EshXxgPjVC+jehY2Dw88kDF9TI73avJkgkPag70fRFxGH6CnA2tlCVGivB4/uaFwq0ojxoiJU+93uuLXpWfNzuOKsEt+LXJr+iLn3Bo1gs5gGzZRxNZu7aQZoEynrvFn9txznHBxHVFfWnGG6zp48kY36MwoRjDpDb5DMmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766722; c=relaxed/simple;
	bh=Bm1rzBizY8q83ZqDUOdoacNCvwxlIgVOhaalXYwx2jU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TSAcTPwNw8jgCYlbobFm7hKP5Grf9lNGCoFEQlxMB5E7rOiieTJOKRwced7e7tuQmA4xOcrHwkZDWtTGhsBldSBiOh/I3BpPhSsF7tNexKtJCiViUyauNX6UQVF1iGK5WzBbXR78T2vs2cS3i3kS92wpt0dMvd52jt4+8aZAvfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kIQpiHIY; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV8EbAtDNxN3/cm7vy2mZmNk82bvCM6wnHBfk67whGePHDzamfQGEw9SRt57KnK9PAovvcPhC60lETAIEmHcFrC4FAARibVgZR9QO++tDl7HpzEHFlJX56/+17rP9YdYkVWkN9ilrM1LFIS2y1EUKObc+k3SHryoSkKMXiZtFW/LGQn9ueOS2EFgO1joklnb9YzvonUow1iC+UrPk3X0AS6cRDn8dq3PHPPp9D4SVPMRYebcmgklP/0aSzSfhDPZuNoquvvyTAuqagrXV0LGMzJ8z2dG3fEUM0kTcWYxwKmgECZH9pHeMdXKgf3Mke3BfpIxjBUyq/dCkeAr+m0ARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONQWu0Z2SDPB1FF/NG9VETJX4nmn4NiTazYrjRxeENo=;
 b=W8vHywomR9+g63PDmUxv79vrxQXtNeegJ4DTGa8SNvnlQ+ra0eIRrlyruKxHa4TLXV+EyoTLlVMpZJxLHA2BssOceqkmjBJCwFRnodkg97ENEN/Vwbr7fVjEY4L4KA/wkAotf9Wbb8ySLAm0fJov6NT1gps8tv8Attt574Ubpw0Bak0gq4CffB4Kh7WMR7JC2/lkWBRvn5tmUchAznQVWp7eyf11v9f50eacRjVOt0uxmf25qPxRNdFarrTJiArLz/Q3iVR453okpA7kwxrLnC3a9Yeo3tgbA7xca/LTDkLkY+QmpFAcnk4HUojy7dTmNjqIpZAPD0uzaBvjQpR1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONQWu0Z2SDPB1FF/NG9VETJX4nmn4NiTazYrjRxeENo=;
 b=kIQpiHIYSjRom27rXK40BoeSO4urCyLsrm+3QfbV8zmB5uy/c0IW+6FcDtFDzXVO58cdj5VLKzOqUi5UCE6dow5XY8mmNaqy0Z3SlNYKqRJKTJTlDwsSMpStJG1wXHo4QAYwJgyd8C7KhAJwpn7gt39b6Xm+a0nfBtM08QnYJDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB8944.eurprd04.prod.outlook.com (2603:10a6:102:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 13:25:16 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:25:16 +0000
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
	Ye Li <ye.li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 03/15] clk: imx: composite-7ulp: Check the PCC present bit
Date: Fri,  7 Jun 2024 21:33:35 +0800
Message-Id: <20240607133347.3291040-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 416c5ddf-2682-4005-c67e-08dc86f544ee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uR6SjqfiTsiPZfDyHm93pbKp3i8F6KLPUgq2/6leTtITG+yeoNLrbpL6/5DB?=
 =?us-ascii?Q?doDrLpdelr0CGkTcjbPHpH7VsSzLAKap/lMEm77ILXKLGqtK7JdzOLoBy+vP?=
 =?us-ascii?Q?ZuM6vPa0arKWu82a/CA/w1Cahj4LHWahTR28auWB9eTrfxu9s9hl1+wIMXdQ?=
 =?us-ascii?Q?6O6/SaykN0xgo28oQ2/xs1puymPTUGqU8MoCRbfwzBktIPv29X4a6MMUQrna?=
 =?us-ascii?Q?H8NyNxr4qyhRV1pDu2YtdjfJaUe0nPV8hjxyvwI4MBS6dRIMQNOdyArezmcj?=
 =?us-ascii?Q?vf4l/MnzsNydflmq/kdz/4CUeArvDX72Q2Gv24NhW+ru6NLSuhg75v8fLbdC?=
 =?us-ascii?Q?yU7jfvEBtgBbop+Ouvs08joVOD5Uz3sQilfRq+6N/mjw1ULD2j60/B1tYp2x?=
 =?us-ascii?Q?IaVhy5mNDY73oip70lNE8r8rYk4QOtkZJvRELfuMdpBI4t58HsjH3P130yhO?=
 =?us-ascii?Q?I1QAgAKqRG244KIcCB76AgvxGBwVGdha3Zvor0L860Psqs2dVTFJQQDEhrDA?=
 =?us-ascii?Q?Vc1M+8CJ+GHYCOUgtm2J/fX6HAOU93cyiubI9MuOWpkmX0XenfqhX9GAT+LH?=
 =?us-ascii?Q?qdXbRS6UV22+SiIwIubl7XOER0/0Lclt71wO8RT1Ijlhu+42vlQov15qD2in?=
 =?us-ascii?Q?l39npXqpNczcswGalu/ZKsI9abj65kFcZYLBiYteIWE/HdDRiC9oouaTlSjx?=
 =?us-ascii?Q?inlAgNlgZMqkloI3VDjfy35gpLlT8D7mfJcoaCuzg0yRfkDPLW4u3ZGXs0dB?=
 =?us-ascii?Q?GDgh9p4RprqvDWjVYITUxRsCbR7I8qYS/53qhevp6dYCFkt9dpvfvATdu4MV?=
 =?us-ascii?Q?JV4t3K86Nbl3HbiC6rZCsW4eSD4mTV8scBvN+ZHm8kuhT3JdT2RO2hxVmfUC?=
 =?us-ascii?Q?1hHkNVXcoZ8PhhmAtZnAuiQJj7OQ1gzVPFayTCs5ksKgOLk70zCwe2eL93Ee?=
 =?us-ascii?Q?AebHsClQLokwoaTS5XztCQPKkE+DvtVnlG8rWaPnLDHhA9P2Zt5wGke7jul1?=
 =?us-ascii?Q?p0AWR1AjlwG0wj9KylYD6MuDQF92FDOc7o2vXhh/jnFFpJ8s1lAG2dcMwHPl?=
 =?us-ascii?Q?HZNeGysdaULA1NAFG0A57HFk3ybjb3KkAJ4wtgHpfCB0ar184v7eHQErSbTL?=
 =?us-ascii?Q?Ez4R4uu6c+d2NjFHRkjJXyocuXVaTLZ441hBQNxZ1UHbBvP8plOiKcGPlQd5?=
 =?us-ascii?Q?dWS7pIYA97vBh3gJM0io9uwDI1DBjn05EAhlz7URo8Ayv7oOsROyorpIyyJO?=
 =?us-ascii?Q?U7OEkbeqMrS6Gg/oXZ82pCF4Fs8BJ/Jggt50QF2GfQDawdtR3j84UOWU/Qpv?=
 =?us-ascii?Q?E1rmEJ4FCSOs/SpaCMvY4HfuUG+sKrObP1akF0QWz4rLjT84wXYcMy0F86nW?=
 =?us-ascii?Q?faSkUck=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?px0OurrHXpbepEIeIVKpyRHpmmevUHC9AcVWEbA1PuC3U7nUjDruwf9U9UYg?=
 =?us-ascii?Q?L5/ChfIfaI5xWS934vXC8twVL8dB09XPjCkspN4Gvkh1bwObTtuVVbRdfqiL?=
 =?us-ascii?Q?bnL9TGVBIqBB12yUonhdiL+ZAGyofdb9Gy4BsLMHzcyy9e7H+D4x+PGoeqXv?=
 =?us-ascii?Q?3ibwqgH+ntFSKdQaJMwTEJbv2wnhN83Q06cmR9KhWJAeQ2PHW4DqgVGrT3WB?=
 =?us-ascii?Q?vFPgKXgE7ylVHwIBY9luhSDngv9s59CuO8zVw700VNL92N3rjZKnu8qdpm+D?=
 =?us-ascii?Q?fXJ7IcKkukjjc+wE0f5iq/lbZMX2pJwOAVNTHcQBqhE2dVsd5hLOjLIazQcZ?=
 =?us-ascii?Q?1ZXwZHxTjK4W3ELQEv3BCqk9nhS8I6d1kLpLoF1FXWNhnQGMXxvltRgOFl8/?=
 =?us-ascii?Q?FT3ZRgvFueUPxVH7iGDpgqDmQBf6tkqfuFUEgLqu4hO52f5PKe2t28K9xqfb?=
 =?us-ascii?Q?gVaxD+aYnvQepCLWqWwpi93B2EdbaHWtqgEuub5N3Xaf69OYNmkfZ1WDGY41?=
 =?us-ascii?Q?ENJfwNKBUJMrGOQOg3ImtHWb1MhAfGqQcUkSoNTAyaEUV1R2goEJkIxYMhFb?=
 =?us-ascii?Q?y8DD29V79SVDh/g4+SpxBbCPBcoXkvXOUqBAABs4BPvEykXndFVBeEunr+K3?=
 =?us-ascii?Q?gOWBeosbGpSv2h+yTpihzCs+uWZXJykk6U7yb7rB9XBF+zn8WzsH/MRlraKQ?=
 =?us-ascii?Q?RDVAmJKDhpR755dEsde5xIQS1lgS/xy0fTcGbwp44U4l6ClU4igLi6oKJXw/?=
 =?us-ascii?Q?DdKGXa/1fxKyPZW2vnD3pHD5U4J84+Wui84ZsIfzyEtpDCbOAMp0Ugl57xps?=
 =?us-ascii?Q?bTSRHGu5/ushSIUDu4ckW4FT0XFAoYLUr87wO0195nF7UX66b4kJaVfkEoSf?=
 =?us-ascii?Q?ZargGuT6dU+WOAFO4POv/8Jtzfv2U6xBOoX7Hi88dWkN+hhxNUuRCrhe791l?=
 =?us-ascii?Q?UVZ6e8XEWmZ5NBfanczjEF+LkyyUdqiGXAMPLuElfcUA2ZmCq4Sa/8hEn1PR?=
 =?us-ascii?Q?+e5uqentDKyyJIoZYf2jzqzZ9WWtPcqkAXlUpMnlCn6duzmfoQd2JV/nmH7i?=
 =?us-ascii?Q?Wvba54XL7OF1sMcP+Y0l8+Z0iQTHUJ6DFUSvHI7a2PsZm3FuhFoH8aOHrkB3?=
 =?us-ascii?Q?IuNXF4cEopJlX+zkJ6p/epwrFs6pIR9oY5iW9ia5ENLHPwhTWA6U9Sedq1h3?=
 =?us-ascii?Q?sPP31KuY4vCPq6zHVj/wN41US3vdIPJnb+QdvpIy/X9531MMdma8pv89S2ks?=
 =?us-ascii?Q?8cV+qhVYef+WeJr0GMUhZ5dyC0pk8IhXikFXY9rSGAZXeho3BX9juZkavUQl?=
 =?us-ascii?Q?cJy2AT6GZ1AmcRsLAPRJL9GYKvFnBuwpT3h2bKAW72wCOc/vG799cCeaZefg?=
 =?us-ascii?Q?TUGlgFCIzzaIl9oyTNQeFA5uk4qt5+qXt+VKhaR5gof4A5j024zl8HChnjOa?=
 =?us-ascii?Q?kyJals0WoV1wHUcqbOTKW7jK2q1EWECDj8bhXRssxxQQGZx3LadZvd7f0piS?=
 =?us-ascii?Q?wEEEzmrl84r943wLqTr9U5l6i8HZ55AfQLYYhayhk2L4yvX9q2dQi0qoaXuS?=
 =?us-ascii?Q?7PuojQlGmaUiC8aCQogJAzGISFLzvWfOe/3CN0RS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416c5ddf-2682-4005-c67e-08dc86f544ee
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:25:16.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8z8BxDMZN7iuxR6r8nRj8+upIDLi418p4r+0JZFLUPshulz3f3g2ctAJ5yuZhclGpXOZNAEttmQ85Gj5vzuLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8944

From: Ye Li <ye.li@nxp.com>

When some module is disabled by fuse, its PCC PR bit is default 0 and
PCC is not operational. Any write to this PCC will cause SError.

Fixes: b40ba8065347 ("clk: imx: Update the compsite driver to support imx8ulp")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-7ulp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-composite-7ulp.c
index e208ddc51133..db7f40b07d1a 100644
--- a/drivers/clk/imx/clk-composite-7ulp.c
+++ b/drivers/clk/imx/clk-composite-7ulp.c
@@ -14,6 +14,7 @@
 #include "../clk-fractional-divider.h"
 #include "clk.h"
 
+#define PCG_PR_MASK		BIT(31)
 #define PCG_PCS_SHIFT	24
 #define PCG_PCS_MASK	0x7
 #define PCG_CGC_SHIFT	30
@@ -78,6 +79,12 @@ static struct clk_hw *imx_ulp_clk_hw_composite(const char *name,
 	struct clk_hw *hw;
 	u32 val;
 
+	val = readl(reg);
+	if (!(val & PCG_PR_MASK)) {
+		pr_info("PCC PR is 0 for clk:%s, bypass\n", name);
+		return 0;
+	}
+
 	if (mux_present) {
 		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 		if (!mux)
-- 
2.37.1


