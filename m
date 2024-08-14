Return-Path: <linux-kernel+bounces-287211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4D89524CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4D0283B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A331C7B6F;
	Wed, 14 Aug 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HorSUoE9"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311113DDB8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670933; cv=none; b=VTZg0zEwT3cJ0JfoEKS66VAfk3lACmDmi3NYVXzCXgnI2uzbKh89cKn8ctRSSgirbN0KVyUnkHYoIHh7hVthSul1DJMdX+g1IdijHCe/AqcRt8mFGSiIQ+mSm1JpcBb8+VO1VK0JxSh4ByySjBx79Ej+zoXOeGH7RFsWc+TAprs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670933; c=relaxed/simple;
	bh=nooDvPjrhyDcyqWzZ9kAgzT3KxWxvrBHEldBc6Dp72g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3bA1XOu1ORmmGQJufcJYEVQnje7XeFp7Ot9z5vrOWTVg9ALeYDkLzdbOFOR8Y6+rmKCSjdWTBDkoKeWReShiICHponffYffqq9P0cHM+ttrJ7HFu227SQU06XwWwTBKm31Z+nEXkBbplJI5NXZlFSKn63b3g6x//Pm2OkpcM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HorSUoE9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so48202266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723670929; x=1724275729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBCZrf3s8CAVk4wrOG7aazIiqNpvS17dF6ZS4s+MwpQ=;
        b=HorSUoE937vOeUi1deHDh2phYARWfBQZba+xnxcYgfmcMQ6bpPA11wBj0zn3smp2Db
         yR1MstgZdg8vp0AOyoFXH6uTmEvzEFltPbtGXo7QkX6QGSQEjY8X4Tsv0SGX8cNgDTrr
         3r7bF7WofLWTJmCN/gNi00HGwhYAeirDbkc/SBL8HP5/y7Z8IShiiYoQxHQcoerKjSCK
         I2f8/u6ypaYBIKbX3/ucGTCm5JsihPJtSSEEJYNqRkclNptvVIfnWV5hTTSIUVNubYbs
         IZZTv7pBauLG0wlC9vbusjvmkvhv/i+roOZZFdu+Vx48S3Z6FShzLnixD20to/T7xzzX
         /Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670929; x=1724275729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBCZrf3s8CAVk4wrOG7aazIiqNpvS17dF6ZS4s+MwpQ=;
        b=WHjK+GvwskiywuCqC4BCXuIii/f0eXdBQVaYE7qpPz4liGXyJ7WnZzPvAPO5s0/lgC
         GWBFn1qopTiEIhyzzaQM9GSSqadf8ypJ6idRC0ZZxwS5Rc3DpQgXrHok8V2i2PIQAzuy
         wJVWkSwr/7luCggTRfChck7PXfNxXsu+mE4XfmFKCGyKz+LBdHcBft4e/rNLK3UrcjSu
         Jf1Q4q1YLDDdgpKoIgZGKhQxSgWE/ilR8Y5wcASLBL3kWdHIW/KrtGT2nM7Y/GNGXLkd
         romtfggwLwcPR3gGIx6YyW/SMalTxNTT+PBjzhvxJ0qdYsojXjGSOrvmEYr12iInw2bY
         gDRw==
X-Forwarded-Encrypted: i=1; AJvYcCWxETy4BB3FzIek6McJfTmyAYxNvznvD5gq8311QuSj1nLSrh1stQQJ9/YKjssWWc78t/VIt74grjt4WlO4zr1ZQEFyGKnfz0w6nMQs
X-Gm-Message-State: AOJu0YzefbJYTLC5e6cwAiN+m9OrQfWmw5yxK2lE5eistF1W1lNmZr6j
	v9glT/dj+8R2dZZn1TTLCnGkrLIiiOzqd5RrjvNdfKCN6TL+KhkHFGrP6NRfddKqdt1FOJK1YWR
	qtfhe764O5jHdbHFJF7Dldg49kcY=
X-Google-Smtp-Source: AGHT+IG1ba1R/vxnHTpTL7Edk9ie+e8zqinIa/uDyCVY7MiU+Rgu7ul1WUnO0BLHfW97YdSI5YIs1BeHYWZ8y4mmfDk=
X-Received: by 2002:a17:907:d3c4:b0:a7a:a06b:eec9 with SMTP id
 a640c23a62f3a-a8366c2f611mr293074066b.4.1723670928513; Wed, 14 Aug 2024
 14:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814145256.1683498-1-mjguzik@gmail.com> <20240814141614.56337d7cd3f0671d8edc7676@linux-foundation.org>
In-Reply-To: <20240814141614.56337d7cd3f0671d8edc7676@linux-foundation.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 14 Aug 2024 23:28:36 +0200
Message-ID: <CAGudoHFFRRPau=iCYFjNQV_HSnC582ZZgY=iJ1HrS=sCAQ6mRw@mail.gmail.com>
Subject: Re: [PATCH] mm: whack now bogus comment in pmd_install() concerning a fence
To: Andrew Morton <akpm@linux-foundation.org>
Cc: npiggin@gmail.com, david@redhat.com, willy@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 11:16=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 14 Aug 2024 16:52:56 +0200 Mateusz Guzik <mjguzik@gmail.com> wrot=
e:
>
> > Commit 362a61ad6119 ("fix SMP data race in pagetable setup vs walking")
> > added the following:
> >
> > +       smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
> > +
> >         spin_lock(&mm->page_table_lock);
> >
> > However, over the years the fence along with the comment got moved
> > around the file, eventually landing in a spot where it is *NOT* followe=
d
> > by a lock acquire (or any other operation which might happen to provide
> > any fence on a given arch), rendering the comment stale.
> >
> > ...
> >
> > I fully concede I could not be arsed to check if the fence is still
> > needed to begin with, I ran into this while looking at something else.
> > The comment puzzled me for a minute suggesting pmd_populate has an
> > immediate lock acquire inside.
> >
> > ...
> >
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -436,7 +436,7 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, =
pgtable_t *pte)
> >                * seen in-order. See the alpha page table accessors for =
the
> >                * smp_rmb() barriers in page table walking code.
> >                */
> > -             smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lo=
ck */
> > +             smp_wmb();
> >               pmd_populate(mm, pmd, *pte);
> >               *pte =3D NULL;
> >       }
>
> It's best to document all such barriers, so the preferred patch would
> be to fix the comment rather than removing it.
>
> And if the barrier now does nothing then of course removing the thing
> would be best.
>
> So I'd suggest that the wrong comment be left there, if only to tell
> developers why the barrier used to be there!

The comment above it (only partially seen in the context) documents
what the purpose is.

The comment I'm removing merely mentions a no longer applicable
optimization opportunity: it used to be immediately followed by
spin_lock. If the architecture at hand provides a full fence when
acquiring a lock *and* has a costly smp_wmb, then a hypothetical
smp_wmb__before_spin_lock could be used to elide it.

--=20
Mateusz Guzik <mjguzik gmail.com>

