Return-Path: <linux-kernel+bounces-247375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CE792CE96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DBE7B20A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379B118FA23;
	Wed, 10 Jul 2024 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="m8EqlA+p"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F2D18EFCC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720605090; cv=none; b=n3C9IcSbTB/70VG7RqCkTTFtdgNLsiiUkx8wAhd+lxOt5ZSPYH2T9tdsHs5LNXpQnkgN+1xaPZEe/Ux7/24/FRdJ3vGzaaEeAc3Jj1Ff370AXiYEDSiEM7EaeB+UGi1mEFe0f7fHadRy8ZaqPZYOU8osrSwlV5TqOGjeDd9JODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720605090; c=relaxed/simple;
	bh=5vy6X0O6qEnfmBFIMy66z8mbjzBObduDt7gIIzeMJf0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=llQkMpB29fe/ethfoGtoFzq3LWpT3CiThb9imAxRtcu8UPnTluYfAWQMn1PU2qY64pTsoG/ndezdPplQTiN5VqzH+qupHe4UjNU54MGcL+QExrC2Cg/EiX4kowN97SGyVnII1YrJN+NO021sRacNHawSXKuJy4xN1ENC/sxBUEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=m8EqlA+p; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1720605086; x=1723197086;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5vy6X0O6qEnfmBFIMy66z8mbjzBObduDt7gIIzeMJf0=;
	b=m8EqlA+paYoBgUaLDhjoUNJTSZc9qT5Ei0rlLfOHx8Quwvf81nB/uYM9fRc5YUFm
	XSM8dFP1BbRuzkQaNyCn3T3fhdaSV/GICatMauruOfVSeJaTis8A+bQyBOD9A8Eb
	rb89pTvD/BnJaUK5OaA3wtmjv+FhtCP+EJMAab9NPGo=;
X-AuditID: ac14000a-03e52700000021bc-46-668e599e3cbe
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id BD.7F.08636.E995E866; Wed, 10 Jul 2024 11:51:26 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 10 Jul
 2024 11:51:25 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Wed, 10 Jul 2024 11:51:25 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"Rob Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: PHYTEC Upstream <upstream@lists.phytec.de>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: freescale: imx8mp-phycore: Add no-eth
 overlay
Thread-Topic: [PATCH v2] arm64: dts: freescale: imx8mp-phycore: Add no-eth
 overlay
Thread-Index: AQHaztTwwwIaBQqxY0i9PdyfIGTAlrHsiQGAgAMVQoA=
Date: Wed, 10 Jul 2024 09:51:25 +0000
Message-ID: <829ab483-fb96-4fd2-be7c-03548ba22ce5@phytec.de>
References: <20240705-bspimx8m-3180-v2-1-dc1a7e1689be@phytec.de>
 <1764670d-0248-46fd-b0ce-03bcbcd6977b@linaro.org>
In-Reply-To: <1764670d-0248-46fd-b0ce-03bcbcd6977b@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CD51A38C1FC3D4991D2BFE0AD5067E4@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWyRpKBR3deZF+awYV/fBZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPFou/FQ2aLva+3sltsenyN1eLyrjlsFq17j7Bb/N2+icXixRZxi+53
	6g68Hjtn3WX32LSqk83jzrU9bB6bl9R7vNg8k9Gjv7uF1aP/r4HH501yARxRXDYpqTmZZalF
	+nYJXBnbJy9iLmjhrWi+/4+1gfEGTxcjJ4eEgInEjM9HGbsYuTiEBJYwSTw8MY0VwrnPKNH1
	+AQ7hLOBUWL3jQUsIC1sAmoSu968BqsSEXjAJNH0+CxYP7PAGiaJk1dWMHcxcnAICwRLbDzD
	CtIgIhAisfrILRYI20pix/WzbCA2i4CqxJ79G8DivAI2Ev8OL2EEsYUESiQ+zloMNoZTwE5i
	0lNFkDCjgKzEhg3nmUFsZgFxiU3PvrNCvCAgsWQPRFxCQFTi5eN/UHF5iRO3pjGBjGEW0JRY
	v0sfotVC4klHJ9QYRYkp3Q/ZIS4QlDg58wnLBEbxWUg2zELonoWkexaS7llIuhcwsq5iFMrN
	TM5OLcrM1ivIqCxJTdZLSd3ECEoDIgxcOxj75ngcYmTiYDzEKMHBrCTCO/9Gd5oQb0piZVVq
	UX58UWlOavEhRmkOFiVx3tUdwalCAumJJanZqakFqUUwWSYOTqkGxsRXeR0n+XKXPbpScX9R
	xMZcLYtVvvmmJ1YnsSxpk39YV7ZQh/O6bPEdo937Hlgte8/SdeztN59ndQ69st/n2hvu2eDW
	/fTrvL6QB5+dfSo+3DY0eZlw6/XpRapMc09zNz2rzPP7sW+ryL+vztMyvWbLfHN8vEigLeJE
	uaDN8zOlDlGON9uPVSqxFGckGmoxFxUnAgBYqL1j8QIAAA==

T24gMDguMDcuMjQgMTI6NDYsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDA1LzA3
LzIwMjQgMTQ6MTQsIEJlbmphbWluIEhhaG4gd3JvdGU6DQo+PiBBZGQgYSBkZXZpY2V0cmVlIG92
ZXJsYXkgdG8gZGlzYWJsZSBldGhlcm5ldCBmb3IgYm9hcmRzIHdoZXJlIGl0IGlzIG5vdA0KPj4g
cG9wdWxhdGVkLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEhhaG4gPEIuSGFobkBw
aHl0ZWMuZGU+DQo+PiAtLS0NCj4+IENoYW5nZXMgaW4gdjI6DQo+IFRoYXQncyBzb21lIG9sZCBr
ZXJuZWwgeW91IGFyZSBkZXZlbG9waW5nIG9uLCByaWdodD8NCg0KWW91IGFyZSBjb3JyZWN0LiBJ
IHdhcyBzdGlsbCBvbiBLZXJuZWwgdmVyc2lvbiA2LjguDQoNCkkgcmViYXNlZCB0byBtYXN0ZXIg
YW5kIHNlbnQgYSB2My4NCg0KUmVnYXJkcywNCg0KQmVuamFtaW4NCg0KPg0KPiA8Zm9ybSBsZXR0
ZXI+DQo+IFBsZWFzZSB1c2Ugc2NyaXB0cy9nZXRfbWFpbnRhaW5lcnMucGwgdG8gZ2V0IGEgbGlz
dCBvZiBuZWNlc3NhcnkgcGVvcGxlDQo+IGFuZCBsaXN0cyB0byBDQyAoYW5kIGNvbnNpZGVyIC0t
bm8tZ2l0LWZhbGxiYWNrIGFyZ3VtZW50KS4gSXQgbWlnaHQNCj4gaGFwcGVuLCB0aGF0IGNvbW1h
bmQgd2hlbiBydW4gb24gYW4gb2xkZXIga2VybmVsLCBnaXZlcyB5b3Ugb3V0ZGF0ZWQNCj4gZW50
cmllcy4gVGhlcmVmb3JlIHBsZWFzZSBiZSBzdXJlIHlvdSBiYXNlIHlvdXIgcGF0Y2hlcyBvbiBy
ZWNlbnQgTGludXgNCj4ga2VybmVsLg0KPg0KPiBUb29scyBsaWtlIGI0IG9yIHNjcmlwdHMvZ2V0
X21haW50YWluZXIucGwgcHJvdmlkZSB5b3UgcHJvcGVyIGxpc3Qgb2YNCj4gcGVvcGxlLCBzbyBm
aXggeW91ciB3b3JrZmxvdy4gVG9vbHMgbWlnaHQgYWxzbyBmYWlsIGlmIHlvdSB3b3JrIG9uIHNv
bWUNCj4gYW5jaWVudCB0cmVlIChkb24ndCwgaW5zdGVhZCB1c2UgbWFpbmxpbmUpIG9yIHdvcmsg
b24gZm9yayBvZiBrZXJuZWwNCj4gKGRvbid0LCBpbnN0ZWFkIHVzZSBtYWlubGluZSkuIEp1c3Qg
dXNlIGI0IGFuZCBldmVyeXRoaW5nIHNob3VsZCBiZQ0KPiBmaW5lLCBhbHRob3VnaCByZW1lbWJl
ciBhYm91dCBgYjQgcHJlcCAtLWF1dG8tdG8tY2NgIGlmIHlvdSBhZGRlZCBuZXcNCj4gcGF0Y2hl
cyB0byB0aGUgcGF0Y2hzZXQuDQo+IDwvZm9ybSBsZXR0ZXI+DQo+DQo+IEJlc3QgcmVnYXJkcywN
Cj4gS3J6eXN6dG9mDQo+DQoNCg==

