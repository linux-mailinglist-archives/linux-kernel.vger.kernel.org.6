Return-Path: <linux-kernel+bounces-516044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0FFA36C59
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 07:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC771895573
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 06:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EC8186E54;
	Sat, 15 Feb 2025 06:52:33 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62911537AC
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739602352; cv=none; b=eZpQpDuHjGoO9SzzkCHLDURWeRMCsMa/Kt57Bl5TOpmJ14ANYbIqtbWsF5hgzcMY7eXaHFo8EolifQnB9WrZo6RKyNMOmCDdSuDQiDNpnf9d0/h9Hy8dxetaEiP8zFNaFZmYVpjjWIQa+GkGgYtR6NfCe9mL1hGiFx7v68qn5QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739602352; c=relaxed/simple;
	bh=B5daVWDTDqP2Yx99kFYFc03Cv9SbMm8A4TyCIPOOYL4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BBdXJ/xEUZCJWZFJDcW4+UW1mxqyyISx9Yt5ZE23PiSadvhtFNofnVW8kfxcDskTIGj1UO+MJA6m0PtNohW1EZddb48JLQqVkoOweb8ZldHLs52EjfE0XwRzIlLIwDKYHnmXR19ChYu+8co2whIetV3Uu+LVN+lmfVEK9XKFgJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4Yw02C4HlNzYlYwF;
	Sat, 15 Feb 2025 14:51:31 +0800 (CST)
Received: from a002.hihonor.com (10.68.31.193) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 15 Feb
 2025 14:52:21 +0800
Received: from a007.hihonor.com (10.68.22.31) by a002.hihonor.com
 (10.68.31.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 15 Feb
 2025 14:52:21 +0800
Received: from a007.hihonor.com ([fe80::e866:83ac:f23b:c25c]) by
 a007.hihonor.com ([fe80::e866:83ac:f23b:c25c%10]) with mapi id
 15.02.1544.011; Sat, 15 Feb 2025 14:52:21 +0800
From: gaoxu <gaoxu2@honor.com>
To: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, Barry Song <21cnbao@gmail.com>, "Yosry
 Ahmed" <yosry.ahmed@linux.dev>, yipengxiang <yipengxiang@honor.com>
Subject: [PATCH v2] mm: Fix possible NULL pointer dereference in
 __swap_duplicate
Thread-Topic: [PATCH v2] mm: Fix possible NULL pointer dereference in
 __swap_duplicate
Thread-Index: Adt/c+jLXWIUvZ+8S8+6YIq3M7UYAQ==
Date: Sat, 15 Feb 2025 06:52:21 +0000
Message-ID: <afecae337e5b4b2b8ce4e5a591957f89@honor.com>
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
IHRoZSBpbXBhY3Qgb24gdGhlIGVudGlyZSBtYWNoaW5lLg0KDQpTaWduZWQtb2ZmLWJ5OiBnYW94
dSA8Z2FveHUyQGhvbm9yLmNvbT4NClJldmlld2VkLWJ5OiBZb3NyeSBBaG1lZCA8eW9zcnkuYWht
ZWRAbGludXguZGV2Pg0KLS0tDQp2MSAtPiB2MjogDQotIEFkZCBXQVJOX09OX09OQ0UuDQotIHVw
ZGF0ZSB0aGUgY29tbWl0IGluZm8uDQoNCm1tL3N3YXBmaWxlLmMgfCAyICsrDQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvbW0vc3dhcGZpbGUuYyBiL21t
L3N3YXBmaWxlLmMNCmluZGV4IDc0NDhhMzg3Ni4uYTBiZmRiYTk0IDEwMDY0NA0KLS0tIGEvbW0v
c3dhcGZpbGUuYw0KKysrIGIvbW0vc3dhcGZpbGUuYw0KQEAgLTM1MjEsNiArMzUyMSw4IEBAIHN0
YXRpYyBpbnQgX19zd2FwX2R1cGxpY2F0ZShzd3BfZW50cnlfdCBlbnRyeSwgdW5zaWduZWQgY2hh
ciB1c2FnZSwgaW50IG5yKQ0KIAlpbnQgZXJyLCBpOw0KIA0KIAlzaSA9IHN3cF9zd2FwX2luZm8o
ZW50cnkpOw0KKwlpZiAoV0FSTl9PTl9PTkNFKCFzaSkpDQorCQlyZXR1cm4gLUVJTlZBTDsNCiAN
CiAJb2Zmc2V0ID0gc3dwX29mZnNldChlbnRyeSk7DQogCVZNX1dBUk5fT04obnIgPiBTV0FQRklM
RV9DTFVTVEVSIC0gb2Zmc2V0ICUgU1dBUEZJTEVfQ0xVU1RFUik7DQotLSANCjIuMTcuMQ0K

