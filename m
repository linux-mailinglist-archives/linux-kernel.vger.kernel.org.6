Return-Path: <linux-kernel+bounces-440514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6B89EBF81
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68B2188AE68
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1D1225A33;
	Tue, 10 Dec 2024 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x+0eqxQU"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B016B225A22
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733873884; cv=none; b=hGKaTBnmV5jJhEqIp1e1w7mTXMiQUJdIiFyAj1p4s2U4vuvVSs8yLdCku/ujaTcG9/CT0q5FW5nfLLSREHcsHmEGhPcKngNZB+WTfaYVgYzJTGhPUpWkktNo9nkaPYcIZad+1NZzg1zNXmPb2ssDWcoAXF2L5rkTkAZYuZ8GngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733873884; c=relaxed/simple;
	bh=CIRYSdyvuK7eTruNeed8tolmP53zFL7MixtgpYTu72k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFEZr6eTvVwK2oQ9dDSAiF5AMRBQHGlzeAkqismcKXPiyVl6208Kq+bHoKo5W5jOReIFQj0tWt0/jgCuNcjsDOKhwaYdb3yUCPk+4vLCKLCbLgU+GRilaqP9caOl5JJB7cYCyZQ3XNTc+IwaHcmkhHv45UT2cJj+tuUZH/j9TF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x+0eqxQU; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4674c22c4afso30841cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733873881; x=1734478681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu2SYWJsLxhdZs4rx8neOqZ9H9vIwKibAwt/zeZ9+H0=;
        b=x+0eqxQUWY44hRoDy8ZXW6iiFbesoCg4ZdWSmJmQVKNVRZ8Ao3uqdKlUrHhaMQPNSV
         UFvZM1HdHcftDUpM+/WBxovNbbkjQwsIKekirUwZ2HXtBbykuzb32X44Z8BhC3H3FxC6
         W2nDi/uqCfxzJon1VwdmxENgZtITIaQLJ0cKP+slfvuTMxevOnzTQ0U7+RaeWH+6MW0v
         UBIYvf59mTF1JneGEOMUckkwSIe/8bTNqXoLUMruKRD7ductQjOBCjTzmXAvRG7t9sEM
         bJVY9fLRmU5tvF68S9BFz9RG92QbEVLI5UUfVrb3Z0RA6LQABPPcZWB10fbfMbSMaBU6
         ymnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733873881; x=1734478681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uu2SYWJsLxhdZs4rx8neOqZ9H9vIwKibAwt/zeZ9+H0=;
        b=J5aMSxZ9IRKZq+SYWLGDK7ksF3fZZ//AaByu4fyosdYzQ7MX8t5tMPWYPyXbHcI8Cn
         Yua08e+n4oJ+HJqBDUWrm/9PQesdTeeBS+R+kiEWjxXQVxaIgLISvoYKc2oSZN/JYrUL
         aa+DKU3PU0dszxRCvNg8GlGDbxQZkacwuEbOQtCksqtT6uxfffNN4rkAVk3ZqcqWz6Bz
         OosPrisp3cFFRvAhW2o/gA/YZcNEM15f/pDKMH9DG2HyD3PXrQ0EAs2GtEemOj3pkIT+
         L/1fR/7OaJAzjYVg5/kwfOhOrbFXdBRHbiatcg2k/uze48DhscA0GpeWVrluzn4NdAqr
         3oiw==
X-Forwarded-Encrypted: i=1; AJvYcCUKOfcoFcHNR4ZfHAevP3J0pArt0izvV+HhneV7dkAYZhf00Ano3IoXar0ImL/pY8k2oijJCxHQ++g0O2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7or/9i34GqQu9QWmGysfk5GlIzdpOW2wDtVQyhn/SWBk6nap
	0FAW8XWMb9b4hlMUedFCp+1g1rab7pjyQowSb3IXOZzuVuh8ZDp29Lx5HYev0KMBCyuQOcpwhip
	DfddmhwzwwJFN52donW52TgYrhX0AKE9k/UaT
X-Gm-Gg: ASbGncsCWvnLkj5f13XOHuhqQ9pCPXJoUoTqn1sZwhYE9zur9o5CoR7d6eiwinPRV8i
	TpGk2NDSr207ykTNkoiZjobkQKyjWJkl2agsqRDrelHxlPiidW/aNJAw8Yvs6Vurdc5rQ
X-Google-Smtp-Source: AGHT+IGVBhSdLp0As/jnqYKsN1aao1rI32aOWTfzLBLFYeCOWRS7Ts77DeQuAR9U51StXOPpmkFzjIEqygtIUoqBAKY=
X-Received: by 2002:a05:622a:1928:b0:466:8a29:9de7 with SMTP id
 d75a77b69052e-46788c830b3mr1583661cf.12.1733873881306; Tue, 10 Dec 2024
 15:38:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <20241111205506.3404479-4-surenb@google.com>
 <ZzLgZTH9v5io1Elx@casper.infradead.org> <CAJuCfpHpGSpix8+mB76Virb+HAMrOqB3wG8E4EXPrRCnBoBGeA@mail.gmail.com>
 <20241210223850.GA2484@noisy.programming.kicks-ass.net>
In-Reply-To: <20241210223850.GA2484@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 10 Dec 2024 15:37:50 -0800
Message-ID: <CAJuCfpETJZVFYwf+P=6FnY_6n8E7fQsKH6HrOV1Q_q9cFizEKw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 2:39=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Nov 12, 2024 at 07:18:45AM -0800, Suren Baghdasaryan wrote:
> > On Mon, Nov 11, 2024 at 8:58=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Mon, Nov 11, 2024 at 12:55:05PM -0800, Suren Baghdasaryan wrote:
> > > > When a reader takes read lock, it increments the atomic, unless the
> > > > top two bits are set indicating a writer is present.
> > > > When writer takes write lock, it sets VMA_LOCK_WR_LOCKED bit if the=
re
> > > > are no readers or VMA_LOCK_WR_WAIT bit if readers are holding the l=
ock
> > > > and puts itself onto newly introduced mm.vma_writer_wait. Since all
> > > > writers take mmap_lock in write mode first, there can be only one w=
riter
> > > > at a time. The last reader to release the lock will signal the writ=
er
> > > > to wake up.
> > >
> > > I don't think you need two bits.  You can do it this way:
> > >
> > > 0x8000'0000 - No readers, no writers
> > > 0x1-7fff'ffff - Some number of readers
> > > 0x0 - Writer held
> > > 0x8000'0001-0xffff'ffff - Reader held, writer waiting
> > >
> > > A prospective writer subtracts 0x8000'0000.  If the result is 0, it g=
ot
> > > the lock, otherwise it sleeps until it is 0.
> > >
> > > A writer unlocks by adding 0x8000'0000 (not by setting the value to
> > > 0x8000'0000).
> > >
> > > A reader unlocks by adding 1.  If the result is 0, it wakes the write=
r.
> > >
> > > A prospective reader subtracts 1.  If the result is positive, it got =
the
> > > lock, otherwise it does the unlock above (this might be the one which
> > > wakes the writer).
> > >
> > > And ... that's it.  See how we use the CPU arithmetic flags to tell u=
s
> > > everything we need to know without doing arithmetic separately?
> >
> > Yes, this is neat! You are using the fact that write-locked =3D=3D no
> > readers to eliminate unnecessary state. I'll give that a try. Thanks!
>
> The reason I got here is that Vlastimil poked me about the whole
> TYPESAFE_BY_RCU thing.
>
> So the normal way those things work is with a refcount, if the refcount
> is non-zero, the identifying fields should be stable and you can
> determine if you have the right object, otherwise tough luck.
>
> And I was thinking that since you abuse this rwsem you have, you might
> as well turn that into a refcount with some extra.
>
> So I would propose a slightly different solution.
>
> Replace vm_lock with vm_refcnt. Replace vm_detached with vm_refcnt =3D=3D=
 0
> -- that is, attach sets refcount to 1 to indicate it is part of the mas,
> detached is the final 'put'.

I need to double-check if we ever write-lock a detached vma. I don't
think we do but better be safe. If we do then that wait-until() should
accept 0x8000'0001 as well.

>
> RCU lookup does the inc_not_zero thing, when increment succeeds, compare
> mm/addr to validate.
>
> vma_start_write() already relies on mmap_lock being held for writing,
> and thus does not have to worry about writer-vs-writer contention, that
> is fully resolved by mmap_sem. This means we only need to wait for
> readers to drop out.
>
> vma_start_write()
>         add(0x8000'0001); // could fetch_add and double check the high
>                           // bit wasn't already set.
>         wait-until(refcnt =3D=3D 0x8000'0002); // mas + writer ref
>         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
>         sub(0x8000'0000);
>
> vma_end_write()
>         put();

We don't really have vma_end_write(). Instead it's vma_end_write_all()
which increments mm_lock_seq unlocking all write-locked VMAs.
Therefore in vma_start_write() I think we can sub(0x8000'0001) at the
end.

>
> vma_start_read() then becomes something like:
>
>         if (vm_lock_seq =3D=3D mm_lock_seq)
>           return false;
>
>         cnt =3D fetch_inc(1);
>         if (cnt & msb || vm_lock_seq =3D=3D mm_lock_seq) {
>           put();
>           return false;
>         }
>
>         return true;
>
> vma_end_read() then becomes:
>         put();
>
>
> and the down_read() from uffffffd requires mmap_read_lock() and thus
> does not have to worry about writers, it can simpy be inc() and put(),
> no?

I think your proposal should work. Let me try to code it and see if
something breaks.
Thanks Peter!

