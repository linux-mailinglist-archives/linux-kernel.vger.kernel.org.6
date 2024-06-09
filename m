Return-Path: <linux-kernel+bounces-207306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 711A4901554
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 11:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC1F1B21630
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 09:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4731CD3F;
	Sun,  9 Jun 2024 09:36:19 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509E71CD00
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717925779; cv=none; b=HvUBhr3mvlx/8nFCsZiNHeD33EStJdPSxmftkGeaC+JJ7r4gJRjh5xlux9eFJdO5eg6GPW9lB+SuX39wLsw6DPnbyfYDULSowTEfXP29MCFkEtHIL/bbQx4CBr+R8CHh5E+Wr1WT0FYlph7K5m46INEmBeQZWYS+lLnSmTGcN7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717925779; c=relaxed/simple;
	bh=QxyqwjX4RH9bduRiYY47W4a7DNLiazGnEX4BsDURPhg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=HId/K1Qe+fHqtpPoa6lSi2zRixK2xuWd3m4sFnbTS+8liJ/uF0cmAiaoIOcuXIhI4+WIp4G2R72h+ESg6BB7jxL5CHUpObYlCf0Fht2ANBDGo+ORe5CXf5QF1/GA8y9Zr67r20B77/4AEhBJ/bYc+9yirocvCrpSzK9fbD/gGfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-136-YpaBPdK1NEKgXkUGJAVVTQ-1; Sun, 09 Jun 2024 10:36:14 +0100
X-MC-Unique: YpaBPdK1NEKgXkUGJAVVTQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 9 Jun
 2024 10:35:37 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 9 Jun 2024 10:35:37 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: Linux kernel regressions list <regressions@lists.linux.dev>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>
Subject: RE: Linux 6.10-rc2 - massive performance regression
Thread-Topic: Linux 6.10-rc2 - massive performance regression
Thread-Index: Adq5okQ7HduYf8qJTJSPwCpAtFdr/wAEqzOAAAzamAAAFwt/pgABdYJQ
Date: Sun, 9 Jun 2024 09:35:36 +0000
Message-ID: <930d66db93814520be94f02ee62a19e6@AcuMS.aculab.com>
References: <CAHk-=wisJ8bS3qe6iBPwL9x=PqJA5oE7tum-E9oZfyPgd2mmrw@mail.gmail.com>
 <46cb50d65e414bfd9bef5549d68ae4ea@AcuMS.aculab.com>
 <CAHk-=wh170Lme6HHSGa5eM6YNcd01vdkOoPenZ0m7P+Yv6_zxg@mail.gmail.com>
 <adbbd899aabf4e6898bbbb04f90b3ede@AcuMS.aculab.com>
 <CAHk-=wjwFGQZcDinK=BkEaA8FSyVg5NaUe0BobxowxeZ5PvetA@mail.gmail.com>
 <ebf5c056-3035-4e76-9472-d76be6427669@leemhuis.info>
In-Reply-To: <ebf5c056-3035-4e76-9472-d76be6427669@leemhuis.info>
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

RnJvbTogTGludXggcmVncmVzc2lvbiB0cmFja2luZyAoVGhvcnN0ZW4gTGVlbWh1aXMpDQo+IFNl
bnQ6IDA5IEp1bmUgMjAyNCAwOToxMQ0KPiANCj4gT24gMDkuMDYuMjQgMDA6MDAsIExpbnVzIFRv
cnZhbGRzIHdyb3RlOg0KPiA+IE9uIFNhdCwgOCBKdW4gMjAyNCBhdCAxNDozNiwgRGF2aWQgTGFp
Z2h0IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4gWy4uLl0NCj4gPj4gSSd2
ZSBkb25lIHNvbWUgdGVzdHMuDQo+ID4+IEknbSBzZWVpbmcgYSB0aHJlZS1mb2xkIHNsb3cgZG93
biBvbjoNCj4gPj4gJCBpPTA7IHdoaWxlIFsgJGkgLWx0IDEwMDAwMDAgXTsgZG8gaT0kKChpICsg
MSkpOyBkb25lDQo+ID4+IHdoaWNoIGdvZXMgZnJvbSAxIHNlY29uZCB0byAzLg0KPiA+Pg0KPiA+
PiBJIGNhbiBydW4gdGhhdCB3aXRoIGZ0cmFjZSBtb25pdG9yaW5nIHNjaGVkdWxlciBldmVudHMg
KGFuZCBhIGZldw0KPiA+PiBvdGhlciB0aGluZ3MpIGFuZCBjYW4ndCBzcG90IGFueXdoZXJlIHRo
ZSBwcm9jZXNzIGlzbid0IHJ1bm5pbmcNCj4gPj4gZm9yIGEgc2lnbmlmaWNhbnQgdGltZS4NCj4g
Pg0KPiA+IFNvdW5kcyBsaWtlIGNwdSBmcmVxdWVuY3kuIEFsbW9zdCBjZXJ0YWlubHkgaHctc3Bl
Y2lmaWMuIEkgd2VudA0KPiA+IHRocm91Z2ggdGhhdCBvbiBteSBUaHJlYWRyaXBwZXIgaW4gdGhl
IDYuOSB0aW1lZnJhbWUsIGJ1dCBJJ20gbm90DQo+ID4gc2VlaW5nIGFueSBpc3N1ZXMgaW4gdGhp
cyBjdXJyZW50IHJlbGVhc2UuDQo+IA0KPiBEYXZpZCwgd2hhdCBraW5kIG9mIGhhcmR3YXJlIGRv
IHlvdSB1c2U/DQoNClRoaXMgaXMgb24gYW4gMTctNzcwMCAoNCBjb3JlcyArIGh5cGVydGhyZWFk
aW5nIGVuYWJsZWQgPSA4IGNwdSkuDQoNCj4gSm9oYW4gSG92b2xkIGFzDQo+IG1hbi1pbi10aGUt
bWlkZGxlIGp1c3QgcmVwb3J0ZWQgIkNQVSBmcmVxdWVuY3kgb2YgdGhlIGJpZyBjb3JlcyBvbiB0
aGUNCj4gTGVub3ZvIFRoaW5rUGFkIFgxM3Mgc29tZXRpbWVzIGFwcGVhcnMgdG8gZ2V0IHN0dWNr
IGF0IGEgbG93IGZyZXF1ZW5jeQ0KPiB3aXRoIDYuMTAtcmMyIiBhbmQgY29uZmlybWVkICJ0aGF0
IG9uY2UgdGhlIGNvcmVzIGFyZSBmdWxseSB0aHJvdHRsZWQNCj4gKHVzaW5nIHRoZSBzdGVwd2lz
ZSB0aGVybWFsIGdvdmVybm9yKSBkdWUgdG8gdGhlIHNraW4gdGVtcGVyYXR1cmUNCj4gcmVhY2hp
bmcgdGhlDQo+IGZpcnN0IHRyaXAgcG9pbnQsIHNjYWxpbmdfbWF4X2ZyZXEgZ2V0cyBzdHVjayBh
dCB0aGUgbmV4dCBPUFAiLg0KDQpUaGF0J3Mgbm90IHdoYXQgSSdtIHNlZWluZy4NCkkgY2FuIHR1
cm4gdGhlIHNwZWVkIHVwIGFuZCBkb3duIGJ5IHN0b3BwaW5nL3N0YXJ0aW5nIGEgZGFlbW9uIHdl
IHVzZQ0KZm9yIHByb2Nlc3NpbmcgYXVkaW8uDQooSSBjYW4gZ2l2ZSBhbnlvbmUgYSBjb3B5OyBp
dCBpcyBmcmVlbHkgZG93bmxvYWRhYmxlIGZyb20gdGhlIGNvbXBhbnkNCndlYiBzaXRlIC0gaWYg
eW91IGtub3cgZXhhY3RseSB3aGVyZSB0byBsb29rISkNCkJhc2ljYWxseSB0aGF0IGVuZHMgdXAg
cnVubmluZyBhIGJpdCBvZiBjb2RlIG9uIGV2ZXJ5IGNwdSBldmVyeSAxMG1zLg0KDQpUaGVyZSBp
cyBhIGJpZyBkaWZmZXJlbmNlIGluIHRoZSBudW1iZXIgb2Ygc2NoZWRfbWlncmF0ZV90YXNrIHRy
YWNlcw0KYmV0d2VlbiA2LjkgYW5kIDYuMTAgKDE1IHYgODMpLg0KDQpJIHN1c3BlY3QgdGhhdCB0
aGUgdW5kZXJseWluZyBwcm9ibGVtIGlzIHRoYXQgdGhlIGNwdSBnb3Zlcm5vcg0KZG9lc24ndCBh
bGxvdyBmb3IgYSAnYnVzeScgcHJvY2VzcyBiZWluZyBtb3ZlZCB0byBhbiBpZGxlIGNwdT8NClNv
IGlmIHlvdSBib3VuY2UgYSBwcm9jZXNzIGFib3V0IGl0IGFsd2F5cyBydW5zIGFuIDgwME1Iei4N
Cg0KTXkgZG1lc2cgKDYuOSBhbmQgNi4xMCkgaGFzOg0KY3B1aWRsZTogdXNpbmcgZ292ZXJub3Ig
aWRsZQ0KY3B1aWRsZTogdXNpbmcgZ292ZXJub3IgbGFkZGVyDQoNCkJ1dCBJIGhhZCBhIGZlZWxp
bmcgdGhhdCBzb21lICdoYXJkd2FyZSBtYWdpYycgY2hhbmdlcyB0aGUgY3B1DQpzcGVlZCBvbiB0
aGVzZSBzeXN0ZW1zPw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


