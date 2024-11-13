Return-Path: <linux-kernel+bounces-407908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A559C775B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D52B1F29C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D941114F114;
	Wed, 13 Nov 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REYajD4K"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7675E148FED
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511832; cv=none; b=NfYYCNb69xMVxPtvqdUS6stMpnVCiEpmbWZwU33fDd2X+D8EdDoMpCN1K3tXej08+Ff8ow3ZmJAmmG+qSM5o4d1OJr8wN2KYVgdBgBNRRHD3jq5nFX28SqTlzYCaDFnvE1oGtpDsWHM/4V9EIUQjPQjJq5QB0292dMThOehoOw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511832; c=relaxed/simple;
	bh=Cdo5Fg3asTFFASSZuRY+El6jWs0u8Ob8ki4UqcFnV9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLIKq1M0PPVd8iO0PckT2ACA69FMHlD98qjHsdexRZEI/pfUMiSEPkUphRahgfsM9pg0F9vGIbzm5pBx6Ziry6snxHageYGoHymPZT3R7aRaltG2rW20NjGQMIjxkkf/uc5SwPaOfLqu2PVfb0+sBPiAjl4UkK+rq5uQZ7r9pGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=REYajD4K; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4608dddaa35so313471cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731511829; x=1732116629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BbbffFEdpPTuuw0SdeJQjv4E7gg7EUGlV/WAkAH+3E=;
        b=REYajD4K3Mbvp58G2Lko+pGQIBQaI1tVpo7WNlAMjzLnIrIajnywKa88ch3dUU+nlr
         MSSAPoj8xJ0hNjNSsTh9XzCtM4Ji3fiAHNhJK1ROzng/r2dARokAE2Vng4B5EGomrnZr
         8oody38dTXHNbCpBIggO+tIF8iorBa43qhfNn3dZ+1qrs+hBWy2p6ds5ye2b6nUlYlvt
         gCnhioCs0pjEE3FMWfboTMU6tycqJS//XaydPUVTNdfKAxlxJva3bFaNUCOw3/dSJ3hk
         Deut82BiSotAX0qF2oYvRvnIYH85WJy80rGbbRcyrhK1UMdJ8Krw/48L6kq5JdVCwqbt
         OUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511829; x=1732116629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BbbffFEdpPTuuw0SdeJQjv4E7gg7EUGlV/WAkAH+3E=;
        b=KA9Nupx7bX63fYD+xmraLb76yeLXsxuAXJm/Dzg3V+Lz2sBxiWMQMTZLGzeY87TZS1
         vqDkyZtKMmQKZAIYXigUyeHWy+3vzd6Gq9SNHGA5DDVx2NlQKO7dxo8k3pGuqFliDOn7
         z/f55V+weU1bhWBOHaFQ1PeUDxR2/PSQ3GKmIK3EdHEZoPpoG3mDc+G8dpbJUDh9kcNI
         0iffHPsZluA3/w8bNT+DbZhAOGehSud3+4ukJjOckPaH4sigIDBNfTy9hTbKyivO91wE
         kAxKMTr235S7k/ZMwJejIxbEk+JlkvJYvmUnPCZDTDfAPh9JHwDhOBUR/zfUIycrU4Nb
         tyYg==
X-Forwarded-Encrypted: i=1; AJvYcCVuUgE0N+yyhAc04dI1q2F6OirUB3AZ8aHr8XVYcjCGYeO7AuBPRmgpuJQFvI6aqtD85pUcfZ3TCQV7Qnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRfOqUBqnH+S/tNFQCO9c7QJtdHBdwDb8VfbBxcqm3roIcPz3I
	HZkMciDPt5zglzjlAV7ZzHKNB5HDg2yLM/ekEPFNo41GRXlRKb/Fb5ShmEqmkNBVl0ldIv5l9BR
	TAa2vGT7bYrXehjodF0Z5RrMlHG7vW8ZjSLvf
X-Gm-Gg: ASbGncvZrf4ecmAytsGGoja0zCPNNMPy+MugAymmdXFrhBErpOI4bxQ3C2O8FSnIblW
	Sf/Sg2zw3w0vIdfkkwbgRuOPZKVHCQJo=
X-Google-Smtp-Source: AGHT+IGz40KmLuNbxr1emImpXj3jJtsfK43R22qhvzAF8QhGBtb3EYXrWEmJ3so6kTbs7jEjbk5bchWT0D8Dx0lKbXY=
X-Received: by 2002:a05:622a:47c6:b0:461:679f:f1ba with SMTP id
 d75a77b69052e-4634bca4e56mr3610881cf.20.1731511828953; Wed, 13 Nov 2024
 07:30:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com> <20241112194635.444146-2-surenb@google.com>
 <16442026-5237-4dcd-9343-99a242ddb7a7@lucifer.local>
In-Reply-To: <16442026-5237-4dcd-9343-99a242ddb7a7@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 13 Nov 2024 07:30:17 -0800
Message-ID: <CAJuCfpFNVpmG-jaERY5Y5jSFWAVWk8NMJ=Gs0nSn+cmdADTUmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm: introduce vma_start_read_locked{_nested} helpers
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 6:10=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Nov 12, 2024 at 11:46:31AM -0800, Suren Baghdasaryan wrote:
> > Introduce helper functions which can be used to read-lock a VMA when
> > holding mmap_lock for read. Replace direct accesses to vma->vm_lock
> > with these new helpers.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm.h | 20 ++++++++++++++++++++
> >  mm/userfaultfd.c   | 14 ++++++--------
> >  2 files changed, 26 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index fecd47239fa9..01ce619f3d17 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -722,6 +722,26 @@ static inline bool vma_start_read(struct vm_area_s=
truct *vma)
> >       return true;
> >  }
> >
> > +/*
> > + * Use only while holding mmap_read_lock which guarantees that nobody =
can lock
> > + * the vma for write (vma_start_write()) from under us.
> > + */
> > +static inline void vma_start_read_locked_nested(struct vm_area_struct =
*vma, int subclass)
> > +{
> > +     mmap_assert_locked(vma->vm_mm);
> > +     down_read_nested(&vma->vm_lock->lock, subclass);
> > +}
> > +
> > +/*
> > + * Use only while holding mmap_read_lock which guarantees that nobody =
can lock
> > + * the vma for write (vma_start_write()) from under us.
> > + */
> > +static inline void vma_start_read_locked(struct vm_area_struct *vma)
> > +{
> > +     mmap_assert_locked(vma->vm_mm);
> > +     down_read(&vma->vm_lock->lock);
> > +}
>
> Hm, but why would we want to VMA read lock under mmap read lock again? mm=
ap
> read lock will exclude VMA writers so it seems sort of redundant to do
> this, is it because callers expect to then release the mmap read lock
> afterwards or something?

Yes, that's the pattern used there. They kinda downgrade from mmap to
vma lock to make it more local.

>
> It feels like a quite specialist case that maybe is worth adding an
> additional comment to because to me it seems entirely redundant - the who=
le
> point of the VMA locks is to be able to avoid having to take an mmap lock
> on read.
>
> Something like 'while the intent of VMA read locks is to avoid having to
> take mmap locks at all, there exist certain circumstances in which we wou=
ld
> need to hold the mmap read to begin with, and these helpers provide that
> functionality'.

Ok, I'll try documenting these functions better.

>
> Also, I guess naming is hard, but _locked here strikes me as confusing as
> I'd read this as if the locked refer to the VMA lock rather than the mmap
> lock.
>
> It also speaks to the need for some additional comment so nobody walks aw=
ay
> thinking they _must_ take a VMA read lock _as well as_ an mmap read lock
> before reading from a VMA.
>
> Again, naming, hard :>)

I'm open to suggestions.

>
> > +
> >  static inline void vma_end_read(struct vm_area_struct *vma)
> >  {
> >       rcu_read_lock(); /* keeps vma alive till the end of up_read */
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 60a0be33766f..55019c11b5a8 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -86,13 +86,11 @@ static struct vm_area_struct *uffd_lock_vma(struct =
mm_struct *mm,
> >       vma =3D find_vma_and_prepare_anon(mm, address);
> >       if (!IS_ERR(vma)) {
> >               /*
> > +              * While holding mmap_lock we can't fail
> >                * We cannot use vma_start_read() as it may fail due to
> > -              * false locked (see comment in vma_start_read()). We
> > -              * can avoid that by directly locking vm_lock under
> > -              * mmap_lock, which guarantees that nobody can lock the
> > -              * vma for write (vma_start_write()) under us.
> > +              * false locked (see comment in vma_start_read()).
>
> Nit but 'as it may fail due to false locked' reads strangely.

replace with "overflow"?

>
> >                */
> > -             down_read(&vma->vm_lock->lock);
> > +             vma_start_read_locked(vma);
>
> Do we even need this while gross 'this is an exception to the rule' comme=
nt now
> we have new helpers?
>
> Isn't it somewhat self-documenting now and uffd is no longer a special
> snowflake?

Ack.

>
>
> >       }
> >
> >       mmap_read_unlock(mm);
> > @@ -1480,10 +1478,10 @@ static int uffd_move_lock(struct mm_struct *mm,
> >                * See comment in uffd_lock_vma() as to why not using
> >                * vma_start_read() here.
> >                */
> > -             down_read(&(*dst_vmap)->vm_lock->lock);
> > +             vma_start_read_locked(*dst_vmap);
> >               if (*dst_vmap !=3D *src_vmap)
> > -                     down_read_nested(&(*src_vmap)->vm_lock->lock,
> > -                                      SINGLE_DEPTH_NESTING);
> > +                     vma_start_read_locked_nested(*src_vmap,
> > +                                             SINGLE_DEPTH_NESTING);
> >       }
> >       mmap_read_unlock(mm);
> >       return err;
> > --
> > 2.47.0.277.g8800431eea-goog
> >

