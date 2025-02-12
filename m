Return-Path: <linux-kernel+bounces-510442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4D7A31CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D5217A3694
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263B41E1022;
	Wed, 12 Feb 2025 03:32:13 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ADB3597E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739331132; cv=none; b=JxNpPXGaZkXbO+z+oDsB1EqU6HDknGjK2VNB0IPHjnwu/TnnsT4D15oKxQMq1/kbkpHT5eLGa7Tj+XcI6B3nKd2N6Dyf1Hp9IZ0uHHgysEsK1fJI7X4qACmtxJTTXJC7UqRLgE8ZCosIwia0UNh5vETnp1YlYR3961UFxo8zvds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739331132; c=relaxed/simple;
	bh=glInTiBVeilIs24ZWvGBKoc7kufdh6XKYo4ictR/3Fk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qyiTaCnZK0wvzWS3ZTsMg44gsTS5ocn2ujdhgwQAKuqUrFGMjaktLkr9bSdJjf5NOUTdEIORh+r9sRoKrJWCgcJ1BVkzF4xs/C/XqHQItLkGdcFsM42NKN6yMFLxtPUVO2LYSIupx8egsGWSOuiZN5i89+zE2xr7gDHHYqqH+kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4Yt3K81Fg2zYlSjh;
	Wed, 12 Feb 2025 11:12:44 +0800 (CST)
Received: from a008.hihonor.com (10.68.30.56) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 12 Feb
 2025 11:13:46 +0800
Received: from a007.hihonor.com (10.68.22.31) by a008.hihonor.com
 (10.68.30.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 12 Feb
 2025 11:13:46 +0800
Received: from a007.hihonor.com ([fe80::e866:83ac:f23b:c25c]) by
 a007.hihonor.com ([fe80::e866:83ac:f23b:c25c%10]) with mapi id
 15.02.1544.011; Wed, 12 Feb 2025 11:13:46 +0800
From: gaoxu <gaoxu2@honor.com>
To: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, Barry Song <21cnbao@gmail.com>,
	yipengxiang <yipengxiang@honor.com>
Subject: [PATCH] mm: Fix possible NULL pointer dereference in __swap_duplicate
Thread-Topic: [PATCH] mm: Fix possible NULL pointer dereference in
 __swap_duplicate
Thread-Index: Adt8+0GogoLTL6hgQfOcUIXDGgpBSQ==
Date: Wed, 12 Feb 2025 03:13:46 +0000
Message-ID: <44655569e3a1419f800952004f07e714@honor.com>
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

c3dwX3N3YXBfaW5mbygpIG1heSByZXR1cm4gbnVsbDsgaXQgaXMgbmVjZXNzYXJ5IHRvIGNoZWNr
IHRoZSByZXR1cm4gdmFsdWUNCnRvIGF2b2lkIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZS4gVGhl
IGNvZGUgZm9yIG90aGVyIGNhbGxzIHRvDQpzd3Bfc3dhcF9pbmZvKCkgaW5jbHVkZXMgY2hlY2tz
LCBhbmQgX19zd2FwX2R1cGxpY2F0ZSgpIHNob3VsZCBhbHNvDQppbmNsdWRlIGNoZWNrcy4NCg0K
VGhlIHJlYXNvbiB3aHkgc3dwX3N3YXBfaW5mbygpIHJldHVybnMgTlVMTCBpcyB1bmNsZWFyOyBp
dCBtYXkgYmUgZHVlIHRvDQpDUFUgY2FjaGUgaXNzdWVzIG9yIEREUiBiaXQgZmxpcHMuIFRoZSBw
cm9iYWJpbGl0eSBvZiB0aGlzIGlzc3VlIGlzIHZlcnkNCnNtYWxsLCBhbmQgdGhlIHN0YWNrIGlu
Zm8gd2UgZW5jb3VudGVyZWQgaXMgYXMgZm9sbG93c++8mg0KVW5hYmxlIHRvIGhhbmRsZSBrZXJu
ZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcw0KMDAwMDAwMDAw
MDAwMDA1OA0KW1JCL0VdcmJfc3JlYXNvbl9zdHJfc2V0OiBzcmVhc29uX3N0ciBzZXQgbnVsbF9w
b2ludGVyDQpNZW0gYWJvcnQgaW5mbzoNCiAgRVNSID0gMHgwMDAwMDAwMDk2MDAwMDA1DQogIEVD
ID0gMHgyNTogREFCVCAoY3VycmVudCBFTCksIElMID0gMzIgYml0cw0KICBTRVQgPSAwLCBGblYg
PSAwDQogIEVBID0gMCwgUzFQVFcgPSAwDQogIEZTQyA9IDB4MDU6IGxldmVsIDEgdHJhbnNsYXRp
b24gZmF1bHQNCkRhdGEgYWJvcnQgaW5mbzoNCiAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDAwNSwg
SVNTMiA9IDB4MDAwMDAwMDANCiAgQ00gPSAwLCBXblIgPSAwLCBUbkQgPSAwLCBUYWdBY2Nlc3Mg
PSAwDQogIEdDUyA9IDAsIE92ZXJsYXkgPSAwLCBEaXJ0eUJpdCA9IDAsIFhzID0gMA0KdXNlciBw
Z3RhYmxlOiA0ayBwYWdlcywgMzktYml0IFZBcywgcGdkcD0wMDAwMDAwOGE4MGU1MDAwDQpbMDAw
MDAwMDAwMDAwMDA1OF0gcGdkPTAwMDAwMDAwMDAwMDAwMDAsIHA0ZD0wMDAwMDAwMDAwMDAwMDAw
LA0KcHVkPTAwMDAwMDAwMDAwMDAwMDANCkludGVybmFsIGVycm9yOiBPb3BzOiAwMDAwMDAwMDk2
MDAwMDA1IFsjMV0gUFJFRU1QVCBTTVANClNraXAgbWQgZnRyYWNlIGJ1ZmZlciBkdW1wIGZvcjog
MHgxNjA5ZTANCi4uLg0KcGMgOiBzd2FwX2R1cGxpY2F0ZSsweDQ0LzB4MTY0DQpsciA6IGNvcHlf
cGFnZV9yYW5nZSsweDUwOC8weDFlNzgNCnNwIDogZmZmZmZmYzBmMmE2OTllMA0KeDI5OiBmZmZm
ZmZjMGYyYTY5OWUwIHgyODogZmZmZmZmOGE1YjI4ZDM4OCB4Mjc6IGZmZmZmZjhiMDY2MDMzODgN
CngyNjogZmZmZmZmZGY3MjkxZmU3MCB4MjU6IDAwMDAwMDAwMDAwMDAwMDYgeDI0OiAwMDAwMDAw
MDAwMTAwMDczDQp4MjM6IDAwMDAwMDAwMDAyZDJkMmYgeDIyOiAwMDAwMDAwMDAwMDAwMDA4IHgy
MTogMDAwMDAwMDAwMDAwMDAwMA0KeDIwOiAwMDAwMDAwMDAwMmQyZDJmIHgxOTogMTgwMDAwMDAw
MDJkMmQyZiB4MTg6IGZmZmZmZmRmNzI2ZmFlYzANCngxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6
IDAwMTAwMDAwMDAwMDAwMDEgeDE1OiAwMDQwMDAwMDAwMDAwMDAxDQp4MTQ6IDA0MDAwMDAwMDAw
MDAwMDEgeDEzOiBmZjdmZmZmZmZmZmZmYjdmIHgxMjogZmZlZmZmZmZmZmZmZmJmZg0KeDExOiBm
ZmZmZmY4YTVjN2UxODk4IHgxMDogMDAwMDAwMDAwMDAwMDAxOCB4OSA6IDAwMDAwMDAwMDAwMDAw
MDYNCng4IDogMTgwMDAwMDAwMDAwMDAwMCB4NyA6IDAwMDAwMDAwMDAwMDAwMDAgeDYgOiBmZmZm
ZmY4MDU3YzAxZjEwDQp4NSA6IDAwMDAwMDAwMDAwMGEzMTggeDQgOiAwMDAwMDAwMDAwMDAwMDAw
IHgzIDogMDAwMDAwMDAwMDAwMDAwMA0KeDIgOiAwMDAwMDA2ZGFmMjAwMDAwIHgxIDogMDAwMDAw
MDAwMDAwMDAwMSB4MCA6IDE4MDAwMDAwMDAyZDJkMmYNCkNhbGwgdHJhY2U6DQogc3dhcF9kdXBs
aWNhdGUrMHg0NC8weDE2NA0KIGNvcHlfcGFnZV9yYW5nZSsweDUwOC8weDFlNzgNCiBjb3B5X3By
b2Nlc3MrMHgxMjc4LzB4MjFjYw0KIGtlcm5lbF9jbG9uZSsweDkwLzB4NDM4DQogX19hcm02NF9z
eXNfY2xvbmUrMHg1Yy8weDhjDQogaW52b2tlX3N5c2NhbGwrMHg1OC8weDExMA0KIGRvX2VsMF9z
dmMrMHg4Yy8weGUwDQogZWwwX3N2YysweDM4LzB4OWMNCiBlbDB0XzY0X3N5bmNfaGFuZGxlcisw
eDQ0LzB4ZWMNCiBlbDB0XzY0X3N5bmMrMHgxYTgvMHgxYWMNCkNvZGU6IDkxMzljMzVhIDcxMDA2
ZjNmIDU0MDAwNTY4IGY4Nzk3YjU1IChmOTQwMmVhOCkNCi0tLVsgZW5kIHRyYWNlIDAwMDAwMDAw
MDAwMDAwMDAgXS0tLQ0KS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IE9vcHM6IEZhdGFsIGV4
Y2VwdGlvbg0KU01QOiBzdG9wcGluZyBzZWNvbmRhcnkgQ1BVcw0KDQpUaGUgcGF0Y2ggc2VlbXMg
dG8gb25seSBwcm92aWRlIGEgd29ya2Fyb3VuZCwgYnV0IHRoZXJlIGFyZSBubyBtb3JlDQplZmZl
Y3RpdmUgc29mdHdhcmUgc29sdXRpb25zIHRvIGhhbmRsZSB0aGUgYml0IGZsaXBzIHByb2JsZW0u
IFRoaXMgcGF0aA0Kd2lsbCBjaGFuZ2UgdGhlIGlzc3VlIGZyb20gYSBzeXN0ZW0gY3Jhc2ggdG8g
YSBwcm9jZXNzIGV4Y2VwdGlvbiwgdGhlcmVieQ0KcmVkdWNpbmcgdGhlIGltcGFjdCBvbiB0aGUg
ZW50aXJlIG1hY2hpbmUuDQoNClNpZ25lZC1vZmYtYnk6IGdhbyB4dSA8Z2FveHUyQGhvbm9yLmNv
bT4NCi0tLQ0KIG1tL3N3YXBmaWxlLmMgfCAyICsrDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvbW0vc3dhcGZpbGUuYyBiL21tL3N3YXBmaWxlLmMNCmlu
ZGV4IDc0NDhhMzg3Ni4uMGIyNTNiOGNhIDEwMDY0NA0KLS0tIGEvbW0vc3dhcGZpbGUuYw0KKysr
IGIvbW0vc3dhcGZpbGUuYw0KQEAgLTM1MjEsNiArMzUyMSw4IEBAIHN0YXRpYyBpbnQgX19zd2Fw
X2R1cGxpY2F0ZShzd3BfZW50cnlfdCBlbnRyeSwgdW5zaWduZWQgY2hhciB1c2FnZSwgaW50IG5y
KQ0KIAlpbnQgZXJyLCBpOw0KIA0KIAlzaSA9IHN3cF9zd2FwX2luZm8oZW50cnkpOw0KKwlpZiAo
dW5saWtlbHkoIXNpKSkNCisJCXJldHVybiAtRUlOVkFMOw0KIA0KIAlvZmZzZXQgPSBzd3Bfb2Zm
c2V0KGVudHJ5KTsNCiAJVk1fV0FSTl9PTihuciA+IFNXQVBGSUxFX0NMVVNURVIgLSBvZmZzZXQg
JSBTV0FQRklMRV9DTFVTVEVSKTsNCi0tIA0KMi4xNy4xDQo=

