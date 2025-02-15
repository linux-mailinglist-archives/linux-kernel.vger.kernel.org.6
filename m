Return-Path: <linux-kernel+bounces-516079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76919A36CBC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2882E18924B6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2061519CD1B;
	Sat, 15 Feb 2025 09:05:57 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14EEACE
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739610356; cv=none; b=aJa01uRwrasHw5sSiyoSnOhsAkdICtQCWK9fFS1oABFbml3uIO2BNMjFC+m0cIWXuhFsAcfNMZEh3vu8eCwDUg6jxFuzu/c+FlMNGxSRSWHcB0v0qrISPOm2RW0ZQo3/V58UkLvCsdcb8gZH5rzefST/8pplgDY/MHb0Mt22Wgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739610356; c=relaxed/simple;
	bh=+UG5j84zhGYC7t41WNQYDePcgLwKwWlMeeFq9ZVzv0E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NaxMureSTpEyge207g2osDPXO3mxIiNW8jhbi/k3v7gZA2q9UuOc42YxmPDJJO9yV0f+WBdUkqtAipA3t2bM25lsGgZm6Hh0DPKgwYCMQFFklahOTk/30Ojh7bRs1kQyaXW3B/TV7HFrWU55tt2C55w85qI0lDzePUJ8btX5kes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4Yw2zz2Qv8zYl1jK;
	Sat, 15 Feb 2025 17:04:47 +0800 (CST)
Received: from a007.hihonor.com (10.68.22.31) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 15 Feb
 2025 17:05:51 +0800
Received: from a007.hihonor.com (10.68.22.31) by a007.hihonor.com
 (10.68.22.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 15 Feb
 2025 17:05:51 +0800
Received: from a007.hihonor.com ([fe80::e866:83ac:f23b:c25c]) by
 a007.hihonor.com ([fe80::e866:83ac:f23b:c25c%10]) with mapi id
 15.02.1544.011; Sat, 15 Feb 2025 17:05:51 +0800
From: gaoxu <gaoxu2@honor.com>
To: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, Barry Song <21cnbao@gmail.com>, "Yosry
 Ahmed" <yosry.ahmed@linux.dev>, yipengxiang <yipengxiang@honor.com>
Subject: [PATCH v3] mm: Fix possible NULL pointer dereference in
 __swap_duplicate
Thread-Topic: [PATCH v3] mm: Fix possible NULL pointer dereference in
 __swap_duplicate
Thread-Index: Adt/iIz/pSZ7Q3r8TEmsD6w3AazKUA==
Date: Sat, 15 Feb 2025 09:05:51 +0000
Message-ID: <f8be2606fa114184a17a48f9859ec592@honor.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
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

QWRkIGEgTlVMTCBjaGVjayBvbiB0aGUgcmV0dXJuIHZhbHVlIG9mIHN3cF9zd2FwX2luZm8gaW4g
X19zd2FwX2R1cGxpY2F0ZQ0KdG8gcHJldmVudCBjcmFzaGVzIGNhdXNlZCBieSBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UuDQoNClRoZSByZWFzb24gd2h5IHN3cF9zd2FwX2luZm8oKSByZXR1cm5z
IE5VTEwgaXMgdW5jbGVhcjsgaXQgbWF5IGJlIGR1ZSB0bw0KQ1BVIGNhY2hlIGlzc3VlcyBvciBE
RFIgYml0IGZsaXBzLiBUaGUgcHJvYmFiaWxpdHkgb2YgdGhpcyBpc3N1ZSBpcyB2ZXJ5DQpzbWFs
bCwgYW5kIHRoZSBzdGFjayBpbmZvIHdlIGVuY291bnRlcmVkIGlzIGFzIGZvbGxvd3PvvJoNClVu
YWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFs
IGFkZHJlc3MNCjAwMDAwMDAwMDAwMDAwNTgNCltSQi9FXXJiX3NyZWFzb25fc3RyX3NldDogc3Jl
YXNvbl9zdHIgc2V0IG51bGxfcG9pbnRlcg0KTWVtIGFib3J0IGluZm86DQogIEVTUiA9IDB4MDAw
MDAwMDA5NjAwMDAwNQ0KICBFQyA9IDB4MjU6IERBQlQgKGN1cnJlbnQgRUwpLCBJTCA9IDMyIGJp
dHMNCiAgU0VUID0gMCwgRm5WID0gMA0KICBFQSA9IDAsIFMxUFRXID0gMA0KICBGU0MgPSAweDA1
OiBsZXZlbCAxIHRyYW5zbGF0aW9uIGZhdWx0DQpEYXRhIGFib3J0IGluZm86DQogIElTViA9IDAs
IElTUyA9IDB4MDAwMDAwMDUsIElTUzIgPSAweDAwMDAwMDAwDQogIENNID0gMCwgV25SID0gMCwg
VG5EID0gMCwgVGFnQWNjZXNzID0gMA0KICBHQ1MgPSAwLCBPdmVybGF5ID0gMCwgRGlydHlCaXQg
PSAwLCBYcyA9IDANCnVzZXIgcGd0YWJsZTogNGsgcGFnZXMsIDM5LWJpdCBWQXMsIHBnZHA9MDAw
MDAwMDhhODBlNTAwMA0KWzAwMDAwMDAwMDAwMDAwNThdIHBnZD0wMDAwMDAwMDAwMDAwMDAwLCBw
NGQ9MDAwMDAwMDAwMDAwMDAwMCwNCnB1ZD0wMDAwMDAwMDAwMDAwMDAwDQpJbnRlcm5hbCBlcnJv
cjogT29wczogMDAwMDAwMDA5NjAwMDAwNSBbIzFdIFBSRUVNUFQgU01QDQpTa2lwIG1kIGZ0cmFj
ZSBidWZmZXIgZHVtcCBmb3I6IDB4MTYwOWUwDQouLi4NCnBjIDogc3dhcF9kdXBsaWNhdGUrMHg0
NC8weDE2NA0KbHIgOiBjb3B5X3BhZ2VfcmFuZ2UrMHg1MDgvMHgxZTc4DQpzcCA6IGZmZmZmZmMw
ZjJhNjk5ZTANCngyOTogZmZmZmZmYzBmMmE2OTllMCB4Mjg6IGZmZmZmZjhhNWIyOGQzODggeDI3
OiBmZmZmZmY4YjA2NjAzMzg4DQp4MjY6IGZmZmZmZmRmNzI5MWZlNzAgeDI1OiAwMDAwMDAwMDAw
MDAwMDA2IHgyNDogMDAwMDAwMDAwMDEwMDA3Mw0KeDIzOiAwMDAwMDAwMDAwMmQyZDJmIHgyMjog
MDAwMDAwMDAwMDAwMDAwOCB4MjE6IDAwMDAwMDAwMDAwMDAwMDANCngyMDogMDAwMDAwMDAwMDJk
MmQyZiB4MTk6IDE4MDAwMDAwMDAyZDJkMmYgeDE4OiBmZmZmZmZkZjcyNmZhZWMwDQp4MTc6IDAw
MDAwMDAwMDAwMDAwMDAgeDE2OiAwMDEwMDAwMDAwMDAwMDAxIHgxNTogMDA0MDAwMDAwMDAwMDAw
MQ0KeDE0OiAwNDAwMDAwMDAwMDAwMDAxIHgxMzogZmY3ZmZmZmZmZmZmZmI3ZiB4MTI6IGZmZWZm
ZmZmZmZmZmZiZmYNCngxMTogZmZmZmZmOGE1YzdlMTg5OCB4MTA6IDAwMDAwMDAwMDAwMDAwMTgg
eDkgOiAwMDAwMDAwMDAwMDAwMDA2DQp4OCA6IDE4MDAwMDAwMDAwMDAwMDAgeDcgOiAwMDAwMDAw
MDAwMDAwMDAwIHg2IDogZmZmZmZmODA1N2MwMWYxMA0KeDUgOiAwMDAwMDAwMDAwMDBhMzE4IHg0
IDogMDAwMDAwMDAwMDAwMDAwMCB4MyA6IDAwMDAwMDAwMDAwMDAwMDANCngyIDogMDAwMDAwNmRh
ZjIwMDAwMCB4MSA6IDAwMDAwMDAwMDAwMDAwMDEgeDAgOiAxODAwMDAwMDAwMmQyZDJmDQpDYWxs
IHRyYWNlOg0KIHN3YXBfZHVwbGljYXRlKzB4NDQvMHgxNjQNCiBjb3B5X3BhZ2VfcmFuZ2UrMHg1
MDgvMHgxZTc4DQogY29weV9wcm9jZXNzKzB4MTI3OC8weDIxY2MNCiBrZXJuZWxfY2xvbmUrMHg5
MC8weDQzOA0KIF9fYXJtNjRfc3lzX2Nsb25lKzB4NWMvMHg4Yw0KIGludm9rZV9zeXNjYWxsKzB4
NTgvMHgxMTANCiBkb19lbDBfc3ZjKzB4OGMvMHhlMA0KIGVsMF9zdmMrMHgzOC8weDljDQogZWww
dF82NF9zeW5jX2hhbmRsZXIrMHg0NC8weGVjDQogZWwwdF82NF9zeW5jKzB4MWE4LzB4MWFjDQpD
b2RlOiA5MTM5YzM1YSA3MTAwNmYzZiA1NDAwMDU2OCBmODc5N2I1NSAoZjk0MDJlYTgpDQotLS1b
IGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0NCktlcm5lbCBwYW5pYyAtIG5vdCBzeW5j
aW5nOiBPb3BzOiBGYXRhbCBleGNlcHRpb24NClNNUDogc3RvcHBpbmcgc2Vjb25kYXJ5IENQVXMN
Cg0KVGhlIHBhdGNoIHNlZW1zIHRvIG9ubHkgcHJvdmlkZSBhIHdvcmthcm91bmQsIGJ1dCB0aGVy
ZSBhcmUgbm8gbW9yZQ0KZWZmZWN0aXZlIHNvZnR3YXJlIHNvbHV0aW9ucyB0byBoYW5kbGUgdGhl
IGJpdCBmbGlwcyBwcm9ibGVtLiBUaGlzIHBhdGgNCndpbGwgY2hhbmdlIHRoZSBpc3N1ZSBmcm9t
IGEgc3lzdGVtIGNyYXNoIHRvIGEgcHJvY2VzcyBleGNlcHRpb24sIHRoZXJlYnkNCnJlZHVjaW5n
IHRoZSBpbXBhY3Qgb24gdGhlIGVudGlyZSBtYWNoaW5lLg0KDQpTaWduZWQtb2ZmLWJ5OiBnYW8g
eHUgPGdhb3h1MkBob25vci5jb20+DQotLS0NCnYxIC0+IHYyOiANCi0gQWRkIFdBUk5fT05fT05D
RS4NCi0gdXBkYXRlIHRoZSBjb21taXQgaW5mby4NCnYyIC0+IHYzOiBEZWxldGUgdGhlIHJldmll
dyB0YWdzIChUaGlzIGlzIG15IGlzc3VlLCBhbmQgSSBhcG9sb2dpemUpLg0KLS0tDQoNCm1tL3N3
YXBmaWxlLmMgfCAyICsrDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZm
IC0tZ2l0IGEvbW0vc3dhcGZpbGUuYyBiL21tL3N3YXBmaWxlLmMNCmluZGV4IDc0NDhhMzg3Ni4u
YTBiZmRiYTk0IDEwMDY0NA0KLS0tIGEvbW0vc3dhcGZpbGUuYw0KKysrIGIvbW0vc3dhcGZpbGUu
Yw0KQEAgLTM1MjEsNiArMzUyMSw4IEBAIHN0YXRpYyBpbnQgX19zd2FwX2R1cGxpY2F0ZShzd3Bf
ZW50cnlfdCBlbnRyeSwgdW5zaWduZWQgY2hhciB1c2FnZSwgaW50IG5yKQ0KIAlpbnQgZXJyLCBp
Ow0KIA0KIAlzaSA9IHN3cF9zd2FwX2luZm8oZW50cnkpOw0KKwlpZiAoV0FSTl9PTl9PTkNFKCFz
aSkpDQorCQlyZXR1cm4gLUVJTlZBTDsNCiANCiAJb2Zmc2V0ID0gc3dwX29mZnNldChlbnRyeSk7
DQogCVZNX1dBUk5fT04obnIgPiBTV0FQRklMRV9DTFVTVEVSIC0gb2Zmc2V0ICUgU1dBUEZJTEVf
Q0xVU1RFUik7DQotLSANCjIuMTcuMQ0K

