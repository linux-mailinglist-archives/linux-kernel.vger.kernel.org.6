Return-Path: <linux-kernel+bounces-383903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 907C29B21A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 01:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB21C1C20E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 00:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED35A824A3;
	Mon, 28 Oct 2024 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFKOP7Ub"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50106664C6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730077071; cv=none; b=OmuuVkYuUkE2tBQESlgNt64Lc76fn3MwLzEa/m3pLDc/8odkDCWgpoVoVWGrPTEK0/a8UuSAPjD64qcMnTD5jpAhOWoUply0Guru0RYF7F2tJ/f5GdPXtmSZfdwybXWDbAb2UeyqZReNW6/Zd8YybQMVOFTQpHzgHvG+7WfsSck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730077071; c=relaxed/simple;
	bh=4uR0sEFHNYrqjluI6UbNQ2AzpXij+C7pgMvqOfxQb7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgR5k91uiMbZfjqiZ0QTgFMokhOF7srmV3JWQbCBK+vQ1rZD+SkUzxm5Qi/nCty7Z8UksemJkSbE9p3xN8Sd3vSFfNlBuyb0Ab9i+kIpE4gAFwkztgZAcpcVtgXXQ9cTMhSvgdkgaRiOm2NkuoaHjPoxPr/hoWkLMy++8K1IMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFKOP7Ub; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5e5a0519d00so1733268eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 17:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730077067; x=1730681867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4QBPLq7a004rv8ai6kkCUUNzEpogEnxOy7q8leSeWc=;
        b=YFKOP7UbKPMaK7a07jz7FLim5qZd9ntuSrayGG8xcwnsVaaj1ZaRBM4SQSIlntOv7b
         8qWG772AQIUay9rPnFKT8xpn6XjqWoX8m12bbanXx8SUl8pze569G/PgurhUYaQ1hfSe
         sLwiV6zR0W38MyJ9tq6bja6aXnjlNCEPl+BnSLVAUqY9uVNTrmqBpcUUrzyDP9d2DK40
         Jro8eX2rJ9ARDmGvRje/85v9+dv7ReGKVxTCzDCzU1NG8ItTLo4bhFPZ8cAUZDbYGsVW
         h/6kMG00izMG8Fy8j/N4Vd4sAP+2r4zw9KLU9cyIX3xvVp6SDFRr8clsLBkpjS/hUeLj
         On7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730077067; x=1730681867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4QBPLq7a004rv8ai6kkCUUNzEpogEnxOy7q8leSeWc=;
        b=Ti4EunrnYAkUSIsG9y1iJP2KDaQeE48kwn6MKmq2zKepX5y1M1NtnHpLPYO2JKfyOW
         XFH6/IwtmxSE8JblBTehQs/DJZeWkZa/4hncNIPRW0G3FlEmR45piIUclMBgly7v/A1C
         4QG37W8f2SkEGJ9UmKbJ3EmYuSzfh1kFzmtcX8neBABEwCkFKEvXn2y1UEJ4lof+pBBV
         T4hMP1nTzQhzaU3XJpXBZnObuc+/4uUUBi3J9msWsEVuvIqy1GdTRowgcYh1D3ROWm+8
         vxmyANINj28X7SHAz04kQ2ynwthahVM/KvKPw+N9ArCFiRHr8euh0VJABe0xVvm0cFU3
         HOaw==
X-Forwarded-Encrypted: i=1; AJvYcCWOrg39DQRN+p4gWmNlNb6O8vFhe72MS0IikWKm4rTOcCgfNcOYZjA604jqfhlQaubr9FbEWYnRMvixtEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5bLynG/oJ6eAgaOCcAJFCbT1BBfwTLyIpQgC8MAJk5DIp3i2n
	AZDVMCN2Y7wpa5qkuG5wUzU657Was1ke4NL3q9WaIWKqOijA0RWJv9cw3lw9dYraakbWOsrLKAx
	D1CnRKsKuJatwbXCSG8QkP7AZwYI=
X-Google-Smtp-Source: AGHT+IEjQ94VsgFmtD4EoeQd4hUT/7FXQBzsJm+1R5ItM6JK1hqtC6yf/JSLwYpvI8QkMF0F4nsaR9/CWpDXoZFqMEo=
X-Received: by 2002:a05:6870:3328:b0:270:1dab:64a9 with SMTP id
 586e51a60fabf-29051b7415dmr4691188fac.14.1730077066819; Sun, 27 Oct 2024
 17:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024205231.1944747-1-surenb@google.com>
In-Reply-To: <20241024205231.1944747-1-surenb@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sun, 27 Oct 2024 17:57:34 -0700
Message-ID: <CAEf4BzZvFFXByMS-eyFZzt7055MHexT2h0FfKfSN83x_jYTZEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: convert mm_lock_seq to a proper seqcount
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, andrii@kernel.org, 
	jannh@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, brauner@kernel.org, oleg@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 1:52=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Convert mm_lock_seq to be seqcount_t and change all mmap_write_lock
> variants to increment it, in-line with the usual seqcount usage pattern.
> This lets us check whether the mmap_lock is write-locked by checking
> mm_lock_seq.sequence counter (odd=3Dlocked, even=3Dunlocked). This will b=
e
> used when implementing mmap_lock speculation functions.
> As a result vm_lock_seq is also change to be unsigned to match the type
> of mm_lock_seq.sequence.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Applies over mm-unstable
>
> This conversion was discussed at [1] and these patches will likely be
> incorporated into the next version od Andrii's patcset.

I got a notification that this patch set was applied to mm-unstable by
Andrew. But I was wondering if Andrew and Peter would agree to move
the patches into tip's perf/core branch, given this is a dependency of
my pending uprobe series ([0]) and, as far as I'm aware, there is no
urgent need for this API in mm tree(s). If we route this through
mm-unstable, we either need a stable tag from mm tree for Peter to
merge into perf/core (a bit of a hassle for both Andrew and Peter, I'm
sure), or I'd have to wait for 5-6 weeks until after next merge window
closes, which would be a huge bummer, given I'd been at this for a
while already with basically done patches, and would prefer to get my
changes sooner.

So, I'd very much prefer to just route these changes through
perf/core, if mm folks don't oppose this? In fact, I'll go ahead and
will send my patches with Suren's patches included with the assumption
that we can reroute all this. Thanks for understanding!

P.S. And yeah, Suren's patches apply cleanly to perf/core just as
well, I checked.

  [0] https://lore.kernel.org/linux-trace-kernel/20241010205644.3831427-1-a=
ndrii@kernel.org/

> The issue of the seqcount_t.sequence being an unsigned rather than
> unsigned long will be addressed separately in collaoration with Jann Horn=
.
>
> [1] https://lore.kernel.org/all/20241010205644.3831427-2-andrii@kernel.or=
g/
>
>  include/linux/mm.h               | 12 +++----
>  include/linux/mm_types.h         |  7 ++--
>  include/linux/mmap_lock.h        | 58 +++++++++++++++++++++-----------
>  kernel/fork.c                    |  5 +--
>  mm/init-mm.c                     |  2 +-
>  tools/testing/vma/vma.c          |  4 +--
>  tools/testing/vma/vma_internal.h |  4 +--
>  7 files changed, 56 insertions(+), 36 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4ef8cf1043f1..77644118b200 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -698,7 +698,7 @@ static inline bool vma_start_read(struct vm_area_stru=
ct *vma)
>          * we don't rely on for anything - the mm_lock_seq read against w=
hich we
>          * need ordering is below.
>          */
> -       if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->mm_l=
ock_seq))
> +       if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->mm_l=
ock_seq.sequence))
>                 return false;
>
>         if (unlikely(down_read_trylock(&vma->vm_lock->lock) =3D=3D 0))
> @@ -715,7 +715,7 @@ static inline bool vma_start_read(struct vm_area_stru=
ct *vma)
>          * after it has been unlocked.
>          * This pairs with RELEASE semantics in vma_end_write_all().
>          */
> -       if (unlikely(vma->vm_lock_seq =3D=3D smp_load_acquire(&vma->vm_mm=
->mm_lock_seq))) {
> +       if (unlikely(vma->vm_lock_seq =3D=3D raw_read_seqcount(&vma->vm_m=
m->mm_lock_seq))) {
>                 up_read(&vma->vm_lock->lock);
>                 return false;
>         }
> @@ -730,7 +730,7 @@ static inline void vma_end_read(struct vm_area_struct=
 *vma)
>  }
>
>  /* WARNING! Can only be used if mmap_lock is expected to be write-locked=
 */
> -static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lo=
ck_seq)
> +static bool __is_vma_write_locked(struct vm_area_struct *vma, unsigned i=
nt *mm_lock_seq)
>  {
>         mmap_assert_write_locked(vma->vm_mm);
>
> @@ -738,7 +738,7 @@ static bool __is_vma_write_locked(struct vm_area_stru=
ct *vma, int *mm_lock_seq)
>          * current task is holding mmap_write_lock, both vma->vm_lock_seq=
 and
>          * mm->mm_lock_seq can't be concurrently modified.
>          */
> -       *mm_lock_seq =3D vma->vm_mm->mm_lock_seq;
> +       *mm_lock_seq =3D vma->vm_mm->mm_lock_seq.sequence;
>         return (vma->vm_lock_seq =3D=3D *mm_lock_seq);
>  }
>
> @@ -749,7 +749,7 @@ static bool __is_vma_write_locked(struct vm_area_stru=
ct *vma, int *mm_lock_seq)
>   */
>  static inline void vma_start_write(struct vm_area_struct *vma)
>  {
> -       int mm_lock_seq;
> +       unsigned int mm_lock_seq;
>
>         if (__is_vma_write_locked(vma, &mm_lock_seq))
>                 return;
> @@ -767,7 +767,7 @@ static inline void vma_start_write(struct vm_area_str=
uct *vma)
>
>  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
>  {
> -       int mm_lock_seq;
> +       unsigned int mm_lock_seq;
>
>         VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
>  }
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index ff8627acbaa7..80fef38d9d64 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -715,7 +715,7 @@ struct vm_area_struct {
>          * counter reuse can only lead to occasional unnecessary use of t=
he
>          * slowpath.
>          */
> -       int vm_lock_seq;
> +       unsigned int vm_lock_seq;
>         /* Unstable RCU readers are allowed to read this. */
>         struct vma_lock *vm_lock;
>  #endif
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
> @@ -895,7 +898,7 @@ struct mm_struct {
>                  * Can be read with ACQUIRE semantics if not holding writ=
e
>                  * mmap_lock.
>                  */
> -               int mm_lock_seq;
> +               seqcount_t mm_lock_seq;
>  #endif
>
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index de9dc20b01ba..6b3272686860 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -71,39 +71,38 @@ static inline void mmap_assert_write_locked(const str=
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
> +static inline void mm_lock_seqcount_init(struct mm_struct *mm)
>  {
> -       mmap_assert_write_locked(mm);
> -       /*
> -        * Nobody can concurrently modify mm->mm_lock_seq due to exclusiv=
e
> -        * mmap_lock being held.
> -        * We need RELEASE semantics here to ensure that preceding stores=
 into
> -        * the VMA take effect before we unlock it with this store.
> -        * Pairs with ACQUIRE semantics in vma_start_read().
> -        */
> -       smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
> +       seqcount_init(&mm->mm_lock_seq);
> +}
> +
> +static inline void mm_lock_seqcount_begin(struct mm_struct *mm)
> +{
> +       do_raw_write_seqcount_begin(&mm->mm_lock_seq);
> +}
> +
> +static inline void mm_lock_seqcount_end(struct mm_struct *mm)
> +{
> +       do_raw_write_seqcount_end(&mm->mm_lock_seq);
>  }
> +
>  #else
> -static inline void vma_end_write_all(struct mm_struct *mm) {}
> +static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
> +static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
> +static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
>  #endif
>
>  static inline void mmap_init_lock(struct mm_struct *mm)
>  {
>         init_rwsem(&mm->mmap_lock);
> +       mm_lock_seqcount_init(mm);
>  }
>
>  static inline void mmap_write_lock(struct mm_struct *mm)
>  {
>         __mmap_lock_trace_start_locking(mm, true);
>         down_write(&mm->mmap_lock);
> +       mm_lock_seqcount_begin(mm);
>         __mmap_lock_trace_acquire_returned(mm, true, true);
>  }
>
> @@ -111,6 +110,7 @@ static inline void mmap_write_lock_nested(struct mm_s=
truct *mm, int subclass)
>  {
>         __mmap_lock_trace_start_locking(mm, true);
>         down_write_nested(&mm->mmap_lock, subclass);
> +       mm_lock_seqcount_begin(mm);
>         __mmap_lock_trace_acquire_returned(mm, true, true);
>  }
>
> @@ -120,10 +120,30 @@ static inline int mmap_write_lock_killable(struct m=
m_struct *mm)
>
>         __mmap_lock_trace_start_locking(mm, true);
>         ret =3D down_write_killable(&mm->mmap_lock);
> +       if (!ret)
> +               mm_lock_seqcount_begin(mm);
>         __mmap_lock_trace_acquire_returned(mm, true, ret =3D=3D 0);
>         return ret;
>  }
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
> +       mmap_assert_write_locked(mm);
> +       /*
> +        * Nobody can concurrently modify mm->mm_lock_seq due to exclusiv=
e
> +        * mmap_lock being held.
> +        */
> +       mm_lock_seqcount_end(mm);
> +}
> +
>  static inline void mmap_write_unlock(struct mm_struct *mm)
>  {
>         __mmap_lock_trace_released(mm, true);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index fd528fb5e305..0cae6fc651f0 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -447,7 +447,7 @@ static bool vma_lock_alloc(struct vm_area_struct *vma=
)
>                 return false;
>
>         init_rwsem(&vma->vm_lock->lock);
> -       vma->vm_lock_seq =3D -1;
> +       vma->vm_lock_seq =3D UINT_MAX;
>
>         return true;
>  }
> @@ -1260,9 +1260,6 @@ static struct mm_struct *mm_init(struct mm_struct *=
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
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index 24c809379274..6af3ad675930 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -40,7 +40,7 @@ struct mm_struct init_mm =3D {
>         .arg_lock       =3D  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
>         .mmlist         =3D LIST_HEAD_INIT(init_mm.mmlist),
>  #ifdef CONFIG_PER_VMA_LOCK
> -       .mm_lock_seq    =3D 0,
> +       .mm_lock_seq    =3D SEQCNT_ZERO(init_mm.mm_lock_seq),
>  #endif
>         .user_ns        =3D &init_user_ns,
>         .cpu_bitmap     =3D CPU_BITS_NONE,
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> index 8fab5e13c7c3..9bcf1736bf18 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/vma.c
> @@ -89,7 +89,7 @@ static struct vm_area_struct *alloc_and_link_vma(struct=
 mm_struct *mm,
>          * begun. Linking to the tree will have caused this to be increme=
nted,
>          * which means we will get a false positive otherwise.
>          */
> -       vma->vm_lock_seq =3D -1;
> +       vma->vm_lock_seq =3D UINT_MAX;
>
>         return vma;
>  }
> @@ -214,7 +214,7 @@ static bool vma_write_started(struct vm_area_struct *=
vma)
>         int seq =3D vma->vm_lock_seq;
>
>         /* We reset after each check. */
> -       vma->vm_lock_seq =3D -1;
> +       vma->vm_lock_seq =3D UINT_MAX;
>
>         /* The vma_start_write() stub simply increments this value. */
>         return seq > -1;
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_int=
ernal.h
> index e76ff579e1fd..1d9fc97b8e80 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -241,7 +241,7 @@ struct vm_area_struct {
>          * counter reuse can only lead to occasional unnecessary use of t=
he
>          * slowpath.
>          */
> -       int vm_lock_seq;
> +       unsigned int vm_lock_seq;
>         struct vma_lock *vm_lock;
>  #endif
>
> @@ -416,7 +416,7 @@ static inline bool vma_lock_alloc(struct vm_area_stru=
ct *vma)
>                 return false;
>
>         init_rwsem(&vma->vm_lock->lock);
> -       vma->vm_lock_seq =3D -1;
> +       vma->vm_lock_seq =3D UINT_MAX;
>
>         return true;
>  }
>
> base-commit: 9c111059234a949a4d3442a413ade19cc65ab927
> --
> 2.47.0.163.g1226f6d8fa-goog
>

