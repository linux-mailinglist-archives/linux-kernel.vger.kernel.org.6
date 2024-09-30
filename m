Return-Path: <linux-kernel+bounces-343391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAC6989A70
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BB31C21389
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336B8149C50;
	Mon, 30 Sep 2024 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ggmnl3/M"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2046.outbound.protection.outlook.com [40.107.255.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ECD1F5EA;
	Mon, 30 Sep 2024 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727676527; cv=fail; b=LQ1s9KAWCtmm73WQLzIt5E2pSE6Qv9qATxowjkn9JJRtC6JhRsbNN7eMX7AByl/zz40axZmhZgXAbxujZRLJof905cJsUXF34kTPNl94lrkMFc9JBm636FN9XhBa1aKiG0xjUZQBImkqjuELPd3iJBi3fpWwfnfRrKU17+VjUHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727676527; c=relaxed/simple;
	bh=+Fu/y6JEy2wV9ccRQISwsZONZximeBcr0KP9VWvxDLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZCOauQRtIzyNl6ZaFfOcecISZnirnVkEYuZtmzK3puhKzXS1u+9fX4gb4068d6H8YeIlWVdN7eOdulBu41FbmIDw6rqIVM0+aN++YarFUK41yLZXqNcbmhZN8DdkdPVCmoXzXJtIXBWKwsGvkUkmhbmp9Egi50oTIy58PSKXKWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ggmnl3/M; arc=fail smtp.client-ip=40.107.255.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqlwseuZqRMncndSUjEL9L7ifeWmkfw4ponlHtBhKV+T80JwPACfCvEKuV+fCR7uB59b4an56z3/NWvYIU55agCwH+4sP2eM2rzy5GdJZimRerbNYHVfvuD1cT2iAowlrRfRicdeNDN9OgF28xntYd32MRV8ENFQbHCQT8SK6T/nmm5kETYr8Ib/aHsB2qWwT4AOMBNpCNO7cg3FhenSiWnrf40qQXHcNv4qSCzyDzii/RL5fPYs6PLB0loQh1NkItQhg0rAWtCuEBTWX3Mr3jPESjSnqgL6Vlji5uFKgF26eJbtvLA1au6DkrkAgMxdjWziF4ENAU9Bh6CRnivd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Fu/y6JEy2wV9ccRQISwsZONZximeBcr0KP9VWvxDLY=;
 b=ik/3fz3chOgUcMvEOgVIP2ZhFgimxbOiHq8I7+k35rExVGtaVOb6nswzl7PnMHBIrC50mdHl2XzzVYWbcnID7L1uB9+/IOuCWM9Bq7ptb80jKofp2xAd9Kmr3CCNuhv9R+q3roqrPedXFYyWTa0AeXYj+hJz4XPyaY3Mr+5jqwvXtViise0j0B2nQfHUG9Bi9OIB8iPAROl7XvIgXRl052Qdxa5GSEzv0gydyolUvTMOjb/XqR3h0v8XdRt1jl0AOzdqNXiYMaG0eXVH/wTGgh8A/Auq4fR2jDcHbFWzcrHIx6OUWp3zOhfuTfUj5Nk1zQRVek4cCqkztjWzr7hyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Fu/y6JEy2wV9ccRQISwsZONZximeBcr0KP9VWvxDLY=;
 b=ggmnl3/MSFcOYA9tcojYUsClZl9eaKuBHra4eB2OuZGEbDr4dKxzcP+sul3Bdm715gTOPMWdHHyxkoCEr+U2aFHBimtZEjgg8/OIix3VNJtRuSt2aJx6lJW8bLzrrIDUfyIi0iE3Bsich9KYK5Te41dcdZc4Fjzy95kDpJXjEdlCHrNFPg5iukn1ETSxiawHz5H4hC9seUBxyqUSOPV4ioEIQJH4dZzrKAFMiXeMdXQFoqmjA3Og+ECWjF1c3DoS/iCfZORmsQisD4qQBCo2GS/e7wKulhr7568AO+TtsH9witASSFzZAIQ7NMFyaEnPAoVRGY7VhI23S0uE1es7Sg==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by SEYPR04MB5620.apcprd04.prod.outlook.com (2603:1096:101:50::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Mon, 30 Sep
 2024 06:08:38 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:08:38 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, Patrick Williams <patrick@stwcx.xyz>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Ricky CX
 Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE
 on Spider Board
Thread-Topic: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE
 on Spider Board
Thread-Index:
 AQHbD72dvqgTMAKzWkuYvi4zIhwj+rJrJMWAgAAxixCAASfCAIAC9XGAgAAdDXCAABMVAIAAL3rwgAAJ7YCAAAF0QA==
Date: Mon, 30 Sep 2024 06:08:38 +0000
Message-ID:
 <TYZPR04MB5853A7B1266F61A7FD67175CD6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
	 <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
	 <TYZPR04MB5853B51141F3D0610D970265D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
	 <Zvdq7o6NFXRVCJqX@heinlein.vulture-banana.ts.net>
	 <16c89a7b9b85d21f1f23aa0d67742c6bde94a295.camel@codeconstruct.com.au>
	 <TYZPR04MB5853A70A99CEDE8EB64A317DD6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
	 <ef0e0be6cbdcf410ca7854884f32da0e3cf6b295.camel@codeconstruct.com.au>
	 <TYZPR04MB5853D743126A23AD41BE3E0DD6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
 <81b9916f299bbf29583aba610c0147c8b8afd092.camel@codeconstruct.com.au>
In-Reply-To:
 <81b9916f299bbf29583aba610c0147c8b8afd092.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|SEYPR04MB5620:EE_
x-ms-office365-filtering-correlation-id: 6727f1c9-8811-4e05-2463-08dce116536f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnVvaW1VTVExTFlBVkZtckFaREZPTzNldmZjTzVJNndTcm5ZbVVRNC9rNnFG?=
 =?utf-8?B?bGNlcG5MUytVV0NwUmgzVjBKSG1kQVltd2dpWW1HV2hERmxnalpvU3BiSldU?=
 =?utf-8?B?VEt1a1N6S2FrK2ZMbGg2OEpmY2lIYmlVZ1doZm00eGlZREE4RlZiaU9JdlVj?=
 =?utf-8?B?Zm5qZWRUTFFEKzhqTW9jOWNES3paNE1pR1VsZ0JSVVNJQ2poRWUxd3lVR1hp?=
 =?utf-8?B?bjRNVWlBMXpKQnFrMElURXZkODJVTGpYeWJFODhrRGlPOVBCZ2hvZVg1UE85?=
 =?utf-8?B?emliejgvNTJDaWlMWTFyNU0vcEdBZFRxKzhIUGRkdHc2NWM5NFRPVnRrcjJ1?=
 =?utf-8?B?YUw3MmZlb1JWVC8ySVVQbUFiVk1BQzJ6MFhQS1FrN1hzdHFoVHVxL25Ld1pB?=
 =?utf-8?B?VHRkZFVXQ3ErdE1HMGVJMzU1WC9zb2NOVmlUSnZmOWc3S25qTWttNWJYS2U4?=
 =?utf-8?B?c1pFbnBpT1pjcjdwMHVkWjFXRU0xZTZKenRzeER6N29UMmJGZnBsQk1jVUtQ?=
 =?utf-8?B?TmYwTDA2S01jVnZXWk1OLzRlaDRieG9NcGVMc001WXdGclJKblMxS1RoNVNk?=
 =?utf-8?B?RlFiOG1PbGdXTjIvVVg5VW5ldjRQZVVwbWJyQ09hYVFZbXpTSm5MMk1PNU9O?=
 =?utf-8?B?STFaMkJvRm5qT1ZwUzlpR1FRVm9ScjhBenJyVzZieTVsWjhEVlR0bktxMU1o?=
 =?utf-8?B?U2lYSDlrRDhIYzZTWlQxNjVqRWxUcXlwcStOQk16dEZEN0pzQ1Ntcld2YW1R?=
 =?utf-8?B?dkdaQ2MrdU5IQVdNRk9tcm42OHZseGF3SEtxZjFFeTM0L3JSekUxYkZRN2RM?=
 =?utf-8?B?eENjVmRicWdGQVNJWHZiUi9LUThlMU1SeFhRMk5XN2I4WHJKbnFuNzVzVmo1?=
 =?utf-8?B?WWNPdVhtNElLT0VacWIvUlhneEdpN3o5THE2bzNVYm1kWWszcW84SkwrVjk2?=
 =?utf-8?B?OFl1anNBd2thZDNKa01hd0RxdlNaM1d6aEUxcE1pZSs5YzZoWGkzQzVuYVdJ?=
 =?utf-8?B?cG9ETm5tYXdnbVZoS1l0b2c5TnloemNYNDBDeXVvNS82aXE1T0x5MlRtU0VO?=
 =?utf-8?B?VGJVa0plZDhLdEJ3N2pBLy9mNms4anBJd29BL2lRNFlsZThveExweGdBMmNo?=
 =?utf-8?B?c0p0MGVsdks0SFBrN1JsM0ZCbkFreVBKcWp5dmU1Q0dWV1BsU3gvdG5SWU9B?=
 =?utf-8?B?MEVNdjNKUnloeitWREt0VUtVM0M4WkNqUHYxaU4vMlBLMjNxbzVtdnFSVUYy?=
 =?utf-8?B?dmkvSUNlK0dWSlRTUHJzcnZhbndVZ0cza2I5Ym0wQ3N5b2FrcmtoQ0Q2OEdF?=
 =?utf-8?B?VWI2LzIrOVhqSmtpWFl5S3JtN2FEYlEwK2IzMmpTWHZHZWdYRHNMMklXYXVM?=
 =?utf-8?B?eHFrSXNYS0xtZXFERVJGSXhCbk5xNkkyUmoyNVh0T0lTQStHZmV3R1hkb2d5?=
 =?utf-8?B?UnhsZFZmUU5CalU3M1Evdk9ZcEFnS2xHQXk1UDZqeEVvTGdIZkJlTS9jeFdC?=
 =?utf-8?B?ZGdZZGFEUnlyekJIZlV2bXdmUGhrdURObEZJM0Rzbm44MXQ4WGVPN0M5U0E2?=
 =?utf-8?B?QUFkbW9qRHhJK0ZLMFU1UnFSQmxtbSt3QWlQWGIxREJsUEtza0pxTTBVSm93?=
 =?utf-8?B?RjMzNmFsZ3lrRFRucC9uUCtRSkF5b05nU3JCcnBKVUtsQzd1OW9TS3RHOUFv?=
 =?utf-8?B?ZmhRRGYxK2J1ajB4WFU5TlNxTjF1aFdDdG5MZytJNGkrRUFOK05HcFpJNUdh?=
 =?utf-8?B?RE41VmlyaVRLT0o5WC9hS1NDM1RabG84aW5Mc2dxSnNKYzAwTUo2WW1zazhr?=
 =?utf-8?B?ZnJ3cnB3WDJDRWJ0YUVDdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0FxY1FzSFBESkNMNk1kejNKMmlaaEdBRlRmU3dQMnovRGhkeThaaG91VVhI?=
 =?utf-8?B?MHVBbGR6RTl1OWRtclIwMldwWlN0Vm1wVkd3MzNoSExnRnFFaWhRb2xyYTM4?=
 =?utf-8?B?ZUtvOTNHUDduM2JPeXlnVFdvSTJ4VFhaeU5UNElKa1MwOUdyd0x6dGpobmRO?=
 =?utf-8?B?a3pwVEFLQ0MyNk1KK2kwRHRNaEhtRnZiT0lmNEpyaUZZbENHVGhyeGdkMVZ4?=
 =?utf-8?B?aVIxSFdZN0VhRXFncjdoV25TVStPckVhYmRkSVI4SFVsR2s3OUlFL1Bsdkdo?=
 =?utf-8?B?QUs3V0FkazF0UVRwWnRoWTVPN1VxWVlXK2JBcmZRVkYrZG9VL3h6VGxibTND?=
 =?utf-8?B?NldmZXFWVFN5eDdUbFcvZkdZRDBNbUZHdmtqazhTZkJaemlpMGtGVy9IZUl6?=
 =?utf-8?B?NEFZRG40cldySUlET1UzYVI3cmlnMmtUbVNnU2lmajNmUEFCUWgzUmZTc1Nz?=
 =?utf-8?B?RTFsWCs5dHJ0SU1SNjBudmdUUmxkWmtLaThOaEh5cDVJUHRQNzBZaEhrTFNP?=
 =?utf-8?B?SlAvWU4xMWhqWDBJUzlyaFJsaGNvdDBkZUUzQUthWi96YU82UzRyblhya013?=
 =?utf-8?B?Zy96bis5cE9WQ1FRamx1RVcvZnhhemFNZWlpZ1A3Q3ppSnM2d0pJdVJpRG1x?=
 =?utf-8?B?U0hJYkdoUVR5NnA1dVZkMU5leUh5Qi9iOWp3RDAzZ1BXc1MrK2ZXeHFiTFFt?=
 =?utf-8?B?Q2orVVFCUWY3cVNkZEtiMzZhYWNRdnpoMkpyOUdNRDNnWUpyUDBpM0VneE0z?=
 =?utf-8?B?ZzU1NUFDeVBYYWExbHV6N0xVZnZkWXRLVENSUFNwVlN6S2RNQ3pWS3dEdW8v?=
 =?utf-8?B?ZnZLU203SmFpZU53L2NBRkdvb0t4VWk4K2kwQkEzV3hwVHJUdE1jYkFwa0gv?=
 =?utf-8?B?N3pQVGFYMWhWeFkxOUJqcEwxbVlJZ0cwUjFPOEpRVG5iWlVBK0pHbWdYQkRz?=
 =?utf-8?B?QnhHT0I3NHdnNHJIVkRQTis0bGJOSEwzcS9ZeDFTeUpzK1ZEWDF4TEg1bTNk?=
 =?utf-8?B?cEVkMEtuelNyMFpSMkJGZURjOXkreVB3a055dFF5NmZRclozaDlyZkVWN0Zz?=
 =?utf-8?B?cVdsVnZRQzN2em1vRHNmSnVXZFp3OXJnNFluaThSMFY1Z05qV3MxbXIvRzJV?=
 =?utf-8?B?S3JJUWxwRnFZZldkNnR0S0lIUnJBNTFibGtWTGgvYVQ5NGNSTVRRWFR2R1dF?=
 =?utf-8?B?YjBMd0dYUzVET2JYaVpYaVcyRTRMcGtvT3pvMGNza3hZaDFpSi9JUWJRSytL?=
 =?utf-8?B?Q3QxT2dheG4rWE44dGdJcUV0V0NhR2ZnUTVacWJSUFBaZ0NuaTR4N1pZV2NX?=
 =?utf-8?B?UzFhUGswWXpTWHZublJCMzJZYjVqZFYveGdBVzRhSllYU0ludmwvUnovckdT?=
 =?utf-8?B?ZXBKYXY1ZUs5d2U5UlBJc3B5SVRXYWp4UDJUUzNvRG5UVG50OWo2MTdhVFkr?=
 =?utf-8?B?L2YzSDlpUHl1bW9sQlFRcXZBQnhnVEd3UkFZQmsycDlsaVJMK1drZTNWZzBj?=
 =?utf-8?B?K2xUK0JuSzBEeFZCK1hXTlZKbXU5TFh0Y3pnVTJoSHhrb3E5bzRFenZuRDhi?=
 =?utf-8?B?a252am1wL1lMTzVXVXlINCt5SUNKQVdsUWNicHpKVXF1RmdteFVzZ3dUZlBJ?=
 =?utf-8?B?TjRqaEp2SUpnZktZL1dWNXdlVjdQZk5SZGlRR2NkTjhwSmVIdWRJQ3V4d3Vv?=
 =?utf-8?B?Z0tvakF3dFVRdUE4ZnAwZThjOGRveUl6aVo5V1pEOVhyRm50OVE4OVQvM1Jk?=
 =?utf-8?B?SkxDUWQ2NHdFN3RCZGFoYWhYcnJmWHBhdmdUUWt4MldrQkFnMDliTHB4Mis1?=
 =?utf-8?B?cjV2dFVNS1ltV0hQdWJpMnhFNHh2VWJIK3ZrbUVESy9qMWo1Wk1JWGFNdm96?=
 =?utf-8?B?V1E5djBUUVFFcDBTYkNrY1NqMEtrYzNyL2ZMeEZzOCtrL1pKSTR0Z3Jkem1j?=
 =?utf-8?B?MnE1NmtjZllhZlI5b1FtVXFsM0xyTFFTYW9hckEyUVJ5bmVLeExadUQrS1B1?=
 =?utf-8?B?aUhOaDRVUGhoRlJHNnhtbnhsejRra21zTHkxZGFCMzV0MFd3eEx2d0ZBZUVB?=
 =?utf-8?B?SGJDZnNQR0UvUGxCTlZqdFZqTTVkTFYydFIzZGd0cTkzVFBlVmlFUnJUcDZ6?=
 =?utf-8?Q?eqlwt6MfInsDeY1b6Miwier/Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6727f1c9-8811-4e05-2463-08dce116536f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 06:08:38.4553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwLzJifpZP/91BsBf8e7xzY/8hpjYySQRwFRATA8NUQE6/AhnSVGM/Yr9+IR6LmGVLcj+blI5C2py+yZmx/zhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5620

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIg
MzAsIDIwMjQgMjowMiBQTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8RGVs
cGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gUGF0cmljayBXaWxsaWFtcyA8cGF0cmlja0Bz
dHdjeC54eXo+DQo+IENjOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsNCj4gQ29ub3IgRG9vbGV5IDxjb25vcitk
dEBrZXJuZWwub3JnPjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IFJpY2t5IENYDQo+
IFd1IDxyaWNreS5jeC53dS53aXd5bm5AZ21haWwuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYXNw
ZWVkQGxpc3RzLm96bGFicy5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MV0gQVJNOiBkdHM6IGFzcGVlZDogeW9zZW1pdGU0OiBBZGQg
aTJjLW11eCBmb3IgQ1BMRA0KPiBJT0Ugb24gU3BpZGVyIEJvYXJkDQo+IA0KPiAgW0V4dGVybmFs
IFNlbmRlcl0NCj4gDQo+ICBbRXh0ZXJuYWwgU2VuZGVyXQ0KPiANCj4gT24gTW9uLCAyMDI0LTA5
LTMwIGF0IDA1OjU1ICswMDAwLCBEZWxwaGluZV9DQ19DaGl1L1dZSFEvV2l3eW5uDQo+IHdyb3Rl
Og0KPiA+DQo+ID4gSSBoYXZlIG9uZSBtb3JlIHF1ZXN0aW9uIHRoYXQgaWYgSSBuZWVkIHRvIGFk
ZCB0aGUgRFRTIGJhc2VkIG9uIHRoZQ0KPiA+IHBhdGNoZXMgdGhhdCBoYXZlIGJlZW4gYXBwbGll
ZCBidXQgaGF2ZW4ndCBiZWVuIG1lcmdlZCBpbiB0b3J2YWxkcy9saW51eC4NCj4gPiBTaG91bGQg
SSBhbHNvIGJhc2VkIG9uIHRoZSBicmFuY2ggImZvci9ibWMvZHQiIGZyb20gYW1ib2FyL2xpbnV4
IHRvDQo+ID4gY3JlYXRlIHRoZSBwYXRjaD8NCj4gPg0KPiANCj4gWW91IGNhbiBkbyB0aGF0LCB5
ZXMuIFdlIGNhbiBhdCBsZWFzdCB0aGVuIGJlIHN1cmUgeW91ciB3b3JrIHdvbid0IGdlbmVyYXRl
DQo+IGNvbmZsaWN0cyB3aGVuIEkgdHJ5IHRvIGFwcGx5IGl0ICh1bmxlc3MgeW91J3ZlIGluYXBw
cm9wcmlhdGVseSBzcGxpdCB5b3VyIHNlcmllcykuDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBBbmRy
ZXcNCg0KR290IGl0IQ0KVGhhbmtzIGZvciB5b3VyIGhlbHAuDQoNClJlZ2FyZHMsDQpSaWNreQ0K

