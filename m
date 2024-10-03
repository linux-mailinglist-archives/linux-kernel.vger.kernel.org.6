Return-Path: <linux-kernel+bounces-348671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7BE98EA42
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E891C224EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5347B208A9;
	Thu,  3 Oct 2024 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ttCEgpP0"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010021.outbound.protection.outlook.com [52.101.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AAA78281;
	Thu,  3 Oct 2024 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939975; cv=fail; b=RKrpUJfi6WhraR3ppbSlfGyompRfrnHFnIJfiktUZfZe8rerqv4LT27C76DXHtR6YSCJ2IqBQIqmEW/cJiqZU2d9XZYaTiLfSqZl2HpYkTs9E+aTo+4WASMJavhytF5iRhmyxKxXA2kzdvqSzixAHDbXxEEg0A9eI5Fz2j5ZdGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939975; c=relaxed/simple;
	bh=24QKEH7UXu4pOJ0FwH4W77aRZu7JpTuov8RzTVNdyEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WYt3z4ztGVyVF/iXSGBMTBNhSebl5uU6PCviH0wUyF8YaaujuZ6No9q49LsP4fOYe9qFx73kOoBzG7dmufbbMeXb3fCONxJB2GkQ2Y+vMXyoIyFDCjmeuegrsMnMOAtGYHlHoDmOUon5hlTrsOqcAIvo8SQfAJWzuXFDLGIKQu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ttCEgpP0; arc=fail smtp.client-ip=52.101.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBilM2VVbVfZcNOlYPcda4mcquyYGMBK/cu7d2u1qU515PnuLMtcZ8sj7eYredCWJlK5J5T9QQh9CNC4rVXs9KiFxiZuK9LtZ4bk/R/JKSzJJl4Ny4We5AusqzARKAEB5b7xQJwfFmTAhzL/7yOZZcX8EXt21CUhue6fNbEdqyR4q2Fxh5ZZ+tEogeetqlrXNBpbPaHQDqch5mECsseIOcQmzlA9BIcbPifGxetZ73TyKYN4gheh3/klT7W+P+F8tGOOoZ0v7Wp92L/gkCkyHjIYRoEBm4RzFG4hVnoXFiFfVGXBSN5nvC4Rzxfq1TUaDE1elWAy8o1J54ja6EgBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24QKEH7UXu4pOJ0FwH4W77aRZu7JpTuov8RzTVNdyEg=;
 b=iuskEtbEqndSKb5KPri7UGwSf231X3sHNeOKV6Pkv5sAztxQPpdrm52cYZmRvWyu0TqKv8z7e0qL89vfGSyXcUW6HIMeBjUX+GdsV25MFjph5I9f4DHdEXb78A5CIi6EQgU6Ow6Z0EhlD67r5FWwBVOgCThwlbX26bn/ZZdQOdcCZyDQ4yijxcpz325uNIleFLsm5YwAPujkg9WBqiQUT8IIdrx99TNQJv8ljxWvOfU0AbJ2RqsIPHTp1ixQfdsGNB7pbJUiy9oN7A9ZxizTZvUbBrsWQwwxrVCRxMTreEuKElAPPLogH2hxySdfPOhuGr+Ua7+RxvtLtbMBlxVF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24QKEH7UXu4pOJ0FwH4W77aRZu7JpTuov8RzTVNdyEg=;
 b=ttCEgpP0ymsnnZNWZgvX0Yp5YoO/Y/QUDcrei5Byg4ff7ddwxPHGUsIARWicx2/es4M11hP7qjsir1va8TiAGwLzcHGqOELzCbzkKQvS9by9cXyuqJ3IocZwgz8y5BxxLsAZQV+mVoy+fXzWAGK+H3ftD6ob3+LWmF3QJ1zsUyx0XMtxrAuOXZi634xE0WFOPjEYaOsJpHbhiB/8qVi8qGk23rkdW/uUY01CKS4s39ldrOAQzGe7y3uBXz3ZcgDVTxZy+y/M5zjMQ/tkV6FMhpghfsUGOWkjFvybZgG9X4Nb342gtBUmrI+kJCgFVgbb6tgtJOaOzhbMTfhLMpSLuA==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by SEYPR04MB5835.apcprd04.prod.outlook.com (2603:1096:101:81::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 07:19:25 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 07:19:25 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
CC: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 07/10] ARM: dts: aspeed: yosemite4: correct the
 compatible string for max31790
Thread-Topic: [PATCH v2 07/10] ARM: dts: aspeed: yosemite4: correct the
 compatible string for max31790
Thread-Index: AQHbE9rkSZGjnIWGW06qaqCftsPaj7JysdwAgAHvZaA=
Date: Thu, 3 Oct 2024 07:19:25 +0000
Message-ID:
 <TYZPR04MB5853B90D170DA7069BDA31D8D6712@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20241001082053.3455836-1-Delphine_CC_Chiu@wiwynn.com>
	 <20241001082053.3455836-8-Delphine_CC_Chiu@wiwynn.com>
 <21415012dec630193b916900f1382d5518d98042.camel@codeconstruct.com.au>
In-Reply-To:
 <21415012dec630193b916900f1382d5518d98042.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|SEYPR04MB5835:EE_
x-ms-office365-filtering-correlation-id: c931e5e4-cfc3-4118-dd09-08dce37bb5d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZE50UkZwdVhnU3phbHRZYVlPYy8vbEVZOGxSczI2WDJjVlB4M2JFaUhFajE2?=
 =?utf-8?B?bWhacFF2N014U1hUS1JBOE11eDVmaWwzRDRDdWZXZXowNGhCM3lFd1JUYloz?=
 =?utf-8?B?NFBjQ1JJN2RhTzZjVGFRai9HOVREcjdBR0xEeW12eFVNMjMvaC9PN0lhaXF6?=
 =?utf-8?B?dmF1NDJoQlUzb0JKcS9ySGNnRUVNTGQ3cjJvYVhwcG5URFdSV3EvWmt3a3Js?=
 =?utf-8?B?bVN4ZE5UNEVMVnBoYkxEcXE4RnQzbThrb05PRDhzWEFrMUtzQTYyWE80MUJx?=
 =?utf-8?B?WGdob3F4QmgxU2JyZkNZRkFDMm4rbkpzNk1TdkJhUURuWTl1bXBGNm1JZTFB?=
 =?utf-8?B?U2JPT240SWpHQ2ZxUno5aXVnN0VoQXhadkxZempnUTY2UDFlL2ZQdjkrQVkw?=
 =?utf-8?B?aHZRVVdWUjBldlVuM1E1RjRVSjU3OHArUW01azNhamwyajlnT2JRSU9jQjl3?=
 =?utf-8?B?Uy92S1lCblplejB3Y2F5Nnc1NURUb3ZpQjNweE9WWkpFNlM2SDIrL1U2NXVX?=
 =?utf-8?B?UXc5ZFBmR0hRY0Uwd0g2NjNyMFZ5VnpJT0hrUzRPSzhLZGYrSitvMWowVUI4?=
 =?utf-8?B?b0p1dkx2YVIrbS84ZTlnaTlSaC9KcWFyeU1ibitJL2NkU0lkRHNUcW9BMk5i?=
 =?utf-8?B?bkU2cTNRTEY4ZFNqNmlQbzJhZUdQNjkxbzRYZGk5Zk5UN0F6SnlIMDI5cUlY?=
 =?utf-8?B?RDVscXpRcFJ2ak5UcldGNnZMR2NsWnFyd3l5M056V3RVMjI1SzRKUVB5VDhT?=
 =?utf-8?B?enVTNksyeU1WUGQ1ZGNRUmNod1d0VFNqZGZrbVNZcWtVRlNTRXBTazVXVGw3?=
 =?utf-8?B?T1FLRUdZbGJKZGV4L25BakJqYW5nNjhGTkN4ckFod0o2Q05aRGNqWWQzQUFI?=
 =?utf-8?B?SXA5UE5LaGUzMksvSFRzS29YNUhDc2l6MlJTNElPTFV1eW5pTjFQbStzR05K?=
 =?utf-8?B?dEdaeEhjazZpNS92eExSZFBKMUFscmpEUklrbHpqcEJyTWdWblAyRVFoSjcx?=
 =?utf-8?B?dGR1cEhTYjNGL0N1Q3dMYk4yQkY1OVZoOTM3c0l2UmpmeisydFVMYy95Mytm?=
 =?utf-8?B?Zm02ekxBN2RaUzduS0w4WFZlV1g0TGIycDFkSWc0WUlmV3ArVElYejVDZy9o?=
 =?utf-8?B?RlAyNEZncThpNGRsV21QZmxKdFk2MURlMC9VREs2dTEraXdNeEZuU0ZyVHZo?=
 =?utf-8?B?UWZFelYxdXo0SkRhUHM4OFJRa0ZhQnZWK1E3WCtpVStIWVFicVFaaWpNTFZF?=
 =?utf-8?B?cUQ0UkJPWnY3NzlGa2ZJYmV5REVicVZyMmVhQjNZSXFVK3pmSlNxZTBFVU5u?=
 =?utf-8?B?ZVVzOWY3MlNaU0kvTkNSS04wZDErcDNReDE0Y2pGT0xtbFVVMXMvckYwc25t?=
 =?utf-8?B?TUs5aGZXd2FuR1A1alpMY2xmY3h0NWFqSUtKcTRhTGRkOHFUVkhIb1hGcENx?=
 =?utf-8?B?MTh3a0hhQkRTMi9BWFR2WFlFMHVUR2Erdlk0OTM5RTZENmlGY2QrMlNGclJP?=
 =?utf-8?B?TGhvVnd0MHpVY3ZmU0FCbitWR1RDbXhLNUJ5UUZ4U2F0dlozUjBRL0RrUHVF?=
 =?utf-8?B?UzBBRFUrb0plQVUwNTFORmg2QnlQeU9jenFvZDBXMmpWdGF3Y2hWTGFTUE9O?=
 =?utf-8?B?aFFKbk91RE5uVDJTd0JNdnVVcHoza2xEK05DaU1jMGdrYW9KQXJJVFA4YXFZ?=
 =?utf-8?B?bHo3U1FJc3pMQWFQdlpXajBqZW9sTWFCbnlLdURxMDhiMlBpbzJIWHExSUQv?=
 =?utf-8?B?UTFTUVRHcFNyWjhlMmNkKzZURS9ZdTRXT1NaUTJmU3kzSWZaOG5DUXNWcGhC?=
 =?utf-8?B?aFdWNnlFNThnMTA5YjA5dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFBBSlhNYkx2Q3UrSzNMSEVtL1hCbXhZY1NIcGVuZ3cxRlNQTyt5OEdTZUhj?=
 =?utf-8?B?dGhwVG91eTNtSDRndmhQeGJheW9GSW45MWRaQmRBdmsvMmZhQlhmWXlOaEZM?=
 =?utf-8?B?R1BCNmJkY1FlejEybFpJeUw1bW41UWtPTjI4SlB2SnV2RmFHa3Y5MlhZTUxL?=
 =?utf-8?B?UFFYOUZlR3RiZWkxSGlYMzQrOVhLTGgrdFQ4aW8xYmkvMzNOWG9ZNVZRSU96?=
 =?utf-8?B?UnUwc3ZvQTJTb05jaG1mSzBTQWU3ODZFSnNJNFc3OSs3bjN5V1BtbWVyalFG?=
 =?utf-8?B?RU14Z3J2cXVJU3d4TGl1V0RWQldnMFBxN1hsSUQ2VlpxbXI4cjhLQWQ3ZW9o?=
 =?utf-8?B?RmhFTVp5Mzh2czN3YkRxdkthc3FMakJEU1hsNWZaL3k0Z0NOM3RWOVVpRjFv?=
 =?utf-8?B?Z25KdjFxQTZsQlpTSHRPaURSb0VkYmhoelZ2aVpTa2Jud05lODRQbW5xQjU4?=
 =?utf-8?B?bzFiaWtnUy80anFJaUxGS0NrSzM5N3dhb2xRVWFOUkUvdzdQUkgwWVZMUEoy?=
 =?utf-8?B?Mnc1bWxTM0JOa1RkUGp2dTNKR2JTWDkzZ3FkWmN5UkVtL2xwRmZjeHVJbWVX?=
 =?utf-8?B?eEdtYUwzQUlDYjNTYXI0SVgrWHI4dVhRQU4xWGhoOUtQc24wWGwxdEJiWWd3?=
 =?utf-8?B?c3dWdW5GZmZ4SndZcnQ3UEgrMFZNZTVEQ2VmNEgzdFJXc21HMXpSR0d0b1Jl?=
 =?utf-8?B?RUJ6UFRFcThpQjVTTmgxajk1UC9FcHpWOUliclpVbU8zMUh0MVZ0Lyt5S290?=
 =?utf-8?B?RkV2b2hXVDBjOUhra2ExbTZwUUtPeTlpcExaWlhlbUphWm01ZFlXbk1idmUz?=
 =?utf-8?B?QVRKUUEvSGgyWWRlcGVEWXJLWDJXMlJHKzJEV0RFQTFRais3Qm5NWGkxR1lm?=
 =?utf-8?B?UGRmKzBwLzBadVpaSlhqRkltWS9pV1VPb0tLcVFmUERkL1JwdGsvUnFvL1Q2?=
 =?utf-8?B?UGJudW1qQ0hDSHBUYlpjNTdVeXUreEdhd001Wm5iTmdrSDBvbEQ2SzZUcSt6?=
 =?utf-8?B?dGs3bzg3OEE2Y1FnSmc5eUFzYlRtZWZjRSs0TXVwOGd1bnczcXBpdXppa0JC?=
 =?utf-8?B?blZtL0VtelBSVmVibjZHWjJCQitFakJzb3p6elorVVR2S0hmL0RPTnVYQmFn?=
 =?utf-8?B?SnFITGhhRGVHTnIxcGF0VW1ROTVOeUhmd2JXZU00SHZhSTdNYjZmQUpCWWNU?=
 =?utf-8?B?UEZpbSs5UEYyaVdLSFNSQ3lCRTdrRGwxYUczOW1pK040NzBNeit3ODJDNU9T?=
 =?utf-8?B?OFJjeFEzTE5kV1NVbXJobzRjYTNoeXAzeEtWM1RSMnMyVVhLYXY3T1NLK3N6?=
 =?utf-8?B?ZHROV3RDQ3dEQVNpMGxkaTdBNmEvbm5iV05uSUNkQkVVSzBPRXNIYzM3endM?=
 =?utf-8?B?UExJMXNjaUJ0bHRzUllBZUhQWkNSQkhmem5mRTN0ZExpampoaDFJL2pkKzky?=
 =?utf-8?B?NGVNSzlPMkFGUVVrRHU2UHdHYzFCQkVTU2lnMU05Sys5YmR3NHZXL3pjaUNP?=
 =?utf-8?B?MytkVnlqeWw1SXgxVFZ2VUU0TnRiTkRWNFQ1VlMzQnVoZ1R5cGczbU5DdC9R?=
 =?utf-8?B?Q3RrRnVkZFNsM1NocWllK1l4RmZnWlZ3c2lYZmMwNjYzcjMvY0duR1N5amxt?=
 =?utf-8?B?cFZUcWJ4UzkvUWUxYWdIMmZtTEN3dzIzWHJpcFF3VElWVWNaVG9MTWZnUVcz?=
 =?utf-8?B?ZzZVeDg3ZVRBTTVRYUo1K0Q4bSt6U3R5dkVyRjJxUzF1K3ZLN0ZGdVpBL1JU?=
 =?utf-8?B?QzVEaXRlV1RGY3lOUGpHZjJHWUJrbFRaZlRPa3hFWXpSajZjNDZJLzROTUVp?=
 =?utf-8?B?cmc2RzRvTVVoLzBaeHRpcnl3YmprSVlHWWJud0E2bzUxejg4MVpwUVhSVGsv?=
 =?utf-8?B?YmUzTW9TY3lWWWNFWFVpMUlHbkhBSmY1Z3pCU3Rqb0x0SzRkdSttRGMvLzg4?=
 =?utf-8?B?MU04UUhkbUloVzVBcDc5eXNOMGpGdndLNzI4RU9EMDlOaHkyYTdDaUhuaERh?=
 =?utf-8?B?dENJdVBYQXRpTzNUSm1MM0ZMUjJZanN2M29DdkxOQ2hVSGN2NDA5YldkaUo3?=
 =?utf-8?B?d3NIMVk3cFlDNlJFUE04dzQvbThzQW9GQ0pvcEZiWHoxWlhPajM3NTVjbU5j?=
 =?utf-8?Q?n52ZfYFosFRIcXskPlkBR5IRv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c931e5e4-cfc3-4118-dd09-08dce37bb5d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 07:19:25.0612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5306fFJHE/86B0vPCFyXBeK9LmFCNDdDhn5CB2zbtIlC9Q/Zm2KcOeN134TuvycBzifrZAYchvVyE99z+ZB0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5835

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVy
IDIsIDIwMjQgOTo0NiBBTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8RGVs
cGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gcGF0cmlja0BzdHdjeC54eXo7IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0QGtl
cm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb2VsIFN0YW5s
ZXkNCj4gPGpvZWxAam1zLmlkLmF1Pg0KPiBDYzogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1Lndp
d3lubkBnbWFpbC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJz
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyIDA3LzEwXSBBUk06IGR0czogYXNwZWVkOiB5b3NlbWl0ZTQ6IGNvcnJlY3QgdGhlDQo+IGNv
bXBhdGlibGUgc3RyaW5nIGZvciBtYXgzMTc5MA0KPiANCj4gIFtFeHRlcm5hbCBTZW5kZXJdDQo+
IA0KPiAgW0V4dGVybmFsIFNlbmRlcl0NCj4gDQo+IE9uIFR1ZSwgMjAyNC0xMC0wMSBhdCAxNjoy
MCArMDgwMCwgRGVscGhpbmUgQ0MgQ2hpdSB3cm90ZToNCj4gPiBGcm9tOiBSaWNreSBDWCBXdSA8
cmlja3kuY3gud3Uud2l3eW5uQGdtYWlsLmNvbT4NCj4gPg0KPiA+IEZpeCB0aGUgY29tcGF0aWJs
ZSBzdHJpbmcgZm9yIG1heDMxNzkwIHRvIG1hdGNoIHRoZSBiaW5kaW5nIGRvY3VtZW50Lg0KPiA+
DQo+ID4gRml4ZXM6IDJiOGQ5NGY0YjRhNCAoIkFSTTogZHRzOiBhc3BlZWQ6IHlvc2VtaXRlNDog
YWRkIEZhY2Vib29rDQo+ID4gWW9zZW1pdGUgNCBCTUMiKQ0KPiANCj4gQ2FuIHlvdSBwbGVhc2Ug
b3JkZXIgdGhpcyBjaGFuZ2UgdG8gcGF0Y2ggMDYvMTA/IFRoYXQgd2F5IHRoZSBmaXhlcyB0YWcg
aXMNCj4gbWVhbmluZ2Z1bC4gT3RoZXJ3aXNlIHRoZSBmaXggaXMgZGlzcnVwdGVkIGJ5IHRoZSBj
b2RlIG1vdGlvbiBpbiAwNi8xMC4NCj4gDQo+IEFuZHJldw0KU3VyZSwgSSB3aWxsIG9yZGVyIHRo
aXMgcGF0Y2ggdG8gMDYvMTAgaW4gdGhlIG5leHQgdmVyc2lvbiBvZiBwYXRjaGVzLg0KDQpSZWdh
cmRzLA0KUmlja3kNCg==

