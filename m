Return-Path: <linux-kernel+bounces-532603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E8A44FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A22F7A65F3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2879721420D;
	Tue, 25 Feb 2025 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T9YXZA4S"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6643214A97
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522114; cv=none; b=nyskvKLHmuR2bFLNVjAQ2niyVYyuFNIpuwMU6PPAu2PquenoBqBG23zIX1xfKMM8Z20fz90XXRj15oo04QIwERsidMXc3taqLe//I7JjaxIx+FOjhI3Th/8l3C1ohPwLRT8pvtQXph9aLK2FMqTYIqQb0psyqIjznF9DbOjBDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522114; c=relaxed/simple;
	bh=V8hikXjTftw0cXBaUEV3kLVcBYfQoNmDC86IxHTVlsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIay2XZiL02Crb8i13Z24DIYpjxE25da2R/WLHAcFIs4GoKlYSL8a8JCYS9bTAawD+Ql4cIaLiXxzTPH/d9qJGHYl/siCR45UIS1CnguWVNWAzbBQV/mLpQiPrKPwTIc1/5IJUTg2wgROURwUvPAXb8kvwa5kse4FXe8OPw+p9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T9YXZA4S; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-472098e6e75so42971cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740522111; x=1741126911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU6IIXGWGh9H/ehdT9Qc/ulzK83hLj2Kl5Kcq106fII=;
        b=T9YXZA4SrxfPJNcdorf87P60efwr7zyVH61MqA+kGbNWXJJzgZrNNSWVa0dkjPm2RY
         XtK4B+0OADdqdMF2VT4JXAbEiUR7RXXAzQxcFjoSdRxffSIfWIwe/CYAIqZedGQ7zGt8
         ++Uesp+ldNZ4JJDy88przxkGs14ZknYubWUl1eCbs6P5hUwKdBk2U+Gd3Af14UAeRPwZ
         OMZd0bNMZZ5EeCs+O6nJrqEiKvgbR/qvdyx7nN18Vu3xKzOFlYB5Cva6NhI0pThlTyB5
         kGFhyrxa1KtOtIR7fvwmKeNslNodqdFnsX/aTImbsWnjVx+y9OJ0Ba0dWBL0mGltHfxX
         etWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522111; x=1741126911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU6IIXGWGh9H/ehdT9Qc/ulzK83hLj2Kl5Kcq106fII=;
        b=BKnSVrl8BXU3x1DIKN5AqUganfdZVej03gQQXfnRAFe4EM0J0uw/Ds5BplGn7Y/NN1
         QEUPhTKiXXhBUy7M6INkSr9uROXnX11OP05GDYfY7RVYneKZ9Xrm62jX2dzxW2LzOZzz
         ZwvGAfr9HudQuoKaeq12D/mnptpz1dSbg4UgZU7FV3M7Uf8lWe+/X+EFKzzzsUBUH2Wd
         FmcchPD2Zlr83H9jB9UyrSc35FPe7Z8Tg2e9HVdel5nLJslhwzMEjj/kfzQXE7dUwqcS
         yCAoLlfvJpYlgIuCs/kOErteXTP3/zEH/ibNFDuk/M9sRsC4lH/H3cwUFsR7ugb416Yk
         sMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvhGql2IvRZ6cJvmKOTUb1EGUi4o+WJ5fGaejDnDkR01w0bfjV9zaKMwqsmB7eQVfy2vCAMo6SuQ/ucjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBIze/JlsCxK1JUoVb/Rn2kS0IiW//yC2YlSPfGeo7WRsdiWvP
	OyHko7elyIZWA8ynKv3JDXaknAqY8YjW+woUts37LfMzTSnzfEwAXSRDlrviOkkutN412sTBior
	O4wNjQDjVcdUWNiHsPwdZYu39ITz44SHrqHxC
X-Gm-Gg: ASbGncuImzuwHBbPW0h29gFov0jsWn8baNrAjzf7sYYWfJsEW+qwz5c/k+kvkkvG5ns
	n/1+OXsR8Pf/iDMC3e2Sh0Je7+buD8T4g8slvnpMtVIgCtnaU+1Lea7q3fLmi3T4/8EjeOpDhpu
	TWi/4h8Ec=
X-Google-Smtp-Source: AGHT+IEq/AKzX+cYl7aJmSUqhtY1SddAAUnJW41lZVjVI/xrlYAHTtZS1Og5x8RQPWjaHO4K/43BSUS1zvjg+LAB+A4=
X-Received: by 2002:ac8:7f95:0:b0:471:f257:7a5f with SMTP id
 d75a77b69052e-47376e8f38cmr7477371cf.13.1740522111074; Tue, 25 Feb 2025
 14:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225204613.2316092-1-surenb@google.com> <Z7420bbHoz3y73xh@x1.local>
 <CAJuCfpGLcxSLNek7bUALKcg8HwF8vd9piaBf+cvjYRhY=xOfrA@mail.gmail.com>
In-Reply-To: <CAJuCfpGLcxSLNek7bUALKcg8HwF8vd9piaBf+cvjYRhY=xOfrA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 25 Feb 2025 14:21:39 -0800
X-Gm-Features: AWEUYZlr9psNh16uDKwukoh4oYDN-sgVhvIBloc0uSr9nmxcabIzsX5L3_guFh0
Message-ID: <CAJuCfpH8-LrNuK8xWHU9kGM7QjYqWBdjy1TKe4DuuPd1s+g11Q@mail.gmail.com>
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

On Tue, Feb 25, 2025 at 2:12=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Feb 25, 2025 at 1:32=E2=80=AFPM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > On Tue, Feb 25, 2025 at 12:46:13PM -0800, Suren Baghdasaryan wrote:
> > > Lokesh recently raised an issue about UFFDIO_MOVE getting into a dead=
lock
> > > state when it goes into split_folio() with raised folio refcount.
> > > split_folio() expects the reference count to be exactly
> > > mapcount + num_pages_in_folio + 1 (see can_split_folio()) and fails w=
ith
> > > EAGAIN otherwise. If multiple processes are trying to move the same
> > > large folio, they raise the refcount (all tasks succeed in that) then
> > > one of them succeeds in locking the folio, while others will block in
> > > folio_lock() while keeping the refcount raised. The winner of this
> > > race will proceed with calling split_folio() and will fail returning
> > > EAGAIN to the caller and unlocking the folio. The next competing proc=
ess
> > > will get the folio locked and will go through the same flow. In the
> > > meantime the original winner will be retried and will block in
> > > folio_lock(), getting into the queue of waiting processes only to rep=
eat
> > > the same path. All this results in a livelock.
> > > An easy fix would be to avoid waiting for the folio lock while holdin=
g
> > > folio refcount, similar to madvise_free_huge_pmd() where folio lock i=
s
> > > acquired before raising the folio refcount.
> > > Modify move_pages_pte() to try locking the folio first and if that fa=
ils
> > > and the folio is large then return EAGAIN without touching the folio
> > > refcount. If the folio is single-page then split_folio() is not calle=
d,
> > > so we don't have this issue.
> > > Lokesh has a reproducer [1] and I verified that this change fixes the
> > > issue.
> > >
> > > [1] https://github.com/lokeshgidra/uffd_move_ioctl_deadlock
> > >
> > > Reported-by: Lokesh Gidra <lokeshgidra@google.com>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> >
> > One question irrelevant of this change below..
> >
> > > ---
> > >  mm/userfaultfd.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index 867898c4e30b..f17f8290c523 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -1236,6 +1236,7 @@ static int move_pages_pte(struct mm_struct *mm,=
 pmd_t *dst_pmd, pmd_t *src_pmd,
> > >                */
> > >               if (!src_folio) {
> > >                       struct folio *folio;
> > > +                     bool locked;
> > >
> > >                       /*
> > >                        * Pin the page while holding the lock to be su=
re the
> > > @@ -1255,12 +1256,26 @@ static int move_pages_pte(struct mm_struct *m=
m, pmd_t *dst_pmd, pmd_t *src_pmd,
> > >                               goto out;
> > >                       }
> > >
> > > +                     locked =3D folio_trylock(folio);
> > > +                     /*
> > > +                      * We avoid waiting for folio lock with a raise=
d refcount
> > > +                      * for large folios because extra refcounts wil=
l result in
> > > +                      * split_folio() failing later and retrying. If=
 multiple
> > > +                      * tasks are trying to move a large folio we ca=
n end
> > > +                      * livelocking.
> > > +                      */
> > > +                     if (!locked && folio_test_large(folio)) {
> > > +                             spin_unlock(src_ptl);
> > > +                             err =3D -EAGAIN;
> > > +                             goto out;
> > > +                     }
> > > +
> > >                       folio_get(folio);
> > >                       src_folio =3D folio;
> > >                       src_folio_pte =3D orig_src_pte;
> > >                       spin_unlock(src_ptl);
> > >
> > > -                     if (!folio_trylock(src_folio)) {
> > > +                     if (!locked) {
> > >                               pte_unmap(&orig_src_pte);
> > >                               pte_unmap(&orig_dst_pte);
> >
> > .. just notice this.  Are these problematic?  I mean, orig_*_pte are st=
ack
> > variables, afaict.  I'd expect these things blow on HIGHPTE..
>
> Ugh! Yes, I think so. From a quick look, move_pages_pte() is the only
> place we have this issue and I don't see a reason for copying src_pte
> and dst_pte values. I'll spend some more time trying to understand if
> we really need these local copies.

Ah, we copy the values to later check if PTEs changed from under us.
But I see no reason we need to use orig_{src|dst}_pte instead of
{src|dst}_pte when doing pte_unmap(). I think we can safely replace
them with the original ones. WDYT?

>
> >
> > >                               src_pte =3D dst_pte =3D NULL;
> > >
> > > base-commit: 801d47bd96ce22acd43809bc09e004679f707c39
> > > --
> > > 2.48.1.658.g4767266eb4-goog
> > >
> >
> > --
> > Peter Xu
> >

