Return-Path: <linux-kernel+bounces-312661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A796997A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9788BB21FAB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D375519F41B;
	Tue,  3 Sep 2024 09:49:11 +0000 (UTC)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115BC1A0BF2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356951; cv=none; b=uoz3ZJjs3ZeMAettkYURX0+ck4lxi9Ftq/vUIZSsY6P3tE7nci5qNYgm+r9P9HMk4lNUTQ+jcMNHduCSqwlpz+2PAyBddFefaMFNknZOjm8MM0hTkaZaGUARmxIZVXCdsZYfLXI2bbEspAgm/yOtqWuZZp1oOe9y9/eNBT8a0aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356951; c=relaxed/simple;
	bh=YCJtvlKwGlnH0v4fIcqZym0S/odYiTTNF/thyVRPRdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CdZ8jFMZpz8Dx/hdnL9DCkQcT5V3bpqDyQPt6DpvmGpEuyL7XrKjNrYTiH+BvkGbOIJ4KIduBscm2LJjO3caHbaTyOTbpjinG7eePWnNXfDRVNIbJw/RYaTVrTQCCVxjSnF0K6vgpJ+3Erdcypd1KMH+4y5QTZvRN7pGOMZXBZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: 6+T9Hnn8RuWjBFzMOk/HVw==
X-CSE-MsgGUID: +E2TGmDJTgiGlym54yZ89A==
X-IronPort-AV: E=Sophos;i="6.10,198,1719849600"; 
   d="scan'208";a="95305435"
From: Huang Jianan <huangjianan@xiaomi.com>
To: Wu Bo <bo.wu@vivo.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Wu Bo <wubo.oduw@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [External Mail][f2fs-dev] [PATCH 05/13] f2fs: set inline tail
 flag when create inode
Thread-Topic: [External Mail][f2fs-dev] [PATCH 05/13] f2fs: set inline tail
 flag when create inode
Thread-Index: AQHa/d9TEJ0BFkkmf0yNrLcOSrFLD7JFSyMA
Date: Tue, 3 Sep 2024 09:49:00 +0000
Message-ID: <83bfb7d2-655e-4f3d-9bda-3f275637a3f0@xiaomi.com>
References: <cover.1725334811.git.bo.wu@vivo.com>
 <d5f1a318931b213f7a27de8441ba985354eecabb.1725334811.git.bo.wu@vivo.com>
In-Reply-To: <d5f1a318931b213f7a27de8441ba985354eecabb.1725334811.git.bo.wu@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <604B70C4BBC297469DA7016D8A220A7C@xiaomi.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNC85LzMgMTY6NTQsIFd1IEJvIHZpYSBMaW51eC1mMmZzLWRldmVsIHdyb3RlOg0KSGkg
Qm8sDQo+IA0KPiBTZXQgaW5saW5lIHRhaWwgZmxhZyB0byBlbmFibGUgdGhpcyBmZWF0dXJlIHdo
ZW4gbmV3IGlub2RlIGlzIGNyZWF0ZWQuDQo+IEluaGVyaXQgdGhlIGNvbmRpdGlvbnMgZnJvbSBp
bmxpbmUgZGF0YS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFd1IEJvIDxiby53dUB2aXZvLmNvbT4N
Cj4gLS0tDQo+ICAgZnMvZjJmcy9uYW1laS5jIHwgMyArKysNCj4gICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9uYW1laS5jIGIvZnMv
ZjJmcy9uYW1laS5jDQo+IGluZGV4IDM4YjQ3NTA0NzVkYi4uMTNjMjk1ZWExOWRlIDEwMDY0NA0K
PiAtLS0gYS9mcy9mMmZzL25hbWVpLmMNCj4gKysrIGIvZnMvZjJmcy9uYW1laS5jDQo+IEBAIC0z
MTUsNiArMzE1LDkgQEAgc3RhdGljIHN0cnVjdCBpbm9kZSAqZjJmc19uZXdfaW5vZGUoc3RydWN0
IG1udF9pZG1hcCAqaWRtYXAsDQo+ICAgICAgICAgIC8qIFNob3VsZCBlbmFibGUgaW5saW5lX2Rh
dGEgYWZ0ZXIgY29tcHJlc3Npb24gc2V0ICovDQo+ICAgICAgICAgIGlmICh0ZXN0X29wdChzYmks
IElOTElORV9EQVRBKSAmJiBmMmZzX21heV9pbmxpbmVfZGF0YShpbm9kZSkpDQo+ICAgICAgICAg
ICAgICAgICAgc2V0X2lub2RlX2ZsYWcoaW5vZGUsIEZJX0lOTElORV9EQVRBKTsNCj4gKyAgICAg
ICAvKiBJbmhlcml0IHRoZSBjb25kaXRpb25zIGZyb20gaW5saW5lIGRhdGEgKi8NCj4gKyAgICAg
ICBpZiAodGVzdF9vcHQoc2JpLCBJTkxJTkVfVEFJTCkgJiYgZjJmc19oYXNfaW5saW5lX2RhdGEo
aW5vZGUpKQ0KPiArICAgICAgICAgICAgICAgc2V0X2lub2RlX2ZsYWcoaW5vZGUsIEZJX0lOTElO
RV9UQUlMKTsNCg0KU2hvdWxkIGYyZnNfcG9zdF9yZWFkX3JlcXVpcmVkKCkgYmUgY2hlY2tlZCBo
ZXJlLCBsaWtlIGlubGluZSBkYXRhPw0KDQpUaGFua3MsDQpKaWFuYW4NCg0KPiANCj4gICAgICAg
ICAgaWYgKG5hbWUgJiYgIXRlc3Rfb3B0KHNiaSwgRElTQUJMRV9FWFRfSURFTlRJRlkpKQ0KPiAg
ICAgICAgICAgICAgICAgIHNldF9maWxlX3RlbXBlcmF0dXJlKHNiaSwgaW5vZGUsIG5hbWUpOw0K
PiAtLQ0KPiAyLjM1LjMNCj4gDQo+IA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCj4gTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QNCj4g
TGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQNCj4gaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbA0KDQo=

