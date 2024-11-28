Return-Path: <linux-kernel+bounces-425033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DF69DBCB3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0333D281737
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FBD1487C1;
	Thu, 28 Nov 2024 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQgcXKwY"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6897A13A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732823689; cv=none; b=PuJKTIlFVNzuCBkwMy0ejAfTLUD8sPJilwmldQO+m3I/cRWOWPVkOYzwz52gAk8e34VessUJtKRFOJbHKlIUoSyqaPBXo1mCPg7Nt1M/xOQ4ZWLdi66j5HiM0fgfYyu1NTfLVoWiUqxI49jvhUaf8TuGlUPPqNSJbrrNNvdkKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732823689; c=relaxed/simple;
	bh=dr8oW2zLaxLy4A7VaaQelxw7mcP+ZcRS6lp1MkoS7GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdazLKo+GPBXvD3qsKWFpWJAeC+KVwayW8NG4+Yt29lw52S5YDFfSAU9UGHAfMpnh3OJabwY9Ns1BDYZpkbqqG1eMrgyid8OE+T/gAldEmlK4JBrGAca+qFJn18FpSKTxtP8KpMqZtfxTnj9sTO8f0DIKw1mAFmJ9LLquGs+c+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JQgcXKwY; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4668caacfb2so255561cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732823686; x=1733428486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkB1StDYK9iY92SsO9AoNAo6Yqs2+cYt48DwANwoEkM=;
        b=JQgcXKwYc58rV9ya7v13+YNEqq3PIqKw/x+/BEp3SVRj4/oDVpp8Lr+M17OS5WqS1O
         9sVAOGMqxQAt37xclCm/W7n1KdwuVW/h/KYnAKERYCVfv8B5iSfcCeNWkNCCeCl6sMi0
         wjvIVO9thaJ4TIidtNPehXVWjPSDGrrKW/44/V+bqJcMzt41UHO4qtThTGwDGDZegvWm
         g8J5t7Pf9dJ+5zwYdSesfWcPYrDwJYALuw5UCnSiot0aZlZeVZkZi6RsnLagRQpY5LbM
         zl/yf4rWQz6Tgptp8GbQA5V7xwComDD9akF4LOd6czgl8xgmCyiorDLUtyDTX/0z34Dy
         1jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732823686; x=1733428486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkB1StDYK9iY92SsO9AoNAo6Yqs2+cYt48DwANwoEkM=;
        b=D4AQaNoFLFk19gdmaUoWtKJyfKw5WMaqAd29dbxsCGiVxx4vNbHMsTeUmlOsZoVzYM
         0JUDteWtzVH7L3WvnBGrJBwd+qXkSNHN0OEnmmn9CAUJ2WK9PuOBSj7Ui4VS0IKD00ag
         19v8QRUbPX5pQpNiVet4/loPIRm8v9dWrSGqVeCkQIc9mdTJWZ+LYdsDH3SJ1gVEe0l4
         YEL94une/37S/7BTuvd/hYjNdhCIDMiTHK/h4MNtPcf+7WWGWDwdL89VMXV740aBwZOm
         LZpmBzpCSulCbpXl7byjbjE/KsW6JOOd0VlM0Q9wKs9MeY6MGMrFE45WHTrtD1xoEqXY
         EE7A==
X-Forwarded-Encrypted: i=1; AJvYcCXk2Ximx+ol6HzQYRBpaIkEg9MD8/W7PRgVHSxXEpu/UpgQ7haTW/vNQij7JyHM+Czsx1iBPdo5g2g4Z9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzhkWHokRYrcKLo86qpkr4J9kZd4OO6pLSh9lSDGGGQc5hl6op
	hpBAdZ8qEJEKZeVF4sR30K4np14/3AKy/VklNADIalbyrr/+o7qUOYCAYvZCo88gL0ryKLlFgGo
	jjbW07q/OWCJP2XBbTZFpHkECDlig5NMGsYZY
X-Gm-Gg: ASbGnct1QckX/UMcDGIBL/n3KFSo2+1tR8dYmXmezoOaJGIP9M0qe/jyf4vCrF98k8k
	056hBo6x3dhvArSNyKL44cpDrZtKOfhg=
X-Google-Smtp-Source: AGHT+IF4L8W1t9sDuXxYjQ1a5Qpt2rW5pCRo4DikcQ7c7wcYJg7GEU+ozfymbegPPfYuWbi3iYRwtfXnpvHm8NHfYV0=
X-Received: by 2002:a05:622a:40c6:b0:466:9003:aae6 with SMTP id
 d75a77b69052e-466c2936ad7mr4121011cf.2.1732823685972; Thu, 28 Nov 2024
 11:54:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128102619.707071-1-00107082@163.com> <CAJuCfpE0tJfq8juxD+jeStnhQ2PTUH6DqjL7AP_E+Pw++8L35w@mail.gmail.com>
In-Reply-To: <CAJuCfpE0tJfq8juxD+jeStnhQ2PTUH6DqjL7AP_E+Pw++8L35w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 28 Nov 2024 11:54:35 -0800
Message-ID: <CAJuCfpEqHEOa9y4rTgkqLFOc2ueVe6Yz3aKtaM8hoJtrvO4UmA@mail.gmail.com>
Subject: Re: [PATCH] mm/codetag: swap tags when migrate pages
To: David Wang <00107082@163.com>
Cc: kent.overstreet@linux.dev, yuzhao@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 11:53=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Thu, Nov 28, 2024 at 2:26=E2=80=AFAM David Wang <00107082@163.com> wro=
te:
> >
> > The initial solution for codetag adjustment during page migration
> > uses three kinds of low level plumbings, those steps can be replaced
> > by swapping tags, which only needs one kind of low level plumbing,
> > and code is more clear.
>
> This description does not explain the real issue. I would suggest
> something like:
>
> Current solution to adjust codetag references during page migration is
> done in 3 steps:
> 1. sets the codetag reference of the old page as empty (not pointing
> to any codetag);
> 2. subtracts counters of the new page to compensate for its own allocatio=
n;
> 3. sets codetag reference of the new page to point to the codetag of
> the old page.
> This does not work if CONFIG_MEM_ALLOC_PROFILING_DEBUG=3Dn because
> set_codetag_empty() becomes NOOP. Instead, let's simply swap codetag
> references so that the new page is referencing the old codetag and the
> old page is referencing the new codetag. This way accounting stays
> valid and the logic makes more sense.
>
> Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
>
> >
> > Signed-off-by: David Wang <00107082@163.com>
> > Link: https://lore.kernel.org/lkml/20241124074318.399027-1-00107082@163=
.com/
>  This above Link: seems unusual. Maybe uses Closes instead like this:
>
> Closed: https://lore.kernel.org/lkml/20241124074318.399027-1-00107082@163=
.com/

Sorry, fat fingered. Should have been:

This above Link: seems unusual. Maybe use Closes instead like this:
Closes: https://lore.kernel.org/lkml/20241124074318.399027-1-00107082@163.c=
om/

>
> > ---
> >  include/linux/pgalloc_tag.h |  4 ++--
> >  lib/alloc_tag.c             | 35 +++++++++++++++++++----------------
> >  mm/migrate.c                |  2 +-
> >  3 files changed, 22 insertions(+), 19 deletions(-)
> >
> > diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
> > index 0e43ab653ab6..3469c4b20105 100644
> > --- a/include/linux/pgalloc_tag.h
> > +++ b/include/linux/pgalloc_tag.h
> > @@ -231,7 +231,7 @@ static inline void pgalloc_tag_sub_pages(struct all=
oc_tag *tag, unsigned int nr)
> >  }
> >
> >  void pgalloc_tag_split(struct folio *folio, int old_order, int new_ord=
er);
> > -void pgalloc_tag_copy(struct folio *new, struct folio *old);
> > +void pgalloc_tag_swap(struct folio *new, struct folio *old);
> >
> >  void __init alloc_tag_sec_init(void);
> >
> > @@ -245,7 +245,7 @@ static inline struct alloc_tag *pgalloc_tag_get(str=
uct page *page) { return NULL
> >  static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsign=
ed int nr) {}
> >  static inline void alloc_tag_sec_init(void) {}
> >  static inline void pgalloc_tag_split(struct folio *folio, int old_orde=
r, int new_order) {}
> > -static inline void pgalloc_tag_copy(struct folio *new, struct folio *o=
ld) {}
> > +static inline void pgalloc_tag_swap(struct folio *new, struct folio *o=
ld) {}
> >
> >  #endif /* CONFIG_MEM_ALLOC_PROFILING */
> >
> > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > index 2414a7ee7ec7..b45efde50c40 100644
> > --- a/lib/alloc_tag.c
> > +++ b/lib/alloc_tag.c
> > @@ -189,26 +189,29 @@ void pgalloc_tag_split(struct folio *folio, int o=
ld_order, int new_order)
> >         }
> >  }
> >
> > -void pgalloc_tag_copy(struct folio *new, struct folio *old)
> > +void pgalloc_tag_swap(struct folio *new, struct folio *old)
> >  {
> > -       union pgtag_ref_handle handle;
> > -       union codetag_ref ref;
> > -       struct alloc_tag *tag;
> > +       union pgtag_ref_handle handles[2];
> > +       union codetag_ref refs[2];
> > +       struct alloc_tag *tags[2];
> > +       struct folio *folios[2] =3D {new, old};
> > +       int i;
> >
> > -       tag =3D pgalloc_tag_get(&old->page);
> > -       if (!tag)
> > -               return;
> > +       for (i =3D 0; i < 2; i++) {
> > +               tags[i] =3D pgalloc_tag_get(&folios[i]->page);
> > +               if (!tags[i])
> > +                       return;
> > +               if (!get_page_tag_ref(&folios[i]->page, &refs[i], &hand=
les[i]))
> > +                       return;
>
> If any of the above getters fail on the second cycle, you will miss
> calling put_page_tag_ref(handles[0]) and releasing the page_tag_ref
> you obtained on the first cycle. It might be cleaner to drop the use
> of arrays and use new/old.
>
> > +       }
> >
> > -       if (!get_page_tag_ref(&new->page, &ref, &handle))
> > -               return;
> > +       swap(tags[0], tags[1]);
> >
> > -       /* Clear the old ref to the original allocation tag. */
> > -       clear_page_tag_ref(&old->page);
> > -       /* Decrement the counters of the tag on get_new_folio. */
> > -       alloc_tag_sub(&ref, folio_size(new));
> > -       __alloc_tag_ref_set(&ref, tag);
> > -       update_page_tag_ref(handle, &ref);
> > -       put_page_tag_ref(handle);
> > +       for (i =3D 0; i < 2; i++) {
> > +               __alloc_tag_ref_set(&refs[i], tags[i]);
> > +               update_page_tag_ref(handles[i], &refs[i]);
> > +               put_page_tag_ref(handles[i]);
> > +       }
> >  }
> >
> >  static void shutdown_mem_profiling(bool remove_file)
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 2ce6b4b814df..cc68583c86f9 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -745,7 +745,7 @@ void folio_migrate_flags(struct folio *newfolio, st=
ruct folio *folio)
> >                 folio_set_readahead(newfolio);
> >
> >         folio_copy_owner(newfolio, folio);
> > -       pgalloc_tag_copy(newfolio, folio);
> > +       pgalloc_tag_swap(newfolio, folio);
> >
> >         mem_cgroup_migrate(folio, newfolio);
> >  }
> > --
> > 2.39.2
> >

