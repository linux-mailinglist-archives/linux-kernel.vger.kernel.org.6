Return-Path: <linux-kernel+bounces-440439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860E89EBDF1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E4A2828F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914CA1F1902;
	Tue, 10 Dec 2024 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="quE/vhoI"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4D51D014E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870354; cv=none; b=n1sY6LH42c4veMpJ09tbjNmDJPw0aB30SKQ4U4U2sfK7mntQ0FtgGhDoADaYRcAoAaGrqSJqk69f+GGfc0KMO+lL65MP2FMkQqS8c/SkPujsOn1lUC1JUpIQv4GeK4yVFaV+/8qj3Bma/NstIzRLKS2L3xdnLMSogOTANnpiGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870354; c=relaxed/simple;
	bh=O++82/VkfCl3c2Ppr1UMi8Dgi7ke022oDTm813+GREQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snTqkmflQx7DnlveUuy45MYuFDWf8n+O192l9WKRYQ67+St+et5IdzRj7DxBMEXrFIMSMrixtFdg6JesJb1Kzx+NctUUAmn8tKhqXTIN0NF78Rssq05/p2mqiCF6vqdqW+s8DGCEWGQoQkdtopGYX/DUuKq1tzmnsR4ODRrQiV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=quE/vhoI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=6Z6f8By0er5Bpt2mZnEJVSkHMXAxhgYlT24keL+DlzQ=; b=quE/vhoIfs0hRTKXaHNBdDpod1
	jn1GMuKF6WkW5VoOjLc1PszLeOj0LwrASzHgrtD07Y8a79AJhLUBTynZ7VO7PhVrdllur3+ovt7oo
	zufumRE2Xsuk5TyJ575TlZlHwQp5cQp/ibzWJNENC/80HEhN8gco7euk0ChjUg86ftRoaHTrRvyZC
	U7HLNXBUuAQOFdzPpYGFWUoZAGbU8vyg6whZFWmGsypGcqu4jafpuM0LFzkDZ3dOMLvpygz8UUHGo
	nLQyR5BmJ1485xvZMwI+7SUV9eKxXiOm7eJsX5V2CdO2fTgOQ0qGi5/lbjQWMteVY7lND5duPHWE3
	xrbD8FDw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tL8sV-00000003jqh-1IyZ;
	Tue, 10 Dec 2024 22:38:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7F9E130035F; Tue, 10 Dec 2024 23:38:50 +0100 (CET)
Date: Tue, 10 Dec 2024 23:38:50 +0100
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
Message-ID: <20241210223850.GA2484@noisy.programming.kicks-ass.net>
References: <20241111205506.3404479-1-surenb@google.com>
 <20241111205506.3404479-4-surenb@google.com>
 <ZzLgZTH9v5io1Elx@casper.infradead.org>
 <CAJuCfpHpGSpix8+mB76Virb+HAMrOqB3wG8E4EXPrRCnBoBGeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHpGSpix8+mB76Virb+HAMrOqB3wG8E4EXPrRCnBoBGeA@mail.gmail.com>

On Tue, Nov 12, 2024 at 07:18:45AM -0800, Suren Baghdasaryan wrote:
> On Mon, Nov 11, 2024 at 8:58 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Nov 11, 2024 at 12:55:05PM -0800, Suren Baghdasaryan wrote:
> > > When a reader takes read lock, it increments the atomic, unless the
> > > top two bits are set indicating a writer is present.
> > > When writer takes write lock, it sets VMA_LOCK_WR_LOCKED bit if there
> > > are no readers or VMA_LOCK_WR_WAIT bit if readers are holding the lock
> > > and puts itself onto newly introduced mm.vma_writer_wait. Since all
> > > writers take mmap_lock in write mode first, there can be only one writer
> > > at a time. The last reader to release the lock will signal the writer
> > > to wake up.
> >
> > I don't think you need two bits.  You can do it this way:
> >
> > 0x8000'0000 - No readers, no writers
> > 0x1-7fff'ffff - Some number of readers
> > 0x0 - Writer held
> > 0x8000'0001-0xffff'ffff - Reader held, writer waiting
> >
> > A prospective writer subtracts 0x8000'0000.  If the result is 0, it got
> > the lock, otherwise it sleeps until it is 0.
> >
> > A writer unlocks by adding 0x8000'0000 (not by setting the value to
> > 0x8000'0000).
> >
> > A reader unlocks by adding 1.  If the result is 0, it wakes the writer.
> >
> > A prospective reader subtracts 1.  If the result is positive, it got the
> > lock, otherwise it does the unlock above (this might be the one which
> > wakes the writer).
> >
> > And ... that's it.  See how we use the CPU arithmetic flags to tell us
> > everything we need to know without doing arithmetic separately?
> 
> Yes, this is neat! You are using the fact that write-locked == no
> readers to eliminate unnecessary state. I'll give that a try. Thanks!

The reason I got here is that Vlastimil poked me about the whole
TYPESAFE_BY_RCU thing.

So the normal way those things work is with a refcount, if the refcount
is non-zero, the identifying fields should be stable and you can
determine if you have the right object, otherwise tough luck.

And I was thinking that since you abuse this rwsem you have, you might
as well turn that into a refcount with some extra.

So I would propose a slightly different solution.

Replace vm_lock with vm_refcnt. Replace vm_detached with vm_refcnt == 0
-- that is, attach sets refcount to 1 to indicate it is part of the mas,
detached is the final 'put'.

RCU lookup does the inc_not_zero thing, when increment succeeds, compare
mm/addr to validate.

vma_start_write() already relies on mmap_lock being held for writing,
and thus does not have to worry about writer-vs-writer contention, that
is fully resolved by mmap_sem. This means we only need to wait for
readers to drop out.

vma_start_write()
	add(0x8000'0001); // could fetch_add and double check the high
			  // bit wasn't already set.
	wait-until(refcnt == 0x8000'0002); // mas + writer ref
	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
	sub(0x8000'0000);

vma_end_write()
	put();

vma_start_read() then becomes something like:

	if (vm_lock_seq == mm_lock_seq)
	  return false;

	cnt = fetch_inc(1);
	if (cnt & msb || vm_lock_seq == mm_lock_seq) {
	  put();
	  return false;
	}

	return true;
	
vma_end_read() then becomes:
	put();


and the down_read() from uffffffd requires mmap_read_lock() and thus
does not have to worry about writers, it can simpy be inc() and put(),
no?

