Return-Path: <linux-kernel+bounces-532588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7210A44F93
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD18A3B0936
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7013D212FA9;
	Tue, 25 Feb 2025 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kUKrniKw"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC59212B0D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521564; cv=none; b=ufvJMkiwUu3aQY2b2touPknDLf6QAcAiKo8V5FWhAWZcAlhXFD630lJpiEduKQU0otu512li/dyJeDmM+8dcNDYBqL5iTpcMB1CIuHdKJ1fKhe/63r33Ld+T3bI4iOB6axjrFTR+jwkMYXxJbClRoVUBEr3H9NJ2KmXvID/bKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521564; c=relaxed/simple;
	bh=+omL0bG5usAOiKMbZmtMn11yUx6SDU1JFErIAPC2NWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CynPePOSReEF+643L8ubg26lOHQbBVDmD/NUBxj3pY+MP9e+eUyoRTn4qqKbJbKFkrguVetotglesphJfVZIgeXqZMf3OZz2nNv9fq0S7o5VMW3KTiH8SOCio9NeAgjVxEUuI1NLGOSRmICmOsVMoqu6iPOMdCEillqv14oQ+hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kUKrniKw; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-471f1dd5b80so29631cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740521562; x=1741126362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwrTC5LqQGsUOp6a4E+fD006nIMQ2oDxzYaqrSA4yW0=;
        b=kUKrniKw6IrSIS0jfZ6OkawNTQwKUr+JaAdct6a0RIHE/6dExpXvfiwzZ4/e1t+ydq
         BpVkhrfRD8bnQQS2bREfeEZ0gT1qfLMonSACsEb+JYrkkJPVONE6xDmhzvR/iU5ZnHta
         DO8yAjRppw+VoL0/qadLqiOBwXX58RMvt8qdxe+s4CDHSMBzRut66+cJ98WDbRONpLgn
         ZVGiZdRhCR6GmPJJp9mzjzOkK1f+ovICMUOjxkhaoBtRZLn5+7AsGZ2mAFKC1fmrKtof
         ncFU6tWgJ5RKLFWPH+AYxsuTbO8iq7bhh/kqBtshOAJXGTIL0QNBVbEL+7qVP1Gq3aP5
         gKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740521562; x=1741126362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwrTC5LqQGsUOp6a4E+fD006nIMQ2oDxzYaqrSA4yW0=;
        b=R+4IUsnB6fSc4eYRcW0hSqR1mm5eyKmnIYdZZXX1t2kB22IRVZFlKxR5jCpw3YVUwU
         ZjFmDAnwDJ1xxe/habWI2Tp8GHXHjJRsG48p5n0spUILC2hXzgGUp1j7kGuk3GVx5oba
         pR0SYYX7zMJoceLz3zO6/wrWD3eZj/PC6NkugR52/XFdy3e7b+M0GNdhr1WRQB9URSze
         hFVw3AulhMrbxtlK+swjmh+gvdpo1pqtuEOj67zJ/qHIsV/YK+yTSXdQm4EY52pBxFO9
         Ikr9B6z6Wu2R3wxmfThXNyNf7PxNfH0ewjzdiwGm6s7UjrKB5JasHbUxYnLGbJ6Mq8zr
         9i8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWujOYvBdUDLb5vh6wz8/oUOOaUCNveaDlhpaFUfIq0uyRhbgXfkKL7yFlaiXQPxQGGVuEHyzm0kJB5Ris=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIbof9MZJP4j6XuIkrwVJ0CqIkhCpmwVQwm1vQlbz8bJ670U5K
	WmvE3gk7/6ZsJRWUaPkTSkIE+GVy/YXTvnadqJFwyT6eDTsVZxsIG1ECrHddwEVVJuMQKSZ9pru
	+ntzr+ciRq2JDX+0p/hG7MPkyMeFNAiy4YLdU
X-Gm-Gg: ASbGncsYi09QhFqCQKrQHlR4QeXqxGfEbWqchbEPu8/ixlXrb9zc+ROZSqwLch9w4D4
	rkynYQOK7jYb4V38sHd3CLY2PPwZuoC8EnOqOR33sPibD1d5WvVNiyHgJrP/IIeuLThuM/css23
	5TJCcN0cA=
X-Google-Smtp-Source: AGHT+IG8QHwqC/lfMZgIU/2wkhNunDI7FmTTo0moaCzvZNTzHf2UgTGIJS4OByBvqQnxdoCvhd4P+CJkuyJL8FDcvK0=
X-Received: by 2002:a05:622a:13ca:b0:466:861a:f633 with SMTP id
 d75a77b69052e-47376e5d9bdmr6454421cf.5.1740521561574; Tue, 25 Feb 2025
 14:12:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225204613.2316092-1-surenb@google.com> <Z7420bbHoz3y73xh@x1.local>
In-Reply-To: <Z7420bbHoz3y73xh@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 25 Feb 2025 14:12:30 -0800
X-Gm-Features: AWEUYZkYR2X7-hqdcRQcXL8Vrtj_xi5DIxLU7WQvN1cO0LOhMz7v5f97S-16abI
Message-ID: <CAJuCfpGLcxSLNek7bUALKcg8HwF8vd9piaBf+cvjYRhY=xOfrA@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: do not block on locking a large folio
 with raised refcount
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, lokeshgidra@google.com, aarcange@redhat.com, 
	21cnbao@gmail.com, v-songbaohua@oppo.com, david@redhat.com, 
	willy@infradead.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	hughd@google.com, jannh@google.com, kaleshsingh@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 1:32=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Feb 25, 2025 at 12:46:13PM -0800, Suren Baghdasaryan wrote:
> > Lokesh recently raised an issue about UFFDIO_MOVE getting into a deadlo=
ck
> > state when it goes into split_folio() with raised folio refcount.
> > split_folio() expects the reference count to be exactly
> > mapcount + num_pages_in_folio + 1 (see can_split_folio()) and fails wit=
h
> > EAGAIN otherwise. If multiple processes are trying to move the same
> > large folio, they raise the refcount (all tasks succeed in that) then
> > one of them succeeds in locking the folio, while others will block in
> > folio_lock() while keeping the refcount raised. The winner of this
> > race will proceed with calling split_folio() and will fail returning
> > EAGAIN to the caller and unlocking the folio. The next competing proces=
s
> > will get the folio locked and will go through the same flow. In the
> > meantime the original winner will be retried and will block in
> > folio_lock(), getting into the queue of waiting processes only to repea=
t
> > the same path. All this results in a livelock.
> > An easy fix would be to avoid waiting for the folio lock while holding
> > folio refcount, similar to madvise_free_huge_pmd() where folio lock is
> > acquired before raising the folio refcount.
> > Modify move_pages_pte() to try locking the folio first and if that fail=
s
> > and the folio is large then return EAGAIN without touching the folio
> > refcount. If the folio is single-page then split_folio() is not called,
> > so we don't have this issue.
> > Lokesh has a reproducer [1] and I verified that this change fixes the
> > issue.
> >
> > [1] https://github.com/lokeshgidra/uffd_move_ioctl_deadlock
> >
> > Reported-by: Lokesh Gidra <lokeshgidra@google.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> One question irrelevant of this change below..
>
> > ---
> >  mm/userfaultfd.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 867898c4e30b..f17f8290c523 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1236,6 +1236,7 @@ static int move_pages_pte(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd,
> >                */
> >               if (!src_folio) {
> >                       struct folio *folio;
> > +                     bool locked;
> >
> >                       /*
> >                        * Pin the page while holding the lock to be sure=
 the
> > @@ -1255,12 +1256,26 @@ static int move_pages_pte(struct mm_struct *mm,=
 pmd_t *dst_pmd, pmd_t *src_pmd,
> >                               goto out;
> >                       }
> >
> > +                     locked =3D folio_trylock(folio);
> > +                     /*
> > +                      * We avoid waiting for folio lock with a raised =
refcount
> > +                      * for large folios because extra refcounts will =
result in
> > +                      * split_folio() failing later and retrying. If m=
ultiple
> > +                      * tasks are trying to move a large folio we can =
end
> > +                      * livelocking.
> > +                      */
> > +                     if (!locked && folio_test_large(folio)) {
> > +                             spin_unlock(src_ptl);
> > +                             err =3D -EAGAIN;
> > +                             goto out;
> > +                     }
> > +
> >                       folio_get(folio);
> >                       src_folio =3D folio;
> >                       src_folio_pte =3D orig_src_pte;
> >                       spin_unlock(src_ptl);
> >
> > -                     if (!folio_trylock(src_folio)) {
> > +                     if (!locked) {
> >                               pte_unmap(&orig_src_pte);
> >                               pte_unmap(&orig_dst_pte);
>
> .. just notice this.  Are these problematic?  I mean, orig_*_pte are stac=
k
> variables, afaict.  I'd expect these things blow on HIGHPTE..

Ugh! Yes, I think so. From a quick look, move_pages_pte() is the only
place we have this issue and I don't see a reason for copying src_pte
and dst_pte values. I'll spend some more time trying to understand if
we really need these local copies.

>
> >                               src_pte =3D dst_pte =3D NULL;
> >
> > base-commit: 801d47bd96ce22acd43809bc09e004679f707c39
> > --
> > 2.48.1.658.g4767266eb4-goog
> >
>
> --
> Peter Xu
>

