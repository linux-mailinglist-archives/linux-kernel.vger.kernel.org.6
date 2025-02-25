Return-Path: <linux-kernel+bounces-532326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AA1A44B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC290420F31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1853020DD40;
	Tue, 25 Feb 2025 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PcfCCpzJ"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6C1DFD89;
	Tue, 25 Feb 2025 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512441; cv=fail; b=SGpMU/FCJ4VFHpFdOfsa/0ePthkvTGYA56f4uwWNp8VI0xHOTQ0pkiHX+u17zv66KbFI07ayNZHClvR0Atp/MF4Clqqnye2vqclJW0zcJbvq53fOM6qiwZs+GPYnYUZ/x0h9SKt3NfWFWfTm8ZMokRMujn9CuL5ZavUiwd6t93A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512441; c=relaxed/simple;
	bh=2Pai41WFFju9eWgN86WADHzM9IQqaGN9IE1IFcDSUG8=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HihQg+PqjrNDY/uJMNFrqyU56ohfMsdLbvdEKyTbouI9LhbcjNVtC3jOEhH4FKxgdOATM28rB2Op/L/5g6DmcLcVy7yRyoFiNnuDoplit10DF74jsPXO31xoRrV29OrIrY0BpuzilpVWz5mayRtw6cpoR9ncX+ghpvEMeH7jdb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PcfCCpzJ; arc=fail smtp.client-ip=40.107.104.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gz1Qs6uy5E4O5WLZ6ZWz5EP8UHjCh+CEltraUeY5wKNDcuSDROIkMrk1TQhg/10x7IiBIpDHnb+EVtoP/8b+QEujxBXZl5xAuWJgJ9Egu0VXBZ2TUJZl7dWDQ8J/TVEH6sst4te63exkhpgTwkT20RoSLcfRaP4As6Wd24VsvGyqDwoe13ZNQYSlLzZ5M89/PO0PqViRocm2kUENx3EwuZ9NHxJ6GUTHAQvm14EhdhrvBR80km5ik9fX1OnkMhXppi8/THFqNXMURfR13o3Twx3lS+fsh6FPS0xfIX89btgTEh0cesa02CiWtnBNjq7/FNZXPv+Lrfg2P5FQ5CAKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0HedO2R5roLvvNgA16NYkrRBnfqBV+soef9P/o1tNc=;
 b=brxC/1i64m+m8DoEGRVqIUYOK1hHUKxvQvGC+a1VksjAOMZ4tNyjeqRl6CAe99OXQ7v43352+mtx538DkGePs/qD8JsB+1Rigbujz74bOvKz/9mtny0JZrNuNw7w734y4J8jg6MikZ+ZDyhOXAblowE1ZlVj/9ARa3kVNWRN0chkmgM578hsBS7MJ/YNuWy11P4c/DqFB0qrNrbr7FBg+OsgvrK7bZTXz3sI0th+eiGhWm88Q7TEjcifa2d/FKrUGCE5M/izudZ0n9O0UfQOuGH8eo5nF9ODjbPp2XzfbNS74kD/Ygw+BudJf/A2Votw8ZpJYWDDiXjaF43DuOapsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0HedO2R5roLvvNgA16NYkrRBnfqBV+soef9P/o1tNc=;
 b=PcfCCpzJ0ugo9VQHc+SQv5bJVoBB6SuXMNMnRuYtFb3vNMgVR2dm53NcgFtPoorw956dOYecvgY8UpbQRH+//JVJet1wKGL0V76kuWbjgz0SZlmI28PsFGa/Lu9dNToq5aPcWllB/PTNWI2Qc+0CkL1fX+gwqvQBWTKjFCIpyII584QhDjnFAo1tdJaUJaL6nBjfBXViqaoV62jKNqfQ65Y05P6mTimm/a6FddZR1hJD6uCU1igaWxD1NpscB7LEJjdMJ1LNv+0XUfjPtgeX5LcC9LxUQpWFVyPv7zWg6YvWF9W4foX0f9vev6VJFyjiObevcH3UoMAlryYpZmck+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8347.eurprd04.prod.outlook.com (2603:10a6:10:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 19:40:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 19:40:36 +0000
Date: Tue, 25 Feb 2025 14:40:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] arm64: dts: imx93: Add the 'fsl,ext-reset-output'
 property for wdog3
Message-ID: <Z74crTILjh2LeR3e@lizhi-Precision-Tower-5810>
References: <20250225192557.2914684-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225192557.2914684-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca6c461-0e7c-4de3-367c-08dd55d44694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BdwF75onKXa8BUdicjSPJxRZ0AWmvFh8Pj5dccLK4WNyZiuCFz1ek4ISuOw5?=
 =?us-ascii?Q?mFX6IakZc5/mIV59CsuBdobSdySzetGu30Wb5o12YPpXXf7FcJaiJX4G56tm?=
 =?us-ascii?Q?G1ekicZjKqsoeFYU804086AeU/xJL9Zfz0tg2UmjJJkaxxwAKUI97hsBRrRL?=
 =?us-ascii?Q?PFPgs+MuY7DAyEeHJV8Btta7RZgHeP+B4iyt7XUirq+ULDeSPiODwLIGVL2m?=
 =?us-ascii?Q?o00ulQrhqMZ/LfrZFk2FhFGLeybS81GDUS4kTeikmVy2JQgdL4HNbiDWNVSr?=
 =?us-ascii?Q?AL/mwg+GfhydBJM2OXXrGEI6wbY19UVxcCo7U5XcDB+uBJjsH3ss/g1YIN8y?=
 =?us-ascii?Q?28zLhKkEoh/aiGghOoEG5VpSnqxSc1atlTRV7cOdxtJO4Lx1pSODTpGdks7M?=
 =?us-ascii?Q?xPwCf/QH2n8tOOMzI5AKaatj0ap0mzOqNBiGKVcOIGWreiSvXDEyRh9tKXKN?=
 =?us-ascii?Q?0/pWRDBtS4DFNpJRHTpai/xHOc8MsdvrZahpCHySSYERNxlY0PrHu9kZsqel?=
 =?us-ascii?Q?4dMQNXfLunOWhUwMKkqP39PdC7z8tSPgif/6bZuHKHD+Cj3ODSshrAVSmDBG?=
 =?us-ascii?Q?Yfor0fT358FEWfv1xMEXrsB0eJmKcLwApOABfTDRNE7up8q5Xv8BoY9S9MUV?=
 =?us-ascii?Q?8brN0YC58Q+IUVF7XarrHaZjVklNCA6Q91uWIxjLAgndZ2q8OzL0cum+SyWM?=
 =?us-ascii?Q?rSMV4jmZxCDqlO1ry7OQRoLU0fc//K4bIEo7SPtOyuVCJ4ylB6Du1IWidZJQ?=
 =?us-ascii?Q?usgLyiLx07r28ZHYXA3/N1DfYYKLR4sLlgp+bh3JQw3I4/OsvNjj4bZ+ZHvr?=
 =?us-ascii?Q?XGtQyOHA7ZZxk7gwh+ZQAVUMvvfDW6Cy64lgFNaycIRVLcpnLz9KTxl/pIRm?=
 =?us-ascii?Q?YNyvol1BnvR6LkWYsqG7OH79GAjlHAT+vhMcaiKDMVrPc15cP4kwSJZbXl+1?=
 =?us-ascii?Q?/MND1+VAyY3lWii4BgiQuZ5UanYnG1GmJZUWBpd0WBNHPQgtvCLYWPdsFNkM?=
 =?us-ascii?Q?s8vR+VbmwsTLwx3rnPvUl4hwonvOwrz4dedWhM5HVs61Jbg90N+uEg8f5tIM?=
 =?us-ascii?Q?VuRNa84ArJYwJbsA6OVb6yuUD36OdTWf5WpHQV89IyPXAZ0KVOEn97se4ykj?=
 =?us-ascii?Q?lBRO/LnxQFdWp/8vJKHei3qQLYHG5leThaB0EljPD7imuomooUKIxa8EKcyc?=
 =?us-ascii?Q?TIv1PUpPGQjtoJrWgiuohsluN+jlv3wYWs0PU0ix4g4oJRnfJI6dEFuaKJ8k?=
 =?us-ascii?Q?pdNCtZCovtM7x965Ns0FJUJ3lc28b/v/DWrRsSsu/SbdQ0HyKX9h7QEr0R6e?=
 =?us-ascii?Q?ymSY65Kco+K9jhyDjtc6+UiDOzcrSeR2gnFZ4KsRyUbcPOJ2c6+cYUXR7Nf1?=
 =?us-ascii?Q?pY1nJPUDu8ZYDCbi8ip+lQB5LHBGTuT8NcvBsEMuQJs/jiY3DXOC2TBvBU5n?=
 =?us-ascii?Q?SZZX4z0l0bSHWvJ8JGSwMd2tBDQkJmyFyIHA+ejbhdsHbRiLaAQE9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mDhLUcEht/0bikqiGayor3GI6+K/k7ljbwm3JDf8WGTP1KfmZ6Jeghu2Opag?=
 =?us-ascii?Q?Mb9RVou1VPFJ3D+x1zUHnt2fraB+aO0m6Z4/t9JyR9rNjSSCRxzx0a+Wufs5?=
 =?us-ascii?Q?ibprHq5/0ZEAvOV8hUNq/oJAoHekse4omb96PANvcA8QyozbCAZ9iELLelwF?=
 =?us-ascii?Q?qNeSpfyafOY9rDntKjkXrcpitKh19eTd6Sem4+k3hsaGQ4mgm3S06Z9+tixd?=
 =?us-ascii?Q?mAYdhgSgnCM0mAuiAdCb9RKS+oZJd6CKOMPqifJCE9Ip4ghQIrnAbU0Uudsa?=
 =?us-ascii?Q?ByUAX4PPtP+1Hf2AHPYpVTVLMDM1IHRpvrZiADe2tyEkZlOc670igO3PjPzF?=
 =?us-ascii?Q?BYfpEXNy1oCWgv3j+iYYGzNyponGi+0LDAcJQjvEupDpVfuuM0S6tKVs/tAK?=
 =?us-ascii?Q?Hstcvglvua8M/NcNRob1OcBCbndHu9uU8oxGjazqxTIl0f6zvrIuzttMAr2G?=
 =?us-ascii?Q?yZGgDcfs3eX+RqBCXPxfjxVTl7qZaXlwwzGKn+k4FFi9fEGYO89hA9D4AdCa?=
 =?us-ascii?Q?QgqxbI3DlE7vLfNziSWr5dOKY6g0dM4lh3/YnEGZ787NI2j5W4ol8sQzd1LU?=
 =?us-ascii?Q?OoPjDbPkIvZv/cO2RhTtNf/uxNI1h+oSVxquH+gT6vnc/Sd4uhGrERLCVwmE?=
 =?us-ascii?Q?ofQWhbF7JpvyUaxMcigUf960SNY2/yUHwEmEtqC0E8FyWj1NZDZSH8SHbY/7?=
 =?us-ascii?Q?z9847MXP+hul2axnMV8dldsgd7cJEyJR0V0l/MWXpeuFw5o7Hafl5q8noBm6?=
 =?us-ascii?Q?NzU1qxslOJOFqEsOj0zsztt25dtw2ybMzowhCw5cK2R7VG9DGgyb1J7AREW2?=
 =?us-ascii?Q?WvOu/znC6aalwNiwWr99VfchZDAclH/eFzI4LB1ufIvePDf+JfxumxNPm950?=
 =?us-ascii?Q?ImDll7oKHE0V8hq3kgQrdUsK8Nd7TkhwjttMlt2Tdjj8z0f3LLEHUbkwxUV4?=
 =?us-ascii?Q?2tEEXsfRa+N/3J5GZwucTc4VUMOSo1BIyVrniToKldD1hxydqBq5WENhHIWe?=
 =?us-ascii?Q?80dv17L7jzyVM379bSV1U0blKvK9bRz/7xIkQaKnv1+PeDMsWCYrTPLb2ZoC?=
 =?us-ascii?Q?30kYRgil0PwXzpT947MWCwbDRjrQC4Q/BN/U0VW9f1Vfsi5INs4OIF1yynO3?=
 =?us-ascii?Q?imeVASwbNHLV217i1EfW1PLS8+BqQplIr6ate5uCtsP94j1hnCv6ySF/pPuL?=
 =?us-ascii?Q?B68e3S1NTmz8NfUtRZuH+ORtZm9oZufFsu/FlicxmG4YFbGT7qyqyL9BSNPw?=
 =?us-ascii?Q?QrbNVXJAS2X2hIVy94Vrv9LAUSDm4mADHv04PK4sDpHy3AsiQOzTtQnRkCYA?=
 =?us-ascii?Q?DwV0z0LAJ/e4dqBHdOae0XVAM3AovrIDoaxfQ5VTK7jpVpcMa+nE7198IhKt?=
 =?us-ascii?Q?Q5GhVvjMO3dIjgOfXia5Lnw5xaQtn5+pLil9G9Yj5k0kGPTF5euanPiDTgSe?=
 =?us-ascii?Q?DripSvRpKdjFCG/O/4c2uyjZKBYs6UYD5MrxAsNpZgkvS8WIp+8MtCTTr6lG?=
 =?us-ascii?Q?GZjlxekpLhVE0y2XCmPWSXwPOEqnbKN8vbPIX2qt29RqzXt9A8V2ezRq3GOW?=
 =?us-ascii?Q?B6kTx1F9jOQNhNvDU+cc4G8i8qHoj9S30o5RyVYH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca6c461-0e7c-4de3-367c-08dd55d44694
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 19:40:36.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxIHC4mXZEdANs+ugZkxvGAcSPAMKi1jrxScPz97ZfRwe/KZRgxHX5Mg9afvWuSJcqrpeJ0WHhD0RHRIwg74Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8347

On Tue, Feb 25, 2025 at 02:25:56PM -0500, Frank Li wrote:
> From: Jacky Bai <ping.bai@nxp.com>
>
> Add 'fsl,ext-reset-output' property for wdog3 to let it to trigger
> external reset through wdog_any pin.

Shawn:

	Please forget this patch. It should be set at board level dts file.

Frank

>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 64cd0776b43d3..ddfd57cedff73 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -692,6 +692,7 @@ wdog3: watchdog@42490000 {
>  				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX93_CLK_WDOG3_GATE>;
>  				timeout-sec = <40>;
> +				fsl,ext-reset-output;
>  				status = "disabled";
>  			};
>
> --
> 2.34.1
>

