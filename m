Return-Path: <linux-kernel+bounces-361448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE7A99A85A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9601F23DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67269198E91;
	Fri, 11 Oct 2024 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ipq5vjCz"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3D6195FCE;
	Fri, 11 Oct 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661921; cv=fail; b=NOujXFoauKydf5LULrode5u7eAItiupUb3JamADgiHpWM2unyYQSFNlrJt6LDMADXu0HsGPM3cdrox+aGHUfdxsED3Eqs5CUUHsN3NmTpJrfJMm3DUDcJhIlYtOwJ9Cw0sei+0le4xjzhlR3ZSaE3gYpUmjkpuRQvrEH9Ygj1O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661921; c=relaxed/simple;
	bh=LkS+7Fi79go41qkHuGXZHUAs/cpG6x2WXpDSHNZ/mLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JJ8RK9SJwhEo54EF34DyN8Bmy9pE61vqwqqh7vWRQhZDyFqQLjoUZyH0TUZdWuCiZIYqTct3DLTr7CNfTTfUvyz4ZijQPEb35ogDxUhKd9equfQuPl+K7Y+PnKK/hmGusdYdLORgvJSyw0NPVywJhERmM3UVaNlRQJmolpBk0+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ipq5vjCz; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPoH3xtS680UgGK4eGJzJHrKyHPrMq2SXqToCfHxu3adVL/nTtn3Kv92r9i6RT06M07dDsq0isEO5YKDWhhAVjYqW3RMhmC17m7yOzrZEYnchoMZg/gT0GniDgXTQjbWoizIVNnLBKFAmTQbrfeDr6iexLRBT5ETuuI4D4BovTQZSQBqY2Asub/m/r1oVP1hLuyAgHdBfYZB7x2tfrcBVzgxBHvcnwAM9BNAFQNgKMMQ3RLHwJtX2FRMmunxPPDd916ZguJjh+iRiTlIEsQCferTQxgRuo35gmiij2CYCtp0kJ/qLCBGqu+hgAo2bVyEvI+hvMVuKcudZY9sIc1zew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsP3wLbjOrHBfNz9l6GobWZAKu561M/OA4TSZCP/TQk=;
 b=oo+rRrPGchKQqJRvLDfM2CWU+3AUEORvrneMhDe+3QnQzT28YL4p8yj8pyrFyDas2dPA9Im1dIlYzZoZiFkfnpW7iJ3l3iJYkgj/95TjLg0QJLP8vcYubZ3iJjiTaUhNJxGFcP4MkwaCb0Y743jCnQluUvqbXTf1oA+1qNi2bcYqwBz2uMfiGHEo3kHBFGJbXWo63cFCVX45215rIlcTTuA7S47X/uoURDhzAPURQU2IjAuQgnfa4PIVaMNvvM6JnifYm+FEAmj+0phMewzeMijru4Ri2XziUEknnrA1sYF1otEZfGuto2hRAieTC6uZgx0gZSB/9lCZrvKgo6dXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsP3wLbjOrHBfNz9l6GobWZAKu561M/OA4TSZCP/TQk=;
 b=ipq5vjCzZxsh7TFET2zkmJ9HIjsR+dYt9xq6mpQXTVyzNG0gRo1VyX0+thNWSzrlWdt8Asd3VYBzu+Vl5QzElSYVGyLhmjXFSTZcdkvVptCcHmaFQpF4eLfJMi5qwFC6AzxOg1IHphm9dc+Q796FfW7apSOWVRQTGDmlSZmYubkCorLr4j4XbOmln9hA+05nH7ct7NUwQULaChPIFkrMPkwXIShPFgDHeg9NdF12N8ZGmkzlrxK62mz3EyyOig2JRllOb+/aglbJmUlLTgkXBtrZqAGBvDNXw+zR8MNNOl0TeLyx0abcBK6w6epwCAQzZFI1gWAkzCWK1U+permigw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7434.eurprd04.prod.outlook.com (2603:10a6:102:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 15:51:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 15:51:57 +0000
Date: Fri, 11 Oct 2024 11:51:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/6] arm64: dts: imx8qm: drop dsp node from
 audio_subsys bus
Message-ID: <ZwlJlA7bA0+E6lsy@lizhi-Precision-Tower-5810>
References: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
 <20241011150439.4027-5-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011150439.4027-5-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b40844-f377-42c0-350d-08dcea0ca2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EMraXHkvU1MSu/+570aLLuss81ZG7zm4wspu+gLnvZRVMKY00Wwvlg8TblPh?=
 =?us-ascii?Q?TFky6c6POZi7wSkfxkeGLRnW9A3qemBXsI1VUbJX5jw6GdsDT/WwY07Mst8O?=
 =?us-ascii?Q?EJwMWjNTYMkVL7IRRZcp70SPdJBrZbWYaAbqpp9pMHUr3tN8Dtn/ObtQI2M/?=
 =?us-ascii?Q?e4qSbgWq2bamvNzKthtvhgFIV3V3KHJR7dnVabGYohaKcYh+MO/aydUvw5Ep?=
 =?us-ascii?Q?ukskUjMAdbFvkiWy7U4wIBGDpqI0LAgSvRE3HpxzvPTQnnly3HbN2/WQJ069?=
 =?us-ascii?Q?FUebiR+zWCJx+F9ZKMWuXSQPvsMaqfH2/Yr0myhezglad39/Wb3OxWhtV3jH?=
 =?us-ascii?Q?TYSQW03sORyevxhi6efg4Kjkv/SYquNc8NSWOmBaK+QVUAKbJ/frMc4M/lXL?=
 =?us-ascii?Q?LedOT1DKUO9aSvtEIpZr6b3sMaLgYq30eTbt4/jep8leONZdw9KzdHy1Pyso?=
 =?us-ascii?Q?GNV3MtVqf6rmrpdCUGAgDXPOfXsRk3g0NSpTlY0ezjqvnAeELxSDJFKBVHjg?=
 =?us-ascii?Q?mGqVzfBmlSJ48/ASCHPvtYrM7uZELe/pvAzvNJRecqGPDUybY7ddBSoYFdml?=
 =?us-ascii?Q?QaqTrBxuhT9ut0UBH4LTVUq59mJ5LKcQD2PSEFmtaFY+/dWydGP0FPHVclbA?=
 =?us-ascii?Q?8g8WXcmc6fSqqNV0JP1/ByJRopwBJBQi24Os1cKum1e3YB4XG+Em6zp+pE78?=
 =?us-ascii?Q?Af8XiGqcbtnFbTGZh5v66MxSaSzKeP0evnaNEZjs4CntZ3+OBStUX3OSNABF?=
 =?us-ascii?Q?xbUrZUHstsdKicBsrLWBGTwcoINQbBjol2mPynETPCHZWMJHFX8IZb9silbA?=
 =?us-ascii?Q?mid9SNoeC9CHRqidsz3LIf97Vi8cFZKnm8NxjAJCqDySwlUTEG/FVi1O5jDl?=
 =?us-ascii?Q?tRxKujUnPLlOZhA6k0J38ap4j+9pBR/+hK4KsO7YB6OVDGB0Eoj5X2Q0DhLg?=
 =?us-ascii?Q?MpBNV88Kyn2bpaLGTCo1uHGHVTCwCxV5LcUKkLXPyc4ILw+eTRpIFfHp9A0D?=
 =?us-ascii?Q?4HxdfSmD64oBBzH1jqGx3LXc1DfejoW/GQFS1+N4Cg3wS1yjvYGfddZgBSvL?=
 =?us-ascii?Q?vNff9d7+ksCsmxMehCkCM3gubutLGi3askOYU9brqm6nsQexnagMOHUeW+dh?=
 =?us-ascii?Q?vZMyTdYvxsoXhX1hdL6/cMG9qkr02e0nHApRNaXVndSR1iNshqU7BNOYxACS?=
 =?us-ascii?Q?+5iJm4hWZ2V4Z86fQ6m8Ar7GuFMG2eglrcddYyLk6o76DuXOv1z4DWCRwkOe?=
 =?us-ascii?Q?SgasBHN0KXf15+uD5Q+SzoXL4Z8onWtf7C/BEWdMyI4yFyCGBgsd3LEp3wKh?=
 =?us-ascii?Q?gyD5VbEWHCPq7alxbtphBjNYYvJsZC9FgxiFdId75ifIGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?19EI/hyGCHIipHYyUn9tGmxnLcUrvF2NXpLRTpUGwnVMvkliN8Jjw42dhP1j?=
 =?us-ascii?Q?5XCemPqBrKGkSEAHh3pj1AK32Kdm1oX+uPFMlpCfV0EX11t+r9guZMaH5mVS?=
 =?us-ascii?Q?Elp9uXTun/W84vG7K/pSALisPwDIoDKlwVlBq4nzraIsdYjVxAme8+1nWUy+?=
 =?us-ascii?Q?OoAu6cauH/zCjZ2+BYdoiYzaFf0AYciGphav71kdsKkIgiFOOxQQDE3op3Ek?=
 =?us-ascii?Q?d/g1/pKk8Jq0TJoFlGPBP19dy7zVsHZS1VLyBRMr/kZbmd7S55/KulmAQzWr?=
 =?us-ascii?Q?IBTxlmIvN6EfGk+CJWkE9ojJAD+DFBJCixyUBCqtdiq+aJZH93l6G2Mfig+X?=
 =?us-ascii?Q?eMeCrwfdOgtMvLOgv7bnmx0xZENCLGtrCBz3bk7P3CW9JDNUZXI3j6mYGTa9?=
 =?us-ascii?Q?zIiJzLU0hkpXnwq5DLl/IrGOntnT3D0w8gsAafDModckCLtAbvKrcUAHG3N1?=
 =?us-ascii?Q?AD6+QnvTUAxpzBBnOrE+2odngeoeqrYWPFthtBUcKK5ieYmtjOEe8ySrGI0v?=
 =?us-ascii?Q?3xnCbps14H4ceInZc/4SE5DiE0tWiiBkyJFCATCSG686+EGJreVXJz76PizW?=
 =?us-ascii?Q?jCF9cUcZJc0Vz8jv30beFfuI0i9MsUNZ79ULN2yGpq1Euht5IKX5qgqxcMbi?=
 =?us-ascii?Q?lUzeQQk4oBuCBAb83efaGKcDrebRVM4XULH+xjuiNLdWzGZun/zzxpUOB3Ui?=
 =?us-ascii?Q?dqnswHy+8V5djhvAXWXqhi+VGK9CGtmWzyg0/Zpe4PZNoHUShivzVR+vbrAm?=
 =?us-ascii?Q?gwOUgEtEm9vSmKH2j16lHz+ZaZ3Ic25yZeNxKpwkbjIyd55rsm7N0MCuNs/I?=
 =?us-ascii?Q?tujVsmzE7BSx8YqBfJxV5uGsYxWLYgMQAlnAoHv8q5t0+qEKfczWcYKftrTk?=
 =?us-ascii?Q?QN1i+BrERHiD8lt04Q3W62pdqDOazvB/ZgRzouFnxYmefqOUPPK7DpvQJ864?=
 =?us-ascii?Q?VD/lQrt70InE/9SeLEngIpaXKY9dM3aEfjnipFvvBV1pNa36FneOB5tjk9rQ?=
 =?us-ascii?Q?AhXtSX4zcTS+ay1K412d27w7DeStvk3g4U3pfrKqqxuKhTqJd/RmG4ALjT6r?=
 =?us-ascii?Q?8Z0hJUpTt4kMnZ2EovRjEqqc21Fo3ZTSfF2uxQ1PwLdR1/3iLP10uvQquNZv?=
 =?us-ascii?Q?4COTNYetCG9I0A6Se3/OuoNZMZSB21i08gEjygXrmDg9FmBtqIDBxJW/lqPi?=
 =?us-ascii?Q?PnR9esIS14Aj+FjrZlUgE/Tqnb4kQlQeY9BPzCIWoVoyYYkNkX/KeT1VeycX?=
 =?us-ascii?Q?WGXBpCzch3F/XldkNBWgSIznuRVktGN//8EklOfa1vTePNEuaQ8R7MHhyXyB?=
 =?us-ascii?Q?UDugFDPGl/Pr2TA3HRE5a4NrRZAysJNC99G3yhoICbTKfr2amoMVA44pS2eL?=
 =?us-ascii?Q?trvCVrtOb0phWkAhGRmnNJ1mX1evH8y8k71qh1cnmlVn+DOmRW2EesU0Gd2a?=
 =?us-ascii?Q?G05wML6ArY65Pnxm7qJnGzIBRO6/WGSQlgCS8OT+djS7EYeLMYkxukqj9wP6?=
 =?us-ascii?Q?YQ0tQivPkN+9/RWj9C/KIJnXSyD0/XNnF3gxXWdb0+7qvmHGeVcpW+u1kg2T?=
 =?us-ascii?Q?v5W+304AUY9ordO0oCg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b40844-f377-42c0-350d-08dcea0ca2be
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:51:57.1505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5hcOA1TbHRbkyCbUY0r7C6XoTecDOVr+09Q87sofGpkEosQ3d9yVkAr33l49hm/iwYzYg6eS8TpVHSns2VDgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7434

On Fri, Oct 11, 2024 at 11:04:37AM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> On i.MX8QM, the DSP is in the VPU subsystem, which means that using the
> 'dsp' node from 'imx8-ss-audio.dtsi' is wrong as it's placed under the
> wrong bus. As such, drop it.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> index 3ee6e2869e3c..f8b577ebdbef 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> @@ -603,3 +603,5 @@ mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
>  #include "imx8qm-ss-audio.dtsi"
>  #include "imx8qm-ss-lvds.dtsi"
>  #include "imx8qm-ss-mipi.dtsi"
> +
> +/delete-node/ &dsp;
> --
> 2.34.1
>

