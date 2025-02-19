Return-Path: <linux-kernel+bounces-520784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E2EA3AF31
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8D5167760
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7A712CDAE;
	Wed, 19 Feb 2025 01:56:33 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A8314F70
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739930193; cv=none; b=p8440ujxnhP7zCrBb4oWn2PmldYgTqqldCHPXLGG+Q8hWNuPzBNcfKP8sa52Xdg2aF/3LmCfltscxu6ro6dlsqoLa6C7Z4JP0G/23gBCxXQYgR+RcytoFnLAxOCELyYpZW2hbY7QiZAzLwjVJEMBfgfkiptbGvE4XF94WSbGIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739930193; c=relaxed/simple;
	bh=Mc+kH8GEon/PVfC0HKf5NV/vmITYzF+FwowKOyfCJMk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hUQeej+J+PKeJGJqKb4ifL31a4V6aa7RPcj9oY4mWB18htxAf/iIl0Cv5yQqNOpxOIbqNqQI7B8KkuYNl7PTwJXEbkFtVkbYUYW3v15r72KU5JUYW6dv3jqk57pb9oSjrpJBhCwPJlbkGOdjoQ5FMnWudGh+HOPn9KhIz8bqbvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4YyKGw4XmzzYky7j;
	Wed, 19 Feb 2025 09:55:36 +0800 (CST)
Received: from a005.hihonor.com (10.68.18.24) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 19 Feb
 2025 09:56:29 +0800
Received: from a007.hihonor.com (10.68.22.31) by a005.hihonor.com
 (10.68.18.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 19 Feb
 2025 09:56:28 +0800
Received: from a007.hihonor.com ([fe80::e866:83ac:f23b:c25c]) by
 a007.hihonor.com ([fe80::e866:83ac:f23b:c25c%10]) with mapi id
 15.02.1544.011; Wed, 19 Feb 2025 09:56:28 +0800
From: gaoxu <gaoxu2@honor.com>
To: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, Barry Song <21cnbao@gmail.com>, "Yosry
 Ahmed" <yosry.ahmed@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v4] mm: Fix possible NULL pointer dereference in
 __swap_duplicate
Thread-Topic: [PATCH v4] mm: Fix possible NULL pointer dereference in
 __swap_duplicate
Thread-Index: AduCcQRTKSEr86o5RfKgi/48SSQ2Jw==
Date: Wed, 19 Feb 2025 01:56:28 +0000
Message-ID: <e223b0e6ba2f4924984b1917cc717bd5@honor.com>
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
dyB0YWdzIChUaGlzIGlzIG15IGlzc3VlLCBhbmQgSSBhcG9sb2dpemUpLg0KVjMgLT4gdjQ6IEFk
ZCBzd2FwIGVudHJ5IGxvZ2dpbmcgcGVyIEJhcnJ5IFNvbmcncyBzdWdnZXN0aW9uLg0KLS0tDQog
bW0vc3dhcGZpbGUuYyB8IDQgKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL21tL3N3YXBmaWxlLmMgYi9tbS9zd2FwZmlsZS5jDQppbmRleCA3NDQ4
YTM4NzYuLjQwM2RmMTgxNyAxMDA2NDQNCi0tLSBhL21tL3N3YXBmaWxlLmMNCisrKyBiL21tL3N3
YXBmaWxlLmMNCkBAIC0zNTIxLDYgKzM1MjEsMTAgQEAgc3RhdGljIGludCBfX3N3YXBfZHVwbGlj
YXRlKHN3cF9lbnRyeV90IGVudHJ5LCB1bnNpZ25lZCBjaGFyIHVzYWdlLCBpbnQgbnIpDQogCWlu
dCBlcnIsIGk7DQogDQogCXNpID0gc3dwX3N3YXBfaW5mbyhlbnRyeSk7DQorCWlmIChXQVJOX09O
X09OQ0UoIXNpKSkgew0KKwkJcHJfZXJyKCIlcyUwOGx4XG4iLCBCYWRfZmlsZSwgZW50cnkudmFs
KTsNCisJCXJldHVybiAtRUlOVkFMOw0KKwl9DQogDQogCW9mZnNldCA9IHN3cF9vZmZzZXQoZW50
cnkpOw0KIAlWTV9XQVJOX09OKG5yID4gU1dBUEZJTEVfQ0xVU1RFUiAtIG9mZnNldCAlIFNXQVBG
SUxFX0NMVVNURVIpOw0KLS0gDQoyLjE3LjENCg==

