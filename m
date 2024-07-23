Return-Path: <linux-kernel+bounces-259891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE24939EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DB7283583
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D22D14EC5D;
	Tue, 23 Jul 2024 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK461JAg"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8573D6A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721731843; cv=none; b=mF8zsDiBSqz3suOqOJHyBNDt0bgEk5+6T9mW5ffcchm21xvsaxPIGwO5t7VDBUoaKeeCMduO31Lynu9LKK6bNqdEw4gpkLxg6o/LGmHSozcdwq6v6pm1c8HvZhunI0gNEieSVHAIuKSm+ZrsQPAnGfWtBfQoMlDpUK6RD8Ns1RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721731843; c=relaxed/simple;
	bh=7ln9MIH0a/F0tJNQVBzf6RTmcRbwAdmobtg1zQcLYUY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kazhAt6a3A1IcD4pSDk71MJ24bfUlny1SsDjzk9mRUTYxEiSGv4tu+O4VvIZM7hvfi6azfhnZLBwkeu87OZn9y7pxCYmP556Mr+XK7lvwnDEmOqT93Hq29OtuKu9Wwl7w/nhtOk54vVaRHCX0QNvCp5nN7KKhgJaEp7JX5TYKTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK461JAg; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe3fb5d4dso47964481fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721731840; x=1722336640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0dRtw8ZAunWvu++rHHyoAYfF4HuDJvNfZWM1BGrhWE4=;
        b=hK461JAgmoSMzFHS1fDfd1luWL3yuKQzwB1z0zqF5JMsEgXhZinp3pelxbUqbdZ0Dw
         5NWxGIiDtyRk0u3jqq2L+hqNUBTew+HyXOn3skQjj13AEAwD28V+81k8n7ylJhjB0SY+
         JnR6NlqgPUmE6ok3DxbrnnfymQoabO48LPxfuKiw1S/V04Kx5OVxSSBoZiUfkCAiLCeX
         tE5nQjqkhJTBfLOmyuTFSoGN8UANSm7pdK0ZjqS5HXoAQB+ibKweW+2b2TVMZ81LcGvD
         y3JMucRtYmN0DRRQIVY3SmXASHllx94JACT8euDUJzQ6AHtjW29t8KhP2510sh07+XS6
         bVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721731840; x=1722336640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dRtw8ZAunWvu++rHHyoAYfF4HuDJvNfZWM1BGrhWE4=;
        b=cIDNgHS2y1/sdS5TlQbJhmvfXWeKAKe4+LBSqxTxDzUjBNIL4jtsqmLbgHT1VAFkrq
         U2ZfS8tqwDK6+YkEK9yRkIl6+0Iq5J9ZUlfjFPxOSLcTJGPSdG0Ac+d64Rvkki9LSQMk
         91TNlbheoCw4hEf7ADx1s3jCrZEV4eLvkWa6AG6g+7mQGVcFtD6A7XhT6M4pZ0dWI9lX
         QRk9tvI9Xmoi6ftLTUoSPJjVveBGp9PPpYuJ2calVtHf5CHWx0yuHF22OSmYN3n1P7c0
         4eJQicDXnJYdbMfWfcEbB4pS33NUNMHj70+ldFulWoeGoQ+Cv6dcAjnBeKQRHGFkXO0g
         EQMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkzCyBS7LgH4+eTjwGHomJasjvR7Y+hM7ny4OZaD+frQi/wf+D0V2mtTI8QmF5c/cVJ5bdg7plmm0xJBKjJRTrEmW3O6WOiaWU4cO+
X-Gm-Message-State: AOJu0YwwYg9DJH+7CmpCnFZSSfksJCKA4/INShbIeulgBtipRg6zYI2V
	7EWsKB5ezPxmkz+wLmEfSqeSXUgFRDCv5rgvN3CUCfz0Fy6pGnJj
X-Google-Smtp-Source: AGHT+IGSthot0iKE/vnYRJKk2YUIwtdaQfsx4fYPIMwYj5KmJH4KDDVptJnU8LtEG8PCcRCc48D0Qg==
X-Received: by 2002:a2e:a7ca:0:b0:2ee:7c35:d892 with SMTP id 38308e7fff4ca-2f0210dd6edmr7003811fa.17.1721731839466;
        Tue, 23 Jul 2024 03:50:39 -0700 (PDT)
Received: from pc636 (host-90-233-197-231.mobileonline.telia.com. [90.233.197.231])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f01cc2ef3bsm3955251fa.98.2024.07.23.03.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 03:50:38 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 23 Jul 2024 12:50:36 +0200
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: urezki@gmail.com, ahuang12@lenovo.com, akpm@linux-foundation.org,
	hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	peterz@infradead.org, sunjw10@lenovo.com
Subject: Re: [PATCH 1/1] mm/vmalloc: Add preempt point in purge_vmap_node()
 when enabling kasan
Message-ID: <Zp-K_A60DjlDhlRt@pc636>
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
It works great and does not generate the soft-lock-up splat :)
See below some comments:

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
>
Do we need it here? We just did the TLB flush for en entire range in the
__purge_vmap_area_lazy(). So, it is two times invoked and looks odd to me.

Am i missing something?

Thanks!

--
Uladzislau Rezki

