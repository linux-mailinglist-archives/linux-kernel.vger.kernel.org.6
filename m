Return-Path: <linux-kernel+bounces-380134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C89AE95B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DFA1C22160
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F90E1E631A;
	Thu, 24 Oct 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC4tZT3p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC03F1E3DF2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781435; cv=none; b=qljQKzNsbQtW295qOQb9RdJu/p92QCJf1OUpsAkWG/7UN/egrsaifrcnq9S87DRc7t+Mt6UsC7Yu9S2hTYndWZ+h3rBJ2LbEFF+OkMNmKt5kovxfK7u7RYuGwWpIApNCLEENfW7SQHgQUKRXVqn0YGFtB5JQTl6McXVbmZtCoG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781435; c=relaxed/simple;
	bh=NhIaoSw0gR3pQPGhb7rPIYZ2pg/iO0lhWZm8bnn3FWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYSBNWS2extztzAO4Nx3QJbfWQm0oU10wReVHMYCFUfurwit/xUQPGieTMZ74u6ZE3eZMsW8MGUAAxbttRpG/T/+MwkQ45qjvqDNx9rSlzSjMMpxZaaDJSvS3DYxg/9m3mN6hy05U3rP4ceFxtqESKKh6gH0uv8oh4Og/OkfMWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC4tZT3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65B7C4CEE4;
	Thu, 24 Oct 2024 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729781435;
	bh=NhIaoSw0gR3pQPGhb7rPIYZ2pg/iO0lhWZm8bnn3FWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aC4tZT3pMuqOqASPonwFqsYVxJpW8KZvs3KQksU+Y9v69Ao87TBHOSy7BiR7WjZiA
	 SBN+LTx7gEF/lC0voKuHDU4qsOITjRZ5HMkU+/TD2LMcxh4aYlWOpQZ+PWhd2HVfzy
	 sR3fqkg74wpduIl2RGxVjJQfVxz2VNinqfXgQe9XOZfKi7jTlfO9f6eBMz9b61AZDd
	 RHb7CJcTjSWIKIRJs0XGHXvaQmOt7neG64A5HdYtSQdGw7DU3t7H6/OhADvDqT4EHq
	 PfsWHHpnitXHy8EXGw9BWFNokQF+qM4bcflSQGK7jmIg/Q3NSz7E2Lpu/SyxmmppP7
	 vn/fgmULE/lqQ==
Date: Thu, 24 Oct 2024 15:50:30 +0100
From: Will Deacon <will@kernel.org>
To: Liao Chang <liaochang1@huawei.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, oliver.upton@linux.dev,
	kristina.martsenko@arm.com, ptosi@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Return early when break handler is found on
 linked-list
Message-ID: <20241024145028.GA31224@willie-the-truck>
References: <20241024034120.3814224-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024034120.3814224-1-liaochang1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 24, 2024 at 03:41:20AM +0000, Liao Chang wrote:
> The search for breakpoint handlers iterate through the entire
> linked list. Given that all registered hook has a valid fn field, and no
> registered hooks share the same mask and imm. This commit optimize the
> efficiency slightly by returning early as a matching handler is found.
> 
> v2->v1:
> Remove all WARN_ON(!hook->fn) in v1 as Will suggested.

nit: Changelogs like ^^^ should go after the '---' line, otherwise they
end up in the git history.

> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/arm64/kernel/debug-monitors.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index c60a4a90c6a5..58f047de3e1c 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -303,7 +303,6 @@ static int call_break_hook(struct pt_regs *regs, unsigned long esr)
>  {
>  	struct break_hook *hook;
>  	struct list_head *list;
> -	int (*fn)(struct pt_regs *regs, unsigned long esr) = NULL;
>  
>  	list = user_mode(regs) ? &user_break_hook : &kernel_break_hook;
>  
> @@ -313,10 +312,10 @@ static int call_break_hook(struct pt_regs *regs, unsigned long esr)
>  	 */
>  	list_for_each_entry_rcu(hook, list, node) {
>  		if ((esr_brk_comment(esr) & ~hook->mask) == hook->imm)
> -			fn = hook->fn;
> +			return hook->fn(regs, esr);
>  	}
>  
> -	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
> +	return DBG_HOOK_ERROR;
>  }
>  NOKPROBE_SYMBOL(call_break_hook);

Acked-by: Will Deacon <will@kernel.org>

I assume Catalin will pick this one up (but he'll need to tweak the
commit message as per my comment above).

Will

