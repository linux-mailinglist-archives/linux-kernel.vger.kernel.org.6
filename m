Return-Path: <linux-kernel+bounces-218317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8956C90BC81
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D370928553B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACFE198E7E;
	Mon, 17 Jun 2024 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KsKpGGo4"
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630DA79CE;
	Mon, 17 Jun 2024 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658089; cv=none; b=BSluX+hlvQQM3tVGNYw/ne5uSJYGvX7kdT83pULgbNtbp/+YPxPQzHsIkMUsLWSoYJ6mBxkGy4XT7/+r+1fk16aIzxDY4An5PfOJ0qX9FSqffSNNMF1Pnlzz5L9ahEvKe1qBN8l0bm0NBO+yKoiTbEVbgv6WENqqTh73iV4hA00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658089; c=relaxed/simple;
	bh=+jerAU329B9P5FuyjVTDEtLOsYym20sBbmu5puVsEQ0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=SZMQgC2coH0SSIPgbJcpIfbdJWJdiGLt6WVWYXnd3U3CvFSUlEu0wU+T94biM9XiwxCRmwYpAEpLTCsKLluqxsgx3qkgWw01vW1obZoouN1F1TDdX0sNIkCXzr3n6clc4i32IsQMXDV3majpe3KiRNIP/9NZUJAFZSmjsymazG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KsKpGGo4; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718658087; x=1750194087;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=+jerAU329B9P5FuyjVTDEtLOsYym20sBbmu5puVsEQ0=;
  b=KsKpGGo4r33gSv83owBFKayDwz3Zj/lYQBJaGG0d30yUNqNRvGGQ2m8w
   TpvfddbBQa6QW6ygOsEz4zp6zrDUPrX1HUl+7D2b7MRUct5O0efEKsc72
   4/IwIgnhp36f16f99Xw2r5WngHZVuZj9ORJbFF9wUD9p/h4PASPOZePcl
   I=;
X-IronPort-AV: E=Sophos;i="6.08,245,1712620800"; 
   d="scan'208";a="733504241"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 21:01:21 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:28934]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.125:2525] with esmtp (Farcaster)
 id 9f6fef16-53b4-4764-8560-b3586651ba6d; Mon, 17 Jun 2024 21:01:20 +0000 (UTC)
X-Farcaster-Flow-ID: 9f6fef16-53b4-4764-8560-b3586651ba6d
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 17 Jun 2024 21:01:19 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 17 Jun
 2024 21:01:14 +0000
Message-ID: <049b2e0f-00b2-4704-8868-1569a006a134@amazon.com>
Date: Mon, 17 Jun 2024 23:01:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH v6 0/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
To: Steven Rostedt <rostedt@goodmis.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
	<akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>, "Joel
 Fernandes" <joel@joelfernandes.org>, Daniel Bristot de Oliveira
	<bristot@redhat.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, <suleiman@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Vineeth Pillai <vineeth@bitbyteword.org>, Youssef Esmat
	<youssefesmat@google.com>, Beau Belgrave <beaub@linux.microsoft.com>,
	"Baoquan He" <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, "Paul E.
 McKenney" <paulmck@kernel.org>, David Howells <dhowells@redhat.com>, Mike
 Rapoport <rppt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
References: <20240613155506.811013916@goodmis.org>
 <b0ed328f-c4e5-4e9b-ae4e-5c60703ab376@amazon.com>
 <20240613131212.7d1a7ffa@rorschach.local.home>
 <7c90c574-5cfa-40cf-bd4c-1188136cd886@amazon.com>
 <20240617164006.198b9ba3@rorschach.local.home>
Content-Language: en-US
In-Reply-To: <20240617164006.198b9ba3@rorschach.local.home>
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

W3Jlc2VuZCBiZWNhdXNlIFRodW5kZXJiaXJkIGRlY2lkZWQgdG8gc2VuZCB0aGUgcHJldmlvdXMg
dmVyc2lvbiBhcyBIVE1MIDooXQoKCk9uIDE3LjA2LjI0IDIyOjQwLCBTdGV2ZW4gUm9zdGVkdCB3
cm90ZToKPiBPbiBNb24sIDE3IEp1biAyMDI0IDA5OjA3OjI5ICswMjAwCj4gQWxleGFuZGVyIEdy
YWY8Z3JhZkBhbWF6b24uY29tPiAgd3JvdGU6Cj4KPj4gSGV5IFN0ZXZlLAo+Pgo+Pgo+PiBJIGJl
bGlldmUgd2UncmUgdGFsa2luZyBhYm91dCAyIGRpZmZlcmVudCB0aGluZ3MgOikuIExldCBtZSBy
ZXBocmFzZSBhCj4+IGJpdCBhbmQgbWFrZSBhIGNvbmNyZXRlIGV4YW1wbGUuCj4+Cj4+IEltYWdp
bmUgeW91IGhhdmUgcGFzc2VkIHRoZSAicmVzZXJ2ZV9tZW09MTJNOjQwOTY6dHJhY2UiIGtlcm5l
bCBjb21tYW5kCj4+IGxpbmUgb3B0aW9uLiBUaGUga2VybmVsIG5vdyBjb21lcyB1cCBhbmQgYWxs
b2NhdGVzIGEgcmFuZG9tIGNodW5rIG9mCj4+IG1lbW9yeSB0aGF0IC0gYnkgKGFkbWl0dGVkbHkg
Z29vZCkgY2hhbmNlIC0gbWF5IGJlIGF0IHRoZSBzYW1lIHBoeXNpY2FsCj4+IGxvY2F0aW9uIGFz
IGJlZm9yZS4gTGV0J3MgYXNzdW1lIGl0IGRlZW1lZCAweDEwMDAwMDAgYXMgYSBnb29kIG9mZnNl
dC4KPiBOb3RlLCBpdCdzIG5vdCByYW5kb20uIEl0IHBpY2tzIGZyb20gdGhlIHRvcCBvZiBhdmFp
bGFibGUgbWVtb3J5IGV2ZXJ5Cj4gdGltZS4gQnV0IHRoaW5ncyBjYW4gbWVzcyB3aXRoIGl0IChz
ZWUgYmVsb3cpLgo+Cj4+IExldCdzIG5vdyBhc3N1bWUgeW91J3JlIHJ1bm5pbmcgb24gYSBVRUZJ
IHN5c3RlbS4gVGhlcmUsIHlvdSBhbHdheXMgaGF2ZQo+PiBub24tdm9sYXRpbGUgc3RvcmFnZSBh
dmFpbGFibGUgdG8geW91IGV2ZW4gaW4gdGhlIHByZS1ib290IHBoYXNlLiBUaGF0Cj4+IG1lYW5z
IHRoZSBrZXJuZWwgY291bGQgY3JlYXRlIGEgVUVGSSB2YXJpYWJsZSB0aGF0IHNheXMgIjEyTTo0
MDk2OnRyYWNlCj4+IC0+IDB4MTAwMDAwMCIuIFRoZSBwcmUtYm9vdCBwaGFzZSB0YWtlcyBhbGwg
dGhlc2UgVUVGSSB2YXJpYWJsZXMgYW5kCj4+IG1hcmtzIHRoZW0gYXMgcmVzZXJ2ZWQuIFdoZW4g
eW91IGZpbmFsbHkgcmVhY2ggeW91ciBjb21tYW5kIGxpbmUgcGFyc2luZwo+PiBsb2dpYyBmb3Ig
cmVzZXJ2ZV9tZW09LCB5b3UgY2FuIGZsaXAgYWxsIHJlc2VydmF0aW9ucyB0aGF0IHdlcmUgbm90
IG9uCj4+IHRoZSBjb21tYW5kIGxpbmUgYmFjayB0byBub3JtYWwgbWVtb3J5Lgo+Pgo+PiBUaGF0
IHdheSB5b3UgaGF2ZSBwcmV0dHkgbXVjaCBndWFyYW50ZWVkIHBlcnNpc3RlbnQgbWVtb3J5IHJl
Z2lvbnMsIGV2ZW4KPj4gd2l0aCBLQVNMUiBjaGFuZ2luZyB5b3VyIG1lbW9yeSBsYXlvdXQgYWNy
b3NzIGJvb3RzLgo+Pgo+PiBUaGUgbmljZSB0aGluZyBpcyB0aGF0IHRoZSBhYm92ZSBpcyBhbiBl
eHRlbnNpb24gb2Ygd2hhdCB5b3UndmUgYWxyZWFkeQo+PiBidWlsdDogU3lzdGVtcyB3aXRoIFVF
Rkkgc2ltcGx5IGdldCBiZXR0ZXIgZ3VhcmFudGVlcyB0aGF0IHRoZWlyIHJlZ2lvbnMKPj4gcGVy
c2lzdC4KPiBUaGlzIGNvdWxkIGJlIGFuIGFkZGVkIGZlYXR1cmUsIGJ1dCBpdCBpcyB2ZXJ5IGFy
Y2hpdGVjdHVyZSBzcGVjaWZpYywKPiBhbmQgd291bGQgbGlrZWx5IG5lZWQgYXJjaGl0ZWN0dXJl
IHNwZWNpZmljIHVwZGF0ZXMuCgoKSXQgZGVmaW5pdGVseSB3b3VsZCBiZSBhbiBhZGRlZCBmZWF0
dXJlLCB5ZXMuIEJ1dCBvbmUgdGhhdCBhbGxvd3MgeW91IHRvIAplbnN1cmUgcGVyc2lzdGVuY2Ug
YSBsb3QgbW9yZSBzYWZlbHkgOikuCgoKPj4+Pj4gUmVxdWlyZW1lbnQ6Cj4+Pj4+Cj4+Pj4+IE5l
ZWQgYSB3YXkgdG8gcmVzZXJ2ZSBtZW1vcnkgdGhhdCB3aWxsIGJlIGF0IGEgY29uc2lzdGVudCBs
b2NhdGlvbiBmb3IKPj4+Pj4gZXZlcnkgYm9vdCwgaWYgdGhlIGtlcm5lbCBhbmQgc3lzdGVtIGFy
ZSB0aGUgc2FtZS4gRG9lcyBub3QgbmVlZCB0byB3b3JrCj4+Pj4+IGlmIHJlYm9vdGluZyB0byBh
IGRpZmZlcmVudCBrZXJuZWwsIG9yIGlmIHRoZSBzeXN0ZW0gY2FuIGNoYW5nZSB0aGUKPj4+Pj4g
bWVtb3J5IGxheW91dCBiZXR3ZWVuIGJvb3RzLgo+Pj4+Pgo+Pj4+PiBUaGUgcmVzZXJ2ZWQgbWVt
b3J5IGNhbiBub3QgYmUgYW4gaGFyZCBjb2RlZCBhZGRyZXNzLCBhcyB0aGUgc2FtZSBrZXJuZWwg
Lwo+Pj4+PiBjb21tYW5kIGxpbmUgbmVlZHMgdG8gcnVuIG9uIHNldmVyYWwgZGlmZmVyZW50IG1h
Y2hpbmVzLiBUaGUgcGlja2VkIG1lbW9yeQo+Pj4+PiByZXNlcnZhdGlvbiBqdXN0IG5lZWRzIHRv
IGJlIHRoZSBzYW1lIGZvciBhIGdpdmVuIG1hY2hpbmUsIGJ1dCBtYXkgYmUKPj4+PiBXaXRoIEtB
U0xSIGlzIGVuYWJsZWQsIGRvZXNuJ3QgdGhpcyBhcHByb2FjaCBicmVhayB0b28gb2Z0ZW4gdG8g
YmUKPj4+PiByZWxpYWJsZSBlbm91Z2ggZm9yIHRoZSBkYXRhIHlvdSB3YW50IHRvIGV4dHJhY3Q/
Cj4+Pj4KPj4+PiBQaWNraW5nIHVwIHRoZSBpZGVhIGFib3ZlLCB3aXRoIGEgcGVyc2lzdGVudCB2
YXJpYWJsZSB3ZSBjb3VsZCBldmVuIG1ha2UKPj4+PiBLQVNMUiBhdm9pZCB0aGF0IHJlc2VydmVk
IHBzdG9yZSByZWdpb24gaW4gaXRzIHNlYXJjaCBmb3IgYSB2aWFibGUgS0FTTFIKPj4+PiBvZmZz
ZXQuCj4+PiBJIHRoaW5rIEkgd2FzIGhpdCBieSBpdCBvbmNlIGluIGFsbCBteSB0ZXN0aW5nLiBG
b3Igb3VyIHVzZSBjYXNlLCB0aGUKPj4+IGZldyB0aW1lcyBpdCBmYWlscyB0byBtYXAgaXMgbm90
IGdvaW5nIHRvIGFmZmVjdCB3aGF0IHdlIG5lZWQgdGhpcyBmb3IKPj4+IGF0IGFsbC4KPj4gT25j
ZSBpcyBwcmV0dHkgZ29vZC4gRG8geW91IGtub3cgd2h5PyBBbHNvIG9uY2Ugb3V0IG9mIGhvdyBt
YW55IHJ1bnM/IElzCj4+IHRoZSByYW5kb21uZXNzIHNvdXJjZSBub3QgYXMgcmFuZG9tIGFzIGl0
IHNob3VsZCBiZSBvciBhcmUgdGhlIG51bWJlciBvZgo+PiBiaXRzIGZvciBLQVNMUiBtYXliZSBz
byBmZXcgb24geW91ciB0YXJnZXQgYXJjaGl0ZWN0dXJlIHRoYXQgdGhlIG9kZHMgb2YKPj4gaGl0
dGluZyBhbnl0aGluZyBiZWNvbWUgbG93PyBEbyB0aGVzZSBzYW1lIGNvbnN0cmFpbnRzIGhvbGQg
dHJ1ZSBvdXRzaWRlCj4+IG9mIHlvdXIgdGVzdGluZyBlbnZpcm9ubWVudD8KPiBTbyBJIGp1c3Qg
cmFuIGl0IGEgaHVuZHJlZCB0aW1lcyBpbiBhIGxvb3AuIEkgYWRkZWQgYSBwYXRjaCB0byBwcmlu
dAo+IHRoZSBsb2NhdGlvbiBvZiAiX3RleHQiLiBUaGUgbG9vcCB3YXMgdGhpczoKPgo+ICAgIGZv
ciBpIGluIGBzZXEgMTAwYDsgZG8KPiAgICAgICAgICBzc2ggcm9vdEBkZWJpYW50ZXN0aW5nLXg4
Ni02NCAiZG1lc2cgfCBncmVwIC1lICd0ZXh0IHN0YXJ0cycgLWUgJ21hcHBlZCBib290JyAgPj4g
dGV4dDsgZ3J1Yi1yZWJvb3QgJzE+MCc7IHNsZWVwIDAuNTsgcmVib290Igo+ICAgICAgICAgIHNs
ZWVwIDI1Cj4gICAgZG9uZQo+Cj4gSXQgc2VhcmNoZXMgZG1lc2cgZm9yIG15IGFkZGVkIHByaW50
ayBhcyB3ZWxsIGFzIHRoZSBwcmludCBvZiB3ZXJlIHRoZQo+IHJpbmcgYnVmZmVyIHdhcyBsb2Fk
ZWQgaW4gcGh5c2ljYWwgbWVtb3J5Lgo+Cj4gSXQgdGFrZXMgYWJvdXQgMTUgc2Vjb25kcyB0byBy
ZWJvb3QsIHNvIEkgd2FpdGVkIDI1LiBUaGUgcmVzdWx0cyBhcmUKPiBhdHRhY2hlZC4gSSBmb3Vu
ZCB0aGF0IGl0IHdhcyBjb25zaXN0ZW50IDc2IHRpbWVzLCB3aGljaCBtZWFucyAxIG91dCBvZgo+
IDQgaXQncyBub3QuIEZ1bm55IGVub3VnaCwgaXQgYnJva2Ugd2hlbmV2ZXIgaXQgbG9hZGVkIHRo
ZSBrZXJuZWwgYmVsb3cKPiAweDEwMDAwMDAwMC4gQW5kIHRoZW4gaXQgd291bGQgYmUgb2ZmIGJ5
IGEgbGl0dGxlLgo+Cj4gSXQgd2FzIGNvbnNpc3RlbnRseSBhdDoKPgo+ICAgIDB4MjdkMDAwMDAw
Cj4KPiBBbmQgd2hlbiBpdCBmYWlsZWQsIGl0IHdhcyBhdCAweDI3Y2UwMDAwMC4KPgo+IE5vdGUs
IHdoZW4gSSB1c2VkIHRoZSBlODIwIHRhYmxlcyB0byBkbyB0aGlzLCBJIG5ldmVyIHNhdyBhIGZh
aWx1cmUuIE15Cj4gYXNzdW1wdGlvbiBpcyB0aGF0IHdoZW4gaXQgaXMgYmVsb3cgMHgxMDAwMDAw
MDAsIHNvbWV0aGluZyBlbHNlIGdldHMKPiBhbGxvY2F0ZWQgY2F1c2luZyB0aGlzIHRvIGdldCBw
dXNoZWQgZG93bi4KCgpUaGlua2luZyBhYm91dCBpdCBhZ2FpbjogV2hhdCBpZiB5b3UgcnVuIHRo
ZSBhbGxvY2F0aW9uIHN1cGVyIGVhcmx5IChzZWUgCmFyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9r
YXNsci5jOmhhbmRsZV9tZW1fb3B0aW9ucygpKT8gSWYgeW91IHN0aWNrIHRvIAphbGxvY2F0aW5n
IG9ubHkgZnJvbSB0b3AsIHlvdSdyZSBlZmZlY3RpdmVseSBrZXJuZWwgdmVyc2lvbiBpbmRlcGVu
ZGVudCAKZm9yIHlvdXIgYWxsb2NhdGlvbnMgYmVjYXVzZSBub25lIG9mIHRoZSBrZXJuZWwgY29k
ZSByYW4geWV0IGFuZCAKZGVmaW5pdGVseSBLQVNMUiBpbmRlcGVuZGVudCBiZWNhdXNlIHlvdSdy
ZSBydW5uaW5nIGRldGVybWluaXN0aWNhbGx5IApiZWZvcmUgS0FTTFIgZXZlbiBnZXRzIGFsbG9j
YXRlZC4KCj4gQXMgdGhpcyBjb2RlIHJlbGllcyBvbiBtZW1ibG9ja19waHlzX2FsbG9jKCkgYmVp
bmcgY29uc2lzdGVudCwgaWYKPiBzb21ldGhpbmcgZ2V0cyBhbGxvY2F0ZWQgYmVmb3JlIGl0IGRp
ZmZlcmVudGx5IGRlcGVuZGluZyBvbiB3aGVyZSB0aGUKPiBrZXJuZWwgaXMsIGl0IGNhbiBhbHNv
IG1vdmUgdGhlIGxvY2F0aW9uLiBBIHBsdWdpbiB0byBVRUZJIHdvdWxkIG1lYW4KPiB0aGF0IGl0
IHdvdWxkIG5lZWQgdG8gcmVzZXJ2ZSB0aGUgbWVtb3J5LCBhbmQgdGhlIGNvZGUgaGVyZSB3aWxs
IG5lZWQKPiB0byBrbm93IHdoZXJlIGl0IGlzLiBXZSBjb3VsZCBhbHdheXMgbWFrZSB0aGUgZnVu
Y3Rpb24gcmVzZXJ2ZV9tZW0oKQo+IGdsb2JhbCBhbmQgd2VhayBzbyB0aGF0IGFyY2hpdGVjdHVy
ZXMgY2FuIG92ZXJyaWRlIGl0LgoKClllcywgdGhlIGluLWtlcm5lbCBVRUZJIGxvYWRlciAoZWZp
LXN0dWIpIGNvdWxkIHNpbXBseSBwb3B1bGF0ZSBhIG5ldyAKdHlwZSBvZiBtZW1ibG9jayB3aXRo
IHRoZSByZXNwZWN0aXZlIHJlc2VydmF0aW9ucyBhbmQgeW91IGxhdGVyIGNhbGwgCm1lbWJsb2Nr
X2ZpbmRfaW5fcmFuZ2Vfbm9kZSgpIGluc3RlYWQgb2YgbWVtYmxvY2tfcGh5c19hbGxvYygpIHRv
IHBhc3MgCmluIGZsYWdzIHRoYXQgeW91IHdhbnQgdG8gYWxsb2NhdGUgb25seSBmcm9tIHRoZSBu
ZXcgCk1FTUJMT0NLX1JFU0VSVkVfTUVNIHR5cGUuIFRoZSBzYW1lIG1vZGVsIHdvdWxkIHdvcmsg
Zm9yIEJJT1MgYm9vdHMgCnRocm91Z2ggdGhlwqBoYW5kbGVfbWVtX29wdGlvbnMoKSBwYXRoIGFi
b3ZlLiBJbiBmYWN0LCBpZiB0aGUgQklPUyB3YXkgCndvcmtzIGZpbmUsIHdlIGRvbid0IGV2ZW4g
bmVlZCBVRUZJIHZhcmlhYmxlczogVGhlIHNhbWUgd2F5IGFsbG9jYXRpb25zIAp3aWxsIGJlIGlk
ZW50aWNhbCBkdXJpbmcgQklPUyBleGVjdXRpb24sIHRoZXkgc2hvdWxkIHN0YXkgaWRlbnRpY2Fs
IAphY3Jvc3MgVUVGSSBsYXVuY2hlcy4KCkFzIGNoZXJyeSBvbiB0b3AsIGtleGVjIGFsc28gd29y
a3Mgc2VhbWxlc3NseSB3aXRoIHRoZSBzcGVjaWFsIG1lbWJsb2NrIAphcHByb2FjaCBiZWNhdXNl
IGtleGVjIChhdCBsZWFzdCBvbiB4ODYpIGhhbmRzIG1lbWJsb2NrcyBhcyBpcyB0byB0aGUgCm5l
eHQga2VybmVsLiBTbyB0aGUgbmV3IGtlcm5lbCB3aWxsIGFsc28gYXV0b21hdGljYWxseSB1c2Ug
dGhlIHNhbWUgCnJhbmdlcyBmb3IgaXRzIGFsbG9jYXRpb25zLgoKCkFsZXgKCgoKCkFtYXpvbiBX
ZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAz
OAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBK
b25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1
bnRlciBIUkIgMjU3NzY0IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK


