Return-Path: <linux-kernel+bounces-442741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B8D9EE113
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C971165489
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1D020CCE0;
	Thu, 12 Dec 2024 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="FDeK6cS1"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD6220C463
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991519; cv=none; b=QxKnfYgvlUYMKcK341RJrs1yKLy/C6yRnVfy+QkPYyQucgUTM9mh0DotmoIMXCpb+odIIOB49nTGE0E+fYQxlOg/Ve7MOy8L3dDSFryAHcgiGVg/0RfZ7X91zZqaH3Vh0TNRbW1mBqBXyOjADR1/2K0CEac+57OHgPqW9PoF3wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991519; c=relaxed/simple;
	bh=RLDZqIz38VjI/zaobMDhb8iKpNgj2VhxjWcO5U15HEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=qhHi19+CwzBZAHte1Empcl4QHl/xsG941XW6LF2LjAwGTxkAf7mAqo/topMCq9VQY5UHfmESznToZqKQbFEv3jcdO1p0pWDJq8orGiF2TeLX6FP/UouCQVp74e+EICVKMq6VoxvWm7AVGPPP5B5KQoYnKkFBtGNg9hQ9sbCBJ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=FDeK6cS1 reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Gt4EeInFURnpaF2fnTgIup71H3SdAvx2EeuLaba9tuc=; b=F
	DeK6cS1Rj+IfYLtJVmqNf1e42A5CCPSAOi2XWNsvswV/ijRO8WlR4GCKRQ83uW9o
	oN9uPQ/4wQAnzB/vdPbW7gBHXAfhZo9/jN2zNDgR4hnfLPtZotguHWu0J2sk+5m8
	o4RVSfoxBXUzJKRM/O/0kHi47WdPtr319VvxCmfYOI=
Received: from 00107082$163.com ( [111.35.188.140] ) by
 ajax-webmail-wmsvr-40-144 (Coremail) ; Thu, 12 Dec 2024 16:17:00 +0800
 (CST)
Date: Thu, 12 Dec 2024 16:17:00 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: kent.overstreet@linux.dev, yuzhao@google.com, oliver.sang@intel.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lkp@intel.com, oe-lkp@lists.linux.dev
Subject: Re: [PATCH] mm/codetag: clear tags before swap
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAJuCfpGJp-U3t_SHRhuSRTu7Hjkz23oqKSNbVL79O1OQhgJndw@mail.gmail.com>
References: <202412112227.df61ebb-lkp@intel.com>
 <20241212040104.507310-1-00107082@163.com>
 <CAJuCfpGJp-U3t_SHRhuSRTu7Hjkz23oqKSNbVL79O1OQhgJndw@mail.gmail.com>
X-NTES-SC: AL_Qu2YAfWSvkwp5ieQY+kXn0oTju85XMCzuv8j3YJeN500tSbC/S4DcnBOEFry1cOyFCqSvxeQTwFC88hqfJNEYqQRqJQ69Tv77yNO8JdSPLJH
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <19d1f6e9.88c7.193b9f15377.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kCgvCgD3v579m1pnQSE+AA--.1999W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0gOzqmdalpSqGAAAsF
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMTItMTIgMTU6MDk6NTksICJTdXJlbiBCYWdoZGFzYXJ5YW4iIDxzdXJlbmJAZ29v
Z2xlLmNvbT4gd3JvdGU6Cj5PbiBXZWQsIERlYyAxMSwgMjAyNCBhdCA4OjAz4oCvUE0gRGF2aWQg
V2FuZyA8MDAxMDcwODJAMTYzLmNvbT4gd3JvdGU6Cj4+Cj4+IFdoZW4gQ09ORklHX01FTV9BTExP
Q19QUk9GSUxJTkdfREVCVUcgaXMgc2V0LCBrZXJuZWwgV0FSTiB3b3VsZCBiZQo+PiB0cmlnZ2Vy
ZWQgd2hlbiBjYWxsaW5nIF9fYWxsb2NfdGFnX3JlZl9zZXQoKSBkdXJpbmcgc3dhcDoKPj4KPj4g
ICAgICAgICBhbGxvY190YWcgd2FzIG5vdCBjbGVhcmVkIChnb3QgdGFnIGZvciBtbS9maWxlbWFw
LmM6MTk1MSkKPj4gICAgICAgICBXQVJOSU5HOiBDUFU6IDAgUElEOiA4MTYgYXQgLi9pbmNsdWRl
L2xpbnV4L2FsbG9jX3RhZy5oLi4uCj4+Cj4+IENsZWFyIGNvZGUgdGFncyBiZWZvcmUgc3dhcCBj
YW4gZml4IHRoZSB3YXJuaW5nLiBBbmQgdGhpcyBwYXRjaCBhbHNvIGZpeAo+PiBhIHBvdGVudGlh
bCBpbnZhbGlkIGFkZHJlc3MgZGVyZWZlcmVuY2UgaW4gYWxsb2NfdGFnX2FkZF9jaGVjaygpIHdo
ZW4KPj4gQ09ORklHX01FTV9BTExPQ19QUk9GSUxJTkdfREVCVUcgaXMgc2V0IGFuZCByZWYtPmN0
IGlzIENPREVUQUdfRU1QVFksCj4+IHdoaWNoIGlzIGRlZmluZWQgYXMgKCh2b2lkICopMSkuCj5e
Xl4KPkdvb2QgY2F0Y2ghCj4KPj4KPj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgV2FuZyA8MDAxMDcw
ODJAMTYzLmNvbT4KPj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxvbGl2ZXIuc2Fu
Z0BpbnRlbC5jb20+Cj4+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2UtbGtwLzIw
MjQxMjExMjIyNy5kZjYxZWJiLWxrcEBpbnRlbC5jb20KPj4gLS0tCj4+ICBpbmNsdWRlL2xpbnV4
L2FsbG9jX3RhZy5oIHwgMiArLQo+PiAgbGliL2FsbG9jX3RhZy5jICAgICAgICAgICB8IDQgKysr
Kwo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4K
Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYWxsb2NfdGFnLmggYi9pbmNsdWRlL2xpbnV4
L2FsbG9jX3RhZy5oCj4+IGluZGV4IDdjMDc4NmJkZjlhZi4uY2JhMDI0YmYyZGIzIDEwMDY0NAo+
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2FsbG9jX3RhZy5oCj4+ICsrKyBiL2luY2x1ZGUvbGludXgv
YWxsb2NfdGFnLmgKPj4gQEAgLTEzNSw3ICsxMzUsNyBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBh
bGxvY190YWdfY291bnRlcnMgYWxsb2NfdGFnX3JlYWQoc3RydWN0IGFsbG9jX3RhZyAqdGFnKQo+
PiAgI2lmZGVmIENPTkZJR19NRU1fQUxMT0NfUFJPRklMSU5HX0RFQlVHCj4+ICBzdGF0aWMgaW5s
aW5lIHZvaWQgYWxsb2NfdGFnX2FkZF9jaGVjayh1bmlvbiBjb2RldGFnX3JlZiAqcmVmLCBzdHJ1
Y3QgYWxsb2NfdGFnICp0YWcpCj4+ICB7Cj4+IC0gICAgICAgV0FSTl9PTkNFKHJlZiAmJiByZWYt
PmN0LAo+PiArICAgICAgIFdBUk5fT05DRShyZWYgJiYgcmVmLT5jdCAmJiAhaXNfY29kZXRhZ19l
bXB0eShyZWYpLAo+PiAgICAgICAgICAgICAgICAgICAiYWxsb2NfdGFnIHdhcyBub3QgY2xlYXJl
ZCAoZ290IHRhZyBmb3IgJXM6JXUpXG4iLAo+PiAgICAgICAgICAgICAgICAgICByZWYtPmN0LT5m
aWxlbmFtZSwgcmVmLT5jdC0+bGluZW5vKTsKPj4KPj4gZGlmZiAtLWdpdCBhL2xpYi9hbGxvY190
YWcuYyBiL2xpYi9hbGxvY190YWcuYwo+PiBpbmRleCAzNWY3NTYwYTMwOWEuLmNjNWZkYTk5MDFj
MiAxMDA2NDQKPj4gLS0tIGEvbGliL2FsbG9jX3RhZy5jCj4+ICsrKyBiL2xpYi9hbGxvY190YWcu
Ywo+PiBAQCAtMjA5LDYgKzIwOSwxMCBAQCB2b2lkIHBnYWxsb2NfdGFnX3N3YXAoc3RydWN0IGZv
bGlvICpuZXcsIHN0cnVjdCBmb2xpbyAqb2xkKQo+PiAgICAgICAgICAgICAgICAgcmV0dXJuOwo+
PiAgICAgICAgIH0KPj4KPj4gKyAgICAgICAvKiBjbGVhciB0YWdzIGJlZm9yZSBzd2FwICovCj4K
PlRoZSBhYm92ZSBjb21tZW50IHN0YXRlcyB3aGF0IHdlIGFscmVhZHkga25vdyBmcm9tIHRoZSBj
b2RlIGJ1dCBkb2VzCj5ub3QgZXhwbGFpbiB3aHkgd2UgZG8gdGhpcy4gQmV0dGVyIHRvIGRlc2Ny
aWJlIHRoZSByZWFzb24gYW5kIG5vdCB3aGF0Cj53ZSBkby4gU29tZXRoaW5nIGxpa2U6Cj4KPi8q
Cj4gKiBDbGVhciB0YWcgcmVmZXJlbmNlcyB0byBhdm9pZCBkZWJ1ZyB3YXJuaW5nIHdoZW4gdXNp
bmcKPiAqICBfX2FsbG9jX3RhZ19yZWZfc2V0KCkgd2l0aCBub24tZW1wdHkgcmVmZXJlbmNlLgo+
ICovCj4KCkNvcHkgdGhhdH4hCgoKVGhhbmtzIQpEYXZpZAo+PiArICAgICAgIHNldF9jb2RldGFn
X2VtcHR5KCZyZWZfb2xkKTsKPj4gKyAgICAgICBzZXRfY29kZXRhZ19lbXB0eSgmcmVmX25ldyk7
Cj4+ICsKPj4gICAgICAgICAvKiBzd2FwIHRhZ3MgKi8KPj4gICAgICAgICBfX2FsbG9jX3RhZ19y
ZWZfc2V0KCZyZWZfb2xkLCB0YWdfbmV3KTsKPj4gICAgICAgICB1cGRhdGVfcGFnZV90YWdfcmVm
KGhhbmRsZV9vbGQsICZyZWZfb2xkKTsKPj4gLS0KPj4gMi4zOS4yCj4+Cj4+Cg==

