Return-Path: <linux-kernel+bounces-173668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED63F8C03B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C612284748
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D18D12E1C8;
	Wed,  8 May 2024 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="EXe2OJUg"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFA612BF29
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190601; cv=none; b=fwCT/hGlcn8XNeVyetNtdd/Edib1k0TZafdYhX49garn16nCwWqRn8USLsp16wa5z8uIA0h9AUEct5sYjl9MVpOdtdZrcyU4I9y07B9T4mbAAeGZ38Wd9DubIAVjJmNJXGywww2Qp2Fag/R/0ITXs5myvwTMAu4U/fNSLumjM4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190601; c=relaxed/simple;
	bh=V2Q4pwpdjqg9xxAMMtcZVQYSQ96Q+Kp2F4ha6okEb84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XxHqWwzpYrpUrEFyMYWyB87mf876LWAaztfJbBDI+A9vXC5S8DVWXXu3kUAWwdxaQkL7kxZxVVBclHhS2EUZ7QWecytAVCviTF4aCnhs/wzg2Ge/teqi0Q1FqN/0qAPwTbpFy9K2fu8U+gXja1fJXN1A5Btq6yvdytQ9AJy4pgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=EXe2OJUg; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A47EE2C01BD;
	Thu,  9 May 2024 05:49:49 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1715190589;
	bh=V2Q4pwpdjqg9xxAMMtcZVQYSQ96Q+Kp2F4ha6okEb84=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=EXe2OJUgIDR0A/GXHnI7+K/re/H5RaiZg7ypj2E/FEa0S9/Fj7Rbe0oZuKXcvW8w6
	 JOxGHJP87Bf4XG3FoUFNdIiFH9HpS9YeDqfa7FhXArkmomWy7SOFBkdNAGrt3E6NHe
	 vY+5eG+4Fjf43jgGWAMDPTiPMMjNE/9JiZhgbgYFa3sYUt/17mDtyINikp+m4Iv+Tz
	 ltXtYS34HsWH5RKc8ZGZBS32vwEypsZjTePspzZOiRfqbY5IzPVefiZp+o/5117OHK
	 jLawqAMe22A8lFIkZHDXoMz66zq65eyoWRBsrnTEdNMwgGyCGCTcq4Vf2YDNmZ3TR7
	 24eCNYlRBnMfQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B663bbb3d0001>; Thu, 09 May 2024 05:49:49 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Thu, 9 May 2024 05:49:49 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Thu, 9 May 2024 05:49:49 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Thu, 9 May 2024 05:49:49 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "jdelvare@suse.com" <jdelvare@suse.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: (adt7475) Add support for configuring initial
 PWM duty cycle
Thread-Topic: [PATCH 2/2] hwmon: (adt7475) Add support for configuring initial
 PWM duty cycle
Thread-Index: AQHaoWn5Wh+pud+mHku8vdrDvQZJzLGM1D2A
Date: Wed, 8 May 2024 17:49:49 +0000
Message-ID: <7cb45e90-659e-4caa-8e10-be52e1c969c6@alliedtelesis.co.nz>
References: <20240508170544.263059-1-chris.packham@alliedtelesis.co.nz>
 <20240508170544.263059-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240508170544.263059-3-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAC0F0B1DB31164DA0FEF15AFD7CAA09@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=MfrPuI/f c=1 sm=1 tr=0 ts=663bbb3d a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=gnXwXUZvAAwXd9gAzRcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiA5LzA1LzI0IDA1OjA1LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiBCeSBkZWZhdWx0IHRo
ZSBQV00gZHV0eSBjeWNsZSBpbiBoYXJkd2FyZSBpcyAxMDAlLiBPbiBzb21lIHN5c3RlbXMgdGhp
cw0KPiBjYW4gY2F1c2UgdW53YW50ZWQgZmFuIG5vaXNlLiBBZGQgdGhlIGFiaWxpdHkgdG8gdGFr
ZSBhbiBpbml0aWFsIFBXTQ0KPiBkdXR5IGN5Y2xlIGFuZCBmcmVxdWVuY3kgdmlhIGRldmljZSBw
cm9wZXJ0aWVzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNr
aGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvaHdtb24vYWR0NzQ3
NS5jIHwgNTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICAx
IGZpbGUgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9od21vbi9hZHQ3NDc1LmMgYi9kcml2ZXJzL2h3bW9uL2FkdDc0NzUuYw0KPiBpbmRleCA0MjI0
ZmZiMzA0ODMuLmIwYzdjMWE5NTg5NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9od21vbi9hZHQ3
NDc1LmMNCj4gKysrIGIvZHJpdmVycy9od21vbi9hZHQ3NDc1LmMNCj4gQEAgLTE2NjIsNiArMTY2
Miw1NCBAQCBzdGF0aWMgaW50IGFkdDc0NzVfc2V0X3B3bV9wb2xhcml0eShzdHJ1Y3QgaTJjX2Ns
aWVudCAqY2xpZW50KQ0KPiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgaW50
IGFkdDc0NzVfc2V0X3B3bV9pbml0aWFsX2ZyZXEoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCkN
Cj4gK3sNCj4gKwlpbnQgcmV0LCBvdXQsIGk7DQo+ICsJdTMyIGZyZXFzW0FEVDc0NzVfUFdNX0NP
VU5UXTsNCj4gKwlpbnQgZGF0YTsNCj4gKw0KPiArCXJldCA9IGRldmljZV9wcm9wZXJ0eV9yZWFk
X3UzMl9hcnJheSgmY2xpZW50LT5kZXYsDQo+ICsJCQkJCSAgICAgInB3bS1pbml0aWFsLWZyZXF1
ZW5jeSIsIGZyZXFzLA0KPiArCQkJCQkgICAgIEFSUkFZX1NJWkUoZnJlcXMpKTsNCj4gKwlpZiAo
cmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IEFEVDc0NzVf
UFdNX0NPVU5UOyBpKyspIHsNCj4gKwkJb3V0ID0gZmluZF9jbG9zZXN0KGZyZXFzW2ldLCBwd21m
cmVxX3RhYmxlLCBBUlJBWV9TSVpFKHB3bWZyZXFfdGFibGUpKTsNCj4gKwkJZGF0YSA9IGFkdDc0
NzVfcmVhZChURU1QX1RSQU5HRV9SRUcoaSkpOw0KPiArCQlpZiAoZGF0YSA8IDApDQo+ICsJCQly
ZXR1cm4gZGF0YTsNCj4gKwkJZGF0YSAmPSB+MHhmOw0KPiArCQlkYXRhIHw9IG91dDsNCj4gKw0K
PiArCQlyZXQgPSBpMmNfc21idXNfd3JpdGVfYnl0ZV9kYXRhKGNsaWVudCwgVEVNUF9UUkFOR0Vf
UkVHKGkpLCBkYXRhKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCXJldHVybiByZXQ7DQo+ICsJfQ0K
PiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgYWR0NzQ3NV9zZXRf
cHdtX2luaXRpYWxfZHV0eShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQ0KPiArew0KPiArCWlu
dCByZXQsIGk7DQo+ICsJdTMyIGR1dHlzW0FEVDc0NzVfUFdNX0NPVU5UXTsNCj4gKw0KPiArCXJl
dCA9IGRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMl9hcnJheSgmY2xpZW50LT5kZXYsDQo+ICsJCQkJ
CSAgICAgImFkaSxwd20taW5pdGlhbC1kdXR5LWN5Y2xlIiwgZHV0eXMsDQo+ICsJCQkJCSAgICAg
QVJSQVlfU0laRShkdXR5cykpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsN
Cj4gKwlmb3IgKGkgPSAwOyBpIDwgQURUNzQ3NV9QV01fQ09VTlQ7IGkrKykgew0KPiArCQlyZXQg
PSBpMmNfc21idXNfd3JpdGVfYnl0ZV9kYXRhKGNsaWVudCwgUFdNX01BWF9SRUcoaSksIGR1dHlz
W2ldICYgMHhmZik7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4g
Kw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICAgc3RhdGljIGludCBhZHQ3NDc1X3Byb2Jl
KHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpDQo+ICAgew0KPiAgIAllbnVtIGNoaXBzIGNoaXA7
DQo+IEBAIC0xNzc4LDYgKzE4MjYsMTQgQEAgc3RhdGljIGludCBhZHQ3NDc1X3Byb2JlKHN0cnVj
dCBpMmNfY2xpZW50ICpjbGllbnQpDQo+ICAgCWlmIChyZXQgJiYgcmV0ICE9IC1FSU5WQUwpDQo+
ICAgCQlkZXZfd2FybigmY2xpZW50LT5kZXYsICJFcnJvciBjb25maWd1cmluZyBwd20gcG9sYXJp
dHlcbiIpOw0KPiAgIA0KPiArCXJldCA9IGFkdDc0NzVfc2V0X3B3bV9pbml0aWFsX2ZyZXEoY2xp
ZW50KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KDQpXaG9vcHMgSSBtZWFudCB0
byBzZW5kIHRoZSB2ZXJzaW9uIHRoYXQgaGFuZGxlcyAtRUlOVkFMLiB2MiB3aWxsIGhhbmRsZSAN
CmVycm9ycyB0aGUgc2FtZSB3YXkgYXMgcHdtX3BvbGFyaXR5IGFib3ZlLiBJJ2xsIHdhaXQgZm9y
IGEgYml0IGJlZm9yZSANCnNlbmRpbmcgdGhhdCBvdXQuDQoNCj4gKw0KPiArCXJldCA9IGFkdDc0
NzVfc2V0X3B3bV9pbml0aWFsX2R1dHkoY2xpZW50KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1
cm4gcmV0Ow0KPiArDQo+ICAgCS8qIFN0YXJ0IG1vbml0b3JpbmcgKi8NCj4gICAJc3dpdGNoIChj
aGlwKSB7DQo+ICAgCWNhc2UgYWR0NzQ3NTo=

