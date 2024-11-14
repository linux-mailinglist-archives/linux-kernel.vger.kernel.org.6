Return-Path: <linux-kernel+bounces-408493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D863C9C7F88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4488F284363
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F96F9C0;
	Thu, 14 Nov 2024 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="k8lCXi3/"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C5C1FC3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545476; cv=none; b=Mb+apPlbHXAOC4aQAnOSc3sWvAnnpULTaxIx0aEL+CvMxq519klZ/IxtS6wWwBoCXkczexaBe1WwhcSeNL+AkU/jfXWdcMQP5oq6ECAC0MgavObO1Yg7XGsLfSjDYgd4A9//a3TsmV5AjbbFc2NDJwuVgsNdAVw7CM2N1Rn8xg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545476; c=relaxed/simple;
	bh=TmDfRQRoYFZLCGu3Rq9F9sj/Ju1LhQcD1pV7vBMNJS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=QH4Yj/B7WWtqwr8vnZGGEpUxq89KFRoSGViE/jRf5+adrLWeDWeuhI3lihTH6svC1bykHFDVMMKeykAt2/wpdbV9Sa1jmyUXxtTP409tf0BmE7ydMnQ32O8prtsNk0ftxtm7wcUiV+9cUAOA8YrDOn+ZqFD+yN/bJ3a5xZ3/9EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=k8lCXi3/ reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=HxStjIbqCkHIGsb5YkLzMTsySu2+FeJnPPzLOOGhizw=; b=k
	8lCXi3/VVMZA7GmT/BivtNVcY43y+238j3Csx+YKmsAdK7gRrJnZrMm++OVJs6cE
	eNFzB9PWcKHuTP/dk78GzfKKXSF5FHo9597UVfze6R6X2cs8lD9avI9IGAgUbm7P
	yLZOobo+5xtZhOCOGbCObTIgRlYt/Zf+Cvrwqkv3KQ=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-129 (Coremail) ; Thu, 14 Nov 2024 08:50:20 +0800
 (CST)
Date: Thu, 14 Nov 2024 08:50:20 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Quentin Schulz" <quentin.schulz@cherry.de>
Cc: "Heiko Stuebner" <heiko@sntech.de>, hjc@rock-chips.com, 
	andy.yan@rock-chips.com, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"Heiko Stuebner" <heiko.stuebner@cherry.de>
Subject: Re:Re: [PATCH 1/2] drm/rockchip: vop2: fix rk3588 dp+dsi maxclk
 verification
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <cb73853e-4201-4cc9-9e8a-f977e66241f6@cherry.de>
References: <20240425195506.2935955-1-heiko@sntech.de>
 <20240425195506.2935955-2-heiko@sntech.de>
 <cb73853e-4201-4cc9-9e8a-f977e66241f6@cherry.de>
X-NTES-SC: AL_Qu2YA/mfukwp5imdZekZnEobh+Y5UcK2s/ki2YFXN5k0mCTmyg4+bG5cLH7q9fmiKiCmoQmLURl14P5jTa5KbpjPaX03fUneRyBcUR0WBzmI
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <72672888.8f9.1932826549b.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gSgvCgD3_+JNSTVnfU8mAA--.60608W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0hKXXmc1QEikyQABs-
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpLAoKQXQgMjAyNC0wNS0wNiAxNTo0NDozNiwgIlF1ZW50aW4gU2NodWx6IiA8cXVlbnRpbi5z
Y2h1bHpAY2hlcnJ5LmRlPiB3cm90ZToKPkhpIEhlaWtvLAo+Cj5PbiA0LzI1LzI0IDk6NTUgUE0s
IEhlaWtvIFN0dWVibmVyIHdyb3RlOgo+PiBGcm9tOiBIZWlrbyBTdHVlYm5lciA8aGVpa28uc3R1
ZWJuZXJAY2hlcnJ5LmRlPgo+PiAKPj4gVGhlIGNsb2NrIGlzIGluIEh6IHdoaWxlIHRoZSB2YWx1
ZSBjaGVja2VkIGFnYWluc3QgaXMgaW4ga0h6LCBzbwo+PiBhY3R1YWwgZnJlcXVlbmNpZXMgd2ls
bCBuZXZlciBiZSBhYmxlIHRvIGJlIGJlbG93IHRvIG1heCB2YWx1ZS4KPj4gRml4IHRoaXMgYnkg
c3BlY2lmeWluZyB0aGUgbWF4LXZhbHVlIGluIEh6IHRvby4KPj4gCj4+IEZpeGVzOiA1YTAyOGU4
ZjA2MmYgKCJkcm0vcm9ja2NoaXA6IHZvcDI6IEFkZCBzdXBwb3J0IGZvciByazM1ODgiKQo+PiBT
aWduZWQtb2ZmLWJ5OiBIZWlrbyBTdHVlYm5lciA8aGVpa28uc3R1ZWJuZXJAY2hlcnJ5LmRlPgo+
PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcDIuYyB8
IDQgKystLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlw
X2RybV92b3AyLmMgYi9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcDIu
Ywo+PiBpbmRleCA5YmVlMWZkODhlNmEyLi41MjM4ODBhNGU4ZTc0IDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcDIuYwo+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcDIuYwo+PiBAQCAtMTcxOSw3ICsx
NzE5LDcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgcmszNTg4X2NhbGNfY3J1X2NmZyhzdHJ1Y3Qg
dm9wMl92aWRlb19wb3J0ICp2cCwgaW50IGlkLAo+PiAgIAkJZWxzZQo+PiAgIAkJCWRjbGtfb3V0
X3JhdGUgPSB2X3BpeGNsayA+PiAyOwo+PiAgIAo+PiAtCQlkY2xrX3JhdGUgPSByazM1ODhfY2Fs
Y19kY2xrKGRjbGtfb3V0X3JhdGUsIDYwMDAwMCk7Cj4+ICsJCWRjbGtfcmF0ZSA9IHJrMzU4OF9j
YWxjX2RjbGsoZGNsa19vdXRfcmF0ZSwgNjAwMDAwMDAwKTsKPj4gICAJCWlmICghZGNsa19yYXRl
KSB7Cj4+ICAgCQkJZHJtX2Vycih2b3AyLT5kcm0sICJEUCBkY2xrX291dF9yYXRlIG91dCBvZiBy
YW5nZSwgZGNsa19vdXRfcmF0ZTogJWxkIEtIWlxuIiwKPgo+SXQgc2VlbXMgdGhlIGVycm9yIG1l
c3NhZ2UgaXMgaW5jb3JyZWN0IGFzIHdlbGwgYW5kIHNob3VsZCBiZSBzYXlpbmcgSHogCj5pbnN0
ZWFkIG9mIEtIei4gKG5vdGUgYWxzbyB0aGUgbG93ZXJjYXNlIHopLgoKSSB0aGluayBrSHogaXMg
ZmluZSwgd2UgY2FuIGZpbmQgbWFueSBzaW1pbmFyeSB1c2FnZSBpbiBkcm06Cgpkcml2ZXJzL2dw
dS9kcm0vZHJtX3ZibGFuay5jCjY1NjogICAgZHJtX2RiZ19jb3JlKGRldiwgImNydGMgJXU6IGNs
b2NrICVkIGtIeiBmcmFtZWR1ciAlZCBsaW5lZHVyICVkXG4iLAo+Cj4+ICAgCQkJCWRjbGtfb3V0
X3JhdGUpOwo+PiBAQCAtMTczNiw3ICsxNzM2LDcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgcmsz
NTg4X2NhbGNfY3J1X2NmZyhzdHJ1Y3Qgdm9wMl92aWRlb19wb3J0ICp2cCwgaW50IGlkLAo+PiAg
IAkJICogZGNsa19yYXRlID0gTiAqIGRjbGtfY29yZV9yYXRlIE4gPSAoMSwyLDQgKSwKPj4gICAJ
CSAqIHdlIGdldCBhIGxpdHRsZSBmYWN0b3IgaGVyZQo+PiAgIAkJICovCj4+IC0JCWRjbGtfcmF0
ZSA9IHJrMzU4OF9jYWxjX2RjbGsoZGNsa19vdXRfcmF0ZSwgNjAwMDAwKTsKPj4gKwkJZGNsa19y
YXRlID0gcmszNTg4X2NhbGNfZGNsayhkY2xrX291dF9yYXRlLCA2MDAwMDAwMDApOwo+PiAgIAkJ
aWYgKCFkY2xrX3JhdGUpIHsKPj4gICAJCQlkcm1fZXJyKHZvcDItPmRybSwgIk1JUEkgZGNsayBv
dXQgb2YgcmFuZ2UsIGRjbGtfb3V0X3JhdGU6ICVsZCBLSFpcbiIsCj4KPkRpdHRvLgo+Cj5PdGhl
cndpc2UsCj4KPlJldmlld2VkLWJ5OiBRdWVudGluIFNjaHVseiA8cXVlbnRpbi5zY2h1bHpAY2hl
cnJ5LmRlPgoKQWNrZWQtYnk6IEFuZHkgWWFuPGFuZHlzaHJrQDE2My5jb20+Cgo+Cj5UaGFua3Mh
Cj5RdWVudGluCg==

