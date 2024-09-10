Return-Path: <linux-kernel+bounces-322581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EF9972B21
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26871F250E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE3B18308E;
	Tue, 10 Sep 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="stZX+HeI"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB041514DA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954483; cv=none; b=uWM9CdTSAxfZhTbKGRGv6wCwGPzXTE3PBdfqlbHY3hDwla5/MSLYjMTZaWsC/ZMVOAFNryvoiQT3Ma/9FFekVWJjOPQ8j2nLj539vJoTUQIHEeDa7PhPiyhO7GH754/23uIA4PaL0FlYBy2qSdPDCTgK1bZIthBg0PNwhVfqJZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954483; c=relaxed/simple;
	bh=wxWwHk0nwc2H9qd/VUc1E7GvAr+7m/sH/Q5oxnmNf6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=McE2opnztLqtv8TJZ3YoQk5Et8rgHZreB/ORrz8jQNEIJX9O0eZvUHAJ6D/WoNO5zSjzenz6uc+TbjZVNIjg7uMS7IOcguCbIJa7rMTup/X+a9cFQIgCxwfFQh2nSbTjpvry6CD8/eskrVQOjIIUHG/g7IFwa256fLbzInKIoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=stZX+HeI; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725954482; x=1757490482;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wxWwHk0nwc2H9qd/VUc1E7GvAr+7m/sH/Q5oxnmNf6g=;
  b=stZX+HeI95GOPsm4NOWlbLstRWc+THPqsKFzlgCPBA4v8FS/davtq+nj
   /esoT3VSVNR49FUde9WWLezo+QtZPP5ZgpC1s5BTkfr7sk68UTfbmBTgu
   siyIeUYo0pUrDH8hZ09v9oyrGZK3jbpKztaUV/GEQjBiwO5vP4dy8Yngl
   0=;
X-IronPort-AV: E=Sophos;i="6.10,216,1719878400"; 
   d="scan'208";a="432364489"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 07:47:58 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:11295]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.54:2525] with esmtp (Farcaster)
 id 7cd07189-687a-42b6-ad96-7297ba812e56; Tue, 10 Sep 2024 07:47:57 +0000 (UTC)
X-Farcaster-Flow-ID: 7cd07189-687a-42b6-ad96-7297ba812e56
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 07:47:57 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Tue, 10 Sep 2024
 07:47:54 +0000
Message-ID: <d49a9768-fc9c-4df7-ba11-5b25470f6feb@amazon.com>
Date: Tue, 10 Sep 2024 09:47:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
To: "Xing, Cedric" <cedric.xing@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, Lukas Wunner
	<lukas@wunner.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, Qinkun Bao
	<qinkun@google.com>, Mikko Ylinen <mikko.ylinen@linux.intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <10ffa4f1-e3f9-4b7d-9a6f-e4dd843f6d44@amazon.com>
 <b1965018-6663-4bf5-b8e0-8210d0429333@intel.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <b1965018-6663-4bf5-b8e0-8210d0429333@intel.com>
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDA5LjA5LjI0IDE2OjU1LCBYaW5nLCBDZWRyaWMgd3JvdGU6Cj4gSGkgQWxleCwKPgo+IFRo
YW5rcyBmb3IgeW91IGNvbW1lbnRzIQo+Cj4gT24gOS84LzIwMjQgMTI6MzcgUE0sIEFsZXhhbmRl
ciBHcmFmIHdyb3RlOgo+PiBIZXkgQ2VkcmljLAo+Pgo+PiBPbiAwOC4wOS4yNCAwNjo1NiwgQ2Vk
cmljIFhpbmcgd3JvdGU6Cj4+PiBOT1RFOiBUaGlzIHBhdGNoIHNlcmllcyBpbnRyb2R1Y2VzIHRo
ZSBNZWFzdXJlbWVudCBSZWdpc3RlciAoTVIpIEFCSSwKPj4+IGFuZCBpcwo+Pj4gbGFyZ2VseSBh
IGNvbnRpbnVhdGlvbiBvZiBTYW11ZWwgT3J0aXrigJlzIHByZXZpb3VzIHdvcmsgb24gdGhlIFJU
TVIgQUJJCj4+PiBbMV0uCj4+Pgo+Pj4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBhIHVuaWZpZWQg
aW50ZXJmYWNlIHRvIFRTTSBjb3JlIGZvciBjb25maWRlbnRpYWwKPj4+IGNvbXB1dGluZyAoQ0Mp
IGd1ZXN0IGRyaXZlcnMgdG8gcHJvdmlkZSBhY2Nlc3MgdG8gbWVhc3VyZW1lbnQKPj4+IHJlZ2lz
dGVycyAoTVJzKSwKPj4+IHdoaWNoIGFyZSBlc3NlbnRpYWwgZm9yIHJlbHlpbmcgcGFydGllcyAo
UlBzKSB0byB2ZXJpZnkgdGhlIGludGVncml0eQo+Pj4gb2YgdGhlCj4+PiBjb21wdXRpbmcgZW52
aXJvbm1lbnQuIFRoZSBpbnRlcmZhY2UgaXMgc3RydWN0dXJlZCBhcm91bmQKPj4+IGBzdHJ1Y3Qg
dHNtX21lYXN1cmVtZW50X3Byb3ZpZGVyYCwgd2hpY2ggaG9sZHMgYW4gYXJyYXkgb2YKPj4+IGBz
dHJ1Y3QgdHNtX21lYXN1cmVtZW50X3JlZ2lzdGVyYCBhbmQgaW5jbHVkZXMgb3BlcmF0aW9ucyBm
b3IgCj4+PiByZWFkaW5nIGFuZAo+Pj4gdXBkYXRpbmcgTVJzLgo+Pj4KPj4+IFRoZSBNUnMgY29t
ZSBpbiB0d28gdmFyaWV0aWVzOiBzdGF0aWMgYW5kIHJ1bnRpbWUuIFN0YXRpYyBNUnMgYXJlCj4+
PiBkZXRlcm1pbmVkIGF0Cj4+PiB0aGUgVEVFIFZNIChUVk0pIGJ1aWxkIHRpbWUgYW5kIGNhcHR1
cmUgdGhlIGluaXRpYWwgbWVtb3J5IGltYWdlIG9yIHRoZQo+Pj4gY29uZmlndXJhdGlvbi9wb2xp
Y3kgc3BlY2lmaWVkIGJ5IHRoZSBUVk0ncyBvd25lci4gSW4gY29udHJhc3QsCj4+PiBSdW50aW1l
IE1Scwo+Pj4gKFJUTVJzKSBzdGFydCB3aXRoIGtub3duIHZhbHVlcywgc3VjaCBhcyBhbGwgemVy
b3MsIGF0IFRWTSBidWlsZCB0aW1lCj4+PiBhbmQgYXJlCj4+PiBleHRlbmRlZCB3aXRoIG1lYXN1
cmVtZW50cyBvZiBsb2FkZWQgY29kZSwgZGF0YSwgY29uZmlndXJhdGlvbiwgb3IKPj4+IGV4ZWN1
dGVkCj4+PiBhY3Rpb25zIGJ5IHRoZSBUVk0gZ3Vlc3QgZHVyaW5nIHJ1bnRpbWUuCj4+Cj4+Cj4+
IElzIHRoZXJlIGEgcGFydGljdWxhciByZWFzb24gdG8gdHJlYXQgcnVudGltZSBhbmQgc3RhdGlj
IG1lYXN1cmVtZW50cwo+PiBzZXBhcmF0ZWx5PyBJbiBOaXRybyBFbmNsYXZlcyAod2hpY2ggSSBz
dGlsbCBuZWVkIHRvIGFkZCB0c20gaW50ZWdyYXRpb24KPj4gZm9yKSwgYm90aCBhcmUgc2ltcGx5
IE5TTSBQQ1JzLiAiU3RhdGljIiBtZWFzdXJlbWVudHMgZ2V0IGxvY2tlZCBieSB0aGUKPj4gaW5p
dGlhbCBib290IGNvZGUuICJSdW50aW1lIiBtZWFzdXJlbWVudHMgY2FuIGdldCBsb2NrZWQgYnkg
Z3Vlc3QgY29kZQo+PiBsYXRlciBpbiB0aGUgYm9vdCBwcm9jZXNzLiBCdXQgdGVjaG5pY2FsbHks
IGJvdGggYXJlIHRoZSBzYW1lIHR5cGUgb2YKPj4gbWVhc3VyZW1lbnQuCj4+Cj4gTXkgYXBvbG9n
aWVzIGZvciB0aGUgY29uZnVzaW9uISBUaGV5IGFyZSBpbiBmYWN0IHRyZWF0ZWQgaW4gdGhlIHNh
bWUgd2F5Cj4gZnJvbSB0aGUgQ0MgZ3Vlc3QgZHJpdmVyJ3MgcGVyc3BlY3RpdmUuCgoKSSdtIG5v
dCB3b3JyaWVkIGFib3V0IHRoZSBkcml2ZXIncyBwZXJzcGVjdGl2ZSB0byBiZSBob25lc3Q7IEkn
bSBtdWNoIAptb3JlIGludGVyZXN0ZWQgaW4gdGhlIHVzZXIgc3BhY2UgQUJJIGFuZCB0byBlbnN1
cmUgaXQncyBjb25zaXN0ZW50IGFuZCAKZmxleGlibGUgOikuCgoKPiBIZXJlIEkgbWVhbnQgdG8g
ZGVzY3JpYmUgdGhhdCBzdGF0aWMgYW5kIHJ1bnRpbWUgTVJzIGhhdmUgZGlmZmVyZW50Cj4gcHJv
cGVydGllcyAobGlrZSAibG9ja2VkIiBhcyB5b3UgbWVudGlvbmVkKSBzbyBpbiBvcmRlciB0byB0
cmVhdCB0aGVtIGluCj4gdGhlIHNhbWUgd2F5LCB3ZSdkIGhhdmUgdG8gZGVmaW5lIHRoZSBwcm9w
ZXJ0aWVzIGluIGNvZGUgKGkuZS4sIGBlbnVtCj4gdHNtX21lYXN1cmVtZW50X3JlZ2lzdGVyX2Zs
YWdgIGluIGluY2x1ZGUvbGludXgvdHNtLmgpLgo+Cj4+IEluIGZhY3QsIG90aGVyIGF0dHJpYnV0
ZXMgbGlrZSBhbiBhZGRpdGlvbmFsICJoYXNoX2FsZ28iIHRvIHRoZQo+PiBtZWFzdXJlbWVudCBp
dHNlbGYgY2FuIGJlIHVzZWZ1bCBpbiBnZW5lcmFsLiBJZiB0aGUgdW5kZXJseWluZwo+PiBpbmZy
YXN0cnVjdHVyZSBhbGxvd3MgZm9yIGEgZ2VuZXJpYyBldmVudCBsb2cgbWVjaGFuaXNtLCBoYXZp
bmcgdGhhdAo+PiBlYXNpbHkgYXZhaWxhYmxlIGhlcmUgaXMgdXNlZnVsIHRvby4KPj4KPiBgaGFz
aF9hbGdvYCBpcyBpbmRlZWQgYSBtZW1iZXIgb2YgYHN0cnVjdCB0c21fbWVhc3VyZW1lbnRfcmVn
aXN0ZXJgLgo+Cj4+IFNvIEkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgd2h5IHdlIHdvdWxkIHRy
ZWF0IHN0YXRpYyBhbmQgcnVudGltZQo+PiBtZWFzdXJlbWVudHMgZGlmZmVyZW50bHkuIENhbid0
IHdlIGp1c3QgbWFrZSBhbGwgb2YgdGhlbSBkaXJlY3RvcmllcyBhbmQKPj4gaW5kaWNhdGUgd2hl
dGhlciB0aGV5IGFyZSAoaW0tKW11dGFibGUgdmlhIGEgZmlsZT8KPj4KPiBEaXN0aW5ndWlzaGlu
ZyB0aGVtIGluIHRoZSB1c2VyIGludGVyZmFjZSBtYWtlcyBlbnVtZXJhdGlvbiBvZiBSVE1Scwo+
IGVhc2llci4gQWxzbywgdGhlcmUgYXJlIFJUTVIgc3BlY2lmaWMgYXJ0aWZhY3RzIHRoYXQgc3Rh
dGljIE1ScyBkb24ndAo+IGhhdmUuIFRoZSBtb3N0IG9idmlvdXMgaXMgdGhlIGBldmVudF9sb2dg
LiBgaGFzaF9hbGdvYCBpcyBsZXNzIG9idmlvdXMKPiBidXQgaXQgaXMgaW4gZmFjdCBhcHBsaWNh
YmxlIHRvIFJUTVJzIG9ubHkgKHRoZSBvbmx5IHRoaW5nIHRoYXQgYSBzdGF0aWMKPiBNUiBoYXMg
aXMgaXRzIHZhbHVlKS4gQWRkaW5nIHRob3NlIHRvIHN0YXRpYyBNUnMgd291bGQgY29uZnVzZSB1
c2Vycy4KCgpJIHRoaW5rIHRoYXQgdGhpcyBzdGF0ZW1lbnQgaXMgbG9va2luZyB0b28gbXVjaCBh
dCB0aGUgcHJvYmxlbSB3aXRoIFREWCAKZ2xhc3NlcyBvbi4gQ29uY2VwdHVhbGx5LCBtZWFzdXJl
bWVudHMgY2FuIGhhcHBlbiBhdCBhbnkgdGltZSBieSBhbnkgCmNvbXBvbmVudCBhbmQgdGhlbiBn
ZXQgbG9ja2VkIGdvaW5nIGZvcndhcmQuIExldCdzIGxvb2sgYSBiaXQgYXQgd2hhdCAKZGlmZmVy
ZW50IHNvbHV0aW9ucyBkbzoKClREWAoKc3RhdGljIC0gc3BlY2lhbCByZWdpc3RlcnMgdGhhdCBn
ZXQgd3JpdHRlbiBieSB0aGUgc2VjdXJlIG1vZHVsZSBhbmQgYXJlIApsb2NrZWQgYXQgbGF1bmNo
ICg/KTsgU0hBMjU2PyBObyBldmVudCBsb2c7IG9yZGVyIGRlZmluZWQgYnkgcGxhdGZvcm0uCmR5
bmFtaWMgLSBzcGVjaWFsIHJlZ2lzdGVycyB0aGF0IGFyZSBtdXRhYmxlIGF0IHJ1bnRpbWUKClNF
Vi1TTlAKCnN0YXRpYyAtIGxhdW5jaCBkaWdlc3QgZ2VuZXJhdGVkIGJ5IEFTUCBhdCBsYXVuY2gg
dGltZSB1c2luZyBhIFNFVi1TTlAgCnNwZWNpZmljIGFsZ29yaXRobS4gTm8gZXZlbnQgbG9nOyBv
cmRlciBkZWZpbmVkIGJ5IHBsYXRmb3JtLgpkeW5hbWljIC0gbm90IHNwZWNpZmllZCwgd291bGQg
YmUgaW1wbGVtZW50ZWQgYnkgYW4gU1ZTTQoKTml0cm8gRW5jbGF2ZXMKCnN0YXRpYyAtIFBDUjAt
MTUgZ2V0IGNhbGN1bGF0ZWQgYW5kIHRoZW4gbG9ja2VkIGJ5IHRoZSBib290IGxvYWRlci4gClNI
QTM4NC4gTm8gZXZlbnQgbG9nOyBtZWNoYW5pY3MgdG8gcmVwcm9kdWNlIGFyZSBkZWZpbmVkIGlu
IGRvY3MuCmR5bmFtaWMgLSBQQ1IxNi0zMSBhcmUgdXAgZm9yIGN1c3RvbWVyIHVzZSBhbmQgY2Fu
IGJlIGxvY2tlZCBhdCBhbnkgCmxhdGVyIHN0YWdlLiBTSEEzODQuIEV2ZW50IGxvZyBpcyB1bmRl
ZmluZWQgYW5kIHVwIHRvIGN1c3RvbWVyIGNvZGUuCgoKQWxsIHN0YXRpYyBjYWxjdWxhdGlvbnMg
YXJlIGJhc2VkIG9uIHNvbWUgYWxnb3JpdGhtLiBZZXMsIHRoZSBhbGdvcml0aG0gCmlzbid0IG5l
Y2Vzc2FyaWx5IGEgc3RhbmRhcmQgZGlnZXN0LCBidXQgdGhleSBjYW4gYWxsIGhhdmUgYSBuYW1l
LiBJIGNhbiAKYWxzbyBhYnNvbHV0ZWx5IHNlZSBob3cgYW55IG9mIHRoZSBzb2x1dGlvbnMgYWJv
dmUgZ2FpbiBldmVudCBsb2cgCnN1cHBvcnQgZm9yIHN0YXRpYyBvciBkeW5hbWljIG1lYXN1cmVt
ZW50cy4gQXQgdGhlIGVuZCBvZiB0aGUgZGF5LCBhbiAKZXZlbnQgbG9nIGZvciBzdGF0aWMgbWVh
c3VyZW1lbnRzIGlzIGp1c3QgYSBtYXR0ZXIgb2Ygd3JpdGluZyBpdCBvdXQgYXQgCmxhdW5jaCB0
aW1lLgoKU28gd2hhdCBJJ20gdHJ5aW5nIHRvIHNheSBpczogSW4gdGhlIHVzZXIgc3BhY2UgQUJJ
IChmaWxlIHN5c3RlbSAKbGF5b3V0KSwgcGxlYXNlIHRyZWF0IHN0YXRpYyBhbmQgZHluYW1pYyBy
ZWdpc3RlcnMgaWRlbnRpY2FsbHkuIFRoZXJlIApyZWFsbHkgaXMgbm8gZGlmZmVyZW5jZSBiZXR3
ZWVuIHRoZW0gYXBhcnQgZnJvbSB0aGUgZmFjdCB0aGF0IHNvbWUgYXJlIApyZWFkLW9ubHkgYW5k
IG90aGVycyBhcmUgcmVhZC13cml0ZS4KCgpBbGV4CgoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERl
dmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGlu
Ckdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MK
RWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2
NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==


