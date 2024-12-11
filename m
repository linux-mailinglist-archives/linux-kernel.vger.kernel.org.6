Return-Path: <linux-kernel+bounces-441514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68249ECF86
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3AF216721B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5550819DF9A;
	Wed, 11 Dec 2024 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KVuIeAzi"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED13246356
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930417; cv=none; b=oJ1jkmH636PEILeL/om8tIRTxsx1h19B8vGSzZ4XpP9+Jx3iKeKvJHXmZ0W2uvymliJLgWruZejhHlbDFpUR6CFBx+lCInabSgeUU0ODYc+82K0jHgRc8/9+F9l2AedgAQWUB2/9CYZaoTDQQKclfqTXTzIgB9eEhAaHsJiuKrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930417; c=relaxed/simple;
	bh=D2Cxqy9J4YNt0mGK/OtF+WWyPQA3cg++IsifvCKS8eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCsmCCJ+QeAlRWqT2FnOKUzbr28W2EzDkC4pt1bhwzUeER7NN9DrEjf3Dg8vo75skEXW6/3F8ysC1XXL9YJ/5pY7duNfa+FAxO8AthOjM/jg/rreZLAn57txLLivVpxt3pJTagPlmF65MuMD3PKf5mKWJCz9yH16dkyGGuzfMO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KVuIeAzi; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4674c22c4afso247471cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733930415; x=1734535215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brFp1j3FNkXikD4kXv2EisLQFnKxPJZnLCQQZU1UlHQ=;
        b=KVuIeAziz6Y84JLOJKEXstJ46R3NxVTBHTUjEwAqcfQ+0heSqfisDNyFp3ReSSKuyF
         ZjWBcrf8pUygI42SwJaPIyseqYEpy7CRCYNNPoEoXlmUfN/g0wMBmvc9W7Y1XwzKCDGd
         9W0mwAjzQ7pIDiUh2ZkTD+jeNgOAlgnZV4fr4H70vrrSNn3L4nAY4yLOqquWDHi/PKdg
         uiQobAvq9TMhUOvJ1TSO7LxJ2Q56fmRNWsxhnOwICy6jezQJmDmoNqg2kie5tVSLEyQs
         /Y6OMlYdWwAAJNGMFP0x9wA2gXphwQ1IEQk8XqfRejKIhX/tDpCYyTyyciKDFF+rS2C9
         PAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733930415; x=1734535215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brFp1j3FNkXikD4kXv2EisLQFnKxPJZnLCQQZU1UlHQ=;
        b=VmHejzH0fuI94nNo6ySGjTbL/psP0kU1GXYSkLiyOWrEsQnvm/wxFKFqo3pvZCci2/
         q7wH9N7ckI/wibewJd67mbiPHuWoPdFvwm8imtdZ2Y/ewMKOi+f2pSA2bTmQ/pNv9/uy
         jeGhHK/BLjTDIN/fo2JGmGseLSmmZa5TVWgyEEBz8uoTbfsxCWI9rYSQgTgn6UIwrvQ+
         Tc7UgzCGab9fFPVPOgbxzUPuSp6sFAElChTd0Uz9cKZ5UZoC3r7Q3l/+CCivsSXueSjX
         X0fE92c/SZXnC8hAXkovdgHOydyGPmCDkg2a/pondEBZ/8pkjBREGcc2tLvA37xPh7AH
         NQHw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/eca3VtIGdTGIEDw9qWXkfo+xZRMk3GAOBmb4hOf8x5nRehNtG8FxBRZNMzDkEvxIjDytIQZBQTq7cM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5emutRgvTZfe9H9xX9WV+hrJYlYYUEEx6YS9qs53yw/9WpSy6
	ua4UG2EZvNE5DE5SRRpek1ha4DQCDo3aenq9FHxG/f2REzr+GZMF87DYkyfvnJ71rKJS0UwiB1T
	tyBLH74mNGyRKz2cc2U6bGO/d/tMaEHYWA8VO
X-Gm-Gg: ASbGncvjXVlBfCEm0YGIyCzmCgQUAcngtKwM/zHSin02msNRQ2IY0ux+3fPZDgT8JHG
	+sBjhI4olZ5z4vViNVezyyYdh+ki8LLSWlYJWi+NypjRG7UKez6n9xMFvPlOprBLDew==
X-Google-Smtp-Source: AGHT+IHu2VbMB49y+iTCluJ2NomAiKyndnfffuEwxHdnIL3N6UHlxRCiW6C/XC3v82eUhvtJIDU+dvXD+IWEY4VEzKg=
X-Received: by 2002:a05:622a:5a99:b0:466:9003:aae6 with SMTP id
 d75a77b69052e-46788c83ae6mr5044671cf.2.1733930414668; Wed, 11 Dec 2024
 07:20:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <20241111205506.3404479-4-surenb@google.com>
 <ZzLgZTH9v5io1Elx@casper.infradead.org> <CAJuCfpHpGSpix8+mB76Virb+HAMrOqB3wG8E4EXPrRCnBoBGeA@mail.gmail.com>
 <20241210223850.GA2484@noisy.programming.kicks-ass.net> <CAJuCfpETJZVFYwf+P=6FnY_6n8E7fQsKH6HrOV1Q_q9cFizEKw@mail.gmail.com>
 <20241211082541.GQ21636@noisy.programming.kicks-ass.net>
In-Reply-To: <20241211082541.GQ21636@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 11 Dec 2024 07:20:03 -0800
Message-ID: <CAJuCfpEMYhAmOPwjGO+j1t+069MJZxUs1O1co-zJ4+vEeXCtng@mail.gmail.com>
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

On Wed, Dec 11, 2024 at 12:25=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Tue, Dec 10, 2024 at 03:37:50PM -0800, Suren Baghdasaryan wrote:
>
> > > Replace vm_lock with vm_refcnt. Replace vm_detached with vm_refcnt =
=3D=3D 0
> > > -- that is, attach sets refcount to 1 to indicate it is part of the m=
as,
> > > detached is the final 'put'.
> >
> > I need to double-check if we ever write-lock a detached vma. I don't
> > think we do but better be safe. If we do then that wait-until() should
> > accept 0x8000'0001 as well.
>
> vma_start_write()
>   __is_vma_write_locked()
>     mmap_assert_write_locked(vma->vm_mm);
>
> So this really should hold afaict.
>
> > > RCU lookup does the inc_not_zero thing, when increment succeeds, comp=
are
> > > mm/addr to validate.
> > >
> > > vma_start_write() already relies on mmap_lock being held for writing,
> > > and thus does not have to worry about writer-vs-writer contention, th=
at
> > > is fully resolved by mmap_sem. This means we only need to wait for
> > > readers to drop out.
> > >
> > > vma_start_write()
> > >         add(0x8000'0001); // could fetch_add and double check the hig=
h
> > >                           // bit wasn't already set.
> > >         wait-until(refcnt =3D=3D 0x8000'0002); // mas + writer ref
> > >         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> > >         sub(0x8000'0000);
> > >
> > > vma_end_write()
> > >         put();
> >
> > We don't really have vma_end_write(). Instead it's vma_end_write_all()
> > which increments mm_lock_seq unlocking all write-locked VMAs.
> > Therefore in vma_start_write() I think we can sub(0x8000'0001) at the
> > end.
>
> Right, I know you don't, but you should :-), I've suggested adding this
> before.

I'll look into adding it. IIRC there was some issue with that but I
can't recall...

>
> > > vma_start_read() then becomes something like:
> > >
> > >         if (vm_lock_seq =3D=3D mm_lock_seq)
> > >           return false;
> > >
> > >         cnt =3D fetch_inc(1);
> > >         if (cnt & msb || vm_lock_seq =3D=3D mm_lock_seq) {
> > >           put();
> > >           return false;
> > >         }
> > >
> > >         return true;
> > >
> > > vma_end_read() then becomes:
> > >         put();
> > >
> > >
> > > and the down_read() from uffffffd requires mmap_read_lock() and thus
> > > does not have to worry about writers, it can simpy be inc() and put()=
,
> > > no?
> >
> > I think your proposal should work. Let me try to code it and see if
> > something breaks.
>
> Btw, for the wait-until() and put() you can use rcuwait; that is the
> simplest wait form we have. It's suitable because we only ever have the
> one waiter.

Yes, Davidlohr mentioned that before. I'll do that. Thanks!

