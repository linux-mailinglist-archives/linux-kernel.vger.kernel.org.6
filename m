Return-Path: <linux-kernel+bounces-334041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BF597D1C6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1091C20F63
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B659C4D8BC;
	Fri, 20 Sep 2024 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="n6awACs7"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2138.outbound.protection.outlook.com [40.107.215.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2B40862;
	Fri, 20 Sep 2024 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726817594; cv=fail; b=NnSurG4BTT/t5aKsmJvl+7i6j59xLnJR//NoLCkdkSIZ336VBTzkP10zezlm+A4ZSyfVrNBNLFUYDGSgy8ur/KYDkHMbPQK6ll/MTAD2GILreUw6LISekRCiiPyo0JV2okXAJQUViym5rF/zYWGnNdzyFlJLs/PvbxCO+2za0Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726817594; c=relaxed/simple;
	bh=Ed7Wv6eM2hXWqY3LGZL6xK2TpPfOH1pZLKIeyjkdS9M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K9rAHEb8G8fDgBue2NQBMSeFrF0wa2VtOmyB0/ZaAyd6wVFT+r2l1RbRLnaAemZTwusVx87YtFuPsqngGpxBLjUgmXc7jGCIfsjcE68tOAHSvGepWahld8SeyrrJh2v/Vegt8jK3/KQVq7qk2hdJnpwy0YvPobwTjQ7ACCR/X/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=n6awACs7; arc=fail smtp.client-ip=40.107.215.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWHLfbkk2SHay7PjxThIk1uTxG533YEVnMCNJ0WLMnTcbA8BwFMG3l3c2BKy79RinUrZ56k2AuR8t8UShRiHJAI0ZlVvSaO72QPiapwee/TN7R9enL1LySwR00In4EIT1wVBiAxqw/m8WKfY+h4/Syy5dpsx2KGtAZS82gwFAj0Ln5vW6p7UjFU+uCNoiTmbsRW0mIDh0ykvoTNlvzQ4zZnRbLin6g+Lf+TsNtv+ggohiFejgq/Z0QGMnsKHyu2H5NPykRNGngd5nTJKIOBOSt0h6+tXn5wFm+DRqBa0QLEA10JXtlvS7e6M+9jfMAL9aacq9xqc6O0x/Dc4XvttXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ed7Wv6eM2hXWqY3LGZL6xK2TpPfOH1pZLKIeyjkdS9M=;
 b=Cjzs0+cMYcBd53K3Y3QJXRXjr7ELJIKDvAp0e6J1EdURq5ioDvhy0Us8m9/rlSeI0K7FSb9TXM63h1F9Iwau7IjdoYkGqhPe0+nVNHRY8Zx/xeBSCvDU6K3oHHHkizLyuMLPyY86t1SlAbhIds9az09CTRrD9dhZeAhJxgGPI9FJUmRsr2msFcNTgsYEKYIAXOef1Ngqk04p3k2LMpP+0uRaOen6xSS+SdAMqr7WndQ9XVoNqwNTvmZevhthilZWOjn8NCQjcc1hDM3SjT2yWGT8tRlrKWrWWR7iRkRUX0vciIoOyXrBIVFcQRk1BE+59gYBaL/aPq+Zo4SwsHq7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed7Wv6eM2hXWqY3LGZL6xK2TpPfOH1pZLKIeyjkdS9M=;
 b=n6awACs7GEret/dtVTKz35td6GfHvmYSrwvgNddcivQArxaIDVUsKBvqBtkR4Uxki2eUNhsWKzspooPB3100pnhUkEZ4olpuLpUwI7arieorlkMxBY2Intdevo9vY5bCRlz+yggyulpmbW7MNtr/Ei6HGU8Q/gYwtkyR1CksLvl6Fg1oawJ87zB4vgImKAm3z7YNV2XF0PXOQZFkE4ZfSSCsfHzjt94I4UBTb3iFTwnC6KD5Bdr9CtO7f0nC/jdvJkm7WOPbj0JA5UyXP1OV9EH9rpd3kd0MOavuM+AEjGP7NdSSEa3BpnAQ9b/GrF12VKRYvqEYG1ppznKkom6Qjw==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by KL1PR0601MB5447.apcprd06.prod.outlook.com (2603:1096:820:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Fri, 20 Sep
 2024 07:33:08 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%4]) with mapi id 15.20.7982.012; Fri, 20 Sep 2024
 07:33:08 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v3 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Topic: [PATCH v3 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Index:
 AQHbCBhSCltx7mVaxk6lgtgjWxjd+LJaMKkAgARx6aCAAA+HgIAAA4BggAA4qQCAAV+voA==
Date: Fri, 20 Sep 2024 07:33:07 +0000
Message-ID:
 <OS8PR06MB7541773C1DC1CCE8E4149E3AF26C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240916091039.3584505-1-ryan_chen@aspeedtech.com>
 <20240916091039.3584505-2-ryan_chen@aspeedtech.com>
 <9b356379-907c-4112-8e24-1810cfa40ef6@kernel.org>
 <OS8PR06MB75416C23247B7AC64260C0AFF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <f79a48e6-e0ff-453f-98c1-1c5acbe6467d@kernel.org>
 <OS8PR06MB7541FDB6A74119A160B1A57CF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <3185f620-28be-49b8-85f4-7ff8dd5ffce0@kernel.org>
In-Reply-To: <3185f620-28be-49b8-85f4-7ff8dd5ffce0@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|KL1PR0601MB5447:EE_
x-ms-office365-filtering-correlation-id: 1feb90b6-4076-4264-a8c9-08dcd94678fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?QW5kaWVNQXFGa3gvTmdkcnVOT3U0MDM5eFYxMTB6M054eEx2MGRIZzFWYnZn?=
 =?utf-8?B?QW9OeUhraTZoc2Q4WTh4TGhXWXovUjZjTmhqRjVMZDFFOHJhaUk4M1Y2cS9z?=
 =?utf-8?B?UjZlVTBLUnZyQXpqNDFoY2wxdWIwd1VNUnNhak5jbnJ5NkRCZUZjdXlXd2tk?=
 =?utf-8?B?Ri9rTkJpUENMOHp4VU54a0FhTkNvWHpYWWs4WjRDcUhiaC9MZXpCblVjYm9U?=
 =?utf-8?B?UXZVSkRUYUhFRktvcVpIakNFVHU4QlZYNWFwMWVSTE1oZVlNRE9WZDdyZThF?=
 =?utf-8?B?Rzd5NVpocmJoVUl4UzhvUzh5c2FQOG9VZ2QxNlV4QndlYldweUJRK25pcnFB?=
 =?utf-8?B?bVl5R1VZSkRXbW4wdmdPTzFQM0habm94ZFpNZ0RoWFZuaStybmlkenplUTBv?=
 =?utf-8?B?UHIwVXJBTnVaK1NaOU5HVHo3MHFuNDRPMytsMmxGSkoydVNQdnRPa1VpN2xo?=
 =?utf-8?B?R2lCdE96UXZtTTViWCtYMHo0QUV6S0hsNjJBWUFkZGgvR2t2RC91Ym9JYU5r?=
 =?utf-8?B?d1FDU2NJSzBpZytwUmxrTUdvRUo2d0ZlRUEyUUZ4YzhwQ2EvNUhmVHhBNjVZ?=
 =?utf-8?B?TGtxaUQxNnRBcW9UbWtkSmVnVTZjMTdqUHIxSEV5R0MxdDBvZGJ1ZGlzdFlW?=
 =?utf-8?B?VVVsajR4Q0JLTSthUjF2S1I4UHlCcjJCZzVCWmJ1WjlEQ3pyS0o5WCtDb0pN?=
 =?utf-8?B?RDdrWmlrZys4bWkrdGJTSVg5aFFndXhaRHQ4VzM1TVZhTjhvNjhFZ1pxdDRK?=
 =?utf-8?B?Qjh1MlVvQmNZVGt5MTYzOEU0Q2Z3d3RBQVZJamwrZzRZc245NFNGWUVWZVJj?=
 =?utf-8?B?ZXFrZXNlNFkyMWE1c1NmZXBjSHlvb1hoSXh6dUptekEydEVnSGt1bmFKZ1hk?=
 =?utf-8?B?N2dOME9IMWR2RnJMSk9mT2g3Y0dOV1pqaFZrUzBKalNaeFNtV1N2bUsxNGY2?=
 =?utf-8?B?YUNXc3N6RXB2cTBxWjF0SDZMQkhGUDc2eXBEWk12NENwcHhJSEh3dDE5a296?=
 =?utf-8?B?bVRzKzRENEI4SnFyWFloeFo2TkwrQm5acmdiTEtsRWtObTdrcTJPMWMrVFRv?=
 =?utf-8?B?TkNxcmJ1UkowTVZUd2Q2UTdCWnpOUmZDTVIyQ1hTUmprYmlqRlRFWVhIWTRw?=
 =?utf-8?B?Qkh2SEdMY0VOWEdDNmhqelU2NUVwT3dsV21UeTJxQ1FXVmtkdU1KZzZ0VmVG?=
 =?utf-8?B?YTlCMjFwNDNZLzVGZ3dXTXYzNEdIcVhhaTlxUXd2VDhuTjFxNFlqckdSbzl4?=
 =?utf-8?B?L2pFTFJDZVdadVFocjlnUkpieDhpTjYzSHRnT0E1YzAvVER5R1lsamNnUTFR?=
 =?utf-8?B?OTJ5akhlbWZwUkh1U3ZtQmtnVEVwUzJFM1RhSTJ1SmFKVXRsUU80VkQxVzIv?=
 =?utf-8?B?eWp6NU1ERkNmcUh3ZHBDTGUrcFhPWUZoY05lbGs0NmplVHdmNUlmakhuUEhv?=
 =?utf-8?B?U3ZYN3V3Z1pneHhlbzUwZlU0bnRuTFRjaStDWDJSeVlOTXBBYzJrb25ZcDc4?=
 =?utf-8?B?NVBrYUY2eWpURUdhamMzOC82KzBVYXhBeGNqYklKOU1iRVNhSndUK1dHK0ZS?=
 =?utf-8?B?OFdEOEowM0Z5YmJEeWN4ZWJrK3d4ejR4S0ZWRG9tb3B3YUFadDQ4b3JtNDVx?=
 =?utf-8?B?bm51ZW5IZUR3NUtSdzBpeDFvdmY5cTdBakgzeDdPT04xMmhwZkg3enRWaHMz?=
 =?utf-8?B?OXNQLzdtQkFvaGxMMm44V1Rxbkl5UExXVStxb3hIU3lBbXdWNGdHOXdvTkpV?=
 =?utf-8?B?L1RKQU5uT3hsZ2NzVjhCNkZTaUpmMEdxdnpZM1dhblg5Um56c29PQ085bmdF?=
 =?utf-8?B?Ym1PbmZKTksyYWxWcm9iZkVFalZNM1k0NjFJd1hac1E5S2E4OWFWVW9aWDhX?=
 =?utf-8?B?OFQxUThTbmhsL3NPclRVRWtSd2tHMHhWWVR5UG5BeUtVUHNEUlBDNVlERW9E?=
 =?utf-8?Q?SA2RAM5O8I4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dk53c0JLMC90dE9SZ2FtYnhGaEZ4ajZtbWVmVGNXdk9BYUxNeXpRYS9SNjVF?=
 =?utf-8?B?bS82Qm1DbGRSTVlmRUdZREtuRWpoL3Y2V1hHT3dxWHhTRWNDTHh4L2dPLzRs?=
 =?utf-8?B?NFM0UXdCeDJvWXR2allJWVc5ZTlKZWhsMk9aNlBXd2NEZ1JPY3JtRmpjSVUw?=
 =?utf-8?B?QWJXUThhZGlLSXVqR1pXWGZDZlBsSzFhMVBURUpFbWFTRVF5TXVwVm1Vd1cx?=
 =?utf-8?B?VTNvUnRyZUd1aXRJQ0JqRERTRlE2UnN6RExqQ2lzVlAyaXRGcDdGWW9LcitK?=
 =?utf-8?B?YmMvM1dkQ2paNzV0ZzUzOUVCL2NJSWdKMVkyV280TnVNMkU3RWdheHBpNzZ0?=
 =?utf-8?B?UEpNeVozdTJYeVp6bDVCd3pnTW9WcGNzazhqcDkyOVp1Q3lOOTlGaEhrZWcr?=
 =?utf-8?B?QStFbGtkSXZJYnNobGVGSm91Si9XVllwWDduQlhFYWlyYiszUTFIdHNTbXkx?=
 =?utf-8?B?M3dqRy9zUmxQZ0tzSmZJT2ZRRy8reTJkRllSTER1eHYrTUFKNW5CN29neGY2?=
 =?utf-8?B?UHFRSmZwbTIyckZ2SWpFcjBJOFJpaFJ6TzJ2Zm1WZUdiaGxPb0xNSWh6aEhG?=
 =?utf-8?B?c1E2TzU1cTVScVlPeExDdkFpbzZqVmIxdmNndHN4VmlzN0hRQyt3cGJkeTZk?=
 =?utf-8?B?WG9sQmJGenBoMUZSaEI0MlpLSVBKY2RBV1N3OHgrOCtqbHlZVGJ1ZCtOOTJB?=
 =?utf-8?B?aXhFL2FjM0lKOElERTNvdkVBYllTR0hzR1JFZ29EUUFOR1diRHo3SzY4eDAy?=
 =?utf-8?B?c2RzMlNkWFI3REQ5c21XWUNXWGJIdFN0dUJOaDI4RTdLSzVkcG1pdjhoZEZC?=
 =?utf-8?B?T3hBRGNLRHQzRUpWWkhkcGlyS3FGZG9CN1FtUUI1SzIzaGZMRVozZmlSOExO?=
 =?utf-8?B?L0hsZFdSS3FZa0ZoU09LcFROSHdEUGdzWEFPTmFtbmVYbEY4d0NkVFpIdWVW?=
 =?utf-8?B?SXJEak9Sa2YrYUtpTklqOWlkNnBESEI3NHhkelIvTm5JRUYxcjRLbFUzWnh3?=
 =?utf-8?B?eFhGQnprRENYWDBsN0NRcGwwM25sQnhPT1RNUVVTcm91aUZDREQ0QWNmTEMy?=
 =?utf-8?B?QWdXdEMza1o5MW4xZVkxY2RBbEFqUll1R2VXcjA3cG5yS2w1Qk8za3p3VmJD?=
 =?utf-8?B?clQ2a0RwR1N1eDBoMTNWazE4bWZLSlBtMmtTM3dIK0hvUmpKTDFCTEFjTXRE?=
 =?utf-8?B?ekhzTjBYaDhlSUZOOVN2Q25nRUxvUzl2UEFmdkFBMHdQM3FGT2t6UU9menF4?=
 =?utf-8?B?bEh2V3lnOXozNDNYZDNvYUlqbzhUREVMdlFTSGdEeElqMEJkVkJoWHkwa1Qv?=
 =?utf-8?B?YnJtYUd3bVlCWmpiVDFkT3VqUHNPYTJOMXVpZmtJT1hXbUl6cTFsVzlCUjA0?=
 =?utf-8?B?cFZxZ2NvNy9DMnhnczdmdFEzNFZGcXpwVXB3TWcvQWIxbW52Qjh6Y2ZjQ0Ey?=
 =?utf-8?B?NEdyU2RGSFJIVmJpbkZMTUg3S05GNlR3MG1zR25BSnZxUVJhME5ML0pZc21Q?=
 =?utf-8?B?NnlmT3M0M3FMakdLbG1wWHlIeUVxSis4Lzk1K2xtMUVHemROOSsxb2s1YmtC?=
 =?utf-8?B?OTlKck8rNlZRRE9IblhJQTZEUEY2ZHJPZDNUU2JuZ1ZtU1VoMVF0VkFDa1Ba?=
 =?utf-8?B?MTNsWkY0bUowOE1NWlNRUnhQaU1ZdHdlR093NjV6SkN6bUVGdE04ZWUveGlm?=
 =?utf-8?B?Y3UvdkFGNDMxZjhJczN6VnNsSjFmTWhnbDNmbzZseEpSRit0QjRFNHIwVDlT?=
 =?utf-8?B?Tk9rRWRFeFFXbDRIRStZcU9sNXpOSTYyT3kwa2xQRXROR1UxNTFka3JqQU9R?=
 =?utf-8?B?RjdKRWdHMm9WaTlVVjBnSG1jVzlxU25JbExBNnlMNUxpeHh3QTdVL2pZb0dX?=
 =?utf-8?B?Rk4wN3V6UjFXcmgxZ2xVR3dKOC9xRjBlRzdjZkVzU0JuTUNlYWVEUzl6NWov?=
 =?utf-8?B?Uk1SUkJlUGs3cDZib3I1MEkyK0RUR0RBV0k4SE5vYmFCYStBWlI3ZHJVaWo3?=
 =?utf-8?B?YzNaR1Y5YnFRZVE0M1J2OVZwa1NkWXAvcjh2RW1Fc1hZbEhyams5OFFKVGo3?=
 =?utf-8?B?dG1xKzBEK3RLZVhQdXdBQlJWRElVcGUyYzNON21kOHRnZElTQmlkNHJuaExi?=
 =?utf-8?Q?Ioz3eSV081P5J4z/VmB/hxoXd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1feb90b6-4076-4264-a8c9-08dcd94678fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 07:33:07.9996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +228gNkG5JsQfGenwbrsWeLYoC13921u1OL+wf+MwUv5biozhUzl9rPqRuAEHmrC81nJiGFFAQcRmyydtoOpeTjDwzlfPYzTvdLrkpfhf/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5447

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvNF0gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVkOiBz
dXBwb3J0IGZvciBBU1QyNzAwDQo+IA0KPiBPbiAxOS8wOS8yMDI0IDA5OjEzLCBSeWFuIENoZW4g
d3JvdGU6DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS80XSBkdC1iaW5kaW5nczogbWZk
OiBhc3BlZWQ6IHN1cHBvcnQgZm9yDQo+ID4+IEFTVDI3MDANCj4gPj4NCj4gPj4gT24gMTkvMDkv
MjAyNCAwODowNSwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+Pj4+PiBkaWZmIC0tZ2l0DQo+ID4+Pj4+
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0MngwMC1z
Y3UueWFtbA0KPiA+Pj4+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQv
YXNwZWVkLGFzdDJ4MDAtc2N1LnlhbWwNCj4gPj4+Pj4gaW5kZXggODZlZTY5YzBmNDViLi4xMjdh
MzU3MDUxY2QgMTAwNjQ0DQo+ID4+Pj4+IC0tLQ0KPiA+Pj4+PiBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tZmQvYXNwZWVkLGFzdDJ4MDAtc2N1LnlhbWwNCj4gPj4+Pj4gKysr
DQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0Mngw
MC1zY3UueWFtDQo+ID4+Pj4+ICsrKyBsDQo+ID4+Pj4+IEBAIC05LDYgKzksOCBAQCB0aXRsZTog
QXNwZWVkIFN5c3RlbSBDb250cm9sIFVuaXQNCj4gPj4+Pj4gIGRlc2NyaXB0aW9uOg0KPiA+Pj4+
PiAgICBUaGUgQXNwZWVkIFN5c3RlbSBDb250cm9sIFVuaXQgbWFuYWdlcyB0aGUgZ2xvYmFsIGJl
aGF2aW91ciBvZg0KPiA+Pj4+PiB0aGUNCj4gPj4+PiBTb0MsDQo+ID4+Pj4+ICAgIGNvbmZpZ3Vy
aW5nIGVsZW1lbnRzIHN1Y2ggYXMgY2xvY2tzLCBwaW5tdXgsIGFuZCByZXNldC4NCj4gPj4+Pj4g
KyAgSW4gQVNUMjcwMCBTT0Mgd2hpY2ggaGFzIHR3byBzb2MgY29ubmVjdGlvbiwgZWFjaCBzb2Mg
aGF2ZSBpdHMNCj4gPj4+Pj4gKyBvd24gc2N1ICByZWdpc3RlciBjb250cm9sLCBhc3QyNzAwLXNj
dTAgZm9yIHNvYzAsIGFzdDI3MDAtc2N1MQ0KPiA+Pj4+PiArIGZvcg0KPiA+PiBzb2MxLg0KPiA+
Pj4+Pg0KPiA+Pj4+PiAgbWFpbnRhaW5lcnM6DQo+ID4+Pj4+ICAgIC0gSm9lbCBTdGFubGV5IDxq
b2VsQGptcy5pZC5hdT4gQEAgLTIxLDYgKzIzLDggQEAgcHJvcGVydGllczoNCj4gPj4+Pj4gICAg
ICAgICAgICAtIGFzcGVlZCxhc3QyNDAwLXNjdQ0KPiA+Pj4+PiAgICAgICAgICAgIC0gYXNwZWVk
LGFzdDI1MDAtc2N1DQo+ID4+Pj4+ICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjYwMC1zY3UNCj4g
Pj4+Pj4gKyAgICAgICAgICAtIGFzcGVlZCxhc3QyNzAwLXNjdTANCj4gPj4+Pj4gKyAgICAgICAg
ICAtIGFzcGVlZCxhc3QyNzAwLXNjdTENCj4gPj4+Pj4gICAgICAgIC0gY29uc3Q6IHN5c2Nvbg0K
PiA+Pj4+PiAgICAgICAgLSBjb25zdDogc2ltcGxlLW1mZA0KPiA+Pj4+Pg0KPiA+Pj4+PiBAQCAt
MzAsMTAgKzM0LDEyIEBAIHByb3BlcnRpZXM6DQo+ID4+Pj4+ICAgIHJhbmdlczogdHJ1ZQ0KPiA+
Pj4+Pg0KPiA+Pj4+PiAgICAnI2FkZHJlc3MtY2VsbHMnOg0KPiA+Pj4+PiAtICAgIGNvbnN0OiAx
DQo+ID4+Pj4+ICsgICAgbWluaW11bTogMQ0KPiA+Pj4+PiArICAgIG1heGltdW06IDINCj4gPj4+
Pj4NCj4gPj4+Pj4gICAgJyNzaXplLWNlbGxzJzoNCj4gPj4+Pj4gLSAgICBjb25zdDogMQ0KPiA+
Pj4+PiArICAgIG1pbmltdW06IDENCj4gPj4+Pj4gKyAgICBtYXhpbXVtOiAyDQo+ID4+Pj4NCj4g
Pj4+PiBXaHkgZG8gdGhlIGNoaWxkcmVuIGhhdmUgNjQgYml0IGFkZHJlc3Npbmc/DQo+ID4+Pg0K
PiA+Pj4gQVNUMjcwMCBpcyA2NGJpdCBhZGRyZXNzLCBzbyBpdCBhbHNvLg0KPiA+Pg0KPiA+PiBC
dXQgd2h5IGRvIHRoZXkgbmVlZCBpdD8NCj4gPj4NCj4gPiBTb3JyeSwgSSBtYXkgbm90IHVuZGVy
c3RhbmQgeW91ciBwb2ludC4NCj4gDQo+IEkgYXNrZWQgd2h5IGRvIHlvdSB0aGluayBjaGlsZHJl
biByZXF1aXJlIDY0LWJpdCBhZGRyZXNzaW5nLCBpbnN0ZWFkIG9mIHdvcmtpbmcNCj4gd2l0aCBl
eGlzdGluZyAzMi1iaXQgYWRkcmVzcy4NCj4gDQo+ID4gU2luY2UgYWRkcmVzcy1jZWxsID0gPDI+
LCBEbyB5b3UgbWVhbiBzaXplLWNlbGwgc3RpbGwgMT8NCj4gDQo+IE5vLi4uIGFsdGhvdWdoIHRo
YXQncyBhbm90aGVyIHBvaW50LCBob3cgYnVnIGFkZHJlc3Mgc2l6ZSBpcyB0aGVyZT8gRm9yIHRo
ZQ0KPiBjaGlsZHJlbj8NCj4gDQo+ID4gSWYgeWVzLiBJIGRvIHRoZSBkdHMgY2hlY2sgaXQgbmVl
ZCBzaXplLWNlbGxzPTwyPiwgd2hlbiBJIGRvDQo+ID4gYWRkcmVzcy1jZWxscyA9IDwyPg0KPiAN
Cj4gV2VsbCwgSSB0YWxrIGFib3V0IGJ1cyBhbmQgY2hpbGRyZW4gYWRkcmVzc2luZy4gSXQncyBr
aW5kIG9mIG9idmlvdXMgdGhhdA0KPiBjaGFuZ2luZyBvbmUgcHJvcGVydHkgbWVhbnMgdXNpbmcg
ZGlmZmVyZW50IHJlZy4uLg0KPiANClVuZGVyc3Rvb2QgeW91ciBwb2ludCwgSSBkb27igJl0IHVz
ZSBzbyBtdWNoIGZvciBzaXplLCBzaXplLWNlbGwgPSA8MT4gaXMgZW5vdWdoLCB3aWxsIGtlZXAg
PDE+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

