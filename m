Return-Path: <linux-kernel+bounces-514344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CC5A355D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572DB3ACAA9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C58186284;
	Fri, 14 Feb 2025 04:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbT5E6bx"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7326B17B401;
	Fri, 14 Feb 2025 04:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739507656; cv=none; b=bVgVT/8W1pM0uMec/td9eLoBA9REK/71wdKiuMS9QshfL/G73GXavK12p9WmDfr4SoeS4MaJ1PZku0b0xul7lBttJqYAbkft28k8Gd1sfb1QrC8bVe3Es8DOgjzYedstekgeQ6tEdeKPucHePAJTkW+EMtK3OS2gnqfaN3nBZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739507656; c=relaxed/simple;
	bh=aE2wWcqpFbC4XebLj7NF3xjtNb+1wLW9AH1SRvAJy9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kC8Vn4PHooL3bWXg1Ie+QKgh1cPFq+emTmhWS0KwjE9IMT8KLhPq6jFNtQ+osXqGoOWcY4Bfg8SZq+0myG3y0J08LFKlqta8xocIF7UDLb6FRkTTKymqnD5nYmWqDMwZmUKd9ZrzL5PM3Y9a4UKpvOhshUUoZnJZcUvlW9rlp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbT5E6bx; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7f42ee3ecso325847166b.0;
        Thu, 13 Feb 2025 20:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739507653; x=1740112453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aE2wWcqpFbC4XebLj7NF3xjtNb+1wLW9AH1SRvAJy9A=;
        b=bbT5E6bxHBpVQS80mYwrID2IuYMN4ZFBzu82MlIrQP4EWTqQjzskOQdm2yLssOylxw
         ebsb8oleBO0Od5gKbysSObkfydMD9+G+cKyw5iVt8SSa0g/yauMhI7obvBQ9D/12xp3p
         KE1G/DaA3bvKcgF6htn+1AM1VU6YiolJwDavK3Uz5Lo9TUlJcKyXSUoHWARalayUya4Z
         awO5eYul19vEPza1INstZCU5npKHL8atE9TYicsu+euCdF9ofyylHxB5PmF4jUq8fNED
         NmrQjkEJWkRfVHMiEetty44RgJnI9FkuU4ZdfK9HMfYamkSWp52m0eBnwNWURPP/6JON
         mntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739507653; x=1740112453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aE2wWcqpFbC4XebLj7NF3xjtNb+1wLW9AH1SRvAJy9A=;
        b=Eyaf/MLSrsNi3JdHohGeoEwemi237dKNWSBhpO0DLbwMK8dSz7wWqwfHKgwehOcyL7
         4HQ72CJMmlq6PQkE2mKh8LMhaFrsi2YNn5CPi+xjI8rt5RafH7QSf2py/tSR5Ctlnlm5
         0c5HIxbXbZ2CzN3ydalapbdAJA6MAmoUeKU2NIJ3mPbqMk3HVqpmCovHBCzfqrezjJTE
         7MOoco8cuxCEh4/4qMevzlwNfbAZwZj9R3rzXr4tEsQn157g4ukFTuX0Z9o1KM5v3pwo
         KVgvF3ZTgqduxNmc5+oosfRGDhfPHIW765nPDKwoS70ELDXY4T+FXyun+Zu7VNjDpzvi
         PwJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrQp68rAddgmf4RUee9lv6TQ6Q0s+ehwkyOUReBGGzz/sA0hNcIUbLY/C4Gv1FfgRNMdc73VX3QOc=@vger.kernel.org, AJvYcCXcyd7TN84StiNcjjpdPxv/XEJjHOjjIzgDLe1BTUx3Xv+uTPfCGN9pkaTnYfsUKtYlvNm2dMw+FKkFBVXe@vger.kernel.org
X-Gm-Message-State: AOJu0YymyfU1Z/pILkQNlBQyVRHUP3wq/LEqEPOyczXXmdhpFG9SVr5s
	1bjpx0XK1jzdHU/HJh6KK6wYWPYUlQluwQEYSBvBlUkYlLpsx9BslGmxqBpSyv1dA8tEkAOYSSU
	z/7KLoAW+4XtLlufDfLloXIXOqKe8/GsqJDfaXQ==
X-Gm-Gg: ASbGncsovH5ujNbsuZf824XL2v2DHktKwDQlOgNnj74vJBzj+bOHgXIsnCSfh12h6hh
	bMmasG78FLxWb7k0PL8V4kNrrMSkBtRv8ERGXaPZobxSmIL76OVURUSS9YTZ9WYD6lyPpTZCC
X-Google-Smtp-Source: AGHT+IEdWqk6OuWF9cpgOPkxClX2jfBAmhUTYRnLlwYU2C8FQEalrxY4didEhXlEEI2pQRacKG1c6+qdxnFlk94LWCU=
X-Received: by 2002:a17:906:f59b:b0:ab6:8bc1:9b5a with SMTP id
 a640c23a62f3a-aba5018d9a1mr611382466b.41.1739507652395; Thu, 13 Feb 2025
 20:34:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213054222.21776-1-alexs@kernel.org> <20250213054222.21776-2-alexs@kernel.org>
 <5d35c3f6-a52f-4e63-a972-50ee2898947e@linux.dev> <CAD-N9QXhmNBUFPfo11-h0H0Du_JFNX_Qxcs8aoesW8=ABgneaw@mail.gmail.com>
In-Reply-To: <CAD-N9QXhmNBUFPfo11-h0H0Du_JFNX_Qxcs8aoesW8=ABgneaw@mail.gmail.com>
From: Alex Shi <seakeel@gmail.com>
Date: Fri, 14 Feb 2025 12:33:35 +0800
X-Gm-Features: AWEUYZk20DCwab62mCru-z3vCsCxAjsGUM0lUQ3P4Vqq843x7N2uOL-h_E0v6dQ
Message-ID: <CAJy-AmmZAuZWUS5TTuSGg5y33Q7Q52CGQ7en5vg_eB2W2y_s9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs/zh_CN: add few request for Chinese translation
To: Dongliang Mu <mudongliangabcd@gmail.com>
Cc: Yanteng Si <si.yanteng@linux.dev>, alexs@kernel.org, 
	Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

RG9uZ2xpYW5nIE11IDxtdWRvbmdsaWFuZ2FiY2RAZ21haWwuY29tPiDkuo4yMDI15bm0MuaciDE0
5pel5ZGo5LqUIDExOjI15YaZ6YGT77yaDQo+DQo+IE9uIFRodSwgRmViIDEzLCAyMDI1IGF0IDY6
MjTigK9QTSBZYW50ZW5nIFNpIDxzaS55YW50ZW5nQGxpbnV4LmRldj4gd3JvdGU6DQo+ID4NCj4g
Pg0KPiA+IOWcqCAyLzEzLzI1IDE6NDIgUE0sIGFsZXhzQGtlcm5lbC5vcmcg5YaZ6YGTOg0KPiA+
ID4gRnJvbTogQWxleCBTaGkgPGFsZXhzQGtlcm5lbC5vcmc+DQo+ID4gPg0KPiA+ID4gQSBnb29k
IGNoZWNrZWQgc3VtbWl0IGNvdWxkIHNhdmUgbXVjaCB0aW1lIGZvciBsaW51eC1kb2MgbWFpbnRh
aW5lci4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFNoaSA8YWxleHNAa2VybmVs
Lm9yZz4NCj4gPiA+IENjOiBZYW50ZW5nIFNpIDxzaXlhbnRlbmdAbG9vbmdzb24uY24+DQo+ID4g
PiBDYzogSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD4NCj4gPiA+IENjOiBsaW51eC1k
b2NAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IFlhbnRlbmcgU2kgPHNpLnlhbnRlbmdAbGludXguZGV2
Pg0KPiA+DQo+ID4NCj4gPg0KPiA+ID4gLS0tDQo+ID4gPiAgIERvY3VtZW50YXRpb24vdHJhbnNs
YXRpb25zL3poX0NOL2luZGV4LnJzdCB8IDggKysrKysrKy0NCj4gPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9pbmRleC5yc3QgYi9Eb2N1bWVu
dGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9pbmRleC5yc3QNCj4gPiA+IGluZGV4IDc1NzRlMTY3
MzE4MC4uY2M1MTJjYTU0MTcyIDEwMDY0NA0KPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFu
c2xhdGlvbnMvemhfQ04vaW5kZXgucnN0DQo+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5z
bGF0aW9ucy96aF9DTi9pbmRleC5yc3QNCj4gPiA+IEBAIC0yNiw3ICsyNiwxMyBAQA0KPiA+ID4g
ICDpobrkvr/or7TkuIvvvIzkuK3mlofmlofmoaPkuZ/pnIDopoHpgbXlrojlhoXmoLjnvJbnoIHp
o47moLzvvIzpo47moLzkuK3kuK3mloflkozoi7HmlofnmoTkuLvopoHkuI3lkIzlsLHmmK/kuK3m
locNCj4gPiA+ICAg55qE5a2X56ym5qCH54K55Y2g55So5Lik5Liq6Iux5paH5a2X56ym5a695bqm
77yM5omA5Lul77yM5b2T6Iux5paH6KaB5rGC5LiN6KaB6LaF6L+H5q+P6KGMMTAw5Liq5a2X56ym
5pe277yMDQo+ID4gPiAgIOS4reaWh+WwseS4jeimgei2hei/hzUw5Liq5a2X56ym44CC5Y+m5aSW
77yM5Lmf6KaB5rOo5oSPJy0n77yMJz0n562J56ym5Y+35LiO55u45YWz5qCH6aKY55qE5a+56b2Q
44CC5Zyo5bCGDQo+ID4gPiAt6KGl5LiB5o+Q5Lqk5Yiw56S+5Yy65LmL5YmN77yM5LiA5a6a6KaB
6L+b6KGM5b+F6KaB55qEIGBgY2hlY2twYXRjaC5wbGBgIOajgOafpeWSjOe8luivkea1i+ivleOA
gg0KPiA+ID4gK+ihpeS4geaPkOS6pOWIsOekvuWMuuS5i+WJje+8jOS4gOWumuimgei/m+ihjOW/
heimgeeahCBgYGNoZWNrcGF0Y2gucGxgYCDmo4Dmn6XlkoznvJbor5HmtYvor5XvvIznoa7kv50N
Cj4gPiA+ICvlnKggYGBtYWtlIGh0bWxkb2NzL3BkZmRvY3NgYCDkuK3kuI3lop7liqDmlrDnmoTl
kYrorabvvIzmnIDlkI7vvIzlronoo4Xmo4Dmn6XkvaDnlJ/miJDnmoQNCj4gPiA+ICtodG1sL3Bk
ZiDmlofku7bvvIznoa7orqTlroPku6znnIvotbfmnaXmmK/mraPluLjnmoTjgIINCj4gPiA+ICsN
Cj4gPiA+ICvmj5DkuqTkuYvliY3or7fnoa7orqTkvaDnmoTooaXkuIHlj6/ku6XmraPluLjmj5Dk
uqTliLDkuK3mlofmlofmoaPnu7TmiqTlupM6DQo+ID4gPiAraHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYWxleHMvbGludXguZ2l0Lw0KPiA+DQo+ID4gPiAr
5aaC5p6c5L2g55qE6KGl5LiB5L6d6LWW5LqO5YW25LuW5Lq655qE6KGl5LiBLCDlj6/ku6XkuI7l
hbbku5bkurrllYbph4/lkI7nlLHmn5DkuIDkuKrkurrlkIjlubbmj5DkuqTjgIINCj4gPg0KPiA+
IEkgdGhpbmsgdGhpcyByZXF1aXJlcyBhIGRldGFpbGVkIHR1dG9yaWFsLiBPdGhlcndpc2UsIGl0
DQo+ID4NCj4gPiB3aWxsIGluY3JlYXNlIHRoZSBkaWZmaWN1bHR5IGZvciBiZWdpbm5lcnMgdG8g
Z2V0IHN0YXJ0ZWQuDQo+ID4NCj4gPiBIb3cgYWJvdXQgcmVtb3ZpbmcgaXQgZm9yIG5vdz8gSSBo
YXZlIGEgcGxhbiB0byB3cml0ZQ0KPiA+DQo+ID4gYSB0cmFuc2xhdGlvbiBndWlkZWJvb2suIFdo
YXQncyB5b3VyIG9waW5pb24/DQo+DQo+IEdvb2QgaWRlYS4gSSBjYW4gaGVscCBjb250cmlidXRl
LiBPdXIgVHJhbnNsYXRpb24gVGVhbSBoYXMgYSBzaW1wbGUNCj4gb25lIHRvIGd1aWRlIHRlYW0g
bWVtYmVycyBpbiBrZXJuZWwgZG9jdW1lbnQgdHJhbnNsYXRpb24uDQo+DQo+IE9uZSBpc3N1ZSBp
biBteSBtaW5kIGlzLCBgbWFrZSBodG1sZG9jc2AgbmVlZHMgbXVjaCByZXNvdWNlIGluIHRoZSBj
b21waWxhdGlvbi4NCg0KTmljZSBkb2MhIExvb2tzIHZlcnkgdXNlZnVsLg0KQnV0IGl0IGFsc28g
bWVudGlvbmVkICdtYWtlIGh0bWxkb2NzJyBpcyByZXF1aXJlZCwgc28gd2hhdCdzIHlvdXINCmZp
bmFsIHN1Z2dlc3Rpb24gZm9yICdtYWtlIGh0bWxkb2NzJz8NCg0KPg0KPiBbMV0gaHR0cHM6Ly9n
aXRodWIuY29tL2h1c3Qtb3Blbi1hdG9tLWNsdWIvVHJhbnNsYXRlUHJvamVjdC93aWtpLzMuMS0l
RTUlODYlODUlRTYlQTAlQjglRTYlOTYlODclRTYlQTElQTMlRTclQkYlQkIlRTglQUYlOTElRTYl
OEMlODclRTUlOEQlOTcNCg==

