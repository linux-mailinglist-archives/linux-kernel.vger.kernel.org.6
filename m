Return-Path: <linux-kernel+bounces-210169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C579904048
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5C21C22745
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8992383BF;
	Tue, 11 Jun 2024 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="nWXqgAQZ"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F00D1DA4E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120575; cv=none; b=E0DUHiCBy1h7ec0DiAJQcayzwarBwBmW87QmPYpx0cguvUSYRaNnVr4tBjX/KKd2J46MqwOxvfWjQDthKe5VY/XABASfc8SgCnSzmgOUCRchu9qLEtzGHaEqOWwBHC0ZeH+taLALPk5pg/GrxWmzHgd91qc8ica/z0e6bdYrWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120575; c=relaxed/simple;
	bh=VXQYnofBpfEDvoF6OGE+ugSlp9xKvZ0Zx0BQrYKFOz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=jy5Fiejf0hNHiFsWYlZLUyqIlPtoxYyplMox3O1wA9Q7CcAWkciYoZ+9oCviHYEPHdtLNgQC6vqCNRoSXcFPDi/o8rhW1Y872/3L2yJzj4iO0e9HKZ/TZqREILzQMwLVVonceGjSDeNPIXeMxBvIUDC2YHl7UKnMYUeNFq4uyfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=nWXqgAQZ reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=luTtMKdjg6KtwvkFZDVHjSU1c7aujy4aLw+U6nWUJpc=; b=n
	WXqgAQZQLH47Z1ZVq9I6+AgeLnkcaciJBTFFP5d90jLRC6uxNY05xgxKjocF2uOy
	R2rD26orMaTVqXsFT0Qc3kTBCsMxg6iFOBxZ6/zMC2NvXX7dxX59pcP//EfNO9hX
	k9wVlISgpe9N0GRDyr96+czVXT3T5zOHSCMSDDqMNg=
Received: from luuiiruo$163.com ( [113.91.88.209] ) by
 ajax-webmail-wmsvr-40-126 (Coremail) ; Tue, 11 Jun 2024 23:41:53 +0800
 (CST)
Date: Tue, 11 Jun 2024 23:41:53 +0800 (CST)
From: zzz  <luuiiruo@163.com>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] genirq: Fix gpio irq will fail to be resend under
 certain conditions
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <874ja0wqfb.ffs@tglx>
References: <20240608163620.89028-1-luuiiruo@163.com> <874ja0wqfb.ffs@tglx>
X-NTES-SC: AL_Qu2aCv2Zv00q5SaabelSzjN1/pBjOJfWzJlfjsYCZP8ilQ3i2ykiVEFlIVzq8uYGS57Lf2Z+k25Lb+QADbFW
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <320df2de.cd42.19007f68062.Coremail.luuiiruo@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3f0FBcGhmfQZ_AA--.3703W
X-CM-SenderInfo: 5oxxxxxuxrqiywtou0bp/xtbB0gz6k2WXyS3PxQAds2
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

dGdseCwKwqDCoMKgwqBJJ23CoHNvcnJ5wqBmb3LCoG15wqB2YWd1ZcKgZGVzY3JpcHRpb24uwqBG
aXJzdCwgbGV0wqBtZcKgYW5zd2VywqB5b3VywqBxdWVzdGlvbnMuCgo+VGhpc8KgaGFzwqBub3Ro
aW5nwqB0b8KgZG/CoHdpdGjCoEdQSU/CoGludGVycnVwdHMuwqBJdCdzwqBhwqBnZW5lcmFswqBw
cm9ibGVtCj52cy7CoHJlc2VuZCzCoG5vPwpZZXMswqBpwqB0aGlua8KgaXQnc8KgYcKgZ2VuZXJh
bMKgaW50ZXJydXB0c8KgcHJvYmxlbSzCoGJ1dMKgacKgZm91bmTCoGl0wqB3aGlsZcKgdGVzdGlu
Z8KgZ3Bpb8KgaW50ZXJydXB0cy4KCj5Tb8Kgd2hhdMKgeW91wqBhcmXCoHNheWluZ8KgaXM6Cj5B
bsKgaW50ZXJydXB0wqBpc8KgZGlzYWJsZWQswqBidXTCoHRoZcKgd2FrZXVwwqBmdW5jdGlvbsKg
b2bCoHRoZcKgaW50ZXJydXB0wqBpcwo+ZW5hYmxlZCzCoHJpZ2h0PwpZZXMuCgo+Tm93wqB0aGXC
oHN5c3RlbcKgZW50ZXJzwqBzdXNwZW5kwqBhbmTCoHRoZcKgaW50ZXJydXB0wqBpc8KgcmFpc2Vk
LMKgd2hpY2gKPnRyaWdnZXJzwqB0aGXCoHdha2V1cMKgZnVuY3Rpb24swqByaWdodD8KWWVzLgoK
Pk5vd8KgdGhlwqBzeXN0ZW3CoGVudGVyc8Kgc3VzcGVuZMKgbmV2ZXJ0aGVsZXNzLsKgSG93wqBj
YW7CoHRoYXTCoGhhcHBlbj8KQWx0aG91Z2jCoHRoZcKgZGV2aWNlwqBpc8Kgd29rZW7CoHVwwqBi
ecKgZ3Bpb8KgaXJxLMKgaXTCoG1hecKgcmUtZW50ZXLCoHN1c3BlbmTCoGFmdGVywqBzb21lwqB0
aW1lLgoKPkR1ZcKgdG/CoHRoYXTCoHRoZcKgSVJRU19SRVBMQVnCoGZsYWfCoHdpbGzCoGJlwqBz
ZXQuwqBIb3fCoHNvP8KgSVJRU19SRVBMQVnCoGlzCj5vbmx5wqBzZXTCoGZyb23CoHRoZcKgcmVz
ZW5kwqBmdW5jdGlvbi4KV2hlbsKgZW50ZXJpbmfCoHN1c3BlbmTCoCzCoHRoZcKgcGF0aMKgaXPC
oGFzwqBmb2xsb3dzOgpzdXNwZW5kX2RldmljZV9pcnFzKCkKwqDCoMKgwqBzdXNwZW5kX2Rldmlj
ZV9pcnEoKQrCoMKgwqDCoMKgwqDCoMKgX19lbmFibGVfaXJxKCkKwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaXJxX3N0YXJ0dXAoKQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNoZWNr
X2lycV9yZXNlbmQoKcKgwqDCoC0tSVJRU19SRVBMQVnCoGZsYWfCoGlzwqBzZXTCoGluwqB0aGlz
wqBmdW5jdGlvbi4KCj5EdWXCoHRvwqB0aGF0wqBJUlFTX1JFUExBWcKgd2lsbMKgbm90wqBiZcKg
Y2xlYXJlZMKgYmVjYXVzZcKgdGhlwqBpcnFfbWF5X3J1bigpCj5jb25kaXRpb27CoGlzwqBub3TC
oGNsZWFyZWQuwqBTdXJlLMKgYnV0wqBob3fCoGRvZXPCoGFuecKgb2bCoHRoaXPCoGhhcHBlbsKg
aW7CoHRoZQo+Zmlyc3TCoHBsYWNlPwpJwqB3aWxswqBzaG93wqB5b3XCoGHCoGNvbXBsZXRlwqBw
cm9jZXNzLgoKPkJlZm9yZcKgeW91wqBzZW5kwqBtZcKgYcKgZGVjaXBoZXJhYmxlwqBkZXNjcmlw
dGlvbsKgb2bCoHRoZcKgcHJvYmxlbSzCoGxldMKgbWXCoGFzawo+eW91wqBhwqBmZXfCoG9idmlv
dXPCoHF1ZXN0aW9uczoKPsKgwqAxKcKgV2h5wqBpc8KgdGhlwqBpbnRlcnJ1cHTCoGRpc2FibGVk
wqBfYW5kX8KgbWFya2VkwqBhc8Kgd2FrZXVwwqBpbnRlcnJ1cHQ/CknCoGhhdmXCoGHCoHBpbsKg
bmFtZWTCoERBVEEuCldoZW7CoHRoZXJlwqBpc8Kgbm/CoGNvbm5lY3Rpb24swqBEQVRBwqBuZWVk
c8KgdG/CoGJlwqBhwqByZWNvZ25pdGlvbsKgZnVuY3Rpb24swqB0aGXCoAppbnRlcnJ1cHTCoGVu
YWJsZWTCoGFuZMKgd2FrZXVwwqBhcmXCoHVzZWTCoGhlcmUuCldoZW7CoHRoZXJlwqBpc8KgY29u
bmVjdGlvbizCoERBVEHCoGlzwqB1c2VkwqBjb21tdW5pY2F0aW9uwqBmdW5jdGlvbizCoHRoZcKg
aW50ZXJydXB0wqAKZGlzYWJsZWTCoGFuZMKgd2FrZXVwwqBhcmXCoHVzZWTCoGhlcmUuCgo+wqDC
oDIpwqBJZsKgaXTCoHNob3VsZMKgc3RpbGzCoHdha2V1cMKgdGhlwqBzeXN0ZW3CoGV2ZW7CoGlm
wqBkaXNhYmxlZCzCoHRoZW7CoHRoZQo+wqDCoMKgwqDCoGludGVycnVwdMKgY2hpcMKgc2hvdWxk
wqBoYXZlwqB0aGXCoElSUUNISVBfRU5BQkxFX1dBS0VVUF9PTl9TVVNQRU5ECj7CoMKgwqDCoMKg
ZmxhZ8Kgc2V0LsKgVGhhdCdzwqBub3TCoHRoZcKgY2FzZSzCoHJpZ2h0PwpObyzCoElSUUNISVBf
RU5BQkxFX1dBS0VVUF9PTl9TVVNQRU5EwqBmbGFnwqB3aWxswqBiZcKgc2V0LgoKClNlY29uZCzC
oEkgd2lswqBzaG93wqB5b3XCoGNvbXBsZXRlwqBwcm9jZXNzwqBiecKgdGltZWxpbmU6CgoxLmRl
dmljZcKgaXPCoHN1c3BlbmQswqBpcnHCoGRpc2FibGUswqB3YWtldXDCoGVuYWJsZSzCoGV2ZXJ5
wqBzdGF0ZcKgaXPCoG5vcm1hbMKgbm93OwoKMi5kZXZpY2XCoGlzwqBzdXNwZW5kLMKgaXJxwqBk
aXNhYmxlLMKgd2FrZXVwwqBlbmFibGUswqBpcnHCoHJhaXNlZMKgYW5kwqB0cmlnZ2VywqB3YWtl
dXAswqAKSVJRU19QRU5ESU5HwqBmbGFnwqB3aWxswqBiZcKgc2V0OwoKMy5kZXZpY2XCoGlzwqBh
Y3RpdmUswqBpcnHCoGRpc2FibGUswqB3YWtldXDCoGVuYWJsZSzCoGRldmljZXPCoGVudGVywqBz
dXNwZW5kwqBhZnRlwqBzb21lwqAKdGltZSzCoHRoaXPCoHN0ZXDCoHdpbGzCoGV4ZWN1dGVzwqBj
aGVja19pcnFfcmVzZW5kKCkswqBJUlFTX1JFUExBWcKgZmxhZ8Kgd2lsbMKgYmXCoHNldC7CoApQ
bGVhc2XCoHJlZmVywqB0b8KgdGhlwqBwYXRoc8KgbGlzdGVkwqBhYm92ZS4KQW5kwqBjaGVja19p
cnFfcmVzZW5kKCnCoHdpbGzCoGNhbGzCoGhhbmRsZV9mYXN0ZW9pX2lycSgpLMKgYnV0wqBpcnFf
bWF5X3J1bigpwqByZXR1cm7CoGZhbHNlLApzb8KgSVJRU19SRVBMQVnCoGZsYWfCoG5vdMKgYmXC
oGNsZWFyLgoKNC5kZXZpY2XCoGlzwqBzdXNwZW5kLMKgaXJxwqBkaXNhYmxlLMKgd2FrZXVwwqBl
bmFibGUswqBkZXZpY2XCoHdha2V1cMKgYWdhaW4swqB3ZcKgc2V0wqBpcnHCoAplbmFibGUswqBh
bmTCoGxldMKgZGV2aWNlwqBlbnRlcsKgc3VzcGVuZDsKCjUuZGV2aWNlwqBpc8Kgc3VzcGVuZCzC
oGlyccKgZW5hYmxlLMKgd2FrZXVwwqBlbmFibGUswqBpcnHCoHJhaXNlZMKgYW5kwqB0cmlnZ2Vy
wqB3YWtldXAswqB3aWxswqAKZXhlY3V0ZXPCoGNoZWNrX2lycV9yZXNlbmQoKSzCoGJ1dMKgSVJR
U19SRVBMQVnCoGZsYWfCoGlzwqBzZXQswqBzb8KgaXJxwqB0aHJlYWRfZm4oKcKgd2lsbMKgbm90
wqAKYmXCoGV4ZWN1dGVzLgoKClRoYW5rcyEKenp6

