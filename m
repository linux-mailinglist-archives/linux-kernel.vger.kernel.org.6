Return-Path: <linux-kernel+bounces-174759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52368C149B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8F31C21E17
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC077108;
	Thu,  9 May 2024 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="KB2e49G2"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCA3770FC
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278763; cv=none; b=Ey0liRjpLwJd/it+untd8ESGezB0xtL1W0f6JgobqmhMD4TqH/fEkTQD10aaB6Tv2A+vsuS/inxg644u4LDTrikKTC9zBEknVCMK0U3F3BjLMS85mhXIcSeSaPHpRmAN/B1my1XFNLpPCRwlWf9+3K8WkkSTSMAGHoRJ/gkDi4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278763; c=relaxed/simple;
	bh=RJE7wtOGuiVA6SM4445qxe+uUKV5GXrAqRRpV1HQKLI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cXJe1yAHKgSfeAXW93coUXBjhI1OzMCHQV7p3CCqgn9D1SQKhKa4mXj1xQWEV5g1HUFyRbBcETv6MUnxaeNJVdi3lnauUZDTY58suHQUL7Qj6OFYmQIsamvOG/3pl8ngrkbU98i9OeBJtDdu59SbEl3cEJpQ87nc5BoqTCLuhU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=KB2e49G2; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1FED92C0BA5;
	Fri, 10 May 2024 06:19:13 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1715278753;
	bh=RJE7wtOGuiVA6SM4445qxe+uUKV5GXrAqRRpV1HQKLI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=KB2e49G20LPOmo8v7NzrcDu+9gdvwkK88l08p5RK4IIuy52GACt6+qVS+gGSbmDvK
	 ZCVgndZLRADlr9kpSYOCJxJqSMc1d75LfXbmuTkgqNKr9nkYaMpMc7NXZxRCAaVp1y
	 YSxKdJHpcBDJh0rL7c9jzKXYb87TpBXcEQS8jCnikkWQNIS6Fr7FO//VZIEQ3FpHuq
	 fmWQqCOqy7KH1ua8iI6xE0ofoazOjQ76yCvP6TG8k8FEw5OCNZDkXZ8oYNSEhlsH9s
	 VB5qliUkPqkPXdBOtgL+H+qGzFvRd0ZlJC2Mxyepkg9eKdFLO5jfY/eU/aOZdnjBJg
	 yYI719MhesGwQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B663d13a10000>; Fri, 10 May 2024 06:19:13 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Fri, 10 May 2024 06:19:12 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Fri, 10 May 2024 06:19:12 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Fri, 10 May 2024 06:19:12 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Krzysztof Kozlowski <krzk@kernel.org>, "jdelvare@suse.com"
	<jdelvare@suse.com>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Document adt7475 PWM initial
 duty cycle
Thread-Topic: [PATCH v2 1/2] dt-bindings: hwmon: Document adt7475 PWM initial
 duty cycle
Thread-Index: AQHaoZJj5QPx6ZJTO0uIJD/DY55QH7GNspyAgAC7vYA=
Date: Thu, 9 May 2024 18:19:12 +0000
Message-ID: <d11093bb-230b-4918-a8cd-4f4eb760ccf3@alliedtelesis.co.nz>
References: <20240508215504.300580-1-chris.packham@alliedtelesis.co.nz>
 <20240508215504.300580-2-chris.packham@alliedtelesis.co.nz>
 <fe5b3af9-b307-45e1-b190-ba2b3327a8df@kernel.org>
In-Reply-To: <fe5b3af9-b307-45e1-b190-ba2b3327a8df@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDEE378BC921B04C85E523A937244128@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=MfrPuI/f c=1 sm=1 tr=0 ts=663d13a1 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=elF3_sayRK1upBjPgWEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgS3J6eXN6dG9mLA0KDQpPbiA5LzA1LzI0IDE5OjA2LCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAwOC8wNS8yMDI0IDIzOjU1LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gQWRk
IGRvY3VtZW50YXRpb24gZm9yIHRoZSBwd20taW5pdGlhbC1kdXR5LWN5Y2xlIGFuZA0KPj4gcHdt
LWluaXRpYWwtZnJlcXVlbmN5IHByb3BlcnRpZXMuIFRoZXNlIGFsbG93IHRoZSBzdGFydGluZyBz
dGF0ZSBvZiB0aGUNCj4+IFBXTSBvdXRwdXRzIHRvIGJlIHNldCB0byBjYXRlciBmb3IgaGFyZHdh
cmUgZGVzaWducyB3aGVyZSB1bmRlc2lyYWJsZQ0KPj4gYW1vdW50cyBvZiBub2lzZSBpcyBjcmVh
dGVkIGJ5IHRoZSBkZWZhdWx0IGhhcmR3YXJlIHN0YXRlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+IC0t
LQ0KPj4NCj4+IE5vdGVzOg0KPj4gICAgICBDaGFuZ2VzIGluIHYyOg0KPj4gICAgICAtIERvY3Vt
ZW50IDAgYXMgYSB2YWxpZCB2YWx1ZSAobGVhdmVzIGhhcmR3YXJlIGFzLWlzKQ0KPj4NCj4+ICAg
Li4uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWR0NzQ3NS55YW1sICAgIHwgMjcgKysrKysr
KysrKysrKysrKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaHdtb24vYWR0NzQ3NS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2h3bW9uL2FkdDc0NzUueWFtbA0KPj4gaW5kZXggMDUxYzk3NmFiNzExLi45N2RlZGEw
ODJiNGEgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aHdtb24vYWR0NzQ3NS55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaHdtb24vYWR0NzQ3NS55YW1sDQo+PiBAQCAtNTEsNiArNTEsMzAgQEAgcHJvcGVydGll
czoNCj4+ICAgICAgICAgZW51bTogWzAsIDFdDQo+PiAgICAgICAgIGRlZmF1bHQ6IDENCj4+ICAg
DQo+PiArICBhZGkscHdtLWluaXRpYWwtZHV0eS1jeWNsZToNCj4+ICsgICAgZGVzY3JpcHRpb246
IHwNCj4+ICsgICAgICBDb25maWd1cmVzIHRoZSBpbml0aWFsIGR1dHkgY3ljbGUgZm9yIHRoZSBQ
V00gb3V0cHV0cy4gVGhlIGhhcmR3YXJlDQo+PiArICAgICAgZGVmYXVsdCBpcyAxMDAlIGJ1dCB0
aGlzIG1heSBjYXVzZSB1bndhbnRlZCBmYW4gbm9pc2UgYXQgc3RhcnR1cC4gU2V0DQo+PiArICAg
ICAgdGhpcyB0byBhIHZhbHVlIGZyb20gMCAoMCUgZHV0eSBjeWNsZSkgdG8gMjU1ICgxMDAlIGR1
dHkgY3ljbGUpLg0KPj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy91aW50MzItYXJyYXkNCj4+ICsgICAgbWluSXRlbXM6IDMNCj4+ICsgICAgbWF4SXRlbXM6IDMN
Cj4+ICsgICAgaXRlbXM6DQo+PiArICAgICAgbWluaW11bTogMA0KPj4gKyAgICAgIG1heGltdW06
IDI1NQ0KPj4gKyAgICAgIGRlZmF1bHQ6IDI1NQ0KPj4gKw0KPj4gKyAgYWRpLHB3bS1pbml0aWFs
LWZyZXF1ZW5jeToNCj4gRnJlcXVlbmN5IHVzdWFsbHkgaGFzIHNvbWUgdW5pdHMsIHNvIHVzZSBh
cHByb3ByaWF0ZSB1bml0IHN1ZmZpeCBhbmQNCj4gZHJvcCAkcmVmLiAgTWF5YmUgdGhhdCdzIGp1
c3QgdGFyZ2V0LXJwbSBwcm9wZXJ0eT8NCj4NCj4gQnV0IGlzbid0IHRoaXMgZHVwbGljYXRpbmcg
cHJldmlvdXMgcHJvcGVydHk/IFRoaXMgaXMgZmFuIGNvbnRyb2xsZXIsDQo+IG5vdCBQV00gcHJv
dmlkZXIgKGluIGFueSBjYXNlIHlvdSBtaXNzIHByb3BlciAkcmVmcyB0byBwd20ueWFtbCBvcg0K
PiBmYW4tY29tbW9uLnlhbWwpLCBzbyB0aGUgb25seSB0aGluZyB5b3UgaW5pdGlhbGx5IHdhbnQg
dG8gY29uZmlndXJlIGlzDQo+IHRoZSBmYW4gcm90YXRpb24sIG5vdCBzcGVjaWZpYyBQV00gd2F2
ZWZvcm0uIElmIHlvdSB5b3Ugd2FudCB0bw0KPiBjb25maWd1cmUgc3BlY2lmaWMgUFdNIHdhdmVm
b3JtLCB0aGVuIGl0J3MgYSBQV00gcHJvdmlkZXIuLi4gYnV0IGl0IGlzDQo+IG5vdC4uLiBDb25m
dXNlZC4NCg0KVGhlcmUncyB0d28gdGhpbmdzIGdvaW5nIG9uIGhlcmUuIFRoZXJlJ3MgYSBQV00g
ZHV0eSBjeWNsZSB3aGljaCBpcyANCmNvbmZpZ3VyYWJsZSBmcm9tIDAlIHRvIDEwMCUuIEl0IG1p
Z2h0IGJlIG5pY2UgaWYgdGhpcyB3YXMgZXhwcmVzc2VkIGFzIA0KYSBwZXJjZW50YWdlIGluc3Rl
YWQgb2YgMC0yNTUgYnV0IEkgd2VudCB3aXRoIHRoZSBsYXR0ZXIgYmVjYXVzZSB0aGF0J3MgDQpo
b3cgdGhlIHN5c2ZzIEFCSSBmb3IgdGhlIGR1dHkgY3ljbGUgd29ya3MuDQoNClRoZSBmcmVxdWVu
Y3kgKHdoaWNoIEknbGwgY2FsbCBhZGkscHdtLWluaXRpYWwtZnJlcXVlbmN5LWh6IGluIHYzKSAN
CmFmZmVjdHMgaG93IHRoYXQgZHV0eSBjeWNsZSBpcyBwcmVzZW50ZWQgdG8gdGhlIGZhbnMuIFNv
IHlvdSBjb3VsZCBzdGlsbCANCmhhdmUgYSBkdXR5IGN5Y2xlIG9mIDUwJSBhdCBhbnkgZnJlcXVl
bmN5LiBXaGF0IGZyZXF1ZW5jeSBpcyBiZXN0IA0KZGVwZW5kcyBvbiB0aGUga2luZCBvZiBmYW5z
IGJlaW5nIHVzZWQuIEluIG15IHBhcnRpY3VsYXIgY2FzZSB0aGUgbG93ZXIgDQpmcmVxdWVuY2ll
cyBlbmQgdXAgd2l0aCB0aGUgZmFucyBvc2NpbGxhdGluZyBhbm5veWluZ2x5IHNvIEkgdXNlIHRo
ZSANCmhpZ2hlc3Qgc2V0dGluZy4NCg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
Pg==

