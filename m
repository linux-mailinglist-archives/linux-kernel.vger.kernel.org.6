Return-Path: <linux-kernel+bounces-518503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F262FA39013
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 01:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA82169BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383AB1D52B;
	Tue, 18 Feb 2025 00:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="PKHF027/"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44772E56F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739840229; cv=none; b=iPQOhhjCapqBiHvdQ4NeKUrIdK7WeETr9ClycoKEyewYU4dBisUuGPey4iV0h6TaY2ujUOT7TcQhkfNffKKtv/yT7FfZAq6HchNfgGCvdBZqNXuw462sA/Y4KXsH3eHzL1sIRLUqmBobbAkHHH+2c8KzJ/HmezkiNtzzSuSyouw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739840229; c=relaxed/simple;
	bh=EkQ8ik4KdAGTrmDROq1yWEvtaKgYAVb1rRwmJhpHbIY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QO7PP/cib9u+N3TJ7PUeMQFQZuDDUp6gnPhaNXQcKk4PZEu6vt2N+YY3NgLfq2JW87jL/gCV1NQ4yJ2+sCkUKQdu1wdYGqx+gIg0YrO11S7PlyHQjH1G2MX4ZE7wdqp2g1cXt6t4ivT2Y7PS777QIrq4A1H/T1/GS1MbuHnrhBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=PKHF027/; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739840217;
	bh=EkQ8ik4KdAGTrmDROq1yWEvtaKgYAVb1rRwmJhpHbIY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PKHF027/YqWI0hLDSpaf6m8oWe3aOeZOErMZjZyNQK/1VLMrsayuAOE9MEeeRmyeG
	 Zya4NJgfYPP7QoVHwEi25s3nATtH1x/QivmUGOdTzFfc/dSXlcdIedaSHkwfN/M0Q7
	 ISJ5sz/LA6WAvmEl3mFtlMXoCysBYbssI53AalZv5prualDQ3f4ENR+SdxHGpImIOZ
	 EoDpYyDX5UGmIG0L+Csp/Qu1AMif4DGQRpwp4a3vULIfLxUCnspSpP98Jurxmyr7Oj
	 y1F503EdhB5E1H/gwdiSnrVDzPjMTSxt5aDs+SX0qyp70hqIwAdNcyJ4uejTQ646mL
	 itPZMdMybTs+g==
Received: from [192.168.68.112] (ppp118-210-165-49.adl-adc-lon-bras34.tpg.internode.on.net [118.210.165.49])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5BB64759DD;
	Tue, 18 Feb 2025 08:56:54 +0800 (AWST)
Message-ID: <6fd7cd57261ddf9831f57dc4c637b24e9f8982d9.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzk@kernel.org>, Kevin Chen
 <kevin_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org,  conor+dt@kernel.org, joel@jms.id.au,
 chiawei_wang@aspeedtech.com,  linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Cc: "tomer.maimon" <tomer.maimon@nuvoton.com>
Date: Tue, 18 Feb 2025 11:26:53 +1030
In-Reply-To: <e43b5f8f-37e4-4468-b3ca-5059a5e6f3c3@kernel.org>
References: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
	 <20250217114831.3225970-4-kevin_chen@aspeedtech.com>
	 <e43b5f8f-37e4-4468-b3ca-5059a5e6f3c3@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI1LTAyLTE3IGF0IDEzOjAwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOgo+IE9uIDE3LzAyLzIwMjUgMTI6NDgsIEtldmluIENoZW4gd3JvdGU6Cj4gPiArCj4gPiAr
wqDCoMKgwqDCoMKgwqBwY2MtPm1kZXYucGFyZW50ID0gZGV2Owo+ID4gK8KgwqDCoMKgwqDCoMKg
cGNjLT5tZGV2Lm1pbm9yID0gTUlTQ19EWU5BTUlDX01JTk9SOwo+ID4gK8KgwqDCoMKgwqDCoMKg
cGNjLT5tZGV2Lm5hbWUgPSBkZXZtX2thc3ByaW50ZihkZXYsIEdGUF9LRVJORUwsICIlcyVkIiwK
PiA+IERFVklDRV9OQU1FLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBjYy0+bWRldl9pZCk7
Cj4gPiArwqDCoMKgwqDCoMKgwqBwY2MtPm1kZXYuZm9wcyA9ICZwY2NfZm9wczsKPiA+ICvCoMKg
wqDCoMKgwqDCoHJjID0gbWlzY19yZWdpc3RlcigmcGNjLT5tZGV2KTsKPiA+ICvCoMKgwqDCoMKg
wqDCoGlmIChyYykgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIo
ZGV2LCAiQ291bGRuJ3QgcmVnaXN0ZXIgbWlzYyBkZXZpY2VcbiIpOwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZXJyX2ZyZWVfa2ZpZm87Cj4gPiArwqDCoMKgwqDCoMKg
wqB9Cj4gCj4gWW91IGNhbm5vdCBleHBvc2UgdXNlci1zcGFjZSBpbnRlcmZhY2VzIGZyb20gU29D
IGRyaXZlcnMuIFVzZQo+IGFwcHJvcHJpYXRlIHN1YnN5c3RlbSBmb3IgdGhpcyB3aXRoIHByb3Bl
ciBBQkkgZG9jdW1lbnRhdGlvbi4KPiAKPiBTZWU6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsL2JjNTExOGYyLTg5ODItNDZmZi1iYzc1LWQwYzcxNDc1ZTkwOUBhcHAuZmFzdG1haWwuY29t
Lwo+IGFuZCBtb3JlIGRpc2N1c3Npb25zIG9uIExLTUwKCkZ1cnRoZXIsIGRyaXZlcnMvbWlzYy9h
c3BlZWQtbHBjLXNub29wLmMgYWxyZWFkeSBleGlzdHM6CgpodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD05
ZjRmOWFlODFkMGFmZmMxODJmNTRkZDAwMjg1ZGRiOTBlMGIzYWUxCgpLZXZpbjogRGlkIHlvdSBj
b25zaWRlciByZXdvcmtpbmcgaXQ/CgpOdXZvdG9uIGhhdmUgYSBzaW1pbGFyIGNhcGFiaWxpdHkg
aW4gdGhlaXIgTlBDTSBCTUMgU29DKHMpIHdpdGggdGhlCiJCUEMiICgiQklPUyBQT1NUIENvZGUi
IGNvbnRyb2xsZXIpLiBUaGVyZSBzaG91bGQgYmUgc29tZSBjb25zZW5zdXMgb24KdGhlIGJpbmRp
bmcgYW5kIHVzZXJzcGFjZSBpbnRlcmZhY2UuCgpBbmRyZXcK


