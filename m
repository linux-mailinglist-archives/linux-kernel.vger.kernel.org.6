Return-Path: <linux-kernel+bounces-328750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BD8978846
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B64288234
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1870713B59E;
	Fri, 13 Sep 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tP2RrfKm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56C13A3F6;
	Fri, 13 Sep 2024 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253812; cv=none; b=lVJxC/SE81gtZALdzx/ko9InfLZx29QkROnoH9Y3i9nih4OWl6gzlKyvd5VOZK14d4VrdzNj/xU7Rv3dz98n9FXwf/f0mGkCXa35+X8AGndrVqPCh4Mj1DrJBmh/njp2RTjQJ77hB19w+ec43N/My8gnt3vAfZVD47e3BtmozHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253812; c=relaxed/simple;
	bh=MU66eme10gPD/yu7J7iVTKruJuuQlBaObSGd/wyBjwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=So/JTapQHuG0ZdQQ39upd95JXqA9iqzr/T3j54vDX72wvYHMynnj4qmX1IXRN3SS4SiGduE3oZTZsyRR2J71x+SKE1Du91Dg0fcMrUKZafwvWeQOEIUA2Wg+1fIRdnyCvYxp5NrmFjBaD+QIFrdlqOBTiFKarmRr0nXc7gyytgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tP2RrfKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A27C4CECD;
	Fri, 13 Sep 2024 18:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726253811;
	bh=MU66eme10gPD/yu7J7iVTKruJuuQlBaObSGd/wyBjwY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tP2RrfKm38M+eDc/N+4qcNYEXZlVuE+4IfSo09o2ypl4jBgRwKIWOrXZ5/Ayg0zCc
	 wlGnGz7SytGX5VhVB8rbNkXv3k62JU5ZvRzNnup/wzvsadSwbiPeo8wh6aJiqqoSFi
	 ulTdTUVP/xkvcpThlVfzpTT5/xOsbX/ktWEBMW8rBeStJDCo1lyoAOsUy+zENNqQ0y
	 0NtNqkHMMOfwG/pLnLijEH7wa16QHxO99tyiXp4uka3bNxRy6dru1kagwIdJGtjLGv
	 OEQjO297g/YEZ4ZmS0bqfz4l90+2MtdKxYcw5TgHJ8OHLkPsMHwe/kTPjIh+wqytzq
	 asxj5BAZjl0SQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-536562739baso2156071e87.1;
        Fri, 13 Sep 2024 11:56:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV77Q1J/XDGAleCAf/nG2V3TpjBh2ttanHx05hgKSrFE8SIBngwsIHJE7WUOI7pUlRE5JD/83B4WI5K@vger.kernel.org, AJvYcCW+S6oIMicZAynkQuFW3VmXdqrMg/jqRGpt08Qav71gNvlihXNKkPgzw76I3YxU6virj+LQK2ARKawLnysS@vger.kernel.org
X-Gm-Message-State: AOJu0YxJiHBIJ51Phk8oxALPFov82SB8BHp2yJP3SXYjZqByQXvEneo4
	T6Pb1SNrG1Vy05ga+ez4PzQiBhuphJv2IWz7jk5BkwD2hzzmYRtjPGfYOJfFRiWeMW2v/uTcoOE
	NFLAG0NztIR7U09+ODy4dcyE1xA==
X-Google-Smtp-Source: AGHT+IHRy1/QFoSwP2uJlUhM1zAHn9fqI4LVW/q56a9TRgmWkrLrojWdNvdph9QPZS3lJh4up/5q7OADDbF9pJ4gEcc=
X-Received: by 2002:a05:6512:1196:b0:536:55ae:7458 with SMTP id
 2adb3069b0e04-53678fed155mr5253297e87.40.1726253810268; Fri, 13 Sep 2024
 11:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-of-address-overflow-v1-1-19567aaa61da@linutronix.de> <87plp7r8ye.fsf@mail.lhotse>
In-Reply-To: <87plp7r8ye.fsf@mail.lhotse>
From: Rob Herring <robh@kernel.org>
Date: Fri, 13 Sep 2024 13:56:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLYQyue9WyYiQPaM1D8Hxve-a4RXCaDRvyeF2VWWx=Ozg@mail.gmail.com>
Message-ID: <CAL_JsqLYQyue9WyYiQPaM1D8Hxve-a4RXCaDRvyeF2VWWx=Ozg@mail.gmail.com>
Subject: Re: [PATCH] of: address: Unify resource bounds overflow checking
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 8:15=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:
> > The members "start" and "end" of struct resource are of type
> > "resource_size_t" which can be 32bit wide.
> > Values read from OF however are always 64bit wide.
> >
> > Refactor the diff overflow checks into a helper function.
> > Also extend the checks to validate each calculation step.
> >
> > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  drivers/of/address.c | 45 ++++++++++++++++++++++++++------------------=
-
> >  1 file changed, 26 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 7e59283a4472..df854bb427ce 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -198,6 +198,25 @@ static u64 of_bus_pci_map(__be32 *addr, const __be=
32 *range, int na, int ns,
> >
> >  #endif /* CONFIG_PCI */
> >
> > +static int __of_address_resource_bounds(struct resource *r, u64 start,=
 u64 size)
> > +{
> > +     u64 end =3D start;
> > +
> > +     if (overflows_type(start, r->start))
> > +             return -EOVERFLOW;
> > +     if (size =3D=3D 0)
> > +             return -EOVERFLOW;
> > +     if (check_add_overflow(end, size - 1, &end))
> > +             return -EOVERFLOW;
> > +     if (overflows_type(end, r->end))
> > +             return -EOVERFLOW;
>
> This breaks PCI on powerpc qemu. Part of the PCI probe reads a resource
> that's zero sized, which used to succeed but now fails due to the size
> check above.
>
> The diff below fixes it for me.

I fixed it up with your change.


> It leaves r.end =3D=3D r.start, which is fine in my case, because the cod=
e
> only uses r.start.
>
> And it seems more sane than the old code which would return
> end =3D start - 1, for zero sized resources.
>
> cheers
>
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index df854bb427ce..a001e789a6c4 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -204,9 +204,7 @@ static int __of_address_resource_bounds(struct resour=
ce *r, u64 start, u64 size)
>
>         if (overflows_type(start, r->start))
>                 return -EOVERFLOW;
> -       if (size =3D=3D 0)
> -               return -EOVERFLOW;
> -       if (check_add_overflow(end, size - 1, &end))
> +       if (size > 0 && check_add_overflow(end, size - 1, &end))
>                 return -EOVERFLOW;
>         if (overflows_type(end, r->end))
>                 return -EOVERFLOW;
>

