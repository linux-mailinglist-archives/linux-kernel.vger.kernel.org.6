Return-Path: <linux-kernel+bounces-192700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D98BA8D20E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE4CB229A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3719F17167F;
	Tue, 28 May 2024 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EO2UkSfT"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2CC17083D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911769; cv=none; b=tQsv9y8W9cdgtbjegt0c80wPLCejWqnTDP9YvOP76pLr+A1COTx8TjzSXS94YbYK0e1OnYPCYupVFr25Qcszraul1eWpgCsZ1H1cDEbjnKfchGda7hwftCTdeMHrikpbnKVj7oAjfFkflfyfv59L47gQqKAWYNTb1wA6AgqfaUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911769; c=relaxed/simple;
	bh=Z6eMR50d0y61b5WoKraSsjLkDr/ro12YqTUiPBx59K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+IkfbunvQ7vYg/7Lkj7sV6Uxgq7tbS3WjAEO3OIdVOXejN6IFMgx0hQ9OyUQyOsyGQP26ROcAgWIGtRWjQnsupFxgHJALmOqhSeNvaV4dWfUCPsRTw6hg+xQ9n6qjkm3QKYEuJlvhVAoxIy/wgyl/s6AtZ4by4Z4BILUp0dF5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EO2UkSfT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fM+NGcav1lckXHWpe96fpiDwqP/pc/A4QkuSVHmoM5M=; b=EO2UkSfTTa5hHUoQZmCXaVz7Uf
	unD1U2IYAboNy7zGKYpl2xVQ/iODiwWm3UG9ObKjs3xzJ1+/2nMuTe/MvZSPagut+q9G0ClYXpLt5
	ONXGy3qcBiGwz30+umOz06uElvlB7OtiROA+19oJ4VS9HbChgatBF3bsgZS+lvakYJlEw6i5NWeeX
	mwZKSBwVe4jPvBBiy/9bz+HRxsXjc6+Dm4kyJHKhWVYpcxYeU2BRC7fNXrNWHiPKfWGwqvIlBTUQ2
	nHl46WVxttdjmdly6HRjnDS+aVKTMyemIjVe9u287uwUSNtjAEDdqdLnTQKYOJtx5ri7OYb43LZgG
	KXH2Dymg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzAu-00000008nTY-1JSR;
	Tue, 28 May 2024 15:55:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E613D30058E; Tue, 28 May 2024 17:55:43 +0200 (CEST)
Date: Tue, 28 May 2024 17:55:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH v2 05/35] thread_info: selector for
 TIF_NEED_RESCHED[_LAZY]
Message-ID: <20240528155543.GA26599@noisy.programming.kicks-ass.net>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-6-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528003521.979836-6-ankur.a.arora@oracle.com>

On Mon, May 27, 2024 at 05:34:51PM -0700, Ankur Arora wrote:
> Define tif_resched() to serve as selector for the specific
> need-resched flag: with tif_resched() mapping to TIF_NEED_RESCHED
> or to TIF_NEED_RESCHED_LAZY.
> 
> For !CONFIG_PREEMPT_AUTO, tif_resched() always evaluates
> to TIF_NEED_RESCHED, preserving existing scheduling behaviour.
> 
> Cc: Peter Ziljstra <peterz@infradead.org>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  include/linux/thread_info.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 06e13e7acbe2..65e5beedc915 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -71,6 +71,31 @@ enum syscall_work_bit {
>  #define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
>  #endif
>  
> +typedef enum {
> +	RESCHED_NOW = 0,
> +	RESCHED_LAZY = 1,
> +} resched_t;
> +
> +/*
> + * tif_resched(r) maps to TIF_NEED_RESCHED[_LAZY] with CONFIG_PREEMPT_AUTO.
> + *
> + * For !CONFIG_PREEMPT_AUTO, both tif_resched(RESCHED_NOW) and
> + * tif_resched(RESCHED_LAZY) reduce to the same value (TIF_NEED_RESCHED)
> + * leaving any scheduling behaviour unchanged.
> + */
> +static __always_inline int tif_resched(resched_t rs)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO))
> +		return (rs == RESCHED_NOW) ? TIF_NEED_RESCHED : TIF_NEED_RESCHED_LAZY;
> +	else
> +		return TIF_NEED_RESCHED;
> +}

Perhaps:

	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) && rs == RESCHED_LAZY)
		return TIF_NEED_RESCHED_LAZY;

	return TIF_NEED_RESCHED;

hmm?

> +
> +static __always_inline int _tif_resched(resched_t rs)
> +{
> +	return 1 << tif_resched(rs);
> +}
> +
>  #ifdef __KERNEL__
>  
>  #ifndef arch_set_restart_data
> -- 
> 2.31.1
> 

