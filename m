Return-Path: <linux-kernel+bounces-440562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9FB9EC104
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4540F282DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9F33B791;
	Wed, 11 Dec 2024 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6U360kn"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA4182B4;
	Wed, 11 Dec 2024 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733877674; cv=none; b=bpKoLcJESXOKstzRCepdXia+vFdcVzG9RDwgQoPoYdJRMlhpt7bee7T34tjIEFovZcPq2fyMmPXjtSQrT0+sryTV29Qw5Z4YcDLGM8cqMBCkQAAn5PyS6BP1KtAhZn/HSUsphh+7vV+FZ+VV3gK09F5pdN0gTSr7t9nc5WoitZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733877674; c=relaxed/simple;
	bh=5UPtfw8VuK8f7upUsP0qiiGtjlJDQAQYuFm8VMuMXK4=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=atQO9NMyiVeIElYY0Xg5r5Exz8ujt99KVFOFax/rYh7Ta+Rjf16R1JWEeXl78repS8OaGcF648qPIpiTMbDB3MaCGmbzwrcqQy5FxhxoDZPdXSWmMQfsPa2q5d2VA9noulFHTsvryHABPxmR6BV7NjY1H/lBlG2xk/t3rFYjDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6U360kn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215770613dbso41393155ad.2;
        Tue, 10 Dec 2024 16:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733877672; x=1734482472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UPtfw8VuK8f7upUsP0qiiGtjlJDQAQYuFm8VMuMXK4=;
        b=O6U360knWQoFsMQcL43k6GEAs5MtLom7pJGUdPRfWDJ4BmKi/MSbjyyDvx4Gsvij4z
         YvX9s0d3bZ5Aw0uJJuEudtdQ1r+qoRzcLvayBIvtn0MspiAw1mMTtpJjwEtwi4hnj1mh
         u+RSVa2lbK9Kwxm8XeaHtRuKXQ8EsFAGcbm51LfVtLaPsUyMK+//75x+Xvmvvwr90y8H
         gFpkSjbTHO2rupHZxr8fDzwwrmclkwlULqOxhDDlEssh2UiBJMcQ8gDC5mekRxP7Ovzv
         Qu/dcMitiQUqqWBkxs25HVxUd5J6lgkRieESgCSAgmwo7XWD1KxN1e/4AjH65k0m+kEW
         KWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733877672; x=1734482472;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5UPtfw8VuK8f7upUsP0qiiGtjlJDQAQYuFm8VMuMXK4=;
        b=QyzjyLiOwsq4ce9AmCo417376EPMwtJcPFgA3bnSETpt8UmuF9AGVPI1MSc0huSV+3
         hMiSVkk84RJy0DZjbNmaijga+8XKVn67ocAfYHVQCqDaG13wB5Xd7E6D6kec8HQo7u0o
         q/FNcAMoZlTHiCi2Yksiqz0p6401iPdNbpmp+LnCjtG9q+ZWIQetVpIRUH3JxutIIuLb
         hq/VVTdj0+Kgtz+8wNvQNX4mHRbLfJF2XfLRf60Jr70WREUrFYu2NF5cQx9IK3hNCczc
         glrcxuq8yAtSN1wK1ExgMSBvqJl4IF6jnXlavCs1aTcXAx50CnxPPwQOLMi9JkTrw7OO
         Nk3w==
X-Forwarded-Encrypted: i=1; AJvYcCWSvlmmB7x1l4Pt0NksuenO64PPchxb2pLVOuEO7ght+xNTcm6VHtENyCHX9bmB6c1XxTnd3I4RVbaSVtY=@vger.kernel.org, AJvYcCWm2ywmW1mC/B+n6SE+POI419FwFMTFtyZJY1Vtd57yAlvwgWjPBFoi+whJEYAFRmk+oAB7NhdDSAPCCDxsAR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5t6ezaHRSX29F4+DJUyUKd4MjAJcGqdPSUuBzO2JGoJXM73rI
	7x3N5/UNilOpg063QZdjuGF+B1CYrUA+DbYy38Paush9AXxEKik/
X-Gm-Gg: ASbGncsygNlAIKs6Zy7ls7G1D/hAXZ1NOjWwxngJJ5Mj+grTF6p78thcuPLHKVPFb9j
	NraO+DPrxTrWA2zf2AVBJfzq2wtlXnYZABlg5M7ilx39n3gp/q9a6IrKDalkvhz+0GhFYtN8ya7
	xcJbihDDs/P1XFDLtUTEC36i05Vamr2I+zbIU1P457CoVsSXbHAjOHzkVOhgXTIF1QRvpsnzMik
	XddMlwNAwmNjWac7y5JFUP9y9y8fbbhdjR9X2G1RV+KvL1fWwdIkm3G3NrCgWY5vPZED/Ly0Y/c
	zInlhX47qda6IfebgzWy8b0cLoEoWY3p4w==
X-Google-Smtp-Source: AGHT+IHqHfCvZvGKLuMXz8AiDsWXknJ34bQnBz2kNatpxzICbZyL3M7rCR45PKN88PXAaH1LNr0svg==
X-Received: by 2002:a17:902:8b83:b0:216:7cbf:9500 with SMTP id d9443c01a7336-21778397522mr17055945ad.6.1733877672078;
        Tue, 10 Dec 2024 16:41:12 -0800 (PST)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216353ab708sm56076995ad.182.2024.12.10.16.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 16:41:11 -0800 (PST)
Date: Wed, 11 Dec 2024 09:40:54 +0900 (JST)
Message-Id: <20241211.094054.1429837669366274024.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, peterz@infradead.org,
 hpa@zytor.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, tangyouling@loongson.cn,
 hejinyang@loongson.cn, yangtiezhu@loongson.cn, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
 tmgross@umich.edu
Subject: Re: [PATCH v1 5/5] rust: Add warn_on and warn_on_once
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgiShKMGo6AYWM-4S8JK+iDA+tUfz9uxkns82g0nLW--NQ@mail.gmail.com>
References: <20241210001802.228725-1-fujita.tomonori@gmail.com>
	<20241210001802.228725-6-fujita.tomonori@gmail.com>
	<CAH5fLgiShKMGo6AYWM-4S8JK+iDA+tUfz9uxkns82g0nLW--NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gVHVlLCAxMCBEZWMgMjAyNCAxMDowNTowNyArMDEwMA0KQWxpY2UgUnlobCA8YWxpY2VyeWhs
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+IE9uIFR1ZSwgRGVjIDEwLCAyMDI0IGF0IDE6MTnigK9B
TSBGVUpJVEEgVG9tb25vcmkNCj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+IHdyb3RlOg0K
Pj4NCj4+IEFkZCB3YXJuX29uIGFuZCB3YXJuX29uX29uY2UgbWFjcm9zLiBXcmFwcGluZyB0aGUg
QydzIFdBUk5fKiBhbmQgQlVHXyoNCj4+IG1hY3JvcyBkb2Vzbid0IHdvcmsgc28gdGhpcyB1c2Vz
IHRoZSBhc3NlbWJseSBjb2RlIGV4cG9ydGVkIGJ5IHRoZSBDDQo+PiBzaWRlIHZpYSBBUkNIX1dB
Uk5fQVNNIG1hY3JvLiBMaWtlIHRoZSBzdGF0aWMgYnJhbmNoIGNvZGUsIHRoaXMNCj4+IGdlbmVy
YXRlcyB0aGUgYXNzZW1ibHkgY29kZSBmb3IgcnVzdCBkeW5hbWljYWxseSBieSB1c2luZyB0aGUg
Qw0KPj4gcHJlcHJvY2Vzc29yLg0KPj4NCj4+IGZpbGUoKSEgbWFjcm8gZG9lc24ndCB3b3JrIGZv
ciB0aGUgUnVzdCBpbmxpbmUgYXNzZW1ibHkgaW4gdGhlIHNhbWUNCj4+IHdheSBhcyBfX0ZJTEVf
XyBmb3IgdGhlIEMgaW5saW5lIGFzc2VtYmx5LiBTbyB0aGUgY29kZSB0byBoYW5kbGUgYQ0KPj4g
ZmlsZSBuYW1lIGlzIGRpZmZlcmVudCBmcm9tIHRoZSBDIGFzc2VtYmx5IGNvZGUgKHNpbWlsYXIg
dG8gdGhlDQo+PiBhcm02NC9sb29uZ2FyY2ggYXNzZW1ibHkpLg0KPj4NCj4+IEFTTV9SRUFDSEFC
TEUgZGVmaW5pdGlvbiB3b3JrcyBpbiB0aGUgc2FtZSB3YXkgdG8gZ2V0IG9ianRvb2wncw0KPj4g
cmVhY2hhYmxlIGFzbSBjb2RlLiBUaGUgYXJjaGl0ZWN0dXJlcyB3aGljaCB1c2Ugb2JqdG9vbCAo
eDg2IGFuZA0KPj4gbG9vbmdhcmNoKSBuZWVkcyBpdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBG
VUpJVEEgVG9tb25vcmkgPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+DQo+IA0KPj4gKyNbbWFj
cm9fZXhwb3J0XQ0KPj4gKyNbZG9jKGhpZGRlbildDQo+PiArI1tjZmcoYWxsKENPTkZJR19CVUcs
IG5vdChDT05GSUdfVU1MKSkpXQ0KPj4gKyNbY2ZnKGFueSh0YXJnZXRfYXJjaCA9ICJ4ODZfNjQi
LCB0YXJnZXRfYXJjaCA9ICJyaXNjdjY0IikpXQ0KPiANCj4+ICsjW21hY3JvX2V4cG9ydF0NCj4+
ICsjW2RvYyhoaWRkZW4pXQ0KPj4gKyNbY2ZnKGFsbChDT05GSUdfQlVHLCBub3QoQ09ORklHX1VN
TCkpKV0NCj4+ICsjW2NmZyhhbnkodGFyZ2V0X2FyY2ggPSAiYWFyY2g2NCIsIHRhcmdldF9hcmNo
ID0gImxvb25nYXJjaDY0IikpXQ0KPiANCj4gV2hhdCdzIHRoZSByZWFzb24gZm9yIHRoaXMgYXJj
aC1zcGVjaWZpYyBjb2RlPyBUaGUgZmlsZSEoKS9saW5lISgpDQo+IGludm9jYXRpb25zPyBDb3Vs
ZCB0aGV5IGJlIHBhc3NlZCBhcyBhbiBhcmd1bWVudCB0byB0aGUgYXNtIGluc3RlYWQgc28NCj4g
dGhhdCB3ZSBkb24ndCBuZWVkIHRhcmdldF9hcmNoIGNmZ3M/IEkgdW5kZXJzdGFuZCB0aGF0IHRo
ZXkgZG9uJ3Qgd29yaw0KPiBleGFjdGx5IHRoZSBzYW1lIHdheSwgYnV0IG1heWJlIGl0IGNvdWxk
IHN0aWxsIHdvcms/DQoNCkJlY2F1c2Ugb2YgImVycm9yOiBuYW1lZCBhcmd1bWVudCBuZXZlciB1
c2VkIiBpbiBSdXN0IGlubGluZSBhc3NlbWJseToNCg0KQWxsIHRoZSBhcmNocyBkZWZpbmUgQVJD
SF9XQVJOX0FTTSBtYWNybyBpbiB0aGUgc2FtZSB3YXk6DQoNCiNkZWZpbmUgQVJDSF9XQVJOX0FT
TShmaWxlLCBsaW5lLCBmbGFncywgc2l6ZSkNCg0KSG93ZXZlciwgb25seSB4ODYgYW5kIHJpc2Mt
diBhc20gY29kZSB1c2UgdGhlIHNpemUgYXJndW1lbnQuIFdpdGhvdXQNCnRoZSBjZmdzLCBJJ2xs
IGdldCB0aGUgZm9sbG93aW5nIG9uIGFybTY0L2xvb25nYXJjaDoNCg0KZXJyb3I6IG5hbWVkIGFy
Z3VtZW50IG5ldmVyIHVzZWQNCiAgLS0+IC9ob21lL2Z1aml0YS9naXQvbGludXgtcnVzdC9kcml2
ZXJzL2Jsb2NrL3JudWxsLnJzOjU0OjkNCiAgIHwNCjU0IHwgICAgICAgICB3YXJuX29uISh0cnVl
KTsNCiAgIHwgICAgICAgICBeXl5eXl5eXl5eXl5eXiBuYW1lZCBhcmd1bWVudCBuZXZlciB1c2Vk
DQogICB8DQogICA9IGhlbHA6IGlmIHRoaXMgYXJndW1lbnQgaXMgaW50ZW50aW9uYWxseSB1bnVz
ZWQsIGNvbnNpZGVyIHVzaW5nIGl0IGluIGFuIGFzbSBjb21tZW50OiBgIi8qIHtzaXplfSAqLyJg
DQogICA9IG5vdGU6IHRoaXMgZXJyb3Igb3JpZ2luYXRlcyBpbiB0aGUgbWFjcm8gYCRjcmF0ZTo6
d2Fybl9mbGFnc2Agd2hpY2ggY29tZXMgZnJvbSB0aGUgZXhwYW5zaW9uIG9mIHRoZSBtYWNybyBg
d2Fybl9vbmAgKGluIE5pZ2h0bHkgYnVpbGRzLCBydW4gd2l0aCAtWiBtYWNyby1iYWNrdHJhY2Ug
Zm9yIG1vcmUgaW5mbykNCg0KDQpBbnkgd2F5IHRvIG1ha2UgdGhlIGNvbXBpbGVyIHRvIGlnbm9y
ZSB0aGlzPw0KDQoNCj4+ICsjW21hY3JvX2V4cG9ydF0NCj4+ICsjW2RvYyhoaWRkZW4pXQ0KPj4g
KyNbY2ZnKGFsbChDT05GSUdfQlVHLCBDT05GSUdfVU1MKSldDQo+PiArbWFjcm9fcnVsZXMhIHdh
cm5fZmxhZ3Mgew0KPj4gKyAgICAoJGZsYWdzOmV4cHIpID0+IHsNCj4+ICsgICAgICAgIC8vIFNB
RkVUWTogSnVzdCBhbiBGRkkgY2FsbC4NCj4+ICsgICAgICAgIHVuc2FmZSB7DQo+PiArICAgICAg
ICAgICAgJGNyYXRlOjpiaW5kaW5nczo6d2Fybl9zbG93cGF0aF9mbXQoDQo+PiArICAgICAgICAg
ICAgICAgICRjcmF0ZTo6Y19zdHIhKDo6Y29yZTo6ZmlsZSEoKSkuYXNfcHRyKCkgYXMgKmNvbnN0
IDo6Y29yZTo6ZmZpOjpjX2NoYXIsDQo+PiArICAgICAgICAgICAgICAgIGxpbmUhKCkgYXMgaTMy
LA0KPj4gKyAgICAgICAgICAgICAgICAkZmxhZ3MgYXMgdTMyLA0KPj4gKyAgICAgICAgICAgICAg
ICA6OmNvcmU6OnB0cjo6bnVsbCgpIGFzICpjb25zdCA6OmNvcmU6OmZmaTo6Y19jaGFyLA0KPiAN
Cj4gSSB3b25kZXIgaWYgdGhpcyBjb3VsZCBiZSB3cml0dGVuIHRvIHV0aWxpemUgTG9jYXRpb246
OmNhbGxlcigpDQo+IGluc3RlYWQgc28gdGhhdCBgI1t0cmFja19jYWxsZXJdYCB3b3Jrcz8NCg0K
WW91IG1lYW50IHRoYXQgd2UgY291bGQgbWFrZSB3YXJuX2ZsYWdzKCkgZnVuY3Rpb24gaW5zdGVh
ZCBvZiBtYWNybw0Kd2l0aCBMb2NhdGlvbjo6Y2FsbGVyKCk/DQoNCklmIHNvLCB3ZSBuZWVkIHRv
IGFkZCBjZmdzIHRvIHdhcm5fb24gYW5kIHdhcm5fb25fb25jZSBiZWNhdXNlIGJvdGggbWFjcm8N
CmFuZCBmdW5jdGlvbiBvZiB3YXJuX2ZsYWdzIGFyZSBuZWNlc3Nhcnk/DQo=

