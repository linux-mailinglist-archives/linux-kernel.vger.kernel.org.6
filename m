Return-Path: <linux-kernel+bounces-258365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D709938713
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 02:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188571C20C27
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 00:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BCF4C7D;
	Mon, 22 Jul 2024 00:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nb/HAVSL"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2080.outbound.protection.outlook.com [40.92.42.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9512F56;
	Mon, 22 Jul 2024 00:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721608683; cv=fail; b=Gz1rErVPMvLC5U60CzHn0zGlctO7rX1qWyqKddF6kBxTGNrfX7CSLo6bf3f53quqG7Wf79BX0JErp0OasKqvW13DY3ClfAJwNre98L94WjrJDXNEtY1mPEJ78uedG+A1nXQjqkDu1VGqvUCuTV/dG2eqABGUwj6o6pPQZWOYI4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721608683; c=relaxed/simple;
	bh=RV+ZdR4p6q83zjWGOiaOMzJoKU9lEpcWcHI2HrbDk4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qd/PfCzHYYgq81sRPENtpl6NhBX8i56MUTwnqhW3TbCdwaJYbwC/FJ2vAo/WsPsF5Q4wrxEl4+GFGwTeV7o3P9fR0TMYlmi8T70/e1GslcRQhToPWgo0WWFtGjuEBD1wMSEiov2Kv1LVTMLhli9PgKVETutuYc4+q1ttHVg1caE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nb/HAVSL; arc=fail smtp.client-ip=40.92.42.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PT7LWZrTfl9pWhNwHx3T7Gcp2Se/I+Y67XsidEhQzZUm+gNKWXoKc8Mw7W63JOR7/PD6nmx2EouKbWtY6w0wlJR0twvSBSVeTTmWTR2wdBIBL9lpUkC4wLQh1In5+x11OGg+DwUU+b5gRAKJAe1vTkR+E3mwlEtpGq5N2yxx7nPvY6D5Ehx5VQ+6w3RjfGs1z63vZeWIt94KiA/AQ7EPCKUF3q+PKWDI3ymH9cZlpHY1o5X47f0RUgHYQNW52pHQKgSukNXrjbEdNChviUuK8gkhTR3kxgpnyOQ72ORVEnScu7W0dSPqKimts2jO8A/vJs7EpQHXAyTGHY1Rg7JnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OJg4hb3CLFxpqGwlOnt3jlb/J3tZGR3y/fMdOpIMng=;
 b=PpNFicA92Olj9sVdptvRfS2lw/q290tKop41TziV1MYaUnHKLM5GgIEM2cN3sO55Sk8NAGOvy8UAtjeRSqL8vKfyA7oK0/zCfFkf+lJuKkbZiy0eCeNGEKUkwiFFwigK0pbIJi4GqWtuD3n7DYofuAsBvl9N5KxwXpUDCbGkwtFYupqnpvYvUJWvI+fuw1f8YlyffEwR8d/u7KUUAyPLhdSfPWJJmwy4/zDUusE/kdIZZQe2JGt29AiLVnps8alOEcGNgOjf1ItMBNDrJjKp3CmVpHgYBX/8sgaxqw4WvD/CcG+BMWL+8v1igORAwcgeAMs8JFl7UobQXm8f/DourQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OJg4hb3CLFxpqGwlOnt3jlb/J3tZGR3y/fMdOpIMng=;
 b=nb/HAVSLXoHTCDQt6OU/CQwvyqctJPyiVT+MGU94A7Bq0BfvBEQZxNYVUHah4aI2ANZ1aEcI29oagRvGwfyNzQyIaoOL2Tx0oU/Ydx530ag6A3aYITytcbc9QwD7LreBwlnYC5h3gAtteHwWhOjhtPsC9uzEuxr42bsAcUtLJnG7hCIAourNJpQcJ/mJZNMXQYresfIrLRREhwO99px0QtrZm0Q0BC2muTyDUHOxk7GFev4kgcT9ZNP8QryWWLEjZuKpXQM/3O5s4Lc0CNHjThn33YO+5HGC94aK1uw6lDNwXlc0DA7ptda8KKabT0+zpf7/fkB41YIyhauDSCSU3Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN0PR20MB7213.namprd20.prod.outlook.com (2603:10b6:208:4c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 00:37:55 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 00:37:55 +0000
Date: Mon, 22 Jul 2024 08:37:35 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Yixun Lan <dlan@gentoo.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Yangyu Chen <cyy@cyyself.name>, 
	Jesse Taube <jesse@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Icenowy Zheng <uwu@icenowy.me>, Meng Zhang <zhangmeng.kevin@spacemit.com>, 
	Meng Zhang <kevin.z.m@hotmail.com>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: dts: spacemit: add pinctrl support for K1 SoC
Message-ID:
 <IA1PR20MB49534AC5F138D4FBD32CC8F8BBA82@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240719-02-k1-pinctrl-v1-0-239ac5b77dd6@gentoo.org>
 <20240719-02-k1-pinctrl-v1-1-239ac5b77dd6@gentoo.org>
 <IA1PR20MB4953D7FC538E7E67B00434AEBBAE2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240721122240.GYA18276.dlan.gentoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240721122240.GYA18276.dlan.gentoo>
X-TMN: [aY6iG5vjGQo+2x+phUANjPIEdRI/v13/Om0ntVn8PLY=]
X-ClientProxiedBy: PS2PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::23) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <ul2ljqco3yiwudmednldwlhcfwahb5d46n4whuwrplw45kcg24@awnbeqr7egbw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN0PR20MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: aacaa3d2-a479-440b-8201-08dca9e68696
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|440099028|3412199025|56899033|1710799026;
X-Microsoft-Antispam-Message-Info:
	044DYG45a1XWt+K+5v3cj4qqtNP9CwYGvrfJD7CN833FCVdkLssm3LA2RhlKY8yQb+JzNFB+MAge4myPS/8eOOzlsB274CjpvhABquWRgYI7n7qi5Sck0SScvDqwMY9GJeByrWRcq9N/+kyPjZM9jUXkGsvxqJzhc1OklSq8Gku8m/jFg9EGAEGBKnmW8LuIuKmOR7ZRP0opGCsgh/witFTyqOsnQcGForivwrB4LCudn94esL7vuaHN+SG+97FcO6mEB53R8AtNd7WrQBF2cbQ4NyKiEoEIt/hCz1yogBB/yBUteJya0iaBnamb/tPS3WORwRSBh2doz7bqjd01KluzzK6EFmmnbayWoZYCfpx5JgRZ9eZT/NtPwsKQMP/r5SnaLh9Bucrq6j6WQ6UaDYZ/MrMmeHtQjz/ygTmxdthsnXuAG0aUeFJTXIw1Cf992fYSalEXIy4D7XgkQZsJ6qvg5w+b6f363ChncAcORrqr5c1jFZLnz13y/wNTtPCismibVtykGVu5CaaGtYe/ziahD6UNqp9BfMP0YhUaabcFZ1XQBKZ1YwZnMaBX8GMDs8ghDK9umOxQ9jHXkalHonrcyLmbWu3r3YzV7rSPVoht4NoXAGYh1jH47j8n4BuJCujq1r6b3uzV3TmXibb/tNltDXSpvzG4qVPvkkqGnOcUgEFV23IIdv/V8QvDwQBn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XDLsaouJiiCBLcIHZCLFHAqgm4YcCOZqHmrWZys178ixHdH9VtQOBlLKae+t?=
 =?us-ascii?Q?WpZPwFoq5mBD2wlRLJlPNf+CaxPqv5k1y9SLkMLxyAuknnE5OUuiXZGrawN+?=
 =?us-ascii?Q?/p8/sPPPz4K4IsmExk1pFqtVgL+4axEU2ux73KEWKb2WJNwoL+R57VQ0wLgy?=
 =?us-ascii?Q?JS+/Al8FrjesDxp5LGA/LKx52S92gDf3QBIGFqZqlonWm+1f6eoxvZJM5ziU?=
 =?us-ascii?Q?h4M71LHmUw7NpAl7NgLh3oB7Nnj17dSgbap/N85kuc6fuLLqJ0M5Pb0Z08uP?=
 =?us-ascii?Q?p6Q0HvwMxLsrYkF8d3Au7dLUf4GOl2Gb02WZFKit/+cPBFrXiMkKtKVC4vDA?=
 =?us-ascii?Q?fV5BEUbDKPF6Z0iH4g/UzXjPhXggY1jWuH5QgVSyhm1/8z8V+aseX/qeqEPw?=
 =?us-ascii?Q?nJiUCIhbT1A6bMv38QaVd8pUeIytjC9teYrySibzZtrAzuGkP/nc8KxcGNcx?=
 =?us-ascii?Q?3i4ijPvArtfVWYsexhIHdj1BpJdj+TKi1wkAjg42u394jv6AZiNAMiUkaacn?=
 =?us-ascii?Q?seQVa6WeNhvS6PwzHCGb1K45rdgFyuUz0hsi5Yz9wDufe7T+ok7tN4Br56fZ?=
 =?us-ascii?Q?SXsi4LVfvCa+8rCwA902qJC/P7I2NDlTzsL4RsFuXe25XIlpsq0zzMR7z2uM?=
 =?us-ascii?Q?+vATcKi9esXePuFxA+w51s0qgDs7s3Q7pJZuEjGiJYXOWBbztHlkObZY4k1Q?=
 =?us-ascii?Q?kGImjEKkgN7DFXktIE9bzAJOvSSyF7GL7hYjH9MASbFr1GqVpTRERff55jC6?=
 =?us-ascii?Q?I6K1nQwRtKQJRNTd0jqyzddfLOgfv3LITYITEj/1kRmzMzUrVUk6yIzUivBR?=
 =?us-ascii?Q?YNQQDoK73wRSRg4m0K/RmMhikBYicBf1LtoDUc9vPaw+k2/j9eCRcEuRv3Gr?=
 =?us-ascii?Q?p+RqAUy6OmiODbo08ElMxHLR2d1ER+yVxzj46APFKJJhKDYraJEUtgTxlZhY?=
 =?us-ascii?Q?ZADipbIPSnCzMy0dQbGnUSvWcQ5vwdGgXSShE64RGsqkZLqzMcCBK4j1nzWp?=
 =?us-ascii?Q?WKw1nwm+RAOv7TtkNvRSsYCyFdkHwSZgQX/OXwFitxVy4ttMo1Cwj6V3jg5z?=
 =?us-ascii?Q?/mfMSGDYB5xC2amJI9royBpMWAPbU1OILCQfbOudplHQPzaXKJOmgFCo5sjP?=
 =?us-ascii?Q?bw4YDlSbCPCtZXnMlkGz8yiKup/iA5uwOv6zbCYQ0Yqrfv1fhaSb2pp2sbWB?=
 =?us-ascii?Q?UtN3bewkHYXnVC7TBtzlFilvJnheWkv9g4UZUo2dmQ2Ick7d30ZELZZuQEX+?=
 =?us-ascii?Q?1dsDjKJCpBOWbNdaU6Ru?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacaa3d2-a479-440b-8201-08dca9e68696
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 00:37:55.1828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB7213

On Sun, Jul 21, 2024 at 12:22:40PM GMT, Yixun Lan wrote:
> Hi Inochi:
> 
> On 08:30 Sat 20 Jul     , Inochi Amaoto wrote:
> > On Fri, Jul 19, 2024 at 12:21:39PM GMT, Yixun Lan wrote:
> > > SpacemiT's K1 SoC has a pinctrl controller which can be
> > > modeled using the pinctrl-single driver.
> > > 
> > > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > > ---
> > >  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 1746 ++++++++++++++++++++++++++
> > >  arch/riscv/boot/dts/spacemit/k1-pinctrl.h    |  220 ++++
> > >  arch/riscv/boot/dts/spacemit/k1.dtsi         |   14 +
> > >  3 files changed, 1980 insertions(+)
> > > 
> > > diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > new file mode 100644
> > > index 0000000000000..ad6f171d3ec1f
> > > --- /dev/null
> > > +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > @@ -0,0 +1,1746 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > > +/*
> > > + * Copyright (c) 2022 SpacemiT (Hangzhou) Technology Co. Ltd
> > 
> > Copyright should always match the year 2024, this apply to other files.
> > 
> Ok
> > > + * Copyright (c) 2024 Yixun Lan <dlan@gentoo.org>
> > > + */
> > > +
> > > +#include "k1-pinctrl.h"
> > > +
> > > +&pinctrl {
> > > +	camera0_pin: camera0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(53, 1) /* cam_mclk0 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	camera1_pin: camera1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(58, 1) /* cam_mclk1 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	camera2_pin: camera2-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(120, 1) /* cam_mclk2 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	can_0_pins: can-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(75, 3) /* can_tx0 */
> > > +			K1_PADCONF0(76, 3) /* can_rx0 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	can_1_pins: can-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(54, 2) /* can_tx0 */
> > > +			K1_PADCONF0(55, 2) /* can_rx0 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	clk_32k_out_0_pin: clk-32k-out-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(21, 3) /* 32k_out */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	clk_32k_out_1_pin: clk-32k-out-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(31, 3) /* 32k_out */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	clk_32k_out_2_pin: clk-32k-out-2-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(28, 4) /* 32k_out */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	gmac0_pins: gmac0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF1(00, 1) /* gmac0_rxdv */
> > > +			K1_PADCONF1(01, 1) /* gmac0_rx_d0 */
> > > +			K1_PADCONF1(02, 1) /* gmac0_rx_d1 */
> > > +			K1_PADCONF1(03, 1) /* gmac0_rx_clk */
> > > +			K1_PADCONF1(04, 1) /* gmac0_rx_d2 */
> > > +			K1_PADCONF1(05, 1) /* gmac0_rx_d3 */
> > > +			K1_PADCONF1(06, 1) /* gmac0_tx_d0 */
> > > +			K1_PADCONF1(07, 1) /* gmac0_tx_d1 */
> > > +			K1_PADCONF1(08, 1) /* gmac0_tx */
> > > +			K1_PADCONF1(09, 1) /* gmac0_tx_d2 */
> > > +			K1_PADCONF1(10, 1) /* gmac0_tx_d3 */
> > > +			K1_PADCONF1(11, 1) /* gmac0_tx_en */
> > > +			K1_PADCONF1(12, 1) /* gmac0_mdc */
> > > +			K1_PADCONF1(13, 1) /* gmac0_mdio */
> > > +			K1_PADCONF1(14, 1) /* gmac0_int_n */
> > > +			K1_PADCONF1(45, 1) /* gmac0_clk_ref */
> > > +		>;
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	gmac1_pins: gmac1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF1(29, 1) /* gmac1_rxdv */
> > > +			K1_PADCONF1(30, 1) /* gmac1_rx_d0 */
> > > +			K1_PADCONF1(31, 1) /* gmac1_rx_d1 */
> > > +			K1_PADCONF1(32, 1) /* gmac1_rx_clk */
> > > +			K1_PADCONF1(33, 1) /* gmac1_rx_d2 */
> > > +			K1_PADCONF1(34, 1) /* gmac1_rx_d3 */
> > > +			K1_PADCONF1(35, 1) /* gmac1_tx_d0 */
> > > +			K1_PADCONF1(36, 1) /* gmac1_tx_d1 */
> > > +			K1_PADCONF1(37, 1) /* gmac1_tx */
> > > +			K1_PADCONF1(38, 1) /* gmac1_tx_d2 */
> > > +			K1_PADCONF1(39, 1) /* gmac1_tx_d3 */
> > > +			K1_PADCONF1(40, 1) /* gmac1_tx_en */
> > > +			K1_PADCONF1(41, 1) /* gmac1_mdc */
> > > +			K1_PADCONF1(42, 1) /* gmac1_mdio */
> > > +			K1_PADCONF1(43, 1) /* gmac1_int_n */
> > > +			K1_PADCONF1(46, 1) /* gmac1_clk_ref */
> > > +		>;
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	hdmi_0_pins_0: hdmi-0-pins-0 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(86, 1) /* hdmi_tx_hscl */
> > > +			K1_PADCONF0(87, 1) /* hdmi_tx_hsda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	hdmi_0_pins_1: hdmi-0-pins-1 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(88, 1) /* hdmi_tx_hcec */
> > > +			K1_PADCONF0(89, 1) /* hdmi_tx_pdp */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	hdmi_1_pins: hdmi-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(59, 1) /* hdmi_tx_hscl */
> > > +			K1_PADCONF0(60, 1) /* hdmi_tx_hsda */
> > > +			K1_PADCONF0(61, 1) /* hdmi_tx_hcec */
> > > +			K1_PADCONF0(62, 1) /* hdmi_tx_pdp */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	i2c0_pins: i2c0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(54, 1) /* i2c0_scl */
> > > +			K1_PADCONF0(55, 1) /* i2c0_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	i2c1_pins: i2c1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(56, 1) /* i2c1_scl */
> > > +			K1_PADCONF0(57, 1) /* i2c1_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	i2c2_0_pins: i2c2-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(84, 4) /* i2c2_scl */
> > > +			K1_PADCONF0(85, 4) /* i2c2_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	i2c2_1_pins: i2c2-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(70, 2) /* i2c2_scl */
> > > +			K1_PADCONF0(71, 2) /* i2c2_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	i2c2_2_pins: i2c2-2-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(68, 3) /* i2c2_scl */
> > > +			K1_PADCONF0(69, 3) /* i2c2_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	i2c3_0_pins: i2c3-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(38, 2) /* i2c3_scl */
> > > +			K1_PADCONF0(39, 2) /* i2c3_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	i2c3_1_pins: i2c3-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(47, 4) /* i2c3_scl */
> > > +			K1_PADCONF0(48, 4) /* i2c3_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	i2c3_2_pins: i2c3-2-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(77, 3) /* i2c3_scl */
> > > +			K1_PADCONF0(78, 3) /* i2c3_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	i2c4_0_pins: i2c4-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(40, 2) /* i2c4_scl */
> > > +			K1_PADCONF0(41, 2) /* i2c4_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	i2c4_1_pins: i2c4-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(75, 5) /* i2c4_scl */
> > > +			K1_PADCONF0(76, 5) /* i2c4_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(0);
> > > +	};
> > > +
> > > +	i2c4_2_pins: i2c4-2-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(51, 4) /* i2c4_scl */
> > > +			K1_PADCONF0(52, 4) /* i2c4_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(0);
> > > +	};
> > > +
> > > +	i2c5_0_pins: i2c5-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(81, 5) /* i2c5_scl */
> > > +			K1_PADCONF0(82, 5) /* i2c5_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	i2c5_1_pins: i2c5-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(54, 5) /* i2c5_scl */
> > > +			K1_PADCONF0(55, 5) /* i2c5_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	i2c6_0_pins: i2c6-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(83, 5) /* i2c6_scl */
> > > +			K1_PADCONF0(90, 5) /* i2c6_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	i2c6_1_pins: i2c6-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(118, 2) /* i2c6_scl */
> > > +			K1_PADCONF0(119, 2) /* i2c6_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	i2c6_2_pins: i2c6-2-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(56, 5) /* i2c6_scl */
> > > +			K1_PADCONF0(57, 5) /* i2c6_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	i2c7_pins: i2c7-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(118, 1) /* i2c6_scl */
> > > +			K1_PADCONF0(119, 1) /* i2c6_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	i2c8_pins: i2c8-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(93, 0) /* pwr_scl */
> > > +			K1_PADCONF0(94, 0) /* pwr_sda */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	one_wire_0_pin: one-wire-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(110, 5) /* one_wire */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	one_wire_1_pin: one-wire-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(47, 5) /* one_wire */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	ir_rx_0_pin: ir-rx-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(97, 2) /* ir_rx */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	ir_rx_1_pin: ir-rx-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(79, 1) /* ir_rx */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	ir_rx_2_pin: ir-rx-2-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(58, 4) /* ir_rx */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	mmc1_pins_0: mmc1-pins-0 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(104, 0) /* mmc1_d3 */
> > > +			K1_PADCONF0(105, 0) /* mmc1_d2 */
> > > +			K1_PADCONF0(106, 0) /* mmc1_d1 */
> > > +			K1_PADCONF0(107, 0) /* mmc1_d0 */
> > > +			K1_PADCONF0(108, 0) /* mmc1_cmd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +
> > > +	mmc1_pins_1: mmc1-pins-1 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(109, 0) /* mmc1_clk */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	mmc1_fast_pins_0: mmc1-fast-pins-0 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(104, 0) /* mmc1_d3 */
> > > +			K1_PADCONF0(105, 0) /* mmc1_d2 */
> > > +			K1_PADCONF0(106, 0) /* mmc1_d1 */
> > > +			K1_PADCONF0(107, 0) /* mmc1_d0 */
> > > +			K1_PADCONF0(108, 0) /* mmc1_cmd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(3);
> > > +	};
> > > +
> > > +	mmc1_fast_pins_1: mmc1-fast-pins-1 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(109, 0) /* mmc1_clk */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(3);
> > > +	};
> > > +
> > > +	mmc2_pins: mmc2-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(15, 1) /* mmc2_data3 */
> > > +			K1_PADCONF0(16, 1) /* mmc2_data2 */
> > > +			K1_PADCONF0(17, 1) /* mmc2_data1 */
> > > +			K1_PADCONF0(18, 1) /* mmc2_data0 */
> > > +			K1_PADCONF0(19, 1) /* mmc2_cmd */
> > > +			K1_PADCONF0(20, 1) /* mmc2_clk */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	mn_clk_0_pin: mn-clk-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(92, 1) /* mn_clk */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	mn_clk_1_pin: mn-clk-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(81, 4) /* mn_clk */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	mn_clk_2_pin: mn-clk-2-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(44, 1) /* mn_clk */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	mn_clk_3_pin: mn-clk-3-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(20, 3) /* mn_clk */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	mn_clk_4_pin: mn-clk-4-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(23, 3) /* mn_clk */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	mn_clk_5_pin: mn-clk_5-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(32, 3) /* mn_clk */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	mn_clk2_0_pin: mn-clk2-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(91, 1) /* mn_clk2 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	mn_clk2_1_pin: mn-clk2-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(85, 3) /* mn_clk2 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pcie0_0_pins: pcie0-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(15, 2) /* PCIe0_perstn */
> > > +			K1_PADCONF0(16, 2) /* PCIe0_waken */
> > > +			K1_PADCONF0(17, 2) /* PCIe0_clkreqn */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pcie0_1_pins: pcie0-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(29, 4) /* PCIe0_perstn */
> > > +			K1_PADCONF0(30, 4) /* PCIe0_waken */
> > > +			K1_PADCONF0(31, 4) /* PCIe0_clkreqn */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pcie0_2_pins: pcie0-2-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(110, 4) /* PCIe0_perstn */
> > > +			K1_PADCONF0(115, 4) /* PCIe0_waken */
> > > +			K1_PADCONF0(116, 4) /* PCIe0_clkreqn */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pcie0_3_pins_0: pcie0-3-pins-0 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(53, 3) /* PCIe0_perstn */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pcie0_3_pins_1: pcie0-3-pins-1 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(54, 3) /* PCIe0_waken */
> > > +			K1_PADCONF0(55, 3) /* PCIe0_clkreqn */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pcie1_0_pins: pcie1-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(15, 4) /* PCIe1_perstn */
> > > +			K1_PADCONF0(16, 4) /* PCIe1_waken */
> > > +			K1_PADCONF0(17, 4) /* PCIe1_clkreqn */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pcie1_1_pins: pcie1-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(32, 4) /* PCIe1_perstn */
> > > +			K1_PADCONF0(33, 4) /* PCIe1_waken */
> > > +			K1_PADCONF0(34, 4) /* PCIe1_clkreqn */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pcie1_2_pins_0: pcie1-2-pins-0 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(56, 3) /* PCIe1_perstn */
> > > +			K1_PADCONF0(57, 3) /* PCIe1_waken */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pcie1_2_pins_1: pcie1-2-pins-1 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(58, 3) /* PCIe1_clkreqn */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pcie1_3_pins: pcie1-3-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(59, 4) /* PCIe1_perstn */
> > > +			K1_PADCONF0(60, 4) /* PCIe1_waken */
> > > +			K1_PADCONF0(61, 4) /* PCIe1_clkreqn */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pcie2_0_pins: pcie2-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(18, 4) /* PCIe2_perstn */
> > > +			K1_PADCONF0(19, 4) /* PCIe2_waken */
> > > +			K1_PADCONF0(20, 4) /* PCIe2_clkreqn */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pcie2_1_pins: pcie2-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(35, 4) /* PCIe2_perstn */
> > > +			K1_PADCONF0(36, 4) /* PCIe2_waken */
> > > +			K1_PADCONF0(37, 4) /* PCIe2_clkreqn */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pcie2_2_pins_0: pcie2-2-pins-0 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(62,  4) /* PCIe2_perstn */
> > > +			K1_PADCONF0(74,  4) /* PCIe2_waken */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +
> > > +	pcie2_2_pins_1: pcie2-2-pins-1 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(117, 4) /* PCIe2_clkreqn */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pcie2_3_pins: pcie2-3-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(111, 3) /* PCIe2_perstn */
> > > +			K1_PADCONF0(112, 3) /* PCIe2_waken */
> > > +			K1_PADCONF0(113, 3) /* PCIe2_clkreqn */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pcie2_4_pins_0: pcie2-4-pins-0 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0( 62, 4) /* PCIe2_perstn */
> > > +			K1_PADCONF0(112, 3) /* PCIe2_waken */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +
> > > +	pcie2_4_pins_1: pcie2-4-pins-1 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(117, 4) /* PCIe2_clkreqn */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pri_pins_0: pri-pins-0 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(70, 0) /* pri_tdi */
> > > +			K1_PADCONF0(71, 0) /* pri_tms */
> > > +			K1_PADCONF0(73, 0) /* pri_tck */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pmic_pins_0: pmic-pins-0 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(95, 0) /* vcxo_en */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pmic_pins_1: pmic-pins-1 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(96, 0) /* dvl0 */
> > > +			K1_PADCONF0(97, 0) /* dvl1 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pri_pins_1: pri-pins-1 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(72, 0) /* pri_tck */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm0_0_pin: pwm0-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(104, 5) /* pwm0 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	pwm0_1_pin: pwm0-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(14, 3) /* pwm0 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm0_2_pin: pwm0-2-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(22, 4) /* pwm0 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm1_0_pin: pwm1-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(105, 5) /* pwm1 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	pwm1_1_pin: pwm1-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(29, 3) /* pwm1 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm1_2_pin: pwm1-2-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(23, 4) /* pwm1 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm2_0_pin: pwm2-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(106, 5) /* pwm2 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	pwm2_1_pin: pwm2-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(22, 2) /* pwm2 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm2_2_pin: pwm2-2-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(30, 3) /* pwm2 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm2_3_pin: pwm2-3-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(24, 4) /* pwm2 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm3_0_pin: pwm3-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(107, 5) /* pwm3 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	pwm3_1_pin: pwm3-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(33, 3) /* pwm3 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm3_2_pin: pwm3-2-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(25, 4) /* pwm3 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm4_0_pin: pwm4-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(108, 5) /* pwm4 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	pwm4_1_pin: pwm4-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(34, 3) /* pwm4 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm5_0_pin: pwm5-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(109, 5) /* pwm5 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	pwm5_1_pin: pwm5-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(35, 3) /* pwm5 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm6_0_pin: pwm6-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(88, 4) /* pwm6 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm6_1_pin: pwm6-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(36, 3) /* pwm6 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm7_0_pin: pwm7-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(92, 2) /* pwm7 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm7_1_pin: pwm7-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(37, 2) /* pwm7 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm8_0_pin: pwm8-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(00, 3) /* pwm8 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm8_1_pin: pwm8-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(38, 4) /* pwm8 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm9_0_pin: pwm9-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(01, 3) /* pwm9 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm9_1_pin: pwm9-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(39, 4) /* pwm9 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm9_2_pin: pwm9-2-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(74, 2) /* pwm9 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm10_0_pin: pwm10-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(02, 3) /* pwm10 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm10_1_pin: pwm10-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(40, 4) /* pwm10 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm11_0_pin: pwm11-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(03, 3) /* pwm11 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm11_1_pin: pwm11-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(41, 4) /* pwm11 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm12_0_pin: pwm12-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(04, 3) /* pwm12 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm12_1_pin: pwm12-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(42, 4) /* pwm12 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm13_0_pin: pwm13-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(05, 3) /* pwm13 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm13_1_pin: pwm13-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(43, 4) /* pwm13 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm14_0_pin: pwm14-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(06, 3) /* pwm14 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm14_1_pin: pwm14-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(44, 4) /* pwm14 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm15_0_pin: pwm15-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(07, 3) /* pwm15 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm15_1_pin: pwm15-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(45, 4) /* pwm15 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm16_0_pin: pwm16-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(09, 3) /* pwm16 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm16_1_pin: pwm16-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(46, 4) /* pwm16 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm17_0_pin: pwm17-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(10, 3) /* pwm17 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm17_1_pin: pwm17-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(53, 2) /* pwm17 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm18_0_pin: pwm18-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(11, 3) /* pwm18 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm18_1_pin: pwm18-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(57, 4) /* pwm18 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm19_0_pin: pwm19-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(13, 3) /* pwm19 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	pwm19_1_pin: pwm19-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(63, 4) /* pwm19 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	qspi_pins_0: qspi-pins-0 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(98,  0) /* qspi_d3 */
> > > +			K1_PADCONF0(99,  0) /* qspi_d2 */
> > > +			K1_PADCONF0(100, 0) /* qspi_d1 */
> > > +			K1_PADCONF0(101, 0) /* qspi_d1 */
> > > +			K1_PADCONF0(102, 0) /* qspi_clk */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	qspi_pins_1: qspi-pins-1 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(103, 0) /* qspi_csi */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	rcpu_pins: rcpu-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(47, 1) /* r_uart0_tx */
> > > +			K1_PADCONF0(48, 1) /* r_uart0_rx */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	spi_lcd_0_pins_0: spi-lcd-0-pins-0 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(86, 3) /* dclk */
> > > +			K1_PADCONF0(87, 3) /* dcx */
> > > +			K1_PADCONF0(91, 3) /* dsi_te */
> > > +			K1_PADCONF0(92, 3) /* smpn_rstb */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	spi_lcd_0_pins_1: spi-lcd-0-pins-1 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(88, 3) /* din */
> > > +			K1_PADCONF0(89, 3) /* dout0 */
> > > +			K1_PADCONF0(90, 3) /* dout1 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	spi_lcd_1_pins_0: spi-lcd-1-pins-0 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(70, 3) /* dclk */
> > > +			K1_PADCONF0(71, 3) /* dcx */
> > > +			K1_PADCONF0(73, 3) /* dout0 */
> > > +			K1_PADCONF0(74, 3) /* dout1 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	spi_lcd_1_pins_1: spi-lcd-1-pins-1 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0( 72, 3) /* din */
> > > +			K1_PADCONF0(114, 3) /* dsi_te */
> > > +			K1_PADCONF0( 63, 3) /* smpn_rstb */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	sspa0_0_pins_0: sspa0-0-pins-0 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(118, 3) /* sspa0_clk */
> > > +			K1_PADCONF0(119, 3) /* sspa0_frm */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	sspa0_0_pins_1: sspa0-0-pins-1 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(120, 3) /* sspa0_txd */
> > > +			K1_PADCONF0(121, 3) /* sspa0_rxd */
> > > +			K1_PADCONF0(122, 3) /* sspa0_sysclk */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	sspa0_1_pins: sspa0-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(58,  2) /* sspa0_sysclk */
> > > +			K1_PADCONF0(111, 2) /* sspa0_clk */
> > > +			K1_PADCONF0(112, 2) /* sspa0_frm */
> > > +			K1_PADCONF0(113, 2) /* sspa0_txd */
> > > +			K1_PADCONF0(114, 2) /* sspa0_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	sspa1_pins: sspa1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(24, 3) /* sspa1_sysclk */
> > > +			K1_PADCONF0(25, 1) /* sspa1_sclk */
> > > +			K1_PADCONF0(26, 1) /* sspa1_frm */
> > > +			K1_PADCONF0(27, 1) /* sspa1_txd */
> > > +			K1_PADCONF0(28, 1) /* sspa1_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	ssp2_0_pins: ssp2-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(75, 1) /* ssp2_sclk */
> > > +			K1_PADCONF0(76, 1) /* ssp2_frm */
> > > +			K1_PADCONF0(77, 1) /* ssp2_txd */
> > > +			K1_PADCONF0(78, 1) /* ssp2_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	ssp2_1_pins: ssp2-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(64, 3) /* ssp2_sclk */
> > > +			K1_PADCONF0(65, 3) /* ssp2_frm */
> > > +			K1_PADCONF0(66, 3) /* ssp2_txd */
> > > +			K1_PADCONF0(67, 3) /* ssp2_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	ssp3_0_pins: ssp3-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(75, 2) /* ssp3_sclk */
> > > +			K1_PADCONF0(76, 2) /* ssp3_frm */
> > > +			K1_PADCONF0(77, 2) /* ssp3_txd */
> > > +			K1_PADCONF0(78, 2) /* ssp3_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	ssp3_1_pins: ssp3-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(59, 2) /* ssp3_sclk */
> > > +			K1_PADCONF0(60, 2) /* ssp3_frm */
> > > +			K1_PADCONF0(61, 2) /* ssp3_txd */
> > > +			K1_PADCONF0(62, 2) /* ssp3_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart0_0_pins: uart0-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(104, 3) /* uart0_txd */
> > > +			K1_PADCONF0(105, 3) /* uart0_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	uart0_1_pins: uart0-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(80, 3) /* uart0_rxd */
> > > +			K1_PADCONF0(108, 1) /* uart0_txd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	uart0_2_pins: uart0-2-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(68, 2) /* uart0_txd */
> > > +			K1_PADCONF0(69, 2) /* uart0_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart2_pins: uart2-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(21, 1) /* uart2_txd */
> > > +			K1_PADCONF0(22, 1) /* uart2_rxd */
> > > +			K1_PADCONF0(23, 1) /* uart2_cts_n */
> > > +			K1_PADCONF0(24, 1) /* uart2_rts_n */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(0);
> > > +	};
> > > +
> > > +	uart3_0_pins: uart3-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(81, 2) /* uart3_txd */
> > > +			K1_PADCONF0(82, 2) /* uart3_txd */
> > > +			K1_PADCONF0(83, 2) /* uart3_cts_n */
> > > +			K1_PADCONF0(84, 2) /* uart3_rts_n */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart3_1_pins: uart3-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(18, 2) /* uart3_txd */
> > > +			K1_PADCONF0(19, 2) /* uart3_rxd */
> > > +			K1_PADCONF0(20, 2) /* uart3_cts_n */
> > > +			K1_PADCONF0(21, 2) /* uart3_rts_n */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart3_2_pins: uart3-2-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(53, 4) /* uart3_txd */
> > > +			K1_PADCONF0(54, 4) /* uart3_rxd */
> > > +			K1_PADCONF0(55, 4) /* uart3_cts_n */
> > > +			K1_PADCONF0(56, 4) /* uart3_rts_n */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart4_0_pins: uart4-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(100, 4) /* uart4_txd */
> > > +			K1_PADCONF0(101, 4) /* uart4_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	uart4_1_pins: uart4-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(81, 3) /* uart4_cts_n */
> > > +			K1_PADCONF0(82, 3) /* uart4_rts_n */
> > > +			K1_PADCONF0(83, 3) /* uart4_txd */
> > > +			K1_PADCONF0(84, 3) /* uart4_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart4_2_pins: uart4-2-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(23, 2) /* uart4_txd */
> > > +			K1_PADCONF0(24, 2) /* uart4_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart4_3_pins: uart4-3-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(33, 2) /* uart4_txd */
> > > +			K1_PADCONF0(34, 2) /* uart4_rxd */
> > > +			K1_PADCONF0(35, 2) /* uart4_cts_n */
> > > +			K1_PADCONF0(36, 2) /* uart4_rts_n */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart4_4_pins: uart4-4-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(111, 4) /* uart4_txd */
> > > +			K1_PADCONF0(112, 4) /* uart4_rxd */
> > > +			K1_PADCONF0(113, 4) /* uart4_cts_n */
> > > +			K1_PADCONF0(114, 4) /* uart4_rts_n */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart5_0_pins: uart5-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(102, 3) /* uart5_txd */
> > > +			K1_PADCONF0(103, 3) /* uart5_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	uart5_1_pins: uart5-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(25, 2) /* uart5_txd */
> > > +			K1_PADCONF0(26, 2) /* uart5_rxd */
> > > +			K1_PADCONF0(27, 2) /* uart5_cts_n */
> > > +			K1_PADCONF0(28, 2) /* uart5_rts_n */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart5_2_pins: uart5-2-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(42, 2) /* uart5_txd */
> > > +			K1_PADCONF0(43, 2) /* uart5_rxd */
> > > +			K1_PADCONF0(44, 2) /* uart5_cts_n */
> > > +			K1_PADCONF0(45, 2) /* uart5_rts_n */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart5_3_pins: uart5-3-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(70, 4) /* uart5_txd */
> > > +			K1_PADCONF0(71, 4) /* uart5_rxd */
> > > +			K1_PADCONF0(72, 4) /* uart5_cts_n */
> > > +			K1_PADCONF0(73, 4) /* uart5_rts_n */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart6_0_pins: uart6-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(85, 2) /* uart6_cts_n */
> > > +			K1_PADCONF0(86, 2) /* uart6_txd */
> > > +			K1_PADCONF0(87, 2) /* uart6_rxd */
> > > +			K1_PADCONF0(90, 2) /* uart6_rts_n */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart6_1_pins: uart6-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(00, 2) /* uart6_txd */
> > > +			K1_PADCONF0(01, 2) /* uart6_rxd */
> > > +			K1_PADCONF0(02, 2) /* uart6_cts_n */
> > > +			K1_PADCONF0(03, 2) /* uart6_rts_n */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart6_2_pins: uart6-2-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(56, 2) /* uart6_txd */
> > > +			K1_PADCONF0(57, 2) /* uart6_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart7_0_pins: uart7-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(88, 2) /* uart7_txd */
> > > +			K1_PADCONF0(89, 2) /* uart7_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart7_1_pins: uart7-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(04, 2) /* uart7_txd */
> > > +			K1_PADCONF0(05, 2) /* uart7_rxd */
> > > +			K1_PADCONF0(06, 2) /* uart7_cts_n */
> > > +			K1_PADCONF0(07, 2) /* uart7_rts_n */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart8_0_pins: uart8-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(82, 4) /* uart8_txd */
> > > +			K1_PADCONF0(83, 4) /* uart8_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart8_1_pins: uart8-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(08, 2) /* uart8_txd */
> > > +			K1_PADCONF0(09, 2) /* uart8_rxd */
> > > +			K1_PADCONF0(10, 2) /* uart8_cts_n */
> > > +			K1_PADCONF0(11, 2) /* uart8_rts_n */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart8_2_pins: uart8-2-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(75, 4) /* uart8_txd */
> > > +			K1_PADCONF0(76, 4) /* uart8_rxd */
> > > +			K1_PADCONF0(77, 4) /* uart8_cts_n */
> > > +			K1_PADCONF0(78, 4) /* uart8_rts_n */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_3V_DS(4);
> > > +	};
> > > +
> > > +	uart9_0_pins: uart9-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(12, 2) /* uart9_txd */
> > > +			K1_PADCONF0(13, 2) /* uart9_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart9_1_pins: uart9-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(110, 3) /* uart9_cts_n */
> > > +			K1_PADCONF0(115, 3) /* uart9_rts_n */
> > > +			K1_PADCONF0(116, 3) /* uart9_txd */
> > > +			K1_PADCONF0(117, 3) /* uart9_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	uart9_2_pins: uart9-2-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(72, 2) /* uart9_txd */
> > > +			K1_PADCONF0(73, 2) /* uart9_rxd */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	usb0_0_pins: usb0-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(125, 1) /* vbus_on0 */
> > > +			K1_PADCONF0(126, 1) /* usb_id0 */
> > > +			K1_PADCONF0(127, 1) /* drive_vbus0_iso */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	usb0_1_pins_0: usb0-1-pins-0 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(63, 1) /* drive_vbus0_iso */
> > > +			K1_PADCONF0(64, 1) /* vbus_on0 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	usb0_1_pins_1: usb0-1-pins-1 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(65, 1) /* usb_id0 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	usb1_0_pin: usb1-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(124, 1) /* drive_vbus1_iso */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	usb1_1_pin: usb1-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(66, 1) /* drive_vbus1_iso */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	usb2_0_pins: usb2-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(121, 2) /* vbus_on2 */
> > > +			K1_PADCONF0(122, 2) /* usb_id2 */
> > > +			K1_PADCONF0(123, 1) /* drive_vbus2_iso */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	usb2_1_pins_0: usb2-1-pins-0 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(67, 1) /* drive_vbus2_iso */
> > > +			K1_PADCONF0(68, 1) /* vbus_on2 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	usb2_1_pins_1: usb2-1-pins-1 {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(69, 1) /* usb_id2 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	vcxo_0_pins: vcxo-0-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(96, 3) /* vcxo_req */
> > > +			K1_PADCONF0(97, 3) /* vcxo_out */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	vcxo_1_pins: vcxo-1-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(16, 3) /* vcxo_req */
> > > +			K1_PADCONF0(17, 3) /* vcxo_out */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	vcxo_2_pins: vcxo-2-pins {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(89, 4) /* vcxo_req */
> > > +			K1_PADCONF0(90, 4) /* vcxo_out */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	vcxo_out_0_pin: vcxo-out-0-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(91, 2) /* vcxo_out_0 */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(1);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(0);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +
> > > +	vcxo_out_1_pin: vcxo-out-1-pin {
> > > +		pinctrl-single,pins = <
> > > +			K1_PADCONF0(12, 3) /* vcxo_out */
> > > +		>;
> > > +		pinctrl-single,bias-pullup = PINCTRL_PULLUP(0);
> > > +		pinctrl-single,bias-pulldown = PINCTRL_PULLDN(1);
> > > +		pinctrl-single,drive-strength = PINCTRL_1V8_DS(2);
> > > +	};
> > > +};
> > 
> > I see that you may add all the pin definition for the SoC. It is OK,
> > but I think these may be too much as some board may have different
> > configurations. I think adding the common pin definition to this file
> > is enough. Others should be left in the board dts.
> > 
> 
> Generally, I agree with your idea, the configurations are more specific to
> customized user case, so spill them out to board dts would be a feasible idea
> 
> But, another concern, if we have more boards added, should we have a common
> file (like k1-pinconf.dtsi) to collect common settings, so we don't have
> to duplicate them in all board dts files?
> 

I think using common file is OK. But this should be limited, I do not 
want to move the pin from common file to the board dts later. :)

> > > diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.h b/arch/riscv/boot/dts/spacemit/k1-pinctrl.h
> > > new file mode 100644
> > > index 0000000000000..22eec2293ee33
> > > --- /dev/null
> > > +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.h
> > > @@ -0,0 +1,220 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> > > +/*
> > > + * Copyright (c) 2022 SpacemiT (Hangzhou) Technology Co. Ltd
> > > + * Copyright (c) 2024 Yixun Lan <dlan@gentoo.org>
> > > + */
> > > +
> > > +#ifndef __DT_BINDINGS_K1_PINCTRL_H
> > > +#define __DT_BINDINGS_K1_PINCTRL_H
> > > +
> > > +/* pin offset */
> > > +#define PINID(x)	((x) + 1)
> > > +
> > > +#define GPIO_00     PINID(0)
> > > +#define GPIO_01     PINID(1)
> > > +#define GPIO_02     PINID(2)
> > > +#define GPIO_03     PINID(3)
> > > +#define GPIO_04     PINID(4)
> > > +#define GPIO_05     PINID(5)
> > > +#define GPIO_06     PINID(6)
> > > +#define GPIO_07     PINID(7)
> > > +#define GPIO_08     PINID(8)
> > > +#define GPIO_09     PINID(9)
> > > +#define GPIO_10     PINID(10)
> > > +#define GPIO_11     PINID(11)
> > > +#define GPIO_12     PINID(12)
> > > +#define GPIO_13     PINID(13)
> > > +#define GPIO_14     PINID(14)
> > > +#define GPIO_15     PINID(15)
> > > +#define GPIO_16     PINID(16)
> > > +#define GPIO_17     PINID(17)
> > > +#define GPIO_18     PINID(18)
> > > +#define GPIO_19     PINID(19)
> > > +#define GPIO_20     PINID(20)
> > > +#define GPIO_21     PINID(21)
> > > +#define GPIO_22     PINID(22)
> > > +#define GPIO_23     PINID(23)
> > > +#define GPIO_24     PINID(24)
> > > +#define GPIO_25     PINID(25)
> > > +#define GPIO_26     PINID(26)
> > > +#define GPIO_27     PINID(27)
> > > +#define GPIO_28     PINID(28)
> > > +#define GPIO_29     PINID(29)
> > > +#define GPIO_30     PINID(30)
> > > +#define GPIO_31     PINID(31)
> > > +
> > > +#define GPIO_32     PINID(32)
> > > +#define GPIO_33     PINID(33)
> > > +#define GPIO_34     PINID(34)
> > > +#define GPIO_35     PINID(35)
> > > +#define GPIO_36     PINID(36)
> > > +#define GPIO_37     PINID(37)
> > > +#define GPIO_38     PINID(38)
> > > +#define GPIO_39     PINID(39)
> > > +#define GPIO_40     PINID(40)
> > > +#define GPIO_41     PINID(41)
> > > +#define GPIO_42     PINID(42)
> > > +#define GPIO_43     PINID(43)
> > > +#define GPIO_44     PINID(44)
> > > +#define GPIO_45     PINID(45)
> > > +#define GPIO_46     PINID(46)
> > > +#define GPIO_47     PINID(47)
> > > +#define GPIO_48     PINID(48)
> > > +#define GPIO_49     PINID(49)
> > > +#define GPIO_50     PINID(50)
> > > +#define GPIO_51     PINID(51)
> > > +#define GPIO_52     PINID(52)
> > > +#define GPIO_53     PINID(53)
> > > +#define GPIO_54     PINID(54)
> > > +#define GPIO_55     PINID(55)
> > > +#define GPIO_56     PINID(56)
> > > +#define GPIO_57     PINID(57)
> > > +#define GPIO_58     PINID(58)
> > > +#define GPIO_59     PINID(59)
> > > +#define GPIO_60     PINID(60)
> > > +#define GPIO_61     PINID(61)
> > > +#define GPIO_62     PINID(62)
> > > +#define GPIO_63     PINID(63)
> > > +
> > > +#define GPIO_64     PINID(64)
> > > +#define GPIO_65     PINID(65)
> > > +#define GPIO_66     PINID(66)
> > > +#define GPIO_67     PINID(67)
> > > +#define GPIO_68     PINID(68)
> > > +#define GPIO_69     PINID(69)
> > > +#define GPIO_70     PINID(70)
> > > +#define GPIO_71     PINID(71)
> > > +#define GPIO_72     PINID(72)
> > > +#define GPIO_73     PINID(73)
> > > +#define GPIO_74     PINID(74)
> > > +#define GPIO_75     PINID(75)
> > > +#define GPIO_76     PINID(76)
> > > +#define GPIO_77     PINID(77)
> > > +#define GPIO_78     PINID(78)
> > > +#define GPIO_79     PINID(79)
> > > +#define GPIO_80     PINID(80)
> > > +#define GPIO_81     PINID(81)
> > > +#define GPIO_82     PINID(82)
> > > +#define GPIO_83     PINID(83)
> > > +#define GPIO_84     PINID(84)
> > > +#define GPIO_85     PINID(85)
> > > +
> > > +#define GPIO_101    PINID(89)
> > > +#define GPIO_100    PINID(90)
> > > +#define GPIO_99     PINID(91)
> > > +#define GPIO_98     PINID(92)
> > > +#define GPIO_103    PINID(93)
> > > +#define GPIO_102    PINID(94)
> > > +
> > > +#define GPIO_104    PINID(109)
> > > +#define GPIO_105    PINID(110)
> > > +#define GPIO_106    PINID(111)
> > > +#define GPIO_107    PINID(112)
> > > +#define GPIO_108    PINID(113)
> > > +#define GPIO_109    PINID(114)
> > > +#define GPIO_110    PINID(115)
> > > +
> > > +#define GPIO_93     PINID(116)
> > > +#define GPIO_94     PINID(117)
> > > +#define GPIO_95     PINID(118)
> > > +#define GPIO_96     PINID(119)
> > > +#define GPIO_97     PINID(120)
> > > +
> > > +#define GPIO_86     PINID(122)
> > > +#define GPIO_87     PINID(123)
> > > +#define GPIO_88     PINID(124)
> > > +#define GPIO_89     PINID(125)
> > > +#define GPIO_90     PINID(126)
> > > +#define GPIO_91     PINID(127)
> > > +#define GPIO_92     PINID(128)
> > > +
> > > +#define GPIO_111    PINID(130)
> > > +#define GPIO_112    PINID(131)
> > > +#define GPIO_113    PINID(132)
> > > +#define GPIO_114    PINID(133)
> > > +#define GPIO_115    PINID(134)
> > > +#define GPIO_116    PINID(135)
> > > +#define GPIO_117    PINID(136)
> > > +#define GPIO_118    PINID(137)
> > > +#define GPIO_119    PINID(138)
> > > +#define GPIO_120    PINID(139)
> > > +#define GPIO_121    PINID(140)
> > > +#define GPIO_122    PINID(141)
> > > +#define GPIO_123    PINID(142)
> > > +#define GPIO_124    PINID(143)
> > > +#define GPIO_125    PINID(144)
> > > +#define GPIO_126    PINID(145)
> > > +#define GPIO_127    PINID(146)
> > > +
> > > +/*
> > > + * +-------------------+-------------------+------+------+---------+-----+
> > > + * |   pull  |   drive  | schmitter |  slew  |  edge  |  strong  |   mux  |
> > > + * | up/down | strength |  trigger  |  rate  | detect |   pull   |  mode  |
> > > + * +---------+----------+-----------+--------+--------+----------+--------+
> > > + *   3 bits     3 bits     2 bits     1 bit    3 bits     1 bit    3 bits
> > > + *
> > > + */
> > > +
> > 
> > > +/* strong pull */
> > > +#define SPU_EN          (1 << 3)
> > > +
> > > +/* edge detect */
> > > +#define EDGE_NONE       (1 << 6)
> > > +#define EDGE_RISE       (1 << 4)
> > > +#define EDGE_FALL       (1 << 5)
> > > +#define EDGE_BOTH       (3 << 4)
> > > +
> > 
> > Just curious, how do you map the attributes "strong pull" and 
> > "edge detect"?
> to be honest, these two haven't addressed in this version
> 
> for "strong pull", I'm thinking about folding it into PULL_UP setting.
> 

I have seen similar attribute in starfive JH7100. Maybe this help.

> for "edge detect", I'm not very clear about this functionality,
> I think it's related to system wakeup, and I didn't see how to
> map them in the scope of pinctrl-single drivers, so any suggestion is welcome
> 
> > 
> > > +/* slew rate output control */
> > > +#define SLE_EN          (1 << 7)
> > > +
> > > +#define PINCTRL_SLEW_RATE(val)	< (val << 7) (1 << 7) >
> > 
> > It will be good to setting slew rate explictly.
> > 
> thanks, let me think about how to address this in next version
> (this should be similar to driver strength)
> 
> > > +
> > > +/* schmitter trigger input threshold */
> > > +#define ST00            (0 << 8)
> > > +#define ST01            (1 << 8)
> > > +#define ST02            (2 << 8)
> > > +#define ST03            (3 << 8)
> > > +
> > > +#define SCHMITT_ENABLE  (3 << 8)
> > > +#define SCHMITT_DISABLE (0 << 8)
> > > +
> > > +# define PINCTRL_INPUT_SCHMITT(val)  \
> > > +	< (val << 8) (SCHMITT_ENABLE) (SCHMITT_DISABLE) (SCHMITT_ENABLE) >
> > > +
> > > +/* driver strength*/
> > > +#define PAD_1V8_DS0     (0 << 11)
> > > +#define PAD_1V8_DS1     (1 << 11)
> > > +#define PAD_1V8_DS2     (2 << 11)
> > > +#define PAD_1V8_DS3     (3 << 11)
> > > +
> > > +#define PAD_3V_DS0      (0 << 10)
> > > +#define PAD_3V_DS1      (2 << 10)
> > > +#define PAD_3V_DS2      (4 << 10)
> > > +#define PAD_3V_DS3      (6 << 10)
> > > +#define PAD_3V_DS4      (1 << 10)
> > > +#define PAD_3V_DS5      (3 << 10)
> > > +#define PAD_3V_DS6      (5 << 10)
> > > +#define PAD_3V_DS7      (7 << 10)
> > 
> > For drive strength mapping, your can change DSx -> xmA or xuA.
> > Then uses your DS macro to mapping it. 
> > The same apply to schmitt trigger.
> > 
> > > +
> > > +#define PINCTRL_1V8_DS(value)	\
> > > +	< (PAD_1V8_DS##value) (0x7 << 10) >
> > > +#define PINCTRL_3V_DS(value)	\
> > > +	< (PAD_3V_DS##value)  (0x7 << 10) >
> > > +
> > > +/* pull up/down */
> > > +#define PULL_SEL        (1 << 15)
> > > +#define PULLUP_EN       (1 << 14)
> > > +#define PULLDN_EN       (1 << 13)
> > > +
> > > +#define PINCTRL_PULLUP(val)		\
> > > +	< (val << 14) (PULLUP_EN) (0 << 14) (PULLUP_EN) >
> > > +#define PINCTRL_PULLDN(val)		\
> > > +	< (val << 13) (PULLDN_EN) (0 << 13) (PULLDN_EN) >
> > > +
> > > +#define K1_PADCONF0(id, mux) \
> > > +	((GPIO_##id) * 4) (mux) (EDGE_NONE | PULL_SEL)
> > > +
> > > +#define K1_PADCONF1(id, mux) \
> > > +	((GPIO_##id) * 4) (mux) (EDGE_NONE)
> > > +
> > > +#endif /* __DT_BINDINGS_K1_PINCTRL_H */
> > > diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > > index 0777bf9e01183..2f0c56b06d413 100644
> > > --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> > > +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > > @@ -416,6 +416,20 @@ uart9: serial@d4017800 {
> > >  			status = "disabled";
> > >  		};
> > >  
> > > +		pinctrl: pinctrl@d401e000 {
> > > +			compatible = "pinconf-single";
> > > +			reg = <0x0 0xd401e000 0x0 0x400>;
> > > +			#pinctrl-cells = <2>;
> > > +			#gpio-range-cells = <3>;
> > > +
> > > +			pinctrl-single,register-width = <32>;
> > > +			pinctrl-single,function-mask = <0xff77>;
> > > +
> > > +			range: gpio-range {
> > > +				#pinctrl-single,gpio-range-cells = <3>;
> > > +			};
> > > +		};
> > > +
> > >  		plic: interrupt-controller@e0000000 {
> > >  			compatible = "spacemit,k1-plic", "sifive,plic-1.0.0";
> > >  			reg = <0x0 0xe0000000 0x0 0x4000000>;
> > > 
> > > -- 
> > > 2.45.2
> > > 
> 
> -- 
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55

