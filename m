Return-Path: <linux-kernel+bounces-309807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437E09670A1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294A41C22396
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE54178398;
	Sat, 31 Aug 2024 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs9xC92Z"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8892716A940
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725098124; cv=none; b=f0MY8CL4wylwk6hzrCujyDSwJth61paB7c8jnP9JfZIXvxM050WJlLwcFWF/cbbSkQUDPJ9DEtnkfSVFAAqsTyJhUvvLTrXQ4TZzFGfdekicmL0aWsd8OQ5AYhafJz4squUDm1Qf+B1u6D+RMIFaAnp0+Dpz0Lm+3HuxvxHSr6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725098124; c=relaxed/simple;
	bh=B3yA/oZYeNrCMjdU6Eg2vf1wZ1f06dXaNUZMAXZFdWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hl6UFAZSPI6SGg1aKXwQoiajPevDxT6OcrhTHdXjODhMSaeoXXacWk0Nx4TqO2zZTQFZoFGOWH6kKzWNXDvAxMxkKLHCr4GKz13+OCIs2QbhgyaTdpCItGGUYgoJwtT23GsRk4tHfhPneGGAY+9a+PCdtj00sR2RSc0PJi/+jC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gs9xC92Z; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4fd05947340so798212e0c.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725098121; x=1725702921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bA83jpAm5TtB/dQRQjhwKsRlQuXlKSfd6wMf3uCUyCE=;
        b=Gs9xC92ZrU2gn78fvLQGeC+TtuA+YxSPBLTrVEfbIAxRdbE7jy7B1az/DA6yanEr/P
         x7YJ4yB4VoCuzzIOGLeLuq0YFC/lHrhjAce01lXdBtAT468BEAxSzCTsh74kBNkCkaPR
         BMPOv1iTdDMJeki4DabAsq84J6SsYiW0oFLKUjL4WYCviYhH5sXKR9GdC/WeyrUk8YiN
         uUhWo2YlqJqKJgUGcY1SzfRiG+MmDgiz9VJ/6pyvaC/p+FdsXk0v5hxE9Xg8MrWjuno9
         eKv3AVRrbfmzJsqspDShEFVbpIML9VfBx/B0A2AlrjxP4a5dboLZ7jgXGmeVrnBmRTES
         t0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725098121; x=1725702921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bA83jpAm5TtB/dQRQjhwKsRlQuXlKSfd6wMf3uCUyCE=;
        b=I8nT+xB8ZmoJ6MWlhwA78Q5wC/GMfpul5ldqhx0elqDB7E4Z5DAHLTjoMC3eTTJWWz
         WD7aOn0X9SPS8UlhTAhSGvs/oo8CvMSCSJv1aHcLvLGysWZArNijkwY+i4jdBDx/Z5jx
         P4nRjQ5n91RB/WsCO2BjQR4kDmyCBcsKtmXVwzVmy3TlT1e/QkPf7aJywPWaeVc1Rpmk
         zdrAAoBQur1C5BuhPkm0LtUr/WCUgu6k0+LxXDYBsV+wXvy2PvRlhrKRAO3FmCyrNEYP
         8j6H1fgFWkWIY+97QhLE8kER0f+fBnDmXRsc6mJ9YqCmex3w/AtDnKyfRjGdT4hFEoeZ
         CsSg==
X-Forwarded-Encrypted: i=1; AJvYcCXOuJgpaVtuBlQHb20kFttItRb/Mx99BlUaa7imL8ljgM0oiLyszQp7qUbWSHFbn9dHOOm7mDr/uYlPoxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHZt3s5r77x0I5YJ9YjRe6ZEjHsth0++AT7jX45bgX5wBrF5Rx
	pceiD4ieaHb+tnMgpZThlbDNAJOih5fmQ8Ycc/9oRyZfQ4U2Q8vMDgZU+Ot0Qq68/HyeKI0Ft/p
	Np2NwSxr17q/EtsqwpfYZk7vSsHs=
X-Google-Smtp-Source: AGHT+IFjA/yo7bM97InVQY4FPIFKW8dS/BaR2e60RIphe8Mt6Hj7CScciypELUX8ycgB7ScXwsAMRNTGrIrJtYJEURM=
X-Received: by 2002:a05:6122:221b:b0:4fc:e4f5:7f83 with SMTP id
 71dfb90a1353d-5009b1305bfmr2139672e0c.9.1725098121281; Sat, 31 Aug 2024
 02:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831092339.66085-1-21cnbao@gmail.com> <d0b826c1-8577-46f8-8e4c-ca2b72554819@redhat.com>
In-Reply-To: <d0b826c1-8577-46f8-8e4c-ca2b72554819@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 31 Aug 2024 21:55:09 +1200
Message-ID: <CAGsJ_4ynOeOaRb3=xBc1uETn9oLTkSpZGoEYGpTeJ1F4uqB7bA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: entirely reuse the whole anon mTHP in do_wp_page
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Chuanhua Han <hanchuanhua@oppo.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 9:44=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 31.08.24 11:23, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > On a physical phone, it's sometimes observed that deferred_split
> > mTHPs account for over 15% of the total mTHPs. Profiling by Chuanhua
> > indicates that the majority of these originate from the typical fork
> > scenario.
> > When the child process either execs or exits, the parent process should
> > ideally be able to reuse the entire mTHP. However, the current kernel
> > lacks this capability and instead places the mTHP into split_deferred,
> > performing a CoW (Copy-on-Write) on just a single subpage of the mTHP.
> >
> >   main()
> >   {
> >   #define SIZE 1024 * 1024UL
> >           void *p =3D malloc(SIZE);
> >           memset(p, 0x11, SIZE);
> >           if (fork() =3D=3D 0)
> >                   exec(....);
> >          /*
> >        * this will trigger cow one subpage from
> >        * mTHP and put mTHP into split_deferred
> >        * list
> >        */
> >       *(int *)(p + 10) =3D 10;
> >       printf("done\n");
> >       while(1);
> >   }
> >
> > This leads to two significant issues:
> >
> > * Memory Waste: Before the mTHP is fully split by the shrinker,
> > it wastes memory. In extreme cases, such as with a 64KB mTHP,
> > the memory usage could be 64KB + 60KB until the last subpage
> > is written, at which point the mTHP is freed.
> >
> > * Fragmentation and Performance Loss: It destroys large folios
> > (negating the performance benefits of CONT-PTE) and fragments memory.
> >
> > To address this, we should aim to reuse the entire mTHP in such cases.
> >
> > Hi David,
> >
> > I=E2=80=99ve renamed wp_page_reuse() to wp_folio_reuse() and added an
> > entirely_reuse argument because I=E2=80=99m not sure if there are still=
 cases
> > where we reuse a subpage within an mTHP. For now, I=E2=80=99m setting
> > entirely_reuse to true only for the newly supported case, while all
> > other cases still get false. Please let me know if this is incorrect=E2=
=80=94if
> > we don=E2=80=99t reuse subpages at all, we could remove the argument.
>
> See [1] I sent out this week, that is able to reuse even without
> scanning page tables. If we find the the folio is exclusive we could try
> processing surrounding PTEs that map the same folio.
>
> [1] https://lkml.kernel.org/r/20240829165627.2256514-1-david@redhat.com

Great! It looks like I missed your patch again. Since you've implemented th=
is
in a better way, I=E2=80=99d prefer to use your patchset.

I=E2=80=99m curious about how you're handling ptep_set_access_flags_nr() or=
 similar
things because I couldn=E2=80=99t find the related code in your patch 10/17=
:

[PATCH v1 10/17] mm: COW reuse support for PTE-mapped THP with CONFIG_MM_ID

Am I missing something?

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

