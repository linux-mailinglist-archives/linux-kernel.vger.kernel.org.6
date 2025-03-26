Return-Path: <linux-kernel+bounces-577178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7523CA71996
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD50016CD95
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F0E1F3BB2;
	Wed, 26 Mar 2025 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ijULDyRK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JGYCJ44/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ijULDyRK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JGYCJ44/"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF611E502
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000891; cv=none; b=NJPAQcdTsMC/EFewEMqJL7RG8IRKAHifjVYLOfwXubr0oIAuNr9a2o8XO350XA+DfoiEU5MQvDrdJFqmuhUqMFAUNI9daUsR7KyVuF2wUHug6CcNcnfHt5qnYFjABGbfgSr5wZrciHK2RUj6khohrgDwlvrP77RqraRM2UjjHhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000891; c=relaxed/simple;
	bh=rGHzZernclzfEZzSSzphkFFLUtZYXt411TaLEpWyxhA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W6bjsVioBDEEBhXTdFRhixYpb+FwqrLtTqSHjkQfaEJQ5HJvL65hCgaQKow8Xrg5TT1FTKT7+pYgfmcJCHI546qSdFE0p7CjQpaB4E5TNKRCmbUSbvkrUqSI0vlD3D6SZzC19Wtw67/ZN6SOtHmpFl9Pvx1DqP938eq2JTIYimE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ijULDyRK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JGYCJ44/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ijULDyRK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JGYCJ44/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27A5F21175;
	Wed, 26 Mar 2025 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743000888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nj7qnn1zPrsquxyNyEVdjhlDD4L+SsWm9vlyd/xPZAQ=;
	b=ijULDyRKEnIecmUhlsdbCqOpP/QmoFHZ40deQxGm408qOnb2vF6/kCOOB3RProH9XueokH
	A8Fm7juu6Oxqtb1QeyfzuY3Iy+9Illivtu44d6VJeT2TjOa1KsDQf+QDC/dhP7Jn5w5c6I
	oQDtuhLyqcF2Fc7X7tTJ/LGYbg3qiZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743000888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nj7qnn1zPrsquxyNyEVdjhlDD4L+SsWm9vlyd/xPZAQ=;
	b=JGYCJ44/8ga5JDLLmdLD2tV8sMEU4sQp1+PPOs2EiUzhiZNnNInSVojPxx2TmWw9wtWTz3
	w6sqYNZXKwELI/DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743000888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nj7qnn1zPrsquxyNyEVdjhlDD4L+SsWm9vlyd/xPZAQ=;
	b=ijULDyRKEnIecmUhlsdbCqOpP/QmoFHZ40deQxGm408qOnb2vF6/kCOOB3RProH9XueokH
	A8Fm7juu6Oxqtb1QeyfzuY3Iy+9Illivtu44d6VJeT2TjOa1KsDQf+QDC/dhP7Jn5w5c6I
	oQDtuhLyqcF2Fc7X7tTJ/LGYbg3qiZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743000888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nj7qnn1zPrsquxyNyEVdjhlDD4L+SsWm9vlyd/xPZAQ=;
	b=JGYCJ44/8ga5JDLLmdLD2tV8sMEU4sQp1+PPOs2EiUzhiZNnNInSVojPxx2TmWw9wtWTz3
	w6sqYNZXKwELI/DQ==
Date: Wed, 26 Mar 2025 15:54:48 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Peter Zijlstra <peterz@infradead.org>
cc: Josh Poimboeuf <jpoimboe@redhat.com>, mingo@kernel.com, 
    juri.lelli@redhat.com, vincent.guittot@linaro.org, 
    dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
    mgorman@suse.de, vschneid@redhat.com, jpoimboe@kernel.org, 
    jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com, 
    linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
    Thomas Gleixner <tglx@linutronix.de>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC][PATCH] sched,livepatch: Untangle cond_resched() and
 live-patching
In-Reply-To: <20250324134909.GA14718@noisy.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.2503261552360.4152@pobox.suse.cz>
References: <20250324134909.GA14718@noisy.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

>  void __klp_sched_try_switch(void)
>  {
> -	if (likely(!klp_patch_pending(current)))
> -		return;
> -
>  	/*
>  	 * This function is called from cond_resched() which is called in many
>  	 * places throughout the kernel.  Using the klp_mutex here might
> @@ -377,14 +365,14 @@ void __klp_sched_try_switch(void)
>  	 * klp_try_switch_task().  Thanks to task_call_func() they won't be
>  	 * able to switch this task while it's running.
>  	 */
> -	preempt_disable();
> +	lockdep_assert_preemption_disabled();
>  
>  	/*
>  	 * Make sure current didn't get patched between the above check and
>  	 * preempt_disable().
>  	 */
>  	if (unlikely(!klp_patch_pending(current)))
> -		goto out;
> +		return;

It does not look correct. We just make sure that 
klp_patch_pending(current) did not change here. It would be highly 
unlikely. However, we should keep the likely way out (the first removed 
condition above). So let's also s/unlikely/likely/ here.

And the comments in the function should be updated as well.

Miroslav

