Return-Path: <linux-kernel+bounces-221925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DD290FAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77511C2171F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25048BA4B;
	Thu, 20 Jun 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="W/YXIoVw"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2015.outbound.protection.outlook.com [40.92.20.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116C91171D;
	Thu, 20 Jun 2024 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718845228; cv=fail; b=XJHRPRQfsgRzZ444+LsGsDJSJlV5XkbMyp9PeOCijMVvLzu2fTFTMF+MFB7GkPvYtg4qdFMjq5lunb0McLmuLw/wtFRVsOHSZrbfGncpoSF8T++As5uFxUlucyKxTzxq/Y5k6mOfHP2AigTHl9br2+OF4n5DTEJpFzntbZV/rho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718845228; c=relaxed/simple;
	bh=GAU2vLnA9QbAL1L1648kYGNMuXA5gCoJ/8/QndGawQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g+elh8kxtV7T4a37Hy+UHWKTUBlWEtAkEnbIoQf6Vu8MWMULdlN5GNW3tHDOfLU9oXQg8SbZP1a9LZ8wwXhcd/zRFPcRQDfKn8h6EThacl8dc2fC2fQ0+YrVkutctUNpHkiG5Yx9bjjWrv/QxCCkimwB+7FmopcgBCJ4U72t13U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=W/YXIoVw; arc=fail smtp.client-ip=40.92.20.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zy6+e+s+2uwf5JTloP61nsiqOaMoZzKWznwJUCYCVmXkbG2sDf6jnrfb57fxrZ9kIDlYmCtuPFMjG7CIQuR3EPZZc6XKmengI21LI8LVxc/41lQTO9uHX1weRxC47shp+JtgfsB+rPrl2bryhT3QbuH8ZVA3xW/kcaVZ7Nu+x0T3TSZxnxEVswySdx4m+4pw/GxBz6AbD9X5g84YlgePYqJ2rS2nU8K7AuOgC+N6L+UETRIDzNQOpmt3dkvIncXjgjEERmYxYpSppZMLmS+B3VuQiSBvCMW2dw18Z2JVg9oin2EeuVXQHJP2qjDkga4m6gXaI+DKteoyjm4I8bHsvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6ELvcuvu/w4UtFvDMOkXapy8B41Ar9VJFc1hr+ciks=;
 b=WX6fMGCvJ2kRGlx5MMseq88sTSfMttSIQsJ2m8F2UoPekYFN1GWA+5pdOnZIHf+ZUG6WK97tB72N8m7KL3Ggl4wtHR0QeRkK0x3LfMsZ05jsWHjEVCQlq6SYta7zFVP3142pOZSKKtb9r2WcreO5hWRV8JIBNK1PFfj7cOFMWZCfJZ9zOThVIT7dVRnuV00vYYWT4mGDW8LpvNaJIufEvDZS64b8IzVpaKuQjHhvdFmR5S/OB6hSbtFlvPfdrQC5+nZSDqcgxR4N6a+wF04dV2d9L9viaihFE6+urR/rN6ajoiziDfh3G8x/ibLr0qtFZuua33VOwQKxpe/PI1SkkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6ELvcuvu/w4UtFvDMOkXapy8B41Ar9VJFc1hr+ciks=;
 b=W/YXIoVwBFO6h335HdV3OAn9q2pf5VPtmy2brDBG2VVLOS3xgoGtEeDUgSvi7B9G/F5SWlVK6WyShjyFGMWEhBg7OyWaGpJZgOqVFKe8hRyJ8n5+TbU7oUqSm9JgUio4mgve3OFY/Cm0mtl77kY7TFF6ZTdctw8giCCdbFf0FNxsX9ml9FMGAKSq2hr4nRJ1BtqktkRyuGUj7lvka9QrXO8gllgKUBo9FP+vhcXIrLnLFKxa7dckIrJllARmB7SwzlWZhL5MX7Jq+59pS74xU7keV98XPhMYsu+L+Zlu96nOHCTGpjhHn3gPYvcEKA18aYcf8GFxE/KWSOkRJCEWIQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5510.namprd20.prod.outlook.com (2603:10b6:510:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 01:00:22 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 01:00:22 +0000
Date: Thu, 20 Jun 2024 09:00:04 +0800
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
Subject: Re: [PATCH v2 6/6] riscv: dts: sophgo: Add LicheeRV Nano board
 device tree
Message-ID:
 <IA1PR20MB49531ABF339729728958FFEBBBC82@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
 <20240612-sg2002-v2-6-19a585af6846@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612-sg2002-v2-6-19a585af6846@bootlin.com>
X-TMN: [HbU3fxqQ3HbuoXM+GMsFjRj9LNzzZje95tGHVikTIsQ=]
X-ClientProxiedBy: TYCP286CA0117.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <skrgd7saw4p6szkd5u54glpzqcdwt3sw243xps4jwk6qylwrjb@co5pe53zgp5j>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5510:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a98ab9-869c-4671-72cd-08dc90c45c80
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|440099025|4302099010|1602099009|1710799023;
X-Microsoft-Antispam-Message-Info:
	IiOHvMVkpStgDr/iWrqCPvnTZas8/i9PNY9iux1gex65dEgF5ZXK0GRo5YzeVJzXmoNVmTTz3m42H+bSE/2aqIwShUXOJ+LNEanVqWLeyvChUZp/Jw5/ge2JyTelJDwJ8PNmies0/aI351dfi2yra4kLoXTPNbPr3D3sn3H3Xzm1e3QGiWSt54xm0l+Gcpho3DQuE8zitMSbz9xYH7LCBOwbWVzTzFHTf69Y+nhMM6cIzs3V7yzdjsD14CMgWseu7cFsRS+IvNVmAsQO4iHgbY/xSEXPHueIZkG6YLmBKnbn6KA7YFjEcoFzj+xleqB9LzIpJhq679xR12IPRMuM7ISQ6A+XMfc/KlVL+bDBBsyMjKvpC8EEK5OsdS/2njzVt0n6/FPTN295cTSxIg9aV8XifLh9FZXc6e2ZHLAgIxtx+or6BTKqD5zU+TtK+eCGs3yiioIegQx4fR4iidBnSAYIrxZRatzABHXq40oxrwORHBeiXpuGpl86/cY8XPj6q8lGXQFEhtFd8dwlhuBZwoZPW7MDv0gnPyirrKJv/9rB5YQNVZbCX3jZjK2HJzb9Z0TIV1nejqV54kCjQ4wkyhFn2i781COT/uE1lhA5LCYPy8gPu3COVs+FYYbaz5H85zY2lhDOao3KPTPv5tygDqmyJEavIbuIw3fBgh6Cea2hEtmEo0P2LctdWaiHy+AJA4nPmeSFIA3wjwdVmW4/EkyfQdlYYeL8Ils0TEjGtOk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ycGPgxaqI+EDcz8YTFlsv76GAyB7jpWy+8b031xrEAXgmaEmq/YZ7i391qu2?=
 =?us-ascii?Q?haA6WCfblqr2jW6TJwlPsqdM3+nfqgnQUnD+db0WDMwNN8NWmc2YqDxXffoC?=
 =?us-ascii?Q?7A1XxELs2KDxD6f/c94PKCK3TRHDHDA+McnEFc+aCDrBhMfBrp9MSVNCPLiw?=
 =?us-ascii?Q?z/NZyYECj61ZGZgdPzTtTNevyx15/DeVAXESIFO879YqjW2ixJVLIX1L1mqZ?=
 =?us-ascii?Q?BR/gZi5cWZkpMX9PvBrIq+zU8BPRlQ4Ts/4FYaBbYklVS/7c9GlmHMY8421n?=
 =?us-ascii?Q?Zemm/c+iSOjLH/rDVGrB4M5YxLk8H3ZHQ9SlQ7epj6rptTWR5vfrJ3wVPCI9?=
 =?us-ascii?Q?8MuFpxgLI+9o/ySAAy6iMa6ST1Pa9sQRN9P3q2aN7VYE5JDyoAQfIMymGd8q?=
 =?us-ascii?Q?iqBpLCMdfYVtO926ZrM/TMh53TSFN/YWn2m6ab9dlCsKDPuPCwp9nQN8KvZj?=
 =?us-ascii?Q?XrssSw90zbps3d1wGvkaw86Atb0UbTWL7wpkQ/lLTOwX2Z9NfnZiYaueFlQg?=
 =?us-ascii?Q?1TgU3sRq/DopjMcR5rId2HULE8er6ogToWgCiFdhE5yHOuRJIO3vMUgJk9Fl?=
 =?us-ascii?Q?DNINofFr030Cj46zBDpWv6dhInADisXuYF3l2ebuinmolD6R6K00eHLQuPcF?=
 =?us-ascii?Q?FyRRdEOW8QldggrbK2PGiyV4atw0GoJAIGUDM8V7hM4NSV/t5xPAMDNGrScx?=
 =?us-ascii?Q?fyF7yAyXf2wFo32VcA4QqM3KoMMTe8+jgS03OYeve00XxXhposyj8WxU5mzw?=
 =?us-ascii?Q?uQjctCUGRVOykH3hODJ8hbbNHcwX74yGSxzwNE/u9lF+p0dZwuWyOFdi4JXf?=
 =?us-ascii?Q?fLeSZ6uRSk2BQlDwGBMTPU5ZLDDkH70KD1LzQkQEY3neuJLQSbiXdjXlBYmD?=
 =?us-ascii?Q?T5IW+8ArpQyHG6/t0pXeMU56ULEa21Cnx1uUeeOTNBq8fATHBUOfo036DfgX?=
 =?us-ascii?Q?iN/uxjwsyqwmFDvm6aabkjCCuxSugfsqzvxiKj4c5UDt+qGhvJK7eVQWEzTZ?=
 =?us-ascii?Q?M/NYiLwLf13PRhUozKakWnolqv3ra0GizymfUDm+4t9+Ww7Nr0SCQjeH2Fbg?=
 =?us-ascii?Q?kl8JBSkAAFdcpY9O0KhqtiaGBzjEVcHxojGpjdA/lOJJj04S2VKnpFBPtMtz?=
 =?us-ascii?Q?ii0wfdtyq7YmChe4PSYjYN2RBx/6IKqIbvFBym7Yc73D6Fr+7lFzFkOzfFSJ?=
 =?us-ascii?Q?14TIK2mD3xCRO/wkTAiQ8Z4mo4jlbika9CVizaFZ8B1doBecOD3/klDZxiJT?=
 =?us-ascii?Q?jkvAjQ5UFuPwK89RgqZQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a98ab9-869c-4671-72cd-08dc90c45c80
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 01:00:22.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5510

On Wed, Jun 12, 2024 at 10:02:36AM GMT, Thomas Bonnefille wrote:
> LicheeRV Nano B [1] is an embedded development platform based on the SOPHGO
> SG2002 chip, the B(ase) version is deprived of Wifi/Bluetooth and Ethernet.
> 
> Add only support for UART and SDHCI.
> 
> Link: https://wiki.sipeed.com/hardware/en/lichee/RV_Nano/1_intro.html [1]
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>  arch/riscv/boot/dts/sophgo/Makefile                |  1 +
>  .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts     | 53 ++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
> index 57ad82a61ea6..47d4243a8f35 100644
> --- a/arch/riscv/boot/dts/sophgo/Makefile
> +++ b/arch/riscv/boot/dts/sophgo/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
>  dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
> +dtb-$(CONFIG_ARCH_SOPHGO) += sg2002-licheerv-nano-b.dtb
>  dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
> diff --git a/arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts b/arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts
> new file mode 100644
> index 000000000000..d011fb15b097
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts
> @@ -0,0 +1,53 @@
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
> +	model = "LicheeRV Nano B";
> +	compatible = "sipeed,licheerv-nano-b", "sipeed,licheerv-nano", "sophgo,sg2002";
> +
> +	aliases {
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1;
> +		gpio2 = &gpio2;
> +		gpio3 = &gpio3;
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&osc {
> +	clock-frequency = <25000000>;
> +};
> +
> +&sdhci0 {
> +	status = "okay";
> +	bus-width = <4>;
> +	no-1-8-v;
> +	no-mmc;
> +	no-sdio;
> +};

Please add "disable-wp" property. Otherwise the card will be
probed as read-only.

> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> 
> -- 
> 2.45.2
> 

