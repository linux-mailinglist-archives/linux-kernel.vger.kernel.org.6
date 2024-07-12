Return-Path: <linux-kernel+bounces-250052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBE792F37D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0E328393B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 01:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135A0567D;
	Fri, 12 Jul 2024 01:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bIvTy2on"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2041.outbound.protection.outlook.com [40.92.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277BC8F40;
	Fri, 12 Jul 2024 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720748043; cv=fail; b=lu3q338eVK5Y6ruUkva+TgwdSE8VaIsVCsV7fPrM3AgQ2g/x5ZI1yugTlOVwRXm8FON0omJdOMj4Q9Eff684003Qjq103VeceSB5uNp9USlXW/ztvftx0gX9fn6MI+gaBVjUJLyoQ6D3cVgGQbnNkmKhoSu5y35954IpSjR4CmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720748043; c=relaxed/simple;
	bh=5VWzZyXn7P1pMVKVUNBxGuidWKoh9rwK+5rVfe9HZxA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oma2QFM0RYM/3732HddVOfq5qNi/dTBAWrEjZkfpphiOlWmZhdlcZyWakb5G9WkVywLDY2r6ekkuKSiaikjd7huf/4ddDUatPrpZthbrxXQ5CpdYHuHF9W+0W/jhC6cUyo98+z3AmI7JnEgDGrFbOGLnQ0DQx0VmaYvonX/4pyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bIvTy2on; arc=fail smtp.client-ip=40.92.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEwrLkMQfNKvoO9oyMzYXr7vO5T07d/i5LXCavS4Js3SgDN7Ek3N3gaeQup5MKG/zd5nJiQdpg704c+imnilHDFQxerFZe/HPeJdLVcpOwuphbLgMG9ZGjSGXM2oN0LUcb6SLulg9b35i+Gm2e2B8bXPPAq1jBwqfAQ/E0PfhUkXSyufOPEekBNOe5yUolfnZwpQrrFSqYJH41EzRck/oTYHzL0CWzKd9DTAg7F848LFiNv3rLA9FUydJ/hVcGeDWABAmAmQ2ZJILbNodIxexIakhhI1hCYK8b/HnX/Iy4Jo89Uj1A6W4QyGSijxfAi7TopSO1EeVJDZr5QXi0vNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxNcn3NFcwECsF608DtFCjv9MWTnvbm31NoyPmUzUpY=;
 b=JIS3YVkJLWgDdeoczuPJkvusQ7G248llTyjnhuNG9EzxQOfqqBndUsNmjmO6wnCtdsZZMpHY9gkxz3NDshSZ+9+nXPfPw4E10txjClaEHlpTwEMAduSv8NzDf61EYOOTrFN2eFEqFQHLSZxgEk2r7HOH3Zbj15uI7yOOw8rrYWLUSXl80mJnVOaeBoMgekf/yYELyxwlgeXOATQH4YpQd+xNun8+WEuCvOnf7AiTOFTg7DbUn2m6I7zhhJ7xIYH52bziT9oMl/SXr1mtFgJniTox2rDxDhk3AauE8fslhpbhWqYtPXd6PJUgKuX8UFDw8WWaRpk+ct5AbtmNf99ZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxNcn3NFcwECsF608DtFCjv9MWTnvbm31NoyPmUzUpY=;
 b=bIvTy2onp9U75AKkNk2ntbKn0NSw3DkfgDIgIIMyav9S3hUphD3btjQ4Mfctnlem9PF3Tc1zUgxPv9ihYGrr2y7SYzwcNMFWkPsSGsr2FAP5CO/6KggqBRJlZK45pAtVxvoC+SlEZTFT5LMixmPJZqL9KZ1jgNusQUlx4pYvjCMnJoJzVA+Za939rahVOnVaypHWNAjpbOvDoEg0uh3G6GzGZU6o8loH0KSBRePp8QJ6yzo35iykhMRxBfIosHdL7uYALKeW9P+8B0d+KyLl1K+/81kFVIrJzy96pHWqLd1Nieb66xlPITKM6nDmlM69NO/gvTKnGm15s+vSL4Gg3Q==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB0489.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:11c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 01:33:53 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 01:33:52 +0000
Message-ID:
 <MA0P287MB2822C4E2EEFB67F82458C390FEA62@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 12 Jul 2024 09:33:46 +0800
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
X-TMN: [XLMLPywzSoIB5ldrPMmiF5rG5qJ0wW4h]
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <e8830886-19bc-435d-b35c-39cf0718a9f4@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB0489:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d173977-b2dc-46f9-41ab-08dca212afeb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|4302099013|3412199025|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	dfXCkZuf2S2mY7Aaq/+Wb5GH8jW/EgtTwCGapcgeuMC3se/a9mWd5bKPJE8v8lw+h+kyzVcFlhYG+tUI8OJzkiO2pMCrgrGvc6/LgfxSZtUwJc1uj2ZgK6CFZKTqqEIvQz8mVAjMM75QUy+PEEAvjL/cn78HYT1nHpJutWMPdUzvjB3KOa1Pjk5/B0/+OsV6jJEXXUtBaCBPfY4m2bJAOMp6rpRcNnsp761vMcvWm6hO1GSGqihuuU8luI1a/xN7YuXw9OFdYz9hcnXfX1XfLr6f2Ay+QC+NrAdnXll023zory1azUnrbkCrlpVi4znQ7W971PPWGvOdcODKrAkHQKt7rSeqoqMACpQDiCLMBl0VrDhE1nwq8awXDT8FnAYWx2xbrl76STjadvnOKMqX2VbFJJYSCVo5tqfrOqkq+lHrsdZnDMmCwKTnYJlNQewHh2Iq6EqGuxzQjT2DeYKDERSxJrmqrZ+1ZRAqsq7HKZ3ysKB3BF8slYtK5xTaBb7C5lMSkt842RmuJcWElW1ePpvHyLNkuk+L7os1mQG3wLW4/J4N5SADKc8qxJXy9ZaPJhOwdvJQl4oO71Ol5ORSzWi7dMKixAyq3uM4na0swcUGAmNmAOsqtBqRZfiCjgaEL7Az7PWNLo+VQBfMntHZFgHMkxDiocitHSN5+eLm3I3xN/jOGqCmBLTaMyQvrh8TX3RtRKYerTVrWcWKqNBiwmFo27UOIiGR7FyQBOcHWs/f4zkikLH6aFjaTJCIeOiW0lcRhXyU9cCwczi8mB3rFA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXJ6Q0duaWZQTUFYNUJsY3dUakNkSElkeDNJODkyVlo3R2pUZHFBZFdDcHFU?=
 =?utf-8?B?eXNPa1VzUXJiSDlORXliekFZRTF1aGFJS25UQSswZmZKNTBaR3RzbndmaEZN?=
 =?utf-8?B?WTRVZFNYUzdTSzFmSVNBU0ZIVWNrZFNPRDIybkMrUnNkRzFJbTFGSFk1OVND?=
 =?utf-8?B?WThVeXVjTFN6UUQ5aEljNjBkdkNKeThFbXN5SlpKMXVrRHJ2dHQ4L1JDSUJM?=
 =?utf-8?B?aVBiQW05VEFXWU5walduR2ZEYlltU0p2cWdYc20rOVVRYXVheU80d0xOZUYv?=
 =?utf-8?B?TWJDTU5pbkdJRlpOdjV1R3lUdHBmVGkvekJKSUhJL1Uvc056SFJQTTJzb21F?=
 =?utf-8?B?eWNaeUdzZHl2bXRJQVhHMHNHWW94eXd2YVZXM0hVNWNRc1oyYmJpUnFrN3dK?=
 =?utf-8?B?dGZCQzRsS0dpVERQUDRYOGJ2aUE4UDZaWlpwNzE3YzBSVjI2eWZtUlpFY1g3?=
 =?utf-8?B?N0lKQlFYaHZ4eDFsbGk3NXRsSmdyelVDL1Q5TDR1ejErTUpIZmZYRDgzZEpm?=
 =?utf-8?B?WUtoQURaR3Ntek1XTUVZdVJ1c2tjbndSRW52enFFMjJ0OEZFQ0tGOU1Wa0NY?=
 =?utf-8?B?U2hYVWtTVE5MMEZYN0RadGRyUzRYd1JDSUN0b0dOcDRKMEtzTm4rcHZVWEFh?=
 =?utf-8?B?Vi9rZTZBQkxBbm16aHp1L3MraTh3VzBoc0VEcElzNks2SkZWR25kR0VHOGZi?=
 =?utf-8?B?YnpHRjdZOUdIQ2F6b2s3U0NiK2hzSmxseVE3dk9kczFEWlUxVllnUlhGdFNU?=
 =?utf-8?B?S1dGayt1QnRUVUk3bHpSZU4wRWZnaDl1SWVpclRkUzVoWGNzRU1xUDFQakNL?=
 =?utf-8?B?TGFVWCtnd3VoR0lDZUZjRXFXdWdZMklTK0RGa0N1YThWMDZqMHBwZVp6NUdh?=
 =?utf-8?B?Ykxld1B2WGFOdEhwNlRZMjEzTnZWUUVyUGZ3YXM4SVlaOTQ3Ky94Ui9ZMGV6?=
 =?utf-8?B?SUppUnVOVXpjVWFtTUJpc2VpS0VrUTFTZWFnd2ZuT0ljbVdsaXV1eUhmTVho?=
 =?utf-8?B?RkJhMTBEd0lsMDdwZlVBSWpiSitlZ1Q1SDROc2p4cEpDSlQyWVNORTc4bGl0?=
 =?utf-8?B?ZXNHd2ZqUFdaL1poSmtJREZaNVNvM0M0bVJ4S0IrRGY0RzZ5cnhaMXVuV0FE?=
 =?utf-8?B?cCtzRU9UTGwxODFpL3pVOGJSU2pHSTZoOTV0bEczY1VBb2lzT2d0eW5iY0xa?=
 =?utf-8?B?WXlRd2RPOXZvOW1lQzM5MVJJUlc3SEhla3pkUkpSQ1l3ZE1QZFd2SEx5YVlr?=
 =?utf-8?B?MG5mQXpWV2MxRTg3eGI5L0NPMytUMGs0TVhOTUVqcVhKM2FYZzJMMklyK0Jh?=
 =?utf-8?B?QXdPNkFEbnhQS2JHUEFsaHJkVi92ZzZ3cnVZUmEwWVpNQmVkUzF3K2Fybk8y?=
 =?utf-8?B?QTcxWmhWUUpGcTZubXN4M1NiaS9mOWRrbit2OW02YU9FallORDZWUGFaNkE2?=
 =?utf-8?B?dXBrVlBBOElpbHFxUzhGL0dwTlUxYkpVbHVnQ2R2b2ZBaVp3VjFHQThsQS9D?=
 =?utf-8?B?bm9hT2QwbzNMZjFlR2JhN0NDQWJrWDhNbndyMDhHa0locFhqbEFpTmNzbm5M?=
 =?utf-8?B?MWt3R2RKUHVwc1FuUWEwZ3ZkOFA2ZmxCT0RvNkdJeUlJWS9VTFVvRWRhb2h0?=
 =?utf-8?B?UjNuTlBoakpYMm1QVk04ZmxHQWdrMU1sZnpKWGd0L0hpemlSd2RKczlPMXl0?=
 =?utf-8?Q?TqiSzd0msW+k30Iwxgm4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d173977-b2dc-46f9-41ab-08dca212afeb
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 01:33:52.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0489

hi, Conor,

How about letting me PR all the four patches in this patchset? Because 
they are all related to sophgo, it would be better to PR them together 
to avoid confusion.
Especially about the change of sifive,plic-1.0.0.yaml, my original 
understanding was that it should be handled by you.

Regards,

Chen

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

