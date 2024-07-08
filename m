Return-Path: <linux-kernel+bounces-244146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F15F929FC3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A001C23151
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BAA74BF8;
	Mon,  8 Jul 2024 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Y3YY9Ufw"
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD04E6F2E9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432698; cv=none; b=ijYdyDRIh06N/v3yabOxNXzYI1nEl/fhSKI4jpJSYiY6qxcP+GRoCRIwvciwVdeLdjIwUJjcyVNe+TL41mZCGyvyTMiQL6XvnwhBvhXwC35Vfdth7LBMjF+CsT8D8cuN2Haz3/6CFwmnRB87GIygB6tQ6JbAYSWvh4BNtTn2qVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432698; c=relaxed/simple;
	bh=09A+agkF70Psqu3YtBvHyqdgSuOLGsFlv3gsDiU0ohM=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m1mmqQN+ihK1a7U4iHsy6NWeuizFkWls7miSb5Ro7ms6R9wvUqYjuQQPOp0Twf+c+DX0et/3UJ+fMSMMmhNSeU8/4bwmsnzM/Xfx2Mdu9osU41KUbgdTWrskVK3/GlNgbNUEfn1AY8vdKogvP5Mho9yuQNcbE5K8wAlE8IOVtKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Y3YY9Ufw; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720432697; x=1751968697;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=09A+agkF70Psqu3YtBvHyqdgSuOLGsFlv3gsDiU0ohM=;
  b=Y3YY9Ufwe2cfpexOUXkCOzM4iMJtpoOaLG6zZ0PuNgESMYpcNxn1fs2N
   UXjbrO3Mf2ZN5q4wb0lLlga0fUM16y2Is11BooGUfBvGiUcaHcXCcDUf7
   5oo+rmELWkI0U8o3+Awz0jZ0TVApfWdPZzDdBbe0eQdilZ2I8MvyMuxfP
   4=;
X-IronPort-AV: E=Sophos;i="6.09,191,1716249600"; 
   d="scan'208";a="739537399"
Subject: Re: [linux-next-6.10-rc6-20240703] Warning at mm/memblock.c:1447
Thread-Topic: [linux-next-6.10-rc6-20240703] Warning at mm/memblock.c:1447
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 09:58:11 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:27253]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.53:2525] with esmtp (Farcaster)
 id a71911b4-fbfc-41cd-9f48-f63e4cd08bdb; Mon, 8 Jul 2024 09:58:10 +0000 (UTC)
X-Farcaster-Flow-ID: a71911b4-fbfc-41cd-9f48-f63e4cd08bdb
Received: from EX19D020UWA003.ant.amazon.com (10.13.138.254) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 09:58:10 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D020UWA003.ant.amazon.com (10.13.138.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 09:58:10 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1258.034; Mon, 8 Jul 2024 09:58:09 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "naveen.n.rao@linux.ibm.com"
	<naveen.n.rao@linux.ibm.com>, "venkat88@linux.vnet.ibm.com"
	<venkat88@linux.vnet.ibm.com>, "npiggin@gmail.com" <npiggin@gmail.com>,
	"rppt@kernel.org" <rppt@kernel.org>
CC: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "linux-mm@vger.kernel.org"
	<linux-mm@vger.kernel.org>, "Graf (AWS), Alexander" <graf@amazon.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Thread-Index: AQHa0RrhQT/K7aCq10aAtnfUXeDICrHsmHGA
Date: Mon, 8 Jul 2024 09:58:09 +0000
Message-ID: <e6dbf04ca92a021856d8da2a4e795908290c6c9c.camel@amazon.com>
References: <a70e4064-a040-447b-8556-1fd02f19383d@linux.vnet.ibm.com>
In-Reply-To: <a70e4064-a040-447b-8556-1fd02f19383d@linux.vnet.ibm.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <D852B9AC5E18A342A700FD9ADA77C286@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgVmVua2F0LA0KDQpPbiBNb24sIDIwMjQtMDctMDggYXQgMTU6MDkgKzA1MzAsIFZlbmthdCBS
YW8gQmFnYWxrb3RlIHdyb3RlOg0KPiBHcmVldGluZ3MhISENCj4gDQo+IA0KPiBPYnNlcnZpbmcg
YmVsb3cgd2FybmluZyB3aGlsZSBib290aW5nLCB3aGVuIGZhZHVtcCBpcyBjb25maWd1cmVkIHdp
dGggbm9jYW0uDQo+IA0KPiANCj4gW8KgwqDCoCAwLjA2MTMyOV0gLS0tLS0tLS0tLS0tWyBjdXQg
aGVyZSBdLS0tLS0tLS0tLS0tDQo+IFvCoMKgwqAgMC4wNjEzMzJdIFdBUk5JTkc6IENQVTogMCBQ
SUQ6IDEgYXQgbW0vbWVtYmxvY2suYzoxNDQ3DQo+IG1lbWJsb2NrX2FsbG9jX3JhbmdlX25pZCsw
eDI0Yy8weDI3OA0KPiBbwqDCoMKgIDAuMDYxMzM3XSBNb2R1bGVzIGxpbmtlZCBpbjoNCj4gW8Kg
wqDCoCAwLjA2MTMzOV0gQ1BVOiAwIFVJRDogMCBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIE5vdCB0
YWludGVkDQo+IDYuMTAuMC1yYzYtbmV4dC0yMDI0MDcwMy1hdXRvICMxDQo+IFvCoMKgwqAgMC4w
NjEzNDFdIEhhcmR3YXJlIG5hbWU6IElCTSw5MDgwLUhFWCBQT1dFUjEwIChhcmNoaXRlY3RlZCkN
Cj4gMHg4MDAyMDAgMHhmMDAwMDA2IG9mOklCTSxGVzEwNjAuMDAgKE5IMTA2MF8wMTYpIGh2OnBo
eXAgcFNlcmllcw0KPiBbwqDCoMKgIDAuMDYxMzQyXSBOSVA6ICBjMDAwMDAwMDAyMDYxNjEwIExS
OiBjMDAwMDAwMDAyMDYxNDI0IENUUjoNCj4gMDAwMDAwMDAwMDAwMDAwMA0KPiBbwqDCoMKgIDAu
MDYxMzQ0XSBSRUdTOiBjMDAwMDAwMDA0ZDJmNzgwIFRSQVA6IDA3MDAgICBOb3QgdGFpbnRlZA0K
PiAoNi4xMC4wLXJjNi1uZXh0LTIwMjQwNzAzLWF1dG8pDQo+IFvCoMKgwqAgMC4wNjEzNDVdIE1T
UjogIDgwMDAwMDAwMDIwMjkwMzMgPFNGLFZFQyxFRSxNRSxJUixEUixSSSxMRT7CoCBDUjoNCj4g
NDQwMDAyNDIgIFhFUjogMjAwNDAwMTANCj4gW8KgwqDCoCAwLjA2MTM1MF0gQ0ZBUjogYzAwMDAw
MDAwMjA2MTQyYyBJUlFNQVNLOiAwDQo+IFvCoMKgwqAgMC4wNjEzNTBdIEdQUjAwOiBjMDAwMDAw
MDAyMDYxNDI0IGMwMDAwMDAwMDRkMmZhMjAgYzAwMDAwMDAwMTVhM2QwMA0KPiAwMDAwMDAwMDAw
MDAwMDAxDQo+IFvCoMKgwqAgMC4wNjEzNTBdIEdQUjA0OiAwMDAwMDAwMDAwMDAwODAwIDAwMDAw
MDEyYzAwMDAwMDAgMDAwMDAwMjU4MDAwMDAwMA0KPiBmZmZmZmZmZmZmZmZmZmZmDQo+IFvCoMKg
wqAgMC4wNjEzNTBdIEdQUjA4OiAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAwMDAwMDAwMDIgYzAw
MDAwMDAwMmY1OGMwOA0KPiAwMDAwMDAwMDI0MDAwMjQyDQo+IFvCoMKgwqAgMC4wNjEzNTBdIEdQ
UjEyOiBjMDAwMDAwMDAwNDU0NDA4IGMwMDAwMDAwMDMwMTAwMDAgYzAwMDAwMDAwMDAxMTJhYw0K
PiAwMDAwMDAwMDAwMDAwMDAwDQo+IFvCoMKgwqAgMC4wNjEzNTBdIEdQUjE2OiAwMDAwMDAwMDAw
MDAwMDAwIDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMA0KPiAwMDAwMDAwMDAwMDAw
MDAwDQo+IFvCoMKgwqAgMC4wNjEzNTBdIEdQUjIwOiAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAw
MDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMA0KPiBjMDAwMDAwMDAxNDlkMzkwDQo+IFvCoMKgwqAg
MC4wNjEzNTBdIEdQUjI0OiBjMDAwMDAwMDAyMDA0NjZjIGZmZmZmZmZmZmZmZmZmZmYgMDAwMDAw
MjU4MDAwMDAwMA0KPiAwMDAwMDAxMmMwMDAwMDAwDQo+IFvCoMKgwqAgMC4wNjEzNTBdIEdQUjI4
OiAwMDAwMDAwMDAwMDAwODAwIDAwMDAwMDAwMDAwMDAwMDUgMDAwMDAwMDAwMDAwMDAwMA0KPiAw
MDAwMDAwMDAwMDAwMDAwDQo+IFvCoMKgwqAgMC4wNjEzNjVdIE5JUCBbYzAwMDAwMDAwMjA2MTYx
MF0gbWVtYmxvY2tfYWxsb2NfcmFuZ2VfbmlkKzB4MjRjLzB4Mjc4DQo+IFvCoMKgwqAgMC4wNjEz
NjhdIExSIFtjMDAwMDAwMDAyMDYxNDI0XSBtZW1ibG9ja19hbGxvY19yYW5nZV9uaWQrMHg2MC8w
eDI3OA0KPiBbwqDCoMKgIDAuMDYxMzcwXSBDYWxsIFRyYWNlOg0KPiBbwqDCoMKgIDAuMDYxMzcx
XSBbYzAwMDAwMDAwNGQyZmEyMF0gW2MwMDAwMDAwMDRkMmZhNjBdIDB4YzAwMDAwMDAwNGQyZmE2
MA0KPiAodW5yZWxpYWJsZSkNCj4gW8KgwqDCoCAwLjA2MTM3M10gW2MwMDAwMDAwMDRkMmZhZTBd
IFtjMDAwMDAwMDAyMDYxNzhjXQ0KPiBtZW1ibG9ja19waHlzX2FsbG9jX3JhbmdlKzB4NjAvMHhl
NA0KPiBbwqDCoMKgIDAuMDYxMzc2XSBbYzAwMDAwMDAwNGQyZmI2MF0gW2MwMDAwMDAwMDIwMTdh
NjBdDQo+IHNldHVwX2ZhZHVtcCsweDExNC8weDI0NA0KPiBbwqDCoMKgIDAuMDYxMzc5XSBbYzAw
MDAwMDAwNGQyZmJlMF0gW2MwMDAwMDAwMDAwMTBlNzhdDQo+IGRvX29uZV9pbml0Y2FsbCsweDYw
LzB4Mzk4DQo+IFvCoMKgwqAgMC4wNjEzODFdIFtjMDAwMDAwMDA0ZDJmY2MwXSBbYzAwMDAwMDAw
MjAwNmI1Y10NCj4gZG9faW5pdGNhbGxzKzB4MTJjLzB4MjE4DQo+IFvCoMKgwqAgMC4wNjEzODNd
IFtjMDAwMDAwMDA0ZDJmZDcwXSBbYzAwMDAwMDAwMjAwNmYyOF0NCj4ga2VybmVsX2luaXRfZnJl
ZWFibGUrMHgyMzgvMHgzNzANCj4gW8KgwqDCoCAwLjA2MTM4Nl0gW2MwMDAwMDAwMDRkMmZkZTBd
IFtjMDAwMDAwMDAwMDExMmQ4XSBrZXJuZWxfaW5pdCsweDM0LzB4MjZjDQo+IFvCoMKgwqAgMC4w
NjEzODhdIFtjMDAwMDAwMDA0ZDJmZTUwXSBbYzAwMDAwMDAwMDAwZGY3Y10NCj4gcmV0X2Zyb21f
a2VybmVsX3VzZXJfdGhyZWFkKzB4MTQvMHgxYw0KPiBbwqDCoMKgIDAuMDYxMzg5XSAtLS0gaW50
ZXJydXB0OiAwIGF0IDB4MA0KPiBbwqDCoMKgIDAuMDYxMzkwXSBDb2RlOiBlYjgxZmZlMCBlYmMx
ZmZmMCBlYmUxZmZmOCA3YzA4MDNhNiA3ZDcxMDEyMA0KPiA3ZDcwODEyMCA0ZTgwMDAyMCA2MDAw
MDAwMCA0YWZiZjIxOSA2MDAwMDAwMCAzYjgwMDA4MCA0YmZmZmU0MA0KPiA8MGZlMDAwMDA+IGU4
NjEwMDY4IDdmMjZjYjc4IDM4YTAyOTAwDQo+IFvCoMKgwqAgMC4wNjEzOTZdIC0tLVsgZW5kIHRy
YWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KDQpUaGUgcHVycG9zZSBvZiB0aGF0IG5ld2x5IGlu
dHJvZHVjZWQgd2FybmluZyBpcyB0byBkZXRlY3QgaW5jb3JyZWN0DQp1c2FnZSBvZiB0aGUgbWVt
YmxvY2sgYWxsb2NhdG9yLiBTcGVjaWZpY2FsbHksIHRvIGZpbmQgd2hlbiBhDQpkcml2ZXIvc3Vi
c3lzdGVtIHRyaWVzIHRvIGRvIGEgbWVtYmxvY2sgYWxsb2MgYWZ0ZXIgbWVtYmxvY2sgaGFzIGdp
dmVuDQphbGwgc3lzdGVtIFJBTSB0byB0aGUgYnVkZHkgYWxsb2NhdG9yLiBJdCBoYXMgbWF5YmUg
Y2F1Z2h0IHN1Y2ggYSBjYXNlDQpub3cuLi4NCg0KSSBkb24ndCBoYXZlIGEgcG93ZXJwYyBzeXN0
ZW0gaGFuZHkgdG8gcmVwcm8geW91ciBmYWlsdXJlLCBidXQgbG9va2luZw0KYXQgdGhlIGNvZGUs
IGl0IGxvb2tzIGxpa2U6DQoxLiBmYWR1bXBfc2V0dXBfcGFyYW1fYXJlYSBhbGxvY3MgYSBwaHlz
aWNhbCByYW5nZSBmb3INCmZ3X2R1bXAucGFyYW1fYXJlYSBhbmQgemVyb2VzIHRoYXQgcmFuZ2Uu
DQoyLiBmYWR1bXBfYXBwZW5kX2Jvb3RhcmdzKCkgbWFya3MgaXQgYXMgcmVzZXJ2ZWQNCg0KQnV0
IEkgYmVsaWV2ZSB0aGF0IGJ5IHRoaXMgcG9pbnQgdGhlIG1lbW9yeSBoYXMgYWxyZWFkeSBiZWVu
IGhhbmRlZCB0bw0KdGhlIGJ1ZGR5IGFsbG9jYXRvci4gU28gaXQncyBwb3NzaWJsZSBmb3IgdGhh
dCB6ZXJvaW5nIHRvIGJlIGNsb2JiZXJpbmcNCnNvbWVvbmUgZWxzZSdzIG1lbW9yeSwgYXMgdGhl
IGZhZHVtcCBjb2RlIGluY29ycmVjdGx5IGFzc3VtZXMgdGhhdCBpdA0KaGFzIGV4Y2x1c2l2ZSB1
c2Ugb2YgdGhpcyByZWdpb24uDQoNCkkgbWF5IGJlIHdpbGRseSBvZmYsIGJ1dCB0aGF0IHdhcyB0
aGUgKmludGVudGlvbiogb2YgdGhlIHdhcm5pbmcuDQoNCkFkZGluZyBQb3dlclBDIG1haW50YWlu
ZXJzIGhlcmUgZm9yIHRoZWlyIG9waW5pb24gb24gd2hldGhlciBmYWR1bXAgaXMNCmRvaW5nIHRo
ZSByaWdodCB0aGluZyBoZXJlIG9yIG5vdC4NCg0KPiANCj4gDQo+IGNhdCAvcHJvYy9jbWRsaW5l
DQo+IEJPT1RfSU1BR0U9KGllZWUxMjc1Ly92ZGV2aWNlL3ZmYy1jbGllbnRAMzAwMDAwZDQvZGlz
a0A1MDA1MDc2ODEwMTUzNWU1LG1zZG9zMykvYm9vdC92bWxpbnV6LTYuMTAuMC1yYzYtbmV4dC0y
MDI0MDcwMw0KPiByb290PVVVSUQ9MmM5MGFiNDctMzM4OS00MDE3LTlmMDYtMGM5NDUzNGZkOWNi
IHJvDQo+IGNyYXNoa2VybmVsPTJHLTRHOjM4NE0sNEctMTZHOjUxMk0sMTZHLTY0RzoxRyw2NEct
MTI4RzoyRywxMjhHLTo0Rw0KPiBmYWR1bXA9bm9jbWENCj4gDQo+IA0KPiBSZXZlcnRpbmcgdGhl
IGJlbG93IGNvbW1pdCwgaXNzdWUgaXMgbm90IHNlZW4uDQo+IA0KPiANCj4gQ29tbWl0IElEOiAw
ZmE0YWM2NzIyMTI3ZjRhYWUyZWE5ODEzYmEyNDZjZTJiZWM4MzI2DQo+IA0KPiANCj4gUmVnYXJk
cywNCj4gDQo+IFZlbmthdC4NCj4gDQoNCg==

