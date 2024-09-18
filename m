Return-Path: <linux-kernel+bounces-332246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDF597B72A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 05:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02055286CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600C813A3EC;
	Wed, 18 Sep 2024 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="TYVe56lT"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5127442
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726631985; cv=none; b=IF6K46JSxXLtQMk4Xtldqxgjwp8a3iBH4jC+UYCr6exCE3qnRCR/mteRrAhaxKYoybXq67RLq4nJtYc0YnvcEr7uv9XKIcwprXHushujsAWByBtMqdiUmACeamCqvk9HlNa41fn12B46j7l37XSyh8WuY+eN0rlwmUYS5REs54U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726631985; c=relaxed/simple;
	bh=g4pV84ZXe6Z3UQh0TVE5prh0s6XUyVugKfi/NSEEO9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=n5/X8dyliB7ojhau9fL6GdhgHChUviTqzQTF0wQ/bz1ScnUavAwjetkDvfHA9k9mkhMV3D7FOIg/PwGS8X0Sj+3dGmv8UiC1hpkZZsdQ6C0DDr/vCiUll/WuEdSVjT96PbxY/+NYgv/SLcgx7COfRv6Ig3yLU0E71uGRMPeJO9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=TYVe56lT reason="signature verification failed"; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtpsz4t1726631918taq48xd
X-QQ-Originating-IP: 1Sn0WOKbwVG4a4Z6Z9OX5IYgS+IIhgH0rPbwJGuBZk0=
Received: from m16.mail.163.com ( [117.135.210.5])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 18 Sep 2024 11:58:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13185123578724237292
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=y3E6MmDVT/btgzdDlbzQ7veIeptYfTz+aSWqvVj2FMk=; b=T
	YVe56lT8CH3Mp31ds3uz9hMVD/wR3/Aow/PqsIbX3Ge4j14sg7k8PzHy0a6pWM3n
	DWKjz5vYNMoMIejniuTdz34cNEGCviFTzAF6PPuHvA05ggw2fDSJ+TvuElRd/3yj
	4IvdflzGEXOBiypRzPD+SWFvv/IRAETByKsU68IcYQ=
Received: from kxwang23$m.fudan.edu.cn ( [202.120.235.228] ) by
 ajax-webmail-wmsvr-40-138 (Coremail) ; Wed, 18 Sep 2024 11:57:57 +0800
 (CST)
Date: Wed, 18 Sep 2024 11:57:57 +0800 (CST)
From: "Kaixin Wang" <kxwang23@m.fudan.edu.cn>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: sre@kernel.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org, 
	21210240012@m.fudan.edu.cn, 21302010073@m.fudan.edu.cn
Subject: Re: [PATCH v2] HSI: ssi_protocol: Fix use after free vulnerability
 in ssi_protocol Driver Due to Race Condition
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZugK8hXvMaMEaOsz@smile.fi.intel.com>
References: <20240914172142.328-1-kxwang23@m.fudan.edu.cn>
 <ZugK8hXvMaMEaOsz@smile.fi.intel.com>
X-NTES-SC: AL_Qu2ZBPqYvkAs4SmeZukXn0kbjug3WcW0u/0k3oJUNps0iCXO5jASYlZYDHzb6/qIERKvmTG6YB9gwcB/WaZ3Y4ldX8L0cE/rMG2+CnumzVwv
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <90855D27249D797E+4a7cfd3a.4df2.19203479d54.Coremail.kxwang23@m.fudan.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3H+jHT+pmeKURAA--.2334W
X-CM-SenderInfo: zprtkiiuqyikitw6il2tof0z/1tbiYxxc2GV4KzIKgAAIs9
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

CkF0IDIwMjQtMDktMTYgMTg6Mzk6NDYsICJBbmR5IFNoZXZjaGVua28iIDxhbmRyaXkuc2hldmNo
ZW5rb0BsaW51eC5pbnRlbC5jb20+IHdyb3RlOgo+T24gU3VuLCBTZXAgMTUsIDIwMjQgYXQgMDE6
MjE6NDNBTSArMDgwMCwgS2FpeGluIFdhbmcgd3JvdGU6Cj4+IEluIHRoZSBzc2lfcHJvdG9jb2xf
cHJvYmUgZnVuY3Rpb24sICZzc2ktPndvcmsgaXMgYm91bmQgd2l0aAo+PiBzc2lwX3htaXRfd29y
aywgSW4gc3NpcF9wbl9zZXR1cCwgdGhlIHNzaXBfcG5feG1pdCBmdW5jdGlvbgo+PiB3aXRoaW4g
dGhlIHNzaXBfcG5fb3BzIHN0cnVjdHVyZSBpcyBjYXBhYmxlIG9mIHN0YXJ0aW5nIHRoZQo+PiB3
b3JrLgo+Cj5XZSByZWZlciB0byB0aGUgZnVuY3Rpb25zIGFzIGZ1bmMoKS4gRS5nLiwgc3NpcF9w
bl9zZXR1cCgpLAo+c3NpcF9wbl94bWl0KCkuCj4KCkkgd2lsbCBjb3JyZWN0IGl0LgoKPj4gSWYg
d2UgcmVtb3ZlIHRoZSBtb2R1bGUgd2hpY2ggd2lsbCBjYWxsIHNzaV9wcm90b2NvbF9yZW1vdmUK
Pj4gdG8gbWFrZSBhIGNsZWFudXAsIGl0IHdpbGwgZnJlZSBzc2kgdGhyb3VnaCBrZnJlZShzc2kp
LAo+PiB3aGlsZSB0aGUgd29yayBtZW50aW9uZWQgYWJvdmUgd2lsbCBiZSB1c2VkLiBUaGUgc2Vx
dWVuY2UKPj4gb2Ygb3BlcmF0aW9ucyB0aGF0IG1heSBsZWFkIHRvIGEgVUFGIGJ1ZyBpcyBhcyBm
b2xsb3dzOgo+PiAKPj4gQ1BVMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENQ
VTEKPj4gCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIHwgc3NpcF94bWl0X3dvcmsKPj4gc3Np
X3Byb3RvY29sX3JlbW92ZSAgICAgfAo+PiBrZnJlZShzc2kpOyAgICAgICAgICAgICB8Cj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgc3RydWN0IGhzaV9jbGllbnQgKmNsID0gc3NpLT5jbDsK
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgfCAvLyB1c2Ugc3NpCj4+IAo+PiBGaXggaXQgYnkg
ZW5zdXJpbmcgdGhhdCB0aGUgd29yayBpcyBjYW5jZWxlZCBiZWZvcmUgcHJvY2VlZGluZwo+PiB3
aXRoIHRoZSBjbGVhbnVwIGluIHNzaV9wcm90b2NvbF9yZW1vdmUuCj4KPlNhbWUgaGVyZS4KPgoK
SSB3aWxsIGNvcnJlY3QgaXQuCgo+Li4uCj4KPj4gQWNrZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8
YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPgo+Cj4+IC0gYWRkIHRoZSBBY2tlZC1i
eSBsYWJlbCBmcm9tIEFuZHkKPgo+Tm90IHRoYXQgQWNrIHdhcyBnaXZlbiB0byBfdGhpc18gdmVy
c2lvbiBvZiB0aGUgY2hhbmdlIChpdCBoYXMgYmVlbiBjaGFuZ2VkCj5hIGxvdCksIGJ1dCBJJ20g
ZmluZSB3aXRoIGtlZXBpbmcgaXQuCj4KClNvcnJ5LCBJIG1pc3NlZCB0aGlzIHBvaW50LgoKPi0t
IAo+V2l0aCBCZXN0IFJlZ2FyZHMsCj5BbmR5IFNoZXZjaGVua28KPgo+Cj4KCkJlc3QgcmVnYXJk
cywKS2FpeGluIFdhbmcK

