Return-Path: <linux-kernel+bounces-340093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0FE986E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF5A7B26479
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80DC4C91;
	Thu, 26 Sep 2024 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="EDnxg5qd"
Received: from ironport.ite.com.tw (HC210-202-87-179.vdslpro.static.apol.com.tw [210.202.87.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB6B1C6A1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337879; cv=none; b=KxTOFCEoQClxv6nlEH5cQUvVsJ6kio7OpkV6xleazANGBJnd22kLMP5mrF+D1taz0obx7CILz6h4L++ZweB4EBfGdzXknG27yVrdj0fd22NkM1RK/E3aK8wnrBJM+5/VfqPBYNG0+ekLcTIW4iVy7YAjR+gXVaYHsffAC6mHdjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337879; c=relaxed/simple;
	bh=zAhjqqnt+vihOHLXCcReZ2zUxhIQlge/XtTGcpTLwsY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=joI4kWaAmJluEahooeTsuvLK7Bf0S3E2dAeUD9Ma9R1NLdUISVrtfUFf9n6+6kAgD8zJ+Dys/Vhhd+o6axQ98s0vsAid67cbcszkY/S7420SIohyyaDVAb0dEePz5ONLKJwrtf14ESw1ZjMT/yXKAsIWjcxxTFFYor/BKoooeIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=EDnxg5qd reason="key not found in DNS"; arc=none smtp.client-ip=210.202.87.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zAhjqqnt+vihOHLXCcReZ2zUxhIQlge/XtTGcpTLwsY=;
  b=EDnxg5qd1bDs4mDuvxnEAga4NAouo+z9efdC07xtGsivPoiJw79r0TU6
   ESE6ZuL93y1JupGlTwmiWWnV4gMx3y3TTOfn3+98l0DNLaoeZlPKQEA6L
   PXTk/JZQouRYAJFh8x7Z/oKjHG1mEDFI0sTs9uXlICG06tUmhCRRkFb0/
   zerR3s7xADSDhA0ghsI5uKO8X61qO9RZscjZ3lOJFUsw7aErxurwB5W8z
   hB5ly3G1OlYEmus2JghtWYrmHPIjqpcP4+7U4d4/qoZBjaVpHkXreupBH
   JuTjgKt3ddk4GNTO0nfm1dJJd62ZyH4SaT35j7qBF6EC0PTHNnMREy6Qj
   A==;
X-CSE-ConnectionGUID: sbMb1ya5RT+tR1myXqvpBg==
X-CSE-MsgGUID: MF3JLNddS8qEmW0shmyKng==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 26 Sep 2024 16:04:35 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48Q84VKx056748;
	Thu, 26 Sep 2024 16:04:31 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from TPEMAIL1.internal.ite.com.tw (192.168.15.58) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 16:04:32 +0800
Received: from TPEMAIL1.internal.ite.com.tw ([fe80::dd6d:92:8773:b68]) by
 TPEMAIL1.internal.ite.com.tw ([fe80::dd6d:92:8773:b68%6]) with mapi id
 15.01.2507.039; Thu, 26 Sep 2024 16:04:32 +0800
From: <Hermes.Wu@ite.com.tw>
To: <dmitry.baryshkov@linaro.org>
CC: <Kenneth.Hung@ite.com.tw>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <angelogioacchino.delregno@collabora.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 02/11] drm/bridge: it6505: fix aux operation for edid
 read
Thread-Topic: [PATCH v4 02/11] drm/bridge: it6505: fix aux operation for edid
 read
Thread-Index: AQHbD+kjGrKEoIM+OEqhK3clD79cG7JptSew
Date: Thu, 26 Sep 2024 08:04:32 +0000
Message-ID: <3150e8e9ca754411bb0404475d149a8f@ite.com.tw>
References: <20240926074755.22176-1-Hermes.Wu@ite.com.tw>
 <20240926074755.22176-3-Hermes.Wu@ite.com.tw>
 <ngr25a4x3s6hd3ztmj7h5y6zp3fxw3ojm4ax5wpk45iqdfkvwe@piznnnlyudmv>
In-Reply-To: <ngr25a4x3s6hd3ztmj7h5y6zp3fxw3ojm4ax5wpk45iqdfkvwe@piznnnlyudmv>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: 66043082299B154D2E8B6C8604E5972B2BFE8F93E60CA43BFC5FDEB6A86BF5E02002:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:mse.ite.com.tw 48Q84VKx056748

Pk9uIFRodSwgU2VwIDI2LCAyMDI0IGF0IDAzOjQ3OjUyUE0gR01ULCBIZXJtZXMgV3Ugd3JvdGU6
DQo+PiBGcm9tOiBIZXJtZXMgV3UgPEhlcm1lcy53dUBpdGUuY29tLnR3Pg0KPj4gDQo+PiBUaGUg
RURJRCByZWFkIG9wZXJhdGlvbiBjYW4gcmVhY2ggdGhlIG1heGltdW0gc2l6ZSBvZiB0aGUgQVVY
IEZJRk8gYnVmZmVyLg0KPg0KPkFuZD8gQ29tbWl0IG1lc3NhZ2Ugc2hvdWxkIGRlc2NyaWJlIHdo
eSB0aGUgY2hhbmdlIGlzIG5lY2Vzc2FyeSBhbmQgd2hhdCBpcyBiZWluZyBkb25lLiBKdXN0IHBy
b3ZpZGluZyBhIHN0YXRlbWVudCBpcyBub3QgZW5vdWdoLg0KPg0KDQpUaGUgb3JpZ2luYWwgQVVY
IG9wZXJhdGlvbiB0cmVhdCBhbGwgcmVhZHMgYnkgdXNpbmcgZGF0YSByZWdpc3RlcnMgd2lsbCBi
ZSBsaW1pdGVkIGF0IDQgYnl0ZXMuDQpBVVggb3BlcmF0aW9uIGNvbW1hbmQgQ01EX0FVWF9JMkNf
RURJRF9SRUFEIHVzaW5nIEFVWCBGSUZPIGlzIGNhcGFibGUgb2YgcmVhZHMgZGF0YSBieSAxNiBi
eXRlcyBlYWNoIHRpbWUuDQpJdCBjYW4gaW1wcm92ZSBzcGVlZCBvZiByZWFkIEVESUQuDQoNCg0K
Pj4gDQo+PiBGaXhlczogYjVjODRhOWVkY2Q0ICgiZHJtL2JyaWRnZTogYWRkIGl0NjUwNSBkcml2
ZXIiKQ0KPj4gU2lnbmVkLW9mZi1ieTogSGVybWVzIFd1IDxIZXJtZXMud3VAaXRlLmNvbS50dz4N
Cj4+IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9icmlkZ2UvaXRlLWl0NjUwNS5jIHwgOCArKysr
KystLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2l0ZS1pdDY1MDUu
YyANCj4+IGIvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9pdGUtaXQ2NTA1LmMNCj4+IGluZGV4IDI4
YTgwNDMyMjlkMy4uYjQ1MWQzYzJhYzFkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2JyaWRnZS9pdGUtaXQ2NTA1LmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvaXRl
LWl0NjUwNS5jDQo+PiBAQCAtMTA3OCw4ICsxMDc4LDExIEBAIHN0YXRpYyBzc2l6ZV90IGl0NjUw
NV9hdXhfZG9fdHJhbnNmZXIoc3RydWN0IGl0NjUwNSAqaXQ2NTA1LA0KPj4gIAlpbnQgaSwgcmV0
X3NpemUsIHJldCA9IDAsIHJlcXVlc3Rfc2l6ZTsNCj4+ICANCj4+ICAJbXV0ZXhfbG9jaygmaXQ2
NTA1LT5hdXhfbG9jayk7DQo+PiAtCWZvciAoaSA9IDA7IGkgPCBzaXplOyBpICs9IDQpIHsNCj4+
IC0JCXJlcXVlc3Rfc2l6ZSA9IG1pbigoaW50KXNpemUgLSBpLCA0KTsNCj4+ICsJZm9yIChpID0g
MDsgaSA8IHNpemU7ICkgew0KPj4gKwkJaWYgKGNtZCA9PSBDTURfQVVYX0kyQ19FRElEX1JFQUQp
DQo+PiArCQkJcmVxdWVzdF9zaXplID0gbWluX3QoaW50LCAoaW50KXNpemUgLSBpLCBBVVhfRklG
T19NQVhfU0laRSk7DQo+PiArCQllbHNlDQo+PiArCQkJcmVxdWVzdF9zaXplID0gbWluX3QoaW50
LCAoaW50KXNpemUgLSBpLCA0KTsNCj4+ICAJCXJldF9zaXplID0gaXQ2NTA1X2F1eF9vcGVyYXRp
b24oaXQ2NTA1LCBjbWQsIGFkZHJlc3MgKyBpLA0KPj4gIAkJCQkJCWJ1ZmZlciArIGksIHJlcXVl
c3Rfc2l6ZSwNCj4+ICAJCQkJCQlyZXBseSk7DQo+PiBAQCAtMTA4OCw2ICsxMDkxLDcgQEAgc3Rh
dGljIHNzaXplX3QgaXQ2NTA1X2F1eF9kb190cmFuc2ZlcihzdHJ1Y3QgaXQ2NTA1ICppdDY1MDUs
DQo+PiAgCQkJZ290byBhdXhfb3BfZXJyOw0KPj4gIAkJfQ0KPj4gIA0KPj4gKwkJaSArPSByZXF1
ZXN0X3NpemU7DQo+PiAgCQlyZXQgKz0gcmV0X3NpemU7DQo+PiAgCX0NCj4+ICANCj4+IC0tDQo+
PiAyLjM0LjENCj4+IA0KPg0KPi0tIA0KPldpdGggYmVzdCB3aXNoZXMNCj5EbWl0cnkNCj4NCg0K
QlIsDQpIZXJtZXMNCg0K

