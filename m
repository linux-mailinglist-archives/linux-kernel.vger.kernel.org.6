Return-Path: <linux-kernel+bounces-312662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE8A96997E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411861C2389B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38C019F41B;
	Tue,  3 Sep 2024 09:50:45 +0000 (UTC)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532CA1A0BF9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357045; cv=none; b=XyunYI3aGd4ksxpPOLdoeTUpZrzjFkXzOwgS989hT3rKlksWVCGz9S39I+sFE+4aGCvXy2WVCev3CGKZ88rkse5e1PBqzHUCxPwskwXDgbOgpwgcXfjSMkzbsHKRPxzZtXe69eHEjOQqfyffKkRnuxxyR0YKhFhollPAXOtXlRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357045; c=relaxed/simple;
	bh=XOVQ707CMA64SAkQoKVPUzsZM3uB3E3NDa9YdXVxXYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MrmrISeFGIHObUmo0M7T8m2sN+sf/ku4bgXPM27rXzOlot3n8a6wcBWmnLeLOoEFxyHa5arHSPGTEsCmy0eIlk4u74ER76Nf4LWc6u19Zj1KY7o2nNueS+xwWWQASiXpwGsO0E0xyLW2UYW/JcDS1yluYUDePC7JHAVkcFq4aP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: Y3LtmdYtR0C+oVJmOa/52Q==
X-CSE-MsgGUID: aKoAoiowQiGb/3Lvw25XOQ==
X-IronPort-AV: E=Sophos;i="6.10,198,1719849600"; 
   d="scan'208";a="121008352"
From: Huang Jianan <huangjianan@xiaomi.com>
To: Wu Bo <wubo.oduw@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Jaegeuk Kim <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [External Mail][f2fs-dev] [PATCH 05/13] f2fs: set inline tail
 flag when create inode
Thread-Topic: [External Mail][f2fs-dev] [PATCH 05/13] f2fs: set inline tail
 flag when create inode
Thread-Index: AQHa/d9TEJ0BFkkmf0yNrLcOSrFLD7JFS5uA
Date: Tue, 3 Sep 2024 09:50:41 +0000
Message-ID: <9f381694-2573-4f72-9177-54e2b5c07652@xiaomi.com>
References: <cover.1725334811.git.bo.wu@vivo.com>
 <d5f1a318931b213f7a27de8441ba985354eecabb.1725334811.git.bo.wu@vivo.com>
In-Reply-To: <d5f1a318931b213f7a27de8441ba985354eecabb.1725334811.git.bo.wu@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <624B598B5950C141A39959F41105D51B@xiaomi.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNC85LzMgMTY6NTQsIFd1IEJvIHZpYSBMaW51eC1mMmZzLWRldmVsIHdyb3RlOg0KPiBb
5aSW6YOo6YKu5Lu2XSDmraTpgq7ku7bmnaXmupDkuo7lsI/nsbPlhazlj7jlpJbpg6jvvIzor7fo
sKjmhY7lpITnkIbjgILoi6Xlr7npgq7ku7blronlhajmgKflrZjnlpHvvIzor7flsIbpgq7ku7bo
vazlj5Hnu5ltaXNlY0B4aWFvbWkuY29t6L+b6KGM5Y+N6aaIDQo+IA0KPiBTZXQgaW5saW5lIHRh
aWwgZmxhZyB0byBlbmFibGUgdGhpcyBmZWF0dXJlIHdoZW4gbmV3IGlub2RlIGlzIGNyZWF0ZWQu
DQo+IEluaGVyaXQgdGhlIGNvbmRpdGlvbnMgZnJvbSBpbmxpbmUgZGF0YS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFd1IEJvIDxiby53dUB2aXZvLmNvbT4NCj4gLS0tDQo+ICAgZnMvZjJmcy9uYW1l
aS5jIHwgMyArKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZnMvZjJmcy9uYW1laS5jIGIvZnMvZjJmcy9uYW1laS5jDQo+IGluZGV4IDM4
YjQ3NTA0NzVkYi4uMTNjMjk1ZWExOWRlIDEwMDY0NA0KPiAtLS0gYS9mcy9mMmZzL25hbWVpLmMN
Cj4gKysrIGIvZnMvZjJmcy9uYW1laS5jDQo+IEBAIC0zMTUsNiArMzE1LDkgQEAgc3RhdGljIHN0
cnVjdCBpbm9kZSAqZjJmc19uZXdfaW5vZGUoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsDQo+ICAg
ICAgICAgIC8qIFNob3VsZCBlbmFibGUgaW5saW5lX2RhdGEgYWZ0ZXIgY29tcHJlc3Npb24gc2V0
ICovDQo+ICAgICAgICAgIGlmICh0ZXN0X29wdChzYmksIElOTElORV9EQVRBKSAmJiBmMmZzX21h
eV9pbmxpbmVfZGF0YShpbm9kZSkpDQo+ICAgICAgICAgICAgICAgICAgc2V0X2lub2RlX2ZsYWco
aW5vZGUsIEZJX0lOTElORV9EQVRBKTsNCj4gKyAgICAgICAvKiBJbmhlcml0IHRoZSBjb25kaXRp
b25zIGZyb20gaW5saW5lIGRhdGEgKi8NCj4gKyAgICAgICBpZiAodGVzdF9vcHQoc2JpLCBJTkxJ
TkVfVEFJTCkgJiYgZjJmc19oYXNfaW5saW5lX2RhdGEoaW5vZGUpKQ0KPiArICAgICAgICAgICAg
ICAgc2V0X2lub2RlX2ZsYWcoaW5vZGUsIEZJX0lOTElORV9UQUlMKTsNCg0KU2hvdWxkIGYyZnNf
cG9zdF9yZWFkX3JlcXVpcmVkKCkgYmUgY2hlY2tlZCBoZXJlLCBsaWtlIGlubGluZSBkYXRhPw0K
DQpUaGFua3MsDQpKaWFuYW4NCg0KPiANCj4gICAgICAgICAgaWYgKG5hbWUgJiYgIXRlc3Rfb3B0
KHNiaSwgRElTQUJMRV9FWFRfSURFTlRJRlkpKQ0KPiAgICAgICAgICAgICAgICAgIHNldF9maWxl
X3RlbXBlcmF0dXJlKHNiaSwgaW5vZGUsIG5hbWUpOw0KPiAtLQ0KPiAyLjM1LjMNCj4gDQo+IA0K
PiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4g
TGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QNCj4gTGludXgtZjJmcy1kZXZlbEBsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQNCj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlz
dGluZm8vbGludXgtZjJmcy1kZXZlbA0KDQo=

