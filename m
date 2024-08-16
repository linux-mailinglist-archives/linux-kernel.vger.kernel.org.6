Return-Path: <linux-kernel+bounces-289247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02D595439D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DE41B2398D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B818F80C0C;
	Fri, 16 Aug 2024 08:03:19 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12E54645
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795399; cv=none; b=FgjneIAl9Sb8+sM+hE+gRbrPZqp1obUKCiGZt9i9QZkYT/dkF/FrXufMt6yAkTkRp/2LScAmiORZuNUIciGnFKujE26qnNGO1Zs4vdFGAFVeLBNEMy5kFIjzR3DfX9WyM24QLTyVsvVrcZ+2EXxxd4SHL7lkwMnlQwLvQgUR9vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795399; c=relaxed/simple;
	bh=g4mcBYcFzhVMu5gQ+5WbNAYNu5fDd7oX3yiksydV/lw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JMI/5uUa5OCuF4XKogkHypqUfoJ8qNL+fyBOfFmAUNqFdw8pVQfAIkcnbht2COuGmELZhOGuUvag7JjqO6o8CmyUBtJ5FxxlMFX3TWg/wM5k4edwg/CIvFYHTZTHsafz/Xd5ncLTFdNAxZdI6mxIB57oNUTs5W47t/7/fbJHufU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4WlYwn1NRmzYnC3q;
	Fri, 16 Aug 2024 15:47:05 +0800 (CST)
Received: from a016.hihonor.com (10.68.16.211) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Aug
 2024 15:48:02 +0800
Received: from a007.hihonor.com (10.68.22.31) by a016.hihonor.com
 (10.68.16.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Aug
 2024 15:48:01 +0800
Received: from a007.hihonor.com ([fe80::4407:dd67:71d7:ea82]) by
 a007.hihonor.com ([fe80::4407:dd67:71d7:ea82%10]) with mapi id
 15.02.1544.011; Fri, 16 Aug 2024 15:48:01 +0800
From: gaoxu <gaoxu2@honor.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>,
	Shaohua Li <shli@fb.com>, yipengxiang <yipengxiang@honor.com>, fengbaopeng
	<fengbaopeng@honor.com>, Kalesh Singh <kaleshsingh@google.com>
Subject: [PATCH v2] mm: add lazyfree folio to lru tail
Thread-Topic: [PATCH v2] mm: add lazyfree folio to lru tail
Thread-Index: Adrvp/sHXyayf1r5TQG6pnGY8/qB0A==
Date: Fri, 16 Aug 2024 07:48:01 +0000
Message-ID: <f29f64e29c08427b95e3df30a5770056@honor.com>
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

UmVwbGFjZSBscnV2ZWNfYWRkX2ZvbGlvIHdpdGggbHJ1dmVjX2FkZF9mb2xpb190YWlsIGluIHRo
ZSBscnVfbGF6eWZyZWVfZm46DQoxLiBUaGUgbGF6eS1mcmVlIGZvbGlvIGlzIGFkZGVkIHRvIHRo
ZSBMUlVfSU5BQ1RJVkVfRklMRSBsaXN0LiBJZiBpdCdzDQogICBtb3ZlZCB0byB0aGUgTFJVIHRh
aWwsIGl0IGFsbG93cyBmb3IgZmFzdGVyIHJlbGVhc2UgbGF6eS1mcmVlIGZvbGlvIGFuZA0KICAg
cmVkdWNlcyB0aGUgaW1wYWN0IG9uIGZpbGUgcmVmYXVsdC4NCjIuIFdoZW4gbWdscnUgaXMgZW5h
YmxlZCwgdGhlIGxhenktZnJlZSBmb2xpbyBpcyByZWNsYWltYWJsZWQgYW5kIHNob3VsZCBiZQ0K
ICAgYWRkZWQgdXNpbmcgbHJ1X2dlbl9hZGRfZm9saW8obHJ1dmVjLCBmb2xpbywgdHJ1ZSkgaW5z
dGVhZCBvZg0KICAgbHJ1X2dlbl9hZGRfZm9saW8obHJ1dmVjLCBmb2xpbywgZmFsc2UpIGZvciBh
ZGRpbmcgdG8gZ2VuLg0KDQpXaXRoIHRoZSBjaGFuZ2UgaW4gcGxhY2UsIHdvcmtpbmdzZXRfcmVm
YXVsdF9maWxlIGlzIHJlZHVjZWQgYnkgMzMlIGluIHRoZQ0KY29udGludW91cyBzdGFydHVwIHRl
c3Rpbmcgb2YgdGhlIGFwcGxpY2F0aW9ucyBpbiB0aGUgQW5kcm9pZCBzeXN0ZW0uDQoNClNpZ25l
ZC1vZmYtYnk6IGdhbyB4dSA8Z2FveHUyQGhpaG9ub3IuY29tPg0KLS0tDQpWMSAtPiBWMjogQmFz
ZWQgb24gdGhlIGxhdGVzdCBtbS11bnN0YWJsZSwgcmVjcmVhdGUgdGhlIHBhdGNoLg0KDQogbW0v
c3dhcC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvbW0vc3dhcC5jIGIvbW0vc3dhcC5jDQppbmRleCA2YjgzODk4
NmQuLmUwZGJmYzk4MyAxMDA2NDQNCi0tLSBhL21tL3N3YXAuYw0KKysrIGIvbW0vc3dhcC5jDQpA
QCAtNjQxLDcgKzY0MSw3IEBAIHN0YXRpYyB2b2lkIGxydV9sYXp5ZnJlZShzdHJ1Y3QgbHJ1dmVj
ICpscnV2ZWMsIHN0cnVjdCBmb2xpbyAqZm9saW8pDQogCSAqIGFub255bW91cyBmb2xpb3MNCiAJ
ICovDQogCWZvbGlvX2NsZWFyX3N3YXBiYWNrZWQoZm9saW8pOw0KLQlscnV2ZWNfYWRkX2ZvbGlv
KGxydXZlYywgZm9saW8pOw0KKwlscnV2ZWNfYWRkX2ZvbGlvX3RhaWwobHJ1dmVjLCBmb2xpbyk7
DQogDQogCV9fY291bnRfdm1fZXZlbnRzKFBHTEFaWUZSRUUsIG5yX3BhZ2VzKTsNCiAJX19jb3Vu
dF9tZW1jZ19ldmVudHMobHJ1dmVjX21lbWNnKGxydXZlYyksIFBHTEFaWUZSRUUsIG5yX3BhZ2Vz
KTsNCi0tIA0KMi4xNy4xDQo=

