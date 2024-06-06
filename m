Return-Path: <linux-kernel+bounces-203595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CD08FDD96
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF7D1F254D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD6A2C853;
	Thu,  6 Jun 2024 03:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="TphYEWKK"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A1E28373
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 03:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717645380; cv=none; b=ugGJp27CdnZxX325KxWFVbvjN/qe7hC2X5BXAaYuO8Zf/MOkBiAH0ShawqCKYNT776aTiUIgWL3aGG4qIXFC5jfsLhQJtKX6PSuKgCEflH9RKhi2i2KzNH9V9UkMnHgDz1aLCOEtFKO9uUFiAgIGCGT4zjR4zjTFyJ5AKVvQaBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717645380; c=relaxed/simple;
	bh=rDmtpd+duE5CxQSckPkPgXM3joj0Z1vNz/QbXkXW01M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=JXMG3HAltS6d5RTJRtSB9BUYLqWAlhOqMEV2vI6/oTTlHSxFtuPDnt4Hls12lDzCqGcTKY1ZW438UishYDk0tCU105//jjiqBd3lAsblpYdArd8OdeamZOtQ4l2tZuVTQg+81LUbchm50wXVMyJ34Q6OMPYXg95FEkaCxF33zh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=TphYEWKK reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=SzvhPkEeSUU4Uy4laIaSuaFZpz0kMcmzAtZt6iJXrsc=; b=T
	phYEWKKwypalIN0imXNqzh3B7mbDpgMu6IvoSGUFFnxZFoEklElqHAAFD+FzLDWA
	hcmT9t0QWMLw+fz8YaioCu6xdjtPjeRuKYjf4yqtFN4vvfEYbXduxw0Ok3rGJ/ah
	Ovn/FHO3ntMi5k8JNu78dYoJO817DcSOFWtY3CU+Ds=
Received: from 00107082$163.com ( [111.35.186.64] ) by
 ajax-webmail-wmsvr-40-117 (Coremail) ; Thu, 6 Jun 2024 11:42:16 +0800 (CST)
Date: Thu, 6 Jun 2024 11:42:16 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: kent.overstreet@linux.dev, keescook@chromium.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [BUG?] memory allocation profiling: the counters are not
 non-decreasing.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAJuCfpFY=e3zNOMHgTM-HGxhk2c_nr=ODOo3Fk67_D4gNgzx-Q@mail.gmail.com>
References: <20240605123710.7396-1-00107082@163.com>
 <CAJuCfpFY=e3zNOMHgTM-HGxhk2c_nr=ODOo3Fk67_D4gNgzx-Q@mail.gmail.com>
X-NTES-SC: AL_Qu2aBfqfukso4CGeYOkZnEYQheY4XMKyuPkg1YJXOp80pyTr6jg5fER7PHT29/uVJASQiyOtWR9exMt0Yah0Z50CAj64B/TLbULgT6mkhN9m
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <182db681.446d.18feba3de6a.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3X6EZMGFmik1sAA--.19049W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxz0qmXAlp85YQADsG
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0wNi0wNiAwNDowMDoxNywgIlN1cmVuIEJhZ2hkYXNhcnlhbiIgPHN1cmVuYkBnb29n
bGUuY29tPiB3cm90ZToKPk9uIFdlZCwgSnVuIDUsIDIwMjQgYXQgNTozN+KAr0FNIERhdmlkIFdh
bmcgPDAwMTA3MDgyQDE2My5jb20+IHdyb3RlOgo+Pgo+PiBIaSwKPj4gSSB3YXMgcGxheWluZyB3
aXRoIHRoaXMgbmV3IGZlYXR1cmUgb2YgbWVtb3J5IGFsbG9jYXRpb24gcHJvZmlsaW5nLCB3aGVu
IEkgcGxvdCB0aGUgZGF0YSwgZ3JvdXBlZCBieSBjYWxsZXIncyBzb3VyY2UgZGlyLAo+PiBJIG5v
dGljZWQgdGhhdCB0aGUgY291bnRlcnMgYXJlIG5vdCBub24tZGVjcmVhc2luZy4KPj4gSWYgSSB1
bmRlcnN0YW5kIHRoaXMgZmVhdHVyZSBjb3JyZWN0bHksIGFsbCBjb3VudGVycyBzaG91bGQgYmUg
bm9uLWRlY3JlYXNpbmcsIHJpZ2h0Pwo+PiBPciBpcyB0aGVyZSBzb21lIFRUTCBmb3Igc3RhbGUg
aXRlbXM/Cj4KPkhpIERhdmlkLAo+Q291bnRlcnMgY2FuIGRlY3JlYXNlIG9uY2UgYW4gYWxsb2Nh
dGlvbiBpcyBmcmVlZC4KPlRoYW5rcywKPlN1cmVuLgo+CgpIaSAgU3VyZW4sCgpUaGFua3MgZm9y
IHRoZSBxdWljayByZXNwb25zZS4gCkkgZ3Vlc3MgSSBtaXN1bmRlcnN0b29kIHRoaXMgZmVhdHVy
ZSwgbm8gd29uZGVyIEkgc2F3IHNldmVyYWwgInplcm8iIHZhbHVlcy4KCklmICJmcmVlZCIgbWVt
b3J5IGlzIGFsc28gdHJhY2tlZCBhY2N1cmF0ZWx5LCBJIGZlZWwgdGhpcyB3b3VsZCBiZSBhIHZl
cnkgcG93ZXJmdWwgZmVhdHVyZSEKClRoeH4KRGF2aWQKCj4+Cj4+IEZvbGxvd2luZyBpcyBhIHNp
bXBsZXIgc2NyaXB0IGRlbW9uc3RyYXRpbmcgbXkgc2F5aW5ncwo+Pgo+PiAgICAgICAgICQgZm9y
IGkgaW4gezEuLjEwMH07IGRvIHN1ZG8gY2F0IC9wcm9jL2FsbG9jaW5mbyB8IGdyZXAgIiBtbVwv
IiB8IGF3ayAne3MrPSQyfUVORHtwcmludCBzfSc7IHNsZWVwIDEwOyBkb25lCj4+ICAgICAgICAg
MTE5NDQ1Mwo+PiAgICAgICAgIDExOTY5MzUKPj4gICAgICAgICAxMTk4OTU3Cj4+ICAgICAgICAg
MTE5OTcxNgo+PiAgICAgICAgIDEyMDA3NzAKPj4gICAgICAgICAxMTkwNzk1ICA8LS0tIGRlY3Jl
YXNlIGhlcmUKPj4gICAgICAgICAxMTkyNzAyCj4+ICAgICAgICAgMTE5MzA3MAo+PiAgICAgICAg
IDExOTM4MTIKPj4gICAgICAgICAxMTk1MDY5Cj4+ICAgICAgICAgMTE5NjQ5MQo+PiAgICAgICAg
IC4uLgo+Pgo+PiBGWUkKPj4gRGF2aWQKPj4K

