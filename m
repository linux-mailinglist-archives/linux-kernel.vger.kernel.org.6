Return-Path: <linux-kernel+bounces-320948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F4E97125F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E743AB23F1D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD081B29A3;
	Mon,  9 Sep 2024 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QszBD3Mj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291941B253A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871409; cv=none; b=QNQl8pAF7rS9QiVS2SB43O2vDDLUoyzIJyengtV6qUkke5wXUzEPVmfLVj/keTvbh3o/rcCZ1FuZxdOEJCMLaRzzKGrOEbyT1SscdZfWb57o5ruFaLXWGvssoJv1fmgZMjZCIA7mQwNauEyLM1Wp8glQRiWjdACF3S6J7wweUzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871409; c=relaxed/simple;
	bh=39A7BTcSzZ2dXOFvbxhG2IJqxfl9nXPv0m8N4YYbvXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQvvWKQ8YD9R+MAgVNbCYv45I8tVEcTUbKCa+aVbKa3FFlix0nFtm74G+unWyvLwmww4sbLHjpqTunVSfjJ7NHwaakRbIUWCRIZiESXKx6YipBVF/roB2XO6o5pXoPm8ucSiTI546y09q9VQy26qZK1KI1nWadFfTpNMYyO60YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QszBD3Mj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725871405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XTSp2n+GbdScgaVNMoj5K3OzDIPbt5gKDT/PTBJUEoM=;
	b=QszBD3MjEqOVxvlgtXEHRp0XD3HWoYcb3vQ104kxh4PT3mkUlpY6Nxb4rF5BaFsn8X8b6K
	k2ov45BlgZvkGMmoSso7cH1q7UgGl8tXdEbK098RB9GCG9E2RvzuGGESsHoyJAXQ6VljPp
	du+piHa9OFFb7jd7gVl/UZt2hDvKiew=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-UmvEA26wOG2qmiAdC2JkkA-1; Mon, 09 Sep 2024 04:43:24 -0400
X-MC-Unique: UmvEA26wOG2qmiAdC2JkkA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb0b0514bso13539875e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725871403; x=1726476203;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XTSp2n+GbdScgaVNMoj5K3OzDIPbt5gKDT/PTBJUEoM=;
        b=DpuM2YjKRLwdvyOJz8eC8gRqWpe3MrHvjMxo9Qk3Jj4qRUUAtkQqUajnXUkIu7BBYF
         OlhRZzVp0qmb0Ceo1q0xis5Qv3r6cYKWo4wnOQGBGALaCL3vCspHTjkTu69g9Jvvpdwj
         Oi2o9uoMlkQcGDRWhATEBZXHVo5tHt1XEFArj5T7EOwqqWyKpq2Of1879Mhl9cod+3ma
         9OpZfq/VwvZHWFyjohahSw3Req8sudRVECtg0cvMDSKwQCXvtd5ymNkoj1BKz8IUB0GJ
         Z2JRNjXcyvYqZ0sHT7d9eyt3Oy1iSoMPpaivVg8n+u/lQdva8PeMNjU5UjHzBWaMT5ag
         OgJA==
X-Forwarded-Encrypted: i=1; AJvYcCWztPiR8RsMXoclxpaNrgav4li854oxS0Ogi98vzwSSE/PyERf5vZnsH1sN5viQH5uLpMY76QIp5ZgsSVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkDMB5vAZG3Drq460AGYLa71z1UXHMEHdMlAs/TIdDxAbp//lZ
	X7KKzlT84GFi8VHT2GgSJOibO4uhpFXEaMgZhClTZUevI5793Q37wOaXsAwW96Le6sAhvHJc1BD
	LMtz+mX806/djwgArQR0WeB4qqUmXxOK9JzIMHZDZccrwtnZHoSWI0Hdb33auWA==
X-Received: by 2002:a05:600c:4684:b0:429:a3e:c785 with SMTP id 5b1f17b1804b1-42c9f985734mr81513405e9.21.1725871402637;
        Mon, 09 Sep 2024 01:43:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7xeg/Y6rg1dWJsOE3FD9IspGfDP4hzFUjfRiT+r/9Ea3j6VufVjpCrcrUF1/Ag3SGmwIE+A==
X-Received: by 2002:a05:600c:4684:b0:429:a3e:c785 with SMTP id 5b1f17b1804b1-42c9f985734mr81513105e9.21.1725871401961;
        Mon, 09 Sep 2024 01:43:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c729:d800:d3b6:a549:7878:a6ee? (p200300cbc729d800d3b6a5497878a6ee.dip0.t-ipconnect.de. [2003:cb:c729:d800:d3b6:a549:7878:a6ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cadda5a07sm74797625e9.0.2024.09.09.01.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 01:43:21 -0700 (PDT)
Message-ID: <dfd118c5-a3d3-42d2-a25c-43e668247879@redhat.com>
Date: Mon, 9 Sep 2024 10:43:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH 1/2] hugetlb: arm64: add mte support
To: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org, muchun.song@linux.dev, akpm@linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240906175945.3636193-1-yang@os.amperecomputing.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240906175945.3636193-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.09.24 19:59, Yang Shi wrote:
> Enable MTE support for hugetlb.
> 
> The MTE page flags will be set on the folio only.  When copying
> hugetlb folio (for example, CoW), the tags for all subpages will be copied
> when copying the first subpage.
> 
> When freeing hugetlb folio, the MTE flags will be cleared.
> 
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>   arch/arm64/include/asm/hugetlb.h | 15 ++++++-
>   arch/arm64/include/asm/mman.h    |  3 +-
>   arch/arm64/include/asm/mte.h     | 67 ++++++++++++++++++++++++++++++++
>   arch/arm64/kernel/hibernate.c    |  7 ++++
>   arch/arm64/kernel/mte.c          | 25 +++++++++++-
>   arch/arm64/kvm/guest.c           | 16 ++++++--
>   arch/arm64/kvm/mmu.c             | 11 ++++++
>   arch/arm64/mm/copypage.c         | 33 +++++++++++++---
>   fs/hugetlbfs/inode.c             |  2 +-
>   9 files changed, 166 insertions(+), 13 deletions(-)
> 
> v3: * Fixed the build error when !CONFIG_ARM64_MTE.
>      * Incorporated the comment from David to have hugetlb folio
>        specific APIs for manipulating the page flags.
>      * Don't assume the first page is the head page since huge page copy
>        can start from any subpage.
> v2: * Reimplemented the patch to fix the comments from Catalin.
>      * Added test cases (patch #2) per Catalin.
> 
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 293f880865e8..06f621c5cece 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -11,6 +11,7 @@
>   #define __ASM_HUGETLB_H
>   
>   #include <asm/cacheflush.h>
> +#include <asm/mte.h>
>   #include <asm/page.h>
>   
>   #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> @@ -18,9 +19,21 @@
>   extern bool arch_hugetlb_migration_supported(struct hstate *h);
>   #endif
>   
> +#ifdef CONFIG_ARM64_MTE
> +#define CLEAR_FLAGS (BIT(PG_dcache_clean) | BIT(PG_mte_tagged) | \
> +		     BIT(PG_mte_lock))
> +#else
> +#define CLEAR_FLAGS BIT(PG_dcache_clean)
> +#endif
> +
>   static inline void arch_clear_hugetlb_flags(struct folio *folio)
>   {
> -	clear_bit(PG_dcache_clean, &folio->flags);
> +	if (!system_supports_mte()) {
> +		clear_bit(PG_dcache_clean, &folio->flags);
> +		return;
> +	}
> +
> +	folio->flags &= ~CLEAR_FLAGS;

In contrast to clear_bit, this is now not an atomic operation anymore. 
Could we have concurrent modifications (locking the folio? mte?) where 
we could mess up (IOW, is there a reason we don't do __clear_bit in 
existing code)?

Maybe start with:

static inline void arch_clear_hugetlb_flags(struct folio *folio)
{
	clear_bit(PG_dcache_clean, &folio->flags);
#ifdef CONFIG_ARM64_MTE
	if (system_supports_mte()) {
		clear_bit(PG_mte_tagged, &folio->flags);
		clear_bit(PG_mte_lock, &folio->flags);
	}
#endif
}

And if you can argue that atomics are not required, convert all to 
__clear_bit() and have the compiler optimize it for you.

>   }
>   #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
>   > diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 0f84518632b4..cec9fb6fec3b 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -41,6 +41,8 @@ void mte_free_tag_storage(char *storage);
>   
>   static inline void set_page_mte_tagged(struct page *page)
>   {
> +	VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
> +
>   	/*
>   	 * Ensure that the tags written prior to this function are visible
>   	 * before the page flags update.
> @@ -51,6 +53,8 @@ static inline void set_page_mte_tagged(struct page *page)
>   
>   static inline bool page_mte_tagged(struct page *page)
>   {
> +	VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
> +
>   	bool ret = test_bit(PG_mte_tagged, &page->flags);
>   
>   	/*
> @@ -76,6 +80,8 @@ static inline bool page_mte_tagged(struct page *page)
>    */
>   static inline bool try_page_mte_tagging(struct page *page)
>   {
> +	VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
> +
>   	if (!test_and_set_bit(PG_mte_lock, &page->flags))
>   		return true;
>   

[...]

> +static inline void set_folio_hugetlb_mte_tagged(struct folio *folio)
> +{
> +}
> +
> +static inline bool folio_hugetlb_mte_tagged(struct folio *folio)
> +{
> +	return false;
> +}
> +
> +static inline bool try_folio_hugetlb_mte_tagging(struct folio *folio)
> +{
> +	return false;
> +}

I would suggest to stick to the format of our folio_test / folio_set ... 
functions. Please refer to 
folio_set_hugetlb_migratable/folio_set_hugetlb_hwpoison/ ...

Something like:

folio_test_hugetlb_mte_tagged
folio_set_hugetlb_mte_tagged

But the semantics of try_folio_hugetlb_mte_tagging() are a bit less 
obvious. I would suggest

folio_test_and_set_hugetlb_mte_lock()


We should probably clean up the page_* variants separately.

But ARM maintainers can feel free to intervene here.

> +#endif
> +
>   static inline void mte_disable_tco_entry(struct task_struct *task)
>   {
>   	if (!system_supports_mte())
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 02870beb271e..ebf81fffa79d 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -266,10 +266,17 @@ static int swsusp_mte_save_tags(void)
>   		max_zone_pfn = zone_end_pfn(zone);
>   		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
>   			struct page *page = pfn_to_online_page(pfn);
> +			struct folio *folio;
>   
>   			if (!page)
>   				continue;
>   

Nit: I would drop this empty line.

> +			folio = page_folio(page);
> +
> +			if (folio_test_hugetlb(folio) &&
> +			    !folio_hugetlb_mte_tagged(folio))
> +				continue;
> +
>   			if (!page_mte_tagged(page))
>   				continue;
>   
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 6174671be7c1..c8b13bf36fc6 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -38,7 +38,22 @@ EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
>   void mte_sync_tags(pte_t pte, unsigned int nr_pages)
>   {
>   	struct page *page = pte_page(pte);
> -	unsigned int i;
> +	struct folio *folio = page_folio(page);
> +	unsigned long i;
> +
> +	if (folio_test_hugetlb(folio)) {
> +		unsigned long nr = folio_nr_pages(folio);

Nit: empty line please.

> +		/* Hugetlb MTE flags are set for head page only */
> +		if (try_folio_hugetlb_mte_tagging(folio)) {
> +			for (i = 0; i < nr; i++, page++)
> +				mte_clear_page_tags(page_address(page));
> +			set_folio_hugetlb_mte_tagged(folio);
> +		}
> +
> +		smp_wmb();

We already do have one in set_folio_hugetlb_mte_tagged() [and 
try_folio_hugetlb_mte_tagging() does some magic as well], do we really 
need this smp_wmb()?

In general, I think checkpatch will tell you to document memory barriers 
and their counterparts thoroughly.

> +
> +		return;
> +	}




-- 
Cheers,

David / dhildenb


