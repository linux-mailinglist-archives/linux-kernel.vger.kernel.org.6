Return-Path: <linux-kernel+bounces-291712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E6E9565CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58867285367
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A2915B552;
	Mon, 19 Aug 2024 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="PEIpUvst"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6915B13B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056930; cv=none; b=HgERzdSz1f+bQOfiN5f89atCFyK5g7xtNP19Aft9atesWCcbrObS/Bq958YvAvfGXg3wDoGzl5arUegTZXZJoJOooIFSUKO5jCGHeq4XoNAG7hR8ZDY92YCQmh78Xb2cza+e1SbuQPP9Md/4wB+eJZLLd3SUzSl3YgKeCKq2H7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056930; c=relaxed/simple;
	bh=1yA/mZbGAOty4Qp+W85rMw9ZhH3Dt00iJEVQ5wC8PVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uYg2Qz4O4aheg6A63zC96lMQcGSh4MKfy7knQh7LMRTpa7CzuYcX1xrd0FrQFCOhC7ACiWm225Hmv0hPv1Vd+hxIJiq4q9E04vY4U+KZ1/rEgLxetXAWtjExVuPE7E2L+eGQrmab4pmElBW+wSa+3BkOlWbFCI0mYBbnayfWsIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=PEIpUvst; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724056926; x=1726648926;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1yA/mZbGAOty4Qp+W85rMw9ZhH3Dt00iJEVQ5wC8PVs=;
	b=PEIpUvst8ZYo5w+05Sw1eVxTphDorS1DYs8VJg3sD4d6Ed3DHCwrModrcuX63Ydl
	fyPF4cF8oXqUNcwEhBs7djzMbQMINJitcqYhErUpb8FEUfGpITqnmUYJCGotqVPT
	AynYObuHYE5ooPXBr1RL0vzm3PWpzuYlBEiHPVJt2dY=;
X-AuditID: ac14000a-03251700000021bc-83-66c3055ed8b8
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 22.37.08636.E5503C66; Mon, 19 Aug 2024 10:42:06 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 19 Aug
 2024 10:42:06 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 19 Aug 2024 10:42:06 +0200
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
Subject: Re: [PATCH 1/6] arm64: dts: imx8mp-phycore: Add VDD_IO regulator
Thread-Topic: [PATCH 1/6] arm64: dts: imx8mp-phycore: Add VDD_IO regulator
Thread-Index: AQHa7iwROvHt+W4v40iHLuEIlmiogrIuKXeA
Date: Mon, 19 Aug 2024 08:42:06 +0000
Message-ID: <283d8090f358c6343c126fbac77462e19bdc7b74.camel@phytec.de>
References: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-0-e2500950c632@phytec.de>
	 <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-1-e2500950c632@phytec.de>
In-Reply-To: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-1-e2500950c632@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED2F2E5DFA68DB459FA192BB807FEB24@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWyRpKBRzeO9XCawcFZyhZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPF4uWse2wWmx5fY7W4vGsOm8X/PTvYLf5u38Ri8WKLuEX3O3UHHo+d
	s+6ye2xa1cnmsXlJvceLzTMZPfq7W1g9+v8aeHzeJBfAHsVlk5Kak1mWWqRvl8CVcaavjalg
	Bm/F53N3WRsY3/B0MXJwSAiYSHx9q9fFyMUhJLCESWL7po2MEM59Rokrm7azQDgbGCVar78A
	ynBysAmoSJyccQmsSkTgJZPE4qnfwRxmgb9MEk9/gTgcHMICnhKnXsmBNIgIeEnM/PiaGcI2
	kvg9o58NxGYRUJXYe+In2FBeATeJyxu2s4PYQgL7GCUWX/EFsTkFUiQmL50EVsMoICuxYcN5
	sDnMAuISm559ZwWxJQQEJJbsgYhLCIhKvHz8DyouL3Hi1jQmkHOYBTQl1u/ShzAtJD7Pi4GY
	oigxpfshO8QFghInZz5hmcAoPgvJglkIzbMQmmchaZ6FpHkBI+sqRqHczOTs1KLMbL2CjMqS
	1GS9lNRNjKB4F2Hg2sHYN8fjECMTB+MhRgkOZiUR3u6XB9OEeFMSK6tSi/Lji0pzUosPMUpz
	sCiJ867uCE4VEkhPLEnNTk0tSC2CyTJxcEo1MGq+nMN4Xdz2S574ZT6xmR+lVAz/TRHQ+NuX
	Ju9+SU9MOvuseeiepu89U6LtFq/4HZg3Y2LAX7++A40Xm+OKvj9JrPY7J10T8ED10UqTxRlX
	Z1s5Z8xMMtF+MvPUU8ncdMEj21vfPGv/e5nnbiuvj4tQs5qd9baUO4eLC45phB2aYfgmaPHG
	OCWW4oxEQy3mouJEAHJQoqHlAgAA

T24gV2VkLCAyMDI0LTA4LTE0IGF0IDExOjI2ICswMjAwLCBUZXJlc2EgUmVtbWV0IHdyb3RlOg0K
PiBGcm9tOiBZYXNod2FudGggVmFyYWthbGEgPHkudmFyYWthbGFAcGh5dGVjLmRlPg0KPiANCj4g
QWRkIGZpeGVkIHJlZ3VsYXRvciBWRERfSU8gKDMuM3YpIGJhc2VkIG9uIHRoZSBTb00gc2NoZW1h
dGljcyB0byByZWZsZWN0DQo+IHRoZSBjb25uZWN0aXZpdHkgb24gdGhlIHBoeUNPUkUtaS5NWDhN
UC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhc2h3YW50aCBWYXJha2FsYSA8eS52YXJha2FsYUBw
aHl0ZWMuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IFRlcmVzYSBSZW1tZXQgPHQucmVtbWV0QHBoeXRl
Yy5kZT4NClJldmlld2VkLWJ5OiBZYW5uaWMgTW9vZyA8eS5tb29nQHBoeXRlYy5kZT4NCg0KPiAt
LS0NCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Y29yZS1zb20u
ZHRzaSB8IDkgKysrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1w
aHljb3JlLXNvbS5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1w
LXBoeWNvcmUtc29tLmR0c2kNCj4gaW5kZXggZTZmZmE2YTZiNjhiLi45YzUyNzJjNjkzMWEgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHljb3Jl
LXNvbS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1w
aHljb3JlLXNvbS5kdHNpDQo+IEBAIC0yMCw2ICsyMCwxNSBAQCBtZW1vcnlANDAwMDAwMDAgew0K
PiDCoAkJZGV2aWNlX3R5cGUgPSAibWVtb3J5IjsNCj4gwqAJCXJlZyA9IDwweDAgMHg0MDAwMDAw
MCAwIDB4ODAwMDAwMDA+Ow0KPiDCoAl9Ow0KPiArDQo+ICsJcmVnX3ZkZF9pbzogcmVndWxhdG9y
LXZkZC1pbyB7DQo+ICsJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4gKwkJcmVn
dWxhdG9yLWFsd2F5cy1vbjsNCj4gKwkJcmVndWxhdG9yLWJvb3Qtb247DQo+ICsJCXJlZ3VsYXRv
ci1tYXgtbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPiArCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9s
dCA9IDwzMzAwMDAwPjsNCj4gKwkJcmVndWxhdG9yLW5hbWUgPSAiVkREX0lPIjsNCj4gKwl9Ow0K
PiDCoH07DQo+IMKgDQo+IMKgJkE1M18wIHsNCj4gDQoNCg==

