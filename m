Return-Path: <linux-kernel+bounces-547637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D4A50BDD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2C01895663
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2492C254B12;
	Wed,  5 Mar 2025 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pduOX6Bx"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B49D25485C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204002; cv=none; b=WytF+lZXxQO+5CwhS5dz04+F8gfPDNJj1Xu3X7SrZxT+VI0f2gyGYzcpmZTHYSoqIWbDmaENVeTZ0anptOmjn1hGfh6/wBMHrNp06qITS8gPQhr3TFI84h70wgEG/El4MP6E4mWXxo56d+B16vjjCrM6a6W2NJFB67cMN8mueNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204002; c=relaxed/simple;
	bh=TBYxcXb1uFyFuRMhjrlHFz8inUeSGUF71FqDEzLTzKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcXTddb+RqDlVgEBIQ4uQVRNlCJz95jmynCn0A+9VKk/uktQWNKu+/HuVhMIS16DmagIKEQ/bov/Nwaj+PXXAREwan2qLItoHxR9okH3jjVW/WtGlG65VhWDSzaIPZ3GBYNa1rMqVOJD0StPa3RF9gH59zl/5Vf9QYEdoRJqqCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pduOX6Bx; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Mar 2025 11:46:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741203996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DH4yyq1YOxF+bzlMB1SUQ5BPKUaI0NfAtTF6Qw6nZc=;
	b=pduOX6BxLOXgwIK495HLbYdHh7S7eLiS5RLNSg+GFiJ5ktzOnd+2EV7XpVFLxK8DtrunyT
	3mRF9z+j4Qm18W2W2R2kKCUGnGfd1jwH9x5+xfaC78oPzcII5cWLJnpO4ychcWE0LffRpJ
	zzbSJRGudHMaD2tDSdJH5MLXkddHS1I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, SeongJae Park <sj@kernel.org>, 
	"Liam R. Howlett" <howlett@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/16] mm/madvise: batch tlb flushes for
 MADV_DONTNEED and MADV_FREE
Message-ID: <snby4wevysj2hr6rmqcwezcujhwmjgtby6ogkrc4wmqnzcqcsv@tu23rsyltc2m>
References: <20250305181611.54484-1-sj@kernel.org>
 <Z8ieZVFEa6vAouvu@casper.infradead.org>
 <46960f37-0d12-4cfd-a214-1ddae2495665@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46960f37-0d12-4cfd-a214-1ddae2495665@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 05, 2025 at 08:19:41PM +0100, David Hildenbrand wrote:
> On 05.03.25 19:56, Matthew Wilcox wrote:
> > On Wed, Mar 05, 2025 at 10:15:55AM -0800, SeongJae Park wrote:
> > > For MADV_DONTNEED[_LOCKED] or MADV_FREE madvise requests, tlb flushes
> > > can happen for each vma of the given address ranges.  Because such tlb
> > > flushes are for address ranges of same process, doing those in a batch
> > > is more efficient while still being safe.  Modify madvise() and
> > > process_madvise() entry level code path to do such batched tlb flushes,
> > > while the internal unmap logics do only gathering of the tlb entries to
> > > flush.
> > 
> > Do real applications actually do madvise requests that span multiple
> > VMAs?  It just seems weird to me.  Like, each vma comes from a separate
> > call to mmap [1], so why would it make sense for an application to
> > call madvise() across a VMA boundary?
> 
> I had the same question. If this happens in an app, I would assume that a
> single MADV_DONTNEED call would usually not span multiples VMAs, and if it
> does, not that many (and that often) that we would really care about it.

IMHO madvise() is just an add-on and the real motivation behind this
series is your next point.

> 
> OTOH, optimizing tlb flushing when using a vectored MADV_DONTNEED version
> would make more sense to me. I don't recall if process_madvise() allows for
> that already, and if it does, is this series primarily tackling optimizing
> that?

Yes process_madvise() allows that and that is what SJ has benchmarked
and reported in the cover letter. In addition, we are adding
process_madvise() support in jemalloc which will land soon.


