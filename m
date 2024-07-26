Return-Path: <linux-kernel+bounces-263231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C00C93D2FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19111F2214F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867A617A5BA;
	Fri, 26 Jul 2024 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="HvezL4Jb"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF813C9CD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997076; cv=none; b=bFLcvhKeM7ednT1r8/afagOcRfMFJyfcMbMhGDDK8Yy7PubCZqP0EP8B8O37GrA3oH3Gvy3KW41WTMyXa6VMPPrjlPJPqWvGlBVP1D8L3Svz831laZRfsnYfih8ZlGXzgPQNreJh8ets51dpRK2pto+24nrj+3EB/uyV75q435w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997076; c=relaxed/simple;
	bh=MlJwlbjUlcCc+ZZTtdm6Pi/qZeMa/wtqkGavYiLkVXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NA7IQprNh70cij9HhW+fmviD6uXPXhUoEZmSPdIZmaPdsZnTtHyYUaS5/WQZCbmcTzJ2nI8umZ+q2qCnPv6kZ/aWQHbmLykMD8BxaTQ5dtcAqDhcah1vm2oOKHog7La277P0NF422SpxZD5ojYAVF5kvLvE15A6KzuNrwzE2/vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=HvezL4Jb; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1721997064; x=1724589064;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MlJwlbjUlcCc+ZZTtdm6Pi/qZeMa/wtqkGavYiLkVXA=;
	b=HvezL4JbN5+QhxNyQoo487S9B50vvZ3KGzpyLr0S0009mQL67/QUGedFy8tfxI0Y
	f/ZcFRoxdCwm5gStCdJRhKaUD43H8nKecX/4Y2+AgKnWE2emCBmZOChPCAOi0oNd
	tPux8v7EWWw1m9nbQCxVNRCzHOG7XXt8Vz/HD9mA/QI=;
X-AuditID: ac14000a-03251700000021bc-77-66a3970808c3
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A2.F1.08636.80793A66; Fri, 26 Jul 2024 14:31:04 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 26 Jul
 2024 14:31:04 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Fri, 26 Jul 2024 14:31:03 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Andrej Picej <andrej.picej@norik.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, PHYTEC Upstream
	<upstream@lists.phytec.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: Re: [Upstream] [PATCH] arm64: dts: imx8mp-phyboard-pollux: Disable
 write-protect on SD card
Thread-Topic: [Upstream] [PATCH] arm64: dts: imx8mp-phyboard-pollux: Disable
 write-protect on SD card
Thread-Index: AQHa31euUtK0aNEroEae9APeWMkSoA==
Date: Fri, 26 Jul 2024 12:31:03 +0000
Message-ID: <0b2eecd0-cd5f-48d9-9377-164b5ad5b78d@phytec.de>
References: <20240716085114.3205582-1-andrej.picej@norik.com>
In-Reply-To: <20240716085114.3205582-1-andrej.picej@norik.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE72787A14AC7346A57308D98746FC04@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWyRpKBV5dj+uI0g7cXRSym7mW0WLP3HJPF
	/CPnWC0eXvW3mHmvlc1i1dSdLBYvZ91js9j0+BqrxeVdc9gs/u/ZwW7xd/smFosXW8Qtut+p
	O/B67Jx1l91j06pONo/NS+o9XmyeyejR393C6vH96wZWj/6/Bh6fN8kFcERx2aSk5mSWpRbp
	2yVwZZxrDC6YwVPxa9ZdlgbGD9xdjJwcEgImEp+v72fuYuTiEBJYwiSx68BfdgjnPqPE3JbZ
	LBDOBkaJi9cfsoK0sAmoSex685oVJCEi8IZJ4uT9n2D9zAJrmCQ6p90GqxIWSJO41NvD1MXI
	AVSVLrH1fSFIWERAT+Jl60YWEJtFQFWi59xnNhCbV8BGovnPMmYQW0jAVmJB3y8mEJtTwE5i
	S9sRsJGMArISGzacB6thFhCX2PTsOyvEDwISS/ZAxCUERCVePv4HFZeXOHFrGtgJzAKaEut3
	6UO0WkisWnqdCcJWlJjS/ZAd4gRBiZMzn7BMYBSfhWTDLITuWUi6ZyHpnoWkewEj6ypGodzM
	5OzUosxsvYKMypLUZL2U1E2MoCQgwsC1g7FvjschRiYOxkOMEhzMSiK8y+4vTBPiTUmsrEot
	yo8vKs1JLT7EKM3BoiTOu7ojOFVIID2xJDU7NbUgtQgmy8TBKdXAuPnB/f1t+mslHs9x+ewq
	MfPf52qDfyU7pE7dnllpqZR6fdprVofeF1dcnC9l5x1/0fFKxmFW5R/JCqP2TNmFGddfiaa7
	Xjg2IUXqzSkZ9mqNkGkXnl6U2n/eZuIcr9TA4EdzzANmON+VVdjNPFWxSiFj3b6lUbPzNUJW
	vn2iFu0szlu9eLWwqBJLcUaioRZzUXEiAD277ETwAgAA

T24gMTYuMDcuMjQgMTA6NTEsIEFuZHJlaiBQaWNlaiB3cm90ZToNCj4gTWljcm8gU0QgY2FyZHMg
Y2FuJ3QgYmUgcGh5c2ljYWxseSB3cml0ZS1wcm90ZWN0ZWQgbGlrZSBmdWxsLXNpemVkDQo+IGNh
cmRzLiBEaXNhYmxlIHRoaXMgZmVhdHVyZSBpbiBkZXZpY2UtdHJlZSB0byBnZXQgcmlkIG9mIHRo
ZSBrZXJuZWwNCj4gd2FybmluZzoNCj4NCj4gImhvc3QgZG9lcyBub3Qgc3VwcG9ydCByZWFkaW5n
IHJlYWQtb25seSBzd2l0Y2gsIGFzc3VtaW5nIHdyaXRlLWVuYWJsZSINCj4NCj4gU2lnbmVkLW9m
Zi1ieTogQW5kcmVqIFBpY2VqIDxhbmRyZWoucGljZWpAbm9yaWsuY29tPg0KUmV2aWV3ZWQtYnk6
IEJlbmphbWluIEhhaG4gPEIuSGFobkBwaHl0ZWMuZGU+DQo+IC0tLQ0KPiAgIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLmR0cyB8IDEgKw0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGsuZHRz
IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1y
ZGsuZHRzDQo+IGluZGV4IDAwYTI0MDQ4NGMyNS4uNzkxOTA5ZGNhNmUxIDEwMDY0NA0KPiAtLS0g
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJk
ay5kdHMNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJv
YXJkLXBvbGx1eC1yZGsuZHRzDQo+IEBAIC0yNjcsNiArMjY3LDcgQEAgJnVzZGhjMiB7DQo+ICAg
CXBpbmN0cmwtMSA9IDwmcGluY3RybF91c2RoYzJfMTAwbWh6PiwgPCZwaW5jdHJsX3VzZGhjMl9w
aW5zPjsNCj4gICAJcGluY3RybC0yID0gPCZwaW5jdHJsX3VzZGhjMl8yMDBtaHo+LCA8JnBpbmN0
cmxfdXNkaGMyX3BpbnM+Ow0KPiAgIAljZC1ncGlvcyA9IDwmZ3BpbzIgMTIgR1BJT19BQ1RJVkVf
TE9XPjsNCj4gKwlkaXNhYmxlLXdwOw0KPiAgIAl2bW1jLXN1cHBseSA9IDwmcmVnX3VzZGhjMl92
bW1jPjsNCj4gICAJYnVzLXdpZHRoID0gPDQ+Ow0KPiAgIAlzdGF0dXMgPSAib2theSI7DQoNCg0K

