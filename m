Return-Path: <linux-kernel+bounces-514773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EFFA35B57
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09EE5168F49
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2BA255E42;
	Fri, 14 Feb 2025 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVZr1ACn"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99A42AAF;
	Fri, 14 Feb 2025 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528339; cv=none; b=HjYA3fWo8t4cQ7PYdNdy+ngNYd/A0pqktNSMjcWy7X+CravejAMzyLOcpfATU+YeUvabqVzIZj2Y5+rdusYxnrhWwf16fcnLx4Vs8BMuw/dIDil6Myu4Ojpmbt5KDNMFxnexV1SHvgzVCQTnUuXk5y34SjQo+e1DeDbSRCmPUXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528339; c=relaxed/simple;
	bh=Il568naOew6ovHDXO3jTpcQ9YSm2HukC1p8h8DNhhOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQUTYubXekvYpPm6FGScno9uGYaUjA1EVfmLOk+TAax9PSo7mGWiaVtIG402tJ0emz/p/5MvzrkGVWGBNcDN4IWsCobK5CDJNvWMm0BE5q8vcZ/nQSfE5xOPmpRPLTkZWWTOq+cLRrtEyT1wHMZnOOS3NmUoHeGl4efSZkoS9Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVZr1ACn; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7d451f7c4so275251166b.0;
        Fri, 14 Feb 2025 02:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739528336; x=1740133136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il568naOew6ovHDXO3jTpcQ9YSm2HukC1p8h8DNhhOI=;
        b=nVZr1ACnb3QWcfNGUuPCQdxnOnGvAy7KUaw/wQIfxFXZrcpSpc7kcV6f2PbDKz5MG7
         i5wkhXawIpe4481/mi5uAbUnJyj27wGLAjdTl1ucI1Ag6GLchH0mfd6LBA1y+IQ6xshg
         +7KgascNPFHxfOT86GmLk4yz6sJmdQPp3XjfkGqMtSnhVoDeqvFhBAOE9VDs9Z3oQnkD
         9IwrEnmJnLBeGBgJDaZ2ZMDHEo30I5/swyFUgBVSXX5unPiYplJoQ1ssoqvzYjZDVBe/
         OHuwBbck71Py4ZnFbUISNnu6laQ4orJBYhuOns5ZojvEKpHhChWaJBD9pp0Ks9jFyDAq
         VoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739528336; x=1740133136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Il568naOew6ovHDXO3jTpcQ9YSm2HukC1p8h8DNhhOI=;
        b=twoOBBr2JP4aJ2g1usdG3PN1ffC3ghp0SBw5E/ouiBjofCVBRZgWw2L91VzrtWGS62
         rt6IQR+0nMNp5ULfhmi2CbYD+l9p2TaZsS5bwN9CSehz5vssF60MzrNHyyG7p+9Ld+of
         6mbhWudEWAcf55YqCHPe2dJcIhG2LOPwwSZ1hFXlc9s7VNqL0+wxf7G2nKS07cfpjmXf
         IcyUzgoi6L/3Gux15vLFAgfl9OJ9lsIlRCmFvYOBsLMsFIbEXJjzoTxjT4KoF54h3KHJ
         T/axr2jP08pcuJdSg1FU0rxNs2dY/c/3CKKzQcyVx0BalBQpPNOMSFfTTWXj//qwvJM0
         8dyg==
X-Forwarded-Encrypted: i=1; AJvYcCUI4c7cGMVt1D2/hH/2/svHlQmLAgN1QtaNAP2cZ9M1Nq5UjtAV0gjd+aic4M0AoM+zCTXx2+hqUJW0j3/O@vger.kernel.org, AJvYcCXU9EZDgMR3YEUCYy5L1d8n9kd+D/U+iaoDTlp+mdVUtqnv62IYr5Iyo5ew2l3PF8p/tnWpqN2oyRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXpQlndEhBjOFoyK3qW9vke081OFmOhrczQZ47862xDFtk749k
	0GczXmlZfNIU/eRpurkRPJAVhrGzOQsBKeitSR8YdjwSp01y26+A68VD6vHDdlHWNC2iESo/DnC
	EF1+A+ScrP4elSPVpWI1smJToSDQ=
X-Gm-Gg: ASbGncumLX4DUb48t/0aC6XWUieRWp+v9FGvyIJzoA+gRk08/iTHmioTT7LKEmJrV+q
	OuHykr2IWoEaXbfPtNgHqOjYQtVTNTMHnOgfMR64laCjOWHyGSkR0vi62rdBOt6Xu4FOOkMHpum
	w=
X-Google-Smtp-Source: AGHT+IGuQJEC4zgNy2eM9oaft5R2o2c2BUFYgvEC+eGiMK0cL25sANfPhcV2rzuqV+3GILHvd7e060wRpqb4IlrFxRw=
X-Received: by 2002:a17:907:2cc5:b0:ab6:f4e7:52f9 with SMTP id
 a640c23a62f3a-ab7f33d1874mr1161608366b.25.1739528335560; Fri, 14 Feb 2025
 02:18:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213054222.21776-1-alexs@kernel.org> <20250213054222.21776-2-alexs@kernel.org>
 <5d35c3f6-a52f-4e63-a972-50ee2898947e@linux.dev> <CAD-N9QXhmNBUFPfo11-h0H0Du_JFNX_Qxcs8aoesW8=ABgneaw@mail.gmail.com>
 <CAJy-AmmZAuZWUS5TTuSGg5y33Q7Q52CGQ7en5vg_eB2W2y_s9Q@mail.gmail.com>
In-Reply-To: <CAJy-AmmZAuZWUS5TTuSGg5y33Q7Q52CGQ7en5vg_eB2W2y_s9Q@mail.gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Fri, 14 Feb 2025 18:18:28 +0800
X-Gm-Features: AWEUYZk8FkaNBxlc6-QeiBhxvN3sQSYoOpIaiZdzvuNPIENlyZuamLISF2d6KH8
Message-ID: <CAD-N9QXRjr3yVtyucRbRJqXcJy0JwR=UhcNoHPbs3MQ2JcGKdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs/zh_CN: add few request for Chinese translation
To: Alex Shi <seakeel@gmail.com>
Cc: Yanteng Si <si.yanteng@linux.dev>, alexs@kernel.org, 
	Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBGZWIgMTQsIDIwMjUgYXQgMTI6MzTigK9QTSBBbGV4IFNoaSA8c2Vha2VlbEBnbWFp
bC5jb20+IHdyb3RlOg0KPg0KPiBEb25nbGlhbmcgTXUgPG11ZG9uZ2xpYW5nYWJjZEBnbWFpbC5j
b20+IOS6jjIwMjXlubQy5pyIMTTml6XlkajkupQgMTE6MjXlhpnpgZPvvJoNCj4gPg0KPiA+IE9u
IFRodSwgRmViIDEzLCAyMDI1IGF0IDY6MjTigK9QTSBZYW50ZW5nIFNpIDxzaS55YW50ZW5nQGxp
bnV4LmRldj4gd3JvdGU6DQo+ID4gPg0KPiA+ID4NCj4gPiA+IOWcqCAyLzEzLzI1IDE6NDIgUE0s
IGFsZXhzQGtlcm5lbC5vcmcg5YaZ6YGTOg0KPiA+ID4gPiBGcm9tOiBBbGV4IFNoaSA8YWxleHNA
a2VybmVsLm9yZz4NCj4gPiA+ID4NCj4gPiA+ID4gQSBnb29kIGNoZWNrZWQgc3VtbWl0IGNvdWxk
IHNhdmUgbXVjaCB0aW1lIGZvciBsaW51eC1kb2MgbWFpbnRhaW5lci4NCj4gPiA+ID4NCj4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogQWxleCBTaGkgPGFsZXhzQGtlcm5lbC5vcmc+DQo+ID4gPiA+IENj
OiBZYW50ZW5nIFNpIDxzaXlhbnRlbmdAbG9vbmdzb24uY24+DQo+ID4gPiA+IENjOiBKb25hdGhh
biBDb3JiZXQgPGNvcmJldEBsd24ubmV0Pg0KPiA+ID4gPiBDYzogbGludXgtZG9jQHZnZXIua2Vy
bmVsLm9yZw0KPiA+ID4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4N
Cj4gPiA+IFJldmlld2VkLWJ5OiBZYW50ZW5nIFNpIDxzaS55YW50ZW5nQGxpbnV4LmRldj4NCj4g
PiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAgRG9jdW1lbnRhdGlvbi90
cmFuc2xhdGlvbnMvemhfQ04vaW5kZXgucnN0IHwgOCArKysrKysrLQ0KPiA+ID4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4NCj4gPiA+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2luZGV4LnJz
dCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2luZGV4LnJzdA0KPiA+ID4gPiBp
bmRleCA3NTc0ZTE2NzMxODAuLmNjNTEyY2E1NDE3MiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vaW5kZXgucnN0DQo+ID4gPiA+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2luZGV4LnJzdA0KPiA+ID4gPiBAQCAtMjYs
NyArMjYsMTMgQEANCj4gPiA+ID4gICDpobrkvr/or7TkuIvvvIzkuK3mlofmlofmoaPkuZ/pnIDo
poHpgbXlrojlhoXmoLjnvJbnoIHpo47moLzvvIzpo47moLzkuK3kuK3mloflkozoi7HmlofnmoTk
uLvopoHkuI3lkIzlsLHmmK/kuK3mlocNCj4gPiA+ID4gICDnmoTlrZfnrKbmoIfngrnljaDnlKjk
uKTkuKroi7HmloflrZfnrKblrr3luqbvvIzmiYDku6XvvIzlvZPoi7HmlofopoHmsYLkuI3opoHo
toXov4fmr4/ooYwxMDDkuKrlrZfnrKbml7bvvIwNCj4gPiA+ID4gICDkuK3mloflsLHkuI3opoHo
toXov4c1MOS4quWtl+espuOAguWPpuWklu+8jOS5n+imgeazqOaEjyctJ++8jCc9J+etieespuWP
t+S4juebuOWFs+agh+mimOeahOWvuem9kOOAguWcqOWwhg0KPiA+ID4gPiAt6KGl5LiB5o+Q5Lqk
5Yiw56S+5Yy65LmL5YmN77yM5LiA5a6a6KaB6L+b6KGM5b+F6KaB55qEIGBgY2hlY2twYXRjaC5w
bGBgIOajgOafpeWSjOe8luivkea1i+ivleOAgg0KPiA+ID4gPiAr6KGl5LiB5o+Q5Lqk5Yiw56S+
5Yy65LmL5YmN77yM5LiA5a6a6KaB6L+b6KGM5b+F6KaB55qEIGBgY2hlY2twYXRjaC5wbGBgIOaj
gOafpeWSjOe8luivkea1i+ivle+8jOehruS/nQ0KPiA+ID4gPiAr5ZyoIGBgbWFrZSBodG1sZG9j
cy9wZGZkb2NzYGAg5Lit5LiN5aKe5Yqg5paw55qE5ZGK6K2m77yM5pyA5ZCO77yM5a6J6KOF5qOA
5p+l5L2g55Sf5oiQ55qEDQo+ID4gPiA+ICtodG1sL3BkZiDmlofku7bvvIznoa7orqTlroPku6zn
nIvotbfmnaXmmK/mraPluLjnmoTjgIINCj4gPiA+ID4gKw0KPiA+ID4gPiAr5o+Q5Lqk5LmL5YmN
6K+356Gu6K6k5L2g55qE6KGl5LiB5Y+v5Lul5q2j5bi45o+Q5Lqk5Yiw5Lit5paH5paH5qGj57u0
5oqk5bqTOg0KPiA+ID4gPiAraHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvYWxleHMvbGludXguZ2l0Lw0KPiA+ID4NCj4gPiA+ID4gK+WmguaenOS9oOeahOih
peS4geS+nei1luS6juWFtuS7luS6uueahOihpeS4gSwg5Y+v5Lul5LiO5YW25LuW5Lq65ZWG6YeP
5ZCO55Sx5p+Q5LiA5Liq5Lq65ZCI5bm25o+Q5Lqk44CCDQo+ID4gPg0KPiA+ID4gSSB0aGluayB0
aGlzIHJlcXVpcmVzIGEgZGV0YWlsZWQgdHV0b3JpYWwuIE90aGVyd2lzZSwgaXQNCj4gPiA+DQo+
ID4gPiB3aWxsIGluY3JlYXNlIHRoZSBkaWZmaWN1bHR5IGZvciBiZWdpbm5lcnMgdG8gZ2V0IHN0
YXJ0ZWQuDQo+ID4gPg0KPiA+ID4gSG93IGFib3V0IHJlbW92aW5nIGl0IGZvciBub3c/IEkgaGF2
ZSBhIHBsYW4gdG8gd3JpdGUNCj4gPiA+DQo+ID4gPiBhIHRyYW5zbGF0aW9uIGd1aWRlYm9vay4g
V2hhdCdzIHlvdXIgb3Bpbmlvbj8NCj4gPg0KPiA+IEdvb2QgaWRlYS4gSSBjYW4gaGVscCBjb250
cmlidXRlLiBPdXIgVHJhbnNsYXRpb24gVGVhbSBoYXMgYSBzaW1wbGUNCj4gPiBvbmUgdG8gZ3Vp
ZGUgdGVhbSBtZW1iZXJzIGluIGtlcm5lbCBkb2N1bWVudCB0cmFuc2xhdGlvbi4NCj4gPg0KPiA+
IE9uZSBpc3N1ZSBpbiBteSBtaW5kIGlzLCBgbWFrZSBodG1sZG9jc2AgbmVlZHMgbXVjaCByZXNv
dWNlIGluIHRoZSBjb21waWxhdGlvbi4NCj4NCj4gTmljZSBkb2MhIExvb2tzIHZlcnkgdXNlZnVs
Lg0KPiBCdXQgaXQgYWxzbyBtZW50aW9uZWQgJ21ha2UgaHRtbGRvY3MnIGlzIHJlcXVpcmVkLCBz
byB3aGF0J3MgeW91cg0KPiBmaW5hbCBzdWdnZXN0aW9uIGZvciAnbWFrZSBodG1sZG9jcyc/DQoN
Ck15IGZpbmFsIHN1Z2dlc3Rpb24gaXMgdG8gYXNrIGRldmVsb3BlcnMgdG8gZG8gdGhpcyBhcyB3
ZSB3aWxsIGNoZWNrDQp0aGlzIGluIHRoZSByZXZpZXcgcHJvY2Vzcy4NCg0KV2hhdCBJIG1lYW4g
aXMgdG8gbWVudGlvbiB0aGF0LCBgbWFrZSBodG1sZG9jc2Agd291bGQgbmVlZCBsb3RzIG9mDQp0
aW1lIHRvIGNvbXBpbGUgYW5kIHNvbWUgdGlwcyBhYm91dCB0aGlzLCBmb3IgZXhhbXBsZSwNCg0K
SXQgdGFrZXMgcXVpdGUgYSBiaXQgb2YgdGltZSB0byBmaW5pc2ggcnVubmluZyBgbWFrZSBodG1s
ZG9jc2AuIEdyYWIgYQ0KY29mZmVlIGFuZCByZWxheCB3aGlsZSB5b3Ugd2FpdCENCg0KRG9uZ2xp
YW5nIE11DQoNCj4NCj4gPg0KPiA+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vaHVzdC1vcGVuLWF0
b20tY2x1Yi9UcmFuc2xhdGVQcm9qZWN0L3dpa2kvMy4xLSVFNSU4NiU4NSVFNiVBMCVCOCVFNiU5
NiU4NyVFNiVBMSVBMyVFNyVCRiVCQiVFOCVBRiU5MSVFNiU4QyU4NyVFNSU4RCU5Nw0K

