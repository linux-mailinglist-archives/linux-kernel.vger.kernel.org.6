Return-Path: <linux-kernel+bounces-547689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1179DA50C69
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20203A9AF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46568255230;
	Wed,  5 Mar 2025 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SlOZ9KuK"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126D525332F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206157; cv=none; b=sLvBZzrccqrUCj1gjoIFBLaNZ2Um7VKaZVYRKDUGNPvF3IXH3Hx8xrXkc+bCUEVPZ/fZLcknqIhH7zGrR1jTW8/HblBrhGI08rBDpW8iGgc93ey+CLGHxeRL0l7B1TerFAEFfpbjf6xyUUiSHFxI/sGXc+W4C142rcqEOr/HDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206157; c=relaxed/simple;
	bh=umN5bkeHFSQuRo6aIF8Zv1z+PnNEYPXq8Sbo8eKVCC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOXOBkzBwfIAVT0GAeom/uvXuZItb+Y55NeCPh1PHoI7HshD1d3pcQH6sQBU9sAbjeF96TkRa+ulxu+ct2lQby77onL2Wc6g8l5WbJB6FnlhggiPSL4nmNwykAuuhyZBTUjibyL6SgyXDRb58bVoxjVAiV09O2c0/J6oeofZ18w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SlOZ9KuK; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Mar 2025 12:22:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741206152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60IYXncwzNAIP2DDPmSH9jAFXc71tM9uKRjLp1njXNA=;
	b=SlOZ9KuKK6o/G8SJDyBxmZR8PyO6enQbmzy41bVGtgaIGTlSNUOquZK2nusuY2JZUDxOIq
	ie0od8LW6I7uYE7lvYISL+k/PcOE+T9aA6X1+GgmDy237fdzJclo0ikgq9/4E0qcP52jqv
	pXXpueDBk4R+enqEUKdVUfNzaLXlSUo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <howlett@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/16] mm/madvise: batch tlb flushes for
 MADV_DONTNEED and MADV_FREE
Message-ID: <ro2wtggwxbmwk6lhvcixwrefo44x7ggeumevv7lyupvudwxjsg@onh2e46eqzcy>
References: <20250305181611.54484-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305181611.54484-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 05, 2025 at 10:15:55AM -0800, SeongJae Park wrote:
> For MADV_DONTNEED[_LOCKED] or MADV_FREE madvise requests, tlb flushes
> can happen for each vma of the given address ranges.  Because such tlb
> flushes are for address ranges of same process, doing those in a batch
> is more efficient while still being safe.  Modify madvise() and
> process_madvise() entry level code path to do such batched tlb flushes,
> while the internal unmap logics do only gathering of the tlb entries to
> flush.
> 
> In more detail, modify the entry functions to initialize an mmu_gather
> ojbect and pass it to the internal logics.  Also modify the internal
> logics to do only gathering of the tlb entries to flush into the
> received mmu_gather object.  After all internal function calls are done,
> the entry functions finish the mmu_gather object to flush the gathered
> tlb entries in the one batch.
> 
> Patches Seuquence
> =================
> 
> First four patches are minor cleanups of madvise.c for readability.
> 
> Following four patches (patches 5-8) define new data structure for
> managing information that required for batched tlb flushing (mmu_gather
> and behavior), and update code paths for MADV_DONTNEED[_LOCKED] and
> MADV_FREE handling internal logics to receive it.
> 
> Three patches (patches 9-11) for making internal MADV_DONTNEED[_LOCKED]
> and MADV_FREE handling logic ready for batched tlb flushing follow. 

I think you forgot to complete the above sentence or the 'follow' at the
end seems weird.

> The
> patches keep the support of unbatched tlb flushes use case, for
> fine-grained and safe transitions.
> 
> Next three patches (patches 12-14) update madvise() and
> process_madvise() code to do the batched tlb flushes utilizing the
> previous patches introduced changes.
> 
> Final two patches (patches 15-16) clean up the internal logics'
> unbatched tlb flushes use case support code, which is no more be used.
> 
> Test Results
> ============
> 
> I measured the time to apply MADV_DONTNEED advice to 256 MiB memory
> using multiple process_madvise() calls.  I apply the advice in 4 KiB
> sized regions granularity, but with varying batch size (vlen) from 1 to
> 1024.  The source code for the measurement is available at GitHub[1].
> 
> The measurement results are as below.  'sz_batches' column shows the
> batch size of process_madvise() calls.  'before' and 'after' columns are
> the measured time to apply MADV_DONTNEED to the 256 MiB memory buffer in
> nanoseconds, on kernels that built without and with the MADV_DONTNEED
> tlb flushes batching patch of this series, respectively.  For the
> baseline, mm-unstable tree of 2025-03-04[2] has been used.
> 'after/before' column is the ratio of 'after' to 'before'.  So
> 'afetr/before' value lower than 1.0 means this patch increased
> efficiency over the baseline.  And lower value means better efficiency.

I would recommend to replace the after/end column with percentage i.e.
percentage improvement or degradation.

> 
>     sz_batches    before       after        after/before
>     1             102842895    106507398    1.03563204828102
>     2             73364942     74529223     1.01586971880929
>     4             58823633     51608504     0.877343022998937
>     8             47532390     44820223     0.942940655834895
>     16            43591587     36727177     0.842529018271347
>     32            44207282     33946975     0.767904595446515
>     64            41832437     26738286     0.639175910310939
>     128           40278193     23262940     0.577556694263817
>     256           41568533     22355103     0.537789077136785
>     512           41626638     22822516     0.54826709762148
>     1024          44440870     22676017     0.510251419470411
> 
> For <=2 batch size, tlb flushes batching shows no big difference but
> slight overhead.  I think that's in an error range of this simple
> micro-benchmark, and therefore can be ignored.  

I would recommend to run the experiment multiple times and report
averages and standard deviation which will support your error range
claim.

> Starting from batch size
> 4, however, tlb flushes batching shows clear efficiency gain.  The
> efficiency gain tends to be proportional to the batch size, as expected.
> The efficiency gain ranges from about 13 percent with batch size 4, and
> up to 49 percent with batch size 1,024.
> 
> Please note that this is a very simple microbenchmark, so real
> efficiency gain on real workload could be very different.
> 

I think you are running a single thread benchmark on a free machine. I
expect this series to be much more beneficial on loaded machine and for
multi-threaded applications. No need to test that scenario but if you
have already done that then it would be good to report.

