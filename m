Return-Path: <linux-kernel+bounces-440959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9879F9EC715
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0342516A1BD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C5D1D88D0;
	Wed, 11 Dec 2024 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OP4CchUu"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7C1D86F7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905567; cv=none; b=JUXGHL7UOer5O6PWCruL1i3pS99GR5tXNxOp21AT5GiMNn6AVXzeQOHTbbR5fUX7P3M49WfxizwnyDoQKEnlc1n/DRqRkr3JKmh1j+rPwewfe1jqawTnKiyCN5ay0jzx2nv9224OXZbbWamp0HSgZXT7f4DlMWNEvPs1O6Q7qvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905567; c=relaxed/simple;
	bh=fLIpHS7irDkXQbygn7Juj3Ag022uPiNCR56uRyVjQRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/Kspz6p8ZOPhrgIPve1TfGOdKC4etr3ZUjnO7fGxykBYWC0jyAAps9sLQyMZlVdjxf2hjCFww9ydnJbOjPaxKspbZTD470vmF6+kF7yl2u6lQGuEsmV1lBi2zzcyq0NDxrJh69m7lj2fuBZCiO38RupdOLO21FzXm3IojdFRj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OP4CchUu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VRKUf7RHuICLEGBDyGRTHbcfZwuBStKvAlTf7DKhWpk=; b=OP4CchUuNPmUpanAmTOAUV5JVB
	7/v5syDT3urXIOzhtcnJ64z4zrdjq6JY3L/YXSlcCkriiCyPQRkNk5eCZ/vxEGySLxdms67AylgNU
	b7E+Xu1BlHq21Au3CoIX90qvjKE+yqRFW+29KEMEddtH4cTsX8QRiFt9fPF78bvm6up3pZy7aanZJ
	YEb1de0uXJOcj1Nkcz4XNGeIWv2JnEX84/XY/pJSNHXptfZnTGf9meg57jg7JgnU5W0CZR9B7MG5W
	7SdXh59/nbncVciawp0h1T0zfOccX4sBz6TzobHvOLa52BBOoxeDVr6965bqIf4B2/NeXy7Sc5B+F
	CbNp96Hw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLI2Q-0000000ExKo-0HS3;
	Wed, 11 Dec 2024 08:25:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4118630049D; Wed, 11 Dec 2024 09:25:41 +0100 (CET)
Date: Wed, 11 Dec 2024 09:25:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
	hughd@google.com, minchan@google.com, jannh@google.com,
	shakeel.butt@linux.dev, souravpanda@google.com,
	pasha.tatashin@soleen.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
Message-ID: <20241211082541.GQ21636@noisy.programming.kicks-ass.net>
References: <20241111205506.3404479-1-surenb@google.com>
 <20241111205506.3404479-4-surenb@google.com>
 <ZzLgZTH9v5io1Elx@casper.infradead.org>
 <CAJuCfpHpGSpix8+mB76Virb+HAMrOqB3wG8E4EXPrRCnBoBGeA@mail.gmail.com>
 <20241210223850.GA2484@noisy.programming.kicks-ass.net>
 <CAJuCfpETJZVFYwf+P=6FnY_6n8E7fQsKH6HrOV1Q_q9cFizEKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpETJZVFYwf+P=6FnY_6n8E7fQsKH6HrOV1Q_q9cFizEKw@mail.gmail.com>

On Tue, Dec 10, 2024 at 03:37:50PM -0800, Suren Baghdasaryan wrote:

> > Replace vm_lock with vm_refcnt. Replace vm_detached with vm_refcnt == 0
> > -- that is, attach sets refcount to 1 to indicate it is part of the mas,
> > detached is the final 'put'.
> 
> I need to double-check if we ever write-lock a detached vma. I don't
> think we do but better be safe. If we do then that wait-until() should
> accept 0x8000'0001 as well.

vma_start_write()
  __is_vma_write_locked()
    mmap_assert_write_locked(vma->vm_mm);

So this really should hold afaict.

> > RCU lookup does the inc_not_zero thing, when increment succeeds, compare
> > mm/addr to validate.
> >
> > vma_start_write() already relies on mmap_lock being held for writing,
> > and thus does not have to worry about writer-vs-writer contention, that
> > is fully resolved by mmap_sem. This means we only need to wait for
> > readers to drop out.
> >
> > vma_start_write()
> >         add(0x8000'0001); // could fetch_add and double check the high
> >                           // bit wasn't already set.
> >         wait-until(refcnt == 0x8000'0002); // mas + writer ref
> >         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> >         sub(0x8000'0000);
> >
> > vma_end_write()
> >         put();
> 
> We don't really have vma_end_write(). Instead it's vma_end_write_all()
> which increments mm_lock_seq unlocking all write-locked VMAs.
> Therefore in vma_start_write() I think we can sub(0x8000'0001) at the
> end.

Right, I know you don't, but you should :-), I've suggested adding this
before.

> > vma_start_read() then becomes something like:
> >
> >         if (vm_lock_seq == mm_lock_seq)
> >           return false;
> >
> >         cnt = fetch_inc(1);
> >         if (cnt & msb || vm_lock_seq == mm_lock_seq) {
> >           put();
> >           return false;
> >         }
> >
> >         return true;
> >
> > vma_end_read() then becomes:
> >         put();
> >
> >
> > and the down_read() from uffffffd requires mmap_read_lock() and thus
> > does not have to worry about writers, it can simpy be inc() and put(),
> > no?
> 
> I think your proposal should work. Let me try to code it and see if
> something breaks.

Btw, for the wait-until() and put() you can use rcuwait; that is the
simplest wait form we have. It's suitable because we only ever have the
one waiter.

