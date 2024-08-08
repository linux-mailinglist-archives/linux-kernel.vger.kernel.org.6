Return-Path: <linux-kernel+bounces-280091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BF394C590
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BAD42810EA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF76156237;
	Thu,  8 Aug 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtWoMhI3"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EDF155A25
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148346; cv=none; b=FxpGJBg9ThYkvCL03BgdvSQEgFDXyv9cwi+YuSAPyuK1LgQbrjHUY26FKvKHDjegzHQMTjVKyPbwoeYHqY//ROk4WIW3YE+CPrNHI2bnhvJZ61jAUXG4dedXvpXDHVvG0ecmHOIYQNbVhU9ynbChQyhgNlzJzB8O/xzrFo2roeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148346; c=relaxed/simple;
	bh=IS8W1wSJT1mxumUiwbXlNLchbOmr2nOSgImW/nGa8fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uG0MoXWdP67EJpcULBGgDheO9YxHqmqVx4LFq7KZbog/NTDINz3AQPrVwGHPOlN2e9Fpebtq2xyQjyngoJKXSAuMci0M/XIdI6WQ0KFo2DXAcUyuat7waWXwj5UmzqUA+n1FhFUamutSu3zLbwzBfBER3uCAyI4bBjF6AHxIL/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtWoMhI3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso146024266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723148343; x=1723753143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crPwGeOrxjPFHaDXHUZYSxmf8c7pkDPQAJXPSd+ORLU=;
        b=TtWoMhI3/YF64xYHq45IzMCh4NSFl3jAHjZzPkPdaDa9xmVRGrkgfqtmYbguhZs/3x
         dnRtfptvQmP99H0hpFw4FLrcID9oAlDo0lOlh323Vy3tNkjX7BuYKgtqXrXVXxyjNkn6
         Pfl4OCvvI+0kayd4yz4TeXStNlBhdxNUf7YaWf+/Ij6/DNueyeu0WQnCqm5e4ecjI+NH
         /JicUv6i4pcb3mM1p9aPi8DQ2GfqXTn9mVfYr4wft+GgfTXh8gmsorj8MyalN7+amilo
         mWBEBaq2/zXlkid6wYJaWh+pCFx2SPWv34dXERYrR+UaMnj03BMfZ5n+Siy+SHalHwZH
         EMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723148343; x=1723753143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crPwGeOrxjPFHaDXHUZYSxmf8c7pkDPQAJXPSd+ORLU=;
        b=mpieH1ieqpZ3yxXZ3b7YQfE18gUqvDG5tUjRK3pMj51y+OzYQZ2a3CTW618sHNJ1aw
         +d51PBUgkwagBWuvd50rnKnQhDOk2v/GeJnweEW51yJZ62RYevk1nY+0NCNvVHUBC3Bu
         kwxLUfllrK0RDpESQcJc5fgpxfawWfv15/qSyTJXN2PNJ8jue+gcMfluu4PfE2yZyGDV
         CBpC+oXOK727l4A4ak6cH2pYLlhzP4v81FAwRKIhqgz5E6wf2XrKQP+mue3sSRxD3Q85
         f6WYzmPSz5vEFzJPgXOpTEza4Lxd5zojCd07KnRai4m9JXwH/cbY/J3MEfI1p0YgirBU
         HgSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlMnQdJQVx43CxR/rRaPxPJpN5IUGks2dtNm+KCIZnaIHEz3qfZ4aFVxdROQwUAl1ddBEc07txmsMXYaDU5YnuXb+Eo3wSQ/v4r0Vo
X-Gm-Message-State: AOJu0YwyZWHtNcacQbP3fvcQPTTEPABA2F+GrvHnilUtgBoBNpPLcx5I
	8x4MJMO0H69+wQ5WFYyXjc38rtWV1SehhqbPZFey7UnSkqJ1stlzhWFVRt/hcNwnxhxk75MvAt9
	Iu/sZ71+u3i7ywdY+z9msTe7tDWI=
X-Google-Smtp-Source: AGHT+IEUOhYL6xStpYkuThqQmBqF9anzRNcCXHrVrb8jzngDIMAgzFxD9dlfrxkdWim6vc6yiQ0wqpXPBTEwfZx8S9M=
X-Received: by 2002:a17:907:3e1a:b0:a7d:2612:33d6 with SMTP id
 a640c23a62f3a-a8090e9f92fmr259662366b.53.1723148342231; Thu, 08 Aug 2024
 13:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807182325.2585582-1-surenb@google.com>
In-Reply-To: <20240807182325.2585582-1-surenb@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Aug 2024 13:18:46 -0700
Message-ID: <CAEf4BzaocU-CQsFZ=s5gDM6XQ0Foss_HroFsPUesBn=qgJCprg@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 11:23=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Add helper functions to speculatively perform operations without
> read-locking mmap_lock, expecting that mmap_lock will not be
> write-locked and mm is not modified from under us.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> ---

This change makes sense and makes mm's seq a bit more useful and
meaningful. I've also tested it locally with uprobe stress-test, and
it seems to work great, I haven't run into any problems with a
multi-hour stress test run so far. Thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> Discussion [1] follow-up. If proves to be useful can be included in that
> patchset. Based on mm-unstable.
>
> [1] https://lore.kernel.org/all/20240730134605.GO33588@noisy.programming.=
kicks-ass.net/
>
>  include/linux/mm_types.h  |  3 +++
>  include/linux/mmap_lock.h | 53 +++++++++++++++++++++++++++++++--------
>  kernel/fork.c             |  3 ---
>  3 files changed, 46 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 003619fab20e..a426e6ced604 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -887,6 +887,9 @@ struct mm_struct {
>                  * Roughly speaking, incrementing the sequence number is
>                  * equivalent to releasing locks on VMAs; reading the seq=
uence
>                  * number can be part of taking a read lock on a VMA.
> +                * Incremented every time mmap_lock is write-locked/unloc=
ked.
> +                * Initialized to 0, therefore odd values indicate mmap_l=
ock
> +                * is write-locked and even values that it's released.
>                  *
>                  * Can be modified under write mmap_lock using RELEASE
>                  * semantics.
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index de9dc20b01ba..5410ce741d75 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -71,15 +71,12 @@ static inline void mmap_assert_write_locked(const str=
uct mm_struct *mm)
>  }
>
>  #ifdef CONFIG_PER_VMA_LOCK
> -/*
> - * Drop all currently-held per-VMA locks.
> - * This is called from the mmap_lock implementation directly before rele=
asing
> - * a write-locked mmap_lock (or downgrading it to read-locked).
> - * This should normally NOT be called manually from other places.
> - * If you want to call this manually anyway, keep in mind that this will=
 release
> - * *all* VMA write locks, including ones from further up the stack.
> - */
> -static inline void vma_end_write_all(struct mm_struct *mm)
> +static inline void init_mm_lock_seq(struct mm_struct *mm)
> +{
> +       mm->mm_lock_seq =3D 0;
> +}
> +
> +static inline void inc_mm_lock_seq(struct mm_struct *mm)
>  {
>         mmap_assert_write_locked(mm);
>         /*
> @@ -91,19 +88,52 @@ static inline void vma_end_write_all(struct mm_struct=
 *mm)
>          */
>         smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
>  }
> +
> +static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int=
 *seq)
> +{
> +       /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> +       *seq =3D smp_load_acquire(&mm->mm_lock_seq);
> +       /* Allow speculation if mmap_lock is not write-locked */
> +       return (*seq & 1) =3D=3D 0;
> +}
> +
> +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int s=
eq)
> +{
> +       /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> +       return seq =3D=3D smp_load_acquire(&mm->mm_lock_seq);
> +}
> +
>  #else
> -static inline void vma_end_write_all(struct mm_struct *mm) {}
> +static inline void init_mm_lock_seq(struct mm_struct *mm) {}
> +static inline void inc_mm_lock_seq(struct mm_struct *mm) {}
> +static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int=
 *seq) { return false; }
> +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int s=
eq) { return false; }
>  #endif
>
> +/*
> + * Drop all currently-held per-VMA locks.
> + * This is called from the mmap_lock implementation directly before rele=
asing
> + * a write-locked mmap_lock (or downgrading it to read-locked).
> + * This should normally NOT be called manually from other places.
> + * If you want to call this manually anyway, keep in mind that this will=
 release
> + * *all* VMA write locks, including ones from further up the stack.
> + */
> +static inline void vma_end_write_all(struct mm_struct *mm)
> +{
> +       inc_mm_lock_seq(mm);
> +}
> +
>  static inline void mmap_init_lock(struct mm_struct *mm)
>  {
>         init_rwsem(&mm->mmap_lock);
> +       init_mm_lock_seq(mm);
>  }
>
>  static inline void mmap_write_lock(struct mm_struct *mm)
>  {
>         __mmap_lock_trace_start_locking(mm, true);
>         down_write(&mm->mmap_lock);
> +       inc_mm_lock_seq(mm);
>         __mmap_lock_trace_acquire_returned(mm, true, true);
>  }
>
> @@ -111,6 +141,7 @@ static inline void mmap_write_lock_nested(struct mm_s=
truct *mm, int subclass)
>  {
>         __mmap_lock_trace_start_locking(mm, true);
>         down_write_nested(&mm->mmap_lock, subclass);
> +       inc_mm_lock_seq(mm);
>         __mmap_lock_trace_acquire_returned(mm, true, true);
>  }
>
> @@ -120,6 +151,8 @@ static inline int mmap_write_lock_killable(struct mm_=
struct *mm)
>
>         __mmap_lock_trace_start_locking(mm, true);
>         ret =3D down_write_killable(&mm->mmap_lock);
> +       if (!ret)
> +               inc_mm_lock_seq(mm);
>         __mmap_lock_trace_acquire_returned(mm, true, ret =3D=3D 0);
>         return ret;
>  }
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3d590e51ce84..73e37af8a24d 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1259,9 +1259,6 @@ static struct mm_struct *mm_init(struct mm_struct *=
mm, struct task_struct *p,
>         seqcount_init(&mm->write_protect_seq);
>         mmap_init_lock(mm);
>         INIT_LIST_HEAD(&mm->mmlist);
> -#ifdef CONFIG_PER_VMA_LOCK
> -       mm->mm_lock_seq =3D 0;
> -#endif
>         mm_pgtables_bytes_init(mm);
>         mm->map_count =3D 0;
>         mm->locked_vm =3D 0;
>
> base-commit: 98808d08fc0f78ee638e0c0a88020fbbaf581ec6
> --
> 2.46.0.rc2.264.g509ed76dc8-goog
>

