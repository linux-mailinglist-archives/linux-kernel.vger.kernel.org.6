Return-Path: <linux-kernel+bounces-361453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC13299A879
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6F2B22D30
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DCC195FCE;
	Fri, 11 Oct 2024 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mRfuMHfE"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987B18EFC1;
	Fri, 11 Oct 2024 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662184; cv=fail; b=bXA9cBCTSrSVaWaIYCgt77eHPgsY+ij3jJXM0zTwAbIXyNDw4QdinWYIfNT5guXfCSGPU23twRURVZOqfhR3RTNQodU/BcOQMckHQZTM/15N0DZcAWqSdvAfsDfiWsTwjkEvKZqG7l5dw0BV3wm151mrHI7AXZ+d/Ym9Hv92a7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662184; c=relaxed/simple;
	bh=QK/vnE3Wwd0Z3iOOajs1kYxN8z+R5nwAZOoKSw/dr84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nqND9zRharwSNQIWhn/kes99qNC3jb93gp3ivxzHr8mtmOO6zNnWZZNl/gzd8eFvI1zhI5PfwDyoipFhW7ixHBcdv7DE9XD2L/jshOvz7yJ0Mfc+313CA4tvhqofMdHGA/danB0kljFK9lCJIWV4reKvVdxRQsQm//2H/eDUCTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mRfuMHfE; arc=fail smtp.client-ip=40.107.104.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWPqpywI52W1HdIwhx2n1y6WExNi7BERK0zEsiuRZP70GVqZHpQJX7XwDs2/Koksj3l9kjO4z2v5bRZHfvEhdhJt4hoL9GU1Am5GZFnJHjp27ISIYJfVnzgWHfPNM/+PwwglfitKvnLS4NEvtkd+lhmC5X8HaIcM8bqRN2xKW7aWTiLYdPoEmCptRHDXG4+r5bwSnegiEFloPOQUUZ2qqlg5zMxML3CrAKlW+6uyyJdKsnc1+F3bwo6HndunH2o0WbvPQEXITyxERV2e+9QBIoi7a5kltO2NZc68ZkT47VK4Aewxd6hlI1gFBn2eJYkQbR8dR7FgFHJfomdNxGVPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8tziHtJ455JInMW0xLE6BIwZ4GM2V5HjYCHZs0kgPA=;
 b=D4ynxkvg2J9ohGMWx/FUVhFlRh8M1FRyYUCIb7CZVDiT6dmUnq6c/4pBRHR1XNzvuqaAv+SehuY1YkSzHObb3rSzRAvTguk4UARP8tzcrc674B7nBvUtvLSG9Zu+B7IPhW98RNlyjHsyVZsw4KqO1/h7qZz+RRfYhMWMs9wmhNgYiR25i0tLh2Kan9tjVsGPa1MTcoW6KyMAWDWVmO6ASnIuuWiIt8xkCZUKQMxTEIlIvs0tS1++jCzcWsZbS7A8t0aedQiW08x9vnIoHFi+Zgmp4TqOeuypMp8lY33L8XbZR8jraICLecowO/PNSoj25dSWZ0f1w+yVEm9hKITZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8tziHtJ455JInMW0xLE6BIwZ4GM2V5HjYCHZs0kgPA=;
 b=mRfuMHfEkShOlemrIlfM+DiMOalkhSWT3fD47awu9OKpX2apWdlcpcp88vgbVFhzbA9kKPykh2PI49RSqH1pk+aDK4yFnypmeGSywvtXPoB1o1s2uJ3JwPpwrifbhb4hwnb6B5kLD68Gs+3BVqcuWs03jfFxkL4yVhbbdJcJHXd2MBiZ8chpYn4s7uphhQK6ppQ9cGrZ126VF0tnauCBo9a4XUHfkwaprw7E+miMXNgJmF3WVFg87iucyJEL8TEh5TlS/5zkECB1QOdWGtleFM9uUXf56mUJevaJaqLmiYRRauKj33UzGkoTB08v/79WvEEEanWQlKiARvGN3To2gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7434.eurprd04.prod.outlook.com (2603:10a6:102:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 15:56:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 15:56:20 +0000
Date: Fri, 11 Oct 2024 11:56:11 -0400
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
Subject: Re: [PATCH v3 6/6] arm64: dts: imx8qm-mek: enable dsp node for rproc
 usage
Message-ID: <ZwlKm/Z3wtj1xa5S@lizhi-Precision-Tower-5810>
References: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
 <20241011150439.4027-7-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011150439.4027-7-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: BY3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:254::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a68d27-0289-4590-8843-08dcea0d3f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CrDCwdMmWtnwx6fYVclaT9jm0ABgnc8ZHVr0Po8k/378cbb8laMqlTbWJ8R5?=
 =?us-ascii?Q?dctzNnPj4NyMcRkUhdq9s7IsL2zpFNhubjvrKkj5pYRiIFNwMhX+FoThus4F?=
 =?us-ascii?Q?aA5z8xkB4dsFmyXihZBtFgHMjKhmHpbi/C0vQhpORoxQyHqwtTdFax0WgBQ+?=
 =?us-ascii?Q?gIawoaqKfiO3ig+3QW2Lli7Cw8bpVdMMNoab3YlLfBJXSyhR2hp1J/c0QITh?=
 =?us-ascii?Q?4RKd0NVCZXaSwMzNbKVxPXsouOml7kAHtsPxTcrbBXKL5hXpJydfAIA275aK?=
 =?us-ascii?Q?qEeRh6tNaA71jNSQ/G8fePr5Qc3lmSSjSZZYQkE5GHlz2uIO/iewDsI/sf+W?=
 =?us-ascii?Q?iQIe9/151w9ViHJSTNGZI81uobIJcIg0WSXDIl58+UCjroL7sWB4FzlpZ/Uh?=
 =?us-ascii?Q?71wcvYcQG8AgKkdyfBb1mMHt8Pv385TEO197YiipKlFWx/1WwXjG0V7zi/Iq?=
 =?us-ascii?Q?ksWuqhCVN+draDU3m+y+IbcbL0zysh+mD+wOmqRmlK82R4/hW0PLDq3i/VcF?=
 =?us-ascii?Q?EJZdLkcg/Mochm8rKkG5QmEqueAWRFJhc+JH5wBc4943zyc56xpvxkyB0qGz?=
 =?us-ascii?Q?Qja3CwhR6x4D48OdXr/B4nMqm22mH3pXgcuFavM2BzhDWdxsTQtdXts8dZSa?=
 =?us-ascii?Q?VNwcf1V9wevV1QAuzmg4EALRXgLH95IBCCbTRgBEv4QOlgyo+2v7X2aJBulb?=
 =?us-ascii?Q?KCLCZGNQp7QWINRjh+GJKZV9O/Vi8ZmXteFYr6YQS7Fp7CxlXhI+fz1yCFKK?=
 =?us-ascii?Q?a8U277SGPHALe7SNKXRzpmu1BE2JDV+1KixBRTlBDiWnqRdNrf3eqbbj2uMO?=
 =?us-ascii?Q?LkAyMstFo5cu12CYwD9T1V2x3tEcthIBYNTMAYug/eRtneeVYQIEbaSFxrg3?=
 =?us-ascii?Q?+ZGrtSP1tFxLTYAkhC98v/zFguNptCRK8zzAfuPKn9EvDh/RsHQahnrimLl5?=
 =?us-ascii?Q?G/Lp5hVpKK3/JptfgSHmGRGaTaAQfbPSYzWKpT8HMEQrgu481MUWxSC06VP+?=
 =?us-ascii?Q?2B6osFda/GwRk9EHzQ4SB0ILXapw0M3Xml3fDxjygm26mx4kJf6zWrSF24o6?=
 =?us-ascii?Q?KiUzDjvMNyX8kfB38Jg1LXN5HSHOfxCLqpI/UD9dxJhgBbFXJmI30fDbz2I6?=
 =?us-ascii?Q?Zl842mCrjdKLRQK3eCbqE3kg7BwAB7nbmFnX18Qn92JIHzqiDTa94OKfvaUo?=
 =?us-ascii?Q?3RkZR9CCGRh0U34EA6kGnhoNPjn6YBv+reW69X0QpkQl66pdmdIfT5pTk5WK?=
 =?us-ascii?Q?/kJaBrmGPqQ6by8PY87dFeXvyHkTKecH5Eh7w+xTmTCylxop2UDXxnkJSVt/?=
 =?us-ascii?Q?/4CefNxQFarh5IJGCyiiZLR9M5vJho5y9hyZlazqsT2Z/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?99xAdTfJMErGFg1x2IHV28znux0VvpddxZylNPEzWPAtZ/j5xfaTFN7LxaMS?=
 =?us-ascii?Q?av6ITSd9oC6clcRa++jFnyNh1EbA7VwTJUO/6NuytKnkGPbUIQha87cMsZtW?=
 =?us-ascii?Q?7FQVVzCdlib/ZCSWBk1OgGt1n1krFa8o7JrJtAJcH+aA1xhOg9JUc5NgT2jq?=
 =?us-ascii?Q?QLetUry/90UAwlPZPiOwJ/0dcZCtqgbfKUUmH5y2H3SOYI5N2gitFCaGRjzH?=
 =?us-ascii?Q?pbPDao0H0c/Rhp00/xujpnN18+8EAcRFEP9M0efWDeQvmWHZS7nm45kMaUyx?=
 =?us-ascii?Q?uiZyQRzLivizL2wu+jB6xZ94Z5LC3/kQy41O3lTxqwX2lSsIpwSMwnFgR2Ii?=
 =?us-ascii?Q?tPg8zW5crW6v9erYgzIpbOajHrXgotrBo+ZkykBoJ8NQzwaypRaSlPJjkzp3?=
 =?us-ascii?Q?Pu+QtoiWlSJQdk6RAVOrIG5tr2VFC3tGEZn2Mm70Iv0nI1FVd5LmjcNCAHi7?=
 =?us-ascii?Q?2teeskv3Ox/IgAh9aBsan4qCLYcaxDq1iwc8ilG/unKhYhYwviiZtYufw3Yc?=
 =?us-ascii?Q?Rb+cqSERywHPnuzyWJOrV8VydcBIkf5SuqSTZlgkEQ0D/Yj70R3LEbqEERIX?=
 =?us-ascii?Q?TNJID10dp6pa2oeG/+GKmScvRKsdzCPfnXGMD0DWz+cWuJAP4G8F81Ue6ZLt?=
 =?us-ascii?Q?E/4eDxW8GUzUo9gtPPrEuQ0/ITITWQvR276k9N7bQaGhghUFlRnrj9tsGxaE?=
 =?us-ascii?Q?Hu630HPv2T8/aZ/d28fzyKgy/ZniCjZOmRpWAcksG9vfkdzHLXrtzjAA0dSn?=
 =?us-ascii?Q?WcFOt4TkZBDP8WNYrj3/lVXckx/tZMq2d9cNTvy5B9WX0E6lzzdJpFI4IW1m?=
 =?us-ascii?Q?Fayjcq7KA1uAXEdCbvuCk21iZFeAQJuBaZCQTTny5F4UCEOyb+uRWFb13aiX?=
 =?us-ascii?Q?tvk3s8HhNgryY8JQbAeYrSc4XQB8pSISaLvyAy6J+s0tMi8mq7vFhlRmsF+O?=
 =?us-ascii?Q?3vVz54Kg33ExweXq+pH/YOWp5ZYHhM5Fq81cwXWzdq0va8ObB7QLSRS+dj3I?=
 =?us-ascii?Q?7She8BQV+dcNf6xAG+gGzqNb3Y7/X0qtU/IxLhkXvBKK1HwIfRt5yMXMW62g?=
 =?us-ascii?Q?7gVULVlLYy8nT1xAa1H2WHB+4kQWfRdY1mszOiDf4JwII5DR9mlP/tZCHWA0?=
 =?us-ascii?Q?7BAKaUt/GrHSz1CF2rwAGhbTAqHbkRVmgl/2SU8/tBg53XhloJ0W9BCZ2Mnk?=
 =?us-ascii?Q?QE7Hi4Vn/w7u5RmftrTEVBDO1/BAK7NJCFNNGN4rNVVq6oSvIjgaR1pFTxph?=
 =?us-ascii?Q?TCuk5JIeX0bOUcbXQrNZ5dfs9naoElrm9r1BcpCimn6eNVNFoD1ZNQk510Ic?=
 =?us-ascii?Q?aMnCa5j5Aca2FUZFvChAYsCpG/UlAIz8lSjEne+s06GN+TYVrLThxnrstv8t?=
 =?us-ascii?Q?kJqBZfAXTT0RVdbzZQiEuU3F0W+TfK2RgGKXyefR1IAb0cXLTntUlTkNqNI9?=
 =?us-ascii?Q?8A6dR8Y+wMlMKreV9a3Ex4dw1i66QpS/trQUMlRpnqGWqQ8IJe/FydAyDhDL?=
 =?us-ascii?Q?CvcU4ElIiyKcDcRDnJtPHvPMSONaRklSgO0ioMsDWQ+lrByN1beVDOqizVu5?=
 =?us-ascii?Q?ueA+XTpx/xbs6qCCGsVdkCK1n8lJcLpe0QP8Kv4B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a68d27-0289-4590-8843-08dcea0d3f8a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:56:20.4565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43UTAloJs0qE4+Sxw8NCVR7qYMe7ZDoPiDPM9zwBjLy+GeyeX1PZKhHuTvRT2vilG9uv4ikPljoum9q1phM8gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7434

On Fri, Oct 11, 2024 at 11:04:39AM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Set the status of the dsp node to "okay" and assign and add
> its reserved memory regions.

nit: wrap to 75 chars.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 27 ++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> index 62203eed6a6c..d51da3b6b3aa 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> @@ -92,6 +92,27 @@ vdevbuffer: memory@90400000 {
>  			reg = <0 0x90400000 0 0x100000>;
>  			no-map;
>  		};
> +
> +		dsp_reserved: memory@92400000 {
> +			reg = <0 0x92400000 0 0x1000000>;
> +			no-map;
> +		};
> +
> +		dsp_vdev0vring0: memory@942f0000 {
> +			reg = <0 0x942f0000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		dsp_vdev0vring1: memory@942f8000 {
> +			reg = <0 0x942f8000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		dsp_vdev0buffer: memory@94300000 {
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

