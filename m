Return-Path: <linux-kernel+bounces-278170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8301F94ACFA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA931F251B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07ED129E93;
	Wed,  7 Aug 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ROyxKvbc"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2056.outbound.protection.outlook.com [40.107.247.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF2074E09;
	Wed,  7 Aug 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044902; cv=fail; b=a3mnkKhLM1M7KxbVk3jd7O2+tb39GE0FnCnqUOxS6+z6x9fKIuJFA26O01mMZR3M3AVHG0wx7s9Mn59zEz01mipln5v7Phthgnlrv6k57NyK16L/Oaej8zaeYekT+6ISuhSnJIEgloECCGZ2kyr7Hl4F4yak1YBub6CoNChVCQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044902; c=relaxed/simple;
	bh=I1MAPGZC7RXAMECI5vAi9vbcRGFUH3UNDuJ6LQEvFjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oHGRtOc4BBPHxLSfOtKakB7aOFRa/f2jOehBQJxUEXWPog9Q4dHziKa7HJvBDeRApXhRMTmWtbQQm9dtwX7ybRL5F0CbVgDnCA7N4V39cK2NvMuQfULVqnvYpaSsySRBRwDznsWyCJx8u5ttafW7U0X6f2IyY4yeoOhBWauNJBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ROyxKvbc; arc=fail smtp.client-ip=40.107.247.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o606cbEJwVdSr5g6WZdLSdSVx11GrQYdozqjfWBl11Ci04zEodr5xZJFN5PyzJeuxwxSKHKb/mP6a8JVKRDDbpkiMOTj+GOk0dwbBdVl5Y/3kPmXkhQq97v3bRC/n5bpuQgOYpYitAx3yZcS2eQhmq3qPvjP4s+xIVnhtq+61XbPJgEOjOOzPluGvvTDNSNVfdriMkQvhs2j+xTA0fl6yVKW2M3of+pWM2sYLjibb66wBPzgIrCsP5/HE7zkHNlpN5T2piKMJzPOro1rjdERZwnQJV+dWMlIgKpdyYsSW+9gT1otASpr9gSQ7pqYIbCrpLxLfAwZwmFKcG1B6R3mFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjenbptg98NVvrzdcjhNXlNdY1Nq65dqFtwJ1V+lT5o=;
 b=wHIgA5vyYEqm0ZAgV0LGhfi7tRtWMVrsSETxr7XMftl+YzsSxO0ypnZHmUwHNoI9gNdmzCyoOthjXa3RCcOarCRyenVX+j8zN2e2Wnjej89i7XjaCjXRL8uChNB6Uo7dt4dnzps+Vh1gQhfynhNNjDrj0McLt32aHlZtIK16LUdyzbpdxCWfpdLjrmXZzL/ffvPuqvQQH3WQvl3hFoBDi/fs7UnfOWA+2LqUxzmZaouJrOAC0GCGEUrwE4h2QDB/oI3SCjwhSZnRvS6ZieoKcCHlalCaL9aOadkwOmDC2oiJ1O2LNtRknMCfBs7+tFvwA5u8wd+HzUlFyYhRpGSEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjenbptg98NVvrzdcjhNXlNdY1Nq65dqFtwJ1V+lT5o=;
 b=ROyxKvbcDGxwn3AXSYGoGx/dRdB9qYMs+jswtnkdUP2dN6o7ZPO+nl/+TKuOceedn10tHwvtSudzdMNeH0lCZ5t9s5OM2FAxrUDBYxpLjAyjExe6RROBTsV6oheq1byY3VE/hs/n59zPMXlwqEpJDpVAG9yG/R+KorXkYJefOY/cKvL0HE5tLzlBKASpN948i1uKWBgBMHMA9TKwcPnATHVHiPi9cOXToKvzCr2NGTy0OJRhTRYGdBR9nDWkF9IAmr7qwez0/Gf+1l1LJglsxNDkiZYTEuX4Gf3Vocvnohu/RfY/36jytiZvPLm7qvzuXmdiklUrCeXtO67UkUWmNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7206.eurprd04.prod.outlook.com (2603:10a6:10:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 15:34:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 15:34:56 +0000
Date: Wed, 7 Aug 2024 11:34:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] arm64: dts: imx8-ss-conn: add PPS channel to the
 FEC nodes
Message-ID: <ZrOUGLJPYC/K4MlP@lizhi-Precision-Tower-5810>
References: <20240807144349.297342-1-francesco@dolcini.it>
 <20240807144349.297342-5-francesco@dolcini.it>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807144349.297342-5-francesco@dolcini.it>
X-ClientProxiedBy: BYAPR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fbd4459-fbaa-4741-1d64-08dcb6f67dc2
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?wMu2bROOJ7cMrM0o4CpKPvheOaeFgpo4S5bEwZvz1zAsX3os0hR9Vvq6qE6p?=
 =?us-ascii?Q?Dy4+PSStdBBnRxPFHKqFPTNVQwVTNZqxFLLzsmG3UR9EQ45VnkUvN8NZFz6M?=
 =?us-ascii?Q?oAcpv/XdZLQ15N0DlU4Bi6NywfV9pf5PXT16599V0Us8752gxqdqvBvQeqim?=
 =?us-ascii?Q?q0rO42Iui7Aq4d3AFp3fue1ScGtw4u09TCfPXpdLuHgGMsJvnEZI7zOAkPZb?=
 =?us-ascii?Q?LJG+LfEAM1ubbCZbUPUq5/YduziLHQXf9GSrIs0METW2NMzk414fANKFcm25?=
 =?us-ascii?Q?3YCffca9peL29OWHAs2Zo3i4xbRAI3Plt2IasQO/Rs6jHt82zJXN3kTbvwQQ?=
 =?us-ascii?Q?hzP0Jh9rgE0Orck2a5/Y7ck+m7jx4H+HNRMXndZodIQWd3rQdCVL8z3ys4J8?=
 =?us-ascii?Q?qyuecmm/IRch1PTwCKKRejiTeK1354zsIiSShjhc2c6FeuO3dGGBZ+QIrdG8?=
 =?us-ascii?Q?sjZDdv5fH9pfOXnGuuhtmOXUdsFAJ963dwW3P/44hw1sxSCS8ztS5lUA/1L0?=
 =?us-ascii?Q?7/BPD5ZdXdQ7BZq1I9xJRXVisa7OLH2v3DpVcdjpveen18PcNjc7TD5rJ6r/?=
 =?us-ascii?Q?oGxaTfc7GEpAyypZk9lYUWAZ6HjzSMrWHzR2KGb7JN0AVN/m9ZuJ5Xlgc6qa?=
 =?us-ascii?Q?oQw5hxknKxhqDrwjcQq/a53y4zcF2QVL8F+uuF8hKZOChLv/eiegYKQ/6/4B?=
 =?us-ascii?Q?xtRhckqBukCLcuiPbLs8jmKfZrND7EbPQOJ/r3OTdeTQPDFKA1AHgiOw3/M7?=
 =?us-ascii?Q?ect76T2kSeXQWhV2uYFDrI7AUMNTq+5usgr51p8g/5c9rFUuDkD2XLYvqzaO?=
 =?us-ascii?Q?X8MB2SzJJTjtAVUU8HX1eexAWJbZG0NGbkUSVvKvVDu/VJeD0aNI07bbr5ZK?=
 =?us-ascii?Q?uEfW3/0JKYlJ34r1V49VVQ3EreaFw1V3Ybn6UFrF38l9qaH1WIFTOTr5J1CN?=
 =?us-ascii?Q?XCw0T9Yq8smiGWOdysJsWGBjyQOJxLcLhvLvtA71+u/nS6DjQ3gNDmL9oXCy?=
 =?us-ascii?Q?ZzD/+lRbSzHspNRXR7IpjxaPJYw0Z50vmmKZOTtJbbiMddud6/a7Krna+ge2?=
 =?us-ascii?Q?4XUFIu1EeDHnTd/dWADSrhP4YVCjbIh4sTNmuy+6mYovPOx08ZN0CUF/crSX?=
 =?us-ascii?Q?duV6jHiN8WGd7niIM//dnAhqLz4+nMl5Csy/otNiHuJKjTdCaPCDfvzCMo3j?=
 =?us-ascii?Q?IPlgQC+YpPWYJbjiMYRQiB6Q8kH6I6RDxPjlwVX+ZrpzV8Hd/bAjvwB5rKm8?=
 =?us-ascii?Q?dXI6Oqdlt+T60mwfJHr0aKyw2xZhcWneMkWw7qrxnIAQbZNCJkGdDI6q80xj?=
 =?us-ascii?Q?7ikZvMZ/exQWivurwOGqfOpNO1AOiuKLYl8AHr79OasoMPZv0jlWUaeQe/ur?=
 =?us-ascii?Q?XgXtKAv4VVzAeItpwmFHNelF5571h8FIGYR/D7EDbo3+4UnoTA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?SHUC3LUEHmDf8bFMY9LjTAwx+UXq0tqTRaztokCiiCsiq6T7vy2XMR6dXNm5?=
 =?us-ascii?Q?hfTIdU0gStz1yDTJ0TDuNC0GDxiHAqaUA/S70JEcniinqPqWaIG4fTpHYK8f?=
 =?us-ascii?Q?dP9VBZbZrAyIFVMFfeMsKOexkkNrPU3a9N6jZ7t5fscuj33N+2AmMexjayph?=
 =?us-ascii?Q?RsvKbC5N7/bjIIJ+wfNpnD7JOvHtDp2jUZY6ZgY/+bxvT0+vD2kw9tKQ6ier?=
 =?us-ascii?Q?TXhCo1SEzEJQNm1eWuLSWBElz0QJejXxfH+K9zakKsauuyehYQ/w63wKDApC?=
 =?us-ascii?Q?Wd8aQNvSB7F9x6OlUsW0BBZ78fDVo8Vs3Og0UTuQUXzU+vLLMDOyREJxScLU?=
 =?us-ascii?Q?tJnNZG4SoYvteeY70qGl5k745g8LXDuf5RFDO2/nXyTWV1lShs7tbM212tWi?=
 =?us-ascii?Q?Elz1GITTwivgUU60Fb7B4K3K7aHVuTf3c6or/Wo7h8hLDV9mFW7PWg1SiI+G?=
 =?us-ascii?Q?HAtfNRmAJPlrvOEE2tzAWAbB07W1fkG3B8K9/BjD6Xx4BibAVYP/sYFAmxxp?=
 =?us-ascii?Q?PlSWORB+WBssz/4tNQneHfDqa7l3dSSxu5g4nPYmXl+C1AZ4q1ztCT+AquPZ?=
 =?us-ascii?Q?6XNOTQjjrm0zwD7Xlb+UG6IMPBR2NSZBb//4RZ0JGTh0NQqs6FXwlbjovQZT?=
 =?us-ascii?Q?OkErnr7DrOLWqusPqTHT9MI/dwe4S3bBBFB+XyB8rW48qo4vl9rsePRxK9TT?=
 =?us-ascii?Q?51jS3eRuFKMkcWoIKlHPKQsQQ7FFwOT5/4sEguRSA/gp6siAAOUhbk8sOSNM?=
 =?us-ascii?Q?CCXKqnjxbM/wfr260xiUqcOyE2hzkzAH4Hvy5oEi0merUy8nVQQdeiCY4ilo?=
 =?us-ascii?Q?E7/S/Y103yTY2ge2a0I6owKNuWnJhnI3Vw33EPtQbRv/Xgj/fXmNEBOafcDX?=
 =?us-ascii?Q?KM05fj6MB3gs3UNshK9KOCMEENEp3SPMQZcoSZve0Hy/lZQEmPKZR531U6DK?=
 =?us-ascii?Q?Fcj+f/GS2HFNGVg06+5+ulmV1zraTP/3p84/OcpJWdemDduHndOWYGHiL3UD?=
 =?us-ascii?Q?XGKGHMn5s+OYRLTz8phKpd6pa90eQsahJ5B2NteOK9cRIWmNeYpfFdtc8O6I?=
 =?us-ascii?Q?G4oYn05Z1XYM8YseNF4Xogw5VYTHjCvpC9F9QiQ+2VOICVwO7yaibe4Rf2kh?=
 =?us-ascii?Q?Da30XKILGpureAFEBzsCwjzT6FVPQEciYCT561yCe0FhrMjlE1x8/GNZmyI1?=
 =?us-ascii?Q?IpYgH2NGudJ6MONlcxJB/dnRYSltR7cX+9k+OiYKvedNGjKCsMDHY3ZPmIB1?=
 =?us-ascii?Q?8j7AedUdtAHS20hRsfhhu4OGEMpYq3MKymMTd8NpVRcrKGDy2ZVF17iWNji3?=
 =?us-ascii?Q?FsLsldeqaSXEby/q/stCleVK9QPByr9iJUsUaYYCd2SAHJ5VXJ/s0dOaA6b+?=
 =?us-ascii?Q?pEe3DCQ4XYA5yMHL3rwwVGH8uYyJDgF5XkQD/Yi/6L5KUAVs25jSl76QHpI7?=
 =?us-ascii?Q?TNOr6ZYN05ZO98oer1yqcw2kAlUVZ76HA30Aaoecey6zpDIhuTmuks15hOJp?=
 =?us-ascii?Q?REpvjGiaQxKWCHJfbWY9OFF9SM5mQxSj4bCnjf/FbkTPViy/fVfyoOpvfO+p?=
 =?us-ascii?Q?yKBj2L+qnZImiSjxN8Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbd4459-fbaa-4741-1d64-08dcb6f67dc2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 15:34:56.8777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOVnI3YoCrL1KnBCyqmzR0ALGAIkrlFDR29CHkKT7hVXwc9EP5CZorRpVTCep0a8w8FWet309XnfblbvSKxWlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7206

On Wed, Aug 07, 2024 at 04:43:49PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> On i.MX8 the FEC PPS channel is routed to the instance 1, not to the
> default 0.

According to my understand, it should be board level configuration. FEC
support output pps to any one. choose which one by board design.

Frank

>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> index a4a10ce03bfe..a9fd47041e3a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> @@ -121,6 +121,7 @@ fec1: ethernet@5b040000 {
>  		assigned-clock-rates = <250000000>, <125000000>;
>  		fsl,num-tx-queues = <3>;
>  		fsl,num-rx-queues = <3>;
> +		fsl,pps-channel = <1>;
>  		power-domains = <&pd IMX_SC_R_ENET_0>;
>  		status = "disabled";
>  	};
> @@ -141,6 +142,7 @@ fec2: ethernet@5b050000 {
>  		assigned-clock-rates = <250000000>, <125000000>;
>  		fsl,num-tx-queues = <3>;
>  		fsl,num-rx-queues = <3>;
> +		fsl,pps-channel = <1>;
>  		power-domains = <&pd IMX_SC_R_ENET_1>;
>  		status = "disabled";
>  	};
> --
> 2.39.2
>

