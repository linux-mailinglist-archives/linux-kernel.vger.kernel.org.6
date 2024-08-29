Return-Path: <linux-kernel+bounces-306157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86647963A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EDC28305D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822634D8C6;
	Thu, 29 Aug 2024 05:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lhP+G/wX"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2071.outbound.protection.outlook.com [40.92.47.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F8F42A9D;
	Thu, 29 Aug 2024 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910793; cv=fail; b=YEVJEY4BvoMtAjskm1w5lMCszstP0KCgJAHxIFwoHxx32Ih9E0adu0QaOSbIDvH9RiwxLrjiUht5IUGWJkUToBIGP9Xo3fgdS8ZwXJBRwqUjocdttsLR9MFvzf4aToJoQLLh0C9qCw8N7RU0maGDpF6O4Zk+9fEtl4wbt2+3csY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910793; c=relaxed/simple;
	bh=jdKMYAkhkiurXLWErqsGTKR22CHcCon17kI6tBvQd40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cxR0Ya+6r5kPmuuDcRX+VPCm6qiwcbjypm93cqoPAQHknOitEYuGoDpQ3e0ggzuJud4tYVyGcVRqPdTODrAn7UhFmeaockEegC+cqfTG8SEhGkjFUBBAAfGapv2SuFDHxFXswoLRNHhZHbORj7WZUxQCwqFfiYyQj3StJ3ZFGNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lhP+G/wX; arc=fail smtp.client-ip=40.92.47.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7U5PHa95gKJbqZ03EUMrRSI7pkG2yh4ofqloilyUrPKMic2P6TPTW59tly2MYL+pFAMAZuiueNK6x3yMH/s2nS2vN7F5St5fcyj6In39cWGZmA5b/TMR9rR4b/ktPqUv2gK8qLjhUfrKuhkonJkpqIqLHtsoV6nTAelyVFMOZEi8qG1w1ZTlpDEdh9FMJGmiQpZ2NcMRrk8J9XR0XKTs8LsYbSPc9Ge6wagnxDBL85p/njMg1/256Qgt68ViJ7z92A+hjg9toGg7ZtJgKX5sGzClyXESckPDX7zyGENRUx+h0iDdCxqejrlK23AXF4GC9sx9RyNXJ3muD2A2zbsgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx/whpwT4PSOF1e4B76P6dDxzPYBUiZX7eW/P54h5qM=;
 b=Sodzn2NlzLyVcQtotcmIFFm/o00Avk4xHT6+RsVyVY7irTsEfoYe/Erkdfwv/16U2xYh8davrd/ecZqOXjUTz6KSEE9i+HdkvxqRTJA3ka7SoM5hjuGRGj1plddM06RLCelmmkinL4jWlL0f8yKy3TlU0xQ6iJX/FCwXxagT8gh1cQfG7l5q9T4yYBzB6SwfkAeapYcyEDytHagG6NB0zXl/TJL9v+KY39vmJjdljoMO6wmjUZcpLX2ymiJEZhogEjqY9ObgpeW5Jn5qtOyve6g990Ms14AsmTDHy9AJc5HQx1JCSZsN8LJhGVYYTWXaox33htrHl29Kvlc6Gk/Cxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sx/whpwT4PSOF1e4B76P6dDxzPYBUiZX7eW/P54h5qM=;
 b=lhP+G/wXpAFaxeBZzfj9vJRAVYTfufPHt60mDccnoOcYmqok/RNA26cyKcXLuGaDcXVP4m4zm0QnQ7WX4+3siHRyyHU/lU1Nb4I6MjZgt0A4p/ok5bhMLfZalSHs0lJZyzNHHe9D6BDTTegEkzWAOss9ZcoZMIHWXKGbURm3zUXsaWiyzMsnIUmNXWGZwibNDgeNW66klu04+t/KgcuanvuJ9ajZAqLv/Vz41/8BVEp8r/JSaJO0p85vzVIsyBXVzxxz8sPZpv+/oN/ClOSuIeS5eUlUVBPEtzySuRphgohV7/ps4JDC43//rxv4WeemNl58Oh5ZnjAK4anMucPLww==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW4PR20MB5324.namprd20.prod.outlook.com (2603:10b6:303:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 05:53:08 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 05:53:07 +0000
Date: Thu, 29 Aug 2024 13:52:03 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Chao Wei <chao.wei@sophgo.com>, Conor Dooley <conor@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 4/4] riscv: dts: sophgo: Add LicheeRV Nano board
 device tree
Message-ID:
 <IA1PR20MB4953612773890B94FFD0C9EABB962@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
 <20240711-sg2002-v4-4-d97ec2367095@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-sg2002-v4-4-d97ec2367095@bootlin.com>
X-TMN: [9Hn/CEYPHkPAzj5/8s/WSQF6aj6gryIVtr2YGaDBOHs=]
X-ClientProxiedBy: TYAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:404:15::25) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <ppy4cw6pqx63wnoldwn6324umgkbiuu35zh5qmadhpqn5viura@x3xoizhi5x2l>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW4PR20MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c4dda6-1a3b-4a91-4bcf-08dcc7eedaf0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|15080799006|5072599009|19110799003|461199028|8060799006|1602099012|440099028|3412199025|4302099013|1710799026;
X-Microsoft-Antispam-Message-Info:
	cCaIwQTjzJNTqR1mYSxOMbTj1yju7AD0tNSQp44z/ROjOcn8NJfTJP+5CzUiC4Zb5VC9fF23ZFtytIiOswB17uT5p6KXwbYGblFIaipwLiE3e/7CGNTkNRpH06vh6NBpvvUHW5lQKMoDXKDDfTXG+Z3QCR80Q13oTiADDyEtj+/fqr2/cZ0G/caUCkPGket6eDeHqkwxqSOITD2cskBJ6b7/DDSRP3exwnoMbR87pqncwsKeI4yMmCeJF6iL6P9L386ZuaZ4pStmh+2DGqcLSzky/yWU1l+N3jRd6iBJYAeWcCHJhYCVGqggD1KXQG1OxLFQ77jv4Dat+9/el4mUaKZHTJ1BI2db4tuhTbskqojxEgoEhM6T5stDa6m52IsrEXEkIRkeDXs9k44KhvoPBC2OFfzReTXIJHBgl08Q5fFGFuEup/igmlL6Y3RxZOdbz7UbxGsihB6N/Y69QXeLD47Vfn9ACzFcs/RMf0NrQ9zFKDeqIRztu1WiNmZarKA095X4ysbJSCRWDYAu0S8ucts+KsueRe6ri0AGmH0XsR9sIHiFxZ5CjVxD/rWb4oeY6WEb3XL4laGocU2PUJngn5UgCn5Q7ekdSaNkNSzvqIBhYsZJbcdV6CIyc7z70xeISFpoL2Ug/Q3WqmCwuSahnfcNsp8YAe3+NnOFjP3r9xe2BIO9mPMJrap+2YKA619ReWceDkCxkckXOidywqlOxIIw1cyeruXGc5IVqxfw3+1JcZC0bIWdKqGqLUKWhbsUxDHeBzT28jiWB/u9cWFSJI9RkN1TS8Eh6A5mwSERewtldjsVsOSSAxc2GS/Ddjc6w+vxecHxoqI8WNt2Q6lqRKS+BdyyVzJtbxUb5FZ+YCv2TMQzQTtAVaa/xInPiaaX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IpIXzXQNC2z+5PP8Y/EB4Yke70T1UWbu7zLgkvxWi3gMWZ2DrOFhYIw4as15?=
 =?us-ascii?Q?QrYLzlx4MU2iu8IZ27oRNYHFySsCmnly+Brg6UgddxnpE+lqaHfZVChDz5L/?=
 =?us-ascii?Q?12ZpLHuQ0wcLUBABgfG4mk9+QDqR/dptEcAgtIDTKPXi2bsor6fpqJ9YNF/A?=
 =?us-ascii?Q?rsqYr6mM9oC0XD0c3iDvKvVUFfr5cefjsK3OrO5SbkH9Ij6GcCHnZsdW3ig6?=
 =?us-ascii?Q?G84+BoBIfPSS30RCkjIvmRulbqTcdfSKYT8XIeW9xn6KfKDFDZKox7JDYKWd?=
 =?us-ascii?Q?PH76QE+Ww3EtdFOgdKalHUth3TMRHUkqTr2EnaXcXFkIPs7X5ZWxh46uzpEG?=
 =?us-ascii?Q?Z+C99UTTQiB2ajE4ixT7+sWyLgmNaDAqt5FQD0i6yl4R8BiRfP/G9Hav8UEq?=
 =?us-ascii?Q?nlL3JPG6o0P4Ss197J+mmARbTKazu8fCg34agsGdqL9j+hv7asXhitogRAeb?=
 =?us-ascii?Q?Y634o86mb4Ka8xBJdahqHWEEvXIiitCTmxJVnqBybU1zKsXhgUtQ5Cr0wyCT?=
 =?us-ascii?Q?eE31zpeCNGGJY7qFofN/p87xa92enVC5I2Iz35++Fg/4NOO23VTHjdQhiLXm?=
 =?us-ascii?Q?d/loxT2MWHep8ltI4RzLjHObqEHJc4BOm85gWPUrBJWWcoIl/Ov4gy4gjWXJ?=
 =?us-ascii?Q?NcfYFHu+JaucJv46xzJb59g8+6PRywkA3SR/dpby4jHgSsJlepbR0LFPgcue?=
 =?us-ascii?Q?kyTNlbiL3iFEATMg92gfaCzO9POnUwm9A3DtjS/vgXMxK0P7r7nzs2PBCbdN?=
 =?us-ascii?Q?B1aXnEVZWHoJmgn4GbjMcx3GGV+ZmewSqlSKLwjWw7e2YeSndqg1oSPJY9J3?=
 =?us-ascii?Q?JkAgYJeA/K+O3jLjM0QI4w4KMX96FEOyeO0iTEvb87Xxzr7R+of3GawEOMQp?=
 =?us-ascii?Q?Cu0zu/fUj1ljBmqRUsvfoHUgiG6++JiEhbYwIVVN+Y9aevo56Rpt5YP8ymSq?=
 =?us-ascii?Q?3MCUWc0eDo/XlHMNosl5cEuJEvA04E7yPQcON+ffJPG8ppU7tcgeL6FOaO2U?=
 =?us-ascii?Q?0r5EfPkzwb3rh0sSq5UMvYvr+/WzHnUQvKWNnNqDNADD0AsLO32PbExMB1um?=
 =?us-ascii?Q?Eji+vGjOkLb8qZMLxOx5eKh0iKq0tO6uZzwtBHMEZZAiyMC3298Wu9gvZU8d?=
 =?us-ascii?Q?x/uZYR1yVRbXJtUTu9EmI7QOWEnF6UzYtx1qVhUwuKkMIxiRizlrkNnZBfMY?=
 =?us-ascii?Q?9I5xcbPnHfBfcGlpTHS62hubJOf4z1qLY+bBdBEiT7cOZyxsoFhjkHF2mwdI?=
 =?us-ascii?Q?LUV8DDTwS0rtzSyLepn7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c4dda6-1a3b-4a91-4bcf-08dcc7eedaf0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 05:53:07.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB5324

On Thu, Jul 11, 2024 at 12:01:31PM GMT, Thomas Bonnefille wrote:
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
>  .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts     | 54 ++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
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
> index 000000000000..fc98b6a0ddf7
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts
> @@ -0,0 +1,54 @@
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
> +	disable-wp;
> +};
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

Have you test you patch with a real board? Especially
for device "uart1" and "i2c0", I suspect your 
configuartion does not work by default.

