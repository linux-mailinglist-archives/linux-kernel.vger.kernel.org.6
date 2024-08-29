Return-Path: <linux-kernel+bounces-307240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5936D964AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2D6283FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A551B4C45;
	Thu, 29 Aug 2024 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg2Xv45c"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578921B4C32
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946666; cv=none; b=cIeoCMSfUW526hAm3fc0eePdqZkE2khmd/CcuySwjDCofW5w5RaLmyGJkGuzVsYTS+MKT4mGKfEU1EsNUmr9i2MauepTWxPKBUhpgZK+6JXj8gW5RlAOn+ZfUZcjqJZ2VrkoJXL3QzVUzZlwScxLJA6ET1+mkZuk4IAPDoJGS5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946666; c=relaxed/simple;
	bh=zvAY9Ccukr+/HE07/0WO1dFQLdJcPTCRcUNXQG5PwWI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=j2KXGoZkWE2bJkN1Ijz9aGgmTv9FA9tmFfghlNjIvjh8cIdOqKlkhPpbjFDHoTRckDo8tYyPQQzuhrq8JtVi6RC93yrYtGPh1HFQO4ew6vI/+fJc29grmpeMeuuKhyvH+CEmgSu005lzu0M4EmlxWrL21BzokzOEFvEHqHariac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg2Xv45c; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f3e071eb64so10435481fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724946662; x=1725551462; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvAY9Ccukr+/HE07/0WO1dFQLdJcPTCRcUNXQG5PwWI=;
        b=lg2Xv45cWVe8uakVxY4ysTlNKLkoOu/HcTbZ5z44p1i5KHy6eO+9GddVb+we8GJPna
         zwNniljl9DKeX/12ZCYzvjoQ0fGbOWnEOFq94Bup2DwYbAng8g0gdx2EN5BO07dv53CT
         oj2I/gje/gnwB0VrC+Nvhi4rz0w+wCtbntNTrpziwISzSV9Y4alnKYty3kBTVKWhT8is
         PodAEPVmF080Zzi09jfbo4Yl70TrGBLFyAK7rALc2m/EHLKFN3oGos7vsEIQR65vlMQS
         GHk6MdDYlHZ3jTrrCiWrCfJYNZaL7p4vd3XvIEbxfXe1kkPSuB+YJLV1kdK85q8hIN8G
         /AMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724946662; x=1725551462;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvAY9Ccukr+/HE07/0WO1dFQLdJcPTCRcUNXQG5PwWI=;
        b=N15RXS+8y+dLjEvZGY7qbFzJvXZahz2+L/UBZmNgo273RmMMnYDiu/NLR9ePcphznH
         0yOrxgLN4gTmP7QzoHQVubWP8FMleK8fdBJmBwOtj8ESYt9rFk3AXY0iQ8OjKafuvias
         VILUHipEIVzA0WQA62kqZi0IRssb9zOMff6ztvWolMP0Bm0X6hiQPDylioBsArMRof+B
         7SHFAfGOgNT/yDpOUPt44jygNjOhgl9AAzgdTloO5+qOUy3QOTrFGcllgAx/YNcUsfke
         r074vEhKGz9lMAPqcOZR3CQmLalYERi+nJKUpVVpwG8Vp0930CUrxV7YYWpnRfK/ZobN
         RsUg==
X-Forwarded-Encrypted: i=1; AJvYcCXZlv7yByMK3GFPPdRgZblIzi/vvbf1TkyuqDumzPuiPaB/TDeeLynFKqGQb4Wx89sVrIR3fXF+Msh7f2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTarNdTXOyiUC43fy+/Y2CTtGrueNnX5gnH/Ngec1t0o9baH8r
	3qLz2d8i3bvW6gJ5Q2Mjo0jmTEMT7eARWsTG3TzEddxxxXxGu5Av
X-Google-Smtp-Source: AGHT+IFha5XsOkvb/Z9HPThCNhx9ub0dAJ1+WGMf83pfULX4kvSBKgNFy4SELU2Yh91wH2n+OKqXyw==
X-Received: by 2002:a05:651c:210d:b0:2ef:29cd:3191 with SMTP id 38308e7fff4ca-2f6108934b4mr25104131fa.35.1724946661825;
        Thu, 29 Aug 2024 08:51:01 -0700 (PDT)
Received: from smtpclient.apple (89-73-96-21.dynamic.chello.pl. [89.73.96.21])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f61518225bsm1970721fa.107.2024.08.29.08.51.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2024 08:51:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <CAJD7tkbF2Cx4uRCJAN=EKDLkVC=CApiLAsYt4ZN9YcVUJZp_5g@mail.gmail.com>
Date: Thu, 29 Aug 2024 17:50:50 +0200
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
 Nhat Pham <nphamcs@gmail.com>,
 Matthew Wilcox <willy@infradead.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE83D424-A546-410D-B5ED-6E9631746ACF@gmail.com>
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
 <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com>
 <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
 <A512FD59-63DF-48D3-BCB3-83DF8505E7E0@gmail.com>
 <oophwj3aj2fnfi57ebzjuc536iltilmcpoucyms6nfk2alwvtr@pdj4cn4rvpdn>
 <3D1B8F1F-2C41-4CCD-A5D7-41CF412F99DE@gmail.com>
 <CAJD7tkbF2Cx4uRCJAN=EKDLkVC=CApiLAsYt4ZN9YcVUJZp_5g@mail.gmail.com>
To: Yosry Ahmed <yosryahmed@google.com>
X-Mailer: Apple Mail (2.3776.700.51)



> Wiadomo=C5=9B=C4=87 napisana przez Yosry Ahmed <yosryahmed@google.com> =
w dniu 27.08.2024, o godz. 20:48:
>=20
> On Sun, Aug 25, 2024 at 9:24=E2=80=AFAM Piotr Oniszczuk
> <piotr.oniszczuk@gmail.com> wrote:
>>=20
>>=20
>>=20
>>> Wiadomo=C5=9B=C4=87 napisana przez Pedro Falcato =
<pedro.falcato@gmail.com> w dniu 25.08.2024, o godz. 17:05:
>>>=20
>>> Also, could you try a memtest86 on your machine, to shake out =
potential hardware problems?
>>=20
>>=20
>> I found less time consuming way to trigger issue: 12c24t cross =
compile of llvm with =E2=80=9Eonly 16G=E2=80=9D of ram - as this =
triggers many heavy swappings (top swap usage gets 8-9G out of 16G swap =
part)
>>=20
>> With such setup - on 6.9.12 - i=E2=80=99m getting not available =
system (due cpu soft lockup) just in 1..3h
>> (usually first or second compile iteration; i wrote simple scrip =
compiling in loop + counting interations)
>=20
> Are we sure that the soft lockup problem is related to the originally
> reported problem? It seems like in v6.10 you hit a BUG in zswap
> (corruption?), and in v6.9 you hit a soft lockup with a zswap lock
> showing up in the splat. Not sure how they are relevant.

If so then i=E2=80=99m interpreting this as:

a\ 2 different bugs=20

or=20

b\ 6.10 issue is result of 6.9 bug

In such case i think we may:

1. fix 6.9 first (=3Dget it stable for let say 30h continuous compil.)
2. apply fix to 6.10 then test stability on 6.10=20

>=20
> Is the soft lockup reproducible in v6.10 as well?
>=20
> Since you have a narrow window (6.8.2 to 6.9) and a reproducer for the
> soft lockup problem, can you try bisecting?
>=20
> Thanks!



May you pls help me with reducing amount of work here?=20

1. by narrowing # of bisect iternations?
On my side each iteration is like
-build arch pkg
-install on builder
-compile till first hang (2..3h probably for bad) or 20h (for good)
this means days and i=E2=80=99m a bit short with time as all this is my =
hobby (so competes with all rest of my life...)

or

2. Ideally will be to have list of revert 6.9 commit candidates =
(starting from most probable falling commit)
i=E2=80=99ll revert and test

i=E2=80=99ll really appreciate help here=E2=80=A6.


