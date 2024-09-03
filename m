Return-Path: <linux-kernel+bounces-313926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE5696AC72
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B45D2B23132
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C651D7998;
	Tue,  3 Sep 2024 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNKA9Zjg"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D391D7980
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403437; cv=none; b=nU/2wsqtbjML87nmhcAZOJFi3WOf5Q/tW6b7GyfItwsgDn17oe3rLf35u8AgbN1HWufZ0uwGul1kqhrrUccLUFXcaC5x5syd9wh6rJ7McRY6BEdfALFYVlnssPv1mWtufdP0cTOPIE4Dk5NdzO5O4eVVjqpUfAH0FVgBY6U/qgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403437; c=relaxed/simple;
	bh=8FiFXXA/l3FkeAr8G3sWENhyWD2nRnjVPnBxOLfEYnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/NjPHNFFoSZqVn7VnTpb+Q42ascsMoVR4wYm4kjhGPuhv2JXNg11vL5/joTNbC70cJltaO4325pNvmHMHoQs9HAN9IqE06IY/YLSYoG5ce3+xoXHIpquNgDFxYL/7lDtSFSqR4IyGm+VwXXr2InxXPJGPo3j6iOqZ1hqsuUagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNKA9Zjg; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4fd136aac40so1685653e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725403435; x=1726008235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FiFXXA/l3FkeAr8G3sWENhyWD2nRnjVPnBxOLfEYnc=;
        b=eNKA9ZjglaWjlTVnuY5kDHinp0x4Q0mHG/vyQ96DATYyWDU/g+6+GJ1iEmfXD3Zmtk
         tugnIHXNZhI90GpRuiI5xnxUPxhlXV9Lhou1hQGFg1cHN2X2dyqIlLXbvsHOReiy30LN
         ldgZq4vnhwJV3fbuSTCONvO0bj8DmTy2F9tRdEABo+XRi8qccOT7GM9S7S2rAdp+Z3cA
         hFaXVFRrEV/srRsGSZ2XPxF4OXhmHlMI8UTeT5uR60xqbpnVor9rz4PboUa9oz4aj9XY
         FCTJ2W/6bZvcNOvlBNC4LgHZx2IwpwrD/EvQ8fPGXEjO+k97oo4VLx8kSKmb0pk4Azj4
         6GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725403435; x=1726008235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FiFXXA/l3FkeAr8G3sWENhyWD2nRnjVPnBxOLfEYnc=;
        b=mx1R4YqDiIt1SSaZW4AzvNBUe2aBI7whWPCaUgishGgB8P+zYOpOVlXL9ietGW0XcS
         LVF+uOEFbErIdI4QfXem7TcdlTLlQreXTDV0rxSMiwRR9j83bMA37gQCwVqTeHk4D+81
         blY6tfXU93hDKh8CSIhxR+kKl73FAfeU4kTbFEz54g45s5VzpxK7yFIXpUDb/IJ+F8Mz
         jUctfWNxn3Cd6amB44UAvn7xnn8/e1cdy76tiE95kgLafkRJdaW823nl35pdt01U8UwM
         9fCn5qSWpLyfAxcj7q5ROTPVFnLiQHhwSmHuYV9t7XvAMA4FkMXb5Lb7DZ3mKAuIRPpw
         YI4g==
X-Forwarded-Encrypted: i=1; AJvYcCUuslljFFesQHtpxvtS2xbdzrSJoMG7RyCHh5C4LBmrp34odwza79XI9G63kVdsN1J7UicgBJ3b/qHmd8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZix26K2CxJsQnQg+huvImfkuhI1TeZIVusxIi+ZUGTUqM+In
	+VgSve9pi8woymbV7k9JDZtGRvkZsktkSS4iM2iFdF3MP/lE4Bu3nstzwqRPHYp09d7ek8/Eeh7
	5KCgwTLKy87J8Q4RPUuKOuiB1jE8=
X-Google-Smtp-Source: AGHT+IENyUbCLbadEWFLpOh2q/6waOSadl+medXd1iZVdEMn6jiqqDqBGZRw1xe7jx6KhhamVY4Jg5rPOa45zS2xjGA=
X-Received: by 2002:a05:6122:3115:b0:4f6:aa3e:aa4c with SMTP id
 71dfb90a1353d-5009b1b6015mr10311639e0c.3.1725403434612; Tue, 03 Sep 2024
 15:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info> <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com> <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
 <A512FD59-63DF-48D3-BCB3-83DF8505E7E0@gmail.com> <oophwj3aj2fnfi57ebzjuc536iltilmcpoucyms6nfk2alwvtr@pdj4cn4rvpdn>
 <3D1B8F1F-2C41-4CCD-A5D7-41CF412F99DE@gmail.com> <CAJD7tkbF2Cx4uRCJAN=EKDLkVC=CApiLAsYt4ZN9YcVUJZp_5g@mail.gmail.com>
 <EE83D424-A546-410D-B5ED-6E9631746ACF@gmail.com> <CAJD7tkZ01PPYMzcTyX_cwr836jGonJT=fwT3ovc4ixW44keRgg@mail.gmail.com>
 <277CDE7C-7ED8-4840-9C30-533C9327B028@gmail.com> <CAJD7tkaTcnuCFW+dWTzSAuLKBqkkGv9s5uByYm9DaJC=Cp-Xqg@mail.gmail.com>
 <EF0ABD3E-A239-4111-A8AB-5C442E759CF3@gmail.com> <CAJD7tkZi8Wg+ZCWMy=2YKZ3hLZZ7JYQaCG+w7y=3Tb8wmHC48g@mail.gmail.com>
In-Reply-To: <CAJD7tkZi8Wg+ZCWMy=2YKZ3hLZZ7JYQaCG+w7y=3Tb8wmHC48g@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 3 Sep 2024 15:43:43 -0700
Message-ID: <CAKEwX=PiyvV7AxKESk5zc9TN1n5b0uFR0pr_HGxKsUFUgk0q+Q@mail.gmail.com>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 10:49=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Sep 2, 2024 at 1:58=E2=80=AFAM Piotr Oniszczuk
> <piotr.oniszczuk@gmail.com> wrote:
> >
> >
> >
> > > Wiadomo=C5=9B=C4=87 napisana przez Yosry Ahmed <yosryahmed@google.com=
> w dniu 31.08.2024, o godz. 19:23:
> > >
> > > On Sat, Aug 31, 2024 at 2:41=E2=80=AFAM Piotr Oniszczuk
> > > <piotr.oniszczuk@gmail.com> wrote:
> > >>
> > >>
> > >>
> > >>> Wiadomo=C5=9B=C4=87 napisana przez Yosry Ahmed <yosryahmed@google.c=
om> w dniu 29.08.2024, o godz. 23:54:
> > >>>
> > >>> I also noticed that you are using z3fold as the zpool. Is the probl=
em
> > >>> reproducible with zsmalloc? I wouldn't be surprised if there's a
> > >>> z3fold bug somewhere.
> > >>>
> > >>
> > >> Hmm - yesterday i recompiled 6.9.12 with zsmalloc and =E2=80=A6. aft=
er 16h of continuous tests I can=E2=80=99t reproduce issue.
> > >> With zsmalloc 6.9.12 looks to me like stable.
> > >
> > > Interesting, and a little bit what I hoped for tbh.
> >
> > :-)
> >
> > I tested mainline 6.10.7 with 26h test and also it is stable with zsmal=
loc
> >
> > >
> > >>
> > >> With this - what will be your advice to move forward?
> > >
> > > Well, it's possible that some zswap change was not fully compatible
> > > with z3fold, or surfaced a dormant bug in z3fold. Either way, my
> > > recommendation is to use zsmalloc.
> > > I have been trying to deprecate
> >
> > IMHO - isn=E2=80=99t bug in this report + difficulties to reproduce->fi=
x enough to depreciate z3fold?
>
> I would say this bug report is yet another reason why we should deprecate=
 it.

+100000.

This is precisely why I was asking which allocator was being used
here. We have also accidentally selected z3fold internally a couple
times in the past, which had bitten us as well.

>
> >
> > > z3fold, and honestly you are the only person I have seen use z3fold i=
n
> > > a while -- which is probably why no one else reported such a problem.
> >
> > Well - in fact this is ArchLinux - not me.
> > I=E2=80=99m using Arch and kernel in builder machine with ArchLinux con=
fig + packaging
>
> According to [1], zsmalloc should be the default allocator for zswap
> on ArchLinux. Anyway, I initially thought that no one was using z3fold
> and it was bitrot, but apparently some people are using it and it's
> actively harming them.
>
> [1]https://wiki.archlinux.org/title/Zswap
>
> >
> > >
> >
> > I see benefits already: on very memory demanding qtwebkit compile:
> > z3fold: swap frequently gets 6..8G from 16G available
> > zsmalloc: can=E2=80=99t see more than 1..2G

Exactly :) zsmalloc is better than z3fold in a lot of workloads that I
have observed.

> >
> > > doubt that you (or anyone) wants to spend time debugging a z3fold
> > > problem :)
> >
> > lets depreciate it!
>
> I tried deprecating it before [2] and performed some analysis [3], but
> there was some.. resistance. Maybe I will try again and use this bug
> report as yet another argument for deprecating z3fold :)
>
> [2] https://lore.kernel.org/linux-mm/20240112193103.3798287-1-yosryahmed@=
google.com/
> [3] https://lore.kernel.org/lkml/CAJD7tkbRF6od-2x_L8-A1QL3=3D2Ww13sCj4S3i=
4bNndqF+3+_Vg@mail.gmail.com/

I don't wanna sound like a broken record. But this has been the nth
time we need to spend extra engineering time and effort unnecessarily
because we have not deprecated z3fold.

If you need more datapoint - here's our last conversation where z3fold
was a problem:

https://lore.kernel.org/lkml/CAKEwX=3DMo+EaaxBYcLMTHYADB4WhqC3QmWV3WQ0h2KM4=
91FRuQA@mail.gmail.com/

