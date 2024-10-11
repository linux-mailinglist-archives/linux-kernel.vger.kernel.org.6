Return-Path: <linux-kernel+bounces-361442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F0899A84B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A67281561
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09894198851;
	Fri, 11 Oct 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WwJusExm"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8832EB1D;
	Fri, 11 Oct 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661815; cv=fail; b=GXjAZPbn18N6EC1/Y1hCEe5b/GbJ6OlB6iYhfpLusDzmMVRSGUU/90MRl5BNo/yqhlaolahBSOdxCq06WpHoInSMjYwilRyXwr2zcqo6c8NNyn4+PM8dWICotVH0EgmcZq6ygLJB0u7tvlwtYXnyL881vIh6CXyLCEuEf+RdmYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661815; c=relaxed/simple;
	bh=hQxUKq1naRMj/oRlgH4OV3btF+BY05yZXZ3N7lsE1j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DXSN9nw6nC3OLzftuZLMiFWBKisSvYu00HaUo1DwSFkJEanVrAnqq17/Iplf/zaXpkWuLEH1t9pHRs9WrCH2Nl5mXwCp6qe/5wJ4PKAeI0JDIYiio0Omq3E4N+G31QW7d0PDvzqY6yE1PbDMdCf4bv0ky6bUNSuTUhCxpU79of8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WwJusExm; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPnBOkZtBv2pNGTUW2xt36LtC2tSRNDmR9xZNsjw0UQMiHMCoVhTwnlgf2hVun2/5mf3UYYo9qk3SS0zB1Hho13b+5IjIgeZye3/GcLdImgE3CM+bzo6V2JGoQ47BSrupoED+Askk4I9pAs+CUTw031CxVi9MBPzcbeSfsNTU+pApIEryJ5ubYkHCR4jf/CC7XlO2jCjE511WbFs9KW8naR5Ch6udE+UwoMXpQlQVmKiZPXheFNE7JCABVHFIrIlHF75UxFCy9ugE1URpD4FqCIBtnggCgtRiJzzTPA7fdpuP6d0QJcBIRdd0JAVKWTxdtW2+RL/anJQX40iNr+tSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQpzQYqSvjX+8UNAh15DzG54ag3XZhcKlrmvbCQqKNM=;
 b=HRt1LJQhOnvV45LhnhY6Osc/u8OBY23dambTKl6jIbs+MDltnywEAwxr5cKTTCAQsPW4nr5fszI6t3PIuwMagfTIwVzzBcxEL0noxQjZS/Psj2H3P4ObNktHhFQ/WSaq9530T/KJbE4zKVQnCaNpYkZEFAH0Nn0m3OrRKhVnJDIFQQG3BdUfmrFJOK2JOVNqNOQlGjpswoBWraduOyy+ALJ9H9gfgSlXUw/RxbyOcPJ9IxpreBXj8Ysyue1xriwZ11nPKW7ZYsjZrfgYeTtj6GKLW3EdoUeoBo0HF88hWkLRtkyMt5vd8wi9aS+A8ePM7HUgQr8Eld+YVcAlgUG8Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQpzQYqSvjX+8UNAh15DzG54ag3XZhcKlrmvbCQqKNM=;
 b=WwJusExmocaxbmCDPz4r/07dGTllcrib6ynnHO3S+/Y6hufqa6dgQlpNDQr5IWFXtcvXhNpO/tMiAXQNMmMytYoNNwmAoH0t4hOlgdL7hTncArjne450QcmCd1/xT4LjlPQZFbrR02MgxA6FEr2x3Gr31sVn8Wh+I/TW87mbPXUD/b3GH9nB5STDMYqZ/0MY4Z4IkqAIe1UqxY94d3eSKM2wOfRnUrNpm2bmdSJteh+P3hldyqnjC029+xcM4szCvAid72oJYvo8PefC6uSYaBx7Fk6ubqtR/YYTSus6Pj0wMV6+4NJSzLnMg/GXElLND9YKatxsbyejmGcOwdVLyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10617.eurprd04.prod.outlook.com (2603:10a6:800:27f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 15:50:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 15:50:10 +0000
Date: Fri, 11 Oct 2024 11:50:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/6] arm64: dts: imx8-ss-audio: configure dsp node for
 rproc usage
Message-ID: <ZwlJKT6000Q3jSdE@lizhi-Precision-Tower-5810>
References: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
 <20241011150439.4027-3-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011150439.4027-3-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: BYAPR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10617:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8522d4-0262-42c2-2c4b-08dcea0c62ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R0Akdnb4OdP3HDejzfRxFUFDiW7dmOkwzvrjFeQbmAXSw+gH4lghqil2tN6r?=
 =?us-ascii?Q?OZ0FJFdp032bYsfJpVY95dAPoz7sC9bA7zFRTmw5tiw0+5LrWmgjpXQnc53Z?=
 =?us-ascii?Q?XPg/GC/INLnEY+7zXFUQ0LpJDG+izPgBTbmUCAWlNLBYGm0hSWd1unXbDphN?=
 =?us-ascii?Q?EJhxM/2ZeKVhQJQ4PBcY6jCWwLSCqszrCUyputUOskSe9Sp3EOfpdS45XHr/?=
 =?us-ascii?Q?LrYsloA46eZSUDlJcYf/vuBnIBejzMaqBhuvAp7itIOOHNRh5ZH5XWqzwiXz?=
 =?us-ascii?Q?gA6jlVmG0Ti7WRS5BKU9vX5r8yCw1I7ShAukecbUBJzNic6h7+KLjJ/3mSgW?=
 =?us-ascii?Q?V1NkDoVtrLec1xPBPUMmPB34mGubYcQw6OMC0slph1A098MbVb6sqRjUgwu0?=
 =?us-ascii?Q?oN4lzWMrlc2XCJByC1GLeuXTPMdh5ZzIsOD5ABjYyaGwEW7+epn4eTEdzNnT?=
 =?us-ascii?Q?KnC0PacaW5Qk0D89G0sH6el23MYowoq36uXUbVFDdNZRP1Tths9/tPbjPhd5?=
 =?us-ascii?Q?UxIbt8z1slaiAdTDrOufUZxH3F3gNIcewWyx0xxCtdgN2hYl+Z0kbBtsAJRT?=
 =?us-ascii?Q?TMDqk+n3lZwVsE1Mb27vyJbTSDJ99AsW02lMkX19UOefBvH2Jj3EaS4iIR10?=
 =?us-ascii?Q?dZk9C1Bgexh8wKzb5VggoSA0mxjZg5atFoKMmZ6a8RhgvCK9WykTAKbynJtB?=
 =?us-ascii?Q?JODclAB1/mOkt3bDQheMsESvHy0skgMDNbANfWrFH6dHdn6xAI6MJBV9SUST?=
 =?us-ascii?Q?RIm3pDPDljapId36rHPZq0c6kI4JycZIv4vLU6/VdgrSLK35Y6N0m85CHuro?=
 =?us-ascii?Q?rrfbxIkpdpIMB5KeBQQTKEIT5x/X4IgVVQWa783rAK76+cL5uJswPBqVLzAd?=
 =?us-ascii?Q?7CCWU7IKX1PSnGbFTNatKGU1jbkBIDwVk16FJS9UfrlDAZfSeADRvBip4Wsq?=
 =?us-ascii?Q?rF1h+OfaWxprWwUjfcLbAMC02J1IAJLS3o91ZPkErzTHpVrM0/jly4aJP0ru?=
 =?us-ascii?Q?60uTU35A6cDw8jb1ucJigx/cPiS+hOb4PT3KwacPbVluzFRm1/YU/EH4FcPD?=
 =?us-ascii?Q?uoOvPcsQrR97n71h9SFS5DU04+pN7ArNPtg4xUDtw956L7SgLBCtT11wziEy?=
 =?us-ascii?Q?sCsqI/nNaHqmz+4e4iuqj3hDEwdMgsZ9u5L0YbS9DOlWbAR2U4EeysG/xpqy?=
 =?us-ascii?Q?naec7s5v7m2ZYeDGiUdzNOWE+aeGDwDBX4EA2FvWKRC5KVWzLc84eK/ezYWN?=
 =?us-ascii?Q?7HTkpXt2c/3K7CFKJpCTZcH6C2qvIE2uTy4j44nZc4Y0Y+gdCi/bhGTMx45K?=
 =?us-ascii?Q?CKIc1lYe4RYstfK2glvgXXKoLVo8wEawn8GBnXjWMLAV5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ZJqH5P68OGUz1dsP3EHBlsN8/Nh7dyGtLETH3M+z9vJIO779wO0AzR86oLh?=
 =?us-ascii?Q?EwqFrKZKtvLvJxNeC4efVyoW+0LPxBzEQxDG3pFSbxxWBiHDGXrUBGYZ23FY?=
 =?us-ascii?Q?ZhcchX51eM4UMMfhT1d1gISlKP+G76rIhGIcEQMC30VAn0EvsluKzozx+rtS?=
 =?us-ascii?Q?4UebcXqD5wFtiqbqv4arLcm2BxZn/fV8DMthdWlzvGksEH2s5BLoeVR4FAef?=
 =?us-ascii?Q?milLrdNHa0W03MMdv2nLEdR5PrqIATlT2tx5jLmch8BfHb/LqTKoQYVE27FA?=
 =?us-ascii?Q?8XPkbN3VIfWOUNQ3IxGhU/v+VAZpZ2zLhhoe4I1VNO99MoReaKVUU5/8oeH3?=
 =?us-ascii?Q?m2z8v0KfCastPK3NjXHUEewZxhBvZp/nCcrrxYT9ElswnYaoqBtjsV3ugED/?=
 =?us-ascii?Q?7aGGBFAD7I6OZGW5LIoiDE//mSdahMbiwaUtL5wZH86vi1dUu10t9wKmvY+2?=
 =?us-ascii?Q?IylMz3IRcCy5jdb+T04OEFKQyJJNYoE37LP+vpnZA4CJIp7hKe4OuJL0AsTt?=
 =?us-ascii?Q?zbUiAmKz88B2/khdeiDrWnc6C5TZGOPKKFEzJOm0nKmqKf0CcfTQKxh6KJD1?=
 =?us-ascii?Q?7S7sY3Yv5CY8n6D0m56W8bAZvcqVP7KxX3cgGKY0c5cq1ov66P0h3n3rS7tm?=
 =?us-ascii?Q?Ff/Sg6bCm0Xtaf6q/BR+xGIqB3tjGdOl9LXgKvux56/ajWs+xLAn7bwmx1P+?=
 =?us-ascii?Q?IQWs3ktBVkBRLuzXY8uECYNmD6hrvjrBGUe/bKfQqXxjn+ZCYF8DCPggzrYw?=
 =?us-ascii?Q?UDL8r/L1EHFXM8dvt+pL+QrVLd5dR10uzztl0mRVtFcLnmtxUYpSIVampit7?=
 =?us-ascii?Q?q+sXspGXiNVf+23AuDjaZF4baYrlA4l4dT2fpQDJ/XYW5zQ0mFwmE1Zj6FSZ?=
 =?us-ascii?Q?XUr6RzUz2pYxNIdYhObAGqU0ipVyUAzvPUE7xmpBY0FTcSOJ7jKwgRH8sWos?=
 =?us-ascii?Q?TF9HaWi8WRsCQpmVsqQlIZFesEso/DAialhHVRfyly01quM4sVNW34407NR6?=
 =?us-ascii?Q?WEGDt3isso7naMglRU0pTyS5yOoeuXJOLM1d772/bQ0Vm/1gwyBlKerYTGSm?=
 =?us-ascii?Q?/6ogD4DLGhcpPKGAszfs50yMyADS3dZch4t429wkrOWzCcKEF022gIbL3kP1?=
 =?us-ascii?Q?/2Fp5tyDrCmPwVwIBGC/w6OntVqwsJ3mQG8jiGjFxzjeKYutNx5trQCbKGaP?=
 =?us-ascii?Q?lvoGqgdwUYDRlXlKLitsYsapcNP/Rgw8AVkHW8fihPyAHOveUNyelAOl62Nd?=
 =?us-ascii?Q?QyvTrvtcrjCUhK+brBVdJ/OIXAWPhAIV787GatbX52R+CJsn1XlgL6ADoB9Z?=
 =?us-ascii?Q?Sa0qis/FvDYCokJalYDsSWKb2u0R+V9swzeZusnVDZPIc78fZ2tK+ResoGAV?=
 =?us-ascii?Q?qGWglf9zGb4N9zk1PRhy89MVPkZ4URgTSyGjogpa0ERatzgNQBDyQhUrK/tr?=
 =?us-ascii?Q?suHf6b2VJe0vwuT/myOa0Gq/H1gk28krjOAXw1vH3qmainwaSwipZGfJfycR?=
 =?us-ascii?Q?+xYX449jLJ1E1t5rZxngHPYweA8DzHEiVdve45NEWSTrjCjM9eYF2Fb+e4/O?=
 =?us-ascii?Q?OkUdii9JXneQNpdJIZ1bJxEzLbSAoTbimyaztbk2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8522d4-0262-42c2-2c4b-08dcea0c62ee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:50:10.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzwsbaQgTgIIk9D1EaU1gNuhyO21Hp22uNgPHI55x4j0X6kFLimRblH9QtWYZDhL5BaXJBUS1pkSRPjqlpuoyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10617

On Fri, Oct 11, 2024 at 11:04:35AM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> The 'dsp' node is currently configured for running an
> audio firmware. Since the firmware requires that some
> audio-related IPs be disabled in Linux, this will clash
> with the configurations from the imx8 board DTs
> (i.e: imx8qm-mek, imx8qxp-mek, etc...), thus making the
> dsp unusable (since the firmware won't function properly).
>
> To avoid this issue, configure the 'dsp' node for rproc.
> This way, users will be able to use the dsp alongside the
> board-level audio configuration as long as the firmware
> doesn't need the audio IPs.

Nit:
 wrap at 75 char

Frank

>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../boot/dts/freescale/imx8-ss-audio.dtsi     | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> index ff5df0fed9e9..a60ebb718789 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> @@ -431,22 +431,19 @@ dsp_ram_lpcg: clock-controller@59590000 {
>  	};
>
>  	dsp: dsp@596e8000 {
> -		compatible = "fsl,imx8qxp-dsp";
> +		compatible = "fsl,imx8qxp-hifi4";
>  		reg = <0x596e8000 0x88000>;
>  		clocks = <&dsp_lpcg IMX_LPCG_CLK_5>,
>  			 <&dsp_ram_lpcg IMX_LPCG_CLK_4>,
>  			 <&dsp_lpcg IMX_LPCG_CLK_7>;
>  		clock-names = "ipg", "ocram", "core";
> -		power-domains = <&pd IMX_SC_R_MU_13A>,
> -			<&pd IMX_SC_R_MU_13B>,
> -			<&pd IMX_SC_R_DSP>,
> -			<&pd IMX_SC_R_DSP_RAM>;
> -		mbox-names = "txdb0", "txdb1",
> -			"rxdb0", "rxdb1";
> -		mboxes = <&lsio_mu13 2 0>,
> -			<&lsio_mu13 2 1>,
> -			<&lsio_mu13 3 0>,
> -			<&lsio_mu13 3 1>;
> +		power-domains = <&pd IMX_SC_R_MU_13B>,
> +				<&pd IMX_SC_R_MU_2A>;
> +		mbox-names = "tx", "rx", "rxdb";
> +		mboxes = <&lsio_mu13 0 0>,
> +			 <&lsio_mu13 1 0>,
> +			 <&lsio_mu13 3 0>;
> +		firmware-name = "imx/dsp/hifi4.bin";
>  		status = "disabled";
>  	};
>
> --
> 2.34.1
>

