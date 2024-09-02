Return-Path: <linux-kernel+bounces-310894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B42CD968293
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53751C2165D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5DD187329;
	Mon,  2 Sep 2024 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXbchImT"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252A6143889
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267489; cv=none; b=mVu9pQifb4s5olbOSkqw9Squ1mzau+FUJavKyUpM2/OZawoWfCYOl0Cup5rBZURb80aEUp8ZfWknj9sDdSCFlTt9udzPZhKjb0A/eDV29Qlitp5lPg0fkstjJgrVNhTN3N8oLW3elNVgRxyD0PnbHn50cX2JZNIowRUR6+xLbo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267489; c=relaxed/simple;
	bh=d2AZu0FgOe8i1cQYkiWwnvAeNAInMNJYhUwoL8TEgHk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Hzb7KJmnAhj5vTsuyY0pi2LYXc7hu1lSIs3FQWHMZb24eNf/rDvoGweugQQH4OIMnb+aigW10hcfjb1zQhkQcP19zx43dh8CtUOIK++e+EiWY11WHMZ6vGbxaasQQCV016UXLeCzBsS97jFgBB1MaPIxDyOdtF5ppHb6w98EfWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXbchImT; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5343e75c642so5174720e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725267486; x=1725872286; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2AZu0FgOe8i1cQYkiWwnvAeNAInMNJYhUwoL8TEgHk=;
        b=kXbchImT2ts9B84t+0j5JimkoiwN42HHZBNBbllgX4EYgiQD+iRKbnHP0bJzN3ZzTb
         jmSPbzofuzF8igMmO4GO7eG4UGH08K5OEyoSUEqn2rj52vM4tId2qPDY7aSbH6Pl03fQ
         mwoFvAPXT40+pswdGc7PwTePrO4q+dK9Nr6f4XEMT9ynBFr4MStA/Rf1qERxEhhbNLOV
         RwGBbabhm0Pe0P2+10YeUKKNLtT8SBSFg89xDB8i5jm9nwWvuVpZMc7Y+wjd6wuucB9w
         NR0Ah8QMtYvYwSz6dC0QmNwzNjI+6NnmqCVNVJGAAkbi374uLTS9SegD5Eos5T6ZL440
         uKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725267486; x=1725872286;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2AZu0FgOe8i1cQYkiWwnvAeNAInMNJYhUwoL8TEgHk=;
        b=wbnvASBLtBwQO0mk3tWssBAr8QIvb2+Tgw/5Qbn0rqLGEEth7EQ90cEwi+tUXcPVT6
         WG93d/eb/TWpoUYti241y0Vmg9+Oy2Co6GcNWCcNmG5rnSg1GfgrzT+fJkNn49DBmgOX
         448xw03bKxbnypg2AC49XEKCkEkvZ0AcF2jgwomiWc4NDl+bdOXY+/Ga+v/qOa0Ny+0V
         9563NHsUJ76m3Vy/VTYzREH+/s1aZofDjEXzGqls2wKmNVfEEsKCoxGpPJ7wnxQgrUo2
         k7fqJt1TgtQj8u1tkdXs0QfQc4yCWvZw+/wT0CxUqoyMS1i5YIRPKIb2Ag1s2SNmYNsS
         knmA==
X-Forwarded-Encrypted: i=1; AJvYcCUmhFxof+YP1reJkqAVTad/GFaD7Vm48WgynZL1hRBZ+BAAhujkgA81RWI0a34pL+jbHTGoi0XwSCym6w8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxej/Ji1+weNUAdn4UtGkTUNb8Wy77Un+dVV6ubuIJjKyuinjkJ
	N1yUVXVGj7+w8duOR4vTfek6MRKZfgWLt52Zq02NScB4FmaMZSLX0vMU+w==
X-Google-Smtp-Source: AGHT+IFwfYZR2luHOQ+GPhBWgJFUVzn4OSgxSLuQwNZCqivU7rhn+pZVHQZIOy9FQRYEstjwFCb45A==
X-Received: by 2002:a05:6512:3f11:b0:533:4652:983a with SMTP id 2adb3069b0e04-53546b49f56mr7622865e87.35.1725267486026;
        Mon, 02 Sep 2024 01:58:06 -0700 (PDT)
Received: from smtpclient.apple (89-73-96-21.dynamic.chello.pl. [89.73.96.21])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354084de30sm1524371e87.243.2024.09.02.01.58.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2024 01:58:05 -0700 (PDT)
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
In-Reply-To: <CAJD7tkaTcnuCFW+dWTzSAuLKBqkkGv9s5uByYm9DaJC=Cp-Xqg@mail.gmail.com>
Date: Mon, 2 Sep 2024 10:57:50 +0200
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
 Nhat Pham <nphamcs@gmail.com>,
 Matthew Wilcox <willy@infradead.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF0ABD3E-A239-4111-A8AB-5C442E759CF3@gmail.com>
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
 <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com>
 <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
 <A512FD59-63DF-48D3-BCB3-83DF8505E7E0@gmail.com>
 <oophwj3aj2fnfi57ebzjuc536iltilmcpoucyms6nfk2alwvtr@pdj4cn4rvpdn>
 <3D1B8F1F-2C41-4CCD-A5D7-41CF412F99DE@gmail.com>
 <CAJD7tkbF2Cx4uRCJAN=EKDLkVC=CApiLAsYt4ZN9YcVUJZp_5g@mail.gmail.com>
 <EE83D424-A546-410D-B5ED-6E9631746ACF@gmail.com>
 <CAJD7tkZ01PPYMzcTyX_cwr836jGonJT=fwT3ovc4ixW44keRgg@mail.gmail.com>
 <277CDE7C-7ED8-4840-9C30-533C9327B028@gmail.com>
 <CAJD7tkaTcnuCFW+dWTzSAuLKBqkkGv9s5uByYm9DaJC=Cp-Xqg@mail.gmail.com>
To: Yosry Ahmed <yosryahmed@google.com>
X-Mailer: Apple Mail (2.3776.700.51)



> Wiadomo=C5=9B=C4=87 napisana przez Yosry Ahmed <yosryahmed@google.com> =
w dniu 31.08.2024, o godz. 19:23:
>=20
> On Sat, Aug 31, 2024 at 2:41=E2=80=AFAM Piotr Oniszczuk
> <piotr.oniszczuk@gmail.com> wrote:
>>=20
>>=20
>>=20
>>> Wiadomo=C5=9B=C4=87 napisana przez Yosry Ahmed =
<yosryahmed@google.com> w dniu 29.08.2024, o godz. 23:54:
>>>=20
>>> I also noticed that you are using z3fold as the zpool. Is the =
problem
>>> reproducible with zsmalloc? I wouldn't be surprised if there's a
>>> z3fold bug somewhere.
>>>=20
>>=20
>> Hmm - yesterday i recompiled 6.9.12 with zsmalloc and =E2=80=A6. =
after 16h of continuous tests I can=E2=80=99t reproduce issue.
>> With zsmalloc 6.9.12 looks to me like stable.
>=20
> Interesting, and a little bit what I hoped for tbh.

:-)

I tested mainline 6.10.7 with 26h test and also it is stable with =
zsmalloc=20

>=20
>>=20
>> With this - what will be your advice to move forward?
>=20
> Well, it's possible that some zswap change was not fully compatible
> with z3fold, or surfaced a dormant bug in z3fold. Either way, my
> recommendation is to use zsmalloc.
> I have been trying to deprecate

IMHO - isn=E2=80=99t bug in this report + difficulties to reproduce->fix =
enough to depreciate z3fold? =20

> z3fold, and honestly you are the only person I have seen use z3fold in
> a while -- which is probably why no one else reported such a problem.

Well - in fact this is ArchLinux - not me.
I=E2=80=99m using Arch and kernel in builder machine with ArchLinux =
config + packaging

>=20
>> Is there any possibility/way to avoid bisecting? (due limited time =
from my side)
>=20
> So unless you have a reason to specifically use z3fold or avoid
> zsmalloc, please use zsmalloc. It should be better for you anyway. I

I see benefits already: on very memory demanding qtwebkit compile:
z3fold: swap frequently gets 6..8G from 16G available
zsmalloc: can=E2=80=99t see more than 1..2G
 =20
> doubt that you (or anyone) wants to spend time debugging a z3fold
> problem :)

lets depreciate it!




