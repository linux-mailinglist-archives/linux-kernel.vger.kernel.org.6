Return-Path: <linux-kernel+bounces-527308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF324A40978
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BD9189EB69
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A78171E43;
	Sat, 22 Feb 2025 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="4ce8sOQR"
Received: from smtp4.epfl.ch (smtp4.epfl.ch [128.178.224.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5078F46
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.178.224.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740237641; cv=none; b=tKBEktbk4bDj2CYVfwaBdj8dvuEgPJByqF2UbvUNBQ59L2Q3Mn1Gee96KDOkyqb5qmeHqJXHPOUIw8aN2BdVvEzX7Q6cuItxxQYpuge4YNVMzceFzQLx2Zw+fuCeaGSavQnPgp3uaSqIld7vcwdskC0AcqliuS+PT7m1XAkdJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740237641; c=relaxed/simple;
	bh=x/ouvYV8KYqaGJxp+7c4Mh8n3Po2I8YHaK+uUNGOK+E=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TWyY9Tc/hg56EG0YSyc6zszGRYOGdQGahY1t5iwRVGEnN9utrJmDpYJUHnIKTqTqDBPw44gwpfxRUehdlx8xjnfJDv2F/HU/oiReWE1E4fYgp9wOsZdZn8fbI6UR37xAkALWYthEKvtnvEEJUAedeszK1tY90fiTSxwFvfMUcQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch; spf=pass smtp.mailfrom=epfl.ch; dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b=4ce8sOQR; arc=none smtp.client-ip=128.178.224.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1740237233;
      h=From:To:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
      bh=x/ouvYV8KYqaGJxp+7c4Mh8n3Po2I8YHaK+uUNGOK+E=;
      b=4ce8sOQR30sdStd8tRqOZ5Kkuzz80rUpl6b4qfC6fwz2Uf45YqwcpVbRfZ1ZAAlFD
        w85dQQsV2JCdOxMQoGK4AQObZaFqrVgsmcuJgNRG1XDxySbYFzFXFfKH6W32kuyi/
        hyIFdJqBrlSzcKQVdiDDewPbc50FFH6aTw1tLINIY=
Received: (qmail 42719 invoked by uid 107); 22 Feb 2025 15:13:53 -0000
Received: from ax-snat-224-179.epfl.ch (HELO ewa08.intranet.epfl.ch) (192.168.224.179) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Sat, 22 Feb 2025 16:13:53 +0100
X-EPFL-Auth: tdG1Zg5FwtoI54Tsf+zKa8Sfb1BJlQvhQpxuR2PuVE3kxQABK3Y=
Received: from ewa07.intranet.epfl.ch (128.178.224.178) by
 ewa08.intranet.epfl.ch (128.178.224.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 22 Feb 2025 16:13:50 +0100
Received: from ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a]) by
 ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a%9]) with mapi id
 15.01.2507.044; Sat, 22 Feb 2025 16:13:50 +0100
From: Georgiy Konstantinovich Lebedev <georgiy.lebedev@epfl.ch>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>
Subject: Does NUMA_BALANCING_MEMORY_TIERING work with hugetlb pages?
Thread-Topic: Does NUMA_BALANCING_MEMORY_TIERING work with hugetlb pages?
Thread-Index: AQHbhTxgg1UfPTuewk6Y9fNDedGGsQ==
Date: Sat, 22 Feb 2025 15:13:50 +0000
Message-ID: <907A5EDC-F9D7-4D27-BAC3-5EAAE151AA7B@epfl.ch>
Accept-Language: en-US, fr-CH
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7ECCE45FF3A0547A2E2D11292031D60@intranet.epfl.ch>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8sDQoNCkkgYW0gaGF2aW5nIHRyb3VibGUgZmlndXJpbmcgb3V0IHdoZXRoZXIgdGhlIE5V
TUFfQkFMQU5DSU5HX01FTU9SWV9USUVSSU5HDQpmZWF0dXJlIG9mIC9wcm9jL3N5cy9rZXJuZWwv
bnVtYV9iYWxhbmNpbmcgd29ya3Mgd2l0aCBodWdldGxiIHBhZ2VzLg0KDQpJIGNvdWxkIG5vdCBm
aW5kIGFueSBpbmZvcm1hdGlvbiBhYm91dCBodWdldGxiIHBhZ2VzIGluIHRoZSBkb2N1bWVudGF0
aW9uDQpyZWxhdGVkIHRvIHRoaXMgZmVhdHVyZS4NCg0KSSBoYXZlIHRyaWVkIHNlYXJjaGluZyB0
aHJvdWdoIHRoZSBrZXJuZWwgY29kZWJhc2UsIGhvd2V2ZXIgSSBoYXZlIG9ubHkNCmZvdW5kIHRo
YXQgaHVnZXRsYiBwYWdlcyBhcmUgZmlsdGVyZWQgb3V0IGluIHRoZSBgc2hvdWxkX3NraXBfdm1h
YCBmdW5jdGlvbiBpbg0KYG1tL3Ztc2Nhbi5jYCDigJQgdHJhY2luZyBpdHMgdXNhZ2UsIEkgY291
bGQgbm90IHVuZGVyc3RhbmQgd2hldGhlciBpdCBpcyB1c2VkIGluDQptZW1vcnkgdGllcmluZy4N
Cg0KSSBoYXZlIHRyaWVkIHJ1bm5pbmcgbWVtb3J5IHRpZXJpbmcgc3RyZXNzIHRlc3QgYXMgZm9s
bG93cywgYnV0IEkgYW0gbm90DQpzZWVpbmcgYW55IHByb21vdGlvbiBvciBkZW1vdGlvbnMgaW4g
L3Byb2Mvdm1zdGF0Og0KYGBgDQp2b2lkIHRyaWdnZXJfdHBwKHZvaWQgKmFkZHIsIHNpemVfdCBu
X3BhZ2VzKSB7DQoJc2l6ZV90IG9mZnNldCA9IG5fcGFnZXMgLSBuX3BhZ2VzICogMSAvIDEwOw0K
CWZvciAoc2l6ZV90IGsgPSAwOyBrIDwgMTAwMDAwMDAwOyArK2spIHsNCgkJZm9yIChzaXplX3Qg
aSA9IG9mZnNldDsgaSA8IG5fcGFnZXM7ICsraSkgew0KCQkJY2hhciAqcGFnZSA9IChjaGFyICop
YWRkciArIChpICogSFVHRV9QQUdFX1NJWkUpOw0KCQl9DQoJfQ0KfQ0KYGBgDQoNClRoZSBzZXR1
cCBmb3IgdGhlIHN0cmVzcyB0ZXN0IGlzIGFzIGZvbGxvd3M6DQoxLiBJIGFsbG9jYXRlIGh1Z2V0
bGIgcGFnZXMgdG8gdXNlIGFsbW9zdCBhbGwgdGhlIGF2YWlsYWJsZSBEUkFNIG1lbW9yeSwNCmAv
c3lzL2RldmljZXMvc3lzdGVtL25vZGUvbm9kZTEvaHVnZXBhZ2VzL2h1Z2VwYWdlcy0yMDQ4a0Iv
bnJfaHVnZXBhZ2VzYA0KcmVwb3J0cyAxMjQ5MjggKDI0NCBHQikgb3V0IG9mIDI1MSBHQiBhdmls
YWJsZSANCjIuIEkgYWxsb2NhdGUgaHVnZXRsYiBwYWdlcyBmb3IgdGhlIHdvcmtsYW9kIG9uIHRo
ZSBDWEwgYXR0YWNoZWQgbWVtb3J5LCANCmAvc3lzL2RldmljZXMvc3lzdGVtL25vZGUvbm9kZTMv
aHVnZXBhZ2VzL2h1Z2VwYWdlcy0yMDQ4a0IvbnJfaHVnZXBhZ2VzYCANCnJlcG9ydHMgMTAyNDAg
KDEwIEdCKQ0KMy4gbnVtYWN0bCAtSCByZXBvcnRzIDE2MTEgTUIgZnJlZSBtZW1vcnkgb24gbm9k
ZSAxDQo0LiBJICJlYXQiIDI0MiBHQiBvZiBodWdlIHBhZ2VzIGJ5IHJ1bm5pbmcgYSBiYWNrZ3Jv
dW5kIGFwcGxpY2F0aW9uIHRoYXQgbW1hcHMNCmFuZCBmYXVsdHMgbWVtb3J5LA0KYC9zeXMvZGV2
aWNlcy9zeXN0ZW0vbm9kZS9ub2RlMS9odWdlcGFnZXMvaHVnZXBhZ2VzLTIwNDhrQi9mcmVlX2h1
Z2VwYWdlc2AgDQpyZXBvcnRzIDEwMjEgKDIgR0IpDQo0LiBJIHJ1biB0aGUgbWVtb3J5IHRpZXJp
bmcgc3RyZXNzIHRlc3Qgd2l0aCAyMEdCIG9mIGh1Z2UgcGFnZXMgKG1tYXBlZCBhbmQgDQpmYXVs
dGVkKSwgbnVtYXN0YXQgcmVwb3J0cyAyMDQyIE1CIG9mIGh1Z2UgcGFnZXMgb24gbm9kZSAxLCAx
ODQzOCBNQiBvZiBodWdlIA0KcGFnZXMgb24gbm9kZSAzLg0KDQpUaGFuayB5b3UgaW4gYWR2YW5j
ZSBmb3IgeW91ciB0aW1lIQ0KDQpSZWdhcmRzLA0KR2VvcmdpeSBMZWJlZGV2DQo=

