Return-Path: <linux-kernel+bounces-250046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5157092F370
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BA91F2235A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 01:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD695523A;
	Fri, 12 Jul 2024 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p67Ft2KF"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2047.outbound.protection.outlook.com [40.92.103.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA55B79D0;
	Fri, 12 Jul 2024 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720747642; cv=fail; b=XGu2to8wxEuYnQzrs8aH7+EKBBTRdPj/GgkFptoU+GNSk6px31oJA5paPhGFvtdi2uzhuoyAcLRcPOB+U7mhJycHbb+vSSZVctzQKR0gWRvGkJrfO0gXWrsuq05Q2qhOWT0ikQlnszYO+wUUJye5fMtGVHFGJSkQ29TvUcQSFLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720747642; c=relaxed/simple;
	bh=gYbCTlkaSrK3nLnW51oDymNOSpz29kO92uf80NKl90c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fmfUuFGehEx4jDauct0CD4qF//SFGBMXa46zI7KuE/ePo487NepRqJNilhUk3cgTuw8rVGP55XUu2ze7/dLQHJL7YtlOz2OPo0VwEkvfDjUh7UxsrgTvQxzB8pusi0DHNxbytSgfSI82psUN1c99undpyNMl4GFTSjAcTqUHRjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=p67Ft2KF; arc=fail smtp.client-ip=40.92.103.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDA2EeZXgwdBZutHMl+2Vk162bhJs8kYvNVPC61emnovS8DzGU+Tzbp3CLD6piUBLO3vdBGT1A3j/k1HLrZ6cCT/XpXwxcDCST+cHny5H18WuIx6zevnSZqVJzlc0o0+fb8xdwRDTX/4zmj52NAl3NyoFbmBuOP0QcqteRwFb81gLnVWqPOaO5ilSpedLMpj4y9+c2GDQ+jteEQ2TKNb6v1SeF4OxOhPzYpaDpETIWtmS5Tt/ohQEuoe/qm6+n4nOb4bJBxuGhQyd/HUAAwSQzRRRylqOUIhdVaV1lik0FgTOv1ISo4hV9VZZ1+cn80ygPY8zMPPYnphfISx7d7eMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeSHRa69gSaT/Iz9uheBurlGd/xAzO8phN9WvKbBeW8=;
 b=y235QmBvb00oJf4m/71sdOkdtm4SRUIa29Aw1QpdL9ZGB3p7kJ3gzmecMLiRPM9MKzPbtoEG8OuEEmj1zmo9EA2OBNamxyvdeobk+/IvEOpa8q0QIUTcSX84JPbBTycz21aOny3PddoXM7Uvq2AoPUJhmILUzj75GpN9nzXbbDFJBGTlYnAFXSWe+rPBNAsdY4NI2QzinU0BEU9G7JKU0TneP5Ya0e8OVvUyBnjmz46mB1e2/znkgMySI5zejWXNElHUdcSPluHcnV64B1ysHlO5eUvmFb1s5pj2UIDlYQ+hGPRNYssE9+E/04R2FEcimyuMxQsbOUiyX9JgZVIVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeSHRa69gSaT/Iz9uheBurlGd/xAzO8phN9WvKbBeW8=;
 b=p67Ft2KF0l0NG5jnck1hXt5Ic60A3ybdgjkyEOTCVt25788ufIu1JuWq7lzUyvAKyJ/ZeGMomDIC2sVF4z45M2/+3i33r9iPkhlJm6uHfG7f1sn3nVg9PICXKWgD+jbKqE/eo3/g8r4tYhdIK8MHTqmb7XJbgWokdWB2IhNt9+zwuZmq6WQ+Wxq2GEWvw5mBtpe5w5hZarhXL3kwWmyR2ebHz9vDDLgmL6AbwWbjybLGci1qdQ41KWvt2ZqrvCuAOEjjHh1WPunwZywoLRJW8Z4zjMVInAu4gHqUNxRSEa0dJC2DWVSJonOWceZAMBJaqZoSh2pevpHT5k6DcgK/Ug==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB1407.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 01:27:12 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 01:27:12 +0000
Message-ID:
 <MA0P287MB2822406AE122B7257B8C57F1FEA62@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 12 Jul 2024 09:27:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add board support for Sipeed LicheeRV Nano
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Inochi Amaoto <inochiama@outlook.com>,
 Chao Wei <chao.wei@sophgo.com>, Conor Dooley <conor@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
References: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [cuj/tQW+JT1Q8m2hZW1RrqtRtejeOrzW]
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <9758f109-5b13-4a35-ad58-6db0b61b2df3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB1407:EE_
X-MS-Office365-Filtering-Correlation-Id: 083be0e6-adcc-4f18-9424-08dca211c119
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|4302099013|440099028|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	mtdGjbvLLFX8W9VUvu5G9Y3d1ndZbWQ+TSJ2hsUZTfADGFoCMZS4225DPLrCOXgyzVoYtbHQijHYZFz02FZAuVi6xlb+/6g/exvNUE2DiP9GEAt4URmDDcpdcs8WVVYr1IpiM9g1bJIzI6bXDd1uhuqZhd+YFuaDSgr9IXrLUpRxyS6whLCaxeTDIfvuGeesAmteyIjU9mnOrJOuXKkIGrBh5a6bxtr9IYnVLzZ3vHHX3h+ogStmnFNga1F8z7tof9uHOty+Sx+rEeOXuCIX2mnXCqnPf/p624tj3lWyQXJ0vsfgIweP4qKECz8QBSkhAy1ioTe73Ztta2wZ1dW5V2AOWLj+kexQCL3wG6V2yrONBYAtjL99j68jwFWRH60SMRvI7iymqTaKkUhtfYJH4+MtaLrQ1/KQ/Z9D5o7QAAnK23D2W/SLzSjqdtiv9vWOYOaUg0I/GVIN8SR0CetGJr+8qWMEdDpR1N/pA5ruqH+ReuyQYC6jYrkkZlokRVX4/5vbToyo21aNlZRBuKPvAtRRYBPUOA3qfm7Z5pLCVKODdyLySlXM5labFh+dSh4t+bQX5cdL981/eyJ0Qq14i7jUxwmgeBfhHsSP2CPB7YQVZGhgJ8uTs6QCEL4DS6d0JuAu8KJgMGm3EVCv8VaSQyYK7p3SBTd2J4812eHXUtbFx/1cwmSnGUN5grEyUKP3Jlbh0WDtzAz2uYRpZ2D5pfV8qx5GS8eXCor4C7yEI9mqgX8tG7dmMxe7m4KRs4NiJTT2/Et0u+aQF/CU1Ka+/g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnJkUjhSWlZ5QzBsc3B2ckhyZkNLK2oydldQUVlWVmNHTzlQNlRPTTZubURP?=
 =?utf-8?B?UGFZbElFRmtzc1VhZjk3NkxnUkRBblVSUk1ZK1g3dnZrL2xFTmdjdGNqN3dy?=
 =?utf-8?B?U0hSZnFjRjNJSFlOK1A3Z201V1NmVXd3QnlGdDR5YTB2MVIzeVpNRTd1RndV?=
 =?utf-8?B?VUs2aVlMYlQwelRTNC8xaEFaOWZzelpnMnZnVEREQmNaUnc3N2pKVStpOVZG?=
 =?utf-8?B?TmFHdVNLS2YyVjR1dzFvQmJoRkp1TWErNW1wYmRMNFQ4bDVmZENDQ1JTT3ZX?=
 =?utf-8?B?Ulczd1IyUHBLM3pmQ1FQb1JlUHRSSVZTRWFQaVFjaSsycndWM1Z3Ymx1TEFs?=
 =?utf-8?B?WnlQSmY2aEhXZGM5VUt3dmNkVng1V2NOVC8wYnkyMG9OK25JdjVHeVl3V3NK?=
 =?utf-8?B?c3RpanUxK3puLytYbGpzVkVHMjdrSWlRbjM0WFhJVU1sQjA3TVQ4SjZNV1RW?=
 =?utf-8?B?L3VGR3M2WTBpdmVNVm5jMjZoNFRwL003U1FhaStrVFE2TFBIMEQ0c214KzMy?=
 =?utf-8?B?ZURIZVpGcWdmeXVReVp0TFZYYk5SVi9aM2pTTzVweXpyRmFrYWZpMEY3OWl2?=
 =?utf-8?B?WnFBSjJjcWJvZnZ2WVUyWkpLYys0V2FmZTdnSlgwa2VoSnk0aGxvTTR6eWVq?=
 =?utf-8?B?a1N2NnNzU1lITHBtTUx4aHpmQXUxVzZRSzI4YmU1UjJ2eEg4RzdoRTgwQ0JS?=
 =?utf-8?B?QjBmNmdOK1Q4WXFBSStXZmZ2VElXRlB0WDhWKy9vbXR3K1VtUjdqUTlLN20r?=
 =?utf-8?B?R2hsSmhuaEFPaDNSQ2NMQlhZREpVUHJpaCtwYVUyTHpoNVFyemwyNXlOaVNL?=
 =?utf-8?B?b1ROMkVqWGt6eEphQk5icUoxcTZKSk9rS1YzdjhLMnFYYXNxU3F1WGJUSWRo?=
 =?utf-8?B?QmJyTG1pTElWQjBrOVVRNlN3N0NWYmJRUUgwNkJLNk91VTVPZDVUb21wNXJQ?=
 =?utf-8?B?dXpwTDhQTVl2R25CODNQZEZFR1VkQmlKOTE0L2FFb3hsd1Q2K09sYlFpdFZM?=
 =?utf-8?B?NjIydGJhLzhPR0JNRm5PdjVsT3RNY0dBZTZnNm9sbVdsY1VnQzRJUmZEWFZC?=
 =?utf-8?B?Q2FhZU5rMkVpczROdDRmdksyU0VXanJxSlQvVnZTU1QyeVUrYXFMWUk0bmda?=
 =?utf-8?B?OEI2RHRna0NvcHdnbWtydkdRVExleG13YjEySUVwOEZMMGs0RzliWURqZDdS?=
 =?utf-8?B?OEVxK3poaFFrQzZCRmcybzFFeXNDdCtkWmtXQW9USzhQU2pCZGU2L1FIL09U?=
 =?utf-8?B?SmlFdUVCMjl6RkI2TmhsYWx5a0FXUUVtY21zdW05bzJvcGJDTmdnc2JaamRw?=
 =?utf-8?B?RnFBd3ZNYVI3SmF3ekMyZjA2UFlVUmxvbVgrUnM2Y1d6U1JJOHJqWU8zby9E?=
 =?utf-8?B?clNMdS9GTG9hVzJEU3p1b0twMWYzZHZkd0w2WFNBYlNRSHA1eHBUSkh6SFdC?=
 =?utf-8?B?QTRhdXN1Y1pVVU8wVXNla3drcko2L2IybnBjb3NseVNBelppMXMyWDAvRjdF?=
 =?utf-8?B?YWZQZ1hmZkZmSDJSV1Zrek1zWlh5SFRmY1Qrb2JPWEwyMU5tU1l6OTg1R3pB?=
 =?utf-8?B?TE9seWIyOVdkd2pyVlJ3YVNwRWtzMFJwNXozUTBhRXBmcEUyaEwxMGNGUWM4?=
 =?utf-8?B?TFFKdUVOTmczMU5RTHR6ZDBPSWNQSUxraWZxM252bVd4cFQ0QXNKV2lIdmFj?=
 =?utf-8?Q?C0IBClaKvxVkaO0Szhr3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083be0e6-adcc-4f18-9424-08dca211c119
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 01:27:12.2888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1407


On 2024/7/11 18:01, Thomas Bonnefille wrote:
> The LicheeRV Nano is a RISC-V SBC based on the Sophgo SG2002 chip. Adds
> minimal device tree files for this board to make it boot to a basic
> shell.
>
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
> Changes in v4:
> - Add correct bindings configuration for SG2002 sdhci
> - Drop commit "dt-bindings: timer: Add SOPHGO SG2002 clint" because it
>    has already been merged in Daniel Lezcano git tree.
> - Link to v3: https://lore.kernel.org/r/20240709-sg2002-v3-0-af779c3d139d@bootlin.com
>
> Changes in v3:
> - Remove /dts-v1/ directive from sg2002.dtsi file
> - Add disable-wp property to sdhci node to avoid having a write
>    protected SD card
> - Drop changes in cv18xx.dtsi and cv1800b.dtsi
> - Add fallback compatible to cv1800b in SDHCI node of sg2002.dtsi
> - Link to v2: https://lore.kernel.org/r/20240612-sg2002-v2-0-19a585af6846@bootlin.com
>
> Changes in v2:
> - Add SDHCI support
> - Change device tree name to match the Makefile
> - Add oscillator frequency
> - Add aliases to other UARTs
> - Add aliases to GPIOs
> - Move compatible for SDHCI from common DT to specific DT
> - Link to v1: https://lore.kernel.org/r/20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com
>
> ---
> Thomas Bonnefille (4):
>        dt-bindings: interrupt-controller: Add SOPHGO SG2002 plic
>        dt-bindings: riscv: Add Sipeed LicheeRV Nano board compatibles
>        riscv: dts: sophgo: Add initial SG2002 SoC device tree
>        riscv: dts: sophgo: Add LicheeRV Nano board device tree
>
>   .../interrupt-controller/sifive,plic-1.0.0.yaml    |  1 +
>   .../devicetree/bindings/riscv/sophgo.yaml          |  5 ++
>   arch/riscv/boot/dts/sophgo/Makefile                |  1 +
>   .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts     | 54 ++++++++++++++++++++++
>   arch/riscv/boot/dts/sophgo/sg2002.dtsi             | 32 +++++++++++++
>   5 files changed, 93 insertions(+)
> ---
> base-commit: d20f6b3d747c36889b7ce75ee369182af3decb6b
> change-id: 20240515-sg2002-93dce1d263be
>
> Best regards,
Hi, Thomas,

This stuff is already too late for 6.11 as I already sent my PRs. I will 
handle this next period.

Cheers,

Chen



