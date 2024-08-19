Return-Path: <linux-kernel+bounces-291717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088079565D8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D92B231C5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFA415B968;
	Mon, 19 Aug 2024 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="ORIiATEJ"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB7615B560
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056967; cv=none; b=moBIKnuY3Jx10sWQQOS/CbAahKihLJQS5XECxx5fPiWzdVDWHovRuQqTcWUSr0Nmy1MwGEj71EGciSWn4QIIvk9zwGBjaFgrzjqNhnqrI4Yx0KodRzMRd/BsPeP0HpR0KvzS1qvnQ886dt9Y7i8zTKWrNUF6I9DfCBvLbM+4FPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056967; c=relaxed/simple;
	bh=MaGOfuZj2IBvb0IsbGDgoNqa3AvCCOOhv4QBY1N9IVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BuKhGU4/2i2/SCiKUJwh3G0HgF6x9tYtyqrXeJZ50B72iFlt+uAhmUT8PwHijE6es0wSNxadm8CzUTC9GJOn/6jhcHoSe2orkLKeXGwFNH22Nx/vRKRmuns7ZhAxb22U+r6EMIeCtCm30a6yl9jpMIuxUkEok1vO1Srx7KTimMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=ORIiATEJ; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724056962; x=1726648962;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MaGOfuZj2IBvb0IsbGDgoNqa3AvCCOOhv4QBY1N9IVM=;
	b=ORIiATEJefi0lu59o+SazVOXUAw75+ScXmPvm0J6GP26d+Q489MJktoyWbRuP76q
	zrwd9nPPPPgjlZ/HbZblPAv6tEDW/OYh1O1Vlie9U022GffB3UpV1Lo1mYkXhMq/
	5fpCq8HNCftWtm0/dgsKR1GHaDy/2WI1HSgsMSXeei8=;
X-AuditID: ac14000a-03251700000021bc-91-66c30582799b
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D6.37.08636.28503C66; Mon, 19 Aug 2024 10:42:42 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 19 Aug
 2024 10:42:42 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 19 Aug 2024 10:42:42 +0200
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
Subject: Re: [PATCH 3/6] arm64: dts: imx8mp-phyboard-pollux: Add SD-Card vqmmc
 supply
Thread-Topic: [PATCH 3/6] arm64: dts: imx8mp-phyboard-pollux: Add SD-Card
 vqmmc supply
Thread-Index: AQHa7iwRrFOtrj/64kiMzchT6L5e0bIuKaGA
Date: Mon, 19 Aug 2024 08:42:42 +0000
Message-ID: <21bd2960f35b89e1feffe2f7a23965ea97eb0f6b.camel@phytec.de>
References: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-0-e2500950c632@phytec.de>
	 <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-3-e2500950c632@phytec.de>
In-Reply-To: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-3-e2500950c632@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <D884B54CDA40954984B98070A5B10AAD@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWyRpKBR7eJ9XCawd370hZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPF4uWse2wWmx5fY7W4vGsOm8X/PTvYLf5u38Ri8WKLuEX3O3UHHo+d
	s+6ye2xa1cnmsXlJvceLzTMZPfq7W1g9+v8aeHzeJBfAHsVlk5Kak1mWWqRvl8CVMa3tHUvB
	Cc6KrYfOsDQwruDsYuTkkBAwkbi8bDFrFyMXh5DAEiaJN/vfsEM49xklnv7tZ4RwNjBKHHnY
	wQLSwiagInFyxiWwhIjASyaJxVO/gznMAn+ZJJ7+AnE4OYQFwiUWtO5gArFFBCIkpt1oZIew
	jSRe/t4EFmcRUJU49OEUUD0HB6+Am8S6J6EQ2/YxSryYuwNsDqdAisS3Ge3MIDajgKzEhg3n
	wWxmAXGJTc++s0I8ISCxZA9EXEJAVOLl439QcXmJE7emMYHMZxbQlFi/Sx+i1ULi9dVuJghb
	UWJK90Ow03gFBCVOznzCMoFRfBaSDbMQumch6Z6FpHsWku4FjKyrGIVyM5OzU4sys/UKMipL
	UpP1UlI3MYLiXoSBawdj3xyPQ4xMHIyHGCU4mJVEeLtfHkwT4k1JrKxKLcqPLyrNSS0+xCjN
	waIkzru6IzhVSCA9sSQ1OzW1ILUIJsvEwSnVwOi5ag+rkm5rWuN/t0VWGrM9slndJZIPv17v
	9cvCyyg7/fOegMebznqppAgez5B4bz/LJ6Rt+TXv7X8sQlYwMc7m+zrTIp8jNYE5TevM7ISt
	zsue/tsso3zq9I6a/lPZfssDb3wV87bJK1nbofj+SKnw639ySqYnNJblTY3OZn0oa8bqmNp+
	XomlOCPRUIu5qDgRAAc2SCrpAgAA

T24gV2VkLCAyMDI0LTA4LTE0IGF0IDExOjI2ICswMjAwLCBUZXJlc2EgUmVtbWV0IHdyb3RlOg0K
PiBBZGQgU0QtQ2FyZCBwcm9wZXJ0eSBmb3IgdGhlIGJ1cyBJTyBwb3dlciBmcm9tIHRoZSBQTUlD
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGVyZXNhIFJlbW1ldCA8dC5yZW1tZXRAcGh5dGVjLmRl
Pg0KUmV2aWV3ZWQtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPg0KDQo+IC0tLQ0K
PiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgt
cmRrLmR0cyB8IDEgKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2Fy
ZC1wb2xsdXgtcmRrLmR0cw0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
cC1waHlib2FyZC1wb2xsdXgtcmRrLmR0cw0KPiBpbmRleCAzNDI3OTM2ZjkwNDUuLjM0MWJhYTE2
NzE5MSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1w
LXBoeWJvYXJkLXBvbGx1eC1yZGsuZHRzDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLmR0cw0KPiBAQCAtMjg1LDYgKzI4NSw3
IEBAICZ1c2RoYzIgew0KPiDCoAljZC1ncGlvcyA9IDwmZ3BpbzIgMTIgR1BJT19BQ1RJVkVfTE9X
PjsNCj4gwqAJZGlzYWJsZS13cDsNCj4gwqAJdm1tYy1zdXBwbHkgPSA8JnJlZ191c2RoYzJfdm1t
Yz47DQo+ICsJdnFtbWMtc3VwcGx5ID0gPCZsZG81PjsNCj4gwqAJYnVzLXdpZHRoID0gPDQ+Ow0K
PiDCoAlzdGF0dXMgPSAib2theSI7DQo+IMKgfTsNCj4gDQoNCg==

