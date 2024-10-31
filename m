Return-Path: <linux-kernel+bounces-390346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AB89B78A8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD141F2216C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C2C199238;
	Thu, 31 Oct 2024 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="QrlPHrTC"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F11940BC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370527; cv=none; b=acLdCJyfEy94KvOPDOKzOURBveRcoSqV/GjbgrYH0Obqf2/ejkzITMdRr8Necy22BSggPQav1qEDXv0TmYY8/t6GEEMkQAfoAa0f5p4zF3mmW1H8DBibhfKKHPRq9c3cEGlKWQ5Dqd3SrlY8F/TPMDVVvfvGtzRpCipMhSyHUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370527; c=relaxed/simple;
	bh=y6n6pz2W5MZO2A4sd5f4ojfHs94IDEJRlAgppBlPPxI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ygzv6s4eEaPR3LaM3r33hFQaNdQGYvB0yYUmFLCao00tBPZWMq6xS482AvAIzJ58RXUo3nrngH3p/RAwMdprHN3n7Fy2fpeTjJrTQewehsS+Gal9X9DRgXKv+cBClie5xRm9F5ca6v0EpulL9Ib6ekNFn8BK5X7oExf8brxecO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=QrlPHrTC; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730370518; x=1730975318; i=efault@gmx.de;
	bh=y6n6pz2W5MZO2A4sd5f4ojfHs94IDEJRlAgppBlPPxI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QrlPHrTCz/Pn18n0kOa96e01L5G5hoWmbAOOGAy+gHTicXuDUhVfjwdKK+S4nWt5
	 DS5WaYMWrOd35OZdZIOwmA3wbEJcS8gNqzbCNqJeBQovSVycDwaT/mJNBSySR9Dec
	 VMe4DMjSSTd7M65z7JWHswuSNTHG9QJlV57aa1ky11GlJGHAG/DNqZKaTOV5U8LMr
	 GMytv5P7whL5Iz3CZDJH4CwJD/vAOoeHVHu+83n4q1WQQS56rvRh6fbWrxhpT9YS1
	 +7Tbxw8zuAP1fB3iEGHb0FlAcBiAtu13PYHfNb0WYouG4lXN2bHrfBR1elIHDvMUs
	 R33ZiUYDhxPqFT56xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.187]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7i8O-1tsO4i14rK-011k8s; Thu, 31
 Oct 2024 11:28:38 +0100
Message-ID: <5f534654a8aaa91428c2f9e188d7db7de080b9bc.camel@gmx.de>
Subject: Re: RFC [PATCH2] fs/writeback: Mitigate move_expired_inodes()
 induced service latency
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-mm <linux-mm@kvack.org>
Date: Thu, 31 Oct 2024 11:28:37 +0100
In-Reply-To: <ad30ef4edfc22e7f29280fdec763189efddda9d0.camel@gmx.de>
References: <88ae633aa910c7e320b89e5f4779d472f7cffffb.camel@gmx.de>
	 <ad30ef4edfc22e7f29280fdec763189efddda9d0.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:EiGrpm0h35FCnJI6hZgyJ1vEjs0/eM9iGLmicDl5eW8XX36yUVm
 KorBBea1UB/UzazYQv5eCCIWnhnfHTCT60HCIDhIdH7oSMBkmZhcpIDrzxIrQZqCyHhmi3a
 DxO1ILWeEgY4NuvK15MOqVwFqoJt8QNDR8G/uuUVPjx0xOH3/ll0zQIIB1cH4EEGZJN6nKD
 6YGpFp+XUqmV9Ilb4Ql/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/FFcCasr6ww=;onnOC41N+/hBpn0C97EukZFABsK
 A1/ks0emxKsGkGpvErd1LiU1mE/dDfSU0qmX8b/1aP+39WzjBauRXpEqRYT3jEBAjerDUdIsm
 WYsdAEuKoNCa6r3ZjIHMFktD2mgsrFKt5wpABCg4yklVyqt6KqjKxXUxMPl6eIdQQVCTGaxJA
 ZH0K9lux9SpDMQTaDdVLLvJ2j4b32EIfFGS+dIMVOYjdPGSkR7st/v2bCVPw+rO4GqheDXkjE
 mPBhjSwJWuNU0VYIsVnOUpfTzdmHKqCHMAU9UgD5D9wHpk4tk+4SE3qMn7ICYqRzP7A58P1nV
 jm7cXBYLOYoR8C28XDaB6eLdg1iz7ADnsgk8OdfxQ28SkQDHM7YBcMFkmRgrXPGb3ThIAaGho
 fQab4pLTDqtKq22zHwJnm/xp2cPD7aLSmXmCpaEO58wHUNqUpJWCztdlalE/OSglJycyO5Xk3
 tQbhjqGIVXOSJ51REzS170cjt8uO4eFi/f2OfcMXEoT0e7tzy+SfZEChnlWXet3xCw5TnyILG
 RlgZu//KDKYzIKUdXLq2oPtHm5ZU04MdUi0W/Qbyu+Cro56/cZCUEfR0JMF+GJxroEp5yC8b5
 ipSLOFFXHvoSApSRXgDXQ0RtL0RTCSF03njPWCB5hAWhyLuY14iGJWvX7qn0BXrsbDk8VgMri
 gFLKdt4ACoGBKAfsTqk0NVpNquKqL1Ga0OIGbddhYSKuAr3iQLKZAMA6tt0thGXQv6lrfIqxe
 RE03qsrAAWO+KatlUIhtQO/394N3DLgtXmdHhZloLh3y031dnjMWWLSRJet2CHnUoWi0a+6xN
 ur8HuJ3CLZWK9N40yemKWB0w==

KGdyci4uIENDIHdhcyBzdXBwb3NlZCB0byBiZSBrdmFjaykNCg0KT24gVGh1LCAyMDI0LTEwLTMx
IGF0IDExOjIxICswMTAwLCBNaWtlIEdhbGJyYWl0aCB3cm90ZToNCj4gKHdhcyByZWdyZXNzaW9u
OiBtbTogdm1zY2FuOsKgIC3CoCBzaXplIFhMIGlycW9mZiB0aW1lIGluY3JlYXNlIHY2LjEwKykN
Cj4gDQo+IA0KPiBCcmVhayBvZmYgcXVldWVpbmcgb2YgSU8gYWZ0ZXIgd2UndmUgYmVlbiBhdCBp
dCBmb3IgYSBtcyBvciBzbyBhbmQgYQ0KPiBwcmVlbXB0aW9uIGlzIGR1ZSwgdG8ga2VlcCB3cml0
ZWJhY2sgbGF0ZW5jeSBpbXBhY3QgYXQgbGVhc3QgcmVhc29uYWJsZS4NCj4gVGhlIElPIHdlJ3Jl
IHF1ZXVlaW5nIHVuZGVyIHNwaW5sb2NrIHN0aWxsIGhhcyB0byBiZSBzdGFydGVkIHVuZGVyIHRo
YXQNCj4gc2FtZSBsb2NrLiANCj4gDQo+IHdha2V1cF9ydCB0cmFjaW5nIGNhdWdodCB0aGlzIGZ1
bmN0aW9uIHNwYW5uaW5nIDY2bXMgaW4gYSBpNy00NzkwIGJveC4NCj4gDQo+IFdpdGggdGhpcyBw
YXRjaCBhcHBsaWVkIG9uIHRvcCBvZiBvbmUgdG8gbWl0aWdhdGUgZXZlbiB3b3JzZSBJUlEgaG9s
ZG9mZg0KPiBpbmR1Y2VkIGhpdHMgKDc4bXMpIGJ5IGlzb2xhdGVfbHJ1X2ZvbGlvcygpLCB0aGUg
c2FtZSB0cml2aWFsIGxvYWQgdGhhdA0KPiBsZWFkcyB0byB0aGlzIGFuZCB3b3JzZSAob3NjIGtl
cm5lbCBwYWNrYWdlIGJ1aWxkICsgYm9ubmllKToNCj4gVDogMSAoIDYyMTEpIFA6OTkgSToxNTAw
IEM6IDYzOTk3MSBNaW46wqDCoMKgwqDCoCAxIEFjdDrCoMKgwqAgNyBBdmc6wqDCoCAxMiBNYXg6
wqDCoCA2NjY5Ng0KPiANCj4gcmVzdWx0ZWQgaW4gdGhpcyBwZXJmZWN0bHkgcmVhc29uYWJsZSBt
YXg6DQo+IFQ6IDAgKCA2MDc4KSBQOjk5IEk6MTAwMCBDOjEwMzEyMzAgTWluOsKgwqDCoMKgwqAg
MSBBY3Q6wqDCoMKgIDcgQXZnOsKgwqDCoCA0IE1heDrCoMKgwqAgNDQ0OQ0KPiANCj4gTm90ZTog
Y3ljbGljdGVzdCAtU21wOTkgaXMgb25seSB0aGUgbWVzc2VuZ2VyLsKgIFRoaXMgaXMgbm90IGFu
IFJUIGlzc3VlLA0KPiBSVCBpcyBmaW5nZXJpbmcgYmFkIGdlbmVyaWMgYmVoYXZpb3IuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBNaWtlIEdhbGJyYWl0aCA8ZWZhdWx0QGdteC5kZT4NCj4gLS0tDQo+
IMKgZnMvZnMtd3JpdGViYWNrLmMgfMKgwqAgMTggKysrKysrKysrKysrKysrKysrDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4gDQo+IC0tLSBhL2ZzL2ZzLXdyaXRlYmFj
ay5jDQo+ICsrKyBiL2ZzL2ZzLXdyaXRlYmFjay5jDQo+IEBAIC0yOSw2ICsyOSw3IEBADQo+IMKg
I2luY2x1ZGUgPGxpbnV4L3RyYWNlcG9pbnQuaD4NCj4gwqAjaW5jbHVkZSA8bGludXgvZGV2aWNl
Lmg+DQo+IMKgI2luY2x1ZGUgPGxpbnV4L21lbWNvbnRyb2wuaD4NCj4gKyNpbmNsdWRlIDxsaW51
eC9zY2hlZC9jbG9jay5oPg0KPiDCoCNpbmNsdWRlICJpbnRlcm5hbC5oIg0KPiDCoA0KPiDCoC8q
DQo+IEBAIC0xNDI0LDYgKzE0MjUsMTAgQEAgc3RhdGljIGludCBtb3ZlX2V4cGlyZWRfaW5vZGVz
KHN0cnVjdCBsaQ0KPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGlub2RlICppbm9kZTsNCj4gwqDC
oMKgwqDCoMKgwqDCoGludCBkb19zYl9zb3J0ID0gMDsNCj4gwqDCoMKgwqDCoMKgwqDCoGludCBt
b3ZlZCA9IDA7DQo+ICsjaWZuZGVmIENPTkZJR19QUkVFTVBUX1JUDQo+ICvCoMKgwqDCoMKgwqDC
oHU2NCB0aGVuID0gbG9jYWxfY2xvY2soKTsNCj4gK8KgwqDCoMKgwqDCoMKgaW50IGl0ZXIgPSAw
Ow0KPiArI2VuZGlmDQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqB3aGlsZSAoIWxpc3RfZW1wdHko
ZGVsYXlpbmdfcXVldWUpKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW5v
ZGUgPSB3Yl9pbm9kZShkZWxheWluZ19xdWV1ZS0+cHJldik7DQo+IEBAIC0xNDM5LDYgKzE0NDQs
MTkgQEAgc3RhdGljIGludCBtb3ZlX2V4cGlyZWRfaW5vZGVzKHN0cnVjdCBsaQ0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChzYiAmJiBzYiAhPSBpbm9kZS0+aV9zYikNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZG9fc2Jfc29y
dCA9IDE7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2IgPSBpbm9kZS0+aV9z
YjsNCj4gKyNpZm5kZWYgQ09ORklHX1BSRUVNUFRfUlQNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoC8qDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBXZSdyZSB1
bmRlciAtPmxpc3RfbG9jayBoZXJlLCBhbmQgdGhlIElPIGJlaW5nIHF1ZXVlZA0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogc3RpbGwgaGFzIHRvIGJlIHN0YXJ0ZWQuIFN0b3Ag
cXVldWVpbmcgd2hlbiB3ZSd2ZSBiZWVuDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKiBhdCBpdCBmb3IgYSBtcyBvciBzbyBhbmQgYSBwcmVlbXB0aW9uIGlzIGR1ZSwgdG8ga2Vl
cA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogbGF0ZW5jeSBpbXBhY3QgcmVh
c29uYWJsZS4NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLw0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGl0ZXIrKyA8IDEwMCB8fCAhbmVlZF9yZXNjaGVk
KCkpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29u
dGludWU7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobG9jYWxfY2xvY2so
KSAtIHRoZW4gPiBOU0VDX1BFUl9NU0VDKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaXRlciA9IDA7DQo+ICsjZW5kaWYNCj4gwqDCoMKgwqDCoMKgwqDCoH0NCj4gwqANCj4gwqDC
oMKgwqDCoMKgwqDCoC8qIGp1c3Qgb25lIHNiIGluIGxpc3QsIHNwbGljZSB0byBkaXNwYXRjaF9x
dWV1ZSBhbmQgd2UncmUgZG9uZSAqLw0KPiANCg0K

