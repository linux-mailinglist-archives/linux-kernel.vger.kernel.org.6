Return-Path: <linux-kernel+bounces-371159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB559A372E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAAE283248
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0E5189B9D;
	Fri, 18 Oct 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="s44Td5Rm"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BDA186613
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236713; cv=none; b=lZiCKF/WAfrkeoX61LIRDZqmwdW7do8ge8AaVjAoWkyW63f4FCjbbFTwVpPx0gqaO3i7cP1P9jSPTOko6actVUlQSa1YVgCzGPsTKtaR+CkZsd6Kxn95J8VBokCusKQRZTyCDV7o1mtcAejZc0Ayy0rI2xG2yv/0YmNNJuPHKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236713; c=relaxed/simple;
	bh=Bcyhl5kY/sOHE7DfxpuYkTfNLNsdv4JRLJMRoGawewE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GQ27BYbbZmbJz2ZmXRcWozCekBSUPa1/RvseZrHPkpC4e/AiSqtx7KcKx0XpxMNFYKs5ip8WUrfrNjpdXtzZDsLdlOzY7BVpUMHpaQ92tvbF0GpOAVNvZhX1as05Nvp4WP1rD+By/+vIeLEOcwAeBFJA+vDN4Cj4spl8NgoPw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=s44Td5Rm; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1729236708; x=1731828708;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bcyhl5kY/sOHE7DfxpuYkTfNLNsdv4JRLJMRoGawewE=;
	b=s44Td5RmMuxgg8qTb4MyALbP+OHEFB0oimt92MugzfRwXrBhaft6tqWd7OyB2lw/
	IkQHtKqKWh0D3tA+/hipMmwo/DtMjE1SDYlRRXHCWHkPO2RcMQ6gXHRuqsylyLV4
	4I7KqGb2er4ZyIplOl89igPglt6n6NRIC24TvEesfnA=;
X-AuditID: ac14000a-4577e70000004e2a-8c-67120ee3e23a
Received: from Diagnostix.phytec.de (Diagnostix.phytec.de [172.25.0.14])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B3.A2.20010.3EE02176; Fri, 18 Oct 2024 09:31:47 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 18 Oct
 2024 09:31:47 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Fri, 18 Oct 2024 09:31:47 +0200
From: Yannic Moog <Y.Moog@phytec.de>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "marex@denx.de" <marex@denx.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "isaac.scott@ideasonboard.com"
	<isaac.scott@ideasonboard.com>, "kernel@dh-electronics.com"
	<kernel@dh-electronics.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "victor.liu@nxp.com"
	<victor.liu@nxp.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mp-phyboard-pollux: Set Video PLL1
 frequency to 506.8 MHz
Thread-Topic: [PATCH] arm64: dts: imx8mp-phyboard-pollux: Set Video PLL1
 frequency to 506.8 MHz
Thread-Index: AQHbIEJYdOojGCieyEaB2fu4YX6curKL/YeA
Date: Fri, 18 Oct 2024 07:31:47 +0000
Message-ID: <7094f3c17319ccb4676e7b539fc4bb52bea674e6.camel@phytec.de>
References: <20241017031146.157996-1-marex@denx.de>
In-Reply-To: <20241017031146.157996-1-marex@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <617401BAA2C620438450CA58711C95DE@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWyRpKBT/cxn1C6wcNzVhZr9p5jsph/5Byr
	xcOr/hYz77WyWbw7/Z7Z4vORG2wWq6buZLF4Oesem8Wmx9dYLS7vmsNm8aatkdHi/54d7BZ/
	t29isXixRdziW9tmdgd+j3mzTrB43Du+h9lj56y77B6zO2ayemxa1cnmsXlJvceLzTMZPTa+
	28Hk0f/XwOPzJrkArigum5TUnMyy1CJ9uwSujEXrFjMXHJGueHTzLVsD4wupLkZODgkBE4k3
	kw+wdzFycQgJrGOSONF/gg3CecwosWvxEihnA6PEussvWUBa2ARUJE7OuMQIYosIlEh82NwO
	VsQsMJ1VYtqZXnaQhLBAgsT3P03MXYwcQEWJEofOy0DUG0kcm/8erIRFQFVi+otfbCA2r4Cb
	ROusi6wgtpCAscTpTUuYQGxOoPM6vmwB28UoICuxYcN5ZhCbWUBcYtOz76wQLwhILNkDEZcQ
	EJV4+fgfVFxe4sStaUwgJzALaEqs36UP0Wohcbz9LhOErSgxpfshO8QJghInZz5hmcAoPgvJ
	hlkI3bOQdM9C0j0LSfcCRtZVjEK5mcnZqUWZ2XoFGZUlqcl6KambGEEJQ4SBawdj3xyPQ4xM
	HIyHGCU4mJVEeJPqBdOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ867uCE4VEkhPLEnNTk0tSC2C
	yTJxcEo1MMr4XZnmdP5M4Ns9M63ZmEyP/up6vqdQ+RXHiQMz5rsoZxgnLz7XlXflWtH6FYdk
	pTruy51J8pRc+vF8S5tlxKNERydu8de7e96mv1JnqFzPbu9icVfqnNfEMw3XrmlW/1bcni5e
	vp9lr4zzwS/cbHM3Trr19b6+6/T/Zz7738mfFTbH6NGctQFKLMUZiYZazEXFiQDp8wIMBgMA
	AA==

T24gVGh1LCAyMDI0LTEwLTE3IGF0IDA1OjExICswMjAwLCBNYXJlayBWYXN1dCB3cm90ZToNCj4g
VGhlIExWRFMgcGFuZWwgb24gdGhpcyBkZXZpY2UgdXNlcyA3Mi40IE1IeiBwaXhlbCBjbG9jaywg
c2V0IElNWDhNUF9WSURFT19QTEwxDQo+IHRvIDcyLjQgKiA3ID0gNTA2LjggTUh6IHNvIHRoZSBM
REIgc2VyaWFsaXplciBhbmQgTENESUZ2MyBzY2Fub3V0IGVuZ2luZSBjYW4NCj4gcmVhY2ggYWNj
dXJhdGUgcGl4ZWwgY2xvY2sgb2YgZXhhY3RseSA3Mi40IE1Iei4NCj4gDQo+IFdpdGhvdXQgdGhp
cyBwYXRjaCwgdGhlIFZpZGVvIFBMTDEgZnJlcXVlbmN5IGlzIHRoZSBkZWZhdWx0IHNldCBpbiBp
bXg4bXAuZHRzaQ0KPiB3aGljaCBpcyAxMDM5LjUgTUh6LCB3aGljaCBkaXZpZGVzIGRvd24gdG8g
aW5hY2N1cmF0ZSBwaXhlbCBjbG9jayBvZiA3NC4yNSBNSHoNCj4gd2hpY2ggd29ya3MgZm9yIHRo
aXMgcGFydGljdWxhciBwYW5lbCBieSBzaGVlciBjaGFuY2UuDQo+IA0KPiBTdG9wIHRha2luZyB0
aGF0IGNoYW5jZSBhbmQgc2V0IGNvcnJlY3QgYWNjdXJhdGUgcGl4ZWwgY2xvY2sgZnJlcXVlbmN5
IGluc3RlYWQuDQo+IA0KPiBGaXhlczogMzI2ZDg2ZTE5N2ZjICgiYXJtNjQ6IGR0czogaW14OG1w
LXBoeWJvYXJkLXBvbGx1eC1yZGs6IGFkZCBldG1sIHBhbmVsIHN1cHBvcnQiKQ0KPiBSZXBvcnRl
ZC1ieTogSXNhYWMgU2NvdHQgPGlzYWFjLnNjb3R0QGlkZWFzb25ib2FyZC5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KDQpSZXZpZXdlZC1ieTogWWFu
bmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+DQpUZXN0ZWQtYnk6IFlhbm5pYyBNb29nIDx5Lm1v
b2dAcGh5dGVjLmRlPg0KDQo+IC0tLQ0KPiBDYzogQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJu
ZWwub3JnPg0KPiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBDYzog
SXNhYWMgU2NvdHQgPGlzYWFjLnNjb3R0QGlkZWFzb25ib2FyZC5jb20+DQo+IENjOiBLcnp5c3p0
b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+DQo+IENjOiBMaXUgWWluZyA8dmljdG9y
LmxpdUBueHAuY29tPg0KPiBDYzogUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0gPGtlcm5lbEBwZW5n
dXRyb25peC5kZT4NCj4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IENjOiBT
YXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+DQo+IENjOiBTaGF3biBHdW8gPHNo
YXduZ3VvQGtlcm5lbC5vcmc+DQo+IENjOiBZYW5uaWMgTW9vZyA8eS5tb29nQHBoeXRlYy5kZT4N
Cj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBpbXhAbGlzdHMubGludXgu
ZGV2DQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+IE5vdGU6IEkgZG8gbm90IGhhdmUg
dGhlIGJvYXJkLCBidXQgSXNhYWMgcmVwb3J0ZWQgdGhleSB0ZXN0ZWQgaXQgc3VjY2Vzc2Z1bGx5
Lg0KPiDCoMKgwqDCoMKgIFRCIHdvdWxkIGJlIG5pY2UuDQo+IC0tLQ0KPiDCoC4uLi9kdHMvZnJl
ZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLmR0c8KgwqDCoMKgIHwgMTIgKysrKysr
KysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9s
bHV4LXJkay5kdHMNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5
Ym9hcmQtcG9sbHV4LXJkay5kdHMNCj4gaW5kZXggNTBkZWJlODIxYzQyMS4uOWMxMDJhY2I4MDUy
YyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBo
eWJvYXJkLXBvbGx1eC1yZGsuZHRzDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLmR0cw0KPiBAQCAtMjE4LDYgKzIxOCwxOCBA
QCBsZGJfbHZkc19jaDE6IGVuZHBvaW50IHsNCj4gwqAJfTsNCj4gwqB9Ow0KPiDCoA0KPiArJm1l
ZGlhX2Jsa19jdHJsIHsNCj4gKwkvKg0KPiArCSAqIFRoZSBMVkRTIHBhbmVsIG9uIHRoaXMgZGV2
aWNlIHVzZXMgNzIuNCBNSHogcGl4ZWwgY2xvY2ssDQo+ICsJICogc2V0IElNWDhNUF9WSURFT19Q
TEwxIHRvIDcyLjQgKiA3ID0gNTA2LjggTUh6IHNvIHRoZSBMREINCj4gKwkgKiBzZXJpYWxpemVy
IGFuZCBMQ0RJRnYzIHNjYW5vdXQgZW5naW5lIGNhbiByZWFjaCBhY2N1cmF0ZQ0KPiArCSAqIHBp
eGVsIGNsb2NrIG9mIGV4YWN0bHkgNzIuNCBNSHouDQo+ICsJICovDQo+ICsJYXNzaWduZWQtY2xv
Y2stcmF0ZXMgPSA8NTAwMDAwMDAwPiwgPDIwMDAwMDAwMD4sDQo+ICsJCQnCoMKgwqDCoMKgwqAg
PDA+LCA8MD4sIDw1MDAwMDAwMDA+LA0KPiArCQkJwqDCoMKgwqDCoMKgIDw1MDY4MDAwMDA+Ow0K
PiArfTsNCj4gKw0KPiDCoCZzbnZzX3B3cmtleSB7DQo+IMKgCXN0YXR1cyA9ICJva2F5IjsNCj4g
wqB9Ow0KDQo=

