Return-Path: <linux-kernel+bounces-185649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5588CB866
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4AD1C20C29
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537FE1C01;
	Wed, 22 May 2024 01:17:42 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47B4C6D
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716340661; cv=none; b=KhVRymlNB4VImUuWjmHk4T6g7z3OptSHsOGph/YB7Mid8b4oJLYFrSXKvhgr5vceJu9lc3T4QUYGgyEk1T/QrH/8P/dMl7ubjng71YKpa4vFWspGH+Tx4/xZCYbbGQkH24/jDbawUXzSaz/9h2FlTDyPS4xCHFYvsVgHiz0jThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716340661; c=relaxed/simple;
	bh=uRpBN6UVpNLAoxjshnQFTBd8cdW3OrJlZ0XpdiT/xgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9ViHlOSjAkoINXAP+Q2qhLjOFKZ1VMMOlixjk6R/6il26+bcRIjBPg7rr0gb+gyOo0Kxx+Yotiz+gQXIfNIdiDezRmF0LMrrWMjYrd3iWYm1bSk0HnKh/sE9B02CXN4cN/SgoDjr3ARRLEEnYUnhXineioFX8Oj5n5l/YKLcwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4affeacaff9so95075e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716340659; x=1716945459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uULwFZNVMvuZLMIcl/Jj9q31bH6KvSTXLcBzFppjdEQ=;
        b=tUwB1thhVT5/qsUQStnBNm9pxxoRkUdJ8/Tx1kJwpsNF0L4ZrDMzWws83F/Ih/WeHU
         xvDGMbpqPY9DTaKiatYt2wDaZxgRuaVv/Zj9ty8f9zOAmO5MDqUfff03As2N3TAQsII3
         lgBXG8EeMPqGC93qAbEYHlXXq9wvSZIOJQYEmgek+Uc3UfP5FdpqQaxFS6YhoqZxRVrh
         6z7bdhMzDx0Y5Z39r35dZi4PDw4xO+gV5lbzbLHXeyGVSne12Veulj+NxNi9/qY0cKbH
         KJpWyEj0sHnUufcAmIqtOnsVtATWuXsorjYYwJpBmWeRwHgslybpP/42H4HlANFIXfHA
         1CtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy/NLnoBQj/r6XLDzuk21YMvb3F9BRcfEB2xAzv5jc1E5GUhlsEvjDuP0eZ3nA6lK34WzGi1U+1KUnxAD/HtRth0kBsr/53IJ+LSOi
X-Gm-Message-State: AOJu0YyEhTfEK3tRvkWr0vv08n1OE8Y/g6LZoMPNq3pv9D+FGQK4soWA
	9E0H5TgodtH7UdGpM84r00/pbV+a2/JqlFdCnMn3qbPLsUfi/uL/
X-Google-Smtp-Source: AGHT+IHhSdROKgvMV8hFVSNBhuhEqQ6/xSpoi2IcBAFa+l3fdjSN+49znDGLKI2DlOgM2BkACSghJw==
X-Received: by 2002:a05:6122:368b:b0:4df:2b08:f217 with SMTP id 71dfb90a1353d-4e218510d67mr540985e0c.6.1716340658805;
        Tue, 21 May 2024 18:17:38 -0700 (PDT)
Received: from snowbird ([165.225.8.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab840e24eesm266616d6.135.2024.05.21.18.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 18:17:38 -0700 (PDT)
Date: Tue, 21 May 2024 18:17:36 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: tj@kernel.org, hughd@google.com, akpm@linux-foundation.org,
	vbabka@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] percpu_counter: add a cmpxchg-based _add_batch variant
Message-ID: <Zk1HsDYKwxpzeBjq@snowbird>
References: <20240521233100.358002-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521233100.358002-1-mjguzik@gmail.com>

Hi Mateusz,

On Wed, May 22, 2024 at 01:31:00AM +0200, Mateusz Guzik wrote:
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

This is cool!

> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> 
> v3:
> - add a missing word to the new comment
> 
> v2:
> - dodge preemption
> - use this_cpu_try_cmpxchg
> - keep the old variant depending on CONFIG_HAVE_CMPXCHG_LOCAL
> 
>  lib/percpu_counter.c | 44 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index 44dd133594d4..c3140276bb36 100644
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

Should this_cpu_read() be inside the do {} while in case the extreme
case that we get preempted after the read and before the cmpxchg AND
count + amount < batch on both the previous and next cpu?

> +	do {
> +		if (unlikely(abs(count + amount)) >= batch) {
> +			raw_spin_lock_irqsave(&fbc->lock, flags);
> +			/*
> +			 * Note: by now we might have migrated to another CPU
> +			 * or the value might have changed.
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
> -- 
> 2.39.2
> 

Thanks,
Dennis

