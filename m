Return-Path: <linux-kernel+bounces-373697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED239A5A69
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFAF281478
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA021CF291;
	Mon, 21 Oct 2024 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="qfOO5kwR"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116B194A49
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729492405; cv=none; b=gTuZBsjwkdesF0jWWABmls94SqwSmVhUkBwZBzIjE9LJmZ6an49KqQjBMF7zog2o7qfm7WHxh15kZXUJmSniTjo6o4gVgZDPG8rJYxsPSgMLPLvNUJPnuRkVErKeCZwrMaRmj7rZ63ikb0k19pj5DrWIm6RWiCLL/kfwxpwlwyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729492405; c=relaxed/simple;
	bh=d9EUatJrHB967xkaMIGGxBlmw9uOaKcQwdMTUJwPQyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=leI42oIbj/fNp6FIxYH12fNVXWZb6WEWF4jKI/aKiaofSJZcslGRUsHrHNEoPDiLTud/WqdkhnLXOGi8czCSGUgXeVTuOvkBWSGa0RJX3wVjkjLQOlQSkVyysiyy9POwWRZeR4NtdMnEQM7+EtzAQuavQPaDrDo67Eq/wL8L7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=qfOO5kwR reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d9EUatJrHB967xkaMIGGxBlmw9uOaKcQwdMTUJwPQyA=;
  b=qfOO5kwR8h//rxYbBkp8CRl+x211/8uAdpdbU4VwGIYrBK28i3ZtH15E
   yIXwdrEBf5fbreTq597nc3+rvfRIAenAmQkeAlL3b+T1/g/s0eUNlTT76
   v4eJnWOoQZFqJC8emM5rSX04w1Z1qJZ5YwmRLDS7fQ9wPJQYXyfDTwVsi
   /gP/BlprxEgJcJj5RtxLVdmVfLq6Xx/c7FYrU0LUWjoYWVimYDN9iv6jB
   hdYFifAilB3+swK6xah1WR9t5/K7zyeH4s7oE5AOinWeLsplfHhm2SHxY
   Wdmsl3JKJ/tKv4u9ttprN3TlfNhfpvWWIRv2ltmWUZqS1Ub+6SK4eFKWx
   g==;
X-CSE-ConnectionGUID: IZyzp3biR+aigF6Kxb/glA==
X-CSE-MsgGUID: 8zrP8PZfSaahjsweDGbz/Q==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 21 Oct 2024 14:33:14 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 49L6X9XD099218;
	Mon, 21 Oct 2024 14:33:09 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from TPEMAIL1.internal.ite.com.tw (192.168.15.58) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 14:33:09 +0800
Received: from TPEMAIL1.internal.ite.com.tw ([fe80::dd6d:92:8773:b68]) by
 TPEMAIL1.internal.ite.com.tw ([fe80::dd6d:92:8773:b68%6]) with mapi id
 15.01.2507.039; Mon, 21 Oct 2024 14:33:09 +0800
From: <Hermes.Wu@ite.com.tw>
To: <dmitry.baryshkov@linaro.org>
CC: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <angelogioacchino.delregno@collabora.com>,
        <treapking@chromium.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <Kenneth.Hung@ite.com.tw>,
        <Pet.Weng@ite.com.tw>
Subject: RE: [PATCH v6 00/10] drm/bridge: it6505: fix HDCP CTS fail items and
 add MCCS support
Thread-Topic: [PATCH v6 00/10] drm/bridge: it6505: fix HDCP CTS fail items and
 add MCCS support
Thread-Index: AQHbIvfv2yCYgM8QaEWs6T2K4Uuy/LKQvbWQ
Date: Mon, 21 Oct 2024 06:33:09 +0000
Message-ID: <2302452d3a6e446d9d288241958ec086@ite.com.tw>
References: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
 <e6ksqhssu55ox4ffzyko7fsahvk6i6aoj4jo2rbe2gv6sclvzp@elpidkcflh3s>
In-Reply-To: <e6ksqhssu55ox4ffzyko7fsahvk6i6aoj4jo2rbe2gv6sclvzp@elpidkcflh3s>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: 4AA65F92141D12A2B8DA56F580D5AD81F0FF959BCA15C3262F2C8DAA8FFB35882002:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:mse.ite.com.tw 49L6X9XD099218

aGkNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRG1pdHJ5IEJhcnlzaGtv
diA8ZG1pdHJ5LmJhcnlzaGtvdkBsaW5hcm8ub3JnPiANCj5TZW50OiBTdW5kYXksIE9jdG9iZXIg
MjAsIDIwMjQgOTo1NyBQTQ0KPlRvOiBIZXJtZXMgV3UgKKdkqM6nuykgPEhlcm1lcy5XdUBpdGUu
Y29tLnR3Pg0KPkNjOiBBbmRyemVqIEhhamRhIDxhbmRyemVqLmhhamRhQGludGVsLmNvbT47IE5l
aWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPjsgUm9iZXJ0IEZvc3MgPHJm
b3NzQGtlcm5lbC5vcmc+OyBMYXVyZW50IFBpbmNoYXJ0IDxMYXVyZW50LnBpbmNoYXJ0QGlkZWFz
b25ib2FyZC5jb20+OyBKb25hcyBLYXJsbWFuIDxqb25hc0Brd2lib28uc2U+OyBKZXJuZWogU2ty
YWJlYyA8amVybmVqLnNrcmFiZWNAZ21haWwuY29tPjsgTWFhcnRlbiBMYW5raG9yc3QgPG1hYXJ0
ZW4ubGFua2hvcnN0QGxpbnV4LmludGVsLmNvbT47IE1heGltZSBSaXBhcmQgPG1yaXBhcmRAa2Vy
bmVsLm9yZz47IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPjsgRGF2aWQg
QWlybGllIDxhaXJsaWVkQGdtYWlsLmNvbT47IFNpbW9uYSBWZXR0ZXIgPHNpbW9uYUBmZndsbC5j
aD47IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25v
QGNvbGxhYm9yYS5jb20+OyBQaW4teWVuIExpbiA8dHJlYXBraW5nQGNocm9taXVtLm9yZz47IGRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IEtlbm5ldGggSHVuZyAorHiuYa3bKSA8S2VubmV0aC5IdW5nQGl0ZS5jb20udHc+OyBQZXQg
V2VuZyAor86lyariKSA8UGV0LldlbmdAaXRlLmNvbS50dz4NCj5TdWJqZWN0OiBSZTogW1BBVENI
IHY2IDAwLzEwXSBkcm0vYnJpZGdlOiBpdDY1MDU6IGZpeCBIRENQIENUUyBmYWlsIGl0ZW1zIGFu
ZCBhZGQgTUNDUyBzdXBwb3J0DQo+DQo+T24gV2VkLCBPY3QgMTYsIDIwMjQgYXQgMDM6NTQ6MTJQ
TSArMDgwMCwgSGVybWVzIFd1IHZpYSBCNCBSZWxheSB3cm90ZToNCj4+IFRoaXMgaXMgYSB2NiBw
YXRjaC1zZXQuDQo+PiANCj4+IFRoZXJlIGFyZSBsb3RzIG9mIGZhaWx1cmUgaXRlbXMgd2hpbGUg
cnVubmluZyBIRENQIENUUyB1c2luZyBVTklHUkFGIERQUi0xMDAuDQo+PiBJbiBPcmRlciB0byBm
aXggdGhvc2UgZmFpbHVyZXMsIEhEQ1AgZmxvdyBuZWVkcyB0byBiZSBjaGFuZ2VkLg0KPj4gDQo+
PiBUaGUgRGlzcGxheVBvcnQgQVVYIHByb3RvY29sIHN1cHBvcnRzIEkyQyB0cmFuc3BvcnQuDQo+
PiBJbiBPcmRlciB0byBzdXBwb3J0IE1DQ1MgdmlhIHRoZSBhdXggY2hhbm5lbCwgdGhlIGF1eC1p
MmMgb3BlcmF0aW9uIGlzIGFkZGVkLg0KPj4gDQo+PiB2NS0+djY6DQo+PiAJLWtlZXAgdGhlIGNv
bW1pdCBtZXNzYWdlIHdyYXBwZWQgYXQgNzItNzUgY2hhcnMuDQo+PiAJLVsxMC8xMF0gZml4IHJl
dHVybiB2YXJpYWJsZSBiZWluZyB1c2VkIHdpdGhvdXQgYmVpbmcgaW5pdGlhbGl6ZWQNCj4NCj5J
IGhhdmUgcmV2aWV3ZWQgdGhlIHBhdGNoZXMgdGhhdCBJIGNvdWxkIHJldmlldywgYnV0IEkgbGFj
ayBkZWVwIEhEQ1Aga25vd2xlZGdlLCBzbyBJIGNhbiBub3QgcmV2aWV3IHBhdGNoZXMgNSwgNiwg
OCwgOS4gSG9wZWZ1bGx5IHNvbWVib2R5IGVsc2UgY2FuIHN0ZXAgdXAuDQo+DQp0aGFuayB5b3Uu
DQoNCj4+IHY0LT52NToNCj4+IAktYWRkIG1vcmUgbWVzc2FnZXMgZm9yIGNoYW5nZXMuDQo+PiAJ
LVsyLzEwXSBtb2RpZmllZCBBVVggdHJhbnNmZXIgZGF0YSBzaXplIGp1ZGdtZW50Lg0KPj4gCQlj
aGFuZ2UgZm9yLWxvb3AgdG8gZG8td2hpbGUuDQo+PiAJLVs3LzEwXSBjaGFuZ2UgZm9yLWxvb3Ag
dG8gZG8td2hpbGUuDQo+PiAJLVs5LzEwXSBjaGFuZ2Ugd2FpdCB0aW1lciB3aXRoIHRpbWVyX2Fm
dGVyKCkNCj4+IA0KPj4gCWxpbmtzOg0KPj4gCWh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA5MjYwNzQ3NTUuMjIxNzYtNC1IZXJtZXMu
V3VAaXRlLmNvbS50dy9fXzshIUh0bkxFOEEhSE93eTA1X2VnVGJqNVU3dnJqZlBoSkMyMVZLX0p4
bGw4VVdOT2NHRXpOU0R4bktRakU2UVNMaGFtZC1JUk9FLVN4R09yekZTX1NMZml4dE9SakxMQlRq
ZEwzU1YkIA0KPj4gCQ0KPj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8yMDI0MDkyNjA3NTEzNA0KPj4gLjIyMzk0LTEtSGVybWVzLld1QGl0
ZS5jb20udHcvX187ISFIdG5MRThBIUhPd3kwNV9lZ1RiajVVN3ZyamZQaEpDMjFWSw0KPj4gX0p4
bGw4VVdOT2NHRXpOU0R4bktRakU2UVNMaGFtZC1JUk9FLVN4R09yekZTX1NMZml4dE9SakxMQlRj
X1lnOFIkDQo+PiANCj4+IHYzLT52NDoNCj4+IAktc3BsaXQgY2hhbmdlcyAgaW50byBwYXRjaGVz
Lg0KPj4gDQo+PiB2Mi0+djM6DQo+PiAJLXNwbGl0IGF1eCByZWFkICBLU1YgZnVuY3Rpb24gdG8g
YSBwYXRjaC4NCj4+IAktWzEvM10gbmV3IGluIHYzDQo+PiAJLVsyLzNdIGFkZCBkZXNjcmlwdGlv
biBvZiBwYXRjaA0KPj4gDQo+PiB2MS0+djI6DQo+PiAJLSBpZ25vcmVkLg0KPj4gDQo+PiBIZXJt
ZXMgV3UgKDEwKToNCj4+ICAgZHJtL2JyaWRnZTogaXQ2NTA1OiBDaGFuZ2UgZGVmaW5pdGlvbiBv
ZiBBVVhfRklGT19NQVhfU0laRQ0KPj4gICBkcm0vYnJpZGdlOiBpdDY1MDU6IGltcHJvdmUgQVVY
IG9wZXJhdGlvbiBmb3IgZWRpZCByZWFkDQo+PiAgIGRybS9icmlkZ2U6IGl0NjUwNTogYWRkIEFV
WCBvcGVyYXRpb24gZm9yIEhEQ1AgS1NWIGxpc3QgcmVhZA0KPj4gICBkcm0vYnJpZGdlOiBpdDY1
MDU6IENoYW5nZSBkZWZpbml0aW9uIE1BWF9IRENQX0RPV05fU1RSRUFNX0NPVU5UDQo+PiAgIGRy
bS9icmlkZ2U6IGl0NjUwNTogZml4IEhEQ1AgQnN0YXR1cyBjaGVjaw0KPj4gICBkcm0vYnJpZGdl
OiBpdDY1MDU6IGZpeCBIRENQIGVuY3J5cHRpb24gd2hlbiBSMCByZWFkeQ0KPj4gICBkcm0vYnJp
ZGdlOiBpdDY1MDU6IGZpeCBIRENQIENUUyBLU1YgbGlzdCByZWFkIHdpdGggVU5JR1JBRiBEUFIt
MTAwLg0KPj4gICBkcm0vYnJpZGdlOiBpdDY1MDU6IGZpeCBIRENQIENUUyBjb21wYXJlIFYgbWF0
Y2hpbmcNCj4+ICAgZHJtL2JyaWRnZTogaXQ2NTA1OiBmaXggSERDUCBDVFMgS1NWIGxpc3Qgd2Fp
dCB0aW1lcg0KPj4gICBkcm0vYnJpZGdlOiBpdDY1MDU6IGFkZCBJMkMgZnVuY3Rpb25hbGl0eSBv
biBBVVgNCj4+IA0KPj4gQ2hhbmdlLUlkOiBJYWQwYzA1NmQ3MmFiZjI2NTUwODEzNTdjZjQwYzNi
MGQzZGY5MTZiNQ0KPj4gU2lnbmVkLW9mZi1ieTogSGVybWVzIFd1IDxIZXJtZXMud3VAaXRlLmNv
bS50dz4NCj4+IC0tLQ0KPj4gSGVybWVzIFd1ICgxMCk6DQo+PiAgICAgICBkcm0vYnJpZGdlOiBp
dDY1MDU6IENoYW5nZSBkZWZpbml0aW9uIG9mIEFVWF9GSUZPX01BWF9TSVpFDQo+PiAgICAgICBk
cm0vYnJpZGdlOiBpdDY1MDU6IGltcHJvdmUgQVVYIG9wZXJhdGlvbiBmb3IgZWRpZCByZWFkDQo+
PiAgICAgICBkcm0vYnJpZGdlOiBpdDY1MDU6IGFkZCBBVVggb3BlcmF0aW9uIGZvciBIRENQIEtT
ViBsaXN0IHJlYWQNCj4+ICAgICAgIGRybS9icmlkZ2U6IGl0NjUwNTogQ2hhbmdlIGRlZmluaXRp
b24gTUFYX0hEQ1BfRE9XTl9TVFJFQU1fQ09VTlQNCj4+ICAgICAgIGRybS9icmlkZ2U6IGl0NjUw
NTogZml4IEhEQ1AgQnN0YXR1cyBjaGVjaw0KPj4gICAgICAgZHJtL2JyaWRnZTogaXQ2NTA1OiBm
aXggSERDUCBlbmNyeXB0aW9uIHdoZW4gUjAgcmVhZHkNCj4+ICAgICAgIGRybS9icmlkZ2U6IGl0
NjUwNTogZml4IEhEQ1AgQ1RTIEtTViBsaXN0IHJlYWQgd2l0aCBVTklHUkFGIERQUi0xMDAuDQo+
PiAgICAgICBkcm0vYnJpZGdlOiBpdDY1MDU6IGZpeCBIRENQIENUUyBjb21wYXJlIFYgbWF0Y2hp
bmcNCj4+ICAgICAgIGRybS9icmlkZ2U6IGl0NjUwNTogZml4IEhEQ1AgQ1RTIEtTViBsaXN0IHdh
aXQgdGltZXINCj4+ICAgICAgIGRybS9icmlkZ2U6IGl0NjUwNTogYWRkIEkyQyBmdW5jdGlvbmFs
aXR5IG9uIEFVWA0KPj4gDQo+PiAgZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9pdGUtaXQ2NTA1LmMg
fCAzMzQgDQo+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4+ICAxIGZp
bGUgY2hhbmdlZCwgMjc3IGluc2VydGlvbnMoKyksIDU3IGRlbGV0aW9ucygtKQ0KPj4gLS0tDQo+
PiBiYXNlLWNvbW1pdDogYjgxMjhmNzgxNWZmMTM1ZjAzMzNjMWI0NmRjZGYxNTQzYzQxYjg2MA0K
Pj4gY2hhbmdlLWlkOiAyMDI0MTAxNS11cHN0cmVhbS12Ni05ZjRiMDE1ZmVjZjcNCj4+IA0KPj4g
QmVzdCByZWdhcmRzLA0KPj4gLS0NCj4+IEhlcm1lcyBXdSA8SGVybWVzLnd1QGl0ZS5jb20udHc+
DQo+PiANCj4+IA0KPg0KPi0tDQo+V2l0aCBiZXN0IHdpc2hlcw0KPkRtaXRyeQ0KPg0KDQpCUiwN
Ckhlcm1lcw0K

