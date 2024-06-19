Return-Path: <linux-kernel+bounces-220912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C424090E910
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE0C282E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBA3136E2C;
	Wed, 19 Jun 2024 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PxedeH7b"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABA282495
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795608; cv=none; b=EukyBbPLjwNHoZ/7oMI+i/QrXoplrop+S8UQR8nF6bpzokTFejnT5KErxxGF3naZJmJueEa7DnmbqVSTAYindMkHplxpdHNHiJn+hCbKAQ6Yw1hO4oxqW798EEXCnOZymffR5pHNz8sovYBiZbeSHzSedweYoxo2zXD5Zl9zgxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795608; c=relaxed/simple;
	bh=RZdUXIH9a+7G6DvRXdKFfOw6LMBwYt6W40XAo7xpZGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug2lSrLx5Rj44frHYswNQx3jTEwwf0iSMZyDCX2fVKmcsLUj92gg7rG3/3e45bGum7GZMkJIMbrV9B3HR7OMifR+YLvALWih0FNb3rIsNEJb8tC1GIW8n/+N8vVw0L55oJLNhslAf+2ptFFqjB/93nGzu9S+TD9VTPXxanMQOWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PxedeH7b; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MgDB73J+ESWc1hc2QijvGYX1poshHHKANGVhmb9xBg4=; b=PxedeH7bljUSHM3+fJzXO6JoUC
	J/wjd0MAVjrv+NqIGGa5YwYIR0+c8qY5KCnkMndOapMQSOypUSO+sVgMHsNhMv3cGj6afCVcZzaWd
	KrVm2ODUq+SsDOwsNtsIu1GRdLB58iX69mB5SwQOaAMLG09yQiJhsG5kM3YlZyFwXYmnRRZGlyaeg
	Y2OzLeOLcMfMmWpA8YJSGMMLA+6dQua5To1A8zoS9KsY9vM5HK8x8RFvDAVABawV/U6T8QoNrsS/y
	lmkCqNrO59mF+a9k5fnKWgXQTrmtfBgSWh85DZjlJQtQGgN7i4rOFWAPr+BCYfNlvWfkOS6I288Zl
	HwyASjwA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJtFW-00000007L2J-37Zt;
	Wed, 19 Jun 2024 11:13:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C73C4300561; Wed, 19 Jun 2024 13:13:09 +0200 (CEST)
Date: Wed, 19 Jun 2024 13:13:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
	elver@google.com, glider@google.com, nogikh@google.com,
	tarasmadan@google.com
Subject: Re: [PATCH v2 2/4] kcov: add interrupt handling self test
Message-ID: <20240619111309.GJ31592@noisy.programming.kicks-ass.net>
References: <cover.1718092070.git.dvyukov@google.com>
 <7662127c97e29da1a748ad1c1539dd7b65b737b2.1718092070.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7662127c97e29da1a748ad1c1539dd7b65b737b2.1718092070.git.dvyukov@google.com>

On Tue, Jun 11, 2024 at 09:50:31AM +0200, Dmitry Vyukov wrote:
> Add a boot self test that can catch sprious coverage from interrupts.
> The coverage callback filters out interrupt code, but only after the
> handler updates preempt count. Some code periodically leaks out
> of that section and leads to spurious coverage.
> Add a best-effort (but simple) test that is likely to catch such bugs.
> If the test is enabled on CI systems that use KCOV, they should catch
> any issues fast.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: syzkaller@googlegroups.com
> 
> ---
> 
> Changed since v1:
>  - renamed KCOV_TEST to KCOV_SELFTEST
>  - improved the config description
>  - loop for exactly 300ms in the test
> 
> In my local testing w/o the previous fix,
> it immidiatly produced the following splat:
> 
> kcov: running selftest
> BUG: TASK stack guard page was hit at ffffc90000147ff8
> Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN PTI
> ...
>  kvm_set_cpu_l1tf_flush_l1d+0x5/0x20
>  sysvec_call_function+0x15/0xb0
>  asm_sysvec_call_function+0x1a/0x20
>  kcov_init+0xe4/0x130
>  do_one_initcall+0xbc/0x470
>  kernel_init_freeable+0x4fc/0x930
>  kernel_init+0x1c/0x2b0

So I'm not entirely sure how the above BUG comes about, nor how this
selftest tickles it. Could you elaborate?
	
I've found check_kcov_mode() which has this !in_task() clause, but I'm
not entirely sure how failing that leads to the above mentioned failure.

> ---
>  kernel/kcov.c     | 31 +++++++++++++++++++++++++++++++
>  lib/Kconfig.debug |  8 ++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index c3124f6d5536..72a5bf55107f 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -11,6 +11,7 @@
>  #include <linux/fs.h>
>  #include <linux/hashtable.h>
>  #include <linux/init.h>
> +#include <linux/jiffies.h>
>  #include <linux/kmsan-checks.h>
>  #include <linux/mm.h>
>  #include <linux/preempt.h>
> @@ -1057,6 +1058,32 @@ u64 kcov_common_handle(void)
>  }
>  EXPORT_SYMBOL(kcov_common_handle);
>  
> +#ifdef CONFIG_KCOV_SELFTEST
> +static void __init selftest(void)
> +{
> +	unsigned long start;
> +
> +	pr_err("running self test\n");
> +	/*
> +	 * Test that interrupts don't produce spurious coverage.
> +	 * The coverage callback filters out interrupt code, but only
> +	 * after the handler updates preempt count. Some code periodically
> +	 * leaks out of that section and leads to spurious coverage.
> +	 * It's hard to call the actual interrupt handler directly,
> +	 * so we just loop here for a bit waiting for a timer interrupt.
> +	 * We set kcov_mode to enable tracing, but don't setup the area,
> +	 * so any attempt to trace will crash. Note: we must not call any
> +	 * potentially traced functions in this region.
> +	 */
> +	start = jiffies;
> +	current->kcov_mode = KCOV_MODE_TRACE_PC;

	barrier();

> +	while ((jiffies - start) * MSEC_PER_SEC / HZ < 300)
> +		;

	barrier();

> +	current->kcov_mode = 0;
> +	pr_err("done running self test\n");
> +}
> +#endif

