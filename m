Return-Path: <linux-kernel+bounces-287960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46461952E93
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A241C23A43
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB4919AD8E;
	Thu, 15 Aug 2024 12:52:43 +0000 (UTC)
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0971993BC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726363; cv=none; b=bZEwkoCGobVp08yJKu12R711jLGmkgDXwZATY/tiJj7vefBiKkee6BD2DlZ2a8wsLNrG/wwmPJtoarUKy2kzVh2J7GUMdhpLwjuMeBAug73ANGvi3VjVuzTbmBF3MPckV9HfojIliK5cz38If7v9WLkevGtplZDnFBh07KQMC/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726363; c=relaxed/simple;
	bh=wzIkoAnvjNhC8IujAHq4bsBjuM4OFfBPrl1PuZoYHYI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l9VwhltdDNT9chAZPRAjkYl/IMHsuoZkEruKHmgkM/W7FUoza2pVGiYB+A2KOFumGxX/iPsviWnWvceHIU5nlUbRhAuSDCUjk6hC13zBNiBYKATkoL2knE+N7gqUKnfdulJYh2XME/MqIEIqb4IxJZutRdBLmM0NF5WCtLoEp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4Wl4Gh0MjTzYkxh6;
	Thu, 15 Aug 2024 20:30:52 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Aug
 2024 20:33:10 +0800
Received: from a007.hihonor.com (10.68.22.31) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Aug
 2024 20:33:10 +0800
Received: from a007.hihonor.com ([fe80::4407:dd67:71d7:ea82]) by
 a007.hihonor.com ([fe80::4407:dd67:71d7:ea82%10]) with mapi id
 15.02.1544.011; Thu, 15 Aug 2024 20:33:09 +0800
From: gaoxu <gaoxu2@honor.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, "Yu
 Zhao" <yuzhao@google.com>, Shaohua Li <shli@fb.com>, yipengxiang
	<yipengxiang@honor.com>, fengbaopeng <fengbaopeng@honor.com>
Subject: [PATCH] mm: add lazyfree folio to lru tail
Thread-Topic: [PATCH] mm: add lazyfree folio to lru tail
Thread-Index: AdrvDo5mhFpHwjY+TGSie/L6+cGQzQ==
Date: Thu, 15 Aug 2024 12:33:09 +0000
Message-ID: <37bbf461e81342a7b5798923b783e349@honor.com>
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
ZC1vZmYtYnk6IGdhbyB4dSA8Z2FveHUyQGhpaG9ub3IuY29tPg0KLS0tDQogbW0vc3dhcC5jIHwg
MiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpk
aWZmIC0tZ2l0IGEvbW0vc3dhcC5jIGIvbW0vc3dhcC5jDQppbmRleCA2Nzc4NmNiNzcuLmVkNDk2
NDNlYyAxMDA2NDQNCi0tLSBhL21tL3N3YXAuYw0KKysrIGIvbW0vc3dhcC5jDQpAQCAtNjM1LDcg
KzYzNSw3IEBAIHN0YXRpYyB2b2lkIGxydV9sYXp5ZnJlZV9mbihzdHJ1Y3QgbHJ1dmVjICpscnV2
ZWMsIHN0cnVjdCBmb2xpbyAqZm9saW8pDQogCQkgKiBhbm9ueW1vdXMgZm9saW9zDQogCQkgKi8N
CiAJCWZvbGlvX2NsZWFyX3N3YXBiYWNrZWQoZm9saW8pOw0KLQkJbHJ1dmVjX2FkZF9mb2xpbyhs
cnV2ZWMsIGZvbGlvKTsNCisJCWxydXZlY19hZGRfZm9saW9fdGFpbChscnV2ZWMsIGZvbGlvKTsN
CiANCiAJCV9fY291bnRfdm1fZXZlbnRzKFBHTEFaWUZSRUUsIG5yX3BhZ2VzKTsNCiAJCV9fY291
bnRfbWVtY2dfZXZlbnRzKGxydXZlY19tZW1jZyhscnV2ZWMpLCBQR0xBWllGUkVFLA0KLS0gDQoy
LjE3LjENCg==

