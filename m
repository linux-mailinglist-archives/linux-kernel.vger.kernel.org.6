Return-Path: <linux-kernel+bounces-275860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347E7948B27
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D931C22AE5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E161BD00D;
	Tue,  6 Aug 2024 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="pJXYDJ+2"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ECA3C092
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722932488; cv=none; b=U7mV9DfwKdWH0wVENORJNIBFcQWuoYVYlNpbwgI/vlvxyExG4bcRNglUgZ9aNBkeOjLKkHACOOhzULsOyh5SPY2VOYo+ZEbG33jImQgk+3NaPmZPx7HZQIFY6Dmwrxzc4h/Q786/gXzonMW2nxbuxAIVmbHu0vn+nXPTnDDz+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722932488; c=relaxed/simple;
	bh=syvyItGOW35lUwEWTUTsWPkkLzz5x+BGqu6NrURaHm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N0C3ICShVZ5YpPkJ7izGX9VVW7ecvtZuW+N12YbSOJAedAAns4kXxmV6bHlI6tu+GZBahYZQaRnnllfX+Gu/W3fcdnjVNv8xt0uvVLsuT+VKS01+lr1GtR/9pv44okl9UI1icAUuxixmqaeTLmyl8AAtkAEv6MWn/0wnFOlRYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=pJXYDJ+2; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1722932480; x=1725524480;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=syvyItGOW35lUwEWTUTsWPkkLzz5x+BGqu6NrURaHm0=;
	b=pJXYDJ+2BgGkz/w0Vu6xFvViR/RyVPf7R/Fuh3h0GfaWKII+uXucj+w6SbMmEXqF
	mLrlUjVjk3jIBFXef4cPXGwLQINkCwcmMZ3xDLcLfcryQnMAuW+jDeUIvIKmPshB
	vYwcmMMIHBIBGhxBkDM82+dLG3a3jSZO+7EhtRis83w=;
X-AuditID: ac14000a-03251700000021bc-7c-66b1dcff91c9
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 7D.AD.08636.FFCD1B66; Tue,  6 Aug 2024 10:21:19 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 6 Aug 2024
 10:21:19 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Tue, 6 Aug 2024 10:21:19 +0200
From: Teresa Remmet <T.Remmet@phytec.de>
To: "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"robh@kernel.org" <robh@kernel.org>, "Frank.Li@nxp.com" <Frank.Li@nxp.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 9/9] arm64: dts: imx8mm-phygate: fix typo pinctrcl-0
Thread-Topic: [PATCH 9/9] arm64: dts: imx8mm-phygate: fix typo pinctrcl-0
Thread-Index: AQHa51ALGyMcVFYDTkWcFys00cmECrIZwxEA
Date: Tue, 6 Aug 2024 08:21:19 +0000
Message-ID: <9e87a9fda253e05740b0ba19f8f20eab6541d656.camel@phytec.de>
References: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
	 <20240805-fsl_dts_warning-v1-9-055653dd5c96@nxp.com>
In-Reply-To: <20240805-fsl_dts_warning-v1-9-055653dd5c96@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <173A460F69243844AED75BAB8F7EB062@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsWyRpKBR/f/nY1pBg1TjSzW7D3HZDH/yDlW
	i4dX/S3avuxksph5r5XNYtXUnSwWL2fdY7PY9Pgaq8XlXXPYLP7v2cFu8Xf7JhaLF1vEHXg8
	ds66y+6xaVUnm8fmJfUeLzbPZPTY+G4Hk0f/XwOPz5vkAtijuGxSUnMyy1KL9O0SuDLWP9jM
	VHBFquLZn8AGxj+SXYycHBICJhLd1+exdzFycQgJLGGS+Hj7BguEc49R4su6m4wQznpGiR8N
	j5hAWtgENCRenuhmAkmICLxikvh+7SUbiMMs0MAksXTiGVaQKmEBD4nVyzYygtgiAp4SW64s
	B4pzANlGEvuvZ4KEWQRUJBY8b2cBsXkF3CQuX7sBtkBIoEJi1rYtzCA2p4CjxKvPa9hBbEYB
	WYkNG86DxZkFxCU2PfvOCvGDgMSSPRBxCQFRiZeP/0HF5SVO3JrGBLKWWUBTYv0ufYhWC4nj
	7yFWMQsoSkzpfsgOcYKgxMmZT1gmMIrPQrJhFkL3LCTds5B0z0LSvYCRdRWjUG5mcnZqUWa2
	XkFGZUlqsl5K6iZGUNSLMHDtYOyb43GIkYmD8RCjBAezkghvV+mGNCHelMTKqtSi/Pii0pzU
	4kOM0hwsSuK8qzuCU4UE0hNLUrNTUwtSi2CyTBycUg2MkVefeFl8j7MxvvR5yqtAyWk/lfLr
	LgW/Oxmn0Ki79uGFNGHLBSrnjv+W97zH7r379cULot8jb6yYcdf18bvb7xalXPR8eHBPq9nV
	fJvZTWwPrA3X5nK9XV227oftwyTBTXZ6Z7I5tjLpWm08p5RVVW7oMZk55dcBRc7aO6pFjxcq
	he6tmO41U4mlOCPRUIu5qDgRAKRa87DoAgAA

QW0gTW9udGFnLCBkZW0gMDUuMDguMjAyNCB1bSAxMTo0OSAtMDQwMCBzY2hyaWViIEZyYW5rIExp
Og0KPiBGaXggdHlwbyBwaW5jdHJjbC0wIHdpdGggcGluY3RybC0wLg0KPiBGaXggYmVsb3cgd2Fy
bmluZzoNCj4gDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHlnYXRl
LXRhdXJpLWwtcnMyMzItcnM0ODUuZHRiOg0KPiBncGlvQDMwMjIwMDAwOiAncGluY3RybC0wJyBp
cyBhIGRlcGVuZGVuY3kgb2YgJ3BpbmN0cmwtbmFtZXMnDQo+IMKgwqDCoMKgwqDCoMKgIGZyb20g
c2NoZW1hICRpZDoNCj4gaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcGluY3RybC9waW5j
dHJsLWNvbnN1bWVyLnlhbWwjDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
bS1waHlnYXRlLXRhdXJpLWwtcnMyMzItcnM0ODUuZHRiOg0KPiB1YXJ0NF9yczQ4NV9lbjogJG5v
ZGVuYW1lOjA6ICd1YXJ0NF9yczQ4NV9lbicgZG9lcyBub3QgbWF0Y2ggJ14oaG9nLQ0KPiBbMC05
XSt8ListaG9nKC1bMC05XSspPykkDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBMaSA8RnJh
bmsuTGlAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFRlcmVzYSBSZW1tZXQgPHQucmVtbWV0QHBo
eXRlYy5kZT4NCg0KVGhhbmtzIGZvciBmaXhpbmcgdGhpcy4NCg0KVGVyZXNhDQoNCj4gLS0tDQo+
IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXBoeWdhdGUtdGF1cmktbC1y
czIzMi0NCj4gcnMyMzIuZHRzbyB8IDIgKy0NCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLXJzMjMyLQ0KPiByczQ4NS5kdHNvIHwgMiArLQ0K
PiDCoDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHln
YXRlLXRhdXJpLWwtDQo+IHJzMjMyLXJzMjMyLmR0c28gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bW0tcGh5Z2F0ZS0NCj4gdGF1cmktbC1yczIzMi1yczIzMi5kdHNvDQo+IGlu
ZGV4IGYyNDZiMGJhNmFmMjkuLmNlMTk3MjY2MjYyYTUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHlnYXRlLXRhdXJpLWwtcnMyMzItDQo+IHJz
MjMyLmR0c28NCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXBo
eWdhdGUtdGF1cmktbC1yczIzMi0NCj4gcnMyMzIuZHRzbw0KPiBAQCAtMjIsNyArMjIsNyBAQA0K
PiDCoA0KPiDCoCZncGlvMyB7DQo+IMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsLW5hbWVzID0gImRl
ZmF1bHQiOw0KPiAtwqDCoMKgwqDCoMKgwqBwaW5jdHJjbC0wID0gPCZwaW5jdHJsX2dwaW8zX2hv
Zz47DQo+ICvCoMKgwqDCoMKgwqDCoHBpbmN0cmwtMCA9IDwmcGluY3RybF9ncGlvM19ob2c+Ow0K
PiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgdWFydDRfcnM0ODVfZW4gew0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdwaW8taG9nOw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXBoeWdhdGUtdGF1cmktbC0NCj4gcnMyMzItcnM0ODUu
ZHRzbyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHlnYXRlLQ0KPiB0
YXVyaS1sLXJzMjMyLXJzNDg1LmR0c28NCj4gaW5kZXggNjc1MDhjYTE0Mjc2Zi4uZjJhNzgxMWYx
YjlmMiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1t
LXBoeWdhdGUtdGF1cmktbC1yczIzMi0NCj4gcnM0ODUuZHRzbw0KPiArKysgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLXJzMjMyLQ0KPiByczQ4
NS5kdHNvDQo+IEBAIC0yMyw3ICsyMyw3IEBADQo+IMKgDQo+IMKgJmdwaW8zIHsNCj4gwqDCoMKg
wqDCoMKgwqDCoHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+IC3CoMKgwqDCoMKgwqDCoHBp
bmN0cmNsLTAgPSA8JnBpbmN0cmxfZ3BpbzNfaG9nPjsNCj4gK8KgwqDCoMKgwqDCoMKgcGluY3Ry
bC0wID0gPCZwaW5jdHJsX2dwaW8zX2hvZz47DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqB1YXJ0
NF9yczQ4NV9lbiB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ3Bpby1ob2c7
DQo+IA0KDQotLSANClBIWVRFQyBNZXNzdGVjaG5payBHbWJIIHwgQmFyY2Vsb25hLUFsbGVlIDEg
fCA1NTEyOSBNYWlueiwgR2VybWFueQ0KDQpHZXNjaMOkZnRzZsO8aHJlcjogRGlwbC4tSW5nLiBN
aWNoYWVsIE1pdGV6a2ksIERpcGwuLUluZy4gQm9kbyBIdWJlciwNCkRpcGwuLUluZy4gKEZIKSBN
YXJrdXMgTGlja2VzIHwgSGFuZGVsc3JlZ2lzdGVyIE1haW56IEhSQiA0NjU2IHwNCkZpbmFuemFt
dCBNYWlueiB8IFN0Lk5yLiAyNjY1MDA2MDgsIERFIDE0OTA1OTg1NQ0K

