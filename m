Return-Path: <linux-kernel+bounces-576519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5223DA71051
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B32174922
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E9F1714B4;
	Wed, 26 Mar 2025 06:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="CllUNNpr"
Received: from mail.crpt.ru (mail1.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B267A937
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742968907; cv=none; b=aQrhq8xWuzadkK+UCR+0Yu0bPwpl+9EbukULc8VY0Zc1mglfCCOgXVI19BP4MFqIF6Kxfvo5j5eV+SwUoO2My1+LFFPXbsOhuCpfNoMSYkkiM4IpBs4S3SaA9o8YGiX46rjrCNLKqjurYkfnsZmG/fFI8du6G1Pe+Z888qHZggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742968907; c=relaxed/simple;
	bh=SMaYKshq3acZS99u+26mBuayTpIg9iiDJLeo1mA0VVw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EthuEmTFjqeXn2GG0yEqBOIKJzbVTa0m+BVl6uH3WCPt7PqGuK3ijYTNztieHsvxuY+z4VafAY2QAuOKLGWzPbw+cZ51BFsCMqWbTT7cqI4EBcEIkB5g2V+SezUO2PoZek/umOYUYPCMjpV8O339tPtGPMy8qwecXVoQRrvnM+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=CllUNNpr; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTP id 52Q61Joa020126-52Q61Joc020126
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Wed, 26 Mar 2025 09:01:19 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 26 Mar
 2025 09:01:19 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Wed, 26 Mar 2025 09:01:19 +0300
From: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>
To: Kenneth Feng <kenneth.feng@amd.com>
CC: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>, Alex Deucher <alexander.deucher@amd.com>,
	=?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sunil Khatri
	<sunil.khatri@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Tim Huang
	<tim.huang@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>, "chr[]"
	<chris@rudorff.com>, Yang Wang <kevinyang.wang@amd.com>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH] drm/amdgpu: Remove the redundant NULL check for the
 'dte_data' object
Thread-Topic: [PATCH] drm/amdgpu: Remove the redundant NULL check for the
 'dte_data' object
Thread-Index: AQHbnhR++EzAa3ZlHUaU6nruSXfbmA==
Date: Wed, 26 Mar 2025 06:01:19 +0000
Message-ID: <20250326060059.15335-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX2.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 3/25/2025 10:34:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 192.168.60.4
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=SMaYKshq3acZS99u+26mBuayTpIg9iiDJLeo1mA0VVw=;
 b=CllUNNprfqAVkUe2LfYNfFiPe7WMQzwbnbuJtW0m+s8PkL+AJkIj+8zMRaAVBLiGsiJDtTrEFnJe
	EsS7DF4vmctwRzwIqkiUzmST1HJouD36NU6huwOlk87t+qWFiPQvDDWgcAIh2Udaw7X9LY/RczJ6
	T7eCVTeT4zU+rJqyLF/QxMNF/GOM6zz0y5QyT+jLDA2nmMJK2Pw2cf6+/UP23nzI54UoHKFxiCCB
	yAh0hEYvgylQbezRe7VFC46DeAmZpz+A4Fzvz3trCHSnDssFEe6HSoPbLA/z1W8Uxzv1dayWoLgz
	tHKH/9A1WnnIWfdfa94EFaNhirsQHC/C+Ho4DQ==

RnJvbTogQW5kcmV5IFZhdG9yb3BpbiA8YS52YXRvcm9waW5AY3JwdC5ydT4NCg0KU3RhdGljIGFu
YWx5c2lzIHNob3dzIHRoYXQgcG9pbnRlciAiZHRlX2RhdGEiIGNhbm5vdCBiZSBOVUxMIGJlY2F1
c2UgaXQgDQpwb2ludHMgdG8gdGhlIG9iamVjdCAic3RydWN0IHNpX2R0ZV9kYXRhIi4NCg0KUmVt
b3ZlIHRoZSBleHRyYSBOVUxMIGNoZWNrLiBJdCBpcyBtZWFuaW5nbGVzcyBhbmQgaGFybXMgdGhl
IHJlYWRhYmlsaXR5DQpvZiB0aGUgY29kZS4NCg0KRm91bmQgYnkgTGludXggVmVyaWZpY2F0aW9u
IENlbnRlciAobGludXh0ZXN0aW5nLm9yZykgd2l0aCBTVkFDRS4NCg0KU2lnbmVkLW9mZi1ieTog
QW5kcmV5IFZhdG9yb3BpbiA8YS52YXRvcm9waW5AY3JwdC5ydT4NCi0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vbGVnYWN5LWRwbS9zaV9kcG0uYyB8IDMgLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2xl
Z2FjeS1kcG0vc2lfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2xlZ2FjeS1kcG0vc2lf
ZHBtLmMNCmluZGV4IGQ2ZGZlMjU5OWViZS4uMzJlNmE4MTVlNjA5IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9sZWdhY3ktZHBtL3NpX2RwbS5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL2xlZ2FjeS1kcG0vc2lfZHBtLmMNCkBAIC0yNTY3LDkgKzI1NjcsNiBAQCBz
dGF0aWMgaW50IHNpX2luaXRpYWxpemVfc21jX2R0ZV90YWJsZXMoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpDQogCXU4IHRkZXBfY291bnQ7DQogCXUzMiBpOw0KIA0KLQlpZiAoZHRlX2RhdGEg
PT0gTlVMTCkNCi0JCXNpX3BpLT5lbmFibGVfZHRlID0gZmFsc2U7DQotDQogCWlmIChzaV9waS0+
ZW5hYmxlX2R0ZSA9PSBmYWxzZSkNCiAJCXJldHVybiAwOw0KIA0KLS0gDQoyLjQzLjANCg==

