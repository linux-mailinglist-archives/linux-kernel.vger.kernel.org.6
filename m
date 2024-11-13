Return-Path: <linux-kernel+bounces-406947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE5E9C6685
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710ACB24641
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE0D13AC1;
	Wed, 13 Nov 2024 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="EU8hazD+"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A322309AC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 01:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460671; cv=none; b=els3zD11ijziKehhUs4hMA1IDfG8IEijFFWAIFy8WP2GtIjlbNzwyVgBElCUAUYcDyDdBLFPv9jMZg1Nh4lhNeFoK4h8/eXN5mjxpNqNeEAkcN0Y9jnpszPNMydQ7HJ9eF4NBvzEYWBJhQ3Frukc0hHGJtuuwdAagk9cQ4YjRR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460671; c=relaxed/simple;
	bh=niYGqHGfBIAIT4DVvp9SufqlWgazwxP2IOTBECijsU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=BK/AYpZXSkl47XZ6+1yNojhyDcgToGkXt8wq2GA3VWlOxOru1g7/bvpVkaeI16PMWLNKeIMUDecCP9jxhF3fb28j0XknAeRX2uZL85u3PfqotZwLGxQyBWmroLqPDxycl1ZXKSteznngRdVJYjWkZWWUUT3MBWzOxAglVEwb8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=EU8hazD+ reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=fZZMT+/Mq1IzQAs8XttbFYcD4jt6sLWoadgWnzFFMgI=; b=E
	U8hazD+bQ+l5AfskLn/jugyDjzXaPEQ4avhYDLxkgiJ4l7Xpze87V0YMGaDtzJnA
	PrQKW6fa1oNO5SAna9Xmqk/W4HcXzecT6w4NQTfrZGM6xpX9ijKVnRxznzmLX29/
	y2zXOcLr9m5H5FHalDHS5VDn1JIDQAkZIhWXV2zB50=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-129 (Coremail) ; Wed, 13 Nov 2024 09:16:49 +0800
 (CST)
Date: Wed, 13 Nov 2024 09:16:49 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Heiko Stuebner" <heiko@sntech.de>
Cc: quentin.schulz@theobroma-systems.com, hjc@rock-chips.com, 
	andy.yan@rock-chips.com, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"Heiko Stuebner" <heiko.stuebner@cherry.de>, 
	sebastian.reichel@collabora.com
Subject: Re:[PATCH 1/2] drm/rockchip: vop2: fix rk3588 dp+dsi maxclk
 verification
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240425195506.2935955-2-heiko@sntech.de>
References: <20240425195506.2935955-1-heiko@sntech.de>
 <20240425195506.2935955-2-heiko@sntech.de>
X-NTES-SC: AL_Qu2YA/idv04r7ySbY+kZnEobh+Y5UcK2s/ki2YFXN5k0mCTmyg4+bG5cLH7q9fmiKiCmoQmLURl14P5jTa5KbpiYvcCAmhgeX8QvpwslBgwR
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4cbc446f.f07.193231835a1.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gSgvCgDHTywB_jNnjV0lAA--.56349W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMx2WXmcz+UKPeAACs8
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CisgU2ViYXN0aW5hLApIaSBTZWJhc3RpYW4sICBJIHRoaW5rIHlvdSBhbHNvIG5lZWQgdGhpcyBw
YXRjaCB3aGVuIHlvdSB0ZXN0IERTSSBvbiByazM1ODggd2l0aCAgRFNJMiBzdXBwb3J0IHBhdGNo
IGZyb20gSGVpa28uCgpBdCAyMDI0LTA0LTI2IDAzOjU1OjA1LCAiSGVpa28gU3R1ZWJuZXIiIDxo
ZWlrb0BzbnRlY2guZGU+IHdyb3RlOgo+RnJvbTogSGVpa28gU3R1ZWJuZXIgPGhlaWtvLnN0dWVi
bmVyQGNoZXJyeS5kZT4KPgo+VGhlIGNsb2NrIGlzIGluIEh6IHdoaWxlIHRoZSB2YWx1ZSBjaGVj
a2VkIGFnYWluc3QgaXMgaW4ga0h6LCBzbwo+YWN0dWFsIGZyZXF1ZW5jaWVzIHdpbGwgbmV2ZXIg
YmUgYWJsZSB0byBiZSBiZWxvdyB0byBtYXggdmFsdWUuCj5GaXggdGhpcyBieSBzcGVjaWZ5aW5n
IHRoZSBtYXgtdmFsdWUgaW4gSHogdG9vLgo+Cj5GaXhlczogNWEwMjhlOGYwNjJmICgiZHJtL3Jv
Y2tjaGlwOiB2b3AyOiBBZGQgc3VwcG9ydCBmb3IgcmszNTg4IikKPlNpZ25lZC1vZmYtYnk6IEhl
aWtvIFN0dWVibmVyIDxoZWlrby5zdHVlYm5lckBjaGVycnkuZGU+Cj4tLS0KPiBkcml2ZXJzL2dw
dS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcDIuYyB8IDQgKystLQo+IDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcDIuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fdm9wMi5jCj5pbmRleCA5YmVlMWZkODhlNmEyLi41MjM4
ODBhNGU4ZTc0IDEwMDY0NAo+LS0tIGEvZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlw
X2RybV92b3AyLmMKPisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1f
dm9wMi5jCj5AQCAtMTcxOSw3ICsxNzE5LDcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgcmszNTg4
X2NhbGNfY3J1X2NmZyhzdHJ1Y3Qgdm9wMl92aWRlb19wb3J0ICp2cCwgaW50IGlkLAo+IAkJZWxz
ZQo+IAkJCWRjbGtfb3V0X3JhdGUgPSB2X3BpeGNsayA+PiAyOwo+IAo+LQkJZGNsa19yYXRlID0g
cmszNTg4X2NhbGNfZGNsayhkY2xrX291dF9yYXRlLCA2MDAwMDApOwo+KwkJZGNsa19yYXRlID0g
cmszNTg4X2NhbGNfZGNsayhkY2xrX291dF9yYXRlLCA2MDAwMDAwMDApOwo+IAkJaWYgKCFkY2xr
X3JhdGUpIHsKPiAJCQlkcm1fZXJyKHZvcDItPmRybSwgIkRQIGRjbGtfb3V0X3JhdGUgb3V0IG9m
IHJhbmdlLCBkY2xrX291dF9yYXRlOiAlbGQgS0haXG4iLAo+IAkJCQlkY2xrX291dF9yYXRlKTsK
PkBAIC0xNzM2LDcgKzE3MzYsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyByazM1ODhfY2FsY19j
cnVfY2ZnKHN0cnVjdCB2b3AyX3ZpZGVvX3BvcnQgKnZwLCBpbnQgaWQsCj4gCQkgKiBkY2xrX3Jh
dGUgPSBOICogZGNsa19jb3JlX3JhdGUgTiA9ICgxLDIsNCApLAo+IAkJICogd2UgZ2V0IGEgbGl0
dGxlIGZhY3RvciBoZXJlCj4gCQkgKi8KPi0JCWRjbGtfcmF0ZSA9IHJrMzU4OF9jYWxjX2RjbGso
ZGNsa19vdXRfcmF0ZSwgNjAwMDAwKTsKPisJCWRjbGtfcmF0ZSA9IHJrMzU4OF9jYWxjX2RjbGso
ZGNsa19vdXRfcmF0ZSwgNjAwMDAwMDAwKTsKPiAJCWlmICghZGNsa19yYXRlKSB7Cj4gCQkJZHJt
X2Vycih2b3AyLT5kcm0sICJNSVBJIGRjbGsgb3V0IG9mIHJhbmdlLCBkY2xrX291dF9yYXRlOiAl
bGQgS0haXG4iLAo+IAkJCQlkY2xrX291dF9yYXRlKTsKPi0tIAo+Mi4zOS4yCg==

