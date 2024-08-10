Return-Path: <linux-kernel+bounces-282051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CF094DF07
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 00:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13AF61C21037
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 22:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE36142629;
	Sat, 10 Aug 2024 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="obgXTYiB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6811422B4;
	Sat, 10 Aug 2024 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723328113; cv=none; b=bYSKu/LYTqVbc1fugZfvCTdWNrQpk2fRVJeMlWY4sdf9uC8YLkDBaD3s2pnZm4XSbPljSjHTfRzdxjffuN/VNbeH0jFrduRhqhQYByG3kThd22YNWHJLEsquYODHo34tV2ItU47UAJn42zAQS1ScGDbGoTD3Qmv3tFH7K//Pu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723328113; c=relaxed/simple;
	bh=B65xwCOe3VkI65GHIok/4lUn7GKvQwssFjB5wJjsOrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBea/1y9T4c+jGZOT7pQDTrghXmOxI5r05iV9QgunpUVoGvjWFS0zgRAyjt1npjB0cc6ErATWHlNaN9RcScgMBfjOYdJS4urEFw3O87ZqrACVLiPSiLmPCz98GdoC7ci33grIYT68a3kjS8BSk9L+GQvNhQoIWY2204A9adEOvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=obgXTYiB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u+474jO65+2SLITFc26I/AUfOj7pAAQfFYHWkSyVGVk=; b=obgXTYiBulWaNOUkN6wbxS9UAd
	6yYOh0MfZO+fnXuXCvmMgJ6pygiyENEiLXU08CbOi2mmwCcZeSzT0dDbbDkG/q4dwmJhyysZifhyY
	oBd2FLPOEhBZwuX0duWhwyKwre/EBIJl5X4GHvJpm2sb5ztr9X47VxWqIwt+wfGX9CmgY7c7+/6Gr
	BbYIsJUVYqkiG1x/Lo+wbtchaNO531Kl0HE2OszLm4mb+wSGJRxUZN4mySgl2gbSSvARaH/2Kx1Vv
	39I0kNXVwpxJwDzE+0EhsgKLyFE2+PZwsnZ6FjTup1SyjT0jqmclLgwiamW2El2JAn7pt5wvDlEN8
	8GbbK8Ag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scuMe-0000000CoFr-3R1S;
	Sat, 10 Aug 2024 22:15:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D1993300729; Sun, 11 Aug 2024 00:15:07 +0200 (CEST)
Date: Sun, 11 Aug 2024 00:15:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Remove setting of page->index and ->mapping
Message-ID: <20240810221507.GI11646@noisy.programming.kicks-ass.net>
References: <20240809201038.2648058-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809201038.2648058-1-willy@infradead.org>

On Fri, Aug 09, 2024 at 09:10:36PM +0100, Matthew Wilcox (Oracle) wrote:
> I have no idea why perf is setting these fields.  There should be
> no need to do this.

Because these are not shared pages and nobody will ever look at these
fields? Yeah, I can't for the life of me remember why I did that.

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  kernel/events/core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index aa3450bdc227..f55ab04f3df0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6221,8 +6221,6 @@ static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
>  		goto unlock;
>  
>  	get_page(vmf->page);
> -	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
> -	vmf->page->index   = vmf->pgoff;
>  
>  	ret = 0;
>  unlock:
> -- 
> 2.43.0
> 

