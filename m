Return-Path: <linux-kernel+bounces-198826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 504158D7DFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63251F210CE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33414495CC;
	Mon,  3 Jun 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wrv08K3J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DFA208A1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405328; cv=none; b=LBGQFdizXbMRhjjw0ey8yvZC7yHC7RZeVCRUxr/OvJgmOmmDfoPXrjYo7owyLvc1qDZhcwSGDLhUw5GIqB+gDUPhxfTD66gLjRPhEJ+pWTSFE3yrAbZrzoaGzcfOmlpSud67YJzRckXYMEbxO2KYkZD/sy/Afj0Vbefo9hwl5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405328; c=relaxed/simple;
	bh=KWL0BtQ8j+MmMykyyg8LoAW+giPodH52CjW6HlBWN3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nih68Pe+f+wfXtCgP72ET8osRtfq3qLDkufjsr690PRVq8VCm2rwHkclYq1ipCm0zCnF4Q1qyadCTkwn9ggNZFdCkuizRqUs5Aw8CYhjwWl39LZCaY5uqMK66ExMuDhYFogJsmjRkt9jGI94uy45WNZNlDT2bU6w+CNSf0n2jZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wrv08K3J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717405325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bmTmMvr+U8qc00Vmbs+9KWLbWZXFCT9/Yo6SuG4AdTQ=;
	b=Wrv08K3JRmIcYBk4GolbqejXhc0IR8RQwoVTG+9be4P2prFXYK/L0O9g4rTA47dNdebIQ6
	8DtJnXVP5odepDFClljLPVQPxhfHIT9xh7BRvr2REnPUcIQFfejRd1EQdSCmQtT8lkXvEv
	y5XpwGkn4Phadwl9lFpv83AuSjnJpj4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-xGa1USaWMFm-wo8xJr28Xw-1; Mon, 03 Jun 2024 05:02:03 -0400
X-MC-Unique: xGa1USaWMFm-wo8xJr28Xw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35dcb90989eso2620079f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 02:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717405322; x=1718010122;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bmTmMvr+U8qc00Vmbs+9KWLbWZXFCT9/Yo6SuG4AdTQ=;
        b=JKCgclEGntv7s1f+AGZQsiJ2ES//cdQd4Idjcim/H+m8Ay13/ltd9BzsQpCvJVdqtM
         AY48XFJ7AJVC22wg/pKti4tVvnNzh7mmSNrm2CuyZ+gIBXXiD42zCI7dzbVwPSKr7KHu
         3LA71Ma20IEMbQJRTAYMUwD1fx/gSaLTReNi88s9IjUppGV6Nxwsn282npqluvPIQ15G
         T+5B4/TlHoT+WPHqsNbA4NjQwGP/rL+Vau3fn8kSJFT1HZ79Q8RvZlaOo0f3nUYAElGh
         qIBByW+rKy4NxJM1giBhzZmqhhmQs9gM/Wi7QsFBt21tFiAItAWTDlIViNUjyeQaJgEr
         5GCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNnLVz8Xk4n6WW3Ilj2GZWfnbgUyAeRRFaOI0jJixIPrunCAmvurcH0xGbWHjHF6LX15JzRQFdeH0I59xZ0nT/yjxkslo2ZmLGayUh
X-Gm-Message-State: AOJu0YzS9qrG+zTCkJ5vWjhF4RRoJQRSZXU1dZb/9eyZV/MMCHymGUE/
	8ryMBO9II2CPKVJ4BtiSPC5f5pBKDBmpsljmbFGkW2J9IADUyphzcHKlpFH+KIzNndcpv/JK8Gd
	CQ3ze9blaFovP7icZ0ot6hpz26qD3kYO+MEPkRfpUAR+PqSZ0sxnXjyIhw6A0GQ==
X-Received: by 2002:adf:ea11:0:b0:354:f2b0:ebd6 with SMTP id ffacd0b85a97d-35e0f25e2b9mr5591197f8f.9.1717405322334;
        Mon, 03 Jun 2024 02:02:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQYyurIt9bKIhqYuctRks+Cmy/gNrUFKPJUqVLgUIXC3BXWTTi8q+Bt0ARepojw3r2zdN3Cw==
X-Received: by 2002:adf:ea11:0:b0:354:f2b0:ebd6 with SMTP id ffacd0b85a97d-35e0f25e2b9mr5591168f8f.9.1717405321811;
        Mon, 03 Jun 2024 02:02:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c731:3d00:918f:ce94:4280:80f0? (p200300cbc7313d00918fce94428080f0.dip0.t-ipconnect.de. [2003:cb:c731:3d00:918f:ce94:4280:80f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e0f97ba3csm7719440f8f.73.2024.06.03.02.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 02:02:01 -0700 (PDT)
Message-ID: <baf84b51-7e8a-4da8-9662-3f5cf14ad6f6@redhat.com>
Date: Mon, 3 Jun 2024 11:01:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: swap: reuse exclusive folio directly instead of wp
 page faults
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chrisl@kernel.org, kasong@tencent.com, linux-kernel@vger.kernel.org,
 minchan@kernel.org, ryan.roberts@arm.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org
References: <20240602004502.26895-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240602004502.26895-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.06.24 02:45, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> After swapping out, we perform a swap-in operation. If we first read
> and then write, we encounter a major fault in do_swap_page for reading,
> along with additional minor faults in do_wp_page for writing. However,
> the latter appears to be unnecessary and inefficient. Instead, we can
> directly reuse in do_swap_page and completely eliminate the need for
> do_wp_page.
> 
> This patch achieves that optimization specifically for exclusive folios.
> The following microbenchmark demonstrates the significant reduction in
> minor faults.
> 
>   #define DATA_SIZE (2UL * 1024 * 1024)
>   #define PAGE_SIZE (4UL * 1024)
> 
>   static void *read_write_data(char *addr)
>   {
>           char tmp;
> 
>           for (int i = 0; i < DATA_SIZE; i += PAGE_SIZE) {
>                   tmp = *(volatile char *)(addr + i);
>                   *(volatile char *)(addr + i) = tmp;
>           }
>   }
> 
>   int main(int argc, char **argv)
>   {
>           struct rusage ru;
> 
>           char *addr = mmap(NULL, DATA_SIZE, PROT_READ | PROT_WRITE,
>                           MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>           memset(addr, 0x11, DATA_SIZE);
> 
>           do {
>                   long old_ru_minflt, old_ru_majflt;
>                   long new_ru_minflt, new_ru_majflt;
> 
>                   madvise(addr, DATA_SIZE, MADV_PAGEOUT);
> 
>                   getrusage(RUSAGE_SELF, &ru);
>                   old_ru_minflt = ru.ru_minflt;
>                   old_ru_majflt = ru.ru_majflt;
> 
>                   read_write_data(addr);
>                   getrusage(RUSAGE_SELF, &ru);
>                   new_ru_minflt = ru.ru_minflt;
>                   new_ru_majflt = ru.ru_majflt;
> 
>                   printf("minor faults:%ld major faults:%ld\n",
>                           new_ru_minflt - old_ru_minflt,
>                           new_ru_majflt - old_ru_majflt);
>           } while(0);
> 
>           return 0;
>   }
> 
> w/o patch,
> / # ~/a.out
> minor faults:512 major faults:512
> 
> w/ patch,
> / # ~/a.out
> minor faults:0 major faults:512
> 
> Minor faults decrease to 0!
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   -v2:
>   * don't set the dirty flag for read fault, per David;
>   * make write-protect of uffd_wp clear and remove confusion(
>     it used to be "wrprotected->writable->wrprotected"), per
>     David;
>   Thank you for reviewing, David.
> 
>   -v1:
>   https://lore.kernel.org/linux-mm/20240531104819.140218-1-21cnbao@gmail.com/
> 
>   mm/memory.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index eef4e482c0c2..9696c7397b85 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4316,6 +4316,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
>   	add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
>   	pte = mk_pte(page, vma->vm_page_prot);
> +	if (pte_swp_soft_dirty(vmf->orig_pte))
> +		pte = pte_mksoft_dirty(pte);
> +	if (pte_swp_uffd_wp(vmf->orig_pte))
> +		pte = pte_mkuffd_wp(pte);
>   
>   	/*
>   	 * Same logic as in do_wp_page(); however, optimize for pages that are
> @@ -4325,18 +4329,18 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	 */
>   	if (!folio_test_ksm(folio) &&
>   	    (exclusive || folio_ref_count(folio) == 1)) {
> -		if (vmf->flags & FAULT_FLAG_WRITE) {
> -			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
> -			vmf->flags &= ~FAULT_FLAG_WRITE;
> +		if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
> +		    !vma_soft_dirty_enabled(vma)) {
> +			pte = pte_mkwrite(pte, vma);
> +			if (vmf->flags & FAULT_FLAG_WRITE) {
> +				pte = pte_mkdirty(pte);
> +				vmf->flags &= ~FAULT_FLAG_WRITE;
> +			}
>   		}
>   		rmap_flags |= RMAP_EXCLUSIVE;
>   	}
>   	folio_ref_add(folio, nr_pages - 1);
>   	flush_icache_pages(vma, page, nr_pages);
> -	if (pte_swp_soft_dirty(vmf->orig_pte))
> -		pte = pte_mksoft_dirty(pte);
> -	if (pte_swp_uffd_wp(vmf->orig_pte))
> -		pte = pte_mkuffd_wp(pte);
>   	vmf->orig_pte = pte_advance_pfn(pte, page_idx);
>   
>   	/* ksm created a completely new copy */

Thanks, LGTM!

Acked-by: David Hildenbrand <david@redhat.com>

Maybe we really want (likely with better naming)

soft_dirty_pte(vma, pte)
soft_dirty_pte(vma, pmd)

that wrap the VMA+pte check, like we have for uffd-wp.

$ git grep vma_soft_dirty | grep -E "(pmd)|(pte)"
mm/gup.c:       if (vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd))
mm/gup.c:       if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
mm/huge_memory.c:       if (vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd))
mm/mprotect.c:  if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))

... then we could simply use the one here as well.

-- 
Cheers,

David / dhildenb


