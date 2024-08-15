Return-Path: <linux-kernel+bounces-288290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A59953870
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50906287E14
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AEF1B9B49;
	Thu, 15 Aug 2024 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffbLbPXc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FDF1B9B4F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739969; cv=none; b=QH0qKs7Q3bqKFzI/UR3e1gAD6pS+imkWJMB/Sa2R4w4RDeZoksrcQOkcGFgNhLx8T74npG8JBxrRqTDxblycjWi10jVhfwXo7UdsUJs1tax+iRHRrv/0naJp0TxHY9gHIGOpETbILBaQCT0pozc6j7XtPtDbMF6v4xjBANP1q6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739969; c=relaxed/simple;
	bh=QI+C3vffo5OIGR+0z4O/r2FQ5Uk17AMZUPdF3h/VXGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvtkXujNfvoGsrHY/qH1sVqyQVEQzfKyr6i4h8E4g4jGWRgWF+PjGDHBVT/vOLXiz5i672IuDNyIWNjF6TX0Kq1hsw9VGfJ+EP7tTWaOMrcFZwNSY2EaG2q4/M5YEg238yu3eQ3ECltJek8WrCUK0WvxckmhFW7MHijSWezl6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffbLbPXc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723739965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jmOkhEL7rMMPlaOZcAW1VqfnJiokn3GYAZDEx+SI0NY=;
	b=ffbLbPXcOZQr4YKuFCAw3CHi9n6oeMgFhOrLjBFTHFt7mXW5fZg5i7H3hgIZcoq+P/eR0f
	dzaZz/KKyT8YjlPbsGiPr4LaUl2IIPYiMZgXCDiw50k5EM8o4HFWzlBY7czBc4Vk+ZltXV
	Z9o3Xy3pZyavIGPJSiMDwOdqzrLBSoA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-irQFjzpePkOqUp-JPdqLoQ-1; Thu, 15 Aug 2024 12:39:23 -0400
X-MC-Unique: irQFjzpePkOqUp-JPdqLoQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428207daff2so6970645e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723739962; x=1724344762;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jmOkhEL7rMMPlaOZcAW1VqfnJiokn3GYAZDEx+SI0NY=;
        b=vzS05rQ6MQuGPWN4XY5R3qXmOeT4ogp4yyPIk/H8HHlyeAHPUqaPIY1RfVAL44ZuiG
         Ot5eiLrBSzz8288+baoyQAIPlRG/FHr3dYRvDXLJLWpIR4L7NkaX05qAioId5wbHrKKk
         NyaQaYCSaPVg8QiukI3nlrohB/CCSZzhbRZ8vF0w6oaDo9fIo0vNy/YmBpe9Jjv4k05o
         p2sWPowURFMqjnThZbI59dze8Q8xvCLd/iEi9iVPY86i06QUTk+eIfPi8fZV4qHcDC9Q
         1JsrDe30+GqOucUFq3bkb5OCdOr+IhOA8ZXJT21npFU1hrlNfzw4UYXz1PqdCftHgukK
         JlbA==
X-Forwarded-Encrypted: i=1; AJvYcCWDKDtuDnsbf7zMzX0zsttqUxw+E97IBccLF7TXmdmmYi66iNlOLUfRF5eAH1fW9IdZqqgHtNZu6ZQC+MEGVxyak1dRmFnO7eJxOcCX
X-Gm-Message-State: AOJu0YxROoM11zavnA1uDemjz+lacY4X76QLIJHYNWP2P7S31v5qiWy2
	wsSvcbeCANwQqDt2j7v/szcs0NqaNdLcsqTvrxLxUaO809Jw/dUQHOEqw4G6NfW9jjqb9DG5yR8
	nCopfxJFMQAHb0we26mpx4PkKcho5CFLlazU24YpR4MXNr6C9lZQsJi51uWjqQQ==
X-Received: by 2002:a05:600c:3108:b0:426:5c9b:dee6 with SMTP id 5b1f17b1804b1-429dd264cd6mr43534355e9.26.1723739961671;
        Thu, 15 Aug 2024 09:39:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+Z8NtVjPMw24mMiSZ4V1ba9fdPoF/8N7zEcxDdY7uVe69arKiWFX6LoyZgTtvBPCT0Lh5lA==
X-Received: by 2002:a05:600c:3108:b0:426:5c9b:dee6 with SMTP id 5b1f17b1804b1-429dd264cd6mr43534225e9.26.1723739961175;
        Thu, 15 Aug 2024 09:39:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6d00:aebb:127d:2c1a:7f3a? (p200300cbc7176d00aebb127d2c1a7f3a.dip0.t-ipconnect.de. [2003:cb:c717:6d00:aebb:127d:2c1a:7f3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded17cb3sm52926675e9.10.2024.08.15.09.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 09:39:20 -0700 (PDT)
Message-ID: <e6357e8e-5dd4-47a1-b7a4-603d32633692@redhat.com>
Date: Thu, 15 Aug 2024 18:39:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] codetag: debug: mark codetags for cma pages as empty
To: Hao Ge <hao.ge@linux.dev>, rppt@kernel.org, akpm@linux-foundation.org,
 surenb@google.com, babka@suse.cz, kent.overstreet@linux.dev, kees@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>
References: <20240815090324.36065-1-hao.ge@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240815090324.36065-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.08.24 11:03, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> Here are some warnning
> 
> [    1.342603] ------------[ cut here ]------------
> [    1.342608] alloc_tag was not set
> [    1.342623] WARNING: CPU: 0 PID: 1 at ./include/linux/alloc_tag.h:130 __free_pages+0x1a4/0x1b4
> [    1.342633] Modules linked in:
> [    1.342639] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc3+ #12
> [    1.342645] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    1.342650] pc : __free_pages+0x1a4/0x1b4
> [    1.342654] lr : __free_pages+0x1a4/0x1b4
> [    1.342658] sp : ffff8000833dbcb0
> [    1.342661] x29: ffff8000833dbcb0 x28: ffff000b34d9dac0 x27: ffff80008175f000
> [    1.342669] x26: 00000000000fc000 x25: ffff800082ac6028 x24: ffff80008252e000
> [    1.342675] x23: ffff0000c0660000 x22: 0000000000000000 x21: 0000000000000009
> [    1.342681] x20: 0000000000000000 x19: fffffd7fc3ac0000 x18: ffffffffffffffff
> [    1.342688] x17: ffff80008105bf68 x16: ffff800081841bb4 x15: 0720072007200720
> [    1.342694] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
> [    1.342700] x11: 0720072007200720 x10: 0720072007200720 x9 : 0720072007200720
> [    1.342706] x8 : 0720072007200720 x7 : ffff80008237bad0 x6 : c0000000ffff7fff
> [    1.342712] x5 : ffff80008237ba78 x4 : ffff8000820bbad0 x3 : 0000000000000001
> [    1.342719] x2 : 13c63f521095dc00 x1 : 13c63f521095dc00 x0 : 0000000000000000
> [    1.342725] Call trace:
> [    1.342728]  __free_pages+0x1a4/0x1b4
> [    1.342732]  init_cma_reserved_pageblock+0x5c/0xac
> [    1.342739]  cma_init_reserved_areas+0x2b4/0x3f4
> [    1.342744]  do_one_initcall+0x54/0x368
> [    1.342749]  kernel_init_freeable+0x23c/0x450
> [    1.342755]  kernel_init+0x2c/0x144
> [    1.342760]  ret_from_fork+0x10/0x20
> [    1.342764] ---[ end trace 0000000000000000 ]---
> 
> To avoid debug warnings while freeing cma pages which were not
> allocated with usual allocators, mark their codetags as empty before
> freeing.
> 
> Reference commit d224eb0287fb ("codetag: debug: mark codetags
> for reserved pages as empty")
> 
> Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>   mm/mm_init.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 75c3bd42799b..d7d40a8d738f 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2243,6 +2243,16 @@ void __init init_cma_reserved_pageblock(struct page *page)
>   		set_page_count(p, 0);
>   	} while (++p, --i);
>   
> +	/* pages were reserved and not allocated */
> +	if (mem_alloc_profiling_enabled()) {
> +		union codetag_ref *ref = get_page_tag_ref(page);
> +
> +		if (ref) {
> +			set_codetag_empty(ref);
> +			put_page_tag_ref(ref);
> +		}
> +	}
> +
>   	set_pageblock_migratetype(page, MIGRATE_CMA);
>   	set_page_refcounted(page);
>   	__free_pages(page, pageblock_order);

See https://lkml.kernel.org/r/20240813150758.855881-2-surenb@google.com

-- 
Cheers,

David / dhildenb


