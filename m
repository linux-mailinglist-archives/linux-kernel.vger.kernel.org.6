Return-Path: <linux-kernel+bounces-514204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C847A353F8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA39E7A474B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8A486346;
	Fri, 14 Feb 2025 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI08z9GW"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F2B1E502;
	Fri, 14 Feb 2025 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498391; cv=none; b=FORo8CBu0MSv+3IpwB3uI+g2iF1A8zdtUugVxyO3AzB9wQas4eqXFdJ79+LAjnzjeFs5rZG6gO/anYYTldK4Z2ePY7GTpN6IoubtlQkA6dwlGxdU1J6ShtlcsdCZeMPLlgbDOV6/CZevyIqIt2WRmf5FKZefrTuIxGA2z4RFtWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498391; c=relaxed/simple;
	bh=xUf+AKuj701KwoLYDFxX/BpBCJ4X4GHeaSOxbCMiNQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uF/5wWi5Ckk62SpWXh7yGFb8XhXKoEPfb89yfhLnFEz5pEDsBKOslFH8RYxrOtN9i6rsyghAuk76OBOgOAPMkwEUrqPZvIZYa1j2jt7K5dfdSImCUth0IVF13UmCLSM5ICZQeMnlrv/hfgnPf3ZmR6uxdyiUy/2xcdQq/rIXs/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RI08z9GW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso261927166b.1;
        Thu, 13 Feb 2025 17:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739498388; x=1740103188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUf+AKuj701KwoLYDFxX/BpBCJ4X4GHeaSOxbCMiNQQ=;
        b=RI08z9GWYNP5ANkB7B2UrE76iw4jxndLs5dkbgGRLxbZOdf6wOydMcwFetPB6cm8kn
         6vRquE6cgN87BBzBtR/kvKxTu+cfGkhYWv6gea3Y+uIatnq0CFTlW0ocYn0xxKv29w7V
         kf7E26kJXzErcXUTwlgs5kSl9xzsxrL1QfVBj9FdF7Mu+PAf3MppHOPWS7LNlkWc446R
         tPxF0unz10UH32khDjE+AFRu8iBCBj5Pedkatys1ps3zNbqEguUhbVeRInEXrWCbirYz
         vFdgQDabaP0HGIIoM9xTMTXc0KWLhNVxIQQWHInr6goIBwDVaSTdqvOkrPtuCOMVyYuu
         Fhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739498388; x=1740103188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUf+AKuj701KwoLYDFxX/BpBCJ4X4GHeaSOxbCMiNQQ=;
        b=Ea9ii4MzGYPkbz1p+JVFvWJ+63qfkIFINVYMIIcsVJrjUjfmATQaZqhI6034y40SkT
         b1vpQgSa5FQFs0ogJeED5Ku9RbtK8Hyf9I7iY4lZ16aO/Elw4YR2rbsyW8J1iVQlYYc3
         5gFaPVy/O+Ci2T0PXFT/U8HcurGtzfh2RgBEFafCBLLPgV41y5UM0rXzIAxxEEk+qQsV
         gFENm/j737jWdIY52krzbRipbABZczuayArNfO7fyXcWUYC6jDcmqUbuSRdm0ExrNaoq
         laexPSlgG7Mw5oE44UGp35N2AgWK4HRwHvHcO3RehQPQxY3kRJEihbdW62fNOJ6A1cZ/
         RIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpREULAlpA5DusieTFx4afs9iharLCLCgykVZYoIm0fB2LYrq2kp/ZYc4Ncf13wcDDbxIe06ro56RF2CAZ@vger.kernel.org, AJvYcCXm9D7qKU1PZD939bS0XOFWSIJYwJaFlEAUOFwx7rd24b1MtwgHA4jymy9dioPP/pIHtc/CVrh0GrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpHR4n8mOXA9EVGX47qmkDCpmj1bB4arSaACmvEWmA8RayLCpL
	Mado5CxvLW8OuV0GwWeL8hLxndMzeYfqc6tcXK+yfsd+L5iBaKip3CufBq1LBW6SqqcNxfytjsX
	B4z0dfI6uwPwQnYAtDSIRijTAzx8IWpbWWePWSw==
X-Gm-Gg: ASbGnctftGTu/f0rBzn1L+C5tUFiVB0i/ZZiwDVIilnnd+yRRjaOdZ3BKFUF1dv7BTO
	vRybpGQ2/QukSLOOobG7BM3Dzz74Etd7/8Fh4yAsT+zbI6dKs/SwwqQsuEAVsCEnSrDV/IQUU
X-Google-Smtp-Source: AGHT+IHazsHzK2ZgK3iMJlmUZlf8BtYEIImbdyuSjLbiRqylJLATjCuxm2dkSUns2aKpanz3Royfq5eZ7/vj1basQCY=
X-Received: by 2002:a17:907:dab:b0:aa6:8cbc:8d15 with SMTP id
 a640c23a62f3a-ab7f338ef2fmr1002716066b.14.1739498388038; Thu, 13 Feb 2025
 17:59:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213054222.21776-1-alexs@kernel.org> <20250213054222.21776-2-alexs@kernel.org>
 <5d35c3f6-a52f-4e63-a972-50ee2898947e@linux.dev>
In-Reply-To: <5d35c3f6-a52f-4e63-a972-50ee2898947e@linux.dev>
From: Alex Shi <seakeel@gmail.com>
Date: Fri, 14 Feb 2025 09:59:11 +0800
X-Gm-Features: AWEUYZlTQ-Wgf7d0bXGplnw6p8jSNFO0YPpYXQnmHbA3MmOppaTU62KO4Lj_81Q
Message-ID: <CAJy-Amn7ohs2PxzygRmi3F=fNnuMrz9cEpsj5EFwgcq+O9ymcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs/zh_CN: add few request for Chinese translation
To: Yanteng Si <si.yanteng@linux.dev>
Cc: alexs@kernel.org, Yanteng Si <siyanteng@loongson.cn>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

WWFudGVuZyBTaSA8c2kueWFudGVuZ0BsaW51eC5kZXY+IOS6jjIwMjXlubQy5pyIMTPml6Xlkajl
m5sgMTg6MTnlhpnpgZPvvJoNCj4NCj4NCj4g5ZyoIDIvMTMvMjUgMTo0MiBQTSwgYWxleHNAa2Vy
bmVsLm9yZyDlhpnpgZM6DQo+ID4gRnJvbTogQWxleCBTaGkgPGFsZXhzQGtlcm5lbC5vcmc+DQo+
ID4NCj4gPiBBIGdvb2QgY2hlY2tlZCBzdW1taXQgY291bGQgc2F2ZSBtdWNoIHRpbWUgZm9yIGxp
bnV4LWRvYyBtYWludGFpbmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBTaGkgPGFs
ZXhzQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IFlhbnRlbmcgU2kgPHNpeWFudGVuZ0Bsb29uZ3Nvbi5j
bj4NCj4gPiBDYzogSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD4NCj4gPiBDYzogbGlu
dXgtZG9jQHZnZXIua2VybmVsLm9yZw0KPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+DQo+IFJldmlld2VkLWJ5OiBZYW50ZW5nIFNpIDxzaS55YW50ZW5nQGxpbnV4LmRldj4N
Cj4NCj4NCj4NCj4gPiAtLS0NCj4gPiAgIERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NO
L2luZGV4LnJzdCB8IDggKysrKysrKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L3RyYW5zbGF0aW9ucy96aF9DTi9pbmRleC5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9u
cy96aF9DTi9pbmRleC5yc3QNCj4gPiBpbmRleCA3NTc0ZTE2NzMxODAuLmNjNTEyY2E1NDE3MiAx
MDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9pbmRleC5y
c3QNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9pbmRleC5yc3QN
Cj4gPiBAQCAtMjYsNyArMjYsMTMgQEANCj4gPiAgIOmhuuS+v+ivtOS4i++8jOS4reaWh+aWh+ah
o+S5n+mcgOimgemBteWuiOWGheaguOe8lueggemjjuagvO+8jOmjjuagvOS4reS4reaWh+WSjOiL
seaWh+eahOS4u+imgeS4jeWQjOWwseaYr+S4reaWhw0KPiA+ICAg55qE5a2X56ym5qCH54K55Y2g
55So5Lik5Liq6Iux5paH5a2X56ym5a695bqm77yM5omA5Lul77yM5b2T6Iux5paH6KaB5rGC5LiN
6KaB6LaF6L+H5q+P6KGMMTAw5Liq5a2X56ym5pe277yMDQo+ID4gICDkuK3mloflsLHkuI3opoHo
toXov4c1MOS4quWtl+espuOAguWPpuWklu+8jOS5n+imgeazqOaEjyctJ++8jCc9J+etieespuWP
t+S4juebuOWFs+agh+mimOeahOWvuem9kOOAguWcqOWwhg0KPiA+IC3ooaXkuIHmj5DkuqTliLDn
pL7ljLrkuYvliY3vvIzkuIDlrpropoHov5vooYzlv4XopoHnmoQgYGBjaGVja3BhdGNoLnBsYGAg
5qOA5p+l5ZKM57yW6K+R5rWL6K+V44CCDQo+ID4gK+ihpeS4geaPkOS6pOWIsOekvuWMuuS5i+WJ
je+8jOS4gOWumuimgei/m+ihjOW/heimgeeahCBgYGNoZWNrcGF0Y2gucGxgYCDmo4Dmn6Xlkozn
vJbor5HmtYvor5XvvIznoa7kv50NCj4gPiAr5ZyoIGBgbWFrZSBodG1sZG9jcy9wZGZkb2NzYGAg
5Lit5LiN5aKe5Yqg5paw55qE5ZGK6K2m77yM5pyA5ZCO77yM5a6J6KOF5qOA5p+l5L2g55Sf5oiQ
55qEDQo+ID4gK2h0bWwvcGRmIOaWh+S7tu+8jOehruiupOWug+S7rOeci+i1t+adpeaYr+ato+W4
uOeahOOAgg0KPiA+ICsNCj4gPiAr5o+Q5Lqk5LmL5YmN6K+356Gu6K6k5L2g55qE6KGl5LiB5Y+v
5Lul5q2j5bi45o+Q5Lqk5Yiw5Lit5paH5paH5qGj57u05oqk5bqTOg0KPiA+ICtodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9hbGV4cy9saW51eC5naXQvDQo+
DQo+ID4gK+WmguaenOS9oOeahOihpeS4geS+nei1luS6juWFtuS7luS6uueahOihpeS4gSwg5Y+v
5Lul5LiO5YW25LuW5Lq65ZWG6YeP5ZCO55Sx5p+Q5LiA5Liq5Lq65ZCI5bm25o+Q5Lqk44CCDQo+
DQo+IEkgdGhpbmsgdGhpcyByZXF1aXJlcyBhIGRldGFpbGVkIHR1dG9yaWFsLiBPdGhlcndpc2Us
IGl0DQoNCkkgZG9uJ3Qga25vdyBpZiBpdCBjb3VzZXMgY29uZnVzaW9uLiBNYXliZSBsZXQncyB0
aGlzIHN1Z2dlc3Rpb24gaGVyZQ0KYW5kIHRvIHNlZSB0aGUgcmVzcG9uc2UgZnJvbSBjb21tdW5p
dHk/DQoNCj4NCj4gd2lsbCBpbmNyZWFzZSB0aGUgZGlmZmljdWx0eSBmb3IgYmVnaW5uZXJzIHRv
IGdldCBzdGFydGVkLg0KPg0KPiBIb3cgYWJvdXQgcmVtb3ZpbmcgaXQgZm9yIG5vdz8gSSBoYXZl
IGEgcGxhbiB0byB3cml0ZQ0KPg0KPiBhIHRyYW5zbGF0aW9uIGd1aWRlYm9vay4gV2hhdCdzIHlv
dXIgb3Bpbmlvbj8NCg0KSSdtIGdsYWQgdG8gaGVhciB0aGF0IHlvdSB3aWxsIGhhdmUgYSB0cmFu
c2xhdGlvbiBndWlkZS4gOikNCkhvcGUgdG8gc2VlIGl0IHNvb24hDQoNClRoYW5rcyENCg==

