Return-Path: <linux-kernel+bounces-536889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15DCA4855C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9079B3A9B53
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0051B4232;
	Thu, 27 Feb 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZLJpmCSh"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6D1B2EF2;
	Thu, 27 Feb 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674401; cv=fail; b=pD7Su6IGwIWFyZB9Hg1jRA1M6oHYfjSMAV+vOwFA9iARGmyCbQ3M0XDK6Ops/1w4gbUhBKxWDVYmLU1sZgDYp/BG83S3MOnSv3OYwNaSiQIVuAO4an1M1YCzizAAQS3LvjQkYbzvKynsWZICPjP6FaRmzKgw/O2q6N3y+FhOUFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674401; c=relaxed/simple;
	bh=PvGkMDFLa6upgLTUXu93JA+UxRtA2Xna38Q8vuP43bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SvxtwKpKCOk9AyQ6aieBFaWqYfdUb4QxAdIvwDlYrKLBSLx+0hMGbbqpocjngDpzEy4WBDgCpThbg9h0+P1TSIqwQBSRDAARsOSo6cK9c/f1q4Vq+heVBh6J0YnvInkbGhJjOmLLSlJmuYwKXGboK4/el5aK49TD3dnuekb00fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZLJpmCSh reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H64UpFRpqwKvm4QV9cb3fXG2IfMRbAAM5z7t5zRrJzyytaH3eQKsZM5nnCLeXhUhebN3QjA8MDdciLxDH2oRaPku7dJ9DDqPe/9fdLHnNEsvMz4wVRy11iE18joDV1GCKAhq1zUqA5wdwDCHy4qOhcVRd5bXE/ZX4BZs1/kbwMJ2DXGQXUCi/Brjl+l3AiZAhh+GY0+V9G9+RS0U6+lG8O/sLkZWWsKClZs4iDMqw66Xk5paZa4Fbp8O+p510bzj7Hx1GTLhB0FR3zvsKUalGHfwz82aqc9pwhvcP+3fjMxIXag4y9ryJ133bpQicHtstuDeJuio9IdRK6Isjt2WdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRs9RdCjnBDLt672JIm0ap5aI+xjByy3D4ACZtoZ9CI=;
 b=dua04xdqsWYdkDuZAAhbPPN5ajAws38kzfVRUAc7St9Ez52jHyQf0VUdLPpkDFrfjH3DtKjnIJUniKly+2LC1zJHkBLUy0Mk0RiWo/4cQBAsCFk3vrtE/GMG2/OSKwIEUiR+Of9uG5f6dBWQBjIg4rdT+8u3UguoXZldRP5+4/ZVBGqa5ipWLAen0SD/0ZnDputhn9NbhEiJBWgoKs3LlK8v1TLsheGwgIwOmyXl1grR2zdYxSew0rhuUT5AWDbuNaPQDsr7kT3HMivg+RclrZn6GXBnStQADLABMlxW9PshpvlLj9LPXU+9YYKMMxiTcysPN7LCV+SQDwqQJv5cqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRs9RdCjnBDLt672JIm0ap5aI+xjByy3D4ACZtoZ9CI=;
 b=ZLJpmCShCrA8zrAHJRyyEShHz9Jgl2rXw5Hz9uR/SUOt3ylES6QfsRIw01jHOec8BXYzuRJzOvb/hymNXZcd6HTANW0eiJrrTDnE2Iekf+9YAfMXZyny1CGd3c+AqPRvm1suOaraM5xn3KuUyrB43bGMUYXhKwqJYaLmq8h4p2Z4/Gpx3LAocD8DgoO9nfdHyiUWcsvoxjfLeQlf/b0ztju8pMR9zK97HTO/7C9DKRl/xK7CoeswI6WaD8qwcpyJo1A50WviIAwMb74I75F5YMwkQSOfH38qceViOguR6iPT0lzTXM4zfwPdMhLK9JcN+nKjYyYPJRzXk2nig+NkOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10363.eurprd04.prod.outlook.com (2603:10a6:10:55f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 16:39:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 16:39:55 +0000
Date: Thu, 27 Feb 2025 11:39:47 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, hongxing.zhu@nxp.com
Subject: Re: [PATCH 4/5] arm64: dts: imx95: add PCIe's msi-map and iommu-map
 property
Message-ID: <Z8CVU/RWXSNe7bfN@lizhi-Precision-Tower-5810>
References: <20250128211559.1582598-1-Frank.Li@nxp.com>
 <1995746.PYKUYFuaPT@steina-w>
 <Z79B3pH0BwxJseHK@lizhi-Precision-Tower-5810>
 <1819305.VLH7GnMWUR@steina-w>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1819305.VLH7GnMWUR@steina-w>
X-ClientProxiedBy: SA9P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10363:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7215a6-e15f-488b-5052-08dd574d5d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?WfQHNAfmU9wvfE0DOAeg/Le08vWNCT6F5TJ5UMIjfgz59EXEhpCPe6XINV?=
 =?iso-8859-1?Q?4Ehp6O88RrG20sz1an0Y6g3Ga0uKU9lYVGij82JFHarw9IlKK+2/vPeTtL?=
 =?iso-8859-1?Q?GvADXwCRX6UDynTnUlahitJr/DZhY9JAsNLhme9D2oXrfBws6luTE57L3Q?=
 =?iso-8859-1?Q?6YlHZw6dsJ1XH8laAtt388PRxvpuB5SofsU9N3+icOrOtz5OnDA8TQV70Z?=
 =?iso-8859-1?Q?dNIXGPrriG+XdRhA/uBpq4MpumN5a7DF/BaWosPPTkXJ9QvpUuBf6taaHt?=
 =?iso-8859-1?Q?TqpMV7kXLN81Mq76fMIWb+WTqBn/XZDwnF+f1vZjmkJ6TPw7ilYvEMGZaT?=
 =?iso-8859-1?Q?Z4K8qIPMVzMckqmFJjLtcEeYi6dx4Cyr5UqJpRFlC+fl7LalfRknndLyhG?=
 =?iso-8859-1?Q?EbSJBedcbP6ohtbEEdJ62QDwdf7eeIdldBoghI5DjfskgLVxX+79ZAt9Ch?=
 =?iso-8859-1?Q?TWE4hLMQnVlocBMb9xUdw4dCeq35md2vWq5//hGFhFQEg0xqDI144wW9Qj?=
 =?iso-8859-1?Q?a7VQi1i/eWtML/9wigICkiWrhYMRQlTSk8f0xUq4Cm7ceQH159oWpcqEl+?=
 =?iso-8859-1?Q?+1TImx9ikfPWtLe77GhCG4GWmTdNdPXwUEMRsLY+tUg7ibNOeQU2JcImWe?=
 =?iso-8859-1?Q?OHbqeLCu2aqiz08VD9VcCKyvkddpotd6KA2Jj8Xk/uXN4ABmPntgMRWBcj?=
 =?iso-8859-1?Q?rjE4/ENtE2r3GK+3xVN6zUg7FNpMp3ypM4zE5u1vYqSCUrEdM1CFM7u5L3?=
 =?iso-8859-1?Q?jWebXYBGOLUtlyHdqe+onQjpV0OkAI4ZvGWX29CXxfPgDMlzQC9Ffeords?=
 =?iso-8859-1?Q?9zYcyl2BLlkYk92UO1+I/OlIMQ2pradvAGeAZij8dcb27/gMi9Mxmf9c0q?=
 =?iso-8859-1?Q?mlUbdhcsyco1CgKdwaRTBaq6of+DhQsHcHj4uamk5AoF1TU1XhurnEGs+a?=
 =?iso-8859-1?Q?AoWPo6tNa+OB6FwRoxO5D4xx3V2HYnsBLeJuIMVKTB0l2JkHhI35o2rwMN?=
 =?iso-8859-1?Q?GMKAG9wJruocndrpRT5HbBcmzbVLuCaDYcUh3CxIh76Rjey6G2Jaa7PgYg?=
 =?iso-8859-1?Q?oMh+8Hf5AZZ/Imh8dkBF50HkMYLAoWvoWKlZxmn6jADzpl2ZelA9vGAMzy?=
 =?iso-8859-1?Q?PA/i2S9VRX1aGGBwiwgNqc9fAuuNddYLV3bcRTDYCwQ+aU6ENYWRobOQt3?=
 =?iso-8859-1?Q?Et6E4q88Z/xdX6iUXzpjS8Aw+Z+6f+LRWVqU7R7vfnP+kuQo1cS0WphIkE?=
 =?iso-8859-1?Q?FFryVPUcHjXCGBbU1rsaoAq38FlihX9mCzQmIQ4R4evdM2Do+Uf71nIkMo?=
 =?iso-8859-1?Q?TWkQRHu726SMshhLY9o65+OGdOihroLO/aoOi/Gdzkgpi0a8ocGq4Zyixb?=
 =?iso-8859-1?Q?uuyexp3wdAw8EmmSSqQlvkPppiRwIMmOL+fbmsgKBcIkYv5RbeuLh71nVE?=
 =?iso-8859-1?Q?NMytwIrJnD5Z6/p3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?atIPvtvheBeNWpIkeG1txemo+i//Px77g22ZAwzSARDTRSOLAtJWVtf7k8?=
 =?iso-8859-1?Q?TnnEIDCZ2mVy/RflXHezZI+dTnDwNHtnUgO2wCKW5cZrc0tkH67Ic6nQmB?=
 =?iso-8859-1?Q?2p59q2KpmX0f1jnuDcFtU8LPM+kooq6PGcMhudXAqsuzH9xlUacgf4GeSR?=
 =?iso-8859-1?Q?fP5nOWTW09mN3TPUZSr0EZNk77gdpCO37e9TrunKblvMUDz++lVq5FoQ15?=
 =?iso-8859-1?Q?TAEhwnli0ijKv1G5ejqj+QKZVZcXv69IYvQuok11orvNJJFVMlBWa1W0Fb?=
 =?iso-8859-1?Q?0zTZGJfaFM1TJxdxQhKQduMBQbpQUKMrl6S3TL+S4thOYcTQ/nYroWjSnf?=
 =?iso-8859-1?Q?fFv8MpdFoGXi7T1DDyC4yJvTMZ4Ij51prU/zfG+ROW2FngmUu+bPKZeBPK?=
 =?iso-8859-1?Q?yKfXuO5W/l2r4iOWdyDBpDMAg2z3R+o7RkVksaSbWoyDZ0abNhrURFscgG?=
 =?iso-8859-1?Q?SYah2Jl0ZKL3PbBsrlKtblUpyXqnluavUe1el/p8wi5TAmdIndSjAG3tcP?=
 =?iso-8859-1?Q?W0iCRpH65atm+6YXZVjOCF4F2dAYxbX3kpSfqXqCtMvl4OZEGgAx0IL9YV?=
 =?iso-8859-1?Q?t7gGr5VqScgBsofEo8LMze629H04sUBlNyTMpPbED1OP42kWrlWo59Dqtt?=
 =?iso-8859-1?Q?r4B8GDz89h5UEBcYAvACg9I5ahA+cxtiS2CacoP6YCCtEB3tC9uXyhPvzW?=
 =?iso-8859-1?Q?5gV/zHCYQ/sKgcpqFw7zlzMJEkbRzGpe5UqgQbb0+GVOMmSw00KHBos/pK?=
 =?iso-8859-1?Q?kWojwPZ9C/Kc57lpo+nRMiGCesFsG/qbiUtmgrPxAp+fExnpkfcUCU3puO?=
 =?iso-8859-1?Q?j3hWCmJiPXNqaaMMVf+JLOgrBZbT7eg9Rr9sayrYz1UadWVINNt+GyIky6?=
 =?iso-8859-1?Q?ZsPw8oEug/ZB0DoAMPvnlroE53+P/qCxpk4ydCrZbD8sBsCgxq+aAZd0c5?=
 =?iso-8859-1?Q?hZ2uGJBxYfOkHMexbaFXwSSN/E0Ym/2o7vsdJh7zLsjegcIiuiFyz7BH+H?=
 =?iso-8859-1?Q?aRSgWC3Px4khalHPDKhhapD8+JX7m0ZqI8khA78jsfsxpCFXdOba9290O7?=
 =?iso-8859-1?Q?wyZQWv3RkkE12qG4yD1SqGjEjqPoINMHO89SRCpMbE40wr3iarP0ZhEZ2T?=
 =?iso-8859-1?Q?sSitDCWT5iEMK44Nl/L1q3/fjpW+I7uL6mAZ/pwhXZZ+vFiFEu4b6zKXXA?=
 =?iso-8859-1?Q?NCXJSECBEW3ltKsuG7VLyDh7zBl+MD/i0rOYTO9Ba9vGZSeBEKa0UsuTEE?=
 =?iso-8859-1?Q?HhajI/Ly0BzzZnxDY+lc+fRdHkB6xGJFWCEbGMuSGG6y57cVxfGB/UuILw?=
 =?iso-8859-1?Q?Vq+LVXLvggsg0gcWhieUaY0YoLm7IB4voD8D0+ESSyH16xFvnwEjmuBXaB?=
 =?iso-8859-1?Q?AKBqkrgVoUxENj4Mo0OZyZNfLHJ8tuVk/GjrDQMm7ppLt4S0o0fYkce43+?=
 =?iso-8859-1?Q?X1Hd6Urd7XwEGEcUVXVAc9hkwnkdU+iIziO74KDzDbbxm5wuzTqkro15LU?=
 =?iso-8859-1?Q?CFGWYHknKQ32zgCyxqfUVIR8ZOJTOMvh470CuI/46xQHtSrNsz7hhjUmn8?=
 =?iso-8859-1?Q?1Lc+LdeqhoWAjHV3jYYp3b3AiENb2e/rIEAaE4qf7yLWJjUplHAiUDFuOm?=
 =?iso-8859-1?Q?/qu/pdPeIxkcs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7215a6-e15f-488b-5052-08dd574d5d76
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:39:55.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXasrnfrk4yVmjQzq8e7BXMZwFnN4HvFGPdB7LSPVPQwk+S0d2Y/MgkXKy6MIpEtt3/2dLzRVT584FClJvhX9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10363

On Thu, Feb 27, 2025 at 08:54:13AM +0100, Alexander Stein wrote:
> Hi Frank,
>
> Am Mittwoch, 26. Februar 2025, 17:31:26 CET schrieb Frank Li:
> > On Wed, Feb 26, 2025 at 01:11:37PM +0100, Alexander Stein wrote:
> > > Hi Frank,
> > >
> > > Am Dienstag, 28. Januar 2025, 22:15:58 CET schrieb Frank Li:
> > > > Add PCIe's msi-map and iommu-map property because i.MX95 support smmu and
> > > > its.
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/imx95.dtsi | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > > index 6b8470cb3461a..2cebeda43a52d 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > > +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > > @@ -1573,6 +1573,12 @@ pcie0: pcie@4c300000 {
> > > >  			assigned-clock-parents = <0>, <0>,
> > > >  						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> > > >  			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
> > > > +			/* pcie0's Devid(BIT[7:6]) is 0x00, stream id(BIT[5:0]) is 0x10~0x17 */
> > > > +			msi-map = <0x0 &its 0x10 0x1>,
> > > > +				  <0x100 &its 0x11 0x7>;
> > >
> > > Aren't you missing msi-map-mask = <0x1ff>; here? Similar to pcie1.
> > > Either way, with this change PCIe on pcie0 is not working anymore,
> > > regardless of msi-map-mask.
> >
> > Yes, it should have msi-map-mask. During my test, I have not enable enetc
> > so I have not found this problem.
>
> Just to be clear: This is not about enetc. This works fine here.
>
> > > Without msi-map-mask:
> > > > OF: /soc/pcie@4c300000: iommu-map, using mask 000001ff, id-base: 00000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > > OF: /soc/pcie@4c300000: no msi-map translation for id 0x300 on (null)
> > > > r8169 0000:03:00.0: error -EINVAL: enable failure
> > > > r8169 0000:03:00.0: probe with driver r8169 failed with error -22
> > >
> > > With msi-map-mask:
> > > > OF: /soc/pcie@4c300000: iommu-map, using mask 000001ff, id-base: 00000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > > OF: /soc/pcie@4c300000: msi-map, using mask 000001ff, id-base: 00000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > > r8169 0000:03:00.0: error -EIO: PCI read failed
> > > > r8169 0000:03:00.0: probe with driver r8169 failed with error -5
> >
> > Can you try remove iommu-map and keep msi-map? then remove msi-map and
> > keep iommu-map to check which one cause this problem.
>
> With only msi-map removed, but smmu enabled:
> > arm-smmu-v3 490d0000.iommu: event 0x10 received:
> > arm-smmu-v3 490d0000.iommu:      0x0000001100000010
> > arm-smmu-v3 490d0000.iommu:      0x0000020a00000000
> > arm-smmu-v3 490d0000.iommu:      0x000000009b0cc000
> > arm-smmu-v3 490d0000.iommu:      0x0000000000000000
> > arm-smmu-v3 490d0000.iommu: event: F_TRANSLATION client: 0000:01:00.0 sid: 0x11 ssid: 0x0 iova: 0x9b0cc000 ipa: 0x0
> > arm-smmu-v3 490d0000.iommu: priv data read s1 "Input address caused fault" stag: 0x0 r8169 0000:03:00.0
> > enp3s0: Link is Down
>
> With only iommu-map removed, both smmu enabled or disabled:
> > OF: /soc/pcie@4c300000: msi-map, using mask 000001ff, id-base: 00000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > r8169 0000:03:00.0: error -EIO: PCI read failed
> > r8169 0000:03:00.0: probe with driver r8169 failed with error -5
>
> Only if smmu is disabled and msi-map is removed the driver probes
> successfully:
> > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > r8169 0000:03:00.0 eth0: RTL8168g/8111g, d8:9d:b9:00:16:10, XID 4c0, IRQ 160
> > r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
> > r8169 0000:03:00.0 enp3s0: renamed from eth0
> > r8169 0000:03:00.0: enabling bus mastering
> > r8169 0000:03:00.0 enp3s0: Link is Down
>
> > >
> > > Without msi-map/iommu-map:
> > > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > > r8169 0000:03:00.0 eth0: RTL8168g/8111g, d8:9d:b9:00:16:10, XID 4c0, IRQ 166
> > > > r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
> > > > r8169 0000:03:00.0 enp3s0: renamed from eth0
> > > > r8169 0000:03:00.0: enabling bus mastering
> > > > r8169 0000:03:00.0 enp3s0: Link is Down
> > >
> > > pcie1 works as expected. But this is only a single PCIe device, rather than
> > > having a PCIe bridge.
> > > Any idea what's wrong here?
> >
> > Can you help dump more information at for PCIe bridge case:
> >
> > imx_pcie_add_lut(), need rid and sid information.
> > drivers/pci/controller/dwc/pci-imx6.c
>
> Just to be clear, without msi-map and iommu-map I get:
> > imx6q-pcie 4c380000.pcie: rid: 0x0, sid: 0x18
> > imx6q-pcie 4c380000.pcie: rid: 0x100, sid: 0x19

Can you help dump register value PE0_LUT_CREQID offset 0x101 for your
smmu-map or msi-map enable case

2nd test.
change IMX95_PE0_LUT_MASK to 0x1ff

Frank

>
> This function get called once for each device.
> Maybe the whole PCIe bus might help here, so I've put lspci output here as well.
>
> $ lspci
> 0000:00:00.0 PCI bridge: Philips Semiconductors Device 0000
> 0000:01:00.0 PCI bridge: Pericom Semiconductor Device a303 (rev 03)
> 0000:02:01.0 PCI bridge: Pericom Semiconductor Device a303 (rev 03)
> 0000:02:02.0 PCI bridge: Pericom Semiconductor Device a303 (rev 03)
> 0000:03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
> 0000:04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
> 0001:00:00.0 PCI bridge: Philips Semiconductors Device 0000
> 0001:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
> 0002:00:00.0 Ethernet controller: Philips Semiconductors Device e101 (rev 04)
> 0002:00:01.0 Generic system peripheral [0807]: Philips Semiconductors Device e001 (rev 03)
> 0002:00:08.0 Ethernet controller: Philips Semiconductors Device e101 (rev 04)
> 0002:00:10.0 Ethernet controller: Philips Semiconductors Device e101 (rev 04)
> 0002:00:18.0 System peripheral: Philips Semiconductors Device ee02 (rev 04)
> 0003:01:00.0 System peripheral: Philips Semiconductors Device ee00 (rev 04)
> 0003:01:01.0 Generic system peripheral [0807]: Philips Semiconductors Device e001 (rev 03)
>
> $ lspci -t
> -[0000:00]---00.0-[01-ff]----00.0-[02-04]--+-01.0-[03]----00.0
>                                            \-02.0-[04]----00.0
> -[0001:00]---00.0-[01-ff]----00.0
> -[0002:00]-+-00.0
>            +-01.0
>            +-08.0
>            +-10.0
>            \-18.0
> -[0003:01]-+-00.0
>            \-01.0
>
> Thanks and best regards,
> Alexander
> --
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
>
>

