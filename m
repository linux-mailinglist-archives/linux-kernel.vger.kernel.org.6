Return-Path: <linux-kernel+bounces-398653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4D09BF435
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E670528250B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A03D206948;
	Wed,  6 Nov 2024 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JZw05k1K"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B812064FB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730913650; cv=none; b=tq0rjMl4UgMAcsQOJ6JqerIJCSTA2vI8r09I40Z7ZHMr7JipO3NWiIs242IYupLYF+7wZwUPabMIq1nIVBcp9FmnuNg1d+TqyfBuV9BsmYqbetyrseOYO4HKyTd2gDG07/rNc7NLti3Fj1XqqnOBgHn1WxEDWNDuFJTWFZCHWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730913650; c=relaxed/simple;
	bh=RlHUja1Des5IGMPABMOhXsw8RPGJXKBiaIiv+AkTfWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyaXZztMCe2hg7U77W4g0ouBz+JuPO98VknYCzVolswZCHCGxwXo/DcvsmvSDrdKa/eVRu0V8i9pVKDC1yljbMqRpMzooX55VIjuX8MdbXe8n/XL8x5lGisyqjI2sfD7UquxxTgABP0Ty//Wk1zdtoah8JBMX5bLDFoANlNnR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JZw05k1K; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YaAQcBsa2cnJCgTjalITE0EwYt8XTOAU0x9FyUT2aS8=; b=JZw05k1KvEZXk5F7e2HwZwvyxD
	F4HS3USPHOuQqM7J3NfIdl4QmWC2+eAEUhHXzr4OH8Y8MJaCazJWRXIhCdoepIdjEavvL3XELl72I
	NgzSRvgxvJpy8oM+MuMcdp7KLtysrYGEdMv0/LN7jM7qUJ6pe087vfnFqi6lQi4RQ/pSrtfTrjUdk
	zsfQjMqWaouvWHTGxaj0Gt266sM4z457v3HjB6Ef4oiMIhcfLw9lW5pv5JKb7cka2wCicKKl2rF1D
	dLib/KvGxjSGZIbgPqYwzteOpdx4fYfB5mQh874Oxt4cOFzggJJMDVCWHrkv6oSoT7BmvI4iHMhg3
	CLpIJTYw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ji1-000000050Bh-26EG;
	Wed, 06 Nov 2024 17:20:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6A197300478; Wed,  6 Nov 2024 18:20:44 +0100 (CET)
Date: Wed, 6 Nov 2024 18:20:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] sched, x86: Update the comment for TIF_NEED_RESCHED_LAZY.
Message-ID: <20241106172044.GO10375@noisy.programming.kicks-ass.net>
References: <20241106162449.sk6rDddk@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106162449.sk6rDddk@linutronix.de>

On Wed, Nov 06, 2024 at 05:24:49PM +0100, Sebastian Andrzej Siewior wrote:
> Add the "Lazy" part to the comment for TIF_NEED_RESCHED_LAZY so it is
> not the same as TIF_NEED_RESCHED.

But it is lazy to copy/paste and not bother with comments, right? :-)

Thanks!

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/include/asm/thread_info.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 75bb390f7baf5..a55c214f3ba64 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -87,7 +87,7 @@ struct thread_info {
>  #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
>  #define TIF_SIGPENDING		2	/* signal pending */
>  #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
> -#define TIF_NEED_RESCHED_LAZY	4	/* rescheduling necessary */
> +#define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling needed */
>  #define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
>  #define TIF_SSBD		6	/* Speculative store bypass disable */
>  #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
> -- 
> 2.45.2
> 

