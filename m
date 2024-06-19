Return-Path: <linux-kernel+bounces-220925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A0190E944
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB0C1C22F41
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068CA13AA35;
	Wed, 19 Jun 2024 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d+0e30cv"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A0D135A6D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796229; cv=none; b=axt+5LfZE5nxW40ApsxXCc61nLRAAAUWqzmDK77MGQrynCaK16YgFmYwxndN7lKLR/ib0eJ5Pkj+++zrGb1/S6AAJJdd/ej4igYvpJpI256nZNbscl5Jw+NFfQj3aRA8QW6jx+//ePHTOiO+QZHBuBUwTBlOoaBMzZFa1uY/yHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796229; c=relaxed/simple;
	bh=BBguYIkPhr2cW/zW4H5cmmkMU04bj5Cf+LYralRxPqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sb36AhuoR811I+8/XzfQmAQd9CjVmXS46dYKLygD0xKeBfhP0/9DfvDTyRbhiLFZAdr+jIDlK+wuw3181td6yDJwVcX/7W4qadWqZmDJB/EE44MVrvgQXk9YnhWLSf+XKZICwkKuZCQaUYxdJ4Uq0B0u38Ad0N1ohis/uoxgA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d+0e30cv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CwCo1n4Fm3232a95hepCYO9qcNQgRqZ13zK7evdQL9U=; b=d+0e30cv62/smwEKJ2OStOkgnz
	TcbCKoEcEthhdeSi/cvS+fUtOdRHrjCtmrwGlu4UhaXRmwbfc78b7friiIggTSOBiit0zOvJ+Elci
	O+zASOYhOMR21czciHxhpvYq30AD8fRkHo01DF1j1hl4azOe5jczcGxokySNfvfJnniLWIUUa/aYg
	WIFFm971TFT4gV3F9dAd0beMnbTVh2g07SDYJPL2Q3TmvOClmhvkwSYuaKkNtXfEIF3xy+v3ySBZx
	iVOYAzxq0n51zYXGBrjLe3D5eGT35VtQoGIWZ0Z1PZ/3yDX/mTYJyFOouoTe1J7iUVKAk2yu/PbnV
	X+oCpK3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJtPZ-00000004chx-0jGh;
	Wed, 19 Jun 2024 11:23:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 97E37300561; Wed, 19 Jun 2024 13:23:32 +0200 (CEST)
Date: Wed, 19 Jun 2024 13:23:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
	elver@google.com, glider@google.com, nogikh@google.com,
	tarasmadan@google.com
Subject: Re: [PATCH v2 4/4] x86: Ignore stack unwinding in KCOV
Message-ID: <20240619112332.GL31592@noisy.programming.kicks-ass.net>
References: <cover.1718092070.git.dvyukov@google.com>
 <eaf54b8634970b73552dcd38bf9be6ef55238c10.1718092070.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaf54b8634970b73552dcd38bf9be6ef55238c10.1718092070.git.dvyukov@google.com>

On Tue, Jun 11, 2024 at 09:50:33AM +0200, Dmitry Vyukov wrote:
> Stack unwinding produces large amounts of uninteresting coverage.
> It's called from KASAN kmalloc/kfree hooks, fault injection, etc.
> It's not particularly useful and is not a function of system call args.
> Ignore that code.

This stems from KCOV's purpose being guiding syzkaller as opposed to it
being a more general coverage tool, right?

Is that spelled out anywhere?

Anyway,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Reviewed-by: Marco Elver <elver@google.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: syzkaller@googlegroups.com
> ---
>  arch/x86/kernel/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 20a0dd51700a..cd49ebfae984 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -39,6 +39,14 @@ KMSAN_SANITIZE_sev.o					:= n
>  # first second.
>  KCOV_INSTRUMENT_head$(BITS).o				:= n
>  KCOV_INSTRUMENT_sev.o					:= n
> +# These are called from save_stack_trace() on debug paths,
> +# and produce large amounts of uninteresting coverage.
> +KCOV_INSTRUMENT_stacktrace.o				:= n
> +KCOV_INSTRUMENT_dumpstack.o				:= n
> +KCOV_INSTRUMENT_dumpstack_$(BITS).o			:= n
> +KCOV_INSTRUMENT_unwind_orc.o				:= n
> +KCOV_INSTRUMENT_unwind_frame.o				:= n
> +KCOV_INSTRUMENT_unwind_guess.o				:= n
>  
>  CFLAGS_irq.o := -I $(src)/../include/asm/trace
>  
> -- 
> 2.45.2.505.gda0bf45e8d-goog
> 

