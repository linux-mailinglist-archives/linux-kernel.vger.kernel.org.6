Return-Path: <linux-kernel+bounces-534897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6DCA46C62
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0053AD37D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21262571A7;
	Wed, 26 Feb 2025 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aG7+FlGu"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4B256C8C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601564; cv=none; b=jvWg1pF6y0ddIrvDVq/TfcfcItAEq5CYeqbYWHyF+7AlLpE46O9Op2jFDiOCuZmYAuHzoluhn4ZGEeBurdJY5FJYH/8dQpPob+OyegFbn6y9CZZG+dHtaWjPNW39B8LrArxq83NChhGv/OjB9nFFHrsknglF7Aa9U5oobi4Cvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601564; c=relaxed/simple;
	bh=8MVBMQM1Iw3yKzj2w0u0FTD+IoYzkrwy87ja4gr7IJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMUQpPxJEUO/hi44vWwKYWP5vr6M9ltSTtJxgVCvFZ0p886n39IMpXGzVDlO4UCMxz5RPze3n+qF2hN7cJjd8CxHbJ7RKUWtn0rtiCfK3JiSIdiRvoIMj+GugN7hrsDZHCMvid/KHcBDpeoAkKNL8kCjcnGp/7wgVkXRqnjae+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aG7+FlGu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G9zstfvvCatDGHnNVZMXYf5NNGYqnIPHvVpqN2IbsII=; b=aG7+FlGu11OPuRNyFcFlYr+KWV
	3CW9fDc97vxGomhgSEPeWGO6K+J16xmpnARRzrNaD7PMeMx7l4atRhqhCW3jqjLLWnYuTImiWqvs4
	MtKIYcb62O+9wW64dyH/Nwup5WFUgJQgSOs1fT9GRrrQcXN9JrySMRE1g3yu90MEYhy6QGkd5X8ha
	4iIaHE35Dwa9dSOnNzveeLHgdhiV7tJV4OhaSO8Eqxyc9XkAS6Ps5IUtj5j7uitRCYWGV0kbOmoyq
	034jsPun75IrKWD4F9hSxixbomvq15FXb6TWn9E8rzgDFHzbAoGDcgw5qXGpIOUcX/r7TPBWbtHvF
	4ngwRIsw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tnNyd-00000003gXd-31Cm;
	Wed, 26 Feb 2025 20:25:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 19E70300677; Wed, 26 Feb 2025 21:25:55 +0100 (CET)
Date: Wed, 26 Feb 2025 21:25:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 07/11] x86/irq: Move irq stacks to percpu hot section
Message-ID: <20250226202554.GC29387@noisy.programming.kicks-ass.net>
References: <20250226180531.1242429-1-brgerst@gmail.com>
 <20250226180531.1242429-8-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226180531.1242429-8-brgerst@gmail.com>

On Wed, Feb 26, 2025 at 01:05:26PM -0500, Brian Gerst wrote:

> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index 474af15ae017..2cd2064457b1 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -34,6 +34,11 @@ EXPORT_PER_CPU_SYMBOL(irq_stat);
>  DEFINE_PER_CPU_CACHE_HOT(u16, __softirq_pending);
>  EXPORT_PER_CPU_SYMBOL(__softirq_pending);
>  
> +DEFINE_PER_CPU_CACHE_HOT(struct irq_stack *, hardirq_stack_ptr);
> +#ifdef CONFIG_X86_64
> +DEFINE_PER_CPU_CACHE_HOT(bool, hardirq_stack_inuse);
> +#endif
> +
>  atomic_t irq_err_count;
>  
>  /*

Perhaps instead of the above #ifdef,...

> diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
> index dc1049c01f9b..48a27cde9635 100644
> --- a/arch/x86/kernel/irq_32.c
> +++ b/arch/x86/kernel/irq_32.c
> @@ -52,6 +52,8 @@ static inline int check_stack_overflow(void) { return 0; }
>  static inline void print_stack_overflow(void) { }
>  #endif
>  
> +DEFINE_PER_CPU_CACHE_HOT(struct irq_stack *, softirq_stack_ptr);
> +
>  static void call_on_stack(void *func, void *stack)
>  {
>  	asm volatile("xchgl	%%ebx,%%esp	\n"

> diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
> index 56bdeecd8ee0..4834e317e568 100644
> --- a/arch/x86/kernel/irq_64.c
> +++ b/arch/x86/kernel/irq_64.c

stick it in this file, like you already did for the 32bit case?

