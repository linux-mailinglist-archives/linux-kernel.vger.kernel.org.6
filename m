Return-Path: <linux-kernel+bounces-538949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E74AA49F21
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E9A7A2D90
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986EB276042;
	Fri, 28 Feb 2025 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="QoHiDxdJ"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010009.outbound.protection.outlook.com [52.103.68.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DEC1A5BA4;
	Fri, 28 Feb 2025 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760882; cv=fail; b=azzgq6Shzb33CTLnSq6ZNbiUeBOMjF2O77jKHTMsxyv00M0bDbK4vR+cdtxhJ5aMaV6gl/HAQXwjXmKzcRv/XqWwo3yO54ypfSPCicp7wgC9patIptFmOSYnU4CZvWl5/Wjl7HMru1k4+fTGCn777WDUslqmgwb1+aNKA9uGSY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760882; c=relaxed/simple;
	bh=CuiDCg5aRpA9uzUHs8n2igRh1b1xP+m5eAxP6LJlwfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jWsIuqc0djCKWlW+LAPcd3kcwpRM1jAr+Nto8VXDjuRqkJC7CyHLHtPPS+Fi8kEx5ecsitH+WZdcHy7B1xD3h0TBuAFNceZjODUKgw2SwmynDXqD15nvVbG4WEFfm8PKyPJWctix/lz5CFnTSB0JkhJ237B6Br+xRRsF4zhhAZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=QoHiDxdJ; arc=fail smtp.client-ip=52.103.68.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koT/nkh44M9jIfswqO8jQ0pBjtP/9VczjhsNSTDX+YjnrPlc8sym9IV57VUyQQ/Hg/rBNkxeBp8RrB7LW9lnKwjS5+0gLZUgvkbMe4WpIXjVFsluDiBLFjp8n5+U7iPauGS0WkraG48tf0OoAja+i22kQDtwsQ1nK8vaHefapgRLdj+zxb0MzibQiAeFMj14T20TGqtk+mzhAdCPHB7fCtVI4OhdgZsxtTPsMFszPcjc96hZ3jLgUeE/AiQylr7582DM3ViZKqq57o7cCWfSCPdHzXHl+UiUVSD0th31vBz21pdLIg7VnpxezTtjnpp6W/0jfPB54FU77mp+BC2g9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuiDCg5aRpA9uzUHs8n2igRh1b1xP+m5eAxP6LJlwfI=;
 b=VHa/ml8RrO3dPms9kiP5j7vcAltM65/vZXjbQMOS1VpvpjD/JdYKAXg9YfQpU7jUvAELKdNZSLnTYZ/i4vKihzBwQs04aBJeZYJ1+970D4w+pjkILLgZtJ4QLuQoA9Ly1Kr0pVAt4Fj6eOGzv7OqAyaKGqZg0wPBREezjcFVKev9zW+huslKeZiEKmmcnrXJTrm1CjHf/XNcfu7aMyQKuNg7/MB7t15Idjqkwj2G3cr52GTiZXMWTWp3H43yZSc+wMH8vNSukkMhpeKdkMNH1jOkoTE8zud6jiRxEiyldK+OvttpWXnrAWa8EaEIbAHAI6NFue41Tu095ixBN77uiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuiDCg5aRpA9uzUHs8n2igRh1b1xP+m5eAxP6LJlwfI=;
 b=QoHiDxdJe7aRMybbS4K+KHfSOZIbUs+sTeS1sXupXaryYSNasvu4BHgVQyz+Bbc2FzIB/uOKZuXQ4Xx95vnmnMw6XQfAigJjQ6mO7Hvznr+Ys+8AIcjfazgec5yxx8kbjefClLG1ODMtJiwMeqTFAkae2DAaeblTBISOQzylRDI/nAMSn9UAAd5WdMHnIOXO0CdKYh7hOcurm+eSe7yizZieZHNTa6BixhEZ9OGh096B4huRtp80sE1b7fkqdBHVi9ysTKXsTggEMc6kPE7kue4H0JIcpL7DBnC4pPBRqwyVKna7wULaeFXA9lD2Ago6V21x/InEWm5ihE5VVp5VJA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB9048.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 16:41:11 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 16:41:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, "apw@canonical.com" <apw@canonical.com>,
	"joe@perches.com" <joe@perches.com>, "dwaipayanray1@gmail.com"
	<dwaipayanray1@gmail.com>, "lukas.bulwahn@gmail.com"
	<lukas.bulwahn@gmail.com>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Hector Martin
	<marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, Janne Grunau
	<j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Asahi Linux Mailing
 List <asahi@lists.linux.dev>
Subject: Re: [PATCH v5] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
Thread-Topic: [PATCH v5] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
Thread-Index: AQHbif3mc9j8yKPpukK7n8PE6iWbd7Nc6xwA
Date: Fri, 28 Feb 2025 16:41:11 +0000
Message-ID: <AD17906E-5848-4274-B732-C97A7FECE900@live.com>
References: <2C9622E6-A2DB-4681-A971-604C79F9955E@live.com>
In-Reply-To: <2C9622E6-A2DB-4681-A971-604C79F9955E@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB9048:EE_
x-ms-office365-filtering-correlation-id: f3bf1a90-8394-47c8-b964-08dd5816b5b0
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|7092599003|461199028|8062599003|19110799003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?RW5keVpoWkhqVEZjSlU2SXRaRHZVY0djYkNWNWcwYXJlSlJpSlpsVnJUZkwr?=
 =?utf-8?B?ZlhOQ2xFMlo4SW5YdElQUndWNllJaUw5ZENEZlpoUXZyMSt2QlNVSzBqcW5j?=
 =?utf-8?B?OGNKRGN4b3o2TERydGVESk9pM1NrUnMzbUEzanM1Zk1CREMrSFJPOUtJZnM2?=
 =?utf-8?B?ODZaYmtadlVwcmtCZzBoNHR0SmE1dFEvb29qcGdLVlpTNi9XQ1dQTU5haGds?=
 =?utf-8?B?cHFZVHVsUmNWZGh1UWp2M2grcVJvbVRkbEVJNVB6VU4xczk1VTFZbVJpbjRU?=
 =?utf-8?B?dU9CRStoYzdzZWpXajkrbTFDWEhFMUM4WE9abFUzWFpuV052TVpTcENiS3RO?=
 =?utf-8?B?aS9LbHlZSytHMmpqemd2NWJ4QU9TSnlMK3lSOXBuZUhjZVEzaUtYRmZ3RWVD?=
 =?utf-8?B?aHJSdDlmYUtoZC8raXMwY2NER3JzTFBraVNXbDZTOWEvbVVuQXBoajl3UGYr?=
 =?utf-8?B?N0g4UHp0aWI4Z3V4ejZnVVJRV0E3YmF1cVY0K3BjblBnREo2MEp5akhxaklh?=
 =?utf-8?B?WkdPc1p0RXRCT0tVOXh6dHVEc0FGd3dmeWVlNlFBN0ZjaTlZMVZXa2c1WDIv?=
 =?utf-8?B?eXd5aGttalNoMkx1K0RGaTJvc3lVWmJTYUExWm5oTS9ha2EzYWFxVFJUQVNZ?=
 =?utf-8?B?ZXU2T2QzNTlGMWFPY3o0TUQ2S2xYWE8rTlZ5bC92UmxVejNsck43NlNtWEIw?=
 =?utf-8?B?Z2RWSHVrZGczWlpvMUV2R1gwS0ZWZUluT2xDSm9sM0czWkE4S0tmcy82VC9C?=
 =?utf-8?B?UUp2eGtLUkU0K3hHeitSTDIxekpGdUNOdVFKTnVuSi94aHdmcUJJbCtHVnYv?=
 =?utf-8?B?VU1IVUN1VWIvQmF1NUNUN3VrblFNRlU0Tkk4a3Y1cEp3L203RS9aRW9PdUFa?=
 =?utf-8?B?TzdxOUxWQUlwUVpxV3hlaHRrd2hUNnY4M3pETUpjVWVyOUszUHVWMytLSDQ1?=
 =?utf-8?B?TlowRlNUUEJFaVZGQ0xzYjU1cDk0OFY2TWJpdHZSZ203THdVS25HWnNWQkdZ?=
 =?utf-8?B?YUpkYk9oWFpybHpHN0ZJR3dJOHh4NFlDOUhaQ2k3Ukw5T3RWdGpRWm9lMmxX?=
 =?utf-8?B?TVYxbVdHb2s0NG1BNkNPRTlVNTFXbXhSOXNxTEZzZHR2cXdHdFo0Y1pZTmxK?=
 =?utf-8?B?K2tpWm10bTQ2TWJQOEIvdkxKREtWaU5kTTVyakw0TE43QWpLbW1JVXVXOE5h?=
 =?utf-8?B?eThQb2hhQlFxa05rVDNIT0ZyUlpmQ0VTa1BLdGdBWVNhT04wSEdjaGc4YmVx?=
 =?utf-8?B?SVlnanY3VGFDUjdTcnlxSE1Zdjd2S3A2Y3RBVzZzYnByTytweWFrTDZkVjJL?=
 =?utf-8?B?SHA1SlRuMm96ekkrUmplVFkyNktaelFxaWJZN1F6MXhMcEdwcXVkOHo4NjVa?=
 =?utf-8?B?SXlwVjJEWVpvSlUrdytWcFY1aUFUczhZQWtWL1lzM2RoQ1A5UXNHKytFbU93?=
 =?utf-8?B?M05BaFdWWnJiVE9ZaEZmMWIyZ3JiRDNvMExIVWhRPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXNjTE5pZkVxcHZjdXdQMTVCbkpFbmZ1R2hFT2FWaERXVWhpQ0ZveTVWR2lw?=
 =?utf-8?B?QnN5bU5JMURuekJsK243T0NIR1dKdkkzc3RKajZ0akJPQ0tNMGYvWHp0RHVZ?=
 =?utf-8?B?RWduUU0yeWtUN1pSRkhIb2dhTEFJbzJnNlVUSy9Rek4wbUNLT1V4eDQrcFRU?=
 =?utf-8?B?UVZxNEpSTVFGbUFpZ29UaE02bzBIM2JZNE82UWE0MnZ5ekU0TFFIb1VpaWQ4?=
 =?utf-8?B?Tm1zbWNsK2JSQndtTi8vSVJva2RxZzRaYjUxT01xdi9DcnB3RUpkNTcvZDZC?=
 =?utf-8?B?THN5ZXFQdlhIQkttSUdHcFRvMTV3eEdYUi85ZDhNRTdraWgzdmdtK1RtMFh4?=
 =?utf-8?B?Y2UvbHBEOHJkUlpFeldkdDl6d3Z2WEZtNm0yalk3NVJlZTFTcnY1STNna2tv?=
 =?utf-8?B?VTBueTBjcG5DK3VyTzZLbE4wQmM5aWtFMHhkc0pqa1NkakRGTG5qQ2lIOVo5?=
 =?utf-8?B?YksxWlo0OWE4MHdJUjNhMlgxMm11QitkSU5Rd3Z3Z0luSHZtYTg1cVhqTVI2?=
 =?utf-8?B?ZTlBeWJ1aUZhK1QrWVhoYWs0S0FvYkdaVXNmL0FKaVFBQmM0SHl5UllZTGZK?=
 =?utf-8?B?QWkzN1VXMjFlVE9Oa2ozaEtvMWc2azdlTzA2UmJaUVV5Q2VvSlF2N09SdjQv?=
 =?utf-8?B?SHhhalFlMlJlYVAzODlNU0RaT01nL2pJZ0grVWFXWVZGTENQdk1LODJQb2d2?=
 =?utf-8?B?bnhTTUNJRjBXODVveGwxaVIyVjBPTTZtVldMYlJEczl3Q2FCcmVOYmlWdUpz?=
 =?utf-8?B?aVNLZWtGQnRPV2tGdTlSUDhOcFNrZVFRZUxwemRSK05aME9VRlY4UHZKVEpN?=
 =?utf-8?B?b1dDcTliUlhidUhFZjR0UGZxU082Y0hMcTd5WnlBNURtMWFGK0loRk5FakR2?=
 =?utf-8?B?MGk5QlVMcC9tUTAvQURlL2pHelBOdHdBMk5ZbzM1enQwWFR1ZGhRdU5vQ21n?=
 =?utf-8?B?MG1QMkhtKzlMU1Z0a3NGdzRmdFgxdnJHbkczeUJuTkQvYVRmZzQ4UGNSQkV5?=
 =?utf-8?B?dHFkZURLMGx6QVFILzVxMmRhQ0hxUkxQRTNwekZUcE5IOS9KN2dwQURDQlRv?=
 =?utf-8?B?cFloVEMzOXB1MkwrNHVaZXk1c1YrYmlmb0R6bFJTMnJTM1pMOFhaNnNIQUJL?=
 =?utf-8?B?QjVZbXhxQWRUZnR5b285c2J0SUIzUVVqVkhCYUc5WG4vZUJ0eVJFQ3EycXpZ?=
 =?utf-8?B?WVhkRUpERkpwdGh1bTNTNEw2U2daUW1xanJ4ZFI0Z1ArUnZSWkIzQ0Fac1NJ?=
 =?utf-8?B?S3V4WXJwcE9sWGtsd2V4dmR6TkJPTlJpVnE1aEZtaEpMcW9sTlBFT1dLc2Jh?=
 =?utf-8?B?T0hsL1NXNEU3cW5rREZsLy9INDA2R01tOTdFNlRzZFNDL2U2WTU2L251UVN6?=
 =?utf-8?B?WTdTOFM1TERKK24yanh6NzZ6aXg4c2NEV2x6QW1VL0pZTWZVWlRDejY0VE9X?=
 =?utf-8?B?VUFwOFJTakF3aW5UUTNBQ1ZlVzFkL3J1b1pHMENGWWFnTU8xbnNiMGpTazVD?=
 =?utf-8?B?U01STlU1U0cwT3pJdEEwUjEvWGJXZ3NIQmd4eTAzVG9oZE56T3QvZGVKdW5x?=
 =?utf-8?B?UGMwanRFeFhpUVVIbU5YR0lUbkt1YW1iWUp5Y0xZeTdxRk5ORWw0Q1FyR3E5?=
 =?utf-8?B?Z21ybzQ4aFBmVlQ1MGJuK0F0NCtSREtET3lwNjJlcFRzUDEyL0NNdXdYNDNS?=
 =?utf-8?B?MHdmQy9tQ1UweFNNbXdtdDlzUEVZM1dHbGlWamdLMVY2STF4a2FaeHE0OXhV?=
 =?utf-8?Q?yKl+9PZP7fboJVJmSh9fbKfP8rw8W46fHTG/Cp3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA3993444083244285F31EF45865A9CB@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bf1a90-8394-47c8-b964-08dd5816b5b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 16:41:11.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9048

DQoNCj4gT24gMjggRmViIDIwMjUsIGF0IDk6NTnigK9QTSwgQWRpdHlhIEdhcmcgPGdhcmdhZGl0
eWEwOEBsaXZlLmNvbT4gd3JvdGU6DQo+IA0KPiBGcm9tOiBIZWN0b3IgTWFydGluIDxtYXJjYW5A
bWFyY2FuLnN0Pg0KPiANCj4gJXA0Y2MgaXMgZGVzaWduZWQgZm9yIERSTS9WNEwyIEZvdXJDQ3Mg
d2l0aCB0aGVpciBzcGVjaWZpYyBxdWlya3MsIGJ1dA0KPiBpdCdzIHVzZWZ1bCB0byBiZSBhYmxl
IHRvIHByaW50IGdlbmVyaWMgNC1jaGFyYWN0ZXIgY29kZXMgZm9ybWF0dGVkIGFzDQo+IGFuIGlu
dGVnZXIuIEV4dGVuZCBpdCB0byBhZGQgZm9ybWF0IHNwZWNpZmllcnMgZm9yIHByaW50aW5nIGdl
bmVyaWMNCj4gMzItYml0IEZvdXJDQ3Mgd2l0aCB2YXJpb3VzIGVuZGlhbiBzZW1hbnRpY3M6DQo+
IA0KPiAlcDRjaCBIb3N0LWVuZGlhbg0KPiAlcDRjbiBSZXZlcnNlLWVuZGlhbg0KPiAlcDRjbCAg
IExpdHRsZS1lbmRpYW4NCj4gJXA0Y2IgQmlnLWVuZGlhbg0KPiANCj4gVGhlIGVuZGlhbm5lc3Mg
ZGV0ZXJtaW5lcyBob3cgYnl0ZXMgYXJlIGludGVycHJldGVkIGFzIGEgdTMyLCBhbmQgdGhlDQo+
IEZvdXJDQyBpcyB0aGVuIGFsd2F5cyBwcmludGVkIE1TQnl0ZS1maXJzdCAodGhpcyBpcyB0aGUg
b3Bwb3NpdGUgb2YNCj4gVjRML0RSTSBGb3VyQ0NzKS4gVGhpcyBjb3ZlcnMgbW9zdCBwcmFjdGlj
YWwgY2FzZXMsIGUuZy4gJXA0Y24gd291bGQNCj4gYWxsb3cgcHJpbnRpbmcgTFNCeXRlLWZpcnN0
IEZvdXJDQ3Mgc3RvcmVkIGluIGhvc3QgZW5kaWFuIG9yZGVyDQo+IChvdGhlciB0aGFuIHRoZSBo
ZXggZm9ybSBiZWluZyBpbiBjaGFyYWN0ZXIgb3JkZXIsIG5vdCB0aGUgaW50ZWdlcg0KPiB2YWx1
ZSkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIZWN0b3IgTWFydGluIDxtYXJjYW5AbWFyY2FuLnN0
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxpdmUuY29tPg0K
PiAtLS0NCj4gdjIgLT4NCj4gLSBBZGQgdGhpcyBwYXRjaCB0byBhcHBsZXRiZHJtIHBhdGNoc2V0
DQo+IA0KPiB2MyAtPg0KPiAtIE1ha2UgYXJyYXkgc3RhdGljDQo+IA0KPiB2NCAtPg0KPiAtIEZp
eCBjb2RlIGVycm9yDQo+IC0gRml4IHNwYXJzZSB3YXJuaW5ncw0KPiAtIE1ha2UgdGhpcyBwYXRj
aCBzZXBhcmF0ZSBmcm9tIGRybQ0KPiANCj4gdjUgLT4NCj4gLSBJbXByb3ZlIGRvY3VtZW50YXRp
b24NCj4gLSBVc2UgYmV0dGVyIGxvZ2ljIHRvIGFzc2lnbiB2YWx1ZSBvZiB2YWwNCj4gLSBVc2Ug
J24nIGluc3RlYWQgb2YgJ3InIGZvciByZXZlcnNlIGVuZGlhbg0KPiAtIFVzZSBBUlJBWV9TSVpF
KCkgaW5zdGVhZCBvZiBoYXJkY29kaW5nIDENCj4gDQo+IERvY3VtZW50YXRpb24vY29yZS1hcGkv
cHJpbnRrLWZvcm1hdHMucnN0IHwgMzIgKysrKysrKysrKysrKysrKysrKw0KPiBsaWIvdGVzdF9w
cmludGYuYyAgICAgICAgICAgICAgICAgICAgICAgICB8IDM5ICsrKysrKysrKysrKysrKysrKyst
LS0tDQo+IGxpYi92c3ByaW50Zi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMzUgKysr
KysrKysrKysrKysrKy0tLS0NCj4gc2NyaXB0cy9jaGVja3BhdGNoLnBsICAgICAgICAgICAgICAg
ICAgICAgfCAgMiArLQ0KPiA0IGZpbGVzIGNoYW5nZWQsIDk0IGluc2VydGlvbnMoKyksIDE0IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vY29yZS1hcGkvcHJp
bnRrLWZvcm1hdHMucnN0IGIvRG9jdW1lbnRhdGlvbi9jb3JlLWFwaS9wcmludGstZm9ybWF0cy5y
c3QNCj4gaW5kZXggZWNjY2MwNDczLi4xNDg1MzI5NWEgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50
YXRpb24vY29yZS1hcGkvcHJpbnRrLWZvcm1hdHMucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24v
Y29yZS1hcGkvcHJpbnRrLWZvcm1hdHMucnN0DQo+IEBAIC02NDgsNiArNjQ4LDM4IEBAIEV4YW1w
bGVzOjoNCj4gJXA0Y2MgWTEwICBsaXR0bGUtZW5kaWFuICgweDIwMzAzMTU5KQ0KPiAlcDRjYyBO
VjEyIGJpZy1lbmRpYW4gKDB4YjIzMTU2NGUpDQo+IA0KPiArR2VuZXJpYyBGb3VyQ0MgY29kZQ0K
PiArLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiArDQo+ICs6Og0KPiArICVwNGNbaG5sYl0gZ1AwMCAo
MHg2NzUwMzAzMCkNCj4gKw0KPiArUHJpbnQgYSBnZW5lcmljIEZvdXJDQyBjb2RlLCBhcyBib3Ro
IEFTQ0lJIGNoYXJhY3RlcnMgYW5kIGl0cyBudW1lcmljYWwNCj4gK3ZhbHVlIGFzIGhleGFkZWNp
bWFsLg0KPiArDQo+ICtUaGUgZ2VuZXJpYyBGb3VyQ0MgY29kZSBpcyBhbHdheXMgcHJpbnRlZCBp
biB0aGUgYmlnLWVuZGlhbiBmb3JtYXQsDQo+ICt0aGUgbW9zdCBzaWduaWZpY2FudCBieXRlIGZp
cnN0LiBUaGlzIGlzIHRoZSBvcHBvc2l0ZSBvZiBWNEwvRFJNIEZvdXJDQ3MuDQo+ICsNCj4gK1Ro
ZSBhZGRpdGlvbmFsIGBgaGBgLCBgYG5gYCwgYGBsYGAsIGFuZCBgYGJgYCBzcGVjaWZpZXJzIGRl
ZmluZSB3aGF0DQo+ICtlbmRpYW5uZXNzIGlzIHVzZWQgdG8gbG9hZCB0aGUgc3RvcmVkIGJ5dGVz
LiBUaGUgZGF0YSBtaWdodCBiZSBpbnRlcnByZXRlZA0KPiArdXNpbmcgdGhlIGhvc3QtZW5kaWFu
LCByZXZlcnNlLWhvc3QtZW5kaWFuLCBsaXR0bGUtZW5kaWFuLCBvciBiaWctZW5kaWFuLg0KPiAr
DQo+ICtQYXNzZWQgYnkgcmVmZXJlbmNlLg0KPiArDQo+ICtFeGFtcGxlcyBmb3IgYSBsaXR0bGUt
ZW5kaWFuIG1hY2hpbmUsIGdpdmVuICYodTMyKTB4Njc1MDMwMzA6Og0KPiArDQo+ICsgJXA0Y2gg
Z1AwMCAoMHg2NzUwMzAzMCkNCj4gKyAlcDRjbiAwMFBnICgweDMwMzA1MDY3KQ0KPiArICVwNGNs
IGdQMDAgKDB4Njc1MDMwMzApDQo+ICsgJXA0Y2IgMDBQZyAoMHgzMDMwNTA2NykNCj4gKw0KPiAr
RXhhbXBsZXMgZm9yIGEgYmlnLWVuZGlhbiBtYWNoaW5lLCBnaXZlbiAmKHUzMikweDY3NTAzMDMw
OjoNCj4gKw0KPiArICVwNGNoIGdQMDAgKDB4Njc1MDMwMzApDQo+ICsgJXA0Y24gMDBQZyAoMHgz
MDMwNTA2NykNCj4gKyAlcDRjbCAwMFBnICgweDMwMzA1MDY3KQ0KPiArICVwNGNiIGdQMDAgKDB4
Njc1MDMwMzApDQo+ICsNCj4gUnVzdA0KPiAtLS0tDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGliL3Rl
c3RfcHJpbnRmLmMgYi9saWIvdGVzdF9wcmludGYuYw0KPiBpbmRleCA1OWRiZTRmOWEuLjgwZDlm
ZDM3NCAxMDA2NDQNCj4gLS0tIGEvbGliL3Rlc3RfcHJpbnRmLmMNCj4gKysrIGIvbGliL3Rlc3Rf
cHJpbnRmLmMNCj4gQEAgLTc3NiwyMSArNzc2LDQ2IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBmd25v
ZGVfcG9pbnRlcih2b2lkKQ0KPiBzb2Z0d2FyZV9ub2RlX3VucmVnaXN0ZXJfbm9kZV9ncm91cChn
cm91cCk7DQo+IH0NCj4gDQo+ICtzdHJ1Y3QgZm91cmNjX3N0cnVjdCB7DQo+ICsgdTMyIGNvZGU7
DQo+ICsgY29uc3QgY2hhciAqc3RyOw0KPiArfTsNCj4gKw0KPiArc3RhdGljIHZvaWQgX19pbml0
IGZvdXJjY19wb2ludGVyX3Rlc3QoY29uc3Qgc3RydWN0IGZvdXJjY19zdHJ1Y3QgKmZjLCBzaXpl
X3QgbiwNCj4gKyAgICAgICBjb25zdCBjaGFyICpmbXQpDQo+ICt7DQo+ICsgc2l6ZV90IGk7DQo+
ICsNCj4gKyBmb3IgKGkgPSAwOyBpIDwgbjsgaSsrKQ0KPiArIHRlc3QoZmNbaV0uc3RyLCBmbXQs
ICZmY1tpXS5jb2RlKTsNCj4gK30NCj4gKw0KPiBzdGF0aWMgdm9pZCBfX2luaXQgZm91cmNjX3Bv
aW50ZXIodm9pZCkNCj4gew0KPiAtIHN0cnVjdCB7DQo+IC0gdTMyIGNvZGU7DQo+IC0gY2hhciAq
c3RyOw0KPiAtIH0gY29uc3QgdHJ5W10gPSB7DQo+ICsgc3RhdGljIGNvbnN0IHN0cnVjdCBmb3Vy
Y2Nfc3RydWN0IHRyeV9jY1tdID0gew0KPiB7IDB4MzIzMTU2NGUsICJOVjEyIGxpdHRsZS1lbmRp
YW4gKDB4MzIzMTU2NGUpIiwgfSwNCj4geyAweGIyMzE1NjRlLCAiTlYxMiBiaWctZW5kaWFuICgw
eGIyMzE1NjRlKSIsIH0sDQo+IHsgMHgxMDExMTIxMywgIi4uLi4gbGl0dGxlLWVuZGlhbiAoMHgx
MDExMTIxMykiLCB9LA0KPiB7IDB4MjAzMDMxNTksICJZMTAgIGxpdHRsZS1lbmRpYW4gKDB4MjAz
MDMxNTkpIiwgfSwNCj4gfTsNCj4gLSB1bnNpZ25lZCBpbnQgaTsNCj4gKyBzdGF0aWMgY29uc3Qg
c3RydWN0IGZvdXJjY19zdHJ1Y3QgdHJ5X2NoID0gew0KPiArIHsgMHg0MTQyNDM0NCwgIkFCQ0Qg
KDB4NDE0MjQzNDQpIiwgfSwNCj4gKyB9Ow0KPiArIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZm91cmNj
X3N0cnVjdCB0cnlfY24gPSB7DQo+ICsgeyAweDQxNDI0MzQ0LCAiRENCQSAoMHg0NDQzNDI0MSki
LCB9LA0KPiArIH07DQo+ICsgc3RhdGljIGNvbnN0IHN0cnVjdCBmb3VyY2Nfc3RydWN0IHRyeV9j
bCA9IHsNCj4gKyB7IGxlMzJfdG9fY3B1KDB4NDE0MjQzNDQpLCAiQUJDRCAoMHg0MTQyNDM0NCki
LCB9LA0KPiArIH07DQo+ICsgc3RhdGljIGNvbnN0IHN0cnVjdCBmb3VyY2Nfc3RydWN0IHRyeV9j
YiA9IHsNCj4gKyB7IGJlMzJfdG9fY3B1KDB4NDE0MjQzNDQpLCAiQUJDRCAoMHg0MTQyNDM0NCki
LCB9LA0KDQpVZ2gsIGhvdyBkaWQgdGhlIFtdIGdldCBydWluZWQgaGVyZSBub3cuIFByZXR0eSBz
dXJlIEkgYWRkZWQgdGhlbS4gQW55d2F5cywgSeKAmWxsIHdhaXQgZm9yIGEgcmV2aWV3IGluIGNh
c2UgbW9yZSBjaGFuZ2VzIGFyZSBuZWVkZWQgYXMgd2VsbC4NCg0K

