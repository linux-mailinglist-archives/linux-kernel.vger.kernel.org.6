Return-Path: <linux-kernel+bounces-334349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C572997D611
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FE128637D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103781779A4;
	Fri, 20 Sep 2024 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Zjcowcu2"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15531714AF
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726838386; cv=none; b=me+6X00bT3QlGKhGVxc8SMa0C/nJNn02Y/ldxkpOFFRLt3XCm9a9BEM/62zIyUBiQCmXm7RZ2/RFwEEzqJ2fvm0g955thOuRA4H7cGe1jCoN6neWHiODcjGQhwUa+UFzIC9WKaD7SdqvnsyhBtMEs22L6wv7LXS6XXX6vtqM5S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726838386; c=relaxed/simple;
	bh=DFJqtOF4lDhc4gTyULxbIXKWq6CAYC2v6Kd9JudlogQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f2RvLVxJm1Ur/vGSit1sN/W6mKmUe18wJ+4CVcckjVRZNcxmBfbDtf+dLHvw07xfwZkScyAOMjs7eLA2JMgUgrgYtJgGX4ASUtEgRsi2fIQJD15V4tVynEZL9QL2iS6QcLPbyV7aezLoy9kBtS2cDyIKcY1MKnaCx6IMNLl4ghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Zjcowcu2; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1726838384; x=1758374384;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DFJqtOF4lDhc4gTyULxbIXKWq6CAYC2v6Kd9JudlogQ=;
  b=Zjcowcu2ITSWlm0BDn2z2TJt13Wsl3D/gNjtcw5I2BC6/+MtueIi6eTi
   dJOevS32pR+hmwhUI73fq6/kFdO357NlOSRAJYBjSg9lSwcVpOCWcmx6i
   ajN7mwV031NfKhLcjlzHbL2Lkbbd2f1LpE93qfRv3koMjAa4HljS+6AJN
   I=;
X-IronPort-AV: E=Sophos;i="6.10,244,1719878400"; 
   d="scan'208";a="128029568"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 13:19:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:28574]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.228:2525] with esmtp (Farcaster)
 id 02076010-c227-44f5-850a-0b401f639afb; Fri, 20 Sep 2024 13:19:42 +0000 (UTC)
X-Farcaster-Flow-ID: 02076010-c227-44f5-850a-0b401f639afb
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 20 Sep 2024 13:19:40 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Fri, 20 Sep 2024
 13:19:34 +0000
Message-ID: <23d90b50-f087-4daa-b4bc-4da406160c9d@amazon.com>
Date: Fri, 20 Sep 2024 15:19:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] support for mm-local memory allocations and use
 it
To: Fares Mehanna <faresx@amazon.de>
CC: <nh-open-source@amazon.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
	=?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>, Ard Biesheuvel
	<ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Javier Martinez
 Canillas" <javierm@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Fuad Tabba
	<tabba@google.com>, Mark Brown <broonie@kernel.org>, Joey Gouly
	<joey.gouly@arm.com>, Kristina Martsenko <kristina.martsenko@arm.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, "Mike Rapoport (IBM)"
	<rppt@kernel.org>, David Hildenbrand <david@redhat.com>, Roman Kagan
	<rkagan@amazon.de>, "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64
 (KVM/arm64)" <linux-arm-kernel@lists.infradead.org>, "open list:KERNEL
 VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" <kvmarm@lists.linux.dev>, open list
	<linux-kernel@vger.kernel.org>, "open list:MEMORY MANAGEMENT"
	<linux-mm@kvack.org>, <mark.rutland@arm.com>, Mike Rapoport
	<mikerapoport@microsoft.com>
References: <20240911143421.85612-1-faresx@amazon.de>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20240911143421.85612-1-faresx@amazon.de>
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMTEuMDkuMjQgMTY6MzMsIEZhcmVzIE1laGFubmEgd3JvdGU6Cj4gSW4gYSBzZXJpZXMgcG9z
dGVkIGEgZmV3IHllYXJzIGFnbyBbMV0sIGEgcHJvcG9zYWwgd2FzIHB1dCBmb3J3YXJkIHRvIGFs
bG93IHRoZQo+IGtlcm5lbCB0byBhbGxvY2F0ZSBtZW1vcnkgbG9jYWwgdG8gYSBtbSBhbmQgdGh1
cyBwdXNoIGl0IG91dCBvZiByZWFjaCBmb3IKPiBjdXJyZW50IGFuZCBmdXR1cmUgc3BlY3VsYXRp
b24tYmFzZWQgY3Jvc3MtcHJvY2VzcyBhdHRhY2tzLiAgV2Ugc3RpbGwgYmVsaWV2ZQo+IHRoaXMg
aXMgYSBuaWNlIHRoaW5nIHRvIGhhdmUuCj4KPiBIb3dldmVyLCBpbiB0aGUgdGltZSBwYXNzZWQg
c2luY2UgdGhhdCBwb3N0IExpbnV4IG1tIGhhcyBncm93biBxdWl0ZSBhIGZldyBuZXcKPiBnb29k
aWVzLCBzbyB3ZSdkIGxpa2UgdG8gZXhwbG9yZSBwb3NzaWJpbGl0aWVzIHRvIGltcGxlbWVudCB0
aGlzIGZ1bmN0aW9uYWxpdHkKPiB3aXRoIGxlc3MgZWZmb3J0IGFuZCBjaHVybiBsZXZlcmFnaW5n
IHRoZSBub3cgYXZhaWxhYmxlIGZhY2lsaXRpZXMuCj4KPiBBbiBSRkMgd2FzIHBvc3RlZCBmZXcg
bW9udGhzIGJhY2sgWzJdIHRvIHNob3cgdGhlIHByb29mIG9mIGNvbmNlcHQgYW5kIGEgc2ltcGxl
Cj4gdGVzdCBkcml2ZXIuCj4KPiBJbiB0aGlzIFJGQywgd2UncmUgdXNpbmcgdGhlIHNhbWUgYXBw
cm9hY2ggb2YgaW1wbGVtZW50aW5nIG1tLWxvY2FsIGFsbG9jYXRpb25zCj4gcGlnZ3ktYmFja2lu
ZyBvbiBtZW1mZF9zZWNyZXQoKSwgdXNpbmcgcmVndWxhciB1c2VyIGFkZHJlc3NlcyBidXQgcGlu
bmluZyB0aGUKPiBwYWdlcyBhbmQgZmxpcHBpbmcgdGhlIHVzZXIvc3VwZXJ2aXNvciBmbGFnIG9u
IHRoZSByZXNwZWN0aXZlIFBURXMgdG8gbWFrZSB0aGVtCj4gZGlyZWN0bHkgYWNjZXNzaWJsZSBm
cm9tIGtlcm5lbC4KPiBJbiBhZGRpdGlvbiB0byB0aGF0IHdlIGFyZSBzdWJtaXR0aW5nIDUgcGF0
Y2hlcyB0byB1c2UgdGhlIHNlY3JldCBtZW1vcnkgdG8gaGlkZQo+IHRoZSB2Q1BVIGdwLXJlZ3Mg
YW5kIGZwLXJlZ3Mgb24gYXJtNjQgVkhFIHN5c3RlbXMuCj4KPiBUaGUgZ2VuZXJpYyBkcmF3YmFj
a3Mgb2YgdXNpbmcgdXNlciB2aXJ0dWFsIGFkZHJlc3NlcyBtZW50aW9uZWQgaW4gdGhlIHByZXZp
b3VzCj4gUkZDIFsyXSBzdGlsbCBob2xkLCBpbiBhZGRpdGlvbiB0byBhIG1vcmUgc3BlY2lmaWMg
b25lOgo+Cj4gLSBXaGlsZSB0aGUgdXNlciB2aXJ0dWFsIGFkZHJlc3NlcyBhbGxvY2F0ZWQgZm9y
IGtlcm5lbCBzZWNyZXQgbWVtb3J5IGFyZSBub3QKPiAgICBkaXJlY3RseSBhY2Nlc3NpYmxlIGJ5
IHVzZXJzcGFjZSBhcyB0aGUgUFRFcyByZXN0cmljdCB0aGF0LCBjb3B5X2Zyb21fdXNlcigpCj4g
ICAgYW5kIGNvcHlfdG9fdXNlcigpIGNhbiBvcGVyYXRlIG9uIHRob3NlIHJhbmdlcywgc28gdGhh
dCBlLmcuIHRoZSB1c2VybW9kZSBjYW4KPiAgICBndWVzcyB0aGUgYWRkcmVzcyBhbmQgcGFzcyBp
dCBhcyB0aGUgdGFyZ2V0IGJ1ZmZlciBmb3IgcmVhZCgpLCBtYWtpbmcgdGhlCj4gICAga2VybmVs
IG92ZXJ3cml0ZSBpdCB3aXRoIHRoZSB1c2VyLWNvbnRyb2xsZWQgY29udGVudC4gRWZmZWN0aXZl
bHkgbWFraW5nIHRoZQo+ICAgIHNlY3JldCBtZW1vcnkgaW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50
YXRpb24gbWlzc2luZyBjb25maWRlbnRpYWxpdHkgYW5kCj4gICAgaW50ZWdyaXR5IGd1YXJhbnRl
ZXMuCj4KPiBJbiB0aGUgc3BlY2lmaWMgY2FzZSBvZiB2Q1BVIHJlZ2lzdGVycywgdGhpcyBpcyBm
aW5lIGJlY2F1c2UgdGhlIG93bmVyIHByb2Nlc3MKPiBjYW4gcmVhZCBhbmQgd3JpdGUgdG8gdGhl
bSB1c2luZyBLVk0gSU9DVExzIGFueXdheS4gQnV0IGluIHRoZSBnZW5lcmFsIGNhc2UgdGhpcwo+
IHJlcHJlc2VudHMgYSBzZWN1cml0eSBjb25jZXJuIGFuZCBuZWVkcyB0byBiZSBhZGRyZXNzZWQu
Cj4KPiBBIHBvc3NpYmxlIHdheSBmb3J3YXJkIGZvciB0aGUgYXJjaC1hZ25vc3RpYyBpbXBsZW1l
bnRhdGlvbiBpcyB0byBsaW1pdCB0aGUgdXNlcgo+IHZpcnR1YWwgYWRkcmVzc2VzIHVzZWQgZm9y
IGtlcm5lbCB0byBzcGVjaWZpYyByYW5nZSB0aGF0IGNhbiBiZSBjaGVja2VkIGFnYWluc3QKPiBp
biBjb3B5X2Zyb21fdXNlcigpIGFuZCBjb3B5X3RvX3VzZXIoKS4KPgo+IEZvciBhcmNoIHNwZWNp
ZmljIGltcGxlbWVudGF0aW9uLCB1c2luZyBzZXBhcmF0ZSBQR0QgaXMgdGhlIHdheSB0byBnby4K
Pgo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTkwNjEyMTcwODM0LjE0ODU1
LTEtbWhpbGxlbmJAYW1hem9uLmRlLwo+IFsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzIwMjQwNjIxMjAxNTAxLjEwNTk5NDgtMS1ya2FnYW5AYW1hem9uLmRlLwoKCkhleSBNYXJrIGFu
ZCBNaWtlLAoKV2UgdGFsa2VkIGF0IExQQyBhYm91dCBtbS1sb2NhbCBtZW1vcnkgYW5kIHlvdSBo
YWQgc29tZSBpbnB1dHMuIEl0IHdvdWxkIApiZSBhbWF6aW5nIHRvIHdyaXRlIHRoZW0gZG93biBo
ZXJlIHNvIEkgZG9uJ3QgZW5kIHVwIHBsYXlpbmcgZ2FtZSBvZiAKdGVsZXBob25lIDopCgoKVGhh
bmtzIQoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBH
bWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlz
dGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0
IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBE
RSAzNjUgNTM4IDU5Nwo=


