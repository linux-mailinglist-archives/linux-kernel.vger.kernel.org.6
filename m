Return-Path: <linux-kernel+bounces-303349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89613960B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A152848C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4D21BD010;
	Tue, 27 Aug 2024 12:50:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF55199EAC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763044; cv=none; b=JvZQspVWSK7GhGJM97iLqNvKaE1pcQqL8R6xu0qJLeK+eM+RqHFYK0xIdv3mROavhRPAkJeJ8b4dEAv+5QdJy72gqmZtccA4S0W97Gki+hitdkpsMJUKDhAhumnnQJZtp4bAvb00431/902ZbpJ/Y+tAx1KheCzNoV3pNxem9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763044; c=relaxed/simple;
	bh=huO9vWhEDsPBlw8H6PQbdg1lfJ5sk4zBJisn6bmODh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdaiZ3IauWUW6U2wrgmUJLwZCsVTDn4TnPk6jtf7gSJ7J1+BO8k70EmHsj2c15q+NnkSiSctqpigE0Wlpc1zjBOA2mYIOdowquPTFwfIE4pNPOhM1BvJwraumvqinVkFZvjH17KsEN/uqzOQsBTR0yzlVTeuOGGuOvczx8gBtFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1437DA7;
	Tue, 27 Aug 2024 05:51:06 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A93EA3F66E;
	Tue, 27 Aug 2024 05:50:39 -0700 (PDT)
Date: Tue, 27 Aug 2024 13:50:37 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, ptosi@google.com,
	oliver.upton@linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Return early when break handler is found on
 linked-list
Message-ID: <Zs3LnYkXL5sg2yBH@J2N7QTR9R3.cambridge.arm.com>
References: <20240827110046.3209679-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827110046.3209679-1-liaochang1@huawei.com>

On Tue, Aug 27, 2024 at 11:00:46AM +0000, Liao Chang wrote:
> The search for breakpoint handlers iterate through the entire
> linked list. Given that all registered hook has a valid fn field, and no
> registered hooks share the same mask and imm. This commit optimize the
> efficiency slightly by returning early as a matching handler is found.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>

This looks fine, though I'd love if we could clean this up to remove the
linked list entirely by separating the user/kernel entrypoints and using
a switch statement to decide the handler based on the immediate. That'd
also remove the need for RCU protection.

Last I looked that would require some largely mechanical restructuring,
and the only painful bit was the hooks that KGDB uses, since those are
the only ones that actually get unregistered.

Mark.

> ---
>  arch/arm64/kernel/debug-monitors.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 024a7b245056..fc998956f44c 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -281,6 +281,7 @@ static LIST_HEAD(kernel_break_hook);
>  
>  void register_user_break_hook(struct break_hook *hook)
>  {
> +	WARN_ON(!hook->fn);
>  	register_debug_hook(&hook->node, &user_break_hook);
>  }
>  
> @@ -291,6 +292,7 @@ void unregister_user_break_hook(struct break_hook *hook)
>  
>  void register_kernel_break_hook(struct break_hook *hook)
>  {
> +	WARN_ON(!hook->fn);
>  	register_debug_hook(&hook->node, &kernel_break_hook);
>  }
>  
> @@ -303,7 +305,6 @@ static int call_break_hook(struct pt_regs *regs, unsigned long esr)
>  {
>  	struct break_hook *hook;
>  	struct list_head *list;
> -	int (*fn)(struct pt_regs *regs, unsigned long esr) = NULL;
>  
>  	list = user_mode(regs) ? &user_break_hook : &kernel_break_hook;
>  
> @@ -313,10 +314,10 @@ static int call_break_hook(struct pt_regs *regs, unsigned long esr)
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
>  
> -- 
> 2.34.1
> 
> 

