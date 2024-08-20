Return-Path: <linux-kernel+bounces-293566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533C0958166
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E2E282223
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDA518A944;
	Tue, 20 Aug 2024 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="pDUTSS9c"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C518E352
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143960; cv=none; b=G6Civb5yZRXfQ6F74buXkwEVSQ+sDPzIGsA/Nn1z5mBu1gkUvU4L//PfDsQP26c0E3T6SZ0lWLCcVftIfG+8a12mjss5anLWse2EmAHtNzJCvB/QgXkvsfsHvsgnxhCBJZd7m+Cz5TM8pV/vDjiViG2voKsslyQ4VjHN8q/dV74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143960; c=relaxed/simple;
	bh=eIOkP9xE3IJjpxOBMIGmn6ZTxMt1M+Ylw+RA8R9iFzM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eOv133z5DwturQNlroZKMrqAgMDyXBK40h/c+URGfhz0a8MjTSGxaZ3G+C2fhNu8v/xTm2v25DgbpkZQ8BkzB+d45bGwdmYV5a0ldPsCpuknMP9YNwOqGYCnZQDn0hTWce1qwB+naoaPjG446LasvoKyHXWyeVgDL1boPdBvXnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=pDUTSS9c; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724143947; x=1726735947;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eIOkP9xE3IJjpxOBMIGmn6ZTxMt1M+Ylw+RA8R9iFzM=;
	b=pDUTSS9c3vGZMDFtwBoqDwcCPpmuomXMFgP9pCEFzhpR2lujUDygfZX/nr8f20lz
	6SerDbtCwg0M+TU4uuLlEXB4IajgCaaM67cr7jM8ZOF2qlk/8apIkx12c91PWeNy
	0kaBnGdegk5zM0uAr+6N8AHK+aOs0GpjAgCHJCoYfMI=;
X-AuditID: ac14000a-03e52700000021bc-a8-66c4594ac09a
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C4.4D.08636.A4954C66; Tue, 20 Aug 2024 10:52:26 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 20 Aug
 2024 10:52:26 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Tue, 20 Aug 2024 10:52:26 +0200
From: Yannic Moog <Y.Moog@phytec.de>
To: Benjamin Hahn <B.Hahn@phytec.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "robh@kernel.org"
	<robh@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Teresa Remmet <T.Remmet@phytec.de>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, PHYTEC Upstream
	<upstream@lists.phytec.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [Upstream] [PATCH] arm64: dts: imx8mp-phyboard-pollux-rdk: Add
 support for PCIe
Thread-Topic: [Upstream] [PATCH] arm64: dts: imx8mp-phyboard-pollux-rdk: Add
 support for PCIe
Thread-Index: AQHa7Xioa/ZE9tcInkimclke5FKfWbIvwBWA
Date: Tue, 20 Aug 2024 08:52:26 +0000
Message-ID: <134471bf20329ab3def09f0a56a6dfc88e1a395a.camel@phytec.de>
References: <20240813-wip-bhahn-add_pcie_support-v1-1-c1bb062b4e1f@phytec.de>
In-Reply-To: <20240813-wip-bhahn-add_pcie_support-v1-1-c1bb062b4e1f@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BB503C31A5DB942ACB03E34A1AFFCEE@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWyRpKBV9cr8kiaQdsUPYs1e88xWcw/co7V
	4uFVf4uZ91rZLFZN3cli8XLWPTaLTY+vsVpc3jWHzeL/nh3sFn+3b2KxeLFF3KL7nboDj8fO
	WXfZPTat6mTz2Lyk3uPF5pmMHv3dLawe/X8NPD5vkgtgj+KySUnNySxLLdK3S+DKePb7PFPB
	CfmKna1mDYwP5LoYOTkkBEwkPvxZxtzFyMUhJLCESaJ97hxGCOc+o8SHX1PZIJwNjBK3b/xi
	AWlhE1CRODnjEiOILSLQzSxxr8kNpIhZYA2TxO2La1i7GDk4hAXiJOasUgAxRQTiJb5844Qo
	N5I4P/kMWCuLgKrE7K0TwUbyCrhJPF57kB2kXEjAV+JtkytImFPAT+LHkRlMIDajgKzEhg3n
	mUFsZgFxiU3PvrNCPCAgsWQPRFxCQFTi5eN/UHF5iRO3pjGBjGQW0JRYv0sfwrSQODYxCGKK
	osSU7ofsEAcISpyc+YRlAqP4LCQLZiE0z0JonoWkeRaS5gWMrKsYhXIzk7NTizKz9QoyKktS
	k/VSUjcxgiJdhIFrB2PfHI9DjEwcjIcYJTiYlUR4u18eTBPiTUmsrEotyo8vKs1JLT7EKM3B
	oiTOu7ojOFVIID2xJDU7NbUgtQgmy8TBKdXAKPKhcOGfmIfcTdt/r9vz/urjvZ5eSj1vjpk2
	3GX7HfpGuTzu6SmOBSt2uc480nZF/pTU46O/Js4NbjmgfGJmWsnT86sYdm7R+RGYN0fiaeyO
	8wo7FKeeuvzv0bGyEMPOsLk/vX/VZM6UKioQcH8t2JEXx2Ml4Hqhde+TheUfG/9M37iNLVXn
	1jclluKMREMt5qLiRAB6Lstr4gIAAA==

SGVsbG8gQmVuamFtaW4sDQoNCk9uIFR1ZSwgMjAyNC0wOC0xMyBhdCAxNDowMiArMDIwMCwgQmVu
amFtaW4gSGFobiB3cm90ZToNCj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBNaW5pIFBDSWUgc2xvdC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEhhaG4gPEIuSGFobkBwaHl0ZWMuZGU+DQo+
IC0tLQ0KPiDCoC4uLi9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLmR0
c8KgwqAgfCA0MiArKysrKysrKysrKysrKysrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQy
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMNCj4gYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMNCj4gaW5kZXgg
MDBhMjQwNDg0YzI1Li4wZWNiMmY2MmMzN2YgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLmR0cw0KPiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5k
dHMNCj4gQEAgLTYsNiArNiw3IEBADQo+IMKgDQo+IMKgL2R0cy12MS87DQo+IMKgDQo+ICsjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUuaD4NCj4gwqAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvbGVkcy9sZWRzLXBjYTk1MzIuaD4NCj4gwqAjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
cHdtL3B3bS5oPg0KPiDCoCNpbmNsdWRlICJpbXg4bXAtcGh5Y29yZS1zb20uZHRzaSINCj4gQEAg
LTYzLDYgKzY0LDE3IEBAIHJlZ19jYW4yX3N0Ynk6IHJlZ3VsYXRvci1jYW4yLXN0Ynkgew0KPiDC
oAkJcmVndWxhdG9yLW5hbWUgPSAiY2FuMi1zdGJ5IjsNCj4gwqAJfTsNCj4gwqANCj4gKwlyZWdf
cGNpZTA6IHJlZ3VsYXRvci1wY2llIHsNCj4gKwkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4
ZWQiOw0KPiArCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiArCQlwaW5jdHJsLTAgPSA8
JnBpbmN0cmxfcGNpZTBfcmVnPjsNCj4gKwkJcmVndWxhdG9yLW5hbWUgPSAiTVBDSUVfM1YzIjsN
Cj4gKwkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+ICsJCXJlZ3VsYXRv
ci1tYXgtbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPiArCQlncGlvID0gPCZncGlvMSAxNCBHUElP
X0FDVElWRV9ISUdIPjsNCj4gKwkJZW5hYmxlLWFjdGl2ZS1oaWdoOw0KPiArCX07DQo+ICsNCg0K
cGNpZSB1c2VzIHRoZSByZWdfdmNjXzN2M19zdy4gRHJvcCB0aGlzIG5vZGUgYW5kIHVzZSB0aGUg
YXBwcm9wcmlhdGUgcmVndWxhdG9yIGluc3RlYWQuDQoNCj4gwqAJcmVnX2x2ZHMxX3JlZ19lbjog
cmVndWxhdG9yLWx2ZHMxIHsNCj4gwqAJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsN
Cj4gwqAJCWVuYWJsZS1hY3RpdmUtaGlnaDsNCj4gQEAgLTE5NSw2ICsyMDcsMjMgQEAgJnNudnNf
cHdya2V5IHsNCj4gwqAJc3RhdHVzID0gIm9rYXkiOw0KPiDCoH07DQo+IMKgDQo+ICsmcGNpZV9w
aHkgew0KPiArCWZzbCxyZWZjbGstcGFkLW1vZGUgPSA8SU1YOF9QQ0lFX1JFRkNMS19QQURfT1VU
UFVUPjsNCj4gKwlmc2wsY2xrcmVxLXVuc3VwcG9ydGVkOw0KDQpXaHkgZG8geW91IGhhdmUgdGhp
cyBhcyB1bnN1cHBvcnRlZD8gV2UgaGF2ZSBhIEdQSU8gY29ubmVjdGVkIHRvIENMS1JFUS4NCg0K
PiArCWNsb2NrcyA9IDwmaHNpb19ibGtfY3RybD47DQo+ICsJY2xvY2stbmFtZXMgPSAicmVmIjsN
Cj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICsvKiBNaW5pIFBDSWUgKi8NCj4g
KyZwY2llIHsNCj4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiArCXBpbmN0cmwtMCA9
IDwmcGluY3RybF9wY2llMD47DQo+ICsJcmVzZXQtZ3BpbyA9IDwmZ3BpbzEgOCBHUElPX0FDVElW
RV9MT1c+Ow0KPiArCXZwY2llLXN1cHBseSA9IDwmcmVnX3BjaWUwPjsNCj4gKwlzdGF0dXMgPSAi
b2theSI7DQo+ICt9Ow0KPiArDQo+IMKgJnB3bTMgew0KPiDCoAlzdGF0dXMgPSAib2theSI7DQo+
IMKgCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+IEBAIC0zNjYsNiArMzk1LDE5IEBAIE1Y
OE1QX0lPTVVYQ19TRDJfV1BfX0dQSU8yX0lPMjAJCTB4MTINCj4gwqAJCT47DQo+IMKgCX07DQo+
IMKgDQo+ICsJcGluY3RybF9wY2llMDogcGNpZTBncnAgew0KPiArCQlmc2wscGlucyA9IDwNCj4g
KwkJCU1YOE1QX0lPTVVYQ19HUElPMV9JTzExX19HUElPMV9JTzExCTB4NjAgLyogb3BlbiBkcmFp
biwgcHVsbCB1cCAqLw0KPiArCQkJTVg4TVBfSU9NVVhDX0dQSU8xX0lPMDhfX0dQSU8xX0lPMDgJ
MHg0MA0KDQpDYW4geW91IHBsZWFzZSByZW9yZGVyIG51bWVyaWNhbGx5IGFzY2VuZGluZz8NCllv
dSBhcmUgbWlzc2luZyBHUElPMSAxMCB1c2VkIGZvciBXQUtFIy4NCg0KPiArCQk+Ow0KPiArCX07
DQo+ICsNCj4gKwlwaW5jdHJsX3BjaWUwX3JlZzogcGNpZTByZWdncnAgew0KPiArCQlmc2wscGlu
cyA9IDwNCj4gKwkJCU1YOE1QX0lPTVVYQ19HUElPMV9JTzE0X19HUElPMV9JTzE0CTB4NDANCg0K
VGhpcyBncGlvIG11eGluZyBzaG91bGQgYmUgaW4gdGhlIHBjaWUwZ3JwLg0KDQpZYW5uaWMNCg0K
PiArCQk+Ow0KPiArCX07DQo+ICsNCj4gwqAJcGluY3RybF9wd20zOiBwd20zZ3JwIHsNCj4gwqAJ
CWZzbCxwaW5zID0gPA0KPiDCoAkJCU1YOE1QX0lPTVVYQ19TUERJRl9UWF9fUFdNM19PVVQJCTB4
MTINCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogN2M2MjZjZTRiYWUxYWMxNGY2MDA3NmQwMGVh
ZmU3MWFmMzA0NTBiYQ0KPiBjaGFuZ2UtaWQ6IDIwMjQwODEzLXdpcC1iaGFobi1hZGRfcGNpZV9z
dXBwb3J0LWI5YmQ3NWZjNGQ5OA0KPiANCj4gQmVzdCByZWdhcmRzLA0KDQo=

