Return-Path: <linux-kernel+bounces-228743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2409E91664E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E691F24498
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBABE14BF8B;
	Tue, 25 Jun 2024 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rJO0+Chy"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2100.outbound.protection.outlook.com [40.92.98.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252EB14B07C;
	Tue, 25 Jun 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315318; cv=fail; b=nykVP1Dvd4r44xsbI+npgjCfEf/CM15Zse9q1jKwjCh1Dh0nyv5YdjU4sn4NKSPqJw7QX/gI349VE6pcQ79TF0lvWsua/m93EsEsrYnk+O5mzjWjMZtMTsmj/WhIBmzH8+KxWuv8qp0fBRmpB3+xVYyS6IN1QeNGZ5ZBEhF0X/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315318; c=relaxed/simple;
	bh=G4/0zQ4aNuCGMtZnGOMeDzudND1GbdZR575/Gf6w4po=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dgXQclSPEUNqwD6Nz85elKVS/B3/LZ3rCSWpbFKhNWYXgBnYxkRfVJelj5jdJqQNm2tj96vrgA1H5fGFlWzm6eld+01qzwQsxKb+pE/cT12biL7knggvxJERCdBDkizh0lEj2ivOUA2GGwU6ktKMBcRz9Ezr8lzcnsCLWUL2308=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rJO0+Chy; arc=fail smtp.client-ip=40.92.98.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOgqBPPsR9F6rRmiwreqK37xol8ayrAVZHkH8gDjdPHohoRfPo1DiXjoSqUCmcLT8E7Qp8+i+Ou1zefgyZZKR/OwQGK9fnzJNtRS041T7jagY2uj1lIvqJSvJKmM6mW6vbXRPkXmRCczdJu4nP/mryiTmvcCKvniLDcc8UADKAcYjuA9dyCmfRmcnpL5Ry9iBuj5bCJMFCUNu0DxOl5SdWIi9+6Bde2hLIacH8ziQne8EqX4zGjA67KXQheKTlVYDwz2rNTEx6i72DD3+bI4viu3q57+jbSlYuOUD3Gru83XOYP+NPANC/paReOJgOZZbpHLzvs6SN77XP7k190Jjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OY6R0d2nH/po2WAD8Y0PLpV+PtmVjvD3sFZQ5R+AAY=;
 b=h+doNq+vxZCNPtV7x/rFKJYhoKjqHCe8g+SR7+HnFihfHzcFw0eDDSOHPBV6ROfbgHAYepaOzAhRv2LS6sJ4NyO8kmr93TAXrVWizk/wXbGvdJ7wrk8oEcBjrfpj3GC11ClvTUapq6FvFabxi/hfXP05Y7NQfcELeOfPEaLT4xfhguB/Z/SeQWit6Vsl40+Cg7EMzAUtu+Ssk+xlZ/ap4KnuoTUzM3a/6zXQ9k7uuQvrgNId6Wh82K5BON1fP3KcjS1LUcxQS25+no2LATQfXIG2m8PY7nf0GJ5PKQHqfoBV1HIF6ZCmaSXKs69arR8erPz2t47lLEmU75DcLcnhFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OY6R0d2nH/po2WAD8Y0PLpV+PtmVjvD3sFZQ5R+AAY=;
 b=rJO0+ChyPIJBoPerpe1vQJAA4nD5mxdzYvobBcJlQc8R8tKXlgz+bgvZFllsMxGP1KLmoOYwhYLplx9haFsDBDF6qjCQ32uLfCILBFTlURwRmR4mzXy4tfGae/0XuDDwK1EXbpSCUE8yL4Ycty3x1nM+cl2cdq4cEjRpWR/8jDbZtwSu+iuU9wctVwqldTFDmTKL9MbCdt41dkSFnlTxZF/eIKaIVR1BvAT+51LDDAbBpTbtDwK6USlySG3K77nITV+IInqJ6m41O4YpZVqvCt3YicdRER7Yzyr9jQwwin+NYCy3co62Y1cN86w82CJNgVEZIGzYByC4RrGPL0qIFA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TY3P286MB3539.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 11:35:10 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 11:35:10 +0000
Message-ID:
 <TY3P286MB26112163A012F5D09741A01498D52@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Tue, 25 Jun 2024 19:30:29 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, wenst@chromium.org, hsinyi@chromium.org,
 nfraprado@collabora.com, macpaul.lin@mediatek.com, sean.wang@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 stephen@radxa.com, tom@radxa.com
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: Introduce the MT8395 Radxa
 NIO 12L board
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org
References: <20240202114821.79227-1-angelogioacchino.delregno@collabora.com>
 <20240202114821.79227-3-angelogioacchino.delregno@collabora.com>
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <20240202114821.79227-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN: [CQcUJEo76xTI+0FghYC55V+8XpWJTp944mxui7IFeReODrqYrHxvdRwo2zNFoEDe]
X-ClientProxiedBy: SG2PR01CA0119.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::23) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID:
 <0598e574-dff9-4dc9-89d8-e085f79e6b63@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY3P286MB3539:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d20641c-7322-4e9b-50e2-08dc950adeff
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|440099025|3412199022|1710799023;
X-Microsoft-Antispam-Message-Info:
	9EiY7T6WBNdEiXyWA5aM7Ha4kdJA2jJnB/j40YxQRA2cNOn1ZraGo4Dugf2AwBaWKLzupREUfKvLujwJjs0dJFT6TXKNpV7XkZzGH1rW1vXJH/IAKrsc0bVWz+6czqZUras2yRx4ZiMLMSwHpLYPY6bJ9/IhpeFtbBPEiWJ9siwxpBozi/oi6qd5GYK1fG7MTPhjMyoNLmwHyoJ+y2y/Izh7GCyauDYw2HiuzcLGZITc3uwOoetDrxX5fNs75rxUyo81bP7R3OJd8R2g6X9PrM9h+NK4I4TDYWtpzhPwYHO/COTrQbdz+zTGkR4pEURnJn9IRbDqs4+5X2ARiybSO1UpTGHBSoKtugFqCwNV7DJAl0pEaoVCsyrJFlQIBooD9tAA1JEEH6XzJbV0is0vUOMrRgkRZtZkd8GrzF40rFrtK7uvWN6OfjsyXBCx4d7cSKqvwkSvOkEneOvdpD8S5dIMk5HDDRI51mXNU3DKAn74L7yFZRUIoW+itdyKHtXp6mY0NdZKf4dmPPNKe2LppTXzbGTkKmx+AR1wEqLkXW92STwGKRsLgKZd3jisKnojTa/9Sm3/VUpiPbeUM2CIUE8L0baCIrLrRQg+iusU3ngWMlmr9/WCePguIUW7fF0q
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3hKYzlNRVdCN3Blbm9rMkltc1A1M3RudHBTdHlmWmRnQ090bGx0Yk9ncVd4?=
 =?utf-8?B?QktqSUM5dGRuUXkwT2dEMVN5YXZYYW9CbzNiN3EzTDB6azgwcUFKbFZXdkJV?=
 =?utf-8?B?bGwraS9VVEY3N2RrVVJkenpCVWxkM3VqYVBXdnJXakVBTWlaQVoyRFlCVnA2?=
 =?utf-8?B?ZTBwdUtCTmpXdEx1L2gvVnh2NEJXVDUxQ3dBczRKSGU3R3RHY0xHVmZaV2FP?=
 =?utf-8?B?MlBVZ3ZveTBWc2x4OWQ3b1ZPN2t0TzJhTVNoNC83aWF4amVVUVV4emRUTktI?=
 =?utf-8?B?ejZzN0ovbCtSb3lmOGc2RFpSaThCSWQyeFVqSGw5YlR0K3Z0WVVPc0ZzajRM?=
 =?utf-8?B?bG16OE1tNllaUGVJSEpObTgvVGxXbGZiMXViQm5kZDBobWhWU1A4QmxQUm81?=
 =?utf-8?B?QUl1UFN6M09QeHMzQ0FpRThWNG82ZUU5S09YL2tkYXU5UysreHpxa0JudWdG?=
 =?utf-8?B?aUo2UThod3k5VmFvSmtZRkxvK3A1MFhTTXlvTWFFd21sTUhMMlA5YUFGUnp3?=
 =?utf-8?B?d2xvWXhqNFJCRWJORVF1SnBMSWwzbjVPbjhuMGc1TlBzS28vcE8rQ25YWEhh?=
 =?utf-8?B?cDUra2R0dzVzODc3OWxyTnpkQmR3S2FtWXJPcXlzbkU3OEJ1Rm1XVlRXT1Zz?=
 =?utf-8?B?ZkFtZWNheHQ4M2dBN20zMGhqb041ckF5eXlJSDdQRDRic3NXbDU5cEZ3VGpP?=
 =?utf-8?B?eldSbDJGeGpIOUszSWJacFdqVXJsMXR0SERqWSsyTXZzT1NjTDN0SGIyUkZj?=
 =?utf-8?B?aFo1OHR2UWtXSWpqejZsS1p2VFpjbmxsbDRNUDhPWG5QSTgrQmdSOHRTWFVJ?=
 =?utf-8?B?WjhzaWpsS0Z1TDhIUnhScjlWZUZaTWVIMHI3S3BPYkZXTmhKTG5iZmNnSS9E?=
 =?utf-8?B?TmF6SlNtU0RjNFVyaGpmSVM1MTlVem5reWcreko0Q2p3TXkrajEzd283bkFP?=
 =?utf-8?B?LzE1T3NkaEp5TmsvMTlGNk9vR1BTVGJRS1lKK3cxVjlLSkxKb3c2TWlmNWJn?=
 =?utf-8?B?ZzlVbEVQWUUzZTc2NFFTTTlOWko0ai9YbXpzbFdCdjIwdVBHdmxqZU1mUVIx?=
 =?utf-8?B?SkVGOUhMNkk0cmxEbWEwUDdzRFJobjBnZkw2Y1gyVkd6TGFIQzlzblBpdGt4?=
 =?utf-8?B?RG5ZQ2I5RW5QVUdiNnAzNmZpYmxYYkJtSWtNVkYzME1FUkRVMXpKNTZZczBB?=
 =?utf-8?B?ajZrSXRIU2RRTWhvVy9mUmJNaDZ6aDF4VnZYMjBJSUlnMndvSkdBNUVCeFhG?=
 =?utf-8?B?NmpuUi9xMHloL0lERmE5a0dwQlBpZHlRS2JmZzR6cXFDUkdHbFdlNGtIZXJi?=
 =?utf-8?B?ZEQ1Yk50WUdDU3JnVGtub3dVNHVQN0VBS2srSUVXVktxbTA0NWwzVWZPTHh0?=
 =?utf-8?B?UHUvV3p1SmFjdVY3R3hGaDVIRDdJbXJURVF4aTlkWWd2T3FxcENJN3pObDhG?=
 =?utf-8?B?UThlTVAvejMwbmNxWEhQQWNEQm44d2Vldi9lZ0hYS3p2RWJ0aFZYejZSVHRG?=
 =?utf-8?B?ZjN3cmVaYzFrNE1iUitURTUrcURiaStkWG8yWWF3Z3FSOUg4YlJHRDU3ZDFP?=
 =?utf-8?B?VktvdmMrZURTUFVvcWhBNFU1Y1Q4WHZwUndOVzZiRU9CcFpYdkJDVEQ1ckxh?=
 =?utf-8?B?RG5oTjhnVEtlUVhuR21lWGJiM0k4TFZuN3V6OVZSQ1JNNDNySHhnalYxRmpu?=
 =?utf-8?B?bmV5MEw3K21YZnZaQWR1TlNNZG1sNnBsSWtaMXdsMkxhQ0JNTTVSa2FtTDNj?=
 =?utf-8?Q?jUHlejAOTmoY03mYZA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d20641c-7322-4e9b-50e2-08dc950adeff
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 11:35:10.6485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3539

Hello,

What bootloader and tf-a are you using for testing these patches,
mainline or vendor? I'd like to try them too.

Best regards,
Shengyu

在 2024/2/2 19:48, AngeloGioacchino Del Regno 写道:
> Add a device tree for the Radxa NIO 12L SBC, powered by the MediaTek
> MT8395 Genio 1200 SoC.
> 
> This board features:
>  * MT6359 + MT6360 PMICs at I2C-6
>    - Regulators, battery charger, TypeC Port Controller Interface
>    - Audio through 3.5mm jack (2CH out, 1CH in)
>  * Two MT6315 PMICs over SPMI
>    - CPU-Big and GPU Core regulators
>  * Network Connectivity
>    - Realtek RTL8211FD MDIO PHY/Transceiver, 10/100/1000M Ethernet
>    - MT7921E WiFi (PCIe1) / Bluetooth (USB 2.0) combo chip
>  * Storage
>    - On-board UFS storage
>    - On-board eMMC on MMC0 controller
>    - MicroSD card slot on MMC1 controller
>  * Other connectivity
>    - 1x USB Type-C Charging/Power only port
>    - 1x USB 3.2 SuperSpeed Type-C OTG+DisplayPort mode
>      - Muxed by ITE IT5205 Alternate Mode Passive MUX
>    - 4x USB 3.0 Type-A ports on VL805 USB Hub (PCIe0)
>    - 1x HDMI IN port
>    - 1x HDMI OUT port
>    - 1x MIPI DSI (Display) port
>    - 2x MIPI CSI (Camera) ports
>  * 40-pin Expansion Header
>    - Two UART ports
>    - I2C, SPI busses
>    - I2S for external audio chips
>    - ADC
>    - GPIOs
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>  .../dts/mediatek/mt8395-radxa-nio-12l.dts     | 825 ++++++++++++++++++
>  2 files changed, 826 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 1e6f91731e92..fdd8f4a58003 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -63,4 +63,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> new file mode 100644
> index 000000000000..e5d9b671a405
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> @@ -0,0 +1,825 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 Radxa Limited
> + * Copyright (C) 2024 Collabora Ltd.
> + *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#include "mt8195.dtsi"
> +#include "mt6359.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> +#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
> +#include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/usb/pd.h>
> +
> +/ {
> +	model = "Radxa NIO 12L";
> +	chassis-type = "embedded";
> +	compatible = "radxa,nio-12l", "mediatek,mt8395", "mediatek,mt8195";
> +
> +	aliases {
> +		i2c0 = &i2c2;
> +		i2c1 = &i2c3;
> +		i2c2 = &i2c4;
> +		i2c3 = &i2c0;
> +		i2c4 = &i2c1;
> +		ethernet0 = &eth;
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		spi0 = &spi1;
> +		spi1 = &spi2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:921600n8";
> +	};
> +
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0x1 0x0>;
> +	};
> +
> +	wifi_vreg: regulator-wifi-3v3-en {
> +		compatible = "regulator-fixed";
> +		regulator-name = "wifi_3v3_en";
> +		regulator-always-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpio = <&pio 67 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_vreg_pins>;
> +		vin-supply = <&vsys>;
> +	};
> +
> +	/* system wide switching 5.0V power rail */
> +	vsys: regulator-vsys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_vsys>;
> +	};
> +
> +	vsys_buck: regulator-vsys-buck {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_buck";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_vsys>;
> +	};
> +
> +	/* Rail from power-only "TYPE C DC" port */
> +	vcc5v0_vsys: regulator-vcc5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/*
> +		 * 12 MiB reserved for OP-TEE (BL32)
> +		 * +-----------------------+ 0x43e0_0000
> +		 * |      SHMEM 2MiB       |
> +		 * +-----------------------+ 0x43c0_0000
> +		 * |        | TA_RAM  8MiB |
> +		 * + TZDRAM +--------------+ 0x4340_0000
> +		 * |        | TEE_RAM 2MiB |
> +		 * +-----------------------+ 0x4320_0000
> +		 */
> +		optee_reserved: optee@43200000 {
> +			reg = <0 0x43200000 0 0xc00000>;
> +			no-map;
> +		};
> +
> +		scp_mem: memory@50000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x50000000 0 0x2900000>;
> +			no-map;
> +		};
> +
> +		vpu_mem: memory@53000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x53000000 0 0x1400000>; /* 20 MB */
> +		};
> +
> +		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
> +		bl31_secmon_mem: memory@54600000 {
> +			reg = <0 0x54600000 0x0 0x200000>;
> +			no-map;
> +		};
> +
> +		afe_mem: memory@60000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x60000000 0 0x1100000>;
> +			no-map;
> +		};
> +
> +		apu_mem: memory@62000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x62000000 0 0x1400000>; /* 20 MB */
> +		};
> +	};
> +};
> +
> +&eth {
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&rgmii_phy>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&eth_default_pins>;
> +	pinctrl-1 = <&eth_sleep_pins>;
> +	mediatek,tx-delay-ps = <2030>;
> +	mediatek,mac-wol;
> +	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
> +	snps,reset-delays-us = <0 20000 100000>;
> +	status = "okay";
> +
> +	mdio {
> +		rgmii_phy: ethernet-phy@1 {
> +			compatible = "ethernet-phy-id001c.c916";
> +			reg = <0x1>;
> +		};
> +	};
> +};
> +
> +&gpu {
> +	mali-supply = <&mt6315_7_vbuck1>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&i2c2_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	typec-mux@48 {
> +		compatible = "ite,it5205";
> +		reg = <0x48>;
> +
> +		mode-switch;
> +		orientation-switch;
> +
> +		vcc-supply = <&mt6359_vibr_ldo_reg>;
> +
> +		port {
> +			it5205_sbu_mux: endpoint {
> +				remote-endpoint = <&typec_con_mux>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&i2c4_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	/* I2C4 exposed at 39-pins MIPI-LCD connector */
> +};
> +
> +&i2c6 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&i2c6_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	mt6360: pmic@34 {
> +		compatible = "mediatek,mt6360";
> +		reg = <0x34>;
> +		interrupts-extended = <&pio 101 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-names = "IRQB";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		pinctrl-0 = <&mt6360_pins>;
> +
> +		charger {
> +			compatible = "mediatek,mt6360-chg";
> +			richtek,vinovp-microvolt = <14500000>;
> +
> +			otg_vbus_regulator: usb-otg-vbus-regulator {
> +				regulator-name = "usb-otg-vbus";
> +				regulator-min-microvolt = <4425000>;
> +				regulator-max-microvolt = <5825000>;
> +			};
> +		};
> +
> +		regulator {
> +			compatible = "mediatek,mt6360-regulator";
> +			LDO_VIN1-supply = <&vsys_buck>;
> +			LDO_VIN3-supply = <&mt6360_buck2>;
> +
> +			mt6360_buck1: buck1 {
> +				regulator-name = "emi_vdd2";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP
> +							   MT6360_OPMODE_ULP>;
> +				regulator-always-on;
> +			};
> +
> +			mt6360_buck2: buck2 {
> +				regulator-name = "emi_vddq";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP
> +							   MT6360_OPMODE_ULP>;
> +				regulator-always-on;
> +			};
> +
> +			mt6360_ldo1: ldo1 {
> +				regulator-name = "ext_lcd_3v3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +				regulator-always-on;
> +			};
> +
> +			mt6360_ldo2: ldo2 {
> +				regulator-name = "panel1_p1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +
> +			mt6360_ldo3: ldo3 {
> +				regulator-name = "vmc_pmu";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +
> +			mt6360_ldo5: ldo5 {
> +				regulator-name = "vmch_pmu";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +				regulator-always-on;
> +			};
> +
> +			mt6360_ldo6: ldo6 {
> +				regulator-name = "mt6360_ldo6"; /* Test point */
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <2100000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +
> +			mt6360_ldo7: ldo7 {
> +				regulator-name = "emi_vmddr_en";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <2100000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +				regulator-always-on;
> +			};
> +		};
> +
> +		typec {
> +			compatible = "mediatek,mt6360-tcpc";
> +			interrupts-extended = <&pio 100 IRQ_TYPE_LEVEL_LOW>;
> +			interrupt-names = "PD_IRQB";
> +
> +			connector {
> +				compatible = "usb-c-connector";
> +				label = "USB-C";
> +				data-role = "dual";
> +				op-sink-microwatt = <10000000>;
> +				power-role = "dual";
> +				try-power-role = "sink";
> +
> +				source-pdos = <PDO_FIXED(5000, 1000,
> +							 PDO_FIXED_DUAL_ROLE |
> +							 PDO_FIXED_DATA_SWAP)>;
> +				sink-pdos = <PDO_FIXED(5000, 3000,
> +						       PDO_FIXED_DUAL_ROLE |
> +						       PDO_FIXED_DATA_SWAP)>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						typec_con_hs: endpoint {
> +							remote-endpoint = <&mtu3_hs0_role_sw>;
> +						};
> +					};
> +
> +					port@2 {
> +						reg = <2>;
> +						typec_con_mux: endpoint {
> +							remote-endpoint = <&it5205_sbu_mux>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +/* MMC0 Controller: eMMC (HS400). Power lines are shared with UFS! */
> +&mmc0 {
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc0_default_pins>;
> +	pinctrl-1 = <&mmc0_uhs_pins>;
> +	bus-width = <8>;
> +	max-frequency = <200000000>;
> +	hs400-ds-delay = <0x14c11>;
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
> +	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
> +	status = "okay";
> +};
> +
> +/* MMC1 Controller: MicroSD card slot */
> +&mmc1 {
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc1_default_pins>, <&mmc1_pins_detect>;
> +	pinctrl-1 = <&mmc1_default_pins>;
> +	bus-width = <4>;
> +	max-frequency = <200000000>;
> +	cap-sd-highspeed;
> +	cd-gpios = <&pio 129 GPIO_ACTIVE_LOW>;
> +	no-mmc;
> +	no-sdio;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&mt6360_ldo5>;
> +	vqmmc-supply = <&mt6360_ldo3>;
> +	status = "okay";
> +};
> +
> +&mt6359_vaud18_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vbbck_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +/* For USB Hub */
> +&mt6359_vcamio_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vcn33_2_bt_ldo_reg {
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +};
> +
> +&mt6359_vcore_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vgpu11_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vproc1_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vproc2_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vpu_buck_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vrf12_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +&mt6359_vsram_md_ldo_reg {
> +	regulator-always-on;
> +};
> +
> +/* for GPU SRAM */
> +&mt6359_vsram_others_ldo_reg {
> +	regulator-min-microvolt = <750000>;
> +	regulator-max-microvolt = <750000>;
> +};
> +
> +&pio {
> +	eth_default_pins: eth-default-pins {
> +		pins-cc {
> +			pinmux = <PINMUX_GPIO85__FUNC_GBE_TXC>,
> +				 <PINMUX_GPIO86__FUNC_GBE_RXC>,
> +				 <PINMUX_GPIO87__FUNC_GBE_RXDV>,
> +				 <PINMUX_GPIO88__FUNC_GBE_TXEN>;
> +			drive-strength = <8>;
> +		};
> +
> +		pins-mdio {
> +			pinmux = <PINMUX_GPIO89__FUNC_GBE_MDC>,
> +				 <PINMUX_GPIO90__FUNC_GBE_MDIO>;
> +			input-enable;
> +		};
> +
> +		pins-power {
> +			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
> +				 <PINMUX_GPIO92__FUNC_GPIO92>;
> +			output-high;
> +		};
> +
> +		pins-rst {
> +			pinmux = <PINMUX_GPIO93__FUNC_GPIO93>;
> +		};
> +
> +		pins-rxd {
> +			pinmux = <PINMUX_GPIO81__FUNC_GBE_RXD3>,
> +				 <PINMUX_GPIO82__FUNC_GBE_RXD2>,
> +				 <PINMUX_GPIO83__FUNC_GBE_RXD1>,
> +				 <PINMUX_GPIO84__FUNC_GBE_RXD0>;
> +		};
> +
> +		pins-txd {
> +			pinmux = <PINMUX_GPIO77__FUNC_GBE_TXD3>,
> +				 <PINMUX_GPIO78__FUNC_GBE_TXD2>,
> +				 <PINMUX_GPIO79__FUNC_GBE_TXD1>,
> +				 <PINMUX_GPIO80__FUNC_GBE_TXD0>;
> +			drive-strength = <8>;
> +		};
> +	};
> +
> +	eth_sleep_pins: eth-sleep-pins {
> +		pins-cc {
> +			pinmux = <PINMUX_GPIO85__FUNC_GPIO85>,
> +				 <PINMUX_GPIO86__FUNC_GPIO86>,
> +				 <PINMUX_GPIO87__FUNC_GPIO87>,
> +				 <PINMUX_GPIO88__FUNC_GPIO88>;
> +		};
> +
> +		pins-mdio {
> +			pinmux = <PINMUX_GPIO89__FUNC_GPIO89>,
> +				 <PINMUX_GPIO90__FUNC_GPIO90>;
> +			bias-disable;
> +			input-disable;
> +		};
> +
> +		pins-rxd {
> +			pinmux = <PINMUX_GPIO81__FUNC_GPIO81>,
> +				 <PINMUX_GPIO82__FUNC_GPIO82>,
> +				 <PINMUX_GPIO83__FUNC_GPIO83>,
> +				 <PINMUX_GPIO84__FUNC_GPIO84>;
> +		};
> +
> +		pins-txd {
> +			pinmux = <PINMUX_GPIO77__FUNC_GPIO77>,
> +				 <PINMUX_GPIO78__FUNC_GPIO78>,
> +				 <PINMUX_GPIO79__FUNC_GPIO79>,
> +				 <PINMUX_GPIO80__FUNC_GPIO80>;
> +		};
> +	};
> +
> +	i2c2_pins: i2c2-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO12__FUNC_SDA2>,
> +				 <PINMUX_GPIO13__FUNC_SCL2>;
> +			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
> +			drive-strength = <6>;
> +			drive-strength-microamp = <1000>;
> +		};
> +	};
> +
> +	i2c4_pins: i2c4-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO16__FUNC_SDA4>,
> +				 <PINMUX_GPIO17__FUNC_SCL4>;
> +			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
> +			drive-strength-microamp = <1000>;
> +		};
> +	};
> +
> +	i2c6_pins: i2c6-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO25__FUNC_SDA6>,
> +				 <PINMUX_GPIO26__FUNC_SCL6>;
> +			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
> +		};
> +	};
> +
> +	mmc0_default_pins: mmc0-default-pins {
> +		pins-clk {
> +			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_CLK>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +			drive-strength = <6>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
> +				 <PINMUX_GPIO125__FUNC_MSDC0_DAT1>,
> +				 <PINMUX_GPIO124__FUNC_MSDC0_DAT2>,
> +				 <PINMUX_GPIO123__FUNC_MSDC0_DAT3>,
> +				 <PINMUX_GPIO119__FUNC_MSDC0_DAT4>,
> +				 <PINMUX_GPIO118__FUNC_MSDC0_DAT5>,
> +				 <PINMUX_GPIO117__FUNC_MSDC0_DAT6>,
> +				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
> +				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +			drive-strength = <6>;
> +			input-enable;
> +		};
> +
> +		pins-rst {
> +			pinmux = <PINMUX_GPIO120__FUNC_MSDC0_RSTB>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +			drive-strength = <6>;
> +		};
> +	};
> +
> +	mmc0_uhs_pins: mmc0-uhs-pins {
> +		pins-clk {
> +			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_CLK>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +			drive-strength = <8>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
> +				 <PINMUX_GPIO125__FUNC_MSDC0_DAT1>,
> +				 <PINMUX_GPIO124__FUNC_MSDC0_DAT2>,
> +				 <PINMUX_GPIO123__FUNC_MSDC0_DAT3>,
> +				 <PINMUX_GPIO119__FUNC_MSDC0_DAT4>,
> +				 <PINMUX_GPIO118__FUNC_MSDC0_DAT5>,
> +				 <PINMUX_GPIO117__FUNC_MSDC0_DAT6>,
> +				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
> +				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +			drive-strength = <8>;
> +			input-enable;
> +		};
> +
> +		pins-ds {
> +			pinmux = <PINMUX_GPIO127__FUNC_MSDC0_DSL>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +			drive-strength = <8>;
> +		};
> +
> +		pins-rst {
> +			pinmux = <PINMUX_GPIO120__FUNC_MSDC0_RSTB>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +			drive-strength = <8>;
> +		};
> +	};
> +
> +	mmc1_default_pins: mmc1-default-pins {
> +		pins-clk {
> +			pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +			drive-strength = <8>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
> +				 <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
> +				 <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
> +				 <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
> +				 <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +			drive-strength = <8>;
> +			input-enable;
> +		};
> +	};
> +
> +	mmc1_pins_detect: mmc1-detect-pins {
> +		pins-insert {
> +			pinmux = <PINMUX_GPIO129__FUNC_GPIO129>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	mt6360_pins: mt6360-pins {
> +		pins-irq {
> +			pinmux = <PINMUX_GPIO100__FUNC_GPIO100>,
> +				 <PINMUX_GPIO101__FUNC_GPIO101>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pcie0_default_pins: pcie0-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO19__FUNC_WAKEN>,
> +				 <PINMUX_GPIO20__FUNC_PERSTN>,
> +				 <PINMUX_GPIO21__FUNC_CLKREQN>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pcie1_default_pins: pcie1-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO0__FUNC_PERSTN_1>,
> +				 <PINMUX_GPIO1__FUNC_CLKREQN_1>,
> +				 <PINMUX_GPIO2__FUNC_WAKEN_1>;
> +			bias-disable;
> +		};
> +	};
> +
> +	spi1_pins: spi1-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO136__FUNC_SPIM1_CSB>,
> +				 <PINMUX_GPIO137__FUNC_SPIM1_CLK>,
> +				 <PINMUX_GPIO138__FUNC_SPIM1_MO>,
> +				 <PINMUX_GPIO139__FUNC_SPIM1_MI>;
> +			bias-disable;
> +		};
> +	};
> +
> +	spi2_pins: spi2-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO140__FUNC_SPIM2_CSB>,
> +				 <PINMUX_GPIO141__FUNC_SPIM2_CLK>,
> +				 <PINMUX_GPIO142__FUNC_SPIM2_MO>,
> +				 <PINMUX_GPIO143__FUNC_SPIM2_MI>;
> +			bias-disable;
> +		};
> +	};
> +
> +	uart0_pins: uart0-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
> +				 <PINMUX_GPIO99__FUNC_URXD0>;
> +		};
> +	};
> +
> +	uart1_pins: uart1-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO102__FUNC_UTXD1>,
> +				 <PINMUX_GPIO103__FUNC_URXD1>;
> +		};
> +	};
> +
> +	wifi_vreg_pins: wifi-vreg-pins {
> +		pins-wifi-pmu-en {
> +			pinmux = <PINMUX_GPIO65__FUNC_GPIO65>;
> +			output-high;
> +		};
> +
> +		pins-wifi-vreg-en {
> +			pinmux = <PINMUX_GPIO67__FUNC_GPIO67>;
> +		};
> +	};
> +};
> +
> +&pcie0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_default_pins>;
> +	status = "okay";
> +};
> +
> +&pcie1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie1_default_pins>;
> +	status = "okay";
> +};
> +
> +&pmic {
> +	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&scp {
> +	memory-region = <&scp_mem>;
> +	status = "okay";
> +};
> +
> +&spi1 {
> +	/* Exposed at 40 pin connector */
> +	pinctrl-0 = <&spi1_pins>;
> +	pinctrl-names = "default";
> +	mediatek,pad-select = <0>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +};
> +
> +&spi2 {
> +	/* Exposed at 40 pin connector */
> +	pinctrl-0 = <&spi2_pins>;
> +	pinctrl-names = "default";
> +	mediatek,pad-select = <0>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +};
> +
> +&spmi {
> +	#address-cells = <2>;
> +	#size-cells = <0>;
> +
> +	mt6315_6: pmic@6 {
> +		compatible = "mediatek,mt6315-regulator";
> +		reg = <0x6 SPMI_USID>;
> +
> +		regulators {
> +			mt6315_6_vbuck1: vbuck1 {
> +				regulator-compatible = "vbuck1";
> +				regulator-name = "Vbcpu";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1193750>;
> +				regulator-enable-ramp-delay = <256>;
> +				regulator-allowed-modes = <0 1 2>;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	mt6315_7: pmic@7 {
> +		compatible = "mediatek,mt6315-regulator";
> +		reg = <0x7 SPMI_USID>;
> +
> +		regulators {
> +			mt6315_7_vbuck1: vbuck1 {
> +				regulator-compatible = "vbuck1";
> +				regulator-name = "Vgpu";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1193750>;
> +				regulator-enable-ramp-delay = <256>;
> +				regulator-allowed-modes = <0 1 2>;
> +			};
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	/* Exposed at 40 pin connector */
> +	pinctrl-0 = <&uart0_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	/* Exposed at 40 pin connector */
> +	pinctrl-0 = <&uart1_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&ssusb0 {
> +	role-switch-default-mode = "host";
> +	usb-role-switch;
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +
> +	port {
> +		mtu3_hs0_role_sw: endpoint {
> +			remote-endpoint = <&typec_con_hs>;
> +		};
> +	};
> +};
> +
> +&ssusb2 {
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
> +&xhci0 {
> +	vbus-supply = <&otg_vbus_regulator>;
> +	status = "okay";
> +};
> +
> +&xhci1 {
> +	/* MT7921's USB Bluetooth has issues with USB2 LPM */
> +	usb2-lpm-disable;
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	vbus-supply = <&vsys>;
> +	status = "okay";
> +};
> +
> +&xhci2 {
> +	vbus-supply = <&vsys>;
> +	status = "okay";
> +};

