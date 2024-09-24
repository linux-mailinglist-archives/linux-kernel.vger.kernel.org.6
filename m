Return-Path: <linux-kernel+bounces-337093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A704984538
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D900DB24108
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DE91A4F19;
	Tue, 24 Sep 2024 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ezpH4h5Q"
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011058.outbound.protection.outlook.com [40.107.74.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0FA824AD;
	Tue, 24 Sep 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178707; cv=fail; b=RdeEu9ISzM6RLGRK0KzksZdGH0pUDj0pJoidouu4AORbz5z1oO18oZt9dS121WSEg3kUi8pC10gxCnBAtRS9U2s09DEkm8cM4/H+CugSrlYjddSJG6JEqiUezeffkbGEuH4Ah5EmLPb+82RP1jdbE6KHER3eHzYHE76ePDjHSmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178707; c=relaxed/simple;
	bh=KnwlcoEcXb+9P+S88pmROg0oTKGDV7gHVz5N/bJOKp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lV2+kTAwR+2klkZ4/JCuGTqgXcxr6XdNM3hlKvrqDOIQnAbLCm/bzVT8uOI1IAPXMYun7KZMtlvuIqfvTk2fxsgMXN3E6Uzk7EJUaQ51ZZI0WyXCkHpB9hUqyaGo0lv0BnUubrxAlLRHQI68YXb8VKK/fLTIJXzk4SN7d1Mxq5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ezpH4h5Q; arc=fail smtp.client-ip=40.107.74.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyDh8DEHTA/t1jCWr7fIrbunk3v2c2CuOVZfYYLwb166Dx64w+IcuVoqC2W1BbusmYbxegyGmzC2mdGp/NoZnHZS2JkuFNle9QwrPfUJS29izPJ68RFfn4O3pI4UZ770ov+0AL2/6amY+/U6x0E3FrdFyvFO6rx9geNRIiG/c+nhMtegg4C4X6B0WDxfLEJN9p9Iy/ZDwEnOsiA8v0Vpdi9RYlRvpVaMCD0c0eTxvrH1j87T/IpfL1kM3RttgJSYDjVYuSF6pBP7yQJ2DNVghEGkvRpvUBbv+rQN850EN+6BD/gkx4V80QG6XkECL4x+csCVm7e6yblNxNtwSHuHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnwlcoEcXb+9P+S88pmROg0oTKGDV7gHVz5N/bJOKp0=;
 b=ci3fYe0Ec14+Hyl2gxPwX8xeCgrZGh4ohjWQlkVCl4otEyFEjMDZMYL4BgZPyP+jfvHUtwSq4lWKHA+CdIZlB6xlDW/ANjcxtph8O4m5ycYDEhjmxowJBRZo8xkvnFQvOobzQQf3YT1/9pkv8LgAMMt4YHiMffrBARRhlnKir8fhrZNKf/8Kr0lrKQAze7un1PDfbRPC0yFbeundHvAb2JqjUcaicy/xCacs5Ne3jwiE0V9U6fTFWNQzD6b0ovMN5uA5OIomN26cqt9hVUQ5WvC2m37QUIZaiH8WA921SW2KJKCCvoupUF7+T6ABkHGCSjyOYcUKw+jHpgFp5XrLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnwlcoEcXb+9P+S88pmROg0oTKGDV7gHVz5N/bJOKp0=;
 b=ezpH4h5QZFWeaAWz3SxvQ0MXLeayO8MBciBERSWD90u7jiNdrDHEJkXqna6eoK94xMpEoP2ZKosObzAT02ZO7mRWUcUTR8iBR+/VsiTLip8NfmNTqB9el0qMn/o5hD7kVtRF62PMxseHADLyQ1BabGQvSk37eDW1eI44hReIJT0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSZPR01MB9517.jpnprd01.prod.outlook.com (2603:1096:604:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 11:51:41 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 11:51:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Markus Elfring <Markus.Elfring@web.de>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH] regulator: Call of_node_put() only once in
 rzg2l_usb_vbus_regulator_probe()
Thread-Topic: [PATCH] regulator: Call of_node_put() only once in
 rzg2l_usb_vbus_regulator_probe()
Thread-Index: AQHbDnXHDDQwPkkn2UCKqbxgiddrM7Jm0vQg
Date: Tue, 24 Sep 2024 11:51:40 +0000
Message-ID:
 <TY3PR01MB113467393E246D553D715D3B786682@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <f9d7a026-a67a-4164-80f4-578b1fbf71ac@web.de>
In-Reply-To: <f9d7a026-a67a-4164-80f4-578b1fbf71ac@web.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSZPR01MB9517:EE_
x-ms-office365-filtering-correlation-id: 24a5fcc9-e172-4139-a868-08dcdc8f4103
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aHM4SlFtdWl6QkZjWGVJUlV0dlU3ejBLOGcrVlpNUUVTdFJ2b3kwelViWUow?=
 =?utf-8?B?YVUrKzl0VDJpb2hacEVJMysyUGwvcGQ5dWM5eE8vWDdaemhsSmlPdGU4cGpr?=
 =?utf-8?B?TkU5RnFuVW1jUjc3UWFLZFNMTFdVcVoyTldnQldMVmRaSUtWcjZ4cmhWY3VG?=
 =?utf-8?B?VDFjcEc0cUp4eFlRQ0tqckdkRldGNEFaT2ZJUmtIRU9FQzltalFzMzlmd0kx?=
 =?utf-8?B?QTNod09QNzE1NldsdUpoNndKNzRQK1FVdzU3OVBYQTZOYlBsdHoraDRaN3RO?=
 =?utf-8?B?b2tqZzZwMTBSdjVHY042bzd5MjZ3K29nSGovWk9MaHlseXJJZE5jNWpKeDZW?=
 =?utf-8?B?M3pQVmlmVkVzTUlhWktlbTJtYS9KQlVOSldyQzU2Y0IrT0NzYTVZUnpoRXJE?=
 =?utf-8?B?RysyK1QwcGthdlE0bE5pVXE4T1FNcm1sZnpQbUd2UDhDNGVHcmpRUzVPYnZy?=
 =?utf-8?B?Q2VjRGc4QzA1NnNvQk5Vb2xQcVVQNzZjVzhBWlpJUC82ZDF3cHdpd1k3TlNU?=
 =?utf-8?B?T3dQVmlrZEYxWDZFTDJIazRjNG1yRUJScnNwRmFOM1dVTUFHVW5OblAzK1V2?=
 =?utf-8?B?c2pua21jaTRrMm51MldYNkxNSzhva0VkZDlxUDlnQkpjOHE5bXpXWGEyL3pM?=
 =?utf-8?B?WlJOOFVQMzB3QkMydGJTcjFpQ2phK1lTZG9DWkpaZGxSU2E3RmwwcEVPWDQ0?=
 =?utf-8?B?L28rTjM5TW1MVFU3Ynoxc0JySHFZelpyMlVUNVBiVkEzbGZGVmNkaTNQbjRO?=
 =?utf-8?B?SkhkaHh0Z3l5WmMwajNPSUhYTHMrWEdWMUNCRnpEWXFkWFJRbGhhbVhES2NH?=
 =?utf-8?B?dlNTOVZHd2owQzN5VXpHM2JNd0gwZ0VNaDZOenh6aDNJMTkvb0RWMXUwYThy?=
 =?utf-8?B?RlpURDl2ZnlxVVU0cDY3OGNORWNYTmpyQWF0Um1hV044V21wazN4TTFOYm1j?=
 =?utf-8?B?SDhkT0ZEK0FnK1ZJa2NaaDBlaHNIaXJoa1VzVUFEL2d5c3JYbGozYUNQMkV0?=
 =?utf-8?B?Z3RFUEJwSDlYUllKNFZFQ2phNWpxWVVLSndzbko5eUhrSWY1RVBIZE9CTy96?=
 =?utf-8?B?R3dEQm5jSnB0RVJNNGFmcjZXY1F2T250emk0aUQ3NmhPcFAvVzlTRE9PTm94?=
 =?utf-8?B?UmJVc2tFazV1L2FtVTBKNGdURnN5TFpibStjVElyMXRMejQ2TnA2VmtHMkZ3?=
 =?utf-8?B?cjBBV2NEamlKOUc2a3pUUFArUFdjLzlNYVpoTmFDYUl2ZjFmSk5JUHAzNEZ2?=
 =?utf-8?B?clJWTXV2ZXg5UkNLeHMwOUhZamxtK3pSblY2d1B3blBkYjBuVTRqamtidllK?=
 =?utf-8?B?aHJsU2hna3VSSG9keVhpbW5KVEVLTTE4eXA5dTdQV1B3ZGVaWjVhelY3TDFq?=
 =?utf-8?B?ZEFuaGpDQUNwUW1EWk9NUGNDR3JweHh0L2dPNWdBeWlGSkptWFhjWjBCQzZ2?=
 =?utf-8?B?WDlaYXp5ZFdMVDBKYkxtdGpGdHBDclZXNWQrYjhIRHF0Ri9BYWV3bDhCWWkw?=
 =?utf-8?B?eTF4M29pMmtSVVFkdEEwNTZUMjYvWFY3SHhHdVVrZEtkSWJQYzNDL3JkME5q?=
 =?utf-8?B?Y3lTMXdMM0xONUNIZElEL1o0VzJudGlIM20vMzFHWVVydjV6ekhEMzI5RStq?=
 =?utf-8?B?Vm5QaHI4REdwTzBrRTJ0K0tnVml2VmpzbGxqbFJBNHFuUTd0cnpFZTgrL3J2?=
 =?utf-8?B?cmVnL3lSckFPaUxZczlDamNKRVUxNlVNOUlFSUhWKytmaFpiYUdpU2w5R2xH?=
 =?utf-8?B?L2tqYzlHejV6SHRSOE5TRjZyTS9BWWpkdzlIRDNuUnpyNVVWOVhoZVQ4L24v?=
 =?utf-8?B?L1NEQi91ZGtBZHJ3SnNlUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTdsTUhUTE1ETE9lcXN5ZGtkZkY0cXNiVks4SVVHUWFZd0dVcVVXZVFXdTBB?=
 =?utf-8?B?N2ZzR1lzaS9Qdk95bzFuRzhqMmFkZWZzSDZVZTd4RU5MWFVaMFFsMktIVWJC?=
 =?utf-8?B?VSs1Q21FZnpnNU05TXoydTNrSzV2akZLa1IrcDZwNi8xVXVGVGFGbkZqRzJV?=
 =?utf-8?B?a1BVeVJCMTdJdU5rczJUQzY4bnp4QkxiODdReGN1WnVmbkUzVEFrUWxsbUtz?=
 =?utf-8?B?QmNWZWVMalI4OUVNOVVWZWVhZ0ZQSkJVblltVXBCZHU4cDg0anVpaXJqL0JF?=
 =?utf-8?B?Y0FnWGxmOTlxdi9NcGxOU2tRUjBGR3NJclpRM0Z3K29idWZFRzFhdWw4V1lH?=
 =?utf-8?B?ajlhMlVsalNvdjFNcTNpamc2cXJMR044TkhqVkRNc1RPVGd2SEp5dmJ5bnlK?=
 =?utf-8?B?MWFlVnU3TzBhWm4vdGM2UDllUVM2VzVRT0gxTWRrUzdHQm5BRHN6V0hQSDZp?=
 =?utf-8?B?NU51K1Z5SHV1YWhFenhQeTk0UmQ0QzVXUnZpTnNNUWxENEhUT3lwKzYvcG82?=
 =?utf-8?B?TWJ5a2NHYjNsYndmU1VtZ2RzeGFQREdpM0RBb21tYVZPQmY0UW9PRzJtR0pR?=
 =?utf-8?B?SUFudkxCb1BJeHBCVS9VMnl3OE0wVUhDdFMrSmZxSW81QXlMbEgrVXRheGQx?=
 =?utf-8?B?Z1BWWk1jUnB6eGlnK05sN3hWRjlLanAyQTZsZUZtWTE3R0hxZDBObkg3TGs0?=
 =?utf-8?B?ckpoUW4xby9IeEVDb09LSGRuRmZGWXN2MUVmT0ZWenZmM0FSVktRZjJTWVhI?=
 =?utf-8?B?WlRlZHZSRXAzekI1YlM5eWdqdWFlTzN2bG1LZ3VYZjBySjhwenN3N0N3M2Nl?=
 =?utf-8?B?Zlh1MzdmV1JGT08yck80TkVmeXQ2eElCd0N6WEw1L0hoT1BMSWdET3FqTzEr?=
 =?utf-8?B?Y2hsMFZMOGpNV0J5YWp0R1VGbXJtNFFXcFFpd05VS1pEWmNSZ3pNZTJzZTdv?=
 =?utf-8?B?NGljY3E3eUxMK1FVKzUyOVhWcnFvNnh1cVJDTHR1R0RtclRIY1BGb1VWMk10?=
 =?utf-8?B?dTk0MWhzWWQ3blpnejIxaTNrVlJMMVFTajh6UFBEZWtUc3dDQlhMZ3ZnVVQ4?=
 =?utf-8?B?VHBxWTJzTjlTRkE1SVFZbXhkZERpVDUzZ2tKZ3EySTJjZ1FIOU5rdW5CU3Q5?=
 =?utf-8?B?bkRVVi81cDdrRUdrOXhSdEsxdGxDaWprVDExRGdrM0ppajJXcGJJd0lIeGdI?=
 =?utf-8?B?Q2FuYVF4L3RVc0JMdUdOcnZRYndqSFpIRDByL0lzb3Zaa1lwak5zaFdsRFph?=
 =?utf-8?B?MUFhVGxaKzZzanRLT0d2M1ZHVSs5RHpqU25oYkxyZXJLTGRLblF4QjgzRWN5?=
 =?utf-8?B?azArNk1jZFUwV0Fkb2RhakN0YXhvUlhMMmx0Q2R1NXVhMGpZKzJxdGpoSGpw?=
 =?utf-8?B?RDNoQ1N2cHZqTE5NeFdJQ2duYjBZd3BDWDhOajFWME5KaE9QRC9pa2ZtOXJJ?=
 =?utf-8?B?dUFXc1plUHkrWHA3dVYvSERvaDVRcmk4RGZoTHRHVFBSZGN0UWpqYVAzeDlH?=
 =?utf-8?B?bE9FZ0w3WU0wdjRqeTZ3UGFpT3RsdnZ0c2RzcmZ6QkFxTzhSTXhhNEJFcWFG?=
 =?utf-8?B?ZHA5VCtpZ1BxMkFWbFVBY3BJdmFjY01SYjVoTVpwY1JmbEJUUDNrYUhmOVVZ?=
 =?utf-8?B?aThmYkE2TjhaczA0bG8zSFJ1TFNXb2ZJeTRTenAwdlNmQWhZaDhJMFgvU0l1?=
 =?utf-8?B?Z0Ztakp4dVFHZzJIL3RsdUZuVTNuUUFKT1VWcUxMZUoxZmd2aG5mYlBKdUZI?=
 =?utf-8?B?U2tIcnF2ZDg1M25ZQUErcG1odzd3WFhFWjg5dlhuL211QWttTU5WaXBnTTJh?=
 =?utf-8?B?dUcxWGFlVjdDSTUycXdXZnAxRnUyM0xpYTF2Mk91MVY4MDZGS2huTEFBaW5N?=
 =?utf-8?B?ZkpTQVFVU1NUZTMvQjYxQmJzcjdmT29qZ0k2K0o4SHZ1MERMcENKZGtlZlQ1?=
 =?utf-8?B?Z0pGbmhGbldzOEJidVR1SXZRUXhlZXNmZXVtMTNzanNuY09DTGhjek5pZ1cy?=
 =?utf-8?B?VjFlWVc1SEMvLzFBWFVSKzYzV0lUU1VFVkNzejE1WVdvUDNQaW83M1ZiZjlp?=
 =?utf-8?B?WHMxaUZCZlhMNDdjazN2QXpFQjl3cTJRWTdyamVOSnNFUWM4alVSVWQxbkJX?=
 =?utf-8?Q?b+zoTcfT+qSqaMZkmOh2dNZqj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a5fcc9-e172-4139-a868-08dcdc8f4103
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 11:51:40.8588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jHuST/l8b0zBhnKUUwg0A1rvma53bneeJx/YJRP6kMNXRAt8OfJSR/m05HIWY+QZ4sT+m6eN1Wrd3hU6DMX8goVWewZpToCqMEjJD0HtuHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9517

SGkgTWFya3VzIEVsZnJpbmcsDQoNClRoYW5rcyBmb3IgdGhlIHBhdGNoLg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmt1cyBFbGZyaW5nIDxNYXJrdXMuRWxmcmlu
Z0B3ZWIuZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyNCwgMjAyNCAxMjozNSBQTQ0K
PiBTdWJqZWN0OiBbUEFUQ0hdIHJlZ3VsYXRvcjogQ2FsbCBvZl9ub2RlX3B1dCgpIG9ubHkgb25j
ZSBpbiByemcybF91c2JfdmJ1c19yZWd1bGF0b3JfcHJvYmUoKQ0KPiANCj4gRnJvbTogTWFya3Vz
IEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0Pg0KPiBEYXRlOiBUdWUsIDI0
IFNlcCAyMDI0IDEzOjIxOjUyICswMjAwDQo+IA0KPiBBbiBvZl9ub2RlX3B1dChjb25maWcub2Zf
bm9kZSkgY2FsbCB3YXMgaW1tZWRpYXRlbHkgdXNlZCBhZnRlciBhIHBvaW50ZXIgY2hlY2sgZm9y
IGENCj4gZGV2bV9yZWd1bGF0b3JfcmVnaXN0ZXIoKSBjYWxsIGluIHRoaXMgZnVuY3Rpb24gaW1w
bGVtZW50YXRpb24uDQo+IFRodXMgY2FsbCBzdWNoIGEgZnVuY3Rpb24gb25seSBvbmNlIGluc3Rl
YWQgZGlyZWN0bHkgYmVmb3JlIHRoZSBjaGVjay4NCj4gDQo+IFRoaXMgaXNzdWUgd2FzIHRyYW5z
Zm9ybWVkIGJ5IHVzaW5nIHRoZSBDb2NjaW5lbGxlIHNvZnR3YXJlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0Pg0KDQpS
ZXZpZXdlZC1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KDQpDaGVl
cnMsDQpCaWp1DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3JlZ3VsYXRvci9yZW5lc2FzLXVzYi12YnVz
LXJlZ3VsYXRvci5jIHwgNyArKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVndWxhdG9y
L3JlbmVzYXMtdXNiLXZidXMtcmVndWxhdG9yLmMgYi9kcml2ZXJzL3JlZ3VsYXRvci9yZW5lc2Fz
LXVzYi12YnVzLQ0KPiByZWd1bGF0b3IuYw0KPiBpbmRleCA0ZWNlYjZiNTQ0OTcuLmRlYzdjYWM1
ZThkNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9yZWd1bGF0b3IvcmVuZXNhcy11c2ItdmJ1cy1y
ZWd1bGF0b3IuYw0KPiArKysgYi9kcml2ZXJzL3JlZ3VsYXRvci9yZW5lc2FzLXVzYi12YnVzLXJl
Z3VsYXRvci5jDQo+IEBAIC00OSwxMyArNDksMTAgQEAgc3RhdGljIGludCByemcybF91c2JfdmJ1
c19yZWd1bGF0b3JfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJcmV0
dXJuIGRldl9lcnJfcHJvYmUoZGV2LCAtRU5PREVWLCAicmVndWxhdG9yIG5vZGUgbm90IGZvdW5k
XG4iKTsNCj4gDQo+ICAJcmRldiA9IGRldm1fcmVndWxhdG9yX3JlZ2lzdGVyKGRldiwgJnJ6ZzJs
X3VzYl92YnVzX3JkZXNjLCAmY29uZmlnKTsNCj4gLQlpZiAoSVNfRVJSKHJkZXYpKSB7DQo+IC0J
CW9mX25vZGVfcHV0KGNvbmZpZy5vZl9ub2RlKTsNCj4gKwlvZl9ub2RlX3B1dChjb25maWcub2Zf
bm9kZSk7DQo+ICsJaWYgKElTX0VSUihyZGV2KSkNCj4gIAkJcmV0dXJuIGRldl9lcnJfcHJvYmUo
ZGV2LCBQVFJfRVJSKHJkZXYpLA0KPiAgCQkJCSAgICAgIm5vdCBhYmxlIHRvIHJlZ2lzdGVyIHZi
dXMgcmVndWxhdG9yXG4iKTsNCj4gLQl9DQo+IC0NCj4gLQlvZl9ub2RlX3B1dChjb25maWcub2Zf
bm9kZSk7DQo+IA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAtLQ0KPiAyLjQ2LjENCg0K

