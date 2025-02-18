Return-Path: <linux-kernel+bounces-518652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5B6A3929E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EEDD7A3A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDD11B043C;
	Tue, 18 Feb 2025 05:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP5IbQr2"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC51B0439
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739856458; cv=none; b=Hf5MF40LWPHIKnt5LNw8yyE6Hkx54P0Gd+aGDL5hEKTx8M4qQp28m5IstKwM4yfrSm2PVYg+Dubq3Co6x/JQQmhpM7ZdyvXg6mlSjTfqirE4W7CUcVQ9PfFLXGceouh11aL6C3FgYyx97CtZAk58o3l4TnOVV9kF1Y+Y0UtGWeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739856458; c=relaxed/simple;
	bh=+9uCyGXOAJ0ZSD5E3hkk/2H2EZqIk3JHrGCiuf0AfgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvdMbWEjgkisvf5ZJJC7Nc/tUYOsLfWUX7a8kpC1fyuq1wnEzbTNfmKNSFwPPjOiUWXLu8YFz5ldyo4n9hPd4acl3K5c2bejvt/ly6EjJVDN9yl0DoMhMiPXoicS3uxtdYXQgCBqu7SxXvCgs4m1CX6IlTYMgG7FY27UqDN1REg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP5IbQr2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22100006bc8so48496505ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 21:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739856456; x=1740461256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HxqZOLsj7jsOonVVaVaqp826M8Lpw89ZMq77OrIZj20=;
        b=KP5IbQr2NZvlCvlF1gFqjwdPfHrhNId3+nQKw0vn76P/YcPWXA7iJW8Q9eke1W4Js9
         zGDUI11dAK/YzywzzQhiZNn+2kDaZ+rBSVyBSlmUsk3vbnf4koxpEu38OS3nlHmPIO77
         mkn2/dIHy5arkyXRNO/y1K1YGTJXnbx25zDQD1ZG7pT7Hkew+ax3iXYn7U2JdnnqkKRR
         fsRVmD70wsQDcCDIn46DBWCgudNH3PFljq0AZVg1AG3WBRrJzuSKRNzvxf+z/e7nPFP2
         O/+xdJimk12XQtRAWzmj1NeNhhgB8SEYB7Dc9sexo6hZdv62pfE8tnVaYZEoHhYoXwC7
         kAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739856456; x=1740461256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxqZOLsj7jsOonVVaVaqp826M8Lpw89ZMq77OrIZj20=;
        b=nLqgbKdPOcKLuDXqG1pSm0bYoC+1l01GVYRMPYF9GykXM9d2TxIfhAcYKGzAoQdA3S
         6bEf8Dg+IBtmuPwvBEn2D9DsVnP056ZjItteCCEqZsaiblTQkgWhrxcqjb4L+EPtHFlp
         Hbm4a301a6T7c33gjO6Auf2fz1MERfBd8BWQUdTynDGCyjnKQzB54DgRAVOtCZDKA47V
         KxJtxDru1wo6QZmKq5PsVQ+SP8SxBU/5oQgQtIVq0j8LnFih3caLuiQ4FSJ/vIqw+URM
         VyLt/65BmcxyrxjIfvGkmJlwMpyUnUv41KpNUuTUZwQn+7pJD17BJxb0MP4v7cCMw3Dz
         blTA==
X-Gm-Message-State: AOJu0YwFmy1Dp6fOBAx15X9IZe7ojB3O0vG20nuAe2iSn9CrSyvqTK5S
	MW5Z7kcpvQ+f3uGSREQZb/VDp0usQ2wJk/JtMHlycHSVA0FXPcYZ
X-Gm-Gg: ASbGncuMy8/3WI/4Wa7Ko/JsH65PkLB3Z2wl0dWpKtmrCZR3uS3AXhD99S2rpQK88hP
	XvuWcEzLmJrkBBSWl3lHRxwZf0BjMNIuZzNCJXo96zAH7uWlZ8D2JOgUhiRSHciIsyfBzpL9o9/
	XTbNyMgt71UYg9kWPAbx8I8KYCXtNR3wXZAEsnAaVA/khZFvKjEL+DCFOwLhXPwEgWjKTllKo9Z
	ULexMfunn9vJzDeF8i30KvKsS1rcMtl21iJI/5JShCB3o7p3NFFgYvRFV9iOXKX3KPeizpEfQ22
	T9VxWP+mmnFmR8qjjIgu1thKnh6UbLSUQD2WozD20KZCiFI=
X-Google-Smtp-Source: AGHT+IF5VyxzzJu90hZ1mhaq1UwHE6K8UC73LdsXtYWXKAJmnEPRpcOlHz7oLZrH6QhnpDCgjbTr1A==
X-Received: by 2002:a17:903:1ce:b0:220:cd61:c03b with SMTP id d9443c01a7336-2210404bf14mr167296225ad.21.1739856455858;
        Mon, 17 Feb 2025 21:27:35 -0800 (PST)
Received: from MacBook-Air-5.local ([2001:2d8:f03b:2a87:480c:6184:1db1:ca0b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d453sm79029535ad.115.2025.02.17.21.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:27:35 -0800 (PST)
Date: Tue, 18 Feb 2025 14:27:27 +0900
From: "Harry Yoo (Oracle)" <42.hyeyoo@gmail.com>
To: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: linux-kernel@vger.kernel.org, osalvador@suse.de, byungchul@sk.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, max.byungchul.park@sk.com,
	max.byungchul.park@gmail.com
Subject: Re: [PATCH 1/1] x86/vmemmap: Use direct-mapped VA instead of
 vmemmap-based VA
Message-ID: <Z7QaPwI1eMPEwHii@MacBook-Air-5.local>
References: <20250217114133.400063-1-gwan-gyeong.mun@intel.com>
 <20250217114133.400063-2-gwan-gyeong.mun@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217114133.400063-2-gwan-gyeong.mun@intel.com>

On Mon, Feb 17, 2025 at 01:41:33PM +0200, Gwan-gyeong Mun wrote:
> When a process leads the addition of a struct page to vmemmap
> (e.g. hot-plug), the page table update for the newly added vmemmap-based
> virtual address is updated first in init_mm's page table and then
> synchronized later.
>
> If the vmemmap-based virtual address is accessed through the process's
> page table before this sync, a page fault will occur.
> 
> This translates vmemmap-based virtual address to direct-mapped virtual
> address and use it, if the current top-level page table is not init_mm's
> page table when accessing a vmemmap-based virtual address before this sync.
> 
> Fixes: faf1c0008a33 ("x86/vmemmap: optimize for consecutive sections in partial populated PMDs")
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>

I think this fix is reasonable without changing existing code too much.
Any thoughts from x86 folks?

> Cc: Byungchul Park <byungchul@sk.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Shouldn't we add Cc: <stable@vger.kernel.org>?

-- 
Harry

> ---
>  arch/x86/mm/init_64.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 01ea7c6df303..1cb26f692831 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -844,6 +844,17 @@ void __init paging_init(void)
>   */
>  static unsigned long unused_pmd_start __meminitdata;
>  
> +static void * __meminit vmemmap_va_to_kaddr(unsigned long vmemmap_va)
> +{
> +	void *kaddr = (void *)vmemmap_va;
> +	pgd_t *pgd = __va(read_cr3_pa());
> +
> +	if (init_mm.pgd != pgd)
> +		kaddr = __va(slow_virt_to_phys(kaddr));
> +
> +	return kaddr;
> +}
> +
>  static void __meminit vmemmap_flush_unused_pmd(void)
>  {
>  	if (!unused_pmd_start)
> @@ -851,7 +862,7 @@ static void __meminit vmemmap_flush_unused_pmd(void)
>  	/*
>  	 * Clears (unused_pmd_start, PMD_END]
>  	 */
> -	memset((void *)unused_pmd_start, PAGE_UNUSED,
> +	memset(vmemmap_va_to_kaddr(unused_pmd_start), PAGE_UNUSED,
>  	       ALIGN(unused_pmd_start, PMD_SIZE) - unused_pmd_start);
>  	unused_pmd_start = 0;
>  }
> @@ -882,7 +893,7 @@ static void __meminit __vmemmap_use_sub_pmd(unsigned long start)
>  	 * case the first memmap never gets initialized e.g., because the memory
>  	 * block never gets onlined).
>  	 */
> -	memset((void *)start, 0, sizeof(struct page));
> +	memset(vmemmap_va_to_kaddr(start), 0, sizeof(struct page));
>  }
>  
>  static void __meminit vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
> @@ -924,7 +935,7 @@ static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long
>  	 * Mark with PAGE_UNUSED the unused parts of the new memmap range
>  	 */
>  	if (!IS_ALIGNED(start, PMD_SIZE))
> -		memset((void *)page, PAGE_UNUSED, start - page);
> +		memset(vmemmap_va_to_kaddr(page), PAGE_UNUSED, start - page);
>  
>  	/*
>  	 * We want to avoid memset(PAGE_UNUSED) when populating the vmemmap of
> -- 
> 2.48.1
> 

