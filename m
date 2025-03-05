Return-Path: <linux-kernel+bounces-547657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD9FA50C11
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0182188E1A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B7725335D;
	Wed,  5 Mar 2025 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q1y+8z1x"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC2249E5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204668; cv=none; b=d7xEwMlQQznmth2IRnjzOweYWI4lB/zCEgA51TAMLLTVKGGaWdSqRun1NlGWOsUP+QENzJqNVdZlmwFnXeUgwuJ4WYVsMO2BXkyYFxYN6xfLIKvO/dlMWsOi5v1BPRLlo/pwhy4tc04jULBCz/513m0v/kkWWexKXmEL1efe6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204668; c=relaxed/simple;
	bh=5IfmEMBLSn17y1bXlj85mdzWZLBD2lzlbwCUQXispsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guNL2a/uQyoUK7YdQcB18zyxd9Lp7/3UPdylmWN3FLYqy5w1EJvErC+LVaMUGRcV2DkreQ1tvwYLTSWLdiljmf2R6mKcMfiqeYA2lI4BZsrImkmCrLEyTinpLPSkK33nU7sJjvwnJSLnv6/qQXMfnbGvxckvJVBr8sq9oQVxWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q1y+8z1x; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Mar 2025 11:57:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741204663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BZ45IvxuT1CTbxL4RXBvU3iDHOginUNtnpFE38cxuc=;
	b=Q1y+8z1x5VgG/XpjBvKhsf+yFp15h+btREigmGTxucfx2h3D93SXm/7sToNWv3N60AK3e4
	lq2Ft8dgc4UKKOiZ5Z+cvG7Kzkg18IWSOW9aI2u48P24dOumyVkFtY54ZNeibr/rUe4io5
	C/Kz3QJnDDxILmjNuNnyIdIIOTi7blk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, SeongJae Park <sj@kernel.org>, 
	"Liam R. Howlett" <howlett@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/16] mm/madvise: batch tlb flushes for
 MADV_DONTNEED and MADV_FREE
Message-ID: <yhfyhovnztn3m224tdbq4hrth3bulq23ym57rp7prvodaapjdo@any7cn33suh3>
References: <20250305181611.54484-1-sj@kernel.org>
 <Z8ieZVFEa6vAouvu@casper.infradead.org>
 <46960f37-0d12-4cfd-a214-1ddae2495665@redhat.com>
 <snby4wevysj2hr6rmqcwezcujhwmjgtby6ogkrc4wmqnzcqcsv@tu23rsyltc2m>
 <815d1f2d-4bc0-40da-ba07-42593ae7ee45@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815d1f2d-4bc0-40da-ba07-42593ae7ee45@lucifer.local>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 05, 2025 at 07:49:50PM +0000, Lorenzo Stoakes wrote:
> On Wed, Mar 05, 2025 at 11:46:31AM -0800, Shakeel Butt wrote:
> > On Wed, Mar 05, 2025 at 08:19:41PM +0100, David Hildenbrand wrote:
> > > On 05.03.25 19:56, Matthew Wilcox wrote:
> > > > On Wed, Mar 05, 2025 at 10:15:55AM -0800, SeongJae Park wrote:
> > > > > For MADV_DONTNEED[_LOCKED] or MADV_FREE madvise requests, tlb flushes
> > > > > can happen for each vma of the given address ranges.  Because such tlb
> > > > > flushes are for address ranges of same process, doing those in a batch
> > > > > is more efficient while still being safe.  Modify madvise() and
> > > > > process_madvise() entry level code path to do such batched tlb flushes,
> > > > > while the internal unmap logics do only gathering of the tlb entries to
> > > > > flush.
> > > >
> > > > Do real applications actually do madvise requests that span multiple
> > > > VMAs?  It just seems weird to me.  Like, each vma comes from a separate
> > > > call to mmap [1], so why would it make sense for an application to
> > > > call madvise() across a VMA boundary?
> > >
> > > I had the same question. If this happens in an app, I would assume that a
> > > single MADV_DONTNEED call would usually not span multiples VMAs, and if it
> > > does, not that many (and that often) that we would really care about it.
> >
> > IMHO madvise() is just an add-on and the real motivation behind this
> > series is your next point.
> >
> > >
> > > OTOH, optimizing tlb flushing when using a vectored MADV_DONTNEED version
> > > would make more sense to me. I don't recall if process_madvise() allows for
> > > that already, and if it does, is this series primarily tackling optimizing
> > > that?
> >
> > Yes process_madvise() allows that and that is what SJ has benchmarked
> > and reported in the cover letter. In addition, we are adding
> > process_madvise() support in jemalloc which will land soon.
> >
> 
> Feels like me adjusting that to allow for batched usage for guard regions
> has opened up unexpected avenues, which is really cool to see :)
> 
> I presume the usage is intended for PIDFD_SELF usage right?

Yes.

> 
> At some point we need to look at allowing larger iovec size. This was
> something I was planning to look at at some point, but my workload is
> really overwhelming + that's low priority for me so happy for you guys to
> handle that if you want.
> 
> Can discuss at lsf if you guys will be there also :)

Yup, we will be there and will be happy to discuss.

Also the draft of jemalloc using process_madvise() is at [1].

[1] https://github.com/jemalloc/jemalloc/pull/2794

