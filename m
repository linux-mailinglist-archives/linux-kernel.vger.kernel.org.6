Return-Path: <linux-kernel+bounces-210119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A970903F91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B833A1F22689
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728AC2D638;
	Tue, 11 Jun 2024 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m6Rftg5u"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5002D058;
	Tue, 11 Jun 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118208; cv=fail; b=mMGqlGWl+IHWzATneqFVTthhVr3oGYBD6r0BElvbNm1Gnhaim2IpqoQzl6qICI7twRrNxFKI/7dVg/HGKiU3zgx2ZeP/1Z/Uq1v9PHZp3qMdeEdoZP4g4KCvADvhqNN41h50WEN3R25ildZFM82cHttxlgnCDonGFFmmScjigwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118208; c=relaxed/simple;
	bh=yuOyWTWPV5hi+RlOOEGu7/ERSM7MsCDQ0kuPpogq00U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JxU74ZL9c1R8DrOFIaB1TO08ZjAg6k1vvn2gUIBhdVigKZtkKd9MNiZdWamFdc+fPew/0cu+ZdxGw4Lj+vojJ0JbWE1jdlWMH4LqbB2d/+JxQSnMntdLhea85drSX1ypaealKbRbozfdCwrouacqeVmg4+VWCWv8cvyXRg1XxJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m6Rftg5u reason="signature verification failed"; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiLBN8la16OZYBS7V8jVCtCGSC8wG76qSLpVY7paeehWATcraaFJ1qVxbGHs2VyA4efr4vhLdavKGu8RNij6kwj+sqcTjLad1KPe//ySH/03X84rkud2oY//so3nhkI/7Y4ZtV81OKx5P4ycRxSXm32YeHaZUx+MXa90l2N/Rk6yM8voxczPQhn5MQUUqrSrNqdqBP71ABEy2TpxLZPg+6Ga//3je9x++h447m3IFlwZkNVT8E3a/hAL0V9kuXSL1k/Dr2nMTdld/i0P0LCVz7ai0UCVM7/hGQ0hkGj9Tobjhbk/9sQMBCPXGMzmH9lbfsQSgho1a2IO4v6FI9k4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3qBXlS52SYHDOq7ejbT8yxp5pe8R+e6xso2fPzf2EA=;
 b=Y22t0zF6EobI+aiOzzCBh8Tem3z5Xo1/836O+m5EsX3fVXkKQgu4qIvE+RwrMjUoowBXsuxxsVzciJHOyqBYZQEFRpZQAPyi1HE4ETFT9RU36xb7hbUgU99g17VLZIoC2ofZOqErpc1d8+D/zLuRrYooCGa/ygHka10tbBntPJZabjAVED6lG6ZpoUZtlj1qDaWklU4bFp0V3Go6Mg+FaQE9npsyvbguFecmcapnR+pjJF748FMetE3GAFwR//LmufmMiyb9IfMTpqVPu9YRNtAlA5CuOwg7BRghJJp7ioA39nRBpN25SDEsWrzMG0JELMxof2L4+Vhn+kPtuU6jzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3qBXlS52SYHDOq7ejbT8yxp5pe8R+e6xso2fPzf2EA=;
 b=m6Rftg5u4G/FbyurXFIKzaa7Aoo44BIVqaNyRUrRVqKva/lvZikjYPc/JxwMJvqVA/bnhqgVfmvns6eP6D8XWYXn+B/s/xySYcoVvJ2FkjI/MeAdn8IEsVvGkIp7wsHNjv0QYqsag4oG8fb9UJGFP3+cAEhCaBzLrW4YxrrKgP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6893.eurprd04.prod.outlook.com (2603:10a6:803:133::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Tue, 11 Jun
 2024 15:03:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 15:03:22 +0000
Date: Tue, 11 Jun 2024 11:03:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] arm64: dts: imx8: add basic mipi subsystem
Message-ID: <ZmhnMTGrl+3m9w1f@lizhi-Precision-Tower-5810>
References: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
 <20240610-imx8qm-dts-usb-v2-3-788417116fb1@nxp.com>
 <13535816.uLZWGnKmhe@steina-w>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13535816.uLZWGnKmhe@steina-w>
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 335cc48c-0b2c-44bb-7e97-08dc8a27a2c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|7416006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?g6ygF0h9wFsdPJUnFlwVrCMhHqpmav4lC12q9nh6hyJvdyC9PiAw+LLN+8?=
 =?iso-8859-1?Q?XQ8ADZ+0Zyh4bD+vC2hzWbzrcRvbbJkeyOXu1dohuwxuJl6uIuLgSaIAuD?=
 =?iso-8859-1?Q?1l9VdT+7qBzvemxTpRMdK3Jb/p5DXi3Vup/NkqKr009Zgk04fpHUXpkwEq?=
 =?iso-8859-1?Q?mPpgeD7adFYNShWauaGHajvO2VNhzl5MqK+8YO578c8vcG0b54tF3FMypV?=
 =?iso-8859-1?Q?yi+JwFH4VGeb0fxluF4vgHZ+1FFt6xwxv+iMbxeXKpY2FS7fzdUFrvMJct?=
 =?iso-8859-1?Q?h0MBKT6rREZI872Eg6Uw7nIusDG9TkEb2V//8uLWrwJrVWisCQemwBZRuC?=
 =?iso-8859-1?Q?LJsqFqcOMCV1tT/FeQtJSFqTZeI1yCsHtV78MzEsZxp8S/om+A3VU8bklB?=
 =?iso-8859-1?Q?6ty3LWQOtny/0LtX+bGwtDpe2UQBjkle8ZuqY7HWznIP29cDolkIyrIuRx?=
 =?iso-8859-1?Q?uvURN5VHsDMx2b7xYX1/uu8OFzvZ7/QDdKQYLzvQHZjIh0D5xNwQ6shfDU?=
 =?iso-8859-1?Q?USrxkqexzZ+Om7ieOH4ACKLSKtzoogyY3svK4Y/kVToHbyRwiVGHjTwlY2?=
 =?iso-8859-1?Q?tpMKg4wjwWndacya0+hrol7MH9ppJ3mBTvW+yU/1a2TYONSGiW8eXaYi3a?=
 =?iso-8859-1?Q?wBr28V2Iqearrh3IXKo1Hpkao6S6EYP7YD675b5/7u9ozc2HzbVHtupciU?=
 =?iso-8859-1?Q?Gjx/pWuBQngj0DPzMmB9suDlqbrBtZ+OgLhFBFn2ezxMmvh4rUj0Cn9BYN?=
 =?iso-8859-1?Q?9lnBWtUwPwTkz1l9ZauBwlwiHD0UBRIxrCm6vathWxi3TKj1340BuI0L0a?=
 =?iso-8859-1?Q?h2FcbWluHH0qWFhATXCOeMe19lRSKbVXL8QzqW1KxpLpqoHTkYtdns5Xsq?=
 =?iso-8859-1?Q?BpcshReGsydqSfBSVELWyqkDL6kf182SYNqw8V5RM6bJMGlWmwGGKWUKJb?=
 =?iso-8859-1?Q?GNHnrseKeXosp6BvvGBaXFyJ2oPdBYlEafCwlaY/c8goc8iOqnTlZWHyeU?=
 =?iso-8859-1?Q?k5ycSNWXCuI9bh2hB9Y/ZzTX6NJE/dP3+cNp1o5j87Z0yrbEb1gd0ikjTp?=
 =?iso-8859-1?Q?1vxUAD1fgRQ+pB6OqIjKUSdhMaZnoixNRtVuOewKpoNwOP8XNh4JXiz0C/?=
 =?iso-8859-1?Q?oCe7NouYecgykThhGaauHtVSeR1kIzvgidWLxPcgghYrEYY0h7zpIgVy0i?=
 =?iso-8859-1?Q?ezhxuv7+dqbAszCQJ4Q/LU1h/ZLUKAhVal9Jhw2SYrBiCn9j+F4Dc7OcM7?=
 =?iso-8859-1?Q?w81PAJnI3r+gAUbkZ7oxKGCgZiR7z+V2Be3W/NuZsiBnMTQgW5HFhRJcOM?=
 =?iso-8859-1?Q?YV/jr5BiA6feBc21ce6Ec7HNMg70pepIw5PfMO7tJWkDFNGcA8KpZvgnb1?=
 =?iso-8859-1?Q?9fT23/ueT3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(7416006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?cPLRemAZRKk+gyf8U6XIZQ+MRgLXa4Vb3Ly5061lfcngEGawD0cN4OQ24R?=
 =?iso-8859-1?Q?hx4tV/Ta9Fnr9TbnkAlHuRb0AFu16Ckaiaz7Agr5k7cDhtsOyTfnQELcvz?=
 =?iso-8859-1?Q?kmT7STCd+U8MvhN7UKUniAoCglV5Tl5ic2lu+kylTQo57VMsgEGE+eWfAZ?=
 =?iso-8859-1?Q?6MQvuANhqMjWLe8T6iN9faje+MHDAfUwV7LRRpUiyAc39w1p/lXx7sC5of?=
 =?iso-8859-1?Q?zG0NhRyBUJtoSbxaWUsBY6JFW3IbV4G8n7OsfItQmIHArz3/GcuJLbggUa?=
 =?iso-8859-1?Q?GiZxHJl74MoyxQbVPo3EC3nddQxNT7latD7KT1DU5Q55YjqO17P0ZL4h8t?=
 =?iso-8859-1?Q?pVDp/x7uJATaxyhHnzHfTeSTTHqarKzgc/1cZxyKilDpePBpHUZZUBd3qB?=
 =?iso-8859-1?Q?nrnCDihxb+XxH4T8seBIsumMpKUEsS+FOiZ2z1VLv872TmvJ4B+dYgW18Z?=
 =?iso-8859-1?Q?sqrQdlKo1kAxn1KNTiAoDejzJx3cZHm6zV7x8Vnlu3tc9zqdxciuF3YDMf?=
 =?iso-8859-1?Q?PykYxIo9qXn0fRRSal0vxmDfR1/huEaFTIlAoaFW7RNSlCp8DJmrh6bBVf?=
 =?iso-8859-1?Q?8lDSRbkC7boJ8pfFfJ0en+335Lro8hPVIymJ93cn7FB3+A8tcps2xf/JW+?=
 =?iso-8859-1?Q?D4t6qWjSLf/TYzNohLYjR6Ttr+WmMbsBo4xTeTu+Gumw7z524lRLc2bDwW?=
 =?iso-8859-1?Q?Udh3SsxylwFbUmaBr5/oAIjHTkga8serVWR8F7ms8Jl/CGP8yJXhUFEWu8?=
 =?iso-8859-1?Q?ZWqgS2QOUnWJkx2M/HKgnwkDU9lIu4asWNWsr0pxJ2hEfIqSec9kTsficK?=
 =?iso-8859-1?Q?dfnZG7mucX6PkSijNbM1AJs77BrsvNTSHZDCfEljYi20TbEXhsMknlg4Ai?=
 =?iso-8859-1?Q?lrNkK82j/1SE97UPo8sYr24MjmeimJNiDphQM15d2LyvHFJTT5PBVioGNW?=
 =?iso-8859-1?Q?rIl0I6JtoxSjUogp8I71qFhW0lnmfv0QZ9/N5PlgWvLtYO6qiXWLwxMhhc?=
 =?iso-8859-1?Q?NchcF42MvzmuZ6gxYnaEGokjpuhkwB7nKmVMDBUt8/lBs33oUi+JdgIUXk?=
 =?iso-8859-1?Q?Z4qf5CzsUknjg1F/jbZhlb34g6gP1yz5Gg1QFCDea6i5586vynt0qHyu/S?=
 =?iso-8859-1?Q?kLXS7pcxQazxkzFTlG4iwwcoHRXAbMx/buPdCSBjBob0VOU58Xc8e0PZAk?=
 =?iso-8859-1?Q?fZOZvV31qvannUC5I0GGFV8j9ZC8mZjDyYrkDA+eHMBi3XNYtAzvPDEjgc?=
 =?iso-8859-1?Q?ufEFjU1fk6Haqqq1GT5wWj8UBGMCvanJFfXJhQ0kuJJz8pzmiMgbgFk6Es?=
 =?iso-8859-1?Q?TrX7346XcoV9Jqq1mr9jsAaIZYKI+LnhspCSvl1ebanJ73yKsjEiYxtDFp?=
 =?iso-8859-1?Q?QQDud2DxDrSwdfA54DofO0hukoAnIjFriZZWoQWkNF2hiVPXXwDYREJdKQ?=
 =?iso-8859-1?Q?KDsc3YyHK2/59t2dsLumXHB2zfOiXvoLFVRxpyuj8u2GaTT/ynFnBbOyvM?=
 =?iso-8859-1?Q?OgIGmE88Y4RdIAZ/vQF6nZLJ8aTM9aJQNDy0lI/dbXs55C/GOUxesjMrJk?=
 =?iso-8859-1?Q?8NKZFVjY2UnfbHH1KI6JUH91ZXRK5UDesE6XA2X04FRNkddyVUb9d/kgR8?=
 =?iso-8859-1?Q?e6yoz4GfPmtbiuxUpwzNbNp/AEVD7P3HQM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335cc48c-0b2c-44bb-7e97-08dc8a27a2c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 15:03:22.0142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Pcg048KJOoOunSxKtoVeJA15GEz03ZpUE9ZRFcZOCt4HJvhz+ksd7vM4oAbES/VPlMcdRZAnZefldS9tQYyBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6893

On Tue, Jun 11, 2024 at 01:14:20PM +0200, Alexander Stein wrote:
> Am Montag, 10. Juni 2024, 22:46:20 CEST schrieb Frank Li:
> > ********************
> > Achtung externe E-Mail: Öffnen Sie Anhänge und Links nur, wenn Sie wissen, dass diese aus einer sicheren Quelle stammen und sicher sind. Leiten Sie die E-Mail im Zweifelsfall zur Prüfung an den IT-Helpdesk weiter.
> > Attention external email: Open attachments and links only if you know that they are from a secure source and are safe. In doubt forward the email to the IT-Helpdesk to check it.
> > ********************
> > 
> > Add basic mipi subsystem for imx8qm and imx8qxp.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi | 138 +++++++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi | 138 +++++++++++++++++++++++
> >  2 files changed, 276 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi
> > new file mode 100644
> > index 0000000000000..6b56315e8c434
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi
> > @@ -0,0 +1,138 @@
> > +// SPDX-License-Identifier: GPL-2.0-only and MIT
> > +
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +mipi0_subsys: bus@56220000 {
> > +	compatible = "simple-bus";
> > +	interrupt-parent = <&irqsteer_mipi0>;
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	ranges = <0x56220000 0x0 0x56220000 0x10000>;
> > +
> > +	irqsteer_mipi0: interrupt-controller@56220000 {
> > +		compatible = "fsl,imx8qxp-irqsteer", "fsl,imx-irqsteer";
> > +		reg = <0x56220000 0x1000>;
> > +		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-controller;
> > +		interrupt-parent = <&gic>;
> > +		#interrupt-cells = <1>;
> > +		clocks = <&mipi0_lis_lpcg IMX_LPCG_CLK_0>;
> > +		clock-names = "ipg";
> > +		power-domains = <&pd IMX_SC_R_MIPI_0>;
> > +		fsl,channel = <0>;
> > +		fsl,num-irqs = <32>;
> > +	};
> > +
> > +	mipi0_lis_lpcg: clock-controller@56223000 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x56223000 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&dsi_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>;
> 
> That's LPCG_DI_LVDS_LPCG_0 for imx8qxp, no? So clock-indices and
> clock-output-names should be split similar to patch.

I am focus qm firstly. I can remove it. 

> 
> > +		clock-output-names = "mipi0_lis_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_0>;
> > +	};
> > +
> > +	mipi0_pwm_lpcg: clock-controller@5622300c {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x5622300c 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>,
> > +			 <&dsi_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > +		clock-output-names = "mipi0_pwm_lpcg_clk",
> > +				     "mipi0_pwm_lpcg_ipg_clk";
> 
> That's LPCG_DI_MIPI_LPCG_12, no? imx8qm RM Rev 0 just lists one clock.
> Also it's different on imx8qxp.
> 
> > +		power-domains = <&pd IMX_SC_R_MIPI_0_PWM_0>;
> > +	};
> > +
> > +	mipi0_i2c0_lpcg_ipg_clk: clock-controller@56223014 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x56223014 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&mipi0_i2c0_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
> 
> Just 0 instead of IMX_LPCG_CLK_0.

all lpcg have to use IMX_LPCG_CLK_n, down stream clk driver is difference
with upstream one.

> 
> > +		clock-indices = <IMX_LPCG_CLK_0>;
> > +		clock-output-names = "mipi0_i2c0_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
> > +	};
> > +
> > +	mipi0_i2c0_lpcg_ipg_s_clk: clock-controller@56223018 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x56223018 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&dsi_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>;
> > +		clock-output-names = "mipi0_i2c0_lpcg_ipg_s_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
> > +	};
> > +
> > +	mipi0_i2c0_lpcg_clk: clock-controller@5622301c {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x5622301c 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&clk IMX_SC_R_MIPI_0_I2C_0 IMX_SC_PM_CLK_MISC2>;
> > +		clock-indices = <IMX_LPCG_CLK_0>;
> > +		clock-output-names = "mipi0_i2c0_lpcg_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
> > +	};
> > +
> > +	mipi0_i2c1_lpcg_ipg_clk: clock-controller@56223024 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x56223024 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&mipi0_i2c1_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
> > +		clock-indices = <IMX_LPCG_CLK_0>;
> > +		clock-output-names = "mipi0_i2c1_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
> > +	};
> > +
> > +	mipi0_i2c1_lpcg_clk: clock-controller@5622302c {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x5622302c 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&clk IMX_SC_R_MIPI_0_I2C_1 IMX_SC_PM_CLK_MISC2>;
> > +		clock-indices = <IMX_LPCG_CLK_0>;
> > +		clock-output-names = "mipi0_i2c1_lpcg_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
> > +	};
> > +
> > +	mipi0_i2c1_lpcg_ipg_s_clk: clock-controller@56223028 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x56223028 0x4>;
> 
> Order nodes by base address please.
> 
> > +		#clock-cells = <1>;
> > +		clocks = <&dsi_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>;
> > +		clock-output-names = "mipi0_i2c1_lpcg_ipg_s_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
> > +	};
> > +
> > +	pwm_mipi0: pwm@56224000 {
> > +		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
> > +		reg = <0x56224000 0x1000>;
> > +		clocks = <&mipi0_pwm_lpcg IMX_LPCG_CLK_4>,
> > +			 <&mipi0_pwm_lpcg IMX_LPCG_CLK_0>;
> 
> I don't think that's correct. IMX_LPCG_CLK_4 evaluates to 16.
> 'mipi0_pwm_lpcg' only has 2 clocks, so you should use just '1' and '0'.

all lpcg have to use indices, instead of index. Upstream clk driver use
arg0 as clock indices, which is difference downstream version. 

> 
> > +		clock-names = "ipg", "per";
> > +		assigned-clocks = <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>;
> > +		assigned-clock-rates = <24000000>;
> > +		#pwm-cells = <3>;
> > +		power-domains = <&pd IMX_SC_R_MIPI_0_PWM_0>;
> > +		status = "disabled";
> > +	};
> > +
> > +	i2c0_mipi0: i2c@56226000 {
> > +		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
> > +		reg = <0x56226000 0x1000>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		interrupts = <8>;
> > +		clocks = <&mipi0_i2c0_lpcg_clk IMX_LPCG_CLK_0>,
> > +			 <&mipi0_i2c0_lpcg_ipg_clk IMX_LPCG_CLK_0>;
> 
> Just use 0 instead of IMX_LPCG_CLK_0.
> 
> > +		clock-names = "per", "ipg";
> > +		assigned-clocks = <&mipi0_i2c0_lpcg_clk IMX_LPCG_CLK_0>;
> > +		assigned-clock-rates = <24000000>;
> > +		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
> > +		status = "disabled";
> > +	};
> > +};
> > +
> > diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi
> > new file mode 100644
> > index 0000000000000..5b1f08e412b24
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi
> 
> This is only for imx8qm, no?
> 
> It maybe makes sense to rename this file to imx8qm-ss-mipi1.dtsi
> 
> Best regards,
> Alexander
> 
> > @@ -0,0 +1,138 @@
> > +// SPDX-License-Identifier: GPL-2.0-only and MIT
> > +
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +mipi1_subsys: bus@57220000 {
> > +	compatible = "simple-bus";
> > +	interrupt-parent = <&irqsteer_mipi1>;
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	ranges = <0x57220000 0x0 0x57220000 0x10000>;
> > +
> > +	irqsteer_mipi1: interrupt-controller@57220000 {
> > +		compatible = "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";
> > +		reg = <0x57220000 0x1000>;
> > +		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-controller;
> > +		interrupt-parent = <&gic>;
> > +		#interrupt-cells = <1>;
> > +		clocks = <&mipi1_lis_lpcg IMX_LPCG_CLK_0>;
> > +		clock-names = "ipg";
> > +		power-domains = <&pd IMX_SC_R_MIPI_1>;
> > +		fsl,channel = <0>;
> > +		fsl,num-irqs = <32>;
> > +	};
> > +
> > +	mipi1_lis_lpcg: clock-controller@57223000 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x57223000 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&dsi_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>;
> > +		clock-output-names = "mipi1_lis_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_1>;
> > +	};
> > +
> > +	mipi1_pwm_lpcg: clock-controller@5722300c {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x5722300c 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>,
> > +			 <&dsi_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > +		clock-output-names = "mipi1_pwm_lpcg_clk",
> > +				     "mipi1_pwm_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
> > +	};
> > +
> > +	mipi1_i2c0_lpcg_clk: clock-controller@5722301c {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x5722301c 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_MISC2>;
> > +		clock-indices = <IMX_LPCG_CLK_0>;
> > +		clock-output-names = "mipi1_i2c0_lpcg_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
> > +	};
> > +
> > +	mipi1_i2c0_lpcg_ipg_clk: clock-controller@57223014 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x57223014 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&mipi1_i2c0_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
> > +		clock-indices = <IMX_LPCG_CLK_0>;
> > +		clock-output-names = "mipi1_i2c0_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
> > +	};
> > +
> > +	mipi1_i2c0_lpcg_ipg_s_clk: clock-controller@57223018 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x57223018 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&dsi_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>;
> > +		clock-output-names = "mipi1_i2c0_lpcg_ipg_s_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
> > +	};
> > +
> > +	mipi1_i2c1_lpcg_ipg_clk: clock-controller@57223024 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x57223024 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&mipi1_i2c1_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
> > +		clock-indices = <IMX_LPCG_CLK_0>;
> > +		clock-output-names = "mipi1_i2c1_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
> > +	};
> > +
> > +	mipi1_i2c1_lpcg_ipg_s_clk: clock-controller@57223028 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x57223028 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&dsi_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>;
> > +		clock-output-names = "mipi1_i2c1_lpcg_ipg_s_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
> > +	};
> > +
> > +	mipi1_i2c1_lpcg_clk: clock-controller@5722302c {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x5722302c 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&clk IMX_SC_R_MIPI_1_I2C_1 IMX_SC_PM_CLK_MISC2>;
> > +		clock-indices = <IMX_LPCG_CLK_0>;
> > +		clock-output-names = "mipi1_i2c1_lpcg_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
> > +	};
> > +
> > +	pwm_mipi1: pwm@57224000 {
> > +		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
> > +		reg = <0x57224000 0x1000>;
> > +		clocks = <&mipi1_pwm_lpcg IMX_LPCG_CLK_4>,
> > +			 <&mipi1_pwm_lpcg IMX_LPCG_CLK_0>;
> > +		clock-names = "ipg", "per";
> > +		assigned-clocks = <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>;
> > +		assigned-clock-rates = <24000000>;
> > +		#pwm-cells = <3>;
> > +		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
> > +		status = "disabled";
> > +	};
> > +
> > +	i2c0_mipi1: i2c@57226000 {
> > +		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
> > +		reg = <0x57226000 0x1000>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		interrupts = <8>;
> > +		interrupt-parent = <&irqsteer_mipi1>;
> > +		clocks = <&mipi1_i2c0_lpcg_clk IMX_LPCG_CLK_0>,
> > +			 <&mipi1_i2c0_lpcg_ipg_clk IMX_LPCG_CLK_0>;
> > +		clock-names = "per", "ipg";
> > +		assigned-clocks = <&mipi1_i2c0_lpcg_clk IMX_LPCG_CLK_0>;
> > +		assigned-clock-rates = <24000000>;
> > +		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
> > +		status = "disabled";
> > +	};
> > +};
> > 
> > 
> 
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
> 
> 

