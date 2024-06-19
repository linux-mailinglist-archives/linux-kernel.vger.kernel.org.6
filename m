Return-Path: <linux-kernel+bounces-221243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF1490F0C8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C4F1F26F37
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2E91CD18;
	Wed, 19 Jun 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ZbU2494n"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2144.outbound.protection.outlook.com [40.92.63.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6C2374E;
	Wed, 19 Jun 2024 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807635; cv=fail; b=AYXsz5KTsYfUnqHsfxbySEJP7ulhtwBTRiENNnpI0UK3OcH3iJ4EIwU6ZD/vs9zB48IgUTKAAiNGEedT5uiQEeaSTIkfAIZ4TA68zqkxkI6AJ5qedRT53/gGHoXDWrMMbiMLfCTfYjLpm0KcJjHTttFVIEacP8G3mC7z0soXcbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807635; c=relaxed/simple;
	bh=9NfafMuBTzFv1V/t8ARAZKCF8lHqQyH67wmUYaMA0s0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QoR1INAOAAi6ilW2SX0ENSwxB/ixkAgS2+end6re06o8UMNsSy9k2B8EdIeXus51zh4aqKGrQjXHLM/VauZanazOzTNZv9Lsh/D0P9f6J3PTTzytFEeUWDAKnyGHEwgaaaDW4V/dzmN7MixE1xigP8AOC7XQztbA5bnfb9hIAZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ZbU2494n; arc=fail smtp.client-ip=40.92.63.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWeeoleM8l63yCQwwosFiepcWxb5u0xQeyr9l8tcNj9JXrcSTvbC+iubsAXEukETo+iifUM6o84jBJ4xCaxHH5usxTe+1CQPoswInMcOzXzVg6E47OuksIRlHZfUPHN0fIEvNp7tKLLr84QTg5vLNlb6sP0VgJ0jkQLW+D3gwgZOv/W/qkhWV+RYnQD5uybSHELo0xfNKsROkZI2t+a6vZk+b77ZearSsQDzK7BbcTUmml9bRHzJrw/KtfWQXFvGbHyk6yLbGEbvygKMqMQ0lECUuoYzHEcgdviXosE0f/RF+IUe3EuOrtVjd6JhKyl8+4254XMYQRpwcLeKMoYEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NfafMuBTzFv1V/t8ARAZKCF8lHqQyH67wmUYaMA0s0=;
 b=VQm8TQTNxJxZsNCedmZ13uitCxA/E6uVjbx285MOOA3pGn0x78U9Na0Pfnf8QO2U4jGNtWAwQ5P12FzDTCXhAcHR21xBlAEo97UnFAR9A9afiW6Xs8Fyd90eAltyXe/+LdHwOD9Kwb3LxH7xD680aId3aNzMtrkfSKNnobvM9ogt/mZ08d8Lq+V6WIgvyM4IVbkNR2r1hjhMd93pm5WJC2PDbqhYLMF35HtKAsAA5Yz0elA89w3vx6QB5OKqP519wjVotOkkXmHqcwCUNHF2omoKj4cGKNT9SPkTSPza7MWwWJjSJ7JoeRcu+m+1CoDZ56VEOQJIqsMzqIQPee9GWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NfafMuBTzFv1V/t8ARAZKCF8lHqQyH67wmUYaMA0s0=;
 b=ZbU2494nAGx+qV4vIt6gM2BgubkHxqbYhUpR4v/nSly/SqtSfGZP99CPBEXKcFtE/kEEIwCNCivs+hP4+KEDn3y0ROPYpc30rntPXxNigPK0iSQrdFuiq8byor5zUJ+QWFrKHh1aD24t3+zqjyTSI6hQaZoTTPw6LTqYGwqOb9PttD5KGp7oVLOHXhpi2hiSM7qByXn+/nOW8GuzLLwD6pUPZj+JreC8yqZdSLt9/3iaOy5xTbG4gtfXBPQwn7B12AmlI8+gv+bEBmPvVIqhSkdP9jd1UwrXToZZZNk8IFMTmzm8wJxIvQuCkPRC7DSsDCtB9nFRR7CNZ4fC3XQ71Q==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 SY8P282MB5055.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2b3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Wed, 19 Jun 2024 14:33:46 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%2]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 14:33:46 +0000
From: =?utf-8?B?6Z+15rabIOS7ow==?= <d1581209858@live.com>
To: Conor Dooley <conor@kernel.org>
CC: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Chen Wang
	<unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs mailbox
Thread-Topic: [PATCH 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs mailbox
Thread-Index: AQHawZIDXpA1fvG1y0K0Pqnnh8DDpbHNqAgAgAFy2Ao=
Date: Wed, 19 Jun 2024 14:33:46 +0000
Message-ID:
 <SYBP282MB2238E28A6EA276C7201CA621C4CF2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
References:
 <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <SYBP282MB22389FD1E07BBDC6FE1D90A0C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <20240618-monastery-manger-1a7d9a272f11@spud>
In-Reply-To: <20240618-monastery-manger-1a7d9a272f11@spud>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [wTE1DhrWKANTCGSUWgxC+uTctylnkmKg]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBP282MB2238:EE_|SY8P282MB5055:EE_
x-ms-office365-filtering-correlation-id: 3d2814d9-9738-4aeb-e64f-08dc906cd3b8
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199025|1602099009|4302099010|440099025|3412199022|102099029;
x-microsoft-antispam-message-info:
 cKW/JixePj5vyDIQrFRNQj53YCrr9Mz397BUZmnJVvnM9KhOIoRlRydKXVPjVSYXl0Bp7VOKYMu7WUT/uJXVniT/5UoitDbM+84s+I22K6n/AXLiM6MaH3TsKkVHcK8GV3ery/Lnv01wwLcGd4lARK3tJdVsz92XV5uVEG+y/HqHQSOqqU1wAan7al7lRUw5Cs7WhgOq1xlt6uxpNgL2qev56Vp6cTei1KHhEGVMzukoBoKzfZZZtNfCzuQ+Qm+LTH3cstTmGWG7HPczoiFO/i6mGAKHzraLJMz62OrOl11Qg9z0IujzHcdoTHRgKbt/WQclrgoL7HTVHARqfSVbIbM9kZvIr42g5kX9ETHJvfMZG8SSdAss0Hwjt7GoJIFLHfm+0VSn7Br/aciNdBssiMrlu/aSHFYRtuB8xmbjq9S8ZP1k+B4VrVVMEor9BsrbF+EzKt6Edj9m58YBShqnhTvtwnWgmQf3QYMI/8gzJXxsGBIY2ZsPPWcviXr02EpXQpOOazzEAEvCUmrw/YZb3dZkFC5/6cMvGXai7m/HQwod489u5lqq/DwjPYxnOzESRDcgrir7Wvjh0ISfydQT8R5S8VPJk0La7vB1ovXzXK1fc7Epn2l+wRSksmgMNR9p8CyEKMhFIIGyAPMja04nNg7JyCaHqiP0vesT6rELu3+BjzXIEMFkBtFiYbGhy9hZ
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUJTSm9pUFByY25mQ25vdFpSVUhlSUJ6MlQ0TlBKUjF0ckdEbml5eHNQM2d0?=
 =?utf-8?B?dTF6Rm9kajhxWTNvSVp1NE1OMW9FSHA5MWZlUUprblhOakVINHIrVjZ6aVl5?=
 =?utf-8?B?UnE2aE9jMDdoaDFjdWkwUlhHMDNSc2lBa1ZueEowN1RxMVU4UlAxb0NQSzRX?=
 =?utf-8?B?SFZ4YXNCaFdWanIvVmxHM09JWTJ0TTh5WExmRmt2MzNuODlFbHVBdk1BdjZl?=
 =?utf-8?B?aXRBekN6V3RxSENxTzlnaElWbWx1UjlMeHRIT01BZFJjOHJ5OUtVNkl3OW51?=
 =?utf-8?B?Wjd0Y3JIVzlFU1NoRnZVT0wrdkFrZjJSTUVvNjVJVUlVenlDSDhTVjNFUUho?=
 =?utf-8?B?bUVqRHhaSW8vQVQrWmFibjlib1JIWDB6dnNrbHR2VWp6WE45OWJZNHNPQVd6?=
 =?utf-8?B?elR0MTFyTWlQN2QxckdiWkliTkcyMmViWDdFN01pY3R6NGxXVWhIakdYK0hX?=
 =?utf-8?B?QUZ6TFV1Q1dRVU93Z2xXRm56Mi9KZndrb0FWYmsrMWNzUWhPUk1aZW4vYVpv?=
 =?utf-8?B?RVdxVkMrK0luUGhySnZLaE1aVHFkNk9lcTdHbDR6VjlEYkZOMGRrYWs0aUx5?=
 =?utf-8?B?VUlFQ0I4QXMrQzAvRkZUQ3V6QmFxc1lLM0dPa2w4YU5YanA3ODFad3BkWkVo?=
 =?utf-8?B?OG9oWEcwOGxqWkV6MVBETHBOQ2ZTTjFCSWkxRGwrL241Sy9vY09pNldVNGxi?=
 =?utf-8?B?cGErUHpYVUhZTmdRaC9td1R3d2RQOHRFdmVrWldxckRTS0IyUHZPS1BwdkpY?=
 =?utf-8?B?WCtlekNlVVcvckt2RnV4aWx5dmYrb3FjbUVnVHFONDlXVkFFVjVQZ2RlWjR3?=
 =?utf-8?B?MGp2VG5TOHdxK2V4ZzFKMEZYNjgyVWw4bzAxeUhzNkNNVmRNcEFkQ2dLbFI5?=
 =?utf-8?B?NHRvdWRyMTFwcXp2MXVraGFqcmJSOWNNb1U0NkpsVXVaODl5R0ZZZ1UwQXQx?=
 =?utf-8?B?Rzg1RXlBV1B4S2VRamhnMXZhaldYRGRXS2toZUpIblN2SmhJeWVQbGROQ1NR?=
 =?utf-8?B?V2FISEorb2Z1ZVBCSHJIRXFadGNITkZndFQ4LzlpRHJYN01EV3dxRVJ0bmtR?=
 =?utf-8?B?c3Vmb0wyVzNBVi9QMUFlaTl1dnloNXpYUE0xZzRCaFR1bDR1ZTU5UlpNNkhj?=
 =?utf-8?B?RndESHgyNThOblg5MmZ5U05PQm9Rek5RN3hrUFQ4eXpyWWE0bW1yQ0UxSzVj?=
 =?utf-8?B?TUE5bHlBZ2pqSHY0MFdqY1lPMlFJMk4rSnFVMloxQU1HcUxVNFk2N1ppVTI0?=
 =?utf-8?B?Z1piRmhqbWhWNm15SmVGUkJQWUVObm5TMStwMFFnMVphLzM1R2dReC9vN253?=
 =?utf-8?B?dUNCWnBvSnRoUTk5OFptZnExcGRCaVQ0Si81NmVPZXh0clF2aUFwanNpREFo?=
 =?utf-8?B?bUx3OUg0M1c2djlleVJSS1RPS3plVXlMS0ZzTzF5S0FNbWFySGFDWElkMnBu?=
 =?utf-8?B?Z3NqbHN5bktKZGZFT0ttOGdDSGxOVFB0dTlLK3FnZHVzRHN6MThQWDV5azZB?=
 =?utf-8?B?VkJSemQ5eHNsK2J6NFVmMEhEMU9va2JSNE1SVjNKbTRuY3Y0THppaUhyV0RX?=
 =?utf-8?B?UTh6TDhEYng1dEtIVzZXeEhjVFIvRVVmQUxEWFpzcitLalpxVjJUTzBUeTEw?=
 =?utf-8?Q?FspZW6BaEkuB6e412Lj7X1lsJKqir3r0rqYMec9orspc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2814d9-9738-4aeb-e64f-08dc906cd3b8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 14:33:46.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB5055

SGkgQ29ub3IsCgo+IEZyb206wqBDb25vciBEb29sZXkKPiBTZW50OsKgVHVlc2RheSwgSnVuZSAx
OCwgMjAyNCAyMzozOAo+IFRvOsKgWXVudGFvIERhaQo+IENjOsKgamFzc2lzaW5naGJyYXJAZ21h
aWwuY29tOyByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2Vy
bmVsLm9yZzsgdW5pY29ybl93YW5nQG91dGxvb2suY29tOyBpbm9jaGlhbWFAb3V0bG9vay5jb207
IHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VAZWVjcy5i
ZXJrZWxleS5lZHU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnCj4gU3ViamVjdDrC
oFJlOiBbUEFUQ0ggMS8zXSBkdC1iaW5kaW5nczogbWFpbGJveDogYWRkIFNvcGhnbyBjdjE4eCBT
b0NzIG1haWxib3gKPiAKPiAKPiBPbiBUdWUsIEp1biAxOCwgMjAyNCBhdCAxMToxMjozM1BNICsw
ODAwLCBZdW50YW8gRGFpIHdyb3RlOgo+IAo+ID4gQWRkIGRldmljZXRyZWUgYmluZGluZ3MgZG9j
dW1lbnRhdGlvbiBmb3IgU29waGdvIGN2MTh4IFNvQ3MgbWFpbGJveAo+IAo+ID4KPiAKPiA+IFNp
Z25lZC1vZmYtYnk6IFl1bnRhbyBEYWkgPGQxNTgxMjA5ODU4QGxpdmUuY29tPgo+IAo+ID4gLS0t
Cj4gCj4gPsKgIC4uLi9tYWlsYm94L3NvcGhnbyxjdjE4MDBiLW1haWxib3gueWFtbMKgwqDCoMKg
wqDCoCB8IDc1ICsrKysrKysrKysrKysrKysrKysKPiAKPiA+wqAgMSBmaWxlIGNoYW5nZWQsIDc1
IGluc2VydGlvbnMoKykKPiAKPiA+wqAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L3NvcGhnbyxjdjE4MDBiLW1haWxib3gueWFtbAo+
IAo+ID4KPiAKPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWFpbGJveC9zb3BoZ28sY3YxODAwYi1tYWlsYm94LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9zb3BoZ28sY3YxODAwYi1tYWlsYm94LnlhbWwKPiAK
PiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gCj4gPiBpbmRleCAwMDAwMDAwMDAuLmUxODY4YWFm
Mgo+IAo+ID4gLS0tIC9kZXYvbnVsbAo+IAo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21haWxib3gvc29waGdvLGN2MTgwMGItbWFpbGJveC55YW1sCj4gCj4gPiBA
QCAtMCwwICsxLDc1IEBACj4gCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0y
LjAgT1IgQlNELTItQ2xhdXNlKQo+IAo+ID4gKyVZQU1MIDEuMgo+IAo+ID4gKy0tLQo+IAo+ID4g
KyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbWFpbGJveC9zb3BoZ28sY3YxODAw
Yi1tYWlsYm94LnlhbWwjCj4gCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21l
dGEtc2NoZW1hcy9jb3JlLnlhbWwjCj4gCj4gPiArCj4gCj4gPiArdGl0bGU6IFNvcGhnbyBjdjE4
MDBiIG1haWxib3ggY29udHJvbGxlcgo+IAo+ID4gKwo+IAo+ID4gK21haW50YWluZXJzOgo+IAo+
ID4gK8KgIC0gWXVudGFvIERhaSA8ZDE1ODEyMDk4NThAbGl2ZS5jb20+Cj4gCj4gPiArCj4gCj4g
PiArZGVzY3JpcHRpb246Cj4gCj4gPiArwqAgVGhlIFNvcGhnbyBjdjE4eCBTb0NzIG1haWxib3gg
aGFzIDggY2hhbm5lbHMgYW5kIDggYnl0ZXMgcGVyIGNoYW5uZWwgZm9yCj4gCj4gPiArwqAgZGlm
ZmVyZW50IHByb2Nlc3NvcnMuIEFueSBwcm9jZXNzZXIgY2FuIHdyaXRlIGRhdGEgaW4gYSBjaGFu
bmVsLCBhbmQKPiAKPiA+ICvCoCBzZXQgY28tcmVzcG9uZGluZyByZWdpc3RlciB0byByYWlzZSBp
bnRlcnJ1cHQgdG8gbm90aWNlIGFub3RoZXIgcHJvY2Vzc29yLAo+IAo+ID4gK8KgIGFuZCBpdCBp
cyBhbGxvd2VkIHRvIHNlbmQgZGF0YSB0byBpdHNlbGYuCj4gCj4gPiArwqAgU29waGdvIGN2MTh4
IFNvQ3MgaGFzIDMgcHJvY2Vzc29ycyBhbmQgbnVtYmVyZWQgYXMKPiAKPiA+ICvCoCA8MT4gQzkw
NkwKPiAKPiA+ICvCoCA8Mj4gQzkwNkIKPiAKPiA+ICvCoCA8Mz4gODA1MQo+IAo+ID4gKwo+IAo+
ID4gK3Byb3BlcnRpZXM6Cj4gCj4gPiArwqAgY29tcGF0aWJsZToKPiAKPiA+ICvCoMKgwqAgZW51
bToKPiAKPiA+ICvCoMKgwqDCoMKgIC0gc29waGdvLGN2MTgwMGItbWFpbGJveAo+IAo+ID4gKwo+
IAo+ID4gK8KgIHJlZzoKPiAKPiA+ICvCoMKgwqAgbWF4SXRlbXM6IDEKPiAKPiA+ICsKPiAKPiA+
ICvCoCBpbnRlcnJ1cHRzOgo+IAo+ID4gK8KgwqDCoCBtYXhJdGVtczogMQo+IAo+ID4gKwo+IAo+
ID4gK8KgIGludGVycnVwdC1uYW1lczoKPiAKPiA+ICvCoMKgwqAgY29uc3Q6IG1haWxib3gKPiAK
PiA+ICsKPiAKPiA+ICvCoCByZWN2aWQ6Cj4gCj4gPiArwqDCoMKgIG1heEl0ZW1zOiAxCj4gCj4g
PiArwqDCoMKgIGRlc2NyaXB0aW9uOgo+IAo+ID4gK8KgwqDCoMKgwqAgVGhpcyBjZWxsIGluZGlj
YXRlcyB0aGUgbWFpbGJveCBjb250cm9sbGVyIGlzIHJ1bm5pbmcgb24gd2hpY2ggcHJvY2Vzc29y
Cj4gCj4gCj4gCj4gWW91IGNhbiBqdXN0IGxvb2sgdXAgeW91ciBoYXJ0aWQgYXQgcnVudGltZSwg
d291bGRuJ3QgdGhhdCBiZQo+IAo+IHN1ZmZpY2llbnQ/Cj4gCgp0aGFua3MgeW91ciBhZGR2aWNl
LCBJIHdpbGwgZml4IGl0Cgo+IAo+ID4gKwo+IAo+ID4gK8KgIHNlbmR0bzoKPiAKPiA+ICvCoMKg
wqAgbWF4SXRlbXM6IDEKPiAKPiA+ICvCoMKgwqAgZGVzY3JpcHRpb246Cj4gCj4gPiArwqDCoMKg
wqDCoCBUaGlzIGNlbGwgaW5kaWNhdGVzIHRoZSBtZXNzYWdlIHNlbmRzIHRvIHdoaWNoIHByb2Nl
c3Nvcgo+IAo+IAo+IAo+IENhbid0IHRoaXMgZ28gaW50byBhbiBtYm94IGNlbGw/IEhhdmluZyB0
aGlzIHByb3BlcnR5IHdvdWxkIGxpbWl0IHRoZQo+IAo+IG1haWxib3ggdG8gb25seSBjb21tdW5p
Y2F0aW5nIHdpdGggMSBvZiB0aGUgMiBhdmFpbGFibGUgcHJvY2Vzc29ycy4KPiAKCkkgd2lsbCBm
aXggaXQKCj4gQ2hlZXJzLAo+IAo+IENvbm9yLgo+IAo+IAo+IAo+ID4gKwo+IAo+ID4gKwo+IAo+
ID4gK8KgICIjbWJveC1jZWxscyI6Cj4gCj4gPiArwqDCoMKgIGNvbnN0OiAxCj4gCj4gPiArwqDC
oMKgIGRlc2NyaXB0aW9uOgo+IAo+ID4gK8KgwqDCoMKgwqAgVGhpcyBjZWxsIGluZGljYXRlcyB3
aGljaCBjaGFubmVsIGlzIHVzZWQKPiAKPiA+ICsKPiAKPiA+ICtyZXF1aXJlZDoKPiAKPiA+ICvC
oCAtIGNvbXBhdGlibGUKPiAKPiA+ICvCoCAtIHJlZwo+IAo+ID4gK8KgIC0gaW50ZXJydXB0cwo+
IAo+ID4gK8KgIC0gcmVjdmlkCj4gCj4gPiArwqAgLSBzZW5kdG8KPiAKPiA+ICvCoCAtICIjbWJv
eC1jZWxscyIKPiAKPiA+ICsKPiAKPiA+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UKPiAK
PiA+ICsKPiAKPiA+ICtleGFtcGxlczoKPiAKPiA+ICvCoCAtIHwKPiAKPiA+ICvCoMKgwqAgI2lu
Y2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPgo+IAo+ID4gKwo+
IAo+ID4gK8KgwqDCoCBtYWlsYm94OiBtYWlsYm94QDE5MDAwMDAgewo+IAo+ID4gK8KgwqDCoMKg
wqDCoMKgIGNvbXBhdGlibGUgPSAic29waGdvLGN2MTgwMGItbWFpbGJveCI7Cj4gCj4gPiArwqDC
oMKgwqDCoMKgwqAgcmVnID0gPDB4MDE5MDAwMDAgMHgxMDAwPjsKPiAKPiA+ICvCoMKgwqDCoMKg
wqDCoCBpbnRlcnJ1cHRzID0gPDEwMSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsKPiAKPiA+ICvCoMKg
wqDCoMKgwqDCoCBpbnRlcnJ1cHQtbmFtZXMgPSAibWFpbGJveCI7Cj4gCj4gPiArwqDCoMKgwqDC
oMKgwqAgaW50ZXJydXB0LXBhcmVudCA9IDwmcGxpYz47Cj4gCj4gPiArwqDCoMKgwqDCoMKgwqAg
cmVjdmlkID0gPDE+Owo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgIHNlbmR0byA9IDwyPjsKPiAKPiA+
ICvCoMKgwqDCoMKgwqDCoCAjbWJveC1jZWxscyA9IDwxPjsKPiAKPiA+ICvCoMKgwqAgfTsKPiAK
PiA+IC0tCj4gCj4gPiAyLjE3LjEKCkJlc3QgcmVnYXJkcywKWXVudGFv

