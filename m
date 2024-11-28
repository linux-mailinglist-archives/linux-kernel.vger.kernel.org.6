Return-Path: <linux-kernel+bounces-424393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2680A9DB3DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F45164279
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A9414B945;
	Thu, 28 Nov 2024 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="KE3gV9OT"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA80B14AD1A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732782898; cv=none; b=BG/fhi7XKqHFEStk19jcl4vGZe3rZg0qUIOFdexRtmd8i0K3lNWkMI+tQNXUYvj6JeFn1clmvrRCBUxSaZnKx4aJjOP3yLCUQmfOpi5FeTwBPdkw62Pd1DyRbyenoQYx7euZDKL+m1MHUl8bXW3JreMnylDVYuh34qvhj1bSJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732782898; c=relaxed/simple;
	bh=ku3YuHnBx1sY3bRszis8Kucodvyw9vmk7Y822p9eLIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=IVFvYDhGgZs5FMlM72bkco83b/S9pKfw0N1TlIIdguWycIFE5o1M8UGY32CFA5C/M798B8jvkSDbBOKiIvbGYJesvgvsF/FmZKHKiXHeHuBT1l3j9qFy+qYCeoZMesNtHM3EIT9lL4CWtSBmZ11nlAqBtVY3bwilb1jaE0XLOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=KE3gV9OT reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=C6mFCjq+/GZIsg+PTbH/rfn1jrI9/7tBQjDaYbzi8gQ=; b=K
	E3gV9OTOV1ejOyol9TPfPcvz92zl/E2sveFQZtFYe2ziucaLDH3OR9Z3aawFTg/u
	Efp5txMcMZLSwPCnrXvZLBc1V4vhneEcY7/9P6ihFzaFvcU2qaLlrhqIiLEtQKjI
	/xtHn8Tb0IfxPDAfAvTNS4cYY8ZsDUETCRQnRRyF4g=
Received: from 00107082$163.com ( [111.35.188.140] ) by
 ajax-webmail-wmsvr-40-135 (Coremail) ; Thu, 28 Nov 2024 16:34:10 +0800
 (CST)
Date: Thu, 28 Nov 2024 16:34:10 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, yuzhao@google.com
Subject: Re: Abnormal values show up in /proc/allocinfo
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <1801415b.a202.1936d01f953.Coremail.00107082@163.com>
References: <20241124074318.399027-1-00107082@163.com>
 <CAJuCfpHviS-pw=2=BNTxp1TnphjuiqWGgZnq84EHvbz08iQ6eg@mail.gmail.com>
 <70bad55f.b656.19362cca6ee.Coremail.00107082@163.com>
 <CAJuCfpHho8se-f4cnvk0g1YLNzhvG3q8QTYmvMmweUnGAhtA=g@mail.gmail.com>
 <CAJuCfpEP-xMzHonsE3uV1uYahXehR007B5QX9KjdZdHBWyrXwQ@mail.gmail.com>
 <51c19b31.eaf.193660912f7.Coremail.00107082@163.com>
 <337c721a.70d1.1936753c377.Coremail.00107082@163.com>
 <CAJuCfpHZhMwK8jOz_evvvD8CaNxxaaRQEx0Qv_yPp4ZA_DkXeg@mail.gmail.com>
 <1801415b.a202.1936d01f953.Coremail.00107082@163.com>
X-NTES-SC: AL_Qu2YAPuTvUAu5iObYukXn0oTju85XMCzuv8j3YJeN500hiXW3BwpWVtHEXD0+f2GNhyglDybfTtg0dpZQrZadK4Bggdn3b+FTj/33RjXFg4y
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6c49f606.8737.19371e80128.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hygvCgD3P2QDK0hndKQyAA--.27882W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMw+lqmdIJVxfPQADsE
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0xMS0yNyAxNzo0NDoyNiwgIkRhdmlkIFdhbmciIDwwMDEwNzA4MkAxNjMuY29tPiB3
cm90ZToKPgo+Cj4KPkF0IDIwMjQtMTEtMjcgMDE6MTA6MjMsICJTdXJlbiBCYWdoZGFzYXJ5YW4i
IDxzdXJlbmJAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4KPj4KPj5IaSBEYXZpZCwKPj5UaGFua3MgZm9y
IHRoZSBpbnZlc3RpZ2F0aW9uLiBJIHRoaW5rIHlvdXIgc3VnZ2VzdGlvbiBzaG91bGQgd29yayBm
aW5lCj4+YW5kIGl0J3Mgc2ltcGxlciB0aGFuIHdoYXQgd2UgZG8gbm93LiBJdCB3aWxsIHN3YXAg
bm90IG9ubHkgY291bnRlcnMKPj5idXQgYWxsb2NhdGlvbiBsb2NhdGlvbnMgYXMgd2VsbCwgaG93
ZXZlciBJIHRoaW5rIHdlIGFscmVhZHkgZG8gdGhhdAo+PndoZW4gd2UgY2FsbCBfX2FsbG9jX3Rh
Z19yZWZfc2V0KCkuIFNvLCBpbnN0ZWFkIG9mIGNsZWFyaW5nIHRoZQo+Pm9yaWdpbmFsIHRhZywg
ZGVjcmVtZW50aW5nIHRoZSBuZXcgdGFnJ3MgY291bnRlciAodG8gY29tcGVuc2F0ZSBmb3IKPj5p
dHMgb3duIGFsbG9jYXRpb24pIGFuZCByZWFzc2lnbmluZyB0aGUgb2xkIHRhZyB0byB0aGUgbmV3
IGNvdW50ZXIsCj4+eW91IHNpbXBseSBzd2FwIHRoZSB0YWdzLiBUaGF0IHNlZW1zIGZpbmUgdG8g
bWUuCgpJIHdpbGwgc2VuZCBhIHBhdGNoIGZvciB0aGlzLgoKPj5Ib3dldmVyIEkgdGhpbmsgdGhl
cmUgaXMgc3RpbGwgYSBidWcgd2hlcmUgc29tZSBnZXRfbmV3X2ZvbGlvKCkKPj5jYWxsYmFjayBk
b2VzIG5vdCBpbmNyZW1lbnQgdGhlIG5ldyBmb2xpbydzIGNvdW50ZXJzIGFuZCB0aGF0J3Mgd2h5
IHdlCj4+Z2V0IGFuIHVuZGVyZmxvdyB3aGVuIGNhbGxpbmcgYWxsb2NfdGFnX3N1YigpLiBJJ2xs
IHRyeSB0byByZXByb2R1Y2UKPj5vbiBteSBzaWRlIGFuZCBzZWUgd2hhdCdzIGdvaW5nIG9uIHRo
ZXJlLgo+Cj5BZ3JlZWQsIHRoZSByZWFzb24gZm9yIHVuZGVyZmxvdyB3aXRoIGN1cnJlbnQgY29k
ZSBzaG91bGQgYmUgY2xhcmlmaWVkLgo+SnVzdCB1cGRhdGUgcmVwcm9kdWNlIHByb2NlZHVyZToK
PjEuIGZpbyAtLXJhbmRyZXBlYXQ9MSAtLWlvZW5naW5lPWxpYmFpbyAtLWRpcmVjdD0xIC0tbmFt
ZT10ZXN0ICAtLWJzPTRrIC0taW9kZXB0aD02NCAtLXNpemU9MUcgLS1yZWFkd3JpdGU9cmFuZHJ3
ICAtLXJ1bnRpbWU9MTAwIC0tbnVtam9icz00IC0tdGltZV9iYXNlZD0xCj4yLiAgZWNobyAxID4v
cHJvYy9zeXMvdm0vY29tcGFjdF9tZW1vcnkKPjMuICBlY2hvIDEgPiAvcHJvYy9zeXMvdm0vZHJv
cF9jYWNoZXMKPihJdCBpcyB2ZXJ5IHN0cmFuZ2UsIG9uIG15IFZNLCAgImVjaG8gMyA+IC9wcm9j
L3N5cy92bS9kcm9wX2NhY2hlcyIgd291bGQgbm90IHRyaWdnZXIgZWFzaWx5LiAgCj40IGNhdCAv
cHJvYy9hbGxvY2luZm8gfCBncmVwIF9fZmlsZW1hcF9nZXRfZm9saW8KPgo+Cj5GWUkKPkRhdmlk
Cj4KRmluYWxseSBmaW5kIG91dCB3aHkgdGhvc2UgdW5kZXJmbG93IHZhbHVlcyBvbiBteSBzeXN0
ZW0sIApjbGVhcl9wYWdlX3RhZ19yZWYoKSAtPiBzZXRfY29kZXRhZ19lbXB0eSgpIG9ubHkgd29y
a3Mgd2hlbgpDT05GSUdfTUVNX0FMTE9DX1BST0ZJTElOR19ERUJVRyBpcyBkZWZpbmVkLi4uLi4g
CkkgZ3Vlc3MgeW91IGd1eXMgd291bGQgaGF2ZSBDT05GSUdfTUVNX0FMTE9DX1BST0ZJTElOR19E
RUJVRz15LCBidXQgSSBkb24ndAp0aGluayBpdCB3b3VsZCBiZSB0aGUgY2FzZSBmb3IgZW5kIHVz
ZXJzLgoKVGhlcmUgYXJlIHNldmVyYWwgcmVmZXJlbmNlcyBvZiBjbGVhcl9wYWdlX3RhZ19yZWYo
KS9zZXRfY29kZXRhZ19lbXB0eSgpOgoKLi9tbS9tbV9pbml0LmM6CWNsZWFyX3BhZ2VfdGFnX3Jl
ZihwYWdlKTsKLi9tbS9tbV9pbml0LmM6CWNsZWFyX3BhZ2VfdGFnX3JlZihwYWdlKTsKLi9tbS9w
YWdlX2FsbG9jLmM6CQljbGVhcl9wYWdlX3RhZ19yZWYocGFnZSk7Ci4vbW0vcGFnZV9hbGxvYy5j
OgljbGVhcl9wYWdlX3RhZ19yZWYocGFnZSkgCi4vbW0vc2x1Yi5jOgkJc2V0X2NvZGV0YWdfZW1w
dHkoJnNsYWJfZXh0c1tvZmZzXS5yZWYpOwouL21tL3NsdWIuYzoJCQlzZXRfY29kZXRhZ19lbXB0
eSgmdmVjW2ldLnJlZik7CgoKVGhpbmdzIG1heSBnbyBvZmYgd2hlbiBDT05GSUdfTUVNX0FMTE9D
X1BST0ZJTElOR19ERUJVRyBpcyBub3Qgc2V0LgoKCkZZSQpEYXZpZAoK

