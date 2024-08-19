Return-Path: <linux-kernel+bounces-291930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DEA956907
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C3C1F22652
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AD0165F17;
	Mon, 19 Aug 2024 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="PhfnTC5t"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159A161328
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065786; cv=none; b=iL+udO2rfpPHwvaCUOhMu8hVKlnsmVBjWzvwZbf6olheoESsQ6zQnCzac9Bpk0FwCbMXhXT+4SwshUboi5acTyeK6VN2hC/008eEZKlxbs14KQfvGqUrUbnS1k2XMm+4ixI3AR/64F8UJxtcAAd4hqXnhuTE37slRLhAQ1J3L7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065786; c=relaxed/simple;
	bh=JYclb++11GGwaFgysyk6lclOhvMATGuF1XxXmAbUVtY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UdZ7JwxnQn9btXZ/GdWoGf90IzxTICq8ckafSgen8C291aButlpXpchy+ApE5jgkUfCF1GJp9K4gV2woh2mUaw27Ai99LxV7zx93IIyIU0TEP2hQ90sewBd+BrI73JJL3Lz6sBdZbM3IPcWLPQSsCN06AOiKEewIFBReB87j6x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=PhfnTC5t; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724065780; x=1726657780;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JYclb++11GGwaFgysyk6lclOhvMATGuF1XxXmAbUVtY=;
	b=PhfnTC5t+N649ZIeXesUMa8LUcc/ysXIHb1hR6uz2QOypaBE6rdHb9hxNxvP+hK7
	GKAMr//GVKo7vwJKyp24HZRGjR+wakRhBRbpeMFQZmQ7aMZlfkHWw/Xedls+w4q2
	28WHSkZaBVSggO7fXSJ+aeaN52zhl8TiOaoy4rMru68=;
X-AuditID: ac14000a-03e52700000021bc-75-66c327f4daf2
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 79.48.08636.4F723C66; Mon, 19 Aug 2024 13:09:40 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 19 Aug
 2024 13:09:40 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 19 Aug 2024 13:09:40 +0200
From: Teresa Remmet <T.Remmet@phytec.de>
To: Yannic Moog <Y.Moog@phytec.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "robh@kernel.org"
	<robh@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: PHYTEC Upstream <upstream@lists.phytec.de>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [Upstream] [PATCH 3/3] arm64: dts: imx8mm-phygate-tauri-l: add
 rtc aux-voltage-chargeable
Thread-Topic: [Upstream] [PATCH 3/3] arm64: dts: imx8mm-phygate-tauri-l: add
 rtc aux-voltage-chargeable
Thread-Index: AQHa7iwq47yBAzB/NkevrL/ryHqTg7IuUrIA
Date: Mon, 19 Aug 2024 11:09:40 +0000
Message-ID: <22a46f85debf6ba52f14f6f89023a4eca9e595e8.camel@phytec.de>
References: <20240814-b4-phytec_imx8m_rtc_updates-v1-0-10f1afc1b3ad@phytec.de>
	 <20240814-b4-phytec_imx8m_rtc_updates-v1-3-10f1afc1b3ad@phytec.de>
In-Reply-To: <20240814-b4-phytec_imx8m_rtc_updates-v1-3-10f1afc1b3ad@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4803DBC4E99094E897A0682EBC88414@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsWyRpKBV/eL+uE0g//7TCzW7D3HZDH/yDlW
	i4dX/S1m3mtls1g1dSeLxctZ99gsNj2+xmpxedccNov/e3awW/zdvonF4sUWcYvud+oOPB47
	Z91l99i0qpPNY/OSeo8Xm2cyevR3t7B69P818Pi8SS6APYrLJiU1J7MstUjfLoErY8KhfawF
	23gqJi3cwtbA2MPTxcjJISFgIjH9w0rWLkYuDiGBJUwSs1/sZodw7jNKzN29ihHC2cAo0d19
	nB2khU1AQ+LliW4mkISIwFMmif9tjWAtzAJrmCR+z77JBlIlLJAh8XjJOSYQW0QgU+Jc5wMW
	CNtIYtHf04wgNouAqsTG4zfA6nkF3CQWP7nHArFuCqNEb+dVsAZOAX+JI4f3gdmMArISGzac
	ZwaxmQXEJTY9+84K8YWAxJI9EHEJAVGJl4//QcXlJU7cmgZ0BAdQvabE+l36EK0WEvvn72eH
	sBUlpnQ/ZIe4QVDi5MwnLBMYxWch2TALoXsWku5ZSLpnIelewMi6ilEoNzM5O7UoM1uvIKOy
	JDVZLyV1EyMo8kUYuHYw9s3xOMTIxMF4iFGCg1lJhLf75cE0Id6UxMqq1KL8+KLSnNTiQ4zS
	HCxK4ryrO4JThQTSE0tSs1NTC1KLYLJMHJxSDYwiIal6SktfnoyP+/BNVmt1evKSdXt2fvPT
	TM9+cLbkYHr6s+cGl1mD5nt7HwpIy/C86e344o2v5YWa42kZEcH8mSKP3jA/llJ4qZbelFzQ
	lLSE5d1OD5n4a6+vWh3c83HHLOUU7XcvFDVepry8c4/nyL3mZH9z3aXnT1Ssvfe4SaAyKO/j
	1x9KLMUZiYZazEXFiQBa2iXE6gIAAA==

QW0gTWl0dHdvY2gsIGRlbSAxNC4wOC4yMDI0IHVtIDExOjI2ICswMjAwIHNjaHJpZWIgWWFubmlj
IE1vb2c6DQo+IHBoeWdhdGUtdGF1cmktbCBoYXMgYSBjaGFyZ2FibGUgY2FwYWNpdG9yIHBvcHVs
YXRlZCwgcnRjIHN1cHBvcnRzDQo+IGNoYXJnaW5nIGl0LiBBZGQgcHJvcGVydHkgaW5kaWNhdGlu
ZyB0aGlzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMu
ZGU+DQoNClJldmlld2VkLWJ5OiBUZXJlc2EgUmVtbWV0IDx0LnJlbW1ldEBwaHl0ZWMuZGU+DQoN
Cj4gLS0tDQo+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXBoeWdhdGUt
dGF1cmktbC5kdHMgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tcGh5
Z2F0ZS10YXVyaS1sLmR0cw0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
bS1waHlnYXRlLXRhdXJpLWwuZHRzDQo+IGluZGV4IGJhNmNlM2M3ZjQ3Ny4uYzM4MzViMmQ4NjBh
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tcGh5
Z2F0ZS10YXVyaS1sLmR0cw0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW0tcGh5Z2F0ZS10YXVyaS1sLmR0cw0KPiBAQCAtMjE1LDYgKzIxNSw3IEBAICZwd200IHsN
Cj4gwqANCj4gwqAvKiBSVEMgKi8NCj4gwqAmcnYzMDI4IHsNCj4gK8KgwqDCoMKgwqDCoMKgYXV4
LXZvbHRhZ2UtY2hhcmdlYWJsZSA9IDwxPjsNCj4gwqDCoMKgwqDCoMKgwqDCoHRyaWNrbGUtcmVz
aXN0b3Itb2htcyA9IDwzMDAwPjsNCj4gwqB9Ow0KPiDCoA0KPiANCg0KLS0gDQpQSFlURUMgTWVz
c3RlY2huaWsgR21iSCB8IEJhcmNlbG9uYS1BbGxlZSAxIHwgNTUxMjkgTWFpbnosIEdlcm1hbnkN
Cg0KR2VzY2jDpGZ0c2bDvGhyZXI6IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1J
bmcuIEJvZG8gSHViZXIsDQpEaXBsLi1JbmcuIChGSCkgTWFya3VzIExpY2tlcyB8IEhhbmRlbHNy
ZWdpc3RlciBNYWlueiBIUkIgNDY1NiB8DQpGaW5hbnphbXQgTWFpbnogfCBTdC5Oci4gMjY2NTAw
NjA4LCBERSAxNDkwNTk4NTUNCg==

