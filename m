Return-Path: <linux-kernel+bounces-516947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810A1A37A10
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C0397A2DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95F014D444;
	Mon, 17 Feb 2025 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGjKqwMf"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5014A8B;
	Mon, 17 Feb 2025 03:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739762718; cv=none; b=fjoLA53bSLMC69lR5rXCuQlxzr1g6xSPsqQP5NH/C0NSJ2Df8uwqKt2WYXAgcbb/ExPKJKJMn/LMjaiqii8inrPVbPVmsmQyI8TFT6iyfDGX/6BnJJDe8BoSUPv0SVV4W9/AboGYzj8UvQ3QDLStBXRfBixjx1YvIXhNep7PrjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739762718; c=relaxed/simple;
	bh=l1tXD7vNWS9uX1QKovXf19BYGiw2wzXMuW1SWoDPgQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afreqWryVZfzLzV7Pw8xdx91srrsvPpXGidCNyLh3ISju3/+mQFyobEgu/gkacL6Sf/TeGACynVlGMIPbI/Qlf+8u4y9r28VZ+NRYrkSUs483XScwH7LZPvDG55LD1AeohkNWtULis9SeLaG0adJtW8IfAVp7eGBUhvyf+3iWRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGjKqwMf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaec61d0f65so813471766b.1;
        Sun, 16 Feb 2025 19:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739762713; x=1740367513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1tXD7vNWS9uX1QKovXf19BYGiw2wzXMuW1SWoDPgQw=;
        b=KGjKqwMfyA6niYBRGfg/5Rjsj4nOVUCNFGHxueoeA+CTyYLOhVnkGSqxXYzPHcSIEx
         WT0334rarJ5y8Rfp7s63BWAJSmV7z8KctATr+4UQdUVHJZtPTYwGYGQw57HgXcwATNVm
         q3HriLohz58cku9XiY3wMoawgSz0w5svxwwgnIWns+Jh/hVmzr3Hcr49rq8Ie95mIlJW
         LiwQtvNCd2+u44Uss8z1RFXVMP6krb/YVXPGrbvp/gIEhSbdA90VNzFAsg73q5NAmn9E
         zkBUWisS5vFOXi/Nr1TuVE6QM3mhe0wqPPNbDT3SIhE2DgolStfy+1hPsMFja5dXuYKW
         tAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739762713; x=1740367513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1tXD7vNWS9uX1QKovXf19BYGiw2wzXMuW1SWoDPgQw=;
        b=ro03YwFKUpeyxWrlWUoObaSjETHOH4k3yg2eIVJTLSQ3GOZ3Y5ccJi91YuCd1iRAaJ
         dEmLp0obT5emBCjp7vNeI+z1vSjAwl8Fxh5zUgctSxn/SbykbDUuNlM15Z0wryasr/es
         1QRi6RFD78MJGqvhGgR8jPUfq9NpmjjFoy4WOyj5ujC5fbRcSksgxYFEjLUldXARKxic
         ENsfrir+IS3qXGEJ2IHRBIjqZoK8gYaPyPcwrc6RxUNNrzbRZs/Zv0E6orglrd8OYY7+
         fMcYrL7kDl33vjEVCR8j0K/DEiObTd9Qr/L6hD4Lf5f446N5Hm0UllvtBI4h8JZpsFm+
         NN0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3f6wCsmg3QafzxUl30e3KcmRLEsaMBMrhVaVnOXYdjB8I4U2eemGRogrhzKaiN2Ba3ImyUI34joAWYglI@vger.kernel.org, AJvYcCW8OqZKbHZeJT52Y7DcKSeX59T/n0of00/YMINmeklKsczvXB7Rmmu+azfkjNaGxKOZhdt+ndaGyi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjCLCXUGfBtql8VQIxhzjroXMcL3VKMkmbrUA5hVnJefz4yeC1
	dk4YHKRZ35mCPxvt6U4KHOzNj2gusG2C3dcGDO62dzuhYVHEce8I6ArgFWibIwfI3GrtATtOFNV
	tNFUyOn95NWP7Bdn6hsciN8jn4Uk=
X-Gm-Gg: ASbGncsLQrGMVy/7Z6qdIaFLDBf3TwnkApeL8ZfP41CS1euZv10j2R3TG91l2HNYASh
	e6BJzAkkXN+wGrSSl79JF3hVWp/mKSGLrR6GsXjiDIW0Dhj1j6OCB3mp8BJgvR0bmx2nTRDb5
X-Google-Smtp-Source: AGHT+IH0Feh0NxzNkcp3GZidZh65eFmnFzqxzBksjONnrnw+P96DYZ9lJAQo+pAsgHgdpD7G5zkSCjsySOCAoXajslk=
X-Received: by 2002:a17:907:7716:b0:ab7:c152:a3ca with SMTP id
 a640c23a62f3a-abb70c366e5mr690460166b.6.1739762713423; Sun, 16 Feb 2025
 19:25:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213054222.21776-1-alexs@kernel.org> <20250213054222.21776-2-alexs@kernel.org>
 <5d35c3f6-a52f-4e63-a972-50ee2898947e@linux.dev> <CAD-N9QXhmNBUFPfo11-h0H0Du_JFNX_Qxcs8aoesW8=ABgneaw@mail.gmail.com>
 <ae9f3fe4-65e3-4e37-a480-70d7ceea2ec5@linux.dev>
In-Reply-To: <ae9f3fe4-65e3-4e37-a480-70d7ceea2ec5@linux.dev>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Mon, 17 Feb 2025 11:24:47 +0800
X-Gm-Features: AWEUYZldYklRJ999McSdFeA6cd57vOvXGfyd-riCFunhX9G6wnaFB7BB9d9d6Og
Message-ID: <CAD-N9QWQuo0Dd+FwS_8Kr-XtsrpFcGzbY-8V_iKm-jAwDTWhvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs/zh_CN: add few request for Chinese translation
To: Yanteng Si <si.yanteng@linux.dev>
Cc: alexs@kernel.org, Yanteng Si <siyanteng@loongson.cn>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gTW9uLCBGZWIgMTcsIDIwMjUgYXQgMTA6MDLigK9BTSBZYW50ZW5nIFNpIDxzaS55YW50ZW5n
QGxpbnV4LmRldj4gd3JvdGU6DQo+DQo+DQo+IOWcqCAyLzE0LzI1IDExOjI0IEFNLCBEb25nbGlh
bmcgTXUg5YaZ6YGTOg0KPiA+IE9uIFRodSwgRmViIDEzLCAyMDI1IGF0IDY6MjTigK9QTSBZYW50
ZW5nIFNpIDxzaS55YW50ZW5nQGxpbnV4LmRldj4gd3JvdGU6DQo+ID4+DQo+ID4+IOWcqCAyLzEz
LzI1IDE6NDIgUE0sIGFsZXhzQGtlcm5lbC5vcmcg5YaZ6YGTOg0KPiA+Pj4gRnJvbTogQWxleCBT
aGkgPGFsZXhzQGtlcm5lbC5vcmc+DQo+ID4+Pg0KPiA+Pj4gQSBnb29kIGNoZWNrZWQgc3VtbWl0
IGNvdWxkIHNhdmUgbXVjaCB0aW1lIGZvciBsaW51eC1kb2MgbWFpbnRhaW5lci4NCj4gPj4+DQo+
ID4+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFNoaSA8YWxleHNAa2VybmVsLm9yZz4NCj4gPj4+IENj
OiBZYW50ZW5nIFNpIDxzaXlhbnRlbmdAbG9vbmdzb24uY24+DQo+ID4+PiBDYzogSm9uYXRoYW4g
Q29yYmV0IDxjb3JiZXRAbHduLm5ldD4NCj4gPj4+IENjOiBsaW51eC1kb2NAdmdlci5rZXJuZWwu
b3JnDQo+ID4+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+PiBSZXZpZXdl
ZC1ieTogWWFudGVuZyBTaSA8c2kueWFudGVuZ0BsaW51eC5kZXY+DQo+ID4+DQo+ID4+DQo+ID4+
DQo+ID4+PiAtLS0NCj4gPj4+ICAgIERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2lu
ZGV4LnJzdCB8IDggKysrKysrKy0NCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi90cmFuc2xhdGlvbnMvemhfQ04vaW5kZXgucnN0IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xh
dGlvbnMvemhfQ04vaW5kZXgucnN0DQo+ID4+PiBpbmRleCA3NTc0ZTE2NzMxODAuLmNjNTEyY2E1
NDE3MiAxMDA2NDQNCj4gPj4+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NO
L2luZGV4LnJzdA0KPiA+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04v
aW5kZXgucnN0DQo+ID4+PiBAQCAtMjYsNyArMjYsMTMgQEANCj4gPj4+ICAgIOmhuuS+v+ivtOS4
i++8jOS4reaWh+aWh+aho+S5n+mcgOimgemBteWuiOWGheaguOe8lueggemjjuagvO+8jOmjjuag
vOS4reS4reaWh+WSjOiLseaWh+eahOS4u+imgeS4jeWQjOWwseaYr+S4reaWhw0KPiA+Pj4gICAg
55qE5a2X56ym5qCH54K55Y2g55So5Lik5Liq6Iux5paH5a2X56ym5a695bqm77yM5omA5Lul77yM
5b2T6Iux5paH6KaB5rGC5LiN6KaB6LaF6L+H5q+P6KGMMTAw5Liq5a2X56ym5pe277yMDQo+ID4+
PiAgICDkuK3mloflsLHkuI3opoHotoXov4c1MOS4quWtl+espuOAguWPpuWklu+8jOS5n+imgeaz
qOaEjyctJ++8jCc9J+etieespuWPt+S4juebuOWFs+agh+mimOeahOWvuem9kOOAguWcqOWwhg0K
PiA+Pj4gLeihpeS4geaPkOS6pOWIsOekvuWMuuS5i+WJje+8jOS4gOWumuimgei/m+ihjOW/heim
geeahCBgYGNoZWNrcGF0Y2gucGxgYCDmo4Dmn6XlkoznvJbor5HmtYvor5XjgIINCj4gPj4+ICvo
oaXkuIHmj5DkuqTliLDnpL7ljLrkuYvliY3vvIzkuIDlrpropoHov5vooYzlv4XopoHnmoQgYGBj
aGVja3BhdGNoLnBsYGAg5qOA5p+l5ZKM57yW6K+R5rWL6K+V77yM56Gu5L+dDQo+ID4+PiAr5Zyo
IGBgbWFrZSBodG1sZG9jcy9wZGZkb2NzYGAg5Lit5LiN5aKe5Yqg5paw55qE5ZGK6K2m77yM5pyA
5ZCO77yM5a6J6KOF5qOA5p+l5L2g55Sf5oiQ55qEDQo+ID4+PiAraHRtbC9wZGYg5paH5Lu277yM
56Gu6K6k5a6D5Lus55yL6LW35p2l5piv5q2j5bi455qE44CCDQo+ID4+PiArDQo+ID4+PiAr5o+Q
5Lqk5LmL5YmN6K+356Gu6K6k5L2g55qE6KGl5LiB5Y+v5Lul5q2j5bi45o+Q5Lqk5Yiw5Lit5paH
5paH5qGj57u05oqk5bqTOg0KPiA+Pj4gK2h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L2FsZXhzL2xpbnV4LmdpdC8NCj4gPj4+ICvlpoLmnpzkvaDnmoTooaXk
uIHkvp3otZbkuo7lhbbku5bkurrnmoTooaXkuIEsIOWPr+S7peS4juWFtuS7luS6uuWVhumHj+WQ
jueUseafkOS4gOS4quS6uuWQiOW5tuaPkOS6pOOAgg0KPiA+PiBJIHRoaW5rIHRoaXMgcmVxdWly
ZXMgYSBkZXRhaWxlZCB0dXRvcmlhbC4gT3RoZXJ3aXNlLCBpdA0KPiA+Pg0KPiA+PiB3aWxsIGlu
Y3JlYXNlIHRoZSBkaWZmaWN1bHR5IGZvciBiZWdpbm5lcnMgdG8gZ2V0IHN0YXJ0ZWQuDQo+ID4+
DQo+ID4+IEhvdyBhYm91dCByZW1vdmluZyBpdCBmb3Igbm93PyBJIGhhdmUgYSBwbGFuIHRvIHdy
aXRlDQo+ID4+DQo+ID4+IGEgdHJhbnNsYXRpb24gZ3VpZGVib29rLiBXaGF0J3MgeW91ciBvcGlu
aW9uPw0KPiA+IEdvb2QgaWRlYS4gSSBjYW4gaGVscCBjb250cmlidXRlLiBPdXIgVHJhbnNsYXRp
b24gVGVhbSBoYXMgYSBzaW1wbGUNCj4gPiBvbmUgdG8gZ3VpZGUgdGVhbSBtZW1iZXJzIGluIGtl
cm5lbCBkb2N1bWVudCB0cmFuc2xhdGlvbi4NCj4NCj4gR29vZCBqb2JzLCBUaGlzIGlzIHZlcnkg
aGVscGZ1bCB0byBtZS4NCj4NCj4NCj4gSW4gZmFjdCwgSSBhbHJlYWR5IGhhZCBhIGRyYWZ0IGJl
Zm9yZSBOZXcgWWVhcidzIERheS4NCj4NCj4gVGhlIHJlYXNvbiBJIGRpZG4ndCBzdWJtaXQgaXQg
d2FzIGJlY2F1c2UsIGluIHByYWN0aWNlLA0KPg0KPiBJIGZvdW5kIG1hbnkgZGVmaWNpZW5jaWVz
LiBJJ2xsIHRyeSB0byBzdWJtaXQgaXQgbGF0ZXIgdGhpcyB3ZWVrLg0KDQpTdXJlLiBJIHdpbGwg
Z2l2ZSBteSBjb21tZW50cyBvbiB5b3VyIHBhdGNoLg0KDQpEb25nbGlhbmcgTXUNCj4NCj4NCj4g
VGhhbmtzLA0KPg0KPiBZYW50ZW5nDQo+DQo=

