Return-Path: <linux-kernel+bounces-529456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65B8A426A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1E53BC7CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E8A23BD0D;
	Mon, 24 Feb 2025 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="GBqkQPng"
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C20F219300
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411184; cv=fail; b=l87dsPyS6+cXZ8MIDlYdLQHMsfzZTeYt+/ArlLbHXD9mj9PlJSCSbTCz4zce01GjiScTwNBft66VeEwtxSSVFVYtF2Tr0pPc7a8UhZqpTCaOjgjB+mqnqJAT05OmK/bzZ1O1Ur0U60Qc83t/xWmwRtm2SZWjFtIxjSqu1FMG8/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411184; c=relaxed/simple;
	bh=70ZZYfm0AH5BuNfH8AiR12cqiGkj23x0/e77z1pv1ro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qo7QcgHTM6LzQ+LC1FUtwMcjTiDOwY4Sw3miPlI8fUR215vhvJhSoDJLTy7+WJm8tI+wr3cXVS3IaG9OuHL5v4sk6CdyrHbOMhvdj6p6oe++xvez93GQxofWwwwZt4JKymTF/J8uPJYlMGM4UxBMH1NXqHKGaDHXRuEYPKTryjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=GBqkQPng; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niD1G0iFYxZ+aOJo0fYZRIZ8H5SJ3UqOdHzJVno5KeAW0m72wgIAghjz1MxS2pc8r8Ai3CvUhLYPjGSRu3MDxNGGUUDkuH2JW1Yx0Fvkvs3TrNE4b33i3f9J0Gr+xBfB01eLR9QTG8Ilui0uPUP6kDgwjfST5uQt93bXxuUc8cV6MrqYuleIZXBzaTr/+MbiqPuW78eMLpSFkd4ep1FBZ2FzE8Jb7AnpKZs1J17SavwL9HxrL7IDNBHIfQYP2hXrAwspNXspAUuFD59zfRDvZcumAYpF4MkpHNQFJvgE1WREapZNow9FSAWrq0BJAxRfXQq4Uq5qz+h2yJiw6dfjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70ZZYfm0AH5BuNfH8AiR12cqiGkj23x0/e77z1pv1ro=;
 b=sU0fXGq2qmkojew7aBJQUWeK9QCl1cDHqxqHsYg5mVIuPBZL5LKkv3KC42kzQEH4DPtu37H9H0Fo73gNoeVmejbBS8DodEMHiHSy0pzAtD+nrEX1f8kKh6ogp3G2sP4zSXRN83mkoR7FYx4clTL8W28u6fjSyxUvaXmcr8lkOa3cT/oaioskXptEJLpOWVCzOEtMn2YFDIv6+CdbjEa+Ol0nIpi8+E9UK4XfCSwoWg6s0jhLxZ/g7Ng7NipLwWFquBU/KQJz616yNC3NC4E02j+DxvZ4s8hB6DHTl5DYlPzfw5Waui9FflaVHBmumlPOrkXx/YXcTCWqY3RIV9ZPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70ZZYfm0AH5BuNfH8AiR12cqiGkj23x0/e77z1pv1ro=;
 b=GBqkQPngFUi1T4DUPXenFv3U8a09e3n2o7RhmDBluMt7QYoHNpJsTrXg4ZFgBlM9a+3rsBT0XNgE38w2UGW94N9AbC8WNGqCjYQ5ZGq2voFejwTkFssUeGCQVomNoFgo6VWtdYAqP9pBga51vFZVSupGh8ySKmYQdbexXF/ciduqB/QD+pEVj3B8CudcEHh1G0c0maV4Pd0OHtXqIImBcHa/AcnCrxEsrXkz0TfU8o1sooYziftTYuCnpKr257HDhdVu+SYUE6BC7+dfthWe8gNZ47OC/wQkXpFEwA38R6wpuAXtMwUWPCC/p9BlNuJkTLydkeQXPCNaqGituHSP1Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB7569.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:2a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 15:32:57 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 15:32:56 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, Kerem Karabay <kekrby@gmail.com>,
	Atharva Tiwari <evepolonium@gmail.com>, Aun-Ali Zaidi <admin@kodeit.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Thread-Topic: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Thread-Index:
 AQHbhsGm46fWR/3mxEipqc6+PMbxkrNWe38AgAAI1YCAAAcMAIAAAaKAgAACOwCAAAJQAIAAA7BU
Date: Mon, 24 Feb 2025 15:32:56 +0000
Message-ID:
 <PN3PR01MB959729DB53C0D359F8A83292B8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <Z7yMIC1wxm0AGBCt@smile.fi.intel.com>
 <PN3PR01MB9597D4FD9FD8B8A8FB0F2B3CB8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB9597D4FD9FD8B8A8FB0F2B3CB8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB7569:EE_
x-ms-office365-filtering-correlation-id: 0225c21d-3eeb-4765-5be4-08dd54e88346
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|8060799006|15080799006|7092599003|19110799003|8062599003|461199028|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?NEhpS29EZ0Uya3ZjSU1EZUkxTGZCRlg4TjFyVnRpemNYNzZ2Y2J4NjVldXRi?=
 =?utf-8?B?L2ptbUh0SXc4eXQzRm1rS1JYbVdoamZQZ1NicStlRTZPVzFSLzhRV3p3V0FO?=
 =?utf-8?B?MVRBd01VaUNOQjNwaHdLSGxjRUNHa24rL1pxaHdqNlh2R0o1eWdXalV5eVJs?=
 =?utf-8?B?NHZYUVRWUXBIV0F1NW1jVUZKT1BqbkJyUERqdm9qM2ZPcnVibmprT1RaaDZR?=
 =?utf-8?B?YW9WOThwbHkxVEVWTnV2WEN2V3E5M0NpTjVYaExPbVBPeS9ySCttY1dCRUpl?=
 =?utf-8?B?VXBjSnlSL1FiSWtGRnVQMmtGZXZ4U3g4emJvU0Q2K05jb0kzdm1qRnArQTNk?=
 =?utf-8?B?V2YzSVpmbTdIZ3cybHhoeDlTaU0zemRWMGQ3TzZOdEpLMXJiYWRMMDlpeGs0?=
 =?utf-8?B?emtoVnFKemc0ZndBZUVrUFlpN3kzNHNVdTd4YnFIak9EY2krY1ZZWFMvWjBO?=
 =?utf-8?B?REsrZmZ5aWQwWFBJUUVWQ1g5cFNZUHNldHdlanFuRlZlRlJYeU02R04xSHBz?=
 =?utf-8?B?bUozeENBaTlicWN3QXZaYzFDVjA5bXRVaFY1Um80QUVRd1h2ak9XVTlFQm1W?=
 =?utf-8?B?RmlYM0lIb2JGVXpzNXQ1cnlxKzU1ZitqZ0pmcVR1NEJyb1cwZnpWMU83YUhX?=
 =?utf-8?B?UXlmTk9iVjdJQkJYaHpTNm5CZmliRXFkemxFeXJoancyTit0MjRLemRVMkcv?=
 =?utf-8?B?U0J2T1pVQ0YrZ1NlSXpVQmJndlpCUFBEVUZTenJsSVY0Ly90NHhoeXYva3dp?=
 =?utf-8?B?MTFiSkowMEVTaVpKeG1FKzJDU1BSM1NKWjUwbm9ZSWhmdXp2MXVQSGZGdExM?=
 =?utf-8?B?aDE4T2MwVUgxSXhWQTdmeHQ1VWJFcitUb1YvQ0dxdHdpQTl1TEJaRjRwUE5y?=
 =?utf-8?B?L0JQbFBvM3BXdURzVlhDcG52cjNVQVdEUlNIK3d2Y29lekJCckxOR08wUW5D?=
 =?utf-8?B?QS8zZ3ZyWnJuenJEdU5oL0pVS1VKTVZPVGdseGZMUjhJZE00bFQyMGV6Wmtn?=
 =?utf-8?B?K1prR1Fibm8rZDVqbVZNcUhycVhUZUZMYnlvM1cxUmd2VXJuTHkyOHdkYU9t?=
 =?utf-8?B?QmdzeWUxNDkvK1ErclpBTW9HOGZaMzArcGVCT01LeDBRdXVMMVV3OEJDZzNs?=
 =?utf-8?B?dllzcjQzaXVQcloxWmlob3hlV3YvYjZ6a0c3L2VMVGxVSFBRMTdHY2t6WFpR?=
 =?utf-8?B?TCtuRVYrSmJ6c2JlZkU1ZElCMEFOb3VHWThWRjNHaHBCTFlHTVFZTHNPUjF5?=
 =?utf-8?B?OU1rY1FGbXBvR3hVZWRjQXJicnNPK2p1T0thUkp1Wm5SZWtkTHVrV3JXQU9Z?=
 =?utf-8?B?V1QrY1pXMkx0NmdZVjhsbXVlaUtKSWo5QlJKM2huUzNOYUhMam1rMmlpeWUv?=
 =?utf-8?B?WVBKandJZEtEZTBkTXkrMXhoN1JrV2I2K3lCbFdBME9oU0hoVGQ2K2Z5THNL?=
 =?utf-8?B?Qis3aW0wblNrSk1pZFpOa3lEcWhmV0lyamR5MVE2bjRxMmREZkUzTXhLS3cy?=
 =?utf-8?Q?AxlnBg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGtLaE5od3lSOXBFcXlURW81TjBLOS9neXk0RWVyWGgrcDhJdHd1TEJIWTRP?=
 =?utf-8?B?dTg5cDdOVGtkV3REODQ0b1FyYXIyano1cGhBNGI2RUFpNVZpUm5uWVRrSkMw?=
 =?utf-8?B?RTJjbWdtbDdjMzhVOUNmRjBpUEhYK0Y1OHpGUXNyUU4yRmZ3SzFrbWlhTVd4?=
 =?utf-8?B?SGMwNFVLbXZXdFlTUGlXbXhhOW94L3FtUXBRbmZranBIQy8yL0p4UGsvL0hK?=
 =?utf-8?B?S1BZTnh1eDdZbkovUmx4VVdpSVA0VDU0dlZuUUlxOVRQTWlkTG1Dd1QrNGsr?=
 =?utf-8?B?blVZWklMUDJYQml6ZGhKS2ZRcktKVlJhMXhvdFVpb0ZIZ1BVZWM0U09nblE4?=
 =?utf-8?B?QVBEUTBWTmRmYjZuV25CRXMxR051UW16WEhSQXhUdGVaTHRCaFVUMGlvS2tE?=
 =?utf-8?B?R04rQmRBU3U4RjRxODVRYWdSdE9sUngyQjRhYVBtWGFERENKNFFTUm5PN2J4?=
 =?utf-8?B?NmZjNlVBVGhuSmNYZ1JyWXJxYTVvSXVGODgwc3FTK1liNWM5VHNpUjZqd0cr?=
 =?utf-8?B?TFoyaTJKRmthVXNBWVJGa0RGTi95VUNSR3RyTW80aWF0Z2F2MFdLQnJwL0tQ?=
 =?utf-8?B?dFdFVXR6MkhrZGNoYldFNHNLRDRjYjNBTnllc0orMENVckRpR1JYakJPTUE2?=
 =?utf-8?B?NG5PdVVyVS82dG5kVGFOOFJUUWtjWURjVXJHNm85eVhuRk80cjJYZWRobDlO?=
 =?utf-8?B?UVd3eDYvYzZOdnY2ZTlEYTU0RmxpbWxyNkh1RmptengyL2lYS0tyZmRqUlRI?=
 =?utf-8?B?MFpyV2szcGkyTm9xT0FxMWxzQlI0Mkd3c2xlR3ZxaWY4RG0vRlZuTXVjL2xz?=
 =?utf-8?B?UjRoMWk4dWdJNFVObU1EOGpQTE5kUEthYmhYQkN6alZNRnhPdExwY1JjSm85?=
 =?utf-8?B?MmF0WnZtWGtkR2pDOHlNeHhHQTlFOWdvY3BsRUI2aFdDczA4R21BV2ZzcU4w?=
 =?utf-8?B?YmpMU0ZFMDlnZ2NJZFA5aGxsK2ROL3F2bVBCSGRRazNmcmxGQ2F6a0R1SzRp?=
 =?utf-8?B?TFZiR0hFNFkrTTV1S2ZVLzRKZVkzY3hjMlFTa0NPdzhJa2gyTDlvZVdPNTFL?=
 =?utf-8?B?SjNwM2EzeFpYZFltbGMyV2VUSnkzNDFvTkxPdklVeDhxbEVXcE9ZZk1McVR6?=
 =?utf-8?B?QzFMZTROdHpoeDRza2lYb1FkSlZmRW0waE9JT0RwcXNFOWNhM3ZOV1JBY0lS?=
 =?utf-8?B?UlFRbUNGaTJHSHFlNTh2N3N3WFNSU3V3c2RTRUFBMGxJTEV4QXFUNE9SdTRw?=
 =?utf-8?B?TTVxdStrQmNLS1NNSHpCcTAzVVRFUnpCZ2RKUmcxWFZGaWd6TnprWVZNbFhK?=
 =?utf-8?B?SUFTKy8zTTBTbk9UeHZHZlJvUnV6Zjd1MFYxOFk1bHZCRm1HMUswMmpJVUtw?=
 =?utf-8?B?RW9VY2tTY2VicFovcmxLUjhzSkdLZE55akU3dUtXVFY5d0xQcFhIdk93VGE1?=
 =?utf-8?B?N0VWR3VCWGlyekhlSVRUMkF2dUlXalRYOWFhZ21LSytzMVg2S0JTbWl3b3Iw?=
 =?utf-8?B?V0hwUEM5ejVTN0M1dEhYc21HdjZVQnBpc25KZnpoTDNuL3pld3V0RFNDQ00z?=
 =?utf-8?B?TTlSbWYwdCtKcTZEMGlFUWFpMDk0dHVnOC9hVHNWakpkNzBMeHY2VVBlUnNh?=
 =?utf-8?Q?yqGKHDlR1sxRWZyuu62u2bUKl/GeBhDWf+XxZq2vAnVM=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0225c21d-3eeb-4765-5be4-08dd54e88346
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 15:32:56.7935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7569

DQoNCj4gT24gMjQgRmViIDIwMjUsIGF0IDg6NTDigK9QTSwgQWRpdHlhIEdhcmcgPGdhcmdhZGl0
eWEwOEBsaXZlLmNvbT4gd3JvdGU6DQo+IA0KPiDvu78NCj4gDQo+PiBPbiAyNCBGZWIgMjAyNSwg
YXQgODo0MeKAr1BNLCBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20gd3JvdGU6DQo+
PiANCj4+IO+7v09uIE1vbiwgRmViIDI0LCAyMDI1IGF0IDAzOjAzOjQwUE0gKzAwMDAsIEFkaXR5
YSBHYXJnIHdyb3RlOg0KPj4+Pj4gT24gMjQgRmViIDIwMjUsIGF0IDg6MjfigK9QTSwgYW5kcml5
LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tIHdyb3RlOg0KPj4+PiBPbiBNb24sIEZlYiAyNCwg
MjAyNSBhdCAwMjozMjozN1BNICswMDAwLCBBZGl0eWEgR2FyZyB3cm90ZToNCj4+Pj4+PiBPbiAy
NCBGZWIgMjAyNSwgYXQgNzozMOKAr1BNLCBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5j
b20gd3JvdGU6DQo+Pj4+Pj4+IE9uIE1vbiwgRmViIDI0LCAyMDI1IGF0IDAxOjQwOjIwUE0gKzAw
MDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+IA0KPj4+IC4uLg0KPj4+IA0KPj4+Pj4+Pj4gKyNk
ZWZpbmUgX19BUFBMRVRCRFJNX01TR19TVFI0KHN0cjQpICgoX19sZTMyIF9fZm9yY2UpKChzdHI0
WzBdIDw8IDI0KSB8IChzdHI0WzFdIDw8IDE2KSB8IChzdHI0WzJdIDw8IDgpIHwgc3RyNFszXSkp
DQo+Pj4+Pj4+IA0KPj4+Pj4+PiBBcyBjb21tZW50ZWQgcHJldmlvdXNseSB0aGlzIGlzIHF1aXRl
IHN0cmFuZ2Ugd2hhdCdzIGdvaW5nIG9uIHdpdGggZW5kaWFuZXNzIGluDQo+Pj4+Pj4+IHRoaXMg
ZHJpdmVyLiBFc3BlY2lhbGx5IHRoZSBhYm92ZSB3ZWlyZG5lc3Mgd2hlbiBnZXRfdW5hbGlnbmVk
X2JlMzIoKSBpcyBiZWluZw0KPj4+Pj4+PiBvcGVuIGNvZGVkIGFuZCBmb3JjZS1jYXN0IHRvIF9f
bGUzMi4NCj4+Pj4+PiANCj4+Pj4+PiBJIHdvdWxkIGFzc3VtZSBpdCB3YXMgYWxzbyBtaW1pY2tl
ZCBmcm9tIHRoZSBXaW5kb3dzIGRyaXZlciwgdGhvdWdoIEkgaGF2ZW4ndA0KPj4+Pj4+IHJlYWxs
eSB0cmllZCBleHBsb3JpbmcgdGhpcyB0aGVyZS4NCj4+Pj4+PiANCj4+Pj4+PiBJ4oCZZCByYXRo
ZXIgYmUgaGFwcHkgaWYgeW91IGdpdmUgbWUgY29kZSBjaGFuZ2Ugc3VnZ2VzdGlvbnMgYW5kIGxl
dCBtZSByZXZpZXcNCj4+Pj4+PiBhbmQgdGVzdCB0aGVtDQo+Pj4+PiANCj4+Pj4+IEZvciB0aGUg
c3RhcnRlciBJIHdvdWxkIGRvIHRoZSBmb2xsb3dpbmcgZm9yIGFsbCByZWxhdGVkIGNvbnN0YW50
cyBhbmQNCj4+Pj4+IGRyb3AgdGhhdCB3ZWlyZCBhbmQgdWdseSBtYWNyb3MgYXQgdGhlIHRvcCAo
aXQgYWxzbyBoYXMgYW4gaXNzdWUgd2l0aA0KPj4+Pj4gdGhlIHN0cjQgbGVuZ3RoIGFzIGl0IGlz
IDUgYnl0ZXMgbG9uZywgbm90IDQsIGJ0dyk6DQo+Pj4+PiANCj4+Pj4+ICNkZWZpbmUgQVBQTEVU
QkRSTV9NU0dfQ0xFQVJfRElTUExBWSBjcHVfdG9fbGUzMigweDQzNGM1MjQ0KSAvKiBDTFJEICov
DQo+Pj4gDQo+Pj4gTGVtbWUgdGVzdCB0aGlzLg0KPj4gDQo+PiBKdXN0IGluIGNhc2UgaXQgd29u
J3Qgd29yaywgcmV2ZXJzZSBieXRlcyBpbiB0aGUgaW50ZWdlci4gQmVjYXVzZSBJIHdhcyBsb3N0
IGluDQo+PiB0aGlzIGNvbnZlcnNpb24uDQo+IA0KPiBJdCB3b3Jrcy4gV2hhdCBJIHVuZGVyc3Rh
bmQgaXMgdGhhdCB5b3UgdXNlZCB0aGUgbWFjcm8gdG8gZ2V0IHRoZSBmaW5hbCBoZXggYW5kIGNv
bnZlcnRlZCBpdCBpbnRvIGxpdHRsZSBlbmRpYW4sIHdoaWNoIG9uIHRoZSB4ODYgbWFjcyB3b3Vs
ZCB0ZWNobmljYWxseSByZW1haW4gdGhlIHNhbWUuDQoNCkFuZCBub3cgdGhhdCBJIG9iZXJ2ZWQg
YWdhaW4sICVwNGNjIGlzIGFjdHVhbGx5IHByaW50aW5nIHRoZXNlIENMUkQsIFJFRFkgZXRjIGlu
IHJldmVyc2Ugb3JkZXIsIHByb2JhYmx5IHRoZSByZWFzb24gJXA0Y2ggd2FzIGNob3Nlbi4gQW5k
IEkgYW0gdW5hYmxlIHRvIGZpbmQgd2hhdCBtYWNybyB1cHN0cmVhbSBjYW4gYmUgdXNlZC4NCg==

