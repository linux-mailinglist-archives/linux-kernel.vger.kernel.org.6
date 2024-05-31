Return-Path: <linux-kernel+bounces-196439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA628D5C31
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9311C215B1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1412B7641D;
	Fri, 31 May 2024 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsRHIfXQ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878211865C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717142704; cv=none; b=fviT54DPnkPOerhA9RupoxxYYVXPcuThXHq7AUQ+1H2sZ9oCTkZXZEwp51QEfLI0ltF08KNYFWIw5NXnNdu+mBI+Un/rLq17+TvglH24Vna/o5zgSzSvT8vccCPT6e4RhaT3EzjwiQD0G9EuaIo3wEff60vAcPkzBD4BAVVOruY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717142704; c=relaxed/simple;
	bh=F+lzgPqg9lhu50M6zF5XMluTv3sYneYhzf3q2UnA108=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSBNtfbTnZ5HKH4UuXpJ2KiYvL8P5t/s+34FhSfU2nhOhrcRxJUMLT1oHtBnqLL+2tsNHN0UTlwIuVdvuRnEz6+fjIfAH07Ln08hSJV91Dfd7RG9UQWYxXqDbLeL1vR9wA+f2gDxe9DElZtKcosC11B34UbKS0LnnuDktDdliMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsRHIfXQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52965199234so1779084e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717142700; x=1717747500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/lyt572tck3lje3O0S/YoFgYMtGpbPoXZ2zrD3MWgE=;
        b=BsRHIfXQh2r3vFuxerMaBkNuqZdNXQAoDJ6nYJ17sj7OLFZNgUbkGqMDYxMu/YGfLb
         pB03ZNBtdsav4WsxOzjfp6xwIEn49IVqO01Nhx+WnPFrFQp+5B4mUMON9og1xqBF1j4e
         UVD6O4Whk8H3Nx4HzkLGZcj+eN4ZNX93nBAS7HD1/yWESlPdQRLRI48h+sknOXRNs2Ld
         zsGECJ4CXa2PLYIKQcnFh4x76l8OfAOzKzlL1W/M7i4vPOQ3T31U4wMqaVqrOzuGROEW
         KohiSiZ1QKkrZwJSJ529cMDkew4+hDKMRLANXH85SqhRtEH4cYzusrKfO+nW0Sztktpu
         uL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717142700; x=1717747500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/lyt572tck3lje3O0S/YoFgYMtGpbPoXZ2zrD3MWgE=;
        b=XD/kol4NCsWElk4TGWUkjos5IvKjRQkL4+v9XkkrFXqFb+aRsb8oYV0RSR1NknknSo
         UCJ3HVtLwk+8RC4u7J2+jWeUdP4CfwLw7HESR17vlGHbwSMMUh6mURuMIuqzp2sJk5ar
         1L++c7ydt3t0HJtedzEztHpUgQkJ+GjsjX9IKrKi79coaCEgA3FS3KLQ7qEW5PO2WLOP
         cychLTfKOs3chIerttdvxaTf+ujX1uBNzPSDGtNJh0zuuCEuOR7INgszDKOlI69j39CY
         0/H4iTpHNrK8x2MLuauywLnldYJ3JiEseH6NOk25x4mw2FZULhBgAOscnqCq0uRs0AL2
         fF8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPbTWz3oqW5EsXr0Gc2iRlvYmy6US+2MbnFDzR2UPQcNx+x9GaZFm/1/9feUAFZl1Eq2HugwlpvZxFfG2ld7e0+l8hjz9rQj+nd8hC
X-Gm-Message-State: AOJu0Yxd7UmDYDBMW55oKAFmJadghsByZaSGDuUj29tICl1ckWS6X3D4
	/1b7nBzci4bheQBePxSE9Hw9Mkx5UGc1FyOBsmhDQYi0Q8JDKLkX
X-Google-Smtp-Source: AGHT+IGpCuXGTZ8Xt7porjTHxJrfZgkQE6ybn4Sd9kHjWzof4gBAcCJaFTeI4onNWK1I0VZLt0R6uA==
X-Received: by 2002:a05:6512:34cd:b0:52b:242b:5d1f with SMTP id 2adb3069b0e04-52b89573216mr651102e87.15.1717142700052;
        Fri, 31 May 2024 01:05:00 -0700 (PDT)
Received: from pc636 (host-95-193-70-101.mobileonline.telia.com. [95.193.70.101])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d3f428sm250769e87.92.2024.05.31.01.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 01:04:59 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 31 May 2024 10:04:55 +0200
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCHv3] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <ZlmEp9nxKiG9gWFj@pc636>
References: <20240531030520.1615833-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531030520.1615833-1-zhaoyang.huang@unisoc.com>

On Fri, May 31, 2024 at 11:05:20AM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> vmalloc area runs out in our ARM64 system during an erofs test as
> vm_map_ram failed[1]. By following the debug log, we find that
> vm_map_ram()->vb_alloc() will allocate new vb->va which corresponding
> to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
> when vbq->free->next points to vbq->free. That is to say, 65536 times
> of page fault after the list's broken will run out of the whole
> vmalloc area. This should be introduced by one vbq->free->next point to
> vbq->free which makes list_for_each_entry_rcu can not iterate the list
> and find the BUG.
> 
> [1]
> PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
>  #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
>  #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
>  #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
>  #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
>  #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
>  #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
>  #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
>  #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc3c
>  #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
>  #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0
> 
> Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")
> 
> Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
Is a problem related to run out of vmalloc space _only_ or it is a problem
with broken list? From the commit message it is hard to follow the reason.

Could you please post a full trace or panic?

> ---
> v2: introduce cpu in vmap_block to record the right CPU number
> v3: use get_cpu/put_cpu to prevent schedule between core
> ---
> ---
>  mm/vmalloc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22aa63f4ef63..ecdb75d10949 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2458,6 +2458,7 @@ struct vmap_block {
>  	struct list_head free_list;
>  	struct rcu_head rcu_head;
>  	struct list_head purge;
> +	unsigned int cpu;
>  };
>  
>  /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
> @@ -2586,10 +2587,12 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  		return ERR_PTR(err);
>  	}
>  
> +	vb->cpu = get_cpu();
>  	vbq = raw_cpu_ptr(&vmap_block_queue);
>  	spin_lock(&vbq->lock);
>  	list_add_tail_rcu(&vb->free_list, &vbq->free);
>  	spin_unlock(&vbq->lock);
> +	put_cpu();
>  
Why do you need get_cpu() here? Can you go with raw_smp_processor_id()
and then access the per-cpu "vmap_block_queue"? get_cpu() disables
preemption and then a spin-lock is take within this critical section.
From the first glance PREEMPT_RT is broken in this case.

I am on a vacation, responds can be with delays.

--
Uladzislau Rezki

