Return-Path: <linux-kernel+bounces-341269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C83987D74
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218691F25857
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 04:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7451714B8;
	Fri, 27 Sep 2024 04:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="lAZidF9G"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182491684A8
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 04:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409988; cv=none; b=A5gQJDwiuriIZJR7487TNT/ahhDcZeMUCUJU5AeqARJQIui6TLXuNeEL05iv+8q1AxCE6sSKsocXsC0bPxpKnYhdAlN6FJDyvZmrUqpxynkQEgXy5+pihHHBgIOYU7abv6aX4Ebp9v/b6KVKuKYwtIgygIZ76HYI8pmiCxzvCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409988; c=relaxed/simple;
	bh=Wrj7ZQBMYVoa1Wydqxm972EtHAZDMJvuDVB7Rdlyo88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JAODeRROSe7D1dLTCnJDSX81mTUCeQkr0D8fQN27c714tUx0gr0vlqI2QsMTI5Ehu1w2KZXMEwB5/Iqc9jdUMc3e5kd2Bo6C2lpTm0MuEGm3k8qgmrYShfRJmXXghpM2Et/g0eBb4Y29w5gI6AUeoR3PpkYYAY9Pye1hNuhdoIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=lAZidF9G reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wrj7ZQBMYVoa1Wydqxm972EtHAZDMJvuDVB7Rdlyo88=;
  b=lAZidF9GevjySuH1xNbQY/IUWhYZ6IKGqSywFuTVCRmpCrJSRYcT6hyB
   V0F4R6Wt+++oJx8+MfTSK5lkwb7TZggfbcVrm3YjLOlePSLCB9XJAoqz4
   XzP8OPj01/QlxEw+lbRePW19S1q9yuxTeqK1sc7ggzw91jJEtGTZmwJwn
   togqwhv9mT4Jl5lnyDt+a+6+94cGSSye4IojCfXs7dmn5+EwVMmcyVQuA
   iLluAEPNRta5pXaROm4riDSLoMgE6l7lO9j81dYESdA1/I2KnPv+p6CTs
   5gMAQBZEtHDZXdHrqDcdsuQmXiD6BsRcv6/VqcJz5B45P1WimoaBcBS1A
   w==;
X-CSE-ConnectionGUID: 9Lt1dNN1TZiXYSS+Ca+7JA==
X-CSE-MsgGUID: 9/nk258PQ5me0LbvWpW2jg==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 27 Sep 2024 12:06:23 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48R46Lu2033109;
	Fri, 27 Sep 2024 12:06:21 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from TPEMAIL1.internal.ite.com.tw (192.168.15.58) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 12:06:21 +0800
Received: from TPEMAIL1.internal.ite.com.tw ([fe80::dd6d:92:8773:b68]) by
 TPEMAIL1.internal.ite.com.tw ([fe80::dd6d:92:8773:b68%6]) with mapi id
 15.01.2507.039; Fri, 27 Sep 2024 12:06:21 +0800
From: <Hermes.Wu@ite.com.tw>
To: <dmitry.baryshkov@linaro.org>
CC: <Kenneth.Hung@ite.com.tw>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <angelogioacchino.delregno@collabora.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 05/11] drm/bridge: it6505: increase supports of HDCP
 repeater ksv devices
Thread-Topic: [PATCH v4 05/11] drm/bridge: it6505: increase supports of HDCP
 repeater ksv devices
Thread-Index: AQHbD+sd3qzcwRskzkCj5hXUt0VncbJq/O0g
Date: Fri, 27 Sep 2024 04:06:21 +0000
Message-ID: <a0b998672b6644598f8d6664de229eec@ite.com.tw>
References: <20240926075018.22328-1-Hermes.Wu@ite.com.tw>
 <xyi4czye2dwqmh6iaschacduwxm52oaipbt5ulvlmalamkzwbc@6gt5endjo6gl>
In-Reply-To: <xyi4czye2dwqmh6iaschacduwxm52oaipbt5ulvlmalamkzwbc@6gt5endjo6gl>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: 9BDC319A240BA0D8F03BA8C2D3BF4F71DB54F08FB2F5D7E4747E572ADD55CFED2002:8
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:mse.ite.com.tw 48R46Lu2033109

Pg0KPg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRG1pdHJ5IEJhcnlzaGtv
diA8ZG1pdHJ5LmJhcnlzaGtvdkBsaW5hcm8ub3JnPiANCj5TZW50OiBUaHVyc2RheSwgU2VwdGVt
YmVyIDI2LCAyMDI0IDQ6MDcgUE0NCj5UbzogSGVybWVzIFd1ICinZKjOp7spIDxIZXJtZXMuV3VA
aXRlLmNvbS50dz4NCj5DYzogS2VubmV0aCBIdW5nICiseK5hrdspIDxLZW5uZXRoLkh1bmdAaXRl
LmNvbS50dz47IEFuZHJ6ZWogSGFqZGEgPGFuZHJ6ZWouaGFqZGFAaW50ZWwuY29tPjsgTmVpbCBB
cm1zdHJvbmcgPG5laWwuYXJtc3Ryb25nQGxpbmFyby5vcmc+OyBSb2JlcnQgRm9zcyA8cmZvc3NA
a2VybmVsLm9yZz47IExhdXJlbnQgUGluY2hhcnQgPExhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJv
YXJkLmNvbT47IEpvbmFzIEthcmxtYW4gPGpvbmFzQGt3aWJvby5zZT47IEplcm5laiBTa3JhYmVj
IDxqZXJuZWouc2tyYWJlY0BnbWFpbC5jb20+OyBNYWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5s
YW5raG9yc3RAbGludXguaW50ZWwuY29tPjsgTWF4aW1lIFJpcGFyZCA8bXJpcGFyZEBrZXJuZWwu
b3JnPjsgVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+OyBEYXZpZCBBaXJs
aWUgPGFpcmxpZWRAZ21haWwuY29tPjsgU2ltb25hIFZldHRlciA8c2ltb25hQGZmd2xsLmNoPjsg
QWxsZW4gQ2hlbiA8YWxsZW4uY2hlbkBpdGUuY29tLnR3PjsgQW5nZWxvR2lvYWNjaGlubyBEZWwg
UmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT47IG9wZW4gbGlz
dDpEUk0gRFJJVkVSUyA8ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz47IG9wZW4gbGlz
dCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0
IDA1LzExXSBkcm0vYnJpZGdlOiBpdDY1MDU6IGluY3JlYXNlIHN1cHBvcnRzIG9mIEhEQ1AgcmVw
ZWF0ZXIga3N2IGRldmljZXMNCj4NCj5PbiBUaHUsIFNlcCAyNiwgMjAyNCBhdCAwMzo1MDoxNFBN
IEdNVCwgSGVybWVzIFd1IHdyb3RlOg0KPj4gRnJvbTogSGVybWVzIFd1IDxIZXJtZXMud3VAaXRl
LmNvbS50dz4NCj4+IA0KPj4gQSBIRENQIHNvdXJjZSBzaGFsbCBzdXBwb3J0IG1heCBkb3duc3Ry
ZWFtIGRldmljZSB0byAxMjcuDQo+PiANCj4+IENoYW5nZSBkZWZpbml0aW9uIG9mIE1BWF9IRENQ
X0RPV05fU1RSRUFNX0NPVU5UIHRvIDEyNw0KPg0KPlRoaXMgcmVzdWx0cyBpbiBzdHJ1Y3QgaXQ2
NTA1IGdyb3d0aCBieSB+MC41IEtpQi4gUGxlYXNlIG1lbnRpb24gaXQgaW4gdGhlIGNvbW1pdCBt
ZXNzYWdlLg0KPg0KPklzIGl0IHJlYWxseSByZXF1aXJlZCB0byBoYXZlIHNoYTFfaW5wdXQgaW4g
dGhlIGNvbnN0YW50bHkgYWxsb2NhdGVkIHN0cnVjdHVyZT8gSSB0aGluayBpdCdzIGEgdGVtcG9y
YXJ5IGRhdGEsIHdoaWNoIGlzbid0IG5lY2Vzc2FyeSBhZnRlciBwcm9jZXNzaW5nLg0KPg0KDQpG
b3IgSERDUCwgS1NWIGxpc3QgbXVzdCBzdG9yZSBmb3IgRFJNIGNoZWNrLCBjb25zdGFudGx5IGFs
bG9jYXRlZCBpcyBuZWNlc3NhcnkuDQoNCj4+IA0KPj4gRml4ZXM6IGI1Yzg0YTllZGNkNCAoImRy
bS9icmlkZ2U6IGFkZCBpdDY1MDUgZHJpdmVyIikNCj4+IFNpZ25lZC1vZmYtYnk6IEhlcm1lcyBX
dSA8SGVybWVzLnd1QGl0ZS5jb20udHc+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2dwdS9kcm0vYnJp
ZGdlL2l0ZS1pdDY1MDUuYyB8IDIgKy0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9i
cmlkZ2UvaXRlLWl0NjUwNS5jIA0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2l0ZS1pdDY1
MDUuYw0KPj4gaW5kZXggZDFmNTIyMGUwNGE2Li41ZDVjZTEyY2QwNTQgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2l0ZS1pdDY1MDUuYw0KPj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2JyaWRnZS9pdGUtaXQ2NTA1LmMNCj4+IEBAIC0yOTYsNyArMjk2LDcgQEANCj4+ICAj
ZGVmaW5lIE1BWF9MQU5FX0NPVU5UIDQNCj4+ICAjZGVmaW5lIE1BWF9MSU5LX1JBVEUgSEJSDQo+
PiAgI2RlZmluZSBBVVRPX1RSQUlOX1JFVFJZIDMNCj4+IC0jZGVmaW5lIE1BWF9IRENQX0RPV05f
U1RSRUFNX0NPVU5UIDEwDQo+PiArI2RlZmluZSBNQVhfSERDUF9ET1dOX1NUUkVBTV9DT1VOVCAx
MjcNCj4+ICAjZGVmaW5lIE1BWF9DUl9MRVZFTCAweDAzDQo+PiAgI2RlZmluZSBNQVhfRVFfTEVW
RUwgMHgwMw0KPj4gICNkZWZpbmUgQVVYX1dBSVRfVElNRU9VVF9NUyAxNQ0KPj4gLS0NCj4+IDIu
MzQuMQ0KPj4gDQo+DQo+LS0gDQo+V2l0aCBiZXN0IHdpc2hlcw0KPkRtaXRyeQ0KPg0KDQpCUiwN
Ckhlcm1lcw0K

