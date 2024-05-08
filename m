Return-Path: <linux-kernel+bounces-172614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0BA8BF448
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFFD01C22D83
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B56A8F6A;
	Wed,  8 May 2024 01:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="EcooEocR"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEADAAD51
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 01:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715133497; cv=none; b=Vl0SgZxEktUkghMAaDwXuDgHEEMiBu6TTVAn85EXzj1tJVjteVJCUSoU7akKfEw1vptYwfawYWbPjj1ZEMUEeulO5qISe+CUiFn2ibHu+qZbn1bo1u50ii5x7qBA0ZAU41VN+SpzR3zHcqoY909MBR+t+WqWEKh6mY7VxNVZsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715133497; c=relaxed/simple;
	bh=xCS0trzB3FXbPMwRlsMvngLcoOqHigTONUMuxSprm1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=kMRm3hxRafohubwEjUfnyFBTUywxIFUPxVEgpHLscxuKVQgMEiFEeyEvBIpOnTVb8Ebt0EJCP4Lv9KGU2jqaJ2Li2QeAJYiA58NyNFyR45KS1opObGG+H9moyRqln7aDu/VYMuKQdKYxUlln9teCLL7+Eb/mvpGR7wpHozQWVt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=EcooEocR reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=qAcwmOcJtkUz7iXSL+0YdjC+Tf34zyZyjt2ptu431Wo=; b=E
	cooEocRPcoof0j9Jgb9r00i0MLjd6lolNFHgxezTSBR7vpl1SOhFb5Bym0rO2WAy
	MTHn/Eu/ZWSqHToHaoHbd1R9e7kjI0cMAV6iz4ORPNlrHHzr0M5BlVoclETuQgRh
	BTNzbh7M4OPGSN61IJMavLVsn6ESQckPmAgqeJ96YM=
Received: from gaoshanliukou$163.com ( [60.27.227.220] ) by
 ajax-webmail-wmsvr-40-120 (Coremail) ; Wed, 8 May 2024 09:42:16 +0800 (CST)
Date: Wed, 8 May 2024 09:42:16 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: "Alexandre Ghiti" <alex@ghiti.fr>
Cc: alexghiti@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, "yang.zhang" <yang.zhang@hexintek.com>
Subject: Re:Re: [PATCH V2] riscv: set trap vector earlier
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <bfb82e87-94c0-4a23-b59d-bb57911224b5@ghiti.fr>
References: <20240506022239.6817-1-gaoshanliukou@163.com>
 <bfb82e87-94c0-4a23-b59d-bb57911224b5@ghiti.fr>
X-NTES-SC: AL_Qu2aB/2YvU0o4CacZOkXnEYQh+k3XcK4u/0u2YFVP5E0qiT/wSEYRHJZB3L16u6SFyS3vRWtTxZsxu98Z4lpQI9nkv/NUE9cGOesQFbkm49C
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4feaf8ec.2435.18f55dd9745.Coremail.gaoshanliukou@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD333R42DpmZiMnAA--.42497W
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/1tbiNwbX8mXAlHQD7QACs9
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI0LTA1LTA3IDEzOjI4OjU4LCAiQWxleGFuZHJlIEdoaXRpIiA8YWxleEBnaGl0aS5m
cj4gd3JvdGU6Cj5IaSBZYW5nLAo+Cj5PbiAwNi8wNS8yMDI0IDA0OjIyLCB5YW5nLnpoYW5nIHdy
b3RlOgo+PiBGcm9tOiAieWFuZy56aGFuZyIgPHlhbmcuemhhbmdAaGV4aW50ZWsuY29tPgo+Pgo+
PiBJZiB0cmFwIGVhcmxpZXIsIHRyYXAgdmVjdG9yIGRvZXNuJ3QgeWV0IHNldCBwcm9wZXJseSwg
Y3VycmVudAo+PiB2YWx1ZSBtYXliZSBzZXQgYnkgcHJldmlvdXMgZmlybXdpcmUsIHR5cGljYWxs
eSBpdCdzIHRoZSBfc3RhcnQgb2Yga2VybmVsLAo+PiBpdCdzIGNvbmZ1c2VkIGFuZCBkaWZmaWN1
bHQgdG8gZGVidWdlLCBzbyBzZXQgaXQgZWFybGllci4KPgo+Cj5XaGF0IGFib3V0Ogo+Cj4iVGhl
IGV4Y2VwdGlvbiB2ZWN0b3Igb2YgdGhlIGJvb3RpbmcgaGFydCBpcyBub3Qgc2V0IGJlZm9yZSBl
bmFibGluZyB0aGUgCj5tbXUgYW5kIHRoZW4gc3RpbGwgcG9pbnRzIHRvIHRoZSB2YWx1ZSBvZiB0
aGUgcHJldmlvdXMgZmlybXdhcmUsIAo+dHlwaWNhbGx5IF9zdGFydF9rZXJuZWwuIFRoYXQgbWFr
ZXMgaXQgaGFyZCB0byBkZWJ1ZyBzZXR1cF92bSgpIHdoZW4gYmFkIAo+dGhpbmdzIGhhcHBlbi4g
U28gZml4IHRoYXQgYnkgc2V0dGluZyB0aGUgZXhjZXB0aW9uIHZlY3RvciBlYXJsaWVyLiIKCkhp
IGFsZXg6Ck1heWJlICJ0eXBpY2FsbHkgX3N0YXJ0IiBub3QgInR5cGljYWxseSBfc3RhcnRfa2Vy
bmVsIiwgcmlnaHQ/ClRoYW5rcyBmb3IgeW91ciBoZWxwoaMKPj4gLS0tCj4+IHYxIC0+IHYyOgo+
PiBBcyBBbGV4IGNvbW1lbnRlZCwgcmVtb3ZlIHRoZSBwYXRjaCBmb3Igc3VwcG9ydGluZyBodWdl
c2l6ZSBrZXJuZWsgaW1hZ2UKPj4gQWRkIHRoZSBvbWlzc2l2ZSBsb2dpYyBvZiBzZXQgdHJhcCB2
ZWN0b3IgZWFybGllcgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiB5YW5nLnpoYW5nIDx5YW5nLnpoYW5n
QGhleGludGVrLmNvbT4KPj4gLS0tCj4+ICAgYXJjaC9yaXNjdi9rZXJuZWwvaGVhZC5TIHwgMyAr
KysKPj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQg
YS9hcmNoL3Jpc2N2L2tlcm5lbC9oZWFkLlMgYi9hcmNoL3Jpc2N2L2tlcm5lbC9oZWFkLlMKPj4g
aW5kZXggNDIzNmE2OWMzNWNiLi4wM2RjNDQwZTY0M2UgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvcmlz
Y3Yva2VybmVsL2hlYWQuUwo+PiArKysgYi9hcmNoL3Jpc2N2L2tlcm5lbC9oZWFkLlMKPj4gQEAg
LTMwMCw2ICszMDAsOSBAQCBTWU1fQ09ERV9TVEFSVChfc3RhcnRfa2VybmVsKQo+PiAgICNlbHNl
Cj4+ICAgCW12IGEwLCBhMQo+PiAgICNlbmRpZiAvKiBDT05GSUdfQlVJTFRJTl9EVEIgKi8KPj4g
KwkvKiBTZXQgdHJhcCB2ZWN0b3IgdG8gc3BpbiBmb3JldmVyIHRvIGhlbHAgZGVidWcgKi8KPj4g
KwlsYSBhMywgLkxzZWNvbmRhcnlfcGFyawo+PiArCWNzcncgQ1NSX1RWRUMsIGEzCj4+ICAgCWNh
bGwgc2V0dXBfdm0KPj4gICAjaWZkZWYgQ09ORklHX01NVQo+PiAgIAlsYSBhMCwgZWFybHlfcGdf
ZGlyCj4KPk5vdGUgdGhhdCB0aGlzIHBhdGNoIHdpbGwgYWxsb3cgdG8gY2F0Y2ggYW55IGV4Y2Vw
dGlvbiBoYXBwZW5pbmcgaW4gCj5zZXR1cF92bSgpIGJ1dCBhcyB3ZSByZXNldCBzdHZlYyBpbiBy
ZWxvY2F0ZV9lbmFibGVfbW11LiBCdXQgdGhhdCdzIG9rLCAKPml0IHdpbGwgaGVscCBjYXRjaGlu
ZyB3ZWlyZCBidWdzIG1vcmUgZWFzaWx5IDopCj4KPldpdGggdGhlIGNvbW1pdCBtZXNzYWdlIGZp
eGVkLCB5b3UgY2FuIGFkZDoKPgo+UmV2aWV3ZWQtYnk6IEFsZXhhbmRyZSBHaGl0aSA8YWxleGdo
aXRpQHJpdm9zaW5jLmNvbT4KPgo+VGhhbmtzLAo+Cj5BbGV4Cg==

