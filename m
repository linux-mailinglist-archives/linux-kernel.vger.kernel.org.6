Return-Path: <linux-kernel+bounces-258960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25B3938F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2169A1C20F98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF41D16D339;
	Mon, 22 Jul 2024 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLmql/Xy"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04209322E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652024; cv=none; b=Sh4aVwg7LV/LuhbaGAPHq5WvgCFRNTs4q9cQzda0MjlTOgebv4VyOe/YPbwchkgUq7ZfRFyr79K1guym0Ou5ftuHNNl6jwllFKa6+pO3XHvUsrNZabD6Sa98O5GrESq0hZs8ejv5d2t1fhXqMpM7eVI6mhjM2drw/TIik9V1zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652024; c=relaxed/simple;
	bh=FWOD5C4WfvCR20gT644XfROh/DPXAXIy7i6JFqIY2oE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/mhwjFF+LRdeV0xhD3riyyYbc4duIwF0zelCAD0EtQ9Meb3xIUD5GL9cpFVyhB7/Be71e8BwOwWogseXFgLWgXls46pg3PH2np/IVxRQpn9rkbr/wgm0A2+vtRCA4/ZxuKHZ9kCKWh9jjpY+yONM2HFYLDzTl0bm8YoOVJwmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLmql/Xy; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f04c1e58eso994180e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721652021; x=1722256821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P/K2L+QmvMsHM3dk3lxU0tm1Ex9aXPZqsjkrwLpqNMg=;
        b=KLmql/XyRLRSzZ1nzihBJzlJWCcLvHYCrpcKB7Aob+lnxZ1EmEEWykjJLAbajxZvsl
         /vV0YjIlSUwnnYFyg/+yOqI9/T4YmO82wGNj0o0kq6kCjZZs2y98NURsKZ2B/CMGGrs6
         x7FWyHUHpWVlCalFHr494sHSXxvJAM2zv77MNNzhXdKKsZ/27XvUYP6LVikX9RAr4V1a
         D8WkIqkGjQB2lUjkXTnVwMtb3PCzEEsf4NOS7LB/EJ/sNSbZt8RG/ZTTvUe5CEY0+3pn
         gQH7GYvycoChu9LwK3YrxSmKoUUd/82Lw1ztIZ7GBqVQCe6y94ozzgOuUPrq5RIXmmFi
         OQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721652021; x=1722256821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/K2L+QmvMsHM3dk3lxU0tm1Ex9aXPZqsjkrwLpqNMg=;
        b=furxQaoMo4w8zaIIZ+DvTPruZxHto1DBECI+hvde64t8ZWLjvvm3aeoOKJl410LVK3
         RtjpqZLGfCv47X/N/iQbu2sTJ7ly3NYfNmDJvmlCuvXgALkkrrQC1foPEb4oaEKWp0HW
         lElK1LR8OguVKzbCVe+TEKNzdmYf7uouss8EblItvxHytwJwYA5/DJvBaaPiKM+RY6gL
         n27ZtJqU9bwQu1LY//2b8TV53ihnJQ2qUKl9c7rqdhDsk2eI/GmTvXFMFyMbUlizgPtQ
         KNdnt48XqulUXbd9sykSCDNO+Y2x/8Zhv66AZGrDxHh720mTLQvHX2Tbsk6mJMmIQ+mR
         jB5g==
X-Forwarded-Encrypted: i=1; AJvYcCVuMUedNUTaraOFzeHCvD6xbWdPknALGoUU3cdCF3XizUVf2zzc18ws238fvdilYR1bTo6Dy9WdQ2y8hUwcB8vjKhJPn/koE+AwOBoL
X-Gm-Message-State: AOJu0Ywf7guUKG8nEzPCmeekohT/JaBNtGIl9++l4sazA+aha5D2umon
	Y2HD+pXVAt9iHIwJUioG4MWCY+luQdIzY7Qw5uJu8CXKhN6iJs8J
X-Google-Smtp-Source: AGHT+IEKbnz+YGVqQX//G5lVKXtXLjexoIlhLIMvXmJMiNPw2OIt6hOf41hgO32c6BXv9pWNfjjd/A==
X-Received: by 2002:a05:6512:a86:b0:52e:d0f8:2d43 with SMTP id 2adb3069b0e04-52efb53bae5mr4885953e87.17.1721652020702;
        Mon, 22 Jul 2024 05:40:20 -0700 (PDT)
Received: from pc636 (host-90-233-197-231.mobileonline.telia.com. [90.233.197.231])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52efb97bbd4sm872658e87.60.2024.07.22.05.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 05:40:20 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 22 Jul 2024 14:40:17 +0200
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: urezki@gmail.com, ahuang12@lenovo.com, akpm@linux-foundation.org,
	hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	peterz@infradead.org, sunjw10@lenovo.com
Subject: Re: [PATCH 1/1] mm/vmalloc: Add preempt point in purge_vmap_node()
 when enabling kasan
Message-ID: <Zp5TMcd-8hBLYBZ7@pc636>
References: <ZppQo7Biyg5Yc0Ai@pc636>
 <20240722115054.6295-1-ahuang12@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722115054.6295-1-ahuang12@lenovo.com>

On Mon, Jul 22, 2024 at 07:50:54PM +0800, Adrian Huang wrote:
> > I tried to simulate the reported splat and i can reproduce it with KASAN
> > enabled. I use qemu on my 64-core system, it allows me to specify 255
> > cores while running VM. The kernel is 6.10.0-rc5.
> >
> > The kernel should be built with CONFIG_KASAN=y and CONFIG_KASAN_VMALLOC=y
> >
> > The "soft lockup" can be triggered when the kernel is compiled within a
> > VM using 256 jobs and preemption is disabled:
> >
> > echo none > /sys/kernel/debug/sched/preempt
> > make -C coding/linux.git/ -j256 bzImage
> >
> > <snip>
> > watchdog: BUG: soft lockup - CPU#28 stuck for 22s! [kworker/28:1:1760]
> > CPU: 28 PID: 1760 Comm: kworker/28:1 Kdump: loaded Not tainted 6.10.0-rc5 #95
> > Workqueue: events drain_vmap_area_work
> > RIP: 0010:smp_call_function_many_cond+0x1d8/0xbb0
> > ...
> > <snip>
> 
> Great to hear you're able to reproduce the issue.
> 
> I keep debugging, and the original patch (https://lore.kernel.org/all/ZogS_04dP5LlRlXN@pc636/T/) shows purge_vmap_node() iteratively releases kasan vmalloc
> allocations and flushes tlb for each vmap_area. There are 2805
> flush_tlb_kernel_range() calls in ftrace log.
>   * One is called in __purge_vmap_area_lazy().
>   * Others are called in kasan_release_vmalloc(): Called by purge_vmap_node().
>     - [Rough calculation] Each flush_tlb_kernel_range() runs about 7.5ms.
>       -- 2804 * 7.5ms = 21.03 seconds (That's why a soft lock is trigger)
> 
> If we combine all tlb flush operations into one operation in the call path
> 'purge_vmap_node()->kasan_release_vmalloc()', the running time of
> drain_vmap_area_work() can be saved greately. The idea is from the
> flush_tlb_kernel_range() call in __purge_vmap_area_lazy().
> And, the soft lockup won't not be triggered. Please refer to the following patch.
> Here is the test result based on 6.10:
> 
> [6.10 wo/ the patch below]
>   1. ftrace latency profiling (record a trace if the latency > 20s): Commands
>      echo 20000000 > /sys/kernel/debug/tracing/tracing_thresh
>      echo drain_vmap_area_work > /sys/kernel/debug/tracing/set_graph_function
>      echo function_graph > /sys/kernel/debug/tracing/current_tracer
>      echo 1 > /sys/kernel/debug/tracing/tracing_on
> 
>   2. Run `make -j $(nproc)` to compile the kernel source
> 
>   3. Once the soft lockup is reproduced, check the ftace:
>      cat /sys/kernel/debug/tracing/trace
>         # tracer: function_graph
>         #
>         # CPU  DURATION                  FUNCTION CALLS
>         # |     |   |                     |   |   |   |
>           76) $ 50412985 us |    } /* __purge_vmap_area_lazy */
>           76) $ 50412997 us |  } /* drain_vmap_area_work */
>           76) $ 29165911 us |    } /* __purge_vmap_area_lazy */
>           76) $ 29165926 us |  } /* drain_vmap_area_work */
>           91) $ 53629423 us |    } /* __purge_vmap_area_lazy */
>           91) $ 53629434 us |  } /* drain_vmap_area_work */
>           91) $ 28121014 us |    } /* __purge_vmap_area_lazy */
>           91) $ 28121026 us |  } /* drain_vmap_area_work */
> 
> 
> [6.10 w/ the patch below]
>   1. Repeat step 1-2 in "[6.10 wo/ the patch below]"
> 
>   2. The soft lockup is not triggered and the ftrace log is empty.
>      cat /sys/kernel/debug/tracing/trace
>      # tracer: function_graph
>      #
>      # CPU  DURATION                  FUNCTION CALLS
>      # |     |   |                     |   |   |   |
> 
> 
>   3. Setting 'tracing_thresh' to 10/5 seconds does not get any ftrace log.
> 
>   4. Setting 'tracing_thresh' to 1 second gets ftrace log.
>       cat /sys/kernel/tracing/trace
>       # tracer: function_graph
>       #
>       # CPU  DURATION                  FUNCTION CALLS
>       # |     |   |                     |   |   |   |
>         51) $ 1019695 us  |    } /* __purge_vmap_area_lazy */
>         51) $ 1019703 us  |  } /* drain_vmap_area_work */
>        198) $ 1018707 us  |    } /* __purge_vmap_area_lazy */
>        198) $ 1018718 us  |  } /* drain_vmap_area_work */
> 
>   5. Run the following test_vmalloc command without any issues
>      modprobe test_vmalloc nr_threads=$(nproc) run_test_mask=0x1 nr_pages=4
> 
> Could you please test this patch in your VM environment? 
> 
> ---
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 70d6a8f6e25d..ddbf42a1a7b7 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -55,6 +55,9 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
>  int kasan_populate_early_shadow(const void *shadow_start,
>  				const void *shadow_end);
>  
> +#define KASAN_VMALLOC_PAGE_RANGE 0x1 /* Apply existing page range */
> +#define KASAN_VMALLOC_TLB_FLUSH  0x2 /* TLB flush */
> +
>  #ifndef kasan_mem_to_shadow
>  static inline void *kasan_mem_to_shadow(const void *addr)
>  {
> @@ -511,7 +514,8 @@ void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
>  int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
>  void kasan_release_vmalloc(unsigned long start, unsigned long end,
>  			   unsigned long free_region_start,
> -			   unsigned long free_region_end);
> +			   unsigned long free_region_end,
> +			   unsigned long flags);
>  
>  #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>  
> @@ -526,7 +530,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
>  static inline void kasan_release_vmalloc(unsigned long start,
>  					 unsigned long end,
>  					 unsigned long free_region_start,
> -					 unsigned long free_region_end) { }
> +					 unsigned long free_region_end,
> +					 unsigned long flags) { }
>  
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>  
> @@ -561,7 +566,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
>  static inline void kasan_release_vmalloc(unsigned long start,
>  					 unsigned long end,
>  					 unsigned long free_region_start,
> -					 unsigned long free_region_end) { }
> +					 unsigned long free_region_end,
> +					 unsigned long flags) { }
>  
>  static inline void *kasan_unpoison_vmalloc(const void *start,
>  					   unsigned long size,
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index d6210ca48dda..88d1c9dcb507 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -489,7 +489,8 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>   */
>  void kasan_release_vmalloc(unsigned long start, unsigned long end,
>  			   unsigned long free_region_start,
> -			   unsigned long free_region_end)
> +			   unsigned long free_region_end,
> +			   unsigned long flags)
>  {
>  	void *shadow_start, *shadow_end;
>  	unsigned long region_start, region_end;
> @@ -522,12 +523,17 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
>  			__memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
>  			return;
>  		}
> -		apply_to_existing_page_range(&init_mm,
> +
> +
> +		if (flags & KASAN_VMALLOC_PAGE_RANGE)
> +			apply_to_existing_page_range(&init_mm,
>  					     (unsigned long)shadow_start,
>  					     size, kasan_depopulate_vmalloc_pte,
>  					     NULL);
> -		flush_tlb_kernel_range((unsigned long)shadow_start,
> -				       (unsigned long)shadow_end);
> +
> +		if (flags & KASAN_VMALLOC_TLB_FLUSH)
> +			flush_tlb_kernel_range((unsigned long)shadow_start,
> +					       (unsigned long)shadow_end);
>  	}
>  }
>  
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e34ea860153f..d66e09135876 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2193,8 +2193,15 @@ static void purge_vmap_node(struct work_struct *work)
>  	struct vmap_area *va, *n_va;
>  	LIST_HEAD(local_list);
>  
> +	unsigned long start;
> +	unsigned long end;
> +
>  	vn->nr_purged = 0;
>  
> +	start = list_first_entry(&vn->purge_list, struct vmap_area, list)->va_start;
> +
> +	end = list_last_entry(&vn->purge_list, struct vmap_area, list)->va_end;
> +
>  	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
>  		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
>  		unsigned long orig_start = va->va_start;
> @@ -2205,7 +2212,8 @@ static void purge_vmap_node(struct work_struct *work)
>  
>  		if (is_vmalloc_or_module_addr((void *)orig_start))
>  			kasan_release_vmalloc(orig_start, orig_end,
> -					      va->va_start, va->va_end);
> +					      va->va_start, va->va_end,
> +					      KASAN_VMALLOC_PAGE_RANGE);
>  
>  		atomic_long_sub(nr, &vmap_lazy_nr);
>  		vn->nr_purged++;
> @@ -2218,6 +2226,8 @@ static void purge_vmap_node(struct work_struct *work)
>  		list_add(&va->list, &local_list);
>  	}
>  
> +	kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
> +
>  	reclaim_list_global(&local_list);
>  }
>  
> @@ -4726,7 +4736,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  				&free_vmap_area_list);
>  		if (va)
>  			kasan_release_vmalloc(orig_start, orig_end,
> -				va->va_start, va->va_end);
> +				va->va_start, va->va_end,
> +				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
>  		vas[area] = NULL;
>  	}
>  
> @@ -4776,7 +4787,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  				&free_vmap_area_list);
>  		if (va)
>  			kasan_release_vmalloc(orig_start, orig_end,
> -				va->va_start, va->va_end);
> +				va->va_start, va->va_end,
> +				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
>  		vas[area] = NULL;
>  		kfree(vms[area]);
>  	}
>
Sure! I will have a look at the patch and check my environment.

--
Uladzislau Rezki

