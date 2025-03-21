Return-Path: <linux-kernel+bounces-571414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62325A6BCDB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32E61735CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8576C19C54B;
	Fri, 21 Mar 2025 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="cJrfZNqS"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010010.outbound.protection.outlook.com [52.103.68.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FDB78F51
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567038; cv=fail; b=SOPm32j22QCDUSe7vD7gkHRVEgOjNNk8gFJavmCOjsFJ6qlBKl3okOQPCw6IdraQr78xpaN5Fs8BeS7tiZ5d4HGWT925uZscgWReI3fxQguQIisOFaDPQXaAxWHUvK8W7ybMfqljouVZQpxMKFrujlaI9DYgpZ9lnYYAqcANuUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567038; c=relaxed/simple;
	bh=hBU5YcSTomJxiRK3/T9TB25KOxASilPLA8Wgj7cIp9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JVVCtIGFWkX+z09mkjZyCimw75WAxddRqgP3SZOZ5dcOQ42zWE4kp8fI60s9BTv17bfJ8HK/McPFqQSu/grD27CtubcXABtvIG0Uz0dguUD7U2NTltVL3Sw8hAteP88yIti4BM10mAw7yCUGpd+gN6dLI43T1SJkUhAqGG65ZkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=cJrfZNqS; arc=fail smtp.client-ip=52.103.68.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTxKWF4J3DIH4JqvLboDYegKng76b9kTCgoHDT5eLJP5WZMr8rXyMT9hCZwAB4Alr1/xA9bV4MTpdUCTo0oWbZH5XTd50cTfY7eLKSNnRNNQm95MpZEy6GiORqSA0e5S8fpakWyPtYr5qsqLQWslykui/Ff2d9VCEjpdFLPO/wt60RjGz4/KIXbo1DNYzDNnz/k7Q7VKr1CiVi+zCtWejMA7sH/KnlFpomNzboFXx/KY+gemxHJTple/H+Ya5o7/aXZDnx5rSn27O8n47vZ3cR8/ng0He49rf1K9Wb9uRy01pmU3I6EuKwhdyzdifkc3tNh3+X8vqiPE5nw5YB6V8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBU5YcSTomJxiRK3/T9TB25KOxASilPLA8Wgj7cIp9w=;
 b=nJNmwflvnClZfqWcqFqeYdJxOmo1/ikGSOrVwrHqo/jUu5lHbIFH+pmGMU6HEbDHgmzHvdCpB61IsyOqTj4qh6D58t0l7LLeH3SgVN67pXWRsa77HRLpGnn5zqAXfESrkJyYwgnk2AWcOWkHYPppLxMCPR56bU/8+LX8AVWr91FDaNf8qpFrSikhKZqaAvGONDIEsTa9gWvJnCWnOdUM7lzqb+nYG+Kw5l7P5ix8Rxg2U5d69UGoeslYs7bNlgU4DmChUx6hZLF5xq6g0PDmYhnPIuGLbRMkQGh4vqTLLizJbJLsmhX3LnnBhlVedpvo1nhrrWdqE90B5Ls1orfq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBU5YcSTomJxiRK3/T9TB25KOxASilPLA8Wgj7cIp9w=;
 b=cJrfZNqSf+7i3C3RlGkVD6u7SihKT6H0ngTOrakBr7RWX5c58sswp52abD5G/qLUQ//aRXHPIKydE8Colu4L1yEDn00tWfvNZpQ71fwX8fVUK/UDuIIAAh3cFJ6qbw35pn1+w5Lh8Z4hhNx+E5SyI3PO6VJyInZMYYOCKyEEzGIV13b8P/KLeA2ygFi7QyrShaCMkSwUmPrMXv8xjTTCADqrPUil6SNwD086UB7yElB04O1R7cp6KXiXNYJpkkV6bfcl5L3f64peBMKpJwOHntoGXPl3YPCuSVmqCcBbbvsVWB2o6q6gi1IRHfHSIXbsM7CzgKFh54BC2763aaQw8w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB7993.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:41::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 21 Mar
 2025 14:23:51 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 14:23:51 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Tamir Duberstein <tamird@gmail.com>
CC: Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printf: add tests for generic FourCCs
Thread-Topic: [PATCH] printf: add tests for generic FourCCs
Thread-Index: AQHblJN29TpfMnJ0tk2R2endOOpYG7N9rp6AgAAB9u0=
Date: Fri, 21 Mar 2025 14:23:51 +0000
Message-ID:
 <PN3PR01MB95976F630E0E4004CDC5310DB8DB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <4378DDFE-3263-497A-8364-433DC1984FEE@live.com>
 <CAJ-ks9=zN0pUAt9ELckna+3GcnDfhjF3jgiM1FHXLji9pWc2wQ@mail.gmail.com>
In-Reply-To:
 <CAJ-ks9=zN0pUAt9ELckna+3GcnDfhjF3jgiM1FHXLji9pWc2wQ@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB7993:EE_
x-ms-office365-filtering-correlation-id: 267320d6-a3a2-4448-19cc-08dd688400c8
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|461199028|8062599003|7092599003|6072599003|15080799006|10035399004|4302099013|3412199025|440099028|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?utf-8?B?SG1rZHRBNzY4Q01YUE5WaDVDVU1rTnZ4UHBCbzNUMVRncGlRQXEyMFNkOHBY?=
 =?utf-8?B?S254dFYxNFRLcVpuODd5cWhHUU9IRGJmeDFKV1BYNUJ5QmNiTjhSVk5wbWZq?=
 =?utf-8?B?RkFDb1hwZ2ZaRFpSdzJuUlBrYWxiTkdWNzFtK0oxR2dvc3BnaEpINUtKcE5n?=
 =?utf-8?B?STE4TTFybkF1RWhvWWIzanpiUE5Xd1V5cXhGcHY4cE1NNnNDd0Mzcnptamli?=
 =?utf-8?B?WTluWFpMcjVKc2ptWXhDZUdQajBTeVVpdkRCYlh5OFFCUkVMMUxQVjVHSFV3?=
 =?utf-8?B?K0I2UXRVeFlKRXU3c29SUnpXNkp5S3BqemloanRENEVyc0RPaEQvaTdNNWZq?=
 =?utf-8?B?ZkZCYUxoOGhWZFdPSDhvUG9KS0krVm9aK2RDVHViNGhxM1J6Q2RYeDYzRytE?=
 =?utf-8?B?RlZoMERXcnpKb3ZQMG42RmtzcjI4eFZVMS9DYkJTNlBhWkNwalB1UFV4dzVl?=
 =?utf-8?B?SlV4M0ppaFNSVjcwV2ZiKzNuUnBwQ1B1bVJrdTA4RnZPVG9RTngycjB3Mk83?=
 =?utf-8?B?QmVjelE5L1FINUxHeVFmMnI5WndwMFBpRWY4WFpvUE5uMnNPQ0k3MTB1ZHF2?=
 =?utf-8?B?eFNkMTltazdyeisrWmdmL25rWW1LcFl3eUpnWUlDSWdXQXBZWjNoeUM2QlVG?=
 =?utf-8?B?WTlMNG9WY01BWDVlR2F2VFNtaDRBYlhpdjIyY1dMZUsxM25oZ2c3V1FoS1ky?=
 =?utf-8?B?ZGhjVGVIZVk1N2VObzczNjl5NnFzaVBhWnQ4c2lJQ3I1RTh4WFlhN0FyZ2xS?=
 =?utf-8?B?bWZpdUwyUVhMeDlsQk4yVEhIRmNlaGNiekUzcDNkRVFYSFFsN3kyK1IyRkJn?=
 =?utf-8?B?eS93YmFRRmt2Zk5FdWhiSTkyNG41WVM3OEFZZ09NaUxjZFNvT2QwbEczclY0?=
 =?utf-8?B?NDlWWmhncGIwZkt2NmRSb0dFbllkOHNpZjhuTnlyZXk1aDJvY3BEQTdNbk5p?=
 =?utf-8?B?OVhkSXN0cytZeGdiTS9mWm1PKzVHbnBGWjBKZlVWaUNjRnlicDM4V3dsZkY4?=
 =?utf-8?B?Nk9vRXRpV2Y0ZTQrMmdlcHV0L3RmTFVsL0J6MnVIUEdLQmJqL2RjVE1FQk9I?=
 =?utf-8?B?dlhMYzlXVFgwYm04TnI2QWQxSFp0Qk51QkJZZHkzY0RFRnUrck5GRXVqckhM?=
 =?utf-8?B?SmMwYmkrS2EwSjZaNUlFVTd0c3NQZDByNDNET3hTZ0RkLzF5Wm1leEdtaU1B?=
 =?utf-8?B?MXRVc1EveGx2QmZNc0l4eFlLUkNEY3RMc1Vmd1c0QjJZU2FBT3Nmb3RBMHBE?=
 =?utf-8?B?dE5KV3JXc1hSUlJDTnRTWnJMQkZrd1BQVDZFVzVyNVprbXZWdXpVVDVmOEdw?=
 =?utf-8?B?WEJTbUxzeWtsbUFGUnpmbmRXYXo1WGhxSHg1QnRVaWcrdXBSQkkzYStDTEpl?=
 =?utf-8?B?VTRTYWpFdDduNEw0bCs0NnlRQ0dPa3U2a3JFWUJ0dlVFSXFFWVVVNmxHT294?=
 =?utf-8?B?T1JuYXBERjZmbThiSm56MVBEa1pPYlp0b3RDdmwzRUVRZHU0cVY5L0V6bVpo?=
 =?utf-8?B?U1NCYVFGQjM3WlE2VmJFMjcwN0dZVTFpSVQxdGtXQXhpRWt0aWlqQlFZbkpI?=
 =?utf-8?B?RXZaZU1rSUVia1Fhejl2MEZLZEpZeU9TN2Y1TU9BaGVYTHhYYUZPM3lIeDNt?=
 =?utf-8?B?NGlnWWdtelNaS2FJKzVqRVQrdVRSYlFaLzJQRHU0WWxCc3JOS1lVZ1pJY2Jh?=
 =?utf-8?Q?SwiPMeiK+Nw7x4Izo17e?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnZIeWwvYTlUZW1OZ0FKWFYwMk1VUkx5KzZJUkZBR29YQXg5NTZPVFpvejRn?=
 =?utf-8?B?dzdxTXlsQUhkKy9xRk9nOTBlaURGTVhwL21MYTlqVDd3SDVJTE1TWUFJbm00?=
 =?utf-8?B?ZUN3anNHYzV6MGtWNFFLazd2SnRSSkxxakhoNVY4b0trTU1oZ0dzZHBqaEhD?=
 =?utf-8?B?ODRoN05iUUtCMEViaWNwdWJZN1pnNzZxQnFqTXA4dVFhQkgySHptaUM3M29t?=
 =?utf-8?B?WkFoK0xqMTJWbW5FckpianhsSHJxSEloVklvM0ZzTXZUVkZ1Y0I0enFLeEQz?=
 =?utf-8?B?LytIVUgrMkJmemNzdC96K1ZFUWY5MFZpSlg3cmpqaXJOQTNhRlRxenExWXRV?=
 =?utf-8?B?TE9YMHZPOHA0WnRLdmY5Y3RhdFJCZlUrK3B5SGVKYTdUY2hFQUdZS0U0T21B?=
 =?utf-8?B?ZnFUNFFHRWx4dElvQ3k4czJ2eUs4a0lGYWJZR2pubC9hT0IvM2xFOHQ0RWsv?=
 =?utf-8?B?R3YyTDBaR2ZJVDR4cm5PQVZ6b3Vob2s2NVZZMXk1dUZsYittdkpvY09zR2xm?=
 =?utf-8?B?Zy9xTkxKc2NjUTFRSkRUakx0YXp6VzZjQy9tMGZJakVsOHQ4eFFmNVgwN1NW?=
 =?utf-8?B?RXhwOThtMlQvMU5OWlNTTURocEZkVkhtaTZpL1NDVmhRV1B6cDJ1M0p6dG0y?=
 =?utf-8?B?eW90RnN3ODNVemlKczJkSktIaHZvR0JhQjArN1p0YnNwZ1FpL2RYNExEN3VT?=
 =?utf-8?B?K3lVTzBFL2JmMXRLR1AvK2FUTFBHL0lkMUpqaHlqZjZHY2RKeEhQaENkbVFV?=
 =?utf-8?B?N2wvVjlGMVU0VThPMVhXWkMzYTBRNzZ0ZkZNUE90a3E5T2hSeTBjMjJlWVZo?=
 =?utf-8?B?bFJjeDRNY3B1eWFkM2Nuc0ZFRkVzditlMHVqcmxvWTYyYjBva0ZveGlRVExX?=
 =?utf-8?B?UE0rZE56RTJhWi9pUzhVRE5HaWkwYnFwWWRBdmV6cjBLMElCRERnMXF1K3I1?=
 =?utf-8?B?WS9weWNIYXpQY2Q0SVdkVzJrcFV2YVVnTC9hdzVZd2dDYmhSUXJsVm55TEZn?=
 =?utf-8?B?KytxTE9ybUFHTVYyenVPVy8yQzIyZ2hiV1RhbUNXVVR0SnROZWI2M2J5dm0w?=
 =?utf-8?B?NHNwOFVvSHI2T3JuTVkxWUkyVnUzQ1cxOU1qYS9wTTNTaXh4MWhNMnVpOGo2?=
 =?utf-8?B?QkVnZHh6ZjRWYXBEN3lNRzJXNUdhUDc2TFFYd29ZSjhTamorQkhxNTZHbVJk?=
 =?utf-8?B?bWtQVHJjK3N2TDRUaGRhZExRQU1kcXN3Wm9lWXBDbFNtUjN6RDE2OTlzMkM5?=
 =?utf-8?B?c2wxdjVBSmZ6bGUyRWFYZjIvZWIxZ09lYlJpVzFreGtFRHI3ekNLUTRCZk1s?=
 =?utf-8?B?RlRuSUJaUkNRaG45a1EwZGljVm8yM3lURm5wYWhVRkNydmFsR01kalRkaEFp?=
 =?utf-8?B?VlVuOTZVdWppUlllQTJzejhWUisvU0VROVlKTXNZNHZndHZCQ0ZLTkxKQzEz?=
 =?utf-8?B?b2JTcWhJN0UwcUYwakZBRERkSzhqOWVJZFp3N0l1YXF2MEhhVHU1ZU9BTHh5?=
 =?utf-8?B?M1dRclhJOVR6QnJ2QjhxbXFmT3BwM3ExRUthbUFLWmluVnlrZWZjSFQ4VTBX?=
 =?utf-8?B?RngwZlI3OTl0TkpuNy9GWEZvVlZJQ2FSaGg0dmE4bjdzUnppZnZndHVyc1Qw?=
 =?utf-8?B?WTA0enp6dkFVWVpxcmdEOEtCaUR1L3NTVWZ2U1dwZGJKNnh5WnlsUGJTNXJD?=
 =?utf-8?B?L0VCOVR4cGliYmJPeGNaYUpiSU5sSW4wV28xNExRLzRXcTBJaXBVZE1jaVkw?=
 =?utf-8?Q?Str3PD8PDdNDcdVtGY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 267320d6-a3a2-4448-19cc-08dd688400c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 14:23:51.4250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB7993

DQoNCj4gT24gMjEgTWFyIDIwMjUsIGF0IDc6NDfigK9QTSwgVGFtaXIgRHViZXJzdGVpbiA8dGFt
aXJkQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79PbiBUaHUsIE1hciAxMywgMjAyNSBhdCAx
MTo0NeKAr1BNIEFkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhAbGl2ZS5jb20+IHdyb3RlOg0KPj4g
DQo+PiBGcm9tOiBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxpdmUuY29tPg0KPj4gDQo+PiBG
b3JtYXQgc3BlY2lmaWVycyBmb3IgcHJpbnRpbmcgZ2VuZXJpYyAzMi1iaXQgRm91ckNDcyB3ZXJl
IHJlY2VudGx5IGFkZGVkDQo+PiB0byB2c3ByaW50Zi4gVGhleSBhcmUgZ29pbmcgdGhyb3VnaCB0
aGUgRFJNIHRyZWUgYWxvbmd3aXRoIHRoZSBhcHBsZXRiZHJtDQo+PiBkcml2ZXIuIFNpbmNlIHRo
ZSBwcmludGYgdGVzdHMgYXJlIGJlaW5nIGNvbnZlcnRlZCB0byBrdW5pdCwgdGhpcyBzZXBhcmF0
ZQ0KPj4gcGF0Y2ggZm9yIHRoZSB0ZXN0cyBzaG91bGQgbWFrZSBpdCBlYXNpZXIgdG8gcmViYXNl
IHdoZW4gdGhlIG1lcmdlIHdpbmRvdw0KPj4gb3BlbnMuDQo+PiANCj4+IExpbms6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2RyaS1kZXZlbC83OUZBM0Y0MS1GRDdBLTQxRDktODUyQi1EMzI2MDZB
RjVFQjRAbGl2ZS5jb20vVC8jdQ0KPj4gU2lnbmVkLW9mZi1ieTogQWRpdHlhIEdhcmcgPGdhcmdh
ZGl0eWEwOEBsaXZlLmNvbT4NCj4+IC0tLQ0KPj4gbGliL3Rlc3RzL3ByaW50Zl9rdW5pdC5jIHwg
MzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+PiAxIGZpbGUgY2hh
bmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdp
dCBhL2xpYi90ZXN0cy9wcmludGZfa3VuaXQuYyBiL2xpYi90ZXN0cy9wcmludGZfa3VuaXQuYw0K
Pj4gaW5kZXggMmM5ZjYxNzBiLi5iMWZhMGRjZWEgMTAwNjQ0DQo+PiAtLS0gYS9saWIvdGVzdHMv
cHJpbnRmX2t1bml0LmMNCj4+ICsrKyBiL2xpYi90ZXN0cy9wcmludGZfa3VuaXQuYw0KPj4gQEAg
LTcwMSwyMSArNzAxLDQ2IEBAIHN0YXRpYyB2b2lkIGZ3bm9kZV9wb2ludGVyKHN0cnVjdCBrdW5p
dCAqa3VuaXR0ZXN0KQ0KPj4gICAgICAgIHNvZnR3YXJlX25vZGVfdW5yZWdpc3Rlcl9ub2RlX2dy
b3VwKGdyb3VwKTsNCj4+IH0NCj4+IA0KPj4gK3N0cnVjdCBmb3VyY2Nfc3RydWN0IHsNCj4+ICsg
ICAgICAgdTMyIGNvZGU7DQo+PiArICAgICAgIGNvbnN0IGNoYXIgKnN0cjsNCj4+ICt9Ow0KPj4g
Kw0KPj4gK3N0YXRpYyB2b2lkIGZvdXJjY19wb2ludGVyX3Rlc3Qoc3RydWN0IGt1bml0ICprdW5p
dHRlc3QsIGNvbnN0IHN0cnVjdCBmb3VyY2Nfc3RydWN0ICpmYywNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc2l6ZV90IG4sIGNvbnN0IGNoYXIgKmZtdCkNCj4+ICt7DQo+PiAr
ICAgICAgIHNpemVfdCBpOw0KPj4gKw0KPj4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgbjsgaSsr
KQ0KPj4gKyAgICAgICAgICAgICAgIHRlc3QoZmNbaV0uc3RyLCBmbXQsICZmY1tpXS5jb2RlKTsN
Cj4+ICt9DQo+PiArDQo+PiBzdGF0aWMgdm9pZCBmb3VyY2NfcG9pbnRlcihzdHJ1Y3Qga3VuaXQg
Kmt1bml0dGVzdCkNCj4+IHsNCj4+IC0gICAgICAgc3RydWN0IHsNCj4+IC0gICAgICAgICAgICAg
ICB1MzIgY29kZTsNCj4+IC0gICAgICAgICAgICAgICBjaGFyICpzdHI7DQo+PiAtICAgICAgIH0g
Y29uc3QgdHJ5W10gPSB7DQo+PiArICAgICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZm91cmNjX3N0
cnVjdCB0cnlfY2NbXSA9IHsNCj4+ICAgICAgICAgICAgICAgIHsgMHgzMjMxNTY0ZSwgIk5WMTIg
bGl0dGxlLWVuZGlhbiAoMHgzMjMxNTY0ZSkiLCB9LA0KPj4gICAgICAgICAgICAgICAgeyAweGIy
MzE1NjRlLCAiTlYxMiBiaWctZW5kaWFuICgweGIyMzE1NjRlKSIsIH0sDQo+PiAgICAgICAgICAg
ICAgICB7IDB4MTAxMTEyMTMsICIuLi4uIGxpdHRsZS1lbmRpYW4gKDB4MTAxMTEyMTMpIiwgfSwN
Cj4+ICAgICAgICAgICAgICAgIHsgMHgyMDMwMzE1OSwgIlkxMCAgbGl0dGxlLWVuZGlhbiAoMHgy
MDMwMzE1OSkiLCB9LA0KPj4gICAgICAgIH07DQo+PiAtICAgICAgIHVuc2lnbmVkIGludCBpOw0K
Pj4gKyAgICAgICBzdGF0aWMgY29uc3Qgc3RydWN0IGZvdXJjY19zdHJ1Y3QgdHJ5X2NoW10gPSB7
DQo+PiArICAgICAgICAgICAgICAgeyAweDQxNDI0MzQ0LCAiQUJDRCAoMHg0MTQyNDM0NCkiLCB9
LA0KPj4gKyAgICAgICB9Ow0KPj4gKyAgICAgICBzdGF0aWMgY29uc3Qgc3RydWN0IGZvdXJjY19z
dHJ1Y3QgdHJ5X2NuW10gPSB7DQo+PiArICAgICAgICAgICAgICAgeyAweDQxNDI0MzQ0LCAiRENC
QSAoMHg0NDQzNDI0MSkiLCB9LA0KPj4gKyAgICAgICB9Ow0KPj4gKyAgICAgICBzdGF0aWMgY29u
c3Qgc3RydWN0IGZvdXJjY19zdHJ1Y3QgdHJ5X2NsW10gPSB7DQo+PiArICAgICAgICAgICAgICAg
eyAoX19mb3JjZSB1MzIpY3B1X3RvX2xlMzIoMHg0MTQyNDM0NCksICJBQkNEICgweDQxNDI0MzQ0
KSIsIH0sDQo+PiArICAgICAgIH07DQo+PiArICAgICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZm91
cmNjX3N0cnVjdCB0cnlfY2JbXSA9IHsNCj4+ICsgICAgICAgICAgICAgICB7IChfX2ZvcmNlIHUz
MiljcHVfdG9fYmUzMigweDQxNDI0MzQ0KSwgIkFCQ0QgKDB4NDE0MjQzNDQpIiwgfSwNCj4+ICsg
ICAgICAgfTsNCj4+IA0KPj4gLSAgICAgICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh0cnkp
OyBpKyspDQo+PiAtICAgICAgICAgICAgICAgdGVzdCh0cnlbaV0uc3RyLCAiJXA0Y2MiLCAmdHJ5
W2ldLmNvZGUpOw0KPj4gKyAgICAgICBmb3VyY2NfcG9pbnRlcl90ZXN0KGt1bml0dGVzdCwgdHJ5
X2NjLCBBUlJBWV9TSVpFKHRyeV9jYyksICIlcDRjYyIpOw0KPj4gKyAgICAgICBmb3VyY2NfcG9p
bnRlcl90ZXN0KGt1bml0dGVzdCwgdHJ5X2NoLCBBUlJBWV9TSVpFKHRyeV9jaCksICIlcDRjaCIp
Ow0KPj4gKyAgICAgICBmb3VyY2NfcG9pbnRlcl90ZXN0KGt1bml0dGVzdCwgdHJ5X2NuLCBBUlJB
WV9TSVpFKHRyeV9jbiksICIlcDRjbiIpOw0KPj4gKyAgICAgICBmb3VyY2NfcG9pbnRlcl90ZXN0
KGt1bml0dGVzdCwgdHJ5X2NsLCBBUlJBWV9TSVpFKHRyeV9jbCksICIlcDRjbCIpOw0KPj4gKyAg
ICAgICBmb3VyY2NfcG9pbnRlcl90ZXN0KGt1bml0dGVzdCwgdHJ5X2NiLCBBUlJBWV9TSVpFKHRy
eV9jYiksICIlcDRjYiIpOw0KPj4gfQ0KPj4gDQo+PiBzdGF0aWMgdm9pZA0KPj4gLS0NCj4+IDIu
NDMuMA0KPj4gDQo+IA0KPiBUaGlzIGNvZGUgbG9va3MgZmluZSB0byBtZS4gSSB3b3VsZCBhcHBy
ZWNpYXRlIGEgcHJldmlldyBvZiB0aGUgb3V0cHV0DQo+IG9mIHRoZXNlIHRlc3RzIHdoZW4gdGhl
eSBmYWlsOyBhIGxvdCBvZiBlZmZvcnQgd2VudCBpbnRvIG1ha2luZyB0aGUNCj4gcHJpbnRmIHRl
c3RzIHByb2R1Y2UgYWN0aW9uYWJsZSBmYWlsdXJlIG1lc3NhZ2VzLCBhbmQgd2Ugc2hvdWxkDQo+
IGNvbnRpbnVlIHRvIGludmVzdCBpbiB0aGF0IElNTy4NCg0KQ2FuIHlvdSBnaXZlIG1lIHNvbWUg
ZG9jcyBmb3IgcnVubmluZyB0aGUgS3VuaXQgdGVzdHM/IFRoZSBwYXRjaCBpcyBiYXNpY2FsbHkg
YSBwb3J0IG9mIHRoZSBvcmlnaW5hbCB2ZXJzaW9uLg==

