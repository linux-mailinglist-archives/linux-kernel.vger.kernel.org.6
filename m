Return-Path: <linux-kernel+bounces-332882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1A197C042
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13038282CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAA51CA682;
	Wed, 18 Sep 2024 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xlkb5Oh/"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2074.outbound.protection.outlook.com [40.107.103.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534DB1C9DE5;
	Wed, 18 Sep 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726686043; cv=fail; b=nUdWwWOX6L8zqQM/1EQncibaNXTHHA9Q/TauaMA8J1sg4eNCqWYNVFGD1TiAILVl+quKyb8+Cx6jCoaN6z6fW1A8jQ082yUU5mhe8GTNvOEGF19HIA+bJ23cbSxymURlKXxONH8nfWrCdAFBQtNUX36k1Ck487MxtA7UspN3YpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726686043; c=relaxed/simple;
	bh=zFQ2ZxTdWg2P2sxuWXL0cgXi+e146VdxA0dWx9BlZ2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ROTnaErTcpuppRCaRpmstBw9NkqC7RTOxAEJZB/Z+rdlBLi9XxJZoVIBELVkP6+hJCHYgCYyuzh5Mj3TfZuKuDSOkHt3E/+r1XyLs3x3xk6LAy+J+afUT051EbW67tnr8RfNyYfExrhdZidT6QalUQJIuP2aM+eY3deNsATpkHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xlkb5Oh/; arc=fail smtp.client-ip=40.107.103.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X93oftBE8i8/8lTyNURSs+kFZPqd4GEifegkUsnsBbKyiwr5IgFLykQXm+Pz8iGJgXDeqVAg18rnDEOW8dufLWzBOIyuFGYa/Fkwj2oEAjlM/RJ85Juru5Z3jrX7nSURuiOnVnTIz9tYkr6cA1p9wL9FfyS7eLkUk9DPgqoDV+snrqgQ7YiD3b9nCFpsWtSPTMPcN/Fnl0ndkCJ7jgpIpr2AjnUKneWZLqozsUIw9SD/cdxVxnpzh3i4HpJ7yW4ZFuA6MwlAPsNb+gJywL8aO8HSsKrmK/0E1FHBJ+N0O4KwfuNES56LTooRTUkVmltojEzmVKLA1jyavnAM1olo9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7s2i8WZxxCPIly5z4ahlIrY15uWKkIiYfmrfTJqKKnE=;
 b=QuqnfKY4RCnfr2BVOqRnlvO2/fsITlsswnoEIdul+YbOeqxHlXmYmO2ZkyESgq1T2bwTC4uBcxoMnsw32ZciKkhBUok9LJcNtvuvtWsB8QHyHxC8p2iknc79+xq0+rjNeYZkCEqdKRAWimbkMm2FU1Kc+nF5MHB8eqnGnLh3/P6XZfn87ewM5qoUN0TicB3ovcsXBmSn1dhOldtOAdZjE3K5zN9ros9iVdq7/gDpwUDUSQlkLYN/j2ZrR3lvYPh1LAxF9EixiCoSaED0R5jK9tN3gPsPcSZKzw3wqW1/+c8XhbLJ5xjbqs7Hy8wW+jdAjQjE4h9C7GZGgAV0GarX+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s2i8WZxxCPIly5z4ahlIrY15uWKkIiYfmrfTJqKKnE=;
 b=Xlkb5Oh/MtLy814mhwPmw3IA837rPpP0+QzjzxrXWEtzCPDvsLSsNjawVVt9A8okvrUi6Ya4ja8Pp7i9sN6LBhVSl51CCLvSB2fP5tBuISdkpQ/RZdwj2+Oh1BI6P4q89dC6dGoYOR5GkUQj+m36xOwyaHcHWeCaF2sWscTRXcJnA+hz8knu0W6aP8F/k7sfYE/fTIZjkP1bmO3zzgnY9tvQ1bzAFUskRrTTYM/Pl+pM305XHYZ2NZUG0orNQ61AP9JO7oR967Pk93ucxH68T1jcB23uyhNxc43zzJDc93Gv5t/oUj6fSa4F6dmKis0gUZLStNoR44t9N+B5TQW3iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10549.eurprd04.prod.outlook.com (2603:10a6:10:58d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 19:00:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 19:00:32 +0000
Date: Wed, 18 Sep 2024 15:00:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: imx8qm: enable dsp node for rproc usage
Message-ID: <ZusjSPQ0vpqIUtlL@lizhi-Precision-Tower-5810>
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
 <20240918182117.86221-6-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918182117.86221-6-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10549:EE_
X-MS-Office365-Filtering-Correlation-Id: 05764a11-7b75-4d00-4b1b-08dcd8142bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ia6sYIjlfLCaF6xrnVE5kC5i2H5bYPOYQsjNPLEmZJqCuInUpi2gtSh1MsJi?=
 =?us-ascii?Q?NJD4i00WI49XdPpj3ykaYb8wqoSEMNVJ7V5LNNq7hHkW6wJTd68tMaon9bqS?=
 =?us-ascii?Q?Imp3Upm7wj67AD8kgml0NO2lroQvjaK6WworsjUWiItcLyINpvsS4+lJ8woC?=
 =?us-ascii?Q?KeKL1STA+EliEqpPlVLPep1gmQhcps/dhwPvHa7TohuCoiEftSVZWTZ24YLF?=
 =?us-ascii?Q?eAvKc/J1ygeBUNxZRVA+Ihl2/ixx7mWXd4IwQ2jNIDA6uSCokQ/RqiiRi+eI?=
 =?us-ascii?Q?WGSw9diERSxS0KgwxH8srZ5iP7dSTLtnCJLiHSdJqYnnxkRcFixg9hPWDi+m?=
 =?us-ascii?Q?ad45ipKAMXgw/wMjPCTrlgD13uZZ30PbeuAHkQPgFKtxJ6wmuw8vN2TQ2+i0?=
 =?us-ascii?Q?CU4SHG1O+VDriH+oOYnqBpeJg79vy10YRN1X55uXhzRuGb20BQEk4UXZk4cg?=
 =?us-ascii?Q?jdrudYsTxK184WDweHgEOownHOUCXi8U41E0meDSLfffvfFhPgPWqMBHQDsc?=
 =?us-ascii?Q?2Ce3diIWiQgtMzcNkWP1i7IDklUoTWbODEpqbxVspJklc0obLatFbPaw0Ira?=
 =?us-ascii?Q?zFEyEENHb1At/IZucoobWH+ndNXNFItFbMxGoFegrgTYZ4eAG6z/nWk22PLD?=
 =?us-ascii?Q?KVOxCzA8zG9J1Eq763UfaOrW2rlrmmciOZwZ3fbWY5lXEgUwbMZRbjGztpGz?=
 =?us-ascii?Q?jMtYDFpagkPfUsYh68h5Cj3wf6chFpQU5xYXBV/HXLNcoAIOSGdGH+Bv81lc?=
 =?us-ascii?Q?keUPL17R5C2LgHNiltOgFnDfDxZASDfvlXr9xCxxCDGZQPDF25jtjg/duEWT?=
 =?us-ascii?Q?5uyGgmqOBAS8mEuCbZKM1rimkwEHFPF+hoRK8Db9GCJl+zo/nD2G2QMRbtZY?=
 =?us-ascii?Q?YZsJQfPBkq+QBq5c5vxXNleuNcAMuAM4J67ml96KTVmB3NHCjmqGXmZ7/5/Q?=
 =?us-ascii?Q?7vbcbNbn2T5k6H2ZUl08BfnJ+MkIjtaQPu7OApmEoi6g/g7ZkFUb/Czstumv?=
 =?us-ascii?Q?JTwrj+icf3wJGHRfa3eslTV9AhWH7QkSRkTJ2WkgaTl89gfphD4t4lBzNr6m?=
 =?us-ascii?Q?/HX1awEKGggFCgYa14sW26hgDc/EjGhtQ6l2D5uhI/f5zzjESwPu29u0zd4r?=
 =?us-ascii?Q?uAjPvu2ReSowdZ6bKk92D8R5CvKt4iPI4ORyBO7SyOQP5SV8+OsF4ThD7pZy?=
 =?us-ascii?Q?neFBfdoF0Zz0OmaFiKkPt2xH4b87cQyAU6oZD64j6wxz3MabAAR/P2cRjcVw?=
 =?us-ascii?Q?c75R80F8w2A5xeUYKUOOohv+dH48P916gWLqYLQCu8+fGekb+67RDmHhcvB9?=
 =?us-ascii?Q?1dCsVp2gHBtOJgJO/08tKVfE3tPvEJQh3t/UtFm5qHjFIdPlIQkaav1hBc4R?=
 =?us-ascii?Q?ul9PBufDg3UngRl/t93N+dRhuWIwJ3ge8RqFTB5t6FLBnJj5Ig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DyupLbuloqU05JpA16gSA0nVMjzSngdvGxRzfy4mdSryNHNZwauMTFMJgSAX?=
 =?us-ascii?Q?59nb+51GDU5A5PAcbCA27JfyOy928OaDUWKbIEJGvPyNqvw6eliCpLn9oiuL?=
 =?us-ascii?Q?7PzlRkMs3jzy7/5zz5R82h1lAYAGw+uxQc7wjJX3wXpwQypqw4F6ieFFFXHz?=
 =?us-ascii?Q?b0cvwmjjEo0QjQgO7zNAyD4fodn7fdbf0G3wwzAktRivsKYN6lXNF+DPXwu9?=
 =?us-ascii?Q?mfjLaUSAg2pLnhQGRN+iJJ8x8fIxwkT+Dk2trv/5Y5F0g3pWZKx3vuMCBrF+?=
 =?us-ascii?Q?j3C1gCLnzXzdGMlh33n0zRL54EOSOMrii1EWWBk5yAPNqG+bjAqH2HiKfFXE?=
 =?us-ascii?Q?+1yPO897YQYfVRiWhHLHd1nlaEKxgEPzPDd5Jqo9c3a/MJlrzK8T9uGTfvmo?=
 =?us-ascii?Q?fZmuP8k1g9smgInOHAWA7f1JcwjSY8P0OmKQg//HLvFZkL+eG42JKKCnyqrn?=
 =?us-ascii?Q?ZiYQxA20/wMxddViXuU/9gMueo29JxCxYb9an61PYtzwiVkINmlEiapAPZ23?=
 =?us-ascii?Q?w3l1rRzL6pMTAsOI4/modE05CGX0dKpmOqbm7g21n0OoKjtzgTNNML/0BtqK?=
 =?us-ascii?Q?xPday+kKxHnl82FZ7fdOWY80m/T2d3isHoDaHwnFZyZuH/0hmWcF05xku/bl?=
 =?us-ascii?Q?vjbEBXWBdSK+GKTNH8ogGVcXSEKeNQPMFExHXqTlCHvOU2TNd2iuT5WGLHFY?=
 =?us-ascii?Q?jfXk6QavQsZv2aiwAkIuL2oEIvDo23NrbFicNBPYDLBot4BNIrvBsefre23S?=
 =?us-ascii?Q?wG8aS6YKZVZdIcYjFJgOHvuczhLQrkh9o8kDrL+aRMVxM+h4WE55u5iNTh97?=
 =?us-ascii?Q?VR1yxt8iHFiyOk4V9SBkGEKQs3yyB9kpM7aPSQebtu+UYYnLcbdUatuAHGz5?=
 =?us-ascii?Q?UkpNIe0GY+XU7afjkovTr1Sak5XISxNivtCQWJZCsGd7D5TBHE5ZLBIiY4h+?=
 =?us-ascii?Q?Veb/oveqz+RsvBdK6tHWArnWrOupNLZivbsqUvbwKQjcKdExVUOXBD2JLL8F?=
 =?us-ascii?Q?pKIDopw4E9UlRtBOxab7n0jKzjRcPXSaJcNqPiRpUDYpLdYIW0suIvBFE5Bd?=
 =?us-ascii?Q?lfx4rAH3zfTz92l7NvhlpPDZ9qotQpeDnSz4nTJaZRtXdsx30BKbX1JUiF4l?=
 =?us-ascii?Q?EzpNiPbSN0uII5kgNqG+kU8ukNLLsJ3XeU/63xlERafzrbEumR0F37hIC0db?=
 =?us-ascii?Q?CPYuVcCOf3jzhOQQtLAxeAU8et9x2gbZH4VBKah9DJboQt/LFOO8A+ViT/0N?=
 =?us-ascii?Q?fomyOQcMasBUE5moWyPA157BnNBJrf1pjLZcqL0Z0G+7oCZChLIlawKvWZht?=
 =?us-ascii?Q?E+3lkq9GEadlXqIPkxyvgn6TR4UxctV7U24/8sHTTyqZ+B+l3ed1Ac8n4zOd?=
 =?us-ascii?Q?cQ3ZWYKujLiZNW+gpvCYvZHbb90d1aSpMaLxxQYkYe7FCU4xIDrjKkRsGJ6i?=
 =?us-ascii?Q?qAMjNli9lc/h/2xSOPClzy3wFdm8De6JGV6g3NSLHvBMYTXBtf1frAQdGyKF?=
 =?us-ascii?Q?Sr2WcDNV7bU3ut5LiU34hPuO48J9n1Sg2ZdyaFTZ7VhviCUl/WkDwQkCb1Tn?=
 =?us-ascii?Q?yK6LLrA+tKaFCN//W1s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05764a11-7b75-4d00-4b1b-08dcd8142bc2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 19:00:32.7451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFmfhConyrAXpOqkWreVwcWkMdt7EeAdPzO05WcpE/uBcRrSIqdByi2RKsirv5LFGIQ8qMcDksrpO0EB5uHhAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10549

On Wed, Sep 18, 2024 at 02:21:17PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Set the status of the dsp node to "okay" and assign
> its reserved memory regions.

wrap at 75 chars.

Add dsp node and related reserved memory regions.

Frank

>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 27 ++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> index 62203eed6a6c..7ee69ce7b193 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> @@ -92,6 +92,27 @@ vdevbuffer: memory@90400000 {
>  			reg = <0 0x90400000 0 0x100000>;
>  			no-map;
>  		};
> +
> +		dsp_reserved: dsp@92400000 {
> +			reg = <0 0x92400000 0 0x1000000>;
> +			no-map;
> +		};
> +
> +		dsp_vdev0vring0: vdev0vring0@942f0000 {

'vdev0vring0' should be genernal name, such as 'memory'

> +			reg = <0 0x942f0000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		dsp_vdev0vring1: vdev0vring1@942f8000 {
> +			reg = <0 0x942f8000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		dsp_vdev0buffer: vdev0buffer@94300000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x94300000 0 0x100000>;
> +			no-map;
> +		};
>  	};
>
>  	lvds_backlight0: backlight-lvds0 {
> @@ -640,6 +661,12 @@ &sai7 {
>  	status = "okay";
>  };
>
> +&vpu_dsp {
> +	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
> +			<&dsp_vdev0vring1>, <&dsp_reserved>;
> +	status = "okay";
> +};
> +
>  &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_hog>;
> --
> 2.34.1
>

