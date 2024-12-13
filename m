Return-Path: <linux-kernel+bounces-444493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAD69F07BC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923CF1685E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C831B0F04;
	Fri, 13 Dec 2024 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n/lmmeHl"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41391AA7B9
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081770; cv=none; b=qzLC3DFu/beW2DjwMRIzPk52UIqXbzHih+Bybpv5DUYpAkgHUGscRN0I3lF3noYiYcB85+zwhq8Z3XP0R3cxVeTNTjPVSesVv8xRJ5Gm8C/C16a5Qx/Y62roezNoXWArgwZ+mwl/VDkjXd5z9cONSVq0sh3xRgRnnt6sv0fJph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081770; c=relaxed/simple;
	bh=EYctMaNzHP5iOTimpvKi/Z3kCLWy6zuIG3pXNITBRlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki6TmLn8cy0++FEfus2MAep5K/yvkVViE45CN2IfzAjHMXoEuiE0EfLNaFLGaLRs5U/lBfq7YGNhkcrxl5WNpITzAXKd/dZP0NEktFFMI0EgXyA/YknHte30u7EeooHrOT3Hck+KVMQtOIx4B5rleCH8sPv0L3L021ythjHNRtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n/lmmeHl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=5yxKMYewggryOGHY+MR70jJYrmuZmaTGszo19sRiDmE=; b=n/lmmeHlqYuPBE/F6rM88EA/iy
	ywB08fXCL3RNvmCPdhoUo2zUfT/T8Z3sBBgfj7LAUOW4c3jMDO+UrOSID/9tF81TqMVXR4PHH+tb5
	wv6S1QIG/u8w7yDe1jJwbQ6IZaHOScYUCJKO1RlDHAuCq9RkK8U9s9tq2jLrZbFwvjEmvg5MwAurR
	F85zRhH8PJ7c/E9KFueXYZwsngHGK2KoIk3Y3uDFkc048iLFNAQOgTUH4xCZja6sdiNiAe1jUStg6
	17CuGBAQZb8Gh9LIXAb6G1JaaMbaFNMF3c1RWK6zHUm0XfpdIOq7lUFmX6kCbso2kPe6Wp3ibRFbN
	0zaaSUqQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM1sO-00000004EyF-3WXY;
	Fri, 13 Dec 2024 09:22:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6685230049D; Fri, 13 Dec 2024 10:22:23 +0100 (CET)
Date: Fri, 13 Dec 2024 10:22:23 +0100
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
Message-ID: <20241213092223.GB2484@noisy.programming.kicks-ass.net>
References: <20241111205506.3404479-4-surenb@google.com>
 <ZzLgZTH9v5io1Elx@casper.infradead.org>
 <CAJuCfpHpGSpix8+mB76Virb+HAMrOqB3wG8E4EXPrRCnBoBGeA@mail.gmail.com>
 <20241210223850.GA2484@noisy.programming.kicks-ass.net>
 <CAJuCfpETJZVFYwf+P=6FnY_6n8E7fQsKH6HrOV1Q_q9cFizEKw@mail.gmail.com>
 <20241211082541.GQ21636@noisy.programming.kicks-ass.net>
 <CAJuCfpEMYhAmOPwjGO+j1t+069MJZxUs1O1co-zJ4+vEeXCtng@mail.gmail.com>
 <CAJuCfpGOOcRAJ46sbPRoCUNuuhi2fnkM97F=CfZ1=_N5ZFUcLw@mail.gmail.com>
 <20241212091659.GU21636@noisy.programming.kicks-ass.net>
 <CAJuCfpHKFZ2Q1R1Knh-LFLUYcTX6CJuEsqNM5AwxRyDUAzdcVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHKFZ2Q1R1Knh-LFLUYcTX6CJuEsqNM5AwxRyDUAzdcVw@mail.gmail.com>

On Thu, Dec 12, 2024 at 06:17:44AM -0800, Suren Baghdasaryan wrote:
> On Thu, Dec 12, 2024 at 1:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Dec 11, 2024 at 07:01:16PM -0800, Suren Baghdasaryan wrote:
> >
> > > > > > I think your proposal should work. Let me try to code it and see if
> > > > > > something breaks.
> > >
> > > Ok, I tried it out and things are a bit more complex:
> > > 1. We should allow write-locking a detached VMA, IOW vma_start_write()
> > > can be called when vm_refcnt is 0.
> >
> > This sounds dodgy, refcnt being zero basically means the object is dead
> > and you shouldn't be touching it no more. Where does this happen and
> > why?
> >
> > Notably, it being 0 means it is no longer in the mas tree and can't be
> > found anymore.
> 
> It happens when a newly created vma that was not yet attached
> (vma->vm_refcnt = 0) is write-locked before being added into the vma
> tree. For example:
> mmap()
>   mmap_write_lock()
>   vma = vm_area_alloc() // vma->vm_refcnt = 0 (detached)
>   //vma attributes are initialized
>   vma_start_write() // write 0x8000 0001 into vma->vm_refcnt
>   mas_store_gfp()
>   vma_mark_attached()
>   mmap_write_lock() // vma_end_write_all()
> 
> In this scenario, we write-lock the VMA before adding it into the tree
> to prevent readers (pagefaults) from using it until we drop the
> mmap_write_lock().

Ah, but you can do that by setting vma->vm_lock_seq and setting the ref
to 1 before adding it (its not visible before adding anyway, so nobody
cares).

You'll note that the read thing checks both the msb (or other high bit
depending on the actual type you're going with) *and* the seq. That is
needed because we must not set the sequence number before all existing
readers are drained, but since this is pre-add that is not a concern.

> > > 2. Adding 0x80000000 saturates refcnt, so I have to use a lower bit
> > > 0x40000000 to denote writers.
> >
> > I'm confused, what? We're talking about atomic_t, right?
> 
> I thought you suggested using refcount_t. According to
> https://elixir.bootlin.com/linux/v6.13-rc2/source/include/linux/refcount.h#L22
> valid values would be [0..0x7fff_ffff] and 0x80000000 is outside of
> that range. What am I missing?

I was talking about atomic_t :-), but yeah, maybe we can use refcount_t,
but I hadn't initially considered that.


