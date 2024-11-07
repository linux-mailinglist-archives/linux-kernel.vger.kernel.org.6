Return-Path: <linux-kernel+bounces-399632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B799C01F8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A62282E07
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469831EE007;
	Thu,  7 Nov 2024 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BVHzwp9r"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED741EC00A;
	Thu,  7 Nov 2024 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974262; cv=fail; b=owNDzwmZuE0fQMteQpUFUaiFKRW1E4ye+WGtCZUmdf2wFaapbcUr0qgr9we2+xOv70buKkoQsOMaALaMIx/ZHOq7oVwC97MuoLXn5p2VbgADA6cWdjsDmDYrwXU6vDZ2sNRuP7pL6uZhzDoc+o79wH/4h6WGn0HvjAMkGDQZlL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974262; c=relaxed/simple;
	bh=+ET5S1iROFZPgOsZRA7zzHVgjHpV+HJ524XYRyY85Is=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RUTI5Evke1KXV9EqtS2hTNCX/RuNggkKsmoDrm1wDDSMCIg9fWnLA/BECBS0XhR6jacc0MVFgvbqnojPnHEWiajb/vH595x16iNmEXwiEpT1e7XxXBigxrMcx0N6dbLgh1J+5ElRyj+JfYGzpLhwnYwhcrbSa9gJlNKbgg1TSDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BVHzwp9r; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdGA6YbrJ8woicXd82WPuQd4BBDYNRJqsD0Uc37Cp2WzG3QxPZW7NSwL53mcGeVJsBpXsZ4qpFFotib0WOEg8ADfS34tpa04cb9A770GenOB5DZpW1VabCtoz+rWB7pJPZSLW2SBARgqaxlnnDQ3FcdnCuYrEmBru81rzSbZlrjTNGqacesZWuHG0eSP+dejSviiTVcWUfd1Xf9uNyL8eNvaDvEJ6Zplg6xMRLakoYRMjSyDrtoaIy9QnGvvItJwdBd4pNq/AhSr0sFnjvp732txpyS/LGVxxt3LAp3aLPLb5W4jSMNjryuMXnu+MNr282japARGRQbiNkrn1abImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olORSjONvDolK/Ge6D0DZ2P+WxDjDdvsMkxI7Hgr/xA=;
 b=qjL7+V4OV5dHi5CsKOI4fpiQycQfI7wglakByBHw7SKpXMI5VE4ziA/wetaa+REfOhyQ1ClM31csevpHBHpKvWxN9E/42Qj4ItnRMGubsA6noLLtimhUh9GL4qg03cNN7u6WsN1TFNANpfIGzB/85siknLymLr/rEc1ZzR1Z1TJooLfkv1PCVJQkRm9TnBl7hhHWfMvXDfk0V/tFW/MidUOydGeoNa2QRb/n3LwUKGPPeFnsqx7ZR0a7aQkYzlePUj2bfqELn2u9Qj3ofDK5FBdBr8Q4GuN63i7SUjhAhV3uDfS1aJ9IY+QLka+YQoLFTV1lKX7vT+OW2AWzqQP4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olORSjONvDolK/Ge6D0DZ2P+WxDjDdvsMkxI7Hgr/xA=;
 b=BVHzwp9rwp+OfcCh7fkWn62toERfylEOZJc0LEm22OM2HI+kiRRa+5gRmn1ZuE3c5JanWTPEhcriTgSIPObjvG9QnaSCuQJ/0oSCBXV6digqeRdVoePmh0ilgLAexue4KyPJYNAl7j+mpjJoQXUz3Bb+pARkF7btk9ZpOv9u7m6yW2iPHWyORfbHweWT22vENZ+XRRdWsxIuqeft/Xtvy8ssu3hpwCbGGu/SG+0/oPYJBVddsFmFxCWknjN/DT2BbTjjSree4hHSIQOAI29qmfnDpieZ5f30MmTa7izwHrYoYnHwsy8x+9Ukve2T/D+Jd5zPJvzViCkFcLmvNEDhwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21)
 by PAXPR04MB8991.eurprd04.prod.outlook.com (2603:10a6:102:20e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 10:10:50 +0000
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8]) by VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8%3]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 10:10:30 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/3] clk: imx93: Add IMX93_CLK_SPDIF_IPG clock
Date: Thu,  7 Nov 2024 18:20:05 +0800
Message-Id: <20241107102008.3626023-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:3:18::16) To VI1PR04MB7055.eurprd04.prod.outlook.com
 (2603:10a6:800:123::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7055:EE_|PAXPR04MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c3e8f9-857d-43f3-158b-08dcff1468b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BNitcbNZ0wUxvHSAej1FtNM1VfvVnBoFJfqsmg3PEUwFODa0ISxpsk9SkwkG?=
 =?us-ascii?Q?Pj3wjB+b9KnppayCJYw5UvFdmF12IKjQjoMf6qyt/cWsntiO8w2cZQeuqY/O?=
 =?us-ascii?Q?dZk9qBOeEu1mg/Kl+/Rb2fSzpPEROcrQPpZOkz48Vhdk8y9yZtm7s5lUFFIR?=
 =?us-ascii?Q?kPlfxvbr1+U8Cg0vPJ3twTdTeD5VTWfd8hPI1/ywjMMoUlfIY0p+aaAH17oF?=
 =?us-ascii?Q?H41IMM0NmazZ8OvEXD8fV32Le/NnJkyIw3EsjDYPR+5jg40i8uLt3mUhre0l?=
 =?us-ascii?Q?pP7RHZIpvKrC4bVaPp/baUAOey21sp0+dR2DE16l3JAEMXObwqpiC9X8LvfO?=
 =?us-ascii?Q?w190U+Fw2cA7bO3nkVNuXnG1uTe27M3KRjLjF56AqCetGfIYFGsRuWWqogXa?=
 =?us-ascii?Q?1qLKfM/1JrGKOxeBzpw0C9th1FpnXZizGSK3+VTQ4cbQypPLnGArybkSfWwX?=
 =?us-ascii?Q?m+19XSLek75d47yljthKQYmVSl66FSBxFuGNsLz5aEjc9UHIqGF2Zq1DSdSh?=
 =?us-ascii?Q?/Y1mKRzl/BiupyyHFMhQDgG7C5CM2JBLm+iU+4f0iOEB9fVCWioQeOu/e8yQ?=
 =?us-ascii?Q?gUTJqWYx2JAJ568rwf2nOItRgRcJLLDSwCzIyn+NU5iymfBLR2u4R2/W7+pK?=
 =?us-ascii?Q?3svUDmeQZgNkX4dTKzjPt1MCO7coANwo7zQr4c5HD26ebEXJqU0LFeDKsMVc?=
 =?us-ascii?Q?9gI/IPjkV5bLojivqnge0hIBfokQ2Y25ETf2Kz37LyaJ/aB0iDRhmhckvXfl?=
 =?us-ascii?Q?nW5rjjvDMhXUt88RYSd/Ofl7iNxYPVj2Q5A40X8Mjo9M7sBqkT8kyfuZKQ4B?=
 =?us-ascii?Q?FioD6zQfkZan9bH+adVorrlNMvtuieccQrqcNSgeoT8GH8M7OEa6HgLw6Ru5?=
 =?us-ascii?Q?RhCcAxbg99+hrj8/6P/AsOMhrHAIN3wLunB5TYmcRC4qBZ0R7qilOPkYFI+b?=
 =?us-ascii?Q?/GYvehBmpnn/arbGLMdXwSsia3vJFG3QG5/fNpEoCixsCs3eNcqiDRlOVgwl?=
 =?us-ascii?Q?rwz9VCmuN0Y8UbV+/eYtvOxmD8XoHoWJWja//0zBiT1a3DEDyXCNwIN6+vqN?=
 =?us-ascii?Q?ibyQICsuQkp053cgqxHMVkqY24qBje59wcvZr2l9fffx8ajsZIkoPoqrE3Qc?=
 =?us-ascii?Q?45qd9IJfXpnVo4hpjNTl8/91WHUDN3h0P4ZCb5REw0n8u9lWnFCz3S6Pzj9M?=
 =?us-ascii?Q?Jh204u8gcB737amZmc7Kl+4EC8/JoPYZ1GMl5nyeY45b1WI17dLU7CYd9EL4?=
 =?us-ascii?Q?cyHxsD7kCB/PIlD43u6a9e/saNTyLJF0INMsg6Bz2j14KjYrWnAuTaSnCnUC?=
 =?us-ascii?Q?GR6mebRfWcoe1tuaaaRLBwnaugDNtPTBWcMi1QimyNNcnDlOuxMnPIUgwks8?=
 =?us-ascii?Q?vNHtIHnrhbk8T8wbC+q2sWQxDaki?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7055.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eQJl6JQ08rLeoFGXKP7xoJHj2hqfRQWwU0eD9HGyxp3Ftd1Xch4AoKnABWSW?=
 =?us-ascii?Q?1Gf6UbABZr84FEcPG4rGkWobjfLSLy8NOLSuaeSanwJuIGg66kbyMyshXEL2?=
 =?us-ascii?Q?X/Q35vQCihYRrCXg4fIVNnSm9Xc5itMxg/VvfhdJ1eVHkx/U3k0emEBB9EIS?=
 =?us-ascii?Q?Hqya0zS+vf31ajH5LaHY7HhuC2oa9IbR/6CJtkTFSjNpIv6Tg98LwliUyOgL?=
 =?us-ascii?Q?394RU2YTh3PYZwRDgjd6KutXkCJl6b1T96ABn4NH+KNS3Pe7xzYzt+UcFNkv?=
 =?us-ascii?Q?5um1mNm5hIaGekaNu6jw+mJkWmsUUn1YMUtNSMBItNULqVy2+9+rmc4Rgwsn?=
 =?us-ascii?Q?Oc9x/atX/V4DZK83MlO4iJA9u+p2cUwRi+lQErw+t18eQUBEjFwVpngLUIs/?=
 =?us-ascii?Q?bYIn9CYhUN/FqVXpk3MrxoAz1NMBULmzn68vrSqvBuW0kd7ex55TOZWn3Y9S?=
 =?us-ascii?Q?QJVyh0gBISnYRpjEXI799b/lg464Z83Gk3lqqKMcJaOfMrKdDKrl87MvPtOu?=
 =?us-ascii?Q?2Gb5gSdhcBB/wLLQzw0z95b8d2g57KVyc5eYxBg3nifrbCf3wsgLhlreGd66?=
 =?us-ascii?Q?8ZBsHKTAorEDBq53HN4z/0yU3D0KonjbZ4cq2oJ/35dDDmI9ZHKx2P0Txyfs?=
 =?us-ascii?Q?DwvxYmsMswwYrjVrEvon4QamkfwOz4QoV2g48NcWFTIRzmjDHE4JBLQNVG+O?=
 =?us-ascii?Q?VzTp2GS/D5TaZ4CumsRZDoLrdIFUQvS8KZ3Y8M7k7x04QsjRP3WQpCzrisdX?=
 =?us-ascii?Q?DDFAfexyMhmaOKtl9ubTRBjHzWXdVlnSfBBd17fQbF0du3OURljZynRH1Dy8?=
 =?us-ascii?Q?CRMSp7i3A5yja0+gjJr5GW9taVFY2J3Kie0uMK3tNCqoW6kDuoBbRzaWKZzR?=
 =?us-ascii?Q?aGkhCLIkOHpSeVB0rDkMen7HJV+62+ePpznkN81QDsSJtM0CYe11ALzHcbvX?=
 =?us-ascii?Q?kq5//Gb0498203iaZbKBMc1zapb1ZkGZIhquCHOYInhxRY5MNmDhCYFZ39Om?=
 =?us-ascii?Q?IrycwsvaN+LhicNwUBg7T06ZXODVJLiFI1Db3lSCqWpQe0hATzdEu3zHljGd?=
 =?us-ascii?Q?4IAhAqTa+Fw6jbjU5m6QvaD6ecaFlgooP70VfuPLFlFCuJq0959BNxD7W2vE?=
 =?us-ascii?Q?zWCgmRBEiNALs6fKw816Aljtu/q+dgd29TfEz+ozw1wt/2828TNIeQNP0Knb?=
 =?us-ascii?Q?h9cLsNQQXWdd16MJDCE/Lto3sq97XnzfxTzxMGFpEILQBBNhuwzcBEzFYmVX?=
 =?us-ascii?Q?RhYfuEoLeKZ1bvhaWnNA/4Wcf40YO0Y5KURdHAukgXylpmo81IkVMSjAwzIO?=
 =?us-ascii?Q?8apbrP1rRIDhqX/wdao134pISnZyvkykqZBbUbtsvwpYRdejQ95KJFEFaxmT?=
 =?us-ascii?Q?Q7SBbtdaVLSPxBG6+g+6Vs1BXMj1DsNHgVaqJS1vST8JzflLMLtE//EPFYO4?=
 =?us-ascii?Q?ttPuepZi9QEGUDoskRYTX4jAuT8q3XPdCWsDgx1m2DX430lO0r150z/QsgIK?=
 =?us-ascii?Q?jAxzc4b/Iv4jOgNaLB5b86SUiNzfbqD0PuLTJptpsFOWG3Q+E6iouhgrMire?=
 =?us-ascii?Q?mupFUvswsIPX2Fh/GSdWvv7ZUUTkeh2EjTy49zki?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c3e8f9-857d-43f3-158b-08dcff1468b7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 10:10:30.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+cSFJzNcdqKxIUNHTr4fLW0kyvQZyQEvm0IgcO+h+UDmjP+Q4fqDXdvjBQcd/roYXNpx7o/C2ZLA2xXmtwU4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8991

The IMX93_CLK_SPDIF_GATE also controls the gate of IPG clock
and root clock, need to define them separately.
Otherwise driver disable IMX93_CLK_SPDIF_GATE will cause
IPG clock is also disabled, then register accessing fail.

Shengjiu Wang (3):
  dt-bindings: clock: imx93: Add SPDIF IPG clk
  clk: imx93: Add IMX93_CLK_SPDIF_IPG clock
  arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG as SPDIF IPG clock

 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
 drivers/clk/imx/clk-imx93.c              | 6 ++++--
 include/dt-bindings/clock/imx93-clock.h  | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1


