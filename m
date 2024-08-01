Return-Path: <linux-kernel+bounces-270850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126A5944639
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352151C223E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFE415747C;
	Thu,  1 Aug 2024 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="gkQUaWwB";
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="sNMVnQWE"
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54716EEB3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499794; cv=none; b=uTmgrpiCVB5fybg/6sbTFVfkPmHjxgjYd/KKqwEooBkrRaKEt/U21fFVF9PJD2OHX+7P5kss/fvpYR0IO9BQa7W4psbVisJB4p4JD4xhJtkYE4h6v143DLlPMIlPz8UBQbfsSK8v2qnTZifBJtdZcOcdhUNxAtgiJauGkwg6Kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499794; c=relaxed/simple;
	bh=On2CuezVZzW4tOWwxPYeLg6t/rqFLgqgn1L6L6oxBbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oo17NYjj9aKWopaNM6hTC1s1TjNTdfqYF6MQGBW948EzyFutu1VdEUA5YglfTtBrHrK41lj2A1b8fPj+DHkJwDce/ElMuOybzEaYo6ap+w42qAwE3Y9N0/5SBHfKhAHKPO47xxqObq656HjZJjZbOl/swXqCP1WdEJmFvjyq7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com; spf=fail smtp.mailfrom=syntacore.com; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=gkQUaWwB; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=sNMVnQWE; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=syntacore.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 4F6ECC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
	s=mta-04; t=1722499784;
	bh=On2CuezVZzW4tOWwxPYeLg6t/rqFLgqgn1L6L6oxBbs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=gkQUaWwBSc0VwGkVgnIUKuIlyCgpoK7OxPFgaHoPek9lq/lF30g+zrQORzu3wgap6
	 nrg7Hxs1mKrrcSp0wZA6hVa2arzyMKnyJ0cLiFf/2Fg0fNQWvOYm8eDyTiJJQWqw7G
	 Dc5gR0DDm+AF8SLORySNaADtZiIOBEIdth6L/5hxoG0mH3MkNpj+2mYig4GPdGOgq2
	 RwjOUC+n3zv354EqLXaNYdKGuKz2Axsuj8DiqUPL5M2+EycxqTAvUWbAjPrb88N0Nk
	 W6pLVW00duBnm5td84uCUDbHrTDuIiMOgLA5dLOytj2oPnPibbi4lH7T10dL7kwbeL
	 Gts0r2SNHT/DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
	s=mta-03; t=1722499784;
	bh=On2CuezVZzW4tOWwxPYeLg6t/rqFLgqgn1L6L6oxBbs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=sNMVnQWE1o5IhFuPoV5PJdALFUw4KWZzz32zQD5fzSXAPsL/+oI1IBoYFRWuQ78tp
	 eV8fm3gTZH4EQCrcfGtrt3AQlA4tXrGkxuw3ovungasx24zUc+VXFfhs/SwZrKogCJ
	 I6o+Wy0btczEEUnupQG+j37ofVG9VJtOFzuXeVRLuMSV6uKm6CYtSS4O/7OHXy5t4P
	 uxNc1gctspghQphdyjH64d46Nd/NTupsXVJRfOoSNALvxZmobBXoxJi+SbQDFq7lkn
	 kJqAraTLOJ3iPOsoIJ3aRrQ5aHcDp3MrUDJQeK9GlqIvUnQMWwiwsczQLSctK69kCd
	 mAani7giD5Dwg==
From: Dmitry Shifrin <dmitry.shifrin@syntacore.com>
To: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"samuel.holland@sifive.com" <samuel.holland@sifive.com>
CC: "alexghiti@rivosinc.com" <alexghiti@rivosinc.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "atishp@atishpatra.org" <atishp@atishpatra.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "anup@brainfault.org"
	<anup@brainfault.org>, "will@kernel.org" <will@kernel.org>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH] perf: riscv: Fix selecting counters in legacy mode
Thread-Topic: [PATCH] perf: riscv: Fix selecting counters in legacy mode
Thread-Index: AQHa4bcnGNh2aYB3IEWs7z+xYNeVK7IQQ1IAgAGbSAA=
Date: Thu, 1 Aug 2024 08:09:42 +0000
Message-ID: <f35cc5d6607f143bb2f66da0ce629776c0b45802.camel@syntacore.com>
References: <20240729125858.630653-1-dmitry.shifrin@syntacore.com>
	 <0fa3cf3d-48f6-405b-8b66-8935a629089e@sifive.com>
In-Reply-To: <0fa3cf3d-48f6-405b-8b66-8935a629089e@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <01D88D1BD50498488798BD8BBB5A3134@yadro.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU2FtdWVsLA0KDQpPbiBXZWQsIDIwMjQtMDctMzEgYXQgMDI6MzcgLTA1MDAsIFNhbXVlbCBI
b2xsYW5kIHdyb3RlOg0KPiBIaSBEbWl0cnksDQo+IA0KPiBPbiAyMDI0LTA3LTI5IDc6NTggQU0s
IFNoaWZyaW4gRG1pdHJ5IHdyb3RlOg0KPiA+IEl0IGlzIHJlcXVpcmVkIHRvIGNoZWNrIGV2ZW50
IHR5cGUgYmVmb3JlIGNoZWNraW5nIGV2ZW50IGNvbmZpZy4NCj4gPiBFdmVudHMgd2l0aCB0aGUg
ZGlmZmVyZW50IHR5cGVzIGNhbiBoYXZlIHRoZSBzYW1lIGNvbmZpZy4NCj4gPiBUaGlzIGNoZWNr
IGlzIG1pc3NlZCBmb3IgbGVnYWN5IG1vZGUgY29kZQ0KPiA+IA0KPiA+IEZvciBzdWNoIHBlcmYg
dXNhZ2U6DQo+ID4gwqDCoMKgIHN5c2N0bCAtdyBrZXJuZWwucGVyZl91c2VyX2FjY2Vzcz0yDQo+
ID4gwqDCoMKgIHBlcmYgc3RhdCAtZSBjeWNsZXMsTDEtZGNhY2hlLWxvYWRzIC0tDQo+ID4gZHJp
dmVyIHdpbGwgdHJ5IHRvIGZvcmNlIGJvdGggZXZlbnRzIHRvIENZQ0xFIGNvdW50ZXIuDQo+ID4g
DQo+ID4gVGhpcyBjb21taXQgaW1wbGVtZW50cyBldmVudCB0eXBlIGNoZWNrIGJlZm9yZSBmb3Jj
aW5nDQo+ID4gZXZlbnRzIG9uIHRoZSBzcGVjaWFsIGNvdW50ZXJzLg0KPiANCj4gSXQgbG9va3Mg
bGlrZSBwbXVfc2JpX2V2ZW50X21hcHBlZCgpIGFuZCBwbXVfc2JpX2V2ZW50X21hcHBlZCgpIGhh
dmUgYSBzaW1pbGFyDQo+IGJ1ZyB3aGVyZSB0aGV5IGRvIG5vdCBjaGVjayBldmVudC0+YXR0ci50
eXBlLg0KDQpJIGFtIG5vdCBzdXJlIHRoYXQgcG11X3NiaV9ldmVudF91bm1hcHBlZCgpIGFuZCBw
bXVfc2JpX2V2ZW50X21hcHBlZCgpIHNob3VsZCBiZSBjaGFuZ2VkIGluIHRoZSBzYW1lIHdheS4N
ClRoZXNlIGZ1bmN0aW9ucyBpbiBsZWdhY3kgbW9kZSBqdXN0IHNldC9jbGVhciBQRVJGX0VWRU5U
X0ZMQUdfVVNFUl9SRUFEX0NOVCBmb3IgbGVnYWN5IGV2ZW50cyB3aXRob3V0IGFueQ0KbWFwcGlu
Zy91bm1hcHBpbmcuIEhvd2V2ZXIgaW4gcG11X3NiaV9zdGFydGluZ19jcHUoKSBDWUNMRSwgVElN
RSBhbmQgSU5TVFJFVCBjb3VudGVycyBhcmUgYWx3YXlzIG1hcHBlZCB0bw0KdXNlciBzcGFjZSBp
biBsZWdhY3kgbW9kZS4gU28gaXQgbG9va3MgbGlrZSBpbiBsZWdhY3kgbW9kZSB3ZSBjYW4ganVz
dCB1c2UNCg0KOiBpZiAoZXZlbnQtPmh3LmZsYWdzICYgUEVSRl9FVkVOVF9GTEFHX0xFR0FDWSkN
CjoJcmV0dXJuOw0KDQpUaGFua3MsIERtaXRyeQ0KDQo+IA0KPiBSZWdhcmRzLA0KPiBTYW11ZWwN
Cj4gDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogU2hpZnJpbiBEbWl0cnkgPGRtaXRyeS5zaGlm
cmluQHN5bnRhY29yZS5jb20+DQo+ID4gLS0tDQo+ID4gwqBkcml2ZXJzL3BlcmYvcmlzY3ZfcG11
X3NiaS5jIHwgMiArLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGVyZi9yaXNjdl9wbXVf
c2JpLmMgYi9kcml2ZXJzL3BlcmYvcmlzY3ZfcG11X3NiaS5jDQo+ID4gaW5kZXggMzZkMTI4ZmYx
NjZmLi5iZjE0YWIyODJlMTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wZXJmL3Jpc2N2X3Bt
dV9zYmkuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGVyZi9yaXNjdl9wbXVfc2JpLmMNCj4gPiBAQCAt
NDE2LDcgKzQxNiw3IEBAIHN0YXRpYyBpbnQgcG11X3NiaV9jdHJfZ2V0X2lkeChzdHJ1Y3QgcGVy
Zl9ldmVudCAqZXZlbnQpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqIGJ1dCBub3QgaW4gdGhlIHVz
ZXIgYWNjZXNzIG1vZGUgYXMgd2Ugd2FudCB0byB1c2UgdGhlIG90aGVyIGNvdW50ZXJzDQo+ID4g
wqDCoMKgwqDCoMKgwqDCoCAqIHRoYXQgc3VwcG9ydCBzYW1wbGluZy9maWx0ZXJpbmcuDQo+ID4g
wqDCoMKgwqDCoMKgwqDCoCAqLw0KPiA+IC3CoMKgwqDCoMKgwqDCoGlmIChod2MtPmZsYWdzICYg
UEVSRl9FVkVOVF9GTEFHX0xFR0FDWSkgew0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmICgoaHdjLT5m
bGFncyAmIFBFUkZfRVZFTlRfRkxBR19MRUdBQ1kpICYmIChldmVudC0+YXR0ci50eXBlID09IFBF
UkZfVFlQRV9IQVJEV0FSRSkpIHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlmIChldmVudC0+YXR0ci5jb25maWcgPT0gUEVSRl9DT1VOVF9IV19DUFVfQ1lDTEVTKSB7DQo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2ZsYWdz
IHw9IFNCSV9QTVVfQ0ZHX0ZMQUdfU0tJUF9NQVRDSDsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbWFzayA9IDE7DQo+IA0KDQo=

