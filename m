Return-Path: <linux-kernel+bounces-331614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 782A697AEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D73280EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2B2167D83;
	Tue, 17 Sep 2024 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWvoamfo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EDF165F16
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569424; cv=none; b=uBSvxKpK/DsluiTqvM8QSqS/Qc4PiWTnhuEQejKXmbpVY6z+Qo/AmK7qur+gc26RUxOC56B7hGL/CMMabTlj7h+Y8xsUx+jCrzni4r832TnaIMrbtwF4g5NoodFZOzNc+/t6iGRIRrswZRopO9uND/Au3n5GnOLffqcIy9WQ2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569424; c=relaxed/simple;
	bh=eo0C4NnreQjlbPSScqKfR3R/RqvBPfqb21UCXYmaxQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PED+p/FZ7dMFq/yES24tNe+5kspaQ0FH6LqcKiYeU3o3Gz9rXJQrPWmqaZkOL/IAxF6zq6Cni2rDvLunlbX8eHTZsmFePeRFAYwi7OaRdV5V+XLZJm6gcQMnA0mT4SUIbBSN49edIPLZa4agccEYK26FeW1wN1o5I07kuBJBl/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWvoamfo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726569421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k3gFTZxrNbLxX57z2m6Vx99Y/NavEv7vkvUwLMLsP4k=;
	b=IWvoamfo/FAQoGn19ygrRFy6+vq55QqtkLe44rKjwp7khoAg5kJLyCPMOWgvXwuzdo8acM
	uViYCwDectegoiUbv0fOyOGIbHRriPplH+ROLToTDRGJtgByHEF2sFwo6pz6pHkZEgnXOM
	8OtQAvzB2281ieF0n80f85eJ6005BTM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-ShI0PcGIP82kCCjxaRWToA-1; Tue, 17 Sep 2024 06:37:00 -0400
X-MC-Unique: ShI0PcGIP82kCCjxaRWToA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f759688580so29434461fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726569419; x=1727174219;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3gFTZxrNbLxX57z2m6Vx99Y/NavEv7vkvUwLMLsP4k=;
        b=SiT5jPKdi652W6xNc7Feyos2Rpa+envNxhM8RFUQTTIs407JkjebRIXTrxOf1iyAzu
         h9VM0ObxGztWBAf5zgv3Mbq8FGB8WxRjvdbX76FlZjC+lIZ0gb4PRUaPDmZ531124ECV
         BcBWHNj6+n9h91SJOfi8KX/vEnXUj/WxV1l7HT4Tlv12Spt3ecQM932QCZNtRq/qYwAl
         u9BXpAMlUHqszAo/zQ6UqwXX6PqdMb+fBDkaTwi1ekWRCzf6rIWba28fnW/mHVj/aFEM
         /wnJkLZHxaPOyM3GR10naYfxos1XBqtd4rwZF/ngtwUCzvOl0lP3CoAu8ajRx+bxDCC4
         VMfA==
X-Forwarded-Encrypted: i=1; AJvYcCVMX7Y0eh0Zd42uIPaF/1U3X8t95pve1c9ReGG9OsLdEsEPpCc0AYJJ9i2du3/L+XIcYqroJEVCBqp/hzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybLUCPNmak//w8ETkAcN/GMPZDgqgsYKZy6xoiAhhRGeekErAm
	nw8aE8fXjJ0UIwY+41nEYyA9fntPYfWRXZNgZkdzFN4WKL+DSZ6CrJzf9MpA8RZC87Ll9yvQQI+
	5ltRFGi9G2s+nQ6yQGow1t7G9A9O2z3Ca73kScS7+zz5HrTYd4pT9alwCtKVAIg==
X-Received: by 2002:a05:6512:3b91:b0:530:abec:9a23 with SMTP id 2adb3069b0e04-53678fba441mr9537040e87.17.1726569418634;
        Tue, 17 Sep 2024 03:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERPqvDwkXdje8q9/zlcuEo0t6O0Dl0RIarmVntoAa/k/me6Im3qJzXuC1cPR+v/RMBTKRilQ==
X-Received: by 2002:a05:6512:3b91:b0:530:abec:9a23 with SMTP id 2adb3069b0e04-53678fba441mr9537006e87.17.1726569417991;
        Tue, 17 Sep 2024 03:36:57 -0700 (PDT)
Received: from [192.168.55.136] (tmo-067-108.customers.d1-online.com. [80.187.67.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb4911fsm3548737a12.5.2024.09.17.03.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 03:36:56 -0700 (PDT)
Message-ID: <51dd74c3-5da9-4ea0-8298-3ac843c6a843@redhat.com>
Date: Tue, 17 Sep 2024 12:36:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH 1/2] hugetlb: arm64: add mte support
To: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org, muchun.song@linux.dev, akpm@linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240913183404.3517556-1-yang@os.amperecomputing.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240913183404.3517556-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.09.24 20:34, Yang Shi wrote:
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
>   arch/arm64/include/asm/hugetlb.h |  8 ++++
>   arch/arm64/include/asm/mman.h    |  3 +-
>   arch/arm64/include/asm/mte.h     | 67 ++++++++++++++++++++++++++++++++
>   arch/arm64/kernel/hibernate.c    |  6 +++
>   arch/arm64/kernel/mte.c          | 27 ++++++++++++-
>   arch/arm64/kvm/guest.c           | 16 ++++++--
>   arch/arm64/kvm/mmu.c             | 11 ++++++
>   arch/arm64/mm/copypage.c         | 27 ++++++++++++-
>   fs/hugetlbfs/inode.c             |  2 +-
>   9 files changed, 159 insertions(+), 8 deletions(-)
> 
> v5: * Indentation fix and renaming per Catalin.
> v4: * Fixed the comment from David.
> v3: * Fixed the build error when !CONFIG_ARM64_MTE.
>      * Incorporated the comment from David to have hugetlb folio
>        specific APIs for manipulating the page flags.
>      * Don't assume the first page is the head page since huge page copy
>        can start from any subpage.
> v2: * Reimplemented the patch to fix the comments from Catalin.
>      * Added test cases (patch #2) per Catalin.
> 
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 293f880865e8..c6dff3e69539 100644
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
> @@ -21,6 +22,13 @@ extern bool arch_hugetlb_migration_supported(struct hstate *h);
>   static inline void arch_clear_hugetlb_flags(struct folio *folio)
>   {
>   	clear_bit(PG_dcache_clean, &folio->flags);
> +
> +#ifdef CONFIG_ARM64_MTE
> +	if (system_supports_mte()) {
> +		clear_bit(PG_mte_tagged, &folio->flags);
> +		clear_bit(PG_mte_lock, &folio->flags);
> +	}
> +#endif
>   }
>   #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
>   
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index 5966ee4a6154..304dfc499e68 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -28,7 +28,8 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
>   	 * backed by tags-capable memory. The vm_flags may be overridden by a
>   	 * filesystem supporting MTE (RAM-based).
>   	 */
> -	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
> +	if (system_supports_mte() &&
> +	    (flags & (MAP_ANONYMOUS | MAP_HUGETLB)))
>   		return VM_MTE_ALLOWED;
>   
>   	return 0;
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 0f84518632b4..03dc43636aba 100644
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
> @@ -157,6 +163,67 @@ static inline int mte_ptrace_copy_tags(struct task_struct *child,
>   
>   #endif /* CONFIG_ARM64_MTE */
>   
> +#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_ARM64_MTE)
> +static inline void folio_set_hugetlb_mte_tagged(struct folio *folio)
> +{
> +	VM_WARN_ON_ONCE(!folio_test_hugetlb(folio));
> +
> +	/*
> +	 * Ensure that the tags written prior to this function are visible
> +	 * before the folio flags update.
> +	 */
> +	smp_wmb();
> +	set_bit(PG_mte_tagged, &folio->flags);
> +
> +}
> +
> +static inline bool folio_test_hugetlb_mte_tagged(struct folio *folio)
> +{
> +	VM_WARN_ON_ONCE(!folio_test_hugetlb(folio));
> +
> +	bool ret = test_bit(PG_mte_tagged, &folio->flags);

Nit: VM_WARN_ should come after "bool ret" ...

> +
> +	/*
> +	 * If the folio is tagged, ensure ordering with a likely subsequent
> +	 * read of the tags.
> +	 */
> +	if (ret)
> +		smp_rmb();
> +	return ret;
> +}
> +

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


