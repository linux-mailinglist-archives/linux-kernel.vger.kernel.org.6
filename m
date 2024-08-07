Return-Path: <linux-kernel+bounces-277744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6B694A5BB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA09B29444
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9801E3CA9;
	Wed,  7 Aug 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="WEYDx+jQ"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2421E2872
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026859; cv=none; b=sNWxpPYg5tqO7zwssZVhJyUP6qvwX3XfFCILnNtz0pL3ky71sKxcw05aWB7CtPHNUHz1ZKA4wlASrAmpeFq52sE/nfraSrIdwI0KElv7jaqREcU3sYQ1a+zG+CMShKcJrUgfSzDcrZ0ENTNnvRU5l0ROYo2BAxJCbpAII9vL00M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026859; c=relaxed/simple;
	bh=FblmGdf66eN+rJv+O3kISJs4VFmghorqhErApFpjvdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iUXdRJ2tg8x3eXZ1YaD0QF34vne/d9jD6jR5rgodDQREYEUg/zKtSfHM7E1JQnnm/nKXrmBnE90kQ4BhKiZNzP6E6Wms+RQJ2m6q8y7KtBs9XlNQRLhDtZ91fN5XUyxXhjpuj8X70XNXUA/cq/3BtM2cHGFRG0nEix+DtydmbJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=WEYDx+jQ; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723026849; x=1725618849;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FblmGdf66eN+rJv+O3kISJs4VFmghorqhErApFpjvdE=;
	b=WEYDx+jQzTrLDcYrIXbGhj6msUaLbjGSOqkKzL92CjVc67M6LB78LBVpXHK9qzdK
	Iugyn+0LI/GaJ+6Rf1UhsMv9m9fiGSvSRj0ixuALCjW0y/4zEY44s0QwK8SojgjN
	370dnkT5+wCBM2mKm1cJZRu2LCF0O8JC4k12iIeLKYU=;
X-AuditID: ac14000a-03e52700000021bc-2e-66b34da00672
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D7.E4.08636.0AD43B66; Wed,  7 Aug 2024 12:34:08 +0200 (CEST)
Received: from Florix.phytec.de (172.25.0.13) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 7 Aug 2024
 12:34:08 +0200
Received: from Florix.phytec.de ([fe80::a802:84f9:c56c:4c6d]) by
 florix.phytec.de ([fe80::a802:84f9:c56c:4c6d%5]) with mapi id 15.01.2507.006;
 Wed, 7 Aug 2024 12:34:08 +0200
From: Yashwanth Varakala <Y.Varakala@phytec.de>
To: "kernel@pengutronix.de" <kernel@pengutronix.de>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "peng.fan@nxp.com" <peng.fan@nxp.com>,
	"robh@kernel.org" <robh@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"festevam@gmail.com" <festevam@gmail.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, PHYTEC Upstream <upstream@lists.phytec.de>
Subject: Re: [PATCH 3/3] arm64: dts: Add phyBOARD-Pollux dts for rpmsg
Thread-Topic: [PATCH 3/3] arm64: dts: Add phyBOARD-Pollux dts for rpmsg
Thread-Index: AQHa3nd2t62c2rb+I0yYD8HVBQhz47IRlkoAgAn16gA=
Date: Wed, 7 Aug 2024 10:34:08 +0000
Message-ID: <da0363d65457c1f1de26b9bc03117d667d6a578e.camel@phytec.de>
References: <20240725094457.37739-1-y.varakala@phytec.de>
	 <20240725094457.37739-4-y.varakala@phytec.de>
	 <PAXPR04MB84593B109878D86B72DEB4AD88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB84593B109878D86B72DEB4AD88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DB096743C16584EBE7C6329E744B239@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsWyRpKBV3eB7+Y0g+tTLC3W7D3HZDH/yDlW
	i4dX/S1m3mtls1g1dSeLxctZ99gsNj2+xmpxedccNosfq76wWvzfs4Pd4u/2TSwWL7aIW3S/
	U3fg9dg56y67x6ZVnWwem5fUe7zYPJPRo7+7hdVj47sdTB79fw08Pm+SC+CI4rJJSc3JLEst
	0rdL4MqYtGA/S8EWw4qp+y8xNzBOMOhi5OSQEDCRuL/gH2sXIxeHkMASJokP2/dAOfcYJZ7P
	3cQC4WxklNj75xI7SAubgL5E68TnbCAJEYE3TBLn17QzgjjMAmuYJNZN6WUBqRIWcJOYun8y
	M4gtIuAu8aZ9DjuEbSXR1f2WEcRmEVCRONm7hA3E5gWqn9Z4GWrdPkaJY9vawYo4BWIlGu9c
	ARvEKCAr0dnwjgnEZhYQl9j07DsrxBcCEkv2nGeGsEUlXj7+BxWXlzhxaxpQPQdQvabE+l36
	EK0WEoce32eDsBUlpnQ/ZIe4QVDi5MwnLBMYxWch2TALoXsWku5ZSLpnIelewMi6ilEoNzM5
	O7UoM1uvIKOyJDVZLyV1EyMoGYgwcO1g7JvjcYiRiYPxEKMEB7OSCG9z+KY0Id6UxMqq1KL8
	+KLSnNTiQ4zSHCxK4ryrO4JThQTSE0tSs1NTC1KLYLJMHJxSDYzbuOa28cR9m/5iio4we6Y3
	24JpM0NDvu8Vq0nX/LblVl77W0erlYmbQ4Nsiq1Z2L8zOvAvtly/uvNC+pSZRh+jsyo4imeb
	sTLPuemhO/nznPs3leYt2zzL+mVQqN/iroMHnjoFl+xl2LJ2/9UVLB+/WddkN6xZ/VhqgrbA
	2ZQISU5er4Z+JVclluKMREMt5qLiRAC2mQBv9AIAAA==

SGVsbG8gUGVuZywKCk9uIFRodSwgMjAyNC0wOC0wMSBhdCAwMjoyNyArMDAwMCwgUGVuZyBGYW4g
d3JvdGU6Cj4gPiBTdWJqZWN0OiBbUEFUQ0ggMy8zXSBhcm02NDogZHRzOiBBZGQgcGh5Qk9BUkQt
UG9sbHV4IGR0cyBmb3IgcnBtc2cKPiA+IAo+ID4gQWRkcyBhIGRldmljZXRyZWUgY29udGFpbmlu
ZyByZXNlcnZlZCBtZW1vcnkgcmVnaW9ucyB1c2VkIGZvcgo+ID4gaW50ZXJjb3JlIGNvbW11bmlj
YXRpb24gYmV0d2VlbiBBNTMgYW5kIE03IGNvcmVzLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBZ
YXNod2FudGggVmFyYWthbGEgPHkudmFyYWthbGFAcGh5dGVjLmRlPgo+ID4gLS0tCj4gPiDCoGFy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlwqDCoMKgwqDCoMKgwqAgfMKgIDIg
Kwo+ID4gwqAuLi4vZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Y29yZS1ycG1zZy5kdHNvwqDCoCB8
IDU3Cj4gPiArKysrKysrKysrKysrKysrKysrCj4gPiDCoDIgZmlsZXMgY2hhbmdlZCwgNTkgaW5z
ZXJ0aW9ucygrKQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1wLQo+ID4gcGh5Y29yZS1ycG1zZy5kdHNvCj4gPiAKPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZQo+ID4gYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZQo+ID4gaW5kZXggZGVkZWE0YjVjMzE5Li44
MGNjODdkNTAzMDEgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9NYWtlZmlsZQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvTWFrZWZp
bGUKPiA+IEBAIC0xNzcsOSArMTc3LDExIEBAIGR0Yi0kKENPTkZJR19BUkNIX01YQykgKz0gaW14
OG1wLQo+ID4gcGh5Ym9hcmQtcG9sbHV4LXJkay5kdGLCoCBpbXg4bXAtcGh5Ym9hcmQtcG9sbHV4
LXJkay1uby1ldGgtZHRicyArPQo+ID4gaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGsuZHRiIGlt
eDhtcC1waHljb3JlLW5vLWV0aC5kdGJvCj4gPiBpbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay1u
by1ydGMtZHRicyArPSBpbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LQo+ID4gcmRrLmR0YiBpbXg4bXAt
cGh5Y29yZS1uby1ydGMuZHRib8KgIGlteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLW5vLQo+ID4g
c3BpZmxhc2gtZHRicyArPSBpbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdGIgaW14OG1wLXBo
eWNvcmUtbm8tCj4gPiBzcGlmbGFzaC5kdGJvCj4gPiAraW14OG1wLXBoeWJvYXJkLXBvbGx1eC1y
ZGstcnBtc2ctZHRicyArPSBpbXg4bXAtcGh5Ym9hcmQtCj4gPiBwb2xsdXgtcmRrLmR0Ygo+ID4g
K2lteDhtcC1waHljb3JlLXJwbXNnLmR0Ym8KPiA+IMKgZHRiLSQoQ09ORklHX0FSQ0hfTVhDKSAr
PSBpbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay1uby0KPiA+IGV0aC5kdGIKPiA+IMKgZHRiLSQo
Q09ORklHX0FSQ0hfTVhDKSArPSBpbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay1uby1ydGMuZHRi
Cj4gPiDCoGR0Yi0kKENPTkZJR19BUkNIX01YQykgKz0gaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1y
ZGstbm8tCj4gPiBzcGlmbGFzaC5kdGIKPiA+ICtkdGItJChDT05GSUdfQVJDSF9NWEMpICs9IGlt
eDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLQo+ID4gcnBtc2cuZHRiCj4gPiDCoGR0Yi0kKENPTkZJ
R19BUkNIX01YQykgKz0gaW14OG1wLXNrb3YtcmV2Yi1oZG1pLmR0Ygo+ID4gwqBkdGItJChDT05G
SUdfQVJDSF9NWEMpICs9IGlteDhtcC1za292LXJldmItbHQ2LmR0Ygo+ID4gwqBkdGItJChDT05G
SUdfQVJDSF9NWEMpICs9IGlteDhtcC1za292LXJldmItbWkxMDEwYWl0LTFjcDEuZHRiCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWNvcmUt
Cj4gPiBycG1zZy5kdHNvIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBo
eWNvcmUtCj4gPiBycG1zZy5kdHNvCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4gaW5kZXgg
MDAwMDAwMDAwMDAwLi5hNTY5NGYzYWVjYWEKPiA+IC0tLSAvZGV2L251bGwKPiA+ICsrKyBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHljb3JlLXJwbXNnLmR0c28KPiA+
IEBAIC0wLDAgKzEsNTcgQEAKPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MAo+IAo+IER1YWwgbGljZW5zZSBpcyBiZXR0ZXIgZGV2aWNlIHRyZWUuCj4gCj4gPiArLyoKPiA+
ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjQgUEhZVEVDIE1lc3N0ZWNobmlrIEdtYkgKPiA+ICsgKiBB
dXRob3I6IERvbWluaWsgSGFsbGVyIDxkLmhhbGxlckBwaHl0ZWMuZGU+Cj4gPiArICrCoMKgwqDC
oMKgwqDCoCBDZW0gVGVucnVoIDxjLnRlbnJ1aEBwaHl0ZWMuZGU+Cj4gPiArICovCj4gPiArCj4g
PiArL2R0cy12MS87Cj4gPiArL3BsdWdpbi87Cj4gPiArCj4gPiArI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL2Nsb2NrL2lteDhtcC1jbG9jay5oPgo+ID4gKwo+ID4gKyZ7L30gewo+ID4gK8KgwqDCoMKg
wqDCoMKgaW14OG1wLWNtNyB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29t
cGF0aWJsZSA9ICJmc2wsaW14OG1uLWNtNyI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY2xvY2tzID0gPCZjbGsgSU1YOE1QX0NMS19NN19ESVY+Owo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoG1ib3hlcyA9IDwmbXUgMCAxCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCZtdSAxIDEKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgJm11IDMgMT47Cj4gCj4gwqDCoMKgwqDC
oMKgwqAgbWJveGVzID0gPCZtdTEgMAo+IDE+LMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IMKgwqDCoMKg
wqAgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
PCZtdTEgMQo+IDE+LMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IMKgwqDCoMKgwqAgCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPCZtdTEgMyAxPjsKVGhh
bmsgeW91IGZvciB0aGUgZmVlZGJhY2suIEkgY2hlY2tlZCBhbmQgZm91bmQgb25seSBtdSBhbmQg
bXUyIGxhYmVscwpvZiBtYWlsYm94ZXMgYXJlIHByZXNlbnQuIG11MSBpcyBub3QgdXNlZCBpbiBp
bXg4bXAuZHRzaS4gQ2FuIHlvdQpwbGVhc2UgdGVsbCBtZSB3aHkgSSBoYXZlIHRvIHVzZSBtdTEg
aGVyZT8KCj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWJveC1uYW1lcyA9
ICJ0eCIsICJyeCIsICJyeGRiIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBt
ZW1vcnktcmVnaW9uID0gPCZ2ZGV2YnVmZmVyPiwgPCZ2ZGV2MHZyaW5nMD4sCj4gPiA8JnZkZXYw
dnJpbmcxPiwgPCZyc2NfdGFibGU+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJzYy1kYSA9IDwweDU1MDAwMDAwPjsKPiAKPiBEcm9wIHRoaXMgInJzYy1kYSIuCj4gCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RhdHVzID0gIm9rYXkiOwo+IAo+IERyb3Ag
aXQsIGRlZmF1bHQgaXMgIm9rYXkiLgo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgfTsKPiA+ICsKPiA+
ICvCoMKgwqDCoMKgwqDCoHJlc2VydmVkLW1lbW9yeSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmFuZ2VzOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNh
ZGRyZXNzLWNlbGxzID0gPDI+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNz
aXplLWNlbGxzID0gPDI+Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oG03X3Jlc2VydmVkOiBtN0AweDgwMDAwMDAwIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbm8tbWFwOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWcgPSA8MCAweDgwMDAwMDAwIDAgMHgxMDAwMDAw
PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gKwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJzY190YWJsZTogcnNjX3RhYmxlQDU1MGZmMDAwIHsK
PiAKPiAicnNjLXRhYmxlQDU1MGZmMDAwIi4gU2VlbXMgeW91IG5vdCB0ZXN0IHRoaXMgcGF0Y2gg
d2l0aCBsaW51eAo+IHJlbW90ZXByb2MsIG90aGVyd2lzZSB5b3Ugd2lsbCBzZWUgdnJpbmcgbm90
IHNldCB1cC4KPiAKPiBSZWdhcmRzLAo+IFBlbmcuCgotLSAKLQpSZWdhcmRzLApZYXNod2FudGgK
Cgo=

