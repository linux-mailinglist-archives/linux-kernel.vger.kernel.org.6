Return-Path: <linux-kernel+bounces-380717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566799AF4E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB79B1F22BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A094B2178F3;
	Thu, 24 Oct 2024 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BOU84l+7"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13902170C2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729807112; cv=none; b=UA20mRct6LGKeiS2KLV7IUOjCaSBv7rNikw9xtZZD8YIQx67Uom1WhJ6E0/P5qcJQOf2k0ayKDKqf/AXur/3aDtRDXd2s/D8VIr9N1HLWAAprbhXSHqzYv0xfuo4PQea3F2xEzbljwCBvGFV8VukR3rpF0nzzrr2Le36Ep2ypEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729807112; c=relaxed/simple;
	bh=NFGY6lyZykvrolcK8p8oVjRvFX5eNk9VCO54ynzk+u4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sj0Mu/Sei6/WjwxZ0yrgh0DBiOEzNw4Nq7lcbMhN5LIdXFnkRSODH6cO4DQiQnl0oZStFCC1w2J/i5fNctHIiJd+yrnZ0yb1/oedYIusjzskRzW2Uph9LUg6uDh1o+YtQ5WswhidB1z0EMYNSFgz8S4jzwBq4FmH5Na+NENBCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--payamm.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BOU84l+7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--payamm.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fea2adb6so2156197276.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729807109; x=1730411909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFGY6lyZykvrolcK8p8oVjRvFX5eNk9VCO54ynzk+u4=;
        b=BOU84l+7Av8juwFfmhzbd1sBcbxi6mz+/RLck5FKooxm8PTCucvXtruJEI3AzyHaeF
         7ke4gaIRUhdXv4fEsllrRYvhAnrHOLCYw4ORWR4TjYx110bzWy59xkQBmIefVGeoqqUG
         Hy50PWBYd4BZniREqdhWq+vykzIADYwWrQxs5vZrkWnwnHa/QH0ifP+swFwYR9dA5BE2
         pvKPmo+/Q6BW+cQuPNFsr2JfGxrogqOVLRgQ9XA6P6/a8PXBuCG8lu5/CoPypTWN+lC1
         9DCqFphl1lz9TnI9ehgga/h9Z99nBWi0aiaGbK4di1NvRb0S8wPvLGfNMgOfn8TiaeeI
         gkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729807109; x=1730411909;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NFGY6lyZykvrolcK8p8oVjRvFX5eNk9VCO54ynzk+u4=;
        b=NW7ZML5yBS+c3Apj+N03psJKtTeF6j19llVOdNxk6l00WJJsh2ECmz67KIFDXTvCsY
         UwLmCqXm1L5YPVJUCJ64WZWIO/R7EVmOwoDf+E7bIWGoOrRiC0eHAec+MSieE2rrfokK
         lQwmBWKcZar4eb8oEICAiPM82iKRts4sD/tlZwtQO9ZbyPntHt1/bCukpGp3gLn1ELyV
         5cd8mGim7qERn2ZHeOKDbqVovEZEiusxNtdOXnjHqNtrQhXuCv026kGQwqgEMeN62idC
         I7VjGcQcWJmm5FeBDyaRj+FEyxi66p+mhPRdHa88c0oVM3UsJySe8itHAKwSTVsMHKV7
         97jg==
X-Forwarded-Encrypted: i=1; AJvYcCUsskTDlDao+5zpqAQ9IMTe6JVboA0KJEwkei+k0WX+5pyDt6LU9bUQ3vzZM3joMwchQKHbjdw2y1qG4ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGfMndFiGvsTniV4yCjef5zFZRRt4mN+bt/8TodXq1rZs3aK0A
	jhZOEGCVWJU03QDL2qdhecUGOmvtBSCBF5qcvcEVqEeXRejquMEMRe6zCsU6H6msVLw1y3Ho7nc
	vsg==
X-Google-Smtp-Source: AGHT+IGLvylOkv4mC+Lm3+5GUnQPbAe55XQc5LAaetxY883rPUkBfEpiz/dp2Gbr227RoXCkhjEQpqMXtA0=
X-Received: from payamm.svl.corp.google.com ([2620:15c:2c3:11:1bad:71b2:8c3c:d88e])
 (user=payamm job=sendgmr) by 2002:a5b:88a:0:b0:e24:9f58:dd17 with SMTP id
 3f1490d57ef6-e2f22f2314dmr3874276.1.1729807108993; Thu, 24 Oct 2024 14:58:28
 -0700 (PDT)
Date: Thu, 24 Oct 2024 14:58:27 -0700
In-Reply-To: <CAJZ5v0hbg_5VLCT3cXgK4WkCTwNAUGrUuRe66DoCHf6xydsTzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017035940.4067922-1-payamm@google.com> <CAJZ5v0hbg_5VLCT3cXgK4WkCTwNAUGrUuRe66DoCHf6xydsTzQ@mail.gmail.com>
Message-ID: <lbffqd6wuigivpd4ryrxwirhkc5ghj6k4nenm75dtgeea42535@7v2fzt5i7app>
Subject: Re: [PATCH] acpi: zero-initialize acpi_object union structure
From: Payam Moradshahi <payamm@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGkgUmFmYWVsLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVzcG9uc2UuIFBsZWFzZSBzZWUgYmVs
b3cgZm9yIG15IHJlc3BvbnNlLg0KDQpQYXlhbQ0KDQpPbiBNb24sIE9jdCAyMSwgMjAyNCBhdCAw
MTozMTozOVBNIEdNVCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+IE9uIFRodSwgT2N0IDE3
LCAyMDI0IGF0IDU6NTnigK9BTSBQYXlhbSBNb3JhZHNoYWhpIDxwYXlhbW1AZ29vZ2xlLmNvbT4g
IA0KPiB3cm90ZToNCj4gPg0KPiA+IFRoZSB3YXkgaW4gd2hpY2ggYWNwaV9vYmplY3QgdW5pb24g
aXMgYmVpbmcgaW5pdGlhbGl6ZWQgdmFyaWVzIGJhc2VkIG9uDQo+ID4gY29tcGlsZXIgdHlwZSwg
dmVyc2lvbiBhbmQgZmxhZ3MgdXNlZC4gU29tZSB3aWxsIHplcm8taW5pdGlhbGl6ZSB0aGUNCj4g
PiBlbnRpcmUgdW5pb24gc3RydWN0dXJlIGFuZCBzb21lIHdpbGwgb25seSBpbml0aWFsaXplIHRo
ZSBmaXJzdCBOLWJ5dGVzDQo+ID4gb2YgdGhlIHVuaW9uIHN0cnVjdHVyZS4NCg0KPiBBbnkgZGV0
YWlscz8NCkkgZHVtcGVkIGFjcGlfb2JqZWN0IGFmdGVyIGluaXRpYWxpemF0aW9uIGFuZCBub3Rp
Y2VkIGVpdGhlciB0aGUNCmVudGlyZSBzdHJ1Y3R1cmUgd2FzIHplcm8taW5pdGlhbGl6ZWQgb3Ig
anVzdCB0aGUgZmlyc3QgOCBieXRlcw0KZGVwZW5kaW5nIG9uIGNvbXBpbGVyIHR5cGUgYW5kIHZl
cnNpb24uDQoNCmdjYyAxMy4yLjA6IGJhZA0KQ0xBTkdfQ0w9MzYyMTIxMjY5OiBnb29kDQpDTEFO
R19DTD02MDk0NDMxMjY6IGJhZA0KQ0xBTkdfQ0w9Njg0NzczOTYwOiBnb29kDQoNCg0KPiA+IFRo
aXMgY291bGQgbGVhZCB0byB1bmluaXRpYWxpemVkIHVuaW9uIG1lbWJlcnMuDQoNCj4gU28gdGhp
cyBpcyB3b3JraW5nIGFyb3VuZCBhIGNvbXBpbGVyIGJ1ZyBBRkFJQ1MuDQoNCj4gSWYgdGhlIGNv
bXBpbGVyIGhhcyB0aGlzIGJ1ZywgaXMgaXQgZ3VhcmFudGVlZCB0byBjb21waWxlIHRoZSByZXN0
IG9mDQo+IHRoZSBrZXJuZWwgY29ycmVjdGx5Pw0KVGhpcyBpcyBub3QgYSBjb21waWxlciBidWcu
IFRoZSB3YXkgYWNwaV9vYmplY3QgdW5pb24gaXMgYmVpbmcNCmluaXRpYWxpemVkIGlzIG5vdCBj
LXNwZWMgY29tcGxpYW50Lg0KDQpCYXNlZCBvbiBDIFN0YW5kYXJkIElTTy9JRUMgOTg5OToyMDJ4
IChFKToNCg0KU2VjdGlvbiA2LjIuNi4xICg3KSBzYXlzOg0KDQpXaGVuIGEgdmFsdWUgaXMgc3Rv
cmVkIGluIGEgbWVtYmVyIG9mIGFuIG9iamVjdCBvZiB1bmlvbiB0eXBlLCB0aGUgYnl0ZXMgb2Yg
IA0KdGhlDQpvYmplY3QgcmVwcmVzZW50YXRpb24gdGhhdCBkbyBub3QgY29ycmVzcG9uZCB0byB0
aGF0IG1lbWJlciBidXQgZG8gIA0KY29ycmVzcG9uZA0KdG8gb3RoZXIgbWVtYmVycyB0YWtlIHVu
c3BlY2lmaWVkIHZhbHVlcw0KDQpTZWN0aW9uIDYuNy45IHNheXM6DQoNCklmIGFuIG9iamVjdCB0
aGF0IGhhcyBhdXRvbWF0aWMgc3RvcmFnZSBkdXJhdGlvbiBpcyBub3QgaW5pdGlhbGl6ZWQgIA0K
ZXhwbGljaXRseSwNCml0cyB2YWx1ZSBpcyBpbmRldGVybWluYXRlLg0KDQpJZiBhbiBvYmplY3Qg
dGhhdCBoYXMgc3RhdGljIG9yIHRocmVhZCBzdG9yYWdlIGR1cmF0aW9uIGlzIG5vdCBpbml0aWFs
aXplZA0KZXhwbGljaXRseSwgdGhlbjoNCiAgLSBpZiBpdCBpcyBhIHVuaW9uLCB0aGUgZmlyc3Qg
bmFtZWQgbWVtYmVyIGlzIGluaXRpYWxpemVkIChyZWN1cnNpdmVseSkNCiAgICBhY2NvcmRpbmcg
dG8gdGhlc2UgcnVsZXMsIGFuZCBhbnkgcGFkZGluZyBpcyBpbml0aWFsaXplZCB0byB6ZXJvIGJp
dHM7DQoNClRoZSBhYm92ZSBndWFyYW50ZWVzIHplcm8gb25seSBpbiB0aGUgY2FzZSBvZiBzdGF0
aWMgb3IgdGhyZWFkIHN0b3JhZ2UsDQp3aGljaCBpcyBub3QgdGhlIGNhc2UgaGVyZS4NCg0KDQo+
ID4gVGhpcyBidWcgd2FzIGNvbmZpcm1lZCBieSBvYnNlcnZpbmcgbm9uLXplcm8gdmFsdWUgZm9y
IG9iamVjdC0+cHJvY2Vzc29yDQo+ID4gc3RydWN0dXJlIHZhcmlhYmxlcy4NCg0KPiBXaGVyZSBo
YXMgaXQgYmVlbiBvYnNlcnZlZD8gIFdoYXQgY29tcGlsZXIgdmVyc2lvbihzKT8gZXRjLg0KU2Vl
IGFib3ZlIGZvciBzb21lIGV4YW1wbGVzDQoNCj4gPiBub24temVybyBpbml0aWFsaXplZCBtZW1i
ZXJzIG9mIGFjcGlfb2JqZWN0IHVuaW9uIHN0cnVjdHVyZSBjYXVzZXMNCj4gPiBpbmNvcnJlY3Qg
ZXJyb3IgcmVwb3J0aW5nIGJ5IHRoZSBkcml2ZXIuDQo+ID4NCj4gPiBJZiBhIEJJT1MgaXMgdXNp
bmcgIkRldmljZSIgc3RhdGVtZW50IGFzIG9wcG9zZWQgdG8gIlByb2Nlc3NvciINCj4gPiBzdGF0
ZW1lbnQsIG9iamVjdCB2YXJpYWJsZSBtYXkgY29udGFpbiB1bmluaXRpYWxpemVkIG1lbWJlcnMg
Y2F1c2luZyB0aGUNCj4gPiBkcml2ZXIgdG8gcmVwb3J0ICJJbnZhbGlkIFBCTEsgbGVuZ3RoIiBp
bmNvcnJlY3RseS4NCj4gPg0KPiA+IFVzaW5nIG1lbXNldCB0byB6ZXJvLWluaXRpYWxpemUgdGhl
IHVuaW9uIHN0cnVjdHVyZSBmaXhlcyB0aGlzIGlzc3VlIGFuZA0KPiA+IGFsc28gcmVtb3ZlcyB0
aGUgZGVwZW5kZW5jeSBvZiB0aGlzIGZ1bmN0aW9uIG9uIGNvbXBpbGVyIHZlcnNpb25zIGFuZA0K
PiA+IGZsYWdzIGJlaW5nIHVzZWQuDQo+ID4NCj4gPiBUZXN0ZWQ6IFRlc3RlZCBvbiBBUk02NCBo
YXJkd2FyZSB0aGF0IHdhcyBwcmludGluZyB0aGlzIGVycm9yIGFuZA0KPiA+IGNvbmZpcm1lZCB0
aGUgcHJpbnRzIHdlcmUgZ29uZS4NCj4gPg0KPiA+IEFsc28gY29uZmlybWVkIHRoaXMgZG9lcyBu
b3QgY2F1c2UgcmVncmVzc2lvbiBvbiBBUk02NCBhbmQgWDg2DQo+ID4gbWFjaGluZXMuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQYXlhbSBNb3JhZHNoYWhpIDxwYXlhbW1AZ29vZ2xlLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9hY3BpL2FjcGlfcHJvY2Vzc29yLmMgfCA0ICsrKy0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hY3BpX3Byb2Nlc3Nvci5jICANCj4gYi9kcml2
ZXJzL2FjcGkvYWNwaV9wcm9jZXNzb3IuYw0KPiA+IGluZGV4IDdjZjYxMDFjYjRjNzMuLjY2OTZh
ZDQ5MzdkMjEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL2FjcGlfcHJvY2Vzc29yLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaV9wcm9jZXNzb3IuYw0KPiA+IEBAIC0yNzUsNyAr
Mjc1LDcgQEAgc3RhdGljIGlubGluZSBpbnQgYWNwaV9wcm9jZXNzb3JfaG90YWRkX2luaXQoc3Ry
dWN0ICANCj4gYWNwaV9wcm9jZXNzb3IgKnByLA0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgYWNwaV9w
cm9jZXNzb3JfZ2V0X2luZm8oc3RydWN0IGFjcGlfZGV2aWNlICpkZXZpY2UpDQo+ID4gIHsNCj4g
PiAtICAgICAgIHVuaW9uIGFjcGlfb2JqZWN0IG9iamVjdCA9IHsgMCB9Ow0KPiA+ICsgICAgICAg
dW5pb24gYWNwaV9vYmplY3Qgb2JqZWN0Ow0KPiA+ICAgICAgICAgc3RydWN0IGFjcGlfYnVmZmVy
IGJ1ZmZlciA9IHsgc2l6ZW9mKHVuaW9uIGFjcGlfb2JqZWN0KSwgIA0KPiAmb2JqZWN0IH07DQo+
ID4gICAgICAgICBzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByID0gYWNwaV9kcml2ZXJfZGF0YShk
ZXZpY2UpOw0KPiA+ICAgICAgICAgaW50IGRldmljZV9kZWNsYXJhdGlvbiA9IDA7DQo+ID4gQEAg
LTI4NCw2ICsyODQsOCBAQCBzdGF0aWMgaW50IGFjcGlfcHJvY2Vzc29yX2dldF9pbmZvKHN0cnVj
dCAgDQo+IGFjcGlfZGV2aWNlICpkZXZpY2UpDQo+ID4gICAgICAgICB1bnNpZ25lZCBsb25nIGxv
bmcgdmFsdWU7DQo+ID4gICAgICAgICBpbnQgcmV0Ow0KPiA+DQo+ID4gKyAgICAgICBtZW1zZXQo
Jm9iamVjdCwgMCwgc2l6ZW9mKHVuaW9uIGFjcGlfb2JqZWN0KSk7DQo+ID4gKw0KPiA+ICAgICAg
ICAgYWNwaV9wcm9jZXNzb3JfZXJyYXRhKCk7DQo+ID4NCj4gPiAgICAgICAgIC8qDQo+ID4gLS0N
Cg==

