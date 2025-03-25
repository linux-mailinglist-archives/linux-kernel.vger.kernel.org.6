Return-Path: <linux-kernel+bounces-575081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0933A6ED52
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD262188E60D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D771EA7F7;
	Tue, 25 Mar 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="RjGeU7e1"
Received: from mail.crpt.ru (mail1.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC861A2389
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897380; cv=none; b=GPwsh3DW8mJOJSmKNgBFv5QxFdlznHBbVrApxKVi62X9+ZvAgJyI+TMID4bjdv2tuvPAnoifA5K5F3oaXNUktESGlwMB1u1qWumHLLenVx2/9BZzRRGoXWu36PlLlRtRTf0txegTvI/gy9w8xKxotY1o8TwbZYYcqxAQwF0dZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897380; c=relaxed/simple;
	bh=S8ZTcQtvS2V8JjQOpgLS5GBUFk1XIB89xcUDwVmVR60=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VFBz1JjNBFeF3ub0fkJCaZ5cximx3323KcIq03eUbif38jVYfLlpBgZwWO02/Ti3fmt84+ataVw7xky0dhfgGuRlR1PPGKJO/IESdGNPDqot2ouryfLZ37Eebfbn+3QtxP2jGgz6bKhxFVzudHN+wLnnJQcAv5I5a9eHSiw5Jo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=RjGeU7e1; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTP id 52PA9FXR017359-52PA9FXT017359
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Tue, 25 Mar 2025 13:09:15 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 13:09:16 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Tue, 25 Mar 2025 13:09:16 +0300
From: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>
To: Felix Kuehling <Felix.Kuehling@amd.com>
CC: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>, Alex Deucher <alexander.deucher@amd.com>,
	=?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH] drm/amdkfd: Remove the redundant NULL check for the 'svms'
 object
Thread-Topic: [PATCH] drm/amdkfd: Remove the redundant NULL check for the
 'svms' object
Thread-Index: AQHbnW33CeLhAJikwUeO11Tuz1gnSA==
Date: Tue, 25 Mar 2025 10:09:15 +0000
Message-ID: <20250325100908.68325-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX2.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 3/24/2025 10:00:00 PM
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
 bh=S8ZTcQtvS2V8JjQOpgLS5GBUFk1XIB89xcUDwVmVR60=;
 b=RjGeU7e15VmA3QoUPYBidpFwzm6fOZoMgccWwzeAXxPH+LRrdeMZmoIRzoGbqCZI7KIsAeuw7UqK
	R6c42I69wLyOZzeSXFiJuiYZRaIHcr+DiO0mxHVZnpzS0mMAf30T0C2MqjxFJ+4/HwQEc0HLJpKb
	OLBoPjiXkNy0zd4Wr5XuKGupkg3gpy1Tk5rvADmy3iuMmYLr08c2NoRiqossJLU2uEeHQ/n9qFfk
	WRn7hhzvisIvj/499sk8H2vSbh1friBeesyI3ubP+3DW0pJdqGnFKSebR4xHemCyaZguosOnstPi
	JKZN0yD1Btp5ReqwuQSquTWOdJSPBd0uOpiaqg==

RnJvbTogQW5kcmV5IFZhdG9yb3BpbiA8YS52YXRvcm9waW5AY3JwdC5ydT4NCg0KU3RhdGljIGFu
YWx5c2lzIHNob3dzIHRoYXQgcG9pbnRlciAic3ZtcyIgY2Fubm90IGJlIE5VTEwgYmVjYXVzZSBp
dCBwb2ludHMNCnRvIHRoZSBvYmplY3QgInN0cnVjdCBzdm1fcmFuZ2VfbGlzdCIuDQoNClJlbW92
ZSB0aGUgZXh0cmEgTlVMTCBjaGVjay4gSXQgaXMgbWVhbmluZ2xlc3MgYW5kIGhhcm1zIHRoZSBy
ZWFkYWJpbGl0eQ0Kb2YgdGhlIGNvZGUuDQoNCkZvdW5kIGJ5IExpbnV4IFZlcmlmaWNhdGlvbiBD
ZW50ZXIgKGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU1ZBQ0UuDQpTaWduZWQtb2ZmLWJ5OiBBbmRy
ZXkgVmF0b3JvcGluIDxhLnZhdG9yb3BpbkBjcnB0LnJ1Pg0KLS0tDQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX3N2bS5jIHwgNCAtLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3Zt
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMNCmluZGV4IGJkM2UyMGQ5
ODFlMC4uOWYwYzZiNjIzMTc2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3N2bS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMN
CkBAIC00MDg5LDggKzQwODksNiBAQCBpbnQgc3ZtX3JhbmdlX2dldF9pbmZvKHN0cnVjdCBrZmRf
cHJvY2VzcyAqcCwgdWludDMyX3QgKm51bV9zdm1fcmFuZ2VzLA0KIAkqc3ZtX3ByaXZfZGF0YV9z
aXplID0gMDsNCiANCiAJc3ZtcyA9ICZwLT5zdm1zOw0KLQlpZiAoIXN2bXMpDQotCQlyZXR1cm4g
LUVJTlZBTDsNCiANCiAJbXV0ZXhfbG9jaygmc3Ztcy0+bG9jayk7DQogCWxpc3RfZm9yX2VhY2hf
ZW50cnkocHJhbmdlLCAmc3Ztcy0+bGlzdCwgbGlzdCkgew0KQEAgLTQxNDksOCArNDE0Nyw2IEBA
IGludCBrZmRfY3JpdV9jaGVja3BvaW50X3N2bShzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsDQogCXN0
cnVjdCBtbV9zdHJ1Y3QgKm1tOw0KIA0KIAlzdm1zID0gJnAtPnN2bXM7DQotCWlmICghc3ZtcykN
Ci0JCXJldHVybiAtRUlOVkFMOw0KIA0KIAltbSA9IGdldF90YXNrX21tKHAtPmxlYWRfdGhyZWFk
KTsNCiAJaWYgKCFtbSkgew0KLS0gDQoyLjQzLjANCg==

