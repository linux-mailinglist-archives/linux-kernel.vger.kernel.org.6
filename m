Return-Path: <linux-kernel+bounces-425032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B4A9DBCB2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D9E2816F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E876B1487C1;
	Thu, 28 Nov 2024 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNeWHj2x"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD527A13A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732823623; cv=none; b=UyfzJs80dkICld+qhoq7+io6suvn/TY5HFQi/fIhDAEk3cQfE60nEmTudi7uczUYyeXpRp7KSgzD8nL0diHb/s4czAd9egnfwSDqitBiozqXBkRrXF9e9RHnzRtlBdpapaPNYZuGTV8gcaIenIdSIA21Hg+NIADsukeqRpjAmlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732823623; c=relaxed/simple;
	bh=kFp07LDkDWj7ywNZp0xcJ/wocZ+9eRf2GTmwXrjgOEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqVWFqRFRSo3ThDxembZMa2r8qbunyhD5VQ4kM0uiMcs9K1UtAs7cp/PNq8ZgUvdexVjINW+vSa5lBXb1haTWBxWGI3NQchYxaMcu2OPACW6+XemBZQvjvgNC03AXE8DZdmDxXUcWtiPt9yS9Eg6sWR61iz+/NeG+9Pql4PJwZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KNeWHj2x; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-466ab386254so256221cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732823619; x=1733428419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3MGEQAqQD2LsTNLOh1GtipnKL/JQve8iBL2ukXgVaw=;
        b=KNeWHj2xHy5NLRVrIKr6n40YApnuf3jKLdtACSG37dVc9UOM6hm06r4+ObolO7S+EM
         PUi680TdWfjPrHLca+GMRtgLqERaMkerBBMEacuU2qDBwtYdcdfDdjvieSsCmgrszvbb
         p+2F609lqvbof5YlQBsZVWJ9iTKOVLVb8v4V0bS7tNgfYTqVYmHUGdRFEAZe3MSZfzs2
         LOZbroewdVRAI9FvhE6V40COivWuaQ2OxniWT6nZF4jL/mOZveh6OwsvpVpZ6pT0rkVE
         tzxuE29WipTm6R0Ai02+cR9SacpF0G9dVXT/EjfeC1hGAyMLeQ0WmhGlhL+kXICjlscL
         4QJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732823619; x=1733428419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3MGEQAqQD2LsTNLOh1GtipnKL/JQve8iBL2ukXgVaw=;
        b=UE3AqMH4NudpeXUwcyll65tocHg7/3gKdbOdo3Wp1CjnOQQ6dn6ipKpYn9FZVLrprF
         PbrTGiNdt0UvIyIO7pb4b1HsdeStJTUpbo1mg16a89uE846Szne0Rky1CyGnMKLZx7fM
         v+t/44ir+v9J9VsXo76C89j0F3RJ8PLi0Wb066S78pJdQRye4F/2jQ3PLoyblPK6KV+/
         TIJhigDhqmrKsoWT7vSzZmaP5m0vadFlCiD9SucHD23ityYFWcdRGaGtGspTlTJVDj0O
         BnP/MIVkmvYbL1nTyjzEiPlVqn2aR7cGLmXBCllBbb6sZ9fDGw/UTv0R51RYJV1Y4VfH
         kw5A==
X-Forwarded-Encrypted: i=1; AJvYcCV/bUcqI+5klBlKkx8m8hkuXdsxrpnDB51u5QQisYNJG19YaIJA/D9pbg6fBcqIt47Ign/j14iOfrZyc0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7L73VBje0+O6/+q6vWI0+FNm4vOvERSt1HakmAy7Tza6Ang19
	ljLTJLb47Kqte1SSlHROkchT7ADKfQTQVt64XTMORaGORGGftTFbPC+FT5BvTYCwZ1Xo8SKcrQ9
	FobvBU6CELAFQxSOGpb9yD6Aj/PD69nSAk1HA4vu1Hpsowx1ImA/8nF8=
X-Gm-Gg: ASbGnct7ki5Rcrjxq33GVDAlzmn3Tx+46B0TyYeeR8P90xeE4q5EWeQKO1dw2jxe72C
	1aLKSlFdFh8edBjIrUn4rK/4jd8Xl1Yc=
X-Google-Smtp-Source: AGHT+IGBjhy1uINCSebC6lm/avSG4XYl+AUlbvdOTuvz7rQDsjTKEl7zyUWYjSduO6lR3bCdbNIDHNwi33X8ilGcl4o=
X-Received: by 2002:a05:622a:4d90:b0:465:3d28:8c02 with SMTP id
 d75a77b69052e-466c2a5ebcfmr3632411cf.26.1732823619308; Thu, 28 Nov 2024
 11:53:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128102619.707071-1-00107082@163.com>
In-Reply-To: <20241128102619.707071-1-00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 28 Nov 2024 11:53:28 -0800
Message-ID: <CAJuCfpE0tJfq8juxD+jeStnhQ2PTUH6DqjL7AP_E+Pw++8L35w@mail.gmail.com>
Subject: Re: [PATCH] mm/codetag: swap tags when migrate pages
To: David Wang <00107082@163.com>
Cc: kent.overstreet@linux.dev, yuzhao@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 2:26=E2=80=AFAM David Wang <00107082@163.com> wrote=
:
>
> The initial solution for codetag adjustment during page migration
> uses three kinds of low level plumbings, those steps can be replaced
> by swapping tags, which only needs one kind of low level plumbing,
> and code is more clear.

This description does not explain the real issue. I would suggest
something like:

Current solution to adjust codetag references during page migration is
done in 3 steps:
1. sets the codetag reference of the old page as empty (not pointing
to any codetag);
2. subtracts counters of the new page to compensate for its own allocation;
3. sets codetag reference of the new page to point to the codetag of
the old page.
This does not work if CONFIG_MEM_ALLOC_PROFILING_DEBUG=3Dn because
set_codetag_empty() becomes NOOP. Instead, let's simply swap codetag
references so that the new page is referencing the old codetag and the
old page is referencing the new codetag. This way accounting stays
valid and the logic makes more sense.

Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")

>
> Signed-off-by: David Wang <00107082@163.com>
> Link: https://lore.kernel.org/lkml/20241124074318.399027-1-00107082@163.c=
om/
 This above Link: seems unusual. Maybe uses Closes instead like this:

Closed: https://lore.kernel.org/lkml/20241124074318.399027-1-00107082@163.c=
om/

> ---
>  include/linux/pgalloc_tag.h |  4 ++--
>  lib/alloc_tag.c             | 35 +++++++++++++++++++----------------
>  mm/migrate.c                |  2 +-
>  3 files changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
> index 0e43ab653ab6..3469c4b20105 100644
> --- a/include/linux/pgalloc_tag.h
> +++ b/include/linux/pgalloc_tag.h
> @@ -231,7 +231,7 @@ static inline void pgalloc_tag_sub_pages(struct alloc=
_tag *tag, unsigned int nr)
>  }
>
>  void pgalloc_tag_split(struct folio *folio, int old_order, int new_order=
);
> -void pgalloc_tag_copy(struct folio *new, struct folio *old);
> +void pgalloc_tag_swap(struct folio *new, struct folio *old);
>
>  void __init alloc_tag_sec_init(void);
>
> @@ -245,7 +245,7 @@ static inline struct alloc_tag *pgalloc_tag_get(struc=
t page *page) { return NULL
>  static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned=
 int nr) {}
>  static inline void alloc_tag_sec_init(void) {}
>  static inline void pgalloc_tag_split(struct folio *folio, int old_order,=
 int new_order) {}
> -static inline void pgalloc_tag_copy(struct folio *new, struct folio *old=
) {}
> +static inline void pgalloc_tag_swap(struct folio *new, struct folio *old=
) {}
>
>  #endif /* CONFIG_MEM_ALLOC_PROFILING */
>
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 2414a7ee7ec7..b45efde50c40 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -189,26 +189,29 @@ void pgalloc_tag_split(struct folio *folio, int old=
_order, int new_order)
>         }
>  }
>
> -void pgalloc_tag_copy(struct folio *new, struct folio *old)
> +void pgalloc_tag_swap(struct folio *new, struct folio *old)
>  {
> -       union pgtag_ref_handle handle;
> -       union codetag_ref ref;
> -       struct alloc_tag *tag;
> +       union pgtag_ref_handle handles[2];
> +       union codetag_ref refs[2];
> +       struct alloc_tag *tags[2];
> +       struct folio *folios[2] =3D {new, old};
> +       int i;
>
> -       tag =3D pgalloc_tag_get(&old->page);
> -       if (!tag)
> -               return;
> +       for (i =3D 0; i < 2; i++) {
> +               tags[i] =3D pgalloc_tag_get(&folios[i]->page);
> +               if (!tags[i])
> +                       return;
> +               if (!get_page_tag_ref(&folios[i]->page, &refs[i], &handle=
s[i]))
> +                       return;

If any of the above getters fail on the second cycle, you will miss
calling put_page_tag_ref(handles[0]) and releasing the page_tag_ref
you obtained on the first cycle. It might be cleaner to drop the use
of arrays and use new/old.

> +       }
>
> -       if (!get_page_tag_ref(&new->page, &ref, &handle))
> -               return;
> +       swap(tags[0], tags[1]);
>
> -       /* Clear the old ref to the original allocation tag. */
> -       clear_page_tag_ref(&old->page);
> -       /* Decrement the counters of the tag on get_new_folio. */
> -       alloc_tag_sub(&ref, folio_size(new));
> -       __alloc_tag_ref_set(&ref, tag);
> -       update_page_tag_ref(handle, &ref);
> -       put_page_tag_ref(handle);
> +       for (i =3D 0; i < 2; i++) {
> +               __alloc_tag_ref_set(&refs[i], tags[i]);
> +               update_page_tag_ref(handles[i], &refs[i]);
> +               put_page_tag_ref(handles[i]);
> +       }
>  }
>
>  static void shutdown_mem_profiling(bool remove_file)
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 2ce6b4b814df..cc68583c86f9 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -745,7 +745,7 @@ void folio_migrate_flags(struct folio *newfolio, stru=
ct folio *folio)
>                 folio_set_readahead(newfolio);
>
>         folio_copy_owner(newfolio, folio);
> -       pgalloc_tag_copy(newfolio, folio);
> +       pgalloc_tag_swap(newfolio, folio);
>
>         mem_cgroup_migrate(folio, newfolio);
>  }
> --
> 2.39.2
>

