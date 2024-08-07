Return-Path: <linux-kernel+bounces-278052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 355F794AA21
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CC2283928
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248527BAE3;
	Wed,  7 Aug 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RiTC6Jn7"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222601DFFC;
	Wed,  7 Aug 2024 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041013; cv=fail; b=gHP/zRc0rvRZLal8LqH6E4tA349XRlmB4FNzGU3SzUUfUcMgESODgZrkj53jBwPrW0ZdAHdLC7BqwOnPOmoLS36Rs+3EW6yi/6fH/xuiErUTju4DkRnWIcdmo4yHc1DBdQjtrC0itF/eqGW2nuSBQwBAYmsZLRLb8vPl5dgrH9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041013; c=relaxed/simple;
	bh=7laDUYW4cMsjBfa1LH+iLgdbRUrMl/imrqmzyeeBaUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P+Tz73GU8SlbMYehIRJNboHJrt25svuEOLJ98X/72LydZHxnTg3KbWEF1QLiZ6392JGoD/olVGK8ni1F6LL6m152QaSG49gEk6rzH80Samz5tStbm9Jcq+AvvQy/Cv3by9wYWTCpCzc+UYUMNuhMUTOjb6j6j6KQzv4JMdZ5vBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RiTC6Jn7; arc=fail smtp.client-ip=40.107.22.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omGbU/9Bz8BKOFMrp9SKGqpyc6DzH+OwgbAQLKRmzUSz91ypVQpuRBl0+8qdE/5aFNc81JiFwIMy6n4zpmayAFCLIkiqBYbOWQLSDTfRAUI3BXS8oQ0WbAURIRlW97ePaHHdB0u18FDnz3hEUGcLHaqBN++PKaq5wBRYniPpnwjOP60c6zEADnpRD+Dy51AKEQKHmW2aK9wu3eh5pI51MPZ1PnvIq7wk81l32VlE5cPNUGNxHCYdWC94/2o5Xv/ayMOim7kt0XcfRgQSe1L7Ud5jLRktRqL6A4Eww7N/yVOa5X3PneI9J778YSurwiCZvVeUtLD96tOl3BiK9Ug5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZD1cmYczIpl4fB1W33zi5n5HvGkrpKBcwsWRpqfrYI=;
 b=Uit39vHDV0B5u8+RB4FJVyw/0qb0vPNmaElOH21kLMeXrjgVkCLoTjSoVGdMyBSl6ZwOy/QJR9PK/kqMvxPe0kS9gBvT9vtQQA08j5Yfxy1tYDzl1GpSjvjzDsNmDgj3Avogwbb1jqYHHPfCrIOkkEyaITinlPhxbUtmQ1XljqlvCP0+ZWwTXa0IuPe2M3sy3ToZghD6rOrsB4zRte6uk3KMkVlPe8mApnJ8FaF6Xfcjhg2Ev+29u4li+YRZDGkOtsRV6f7CUVL+E8MlPCylKxu2RcPtdrR5sP+1rjao/A9Pxb/R2tBpcDVyf1VMRajJDJqriWeYtnt+JT6rwRXMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZD1cmYczIpl4fB1W33zi5n5HvGkrpKBcwsWRpqfrYI=;
 b=RiTC6Jn7ADCLu09ZaYHD5IPqiXjjp6tMhHFYPG1ID0EYMaLaS6khxiWS2ag1EWzVSLLt3qNdRZl2Xe1oRiE5zcn9zvSl85iQYvyZo1WApb9r4WcQB2uVmR+zS/ivDtTaY1txuhpoEDUlV9EncxOJPCF9eaIixQixyfYl6T679e8ooAX+breO4YdeQ5rBiFo2euzQ0A9fNLsAvM3DPAbBUgdk69OHy8MN7n5FEoIBN5VmfzsvPiXMBPW8nl5r+f5epC2vLPWbPuPnqSy+m70VZ1UaEYwfdMe/2x3m/txdcEwt3t4ltzx/rVvOvSUMoI1UVKr0DDbly5ev2mZjQrJs4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9477.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 14:30:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 14:30:07 +0000
Date: Wed, 7 Aug 2024 10:30:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH 3/3] arm64: dts: layerscape: move dwc3 usb under glue
 layer node
Message-ID: <ZrOE6Kly4cz7LDfz@lizhi-Precision-Tower-5810>
References: <20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com>
 <20240710-ls-dwc-v1-3-62f8cbed31d7@nxp.com>
 <20240711213846.GA3049961-robh@kernel.org>
 <ZqkLT/2myU7S4uYu@lizhi-Precision-Tower-5810>
 <20240807004105.pea4z7oobw7n3qy6@synopsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807004105.pea4z7oobw7n3qy6@synopsys.com>
X-ClientProxiedBy: BYAPR06CA0062.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9477:EE_
X-MS-Office365-Filtering-Correlation-Id: e567e149-f4ec-4c6a-86f2-08dcb6ed6fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rO39zDubVP5Et59HocZ5HgkXnEFCwVn7SOBA5XbglqP6pIIAFkZsGU8PtfBw?=
 =?us-ascii?Q?i4B4pK+vqlrWYmdNhu1Pf1htEtSL7GfP1DsK2HPFoOPI37qctRAHpYzFX/6R?=
 =?us-ascii?Q?9hyjski5w3kmB3NeOB4wluV5t7RaETDb30kB0NFYg9r1eLJpnUmXZMiRK2E1?=
 =?us-ascii?Q?kYTrgwihCnADt/ItrlwbAo6oTBMTufFGGdZwoGIDQuf1yEp2YWlbwMneD6//?=
 =?us-ascii?Q?0FoHayPDrvV6C4kJkZqmsPvz7cXfi5F2Cs2qnuGoVP4/fH9ygNK2r1Dfu+ZW?=
 =?us-ascii?Q?VRsR+3j8AIodn+VQHiWDzX+VGOKDTW7rIUY+C6wUkTHfI9vHpmZyujJ64dvC?=
 =?us-ascii?Q?wCFUHMO1bW8358/0SypYX/6duKoNFp8kRaeh2D4DOVZG6CU8yKfb4oqZnWyx?=
 =?us-ascii?Q?G3n5B9NnR6Nb9+8cNNuEQRQsp2nRrms1INgkP/ZJLDoh2lN6UNpNMZ9ijxot?=
 =?us-ascii?Q?VqyE+mvwaLZ43iZSHMsPa2JSseELZKR9yUp66sXDZs76sk7z9uf2RqDjxt1Y?=
 =?us-ascii?Q?XSUf0rlMHf2qwQkLM/IpkXPbtz0SFyobr2X5+0kamQBo5Q4BS2UYNIf5t3sc?=
 =?us-ascii?Q?7KKOmgBK8xYWw6LfIgi2WOP0RnSRTIzhoJselOVGWpExOTPll/Z4cNclYXJP?=
 =?us-ascii?Q?pY8AUouY0lgpgjUwXy73I06bv51FA46l/6LJDqpRWkHrnMVnd3Yz+vvLObQx?=
 =?us-ascii?Q?3DkjDhEwCMQbelZEuf4p3jS7CpnxEBkt50g6t+aRNYO8U0+F8dmnMTc7Xhf0?=
 =?us-ascii?Q?vE0x+9SM0jXVLaV8cWHxX0ztlR4Un5B4Q8KZJemdCTrHbijc41wB9Hjl8YIt?=
 =?us-ascii?Q?P4oy5y9EoJWCmlP9QG1LShw32HIMxfGDQgee7aQrQhbCXX5jbFN7etaoJxsu?=
 =?us-ascii?Q?TRm0bjz/ME5I180Dg+Mc6dFyUeFa6W6xZlOSGj460Ho5rZSBlrDA8ilgxmnZ?=
 =?us-ascii?Q?Kut6+h7gErQKmYNSWeSPVKQV32bR2Sbl8f+23WSZ4NiFG5sxJOZBjwz5tcEV?=
 =?us-ascii?Q?WUgW+3swUHk1xEibLS2AjUwNVfzSZmSSuWEXJLt0frghArLmY1BoXOBN8WXS?=
 =?us-ascii?Q?kJ85vZeHoTs46Q3L6Yj1ZU3tVzagFCHmjx/DX2CWykO2R8iRDWPRtcV36Uz1?=
 =?us-ascii?Q?eKTZVpiLbMnnCa2kkIXrV8PLaVw1pp5vWO7BlAgB9TvMmKB30HUnB94VfigT?=
 =?us-ascii?Q?vOWHRXo7Rgh1mUTguwUPKq+5hNKTGNgY9lppfJ4Af6HPWgyli7uYg2n/Qv67?=
 =?us-ascii?Q?G+osSkmbIYjAbQr0mdU22WfMj7YjUJWshldv9MTZJsSOoBmlJ/9Coq3qddwk?=
 =?us-ascii?Q?QFSIvTUf0KP8EEhNyEmA+bavTbPytKd9UCyJ23uim+MfoOGwszoIcPfK7Hy2?=
 =?us-ascii?Q?LtGs3wsKq3mLO+SkRARssR5jl35hiGhgJMzTNU+Ln17/7wp7tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZhpD2LxjGDCr/w+z5tm0FXAQ1PPmNF35aq0AHrrNM7Ykex2W8A0/wZ2vSUYx?=
 =?us-ascii?Q?qHqAK+v5W635YQUqprmb+rGKR22DZq1YaAn+b070b/H4Stx8QVm0EMTftY9q?=
 =?us-ascii?Q?b7rmi0CfhcfPCGOzsx2gxVUDXN2SPhnX7/CjF8BP/8wrxiYB35nfJNFSbjYh?=
 =?us-ascii?Q?4TA71e5pvTl9Ucf4KvC1vt11R8LfVliaX9Lks8r4LPjs/1E2S6+pHffKCRMK?=
 =?us-ascii?Q?4SQtclsZaEqE6ZgUD6/9o0xPwId08ME/gsysonzdIYHQk+22LrrH0b+Pe7jB?=
 =?us-ascii?Q?9qidWdS7nEWfEmSz4b8mH0pvug/aaizcyxlSD1a6chty9hJeBDyBd1BHaCYa?=
 =?us-ascii?Q?7fRGnYdnmBUloiUoI5xtUdCSAozFhtXuJ0q0grefPmE97jX20T/q5cNfmHCy?=
 =?us-ascii?Q?jr6wm27jFpiNafDskWbs3KhkADDdgo2vvht+jEC2oQiUm70vJaFIPWWd+8cl?=
 =?us-ascii?Q?VqtBvkFPMuIfhI9iSkmpqnUulooKgOLBOeR6ycHwSXCxfuw6CcpoVfkmCGhi?=
 =?us-ascii?Q?M/6Fk95AIic6t8ZZ+EO0uKYp22ZTKqilqf+ceWcZ58nlKdzgwlfO57BqCraN?=
 =?us-ascii?Q?5y+UxgwJhhV7P0Ye+S6wQgwQBuJqHVpA2JcXmiPVkC+E6GEitwxekpUhgg/O?=
 =?us-ascii?Q?ZIitIVXouiSZHYIG+kIh3S0nJFdFlu+sSf57jGtbTcdHhHWlgueBwzihZcPY?=
 =?us-ascii?Q?Oisbwhhlr/v6VevmCHZ3n5UV0A/efd83S4P+1R2GX9NeMCFCyu4MdJuYFhnV?=
 =?us-ascii?Q?l1Zv18oDKO0G97KimjoVKIr6gD23waEYu9vFMEuyHtoQsHvJclN1NDsoaFVB?=
 =?us-ascii?Q?gd0fVkQ6EAffqT+UcheURt7LPMNLFPRX2QnrRHmfcpND2w9DbITAiI916UIZ?=
 =?us-ascii?Q?Tj+bm7WrM/dyLBtlZA2xTARETTy87JstQV+vA2zOBcJuOBvqVHCx+Fkdden3?=
 =?us-ascii?Q?fbaZmnrrbBATGnJR9UkADMp31Ie98eMN1WLP44NrkCK+dZbbQyQHktLpgL1/?=
 =?us-ascii?Q?BqaIrq4k5cClAkYaxbq5vfwR1ZwA+5ri3ye5cbg9x156YHYRW2S2vEGKyCjU?=
 =?us-ascii?Q?7a7Et/2xosV9ehYySpg8JwwcmTeCFpWlPWWtwDhmFXd/0G3rLo99v3OsBkEd?=
 =?us-ascii?Q?JmcgI3bDrNEb+p8dSc2IunVZEys7r57d5ZmvcZq2X1CYFJS1yl4lAdrIrvok?=
 =?us-ascii?Q?C8Ky5b4K2qQ+uzCqsF2ju9id6OFhApNjCR8w2O6nXu5UHoN5hxCCjDeU8J1w?=
 =?us-ascii?Q?Zm2FBoUNDilVCTPwS6DnSXPs7oV8BdG2EAKYkb8Ij0FV29ckNgrCaQdWR9kc?=
 =?us-ascii?Q?FfRC5NRTzGPbh22zxl+As3sfn/Yl27OYSsEYMI24kb0nkgttCZcum05ARDFd?=
 =?us-ascii?Q?VJZO8WA/xmV+gbVsghtD7brfmMnHHr04AJHXwrpkde2gWo/Lc7pos+kX5y5e?=
 =?us-ascii?Q?Y4k+HwubSPuni+vQ1sIc5ez65T2oovJOlcWJqlpX/OGyVvFDuJbSCpPSzpx6?=
 =?us-ascii?Q?MMdYTWIrrMabvvy/L190t3IxZXDzXhLnhID8ZbnS/DH8I67tZDgcoGuaSvoB?=
 =?us-ascii?Q?m0W49/+WFDnS6Fst+M27bF3vHKe6Y99zwMlFG7Au?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e567e149-f4ec-4c6a-86f2-08dcb6ed6fa8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:30:07.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVOC0M8jBX58Rj1oBjY2l2yidtxAHDy6h8FXFRFMPyGq76kbCn0lYVwO+R7SYDJ2iA9hOaMpT3e1f/H9VX3CVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9477

On Wed, Aug 07, 2024 at 12:41:09AM +0000, Thinh Nguyen wrote:
> Hi Frank,
>
> On Tue, Jul 30, 2024, Frank Li wrote:
> > On Thu, Jul 11, 2024 at 03:38:46PM -0600, Rob Herring wrote:
> > > On Wed, Jul 10, 2024 at 07:02:24PM -0400, Frank Li wrote:
> > > > New usb glue layer driver support enable dma-coherent. So put dwc3 usb node
> > > > under glue layer node and enable dma-coherent.
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 43 ++++++++++++++++----------
> > > >  1 file changed, 26 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > > index 70b8731029c4e..24b937032480f 100644
> > > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > > @@ -615,24 +615,33 @@ gpio3: gpio@2320000 {
> > > >  			little-endian;
> > > >  		};
> > > >
> > > > -		usb0: usb@3100000 {
> > > > -			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
> > > > -			reg = <0x0 0x3100000 0x0 0x10000>;
> > > > -			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> > > > -			snps,dis_rxdet_inp3_quirk;
> > > > -			snps,quirk-frame-length-adjustment = <0x20>;
> > > > -			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> > > > -			status = "disabled";
> > > > -		};
> > > > +		usb {
> > > > +			compatible = "fsl,ls1028a-dwc3";
> > > > +			#address-cells = <2>;
> > > > +			#size-cells = <2>;
> > > > +			ranges;
> > >
> > > No, the existing way is preferred unless you have actual glue/wrapper
> > > registers. Plus this breaks compatibility.
> >
> > Actually, it has glue layer, such as wakeup controller. Remote wakeup have
> > not implement at layerscape platform yet. But this register distribute to
> > difference place with other module misc controller registers. It is
> > difference for difference chips. I can think deep how to handle this.
> >
> > but anyways, it will break compatibility. I have not find good way to
> > keep compatibility and add glue layer, such as wakeup support.
> >
> > Frank
> >
>
> Will this impact how the rest of the series look? If so, I'll wait until
> you resolve this issue and review the rest.

Rob:
	I checked many dwc3-of-simple.c compatible string, which have not
'reg' and just have some clocks and reset.

	Is it okay to add missed clock and fsl,rcpm for usb wakeup support
in gluelayer node?

Frank

>
> BR,
> Thinh

