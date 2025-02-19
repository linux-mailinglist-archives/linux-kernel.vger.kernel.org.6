Return-Path: <linux-kernel+bounces-522523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4709A3CB73
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4987A8732
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4E6257431;
	Wed, 19 Feb 2025 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aJk34N3+"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013043.outbound.protection.outlook.com [52.101.67.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF8122E019;
	Wed, 19 Feb 2025 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000494; cv=fail; b=fAxCWBk79McXkpJ7f/iS0WJ0tFiNZNPlh0m2soJnIA7RtC2l2sDm8O/Cj929RLOExeHsjhjImCJFtKErXIvgqStUMZ/rfGESxcYiUAZOwGXuDZyQcPwy/lKWu4Ez1aZmJQ0plIuVGn4CzOFINAcMXzcqyf2wBXU+4rxM55KVpdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000494; c=relaxed/simple;
	bh=JQvTIMColSNn2XPmKl4T/gY8f48KM2a05vSVuzfaFHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eHhATvRDGv7S1U8zdhOYL1bIarcemdFsymqlwYGXuoB+6jRefAZ+bKYMsYaFYVXBLl+U/h9hTIkzJ28CoZwleDlZ6JF88bSaNEsyBY7boTUYhh3uigr5lO0VpmMRt9MeU+a9vnnhBFORSl71G9U1uNOZfsO0kx0LMSm6SyuxyoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aJk34N3+; arc=fail smtp.client-ip=52.101.67.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TY92P1XiRR/0Tu7dYMEy8qAZV2pUlo+vZC4iOr5/SGBFkkueSGaKTPY2Z0M7vNa9RUlYenN/7LgGUZsoDxd6ROQNvJ6i3eUiTsw6XUb1iqd0A4sjjPE7VjHrwFRYcnWZPIjw2XEIsTF0HAXjO5X9DEKc0YTqpYqP1N1lr+9hzTtCB5xRpPWncixz8ppUPPGZ9OkeEQ9oixIixBRbo+TYEoIiYnfsC4r3ERpL9zSUnPH5LTwIc0LqJN/EnK8u18g/EjqhJLe7brgAXZRCt5sM02iMD3x5UCpflfv1rQfUNvrGcUOgZWBkIyPKSQvPjMFzWRJVzHacf/kea/G+WqpmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4DAHrK4VdBkahKNkvFGOFbya0cGGNdjAhdQNuINnUI=;
 b=ucVBPBhVk0njdThTOtIawpXOkQ2EB2zQ0yZUMOMtjFK+44sKFz8YXdHDNf3xTOpf+rceYhXDk6ylVdv0DnEuRhElqFsWCPTEloXdPhgy596r0i5DQgATWZS7nyHNWaHv29GR42kDDIxRuJDG4FUS7jBZinrRnGhywH6hBuUhO0bQPLLqtgNt7YIQHpg0Hmckl3/a30izwIn6ZtlzZIR82r1pS4fh0sHZOngc12MjHiUMOyPyUCGCsfrqddesONFOL4gIofyEedv//IMI4e3j1LSk4hrPBqDvp5suQ4k/X0CQ/+fzeUz7QASP3i9hJ6Tq6ty5bNGZGyeJIauA2CjESA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4DAHrK4VdBkahKNkvFGOFbya0cGGNdjAhdQNuINnUI=;
 b=aJk34N3+iPPsm90O0se7/tb+JZIxSjX92BiJBChJbBagRV3ymA1RWTy4cCVESL/6vt9imqrtfPSNtDriITz5LKg++NfKjfRd8H8XXCIuwKgdZ+NySJgwLSgaMJO11OTWJ1iiowNUEpw29tgVD6ffY8hw1Gzxqf30nqy7lZ7rqyebfQ3c5/6BSGMkoBh46Y4Hg2g9vGt+/0RG+D6SyRXQIkwzAxqxSUM1/sRbL8tLXpoEyIUyw0S70gV7qMGBlxJN/WEeTVCj83yYcwYiINgleG3bFHTLUUMNjmoTFbESnLMoDGNmNyEg7UPPJALhA0VdGvHrsq52PFC0rE0a1BWfng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB8026.eurprd04.prod.outlook.com (2603:10a6:10:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 21:28:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:28:09 +0000
Date: Wed, 19 Feb 2025 16:28:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: p.zabel@pengutronix.de, robh@kernel.org, shawnguo@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	mathieu.poirier@linaro.org, shengjiu.wang@nxp.com, peng.fan@nxp.com,
	laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com
Subject: Re: [PATCH v2 3/8] arm64: dts: imx8mp: Add resets to dsp node
Message-ID: <Z7ZM4F/wmG3+QvvX@lizhi-Precision-Tower-5810>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
 <20250219192102.423850-4-daniel.baluta@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219192102.423850-4-daniel.baluta@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0b2116-a897-4c6f-297b-08dd512c4e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aZ8eLyuYuY08nN/QGTp6fi8lTeq9ei9rwtv7F0QoBxUN/fq/QWrkrRAfVWET?=
 =?us-ascii?Q?CJxjewK2wqcOtnUUKT0LHDU2Wd0enqvJHwsloRY24UaNbbpWc9Pp86GmWvxr?=
 =?us-ascii?Q?icTI0vPGs6J9RLQXFYUPd8d7w8kSzMWpslPCZjzzbDT/pBzepdFKbUmbTWSD?=
 =?us-ascii?Q?v9JowFmhYiCZV1S7lT5+S+Igjt9FaLyZbbxREqiWXrkJpkV6htJXqf+ygRQv?=
 =?us-ascii?Q?aAz9FojaCHHtC96/l0/EYn3WnW8U9knwmp3eLn2RP/p2w4W0wp/pa2vRbUM0?=
 =?us-ascii?Q?ZvZc65puzwB2+2fhRXlcOMOaJ9wNOWcmI9UxmP5q31Y0d+pKmEdnZC/Y1dnm?=
 =?us-ascii?Q?wU5XCFXmY9KbkSenyxBYNJkAIXUv1Unbfmy22GoSqA5FufIhrFwvNLSbJi8u?=
 =?us-ascii?Q?G/YRW0TgeLlr8u55ktoW9/NuDkomae8bDN4im5v7pJAmPNTC8kRLNJ/89WjZ?=
 =?us-ascii?Q?aBo06e1ieLEWuTZaAv7UNvA+bIKbRwJwMYPKKJwY32SxpMIOm2mfdsSp0MDP?=
 =?us-ascii?Q?roKA4Oz43y3szxsYOkCz+UpYffpBc6I52Hp6EbR2Yn2TiMRYpe1i2bp5Cqs6?=
 =?us-ascii?Q?U1wycRCI9EBaXnWZitYaMxK0Mwb43/sgN0JrHezDZI4Uo4bp6ACnYrRX0yiw?=
 =?us-ascii?Q?DEwELRjOeOSyr3R/6lRo78SN7gPxqs5xul1xmkkgVYNJcSwUmXzB6e3iU0gy?=
 =?us-ascii?Q?/r25ggX72dfi4+8oniCZT41RbyoPdNlwuHal5DtD1bSJFT05dyAhq9w+FnwB?=
 =?us-ascii?Q?NDVymB6DUGg3ZwfCzSpuTBrKcYt3s4JWGEf3qCBb39DBA6Rx5BBJDaNuNbaa?=
 =?us-ascii?Q?r/vCJSCsMXjmytC4GUwb1lRM9uqe33BWkl585QNwE8ir5xBqdmZ2A3F0lZ6j?=
 =?us-ascii?Q?Yhs9DWJoJmJQJwGpoK5xhrxqD6IKvojVcFdfLe4+Eban/zBfN9kHgPPkHuhD?=
 =?us-ascii?Q?lJVMJHBptYutwSWYiSekROHsR7J0u2+r5yUeYn9TFrXFq3SKh7RMmjXdeao2?=
 =?us-ascii?Q?3YOp1t5w7dAdj1YC/sR3X1lje1MmLcKZmjp3qshXAMQTygDWYnZ2kDSPqEsZ?=
 =?us-ascii?Q?Ce0UdwlkW0NTXZ2s909hpuauK8VOFy5rQ6M9pF0JRH9yekRT12ZRjae8I6cL?=
 =?us-ascii?Q?ZjpjYN+ePFM17pk0xkJHnZ+ERS+b98F+ymP8wq755JIOYp1i5ZEtZlWXSOfn?=
 =?us-ascii?Q?ktzWVvqAXcmT4aM81dXpEC3bwkxvXeVy/qjauCKEvg7EeJhN6JwbgXJ6OrQa?=
 =?us-ascii?Q?mNkuNMAF68YMlMFHIsJgpAmA4/YCYgvJI2YoG9A6fGKj55yOF9ufe+AW5534?=
 =?us-ascii?Q?5Q6fRQlzPiQF93xAOrLJvnuKuIIICosufGawrU1RAXPTf8qJoPe94KuAeOEE?=
 =?us-ascii?Q?hZSRCPf6VVC9vX/WqSVRExZQsoS8nJPS01lZ2w9DU/F8ATnCWOz6ifTWqK8L?=
 =?us-ascii?Q?B+UpawLaCJQEjS3idGZWnFiUj774L96t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4W4TyQ2T76vtS5eLe7VPUsFu/eLtY/uUakqNnQPX3rXdFv/RMA4jbQ7aJnzx?=
 =?us-ascii?Q?hEvYgMhRgSNuxGrqwkFtLP5c8CHoPi9ie9X3yZIq1TN+LIugIxMJd+4tYEzu?=
 =?us-ascii?Q?guff5VMTpAGhyvAlbqZrtMYSK6zdQCu7FJYOXAEwTvbUOPAR0vfYX04Tbn1V?=
 =?us-ascii?Q?x9Lle2DjL9mEXmfDCKRDvFksqWZIaWYWPhGcehth9em/P8L5QvJU905th99c?=
 =?us-ascii?Q?8pdYA29mOikWVL6++UVBueoCdWZxuBv+qW32h4i3SHDa5ElisiKXfScfDgfd?=
 =?us-ascii?Q?cNk+gpj1j/vcNoss7JcBaIOvHc6U8Rlr7kFm0RO87K561zGPVl3pA7yi616q?=
 =?us-ascii?Q?bzvQ+Kw+uflVPNpUt+zSy8M2gKeL5/2VYHeHZIRaFbnWR96qPUGL8LeosFxp?=
 =?us-ascii?Q?60YXyYdQ1AhBoTfuolnaLgoz6cZRcTHNFTRNYSI3JfVZf+NUo/i0D3xmsF3/?=
 =?us-ascii?Q?EZJIVR6ZJuqV29Sr4Qw4X0VBSLpSzbmc1RUXaS5biM5CRLD7sXWzNDliMH5J?=
 =?us-ascii?Q?PftJfXIccyejm6U1uRDjBgBfxqOMsbQC3DeMgFZZkicR9vgMpwdnvDJ0We7A?=
 =?us-ascii?Q?uCuZA8o62rm3DFSJREEqz/DWnyA1sESqDnNFB7ux4UuDRi1jpn6/FJBJ/AIp?=
 =?us-ascii?Q?ELq9zhGYFkqQyFZyFK6qEiOfg7sI0qwy1ksc53G6U4lztfcrNZKhIyvUfUp2?=
 =?us-ascii?Q?d5ZZFOMog+UgR0dUh9TmUjnRpiIhkLwSzqeiqxP0Ctbho7YGNx8lRSuvcAuY?=
 =?us-ascii?Q?wQqGfvYRDJjwnDgSaXNEnV9rA2QxKfF2MsWvxauzYy1biSJDsVPi3/vOVMPx?=
 =?us-ascii?Q?Cuodq85b1VFhNWARoduIzX3nnszvXssnyWMwMDJZDuAj9/6liRaewUSpWFxa?=
 =?us-ascii?Q?sP3HIvkaEvFMsasodILSZT+7x/8IiEaEQOKvp1RZOIvefMhUsXHOxzffZnI2?=
 =?us-ascii?Q?uC96bvfMLqJY0HRJifVUBa9pbYT93syAT1JO9NAGVueTRI9A8EzAgaKefX2f?=
 =?us-ascii?Q?qd5lKllfv2sj4AmTbXvTi/uLdcg+7dXB+pjO0aAbaUk3H2gIJK6LAPHpwDFq?=
 =?us-ascii?Q?TOT8Pe4oifywjp8JeCx7Yk5EekbCHNYK8u/fM7hbKfzpKLqtplakhzEWB2bB?=
 =?us-ascii?Q?5FbXuCXUvrniaFNTXyy99KP3fuJLIVhmkF47zkaZNqsAakAHHV4FPv+jeBvK?=
 =?us-ascii?Q?T5fXgHvAZFk4jfSs6RtIUZ0K5ZNQIsmqInGsA6tl3k1S2BgkZ1HSvynnKE5D?=
 =?us-ascii?Q?8UvT9Z7WQcfhHO/tlPdlEyHFq49uzQcKsTd6BjSi9U4XwZ23McnyOrq2NNKw?=
 =?us-ascii?Q?D8LHO698yk48JtWc/XkEeldY8XQ83o3GLbqLKYarR6oJDcCBDR097xVY0ztn?=
 =?us-ascii?Q?tUDD6mAyeJuHweqiHDoIhUVtwEB8C3iJBPcFPq/tok52rUeSpEdyAAhk9rYe?=
 =?us-ascii?Q?8hxe0PSvqr9MmS/xuQIvYZbIV8+38CkpVJG39oCKzhyEOfixOB835LV3JJSF?=
 =?us-ascii?Q?EIG6lyZdeG5i/dtV1aeyrPqQyXguuXbq+I8GKrMdywAwPy64DyUtI9HE+mqW?=
 =?us-ascii?Q?sZNFgFk+KPaB+qINWYJlFpgVsFgxbqvMWynrQTnN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0b2116-a897-4c6f-297b-08dd512c4e5d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:28:09.2740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s46jeXNgfs4ISGAvan3eAdS7JJi8EhlLVOoyhW+k4Pe2m8RJILdDHz3dNaXU3LMTFa7MAXVdknrcFZY+D+TkgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8026

On Wed, Feb 19, 2025 at 09:20:57PM +0200, Daniel Baluta wrote:
> This change adds resets to dsp node in order to be
> able to control the dsp run/stall bit.

Nit: Add resets to ... and wrap at 75 chars

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index e0d3b8cba221..780245d4ce61 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -6,6 +6,7 @@
>  #include <dt-bindings/clock/imx8mp-clock.h>
>  #include <dt-bindings/power/imx8mp-power.h>
>  #include <dt-bindings/reset/imx8mp-reset.h>
> +#include <dt-bindings/reset/imx8mp-reset-audiomix.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interconnect/fsl,imx8mp.h>
> @@ -2421,6 +2422,7 @@ dsp: dsp@3b6e8000 {
>  			mboxes = <&mu2 2 0>, <&mu2 2 1>,
>  				<&mu2 3 0>, <&mu2 3 1>;
>  			memory-region = <&dsp_reserved>;
> +			resets = <&audio_blk_ctrl IMX8MP_AUDIOMIX_DSP>;
>  			status = "disabled";
>  		};
>  	};
> --
> 2.25.1
>

