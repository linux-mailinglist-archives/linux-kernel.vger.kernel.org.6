Return-Path: <linux-kernel+bounces-211310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EA2904FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F85C1C2207E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4751216DEDB;
	Wed, 12 Jun 2024 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R0jb8D6A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0B5A34
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186340; cv=none; b=ozkdE/ftMMzxNL+L+MpGzx1+75laNhV4XidhoVW264Oed463eUZtdhCVRyJJQbH+Sm2tBMy6zR3pkXoIIoR2NEEPxyHWDr/pGC3BLgkp/qjxvYqerhIX6iSFJAI/iWPbtZ2Awu4UOiip0qeMp5WlMBHA8WNybGVCUoeAQ2YxjNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186340; c=relaxed/simple;
	bh=yGPmU6c0nn4fqF3A9xNUXtiVlyn/P1VcM1xKRmdmzQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa1CLJt8YizhIAnyyat60rBDYsbcEBuqJErh02vpmGfL02GOw/cq2LxhRInUkxl9//n4N5uftwpOYK2uTjQfzKWi0wpBbWkXui4DcRAmceOB1AksprvJW45WRaStHksRaGvkMEcFRJVyhfKcmBd48nI1IQZpFtCEz+AmEYxgElw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R0jb8D6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0851C3277B;
	Wed, 12 Jun 2024 09:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718186340;
	bh=yGPmU6c0nn4fqF3A9xNUXtiVlyn/P1VcM1xKRmdmzQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0jb8D6AkI4ujGjIqQicZT3T/N+whcwV45ycQxxBFpXDmvWWOsXVVA14/o4hiExaW
	 CVJXv9rLp9rPzLFdFT0w+NlDX5pm2wJNfD+Bq5Iu+vdWLzxzzPNK6/cE/IeLjB3eLJ
	 jrPQ9bSYhEi/a211bsjYJxDUglDsuwOj2A2BYjoU=
Date: Wed, 12 Jun 2024 11:58:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] binder_alloc: replace kcalloc with kvcalloc to mitigate
 OOM issues
Message-ID: <2024061216-faster-cufflink-ceac@gregkh>
References: <20240611085629.25088-1-liulei.rjpt@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240611085629.25088-1-liulei.rjpt@vivo.com>

On Tue, Jun 11, 2024 at 04:56:28PM +0800, Lei Liu wrote:
> In binder_alloc, there is a frequent need for order3 memory allocation,
> especially on small-memory mobile devices, which can lead to OOM and
> cause foreground applications to be killed, resulting in flashbacks.
> 
> We use kvcalloc to allocate memory, which can reduce system OOM
> occurrences, as well as decrease the time and probability of failure for
> order3 memory allocations. Additionally, it can also improve the
> throughput of binder (as verified by Google's binder_benchmark testing
> tool).
> 
> We have conducted multiple tests on an 8GB memory phone, and the
> performance of kvcalloc is better. Below is a partial excerpt of the
> test data.
> 
> throughput = (size * Iterations)/Time
> Benchmark-kvcalloc	Time	CPU	Iterations	throughput(Gb/s)
> ----------------------------------------------------------------
> BM_sendVec_binder-4096	30926 ns	20481 ns	34457	4563.66↑
> BM_sendVec_binder-8192	42667 ns	30837 ns	22631	4345.11↑
> BM_sendVec_binder-16384	67586 ns	52381 ns	13318	3228.51↑
> BM_sendVec_binder-32768	116496 ns	94893 ns	7416	2085.97↑
> BM_sendVec_binder-65536	265482 ns	209214 ns	3530	871.40↑
> 
> Benchmark-kvcalloc	Time	CPU	Iterations	throughput(Gb/s)

Both benchmarks are the same?  Or is this labeled incorrectly?

> ----------------------------------------------------------------
> BM_sendVec_binder-4096	39070 ns	24207 ns	31063	3256.56
> BM_sendVec_binder-8192	49476 ns	35099 ns	18817	3115.62
> BM_sendVec_binder-16384	76866 ns	58924 ns	11883	2532.86
> BM_sendVec_binder-32768	134022 ns	102788 ns	6535	1597.78
> BM_sendVec_binder-65536	281004 ns	220028 ns	3135	731.14
> 
> Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
> ---
>  drivers/android/binder_alloc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 2e1f261ec5c8..5dcab4a5e341 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -836,7 +836,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>  
>  	alloc->buffer = vma->vm_start;
>  
> -	alloc->pages = kcalloc(alloc->buffer_size / PAGE_SIZE,
> +	alloc->pages = kvcalloc(alloc->buffer_size / PAGE_SIZE,
>  			       sizeof(alloc->pages[0]),
>  			       GFP_KERNEL);

Nit, update the indentation please.

thanks,

greg k-h

