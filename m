Return-Path: <linux-kernel+bounces-576693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D9AA71318
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478053AB88E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC221A3BA1;
	Wed, 26 Mar 2025 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O0uOAMMr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14271440C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742979174; cv=none; b=kS5Pt+zLNoySa9fGysAi0FIV2LN3Qs4pFUBNmJTWF3GwVqnylRUt/u7r7VbNGnffcmmgObcU+c/MhkuEALaFMWZsfg4ZJ6kxybFZ2fkmBj8gwI/Fw3Hw8ZBpdoTLxieTkyQ6hTZltv/A5pLhB82KqO5H8iCHlCe7P801J7xgPA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742979174; c=relaxed/simple;
	bh=pc6BzqgVr39k2T0UBlxABnkDyhytHZOH25/oOWeJDu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtKlPMlkYMsCNideYFvpGR1txTUsoolc4EDeKC66uSifrIqxpFenQsoQg3yyYwghwWsJ45fs4TVADrgFgslBFChX6Lj1W/VepM439A51KkX1djXiJioOkZwKXEFqFiiZ4MIkgHMYJm5dDgRW19tDYEqc41NIPCFFHldO1NBmves=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O0uOAMMr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KXImG46r4aiyY+vMwJl+o0biRuf3PwTtdX0fAmnKSiM=; b=O0uOAMMr3YBvGjWZ8TyB/vBveo
	8H25f4794jc4EFNqvqIBFVwx0b37UjqmpbJj8EjDm8y9RfZ1w//Wn59MfomQCyHgWZUINEZWMCOeG
	nmBgANWe1vvyYBXriiDDkhQm9jLAMiodaRiJxPu6/UpUSjPsAZTkAGyp2T3Tts+DD7CLwmiOimHgE
	w0Ig2rQDrDu57tW4IxNCLZiLlmEsoUh9D/5lKJTunAfG1i9YF1zqd7vZn0qKbVlqcghqjGpXAMAT6
	WPMoF8dzWi65Kc04CSQ1anteypyGjtBkqWv7i+T5ompeNUcSQZ2FBr4DLti0CoFxOfMaOyA8Jfwgf
	m0Vq5Pmw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txMVF-0000000HHzf-2DFV;
	Wed, 26 Mar 2025 08:52:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C6B0A3004AF; Wed, 26 Mar 2025 09:52:48 +0100 (CET)
Date: Wed, 26 Mar 2025 09:52:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/5] bugs/core: Do not print CPU and PID values
 in__warn() output
Message-ID: <20250326085248.GA25239@noisy.programming.kicks-ass.net>
References: <20250326084751.2260634-1-mingo@kernel.org>
 <20250326084751.2260634-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326084751.2260634-6-mingo@kernel.org>

On Wed, Mar 26, 2025 at 09:47:50AM +0100, Ingo Molnar wrote:
> For most warnings it's repeated anyway a few lines later, as
> part of the register dump:
> 
>   WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x410
>            ^^^^^^^^^^^^^
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-01616-g94d7af2844aa #4 PREEMPT(undef)
>   ^^^^^^^^^^^^^^^^^^
> 
> In fact the later dump is richer, as it includes the 'comm' line as well.
> 
> As a side effect, this makes some space for the 'file' field to be augmented
> with extra information (the condition string in particular).
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/panic.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index d8635d5cecb2..3101c21ca39f 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -725,12 +725,9 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>  	disable_trace_on_warning();
>  
>  	if (file)
> -		pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
> -			raw_smp_processor_id(), current->pid, file, line,
> -			caller);
> +		pr_warn("WARNING: %s:%d at %pS\n", file, line, caller);
>  	else
> -		pr_warn("WARNING: CPU: %d PID: %d at %pS\n",
> -			raw_smp_processor_id(), current->pid, caller);
> +		pr_warn("WARNING: at %pS\n", caller);

Over the years I've had concurrent WARNs interleaved on the console.
This duplicate information would allow untangling some of that.


