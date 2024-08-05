Return-Path: <linux-kernel+bounces-275216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FE29481F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5FA1F21C57
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4BF16131A;
	Mon,  5 Aug 2024 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T6DlzV/9"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B715E5BE;
	Mon,  5 Aug 2024 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722884082; cv=fail; b=APHicOCvH4llVF5TwsBu6mORVX2bOFljnybrC7kRgeM6SEvTyZnYCiaYn929Pq2xviKKcKGwWw0xiIGORqvZ/c+J8Q84M/iH7ePLfQz2yoD9ccUE6VDbiH9nvWb8abb9XB61EQ0PVipQPyGpnmVEUf4JtnBNNjvoedNC44wmsF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722884082; c=relaxed/simple;
	bh=d2M6WCA3H/wmKPMo85/Zh1QczBTt+7NDBovafiYBE64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UXZNi8FA0iaCdANs+CMuU/nYadyyGiWK6qXLmQZ7K8nJF7FRE4fg6d7fM4Yu9XyRiMBV9DYFcOVOvxG9fp0QE6nvTadlJDluOtb/w2cYx5B5M8rCgEF2QWzXSLEF9SjyHLCHKY5WMkVAmU0ulJ2Z2vK0Ub6wL2yY99PxoufrDK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T6DlzV/9; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvFaSvBvRiSPesqokkpVbuReTSVtPfJPA7TEqx6Dj7kbeq/5a+afddSSZZXJ2syvN1pOPr3kkMxRgn1o4+lSPhw3oZ28U04MVIx9cTzh6fXXOCeMJfxIX1B03Wuoc7bcdZphptY/hkJvMiWmcB4b2IqP4yHsh9lOJFrU7/mM6aHoO2TMYl07sYkgGHtkMZeSYPAUmqLTDcNoSjZWXcSVqfaqG7CVyvJ/aDRCqwLPIL75sJBQubbktgxJ1zMRHNRafiMX91DP5470Q58RMlewdBSvNy+i7T7H8fE65Sx91kVNZkdFsiBUINZWk5OHvZHeJhAjMkjxODnaoNGXM+G42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZpjhodwVkDgrMffOPaeewR54U1cupibazrvXvD7co0=;
 b=nLBCEz0WLmqZkjKQhmpHr9jdaczDYNhNj4kWMaIxPy+tfNAyfoxduvRHUYHyybbKyWBd5szskg2F8jUMtJneVCvhMWHGIpmdXHe3usoAtZqP1gQnAlmgC8tui6IvG02ZeqwTDRWJEefPRsVQbzNL54iFy8gvs786OyHSIeMy9wEaWzqt9ghCLdVRLbUFdRBxpyIu5/VAifGRebWXp9MGFmx1GjDcR9Hcc/Aqxkux30KEU8IHL5X8eWXDM+646j6pdiRc4Qk5V0iDKIV41ORZELR8btseU4vz6W2Xabv9MGYwVq1rsJ6ig1hRm5/n7nJ1r15blCL6QnaiQOfgGXnQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZpjhodwVkDgrMffOPaeewR54U1cupibazrvXvD7co0=;
 b=T6DlzV/9sV52OKickLNkgL6pSQFLAobFM/UUlWKlK3PG6FeOZ4qmg7qqEBdwzV2Dm9NXGRSRoPTMsyaPQzWJifCh86rbZoM0bGZbmhDQhC2UFL4StkLHQgTqoNKBzE7VLbg/yZy+PVU8gZUjIWO+53CqdLyNYCx4Kal3XZElEV9zNGV3iXOjQEf8R1NqoMBllmhaTP+BddUGQnVvQ+H2+oplSAy1kI+tybWE1ACGkU1oLGg/qsQ15SQha5foRxi4xx+JwUvgMiVc1EoInSYxrG4b4wxPnx3GdNWLqSI8fl8pQyTqcbFxcl4SEzayI/qh+BqAJIwhfK8WYTAghvIXDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9807.eurprd04.prod.outlook.com (2603:10a6:102:384::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 18:54:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 18:54:36 +0000
Date: Mon, 5 Aug 2024 14:54:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: imx-ocotp: support i.MX95
Message-ID: <ZrEf42EvD0pToaiW@lizhi-Precision-Tower-5810>
References: <20240228081355.1627744-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228081355.1627744-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9807:EE_
X-MS-Office365-Filtering-Correlation-Id: f1636bf8-4ca1-496f-ad18-08dcb5800d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bai/sA3UUfxtt7pN7Ss/uB+5Cn2B2+OrFImzr1Vt8N51nEycS2uTJjrimVfN?=
 =?us-ascii?Q?phIwDoOnVYMhxAIb51R5MVJMJNsrc0lUhIziuLYy1xC1zqmoJX0Xg2itCvPF?=
 =?us-ascii?Q?PHD2D21FM9Jb2WcaQdKRPc1Pw0VIWzCy9woPmf7yEQmDbsMXCjWLXdm3fjWu?=
 =?us-ascii?Q?Tds5rE28FUkTfoPYSoVmvzDfoX8KXFmBnojFNta2m8m2aCGi0WI7OdGSBW7H?=
 =?us-ascii?Q?Y/tNSscOyFNlbRo37oo4Mp2rvdwr+vyh8HdKdVZ0mR5LxVA7J9pFHkgmdEtH?=
 =?us-ascii?Q?3xn6T706zMegK+2nq5Pq0ytcPTXMZ6H0V59TdxssNGrN5r+TeuFtxvF+DM8o?=
 =?us-ascii?Q?2+Ol8dOf/uukqbY1K009DVJb9FcATRaHp1cgIYa/bcq8Miy7vz1O4YQ97He2?=
 =?us-ascii?Q?hmpvFi8IMe+bAnqsoCyWRSGBWgBaH6bbn2eArQCZhzjl8p3ox0vq+ZWrjb+v?=
 =?us-ascii?Q?iY5KkMbcObekhg/xY0xCR9sW/oVBiwnHiP1a69W6pPS+DeBvq1lYUJQqMJ8r?=
 =?us-ascii?Q?8Fd8aVC2U49oqRsWtXXovGpoTYtWKOMoBwrYgnjBfZXRQKdEVJK/GcXvXTm5?=
 =?us-ascii?Q?XGM5n5bKAmoBlaRgiJAKeq88EYW6SIQS7pHO18iPlFd+aVngEEJG3o447aDY?=
 =?us-ascii?Q?/qW+2Mp/qNW19AcEk6TPAui+tUKhB/dei8PUcoJo0pu/F1VnzacBAiFEW3W1?=
 =?us-ascii?Q?tnzJGnPvrX8+jNzogFhqhy1d4omMXsUXD5NK5dpk2dzh6jSmcEQ5B99Y7U+0?=
 =?us-ascii?Q?bgR4g+7kMd5g9lbVhIXBusGg1PKTi8qrf/wMDdV284dU7upgfPxw+ELCgvb0?=
 =?us-ascii?Q?hJO1YTK+/XiMHhjWcJJDdSOIp/kBvbChxqQDw7qEh+H+qQDIuN5iYLlzFW+Y?=
 =?us-ascii?Q?P9EN/o89/aXoq6a6xwpioBQI6Ld7LeFZKluoRvqWXGwYADMIq8REvMIHWADH?=
 =?us-ascii?Q?NJluErIJWGX3lqYvTM0gAegJQDPMfClngC9eXK5u/E0fLFXYLIAdWQlPR5bA?=
 =?us-ascii?Q?UOotvH322laMGYFrn15RlQuNSuLRQAE0+s63aa/sr9wXZ+mU074YdAaPlMd0?=
 =?us-ascii?Q?R/tkBgRiUfL3Q7g4eHwxrN7TYgkb5pwi8+UQYYLqz/TspBOtWFixQP2k3a74?=
 =?us-ascii?Q?IymRsIUJ5yC3Oe+Hm4BjQ7MJIM3awT5HO4UwS3a0/KQoY9xIsHSThN5xjUMu?=
 =?us-ascii?Q?/0xSUveFtqMa1c3F9AGnWty/sFTg+xiFbv6r82D+i1KRvCMY88odovxyfF6H?=
 =?us-ascii?Q?ik0r+h7u299TG5i10eYAN2SQDskE8vfJMPBw2tmcpKR2koVs20v/1nCYN1aE?=
 =?us-ascii?Q?xcZ9eTimJAdiz5PuGCgVvhHwogLki8g4j+nxoIj1S91wXmXJyCabsSy7ME2L?=
 =?us-ascii?Q?6UoEspc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KXPUSCip/yrKCb2t1EknByLqOgl5ken1KTkEG017WLf5YsD4M+N6sXumVSrT?=
 =?us-ascii?Q?mq5EuGNWqTqHL005gBUNhSja+sBkX4xr8yvzwrU3hQp0zbZOWmkQ6f4HWSOi?=
 =?us-ascii?Q?rEY9rrtGj3O919N3WQ709K/bferTsZaqTOovBr9OLR0ME6G4P7KhwUVwobNy?=
 =?us-ascii?Q?qaG2Q8/QGp8DK14FwqKNk/jio+/41mCxSGzUnEksIm8txS8hVAdc/5y6mKFX?=
 =?us-ascii?Q?Olr0LgTbm8tz3EUNmkUqjL94tAtWwzGhfZgvX0uX4U+mzRYwLMVz/zGo3xgL?=
 =?us-ascii?Q?E8kbFDZWWb7IhtTw9JfTmLt4eU/3Z0g+nOv3OdTRy4GnOOvuEq3/f/U6WmrS?=
 =?us-ascii?Q?8XF3abxg8wndpjQ3IdCgXOxrCkFv6cJuiIIZsCCloxeC4swIXht5Kx2SBgfg?=
 =?us-ascii?Q?6wN9skxLrppjnn+Vcswwf5B+F/lD2lmKakxdqVnUujGiPD916GnEwS75YguY?=
 =?us-ascii?Q?bPUAsj78EJJThOpnn+SMb6qjG0xP5/ESxnBXUMNih8Qrhuy7YcpXBkat+VMg?=
 =?us-ascii?Q?t4P7GoSGRZZC66NIvhKkvJlJbVmehALmR1DUr/f24p2ho8ft6ehnr+76zPL2?=
 =?us-ascii?Q?VCEDIwPFEJP3PH357eIgbIyPC5ibJfLasV0bYb6LLP94wL6jhHIugOPbECW0?=
 =?us-ascii?Q?7uxGG9dX0tA3PnMAAsdH51H5xF5+Mphe+Ws0tP6J1KiB70KvbzG/vmCN0Ndk?=
 =?us-ascii?Q?RE3TE72ZMU/VWYan9vNdqmW58GbyP+lcplB1JM+lJ1LmHxpLryPvwm0UumqA?=
 =?us-ascii?Q?YWn+aCKKH8APrH+4B63k9tEDmf/JhKG/a1qc2w1JnfVuE1xZHpWu8TXQyouD?=
 =?us-ascii?Q?sOHigISWhXyLSUbPMg4aTNT9M824HWvP09R+WIBQD+1Kn/qfvGkyTHm9w19B?=
 =?us-ascii?Q?grGcBtX9mkfOVZDCEP2cE1SGnl9aLMeQjFdydCHI1MSpMcHQe3EkFiUnfrCz?=
 =?us-ascii?Q?DpvhBQBI/ZQEdDpPZN/vclt9aPwPJHq+cATRiqbTe267tnwFSCP/yC1op/Eb?=
 =?us-ascii?Q?jKxy08VRHI6SDueM58upaprhJDCJOaPpdCyGMVKVR3O3WpiyQqJ9N4CgmEYC?=
 =?us-ascii?Q?KO1n1NMPmYdul7CvsDHG3g935Sb6lWib+ecXbM4Gf2tmztiGK0LBwidb3nFr?=
 =?us-ascii?Q?wBD4QEv7QOAybpy7Ck7y35Sjyiv5EFXJTVd185lt9iQ0jHgEd+9kGfHzUTnv?=
 =?us-ascii?Q?5gg/Z0dHaoqpAOPOrdKumOEVZO48/pMY+HPaqKI/Bw5VUNzzwMdYOyZs9FTV?=
 =?us-ascii?Q?Kj/5gSRiHB9yfLczHsXOuqsTz1F2nPbyrYRr3Fp4eGveCRtDEur/w7RCm1vq?=
 =?us-ascii?Q?gAw/kwTmz+Mhj5Gp9eODlgZS0+8FTxZSvjtwS1xd/7ykgIS1WKugggS7jNwg?=
 =?us-ascii?Q?YQ6QapjrnIz/GyKsYW6W99IZJRJD9EDIXtXWuR8ptC3dTLdD00+Zx722WAfa?=
 =?us-ascii?Q?mMUvatJNkVzLnuwu9Hxp7pKLG+V8ZZ+2EIr3pg4N1VkHqCSIC4+D3dPMpH2k?=
 =?us-ascii?Q?DfHKS5ElWFM+CQqkOTsjAVOpfZIwKqC/0/yunfwu/6/e0y3IATu4R5q8s0yS?=
 =?us-ascii?Q?EQYUbEjSKGVgY+YnAKkXhlysUvc8nQMIb7O31jqX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1636bf8-4ca1-496f-ad18-08dcb5800d32
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 18:54:36.4330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVUzEKYjV2mYG8nBJeanxG2GI3MWmW/1bE6KWXmvuHNKXIDqlbH1oGxn8z/9pWFhqFIzc9CHAGAsamYV1GQn4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9807

On Wed, Feb 28, 2024 at 04:13:54PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Add i.MX95 ocotp compatible string
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

ping? Krzysztof already acked this patch. Who will take care this one?

https://lore.kernel.org/imx/38c0a765-e29a-4142-8f0b-7e8f2ea89fdc@linaro.org/

Frank Li

>  Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> index be1314454bec..e16f16c14505 100644
> --- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> @@ -12,7 +12,7 @@ maintainers:
>  description: |
>    This binding represents the on-chip eFuse OTP controller found on
>    i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
> -  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN i.MX8MP and i.MX93 SoCs.
> +  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN i.MX8MP and i.MX93/5 SoCs.
>
>  allOf:
>    - $ref: nvmem.yaml#
> @@ -34,6 +34,7 @@ properties:
>                - fsl,imx8mq-ocotp
>                - fsl,imx8mm-ocotp
>                - fsl,imx93-ocotp
> +              - fsl,imx95-ocotp
>            - const: syscon
>        - items:
>            - enum:
> --
> 2.37.1
>

