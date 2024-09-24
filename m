Return-Path: <linux-kernel+bounces-336487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119DB983B68
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2FD281683
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A2F12B93;
	Tue, 24 Sep 2024 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="bkSV6P5W"
Received: from ironport.ite.com.tw (HC210-202-87-179.vdslpro.static.apol.com.tw [210.202.87.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31A3B1A4
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727146640; cv=none; b=qMF43nK1Cd9P9V3ZeiDZZzSfA5IM5E9357ML4/f79UT96xb/fa4ZDALvBc9wLbVB1M+SUXem72SZGdUH4wQDcLSmD6maviEzE8p1i+2ctblJsqQSu2EcusHPHCtwyTKNrmikMfcOb8i5EC027tiUAO6jxaSG+f86YSa/Geg8MCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727146640; c=relaxed/simple;
	bh=Pez01GVTI+nAGe+V0h/GEhDzn9cAbuhuFih04e9gyZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LqTyWiK+AkKJM6ZbiozSrCiMSXgXqX00UqOAkLxuvgeGLh7bbvwZEy6p3p2p5N/FV2RJV4UAlC4ubZMOfkFoDAp13+sa7tCMPk5IQtonPYOiN7BQT6t9K8uUlXyzCrZw/5GuxnypFIFEPWKXUqvXA/GoMSIwR8vG7V3Ru9q3HwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=bkSV6P5W reason="key not found in DNS"; arc=none smtp.client-ip=210.202.87.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pez01GVTI+nAGe+V0h/GEhDzn9cAbuhuFih04e9gyZg=;
  b=bkSV6P5WH8MtzHUbwFejbkvodV2vsiKPVcwG57eX0HEs0w/VpoWX01oy
   lfM0G77K/erZKT8VI9QcBJEJ5cQhp+BBIebeSMJRaCA7SPZSuaYvJR+tA
   Uu1HOcG+tD+8z2IXzmy/2AbfdPndEjWPmfnMkhNNiM0RdQKZ2/+cyA5V/
   NoUqfaf3Xu93ZXD6SgxzrgScyeszH4ofr2o5Kc7tV45cPg9ZLM5xmGYQp
   GztSThc6n62sW9qDfUeNo00rLeIUVzLm0tCCPneHcIDBoEJdqhDUbHiAq
   o6ee/57YvaIxt98eNo0wlLbaSfAUQV5acRWRr7lq+i7QlOlJnnuhfilb0
   w==;
X-CSE-ConnectionGUID: hfp7j/ybSnG3IkO9gu66Sw==
X-CSE-MsgGUID: sTBYZWO7Q0uIwBMJBz/iww==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 24 Sep 2024 10:57:15 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48O2vBOJ047817;
	Tue, 24 Sep 2024 10:57:11 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from TPEMAIL1.internal.ite.com.tw (192.168.15.58) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 10:57:10 +0800
Received: from TPEMAIL1.internal.ite.com.tw ([fe80::dd6d:92:8773:b68]) by
 TPEMAIL1.internal.ite.com.tw ([fe80::dd6d:92:8773:b68%6]) with mapi id
 15.01.2507.039; Tue, 24 Sep 2024 10:57:10 +0800
From: <Hermes.Wu@ite.com.tw>
To: <dmitry.baryshkov@linaro.org>
CC: <treapking@chromium.org>, <Kenneth.Hung@ite.com.tw>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] drm/bridge: it6505: HDCP CTS fail on repeater
 items
Thread-Topic: [PATCH v3 2/3] drm/bridge: it6505: HDCP CTS fail on repeater
 items
Thread-Index: AQHbDaFxMxnMHj2GkEGHdgKCDl4eaLJlMDIw//+LvQCAAYOEgA==
Date: Tue, 24 Sep 2024 02:57:10 +0000
Message-ID: <169c171660ac4897903aef5befc780db@ite.com.tw>
References: <20240923094826.13471-1-Hermes.Wu@ite.com.tw>
 <20240923094826.13471-3-Hermes.Wu@ite.com.tw>
 <4viir5prnuvpp76npblwmdrwlttm5daumvdnocipdsn6geyxvf@2yfcytjb3ono>
 <a0a8f862018b4c9aa689672551e7a492@ite.com.tw>
 <mkx63gnb2fobxxc5jc2f326d2oviix7dahyoh4sfeuiyypucln@hnklvrtv4q2u>
In-Reply-To: <mkx63gnb2fobxxc5jc2f326d2oviix7dahyoh4sfeuiyypucln@hnklvrtv4q2u>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: 349B6BE6289B44C8306504438E8113A17A71BD20F204424E7C03870435E6C8B52002:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:mse.ite.com.tw 48O2vBOJ047817

Pk9uIE1vbiwgU2VwIDIzLCAyMDI0IGF0IDEwOjQ1OjQ5QU0gR01ULCBIZXJtZXMuV3VAaXRlLmNv
bS50dyB3cm90ZToNCj4+ID5PbiBNb24sIFNlcCAyMywgMjAyNCBhdCAwNTo0ODoyOFBNIEdNVCwg
SGVybWVzIFd1IHdyb3RlOg0KPj4gPj4gRnJvbTogSGVybWVzIFd1IDxIZXJtZXMud3VAaXRlLmNv
bS50dz4NCj4+ID4+IA0KPj4gPj4gQ2hhbmdlcyBpbiB2MzoNCj4+ID4+ICAtYWRkIGRldGlhbHMg
YWJvdXQgZmFpbCBpdGVtIGFuZCBjaGFuZ2VzLg0KPj4gPj4gDQo+PiA+PiANCj4+ID4+IEZpeCBI
RENQIENUUyBmYWlsIGl0ZW1zIG9uIFVOSUdSQUYgRFJQLTEwMA0KPj4gPj4gDQo+PiA+PiBEVVQg
bXVzdCBTdXBwb3J0IDEyNyBkZXZpY2VzLg0KPj4gPj4gRFVUIG11c3QgY2hlY2sgQlNUQVRVUyB3
aGVuIHJlY2VpdmUgQ1BfSVJRLg0KPj4gPj4gRFVUIG11c3QgZW5hYmxlIGVuY3J5cHRpb24gd2hl
biBSMCcgaXMgcmVhZHkuDQo+PiA+PiBEVVQgbXVzdCByZXRyeSBWJyBjaGVjayAzIHRpbWVzLg0K
Pj4gPj4gaXQ2NTA1IG11c3QgcmVhZCBEUlAtMTAwIEtTViBGSUZPIGJ5IEZJRk8gbW9kZS4NCj4+
ID4+IGl0NjUwNSBzaG91bGQgcmVzdGFydCBIRENQIHdpdGhpbiA1cyBpZiBLU1Ygbm90IHJlYWR5
Lg0KPj4gPg0KPj4gPlN0aWxsIG5vdCByZWFkYWJsZS4NCj4+ID4NCj4+ID5FbmdsaXNoIHRleHQs
IHBsZWFzZS4gU3BsaXQgdGhlIHBhdGNoIHRvIGZpeCBvbmUgaXNzdWUgYXQgYSB0aW1lLg0KPj4g
PkRlc2NyaWJlIHRoZSBfcmVhc29uXyBmb3IgdGhlIGNoYW5nZS4gQW5ub3RhdGUgZml4ZXMgd2l0
aCBGaXhlcyB0YWdzLg0KPj4gPg0KPj4gDQo+PiB3aXRoIGZpeGVzIHRhZyBpbmNsdWRlIGRybS9i
cmlkZ2UgbGlrZSB0aGlzID8gID0+ICJGaXhlczogZHJtL2JyaWRnZTogaXQ2NTA1OiBIRENQIENU
UyBmYWlsIDFCLXh4Ig0KPg0KPk5vLiBQbGVhc2UgcmVhZCB0aGUgZG9jdW1lbnQgdGhhdCBJIGhh
dmUgYmVlbiBwb2ludGluZyB5b3UgdG8uIEl0IGRlc2NyaWJlcyBhbGwgdGhlIHRhZ3MgYW5kIHBy
b2NlZHVyZXMuDQo+DQo+PiANCj4+IEFib3V0IHRoZSByZWFzb24gYWJvdXQgYnVnIGZpeGVzLiAN
Cj4+IA0KPj4gZm9yIGV4YW1wbGUsIHRoZSAxQi0wMSBkZXZpY2UgY291bnQuDQo+PiB3aWxsIHRo
aXMgcmVhZGFibGU/DQo+PiANCj4+ICIgV2hlbiBjb25uZWN0IHRvIEhEQ1AgcmVwZWF0ZXIsIGl0
NjUwNSBtdXN0IHN1cHBvcnQgMTI3IGRvd25zdHJlYW0gZGV2aWNlcy4gIg0KPj4gDQo+PiBBbmQg
dGhpcyB3aWxsIGJlIG9ubHkgb25lIGNoYW5nZSBpbiBhIHBhdGNoPw0KPg0KPkxldCBtZSByZXBl
YXQgdGhlIHBocmFzZSB0aGF0IHlvdSBoYXZlIHF1b3RlZCBmZXcgbGluZXMgYWJvdmUuICJTcGxp
dCB0aGUgcGF0Y2ggdG8gZml4IG9uZSBpc3N1ZSBhdCBhIHRpbWUuIiBTbywgbm8sIHRoaXMgd2ls
bCBub3QgYmUgdGhlIG9ubHkgY2hhbmdlIGluIHRoZSBwYXRjaC4NCj4NCg0KVGhlIEhEQ1AgQ1RT
IGluY2x1ZGUgc2VydmFsIGl0ZW1zLCBJIHNob3VsZCBzcGxpdCBlYWNoIGZhaWx1cmUgaXRlbSBm
aXhlcyBpbnRvIGRpZmZlcmVudCBwYXRjaD8NCg0KDQo+PiANCj4+ID4+IA0KPj4gPj4gU2lnbmVk
LW9mZi1ieTogSGVybWVzIFd1IDxIZXJtZXMud3VAaXRlLmNvbS50dz4NCj4+ID4+IC0tLQ0KPj4g
Pj4gIGRyaXZlcnMvZ3B1L2RybS9icmlkZ2UvaXRlLWl0NjUwNS5jIHwgMTEyIA0KPj4gPj4gKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCA3NCBpbnNl
cnRpb25zKCspLCAzOCBkZWxldGlvbnMoLSkNCj4+ID4NCj4+ID4tLQ0KPj4gPldpdGggYmVzdCB3
aXNoZXMNCj4+ID5EbWl0cnkNCj4+IA0KPj4gQlIsDQo+PiBIZXJtZXMNCj4NCj4tLQ0KPldpdGgg
YmVzdCB3aXNoZXMNCj5EbWl0cnkNCg==

