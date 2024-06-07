Return-Path: <linux-kernel+bounces-206613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A16900C0F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5151F2305F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF4F143864;
	Fri,  7 Jun 2024 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s3OuNrLX"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2089.outbound.protection.outlook.com [40.107.7.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E0D10A24;
	Fri,  7 Jun 2024 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786370; cv=fail; b=m5slf3AWLwZ7C/GPsHggZmijmmNurrOtNAq+U67CjGg2Tb8PRVneWTs3gtYibkj+y/25pY/oqrcWPZ8YoWEMNGkYVOgMzjCjKa7/grqQKiicDA06dORsgnkIEgdFHoJBQP/SpHblSl2VbtOVn+Zg5eU1X5ctrmz9nBf36JuwWtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786370; c=relaxed/simple;
	bh=3DHmg6XrSBGUT47dFuMJVKc1KKdBmmxXN9Cf0QnpWWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b0wytDEzsLluypqRVMdPg3lQbhJ9srKjmQwMYzrzwKaN8Gv4v34p3PPlme75tkvkyFmN70mjD7Bg5LGxynZIKczg7R5NoFwCUf3+NL8hSpuJh7E6Ocf6d8/x9HVSCkdzBgWkABfuD2/kjWagvh4AK5cMLq0N2ruusg/xoRW1SfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s3OuNrLX; arc=fail smtp.client-ip=40.107.7.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mccskFKrNfJrtLOC1QmKwFjb8JIuk0b3JAcndK7QKKMfl0PfbM0nzWCHaoraZM0vLJA9UrpF0ZB+1Q5Uo9Vw+LsiuWIiD6KN84jNNPy5qJX0SGcJ7Ids9C9KNEIWLjw0msa5vFUMLKw4isOs/0uTUSU8AhxQXdb3yTzo+m7Y7zoz+1sEVLwd4xRLTb53YHVMs2Q7o0tqandJU7qTWlddzTcuNmLehkE3emIBxp5Bkr0oD2xSwXOlFYc83KTmnwsNimr9y5B/mgnIISZshrjWnilhwO15t4bq/vAtq84vTsjzZ5UzYrTg5b3pNNn5akeNFZ7uVSh8rPmJk+bjrYEuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OwfIN3FRUvSnWPtvOa6B7Wu6IEhuKp4Z+dNByBG9a0=;
 b=ADssdKrzqakIf6IXC1YwkoYpR2gqNSlW/HCBDburUYzzLnbPSkB2/3eaVBP9BSIc6SqkLFFpBogpJbman3jJJCls+f52DEX/2AnflOYiKmg+w+ntCGUrG17n9PmVB24tkZUoC6Zr52wIDaOMLuts0Y0gvJHdU7ml7Ad78NBzukdoefOxAns1BUOTCx8lvLuYoF0gD/Uon2VnWqmgn4SpoDp9PXx45N0oY0WGl7kTsftaMybMU38LgetmdZhQm7mbEsFb0mdYTrJYOinH62KURjeMWFuDZg7AdvImBhj5rxKCf0AKAl5bNUY1idE2aHym6zXbpdwUvyM/F+xRfMJ80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OwfIN3FRUvSnWPtvOa6B7Wu6IEhuKp4Z+dNByBG9a0=;
 b=s3OuNrLX48xBLrSDNA4t19RlgDWwRcFB5E98vUhGhnpjOwfg291ijbxylCWMcjge9A6e+P2I3F0GxreuEPQZPLcTQnMXw1aGkqE1ojAOpJHlZCeQZ1oZZ5yglj40/NazZ4+B8Pxg8nJWIYXQli2vWlXw/AUEWlECXF9+LvmvX1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8746.eurprd04.prod.outlook.com (2603:10a6:20b:43f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 18:52:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 18:52:44 +0000
Date: Fri, 7 Jun 2024 14:52:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aisheng Dong <aisheng.dong@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] arm64: dts: imx8qm: add lvds subsystem
Message-ID: <ZmNW81FbILhkTAlg@lizhi-Precision-Tower-5810>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
 <20240606-imx8qm-dts-usb-v1-1-565721b64f25@nxp.com>
 <AM6PR04MB5941C0BBD0A64A9AFDD8EC5A88FB2@AM6PR04MB5941.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB5941C0BBD0A64A9AFDD8EC5A88FB2@AM6PR04MB5941.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b5febc1-b5da-4436-2643-08dc872303e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1MNKy0j9/eFJIjQJHijH9sdgLQF/GLjykJRs2lJBl92kBQai9nUoduf5lgwU?=
 =?us-ascii?Q?lMg7dJLmX6TYsM532UtKRep8j812JBV76Mapg94q4j5WVng9pbyEjB8M+k1W?=
 =?us-ascii?Q?69lxjaCVvHSAI9XFHnB4/huQB8oW+nSgslfgv8MBsRtINGzQV1GjAYQGq5N8?=
 =?us-ascii?Q?v+ipvCxBRVwr9itJSl8NX7+ltopX/1SaAYd/TWf87lFGlF0DuH4V8ID7j0Ww?=
 =?us-ascii?Q?tcidnG5CkaYQ9naazlMe3GJzUrM29m3P09SP/0HUzR29RlNE4J3hE1ZqRB+E?=
 =?us-ascii?Q?DXY+24+eXl86oiLp+4k4H5oxOSM8X/xCY0D86ARYZn1o+MIbQtZH2xi45yrz?=
 =?us-ascii?Q?yuNqpV2re0sNPCRrXHepUKkBiyFePw1EabThDfJLzuRm7oBUeTK3wKJNX4GN?=
 =?us-ascii?Q?BrwH/cDhXTTxGyoyEU7pBfXm3Bq51Y6UyxPvK0cjvm+fpJVyQZYUlIfMgG8S?=
 =?us-ascii?Q?PVfiqx3g1X6zPhlMC8+e1Xu26/C707JfKF4uypUm7HI3TAebIBdKylNSoNZl?=
 =?us-ascii?Q?wqOyc3GdL09aGWOLB0v2gyFhfDRwvVJ6bhFEEZXCNKD6yZH5PBpPPo/+pfSu?=
 =?us-ascii?Q?t1nYDCx5R1yLLAM6gOmP2HTsmx4gwK266FGHF6hUUuVcIKtiSvNFp5tKfUnE?=
 =?us-ascii?Q?byA7HwwMYlP7jVuMu7efbbQBnfzIq4RyxplB0lPg+p/LCvomWNJseP2n3EKZ?=
 =?us-ascii?Q?VDvhE+4r0yhkdQz0wALrYJW1UMqZ7Jeqzhik3+UOQXH6btZrHrFYUItEZE16?=
 =?us-ascii?Q?E/2XXvlX+oP6iJfPWnsEdpvFhSg6x9Vt6Z28eh4qef309QynjiIth2feNiHC?=
 =?us-ascii?Q?2NTVz0gAU08z8tLoD5TdJMn8GNYHKdVI19TMXwJuUDaC57nUcbhOiTizrWsv?=
 =?us-ascii?Q?ShSVSfQZb3sc31Kj81iLBF2miIfSmaByoXL8/FmYkn40/0VtCAD5J3yxN7FK?=
 =?us-ascii?Q?sg3o5mm7i9oI5A0dIU14F+oKa6goZZx9XXUSxb0CeqJuG1GUP27pz8LNnNlB?=
 =?us-ascii?Q?s/kfEgJ2m185TamZIw2L/ib9o4bHqcvdd61jJ2tXAOtVJ/b7TPkq2DEB4AKQ?=
 =?us-ascii?Q?8fWJ+7f5W96dnmBndc+LL+uYwxh9ti05zWwLJkf4/71foiCrjF2RrOMIJN0j?=
 =?us-ascii?Q?J5vdSBDgBfUsor0bRUfLJmpVU1ccOAW5aRvmIqE/pq3grV5gmEiqBt1a+bxe?=
 =?us-ascii?Q?LlDwAkZq9BAOWX2yOeu+zx89u8xYoWbx+BfV8cclc0Z487RB7K2C2MiAfX/1?=
 =?us-ascii?Q?5sYUGUQ54t0HxvYwiADrbX5SBtBTX4bh/v90xgBMNvdbaIfkRloIjjnpxJc0?=
 =?us-ascii?Q?pUOGhLRrPwo9Uv3Jn5EKQJQ4Clvck79J4DyBTBUWsm+mVkDK0wi+Zf5ld8Mb?=
 =?us-ascii?Q?UHrFByA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V1SO9Ve5O/Fx7U/gQ+pcGtpY228F1uRnlR7q89l4s4eqSIG0+7xcvxSbqp0X?=
 =?us-ascii?Q?1v+rnLwATNqLlqxGJ4w9qbp+N0IQ3VdO96nMinNCosPukJA86ymV/8KfWDvu?=
 =?us-ascii?Q?SaA+mKBxIj4M1Cpp2d6x7ZFJ4w4qqb0F4c8TQDNQBcJJLqplUBPJUL15dqSX?=
 =?us-ascii?Q?cBytFSk5LTI15IcpqkkuEauZePG7CWaGc5Dt9OXNOS9EELzGcs1cOFWC/DEK?=
 =?us-ascii?Q?nuct2erqoVJ2hD9yC9y3Ns3nBCkRZuhEXftAHJeiDu9Ied9hAHInaMIQW9Xs?=
 =?us-ascii?Q?yb210TWTJxY7DDwy1iF0CpyAHe0aGZ5t3+hyLuXEGRwHeWz/8bMXWo8DgLhg?=
 =?us-ascii?Q?gKo0riIaLaMcRD8KzttGvX/wUnfIoisVya4pSoKjEAhnbg6gOeJ3dDWmlpB9?=
 =?us-ascii?Q?NCiIL/uKsqgOX4WkotytZno/AG9X+MJUsDq0WZOe6GpkT8tuX60esbxqRmY6?=
 =?us-ascii?Q?4fi9nldqghQtXwfhSQJB8xx1Lf7kNduxW3HqivKRNsI87JBnLrDpFxfVnmW6?=
 =?us-ascii?Q?BF0VQutpOg8YJ5rnsKBYl2M9AyyQ2tDHa8svhvFUwZHjKVIQz0MT1QAbW1SJ?=
 =?us-ascii?Q?V1jZY3arkw441AP5/aLWagnlu0mcdRNIPx3MxCEFMraHbE3jcm3enkXYZYTq?=
 =?us-ascii?Q?6Pk+7XgCcNfWIiy4UewX/MrltWQytEfCJcenPujBl0cYBiiH1h9CEu49BfYW?=
 =?us-ascii?Q?5//6yFj1Sj5aR90PwHTepthg6FdxSyFEIdLES4z0BCi77wL41baXd18hGx65?=
 =?us-ascii?Q?4FDMZFpYqiB0eMPMldbQl/Lz5RA5/GR9b161cH1WLpn79bFjaMKvRDZ/N+OK?=
 =?us-ascii?Q?tFIlawYn/PVW4mRKkBeKEGZepzI4UCqB4gSZT9xFqGZWL49WP3aaZMo62iVQ?=
 =?us-ascii?Q?RPJBIiXsB8jA2FmUQGWQVnoLDWiafAMaaY38SVndk2c/Diz/TnSKhgF5z2oc?=
 =?us-ascii?Q?ONb2N5X0BuQg7drMAulf03U64QFYv1nNzHQcJTC6eL6WEk/aa5Vg9OZt4LFM?=
 =?us-ascii?Q?YI+EDpcZXpCK23QcYuYQOXfNHoTrG3fqP7QPn8PSVCaWgoyJ+IiE8Qqi6kdp?=
 =?us-ascii?Q?GW4RX2Sqoh7ao2lBaxXQG1nd8yMz9+o4fwI2hQ1OaCChsSgdJcLj3a9HdIMH?=
 =?us-ascii?Q?F1agF0OlobcTdbiHB/nV/+bfU7Z+dMscnkT5QA0P0yGFYiuiNS5yf+FmAplo?=
 =?us-ascii?Q?XAnDuuNxxYCyKFErtAypaYL3h4fOivZZm8PuRWDuZpDQjm4jVg8Whx3tLu3N?=
 =?us-ascii?Q?glKBoPsczxK5okIxe64gFAHfDFO4TynstgvQP8H74hS4NHuFspwOQSfFqG0U?=
 =?us-ascii?Q?QbfN2BXfPvUZ5nkVH5lsLhzFOA++rsdkPGWRo8Nkx9zGpJ5mGX5UZwD6DJWO?=
 =?us-ascii?Q?0yiESVv84BcOHj/FlXOAP7jkzUSpguNdLw1LeIWxVreGj7nbVcE9YzsCcTBF?=
 =?us-ascii?Q?e6A8SKgsHtQIy2cpki6PlnSXwx99xmiezIJmPrZrt9+YvFB9CUratIKi0c+P?=
 =?us-ascii?Q?jxAMNMFhyfGp550GBrsAkxrEVBkj/fp+XRcB2ql3sC9UmPCXYx59oW8VsWMm?=
 =?us-ascii?Q?12Ccx1MD/J7zDTEB+bk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5febc1-b5da-4436-2643-08dc872303e8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:52:44.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsQ+iuhHaSmBRMHsaC8pDfdmwLuJhMa7eej5EFd/pqQ867ZJLGrvxYY/oK4YW6ZZz7n6f7xgdSq+evdNa37vSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8746

On Fri, Jun 07, 2024 at 01:28:35AM +0000, Peng Fan wrote:
> > Subject: [PATCH 1/7] arm64: dts: imx8qm: add lvds subsystem
> > 
> > Add irqstear, pwm and i2c in lvds subsystem.
> 
> irqsteer
> 
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi | 231
> > ++++++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx8qm.dtsi         |   1 +
> >  2 files changed, 232 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> > new file mode 100644
> > index 0000000000000..eb8208cddeaf9
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> > @@ -0,0 +1,231 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> 
> GPL-2.0-only and MIT?
> 
> > +
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +/{
> > +
> > +	lvds1_ipg_clk: lvds0_ipg_clk: clock-controller-lvds-ipg {
> 
> Two alias name?

It is alllowed by dt. link to one fixed 24M clock. of course we can change
lvds1_ipg_clk to lvds0_ipg_clk.

To avoid confuse, I'd better use two name to align node nams.

Frank

> 
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <24000000>;
> > +		clock-output-names = "lvds0_ipg_clk";
> > +	};
> > +
> 
> Regards,
> Peng.

