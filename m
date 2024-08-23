Return-Path: <linux-kernel+bounces-298789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A60C995CB85
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CECF286AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C43188001;
	Fri, 23 Aug 2024 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="thRBMQ4P"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC41187FEE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412991; cv=none; b=L+3fPcZztSy3jOshNpwP/wr1dZaGjUJUdWkQvYDUfutRYZfHclyHInLiozEn5j48Jewg/G0/K1e2DBoImp3SGCBVxMS8Q5DZaXY9fKE+O74eyfaG5/WAAUjc01RyNKZlbkJ0o+beJqdOfnYVEXQ2tRNXpcpdtvUPc2NRivErLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412991; c=relaxed/simple;
	bh=Ntv6MZ9lCiHnA25uIJN5WCBiRmqOIGg+IIBDR5T364Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P0k4pnKf9QYGLKtoPdN0+/n4D6tBNU8Z28fzm6NC44X67UlwokDKe+y+qfESlI5jIXpVIQbeZzOf0aaU9ElbghO2IcpPG6dh7Vobw1tfmy71Mqc4n9UOgfVD9+xiCXXdWU1mYTgFsAKJfdXL5CQSkfzOWTQoDdyc/Ll6x6jDiKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=thRBMQ4P; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724412983; x=1727004983;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ntv6MZ9lCiHnA25uIJN5WCBiRmqOIGg+IIBDR5T364Y=;
	b=thRBMQ4PyIHkz9hqpclNgmgiSu/a9m6KHpyQ7lYOcaM2ktXd15rWFwOBweK57Ta8
	Oc4t9rIpYBKahmbfCHcqIhKF3arwJOb8Bzg7f+RqLuvsdyNSd0E/TfohxoK6P6wp
	5ojGk7cOkbBlkzcRm659qF1XXRgN7DmrpcjPVfluqjc=;
X-AuditID: ac14000a-03e52700000021bc-96-66c87437ecf3
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 31.91.08636.73478C66; Fri, 23 Aug 2024 13:36:23 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 23 Aug
 2024 13:36:23 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Fri, 23 Aug 2024 13:36:23 +0200
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
Subject: Re: [Upstream] [PATCH v3] arm64: dts: imx8mp-phyboard-pollux-rdk: Add
 support for PCIe
Thread-Topic: [Upstream] [PATCH v3] arm64: dts: imx8mp-phyboard-pollux-rdk:
 Add support for PCIe
Thread-Index: AQHa9TKynCp8C599ik6LNabc/uY/i7I0lW+A
Date: Fri, 23 Aug 2024 11:36:23 +0000
Message-ID: <233e5f32932cd420e6ca8d90e23c25f5740f89ee.camel@phytec.de>
References: <20240823-wip-bhahn-add_pcie_support-v3-1-8b86af45e73f@phytec.de>
In-Reply-To: <20240823-wip-bhahn-add_pcie_support-v3-1-8b86af45e73f@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <10EC0176492E3F43B709DC2060609F7C@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWyRpKBR9e85ESawZ6pxhZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPF4uWse2wWmx5fY7W4vGsOm8X/PTvYLf5u38Ri8WKLuEX3O3UHHo+d
	s+6ye2xa1cnmsXlJvceLzTMZPfq7W1g9+v8aeHzeJBfAHsVlk5Kak1mWWqRvl8CV0ft6B2PB
	E6mKvssfWBsYe6S6GDk5JARMJBZ1tTKB2EICS5gk2hptuhi5gOz7jBLrrz5jgXA2MEr8/TmH
	GaSKTUBF4uSMS4wgtohAN7PEvSY3kCJmgTVMErcvrmEFSQgLJEosu/6CBaIoSaJpWTdUg5HE
	ikv72UFsFgFViYlnH7GB2LwCbhLvb1xghDjDV+Le0VlgNqeAn8SbzVPBbEYBWYkNG86DHcEs
	IC6x6dl3VogXBCSW7IGISwiISrx8/A8qLi9x4tY0oNc4gOo1Jdbv0ocwLSR6FopDTFGUmNL9
	kB3iAkGJkzOfsExgFJ+FZMEshOZZCM2zkDTPQtK8gJF1FaNQbmZydmpRZrZeQUZlSWqyXkrq
	JkZQvIswcO1g7JvjcYiRiYPxEKMEB7OSCG/SvaNpQrwpiZVVqUX58UWlOanFhxilOViUxHlX
	dwSnCgmkJ5akZqemFqQWwWSZODilGhg7bj1c65+TM2edzuP00Gn9K9pUd7rPyEq0XPEutHRh
	9Znqd0LPbJ4Y9K1yTjnO4HrTb/eFs5uZ/3Noxns1SPC/UNFcViQ887XZmqSrnhf2WgR1qfue
	vr+waPbk24Hpu76pcAnbl3IzHg7tEWmctkvdK6Nkg7eNqe77mfPWhWzYXl/U5JV92lmJpTgj
	0VCLuag4EQAoeePK5QIAAA==

T24gRnJpLCAyMDI0LTA4LTIzIGF0IDEwOjAxICswMjAwLCBCZW5qYW1pbiBIYWhuIHdyb3RlOg0K
PiBBZGQgc3VwcG9ydCBmb3IgdGhlIE1pbmkgUENJZSBzbG90Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQmVuamFtaW4gSGFobiA8Qi5IYWhuQHBoeXRlYy5kZT4NClJldmlld2VkLWJ5OiBZYW5uaWMg
TW9vZyA8eS5tb29nQHBoeXRlYy5kZT4NCg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBj
aGFuZ2Ugb3JkZXIgb2YgcHJvcGVydGllcyBmb3IgcGNpZSBwaHkgbm9kZQ0KPiAtIExpbmsgdG8g
djI6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDA4MjEtd2lwLWJoYWhuLWFkZF9w
Y2llX3N1cHBvcnQtdjItMS05YzkyZDg0ODhhYjJAcGh5dGVjLmRlDQo+IA0KPiBDaGFuZ2VzIGlu
IHYyOg0KPiAtIGNoYW5nZSBwY2llIHJlZ3VsYXRvciB0byByZWdfdmNjXzN2M19zdw0KPiAtIGFk
ZCB3YWtlIGdwaW8gdG8gcGNpZSBwaW5jdHJsIGFuZCBvcmRlciB0aGUgZ3Bpb3MNCj4gLSBMaW5r
IHRvIHYxOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwODEzLXdpcC1iaGFobi1h
ZGRfcGNpZV9zdXBwb3J0LXYxLTEtYzFiYjA2MmI0ZTFmQHBoeXRlYy5kZQ0KPiAtLS0NCj4gwqAu
Li4vZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHPCoMKgIHwgMjcg
KysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGsuZHRzDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGsuZHRzDQo+IGluZGV4IDAwYTI0MDQ4NGMy
NS4uYmVhNDc5YjUyMDNhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMNCj4gKysrIGIvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGsuZHRzDQo+IEBAIC02
LDYgKzYsNyBAQA0KPiDCoA0KPiDCoC9kdHMtdjEvOw0KPiDCoA0KPiArI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL3BoeS9waHktaW14OC1wY2llLmg+DQo+IMKgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2xl
ZHMvbGVkcy1wY2E5NTMyLmg+DQo+IMKgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3B3bS9wd20uaD4N
Cj4gwqAjaW5jbHVkZSAiaW14OG1wLXBoeWNvcmUtc29tLmR0c2kiDQo+IEBAIC0xOTUsNiArMTk2
LDIzIEBAICZzbnZzX3B3cmtleSB7DQo+IMKgCXN0YXR1cyA9ICJva2F5IjsNCj4gwqB9Ow0KPiDC
oA0KPiArJnBjaWVfcGh5IHsNCj4gKwljbG9ja3MgPSA8JmhzaW9fYmxrX2N0cmw+Ow0KPiArCWNs
b2NrLW5hbWVzID0gInJlZiI7DQo+ICsJZnNsLHJlZmNsay1wYWQtbW9kZSA9IDxJTVg4X1BDSUVf
UkVGQ0xLX1BBRF9PVVRQVVQ+Ow0KPiArCWZzbCxjbGtyZXEtdW5zdXBwb3J0ZWQ7DQo+ICsJc3Rh
dHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArLyogTWluaSBQQ0llICovDQo+ICsmcGNpZSB7
DQo+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gKwlwaW5jdHJsLTAgPSA8JnBpbmN0
cmxfcGNpZTA+Ow0KPiArCXJlc2V0LWdwaW8gPSA8JmdwaW8xIDggR1BJT19BQ1RJVkVfTE9XPjsN
Cj4gKwl2cGNpZS1zdXBwbHkgPSA8JnJlZ192Y2NfM3YzX3N3PjsNCj4gKwlzdGF0dXMgPSAib2th
eSI7DQo+ICt9Ow0KPiArDQo+IMKgJnB3bTMgew0KPiDCoAlzdGF0dXMgPSAib2theSI7DQo+IMKg
CXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+IEBAIC0zNjYsNiArMzg0LDE1IEBAIE1YOE1Q
X0lPTVVYQ19TRDJfV1BfX0dQSU8yX0lPMjAJCTB4MTINCj4gwqAJCT47DQo+IMKgCX07DQo+IMKg
DQo+ICsJcGluY3RybF9wY2llMDogcGNpZTBncnAgew0KPiArCQlmc2wscGlucyA9IDwNCj4gKwkJ
CU1YOE1QX0lPTVVYQ19HUElPMV9JTzA4X19HUElPMV9JTzA4wqDCoMKgwqAgMHg0MA0KPiArCQkJ
TVg4TVBfSU9NVVhDX0dQSU8xX0lPMTBfX0dQSU8xX0lPMTDCoMKgwqDCoCAweDYwDQo+ICsJCQlN
WDhNUF9JT01VWENfR1BJTzFfSU8xMV9fR1BJTzFfSU8xMQkweDYwIC8qIG9wZW4gZHJhaW4sIHB1
bGwgdXAgKi8NCj4gKwkJCU1YOE1QX0lPTVVYQ19HUElPMV9JTzE0X19HUElPMV9JTzE0wqDCoMKg
wqAgMHg0MA0KPiArCQk+Ow0KPiArCX07DQo+ICsNCj4gwqAJcGluY3RybF9wd20zOiBwd20zZ3Jw
IHsNCj4gwqAJCWZzbCxwaW5zID0gPA0KPiDCoAkJCU1YOE1QX0lPTVVYQ19TUERJRl9UWF9fUFdN
M19PVVQJCTB4MTINCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogN2M2MjZjZTRiYWUxYWMxNGY2
MDA3NmQwMGVhZmU3MWFmMzA0NTBiYQ0KPiBjaGFuZ2UtaWQ6IDIwMjQwODEzLXdpcC1iaGFobi1h
ZGRfcGNpZV9zdXBwb3J0LWI5YmQ3NWZjNGQ5OA0KPiANCj4gQmVzdCByZWdhcmRzLA0KDQo=

