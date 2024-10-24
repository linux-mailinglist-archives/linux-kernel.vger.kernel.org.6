Return-Path: <linux-kernel+bounces-379111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38E49ADA20
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9844C2836C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3681F155A4D;
	Thu, 24 Oct 2024 02:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHKzoWPQ"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04687482EB;
	Thu, 24 Oct 2024 02:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729738303; cv=none; b=YzohpWIVmNVi1UN64RWz53oM6VSQ6NvkBKr5Hhh1wUhu4QpQxRPYAmn5vnB5PZEBHV8nwySJWw+X5OqFZOAEQ6yE+J2hqvOrE39w7gFCoclwMWMVS4Ua4WfEE/A5xQwSJsKLIm6+E2waZQ3qyyWrH3aTTedmTMkeyBBfoSgV0X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729738303; c=relaxed/simple;
	bh=F6r4ekj9WEGBPC54DL3ej6ljaopkDZ+i9DqP6T3RCUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0k9C698cq7teuj73qXEiz9Vyqorcs+0DZdXkoHUqLuwoVCzNiR98+CTzzkoL2UtEN9F1L5qi+A7wTRVr5U6mO6Fd41ecgWt7jVQAWf0mhrjfzh+ByuJx1lvdGI76AtU/NNKQiiYKRRtvmp8oX7fELLACzk5ZnocChy6qE+DpkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHKzoWPQ; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-288661760d3so294663fac.3;
        Wed, 23 Oct 2024 19:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729738299; x=1730343099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6r4ekj9WEGBPC54DL3ej6ljaopkDZ+i9DqP6T3RCUM=;
        b=FHKzoWPQEie81ScFDdp3pEzx2EHBlRzXrUpkMaULDfzLUzCF4k+R+3DGsuNLUDTB2g
         NYqMDLfpUNipomdtb01RsrFTjv3AX72ng5mfgZbLKr+8Udq1dBMNpju32swkFcmxyCW/
         EESkZQDEplz8g/TqcQkVYVRNjoiN3lKlTYCv21ICdxGy5+WlmU1zAfMLb8B47/+JepDn
         A3ezreeHldG2Xe/EBLIYGbp6t0cAMT/rLfzJf1SbRxbSMVz7FGvoZnbtELHsD2KCQAkn
         U2BOg5oiCF62XyUZQmbZry8enJZ0PTM2f1o8FfXMFkFJ8yj39WLiQWsXPjCektBSVYqJ
         dm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729738299; x=1730343099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6r4ekj9WEGBPC54DL3ej6ljaopkDZ+i9DqP6T3RCUM=;
        b=vl+BBqFfhTOjF0ouMq32nGekrVt/S62BC5dhYhw65iNcVUNKLW8udtcbjYp+MJHZ/F
         5nu0LU8cMf9Z+i50AbUAqG1KsOLMdLMvSNTDrji7a9Pcc+Ne1l5hHd2rloL6qcuh4qdU
         3+jAk3DaBk/RIcj94X811PJ2ylxOKWRVesxozNW0rXKwgfVL/Pm7Pk5H7nwMnSfZPV2k
         0WOjjKHAe6Xe2/SSbztO9+G1MHdkgJvFPvFqCgazFlwmc3Tz8uKnOIPfzoTavn84mdjE
         5mvH9MJKFk+QOmv3uQtzfSDhZWXAp/NEZLj8AN7OHdMHcEgzqHskL8HrGBUGIqIMVizB
         TO/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVI2tzQFA9KKuRCFrPEy8w5rtwiIR05z+vQm84Tz9ZzVxJ+Fff0vAsKMEIz3ffP2MizyVDIzEYwOMJYkQEFjPY=@vger.kernel.org, AJvYcCVcHEJOqx33kpkmX744+P9DoIswo0ldWItXbKXQ+CmnqwcsG6W6iR8U2fsswxY9UF9wQHIsABIvS0c=@vger.kernel.org, AJvYcCWlR1ZmpfZCMz6MGrJ/6/1c58/KqHwY99sixtMIZIQiskp702vZ2cI57lz/rZMmRi+gTLgnRroMJuFDOs7s@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6blX23WeiO4sYKMM3Am2OY5G2hinOHu7u+Cio1UoA2oOlGpnf
	s5gjeFbNzysNFLYPVOdq3PdHOC3R2WDiolDzLtlicwYAEcHb/+icZB1FUazFh51ZbJr1HuRzSAA
	d689Wpqqf4V1pM37vC7Zee4F5PNQ=
X-Google-Smtp-Source: AGHT+IG7M/k/D5ljnu9uNo3Z5NPF/D+iW4t4TGMui4Xyfw8PSUJ3REPCzWK7g1ATztJDES/iLOCL0JTV8FGdl3ffFDM=
X-Received: by 2002:a05:6870:911f:b0:288:57fa:9624 with SMTP id
 586e51a60fabf-28ced283d86mr373787fac.18.1729738298942; Wed, 23 Oct 2024
 19:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023062750.849951-1-dzm91@hust.edu.cn> <46e54088-ad96-4387-8a39-2e4686c842bd@gmail.com>
 <345e8f10-fe1a-4736-9468-7c92ac55d62e@hust.edu.cn> <e0c34a1b-6801-4ae3-b04f-56dbce5c76d8@gmail.com>
In-Reply-To: <e0c34a1b-6801-4ae3-b04f-56dbce5c76d8@gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Thu, 24 Oct 2024 10:51:11 +0800
Message-ID: <CAD-N9QV-EBbSkrZ5TSUt7j3MhsAHMozY59gFOEnSQ1HB9cUsZg@mail.gmail.com>
Subject: Re: [PATCH v3] docs/zh_CN: update the translation of process/programming-language.rst
To: Alex Shi <seakeel@gmail.com>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBPY3QgMjQsIDIwMjQgYXQgMTA6NDHigK9BTSBBbGV4IFNoaSA8c2Vha2VlbEBnbWFp
bC5jb20+IHdyb3RlOg0KPg0KPg0KPg0KPiBPbiAxMC8yNC8yNCAxMDozMCwgRG9uZ2xpYW5nIE11
IHdyb3RlOg0KPiA+DQo+ID4gT24gMjAyNC8xMC8yNCAxMDoyMSwgQWxleCBTaGkgd3JvdGU6DQo+
ID4+DQo+ID4+IE9uIDEwLzIzLzI0IDE0OjI3LCBEb25nbGlhbmcgTXUgd3JvdGU6DQo+ID4+PiBV
cGRhdGUgdG8gY29tbWl0IDBiMDIwNzZmOTk1MyAoImRvY3M6IHByb2dyYW1taW5nLWxhbmd1YWdl
OiBhZGQgUnVzdA0KPiA+Pj4gcHJvZ3JhbW1pbmcgbGFuZ3VhZ2Ugc2VjdGlvbiIpDQo+ID4+Pg0K
PiA+Pj4gc2NyaXB0cy9jaGVja3RyYW5zdXBkYXRlLnB5IHJlcG9ydHM6DQo+ID4+Pg0KPiA+Pj4g
RG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcHJvY2Vzcy9wcm9ncmFtbWluZy1sYW5n
dWFnZS5yc3QNCj4gPj4+IGNvbW1pdCAwYjAyMDc2Zjk5NTMgKCJkb2NzOiBwcm9ncmFtbWluZy1s
YW5ndWFnZTogYWRkIFJ1c3QgcHJvZ3JhbW1pbmcNCj4gPj4+IGxhbmd1YWdlIHNlY3Rpb24iKQ0K
PiA+Pj4gY29tbWl0IDM4NDg0YTFkMGM1MCAoImRvY3M6IHByb2dyYW1taW5nLWxhbmd1YWdlOiBy
ZW1vdmUgbWVudGlvbiBvZiB0aGUNCj4gPj4+IEludGVsIGNvbXBpbGVyIikNCj4gPj4+IDIgY29t
bWl0cyBuZWVkcyByZXNvbHZpbmcgaW4gdG90YWwNCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5
OiBEb25nbGlhbmcgTXUgPGR6bTkxQGh1c3QuZWR1LmNuPg0KPiA+Pj4gLS0tDQo+ID4+PiB2Mi0+
djM6IGZpeCB3YXJuaW5ncyBpbiB0aGUgbWFrZSBodG1sZG9jcw0KPiA+Pj4gdjEtPnYyOiByZXZp
c2UgdGhlIHNjcmlwdCBuYW1lDQo+ID4+PiAgIC4uLi96aF9DTi9wcm9jZXNzL3Byb2dyYW1taW5n
LWxhbmd1YWdlLnJzdCAgICB8IDc4ICsrKysrKystLS0tLS0tLS0tLS0NCj4gPj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDQ4IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9wcm9jZXNzL3By
b2dyYW1taW5nLWxhbmd1YWdlLnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NO
L3Byb2Nlc3MvcHJvZ3JhbW1pbmctbGFuZ3VhZ2UucnN0DQo+ID4+PiBpbmRleCBmYWJkYzMzOGRi
ZmIuLjk1YWE0ODI5ZDc4ZiAxMDA2NDQNCj4gPj4+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNs
YXRpb25zL3poX0NOL3Byb2Nlc3MvcHJvZ3JhbW1pbmctbGFuZ3VhZ2UucnN0DQo+ID4+PiArKysg
Yi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9wcm9jZXNzL3Byb2dyYW1taW5nLWxh
bmd1YWdlLnJzdA0KPiA+Pj4gQEAgLTMsMjUgKzMsMjIgQEANCj4gPj4+ICAgOk9yaWdpbmFsOiA6
cmVmOmBEb2N1bWVudGF0aW9uL3Byb2Nlc3MvcHJvZ3JhbW1pbmctbGFuZ3VhZ2UucnN0IDxwcm9n
cmFtbWluZ19sYW5ndWFnZT5gDQo+ID4+PiAgIDpUcmFuc2xhdG9yOiBBbGV4IFNoaSA8YWxleC5z
aGlAbGludXguYWxpYmFiYS5jb20+DQo+ID4+PiAgIC0uLiBfY25fcHJvZ3JhbW1pbmdfbGFuZ3Vh
Z2U6DQo+ID4+PiAtDQo+ID4+PiAgIOeoi+W6j+iuvuiuoeivreiogA0KPiA+Pj4gICA9PT09PT09
PT09PT0NCj4gPj4+ICAgLeWGheaguOaYr+eUqEPor63oqIAgOnJlZjpgYy1sYW5ndWFnZSA8Y25f
Yy1sYW5ndWFnZT5gIOe8luWGmeeahOOAguabtOWHhuehruWcsOivtO+8jOWGheaguOmAmuW4uOaY
r+eUqCA6cmVmOmBnY2MgPGNuX2djYz5gDQo+ID4+PiAt5ZyoIGBgLXN0ZD1nbnUxMWBgIDpyZWY6
YGdjYy1jLWRpYWxlY3Qtb3B0aW9ucyA8Y25fZ2NjLWMtZGlhbGVjdC1vcHRpb25zPmAg5LiL57yW
6K+R55qE77yaSVNPIEMxMeeahCBHTlUg5pa56KiADQo+ID4+PiAtDQo+ID4+PiAt6L+Z56eN5pa5
6KiA5YyF5ZCr5a+56K+t6KiAIDpyZWY6YGdudS1leHRlbnNpb25zIDxjbl9nbnUtZXh0ZW5zaW9u
cz5gIOeahOiuuOWkmuaJqeWxle+8jOW9k+eEtu+8jOWug+S7rOiuuOWkmumDveWcqOWGheaguOS4
reS9v+eUqOOAgg0KPiA+Pj4gK+WGheaguOaYr+eUqCBDIOe8lueoi+ivreiogOe8luWGmeeahCBb
emhfY25fYy1sYW5ndWFnZV1f44CC5pu05YeG56Gu5Zyw6K+077yM5YaF5qC46YCa5bi45L2/55So
IGBgZ2NjYGAgW3poX2NuX2djY11fIOe8luivke+8jA0KPiA+Pj4gK+W5tuS4lOS9v+eUqCBgYC1z
dGQ9Z251MTFgYCBbemhfY25fZ2NjLWMtZGlhbGVjdC1vcHRpb25zXV/vvJrov5nmmK8gSVNPIEMx
MSDnmoQgR05VIOaWueiogOOAgg0KPiA+Pj4gK2BgY2xhbmdgYCBbemhfY25fY2xhbmddXyDkuZ/l
vpfliLDkuobmlK/mjIHvvIzor6bop4HmlofmoaPvvJoNCj4gPj4+ICs6cmVmOmDkvb/nlKggQ2xh
bmcvTExWTSDmnoTlu7ogTGludXggPGtidWlsZF9sbHZtPmDjgIINCj4gPj4+ICAgLeWvueS6juS4
gOS6m+S9k+ezu+e7k+aehO+8jOacieS4gOS6m+S9v+eUqCA6cmVmOmBjbGFuZyA8Y25fY2xhbmc+
YCDlkowgOnJlZjpgaWNjIDxjbl9pY2M+YCDnvJbor5HlhoXmoLgNCj4gPj4+IC3nmoTmlK/mjIHv
vIzlsL3nrqHlnKjnvJblhpnmraTmlofmoaPml7bov5jmsqHmnInlrozmiJDvvIzku43pnIDopoHn
rKzkuInmlrnooaXkuIHjgIINCj4gPj4+ICvov5nnp43mlrnoqIDljIXlkKvlr7kgQyDor63oqIDn
moTorrjlpJrmianlsZUgW3poX2NuX2dudS1leHRlbnNpb25zXV/vvIzlvZPnhLbvvIzlroPku6zo
rrjlpJrpg73lnKjlhoXmoLjkuK3kvb/nlKjjgIINCj4gPj4+ICAgICDlsZ7mgKcNCj4gPj4+ICAg
LS0tLQ0KPiA+Pj4gICAt5Zyo5pW05Liq5YaF5qC45Lit5L2/55So55qE5LiA5Liq5bi46KeB5omp
5bGV5piv5bGe5oCn77yIYXR0cmlidXRlc++8iSA6cmVmOmBnY2MtYXR0cmlidXRlLXN5bnRheCA8
Y25fZ2NjLWF0dHJpYnV0ZS1zeW50YXg+YA0KPiA+Pj4gK+WcqOaVtOS4quWGheaguOS4reS9v+eU
qOeahOS4gOS4quW4uOingeaJqeWxleaYr+WxnuaAp++8iGF0dHJpYnV0ZXPvvIkgW3poX2NuX2dj
Yy1hdHRyaWJ1dGUtc3ludGF4XV/jgIINCj4gPj4+ICAg5bGe5oCn5YWB6K645bCG5a6e546w5a6a
5LmJ55qE6K+t5LmJ5byV5YWl6K+t6KiA5a6e5L2T77yI5aaC5Y+Y6YeP44CB5Ye95pWw5oiW57G7
5Z6L77yJ77yM6ICM5peg6ZyA5a+56K+t6KiA6L+b6KGMDQo+ID4+PiAt6YeN5aSn55qE6K+t5rOV
5pu05pS577yI5L6L5aaC5re75Yqg5paw5YWz6ZSu5a2X77yJIDpyZWY6YG4yMDQ5IDxjbl9uMjA0
OT5gDQo+ID4+PiAr6YeN5aSn55qE6K+t5rOV5pu05pS577yI5L6L5aaC5re75Yqg5paw5YWz6ZSu
5a2X77yJIFt6aF9jbl9uMjA0OV1f44CCDQo+ID4+PiAgICAg5Zyo5p+Q5Lqb5oOF5Ya15LiL77yM
5bGe5oCn5piv5Y+v6YCJ55qE77yI5Y2z5LiN5pSv5oyB6L+Z5Lqb5bGe5oCn55qE57yW6K+R5Zmo
5LuN54S25bqU6K+l55Sf5oiQ5q2j56Gu55qE5Luj56CB77yMDQo+ID4+PiAgIOWNs+S9v+WFtumA
n+W6pui+g+aFouaIluaJp+ihjOeahOe8luivkeaXtuajgOafpS/or4rmlq3mrKHmlbDkuI3lpJ/v
vIkNCj4gPj4+IEBAIC0zMCw0MiArMjcsMjcgQEANCj4gPj4+ICAgYGBfX2F0dHJpYnV0ZV9fKChf
X3B1cmVfXykpYGAg77yJ77yM5Lul5qOA5rWL5Y+v5Lul5L2/55So5ZOq5Lqb5YWz6ZSu5a2X5ZKM
L+aIlue8qeefreS7o+eggSwg5YW35L2TDQo+ID4+PiAgIOivt+WPgumYhSBgYGluY2x1ZGUvbGlu
dXgvY29tcGlsZXJfYXR0cmlidXRlcy5oYGANCj4gPj4+ICAgLS4uIF9jbl9jLWxhbmd1YWdlOg0K
PiA+Pj4gLQ0KPiA+Pj4gLWMtbGFuZ3VhZ2UNCj4gPj4+IC0gICBodHRwOi8vd3d3Lm9wZW4tc3Rk
Lm9yZy9qdGMxL3NjMjIvd2cxNC93d3cvc3RhbmRhcmRzDQo+ID4+PiAtDQo+ID4+PiAtLi4gX2Nu
X2djYzoNCj4gPj4+IC0NCj4gPj4+IC1nY2MNCj4gPj4+IC0gICBodHRwczovL2djYy5nbnUub3Jn
DQo+ID4+PiAtDQo+ID4+PiAtLi4gX2NuX2NsYW5nOg0KPiA+Pj4gLQ0KPiA+Pj4gLWNsYW5nDQo+
ID4+PiAtICAgaHR0cHM6Ly9jbGFuZy5sbHZtLm9yZw0KPiA+Pj4gLQ0KPiA+Pj4gLS4uIF9jbl9p
Y2M6DQo+ID4+PiAtDQo+ID4+PiAtaWNjDQo+ID4+PiAtICAgaHR0cHM6Ly9zb2Z0d2FyZS5pbnRl
bC5jb20vZW4tdXMvYy1jb21waWxlcnMNCj4gPj4+IC0NCj4gPj4+IC0uLiBfY25fZ2NjLWMtZGlh
bGVjdC1vcHRpb25zOg0KPiA+Pj4gLQ0KPiA+Pj4gLWMtZGlhbGVjdC1vcHRpb25zDQo+ID4+PiAt
ICAgaHR0cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2NzL2djYy9DLURpYWxlY3QtT3B0aW9ucy5o
dG1sDQo+ID4+PiAtDQo+ID4+PiAtLi4gX2NuX2dudS1leHRlbnNpb25zOg0KPiA+Pj4gLQ0KPiA+
Pj4gLWdudS1leHRlbnNpb25zDQo+ID4+PiAtICAgaHR0cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVk
b2NzL2djYy9DLUV4dGVuc2lvbnMuaHRtbA0KPiA+Pj4gLQ0KPiA+Pj4gLS4uIF9jbl9nY2MtYXR0
cmlidXRlLXN5bnRheDoNCj4gPj4+IC0NCj4gPj4+IC1nY2MtYXR0cmlidXRlLXN5bnRheA0KPiA+
Pj4gLSAgIGh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5lZG9jcy9nY2MvQXR0cmlidXRlLVN5bnRh
eC5odG1sDQo+ID4+PiAtDQo+ID4+PiAtLi4gX2NuX24yMDQ5Og0KPiA+Pj4gK1J1c3QNCj4gPj4+
ICstLS0tDQo+ID4+PiAgIC1uMjA0OQ0KPiA+Pj4gLSAgIGh0dHA6Ly93d3cub3Blbi1zdGQub3Jn
L2p0YzEvc2MyMi93ZzE0L3d3dy9kb2NzL24yMDQ5LnBkZg0KPiA+Pj4gK+WGheaguOWvuSBSdXN0
IOe8lueoi+ivreiogCBbemhfY25fcnVzdC1sYW5ndWFnZV1fIOeahOaUr+aMgeaYr+WunumqjOaA
p+eahO+8jOW5tuS4lOWPr+S7pemAmui/h+mFjee9rumAiemhuQ0KPiA+Pj4gK2BgQ09ORklHX1JV
U1RgYCDmnaXlkK/nlKjjgIJSdXN0IOS7o+eggeS9v+eUqCBgYHJ1c3RjYGAgW3poX2NuX3J1c3Rj
XV8g57yW6K+R5Zmo5ZyoDQo+ID4+PiArYGAtLWVkaXRpb249MjAyMWBgIFt6aF9jbl9ydXN0LWVk
aXRpb25zXV8g6YCJ6aG55LiL6L+b6KGM57yW6K+R44CC54mI5pys77yIRWRpdGlvbnPvvInmmK/k
uIDnp40NCj4gPj4+ICvlnKjor63oqIDkuK3lvJXlhaXpnZ7lkI7lkJHlhbzlrrnnmoTlsI/lnovl
j5jmm7TnmoTmlrnlvI/jgIINCj4gPj4+ICsNCj4gPj4+ICvpmaTmraTkuYvlpJbvvIzlhoXmoLjk
uK3ov5jkvb/nlKjkuobkuIDkupvkuI3nqLPlrprnmoTnibnmgKcgW3poX2NuX3J1c3QtdW5zdGFi
bGUtZmVhdHVyZXNdX+OAgui/meS6m+S4jeeos+Wumg0KPiA+Pj4gK+eahOeJueaAp+WwhuadpeWP
r+iDveS8muWPkeeUn+WPmOWMlu+8jOWboOatpO+8jOS4gOS4qumHjeimgeeahOebruagh+aYr+i+
vuWIsOS7heS9v+eUqOeos+WumueJueaAp+eahOeoi+W6puOAgg0KPiA+Pj4gKw0KPiA+Pj4gK+WF
t+S9k+ivt+WPgumYhSBEb2N1bWVudGF0aW9uL3J1c3QvaW5kZXgucnN0DQo+ID4+PiArDQo+ID4+
PiArLi4gW3poX2NuX2MtbGFuZ3VhZ2VdIGh0dHA6Ly93d3cub3Blbi1zdGQub3JnL2p0YzEvc2My
Mi93ZzE0L3d3dy9zdGFuZGFyZHMNCj4gPj4+ICsuLiBbemhfY25fZ2NjXSBodHRwczovL2djYy5n
bnUub3JnDQo+ID4+PiArLi4gW3poX2NuX2NsYW5nXSBodHRwczovL2NsYW5nLmxsdm0ub3JnDQo+
ID4+PiArLi4gW3poX2NuX2djYy1jLWRpYWxlY3Qtb3B0aW9uc10gaHR0cHM6Ly9nY2MuZ251Lm9y
Zy9vbmxpbmVkb2NzL2djYy9DLURpYWxlY3QtT3B0aW9ucy5odG1sDQo+ID4+PiArLi4gW3poX2Nu
X2dudS1leHRlbnNpb25zXSBodHRwczovL2djYy5nbnUub3JnL29ubGluZWRvY3MvZ2NjL0MtRXh0
ZW5zaW9ucy5odG1sDQo+ID4+PiArLi4gW3poX2NuX2djYy1hdHRyaWJ1dGUtc3ludGF4XSBodHRw
czovL2djYy5nbnUub3JnL29ubGluZWRvY3MvZ2NjL0F0dHJpYnV0ZS1TeW50YXguaHRtbA0KPiA+
Pj4gKy4uIFt6aF9jbl9uMjA0OV0gaHR0cDovL3d3dy5vcGVuLXN0ZC5vcmcvanRjMS9zYzIyL3dn
MTQvd3d3L2RvY3MvbjIwNDkucGRmDQo+ID4+PiArLi4gW3poX2NuX3J1c3QtbGFuZ3VhZ2VdIGh0
dHBzOi8vd3d3LnJ1c3QtbGFuZy5vcmcNCj4gPj4+ICsuLiBbemhfY25fcnVzdGNdIGh0dHBzOi8v
ZG9jLnJ1c3QtbGFuZy5vcmcvcnVzdGMvDQo+ID4+PiArLi4gW3poX2NuX3J1c3QtZWRpdGlvbnNd
IGh0dHBzOi8vZG9jLnJ1c3QtbGFuZy5vcmcvZWRpdGlvbi1ndWlkZS9lZGl0aW9ucy8NCj4gPj4+
ICsuLiBbemhfY25fcnVzdC11bnN0YWJsZS1mZWF0dXJlc10gaHR0cHM6Ly9naXRodWIuY29tL1J1
c3QtZm9yLUxpbnV4L2xpbnV4L2lzc3Vlcy8yDQo+ID4+IEhpIERvbmdsaWFuZywNCj4gPj4NCj4g
Pj4gR29vZCBqb2IhIE1vc3Qgb2YgdHJhbnNsYXRpb24gYXJlIGdvb2QuDQo+ID4+IEp1c3QgdGhl
IGFib3ZlIGRvYyBzZWVtcyBzdGlsbCBFbmdsaXNoIHZlcnNpb24sIGdpdmUgdGhlbSBhIHpoX2Nu
IG5hbWUgbWF5IGNhdXNlIG1pc3VuZGVyc3RhbmQ/DQo+ID4NCj4gPiBPaCwgSSBzZWUuIEhvd2V2
ZXIsIHlvdSBjYW5ub3QgdXNlIGdjYyBvciBydXN0YyBzaW5jZSBpdCBhbHJlYWR5IGV4aXN0cyBp
biB0aGUgRW5nbGlzaCBkb2N1bWVudHMuIFdlIG5lZWQgYW5vdGhlciBuYW1lIHRvIG1ha2Ugc3Bo
aW54IGhhcHB5LiBUaGVyZWZvcmUsIHdoeSBkbyBub3Qgd2UgZGlyZWN0bHkgdXNlIHRoZSBmaW5h
bCB2ZXJzaW9uIG9mIG5hbWU/IDopDQo+ID4NCj4gVWgsIGlzIGl0IHBvc3NpYmxlIHRvIHVzZSBF
bmdsaXNoIHZlcnNpb24gJ2djYycgbGlua3MgaW4gdGhpcyBkb2M/IE90aGVyd2lzZSxpdCBtYWtl
IHNlbnNlIHRvby4NCj4NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2JhZTNjNTljLTM5
YTUtNGRhYS1iMzdlLWJiZjA3N2Q1NzY0M0BodXN0LmVkdS5jbi9ULyNtOGE5NDhiMjQ0MDE0MDQ4
MDZmNTNlMDg2ZjU3ODU2Y2YzYTU2YTQ5MA0KDQp2MiBwYXRjaCB0cmlnZ2VycyBhIHdhcm5pbmcg
ZHVlIHRvIGR1cGxpY2F0ZSBsaW5rcy4gU28gSSBjcmFmdGVkIGEgdjMNCnZlcnNpb24gdG8gdXNl
IHpoX2NuIHByZWZpeCBiZWZvcmUgZWFjaCBsaW5rDQoNCj4gVGhhbmtzDQo+DQo+ID4gQ29ycmVj
dCBtZSBpZiBJIG1ha2UgYW55IG1pc3VuZGVyc3RhbmRpbmcuDQo+ID4NCj4gPiBEb25nbGlhbmcg
TXUNCj4gPg0KPiA+PiAgIFRoYW5rcw0KPiA+DQo+DQo=

