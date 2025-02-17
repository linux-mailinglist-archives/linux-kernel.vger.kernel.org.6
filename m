Return-Path: <linux-kernel+bounces-516917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8AFA379AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157997A3310
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03EE153BD7;
	Mon, 17 Feb 2025 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WWIey4P1"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F48B136337;
	Mon, 17 Feb 2025 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739758723; cv=fail; b=C48xc+6ibnisOVW9c6KmucpBBgZtWsg8Z5jzyULqyb33bxp++o6fFHHzToLlRRfF0U4GBQPciqO0WyosNTHP50IuZYmKjcWpv94frHUHxLhA30p19xPkwRgDYgu82K+8C5M2suX1Q5to5QWrKDLwkMJ1j7yipQrCrGIIXhsV1qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739758723; c=relaxed/simple;
	bh=qyuxJ3Mtk0SqA9tRWZo1ZaJ6/i3I+a1fFQAiKkORgBg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ik41IXbru24uVjiNXxkc5HgzR9rm3RSK5Q6V5J+OtZVt8DRXkCw0m/5Epr8K3p4W5A2/hIoZmWx0DLLKm5FpmtCKpA5FOgAsD6vLxgbH3hCJtZKVlpOs6dBkMdczCYWF7x1y8/8eHYm7BsfWPMd7AdJ+Lw1vGU/IS8Bab2Fqoco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WWIey4P1; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiC1vA8euNFEMropuZNw34KzxmwqOST+vbOz9jQQjuEpmYTJKQVlFCHfzlw/7KWJQIOhgYXTwtxlg19en9vAUY+5+LdKqjSFVKoeIG6EygK7n1FWI4lLA/HuzqYeRm9/WgJND4g6fndrbNU3zyYYxfdKxyvu5QhDpi588XDD7AQMNz3L4Uw9m0XstvFiBbo11YXozbc/d8G7zFwwelZ1qjaqSV3Wq6+GOdkWTZWxz0e7rP6vr3Vq/+zEynY6SiE1Jn00Keo+ekugbKmtprwmttO62kWKULV9+jrSKAIhpjZiYDluC9h2UQTy4HeEoQ92yf9pRDx6rLuFFhs0EPpe+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUhK2IBAZRKyLIR6BKuHhfeORUFZlBb+X2i/U37Ew2M=;
 b=RxKToaNUBAHH7862pNogQbTCD9Jo5YgOuNNJP7pENRVJ5n60+QMYfaf4REY1u3cCpqzFyO5+shuPhcA67+F2p4PFIWxCya39xRDFPQPjbt+7pPfROSDekvljctz0uBGpFyuxOX/k41IQ8qDsuyAK1WtiXxeLz1zcWU98EzwmA4sYccZTiZqz9Cly8JpND/n4FdnwNwlEDw6jlXMzPDl6L/Pdzaoz3vc97k3TIAbqFImmfw8n28BcRmlSeLWx2Kl+Zs2A5fZAlP1NaT5cuHQ/xA293kmMCfbEUaIZXtjMMW3mCs6erq0CbRk60uALI279AkmBsdiH8tAwSV6hFSPXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUhK2IBAZRKyLIR6BKuHhfeORUFZlBb+X2i/U37Ew2M=;
 b=WWIey4P1S+rPZHYg8ygRrfNKmWijevb38YwUem2xeLZ/mH+XxnANC2gdpvKLyCmLOS+UQ0bg4g6xdab5bwtUV320YliFtYq0nCtSw0Dp5ch2FZbbwgAA/R+obYIL7RxYBFSUNL6YNfZud2fq5rahbpimvoIHlu0D6z+MAlN9sSqTe/qK8WMAL+xbHfJs6QrMDtvM53MGbIBqd9Vk61NAXqiVUvqzckI3sk8L0ZFGm9xhR+5sOqpn39ziwMLFwrhR9zoAyXzrIEW32PxdpGW6n3FxhMx+dlAbb4SZDOPMXJVom54ZIesYumLpJd2EbcMALfyZEog1WRaqCqqvF5f8XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by DBBPR04MB7865.eurprd04.prod.outlook.com (2603:10a6:10:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 02:18:40 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 02:18:38 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] ASoC: imx-card: Add playback_only or capture_only support
Date: Mon, 17 Feb 2025 10:17:15 +0800
Message-Id: <20250217021715.284951-3-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250217021715.284951-1-shengjiu.wang@nxp.com>
References: <20250217021715.284951-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|DBBPR04MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: caf04d64-f0e0-4343-fc72-08dd4ef9632a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tRqbA6Q/Bdwj5JmPH+g7j1OEr4LA9+AT6RSokCAak0RcPR+lMY2Xi7LQlFCd?=
 =?us-ascii?Q?DoZidfeG3K/1aD/FHqtNJaYVjolrUwE+JX4mnrMLwFqJJ0BjuYfzMXXo4jQi?=
 =?us-ascii?Q?Rug2+pKeGWKNEUIwhqIv3P5oniwzoqUBlejrNVtbHbC4PXG0wdyZH6XTck95?=
 =?us-ascii?Q?6gTeDRcmr3OQuT69t+3UUvRnz9Intbj3yoEoyj1O34KC7FeazrkP+ggZlzXl?=
 =?us-ascii?Q?Q3wQ7JcQY9BI9bS2kEr8yx+id7ZVCAXc2RmW09YWMtRQZEtiPFlFGrsrEdE3?=
 =?us-ascii?Q?TIsC3DKl9KYJHAfubyuRkT44OLxUrwQHWXk4c8WhxYm0t6kNBLAz3q26abt3?=
 =?us-ascii?Q?OqoNKL97cv6MFJopY8cH3XkQ69fck5+QojNgfzkUuC1NlgN9RmS3G6CKNNEw?=
 =?us-ascii?Q?s4YXlVDFi96WPSPv7/cK3GEJcKQ0Aw1/Ex04JGqr03IjTUMvzFNhrefZOOeU?=
 =?us-ascii?Q?eWxQ8tmdUUXhAHbhzOLb3zj+PLN6cyLBgFepQPbdwAHQeFcWT1kRG8meCR9/?=
 =?us-ascii?Q?kW18Ks1xjDNGg/NYjqtDB51yM5yFlnYNQ6NEDYUyxoIJzBNDIYUN4sjFJTcj?=
 =?us-ascii?Q?aUZSz4AjjO4qW0pN4qcqKm2bj/ZfjrOXxQJNvG45/fKleYEqbhS/Ti81TkyL?=
 =?us-ascii?Q?vumvEF7KT3ZhR7SLRBQdP9Ta4cQPRWA8nhKSuFMjPro19+6sFi6+YlJag/39?=
 =?us-ascii?Q?7R2c1fHJ/RtZw/HGCHiUGyLaJfqQkmSafut/6Y15nOVrb51/r5/Fpl3BvmwR?=
 =?us-ascii?Q?ZMW1LCpjh0uOFBA/ZmzZdr6DGZ/hgWrwyBE9NDbdOvcpynKOZ65MPF9guMTN?=
 =?us-ascii?Q?llxCMUsLYDbCU0nABLJb6Qr4je+t1JulF7nvWuSqaaijIQdb7N6eath8pi3V?=
 =?us-ascii?Q?eqENuLqcb7ZXfaU7pr035fp4CQplj0Ox4WZdM73IQRgforcMrKUxuvYd3abv?=
 =?us-ascii?Q?DLctVzH5H249f2mpgi2vr1al6pR6R1uLssGIsAGwmxT67A4OqjNvg2krLUxm?=
 =?us-ascii?Q?mYdY02TOrZQe9j/8PFCO/3fxOWS2+oxq1WRZS2diAgOVzOzHwe2jf0KBbFEd?=
 =?us-ascii?Q?RZG7I1NwBcOSHOaU4H6GTwbHrWTPm34uTkqYrxF0TsiwUJIQ4LP6Ot3EB03p?=
 =?us-ascii?Q?rG9kX5wWrV5Z36tYdlHnDFeSYhYUzQilh2XPP2JkN3xgl6tpi20L9BX8agpf?=
 =?us-ascii?Q?WbuPdk9vggWrS4I7eSfUzRAVZaUjCnl9SgEpJ3pcpNmU6HtVhaKaKztFgJ7e?=
 =?us-ascii?Q?h9v59BJELmlwgwYuah4U8wlWgqa+UA4lBqdD6g41Mw0wF8aB/bAHr7oiofeD?=
 =?us-ascii?Q?PaPGKZlEeY5nwSKC00faT/jBbpTwx6mh5NlemDMks8AnDJviwst3I3mrCO3l?=
 =?us-ascii?Q?SVEMO0z7Pcur2NcXiN9FjEaqW6dtbfzcbEbGfs4bBver5yNir2mRG7HcCkB5?=
 =?us-ascii?Q?e21joMpuzGzbU1CN0eqygevjRa1Cbso8WRtASirNUBjSMtuFOK1L2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rWyME3ypWZkgBiqQT5XQ61st0WQyecGv0w3q0DPX/2vB2hBjM9HJyO0ttB1O?=
 =?us-ascii?Q?FnccIgMo2hpjD5B8OK+XVWGY1GwGVs8SEgfcfRi/LysF4fAh0KPGQ8SB0fR2?=
 =?us-ascii?Q?OeUsetSePDNkKDBBw4o2Xy1nmJqXQ0sVPZJfKntW5iOlppD+yrkZDmTu2tLX?=
 =?us-ascii?Q?JXrkcZfhIO/88rSMEydYuk9S9HjmPb8EBiR5RdGVeRtYimoRm0u/RH9j4RYO?=
 =?us-ascii?Q?/nctDUOYdvIrvCMDfWkfnrEyr3OQJmGcYo/Z76BwRKcN2hvgzLiyo84XkEGm?=
 =?us-ascii?Q?G291AaSwnrF+XE1oboxlsIw4z7/J1w/yqZGdLaZmX/OdeI1PrIOYpT8k2EY0?=
 =?us-ascii?Q?9/Qypi6q79ZJA9YgtA214LeWG0BTfWUzfMuREazyd5BPJpkudwHC4hOZ76UP?=
 =?us-ascii?Q?XvJuiWj5xI3vxQ0UNpdpfSzcJmw+2xqUZ3+Tl3Y3HPppFgMtyhGekdWCpwvT?=
 =?us-ascii?Q?RA7koxIqCUZKg8PoMq2eMhGXE0T5IQW75njVHvoqapgfhogrRjT6tdEPaafp?=
 =?us-ascii?Q?oBdL7VUblpCXbiuI6LUiSYs/KQ1ghfoPOYt5vdKY3hl2zIBXBGlp5qRmy3+X?=
 =?us-ascii?Q?9MOLgMsEfEl172c7Iq9VT6BPVCJciLEVB95FRRDs2ch5RRchx2kDuNRjHCd/?=
 =?us-ascii?Q?2Eq1CicV5qoRJ+fNzV+BGARbpaKtArX4mD1VLzADg10R1LNtn6fqbLKZWKif?=
 =?us-ascii?Q?VYUskruUhoukR7DDDCA9vaamHrHKCRHpsFOU9SAbql7E8KCCZCMX+kajdxQ4?=
 =?us-ascii?Q?mOF9cJRVWX54SL+FuB2aclD2fNtDYjktx0bYh8PsmZ5rAKDMgm4kK8tF1JPJ?=
 =?us-ascii?Q?fugs2Ev6Ljjbe0TgIinTukN55TCe2bXrzlGMCxEEUKFF7KidBmTviNtM7mXm?=
 =?us-ascii?Q?RIQDO3E9IGx29uCPJBcUTPz5YgysgDj3M3obtQqof/KQXbSFJLplpKPYqOWS?=
 =?us-ascii?Q?jEy5xNSYZgDWSI75wL9o0EgOQ6hin7HhPDXDICiedh0o+2ua/8dHXApnj/4g?=
 =?us-ascii?Q?gqUGLJt+nQr8CF7WLYeuKgI2aW4wz6ghgejULnyaw8L6/2UBfQqOR69FWImQ?=
 =?us-ascii?Q?F8GAXgy9/vpYKItolGyqDiFXwJlhBSnDEqPIJ0OpvnVYCkW8I/x1z72LX+mf?=
 =?us-ascii?Q?/c8iPXyuOJJBavicxpfZmF71zF+SkGgwMoWJ4VtKhEnhKyy62ZcHFnbHjKrY?=
 =?us-ascii?Q?2nnydVCN8EbEuSFBZSdJSo5ilzsY33VWORnTSMPi45IhLW/srm6ZccEV89i8?=
 =?us-ascii?Q?/FD3BGnk+1XNnpMPCKwjQwFUsLWloGVSHtMmuvakwlUydiXLvEaXMQUcAd2c?=
 =?us-ascii?Q?eR1xpyNV1PAFUJGdmlicHzEXNoKAy2huMXjxnDTg43ey7RmFfFvNzRydnTP7?=
 =?us-ascii?Q?sKZXCoNN39DOyW4EBZqRQw8FAUxtebQlB7VC5Tlkbu4rcNUmMvPA9zDxcH0P?=
 =?us-ascii?Q?kIksCOmHGMuKAB7yK91gjlTSXmbUe5nz7n8srAXmRMlSB3/yv1d7B2hPkUoo?=
 =?us-ascii?Q?D3eU77wUGUhdZXDO6QBRQudQw2ZrqyS5LL3vyyXkteplwbcvQO79TOTqrYlA?=
 =?us-ascii?Q?bHo6j1gPghSsJpr9vbX02C5b7ytGzzmQNu3HiTby?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf04d64-f0e0-4343-fc72-08dd4ef9632a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 02:18:38.0336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zw9No2+YODxNMxJhYVa4SH3i+z+rq1UvW9Ws7UykBBml7v5NLPCm21XIOlpPNn4lb7m8mQNRpHLkVHFZsccPuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7865

With the DPCM case, the backend only support capture or playback, then
the linked frontend can only support capture or playback, but frontend
can't automatically enable only capture or playback, it needs the input
from dt-binding.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 sound/soc/fsl/imx-card.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index ac043ad367ac..905294682996 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -518,6 +518,7 @@ static int imx_card_parse_of(struct imx_card_data *data)
 	struct snd_soc_dai_link *link;
 	struct dai_link_data *link_data;
 	struct of_phandle_args args;
+	bool playback_only, capture_only;
 	int ret, num_links;
 	u32 asrc_fmt = 0;
 	u32 width;
@@ -679,6 +680,10 @@ static int imx_card_parse_of(struct imx_card_data *data)
 			link->ops = &imx_aif_ops;
 		}
 
+		graph_util_parse_link_direction(np, &playback_only, &capture_only);
+		link->playback_only = playback_only;
+		link->capture_only = capture_only;
+
 		/* Get dai fmt */
 		ret = simple_util_parse_daifmt(dev, np, codec,
 					       NULL, &link->dai_fmt);
-- 
2.34.1


