Return-Path: <linux-kernel+bounces-431900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93329E4278
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704A21699D1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D1D20C462;
	Wed,  4 Dec 2024 17:17:08 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B7D202C39
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332627; cv=none; b=JyxOgDBqJdSkP/xTOCxu0TXDnX6mNO/Rmx9JKLBuyf/iNfCn66mGn2SOMSDde0F4JxwWEOFHtoZRPXN3LHfrc9v6s0UAs4MqcfGuc6vlt3F99WzhzzICXR3LvmfsxTiN32ed1xAY7wdOFdBsCFdPLPm5OYRKlPNcb+Yxeeoj/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332627; c=relaxed/simple;
	bh=rIREJMmBivbh8Gm4Doq9HmwrAUpVcJ4x6GNYSVGrUNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Rpfh3agT9jitkLiPovCHEYxuGpmCWeSG9JNy45EkmUyeW3c+Yh7EvJrh643PvXWZ28YJc1s8BKHv50lw3bMpu2SyYsBnmpRN8HRRGblSDvFqs6TxaSjWv0TbaJ/92BCApDvJ0ACtG3m3fzOnKypoui1n8wfMI6kb8St0aCSU8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-55-J4b__t1TOP23i2W8ac3D-g-1; Wed, 04 Dec 2024 17:17:01 +0000
X-MC-Unique: J4b__t1TOP23i2W8ac3D-g-1
X-Mimecast-MFC-AGG-ID: J4b__t1TOP23i2W8ac3D-g
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 4 Dec
 2024 17:16:22 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 4 Dec 2024 17:16:22 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Geert Uytterhoeven' <geert@linux-m68k.org>, Arnd Bergmann
	<arnd@kernel.org>
CC: Linus Torvalds <torvalds@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig
	<hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik
	<mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
Thread-Topic: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
Thread-Index: Adrg+PsJWBOjJVDsQ/+qaYGHKHGutQAEaRMAAANJSHAAAfkwAAACaxqgGUlKIsEABntqQA==
Date: Wed, 4 Dec 2024 17:16:22 +0000
Message-ID: <79870bf11a0147a1a21d9e9fd7332c56@AcuMS.aculab.com>
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
 <CAMuHMdVx0wpKhHKn0NppJRbMA2FwjKntPFX1zaJzKhQANeY6oQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVx0wpKhHKn0NppJRbMA2FwjKntPFX1zaJzKhQANeY6oQ@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: fu_VEtUyhVfV5p_IsJ4LCEsJ-W9dNnL1wcvmsXRZ3E4_1733332619
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuDQo+IFNlbnQ6IDA0IERlY2VtYmVyIDIwMjQgMTM6MTUN
Cj4gSGkgQXJuZCBldCBhbCwNCj4gDQo+IFBlb3BsZSBzdGFydGVkIHNlZWluZyB0aGlzIGluIHRv
ZGF5J3MgbGludXgtbmV4dC4uLg0KPiANCj4gT24gVHVlLCBKdWwgMzAsIDIwMjQgYXQgNDoxNeKA
r1BNIEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gT24gVHVlLCBK
dWwgMzAsIDIwMjQsIGF0IDEyOjEwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPiA+ID4gT24gVHVl
LCBKdWwgMzAsIDIwMjQsIGF0IDA1OjU5LCBMaW51cyBUb3J2YWxkcyB3cm90ZToNCj4gPiA+PiBP
biBNb24sIDI5IEp1bCAyMDI0IGF0IDE2OjIxLCBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGlu
dXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gSSdtIGdpdmluZyB0aGlzIGEg
c3BpbiBvbiB0aGUgcmFuZGNvbmZpZyB0ZXN0IHNldHVwIG5vdyB0byBzZWUNCj4gPiA+IGlmIHRo
ZXJlIGFyZSBzb21lIG90aGVyIGNhc2VzIGxpa2UgdGhlIGJjYWNoZWZzIG9uZS4gU28gZmFyIEkn
dmUNCj4gPiA+IHNlZW4gb25lIGZhaWx1cmUsIGJ1dCBJIGNhbid0IG1ha2Ugc2Vuc2Ugb2YgaXQg
eWV0Og0KPiA+ID4NCj4gPiA+IGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYmFj
a2xpZ2h0LmM6IEluIGZ1bmN0aW9uICdzY2FsZSc6DQo+ID4gPiBpbmNsdWRlL2xpbnV4L2NvbXBp
bGVyX3R5cGVzLmg6NTEwOjQ1OiBlcnJvcjogY2FsbCB0bw0KPiA+ID4gJ19fY29tcGlsZXRpbWVf
YXNzZXJ0XzkwNScgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUgZXJyb3I6IGNsYW1wKCkgbG93DQo+
ID4gPiBsaW1pdCBzb3VyY2VfbWluIGdyZWF0ZXIgdGhhbiBoaWdoIGxpbWl0IHNvdXJjZV9tYXgN
Cj4gPiA+IGluY2x1ZGUvbGludXgvbWlubWF4Lmg6MTA3Ojk6IG5vdGU6IGluIGV4cGFuc2lvbiBv
ZiBtYWNybw0KPiA+ID4gJ0JVSUxEX0JVR19PTl9NU0cnDQo+ID4gPiAgIDEwNyB8ICAgICAgICAg
QlVJTERfQlVHX09OX01TRyhzdGF0aWNhbGx5X3RydWUodWxvID4gdWhpKSwNCj4gPiA+ICAgICAg
ICAgICAgICAgICBcDQo+ID4gPiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Jh
Y2tsaWdodC5jOjQ3OjIyOiBub3RlOiBpbg0KPiA+ID4gZXhwYW5zaW9uIG9mIG1hY3JvICdjbGFt
cCcNCj4gPiA+ICAgIDQ3IHwgICAgICAgICBzb3VyY2VfdmFsID0gY2xhbXAoc291cmNlX3ZhbCwg
c291cmNlX21pbiwgc291cmNlX21heCk7DQo+ID4gPg0KPiA+ID4gU2VlIGh0dHBzOi8vcGFzdGVi
aW4uY29tL3Jhdy95TEo1WnFWdyBmb3IgdGhlIHg4Ni02NCAuY29uZmlnDQo+ID4gPiB0aGF0IHRy
aWdnZXJlZCB0aGlzLg0KPiA+DQo+ID4gVGhlIGFib3ZlIHNlZW1zIHRvIGhhcHBlbiBvbmx5IHdp
dGggZ2NjLTEzIGFuZCBnY2MtMTQsIGJ1dCBub3QgZ2NjLTEyDQo+ID4gYW5kIGVhcmxpZXIsIGFu
ZCBpdCdzIHRoZSBvbmx5IG9uZSBJJ3ZlIHNlZW4gd2l0aCBhIGJpdCBvZiByYW5kY29uZmlnDQo+
ID4gdGVzdGluZyBvbiB0aGF0IHZlcnNpb24uDQoNCkknZCBndWVzcyBpdCBoYXBwZW5zIGJlY2F1
c2Ugc2NhbGUoKSBnZXRzIGlubGluZWQgYW5kIHRoZW4gdGhlIGNvbXBpbGVyDQprbm93cyB0aGUg
dmFsdWVzIG9mIGJvdGggbG8gYW5kIGhpLg0KQnV0IEkgY2FuJ3Qgc2VlIG9uZSB0aGF0IGlzIG9i
dmlvdXNseSB3cm9uZy4NCkkgc3VzcGVjdCB0aGUgY2FsbHMgbmVlZCBjb21tZW50aW5nIG91dCBv
bmUgYnkgb25lIHRvIGRldGVybWluZQ0Kd2hpY2ggb25lIGl0IGlzIGJsZWF0aW5nIGFib3V0DQoN
Cj4gPg0KPiA+IFRoZXJlIGlzIGFub3RoZXIgb25lIHRoYXQgSSBzZWUgd2l0aCBnY2MtOCByYW5k
Y29uZmlncyAoYXJtNjQpOg0KPiA+DQo+ID4gbmV0L25ldGZpbHRlci9pcHZzL2lwX3ZzX2Nvbm4u
YzogSW4gZnVuY3Rpb24gJ2lwX3ZzX2Nvbm5faW5pdCc6DQo+ID4gaW5jbHVkZS9saW51eC9jb21w
aWxlcl90eXBlcy5oOjUxMDozODogZXJyb3I6IGNhbGwgdG8gJ19fY29tcGlsZXRpbWVfYXNzZXJ0
XzEwNDAnIGRlY2xhcmVkIHdpdGgNCj4gYXR0cmlidXRlIGVycm9yOiBjbGFtcCgpIGxvdyBsaW1p
dCBtaW4gZ3JlYXRlciB0aGFuIGhpZ2ggbGltaXQgbWF4X2F2YWlsDQo+ID4gICA1MTAgfCAgX2Nv
bXBpbGV0aW1lX2Fzc2VydChjb25kaXRpb24sIG1zZywgX19jb21waWxldGltZV9hc3NlcnRfLCBf
X0NPVU5URVJfXykNCj4gPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBeDQo+ID4gaW5jbHVkZS9saW51eC9taW5tYXguaDoxODI6Mjg6IG5vdGU6IGluIGV4cGFu
c2lvbiBvZiBtYWNybyAnX19jYXJlZnVsX2NsYW1wJw0KPiA+ICAgMTgyIHwgI2RlZmluZSBjbGFt
cCh2YWwsIGxvLCBoaSkgX19jYXJlZnVsX2NsYW1wKHZhbCwgbG8sIGhpKQ0KPiA+ICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+DQo+ID4gbmV0L25ldGZp
bHRlci9pcHZzL2lwX3ZzX2Nvbm4uYzoxNDk4Ojg6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNy
byAnY2xhbXAnDQo+ID4gIDE0OTggfCAgbWF4ID0gY2xhbXAobWF4LCBtaW4sIG1heF9hdmFpbCk7
DQo+ID4NCj4gPiBJIGNhbiByZXByb2R1Y2UgdGhpcyBvbmUgd2l0aCBnY2MtOC85LzEwLCBidXQg
bm90IGdjYy0xMQ0KPiA+IG9yIGhpZ2hlci4NCj4gPg0KPiA+IFRoaXMgbWF5IGJlIGFub3RoZXIg
Y2FzZSBvZiBfX2J1aWx0aW5fY29uc3RhbnRfcCgpIGJlaW5nDQo+ID4gc2xpZ2h0bHkgdW5yZWxp
YWJsZSB3aGVuIGEgbG9jYWwgdmFyaWFibGUgaXMgY29uc3RhbnQtZm9sZGVkDQo+ID4gYmFzZWQg
b24gYSBjb25kaXRpb24sIG9yIHdpdGggcGFydGlhbCBpbmxpbmluZy4NCg0KV2hhdCBoYXMgcHJv
YmFibHkgaGFwcGVuZWQgaXMgdGhlIGNvbXBpbGVyIGlzIGdlbmVyYXRpbmcgdHdvIChvciBtb3Jl
KSBjb3BpZXMNCm9mIHRoZSBjb2RlIGFuZCBlbmRzIHVwIHdpdGggb25lIHdoZXJlIG1heF9hdmFp
bCBlbmRzIHVwIGJlaW5nIGEgc21hbGwgdmFsdWUuDQpPVE9IIGl0IGlzICduICsgUEFHRV9TSElG
VCAtIDIgLSAxIC0gaycgd2hlbiAnbicgaXMgZGVmaW5pdGVseSB1bmtub3duDQphbmQgJ2snIHNo
b3VsZCBiZSBjb25zdGFudC4NCg0KRm91bmQgaXQuDQpzaXplb2YgKHN0cnVjdCBpcF92c19jb25u
KSBpcyAweDEyMCAtIHNvICdrJyBpcyA5Lg0KUEFHRV9TSElGVCBpcyAocHJvYmFibHkpIDEyLg0K
U28gbWF4X2F2YWlsIGlzIGp1c3QgJ24nLg0KQnV0IG9yZGVyX2Jhc2VfMihuKSBpcyAnbiA+IDEg
PyBpbG9nMihuIC0gMSkgKyAxIDogMCcuDQpBbmQgdGhlIGNvbXBpbGVyIGlzIGdlbmVyYXRpbmcg
dHdvIGNvcGllcyBvZiB0aGUgY29kZS4NCkFuZCB0aGUgb25lIGZvciB0b3RhbHJhbV9wYWdlcygp
IGJlaW5nIHplcm8gaGl0cyB0aGUgY2hlY2sgaW4gY2xhbXAoKS4NCg0KPiANCj4gT3IgcGVyaGFw
cyB0aGUgYXJndW1lbnQgb3JkZXIgaXMgd3JvbmcsIGFuZCBpdCBzaG91bGQgYmUNCj4gDQo+ICAg
ICBtYXggPSBjbGFtcChtYXhfYXZhaWwsIG1pbiwgbWF4KTsNCg0KU2VlbXMgZXF1aXZhbGVudCBh
bmQgZGVmaW5pdGVseSBzYWZlci4NCg0KCURhdmlkDQoNCj4gDQo+IGluc3RlYWQ/DQo+IA0KPiBH
cntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+
IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJl
eW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252
ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4g
QnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3Jh
bW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


