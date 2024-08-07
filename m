Return-Path: <linux-kernel+bounces-277174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C1D949D77
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2016B235BB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F177618FDAC;
	Wed,  7 Aug 2024 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q5jBevcd"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680D17BB1D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722995291; cv=none; b=Wgo5qdskSm2fSws+tLiCNiSMfXiWOLszP9tkUj4Kgsy8OW5ehLFAY18K7BIx2Z9e6ItSwHOCmQ0OkRE8r2vHHwYC/SGEHB3WYteZn+q5Gbdc7dc00IR1+diiODEEItRb2/1yExfII4zhK4heExNnahvdj6D5t02hme77mZyFm5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722995291; c=relaxed/simple;
	bh=FdUFj91gGzKYlWuS2lUpIDglWTgjwTIWbJ4I2Xge3JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dN/xzj6sE0piC0aISxC1fRPsozZTNo1SNGylIjU9lFYdDLSbqgXDOQW74IZ8NDTtYLxT3zZGdAxoUWoLeUILHonxcBN3dPShOIi6be0aLj6ttD2qnG7xnHbwuVRy4ZJ+yEPlx+4qtL1C7zMDMFfzKuzEPzhxsSwovENekfdiv+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q5jBevcd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso26685a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 18:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722995288; x=1723600088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrrAkfyQhofRZJmYel6u7rzN70+VJGRhwdoUB5Em8ng=;
        b=q5jBevcdXizwmTafCav93AVwJnJy4tDSq8jQBZqEYj2MnfNmpCZeZu9umVcZiFIyRZ
         9OlcjgraBXRtsIhLkYw9U9ChAeSut5hH9AN1H5rx1acxhDcoEdBJwChdn0V6qDnK7ls+
         0LB1E64ivVKvLgXf4SskC9/lbGpRiAmN2zQiglN02tuNJSSG3kslNypAAOsaPI0JDDJl
         eb3h0d8OlixQIBytn3qzQPguH6TARBt69p81+3ovmp+/VJvOmI4C96OXVRkIWXi5FKCM
         o1fLgCfFZI84gJFHaanf4aN6S+J8BBIwmPp2taDblQ+66JP0JBkjDTKOgEqR5tv/dfOy
         YVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722995288; x=1723600088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrrAkfyQhofRZJmYel6u7rzN70+VJGRhwdoUB5Em8ng=;
        b=pOylxC8SsNMwXs8DuOLCg6zAwzIN71x7zGpeiyfMwXzL5iRetZ8kIBU8OY5FvVL3IR
         YelLr4DkbRhF3D/FqqCBxOD7O/JIx6inZev1GwmknsIEYYR6KA4y/Iaz7qnz7fSHPshm
         7xqX4w/zyfc4r/NshuEPGI48XF8VQTSIXVUhQ7i+2qxkMdQ0BsQHFkZNkHk0me4i43eC
         Ib1YHuH1OYtqxJaZKvS3+S5NYQszGmijsKHAB2SSJBKG121cWb4UVePd1raNo6gpQkuK
         Pi5592g76ndLHuIs5jCjMa1WPnFnoECIYMTfyOV3ZeREvqks91nRUkzDonBGdEgJwq3C
         QW5w==
X-Forwarded-Encrypted: i=1; AJvYcCXFb7a2yA3ZTEESZiY3nFSQDzOZUAGTsU8GZKRvR+FkiHPjEvujKhqP4zwkVjgfwOsFnRjgzxaQiBBwSxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH2iIYQO7Sjrib9DAcKSr55RLQiw2ViOhqeCCYJp12aCEtYot7
	IhC2atqcmWwOxMHBEnfc1qV8gN6bwi/KnsCfXPzn2WfJKtcpQ3DcZT7hDIVqpCVe0IuOebgbgdv
	lLaT5IOe7yxMZ3otQt11yPghjrcPH91KdlpC3
X-Google-Smtp-Source: AGHT+IFUeSyBaZFBCbb3J6JmImqZTrIUspwZDYVipyZlGrLRsckrTInueT9GqJSQqQBtNeuPC/Ora6/JGH85RPUTwCY=
X-Received: by 2002:a05:6402:27c7:b0:5a7:7f0f:b70b with SMTP id
 4fb4d7f45d1cf-5bba25bee88mr127477a12.0.1722995287484; Tue, 06 Aug 2024
 18:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806212808.1885309-1-pedro.falcato@gmail.com>
 <20240806212808.1885309-5-pedro.falcato@gmail.com> <CALmYWFu_cnS1nHcQxVmjp=a+SdsACi+4YWWvfDGTB=pj=fmS3A@mail.gmail.com>
 <CAKbZUD2hCWoFb4s8ZbGfa7-ejTXbRjMg0wswuo-A2Y8wyomL8A@mail.gmail.com>
In-Reply-To: <CAKbZUD2hCWoFb4s8ZbGfa7-ejTXbRjMg0wswuo-A2Y8wyomL8A@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 6 Aug 2024 18:47:31 -0700
Message-ID: <CALmYWFuufH+mCOng=G+EROo7R-GNBH2w11fva-3qfYh1JCR0=w@mail.gmail.com>
Subject: Re: [PATCH 4/7] mm/mremap: Replace can_modify_mm with can_modify_vma
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 5:59=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> On Wed, Aug 7, 2024 at 12:09=E2=80=AFAM Jeff Xu <jeffxu@google.com> wrote=
:
> >
> > On Tue, Aug 6, 2024 at 2:28=E2=80=AFPM Pedro Falcato <pedro.falcato@gma=
il.com> wrote:
> > >
> > > Delegate all can_modify checks to the proper places. Unmap checks are
> > > done in do_unmap (et al).
> > >
> > > This patch allows for mremap partial failure in certain cases (for
> > > instance, when destination VMAs aren't sealed, but the source VMA is)=
.
> > > It shouldn't be too troublesome, as you'd need to go out of your way =
to
> > > do illegal operations on a VMA.
> > >
> > > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > > ---
> > >  mm/mremap.c | 33 +++++++--------------------------
> > >  1 file changed, 7 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > index e7ae140fc64..8af877d7bb0 100644
> > > --- a/mm/mremap.c
> > > +++ b/mm/mremap.c
> > > @@ -676,6 +676,9 @@ static unsigned long move_vma(struct vm_area_stru=
ct *vma,
> > >         if (unlikely(flags & MREMAP_DONTUNMAP))
> > >                 to_account =3D new_len;
> > >
> > > +       if (!can_modify_vma(vma))
> > > +               return -EPERM;
> > > +
> > I m not 100% sure, but I suspect you don't need this check? Is
> > vma_to_resize already checking the src address ?
>
> Hmm, yes, good point.
>
> >
> > PS. Is it possible to consolidate all the related changes (except the
> > fix for madvise) to a single commit ?
>
> The patch set is organized logically, in simple clear steps. As a
> maintainer, I would prefer to review something like this vs a big
> confusing patch that touches many things at once.
> Of course if the maintainers think this is too coarse (it's not
> exactly a large patch set, just moves a lot of code back and forth),
> I'm happy to merge these into larger chunks.
>
Yes. The patch is not exactly large. (The original mseal patch  has
one single patch for adding mseal code logic, and one for test).

Also the mseal has been backported to  the 6.6 kernel for ChromeOS,
if you keep the code change in one , it will make future backport
easier for me.

> >  It would be easier to look for dependency, e.g. the remap depends on m=
unmap().
>
> All patches depend on the previous (and a single patch would make it
> harder to see these dependencies). The kernel should build and the
> selftests should pass for every patch in the set.
>
> >
> > Also selftest is helpful to prove the correctness of the change. (And
> > I can also test it)
>
> I have run selftests, and it is.
>
> --
> Pedro

