Return-Path: <linux-kernel+bounces-193080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA658D2699
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1817A289E25
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5611C17A930;
	Tue, 28 May 2024 20:57:04 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B63D97A
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929823; cv=none; b=D/KwrqhiVLwVRWP5UmZ9qfUEf01zZYYmwoKx+QjQDSMuGoYpf/+G2uwX2CcJ2nj44PQTC/qvpYyHvRckb6Q84ggo9UUZAeZn1viaMnIqPn1mKfXJNhyk2TYujz4DJ7CfGM8W55hOvKyMXfSH3f2xF35hstr0138GvfY1WUmo9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929823; c=relaxed/simple;
	bh=oqkZbOS9aShq4ws+YJiDWlmR9oBcDuCfEPDgZNLUP8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNAqKy8xtEKO42b0hda8MDtfLjywfwf7oRyfFKhZaDpxxQ2wmG4Mc9TKLujy2N2JZ8yOUSV1PNK2FEH02a2/ibnoEGVdf4AfKbF9wCKm74M/Qa8bo8HYDoaUi7iqvDv8ZocLmXbodpoPXYr9IsiwJR9h8gYFPEEuBTZNzso6n/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2bf5ee192b1so171568a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929822; x=1717534622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07IIU5/iLq0mpEKlNBbglcpKnHcrqOpairoOpNeunHM=;
        b=BzIQeswrIFIdx5buMoAEeZJqyk7sgiFQZKUUEYaCGQ1NCyj1lgjVqJKkps6/VDCgjJ
         +eiWEHZDx1FOLarDa22C0DhcT8+FUjArMEJZ3bO0yxvs8wCvGcrOSHVu65CQ0A+8PoOJ
         ERXVOUdU4s0LyB7vBaY2243SO/BG4xPIbMzLtbjN2Ks04Lsrq0MOC8pHwcrlR2W1yIzY
         npXrnR7CE9Zs7ZP66EjXKstZdGbrQfkoyA6vzCGNgPo1DJWfiTYOhmUJxJeJGmXDDD8f
         ASpDjZra5hba8pfDcGEW5YhYQGsUaKV1BKDIe5QLk5WJ3Nu2LFjpuTxBHZLWuSF/1llx
         jIYw==
X-Forwarded-Encrypted: i=1; AJvYcCWdIWB7CHIMFdUU4LU7xmlwxo/w/0r0FwH8cOQGn9Q4EqlEMmhgzw3EFUlpHalwEBu0ePD+khqsRyTlCeL5uiZfUxikOwYzAAU4szYV
X-Gm-Message-State: AOJu0YwX16Ig083X4LmbaBa9T9B+iDmmyM/mpJFz4hjgBCUNHy3fqsNq
	WbDtQDK++Lj/VrhAHfllW4rSdoAO2XN8wOmfBBpCd3ikVmbZA0we
X-Google-Smtp-Source: AGHT+IGtnpj/yAqJkRmgY6bYx6gFBwzXCLnDfWllgsMjTowHKCPmryfeOYsafjqkBKAXhIDB2PAtQg==
X-Received: by 2002:a17:90a:5d91:b0:2bd:eb72:9fd4 with SMTP id 98e67ed59e1d1-2c02ec62d38mr257568a91.23.1716929821575;
        Tue, 28 May 2024 13:57:01 -0700 (PDT)
Received: from snowbird ([136.25.84.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f61272fsm8249740a91.27.2024.05.28.13.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:57:01 -0700 (PDT)
Date: Tue, 28 May 2024 13:56:58 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: tj@kernel.org, hughd@google.com, akpm@linux-foundation.org,
	vbabka@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4] percpu_counter: add a cmpxchg-based _add_batch variant
Message-ID: <ZlZFGmBiBE1VGQIt@snowbird>
References: <20240528204257.434817-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528204257.434817-1-mjguzik@gmail.com>

On Tue, May 28, 2024 at 10:42:57PM +0200, Mateusz Guzik wrote:
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
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> 
> v4:
> - fix a misplaced paren in unlikely(), reported by lkp:
> https://lore.kernel.org/oe-lkp/ZlZAbkjOylfZC5Os@snowbird/T/#t
> 
> v3:
> - add a missing word to the new comment
> 
> v2:
> - dodge preemption
> - use this_cpu_try_cmpxchg
> - keep the old variant depending on CONFIG_HAVE_CMPXCHG_LOCAL
> 
> 
>  lib/percpu_counter.c | 44 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index 44dd133594d4..51bc5246986d 100644
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
> +		if (unlikely(abs(count + amount) >= batch)) {
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

Andrew you picked up the __this_cpu_try_cmpxchg() patches. At this point
you might as well pick up this too. The cpumask clean ups are likely
going to give me trouble later this week when I rebase so I'll probably
have to base my percpuh hotplug branch on your mm-unstable now.

Acked-by: Dennis Zhou <dennis@kernel.org>

Feel free to toss my ack on the __this_cpu_try_cmpxchg() too.

Thanks,
Dennis

