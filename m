Return-Path: <linux-kernel+bounces-431111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11779E3977
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C554AB291C9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121C11B2522;
	Wed,  4 Dec 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eJdmmZB3"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640501AF0C1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312465; cv=none; b=PqY5zxQX3VqEuaH0ZZODZVTGHy6eIVPYNS+X69mUiYSH5a9E0Gsui/DR9jnoGn8VuTIrgtlMcF34BbFxKpVwJCZS7RP7AxI4i5uqcIzYYZksrZy9+XK5iUiso54KDBV0IaG0XQYU7h11+jGpD8w57K89nnjcE4pVXMeEOdhkiEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312465; c=relaxed/simple;
	bh=L3N4xnB4hpUkX70oEIl5ay7oOHjK5rWVH5VO26SBMRE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RE5cMwtstqh2Q37ohGo3l5k5D78V/JX8ges9WVyV7SOi0TvszhwweMTMtASRaZ5fe6i7sQ1FxLvIvRx+1RK3DRuwMO0prpeEwCMPsCR4GZuaoiCvuvH4tS3rp11T+7LsCDbD5WY6+h2AwhlA2wxBO1MRsHYafk7KjQ+r0JsivZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eJdmmZB3; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733312463; x=1764848463;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=L3N4xnB4hpUkX70oEIl5ay7oOHjK5rWVH5VO26SBMRE=;
  b=eJdmmZB3UhtVVY1RCWIo3hr9Q0f+PrPxJMON5f9XiApflr9tPFfhhLSq
   o/IgMPiJH2XX0fG/5TwGuuyjArmEQxSDjEyfheKVp3YSc03VUtRJWN34r
   u8QW0ssH8e22MIftVzR7O2yHBdDKmwgJNtGP0I70OhPGAUE9UAz9uYqU6
   0=;
X-IronPort-AV: E=Sophos;i="6.12,207,1728950400"; 
   d="scan'208";a="475378494"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 11:40:58 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:59262]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.207:2525] with esmtp (Farcaster)
 id 52e49eb4-420c-4db9-a56f-779f9c594c75; Wed, 4 Dec 2024 11:40:55 +0000 (UTC)
X-Farcaster-Flow-ID: 52e49eb4-420c-4db9-a56f-779f9c594c75
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 4 Dec 2024 11:40:55 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 4 Dec 2024 11:40:55 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.1258.034; Wed, 4 Dec 2024 11:40:55 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Jiri Slaby <jirislaby@kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "npiggin@gmail.com" <npiggin@gmail.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"naveen@kernel.org" <naveen@kernel.org>, "maddy@linux.ibm.com"
	<maddy@linux.ibm.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bhe@redhat.com"
	<bhe@redhat.com>, "hbathini@linux.ibm.com" <hbathini@linux.ibm.com>,
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
	"adityag@linux.ibm.com" <adityag@linux.ibm.com>, "songshuaishuai@tinylab.org"
	<songshuaishuai@tinylab.org>, "takakura@valinux.co.jp"
	<takakura@valinux.co.jp>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
CC: "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: RE: [PATCH v5 1/2] kexec: Consolidate machine_kexec_mask_interrupts()
 implementation
Thread-Topic: [PATCH v5 1/2] kexec: Consolidate
 machine_kexec_mask_interrupts() implementation
Thread-Index: AdtGQRkhPCy0bAvuc0C5GQef/95iog==
Date: Wed, 4 Dec 2024 11:40:55 +0000
Message-ID: <4192766c8f02494a82db68f5732c6dd2@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMTIvNC8yMDI0IDE6MDIgUE0sIEppcmkgU2xhYnkgd3JvdGU6DQo+PiArDQo+PiArY29uZmln
IEdFTkVSSUNfSVJRX0tFWEVDX0NMRUFSX1ZNX0ZPUldBUkQNCj4+ICsgICAgIGJvb2wgIkNsZWFy
IGZvcndhcmRlZCBWTSBpbnRlcnJ1cHRzIGR1cmluZyBrZXhlYyINCj4+ICsgICAgIGRlZmF1bHQg
bg0KPj4gKyAgICAgaGVscA0KPj4gKyAgICAgICBXaGVuIGVuYWJsZWQsIHRoaXMgb3B0aW9uIGFs
bG93cyB0aGUga2VybmVsIHRvIGNsZWFyIHRoZSBhY3RpdmUgc3RhdGUNCj4+ICsgICAgICAgb2Yg
aW50ZXJydXB0cyB0aGF0IGFyZSBmb3J3YXJkZWQgdG8gdmlydHVhbCBtYWNoaW5lcyAoVk1zKSBk
dXJpbmcgYQ0KPj4gKyAgICAgICBtYWNoaW5lIGtleGVjLiBGb3IgaW50ZXJydXB0cyB0aGF0IGFy
ZSBub3QgZm9yd2FyZGVkLCBpZiBzdXBwb3J0ZWQsDQo+PiArICAgICAgIHRoZSBrZXJuZWwgd2ls
bCBhdHRlbXB0IHRvIHRyaWdnZXIgYW4gRW5kIG9mIEludGVycnVwdCAoRU9JKS4NCj4NCj4gVGhp
cyBjYXVnaHQgbXkgYXR0ZW50aW9uLiBJdCBsb29rcyBsaWtlIHlvdSB3YW50IHRvIGFsbG93IHBl
b3BsZSB0b2dnbGluZyBpdD8gSSBiZWxpZXZlIG9ubHkgYXJjaCBjb2RlIHNob3VsZCB0dXJuIGl0
IG9uIGFzIHlvdSBkbyBieSAic2VsZWN0Iiwgbm90IHVzZXJzLg0KDQpUaG9tYXMgR2xlaXhuZXIg
aGFzIGFsc28gY29tbWVudGVkIGFib3V0IGl0Og0KIg0KVGhpcyBzaG91bGQgbm90IGJlIHVzZXIg
c2VsZWN0YWJsZS4gSnVzdCBrZWVwIGl0IGFzOg0KDQpjb25maWcgR0VORVJJQ19JUlFfS0VYRUNf
Q0xFQVJfVk1fRk9SV0FSRA0KICAgICAgICBib29sDQoNCndoaWNoIGRlZmF1bHRzIHRvICduJy4g
SnVzdCBhZGQgYSBjb21tZW50IHdoYXQgdGhpcyBpcyBhYm91dCBsaWtlIGl0J3MgZG9uZSB3aXRo
IHRoZSBvdGhlciBvcHRpb25zIGluIHRoYXQgZmlsZSB3aGljaCBhcmUgb25seSBzZWxlY3RhYmxl
Lg0KIg0KDQpJIHdpbGwgZml4IGl0IGluIHY2Lg0KSSdtIGp1c3Qgd2FpdGluZyBmb3IgYSByZXBs
eSBpZiB0aGUgbmV3IGNvbmZpZ3VyYXRpb24gb3B0aW9uIHNob3VsZCBiZQ0KcGxhY2VkIGluc2lk
ZSBvciBhZnRlciB0aGUgZm9sbG93aW5nIHNlY3Rpb246DQpgYGANCm1lbnUgIklSUSBzdWJzeXN0
ZW0iDQoNCmVuZG1lbnUNCmBgYA0KDQpUaGFua3MsIEVsaWF2DQo=

