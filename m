Return-Path: <linux-kernel+bounces-215412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B4F90926A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E491C231F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773F71A01C5;
	Fri, 14 Jun 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJgGi7eY"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB1119AA6E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390315; cv=none; b=bcEEVKewnBbyNQxZZv5YGzGqyqGSsJekiUIynAY81GAuESA8WrIKXKCL9coIX4iqCu2jHsv1RfInSg7KiOZs0psRvjP/dpfYT76ABKlA1/q6YH54nm0sCFGrdAqj/qnxKW5+/WrUCu+d5jVc3DS8C7UPXzpJLDQgUEurzKDcqDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390315; c=relaxed/simple;
	bh=J/5ihBaXRolkDPJN8mQlqnFwgbD48z7p4gtk24WAW7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ii/+9z9APVIcT8fiZSuMWCGvqVXCUiM9A8l8QyRt/czLG8VWc1OBA2gHDdeDQoEC7uHTM8HZwjYj2iK9c8H7OE4dBYUDrRhlx0ldP9nQ08eV7rQuyefdzJ12R85XHNE5OhwINgIF8U0vIpWkGLyPw4R2PLzE9MdPUOQnRpILA1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJgGi7eY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f70131063cso21550765ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718390313; x=1718995113; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S0zMa6C8i8qb67Vd+aRO22odjQQQkyxDlIIdx8dvZpo=;
        b=mJgGi7eY5T/3HhojOIvl5dPm/qMcAHtZo/niENniiQmj3o3z8ZYoPuQXUOUmGjYqyS
         WqnuhBXszy0kdF8aOOMgpXEYNMvyPySQdhSPhyVJYiERQ6EjidR7v/yrXsp2H1PVtL0H
         hlyNOtjVJbpOHjoWv9RqgquOJod6vR70PGUquE84OfHC6tBKOEjFpLf4w3kaJtycw4yD
         cXww26KY9loON4w6CDqsYBTwEgPAHUHWndZZJasK5dnX6nF2U5AXtowqoOZBDJEHC2PW
         aKunMw1JqHCKecf/DRK6jvykVElyu0j54UpK5Gopbr2Ylf9QUlbfN/mtm1cxtfmY2+7q
         SleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718390313; x=1718995113;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0zMa6C8i8qb67Vd+aRO22odjQQQkyxDlIIdx8dvZpo=;
        b=liOxxB1/iFeKFYG2BqdSRyPmRWV5SNo0IkB+oSxa5BVFKP0TEpDZMoa3DKJmaG9FXW
         4xadUwazAUM1U40NMfkfwXsrTofw331kU473zFcLQ8TmuJA8L9Cf1n71UlCOrg95WgEZ
         EI5+Y4tgRZRJX8lKW1LYau/af+xpEsqeYkbLrQkfiYIaIeJ6zv0jirj96EWovHUNrEHZ
         Anu8pCZoCpmh3dniydmuE5SVi+RwOYGCp/b7bOQc/i/eZOdVE9CSC814hOwam9Iz9+ea
         N2fhPTt0ytJo8BWlO2v1lkdw8QNc5zbCumPCp1dcPyP13BE0+QT6rLwkFmc9fFTBh9in
         8AKA==
X-Forwarded-Encrypted: i=1; AJvYcCVqKE04SB1POyMJHDVoG4mm2yu8/HDiwk4NH4QPwpgOBqLflIJXnd4muQB4/YK9PxNMfTMbxsQ1T7s8Nfjxf5LG+bXchfv6LPBlykPr
X-Gm-Message-State: AOJu0YzxxGrJr/OjsvXgl3kMOiKLWvPmKNC5T1gwp1C8Ki9amiUzDjtR
	V7+hViSQg62ssGVZgYk3gJoXGC8nEgvwUal/pNICp1qBI9XGoxPqaPj25KeVPA==
X-Google-Smtp-Source: AGHT+IHgK17r9FcbDbyrNIS1RKHIl6JLZNOHV/yb5UnACNKgT/L1t8iTDDr3iuoXxdanmEElFsFr7w==
X-Received: by 2002:a17:902:dace:b0:1f7:908:963a with SMTP id d9443c01a7336-1f8626d2879mr43415625ad.24.1718390312748;
        Fri, 14 Jun 2024 11:38:32 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4d14esm35177965ad.288.2024.06.14.11.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:38:32 -0700 (PDT)
Date: Fri, 14 Jun 2024 18:38:28 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v3] binder_alloc: Replace kcalloc with kvcalloc to
 mitigate OOM issues
Message-ID: <ZmyOJJmA7h6sZ_8A@google.com>
References: <20240614040930.11119-1-liulei.rjpt@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614040930.11119-1-liulei.rjpt@vivo.com>

On Fri, Jun 14, 2024 at 12:09:29PM +0800, Lei Liu wrote:
> 1.In binder_alloc, there is a frequent need for order3 memory
> allocation, especially on small-memory mobile devices, which can lead
> to OOM and cause foreground applications to be killed, resulting in
> flashbacks.The kernel call stack after the issue occurred is as follows:
> dumpsys invoked oom-killer:
> gfp_mask=0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), order=3,
> oom_score_adj=-950
> CPU: 6 PID: 31329 Comm: dumpsys Tainted: G        WC O
> 5.10.168-android12-9-00003-gc873b6b86254-ab10823632 #1
> Call trace:
>  dump_backtrace.cfi_jt+0x0/0x8
>  dump_stack_lvl+0xdc/0x138
>  dump_header+0x5c/0x2ac
>  oom_kill_process+0x124/0x304
>  out_of_memory+0x25c/0x5e0
>  __alloc_pages_slowpath+0x690/0xf6c
>  __alloc_pages_nodemask+0x1f4/0x3dc
>  kmalloc_order+0x54/0x338
>  kmalloc_order_trace+0x34/0x1bc
>  __kmalloc+0x5e8/0x9c0
>  binder_alloc_mmap_handler+0x88/0x1f8
>  binder_mmap+0x90/0x10c
>  mmap_region+0x44c/0xc14
>  do_mmap+0x518/0x680
>  vm_mmap_pgoff+0x15c/0x378
>  ksys_mmap_pgoff+0x80/0x108
>  __arm64_sys_mmap+0x38/0x48
>  el0_svc_common+0xd4/0x270
>  el0_svc+0x28/0x98
>  el0_sync_handler+0x8c/0xf0
>  el0_sync+0x1b4/0x1c0
> Mem-Info:
> active_anon:47096 inactive_anon:57927 isolated_anon:100
> active_file:43790 inactive_file:44434 isolated_file:0
> unevictable:14693 dirty:171 writeback:0\x0a slab_reclaimable:21676
> slab_unreclaimable:81771\x0a mapped:84485 shmem:4275 pagetables:33367
> bounce:0\x0a free:3772 free_pcp:198 free_cma:11
> Node 0 active_anon:188384kB inactive_anon:231708kB active_file:175160kB
> inactive_file:177736kB unevictable:58772kB isolated(anon):400kB
> isolated(file):0kB mapped:337940kB dirty:684kB writeback:0kB
> shmem:17100kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB
> writeback_tmp:0kB kernel_stack:84960kB shadow_call_stack:21340kB
> Normal free:15088kB min:8192kB low:42616kB high:46164kB
> reserved_highatomic:4096KB active_anon:187644kB inactive_anon:231608kB
> active_file:174552kB inactive_file:178012kB unevictable:58772kB
> writepending:684kB present:3701440kB managed:3550144kB mlocked:58508kB
> pagetables:133468kB bounce:0kB free_pcp:1048kB local_pcp:12kB
> free_cma:44kB
> Normal: 3313*4kB (UMEH) 165*8kB (UMEH) 35*16kB (H) 15*32kB (H) 0*64kB
> 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 15612kB
> 108356 total pagecache pages

Think about indenting this stacktrace. IMO, the v1 had a commit log that
was much easier to follow.

> 
> 2.We use kvcalloc to allocate memory, which can reduce system OOM
> occurrences, as well as decrease the time and probability of failure
> for order3 memory allocations. Additionally, it can also improve the
> throughput of binder (as verified by Google's binder_benchmark testing
> tool).
> 
> 3.We have conducted multiple tests on an 12GB memory phone, and the
> performance of kvcalloc is better. Below is a partial excerpt of the
> test data.
> throughput = (size * Iterations)/Time

Huh? Do you have an explanation for this performance improvement?
Did you test this under memory pressure?

My understanding is that kvcalloc() == kcalloc() if there is enough
contiguous memory no?

I would expect the performance to be the same at best.

> kvcalloc->kvmalloc:
> Benchmark-kvcalloc	Time	CPU	Iterations	throughput(Gb/s)
> ----------------------------------------------------------------
> BM_sendVec_binder-4096	30926 ns	20481 ns	34457	4563.66↑
> BM_sendVec_binder-8192	42667 ns	30837 ns	22631	4345.11↑
> BM_sendVec_binder-16384	67586 ns	52381 ns	13318	3228.51↑
> BM_sendVec_binder-32768	116496 ns	94893 ns	7416	2085.97↑
> BM_sendVec_binder-65536	265482 ns	209214 ns	3530	871.40↑
> 
> kcalloc->kmalloc
> Benchmark-kcalloc	Time	CPU	Iterations	throughput(Gb/s)
> ----------------------------------------------------------------
> BM_sendVec_binder-4096	39070 ns	24207 ns	31063	3256.56
> BM_sendVec_binder-8192	49476 ns	35099 ns	18817	3115.62
> BM_sendVec_binder-16384	76866 ns	58924 ns	11883	2532.86
> BM_sendVec_binder-32768	134022 ns	102788 ns	6535	1597.78
> BM_sendVec_binder-65536	281004 ns	220028 ns	3135	731.14
> 
> Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
> ---
> Changelog:
> v2->v3:
> 1.Modify the commit message description as the description for the V2
>   version is unclear.

The complete history of the changelog would be better.

> ---
>  drivers/android/binder_alloc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 2e1f261ec5c8..5dcab4a5e341 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -836,7 +836,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>  
>  	alloc->buffer = vma->vm_start;
>  
> -	alloc->pages = kcalloc(alloc->buffer_size / PAGE_SIZE,
> +	alloc->pages = kvcalloc(alloc->buffer_size / PAGE_SIZE,
>  			       sizeof(alloc->pages[0]),
>  			       GFP_KERNEL);

I believe Greg had asked for these to be aligned to the parenthesis.
You can double check by running checkpatch with the -strict flag.

>  	if (alloc->pages == NULL) {
> @@ -869,7 +869,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>  	return 0;
>  
>  err_alloc_buf_struct_failed:
> -	kfree(alloc->pages);
> +	kvfree(alloc->pages);
>  	alloc->pages = NULL;
>  err_alloc_pages_failed:
>  	alloc->buffer = 0;
> @@ -939,7 +939,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>  			__free_page(alloc->pages[i].page_ptr);
>  			page_count++;
>  		}
> -		kfree(alloc->pages);
> +		kvfree(alloc->pages);
>  	}
>  	spin_unlock(&alloc->lock);
>  	if (alloc->mm)
> -- 
> 2.34.1
> 

I'm not so sure about the results and performance improvements that are
claimed here. However, the switch to kvcalloc() itself seems reasonable
to me.

I'll run these tests myself as the results might have some noise. I'll
get back with the results.

Thanks,
Carlos Llamas


