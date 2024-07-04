Return-Path: <linux-kernel+bounces-241391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD62F927ACD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E436E1C22A92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140491B29BA;
	Thu,  4 Jul 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vj4hTvFP"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011042.outbound.protection.outlook.com [52.101.70.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AAC1A0711;
	Thu,  4 Jul 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720109059; cv=fail; b=X+Q+UnYVTpa+XoJFG181+MkxrfvaG8rKnuw1TrFd8TYk4SvX60WP/afJQdZNttmqvqKRScsiRuKJWF12AH+Ie9a4WIH8SjkdDXRyhYrCwkOB4kcsnTeSlqWUrrstP5ci83/ViDfG2ebq8kMKVOpgou64zlsx1Lrb1AiwfGL2ez8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720109059; c=relaxed/simple;
	bh=BjQlVg+ssnCIAHQnbWitnmRVo3Ac3xkobPbeHUVyzTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JtoyXrGW/imO+pyz1BuYHNy9HRy2Tn+2DxlhDdeio+S52I1P506w0CbyAsvD+LM0qgwybeqKrwRdkMOEqw9X1Lnrg5OczcctkTmSKV4Jgkojzz7q81KAFUlGDU+RUK1pnVXOOTpAZ5PgQW1gFVEFhm/c54md/e6Ak1T3lrNiNek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vj4hTvFP; arc=fail smtp.client-ip=52.101.70.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEc8bMB9iWGBvNExHLl89yyqmhLDXXZDbhzyZJpXI9q2q93tNzwvew8PHsbVRKxvC/leBrtfeE+MZ2BiTmDFIput+20eQRp6nEL3UK2xK/F6ojf6kDF5uq6FKX6RiiW0aSuaYKTCbscFhOnLyn9BWjI39XdyH5OyD2LfYUFicp5JbUo5xn+qhW30gA+S58nhU9DZTbs4CphUZn3Fv2mRaapuQO6hFumdnu2yLWFbW7kGYVXqyaasp3Wsc0KfBnvV5X5DXv0S/5s2oBDHKist21M41JwYGbeovmjnOxnoP6bWVNUAPy2n7L8Z/tqE3zGsp/TodDH0toME9q3dvkVyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1m8xzz51t2Rrix4gydZt86M8+QTWaQ5mQAclHA1LAM=;
 b=OfrL0FQgBIVjaUv9Q6XABAk167WKvBkx4wGviscWtWF1asanmbFtg3ueLEI3wTcTj8SSzENuBtfHenOf+9Vywr+8+B4bph+KD1v59cYfESUT70ZLjQ6a+AoiDLtR3YgWL/h+1GxxUzOpL6G/uIrBvJLgmprFL9xc6aQG2kSSJDwRUoYjKvajboZ1ZANrWff91sKEb98Pf7cfX5wGQrpqgCdjnC7mI/3vXkziCFuT0ZMnDSR9k3Z/s0OWspMbGxVs6E9Cx26xA5Upi6IEuIMPoteM7izCz6ZbY4CTLjliF+ED6g9Oh+CfiCKFb6qQHbApL/3l6KEXdnozHgdeDKJx1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1m8xzz51t2Rrix4gydZt86M8+QTWaQ5mQAclHA1LAM=;
 b=Vj4hTvFPH8RnEqhU5r98T4LKmtnm+7gNyf3HPYo1g8EAEyNe4f8hpBrl9U1yoTnbjuWD7vq1MpiKICCnIdYFsdiRX2GTglNer9nzKgBJBfP+Dap/BeIAj2p/D+e0r5DO9QuBzu6YIKKqUEAK45+gTAp4xA+QGNKwYyoaK4myouI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB11040.eurprd04.prod.outlook.com (2603:10a6:150:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 4 Jul
 2024 16:04:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 16:04:11 +0000
Date: Thu, 4 Jul 2024 12:04:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	michal.simek@amd.com, robh+dt@kernel.org,
	krzysztof.kozlowski@linaro.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	git@amd.com
Subject: Re: [PATCH v3] usb: dwc3: enable CCI support for AMD-xilinx DWC3
 controller
Message-ID: <ZobH8x/ikM/yafxb@lizhi-Precision-Tower-5810>
References: <1717657279-2631757-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717657279-2631757-1-git-send-email-radhey.shyam.pandey@amd.com>
X-ClientProxiedBy: BYAPR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:40::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB11040:EE_
X-MS-Office365-Filtering-Correlation-Id: 532416f8-cd17-4b67-2904-08dc9c42f198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Co+URckysfh2fUZ7j1FmcO2Q7C5YjxeenQ4sRRvdVXJPdWjfEAM5IpPl/j93?=
 =?us-ascii?Q?6u+PRd4hxrTTHCkoy7bjBRUZnrK1+8osAUzqe82bHOWpDZgA76ow/pfzNzVv?=
 =?us-ascii?Q?zAA+SG1miBW1cBE+cK3tWVj0GuQLEdSPeG7EnctD3xiWhRRIYrjCZCN5yFO5?=
 =?us-ascii?Q?kq8ma3gcTbP39kihxZ5DkyG+oZyav/0gZFI34xKDjCkGVJOoM9P2K8OSIbfr?=
 =?us-ascii?Q?5xD4nagBNw8GTUghnCNYadVLpqOy2brQQN4pXkYxDFjKw4dtfW7OfamrVNy6?=
 =?us-ascii?Q?Sm+da6C8BluqgNH9V/Po6wrZaBxArN4RgkMzDAkDexjPvQIrwUn2f1p9m7iC?=
 =?us-ascii?Q?CIPybY63Ot2qDyPJIYB2QRDdb8th0PZAIsMYQ726NNYCfxO+SgdEZscZefUs?=
 =?us-ascii?Q?9KJMNbsQRYYWCjFecTi7SXGHrIH2d/oY2uSMEKMKBSuA7KqqgB+u0YML/5eu?=
 =?us-ascii?Q?oihmbU3J70V9UE5MxaVK7K+gW187tcRWyUUYK/7Cso87jHIbNU9XolD+wAcJ?=
 =?us-ascii?Q?s9OG/sdr+9CWSZoffP2Jso5zvEVqnH3cm7FfSeCkpATR7WydHcycZUDHd+xs?=
 =?us-ascii?Q?S4Tyf6G/kqQ6/yW4XWdRj6RGdJcatd/RQFBGB5UNVeGESVmMfO+j6fNq1mtM?=
 =?us-ascii?Q?XjVmlcWktUx9mMXCuSCT0E4x0aEP81VTqHR34oKMYFQuG7HPOF2woxuPrWMD?=
 =?us-ascii?Q?9GxPRYt2X16R+CsWllW92WWUVuMXUdZPIjsOyiR+8+0JjyaVxrG3x7a3wmZN?=
 =?us-ascii?Q?vre3hPAfSJhev6ist1qZ7uRFj/5MXAvPFhw8aoZF6HXQ/b0+l8VBaCleZ9iy?=
 =?us-ascii?Q?k+IUXCPfjG70JnshKmlmKKeRlg/kdocEXWYBFcTkLDlxzYjk/z2MJrqZpIcI?=
 =?us-ascii?Q?auupamSRbJ3epCPigCYF3JbrhglbGko+7zOQ2xKVPuWR/zNUX1+NS5snmllz?=
 =?us-ascii?Q?YXWqSERYm1bWZ9ZZOcSruqAI297jpcR+fIJBI8cuCOHaIOn6sil6tzjE0Ezq?=
 =?us-ascii?Q?Q+EqwYFFQoGVETe+/TZklF9rwmXuhsjIQqw4i+rHbhKHIVewL2dZ5U/fl6Bj?=
 =?us-ascii?Q?90riC1zANBRn73CxjZgdhptlB1h3izLT669WW1PQCxQgOZif8yrZDyeqV6g2?=
 =?us-ascii?Q?ZU8h0GnlGbt4GCcHESyzi/vHU07K7N/hB6C5pookk9p+akBFEkhVHEs87FgD?=
 =?us-ascii?Q?ir+tEdVmKAqjmRnaINgXQtvGafy+Ldv9tbDQr+EDRBN1wXdxZs2lzGaOF58I?=
 =?us-ascii?Q?dFn7YsdWY4Tkl7ULIrUobRLBidCaoVbLyRPw8kQZxzAk8+VxBMQGD4dUEdW5?=
 =?us-ascii?Q?LODwPdfIumw2n0xxRE+RlthfCDApMt4LxsbHiUrBRSup6kvP9WRkcb/bexR9?=
 =?us-ascii?Q?QLW8mtY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v3b2hGEJ9jFRXyo9rIuNTMwLdkUeJ3H7gUo4uzR3J0iInpk4s6R9KbWsRmAZ?=
 =?us-ascii?Q?4lLGhz6Tja9WCr7C5ZTJKovk+ZP2KqxqDw0WN5R0PkJcle3W9fKtRpHyC1h7?=
 =?us-ascii?Q?61L9Lnz0OIWTdWWkSVt9C+IvTeZzo/JlPWJLpUpNttF8AsPIJ1jh/y6FCPa+?=
 =?us-ascii?Q?CMP6xUCjVVOHWD8I3aZAFEmUQ3angwwgioI6xEpnkAwKgwGNBEhikfn2TXc/?=
 =?us-ascii?Q?2GIVyz9VpMORvvu3lJAo6Xx/vihtdrfMyYqsZFGQ1Lza6bilwbwZk9KdES2T?=
 =?us-ascii?Q?6nl+RyDNcLjWKq4tWu9ljlK8NnX/U0GVpln6aedEhzMgUkvschPxu5ohOd0b?=
 =?us-ascii?Q?hNdjUr9ANnN4Leuhisr2i58FHnGdIWybMdDkgBM+wUxkP6yW9fqgHmtp/Gtp?=
 =?us-ascii?Q?BU5bfxgZB6sIa768xhf7NWVhAd7fEgY0odchekPxqtnsCyzgDDJUhwS2AVeC?=
 =?us-ascii?Q?kH1u1QIVGLzYr1ytSE9p5Q3mu9Fs6gwZAPfvn+18Nu9xkH5fo9cXDZXROYQV?=
 =?us-ascii?Q?ueg1kEtgSub/PfWraWdqGYcp1FDDwDvzK4xpvT1adIx6shn70Tm+BavLP6N6?=
 =?us-ascii?Q?uGSxGuzOuwconPbZpfivNjpYGpbtEr1+e+YNJKoC9R44esRVlE9zs4B6w17u?=
 =?us-ascii?Q?HofMrhvKlRqpzVEL8vbNguDYtgnx138lCxs4kcx6VF1j1eL6UI4b7blZ+86e?=
 =?us-ascii?Q?xOOTGmbFA6BNWTpC+v0ohmGIu3lqq8cq8zRNRJ23Wlf1Uch7iY/CttPMDGvG?=
 =?us-ascii?Q?T6KHSCsLdlfVFQ8CxEOEQsyH7C/UIX2HJiddIBy4twVrv6dBPAHQ/3ESpafc?=
 =?us-ascii?Q?wZ+EJHiWKLAi0nnzLvvyqZgucUmwyrHpGJUJrE76o/ILfQYHOwJHIrmt3PAK?=
 =?us-ascii?Q?WS0JsuBIQIrWTiNw0arh9G/KL5wicX4oQuSEPo3xumvz3h8vStucpZ5uGFqX?=
 =?us-ascii?Q?9SJMX7+BdVN3hl3ku34p0EyCc8mNz+HSFzzDTGhWpr2l3ACIA3CegwodqGdZ?=
 =?us-ascii?Q?Sm6pToe9j7eUC0uoz5NXhnm24g1iuX0hWZJo6bJNd1GH6QLZn6ZoJYvmhnPx?=
 =?us-ascii?Q?9VonfymV7GJfenTS6ec4ABD2hx1A29y3b9hkaMKAL75NYxUhjFPGsUv5fc/L?=
 =?us-ascii?Q?/Iw2EqBPCfyCAOWtyfwu38TpPyMIUPeN6irAisjU4z96jg8uE2SGW1yylLRS?=
 =?us-ascii?Q?I/SH/Sv242yn9wcGSeUA/1dDHX8KrBRM1FoFaZDd0CHQHCOAR093T7l4terK?=
 =?us-ascii?Q?DifvjXjVeDg7F2SH3DHkyAi+7BKJqvIf37qB7apMoIpQPGhYVBUHT+ocEe0N?=
 =?us-ascii?Q?jQGY8rp0qAU3e3F4tc/YHQ3LTWL6IZzGJq+nGhzaYFaZSPyjPsx3OStomxll?=
 =?us-ascii?Q?3nSzWsStcximt6sZABFC00QS1LYKwSpv9/kWD79pL75yYJW+jhGEHO7HYlpE?=
 =?us-ascii?Q?WraYQmNVBfz03Pkhw62YvAO6J51iag1wVasMCFs128rRNKN1O8ojyRbVqDjp?=
 =?us-ascii?Q?2x13xNYInvxPH9zaE5g8vODEKy7oKdYyf0meGe34EpUUxnDphBiHNQ2qpAiO?=
 =?us-ascii?Q?mfS5JoSrbRREFG7BQC8FuGxmD2Cuem1Gq48vuq7C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532416f8-cd17-4b67-2904-08dc9c42f198
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 16:04:11.6101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8spgN3xxwGV94cMrKeDZsMrUm3LybLVWUuefDHs7nYUa1SmVnrDGC7ON7ArfeT0b4i0XrNBoMppBfihaboxZWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11040

On Thu, Jun 06, 2024 at 12:31:19PM +0530, Radhey Shyam Pandey wrote:
> The GSBUSCFG0 register bits [31:16] are used to configure the cache type
> settings of the descriptor and data write/read transfers (Cacheable,
> Bufferable/Posted). When CCI is enabled in the design, DWC3 core GSBUSCFG0
> cache bits must be updated to support CCI enabled transfers in USB.
> 
> To program GSBUSCFG0 cache bits create a software node property
> in AMD-xilinx dwc3 glue driver and pass it to dwc3 core. The core
> then reads this property value and configures it in dwc3_core_init()
> sequence.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---

Radhey:

	Do you have plan to continue work on this? We met similar case
with this. If you have not time, I can help core.h and core.c part.

Frank

> Changes for v3:
> In v2 review as suggested by Thinh Nguyen, switch to swnode implementation
> for passing GSBUSCFG0 cache bits from AMD-xilinx dwc3 glue driver to
> core driver.
> 
> Changes for v2:
> Make GSBUSCFG0 configuration specific to AMD-xilinx platform.
> Taken reference from existing commit ec5eb43813a4 ("usb: dwc3: core:
> add support for realtek SoCs custom's global register start address")
> 
> v1 link:
> https://lore.kernel.org/all/20231013053448.11056-1-piyush.mehta@amd.com
> ---
>  drivers/usb/dwc3/core.c        | 24 ++++++++++++++++++++++++
>  drivers/usb/dwc3/core.h        |  8 ++++++++
>  drivers/usb/dwc3/dwc3-xilinx.c | 18 +++++++++++++++++-
>  3 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 7ee61a89520b..159d21b25629 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -23,6 +23,7 @@
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_graph.h>
>  #include <linux/acpi.h>
>  #include <linux/pinctrl/consumer.h>
> @@ -599,6 +600,19 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
>  		parms->hwparams9 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS9);
>  }
>  
> +static void dwc3_config_soc_bus(struct dwc3 *dwc)
> +{
> +	if (of_dma_is_coherent(dwc->dev->of_node)) {
> +		u32 reg;
> +
> +		reg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
> +		reg &= ~DWC3_GSBUSCFG0_DAT_DES_RD_WR_REQINFO_MASK;
> +		reg |= (dwc->acache_data_rd_wr_info <<
> +			DWC3_GSBUSCFG0_DAT_DES_RD_WR_REQINFO_SHIFT);
> +		dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, reg);
> +	}
> +}
> +
>  static int dwc3_core_ulpi_init(struct dwc3 *dwc)
>  {
>  	int intf;
> @@ -1320,6 +1334,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  
>  	dwc3_set_incr_burst_type(dwc);
>  
> +	dwc3_config_soc_bus(dwc);
> +
>  	ret = dwc3_phy_power_on(dwc);
>  	if (ret)
>  		goto err_exit_phy;
> @@ -1574,6 +1590,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>  	u8			tx_max_burst_prd = 0;
>  	u8			tx_fifo_resize_max_num;
>  	const char		*usb_psy_name;
> +	struct device		*tmpdev;
>  	int			ret;
>  
>  	/* default to highest possible threshold */
> @@ -1716,6 +1733,13 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>  	dwc->dis_split_quirk = device_property_read_bool(dev,
>  				"snps,dis-split-quirk");
>  
> +	/* Iterate over all parent nodes for finding swnode properties */
> +	for (tmpdev = dwc->dev; tmpdev; tmpdev = tmpdev->parent) {
> +		device_property_read_u16(tmpdev,
> +					 "snps,acache-data-rd-wr-info",
> +					  &dwc->acache_data_rd_wr_info);
> +	}
> +
>  	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
>  	dwc->tx_de_emphasis = tx_de_emphasis;
>  
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 3781c736c1a1..57b3cb739353 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -194,6 +194,10 @@
>  #define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
>  #define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
>  
> +/* Global SoC Bus Configuration Register: AHB-prot/AXI-cache/OCP-ReqInfo */
> +#define DWC3_GSBUSCFG0_DAT_DES_RD_WR_REQINFO_MASK	GENMASK(31, 16)
> +#define DWC3_GSBUSCFG0_DAT_DES_RD_WR_REQINFO_SHIFT	16
> +
>  /* Global Debug LSP MUX Select */
>  #define DWC3_GDBGLSPMUX_ENDBC		BIT(15)	/* Host only */
>  #define DWC3_GDBGLSPMUX_HOSTSELECT(n)	((n) & 0x3fff)
> @@ -1153,6 +1157,9 @@ struct dwc3_scratchpad_array {
>   * @num_ep_resized: carries the current number endpoints which have had its tx
>   *		    fifo resized.
>   * @debug_root: root debugfs directory for this device to put its files in.
> + * @acache_data_rd_wr_info: store GSBUSCFG0.DATRDREQINFO, DESRDREQINFO,
> + *                          DATWRREQINFO, and DESWRREQINFO value passed from
> + *                          glue driver.
>   */
>  struct dwc3 {
>  	struct work_struct	drd_work;
> @@ -1380,6 +1387,7 @@ struct dwc3 {
>  	int			last_fifo_depth;
>  	int			num_ep_resized;
>  	struct dentry		*debug_root;
> +	u16			acache_data_rd_wr_info;
>  };
>  
>  #define INCRX_BURST_MODE 0
> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
> index 6095f4dee6ce..f3757bfbd650 100644
> --- a/drivers/usb/dwc3/dwc3-xilinx.c
> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
> @@ -47,6 +47,15 @@ struct dwc3_xlnx {
>  	struct phy			*usb3_phy;
>  };
>  
> +static const struct property_entry dwc3_xilinx_properties[] = {
> +	PROPERTY_ENTRY_U16("snps,acache-data-rd-wr-info", 0xffff),
> +	{},
> +};
> +
> +static const struct software_node dwc3_xilinx_swnode = {
> +	.properties = dwc3_xilinx_properties,
> +};
> +
>  static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
>  {
>  	u32 reg;
> @@ -288,10 +297,14 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_clk_put;
>  
> -	ret = of_platform_populate(np, NULL, NULL, dev);
> +	ret = device_add_software_node(dev, &dwc3_xilinx_swnode);
>  	if (ret)
>  		goto err_clk_put;
>  
> +	ret = of_platform_populate(np, NULL, NULL, dev);
> +	if (ret)
> +		goto err_remove_swnode;
> +
>  	pm_runtime_set_active(dev);
>  	ret = devm_pm_runtime_enable(dev);
>  	if (ret < 0)
> @@ -303,6 +316,9 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
>  err_pm_set_suspended:
>  	pm_runtime_set_suspended(dev);
>  
> +err_remove_swnode:
> +	device_remove_software_node(dev);
> +
>  err_clk_put:
>  	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
>  
> -- 
> 2.34.1
> 

