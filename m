Return-Path: <linux-kernel+bounces-520946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55272A3B191
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE9F3AFD5A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 06:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EBC1B87F8;
	Wed, 19 Feb 2025 06:23:54 +0000 (UTC)
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6D16D9AF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946234; cv=none; b=b+Z8uARcGEMBqBrEJ7Ox4Jy4JsYu9wk3m4hh6F0HMw1uU/3/spVK45kyK3heqPwFNlTMNQPhS9zHUNdrHbbZL4mrLoJOsSNHyUiodddKS0Qque6lwo9f5Z9k8Kvi8Jw4HNl6RCbKe1q/r71kdRbGQED1GQNbZ9sa5LHTSRlaE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946234; c=relaxed/simple;
	bh=1hIJCWwGC953Ijo4lalx+UZSk476OHtXAIu9d88Nxy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bwsthJlLc1fwZ/JnzfUTEo/lVC3tVf+bwkUSH4+6k1M4Hd5AmiWNTut+LUTC+OjjTuKIC6qdX+XuDOE517yUifOKVVv+Ez0IE3pIoN3IbiFuQnH0cXy2z9aXE3vCVK6IzyTCXeUbWtWS96fJIBuv8AcHzHfiL2rT9b03vmR6yhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4YyRCx3dqnzYlZ3B;
	Wed, 19 Feb 2025 14:23:25 +0800 (CST)
Received: from a008.hihonor.com (10.68.30.56) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 19 Feb
 2025 14:23:43 +0800
Received: from a007.hihonor.com (10.68.22.31) by a008.hihonor.com
 (10.68.30.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 19 Feb
 2025 14:23:43 +0800
Received: from a007.hihonor.com ([fe80::e866:83ac:f23b:c25c]) by
 a007.hihonor.com ([fe80::e866:83ac:f23b:c25c%10]) with mapi id
 15.02.1544.011; Wed, 19 Feb 2025 14:23:42 +0800
From: gaoxu <gaoxu2@honor.com>
To: Andrew Morton <akpm@linux-foundation.org>, Barry Song <21cnbao@gmail.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, Yosry
 Ahmed <yosry.ahmed@linux.dev>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjRdIG1tOiBGaXggcG9zc2libGUgTlVMTCBwb2lu?=
 =?utf-8?B?dGVyIGRlcmVmZXJlbmNlIGluIF9fc3dhcF9kdXBsaWNhdGU=?=
Thread-Topic: [PATCH v4] mm: Fix possible NULL pointer dereference in
 __swap_duplicate
Thread-Index: AduCcQRTKSEr86o5RfKgi/48SSQ2J///g8MAgAAaroD//1MYUA==
Date: Wed, 19 Feb 2025 06:23:42 +0000
Message-ID: <d9676b1355e84820aeeda18a1c77297a@honor.com>
References: <e223b0e6ba2f4924984b1917cc717bd5@honor.com>
	<CAGsJ_4y9eoHRSUSzs96UWUVygEDcoTQqFM1uyEtr_VHcmAmVDw@mail.gmail.com>
 <20250218200355.959a79bf9b6253772a95e782@linux-foundation.org>
In-Reply-To: <20250218200355.959a79bf9b6253772a95e782@linux-foundation.org>
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

PiANCj4gT24gV2VkLCAxOSBGZWIgMjAyNSAxNToyODoyNiArMTMwMCBCYXJyeSBTb25nIDwyMWNu
YmFvQGdtYWlsLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+ID4gVGhlIHBhdGNoIHNlZW1zIHRvIG9u
bHkgcHJvdmlkZSBhIHdvcmthcm91bmQsIGJ1dCB0aGVyZSBhcmUgbm8gbW9yZQ0KPiA+ID4gZWZm
ZWN0aXZlIHNvZnR3YXJlIHNvbHV0aW9ucyB0byBoYW5kbGUgdGhlIGJpdCBmbGlwcyBwcm9ibGVt
LiBUaGlzDQo+ID4gPiBwYXRoIHdpbGwgY2hhbmdlIHRoZSBpc3N1ZSBmcm9tIGEgc3lzdGVtIGNy
YXNoIHRvIGEgcHJvY2Vzcw0KPiA+ID4gZXhjZXB0aW9uLCB0aGVyZWJ5IHJlZHVjaW5nIHRoZSBp
bXBhY3Qgb24gdGhlIGVudGlyZSBtYWNoaW5lLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IGdhbyB4dSA8Z2FveHUyQGhvbm9yLmNvbT4NCj4gPg0KPiA+IFJlZ2FyZGxlc3Mgb2Ygd2hldGhl
ciB0aGUgYWJvdmUgc3RhdGVtZW50IGlzIDEwMCUgYWNjdXJhdGUgb3Igd2hldGhlcg0KPiA+IGEg
Yml0LWZsaXAgYWN0dWFsbHkgZXhpc3RzLCBwcm92aWRpbmcgdGhpcyBjaGVjayBzdGlsbCBzZWVt
cyB1c2VmdWwsDQo+ID4gYXQgbGVhc3QgZm9yIGRlZmVuc2l2ZSBwcm9ncmFtbWluZy4NCj4gDQo+
IEknbSBkb3VidGZ1bCBhcyB3ZWxsLg0KPiANCj4gSG93IG9mdGVuIGhhcyB0aGlzIGNyYXNoIGJl
ZW4gb2JzZXJ2ZWQ/DQpUaGUgcHJvYmFiaWxpdHkgb2YgdGhpcyBpc3N1ZSBvY2N1cnJpbmcgaXMg
YXBwcm94aW1hdGVseSAxIGluIDUwMCwwMDAgcGVyIHdlZWsuDQo=

