Return-Path: <linux-kernel+bounces-199749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1AA8FA511
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56152816F3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A517113C8E8;
	Mon,  3 Jun 2024 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ljPx/kLW"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7154E12E1FF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451956; cv=none; b=Zio/w2mk7Dqwlh/hVOvDUAKa5sZaCw03tfRf4WtzW+O2L0HMZ035/ElHuugXb3pOttRSpMgZ8oxW2zQlNIIleekiD48Ln5T8a2oo9FJAMbfrxdeKnA+RR6R2+B1YOdSt6un4yS+qV1JX14QeqSqrmMnsYVaKFXYZD3dul9m9fyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451956; c=relaxed/simple;
	bh=UYlBpvItHr2LFXKagCraKaTRi0BSSSgoGfrKvAR4lB0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ETl380ZJzdCKe7/KN78COZdqIWrd1G9aPrkL+EDCwlkRStJFOacaCu4kXled0/CpVZHFAFLjwmZ6O+f+SZZx4F413JoxhFDP1UjJJm7aFiRZ3VaT7g/T5l6ibmueTG3Av8eQNxwIfJE3xlTmjk2jb8P4GEE3b+Xj6nWUwWtjRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ljPx/kLW; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 18A4F2C03CB;
	Tue,  4 Jun 2024 09:59:12 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1717451952;
	bh=UYlBpvItHr2LFXKagCraKaTRi0BSSSgoGfrKvAR4lB0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ljPx/kLWXjpDjjt3HREJNAO08csX2hNK/scKhNGOYpaEK5pbB9H8VlNO5qk5yXVvH
	 Yp0WhWdLjOWPiueIYdq0n4NbNQ8yVZvhb/4G0wtebnN9s7JOVDY9rVtPDdad96Bv7h
	 gUkF12DktCTkP09gI4pT7QNBr1yKylKxbH8u032TfEbhr7ZKXtb0jEf/+La0cFBWcs
	 bfyqaqRs6fXE4LKPBt7ODNiIXK8z8SMOB+YJCm6Bt+r38wSWlQRfYSJxvRu6u0FAgi
	 kX/T7CJGFw7ljN2ZdzM3XdHr7WxMx/sXFaZWyRFtzaLpDSPFUkg0fpkzSxXd7GqXYl
	 kttD9SEoxwYjw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B665e3caf0001>; Tue, 04 Jun 2024 09:59:11 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Jun 2024 09:59:11 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Tue, 4 Jun 2024 09:59:11 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andy Shevchenko <andy@kernel.org>
CC: "geert@linux-m68k.org" <geert@linux-m68k.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] auxdisplay: linedisp: Support configuring the boot
 message
Thread-Topic: [PATCH] auxdisplay: linedisp: Support configuring the boot
 message
Thread-Index: AQHasugIecfWZ64wR0ewV/2PFUMeS7GwsU6AgAUiP4A=
Date: Mon, 3 Jun 2024 21:59:11 +0000
Message-ID: <87e2e4c2-ed9e-4ab4-8920-e7983c5a18ac@alliedtelesis.co.nz>
References: <20240530232054.3559043-1-chris.packham@alliedtelesis.co.nz>
 <ZlnuNx6gKJV6w9YS@smile.fi.intel.com>
In-Reply-To: <ZlnuNx6gKJV6w9YS@smile.fi.intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C387B4FC65C6C4D89B36D4BCE558A7D@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=665e3caf a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=lZX2v85OOG7HqLjV-bEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAxLzA2LzI0IDAzOjM1LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IE9uIEZyaSwgTWF5
IDMxLCAyMDI0IGF0IDExOjIwOjU0QU0gKzEyMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBM
aWtlIHdlIGRvIGZvciBjaGFybGNkLCBhbGxvdyB0aGUgY29uZmlndXJhdGlvbiBvZiB0aGUgaW5p
dGlhbCBtZXNzYWdlDQo+PiBvbiBsaW5lLWRpc3BsYXkgZGV2aWNlcy4NCj4gUHVzaGVkIHRvIG15
IHJldmlldyBhbmQgdGVzdGluZyBxdWV1ZSwgdGhhbmtzIQ0KPg0KPiBJIHR3ZWFrZWQgdGhlIGRl
ZmluZSB0byBiZSBMSU5FRElTUCBhcyBHZWVydCBzdWdnZXN0ZWQuDQo+DQpBY3R1YWxseSBkaWQg
eW91PyBJIGp1c3QgY2hlY2tlZCB3aGF0J3MgaW4gDQphbmR5L2xpbnV4LWF1eGRpc3BsYXkvcmV2
aWV3LWFuZHkgYW5kIGl0IHN0aWxsIHVzZXMgTElORV9ESVNQLg0K

