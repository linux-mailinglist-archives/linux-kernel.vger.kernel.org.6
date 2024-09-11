Return-Path: <linux-kernel+bounces-324289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795D9974AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E87428724A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211DF13CF9E;
	Wed, 11 Sep 2024 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QvxB+PTe"
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5247B13C827
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037805; cv=none; b=BQU+V2ng9vcoMhUutwzI1Ds8cX/VK2Itv8N5eQC4Ia4zYbu1q98pO35SeYJCjVd+2Vi2WNatPm1QrlFzRO+7HLe88tZKTwxqwrksfTyEhCIWHkuCrA12K/DqpytmMU2cJN6NXI2agZulg9askMwNWlRMH5TN4E5iD/yqFMYYzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037805; c=relaxed/simple;
	bh=qvn4r1RONgmoM3Tr/THmjuRLo5Ei/FnD6FvxmlbwpoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=reb6cRs+5njjtLAkCg71KR1JQugCC2/a/qS6qcNZ303QmYwBfROnnmF+DubVJLWJUlFp53SckgQ+wXjgxmEk6pFUrnBsJJqbq8gb+gFH4L0JFChADgLxs8qtWNrNjM8coslnMeaSAtWUu/EOnhg25DP/rTMZImsbfStCX0Pv2+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QvxB+PTe; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1726037804; x=1757573804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qvn4r1RONgmoM3Tr/THmjuRLo5Ei/FnD6FvxmlbwpoU=;
  b=QvxB+PTeyyYac/OKYOeQTlE3pafOEtbm6ik0xSbBtM4zac+dWgK/YW0E
   ih2yecO0EaS14p5N/FFG5mMPpVLZfl9BvWr4A7KbFCOqN3cV+8Q/bKs5S
   f1siCM/I9wnkrydrZGHUnJTAwKqjXUZ/mUxyZpZ7438yyAPJ5Yefb/4Si
   8=;
X-IronPort-AV: E=Sophos;i="6.10,219,1719878400"; 
   d="scan'208";a="231101018"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 06:56:30 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:13075]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.152:2525] with esmtp (Farcaster)
 id 4d025c25-aaec-40b0-9f17-e07b1bae2c78; Wed, 11 Sep 2024 06:56:25 +0000 (UTC)
X-Farcaster-Flow-ID: 4d025c25-aaec-40b0-9f17-e07b1bae2c78
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 11 Sep 2024 06:56:25 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Wed, 11 Sep 2024
 06:56:21 +0000
Message-ID: <51c009c7-e2ee-4753-89c8-6157d2cd49fa@amazon.com>
Date: Wed, 11 Sep 2024 08:56:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
To: "Xing, Cedric" <cedric.xing@intel.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>
CC: Dan Williams <dan.j.williams@intel.com>, Samuel Ortiz
	<sameo@rivosinc.com>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, Lukas Wunner <lukas@wunner.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>,
	Mikko Ylinen <mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <suzuki.poulose@arm.com>,
	<sami.mujawar@arm.com>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <20240910170959.GA213064@myrica>
 <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDExLjA5LjI0IDA2OjAxLCBYaW5nLCBDZWRyaWMgd3JvdGU6Cj4KPiBPbiA5LzEwLzIwMjQg
MTI6MDkgUE0sIEplYW4tUGhpbGlwcGUgQnJ1Y2tlciB3cm90ZToKPj4gSGkgQ2VkcmljLAo+Pgo+
PiBPbiBTYXQsIFNlcCAwNywgMjAyNCBhdCAxMTo1NjoxOFBNIC0wNTAwLCBDZWRyaWMgWGluZyB3
cm90ZToKPj4+IFBhdGNoIDIgaW50cm9kdWNlcyBldmVudCBsb2cgc3VwcG9ydCBmb3IgUlRNUnMs
IGFkZHJlc3NpbmcgdGhlIGZhY3QgCj4+PiB0aGF0IHRoZQo+Pj4gc3RhbmRhbG9uZSB2YWx1ZXMg
b2YgUlRNUnMsIHdoaWNoIHJlcHJlc2VudCB0aGUgY3VtdWxhdGl2ZSBkaWdlc3RzIG9mCj4+PiBz
ZXF1ZW50aWFsIGV2ZW50cywgYXJlIG5vdCBmdWxseSBpbmZvcm1hdGl2ZSBvbiB0aGVpciBvd24u
Cj4+Cj4+IFdvdWxkIGVhY2ggZXZlbnRfbG9nIGluY2x1ZGUgdGhlIGV2ZW50cyB0aGF0IGZpcm13
YXJlIHdyb3RlIGJlZm9yZSAKPj4gTGludXg/Cj4gTm8uIFRoZSBsb2cgZm9ybWF0IHByb3Bvc2Vk
IGhlcmUgaXMgdGV4dHVhbCBhbmQgaW5jb21wYXRpYmxlIHdpdGggVENHMgo+IGxvZyBmb3JtYXQu
Cj4KPiBUaGUgcHJvcG9zZWQgbG9nIGZvcm1hdCBpcyBiYXNlZCBvbiB0aGUgQ29DbyBldmVudCBs
b2cgLQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9jb25maWRlbnRpYWwtY29udGFpbmVycy9ndWVzdC1j
b21wb25lbnRzL2lzc3Vlcy80OTUuCj4KPj4gSSdtIHdvbmRlcmluZyBob3cgdGhpcyBjb2V4aXN0
cyB3aXRoIAo+PiAvc3lzL2Zpcm13YXJlL2FjcGkvdGFibGVzL2RhdGEvQ0NFTC4KPiBUaGUgcHJv
cG9zZWQgbG9nIHdpbGwgdGFrZSBvdmVyIGFmdGVyIGJvb3RpbmcgdG8gTGludXguIFRoZSBgU1lO
Q2AgbGluZQo+IGluIHRoZSBsb2cgY2FwdHVyZXMgdGhlIFJUTVIgdmFsdWUgYmVmb3JlIGl0LCB3
aGljaCBjYW4gYmUgdXNlZCB0bwo+IHZlcmlmeSBDQ0VMIGxlZnQgb2ZmIGJ5IHRoZSB2aXJ0dWFs
IGZpcm13YXJlLgo+Cj4+IE1heWJlIHNvbWV0aGluZyBsaWtlOiBDQ0VMIG9ubHkgY29udGFpbnMg
cHJlLUxpbnV4IGV2ZW50cy4gVGhlIFRTTSAKPj4gZHJpdmVyCj4+IHBhcnNlcyBDQ0VMICh1c2lu
ZyBhIGZvcm1hdCBzcGVjaWZpYyB0byB0aGUgYXJjaCwgZm9yIGV4YW1wbGUgVENHMiksCj4+IHNl
cGFyYXRlcyB0aGUgZXZlbnRzIGJ5IE1SIGFuZCBwcm9kdWNlcyBldmVudF9sb2cgZmlsZXMgaW4K
Pj4gL3N5cy9rZXJuZWwvdHNtLywgcG9zc2libHkgaW4gYSBkaWZmZXJlbnQgZm9ybWF0IGxpa2Ug
Q0VMLVRMVi4gSXMgdGhhdAo+PiB3aGF0IHlvdSBlbnZpc2lvbiBmb3IgVERYPwo+Pgo+IENDRUwg
d2lsbCBiZSBwcmUtTGludXggb25seS4gR2l2ZW4gdGhlIHByb3Bvc2VkIGZvcm1hdCBpcyBpbmNv
bXBhdGlibGUKPiB3aXRoIFRDRzIgZm9ybWF0LCBJIGRvbid0IHRoaW5rIHRob3NlIDIgbG9ncyB3
aWxsIGJlIG1lcmdlZC4gQnV0IGlmIHdlCj4gZ2V0IGFueSBzdWNjZXNzIGluIHRoaXMgbmV3IGxv
ZyBmb3JtYXQsIHdlIG1heSBpbmZsdWVuY2UgdGhlIFVFRkkvT1ZNRgo+IGNvbW11bml0eSB0byBh
ZG9wdCB0aGlzIG5ldyBmb3JtYXQgaW4gZnV0dXJlLgo+Cj4gV2UgaGF2ZSBldmFsdWF0ZWQgYm90
aCBUQ0cyIGFuZCBDRUwgZm9ybWF0cyBidXQgYXJyaXZlZCBpbiB0aGlzIG5ldwo+IGZvcm1hdCBi
ZWNhdXNlIHdlJ2QgbGlrZSB0byBzdXBwb3J0IEFMTCBhcHBsaWNhdGlvbnMuIEFuZCB0aGUgb25s
eSBzYW5lCj4gd2F5IEkgY291bGQgZmlndXJlIG91dCBpcyB0byBzZXBhcmF0ZSB0aGUgbG9nIGlu
dG8gMiBsYXllcnMgLSBhbgo+IGFwcGxpY2F0aW9uIHNwZWNpZmljIHNlbWFudGljcyBsYXllciAo
YSBjb250cmFjdCBiZXR3ZWVuIHRoZSBhcHBsaWNhdGlvbgo+IGFuZCB0aGUgdmVyaWZpZXIpLCBh
bmQgYW4gYXBwbGljYXRpb24gYWdub3N0aWMgc3RvcmFnZSBsYXllcgo+IChpbXBsZW1lbnRlZCBi
eSB0aGUga2VybmVsKS4gVGhlIGNvbW1vbiBwcm9ibGVtIG9mIFRDRzIgYW5kIENFTCBpcyB0aGF0
Cj4gdGhlIGV2ZW50L2NvbnRlbnQgdGFnL3R5cGUgZGljdGF0ZXMgd2hpY2ggcGFydCBvZiB0aGUg
ZXZlbnQgZGF0YS9jb250ZW50Cj4gdG8gaGFzaCwgbWVhbmluZyB0aGUga2VybmVsIG11c3QgdW5k
ZXJzdGFuZCBhbiBldmVudCByZWNvcmQgYmVmb3JlCj4gaGFzaGluZyBpdC4gQW5kIHRoYXQgaGFz
IHByZXZlbnRlZCBhbiBhcHBsaWNhdGlvbiBhZ25vc3RpYyBzdG9yYWdlIAo+IGRlc2lnbi4KPgo+
IEFueXdheSwgdGhpcyBuZXcgbG9nIGNhbiBiZSBlbmNhcHN1bGF0ZWQgaW4gYm90aCBDRUwtSlNP
TiAobGlrZSB3aGF0Cj4gc3lzdGVtZCBpcyBkb2luZyB0b2RheSkgYW5kIFRDRzIgKHVzaW5nIHRo
ZSBFVl9BQ1RJT04gZXZlbnQgdHlwZSkKPiBmb3JtYXRzLiBQbGVhc2Ugc2VlIHRoZSBDb0NvIGlz
c3VlIChsaW5rIGdpdmVuIGFib3ZlKSBmb3IgbW9yZSBkZXRhaWxzLgo+Cj4+IEkgYXNrIGJlY2F1
c2UgSSd2ZSBiZWVuIGxvb2tpbmcgaW50byB0aGlzIGludGVyZmFjZSBmb3IgQXJtIENDQSwgYW5k
Cj4+IGhhdmluZyB1bmlmaWVkIGV2ZW50IGxvZ3MgYXZhaWxhYmxlIHNvbWV3aGVyZSBpbiAvc3lz
L2tlcm5lbC9jb25mZy90c20KPj4gd291bGQgYmUgdmVyeSBjb252ZW5pZW50IGZvciB1c2VycyAo
YXZvaWRzIGhhdmluZyB0byBwYXJzZSBhbmQgY29udmVydAo+PiBkaWZmZXJlbnQgL3N5cy9maXJt
d2FyZSBpbnRlcmZhY2VzIGFsb25nIHdpdGggTGludXggZXZlbnQgbG9ncykuIEkgd291bGQKPj4g
aGF2ZSBwdXQgYSBzaW5nbGUgZXZlbnRfbG9nIGluIC9zeXMva2VybmVsL2NvbmZpZy90c20vcmVw
b3J0LyBidXQKPj4gc3BsaXR0aW5nIGl0IGJ5IE1SIHNob3VsZCB3b3JrIHRvby4KPj4KPiBXZSBo
YXZlIGNvbnNpZGVyZWQgb25lIGdsb2JhbCBsb2cgdnMuIHBlci1NUiBsb2dzLiBJbiBmYWN0LCBh
IGdsb2JhbCBsb2cKPiBpcyBlcXVpdmFsZW50IHRvIHRoZSBjb25jYXRlbmF0aW9uIG9mIGFsbCBw
ZXItTVIgbG9ncy4gV2UndmUgYWRvcHRlZCB0aGUKPiBwZXItTVIgYXBwcm9hY2ggdG8ga2VlcCB0
aGUgbG9nIG9wdGlvbmFsIC0gaS5lLiwgYW4gUlRNUiBjYW4gYmUgZXh0ZW5kZWQKPiBkaXJlY3Rs
eSAoYnkgd3JpdGluZyB0byBpdHMgYGRpZ2VzdGAgYXR0cmlidXRlKSB3aXRob3V0IGEgbG9nLgo+
Cj4gV2l0aCByZWdhcmQgdG8gdGhlIGxvY2F0aW9uIG9mIHRoZSBNUiB0cmVlLCB3ZSBwaWNrZWQg
c3lzZnMgYmVjYXVzZSB0aGUKPiBNUnMgKGFuZCBhc3NvY2lhdGVkIGxvZ3MpIGFyZSBnbG9iYWwg
YW5kIGZpdCBtb3JlIGludG8gdGhlIHNlbWFudGljcyBvZgo+IHN5c2ZzIHRoYW4gY29uZmlnZnMu
IERhbiBXLiBhbmQgSSBhcmUgYWxzbyBjb25zaWRlcmluZyBtb3ZpbmcgYm90aAo+IHJlcG9ydC8g
YW5kIG1lYXN1cmVtZW50LyB0cmVlcyBpbnRvIHNlY3VyaXR5ZnMuIEl0J2xsIGJlIGhpZ2hseQo+
IGFwcHJlY2lhdGVkIGlmIHlvdSAoYW5kIEFsZXgsIGFuZCBldmVyeW9uZSkgY2FuIHNoYXJlIHlv
dXIgaW5zaWdodHMuCj4KPj4gQXMgQWxleCBJIGJlbGlldmUgd2UgbmVlZCBtb3JlIHNpbWlsYXJp
dHkgYmV0d2VlbiB0aGUgaW50ZXJmYWNlcyBvZiAKPj4gc3RhdGljCj4+IGFuZCBydW50aW1lIG1l
YXN1cmVtZW50cywgYmVjYXVzZSB2ZXJpZmllcnMgbWF5IGJlbmVmaXQgZnJvbSBhbiBldmVudCAK
Pj4gbG9nCj4+IG9mIHN0YXRpYyBtZWFzdXJlbWVudHMuIEZvciBleGFtcGxlIEFybSBjb3VsZCBo
YXZlIGEgY29uZmlndXJhdGlvbiBsaWtlCj4+IHRoaXM6Cj4+Cj4+IMKgwqAgc3RydWN0IHRzbV9t
ZWFzdXJlbWVudF9yZWdpc3RlciBhcm1fY2NhX21yc1tdID0gewo+PiDCoMKgwqDCoMKgIHsgTVJf
KHJpbSkgfCBUU01fTVJfRl9SIHwgVFNNX01SX0ZfTE9HLCBIQSB9LAo+PiDCoMKgwqDCoMKgIHsg
TVJfKHJlbTApIHwgVFNNX01SX0ZfUiB8IFRTTV9NUl9GX1ggfCBUU01fTVJfRl9MT0csIEhBIH0s
Cj4+IMKgwqDCoMKgwqAgLi4uCj4+IMKgwqDCoMKgwqAgeyBNUl8ocmVtMykgfCBUU01fTVJfRl9S
IHwgVFNNX01SX0ZfWCB8IFRTTV9NUl9GX0xPRywgSEEgfSwKPj4gwqDCoCB9Owo+Pgo+PiBIZXJl
IHJpbSBpcyBhIHN0YXRpYyBtZWFzdXJlbWVudCBvZiB0aGUgaW5pdGlhbCBWTSBzdGF0ZSwgaW1w
b3NzaWJsZSB0bwo+PiBleHRlbmQgYnV0IGNvdWxkIGhhdmUgYW4gZXZlbnQgbG9nLiByZW0wLTMg
YXJlIHJ1bnRpbWUgbWVhc3VyZW1lbnRzLAo+PiBleHRlbnNpYmxlIGJ5IGZpcm13YXJlIGFuZCB0
aGVuIExpbnV4LiBOb25lIG9mIHRoZSBkaWdlc3RzIGNhbiBiZSAKPj4gd3JpdHRlbgo+PiBkaXJl
Y3RseSwgb25seSBleHRlbmRlZCBhbmQgcmVhZCB3aXRoIGNhbGxzIHRvIHRoZSB1cHBlciBsYXll
ci4gVGhlIHRyZWUKPj4gd291bGQgYmU6Cj4+Cj4+IMKgwqAgL3N5cy9rZXJuZWwvY29uZmlnL3Rz
bS8KPj4gwqDCoCDilJzilIDilIAgcmltCj4+IMKgwqAg4pSCwqDCoCDilJzilIDilIAgZGlnZXN0
Cj4+IMKgwqAg4pSCwqDCoCDilJzilIDilIAgZXZlbnRfbG9nCj4+IMKgwqAg4pSCwqDCoCDilJTi
lIDilIAgaGFzaF9hbGdvCj4+IMKgwqAg4pSc4pSA4pSAIHJlbTAKPj4gwqDCoCDilILCoMKgIOKU
nOKUgOKUgCBkaWdlc3QKPj4gwqDCoCDilILCoMKgIOKUnOKUgOKUgCBhcHBlbmRfZXZlbnQKPj4g
wqDCoCDilILCoMKgIOKUnOKUgOKUgCBldmVudF9sb2cKPj4gwqDCoCDilILCoMKgIOKUlOKUgOKU
gCBoYXNoX2FsZ28KPj4gwqDCoCAuLi4KPj4gwqDCoCDilJzilIDilIAgcmVtMwo+PiDCoMKgIOKU
gsKgwqAg4pSc4pSA4pSAIGRpZ2VzdAo+PiDCoMKgIOKUgsKgwqAg4pSc4pSA4pSAIGFwcGVuZF9l
dmVudAo+PiDCoMKgIOKUgsKgwqAg4pSc4pSA4pSAIGV2ZW50X2xvZwo+PiDCoMKgIOKUgsKgwqAg
4pSU4pSA4pSAIGhhc2hfYWxnbwo+PiDCoMKgIOKUlOKUgOKUgCByZXBvcnQvJG5hbWUKPj4gwqDC
oMKgwqDCoMKgIOKUnOKUgOKUgCBpbmJsb2IKPj4gwqDCoMKgwqDCoMKgIOKUlOKUgOKUgCBvdXRi
bG9iCj4+Cj4gSSBzZWUuIFRoZSBkZXNpcmVkL21pc3NpbmcgZmVhdHVyZSBoZXJlIEkgdGhpbmsg
aXMgdG8gYWxsb3cgYSBDQyBndWVzdAo+IGRyaXZlciB0byBzdXBwbHkgYW4gImluaXRpYWwgbG9n
Ii4gSSBjYW4gZGVmaW5lIGEgTE9HIGJpdCwgd2hpY2ggaWYgc2V0LAo+IHdpbGwgbWFrZSB0aGUg
TVIgaXRzIG93biBkaXIgd2l0aCBgaGFzaF9hbGdvYCBhbmQgYGV2ZW50X2xvZ2AuIEFuZCBpZiBY
Cj4gaXMgYWxzbyBzZXQsIHRoZW4gYGFwcGVuZF9ldmVudGAgd2lsbCBhcHBlYXIgYXMgd2VsbC4g
RG9lcyB0aGlzIHNvdW5kCj4gbGlrZSB3aGF0IEFsZXggYW5kIHlvdSBhcmUgbG9va2luZyBmb3I/
CgoKSSBkb24ndCB1bmRlcnN0YW5kIHdoeSB3ZSB3YW50IHRvIGhhdmUgMiBzZXBhcmF0ZSByZXBy
ZXNlbnRhdGlvbnMgZm9yIGEgCiJtZWFzdXJlbWVudCBvYmplY3QiOiBmbGF0IGZpbGUgYXMgd2Vs
bCBhcyBkaXJlY3RvcnkuIENvdWxkIHlvdSBwbGVhc2UgCmVsYWJvcmF0ZSBvbiB0aGUgcmF0aW9u
YWxlIHdoeSB5b3UgdGhpbmsgaXQgd291bGQgYmUgZGVzaXJhYmxlIHRvIGhhdmUgYSAKbm9uLWRp
cmVjdG9yeSByZXByZXNlbnRhdGlvbiBhdCBhbGw/IEkgZmVlbCBsaWtlIEknbSBtaXNzaW5nIHNv
bWV0aGluZyA6KQoKV2hhdCBpZiBmb3IgZXhhbXBsZSBuZXh0LW5leHQtZ2VuIFNFVi1TTlAgc3Vk
ZGVubHkgZ2FpbnMgZXZlbnQgbG9nIApzdXBwb3J0IGZvciBpdHMgbGF1bmNoIGRpZ2VzdD8gV2Ug
d291bGQgY3JlYXRlIG5lZWRsZXNzIGNodXJuIG9uIHVzZXIgCnNwYWNlIHRvIGR5bmFtaWNhbGx5
IGRldGVybWluZSB3aGV0aGVyIGl0IHNob3VsZCByZWFkIHRoaW5ncyBhcyAKZGlyZWN0b3J5IG9y
IGFzIGZpbGUuIE9yIGV2ZW4gd29yc2U6IE5ld2VyIGtlcm5lbHMgd291bGQgc2ltcGx5IGFsd2F5
cyAKc2V0IHRoZSBMT0cgYml0IGFuZCB3ZSBzdWRkZW5seSBicmVhayB0aGUgdXNlciBzcGFjZSBB
QkkgZm9yIGV4aXN0aW5nIAplbnZpcm9ubWVudHMgdGhhdCBydW4gb24gY3VycmVudC1nZW4gU0VW
LVNOUC4KCgpBbGV4CgoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBH
ZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVu
ZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10
c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpV
c3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==


