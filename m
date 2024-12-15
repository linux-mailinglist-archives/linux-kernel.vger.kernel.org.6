Return-Path: <linux-kernel+bounces-446532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 241919F2593
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 20:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3135718859D3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 19:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A441B87FE;
	Sun, 15 Dec 2024 19:07:26 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794611BFE03
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734289645; cv=none; b=XAMVYQO6yN8UxnAGln8p5o6RTwiRLVZPHxpFqa8LuciJNa17vbgWWfsLO065wCGTKK7vVpQaHAad49akkZrUpmX0XblKJqM+cuT8LKby6+RcsyJbQkYL8OLBMwHj1qGuzhnatiL0MF3JaQfWvimBfu5NwnJVKpAMIym0rodgIvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734289645; c=relaxed/simple;
	bh=vgr8lLu1Qqnub64e79oXwUlqd2gR91iR24nmnJhUuJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=jeZQFl1By2Rf/yVXgfHckSQb2EWosVO5bLkYY/TEY3zfP/DxGcd9SrWuyEGB28F80VP2bbDWbdFlluUugLAwDZKgBTQjU1fbULO4XtxAqnQb+qmqIOeFDLW5zcZ2poIMmhFqftDyfvthf1CuMm2EWr+xX2HUWqV0JcWtBfszs/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-150-76v1ZOAhNra134_68TK1Pg-1; Sun, 15 Dec 2024 19:07:14 +0000
X-MC-Unique: 76v1ZOAhNra134_68TK1Pg-1
X-Mimecast-MFC-AGG-ID: 76v1ZOAhNra134_68TK1Pg
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 15 Dec
 2024 19:06:13 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 15 Dec 2024 19:06:13 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
CC: =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, Nilay Shroff
	<nilay@linux.ibm.com>, Yury Norov <yury.norov@gmail.com>, Qing Zhao
	<qing.zhao@oracle.com>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] fortify: Hide run-time copy size from value range
 tracking
Thread-Topic: [PATCH v2] fortify: Hide run-time copy size from value range
 tracking
Thread-Index: AQHbTch8d+wrrUhKvECKbtRQEXOCn7LnrGkw
Date: Sun, 15 Dec 2024 19:06:12 +0000
Message-ID: <383ed0428fd2415aa7ab09255134d61c@AcuMS.aculab.com>
References: <20241214013600.it.020-kees@kernel.org>
In-Reply-To: <20241214013600.it.020-kees@kernel.org>
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
X-Mimecast-MFC-PROC-ID: 4avvLUWE9y37lLh2s4QJjqh44PfxSZ-Ux11DBiar8Yw_1734289633
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogS2VlcyBDb29rDQo+IFNlbnQ6IDE0IERlY2VtYmVyIDIwMjQgMDE6MzYNCi4uLg0KPiBJ
biBvcmRlciB0byBzaWxlbmNlIHRoaXMgZmFsc2UgcG9zaXRpdmUgYnV0IGtlZXAgZGV0ZXJtaW5p
c3RpYw0KPiBjb21waWxlLXRpbWUgd2FybmluZ3MgaW50YWN0LCBoaWRlIHRoZSBsZW5ndGggdmFy
aWFibGUgZnJvbSBHQ0Mgd2l0aA0KPiBPUFRJTUlaRV9ISURFX1ZBUigpIGJlZm9yZSBjYWxsaW5n
IHRoZSBidWlsdGluIG1lbWNweS4NCi4uLg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9m
b3J0aWZ5LXN0cmluZy5oIGIvaW5jbHVkZS9saW51eC9mb3J0aWZ5LXN0cmluZy5oDQo+IGluZGV4
IDBkOTliZjExZDI2MC4uMWVlZjAxMTk2NzFjIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L2ZvcnRpZnktc3RyaW5nLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9mb3J0aWZ5LXN0cmluZy5o
DQo+IEBAIC02MTYsNiArNjE2LDEyIEBAIF9fRk9SVElGWV9JTkxJTkUgYm9vbCBmb3J0aWZ5X21l
bWNweV9jaGsoX19rZXJuZWxfc2l6ZV90IHNpemUsDQo+ICAJcmV0dXJuIGZhbHNlOw0KPiAgfQ0K
PiANCj4gKy8qDQo+ICsgKiBUbyB3b3JrIGFyb3VuZCB3aGF0IHNlZW1zIHRvIGJlIGFuIG9wdGlt
aXplciBidWcsIHRoZSBtYWNybyBhcmd1bWVudHMNCj4gKyAqIG5lZWQgdG8gaGF2ZSBjb25zdCBj
b3BpZXMgb3IgdGhlIHZhbHVlcyBlbmQgdXAgY2hhbmdlZCBieSB0aGUgdGltZSB0aGV5DQo+ICsg
KiByZWFjaCBmb3J0aWZ5X3dhcm5fb25jZSgpLiBTZWUgY29tbWl0IDZmNzYzMGIxYjViYyAoImZv
cnRpZnk6IENhcHR1cmUNCj4gKyAqIF9fYm9zKCkgcmVzdWx0cyBpbiBjb25zdCB0ZW1wIHZhcnMi
KSBmb3IgbW9yZSBkZXRhaWxzLg0KPiArICovDQo+ICAjZGVmaW5lIF9fZm9ydGlmeV9tZW1jcHlf
Y2hrKHAsIHEsIHNpemUsIHBfc2l6ZSwgcV9zaXplLAkJXA0KPiAgCQkJICAgICBwX3NpemVfZmll
bGQsIHFfc2l6ZV9maWVsZCwgb3ApICh7CQlcDQo+ICAJY29uc3Qgc2l6ZV90IF9fZm9ydGlmeV9z
aXplID0gKHNpemVfdCkoc2l6ZSk7CQkJXA0KPiBAQCAtNjIzLDYgKzYyOSw4IEBAIF9fRk9SVElG
WV9JTkxJTkUgYm9vbCBmb3J0aWZ5X21lbWNweV9jaGsoX19rZXJuZWxfc2l6ZV90IHNpemUsDQo+
ICAJY29uc3Qgc2l6ZV90IF9fcV9zaXplID0gKHFfc2l6ZSk7CQkJCVwNCj4gIAljb25zdCBzaXpl
X3QgX19wX3NpemVfZmllbGQgPSAocF9zaXplX2ZpZWxkKTsJCQlcDQo+ICAJY29uc3Qgc2l6ZV90
IF9fcV9zaXplX2ZpZWxkID0gKHFfc2l6ZV9maWVsZCk7CQkJXA0KPiArCS8qIEtlZXAgYSBtdXRh
YmxlIHZlcnNpb24gb2YgdGhlIHNpemUgZm9yIHRoZSBmaW5hbCBjb3B5LiAqLwlcDQo+ICsJc2l6
ZV90IF9fY29weV9zaXplID0gX19mb3J0aWZ5X3NpemU7CQkJCVwNCj4gIAlmb3J0aWZ5X3dhcm5f
b25jZShmb3J0aWZ5X21lbWNweV9jaGsoX19mb3J0aWZ5X3NpemUsIF9fcF9zaXplLAlcDQo+ICAJ
CQkJICAgICBfX3Ffc2l6ZSwgX19wX3NpemVfZmllbGQsCQlcDQo+ICAJCQkJICAgICBfX3Ffc2l6
ZV9maWVsZCwgRk9SVElGWV9GVU5DXyAjI29wKSwgXA0KPiBAQCAtNjMwLDcgKzYzOCwxMSBAQCBf
X0ZPUlRJRllfSU5MSU5FIGJvb2wgZm9ydGlmeV9tZW1jcHlfY2hrKF9fa2VybmVsX3NpemVfdCBz
aXplLA0KPiAgCQkgIF9fZm9ydGlmeV9zaXplLAkJCQkJXA0KPiAgCQkgICJmaWVsZCBcIiIgI3Ag
IlwiIGF0ICIgRklMRV9MSU5FLAkJCVwNCj4gIAkJICBfX3Bfc2l6ZV9maWVsZCk7CQkJCQlcDQo+
IC0JX191bmRlcmx5aW5nXyMjb3AocCwgcSwgX19mb3J0aWZ5X3NpemUpOwkJCVwNCj4gKwkvKiBI
aWRlIG9ubHkgdGhlIHJ1bi10aW1lIHNpemUgZnJvbSB2YWx1ZSByYW5nZSB0cmFja2luZyB0byAq
LwlcDQo+ICsJLyogc2lsZW5jZSBjb21waWxlLXRpbWUgZmFsc2UgcG9zaXRpdmUgYm91bmRzIHdh
cm5pbmdzLiAqLwlcDQo+ICsJaWYgKCFfX2J1aWx0aW5fY29uc3RhbnRfcChfX2ZvcnRpZnlfc2l6
ZSkpCQkJXA0KPiArCQlPUFRJTUlaRVJfSElERV9WQVIoX19jb3B5X3NpemUpOwkJCVwNCg0KSSB0
aGluayB5b3UgY2FuIG1ha2UgdGhhdDoNCglpZiAoIV9fYnVpbHRpbl9jb25zdGFudF9wKF9fY29w
eV9zaXplKSkgXA0KCQlPUFRJTUlTRVJfSElERV9WQVIoX19jb3B5X3NpemUpIFwNCndoaWNoIGlz
IHByb2JhYmx5IG1vcmUgcmVhZGFibGUuDQoNCglEYXZpZA0KDQo+ICsJX191bmRlcmx5aW5nXyMj
b3AocCwgcSwgX19jb3B5X3NpemUpOwkJCQlcDQo+ICB9KQ0KPiANCj4gIC8qDQo+IC0tDQo+IDIu
MzQuMQ0KPiANCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K


