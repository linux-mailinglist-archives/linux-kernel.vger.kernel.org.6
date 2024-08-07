Return-Path: <linux-kernel+bounces-277910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 570F994A809
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBD31F28668
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2041E673C;
	Wed,  7 Aug 2024 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rlUj9Rvo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SD8JApTd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C844F1C824B;
	Wed,  7 Aug 2024 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034757; cv=none; b=O2nPNAow0SGF3mG+WdGeUpCmzl1DdxoOPU3QzMwKNLLF++AQ2KMytAL+wGTczaz0Lu7XyMnfJMfdbVJpR14uQLibvbTrjAAz4Yuo2szXWs513vopGASjzCVLmh7YSUw0p0QN7zkSAtJA83mMVzGP9x3Hs6Yo56YpzOtx/jDBcJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034757; c=relaxed/simple;
	bh=K2pE7XVDCV05hANZTsq6bdehkgcW6vUq7VIAzyBkfyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KJr5NTxKp0hOY6LvJvAR/6YRpBdlmiv1iRVqMbWn/N/5vRsGqXfONdbhe/tdh5zHxF/WC9KDAR/PYmxztOMz8/dc537Asu23WvQYUVweLKEXPi9sYD9O2FkyktZ9FC0JioHSZPLoyuisss8ZNa5q9XayKtEOV9WLJ2T6SW4Dqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rlUj9Rvo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SD8JApTd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723034753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2pE7XVDCV05hANZTsq6bdehkgcW6vUq7VIAzyBkfyc=;
	b=rlUj9Rvo6RtJwB53IMU6b9rR6Po0XXtDwrvyvrnpOReHmjsrx48Tbvqnbuezdc/sjwBa10
	HgFp8kwPvHYhsNEKdlrL5MZiwpRFJbeLCkz/+HOoG57SsuLkt9SQ4inLAGvpwHFXghmx3u
	36aulfnxiC+KTxn384zE4L8mlZsXqRMfWIroGZAlZuDfDIm1NrkK6REAtqPAcc6x3QHKg0
	Z5cTXEbvuASRN/94I0gRUKTkynLJQBpbpTjBA/rjBym3MywCHzdo9SCjXMJcbHnVThG1NN
	jMeYcm8hTUuc5AuBOWdcZKdkgUfEtAeZf6yd6hnRAlSZrCahsi830e2FdWDz2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723034753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2pE7XVDCV05hANZTsq6bdehkgcW6vUq7VIAzyBkfyc=;
	b=SD8JApTdTudxK9Gag8bnKB3gh2vZiV4+Jll0esZhKRO/lWSvHSsggJnvA6YMQhMXHvVwi8
	S7svFMX0IJGxj7Dg==
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Vlastimil Babka
 <vbabka@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Guenter
 Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Helge
 Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
In-Reply-To: <c54ab27ff0f0bb3e9e681eec9a62549e5e245a6b.camel@HansenPartnership.com>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
 <c54ab27ff0f0bb3e9e681eec9a62549e5e245a6b.camel@HansenPartnership.com>
Date: Wed, 07 Aug 2024 14:45:53 +0200
Message-ID: <87cymk4i2m.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gVHVlLCBBdWcgMDYgMjAyNCBhdCAyMDo0OSwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOg0KPiBP
biBXZWQsIDIwMjQtMDgtMDcgYXQgMDE6MjQgKzAyMDAsIFRob21hcyBHbGVpeG5lciB3cm90ZToN
Cj4+IMKgc3RhdGljIGludCBjaGVja19zbGFiKHN0cnVjdCBrbWVtX2NhY2hlICpzLCBzdHJ1Y3Qg
c2xhYiAqc2xhYikNCj4+IMKgew0KPj4gwqDCoMKgwqDCoMKgwqDCoGludCBtYXhvYmo7DQo+PiBA
QCAtMTM4Niw4ICsxMzg4LDEwIEBAIHN0YXRpYyBpbnQgY2hlY2tfc2xhYihzdHJ1Y3Qga21lbV9j
YWNoZQ0KPj4gwqANCj4+IMKgwqDCoMKgwqDCoMKgwqBtYXhvYmogPSBvcmRlcl9vYmplY3RzKHNs
YWJfb3JkZXIoc2xhYiksIHMtPnNpemUpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoGlmIChzbGFiLT5v
YmplY3RzID4gbWF4b2JqKSB7DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2xh
Yl9lcnIocywgc2xhYiwgIm9iamVjdHMgJXUgPiBtYXggJXUiLA0KPj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzbGFiLT5vYmplY3RzLCBtYXhvYmopOw0K
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRlc3RtZSgpOw0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNsYWJfZXJyKHMsIHNsYWIsICJvYmplY3RzICV1ID4gbWF4
ICV1IHNpemUgJXUgc29yZGVyDQo+PiAldSAldSIsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbGFiLT5vYmplY3RzLCBtYXhvYmosIHMtPnNpemUs
DQo+PiBzbGFiX29yZGVyKHNsYWIpLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgb3JkZXJfb2JqZWN0cyhzbGFiX29yZGVyKHNsYWIpLCBzLT5zaXpl
KSk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOw0KPj4gwqDC
oMKgwqDCoMKgwqDCoH0NCj4+IMKgwqDCoMKgwqDCoMKgwqBpZiAoc2xhYi0+aW51c2UgPiBzbGFi
LT5vYmplY3RzKSB7DQo+PiANCj4+IEkgZG9uJ3Qga25vdyBhbmQgSSBkb24ndCB3YW50IHRvIGtu
b3cgVEJILi4uDQo+DQo+IE9LLCBzbyB5b3UncmUgdGVsbGluZyB1cyB3ZSBoYXZlIGEgcHJvYmxl
bSB3aXRoIHNsYWJfb3JkZXIgb24gcGFyaXNjDQo+IC4uLiB0aGF0J3MgZm9saW9fb3JkZXIsIHNv
IGl0IHNtZWxscyBsaWtlIGEgcGFyaXNjIGJ1ZyB3aXRoDQo+IGZvbGlvX3Rlc3RfbGFyZ2U/ICBV
bmZvcnR1bnRlbHkgSSdtIGEgYml0IHBpc3NlZCBpbiBhbiBhaXJwb3J0IGxvdW5nZQ0KPiBvbiBt
eSB3YXkgdG8gdGhlIFVLLCBzbyBJJ3ZlIGxvc3QgYWNjZXNzIHRvIG15IHBhIHRlc3QgcmlnIGFu
ZCBjYW4ndA0KPiB0ZXN0IGZ1cnRoZXIgZm9yIGEgd2hpbGUuDQoNClRoZSBwb2ludCBpcyB0aGF0
IHRoZXJlIGFyZSB0d28gaW52b2NhdGlvbnMgZm9yIG9yZGVyX29iamVjdHMoLi4uKSBpbg0KdGhh
dCBjb2RlLg0KDQoJbWF4b2JqID0gb3JkZXJfb2JqZWN0cyhzbGFiX29yZGVyKHNsYWIpLCBzLT5z
aXplKTsNCg0KYW5kIHRoZSBleHRyYSBvbmUgaW4gdGhlIHNsYWJfZXJyKCkgb3V0cHV0Og0KDQog
ICAgICAgIHNsYWJfZXJyKHMsIHNsYWIsICJvYmplY3RzICV1ID4gbWF4ICV1IHNpemUgJXUgc29y
ZGVyICV1ICV1IiwNCgkJIHNsYWItPm9iamVjdHMsIG1heG9iaiwgcy0+c2l6ZSxzbGFiX29yZGVy
KHNsYWIpLA0KICAgICAgICAgICAgICAgICBvcmRlcl9vYmplY3RzKHNsYWJfb3JkZXIoc2xhYiks
IHMtPnNpemUpKTsNCg0KPj4gW8KgwqDCoCAwLjAwMDAwMF0gQlVHIGttZW1fY2FjaGVfbm9kZSAo
Tm90IHRhaW50ZWQpOiBvYmplY3RzIDIxID4gbWF4IDE2DQo+PiBzaXplIDE5MiBzb3JkZXIgMCAy
MQ0KDQpTbyBtYXhvYmogPSAxNiBhbmQgdGhlIHNlY29uZCBpbnZvY2F0aW9uIGNvcnJlY3RseSBy
ZXR1cm5zIDIxLCBpZiBhbmQNCm9ubHkgaWYgdGhlICQkZGl2b0kgcGxhY2VtZW50IGlzIGluIHRo
YXQgd2VpcmQgcmFuZ2UuDQoNCldoZW4gSSBtb3ZlIGl0IG91dCBvZiB0aGF0IHJhbmdlIHRoZW4g
Ym90aCByZXR1cm4gMjEgYXMgZXhwZWN0ZWQuDQoNClRoYW5rcywNCg0KICAgICAgICB0Z2x4DQo=

