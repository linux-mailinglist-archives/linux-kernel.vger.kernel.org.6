Return-Path: <linux-kernel+bounces-186908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38C18CCAAA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1932282465
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834DA4C8C;
	Thu, 23 May 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="lCQztU9y"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379861879
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716430827; cv=none; b=ZvbK+6wSiV0QxyaPL6gu77rYwVWpeiszBVaqIk1gKKUt33oT/9jY0uGW8d8wQjR8Fa93ZavBGgFirEFFi4h1nD2zVp5fnbSMBgUmjcZYpF5jOPoPrd4M4azO9N6s0TS1ePCxDpZ10E9aNULRvEXflLmLHP9Zmgm++h/4kk8WU28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716430827; c=relaxed/simple;
	bh=NJXcidCTRToYs0IwR46zej5GAyPnVh2cP1Z9J0t//Yc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HxcTjF0G0B8Nj5TIgxk7FeH8Sc7PDcjRONG85OI39VStWtrYKfWcMzC9K5wTVmBlbyb7mTOZJTo48n1uMJ6szQumEdsQrVyJBOdIK7z8e3oP5Za7wtElcyiUQeGKDfQwBeag9EUWuBjz+TcVU/iRvrq6sksNPIqwlLQLxds8ZHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=lCQztU9y reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=NJXcidCTRToYs0IwR46zej5GAyPnVh2cP1Z9J0t//Yc=;
  b=lCQztU9yDc7R3zhJli+6sXgEcCATROeRrD/Fm075bdPUqYJb0jZg4bqB
   3y9RKECjRPU+IsR5E8QN0U+EvfwNy0lHxS6heYJhy907p4bBmcNyrQt1Z
   ResmkNZ937deTVIGWCcq7Rok1lJZdWklhE9hcF8c8fgz4kkdutAhQvWXW
   HyQUJHaGYmpWMoTfATOuDBJFwKDrKGLVuCYVFy3C4641h4E+bCJJcV1A4
   ulk2la+/NZTyNhZJgN4OEvyOCv0/2dr5K9CZeICzzGmLD//YJsXlY6mgz
   rQNg1UGtKUPGlHOpE7ImAfaUQ39+GyyRyegJMVr3734DqC1CzysnMbtmP
   g==;
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 23 May 2024 10:20:16 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 44N2KBir068194;
	Thu, 23 May 2024 10:20:11 +0800 (GMT-8)
	(envelope-from kuro.chung@ite.com.tw)
Received: from CSBMAIL1.internal.ite.com.tw (192.168.65.58) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 10:20:10 +0800
Received: from CSBMAIL1.internal.ite.com.tw ([fe80::c9da:6689:2b22:a2d6]) by
 CSBMAIL1.internal.ite.com.tw ([fe80::c9da:6689:2b22:a2d6%3]) with mapi id
 15.01.2507.035; Thu, 23 May 2024 10:20:10 +0800
From: <kuro.chung@ite.com.tw>
To: <rfoss@kernel.org>, <mripard@kernel.org>, <tzimmermann@suse.de>,
        <jonas@kwiboo.se>, <daniel@ffwll.ch>,
        <angelogioacchino.delregno@collabora.com>, <allen.chen@ite.com.tw>,
        <neil.armstrong@linaro.org>, <Laurent.pinchart@ideasonboard.com>,
        <maarten.lankhorst@linux.intel.com>, <airlied@gmail.com>,
        <Kenneth.Hung@ite.com.tw>, <dri-devel@lists.freedesktop.org>,
        <treapking@chromium.org>, <andrzej.hajda@intel.com>,
        <jernej.skrabec@gmail.com>, <linux-kernel@vger.kernel.org>,
        <Hermes.Wu@ite.com.tw>
Subject: RE: [PATCH v13] drm/bridge: it6505: fix hibernate to resume no
 display issue
Thread-Topic: [PATCH v13] drm/bridge: it6505: fix hibernate to resume no
 display issue
Thread-Index: AQHarEF1RyVNwB74Y0uCe4AHqbJSWrGkFYQA
Date: Thu, 23 May 2024 02:20:10 +0000
Message-ID: <39420a7df0884000b993dea89c124b57@ite.com.tw>
References: <20240522065528.1053439-1-kuro.chung@ite.com.tw>
 <171637999486.1598011.4983921044000498146.b4-ty@kernel.org>
In-Reply-To: <171637999486.1598011.4983921044000498146.b4-ty@kernel.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: 3E144EBE72A89DF0D9F0957737E552CFF494FD81F32C04417334BFC8901874A42002:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:mse.ite.com.tw 44N2KBir068194

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSb2JlcnQgRm9zcyA8cmZvc3NA
a2VybmVsLm9yZz4gDQpTZW50OiBXZWRuZXNkYXksIE1heSAyMiwgMjAyNCA4OjEzIFBNDQpUbzog
TWF4aW1lIFJpcGFyZCA8bXJpcGFyZEBrZXJuZWwub3JnPjsgVGhvbWFzIFppbW1lcm1hbm4gPHR6
aW1tZXJtYW5uQHN1c2UuZGU+OyBKb25hcyBLYXJsbWFuIDxqb25hc0Brd2lib28uc2U+OyBEYW5p
ZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+OyBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8
YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPjsgQWxsZW4gQ2hlbiA8YWxs
ZW4uY2hlbkBpdGUuY29tLnR3PjsgTmVpbCBBcm1zdHJvbmcgPG5laWwuYXJtc3Ryb25nQGxpbmFy
by5vcmc+OyBMYXVyZW50IFBpbmNoYXJ0IDxMYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5j
b20+OyBNYWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29t
PjsgRGF2aWQgQWlybGllIDxhaXJsaWVkQGdtYWlsLmNvbT47IEt1cm8gQ2h1bmcgKOmQmOS7leW7
tykgPGt1cm8uY2h1bmdAaXRlLmNvbS50dz47IEtlbm5ldGggSHVuZyAo5rSq5a625YCrKSA8S2Vu
bmV0aC5IdW5nQGl0ZS5jb20udHc+OyBvcGVuIGxpc3Q6RFJNIERSSVZFUlMgPGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc+OyBQaW4teWVuIExpbiA8dHJlYXBraW5nQGNocm9taXVtLm9y
Zz47IEFuZHJ6ZWogSGFqZGEgPGFuZHJ6ZWouaGFqZGFAaW50ZWwuY29tPjsgSmVybmVqIFNrcmFi
ZWMgPGplcm5lai5za3JhYmVjQGdtYWlsLmNvbT47IG9wZW4gbGlzdCA8bGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZz47IEhlcm1lcyBXdSAo5ZCz5L2z5a6PKSA8SGVybWVzLld1QGl0ZS5jb20u
dHc+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYxM10gZHJtL2JyaWRnZTogaXQ2NTA1OiBmaXggaGli
ZXJuYXRlIHRvIHJlc3VtZSBubyBkaXNwbGF5IGlzc3VlDQoNCk9uIFdlZCwgMjIgTWF5IDIwMjQg
MTQ6NTU6MjggKzA4MDAsIGt1cm8gd3JvdGU6DQo+IEZyb206IEt1cm8gQ2h1bmcgPGt1cm8uY2h1
bmdAaXRlLmNvbS50dz4NCj4gDQo+IFdoZW4gdGhlIHN5c3RlbSBwb3dlciByZXN1bWVzLCB0aGUg
VFRMIGlucHV0IG9mIElUNjUwNSBtYXkgZXhwZXJpZW5jZSANCj4gc29tZSBub2lzZSBiZWZvcmUg
dGhlIHZpZGVvIHNpZ25hbCBzdGFiaWxpemVzLCBuZWNlc3NpdGF0aW5nIGEgdmlkZW8gDQo+IHJl
c2V0LiBUaGlzIHBhdGNoIGlzIGltcGxlbWVudGVkIHRvIHByZXZlbnQgYSBsb29wIG9mIHZpZGVv
IGVycm9yIA0KPiBpbnRlcnJ1cHRzLCB3aGljaCBjYW4gb2NjdXIgd2hlbiBhIHZpZGVvIHJlc2V0
IGluIHRoZSB2aWRlbyBGSUZPIGVycm9yIA0KPiBpbnRlcnJ1cHQgdHJpZ2dlcnMgYW5vdGhlciBz
dWNoIGludGVycnVwdC4gVGhlIHBhdGNoIHByb2Nlc3NlcyB0aGUgDQo+IFNDRFQgYW5kIEZJRk8g
ZXJyb3IgaW50ZXJydXB0cyBzaW11bHRhbmVvdXNseSBhbmQgaWdub3JlcyBhbnkgdmlkZW8gDQo+
IEZJRk8gZXJyb3IgaW50ZXJydXB0cyBjYXVzZWQgYnkgYSB2aWRlbyByZXNldC4NCj4gDQo+IFsu
Li5dDQoNCkFwcGxpZWQsIHRoYW5rcyENCj4gdGhhbmtzIGV2ZXJ5b25lIGZvciB5b3VyIGhlbHAh
LCBJIHJlYWxseSBhcHByZWNpYXRlIGl0Lg0KDQpbMS8xXSBkcm0vYnJpZGdlOiBpdDY1MDU6IGZp
eCBoaWJlcm5hdGUgdG8gcmVzdW1lIG5vIGRpc3BsYXkgaXNzdWUNCiAgICAgIGh0dHBzOi8vY2dp
dC5mcmVlZGVza3RvcC5vcmcvZHJtL2RybS1taXNjL2NvbW1pdC8/aWQ9NDg0NDM2ZWM1YzJiDQoN
Cg0KDQpSb2INCg0K

