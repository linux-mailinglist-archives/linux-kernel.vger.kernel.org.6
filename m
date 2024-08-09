Return-Path: <linux-kernel+bounces-280389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C276D94C9EB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4691F1F227A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F4F16C863;
	Fri,  9 Aug 2024 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="LDqn2CEd"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2097.outbound.protection.outlook.com [40.107.255.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C34A2905;
	Fri,  9 Aug 2024 05:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723182944; cv=fail; b=IAFkD/Q+4m4oamRLTDI9XaSiHkeSeuMIxnTotQPX4gEPDUwSPDof324qTKYUaUmUUldgLqwfL3SkKOcoBkasmtiHDy2uWuBNaQQhgc4rRT9zBTx4O2EqkSxKaJGxg4073VcVUykAoq+449ksRRuJrAjBAt3sqk8VRJmTJXBG4C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723182944; c=relaxed/simple;
	bh=A9SLhcjDLk/ib0MhRWnsHj67pqPY9IR+BEMLuvyvJsw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K9tKkk4PXJWmMlinKWpbi7aKLQorJlqdCssTTbRmy+UQNp/6xS/xJESvZn0WDqNKDcZyO0gQM9vK/lxxPu2t9yxnBg5ibQV3sttrELATa9L97LAKwbNrVIu0mYwsU3w3aJI0hkvUbJ0WeFm1ITKvI0B/U01/4hU6P+e/ZBtKtwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=LDqn2CEd; arc=fail smtp.client-ip=40.107.255.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jso/TwaXp34LqBwyS23c5SAv7TLe0gwBKd9eA6rqzISBBO/YEch0dcTTp/gs8hepV5vsBPN6mAvyuaEhSm+kyhNQMKrr1eG5wSyh2dZRyKFrmCeAMRXhOn3j7MiAWIRsdbpsWBygy5foeLTZgcNTxKl+WScg858jVkYvX/1gcOv6LwcikXzUiBd9iVOfKHsDu1RzECDpKT70zFbETtChIm4E2Rs0DXiXj7cy6VL6XDEZEMzLgz2P+nw6oK21DXb2jPvuhvKh00ntZuFvIz090mTKQ0+QhDB0m+NyNRJ8o05mC+tYNoz0+RIthvKZ3CpCoftPZ9NXcXyMOcvk7QQERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9SLhcjDLk/ib0MhRWnsHj67pqPY9IR+BEMLuvyvJsw=;
 b=P48A54uSYhf5/NC2j41cQQOJmNxuKfVHJgzqy1yKW6anDOO+zrPt6t3GrOF0UQ313Q6RTBfDI9S+wuRTxIhluc+ZVsBWY99KiPKST5aKmmiGykX5F7oFFO5YsXyN5lhI4TH25FMAG57G+mqT60TdupFr/yW27sxCxajKagOzNujOHmgyJdCRVYdD2Pb3bUhLTXZ+UDjmYihnBCpAjSgxwgnRgAGsqQXy6249ApgeiYyTKjtda/N3Z+OLji1DEFCMJXi/QgS2raMqjka06Nm8znLydKFVfnnhwaxhaNvqwm0CRqcTEvyCx3PfcQ6TQh99xnOUuNigp5n7ib7V9Sm8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9SLhcjDLk/ib0MhRWnsHj67pqPY9IR+BEMLuvyvJsw=;
 b=LDqn2CEdk4wJqXKoiTWQIRzOsrQGLx2iJCSmz7WB5Z22QRE79wL6uG3oUALmAGO9uLzbGYXeQIM5rdLcZ4Tz9+9RXJWQUijqzOIUp0ONZ4wQqSs82UO/R1sY6NdDYdeRAF/mEmQ6hr9AA6MhqHFE922En+u7TqARRo+ZmerxEFZqIJNjYp/pKou253Je4pVf1Y1VQ5dcciVsLaqAGW9vRHlXpkDYu+Q1tpOEDcwgJUEX8h87n9WL9Ghx4qtvKJ51yoLlfVl952x1CrkEzYROB0EsmLIlevqqXllK1l/GI5SOOFIAogIap0i+p7ohGU/xkJhtuy23jA1qm0tR1uwmZA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEZPR06MB6495.apcprd06.prod.outlook.com (2603:1096:101:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 05:55:35 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 05:55:35 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Topic: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Index: AQHa6Wjwpmm6AqTUmky9VcIbkjW1JLIdJMiAgAFHtRA=
Date: Fri, 9 Aug 2024 05:55:35 +0000
Message-ID:
 <OS8PR06MB75416FAD2A1A16E7BE2D255DF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
 <2f27285e-6aa5-4e42-b361-224d8d164113@kernel.org>
In-Reply-To: <2f27285e-6aa5-4e42-b361-224d8d164113@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEZPR06MB6495:EE_
x-ms-office365-filtering-correlation-id: 28b189de-ce67-4285-21ff-08dcb837e332
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?akFGUzIvdGgydktWaFJQM1BJdGpsWWM2ZUZieFJiNW5GZzErMitSRlRCbFZJ?=
 =?utf-8?B?dVhBQ1lHVUtsSTd0MVFpd3haR3ZBbm5VZEJRcHgzUlV4QURQU3NwcUhKMDFR?=
 =?utf-8?B?YkZpTUZ4TEpOR1hVMmJTSHMvam9FTFptdExEZTlLQTAvc2tBOENvczlVdXdH?=
 =?utf-8?B?c3M5RXFaVkpFNXVyYnA5Tlg2VlpQbk5VRUFUaDRiRlhQb25xUDZxUWhVTTc1?=
 =?utf-8?B?ZXZqR2xRblMrdmpveFRqZ2JxcnUyczRNOTU5SHdGNm5QazY0OG9OYUJMQjN0?=
 =?utf-8?B?anlKVmxzK1QxYXJYNFN0ck1ZY2s5TTMvbUNkdDN5Y1lWZWVMcnVGYUxhZ2Z3?=
 =?utf-8?B?YW5NR1FOZUJvb3NXQ1dvV3BBRTBneWR6MjVjbnRnRVRFL0NjQ2RQVjVnT0w1?=
 =?utf-8?B?b1YyeVMxT0hEVmZZenVHRnlMMkNNUlVxZW53SDBLQWlzdDZFaUlQTy9GbnV6?=
 =?utf-8?B?dWppV1lkVUFibUJjZWdKMFVDNFhYZUNac0tzTk5rTCtscWVzd09qNzFVWDJT?=
 =?utf-8?B?c3lrNGx0ZDRiNnNuQ3IvMWl4blJRWWp3OW9pbjVTSnRKMS9QUkRzSi8vY05j?=
 =?utf-8?B?Q005SERzWUhIbXdqUHJ0NlRLWlhxdVYrbE1IYnZCbjM0OVgzVmJUYlJZOCtQ?=
 =?utf-8?B?TU1QQkp2WHkyQWdrNnlnOGJ6OFdZT1hnaUxONktGdnN3a1c4VmdhWkYvN2t5?=
 =?utf-8?B?Vlk5WldDNjFDU2RZS2JlZWJsTTh6SGNWTVQyWkRzVUxWdEV4MzRDeWhLVmlp?=
 =?utf-8?B?eTZVTmpWREtESDJ1MktLenA5dHB6R2JQQnlWenRXS1dOenZFbmZ4NG1EeTgw?=
 =?utf-8?B?cTNlYzVybTJPa1N3TWdUdFFQM21YSTh3WFhFWFA2SkJBWHF1ZHk4WWI2dG9s?=
 =?utf-8?B?enhFc3g1QUlIbWpia2Y1RkI1ekpJYXM2K3NhbHEwclVzbTg4R3M4eXZhaGRa?=
 =?utf-8?B?MFBhR1hRV0Jhc0IvRjBVd2RlSVB4UlZSNWlyUkYvMy9EdUE1V1I2RFpqUndI?=
 =?utf-8?B?bVRocHJ2MXdVZ080V1pSMkJ2WG0zKzJKd1d0aDZKbk94eWU0bHVSbkpseElD?=
 =?utf-8?B?dkt2bW5JL3ZXRHZQL0l6RlF1TzlrcjBRSDJGWWJtcVdMcnpaN1VYSlMxVXBO?=
 =?utf-8?B?M3ZCY3hSZldrZFFrRjRvS2RNeE5TNGVuZzk1YVZNZWU4RnZLeXV4WWdZT1Vp?=
 =?utf-8?B?UTBINmxPT3FCb0RuS1dPY3hva0MrYW85b3B4a2FER1FXTU9zTE1uNGtaSmNK?=
 =?utf-8?B?NFhvMXBzaWpFRlNaNlJpd3NUbFlkNXNpdGE3SzN3eEY3dzdnWHNqV3hMVERY?=
 =?utf-8?B?MU9Nd3FrTDRYMysyZnJ5R0FxV3BFNW0zUlNmUUo1cDZrelNLNDZuNjdHdlQ2?=
 =?utf-8?B?a1JRNlU5R3pxQ1JVbFFpelMxQnJ3N1MzdFA5ckZSOXBBaWkrV3dzRkIwOHdz?=
 =?utf-8?B?VlJjMGtwaXhLL2p2dkYwOXpSY3gxWHFQRVBpWHNkQTVBVFFEUUhEc1N4RUVR?=
 =?utf-8?B?TGZoUWVrTG9SUzZac2JGWG9PaUJIK25hTTVxbjJWWGlrMktGbmdMbU9Lcmtk?=
 =?utf-8?B?cWs5ZjJ1UW94clY2ODdlMlBkbjRKaWFCMm1CcmM0ZFBUVXdya0h6a0NyREg4?=
 =?utf-8?B?NzhZT0lPTHBWWkV5N2VldnBoUDBWdWhEYW4rU3BuU2tzRVFjNFV1blREbjhQ?=
 =?utf-8?B?MFFYUUh3bWRnNUlTSHcrWG9sZ2RjZ2pxOEFJTkUzbkpjTFNYaC96bDYyWlpz?=
 =?utf-8?B?VWtZaTFqa0VYVHVmb1hhMVp6Y0ZjNnRqdU01VDVlVDl5OXIyVnVnQVplREZN?=
 =?utf-8?B?ZUxFQzJkQnBDRWVkSGpBT2ZZWWJkbnFteWpLUnM1dE9MQ3dmTWx3Vi9PMzFL?=
 =?utf-8?B?NU45Q1FubzZPenNTZS9xUDQrZ2drMHJhK054eEZOdkp6d3IxSjR5VlM0azFI?=
 =?utf-8?Q?B53WaUE3Dik=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2Vhbkx1SWNrV0FUSXpDQTZMVm45VzJqdDloL3VEOWV4K1hmQ1RKVitYcHYr?=
 =?utf-8?B?UFVWbUtuNGNCcHQwVjZMd0xZTTR4SEl4blYvY1JOSm10TTRRa0RxSWNhR1Z5?=
 =?utf-8?B?SGVwMHFDcDFGN3lQcW8xbUdzbncyOVZqbXpDeGV1K2NSOTBNb2pVYjlrbmVB?=
 =?utf-8?B?NFg4dktCRU9lR1hWNlJBQ3Z6TDMyUkdZMVM2SHhiYTJCUk8xTjUvVitMcmlH?=
 =?utf-8?B?YVpHQ1ZIeVNxZWlMam5peGx3S1V6ZTNVWUZtUmYzc0VpbmowejBPOWRaNTJ6?=
 =?utf-8?B?NjFFSWdhK3JFM1ByaE5yeldlNktSS3p5RFJmL3puakV0RldIWHMvVDI3bjFv?=
 =?utf-8?B?cythcUozRkt4SHBCeThma1Bka3dXN3dHaE5ZTmFJdTA3OU8vNWxiL3o4VkFx?=
 =?utf-8?B?RWpFSFREOTVOaTFYdE9vQkw4eEpvdENqOUlDcC9Vem9rV2V6OStNdUN2MUQ2?=
 =?utf-8?B?bXQ2MkFMM3g0RU5VamJyMUZEUUNqSThTclhzVnMxVTNHdjlIS0pocXdiQ2lZ?=
 =?utf-8?B?WHpJOUJuSG5adEJXQkNXZUcxVGhsZGEwMHlmeU12UGtXcDMraW9NMWFKaEJP?=
 =?utf-8?B?OEZaY3BEWHBuTWdiWkJKZGZrVElhWlowTTRtUE1SYWtlL3FXVmhrNVo2cGNF?=
 =?utf-8?B?RlkwVU1idXVRcjN5cWlCbDkzMGM1UDhsc25DSE5wM3hLd1p4TzZ1NllLS3ky?=
 =?utf-8?B?Qk5kMllUNkZ2QVlIc3NiVVo3SEU1SHgzQUtLdi9lcjVob25nN2k4Y0hiRGJD?=
 =?utf-8?B?ZTZCbXBwekUvTHpIVmM0QzI5QVNCWnlsLzl6MGcxVy9wTzFvVlY4OG9BSlZs?=
 =?utf-8?B?SXkrMTFFZFlzcXRCeTFoWmhiZzdNek5IeUxJMVpOK2JpeHE3bndSc2RDbDFi?=
 =?utf-8?B?V0ZqOHY1N1NwaVBvZ1NBdWZudWRyajhCY2tuODlzWXVTMThoNkM2UXhwL1VT?=
 =?utf-8?B?OURING9mQ3FPVVozNFVYbHJ2RGpKbkVyV3hTOVJ2TG52cjZZRXhTNktrekRU?=
 =?utf-8?B?V1FkVjlBSGZyWFJENlJJRkVZWHdkeFRzT0gzY2c2WVYzNkZpUkk4T1cyVFJx?=
 =?utf-8?B?N0tEZVllQUVVUWdzWXcrYTIzSS9xb01CL0o1bkRtaHpycVNLbU5LTHJ5Z3Ra?=
 =?utf-8?B?MTZjWDI2S01tRVVQYXBTMjhyeUpocUVVOFEzeG83cjJXdnplakVZNzVtTWN5?=
 =?utf-8?B?ay9ZMXEyakd3dXZpVzZ2eVlKREtpcG94b3ZUN3Qyc3BDMzRpaVJMR2xnZ3Bp?=
 =?utf-8?B?RnZsS3FKa3VYTzljeVh5ckpvOFg1cTVtUDdKajFyY3B3WmFjVW03NnJlc2ZY?=
 =?utf-8?B?VXVtWDVxZXVlc0tQZG5UVUlLMFZ6dVZJaUQrNkJ5Q3hJOXJMRnAxZlZBMWwx?=
 =?utf-8?B?K2NGOUZvYXVlbmhpRDUwR0hndDArM1ovWU1CSzBFallnczVBWmdzN0xBRnFl?=
 =?utf-8?B?QjBDVU02b3c5TEc0NHkvbG9FOWdKVmJRNE53QWhxWXpGZ3U1RUl3YkU4Wjln?=
 =?utf-8?B?clBsREgvaE1sL1J5amx0ZlNWUk13TmlyRlc3b01najhYbVViVjAwVFFGc3Zj?=
 =?utf-8?B?Qi9nNTJaSlRqSU5pWFhRTDl2Qjh0cjRVa21UcFUybXZ0SVFXTkZSTTN5YnJ3?=
 =?utf-8?B?STZlRlVjWlB3M0NFWUltVUg4RFZ6QzR0SXdTbitUNzdDdG0rcTdJNThNVGs2?=
 =?utf-8?B?aHJ1VVNNczV0N3oxTjNHZUVvMk5WT1cvM0JEVElQL3hONjVnYUhKbGRtdlRU?=
 =?utf-8?B?dTVBVHA2MVpWMTc3YUpRT0VWRktrVDF3Q3puenZBOUhkKzJvWm1IUWlkMk1D?=
 =?utf-8?B?eUNRK1Z2Z2gzOTJSclBaWnkwWHBuSTd4MDQ0K0kwVkZFVVdjR05ITERrelZq?=
 =?utf-8?B?SmVWOFNZd3g4SUlIcFBYemVlR0gvREtqUE1vVFhsWGNzTlhrLzZCeWV2UWQx?=
 =?utf-8?B?R2tNamx1UCtIaTNzWWhGZFVjVEZ2ZXRNN2cvUXJ6MUJlSDFLQTZyQkJmS3FV?=
 =?utf-8?B?bUJhOGdrd05pUGFER004ODZTK1EyUkRrRDE0UTgyR1Q2dkdIbHlnalhKVG1J?=
 =?utf-8?B?cFpSVU51TG9lOHFQdG5nVlJTZ0tnRnVBdEczUEJGbFo2cGZGczNvUlN2R2dF?=
 =?utf-8?Q?RTQjZBGJh+v/pXLe0yfTlTugA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b189de-ce67-4285-21ff-08dcb837e332
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 05:55:35.3853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZRFQLeMlLYdClB4R7hOFGs+FcUIP7AwTv1FmNZjUt/Kc37TJ0v95il0rg82HoLC9SWeBz5vdGaFD2VoNUCVkHpjodYUFMsqZJbBmtL5Pt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6495

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVkOiBzdXBw
b3J0IGZvciBBU1QyNzAwDQo+DQo+IE9uIDA4LzA4LzIwMjQgMDk6NTksIFJ5YW4gQ2hlbiB3cm90
ZToNCj4gPiBBZGQgY29tcGF0aWJsZSBzdXBwb3J0IGZvciBBU1QyNzAwIGNsaywgcmVzZXQsIHBp
bmN0cmwsIHNpbGljb24taWQgYW5kDQo+ID4gZXhhbXBsZSBmb3IgQVNUMjcwMCBzY3UuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0MngwMC1zY3UueWFtbCAg
ICAgIHwgMzENCj4gKysrKysrKysrKysrKysrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjkg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXNwZWVkLGFzdDJ4MDAtc2N1
LnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXNwZWVk
LGFzdDJ4MDAtc2N1LnlhbWwNCj4gPiBpbmRleCA4NmVlNjljMGY0NWIuLmMwOTY1ZjA4YWU4YyAx
MDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2Fz
cGVlZCxhc3QyeDAwLXNjdS55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0MngwMC1zY3UueWFtbA0KPiA+IEBAIC0yMSw2ICsyMSw4
IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAtIGFzcGVlZCxhc3QyNDAwLXNjdQ0KPiA+
ICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjUwMC1zY3UNCj4gPiAgICAgICAgICAgIC0gYXNwZWVk
LGFzdDI2MDAtc2N1DQo+ID4gKyAgICAgICAgICAtIGFzcGVlZCxhc3QyNzAwLXNjdTANCj4gPiAr
ICAgICAgICAgIC0gYXNwZWVkLGFzdDI3MDAtc2N1MQ0KPg0KPiBXaGF0IGFyZSB0aGUgZGlmZmVy
ZW5jZXMgYmV0d2VlbiB0aGVzZSB0d28/DQoNClRoZSBuZXh0IFtQQVRDSCA0LzRdIGlzIHNjdSBk
cml2ZXIgdGhhdCBpbmNsdWRlIGFzdDI3MDAtc2N1MCBhbmQgYXN0MjcwMC1zY3UxDQpDTEtfT0Zf
REVDTEFSRV9EUklWRVIoYXN0MjcwMF9zb2MwLCAiYXNwZWVkLGFzdDI3MDAtc2N1MCIsIGFzdDI3
MDBfc29jMF9jbGtfaW5pdCk7DQpDTEtfT0ZfREVDTEFSRV9EUklWRVIoYXN0MjcwMF9zb2MxLCAi
YXNwZWVkLGFzdDI3MDAtc2N1MSIsIGFzdDI3MDBfc29jMV9jbGtfaW5pdCk7DQpTbyBJIGFkZCB0
aGVzZSB0d28uDQoNCj4NCj4gPiAgICAgICAgLSBjb25zdDogc3lzY29uDQo+ID4gICAgICAgIC0g
Y29uc3Q6IHNpbXBsZS1tZmQNCj4gPg0KPiA+IEBAIC0zMCwxMCArMzIsMTIgQEAgcHJvcGVydGll
czoNCj4gPiAgICByYW5nZXM6IHRydWUNCj4gPg0KPiA+ICAgICcjYWRkcmVzcy1jZWxscyc6DQo+
ID4gLSAgICBjb25zdDogMQ0KPiA+ICsgICAgbWluaW11bTogMQ0KPiA+ICsgICAgbWF4aW11bTog
Mg0KPiA+DQo+ID4gICAgJyNzaXplLWNlbGxzJzoNCj4gPiAtICAgIGNvbnN0OiAxDQo+ID4gKyAg
ICBtaW5pbXVtOiAxDQo+ID4gKyAgICBtYXhpbXVtOiAyDQo+ID4NCj4gPiAgICAnI2Nsb2NrLWNl
bGxzJzoNCj4gPiAgICAgIGNvbnN0OiAxDQo+ID4gQEAgLTU2LDYgKzYwLDggQEAgcGF0dGVyblBy
b3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAgIC0gYXNwZWVkLGFzdDI0MDAtcGluY3RybA0KPiA+
ICAgICAgICAgICAgICAtIGFzcGVlZCxhc3QyNTAwLXBpbmN0cmwNCj4gPiAgICAgICAgICAgICAg
LSBhc3BlZWQsYXN0MjYwMC1waW5jdHJsDQo+ID4gKyAgICAgICAgICAgIC0gYXNwZWVkLGFzdDI3
MDAtc29jMC1waW5jdHJsDQo+ID4gKyAgICAgICAgICAgIC0gYXNwZWVkLGFzdDI3MDAtc29jMS1w
aW5jdHJsDQo+ID4NCj4gPiAgICAgIHJlcXVpcmVkOg0KPiA+ICAgICAgICAtIGNvbXBhdGlibGUN
Cj4gPiBAQCAtNzYsNiArODIsNyBAQCBwYXR0ZXJuUHJvcGVydGllczoNCj4gPiAgICAgICAgICAg
ICAgICAtIGFzcGVlZCxhc3QyNDAwLXNpbGljb24taWQNCj4gPiAgICAgICAgICAgICAgICAtIGFz
cGVlZCxhc3QyNTAwLXNpbGljb24taWQNCj4gPiAgICAgICAgICAgICAgICAtIGFzcGVlZCxhc3Qy
NjAwLXNpbGljb24taWQNCj4gPiArICAgICAgICAgICAgICAtIGFzcGVlZCxhc3QyNzAwLXNpbGlj
b24taWQNCj4gPiAgICAgICAgICAgIC0gY29uc3Q6IGFzcGVlZCxzaWxpY29uLWlkDQo+ID4NCj4g
PiAgICAgICAgcmVnOg0KPiA+IEBAIC0xMTUsNCArMTIyLDI0IEBAIGV4YW1wbGVzOg0KPiA+ICAg
ICAgICAgICAgICByZWcgPSA8MHg3YyAweDQ+LCA8MHgxNTAgMHg4PjsNCj4gPiAgICAgICAgICB9
Ow0KPiA+ICAgICAgfTsNCj4gPiArICAtIHwNCj4gPiArICAgIHNvYzAgew0KPiA+ICsgICAgICAg
ICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiA+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0K
Pg0KPiBUaGF0J3MgdGhlIHNhbWUgZXhhbXBsZSBhcyBwcmV2aW91cywgcmlnaHQ/IFRoZSBkcm9w
LCBubyBuZWVkLg0KDQpBU1QyNzAwIGlzIDY0Yml0cyBhZGRyZXNzIG1vZGUgcGxhdGZvcm0sIHRo
YXQgdGhlIHJlYXNvbi4NClNvIEkgYWRkIGV4YW1wbGUgZm9yIDY0Yml0cyBwbGF0Zm9ybSBkZXNj
cmlwdCBpbiBkdHNpDQpJIGhhdmUgdG8gYWRkIHNvYzAgdG8gYmUgYWRkcmVzcy1jZWxscyBhbmQg
c2l6ZS1jZWxscyB0byBiZSA8Mj4NClRoZW4gSSBjYW4gZGVmaW5lIHRoZSByZWdpc3RlciB0byBi
ZSA2NGJpdHMgYWRkcmVzcyBhbmQgc2l6ZS4NCj4NCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0
b2YNCg0KKioqKioqKioqKioqKiBFbWFpbCBDb25maWRlbnRpYWxpdHkgTm90aWNlICoqKioqKioq
KioqKioqKioqKioqDQrlhY3osqzogbLmmI46DQrmnKzkv6Hku7Yo5oiW5YW26ZmE5Lu2KeWPr+iD
veWMheWQq+apn+Wvhuizh+ioiu+8jOS4puWPl+azleW+i+S/neitt+OAguWmgiDlj7Dnq6/pnZ7m
jIflrprkuYvmlLbku7bogIXvvIzoq4vku6Xpm7vlrZDpg7Xku7bpgJrnn6XmnKzpm7vlrZDpg7Xk
u7bkuYvnmbzpgIHogIUsIOS4puiri+eri+WNs+WIqumZpOacrOmbu+WtkOmDteS7tuWPiuWFtumZ
hOS7tuWSjOmKt+avgOaJgOacieikh+WNsOS7tuOAguisneisneaCqOeahOWQiOS9nCENCg0KRElT
Q0xBSU1FUjoNClRoaXMgbWVzc2FnZSAoYW5kIGFueSBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4g
bGVnYWxseSBwcml2aWxlZ2VkIGFuZC9vciBvdGhlciBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24u
IElmIHlvdSBoYXZlIHJlY2VpdmVkIGl0IGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5k
ZXIgYnkgcmVwbHkgZS1tYWlsIGFuZCBpbW1lZGlhdGVseSBkZWxldGUgdGhlIGUtbWFpbCBhbmQg
YW55IGF0dGFjaG1lbnRzIHdpdGhvdXQgY29weWluZyBvciBkaXNjbG9zaW5nIHRoZSBjb250ZW50
cy4gVGhhbmsgeW91Lg0K

