Return-Path: <linux-kernel+bounces-423251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2689DA501
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85734164DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8695C190486;
	Wed, 27 Nov 2024 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="DIcMl3mJ"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AF7188906
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700727; cv=none; b=M+f6ojYz0CDalc4GuD/o6rdC6gLI2Uwgh0pWpxIi/4y2HufsITL8zWvGv5SFE8A/Ek23ZWP7By5PVFfVzOrbW9ETHpuI/0BF0WwQIEyVGYskd0BbZ5OFoW3+3BIBdFl++TZiFbEemS/ten0u3Lw2T9tHZqMshFhyzoz/WkPwkeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700727; c=relaxed/simple;
	bh=R0UCxElKdCp+hubXUKJSpzZPeHqIOSutD5BOePIenkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=mS758CngKEyaHGHNZRi/x98iMDWjdSb0aRMuJxQPplFtDeAqvKUo2IEUZQiHFnYH8myYQ1gLGZ96yz9vbVVpiatTGfnXnRMKkQ4BIZzqA1tfaH2L2tKl0eYGRDFKmdL9/qwpFntxgeRcfQ1pbEj2kyTguFFbhXTGSK2va5C+GWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=DIcMl3mJ reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=/ESgmIG7xx5KLGOElhQnqeAdImd4EEFmlVpuNFQjj/g=; b=D
	IcMl3mJYWyZ5xPYnvF8GFoeGGDNhu/MyJw2F7CKkcX4TSspgOOVZagCC2cT9erwb
	EgnfY55Pz5a4BfctCxp79eFJAUowtV6MuvJsGcOZqxiRnlahgdl4OuGpqIzY4pEi
	Da4WA664yWHd3tyCJ24Ikcyrg1C1SSWxaz5BmNz3Es=
Received: from 00107082$163.com ( [111.35.188.140] ) by
 ajax-webmail-wmsvr-40-139 (Coremail) ; Wed, 27 Nov 2024 17:44:26 +0800
 (CST)
Date: Wed, 27 Nov 2024 17:44:26 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, yuzhao@google.com
Subject: Re: Abnormal values show up in /proc/allocinfo
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAJuCfpHZhMwK8jOz_evvvD8CaNxxaaRQEx0Qv_yPp4ZA_DkXeg@mail.gmail.com>
References: <20241124074318.399027-1-00107082@163.com>
 <CAJuCfpHviS-pw=2=BNTxp1TnphjuiqWGgZnq84EHvbz08iQ6eg@mail.gmail.com>
 <70bad55f.b656.19362cca6ee.Coremail.00107082@163.com>
 <CAJuCfpHho8se-f4cnvk0g1YLNzhvG3q8QTYmvMmweUnGAhtA=g@mail.gmail.com>
 <CAJuCfpEP-xMzHonsE3uV1uYahXehR007B5QX9KjdZdHBWyrXwQ@mail.gmail.com>
 <51c19b31.eaf.193660912f7.Coremail.00107082@163.com>
 <337c721a.70d1.1936753c377.Coremail.00107082@163.com>
 <CAJuCfpHZhMwK8jOz_evvvD8CaNxxaaRQEx0Qv_yPp4ZA_DkXeg@mail.gmail.com>
X-NTES-SC: AL_Qu2YAPubv04t4CGQbekXn0oTju85XMCzuv8j3YJeN500iSXQ1z4AcnBePnz74sORBwmSvxeVURFHyuVYUY5fY5yoN8UcrFImeSYWoJctPzCS
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1801415b.a202.1936d01f953.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iygvCgAXdNL76UZnzsYxAA--.20947W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMwakqmdG4h6rkgACsd
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKQXQgMjAyNC0xMS0yNyAwMToxMDoyMywgIlN1cmVuIEJhZ2hkYXNhcnlhbiIgPHN1cmVuYkBn
b29nbGUuY29tPiB3cm90ZToKCj4KPkhpIERhdmlkLAo+VGhhbmtzIGZvciB0aGUgaW52ZXN0aWdh
dGlvbi4gSSB0aGluayB5b3VyIHN1Z2dlc3Rpb24gc2hvdWxkIHdvcmsgZmluZQo+YW5kIGl0J3Mg
c2ltcGxlciB0aGFuIHdoYXQgd2UgZG8gbm93LiBJdCB3aWxsIHN3YXAgbm90IG9ubHkgY291bnRl
cnMKPmJ1dCBhbGxvY2F0aW9uIGxvY2F0aW9ucyBhcyB3ZWxsLCBob3dldmVyIEkgdGhpbmsgd2Ug
YWxyZWFkeSBkbyB0aGF0Cj53aGVuIHdlIGNhbGwgX19hbGxvY190YWdfcmVmX3NldCgpLiBTbywg
aW5zdGVhZCBvZiBjbGVhcmluZyB0aGUKPm9yaWdpbmFsIHRhZywgZGVjcmVtZW50aW5nIHRoZSBu
ZXcgdGFnJ3MgY291bnRlciAodG8gY29tcGVuc2F0ZSBmb3IKPml0cyBvd24gYWxsb2NhdGlvbikg
YW5kIHJlYXNzaWduaW5nIHRoZSBvbGQgdGFnIHRvIHRoZSBuZXcgY291bnRlciwKPnlvdSBzaW1w
bHkgc3dhcCB0aGUgdGFncy4gVGhhdCBzZWVtcyBmaW5lIHRvIG1lLgo+SG93ZXZlciBJIHRoaW5r
IHRoZXJlIGlzIHN0aWxsIGEgYnVnIHdoZXJlIHNvbWUgZ2V0X25ld19mb2xpbygpCj5jYWxsYmFj
ayBkb2VzIG5vdCBpbmNyZW1lbnQgdGhlIG5ldyBmb2xpbydzIGNvdW50ZXJzIGFuZCB0aGF0J3Mg
d2h5IHdlCj5nZXQgYW4gdW5kZXJmbG93IHdoZW4gY2FsbGluZyBhbGxvY190YWdfc3ViKCkuIEkn
bGwgdHJ5IHRvIHJlcHJvZHVjZQo+b24gbXkgc2lkZSBhbmQgc2VlIHdoYXQncyBnb2luZyBvbiB0
aGVyZS4KCkFncmVlZCwgdGhlIHJlYXNvbiBmb3IgdW5kZXJmbG93IHdpdGggY3VycmVudCBjb2Rl
IHNob3VsZCBiZSBjbGFyaWZpZWQuCkp1c3QgdXBkYXRlIHJlcHJvZHVjZSBwcm9jZWR1cmU6CjEu
IGZpbyAtLXJhbmRyZXBlYXQ9MSAtLWlvZW5naW5lPWxpYmFpbyAtLWRpcmVjdD0xIC0tbmFtZT10
ZXN0ICAtLWJzPTRrIC0taW9kZXB0aD02NCAtLXNpemU9MUcgLS1yZWFkd3JpdGU9cmFuZHJ3ICAt
LXJ1bnRpbWU9MTAwIC0tbnVtam9icz00IC0tdGltZV9iYXNlZD0xCjIuICBlY2hvIDEgPi9wcm9j
L3N5cy92bS9jb21wYWN0X21lbW9yeQozLiAgZWNobyAxID4gL3Byb2Mvc3lzL3ZtL2Ryb3BfY2Fj
aGVzCihJdCBpcyB2ZXJ5IHN0cmFuZ2UsIG9uIG15IFZNLCAgImVjaG8gMyA+IC9wcm9jL3N5cy92
bS9kcm9wX2NhY2hlcyIgd291bGQgbm90IHRyaWdnZXIgZWFzaWx5LiAgCjQgY2F0IC9wcm9jL2Fs
bG9jaW5mbyB8IGdyZXAgX19maWxlbWFwX2dldF9mb2xpbwoKCkZZSQpEYXZpZAoKCj5UaGFua3Ms
Cj5TdXJlbi4KPgo+Pgo+PiAgc3RhdGljIHZvaWQgc2h1dGRvd25fbWVtX3Byb2ZpbGluZyhib29s
IHJlbW92ZV9maWxlKQo+Pgo+Pgo+Pgo+PiBGWUkKPj4gRGF2aWQKPj4KPj4KPj4gPgo+PiA+VGhh
bmtzfgo+PiA+RGF2aWQKPj4gPgo+PiA+Pgo+PiA+Pj4gPiA+VGhhbmtzLAo+PiA+Pj4gPiA+U3Vy
ZW4uCj4+ID4+PiA+ID4KPj4gPj4+ID4gPj4KPj4gPj4+ID4gPj4KPj4gPj4+ID4gPj4gVGhhbmtz
Cj4+ID4+PiA+ID4+IERhdmlkCj4+ID4+PiA+ID4+Cj4+ID4+PiA+ID4+Cj4+ID4+PiA+ID4+Cj4+
ID4+PiA+ID4+Cg==

