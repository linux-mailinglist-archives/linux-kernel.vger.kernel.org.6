Return-Path: <linux-kernel+bounces-422776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089F99D9E07
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D8BB23FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07B51DE89D;
	Tue, 26 Nov 2024 19:28:39 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C8191F8F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732649319; cv=none; b=M0H7kUy/YKHhokMHfm06sGP/TuxVZepHQ31S5/EMh+nIgixO3PmAart8O2PqohcgdPFGqtgc0n1uqFSoJuIuLs+9WOTQ7zHHq8OO8z0/jDXEQX1hXeVuLNHDSOECP66prjEaEHeZ8EZJBPL8mGG6a4uMYz2JW3rR5gb7QkCGRB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732649319; c=relaxed/simple;
	bh=+GBE5B062FR9g4J90SX5hO01IVxZBZ3fP+Lf3aTOPYg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=lQMbztQUcMnc/+WvuUUwuCvWUnqtKbTQVfzqFhAB5OHf2ewrWD+Rrwd+vpdFzDICZMwo4bZuz33O+Swrrl5FSTaVyv98443zQH+92j4LF3nP0OixKp2U8H68076YhKEAPfRf0hlOjLssVtqXfF8TBa1U0yy3e8bjinvNzFP/FoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-59-NBi9ce6hPiKDt7GQ4gr72w-1; Tue, 26 Nov 2024 19:28:29 +0000
X-MC-Unique: NBi9ce6hPiKDt7GQ4gr72w-1
X-Mimecast-MFC-AGG-ID: NBi9ce6hPiKDt7GQ4gr72w
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 26 Nov
 2024 19:28:22 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 26 Nov 2024 19:28:22 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Tingmao Wang' <m@maowtm.org>, Mikel Rychliski <mikel@mikelr.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86: Fix off-by-one error in __access_ok
Thread-Topic: [PATCH] x86: Fix off-by-one error in __access_ok
Thread-Index: AQHbP5/0s5XuBE8Q5Uy4b3TdFy2hrrLJ8xtg
Date: Tue, 26 Nov 2024 19:28:22 +0000
Message-ID: <88d4fc24d4c0449196bf462d54bd6fa2@AcuMS.aculab.com>
References: <20241109210313.440495-1-mikel@mikelr.com>
 <4d5abd25-57c1-4233-a34a-3167a114dcc8@maowtm.org>
In-Reply-To: <4d5abd25-57c1-4233-a34a-3167a114dcc8@maowtm.org>
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
X-Mimecast-MFC-PROC-ID: qUHcoPCrvDz9Rya0Ywdtd8j4fVGfTwyOLDFwB4C36Qs_1732649308
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogVGluZ21hbyBXYW5nIDxtQG1hb3d0bS5vcmc+DQo+IFNlbnQ6IDI2IE5vdmVtYmVyIDIw
MjQgMDE6MDkNCj4gDQo+IEkgaGl0IGFuIGlzc3VlIHdpdGggdXNpbmcgZ2RiIChhbmQgZXZlbnR1
YWxseSBtb3JlKSBvbiBhIHN5c3RlbSB3aXRoIDlwDQo+IGFzIHJvb3RmcyB3aGljaCBJIGV2ZW50
dWFsbHkgcm9vdC1jYXVzZWQgdG8gdGhpcywgc28gSSdtIGp1c3QgcG9zdGluZw0KPiBoZXJlIGZv
ciByZWZlcmVuY2UgLyBhbm90aGVyIHRlc3RpbmcgZGF0YXBvaW50LCBzaW5jZSBJIGNvdWxkbid0
IGZpbmQNCj4gYW55IG90aGVyIG1lbnRpb25zIG9mIHRoaXMgZXJyb3IgZWxzZXdoZXJlIGFuZCB0
aGlzIGlzIGluIHRoZSBsYXRlc3QNCj4gc3RhYmxlIGtlcm5lbCAoNi4xMiAvIDYuMTIuMSkuIEFw
b2xvZ2llcyBpbiBhZHZhbmNlIHRoYXQgSSBtaWdodCBub3QgYmUNCj4gb2ZmZXJpbmcgbXVjaCBl
bHNlIHVzZWZ1bCwgYnV0IEkgY2FuIGNvbmZpcm0gdGhhdCBhcHBseWluZyB0aGlzIHBhdGNoDQo+
IGZpeGVzIGl0Lg0KDQpJIGJlbGlldmUgTGludXMgaGFzIGFwcGxpZWQgYSBkaWZmZXJlbnQgcGF0
aCB0aGF0IGRvZXM6DQotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jDQorKysgYi9h
cmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jDQpAQCAtMjM4OSwxMiArMjM4OSwxMiBAQCB2b2lk
IF9faW5pdCBhcmNoX2NwdV9maW5hbGl6ZV9pbml0KHZvaWQpDQogCWFsdGVybmF0aXZlX2luc3Ry
dWN0aW9ucygpOw0KIA0KIAlpZiAoSVNfRU5BQkxFRChDT05GSUdfWDg2XzY0KSkgew0KLQkJdW5z
aWduZWQgbG9uZyBVU0VSX1BUUl9NQVggPSBUQVNLX1NJWkVfTUFYLTE7DQorCQl1bnNpZ25lZCBs
b25nIFVTRVJfUFRSX01BWCA9IFRBU0tfU0laRV9NQVg7DQoNClByb2JhYmx5IG5vdCBiZWVuIGJh
Y2stcG9ydGVkIHlldC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


