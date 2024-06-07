Return-Path: <linux-kernel+bounces-205247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0178FF9EF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E171A28661B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 02:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0380112B77;
	Fri,  7 Jun 2024 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="cWqA0PGA"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926CC33C0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717727336; cv=none; b=bVvw4ZUFNkymag0Z5+VzQUOR+9fTsrOpq8rsEDn42VFeviJJZgR7cssnfbsuE/uDgR44mV2bVVM/WhxPhFz+IzboqPBI3qSDqwhexdZZaTI2Jv5x9cMOk5tLTaphd60RU6vMfLubV9s4utTT+Xuo3KDDN2cW67NLHlMQ5XljaLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717727336; c=relaxed/simple;
	bh=NR2BjMyojSNVzVA3wiNKVKPivX6F/0FiMK6KwEP4tQk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uI0TjeYzQhTh8YtYFgHahzLj5ZPAsglujnx30mkBQYyg2cwS7sR5TuYi4u5hJxz+t7xCEiA6+BkmlGUWmE+1xkYOn3sIcfjaVzCFp2KXohUGurJ4085qCE7vf8PLy968d9d8B9Bu3SPvO1e43oQvv3FiJLf6nf/ByYOpqQ4vAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=cWqA0PGA; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 350C320075;
	Fri,  7 Jun 2024 10:28:37 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717727319;
	bh=NR2BjMyojSNVzVA3wiNKVKPivX6F/0FiMK6KwEP4tQk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cWqA0PGAUe9qogFTf92p1oVZmk3M3KWt/YqFP1tdjnrTYq6jOfOdCO/E9lMKnGeEo
	 nDH0uKjE1yDtGg4z7TCjPeODlO0Goy3esRjN1sp0IH/c1Rry1mXBh4fZI9SkLHAB+P
	 cWu5/8Ve1EeiiC9nApqJIKJtqxJCkWgaEzAn5ptIA/yoD2P0/vtKympeAScFDJq8wJ
	 +4OD3qfGntNYUIyFkV6mnAo4QsQ8qzDQ5jTolyAeOUQmi7qtFUSW7F32arbckTMewR
	 sJiN6a6TafVyoW5jWwYPvZuOXS3xXru/KBpq3T78BICSozOmdZwxbe4U2J1yiEKEbM
	 MCMiGnRfreOxQ==
Message-ID: <3c6c319f3aaa60428fd28f4d95c71dc9a8150081.camel@codeconstruct.com.au>
Subject: Re: [PATCH] i3c: dw: Fix IBI intr signal programming
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Aniket <aniketmaurya@google.com>, Alexandre Belloni
	 <alexandre.belloni@bootlin.com>, Joel Stanley <joel@jms.id.au>, Billy Tsai
	 <billy_tsai@aspeedtech.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 07 Jun 2024 10:28:42 +0800
In-Reply-To: <20240606124816.723630-1-aniketmaurya@google.com>
References: <20240606124816.723630-1-aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgQW5pa2V0LAoKPiBJQklfU0lSX1JFUV9SRUpFQ1QgcmVnaXN0ZXIgaXMgbm90IHByZXNlbnQg
aWYgdGhlIElQCj4gaGFzIElDX0hBU19JQklfREFUQSA9IDEgc2V0LgoKSSBkb24ndCBoYXZlIGFu
eSBhY2Nlc3MgdG8gdGhlIElQIGl0c2VsZiwgYnV0IEkgdW5kZXJzdGFuZCB0aGVyZSBhcmUgYQpm
ZXcgZGlmZmVyZW50IGNvbmZpZ3VyYXRpb24gc2V0dGluZ3MgaW4gdGhlIElQIHRoYXQgbWF5IGFm
ZmVjdCB0aGUKcmVnaXN0ZXIgaW50ZXJmYWNlLgoKSSB0aGluayB3ZSdyZSBPSyBpbiB0aGlzIGNh
c2UgKGp1c3Qgbm90IHJlYWRpbmcgdGhlIHZhbHVlIG91dCBvZiB0aGUKU0lSX1JFUV9SRUpFQ1Qg
cmVnaXN0ZXIpLCBidXQgYW55IHRob3VnaHRzIG9uIGFkZGluZyBjb3JyZXNwb25kaW5nCnN3aXRj
aGVzIGluIHRoZSBkcml2ZXIgc28gd2UgY2FuIHN1cHBvcnQgdGhvc2UgY29uZmlndXJhdGlvbnM/
IFRoZXNlCndvdWxkIGJlIHJlcHJlc2VudGVkIGFzIERUIGNvbmZpZyBvZiB0aGUgc3BlY2lmaWMg
aGFyZHdhcmUgaW5zdGFuY2UgLSBhdAp0aGUgbW9zdCBncmFudWxhciwganVzdCBieSB0aGUgc3Bl
Y2lmaWMgY29tcGF0aWJsZSBzdHJpbmcuCgo+IGR3X2kzY19tYXN0ZXJfc2V0X3Npcl9lbmFibGVk
KHN0cnVjdCBkd19pM2NfbWFzdGVyICptYXN0ZXIsCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcmVn
ID0gcmVhZGwobWFzdGVyLT5yZWdzICsgSUJJX1NJUl9SRVFfUkVKRUNUKTsKPiDCoMKgwqDCoMKg
wqDCoMKgaWYgKGVuYWJsZSkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnbG9i
YWwgPSByZWcgPT0gMHhmZmZmZmZmZjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Z2xvYmFsID0gIW1hc3Rlci0+c2lyX2VuX2NudCsrOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmVnICY9IH5CSVQoaWR4KTsKPiDCoMKgwqDCoMKgwqDCoMKgfSBlbHNlIHsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJvb2wgaGpfcmVqZWN0ZWQgPSAhIShyZWFk
bChtYXN0ZXItPnJlZ3MgKyBERVZJQ0VfQ1RSTCkgJiBERVZfQ1RSTF9IT1RfSk9JTl9OQUNLKTsK
PiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnIHw9IEJJVChpZHgpOwo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnbG9iYWwgPSAocmVnID09IDB4ZmZmZmZm
ZmYpICYmIGhqX3JlamVjdGVkOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnbG9i
YWwgPSAoIS0tbWFzdGVyLT5zaXJfZW5fY250KSAmJiBoal9yZWplY3RlZDsKPiDCoMKgwqDCoMKg
wqDCoMKgfQoKQ291bGQgd2UgdXNlIHRoZSBTSVIgbWFzayBmb3IgdGhpcywgYnV0IGp1c3QgcmVh
ZCBpdCBmcm9tIGEgZmllbGQgaW4gdGhlCnN0cnVjdCBkd19pM2NfbWFzdGVyLCBpbnN0ZWFkIG9m
IElCSV9TSVJfUkVRX1JFSkVDVD8KClRoaXMgd291bGQgbWVhbiB0aGF0IHRoZXJlJ3Mgbm8gcG9z
c2liaWxpdHkgb2YgdGhlIGNvdW50ZXIgZ29pbmcgb3V0IG9mCnN5bmMgZnJvbSB0aGUgU0lSIHNl
dHRpbmdzIC0gc2F5LCBvbiB1bmRlcmZsb3cgaWYgd2UgZ2V0IGEgc3B1cmlvdXMKZGlzYWJsZS4K
CkNoZWVycywKCgpKZXJlbXkK


