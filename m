Return-Path: <linux-kernel+bounces-552310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B44A57834
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 05:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D6D1899BE0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 04:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A87815E5B8;
	Sat,  8 Mar 2025 04:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BxQzdvMX"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2060.outbound.protection.outlook.com [40.107.247.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF691487F6;
	Sat,  8 Mar 2025 04:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741406551; cv=fail; b=NZKfGkFPRxqIIAPikobyEbiDACJMPdY8ufVMPp5JuNMRJ9a7HAYmOyBeIH0j5mwe5DgvB0E548wYWex8btFtHIDXUbh8wwxNZi4BRaTUaA5A+fdq+GcbpCSzgQB6WGk5vmBSl6h0oXWBlJFJbAiw6yCsjHItNzQQHjzsATqO2Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741406551; c=relaxed/simple;
	bh=SDTgj6RD5mJGP04+6n4P/IvxsVNxSqjxPUPLLsUn960=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lZQLbGEBtZ9EjsI7zEuAhV6CQp9jQPDEQzxndkoNpMiihARSNxnhhYlbGzfqbMASOzRMdBQkhXHQAGdv6rETOtKeXfqy2MGqIleZJyLj2y9HSZqkYEkcqEA8xdlIS+wBKe+qUYbOChAhWUkxBKKvj2SVPY2tpUtW9yE2w/Sf20A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BxQzdvMX; arc=fail smtp.client-ip=40.107.247.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdHq9vP/mKth8i35bF6/J/ScNuFEAg//SQw3kOGQPYJDX45nMlRtWcNJvVs0+bPPTiesvYw0h7T8Gk/iWTG9tSy8yVaAQOr3DBZNLjht/CuypAi715rIDJMkKyVCFICvTBnue+mSrD2ThRBKw8NmrT7E8TDREnABLBXQrtHm41orugtwkYMWt7trHHBn2Pb/NYuy7ivh1P5Z6nrTEk8I+JEiImKwPxN+lEpLKLrUs3MsTaKrT0dJIhz/I1j5tyNZK0yOZ2sKYIhjkecpTjmGtpD1N+CDUKZuGBBUw0r0DXi9Z1u3D4pXpGHLockyjvJ9zBcxrLL4QRIeknBGP+1C0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pPmZ5ocghnk53G6GuthNDhvcLChnp66eIXDssQySeU=;
 b=YRBrfO9jJ4ukqPGKxRcez1ZNuk3AGCnwg3+usvTwmClbTihpeG84oM8xMNkUYw7x4DngWfF/uMvzetTIVoK+ZMbQZx+EMWWOE/83ejMr9PSE9sajz9bAqs10smyeQ00LFIuF8jgbvttFeDi/UunLKjqkI9u6xi4G7Lxdd5Yjs0Vl4ryi2bD2lmYqmTMHtJD6ud6GUCKST1Od5liktGnZj9Hb9qHTSy8SF3gRxUqdMV8A5dax9bQsN0kiX7WTnkSWBW4KHWjmTnDr3wv0IyXH+5N6cgqaUI0P3HP1SkHI03uN9DbjIxBF9UX9seufRwZ/eJglupAGUsE/KDtOWiiPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pPmZ5ocghnk53G6GuthNDhvcLChnp66eIXDssQySeU=;
 b=BxQzdvMXA8Txp1S/cA92wi87xA8ctQYgJq3xvtyKz7LkrJR1QemMvhJ9t57fC/V8Gx3zKpjJW1bVEKOccRdcmKju2kWpbA4rEg1OU+SbAHCCeAT1x/bYwlk+ErBq6U87WLx18+EmG69tAB0FtMrULzDkh4d3EfOCjCdvwjV9AjBm7KOjFbeXb++ZwD6jxyWpLZFi6cNzxvr21nncz1w2fHj4xPHC7pRVCX3a8ctL0QjoAI9yGOxsORWlvc9oAhrpHUjAnupXlymbr80VgwFrcKPjDTbcvytzg65Re13OU91ipeDLG8jndtOfe9IDAfqQCjEtZL8Po6n1EUyEGgMvqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Sat, 8 Mar
 2025 04:02:26 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%4]) with mapi id 15.20.8511.020; Sat, 8 Mar 2025
 04:02:25 +0000
Date: Fri, 7 Mar 2025 22:02:19 -0600
From: Han Xu <han.xu@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:MEMORY TECHNOLOGY DEVICES (MTD)" <linux-mtd@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: mtd: gpmi-nand: Add compatible string for
 i.MX8 chips
Message-ID: <20250308040219.dqds6lrf7qnipldc@cozumel>
References: <20250307220515.3282954-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307220515.3282954-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BYAPR06CA0043.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::20) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|DU2PR04MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: c59ad0b1-93d3-4f39-264c-08dd5df60964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gqIJpXsHzZ7O4S+DB8l5PTEGUA/jyQVvPsQif8WZ57jN9ThzsUrgNYi7mKwQ?=
 =?us-ascii?Q?pMF5/w31woqLg6OkfrGWu0TpnA392YFaUxcMq34cduehuRsNMUxJdRyuVky1?=
 =?us-ascii?Q?gKnQMywTtSxFDrtoXi5nv+yPc0UHuDxMzwc1j93y02WX7xYE77i2Bjs2EZck?=
 =?us-ascii?Q?KKONqim6iowMA2AziCpiqRH95PcVA2HwD4pgfhfjw0+XwaMt+rsV90AyYkQH?=
 =?us-ascii?Q?FoWBLrPjKZGWAbwFxx4bn+TpvM9lZdVf67lwwRAuZRU6lGj5Ptb71atsK6Y4?=
 =?us-ascii?Q?YrowMzn1nwqMj4Y8OW7895XrkEm4f8HbjFw+tXCiau5ETq86fKD5OO4aXuv6?=
 =?us-ascii?Q?CkNM1aV10ZnMHB/EaMSNKthnLtCZwQvoPES2Av5+AlTfU4mEpUKpMU785kig?=
 =?us-ascii?Q?wXl4USjGA2qZxgolMjzs8ZwqosOWwLt50OCirv1NFKOPNa4Y9ytRQsVLVE0u?=
 =?us-ascii?Q?VD3UH8cw+J2+Y8vLieUS0baNnVzPEoDvXEn8jtGnWCgL0GYYS7IDY5HanuLP?=
 =?us-ascii?Q?D1A0sLWgbNq4I4yITbNggPU5HEYHdsUmtW0+PNDx1mFkkdmwAqavst6SsaZp?=
 =?us-ascii?Q?Imi+3yfMdSvusNTUbK2w92LH/Jmj1hK+9r/TVEqE5Avo4kA9WFbKUnNumW7n?=
 =?us-ascii?Q?fP3mpxj391N6VNJQ5VhjAtnQHzqGTjwzCkus7pRuvRoCzwci9ftWmax1Ivrp?=
 =?us-ascii?Q?+pfqN10sC50qpIRS3Fznhv/MCxrcfapdU1VfVO/ZYTHynNa34QxA4wf5fQEI?=
 =?us-ascii?Q?lDhLHOb4gguUYcs46bNOnN3ck5y9s2YiK22QA03mqbSA36KDVbjerUF9WLfv?=
 =?us-ascii?Q?86V/Epth354K9fmvbe4cvlfyLD23zYM+FPIjhqu9XWu0zrFcUPbuQpQT+dJr?=
 =?us-ascii?Q?h22hXOqZL6rQq1/O6odg2R5FCVdSyb1NWFl8TSCTCMDowM/4qoYYddnzOE9P?=
 =?us-ascii?Q?01CQodvxZ/90IySkuL1CpL29snTsYRATut5hWjy9fCztRgdIw24/NZL2s82h?=
 =?us-ascii?Q?AlA5w2rnJE8M7+l/Y35DQQiJNvXPl5R2lBdRaDKYd4a9VlotrFe5DXxFj17K?=
 =?us-ascii?Q?cnj7Wzk9BbuldVS+0Fm0kftMt510UR1ZY76SOwp/ff40O0oYEQgbIOiH4PNr?=
 =?us-ascii?Q?KHGeMDlyG8QWjlvolmJu4T4aDO5cgEUuJKVEZ4rK7pbllHjjUChfY7WzGnmX?=
 =?us-ascii?Q?0ly7dmh8a+2hyaCGppJKfcqCrW5I9In1/WbwNnzKFKDaOZy7Qy9vM85x/dqZ?=
 =?us-ascii?Q?0buwrG9gimj3krisNfrnWDhauNdNpbgL8wmU7SgIHIK//B/uQ7n+Qqmy8yaF?=
 =?us-ascii?Q?5QFJaHp9Lfhub9jF5gf+zlMbomfARB/OlP4eBvLqdNn/9HEYAzSRivn3xLUp?=
 =?us-ascii?Q?LMGO71VOtlo/BHYcjVh9IKZxWXCaYFgRdmT5bdNSO4sKU390Y5o9mRYh99aS?=
 =?us-ascii?Q?kkFjEudfaaZlj9CPw5fvr1kxeakyuTim?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cPeZEpm48kXy3hFrM/shGMCxSfJI95e6Pcz+qWqD0eRdwye988K4NOjqRes0?=
 =?us-ascii?Q?VCjPT/zIIxVp0zVzF6ZG1S5960gvSslUXteaMTIU8oaWmCj4DCfV95Lr8Dep?=
 =?us-ascii?Q?lrMP21fQckq2ODuXPZ/kYdFHM4K5UbbQBoVee43nbRr0m/7z7G28vRE6SbGC?=
 =?us-ascii?Q?8TEXiaLKZm6QhUZEwVx3Yy3SiVofQms+sl+I1bYTDgeOmH5myx5yV1hVtu2E?=
 =?us-ascii?Q?R2ZwPS7/IxO2JO0gwmwKziKLrxMW+ip2Jca2I3/IYOlO6hOOKtmjj8i1r4zS?=
 =?us-ascii?Q?SaDsxtGxFOsk412wL0lO/UKzisDnqKw7jKjuRBxYfLLtN4NgXx8JKQHqDqa2?=
 =?us-ascii?Q?L8W4y8+LIDa2UAZaUAIMI372XeOgEs3E90R5fMEJTyHMWlUuEzeeHKfir1D0?=
 =?us-ascii?Q?T0GY3TX94Q5LLeOZCuZZIjpK1ezNulgI9cTOit6jsc4zK5rFQT9b4ZpS2F7a?=
 =?us-ascii?Q?9p3bY1Y0aZjEMjfOE0/PSvPAiQLiTRE8VNWcs6ksj7RTvix7IlDHlUZHg3ve?=
 =?us-ascii?Q?nt3FQMr4d6RxtyqPR4eWiVa2rBxcEWHC53WPSfLLx59I1pE14jnOyqeZi0Lm?=
 =?us-ascii?Q?GBQabzXm2wLpD9Gfv0OxjoCqQMT9WziQ37Mnn1iAsRBR5sk8IPI4rOQx1LfR?=
 =?us-ascii?Q?KdZEXNMe06THKrScgED5jLm/oBB2UKavoyFi+imknwC6lJGlGme0JLp3NWjb?=
 =?us-ascii?Q?Ek3tjZgdTt0SWLib6KeeZHV+cH9X6lSlX+ZO+lThl/ohxFwi8Anzwkgk59XG?=
 =?us-ascii?Q?zzqJk5codmkTO8e0+rlx9aD9nfG6XuWiMc+sHiVwc0RPDJbW6+3nHLvOBdLm?=
 =?us-ascii?Q?7C0SyWHv/bIajFYDBgO/Ol12+GHLMD7O9OwopltxT+KIoQzzGIBlx/y6d33h?=
 =?us-ascii?Q?s7vEB3DI/zL95EdGm6JajHG4bPB7i9TIUMvC0UTedQlVYbFrJzBSenYOfMLs?=
 =?us-ascii?Q?er6VDoCkbCRRottkpVhFFhNv/XZM94r/tVpRgCDM7es+H34WyxmbbboSQ3hR?=
 =?us-ascii?Q?agh1+ZJp0pI18qDRQf78zP5T9Of4oOkDpL2z4ip+FMu60peiy/L6TXR3ojcN?=
 =?us-ascii?Q?Tn2eWe2s60jNlbOjEHzGgZ8wsCdc6I3LhrdCBm3L7Ct5zXFo7qjAOTSvxgOR?=
 =?us-ascii?Q?ioATZ2ybcsQCYHVRupLUdAuEB9gXJ1LZiflZaAW++FU4wHdIJnYyU2jOBIDh?=
 =?us-ascii?Q?lo7Ow2VB/BiD/Av1xR+1T1j1Pglip6lpNzbySNybqo9YhCCfOF88pi+6ZDPK?=
 =?us-ascii?Q?rlhzcUzIDvWKATwSnSnVrTEX3OgIfXzHPDQ9B2kowUgd69iptFg1K/zjYmDV?=
 =?us-ascii?Q?q0jITqoys+WGhXjMHXRK25aJS4Z9dkvJbqN3Z5gvJZzCNINYwRXbvXTg8E3W?=
 =?us-ascii?Q?HFiCjCwFyxuM6M5w/7xsCM0dYJlv/ve8CqtYRWolzlSLBi5Utm97d6QkmBnu?=
 =?us-ascii?Q?qlb417JXUoCwwslw1Ex1GWcRG3VAmtw4egaMmk71jS2tNko4ISF2oz8kWBCn?=
 =?us-ascii?Q?4sVbf6mBiVkgmcYanaVWlJFalFcwt4zDqTBWVSpRtro9M+XsOLjHb0fRDDTa?=
 =?us-ascii?Q?arsIR2z0tQ6RcdgPKto=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59ad0b1-93d3-4f39-264c-08dd5df60964
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2025 04:02:25.8990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syof+qG1KBHzlzSM1i8d17j2DEtFWQn6ye6MvcHpAtNOtDGpVr3jRdJrvr5rBnKx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8840

On 25/03/07 05:05PM, Frank Li wrote:
> Add compatible string "fsl,imx8mp-gpmi-nand" and "fsl,imx8mq-gpmi-nand",
> which back compatible with i.MX7D. So set these fall back to
> "fsl,imx7d-gpmi-nand".
> 
> Add compatible string "fsl,imx8qm-gpmi-nand" and "fsl,imx8dxl-gpmi-nand",
> which back compatible with i.MX8QXP. So set these fall back to
> "fsl,imx8qxp-gpmi-nand".
> 

Reviewed-by: Han Xu <han.xu@nxp.com>

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/mtd/gpmi-nand.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> index f9eb1868ca1f4..0badb2e978c74 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> @@ -29,7 +29,14 @@ properties:
>            - enum:
>                - fsl,imx8mm-gpmi-nand
>                - fsl,imx8mn-gpmi-nand
> +              - fsl,imx8mp-gpmi-nand
> +              - fsl,imx8mq-gpmi-nand
>            - const: fsl,imx7d-gpmi-nand
> +      - items:
> +          - enum:
> +              - fsl,imx8dxl-gpmi-nand
> +              - fsl,imx8qm-gpmi-nand
> +          - const: fsl,imx8qxp-gpmi-nand
>  
>    reg:
>      items:
> -- 
> 2.34.1
> 

