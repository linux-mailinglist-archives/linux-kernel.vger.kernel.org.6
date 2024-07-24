Return-Path: <linux-kernel+bounces-261558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 086E893B906
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C37D1F23162
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED5513C675;
	Wed, 24 Jul 2024 22:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRF85cv2"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7543473440
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859079; cv=none; b=fKDSKiIwz+dGbi9uj7rLsahMeMqMskByTogJyMeR4fMTw1FH0V7KG9JZvT2GTwn1NcedA5mCkk/k8VmVZm9JxUD6h96+fQdvErJU+zpXHKCu4oREl8NjwoA4FEku8TcECOGvS1pfEHdJRcuLivvs3pxOJaKfeuxknYzc8LkHCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859079; c=relaxed/simple;
	bh=NZUYAIizfzWj4+q8PHceQq+r8xbHGoe/ziGKOJxY2Tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUdzwNpAiCqmGMVh2l+aJg42TJJwGodSkGLhrajqA9PlUa4HzDoScf76ZxYQJPeUYvjegbLrQKbUyL1sF3Xf69JBfkjyAJxC4Agp+IuvhOROUir741eY3Fz95sRXTxnLgF9l4Mf90bSpCpitod2SRS6RQlER8ZWDd5ekAvrGlp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRF85cv2; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-49299adf8adso83001137.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721859076; x=1722463876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTK61uiEhYkh2o7tZZhPgecuOC2jAkgOYa/z/O56iTM=;
        b=nRF85cv22Sx6LLA/dECD7M/+HL9D3y0upQ19FGeXMZwpD2nGZ2rrqdquq5NBcBp2QI
         /OEK+ZiAnr5VpRPVwj4i0PLCLsBy3xhoqjfdlGkhZ7Hm6ilLggxR/k9F51b7AtzMk9s+
         xIcd+8Okdqj5084AiyjubJiewu+cayflvf0xqfxKi+wAKFK48bgWRgAy8uQwIglt22+8
         kDMobExyTWl6P4nPDbeWudbNxs0uXtSMTf2sv7OyMcNR0OEFhgvnbxD8OPFGnB5BJw1F
         jE0dGw2yYxQPRYbDY78Qe14LTUAEow+2nksZR68AZO/cXwGQER/SPA8GX1MgKlTzvt4r
         AhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721859076; x=1722463876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTK61uiEhYkh2o7tZZhPgecuOC2jAkgOYa/z/O56iTM=;
        b=J5LJ4vrfKt5Qxkrv8kMyzgrmTGQFE5eldn0QlTKwWpqpTROgq3dI+weWvWNK1YWjEb
         VBo0fcO1ExNGm+zq6VjQY8SgZzMDyBfN/0eqW20MpLlUl+KjRuiKyPII937NtOFrv+UY
         JSSRF2OWyA3dWH0xSRlsZ0VJFg54V/PhpDmjY/J+8kuk6ArcQhb/T7mYKXnBZ/ZYsjxn
         35n2LL1fYo2XvPaJpl7DUZmKc+eSCqFNoVZeI7PC8UzHC0aNy5r3RH5ueM+2P0dxa3g6
         MOSo6+GENU88vZjFe+kjRxYIAG/zEjVOGZ11EziE5kjxL7lKxDaeyDhxzdKz71uY6Hlq
         HLLg==
X-Forwarded-Encrypted: i=1; AJvYcCVnIj9jDC7iRn7Qvo6kLXfqmuh7S8i0LPVmydcv2K7M1aBguHFkX+lHxPMH+q3YmZnL/vdC6J7TZaSAcizvLDo9PU1+W/W4s15ifwv/
X-Gm-Message-State: AOJu0YzN+5YmHvKJXg2OxRHCM6gph73767YFq1HypOkK8WUtRWzh9Hdn
	kW2eju9taQgp2wCn7BdXA7CHGVa7NkWuNOYEKZyO9FiaJ9cvxDacGd9qgGVLbd/Q5iNgbgTC8dr
	yZ2xT02ZcVZDblMEcknJu9oz4xgs=
X-Google-Smtp-Source: AGHT+IGFQF3HjjwFKtP+DQYIsr8zKt9kM8i6tIBiJ8XE5vZgcuUYlYszg+OZVdedG73qnE+rtlN2f9ddcEFNJ2kDABY=
X-Received: by 2002:a05:6102:5044:b0:493:ce48:a2ed with SMTP id
 ada2fe7eead31-493d9b21f2bmr133373137.29.1721859076204; Wed, 24 Jul 2024
 15:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724181916.31776-1-hailong.liu@oppo.com> <20240724182827.nlgdckimtg2gwns5@oppo.com>
 <ZqFdu73H3BguX4QG@casper.infradead.org>
In-Reply-To: <ZqFdu73H3BguX4QG@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 25 Jul 2024 10:11:04 +1200
Message-ID: <CAGsJ_4yvEGW6cm8h=AJ_f9iUSNvZhODnmt6Ze7Wfxot747b9tw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] mm/vmalloc: fix incorrect __vmap_pages_range_noflush()
 if vm_area_alloc_pages() from high order fallback to order0
To: Matthew Wilcox <willy@infradead.org>
Cc: "Hailong.Liu" <hailong.liu@oppo.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	"Tangquan . Zheng" <zhengtangquan@oppo.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 8:02=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Jul 25, 2024 at 02:28:27AM +0800, Hailong.Liu wrote:
> > >     if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
> > > -                   page_shift =3D=3D PAGE_SHIFT)
> > > -           return vmap_small_pages_range_noflush(addr, end, prot, pa=
ges);
> > > +                   page_shift =3D=3D PAGE_SHIFT ||
> > > +                   page_private(pages[0]) =3D=3D VM_AREA_ALLOC_PAGES=
_FALLBACK) {
> > > +           int ret =3D vmap_small_pages_range_noflush(addr, end, pro=
t, pages);
> > > +
> > > +           set_page_private(pages[0], 0);
> > > +           return ret;
> > > +   }
> > >
> > >     for (i =3D 0; i < nr; i +=3D 1U << (page_shift - PAGE_SHIFT)) {
> > >             int err;
> > > @@ -3583,6 +3590,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > >
> > >                     /* fall back to the zero order allocations */
> > >                     alloc_gfp |=3D __GFP_NOFAIL;
> > > +                   fallback =3D true;
> > Sry for my mistake, I forget define fallback here.
> > BTW, This is not the optimal solution. Does anyone have a better idea? =
Glad to
> > hear:)
>
> Yeah, I really don't like this approach.  You could return a small
> struct indicating both nr_allocated and whether you had to fall back.
> Or you could pass a bool * parameter.  They're both pretty nasty.

Yes, I feel returning a bool won't work very well.

the result could be a mixture of PMD and PTE if the allocated pages are
larger than a PMD.

For example, if we allocate 8MB, it might result in the first 4MB being
2* PMD, and the remaining 4MB being PTE order-0 pages.

I am also curious what will happen if we allocate 3MB(1PMD + some PTEs),
is the below doing the correct mapping?

        do {
                ret =3D vmap_pages_range(addr, addr + size, prot, area->pag=
es,
                        page_shift);
                if (nofail && (ret < 0))
                        schedule_timeout_uninterruptible(1);
        } while (nofail && (ret < 0));

Is it possible we have only mapped the first 2MB if page_shift is PMD?

Thanks
Barry

