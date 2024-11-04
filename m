Return-Path: <linux-kernel+bounces-395576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447499BC004
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FD7282527
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38AE1FCC6C;
	Mon,  4 Nov 2024 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y7H/7SrT"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F5C1D54C0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755593; cv=none; b=P/rNwdtItmapnFMcL7f9UTzduZAWZe+Vr0wmmAzael9MrKzMOQFynrSjmJVhvFuO1GWHZv/I3e8jWLtNjdFgiIggAFhGNpGjl2kdkFT+zFWrhCE8cwSc54AYvUUbJniUkvRNxvSadsQXKqMTj4a7XHB3e2CWle6GIhAAS3VzLEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755593; c=relaxed/simple;
	bh=3bZsS52AgKNDqZvlI0agfAE51dfAkD/uOyCsrBwBHlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KErp9OtyhJjVdYLOVncd0gCPonpk9+yb9lxzUJj0dBxdMnXSSQCtsHCLuUzP2P6rWh3yRmB590I4WZp6Kz8oj0zNt0/WtuK0NH0kroNXwhM9qhGWyrhX69gw25YT1FrBbFvj/pPrfhy9WlamU0WcyS19Ei88k5U9ShLut7UWF6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y7H/7SrT; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e681ba70so1356e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 13:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730755589; x=1731360389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioV/dL07mv9AW1513MtHFX0/Uum+Qg2GuPUOPrtpBeA=;
        b=y7H/7SrTHExdWog9nIM8KjKVXa4K+clvWtP1sIj7Q+091kDcJgSzjdh+4ImvDJCkfJ
         /uNq13laLaBgK67Ey1GnKdZbx3XZK0TuZ2aAfrYGJoGuOtHtrwSKDGtcvfOJjiUx4T6D
         sRfBs1F+z6M9KFpImgcIOweyPvCaEDBLu315cjvmcYe7I4/OlOzrm5SCoifMuNdYvzzk
         fCJJXVMslAWKK0vQjZvsibPw0jSgCu95KKTalKBz/UUBanp65kRZ67euReLT54UkVyCn
         eFQ9DaZ94tDhKsSyuwk8hO5+bfXbbTRzNO+IX+dLYvXHaSKj8SvOOrnNPLddToDaZypO
         DmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755589; x=1731360389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioV/dL07mv9AW1513MtHFX0/Uum+Qg2GuPUOPrtpBeA=;
        b=NlHQSXBv4GFmRvGcLbcCRqaj6JDoXJ2Q87tHngMmYfEEqKE3ZrVy/rcaaeqNgp9N/h
         mMTHlAgnLy5yyGFYQXLW/ErAElnSymkVuilfiHApUR+xKYWMeMWk5mNA3C7TGJk8FE4O
         10XwQUj3YPTfeUdL4AhQptu8LKj74F/5E/uSpcKWhqW8PLZ5LjpsdJs8r5xuHoI/kiYu
         sMeaeQxJ1fTZNzZFFwTYJqOtvxl1JFhkM4XfLFGgfABiwrjF1jCEfxroErcN+qgwLTz0
         bexPoOUz6OnQ2WSmEIlVYCP3zxKcMVFWcYBPyB5iTVzguMTZF184UMxrek7D4t6W6dgs
         CwQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlXhjVy1QVGV+1eLNoiaY7maWqw78NECxvyYPMC9M0bcIjRjbBfh3ZN+RP2S7f36Ot78lMXsBMDtEdjpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQhfYOt7e73tQ2161UAu8Owx40gbzVSJuz1DNDTfvY2yyqEphf
	Jxmm3kB8korO5YahQaaNl2zA/cnwD/YuuOQvyHdoE+M8yTQm+QHYlsL0ULLwMCe26KA+zr7ANGm
	jpeOtI4vFFcvcd7keJymJs9/Hki/RNGaJ6+iq
X-Gm-Gg: ASbGncvJH63VC4XNsTJJc7d2ajkEY1e9xdqCL1l2gxOsNUg+7YOSMpA9KN3U93qay4X
	TBZpvRVKkTaxxJtJPjg6+7if7n6jWVT33ON3/K0y6e4aW1nUTk8HK+OFbbVQ=
X-Google-Smtp-Source: AGHT+IH6R4d/hC/lwyft9RVEnMEbq2YoOGPdQlrePd5m8ZFmQ7lY9g7VTeIfA5PsHS/hHKz5PrijBkxMZmNU3DWbS5M=
X-Received: by 2002:a19:385c:0:b0:535:3d14:1313 with SMTP id
 2adb3069b0e04-53d78288ecemr107678e87.0.1730755588860; Mon, 04 Nov 2024
 13:26:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <CAJuCfpEo2RyBLpariVgKBjQrZxdHuhMCgOGYfESZsYOPMD5vBw@mail.gmail.com> <03cc76df-8814-4d0a-83a6-447212ef2370@lucifer.local>
In-Reply-To: <03cc76df-8814-4d0a-83a6-447212ef2370@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Mon, 4 Nov 2024 22:25:51 +0100
Message-ID: <CAG48ez1kHkAd=EEmL1jxFXN9tiqTKVshMYYBZ0uv3PvgKJD05g@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:04=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Mon, Nov 04, 2024 at 09:01:46AM -0800, Suren Baghdasaryan wrote:
> > On Fri, Nov 1, 2024 at 11:51=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > +MM and VMA locks
> > > +----------------
> > > +
> > > +There are two key classes of lock utilised when reading and manipula=
ting VMAs -
> > > +the `mmap_lock` which is a read/write semaphore maintained at the `m=
m_struct`
> > > +level of granularity and, if CONFIG_PER_VMA_LOCK is set, a per-VMA l=
ock at the
> > > +VMA level of granularity.
> > > +
> > > +.. note::
> > > +
> > > +   Generally speaking, a read/write semaphore is a class of lock whi=
ch permits
> > > +   concurrent readers. However a write lock can only be obtained onc=
e all
> > > +   readers have left the critical region (and pending readers made t=
o wait).
> > > +
> > > +   This renders read locks on a read/write semaphore concurrent with=
 other
> > > +   readers and write locks exclusive against all others holding the =
semaphore.
> > > +
> > > +If CONFIG_PER_VMA_LOCK is not set, then things are relatively simple=
 - a write
> > > +mmap lock gives you exclusive write access to a VMA, and a read lock=
 gives you
> > > +concurrent read-only access.
> > > +
> > > +In the presence of CONFIG_PER_VMA_LOCK, i.e. VMA locks, things are m=
ore
> > > +complicated. In this instance, a write semaphore is no longer enough=
 to gain
> > > +exclusive access to a VMA, a VMA write lock is also required.
> >
> > I think "exclusive access to a VMA" should be "exclusive access to mm"
> > if you are talking about mmap_lock.
>
> Right, but in the past an mm write lock was sufficient to gain exclusive
> access to a _vma_. I will adjust to say 'write semaphore on the mm'.

We might want to introduce some explicit terminology for talking about
types of locks in MM at some point in this document. Like:

 - "high-level locks" (or "metadata locks"?) means mmap lock, VMA
lock, address_space lock, anon_vma lock

 - "pagetable-level locks" means page_table_lock and PMD/PTE spinlocks

 - "write-locked VMA" means mmap lock is held for writing and VMA has
been marked as write-lock

 - "rmap locks" means the address_space and anon_vma locks
   - "holding the rmap locks for writing" means holding both (if applicable=
)
   - "holding an rmap lock for reading" means holding one of them

 - "read-locked VMA" means either mmap lock held for reading or VMA
lock held for reading

That might make it a bit easier to write concise descriptions of
locking requirements in the rest of this document and keep them

> > > +The VMA lock is implemented via the use of both a read/write semapho=
re and
> > > +per-VMA and per-mm sequence numbers. We go into detail on this in th=
e VMA lock
> > > +internals section below, so for the time being it is important only =
to note that
> > > +we can obtain either a VMA read or write lock.
> > > +
> > > +.. note::
> > > +
> > > +   VMAs under VMA **read** lock are obtained by the `lock_vma_under_=
rcu()`
> > > +   function, and **no** existing mmap or VMA lock must be held, This=
 function
> >
> > "no existing mmap or VMA lock must be held" did you mean to say "no
> > exclusive mmap or VMA locks must be held"? Because one can certainly
> > hold a read-lock on them.
>
> Hmm really? You can hold an mmap read lock and obtain a VMA read lock too
> irrespective of that?

I think you can call lock_vma_under_rcu() while already holding the
mmap read lock, but only because lock_vma_under_rcu() has trylock
semantics. (The other way around leads to a deadlock: You can't take
the mmap read lock while holding a VMA read lock, because the VMA read
lock may prevent another task from write-locking a VMA after it has
already taken an mmap write lock.)

> > > +mmap write lock downgrading
> > > +---------------------------
> > > +
> > > +While it is possible to obtain an mmap write or read lock using the
> > > +`mm->mmap_lock` read/write semaphore, it is also possible to **downg=
rade** from
> > > +a write lock to a read lock via `mmap_write_downgrade()`.
> > > +
> > > +Similar to `mmap_write_unlock()`, this implicitly terminates all VMA=
 write locks
> > > +via `vma_end_write_all()` (more or this behaviour in the VMA lock in=
ternals
> > > +section below), but importantly does not relinquish the mmap lock wh=
ile
> > > +downgrading, therefore keeping the locked virtual address space stab=
le.
> > > +
> > > +A subtlety here is that callers can assume, if they invoke an
> > > +mmap_write_downgrade() operation, that they still have exclusive acc=
ess to the
> > > +virtual address space (excluding VMA read lock holders), as for anot=
her task to
> > > +have downgraded they would have had to have exclusive access to the =
semaphore
> > > +which can't be the case until the current task completes what it is =
doing.
> >
> > I can't decipher the above paragraph. Could you please dumb it down
> > for the likes of me?
>
> Since you're smarter than me this indicates I am not being clear here :)
> Actually reading this again I've not expressed this correctly.
>
> This is something Jann mentioned, that I hadn't thought of before.
>
> So if you have an mmap write lock, you have exclusive access to the mmap
> (with the usual caveats about racing vma locks unless you vma write lock)=
.
>
> When you downgrade you now have a read lock - but because you were
> exclusive earlier in the function AND any new caller of the function will
> have to acquire that same write lock FIRST, they all have to wait on you
> and therefore you have exclusive access to the mmap only with a read map.
>
> So you are actually guaranteed that nobody else can be racing you _in tha=
t
> function_, and equally no other writers can arise until you're done as yo=
ur
> holding the read lock prevents that.
>
> Jann - correct me if I'm wrong or missing something here.
>
> Will correct this unless Jann tells me I'm missing something on this :)

Yeah, basically you can hold an rwsem in three modes:

 - reader (R)
 - reader that results from downgrading a writer (D)
 - writer (W)

and this is the diagram of which excludes which (view it in monospace,
=E2=9C=94 means mutually exclusive):

  | R | D | W
=3D=3D|=3D=3D=3D|=3D=3D=3D|=3D=3D=3D
R | =E2=9C=98 | =E2=9C=98 | =E2=9C=94
--|---|---|---
D | =E2=9C=98 | =E2=9C=94 | =E2=9C=94
--|---|---|---
W | =E2=9C=94 | =E2=9C=94 | =E2=9C=94

So the special thing about downgraded-readers compared to normal
readers is that they exclude other downgraded-readers.

