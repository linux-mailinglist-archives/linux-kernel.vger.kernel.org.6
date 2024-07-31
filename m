Return-Path: <linux-kernel+bounces-268447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B14879424B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A11285FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B617BA2;
	Wed, 31 Jul 2024 03:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="h8pHKCOO"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63898DDBE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395043; cv=none; b=bsaZS5/5P86buflnHP2CDGdjw9+I95n9aBeOBINsiR+Xp26bS9UQn4GIJsIp3IqHfV7ygrUaQIu8imN4N/Lt5U5TO9JeKdRBvrG6HMkdlAsQ+R/6g8yx457R5i4clZ2g+wax+YRZRitIscY3mnQtJuDPeRKWHnzF6RB4veN/GvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395043; c=relaxed/simple;
	bh=v4AKbAZqAgYlfpxd7ASi7mp0L8JfpygJzos+PafB7fc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gVOAegz8YcvLd/+CQs8Ff8HmoGG+H7DsdA8QeV1nFWIui3+O1UKl10jBfraj2wEgrsHH50bbS/YvdGFcp358YqPnvP5uVPW9QxBVNSDmllLpLZonqnvFJxwfcBzKF5PbpR2mp/0UaLZfKtwFGcbEUV0LjoVcA5+oVidP16feiXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=h8pHKCOO reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=9/e2p8SnoyZjuBD5kDyZ4Hsc5IvMzC5slAQsPek7aRA=; b=h
	8pHKCOOVohNKcKFZXFhcRMyTYG9iDXiOzBHHscKmMx7BlmB4QVPEk5qCavMMFwy7
	rfdA6qICWfPikWwGbQuIjSd36WN9PEKLXA/hJEqq/+HtcBUjDRYmQHORRfN4uivz
	yZHsrCBgc7okugqdRT61YRXxwK9ho4vl5E0p2bxAcw=
Received: from xavier_qy$163.com ( [59.82.45.99] ) by
 ajax-webmail-wmsvr-40-120 (Coremail) ; Wed, 31 Jul 2024 11:02:05 +0800
 (CST)
Date: Wed, 31 Jul 2024 11:02:05 +0800 (CST)
From: Xavier  <xavier_qy@163.com>
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, tj@kernel.org
Subject: Re:Re: [PATCH-RT sched v1 0/2] Optimize the RT group scheduling
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <acq6wg6r63nhbxsl5xci3gsow2lwmrongn57l5642h4gnreiol@jz6a3jdiviov>
References: <20240627172156.235421-1-xavier_qy@163.com>
 <acq6wg6r63nhbxsl5xci3gsow2lwmrongn57l5642h4gnreiol@jz6a3jdiviov>
X-CM-CTRLMSGS: c/SAlnBsdXM9MTcyMjM5NDkyNzExMl8xMmFmOTA1MGY2MjY2YjQ5M2U0Mjk1Z
 WI2MmRhNjdmMw==
X-NTES-SC: AL_Qu2ZAP+Su0Ep4yeeY+kfmk4aj+k+XsG0vfUj34FWOp9wjDLp5CY5ZEdOLVzo08ijNCyxixWaTTlNxv9mdqpiZq0M9q3liHUJmTPH7tjGYC4O1w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <74ebebc0.2f18.19106bcdacb.Coremail.xavier_qy@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3PxAtqalm3KxYAA--.21884W
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiwhYsEGWXv7P9OwAGsW
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgTWljaGFsLAoKWW91ciBxdWVzdGlvbiBpcyBnb29kLiBob3dldmVyLCBJIGN1cnJlbnRseSBk
b24ndCBoYXZlIGEgc3RhYmxlIGhhcmR3YXJlCmVudmlyb25tZW50IHRvIGV4ZWN1dGUgdGhpcyB0
ZXN0IGNhc2UuIFJ1bm5pbmcgaXQgb24gUUVNVSBpbmRlZWQgc3ViamVjdHMKaXQgdG8gc2lnbmlm
aWNhbnQgcmFuZG9tIGludGVyZmVyZW5jZS4gSSBhdHRlbXB0ZWQgdG8gbWFrZSB0aGUgdGVzdCBj
YXNlcyBydW4KZm9yIGxvbmdlciBwZXJpb2RzLCBidXQgSSBmb3VuZCB0aGF0IHRoZSByZXN1bHRz
IHZhcmllZCBzaWduaWZpY2FudGx5IGVhY2ggdGltZS4KU28gdGhlIHByZXZpb3VzIHRlc3QgZGF0
YSB3YXMgb2J0YWluZWQgYnkgcnVubmluZyB0d28gUUVNVSBpbnN0YW5jZXMKc2ltdWx0YW5lb3Vz
bHksIG9uZSBydW5uaW5nIHRoZSB1bm9wdGltaXplZCBrZXJuZWwgYW5kIHRoZSBvdGhlciBydW5u
aW5nCnRoZSBvcHRpbWl6ZWQga2VybmVsLCB0aGlzIG1ha2VzIHRoZSByZXN1bHRzIG1vcmUgY29u
dmluY2luZy4KCk5ldmVydGhlbGVzcywgZnJvbSB0aGUgY29kZSBsb2dpYywgaXQgaXMgZXZpZGVu
dCB0aGF0IHRoZSBvcHRpbWl6YXRpb25zIGhhdmUKaW5kZWVkIHJlc3VsdGVkIGluIGZld2VyIHNl
IGluc2VydCBhbmQgZGVsZXRlIG9wZXJhdGlvbnMsIHdoaWNoIHRoZW9yZXRpY2FsbHkKc2hvdWxk
IGltcHJvdmUgZWZmaWNpZW5jeS4KClRoYW5rcy4KCi0tCkJlc3QgUmVnYXJkcywKWGF2aWVyCgoK
CgpBdCAyMDI0LTA3LTI5IDE3OjMyOjM3LCAiTWljaGFsIEtvdXRuw70iIDxta291dG55QHN1c2Uu
Y29tPiB3cm90ZToKPk9uIEZyaSwgSnVuIDI4LCAyMDI0IGF0IDAxOjIxOjU0QU0gR01ULCBYYXZp
ZXIgPHhhdmllcl9xeUAxNjMuY29tPiB3cm90ZToKPj4gVGhlIGZpcnN0IHBhdGNoIG9wdGltaXpl
cyB0aGUgZW5xdWV1ZSBhbmQgZGVxdWV1ZSBvZiBydF9zZSwgdGhlIHN0cmF0ZWd5Cj4+IGVtcGxv
eXMgYSBib3R0b20tdXAgcmVtb3ZhbCBhcHByb2FjaC4KPgo+SSBoYXZlbid0IHJlYWQgdGhlIHBh
dGNoZXMsIEkgb25seSBoYXZlIGEgcmVtYXJrIHRvIHRoZSBudW1iZXJzLgo+Cj4+IFRoZSBzZWNv
bmQgcGF0Y2ggcHJvdmlkZXMgdmFsaWRhdGlvbiBmb3IgdGhlIGVmZmljaWVuY3kgaW1wcm92ZW1l
bnRzIG1hZGUKPj4gYnkgcGF0Y2ggMS4gVGhlIHRlc3QgY2FzZSBjb3VudCB0aGUgbnVtYmVyIG9m
IGluZmluaXRlIGxvb3AgZXhlY3V0aW9ucyBmb3IKPj4gYWxsIHRocmVhZHMuCj4+IAo+PiAJCW9y
aWdpb24gICAgICAgICAgb3B0aW1pemVkCj4+IAo+PiAJICAgMTAyNDI3OTQxMzQJCTEwNjU5NTEy
Nzg0Cj4+IAkgICAxMzY1MDIxMDc5OAkJMTM1NTU5MjQ2OTUKPj4gCSAgIDEyOTUzMTU5MjU0CQkx
MzczMzYwOTY0Ngo+PiAJICAgMTE4ODg5NzM0MjgJCTExNzQyNjU2OTI1Cj4+IAkgICAxMjc5MTc5
NzYzMwkJMTM0NDc1OTgwMTUKPj4gCSAgIDExNDUxMjcwMjA1CQkxMTcwNDg0NzQ4MAo+PiAJICAg
MTMzMzUzMjAzNDYJCTEzODU4MTU1NjQyCj4+IAkgICAxMDY4MjkwNzMyOAkJMTA1MTM1NjU3NDkK
Pj4gCSAgIDEwMTczMjQ5NzA0CQkxMDI1NDIyNDY5Nwo+PiAJICAgIDgzMDkyNTk3OTMJCSA4ODkz
NjY4NjUzCj4KPl5eXiBUaGlzIGlzIGZpbmUsIHRoYXQncyB3aGF0IHlvdSBtZWFzdXJlZC4KPgo+
PiBhdmcgICAgICAxMTU0Nzg5NDI2MiAgICAgICAgICAxMTgzNjM3NjQyOQo+Cj5CdXQgcHJvdmlk
aW5nIGF2ZXJhZ2VzIHdpdGggdGhhdCBtYW55IHNpZ25pZmljYW50IGRpZ2l0IGlzIG5vbnNlbnNp
Y2FsCj4obW9zdCBvZiB0aGVtIGFyZSBub2lzZSkuCj4KPklmIEkgcHV0IHlvdXIgY29sdW1ucyBp
bnRvIEQgKE9jdGF2ZSkgYW5kIGVzdGltYXRlIHNvbWUgZXJyb3JzOgo+Cj4oc3RkKEQpL3NxcnQo
MTApKSAuLyBtZWFuKEQpCj5hbnMgPQo+Cj4gICAwLjA0NjYyNiAgIDAuMDQ2NzU1Cj4KPnRoZSBl
cnJvciBpdHNlbGYgd291bGQgYmUgcm91bmRlZCB0byB+NSUsIHNvIHRoZSBhdmVyYWdlcyBtZWFz
dXJlZAo+c2hvdWxkIGJlIHJvdW5kZWQgYWNjb3JkaW5nbHkgCj4KPiBhdmcgICAgMTE1MDAwMDAw
MDAgICAgICAxMTgwMDAwMDAwMAo+Cj5vciBldmVuIG1vcmUgY29uc2VydmF0aXZlbHkKPgo+IGF2
ZyAgICAxMjAwMDAwMDAwMCAgICAgIDEyMDAwMDAwMDAwCj4KPj4gUnVuIHR3byBRRU1VIGVtdWxh
dG9ycyBzaW11bHRhbmVvdXNseSwgb25lIHJ1bm5pbmcgdGhlIG9yaWdpbmFsIGtlcm5lbCBhbmQg
dGhlCj4+IG90aGVyIHJ1bm5pbmcgdGhlIG9wdGltaXplZCBrZXJuZWwsIGFuZCBjb21wYXJlIHRo
ZSBhdmVyYWdlIG9mIHRoZSByZXN1bHRzIG92ZXIKPj4gMTAgcnVucy4gQWZ0ZXIgb3B0aW1pemlu
ZywgdGhlIG51bWJlciBvZiBpdGVyYXRpb25zIGluIHRoZSBpbmZpbml0ZSBsb29wIGluY3JlYXNl
ZAo+PiBieSBhcHByb3hpbWF0ZWx5IDIuNSUuCj4KPk5vdGljZSB0aGF0IHRoZSBtZWFzdXJlIGNo
YW5nZWQgaXMgb24gcGFyIHdpdGggbm9pc2UgaW4gdGhlIGRhdGEgKGkuZS4KPml0IG1heSBiZSBh
Y2NpZGVudGFsKS4gWW91IG1heSBuZWVkIG1vcmUgaXRlcmF0aW9ucyB0byBnZXQgY2xlYW5lcgo+
cmVzdWx0IChtb3JlIGNvbnZpbmNpbmcgZGF0YSkuCj4KPkhUSCwKPk1pY2hhbAo=

