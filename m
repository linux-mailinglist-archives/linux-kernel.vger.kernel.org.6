Return-Path: <linux-kernel+bounces-565227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E60A6640C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B38817D689
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9117013EFE3;
	Tue, 18 Mar 2025 00:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="VCrCjVVy"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486EDD528;
	Tue, 18 Mar 2025 00:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258535; cv=none; b=LJ8elBb8IiFW+PlJmWFcHyXMfxDVF7NvikRF3LC1HXvNeDZnicXuUlKedVWrCwBUwYV4yu0ay8tcTv4nd+A1M7c2RSlEsD20w8DXM6iShhN8fGKJGsbAhJRH9JSqWDj2PH7jc2iYdpAWmD0vjP0ZsYjpgIsNCdR7DyuSmzKI7A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258535; c=relaxed/simple;
	bh=lR8t+yS8heBlVgKW1sJz63d4wBD18a6lsgVnNjdDSVQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ScBNoBrVipo4Zmzk/JIP57CD11u+JzuJVO+JL4NzX7I+nhI2plMUEDuWQyJ311TbxO5tJSWG+3Ts1zHKMRfhDbLnoE7J7QlX5TTKAb4jEuprj4WENJ8HTJHCLhBrUFQuCk+QyJNFbT9xy9BL8HE9aXZziLTZ8M0z6OsGuTF7vk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=VCrCjVVy; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742258531;
	bh=lR8t+yS8heBlVgKW1sJz63d4wBD18a6lsgVnNjdDSVQ=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=VCrCjVVyQloxxKR8/vCcZEWhl5wH0TbTJ4YXNsdM1m459vlb+65LMjGKP9CX0nAE3
	 tJVaa65qgKEVGMBQaMuBNgaUr2xf4SwItxGtuNyXBJkewIzvA5uR7erUJtb8sgEzpk
	 bCLcwZCAnwgGIpGHa4WgGbF36CygZqJb3KrWPqYAUxhJI6gYa8dJD3qzxuItCr8tr5
	 swVtXVVcdY1W60feoPSNlo2DZwjj/AzN5xf9RO7oa1o855/zcvlLazk2hUIpYMSI2D
	 7eyN38fQyZ0ny1Tox+1N2Tv3H9aRHFKruU9MNJ0ShUS8gKOyIwRx8usmnzVYMmyZ1E
	 1kpKwxR4WSWrw==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5A04377BB4;
	Tue, 18 Mar 2025 08:42:10 +0800 (AWST)
Message-ID: <3270a7ea55fa28253b435da0b0bbce3adfdc00eb.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Chen <kevin_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
  krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 derek.kiernan@amd.com,  dragan.cvetic@amd.com, arnd@arndb.de,
 gregkh@linuxfoundation.org,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Tue, 18 Mar 2025 11:12:09 +1030
In-Reply-To: <20250314112113.953238-4-kevin_chen@aspeedtech.com>
References: <20250314112113.953238-1-kevin_chen@aspeedtech.com>
	 <20250314112113.953238-4-kevin_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI1LTAzLTE0IGF0IDE5OjIxICswODAwLCBLZXZpbiBDaGVuIHdyb3RlOgo+ICvC
oMKgwqDCoMKgwqDCoHBjYy0+bWRldi5wYXJlbnQgPSBkZXY7Cj4gK8KgwqDCoMKgwqDCoMKgcGNj
LT5tZGV2Lm1pbm9yID0gTUlTQ19EWU5BTUlDX01JTk9SOwo+ICvCoMKgwqDCoMKgwqDCoHBjYy0+
bWRldi5uYW1lID0gZGV2bV9rYXNwcmludGYoZGV2LCBHRlBfS0VSTkVMLCAiJXMlZCIsCj4gREVW
SUNFX05BTUUsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBjYy0+bWRldl9pZCk7Cj4gK8KgwqDC
oMKgwqDCoMKgcGNjLT5tZGV2LmZvcHMgPSAmcGNjX2ZvcHM7Cj4gK8KgwqDCoMKgwqDCoMKgcmMg
PSBtaXNjX3JlZ2lzdGVyKCZwY2MtPm1kZXYpOwo+ICvCoMKgwqDCoMKgwqDCoGlmIChyYykgewo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKGRldiwgIkNvdWxkbid0IHJl
Z2lzdGVyIG1pc2MgZGV2aWNlXG4iKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Z290byBlcnJfZnJlZV9pZGE7Cj4gK8KgwqDCoMKgwqDCoMKgfQoKSnVzdCBhIG5vdGUgdGhhdCB0
aGlzIHN0aWxsIGlzbid0IGFjY291bnRpbmcgZm9yIGRpc2N1c3Npb24gb24gdGhlCnByZXZpb3Vz
IHBvc3Rpbmcgb2YgdGhlIHNlcmllcyBwdXR0aW5nIHRoZSBkcml2ZXIgdW5kZXIKZHJpdmVycy9z
b2MvYXNwZWVkOgoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2Y3MzY5ZDYyMDVlMDVjN2Fh
YzNmM2RlN2NiZDA4YzNiMDg5NjBkNzUuY2FtZWxAY29kZWNvbnN0cnVjdC5jb20uYXUvCgpJZiB3
ZSdyZSBub3QgZ29pbmcgdG8gdHJ5IG1ha2UgYSBjb21tb24gdXNlcnNwYWNlIGJlaGF2aW91ciBv
dmVyIHRoZQpBc3BlZWQgc25vb3AgYW5kIFBDQyBmdW5jdGlvbnMgYW5kIHRoZSBOdXZvdG9uIEJQ
QyBmdW5jdGlvbiB0aGVuIEkKdGhpbmsgdGhlIGJlaGF2aW91ciBvZiB0aGUgY2hhcmRldiBzaG91
bGQgYXQgbGVhc3QgYmUgZG9jdW1lbnRlZC4gQnV0IEkKd291bGQgcmF0aGVyIHRoYXQgaXQgd2Vy
ZSBjb21tb24gdG8gYXZvaWQgaGVhZGFjaGVzIGluIHVzZXJzcGFjZS4KCkFuZHJldwo=


