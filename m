Return-Path: <linux-kernel+bounces-280133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F1394C62E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BEF283DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DB8156C40;
	Thu,  8 Aug 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYN1vycW"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873D11487FE
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723151519; cv=none; b=YrS13+R7H82/qkE4CnuHyD/c8GUw7WLOURaWhRGdnpwq+xJ25HI+1jPU8ZvPgEUwkQ/ChKWEPC9vcl74nSFcHtkdM0guZHoXgwqG5OtSNP86tgdXcXw4w95//9HFhhGkbavja1pnaHKIT256CPNRflC8+8SzScR9AN/K8nxFzYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723151519; c=relaxed/simple;
	bh=k6iJ5yBjYG1uDxzIHGXkucPmnu4WitUh8rq829qarNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdN1l9xsun7pzdr204+xSY9Z3vzYyfhwOp0mm/COMeJiPYxIJywbvy7seAgyVLd+cLcX0+qclQjwTDnI/WK/D1CHWLCVM8EurzKTcw/pY/C5Bxyi4DikeVUz56JiUNg8fcr0AZAWP0t4SuL/JDyMz1cdBpFtm+iNg0wHXwtVhx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYN1vycW; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso2515051e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 14:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723151515; x=1723756315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8evJkR69sPV/KRCSOPqEBKgOd9wCQjS5v2YcO5rlL1g=;
        b=cYN1vycWDwmlgWAZpwSuMzL6a8b2nh1BNiZYgMzo+NG75TUETA0c1gG+En3NlxLJcI
         3T7DmV2AxC3pRf61ZAF0xuwG1yg4T7CK13nSxZpkMY/4p2k0tv8deSLFoNHqMD2BPrwq
         XxjGw8QCNkusDvq++vWdHkvK7CQa3Ve6YA+EvqHlU8W4AI4HLsE5pf1F9LkKmARdniVg
         g/bNghYiVYJAIrtBv0NTUQq21ecCrufcvjJxiqJhNhvfuahcJXorO8RUHngxjwNuV8uK
         z4sy/n0CAb9OJrpYtiuDWTAvcSCp6qkiEx76/+8E6T2VKUuX8cqmXqD9Klnsg8DghcLd
         biZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723151515; x=1723756315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8evJkR69sPV/KRCSOPqEBKgOd9wCQjS5v2YcO5rlL1g=;
        b=Zuo8W2nGJPE2Lx0eHduLSusLEuoJdV/SriiA0NavkzvcI66Y1lUzx0Id6zQPwMBFRQ
         P4Na2ZTQhrkeRmnGDU4XJ+QlehHbleC6AyU5F9oITH/kCoR7JlG0sud0DfUsJYLArBtM
         ZjutM4ElH/x1mO7GXHPfZYX6KRp/c2nhnD6KwhtZTC7FP7cZbZanlSU3wbrJJOJDMoOm
         v8m2JoHAw31qAdm66nUxeyBZC8CQC9l/gA3rkElQX7+Upci+Zy8gk0w+SxcQFGT/z3GI
         etcwRXsJ+z5IqDWNWFjq+Q/xArTYiFmfLMypv5DSBdVdBdXxaB8Z1FAoLi6XlFf+qLHY
         JgOg==
X-Forwarded-Encrypted: i=1; AJvYcCV2RzJHDVVUsOgB4tW1/xr+WqnZaMM8h0a3vP3+hirz2D+8Tb5J9d9xrjfVqXu7qOSRs18bUN4jWpA/2Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8FQHioZxATIs9Urv04GxjFh3busPvRu/j2UiGbPk+TXQ5O2w
	vWx89PoNwBbp7E/3w9+Y+U4O9WusE1rI2kMK40H830ZbzNmBgHaRj9Jc+PpHUd3s+i83/QEIQzz
	LIAqaZYb3tmuCWxcmGxtqVL3S0dw=
X-Google-Smtp-Source: AGHT+IGC7XvQ9WqG1TKyA8QJMF9wu8iQyRy1rsF4xmNcCm6iwESG4HbLGhx0u1eJxtkBZFWajniUuy9uvkXNPzKeNSI=
X-Received: by 2002:a05:6512:b9b:b0:52c:e05f:9052 with SMTP id
 2adb3069b0e04-530e5876975mr2886465e87.47.1723151515133; Thu, 08 Aug 2024
 14:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807182325.2585582-1-surenb@google.com> <CAEf4BzaocU-CQsFZ=s5gDM6XQ0Foss_HroFsPUesBn=qgJCprg@mail.gmail.com>
 <CAJuCfpHsvhjYxj=aovZjTd2qUvJWHpcnEn1kYfd0m23HVrPwDg@mail.gmail.com>
In-Reply-To: <CAJuCfpHsvhjYxj=aovZjTd2qUvJWHpcnEn1kYfd0m23HVrPwDg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Aug 2024 14:11:37 -0700
Message-ID: <CAEf4BzYqKAaGE6GEcMs9MTcrV4cA+i0M5pniqFTy1LQ+g0Yxkw@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:02=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Thu, Aug 8, 2024 at 8:19=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Aug 7, 2024 at 11:23=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > Add helper functions to speculatively perform operations without
> > > read-locking mmap_lock, expecting that mmap_lock will not be
> > > write-locked and mm is not modified from under us.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > ---
> >
> > This change makes sense and makes mm's seq a bit more useful and
> > meaningful. I've also tested it locally with uprobe stress-test, and
> > it seems to work great, I haven't run into any problems with a
> > multi-hour stress test run so far. Thanks!
>
> Thanks for testing and feel free to include this patch into your set.

Will do!

>
> I've been thinking about this some more and there is a very unlikely
> corner case if between mmap_lock_speculation_start() and
> mmap_lock_speculation_end() mmap_lock is write-locked/unlocked so many
> times that mm->mm_lock_seq (int) overflows and just happen to reach
> the same value as we recorded in mmap_lock_speculation_start(). This
> would generate a false positive, which would show up as if the
> mmap_lock was never touched. Such overflows are possible for vm_lock
> as well (see: https://elixir.bootlin.com/linux/v6.10.3/source/include/lin=
ux/mm_types.h#L688)
> but they are not critical because a false result would simply lead to
> a retry under mmap_lock. However for your case this would be a
> critical issue. This is an extremely low probability scenario but
> should we still try to handle it?
>

No, I think it's fine. Similar problems could happen with refcount_t,
for instance (it has a logic to have a sticky "has overflown" state,
which I believe relies on the fact that we'll never be able to
increment refcount 2bln+ times in between some resetting logic).
Anyways, I think it's utterly unrealistic and should be considered
impossible.



> I'm CC'ing several mm folks and Jann Horn to chime in.
>
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > > Discussion [1] follow-up. If proves to be useful can be included in t=
hat
> > > patchset. Based on mm-unstable.
> > >
> > > [1] https://lore.kernel.org/all/20240730134605.GO33588@noisy.programm=
ing.kicks-ass.net/
> > >
> > >  include/linux/mm_types.h  |  3 +++
> > >  include/linux/mmap_lock.h | 53 +++++++++++++++++++++++++++++++------=
--
> > >  kernel/fork.c             |  3 ---
> > >  3 files changed, 46 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 003619fab20e..a426e6ced604 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -887,6 +887,9 @@ struct mm_struct {
> > >                  * Roughly speaking, incrementing the sequence number=
 is
> > >                  * equivalent to releasing locks on VMAs; reading the=
 sequence
> > >                  * number can be part of taking a read lock on a VMA.
> > > +                * Incremented every time mmap_lock is write-locked/u=
nlocked.
> > > +                * Initialized to 0, therefore odd values indicate mm=
ap_lock
> > > +                * is write-locked and even values that it's released=
.
> > >                  *
> > >                  * Can be modified under write mmap_lock using RELEAS=
E
> > >                  * semantics.
> > > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > > index de9dc20b01ba..5410ce741d75 100644
> > > --- a/include/linux/mmap_lock.h
> > > +++ b/include/linux/mmap_lock.h
> > > @@ -71,15 +71,12 @@ static inline void mmap_assert_write_locked(const=
 struct mm_struct *mm)
> > >  }
> > >
> > >  #ifdef CONFIG_PER_VMA_LOCK
> > > -/*
> > > - * Drop all currently-held per-VMA locks.
> > > - * This is called from the mmap_lock implementation directly before =
releasing
> > > - * a write-locked mmap_lock (or downgrading it to read-locked).
> > > - * This should normally NOT be called manually from other places.
> > > - * If you want to call this manually anyway, keep in mind that this =
will release
> > > - * *all* VMA write locks, including ones from further up the stack.
> > > - */
> > > -static inline void vma_end_write_all(struct mm_struct *mm)
> > > +static inline void init_mm_lock_seq(struct mm_struct *mm)
> > > +{
> > > +       mm->mm_lock_seq =3D 0;
> > > +}
> > > +
> > > +static inline void inc_mm_lock_seq(struct mm_struct *mm)
> > >  {
> > >         mmap_assert_write_locked(mm);
> > >         /*
> > > @@ -91,19 +88,52 @@ static inline void vma_end_write_all(struct mm_st=
ruct *mm)
> > >          */
> > >         smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
> > >  }
> > > +
> > > +static inline bool mmap_lock_speculation_start(struct mm_struct *mm,=
 int *seq)
> > > +{
> > > +       /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> > > +       *seq =3D smp_load_acquire(&mm->mm_lock_seq);
> > > +       /* Allow speculation if mmap_lock is not write-locked */
> > > +       return (*seq & 1) =3D=3D 0;
> > > +}
> > > +
> > > +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, i=
nt seq)
> > > +{
> > > +       /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> > > +       return seq =3D=3D smp_load_acquire(&mm->mm_lock_seq);
> > > +}
> > > +
> > >  #else
> > > -static inline void vma_end_write_all(struct mm_struct *mm) {}
> > > +static inline void init_mm_lock_seq(struct mm_struct *mm) {}
> > > +static inline void inc_mm_lock_seq(struct mm_struct *mm) {}
> > > +static inline bool mmap_lock_speculation_start(struct mm_struct *mm,=
 int *seq) { return false; }
> > > +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, i=
nt seq) { return false; }
> > >  #endif
> > >
> > > +/*
> > > + * Drop all currently-held per-VMA locks.
> > > + * This is called from the mmap_lock implementation directly before =
releasing
> > > + * a write-locked mmap_lock (or downgrading it to read-locked).
> > > + * This should normally NOT be called manually from other places.
> > > + * If you want to call this manually anyway, keep in mind that this =
will release
> > > + * *all* VMA write locks, including ones from further up the stack.
> > > + */
> > > +static inline void vma_end_write_all(struct mm_struct *mm)
> > > +{
> > > +       inc_mm_lock_seq(mm);
> > > +}
> > > +
> > >  static inline void mmap_init_lock(struct mm_struct *mm)
> > >  {
> > >         init_rwsem(&mm->mmap_lock);
> > > +       init_mm_lock_seq(mm);
> > >  }
> > >
> > >  static inline void mmap_write_lock(struct mm_struct *mm)
> > >  {
> > >         __mmap_lock_trace_start_locking(mm, true);
> > >         down_write(&mm->mmap_lock);
> > > +       inc_mm_lock_seq(mm);
> > >         __mmap_lock_trace_acquire_returned(mm, true, true);
> > >  }
> > >
> > > @@ -111,6 +141,7 @@ static inline void mmap_write_lock_nested(struct =
mm_struct *mm, int subclass)
> > >  {
> > >         __mmap_lock_trace_start_locking(mm, true);
> > >         down_write_nested(&mm->mmap_lock, subclass);
> > > +       inc_mm_lock_seq(mm);
> > >         __mmap_lock_trace_acquire_returned(mm, true, true);
> > >  }
> > >
> > > @@ -120,6 +151,8 @@ static inline int mmap_write_lock_killable(struct=
 mm_struct *mm)
> > >
> > >         __mmap_lock_trace_start_locking(mm, true);
> > >         ret =3D down_write_killable(&mm->mmap_lock);
> > > +       if (!ret)
> > > +               inc_mm_lock_seq(mm);
> > >         __mmap_lock_trace_acquire_returned(mm, true, ret =3D=3D 0);
> > >         return ret;
> > >  }
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 3d590e51ce84..73e37af8a24d 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -1259,9 +1259,6 @@ static struct mm_struct *mm_init(struct mm_stru=
ct *mm, struct task_struct *p,
> > >         seqcount_init(&mm->write_protect_seq);
> > >         mmap_init_lock(mm);
> > >         INIT_LIST_HEAD(&mm->mmlist);
> > > -#ifdef CONFIG_PER_VMA_LOCK
> > > -       mm->mm_lock_seq =3D 0;
> > > -#endif
> > >         mm_pgtables_bytes_init(mm);
> > >         mm->map_count =3D 0;
> > >         mm->locked_vm =3D 0;
> > >
> > > base-commit: 98808d08fc0f78ee638e0c0a88020fbbaf581ec6
> > > --
> > > 2.46.0.rc2.264.g509ed76dc8-goog
> > >

