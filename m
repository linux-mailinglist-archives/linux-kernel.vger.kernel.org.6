Return-Path: <linux-kernel+bounces-262435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C3493C713
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67AA1C21FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D139B19D890;
	Thu, 25 Jul 2024 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SGgVtdE2"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2E17588
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924328; cv=none; b=cbIA5HAJUqtHX16iFZHSutwTe1xxcY6+XWijlid0a4EWSCXHoEyR2uEXkERW+YqfxMlI5sYz1idYxpRw0Jo5FqIsoVZiYL3i4Ayl7DOBfaPBWj0OKlccZ20v64FU4wloQnH+NajYbYEOHb/yibJvxskgU4hWYj83nwotE7gNHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924328; c=relaxed/simple;
	bh=xsNte05w5NFyFWw6+3UYRlyMLV3hafmgkJAKhvk8/Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlew9EmxBVWGQXyRificCrKSXCRvQnXyI1HRFVRzBdy4XwkfS1nteGv9cfnZA66NcLsYM372B62YBxHaganXTel44WD2uWiA1IWClNZlnQpEpJpWDY4u89nr8c8qggQqyYYsgpMHjZvtqb0Y9pdW4yJTGa1d0c4izMMK/kJnPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SGgVtdE2; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db130a872fso23665b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721924325; x=1722529125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taWGaT3w4wOQQ018sVYuoJ2OTMdIrOZ4X59IynnsK/0=;
        b=SGgVtdE2clCEb9Px604Sd8Ar8JsPhcLhlMSbkNu4Lf1lj+wCHG7ePcf1W9xESYc81s
         JdvGLwhJtoIETww6uIR/FkQWEEw71DZWmCuxlrIoMxCQE/8iY1PjXrvFPUF4HchIBa5y
         2JMWTyFdtFSJEYkdSTKUe2YSBv3fqSWQmLyYagaFbcSuHjKJ/4DueG/zCc7VaCk4vaI+
         BDjVMNX3uAjsgDmzR8TzCj4ZOXJzFMJjBOUpoK4KtClU+CEWa0IaP2vJmtdIPsN7DV8f
         97BfjFH3pt23bkON9G7bGKZshPBFZ/cTzOPP7M9KiUnar2TEbIaeoLwu49r5U7L44Rlx
         BAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721924325; x=1722529125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taWGaT3w4wOQQ018sVYuoJ2OTMdIrOZ4X59IynnsK/0=;
        b=KzOGoENp6IHVjVlZlMLFODAD1xJBGw22JAo/omveCrD9g0AEW7Xqug57uHBBxpI6rE
         XVhrN8FWeG8hod3NMEcgtoh1+UcmpbzJxm56I9T78vRi3InTAnobi97NPhd11TnGvTsx
         TSz/EXpYR8eXOJYcW1dcMoefk6WwDWl3w+nEwhj1JvKT08ZocZZc/gw0Y4aQQF0K8kNX
         ZsIGrw1AZuFUJtEO98ZzST7IBWh2DeR8zxutpXZm14q/1/5IZfk41D4MCiSj1acHUpAq
         Cakp6l08Qu96xHVHyPUCkbIWWVYnMRbgTDfLQVJLEL41nSiHL3MX6qwCZVVeQge8lDwn
         HDPw==
X-Forwarded-Encrypted: i=1; AJvYcCUcB7zdH76TPinFCbHjWhHz8PjvRUoSavYgm6yct4Jf11PdC1s0DG/VE3EAS38USnzO3gmWHM3N0q2fKEzbuAQphKi3IGI2Quh2sHJH
X-Gm-Message-State: AOJu0YzmyYMi+CEs6juogy1IN6PyOL0CL5NNvuWuZHKLOkM+komGC45B
	qPBWyFqtjpe1CS9a4vgZdYkbnWtabGA1+Tc1DGm9Dn/v3c/R3Ssyi4H3xGFasHecf4Ogn8qUJio
	Uy+a8N4IA34Utt0e63XMGNQ8fz3GdLjLvwShXZvRi6R2UpK70sg==
X-Google-Smtp-Source: AGHT+IHLEzcxxVMZcmdDCRzakueRTDgXzXsCz/LjKhHPcGx2OqMU6KMBDb/YEtnUeQoaDD0UsCJyYEHM1CsawT9LBW0=
X-Received: by 2002:a05:6808:19aa:b0:3d9:243a:7ae8 with SMTP id
 5614622812f47-3db141b3a98mr3570225b6e.39.1721924325226; Thu, 25 Jul 2024
 09:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709163053.2514760-1-fvdl@google.com> <20240724124845.614c03ad39f8af3729cebee6@linux-foundation.org>
In-Reply-To: <20240724124845.614c03ad39f8af3729cebee6@linux-foundation.org>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 25 Jul 2024 09:18:33 -0700
Message-ID: <CAPTztWaCFYgQo1Bk6w-f_2=aYBbYfXeLy_WPw3XRJ+a3RDwnzg@mail.gmail.com>
Subject: Re: [PATCH] mm/cma: export total and free number of pages for CMA areas
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 12:49=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue,  9 Jul 2024 16:30:53 +0000 Frank van der Linden <fvdl@google.com>=
 wrote:
>
> > In addition to the number of allocations and releases, system
> > management software may like to be aware of the size of CMA
> > areas, and how many pages are available in it. This information
> > is currently not available, so export it in total_page and
> > available_pages, respectively.
> >
> > The name 'available_pages' was picked over 'free_pages' because
> > 'free' implies that the pages are unused. But they might not
> > be, they just haven't been used by cma_alloc
> >
> > The number of available pages is tracked regardless of
> > CONFIG_CMA_SYSFS, allowing for a few minor shortcuts in
> > the code, avoiding bitmap operations.
> >
> > ...
> >
> > @@ -382,7 +383,7 @@ static void cma_debug_show_areas(struct cma *cma)
> >  {
> >       unsigned long next_zero_bit, next_set_bit, nr_zero;
> >       unsigned long start =3D 0;
> > -     unsigned long nr_part, nr_total =3D 0;
> > +     unsigned long nr_part;
> >       unsigned long nbits =3D cma_bitmap_maxno(cma);
> >
> >       spin_lock_irq(&cma->lock);
> > @@ -394,12 +395,12 @@ static void cma_debug_show_areas(struct cma *cma)
> >               next_set_bit =3D find_next_bit(cma->bitmap, nbits, next_z=
ero_bit);
> >               nr_zero =3D next_set_bit - next_zero_bit;
> >               nr_part =3D nr_zero << cma->order_per_bit;
> > -             pr_cont("%s%lu@%lu", nr_total ? "+" : "", nr_part,
> > +             pr_cont("%s%lu@%lu", start ? "+" : "", nr_part,
> >                       next_zero_bit);
> > -             nr_total +=3D nr_part;
> >               start =3D next_zero_bit + nr_zero;
> >       }
>
> Can you please explain the above change?

Sure - there's no need anymore to keep a count of available pages for
the debug output, since that's already tracked in the available_count
field. So, 'nr_total' can be removed. But you still need to check for
this being the first instance of the loop, so use 'start' for that
instead.
>
> > -     pr_cont("=3D> %lu free of %lu total pages\n", nr_total, cma->coun=
t);
> > +     pr_cont("=3D> %lu free of %lu total pages\n", cma->available_coun=
t,
> > +                     cma->count);
> >       spin_unlock_irq(&cma->lock);
> >  }
> >
> > @@ -446,6 +447,10 @@ struct page *cma_alloc(struct cma *cma, unsigned l=
ong count,
> >
> >       for (;;) {
> >               spin_lock_irq(&cma->lock);
> > +             if (count > cma->available_count) {
>
> Right here would be a nice place for a comment?
>
Yes, I'll add one.

> > +                     spin_unlock_irq(&cma->lock);
> > +                     break;
> > +             }
> >               bitmap_no =3D bitmap_find_next_zero_area_off(cma->bitmap,
> >                               bitmap_maxno, start, bitmap_count, mask,
> >                               offset);
>

I'll re-send a v2 with some Cc: lines added.

Thanks!

- Frank

