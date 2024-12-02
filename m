Return-Path: <linux-kernel+bounces-427200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E179DFDFD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C21281B9C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0131FC0F8;
	Mon,  2 Dec 2024 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PvLIBcMK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02A1F949
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133643; cv=none; b=lZMI1d7QEB+97qAWqBYzTimzKAxrKdZL1kQ1GGqGp6vJLCYyfRwdRWgKM2E2a6mpGaLLU7UJQrhHT5zfl3wVFD4Nyy4OOYRxGbbHFr5Rq7rYvpRwo+x45f1KJcSiluKUshpmpcKRdIwDxqD+ABdvGj6XZJnUApTiuAC2Jeze+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133643; c=relaxed/simple;
	bh=lFLsD/0Xqp/INe2Ls7r3LQ0h9Nqmzwf/lICtIE8q4wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msJirwu9767W23AvbYM3uhgNJ0P4ThUdGM5F4Y9ZdIZWmKJYRS73qkry1QeemS9xtjAEABblKWliyGBSVxrDHjKmh7potA7Sq6kMfOoxS9Keva502wb0s77N4vP3qyp+RrvmPuG6xZtdq6jZTD2LIOLv4oTYInksDUgjxD/TuNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PvLIBcMK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g3ETWtwH/Dl5K3O6c4I5zJIpk+A5IFQ+FwIqIH9QWkU=; b=PvLIBcMKs+ktvol/GHtdgK60x7
	r80F7DPfqO1Es1gYlB+7InO256ibTWKT4vN7+oeB1cipiDuUPSR/h/tdoxDGUN9AF1SD/nwyO/yhV
	LsSR+XCdQ9ApKNZ3H1v/qTPsf9hNgaCSQQU8o6e6N1aeOCm7zyoPL6USymv03ji+8F3S5oUZgWh7d
	3OjeAhUTkIk45dFKQou6s3peAArtEOhRqi7e8kPQeGmoM45pCwJA9zyBP5zQd+3A1dLviY/Ss3HF2
	wptR180gCuNy88YzfiZhx5K+AxmUmP85uGKGqWZ3i6NDGeTPgP0JaQdyDqeGP+3ioeTqPCOcNIYbt
	C8Fvd76A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tI3EK-00000007oWS-0zei;
	Mon, 02 Dec 2024 10:00:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 17343300402; Mon,  2 Dec 2024 11:00:37 +0100 (CET)
Date: Mon, 2 Dec 2024 11:00:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: jpoimboe@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: Fix the wrong format specifier
Message-ID: <20241202100036.GL24400@noisy.programming.kicks-ass.net>
References: <20241202041126.3563-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202041126.3563-1-zhangjiao2@cmss.chinamobile.com>

On Mon, Dec 02, 2024 at 12:11:26PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> The format specifier of "unsigned long" in printf()
> should be "%lu", not "%ld".

Your subject is wrong, also, who cares? Why did you write this patch?

> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  tools/objtool/check.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 4ce176ad411f..9c36bb519cf3 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -4934,10 +4934,10 @@ int check(struct objtool_file *file)
>  		disas_warned_funcs(file);
>  
>  	if (opts.stats) {
> -		printf("nr_insns_visited: %ld\n", nr_insns_visited);
> -		printf("nr_cfi: %ld\n", nr_cfi);
> -		printf("nr_cfi_reused: %ld\n", nr_cfi_reused);
> -		printf("nr_cfi_cache: %ld\n", nr_cfi_cache);
> +		printf("nr_insns_visited: %lu\n", nr_insns_visited);
> +		printf("nr_cfi: %lu\n", nr_cfi);
> +		printf("nr_cfi_reused: %lu\n", nr_cfi_reused);
> +		printf("nr_cfi_cache: %lu\n", nr_cfi_cache);
>  	}
>  
>  out:
> -- 
> 2.33.0
> 
> 
> 

