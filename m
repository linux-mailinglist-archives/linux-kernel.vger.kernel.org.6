Return-Path: <linux-kernel+bounces-186061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DA88CBF57
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18121F23333
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B40823DE;
	Wed, 22 May 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="t9ZHGlVb"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63B405CC
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374331; cv=none; b=qeQXtZfeZpAwxJPoiZyHmQ5bROZXdGbba9CsPhTbngrULuOITkQiRe/TWioZM0tX3OF7DAECG4X6vbX3ddQ8TuYVJszNdsUw/dRixQhDiPaH35ScQTivrwhDgIXQTNitzZpi+VMVBc1Qb5yeorG3jg9FvkBXkcazUKek+/1v1YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374331; c=relaxed/simple;
	bh=dvZ4Vz1vz3Nu6kSflezdJ6kz7KHr3aXXTyHZga4SfAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m6yr+yvaVV+IMq8XMHUhJ2YfUl0OJj/zYAeZ74/Z4ToPCufqQICdD6UBXbdoKk4vYh8rRnsSnL6TL3GTisl7ROn2V/vFbc7fJEvwEztvYXBju0FEoTEC5Jbrti9G/8rclr+F5Mzd1OQCJ3weBvBy1Pdt8VTp0L9iFMxz1gq9BtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=t9ZHGlVb; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1716373418; x=1718965418;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dvZ4Vz1vz3Nu6kSflezdJ6kz7KHr3aXXTyHZga4SfAg=;
	b=t9ZHGlVbPtK/P3ecnsXvBuMC+GHwRRaH4PWN6oznpLN1ejtrpx3ibd6+ad0mTHsX
	qVYeyWDZdLXQCg+naXTY6jMZNRkSKPS/2gxGI3miX3p4LgsoylOveJgioCmfOzvQ
	q2/yQ1vKPvyZtEsdrlB8MIcmxeAl6I26RfrnA8KK4fs=;
X-AuditID: ac14000a-03e52700000021bc-a5-664dc7aa83ff
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 32.42.08636.AA7CD466; Wed, 22 May 2024 12:23:38 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 12:23:37 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Wed, 22 May 2024 12:23:37 +0200
From: Dominik Haller <D.Haller@phytec.de>
To: "Laurent.pinchart@ideasonboard.com" <Laurent.pinchart@ideasonboard.com>,
	"andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"jyri.sarha@iki.fi" <jyri.sarha@iki.fi>, "rfoss@kernel.org"
	<rfoss@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"a-bhatia1@ti.com" <a-bhatia1@ti.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, "mripard@kernel.org"
	<mripard@kernel.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>
CC: "devarsht@ti.com" <devarsht@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
	"sam@ravnborg.org" <sam@ravnborg.org>, "j-choudhary@ti.com"
	<j-choudhary@ti.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "j-luthra@ti.com" <j-luthra@ti.com>,
	"boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nm@ti.com"
	<nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"kieran.bingham+renesas@ideasonboard.com"
	<kieran.bingham+renesas@ideasonboard.com>, "treding@nvidia.com"
	<treding@nvidia.com>, "praneeth@ti.com" <praneeth@ti.com>
Subject: Re: [EXTERNAL] [PATCH 3/7] drm/bridge: cdns-dsi: Wait for Clk and
 Data Lanes to be ready
Thread-Topic: [EXTERNAL] [PATCH 3/7] drm/bridge: cdns-dsi: Wait for Clk and
 Data Lanes to be ready
Thread-Index: AQHao7lwY8evdberYUusC/uCJpv4BbGi+zyA
Date: Wed, 22 May 2024 10:23:37 +0000
Message-ID: <f45daf0d6c0ab8a225277621b6e6b373929d145a.camel@phytec.de>
References: <20240511153051.1355825-1-a-bhatia1@ti.com>
	 <20240511153051.1355825-4-a-bhatia1@ti.com>
In-Reply-To: <20240511153051.1355825-4-a-bhatia1@ti.com>
Accept-Language: en-DE, de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A62AE1C102C2C4C8F0DEFD6D381EC3C@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUxTQRiFnbtTrY6lygAKETVRI+BCzDy4vYhjjAkuT2qCDb1YUkQouAAv
	RBRLcSmijVRAK1URcSugYFqMYAIIDYkWUBZxC9gEBAVkUUQv1cjb958zZ/4zyQi0wsn6CTFx
	SaIuThUbxMmYEt8Zs4KLa3dErxo/OQdbc29RuK71OoW7CgcZXPXiPIMnH2XT+JajhMGu4X4O
	91pyaewwfOBwz9V7ANf3NjP43WkHjb+1ZAGcmW3l8asneRy2fC1ncEbmTRb3V7YB3DvqpPDP
	D24OXyh4w+KisXKAG/OHedz+YzYu681msclxmcaTzgF+sz8pKEklju/XGFJp7uTJFX0uS2qG
	LQwptLspYivO5Eid8SVFOlrsHCmo30m6smopcjb9C0espmaOlDakktrXjykyaAuIgHtl69Vi
	bMxRURe68YBMk28qZeKLfI/feKvn04ALGYCXgGAYcg80sQYgExTQSqFThU95z9AFUFFx91/n
	AUBW42dainBwOXJfap8ylNDFoneDfZQ00HCMQcbJZ5x0yhtGIeNoDiOxEqrR6QwD5eE1aLSi
	m5eYgUtR2ZUcYACCIIfhaMIy1UkBo9H1niFekr0gRhfPrJRkAJegdvc4kJiGPsjWPcJ6ngCR
	1d5Ee3gecn/89VcPRHVtJkq6hv7T+f6TUE8Uo8oTWZyHF6GLWe+nysjhXFSf+4kxAh/ztA3m
	/2nztLR5Wto8LX0NsMVAcSgmSivqYrQh8ZrkJDEqRC3agPTllDNkFeBcHqkGlACqARLoIKV8
	3+0d0Qq5WpWcIuoOR+qOxIqJ1cBfYIJ85Hf0u0UFPKhKErWiGC/q/rmU4OWXBowdC2rsloQN
	8aW79tdMKI89vH33uBqFrdt6KXV+YPDXh8Pc9pDFi3HEsgOmgI/Odi9X1RDvbmxYuPmsc0Cv
	fewd3jpSvsdPtY4P8H7u79A/DRuQ+4+DyFmmLWpNxejMsWf1CTVrt5WlG/uqNqXY7mbcdLfV
	jSySa7jVnc61rh9RQUyiRrV6Ba1LVP0Gv6vKkGADAAA=

SGkgQXJhZGh5YSwNCg0KdGhpcyBmaXhlcyB0aGUgY29sb3Itc2hpZnQgYnVnIG9uIG91ciBzZXR1
cDoNCmo3MjFzMiAtPiB0aSxzbjY1ZHNpODMgLT4gZWR0LGV0bWwxMDEwZzNkcmENCg0KDQoNClRl
c3RlZC1ieTogRG9taW5payBIYWxsZXIgPGQuaGFsbGVyQHBoeXRlYy5kZT4NCg0KDQpPbiBTYXQs
IDIwMjQtMDUtMTEgYXQgMjE6MDAgKzA1MzAsIEFyYWRoeWEgQmhhdGlhIHdyb3RlOg0KPiBPbmNl
IHRoZSBEU0kgTGluayBhbmQgRFNJIFBoeSBhcmUgaW5pdGlhbGl6ZWQsIHRoZSBjb2RlIG5lZWRz
IHRvIHdhaXQNCj4gZm9yIENsayBhbmQgRGF0YSBMYW5lcyB0byBiZSByZWFkeSwgYmVmb3JlIGNv
bnRpbnVpbmcgY29uZmlndXJhdGlvbi4NCj4gVGhpcyBpcyBpbiBhY2NvcmRhbmNlIHdpdGggdGhl
IERTSSBTdGFydC11cCBwcm9jZWR1cmUsIGZvdW5kIGluIHRoZQ0KPiBUZWNobmljYWwgUmVmZXJl
bmNlIE1hbnVhbCBvZiBUZXhhcyBJbnN0cnVtZW50J3MgSjcyMUUgU29DWzBdIHdoaWNoDQo+IGhv
dXNlcyB0aGlzIERTSSBUWCBjb250cm9sbGVyLg0KPiANCj4gSWYgdGhlIHByZXZpb3VzIGJyaWRn
ZSAob3IgY3J0Yy9lbmNvZGVyKSBhcmUgY29uZmlndXJlZCBwcmUtbWF0dXJlbHksDQo+IHRoZSBp
bnB1dCBzaWduYWwgRklGTyBnZXRzIGNvcnJ1cHQuIFRoaXMgaW50cm9kdWNlcyBhIGNvbG9yLXNo
aWZ0IG9uDQo+IHRoZQ0KPiBkaXNwbGF5Lg0KPiANCj4gQWxsb3cgdGhlIGRyaXZlciB0byB3YWl0
IGZvciB0aGUgY2xrIGFuZCBkYXRhIGxhbmVzIHRvIGdldCByZWFkeQ0KPiBkdXJpbmcNCj4gRFNJ
IGVuYWJsZS4NCj4gDQo+IEZpeGVzOiBlMTkyMzM5NTVkOWUgKCJkcm0vYnJpZGdlOiBBZGQgQ2Fk
ZW5jZSBEU0kgZHJpdmVyIikNCj4gU2lnbmVkLW9mZi1ieTogQXJhZGh5YSBCaGF0aWEgPGEtYmhh
dGlhMUB0aS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9jYWRlbmNlL2Nk
bnMtZHNpLWNvcmUuYyB8IDEzICsrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2JyaWRnZS9jYWRlbmNlL2NkbnMtZHNpLWNvcmUuYw0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9icmlkZ2UvY2FkZW5jZS9jZG5zLWRzaS1jb3JlLmMNCj4gaW5kZXggNTU3YjAzN2JiYzY3Li4w
NWQyZjRjYzUwZGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvY2FkZW5j
ZS9jZG5zLWRzaS1jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9jYWRlbmNl
L2NkbnMtZHNpLWNvcmUuYw0KPiBAQCAtNzYxLDcgKzc2MSw3IEBAIHN0YXRpYyB2b2lkIGNkbnNf
ZHNpX2JyaWRnZV9lbmFibGUoc3RydWN0DQo+IGRybV9icmlkZ2UgKmJyaWRnZSkNCj4gIAlzdHJ1
Y3QgcGh5X2NvbmZpZ3VyZV9vcHRzX21pcGlfZHBoeSAqcGh5X2NmZyA9ICZvdXRwdXQtDQo+ID5w
aHlfb3B0cy5taXBpX2RwaHk7DQo+ICAJdW5zaWduZWQgbG9uZyB0eF9ieXRlX3BlcmlvZDsNCj4g
IAlzdHJ1Y3QgY2Ruc19kc2lfY2ZnIGRzaV9jZmc7DQo+IC0JdTMyIHRtcCwgcmVnX3dha2V1cCwg
ZGl2Ow0KPiArCXUzMiB0bXAsIHJlZ193YWtldXAsIGRpdiwgc3RhdHVzOw0KPiAgCWludCBubGFu
ZXM7DQo+ICANCj4gIAlpZiAoV0FSTl9PTihwbV9ydW50aW1lX2dldF9zeW5jKGRzaS0+YmFzZS5k
ZXYpIDwgMCkpDQo+IEBAIC03NzgsNiArNzc4LDE3IEBAIHN0YXRpYyB2b2lkIGNkbnNfZHNpX2Jy
aWRnZV9lbmFibGUoc3RydWN0DQo+IGRybV9icmlkZ2UgKmJyaWRnZSkNCj4gIAljZG5zX2RzaV9p
bml0X2xpbmsoZHNpKTsNCj4gIAljZG5zX2RzaV9oc19pbml0KGRzaSk7DQo+ICANCj4gKwkvKg0K
PiArCSAqIE5vdyB0aGF0IHRoZSBEU0kgTGluayBhbmQgRFNJIFBoeSBhcmUgaW5pdGlhbGl6ZWQs
DQo+ICsJICogd2FpdCBmb3IgdGhlIENMSyBhbmQgRGF0YSBMYW5lcyB0byBiZSByZWFkeS4NCj4g
KwkgKi8NCj4gKwl0bXAgPSBDTEtfTEFORV9SRFk7DQo+ICsJZm9yIChpbnQgaSA9IDA7IGkgPCBu
bGFuZXM7IGkrKykNCj4gKwkJdG1wIHw9IERBVEFfTEFORV9SRFkoaSk7DQo+ICsNCj4gKwlXQVJO
X09OX09OQ0UocmVhZGxfcG9sbF90aW1lb3V0KGRzaS0+cmVncyArIE1DVExfTUFJTl9TVFMsDQo+
IHN0YXR1cywNCj4gKwkJCQkJc3RhdHVzICYgdG1wLCAxMDAsIDApKTsNCj4gKw0KPiAgCXdyaXRl
bChIQlBfTEVOKGRzaV9jZmcuaGJwKSB8IEhTQV9MRU4oZHNpX2NmZy5oc2EpLA0KPiAgCSAgICAg
ICBkc2ktPnJlZ3MgKyBWSURfSFNJWkUxKTsNCj4gIAl3cml0ZWwoSEZQX0xFTihkc2lfY2ZnLmhm
cCkgfCBIQUNUX0xFTihkc2lfY2ZnLmhhY3QpLA0K

