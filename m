Return-Path: <linux-kernel+bounces-199728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 907768DAE76
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E641C2406B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E579D13B7B3;
	Mon,  3 Jun 2024 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="YvtAcsJe"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A647E0F0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449658; cv=none; b=HHAZW5Apwa/AqToJaIO6DcLX9sK0J2qGDe/ooCUlda2QGoqY/Dyevzkq0Xqj//6jS5xCcnX4DAKLIJVN4n1dWXVo/RjpJOMDfO4+bRx43z06nGVpPiVevmBltYSpBXHBZUCz6RR/cqtBiN6xEwxnzSyTnfgzup6hJid/s1PIWbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449658; c=relaxed/simple;
	bh=ZfhwBS3d8e5zcuO7HzsONZmyUz0E8P83zP91yo0TkqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=US0AOwuTWslKsOn/xsFPnH5DZK/vT70zhMUqY0wnyk/xveM2LaZNaGGXBPUlZGqLnUZPV5jJ6HFShyXEqLp1mI4a/1EM9wZzZfeGOMEX6mrVf3xhWiAb+M+Kc7A+vaxu5k7DzSnfJwoQb0rAJ3m6Kn6dyx2yejqpJ8cewX44rlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=YvtAcsJe; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E6E902C03CB;
	Tue,  4 Jun 2024 09:20:46 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1717449646;
	bh=ZfhwBS3d8e5zcuO7HzsONZmyUz0E8P83zP91yo0TkqE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=YvtAcsJeEE4889xMvP7rMSKr7ecaSz07E0wE+3V7FiATecb+2QuxJEW6GE1ODeZRX
	 vlZONyRiPsWEHYok1oVZde/Q9tA263qC7jb6xI1EW/QFD4LNuMqifEpShq2KQlDhqf
	 mfO/gT+fBIbkbX9pMf/f1ew6S2uQNvKTnJk1bTopTtIwlcnZjzRnDVtAHsDtbbTyZv
	 cG6imtVSA3XsbjkIjBrj4QPGM6Q0KPg913+eZnd9xRFkEM5qBIoIvezCZ4puz+Ilm+
	 pk5/pUFR8pVv3+1AFkv8MW2B+ddMqLQhFoJDkpk2AV9gpMmKyfZhFSFdSvwacQO5L3
	 p34nrjBpY0AHA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B665e33ae0001>; Tue, 04 Jun 2024 09:20:46 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Jun 2024 09:20:46 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Tue, 4 Jun 2024 09:20:46 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andy Shevchenko <andy@kernel.org>
CC: "geert@linux-m68k.org" <geert@linux-m68k.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] auxdisplay: linedisp: Support configuring the boot
 message
Thread-Topic: [PATCH] auxdisplay: linedisp: Support configuring the boot
 message
Thread-Index: AQHasugIecfWZ64wR0ewV/2PFUMeS7GwsU6AgAUXgoA=
Date: Mon, 3 Jun 2024 21:20:45 +0000
Message-ID: <19bb8b8e-6587-4b39-8453-87c6957172e3@alliedtelesis.co.nz>
References: <20240530232054.3559043-1-chris.packham@alliedtelesis.co.nz>
 <ZlnuNx6gKJV6w9YS@smile.fi.intel.com>
In-Reply-To: <ZlnuNx6gKJV6w9YS@smile.fi.intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC82B224C754464B90E7ECBCA941905F@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=665e33ae a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=lZX2v85OOG7HqLjV-bEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAxLzA2LzI0IDAzOjM1LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IE9uIEZyaSwgTWF5
IDMxLCAyMDI0IGF0IDExOjIwOjU0QU0gKzEyMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBM
aWtlIHdlIGRvIGZvciBjaGFybGNkLCBhbGxvdyB0aGUgY29uZmlndXJhdGlvbiBvZiB0aGUgaW5p
dGlhbCBtZXNzYWdlDQo+PiBvbiBsaW5lLWRpc3BsYXkgZGV2aWNlcy4NCj4gUHVzaGVkIHRvIG15
IHJldmlldyBhbmQgdGVzdGluZyBxdWV1ZSwgdGhhbmtzIQ0KPg0KPiBJIHR3ZWFrZWQgdGhlIGRl
ZmluZSB0byBiZSBMSU5FRElTUCBhcyBHZWVydCBzdWdnZXN0ZWQuDQoNClRoYW5rcyBhIGxvdC4g
RW5qb3kgeW91ciB3ZWxsIGVhcm5lZCB2YWNhdGlvbi4NCg==

