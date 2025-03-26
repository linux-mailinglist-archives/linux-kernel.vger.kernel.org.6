Return-Path: <linux-kernel+bounces-577205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2A9A719E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363E2188D43A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CE41A2632;
	Wed, 26 Mar 2025 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dl3e0NU2"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0EA48;
	Wed, 26 Mar 2025 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001406; cv=fail; b=qF33XhGGl5ACEnkNf2lS8FM7Onn6Cx0CM9r60kKusmm0rcU0ac0Q5CDM/ux8xEiKXjw/2dKDF5+R7CsSMvaB5SaNQInPmiiOb73+79G1+r6kA6KdcUqGRF4H79pZrEZ+lmXA3hhRG52QpJMvRBlJn7iSCjMMjJVurbAYORlpPEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001406; c=relaxed/simple;
	bh=oy7hxoZLyDcr9ULUOOChGdbRvCTvpfkN2szEt3OzhEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tBJKUj4n2zNOs1LzRwefRX0ysbXy+NAa6QHMqwEtSajIUUwSIT7jqhbuuPK1IrwNMejDv8o62uTwaRRQKN3Gkb+eHoGST7J2yg83wAC762iFkq8VOrMDB2DPqHjGqjJm9X1Piw7ExtwZGglEIL4IT9Q7JeiHeCQztOIlA1S2LaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dl3e0NU2; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mF7ZAaRCm0Lr6t4g5V1B4lK67eyMDnuWhhZLtk4ZK98QBg1mxn3b4LgtTI9kKI78hXVsS9Qn1+plg+EopSkQ2O3L64BqbwQC114FbcTMtW3vsPD8IYBwLJA7R9KRz2ZXY71JIZ8O2XsMntomeffsTYGfnK0z251LkkoUnX0LrwJRgNICmEs0oObyfLAdl7jmoS9HPM3ujRsozkxrO2vBemCgdopwlWkQA0GswRSGjlDzNWYL9ZRzZPKP6jCtDaVvvGBkSU2JpzvmjdihL6THTzYXJ9w9WoOmGvzExuChkuDeJTUoeYCmWv4uPbjFVMHo/KdA6Juy0IWtfoudZImAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5v8ePxxyNI0xLk0sd4Rg99PRVKlQ8P6TGpUnVLCJ0s=;
 b=W5mniInHqzTKMxcbYXtyn2DQQtiuEpnRZWzNeICoy3YEfYUTp0ct6F/IdZxJIVuV8iIjWn/smrRY2NXIpE08Br2wPrvavLYhGIfRgwblCRLhWpr5NJe6n9teSr9TQ+CYixgYn1eOCcyVyRk0pkI/5gvaxQ52N4D1KgmYEvChsqz04oAKJpt+EvYq99AspRHv0ZgRuy0UzSM6/ew8oLBfFMTPI4vSnff3UlEF3NHJiNJocfjWu0pCmQ9aqc14fEvHub64wAUlQ6++URhr6r/3jnkDJUwy0mHJYh876rxm/W/WERlgauUDvfvN3TuIabcpeLG36oVIBni/CHyh9T+uug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5v8ePxxyNI0xLk0sd4Rg99PRVKlQ8P6TGpUnVLCJ0s=;
 b=dl3e0NU2S8BG0J+gSJZInAiRH13cXJu4Dw0o1S6g1d63oCKPNSZiBuOtE90T0z+ZMJEdHUMimpiskInMkCYticZ7TUCQDJmkMo8RiGQzrJbZHfCn6ZGiajSpgvPn9sO1ZGxhK17K7seQ5XXOcSKAhquKCBN7BzoR4Tj1FonReZBMU+641k+IAPJELDRU5LkJlJCKMUhMDCJZOdimYacolCWRq+sTM+ZGxTpTsw0HVUlfJID9axNlqeCYbSv+17FPCjwjESkQcfg4bFrF9kgPSoaWpyVW7CoOgr5gjfiaLCyk1a8bArsRs39lP4EdAts7PQA9DeBcFPbND2ompdxADw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10036.eurprd04.prod.outlook.com (2603:10a6:10:4c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 15:03:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 15:03:20 +0000
Date: Wed, 26 Mar 2025 11:03:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v14 3/6] arm64: dts: imx8ulp-evk: add nxp secure enclave
 firmware
Message-ID: <Z+QXMJD517AK9WtR@lizhi-Precision-Tower-5810>
References: <20250327-imx-se-if-v14-0-2219448932e4@nxp.com>
 <20250327-imx-se-if-v14-3-2219448932e4@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327-imx-se-if-v14-3-2219448932e4@nxp.com>
X-ClientProxiedBy: PH7P220CA0045.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB10036:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9a8c93-6062-4fdc-a3a3-08dd6c775880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hIWgm6/fpqW/mVGEAoVNK7oX6fI92CgQyo1In/CCKDZNX0Ecan2dCfEUcb9H?=
 =?us-ascii?Q?Yy1r9UeZnr+m3ryOnXia7Ysje1Tedp8+yvqw+WLO2jxR6+NNlxd0JyMH9SSz?=
 =?us-ascii?Q?rufNaSprniILu7HRBPpSRTK2tcIZvM2swl7D2sHW2E09ng3J6r8ug2ogPR7o?=
 =?us-ascii?Q?EgO1mHpfhzp74dscEQHHBHPRkNKWqxiuHEyldayL4Om+I9Ot6WKJjoMs3Vv0?=
 =?us-ascii?Q?j299cl9ylhTOIluGjU4mIdbkiPGd6l9fV2sGWn/eJzzpDIm4aq3Ai4G65A26?=
 =?us-ascii?Q?fa4mGIMF/gfGcvOgMko8zfxwHMMmDxQt1hIFUXJVCeRUHfbA7gHhgP4Vq651?=
 =?us-ascii?Q?2z5WuJyWhqaKmexqrFr/QAgGeBonOTiVrDFRO3hHiX87J1E81LKpaQHvKvyK?=
 =?us-ascii?Q?8j0IcwOy4qvsch3mRZ8c3fxiTeKUJhYudYoVqWrsXoojYwl8HexB3tjjfGkd?=
 =?us-ascii?Q?cFeWt/UymzllY3bZN3GGe5NBI354ObgZ5y09lyQMAbNO2T3deOVEFwuqSEKN?=
 =?us-ascii?Q?tCNWr7BeOjtTwWzNPby+AbtKcAX2S2FZXxXREEnNRw+bHbECeVSucdBkxmWr?=
 =?us-ascii?Q?2pDV2wBJQvjzohB3PnI6QHqIJdadrtt2DebmshNXiBzRMr2nnb9aGT87ZQ0p?=
 =?us-ascii?Q?sv1wiBvYulzNYiAMt6LAvTa4yHDUMPkOzVxG4n27Zl4TKD8aSf6HHF5KpkPB?=
 =?us-ascii?Q?Yvq0o9YjbJ0TDxs4B10SJa5/rAeucOnOn+eWVg9SoEikt3Suw/jWp7d2zphq?=
 =?us-ascii?Q?hY0RHyzPD7ridHWwLmhK5ykCcSE9sNsujFRVwxmGNavSwko+pauo7pphvJNm?=
 =?us-ascii?Q?hkXZVLPE5fbZmdya6ChcF/3DIovf/8KFh1KBbnks8uNejk2viVPEW5WkPZNW?=
 =?us-ascii?Q?YOVkvWRTtA7A4IJf1bJbc+252X0UibJqYm3rwEpB/8vfUrtUPI5rFx5jqM/I?=
 =?us-ascii?Q?XrvzhKavC9Or+XcP/l+7BamxAluaSIisyM6idQhjtl6hc0o6AQw53bVNpPo4?=
 =?us-ascii?Q?+6IWD6i3u7bXjR+jyezQKYiwtvI+vhrY7YNK630MTg05N0VWInhv1euPXOnv?=
 =?us-ascii?Q?Wu0NXKP4y4k09k1Vs8OPirDFxdMWIgWUbu9WCL79bE9HVoMJ+lSgK8S0MxkJ?=
 =?us-ascii?Q?2H74cQCuQ+dK/mH08D1CsJrnlkSiI1JY+95RerAGWqMZSdbSGYTzUpjH/zaF?=
 =?us-ascii?Q?q+mct+Fk5Z++SleEgguF2LmdTo34j/xj33+AytWCzk0DvVtC+Yb0my1SpR5X?=
 =?us-ascii?Q?AnqsyM4MzCdWGRx+dgU0jztO/UMh+crE38WSXi74rNCOAkKVy7cmPP5KMgMG?=
 =?us-ascii?Q?khQGt6kww3r2eZcKOvI+Tk2V1wTsq/wrwiUhV5RuLMlWb8pUcA5EIyqgWLhE?=
 =?us-ascii?Q?456PjkoN9xJiv5OU4MS7YIb3ULkkNNBsIYx54xEl+yCDKszoA+GWRmW7cxz7?=
 =?us-ascii?Q?ryY8igvSfxDZT8Ma6hJAiMHym+TTTE2CwnjdpqPGuv2xQdvTcjByUCTH2fs6?=
 =?us-ascii?Q?H+JaNeXJwyqRFX0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ljJKciBKw2qFB1ECYXh6rO5Y6zTINwbKeON8kWQgyBUBvHIapWkItyVgPK50?=
 =?us-ascii?Q?ROIUxRbx3zhql+oqimqgiPWqBh0wAff0+8DdvoFBMHrTZKJvp7il1HQbJEyi?=
 =?us-ascii?Q?K8JQUeOawe1Xlf9hKszPT2Mh8O4A8jJJEhtUavpzXns7uXt+WHJUB9xdTRS+?=
 =?us-ascii?Q?jc+avgzqGgwYFgYm114/MGibyL5LDMNEOHCgXVi79NbpmAoA/o7akic9fQN1?=
 =?us-ascii?Q?UVqhT88RFX90n8kZtDdV494ghnEI+zw6BwAct1mK60y6Beg1BtyCx+EA5C2s?=
 =?us-ascii?Q?lSNStIh3q7orb2Jqnvre9usLrcJNykzz36N8554AG/D1SXZdUqRazHWsp/7R?=
 =?us-ascii?Q?lmoDtjUsQJykFFSNoeZOuWPuTyPp/46zyKRPYtR4V/HtJnlB11lio1HPrkit?=
 =?us-ascii?Q?WGhKrb5nW3ooWkeoc0InbFgXEZVJcb4kv7sUp/Tgss7Xpd8tXi2/Zd3rja1P?=
 =?us-ascii?Q?LCYihlwDknigNMlzG9b4PUk8hxHf2UB+6EI9z3FESE8KLbTpcYRblD/Mbxby?=
 =?us-ascii?Q?m/G8juyeBISD81JUyoSBmWidpIvqfiMGjQcwBvITqSizKJedKknsR+fi0+Dg?=
 =?us-ascii?Q?HMU04qlNmMC45reapLdroptzklwZlYycybb5X7bt8C8+zHU62QDzZ9WPrrY8?=
 =?us-ascii?Q?tTjVIC1W08tO97UAuMvesZXUzUe1E4UVMzsB7q9EpdzuL4ESK2mn5lb+vT/G?=
 =?us-ascii?Q?jdZMUJQ9Gj4HNoSFUP5ZAkMIEPUzy0xcrAzPYDnrBWwFlXUFk0952Z9iC1RK?=
 =?us-ascii?Q?8h2w/wXlTMpXeiEJwS0kfMlnj9sXTPiJeNf1bp7w1/QRgTX92bJokIOYOhoC?=
 =?us-ascii?Q?XCV2HXkxOJGybXUu//9mcVjf8huHpx1JJ+LoiI/ITca5pdTtATAi+hDCAxhy?=
 =?us-ascii?Q?mT0XEH4SkZe7hLHj6SG+/5huxNb34uw4sYq210/wiuS+gFhBtBWljAASoHJl?=
 =?us-ascii?Q?jDiRM7rmzRJJKlYZIpq2bgFPZTHvHp2QQn6Ny/vlvMfqZ1h6dV3RS8WDqgL6?=
 =?us-ascii?Q?dbQfBiIMmRvCpgwitojmp7sE/ywHzRgM+0PB/3TeCl2yZe/CrTOt8WyLBSj8?=
 =?us-ascii?Q?ArMOLTm8LQR+y/t46Iw/jHc/mcyT1luEiFmKaUeNOtLILJ+/SDoDAQYmE+xl?=
 =?us-ascii?Q?8mHFNw+3lm7wn5k4nIU9R9Cp/Bs5UGiuvDtXK3vM8jhh92j7qwYBSvhpwjiC?=
 =?us-ascii?Q?SHOESGUWNXj0MTJgDcTFZ5XsXIxsEh/MQdbwKQj9A7bThmD9QSjPPrZqR5iz?=
 =?us-ascii?Q?3sv7mtoqzlvgHjmyY5wryFNWGbE2RuLCNPQ1F+DydZ1nM2MN2XqvsLmVw1/N?=
 =?us-ascii?Q?bwsZTXxuBIear2nGqELdyO7g+4mr2x3umd5WwcKn1utUKncHMzJjqSB3revb?=
 =?us-ascii?Q?VGlEMFuscAVZbF+0iXrVxfYApNxlvBNsPL7RfGC0jJl+KiAl8CdjCii4jqfX?=
 =?us-ascii?Q?zyGfhFya5WRTdSBZluI73xMx3Li8WCKhljijc+Xy3nGhZplE39Bv4UTNku7E?=
 =?us-ascii?Q?IS6KLjNbeY4WM5tx7xnMZY//CGrPF91UlH97g1vjP5Cl9+0LRv9Jr/0y23HS?=
 =?us-ascii?Q?wEu3gMTR+uHsZ+UoRxY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9a8c93-6062-4fdc-a3a3-08dd6c775880
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 15:03:19.9647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQ5GkY00TgxOLpNYvEt4dAfXdzijflUlysJWbvvnmPnX+A9vOC/8V3ZgjEk4MLtTrjLVuKZ3XxHRGSnAQa91sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10036

On Thu, Mar 27, 2025 at 12:07:59AM +0530, Pankaj Gupta wrote:
> Add support for NXP secure enclave called EdgeLock Enclave
> firmware (se-fw) for imx8ulp-evk.
>
> EdgeLock Enclave has a hardware limitation of restricted access to DDR
> address: 0x80000000 to 0xafffffff, so reserve 1MB of DDR memory region
> from 0x80000000.
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
> changes from v13 to v14
> - added the blank line.
> - removed the lines: #address-cells = <1>; , #size-cells = <0>;
> - moved the ele-reserved under the parent node "reserved-memory".
> - rename the node name "ele-reserved" to general name "memory".
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 12 +++++++++++-
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 11 +++++++++--
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> index 290a49bea2f7..10aaf02f8ea7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts

Shawn require board dts and chip dts are two patches.

Frank

> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
> - * Copyright 2021 NXP
> + * Copyright 2021, 2025 NXP
>   */
>
>  /dts-v1/;
> @@ -37,6 +37,12 @@ linux,cma {
>  			linux,cma-default;
>  		};
>
> +		ele_reserved: memory@90000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x90000000 0 0x100000>;
> +			no-map;
> +		};
> +
>  		m33_reserved: noncacheable-section@a8600000 {
>  			reg = <0 0xa8600000 0 0x1000000>;
>  			no-map;
> @@ -259,6 +265,10 @@ &usdhc0 {
>  	status = "okay";
>  };
>
> +&hsm0 {
> +	memory-region = <&ele_reserved>;
> +};
> +
>  &fec {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&pinctrl_enet>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index 2562a35286c2..05db47668b7e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
> - * Copyright 2021 NXP
> + * Copyright 2021, 2025 NXP
>   */
>
>  #include <dt-bindings/clock/imx8ulp-clock.h>
> @@ -154,7 +154,7 @@ sosc: clock-sosc {
>  		#clock-cells = <0>;
>  	};
>
> -	sram@2201f000 {
> +	sram0: sram@2201f000 {
>  		compatible = "mmio-sram";
>  		reg = <0x0 0x2201f000 0x0 0x1000>;
>
> @@ -186,6 +186,13 @@ scmi_sensor: protocol@15 {
>  				#thermal-sensor-cells = <1>;
>  			};
>  		};
> +
> +		hsm0: secure-enclave {
> +			 compatible = "fsl,imx8ulp-se-ele-hsm";
> +			 mbox-names = "tx", "rx";
> +			 mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
> +			 sram = <&sram0>;
> +		 };
>  	};
>
>  	cm33: remoteproc-cm33 {
>
> --
> 2.43.0
>

