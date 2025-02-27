Return-Path: <linux-kernel+bounces-536958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C664A48655
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D151887662
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672521DDA2F;
	Thu, 27 Feb 2025 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="VU1qGXwh"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010006.outbound.protection.outlook.com [52.103.68.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4559B1DB122;
	Thu, 27 Feb 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676262; cv=fail; b=l9yIaAnbUEQzEnHJhVo11vzmbbXfREbZuA7nSb9Iku2NG08lT0ZIbuhtOZD0HVCbPa3lCGPZ14floUcZZkIUu7TT+WnbjmyrWTPX3KVrXCb4kyy7PQ2Mg23HiGojJx9VnZ8yAUCOM/TSjF1Po7CMK5YdtlgTVRQCO797RFbJDY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676262; c=relaxed/simple;
	bh=BlnYhth5Sib8ayXwUWRQRZps9bErluUtSB9TjpP2Fhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OLMsIZuxDW+ufecDaIsNW9WrCXFGz/f7XkhnUGjmdECviHRXsiEwei40AbJpC7jQD89Uv4L6FuXJJw0jtMm+9C62SLe7p5Ugb8XLM0CeDT2zqI1nT5kembIplxC9uP4Z6GAHA28LQovgG/re8Z+Pjhd230Dp/n3PGgEx5GMQFN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=VU1qGXwh; arc=fail smtp.client-ip=52.103.68.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rt19Tj9sFGVtA0pIo/8EQAUf/X+VTRnZDT4KkRiOWpMQ3jQOTtsrf1/l3a4SGzdckBCG4djqhIoXpMdyN+4N40apNuRx/Fg9O3/QAIMobqQ9zC2UnhXE2VAZohOeIC6obu0igo623vf9i9zDzvWp9CRH02SYPVzTsX4ComMkCjnUmRh0STHH8t/ol68EMq5mBp0O0dLZynfzmu2eLgzLRmNTutkY5dQshHJh60p+6dsVGHZvJ/zimmTzw/sq1HbaEwmvZUi3Ozwn3n+G+WV48JWLw1y+421qDeG7VIQVZjQpX5/EC1Sx/WP9I2YqyYSyevUCCLBkg3TwTSoIq50nZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlnYhth5Sib8ayXwUWRQRZps9bErluUtSB9TjpP2Fhw=;
 b=guus7v8XAyjJhqSFtk+jiIdOYoXIBGpg8Ka5HRichpQBO6Q1UOIb/sbRrlganrH1guGPOjYFG7ZZpN66prqFL/kq0Hp6PkjXeHDWUxTaB4dzdigB6RK8x4b2G2Xma9dgDDOpP+g/+4mqYIs5ZF6wXN19n44BrUYoFDre4pYx8Z2XJm/olRvtiFBq6pxqwfbvFXe0VKHxidqo0vH4GDnn1ukEKZ8r+xaJ75KzoYpheO0nJ/eh2lYOSBCWm4whYxLQtiMQuRBM1qZBtytkYJDWk2rvYIph8ZzSo1upV3OCAjMlGBUVZiB0oDVuV9wkW4TnHXEaNpqtoPEhbAqkLrcjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlnYhth5Sib8ayXwUWRQRZps9bErluUtSB9TjpP2Fhw=;
 b=VU1qGXwhjZDGz1qsNBkh8dfPEMfG+jtGL09bXsOXdmIbvBLPAJdq2pGRyVUPiB5BnerqdHq3TyqVgTgk+/I4+G0AzzQ1Jh4HA6J0W6KFtgzKCkrh/DGuAZg9SJJWDxyAL4mOxPI09gSPdQtR14zdKdS3vNZp2ODW8OMxH8GJ1yFlUgHNesxVOfNW56Fzyrda25Jh0Fi8G0QYEtZhkM02es7VUMJ/OMUUERLdl9WyYPh0pTgxoL48xzH4eGhDoq061THRxjV7n0jViGCHY7CZXyJfdzaoPxrvVttfVrzalTXM4lL8zZCgp2iZiDsGICw/JwNCIUiNbeQWszkMSI7f2g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7958.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 17:10:52 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 17:10:52 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
CC: "pmladek@suse.com" <pmladek@suse.com>, Steven Rostedt
	<rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"apw@canonical.com" <apw@canonical.com>, "joe@perches.com" <joe@perches.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hector Martin
	<marcan@marcan.st>, "sven@svenpeter.dev" <sven@svenpeter.dev>, Janne Grunau
	<j@jannau.net>, "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>
Subject: Re: [PATCH v4] lib/vsprintf: Add support for generic FOURCCs by
 extending %p4cc
Thread-Topic: [PATCH v4] lib/vsprintf: Add support for generic FOURCCs by
 extending %p4cc
Thread-Index: AQHbiOEjzUrALYS3lkmTQCvm8eL6dLNbOimAgAApL4M=
Date: Thu, 27 Feb 2025 17:10:52 +0000
Message-ID:
 <PN3PR01MB9597916417D398179C55BD98B8CD2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <DB7F502D-1477-49C9-A36D-1DEE408ED23C@live.com>
 <Z8B6DwcRbV-8D8GB@smile.fi.intel.com>
In-Reply-To: <Z8B6DwcRbV-8D8GB@smile.fi.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAZPR01MB7958:EE_
x-ms-office365-filtering-correlation-id: 54800d2e-ab1a-4142-cd93-08dd5751b08a
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|8062599003|12121999004|15080799006|6072599003|7092599003|8060799006|3412199025|440099028|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZFVpYUl5YUFQTmJvMUttbjM1L0JHNFFtZldWVXRibDR1UHQydTNSY2NpZjEr?=
 =?utf-8?B?WWljYmdIR1FUTTB4dnF6Z2ZhTjRsM1RxczV0Z3J6SFlmbXFFbmhDT0I2ZThm?=
 =?utf-8?B?dnpMaHNYTGlhV1NhMVFRV0x3aXNYSEdGb1F6Rmd4RW4zYnNKeW10WStBaXJu?=
 =?utf-8?B?VldxUElVaHZyQVBqQ3dFdjZRNDN6SjFlV0drQzV6aTdxdFdjTk5Fdlk3UXV2?=
 =?utf-8?B?WTlLekJjd29rWU5kZVFnWkZzdlNhdUJzODVxUXBaQWRBRTVCN1hTeDZrN1d5?=
 =?utf-8?B?bzF2ekVkTEdoSy95Z1NhQjkwS0doZ1JkV0ROaVAveXcvc2dqUkM0SmVLSTZu?=
 =?utf-8?B?ZEZTRi82Vnl4alA3cittMmJiMXUrYkwzVXljNm41SkhCRmVBb21ocGNZTzRI?=
 =?utf-8?B?OEo5Ky8wL3pzcW9NWHh0T2pVZnpkNm9xc0l5TkpIMGkvc1lDL1psWTl5K083?=
 =?utf-8?B?VHdpL0NJc2xLWWFNWCtJaVdFYjJYSVJtaThtN1ZtV0grTFVLdFRhR3Y3YXU3?=
 =?utf-8?B?UFJLU1RRbDR5QTF0TGoxVVU3SEdveEFNOEFEMVJDekdGTkZPRWNMSjE0QW0r?=
 =?utf-8?B?bk03SHJibnptWVJTa1hhV1hvYlY2V2haZHNhbUFFT2RFM01PQlhqY3ozNDFD?=
 =?utf-8?B?T0E1ZGdyeDRxaDMrK295QUt5cnloNHU3ajYvci9pZHBGZnU0bHRTVldaTzJm?=
 =?utf-8?B?V3QzTFJ3RDYwS1ZZN3dGdGdNLzBKQTc0Zm90U0FlenJQRFk0VHY3U3R5a1M0?=
 =?utf-8?B?eHdMVTh0WGVxRnF6NGZSbHNsR2UxWHRBcVNzajE5SmtRSGNIRCtlek1SaThU?=
 =?utf-8?B?b09iK2tsYVVxSkFZOEY2SnJ4UER1cktiakRJcGptNlRueFN4Sm02aWZMY29H?=
 =?utf-8?B?ZERITDZVZEEzUWU3Tm1mQjRyYkEzR3VoRFFUQUZxREUwU0ZJSUJVaWlIcW5t?=
 =?utf-8?B?TTcrQ3RNcCtnUllRRDBFbUU5V1NXUmF6elFhTGZzNG5TVldLbHlVWGl1Unhi?=
 =?utf-8?B?ODdUbzlnUFhrWjE5TVRKZ0tLdlVDYW9OWktib3FNdnpzZFZHNG05R0NHenFl?=
 =?utf-8?B?QmpLWUpFdzJuMEVRaVN2MSswdWZUMGd6bTl2UDdVWXovajBWMDJSMmJBa0JN?=
 =?utf-8?B?N0xnNVg4NzBhRnJWdDd4cmJSbmNNZm5TR1NiU0xPSVdFcDF1aGxZK29XM3VH?=
 =?utf-8?B?eHovbGNYbU9abG1KOUluN2c4NG5xdEdFSXlyWkZzT0gxZ0x4WjJLZ3ZmdDBp?=
 =?utf-8?B?dnNNU1ZhM3UxNno1Y0FxUjNkUlNNczdvVEpDMTVHVE9EUVFjd1Vsc21qL3ZS?=
 =?utf-8?B?T1Z5RFBPL2xQVnN1Z0NoTnF2bFVXOHVJblc2UVA4Q0JwUmVSOXZqU1N0Z1U0?=
 =?utf-8?B?OFdFMWl0SFVXdXpDcWhCWFFIclNMMDR0RHFrQWtIWGJORU0yaHZUZEl6UTRL?=
 =?utf-8?B?Q2czVEE4bFNWSDVMZk0xRk5JbWsxVDZwY0pUdERsZjVjSSswTmVZMlBObGtm?=
 =?utf-8?B?dTFZazNqRTRNU3FJOU9XQjMydGc3dk1GOTFwUHkxRHY5Zko2RUJiLytoTjY4?=
 =?utf-8?Q?0KfEO7A5ludCZmo1lRdnqPxo0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUxxcFlWYm95MnhGbCsvV3BKOWZmZE9tMkkvYmZFTmVjNmNqZmhITDg5OUlO?=
 =?utf-8?B?b0ltVWlEZG0vS1JWdWhyamt0U29mTExxaFlEY2cxTmN3Z2Y3TkNxM2EzQ00x?=
 =?utf-8?B?MGpLdDhaUWRKajJrcnU3L0lCOE00a2NlMGZyK0ZmcWlIUnV1SVhHSk8vV2xG?=
 =?utf-8?B?a2VYVENFRDIrbHRTUjRBSVRrNXlDNSt6aFU4Vi9EUEtvK0Fpam5lSFdlNnh4?=
 =?utf-8?B?V3NDWEY1U2FTcmxuT0R0MEc4QXFFRXVCd3h3aDZ3TmlTV1FLQ0NSN0NGcHgv?=
 =?utf-8?B?UFhDOGtGcUkwNjkrdWJsODlzRUFwTkFHOUI4VTQ1NE1qNTRVYjE0aXNtN1B2?=
 =?utf-8?B?V2xmMGdDRmlNL29OVUhNdmlOeU5RZXpVeVVUWlFTR0tWdEswdFp0TENaS3JB?=
 =?utf-8?B?bVZiNERnVUw4OUpuT1RPelVUUno1cGlRVHk5NTFFRG1sYXR5Yk5UZFJ4TFNN?=
 =?utf-8?B?c0F5dmRoZjZ5cmxtbjVneFVFdVd0a3RhVENLeTlMYU01VkNSYzVTV3o5Uk5m?=
 =?utf-8?B?QWRuMjRKWUs2Tk5KTGVkM0tqNm04Wnpxc3o2d1pIVTdQMHlqaFhBVjRuREM1?=
 =?utf-8?B?bC82alRJOXZJM2ZnbkJUMmlsVFljT1hIS1pJZys5dEZoWmREZW5oU2ZGa0hp?=
 =?utf-8?B?djR0YTQxMGh0UnZXUGRTMjhvem5xYkNDdENuUksrcXdER2M2dldZMFBDV2dp?=
 =?utf-8?B?NDRMTFdzb21yaXhORGJLVURpNDBXN1JvaXpWWlNYbFkrVTB6TVJuTkxSWGpW?=
 =?utf-8?B?S3hVaGJGb2kzUU9Eam5WV3pEN0xQY3pjeEJTTGdlZitQZDlHdFZyNDRzWnha?=
 =?utf-8?B?YlZ5elRjRHpJV1N1MnVOYmZyUGFjYkg5eWhCOC8rSjFYekxBWWJCdmRoaUJm?=
 =?utf-8?B?cm1tcmpqWERNOXJCbWxHYk40SDRmcnU0T3Z1a3JSUVovOG92NHB1akY1N1pM?=
 =?utf-8?B?aU5LOUJzT201NWdPaUxRWDJRWUhKR09FWGwrV3RyYnljZmVCMEhxc1FkNW9v?=
 =?utf-8?B?RlF0YmU2akErcGlpZVJTZzNLOHlzSVZ5Zkl1cTNmYzUyeStyRkRsODh0MkV2?=
 =?utf-8?B?VGZBT1RZbHRsalVKTHJEV3k2TXFCaWwrYXdGUEJ3S2JyaEZkK2NUc1pNeHVQ?=
 =?utf-8?B?dU1vZ1NLUTZNcVgvZWN6aERGcXpBQmcwNERsaWhPc0haMWQya0dpem1zMkY1?=
 =?utf-8?B?VHFLMjN3S0p0dnVWVTNXMDFjNUE4MGhIQ1JQMTh2cmt6aVh1MUhQZFF3UVFp?=
 =?utf-8?B?T2U0UU5zZ0M3T043QUw1M0IxbkNRbkdpVFhUeU9ldjY3R25WMXIvYkYvRGxm?=
 =?utf-8?B?NjBTNWQyNUJOSmduMjlIa1ZiOWRCK2dIdmgvSExNcUxUaEVubGk1UDZQY2hX?=
 =?utf-8?B?R2F2eEczU2U1WmUzVlQ2NUl2aVFIYjA5bzZkL2tUZ0pYa09zeWtMTm9PR0k2?=
 =?utf-8?B?bGtDb0hPdUt4cVpoTlhwemFuSDJNZ0p3LzhBR2g3enVaUFBTaVU1TFFnQk9I?=
 =?utf-8?B?QkdERXRwYlU5RnVEM3hHN2RPOUJDR0p6QURyK1QrelRlWW53UVBZMVF2SEtp?=
 =?utf-8?B?VU9sVjNaa2tqK0drSzRkeWZ6N0x2QXM3aWVvaTFlbHY4UGdSaU5QVjRnZGgv?=
 =?utf-8?Q?8dh1SQp6oIm87NifBiESv34bYDl5WTB5We/5T0pJC2uY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 54800d2e-ab1a-4142-cd93-08dd5751b08a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 17:10:52.2013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7958

DQpIaQ0KPiBPbiAyNyBGZWIgMjAyNSwgYXQgODoxM+KAr1BNLCBhbmRyaXkuc2hldmNoZW5rb0Bs
aW51eC5pbnRlbC5jb20gd3JvdGU6DQo+IA0KPiDvu79PbiBUaHUsIEZlYiAyNywgMjAyNSBhdCAw
NjozMDo0OEFNICswMDAwLCBBZGl0eWEgR2FyZyB3cm90ZToNCj4+IEZyb206IEhlY3RvciBNYXJ0
aW4gPG1hcmNhbkBtYXJjYW4uc3Q+DQo+PiANCj4+ICVwNGNjIGlzIGRlc2lnbmVkIGZvciBEUk0v
VjRMMiBGT1VSQ0NzIHdpdGggdGhlaXIgc3BlY2lmaWMgcXVpcmtzLCBidXQNCj4gDQo+IEZvdXJD
QyAoYXMgRm91ciBpcyBub3QgYW4gYWNyb255bSBpdHNlbGYpLg0KDQpPaw0KPiANCj4+IGl0J3Mg
dXNlZnVsIHRvIGJlIGFibGUgdG8gcHJpbnQgZ2VuZXJpYyA0LWNoYXJhY3RlciBjb2RlcyBmb3Jt
YXR0ZWQgYXMNCj4+IGFuIGludGVnZXIuIEV4dGVuZCBpdCB0byBhZGQgZm9ybWF0IHNwZWNpZmll
cnMgZm9yIHByaW50aW5nIGdlbmVyaWMNCj4+IDMyLWJpdCBGT1VSQ0NzIHdpdGggdmFyaW91cyBl
bmRpYW4gc2VtYW50aWNzOg0KPj4gDQo+PiAlcDRjaCAgIEhvc3QtZW5kaWFuDQo+IA0KPiBUb28g
bWFueSBzcGFjZXMgOi0pDQoNCk9rDQo+IA0KPj4gJXA0Y2wgICAgTGl0dGxlLWVuZGlhbg0KPj4g
JXA0Y2IgICAgQmlnLWVuZGlhbg0KPj4gJXA0Y3IgICAgUmV2ZXJzZS1lbmRpYW4NCj4gDQo+PiBU
aGUgZW5kaWFubmVzcyBkZXRlcm1pbmVzIGhvdyBieXRlcyBhcmUgaW50ZXJwcmV0ZWQgYXMgYSB1
MzIsIGFuZCB0aGUNCj4+IEZPVVJDQyBpcyB0aGVuIGFsd2F5cyBwcmludGVkIE1TQnl0ZS1maXJz
dCAodGhpcyBpcyB0aGUgb3Bwb3NpdGUgb2YNCj4+IFY0TC9EUk0gRk9VUkNDcykuIFRoaXMgY292
ZXJzIG1vc3QgcHJhY3RpY2FsIGNhc2VzLCBlLmcuICVwNGNyIHdvdWxkDQo+PiBhbGxvdyBwcmlu
dGluZyBMU0J5dGUtZmlyc3QgRk9VUkNDcyBzdG9yZWQgaW4gaG9zdCBlbmRpYW4gb3JkZXINCj4+
IChvdGhlciB0aGFuIHRoZSBoZXggZm9ybSBiZWluZyBpbiBjaGFyYWN0ZXIgb3JkZXIsIG5vdCB0
aGUgaW50ZWdlcg0KPj4gdmFsdWUpLg0KPiANCj4gLi4uDQo+IA0KPj4gK0dlbmVyaWMgRm91ckND
IGNvZGUNCj4+ICstLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiArDQo+PiArOjoNCj4+ICsgICAgJXA0
Y1tocmJsXSAgICBnUDAwICgweDY3NTAzMDMwKQ0KPj4gKw0KPj4gK1ByaW50IGEgZ2VuZXJpYyBG
b3VyQ0MgY29kZSwgYXMgYm90aCBBU0NJSSBjaGFyYWN0ZXJzIGFuZCBpdHMgbnVtZXJpY2FsDQo+
PiArdmFsdWUgYXMgaGV4YWRlY2ltYWwuDQo+PiArDQo+PiArVGhlIGFkZGl0aW9uYWwgYGBoYGAs
IGBgcmBgLCBgYGJgYCwgYW5kIGBgbGBgIHNwZWNpZmllcnMgYXJlIHVzZWQgdG8gc3BlY2lmeQ0K
Pj4gK2hvc3QsIHJldmVyc2VkLCBiaWcgb3IgbGl0dGxlIGVuZGlhbiBvcmRlciBkYXRhIHJlc3Bl
Y3RpdmVseS4gSG9zdCBlbmRpYW4NCj4+ICtvcmRlciBtZWFucyB0aGUgZGF0YSBpcyBpbnRlcnBy
ZXRlZCBhcyBhIDMyLWJpdCBpbnRlZ2VyIGFuZCB0aGUgbW9zdA0KPj4gK3NpZ25pZmljYW50IGJ5
dGUgaXMgcHJpbnRlZCBmaXJzdDsgdGhhdCBpcywgdGhlIGNoYXJhY3RlciBjb2RlIGFzIHByaW50
ZWQNCj4+ICttYXRjaGVzIHRoZSBieXRlIG9yZGVyIHN0b3JlZCBpbiBtZW1vcnkgb24gYmlnLWVu
ZGlhbiBzeXN0ZW1zLCBhbmQgaXMgcmV2ZXJzZWQNCj4+ICtvbiBsaXR0bGUtZW5kaWFuIHN5c3Rl
bXMuDQo+IA0KPiBCdHcsIHRoaXMgc291bmRzIHRvIG1lIHRoYXQgJ2gnIHNob3VsZCBiZSBhY2Nv
bXBhbmllZCB3aXRoICduJywgb3RoZXJ3aXNlIGl0J3MNCj4gY29uZnVzaW5nIHdoeSBCRSBpcyB0
aGUgaG9zdCBvcmRlciBvdXQgb2YgdGhlIGJsdWUuDQo+IHNvLCBpdCBuZWVkcyBtb3JlIGluZm9y
bWF0aW9uIHRoYXQgdGhpcyBtaW1pY3MgaHRvbmwoKSAvIG50b2hsKCkgZm9yIG5ldHdvcmtpbmcu
DQo+IA0KPiBEb2VzICdyJyBhY3R1YWxseSBzaG91bGQgYmUgJ24nPw0KDQpJIGJlbGlldmUgeW91
IG1lYW4gbmVnYXRpdmUgZW5kaWFuPyBDYW4gYmUgZG9uZS4NCj4gDQo+PiArUGFzc2VkIGJ5IHJl
ZmVyZW5jZS4NCj4+ICsNCj4+ICtFeGFtcGxlcyBmb3IgYSBsaXR0bGUtZW5kaWFuIG1hY2hpbmUs
IGdpdmVuICYodTMyKTB4Njc1MDMwMzA6Og0KPj4gKw0KPj4gKyAgICAlcDRjaCAgICBnUDAwICgw
eDY3NTAzMDMwKQ0KPj4gKyAgICAlcDRjciAgICAwMFBnICgweDMwMzA1MDY3KQ0KPj4gKyAgICAl
cDRjYiAgICAwMFBnICgweDMwMzA1MDY3KQ0KPj4gKyAgICAlcDRjbCAgICBnUDAwICgweDY3NTAz
MDMwKQ0KPj4gKw0KPj4gK0V4YW1wbGVzIGZvciBhIGJpZy1lbmRpYW4gbWFjaGluZSwgZ2l2ZW4g
Jih1MzIpMHg2NzUwMzAzMDo6DQo+PiArDQo+PiArICAgICVwNGNoICAgIGdQMDAgKDB4Njc1MDMw
MzApDQo+PiArICAgICVwNGNyICAgIDAwUGcgKDB4MzAzMDUwNjcpDQo+PiArICAgICVwNGNiICAg
IGdQMDAgKDB4Njc1MDMwMzApDQo+PiArICAgICVwNGNsICAgIDAwUGcgKDB4MzAzMDUwNjcpDQo+
PiArDQo+IA0KPiAuLi4NCj4gDQo+PiArICAgIHN3aXRjaCAoZm10WzJdKSB7DQo+PiArICAgIGNh
c2UgJ2gnOg0KPj4gKyAgICAgICAgdmFsID0gb3JpZzsNCj4+ICsgICAgICAgIGJyZWFrOw0KPj4g
KyAgICBjYXNlICdyJzoNCj4+ICsgICAgICAgIG9yaWcgPSBzd2FiMzIob3JpZyk7DQo+PiArICAg
ICAgICB2YWwgPSBvcmlnOw0KPj4gKyAgICAgICAgYnJlYWs7DQo+PiArICAgIGNhc2UgJ2wnOg0K
Pj4gKyAgICAgICAgb3JpZyA9IChfX2ZvcmNlIHUzMiljcHVfdG9fbGUzMihvcmlnKTsNCj4+ICsg
ICAgICAgIHZhbCA9IG9yaWc7DQo+PiArICAgICAgICBicmVhazsNCj4+ICsgICAgY2FzZSAnYic6
DQo+PiArICAgICAgICBvcmlnID0gKF9fZm9yY2UgdTMyKWNwdV90b19iZTMyKG9yaWcpOw0KPj4g
KyAgICAgICAgdmFsID0gb3JpZzsNCj4+ICsgICAgICAgIGJyZWFrOw0KPj4gKyAgICBjYXNlICdj
JzoNCj4+ICsgICAgICAgIC8qIFBpeGVsIGZvcm1hdHMgYXJlIHByaW50ZWQgTFNCLWZpcnN0ICov
DQo+PiArICAgICAgICB2YWwgPSBzd2FiMzIob3JpZyAmIH5CSVQoMzEpKTsNCj4+ICsgICAgICAg
IHBpeGVsX2ZtdCA9IHRydWU7DQo+PiArICAgICAgICBicmVhazsNCj4+ICsgICAgZGVmYXVsdDoN
Cj4+ICsgICAgICAgIHJldHVybiBlcnJvcl9zdHJpbmcoYnVmLCBlbmQsICIoJXA0PykiLCBzcGVj
KTsNCj4+ICsgICAgfQ0KPiANCj4gQWN0dWFsbHkgeW91IGNhbiByZXBsYWNlIGFsbCB0aGVzZSBv
cmlnIGNvcGllcyBieSBpbnRyb2R1Y2luZyBhIG5ldyBib29sZWFuLCBwaXhlbF9iZS4NCj4gDQo+
IFdpbGwgYmVjb21lDQo+IA0KPiAgICBzd2l0Y2ggKGZtdFsyXSkgew0KPiAgICBjYXNlICdoJzoN
Cj4gICAgICAgIHZhbCA9IG9yaWc7DQo+ICAgICAgICBicmVhazsNCj4gICAgY2FzZSAncic6IC8v
IG9yICduJyA/DQo+ICAgICAgICB2YWwgPSBzd2FiMzIob3JpZyk7DQo+ICAgICAgICBicmVhazsN
Cj4gICAgY2FzZSAnbCc6DQo+ICAgICAgICB2YWwgPSAoX19mb3JjZSB1MzIpY3B1X3RvX2xlMzIo
b3JpZyk7DQo+ICAgICAgICBicmVhazsNCj4gICAgY2FzZSAnYic6DQo+ICAgICAgICB2YWwgPSAo
X19mb3JjZSB1MzIpY3B1X3RvX2JlMzIob3JpZyk7DQo+ICAgICAgICBicmVhazsNCj4gICAgY2Fz
ZSAnYyc6DQo+ICAgICAgICBwaXhlbF9mbXQgPSB0cnVlOw0KPiAgICAgICAgcGl4ZWxfYmUgPSBv
cmlnICYgQklUKDMxKTsNCj4gICAgICAgIC8qIFBpeGVsIGZvcm1hdHMgYXJlIHByaW50ZWQgTFNC
LWZpcnN0ICovDQo+ICAgICAgICB2YWwgPSBzd2FiMzIob3JpZyAmIH5CSVQoMzEpKTsNCj4gICAg
ICAgIGJyZWFrOw0KPiAgICBkZWZhdWx0Og0KPiAgICAgICAgcmV0dXJuIGVycm9yX3N0cmluZyhi
dWYsIGVuZCwgIiglcDQ/KSIsIHNwZWMpOw0KPiAgICB9DQo+IA0KPiBBbmQgd2l0aCB0aGlzIHRo
ZSBleGlzdGVuY2Ugb2YgJ3ZhbCcgbm93IGJlY29tZXMgZG91YnRmdWwsIHdlIG1heSByZXVzZSAn
b3JpZycsDQo+IGp1c3QgbmFtZSBpdCAndmFsJyBldmVyeXdoZXJlLCBubz8NCg0KSW4gY2FzZSBj
LCB2YWwgIT0gb3JpZywgaW4gcmVzdCBpdCBpcy4gV2UgY2FuIGp1c3QgdXNlIHBpeGVsX2ZtdCB0
byBjaGVjayB0aGlzIGNvbmRpdGlvbiwgYnV0IHBsYWNlcyB3aGVyZSB3ZSB1c2Ugb3JpZywgYW5k
IG5vdCB2YWwgd2lsbCBuZWVkIGFuIGlmIHN0YXRlbWVudCBvciBzb21ldGhpbmcgc2ltaWxhci4g
VGJoLCBpdCdzIGFuIHVuZWNlc3NhcnkgY29tcGxpY2F0aW9uLiBZb3UgbWlnaHQgd2FudCB0byBz
ZWUgdGhpcyBwYXJ0IG9mIHRoZSBjb2RlOg0KDQoJaWYgKHBpeGVsX2ZtdCkgew0KCQkqcCsrID0g
JyAnOw0KCQlzdHJjcHkocCwgb3JpZyAmIEJJVCgzMSkgPyAiYmlnLWVuZGlhbiIgOiAibGl0dGxl
LWVuZGlhbiIpOw0KCQlwICs9IHN0cmxlbihwKTsNCgl9DQoNCgkqcCsrID0gJyAnOw0KCSpwKysg
PSAnKCc7DQoJcCA9IHNwZWNpYWxfaGV4X251bWJlcihwLCBvdXRwdXQgKyBzaXplb2Yob3V0cHV0
KSAtIDIsIG9yaWcsIHNpemVvZih1MzIpKTsNCgkqcCsrID0gJyknOw0KCSpwID0gJ1wwJzsNCg0K
SGVyZSwgc3BlY2lhbF9oZXhfbnVtYmVyIGlzIGNvbW1vbiB0byBhbGwgY2FzZXMuDQo=

