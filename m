Return-Path: <linux-kernel+bounces-277164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32343949D65
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A282B1F242EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6B115CD64;
	Wed,  7 Aug 2024 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDdSZQax"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A771215B113
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722994582; cv=none; b=e49cBQs/xSW58QX0IY/KTsjhzOt0TBGjaN2Bxmti5jjO6efXbn0kADBmF52X140DYxnQxbFSXt3NugNESQchOT9C3D22sICs/CSMha1pF9ZaqLyq0f0VRsnzEJ2XV7Soe6DSSnS6je8IphgtoGfg++rzsOQT4AUDzTOsGmrPRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722994582; c=relaxed/simple;
	bh=dAx1wJjnC55G7JZp/KeV7qVIwoD2n/XPZSykS5/OZVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3OGmuDQqlC3wLlHRmvcO+svThDhVxQGULuXue6STyONzYqyGvVd5/ZWLUW60jgjFwP0/X5tfGmTXgft2NBCJgI+b4qh8kH/F6b1QOvUqxMgb2GefbvXtW9hWKVYHqLj1HV2KM9N/l6iGkl/Qxz+USt0JOjPxz9hdQekbAUlG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDdSZQax; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-691c85525ebso11643737b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 18:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722994580; x=1723599380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tdl7f0aHz3AZhx8k9i5pXOhQEPNy1w2diIjEuj/AMss=;
        b=ZDdSZQaxffw9MsCqddj2SdDhaWOXYUMNoT8GFzkef/aPr8uonW1w0yCN2kWuu5usW0
         QRIqjYq+dPR1gVdFIXSba3F8+OOQEFPQXRH2bqbODOYZl/0/h1lnOABM+Z4AjKIYPH6a
         Y6CSiYnvPZI8yI51sctV/LLdKXRGvkKDPJWBefnkX1fUCew5sKq5VUe72bC5aqGggqfj
         1+6VTjiGi/dRUBHkwxG6p/dA1m1dUGy2Ed2esG8akqgerM8d2o2+w6mAgt3ZtY7mfhRl
         Dy+cs7+J6eD0MxRhRHLzVhV5MVU2KhXNLWmjKq7Z2erw4UiGbpEgYetVQYvT85MeaBLP
         ITGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722994580; x=1723599380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tdl7f0aHz3AZhx8k9i5pXOhQEPNy1w2diIjEuj/AMss=;
        b=OzD5Xr5u46tw8tLaiJ2XS+i5dmEjIl1TJNmxRwKl11tIPodwD5E9bh676xOb3Cs9sa
         Ucl3oJL1XclhUoh0gNn+MrL+K1lu+cj6p2LPy9k7QT19yVJsT7c+wcK8QWxk5hNH5y1E
         +ph3LSh73BaQBkKjN83qvJKQ91r45rIJ3HA73fPswa7FSPVt81y6aWPR8v2yyVhwaqDX
         dfMcKyc+4Piu8aNJBJBqRZFQev7XTTY8Es+vya1U3o9+9OKMItQ7jKmMShbQl3f+VKDT
         lve3Fjb1KsYyUNQusLsYgIFgTGGgvLMPtZiuX5U/qhpO8/sOoVbme6Vl0Q3chZs8NzLu
         g01g==
X-Forwarded-Encrypted: i=1; AJvYcCVyqoGoOJVT5vRY1EqiggGX5+MionPW3DCghGjXjfxGmmGibyJK7vDlkxQiIP8fiwBQWreVj28MQ0/EKBdsG0OvC20fA62w21JYENQ5
X-Gm-Message-State: AOJu0YxWPEy8NgI9XI49ozJx8MekgE9lzQbZWyoifOfywlEANp3waNOc
	Fi5UrhRM/7jfH/+AFrHMjdeCbtBQkItq1aiTS725mVNf33YDgmAGdTXZbbSVx+Gvac62v1Uy28Q
	oPIFtfcy9G+GR1yDRxAwQdYS5JIePwSGoK76p
X-Google-Smtp-Source: AGHT+IFk3dCJxraH2ciFb+NG/euaLvoHKlcgNrXp/rfqyOzUfalif22QDUxbyd8TLmYeOKi9XlF0kRESFmAvG4N7C7o=
X-Received: by 2002:a05:690c:2910:b0:632:77ca:dafd with SMTP id
 00721157ae682-6994e688610mr3940887b3.10.1722994579240; Tue, 06 Aug 2024
 18:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zo1hBFS7c_J-Yx-7@casper.infradead.org> <20240710091631.GT27299@noisy.programming.kicks-ass.net>
 <20240710094013.GF28838@noisy.programming.kicks-ass.net> <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com>
 <CAEf4BzZPGG9_P9EWosREOw8owT6+qawmzYr0EJhOZn8khNn9NQ@mail.gmail.com>
 <CAJuCfpELNoDrVyyNV+fuB7ju77pqyj0rD0gOkLVX+RHKTxXGCA@mail.gmail.com>
 <ZqRtcZHWFfUf6dfi@casper.infradead.org> <20240730131058.GN33588@noisy.programming.kicks-ass.net>
 <CAJuCfpFUQFfgx0BWdkNTAiOhBpqmd02zarC0y38gyB5OPc0wRA@mail.gmail.com>
 <CAEf4BzavWOgCLQoNdmPyyqHcm7gY5USKU5f1JWfyaCbuc_zVAA@mail.gmail.com>
 <20240803085312.GP39708@noisy.programming.kicks-ass.net> <CAEf4BzYPpkhKtuaT-EbyKeB13-uBeYf8LjR9CB=xaXYHnwsyAQ@mail.gmail.com>
 <CAEf4BzZ26FNTguRh_X9_5eQZvOeKb+c-o3mxSzoM2+TF3NqaWA@mail.gmail.com>
In-Reply-To: <CAEf4BzZ26FNTguRh_X9_5eQZvOeKb+c-o3mxSzoM2+TF3NqaWA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 6 Aug 2024 18:36:06 -0700
Message-ID: <CAJuCfpFqEjG7HCx1F=Q3fScYAhaAou0Un2SFpibimkxZr7Jsbw@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org, 
	Matthew Wilcox <willy@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, andrii@kernel.org, 
	linux-kernel@vger.kernel.org, oleg@redhat.com, jolsa@kernel.org, clm@meta.com, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 9:08=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Aug 4, 2024 at 4:22=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Aug 3, 2024 at 1:53=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Fri, Aug 02, 2024 at 10:47:15PM -0700, Andrii Nakryiko wrote:
> > >
> > > > Is there any reason why the approach below won't work?
> > >
> > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > index 8be9e34e786a..e21b68a39f13 100644
> > > > --- a/kernel/events/uprobes.c
> > > > +++ b/kernel/events/uprobes.c
> > > > @@ -2251,6 +2251,52 @@ static struct uprobe
> > > > *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
> > > >         struct uprobe *uprobe =3D NULL;
> > > >         struct vm_area_struct *vma;
> > > >
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +       vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE,=
 vm_flags;
> > > > +       struct file *vm_file;
> > > > +       struct inode *vm_inode;
> > > > +       unsigned long vm_pgoff, vm_start, vm_end;
> > > > +       int vm_lock_seq;
> > > > +       loff_t offset;
> > > > +
> > > > +       rcu_read_lock();
> > > > +
> > > > +       vma =3D vma_lookup(mm, bp_vaddr);
> > > > +       if (!vma)
> > > > +               goto retry_with_lock;
> > > > +
> > > > +       vm_lock_seq =3D READ_ONCE(vma->vm_lock_seq);
> > >
> > > So vma->vm_lock_seq is only updated on vma_start_write()
> >
> > yep, I've looked a bit more at the implementation now
> >
> > >
> > > > +
> > > > +       vm_file =3D READ_ONCE(vma->vm_file);
> > > > +       vm_flags =3D READ_ONCE(vma->vm_flags);
> > > > +       if (!vm_file || (vm_flags & flags) !=3D VM_MAYEXEC)
> > > > +               goto retry_with_lock;
> > > > +
> > > > +       vm_inode =3D READ_ONCE(vm_file->f_inode);
> > > > +       vm_pgoff =3D READ_ONCE(vma->vm_pgoff);
> > > > +       vm_start =3D READ_ONCE(vma->vm_start);
> > > > +       vm_end =3D READ_ONCE(vma->vm_end);
> > >
> > > None of those are written with WRITE_ONCE(), so this buys you nothing=
.
> > > Compiler could be updating them one byte at a time while you load som=
e
> > > franken-update.
> > >
> > > Also, if you're in the middle of split_vma() you might not get a
> > > consistent set.
> >
> > I used READ_ONCE() only to prevent the compiler from re-reading those
> > values. We assume those values are garbage anyways and double-check
> > everything, so lack of WRITE_ONCE doesn't matter. Same for
> > inconsistency if we are in the middle of split_vma().
> >
> > We use the result of all this speculative calculation only if we find
> > a valid uprobe (which could be a false positive) *and* if we detect
> > that nothing about VMA changed (which is what I got wrong, but
> > honestly I was actually betting on others to help me get this right
> > anyways).
> >
> > >
> > > > +       if (bp_vaddr < vm_start || bp_vaddr >=3D vm_end)
> > > > +               goto retry_with_lock;
> > > > +
> > > > +       offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - v=
m_start);
> > > > +       uprobe =3D find_uprobe_rcu(vm_inode, offset);
> > > > +       if (!uprobe)
> > > > +               goto retry_with_lock;
> > > > +
> > > > +       /* now double check that nothing about VMA changed */
> > > > +       if (vm_lock_seq !=3D READ_ONCE(vma->vm_lock_seq))
> > > > +               goto retry_with_lock;
> > >
> > > Since vma->vma_lock_seq is only ever updated at vma_start_write() you=
're
> > > checking you're in or after the same modification cycle.
> > >
> > > The point of sequence locks is to check you *IN* a modification cycle
> > > and retry if you are. You're now explicitly continuing if you're in a
> > > modification.
> > >
> > > You really need:
> > >
> > >    seq++;
> > >    wmb();
> > >
> > >    ... do modification
> > >
> > >    wmb();
> > >    seq++;
> > >
> > > vs
> > >
> > >   do {
> > >           s =3D READ_ONCE(seq) & ~1;
> > >           rmb();
> > >
> > >           ... read stuff
> > >
> > >   } while (rmb(), seq !=3D s);
> > >
> > >
> > > The thing to note is that seq will be odd while inside a modification
> > > and even outside, further if the pre and post seq are both even but n=
ot
> > > identical, you've crossed a modification and also need to retry.
> > >
> >
> > Ok, I don't think I got everything you have written above, sorry. But
> > let me explain what I think I need to do and please correct what I
> > (still) got wrong.
> >
> > a) before starting speculation,
> >   a.1) read and remember current->mm->mm_lock_seq (using
> > smp_load_acquire(), right?)
> >   a.2) read vma->vm_lock_seq (using smp_load_acquire() I presume)
> >   a.3) if vm_lock_seq is odd, we are already modifying VMA, so bail
> > out, try with proper mmap_lock
> > b) proceed with the inode pointer fetch and offset calculation as I've =
coded it
> > c) lookup uprobe by inode+offset, if failed -- bail out (if succeeded,
> > this could still be wrong)
> > d) re-read vma->vm_lock_seq, if it changed, we started modifying/have
> > already modified VMA, bail out
> > e) re-read mm->mm_lock_seq, if that changed -- presume VMA got
> > modified, bail out
> >
> > At this point we should have a guarantee that nothing about mm
> > changed, nor that VMA started being modified during our speculative
> > calculation+uprobe lookup. So if we found a valid uprobe, it must be a
> > correct one that we need.
> >
> > Is that enough? Any holes in the approach? And thanks for thoroughly
> > thinking about this, btw!
>
> Ok, with slight modifications to the details of the above (e.g., there
> is actually no "odd means VMA is being modified" thing with
> vm_lock_seq),

Correct. Instead of that (vm_lock_seq->vm_lock_seq =3D=3D mm->mm_lock_seq)
means your VMA is write-locked and is being modified.

> I ended up with the implementation below. Basically we
> validate that mm->mm_lock_seq didn't change and that vm_lock_seq !=3D
> mm_lock_seq (which otherwise would mean "VMA is being modified").

Validating that mm->mm_lock_seq did not change does not provide you
with useful information. It only means that between the point where
you recorded mm->mm_lock_seq and where you are checking it, there was
an mmap_write_unlock() or mmap_write_downgrade() call. Your VMA might
not have even been part of that modification for which mmap_lock was
taken.

In theory what you need is simpler (simplified code for explanation only):

int vm_lock_seq =3D vma->vm_lock_seq;
if (vm_lock_seq =3D=3D mm->mm_lock_seq)
        goto bail_out; /* VMA is write-locked */

/* copy required VMA attributes */

if (vm_lock_seq !=3D vma->vm_lock_seq)
        goto bail_out; /* VMA got write-locked */

But this would require proper ACQUIRE/RELEASE semantics for
vma->vm_lock_seq which is currently not there because all reads/writes
to vma->vm_lock_seq that matter are done under vma->vm_lock->lock
protection, so additional ordering is not required. If you decide to
add that semantics for vma->vm_lock_seq, please make sure that
pagefault path performance does not regress.

> There is a possibility that vm_lock_seq =3D=3D mm_lock_seq just by
> accident, which is not a correctness problem, we'll just fallback to
> locked implementation until something about VMA or mm_struct itself
> changes. Which is fine, and if mm folks ever change this locking
> schema, this might go away.
>
> If this seems on the right track, I think we can just move
> mm_start_vma_specuation()/mm_end_vma_speculation() into
> include/linux/mm.h.
>
> And after thinking a bit more about READ_ONCE() usage, I changed them
> to data_race() to not trigger KCSAN warnings. Initially I kept
> READ_ONCE() only around vma->vm_file access, but given we never change
> it until vma is freed and reused (which would be prevented by
> guard(rcu)), I dropped READ_ONCE() and only added data_race(). And
> even data_race() is probably not necessary.
>
> Anyways, please see the patch below. Would be nice if mm folks
> (Suren?) could confirm that this is not broken.
>
>
>
> Author: Andrii Nakryiko <andrii@kernel.org>
> Date:   Fri Aug 2 22:16:40 2024 -0700
>
>     uprobes: add speculative lockless VMA to inode resolution
>
>     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 3de311c56d47..bee7a929ff02 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2244,6 +2244,70 @@ static int is_trap_at_addr(struct mm_struct
> *mm, unsigned long vaddr)
>         return is_trap_insn(&opcode);
>  }
>
> +#ifdef CONFIG_PER_VMA_LOCK
> +static inline void mm_start_vma_speculation(struct mm_struct *mm, int
> *mm_lock_seq)
> +{
> +       *mm_lock_seq =3D smp_load_acquire(&mm->mm_lock_seq);
> +}
> +
> +/* returns true if speculation was safe (no mm and vma modification
> happened) */
> +static inline bool mm_end_vma_speculation(struct vm_area_struct *vma,
> int mm_lock_seq)
> +{
> +       int mm_seq, vma_seq;
> +
> +       mm_seq =3D smp_load_acquire(&vma->vm_mm->mm_lock_seq);
> +       vma_seq =3D READ_ONCE(vma->vm_lock_seq);
> +
> +       return mm_seq =3D=3D mm_lock_seq && vma_seq !=3D mm_seq;

After spending some time on this I think what you do here is
semantically correct but sub-optimal.

This check means that there was no call to
mmap_write_unlock()/mmap_write_downgrade() since
mm_start_vma_speculation() and the vma is not currently locked. To
unlock a write-locked VMA you do need to call
map_write_unlock()/mmap_write_downgrade(), so I think this check would
guarantee that your vma was not locked and modified from under us.
However this will also trigger false positives if
mmap_write_unlock()/mmap_write_downgrade() was called but the vma you
are using was never locked. So, it will bail out more than necessary.
Maybe it's ok?

> +}
> +
> +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_va=
ddr)
> +{
> +       const vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
> +       struct mm_struct *mm =3D current->mm;
> +       struct uprobe *uprobe;
> +       struct vm_area_struct *vma;
> +       struct file *vm_file;
> +       struct inode *vm_inode;
> +       unsigned long vm_pgoff, vm_start;
> +       int mm_lock_seq;
> +       loff_t offset;
> +
> +       guard(rcu)();
> +
> +       mm_start_vma_speculation(mm, &mm_lock_seq);
> +
> +       vma =3D vma_lookup(mm, bp_vaddr);
> +       if (!vma)
> +               return NULL;
> +
> +       vm_file =3D data_race(vma->vm_file);
> +       if (!vm_file || (vma->vm_flags & flags) !=3D VM_MAYEXEC)
> +               return NULL;
> +
> +       vm_inode =3D data_race(vm_file->f_inode);
> +       vm_pgoff =3D data_race(vma->vm_pgoff);
> +       vm_start =3D data_race(vma->vm_start);
> +
> +       offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_star=
t);
> +       uprobe =3D find_uprobe_rcu(vm_inode, offset);
> +       if (!uprobe)
> +               return NULL;
> +
> +       /* now double check that nothing about MM and VMA changed */
> +       if (!mm_end_vma_speculation(vma, mm_lock_seq))
> +               return NULL;
> +
> +       /* happy case, we speculated successfully */
> +       return uprobe;
> +}
> +#else /* !CONFIG_PER_VMA_LOCK */
> +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_va=
ddr)
> +{
> +       return NULL;
> +}
> +#endif /* CONFIG_PER_VMA_LOCK */
> +
>  /* assumes being inside RCU protected region */
>  static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr,
> int *is_swbp)
>  {
> @@ -2251,6 +2315,10 @@ static struct uprobe
> *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
>         struct uprobe *uprobe =3D NULL;
>         struct vm_area_struct *vma;
>
> +       uprobe =3D find_active_uprobe_speculative(bp_vaddr);
> +       if (uprobe)
> +               return uprobe;
> +
>         mmap_read_lock(mm);
>         vma =3D vma_lookup(mm, bp_vaddr);
>         if (vma) {
> diff --git a/kernel/fork.c b/kernel/fork.c
> index cc760491f201..211a84ee92b4 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -3160,7 +3160,7 @@ void __init proc_caches_init(void)
>                         NULL);
>         files_cachep =3D kmem_cache_create("files_cache",
>                         sizeof(struct files_struct), 0,
> -                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> +
> SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT|SLAB_TYPESAFE_BY_RCU,
>                         NULL);
>         fs_cachep =3D kmem_cache_create("fs_cache",
>                         sizeof(struct fs_struct), 0,
>
>
> >
> > P.S. This is basically the last big blocker towards linear uprobes
> > scalability with the number of active CPUs. I have
> > uretprobe+SRCU+timeout implemented and it seems to work fine, will
> > post soon-ish.
> >
> > P.P.S Also, funny enough, below was another big scalability limiter
> > (and the last one) :) I'm not sure if we can just drop it, or I should
> > use per-CPU counter, but with the below change and speculative VMA
> > lookup (however buggy, works ok for benchmarking), I finally get
> > linear scaling of uprobe triggering throughput with number of CPUs. We
> > are very close.
> >
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index f7443e996b1b..64c2bc316a08 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -1508,7 +1508,7 @@ static int uprobe_dispatcher(struct
> > uprobe_consumer *con, struct pt_regs *regs)
> >         int ret =3D 0;
> >
> >         tu =3D container_of(con, struct trace_uprobe, consumer);
> > -       tu->nhit++;
> > +       //tu->nhit++;
> >
> >         udd.tu =3D tu;
> >         udd.bp_addr =3D instruction_pointer(regs);
> >
> >
> > > > +
> > > > +       /* happy case, we speculated successfully */
> > > > +       rcu_read_unlock();
> > > > +       return uprobe;
> > > > +
> > > > +retry_with_lock:
> > > > +       rcu_read_unlock();
> > > > +       uprobe =3D NULL;
> > > > +#endif
> > > > +
> > > >         mmap_read_lock(mm);
> > > >         vma =3D vma_lookup(mm, bp_vaddr);
> > > >         if (vma) {
> > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > index cc760491f201..211a84ee92b4 100644
> > > > --- a/kernel/fork.c
> > > > +++ b/kernel/fork.c
> > > > @@ -3160,7 +3160,7 @@ void __init proc_caches_init(void)
> > > >                         NULL);
> > > >         files_cachep =3D kmem_cache_create("files_cache",
> > > >                         sizeof(struct files_struct), 0,
> > > > -                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> > > > + SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT|SLAB_TYPESAFE_BY_RCU,
> > > >                         NULL);
> > > >         fs_cachep =3D kmem_cache_create("fs_cache",
> > > >                         sizeof(struct fs_struct), 0,

