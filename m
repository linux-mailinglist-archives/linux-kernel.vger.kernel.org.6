Return-Path: <linux-kernel+bounces-298160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C95A95C33D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 04:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7D628484A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A691F956;
	Fri, 23 Aug 2024 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="pLkyHY0k"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952582E3E8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 02:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724380148; cv=none; b=UPC3jEL1VmAblJGcjAnbR00+7MhFd5d+7ummSYcqPN6VT1uwkmYazLUe+SQyoRqUgIbBb886wn88UbIzmnYpRVNGb+CTMKsXGV/In3eIRx1oh5rBfuLKR1vkScrvVlDSq2HPtyFUkIc+It2UqNVSKFpgtnf2422nl/e3kZV9tVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724380148; c=relaxed/simple;
	bh=5gLGhVhiqucdVUhAYmX1zCTZp/eosl+HkhZKmOxMuYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=X7fr2nOKJK46s0kZPX8GhcenxCF3f9bwRs6q+7RrD3LOpfXB3rD74ozOrR3ncxJH0p9KuL9eZHZ8r3YvGElxxDb6c2Fn0JbjKOCNZOEzeCfwQ5SJVUiUrHjRYB62xPfCXGxxPjxkDsYEgm0dj7K5K0XKvaBG3D0AL03sdOUcMxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=pLkyHY0k reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=GxeMHzOEffG5hRQjAanGzDjOGnB3bQ0si1Jkofo/PoI=; b=p
	LkyHY0kY+x+3jwissNRaRtWu5wXe6tXKcs7xq7jkKyk65MIJwxm7V2eoDADmbaYm
	+7RU92GDlbgxSJQPF227xWY00+JRZAMemunH6PuKGeqrEVBixc10MTvxFo9BZC5V
	/n2uvKHkDsrv47ROt6DsOynCRREq6X9f2rYcW9bXzQ=
Received: from xavier_qy$163.com ( [59.82.45.112] ) by
 ajax-webmail-wmsvr-40-149 (Coremail) ; Fri, 23 Aug 2024 10:28:25 +0800
 (CST)
Date: Fri, 23 Aug 2024 10:28:25 +0800 (CST)
From: Xavier  <xavier_qy@163.com>
To: tglx@linutronix.de
Cc: anna-maria@linutronix.de, frederic@kernel.org, j.granados@samsung.com, 
	kees@kernel.org, linux-kernel@vger.kernel.org, linux@weissschuh.net, 
	mcgrof@kernel.org
Subject: Re:[PATCH v2] Ucount: Optimize the ucount code
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240812084823.563277-1-xavier_qy@163.com>
References: <8734ncu5c0.ffs@tglx>
 <20240812084823.563277-1-xavier_qy@163.com>
X-NTES-SC: AL_Qu2ZBv+Tv0kr4yCYYekfmk4aj+k+XsG0vfUj34FWOp9wjCLrxwYGTWFeIVjY/86gAC6pgAWKXB9P4d5zdJBoU60PHRiQUxylsIRF4djafjQfXg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2dd8a8ef.27d5.1917d104930.Coremail.xavier_qy@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3PwzJ88dm8QoeAA--.23710W
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZR05EGXAnsRC8wACsd
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGksCgpKdXN0IGEgcmVtaW5kZXIsIGRvZXMgYW55b25lIGhhdmUgYW55IGNvbW1lbnRzIG9yIGZl
ZWRiYWNrIG9uIHRoZSBwYXRjaD8KCi0tClRoYW5rcywKWGF2aWVyCgoKCgpBdCAyMDI0LTA4LTEy
IDE2OjQ4OjIzLCAiWGF2aWVyIiA8eGF2aWVyX3F5QDE2My5jb20+IHdyb3RlOgo+T3B0aW1pemUg
dGhlIG1lbW9yeSByZWxlYXNlIG9wZXJhdGlvbiBieSBwbGFjaW5nIGl0IG91dHNpZGUgb2YgdGhl
Cj5zcGluIGxvY2sgaW4gYWxsb2NfdWNvdW50cy4KPgo+U2lnbmVkLW9mZi1ieTogWGF2aWVyIDx4
YXZpZXJfcXlAMTYzLmNvbT4KPi0tLQo+IGtlcm5lbC91Y291bnQuYyB8IDkgKysrKystLS0tCj4g
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+ZGlmZiAt
LWdpdCBhL2tlcm5lbC91Y291bnQuYyBiL2tlcm5lbC91Y291bnQuYwo+aW5kZXggOGMwNzcxNGZm
MjdkLi44N2E3NzNlNmZmMTUgMTAwNjQ0Cj4tLS0gYS9rZXJuZWwvdWNvdW50LmMKPisrKyBiL2tl
cm5lbC91Y291bnQuYwo+QEAgLTE2NCw3ICsxNjQsNyBAQCBzdHJ1Y3QgdWNvdW50cyAqZ2V0X3Vj
b3VudHMoc3RydWN0IHVjb3VudHMgKnVjb3VudHMpCj4gc3RydWN0IHVjb3VudHMgKmFsbG9jX3Vj
b3VudHMoc3RydWN0IHVzZXJfbmFtZXNwYWNlICpucywga3VpZF90IHVpZCkKPiB7Cj4gCXN0cnVj
dCBobGlzdF9oZWFkICpoYXNoZW50ID0gdWNvdW50c19oYXNoZW50cnkobnMsIHVpZCk7Cj4tCXN0
cnVjdCB1Y291bnRzICp1Y291bnRzLCAqbmV3Owo+KwlzdHJ1Y3QgdWNvdW50cyAqdWNvdW50cywg
Km5ldyA9IE5VTEw7Cj4gCWJvb2wgd3JhcHBlZDsKPiAKPiAJc3Bpbl9sb2NrX2lycSgmdWNvdW50
c19sb2NrKTsKPkBAIC0xODIsOSArMTgyLDcgQEAgc3RydWN0IHVjb3VudHMgKmFsbG9jX3Vjb3Vu
dHMoc3RydWN0IHVzZXJfbmFtZXNwYWNlICpucywga3VpZF90IHVpZCkKPiAKPiAJCXNwaW5fbG9j
a19pcnEoJnVjb3VudHNfbG9jayk7Cj4gCQl1Y291bnRzID0gZmluZF91Y291bnRzKG5zLCB1aWQs
IGhhc2hlbnQpOwo+LQkJaWYgKHVjb3VudHMpIHsKPi0JCQlrZnJlZShuZXcpOwo+LQkJfSBlbHNl
IHsKPisJCWlmICghdWNvdW50cykgewo+IAkJCWhsaXN0X2FkZF9oZWFkKCZuZXctPm5vZGUsIGhh
c2hlbnQpOwo+IAkJCWdldF91c2VyX25zKG5ldy0+bnMpOwo+IAkJCXNwaW5fdW5sb2NrX2lycSgm
dWNvdW50c19sb2NrKTsKPkBAIC0xOTMsNiArMTkxLDkgQEAgc3RydWN0IHVjb3VudHMgKmFsbG9j
X3Vjb3VudHMoc3RydWN0IHVzZXJfbmFtZXNwYWNlICpucywga3VpZF90IHVpZCkKPiAJfQo+IAl3
cmFwcGVkID0gIWdldF91Y291bnRzX29yX3dyYXAodWNvdW50cyk7Cj4gCXNwaW5fdW5sb2NrX2ly
cSgmdWNvdW50c19sb2NrKTsKPisJaWYgKG5ldykKPisJCWtmcmVlKG5ldyk7Cj4rCj4gCWlmICh3
cmFwcGVkKSB7Cj4gCQlwdXRfdWNvdW50cyh1Y291bnRzKTsKPiAJCXJldHVybiBOVUxMOwo+LS0g
Cj4yLjQ1LjIK

