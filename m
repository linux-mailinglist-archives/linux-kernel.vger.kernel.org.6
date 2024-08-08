Return-Path: <linux-kernel+bounces-280129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117E294C626
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB75288131
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B378715921B;
	Thu,  8 Aug 2024 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sarLhQAV"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0521494CF
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150968; cv=none; b=tlRBxcE8Io3tsASO7mpCZmwHLRi1bDAyJyb2VXx7KiwFvpqqYUES7aMt1Ek/gMlqCczfdFy91XAVzymw6aFnhSU9oi+ylZWLeKA77NkSRKFYzo85TQ58qXH4ObmUGJ7hu4vRFB0lZ46vqdQKzEU6qi5x+wWIrsfW+Z6Is3mT0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150968; c=relaxed/simple;
	bh=VY51RKJYIhAtdHkkbjl1TUnGz6MpnqdBpmdAogXPmVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciGoGAqwFsg2xjz5SMuN4Igge9k1aCv+QDJlno2OOMFTNkvykV3XXtX+0N8QpvALvz0T+O4nTiafkfiirV8wsDSwicMPhXiA5+aEjPsCLk+F5tqqBsPdOO77UvecTGSBnrneZP4+Q6QxnQ1xxgnGaycjSCRO8pkCT7+UoNECA6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sarLhQAV; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-66ca5e8cc51so14862287b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 14:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723150966; x=1723755766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK0xxjAchJmTqLyqblW6a1BSUgp4bmsDLqA1sO88AlI=;
        b=sarLhQAVLE8uktbsXhTZZNnq6BXniCGMm5LkzfXZ5IpeudAIOLliMC1Hcp0e02BI9i
         e/xVmTwgL6RhtjnzeXsOUV2tjMg04aU8o8yEJUDP9iEzGNvswJyG1Kyp+RXPcaFMMOVR
         oKZWURTj5qVStR7dWoL6/T5krUKJm9yrMcmwUxOSR8Wloxllao/2twxI7/Gj1biwi6iE
         FywxYIK9zlg3hSVwEM57s32aEEUFkuDNLnZQiyG3LiV4AhpAjWYFQiMn/TOmgUfauiRf
         e4fBxOH5iMgRp76OTsRBuQ10KDE+gwqGapY6GXa0WBKpvls5Kk9s7PdkpXoyo60cZtDp
         yLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723150966; x=1723755766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VK0xxjAchJmTqLyqblW6a1BSUgp4bmsDLqA1sO88AlI=;
        b=Slc1GpQETYy8dhAC2AVVJTE7MiN+0rwECv4SaQQlU3ShJ32ldLq8ESenqb3jbi+PzM
         0oekA+H4opds2svi3tb8nCS2LCbIseU8gGv/VnLMULBRk0qP+vtUL0HbVS3ilF3dNOT8
         AsJ0FXkTnkzCv6TFaoBEV90Mbrq6qZuYXbP4UCzzlbf02yN3uoZ7KpE4kHepsl2Z6Joo
         wEE6jAUzNnjQzIXYfGxMixasFyZnjE8bL9q5MF/zNT91d/CF6Qv4Z/E8YbhGYfA1HO7Z
         sKM+46ufjqO6/30NYKdubJqJi0PVj0J4R2cHn7g5DeOpcMxyDHARSl+xMJjPt1cClvoj
         Ciqg==
X-Forwarded-Encrypted: i=1; AJvYcCU1yWkEVCp9H60jnI1vnV14vJwMq77B6/z4ynoR9L4WWWLHj6aAsxqwLtwM7Hk10u/UKDSIUyVGTxfuYMWCPw3rV7pbgm61p4AjsTrR
X-Gm-Message-State: AOJu0YzeArh/XJ6+USuXUSAsSCJtqExiVYIgY1kvQxsSjFJWat13eLF7
	nXDk0exb8Mt9JghfovWruNBbIq+jCFCl6O76VdPOEVJ8/RSYIZ//x7QqBj6k+Td3fySkdtdZzYv
	AutPiSrnyJncwODmZceximY0texfbAEEWSUz+
X-Google-Smtp-Source: AGHT+IEtGpSOUY+7BEqAMsrA6RDC+KM1NYPNuRKKblL87JlMO05gMjbAol7QNVp6PBC4L80ueZKGVTxHTa6ugxo2rps=
X-Received: by 2002:a05:690c:618a:b0:64b:2cf2:391c with SMTP id
 00721157ae682-69bf81ddd67mr29616357b3.18.1723150965620; Thu, 08 Aug 2024
 14:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807182325.2585582-1-surenb@google.com> <CAEf4BzaocU-CQsFZ=s5gDM6XQ0Foss_HroFsPUesBn=qgJCprg@mail.gmail.com>
In-Reply-To: <CAEf4BzaocU-CQsFZ=s5gDM6XQ0Foss_HroFsPUesBn=qgJCprg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 8 Aug 2024 21:02:32 +0000
Message-ID: <CAJuCfpHsvhjYxj=aovZjTd2qUvJWHpcnEn1kYfd0m23HVrPwDg@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 8:19=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 7, 2024 at 11:23=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > Add helper functions to speculatively perform operations without
> > read-locking mmap_lock, expecting that mmap_lock will not be
> > write-locked and mm is not modified from under us.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > ---
>
> This change makes sense and makes mm's seq a bit more useful and
> meaningful. I've also tested it locally with uprobe stress-test, and
> it seems to work great, I haven't run into any problems with a
> multi-hour stress test run so far. Thanks!

Thanks for testing and feel free to include this patch into your set.

I've been thinking about this some more and there is a very unlikely
corner case if between mmap_lock_speculation_start() and
mmap_lock_speculation_end() mmap_lock is write-locked/unlocked so many
times that mm->mm_lock_seq (int) overflows and just happen to reach
the same value as we recorded in mmap_lock_speculation_start(). This
would generate a false positive, which would show up as if the
mmap_lock was never touched. Such overflows are possible for vm_lock
as well (see: https://elixir.bootlin.com/linux/v6.10.3/source/include/linux=
/mm_types.h#L688)
but they are not critical because a false result would simply lead to
a retry under mmap_lock. However for your case this would be a
critical issue. This is an extremely low probability scenario but
should we still try to handle it?

I'm CC'ing several mm folks and Jann Horn to chime in.

>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> > Discussion [1] follow-up. If proves to be useful can be included in tha=
t
> > patchset. Based on mm-unstable.
> >
> > [1] https://lore.kernel.org/all/20240730134605.GO33588@noisy.programmin=
g.kicks-ass.net/
> >
> >  include/linux/mm_types.h  |  3 +++
> >  include/linux/mmap_lock.h | 53 +++++++++++++++++++++++++++++++--------
> >  kernel/fork.c             |  3 ---
> >  3 files changed, 46 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 003619fab20e..a426e6ced604 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -887,6 +887,9 @@ struct mm_struct {
> >                  * Roughly speaking, incrementing the sequence number i=
s
> >                  * equivalent to releasing locks on VMAs; reading the s=
equence
> >                  * number can be part of taking a read lock on a VMA.
> > +                * Incremented every time mmap_lock is write-locked/unl=
ocked.
> > +                * Initialized to 0, therefore odd values indicate mmap=
_lock
> > +                * is write-locked and even values that it's released.
> >                  *
> >                  * Can be modified under write mmap_lock using RELEASE
> >                  * semantics.
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index de9dc20b01ba..5410ce741d75 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -71,15 +71,12 @@ static inline void mmap_assert_write_locked(const s=
truct mm_struct *mm)
> >  }
> >
> >  #ifdef CONFIG_PER_VMA_LOCK
> > -/*
> > - * Drop all currently-held per-VMA locks.
> > - * This is called from the mmap_lock implementation directly before re=
leasing
> > - * a write-locked mmap_lock (or downgrading it to read-locked).
> > - * This should normally NOT be called manually from other places.
> > - * If you want to call this manually anyway, keep in mind that this wi=
ll release
> > - * *all* VMA write locks, including ones from further up the stack.
> > - */
> > -static inline void vma_end_write_all(struct mm_struct *mm)
> > +static inline void init_mm_lock_seq(struct mm_struct *mm)
> > +{
> > +       mm->mm_lock_seq =3D 0;
> > +}
> > +
> > +static inline void inc_mm_lock_seq(struct mm_struct *mm)
> >  {
> >         mmap_assert_write_locked(mm);
> >         /*
> > @@ -91,19 +88,52 @@ static inline void vma_end_write_all(struct mm_stru=
ct *mm)
> >          */
> >         smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
> >  }
> > +
> > +static inline bool mmap_lock_speculation_start(struct mm_struct *mm, i=
nt *seq)
> > +{
> > +       /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> > +       *seq =3D smp_load_acquire(&mm->mm_lock_seq);
> > +       /* Allow speculation if mmap_lock is not write-locked */
> > +       return (*seq & 1) =3D=3D 0;
> > +}
> > +
> > +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int=
 seq)
> > +{
> > +       /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> > +       return seq =3D=3D smp_load_acquire(&mm->mm_lock_seq);
> > +}
> > +
> >  #else
> > -static inline void vma_end_write_all(struct mm_struct *mm) {}
> > +static inline void init_mm_lock_seq(struct mm_struct *mm) {}
> > +static inline void inc_mm_lock_seq(struct mm_struct *mm) {}
> > +static inline bool mmap_lock_speculation_start(struct mm_struct *mm, i=
nt *seq) { return false; }
> > +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int=
 seq) { return false; }
> >  #endif
> >
> > +/*
> > + * Drop all currently-held per-VMA locks.
> > + * This is called from the mmap_lock implementation directly before re=
leasing
> > + * a write-locked mmap_lock (or downgrading it to read-locked).
> > + * This should normally NOT be called manually from other places.
> > + * If you want to call this manually anyway, keep in mind that this wi=
ll release
> > + * *all* VMA write locks, including ones from further up the stack.
> > + */
> > +static inline void vma_end_write_all(struct mm_struct *mm)
> > +{
> > +       inc_mm_lock_seq(mm);
> > +}
> > +
> >  static inline void mmap_init_lock(struct mm_struct *mm)
> >  {
> >         init_rwsem(&mm->mmap_lock);
> > +       init_mm_lock_seq(mm);
> >  }
> >
> >  static inline void mmap_write_lock(struct mm_struct *mm)
> >  {
> >         __mmap_lock_trace_start_locking(mm, true);
> >         down_write(&mm->mmap_lock);
> > +       inc_mm_lock_seq(mm);
> >         __mmap_lock_trace_acquire_returned(mm, true, true);
> >  }
> >
> > @@ -111,6 +141,7 @@ static inline void mmap_write_lock_nested(struct mm=
_struct *mm, int subclass)
> >  {
> >         __mmap_lock_trace_start_locking(mm, true);
> >         down_write_nested(&mm->mmap_lock, subclass);
> > +       inc_mm_lock_seq(mm);
> >         __mmap_lock_trace_acquire_returned(mm, true, true);
> >  }
> >
> > @@ -120,6 +151,8 @@ static inline int mmap_write_lock_killable(struct m=
m_struct *mm)
> >
> >         __mmap_lock_trace_start_locking(mm, true);
> >         ret =3D down_write_killable(&mm->mmap_lock);
> > +       if (!ret)
> > +               inc_mm_lock_seq(mm);
> >         __mmap_lock_trace_acquire_returned(mm, true, ret =3D=3D 0);
> >         return ret;
> >  }
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 3d590e51ce84..73e37af8a24d 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1259,9 +1259,6 @@ static struct mm_struct *mm_init(struct mm_struct=
 *mm, struct task_struct *p,
> >         seqcount_init(&mm->write_protect_seq);
> >         mmap_init_lock(mm);
> >         INIT_LIST_HEAD(&mm->mmlist);
> > -#ifdef CONFIG_PER_VMA_LOCK
> > -       mm->mm_lock_seq =3D 0;
> > -#endif
> >         mm_pgtables_bytes_init(mm);
> >         mm->map_count =3D 0;
> >         mm->locked_vm =3D 0;
> >
> > base-commit: 98808d08fc0f78ee638e0c0a88020fbbaf581ec6
> > --
> > 2.46.0.rc2.264.g509ed76dc8-goog
> >

