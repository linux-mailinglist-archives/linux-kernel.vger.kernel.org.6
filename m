Return-Path: <linux-kernel+bounces-182566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4B98C8CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A9E1F23AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AEA1411C8;
	Fri, 17 May 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FyrhNw1u"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560613FD83;
	Fri, 17 May 2024 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715973910; cv=fail; b=ku0kkB1be2e547f8aWjMJYoDB4Q98nlMAVUIF9LY+5MxVGFd23ocah96sANTg2CQsUzjfT2QTEsX4oL5NLC7T5EowiMCpJlVPl47FYCXC7KcGCQ9aJLZNAIXlWBlDoGkMn1JPNGGqeJ1lHoVLDp4uLhVxaDsrKr9y8pp0jefeVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715973910; c=relaxed/simple;
	bh=CLRf+Kr+QmLTyuPaIQ09C2e6GBZjGKwy8c0Yn4//6SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d400OcZOtFbAh964fJgDVnSbhw14O4A51mg+PZX/JKeyXHny/JLRo8w/DtE2PPtOhV6MvNjXE9lDckh8vBp2L94bv+8sL2JsbadMc1GK3IB9MMMwPPcyqMNw5h7KeWSVHe1x70HbxUYB0cP2xzCISa5f4WF8SwaeJqOIXVuoLiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FyrhNw1u; arc=fail smtp.client-ip=40.107.7.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gn0yfGg1zAajMS9Y6Wn+Xy0RmRLi3PyGLt00iA6ifgjQQlB0N5lmy20bG/bzTHQ/BJ4kyk10+1ZStwE8n20iN/PrZZwSOCwQg+0X7llnYaOckhoUEFC1hrmsKlYtlCOt9FdlE05KDFRnOzsUn/rv61sOvCJHFVbHr5cl6YvhZNSNJIKEoaCL1/dB6giNfCTKppng/vyzrGq2qdjT+jhong222lPqfDw2m1Upz7qR0RynLYAXcluZZLd+eUcx60aWcgA6H5GhXXCi89B/PFXjK3PIip91fZaHWeveGdx1sEeWvyxJzDC0abXdFoMjYh+kdAcjLiiWOMZ+nvF2trFLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD7ZI6DIkUsoCV1cpB4KtXW+p7Dwj5Fos3jh2ejJaS0=;
 b=TuUWj9TFda2d7z/tbmw9pVmrOKjkG7uv21dsMhICQ8IJCPvgpbxYfRWbTLyr7j6m2gmsg14rO6jKDNhzF7y73wDfvus7e3RU66q+2Jplx7VtRWPh3FaM5zXHCP32LAkPALcNzQDKCfYFZL5yeN9hLiH9zaH7TnEONwRpX0r0zYBIxbmmqjrpPyDPG10WcW4d7DQZfgF0owxDmOcV1VQ3ouzneUaNkFLCQPVu98kVNuf62In9qQP8zG+8rjjbQp+XGThi19EWvRDQUXCl19sCfkowFvTlnVd//BIch02lVfKvuyL5GlgnQrnrg/IKArcqXXHWRKTGKNFMtz60eJt53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD7ZI6DIkUsoCV1cpB4KtXW+p7Dwj5Fos3jh2ejJaS0=;
 b=FyrhNw1u7OdzxZ6idZAk7a0P7uLyz72uj0aloCRH1fcbui+t6oWh/8k7f0fVEpNieYDWNlOBr+/Tn09Veu4QS31osgGLYblqTXROeDH7DnEIvqo9xIw8gMEW8PdUYp6wCVIf6iGOUbOcLSyB0Q/IqFCwCq05FmKvWv+RlBdiTUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 19:25:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 19:25:05 +0000
Date: Fri, 17 May 2024 15:24:55 -0400
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
	peng.fan@nxp.com, mturquette@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	marex@denx.de, linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH v3 3/6] dt-bindings: clock: imx8mp: Add reset-controller
 sub-node
Message-ID: <ZkevB4ayrYh3qMHu@lizhi-Precision-Tower-5810>
References: <20240514-campus-sibling-21cdf4c78366@spud>
 <b86c83a520f0c45a60249468fa92b1de.sboyd@kernel.org>
 <CAA+D8ANTdvQJVtniyMtqjnJdT4qX+LDGjVuFO6H0RSO+GDw+ng@mail.gmail.com>
 <20240515-unbundle-bubble-8623b495a4f1@spud>
 <ZkT+4yUgcUdB/i2t@lizhi-Precision-Tower-5810>
 <20240516-reversing-demeanor-def651bc82ac@spud>
 <ZkbVa5KvvbnH/tNQ@lizhi-Precision-Tower-5810>
 <20240517-gristle-dealt-56b5299b9cb8@spud>
 <ZkePbZBufOHWQdzM@lizhi-Precision-Tower-5810>
 <20240517-afterglow-sandstone-076e593fedf8@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517-afterglow-sandstone-076e593fedf8@spud>
X-ClientProxiedBy: SJ0PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: d401da57-fa01-4ae0-171b-08dc76a70e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|366007|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HC6t7qWxbzbTjVCXRObN7cSFC1/yJldIQ+k7GrF1Ejs1LxyhJu/VXrJltWUa?=
 =?us-ascii?Q?5NQS7kkLS1Z3Cm4nBGe58/w6xSyN+X1QTDCrcpqwMJKFqvylbtcT1MN2EQUo?=
 =?us-ascii?Q?xXjQTteJ2DFlv5SUa7Si+2BwPn/WMbhbUdf5AyB0vvqXPnGCZmCYeew6sgQ2?=
 =?us-ascii?Q?2JtCVUttTaY13pXATUEGICrPHxhuMM8CswaEjtGxiX/uNgFajD2B9KbznOO6?=
 =?us-ascii?Q?Uenj4KEAZEGeHM72dRt0tUyi+ureCOplKYxakM+csEzByAVk4lskuDK4F0PR?=
 =?us-ascii?Q?XUC/voxAy0KAbuhgKvTcvb0phNk7ZUC4gs5dZM180VZ3QOq80s8Tmjp3tL9L?=
 =?us-ascii?Q?4MyVmiUS7WwjrBdPjZFy/MZ5J4O8Hm0kDV+GID/WgZ1AfJtO69/8WRwjK0Bq?=
 =?us-ascii?Q?QYXlZ4QZoBBhziXQgsar2u1aumh0UXXfkfVLrkX/izHseJbJjWyctDRVcf9a?=
 =?us-ascii?Q?KnaYQCyIVB7jdjmvtUaA+xxAiFaR/qMwefLbZEpf1aaeUOa8tEOHFLYe+OPq?=
 =?us-ascii?Q?2CaH6IO9JLLSicNwEZn1PWBEh/8jPTfWEKXTilLnvXxUsWP8oEPot0ffVeHW?=
 =?us-ascii?Q?4y1OIRGFvLSjksljFx0KLBqhPwOfq+OLsZezDtLYcGOmhPggZ9Zo/98CSYZi?=
 =?us-ascii?Q?xxRuiA56U1hRbXnMeKWla8ZyPaeA5MetMkyk1OCSBeXoTXQFnh2kS9gmyW9k?=
 =?us-ascii?Q?QZOC8HSJfLwmlLlSJsrZJcKn0fygoEbuCtKsqdKD5h4ElymYuc9tyiFR7dsB?=
 =?us-ascii?Q?C31Mp9zr9FK+5tl7xzARbrOEzYbX5F+Nqj+YEPoLYiaa5XAturNCOTrvXg9+?=
 =?us-ascii?Q?a8YSEU4bSJ3Z0LFt7KcwfOcDnZgYCR5jxrdet5eeyhRNEiUzcXH7/H4n+uK9?=
 =?us-ascii?Q?J1PWfLEla0SjWXWr5ZmH2OsHZI35qSE/dqzEfq3Y/LUK+OMMbAj/Hf79u0mt?=
 =?us-ascii?Q?sp/T/whySUahYUbxNPTt3khAHRiP8y2SI9ZbSHWZU59O4130e1pcA/Rt1cY/?=
 =?us-ascii?Q?+VvsUn8LlsvTdW7Yt95heHrOAFsmm3xRvPiwLr9y2ehcwfk2hbZGCRZBHErT?=
 =?us-ascii?Q?JBBkCvOO3btzPHOmR81W5wLGEle6PtkLpO40UoMzXHA3h1ONSsM2UzJ7GH7M?=
 =?us-ascii?Q?d1Bziv8QjGPmgAOSfMtKSNhj4eStqSt7QWqZGvoSrJqyoyth2rEsSlQRa/CY?=
 =?us-ascii?Q?aWLHVVNXjN5APx1X/ETBJbzC0zMO46BZHfYkRWL4Tao3U3cXu3amC+49QAKb?=
 =?us-ascii?Q?P0gg441UKKNjvSGvoXaZyAsKNLlCmttnyF021qLUzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZnRyq2SjaVLm4eCykljM5nXDKhOp5UgrTO09MLLDryOOH/13noS+/r1I/JHH?=
 =?us-ascii?Q?Uscn1Lac6s/cFaFKkZb9lJbQXEo3rs/H1US2OauKzP+7JGmPV3LjdkEauuyn?=
 =?us-ascii?Q?Jemt5uL4jFm1Judwa0ETsdzNi2aWY7tFLDTlIdinGDE9j5xeP4PfbnGDnyjk?=
 =?us-ascii?Q?qsg/VmCcHl2ox7TkVNm+OBh23u5WGPgl1sZTQVNJKu60mq7HJx0zXdQy/UgQ?=
 =?us-ascii?Q?vQgqlq8ghC5e6jktCNsOfmYqcRZF0WDZmTYX7o8CRqXM3e9FqTOSEZIrJJ+Z?=
 =?us-ascii?Q?LpgutGArRfdjKwJje4ahhpfnvEfrO5QE8ymBaXtHF5/uFxjnf5oxjUVE0KXl?=
 =?us-ascii?Q?+c0+oySbb68HiHCqQKx8SV+oeep+Ks7y3msqdVljQqMkcC04FpED75uSFlM8?=
 =?us-ascii?Q?Z8QGM9sWRPCBMEKGTTpedAp9tGIVA4mkB9QAAjrEXPeMgofKQ5OHuJM8aIYV?=
 =?us-ascii?Q?f1eTSMHEjCf2CaWsPdT+vnqB///uTvat9NrLE0adv4YFAjcXydXL/vXnEN46?=
 =?us-ascii?Q?cAlCne+Py+ozuh4IWHLQOrXMok6AfUcjaxL0BFV0eI+gIBhTVwpn9LeBYhvh?=
 =?us-ascii?Q?n0UBjtnVsHa2YB0pGiKb5Cd/Omeq9iup/crHpLD+qq3FWqLP0oMU79HuzzES?=
 =?us-ascii?Q?wTOf8AE9cInf9kWa2QSgrI2eH4smzmS5uf53CoUN3m0w/4lUSkHAfxBamlQ2?=
 =?us-ascii?Q?cpZ4YVdoqkaZgpc7EtNfYCkscYKALoQ5Ie3K05skC27m41KoqL3MUNGWUoQg?=
 =?us-ascii?Q?YccmqhQnGisk5z47hjLlYuLl78hxPuhjnPWXk81AIxr/TSIuwt8cndBL0OF0?=
 =?us-ascii?Q?M+i5XmLRjRQmktT+VbyrQdPOeewcDuD7U+RuXkuOcPwl65Dmql6jhL0LbxQt?=
 =?us-ascii?Q?WZNCr5AUO0D/Frmuu347Xo1kql6CseHe9MHpOxkfEolCi/Bkf3yXJnid7D3U?=
 =?us-ascii?Q?Trk5gMETm2dXAdLjFwhukqMMxRHE2i0Pa3FMvX6OjVggO/Hjc7rF9nHG7paw?=
 =?us-ascii?Q?RvuzWLONRxLvJDABWFealHkOIcVc4pefGiUWk+Sqs04UwJ6Ni22T/+DGrwHe?=
 =?us-ascii?Q?kZNpdBXnMSC5BZ/stmk/IWxBtQmGB8LL8pXf/BKA8R3TFYWeWPnZDbPtuxA4?=
 =?us-ascii?Q?lRWaIHd0UpbIAgJWikkuCNR7MYa03DDWEIrr14Adsz2072gb4GZKTc3WwdX5?=
 =?us-ascii?Q?fTseryxdR6OoSU/YX5ZQ6TNKB8otPNa959uxh+ysXtmzVd5549as+BbOuyVt?=
 =?us-ascii?Q?dFY3z4UJ4YgAF+YiTJEp6AWYBPrjtI9njDRqm/EbccTAVDchBYuruVMfBL97?=
 =?us-ascii?Q?Xp16U91WfFKbBQkv41FxchTmsiouCacbxYVPFnUw9jqj/O/9vdr21aVlRQSx?=
 =?us-ascii?Q?BsChrtZr5dRGKg8AedhSpEc+t3BgvY87Ws4B5bCY659qAUX/AKH1vVf/ixo/?=
 =?us-ascii?Q?kGcWTHsWXsvZ4pa27tsyg6KN6LadG1qvWgMibnbDyc3bOfa8oRvzIYuu7wPI?=
 =?us-ascii?Q?5RJhOhBW4EnRPghpAbmPeof/vIWF5BNAifD+LqCZMpMKof8cXb7WLfnDd/C6?=
 =?us-ascii?Q?6KH4w+nxbozmb/ZyqnhxeZ/lAeP0ThthQ63hwYN1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d401da57-fa01-4ae0-171b-08dc76a70e69
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 19:25:05.4133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5flTBVNtTztS4X8Cuelr+vCj6ajCjw4wkZobVLGpnnoXlKu7sdJUsO6nL1xMvnMwSkBOpmcLUKEM4fpUQOxFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197

On Fri, May 17, 2024 at 06:13:21PM +0100, Conor Dooley wrote:
> On Fri, May 17, 2024 at 01:10:05PM -0400, Frank Li wrote:
> > On Fri, May 17, 2024 at 05:21:32PM +0100, Conor Dooley wrote:
> > > On Thu, May 16, 2024 at 11:56:27PM -0400, Frank Li wrote:
> > > 
> > > > Look like it is easy to register auxdev "reset" devices. But I have a
> > > > problem. How to use it by DT phandle?  "reset" devices is service provider.
> > > > Some client will use it.
> > > > 
> > > > Generally, reset node will used by other devices nodes. like
> > > > 
> > > > ABC: reset {
> > > > 	compatible="simple-reset";
> > > > 	...
> > > > }
> > > > 
> > > > other node will use "reset = <&ABC 0>".  If use auxdev, how to get &ABC
> > > > in dts file.
> > > 
> > > Whether or not you use auxdev or any other method etc, does not matter
> > > in a DT system, the consumer will always have a phandle to the provider
> > > node:
> > > 
> > > ABC: whatever {
> > > 	compatible = "whatever";
> > > 	#clock-cells = <...>;
> > > 	#reset-cells = <...>;
> > > }
> > > 
> > > something-else {
> > > 	clocks = <&ABC ...>;
> > > 	resets = <&ABC ...>;
> > > }
> > 
> > 
> > It goes back to old problem, "reset-cells" will be in "clock-controller".
> > 
> > clock-controller@30e20000 {
> >         compatible = "fsl,imx8mp-audio-blk-ctrl", "syscon", "simple-mfd";
> >         reg = <0x30e20000 0x10000>;
> > 	...
> > 	
> > 	#reset-cells = <...>;
> > 	^^^
> >     };
> > 
> > If create new "whatever" auxdev bus driver which included two aux devices, 
> > (clock and reset). 
> > 
> > it will be similar with mfd. Still need change
> > clock-controller@30e20000 drivers.
> > 
> > "Which is I suspect is gonna require a change to your clock driver,
> > because the range in the existing clock nodes:
> > 	audio_blk_ctrl: clock-controller@30e20000 {
> > 		compatible = "fsl,imx8mp-audio-blk-ctrl";
> > 		reg = <0x30e20000 0x10000>;
> > 	};
> > would then have to move to the mfd parent node, and your clock child
> > would have a reg property that overlaps the reset region. You'd need to
> > then define a new binding that splits the range in two - obviously
> > doable, but significantly more work and more disruptive than using an
> > auxdev."
> > 
> > So I don't know why auxdev will be better than mfd.
> 
> I think Stephen and I have spent enough time trying to explain why using
> auxdev is beneficial here. I, at least, won't be wasting any more of my
> (metaphorical) breath.

Thanks for your time. After I did more rearch, especially read your
previous patch:
https://lore.kernel.org/linux-clk/20240424-strangle-sharpener-34755c5e6e3e@spud/

I have better view about auxdev.

Frank

> 
> > A possible benefit may be that Auxdev needn't binding doc for clock and
> > reset node devices.
> 



