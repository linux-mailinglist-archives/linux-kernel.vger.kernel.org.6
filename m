Return-Path: <linux-kernel+bounces-573192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7A3A6D413
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6793A838B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D5017E01B;
	Mon, 24 Mar 2025 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="ITGIpFyp"
Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CD62A1CA;
	Mon, 24 Mar 2025 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796998; cv=none; b=BA1bHO7KVOl+FCoIfF72fIlYMFZwWuvPWfhhzqkkgxKU+5zv7BCxje91pzFjZrtqo50RU2gYZ+D0idaJZwuyZbC1ckLoby0MT+aim9TTX2heXmOe9MbMpRpu1pmeQGly9db6ITD85Dj8eWF3VKhMLm33h3apwEa4lFSRxq9JmB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796998; c=relaxed/simple;
	bh=9eSSfttpcw0lJBajJNCu7ORS5sYa5GsLsfivP46rMak=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=N7SdqVpFsxU0t+9+cWch6pww6EHz+5EDEBH5x5XoUxpAI81MJ7pKkL/xTjunXsk6SuZp1Rs3ZySYOo5wXLAaSPBC75YyRxPb7wOYoP5dIooQrn2ieqfQ36+yf82POWRbtVFG33OW4kznM3JaSTF5SXoj2Rg71EY9xAYZMn7uiD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=ITGIpFyp; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.3])
	by mail.crpt.ru  with ESMTP id 52O6FoPN018457-52O6FoPP018457
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Mon, 24 Mar 2025 09:15:50 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex1.crpt.local (192.168.60.3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 24 Mar
 2025 09:15:50 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Mon, 24 Mar 2025 09:15:50 +0300
From: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>
To: Michael Turquette <mturquette@baylibre.com>
CC: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>, Stephen Boyd <sboyd@kernel.org>, Michal Simek
	<michal.simek@amd.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH] soc: xilinx: vcu: modify the order of devices unregistration
Thread-Topic: [PATCH] soc: xilinx: vcu: modify the order of devices
 unregistration
Thread-Index: AQHbnIQwE54gprkZdUqVTZP34SoMOg==
Date: Mon, 24 Mar 2025 06:15:49 +0000
Message-ID: <20250324061543.15150-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX1.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 2/17/2025 9:52:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 192.168.60.3
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=9eSSfttpcw0lJBajJNCu7ORS5sYa5GsLsfivP46rMak=;
 b=ITGIpFypKaB6RSoCLt1/wetbTrDJMw+CmjIoqPiHBS5QO/3pp4Mcdri1sahof3hzEDt7wquw5fAR
	AYRSdBTgKbOoargnFt83PAPCT6GqQMCnUP/xR4vPs9qwtcy6/OTD/PkFacUgxbUdjjv4wyK7CKmA
	cAAMRaZsrW1WS2np15fSBSK5ENdFaxVMBROJ8spJPKbXAVHwcukg3hLj4POA+hokV1wnJsS3/EJN
	XF+LhWtB7gjKeO1fY2o4Q3C3ZYYEyHXBAtSRPyqjohsQARiT9YsEaAk4fo9eqkpJn18rKwMuoMnE
	3W0oVQo7l55qoSkufvQwwKUQA/1Ppoc5+9yBNg==

RnJvbTogQW5kcmV5IFZhdG9yb3BpbiA8YS52YXRvcm9waW5AY3JwdC5ydT4NCg0KVGhlIG9yZGVy
IG9mIHJlZ2lzdHJhdGlvbiBvZiAnc3RydWN0IGNsa19odycgaGFuZGxlcyBpbg0KeHZjdV9jbGtf
aHdfcmVnaXN0ZXJfbGVhZigpIGRvZXMgbm90IGNvcnJlc3BvbmQgdGhlIG9yZGVyIG9mDQp1bnJl
Z2lzdHJhdGlvbiBwZXJmb3JtZWQgaW4geHZjdV9jbGtfaHdfdW5yZWdpc3Rlcl9sZWFmKCkuDQoN
CkNsZWFuIHVwIHRoZSBvcmRlciBhbmQgcmVwbGFjZSB0aGUgZHVwbGljYXRlICFkaXZpZGVyIGNo
ZWNrIHdpdGggYSBtb3JlDQphcHByb3ByaWF0ZSBvbmUuDQoNCkZvdW5kIGJ5IExpbnV4IFZlcmlm
aWNhdGlvbiBDZW50ZXIgKGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU1ZBQ0UuDQoNClNpZ25lZC1v
ZmYtYnk6IEFuZHJleSBWYXRvcm9waW4gPGEudmF0b3JvcGluQGNycHQucnU+DQotLS0NCiBkcml2
ZXJzL2Nsay94aWxpbngveGxueF92Y3UuYyB8IDYgKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xr
L3hpbGlueC94bG54X3ZjdS5jIGIvZHJpdmVycy9jbGsveGlsaW54L3hsbnhfdmN1LmMNCmluZGV4
IDgxNTAxYjQ4NDEyZS4uZTRiMDhmNTAxOTU4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsveGls
aW54L3hsbnhfdmN1LmMNCisrKyBiL2RyaXZlcnMvY2xrL3hpbGlueC94bG54X3ZjdS5jDQpAQCAt
NTExLDExICs1MTEsMTEgQEAgc3RhdGljIHZvaWQgeHZjdV9jbGtfaHdfdW5yZWdpc3Rlcl9sZWFm
KHN0cnVjdCBjbGtfaHcgKmh3KQ0KIAkJcmV0dXJuOw0KIA0KIAltdXggPSBjbGtfaHdfZ2V0X3Bh
cmVudChkaXZpZGVyKTsNCi0JY2xrX2h3X3VucmVnaXN0ZXJfbXV4KG11eCk7DQotCWlmICghZGl2
aWRlcikNCisJY2xrX2h3X3VucmVnaXN0ZXJfZGl2aWRlcihkaXZpZGVyKTsNCisJaWYgKCFtdXgp
DQogCQlyZXR1cm47DQogDQotCWNsa19od191bnJlZ2lzdGVyX2RpdmlkZXIoZGl2aWRlcik7DQor
CWNsa19od191bnJlZ2lzdGVyX211eChtdXgpOw0KIH0NCiANCiBzdGF0aWMgaW50IHh2Y3VfcmVn
aXN0ZXJfY2xvY2tfcHJvdmlkZXIoc3RydWN0IHh2Y3VfZGV2aWNlICp4dmN1KQ0KLS0gDQoyLjQz
LjANCg==

