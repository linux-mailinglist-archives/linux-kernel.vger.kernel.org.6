Return-Path: <linux-kernel+bounces-191490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAED8D103B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EF7280A77
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118DE16726C;
	Mon, 27 May 2024 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="slRJNzhb"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2102.outbound.protection.outlook.com [40.92.22.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7605E1667C9;
	Mon, 27 May 2024 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716848738; cv=fail; b=iCLJMs+P8e6IPpDpwajYP0LhHxOPQZI3c/FZSd1OMtvGzwd/VVOSYPNW9EuPFZzTjzCR/xX6JEauPSPYmjEWIypozru4pi0Db5oA2TIk16Vdz7zuH2IM61Wk4v1gpU6d75fTlCjhrnHo086iEMx+CKCYAzjoPIKZnBoLjcH5r0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716848738; c=relaxed/simple;
	bh=gFzJfsNjTSVWd1VdmwUIG149v7mZhlJSNdc3k6LNUko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z8jVqxanmRanszqVYMr36X/su7bYx+XSpQzvGSJp+bZKONRdiSbigrxIA/UD06zUzN3k4Z7yCOIRa33tIQBI0PbI37EQbcOYWazYEuOvZ0fa/eho8aD3DDNetQeNIWQLYOE1RDd20IP1XJCDKk1xlqXyjucAWLhfCdoDpVfiLRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=slRJNzhb; arc=fail smtp.client-ip=40.92.22.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/bxBGWonBicrkoZTrC+pdcLsXV/cjE9kzacl15YEOSL6d13o8qRVz7ZIelnj1FxqI4C80MZN1s4SQkCBAkaV7mWlhOAC1OgwjiKfuE1LYVTt+OUrHCZsuExRBIoqoCUqdM6knKuxJQj/5NkIj0sQ2reKtK+VKulUO5QHV8vzIIqGNx4PeQvEcm8pLaolGsM6XNFdJp7ZPpkBAlEePlU6uMln6EoOKqjjL8FtDqcPV44a2Wh9RdstyCTEpANllfLRRTyAYekH8sqaCFtC+MqJaRelw6h3w9+VCK1oGSzI9Sb69VKl8Bl3a8fzcHDqHRhW49N6mKFA+8MILKjXL6dWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StnHZfopkJShKYIn0F3F/bUj5Gn55fmK2b6ih170rII=;
 b=XuCo+n/1pp1+EAnyE/LYINE7wtqcpk0hADRMVnBnCwQ9orr4U9sQWXVmaHK9Net7mCbTI6Ewn/HHmDdSZncwggSn8zR/Mm4O78p8MfNGy1+4eqgrcfZgV8Gwg17A5THExJOB8o17rw5D8kJ49Hrx7Cw7jm2Iq1zm0Rewga55ukVf6n21yKRi3Pq5J/ejC/NM+LWhKq5+7tiR+YFw263UcvEkc3BoX2mER5v8ANKNd+8GA/ngOkEg3h/JJKbab+eBRKStcBKIpQIuIeRNJxB6+2ukM+2JchMFQ2VqsFdVK+Xunroxh/mrt5sdbqlj/baids+coS33ls04tyzQtIf98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StnHZfopkJShKYIn0F3F/bUj5Gn55fmK2b6ih170rII=;
 b=slRJNzhbSdHKm4s6brR5OeZolD1ko2+2fOaQUPZbm/oB355Ufp9Wvu6pf3kxfpYnVKBf83mhlOlXUAKZYW6v8YRmcWV2iXlprt0jbM6IEuIS5YOZ3PBMApNaCrmaeNqz1QcY9OAKSdcsxBhrv9Hc8NJf3TfiZEVxFvpY3yRF36vYWzAcAwN3qIyrOgiiPwI9VZ4W/iU87VlmgyHIZ27oYt+EUiXtNMBPLgjv9C0NgrRxtXUyRhov/3k88t14bVRdHl6roAHX6VQwAP7x7581NhGMR3eoCdvVFSZRRMShNL29eV3LxbwXkaoHn0MWOVqDXC3ddWBdAtYOkaDVul9dYw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5945.namprd20.prod.outlook.com (2603:10b6:510:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 22:25:33 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 22:25:33 +0000
Date: Tue, 28 May 2024 06:25:21 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Chao Wei <chao.wei@sophgo.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 5/5] riscv: dts: sophgo: Add LicheeRV Nano board device
 tree
Message-ID:
 <IA1PR20MB49535CBF66DB31C2059C291ABBF02@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
 <20240527-sg2002-v1-5-1b6cb38ce8f4@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-sg2002-v1-5-1b6cb38ce8f4@bootlin.com>
X-TMN: [lJw+hvofuf8Eh06wMo8YuDP9EEvxLi/hMtXfrFQIRYw=]
X-ClientProxiedBy: TYWPR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <7odsikfri37ficuce4gb7qxwkrb62gnfoyldn74mzagz2trdvv@xyiu3fgovfxo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: aec4e3cf-00d2-48d4-e514-08dc7e9bec7d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	uuEtMfY2bi7EDPQuqS3M+p78LMgAdAQbbbBoUiTIjQ/hLpo7lY3y+mg9j5ZKFYN3SD6vFyBe1EkdgclDVKGm1++xs54XwNOUAiowDl0/MOtZBZaSZfM1F7H8VLPpmvHFqXMozmRg2LvubBeZ01AOCOBH9uEQAGRNSsrcPa/5ttDttnR7dLBN+f/3907mK4l2q/kCSttmNkfIKt+MDLvqZGmIXJYks62h69dHsPAuEfm8kNmruqI9pX2wH3UdUA4Od7D6mpV7YYssR8T49xZAjEQGFdCFF/wEhkUNXZkfb3AGl5Oy+yZGEnUJ3whV5nIQtgVQz0FmJvLu3QbHTJFcAfq/QtAq1wGERetU501Lkcuk5es8HIXvYEzR62Rc/gAzcQnhSBzWmh5j3lTbUmG0IVrggmB/WrauL8U+rmszEUjZTDSu7Y89mB7/u4ZzeUpHNAOIUmbuCsf3n0aHJ/q/kA27tStfvbIdZ92uf4Ug03MqKVhv1qkNO3SGw4Fa9y0aUVGQhzak2JYdzunuWjYbgspq0a9HGaKknrPXcZbfMSdDSK3lSy7tDqkKi1by7sg5odUM2xua/CNATZ5XLXRMANb4cDigk7L4hVOfmieApUh1kHMwMcBUnH4bk28zytpDxxRTR4LLuse2A1hWhLYDX+S+ImFOpUzuDpk5uIAE0MR9pc4FEGTaulz/3qqS4cfe
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+bvXGaq2dMAzRvdGEaUB0ETL6MHSRj+VR/UZiNOKhfc74egKUp+qej7u3401?=
 =?us-ascii?Q?M8uCIhfUF+EYQP7Vt7B1oQZbiGK/rgzt2Xy+iYEmkoAVeXstoS52MQIpIC8d?=
 =?us-ascii?Q?bnVCDAeTMWhsmaptKG4UNfKtC00tEkIVg0/XIXpIay/L6vT+mlr1HX3QNiF+?=
 =?us-ascii?Q?/YJjzB2GC0zQxJciTDixyNaC07namn3QK/V+tb5LPrCX/Ldo8ChpnR8FQmTf?=
 =?us-ascii?Q?fz3cZmR4VuU5Ry075bI0L0wl/sldWq6sIc6xKzjcwSh/cqt71HBJXFpmofl4?=
 =?us-ascii?Q?Fhp1HN5AJ4VDFOsyxefJa6n004+4kEkM70i+0o0qpJZkFdCLDSZXBGLYstaT?=
 =?us-ascii?Q?CjhD2dF20aL0QiHaAOZ3Gl+EoN89lpMEPsVFx25lN9zsgJyPEU78+x0yeTx2?=
 =?us-ascii?Q?mgdNwDjSNAngG+cO4K7/dhoitu3N1/x+slwDfN5dlq4pSav2PVRk0e+1QNS2?=
 =?us-ascii?Q?Vi+WyrCjFqaUtU0Fe5cHx8FD5IuGx4YHN1QXWdBdJeiZQJgLZTfUlrnJ8X7z?=
 =?us-ascii?Q?Tr4dGe9eLZTME8BogvUJqV1N69DrJHpsuoDmNihzEkO3hGk2AOl5RJsfN4ni?=
 =?us-ascii?Q?Svu4Wr8FTA056ksKtAj/q8zJdmvZPr5fO+GASs8MqKBxUDibch0WVMW5ryca?=
 =?us-ascii?Q?PceJTq1wJqxFUscNMWPRzQB+SIRyClIEpKejaWszZ6mbFDIZ50tQIquIB/sv?=
 =?us-ascii?Q?XC4UmrSVA378bLjq4jxRdIw8MMQYSh5rb0TwNTSh3x9minx86V+UECVGKQJl?=
 =?us-ascii?Q?R52fyKW/QAsiRcZWPMn823yQNhTADN1/jTGTT3nFQjNzoMY45flFL2yGsW8l?=
 =?us-ascii?Q?rCXRRMLlX47vkrX2NmMcizECmkB4o6H51Y/ccZBrhFT17WQhVPSb1hgGPcTa?=
 =?us-ascii?Q?o7rMOOMlx5NX/iNsaysAyDvL3QOY+FGyR45mrGrWPpMES85CwPnFbHy1o8V2?=
 =?us-ascii?Q?Nzqseg0zMS6DtDRZo42ucBs9QRZRrcNgaLV9IPMnBNwhq6sS8lNYyaiHPeVM?=
 =?us-ascii?Q?Lm+LCYcs0+QYnwnjVd0EYMt6AcFg7MWQmsckguBSW0yR+y6bkNSNG0TSW3P3?=
 =?us-ascii?Q?eO8GbucOT8x1pi+gG1WjE4vAbtXjoHniXYGDWeqTL1RBWg03VaLNDGwipZmB?=
 =?us-ascii?Q?UlUDqiHW0pMWCAWLTHkIbcTMj/sVDuOUFPeGGXXRlusT5T6/8IkBNmcT7B8j?=
 =?us-ascii?Q?MppzHK1PWmDtAgvZFaNF96Nfi+3qtxzEgBsXresxsg3mZZsKUNjprTufqjDy?=
 =?us-ascii?Q?3q/VNgsN80KbY9gBOult?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec4e3cf-00d2-48d4-e514-08dc7e9bec7d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 22:25:33.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5945

On Mon, May 27, 2024 at 12:28:21PM GMT, Thomas Bonnefille wrote:
> LicheeRV Nano [1] is an embedded development platform base on the SOPHGO
> SG2002 chip.
> 
> Add only support for UART.
> 

Although this is OK, I think you can also add sdhci node, it is already
supported.

> Link: https://wiki.sipeed.com/hardware/en/lichee/RV_Nano/1_intro.html
> [1]
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>  arch/riscv/boot/dts/sophgo/Makefile                |  1 +
>  .../boot/dts/sophgo/sg2002-lichee-rv-nano.dts      | 25 ++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
> index 57ad82a61ea6..5759b21805dc 100644
> --- a/arch/riscv/boot/dts/sophgo/Makefile
> +++ b/arch/riscv/boot/dts/sophgo/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
>  dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
> +dtb-$(CONFIG_ARCH_SOPHGO) += sg2002-licheerv-nano.dtb
>  dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
> diff --git a/arch/riscv/boot/dts/sophgo/sg2002-lichee-rv-nano.dts b/arch/riscv/boot/dts/sophgo/sg2002-lichee-rv-nano.dts
> new file mode 100644
> index 000000000000..aaad2733801b
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2002-lichee-rv-nano.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2024 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "sg2002.dtsi"
> +
> +/ {
> +	model = "LicheeRV Nano";
> +	compatible = "sipeed,licheerv-nano", "sophgo,sg2002";

Use the right version, rv nano have several versions with different 
peripherals. The compatible is good for the common file, but not the 
specific board.

> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};

It is also better to add all already support nodes, such as gpio, 
other uart port.

> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> 
> -- 
> 2.45.1
> 

