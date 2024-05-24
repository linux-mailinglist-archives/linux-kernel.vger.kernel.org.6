Return-Path: <linux-kernel+bounces-188246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4C08CDFA6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED2F281A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7E3612D;
	Fri, 24 May 2024 03:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="ab04E9kI"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EE11E892;
	Fri, 24 May 2024 03:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520247; cv=none; b=FM5TwtnMbrq0Qx/qq7/dgI2Z8mWmdjGeAjSFdEGaIOjBoxMPVLlU46OTRO1iYQWQhr/2RScyNT1AiKHs0VSIBy8S30CxccPTKQJ5NcjCW0wOK3Vxi99gyZ2R4gJeo/BPsRZkF4Y0MGod6RpOcynMS/3p7oPdtb9C9fiilrqPS5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520247; c=relaxed/simple;
	bh=35hAnMAszlYmdFcThlQeui5ttgFyoZ0svuwlgFn+DxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=NxsvmL5PgHf3VwjnsWt/MawO14i/pWu2GyZvhMatBrqwOWpMvaqZV7P6BnMm0dpm8lg9eN+p2UONrDPoheEDlht13IGuFdL4LHWM6/UkekxqpUyibwVJvEg+i65CDbyEtphnEU1oGieYjxy1cScLQH1chHYEv0h1TvEfVtl7jAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=ab04E9kI reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=E7quKQSp6wqPBOxJtlAAvy+lNHP6WJxdOO82/8s9fPk=; b=a
	b04E9kI7+OdT2yaqDGkR1UikXvmVRXIvdlsY3/Qze5/0STZ5xcfYjosylhz5X4vc
	5btnBuK3OwEK76Ea49B49RsBtiaCYmLN813AVmmV0i7FAqPRRLM8W4EymUSNBtk7
	Fjd8x5+ydNDKtpytKxbVI+IgYxjIXc4lkxeBiOJnSc=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-137 (Coremail) ; Fri, 24 May 2024 11:09:26 +0800
 (CST)
Date: Fri, 24 May 2024 11:09:26 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Detlev Casanova" <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, "Sandy Huang" <hjc@rock-chips.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	"Andy Yan" <andy.yan@rock-chips.com>, 
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, 
	"Maxime Ripard" <mripard@kernel.org>, 
	"Thomas Zimmermann" <tzimmermann@suse.de>, 
	"David Airlie" <airlied@gmail.com>, 
	"Daniel Vetter" <daniel@ffwll.ch>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Heiko Stuebner" <heiko.stuebner@cherry.de>, 
	"Sebastian Reichel" <sebastian.reichel@collabora.com>, 
	"Dragan Simic" <dsimic@manjaro.org>, 
	"Chris Morgan" <macromorgan@hotmail.com>, 
	"Diederik de Haas" <didi.debian@cknow.org>, 
	"Boris Brezillon" <boris.brezillon@collabora.com>, 
	dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re:[PATCH v2 1/3] vop2: Add clock resets support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240522185924.461742-2-detlev.casanova@collabora.com>
References: <20240522185924.461742-1-detlev.casanova@collabora.com>
 <20240522185924.461742-2-detlev.casanova@collabora.com>
X-NTES-SC: AL_Qu2aBPmZv0kt4CKRYukZnEobh+Y5UcK2s/ki2YFXN5k0iiXU6CEOXlxdIkXL1MCdLxyrkzuuXCZcxvRRTZhhQYZ9GRoRGOM2Exvvy1jUA6OU
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6a3d3fb1.3755.18fa893239e.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wDH7_DmBFBmSo1FAA--.362W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEB7oXmVOEKBR3wACsv
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIERldGxldu+8jAoKCkF0IDIwMjQtMDUtMjMgMDI6NTc6NDgsICJEZXRsZXYgQ2FzYW5vdmEi
IDxkZXRsZXYuY2FzYW5vdmFAY29sbGFib3JhLmNvbT4gd3JvdGU6Cj5BdCB0aGUgZW5kIG9mIGlu
aXRpYWxpemF0aW9uLCBlYWNoIFZQIGNsb2NrIG5lZWRzIHRvIGJlIHJlc2V0IGJlZm9yZQo+dGhl
eSBjYW4gYmUgdXNlZC4KPgo+RmFpbGluZyB0byBkbyBzbyBjYW4gcHV0IHRoZSBWT1AgaW4gYW4g
dW5kZWZpbmVkIHN0YXRlIHdoZXJlIHRoZQo+Z2VuZXJhdGVkIEhETUkgc2lnbmFsIGlzIGVpdGhl
ciBsb3N0IG9yIG5vdCBtYXRjaGluZyB0aGUgc2VsZWN0ZWQgbW9kZS4KCldvdWxkIHlvdSBwbGVh
c2UgcHJvdmlkZSBhIGRldGFpbGVkIGRlc2NyaXB0aW9uIG9mIHlvdXIgdGVzdCBjYXNlPwoKCj4K
PlNpZ25lZC1vZmYtYnk6IERldGxldiBDYXNhbm92YSA8ZGV0bGV2LmNhc2Fub3ZhQGNvbGxhYm9y
YS5jb20+Cj4tLS0KPiBkcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcDIu
YyB8IDMwICsrKysrKysrKysrKysrKysrKysrCj4gMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlv
bnMoKykKPgo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9k
cm1fdm9wMi5jIGIvZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV92b3AyLmMK
PmluZGV4IGZkZDc2OGJiZDQ4N2MuLmU4MWE2NzE2MWQyOWEgMTAwNjQ0Cj4tLS0gYS9kcml2ZXJz
L2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcDIuYwo+KysrIGIvZHJpdmVycy9ncHUv
ZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV92b3AyLmMKPkBAIC0xNyw2ICsxNyw3IEBACj4gI2lu
Y2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgo+ICNpbmNsdWRlIDxsaW51eC9wbV9ydW50
aW1lLmg+Cj4gI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPgo+KyNpbmNsdWRlIDxsaW51eC9yZXNl
dC5oPgo+ICNpbmNsdWRlIDxsaW51eC9zd2FiLmg+Cj4gCj4gI2luY2x1ZGUgPGRybS9kcm0uaD4K
PkBAIC0xNTcsNiArMTU4LDcgQEAgc3RydWN0IHZvcDJfd2luIHsKPiBzdHJ1Y3Qgdm9wMl92aWRl
b19wb3J0IHsKPiAJc3RydWN0IGRybV9jcnRjIGNydGM7Cj4gCXN0cnVjdCB2b3AyICp2b3AyOwo+
KwlzdHJ1Y3QgcmVzZXRfY29udHJvbCAqZGNsa19yc3Q7Cj4gCXN0cnVjdCBjbGsgKmRjbGs7Cj4g
CXVuc2lnbmVkIGludCBpZDsKPiAJY29uc3Qgc3RydWN0IHZvcDJfdmlkZW9fcG9ydF9kYXRhICpk
YXRhOwo+QEAgLTE5MTUsNiArMTkxNywyNiBAQCBzdGF0aWMgaW50IHVzX3RvX3ZlcnRpY2FsX2xp
bmUoc3RydWN0IGRybV9kaXNwbGF5X21vZGUgKm1vZGUsIGludCB1cykKPiAJcmV0dXJuIHVzICog
bW9kZS0+Y2xvY2sgLyBtb2RlLT5odG90YWwgLyAxMDAwOwo+IH0KPiAKPitzdGF0aWMgaW50IHZv
cDJfY2xrX3Jlc2V0KHN0cnVjdCB2b3AyX3ZpZGVvX3BvcnQgKnZwKQo+K3sKPisJc3RydWN0IHJl
c2V0X2NvbnRyb2wgKnJzdGMgPSB2cC0+ZGNsa19yc3Q7Cj4rCXN0cnVjdCB2b3AyICp2b3AyID0g
dnAtPnZvcDI7Cj4rCWludCByZXQ7Cj4rCj4rCWlmICghcnN0YykKPisJCXJldHVybiAwOwoKCklu
IGZhY3QsIHRoaXMgY2hlY2sgaXMgbm90IG5lY2Vzc2FyeSBoZXJlLiAgVGhlIGZvbGxvd2luZyBy
ZXNldCBjb250cm9sIGFwaSB3aWxsIGNoZWNrIGZvciBOVUxMIHBvaW50ZXLjgIIKCj4rCj4rCXJl
dCA9IHJlc2V0X2NvbnRyb2xfYXNzZXJ0KHJzdGMpOwo+KwlpZiAocmV0IDwgMCkKPisJCWRybV93
YXJuKHZvcDItPmRybSwgImZhaWxlZCB0byBhc3NlcnQgcmVzZXRcbiIpOwo+Kwl1ZGVsYXkoMTAp
Owo+KwlyZXQgPSByZXNldF9jb250cm9sX2RlYXNzZXJ0KHJzdGMpOwo+KwlpZiAocmV0IDwgMCkK
PisJCWRybV93YXJuKHZvcDItPmRybSwgImZhaWxlZCB0byBkZWFzc2VydCByZXNldFxuIik7Cj4r
Cj4rCXJldHVybiByZXQ7Cj4rfQo+Kwo+IHN0YXRpYyB2b2lkIHZvcDJfY3J0Y19hdG9taWNfZW5h
YmxlKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywKPiAJCQkJICAgIHN0cnVjdCBkcm1fYXRvbWljX3N0
YXRlICpzdGF0ZSkKPiB7Cj5AQCAtMjA1NSw2ICsyMDc3LDggQEAgc3RhdGljIHZvaWQgdm9wMl9j
cnRjX2F0b21pY19lbmFibGUoc3RydWN0IGRybV9jcnRjICpjcnRjLAo+IAo+IAl2b3AyX3ZwX3dy
aXRlKHZwLCBSSzM1NjhfVlBfRFNQX0NUUkwsIGRzcF9jdHJsKTsKPiAKPisJdm9wMl9jbGtfcmVz
ZXQodnApOwo+Kwo+IAlkcm1fY3J0Y192Ymxhbmtfb24oY3J0Yyk7Cj4gCj4gCXZvcDJfdW5sb2Nr
KHZvcDIpOwo+QEAgLTI3MDYsNiArMjczMCwxMiBAQCBzdGF0aWMgaW50IHZvcDJfY3JlYXRlX2Ny
dGNzKHN0cnVjdCB2b3AyICp2b3AyKQo+IAkJdnAtPmRhdGEgPSB2cF9kYXRhOwo+IAo+IAkJc25w
cmludGYoZGNsa19uYW1lLCBzaXplb2YoZGNsa19uYW1lKSwgImRjbGtfdnAlZCIsIHZwLT5pZCk7
Cj4rCQl2cC0+ZGNsa19yc3QgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsKHZvcDIt
PmRldiwgZGNsa19uYW1lKTsKPisJCWlmIChJU19FUlIodnAtPmRjbGtfcnN0KSkgewo+KwkJICAg
ICAgICBkcm1fZXJyKHZvcDItPmRybSwgImZhaWxlZCB0byBnZXQgJXMgcmVzZXRcbiIsIGRjbGtf
bmFtZSk7Cj4rCQkgICAgICAgIHJldHVybiBQVFJfRVJSKHZwLT5kY2xrX3JzdCk7Cj4rCQl9Cj4r
Cj4gCQl2cC0+ZGNsayA9IGRldm1fY2xrX2dldCh2b3AyLT5kZXYsIGRjbGtfbmFtZSk7Cj4gCQlp
ZiAoSVNfRVJSKHZwLT5kY2xrKSkgewo+IAkJCWRybV9lcnIodm9wMi0+ZHJtLCAiZmFpbGVkIHRv
IGdldCAlc1xuIiwgZGNsa19uYW1lKTsKPi0tIAo+Mi40NC4xCj4KPgo+X19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0Cj5saW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

