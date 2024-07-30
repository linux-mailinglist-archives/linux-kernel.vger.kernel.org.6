Return-Path: <linux-kernel+bounces-268263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A600942258
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E573B21EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA0E18E02D;
	Tue, 30 Jul 2024 21:48:31 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0881AA3EF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722376111; cv=none; b=R9ZhSdwrQndkw0gboBHTz/aUkSAzWagvXvTwt+vjERTveKYGpFzJA0r6jizCGTfM9e+nOKQJA17vCpFTjCSPKNv0cEI5EDccd/8dcqF+VlPC+G6QoJspypO+95wqWVhcEnzF1gHL7rxhel3tiM9nJxFbh5yJJkXaTUt95PipMWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722376111; c=relaxed/simple;
	bh=EPi7Pcr+AtZumapJv1s6AtqIt6HCVk8ogwWNTo7FWyc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=gsO+cEjL5VlOWiZyLOA1TH2ROa5Yjk5ualaNM9Ibky+tOY54sNTl7NvdVkJmsXlKp+WGV5KhBq1CW9OBgrCBRsnOtmNC1heQ4TiQDBbNr7QWsN1yJ+nja3iYSfnRCAeRQSETiFRbYdiT4bdIaOVE4lLj0bPEJAPJllsNfVWKXCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-143-MLWHvDC0PxWV6zvLC7p7GA-1; Tue, 30 Jul 2024 22:48:25 +0100
X-MC-Unique: MLWHvDC0PxWV6zvLC7p7GA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 30 Jul
 2024 22:47:47 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 30 Jul 2024 22:47:47 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linuxfoundation.org>, Arnd Bergmann
	<arnd@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig
	<hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik
	<mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>
Subject: RE: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
Thread-Topic: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
Thread-Index: Adrg+PsJWBOjJVDsQ/+qaYGHKHGutQAEaRMAAANJSHAAAfkwAAACaxqgAGQsLzQABAMbUA==
Date: Tue, 30 Jul 2024 21:47:47 +0000
Message-ID: <73d65e2553e543069f9969ccec4ea9b3@AcuMS.aculab.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com>
 <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com>
 <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com>
 <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
 <e946e002-8ca8-4a09-a800-d117c89b39d3@app.fastmail.com>
 <CAHk-=whCvSUpbOawsbj4A6EUT7jO8562FG+vqiLQvW0CBBZZzA@mail.gmail.com>
 <CAHk-=wgRDupSBzUX_N_Qo_eaYyDfOH=VTihhikN36cGxCc+jvg@mail.gmail.com>
 <f88a19d1-c374-43d1-a905-1e973fb6ce5a@app.fastmail.com>
 <8111159a-c571-4c71-b731-184af56b5cb1@app.fastmail.com>
 <CAHk-=wgLsFdNert_OfCmRon7Y9+ETnjxkz_UA5mv0=1RB71kww@mail.gmail.com>
 <CAHk-=widciTZs3CCoi7X2+4SnVWrKu1Jv2uOV9+oewXGen7Q9A@mail.gmail.com>
In-Reply-To: <CAHk-=widciTZs3CCoi7X2+4SnVWrKu1Jv2uOV9+oewXGen7Q9A@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMzAgSnVseSAyMDI0IDIwOjUzDQo+IFRvOiBB
cm5kIEJlcmdtYW5uIDxhcm5kQGtlcm5lbC5vcmc+DQo+IENjOiBEYXZpZCBMYWlnaHQgPERhdmlk
LkxhaWdodEBBQ1VMQUIuQ09NPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSmVucyBB
eGJvZQ0KPiA8YXhib2VAa2VybmVsLmRrPjsgTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVh
ZC5vcmc+OyBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+OyBBbmRyZXcNCj4g
TW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgQW5keSBTaGV2Y2hlbmtvIDxhbmRy
aXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+OyBEYW4gQ2FycGVudGVyDQo+IDxkYW4uY2Fy
cGVudGVyQGxpbmFyby5vcmc+OyBKYXNvbiBBIC4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+
OyBwZWRyby5mYWxjYXRvQGdtYWlsLmNvbTsgTWF0ZXVzeg0KPiBHdXppayA8bWpndXppa0BnbWFp
bC5jb20+OyBsaW51eC1tbUBrdmFjay5vcmc7IExvcmVuem8gU3RvYWtlcyA8bG9yZW56by5zdG9h
a2VzQG9yYWNsZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS84XSBtaW5tYXg6IFB1
dCBhbGwgdGhlIGNsYW1wKCkgZGVmaW5pdGlvbnMgdG9nZXRoZXINCj4gDQo+IE9uIFR1ZSwgMzAg
SnVsIDIwMjQgYXQgMTE6MDIsIExpbnVzIFRvcnZhbGRzDQo+IDx0b3J2YWxkc0BsaW51eGZvdW5k
YXRpb24ub3JnPiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1ZSwgMzAgSnVsIDIwMjQgYXQgMDc6MTUs
IEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gVGhl
cmUgaXMgYW5vdGhlciBvbmUgdGhhdCBJIHNlZSB3aXRoIGdjYy04IHJhbmRjb25maWdzIChhcm02
NCk6DQo+ID4NCj4gPiBTbyBJIGVuZGVkIHVwIHVuZG9pbmcgdGhhdCBwYXJ0IG9mIG15IHBhdGNo
LCBzbyBpdCdzIGEgbm9uLWlzc3VlIFsuLl0NCj4gDQo+IEkgcHVzaGVkIG91dCBteSBjdXJyZW50
IG9uZS4NCg0KSGF2ZSB5b3UgYSBwbGFuIHRvICdmaXgnIG1pbjMoKSA/DQoNCglEYXZpZA0KDQot
DQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwg
TWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQo=


