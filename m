Return-Path: <linux-kernel+bounces-313471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DD796A5D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C003FB258FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2554118C033;
	Tue,  3 Sep 2024 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDKPqdlt"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF35114293
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385801; cv=none; b=o7shr2VmM1C37n8PIYna9bZW4TYqHBUMsDvKZPl7erw9TKzKFDqSE55svgTV8w/a716dg+bHMBpfCM/DMeWgIGXbKm+8XaJv3b9+6HceAR/qP/r+9U4zsnv2QJHbXoTPROWuYromEFlfw/yxKsQW2KV4ZL+6f8Nn0SELsmWohac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385801; c=relaxed/simple;
	bh=s0G3wSQMAl6e0rRV+V/XUHth+hntN01i+HARZDZUoKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTVbX80W0xdWa0oXHvW8t/KIyEtdG/EKeaejtfMdJ4iPsufbQ+IgX2DGMhiA4PMOPeR/G2dAedm7nvL++APZNX8+QxKAz5j01RCCk0ddIL8ZyrVXXzNFxoZTCCO2AKfKZzf0IoihcPiQ94sXYYkE7MYc7IcX9v5edGBpciFV7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDKPqdlt; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a83562f9be9so536213866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725385798; x=1725990598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0G3wSQMAl6e0rRV+V/XUHth+hntN01i+HARZDZUoKo=;
        b=PDKPqdltvWOK6TOEGgsASlxVPS6yj7ct4fKHF/bynUvLx9VrDSitWdfDWAlpnNT9mo
         KFBfJJlOQkrrz2aLelx7R+EId+y3ZRxxo2d5ku8aMUXaKBqiou6k8Rw6iU+TjsZq64tc
         J6G3hsMeV4Qzp517Bj0o/9WrZBDIsYrRkPWuO5AN2cJoWzozMp+T3jeDpRpDGMWhvlA6
         rqsxRHLj+Mpyq8qfoccYcsXZ5uGYAG29Oy2ozbu9k0V1NuHONeFqR+FlAslp2viUA3No
         x29fstxAhX7Pl+gSmJ5ZS8voydi4Qa5WwgXbdXe2uDPHfS7tT8zqoEuSlI33j5yXu7rd
         x88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725385798; x=1725990598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0G3wSQMAl6e0rRV+V/XUHth+hntN01i+HARZDZUoKo=;
        b=Y9S2VVOUH7Ew96yfDLsn/zvGV21NXNIDYUQnp7p17YZRrv+JkLakJKUqNpdLfVHZwy
         RISdn8KmmS4YzR1OlUzr35f+NhpxL74U5k2cwh6wU43oHWAMChsbHKU18HzVukdcNmMk
         mvGEypK69yJ4TUAyPVsUsONiXPBn4kBYmCLmHIhIEhQat9nN2r928Ep/EoOke6LHTiXY
         1sS6Xp4N0TMFhNj5GUFR+QKP+FgvXYeAWKZJIx7wFcTdX6tHA7bt/BacYHmz5u9mOPlu
         EZJovJUBrEtj7AIuh/wmlPub9t2EOKnxpx8KK63NOP91EsrZDxOUpr472GfL4Ng8ukth
         jhAg==
X-Forwarded-Encrypted: i=1; AJvYcCXVyOcJam3N980C2s88U4w25lXm/enE59UWMY63gUTy2eJ+q/LVJclZIAJZjoVUeNJKkeJEUb+VYO+uz7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd1013r+14EqL++YZgNihpadfTk76wlPcFjUOOtWgZtdeJwmeS
	hF2+H6KQISVr+TLDyu32QaJz6d4sV2BnfVdjXZVk5Ud+PhbZpDzJonaQ7uOCO6uW5tf4KdO+j+W
	femE3/FxZjHGcGR+BWkw/HDTRsRA7nh928AnS
X-Google-Smtp-Source: AGHT+IFofB3wIffAK9PeJljfYupTAr8ZvLUp9muEpmKLRv5Pk0pqIHrN1ItxyWws7Vw7+2fkN1xum+X0r6RRrMeLmUk=
X-Received: by 2002:a17:906:fe44:b0:a86:96d1:d1b with SMTP id
 a640c23a62f3a-a89b94b40fcmr924680766b.16.1725385797168; Tue, 03 Sep 2024
 10:49:57 -0700 (PDT)
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
 <EF0ABD3E-A239-4111-A8AB-5C442E759CF3@gmail.com>
In-Reply-To: <EF0ABD3E-A239-4111-A8AB-5C442E759CF3@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 3 Sep 2024 10:49:19 -0700
Message-ID: <CAJD7tkZi8Wg+ZCWMy=2YKZ3hLZZ7JYQaCG+w7y=3Tb8wmHC48g@mail.gmail.com>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 1:58=E2=80=AFAM Piotr Oniszczuk
<piotr.oniszczuk@gmail.com> wrote:
>
>
>
> > Wiadomo=C5=9B=C4=87 napisana przez Yosry Ahmed <yosryahmed@google.com> =
w dniu 31.08.2024, o godz. 19:23:
> >
> > On Sat, Aug 31, 2024 at 2:41=E2=80=AFAM Piotr Oniszczuk
> > <piotr.oniszczuk@gmail.com> wrote:
> >>
> >>
> >>
> >>> Wiadomo=C5=9B=C4=87 napisana przez Yosry Ahmed <yosryahmed@google.com=
> w dniu 29.08.2024, o godz. 23:54:
> >>>
> >>> I also noticed that you are using z3fold as the zpool. Is the problem
> >>> reproducible with zsmalloc? I wouldn't be surprised if there's a
> >>> z3fold bug somewhere.
> >>>
> >>
> >> Hmm - yesterday i recompiled 6.9.12 with zsmalloc and =E2=80=A6. after=
 16h of continuous tests I can=E2=80=99t reproduce issue.
> >> With zsmalloc 6.9.12 looks to me like stable.
> >
> > Interesting, and a little bit what I hoped for tbh.
>
> :-)
>
> I tested mainline 6.10.7 with 26h test and also it is stable with zsmallo=
c
>
> >
> >>
> >> With this - what will be your advice to move forward?
> >
> > Well, it's possible that some zswap change was not fully compatible
> > with z3fold, or surfaced a dormant bug in z3fold. Either way, my
> > recommendation is to use zsmalloc.
> > I have been trying to deprecate
>
> IMHO - isn=E2=80=99t bug in this report + difficulties to reproduce->fix =
enough to depreciate z3fold?

I would say this bug report is yet another reason why we should deprecate i=
t.

>
> > z3fold, and honestly you are the only person I have seen use z3fold in
> > a while -- which is probably why no one else reported such a problem.
>
> Well - in fact this is ArchLinux - not me.
> I=E2=80=99m using Arch and kernel in builder machine with ArchLinux confi=
g + packaging

According to [1], zsmalloc should be the default allocator for zswap
on ArchLinux. Anyway, I initially thought that no one was using z3fold
and it was bitrot, but apparently some people are using it and it's
actively harming them.

[1]https://wiki.archlinux.org/title/Zswap

>
> >
> >> Is there any possibility/way to avoid bisecting? (due limited time fro=
m my side)
> >
> > So unless you have a reason to specifically use z3fold or avoid
> > zsmalloc, please use zsmalloc. It should be better for you anyway. I
>
> I see benefits already: on very memory demanding qtwebkit compile:
> z3fold: swap frequently gets 6..8G from 16G available
> zsmalloc: can=E2=80=99t see more than 1..2G
>
> > doubt that you (or anyone) wants to spend time debugging a z3fold
> > problem :)
>
> lets depreciate it!

I tried deprecating it before [2] and performed some analysis [3], but
there was some.. resistance. Maybe I will try again and use this bug
report as yet another argument for deprecating z3fold :)

[2] https://lore.kernel.org/linux-mm/20240112193103.3798287-1-yosryahmed@go=
ogle.com/
[3] https://lore.kernel.org/lkml/CAJD7tkbRF6od-2x_L8-A1QL3=3D2Ww13sCj4S3i4b=
NndqF+3+_Vg@mail.gmail.com/

