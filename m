Return-Path: <linux-kernel+bounces-314515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 343DB96B45E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F3B289640
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B32518950D;
	Wed,  4 Sep 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iheBNwT/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D517C203
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437869; cv=none; b=ZQWq7iWNX+yDV8ryNZZs5naM/g9gMQoEVBR8CEKrm0+wOTuhS4IjXc2bGD8t3Re8e9T6HM83pBQZnsyOUMKtwEWC7HY7WQySgOR7R1d93/POFC2hvpwWZMaDZiLYhioPoXZE788b1DMZTIUa6AXrrMni5MOiN4lGqx5sOro4QgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437869; c=relaxed/simple;
	bh=dnd0GzUhmSEHNnmiMaEYVjWzbhS2M2DZ9ZiWsxE0o0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp8mNnOOmgQPlNQvb5wKnVnFbz99C5kEud8+zB9wHUXv30OISg1CG0aYLk5w/3hmxis0zJ48B24wC2xbzOCzoB2ejQ/UtCVCTIpTkTFFx/MRlS5rCEQS216j2chP1Pmm2r69E092iUe3DpRYltD9D9ZXZHAW63V6FgLMEIHWLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iheBNwT/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o/SaEGh8+cMIA7SBKPiC/ZFF8zdmm9+iX54U3DNJJ/4=; b=iheBNwT/MR86q2CwUnbfz0jCYi
	BzAJbFRMSKb7KA6dfueZBhucQtd9U7QhmYGzXnkPHDYVKPjfy7R2Aly2RP5P4tSlltXfX+bWJptwM
	4PhEAy5ikgHTXuAK20PM6J4xBc60FP8bfLa/KJwr154ARgEYQ6xCtE+nZmHifm6ksjvDN+AqA9rIt
	3KGUH7ZUHBFZka6HnDa/TuNK6PK56YqpVXSDK80yRKhQ3g5yl7t03sgeYJJ4nFSZv8lIK4XKrO4sH
	0TA4UoDNRskHo0zuU9fvSXzUF6fiqF1p087xI/uXU1IBChGEO4dRFRy7j8Ilu0cPY19OapFIMKFv/
	2Bse/EVQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sllCw-00000000YRz-3P5y;
	Wed, 04 Sep 2024 08:17:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B5192300642; Wed,  4 Sep 2024 10:17:43 +0200 (CEST)
Date: Wed, 4 Sep 2024 10:17:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
Message-ID: <20240904081743.GF4723@noisy.programming.kicks-ass.net>
References: <87cylj7v6x.ffs@tglx>
 <87a5gn7sqz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5gn7sqz.ffs@tglx>

On Wed, Sep 04, 2024 at 10:00:52AM +0200, Thomas Gleixner wrote:
> On Wed, Sep 04 2024 at 09:08, Thomas Gleixner wrote:
> > On Wed, Sep 04 2024 at 11:32, Jinjie Ruan wrote:
> > So the check must be:
> >
> > 	if (!static_call_key_has_mods(key))
> >         	break;
> >
> > I missed the module local case completely in my analysis. Can you please
> > modify the condition and retest?
> 
> That said. This code is pointlessly noisy for the failure case.
> 
> Allocation fails are not a reason to warn about. -ENOMEM is propagated
> all the way to the caller, so it's sufficient to emit a pr_warn().
> 
> Peter?

Yeah, I think that should do.

> Thanks,
> 
>         tglx
> ---
> --- a/kernel/static_call_inline.c
> +++ b/kernel/static_call_inline.c
> @@ -453,7 +453,7 @@ static int static_call_module_notify(str
>  	case MODULE_STATE_COMING:
>  		ret = static_call_add_module(mod);
>  		if (ret) {
> -			WARN(1, "Failed to allocate memory for static calls");
> +			pr_warn("Failed to allocate memory for static calls\n");
>  			static_call_del_module(mod);
>  		}
>  		break;

