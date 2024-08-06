Return-Path: <linux-kernel+bounces-275863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7680948B38
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E048285589
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60FC1BD00D;
	Tue,  6 Aug 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="GoiMGeS2"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD073C092
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722932708; cv=none; b=HBBtnDxeBZgQHr/00ydBAMLvHVuvP55Bk98XjuMjNbyy+/6SjNMMujuFDCCnCfCdjJ5pTXzS4054CAF7bgrylXJxhY7gtrsH/P7loS8VeemSckpNYvWwPn+1Avz61AcNQKZi2haX0Fq4DP+r5NwwQFDbM3faD9cJyZqitT8XkEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722932708; c=relaxed/simple;
	bh=h8D1nt+xIM5Af7tNSx7i7SKz4hL10tcGcm45Tt6J20E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dHUDei37kCPHfCtQ952QYL58z4M+TWr2DqaeZ2jZD2O7TmE4+bLkfUjQAIGrX9JLyj4m7JpMIALY0vR6PKOvDe0Lwd28cf5C7WyHfFvz2Tqa0PCUdznnLRGJvCIjaZpzjVNQJ4uK+jQjoXjmb20uy9VoL6V8dLvuIZOTKce3Ryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=GoiMGeS2; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1722932704; x=1725524704;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h8D1nt+xIM5Af7tNSx7i7SKz4hL10tcGcm45Tt6J20E=;
	b=GoiMGeS2GqxqDckxPwz2mmeOLTG+zfvr0u4jYxhgMosTvaGiLLukMlZJrwdgcTbH
	d2AVUC52Bdqs7sYyJLMnqQd3sTEFa/FDSt0ucV8eTsBuWwCHYDu/MDoI+jT2Sj7L
	Xvp05hGOpp+Y9cNY2M9AxFFdCnfyBm+fVbODzxzuckM=;
X-AuditID: ac14000a-03e52700000021bc-bd-66b1dde057a9
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 74.BD.08636.0EDD1B66; Tue,  6 Aug 2024 10:25:04 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 6 Aug 2024
 10:25:03 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Tue, 6 Aug 2024 10:25:03 +0200
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
Subject: Re: [PATCH 8/9] arm64: dts: imx8mm: Add fallback compatible string
 fsl,imx8mm
Thread-Topic: [PATCH 8/9] arm64: dts: imx8mm: Add fallback compatible string
 fsl,imx8mm
Thread-Index: AQHa50/260XBs3iG5kKSaB0JsnnMjbIZxB6A
Date: Tue, 6 Aug 2024 08:25:03 +0000
Message-ID: <051cd6a11250b277eb1ac2e5fade36c21026ab3a.camel@phytec.de>
References: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
	 <20240805-fsl_dts_warning-v1-8-055653dd5c96@nxp.com>
In-Reply-To: <20240805-fsl_dts_warning-v1-8-055653dd5c96@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <DED360978B75E24FBE8B0663E5A558DD@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsWyRpKBV/fB3Y1pBg83c1us2XuOyWL+kXOs
	Fg+v+lu0fdnJZDHzXiubxaqpO1ksXs66x2ax6fE1VovLu+awWfzfs4Pd4u/2TSwWL7aIO/B4
	7Jx1l91j06pONo/NS+o9Xmyeyeix8d0OJo/+vwYenzfJBbBHcdmkpOZklqUW6dslcGVsvHSf
	qeCefMWqbz/YGhi/yHUxcnJICJhIPJs1kx3EFhJYwiQx+QF/FyMXkH2PUaL/x2wmCGc9o8SK
	A90sIFVsAhoSL090gyVEBF4xSXy/9pINxGEWaGCSWDrxDCtIlbBAhMShto3MILaIQKTErbnn
	WCFsI4mVO1+xgdgsAioS75+1gtXwCrhJbH74kg3ijgqJe/s3g93EKeAo0bxhIyOIzSggK7Fh
	w3mwemYBcYlNz76zQvwgILFkD0RcQkBU4uXjf1BxeYkTt6YBXcoBVK8psX6XPoRpIfFiSRDE
	FEWJKd0P2SEuEJQ4OfMJywRG8VlIFsxCaJ6F0DwLSfMsJM0LGFlXMQrlZiZnpxZlZusVZFSW
	pCbrpaRuYgTFvAgD1w7GvjkehxiZOBgPMUpwMCuJ8HaVbkgT4k1JrKxKLcqPLyrNSS0+xCjN
	waIkzru6IzhVSCA9sSQ1OzW1ILUIJsvEwSnVwGiklpl160PsfkfLVz5NzxLbZV9fneEg+22R
	qJCQ3kMrnqvTNjqey3rFJqL8I1hg2emUB2+j9e66WxVGhDRK7Ex4opl0beorh2YFfjlDj7OX
	fjjEHdkatXTH6wjTtZKern8M7fwlX0T49z+1yH+yKq+sYtlOndqd5+/Fv3qoalQUtGXiUmfH
	eCWW4oxEQy3mouJEAMZ0TgjnAgAA

SGVsbG8gRnJhbmssDQoNCkFtIE1vbnRhZywgZGVtIDA1LjA4LjIwMjQgdW0gMTE6NDkgLTA0MDAg
c2NocmllYiBGcmFuayBMaToNCj4gQWRkIGZhbGxiYWNrIGNvbXBhdGlibGUgc3RyaW5nIGlteDht
bS1waHlnYXRlIHRvIGZpeCBiZWxvdyB3YXJuaW5nOg0KPiAncGh5dGVjLGlteDhtbS1waHlnYXRl
LXRhdXJpLWwnIGlzIG5vdCBvbmUgb2YgWydhcm1hZGV1cyxpbXgxLQ0KPiBhcGY5MzI4JywgJ2Zz
bCxpbXgxYWRzJ10NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAu
Y29tPg0KPiAtLS0NCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tcGh5
Z2F0ZS10YXVyaS1sLXJzMjMyLQ0KPiByczIzMi5kdHNvwqAgfCAzICsrLQ0KPiDCoGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHlnYXRlLXRhdXJpLWwtcnMyMzItDQo+IHJz
NDg1LmR0c2/CoCB8IDMgKystDQo+IMKgLi4uL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bW0tcGh5Z2F0ZS10YXVyaS1sLXJzMjMyLXJ0cy0NCj4gY3RzLmR0c28gfCAzICsrLQ0KPiDCoDMg
ZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHlnYXRlLXRh
dXJpLWwtDQo+IHJzMjMyLXJzMjMyLmR0c28gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bW0tcGh5Z2F0ZS0NCj4gdGF1cmktbC1yczIzMi1yczIzMi5kdHNvDQo+IGluZGV4IGJm
M2UwNDY1MWJhMDAuLmYyNDZiMGJhNmFmMjkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHlnYXRlLXRhdXJpLWwtcnMyMzItDQo+IHJzMjMyLmR0
c28NCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXBoeWdhdGUt
dGF1cmktbC1yczIzMi0NCj4gcnMyMzIuZHRzbw0KPiBAQCAtMTUsNyArMTUsOCBAQA0KPiDCoC9w
bHVnaW4vOw0KPiDCoA0KPiDCoCZ7L30gew0KPiAtwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0g
InBoeXRlYyxpbXg4bW0tcGh5Z2F0ZS10YXVyaS1sIjsNCj4gK8KgwqDCoMKgwqDCoMKgY29tcGF0
aWJsZSA9ICJwaHl0ZWMsaW14OG1tLXBoeWdhdGUtdGF1cmktbCIsDQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAicGh5dGVjLGlteDhtbS1waHljb3JlLXNvbSIsICJm
c2wsaW14OG1tIjsNCg0Kc2hvdWxkIHRoZSBjb21wYXRpYmxlIG5vdCBiZXR0ZXIgYmUgcmVtb3Zl
ZCBmb3Igb3ZlcmxheXM/DQoNClJlZ2FyZHMsDQpUZXJlc2ENCg0KPiDCoA0KPiDCoH07DQo+IMKg
DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tcGh5
Z2F0ZS10YXVyaS1sLQ0KPiByczIzMi1yczQ4NS5kdHNvIGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1tLXBoeWdhdGUtDQo+IHRhdXJpLWwtcnMyMzItcnM0ODUuZHRzbw0KPiBp
bmRleCBmNDQ0OGNkZTA0MDdjLi42NzUwOGNhMTQyNzZmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLXJzMjMyLQ0KPiBy
czQ4NS5kdHNvDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1w
aHlnYXRlLXRhdXJpLWwtcnMyMzItDQo+IHJzNDg1LmR0c28NCj4gQEAgLTE2LDcgKzE2LDggQEAN
Cj4gwqAvcGx1Z2luLzsNCj4gwqANCj4gwqAmey99IHsNCj4gLcKgwqDCoMKgwqDCoMKgY29tcGF0
aWJsZSA9ICJwaHl0ZWMsaW14OG1tLXBoeWdhdGUtdGF1cmktbCI7DQo+ICvCoMKgwqDCoMKgwqDC
oGNvbXBhdGlibGUgPSAicGh5dGVjLGlteDhtbS1waHlnYXRlLXRhdXJpLWwiLA0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInBoeXRlYyxpbXg4bW0tcGh5Y29yZS1z
b20iLCAiZnNsLGlteDhtbSI7DQo+IMKgDQo+IMKgfTsNCj4gwqANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHlnYXRlLXRhdXJpLWwtDQo+IHJz
MjMyLXJ0cy1jdHMuZHRzbyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1w
aHlnYXRlLQ0KPiB0YXVyaS1sLXJzMjMyLXJ0cy1jdHMuZHRzbw0KPiBpbmRleCAxMDdmNzQzZmJi
MWMzLi43MTRlMjJjY2I5YzY0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLXJzMjMyLXJ0cy0NCj4gY3RzLmR0c28NCj4g
KysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXBoeWdhdGUtdGF1cmkt
bC1yczIzMi1ydHMtDQo+IGN0cy5kdHNvDQo+IEBAIC0xNiw3ICsxNiw4IEBADQo+IMKgDQo+IMKg
DQo+IMKgJnsvfSB7DQo+IC3CoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAicGh5dGVjLGlteDht
bS1waHlnYXRlLXRhdXJpLWwiOw0KPiArwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gInBoeXRl
YyxpbXg4bW0tcGh5Z2F0ZS10YXVyaS1sIiwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICJwaHl0ZWMsaW14OG1tLXBoeWNvcmUtc29tIiwgImZzbCxpbXg4bW0iOw0K
PiDCoA0KPiDCoH07DQo+IMKgDQo+IA0KDQotLSANClBIWVRFQyBNZXNzdGVjaG5payBHbWJIIHwg
QmFyY2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBNYWlueiwgR2VybWFueQ0KDQpHZXNjaMOkZnRzZsO8
aHJlcjogRGlwbC4tSW5nLiBNaWNoYWVsIE1pdGV6a2ksIERpcGwuLUluZy4gQm9kbyBIdWJlciwN
CkRpcGwuLUluZy4gKEZIKSBNYXJrdXMgTGlja2VzIHwgSGFuZGVsc3JlZ2lzdGVyIE1haW56IEhS
QiA0NjU2IHwNCkZpbmFuemFtdCBNYWlueiB8IFN0Lk5yLiAyNjY1MDA2MDgsIERFIDE0OTA1OTg1
NQ0K

