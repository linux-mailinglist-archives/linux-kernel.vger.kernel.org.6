Return-Path: <linux-kernel+bounces-303609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1249610E7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4AEB2829B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DE81C6F40;
	Tue, 27 Aug 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vl6VrFdI"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013021.outbound.protection.outlook.com [52.101.67.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9312C1A072D;
	Tue, 27 Aug 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771637; cv=fail; b=sQO2vt9eHsHSqcml/ANNtI0mJ0M4DCJp8Z5vS/COaODJE6wP5+5fUfNRhrUA5KjxhCfRjQoS4BoP57S7rT/g/j8M7wzz6+a4SDCPRrRN1pPGKWGwTN4mR0srBCXOXxYwpX/nzPT2aATJLi+tJvoXEQHNN6cVBs5WHmrJ8iG6Dng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771637; c=relaxed/simple;
	bh=mPc3qxUsv2dNNCXqIvAg7tTM5iu5n/KHgJTGRBQiVHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FG1bUoKif3YEg0wod0VDgLYQEWJWtTHDmko5qaL9mt1YZqd9O3a6ayGs4SFT9zPE8OU7P2O8wK5MNgOAHl7OC4sRug5fs05JrOsaVWRHVxSpwrG7BYRQfpX2GUnkkIEZzsN1fHLNuF181n4ftOSZnCBCiQ3369VY6VF7dN0T1Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vl6VrFdI; arc=fail smtp.client-ip=52.101.67.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymW5mXYPd2heWZ9ruBMfON8bSsqC/38+3SJPlP1cm/tcHa5yhip7qFLXM78dM5vj+uFrTnL+0GklHnxTlR7gxyuV+8x8GFNedWqU2HcOHTkbmQSwXRPqNc94UeSrIfdE9dSJHZwPDw9bwQovyc4kl0wNi8mUdi1Qr8ogpm7piFmSMOyZFoknLti6Kls7jsjNMGLRQMv2nXUec8MZnBHWICAxGwECV0srdYN24nAWOI4RbdRLKlviJJiXjTEIiTEVWDBvBup/1GmcN0L7ruizqiEPzY1Zc5xKu04ebPK4G72qIcBy5nnyS7xvUSW3Lx2EZcvVGEsVm69AZNh99aWZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKb8YmcxJjOwcRZ77WU8hvwMrutzuWR2XnjzBi4CZUI=;
 b=N2GLQQnZ/LHVsKkHTMO3sNwhgjg5kRKT6wsKUidK5bgnXyU0ujzw0cXCmty4UKZeWA3mu/Tq9Q4HGbkitbN1BuYlCL7fUtyy8OfCgdijqUfAQTKqysGP80dULLH+Hb1nRC1lmG9nH6yjv/Y27LWjNwyD9v5ElX2u1ZfM1YWp4kTNw667/lx/KGnz8sY39agAuws9s4todDt2/iiXbAxWJqdoQPQPE3FtRY0ZRGX9Q3FVHruw0WmWZx6bLaUR+tigL8Kw5oDXfq3R0iPmSfwu3f0s9uqz1wG8fPdP44DJYZhgt5yNygmBWOIYUkZTsLqpKoYAkz1ERVJ+i6BzPHc4lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKb8YmcxJjOwcRZ77WU8hvwMrutzuWR2XnjzBi4CZUI=;
 b=Vl6VrFdI9WMJ84kZS8tmYaWAXtB2wNwIueJ+sz23o+IVph9AQaYMK/SDDEByKL6vb3xKBqynN8Nxr4h0O6BcYqoUO9e/T7i+F7Z/xyiHwpioCsRHtMEbw6uCFlLZwpjRBeiiCUeeJQLuxHtqwzCT6o/p+z2P6MMzeqETgnpxuCdAO4BkhtTdJtgwS71zt98IhhFWnkiCCp/JDPR7o5WlfFjQbhxXe/bngwUF4hyJI55PAvt59MiraWtebdrGhyIbwKBsM3diwf9ib+F4xc5G30UzpTNLOSW4u4LUBUimT2CMYsrCP4tR2UHDMJHWXypbluTjbEvYK2eoEAxZdD51UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 27 Aug
 2024 15:13:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 15:13:52 +0000
Date: Tue, 27 Aug 2024 11:13:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org,
	quic_bjorande@quicinc.com, geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
	arnd@arndb.de, nfraprado@collabora.com
Subject: Re: [PATCH 1/2] arm64: dts: imx93-11x11-evk: Add PWM backlight for
 "LVDS" connector
Message-ID: <Zs3tJzt7sdvK8yeu@lizhi-Precision-Tower-5810>
References: <20240827064717.2383292-1-victor.liu@nxp.com>
 <20240827064717.2383292-2-victor.liu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827064717.2383292-2-victor.liu@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:332::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: d629e5f3-186c-43dc-56cd-08dcc6aadc7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gMVbr5BM0B2rYtPUvDRgG7afyMY5ZCn4LRjASzKI41/+N5/agLnQyMpB+jw1?=
 =?us-ascii?Q?LTfXpW+tpl6Y6gsVnk13LJxlcCplv04zfzKVhI2n2YRdvDbGhcvEd/eJVI8X?=
 =?us-ascii?Q?orTM2DGwLHqrA2juqvwDQYMlJiskWyGMDxV2CHFBJZB1Z+sBgOALrhOUHlb/?=
 =?us-ascii?Q?aY8u308TUKxZjTN0gSqGJmtAuikdbicWsHuVoka4Lq8bPlUXTX+NAYUoe3oh?=
 =?us-ascii?Q?4KTDUF7hLJV2BjyFLeUGafI2YCzrUNegPF7sD1y1XLP4zd4yCy6714feklUV?=
 =?us-ascii?Q?iHrmHPK65uscu5xN5g0BzxfDPc0rO3IZubLWHUOuZgdmM2n2zs9fHOmWldNx?=
 =?us-ascii?Q?T0eOtyRVeskF7oPEQflvKO6q2nhjfRoNI07bzmveINEKbURnBOVsaZ0/5Bvn?=
 =?us-ascii?Q?M8LT6xW3g+mVMnGpP9O68695Mw1VeZJfxNkXgmEDv6Him6I1oH7keUfzA1Df?=
 =?us-ascii?Q?DsPUNV8RBEEH/vJy+fivBAZQXTgYX9ANOnSr6SNUdOEPRw5D2JMJqmQFiO8g?=
 =?us-ascii?Q?MwZ2UoqDglSsoDVkuuOkGsRuQ3scFJAJ4imr9LZ8rz2DE/fzUIp3xecjDYD9?=
 =?us-ascii?Q?h0zfeM7BTMOnAt1Gk90mQyDfO2hryaOxm3q4FrfUNnCpF95++Bs/TQnGL1IE?=
 =?us-ascii?Q?awIIOgrck87H91KxnyaN10y3QDMI3RPTt3XgxLueojoYj9HhTLWUkT+kp3kf?=
 =?us-ascii?Q?mCPsvy7smBhGMxlAy9jECh5EQMsXBrgwsn2W8RnpGi/AE8fFDPP3EyVFdd++?=
 =?us-ascii?Q?6As5zrQKLXOk7jRCt9U/ZAEdPz/Vf5mlwQUusllvYYHd/6ShPKj4bqngv6DL?=
 =?us-ascii?Q?OuwWHiXFU6Rx0TPhvvXY2lhYNPz2lZSJvgTC6E56dO2M99Ts1saEq9MrmdyQ?=
 =?us-ascii?Q?OMIpdW7QbJBCBKRAEWEmL58zAA07SM9AfpKxydUQIZ+o7qlEQhMAwzPytNsu?=
 =?us-ascii?Q?eb+6xEqSCrzt70EUg8z9Zu6v0OgS0lRcDwCv/lNIuByBBAQZi7rr1IYCweaT?=
 =?us-ascii?Q?WYTu0lyYrFcOUJbF1dpUy3OExotCgj9IAVEAPylSt8odYtZo8aBEJ9vy5kM1?=
 =?us-ascii?Q?PV5WCkvaOoXratkdUlOUTpUB8oGfWpEoMLXxCtLU7VaNSbssKGSgR/+Ka1C3?=
 =?us-ascii?Q?bGe423AYkJRc8Yhy75Q2OHBIetCz/LmsluAlCaF2F/e9nxCyC2D4imMq24Wq?=
 =?us-ascii?Q?STw7gauRY8R1/AW2BT2xxmu0WwiOPqmPxclTL18W7IWR2gIthBnABwrwwwVU?=
 =?us-ascii?Q?2OxivnvcKOeMM6ONAs5AAs8xgpDYnaA8pmZd7IO/7iuumK4t9VFQg6WyXknt?=
 =?us-ascii?Q?g6KBdFZY6sTkMybPSn/jKFUI/s5UG0eYwe8T4idBuJ63gn7itdpffukr+3HN?=
 =?us-ascii?Q?5buDJJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MF2lx1sZ7kQuUaB6fUWMBHCQHf0/ULAcfy534MQ7kPRIbc6EjDt5s5PslmL1?=
 =?us-ascii?Q?njrCy43N0olS8NTnbASaPmEINFtekIFm/1gNzCwSCajoTmqeYo3qKnBJuyz9?=
 =?us-ascii?Q?2AhnfnHRD0L3hUTMVzW4rJKFEwLFmu/SWHHG4xmfsOmmcgQSQ5UlAOQ/PR6v?=
 =?us-ascii?Q?4zeXbiD0f4lM6oDl6qp/FHhUsM4CqaikFzc/5U+5U3Z+7iZRYFupbUimJaWS?=
 =?us-ascii?Q?F6II8QfKdDCJAOseF+4FhjQJRlQN1rqq/v88+3XBCU8Stmw0GpaLxsi1Yuds?=
 =?us-ascii?Q?XJQJeGBiJNKgjEewwFxw0PVVc/5LrVnOK9doCR6aryKIpVF+JGc673VjPRcu?=
 =?us-ascii?Q?JMlOwW1C0uXk9p4StqvXYqsaCCLrkaLRFA/zfaP3DjhDUzPLiYUOprs6vwu+?=
 =?us-ascii?Q?hKGA3Uu5syAbLpJHJ+mPC1F4jsheHEPoEabluGZjIcMNe5Re+8s7Ev1nHN70?=
 =?us-ascii?Q?jQCQcULnKYI+/QNXHmhhqpKo3WHhhprQyrEMjUpaLH1H0FSwTtE9oQzU5Qv7?=
 =?us-ascii?Q?FwBEeoHv8cxP9KTids7d75yOyQB9TJESaH0zGbAFym2ZoIycD3WJELr6g527?=
 =?us-ascii?Q?k2N6Owib4r+JJrJ0bQkpyS0P0xHucWgCkyYSWRgjLD7h2OGLKBbtMYWqI5bX?=
 =?us-ascii?Q?ZKMHhsrHdNlS/48UP6nTfpe8IQ3rdRaMeR+d04GENXV4hUzEF5372xy4aqFM?=
 =?us-ascii?Q?jwL+vtzjrbVLgTReglDcFYVoVJVoZS7VYzi0a5NsqdrtRydxz3wnbx9w1a5y?=
 =?us-ascii?Q?7KoUFoaWz6hmYFxJx1iZcgSSKKKe70FJpiqfsOF0OOAtuSQWhouL8zJSafQ8?=
 =?us-ascii?Q?vKHPVyCpgLa54B695RiTgRUChBj7oWoiIOHyw+IHuKJEhuTuMjFUnS2XNnFz?=
 =?us-ascii?Q?bpfqvpo3ekWJekJ+z4apWRWCdkPPMARXQA8mME2rbnh6nlggf6VVVJr/mPAB?=
 =?us-ascii?Q?8nhS3Rkp9xWtARerX0LX5oaVTrrGj/E6/AKbW6A43oIHl0v8pmtEFyKQhGQ+?=
 =?us-ascii?Q?1DTUHiT5af4pmXlyBF6dPTbl9RvZJUUenMCnyv8dPITcPXYkJKVikKlTEyNr?=
 =?us-ascii?Q?N7rapAFefyRbZA3+O8nnpnwSC/vYAJCUXmeTwFpEI9JKNLJ9GdF0WKvECfYC?=
 =?us-ascii?Q?8+yBEki7FBWojBiKylP6RZ6CZMSFecHEgEdnSzAVUI04s1nZvvyV15tW91Cv?=
 =?us-ascii?Q?zE0wuz7tqbAf1vJcOVAHKGxT4+oRvva0qa4JC9EnzJeL2SsberRSqHZMjNwq?=
 =?us-ascii?Q?31TqsxKGbu8qutiOclKP+4wrfwwebDufqRUhvusLNtQyhtuX2GaURr8749bV?=
 =?us-ascii?Q?DXYFQy7+JIvKFohw6ByN1F9OyFMDF6lKbyqx3E8tkQxYElVaacIqJG/LSBYu?=
 =?us-ascii?Q?eQWvp1f5Y6vD56DrJ/LsWEI/ePB5LIC+1V1101Y6lpVvDwikWu7/zNdLbArH?=
 =?us-ascii?Q?gPYP1SFg6SodnX5oi1s4H0FrxHoGC56NGMtkT/x6oFfgnLsYPXkiZhRI85a3?=
 =?us-ascii?Q?5wzeR0coJGyTwvY+fGkLEc2SgOsLzynSUl3ayPN5JQzBG1PbhLpG+cQr1mfj?=
 =?us-ascii?Q?8svblXq/yIMKpZkNt1vpssHoRGC8OWl77VOygDUN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d629e5f3-186c-43dc-56cd-08dcc6aadc7d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:13:52.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lH0yJG2eU+cEnpNmjB+0sreogB/8O5LvEugOGbLZFBmqyS5+WufM/CV8nc6EOb4nYBMyb7+Y8VmEXJSXW+4ApQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8906

On Tue, Aug 27, 2024 at 02:47:16PM +0800, Liu Ying wrote:
> J702 on i.MX93 11x11 EVK base board is a 40-pin connector labelled
> "LVDS".  This connector supports PWM backlight with default 12V power
> supply and ADP5585 PWM controller.  Add support for the backlight.
>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> This patch is based on next-20240826.
>
>  .../boot/dts/freescale/imx93-11x11-evk.dts    | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index 60eb64761392..8d036b3962e9 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -62,6 +62,15 @@ vdevbuffer: vdevbuffer@a4020000 {
>
>  	};
>
> +	reg_vdd_12v: regulator-vdd-12v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDD_12V";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		gpio = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	reg_vref_1v8: regulator-adc-vref {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vref_1v8";
> @@ -81,6 +90,17 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  		enable-active-high;
>  	};
>
> +	backlight_lvds: backlight-lvds {
> +		compatible = "pwm-backlight";
> +		pwms = <&adp5585 0 100000 0>;
> +		brightness-levels = <0 100>;
> +		num-interpolated-steps = <100>;
> +		default-brightness-level = <100>;
> +		power-supply = <&reg_vdd_12v>;
> +		enable-gpios = <&adp5585 9 GPIO_ACTIVE_HIGH>;
> +		status = "disabled";
> +	};
> +
>  	bt_sco_codec: bt-sco-codec {
>  		compatible = "linux,bt-sco";
>  		#sound-dai-cells = <1>;
> @@ -302,6 +322,16 @@ ldo5: LDO5 {
>  			};
>  		};
>  	};
> +
> +	adp5585: io-expander@34 {
> +		compatible = "adi,adp5585-00", "adi,adp5585";
> +		reg = <0x34>;
> +		vdd-supply = <&buck4>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-reserved-ranges = <5 1>;
> +		#pwm-cells = <3>;
> +	};

This part will be conflict with
https://lore.kernel.org/imx/172476183829.3553281.6314012832354346473.robh@kernel.org/T/#m5e2189badf00653200421880c209312fc0aba7f3

Can I merge this to one set?

Frank

>  };
>
>  &lpi2c3 {
> --
> 2.34.1
>

