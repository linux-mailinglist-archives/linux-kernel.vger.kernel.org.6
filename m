Return-Path: <linux-kernel+bounces-219164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E607290CB4E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D12B2B673
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C3615EFB1;
	Tue, 18 Jun 2024 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vGy/GUm0"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5D715ECFB;
	Tue, 18 Jun 2024 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711282; cv=none; b=dAFjENqf8TQdpyWR2CVNOPc90v/2kfvvVeQTj2wmBeVUg2Fr/2kGjMnkKC58394pJoBBC2+9GwAgZq236oqv0ipEDQVz53Q+caiU1rWxze9jhGhbR2G6kN/g4pQkRPvKww3ezbKTLiUeZ83enyH/V6H5MrgRWh4SE/I4mMHt3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711282; c=relaxed/simple;
	bh=+vRDRVJpN5rq3WHoroYBpb7LA/QI9MFmI/SarapUiZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lffQ1ZaoI6Z4Nuhn446WVykxCPSlsojds46PICNh6k7cLOpeuMxZssVwUBsB7xUpDX0ZEPlJ+yNblSoYeYT59Aew1HwWdYeO8gjdT7IMWoB7PoKLKg0HG8nnGeaEEZfm+1Kxt1rGzIA0WBBmhSZgrQmqwYIholMzsPY6dFKtSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vGy/GUm0; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718711280; x=1750247280;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+vRDRVJpN5rq3WHoroYBpb7LA/QI9MFmI/SarapUiZY=;
  b=vGy/GUm0jbxnPT+DIO2HJuJM1uBfY3c6jXQcOXqupcrawjV2t2RqgBBj
   +jh2AOT4CWKbms0BuWKh5wkR/Po2QmuHwJWi/ku++lxILJbSsIjvRMMrC
   p4CuMGxNGwp7rYuTk4Y6vf1WdXKKCCiF/MRwy1MNf6rKwKD//ISWDoLLV
   E=;
X-IronPort-AV: E=Sophos;i="6.08,247,1712620800"; 
   d="scan'208";a="302943811"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 11:47:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:40284]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.70:2525] with esmtp (Farcaster)
 id a685a64b-3977-4cba-b9a5-e7377359415e; Tue, 18 Jun 2024 11:47:57 +0000 (UTC)
X-Farcaster-Flow-ID: a685a64b-3977-4cba-b9a5-e7377359415e
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 18 Jun 2024 11:47:56 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 18 Jun
 2024 11:47:52 +0000
Message-ID: <cd759ac0-73e6-4ab3-a2d0-94f43eec5752@amazon.com>
Date: Tue, 18 Jun 2024 13:47:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
To: Ard Biesheuvel <ardb@kernel.org>
CC: Steven Rostedt <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>, Joel Fernandes
	<joel@joelfernandes.org>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<suleiman@google.com>, Thomas Gleixner <tglx@linutronix.de>, Vineeth Pillai
	<vineeth@bitbyteword.org>, Youssef Esmat <youssefesmat@google.com>, "Beau
 Belgrave" <beaub@linux.microsoft.com>, Baoquan He <bhe@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>, David
 Howells <dhowells@redhat.com>, Mike Rapoport <rppt@kernel.org>
References: <20240613155506.811013916@goodmis.org>
 <b0ed328f-c4e5-4e9b-ae4e-5c60703ab376@amazon.com>
 <20240613131212.7d1a7ffa@rorschach.local.home>
 <7c90c574-5cfa-40cf-bd4c-1188136cd886@amazon.com>
 <20240617164006.198b9ba3@rorschach.local.home>
 <049b2e0f-00b2-4704-8868-1569a006a134@amazon.com>
 <CAMj1kXF3AetyuLh-QU8yaE-wTLcgyzwuAwe-uo_3EqSDsAYhuQ@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAMj1kXF3AetyuLh-QU8yaE-wTLcgyzwuAwe-uo_3EqSDsAYhuQ@mail.gmail.com>
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDE4LjA2LjI0IDEyOjIxLCBBcmQgQmllc2hldXZlbCB3cm90ZToKPiBPbiBNb24sIDE3IEp1
biAyMDI0IGF0IDIzOjAxLCBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPiB3cm90ZToK
Pj4gT24gMTcuMDYuMjQgMjI6NDAsIFN0ZXZlbiBSb3N0ZWR0IHdyb3RlOgo+Pj4gT24gTW9uLCAx
NyBKdW4gMjAyNCAwOTowNzoyOSArMDIwMAo+Pj4gQWxleGFuZGVyIEdyYWY8Z3JhZkBhbWF6b24u
Y29tPiAgd3JvdGU6Cj4+Pgo+Pj4+IEhleSBTdGV2ZSwKPj4+Pgo+Pj4+Cj4+Pj4gSSBiZWxpZXZl
IHdlJ3JlIHRhbGtpbmcgYWJvdXQgMiBkaWZmZXJlbnQgdGhpbmdzIDopLiBMZXQgbWUgcmVwaHJh
c2UgYQo+Pj4+IGJpdCBhbmQgbWFrZSBhIGNvbmNyZXRlIGV4YW1wbGUuCj4+Pj4KPj4+PiBJbWFn
aW5lIHlvdSBoYXZlIHBhc3NlZCB0aGUgInJlc2VydmVfbWVtPTEyTTo0MDk2OnRyYWNlIiBrZXJu
ZWwgY29tbWFuZAo+Pj4+IGxpbmUgb3B0aW9uLiBUaGUga2VybmVsIG5vdyBjb21lcyB1cCBhbmQg
YWxsb2NhdGVzIGEgcmFuZG9tIGNodW5rIG9mCj4+Pj4gbWVtb3J5IHRoYXQgLSBieSAoYWRtaXR0
ZWRseSBnb29kKSBjaGFuY2UgLSBtYXkgYmUgYXQgdGhlIHNhbWUgcGh5c2ljYWwKPj4+PiBsb2Nh
dGlvbiBhcyBiZWZvcmUuIExldCdzIGFzc3VtZSBpdCBkZWVtZWQgMHgxMDAwMDAwIGFzIGEgZ29v
ZCBvZmZzZXQuCj4+PiBOb3RlLCBpdCdzIG5vdCByYW5kb20uIEl0IHBpY2tzIGZyb20gdGhlIHRv
cCBvZiBhdmFpbGFibGUgbWVtb3J5IGV2ZXJ5Cj4+PiB0aW1lLiBCdXQgdGhpbmdzIGNhbiBtZXNz
IHdpdGggaXQgKHNlZSBiZWxvdykuCj4+Pgo+Pj4+IExldCdzIG5vdyBhc3N1bWUgeW91J3JlIHJ1
bm5pbmcgb24gYSBVRUZJIHN5c3RlbS4gVGhlcmUsIHlvdSBhbHdheXMgaGF2ZQo+Pj4+IG5vbi12
b2xhdGlsZSBzdG9yYWdlIGF2YWlsYWJsZSB0byB5b3UgZXZlbiBpbiB0aGUgcHJlLWJvb3QgcGhh
c2UuIFRoYXQKPj4+PiBtZWFucyB0aGUga2VybmVsIGNvdWxkIGNyZWF0ZSBhIFVFRkkgdmFyaWFi
bGUgdGhhdCBzYXlzICIxMk06NDA5Njp0cmFjZQo+Pj4+IC0+IDB4MTAwMDAwMCIuIFRoZSBwcmUt
Ym9vdCBwaGFzZSB0YWtlcyBhbGwgdGhlc2UgVUVGSSB2YXJpYWJsZXMgYW5kCj4+Pj4gbWFya3Mg
dGhlbSBhcyByZXNlcnZlZC4gV2hlbiB5b3UgZmluYWxseSByZWFjaCB5b3VyIGNvbW1hbmQgbGlu
ZSBwYXJzaW5nCj4+Pj4gbG9naWMgZm9yIHJlc2VydmVfbWVtPSwgeW91IGNhbiBmbGlwIGFsbCBy
ZXNlcnZhdGlvbnMgdGhhdCB3ZXJlIG5vdCBvbgo+Pj4+IHRoZSBjb21tYW5kIGxpbmUgYmFjayB0
byBub3JtYWwgbWVtb3J5Lgo+Pj4+Cj4+Pj4gVGhhdCB3YXkgeW91IGhhdmUgcHJldHR5IG11Y2gg
Z3VhcmFudGVlZCBwZXJzaXN0ZW50IG1lbW9yeSByZWdpb25zLCBldmVuCj4+Pj4gd2l0aCBLQVNM
UiBjaGFuZ2luZyB5b3VyIG1lbW9yeSBsYXlvdXQgYWNyb3NzIGJvb3RzLgo+Pj4+Cj4+Pj4gVGhl
IG5pY2UgdGhpbmcgaXMgdGhhdCB0aGUgYWJvdmUgaXMgYW4gZXh0ZW5zaW9uIG9mIHdoYXQgeW91
J3ZlIGFscmVhZHkKPj4+PiBidWlsdDogU3lzdGVtcyB3aXRoIFVFRkkgc2ltcGx5IGdldCBiZXR0
ZXIgZ3VhcmFudGVlcyB0aGF0IHRoZWlyIHJlZ2lvbnMKPj4+PiBwZXJzaXN0Lgo+Pj4gVGhpcyBj
b3VsZCBiZSBhbiBhZGRlZCBmZWF0dXJlLCBidXQgaXQgaXMgdmVyeSBhcmNoaXRlY3R1cmUgc3Bl
Y2lmaWMsCj4+PiBhbmQgd291bGQgbGlrZWx5IG5lZWQgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHVw
ZGF0ZXMuCj4+Cj4+IEl0IGRlZmluaXRlbHkgd291bGQgYmUgYW4gYWRkZWQgZmVhdHVyZSwgeWVz
LiBCdXQgb25lIHRoYXQgYWxsb3dzIHlvdSB0bwo+PiBlbnN1cmUgcGVyc2lzdGVuY2UgYSBsb3Qg
bW9yZSBzYWZlbHkgOikuCj4+Cj4+Cj4+Pj4+Pj4gUmVxdWlyZW1lbnQ6Cj4+Pj4+Pj4KPj4+Pj4+
PiBOZWVkIGEgd2F5IHRvIHJlc2VydmUgbWVtb3J5IHRoYXQgd2lsbCBiZSBhdCBhIGNvbnNpc3Rl
bnQgbG9jYXRpb24gZm9yCj4+Pj4+Pj4gZXZlcnkgYm9vdCwgaWYgdGhlIGtlcm5lbCBhbmQgc3lz
dGVtIGFyZSB0aGUgc2FtZS4gRG9lcyBub3QgbmVlZCB0byB3b3JrCj4+Pj4+Pj4gaWYgcmVib290
aW5nIHRvIGEgZGlmZmVyZW50IGtlcm5lbCwgb3IgaWYgdGhlIHN5c3RlbSBjYW4gY2hhbmdlIHRo
ZQo+Pj4+Pj4+IG1lbW9yeSBsYXlvdXQgYmV0d2VlbiBib290cy4KPj4+Pj4+Pgo+Pj4+Pj4+IFRo
ZSByZXNlcnZlZCBtZW1vcnkgY2FuIG5vdCBiZSBhbiBoYXJkIGNvZGVkIGFkZHJlc3MsIGFzIHRo
ZSBzYW1lIGtlcm5lbCAvCj4+Pj4+Pj4gY29tbWFuZCBsaW5lIG5lZWRzIHRvIHJ1biBvbiBzZXZl
cmFsIGRpZmZlcmVudCBtYWNoaW5lcy4gVGhlIHBpY2tlZCBtZW1vcnkKPj4+Pj4+PiByZXNlcnZh
dGlvbiBqdXN0IG5lZWRzIHRvIGJlIHRoZSBzYW1lIGZvciBhIGdpdmVuIG1hY2hpbmUsIGJ1dCBt
YXkgYmUKPj4+Pj4+IFdpdGggS0FTTFIgaXMgZW5hYmxlZCwgZG9lc24ndCB0aGlzIGFwcHJvYWNo
IGJyZWFrIHRvbyBvZnRlbiB0byBiZQo+Pj4+Pj4gcmVsaWFibGUgZW5vdWdoIGZvciB0aGUgZGF0
YSB5b3Ugd2FudCB0byBleHRyYWN0Pwo+Pj4+Pj4KPj4+Pj4+IFBpY2tpbmcgdXAgdGhlIGlkZWEg
YWJvdmUsIHdpdGggYSBwZXJzaXN0ZW50IHZhcmlhYmxlIHdlIGNvdWxkIGV2ZW4gbWFrZQo+Pj4+
Pj4gS0FTTFIgYXZvaWQgdGhhdCByZXNlcnZlZCBwc3RvcmUgcmVnaW9uIGluIGl0cyBzZWFyY2gg
Zm9yIGEgdmlhYmxlIEtBU0xSCj4+Pj4+PiBvZmZzZXQuCj4+Pj4+IEkgdGhpbmsgSSB3YXMgaGl0
IGJ5IGl0IG9uY2UgaW4gYWxsIG15IHRlc3RpbmcuIEZvciBvdXIgdXNlIGNhc2UsIHRoZQo+Pj4+
PiBmZXcgdGltZXMgaXQgZmFpbHMgdG8gbWFwIGlzIG5vdCBnb2luZyB0byBhZmZlY3Qgd2hhdCB3
ZSBuZWVkIHRoaXMgZm9yCj4+Pj4+IGF0IGFsbC4KPj4+PiBPbmNlIGlzIHByZXR0eSBnb29kLiBE
byB5b3Uga25vdyB3aHk/IEFsc28gb25jZSBvdXQgb2YgaG93IG1hbnkgcnVucz8gSXMKPj4+PiB0
aGUgcmFuZG9tbmVzcyBzb3VyY2Ugbm90IGFzIHJhbmRvbSBhcyBpdCBzaG91bGQgYmUgb3IgYXJl
IHRoZSBudW1iZXIgb2YKPj4+PiBiaXRzIGZvciBLQVNMUiBtYXliZSBzbyBmZXcgb24geW91ciB0
YXJnZXQgYXJjaGl0ZWN0dXJlIHRoYXQgdGhlIG9kZHMgb2YKPj4+PiBoaXR0aW5nIGFueXRoaW5n
IGJlY29tZSBsb3c/IERvIHRoZXNlIHNhbWUgY29uc3RyYWludHMgaG9sZCB0cnVlIG91dHNpZGUK
Pj4+PiBvZiB5b3VyIHRlc3RpbmcgZW52aXJvbm1lbnQ/Cj4+PiBTbyBJIGp1c3QgcmFuIGl0IGEg
aHVuZHJlZCB0aW1lcyBpbiBhIGxvb3AuIEkgYWRkZWQgYSBwYXRjaCB0byBwcmludAo+Pj4gdGhl
IGxvY2F0aW9uIG9mICJfdGV4dCIuIFRoZSBsb29wIHdhcyB0aGlzOgo+Pj4KPj4+ICAgICBmb3Ig
aSBpbiBgc2VxIDEwMGA7IGRvCj4+PiAgICAgICAgICAgc3NoIHJvb3RAZGViaWFudGVzdGluZy14
ODYtNjQgImRtZXNnIHwgZ3JlcCAtZSAndGV4dCBzdGFydHMnIC1lICdtYXBwZWQgYm9vdCcgID4+
IHRleHQ7IGdydWItcmVib290ICcxPjAnOyBzbGVlcCAwLjU7IHJlYm9vdCIKPj4+ICAgICAgICAg
ICBzbGVlcCAyNQo+Pj4gICAgIGRvbmUKPj4+Cj4+PiBJdCBzZWFyY2hlcyBkbWVzZyBmb3IgbXkg
YWRkZWQgcHJpbnRrIGFzIHdlbGwgYXMgdGhlIHByaW50IG9mIHdlcmUgdGhlCj4+PiByaW5nIGJ1
ZmZlciB3YXMgbG9hZGVkIGluIHBoeXNpY2FsIG1lbW9yeS4KPj4+Cj4+PiBJdCB0YWtlcyBhYm91
dCAxNSBzZWNvbmRzIHRvIHJlYm9vdCwgc28gSSB3YWl0ZWQgMjUuIFRoZSByZXN1bHRzIGFyZQo+
Pj4gYXR0YWNoZWQuIEkgZm91bmQgdGhhdCBpdCB3YXMgY29uc2lzdGVudCA3NiB0aW1lcywgd2hp
Y2ggbWVhbnMgMSBvdXQgb2YKPj4+IDQgaXQncyBub3QuIEZ1bm55IGVub3VnaCwgaXQgYnJva2Ug
d2hlbmV2ZXIgaXQgbG9hZGVkIHRoZSBrZXJuZWwgYmVsb3cKPj4+IDB4MTAwMDAwMDAwLiBBbmQg
dGhlbiBpdCB3b3VsZCBiZSBvZmYgYnkgYSBsaXR0bGUuCj4+Pgo+Pj4gSXQgd2FzIGNvbnNpc3Rl
bnRseSBhdDoKPj4+Cj4+PiAgICAgMHgyN2QwMDAwMDAKPj4+Cj4+PiBBbmQgd2hlbiBpdCBmYWls
ZWQsIGl0IHdhcyBhdCAweDI3Y2UwMDAwMC4KPj4+Cj4+PiBOb3RlLCB3aGVuIEkgdXNlZCB0aGUg
ZTgyMCB0YWJsZXMgdG8gZG8gdGhpcywgSSBuZXZlciBzYXcgYSBmYWlsdXJlLiBNeQo+Pj4gYXNz
dW1wdGlvbiBpcyB0aGF0IHdoZW4gaXQgaXMgYmVsb3cgMHgxMDAwMDAwMDAsIHNvbWV0aGluZyBl
bHNlIGdldHMKPj4+IGFsbG9jYXRlZCBjYXVzaW5nIHRoaXMgdG8gZ2V0IHB1c2hlZCBkb3duLgo+
Pgo+PiBUaGlua2luZyBhYm91dCBpdCBhZ2FpbjogV2hhdCBpZiB5b3UgcnVuIHRoZSBhbGxvY2F0
aW9uIHN1cGVyIGVhcmx5IChzZWUKPj4gYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2thc2xyLmM6
aGFuZGxlX21lbV9vcHRpb25zKCkpPwo+IFRoYXQgY29kZSBpcyBub3QgdXNlZCBieSBFRkkgYm9v
dCBhbnltb3JlLgo+Cj4gSW4gZ2VuZXJhbCwgSSB3b3VsZCByZWNvbW1lbmQgKGFuZCBoYXZlIHJl
Y29tbWVuZGVkKSBhZ2FpbnN0IHRoZXNlCj4ga2luZHMgb2YgaGFja3MgaW4gbWFpbmxpbmUsIGJl
Y2F1c2UgLWVzcGVjaWFsbHkgb24geDg2LSB0aGVyZSBpcwo+IGFsd2F5cyBzb21lb25lIHRoYXQg
dHVybnMgdXAgd2l0aCBzb21lIGtpbmQgb2YgY29udm9sdXRlZCB1c2UgY2FzZQo+IHRoYXQgZ2V0
cyBicm9rZW4gaWYgd2UgdHJ5IHRvIGNoYW5nZSBhbnl0aGluZyBpbiB0aGUgYm9vdCBjb2RlLgo+
Cj4gSSBzcGVudCBjb25zaWRlcmFibGUgdGltZSBvdmVyIHRoZSBwYXN0IHllYXIgbWFraW5nIHRo
ZSBFRkkveDg2IGJvb3QKPiBjb2RlIGNvbXBhdGlibGUgd2l0aCB0aGUgbmV3IE1TIGltcG9zZWQg
cmVxdWlyZW1lbnRzIG9uIFBDIGJvb3QKPiBmaXJtd2FyZSAocmVsYXRlZCB0byBzZWN1cmUgYm9v
dCBhbmQgTlggcmVzdHJpY3Rpb25zIG9uIG1lbW9yeQo+IG1hcHBpbmdzKS4gVGhpcyBpbnZvbHZl
ZCBzb21lIHJhZGljYWwgcmVmYWN0b3Jpbmcgb2YgdGhlIGJvb3QKPiBzZXF1ZW5jZSwgaW5jbHVk
aW5nIHRoZSBLQVNMUiBsb2dpYy4gQWRkaW5nIGZyYWdpbGUgY29kZSB0aGVyZSB0aGF0Cj4gd2ls
bCByZXN1bHQgaW4gcmVncmVzc2lvbnMgb2JzZXJ2YWJsZSB0byBlbmQgdXNlcnMgd2hlbiBpdCBn
ZXRzIGJyb2tlbgo+IGlzIHJlYWxseSBub3Qgd2hhdCBJJ2QgbGlrZSB0byBzZWUuCj4KPiBTbyBJ
IHdvdWxkIHBlcnNvbmFsbHkgcHJlZmVyIGZvciB0aGlzIGNvZGUgbm90IHRvIGdvIGluIGF0IGFs
bC4gQnV0IGlmCj4gaXQgZG9lcyBnbyBpbiAoYW5kIFN0ZXZlbiBoYXMgYWxyZWFkeSBhZ3JlZWQg
dG8gdGhpcyksIGl0IG5lZWRzIGEKPiBnaWFudCBkaXNjbGFpbWVyIHRoYXQgaXQgaXMgYmVzdCBl
ZmZvcnQgYW5kIG1heSBnZXQgYnJva2VuCj4gaW5hZHZlcnRlbnRseSBieSBjaGFuZ2VzIHRoYXQg
bWF5IHNlZW0gdW5yZWxhdGVkLgoKCkFscmlnaHQsIGhhcHB5IHRvIHJlc3QgbXkgY2FzZSBhYm91
dCBtYWtpbmcgaXQgbW9yZSByZWxpYWJsZSBmb3Igbm93IAp0aGVuIDopLgoKSU1ITyB0aGUgYmln
IGZhdCBkaXNjbGFpbWVyIHNob3VsZCBiZSBpbiB0aGUgYXJndW1lbnQgbmFtZS4gCiJyZXNlcnZl
X21lbSIgdG8gbWUgc291bmRzIGxpa2UgaXQgYWN0dWFsbHkgZ3VhcmFudGVlcyBhIHJlc2VydmF0
aW9uIC0gCndoaWNoIGl0IGRvZXNuJ3QuIENhbiB3ZSBuYW1lIGl0IG1vcmUgYWxvbmcgdGhlIGxp
bmVzIG9mICJkZWJ1ZyIgKHRvIAppbmRpY2F0ZSBpdCdzIG5vdCBmb3IgcHJvZHVjdGlvbiBkYXRh
KSBvciAicGhvZW5peCIgKHVzdWFsbHkgZ2V0cyByZWJvcm4gCm91dCBvZiBhc2hlcywgYnV0IHlv
dSBjYW4gbmV2ZXIga25vdyBmb3Igc3VyZSk6ICJkZWJ1Z19tZW0iLCAvIAoicGhvZW5peF9tZW0i
PwoKCj4KPj4gSWYgeW91IHN0aWNrIHRvCj4+IGFsbG9jYXRpbmcgb25seSBmcm9tIHRvcCwgeW91
J3JlIGVmZmVjdGl2ZWx5IGtlcm5lbCB2ZXJzaW9uIGluZGVwZW5kZW50Cj4+IGZvciB5b3VyIGFs
bG9jYXRpb25zIGJlY2F1c2Ugbm9uZSBvZiB0aGUga2VybmVsIGNvZGUgcmFuIHlldCBhbmQKPj4g
ZGVmaW5pdGVseSBLQVNMUiBpbmRlcGVuZGVudCBiZWNhdXNlIHlvdSdyZSBydW5uaW5nIGRldGVy
bWluaXN0aWNhbGx5Cj4+IGJlZm9yZSBLQVNMUiBldmVuIGdldHMgYWxsb2NhdGVkLgo+Pgo+IEFs
bG9jYXRpbmcgdG9wIGRvd24gdW5kZXIgRUZJIGlzIGFsbW9zdCBndWFyYW50ZWVkIHRvIHJlc3Vs
dCBpbgo+IHByb2JsZW1zLCBiZWNhdXNlIHRoYXQgaXMgaG93IHRoZSBFRkkgcGFnZSBhbGxvY2F0
b3Igd29ya3MgYXMgd2VsbC4KPiBUaGlzIG1lYW5zIHRoYXQgYWxsb2NhdGlvbnMgd2lsbCBtb3Zl
IGFyb3VuZCBkZXBlbmRpbmcgb24sIGUuZy4sCj4gd2hldGhlciBzb21lIFVTQiBzdGljayB3YXMg
aW5zZXJ0ZWQgb24gdGhlIGZpcnN0IGJvb3QgYW5kIHJlbW92ZWQgb24KPiB0aGUgc2Vjb25kLCBv
ciB3aGV0aGVyIHlvdXIgZXh0ZXJuYWwgZGlzcGxheSB3YXMgb24gb3Igb2ZmLgoKCkkgYmVsaWV2
ZSBtb3N0IFVFRkkgaW1wbGVtZW50YXRpb25zIG9ubHkgYWxsb2NhdGUgdG9wIGRvd24gaW4gdGhl
IGxvd2VyIAozMmJpdHMuIEJ1dCB5ZXMsIGl0J3MgZnJhZ2lsZSwgSSBoZWFyIHlvdS4gTGV0J3Mg
ZW1icmFjZSB0aGUgZmxha3kgCm5hdHVyZSBvZiB0aGUgYmVhc3QgdGhlbiA6KS4KCgpBbGV4CgoK
CgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3Jh
dXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNj
aGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxv
dHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1
MzggNTk3Cg==


