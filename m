Return-Path: <linux-kernel+bounces-288869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8628E953FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DBAB1C226A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A864EB45;
	Fri, 16 Aug 2024 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZlewL0FR"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674FE2C1BA
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723776668; cv=none; b=rK5QfQUq9yh8IYZwF8bQ4DFscN7GPxH6VLGurG6siMH+K/qCaeuTVt0ZV48IjMYO9Mc05wISR85lfOSQwxf2Z1WZnROSlJS5Py1KX2NcnKGg8cR1NmOglZVfCMfxiInLox9lroOSihIG2FB84aU+XqdImS7jBvJr3klIAY28li8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723776668; c=relaxed/simple;
	bh=xzdNlOE6NVbY6jRH0IluIxEb0mkUQhbkH9xOl7Xm5QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrUYk42KzLpoI4atH52OV73ztn7mDyuWwFiTP3T9Q9nLJooHj9qCMQPNbkiedSlO7+vZMtrdZETdje4Yc0a9vtMzpAe6Kh1kZ/wOJSJgSD2RyCw2u4dzPGWvYrMxpkr+aFgvCqdZIkwBvYnQf0oYCVzKwmj2EWq2YqMv9Z//7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZlewL0FR; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-49294bbd279so514642137.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 19:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723776666; x=1724381466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZ4wKjX5UNtk1yVhJjQe2lnH4gaYcg79CHV/ANC3+VI=;
        b=ZlewL0FRtecCXyLnwjvubOLQb5CkwpE5lWQRtbtj3rPK0oZO+CqcwUvX6O70umCoLI
         w0YpqIckg0TkcirToaLenuH6R3nOmF3Zr+kwEd6YsJW2rRUJ4bKWNJPBMjCyuioG18zs
         xABVMZMZc/AKWyOFb1A3UxeTnkmIyUrP6nw0vDok7rIhlRFiBhPZ6xqwY9OfQqD0H9NV
         Stg/n102X4a1OXLKJDP4bYVuVbOocD8llTu44SEHqoa1PI7qzaDAdQAsxieds+L6IsFY
         y2ZaDyxwThJR1L0OweTejEQvcHURV9gjZ0KRzyFpC0XMK8lmRamAnzwOId/US+/n94Zz
         uOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723776666; x=1724381466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZ4wKjX5UNtk1yVhJjQe2lnH4gaYcg79CHV/ANC3+VI=;
        b=o9ZUU3qUvtvHr1470CPrx53lvgV5ZeMjiiIE4Ljl+j/kQ9IecqUXZojkCYRN7in35U
         Ggg0hbfGUcVjDP801Q7aReq04tu7cVB21j3kjo5aDQslk0EJ4AqMQpw+wJ6q2oEpV/Uj
         4Js4bQoh7qHavREq2rafjIKMHxlyzpz64z0i9YXV253KODjPKbJ1ZU1XhfeyhIOVugnM
         gSKUlTxraxRuzvUFvEPhOSfHiwKM3vg9XIl6spGY6L4HgwO1E3TGmsjyXow/CGGqYAwH
         keoNUdFse9wGPupIhWMpzbo5OAVPt1l03dpPXvQCPgSHFQE/q0aZJz5v8if4BJYSdVoj
         scaw==
X-Forwarded-Encrypted: i=1; AJvYcCUTJ7ubhZznNBLOLguXyYYk/6qzJHQinFOr5WfDOUAksBJnkCmLCTEMEY9k16vxvJfgGbS9y6Z9h+RdekBkmHW3ebSf0KUD377VryfE
X-Gm-Message-State: AOJu0YxNFGGRjjOCUHdU8UmIOJgkiJP22GpTNi5RjLY18uR2oVpDyLnW
	fdMM9YOEcMkVSAQJah4tg7YQbyNaHc5V4qcOTJwZQuW159Tz13oo//Si+i2J8XdUdvdrrmJVXXo
	zVbLX4Iq9euQ0bmqEqx2LFQ48SmjcKBvZCX6A
X-Google-Smtp-Source: AGHT+IHqwyaAFVLD4FMxP5y+Y6lD7lVZjOIcgrTDKtU/avRO6AmG9E1BX0dgvzWK/lpcEFyoXStfLJZE6Lu7OJRibMk=
X-Received: by 2002:a05:6102:c04:b0:492:9c55:aec5 with SMTP id
 ada2fe7eead31-4977993fe3cmr2271168137.15.1723776665944; Thu, 15 Aug 2024
 19:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <88d411c5-6d66-4d41-ae86-e0f943e5fb91@gmail.com>
 <20240814230533.54938-1-21cnbao@gmail.com> <4acdf2b7-ed65-4087-9806-8f4a187b4eb5@gmail.com>
 <20240815163013.2522e3dd83acffe70af9cba6@linux-foundation.org>
In-Reply-To: <20240815163013.2522e3dd83acffe70af9cba6@linux-foundation.org>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 15 Aug 2024 20:50:28 -0600
Message-ID: <CAOUHufa=KgKvd4+w_fFqCBDSi-nG638PW01KairXcn50VQ4x7w@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped folios
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>, Barry Song <21cnbao@gmail.com>, baohua@kernel.org, 
	cerasuolodomenico@gmail.com, corbet@lwn.net, david@redhat.com, 
	hannes@cmpxchg.org, kernel-team@meta.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 5:30=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 15 Aug 2024 16:25:09 +0100 Usama Arif <usamaarif642@gmail.com> wr=
ote:
>
> >
> >
> > commit c627655548fa09b59849e942da4decc84fa0b0f2
> > Author: Usama Arif <usamaarif642@gmail.com>
> > Date:   Thu Aug 15 16:07:20 2024 +0100
> >
> >     mm: Introduce a pageflag for partially mapped folios fix
> >
> >     Fixes the original commit by not clearing partially mapped bit
> >     in hugeTLB folios and fixing deferred split THP stats.
> >
> > ...
> >
>
> Life is getting complicated.
>
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1758,7 +1758,6 @@ static void __update_and_free_hugetlb_folio(struc=
t hstate *h,
> >                 free_gigantic_folio(folio, huge_page_order(h));
> >         } else {
> >                 INIT_LIST_HEAD(&folio->_deferred_list);
> > -               folio_clear_partially_mapped(folio);
> >                 folio_put(folio);
> >         }
> >  }
>
> Yu Zhao's "mm/hugetlb: use __GFP_COMP for gigantic folios" was
> expecting that folio_clear_partially_mapped() to be there.
>
> I resolved this within
> mm-hugetlb-use-__gfp_comp-for-gigantic-folios.patch thusly:
>
> @@ -1748,18 +1704,8 @@ static void __update_and_free_hugetlb_fo
>
>         folio_ref_unfreeze(folio, 1);
>
> -       /*
> -        * Non-gigantic pages demoted from CMA allocated gigantic pages
> -        * need to be given back to CMA in free_gigantic_folio.
> -        */
> -       if (hstate_is_gigantic(h) ||
> -           hugetlb_cma_folio(folio, huge_page_order(h))) {
> -               destroy_compound_gigantic_folio(folio, huge_page_order(h)=
);
> -               free_gigantic_folio(folio, huge_page_order(h));
> -       } else {
> -               INIT_LIST_HEAD(&folio->_deferred_list);
> -               folio_put(folio);
> -       }
> +       INIT_LIST_HEAD(&folio->_deferred_list);
> +       hugetlb_free_folio(folio);
>  }
>
>  /*
>
> Please check.

Confirmed, thanks.

