Return-Path: <linux-kernel+bounces-541050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7814FA4B7D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 07:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80799188D723
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F051E3762;
	Mon,  3 Mar 2025 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="o4i/l6LA"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19FA3398A;
	Mon,  3 Mar 2025 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740982735; cv=none; b=J22mAL1DzH+sSM2KqlAx1CE93qiiQJnVEf27ZpvSyEeW3v99GdgKNJ4lCmd9xhIGbTUgGc5HVAOUDl+nFIFeRjbRhlgLc3gWstaJMwlpL2r9gYJlmEMLRVybsLRtuBVyU6LBYYbovyjQHtxHHrQ3i2kcmrWZgeIwBXvFxi3Fjc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740982735; c=relaxed/simple;
	bh=BGuzGmklWCwWu9HoCDFiqOtossYHhBZKWQ1cTQEhELE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=noQvphR/F4coWLjRE4yKwVM2F73xk5weJ91ADvy9C8bmdqHMmZ3oe1BNZgM01sMuyed/bF4PRKq8nN1MNAjBV8kSLSGBwCRQJKrL+9od5L5Kw84oaJG/23eMd0ZpQRhu8qMNWlf+Mk7E9gBYDPLLCVssDXwGoPOUAc4g+Oi45qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=o4i/l6LA reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=c7wgwg7trkS2FEbermFL5uZykFzbYFprUh1vZsPcxAQ=; b=o
	4i/l6LAsls14OIcmvtqwwOM4Ex0xrFvPBFf5MGMz0Eq9wk3/SUITXGV1+IEVLCjN
	NzZgqff57nxwW40y0t2X8iVPvNU1auHQzK30CfapTI2VEmITd7NRc79C32nUiscC
	/WSexSSVSihNMlz3yKp9cH/z/L/seSW/G+69ExL+Es=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-100 (Coremail) ; Mon, 3 Mar 2025 14:17:50 +0800 (CST)
Date: Mon, 3 Mar 2025 14:17:50 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: hjc@rock-chips.com, krzk+dt@kernel.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org, derek.foreman@collabora.com,
	detlev.casanova@collabora.com, daniel@fooishbar.org, robh@kernel.org,
	sebastian.reichel@collabora.com,
	"Andy Yan" <andy.yan@rock-chips.com>,
	"Michael Riesch" <michael.riesch@wolfvision.net>
Subject: Re:Re: [PATCH v15 07/13] drm/rockchip: vop2: Register the primary
 plane and overlay plane separately
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <2759797.BddDVKsqQX@diego>
References: <20250218112744.34433-1-andyshrk@163.com>
 <20250218112744.34433-8-andyshrk@163.com> <2759797.BddDVKsqQX@diego>
X-NTES-SC: AL_Qu2fAvWTvU4s5iaaZOkfmkcVgOw9UcO5v/Qk3oZXOJF8jCrp+T4yXHBTF1zd3fCDBzi2nQiHVRZJ0dhgcY1zcacMWFawtM+gPlh8AAO8w94NRQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1c3ed06d.5e89.1955aa75521.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZCgvCgDHjF6OScVn0j4aAA--.17223W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBwFXmfFRICUNwADsp
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIEhlaWtvLAoKQXQgMjAyNS0wMy0wMyAwMjo1Nzo1MCwgIkhlaWtvIFN0w7xibmVyIiA8aGVp
a29Ac250ZWNoLmRlPiB3cm90ZToKPkhpIEFuZHksCj4KPkFtIERpZW5zdGFnLCAxOC4gRmVicnVh
ciAyMDI1LCAxMjoyNzozNCBNRVogc2NocmllYiBBbmR5IFlhbjoKPj4gRnJvbTogQW5keSBZYW4g
PGFuZHkueWFuQHJvY2stY2hpcHMuY29tPgo+PiAKPj4gSW4gdGhlIHVwY29taW5nIFZPUCBvZiBy
azM1NzYsIGEgV2luZG93IGNhbm5vdCBhdHRhY2ggdG8gYWxsIFZpZGVvIFBvcnRzLAo+PiBzbyBt
YWtlIHN1cmUgYWxsIFZQIGZpbmQgaXQncyBzdWl0YWJsZSBwcmltYXJ5IHBsYW5lLCB0aGVuIHJl
Z2lzdGVyIHRoZQo+PiByZW1haW4gd2luZG93cyBhcyBvdmVybGF5IHBsYW5lIHdpbGwgbWFrZSBj
b2RlIGVhc2llci4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IEFuZHkgWWFuIDxhbmR5LnlhbkByb2Nr
LWNoaXBzLmNvbT4KPj4gVGVzdGVkLWJ5OiBNaWNoYWVsIFJpZXNjaCA8bWljaGFlbC5yaWVzY2hA
d29sZnZpc2lvbi5uZXQ+ICMgb24gUkszNTY4Cj4+IFRlc3RlZC1ieTogRGV0bGV2IENhc2Fub3Zh
IDxkZXRsZXYuY2FzYW5vdmFAY29sbGFib3JhLmNvbT4KPj4gCj4+IC0tLQo+Cj5wYXRjaGVzIDct
OSBsb29rIGdvb2QgdG8gZ28sIGJ1dCAuLi4KPgo+dGhpcyBuZWVkcyBhIHJlYmFzZSB0byBhZGFw
dCB0bwo+ImRybS9yb2NrY2hpcDogdm9wMjogQ29uc2lzdGVudGx5IHVzZSBkZXZfZXJyX3Byb2Jl
KCkiIFswXQo+Cj5bMF0gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9taXNjL2tl
cm5lbC8tL2NvbW1pdC9iMDZkMWVmMzM1NTU3MTM4M2NkYjQ2M2NmMDE5NWI3YTAyZWZkZmJmCgoK
VGhhbmsgeW91LgpJIHNlbnQgVjE2IHdpdGggdGhlIHJlbWFpbmluZyBwYXRjaGVzIHJlYmFzZWQg
b24gZHJtLW1pc2MtbmV4dCwgYW5kIGZpeCB0aGUgc3R5bGUgaXNzdWVzLgoKCj4KPgo+PiAtCQlp
ZiAod2luLT50eXBlID09IERSTV9QTEFORV9UWVBFX1BSSU1BUlkpIHsKPj4gLQkJCXZwID0gZmlu
ZF92cF93aXRob3V0X3ByaW1hcnkodm9wMik7Cj4+IC0JCQlpZiAodnApIHsKPj4gKwkJCWlmICh2
b3AyX2lzX21pcnJvcl93aW4od2luKSkKPj4gKwkJCQljb250aW51ZTsKPj4gKwo+PiArCQkJaWYg
KHdpbi0+dHlwZSA9PSBEUk1fUExBTkVfVFlQRV9QUklNQVJZKSB7Cj4+ICAJCQkJcG9zc2libGVf
Y3J0Y3MgPSBCSVQobnZwKTsKPj4gIAkJCQl2cC0+cHJpbWFyeV9wbGFuZSA9IHdpbjsKPj4gKwkJ
CQlyZXQgPSB2b3AyX3BsYW5lX2luaXQodm9wMiwgd2luLCBwb3NzaWJsZV9jcnRjcyk7Cj4+ICsJ
CQkJaWYgKHJldCkgewo+PiArCQkJCQlkcm1fZXJyKHZvcDItPmRybSwgImZhaWxlZCB0byBpbml0
IHByaW1hcnkgcGxhbmUgJXM6ICVkXG4iLAo+PiArCQkJCQkJd2luLT5kYXRhLT5uYW1lLCByZXQp
Owo+Cj5zaG91bGQgYWxzbyB1c2UgZGV2X2Vycl9wcm9iZQo+Cj4KPkhlaWtvCj4KPgo=

