Return-Path: <linux-kernel+bounces-175979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21208C2835
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF5A281C38
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8A1171E5D;
	Fri, 10 May 2024 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="jgvQ/a3j"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF1A127E18
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715356321; cv=none; b=EXKbZRuHg+3tsGrRgNSLmOubPv7Ss7ppC3MGiyPtzTUfekRBC7mMxjdeOakrgI1AaUc3qxm1wOAfM0cz7qOOcnHXpe9GIr4xzcqDhkTPri64K0Ksl4XWhCMtvX8qOwoGGVemYv7BCqhzz5yto0NRc7NPrS06r8xt5aqwgu1cQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715356321; c=relaxed/simple;
	bh=dXUJUODtKyCuDIIp74YorO/XM9QOZHTtO4aHgtAGTYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H+X8J26OVEz6rUPabMvDIE/17hY07qhQqLROZSzj/sPAnwazkJmkXcSyUBNu90hr6/oGari9TwYOvCO0JUNF0I5M1beKgE4OTdG11dT/hDg+tVIha0sGinn/P2AEPew/sB5OCd30jAAdhwnM6DRQw7B0O9786DbhhpXPeKaQjCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=jgvQ/a3j; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E7C832C03FE;
	Sat, 11 May 2024 03:51:54 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1715356314;
	bh=dXUJUODtKyCuDIIp74YorO/XM9QOZHTtO4aHgtAGTYs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=jgvQ/a3juMG4WtiIqP9PzDXuUp+Juyv+gkIIEDY0hlJdO7x1p5LIzUtsPuRSqTNv2
	 CCj/GiVzqhOiTSkgMP/RcjYYMRovT8tVru4qQqOW0E62XXxEsMH6a4UAYCyRUTTLcw
	 C4q2Vc2Wk/sWslRbBTfeL/JHS9I57+HB3tyE0ddtlxzxfeaT3jbokJOQ4X4/9bV2a/
	 nIgOJFednuU6xB0fA3jv7qdC9G6DnEhumiyrpiOj9RYDXp6/vEHKFS6iLTJGZ51dzi
	 DyGiXVhzvvevfoLo76PsRqqGgHWtLgAokt3TtMggIGX/CKC3PeiPdHVAojovk8oaSg
	 pClk1MLlHbwnw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B663e429a0001>; Sat, 11 May 2024 03:51:54 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 11 May 2024 03:51:54 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Sat, 11 May 2024 03:51:54 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Guenter Roeck <linux@roeck-us.net>
CC: Krzysztof Kozlowski <krzk@kernel.org>, "jdelvare@suse.com"
	<jdelvare@suse.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Document adt7475 PWM initial
 duty cycle
Thread-Topic: [PATCH v2 1/2] dt-bindings: hwmon: Document adt7475 PWM initial
 duty cycle
Thread-Index: AQHaoZJj5QPx6ZJTO0uIJD/DY55QH7GNspyAgAC7vYCAAJu9AIAAzY4A
Date: Fri, 10 May 2024 15:51:54 +0000
Message-ID: <35361786-ef5f-4d81-83e8-e347f47c83ed@alliedtelesis.co.nz>
References: <20240508215504.300580-1-chris.packham@alliedtelesis.co.nz>
 <20240508215504.300580-2-chris.packham@alliedtelesis.co.nz>
 <fe5b3af9-b307-45e1-b190-ba2b3327a8df@kernel.org>
 <d11093bb-230b-4918-a8cd-4f4eb760ccf3@alliedtelesis.co.nz>
 <94c843e2-4415-4786-bfd4-a77fdbbfab07@roeck-us.net>
In-Reply-To: <94c843e2-4415-4786-bfd4-a77fdbbfab07@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <53BCF6F17223F042AABD0ED0D6CA9B72@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=MfrPuI/f c=1 sm=1 tr=0 ts=663e429a a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=7QraPcOLQ5AibYo7dxQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAxMC8wNS8yNCAxNTozNiwgR3VlbnRlciBSb2VjayB3cm90ZToNCj4gQ2hyaXMsDQo+DQo+
IE9uIFRodSwgTWF5IDA5LCAyMDI0IGF0IDA2OjE5OjEyUE0gKzAwMDAsIENocmlzIFBhY2toYW0g
d3JvdGU6DQo+PiBIaSBLcnp5c3p0b2YsDQo+Pg0KPj4gT24gOS8wNS8yNCAxOTowNiwgS3J6eXN6
dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiBPbiAwOC8wNS8yMDI0IDIzOjU1LCBDaHJpcyBQYWNr
aGFtIHdyb3RlOg0KPj4+PiBBZGQgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIHB3bS1pbml0aWFsLWR1
dHktY3ljbGUgYW5kDQo+Pj4+IHB3bS1pbml0aWFsLWZyZXF1ZW5jeSBwcm9wZXJ0aWVzLiBUaGVz
ZSBhbGxvdyB0aGUgc3RhcnRpbmcgc3RhdGUgb2YgdGhlDQo+Pj4+IFBXTSBvdXRwdXRzIHRvIGJl
IHNldCB0byBjYXRlciBmb3IgaGFyZHdhcmUgZGVzaWducyB3aGVyZSB1bmRlc2lyYWJsZQ0KPj4+
PiBhbW91bnRzIG9mIG5vaXNlIGlzIGNyZWF0ZWQgYnkgdGhlIGRlZmF1bHQgaGFyZHdhcmUgc3Rh
dGUuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2to
YW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+Pj4gLS0tDQo+Pj4+DQo+Pj4+IE5vdGVzOg0KPj4+
PiAgICAgICBDaGFuZ2VzIGluIHYyOg0KPj4+PiAgICAgICAtIERvY3VtZW50IDAgYXMgYSB2YWxp
ZCB2YWx1ZSAobGVhdmVzIGhhcmR3YXJlIGFzLWlzKQ0KPj4+Pg0KPj4+PiAgICAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy9od21vbi9hZHQ3NDc1LnlhbWwgICAgfCAyNyArKysrKysrKysrKysrKysr
KystDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaHdtb24vYWR0NzQ3NS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2h3bW9uL2FkdDc0NzUueWFtbA0KPj4+PiBpbmRleCAwNTFjOTc2YWI3MTEuLjk3ZGVkYTA4
MmI0YSAxMDA2NDQNCj4+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2h3bW9uL2FkdDc0NzUueWFtbA0KPj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaHdtb24vYWR0NzQ3NS55YW1sDQo+Pj4+IEBAIC01MSw2ICs1MSwzMCBAQCBwcm9w
ZXJ0aWVzOg0KPj4+PiAgICAgICAgICBlbnVtOiBbMCwgMV0NCj4+Pj4gICAgICAgICAgZGVmYXVs
dDogMQ0KPj4+PiAgICANCj4+Pj4gKyAgYWRpLHB3bS1pbml0aWFsLWR1dHktY3ljbGU6DQo+Pj4+
ICsgICAgZGVzY3JpcHRpb246IHwNCj4+Pj4gKyAgICAgIENvbmZpZ3VyZXMgdGhlIGluaXRpYWwg
ZHV0eSBjeWNsZSBmb3IgdGhlIFBXTSBvdXRwdXRzLiBUaGUgaGFyZHdhcmUNCj4+Pj4gKyAgICAg
IGRlZmF1bHQgaXMgMTAwJSBidXQgdGhpcyBtYXkgY2F1c2UgdW53YW50ZWQgZmFuIG5vaXNlIGF0
IHN0YXJ0dXAuIFNldA0KPj4+PiArICAgICAgdGhpcyB0byBhIHZhbHVlIGZyb20gMCAoMCUgZHV0
eSBjeWNsZSkgdG8gMjU1ICgxMDAlIGR1dHkgY3ljbGUpLg0KPj4+PiArICAgICRyZWY6IC9zY2hl
bWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMi1hcnJheQ0KPj4+PiArICAgIG1pbkl0
ZW1zOiAzDQo+Pj4+ICsgICAgbWF4SXRlbXM6IDMNCj4+Pj4gKyAgICBpdGVtczoNCj4+Pj4gKyAg
ICAgIG1pbmltdW06IDANCj4+Pj4gKyAgICAgIG1heGltdW06IDI1NQ0KPj4+PiArICAgICAgZGVm
YXVsdDogMjU1DQo+Pj4+ICsNCj4+Pj4gKyAgYWRpLHB3bS1pbml0aWFsLWZyZXF1ZW5jeToNCj4+
PiBGcmVxdWVuY3kgdXN1YWxseSBoYXMgc29tZSB1bml0cywgc28gdXNlIGFwcHJvcHJpYXRlIHVu
aXQgc3VmZml4IGFuZA0KPj4+IGRyb3AgJHJlZi4gIE1heWJlIHRoYXQncyBqdXN0IHRhcmdldC1y
cG0gcHJvcGVydHk/DQo+Pj4NCj4+PiBCdXQgaXNuJ3QgdGhpcyBkdXBsaWNhdGluZyBwcmV2aW91
cyBwcm9wZXJ0eT8gVGhpcyBpcyBmYW4gY29udHJvbGxlciwNCj4+PiBub3QgUFdNIHByb3ZpZGVy
IChpbiBhbnkgY2FzZSB5b3UgbWlzcyBwcm9wZXIgJHJlZnMgdG8gcHdtLnlhbWwgb3INCj4+PiBm
YW4tY29tbW9uLnlhbWwpLCBzbyB0aGUgb25seSB0aGluZyB5b3UgaW5pdGlhbGx5IHdhbnQgdG8g
Y29uZmlndXJlIGlzDQo+Pj4gdGhlIGZhbiByb3RhdGlvbiwgbm90IHNwZWNpZmljIFBXTSB3YXZl
Zm9ybS4gSWYgeW91IHlvdSB3YW50IHRvDQo+Pj4gY29uZmlndXJlIHNwZWNpZmljIFBXTSB3YXZl
Zm9ybSwgdGhlbiBpdCdzIGEgUFdNIHByb3ZpZGVyLi4uIGJ1dCBpdCBpcw0KPj4+IG5vdC4uLiBD
b25mdXNlZC4NCj4+IFRoZXJlJ3MgdHdvIHRoaW5ncyBnb2luZyBvbiBoZXJlLiBUaGVyZSdzIGEg
UFdNIGR1dHkgY3ljbGUgd2hpY2ggaXMNCj4+IGNvbmZpZ3VyYWJsZSBmcm9tIDAlIHRvIDEwMCUu
IEl0IG1pZ2h0IGJlIG5pY2UgaWYgdGhpcyB3YXMgZXhwcmVzc2VkIGFzDQo+PiBhIHBlcmNlbnRh
Z2UgaW5zdGVhZCBvZiAwLTI1NSBidXQgSSB3ZW50IHdpdGggdGhlIGxhdHRlciBiZWNhdXNlIHRo
YXQncw0KPj4gaG93IHRoZSBzeXNmcyBBQkkgZm9yIHRoZSBkdXR5IGN5Y2xlIHdvcmtzLg0KPj4N
Cj4+IFRoZSBmcmVxdWVuY3kgKHdoaWNoIEknbGwgY2FsbCBhZGkscHdtLWluaXRpYWwtZnJlcXVl
bmN5LWh6IGluIHYzKQ0KPj4gYWZmZWN0cyBob3cgdGhhdCBkdXR5IGN5Y2xlIGlzIHByZXNlbnRl
ZCB0byB0aGUgZmFucy4gU28geW91IGNvdWxkIHN0aWxsDQo+PiBoYXZlIGEgZHV0eSBjeWNsZSBv
ZiA1MCUgYXQgYW55IGZyZXF1ZW5jeS4gV2hhdCBmcmVxdWVuY3kgaXMgYmVzdA0KPj4gZGVwZW5k
cyBvbiB0aGUga2luZCBvZiBmYW5zIGJlaW5nIHVzZWQuIEluIG15IHBhcnRpY3VsYXIgY2FzZSB0
aGUgbG93ZXINCj4+IGZyZXF1ZW5jaWVzIGVuZCB1cCB3aXRoIHRoZSBmYW5zIG9zY2lsbGF0aW5n
IGFubm95aW5nbHkgc28gSSB1c2UgdGhlDQo+PiBoaWdoZXN0IHNldHRpbmcuDQo+Pg0KPiBNeSB1
ZG5lcnN0YW5kaW5nIGlzIHRoYXQgd2UgYXJlIHN1cHBvc2VkIHRvIHVzZSBzdGFuZGFyZCBwd20g
cHJvdmlkZXINCj4gcHJvcGVydGllcy4gVGhlIHByb3BlcnR5IGRlc2NyaXB0aW9uIGlzIHByb3Zp
ZGVyIHNwZWNpY2ljLCBzbyBJIHRoaW5rDQo+IHdlIGNhbiBwcmV0dHkgbXVjaCBqdXN0IG1ha2Ug
aXQgdXAuDQo+DQo+IEVzc2VudGlhbGx5IHlvdSdkIGZpcnN0IGRlZmluZSBhIHB3bSBwcm92aWRl
ciB3aGljaCBkZWZpbmVzIGFsbCB0aGUNCj4gcHdtIHBhcmFtZXRlcnMgbmVlZGVkLCBzdWNoIGFz
IHB3bSBmcmVxZW5jeSwgZGVmYXVsdCBkdXR5IGN5Y2xlLA0KPiBhbmQgZmxhZ3Mgc3VjaCBhcyBQ
V01fUE9MQVJJVFlfSU5WRVJURUQuIFlvdSdkIHRoZW4gYWRkIHNvbWV0aGluZyBsaWtlDQo+DQo+
IAlwd21zID0gPCZwd20gaW5kZXggZnJlcXVlbmN5IGR1dHlfY3ljbGUgLi4uIGZsYWdzPjsNCj4N
Cj4gdG8gdGhlIG5vZGUgZm9yIGVhY2ggZmFuLCBhbmQgYmUgZG9uZS4NCj4NCj4gVGhhdCBkb2Vz
bid0IG1lYW4gdGhhdCB3ZSB3b3VsZCBhY3R1YWxseSBoYXZlIHRvIHJlZ2lzdGVyIHRoZSBjaGlw
DQo+IGFzIHB3bSBwcm92aWRlciB3aXRoIHRoZSBwd20gc3Vic3lzdGVtOyBhbGwgd2Ugd291bGQg
aGF2ZSB0byBkbyBpcyB0bw0KPiBpbnRlcnByZXQgdGhlIHByb3BlcnR5IHZhbHVlcy4NCg0KV2Un
dmUgYWxyZWFkeSBnb3QgdGhlIHB3bS1hY3RpdmUtc3RhdGUgYXMgYSBzZXBhcmF0ZSBwcm9wZXJ0
eSBzbyB0aGF0IA0KbWlnaHQgYmUgdHJpY2t5IHRvIGRlYWwgd2l0aCwgSSBndWVzcyBpdCBjb3Vs
ZCBiZSBkZXByZWNhdGVkIGluIGZhdm91ciANCm9mIHNvbWV0aGluZyBlbHNlLiBMb29raW5nIGF0
IHB3bS55YW1sIGFuZCBmYW4tY29tbW9uLnlhbWwgSSBjYW4ndCBxdWl0ZSANCnNlZSBob3cgdGhh
dCdkIGhlbHAgaGVyZS4gV2VyZSB5b3UgdGhpbmtpbmcgbWF5YmUgc29tZXRoaW5nIGxpa2UNCg0K
cHdtOiBod21vbkAyZSB7DQogwqDCoMKgIGNvbXBhdGlibGUgPSAiYWRpLGFkdDc0NzYiOw0KIMKg
wqDCoCByZWcgPSA8MHgyZT47DQogwqDCoMKgICNwd20tY2VsbHMgPSA8ND47DQogwqDCoMKgIGZh
bi0wIHsNCiDCoMKgwqAgwqDCoMKgIHB3bXMgPSA8JnB3bSAwIDI1NSAyMjUwMCBQV01fUE9MQVJJ
VFlfSU5WRVJURUQ+Ow0KIMKgwqDCoCDCoMKgwqAgcHdtLW5hbWVzID0gIlBXTTEiOw0KIMKgwqDC
oCDCoMKgwqAgdGFjaC1jaCA9IDwwPjsNCiDCoMKgwqAgfTsNCiDCoMKgwqAgZmFuLTEgew0KIMKg
wqDCoCDCoMKgwqAgLy8gY29udHJvbGxlZCBieSBwd20gMA0KIMKgwqDCoCDCoMKgwqAgdGFjaC1j
aCA9IDwxPg0KIMKgwqDCoCB9Ow0KIMKgwqDCoCBmYW4tMCB7DQogwqDCoMKgwqDCoMKgwqAgcHdt
cyA9IDwmcHdtIDIgMjU1IDIyNTAwIFBXTV9QT0xBUklUWV9JTlZFUlRFRD47DQogwqDCoMKgIMKg
wqDCoCBwd20tbmFtZXMgPSAiUFdNMyI7DQogwqDCoMKgwqDCoMKgwqAgdGFjaC1jaCA8Mj47DQog
wqDCoMKgIH07DQogwqDCoMKgIGZhbi0xIHsNCiDCoMKgwqDCoMKgwqDCoCAvLyBjb250cm9sbGVk
IGJ5IHB3bSAyDQogwqDCoMKgwqDCoMKgwqAgdGFjaC1jaCA9IDwzPg0KIMKgwqDCoCB9Ow0KfTsN
Cg==

