Return-Path: <linux-kernel+bounces-264967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1455E93EAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323481C20EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F6F41C6A;
	Mon, 29 Jul 2024 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NNF9XJbx"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2067.outbound.protection.outlook.com [40.92.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C3E2F46;
	Mon, 29 Jul 2024 01:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217569; cv=fail; b=CyYNJ4+pPQeZNKbY+yEnDvuSTjBNDFeLJRAVkh2PF+ReijMuvZvXldu9+/HjGzVeUNfoC57bmQCEIyDNIR31KBSLyirVMUZJ1PSmgZjHYE8KdDMh7yrNhlGKWzfTrmf7ciHHmei6sMmjbqqzT3e/9YZeyHDHDd6w3Z+2qu/iVUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217569; c=relaxed/simple;
	bh=jnVDODVmLYwKbHSuL2ndr1izU4p0PaqWz2Y6fkTS1SU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RcPj2JCOAUToPfIqnx6FaXFIBzcU6cVJmv0tPL9TbP0Y7mwEXM6p4/GjVucjFvg9Siv0Odsi50PKMaD8huqwEhknQNKxIIZH1gY1X31EUMZzMIG+mN2CJRKoh7w3KVX5A5UfQAq/IM4Spk5xgZL7LwiJCbVzHpZgilftG4fCqlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NNF9XJbx; arc=fail smtp.client-ip=40.92.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxFxi8/yWK02h6Jvre8LF0yej81qSlAm/l3DnL3J9RQe6kDSRHxzDDMktlvUfJmg/VbtIiQDSF+TYeCYbabwaPexKjRAH+zxguAobsrO8SB904jZKsn36cJYWj53z6jNXB0CBpmiHigtFQSvgUkWM3Cpd5f4WTFnJCCqsMJBwhE2uPvLxdocbNsRgF5n6nG3VVafelIYSsABdvGy1W7TZa49xxMNaCFCLrxdJeMEgGvsOBbZSM6MoWqn9IzX3fmXQj3demjoRFBdwzv3OUShV7zmvLEsbJnqI2baTS1DOY8D4M2ZFfH0PBe27/hW5pOxpJrL0Gac/nuFCCC1Xlyxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8idlXP5qmqkczFvHZ8Qva5iTCThTedcVZ4sD3l77pg=;
 b=DIctpquC7z4BpXwGVrwEd6tFRR5BEP1H6dd6qOSkXxUq5fPHqKdycHiyQJUJpZP8PdkRnMfx2A3K5vn1v5RNPFhlfRz9IPhO4WDGpLMrS/VyEBJmo8lhKC535QTlhJ4hAO8owkuZh90Sz54s/U2sbWaFoTCpLZKcbg2/mRnXhkzR9WeF54gLtJdiH1isUH9PD1iDNwXHi1Rbhzzw4wkcj9rU7OgC+dXzGaGF+bCzEp5UQOtzIRTtWMyY7ktmLT95pJpoNCUQzoYPjfJc0oyn/f9JCWxOuppysR0knUmijYGbMCh9jftqYpsun4rH51cl5CccPuyQKngjXy6o515mOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8idlXP5qmqkczFvHZ8Qva5iTCThTedcVZ4sD3l77pg=;
 b=NNF9XJbxgypfO3XvKv4OijBP8tcU5xods1i/dVtgjwxeKEP5nAKTN3c9GU0psUz7GuSiOXqmRfjLrAzB9yXoF7SlSXXVGRwp5jxFjPry0oQCRsH9KCBxETNuQZyZTMiyIqN1tM1gTGAlqwQsPn4BzQ0rqvkxTbhxQeST5eFCzh80ec5IE72m00OCW2heZbr1s+KrRivbKLk3+q7fus0AqiZqLcMvwlLauTnlQDHOHWIHSeUby3p4TwXux18EgTGbDTQI5q+GmVQ+wJVxleFDOR4nE6RfLUnwPGsngscRidn/gPAGS1qrHUi69RS9j3jIKG9E55AE/shXnpIU9zFUhw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1678.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 01:46:01 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 01:46:01 +0000
Message-ID:
 <MA0P287MB2822C3005C40EAF50BD6D9C8FEB72@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 29 Jul 2024 09:45:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: sophgo: Add i2c device support for sg2042
To: Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, Xiaoguang Xing <xiaoguang.xing@sophgo.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <IA1PR20MB49531864C828FE90C4C25D1BBBB42@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB49531864C828FE90C4C25D1BBBB42@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [8pw3KNlUUFow5lPZcS8v9o3hpIaSHjOd]
X-ClientProxiedBy: TYAPR01CA0229.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::25) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <e74241f9-93ea-476e-b3f6-146f21336d19@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1678:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae9f53b-3d60-4fb8-19c3-08dcaf703288
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599006|19110799003|8060799006|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	ErmvAALyL/bYnZWpmBtkCJtKkut23f7MFDwcV8Id8PwYZYgJnCNYLYpFnsUc/ZCEWLdVuvrdA/NxdwEk2DAzpfT5iPzSioLTb7rkn8yVVqx3D5oDaZFnNE9ECDdErV4W5TzknEooVdhHLOEnDnwsY3TpyhSHIRxYUu0o6XcqwW507Oi9OYts6yKoL5evT71mJ5PAsz0Jbts8w3XmJRNiV5nlEqoFt2tiJ2JRLPSfjr7dd/ajbik5FSxBLzunZ8d019YHqK9Zx4b5AjoUSe7uG0YlN9uvGv8651GRP+f55S/dvUk2Lbcg5SwEiVw0MUTUf02J9956Dd1CdT/FjOcADkRRc4KSmQ8gCTzDVovGCfoXcJYmIIDbP+z5Qt/kegj/W+Qm98JL4QPNcesFI2fYttik6M0LknJcmjzebXquDgfwGrFVPI3E4BfD3rFN2y4vir0N+AHTZhZ1cl/C/7k5yqUllPYQVJtB0jCyUuhhAyQ7xD1ePN4h9wku7fDubSEaz2AUsTg02E3yKSns8W61vixtqPZdVyi8IrNe6wPsN0cV9nNSw67/qL0iH+0qWAWUAkN9Bc9DlRyuC5y1omMUNqLfIlEzy3t39ZAYPV1wMNBzWNlyaQOp9fNfN4a/63aFgWLxjaU8OcRw76QCekPeAjS8ZZXCeSu+D3+lqT4iL6E=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emhmdzk1anJyQXNFTkdVeStickdBNXc5ZWtLaSs3bUNJVGYzdkh2UE5VeVo4?=
 =?utf-8?B?eTZMREVjQUczbFJkQXQvSk1Ja1haZVhDSUVwUjFtRytaU3dTT0pTeVVKL0k0?=
 =?utf-8?B?QlpaTDRnaFROTjJQcTk1T2JoN2dvZm5YbkRQMndTZFF1Qit4aEY0bGhSdGxG?=
 =?utf-8?B?NVJDOTdQbXE4ZTJPNld1SDVoWDhROGp1SVVzd3RYaXY0blR4UUdWTnBITytK?=
 =?utf-8?B?Z2pFYklhYXRsYkZ5MHIzaXBNalBwV0N3cGVBSGgyV21GczFHeFFxRlA0WkVW?=
 =?utf-8?B?ODRhaWJFUDFBVmcyUVVSR2IwU0FPdlVVRmlsZG5QcjhqazJYS0RBdXhOOGlR?=
 =?utf-8?B?MHd2TXQxTDA4T080MXB1T3VVSkJrZ1V3RWNXQ0pheUpiU1RyMUFtVGFiVWVq?=
 =?utf-8?B?TjlwNHBKcUJocko2NkJ3RU5kem1Sa3IvYVpvbVpxdU4rZGphRUxUVDQyYVZp?=
 =?utf-8?B?Qmk0Ukxncm1xeFBDUG1idlMwMTIxV0xVWDg2dUUzSWt5ckFQWEQwazlpUU0x?=
 =?utf-8?B?Z0VxNmdkbm9zbnNJcmhHSDEyL0toQ05vV2RxdENrYWgyMjdGTXlob0dZRnNz?=
 =?utf-8?B?alhMV2R3U3BEWkY0bmxqRFNFaUFJV0lxWEU0ZWJzYUYrbC9EVlhGNFZJcHpx?=
 =?utf-8?B?d0IySG1ZWTNxR1ZGMlpZakk1dDFPcUJNaXo3N203dHFJS3dvQmJBNXMyK3Vw?=
 =?utf-8?B?d1RFOE8vTk9RMGJkWDZqSGxSSGl2RkVKTlQ1ejBBa2cvbnJCMkkybnVBNzhp?=
 =?utf-8?B?Q2c2T3lIcU5BaDB5dUdDZWlLUG5JVzVjaW5qNFNMdENtN1l3dCt3V3h2UVor?=
 =?utf-8?B?YWc2RmxMeVVyQ1pjWVZuVUZKQ2lJQUt6SEEzeHc5SGxCMzZSb1B4SW8vQllh?=
 =?utf-8?B?cHVkQ2lKZ1R0SElocy9FYU4yWXd1VnMzWnVoUHpHdjRWQUJHbXdhb004bnIy?=
 =?utf-8?B?Z1doRUJVSDlhQktvZEdaZlY0U3pTcGtCM2F6Qm4zaDVuWnFBTFR0Q21VTGZS?=
 =?utf-8?B?aUMvSTBWcHNPdG1sQkpUSlllSEFhSG9zSlFRV21nTkE0RXpIVm01c3pRKzFE?=
 =?utf-8?B?cW5zS1l1RGlDUWkzeUZTV3JaMWQzdmNiejBMSHY4cER3UHpFK0lkWEFJa3Iv?=
 =?utf-8?B?Zi83NFVSRm1aeXZJUHB6VWNkWGI5d2UwdXRjR3BxdGpWZWxuckwyaGJJVTUy?=
 =?utf-8?B?b2lqWTRUaUVlUDZSeTNVNUFMdDRrUGJVVVhTd1BrRXZLZ2pWcGRaWnlSS08r?=
 =?utf-8?B?Q3JlMVRTZXB1UGZBQzNRZUF2cDlQaXhiQnhtcGpCYVU5UnlOU2N5eklHNHFR?=
 =?utf-8?B?ZXdKOTNmTVJIUGFPZHFPeDZ3Tkp2c0pmWFcrUWU5SDBNVnJxbEo4M3AxVFNO?=
 =?utf-8?B?YXFrdXBmS29ZUStNaFBIZDhqK2JyVlViUGdzdjUwY3FiTnZGTFJWODFFVnF5?=
 =?utf-8?B?SUg4UVR3TTVuNUQrZ095TmpEdkMvUEphOU5RWkFwZStiMWd3S2ZLZUVsQUVB?=
 =?utf-8?B?ZUJXSXIweEtwa1ozY3FxUXVERnkrTDBkQ0JqZjk5THFXMjVPdjFsWFJidkVN?=
 =?utf-8?B?RERTclNqLzk0SmhVc1BIbDJ0YkZXaWVQR0U3TFVuZnpQcDZlSzBmZWJSVXBS?=
 =?utf-8?B?ZHQzWXc5dmRYc1J1eWZrWm40L0xlWTBheVR3dXUvY20rTG9pekduMXJMZFox?=
 =?utf-8?Q?6EP+2Vv/wYGf7YMGJm/Q?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae9f53b-3d60-4fb8-19c3-08dcaf703288
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 01:46:01.3204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1678


On 2024/7/26 9:07, Inochi Amaoto wrote:
> The i2c ip of sg2042 is a standard Synopsys i2c ip, which is already
> supported by the mainline kernel.
>
> Add i2c device node for sg2042.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi | 54 +++++++++++++++++++++++++-
>   1 file changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> index 34c802bd3f9b..eebd6817520e 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -44,8 +44,61 @@ soc: soc {
>   		compatible = "simple-bus";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
> +		interrupt-parent = <&intc>;

I would suggest this change (use common interrupt-parent for soc) in 
another separated patch and this would looks more clear.

Then this patch is only for i2c related changes.

>   		ranges;
>
> +		i2c0: i2c@7030005000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x70 0x30005000 0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&clkgen GATE_CLK_APB_I2C>;
> +			clock-names = "ref";
> +			clock-frequency = <100000>;
> +			interrupts = <101 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&rstgen RST_I2C0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@7030006000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x70 0x30006000 0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&clkgen GATE_CLK_APB_I2C>;
> +			clock-names = "ref";
> +			clock-frequency = <100000>;
> +			interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&rstgen RST_I2C1>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@7030007000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x70 0x30007000 0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&clkgen GATE_CLK_APB_I2C>;
> +			clock-names = "ref";
> +			clock-frequency = <100000>;
> +			interrupts = <103 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&rstgen RST_I2C2>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c@7030008000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x70 0x30008000 0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&clkgen GATE_CLK_APB_I2C>;
> +			clock-names = "ref";
> +			clock-frequency = <100000>;
> +			interrupts = <104 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&rstgen RST_I2C3>;
> +			status = "disabled";
> +		};
> +
>   		pllclk: clock-controller@70300100c0 {
>   			compatible = "sophgo,sg2042-pll";
>   			reg = <0x70 0x300100c0 0x0 0x40>;
> @@ -388,7 +441,6 @@ rstgen: reset-controller@7030013000 {
>   		uart0: serial@7040000000 {
>   			compatible = "snps,dw-apb-uart";
>   			reg = <0x00000070 0x40000000 0x00000000 0x00001000>;
> -			interrupt-parent = <&intc>;
I would prefer this change in a separated patch which has been mentioned 
upon.
>   			interrupts = <112 IRQ_TYPE_LEVEL_HIGH>;
>   			clock-frequency = <500000000>;
>   			clocks = <&clkgen GATE_CLK_UART_500M>,
> --
> 2.45.2
>

