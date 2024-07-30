Return-Path: <linux-kernel+bounces-268011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5A0941F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445D72838A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A371618B46F;
	Tue, 30 Jul 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFXf+JPq"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C63188011
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363416; cv=none; b=lAHyjG0+TM8cKF//pJogjVobXAzJUJ+KAM7UA99hVpre6PBExEoBRw9xYHx3okE9FCkG8AEMA5i9FZt32WnF9kK21q8aYrETviWHMJ/32g0z6Ptyol7DNMg60/F329JkTB0xSlh6dTzmCczuz87HUnTvpiJU7McWZgfX7tlfT9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363416; c=relaxed/simple;
	bh=Ul43gLbjNXWv7uRvKDtkvWpbdFBiooyNeOeGbLSZUjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgwUWS8/B4IFzIzrTTHWYmyr7ed9yPGHYFuHKsXn73UMB3HzubHhL2V+t1Vi1+ULw6kqJFN0D1pOMuTz4ZF9G+mXLRM3WoT9JLyQnVQPKozb8/lE6/p+bUlGxRO8/nrXIH+WvD+V4TXXWwypQzcWBs9nxFhMSGl1d4RY+MorgqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFXf+JPq; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-682ff2f0e67so9567567b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722363414; x=1722968214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paocBMwYt9SJaAdh3bFfHBQaAh4S+xZQ2Uh5KYKzhR8=;
        b=IFXf+JPqkKDXs9eJ7+Fxr9bxUpOORnU1NN/Uf+SQHStRhH6N18Vs6hZvqjzRxkqEg1
         7Qrw7gRIPPOmX6DTIe8+OkfyAEljGCjoFuOs9VtL4IIHwUggPvaxsZpWIjrAj3Ie7sQa
         U7lrQgwJhDBAh9TY/9xI3B/0WOxc7T45PPzDBYyJ0G5JUuOsZvKpNdyD+UWd3HNbWnrV
         /n7QZy9V1BReCANvGBFcfe8Vww8fsWTGi6AriHhMmHOkJY8zkH925zrVvPad42Pjts0e
         IZteP1lp7n6G8VeekMUAkn2/T1ebVOTC4Go9opMDwF23zhvJzP0NduAOCHj/mskr/+Yh
         j3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722363414; x=1722968214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paocBMwYt9SJaAdh3bFfHBQaAh4S+xZQ2Uh5KYKzhR8=;
        b=dIyPP8QvGJCM1zQz8JfXbhMIj/fJTtoUFBpyZAR9YG06hSoFUQZGb3D6XQ7kFYIy5i
         t33/9D5PReDG2F8HOTpjaF1OafX7H6qkWNtUxTdUUzw4dhqJL5jWIchgpRZSrnFhDI1h
         Tg7Ko2KwlfC87RG9WATbZajbQgnETJpEcp6ZSDx/eTqw9eKnJzqpjRgXryThSzC1X79z
         qYVlHhZXwjxDKNk5AUexWrj6wfDBikDNOeeLhRp/bMmdTsyjm56LIkVTay/+MgA14bWo
         sY+kEF+dJ6ncMWrK5Cxji/m2nKiy8GKtnTBAAHsRHFrEY8zRr1NgGM3BROyswTBJZRGu
         T9Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVUbizvTPqKf7L42KciM4B5tjDgj0j9Tj+hGmRzxVo7NbJN9CnzqktSlyyeT5p7+LzuVJ8kH1fnNzV6l5WvOKBbKnN+MIEeZDnT1Oe8
X-Gm-Message-State: AOJu0YwZeMixjs2esEfHlxZA3I0QaoSn976jj0CJHvDdA8/FiV9ab6WV
	4XCvuFPflUqGxivYlQ3305cURhuD87+epJIt/UNETGrvCu6zu9Ktb8qOSOqQjfxM69duaRyiSCv
	f6MkeZmAXuqBA3c04EZ0pC0r5hgxnWu+TCymR
X-Google-Smtp-Source: AGHT+IHFivZ3+xvePr2SKWqE39RES1Ldta9R2db5dN+dbK9pahJeQgXCGle0FrjZBceBG7nZrXuY7oqZgHnUXnjfzP4=
X-Received: by 2002:a0d:f4c7:0:b0:65f:cda7:b065 with SMTP id
 00721157ae682-67a04ffe8bcmr102099007b3.9.1722363414000; Tue, 30 Jul 2024
 11:16:54 -0700 (PDT)
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
 <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com> <20240730134605.GO33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240730134605.GO33588@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 30 Jul 2024 11:16:40 -0700
Message-ID: <CAJuCfpFLig1R1dKN+LiicEe3=fJpFxdC233kZ1xh8kvYSYDHRg@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, 
	andrii@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	oleg@redhat.com, jolsa@kernel.org, clm@meta.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:46=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Jul 22, 2024 at 12:09:21PM -0700, Suren Baghdasaryan wrote:
> > On Wed, Jul 10, 2024 at 2:40=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Wed, Jul 10, 2024 at 11:16:31AM +0200, Peter Zijlstra wrote:
> > >
> > > > If it were an actual sequence count, I could make it work, but sadl=
y,
> > > > not. Also, vma_end_write() seems to be missing :-( If anything it c=
ould
> > > > be used to lockdep annotate the thing.
> >
> > Thanks Matthew for forwarding me this discussion!
> >
> > > >
> > > > Mooo.. I need to stare more at this to see if perhaps it can be mad=
e to
> > > > work, but so far, no joy :/
> > >
> > > See, this is what I want, except I can't close the race against VMA
> > > modification because of that crazy locking scheme :/
> >
> > Happy to explain more about this crazy locking scheme. The catch is
> > that we can write-lock a VMA only while holding mmap_lock for write
> > and we unlock all write-locked VMAs together when we drop that
> > mmap_lock:
> >
> > mmap_write_lock(mm);
> > vma_start_write(vma1);
> > vma_start_write(vma2);
> > ...
> > mmap_write_unlock(mm); -> vma_end_write_all(mm); // unlocks all locked =
vmas
> >
> > This is done because oftentimes we need to lock multiple VMAs when
> > modifying the address space (vma merge/split) and unlocking them
> > individually would be more expensive than unlocking them in bulk by
> > incrementing mm->mm_lock_seq.
>
> Right, but you can do that without having it quite this insane.

I'm happy to take any suggestions that would improve the current mechanism.

>
> You can still make mm_lock_seq a proper seqcount, and still have
> vma_end_write() -- even if its an empty stub only used for validation.

It's doable but what will we be validating here? That the vma is indeed loc=
ked?

>
> That is, something like the below, which adds a light barrier, ensures
> that mm_lock_seq is a proper sequence count.
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index de9dc20b01ba..daa19d1a3022 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -104,6 +104,8 @@ static inline void mmap_write_lock(struct mm_struct *=
mm)
>  {
>         __mmap_lock_trace_start_locking(mm, true);
>         down_write(&mm->mmap_lock);
> +       WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq+1);
> +       smp_wmb();
>         __mmap_lock_trace_acquire_returned(mm, true, true);
>  }

Ok, I'll try the above change and check the benchmarks for any regressions.
Thanks for the suggestions, Peter!

>
>
> With the above addition we could write (although I think we still need
> the RCU_SLAB thing on files_cachep):
>
> static struct uprobe *__find_active_uprobe(unsigned long bp_vaddr)
> {
>         struct mm_struct *mm =3D current->mm;
>         struct uprobe *uprobe =3D NULL;
>         struct vm_area_struct *vma;
>         struct inode *inode;
>         loff_t offset;
>         int seq;
>
>         guard(rcu)();
>
>         seq =3D READ_ONCE(mm->mm_lock_seq);
>         smp_rmb();
>         do {
>                 vma =3D find_vma(mm, bp_vaddr);
>                 if (!vma)
>                         return NULL;
>
>                 if (!valid_vma(vma, false))
>                         return NULL;
>
>                 inode =3D file_inode(vma->vm_file);
>                 offset =3D vaddr_to_offset(vma, bp_vaddr);
>
>         } while (smp_rmb(), seq !=3D READ_ONCE(mm->mm_lock_seq));
>
>         return find_uprobe(inode, offset);
> }
>

