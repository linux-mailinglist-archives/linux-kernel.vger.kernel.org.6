Return-Path: <linux-kernel+bounces-449042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC3E9F48E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9EC1890A86
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020431DF96E;
	Tue, 17 Dec 2024 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ClY9o+2U"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AC01D5CFD;
	Tue, 17 Dec 2024 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431449; cv=none; b=AkXQffVMfxQd0LO44UwRAMP5xX2JSMiMWpYZRQAj9Lf0WErXMjRJtArV5ZAa0jYwPIt8encn8fxluFXoVkiOwjYkXMGa7EtLBLaYAPhmdbUbGjLNF6LklU+o/4zWnTH3y5d4ekJSwOjN5OjyrkNfWwbqwrY+e9Q3QDT1dV0ch5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431449; c=relaxed/simple;
	bh=nMye4Fzq1MQwNPB3OPFATyd8wr7HLm5fGd90VZY1apo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahsLJOyj1tdKK4/ol/TLdvbt5wag7cFnzwGx9tbBr0/ANvsRU5lr1t7ZRyKsBIr4OuzFxQG4xnlvJ4pYEf+XzpVucZ8hipiwZXbc0thmZlSIQHV1AwlMv61S/55/vJPJpLS/0eJPPoINhJMUkUWx1RglBcbHycPOI1tGHV6oz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ClY9o+2U; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=cRjzNOV1ffJ13/MtKPV0Ob+50aKeLsbdFVRQjpo8i44=; b=ClY9o+2UruJ9cz1NKhNFGNqvo+
	wPnfdc1ZhXBJe7kT8WONPHMeF4C3nXgKTY8bVozqBH0ah4tvPBS9KutMS3rxPekUv0I4lFR8PMCN7
	3TEKYbq/w1JYAp0Vq5wu8fY8dYq3JSMTkLZGvw2LIHQgTZgPuXGRYuSwy0PV/KwXTORuqUD6JlX29
	ic1eZC3I5R7JhGDxvWD9B9NE7gcPm1zk51N9GfUGyBZUh9SdDFhlHD51hknyO5rVDV/wMqI3HjRDY
	Rvf7MwdKTPZ7He2sa/eOxS3sQplVAdVKTs/ZJBTTGoMUSLW27y0BbL3V89ijkPMrfMv7uMvyBr//u
	m2Kja0Tg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUqa-00000006Kxn-0oOT;
	Tue, 17 Dec 2024 10:30:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ACBB330015F; Tue, 17 Dec 2024 11:30:35 +0100 (CET)
Date: Tue, 17 Dec 2024 11:30:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz,
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
	hughd@google.com, lokeshgidra@google.com, minchan@google.com,
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com,
	pasha.tatashin@soleen.com, klarasmodin@gmail.com, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v6 10/16] mm: replace vm_lock and detached flag with a
 reference count
Message-ID: <20241217103035.GD11133@noisy.programming.kicks-ass.net>
References: <20241216192419.2970941-1-surenb@google.com>
 <20241216192419.2970941-11-surenb@google.com>
 <20241216213753.GD9803@noisy.programming.kicks-ass.net>
 <CAJuCfpEu_rZkC+ktWXE=rA-VenFBZR9VQ-SnVkDbXUqsd3Ys_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEu_rZkC+ktWXE=rA-VenFBZR9VQ-SnVkDbXUqsd3Ys_A@mail.gmail.com>

On Mon, Dec 16, 2024 at 01:44:45PM -0800, Suren Baghdasaryan wrote:
> On Mon, Dec 16, 2024 at 1:38 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Dec 16, 2024 at 11:24:13AM -0800, Suren Baghdasaryan wrote:
> > > +static inline void vma_refcount_put(struct vm_area_struct *vma)
> > > +{
> > > +     int refcnt;
> > > +
> > > +     if (!__refcount_dec_and_test(&vma->vm_refcnt, &refcnt)) {
> > > +             rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > > +
> > > +             if (refcnt & VMA_STATE_LOCKED)
> > > +                     rcuwait_wake_up(&vma->vm_mm->vma_writer_wait);
> > > +     }
> > > +}
> > > +
> > >  /*
> > >   * Try to read-lock a vma. The function is allowed to occasionally yield false
> > >   * locked result to avoid performance overhead, in which case we fall back to
> > > @@ -710,6 +728,8 @@ static inline void vma_lock_init(struct vm_area_struct *vma)
> > >   */
> > >  static inline bool vma_start_read(struct vm_area_struct *vma)
> > >  {
> > > +     int oldcnt;
> > > +
> > >       /*
> > >        * Check before locking. A race might cause false locked result.
> > >        * We can use READ_ONCE() for the mm_lock_seq here, and don't need
> > > @@ -720,13 +740,20 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
> > >       if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
> > >               return false;
> > >
> > > +
> > > +     rwsem_acquire_read(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
> > > +     /* Limit at VMA_STATE_LOCKED - 2 to leave one count for a writer */
> > > +     if (unlikely(!__refcount_inc_not_zero_limited(&vma->vm_refcnt, &oldcnt,
> > > +                                                   VMA_STATE_LOCKED - 2))) {
> > > +             rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> > >               return false;
> > > +     }
> > > +     lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
> > >
> > >       /*
> > > +      * Overflow of vm_lock_seq/mm_lock_seq might produce false locked result.
> > >        * False unlocked result is impossible because we modify and check
> > > +      * vma->vm_lock_seq under vma->vm_refcnt protection and mm->mm_lock_seq
> > >        * modification invalidates all existing locks.
> > >        *
> > >        * We must use ACQUIRE semantics for the mm_lock_seq so that if we are
> > > @@ -734,10 +761,12 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
> > >        * after it has been unlocked.
> > >        * This pairs with RELEASE semantics in vma_end_write_all().
> > >        */
> > > +     if (oldcnt & VMA_STATE_LOCKED ||
> > > +         unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
> > > +             vma_refcount_put(vma);
> >
> > Suppose we have detach race with a concurrent RCU lookup like:
> >
> >                                         vma = mas_lookup();
> >
> >         vma_start_write();
> >         mas_detach();
> >                                         vma_start_read()
> >                                         rwsem_acquire_read()
> >                                         inc // success
> >         vma_mark_detach();
> >         dec_and_test // assumes 1->0
> >                      // is actually 2->1
> >
> >                                         if (vm_lock_seq == vma->vm_mm_mm_lock_seq) // true
> >                                           vma_refcount_put
> >                                             dec_and_test() // 1->0
> >                                               *NO* rwsem_release()
> >
> 
> Yes, this is possible. I think that's not a problem until we start
> reusing the vmas and I deal with this race later in this patchset.
> I think what you described here is the same race I mention in the
> description of this patch:
> https://lore.kernel.org/all/20241216192419.2970941-14-surenb@google.com/
> I introduce vma_ensure_detached() in that patch to handle this case
> and ensure that vmas are detached before they are returned into the
> slab cache for reuse. Does that make sense?

So I just replied there, and no, I don't think it makes sense. Just put
the kmem_cache_free() in vma_refcount_put(), to be done on 0.

Anyway, my point was more about the weird entanglement of lockdep and
the refcount. Just pull the lockdep annotation out of _put() and put it
explicitly in the vma_start_read() error paths and vma_end_read().

Additionally, having vma_end_write() would allow you to put a lockdep
annotation in vma_{start,end}_write() -- which was I think the original
reason I proposed it a while back, that and having improved clarity when
reading the code, since explicitly marking the end of a section is
helpful.

