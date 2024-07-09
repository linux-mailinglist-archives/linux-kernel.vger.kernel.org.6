Return-Path: <linux-kernel+bounces-245437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7FC92B27F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6734A1F22124
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBF91552FC;
	Tue,  9 Jul 2024 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paxxODwG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F3154BEB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514746; cv=none; b=S1lmLYz4XsdaVxaRor0FlPJnaXc4wjo9x8/LvK+fAwrplVsQNe87eETltPQHOnNrlBRadNM0Pf7GJhjAelqKyZpmqONOLbW5YI5Uk5GI27GWbQK/WU/+u6V/yhWaOAKTd5K2gbvLIdYXsjDXvP2nQfX7Bh6NfiMRKfElNBtRqLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514746; c=relaxed/simple;
	bh=HzI5ANFt9GMQuaC6OglWBygqf04hLrubGkDWVL2nkdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfZinZnbTzEWbTKeiUFAC0n1fb5A682jC7Y0NZwF1CqoGMVom170HC99N0yyZlx+t2wbanXRZ3SmUqf9TcO6en8K0Cfzvl3uoERmDXBLZ2arqHXbpAxHf2YiO5C5JOc+6s2W2QHxoWwOkUwJ/HtuJ36ffNyHc8z2CMdOBJyREsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paxxODwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5A2C32786;
	Tue,  9 Jul 2024 08:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720514746;
	bh=HzI5ANFt9GMQuaC6OglWBygqf04hLrubGkDWVL2nkdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=paxxODwGsxgN/pEQCvdzSL8hJYt+b0437kRpZFx7gvuqp0Et6MibQNDT7dw5OJenl
	 ZpP2v5NDKIt5qyUIhYTRz9iwsCSYGTL4xOG8t3P6yP0guiI3pgywBrHRp6GLfiHsBm
	 XejMQMS/XS45WISy9JQmiIx7rBSzf+xqah5JK8nYpVkjQ+WZB8L8rIuiZLWJmJ4WP6
	 SIUiCF2pYL7MLtZQGccyomcq/53rjq1QmSSws4PPLTBqgRBfJkdsR/SL0bWXzUx+2+
	 f8qPAc8Wxo9bxVRJkowDH5pLFadbbratB99pJeRW9j1/8/ABGTqkFuW+O5CfYhrRMP
	 JNxz6kechq0bg==
Date: Tue, 9 Jul 2024 11:43:01 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, oleg@redhat.com,
	tandersen@netflix.com, mjguzik@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 2/3] kernel/fork.c: get totalram_pages from memblock
 to calculate max_threads
Message-ID: <Zoz4FVwlGgUGY6re@kernel.org>
References: <20240709023609.21332-1-richard.weiyang@gmail.com>
 <20240709023609.21332-2-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709023609.21332-2-richard.weiyang@gmail.com>

On Tue, Jul 09, 2024 at 02:36:08AM +0000, Wei Yang wrote:
> Since we plan to move the accounting into __free_pages_core(),
> totalram_pages may not represent the total usable pages on system
> at this point when defer_init is enabled.
> 
> Instead we can get the total estimated pages from memblock directly.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Mike Rapoport (IBM) <rppt@kernel.org>
> CC: David Hildenbrand <david@redhat.com>
> CC: Oleg Nesterov <oleg@redhat.com>

Acked-by: Mike Rapoport <rppt@kernel.org>

> ---
>  kernel/fork.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 279efadabbf2..d6c2a4ccd532 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -44,6 +44,7 @@
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/mm_inline.h>
> +#include <linux/memblock.h>
>  #include <linux/nsproxy.h>
>  #include <linux/capability.h>
>  #include <linux/cpu.h>
> @@ -999,7 +1000,7 @@ void __init __weak arch_task_cache_init(void) { }
>  static void set_max_threads(unsigned int max_threads_suggested)
>  {
>  	u64 threads;
> -	unsigned long nr_pages = totalram_pages();
> +	unsigned long nr_pages = memblock_estimated_nr_free_pages();
>  
>  	/*
>  	 * The number of threads shall be limited such that the thread
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

