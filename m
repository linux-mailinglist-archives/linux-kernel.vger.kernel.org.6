Return-Path: <linux-kernel+bounces-179180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569478C5CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AE2283068
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CC2181BA8;
	Tue, 14 May 2024 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qcz2ad2Z"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64242181B93
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722108; cv=none; b=W3NOY5H141/EkjSWb+/70upY/tNdU5OdpxKjpvlB5x8Tv/7STMDr4zi9tcVvldv++7/Qv9E/D70r/0EYBtbEH6r9cOAJGauB1ICgTGnurhD8ejAi1tab16R6e2he+zJ0g2+JDf4Le9VdSvuoq/R7Dwk08jW8+p3MImDitQDuLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722108; c=relaxed/simple;
	bh=XDdbNe7ZsD+QuIaN3ybfNtK8paLDxZBMpUwiE+mNH00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiKJm1Plo/d0N7Pa5Ow5EeZh1hIaI7zLNTZMnjrEAjK4jqgfudLLRZCLh7ZP41B8WtEdBHnKXrYfFbwBWh+7/k2alxxd+AUW8nlAAD3BHaT0CCDFRBc+NwxstcgghFQ+tJsgD5u7jIzMeaVe50F//VZkmrtdX2itEpKwDoP+kcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qcz2ad2Z; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-571be483ccaso824884a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715722105; x=1716326905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eS2rhGpY5r3pjUZRE//h/6PnRia7SX4QGvgiH8032Rs=;
        b=Qcz2ad2ZwSz3DwUigbm7HTF4/O72K09AHFXn4fc81g1hU+wtWyoeEYK1/9IDXe1LMB
         /L4p/VlE9k3kdVGJ7x79UAMnDyYQZc/piNv4zqkXeToiF7kxOsOkm4WyKauFx0mZAmop
         D13Hzg3RvF06BYemoquXJD0Yb2J/x2KPbwOAXiZBBSQS0ZkTLseKk4Jbtj+xwfKwl86A
         cZdzSX4MAjHsEXjjCFUy/5nitDBpyxxVxyL8egxK3JViMtIEABZII2TBN2o/AhJm51wm
         21Uu4gwkFg6fPL/zjez7A/i/HIyH4CR/SHfAmV0WZoO8pVgWqHqsxYNNfl+B+vP96/oj
         J26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715722105; x=1716326905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eS2rhGpY5r3pjUZRE//h/6PnRia7SX4QGvgiH8032Rs=;
        b=rQnOWZ9NpPUWgjoqUQylPtM1zH+c3o9BdE4D7TStF7u4IGgExuefrhnxFuEK7zHGTK
         4Rl9o4wdmmhvLTPHOS8M9QtCdCi516JUjIZGuA7Di7RZGBfv19nw8H5DqMzgW+GKeM+i
         kAovge0WmrR9VwO1cwN6c1sm5S6mmDzBjC53MG3irsg6sdBQU0kPypKBSRkmd508eSxr
         mmpOGMETJFh3+AEq93viDN5+4KkiYST0qaiPSeRXSJiolba58e6E5+eRlSGWfMPxxebV
         0v+2rJZdbWW4mwEOJnH0sL5I5EhkMbCdossf7+1JBivCMDd4lbcimAxk8d7hwczEHMQd
         nBjA==
X-Forwarded-Encrypted: i=1; AJvYcCXsZrlI7I7wM1lMaPUey9mVOQyafBJW1PWoGs8aLGi243KWaOWgHyexk+O/tv2uuv30FiQuymnsgK18qigA+L+GK2yJR9jM4fXnmYGT
X-Gm-Message-State: AOJu0YxYOS1ThhSO7oDHcgLNLQuMkLXFNuHeSbaXSBE21fm38ewHVBtl
	wZkHL+laUptYCOcfwzaaTGIGro6Z/9TWiRUqOpeLs7M7G33OQA4HrwrO9Gowwc3NN5byt4yWPGv
	Y3HsIZdtzN+3KST6R8DRcQbBuneQ=
X-Google-Smtp-Source: AGHT+IFJ4Hbx5jNuAI876QYUFP8wMd6M526tTNZKhnNeAWEpQY2GtrlLOSk2WZPmg5O+fdDOFb47pNOjaQYwYarHfyI=
X-Received: by 2002:a50:c30b:0:b0:574:eb80:3305 with SMTP id
 4fb4d7f45d1cf-574eb80345fmr1518586a12.11.1715722104503; Tue, 14 May 2024
 14:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511035435.1477004-1-linmiaohe@huawei.com> <20240514141439.55fba39c81c1af55c9a100e1@linux-foundation.org>
In-Reply-To: <20240514141439.55fba39c81c1af55c9a100e1@linux-foundation.org>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 14 May 2024 15:28:12 -0600
Message-ID: <CAHbLzkq+NBjwjSvU1fQe56nLf5mmGp65TH8hDpb66EFLENctKA@mail.gmail.com>
Subject: Re: [PATCH -rc7] mm/huge_memory: mark huge_zero_page reserved
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, nao.horiguchi@gmail.com, xuyu@linux.alibaba.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 3:14=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sat, 11 May 2024 11:54:35 +0800 Miaohe Lin <linmiaohe@huawei.com> wrot=
e:
>
> > When I did memory failure tests recently, below panic occurs:
> >
> >  kernel BUG at include/linux/mm.h:1135!
> >  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> >  CPU: 9 PID: 137 Comm: kswapd1 Not tainted 6.9.0-rc4-00491-gd5ce28f156f=
e-dirty #14
> >
> > ...
> >
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -208,6 +208,7 @@ static bool get_huge_zero_page(void)
> >               __free_pages(zero_page, compound_order(zero_page));
> >               goto retry;
> >       }
> > +     __SetPageReserved(zero_page);
> >       WRITE_ONCE(huge_zero_pfn, page_to_pfn(zero_page));
> >
> >       /* We take additional reference here. It will be put back by shri=
nker */
> > @@ -260,6 +261,7 @@ static unsigned long shrink_huge_zero_page_scan(str=
uct shrinker *shrink,
> >               struct page *zero_page =3D xchg(&huge_zero_page, NULL);
> >               BUG_ON(zero_page =3D=3D NULL);
> >               WRITE_ONCE(huge_zero_pfn, ~0UL);
> > +             __ClearPageReserved(zero_page);
> >               __free_pages(zero_page, compound_order(zero_page));
> >               return HPAGE_PMD_NR;
> >       }
>
> This causes a bit of a mess when staged ahead of mm-stable.  So to
> avoid disruption I staged it behind mm-stable.  This means that when
> the -stable maintainers try to merge it, they will ask for a fixed up
> version for older kernels so you can please just send them this
> version.

Can you please drop this from mm-unstable since both I and David
nack'ed a similar patch in another thread.
https://lore.kernel.org/linux-mm/20240511032801.1295023-1-linmiaohe@huawei.=
com/

Both patches actually do the same thing, just this one uses page, the
other one uses folio.

>
> To facilitate this I added the below adjustment:
>
> (btw, shouldn't get_huge_zero_page() and shrink_huge_zero_page_scan()
> be renamed to *_folio_*?)
>
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm-huge_memory-mark-huge_zero_page-reserved-fix
> Date: Tue May 14 01:53:37 PM PDT 2024
>
> Update it for 5691753d73a2 ("mm: convert huge_zero_page to huge_zero_foli=
o")
>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
> Cc: Xu Yu <xuyu@linux.alibaba.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  mm/huge_memory.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- a/mm/huge_memory.c~mm-huge_memory-mark-huge_zero_page-reserved-fix
> +++ a/mm/huge_memory.c
> @@ -212,7 +212,7 @@ retry:
>                 folio_put(zero_folio);
>                 goto retry;
>         }
> -       __SetPageReserved(zero_page);
> +       __folio_set_reserved(zero_folio);
>         WRITE_ONCE(huge_zero_pfn, folio_pfn(zero_folio));
>
>         /* We take additional reference here. It will be put back by shri=
nker */
> @@ -265,7 +265,7 @@ static unsigned long shrink_huge_zero_pa
>                 struct folio *zero_folio =3D xchg(&huge_zero_folio, NULL)=
;
>                 BUG_ON(zero_folio =3D=3D NULL);
>                 WRITE_ONCE(huge_zero_pfn, ~0UL);
> -               __ClearPageReserved(zero_page);
> +               __folio_clear_reserved(zero_folio);
>                 folio_put(zero_folio);
>                 return HPAGE_PMD_NR;
>         }
> _
>

