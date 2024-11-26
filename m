Return-Path: <linux-kernel+bounces-421936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A562F9D924C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3187BB23EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C821917EB;
	Tue, 26 Nov 2024 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="K6588PsN"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2678E8F54
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605464; cv=none; b=nWY5ekGaI2SU2BgtZYLOS4f1/63Hu+SDyxKJRP4DkXpQhKp+y4NNwlMg5U0pUMH/p/z2Ttwmf/vkOd+sLcNsJvEbiZUFHi3xCjFWj5104aXP1bmE34z8mErgv1LxMJUClG8wtWRHn24lVQCESNND5WUuwpzkf4h/gYcdCldPFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605464; c=relaxed/simple;
	bh=HpK19tY59xiKlLPs11JAC6mwo+cs0Yf+xayYBAQgZe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ZXLE5E80BQl/o7E0yZG9R9K1PBlQRnA1ZXexyqq76KRRF+Uh60G3UYrR4bD4zUaPhvhHoCKaC+XNPfFfZcYPjjPJ3lZqzHweCgUjCoM4D3C4UXz8FWXjMcBv8BjsjgkvZDeAYNhk9iwt/Qiojb7xCN/ncBMFwq86C2imQTA6TkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=K6588PsN reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=TmwN6MDgR1O/TVJW1LLnw7Xg59ao/Xd7j9yUeqMu1Vo=; b=K
	6588PsNo6uqKUXaD2WKPaSn2nYxc0DVV2numl8yipdaidasrsJxr2oCcyYvuQBXX
	/eZMNvbbfFXvTKHSWqOkk7NNewdBjdq1akfAvUg131QuxtXaLn48+Qip8QAYxyE4
	+XNVYwjja5MKv4pG3x9OG2YY+01AXTjcLww91k0Ywc=
Received: from 00107082$163.com ( [111.35.191.191] ) by
 ajax-webmail-wmsvr-40-101 (Coremail) ; Tue, 26 Nov 2024 15:16:03 +0800
 (CST)
Date: Tue, 26 Nov 2024 15:16:03 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, yuzhao@google.com
Subject: Re: Abnormal values show up in /proc/allocinfo
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <51c19b31.eaf.193660912f7.Coremail.00107082@163.com>
References: <20241124074318.399027-1-00107082@163.com>
 <CAJuCfpHviS-pw=2=BNTxp1TnphjuiqWGgZnq84EHvbz08iQ6eg@mail.gmail.com>
 <70bad55f.b656.19362cca6ee.Coremail.00107082@163.com>
 <CAJuCfpHho8se-f4cnvk0g1YLNzhvG3q8QTYmvMmweUnGAhtA=g@mail.gmail.com>
 <CAJuCfpEP-xMzHonsE3uV1uYahXehR007B5QX9KjdZdHBWyrXwQ@mail.gmail.com>
 <51c19b31.eaf.193660912f7.Coremail.00107082@163.com>
X-NTES-SC: AL_Qu2YAPqbukst5SCdZukXn0oTju85XMCzuv8j3YJeN500syTq1CEpcm9zDUb6+s6AAQKhoAiRXzF+xsFkUqR1Xo2udTj8HZZMUfQ9MYfRQjN8
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <337c721a.70d1.1936753c377.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZSgvCgD3P4u3dUVntTcwAA--.14453W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0h+jqmdFcGAoWwAEsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGksIAoKCkF0IDIwMjQtMTEtMjYgMDk6MTQ6NTAsICJEYXZpZCBXYW5nIiA8MDAxMDcwODJAMTYz
LmNvbT4gd3JvdGU6Cj4KPkhpLCAKPgo+Cj4KPkF0IDIwMjQtMTEtMjYgMDQ6MzE6MzksICJTdXJl
biBCYWdoZGFzYXJ5YW4iIDxzdXJlbmJAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4+Cj4+SGkgRGF2aWQs
Cj4+Q291bGQgeW91IHBsZWFzZSBjaGVjayBpZiB5b3UgaGF2ZSB0aGlzIGZpeDoKPj4KPj5lZDI2
NTUyOWQzOWEgIm1tL2NvZGV0YWc6IGZpeCBhcmcgaW4gcGdhbGxvY190YWdfY29weSBhbGxvY190
YWdfc3ViIgo+Pgo+Pkl0IHdhcyBtZXJnZWQgYWZ0ZXIgdjYuMTItcmM2IGFuZCBpdCBmaXhlcyBh
biBhY2NvdW50aW5nIGJ1ZyBpbnNpZGUKPj5wZ2FsbG9jX3RhZ19jb3B5KCksIHdoaWNoIGlzIHVz
ZWQgZHVyaW5nIGNvbXBhY3Rpb24uCj4+VGhhbmtzLAo+PlN1cmVuLgo+Pgo+Pgo+Pmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDkwNjA0MjEwOC4xMTUwNTI2LTMteXV6aGFvQGdvb2ds
ZS5jb20vCj4+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQxMDIyMjMyNDQwLjMzNDgy
MC0xLXNvdXJhdnBhbmRhQGdvb2dsZS5jb20vCj4KPgo+Tm8sIGVkMjY1NTI5ZDM5YSBpcyBub3Qg
aW4gNi4xMi4wOyBJdCBpcyBub3cgaW4gTGludXMnIHRyZWUuCj5JIHdpbGwgcHVsbCB0aGUgY29k
ZSBhbmQgbWFrZSBzb21lIHRlc3RzLgo+Cj5XaWxsIHVwZGF0ZSBsYXRlci4KCgpJIGJ1aWxkIGEg
a2VybmVsIGJhc2VkIG9uIGEgdHJlZSB3aXRoIHRvcCBjb21taXQgOWYxNmQ1ZTZmMjIwLCAKbm8g
YWJub3JtYWwgdmFsdWUgb2JzZXJ2ZWQgZm9yIGNvbXBhY3Rpb25fYWxsb2M6CgokIHN1ZG8gY2F0
IC9wcm9jL2FsbG9jaW5mbyAgfCBncmVwIGNvbXBhY3Rpb25fYWxsb2MKICAgICAgICAgICAwICAg
ICAgICAwIG1tL2NvbXBhY3Rpb24uYzoxODgwIGZ1bmM6Y29tcGFjdGlvbl9hbGxvYyAyNTAwOTgK
KFRoZSBsYXN0IGNvbHVtbiBpcyBhY2N1bXVsYXRpdmUgY2FsbCBjb3VudGVycyBJIHBhdGNoZWQg
d2l0aCBteSBzeXN0ZW0sIG1lYW5pbmcgY29tcGFjdGlvbl9hbGxvYyBkbyBoYXBwZW4pCgoKQnV0
LCAgc3RpbGwgZ290IHVuZGVyZmxvd2VkIHZhbHVlczoKCiAgICAgICAtNDA5NiAxODQ0Njc0NDA3
MzcwOTU1MTYxNSBtbS9maWxlbWFwLmM6Mzc4OCBmdW5jOmRvX3JlYWRfY2FjaGVfZm9saW8gMTgg
CiAgIC04NjI0MTI4MCAxODQ0Njc0NDA3MzcwOTUzMDU2MSBtbS9maWxlbWFwLmM6MTk1MSBmdW5j
Ol9fZmlsZW1hcF9nZXRfZm9saW8gODY5MTAxNSAKCkZpbmFsbHkgYSBwcm9jZWR1cmUgdG8gcmVw
cm9kdWNlIGl0OiAgKHRoYW5rcyBmb3IgdGhlIHRpcCBhYm91dCBjb21wYWN0X21lbW9yeSkKMS4g
cG9wdWxhdGUgZmlsZSBjYWNoZXMsIGUuZy4gZ3JlcCBzb21ldGhpbmcgaW4ga2VybmVsIHNvdXJj
ZS4KMi4gZWNobyAxID4vcHJvYy9zeXMvdm0vY29tcGFjdF9tZW1vcnkKMy4gZWNobyAzID4gL3By
b2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzCgpUaGVyZSB3b3VsZCBiZSBuZWdhdGl2ZSB2YWx1ZXMgc2hv
dyB1cC4KQSBzaW1wbGUgcHl0aG9uIHNjcmlwdCB0byBjaGVjayBhYm5vcm1hbCB2YWx1ZXM6Cgp3
aXRoIG9wZW4oIi9wcm9jL2FsbG9jaW5mbyIpIGFzIGY6CiAgICBmb3IgbCBpbiBmOgogICAgICAg
IHRyeToKICAgICAgICAgICAgdnMgID0gbC5zcGxpdCgpCiAgICAgICAgICAgIHYxLCB2MiA9IGlu
dCh2c1swXSksIGludCh2c1sxXSkKICAgICAgICAgICAgaWYgdjE8MCBvciB2MjwwIG9yICh2MT09
MCBhbmQgdjIhPTApIG9yICh2MSE9MCBhbmQgdjI9PTApOiBwcmludCBsLAogICAgICAgIGV4Y2Vw
dDogcGFzcwoKCk1vc3QgbGlrZWx5LCBtZW1vcnkgcmVsZWFzZSBpcyBhY2NvdW50ZWQgKnR3aWNl
KiBmb3IgdGhvc2UgbWVtb3J5LgpSZWFkaW5nIHRocm91Z2ggdGhlIGNvZGUsIEkgZmVlbCB0aGUg
bW9zdCBzdXNwZWN0ZWQgY29kZSB3b3VsZCBiZToKICAgIGNsZWFyX3BhZ2VfdGFnX3JlZigmb2xk
LT5wYWdlKTsKVGhpcyBsaW5lIG9mIGNvZGUgbWF5IG5vdCB3b3JrIGFzIGV4cGVjdGVkLgoKVGhl
IGNvZGUgaW4gcGdhbGxvY190YWdfY29weSBpbnZvbHZlcyB0b28gbWFueSBsb3cgbGV2ZWwgcGx1
bWJpbmcgZGV0YWlscywgSSB0aGluayBpdCAKaXMgc2ltcGxlciB0byBqdXN0IGltcGxlbWVudCBh
ICpzd2FwKiBsb2dpYzoganVzdCBzd2FwIHRoZSB0YWdzLgoKSSBtYWRlIGZvbGxvd2luZyBjaGFu
Z2VzIGFuZCBpdCB3b3Jrcywgbm8gYWJub3JtYWwgdmFsdWVzIGRldGVjdGVkLCBzbyBmYXIuCihw
Z2FsbG9jX3RhZ19jb3B5IHNob3VsZCBiZSByZW5hbWVkIHRvIHBnYWxsb2NfdGFnX3N3YXApCgoK
ZGlmZiAtLWdpdCBhL2xpYi9hbGxvY190YWcuYyBiL2xpYi9hbGxvY190YWcuYwppbmRleCAyNDE0
YTdlZTdlYzcuLjdkNmQxMDE1ZjRiMSAxMDA2NDQKLS0tIGEvbGliL2FsbG9jX3RhZy5jCisrKyBi
L2xpYi9hbGxvY190YWcuYwpAQCAtMTkxLDI0ICsxOTIsMzAgQEAgdm9pZCBwZ2FsbG9jX3RhZ19z
cGxpdChzdHJ1Y3QgZm9saW8gKmZvbGlvLCBpbnQgb2xkX29yZGVyLCBpbnQgbmV3X29yZGVyKQog
CiB2b2lkIHBnYWxsb2NfdGFnX2NvcHkoc3RydWN0IGZvbGlvICpuZXcsIHN0cnVjdCBmb2xpbyAq
b2xkKQogewotCXVuaW9uIHBndGFnX3JlZl9oYW5kbGUgaGFuZGxlOwotCXVuaW9uIGNvZGV0YWdf
cmVmIHJlZjsKLQlzdHJ1Y3QgYWxsb2NfdGFnICp0YWc7CisJdW5pb24gcGd0YWdfcmVmX2hhbmRs
ZSBoYW5kbGVfbmV3LCBoYW5kbGVfb2xkOworCXVuaW9uIGNvZGV0YWdfcmVmIHJlZl9uZXcsIHJl
Zl9vbGQ7CisJc3RydWN0IGFsbG9jX3RhZyAqdGFnX25ldywgKnRhZ19vbGQ7CiAKLQl0YWcgPSBw
Z2FsbG9jX3RhZ19nZXQoJm9sZC0+cGFnZSk7Ci0JaWYgKCF0YWcpCisJdGFnX29sZCA9IHBnYWxs
b2NfdGFnX2dldCgmb2xkLT5wYWdlKTsKKwlpZiAoIXRhZ19vbGQpCisJCXJldHVybjsKKwl0YWdf
bmV3ID0gcGdhbGxvY190YWdfZ2V0KCZuZXctPnBhZ2UpOworCWlmICghdGFnX25ldykKIAkJcmV0
dXJuOwogCi0JaWYgKCFnZXRfcGFnZV90YWdfcmVmKCZuZXctPnBhZ2UsICZyZWYsICZoYW5kbGUp
KQorCWlmICghZ2V0X3BhZ2VfdGFnX3JlZigmb2xkLT5wYWdlLCAmcmVmX29sZCwgJmhhbmRsZV9v
bGQpKQorCQlyZXR1cm47CisJaWYgKCFnZXRfcGFnZV90YWdfcmVmKCZuZXctPnBhZ2UsICZyZWZf
bmV3LCAmaGFuZGxlX25ldykpCiAJCXJldHVybjsKIAotCS8qIENsZWFyIHRoZSBvbGQgcmVmIHRv
IHRoZSBvcmlnaW5hbCBhbGxvY2F0aW9uIHRhZy4gKi8KLQljbGVhcl9wYWdlX3RhZ19yZWYoJm9s
ZC0+cGFnZSk7Ci0JLyogRGVjcmVtZW50IHRoZSBjb3VudGVycyBvZiB0aGUgdGFnIG9uIGdldF9u
ZXdfZm9saW8uICovCi0JYWxsb2NfdGFnX3N1YigmcmVmLCBmb2xpb19zaXplKG5ldykpOwotCV9f
YWxsb2NfdGFnX3JlZl9zZXQoJnJlZiwgdGFnKTsKLQl1cGRhdGVfcGFnZV90YWdfcmVmKGhhbmRs
ZSwgJnJlZik7Ci0JcHV0X3BhZ2VfdGFnX3JlZihoYW5kbGUpOworCS8qIHN3YXAgdGFnICovCisJ
X19hbGxvY190YWdfcmVmX3NldCgmcmVmX25ldywgdGFnX29sZCk7CisJdXBkYXRlX3BhZ2VfdGFn
X3JlZihoYW5kbGVfbmV3LCAmcmVmX25ldyk7CisJcHV0X3BhZ2VfdGFnX3JlZihoYW5kbGVfbmV3
KTsKKworCV9fYWxsb2NfdGFnX3JlZl9zZXQoJnJlZl9vbGQsIHRhZ19uZXcpOworCXVwZGF0ZV9w
YWdlX3RhZ19yZWYoaGFuZGxlX29sZCwgJnJlZl9vbGQpOworCXB1dF9wYWdlX3RhZ19yZWYoaGFu
ZGxlX29sZCk7CiB9CiAKIHN0YXRpYyB2b2lkIHNodXRkb3duX21lbV9wcm9maWxpbmcoYm9vbCBy
ZW1vdmVfZmlsZSkKCgoKRllJCkRhdmlkCgoKPgo+VGhhbmtzfgo+RGF2aWQKPgo+Pgo+Pj4gPiA+
VGhhbmtzLAo+Pj4gPiA+U3VyZW4uCj4+PiA+ID4KPj4+ID4gPj4KPj4+ID4gPj4KPj4+ID4gPj4g
VGhhbmtzCj4+PiA+ID4+IERhdmlkCj4+PiA+ID4+Cj4+PiA+ID4+Cj4+PiA+ID4+Cj4+PiA+ID4+
Cg==

