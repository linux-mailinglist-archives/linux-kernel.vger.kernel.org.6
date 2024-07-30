Return-Path: <linux-kernel+bounces-266948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F9F940A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F2B1F24282
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752DF19146E;
	Tue, 30 Jul 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="czAS+Oe1"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2063.outbound.protection.outlook.com [40.92.102.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27B190666;
	Tue, 30 Jul 2024 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325829; cv=fail; b=QmGqmhiYipGbxeZYZhnoTEYilhE83OKBbInzNQeJlEndTObQTWNLV7JjF5qZGU+HUAvB7WCKFVOGHqPiQoF9W/MKn+IgjPKVMtAnWar00Cp357R1OUEulz2Q1ETxe/bC3xLYaG6YatoObF2nMDafrw7YDNZktRbGBnwPT9qOIHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325829; c=relaxed/simple;
	bh=Xkqj6d/709KBVN6E3SbpcV8uzVL63TsiPHUA/vnyssQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ICmqa9ebfFCh/LiTx9R620Dzhbjb84lnR1BhlFjsEUWnetnJ9MFNhxWMjnVXG+pL1JV4DiQNY0HN4sUe/6lMJuYOtk87mergmN/twld+VbYYQymOciYtnu6/AlpOB7AxK9LcUQiGPJ0sYqVhNzPOP7PiEtrIpecQ5fVx2lAkCmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=czAS+Oe1; arc=fail smtp.client-ip=40.92.102.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhFhFRIHnlcYCepXWA6W9IghWMiGlebzeLDLcqoho7rNZjO/7cytQAXWma4e8eE1uGmAZI1DhYT2+a3y2OObdPpLiD7ammOfCobbqjHfNScNlWsy+F1jd5kgltr9v6zP7DDDuk4uuYBmrDfX5Tx9U2XPwBQBjnxNMPSoYpmRtfzYX18EBGUGsTg0yJ0YVKOBTaTH97tgQKS1fJea4YBs7B3KaxzaojPc4t1luGYaLzOEarJ18yIMhnKPOaDKN+8XSjDUtyFXw/mt4Fb6BBU/IE3SMDdRRzGR+kC+hj6s2h+NTkxHi1jQDip7OtuZFlGAv6HxXEQcll5Bb5NKqyOUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bePaIVHi8P+JvSiyOzAr92TLIx0LwjaGsoku4+uXu1g=;
 b=Rwmt2Qlv0y/fBedweRQ+WkuO0CfGLU1DcepBDtwRKlM/wqBRBZaQekVqvWEymfuHENBHIyaEUsmmw4q18wrlXXtTjmbdE2uMxvakbhsMjg4eqt59IPzaX43UcJfRYcCwyRL47a9tlQkTx1CRYXWEFI3fv7F837JtT7cQNfLCGR4dIXhxMnEFrjFkI4Ctug/ejXBiRLRLCeITcNFypS53+we8T43lgEaq095gWW0mryREGSJK/9l5Q5hXIJ6N8J2hwieF5hs1AXfNh9OFFHyN26AojghSefafeV16bX44XIe7PfQuCu1FIAsSezHclVkiou21w4JXGCLVXwmzRXrbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bePaIVHi8P+JvSiyOzAr92TLIx0LwjaGsoku4+uXu1g=;
 b=czAS+Oe1nJj+vr8Tiq4v0sH4PMkejm5po41mvxN1YTsjdlbFjKFeIFtH7HHcSpsvuHr6SdSEKrLvFNOEfKwOtnd5lLO005cne8ULRF06Tk8o+MZ07aNbqhXULdx6b54a7C23smLPq0PZJnDdUpZKKoWmkOX7glcqugx2E7oGUP0W/XE6+E4FgrWPifh8cJQ2U3zmCliKlI8DERxnXenphhD5BMZpnR/HjoheKdlpxdZW4QzCd6zS1LhbDxHJnsSmGD4udCrGiHOhlkpdrgyJzNtItTWLfaL2j5Z2yGI1W7jKL51UJtbOwqr6jVV19FqSmhgtyNyL4+wJ2OSDloQcaw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB2154.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1d4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 07:50:21 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 07:50:21 +0000
Message-ID:
 <MA0P287MB2822A78958F1F3788C15FB5EFEB02@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 30 Jul 2024 15:50:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] riscv: dts: sophgo: Use common "interrupt-parent"
 for all peripherals for sg2042
To: Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Chao Wei <chao.wei@sophgo.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <IA1PR20MB4953DB82FB7D75BF8409FFF4BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49531F6DFD2F116207C1397DBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB49531F6DFD2F116207C1397DBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [Cj1cpXWbXMlpID1GTvkxSdD1FFUMHMHu]
X-ClientProxiedBy: TYCP286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::17) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <47293ea7-212c-4396-9282-b59af021d2f9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB2154:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fe923e-ee7c-42a6-5e0f-08dcb06c4219
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	AUwTBqvd/z8TbFaqh/RYkxj3Ts/y/s3G/LRQMtGnwooG8nA6R2QbTgjmI8xkl0RM01buxx6USNmVR6Mf2y0Qtv4oWTfU0HNW13XSSFPuKgulnc5XQ92IQa01ve6axJ6t+UwIIcCiJtt8O01cdAFeO5kCfIYoRViI/vUDvdAmS9QIBKij1DUjFeI81Aa3yyKDakUlUpK5SvELS+xiLaOxpUiO3eSWTG68WUc8P32T+QSNJbO+MgVDhkGPFacovECg4YGVaWkVCzSpBP/SPHKkEvNmr33t/cW9JvEZzVHxMMvHYJQ4goQDk00AOAi+oK3Ohv9TXUc3ZX3s42nP1gIY432T8UkG7L8sll0a77LXWYF+K5nsKM/qAt+wIvyEmH3mGfV+WuEtKzvJuuCp2stVgieFyCOf2Oedw6wHmhoq9Hp5HyimDZc8VlC0jrmh7Ze5gEpHCdD9Vqn05AHElY98xU7A0OoCvdTRHVFVKeyC35NG/epsiQ262EARwK000hJmukPOvCWncJyeXmF0f/DiMF6inA+r+uNH83ZGejLjhIvmdMJdzTsA27DnlItS+/wQx324YRqRtqb8oJSadJH5l/e/gLgRWwrG6hRnnmUghQZoohOn6RzMn2DJm7Fjoolz7WBIjL5/E5e0LRVwRMcb/f3p/OWVY5xSR3AgImow8Nw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE1jdG5wSjI0M2l2blJ6SVVpT1ZoQmptNnROQzlldzVHUDBhY2dLcC9ockFt?=
 =?utf-8?B?VGNyb29CeE95ZnZYM2pFR0hpUkhiekhoa2ZFdXJhNklYaWxNcURITmlyVXBy?=
 =?utf-8?B?azhTcExmajNqNDZ2Vm9PeEZjVW9wYTV5S0NKM21zN0FiNmRYSGo0OVEwNzF0?=
 =?utf-8?B?QmRNQmxBZVo1T3lFUVF5UkF4MjNnN2NiNTd1WnY3SDRVSXpMdzZGcFY4cGQx?=
 =?utf-8?B?b0c5d1hjOUxCU1RpZFhXVktONFVRUGdmanZ4Vm93TS9oTnlXUjFFOC9UMSsv?=
 =?utf-8?B?YUU4cmhKazFCTUhBMDNJZGJCR2NPc3lVRVJKbXdVMkJOT21qU2d3emZkcFJl?=
 =?utf-8?B?R3phL2FUaENwOG02YXlsVnozc1RqcVV0V1Frd1ptdFIvSlQwZ3IwTFN3RzNU?=
 =?utf-8?B?SDIreHNrWU5mQ3F5Wjhwd3hSbTUvTkViWmwrMVF6MWRsc0swQ1FIUGRjNllE?=
 =?utf-8?B?NC9DNkJ0Mys5NWt5bWlwZk55TU4zK1JHdGRMK3pDR2FrL0dUUTZqSnRiRzRF?=
 =?utf-8?B?QXBuTWNPZzZvMzcwTTFaQjZIYVIzUTYvMlJJa3l0b0tvRnB2eGsxZEhCNUMy?=
 =?utf-8?B?M0kyQlp3bXhucEZiRU9jSTQxOHJzQlNFZnEzWjlqeldxeUkzRERud3h1VUIy?=
 =?utf-8?B?TVBEOVdrYXJvVktjeDNJL0IvVlhpbElETUZYT2VJZm9hVDJGenR0Wmo2VWR3?=
 =?utf-8?B?aklKdDhXYTlJdWsvMXI1Z3dVNk9xSXNvVE1OOWtWRUhiN3dFMGtWd2FBN3E4?=
 =?utf-8?B?RTFVaWtwaGhOQ243ZU05WkhzVFNLK0hsMkkvWnhZaXNOMTdTMnJHYWZGanBM?=
 =?utf-8?B?MDBaVjdNNDBWS0FZd1NSU0FwVzhzZ3dzSnJNVjVmRWJJRUIzVzE4Tk44dTlh?=
 =?utf-8?B?dENST09kazltbGdEZi9OS08vS2RVaTJJbm1aaWFTWGxqQUQyTnZDVjZxYjEz?=
 =?utf-8?B?cXlHdURNU1A0NFlZczE4NUo1TEV2VklpVmRwNnZQM3NrK1FCZUc2dUhQYTdm?=
 =?utf-8?B?TTRQdnFlK3R5Yk1FMjY5RW9WZGg5dWdpVkc3aEluYmhHODVSZ2lPOHlmRHlF?=
 =?utf-8?B?ZFc2UlM3Zm5GeFcwM2VFY3Q1OGo5Q2FrRTQrK0ZKNEJCdjFkYXhNUFVkSm81?=
 =?utf-8?B?MGRIQUZZMGxWMngwbUZlN3NURk43b2YwVDBWRFdzOUh0MXZERDFoTnNnMTFy?=
 =?utf-8?B?NTdWSWtiL0kwdlpIeU45NTN5VWFmbVU2Zm1aMDNxRW42TnVhc2RCQWlvL2Z3?=
 =?utf-8?B?b3Y1Y2VLOEtCTk1SendPcGFuZFFweVBWeXRERmNnSisvOE9JdTlSelcvQ3Rt?=
 =?utf-8?B?Lzd2MC94S3RlMHRtbjdxTlBxY2ozNXVYMHlsaVI3S3h0b21HcU9WUE5QQlpq?=
 =?utf-8?B?Vm4zQktWMkt3UnhVTnNpM1RzUkxnNUZNTldvZGxObXo1c1lKSmticWYySmto?=
 =?utf-8?B?OUtjOThnZi96Qk9sQ25vcVByRGpLNFJ3UFNBa1hZSWl0dkpIU0I3WEJuVkR2?=
 =?utf-8?B?TCtsc0JmMmdScEdFd0xLbW9haWZQd3BLMmlzQXFUN0dxYTVUQjBwL2xmd04z?=
 =?utf-8?B?cFN6WlQ5Q3dONWtJK0pwTnRUQUpzTjErMEdZWmZMbkNoVE9iUGI0MlFTaisy?=
 =?utf-8?B?dFIvNDhPNSs4TzlIeHM5K0RydDFXTUhrSlk5ekIwQ0hVSThyaFl5dWRDdXRU?=
 =?utf-8?Q?oACfn8uXZoEGurPMtLBu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fe923e-ee7c-42a6-5e0f-08dcb06c4219
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:50:21.0548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB2154


On 2024/7/29 10:13, Inochi Amaoto wrote:
> As all peripherals of sg2042 share the same "interrupt-parent",
> there is no need to use peripherals specific "interrupt-parent".
> Define "interrupt-parent" in the SoC level.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Tested-by: Chen Wang <unicorn_wang@outlook.com>

> ---
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> index 34c802bd3f9b..c61d8061119d 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -44,6 +44,7 @@ soc: soc {
>   		compatible = "simple-bus";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
> +		interrupt-parent = <&intc>;
>   		ranges;
>
>   		pllclk: clock-controller@70300100c0 {
> @@ -388,7 +389,6 @@ rstgen: reset-controller@7030013000 {
>   		uart0: serial@7040000000 {
>   			compatible = "snps,dw-apb-uart";
>   			reg = <0x00000070 0x40000000 0x00000000 0x00001000>;
> -			interrupt-parent = <&intc>;
>   			interrupts = <112 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-frequency = <500000000>;
>   			clocks = <&clkgen GATE_CLK_UART_500M>,
> --
> 2.45.2
>

