Return-Path: <linux-kernel+bounces-308297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5EF9659F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C4B1C216A0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98E016C695;
	Fri, 30 Aug 2024 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFQVH14J"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6516B38B;
	Fri, 30 Aug 2024 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005909; cv=none; b=PADfrLSXStSWXcpWieishuuy2NiUEuDABd7ZPGOzn+hruM7vMx1jAqmCEAvFK1Vz/ldfNwQ3ZHno61LWpjYYZWG4d2fTlrx9kyV4HgsC6dCvWj9K/zO1XTEvU5CbLlNsFBonQwh8RjRhHbVvxSYyMO88Yry8d3PV7qlXC8DXTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005909; c=relaxed/simple;
	bh=vtq1wh0UpMSgt2sMCTxSY1bqZjLCpM6PrtifRnjlT4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLd9Dg0cFUJAPOcqWG7d3cYLMDSiDoMEJb6lIZFl1q5Uw69pRtK5MubKG+F4J4DR12IUVRvyrHoW3vq1FcCd2m0jc9E6+U78C5dxcuXmVD5zyZ00dp82XgenYJkqet3hyHdAUHY2b3Q3zjrWHpFOu73bq3OoWChtn22v6QVN+EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFQVH14J; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5da686531d3so972865eaf.3;
        Fri, 30 Aug 2024 01:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725005906; x=1725610706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtq1wh0UpMSgt2sMCTxSY1bqZjLCpM6PrtifRnjlT4s=;
        b=VFQVH14J9pHkLhlzd2YiyzI9rlxjhRbAIwGtsUwhxbzyA9WNasdkyq+6SDJZB9IGWy
         tOMduX8yflDaRjJv8hT71EsAsRbOs9FwWMgaaxlQTBBV3WSl1Zx0mizdFU4z4FUKfiNS
         sbZn34er3uvYs1Iax0i2e4uhJOObBocUhct8C0IGjFtbYkgW/Ks2Pqvv50CQZdFoxqr7
         aWtaSRagUm9x8YMaaGfn/Kr9RKLwjqOS8kazA/BBS28y/y4J/cLojtZLe/7xsRlRQ7YW
         rSdrKmMJlOwxawu4AyY0P3X+CG2Pvly1pxV/Ttz+793mOGdiVlDUldpUFGmruVzqIH9r
         Ulaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725005906; x=1725610706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtq1wh0UpMSgt2sMCTxSY1bqZjLCpM6PrtifRnjlT4s=;
        b=FiX47GmyHZvLDiLOMSN+cafwGjRbCndgrv0edpqjQo/y5MJUWrd/i3DCmo5wr59Ox6
         2KqKTcK2Vqgobhp/0hi2XhJQUVp3N5s4r11g41Md2Bcn7HlSzDRAiHibrgvcafGLwXPc
         Akw3jF/kKglC/BCW6OMONq56WncAv3Nwo3ZvihUVAnLk0YJNYd9yUQf7iYS++fA5RBrt
         EZKrXJamEPssbw2DipxFUK6IrpbU+cVb9J0fx/kDEmlVVb8Q70kfv9Blhk1sHSItW9+R
         mLQanuxlqhyGskFId6dAQE4mev5faBxGdGSMz0ypXLZdXRekiBGssiiIPv+TkQsUD/yB
         syxw==
X-Forwarded-Encrypted: i=1; AJvYcCUcF0V88le99+HxaIx/CMzpJg7FVucSUj/nYiX3RcK1JbmRaFtNKLd4dZJBnrlUUFev6E6hRAYtAZGwzokI@vger.kernel.org, AJvYcCWmnw7ZegKrPU+3RcQY0MeOVD7H/izICkfLBlZwtoG+vFRpUQCDUACAfDgdFSE9HDgdIf038tsX6s0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7gmlUBFZekke2PTo+mk4EvK7OwhfgzxX6Wk0tZmuV+YdPDOPt
	eqKb8SvxLb18d0sEhvafmPJ44rHiHYKuvTwbZl2BjxWho3oTdXpg69YvTCRAPKMb3/4JKt+E3r7
	ZFO9JtIWa4CZ3D4+Pii1ANmY1xsE=
X-Google-Smtp-Source: AGHT+IHuAEAVU2oHCnhdWsOKrMGFGZI7SZP6YCIGxAdPnMNyQMCx1uCP56J6AeuhlUo1rml7tSHguSR2RmkPelUhijE=
X-Received: by 2002:a05:6820:1acd:b0:5df:a346:a1bd with SMTP id
 006d021491bc7-5dfacf68f02mr1587260eaf.6.1725005905628; Fri, 30 Aug 2024
 01:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828074305.314666-1-dzm91@hust.edu.cn> <04184aa1-475e-4e1f-9e05-21f59a0787d3@linux.dev>
 <2e6e368f-0f2a-4724-892e-06cfe3fba97e@linux.dev>
In-Reply-To: <2e6e368f-0f2a-4724-892e-06cfe3fba97e@linux.dev>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Fri, 30 Aug 2024 16:17:59 +0800
Message-ID: <CAD-N9QUBwM-Y1pwEiu5sLGaVVxL_taj-EBYnjUuc4k2hyJ2xbw@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: add the translation of kbuild/gcc-plugins.rst
To: YanTeng Si <si.yanteng@linux.dev>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBBdWcgMzAsIDIwMjQgYXQgMjoxM+KAr1BNIFlhblRlbmcgU2kgPHNpLnlhbnRlbmdA
bGludXguZGV2PiB3cm90ZToNCj4NCj4NCj4NCj4NCj4g5ZyoIDIwMjQvOC8yOSAxODoyMiwgWWFu
VGVuZyBTaSDlhpnpgZM6DQo+ID4NCj4gPg0KPiA+DQo+ID4g5ZyoIDIwMjQvOC8yOCAxNTo0Miwg
RG9uZ2xpYW5nIE11IOWGmemBkzoNCj4gPj4gRmluaXNoIHRoZSB0cmFuc2xhdGlvbiBvZiBrYnVp
bGQvZ2NjLXBsdWdpbnMucnN0IGFuZCBtb3ZlIGdjYy1wbHVnaW5zDQo+ID4+IGZyb20gVE9ETyB0
byB0aGUgbWFpbiBib2R5Lg0KPiA+Pg0KPiA+PiBVcGRhdGUgdG8gY29tbWl0IDM4MzJkMWZkODRi
NiAoImRvY3MvY29yZS1hcGk6IGV4cGFuZCBGZWRvcmENCj4gPj4gaW5zdHJ1Y3Rpb25zDQo+ID4+
IGZvciBHQ0MgcGx1Z2lucyIpDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IERvbmdsaWFuZyBN
dSA8ZHptOTFAaHVzdC5lZHUuY24+DQo+ID4+IC0tLQ0KPiA+PiAgIC4uLi90cmFuc2xhdGlvbnMv
emhfQ04va2J1aWxkL2djYy1wbHVnaW5zLnJzdCB8IDEyNiArKysrKysrKysrKysrKysrKysNCj4g
Pj4gICAuLi4vdHJhbnNsYXRpb25zL3poX0NOL2tidWlsZC9pbmRleC5yc3QgICAgICAgfCAgIDIg
Ky0NCj4gPj4gICAyIGZpbGVzIGNoYW5nZWQsIDEyNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4+IERvY3VtZW50YXRpb24vdHJhbnNs
YXRpb25zL3poX0NOL2tidWlsZC9nY2MtcGx1Z2lucy5yc3QNCj4gPj4NCj4gPj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2tidWlsZC9nY2MtcGx1Z2lucy5y
c3QNCj4gPj4gYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9rYnVpbGQvZ2NjLXBs
dWdpbnMucnN0DQo+ID4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4+IGluZGV4IDAwMDAwMDAw
MDAwMC4uMjE0OTQ1YTRlY2YzDQo+ID4+IC0tLSAvZGV2L251bGwNCj4gPj4gKysrIGIvRG9jdW1l
bnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04va2J1aWxkL2djYy1wbHVnaW5zLnJzdA0KPiA+PiBA
QCAtMCwwICsxLDEyNiBAQA0KPiA+PiArLi4gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjANCj4gPj4gKw0KPiA+PiArLi4gaW5jbHVkZTo6IC4uL2Rpc2NsYWltZXItemhfQ04ucnN0DQo+
ID4+ICsNCj4gPj4gKzpPcmlnaW5hbDogRG9jdW1lbnRhdGlvbi9rYnVpbGQvZ2NjLXBsdWdpbnMu
cnN0DQo+ID4+ICs6VHJhbnNsYXRvcjog5oWV5Yas5LquIERvbmdsaWFuZyBNdSA8ZHptOTFAaHVz
dC5lZHUuY24+DQo+ID4+ICsNCj4gPj4gKz09PT09PT09PT09PT09PT0NCj4gPj4gK0dDQyDmj5Lk
u7bln7rnoYDorr7mlr0NCj4gPj4gKz09PT09PT09PT09PT09PT0NCj4gPj4gKw0KPiA+PiArDQo+
ID4NCj4gPj4gK+S7i+e7jQ0KPiA+PiArPT09PT09PT09PT09DQo+ID4gUGxlYXNlIHRyaW0gdGhl
IGxlbmd0aCBvZiB0aGUgZXF1YWwgc2lnbiBsaW5lLg0KPiA+PiArDQo+ID4+ICtHQ0Mg5o+S5Lu2
5piv5Li657yW6K+R5Zmo5o+Q5L6b6aKd5aSW5Yqf6IO955qE5Y+v5Yqg6L295qih5Z2XDQo+ID4+
IFsxXV/jgILlroPku6zlr7nkuo7ov5DooYzml7bmj5Loo4XlkozpnZnmgIHliIbmnpDpnZ7luLjm
nInnlKjjgIINCj4gPj4gK+aIkeS7rOWPr+S7peWcqOe8luivkei/h+eoi+S4remAmui/h+Wbnuiw
gyBbMl1f77yMR0lNUExFIFszXV/vvIxJUEEgWzRdXyDlkowgUlRMIFBhc3Nlcw0KPiA+PiBbNV1f
DQo+ID4+ICvvvIjor5HogIXms6jvvJpQYXNzDQo+ID4+IOaYr+e8luivkeWZqOaJgOmHh+eUqOea
hOS4gOenjee7k+aehOWMluaKgOacr++8jOeUqOS6juWujOaIkOe8luivkeWvueixoeeahOWIhuae
kOOAgeS8mOWMluaIlui9rOaNouetieWKn+iDve+8iQ0KPiA+Pg0KPiA+PiAr5p2l5YiG5p6Q44CB
5L+u5pS55ZKM5re75Yqg5pu05aSa55qE5Luj56CB44CCDQo+ID4+ICsNCj4gPj4gK+WGheaguOea
hCBHQ0MNCj4gPj4g5o+S5Lu25Z+656GA6K6+5pa95pSv5oyB5p6E5bu65qCR5aSW5qih5Z2X44CB
5Lqk5Y+J57yW6K+R5ZKM5Zyo5Y2V54us55qE55uu5b2V5Lit5p6E5bu644CC5o+S5Lu25rqQ5paH
5Lu25b+F6aG755SxDQo+ID4+DQo+ID4+ICtDKysg57yW6K+R5Zmo57yW6K+R44CCDQo+ID4+ICsN
Cj4gPj4gK+ebruWJjSBHQ0Mg5o+S5Lu25Z+656GA6K6+5pa95Y+q5pSv5oyB5LiA5Lqb5p625p6E
44CC5pCc57SiICJzZWxlY3QgSEFWRV9HQ0NfUExVR0lOUyINCj4gPj4g5p2l5p+l5om+5pSv5oyB
DQo+ID4+ICtHQ0Mg5o+S5Lu255qE5p625p6E44CCDQo+ID4+ICsNCj4gPj4gK+i/meS4quWfuueh
gOiuvuaWveaYr+S7jiBncnNlY3VyaXR5IFs2XV8gIOWSjCBQYVggWzddXyDnp7vmpI3ov4fmnaXn
moTjgIINCj4gPj4gKw0KPiA+PiArLS0NCj4gPj4gKw0KPiA+PiArLi4gWzFdIGh0dHBzOi8vZ2Nj
LmdudS5vcmcvb25saW5lZG9jcy9nY2NpbnQvUGx1Z2lucy5odG1sDQo+ID4+ICsuLiBbMl0gaHR0
cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2NzL2djY2ludC9QbHVnaW4tQVBJLmh0bWwjUGx1Z2lu
LUFQSQ0KPiA+PiArLi4gWzNdIGh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5lZG9jcy9nY2NpbnQv
R0lNUExFLmh0bWwNCj4gPj4gKy4uIFs0XSBodHRwczovL2djYy5nbnUub3JnL29ubGluZWRvY3Mv
Z2NjaW50L0lQQS5odG1sDQo+ID4+ICsuLiBbNV0gaHR0cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVk
b2NzL2djY2ludC9SVEwuaHRtbA0KPiA+PiArLi4gWzZdIGh0dHBzOi8vZ3JzZWN1cml0eS5uZXQv
DQo+ID4+ICsuLiBbN10gaHR0cHM6Ly9wYXguZ3JzZWN1cml0eS5uZXQvDQo+ID4+ICsNCj4gPj4g
Kw0KPiA+DQo+ID4+ICvnm67nmoQNCj4gPj4gKz09PT09PT0NCj4gPg0KPiA+IEkgd2lsbCBjb250
aW51ZSByZXZpZXdpbmcgbGF0ZXIgb3IgdG9tb3Jyb3cuDQo+ID4NCj4gPg0KPiA+IFRoYW5rLA0K
PiA+IFlhbnRlbmcNCj4gPj4gKw0KPiA+PiArR0NDIOaPkuS7tueahOiuvuiuoeebrueahOaYr+aP
kOS+m+S4gOS4quWcuuaJgO+8jOeUqOS6juivlemqjCBHQ0Mg5oiWIENsYW5nDQo+ID4+IOS4iua4
uOayoeacieeahOa9nOWcqOe8luivkeWZqOWKn+iDveOAgg0KPiBIb3cgYWJvdXQ6DQo+IEdDQyDm
j5Lku7bnmoTorr7orqHnm67nmoTmmK/mj5DkvpvkuIDkuKrnlKjkuo7or5XpqowgR0NDIOaIliBD
bGFuZw0KPiDkuIrmuLjmsqHmnInnmoTmvZzlnKjnvJbor5Hlmajlip/og73nmoTlnLrmiYDjgIIN
Cj4gPj4NCj4gPj4gK+S4gOaXpuWug+S7rOeahOWunueUqOaAp+W+l+WIsOmqjOivge+8jOebruag
h+WwseaYr+Wwhui/meS6m+WKn+iDvea3u+WKoOWIsCBHQ0PvvIjlkowNCj4gPj4gQ2xhbmfvvInn
moTkuIrmuLjvvIznhLblkI7lnKgNCj4gPj4gK+aJgOacieaUr+aMgeeahCBHQ0Mg54mI5pys6YO9
5pSv5oyB6L+Z5Lqb5Yqf6IO95ZCO77yM5YaN5bCG5a6D5Lus5LuO5YaF5qC45Lit56e76Zmk44CC
DQo+IOebruagh+aYryDov5vkuIrmuLjlkI4g5oqKIOWKn+iDvSDnp7vpmaTjgIINCj4gQ2FuIHdl
IHJlLXBvbGlzaCBpdCBoZXJlPw0KDQrkuIDml6blroPku6znmoTlrp7nlKjmgKflvpfliLDpqozo
r4HvvIzov5nkupvlip/og73lsIbooqvmt7vliqDliLAgR0ND77yI5ZKMIENsYW5n77yJ55qE5LiK
5ri444CCDQrpmo/lkI7vvIzlnKjmiYDmnInmlK/mjIHnmoQgR0NDIOeJiOacrOmDveaUr+aMgei/
meS6m+WKn+iDveWQju+8jOWug+S7rOS8muiiq+S7juWGheaguOS4reenu+mZpOOAgg0KSG93IGFi
b3V0IHRoaXM/DQoNCj4gPj4gKw0KPiA+PiAr5YW35L2T5p2l6K+077yM5paw5o+S5Lu25bqU6K+l
5Y+q5a6e546w5LiK5ri457yW6K+R5Zmo77yIR0NDIOWSjCBDbGFuZ++8ieS4jeaUr+aMgeeahOWK
n+iDveOAgg0KPiA+PiArDQo+ID4+ICvlvZMgQ2xhbmcg5Lit5a2Y5ZyoIEdDQyDkuK3kuI3lrZjl
nKjnmoTmn5Dpobnlip/og73ml7bvvIzlupTliqrlipvlsIbor6Xlip/og73kuIrkvKDliLDkuIrm
uLgNCj4gPj4gR0ND77yI6ICM5LiN5LuF5LuFDQo+IOW6lOWKquWKm+WwhuivpeWKn+iDveWBmuWI
sCBHQ0PkuIrmuLgNCj4gPj4gK+aYr+S9nOS4uuWGheaguOS4k+eUqOeahCBHQ0Mg5o+S5Lu277yJ
77yM5Lul5L2/5pW05Liq55Sf5oCB6YO96IO95LuO5Lit5Y+X55uK44CCDQo+ID4+ICsNCj4gPj4g
K+exu+S8vOeahO+8jOWmguaenCBHQ0Mg5o+S5Lu25o+Q5L6b55qE5Yqf6IO95ZyoIENsYW5nIOS4
rSAqKuS4jSoqDQo+ID4+IOWtmOWcqO+8jOS9huivpeWKn+iDveiiq+ivgeaYjuaYr+acieeUqOea
hO+8jOS5n+W6lA0KPg0KPiA+PiAr5Yqq5Yqb5bCG6K+l5Yqf6IO95LiK5Lyg5YiwIEdDQ++8iOWS
jCBDbGFuZ++8ieOAgg0KPg0KPiA+PiArDQo+ID4+ICvlnKjkuIrmuLggR0NDIOaPkOS+m+S6huaf
kOmhueWKn+iDveWQju+8jOivpeaPkuS7tuWwhuaXoOazleWcqOebuOW6lOeahCBHQ0MNCj4gPj4g
54mI5pys77yI5Lul5Y+K5pu06auY54mI5pys77yJ5LiL57yW6K+R44CCDQo+ID4+ICvkuIDml6bm
iYDmnInlhoXmoLjmlK/mjIHnmoQgR0NDIOeJiOacrOmDveaPkOS+m+S6huivpeWKn+iDve+8jOiv
peaPkuS7tuWwhuS7juWGheaguOS4reenu+mZpOOAgg0KPiA+PiArDQo+ID4+ICsNCj4gPj4gK+aW
h+S7tg0KPiA+PiArPT09PT0NCj4gPj4gKw0KPiA+PiArKiokKHNyYykvc2NyaXB0cy9nY2MtcGx1
Z2lucyoqDQo+ID4+ICsNCj4gPj4gKyAgICDov5nmmK8gR0NDIOaPkuS7tueahOebruW9leOAgg0K
PiA+PiArDQo+ID4+ICsqKiQoc3JjKS9zY3JpcHRzL2djYy1wbHVnaW5zL2djYy1jb21tb24uaCoq
DQo+ID4+ICsNCj4gPj4gKyAgICDov5nmmK8gR0NDIOaPkuS7tueahOWFvOWuueaAp+WktOaWh+S7
tuOAgg0KPiA+PiArICAgIOW6lOWni+e7iOWMheWQq+Wug++8jOiAjOS4jeaYr+WNleeLrOeahCBH
Q0Mg5aS05paH5Lu244CCDQo+ID4+ICsNCj4gPj4gKyoqJChzcmMpL3NjcmlwdHMvZ2NjLXBsdWdp
bnMvZ2NjLWdlbmVyYXRlLWdpbXBsZS1wYXNzLmgsDQo+ID4+ICskKHNyYykvc2NyaXB0cy9nY2Mt
cGx1Z2lucy9nY2MtZ2VuZXJhdGUtaXBhLXBhc3MuaCwNCj4gPj4gKyQoc3JjKS9zY3JpcHRzL2dj
Yy1wbHVnaW5zL2djYy1nZW5lcmF0ZS1zaW1wbGVfaXBhLXBhc3MuaCwNCj4gPj4gKyQoc3JjKS9z
Y3JpcHRzL2djYy1wbHVnaW5zL2djYy1nZW5lcmF0ZS1ydGwtcGFzcy5oKioNCj4gPj4gKw0KPiA+
PiArICAgIOi/meS6m+WktOaWh+S7tuWPr+S7peiHquWKqOeUn+aIkCBHSU1QTEXjgIFTSU1QTEVf
SVBB44CBSVBBIOWSjCBSVEwgcGFzc2VzDQo+ID4+IOeahOazqOWGjOe7k+aehOOAgg0KPiA+PiAr
ICAgIOS4juaJi+WKqOWIm+W7uue7k+aehOebuOavlO+8jOWug+S7rOabtOWPl+asoui/juOAgg0K
PiA+PiArDQo+ID4+ICsNCj4gPj4gK+eUqOazlQ0KPiA+PiArPT09PT0NCj4gPj4gKw0KPiA+PiAr
5L2g5b+F6aG75Li65L2g55qEIEdDQyDniYjmnKzlronoo4UgR0NDIOaPkuS7tuWktOaWh+S7tu+8
jOS7pSBVYnVudHUg5LiK55qEIGdjYy0xMCDkuLrkvos6Og0KPiA+PiArDQo+ID4+ICsgICAgYXB0
LWdldCBpbnN0YWxsIGdjYy0xMC1wbHVnaW4tZGV2DQo+ID4+ICsNCj4gPj4gK+aIluiAheWcqCBG
ZWRvcmEg5LiKOjoNCj4gPj4gKw0KPiA+PiArICAgIGRuZiBpbnN0YWxsIGdjYy1wbHVnaW4tZGV2
ZWwgbGlibXBjLWRldmVsDQo+ID4+ICsNCj4gPj4gK+aIluiAheWcqCBGZWRvcmEg5LiK5L2/55So
5YyF5ZCr5o+S5Lu255qE5Lqk5Y+J57yW6K+R5Zmo5pe2OjoNCj4gPj4gKw0KPiA+PiArICAgIGRu
ZiBpbnN0YWxsIGxpYm1wYy1kZXZlbA0KPiA+PiArDQo+ID4+ICvlnKjlhoXmoLjphY3nva7kuK3l
kK/nlKggR0NDIOaPkuS7tuWfuuehgOiuvuaWveS4juS4gOS6m+S9oOaDs+S9v+eUqOeahOaPkuS7
tjo6DQo+ID4+ICsNCj4gPj4gKyAgICBDT05GSUdfR0NDX1BMVUdJTlM9eQ0KPiA+PiArICAgIENP
TkZJR19HQ0NfUExVR0lOX0xBVEVOVF9FTlRST1BZPXkNCj4gPj4gKyAgICAuLi4NCj4gPj4gKw0K
PiA+PiAr6L+Q6KGMIGdjY++8iOacrOWcsOaIluS6pOWPiee8luivkeWZqO+8ie+8jOehruS/neiD
veWkn+ajgOa1i+WIsOaPkuS7tuWktOaWh+S7tjo6DQo+ID4+ICsNCj4gPj4gKyAgICBnY2MgLXBy
aW50LWZpbGUtbmFtZT1wbHVnaW4NCj4gPj4gKyAgICBDUk9TU19DT01QSUxFPWFybS1saW51eC1n
bnUtICR7Q1JPU1NfQ09NUElMRX1nY2MNCj4gPj4gLXByaW50LWZpbGUtbmFtZT1wbHVnaW4NCj4g
Pj4gKw0KPiA+PiArInBsdWdpbiIg6L+Z5Liq6K+N5oSP5ZGz552A5a6D5Lus5rKh5pyJ6KKr5qOA
5rWL5YiwOjoNCj4gPj4gKw0KPiA+PiArICAgIHBsdWdpbg0KPiA+PiArDQo+ID4+ICvlrozmlbTn
moTot6/lvoTliJnooajnpLrmj5Lku7blt7Lnu4/ooqvmo4DmtYvliLA6Og0KPiA+PiArDQo+ID4+
ICsgICAgICAgL3Vzci9saWIvZ2NjL3g4Nl82NC1yZWRoYXQtbGludXgvMTIvcGx1Z2luDQo+ID4+
ICsNCj4gPj4gK+e8luivkeWMheaLrOaPkuS7tuWcqOWGheeahOacgOWwj+W3peWFt+mbhjo6DQo+
ID4+ICsNCj4gPj4gKyAgICBtYWtlIHNjcmlwdHMNCj4gPj4gKw0KPiA+PiAr5oiW6ICF55u05o6l
5Zyo5YaF5qC45Lit6L+Q6KGMIG1ha2XvvIzkvb/nlKjlvqrnjq/lpI3mnYLmgKcgR0NDIOaPkuS7
tue8luivkeaVtOS4quWGheaguOOAgg0KPiA+PiArDQo+ID4+ICsNCj4gPj4gKzQuIOWmguS9lea3
u+WKoOaWsOeahCBHQ0Mg5o+S5Lu2DQo+ID4+ICs9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NCj4gPj4gKw0KPiA+PiArR0NDIOaPkuS7tuS9jeS6jiBzY3JpcHRzL2djYy1wbHVnaW5zL+OA
guS9oOmcgOimgeWwhuaPkuS7tua6kOaWh+S7tuaUvuWcqA0KPiA+PiBzY3JpcHRzL2djYy1wbHVn
aW5zLyDnm67lvZXkuIvjgIINCj4gPj4gK+WtkOebruW9leWIm+W7uuW5tuS4jeaUr+aMge+8jOS9
oOW/hemhu+a3u+WKoOWcqA0KPiA+PiBzY3JpcHRzL2djYy1wbHVnaW5zL01ha2VmaWxl44CBc2Ny
aXB0cy9NYWtlZmlsZS5nY2MtcGx1Z2lucw0KPiA+PiAr5ZKM55u45YWz55qEIEtjb25maWcg5paH
5Lu25Lit44CCDQo+ID4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96
aF9DTi9rYnVpbGQvaW5kZXgucnN0DQo+ID4+IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMv
emhfQ04va2J1aWxkL2luZGV4LnJzdA0KPiA+PiBpbmRleCBkOTA2YTRlODhkMGYuLmI1MTY1NWQ5
ODFmNiAxMDA2NDQNCj4gPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04v
a2J1aWxkL2luZGV4LnJzdA0KPiA+PiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96
aF9DTi9rYnVpbGQvaW5kZXgucnN0DQo+ID4+IEBAIC0xMyw2ICsxMyw3IEBADQo+ID4+ICAgICAg
IDptYXhkZXB0aDogMQ0KPiA+PiAgICAgICAgIGhlYWRlcnNfaW5zdGFsbA0KPiA+PiArICAgIGdj
Yy1wbHVnaW5zDQo+ID4+ICAgICBUT0RPOg0KPiA+PiAgIEBAIC0yNCw3ICsyNSw2IEBAIFRPRE86
DQo+ID4+ICAgLSBtb2R1bGVzDQo+ID4+ICAgLSBpc3N1ZXMNCj4gPj4gICAtIHJlcHJvZHVjaWJs
ZS1idWlsZHMNCj4gPj4gLS0gZ2NjLXBsdWdpbnMNCj4gPj4gICAtIGxsdm0NCj4gPj4gICAgIC4u
IG9ubHk6OiAgc3VicHJvamVjdCBhbmQgaHRtbA0KPg0KPiBUaGFua3MsDQo+IFlhbnRlbmcNCj4g
Pg0KPiA+DQo+DQo+DQo=

