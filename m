Return-Path: <linux-kernel+bounces-234088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DB391C205
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89141B214E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28461C2336;
	Fri, 28 Jun 2024 15:04:45 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A056B18C31
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587085; cv=none; b=FrvsdvLqtI7qKcfkkhACvKuCkl/TZZpCB+y1bu70XDRUiVn5pSSHM9XUTjcx9PT79/F92DSt7yLrXK/PIK+jBt0XEa1QeYQ+FtSXWsskwcNJOEnOJvD/ZZTZkN6aEsQaDE4X7Nr+ajI0UuUS1FRYgXE4WhPB2IxVyKThyBY5Bkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587085; c=relaxed/simple;
	bh=dAF/CagxWagf171GUiR+pxLkeIzVmgfwJ+b+Po3AhsM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=hqDSEqIEV6V+W6X0GFjQXzrMFvN6MNBWbQMqVihC1Eqg8APVcwHZIzwBWD2Yt1CfJ/tadFoiL2k7yO0rxKyObXPM7Q4qUkv3E2fBqEFtGOmUaJEVAytG5NeYK87WDOGPVUL3/S2+wa62AZhl5bC4YEyKfLvC7KtGjcNv4EwIa7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-167-sofw076GMKu0l37qeHp-MQ-1; Fri, 28 Jun 2024 16:04:35 +0100
X-MC-Unique: sofw076GMKu0l37qeHp-MQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 28 Jun
 2024 16:03:58 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 28 Jun 2024 16:03:58 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alexey Dobriyan' <adobriyan@gmail.com>, Marco Elver <elver@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject: RE: [PATCH v2] compiler.h: simplify data_race() macro
Thread-Topic: [PATCH v2] compiler.h: simplify data_race() macro
Thread-Index: AQHaxkyxmcs1TfRDYEaTbXk0NMQQRbHdS/5g
Date: Fri, 28 Jun 2024 15:03:58 +0000
Message-ID: <c452e41ed3d14c86aa0e05b4936c670b@AcuMS.aculab.com>
References: <f214f15e-4a0a-4f24-9bd7-8f84cbc12e5a@p183>
 <CANpmjNO=zv6D807cNLAQ3eGLrigUs9xtYNxoHhyuYvHkhhSUWg@mail.gmail.com>
 <2aab04d1-c16b-44e4-a283-7bbf8cba28e7@p183>
 <CANpmjNMZU=T6J5OBpELxB=ZqOnrkou2iRG7zaqoNy7bCGgH9hA@mail.gmail.com>
 <fb62163f-ba21-4661-be5b-bb5124abc87d@p183>
In-Reply-To: <fb62163f-ba21-4661-be5b-bb5124abc87d@p183>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDI0IEp1bmUgMjAyNCAxNjo0MA0KPiANCj4g
LVdkZWNsYXJhdGlvbi1hZnRlci1zdGF0ZW1lbnQgdXNlZCBzaW5jZSBmb3JldmVyIHJlcXVpcmVk
IHN0YXRlbWVudA0KPiBleHByZXNzaW9ucyB0byBpbmplY3QgX19rY3Nhbl9kaXNhYmxlX2N1cnJl
bnQoKSwgX19rY3Nhbl9lbmFibGVfY3VycmVudCgpDQo+IHRvIG1hcmsgZGF0YSByYWNlLiBOb3cg
dGhhdCBpdCBpcyBnb25lLCBtYWtlIG1hY3JvIGV4cGFuc2lvbiBzaW1wbGVyLg0KPiANCj4gX191
bnF1YWxfc2NhbGFyX3R5cGVvZigpIGlzIHdvcmR5IG1hY3JvIGJ5IGl0c2VsZi4NCj4gImV4cHIi
IGlzIGV4cGFuZGVkIHR3aWNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGV5IERvYnJpeWFu
IDxhZG9icml5YW5AZ21haWwuY29tPg0KPiAtLS0NCj4gDQo+ICBpbmNsdWRlL2xpbnV4L2NvbXBp
bGVyLmggfCAgICA2ICsrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4gDQo+IC0tLSBhL2luY2x1ZGUvbGludXgvY29tcGlsZXIuaA0KPiAr
KysgYi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLmgNCj4gQEAgLTIwMCwxMCArMjAwLDggQEAgdm9p
ZCBmdHJhY2VfbGlrZWx5X3VwZGF0ZShzdHJ1Y3QgZnRyYWNlX2xpa2VseV9kYXRhICpmLCBpbnQg
dmFsLA0KPiAgICovDQo+ICAjZGVmaW5lIGRhdGFfcmFjZShleHByKQkJCQkJCQlcDQo+ICAoewkJ
CQkJCQkJCVwNCj4gLQlfX3VucXVhbF9zY2FsYXJfdHlwZW9mKCh7IGV4cHI7IH0pKSBfX3YgPSAo
ewkJCVwNCj4gLQkJX19rY3Nhbl9kaXNhYmxlX2N1cnJlbnQoKTsJCQkJXA0KPiAtCQlleHByOwkJ
CQkJCQlcDQo+IC0JfSk7CQkJCQkJCQlcDQo+ICsJX19rY3Nhbl9kaXNhYmxlX2N1cnJlbnQoKTsJ
CQkJCVwNCj4gKwlfX2F1dG9fdHlwZSBfX3YgPSAoZXhwcik7CQkJCQlcDQo+ICAJX19rY3Nhbl9l
bmFibGVfY3VycmVudCgpOwkJCQkJXA0KPiAgCV9fdjsJCQkJCQkJCVwNCj4gIH0pDQoNCkkgdGhp
bmsgeW91IGNhbiByZW1vdmUgYSBsb3Qgb2YgdGhlIHRhYnMuLi4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==


