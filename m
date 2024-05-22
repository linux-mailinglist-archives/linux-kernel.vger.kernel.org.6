Return-Path: <linux-kernel+bounces-186276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972998CC210
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7C51C21B58
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B354013E049;
	Wed, 22 May 2024 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tuQE7LzE"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2147.outbound.protection.outlook.com [40.92.63.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3213DBB7;
	Wed, 22 May 2024 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.147
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384292; cv=fail; b=DxBe8tdFqzyaa+xhlNH8fQbBFgPDPMdyF8G0gk8VV0nSEtcJO4UOqrwbEksac+8NoaI/a+JpPMKb7g62GoWiQ2kc+n9nE+FoqCkR/GwAFN1LxMJ1DI7Ju80q3MEKG/8QE7ZRMVSn3RDXBQbXQPa/tZjBGPXBWPN6NJAngwSWeXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384292; c=relaxed/simple;
	bh=U3s6CDV/0cQ/qTcgZX3eouSFfDkIpwxEKowF6DVt2Ic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rC63QimhMOYvr4OzZSs9XZSbrtohJcgneSud9bDyk6LFn/wxrFa5fWN9Y9csb9iXuobvIbqOJgKkFY5T0QQ6FylVkcnRNGeWS7nEcxJX/Yx3jn9aQsMf47ErWxK1Que5YZF2XaIwxti9n3g+95h5rf4C7hYMg6Chq4MQdUD3zPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tuQE7LzE; arc=fail smtp.client-ip=40.92.63.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y80LeFdKnX9qZQiea7L2dic+tcLtPiw888uuaGae9b1nBmC+6vQ7gMWYmfMAgWV3+jRHe2ru5yhV11j6N7FUyVzaYMNO7T0SO+9p1QejuRXCuOFKsZYhh/6Co8TQVN4y+QFRtJaOgLUnRvDRrJ9ByyJBTfUa64UfkRs9ods5cKB6EA6JX3qccJocP81rmreMyhDGZhRzBfb28wuZaYecmLO11lzdIwWVC9hqyCqo3htmLwplxR8hApuA+7X0gdOz+EKxbsDvA/ije5SD1N99D6GJnQo5hhN7/qHAcu31OvILoUMn3tI3/2isiMiyYAxv40HAE2nMikb/38k9eZZ20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3s6CDV/0cQ/qTcgZX3eouSFfDkIpwxEKowF6DVt2Ic=;
 b=n9qEKLW89cwvQKRepRAYfU1k6hoyyovGB/hvz8IXEJWlfsX6Lc3TrlKsBcaP/z/oBg7nWzNE9mBcE2af/tcn138VQIg8thSgGsN5xSEN5GRqKlIZOjslXIwlaa2IN2yS3aYG1vsFBV4tyyAHAMtTtuIitA4dZ3L2zJCscLYAegatIhN7k77ljiouQvzpS2ir83m4uwcH9gSykXkiCqDynf3UfkS72tkeQMh4gKg7qPPDlpgA31Wu8V1kLwkhdRMUvi8SH288N6K306tq/soWCW9wiZwXLaUiNsc8Fb3bMn777/OIPLDseG6hum1iJwMzbgi2Rbp+rpEf+p95jEOsfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3s6CDV/0cQ/qTcgZX3eouSFfDkIpwxEKowF6DVt2Ic=;
 b=tuQE7LzEZ1c+7687Muq16KRBNxFbhjJGkb9Fhiy37YPvnPov9/o71yGe16PzpZqMnNWJuoz6rxQmEW+qAOAVEf9AZAa5ZBdNMkCOZ3DpJYAc4XLSw4f+aJsTqgmicNowOMbmHLPOWl6CRqep8NhGIpW3kShflzI4/tzjm0STRe4X6mbmvetGnastl8Bop8hTkROlx8kYBWQdkuANP8FjOQoTkG2Fjcgp5EhpVdAAvEP41qXBFKBq/ghq9WhCMdVL7ILWhuaCkp8LfKNFceLcCRYT+dAgdx5SqITk56THsB9AX5xXUdCp1DoxHQa4EltuV5nlSfBYY988IE7dTuuRNA==
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:228::21)
 by ME4P282MB0744.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.21; Wed, 22 May 2024 13:24:47 +0000
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e]) by ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 13:24:47 +0000
From: Xu Roland <mu001999@outlook.com>
To: Alice Ryhl <aliceryhl@google.com>
CC: "ojeda@kernel.org" <ojeda@kernel.org>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHJ1c3Q6IGtlcm5lbDogbWFrZSBpbXBsX2hhc193?=
 =?utf-8?Q?ork_compatible_with_more_complex_generics?=
Thread-Topic: [PATCH] rust: kernel: make impl_has_work compatible with more
 complex generics
Thread-Index: AQHarENxWIjlBOOAWkqGotVt1EqetLGjMQuAgAANJVI=
Date: Wed, 22 May 2024 13:24:47 +0000
Message-ID:
 <ME0P282MB4890C545F827111FCE2D2AA0CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
References:
 <ME0P282MB48901A79E405F9CF615FF2F1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
 <CAH5fLgiL7EdnzRL79x4zX0pXrtb8OjVkRib+qkoi=TyzHzEc4A@mail.gmail.com>
In-Reply-To:
 <CAH5fLgiL7EdnzRL79x4zX0pXrtb8OjVkRib+qkoi=TyzHzEc4A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [+qpmeLQIcZ5xrNhc0EfFpsAHruyuWa+y]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P282MB4890:EE_|ME4P282MB0744:EE_
x-ms-office365-filtering-correlation-id: 5ac10f99-d981-4ea6-9334-08dc7a628d33
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3430499023|440099019|3412199016|1602099003;
x-microsoft-antispam-message-info:
 qarDWoLHHxDMuzw1M2s5X3KOYhAVL+Geh4JBSfNmKGOT9HH93U11B5rni0U0E5pM/4Yh4kCDFKw+rK2H0tybS/goCFz0foekhZsjeW78AOuDlbUachW9pqrY5pAOHSeVm3ZW8DX1FhJQAdmPtOqou2JGXAzBA0SuIdtjKTrtiMszVGvevTPBn8HUnUHc0YwpeO2HyJU6jlpqK/tn4u5ODE8m+KV5lF7v1fQ//LhwOog0fYc6tio7d4j+dLfG6YQ60EM6sshD4zKpaEO7dNS3VogENmqkHNuISYGL70qRq7pFosSDOl0W9N94vL/LPfoIexsVhmSWhFYzeT/f6LL5qLWpl+RkdlsZocJUtd1e4PwjWkpauc79jykmnMc6hSdou2KVBQAjCmUuGO4EoShcXXJqHFky0AERDedvmmGK92HnLNE8l62fobmB3PrRf6YuTDzn3U6JN0JAnf02KJUj+kBovWtfO8l5fuY9ilu6obAkRHM6V5xB+EkyV3JySj9T5qx7qzN2v4QsIaiJkPEO04nhiCUStWTB16hPelFpQ8xvaY+Arw04WQotZMP4tPYL73sZUceu4X1slYJvqN92ejMtzLdtsd2jYaaLLkRTxmyC0qxRTmlYVlGfriP+WEHSfiIwsx1d2YKsaIwCdqfKAQXyaHu2GVjjnJwtYuzhZzQ=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzRQQmxwN1l1WHlGNUk5OUNqNngzQnYwNFdzRGRGbm9YeWNzT2pQSkJLQzBI?=
 =?utf-8?B?bDlqN2J5R2l6UDhhc3B0NGZWTVk2OWF3MU5XVXUwdElucjVtNDd1dnZlWnFR?=
 =?utf-8?B?Nnhmajc4cG9PZFI1WXpNZXFKb1pCVkJ4aWZaaWppajhHdUk2U2tKNVNrQXpD?=
 =?utf-8?B?bEFhVkJDVzBaalhzV1JpYTdjbHBZZXgzY3NZblA1WFFRaTBoak5LNEN3L2JS?=
 =?utf-8?B?UkIrVEpZWERvZXA2VEt2MUtzamVzMi80NlhGS1Bkd1Y4Q0ZyZG54SWJOS2Rj?=
 =?utf-8?B?Q1FhRXNhZUVseXc0Zmg1RTU3Wjhuc0hPcVJXTUhvMUpiTGhpWjI4ZEtQNzFQ?=
 =?utf-8?B?Um9yN242eXc5czEvdmo4TTdjdUd3elV6bWNBN0ExY2J0RXg3V0FFeWQ2REZ3?=
 =?utf-8?B?NXZXWkdwdGF2L1gra1lzUnIzMXk4ZG1OM3JPclhVZWRmNmFrZGQwbE1JVTZN?=
 =?utf-8?B?QUMxVHkzVnFaSGlsQyt1WjZHUzNEUHpIdXlEZUIzUmVvdkV1VHY0TWdSY3pN?=
 =?utf-8?B?elYvMlVjSDNYaDZvQ3JROStDeVB5Q3k1K0RHbTR0TmViWW5HVFNHUS9FbFBC?=
 =?utf-8?B?aXlqK0lTckRWeitNU2tJZ200NkVoWmtrVERXUmFDeVhsNVdwaTNXQlV0MFRx?=
 =?utf-8?B?aWVzUXRSVjQ0MXd1RDFoSjIySXZlRlg2U3VzUm10T09LQXNIaEU5QTdDQ2FU?=
 =?utf-8?B?M3BybWhFRXJFemdEeUdiY25LdEppZW5ycGpMVzNSUlA2b3BIcCtIRnczRlBH?=
 =?utf-8?B?M3ZWR0dheFhTTUUxMmp5dW5jY3R5dkxidm9LbWd2MGRYU1g5b2FZNm1zS1J1?=
 =?utf-8?B?djUxWjYyQ0p5ZW1MYVdhWnYyc1luZnF3UkFmYXN2U2JHUXdDZlNEVlVkc1RS?=
 =?utf-8?B?ZFl5M29jdGdKOWQrV0s2aGpkbUNWVVZxTUY3YmNVc2ZwVHFtWEhodTNRMlJI?=
 =?utf-8?B?TjY3YndtbitnSGhwTExZeSt2TWpCUDhDM0xwb0I4QVZpVmhhNFBRS05BSXRy?=
 =?utf-8?B?d0c5eFgwZTFxUFBkL1l5UHdtYlJBZmlOVHF1bXhlRHU4RjZMdkVuMHNwSzVq?=
 =?utf-8?B?YitNYm0vOWo1SnZKSExwRXNPK2RxU25EbHBhNndKQVJVTEgza0VBWnBpaUxq?=
 =?utf-8?B?UDhiVHNoQXA4Qjc5MktYN2V2SEI1TnQ0d3JCUjFWWWp6ekZHeTY4YkIrZHBB?=
 =?utf-8?B?MklpNVduSGFac3A2RjJyMS9RQndNK2d4QjRPSFdyclRMODNmalhDQTlXd1k1?=
 =?utf-8?B?Z1hHdFdFSVhCSTIySGRhRjRrMXRKb05iekZEUHNjMkJFbkNkZGRYZHgwTVFh?=
 =?utf-8?B?eUFiT0RjcWlhdEVKY3JHRWNpVFZrOTZPNkc4NEEyZGlyZWhnRnpYUWRxSDlF?=
 =?utf-8?B?cGE0d0tFR2NZN2JBNlQxUG5SSTh6UGRrQ3VrYWk5NllHU2dtcVZpNUdXVXg2?=
 =?utf-8?B?OG05TFVxc0l3Wm9IZ1d0M2NHY2xFTVc1RTNrMU4yM1ppbGtGMXFLeFhRL2ZK?=
 =?utf-8?B?eXdDRnNueldGdmxkTE01SEJwQkhXZWJmQzg0WWYwSy9XK3Q3b3k1TFJhMkc3?=
 =?utf-8?B?QnJaQ3ppU0c4NTNoQkljcVloWHB5Y3pmU2V4RE5RaVI2ZHVvOFJ3L1Nqd040?=
 =?utf-8?B?RStUWmFsRCtsbHNjbU5XWmQzdXpYVkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac10f99-d981-4ea6-9334-08dc7a628d33
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 13:24:47.3601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0744

QWxpY2UgUnlobCBXcm90ZToNCj4gUGxlYXNlIHByb3ZpZGUgYSBtb3JlIGNvbXBsZXRlIGNvbW1p
dCBkZXNjcmlwdGlvbi4gV2hhdCB1c2VyIG1vdGl2YXRlcw0KPiB0aGlzIGNoYW5nZT8NCg0KSSBz
ZW50IHR3byBuZXcgZW1haWxzIGJ1dCBJIHRob3VnaHQgSSBtYWRlIHNvbWV0aGluZyB3cm9uZyBj
YXVzZSBJdCBzZWVtcyBub3QgY29uc2VxdWVudCB3aXRoIHRoaXMuDQpBbmQgSSBmb3VuZCB0aGlz
IGlzc3VlIGF0IGh0dHBzOi8vZ2l0aHViLmNvbS9SdXN0LWZvci1MaW51eC9saW51eC9pc3N1ZXMv
MTA3Nw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQrlj5Hku7bk
uro6IEFsaWNlIFJ5aGwgPGFsaWNlcnlobEBnb29nbGUuY29tPg0K5Y+R6YCB5pe26Ze0OiAyMDI0
5bm0NeaciDIy5pelIDIwOjM3DQrmlLbku7bkuro6IG11MDAxOTk5DQrmioTpgIE6IG9qZWRhQGtl
cm5lbC5vcmc7IGJvcXVuLmZlbmdAZ21haWwuY29tOyBydXN0LWZvci1saW51eEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCuS4u+mimDogUmU6IFtQQVRDSF0g
cnVzdDoga2VybmVsOiBtYWtlIGltcGxfaGFzX3dvcmsgY29tcGF0aWJsZSB3aXRoIG1vcmUgY29t
cGxleCBnZW5lcmljcw0KDQpPbiBXZWQsIE1heSAyMiwgMjAyNCBhdCAyOjI34oCvUE0gbXUwMDE5
OTkgPG11MDAxOTk5QG91dGxvb2suY29tPiB3cm90ZToNCj4NCj4gU2lnbmVkLW9mZi1ieTogbXUw
MDE5OTkgPG11MDAxOTk5QG91dGxvb2suY29tPg0KDQpQbGVhc2UgcHJvdmlkZSBhIG1vcmUgY29t
cGxldGUgY29tbWl0IGRlc2NyaXB0aW9uLiBXaGF0IHVzZXIgbW90aXZhdGVzDQp0aGlzIGNoYW5n
ZT8NCg0KPiAgaW1wbF9oYXNfd29yayEgew0KPiAtICAgIGltcGw8VD4gSGFzV29yazxTZWxmPiBm
b3IgQ2xvc3VyZVdvcms8VD4geyBzZWxmLndvcmsgfQ0KPiArICAgIGltcGx7VH0gSGFzV29yazxT
ZWxmPiBmb3IgQ2xvc3VyZVdvcms8VD4geyBzZWxmLndvcmsgfQ0KPiAgfQ0KDQpJIGVuZGVkIHVw
IGRvaW5nIHNvbWV0aGluZyBzaW1pbGFyIGZvciB0aGUgZ2VuZXJpY3MgaW4gc29tZSBvZiB0aGUN
CmxpbmtlZCBsaXN0IHBhdGNoZXMuIERvZXMgYW55b25lIGtub3cgaWYgaXQncyBwb3NzaWJsZSB0
byBzdXBwb3J0IHRoaXMNCndpdGhvdXQgZ2l2aW5nIHVwIHRoZSA8VD4gc3ludGF4Pw0KDQpBbGlj
ZQ0K

