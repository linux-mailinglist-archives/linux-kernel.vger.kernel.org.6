Return-Path: <linux-kernel+bounces-282710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A525694E7BC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1691C21BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBAF158539;
	Mon, 12 Aug 2024 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="p8Dmlhzb"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2101.outbound.protection.outlook.com [40.107.255.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41D6154C02;
	Mon, 12 Aug 2024 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447587; cv=fail; b=EEq6XXxkF/jKMzAeLs6S8GzsHtQerqHNhiZHu0FQz0SbS1hmUKbfoDBrLUtj/dc+9BISDNeKkbVuha0gb9lA4B1CQRxKDep/R6EcMLx3P6qMDbtmzRBEjUXdsEOfIbBGpPMz2vumXl4018HfMV8NyUAHdT6xv+ksAlz+hN9kPss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447587; c=relaxed/simple;
	bh=feSmg0D2x1Rz63ptHM7cp9SkGK0L3wq2CQLS7CSbywI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qmr0Dj+RLukgadpUpfrigL280LJd2sHm8SNoI7t6fV//jjH+EoyGG/lGORiOT5tRzj93xzCYfJbLS1047l51lghQO3rt1WYJHULfT1AbiIdNhmhlVe3R+qdnO5k4GDdfb3/y8IwMjzTBWUCcbuLREdX1MkjB5AJdA9pcC3X9Ztg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=p8Dmlhzb; arc=fail smtp.client-ip=40.107.255.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mb0m1yZvXfUNudZGefRnanky/I+xUEhTt8lAv1yga3J3jqc7i4oVAWeXtmpcFSuLlUnVozkUJOXSnSOXHwh8JEMdc7YIExQU6JVw/DdNkUbfB+scvX2+T4e8wd71nR+Lgpjuj4fp+KGx/apM2oZ7taY9NwoSQFwplBTPM4dRE73d92CfPABuNSZYywj95IRJ9hiC4FfDzOIjZrhVOkfM6pv8XQ6BpmykbAH9xOj37fwYPigPNTg38ygBCCWlU+LTBWf+pM28VzT9NgCf1TqpFYOYaZL4Vic2Vr/abvAF8I9Y+bjTngIf76khJD/gjaNgxTKx23vnIQwkSGoU00sAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feSmg0D2x1Rz63ptHM7cp9SkGK0L3wq2CQLS7CSbywI=;
 b=TJ+DKGFLH3u/qtr7/qX0ajaS/kDWWtv1muxhG0VWjAx1fjPAtDgbTGcq1oe3PPs4Oa8jIOuldbZsd1gVmw7Mef+Cu43a4HtLngJRQuvHqGevpyOFFG0TT5lwjk6MwBA6SLRFh52A5AO+YwecudWIhJSOJDJnRnrvxIL9wex0wUxmvWCAIN7kNwHKkauFEFkVVC02JXnYePQasdebnEFaLb7jZr7/SP7jvrU7z2xhfOFIt2hyV+Bq+gBZCsFLVLbus75JVInHXhAeWtxQpujUJbzFJkhCg9zUQljkYcUyK1XQ33uMXvwm8H7FAktO7UT56JJU4GsbIaWRZPknuCmDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feSmg0D2x1Rz63ptHM7cp9SkGK0L3wq2CQLS7CSbywI=;
 b=p8Dmlhzbhv6822nflCA77gTSXggdjB+T2Jw3qDZN6w0+hxccw8xgMTziNS+2LdWhDIVd5tjM0vaoVzHlieU8c0jV3qOjMU+glcPTrcI3NymfDByc2MEAcqXICe7Ej+B4qFhwMjjekcqCFIk3v3QLDeklcJUX5EyShCKQ5m7VBYQZvueTsmwXcmjqEVutBucRm5byTmfNk2nexl8PVAg2YCTKwD57t24LdOpZZIpUXuZF9Og9AzcPfeWLtQUZbMEnX6BeYK1PyJV1g0iGinNmTHm5rlyyK6QsRP3IybDCTjYJaPrY+5LmdBG590obad9oli/GHVfs1zIdGD0YMdz+Vg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SG2PR06MB5405.apcprd06.prod.outlook.com (2603:1096:4:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 07:26:18 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 07:26:18 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Lee
 Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Topic: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Index: AQHa6WjvtGERsBjdbUe0s1M0hUJcKbIdCjAAgAFhFjCAAAaDgIAABO+QgATIDfA=
Date: Mon, 12 Aug 2024 07:26:18 +0000
Message-ID:
 <OS8PR06MB7541B0D9A43B989DC1738F68F2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-4-ryan_chen@aspeedtech.com>
 <14ef9485-54ba-402b-9b90-5f10c1523d4e@wanadoo.fr>
 <OS8PR06MB75413728F0FCEE022B4B4F5BF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <eec21668-3674-40c6-b443-90c7c02262e3@kernel.org>
 <OS8PR06MB7541CA018C86E262F826B9E5F2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
In-Reply-To:
 <OS8PR06MB7541CA018C86E262F826B9E5F2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SG2PR06MB5405:EE_
x-ms-office365-filtering-correlation-id: 3ff8c4ae-1213-4ad4-9cd5-08dcbaa00ea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFdQV3JHQWVaQUY3Y21WSTlzRld6Wko5Z01XUlVjS3R4MkQzYm1mb3dORjg1?=
 =?utf-8?B?YkcyQWJ6bGYwR2xwVXJNcm5pOG5iSFkzTVFGVndpNFNaUE9ZMml2R1RCS0pL?=
 =?utf-8?B?dWtOa3FUalY3OGRLeUNIZTI0dXNXL0YvWE9nSGJ6N3NXb3UrQ2xKSldYM2sy?=
 =?utf-8?B?OTZvbGZqR1o0bkpub1dnVk0rN0NOdi90cmViTDAzRlhvd3RUOWdZM1RWaVlX?=
 =?utf-8?B?QUEzU3pPSjg2UVFYeXNzbFROVVF1TENDRmUwUm1MUDVsQzNiWkthaUhsVU5F?=
 =?utf-8?B?QmhXNGJ3Sk5hZFdEbWR4UXA5YTh5bFJhS0k0TEJRK2tsb3RzOG9yY05Pdkc2?=
 =?utf-8?B?YjFDdjN0NDNWRWpldUZaOTNCcGdzMzBiNXdwdXphTWg3azQ1R0hoY1JUMWU4?=
 =?utf-8?B?OTFTWm5ObmFLVTZrb1QzamNUZzd1L1RDSjE5cVZVb0t4d0syYVNGU0hZVjVi?=
 =?utf-8?B?VVFKa1BOTU9STjVnL2p0dEFWZ2NIekZtRkRpaDhqcEVldS9zRkViNTNvdjZy?=
 =?utf-8?B?ZVRiT1E2SjRpbEZtY2x2NEpoN0dsMWlMalZmOE0vOWlLMkRxR2cvcW1MVmkx?=
 =?utf-8?B?czNWQm9ZY3AydXQ2M0tPbHZLeFo4WGdTNEhSd3pzRW9oVlY5RG1iWis0R0lH?=
 =?utf-8?B?TlVxMDFJb1ZlVTJIZlFqZWE4VlRSUUdvejM5dWJ4TnVnV0xEL3hjYlJDZy9T?=
 =?utf-8?B?cURodHVZc1E0dVMyRERZaUh4cnc4T25TZFQ3TjhkQjdReHMxRjZSQi9pYldU?=
 =?utf-8?B?L2tHUGVYVldFZ2E4MTVSK0M2cktnWmpuaE5UK0tWWWZGb3g5cHhMSm9ZRkJ5?=
 =?utf-8?B?SWRUNEVrL1pYeWZ1ZjlnRnNsL1B4bGZTOXd4RGowRUVCaVBIeURoNXVveVRj?=
 =?utf-8?B?WDczczJ5d0ZiRXF6OWNPTjJSM0g5emd5dUgyZ3BmM2ExME5CdVc3eldwWGZl?=
 =?utf-8?B?bDFURVhHVzIvZGJRRHByV2NFVm41REtLNGljNzJqdTRVQi82cjNWS0hNOHl3?=
 =?utf-8?B?QXJKblIyRFBCNS9xREVIMnRCOHFVNFREczBWMjA5cUtYbDVFZ2wyQTN1OVdz?=
 =?utf-8?B?SHp4Sk9DU3VjVEFweFpaYmMveDdKSTYybkhqVEthT2NtS0VWZnJEN3BQT08w?=
 =?utf-8?B?a09BK2ZNR1cyQksyM1QvbUpmQVNydlYxWDRnQUpMREpNVHMyYWxUSXR5SWpS?=
 =?utf-8?B?S1l6SHpoVWhWcmh3VWRqaTdFamxsUXpOOGM1Wm5sd2lranozRlJibGFKeHB6?=
 =?utf-8?B?ZkIrSmVQTmlOTFgwbDJKS09VZmZOQWlXZi84bWhLVVBBQlVsRmt6TmZWR0l0?=
 =?utf-8?B?NHovT0FjbnlGNFVWWHJGbjAyZzB3Z2dXbkRzektwdUdrQitWeG50cStGVndn?=
 =?utf-8?B?SGViWXM4MHE4akxuTDNIbGY3MWlVTi9uZTFlTjA4L3B3VkxyOUxua0xKcXY0?=
 =?utf-8?B?UUxkc2lrTGNBazhvVkt1anhXdWd0QUtjWnczQU55VEZNNWl0YkJIQmtIQWZQ?=
 =?utf-8?B?NVM3ZzVRYlJIaVdLSmdnUWE3ZTFDM3dqaVcwWDh4SmEyTVdoSzNWWmpnTStw?=
 =?utf-8?B?djkzV2FndnVEZHlmbWhoRk9OdS9xYWptV1dtczgybVJsbFFKbDVsVUN6U0E3?=
 =?utf-8?B?anhrUzBNOVVoVld5aVVWL3dhc3JTblc5eFpidnNtSXJ2My9PRVpoMEFvOGp5?=
 =?utf-8?B?YnYzWEpEcktLZzAvODdxRWY5L3ByZTRRM2RlRnNtRE12OTVpRFFxSVVyekRD?=
 =?utf-8?B?UUZtSVd3dlAvNC9MeGJpTXB4Q2lpUmYzSHVMQm1FVGFxTjFhbGtyQ0hWbGlZ?=
 =?utf-8?B?N2xKb2NSbjJtazFnRGE3SWVXcWlmcmtOdEhvTm9zUkMyRlBsNWtNOVhuc2hi?=
 =?utf-8?Q?w93GEUv0HykDz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEt3Z1pJK2tUdjh6YUIzaEVOY0J6N2E1bnh1aGtlRHZmNjR5d1dXMmRsUUZy?=
 =?utf-8?B?RUlyUUNYRDQvSFVLa1dqRVhjLzQ0NUl1Mmxld0ZnYWFTTXdWRTVpVVBROUZ6?=
 =?utf-8?B?VjBIVmlPWmIrZFR5WkVuTkJlZjZEMnd1MllJN2R5NU1BV0JnMG4xc1cyTEQ3?=
 =?utf-8?B?STl5Y2xHbUFMR2FpQ0lacys5bXV5eW15V3JpVTBNeFBPTGxldzZTczdVcnpL?=
 =?utf-8?B?TWhJbGVPa0E3aGx3Ry9KMitGdWtIZFpualNmTVpHYUFLMEd2aFk0S0hGcXJJ?=
 =?utf-8?B?TG5ldzVUSDFPM3NKWHptdVZxNndCOUZrdGk3MkNBdjRYQ1Vqc1FMVGhhRWkz?=
 =?utf-8?B?Z01tanJmVjZ1Yi92bUozTlNSQ28vZW5Id2dwKzlkYUdVRUFReElkRjkrWkp4?=
 =?utf-8?B?V2U3QTUrK1FrcEg1Wm1Well1RE1wQTVXZXhmV0N5bEgyZ2dEdFVXMFhXMk5p?=
 =?utf-8?B?eGUrTkV5U0RZSWhlWSs4ZkJoYzNnZlkwYURXdGZSMkRVaTV6WExXUFJzL2Ji?=
 =?utf-8?B?dDdSdG5iaFlEZjFBWVVSb0M1cXpjZ2FXbHpGSlR3RUpock84V2JBbXB0ZDQv?=
 =?utf-8?B?Z0tTbkVzRmxrVTdSRUtYQzFmMmozdzExNVJINWhLTEVnem1QY01iTWFaNEJH?=
 =?utf-8?B?MUdlRjRPQXZFcmFvTW5pamVjb3J6VVVQblMvUXdvRTJwMXI2bXRlYTlheVJm?=
 =?utf-8?B?RFFnS243dFBIcitVTGtFVjROSjFhN3NMN2lzQlFkN09wV2l5MVQ5cWtuOU1i?=
 =?utf-8?B?TTFOblZYY2RyRFU0MFFxYkl0QjJhZTVYbG1GNWdqb1RNOUErcUZ4OHRMa1pu?=
 =?utf-8?B?OStNcUVEWFBCTnlZc1hVTzdXM3dyeGJUUUpEbEl3MUdWUURYNmRHN0ZKdEZQ?=
 =?utf-8?B?cGxwZjlPcTUxNW55UWdjLzBwTWJTL1RHZDRYSFBOL0dNQlYvemE0UTNZNlly?=
 =?utf-8?B?K3ZUMzdBV2R1RUk3ZEdDcHFhK3hwMUw0S0dKU2twQ253TXQyd2xDTytGYUhw?=
 =?utf-8?B?cW5aUE4zS0JiY3JXbCtKb0orNGFSUkp1UW1ManoxTDMrYmxBUEJDaEJTcWZL?=
 =?utf-8?B?SnJxcWZnWnREdUxXUjBsVXBEUHVlTWdtTjdPTER4RFZOQW1IbURUb2VGOHM2?=
 =?utf-8?B?U3VHeDJXN21YbTZmclhpUExMWU5FUXR5RE4wNkxPekw3bVYzWUhFQm1TTStj?=
 =?utf-8?B?NmVXS1ZxY2lITzZPS3BmL2ZLc2p3NFJubStQMDcxcVIyc2cxMEdGWTJ5Y25T?=
 =?utf-8?B?THlqWVRacnN0YkRlSDZuSm54MUVGbG1oY3QzQi9hVUNuUmtLTmFWd0F1OHA0?=
 =?utf-8?B?SWxLNm41d0FVTk5tTWF1VEVYcXBja2ZLRnN0Q0NOS0RtZ1pJTUNrb0VwYlE5?=
 =?utf-8?B?Wm5pUXVoRmdXSkZaRXdZN1pUSlp1Y3FDNzhlYkJhYVd0L1YzYlZBTU9QWjB5?=
 =?utf-8?B?YjJFK09CUmhVa1JIY25sL3JqOVBGeTNYS1V4bGFPVlJWaCtkNTFnSXMrM1ZR?=
 =?utf-8?B?R1o5NThLcURzbU5BRTRZRktTdmNUWWRpcHFabVFKOURsRERWTnNJVXdVU0hy?=
 =?utf-8?B?K3R0YVV5dHZXRjYyeHpxakZodlNLNVF0YnZEMUpUM1FLYUluY2kveFU5V2dI?=
 =?utf-8?B?VERkMVhCMm52WXQxYzR4N2V6VHdhK2xIZFBkTFBVdXRBWFdqWFdLVXlCbTVX?=
 =?utf-8?B?OWhHa0dSUDhaL3pUeEdsZFRvUDVNdWR0YXVxTzg0VTNuM2tKSzU5bks0cXF2?=
 =?utf-8?B?aU1kVUJiczVDZHErTVVxV25OejhULzRpcHdxemg5TzZuUldSUjExQk5qUzBH?=
 =?utf-8?B?L1BuV3RLenA0b25RMGd3Nk1MaGZBa2UvbFUva2hwKzhyb011VFRmbk54dklV?=
 =?utf-8?B?Z21VOEpWbktyMnVsSkl1ZE16TlBaOTV3Y1d3eTNSTnIwNHIxWGRPbkNqbjZt?=
 =?utf-8?B?UDRsOEFaZk5hOHFOZWFFN09hNEhMVWNuQXo5VjdubTZXZ0VXa1BzbHNHMEFW?=
 =?utf-8?B?SEZ5L1FKbk8vWWJIVWw4c0w3bE9OMHdmL0FmclNKdjgzc1lSOG5LYnpKbEcv?=
 =?utf-8?B?ZHZKSXlyaGZVUTJpRHZqZjFKQmtXNWFtWDlVNDUybEh5SEJZT1kyVUl3VmN6?=
 =?utf-8?Q?EKCbi4/nK0KMrSstQBvghnzH5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff8c4ae-1213-4ad4-9cd5-08dcbaa00ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 07:26:18.2744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gy5usmdyQUYcJwls8v8tUG2qowBYD1vnwBz0sS+jcK0chAfUeL0ikb5i2sd3EVC3Jmkf/sJpqKtrrk8+bAQBIupDoZMnpBOFvNwb/HNtefU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5405

PiBTdWJqZWN0OiBSRTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcw
MCBjbG9jayBiaW5kaW5ncw0KPiANCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQtYmlu
ZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcwMCBjbG9jaw0KPiA+IGJpbmRpbmdzDQo+ID4NCj4gPiBP
biAwOS8wOC8yMDI0IDA3OjQ3LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gPj4gU3ViamVjdDogUmU6
IFtQQVRDSCAzLzRdIGR0LWJpbmRpbmdzOiBjbG9jazogQWRkIEFTVDI3MDAgY2xvY2sNCj4gPiA+
PiBiaW5kaW5ncw0KPiA+ID4+DQo+ID4gPj4gTGUgMDgvMDgvMjAyNCDDoCAwOTo1OSwgUnlhbiBD
aGVuIGEgw6ljcml0IDoNCj4gPiA+Pj4gQWRkIGR0IGJpbmRpbmdzIGZvciBBU1QyNzAwIGNsb2Nr
IGNvbnRyb2xsZXINCj4gPiA+Pj4NCj4gPiA+Pj4gU2lnbmVkLW9mZi1ieTogUnlhbiBDaGVuIDxy
eWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gPj4+IC0tLQ0KPiA+ID4+PiAgIC4uLi9kdC1i
aW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0MjcwMC1jbGsuaCAgICB8IDE3NQ0KPiA+ID4+ICsrKysr
KysrKysrKysrKysrKw0KPiA+ID4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNzUgaW5zZXJ0aW9ucygr
KQ0KPiA+ID4+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4+PiBpbmNsdWRlL2R0LWJpbmRp
bmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAwLWNsay5oDQo+ID4gPj4+DQo+ID4gPj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAwLWNsay5oDQo+ID4g
Pj4+IGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0MjcwMC1jbGsuaA0KPiA+
ID4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmZh
Y2Y3MjM1MmMzZQ0KPiA+ID4+PiAtLS0gL2Rldi9udWxsDQo+ID4gPj4+ICsrKyBiL2luY2x1ZGUv
ZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLGFzdDI3MDAtY2xrLmgNCj4gPiA+Pj4gQEAgLTAsMCAr
MSwxNzUgQEANCj4gPiA+Pj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1v
bmx5IE9SIEJTRC0yLUNsYXVzZSkgKi8NCj4gPiA+Pj4gKy8qDQo+ID4gPj4+ICsgKiBEZXZpY2Ug
VHJlZSBiaW5kaW5nIGNvbnN0YW50cyBmb3IgQVNUMjcwMCBjbG9jayBjb250cm9sbGVyLg0KPiA+
ID4+PiArICoNCj4gPiA+Pj4gKyAqIENvcHlyaWdodCAoYykgMjAyNCBBc3BlZWQgVGVjaG5vbG9n
eSBJbmMuDQo+ID4gPj4+ICsgKi8NCj4gPiA+Pj4gKw0KPiA+ID4+PiArI2lmbmRlZiBfX0RUX0JJ
TkRJTkdTX0NMT0NLX0FTVDI3MDBfSCAjZGVmaW5lDQo+ID4gPj4+ICtfX0RUX0JJTkRJTkdTX0NM
T0NLX0FTVDI3MDBfSA0KPiA+ID4+PiArDQo+ID4gPj4+ICsvKiBTT0MwIGNsay1nYXRlICovDQo+
ID4gPj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfTUNMSyAoMCkNCj4gPiA+Pj4gKyNkZWZpbmUg
U0NVMF9DTEtfR0FURV9FQ0xLICgxKQ0KPiA+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFXzJE
Q0xLICAgICAgICAoMikNCj4gPiA+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9WQ0xLICgzKQ0K
PiA+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0JDTEsgKDQpDQo+ID4gPj4+ICsjZGVmaW5l
IFNDVTBfQ0xLX0dBVEVfVkdBMENMSyAgICAgICg1KQ0KPiA+ID4+PiArI2RlZmluZSBTQ1UwX0NM
S19HQVRFX1JFRkNMSyAgICAgICAoNikNCj4gPiA+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9Q
T1JUQlVTQjJDTEsgKDcpICNkZWZpbmUNCj4gPiBTQ1UwX0NMS19HQVRFX1JTVjgNCj4gPiA+Pj4g
Kyg4KQ0KPiA+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1VIQ0lDTEsgICAgICAoOSkNCj4g
PiA+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9WR0ExQ0xLICAgICAgKDEwKQ0KPiA+ID4+PiAr
I2RlZmluZSBTQ1UwX0NMS19HQVRFX0REUlBIWUNMSyAgICAoMTEpDQo+ID4gPj4+ICsjZGVmaW5l
IFNDVTBfQ0xLX0dBVEVfRTJNMENMSyAgICAgICgxMikNCj4gPiA+Pj4gKyNkZWZpbmUgU0NVMF9D
TEtfR0FURV9IQUNDTEsgICAgICAgKDEzKQ0KPiA+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRF
X1BPUlRBVVNCMkNMSyAoMTQpDQo+ID4gPj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfVUFSVDRD
TEsgICAgICgxNSkNCj4gPiA+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9TTElDTEsgICAgICAg
KDE2KQ0KPiA+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0RBQ0NMSyAgICAgICAoMTcpDQo+
ID4gPj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfRFAgICAoMTgpDQo+ID4gPj4+ICsjZGVmaW5l
IFNDVTBfQ0xLX0dBVEVfRTJNMUNMSyAgICAgICgxOSkNCj4gPiA+Pj4gKyNkZWZpbmUgU0NVMF9D
TEtfR0FURV9DUlQwQ0xLICAgICAgKDIwKQ0KPiA+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRF
X0NSVDFDTEsgICAgICAoMjEpDQo+ID4gPj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfVkxDTEsg
ICAgICAgICgyMikNCj4gPiA+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9FQ0RTQUNMSyAgICAg
KDIzKQ0KPiA+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JTQUNMSyAgICAgICAoMjQpDQo+
ID4gPj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfUlZBUzBDTEsgICAgICgyNSkNCj4gPiA+Pj4g
KyNkZWZpbmUgU0NVMF9DTEtfR0FURV9VRlNDTEsgICAgICAgKDI2KQ0KPiA+ID4+PiArI2RlZmlu
ZSBTQ1UwX0NMS19HQVRFX0VNTUNDTEsgICAgICAoMjcpDQo+ID4gPj4+ICsjZGVmaW5lIFNDVTBf
Q0xLX0dBVEVfUlZBUzFDTEsgICAgICgyOCkNCj4gPiA+Pj4gKy8qIHJlc2VydmVkIDI5IH4gMzEq
Lw0KPiA+DQo+ID4gTm8sIHlvdSBjYW5ub3QgcmVzZXJ2ZSBJRHMuIFRoZXkgYXJlIGFsd2F5cyBj
b250aW5vdXMuDQo+IEkgdGhpbmsgZm9yIG1pcy11bmRlcnN0b29kLg0KPiBJIHdpbGwgcmVtb3Zl
IHRoZSBjb21tZW50Lg0KPiBBbmQga2VlcCBpdCBpcyBjb250aW51b3VzLiBUaGFua3MuDQo+ID4N
Cj4gPiA+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9OVU0gIChTQ1UwX0NMS19HQVRFX1JWQVMx
Q0xLICsgMSkNCj4gPg0KPiA+IE5vLCBub3QgYSBiaW5kaW5nLg0KPiANCkkgd2lsbCBtb2RpZnkg
YnkgZm9sbG93aW5nLg0KDQojZGVmaW5lIFNDVTBfQ0xLX0dBVEVfUlZBUzFDTEsgICgyOCkNCiNk
ZWZpbmUgU0NVMF9DTEtfR0FURV9OVU0gICAgICAgKFNDVTBfQ0xLX0dBVEVfUlZBUzFDTEsgKyAx
KSANCj4gDQo+ID4NCj4gPiA+Pj4gKw0KPiA+ID4+PiArLyogU09DMCBjbGsgKi8NCj4gPiA+Pj4g
KyNkZWZpbmUgU0NVMF9DTEtJTiAgICAgICAgIChTQ1UwX0NMS19HQVRFX05VTSArIDApDQo+ID4g
Pj4NCj4gPiA+PiBTbyBTQ1UwX0NMS0lOIGlzIDI4KzErMCA9IDI5IHdoaWNoIGlzIHNhaWQgdG8g
YmUgcmVzZXJ2ZWQgaW4gdGhlDQo+ID4gPj4gY29tbWVudCBhYm92ZS4NCj4gPiA+DQo+ID4gPiBB
Y3V0ZWx5LCBJIGtlZXAgcmVzZXJ2ZWQgaXMgYmVjYXVzZSBkYXRhIHNoZWV0IGhhcyByZXNlcnZl
ZCBiaXRzIGZyb20NCj4gMjl+MzEuDQo+ID4gPiBJZiB5b3UgaGF2ZSBjb25jZXJuIGFib3V0IGl0
LCBJIGNhbiByZW1vdmUgdGhlIGNvbW1lbnQuDQo+ID4gPiBPciBhcmUgeW91IHByZWZlciBieSBm
b2xsb3dpbmc/DQo+ID4gPiAjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfUkVTRVJWRUQyOSAgICAgICAg
KDI5KQ0KPiA+ID4gI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JFU0VSVkVEMzAgICAgICAgICgzMCkN
Cj4gPiA+ICNkZWZpbmUgU0NVMF9DTEtfR0FURV9SRVNFUlZFRDMxICAgICAgICAoMzEpDQo+ID4g
PiAjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfTlVNICAgICAgIChTQ1UwX0NMS19HQVRFX1JFU0VSVkVE
MzEgKw0KPiAxKQ0KPiA+ID4NCj4gPiA+Pg0KPiA+ID4+PiArI2RlZmluZSBTQ1UwX0NMS18yNE0g
ICAgICAgICAgICAgICAoU0NVMF9DTEtfR0FURV9OVU0gKw0KPiAxKQ0KPiA+ID4+PiArI2RlZmlu
ZSBTQ1UwX0NMS18xOTJNICAgICAgICAgICAgICAoU0NVMF9DTEtfR0FURV9OVU0gKw0KPiAyKQ0K
PiA+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19VQVJUICAgICAgICAgICAgICAoU0NVMF9DTEtfR0FU
RV9OVU0gKw0KPiAzKQ0KPiA+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19QU1AgICAgICAgICAgICAg
ICAoU0NVMF9DTEtfR0FURV9OVU0gKyA0KQ0KPiA+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19IUExM
ICAgICAgICAgICAgICAoU0NVMF9DTEtfR0FURV9OVU0gKyA1KQ0KPiA+ID4+DQo+ID4gPj4gLi4u
DQo+ID4gPg0KPiA+ID4gKioqKioqKioqKioqKiBFbWFpbCBDb25maWRlbnRpYWxpdHkgTm90aWNl
ICoqKioqKioqKioqKioqKioqKioqDQo+ID4gPiDlhY3osqzogbLmmI46DQo+ID4gPiDmnKzkv6Hk
u7Yo5oiW5YW26ZmE5Lu2KeWPr+iDveWMheWQq+apn+Wvhuizh+ioiu+8jOS4puWPl+azleW+i+S/
neitt+OAguWmgiDlj7Dnq6/pnZ7mjIflrpoNCj4gPiDkuYvmlLbku7bogIXvvIzoq4vku6Xpm7vl
rZDpg7Xku7bpgJrnn6XmnKzpm7vlrZDpg7Xku7bkuYvnmbzpgIHogIUsIOS4puiri+eri+WNs+WI
qumZpOacrOmbuw0KPiDlrZANCj4gPiDpg7Xku7blj4rlhbbpmYTku7blkozpirfmr4DmiYDmnIno
pIfljbDku7bjgILorJ3orJ3mgqjnmoTlkIjkvZwhDQo+ID4gPg0KPiA+ID4gRElTQ0xBSU1FUjoN
Cj4gPiA+IFRoaXMgbWVzc2FnZSAoYW5kIGFueSBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gbGVn
YWxseSBwcml2aWxlZ2VkDQo+ID4gPiBhbmQvb3INCj4gPiBvdGhlciBjb25maWRlbnRpYWwgaW5m
b3JtYXRpb24uIElmIHlvdSBoYXZlIHJlY2VpdmVkIGl0IGluIGVycm9yLA0KPiA+IHBsZWFzZSBu
b3RpZnkgdGhlIHNlbmRlciBieSByZXBseSBlLW1haWwgYW5kIGltbWVkaWF0ZWx5IGRlbGV0ZSB0
aGUNCj4gPiBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyB3aXRob3V0IGNvcHlpbmcgb3IgZGlz
Y2xvc2luZyB0aGUgY29udGVudHMuDQo+IFRoYW5rIHlvdS4NCj4gPg0KPiA+IE1heWJlIEkgYW0g
dGhlIGludGVuZGVkIHJlY2lwaWVudCBvZiB5b3VyIG1lc3NhZ2UsIG1heWJlIG5vdC4gSSBkb24n
dA0KPiA+IHdhbnQgdG8gaGF2ZSBhbnkgbGVnYWwgcXVlc3Rpb25zIHJlZ2FyZGluZyB1cHN0cmVh
bSwgcHVibGljDQo+ID4gY29sbGFib3JhdGlvbiwgdGh1cyBwcm9iYWJseSBJIHNob3VsZCBqdXN0
IHJlbW92ZSB5b3VyIG1lc3NhZ2VzLg0KPiA+DQo+ID4gUGxlYXNlIHRhbGsgd2l0aCB5b3VyIElU
IHRoYXQgc3VjaCBkaXNjbGFpbWVycyBpbiBvcGVuLXNvdXJjZSBhcmUgbm90DQo+ID4gZGVzaXJl
ZCAoYW5kIG1heWJlIGV2ZW4gaGFybWZ1bCkuDQo+ID4gSWYgeW91IGRvIG5vdCB1bmRlcnN0YW5k
IHdoeSwgcGxlYXNlIGFsc28gc2VlOg0KPiA+IGh0dHBzOi8vd3d3LnlvdXR1YmUuY29tL2xpdmUv
Zk1lSDd3cU93WEE/c2k9R1k3aWdmYmRhNnZualhsSiZ0PTgzNQ0KPiA+DQo+ID4gSWYgeW91IG5l
ZWQgdG8gZ28gYXJvdW5kIGNvbXBhbnkgU01UUCBzZXJ2ZXIsIHRoZW4gY29uc2lkZXIgdXNpbmcg
YjQNCj4gPiB3ZWItcmVsYXk6IGh0dHBzOi8vYjQuZG9jcy5rZXJuZWwub3JnL2VuL2xhdGVzdC9j
b250cmlidXRvci9zZW5kLmh0bWwNCj4gPg0KPiA+IFBsZWFzZSBiZSBpbmZvcm1lZCB0aGF0IGJ5
IHJlc3BvbmRpbmcgdG8gdGhpcyBlbWFpbCB5b3UgYWdyZWUgdGhhdCBhbGwNCj4gPiBjb21tdW5p
Y2F0aW9ucyBmcm9tIHlvdSBhbmQvb3IgeW91ciBjb21wYW55IGlzIG1hZGUgcHVibGljLiBJbiBv
dGhlcg0KPiA+IHdvcmRzLCBhbGwgbWVzc2FnZXMgb3JpZ2luYXRpbmcgZnJvbSB5b3UgYW5kL29y
IHlvdXIgY29tcGFueSB3aWxsIGJlIG1hZGUNCj4gcHVibGljLg0KPiA+DQo+ID4gQmVzdCByZWdh
cmRzLA0KPiA+IEtyenlzenRvZg0KPiANCj4gKioqKioqKioqKioqKiBFbWFpbCBDb25maWRlbnRp
YWxpdHkgTm90aWNlICoqKioqKioqKioqKioqKioqKioqDQo+IOWFjeiyrOiBsuaYjjoNCj4g5pys
5L+h5Lu2KOaIluWFtumZhOS7tinlj6/og73ljIXlkKvmqZ/lr4bos4foqIrvvIzkuKblj5fms5Xl
vovkv53orbfjgILlpoIg5Y+w56uv6Z2e5oyH5a6a5LmLDQo+IOaUtuS7tuiAhe+8jOiri+S7pemb
u+WtkOmDteS7tumAmuefpeacrOmbu+WtkOmDteS7tuS5i+eZvOmAgeiAhSwg5Lim6KuL56uL5Y2z
5Yiq6Zmk5pys6Zu75a2Q6YO1DQo+IOS7tuWPiuWFtumZhOS7tuWSjOmKt+avgOaJgOacieikh+WN
sOS7tuOAguisneisneaCqOeahOWQiOS9nCENCj4gDQo+IERJU0NMQUlNRVI6DQo+IFRoaXMgbWVz
c2FnZSAoYW5kIGFueSBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gbGVnYWxseSBwcml2aWxlZ2Vk
IGFuZC9vcg0KPiBvdGhlciBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIHlvdSBoYXZlIHJl
Y2VpdmVkIGl0IGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZQ0KPiBzZW5kZXIgYnkgcmVwbHkg
ZS1tYWlsIGFuZCBpbW1lZGlhdGVseSBkZWxldGUgdGhlIGUtbWFpbCBhbmQgYW55DQo+IGF0dGFj
aG1lbnRzIHdpdGhvdXQgY29weWluZyBvciBkaXNjbG9zaW5nIHRoZSBjb250ZW50cy4gVGhhbmsg
eW91Lg0K

