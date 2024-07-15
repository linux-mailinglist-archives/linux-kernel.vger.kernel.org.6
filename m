Return-Path: <linux-kernel+bounces-252732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54B593176D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262631F226F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F86C18EA6F;
	Mon, 15 Jul 2024 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gkd7vXQQ"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7F46FC2;
	Mon, 15 Jul 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056633; cv=fail; b=dEgjp+Vb/9VC1WZOMlDiT6c3CaWA4gJSzm2vVRG1VBmzyynlSYbuK/hj5KZiXY8djJ3noDD5sZ+fiJsD1+DxHVVODEWHLecTFIIc5EVpttb+F591iBgInoD/AvshmPLOS5pp2jwoheQacHtU+Q7fC24uBxeYWC0o3m3oSIWsO90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056633; c=relaxed/simple;
	bh=1ctZabOv651M87hFUc9K/2sYy2lUmoJ0sdxLi8cTLxs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gAMup+eZ4FwbbvDP2FlND2iOmu9Vr2OBlrwbyMW3LVTwUhrqUpRr98UHgjF+/o5N/1mkrMgwyUQBNigv7VSY3QiiYdZpC4KgbF11T0G3HLFxrRENaA4kPuWoFLkXJdug/LSLFs+Mh+ruP8DCVNWMAJY7ZMHKJXP5Iv40MsBwxmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gkd7vXQQ; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umZqUKeMuWSmZaH5Llab1b7BoD3pk5jAn+i7fV8BrJEGUqorqwRgHZm91inX/sz3XXlW+aOTnP3ZHFscjeqt3NGEaVwi0vNE7bHajQfFhgi74uIUI30sFyxGKmRx2Lsrb0BB+UiyS9tjEZgVG+NGiM1/8M4rQaKZlo182yQBO5gbYbxELX7VvdyMzKuuQxoirm+3HkfBWrU1LQswV4V9R5Ju7y7l2rCrh1m9707rHfdiEF42BV9/wWYGuczU6YHkZopkLPNWKQ/nP9vZoO8voKW4p1UIg3+cV3miBHLS/zeqWi9ankT5ss3daPK5RJKz6gnde+ALI+SqHxfibS3SfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8M7BLAK+icICZg8KxC8P5n2ynFP5r7MLcgcjoN8eb4=;
 b=qlRLCQIO67QkLWs4hxYY44UqwDKLJSH0AFyHqO6Dz81slbqtcbubI58Hgj1LpgDoDaU+y2eyQ74dYXzy8QzaYw9tbligF6d6YD7rceYjtFE/zFPWiHHy9jNTfCpZmInbr6MuLQY0gYcC1Ly2ba4fhwhaWRPN+eHzm4aiOB+SEpjHdyn7x+8OvoRel88v2BafAesz/wMwPxpF7uOHQunoTLxm0QmBO+rzCLtWYvBsByfTP9GWQ0bKbQxPGdPeS71o+yFxcz73g0FyMCU+0+FZ6mkSK9IubFe9/Cc/TV04IQxUEOST3OENUMqt85QcvCkmx9bTyoWQhcrOM2Ni2GL51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8M7BLAK+icICZg8KxC8P5n2ynFP5r7MLcgcjoN8eb4=;
 b=gkd7vXQQ7Som6BjcKojuXEBSck4pHK5vpgJ6GGGutosRsg9SGv8VnkcA9PdiVLS5mYUv9Wmz0iHGwfBKdNUENVbu729vavgk9OdoUyVX72tMsVW6VZrhYEHT4KLTWRa9HDcpJXehq+roVe6NFOQc6+1DRJ4soTdi9eTKo2QAcrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by DBBPR04MB7785.eurprd04.prod.outlook.com (2603:10a6:10:1e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 15:17:07 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 15:17:07 +0000
From: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org
Cc: lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@gmail.com,
	kernel@pengutronix.de,
	iuliana.prodan@nxp.com,
	shengjiu.wang@nxp.com,
	laurentiu.mihalcea@nxp.com,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: SOF: imx8m: Fix DSP control regmap retrieval
Date: Mon, 15 Jul 2024 18:16:53 +0300
Message-Id: <20240715151653.114751-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0007.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::11) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|DBBPR04MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: f2dcde96-4bc1-4918-ce45-08dca4e130a9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jEq6ky1yQQwXs1Mg8IGnIKp1mplFRsFv0h8iBOP1Rv4sG+qsiMuW11p/xNBm?=
 =?us-ascii?Q?V33mpzf5NAhjY6Xv1P0CnxNp77SBIk1UI46Y89lgvF8My48PKvflf+apZICk?=
 =?us-ascii?Q?V741zeU3QqYJZznC19dJQkyQJRbYIU11DIJY8Rzlh/IyBvId0troncNFlmyc?=
 =?us-ascii?Q?zkdfoGFOmTAIIk7zHkeeitvcFiIEOT4JbC+SlUmAK1GwLRJ8tL5aWxI9ruqE?=
 =?us-ascii?Q?3T/NKr0MF+5P52zKzOzFWRmizlt+GN7mi9Qfarn35d+bFNxiS4IzXqp2psoJ?=
 =?us-ascii?Q?GcFW7rGpVlLM1cyeDDRMuHEQ0leH/+88NPqsjtl7Co05nWyzwKnpDBbQJRM3?=
 =?us-ascii?Q?mY3K4h+l+/kcKBPjeuIzDSBJlMfOeFYVx4rdL4k3r7zNGir+7vaGTk2vaEeN?=
 =?us-ascii?Q?plkpGeBqqLd6TQSJxBvRacHdGQttZTqbMbIl5G5Ww6otV4qqjZedTg6HYEih?=
 =?us-ascii?Q?JXq2LAH9A6/V0zReigb1JP6vRJ8Uav9++7/aSzVoTWbbCylAk6aG76IGcaz1?=
 =?us-ascii?Q?9mwxSVN+5XnfCV7iu4kD2wBJd1h1d2IFazHEM22/klSkxKmc7gt4fwmToDo1?=
 =?us-ascii?Q?QcLS3EZBXaUw5pmI17Mo6MeJXLd34qXMuk98f7eJPFYLMWIuJuXryOjBiGb3?=
 =?us-ascii?Q?JdxkMRrzh8OJkXnxP72GF/K0W6TXsJ/n0q4HLERy6XG7QbkoXQKLiZTULnG/?=
 =?us-ascii?Q?JTciA4nxJOdEwwcsxheXpv7H99JXUstlJ4mLOp5mXoO7vUqF1xjERZx7UgRc?=
 =?us-ascii?Q?ufcrnuiaTm4YzfHCUf8ML33HEf9W26pjtPfDbhuJDjMdSxX10n/2HtwE9yRU?=
 =?us-ascii?Q?K0YMpRCpmuC82VIugsoiCzpN1yARMQyJnxPx9ZvfQicEYi2T2cFxHlm7rrfL?=
 =?us-ascii?Q?8rjfHncsybw0kpzzRqGiN00V18bk2EshykvnVS2fuCxQU7qgsAxnHi/EdvzU?=
 =?us-ascii?Q?Kg9w8fzvqxY0uqFgksYTlvS8wM4cCFRFZO5idh5Trhkv6vUsfGHaHwBYf7yE?=
 =?us-ascii?Q?faYslfs9LeNoaQJrHINub9e9hvhpthuamw1E8FgMTBMqyoOETuZzK6t6hr0s?=
 =?us-ascii?Q?XbRxryB171qwd3pie/C/cEQkLmsIgsneKaXWTsGh3VW58NcYARGwMRn0WUHF?=
 =?us-ascii?Q?IV6eS3ym5XdVpi6PtCirfjmrP2KWTcvjf5qL/ThINfECPDJxzCqsHUSuuEJX?=
 =?us-ascii?Q?WmJqYu+eNNTLthgUI/vBXg5zkg4jJv76FV/L4p128dZp0+u9rHmFmklqwS/3?=
 =?us-ascii?Q?g/Z7GoMi27WgKtvAK/FU5ir1BUezbMD1cXG2WwF5u+G5vqGbmiTJdaeZOzaS?=
 =?us-ascii?Q?oaMMzgTxZKva4CNQo1XkqmpfPp7XvwTarvsyJrTC+BiqrPl7cGSnYsTJ37hS?=
 =?us-ascii?Q?lVl9TLkLekBBIPTChFUjryQbilLywZBGHwZMVMDcBaSMYn1ZWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k6GDDr3JGW0ywTSXkGleHK6GEBQdP67hU9YmQB/re/t5f7cboIHrSvEJafgj?=
 =?us-ascii?Q?b6i7oPXOPP0nWSC0jn7UGnWZxNxZMRqrz3Q4jhL1x3T0SC/gxWOMOnliP099?=
 =?us-ascii?Q?mj1ZpoLMwL2COTH5I9kOFJ/BGpkFwqiOFgcnXrwycDP/RJKqb1AmcccYQgwR?=
 =?us-ascii?Q?Xb8+32pWVAzZk7hAuBvUgP8EMnqq8sSTEMDu/2g0k3h9YGBrMlrZtXiDKoxg?=
 =?us-ascii?Q?4k9vFRsFxNvMFtaIwigcps5drBXnxYM/eCJcAMPjFim/V3ULnz24GWhy8sZo?=
 =?us-ascii?Q?dvvh4xSGkg3KxTo4XeTNZoQprH8wajoI+OsCECvAaZMQb9mvuBbuEWCkjhxa?=
 =?us-ascii?Q?Dgf7SEv0hgIAYZemu7VIQeH7I8OwWg8J5u/C32L60s4j3OpQjR3yYVsqaj99?=
 =?us-ascii?Q?s93dxWwDNplP/rsedoZitzpky52MtP4wQsMeZgSB4VcJvuroU7L2frY0Fzmp?=
 =?us-ascii?Q?WxpMEXEpxVQN3Vy0/heaPDEWPZ3IXHBt71J3+0bdEFyNjiKUteDNPlGDhTCI?=
 =?us-ascii?Q?tK/GlEoDPfTZXARBmqeUwTih9NlJpHgtZTmY8hCAqvk7sB6uuOYAbJMWLjoN?=
 =?us-ascii?Q?RC9IRjDp1JsldB75J1R+3BLx03aHSTeLNL7jfiMQ/K6qq6ao3kiQLMfyaIqe?=
 =?us-ascii?Q?FLuliHQRjIUXPXNUl5MAAmfHNPHOlZEXz322ZDrsc7VreAPLH5SdT5B4Idxg?=
 =?us-ascii?Q?Cp3TtUHLPpXAYSVtcz4QsNbKwT0o61gXnreZBkYVYurhqwg5YyDdw7/e0Tje?=
 =?us-ascii?Q?HyAKVsfPFBlxiiBnx1MNNzwOar9JWYiMh+IWTpb27zwA5J/4P1kQspwM59YQ?=
 =?us-ascii?Q?ImNyr5hsR8oqiiBbxzz3nFoGlgdzJGROO11iFTL+JxFgX6/MgLCFqd9EVyK9?=
 =?us-ascii?Q?3mo/31Neb9Q5idDAijOsqS0Bu7ixavCXjpKHaLx6BZbXyKYH73RP7YN+INqU?=
 =?us-ascii?Q?IG96mmKYPtatRjk7hN+Fplsu8lbwnW0IUrcql2no8baX28WtUoOWo4y9+eIs?=
 =?us-ascii?Q?j8jAh7SG8QumpHtHS0uHnmf4AM1Zo7e/0MpIIF/K/u3Y1Lpx3mkQ2wKrMvMd?=
 =?us-ascii?Q?CqjmqBhS8bmI4NzTi3yySJTkGcaUN+Wy8DI8Yt2UmoML53CoxP6X5IReEeLl?=
 =?us-ascii?Q?cSJM5eYq7N6coqs2IEmrG/PJChygSDwv0hQ1CISFfNJy09+XUX1hJCCMcA5j?=
 =?us-ascii?Q?FLnLGi/q+BEsdfxk889W/92oIxrXL0SMF1ddeLOCD5cCuM3cocwmzfF3u/3z?=
 =?us-ascii?Q?OKw5XpX2mpw4AkpgiedDf+BQyqIWj7fovyyqCWVr1qajGEOZ7WUI9GgPTkLp?=
 =?us-ascii?Q?bizQCagmRokZbWW4O1cCvaccXaBSCija5+mBqow4uAksQG9s5k/GssbTz+/d?=
 =?us-ascii?Q?APHRSFbIlE9jT0UEfPKTCWZbwoRgZy3/MTk8STIVhgT+ZjiFDlGzEHk1c3RY?=
 =?us-ascii?Q?SbnTsLyukhalYzA9KwUKojO7D9nASieyLfUIVyA+mUZMHbCUxz4nTp+AbpcZ?=
 =?us-ascii?Q?oGfSCgXgjrKQlJ6je6gALvL1hPn5+UuCDQh9yZZ/7AnJs0dUs3DxeluRR+S1?=
 =?us-ascii?Q?3VGaPYTfhntuYh/+OQ3OUWiosamhrrd2Gg6nCIje?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2dcde96-4bc1-4918-ce45-08dca4e130a9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 15:17:07.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbtfYtIVt1/SNIG/nwli1br/DMJgJ7iuRGnb3DcEaaxuGh6UsEwSoVUlLzApmVDkoelKONzN0NeBz3kfVF9lXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7785

From: Daniel Baluta <daniel.baluta@nxp.com>

According to Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
fsl,dsp-ctrl is a phandle to syscon block so we need to use correct
function to retrieve it.

Currently there is no SOF DSP DTS merged into mainline so there is no
need to support the old way of retrieving the dsp control node.

Fixes: 9ba23717b292 ("ASoC: SOF: imx8m: Implement DSP start")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/imx/imx8m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
index 1c7019c3cbd38..cdd1e79ef9f6a 100644
--- a/sound/soc/sof/imx/imx8m.c
+++ b/sound/soc/sof/imx/imx8m.c
@@ -234,7 +234,7 @@ static int imx8m_probe(struct snd_sof_dev *sdev)
 	/* set default mailbox offset for FW ready message */
 	sdev->dsp_box.offset = MBOX_OFFSET;
 
-	priv->regmap = syscon_regmap_lookup_by_compatible("fsl,dsp-ctrl");
+	priv->regmap = syscon_regmap_lookup_by_phandle(np, "fsl,dsp-ctrl");
 	if (IS_ERR(priv->regmap)) {
 		dev_err(sdev->dev, "cannot find dsp-ctrl registers");
 		ret = PTR_ERR(priv->regmap);
-- 
2.25.1


