Return-Path: <linux-kernel+bounces-295768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D49EE95A144
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F7F1F224DA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5154414D71F;
	Wed, 21 Aug 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="Kgyhgy62"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36306149C42
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253830; cv=none; b=slrK5M1uanuJraEXhtcUruObMi2Lpq9vtZNQuBWDm8oaeNP1ij6uj59Yj5jkzVyONu8BQB+WfBJdbzWZ2Hy0AxVlLFVnTnT4WhifyN3V6laKtAdGlhz+/kuW8creB0z7XF1ID0xs3XEcIOmde2ic/oJL5zw1Aekfy1zkqfwrqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253830; c=relaxed/simple;
	bh=NeVAotCcimmW80B66VrXJtlM9z2OoTRQx+4rygElhc0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FR50w/9OCwJGDIgp9I6fij0EEE+UvMEDZz9/eAYJRUfIua9DUkkFh0s9aRIMXqQnoJXT6oDntvq2zk3DJGjsBUagqHzmCwY0zCC8dK5lY9250qb4WpMj7DFu3Yj6pPLDp5+r2GjdIhIz4O8eM9isMoW5j5r1ogC6b6V9DHVKIso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=Kgyhgy62; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724253820; x=1726845820;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NeVAotCcimmW80B66VrXJtlM9z2OoTRQx+4rygElhc0=;
	b=Kgyhgy62YGO8HPMWx8yE5UFrAdgq1FoNPxwappiXc8bOovsURah2DM0Xn3+4xhiQ
	aIVSsRFthG0gXW7p3mIDD/XhPrIQWTms11jK137o0JT09BMiug3RLqSIkgR97+MQ
	NcJo6Ida/SZCCxKZPtzUbUJ3auOuZf6bt+svVPx8obM=;
X-AuditID: ac14000a-03e52700000021bc-59-66c6067ba6b5
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 38.96.08636.C7606C66; Wed, 21 Aug 2024 17:23:40 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 21 Aug
 2024 17:23:39 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Wed, 21 Aug 2024 17:23:39 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Yannic Moog <Y.Moog@phytec.de>, "kernel@pengutronix.de"
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
Thread-Index: AQHa7XimbOKZy6rq40+YdGI18WNCLLIvwBYAgAH/o4A=
Date: Wed, 21 Aug 2024 15:23:39 +0000
Message-ID: <88eff780-b029-459f-9ac4-2b9779f47929@phytec.de>
References: <20240813-wip-bhahn-add_pcie_support-v1-1-c1bb062b4e1f@phytec.de>
 <134471bf20329ab3def09f0a56a6dfc88e1a395a.camel@phytec.de>
In-Reply-To: <134471bf20329ab3def09f0a56a6dfc88e1a395a.camel@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F73A5715FB521478BC050A8F5AA3F74@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWyRpKBR7eG7ViawaQOJos1e88xWcw/co7V
	4uFVf4uZ91rZLFZN3cli8XLWPTaLTY+vsVpc3jWHzeL/nh3sFn+3b2KxeLFF3KL7nboDj8fO
	WXfZPTat6mTz2Lyk3uPF5pmMHv3dLawe/X8NPD5vkgtgj+KySUnNySxLLdK3S+DK2L9sG2vB
	E6WKX5+TGhg/KHYxcnJICJhI7Du4m72LkYtDSGAJk8Sue2/YIJz7jBILnjYxQjgbGCWaG9aw
	gbSwCahJ7HrzmhUkISLQySxx4fcsZhCHWWANk8Tti2uAMhwcwgJxEnNWKYCYIgLxEl++cYL0
	ighYSay+/4gZxGYRUJX48ukGC0gJr4CNxIlWZ4hdXYwSKx/2gO3iFHCX6NizkBHEZhSQldiw
	4TxYL7OAuMSmZ99ZIV4QkFiyByIuISAq8fLxP6i4vMSJW9OYQOYzC2hKrN+lD9FqIbHtwjqo
	MYoSU7ofsoPYvAKCEidnPmGZwCg+C8mGWQjds5B0z0LSPQtJ9wJG1lWMQrmZydmpRZnZegUZ
	lSWpyXopqZsYQREvwsC1g7FvjschRiYOxkOMEhzMSiK8SfeOpgnxpiRWVqUW5ccXleakFh9i
	lOZgURLnXd0RnCokkJ5YkpqdmlqQWgSTZeLglGpgXPef+66iqalkxJWYu/UX9TaqfvSJXPfc
	tHPSTbbAD3uKL/6fGa7Z4+U6W5Rnk0Lou1VFk/8IMOVa5355su/i9EcfchY63Pm7V/4ze9/s
	I+vfd/6tFkuYkNgz/dt8HmG5+uuhvi6WD+/HPf8sWJqQuenZnr2cCyUiQi7vcdiXOXn3jZUx
	e09+na3EUpyRaKjFXFScCAA7gUqp5gIAAA==

SGkgWWFubmljLA0KDQpPbiAyMC4wOC4yNCAxMDo1MiwgWWFubmljIE1vb2cgd3JvdGU6DQo+IEhl
bGxvIEJlbmphbWluLA0KPg0KPiBPbiBUdWUsIDIwMjQtMDgtMTMgYXQgMTQ6MDIgKzAyMDAsIEJl
bmphbWluIEhhaG4gd3JvdGU6DQo+PiBBZGQgc3VwcG9ydCBmb3IgdGhlIE1pbmkgUENJZSBzbG90
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEhhaG4gPEIuSGFobkBwaHl0ZWMuZGU+
DQo+PiAtLS0NCj4+ICDCoC4uLi9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgt
cmRrLmR0c8KgwqAgfCA0MiArKysrKysrKysrKysrKysrKysrKysrDQo+PiAgwqAxIGZpbGUgY2hh
bmdlZCwgNDIgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMNCj4+IGIvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGsuZHRz
DQo+PiBpbmRleCAwMGEyNDA0ODRjMjUuLjBlY2IyZjYyYzM3ZiAxMDA2NDQNCj4+IC0tLSBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLmR0
cw0KPj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJk
LXBvbGx1eC1yZGsuZHRzDQo+PiBAQCAtNiw2ICs2LDcgQEANCj4+ICAgDQo+PiAgwqAvZHRzLXYx
LzsNCj4+ICAgDQo+PiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3BoeS9waHktaW14OC1wY2llLmg+
DQo+PiAgwqAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvbGVkcy9sZWRzLXBjYTk1MzIuaD4NCj4+ICDC
oCNpbmNsdWRlIDxkdC1iaW5kaW5ncy9wd20vcHdtLmg+DQo+PiAgwqAjaW5jbHVkZSAiaW14OG1w
LXBoeWNvcmUtc29tLmR0c2kiDQo+PiBAQCAtNjMsNiArNjQsMTcgQEAgcmVnX2NhbjJfc3RieTog
cmVndWxhdG9yLWNhbjItc3RieSB7DQo+PiAgwqAJCXJlZ3VsYXRvci1uYW1lID0gImNhbjItc3Ri
eSI7DQo+PiAgwqAJfTsNCj4+ICAgDQo+PiArCXJlZ19wY2llMDogcmVndWxhdG9yLXBjaWUgew0K
Pj4gKwkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0KPj4gKwkJcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IjsNCj4+ICsJCXBpbmN0cmwtMCA9IDwmcGluY3RybF9wY2llMF9yZWc+Ow0K
Pj4gKwkJcmVndWxhdG9yLW5hbWUgPSAiTVBDSUVfM1YzIjsNCj4+ICsJCXJlZ3VsYXRvci1taW4t
bWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPj4gKwkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8
MzMwMDAwMD47DQo+PiArCQlncGlvID0gPCZncGlvMSAxNCBHUElPX0FDVElWRV9ISUdIPjsNCj4+
ICsJCWVuYWJsZS1hY3RpdmUtaGlnaDsNCj4+ICsJfTsNCj4+ICsNCj4gcGNpZSB1c2VzIHRoZSBy
ZWdfdmNjXzN2M19zdy4gRHJvcCB0aGlzIG5vZGUgYW5kIHVzZSB0aGUgYXBwcm9wcmlhdGUgcmVn
dWxhdG9yIGluc3RlYWQuDQpvaw0KPg0KPj4gIMKgCXJlZ19sdmRzMV9yZWdfZW46IHJlZ3VsYXRv
ci1sdmRzMSB7DQo+PiAgwqAJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4+ICDC
oAkJZW5hYmxlLWFjdGl2ZS1oaWdoOw0KPj4gQEAgLTE5NSw2ICsyMDcsMjMgQEAgJnNudnNfcHdy
a2V5IHsNCj4+ICDCoAlzdGF0dXMgPSAib2theSI7DQo+PiAgwqB9Ow0KPj4gICANCj4+ICsmcGNp
ZV9waHkgew0KPj4gKwlmc2wscmVmY2xrLXBhZC1tb2RlID0gPElNWDhfUENJRV9SRUZDTEtfUEFE
X09VVFBVVD47DQo+PiArCWZzbCxjbGtyZXEtdW5zdXBwb3J0ZWQ7DQo+IFdoeSBkbyB5b3UgaGF2
ZSB0aGlzIGFzIHVuc3VwcG9ydGVkPyBXZSBoYXZlIGEgR1BJTyBjb25uZWN0ZWQgdG8gQ0xLUkVR
Lg0KSXQgbG9va3MgbGlrZSB0aGUgcGNpZSBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCB1c2luZyBh
IEdQSU8gZm9yIGNsa3JlcS4gDQpTbyBpdCBkb2VzIG5vdCB3b3JrIGZvciB1cy4NCj4NCj4+ICsJ
Y2xvY2tzID0gPCZoc2lvX2Jsa19jdHJsPjsNCj4+ICsJY2xvY2stbmFtZXMgPSAicmVmIjsNCj4+
ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4gK307DQo+PiArDQo+PiArLyogTWluaSBQQ0llICovDQo+
PiArJnBjaWUgew0KPj4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPj4gKwlwaW5jdHJs
LTAgPSA8JnBpbmN0cmxfcGNpZTA+Ow0KPj4gKwlyZXNldC1ncGlvID0gPCZncGlvMSA4IEdQSU9f
QUNUSVZFX0xPVz47DQo+PiArCXZwY2llLXN1cHBseSA9IDwmcmVnX3BjaWUwPjsNCj4+ICsJc3Rh
dHVzID0gIm9rYXkiOw0KPj4gK307DQo+PiArDQo+PiAgwqAmcHdtMyB7DQo+PiAgwqAJc3RhdHVz
ID0gIm9rYXkiOw0KPj4gIMKgCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+PiBAQCAtMzY2
LDYgKzM5NSwxOSBAQCBNWDhNUF9JT01VWENfU0QyX1dQX19HUElPMl9JTzIwCQkweDEyDQo+PiAg
wqAJCT47DQo+PiAgwqAJfTsNCj4+ICAgDQo+PiArCXBpbmN0cmxfcGNpZTA6IHBjaWUwZ3JwIHsN
Cj4+ICsJCWZzbCxwaW5zID0gPA0KPj4gKwkJCU1YOE1QX0lPTVVYQ19HUElPMV9JTzExX19HUElP
MV9JTzExCTB4NjAgLyogb3BlbiBkcmFpbiwgcHVsbCB1cCAqLw0KPj4gKwkJCU1YOE1QX0lPTVVY
Q19HUElPMV9JTzA4X19HUElPMV9JTzA4CTB4NDANCj4gQ2FuIHlvdSBwbGVhc2UgcmVvcmRlciBu
dW1lcmljYWxseSBhc2NlbmRpbmc/DQo+IFlvdSBhcmUgbWlzc2luZyBHUElPMSAxMCB1c2VkIGZv
ciBXQUtFIy4NCg0Kb2sNCg0KQmVuamFtaW4NCg0KPg0KPj4gKwkJPjsNCj4+ICsJfTsNCj4+ICsN
Cj4+ICsJcGluY3RybF9wY2llMF9yZWc6IHBjaWUwcmVnZ3JwIHsNCj4+ICsJCWZzbCxwaW5zID0g
PA0KPj4gKwkJCU1YOE1QX0lPTVVYQ19HUElPMV9JTzE0X19HUElPMV9JTzE0CTB4NDANCj4gVGhp
cyBncGlvIG11eGluZyBzaG91bGQgYmUgaW4gdGhlIHBjaWUwZ3JwLg0KPg0KPiBZYW5uaWMNCj4N
Cj4+ICsJCT47DQo+PiArCX07DQo+PiArDQo+PiAgwqAJcGluY3RybF9wd20zOiBwd20zZ3JwIHsN
Cj4+ICDCoAkJZnNsLHBpbnMgPSA8DQo+PiAgwqAJCQlNWDhNUF9JT01VWENfU1BESUZfVFhfX1BX
TTNfT1VUCQkweDEyDQo+Pg0KPj4gLS0tDQo+PiBiYXNlLWNvbW1pdDogN2M2MjZjZTRiYWUxYWMx
NGY2MDA3NmQwMGVhZmU3MWFmMzA0NTBiYQ0KPj4gY2hhbmdlLWlkOiAyMDI0MDgxMy13aXAtYmhh
aG4tYWRkX3BjaWVfc3VwcG9ydC1iOWJkNzVmYzRkOTgNCj4+DQo+PiBCZXN0IHJlZ2FyZHMsDQoN
Cg0K

