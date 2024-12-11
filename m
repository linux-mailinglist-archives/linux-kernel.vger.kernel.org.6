Return-Path: <linux-kernel+bounces-441634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4698E9ED0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AC1188674F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A531DAC89;
	Wed, 11 Dec 2024 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NacfUhYh"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880321DA103
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933660; cv=none; b=Cw22qMJsaYHuoAmKYyi3aO3IxgZu2+o5vApTiHmBS08oCM7+4u0Ebo5e+3n8QevuQdYIGQF6lsLNGP/obAuhx6fN+Y91cZqIg5JkBgSD4ezr7OlLBmh9N1YCQhC69HpdqjV2HkuZcYD+dg4yv17nOUnP4xTYaI+Sh/PZ7rXiqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933660; c=relaxed/simple;
	bh=g97i63BeRfkeQhxv7hMs2P0YOtRY6jivirL1JdhkWi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIHDFeUKISW+uUDuAj2Nr/UqPdw8lfMwt/A1OkFmeil3JskzH9UCkKuJGPesrHkz9Sd6MFE9Gy2Ae7ggpLxLaXyE+zdwTc+w2ny5ukcrYOymxYUJzFAZOpHMTolUW5138vUOCYcw4ZtNO4t1lbIQDbJzTUVeeqflEDstO0xDKeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NacfUhYh; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4678c9310afso208241cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733933657; x=1734538457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phElHLYxkNBYJyvyG4lECOcpRVx5oOVRU61JUuf+v3s=;
        b=NacfUhYhvkWov6vs7esLNalXJFoBXMPwoY33+PsngATfHi39812CPVb4W8GPS4CCCi
         rSSw5sBYmydvOjLLY83HVfbfqiu+ihw9EYCPnDG+O3HTel+u1JAsRmTSa6pQBAQlCyHf
         r+aSrhakw7RKX/cvIKC/8RNH/DL++padnBUmd6wtlsas1WOe+t4KDobymcGMsPE+Ya/I
         qSWp4XFtfdhwkjdIrDVOHQoon5NgHsENiYYMyQjVNhRq5onKZ/BL5E+UShtqIX4gsd91
         Xgc0RGj3BaIl7EM8GhREDiVcNpud2sdv3ljmJKueHlwWVBEHVoojPPUMNdIq+L+YhAx/
         oJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933657; x=1734538457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phElHLYxkNBYJyvyG4lECOcpRVx5oOVRU61JUuf+v3s=;
        b=vhWEQtDZbXOk/+1n8Ck/okrkP9zibkKfoz1UTYRpMA7y9OZ/eR+baeNP496GG2TAt6
         M8PZzr5LhLNZNn5rbbz0lzaD8nQpAzHWPhFjMgFErDqhXeksm8iVRACXcpi2qqnsju1r
         ri9eBpzu7RtOLb/ceFqmRRM7NnhKLEJNS28LkLSjtWvN+7dWopUeU6SNDMl7lBe1wjg/
         HAsHb9gq/jrUItZnU1ba+5vAVJ9xJCp/CMqxGmPOImTCdYQDoM5m91UsapqNZWs2tda2
         ehg8y/zFxyQ/FQlBETOvFHh/9ojhZgAGdHbd256jleZYn9YzU8B4S4fJ3LSIzgkZXyJk
         X6JA==
X-Forwarded-Encrypted: i=1; AJvYcCWlIfbeyQjQiI7nAAGbrHAqpaFuv1Tq7hVDigYZ/zbJyH/PLKIk0OeyZGhQIJDnd692ooKCT1krq+t2jVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwogItu0dRibxv/STH3h1prwNM/+sLOmwfWh2wcyo/VLFVKGDTI
	WCpbBOEpCEf1kVteY3FG6Jt3ldO93CiqOtL9gHrC0nCJNYZ9kuCBF3ygfEZEtCIaxpZNHE/w+av
	Y7WyBz1NKxtnU2sv35XnwIWAUJMnqlL92M10x
X-Gm-Gg: ASbGncv+vlQIczY+KPHB8o4V9zZE9aSTqScSz7jtfiGRnuI+lBpan4eS95HMWZci35M
	RW2Z9YLWJ+4EW5A28ACJ07ue8ktOLH7S3f6xdOX6nvZ0d9xu8U7VEJcnlR0u0+6xuVA==
X-Google-Smtp-Source: AGHT+IGFzjfV8u0+PhQ9um56OnOqrfs5vhnKjf9zf+yXxmNnp4EslbB/FiQXC1FySPFT5Ic17QmsFwH+OtK/qb2/rpo=
X-Received: by 2002:a05:622a:256:b0:466:a3bf:41ab with SMTP id
 d75a77b69052e-46795e6ec86mr12811cf.21.1733933657220; Wed, 11 Dec 2024
 08:14:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206225204.4008261-1-surenb@google.com> <20241206225204.4008261-5-surenb@google.com>
 <6b29b2a5-c244-4930-a5a0-1a24a04e7e35@suse.cz> <CAJuCfpFxAZ-JwN8VqNF14zeBnsPM_pD0+-N2PDq5GcQGR1xqLQ@mail.gmail.com>
 <643beb6c-4226-46ca-b7e9-292467479aea@suse.cz> <CAJuCfpHR3LXfAZA_oh_2KBtFe6JQPU5T3nYMZd_ooAjRJd8xUQ@mail.gmail.com>
 <5036d089-0774-4863-88c5-eaaea1265ac7@suse.cz> <CAJuCfpGrnSTU5ZH0Vt_AXyyFX5vAyknqcOtRsfnh4dbpOeyy-A@mail.gmail.com>
 <CAJuCfpHcweCby61FpVr8cAhcr1JkXQyZ_LbKL3HrM8fsFTGiog@mail.gmail.com> <253a0af3-6751-413c-ad37-a5d13dd9b8f0@suse.cz>
In-Reply-To: <253a0af3-6751-413c-ad37-a5d13dd9b8f0@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 11 Dec 2024 08:14:05 -0800
Message-ID: <CAJuCfpHOJystnxDZEY8v0iYqVQXqDYnjAoEW3U9SYcbzbzrjAg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, hannes@cmpxchg.org, 
	mjguzik@gmail.com, oliver.sang@intel.com, mgorman@techsingularity.net, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	corbet@lwn.net, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 8:05=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 12/11/24 16:30, Suren Baghdasaryan wrote:
> > On Tue, Dec 10, 2024 at 3:01=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> On Tue, Dec 10, 2024 at 9:25=E2=80=AFAM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> >> >
> >> > On 12/10/24 18:16, Suren Baghdasaryan wrote:
> >> > > On Tue, Dec 10, 2024 at 8:32=E2=80=AFAM Vlastimil Babka <vbabka@su=
se.cz> wrote:
> >> > >>
> >> > >> On 12/10/24 17:20, Suren Baghdasaryan wrote:
> >> > >> > On Tue, Dec 10, 2024 at 6:21=E2=80=AFAM Vlastimil Babka <vbabka=
@suse.cz> wrote:
> >> > >> >>
> >> > >> >> On 12/6/24 23:52, Suren Baghdasaryan wrote:
> >> > >> >> > To enable SLAB_TYPESAFE_BY_RCU for vma cache we need to ensu=
re that
> >> > >> >> > object reuse before RCU grace period is over will be detecte=
d inside
> >> > >> >> > lock_vma_under_rcu().
> >> > >> >> > lock_vma_under_rcu() enters RCU read section, finds the vma =
at the
> >> > >> >> > given address, locks the vma and checks if it got detached o=
r remapped
> >> > >> >> > to cover a different address range. These last checks are th=
ere
> >> > >> >> > to ensure that the vma was not modified after we found it bu=
t before
> >> > >> >> > locking it.
> >> > >> >> > vma reuse introduces several new possibilities:
> >> > >> >> > 1. vma can be reused after it was found but before it is loc=
ked;
> >> > >> >> > 2. vma can be reused and reinitialized (including changing i=
ts vm_mm)
> >> > >> >> > while being locked in vma_start_read();
> >> > >> >> > 3. vma can be reused and reinitialized after it was found bu=
t before
> >> > >> >> > it is locked, then attached at a new address or to a new mm =
while
> >> > >> >> > read-locked;
> >> > >> >> > For case #1 current checks will help detecting cases when:
> >> > >> >> > - vma was reused but not yet added into the tree (detached c=
heck)
> >> > >> >> > - vma was reused at a different address range (address check=
);
> >> > >> >> > We are missing the check for vm_mm to ensure the reused vma =
was not
> >> > >> >> > attached to a different mm. This patch adds the missing chec=
k.
> >> > >> >> > For case #2, we pass mm to vma_start_read() to prevent acces=
s to
> >> > >> >> > unstable vma->vm_mm. This might lead to vma_start_read() ret=
urning
> >> > >> >> > a false locked result but that's not critical if it's rare b=
ecause
> >> > >> >> > it will only lead to a retry under mmap_lock.
> >> > >> >> > For case #3, we ensure the order in which vma->detached flag=
 and
> >> > >> >> > vm_start/vm_end/vm_mm are set and checked. vma gets attached=
 after
> >> > >> >> > vm_start/vm_end/vm_mm were set and lock_vma_under_rcu() shou=
ld check
> >> > >> >> > vma->detached before checking vm_start/vm_end/vm_mm. This is=
 required
> >> > >> >> > because attaching vma happens without vma write-lock, as opp=
osed to
> >> > >> >> > vma detaching, which requires vma write-lock. This patch add=
s memory
> >> > >> >> > barriers inside is_vma_detached() and vma_mark_attached() ne=
eded to
> >> > >> >> > order reads and writes to vma->detached vs vm_start/vm_end/v=
m_mm.
> >> > >> >> > After these provisions, SLAB_TYPESAFE_BY_RCU is added to vm_=
area_cachep.
> >> > >> >> > This will facilitate vm_area_struct reuse and will minimize =
the number
> >> > >> >> > of call_rcu() calls.
> >> > >> >> >
> >> > >> >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >> > >> >>
> >> > >> >> I'm wondering about the vma freeing path. Consider vma_complet=
e():
> >> > >> >>
> >> > >> >> vma_mark_detached(vp->remove);
> >> > >> >>   vma->detached =3D true; - plain write
> >> > >> >> vm_area_free(vp->remove);
> >> > >> >>   vma->vm_lock_seq =3D UINT_MAX; - plain write
> >> > >> >>   kmem_cache_free(vm_area_cachep)
> >> > >> >> ...
> >> > >> >> potential reallocation
> >> > >> >>
> >> > >> >> against:
> >> > >> >>
> >> > >> >> lock_vma_under_rcu()
> >> > >> >> - mas_walk finds a stale vma due to race
> >> > >> >> vma_start_read()
> >> > >> >>   if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(mm->mm_lock=
_seq.sequence))
> >> > >> >>   - can be false, the vma was not being locked on the freeing =
side?
> >> > >> >>   down_read_trylock(&vma->vm_lock.lock) - suceeds, wasn't lock=
ed
> >> > >> >>     this is acquire, but was there any release?
> >> > >> >
> >> > >> > Yes, there was a release. I think what you missed is that
> >> > >> > vma_mark_detached() that is called from vma_complete() requires=
 VMA to
> >> > >> > be write-locked (see vma_assert_write_locked() in
> >> > >> > vma_mark_detached()). The rule is that a VMA can be attached wi=
thout
> >> > >> > write-locking but only a write-locked VMA can be detached. So, =
after
> >> > >>
> >> > >> OK but write unlocking means the mm's seqcount is bumped and beco=
mes
> >> > >> non-equal with vma's vma->vm_lock_seq, right?
> >> > >>
> >> > >> Yet in the example above we happily set it to UINT_MAX and thus e=
ffectively
> >> > >> false unlock it for vma_start_read()?
> >> > >>
> >> > >> And this is all done before the vma_complete() side would actuall=
y reach
> >> > >> mmap_write_unlock(), AFAICS.
> >> > >
> >> > > Ah, you are right. With the possibility of reuse, even a freed VMA
> >> > > should be kept write-locked until it is unlocked by
> >> > > mmap_write_unlock(). I think the fix for this is simply to not res=
et
> >> > > vma->vm_lock_seq inside vm_area_free(). I'll also need to add a
> >> >
> >> > But even if we don't reset vm_lock_seq to UINT_MAX, then whover real=
located
> >> > it can proceed and end up doing a vma_start_write() and rewrite it t=
here
> >> > anyway, no?
> >>
> >> Actually, I think with a small change we can simplify these locking ru=
les:
> >>
> >> static inline void vma_start_write(struct vm_area_struct *vma)
> >> {
> >>         int mm_lock_seq;
> >>
> >> -        if (__is_vma_write_locked(vma, &mm_lock_seq))
> >> -                return;
> >> +        mmap_assert_write_locked(vma->vm_mm);
> >> +        mm_lock_seq =3D vma->vm_mm->mm_lock_seq;
> >>
> >>         down_write(&vma->vm_lock->lock);
> >>         /*
> >>         * We should use WRITE_ONCE() here because we can have concurre=
nt reads
> >>         * from the early lockless pessimistic check in vma_start_read(=
).
> >>         * We don't really care about the correctness of that early che=
ck, but
> >>         * we should use WRITE_ONCE() for cleanliness and to keep KCSAN=
 happy.
> >>         */
> >>         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> >>         up_write(&vma->vm_lock->lock);
> >> }
> >>
> >> This will force vma_start_write() to always write-lock vma->vm_lock
> >> before changing vma->vm_lock_seq. Since vma->vm_lock survives reuse,
> >> the other readers/writers will synchronize on it even if vma got
> >> reused.
> >
> > After thinking of all the alternatives, I think the cleanest way to
> > handle vma detaching would be to follow the same pattern as for vma
> > attaching. To attach a vma we do:
> >
> > vma->vm_mm =3D xxx;
> > ...
> > vma_mark_attached()
> >     smp_wmb();
> >     WRITE_ONCE(vma->detached, false);
> >
> >
> > lock_vma_under_rcu() ensures that a vma is attached and still
> > unchanged like this:
> >
> > lock_vma_under_rcu()
> >     vma_start_read();
> >     is_vma_detached()
> >         detached =3D READ_ONCE(vma->detached);
> >         smp_rmb();
> >     if (vma->vm_mm !=3D mm)
> >
> > So, vm_area_free() can follow the same pattern to ensure vma reuse
> > gets detected even if lock_vma_under_rcu() succeeds in locking the
> > vma:
> >
> > vm_area_free()
> >     vma->vm_mm =3D NULL;
> >     smp_wmb();
> >     WRITE_ONCE(vma->detached, true);
> >
> > Vlastimil, I think that should address the race you described. WDYT?
>
> I'm not sure. AFAIU the barriers would ensure that if lock_vma_under_rcu(=
)
> sees detached, it also sees vm_mm is NULL. But as it doesn't ensure that =
it
> will see it detached, so it also doesn't ensure we will see vm_mm as NULL=
.
>
> I think the main problem is that we unlock the vma by writing to a mm, no=
t
> the vma, which makes it hard to apply the necessary SLAB_TYPESAFE_BY_RCU
> validation patterns to it. I thought the direction you were discussing wi=
th
> PeterZ in the other thread would solve this (in addition of getting rid o=
f
> the rwsem, which we were considering it anyway, but enabling
> SLAB_TYPESAFE_BY_RCU by that would be a stronger argument).

I was hoping to implement SLAB_TYPESAFE_BY_RCU independently from
vm_lock change but you are probably right. Incorporating vma->detached
flag into the lock itself (which survives reuse) would make things way
easier. Let me pivot towards making that change first and see if
SLAB_TYPESAFE_BY_RCU becomes simpler.

>
> Perhaps a solution to this that would work with the current rwsem would b=
e
> that setting detached and vm_mm to NULL would be set under the down_write=
()
> of the rwsem. That would make sure that if lock_vma_under_rcu() succeeds =
the
> down_read_trylock(), it would be guaranteed to see those assignments?

Yeah, that would definitely work. I was trying to avoid extra locking
but it looks like it's unavoidable.
Anyway, let me try replacing vm_lock first and will see where we end up.
Thanks for the input!

>
> >>
> >> >
> >> > > comment for vm_lock_seq explaining these requirements.
> >> > > Do you agree that such a change would resolve the issue?
> >> > >
> >> > >>
> >> > >> > vma_mark_detached() and before down_read_trylock(&vma->vm_lock.=
lock)
> >> > >> > in vma_start_read() the VMA write-lock should have been release=
d by
> >> > >> > mmap_write_unlock() and therefore vma->detached=3Dfalse should =
be
> >> > >> > visible to the reader when it executed lock_vma_under_rcu().
> >> > >> >
> >> > >> >>   is_vma_detached() - false negative as the write above didn't=
 propagate
> >> > >> >>     here yet; a read barrier but where is the write barrier?
> >> > >> >>   checks for vma->vm_mm, vm_start, vm_end - nobody reset them =
yet so false
> >> > >> >>     positive, or they got reset on reallocation but writes did=
n't propagate
> >> > >> >>
> >> > >> >> Am I missing something that would prevent lock_vma_under_rcu()=
 falsely
> >> > >> >> succeeding here?
> >> > >> >>
> >> > >>
> >> >
>

