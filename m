Return-Path: <linux-kernel+bounces-280474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D31194CB17
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A056DB23D8D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D55176228;
	Fri,  9 Aug 2024 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="NxdcLwIH"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F95174EFC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723187972; cv=none; b=F+UlYnIS58GzfSNYk996gpwNeXy9KM3TVbINm3YRUZwOf/8jrJ2kK/D+VhYoYbfDcnMW00DjBl3lZjEzFqhRDDCYW6YhvcYCoykQnaziMfwukTi3m06IAD2WXftwZcyeqpPLqOA1hgHfR09eHHopHHQHUKD53tBHEoe5ssCOK0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723187972; c=relaxed/simple;
	bh=Q4nFREltywLWvp+a+YLS9t960MM8zA7CGo+yKV63lqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZxajxC/YS+8eF5V+ikqdYg9KV2Bgy0mnU5RmIdUWDv6kiz6IbI5vuBtEVegxxkxXGChIcAUAKAa8HGCKS9WM+tnxKSVhjD3kdjsYTGCGiB/dQNLPYouDkCPrbOMt/h32M1gDB6QecalZEOZbJSaX1fxipaY/2iZGFEHkFia0qa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=NxdcLwIH; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723187968; x=1725779968;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q4nFREltywLWvp+a+YLS9t960MM8zA7CGo+yKV63lqA=;
	b=NxdcLwIH+vcNQJb48JT/7hfHKkDdBwpE/OKxNSEZO9svPH3zlZC1jzSow/mYkBWB
	8XtgpWYKEUDIi0SBLa2V+6N3BOOsgPrEdcCA+OVbpUbm/rE/Xwupw62wygEmvqgx
	/8e1y3ovSUf5JQQ6A33VP8JlbIAgMLM6sG925m72xEs=;
X-AuditID: ac14000a-03e52700000021bc-e4-66b5c300ff77
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 81.00.08636.003C5B66; Fri,  9 Aug 2024 09:19:28 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 9 Aug 2024
 09:19:28 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Fri, 9 Aug 2024 09:19:28 +0200
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
	<linux-kernel@vger.kernel.org>, PHYTEC Upstream <upstream@lists.phytec.de>
Subject: Re: [PATCH] dts: freescale: imx8mp-phyboard-pollux-rdk: Add console
 UART bootargs
Thread-Topic: [PATCH] dts: freescale: imx8mp-phyboard-pollux-rdk: Add console
 UART bootargs
Thread-Index: AQHa6XY6kPt5aw6SZ02VFTHA/V1iaLIdAsMAgAFhugA=
Date: Fri, 9 Aug 2024 07:19:28 +0000
Message-ID: <eaf09c81-58d8-4e70-ac58-e69bca617398@phytec.de>
References: <20240808-add_bootargs_to_devicetree-v1-1-79f7ba50b174@phytec.de>
 <ebc46895-6d46-4c24-ac1f-9aecfd2617d6@kernel.org>
In-Reply-To: <ebc46895-6d46-4c24-ac1f-9aecfd2617d6@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <A59B266772063941A9EBF04143087086@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWyRpKBR5fh8NY0g4+t5hZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPF4uWse2wW589vYLfY9Pgaq8XlXXPYLP7v2cFu8Xf7JhaLF1vELbrf
	qTvweuycdZfdY9OqTjaPzUvqPV5snsno0d/dwurR/9fA4/MmuQD2KC6blNSczLLUIn27BK6M
	y2susxcc4q64fWEKcwPjHO4uRk4OCQETidl9h5i6GLk4hASWMEm8+bWeDcK5xyhx7P9tFghn
	PaPElqO/WUFa2ATUJHa9ec0KkhARuM8kcX7bYrAWZoE1TBI9e5YxgVQJC8RI3Gg6wwxiiwjE
	SkxacYEdwraS+NS5Dcjm4GARUJE4ukAZxOQVsJG40iYEsayRUWLqy6UsIOWcAnYSL89PBGtl
	FJCV2LDhPNhIZgFxiU3PvrNC/CAgsWQPRFxCQFTi5eN/UHF5iRO3pjGBzGcW0JRYv0sfotVC
	4sKriVBjFCWmdD8EG88rIChxcuYTlgmM4rOQbJiF0D0LSfcsJN2zkHQvYGRdxSiUm5mcnVqU
	ma1XkFFZkpqsl5K6iREU/yIMXDsY++Z4HGJk4mA8xCjBwawkwtscvilNiDclsbIqtSg/vqg0
	J7X4EKM0B4uSOO/qjuBUIYH0xJLU7NTUgtQimCwTB6dUA+OWPfpstzxaJ9l0aB+W1y1azLND
	pCf4Y6bR3iW321fl3vRo3t3w4Sanzo+qm5yZG7xPuvtsKJ4ddJz5EEPsZV3Hqi2rghpjk2wj
	GUIPn9vS1hlQski/N+TXrjnPtrIF2sTemJ6+VmG1x6TZazMTTUtmsxueEIm4M726Zurht/7x
	Sxbtu6Hfs0yJpTgj0VCLuag4EQC5mnww7QIAAA==

T24gMDguMDguMjQgMTI6MTMsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDA4LzA4
LzIwMjQgMTE6MzQsIEJlbmphbWluIEhhaG4gd3JvdGU6DQo+PiBQYXNzIHRoZSBjb25zb2xlIFVB
UlQgYm9vdGFyZ3MgcGFyYW1ldGVyIHZpYSB0aGUgZGV2aWNldHJlZSBmb3IgYm9vdGluZw0KPj4g
RUZJIGJpbmFyaWVzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEhhaG4gPEIuSGFo
bkBwaHl0ZWMuZGU+DQo+PiAtLS0NCj4+ICAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGsuZHRzIHwgMSArDQo+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMNCj4+IGluZGV4
IDAwYTI0MDQ4NGMyNS4uNTUyYjUyOGZiNjYzIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGsuZHRzDQo+PiArKysg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJk
ay5kdHMNCj4+IEBAIC0xNiw2ICsxNiw3IEBAIC8gew0KPj4gICAJCSAgICAgInBoeXRlYyxpbXg4
bXAtcGh5Y29yZS1zb20iLCAiZnNsLGlteDhtcCI7DQo+PiAgIA0KPj4gICAJY2hvc2VuIHsNCj4+
ICsJCWJvb3RhcmdzID0gImNvbnNvbGU9dHR5bXhjMCwxMTUyMDAiOw0KPiBTb3JyeSwgYnV0IHN0
ZG91dCBpcyBzdWZmaWNpZW50LiBJZiBpdCBpcyBub3QsIHNvbWV0aGluZyBlbHNlIG5lZWRzIGZp
eGluZy4NCg0KT2ssIGxvb2tzIGxpa2Ugc3Rkb3V0LXBhdGNoIHNob3VsZCBpbmRlZWQgYmUgc3Vm
ZmljaWVudCBmb3IgVUVGSSBib290LCANCnNvIHRoaXMgaXMgbm90IG5lZWRlZCB0aGVuLg0KDQpC
ZW5qYW1pbg0KDQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+DQoNCg==

