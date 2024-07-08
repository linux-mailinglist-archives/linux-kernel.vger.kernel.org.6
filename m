Return-Path: <linux-kernel+bounces-244995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDEC92ACB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62781C216BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4FA1527B8;
	Mon,  8 Jul 2024 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ICMlBQRI"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2046.outbound.protection.outlook.com [40.92.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09C13A27B;
	Mon,  8 Jul 2024 23:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720482865; cv=fail; b=efKN6ldNNDpbT009pM7Ils7xXKUHDzG9XdqwrUirs4uhnVl7vvC4bO0Ci4pLm8wO0HVEYdTNPxsN4H1NInRih78zPcCOb/gZUSrC7oA970sPueUXls39k0X4m/32PjiMq+uYckOwgYZesUb0eLPAStHwCLABNnOxtK4nZ92EKak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720482865; c=relaxed/simple;
	bh=8UGhpPs8jrOcCIRyLnAnqflKdy82t+DSFEnDUr2+JW4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h/pR1z4f8ak1P7F//fq+kKjt+tFXyYs1Q3VG5dqc8+4TobiFUV8KNO2GVcuyGXx3TeKN7RWmZG44sp1dWBXdkf5mvW3MZessn94HvcnJe/MJ2QkTHIO97ft5NiyEVlMAu7Srl2y3m/C9nodm+w+KveZvWFQDPkewp/UkFY3dYfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ICMlBQRI; arc=fail smtp.client-ip=40.92.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCnVu2DYJHZPaL43Qe2fElFmk149j0Akn/icjaAMromRmocXH6Cu79Z2VqNA+BWSbr3iDQaAiQzFw5VgWIap+VrIJ3+vmoi1d6Dq6T8tK1sPJ/6T0TqTtgfjuAu9g0KUMSccs06ymBqucPKJKPBICdNbc6tpVDXuFnNAbSp0EPqbZrbN3eaChSZYEJm5KrNjFskyA9s1LD5OpcDqykk19EOxS51TuA1H297ZFZ5+CgY9F1sKdCxM0kcTOPD6B0VqE1cywHo6nEuWjCTyfEXXuVU8vDL/A81g67QK5Ufob09livaw7rdqWhvKV/Z7+83yVT4W9Kphzln+wvQTeVIGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7xSaqLWa+DqO06MrCozuegSb0GWUYlLFX4VGoPeAAM=;
 b=BUdVNICTefjIfmB8Y+gqqeAbI5mOkNC0mrmFB/dHSvWvMl8P7IRfqe5LGHuNUYXlPvWx7ENyeaY67aSL4EG0Pa3Kk/9GwrFx1rzbEwzISVp+GtCX/b3E+IbFcu1YaPirQ04UHl1PaOseVyinDRqXkIkJetzVi5d48TRzKHsuncMxlVQMhOetaACTcl37T138e1D0Imf59eP7y5xm41tgUGbKs3Z7zit5rcJWeR/dW8G43Zh2GMGM5a1FvL83czOJuq4Mdzz/YV+zYZ3+vZg9ZqU6GBXobpdIaiawm89tJYCDoeyjczXvhUgqvhREsawwuncrZXpBWiemKYocPBIkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7xSaqLWa+DqO06MrCozuegSb0GWUYlLFX4VGoPeAAM=;
 b=ICMlBQRIqr4DM3Trl9N3+L4emi24buuFzBokVsBEncyFq4a0mdcaeRIk5+4YB/YQ9+Kfl3nT6kWrRXlvANcFuJALUXltFU2sqkHMXZH+dokcLqY7OtXaJKNNVGxZ5mCjugZUTXvOpwr4Mv2chlTDm0rFVkm375IGgC4UlD9Y7POluWoiMMlyUy5omUT4xSiHQaekl4qNgGuAlt3SKSpjNCx8ZcUM7Bu+2y/faJTC0SMR9B2cLX2G5IuE2Ey2FXCUqLSLihJwvXs55jF9oUDDtXCT9tvuVibrgzpNlxbeMdLwZG1k9JntTdvQuGerdaptyw6xH2nClAxwiuPQPiPIUQ==
Received: from PN1P287MB2818.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:214::7)
 by PN0P287MB0200.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 23:54:16 +0000
Received: from PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a8a:9e40:a4e8:3e2d]) by PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a8a:9e40:a4e8:3e2d%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 23:54:16 +0000
Message-ID:
 <PN1P287MB2818314AA91FB6D244981515FEDA2@PN1P287MB2818.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 9 Jul 2024 07:54:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: phy: add YAML schema for cv1800-usb-phy
 driver bindings
To: Inochi Amaoto <inochiama@outlook.com>, Yao Zi <ziyao@disroot.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240708120830.5785-1-ziyao@disroot.org>
 <20240708120830.5785-2-ziyao@disroot.org>
 <IA1PR20MB495304D471AE08F75D97C25FBBDA2@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB495304D471AE08F75D97C25FBBDA2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [usj2CuUMzCopRg4B+YjYgig4s8Qy4wgn]
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:214::7)
X-Microsoft-Original-Message-ID:
 <fde6fd12-7244-43a3-895e-09de3b841b69@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN1P287MB2818:EE_|PN0P287MB0200:EE_
X-MS-Office365-Filtering-Correlation-Id: 52aa5d88-830d-4c1a-bb1b-08dc9fa94671
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQDyb02v8aRKJxA2TpzIR9U/bbxD+ndoxrmUoXxNY4IScJUpVygK372ofKlIpEBgDdhXH6J2ZOj4VGKE0z7XuzDPkPgLKDm1OdTHFB4rJECcc4L5eHw2FGRw7ixp00t3Umrnachp3JtFt6fe3g/Gdorz9QBEJn3JnviKng7aweXz/d1WirgvVulJb/09drUfGAf1X2woVe4i/KeyrDZUljY4Mwg350OcLcvlS65v16PiLSvivZbZYsuPAQqJQR3tt9OIdMBYboUnO/UN1Bx7YPTmbyXolPNS1j+MaqNob3ypX+d4/jgsAxzGcZtnNfWvBTuCJG6rL8hjILXEckxoTa38cbqvMtpi6NKjQANtf4Klpzw8IZR/JHQTjJcqbAkog8YtKOQjPOU8L7YqhjL0xWvJGp8LVbjuMSe7xJX6QxWWWMB+KO9T97ptSk0gKVsDHDi2UjCUTPzOSiiyKkFxZ7vmv6tRuiaZzvfKrRZgawFTQmK/UCWxeTJEpmQIgWhMRY3xXjxe0VBbLGZGnhSnCU8+ds0xAycJMN7WXnIT6dfe9RykJ1nWTauftLvWCqa90Spt9g5SUh98G75w4qa046NTFVDrZT2QVzajIB3tigd+mGLIiBI+HjSZXCnw12CKUFW4QbFM+rvj8bLslx7H2hz35HTtgx07+/WEN0DP1Dp6C0YSB9qa8UuGiMvaidOkG9YtbRkxA2t1tQtgj7h8hN75Ou52lo3es1Zw7jp2s2gm0y+lxlZeKJ9rcVKdAcEiSI0/79wxWqksuzWGoolwbmShMwDncdBuqSt0O7ITeNIFfwRE7ykSo7/Q
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|440099028|4302099013|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	M/loXdmVmZJ4qyLOk6OdrwgHAHqXdN/rHK8uSUVCoWNA6HdzCd/ypiZUO0eVNkn7bLQksX0sF5AVRV50c6plDktgUE9MLTD2X0OfnpILtiWpJBVySTJy3gZB+ZkkZed4R11M4vHlAW7d3QHiR9nk2l2r0OYxixJmib+gk2JcEw8sPHXilPiCJ84zgj9fUl5I7KlnOALmMajXtecQHNBbrHMrTPs6J+uKnfy8jxi183NM5zVqdJn8D+ixKKJ9rRshz4bDt3ZhxFAbkNiFGqf5S+K2OUxSpBJe8pRtiUph6SPQ1jDugUa970VowwcSGG1jl0qKEvPo1iJpluhFJ+4Fujx1w4GOvNOXz+dBjjTWsXOnDhFXMGjbarGINhUCXu/Zm+Wwi2gclJr8TV0kM6NMRWH204wCzuxEM/3pkW7biMlmF54tE2cLFjBN8sPWra3XfcnqbyhPTQdCxFUJi7dOzD0jdPifrUoywiIswGCO7QzRjRkArBDffhNuSPhJSnHzcrYFss2Re9Ka3JTI3owpyVcCKWX+jGLh0Dc5njaHwExsdHO1TKjkfjyAYPT1IdsPVX+9+lC/8PzD7LScijHiLwB9hkIalI+X923sQ2pzPGYPUmhyE5y2HAMfyjTfOBC0g8N2oE6JJURCTbbUz4jX6kZ/zhKdfyMCwzK5MsV2+TuxFaa1kTStXZ4/ZyE8l/55juSlDaC5azg4DJKCQmoxY5y2Ml7Jp7wQEdD7Jy9kgfXGYYSz5FPP6pZ0ewbo9yIW56XG5KPiDAMMJ/FXP2+g7Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHRGem5lU0ZaTkljNnloSE1TKzd3VDl6aUd3S0lZS0FYZG02c1VRdTMrWUpQ?=
 =?utf-8?B?dGtMazNOZitTWUhIRWNrbE9Gc29EODc4MTMzaElNekNQV3VpL1REVmMya1Rj?=
 =?utf-8?B?My9jc1BZZGY2S0JYd0tLVHQ2UTk1TVVHTUlNU0M4dlpDRXJvRnBOa25HWElp?=
 =?utf-8?B?T3lzK1JKV1ptdEtvcUVFZTFqSjBkUjVqaVV3bE9tUGZaSUxWSHJjK2NQL0hE?=
 =?utf-8?B?aGR6OWtPYWRBMVRabHVQNGl2MGJLRnBmcmwwM3haN1R0WWtGaTFqV2hxT3Fr?=
 =?utf-8?B?WFRCamZ6MEdxNGVobS91c05kNDJMMWQ0S1VaelQ1TWpQY0E2YWVDQlRkSjBE?=
 =?utf-8?B?d2piU2l0RmNENi96S1VQb2szMWYxQTRvMlFnZk8xOUNSTG1sSzNST3BXbVRD?=
 =?utf-8?B?UFlaT3c4SjN1UWRqYVJkeEp2dXF1UGZ6SHVjNmFhNFo3T0V0MnhoNnhkcG8r?=
 =?utf-8?B?WGpJUys0SlcyRlZYSGd3YUFNOEwwR2RQUFhNaTBXN1FDSHFkVS9zeGQ1ZWJt?=
 =?utf-8?B?QTFONkVTdjY2djdIbVMzRkRvZnBmSk5NdFk2bmthS3B5QTFVMlVHbWpwN05D?=
 =?utf-8?B?RDA4MWdpRGVlcTJuSWYrQ3p5dTF3c3hmdzgrRVc2L00vOWNrNkZRalVoRjJH?=
 =?utf-8?B?MDN0TXBvTmVsQ2dlRTlCNFNaTDRPcTZnN0pvZGJGdk4rdEgwMjY0VU15NGVk?=
 =?utf-8?B?VEFYb2I2RnlPM040Z0ZERWI3bVdlaWJkeFoybzIxdVVSWEN0cXh0YmRCUlp5?=
 =?utf-8?B?UmhjdWQ2TlczVzNRVzhqUjVFWlV1R09PT2FDbFNxZkVGQ1ZtMnFrQldFaFVL?=
 =?utf-8?B?SktzSEtqTkF1ekJ2bkVIVnpRNGFyMEg1WkRkYVE1UGFEbE5JUHMya0dVNGJz?=
 =?utf-8?B?dEtwSXY3c0RGbFQ4eUhLUDBGbXEvRG5kVHFucFJrdUZDTjZXSEl3L3JCSFlE?=
 =?utf-8?B?U0ZDVWxKNG1aUmt0WlJMV2VXdzZ1REs3RXUrdXBkMkxCbzlDLzZnazdYdmhs?=
 =?utf-8?B?LzBjWUwxeXk1WkRMR0ZlNjZpNVdtTGI5TWtEYURnd3hqMFBaSkxZd2U1ejdG?=
 =?utf-8?B?eGI2MXBrVnE3VGMrZ2VVK3RNN1JxNU1tdmxha2xsMzByWVB1TFowdVhja3Jk?=
 =?utf-8?B?bXZwZUZNZnNQOXJXR1JjcGliZzYvTDBQRnM4UzZDaWdqbkVxVjNrNEs0c0s1?=
 =?utf-8?B?L011RmhkMU1mVXlKT2wzKzljQTdlNVp3OXU2V0luRXl2bmg5a1BUNS9DL1NQ?=
 =?utf-8?B?R2lkcGtHeWpLSy9jVzdURFNoRkg0V1BTZVRPSmJ1M2dObTZFS0xCMzh4TmxT?=
 =?utf-8?B?SWJPU3ZWN1N3L2JVdnRSUVEvY2tVTjZjNnpUS002cHpHbm5RME9RblhtK2J4?=
 =?utf-8?B?T2JrWE5GMGxVeXcxSkdVZ2RRc1FXMFJCcXpWZ0tLSGt6VTlxNUxBS2pHK0JI?=
 =?utf-8?B?dkJ2K2ZFQWwwclppOE1id25xTWFlNC8waDc2RHRaMTRBUkJmREpSNDdnRHIz?=
 =?utf-8?B?Q0hmU1crNVNuRFlWUi9oZFM1QVFwYjJzWXhxTXUzbUNhNkJvWnk3ZERrMVNh?=
 =?utf-8?B?V3RDYjB4NjNvQTlyMXgxWWtDckQxVHJpblV2WmZRQ0Y2b0IyZk1KcklMSjdE?=
 =?utf-8?B?akd1d0RzL3VtNjh2UGR1T0UxLzVDMW1FWi8wSSt0NjVqcnpkMEVEc0doeU05?=
 =?utf-8?Q?pzR86soRrcFqR6pWmFPv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52aa5d88-830d-4c1a-bb1b-08dc9fa94671
X-MS-Exchange-CrossTenant-AuthSource: PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 23:54:16.2921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0200


On 2024/7/9 6:23, Inochi Amaoto wrote:
[......]
> You patch is duplicated, I have sumbitted patches
> month ago and still needs some time to figure out
> the best topology. Phy driver belongs to syscon,
> which make things kind of complex.
>
> https://lore.kernel.org/all/IA1PR20MB4953C1876484E149AA390DD5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com/#t
>
> Regards,
> Inochi

hi, Yao,

Thanks for your contribution.

Just FYI, we are archiving and tracking all PR status about sophgo 
products at https://github.com/sophgo/linux/wiki.

Regards,

Chen


