Return-Path: <linux-kernel+bounces-412178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3769D04FB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 19:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A312821B5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 18:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D731DA103;
	Sun, 17 Nov 2024 18:23:27 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB9A1863F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731867807; cv=none; b=V7Q+5BC6R01LsxERSG1XDM1Vb8AgBiaEz6unHxH1cqqZnEtKsNxId39PT7RSs01VUrkkH1iHsIzmZpKOxe1Nv3Oh9I1Fio/VcIXP/m9kGU2MhhXNUxTFvnH0xp6ixy9l3ZYj5NKl5ZKJSkSD+UitumxYAax3lt3lpHFtHZmN8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731867807; c=relaxed/simple;
	bh=Lq7+lc0MukCzfZDwfOBCjA9grHkNTBpIjJfNoUx4RWw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NI3a2ZbNj55iGuL84kKd2t33GocCtmKxjgPLiUzmeYGutVLYR20uj7ZjGNPnq+5v0OdatTgl1gZ2WTa104NncQjlHiM4Mr1GI6BfWMvRV612wVnsE5C1V4xbYfnHIscJp+uDM0TcXioKejB9zBg51ZUpxKb0GhniCtMJRANuTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-209-bEZVg5RhPyCH4pvwK1Ydfw-1; Sun, 17 Nov 2024 18:23:21 +0000
X-MC-Unique: bEZVg5RhPyCH4pvwK1Ydfw-1
X-Mimecast-MFC-AGG-ID: bEZVg5RhPyCH4pvwK1Ydfw
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 17 Nov
 2024 18:23:20 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 17 Nov 2024 18:23:20 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Borislav Petkov' <bp@alien8.de>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Thomas De Schampheleire
	<thomas.de_schampheleire@nokia.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: RE: x86/amd late microcode thread loading slows down boot
Thread-Topic: x86/amd late microcode thread loading slows down boot
Thread-Index: AQHbN6A/rTQwJ7AT5E+tr8TdCEPGZbK7zBrA
Date: Sun, 17 Nov 2024 18:23:20 +0000
Message-ID: <53daf7e9901d428fa25ede7caa99b520@AcuMS.aculab.com>
References: <ZyulbYuvrkshfsd2@antipodes>
 <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>
 <20241107153036.GCZyzdHEwm9-LPQOzY@fat_crate.local>
 <Zy0p5DT0SOWsCDn7@antipodes>
 <20241114095639.GDZzXJV1EDJlMqv24c@fat_crate.local>
 <3f6a84bd-af4a-4ffa-8205-25b2c9084893@citrix.com>
 <20241115205114.GCZze0QtUKbeXdFEHe@fat_crate.local>
In-Reply-To: <20241115205114.GCZze0QtUKbeXdFEHe@fat_crate.local>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W2E0pezgxrR2UqpBIc1HdvI-_Kp5BLG5YbfPmb9nPUs_1731867801
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

Li4uDQo+ICsJCS8qDQo+ICsJCSAqIEZsdXNoIG5leHQgcGFnZSB0b28gaWYgcGF0Y2ggaW1hZ2Ug
aXMgY3Jvc3NpbmcgYSBwYWdlDQo+ICsJCSAqIGJvdW5kYXJ5Lg0KPiArCQkgKi8NCj4gKwkJaWYg
KHBfYWRkciA+PiBQQUdFX1NISUZUICE9IChwX2FkZHIgKyBwc2l6ZSkgPj4gUEFHRV9TSElGVCkN
Cj4gKwkJCWludmxwZyhwX2FkZHIgKyBwc2l6ZSk7DQo+ICsJfQ0KDQpTaG91bGRuJ3QgdGhhdCBi
ZSAncHNpemUgLSAxJyA/DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


