Return-Path: <linux-kernel+bounces-184014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB468CA16B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72C62B2264E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99F9138487;
	Mon, 20 May 2024 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MQWERGqP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KniWNG/8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MQWERGqP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KniWNG/8"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E90A2D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226213; cv=none; b=JE6zpMAwjNyfjQ51bdl7T7fgEPQ8foMjheG2lYYbaBjMYzJ4toab/+zGGX6PsKBpJbWCXWX58jjRowNxZNX9nH1B7V/LGzhHjOCaUUD+N37CmsW4xJ25PUTEsn9LWinxLdkGXqaNK7XHSQlrLHbrGJm+lrBO5Dqql4GJ2FWpvRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226213; c=relaxed/simple;
	bh=cBsM2N1jHlOPN0IreD5rHEkojD3zYmil1uPSW0Oyi6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvfsSfHYXskNro8H8oa9rViOE/Kou7gDuFj9x+pe3JvF5c9cN+ZZ4f59p/HNPIBz4VtvMIEukHa3f1Pl1YRzFDOXz+iiw6AYlpqEOsY4E6PF+Cb7afExxjrM8Y78oEiJQ+aUPdMXcygWUap1INDLTrm1pTxRSDUiBXGjHcMPstw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MQWERGqP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KniWNG/8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MQWERGqP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KniWNG/8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F363228C0;
	Mon, 20 May 2024 17:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716226209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MbT9vfV4fhIRSbiw0ZC6R173lRwaCUu2Hmcj1y018H8=;
	b=MQWERGqPK5msWZ+oGvqKi7Y0ImpsrNk+fbWyRF7r265R5BSNwlTWIB9ypDAUu+IWFo7NQe
	8FyW+gWJC9iNBAxldDk9UVOmgp27E5dNYEke+/eskd7XI+Gy1TwVdtdKgRSVSA0J30A49o
	V76XSKKXUsZsUxMio2cS8tWGVZs3BNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716226209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MbT9vfV4fhIRSbiw0ZC6R173lRwaCUu2Hmcj1y018H8=;
	b=KniWNG/8jmqGj4Bb0B3h2Zw9b36h7Cxqp0WiyblPYFR7LaLhpYvbdrZeXnoHWVkExM7K+i
	z2qn/R2Q4CESHpCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MQWERGqP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="KniWNG/8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716226209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MbT9vfV4fhIRSbiw0ZC6R173lRwaCUu2Hmcj1y018H8=;
	b=MQWERGqPK5msWZ+oGvqKi7Y0ImpsrNk+fbWyRF7r265R5BSNwlTWIB9ypDAUu+IWFo7NQe
	8FyW+gWJC9iNBAxldDk9UVOmgp27E5dNYEke+/eskd7XI+Gy1TwVdtdKgRSVSA0J30A49o
	V76XSKKXUsZsUxMio2cS8tWGVZs3BNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716226209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MbT9vfV4fhIRSbiw0ZC6R173lRwaCUu2Hmcj1y018H8=;
	b=KniWNG/8jmqGj4Bb0B3h2Zw9b36h7Cxqp0WiyblPYFR7LaLhpYvbdrZeXnoHWVkExM7K+i
	z2qn/R2Q4CESHpCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47CCB13A6B;
	Mon, 20 May 2024 17:30:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J+vsEKGIS2a/bQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 20 May 2024 17:30:09 +0000
Message-ID: <ca41164e-b895-4a89-bd4e-4786bf25cf8e@suse.cz>
Date: Mon, 20 May 2024 19:30:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] percpu_counter: add a cmpxchg-based _add_batch variant
Content-Language: en-US
To: Mateusz Guzik <mjguzik@gmail.com>, dennis@kernel.org
Cc: tj@kernel.org, hughd@google.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240520071407.201618-1-mjguzik@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240520071407.201618-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5F363228C0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.50

On 5/20/24 9:14 AM, Mateusz Guzik wrote:
> This was "percpu_counter: reimplement _add_batch with __this_cpu_cmpxchg".
> 
> I chatted with vbabka a little bit and he pointed me at mod_zone_state,
> which does the same thing I needed except dodges preemption -- turns out
> cmpxchg with a gs-prefixed argument is safe here.
> 
> ================ cut here ================
> 
> Interrupt disable/enable trips are quite expensive on x86-64 compared to
> a mere cmpxchg (note: no lock prefix!) and percpu counters are used
> quite often.
> 
> With this change I get a bump of 1% ops/s for negative path lookups,
> plugged into will-it-scale:
> 
> void testcase(unsigned long long *iterations, unsigned long nr)
> {
>         while (1) {
>                 int fd = open("/tmp/nonexistent", O_RDONLY);
>                 assert(fd == -1);
> 
>                 (*iterations)++;
>         }
> }
> 
> The win would be higher if it was not for other slowdowns, but one has
> to start somewhere.
> 
> v2:
> - dodge preemption
> - use this_cpu_try_cmpxchg
> - keep the old variant depending on CONFIG_HAVE_CMPXCHG_LOCAL
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

I tried a stupid microbenchmark just doing percpu_counter_inc() in a loop
and this cut the time by almost 50%.

As we discussed, should be also possible to make the fastpath inlined as the
next step, to avoid the function calls that are stupid expensive with cpu
mitigations.

> ---
>  lib/percpu_counter.c | 44 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index 44dd133594d4..80ec2ffc981a 100644
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -73,17 +73,50 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
>  EXPORT_SYMBOL(percpu_counter_set);
>  
>  /*
> - * local_irq_save() is needed to make the function irq safe:
> - * - The slow path would be ok as protected by an irq-safe spinlock.
> - * - this_cpu_add would be ok as it is irq-safe by definition.
> - * But:
> - * The decision slow path/fast path and the actual update must be atomic, too.
> + * Add to a counter while respecting batch size.
> + *
> + * There are 2 implementations, both dealing with the following problem:
> + *
> + * The decision slow path/fast path and the actual update must be atomic.
>   * Otherwise a call in process context could check the current values and
>   * decide that the fast path can be used. If now an interrupt occurs before
>   * the this_cpu_add(), and the interrupt updates this_cpu(*fbc->counters),
>   * then the this_cpu_add() that is executed after the interrupt has completed
>   * can produce values larger than "batch" or even overflows.
>   */
> +#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
> +/*
> + * Safety against interrupts is achieved in 2 ways:
> + * 1. the fast path uses local cmpxchg (note: no lock prefix)
> + * 2. the slow path operates with interrupts disabled
> + */
> +void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
> +{
> +	s64 count;
> +	unsigned long flags;
> +
> +	count = this_cpu_read(*fbc->counters);
> +	do {
> +		if (unlikely(abs(count + amount)) >= batch) {
> +			raw_spin_lock_irqsave(&fbc->lock, flags);
> +			/*
> +			 * Note: by now might have migrated to another CPU or
> +			 * the value might have changed.
> +			 */
> +			count = __this_cpu_read(*fbc->counters);
> +			fbc->count += count + amount;
> +			__this_cpu_sub(*fbc->counters, count);
> +			raw_spin_unlock_irqrestore(&fbc->lock, flags);
> +			return;
> +		}
> +	} while (!this_cpu_try_cmpxchg(*fbc->counters, &count, count + amount));
> +}
> +#else
> +/*
> + * local_irq_save() is used to make the function irq safe:
> + * - The slow path would be ok as protected by an irq-safe spinlock.
> + * - this_cpu_add would be ok as it is irq-safe by definition.
> + */
>  void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
>  {
>  	s64 count;
> @@ -101,6 +134,7 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
>  	}
>  	local_irq_restore(flags);
>  }
> +#endif
>  EXPORT_SYMBOL(percpu_counter_add_batch);
>  
>  /*


