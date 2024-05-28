Return-Path: <linux-kernel+bounces-192870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BC68D2353
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F71284C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664DF4E1DD;
	Tue, 28 May 2024 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/vNHNOb"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0411C6A5
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716921366; cv=none; b=l/DyU3I/VLZYIB1fifijwjdjotsg9G/yCLSbqWAG8f6loRCGsmlPbY9e+KOeqgnGj06qy4QizKI7bJXda77mmn3VeptFsojVNegSuzUSz+D44WGjOi2/0RcwpPeh2RbsEiddmJuxJ5Qs1dh2uOtucpQlZjf91ML1gVDTCvsabtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716921366; c=relaxed/simple;
	bh=rXtUrXLXV0OhPXCJZls3z+Z2nTXyO3iCbX5GfLKNHyc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ht2wYt5jW1WGt2kRcbVsY+cCuQsWrbsd6oDGNLYY1U7BxgqEoq9J6iSjGn0b79FFXEwZt33usSSsIsM2O9XRP/OdlivSM30YDdBZgKrDnQeOnOpq6ZGAJY1tj+I4mi+KZYBWPJDDB4vGV4DIWHkhS9DtAT2tEquygF1I/zTASN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/vNHNOb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so92081e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716921363; x=1717526163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Meei9ZVa20+5yNphV/wKrB9x+kwpXFk7nEopIQ+RSs=;
        b=P/vNHNObUlMC+ifIv/dYOowOFR5MBaVdF9QHXFilETYrZOwv0zH7dbu/NOU417Bt2q
         bVxFM61/V4RPgu2O1Eci1h0aHVKho0bAWVMqYiNOVlfZH1GonJ2jyb/OtoFQyGNaf5Ep
         0HYtiudMzaXTXFWFQHxUBgixP/lTDyWlYfiVspxaDUhnYCnxYel1gnuxTRlSwBVapozp
         9laYZFUaDqvc+oQOazkUNVL54sHDOXFCKRYVSbRPFnXwZX2H9m2dn3kQJ6zciIEOfHDQ
         fWYK9zSuME0aUMNCZpI06ygeDFrxUO89iPFU1OrU8yuqlI13lssoFFwHrlPJUpTootDM
         +SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716921363; x=1717526163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Meei9ZVa20+5yNphV/wKrB9x+kwpXFk7nEopIQ+RSs=;
        b=iNVbqYbVWnbvfcM7hVfn2jyO3M08l/N/Ii/wUhuyBVzUJhOA/FtmTX4yXIT3y4mOSq
         wDd560HsU6QzNOrepf8e/cKIqwask0q4OxKg/nqyFRa3VP5+O8Pf/Q1NiOZzRXynR5iR
         ffOCmb9+lvbEHN1+u+xAxRomEzawO6/wFPh2OiQo72C5AYxgiYEeXA+zBC7sIR3SG6U7
         FlG+Ibie5Gxd5unkYe16Hm2sNOchQt8QsOx4hSg6A4Olap71OXx3xywusFbulO7KFq7J
         RXO1iU3HLxKgl8WEyhZOesclWNyuMz/+JSq19hRlatSq8nQ6kCTCbUJ2RCrffDLzw3+g
         m+rw==
X-Forwarded-Encrypted: i=1; AJvYcCVtmJDG2IYnU691I4LLCZBgJvHr1CgILRWuq+4MoxeNPCbSy+6lVQmaEZCjd+n2FO344AVVFdksLhSxYy2EotUzJPOtKmFR3NLV2xbj
X-Gm-Message-State: AOJu0Yy4e7TOe9nQrV4EX0mOOUWXwLLnPcRHd3RjkEUSWUoYMUgG3wLO
	rBhiufqELHPOhMYLhwGndw7bxerjf/b/vCSU8BXoYmOAjQce6rDx
X-Google-Smtp-Source: AGHT+IFVUefm7Mk6czVp9/GpMy/YUIkaBBT9/L/RHCDAKhAAUwuSnac7GGCBChmy3RuqdnVm8VCXZw==
X-Received: by 2002:ac2:4c2d:0:b0:51f:c153:c3e7 with SMTP id 2adb3069b0e04-527ef4f5c29mr5136415e87.12.1716921362881;
        Tue, 28 May 2024 11:36:02 -0700 (PDT)
Received: from pc636 (host-95-193-70-101.mobileonline.telia.com. [95.193.70.101])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529be969ab2sm160302e87.150.2024.05.28.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 11:36:02 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 28 May 2024 20:36:00 +0200
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v2 2/2] mm/vmalloc: Use __this_cpu_try_cmpxchg() in
 preload_this_cpu_lock()
Message-ID: <ZlYkEIDqiot10w1s@pc636>
References: <20240528144345.5980-1-ubizjak@gmail.com>
 <20240528144345.5980-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528144345.5980-2-ubizjak@gmail.com>

On Tue, May 28, 2024 at 04:43:14PM +0200, Uros Bizjak wrote:
> Use __this_cpu_try_cmpxchg() instead of
> __this_cpu_cmpxchg (*ptr, old, new) == old in
> preload_this_cpu_lock().  x86 CMPXCHG instruction returns
> success in ZF flag, so this change saves a compare after cmpxchg.
> 
> The generated code improves from:
> 
>     4bb6:	48 85 f6             	test   %rsi,%rsi
>     4bb9:	0f 84 10 fa ff ff    	je     45cf <...>
>     4bbf:	4c 89 e8             	mov    %r13,%rax
>     4bc2:	65 48 0f b1 35 00 00 	cmpxchg %rsi,%gs:0x0(%rip)
>     4bc9:	00 00
>     4bcb:	48 85 c0             	test   %rax,%rax
>     4bce:	0f 84 fb f9 ff ff    	je     45cf <...>
> 
> to:
> 
>     4bb6:	48 85 f6             	test   %rsi,%rsi
>     4bb9:	0f 84 10 fa ff ff    	je     45cf <...>
>     4bbf:	4c 89 e8             	mov    %r13,%rax
>     4bc2:	65 48 0f b1 35 00 00 	cmpxchg %rsi,%gs:0x0(%rip)
>     4bc9:	00 00
>     4bcb:	0f 84 fe f9 ff ff    	je     45cf <...>
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> ---
> v2: Show generated code improvement in the commit message.
> ---
>  mm/vmalloc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5d3aa2dc88a8..4f34d935d648 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1816,7 +1816,7 @@ static void free_vmap_area(struct vmap_area *va)
>  static inline void
>  preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
>  {
> -	struct vmap_area *va = NULL;
> +	struct vmap_area *va = NULL, *tmp;
>  
>  	/*
>  	 * Preload this CPU with one extra vmap_area object. It is used
> @@ -1832,7 +1832,8 @@ preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
>  
>  	spin_lock(lock);
>  
> -	if (va && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, va))
> +	tmp = NULL;
> +	if (va && !__this_cpu_try_cmpxchg(ne_fit_preload_node, &tmp, va))
>  		kmem_cache_free(vmap_area_cachep, va);
>  }
>  
> -- 
> 2.42.0
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thanks!

--
Uladzislau Rezki

