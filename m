Return-Path: <linux-kernel+bounces-532956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEF3A45420
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D8D16F07F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8084266EF1;
	Wed, 26 Feb 2025 03:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="HgX8tasU"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64942AB4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740541554; cv=none; b=cA2KxtMhhe2thNuGGick0h5AazL7/f/j30xKIi0Qkl4NMabX71jbmB8QcB/S70vxqc6lS6rlk+MY3pDMVfQqUvgGA3D7KZ0VKZMkeXvP+R6UMU+YjA3aXsWZYxeNMgHrOcOyvdYWzyY2qXXu9P25A7mMZplpbZVYuqwPHZq3vM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740541554; c=relaxed/simple;
	bh=A8wLeaPz+KXaAe28bGFXAyg33i1t+Hjd7ha8vFjEDi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=WbEXCn8nGtDd21IHyDJVrKGcmO7gcQGHheewswp9uT7T2wcm5PdJrDjEyWdqStaAM13+GcgCOMdFqHq5yB7uwLxj0N5AYxNBYddW3bLFXMOOTRWfocrpbZLTN7wXxQvZEZJqLkpvyBfdtPm+DIFTKcBwRzxmjj+xq0m1fVlHF+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=HgX8tasU reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=kqrb1Tuv45oCW2s52tTkGEMymHWWUvdmwqaWUOHB7w8=; b=H
	gX8tasUmKHVA1Lxwkufzo1CRzUWwwHfkJwGvmr2upyq0OHqXkFvJ6K5bT/tRnxhP
	az78h9LgPlnt4hqyWjJN/fw4MMOBTUGAog8SoDjoMkU3p13rX5SHyx1uhDoErgvw
	qJkzBcT0nw75bRJvD8VPPNOxix+RaYYC6m0mefN2uU=
Received: from 00107082$163.com ( [111.35.188.205] ) by
 ajax-webmail-wmsvr-40-114 (Coremail) ; Wed, 26 Feb 2025 11:45:06 +0800
 (CST)
Date: Wed, 26 Feb 2025 11:45:06 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Alexandre Ghiti" <alex@ghiti.fr>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 12/13] riscv/irq: use seq_put_decimal_ull_width() for
 decimal values
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <4c7393a5-ad1a-4740-b454-a9b85682a78f@ghiti.fr>
References: <20241108162503.9914-1-00107082@163.com>
 <4c7393a5-ad1a-4740-b454-a9b85682a78f@ghiti.fr>
X-NTES-SC: AL_Qu2fAvmfvk0r4CKeY+kZnEYQheY4XMKyuPkg1YJXOp80oyT14wcab19+GEfU1cmEMjuxkDi4QBVL8OF6frh9bYSLHs3bYr0Aa7jmWCMw5TKj
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <70e006c0.4333.195405bb2e1.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cigvCgAHrgpDjr5np6FwAA--.46027W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0hIAqme+gqCYAQAGsO
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGksIAoKVGhhbmtzIGZvciB0aGUgdGVzdCBhbmQgIHJldmlldywgYW5kIHNvcnJ5IGZvciBub3Qg
Z2l2aW5nICBtb3JlIGF0dGVudGlvbnMgdG8gYWxpZ25tZW50IGlzc3VlcyB3aGVuIG1hZGUgdGhl
IHBhdGNoLgpCdXQgaWYgYWxpZ25tZW50IHNob3VsZCBub3QgYmUgY2hhbmdlZCwgc2ltcGx5IGFw
cGVuZGluZyBhIFtzcGFjZV0gaXMgbm90IGVub3VnaDogIHRoZSBwYXRjaCBjaGFuZ2UKJyUxMHVb
c3BhY2VdIiB0byAiW3NwYWNlXSUxMHUiLCAgIG9uZSBbc3BhY2VdIGlzIG1vdmVkIGZyb20gdGFp
bCB0byB0aGUgZnJvbnQsICBhbmQgdG8gcmVzdG9yZSB0byBpdHMgb3JpZ2luYWwgc3RhdGUKLCBv
bmUgW3NwYWNlXSBzaG91bGQgYmUgcmVtb3ZlZCBmcm9tIGZyb250LiAgYW5kIEl0IHdvdWxkIG1h
a2UgdGhlIGNvZGUgIHVnbHkgYW5kIHVucGxlYXNhbnQgIHRvIHJlbW92ZSBhIFtzcGFjZV0KZnJv
bSB0aGlzIGxpbmUgCiAgICAgICAgc2VxX3ByaW50ZihwLCAiJSpzJXU6JXMiLCBwcmVjIC0gMSwg
IklQSSIsIGksIHByZWMgPj0gNCA/ICIgIiA6ICIiKTsKKCBvciBtYWtlIGNoYW5nZXMgdG8gc2Vx
X3B1dF9kZWNpbWFsX3VsbF93aWR0aCkKCgpLaW5kIG9mIHRoaW5rIHRoYXQgaXQgZG9lcyBub3Qg
d29ydGggdGhlIGVmZm9ydCBpZiAgY29kZSBjaGFuZ2VzIGFyZSB3YXkgdG9vIHVucGxlYXNhbnQu
Li4uCgoKVGhhbmtzCkRhdmlkCiAKCkF0IDIwMjUtMDItMjUgMjM6MTA6MjYsICJBbGV4YW5kcmUg
R2hpdGkiIDxhbGV4QGdoaXRpLmZyPiB3cm90ZToKPkhpIERhdmlkLAo+Cj5PbiAwOC8xMS8yMDI0
IDE3OjI1LCBEYXZpZCBXYW5nIHdyb3RlOgo+PiBQZXJmb3JtYW5jZSBpbXByb3ZlbWVudCBmb3Ig
cmVhZGluZyAvcHJvYy9pbnRlcnJ1cHRzIG9uIGFyY2ggcmlzY3YKPj4KPj4gU2lnbmVkLW9mZi1i
eTogRGF2aWQgV2FuZyA8MDAxMDcwODJAMTYzLmNvbT4KPj4gLS0tCj4+ICAgYXJjaC9yaXNjdi9r
ZXJuZWwvc21wLmMgfCAzICsrLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL3NtcC5j
IGIvYXJjaC9yaXNjdi9rZXJuZWwvc21wLmMKPj4gaW5kZXggYzE4MGE2NDdhMzBlLi5mMWU5YzNk
YjA5NGMgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL3NtcC5jCj4+ICsrKyBiL2Fy
Y2gvcmlzY3Yva2VybmVsL3NtcC5jCj4+IEBAIC0yMjYsNyArMjI2LDggQEAgdm9pZCBzaG93X2lw
aV9zdGF0cyhzdHJ1Y3Qgc2VxX2ZpbGUgKnAsIGludCBwcmVjKQo+PiAgIAkJc2VxX3ByaW50Zihw
LCAiJSpzJXU6JXMiLCBwcmVjIC0gMSwgIklQSSIsIGksCj4+ICAgCQkJICAgcHJlYyA+PSA0ID8g
IiAiIDogIiIpOwo+PiAgIAkJZm9yX2VhY2hfb25saW5lX2NwdShjcHUpCj4+IC0JCQlzZXFfcHJp
bnRmKHAsICIlMTB1ICIsIGlycV9kZXNjX2tzdGF0X2NwdShpcGlfZGVzY1tpXSwgY3B1KSk7Cj4+
ICsJCQlzZXFfcHV0X2RlY2ltYWxfdWxsX3dpZHRoKHAsICIgIiwKPj4gKwkJCQkJCSAgaXJxX2Rl
c2Nfa3N0YXRfY3B1KGlwaV9kZXNjW2ldLCBjcHUpLCAxMCk7Cj4+ICAgCQlzZXFfcHJpbnRmKHAs
ICIgJXNcbiIsIGlwaV9uYW1lc1tpXSk7Cj4+ICAgCX0KPj4gICB9Cj4KPgo+VmVyeSBsYXRlIGFu
c3dlciBzb3JyeSEKPgo+SSBkb24ndCBoYXZlIHRoZSBzYW1lIG91dHB1dCBiZWZvcmUgYW5kIGFm
dGVyIHlvdXIgcGF0Y2ggYmVjYXVzZSAKPnNlcV9wdXRfZGVjaW1hbF91bGxfd2lkdGgoKSBzZWNv
bmQgYXJndW1lbnQgaXMgcGxhY2VkICpiZWZvcmUqIHRoZSAKPm51bWJlciwgbm90IGFmdGVyIGFz
IGl0IHdhcyBiZWZvcmUuCj4KPlRoZSBmb2xsb3dpbmcgZGlmZiBmaXhlcyB0aGUgaXNzdWU6Cj4K
PmRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9zbXAuYyBiL2FyY2gvcmlzY3Yva2VybmVs
L3NtcC5jIGluZGV4IAo+ZjFlOWMzZGIwOTRjMy4uNGI4MGVlNGU1YjJjMCAxMDA2NDQgLS0tIGEv
YXJjaC9yaXNjdi9rZXJuZWwvc21wLmMgKysrIAo+Yi9hcmNoL3Jpc2N2L2tlcm5lbC9zbXAuYyBA
QCAtMjI1LDkgKzIyNSwxMSBAQCB2b2lkIAo+c2hvd19pcGlfc3RhdHMoc3RydWN0IHNlcV9maWxl
ICpwLCBpbnQgcHJlYykgZm9yIChpID0gMDsgaSA8IElQSV9NQVg7IAo+aSsrKSB7IHNlcV9wcmlu
dGYocCwgIiUqcyV1OiVzIiwgcHJlYyAtIDEsICJJUEkiLCBpLCBwcmVjID49IDQgPyAiICIgOiAK
PiIiKTsgLSBmb3JfZWFjaF9vbmxpbmVfY3B1KGNwdSkgLSBzZXFfcHV0X2RlY2ltYWxfdWxsX3dp
ZHRoKHAsICIgIiwgKyAKPmZvcl9lYWNoX29ubGluZV9jcHUoY3B1KSB7ICsgc2VxX3B1dF9kZWNp
bWFsX3VsbF93aWR0aChwLCBOVUxMLCAKPmlycV9kZXNjX2tzdGF0X2NwdShpcGlfZGVzY1tpXSwg
Y3B1KSwgMTApOyArIHNlcV9wdXRjKHAsICcgJyk7ICsgfSAKPnNlcV9wcmludGYocCwgIiAlc1xu
IiwgaXBpX25hbWVzW2ldKTsgfSB9Cj4KPldpbGwgeW91IHJlc3BpbiBhIG5ldyB2ZXJzaW9uPwo+
Cj5UaGFua3MsCj4KPkFsZXgK

