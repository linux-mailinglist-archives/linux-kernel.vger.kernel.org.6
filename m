Return-Path: <linux-kernel+bounces-411716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F86C9CFEBB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9243B24203
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 12:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FA412C470;
	Sat, 16 Nov 2024 12:13:22 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5D161
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731759202; cv=none; b=KS+6tQd+BEDrJ7hfvAFC/neVjmpAtBOavAFJcObxPJohTRNesjoKc4ZSnnZOGrmCFvK5g9PU0TRDVSG7zGXyqjWZHGBKrDl4ym3d3GHYu/OTI89frDaLQ1KlvwSbzMQkBJq2O/14frQVR23dKhy/tEDzZqECqB3UXH+zxzwD65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731759202; c=relaxed/simple;
	bh=JYMEaRjrLJZJp/WVYKY998cN7Lo7+syvrmumd73EB7M=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=u8dT/YwnNiYTLrrx5X8N5mzxDGbpWLNjBLmkkt3erdhvMlhgxzSNAS6otCRFHShqBHfjUngI2uck+yh4XbZwpqFUqKqDmFlBzt7Zw7fq6rpItsKuRnDLiqacM+xNfoaL6i72Vj/sYyBBVU9AEKUJMlxPTSoQdTKFF98kC6RS1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.2.4] (unknown [60.17.9.120])
	by APP-03 (Coremail) with SMTP id rQCowADX34v2ijhnmFgAAw--.11080S2;
	Sat, 16 Nov 2024 20:07:18 +0800 (CST)
Message-ID: <a9058ac757636e4f5160a0bd11abeb3c111fc9a5.camel@iscas.ac.cn>
Subject: [resend PATCH] riscv: fix memory leakage in
 process_accumulated_relocations
From: laokz <zhangkai@iscas.ac.cn>
To: Walmsley <paul.walmsley@sifive.com>, Dabbelt <palmer@dabbelt.com>, Ou
	 <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Date: Sat, 16 Nov 2024 20:07:18 +0800
X-Priority: 1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:rQCowADX34v2ijhnmFgAAw--.11080S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWxtw15Kr1fCw1rGFWUCFg_yoW8CFy5pr
	1rGr1UGrW8Jr1kJF4Utw1kWryUGr1DCa17WF45JF1xJr13Jr1jvw1UXr1Fgrs8Jr48Jry7
	Jr1UJr1jvryDJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmSb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFcxC0VAYjxAxZF0Ew4CEw7xC
	0wACY4xI67k04243AVC20s07MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW5JwCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UMs0E7xkvzxkvxsIE5cxS5wCE64xvF2IEb7IF0Fy7YxBI
	daVFxhVjvjDU0xZFpf9x07jfHUDUUUUU=
X-CM-SenderInfo: x2kd0wxndlqxpvfd2hldfou0/

U29ycnkgZm9yIGxhc3Qgd2VpcmQgZW1haWwuCi0tLQoKV2hlbiBtb2R1bGUgcmVsb2NhdGlvbiBp
cyBkb25lLCBwcm9jZXNzX2FjY3VtdWxhdGVkX3JlbG9jYXRpb25zKCkKZnJlZXMgYWxsIGR5bmFt
aWMgYWxsb2NhdGVkIG1lbW9yeS4gcmVsX2hlYWRfaXRlci0+cmVsX2VudHJ5IGlzCm1pc3NlZCB0
byBmcmVlIHRoYXQga21lbWxlYWsgbWlnaHQgcmVwb3J0OgoKdW5yZWZlcmVuY2VkIG9iamVjdCAw
eGZmZmZmZmQ4ODBjNWZjNDAgKHNpemUgMTYpOgrCoCBjb21tICJpbnNtb2QiLCBwaWQgMTEwMSwg
amlmZmllcyA0Mjk1MDQ1MTM4CsKgIGhleCBkdW1wIChmaXJzdCAxNiBieXRlcyk6CsKgwqDCoCBl
MCBjMCBmNSA4NyBkOCBmZiBmZiBmZiA2MCBjNSBmNSA4NyBkOCBmZiBmZiBmZsKgIC4uLi4uLi4u
YC4uLi4uLi4KwqAgYmFja3RyYWNlIChjcmMgZDJlY2IyMGMpOgrCoMKgwqAgWzwwMDAwMDAwMGIw
MTY1NWY2Pl0ga21hbGxvY190cmFjZV9ub3Byb2YrMHgyNjgvMHgyZjYKwqDCoMKgIFs8MDAwMDAw
MDA2ZGMwMDY3YT5dCmFkZF9yZWxvY2F0aW9uX3RvX2FjY3VtdWxhdGUuY29uc3Rwcm9wLjArMHhm
Mi8weDFhYQrCoMKgwqAgWzwwMDAwMDAwMGUxYjI5YTM2Pl0gYXBwbHlfcmVsb2NhdGVfYWRkKzB4
MTNjLzB4MzZlCsKgwqDCoCBbPDAwMDAwMDAwNzU0M2YxZmI+XSBsb2FkX21vZHVsZSsweDVjNi8w
eDgzZQrCoMKgwqAgWzwwMDAwMDAwMGFiY2UxMmU4Pl0gaW5pdF9tb2R1bGVfZnJvbV9maWxlKzB4
NzQvMHhhYQrCoMKgwqAgWzwwMDAwMDAwMDQ5NDEzZTNkPl0gaWRlbXBvdGVudF9pbml0X21vZHVs
ZSsweDExNi8weDIyZQrCoMKgwqAgWzwwMDAwMDAwMGY5Yjk4Yjg1Pl0gX19yaXNjdl9zeXNfZmlu
aXRfbW9kdWxlKzB4NjIvMHhhZQoKU2lnbmVkLW9mZi1ieTogS2FpIFpoYW5nIDx6aGFuZ2thaUBp
c2Nhcy5hYy5jbj4KLS0tCsKgYXJjaC9yaXNjdi9rZXJuZWwvbW9kdWxlLmMgfCAxICsKwqAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tlcm5l
bC9tb2R1bGUuYyBiL2FyY2gvcmlzY3Yva2VybmVsL21vZHVsZS5jCmluZGV4IDFjZDQ2MWYzZDg3
Li5mOGMzYzRiNDdkYyAxMDA2NDQKLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvbW9kdWxlLmMKKysr
IGIvYXJjaC9yaXNjdi9rZXJuZWwvbW9kdWxlLmMKQEAgLTY0Myw2ICs2NDMsNyBAQCBwcm9jZXNz
X2FjY3VtdWxhdGVkX3JlbG9jYXRpb25zKHN0cnVjdCBtb2R1bGUgKm1lLArCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWxvY19oYW5kbGVyc1tjdXJyX3R5cGVdLmFjY3Vt
dWxhdGVfaGFuZGxlcigKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbWUsIGxvY2F0aW9uLCBidWZmZXIpOworwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2ZyZWUocmVsX2hlYWRfaXRlci0+cmVs
X2VudHJ5KTsKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBr
ZnJlZShyZWxfaGVhZF9pdGVyKTsKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGtmcmVlKGJ1Y2tldF9pdGVyKTsKCgo=


