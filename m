Return-Path: <linux-kernel+bounces-273720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29C3946CDF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 08:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222C01C212E7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 06:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F129C134A0;
	Sun,  4 Aug 2024 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mm6ufJox"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B8110A19
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 06:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722754569; cv=none; b=oSJjCxB99O9+1kIVfLWeYoZXffKGvUfPzDZdIRL/DeL2/Cj9H2QlAC/bNuyj/7QMDZXUoun64HWppTq2otr7wBXw8tHIF/jW3sBZRB2EB22FUcKF+mZwv9E/p431lnchndhsA3K41LRhzhdSDLhjf5xT4QdMswLC31JDQfhAw3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722754569; c=relaxed/simple;
	bh=XG2VaKIYLfvSAqXzNaHErTDxjLIBaSKRKBZ6u4cFzaQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i71i2cxn4AfL8xQb6T1NkkBolNepMidHOMjGH8lbtrKl7t0Dg4QCO6LTZCRjps5Iu9rPR/SJD04onk8+5Ve+tGJSBpxcYCXa53ZSD5KANn9wdO4mQbPuevPn9nLvwJSrMJWgXjd3OzUijXgz8crhbTBRWPIViq9qnbb7P7mhbKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mm6ufJox; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7093472356dso5651787a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 23:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722754566; x=1723359366; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SqaxZlgtJoYb0bs+SvkOFaofwuMyGM4QmSsTX2Hd1N0=;
        b=Mm6ufJoxbXaCRDWZvER9489SGEY+tgEeb1wK21p17iv8kpcn6EsPI6TXyZVMOI/t+u
         GI3IjvParoxli4+ob6fTgglmJCAGrpOt6FIGEU8A3M7m/SZ3wddHYMcebl1CrS5Lvp1U
         ysBCQnn1BZpvNjLPW8RKHfw6e1P5w70QkizjhZORnU/RGlXraY+0wuui9z6bWkIuRD/1
         D7c+BSxVDIbvLvdwO+JjPlXB6nNSvfOkS1jpE3kUYUQiY8zZdwRzTp0CjC8JMGkuEhp0
         fL+2tdawDz3R/lpg3u57crFPMisDPfIjKarfJTdASESMd9voFQwRrjv3mRZ4QXNFjlKi
         gzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722754566; x=1723359366;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqaxZlgtJoYb0bs+SvkOFaofwuMyGM4QmSsTX2Hd1N0=;
        b=TQVIaHmhYZiQ/4OHC61d/VdJafhzCnFS6gEucaQFT2vXaUHGdZdRCf+pp3SwFxHm/F
         1cKfuEHOReNOSbG50IAB7pemIlYmBxsVrnUO913aEYk1+CnUSUtXhbShaGtIY+FJi26E
         TBeVfZwGHR0UH9Eg4xz8I7/5j1S/n1pGn2owaoTACG8nIMm5FHois/qQGL9yFjyObsQi
         Zk23iWbCK7il1jEej1HiBbDyub/6iWruOZEoW4tQ1u3K2X9/1GcXfHGdPnJgTIfdZiuW
         17XVE12+70zMOPOC1PBDrj4v7zBParte7bj3lzvv/uoftoJUC2gbR7FN3wJQHus56/Mk
         ckvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBpnbRKhxRfqjv0K+Hst+eZ1WbajTr64BVF8Lcdr0e4Qld0gyyuJ9ETkgNa+wyzMudWGQzSnSddOSAxxRap40pz95lAP/mPpZtZrOM
X-Gm-Message-State: AOJu0YyS1MHaC2MScxVEb5FkCxqTAoADLMOI7Mq4l1L137ONvj+ng2tm
	7T1Zc9CRCEuPpsQOP64tswB7P2TFu2RNECpCg6jPCH7QaDI42P+V4xcNO8ABSYH419tew9eckC2
	ibQ==
X-Google-Smtp-Source: AGHT+IEt3PhlbkyOB9RpcniTETIy8QYNjVGaa7vEV0FVGxmmNgCHetEsf+xx9siB51kbRTujgPqcOg==
X-Received: by 2002:a05:6830:618b:b0:70a:988a:b5fd with SMTP id 46e09a7af769-70a988abd5cmr7893673a34.24.1722754566139;
        Sat, 03 Aug 2024 23:56:06 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d762052af1sm1319639eaf.28.2024.08.03.23.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 23:56:04 -0700 (PDT)
Date: Sat, 3 Aug 2024 23:55:51 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Yu Zhao <yuzhao@google.com>, Barry Song <21cnbao@gmail.com>, 
    Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v1 5/5] mm/swap: remove boilerplate
In-Reply-To: <20240711021317.596178-6-yuzhao@google.com>
Message-ID: <714e77d3-f629-bc06-4808-f7f33ac6872d@google.com>
References: <20240711021317.596178-1-yuzhao@google.com> <20240711021317.596178-6-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Jul 2024, Yu Zhao wrote:

> Remove boilerplate by using a macro to choose the corresponding lock
> and handler for each folio_batch in cpu_fbatches.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Andrew, please revert this "remove boilerplate" patch (and of course its
followup fix) from mm-unstable. From the title I presume it was intended
to make no functional change, but that's far from so.

Under tmpfs swapping load, on different runs I see various badnesses:
"Bad page" in __free_one_page(), Oops in __run_timer_base(),
WARNING at kernel/workqueue.c:790 in set_work_data(), PageBuddy BUG
at page-flags.h:1009 from __del_page_from_freelist(), something (I'd
given up taking better notes by this time) in __queue_work(), others.

All those were including the fix to Barry's report: without that fix,
the boot is drowned in warnings scrolling past too fast to be read.

(All the above were on the HP workstation, swapping to SSD; whereas on
this ThinkPad, swapping to NVMe, no problem seen at all - I mention the
swapping medium, but have no idea whether that's a relevant difference.
In each case, MGLRU compiled in but not enabled. THPs and 64kTHPs active.)

Sorry, but I've put no effort whatsoever into debugging this: "remove
boilerplate" didn't seem worth the effort, and my personal preference
is for readable boilerplate over hiding in a macro.  If you prefer the
macro, I expect Yu can soon come up with a fix (which I could test here):
but for now please revert "remove boilerplate", since its issues get in
the way of further mm testing.

Thanks,
Hugh

> ---
>  mm/swap.c | 107 +++++++++++++++++++-----------------------------------
>  1 file changed, 37 insertions(+), 70 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 4a66d2f87f26..342ff4e39ba4 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -220,16 +220,45 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
>  	folios_put(fbatch);
>  }
>  
> -static void folio_batch_add_and_move(struct folio_batch *fbatch,
> -		struct folio *folio, move_fn_t move_fn)
> +static void __folio_batch_add_and_move(struct folio_batch *fbatch,
> +		struct folio *folio, move_fn_t move_fn,
> +		bool on_lru, bool disable_irq)
>  {
> +	unsigned long flags;
> +
> +	folio_get(folio);
> +
> +	if (on_lru && !folio_test_clear_lru(folio)) {
> +		folio_put(folio);
> +		return;
> +	}
> +
>  	if (folio_batch_add(fbatch, folio) && !folio_test_large(folio) &&
>  	    !lru_cache_disabled())
>  		return;
>  
> +	if (disable_irq)
> +		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
> +	else
> +		local_lock(&cpu_fbatches.lock);
> +
>  	folio_batch_move_lru(fbatch, move_fn);
> +
> +	if (disable_irq)
> +		local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
> +	else
> +		local_unlock(&cpu_fbatches.lock);
>  }
>  
> +#define folio_batch_add_and_move(folio, op, on_lru)						\
> +	__folio_batch_add_and_move(								\
> +		this_cpu_ptr(&cpu_fbatches.op),							\
> +		folio,										\
> +		op,										\
> +		on_lru,										\
> +		offsetof(struct cpu_fbatches, op) > offsetof(struct cpu_fbatches, lock_irq)	\
> +	)
> +
>  static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)
>  {
>  	if (folio_test_unevictable(folio))
> @@ -250,23 +279,11 @@ static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)
>   */
>  void folio_rotate_reclaimable(struct folio *folio)
>  {
> -	struct folio_batch *fbatch;
> -	unsigned long flags;
> -
>  	if (folio_test_locked(folio) || folio_test_dirty(folio) ||
>  	    folio_test_unevictable(folio))
>  		return;
>  
> -	folio_get(folio);
> -	if (!folio_test_clear_lru(folio)) {
> -		folio_put(folio);
> -		return;
> -	}
> -
> -	local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
> -	fbatch = this_cpu_ptr(&cpu_fbatches.lru_move_tail);
> -	folio_batch_add_and_move(fbatch, folio, lru_move_tail);
> -	local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
> +	folio_batch_add_and_move(folio, lru_move_tail, true);
>  }
>  
>  void lru_note_cost(struct lruvec *lruvec, bool file,
> @@ -355,21 +372,10 @@ static void folio_activate_drain(int cpu)
>  
>  void folio_activate(struct folio *folio)
>  {
> -	struct folio_batch *fbatch;
> -
>  	if (folio_test_active(folio) || folio_test_unevictable(folio))
>  		return;
>  
> -	folio_get(folio);
> -	if (!folio_test_clear_lru(folio)) {
> -		folio_put(folio);
> -		return;
> -	}
> -
> -	local_lock(&cpu_fbatches.lock);
> -	fbatch = this_cpu_ptr(&cpu_fbatches.lru_activate);
> -	folio_batch_add_and_move(fbatch, folio, lru_activate);
> -	local_unlock(&cpu_fbatches.lock);
> +	folio_batch_add_and_move(folio, lru_activate, true);
>  }
>  
>  #else
> @@ -513,8 +519,6 @@ EXPORT_SYMBOL(folio_mark_accessed);
>   */
>  void folio_add_lru(struct folio *folio)
>  {
> -	struct folio_batch *fbatch;
> -
>  	VM_BUG_ON_FOLIO(folio_test_active(folio) &&
>  			folio_test_unevictable(folio), folio);
>  	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> @@ -524,11 +528,7 @@ void folio_add_lru(struct folio *folio)
>  	    lru_gen_in_fault() && !(current->flags & PF_MEMALLOC))
>  		folio_set_active(folio);
>  
> -	folio_get(folio);
> -	local_lock(&cpu_fbatches.lock);
> -	fbatch = this_cpu_ptr(&cpu_fbatches.lru_add);
> -	folio_batch_add_and_move(fbatch, folio, lru_add);
> -	local_unlock(&cpu_fbatches.lock);
> +	folio_batch_add_and_move(folio, lru_add, false);
>  }
>  EXPORT_SYMBOL(folio_add_lru);
>  
> @@ -702,22 +702,11 @@ void lru_add_drain_cpu(int cpu)
>   */
>  void deactivate_file_folio(struct folio *folio)
>  {
> -	struct folio_batch *fbatch;
> -
>  	/* Deactivating an unevictable folio will not accelerate reclaim */
>  	if (folio_test_unevictable(folio))
>  		return;
>  
> -	folio_get(folio);
> -	if (!folio_test_clear_lru(folio)) {
> -		folio_put(folio);
> -		return;
> -	}
> -
> -	local_lock(&cpu_fbatches.lock);
> -	fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate_file);
> -	folio_batch_add_and_move(fbatch, folio, lru_deactivate_file);
> -	local_unlock(&cpu_fbatches.lock);
> +	folio_batch_add_and_move(folio, lru_deactivate_file, true);
>  }
>  
>  /*
> @@ -730,21 +719,10 @@ void deactivate_file_folio(struct folio *folio)
>   */
>  void folio_deactivate(struct folio *folio)
>  {
> -	struct folio_batch *fbatch;
> -
>  	if (folio_test_unevictable(folio) || !(folio_test_active(folio) || lru_gen_enabled()))
>  		return;
>  
> -	folio_get(folio);
> -	if (!folio_test_clear_lru(folio)) {
> -		folio_put(folio);
> -		return;
> -	}
> -
> -	local_lock(&cpu_fbatches.lock);
> -	fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate);
> -	folio_batch_add_and_move(fbatch, folio, lru_deactivate);
> -	local_unlock(&cpu_fbatches.lock);
> +	folio_batch_add_and_move(folio, lru_deactivate, true);
>  }
>  
>  /**
> @@ -756,22 +734,11 @@ void folio_deactivate(struct folio *folio)
>   */
>  void folio_mark_lazyfree(struct folio *folio)
>  {
> -	struct folio_batch *fbatch;
> -
>  	if (!folio_test_anon(folio) || !folio_test_swapbacked(folio) ||
>  	    folio_test_swapcache(folio) || folio_test_unevictable(folio))
>  		return;
>  
> -	folio_get(folio);
> -	if (!folio_test_clear_lru(folio)) {
> -		folio_put(folio);
> -		return;
> -	}
> -
> -	local_lock(&cpu_fbatches.lock);
> -	fbatch = this_cpu_ptr(&cpu_fbatches.lru_lazyfree);
> -	folio_batch_add_and_move(fbatch, folio, lru_lazyfree);
> -	local_unlock(&cpu_fbatches.lock);
> +	folio_batch_add_and_move(folio, lru_lazyfree, true);
>  }
>  
>  void lru_add_drain(void)
> -- 
> 2.45.2.803.g4e1b14247a-goog

