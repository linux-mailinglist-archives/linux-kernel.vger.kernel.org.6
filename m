Return-Path: <linux-kernel+bounces-576695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D155A7131C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771961882805
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE961A3BA1;
	Wed, 26 Mar 2025 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h8cJkZyp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33C016C69F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742979227; cv=none; b=Z830m3KcbYnLMfVekzEZKbsQo6Otnh17pI6dlhZ87NADNsKthqXsbUp2iiHdBjgjjsYbeyaIsUNdXAnPEohi2MNllZjsBMQFv1wIh2jgCLvwteX4WbvAVcAPBvIhCVGg8whYc/D/F/NZWyMasRLnnkU7Y4CqVOuP3gneiDX+dfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742979227; c=relaxed/simple;
	bh=Q0Vz4BnWEoV8d3KJhDciLDDw86cj6UjnHN1wZiI6AeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkjG0zpBk+BGGl/3nxOm1HmMZ0Q7ls5H5+JLqqOHkGIiedHvLDdeWlwTgN5escV2+22O+AhQ6QJL8Va5TMiOpe8hqMfbBckdbZwyzi12ToaZTF81p1aloZY/kADPmz2LyIYU4wZiLKS7UWDzNB++7zAYb6CZZ6CSgvR/lpeITV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h8cJkZyp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+Oyj1+Yuh3t5Ds+zgnlZKjdk114RL52JfsN5scWbCmo=; b=h8cJkZypcasMoxYJgpl1Wb1UQy
	1SVpYW+K15WzyQqSEkalT7EkROS9qg8vieN85WyhzUv8d5wY08Xp1T1RpI/vg7CMf8WUJ+2C5HLvn
	NXorSCe/0gIRiIFLB65w8sBp20RWs0ORHYo9211SBoEwlvMbnbPjd3OAU16ONKUsWzER21oN8FLym
	8aPbGgVNoe31FwXAVwLs/PiYPpauPOD/hca/0v8VFqIJdybkY3qfd8FUyRdubkIUEYXkvJnr5/Ae4
	NRnzg1aLEDRt454cOFoIUKv+9E/tSUrYz0KnzvFDL4tFVbvzY0ZxjDpRAPxbxiqWJhyA43xAvotLW
	zsd/r05w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txMW7-0000000HI4I-1jWs;
	Wed, 26 Mar 2025 08:53:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 10BC73004AF; Wed, 26 Mar 2025 09:53:43 +0100 (CET)
Date: Wed, 26 Mar 2025 09:53:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/5] bugs/x86: Augment warnings output by concatenating
 'cond_str' with the regular __FILE__ string in _BUG_FLAGS()
Message-ID: <20250326085343.GB25239@noisy.programming.kicks-ass.net>
References: <20250326084751.2260634-1-mingo@kernel.org>
 <20250326084751.2260634-5-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326084751.2260634-5-mingo@kernel.org>

On Wed, Mar 26, 2025 at 09:47:49AM +0100, Ingo Molnar wrote:
> This allows the reuse of the UD2 based 'struct bug_entry' low-overhead
> _BUG_FLAGS() implementation and string-printing backend, without
> having to add a new field.
> 
> An example:
> 
> If we have the following WARN_ON_ONCE() in kernel/sched/core.c:
> 
> 	WARN_ON_ONCE(idx < 0 && ptr);
> 
> Then previously _BUG_FLAGS() would store this string in bug_entry::file:
> 
> 	"kernel/sched/core.c"
> 
> After this patch, it would store and print:
> 
> 	"[idx < 0 && ptr] kernel/sched/core.c"
> 
> Which is an extended string that will be printed in warnings.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/include/asm/bug.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> index aff1c6b7a7f3..e966199c8ef7 100644
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -50,7 +50,7 @@ do {									\
>  		     "\t.org 2b+%c3\n"					\
>  		     ".popsection\n"					\
>  		     extra						\
> -		     : : "i" (__FILE__), "i" (__LINE__),		\
> +		     : : "i" (cond_str __FILE__), "i" (__LINE__),		\
>  			 "i" (flags),					\
>  			 "i" (sizeof(struct bug_entry)));		\
>  } while (0)

Sneaky :-) Do we want to touch up all the other archs? I mean, you
already touched them anyway earlier in the series in order to push this
argument through.

