Return-Path: <linux-kernel+bounces-259316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714509393FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903761C214F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14973170826;
	Mon, 22 Jul 2024 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0FoBv22a"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE97116EC19
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721675377; cv=none; b=EAFwpALRUTK9PyrhdtcVzr2V/m3h4f7AboYICgnLmU83A22tQs0ZzNBJGu6VtWbVd1Cih4e+RGCYCsC8xCt8iOMf5fSKIDNnwlZ2zktVMpp7ym8WmBHHvHfSlkHSbBzYEDtffydboJ1h/8yKvXO4bAuyCMZ8iT4/z27kXxqsloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721675377; c=relaxed/simple;
	bh=qnmq/qlub6NkMVHjk1bCk3gy0V19lvngDxVc6kTkowE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5ghEwa4FvJ+hIJLn/KbEGXE8wCbo6RnZbkXiWwT2vPH8QjWs2fHhdeKZ4b/sdwUz3RvprlMRlN/iYOFna3Z+2n5NCEmr4G1cOt/B/kIAjaDKLL+bbfs0WTtMfqSoQzer9Reigg8QgDt9Os+g3IzqrebQA0cObGK9lRGakKYNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0FoBv22a; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-66ca536621cso14651297b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721675374; x=1722280174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H46wDgBqFw0ZNrcJfr4LFF2KtCEo/8CP1rPHZLFS0ZQ=;
        b=0FoBv22ag6FE5tccQyQHh8SxqWF/2OI9XrmvnFJa5F2xUsWjKYCw+noANCiNcxuDO3
         qvIRW4i27oeJxbK0tAbYR5obb4Ar/xWRPLrh+dgoqJwrhhieESWFiB9Z5O5eVh8r/lt/
         6JVNG21krNXNYSdCUMeDayc61uFisTI2zu9EYBOHwo7AILLCYLqPa8cQ0AjqnroZhqqi
         kUW2iv8aoBzJ5BfwR955Z4ncdvXvMBIMrPiKl39SYRtI5OCqAQsPQE3NJsehGK/cLZPg
         J8Y9040ager+/k56MGuy3hFbEEBG9ycVPyoCL0EyARXQA+nfHq9bvEVdEBGyadV3MGuN
         nQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721675374; x=1722280174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H46wDgBqFw0ZNrcJfr4LFF2KtCEo/8CP1rPHZLFS0ZQ=;
        b=wvMHWYvsbJ11E83YwrF9WGDWjlI0Ej9pWdoEMtz8cXlwwrWjBTKhr9aLPmB/dOLjg1
         pjsV6l7zpYSBg9PNaGdo14IYbudGQP1Sd1RGWDDWg/0Sujl6WG691aga1+VIqcKStuRw
         oy1Zi4Fs5VBMHrcEboDuOWURi3kiSB+hpKC1CxOx3jPeONpITvyz79Iqia/cbnVUzbsc
         bPu8xkIUL8g9UMu29YB5XuAbgfAnPiis+PM27Nhbv9g1PxglME85HaG68qtbWB/bziql
         CACgBZ7WiS1yHGuPkjjEKpZTVOKeBBDMv1KMFwzC1EBXfg/ETd4DaVSvBFQwysqelxZ8
         3LOA==
X-Forwarded-Encrypted: i=1; AJvYcCU2oAp6SRGYe+nD/angYqmlhq5stlPOG/4G2SO8dILSSkSRyCJsaQOKWzfUvnKsrTUNl35kGDpHCQ46iTzr3K7KQnxaJDIjKS8yhvbQ
X-Gm-Message-State: AOJu0YyHTzyMfajfPU93xHdwqRnI/6y79E9jJsY5ZSh7n1/glzVr/LjH
	7LAvY4cW7CZDUi0iXIKQV+RcroX1/jR7IXRC/nLJ4B/iJBQ4JZ4Tls0zmRZ2Gf1Aql4dTCECgv3
	HPBjUsfDvYyRZQM63aNfKyjFwRjUmZH+5dXkn
X-Google-Smtp-Source: AGHT+IHXDOYsKUgQNN+roGNoixtNmwmKEfv7H/r1voZOIiCRIGLdVfRhpTyNt8Q2yiz380ODwN0e5+knFVjhH0Z38U8=
X-Received: by 2002:a81:8a44:0:b0:62c:dcb2:a75b with SMTP id
 00721157ae682-66e4dcdb25amr6041807b3.38.1721675374203; Mon, 22 Jul 2024
 12:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708091241.544262971@infradead.org> <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net> <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
 <20240709142943.GL27299@noisy.programming.kicks-ass.net> <Zo1hBFS7c_J-Yx-7@casper.infradead.org>
 <20240710091631.GT27299@noisy.programming.kicks-ass.net> <20240710094013.GF28838@noisy.programming.kicks-ass.net>
In-Reply-To: <20240710094013.GF28838@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 22 Jul 2024 12:09:21 -0700
Message-ID: <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, 
	andrii@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	oleg@redhat.com, jolsa@kernel.org, clm@meta.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 2:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Jul 10, 2024 at 11:16:31AM +0200, Peter Zijlstra wrote:
>
> > If it were an actual sequence count, I could make it work, but sadly,
> > not. Also, vma_end_write() seems to be missing :-( If anything it could
> > be used to lockdep annotate the thing.

Thanks Matthew for forwarding me this discussion!

> >
> > Mooo.. I need to stare more at this to see if perhaps it can be made to
> > work, but so far, no joy :/
>
> See, this is what I want, except I can't close the race against VMA
> modification because of that crazy locking scheme :/

Happy to explain more about this crazy locking scheme. The catch is
that we can write-lock a VMA only while holding mmap_lock for write
and we unlock all write-locked VMAs together when we drop that
mmap_lock:

mmap_write_lock(mm);
vma_start_write(vma1);
vma_start_write(vma2);
...
mmap_write_unlock(mm); -> vma_end_write_all(mm); // unlocks all locked vmas

This is done because oftentimes we need to lock multiple VMAs when
modifying the address space (vma merge/split) and unlocking them
individually would be more expensive than unlocking them in bulk by
incrementing mm->mm_lock_seq.

>
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2146,11 +2146,58 @@ static int is_trap_at_addr(struct mm_str
>         return is_trap_insn(&opcode);
>  }
>
> -static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is=
_swbp)
> +#ifndef CONFIG_PER_VMA_LOCK
> +static struct uprobe *__find_active_uprobe(unsigned long bp_vaddr)
> +{
> +       return NULL;
> +}
> +#else

IIUC your code below, you want to get vma->vm_file without locking the
VMA. I think under RCU that would have been possible if vma->vm_file
were RCU-safe, which it's not (we had discussions with Paul and
Matthew about that in
https://lore.kernel.org/all/CAJuCfpHW2=3DZu+CHXL+5fjWxGk=3DCVix=3DC66ra+DmX=
gn6r3+fsXg@mail.gmail.com/).
Otherwise you could store the value of vma->vm_lock_seq before
comparing it with mm->mm_lock_seq, then do get_file(vma->file) and
then compare your locally stored vm_lock_seq against vma->vm_lock_seq
to see if VMA got locked for modification after we got the file. So,
unless I miss some other race, I think the VMA locking sequence does
not preclude you from implementing __find_active_uprobe() but
accessing vma->vm_file would be unsafe without some kind of locking.

> +static struct uprobe *__find_active_uprobe(unsigned long bp_vaddr)
>  {
>         struct mm_struct *mm =3D current->mm;
>         struct uprobe *uprobe =3D NULL;
>         struct vm_area_struct *vma;
> +       MA_STATE(mas, &mm->mm_mt, bp_vaddr, bp_vaddr);
> +
> +       guard(rcu)();
> +
> +again:
> +       vma =3D mas_walk(&mas);
> +       if (!vma)
> +               return NULL;
> +
> +       /* vma_write_start() -- in progress */
> +       if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->mm_l=
ock_seq))
> +               return NULL;
> +
> +       /*
> +        * Completely broken, because of the crazy vma locking scheme you
> +        * cannot avoid the per-vma rwlock and doing so means you're racy
> +        * against modifications.
> +        *
> +        * A simple actual seqcount would'be been cheaper and more useful=
l.
> +        */
> +
> +       if (!valid_vma(vma, false))
> +               return NULL;
> +
> +       struct inode =3D file_inode(vma->vm_file);
> +       loff_t offset =3D vaddr_to_offset(vma, bp_vaddr);
> +
> +       // XXX: if (vma_seq_retry(...)) goto again;
> +
> +       return find_uprobe(inode, offset);
> +}
> +#endif
> +
> +static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is=
_swbp)
> +{
> +       struct uprobe *uprobe =3D __find_active_uprobe(bp_vaddr)
> +       struct mm_struct *mm =3D current->mm;
> +       struct vm_area_struct *vma;
> +
> +       if (uprobe)
> +               return uprobe;
>
>         mmap_read_lock(mm);
>         vma =3D vma_lookup(mm, bp_vaddr);
>

