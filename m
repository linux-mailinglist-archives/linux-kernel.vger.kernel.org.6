Return-Path: <linux-kernel+bounces-182379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2568C8A93
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE16E1F24B56
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7C913DB92;
	Fri, 17 May 2024 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DM+UMYgp"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B6F12F5A3;
	Fri, 17 May 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965821; cv=fail; b=aefkEHXQV69OPjugkyOzNjUVJ3P1kOK4C1xBrFR/hOLhjl8i5zZVPrF37MDmcxm3pao5NszwD80msoB5heeT+MepI3Pkjh44L4NlDSCoW+rRNTkB+pD9u23egwixb5OLDL/URWmHvN3D3ZwwhwIUCYgNR+H3f1vr2jnpJDOtojc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965821; c=relaxed/simple;
	bh=ZWZObo3xrMnb2GWeMXm2jeSXeYeXBgZ7i3bitHm3cb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K2/1ynml9JBmYp4FtLYTmFw4l4r+eNgfpdR11iq4eAIVjI2Xq0ujB6ZzU/0/dlZOSSZ7TTYwkoHl+3T4cnIkr+omA/MTVK2xcMt0zfjw0bBhdN83p/71EgwiqmLh5kJoJJ+aQidkWrN4TlAh4VYIpv0xaGsuObDUvNaMGaSVyD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DM+UMYgp; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gm8VGGqacwpqSsA3H+d87A+XD1P+gzJO8K2PbSZrN2ImyzGywO+nmNXLrfFjyn6C2/2HiCzoy7UutDvbUcSTNVgjJrePXG7nlllRwB6nrtbBWt59OU7kH+4dHwDodQiLlhJ6Nbkt3w8BqYqAW4e6g30H1GoMDDP71cuf+sS5nFXi9AicORi2CDUEd/Nx1qJW2yRVaGUG3LsplUR5OtbcMzHgHSOkdo06d5CMAh16sd9NzndpXj6Y6MBsIvhOE4ikUyK3m48xMt+VQ6AnmUOL1opOCvs46pN545GRnR134cKuAaWgR3ikrFCNoGeI2vpNx8kr3rUFJ5hxxJoBtX8GBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7iVaRtdlUNCuYAUgihZgQFsUqG2YU36CULyAXxeFMM=;
 b=aOksuJn6dwLywjzCFkp/zDyLXIJaGLcfJzxrngFKShkLbGnOGAOLp0zLn9KsdP3NjOG7Nj7v27ISM/sFx+5m9XSQv6fi/XoXk+u/7HbC0wh+t1ZtAhwJXcn1OEQjLotuQZMr90fasNhS1XI+1fHliegsZLn1Y4dqfidCMvXZMJHkjYbqSx0l+h3KPpewyWHi+In/cofDl7LEfBDddMpwCVb+hia2vhFF0y+5yjM21Q2a5ZZoVFggYEQqUCP8sSS9d6ERimCP0SIpLbCVXlc7zOrcP9JRGp1V533E5dJFBI/LV7xhfCNAQxy0u6wRrS7m4tDJXBx2cO4WG+76wSQU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7iVaRtdlUNCuYAUgihZgQFsUqG2YU36CULyAXxeFMM=;
 b=DM+UMYgp+OVwA9kYtWx/rP5dfN+lqwBTU7vdBcNwGNH2bFSiyNmOYnszl90v9yQAtO6RkmrrH9+aCUsqqwWN2P6+3tjBlfrj+Cwe0G395adFku8ndDUwkZFB/iRclsYGZI6KVL8CjksZ0cxfAINtJH54ZNnbbdvwWyJngqDbkfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9574.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.56; Fri, 17 May
 2024 17:10:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 17:10:15 +0000
Date: Fri, 17 May 2024 13:10:05 -0400
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
Message-ID: <ZkePbZBufOHWQdzM@lizhi-Precision-Tower-5810>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
 <1715679210-9588-4-git-send-email-shengjiu.wang@nxp.com>
 <20240514-campus-sibling-21cdf4c78366@spud>
 <b86c83a520f0c45a60249468fa92b1de.sboyd@kernel.org>
 <CAA+D8ANTdvQJVtniyMtqjnJdT4qX+LDGjVuFO6H0RSO+GDw+ng@mail.gmail.com>
 <20240515-unbundle-bubble-8623b495a4f1@spud>
 <ZkT+4yUgcUdB/i2t@lizhi-Precision-Tower-5810>
 <20240516-reversing-demeanor-def651bc82ac@spud>
 <ZkbVa5KvvbnH/tNQ@lizhi-Precision-Tower-5810>
 <20240517-gristle-dealt-56b5299b9cb8@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517-gristle-dealt-56b5299b9cb8@spud>
X-ClientProxiedBy: BY5PR16CA0035.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::48) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: 7238153a-8eed-4c22-7212-08dc7694387d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|7416005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4BgobkWp93ydKzFJEwSkVAdAZXPTZAGRKRV5w+8dr0YtyTcCUYdnJJTeHkaw?=
 =?us-ascii?Q?1TjkdCc9HScoYI0EIniWqJLhjgvgIOOzooh16ew2B/kU7ckzq3Vt+ew98WBu?=
 =?us-ascii?Q?pe5s7st091KO0039NztDLuAAnJ4EPBkjnwJHUzrKtz4JTf+E8yJdqWaJlwwI?=
 =?us-ascii?Q?Z+TjIsyKJQ6TTacJ/t4bHIeX5oZ5BN+GetCzAEvl9fam3mJO47i+1BTcrtQB?=
 =?us-ascii?Q?C4LOleB962edDFMVed6z589AVwrSD1Eo10NYBQ25m6bi6zTvkyOPmANTKDso?=
 =?us-ascii?Q?jnmNcM3dh4+UySXq2icsWwt0gjBs3xyUa/7hk/TrhC/nI5tebWP40kE9KtpY?=
 =?us-ascii?Q?hsNFNt9zHDPpFYm7KB/K4t9q7P7wMKSDFAzLG16f/6NgC++9a9p02RxaqGO6?=
 =?us-ascii?Q?Fvd2FC2E4J32//HJHGUw1m6CyKiLpRmk+Ba0oQKsejLqO6p/StNqJqdsy9qi?=
 =?us-ascii?Q?LCesc74VT9zA6VLytm+RxI0rQxdGRzkcyrm2SXfDcIGXq05uIZeXsltiSh81?=
 =?us-ascii?Q?XW6cgGLGuEP2ZZlU9YZgSPsVGw1f+tr7dv1BtVEBHOrhQa312L8Jwiq5Xrgu?=
 =?us-ascii?Q?X+m6RB70c63LrknwWlCQcefYj96Lgc04hhn0y3L4ZbXAKb0Q3oCYwwtrQdHK?=
 =?us-ascii?Q?F2uXQrBwe5mcmbPamXv8oqm3QP3K+eMCZwopjVj1XMv0/BGhoddVzsZ9SoOb?=
 =?us-ascii?Q?xwHwDmiFU+pPUnX5I0v7R1BvE9Gxvc/Qx6XQcVURCpFG7Zs2dUbE82lCO13N?=
 =?us-ascii?Q?DuqAT/1kHkYGXc6doqzZEEeBnB+uVFKCvmbIF6J4QNtDmw7j3h43VJZeCdAR?=
 =?us-ascii?Q?QbWD/wNUqt0+F9BYgTZ/B6sasHbWcU7WdpUR7ZhKArjkFaPX/SxQJREezbRC?=
 =?us-ascii?Q?1ogoky7N41M/eEZ12OU11I6mJP23zeZoBD/4Mx/3xvV3N1skqLqyRTRv6RlG?=
 =?us-ascii?Q?I10xCPcHKXYy+oL8y6h6nhTTqD3+VSdekQ07MxsraA/zW4t0yi6Cam27tfW6?=
 =?us-ascii?Q?srbkvyD/Y4HCqe7Cz/jqVZuFMe6c1q25gsCEdX7AopVxKkiNIK1O9CcTk4xK?=
 =?us-ascii?Q?Bj05AwnrPn+Hv7kzdXWRNFo7bOut3STjWrNTdzkurQgGk+sq6EXhp9oIGqQm?=
 =?us-ascii?Q?1KXDf5jn741byUW5m86+G0lf1uiRanR7cRR5Pd9rQcGtv6fEAHqdhawgV0T/?=
 =?us-ascii?Q?1d1AN3lD+7MMwjzXpbRDHwmUorpPTkHSuxOkzEf9nWxtwhsvWppMzd0OikBw?=
 =?us-ascii?Q?s03qd6dVre+DN/zVIrwayhX8jCugxsg3zdd5dimxqfn4cWI8PxjiJMrCfXjL?=
 =?us-ascii?Q?syJTc9vwH76voh8UgFuTNsUi24WNbu7VQS8CedIfMt/k7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?44zp28m4M+me6qyeLIDgIAVodim0ORr9GcwWB5a56RDE070AT4GK7wCADH2r?=
 =?us-ascii?Q?WAbgREEucKxhTUw734N7ixoLtyDtyh96Tx3nQMKLLEJnbPOWxPGnMPNTyb39?=
 =?us-ascii?Q?FOftvNw9y1gdzjzhFQRP7qmULH7s+URb2vLOEgR1ywPRQAAjqRsdk4XlcC/M?=
 =?us-ascii?Q?9K2i0ld/jiSxXfswC4RL4+oJuL1xOZf/V3TkjcQSRUBpgXszFfszD3bABKhz?=
 =?us-ascii?Q?1eBLmBtiLLCiY0Kexc57XPr/FRsHI0HegE51EwpxR5O86SCfLvkidFBjzKfe?=
 =?us-ascii?Q?V2ka6Y5JBD27Zf+VX3DXpZnC2HDblO3DA17xb7uHG/rdF0q7hY8T7LUbYlO9?=
 =?us-ascii?Q?z43dggC+XvRt5hhXTJJPNg/ysNMp+N4K/QDF00dJf3kwzXa+TXhPDSU5+Sep?=
 =?us-ascii?Q?ltBrxe7Uqm1xz91G0iZ8uC1y+54V9Cp0Hdpg526L24Az4DAlTztQODj1RbEe?=
 =?us-ascii?Q?l4exZV6Fhj12aW2P0j70E10y/sUjjDrG/AD35eaJOM8r4kLhkYuxb0q/ulQk?=
 =?us-ascii?Q?1xSbXOZU+Ggh0GsDOtgCWjKMuuAt0bxNpg1X7SGuR2afw61hR8eqt1yTG50d?=
 =?us-ascii?Q?t3WnNDxaiHewIm6aJV5zS+KAWPayTanhhilw30ICG1R+jtqIu3/49cv4o1dK?=
 =?us-ascii?Q?4qxn8aoMdJUTLkfdIN+8ZRGBiR5uXzo0UUbjPi7wz1TbDih5Z2SWJ4sm7M9f?=
 =?us-ascii?Q?8So09JbwV8NKhNJTWJtE4bCeYsMBS7Z5ywz85jmhX3lvuyNHZJoRYIh90+Ep?=
 =?us-ascii?Q?JqiE02fksiqKfpLuN9a/yD8+xjKByNklYVfMx3MeksL94q0FlD9J/lTJSsrY?=
 =?us-ascii?Q?nKRZCAXak8T4aMfi93lv3xyqmo/JkBCsvDsEOT7puNAksPjzjdrHNYTIj59Z?=
 =?us-ascii?Q?QkzIGX0az7QVjaDcAy1dVK+o3sM7/zRQq2Qq5eX21xe99HzkbZha5RuAP/MY?=
 =?us-ascii?Q?CnTkhbbIWD7Ljk8WtkxQ8A6kLLXk+vUqmN0Xi/pHeMdQ3FSrrgxIe48rU4ye?=
 =?us-ascii?Q?WPDOh5Oi/yXssNF+wuRDGScZkW0fJ5iTpCHTBr6mdZVBHOzD/aFRS3hFb+d4?=
 =?us-ascii?Q?pGHI09l8fo44kTkCtJ7asxayE332ZpzknzwTxIAbKOGEbs/RcfUDqKBMNKqZ?=
 =?us-ascii?Q?+rGmHQtO84NzQbExe/2Fv04vaI601S0mtKKkzMRo0wmTP5f9MXrCIV6KaA/c?=
 =?us-ascii?Q?mkllDgT0HPhjy2MTmiEP1av+P+4/Dg+hnVjVAuoNysT7z93vgVXZHhJ600dm?=
 =?us-ascii?Q?v05xF00JQsR2sDooUi0Qh8ZszS3wU7sPuHMwe/hRg8DYxJxJ/8Eh1gYNVfho?=
 =?us-ascii?Q?l4/9mj2jZL7FkFXCexR/iwYfBJblebA58TV9OJpyhr9fG2hff5XttOdWj59f?=
 =?us-ascii?Q?QEt+CJtBVV9+nH2LybKrl7nwXtUwZC7qFrwxnfecD7WpJQWwapP+75B4BBp4?=
 =?us-ascii?Q?tRq5bKxxZA9P0M6TO7t9wXoMu6t5wkpb64o0Xm50EHZ7Br/xpUOw6aNhwE+d?=
 =?us-ascii?Q?KNRopzzAhcMwtRi5a2l/huhm4rF8LuWLsKoCXAn95FWudOWhtkI164nZ8VtC?=
 =?us-ascii?Q?iEgJgDpPLtncwyPgky6NroA7TTbRT5EoaRkc4PHZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7238153a-8eed-4c22-7212-08dc7694387d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 17:10:15.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vg//+gR0QBthI1KKUeMh1IG103nV3En0XHG5l/oK2eAjZcmCyI3od3WI8jC7xfS0Ei4x7W9YWVTW48FUVnF+UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9574

On Fri, May 17, 2024 at 05:21:32PM +0100, Conor Dooley wrote:
> On Thu, May 16, 2024 at 11:56:27PM -0400, Frank Li wrote:
> 
> > Look like it is easy to register auxdev "reset" devices. But I have a
> > problem. How to use it by DT phandle?  "reset" devices is service provider.
> > Some client will use it.
> > 
> > Generally, reset node will used by other devices nodes. like
> > 
> > ABC: reset {
> > 	compatible="simple-reset";
> > 	...
> > }
> > 
> > other node will use "reset = <&ABC 0>".  If use auxdev, how to get &ABC
> > in dts file.
> 
> Whether or not you use auxdev or any other method etc, does not matter
> in a DT system, the consumer will always have a phandle to the provider
> node:
> 
> ABC: whatever {
> 	compatible = "whatever";
> 	#clock-cells = <...>;
> 	#reset-cells = <...>;
> }
> 
> something-else {
> 	clocks = <&ABC ...>;
> 	resets = <&ABC ...>;
> }


It goes back to old problem, "reset-cells" will be in "clock-controller".

clock-controller@30e20000 {
        compatible = "fsl,imx8mp-audio-blk-ctrl", "syscon", "simple-mfd";
        reg = <0x30e20000 0x10000>;
	...
	
	#reset-cells = <...>;
	^^^
    };

If create new "whatever" auxdev bus driver which included two aux devices, 
(clock and reset). 

it will be similar with mfd. Still need change
clock-controller@30e20000 drivers.

"Which is I suspect is gonna require a change to your clock driver,
because the range in the existing clock nodes:
	audio_blk_ctrl: clock-controller@30e20000 {
		compatible = "fsl,imx8mp-audio-blk-ctrl";
		reg = <0x30e20000 0x10000>;
	};
would then have to move to the mfd parent node, and your clock child
would have a reg property that overlaps the reset region. You'd need to
then define a new binding that splits the range in two - obviously
doable, but significantly more work and more disruptive than using an
auxdev."

So I don't know why auxdev will be better than mfd.

A possible benefit may be that Auxdev needn't binding doc for clock and
reset node devices.

Frank




Frank



