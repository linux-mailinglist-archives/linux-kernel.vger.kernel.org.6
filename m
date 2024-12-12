Return-Path: <linux-kernel+bounces-442823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48D49EE277
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E20916799B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1199C20CCD7;
	Thu, 12 Dec 2024 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EQyVflvW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA0F2594BA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995041; cv=none; b=Me4P2oovaNv98pnDtmzhI5FXDciFXmvGrPeT89BRaEBUwcruzkf5zJ9DaPHTXYkaJLu8xK4sIHYed2AdxVBl4OcjCTaHFoWjmqIExCCf31G8Gv3LUlo/J4/gSPrniRIi6XVGAMEVpKkjYuEUER9pAXHGbUQEtMpT4Tqe35NHZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995041; c=relaxed/simple;
	bh=e8l1yWPU99QRyDuN6n1s4Egi+cUG/nyLM2X02bK7IsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYss+qITQSfBN+rSfEGfVMx/6OBjbo8MBjEvWKKA7StolF4RGwqWUxAga6E2l933JFBDO+pn8sM/aWUAx+6yqR49qSewmEjRJ9uyeZ4FEHTyI5uyDRd+pd2nZ+Xex3CVxpp8AyOqtD8Bv+v9Ra9Gs5CsyLnBm+S9BuZIY8B1058=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EQyVflvW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A0WmZNoF0u1ExgoBDb+GgZ/WiCy/wB2t58LSVxa1zA0=; b=EQyVflvW8FY98DQWF5km0uBtir
	DhdxBwbdAH5I5fWwIPwgKgZabxaF/UOusdQbXSJZ3p/Tay3OzYN6aIO+T1jWzTuyy/n4b9tUO0wub
	1kHWEFtX8Yes7nDW644xX+gxhkBBaub2GbSWjCki4LSCaaaGLBmpv6EXt2CZ7Ulnlz62wihVlRBOY
	/jmLzZF6aAGECIcu4uzznSanjK5uk1m4+DDRHDA7lZ5WzR/g/Kwka2L9HK6ocodTWjGWovJF0FEN4
	YDLLAgVEHOWwlv6F5Gp1/SzCi4fCIQGSBXCJI8ITt4tWx+s9rlwLi4EcMCRXAiuqaGtdOpXdOwkOy
	+XqPAPmA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLfJc-00000004dYY-2ggu;
	Thu, 12 Dec 2024 09:17:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A4F873003FF; Thu, 12 Dec 2024 10:16:59 +0100 (CET)
Date: Thu, 12 Dec 2024 10:16:59 +0100
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
Message-ID: <20241212091659.GU21636@noisy.programming.kicks-ass.net>
References: <20241111205506.3404479-1-surenb@google.com>
 <20241111205506.3404479-4-surenb@google.com>
 <ZzLgZTH9v5io1Elx@casper.infradead.org>
 <CAJuCfpHpGSpix8+mB76Virb+HAMrOqB3wG8E4EXPrRCnBoBGeA@mail.gmail.com>
 <20241210223850.GA2484@noisy.programming.kicks-ass.net>
 <CAJuCfpETJZVFYwf+P=6FnY_6n8E7fQsKH6HrOV1Q_q9cFizEKw@mail.gmail.com>
 <20241211082541.GQ21636@noisy.programming.kicks-ass.net>
 <CAJuCfpEMYhAmOPwjGO+j1t+069MJZxUs1O1co-zJ4+vEeXCtng@mail.gmail.com>
 <CAJuCfpGOOcRAJ46sbPRoCUNuuhi2fnkM97F=CfZ1=_N5ZFUcLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGOOcRAJ46sbPRoCUNuuhi2fnkM97F=CfZ1=_N5ZFUcLw@mail.gmail.com>

On Wed, Dec 11, 2024 at 07:01:16PM -0800, Suren Baghdasaryan wrote:

> > > > I think your proposal should work. Let me try to code it and see if
> > > > something breaks.
> 
> Ok, I tried it out and things are a bit more complex:
> 1. We should allow write-locking a detached VMA, IOW vma_start_write()
> can be called when vm_refcnt is 0. 

This sounds dodgy, refcnt being zero basically means the object is dead
and you shouldn't be touching it no more. Where does this happen and
why?

Notably, it being 0 means it is no longer in the mas tree and can't be
found anymore.

> 2. Adding 0x80000000 saturates refcnt, so I have to use a lower bit
> 0x40000000 to denote writers.

I'm confused, what? We're talking about atomic_t, right?

> 3. Currently vma_mark_attached() can be called on an already attached
> VMA. With vma->detached being a separate attribute that works fine but
> when we combine it with the vm_lock things break (extra attach would
> leak into lock count). I'll see if I can catch all the cases when we
> do this and clean them up (not call vma_mark_attached() when not
> necessary).

Right, I hadn't looked at that thing in detail, that sounds like it
needs a wee cleanup like you suggest.

