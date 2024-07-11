Return-Path: <linux-kernel+bounces-249719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9376C92EEEC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B11280D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14B616DEAA;
	Thu, 11 Jul 2024 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lmjf7B9v"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6402A12D205
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722805; cv=none; b=jRkCcOW3EZ9Pc2sQ7EMETPvsRvAN0kWEJ6JP/ufqtUFvPkMrlpZxRcoyVk5pzBiEHdNGYe8bYePC+Kp07DxUzjO8Pez+B+qWg3l3kFbdIMRBwptDuuSmLIrXTxQVYKYupehz3HAoeHSAFmXlPc3HA/y5MRSTNxc8vTWPUV7t2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722805; c=relaxed/simple;
	bh=oJ3GznkECINHlxveJ32vYEZrfQGHMwZIWyT2js6KsHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXS8KfDVjx6lSSsX/aZS6wnO54wF01Yli3xAa8wFyw+wfGFJgQtZ6oA5BJiTOhwr7tLUvZBG32chc15/+pw4beg8o4g05rEnpoSPAsQhi7CuhvsdWYSHLW5N/+4cd6478KL3IdM88iSf3TGPeINL/FJZSy9ZvbsM77aWHuUFi8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lmjf7B9v; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e03a17a50a9so1291697276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720722803; x=1721327603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKrM1O47jB37W8cJpeR6qNjULwDGt/SAvrPqtbchHV0=;
        b=Lmjf7B9v7vhpGH2osPN2KZzV20ef1OmcOx1qLiWH2/pWAXDHWz/sMcl3YPG5vH0aIQ
         f8RkntKGFOdHydzILfaMEe/UornAo12CYi1GXTB7gK81Q6FCc7DKMpB7pFlms15I5E6J
         DLyKfE3FMovRMSdlaxZ1HSfFwLSRBLf5vvH+TBMhIJgZGa5Y20WGbC5Jo/FNPtCh7ZVA
         TYmsqRPKG2cLwvVR6+eydNef9j1lE1rZugCYfFgEVIwbJje2FMjHA6/VHLzBp0b12BUX
         liEZe+hO/ijO/toMMZ67s+55cjI+G17gbbVDfm3fD7zjlHRnCvgq8MjO2lE/JzCZOzk3
         U5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720722803; x=1721327603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKrM1O47jB37W8cJpeR6qNjULwDGt/SAvrPqtbchHV0=;
        b=U0lsYLzDRDntuTCKCIleKtzJ0yJKo+8A/JV8jDJygZgWgTak+rV71mUo0TX+nKSjaf
         Tj6+D81dgfS9eA43cxIkkZ9R85KFQbmbmVgxwlm8PSiKZK08mcpHGNEGIdhNBNDd28lD
         xe4bYdzf4KxD1hxN6QYrl0fBd0rPFjEBhiIsr7GKF53ro6s9vVmJ8VfavIWKeFVwYFd4
         L3Zl6LMVZI/V3oAkYEueAYGJu3PnavkP9M9qXZCyyrfq25dWA4gnNu1XDcg2Ca4mkN6z
         d/ujb/YH3AduIlAh2tOjo59CzxMbqeuCQm/zZ4plCRFcDpWGCqvkYbWwCWrWpNcYeCSV
         SdTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeKsddZaSRwn2tlbjgq2CYZiKUfH777R7OIEyqukuFCahooc6o+gmZtpPQkz/XcQmROTASbauSG/wOUcmY6065j2weE1Yrau0ilsLi
X-Gm-Message-State: AOJu0YyVQC735mhG7Hbj8ix3C4yG0D74HsYIrxvSicfGMt6BnenKCTDN
	do/uHtH68gnLtZdKG4beb9n2TOQQGxbtP7YpNXUXV34rycBDzWfVU8zEqcGkb29on+aYJRZINe+
	f98DAPpMljmju2nvWzGcHB+9FqwioHSnJgYBQ
X-Google-Smtp-Source: AGHT+IFPnn8XTeseBm+nEoyL6DeSqAdfs1Hn6MN0AuuqFPv4o2UKdw+cc2xNnipURs1wj40Drk/KcRvTHQS0KSqvXHI=
X-Received: by 2002:a25:ce02:0:b0:e02:bf09:18ae with SMTP id
 3f1490d57ef6-e041b03d2f6mr10503579276.6.1720722803036; Thu, 11 Jul 2024
 11:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711170216.1149695-1-surenb@google.com> <30aa2414-3d73-4be5-adb3-10b1fc64f2a0@suse.cz>
In-Reply-To: <30aa2414-3d73-4be5-adb3-10b1fc64f2a0@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jul 2024 11:33:04 -0700
Message-ID: <CAJuCfpHDeafjETF2RhBvk1CzJ6=D6Xaur90-XUFWo9AJnF1RhQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm, slab: move prepare_slab_obj_exts_hook under CONFIG_MEM_ALLOC_PROFILING
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, sxwjean@me.com, xiongwei.song@linux.dev, 
	willy@infradead.org, nathan@kernel.org, cl@linux.com, penberg@kernel.org, 
	rientjes@google.com, iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev, 
	42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 10:21=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 7/11/24 7:02 PM, Suren Baghdasaryan wrote:
> > The only place prepare_slab_obj_exts_hook() is currently being used is
> > from alloc_tagging_slab_alloc_hook() when CONFIG_MEM_ALLOC_PROFILING=3D=
y.
> > Move its definition under CONFIG_MEM_ALLOC_PROFILING to prevent unused
> > function warning for CONFIG_SLAB_OBJ_EXT=3Dn case.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202407050845.zNONqauD-lkp=
@intel.com/
>
> Hm so that's a mainline report, but being a clang-only W=3D1 warning I th=
ink
> it can just wait for the merge window and no need for last-minute 6.10 fi=
x.

Correct. I was wrong thinking that [1] caused this. The warning was
there even before but adding this into slab/for-next simply avoids
merge conflicts.

>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > ---
> > Applied over slab/for-next because of the refactoring [1] in that branc=
h.
>
> And thus took it there. thanks.

Thanks!

>
> >
> > [1] 302a3ea38aec ("mm, slab: move allocation tagging code in the alloc =
path into a hook")
> >
> >  mm/slub.c | 48 +++++++++++++++++++++---------------------------
> >  1 file changed, 21 insertions(+), 27 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index ce39544acf7c..829a1f08e8a2 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2027,6 +2027,27 @@ static inline bool need_slab_obj_ext(void)
> >       return false;
> >  }
> >
> > +#else /* CONFIG_SLAB_OBJ_EXT */
> > +
> > +static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s=
,
> > +                            gfp_t gfp, bool new_slab)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline void free_slab_obj_exts(struct slab *slab)
> > +{
> > +}
> > +
> > +static inline bool need_slab_obj_ext(void)
> > +{
> > +     return false;
> > +}
> > +
> > +#endif /* CONFIG_SLAB_OBJ_EXT */
> > +
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > +
> >  static inline struct slabobj_ext *
> >  prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
> >  {
> > @@ -2051,33 +2072,6 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s,=
 gfp_t flags, void *p)
> >       return slab_obj_exts(slab) + obj_to_index(s, slab, p);
> >  }
> >
> > -#else /* CONFIG_SLAB_OBJ_EXT */
> > -
> > -static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s=
,
> > -                            gfp_t gfp, bool new_slab)
> > -{
> > -     return 0;
> > -}
> > -
> > -static inline void free_slab_obj_exts(struct slab *slab)
> > -{
> > -}
> > -
> > -static inline bool need_slab_obj_ext(void)
> > -{
> > -     return false;
> > -}
> > -
> > -static inline struct slabobj_ext *
> > -prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
> > -{
> > -     return NULL;
> > -}
> > -
> > -#endif /* CONFIG_SLAB_OBJ_EXT */
> > -
> > -#ifdef CONFIG_MEM_ALLOC_PROFILING
> > -
> >  static inline void
> >  alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_=
t flags)
> >  {
> >
> > base-commit: fe4e761669ab4d8b388fdb6e9dbe9a110eed8009
>

