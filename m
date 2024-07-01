Return-Path: <linux-kernel+bounces-235517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB2F91D60A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23A21F218D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B77B667;
	Mon,  1 Jul 2024 02:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="LK5soE92"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671C98BF7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719800643; cv=none; b=Vn3v4ERJMobwaO85Y3L6vM+v4veCHy2cqryOrKdnlc9O+bSA0GC7G88L7oX46V3Lyr/rLEFVRjQTrVrD7hzFFpKoSvDJCtW6PwAZ4RZXlG0pQehAx2HP1Ov1YV/b7GssT6rI1K1avMYk0hiwOYddgQAHvfNSMPQNMZ9V8acK/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719800643; c=relaxed/simple;
	bh=0NomcIrW376mye01CwEX88pFBGpqa2YI0CCkp4+u32E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=j8ry9R6xS56x/uLXDtG2y6jKSNvRqlrLWo5vKKn69nzEQiijxbit+UrMOdaXeoj81smOGx8tkq+SJAuz6favN82doE9zS8fk61M0qWyiEWSGldy3Cl+cowceEiG276XQAllB/BlvnpGgXM1UIzNuxfVB9bzRBRxPBOtefBzMZ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=LK5soE92 reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=iI8zBmrKJrRHvnmdrVBoqCHW7KZvi9ta/8ZKijiyFIk=; b=L
	K5soE92qR2xCUl2cI+qASP0pi3R5LAdMsHp5r697BS5xplRny21GH7pH0sfmXQOI
	0JItplpxNsyBdEWzSh+Jezmc6ZojuEp/6GxZgXa0k0D5RWnIsPZ4cFb++9xnPrwQ
	0svtTEgEHvmtgMZlvZ6p4YOqYSF68eZub/ZYyB0Wn8=
Received: from 00107082$163.com ( [111.35.186.71] ) by
 ajax-webmail-wmsvr-40-118 (Coremail) ; Mon, 1 Jul 2024 10:23:32 +0800 (CST)
Date: Mon, 1 Jul 2024 10:23:32 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] Add accumulated call counter for memory allocation
 profiling
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAJuCfpGaEJLaWYPidiAG1vtayugQY5vJoFv9Opauh1TrofOv7Q@mail.gmail.com>
References: <20240617153250.9079-1-00107082@163.com>
 <CAJuCfpGaEJLaWYPidiAG1vtayugQY5vJoFv9Opauh1TrofOv7Q@mail.gmail.com>
X-NTES-SC: AL_Qu2aC/Sbv04q5CKQYekZnEYQheY4XMKyuPkg1YJXOp80qCTr9SoDcmZsEFXv9tmuFSeFqQG7dSdC+PljW7NlYJyfmNGsNEEoXKbJbud9XH0i
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <13c19bd1.2c49.1906c1ac5bf.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3n70lE4Jm8T4SAA--.58049W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqRAOqmVOBMjahwAFsi
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SEkgU3VyZW4sIAoKQXQgMjAyNC0wNy0wMSAwMzozMzoxNCwgIlN1cmVuIEJhZ2hkYXNhcnlhbiIg
PHN1cmVuYkBnb29nbGUuY29tPiB3cm90ZToKPk9uIE1vbiwgSnVuIDE3LCAyMDI0IGF0IDg6MzPi
gK9BTSBEYXZpZCBXYW5nIDwwMDEwNzA4MkAxNjMuY29tPiB3cm90ZToKPj4KPj4gQWNjdW11bGF0
ZWQgY2FsbCBjb3VudGVyIGNhbiBiZSB1c2VkIHRvIGV2YWx1YXRlIHJhdGUKPj4gb2YgbWVtb3J5
IGFsbG9jYXRpb24gdmlhIGRlbHRhKGNvdW50ZXJzKS9kZWx0YSh0aW1lKS4KPj4gVGhpcyBtZXRy
aWNzIGNhbiBoZWxwIGFuYWx5c2lzIHBlcmZvcm1hbmNlIGJlaGF2aW91cnMsCj4+IGUuZy4gdHVu
aW5nIGNhY2hlIHNpemUsIGV0Yy4KPgo+U29ycnkgZm9yIHRoZSBkZWxheSwgRGF2aWQuCj5JSVVD
IHdpdGggdGhpcyBjb3VudGVyIHlvdSBjYW4gaWRlbnRpZnkgdGhlIG51bWJlciBvZiBhbGxvY2F0
aW9ucyBldmVyCj5tYWRlIGZyb20gYSBzcGVjaWZpYyBjb2RlIGxvY2F0aW9uLiBDb3VsZCB5b3Ug
cGxlYXNlIGNsYXJpZnkgdGhlIHVzYWdlCj5hIGJpdCBtb3JlPyBJcyB0aGUgZ29hbCB0byBzZWUg
d2hpY2ggbG9jYXRpb25zIGFyZSB0aGUgbW9zdCBhY3RpdmUgYW5kCj50aGUgcmF0ZSBhdCB3aGlj
aCBhbGxvY2F0aW9ucyBhcmUgbWFkZSB0aGVyZT8gSG93IHdpbGwgdGhhdAo+aW5mb3JtYXRpb24g
YmUgdXNlZD8KIApDdW11bGF0aXZlIGNvdW50ZXJzIGNhbiBiZSBzYW1wbGVkIHdpdGggdGltZXN0
YW1wLCAgc2F5IGF0IFQxLCBhIG1vbml0b3JpbmcgdG9vbCBnb3QgYSBzYW1wbGUgdmFsdWUgVjEs
CnRoZW4gYWZ0ZXIgc2FtcGxpbmcgaW50ZXJ2YWwsIGF0IFQyLCAgZ290IGEgc2FtcGxlIHZhbHVl
IFYyLiBUaGVuIHRoZSBhdmVyYWdlIHJhdGUgb2YgYWxsb2NhdGlvbiBjYW4gYmUgZXZhbHVhdGVk
CnZpYSAoVjItVjEpLyhUMi1UMSkuIChUaGUgYWNjdXJhY3kgZGVwZW5kcyBvbiBzYW1wbGluZyBp
bnRlcnZhbCkKClRoaXMgaW5mb3JtYXRpb24gIm1heSIgaGVscCBpZGVudGlmeSB3aGVyZSB0aGUg
bWVtb3J5IGFsbG9jYXRpb24gaXMgdW5uZWNlc3NhcnkgZnJlcXVlbnQsICAKYW5kICBnYWluIHNv
bWUgIGJldHRlciBwZXJmb3JtYW5jZSBieSBtYWtpbmcgbGVzcyBtZW1vcnkgYWxsb2NhdGlvbiAu
ClRoZSBwZXJmb3JtYW5jZSAiZ2FpbiIgaXMganVzdCBhIGd1ZXNzLCBJIGRvIG5vdCBoYXZlIGEg
dmFsaWQgZXhhbXBsZS4KCgoKPkknbSBhIGJpdCBjYXV0aW91cyBoZXJlIGJlY2F1c2UgZWFjaCBj
b3VudGVyIHdpbGwgdGFrZSBtb3JlIHNwYWNlIGFuZAo+dXNlIHNvbWUgYWRkaXRpb25hbCBjcHUg
Y3ljbGVzLgo+VGhhbmtzLAo+U3VyZW4uCj4KCgoKVGhhbmtzfiEKRGF2aWQ=

