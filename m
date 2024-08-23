Return-Path: <linux-kernel+bounces-298116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385CE95C2A9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965CBB232F7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 01:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0DB17577;
	Fri, 23 Aug 2024 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="LJUycFRO"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289EFD51A;
	Fri, 23 Aug 2024 01:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724375024; cv=none; b=pt9fvcebXqxS4YzTe2ld6WN00wOGEeI/G7LZqQ8Xh5EMI/JAha3iCi1QCDEhU4w2rKT1Eti1uKkyOwn5omc95xub1K7/9sYEdh6NBs0lPKbFmuyzZCbvp83PzzRonhJrSqopNl6JVviJ8OF2MVonEyuqGtlKEUkdIyYAjE3vQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724375024; c=relaxed/simple;
	bh=UY9faPIXSd2rm/bdMbDKwa3hQ8Sgc8IkfyiVpWIFy7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=NxL1Vf7NVAgXMEQNao1yVH8edD3ZaFi7mu4UGEZdvmXZopgooYyI4RxgL3IXa8rMEsZ+houO+ljYJWvR/vCNQdp7cdZHaJdLVOno3Y2S56AJ+npc4Fx/XudBsro+dq/JeaBGzIc+zTCXKePt7fLbEBxMCJN22CoNEHmhUlHiWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=LJUycFRO reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=gKVSVFPC09Fwvh8vr5n5LVtxpmve0KLk/AGPTPWYriM=; b=L
	JUycFROzWnVdX90eMObuLM4U6GBqeVi7cyVBAETygI2YrBWPo7IOuVYs2n0+69i+
	hp6KySTPFzYG9FGjRoBVAmQYs1ri68kICbEDCA49tBUIzR3JXwzGVm2cdP/ANVQX
	HcJMvG0qSdwjazCUTWEoso3ulFmBmOJV4XrbUmks94=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-105 (Coremail) ; Fri, 23 Aug 2024 09:01:51 +0800
 (CST)
Date: Fri, 23 Aug 2024 09:01:51 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: "Conor Dooley" <conor@kernel.org>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	"Andrzej Hajda" <andrzej.hajda@intel.com>, 
	"Neil Armstrong" <neil.armstrong@linaro.org>, 
	"Robert Foss" <rfoss@kernel.org>, 
	"Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, 
	"Jonas Karlman" <jonas@kwiboo.se>, 
	"Jernej Skrabec" <jernej.skrabec@gmail.com>, 
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, 
	"Maxime Ripard" <mripard@kernel.org>, 
	"Thomas Zimmermann" <tzimmermann@suse.de>, 
	"David Airlie" <airlied@gmail.com>, 
	"Daniel Vetter" <daniel@ffwll.ch>, 
	"Sandy Huang" <hjc@rock-chips.com>, 
	"Andy Yan" <andy.yan@rock-chips.com>, 
	"Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Mark Yao" <markyao0591@gmail.com>, 
	"Sascha Hauer" <s.hauer@pengutronix.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	kernel@collabora.com, "Alexandre ARNOUD" <aarnoud@me.com>, 
	"Luis de Arquer" <ldearquer@gmail.com>
Subject: Re:Re: [PATCH v4 3/4] dt-bindings: display: rockchip: Add schema
 for RK3588 HDMI TX Controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <7fc8cbc3-43d0-43d2-9272-350ac556e2b2@collabora.com>
References: <20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com>
 <7E8109D4-A353-4FE3-9152-3C3C6CB7D634@sntech.de>
 <2085e998-a453-4893-9e80-3be68b0fb13d@collabora.com>
 <4167579.6PsWsQAL7t@diego> <20240822-pushchair-premises-f4055779216a@spud>
 <7fc8cbc3-43d0-43d2-9272-350ac556e2b2@collabora.com>
X-NTES-SC: AL_Qu2ZBv+cu0Eq5yOaZ+kXn0kXhec2W8Czvvgg34JRP5k0tyTL0xIbeGZ9IWHp79CuDxyJqQGmax9X9vRXYaNaX4woqRo5lR8DJERbq8Qshb5n
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4140b55c.a48.1917cc1095f.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD33yp_38dm6fAVAA--.20970W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0hNEXmWXz4pRpQADsb
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

Ckhp77yMCgrlnKggMjAyNC0wOC0yMiAxOTo1OTo0M++8jCJDcmlzdGlhbiBDaW9jYWx0ZWEiIDxj
cmlzdGlhbi5jaW9jYWx0ZWFAY29sbGFib3JhLmNvbT4g5YaZ6YGT77yaCj5PbiA4LzIyLzI0IDEx
OjQxIEFNLCBDb25vciBEb29sZXkgd3JvdGU6Cj4+IE9uIFRodSwgQXVnIDIyLCAyMDI0IGF0IDA5
OjAxOjM0QU0gKzAyMDAsIEhlaWtvIFN0w7xibmVyIHdyb3RlOgo+Pj4gQENvbm9yOiBqdXN0IGZv
ciBtZSwgZGlkIHNvbWUgc2hpZnQgaGFwcGVuIGluIG91ciB1bmRlcnN0YW5kaW5nIG9mIGR0LQo+
Pj4gYmVzdC1wcmFjdGljZXMgaW4gdGVybXMgb2Ygc3lzY29uIHZpYSBwaGFuZGxlIHZzLiBzeXNj
b24gdmlhIGNvbXBhdGlibGU/Cj4+Pgo+Pj4gQmVjYXVzZSBSb2NrY2hpcCBib2FyZHMgYXJlIHJl
ZmVyZW5jaW5nIHRoZWlyIEdSRnMgdmlhIHBoYW5kZXMgZm9yZXZlcgo+Pj4gYnV0IHNpbWlsYXIg
dG8gdGhlIHNvYyB2cyBub24tc29jIG5vZGUgdGhpbmcsIEknZCBsaWtlIHRvIHN0YXkgb24gdG9w
IG9mCj4+PiBiZXN0LXByYWN0aWNlcyA7LSkKPj4gCj4+IElmIElQIGJsb2NrcywgYW5kIHRodXMg
ZHJpdmVycywgYXJlIGdvaW5nIHRvIGJlIHJldXNlZCBiZXR3ZWVuIGRldmljZXMsCj4+IHVzaW5n
IHRoZSBwaGFuZGxlcyBtYWtlcyBzZW5zZSBnaXZlbiB0aGF0IGl0IGlzIHVubGlrZWx5IHRoYXQg
c3lzY29uCj4+IG5vZGVzIGNhbiBtYWtlIHVzZSBvZiBmYWxsYmFjayBjb21wYXRpYmxlcyBkdWUg
dG8gYml0cyB3aXRoaW4gdGhhdCAiZ2x1ZSIKPj4gY2hhbmdpbmcgYmV0d2VlbiBkZXZpY2VzLiBJ
dCBhbHNvIG1ha2VzIHNlbnNlIHdoZW4gdGhlcmUgYXJlIG11bHRpcGxlCj4+IGluc3RhbmNlcyBv
ZiBhbiBJUCBvbiB0aGUgZGV2aWNlLCB3aGljaCBuZWVkIHRvIHVzZSBkaWZmZXJlbnQgc3lzY29u
cy4KPj4gTXkgZ29hbCBpcyB0byBhc2sgcGVvcGxlIHdoeSB0aGV5IGFyZSB1c2luZyB0aGVzZSB0
eXBlIG9mIHN5c2NvbnMKPj4gcGhhbmRsZSBwcm9wZXJ0aWVzLCBjb3Mgb2Z0ZW4gdGhleSBhcmUg
bm90IHJlcXVpcmVkIGF0IGFsbCAtIGZvciBleGFtcGxlCj4+IHdpdGggY2xvY2tzIHdoZXJlIHlv
dSBlZmZlY3RpdmVseSBuZWVkIGEgd2hvbGUgbmV3IGRyaXZlciBmb3IgZXZlcnkKPj4gc2luZ2xl
IHNvYyBhbmQgaGF2aW5nIGEgcGhhbmRsZSBwcm9wZXJ0eSBidXlzIHlvdSBub3RoaW5nLgo+Cj5U
aGF0IHdvdWxkIGJlIGFsc28gdGhlIGNhc2UgZm9yIHRoaXMgSERNSSBjb250cm9sbGVyIC0gbmVl
ZCB0byBjaGVjayB0aGUKPnNwZWNzIGZvciB0aGUgbmV3ZXIgUkszNTc2IFNvQywgYnV0IEkgZXhw
ZWN0IHRoZSBzeXNjb25zIHdvdWxkIGJlIHF1aXRlCj5kaWZmZXJlbnQgd2hlbiBjb21wYXJlZCB0
byBSSzM1ODgsIGhlbmNlIHdlIHNob3VsZCBrZWVwIG1ha2luZyB1c2Ugb2YKPnRoZSBwaGFuZGxl
cy4KCgpZZXPvvIxmb3IgcmszNTc277yMaXQgc2hhcmVzIHRoZSBzYW1lIEhETUkgSVAgYmxvY2vv
vIhoZG1pIGNvbnRyb2xsZXIgYW5kIFBIWe+8ie+8jApvZiBjb3Vyc2UgcmV1c2UgdGhlIGRyaXZl
ciBvZiByazM1ODjvvIwgYnV0IGl0IGhhcyBkaWZmZXJlbnQgR1JGIHRvIGRlcGVuZHMgb25bMF06
CndoaWNoIGNhbGxzIGlvY19ncmYgYW5kIHZvMF9ncmY6CgpJIGFsc28gYmVsaWV2ZSB0aGF0IG1h
a2VpbmcgdXNlIG9mIHBoYW5kbGUgYmVuZWZpY2lhbCBmb3IgZGlmZmVyZW50IGRldmljZXMgdG8g
cmV1c2UgdGhlIHNhbWUgY29kZS4KCmhkbWk6IGhkbWlAMjdkYTAwMDAgewogICAgICAgICAgICAg
ICAgY29tcGF0aWJsZSA9ICJyb2NrY2hpcCxyazM1NzYtZHctaGRtaSI7CiAgICAgICAgICAgICAg
ICByZWcgPSA8MHgwIDB4MjdkYTAwMDAgMHgwIDB4MTAwMDA+LCA8MHgwIDB4MjdkYjAwMDAgMHgw
IDB4MTAwMDA+OwogICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDMzOCBJUlFf
VFlQRV9MRVZFTF9ISUdIPiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8R0lDX1NQSSAz
MzkgSVJRX1RZUEVfTEVWRUxfSElHSD4sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPEdJ
Q19TUEkgMzQwIElSUV9UWVBFX0xFVkVMX0hJR0g+LAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDxHSUNfU1BJIDM0MSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICA8R0lDX1NQSSAzNjcgSVJRX1RZUEVfTEVWRUxfSElHSD47CiwgICAgICAgICAg
ICByb2NrY2hpcCxncmYgPSA8JmlvY19ncmY+OwogICAgICAgICAgICAgcm9ja2NoaXAsdm8wX2dy
ZiA9IDwmdm8wX2dyZj47CiAgICAgICAgICAgICBwaHlzID0gPCZoZHB0eHBoeV9oZG1pPjsKICAg
ICAgICAgICAgIHBoeS1uYW1lcyA9ICJoZG1pIjsKCgpbMF1odHRwczovL2dpdGh1Yi5jb20vYXJt
Ymlhbi9saW51eC1yb2NrY2hpcC9ibG9iL3JrLTYuMS1ya3IzL2FyY2gvYXJtNjQvYm9vdC9kdHMv
cm9ja2NoaXAvcmszNTc2LmR0c2kjTDMxMjJDMi1MMzEyM0MzMwoKPgo+X19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPkxpbnV4LXJvY2tjaGlwIG1haWxpbmcg
bGlzdAo+TGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZwo+aHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yb2NrY2hpcAo=

