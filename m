Return-Path: <linux-kernel+bounces-240605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9968926F9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B3F281064
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE541A0716;
	Thu,  4 Jul 2024 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="CKqEgQp1"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7828619AD5E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720074708; cv=none; b=M43/juHFZ9oEaSnxst2x89LPv2oBJ9b5GZE3Ev5PSl/HHuI/fXq3/aRzNIDjfd+54XTgtC2fAi7VbQr5DsvDZjC16ynjuUs71KKgwvRTU1l/QLRl6qRXEOlit3Tx/MF8uWlchSEPipUtPhKA4kpPVa5aXmx6eY7BjjVviNXQQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720074708; c=relaxed/simple;
	bh=XyU3UQb+qYMhIsu+oeb2ED/YCR5CaNDmLkHr6G9Rg8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vEy7A9QozKd+znmE05EUtnTjwJ1Y9jwkUMmBUvJc02hU3k+NhLtxeUOvHBU4KHzVQ4hj6cvtoowWXx9vAUlGDiJryoISHllwdk+L/J+9zgFP/bLBcBVFLkaDMNvWRIkq3mWfkOMbfxVCRQEGCQLHSxv+6knTO2IQkTlzTyeTntE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=CKqEgQp1; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1720074700; x=1722666700;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XyU3UQb+qYMhIsu+oeb2ED/YCR5CaNDmLkHr6G9Rg8s=;
	b=CKqEgQp1GVXuAGByT1jmPiFcQlnboQ8pBkVBzmCn8evnzViy2wa2O1I9TzEK+D2X
	fYBDRwaYm6aagg2s3pNVjm+AxexxmWWwiNbL8T3c7jATpB4QbEUyHvOl8wdPeTFl
	a3tcE6fMM/Ps8rVBIZ6o4rT2s43xsVdPOGIDAI1SpTM=;
X-AuditID: ac14000a-03251700000021bc-fd-668641cb3deb
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C3.A4.08636.BC146866; Thu,  4 Jul 2024 08:31:39 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 4 Jul 2024
 08:31:39 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Thu, 4 Jul 2024 08:31:39 +0200
From: Teresa Remmet <T.Remmet@phytec.de>
To: Benjamin Hahn <B.Hahn@phytec.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, PHYTEC Upstream
	<upstream@lists.phytec.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [Upstream] [PATCH] arm64: dts: freescale: imx8mp-phycore: Add
 no-eth overlay
Thread-Topic: [Upstream] [PATCH] arm64: dts: freescale: imx8mp-phycore: Add
 no-eth overlay
Thread-Index: AQHazdvTjMe44LTOjEaw+Xp+IpJB8Q==
Date: Thu, 4 Jul 2024 06:31:39 +0000
Message-ID: <54fe986d45065f8671208ece87aa51c39fc0c0f9.camel@phytec.de>
References: <20240703-bspimx8m-3180-v1-1-e43e035a9b2a@phytec.de>
In-Reply-To: <20240703-bspimx8m-3180-v1-1-e43e035a9b2a@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <7851297D51029948BA1AEB7D3322B10E@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWyRpKBR/eMY1uaQe8VXos1e88xWcw/co7V
	4uFVf4uZ91rZLFZN3cli0ffiIbPFpsfXWC0u75rDZtG69wi7xd/tm1gsXmwRt+h+p+7A47Fz
	1l12j02rOtk87lzbw+axeUm9x4vNMxk9+rtbWD36/xp4fN4kF8ARxWWTkpqTWZZapG+XwJVx
	/cUX5oIrUhXdO/pYGxj/SHYxcnJICJhI3PmwnamLkYtDSGAJk8SsdeeYIZx7jBLP+k6zQTjr
	GSWaX99nBmlhE9CQeHmiG6xFRKCbWeLK8cWsIA6zwBomidsX17CCVAkLREscuHiaHcQWEYiR
	eLV+LSOErSfx9sAGsDiLgIpE58kHYHFeATeJjuk9YLaQgIPEiRtbwLZxCjhKdH/YB1bPKCAr
	sWHDebA4s4C4xKZn31khnhCQWLIHIi4hICrx8vE/qLi8xIlb04Au5QCq15RYv0sfotVCYuvi
	K4wQtqLElO6H7BAnCEqcnPmEZQKj+CwkG2YhdM9C0j0LSfcsJN0LGFlXMQrlZiZnpxZlZusV
	ZFSWpCbrpaRuYgQlABEGrh2MfXM8DjEycTAeYpTgYFYS4ZV635wmxJuSWFmVWpQfX1Sak1p8
	iFGag0VJnHd1R3CqkEB6YklqdmpqQWoRTJaJg1OqgTErZfmdqhLmK6/N1nFl3uzZt3BG7SW2
	7TyqXkdeTeL0aGOZlxjsd3zhOq7P4gnrF2ndktbx2HSg9+wfqT/rCjJWKJ9gXhAjn3K0xvRz
	tciTQC2GNY3OrZ1ddzsPlk6TESxwd5Zc1rTg7xW2ztMPmP6K6dzXuXcubqZo5MV3/Dn2er3u
	AtpzxZVYijMSDbWYi4oTARNNwJjuAgAA

SGVsbG8gQmVuamFtaW4sDQoNCkFtIE1pdHR3b2NoLCBkZW0gMDMuMDcuMjAyNCB1bSAxNDozNSAr
MDIwMCBzY2hyaWViIEJlbmphbWluIEhhaG46DQo+IEFkZCBhIGRldmljZXRyZWUgb3ZlcmxheSB0
byBkaXNhYmxlIGV0aGVybmV0IGZvciBib2FyZHMgd2hlcmUgaXQgaXMNCj4gbm90DQo+IHBvcHVs
YXRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEhhaG4gPEIuSGFobkBwaHl0ZWMu
ZGU+DQo+IC0tLQ0KPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArKw0KPiDCoC4uLi9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1wLXBoeWNvcmUtbm8tZXRoLmR0c2/CoMKgwqAgfCAyMA0KPiArKysrKysrKysr
KysrKysrKysrKw0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlDQo+IGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvTWFrZWZpbGUNCj4gaW5kZXggMmNiMDIxMmI2
M2M2Li4xNmUwNmU2ZjA1NWMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL01ha2VmaWxlDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01h
a2VmaWxlDQo+IEBAIC0xNjQsNiArMTY0LDggQEAgZHRiLSQoQ09ORklHX0FSQ0hfTVhDKSArPSBp
bXg4bXAtZXZrLmR0Yg0KPiDCoGR0Yi0kKENPTkZJR19BUkNIX01YQykgKz0gaW14OG1wLWljb3Jl
LW14OG1wLWVkaW1tMi4yLmR0Yg0KPiDCoGR0Yi0kKENPTkZJR19BUkNIX01YQykgKz0gaW14OG1w
LW1zYy1zbTJzLWVwMS5kdGINCj4gwqBkdGItJChDT05GSUdfQVJDSF9NWEMpICs9IGlteDhtcC1w
aHlib2FyZC1wb2xsdXgtcmRrLmR0Yg0KPiAraW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGstbm8t
ZXRoLWR0YnMgKz0gaW14OG1wLXBoeWJvYXJkLXBvbGx1eC0NCj4gcmRrLmR0YiBpbXg4bXAtcGh5
Y29yZS1uby1ldGguZHRibw0KPiArZHRiLSQoQ09ORklHX0FSQ0hfTVhDKSArPSBpbXg4bXAtcGh5
Ym9hcmQtcG9sbHV4LXJkay1uby1ldGguZHRiDQo+IMKgZHRiLSQoQ09ORklHX0FSQ0hfTVhDKSAr
PSBpbXg4bXAtc2tvdi1yZXZiLWhkbWkuZHRiDQo+IMKgZHRiLSQoQ09ORklHX0FSQ0hfTVhDKSAr
PSBpbXg4bXAtc2tvdi1yZXZiLWx0Ni5kdGINCj4gwqBkdGItJChDT05GSUdfQVJDSF9NWEMpICs9
IGlteDhtcC1za292LXJldmItbWkxMDEwYWl0LTFjcDEuZHRiDQo+IGRpZmYgLS1naXQgYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Y29yZS1uby1ldGguZHRzbw0KPiBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHljb3JlLW5vLWV0aC5kdHNv
DQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uMmE5ZmUxZDZk
YjlkDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1wLXBoeWNvcmUtbm8tZXRoLmR0c28NCj4gQEAgLTAsMCArMSwyMCBAQA0KPiArLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gKy8qDQo+ICsgKiBDb3B5cmlnaHQg
KEMpIDIwMjQgUEhZVEVDIE1lc3N0ZWNobmlrIEdtYkgNCj4gKyAqIEF1dGhvcjogQ2VtIFRlbnJ1
aCA8Yy50ZW5ydWhAcGh5dGVjLmRlPg0KPiArICovDQo+ICsNCj4gKy9kdHMtdjEvOw0KPiArL3Bs
dWdpbi87DQo+ICsNCj4gKyZ7L30gew0KPiArwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gInBo
eXRlYyxpbXg4bXAtcGh5Y29yZS1zb20iOw0KPiArfTsNCg0KYXMgdW5kZXJzdG9vZCBmcm9tIHJl
Y2VudCBwYXRjaGVzIG9mIEZhYmlvIHRoZSBjb21wYXRpYmxlIHNob3VsZCBiZQ0KcmVtb3ZlZC4N
Cg0KVGhhbmtzLA0KVGVyZXNhDQoNCj4gKw0KPiArJmV0aHBoeTEgew0KPiArwqDCoMKgwqDCoMKg
wqBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArfTsNCj4gKw0KPiArJmZlYyB7DQo+ICvCoMKgwqDC
oMKgwqDCoHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICt9Ow0KPiANCj4gLS0tDQo+IGJhc2UtY29t
bWl0OiBlOGY4OTdmNGFmZWYwMDMxZmU2MThhOGU5NDEyN2EwOTM0ODk2YWJhDQo+IGNoYW5nZS1p
ZDogMjAyNDA2MTctYnNwaW14OG0tMzE4MC00N2JlZDE4NGE4NTQNCj4gDQo+IEJlc3QgcmVnYXJk
cywNCg0KLS0gDQpQSFlURUMgTWVzc3RlY2huaWsgR21iSCB8IEJhcmNlbG9uYS1BbGxlZSAxIHwg
NTUxMjkgTWFpbnosIEdlcm1hbnkNCg0KR2VzY2jDpGZ0c2bDvGhyZXI6IERpcGwuLUluZy4gTWlj
aGFlbCBNaXRlemtpLCBEaXBsLi1JbmcuIEJvZG8gSHViZXIsDQpEaXBsLi1JbmcuIChGSCkgTWFy
a3VzIExpY2tlcyB8IEhhbmRlbHNyZWdpc3RlciBNYWlueiBIUkIgNDY1NiB8DQpGaW5hbnphbXQg
TWFpbnogfCBTdC5Oci4gMjY2NTAwNjA4LCBERSAxNDkwNTk4NTUNCg==

