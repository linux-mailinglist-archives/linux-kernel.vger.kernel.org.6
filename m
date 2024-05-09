Return-Path: <linux-kernel+bounces-174075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6BE8C09FA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C5C1C21837
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603D914601F;
	Thu,  9 May 2024 03:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jqqQNFgZ"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DC785950;
	Thu,  9 May 2024 03:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715224037; cv=fail; b=sTHjIfDzCnAvSvaFwmnrlHuS5NJ7Xt/XusbdZC8M1ObRJiDIVFwqBagFQtWot+HE4DV9B1qThxGtsmcYDB/Avi9FFKIPeFzmw+GH7ABAACyMrbA4TLnbfxVJevZ99LyqhJKhjLrC9yKkoJqJfvYJN1tDSyhS3M7Kz1adJTVGY8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715224037; c=relaxed/simple;
	bh=9DLAETSguzQ8Y3uHO2rxMstyZ/XYQunzZKavFs/E8I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qeCOQnugOqM8D91RT5vFUnTksDzHfDgR3KFHJ3DWaIYZkB6T5IcCMwxFCQ9cYLrmlu0XBSES5zqLUTfL6+RAvio++onR40k5PxUb6Mz+EnUljkqf6b/usMfG7pqpzDxSd3jhvr8lP1Vl/ceIZd1KrQhFOpVfFF2cx8tW6CYDty0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jqqQNFgZ; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeI0Mplf8TN6qXgwnsikICn9KzJ770xj9+nECONt870RX1aYweLh98HK/dTS+KGBhY9Mjy7Z9cLn5pI7MhFNN4UHMnuqh21icUc6fwh3UQWDibNUyEtw6IJWOfcvCH1XlGrAbZ121FqBuckQGrhGiIKA5g0fXf+eiCL0PoYIZlPtvG0S1C7Xz5NKrEWPr5bJ/F7sMaoOGrOIRUSSRcwAMchckBi0uMadcpVStzOXHPr6KNrX/qN/u6xWVc1CaIMr7xJPPu/y/95dYSRBHOOrRiOgicO/O/Ndo8VI1M/W/DqaktfcWrt5Sb4WfwkqpBhZnhZnpkMtjiUdeETzwvO9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knoID7Fo9N+jw5ECK/RW+HadNLYsFFrsonZxU/DmEO4=;
 b=cRfz/DmhyyIJedWSoFqF5ueNLNG0evA+MkrUelrbWrXl54jfhcsHdVoJ7swAxY+fZ8Xh9qzml6XOKwN25CjTRKzZKXVCXKsSlXjGXu11DWa5AC0J/NtVp1lGxKJh0kKyYjeGRBPyXyWqdUcGaNfa5f9aJca69npj8wtevGXn91chD8CUkwtnsd6TlTl39Ebyz+lxtrQ1ycvLqE1TSNoPIo9ZClWnDxO4vk/uWlKdR4G9aVoyj5FtuBDgPuR4OP4BKcB44R7cE96CkPuRBciSocdStiTSWuXJOx/jSl1ZayI5798yN8lS4egvX+kiNNDcWpXV2YCQpV7vMMMJziXA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knoID7Fo9N+jw5ECK/RW+HadNLYsFFrsonZxU/DmEO4=;
 b=jqqQNFgZ16gwAFnwHdI2K6ddLtZHSxXPByVjsx6cPbRlrMb5+gqiisStUfIvGP6C0pdAP6aq5hStsJgYHjMVIF6Xb/8KfQTD9s5svY3agpj9ffGQspridA/TuGC2wWNSEIhRsEo6d+qDv//QUB9fHwjATlRAoPs7aiCW3Dc//uQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7155.eurprd04.prod.outlook.com (2603:10a6:208:194::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 03:07:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 03:07:10 +0000
Date: Wed, 8 May 2024 23:06:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Franck LENORMAND <franck.lenormand@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Varun Sethi <V.Sethi@nxp.com>,
	Silvano Di Ninno <silvano.dininno@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>, daniel.baluta@nxp.com
Subject: Re: [PATCH 1/4] dt-bindings: firmware: secvio: Add device tree
 bindings
Message-ID: <Zjw9044yBRn9+adW@lizhi-Precision-Tower-5810>
References: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
 <20240509-secvio-v1-1-90fbe2baeda2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509-secvio-v1-1-90fbe2baeda2@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0093.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f049977-cf20-4845-24a5-08dc6fd51dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|52116005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qCsNN+IgBqcuugxAe7m9VJR6FtMKXmkz9LCJO3iAkIbO/gBMxte26sOUza4A?=
 =?us-ascii?Q?+GXCyUUSswpAjLVnBoQNk9rttj6Knhw5mtJVF8YkqQhaHvD//wdBMntp4h0X?=
 =?us-ascii?Q?kA2uqTl6pAD0aiPULUHq8Sc35O5UmKolq+Yf/xmiVV0atQ5dmox54IFeKshQ?=
 =?us-ascii?Q?2+GUkYZ3scyh5LQ4f+ddtdzxaYuGP18HdvX3MYuC0NHqzlQZzMSRmnCFvvFw?=
 =?us-ascii?Q?z8BqLLfV02zPJRXDsFmL3hnJqNnMqWk4VbdlNY4adfUCqdj0367PQNEfSn1R?=
 =?us-ascii?Q?iTT9FSF/WdlA9Mc5haczlx5VvVBjTQJ0gImBWUJfixuRvkH2iQwxj+SBiJ3x?=
 =?us-ascii?Q?TYXJ25Olqmi8P0+v/FkwNnFTXFboBC3CJtk4FImNmkTlz2bYt3K5rYVeveym?=
 =?us-ascii?Q?ztiBk/DDmlTJMmXdVVcpPD+qjnQlLjxzYseub4sbHNe3eYyJ5NabhNdo08Gq?=
 =?us-ascii?Q?XnzD8GWxjN1udsJiUReH+GPuTNRpJwYMiIKxgoweNPPXHwVRCbjg7HEp3+40?=
 =?us-ascii?Q?d8QMg9rPlUfGFKh+v16WRcgu5umFImIacdILK8T5VScelDfQnVZpjqlYTzBe?=
 =?us-ascii?Q?omJhmypWz5037+KvTmB2fSChBVZWntGWva0sxt/Pzin2yfWxLRCEFnBQQcNa?=
 =?us-ascii?Q?gfE6asj9hx4ovjc8l6BmffbpAY8P6h2U+1lOoJ+9cZ9OPG5wiTh2quVUsC14?=
 =?us-ascii?Q?9SYodkA2JklzKWHtwKIlluzU5y2f6KUA0nOeCZR0VOwlBaM/5x05va42Gzf7?=
 =?us-ascii?Q?+Bfatag68qeVBgoglNwE3YgLigC9dNp6bcemP56Ua2Du+ik1HwIAkckfNmbI?=
 =?us-ascii?Q?Pk5Ms5vr+rYpFApnWYkn4f+NAvz/t2wIrIaZ/Yl02QQ657Wt48x8QsXZ31ev?=
 =?us-ascii?Q?hBNxWQEmiPkqheUmpF1oc710Lh5MR8hZEhBX3URemdfKG7dDtx0I1UV/jSqt?=
 =?us-ascii?Q?yrLilaWlX+AcOx769prWY9rxFvdGzvPfpz2jWL2b3nnZnBCWrYvPTmPSgvYt?=
 =?us-ascii?Q?L2zRSA7T6y0YuNt1fUOQIjk05NdeAmD+63tCljOTRe/RbwtkBsyiVMbV8N0H?=
 =?us-ascii?Q?lk0yp5GDBwmLgPCLiKyLULnSZNAhimwP9bqCso7BMlbcBCraZ5pp3OyfZmZV?=
 =?us-ascii?Q?gSbGWYKpkikvSXQtoK2QYhuem0GgQxUrRLms1U/7YS+snJyrONoaWMU3qzYL?=
 =?us-ascii?Q?dNaIVonHYVU+HplstJ6MFx6C6FhVYAGVlBXDrT0UxqcdTq1HXgYegrTk91Pi?=
 =?us-ascii?Q?et35LXdJSV7wCKq+1BJI2Q2/V12vtl7gHAVlY66K1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WCcGYwN8bwRgKqTW3M6o+jb+vPuKUmhdrBYQ/pa3AEXCSfWrxf5sasKsyZUv?=
 =?us-ascii?Q?8W5Md9M3BUs17ptT5toIEw04EFMsyj/pf5I1GQRnduEmqEuioGZbjVDht8eX?=
 =?us-ascii?Q?WDeeM/QD/K4EA4+cG2W0FP+TO8OD4qVn1m9VVUTUbb98xzpRfF8rjMJAEM2R?=
 =?us-ascii?Q?jDoy+Z+Uy47vYj9h8sk+K4MopdFjECHL+vyF2FpM5ZyaM2f1uecai8HT/d3A?=
 =?us-ascii?Q?jPzgJgEGHBFsw0++T9Cq8Kr78YIS3RablBt6py601EXGr32kbaff7tPFlByY?=
 =?us-ascii?Q?TxYZNsaeGH8AO0q4cKyFvJqqRp4iro4w5Zgt/rhwGdlkXoCjmSabrBKO0Yqh?=
 =?us-ascii?Q?k/X19nd4DVDc8s23sseJwsqRieGal6AybYAEeJe8wbwJUTPbqUtnVmcrephJ?=
 =?us-ascii?Q?lTycwgxwcArwoK259Qgea3asiHRh6kl3wHgEdYK1q2j2KaUo4TjGHTGjq/83?=
 =?us-ascii?Q?fINaTPXKzEaJRkCqW9NUeUvAP3vRaiPrefl4jcek2JwKFIfa2+Ofe0zD79+1?=
 =?us-ascii?Q?2ZCt9gdRHafYcHiSdT8mnJbFqwGFc6C/4jV0eg5TIPVfCzjfvf7eN8FR1qQb?=
 =?us-ascii?Q?BAK5Gs8Qy2ftS0i7aWJVks1Skud/bLHQ1K6vwNhXikT/ONeW8PrdZ435JzTW?=
 =?us-ascii?Q?vjfB6UsaCJtJ1O4VNTqtMRYVtV/7RKue/NEBr9FHcWalqB8KvWvOFNIltyoC?=
 =?us-ascii?Q?GXrt7NkY7ihqLov+umO2W0pMcJEXCwxrIUHDNkQNpQUf2fJHNsRuZ6FZDIR3?=
 =?us-ascii?Q?ozYuZ6Ac8YiUEYZclezggTCHe7JtfptA4JjYFKoVgkJ+L8VxUFfOV3cUSlBy?=
 =?us-ascii?Q?X8hkhRF1o+zvPHIdM9AbmMaIl1pSQzElU+Jdx5zTsg2sNXrJLxY8K/SEN0mG?=
 =?us-ascii?Q?s4IewDoM3oXXmI4y+hpkM8CSMZ9R2H2CDrKkNsAo+dpPT8nhM7x27JjpCoko?=
 =?us-ascii?Q?1S3xO8JsBpa05/bUd532Jg+IYo7nFzxVN7XW1OF1bbITIPx7shKDT5WRrLdX?=
 =?us-ascii?Q?jbQz2WMHwUOp+yH5SKq3mXUILYPP/Z65uSv7ZBJ6fO+YN0Mw/hshOGO8tmkT?=
 =?us-ascii?Q?HQuD/SBqSZMaWmuzDZ9ycFObig3rR+AeGJdKm/noNMblJ4zCvLNE6I3lPYrw?=
 =?us-ascii?Q?SahXQC0uR6LK0ZAB9vlBTIEh7zFpbiNdBW4r5r5iUKpSm8mYyQSpjbXKQtWK?=
 =?us-ascii?Q?h7HYElfDCBTTDnBr2YgVOEKRCCcTjId5Bmrfzp/PWpUnkB8lsVO+Eflivz7j?=
 =?us-ascii?Q?L9kh5kSRPRCLQhGNMOSMgvCAD1rzvQvd9UFeZ0RaUQOsH1U0nOjS+UhkZQLm?=
 =?us-ascii?Q?uW1zpHqObv+ZKovovVoRsZW1O5fJzucYx1YRvuQftDOEkfcSUb3lOiw4Zm0v?=
 =?us-ascii?Q?u4wwtcPpvAUCbraLIMQrB4oIGMGe9LvwjOFZ7usd1CgwR8HYujbcwpLX/suq?=
 =?us-ascii?Q?vLOqfjqfjK9+rWNuv5kaHOXYzvV/j3v4+yM3qw1i14f28eq3mzdZG2k4iz0v?=
 =?us-ascii?Q?nl2MxVd0af6tjM/DWeYA/udcCnqias/7RmGO9Ua66vbaks2X6khMWr/6Zzjh?=
 =?us-ascii?Q?Y3LpCDPnl6/CgwGeUwg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f049977-cf20-4845-24a5-08dc6fd51dc4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 03:07:09.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEfAf0bxR8THZlzS/3Rl9rwoY1gILpwRpCuM0PlZ+q72TNFsJSj9DSlJY28ajYijwbfBUflFIu/0+mgfIgjwYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7155

On Thu, May 09, 2024 at 02:45:32AM +0200, Vabhav Sharma wrote:
> Document the secvio device tree bindings.

reduntant sentence. 
> 
> The tampers are security feature available on i.MX products and
> managed by SNVS block.The tamper goal is to detect the variation
                        ^^ space here

> of hardware or physical parameters, which can indicate an attack.
> 
> The SNVS, which provides secure non-volatile storage, allows to
> detect some hardware attacks against the SoC.They are connected
                                               ^^ space here 
> to the security-violation ports, which send an alert when an
> out-of-range value is detected.
> 
> The "imx-secvio-sc" module is designed to report security violations
> and tamper triggering via SCU firmware to the user.
> 
> Add the imx-scu secvio sub node and secvio sub node description.
> 
> Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,scu-secvio.yaml     | 35 ++++++++++++++++++++++
>  .../devicetree/bindings/firmware/fsl,scu.yaml      | 10 +++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml
> new file mode 100644
> index 000000000000..30dc1e21f903
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-secvio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX Security Violation driver

Violation detect driver

> +
> +maintainers:
> +  - Franck LENORMAND <franck.lenormand@nxp.com>
> +
> +description: |

Needn't "|"

> +  Receive security violation from the SNVS via the SCU firmware. Allow to
> +  register notifier for additional processing
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx-sc-secvio
> +
> +  nvmem:
> +    maxItems: 1
> +

any interrupt defined? how do you notify such violation event?

> +required:
> +  - compatible
> +  - nvmem
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    secvio {
> +        compatible = "fsl,imx-sc-secvio";
> +        nvmem = <&ocotp>;
> +    };
> diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> index 557e524786c2..b40e127fdc88 100644
> --- a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> +++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> @@ -129,6 +129,11 @@ properties:
>        RTC controller provided by the SCU
>      $ref: /schemas/rtc/fsl,scu-rtc.yaml
>  
> +  secvio:
> +    description:
> +      Receive security violation from the SNVS via the SCU firmware
> +    $ref: /schemas/arm/freescale/fsl,scu-secvio.yaml
> +
>    thermal-sensor:
>      description:
>        Thermal sensor provided by the SCU
> @@ -197,6 +202,11 @@ examples:
>                  compatible = "fsl,imx8qxp-sc-rtc";
>              };
>  
> +            secvio {
> +                compatible = "fsl,imx-sc-secvio";
> +                nvmem = <&ocotp>;
> +            };
> +
>              keys {
>                  compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
>                  linux,keycodes = <KEY_POWER>;
> 
> -- 
> 2.25.1
> 

