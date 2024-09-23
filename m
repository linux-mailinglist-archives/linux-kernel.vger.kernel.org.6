Return-Path: <linux-kernel+bounces-335747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D3997EA13
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F53B21774
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0CF195FF0;
	Mon, 23 Sep 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="PIGWxJ0+"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A41FDA
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088359; cv=none; b=trsrgcNDUiPBIUW47SN221KL4x6t3pTPIaim1tvSDDguOEPDkYhr8wi1p9T8t2CeOC7rg+rp555tXG4oCBFbrALnG5mg+ix8eLmBP9Pbw7KHRTsUKeDcthyUF4wONVGGrR2SLGkemfIzyuRH2fRned8Otw7crclMZNvwq1zYHs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088359; c=relaxed/simple;
	bh=yoBs70lI0nw+Cn15PKnMkP3pkXySdBMC1A7392unMcs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RL/5stEIMpSLvIIij9+nMFe91Pg9zZgxDbSXT2dPypGDeKFABLoVk/yYNh5itKnPVIEMw6dgVivvTzx2aQ6yiw7ZZl6l364tzKp0gK4eAhRSpKjTJHsoq8Y2uI803rfQpqXSbZFJKIMKkaXnn6vr4hIPnd5nEqxJvzJJqfYJAao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=PIGWxJ0+ reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yoBs70lI0nw+Cn15PKnMkP3pkXySdBMC1A7392unMcs=;
  b=PIGWxJ0+3dVVT6kgzUzdSSMm4B6beUiF/4JTM4U0LFhwbcTD1zlHeE9V
   Wen1qb1pKI1xVhoymA06dRNRRof2M2tHhdWh+sdzfoCIs8ubpM3cBkXhU
   /kOEABRCi81k2BNGS2hnOfIly8+6V/xex2Ls8AjwVB38sA+OsE7/9tu3j
   /alqGX+tBg40yVyHNeS0TXpeVvC+HfaKamJxuKEmh43+MQxR4hSx892I3
   f1nwida7rh0EJ9MKdvZjJlhgF3/MhIkkV/Ge6ZQcGg5xXh8voM4Ny/T3R
   qg9MCIq8panYJKCBJEtksWXTDfs7JZ3r/5CgKe0cJbs7N1Ln3TsTvCqCC
   A==;
X-CSE-ConnectionGUID: 1BS8BjG9Qfm952M928ZQIw==
X-CSE-MsgGUID: zeOnaio9SFq42SvrI1QCrg==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 23 Sep 2024 18:45:54 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48NAjm15039260;
	Mon, 23 Sep 2024 18:45:48 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from TPEMAIL1.internal.ite.com.tw (192.168.15.58) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 18:45:49 +0800
Received: from TPEMAIL1.internal.ite.com.tw ([fe80::dd6d:92:8773:b68]) by
 TPEMAIL1.internal.ite.com.tw ([fe80::dd6d:92:8773:b68%6]) with mapi id
 15.01.2507.039; Mon, 23 Sep 2024 18:45:49 +0800
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
Thread-Index: AQHbDaFxMxnMHj2GkEGHdgKCDl4eaLJlMDIw
Date: Mon, 23 Sep 2024 10:45:49 +0000
Message-ID: <a0a8f862018b4c9aa689672551e7a492@ite.com.tw>
References: <20240923094826.13471-1-Hermes.Wu@ite.com.tw>
 <20240923094826.13471-3-Hermes.Wu@ite.com.tw>
 <4viir5prnuvpp76npblwmdrwlttm5daumvdnocipdsn6geyxvf@2yfcytjb3ono>
In-Reply-To: <4viir5prnuvpp76npblwmdrwlttm5daumvdnocipdsn6geyxvf@2yfcytjb3ono>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: 4A944F3EAC0BF5D4DDFF7121E9A65BB68B7D77BDF3D758EC36039E013E91850C2002:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:mse.ite.com.tw 48NAjm15039260

Pk9uIE1vbiwgU2VwIDIzLCAyMDI0IGF0IDA1OjQ4OjI4UE0gR01ULCBIZXJtZXMgV3Ugd3JvdGU6
DQo+PiBGcm9tOiBIZXJtZXMgV3UgPEhlcm1lcy53dUBpdGUuY29tLnR3Pg0KPj4gDQo+PiBDaGFu
Z2VzIGluIHYzOg0KPj4gIC1hZGQgZGV0aWFscyBhYm91dCBmYWlsIGl0ZW0gYW5kIGNoYW5nZXMu
DQo+PiANCj4+IA0KPj4gRml4IEhEQ1AgQ1RTIGZhaWwgaXRlbXMgb24gVU5JR1JBRiBEUlAtMTAw
DQo+PiANCj4+IERVVCBtdXN0IFN1cHBvcnQgMTI3IGRldmljZXMuDQo+PiBEVVQgbXVzdCBjaGVj
ayBCU1RBVFVTIHdoZW4gcmVjZWl2ZSBDUF9JUlEuDQo+PiBEVVQgbXVzdCBlbmFibGUgZW5jcnlw
dGlvbiB3aGVuIFIwJyBpcyByZWFkeS4NCj4+IERVVCBtdXN0IHJldHJ5IFYnIGNoZWNrIDMgdGlt
ZXMuDQo+PiBpdDY1MDUgbXVzdCByZWFkIERSUC0xMDAgS1NWIEZJRk8gYnkgRklGTyBtb2RlLg0K
Pj4gaXQ2NTA1IHNob3VsZCByZXN0YXJ0IEhEQ1Agd2l0aGluIDVzIGlmIEtTViBub3QgcmVhZHku
DQo+DQo+U3RpbGwgbm90IHJlYWRhYmxlLg0KPg0KPkVuZ2xpc2ggdGV4dCwgcGxlYXNlLiBTcGxp
dCB0aGUgcGF0Y2ggdG8gZml4IG9uZSBpc3N1ZSBhdCBhIHRpbWUuDQo+RGVzY3JpYmUgdGhlIF9y
ZWFzb25fIGZvciB0aGUgY2hhbmdlLiBBbm5vdGF0ZSBmaXhlcyB3aXRoIEZpeGVzIHRhZ3MuDQo+
DQoNCndpdGggZml4ZXMgdGFnIGluY2x1ZGUgZHJtL2JyaWRnZSBsaWtlIHRoaXMgPyAgPT4gIkZp
eGVzOiBkcm0vYnJpZGdlOiBpdDY1MDU6IEhEQ1AgQ1RTIGZhaWwgMUIteHgiDQoNCkFib3V0IHRo
ZSByZWFzb24gYWJvdXQgYnVnIGZpeGVzLiANCg0KZm9yIGV4YW1wbGUsIHRoZSAxQi0wMSBkZXZp
Y2UgY291bnQuDQp3aWxsIHRoaXMgcmVhZGFibGU/DQoNCiIgV2hlbiBjb25uZWN0IHRvIEhEQ1Ag
cmVwZWF0ZXIsIGl0NjUwNSBtdXN0IHN1cHBvcnQgMTI3IGRvd25zdHJlYW0gZGV2aWNlcy4gIg0K
DQpBbmQgdGhpcyB3aWxsIGJlIG9ubHkgb25lIGNoYW5nZSBpbiBhIHBhdGNoPw0KDQo+PiANCj4+
IFNpZ25lZC1vZmYtYnk6IEhlcm1lcyBXdSA8SGVybWVzLnd1QGl0ZS5jb20udHc+DQo+PiAtLS0N
Cj4+ICBkcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2l0ZS1pdDY1MDUuYyB8IDExMiArKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKyks
IDM4IGRlbGV0aW9ucygtKQ0KPg0KPi0tIA0KPldpdGggYmVzdCB3aXNoZXMNCj5EbWl0cnkNCg0K
QlIsDQpIZXJtZXMNCg==

