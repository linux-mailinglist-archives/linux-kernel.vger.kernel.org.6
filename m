Return-Path: <linux-kernel+bounces-532675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9461A450C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E0B3ADB38
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280D0234972;
	Tue, 25 Feb 2025 23:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1e8WmFGB"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C801D2343CF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740524525; cv=none; b=kvTRBCpN8bMrr+ttOZxR+aSwhZE/ARZgtVO5IIPoOSvjoSJSALGjUJZ+NXkCI4XxysAYuneQFPXuCRLPY6y1F8ICxSZv8lXLx+De0I7Axt6m7XApOO89B+bJ92gVUdycfJ8Mt/RvpIlIA4U9Onbt0TK4yH7OOufwdujOUwnOgTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740524525; c=relaxed/simple;
	bh=LFh47qigWMioDnyyfJlCQl0dGLyFl626HCcephHY9jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWZH7blUvMboRE9orW+/IV5o5fZhc0x6F899ryM4Ueh0zXV69+fT0gsGeOgUifIXWha1fCkxykJu3mCOt2x880+yPAAEstA11cQs1Uv7uUfOceFHrWIiJqChgm5ZPGDTKXP8sOZDvTRHgJfPW5xKGXJqs7fzpCAYz2fHMWJ3K1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1e8WmFGB; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471fbfe8b89so123071cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740524523; x=1741129323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kd1Nij5gJveAu0p82tAMdHKM3qEfEzzG4Cog3zXWzXA=;
        b=1e8WmFGBZm0a+u4b1UojONsa5y//uGIBB/c6Z707PuzQU+6cARbbwA1zn1qH+qmbF5
         PP1CPHi04hb/ewdfI6minMc6r4iqsNQMok4CNgUAMXOndCKlHMj02lRGXzXj/V9hEqey
         x8lmIMTQFL6u71bM1n1tChpiziGsh6MP+82ptSRzKQ4wSL0u/F8hYAxKZ7J2zTftSIJK
         V1bH+nQIW9vXcxxHsL2rWJGmEiYsQW4h6gw5DjUhNA5jjZXC+33mqZk97y0jOuXLnUGq
         TyENi+l34eUXiojaOnqawJIYweuQW8BH7J4Oql1RkFR5Y/zDOXWX+ejfvvhnI4/njgkQ
         KaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740524523; x=1741129323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kd1Nij5gJveAu0p82tAMdHKM3qEfEzzG4Cog3zXWzXA=;
        b=b/OyjAFvg07/GHIAR8WZB03A5DkubQMtvCRDDzQMAopS0wkZ40Oj0f69ayk/vETVqh
         8P7s7lAANH6vAYGHc8BcANiwUQKvbob+xLvBqKxYvhq0MOpN7ucKGKqEWuWUNSB2xAdW
         JAsyhDXaYmNGAu2097fSDQEBGWbbHYVkki9AcStQperBG1iPE1FfFf4NqLaXdJ+zuXbu
         tML9v1gTi2kUpLTBFym9dyGab+7Yf+k2HdJ511uFD/xsUyDX9TEhrxVNiGeD7RrXWYpo
         DZfVLIhm/Vz/tEg/1g8Yy590gLNWddZuCOG4HNCrcGXqxx/TjUvHdh3TEbkmSWqkK2Z2
         r5hw==
X-Forwarded-Encrypted: i=1; AJvYcCXZeQXL/Mm3c3sJfcwWYmOiap7gZ0Z6+UypM2ffzXbLNyrfYxxnbWMFrGznf3uAdNQrPwS5pfPaEqKav38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwywUQrEdGZYNS1XgCzcWqdXXL+mF2G81M0slKuZLMK9s8BkFDd
	BPa29rCnR3qwncJQ+7uFC3u1zxlc0BwFEmubjl3SL3wACoWAqoYg8P6ivWApnnJfv5+Vl5DiyAf
	clpO9ZzwidiuXSR65TaKLYz7G8rTF91XzBb8I
X-Gm-Gg: ASbGncvxjirIhRLo4WyqSXuX7h5IfUW60hVevYT1+FEVFpT7XG9LOBtwl+nC4CXUXaa
	fF/GI1ALExmqpTF3LLveSV62AsLtpVYVuLoegfVQSl3eYBFwH0dxY64RV2rrVMyVTZaL1TVdmEm
	sTGZWHMPg=
X-Google-Smtp-Source: AGHT+IHNcfZONBUsPiWpz7/dLowm3QuSIStBlzrnCQaqMToc2xzjWKryrZw7PgO4lZLHv3ILKXVJghpiQDpmbyaVgKQ=
X-Received: by 2002:a05:622a:148c:b0:466:8887:6751 with SMTP id
 d75a77b69052e-47376fd259emr6843411cf.23.1740524522204; Tue, 25 Feb 2025
 15:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225204613.2316092-1-surenb@google.com> <Z7420bbHoz3y73xh@x1.local>
 <CAJuCfpGLcxSLNek7bUALKcg8HwF8vd9piaBf+cvjYRhY=xOfrA@mail.gmail.com>
 <CAJuCfpH8-LrNuK8xWHU9kGM7QjYqWBdjy1TKe4DuuPd1s+g11Q@mail.gmail.com> <Z75Ix6eXr972N5y6@x1.local>
In-Reply-To: <Z75Ix6eXr972N5y6@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 25 Feb 2025 15:01:51 -0800
X-Gm-Features: AWEUYZn2vSga4IwLqX-ZbjEm0R09IHHwmNRv7QsIRiRNt58lbeTeDFxK9a6YzoQ
Message-ID: <CAJuCfpGKVRNgdRF=uZEvd6_gSSdR5jZRO1mXTMPAFSv2YrmFxA@mail.gmail.com>
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

On Tue, Feb 25, 2025 at 2:48=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Feb 25, 2025 at 02:21:39PM -0800, Suren Baghdasaryan wrote:
> > On Tue, Feb 25, 2025 at 2:12=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Tue, Feb 25, 2025 at 1:32=E2=80=AFPM Peter Xu <peterx@redhat.com> =
wrote:
> > > >
> > > > On Tue, Feb 25, 2025 at 12:46:13PM -0800, Suren Baghdasaryan wrote:
> > > > > Lokesh recently raised an issue about UFFDIO_MOVE getting into a =
deadlock
> > > > > state when it goes into split_folio() with raised folio refcount.
> > > > > split_folio() expects the reference count to be exactly
> > > > > mapcount + num_pages_in_folio + 1 (see can_split_folio()) and fai=
ls with
> > > > > EAGAIN otherwise. If multiple processes are trying to move the sa=
me
> > > > > large folio, they raise the refcount (all tasks succeed in that) =
then
> > > > > one of them succeeds in locking the folio, while others will bloc=
k in
> > > > > folio_lock() while keeping the refcount raised. The winner of thi=
s
> > > > > race will proceed with calling split_folio() and will fail return=
ing
> > > > > EAGAIN to the caller and unlocking the folio. The next competing =
process
> > > > > will get the folio locked and will go through the same flow. In t=
he
> > > > > meantime the original winner will be retried and will block in
> > > > > folio_lock(), getting into the queue of waiting processes only to=
 repeat
> > > > > the same path. All this results in a livelock.
> > > > > An easy fix would be to avoid waiting for the folio lock while ho=
lding
> > > > > folio refcount, similar to madvise_free_huge_pmd() where folio lo=
ck is
> > > > > acquired before raising the folio refcount.
> > > > > Modify move_pages_pte() to try locking the folio first and if tha=
t fails
> > > > > and the folio is large then return EAGAIN without touching the fo=
lio
> > > > > refcount. If the folio is single-page then split_folio() is not c=
alled,
> > > > > so we don't have this issue.
> > > > > Lokesh has a reproducer [1] and I verified that this change fixes=
 the
> > > > > issue.
> > > > >
> > > > > [1] https://github.com/lokeshgidra/uffd_move_ioctl_deadlock
> > > > >
> > > > > Reported-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > >
> > > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > >
> > > > One question irrelevant of this change below..
> > > >
> > > > > ---
> > > > >  mm/userfaultfd.c | 17 ++++++++++++++++-
> > > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > index 867898c4e30b..f17f8290c523 100644
> > > > > --- a/mm/userfaultfd.c
> > > > > +++ b/mm/userfaultfd.c
> > > > > @@ -1236,6 +1236,7 @@ static int move_pages_pte(struct mm_struct =
*mm, pmd_t *dst_pmd, pmd_t *src_pmd,
> > > > >                */
> > > > >               if (!src_folio) {
> > > > >                       struct folio *folio;
> > > > > +                     bool locked;
> > > > >
> > > > >                       /*
> > > > >                        * Pin the page while holding the lock to b=
e sure the
> > > > > @@ -1255,12 +1256,26 @@ static int move_pages_pte(struct mm_struc=
t *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
> > > > >                               goto out;
> > > > >                       }
> > > > >
> > > > > +                     locked =3D folio_trylock(folio);
> > > > > +                     /*
> > > > > +                      * We avoid waiting for folio lock with a r=
aised refcount
> > > > > +                      * for large folios because extra refcounts=
 will result in
> > > > > +                      * split_folio() failing later and retrying=
. If multiple
> > > > > +                      * tasks are trying to move a large folio w=
e can end
> > > > > +                      * livelocking.
> > > > > +                      */
> > > > > +                     if (!locked && folio_test_large(folio)) {
> > > > > +                             spin_unlock(src_ptl);
> > > > > +                             err =3D -EAGAIN;
> > > > > +                             goto out;
> > > > > +                     }
> > > > > +
> > > > >                       folio_get(folio);
> > > > >                       src_folio =3D folio;
> > > > >                       src_folio_pte =3D orig_src_pte;
> > > > >                       spin_unlock(src_ptl);
> > > > >
> > > > > -                     if (!folio_trylock(src_folio)) {
> > > > > +                     if (!locked) {
> > > > >                               pte_unmap(&orig_src_pte);
> > > > >                               pte_unmap(&orig_dst_pte);
> > > >
> > > > .. just notice this.  Are these problematic?  I mean, orig_*_pte ar=
e stack
> > > > variables, afaict.  I'd expect these things blow on HIGHPTE..
> > >
> > > Ugh! Yes, I think so. From a quick look, move_pages_pte() is the only
> > > place we have this issue and I don't see a reason for copying src_pte
> > > and dst_pte values. I'll spend some more time trying to understand if
> > > we really need these local copies.
> >
> > Ah, we copy the values to later check if PTEs changed from under us.
> > But I see no reason we need to use orig_{src|dst}_pte instead of
> > {src|dst}_pte when doing pte_unmap(). I think we can safely replace
>
> That looks like something we just overlooked before, meanwhile it's
> undetectable on !HIGHPTE anyway.. in which case the addr ignored, and tha=
t
> turns always into an rcu unlock.
>
> > them with the original ones. WDYT?
>
> Agreed.  Maybe not "the original ones" if we're looking for words to put
> into the commit message: it could be "we should kunmap() whatever we
> kmap()ed before", or something better.

Sounds good to me. I'll give others one day to provide their input and
will post a fix.
Thanks!

>
> Thanks,
>
> --
> Peter Xu
>

