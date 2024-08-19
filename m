Return-Path: <linux-kernel+bounces-291720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05629565DE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6BB2853B1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE8015B963;
	Mon, 19 Aug 2024 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="sTU4HU5o"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EAD15B542
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057013; cv=none; b=lPOKQBqgm02a4xtIGEZ0FTvPhdk+e4iTtsV2poxdttGBPNr6BXnbf+jyhm65N8xoKh7qAy0+a9oG+AAsXyKHbArjlXw2wfCuD2hJe+FNKIaoxN0TyTSONTnNHExPtVUn9aY9UqubFvVAW3ra4FoLlCBOetfE057pVfwl5RAxyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057013; c=relaxed/simple;
	bh=K3LOxVsi2JTaVAbOF1S0jfFxhM0eM9gdbjcCnbEgaTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YImHDN9S6/wMdNNOkn82avY2482lt4KnQeWlmJDTCm/EuzY6+ntGBHA54W1lbI4Sk1tkydXFbpIcSn/VXHoXgXhg0MAMVRRj85BHzF00O1vHjzxi8lXRsewqoPobw51+DgXiVJnu8khuKWgA6+8hxH1JXVc2qtXQmdtkCqkfVb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=sTU4HU5o; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724057010; x=1726649010;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K3LOxVsi2JTaVAbOF1S0jfFxhM0eM9gdbjcCnbEgaTw=;
	b=sTU4HU5oAatwAyRIztmNUz1ikjw2SmScuHIzrk2Xujn97YzDlRn9HmPUgAesZKic
	YMOO8CBXa4oXJvadTRWyyeGdor3nzNGM3oy6VXbkrrIzr2cGEHUk02G2FJ6hIpmD
	Jc+1nBKE5sWtyiX3U58w8cqgpe69QkBVafCg+iT73b0=;
X-AuditID: ac14000a-03251700000021bc-b3-66c305b27500
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 8F.37.08636.2B503C66; Mon, 19 Aug 2024 10:43:30 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 19 Aug
 2024 10:43:30 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 19 Aug 2024 10:43:30 +0200
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
Subject: Re: [PATCH 6/6] arm64: dts: imx8mp-phyboard-pollux: Add usb3_phy1
 regulator reference
Thread-Topic: [PATCH 6/6] arm64: dts: imx8mp-phyboard-pollux: Add usb3_phy1
 regulator reference
Thread-Index: AQHa7iwRevnQ+H5vB0ynpV1fiXCTz7IuKduA
Date: Mon, 19 Aug 2024 08:43:30 +0000
Message-ID: <06fc6f28714b08319226178152e1c900b170d3d2.camel@phytec.de>
References: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-0-e2500950c632@phytec.de>
	 <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-6-e2500950c632@phytec.de>
In-Reply-To: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-6-e2500950c632@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7CF9AF4A265D047A18DF27D3C5881BB@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsWyRpKBR3cT6+E0g5unxCzW7D3HZDH/yDlW
	i4dX/S1m3mtls1g1dSeLxctZ99gsNj2+xmpxedccNov/e3awW/zdvonF4sUWcYvud+oOPB47
	Z91l99i0qpPNY/OSeo8Xm2cyevR3t7B69P818Pi8SS6APYrLJiU1J7MstUjfLoEro3fiJaaC
	SdwVF39/ZW5gfMPVxcjBISFgItHz07iLkYtDSGAJk8S8ydNZuxg5gZz7jBI/TrlCJDYwSpz8
	toARJMEmoCJxcsYlRpCEiMBLJonFU7+DOcwCf5kknv76DlYlLJAgsfb+WjYQW0QgUWLC8ofM
	ELaRRNOTbrAaFgFViXkrN7CD2LwCbhLzdn5jh1i3j1Hib+sLJpAEp0CKROvNo2A3MQrISmzY
	cB5sELOAuMSmZ9/B4hICAhJL9kDEJQREJV4+/gcVl5c4cWsaE8ifzAKaEut36UO0Wkj8fzGL
	HcJWlJjS/RDqBkGJkzOfsExgFJ+FZMMshO5ZSLpnIemehaR7ASPrKkah3Mzk7NSizGy9gozK
	ktRkvZTUTYygqBdh4NrB2DfH4xAjEwfjIUYJDmYlEd7ulwfThHhTEiurUovy44tKc1KLDzFK
	c7AoifOu7ghOFRJITyxJzU5NLUgtgskycXBKNTAKOSUVC7B/1Yy9wn3r7lzh7Y+2VHOsS1jV
	wC5rtv39pRRmtbc664T8/v241+nuJPoqQHbN8wkKrm939m//n5p6zv7UmfOZ0dKTZeZPPG7C
	5nXpe7a9/9Ivuy78veQykY+BJSH2w9vbU1L0OKdauP5XWycZ9zYvl+HvJbllFtn7O256Wm3g
	EK9TYinOSDTUYi4qTgQAQQyrpOgCAAA=

T24gV2VkLCAyMDI0LTA4LTE0IGF0IDExOjI2ICswMjAwLCBUZXJlc2EgUmVtbWV0IHdyb3RlOg0K
PiBGcm9tOiBZYXNod2FudGggVmFyYWthbGEgPHkudmFyYWthbGFAcGh5dGVjLmRlPg0KPiANCj4g
QWRkIFZDQ181Vl9TVyByZWd1bGF0b3IgcmVmZXJlbmNlIHRvIHRoZSB1c2IxIHBoeSBub2RlIHRv
IHJlZmxlY3QgdGhlDQo+IHNjaGVtYXRpYy4gVGhpcyBhbHNvIHNpbGVuY2VzIHRoZSBmYWxsYmFj
ayBkdW1teSByZWd1bGF0b3Igd2FybmluZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhc2h3YW50
aCBWYXJha2FsYSA8eS52YXJha2FsYUBwaHl0ZWMuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IFRlcmVz
YSBSZW1tZXQgPHQucmVtbWV0QHBoeXRlYy5kZT4NClJldmlld2VkLWJ5OiBZYW5uaWMgTW9vZyA8
eS5tb29nQHBoeXRlYy5kZT4NCg0KPiAtLS0NCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMgfCAxICsNCj4gwqAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMNCj4gYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMNCj4g
aW5kZXggNjJmMTgxOWJjMWE0Li42ZTgxODcwZTE3N2MgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLmR0cw0KPiAr
KysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4
LXJkay5kdHMNCj4gQEAgLTI2MCw2ICsyNjAsNyBAQCAmdXNiX2R3YzNfMCB7DQo+IMKgDQo+IMKg
LyogVVNCMiA0LXBvcnQgVVNCMy4wIEhVQiAqLw0KPiDCoCZ1c2IzX3BoeTEgew0KPiArCXZidXMt
c3VwcGx5ID0gPCZyZWdfdmNjXzV2X3N3PjsNCj4gwqAJc3RhdHVzID0gIm9rYXkiOw0KPiDCoH07
DQo+IMKgDQo+IA0KDQo=

