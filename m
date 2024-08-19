Return-Path: <linux-kernel+bounces-291929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9590956905
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D57D2831D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1D1165F14;
	Mon, 19 Aug 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="hEiVY8tE"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8FE2209F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065772; cv=none; b=b0EzvL3DZJKeO2G2XLa1ohrfdp919FBfblgAhY5y3wzA4DAB3ZmO4n0lzcdFXtxXWxePYjDvg5x9d1qmU7lKtsg4GZsV3xEfw4Bt0pfklcJ2UMgCC5d+JT951h0OfiRx5nBNepUvoJIZj6WwkR4B2LuadomScByh2cMH3CoXAfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065772; c=relaxed/simple;
	bh=SIfz6w4rvfUpTygTD3R1js33NxatjGlCypHsvF7JziY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qd/M1nAR5OgHDRvW8dnXnOPQi+Xxxf/BQSEeI/rLQv4qcQ8tgcTmxNKCowIqMsHnmADVmi6Bz117IOcPOQKYEtm4I9WKWSX7k3ir+SNy3vq2RxW6AZ+QRIX5/RYdPHfn2Vf5VtwAB6TTaWLGd4ZEUDC350+j6DKAA9R9hgTDCRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=hEiVY8tE; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724065766; x=1726657766;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SIfz6w4rvfUpTygTD3R1js33NxatjGlCypHsvF7JziY=;
	b=hEiVY8tENE97NiQy05EYOjwWfOo9+ecu9B23IcpJ8ProAtX6BI/meFLggnwcC4Wn
	WliWVMf4MusmOk6Lju0LdMjmYxD2Q7ghCkeKHrxTLpmsaLR9vOdgLfF2AQPUIq0E
	FsEtEFq9FQVwIxDQqEFawnKmtpj9geGW4O5cQnabqiA=;
X-AuditID: ac14000a-03e52700000021bc-71-66c327e6d412
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 67.48.08636.6E723C66; Mon, 19 Aug 2024 13:09:26 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 19 Aug
 2024 13:09:26 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 19 Aug 2024 13:09:26 +0200
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
Subject: Re: [Upstream] [PATCH 2/3] arm64: dts: imx8mm-phyboard-polis: add rtc
 aux-voltage-chargeable
Thread-Topic: [Upstream] [PATCH 2/3] arm64: dts: imx8mm-phyboard-polis: add
 rtc aux-voltage-chargeable
Thread-Index: AQHa7iwqBdLbd4dsxkO3yHAKTbtnobIuUqCA
Date: Mon, 19 Aug 2024 11:09:26 +0000
Message-ID: <e2364cb43cf5afa56d78f0738c3220182457b85a.camel@phytec.de>
References: <20240814-b4-phytec_imx8m_rtc_updates-v1-0-10f1afc1b3ad@phytec.de>
	 <20240814-b4-phytec_imx8m_rtc_updates-v1-2-10f1afc1b3ad@phytec.de>
In-Reply-To: <20240814-b4-phytec_imx8m_rtc_updates-v1-2-10f1afc1b3ad@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <53A171A80933584EA74A41F4907203A3@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsWyRpKBR/eZ+uE0g1PvJSzW7D3HZDH/yDlW
	i4dX/S1m3mtls1g1dSeLxctZ99gsNj2+xmpxedccNov/e3awW/zdvonF4sUWcYvud+oOPB47
	Z91l99i0qpPNY/OSeo8Xm2cyevR3t7B69P818Pi8SS6APYrLJiU1J7MstUjfLoErY9OUd+wF
	x3gqntybwdLAOIeni5GTQ0LARGLO5jPMXYxcHEICS5gkjm/rYwVJCAncZ5Q4/6oQIrGBUWLx
	ltXMIAk2AQ2Jlye6mUASIgJPmST+tzWygzjMAmuYJH7PvskGUiUskC5xYP1eoCoOoKoMiVcP
	DUDCIgJGEn0djxhBbBYBVYl91/rAbF4BN4knG9ayQ2ybwiixducedpAEp4C/xKn3p8A2MwrI
	SmzYcB7MZhYQl9j07DsrxA8CEkv2QMQlBEQlXj7+BxWXlzhxaxrYDcwCmhLrd+lDtFpIfD96
	ggnCVpSY0v2QHeIGQYmTM5+wTGAUn4VkwyyE7llIumch6Z6FpHsBI+sqRqHczOTs1KLMbL2C
	jMqS1GS9lNRNjKCoF2Hg2sHYN8fjECMTB+MhRgkOZiUR3u6XB9OEeFMSK6tSi/Lji0pzUosP
	MUpzsCiJ867uCE4VEkhPLEnNTk0tSC2CyTJxcEo1MC4xjWKqWprb3PB7g7rWlfUPG/MZVa5e
	f2PIK5x5t3N/5PvazDg9H/lHcwoWVS82K4/TOz834RbTTOfWhdnLin8x+D+YePwe36tXzFtF
	cibe3Lptw0XGj02r6kxjiup0l0XeCmeReJ46S71B1Ppf6umvbCIfgvP/d1r+bb5nKysou3jq
	549PLimxFGckGmoxFxUnAgDPkp2T6AIAAA==

QW0gTWl0dHdvY2gsIGRlbSAxNC4wOC4yMDI0IHVtIDExOjI2ICswMjAwIHNjaHJpZWIgWWFubmlj
IE1vb2c6DQo+IHBoeWJvYXJkLXBvbGlzIGhhcyBhIGNoYXJnYWJsZSBjYXBhY2l0b3IgcG9wdWxh
dGVkLCBydGMgc3VwcG9ydHMNCj4gY2hhcmdpbmcgaXQuIEFkZCBwcm9wZXJ0eSBpbmRpY2F0aW5n
IHRoaXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5uaWMgTW9vZyA8eS5tb29nQHBoeXRlYy5k
ZT4NCg0KUmV2aWV3ZWQtYnk6IFRlcmVzYSBSZW1tZXQgPHQucmVtbWV0QHBoeXRlYy5kZT4NCg0K
PiAtLS0NCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tcGh5Ym9hcmQt
cG9saXMtcmRrLmR0cyB8IDEgKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1w
aHlib2FyZC1wb2xpcy0NCj4gcmRrLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtbS1waHlib2FyZC1wb2xpcy1yZGsuZHRzDQo+IGluZGV4IDkyZTYyZmUzMTkyOS4uNWVh
Y2JkOTYxMWVlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW0tcGh5Ym9hcmQtcG9saXMtcmRrLmR0cw0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bW0tcGh5Ym9hcmQtcG9saXMtcmRrLmR0cw0KPiBAQCAtMjIwLDYgKzIy
MCw3IEBAICZwY2llX3BoeSB7DQo+IMKgfTsNCj4gwqANCj4gwqAmcnYzMDI4IHsNCj4gK8KgwqDC
oMKgwqDCoMKgYXV4LXZvbHRhZ2UtY2hhcmdlYWJsZSA9IDwxPjsNCj4gwqDCoMKgwqDCoMKgwqDC
oHRyaWNrbGUtcmVzaXN0b3Itb2htcyA9IDwzMDAwPjsNCj4gwqB9Ow0KPiDCoA0KPiANCg0KLS0g
DQpQSFlURUMgTWVzc3RlY2huaWsgR21iSCB8IEJhcmNlbG9uYS1BbGxlZSAxIHwgNTUxMjkgTWFp
bnosIEdlcm1hbnkNCg0KR2VzY2jDpGZ0c2bDvGhyZXI6IERpcGwuLUluZy4gTWljaGFlbCBNaXRl
emtpLCBEaXBsLi1JbmcuIEJvZG8gSHViZXIsDQpEaXBsLi1JbmcuIChGSCkgTWFya3VzIExpY2tl
cyB8IEhhbmRlbHNyZWdpc3RlciBNYWlueiBIUkIgNDY1NiB8DQpGaW5hbnphbXQgTWFpbnogfCBT
dC5Oci4gMjY2NTAwNjA4LCBERSAxNDkwNTk4NTUNCg==

