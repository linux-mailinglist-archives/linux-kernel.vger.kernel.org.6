Return-Path: <linux-kernel+bounces-310323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DDE967AE5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 19:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A621F2143A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525313B79C;
	Sun,  1 Sep 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="PychHPat"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A58917C;
	Sun,  1 Sep 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725210136; cv=none; b=Ee0GhPRAwLFfUzWfkjPGUXJkVdo7uCVFV1RRA9FzeDH4F+vEcV683xIbAGXPa59c4+LTqpKjbiRoRQTH0i61kpzFg08EBycFdSnzxUYPmL7V95tnFzVEToTToZ6xaFKIioxEq2wiVaQ3ik3+jTSDYPIbknJ0lb818f7HA/nM49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725210136; c=relaxed/simple;
	bh=FsO8EYvnbAmGqUQe9Pii3BHXPSzNdyieBp00jgaKm7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gKhObldzjeHoMC/zoUzzo+KcdwnM7Uq/dwWGnaTQb2LqkIh3Aw6EhX5Lab6CfUvCR3eyOMZ5DhlSatCiHvjV/WSeqbZU2F1bQ1mFBpwMX3muFea6u2BibVU1hwSW2wuEEEW24zYUgW2ormggtyjbPzP6Uu484LwnUYBd8+W21aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=PychHPat reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=AjyGkwb0KCWQ1NnIxOsmkp9771bZVXLIiIJ0kX0YArs=; b=P
	ychHPatwvXf5BcFDQSDy3NXr9qKNZ6eJRupeBD4dg8jBZAPPEMg4IQ6ewsf4ZwsA
	5ZZ8zTMxuOL+AjVRkK2tqFehv4Uu2aOeKzelQ2haiMUsGbaEWNh8l+KKq81UbYde
	A18PrnUFBG+LEudVg1UxsEAkUgzbZizuUp+lZqE51g=
Received: from 00107082$163.com ( [111.35.190.113] ) by
 ajax-webmail-wmsvr-40-114 (Coremail) ; Mon, 2 Sep 2024 01:01:07 +0800 (CST)
Date: Mon, 2 Sep 2024 01:01:07 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH] usb: xhci: wait for controller ready when resume with
 reinit_xhc
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240901162425.5103-1-00107082@163.com>
References: <20240901162425.5103-1-00107082@163.com>
X-NTES-SC: AL_Qu2ZB/6av0gt4SmfbekXn0oTju85XMCzuv8j3YJeN500oyTB5iUpZW9hIlzs+ce1LiCjoAi1QiJDzc1IZKB2cbw2hLX9ZgVPvBhNSXgmNrsJ
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1fe3e185.3639.191ae88840f.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3n6zUndRmuSdHAA--.44675W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqRNNqmVOClTVCwACs0
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

T29wcy4uLiBKdXN0IGZpbmQgb3V0IHRoZSB3YXJuaW5nICIgIGVwXzgxOiBQTTogcGFyZW50IDMt
MS4xOjEuMSBzaG91bGQgbm90IGJlIHNsZWVwaW5nIiBzaG93cyB1cCB3aGVuIEkgc3VzcGVuZCBt
eSBzeXN0ZW0gd2l0aCBVU0IgY2FtZXJhIG9uLCAKYW5kIHRoaXMgcGF0Y2ggY291bGQgbm90IGZp
eCBpdC4KUGxlYXNlIGlnbm9yZSB0aGUgcGF0Y2gsIHNvcnJ5IGJvdGhlcmluZy4uLgoKRGF2aWQK
CgpBdCAyMDI0LTA5LTAyIDAwOjI0OjI1LCAiRGF2aWQgV2FuZyIgPDAwMTA3MDgyQDE2My5jb20+
IHdyb3RlOgo+V2hlbiByZXN1bWUgc3lzdGVtIHdpdGggcmVpbml0X3hoYyB0cnVlLCBQTSB3b3Vs
ZCByZXBvcnQga2VybmVsCj53YXJuaW5nIGFib3V0IGRldmljZSBwYXJlbnQ6Cj4KPiA+dXNiIDMt
MS4xOiByZXNldCBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDQgdXNpbmcgeGhjaV9oY2QK
PiA+Li4KPiA+ZXBfODE6IFBNOiBwYXJlbnQgMy0xLjE6MS4xIHNob3VsZCBub3QgYmUgc2xlZXBp
bmcKPgo+TW92ZSB0aGUgY29kZSB3YWl0aW5nIGZvciBjb250cm9sbGVyIHJlYWR5IG91dCwgYW5k
IG1ha2UgaXQKPmNhcnJ5IG91dCB3b3JrIG5vIG1hdHRlciByZWluaXRfeGhjIGlzIHRydWUgb3Ig
ZmFsc2UuCj5UaGUgZXJyb3IgaXMgaWdub3JlZCB3aGVuIHJlaW5pdF94aGMgaXMgdHJ1ZS4KPgo+
U2lnbmVkLW9mZi1ieTogRGF2aWQgV2FuZyA8MDAxMDcwODJAMTYzLmNvbT4KPi0tLQo+IGRyaXZl
cnMvdXNiL2hvc3QveGhjaS5jIHwgMTQgKysrKysrKystLS0tLS0KPiAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvaG9zdC94aGNpLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYwo+aW5kZXggZWZkZjRjMjI4
YjhjLi44YWViMWIzNGNkYmYgMTAwNjQ0Cj4tLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYwo+
KysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLmMKPkBAIC0xMDMyLDEzICsxMDMyLDE1IEBAIGlu
dCB4aGNpX3Jlc3VtZShzdHJ1Y3QgeGhjaV9oY2QgKnhoY2ksIHBtX21lc3NhZ2VfdCBtc2cpCj4g
CWlmIChoaWJlcm5hdGVkIHx8IHhoY2ktPnF1aXJrcyAmIFhIQ0lfUkVTRVRfT05fUkVTVU1FIHx8
IHhoY2ktPmJyb2tlbl9zdXNwZW5kKQo+IAkJcmVpbml0X3hoYyA9IHRydWU7Cj4gCj4rCS8qCj4r
CSAqIFNvbWUgY29udHJvbGxlcnMgbWlnaHQgbG9zZSBwb3dlciBkdXJpbmcgc3VzcGVuZCwgc28g
d2FpdAo+KwkgKiBmb3IgY29udHJvbGxlciBub3QgcmVhZHkgYml0IHRvIGNsZWFyLCBqdXN0IGFz
IGluIHhIQyBpbml0Lgo+KwkgKiBJZ25vcmUgcmV0dmFsIGlmIHJlaW5pdF94aGMgaXMgdHJ1ZSwg
c2luY2UgdGhlIGRldmljZSB3b3VsZAo+KwkgKiBiZSByZWluaXRlZC4KPisJICovCj4rCXJldHZh
bCA9IHhoY2lfaGFuZHNoYWtlKCZ4aGNpLT5vcF9yZWdzLT5zdGF0dXMsCj4rCQkJCVNUU19DTlIs
IDAsIDEwICogMTAwMCAqIDEwMDApOwo+IAlpZiAoIXJlaW5pdF94aGMpIHsKPi0JCS8qCj4tCQkg
KiBTb21lIGNvbnRyb2xsZXJzIG1pZ2h0IGxvc2UgcG93ZXIgZHVyaW5nIHN1c3BlbmQsIHNvIHdh
aXQKPi0JCSAqIGZvciBjb250cm9sbGVyIG5vdCByZWFkeSBiaXQgdG8gY2xlYXIsIGp1c3QgYXMg
aW4geEhDIGluaXQuCj4tCQkgKi8KPi0JCXJldHZhbCA9IHhoY2lfaGFuZHNoYWtlKCZ4aGNpLT5v
cF9yZWdzLT5zdGF0dXMsCj4tCQkJCQlTVFNfQ05SLCAwLCAxMCAqIDEwMDAgKiAxMDAwKTsKPiAJ
CWlmIChyZXR2YWwpIHsKPiAJCQl4aGNpX3dhcm4oeGhjaSwgIkNvbnRyb2xsZXIgbm90IHJlYWR5
IGF0IHJlc3VtZSAlZFxuIiwKPiAJCQkJICByZXR2YWwpOwo+LS0gCj4yLjM5LjIK

