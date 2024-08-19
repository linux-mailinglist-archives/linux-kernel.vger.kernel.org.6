Return-Path: <linux-kernel+bounces-291719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EC09565DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039C01F243C3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817DC15C134;
	Mon, 19 Aug 2024 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="hzfKQzEy"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C415C12C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057002; cv=none; b=HUQ0Bt19RIxqbwUPNPS9j4v3zxAdiKJ9MjNcSiBb3ViCQx+y6Sv5rI37rQfbhFGiPdtQ74xTQnXPRe17ApR8LAlIoCEIono3MlBWkdZO//3SMWj91TbXj7y70e3XLeD9CwqfUGwrkgm04pGdphQkZeVIqlv5nN2fjZ34vLPFORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057002; c=relaxed/simple;
	bh=jOejjbjiMHjbYFLW9FHCIsxaQdVNI1Ua6lzj3IyMzCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C8oNa3wqbdwy7+uJaSxnJwAnby8/k1dXBhv1RD84405Xn3HfhXyHj93Rso1/XfSyW4R208PAQFhBRrCPmtGDeK+vUJB/h+dIbhylEWp/eRUP2P/Swn1gEmLDyvpkQZfNzXDRR2sDQSFuEnqZBftVr4c86+i4Hg/kF6SuEjhPxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=hzfKQzEy; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724056997; x=1726648997;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jOejjbjiMHjbYFLW9FHCIsxaQdVNI1Ua6lzj3IyMzCw=;
	b=hzfKQzEyxdtTYxA9sUwTvnDfp+QR1NBc1Suxzb/2+alrr0LZE+VhG1y94sV6qT7T
	bVx0ldkbLGe+HxOZZI49C97yvKFqRxBmC7tMkopKxwcM5yvGTbVaZrsGt+HS+oH3
	SlOaVh5s+U0jZ0oePYLuyqC8J6XY8WJ5dJN7ggMVsmU=;
X-AuditID: ac14000a-a784c240000021bc-ad-66c305a5e8f7
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id FC.37.08636.5A503C66; Mon, 19 Aug 2024 10:43:17 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 19 Aug
 2024 10:43:17 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 19 Aug 2024 10:43:17 +0200
From: Yannic Moog <Y.Moog@phytec.de>
To: "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"robh@kernel.org" <robh@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Teresa Remmet
	<T.Remmet@phytec.de>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Benjamin Hahn <B.Hahn@phytec.de>, "Yashwanth
 Varakala" <Y.Varakala@phytec.de>, PHYTEC Upstream <upstream@lists.phytec.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] arm64: dts: imx8mp-phyboard-pollux: Add VCC_5V_SW
 regulator
Thread-Topic: [PATCH 5/6] arm64: dts: imx8mp-phyboard-pollux: Add VCC_5V_SW
 regulator
Thread-Index: AQHa7iwRDixKA0O8TkGJxbteGuH2d7IuKcsA
Date: Mon, 19 Aug 2024 08:43:16 +0000
Message-ID: <88a21e566b0b66752675923a8465a5e0f857e168.camel@phytec.de>
References: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-0-e2500950c632@phytec.de>
	 <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-5-e2500950c632@phytec.de>
In-Reply-To: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-5-e2500950c632@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0E59CACA084C242B087F2428CCA41E7@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWyRpKBR3cp6+E0g+bXQhZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPF4uWse2wWmx5fY7W4vGsOm8X/PTvYLf5u38Ri8WKLuEX3O3UHHo+d
	s+6ye2xa1cnmsXlJvceLzTMZPfq7W1g9+v8aeHzeJBfAHsVlk5Kak1mWWqRvl8CVsfrOPJaC
	GXwVK+6cY2lgfMHbxcjJISFgInGl4xETiC0ksIRJ4voBti5GLiD7PqNEX/NGdghnA6PErP3/
	WEGq2ARUJE7OuMQIkhAReMkksXjqdzCHWeAvk8TTXyAOJ4ewQJjEtO0H2UBsEYFwiU0/rjJB
	2EYSuxc8BLNZBFQlrr3fD7SCg4NXwE1i6oFMiG37GCXeT/nLDlLDKZAi0f/nB9hmRgFZiQ0b
	zjOD2MwC4hKbnn1nhfhBQGLJHoi4hICoxMvH/6Di8hInbk1jApnPLKApsX6XPoRpIfFhshDE
	FEWJKd0PwTbxCghKnJz5hGUCo/gsJAtmITTPQmiehaR5FpLmBYysqxiFcjOTs1OLMrP1CjIq
	S1KT9VJSNzGCIl6EgWsHY98cj0OMTByMhxglOJiVRHi7Xx5ME+JNSaysSi3Kjy8qzUktPsQo
	zcGiJM67uiM4VUggPbEkNTs1tSC1CCbLxMEp1cCozpny8DnTg5Ocux7Y8dbx8lZc2nL057SS
	mZ6//t1L8nax6ri5ddqkBylPfx1+OOtnUPGz+Em3FTj3p61ltFhVwSIi5BKmZ561/c4pq+lZ
	q2+Umy1uW/pnoqnPve6URaV732/58Ub4X4np3Nb3wmel99btj9rRwMF4v2bVz4ubbT8Im/k7
	xn1aosRSnJFoqMVcVJwIADS8d7TmAgAA

T24gV2VkLCAyMDI0LTA4LTE0IGF0IDExOjI2ICswMjAwLCBUZXJlc2EgUmVtbWV0IHdyb3RlOg0K
PiBGcm9tOiBZYXNod2FudGggVmFyYWthbGEgPHkudmFyYWthbGFAcGh5dGVjLmRlPg0KPiANCj4g
QWRkIGZpeGVkwqAgcmVndWxhdG9yIFZDQ181Vl9TVyBiYXNlZCBvbiB0aGUgcGh5Qk9BUkQtUG9s
bHV4IHNjaGVtYXRpY3MNCj4gdG8gcmVmbGVjdCB0aGUgY29ubmVjdGl2aXR5IG9uIHRoZSBwaHlC
T0FSRC1Qb2xsdXgtaS5NWDhNUC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhc2h3YW50aCBWYXJh
a2FsYSA8eS52YXJha2FsYUBwaHl0ZWMuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IFRlcmVzYSBSZW1t
ZXQgPHQucmVtbWV0QHBoeXRlYy5kZT4NClJldmlld2VkLWJ5OiBZYW5uaWMgTW9vZyA8eS5tb29n
QHBoeXRlYy5kZT4NCg0KPiAtLS0NCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMgfCA5ICsrKysrKysrKw0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMNCj4gYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMN
Cj4gaW5kZXggNGNkYjNiOWZmZjA4Li42MmYxODE5YmMxYTQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLmR0cw0K
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9s
bHV4LXJkay5kdHMNCj4gQEAgLTQzLDYgKzQzLDE1IEBAIHBhbmVsMV9pbjogZW5kcG9pbnQgew0K
PiDCoAkJfTsNCj4gwqAJfTsNCj4gwqANCj4gKwlyZWdfdmNjXzV2X3N3OiByZWd1bGF0b3ItdmNj
LTV2LXN3IHsNCj4gKwkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0KPiArCQlyZWd1
bGF0b3ItYWx3YXlzLW9uOw0KPiArCQlyZWd1bGF0b3ItYm9vdC1vbjsNCj4gKwkJcmVndWxhdG9y
LW1heC1taWNyb3ZvbHQgPSA8NTAwMDAwMD47DQo+ICsJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0
ID0gPDUwMDAwMDA+Ow0KPiArCQlyZWd1bGF0b3ItbmFtZSA9ICJWQ0NfNVZfU1ciOw0KPiArCX07
DQo+ICsNCj4gwqAJcmVnX2NhbjFfc3RieTogcmVndWxhdG9yLWNhbjEtc3RieSB7DQo+IMKgCQlj
b21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7DQo+IMKgCQlwaW5jdHJsLW5hbWVzID0gImRl
ZmF1bHQiOw0KPiANCg0K

