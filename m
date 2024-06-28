Return-Path: <linux-kernel+bounces-234506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C618E91C778
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163611F23369
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B13A7A702;
	Fri, 28 Jun 2024 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LUJXneGX"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A1A5381A;
	Fri, 28 Jun 2024 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719607468; cv=fail; b=Q19KAWMy3NBoAOAFyp2irBVVJdGxL0V4Z29dfrhkhaRfGVfmizNqspoae6Ox4dlEy+SUaAG4532XoKiG50yJXE7YM5/2Vb48YU+h2yuOJ463MDOvVuwgAmzvlHs3NS+I35Af4mHF9ajWMp0noNNs8qwyecTlrToGXccyWY75vNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719607468; c=relaxed/simple;
	bh=Ng86F4EgjhgHkO99aqgFXTZOJkvBlb+MorfZ6b4xXEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XEaETpHdcwgDGkA2ODo63Y0fTD33wk1W/PESqwx8kManYDdctq/I9UHtDPOz1C9hAfJwfiOdc/OxEOfOic1GKb91lqtgo568qhbanaEdqXO8u0jfw0i1cImaMptSZYwgpGJ97A/81nt9LA3jbwZmVynKcf6hA1P5BGoGkOXcUt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LUJXneGX; arc=fail smtp.client-ip=40.107.20.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhIb4A6yHEUXMTt257NXtBf4whfjdYpgJF2oY9v9UmYAi3d76TKG2qGK4VvMyvYYMLcu9GBOTWNOK/nwNORmNhTDMj8btAbbiFK+zL9fBOlktWZC+IlvQtEJLsKVGDifh3SkuylTgnNEuZBPQ8BitZ9+IhqNYwFBw9F2ZGhGi/Bmfo9NUTk2hiS2fqaiP60Oy99dkQJuozHVlgjpJv985LMzKTJgQp+vlHeWwZQOZwjqIg5Wt7QVw7iYK6dxcbxIFPL+Tr9MC28C16n6fWKu0BaPOuD7vOUl7t5E+8yTAfXFLjGoQYaUucbeXN4LQF0p0LsM93WAPK+MDsTqZHameQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SPl5/3jMEKtZ7AVqWIo+DaM+lors4QZu1x5TaFCWXs=;
 b=N22n/vv+kyoA/Q8jnU7GzXk+DnfsJcbLRHq4qDQS53jkhtbVeqWXFB+jq/RC+sQBFnEWwB099Fv0/CkfeypLjYqCxbzOca02WjQCDIL7JYHjLIna+BlMADN6EbqhVkEb2P6Fw4LokOw3001mhEXsyBlSP4CB4V+0eeJM4PI0KNDUtNLNkf+N8zZjj3XOTkVVMQ+xNfmiLxR51T7qnxUVvn99Tkw/L/ImVDa209rCxHWPShKBgQVMnTt94c40741FeLVfMrErmmtUPxNXSu53ZzaMCJt6ksxSB05jwQQHCSwBMVCqMZZllm8Re3ezXKJ2T51WPRzrXsYHMtJxheP7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SPl5/3jMEKtZ7AVqWIo+DaM+lors4QZu1x5TaFCWXs=;
 b=LUJXneGX+e4nyb/eWb3FLMl35dfO0QTlYWtrKaX2+btYBYEm00l5lwbk6m3AnRZfC+RpcXdtMmLslmvClL3sXkjFhyQERtSAillsM7H9df2eKuIBarQi1OyYgvusGyL3oIR/BFU18sJFaOPAGVEvJt1NtHu0hLb53KG1+YqZFLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 20:44:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 20:44:20 +0000
Date: Fri, 28 Jun 2024 16:44:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: clock: qoriq-clock: convert to yaml
 format
Message-ID: <Zn8gnEI7asP2w/Y2@lizhi-Precision-Tower-5810>
References: <20240617181410.921090-1-Frank.Li@nxp.com>
 <20240627202254.GA454755-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627202254.GA454755-robh@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8e02c3-4c83-45de-a452-08dc97b31620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2I4/Un6UN0kPbQhgIUeWrQmAdA8BsFfvnY4ya1uTfNRigCxtGodlvkCmeR/Q?=
 =?us-ascii?Q?MxPFGeG5NHI68+M/BntS6GUrnAAUlzp/84qZCe4UiTrQG5HrYMdB4en44+1i?=
 =?us-ascii?Q?PwQI+eLNMjV+USOhuTu9AL8gxfkSRAzJo3n6gt8g1G5Z0FUR3reF+Hc8GaNm?=
 =?us-ascii?Q?rmcK6of0AZwbxYHY6HT2ZFeL7aU3rlzSjz+dkb/TMum+oMDWUIAuQoAPrjj7?=
 =?us-ascii?Q?9N7+Cnd8voW63UClZcUiZWtLxQsrNNWMiF8f/rcVT31M5nyeFS6CU0eXKUEI?=
 =?us-ascii?Q?cU6eq3U/ATuDsBDWqKjRvSv/UQFfrRosHpSi9gJtbFOGtgrnSgEDc/4hokgA?=
 =?us-ascii?Q?DHSYyIzddXQUNa985OfvI+tWF89GuDiSaPN2n59BpX8jR6FD2+g++1rI/YiX?=
 =?us-ascii?Q?+Xv5A3kOv4uOmIcVA4FuSy1F8wY6mdLAwpimDIub/wotXEDRPB2pT4vgZw/I?=
 =?us-ascii?Q?C2JaX2+GuabdAnj8pxX0ugmgQ+1eAIgksznUHBkt11zttwqvmxUvHJJmO9tm?=
 =?us-ascii?Q?GYRQ8vjWa8OXUlaDv0VqISTfL4nOKs3jLGZaUqjWWSHI82cUCVeV7kB9kTW9?=
 =?us-ascii?Q?wSCUg30ubuvhk6Y6/Fc+WDzG7Klo8J8LYyp0ZQlUTlroVHUHNcn7CBhV9H5O?=
 =?us-ascii?Q?pf9Cpbr/Jn7qfp/nCwQ+IxrkWzlWIszupYJel2HoBCYXF5+tpGfKBxtRfJFA?=
 =?us-ascii?Q?eJzWArh0gW0ZGyT7ypkAHF+PoTQNtFGH3WZFEluy+ILVsmeVFmSHxDA++kwz?=
 =?us-ascii?Q?dAb0fOAtQerVhomsqDH3pzkBI8Y+Jmq+PMaJJcJ6loMnYMDIBwOIA2fwUEFd?=
 =?us-ascii?Q?AYTQvmH5J+w08LMLDgOOQolSTulk5mV6pfYffVcDFVHTWEnof9/spkjB/N8M?=
 =?us-ascii?Q?pRmm/eEQ7mOnL3AwfJKE98/XFWv5DCon+V0K+2XoluoNobDGgy+A+eD/UwfL?=
 =?us-ascii?Q?+5Ih4jqx/YzJQUjb+m8reTM9jIqVv8HXngq8F6NDCXQTUCiqD7cAQYDyLkm/?=
 =?us-ascii?Q?Z4933UAf3vpsw16k/UsgAJ3nuf269GRxE8Ar2jpbNpId5IsqWcQXXRlV8oW0?=
 =?us-ascii?Q?spMFV4mDrgzFfBMSwlmDqC75+e/rx6LzkP6UzMyJcGclpIHG7sJLfIVTSODm?=
 =?us-ascii?Q?lCkhAaqAB5FoXTprKgr77p0F+hrGfNZvDkoIrVYR4+HUfQK8ktwJcy/oDfxN?=
 =?us-ascii?Q?4px2a6BcFnWIhpW6s1DSBzMF89EB+7vQFlIOci1f/tUj0i36+HlfP4inwYGB?=
 =?us-ascii?Q?W9sfThqIv3V/g2zpq0VyxK6v8FjZXjdTmM2/48XMwmfz6pSTUjQWOHDP+xu+?=
 =?us-ascii?Q?zonvERYDhW1KIdmf3+L/rOFoHgl62hqdgN8oOclcwA5KhB22R7XQ8078x86E?=
 =?us-ascii?Q?I3597g0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hp5qaxd9tvNSCtQY2SwuwQ5FrQ8L2bkppp/y4QTRht97G796tOR8oCmkriRx?=
 =?us-ascii?Q?gFGQREFy3y+CfhHg6Hx7rmIGieT0zka2M2poLThwIQktZDsOObGplcs3Z5k3?=
 =?us-ascii?Q?cLA+3JpqHWy+WLY6J2deAuZ8bqaXACYR9NceiltqVJ1znk5v0606+eQ1i5k4?=
 =?us-ascii?Q?Pdy5zVPc7arnnA8hKK3JR/WOw+IJrFJuOFlBIjNYqKhChzku7KGNaBuhZiwa?=
 =?us-ascii?Q?vV+nuQQWQYiAZFBuer477XzYqrXy4qTusgeosYfgB+B3eFkMCMG9OwbdX7ea?=
 =?us-ascii?Q?2hEuaMhnUNMcK2SQyc4ehMZ/u+iPp26sdAPsZdyccddxY+0jWwRN45LcBA32?=
 =?us-ascii?Q?Wuw1fULQc2AAtVWGZKZN9pMG8VAQsSdnc6QTp2ya+xhA1BUNOmcIZGfg1+gr?=
 =?us-ascii?Q?pqTyFImK3RRemCHZ8jb+5iXjihMsqlr7ofFlrfx3xdgzkrYlXpbrhI2iSHas?=
 =?us-ascii?Q?GT6xTyeOxZMGi/f0Oa4XyqjTc/1737rNlf6NrzaR6MSWKtJJM3m1NjScLeJF?=
 =?us-ascii?Q?DaEPkIbdBFrHnOHVpEZokMxMruW+gS7L9GgnJeUqPBzltBXn/Kw+7ncNJAyH?=
 =?us-ascii?Q?cpHrC3v94dfq1nb3KylOJbNxKSlpP+a575ERENUK3/rzSVe/bfUqzr/Xm1S2?=
 =?us-ascii?Q?noJsb3m0AQ4AoqpmUrnyynsG9TGr5sGsnjg75QADKOQoG9nP/H1ZCQ3NALe+?=
 =?us-ascii?Q?jheHWL1TT+DPvWjsNUHhQrkxoXjeEt3Dxtpyp2OUv3KcaRoZgqbPjO7xbRqV?=
 =?us-ascii?Q?CpALkYC+VJfmt7h9Ac0AKCNn0vFN2own5YG/EX8IgiXGJjOeDEIeK+iJUC31?=
 =?us-ascii?Q?q6Vr2cjgJS+b8mBh1Xs6F5skyMvJGjELhbSPFQJYXK0vmZv6UYKsT6Lmc1sl?=
 =?us-ascii?Q?mo+Gyf3f60Mo7MQsecnPzHh92In8jUOeBrgDrgEkMIosFiAOFg7IfGup9dNf?=
 =?us-ascii?Q?MY9+EQxZRCsPPPFaMInO/rC7bcBnjesvrgVmjECOn2E7NyFzHQZste+OkNfv?=
 =?us-ascii?Q?1ZhlWUTdviz13lIFLf743Az9j84mP+wFQQ/XEyxd2Y9TuBaKtjcq1SSr117M?=
 =?us-ascii?Q?m6HreoGAPZaff30pCbG5G8OCphhel7tPPd31ytarBKiptT+XHezR/Rq7Zi7g?=
 =?us-ascii?Q?QcIvw+qkm7fK1H10BOnSz9thDAV5K8+3OxRQIqpgzSQbCVjeP2eV2ImdDZcT?=
 =?us-ascii?Q?rq+p3nkmUDSQZPGlymo+vl8ful7KCOzAf1ljbmWyKyJdvg20TIef0xTgXaWX?=
 =?us-ascii?Q?l14EMiUYVmVBiCs0LVdGM7fFXBQyp36EloyaFPqwJMiYXFApc6ClWVEbRDMv?=
 =?us-ascii?Q?poACThbJTOxDgDzV1tTPyIMIDjhCj/0BnX04JbZeF07YRKLficrGGKBqV8Cx?=
 =?us-ascii?Q?T7wl65/Cia7Jb630geOTJPL46b4lUUaPvNNoTXaGwUoLjsAqSHB47gFZBDCI?=
 =?us-ascii?Q?i/8EnZ/0DGSMGW+fME1ziL3MvvidtXOahenl6ShKrzpYPGNKIo1/KOKd+f4B?=
 =?us-ascii?Q?WTNGf9btor3qpww/ZBHk51MxWJ59CSVymIOE3fbm7YTUVp1Iy7KQOIk7bwye?=
 =?us-ascii?Q?eWuBiT/TCO0meALmJhepXrzO+5xxivH+r0RG8nlq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8e02c3-4c83-45de-a452-08dc97b31620
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 20:44:20.7078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7xDD7+8vuCLNjTkiY0ncesHlc9o6cwzLQ3pIZN299yH4Zwg5ldZgURTfR7C/fLJSUo8uhr+egsQHY8B2wvdbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104

On Thu, Jun 27, 2024 at 02:22:54PM -0600, Rob Herring wrote:
> On Mon, Jun 17, 2024 at 02:14:09PM -0400, Frank Li wrote:
> > Convert qoria-clock DT binding to yaml format. Split to two files
> > qoriq-clock.yaml and qoriq-clock-legancy.yaml.
> > 
> > Addtional change:
> > - Remove clock consumer part in example
> > - Fixed example dts error
> > - Deprecated legancy node
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../clock/fsl,qoriq-clock-legacy.yaml         |  84 +++++++
> >  .../bindings/clock/fsl,qoriq-clock.yaml       | 203 +++++++++++++++++
> >  .../devicetree/bindings/clock/qoriq-clock.txt | 212 ------------------
> >  3 files changed, 287 insertions(+), 212 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/fsl,qoriq-clock-legacy.yaml
> >  create mode 100644 Documentation/devicetree/bindings/clock/fsl,qoriq-clock.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/clock/qoriq-clock.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/fsl,qoriq-clock-legacy.yaml b/Documentation/devicetree/bindings/clock/fsl,qoriq-clock-legacy.yaml
> > new file mode 100644
> > index 0000000000000..97b96a1a58254
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/fsl,qoriq-clock-legacy.yaml
> > @@ -0,0 +1,84 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/fsl,qoriq-clock-legacy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Legacy Clock Block on Freescale QorIQ Platforms
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +description: |
> > +  These nodes are deprecated.  Kernels should continue to support
> > +  device trees with these nodes, but new device trees should not use them.
> > +
> > +  Most of the bindings are from the common clock binding[1].
> > +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,qoriq-core-pll-1.0
> > +      - fsl,qoriq-core-pll-2.0
> > +      - fsl,qoriq-core-mux-1.0
> > +      - fsl,qoriq-core-mux-2.0
> > +      - fsl,qoriq-sysclk-1.0
> > +      - fsl,qoriq-sysclk-2.0
> > +      - fsl,qoriq-platform-pll-1.0
> > +      - fsl,qoriq-platform-pll-2.0
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 4
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 4
> > +
> > +  clock-output-names:
> > +    minItems: 1
> > +    maxItems: 8
> > +
> > +  '#clock-cells':
> > +    minimum: 0
> > +    maximum: 1
> > +
> > +required:
> > +  - compatible
> > +  - '#clock-cells'
> > +
> > +additionalProperties: false
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,qoriq-sysclk-1.0
> > +              - fsl,qoriq-sysclk-2.0
> > +    then:
> > +      properties:
> > +        '#clock-cells':
> > +          const: 0
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,qoriq-core-pll-1.0
> > +              - fsl,qoriq-core-pll-2.0
> > +    then:
> > +      properties:
> > +        '#clock-cells':
> > +          const: 1
> > +          description: |
> > +            * 0 - equal to the PLL frequency
> > +            * 1 - equal to the PLL frequency divided by 2
> > +            * 2 - equal to the PLL frequency divided by 4
> > +
> > diff --git a/Documentation/devicetree/bindings/clock/fsl,qoriq-clock.yaml b/Documentation/devicetree/bindings/clock/fsl,qoriq-clock.yaml
> > new file mode 100644
> > index 0000000000000..d641756b04635
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/fsl,qoriq-clock.yaml
> > @@ -0,0 +1,203 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/fsl,qoriq-clock.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Clock Block on Freescale QorIQ Platforms
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +
> 
> Just 1 blank line
> 
> > +description: |
> > +
> 
> drop blank line
> 
> > +  Freescale QorIQ chips take primary clocking input from the external
> > +  SYSCLK signal. The SYSCLK input (frequency) is multiplied using
> > +  multiple phase locked loops (PLL) to create a variety of frequencies
> > +  which can then be passed to a variety of internal logic, including
> > +  cores and peripheral IP blocks.
> > +  Please refer to the Reference Manual for details.
> > +
> > +  All references to "1.0" and "2.0" refer to the QorIQ chassis version to
> > +  which the chip complies.
> > +
> > +  Chassis Version    Example Chips
> > +  ---------------    -------------
> > +       1.0      p4080, p5020, p5040
> > +       2.0      t4240, b4860
> > +
> > +  Clock Provider
> > +
> > +  The clockgen node should act as a clock provider, though in older device
> > +  trees the children of the clockgen node are the clock providers.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - fsl,p2041-clockgen
> > +          - fsl,p3041-clockgen
> > +          - fsl,p4080-clockgen
> > +          - fsl,p5020-clockgen
> > +          - fsl,p5040-clockgen
> > +          - fsl,t1023-clockgen
> > +          - fsl,t1024-clockgen
> > +          - fsl,t1040-clockgen
> > +          - fsl,t1042-clockgen
> > +          - fsl,t2080-clockgen
> > +          - fsl,t2081-clockgen
> > +          - fsl,t4240-clockgen
> > +          - fsl,b4420-clockgen
> > +          - fsl,b4860-clockgen
> 
> > +          - fsl,ls1012a-clockgen
> > +          - fsl,ls1021a-clockgen
> > +          - fsl,ls1028a-clockgen
> > +          - fsl,ls1043a-clockgen
> > +          - fsl,ls1046a-clockgen
> > +          - fsl,ls1088a-clockgen
> > +          - fsl,ls2080a-clockgen
> > +          - fsl,lx2160a-clockgen
> 
> It doesn't look to me like these platforms use this binding.

It should be used.

git grep -r "a\-clockgen" arch/arm64/

arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi:                 compatible = "fsl,ls1012a-clockgen";
arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:                 compatible = "fsl,ls1028a-clockgen";
arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi:                 compatible = "fsl,ls1043a-clockgen";
arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi:                 compatible = "fsl,ls1046a-clockgen";
arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi:                 compatible = "fsl,ls1088a-clockgen";
arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi:                 compatible = "fsl,ls2080a-clockgen";
arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi:                 compatible = "fsl,lx2160a-clockgen";

Frank

> 
> > +      - enum:
> > +          - fsl,qoriq-clockgen-1.0
> > +          - fsl,qoriq-clockgen-2.0
> 
> This allows invalid combinations. You need 2 entries splitting 1.0 and 
> 2.0.
> 
> > +    minItems: 1
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  ranges: true
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 1
> > +
> > +  '#clock-cells':
> > +    const: 2
> > +    description: |
> > +      The first cell of the clock specifier is the clock type, and the
> > +      second cell is the clock index for the specified type.
> > +
> > +        Type#  Name       Index Cell
> > +        0  sysclk          must be 0
> > +        1  cmux            index (n in CLKCnCSR)
> > +        2  hwaccel         index (n in CLKCGnHWACSR)
> > +        3  fman            0 for fm1, 1 for fm2
> > +        4  platform pll    n=pll/(n+1). For example, when n=1,
> > +                          that means output_freq=PLL_freq/2.
> > +        5  coreclk         must be 0
> > +
> > +  clock-frequency:
> > +    description: Input system clock frequency (SYSCLK)
> > +
> > +  clocks:
> > +    items:
> > +      - description:
> > +          sysclk may be provided as an input clock.  Either clock-frequency
> > +          or clocks must be provided.
> > +      - description:
> > +          A second input clock, called "coreclk", may be provided if
> > +          core PLLs are based on a different input clock from the
> > +          platform PLL.
> > +    minItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: sysclk
> > +      - const: coreclk
> > +
> > +patternProperties:
> > +  '^mux[0-9]@[a-f0-9]+$':
> > +    deprecated: true
> > +    $ref: fsl,qoriq-clock-legacy.yaml
> > +
> > +  '^sysclk+$':
> 
> This means 'sysclkkkkkkkkkk' is valid.
> 
> > +    deprecated: true
> > +    $ref: fsl,qoriq-clock-legacy.yaml
> > +
> > +  '^pll[0-9]@[a-f0-9]+$':
> > +    deprecated: true
> > +    $ref: fsl,qoriq-clock-legacy.yaml
> > +
> > +  '^platform\-pll@[a-f0-9]+$':
> > +    deprecated: true
> > +    $ref: fsl,qoriq-clock-legacy.yaml
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#clock-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    /* clock provider example */
> > +    global-utilities@e1000 {
> > +        compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
> > +        reg = <0xe1000 0x1000>;
> > +        clock-frequency = <133333333>;
> > +        #clock-cells = <2>;
> > +    };
> > +
> > +  - |
> > +    /* Legacy example */
> > +    global-utilities@e1000 {
> > +        compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
> > +        reg = <0xe1000 0x1000>;
> > +        ranges = <0x0 0xe1000 0x1000>;
> > +        clock-frequency = <133333333>;
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        #clock-cells = <2>;
> > +
> > +        sysclk: sysclk {
> > +            compatible = "fsl,qoriq-sysclk-1.0";
> > +            clock-output-names = "sysclk";
> > +            #clock-cells = <0>;
> > +        };
> > +
> > +        pll0: pll0@800 {
> > +            compatible = "fsl,qoriq-core-pll-1.0";
> > +            reg = <0x800 0x4>;
> > +            #clock-cells = <1>;
> > +            clocks = <&sysclk>;
> > +            clock-output-names = "pll0", "pll0-div2";
> > +        };
> > +
> > +        pll1: pll1@820 {
> > +            compatible = "fsl,qoriq-core-pll-1.0";
> > +            reg = <0x820 0x4>;
> > +            #clock-cells = <1>;
> > +            clocks = <&sysclk>;
> > +            clock-output-names = "pll1", "pll1-div2";
> > +        };
> > +
> > +        mux0: mux0@0 {
> > +            compatible = "fsl,qoriq-core-mux-1.0";
> > +            reg = <0x0 0x4>;
> > +            #clock-cells = <0>;
> > +            clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +            clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
> > +            clock-output-names = "cmux0";
> > +        };
> > +
> > +        mux1: mux1@20 {
> > +            compatible = "fsl,qoriq-core-mux-1.0";
> > +            reg = <0x20 0x4>;
> > +            #clock-cells = <0>;
> > +            clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +            clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
> > +            clock-output-names = "cmux1";
> > +        };
> > +
> > +        platform-pll@c00 {
> > +            #clock-cells = <1>;
> > +            reg = <0xc00 0x4>;
> > +            compatible = "fsl,qoriq-platform-pll-1.0";
> > +            clocks = <&sysclk>;
> > +            clock-output-names = "platform-pll", "platform-pll-div2";
> > +        };
> > +    };

