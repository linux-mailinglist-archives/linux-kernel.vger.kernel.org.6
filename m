Return-Path: <linux-kernel+bounces-280467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75DC94CAFE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130F61C220E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9D716DEA3;
	Fri,  9 Aug 2024 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="nsT8DcmD"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E746F16DC24
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723187488; cv=none; b=Oi8DErRFE7stRjkUzbpgfVjWYJ3L3AOxbIJri4MJrLrRXYYOid4KIYpSjXIqhlYWsDO9uhnpn8ftelW0GNF9K86Re1pNfiLM9jCP+M5qpsljsjPqP2qBFHe0CEz+vVjH7/FGUOf0o92ngUNjFjMTlVQ1jA4FlWZfZjhenK+s/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723187488; c=relaxed/simple;
	bh=VGAmOVhNIm7Rohbg0grVABzIlXOEwGX3JjpYmTbRoIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UDr2G4S16CcPcl2hWsdG00SOqqUCG8T5WyweAoHSLp27xCWgabjzqlt0RX0OTnprXd9ngWLhI9qgSwKPwzE9xQlg6jae3+Vv0njwBBQeeSIi/rMQihgrNLE/mrEGzzRDJIVKWGuH8szMgtG0gYkujw43/KPNTYXGpPbH2kDpfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=nsT8DcmD; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723187475; x=1725779475;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VGAmOVhNIm7Rohbg0grVABzIlXOEwGX3JjpYmTbRoIE=;
	b=nsT8DcmDI0GtjH4tTXd2Rprm7iYJkT1HZkxX5FFHfUWx4uV+BuY+7//pi3FGRHQG
	T6deTf8v1dPbLh4bgN+zsI5y3ZNf8fizHO9fP80n+GRhZBtyBLC7Wd2sQN8AmKc/
	hjuAZBlEpdbePsHeJUGfFogZbMH4sOkScN3Al3m5gkw=;
X-AuditID: ac14000a-03251700000021bc-76-66b5c1121319
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A8.FF.08636.211C5B66; Fri,  9 Aug 2024 09:11:14 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 9 Aug 2024
 09:11:14 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Fri, 9 Aug 2024 09:11:14 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Teresa Remmet <T.Remmet@phytec.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: freescale: imx8mp-phyboard-pollux: Add and
 enable TPM
Thread-Topic: [PATCH v2] arm64: dts: freescale: imx8mp-phyboard-pollux: Add
 and enable TPM
Thread-Index: AQHa6N0c3R04lazcqEKAWTzargDV2LIdB8GAgAFboQA=
Date: Fri, 9 Aug 2024 07:11:14 +0000
Message-ID: <6e511f04-7f93-49ad-8cf7-336a6bac7d31@phytec.de>
References: <20240807-imx8mp-tpm-v2-1-d43f1e8f70ac@phytec.de>
 <311d8a95-33bf-4549-812a-db52debc7487@kernel.org>
In-Reply-To: <311d8a95-33bf-4549-812a-db52debc7487@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <72EEE5C6F59DFB44B1FC64FC2935A345@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWyRpKBV1fo4NY0g3Nt5hZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPF4uWse2wW589vYLfY9Pgaq8XlXXPYLP7v2cFu8Xf7JhaLF1vEHXg8
	ds66y+6xaVUnm8fmJfUeLzbPZPTo/2vg8XmTXABbFJdNSmpOZllqkb5dAlfG172HGAuu8Fec
	uK3QwLiAv4uRk0NCwETiwsoWpi5GLg4hgSVMErtnzYFy7jFKnHi+ng3CWc8oce1bBytIC5uA
	msSuN69ZQRIiAveZJM5vW8wGkmAWaGCS6Lkn1MXIwSEsEC0x/ZM5SFhEIEZizueT7BC2lcSi
	de8YQUpYBFQkrmx0ATF5BWwk3vbIgFQICRRKLO+dxwYS5hSwk3hytgokzCggK7Fhw3lmiD3i
	EpuefWeFuF9AYskeiLiEgKjEy8f/oOLyEiduTWMCGcMsoCmxfpc+RKuFxPmbzSwQtqLElO6H
	YHfxCghKnJz5hGUCo/gsJBtmIXTPQtI9C0n3LCTdCxhZVzEK5WYmZ6cWZWbrFWRUlqQm66Wk
	bmIExbgIA9cOxr45HocYmTgYDzFKcDArifA2h29KE+JNSaysSi3Kjy8qzUktPsQozcGiJM67
	uiM4VUggPbEkNTs1tSC1CCbLxMEp1cCo6ajF9uai5GLPnWeXrHucnFa7blVJpPftM28W7bfm
	cPSwNEw5L/3TZm1rs1WlhLbtktNrNdtcTqyc8s3zAcMGzQlzdHmWZ9RbLJpVusll8b0sedtL
	xTEdxYXlN/fnbZv/Q+C2SrBdB+e0+axmr9auK7qh9FbJ+OrDiLjw6Y1fv2WybPy44t4SJZbi
	jERDLeai4kQAkG+0L98CAAA=

T24gMDguMDguMjQgMTI6MjcsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDA3LzA4
LzIwMjQgMTc6MTgsIEJlbmphbWluIEhhaG4gd3JvdGU6DQo+PiBBZGQgc3VwcG9ydCBmb3IgVFBN
IGZvciBwaHlCT0FSRCBQb2xsdXguDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gSGFo
biA8Qi5IYWhuQHBoeXRlYy5kZT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+IC0gcmVu
YW1lZCB0cG0gbm9kZSB0byB0cG1AMA0KPj4gLSByZW1vdmVkIG51bS1jcw0KPj4gLSBjbGVhbnVw
IHBpbmN0cmwNCj4+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0
MDgwNS1pbXg4bXAtdHBtLXYxLTEtMWU4OWYwMjY4OTk5QHBoeXRlYy5kZQ0KPj4gLS0tDQo+PiAg
IC4uLi9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLmR0cyAgIHwgMjYg
KysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9u
cygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMNCj4+IGluZGV4IDAwYTI0MDQ4NGMy
NS4uMGU4MjAwNDEzNTU3IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGsuZHRzDQo+PiArKysgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMNCj4+IEBA
IC0xMDMsNiArMTAzLDIzIEBAIHJlZ192Y2NfM3YzX3N3OiByZWd1bGF0b3ItdmNjLTN2My1zdyB7
DQo+PiAgIAl9Ow0KPj4gICB9Ow0KPj4gICANCj4+ICsvKiBUUE0gKi8NCj4+ICsmZWNzcGkxIHsN
Cj4+ICsJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+PiArCSNzaXplLWNlbGxzID0gPDA+Ow0KPj4g
Kwljcy1ncGlvcyA9IDwmZ3BpbzUgOSBHUElPX0FDVElWRV9MT1c+Ow0KPj4gKwlwaW5jdHJsLW5h
bWVzID0gImRlZmF1bHQiOw0KPj4gKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZWNzcGkxPjsNCj4+
ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4gKw0KPj4gKwl0cG06IHRwbUAwIHsNCj4+ICsJCWNvbXBh
dGlibGUgPSAiaW5maW5lb24sc2xiOTY3MCIsICJ0Y2csdHBtX3Rpcy1zcGkiOw0KPj4gKwkJcmVn
ID0gPDA+Ow0KPj4gKwkJc3BpLW1heC1mcmVxdWVuY3kgPSA8MzgwMDAwMDA+Ow0KPj4gKwkJc3Rh
dHVzID0gIm9rYXkiOw0KPiBEaWQgeW91IGRpc2FibGVkIGl0IGFueXdoZXJlPw0KDQpObywgd2Ug
ZG9uJ3QgZGlzYWJsZSBpdCBhbnl3aGVyZSBhdCB0aGUgbW9tZW50Lg0KDQpCZW5qYW1pbg0KDQo+
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+DQoNCg==

