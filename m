Return-Path: <linux-kernel+bounces-196713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBCF8D604C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1141F22F60
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AC8156F5D;
	Fri, 31 May 2024 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiJvRdf/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEEF153BC1
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717153719; cv=none; b=vAkPK5jAQNwBaL6NJVX9gXfrk1binuE26lStiuoE7VacnK8vhiFvxWExAlGqqVVTmwQhOrT4nFjjPrB9PyO7ErXGbs5I8Do3zx0Krdq8RqHvGSAuGjluWPIxJ0lfWUyvYZ+f2pEkudXjSl+J4H2Ks9OLp7kQ5522WrcN0aaw/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717153719; c=relaxed/simple;
	bh=ZfBAd4HwC8+gLE7r7qXKSawruQOUGExdfcKlnrjj5c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q79YR9m0yyHJ0qrB+9Ff/6J5urExYuXWfesWnHy4mL+O+IJs3PC8Fbpyni5L3V3zrErpYbIZxpI6QGfc7ayX48cwKGYzazHN6xr0z4tKk/lpzQ+yz8SnzdXbeyTwkzY/8NV59jk74pT0pE5nEsiSG1vJra7vkCGS8Lp0y1no9kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IiJvRdf/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717153716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OYoUNSJcRNBkUzk1A7IW+hjzLjxRnoh5JSUxpMkjxqM=;
	b=IiJvRdf/1NACTIAja68maE4rcpwwgoJZyu7pJjPGjSNJyVe3kE9lJNexnwedZRN2iaxTei
	mlQAN51q5tdeLqv1ZL2wGXC4G2wGyIWY/8V8eWqkBfwgTVRPfY3eIVm8WEsshSPB2Ss0Or
	Girh8erQ4Rt2sFnyJkkrW1mkFnEL9gI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-KUy71oblOECbecuX60Ov8w-1; Fri, 31 May 2024 07:08:35 -0400
X-MC-Unique: KUy71oblOECbecuX60Ov8w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-354fa62abd7so668633f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 04:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717153714; x=1717758514;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYoUNSJcRNBkUzk1A7IW+hjzLjxRnoh5JSUxpMkjxqM=;
        b=mz8pkb0qVXldv8J8cT7IkV2ecm7UHvyLS0e9WCP5FYSSnMbq9a/yKeTMAf2lFBMIaZ
         WMYkN2jYhJkrJCYR0sBrFk1lMquoitVlUZ0lJrupqnwEntGNH3MAKfXphMsDI9oeutb0
         54Nv6JZnoRh5qmbRW/VoDS2Es+vuyGd8HW8SyJzoMLRBtEwLFZGnJ9T47qCcjiI1o/ba
         EdfM4o3vGa59llQI1RznmVMMrEbZKd8VxpJeC0QAqBcPjjWCgHrp9Rs2ZzU+fxpGFSWA
         u6z4/MNb+wvx/4OZklupZBvf8v3n1nnRDUI9yUjJc44aQ7RGwGhVvIsF6zwMWeee0bAL
         YNvw==
X-Forwarded-Encrypted: i=1; AJvYcCWn1e9qyNzO89Eae1Qb/Xr1NduTO6qZUa75HvEP/IeWCQeFYx6RYC9x3x0pECvGitO3qKrFdH/3Be5DHkPxl5bYfPDbJzE20adebWvt
X-Gm-Message-State: AOJu0YwXY15cZheXjYdWroD5r2sx7nC9zVPfS194rvEu5m8pqjDxTf3F
	x6cxQtDimHYe/OLEb87acIerruT/AdLYLBBiCW6mgX2VYsPRZBhveKtEHpwtYBBO6eZB2UyYDzY
	S1IJ+XFzqDFhz+hOF7uUVtw81LxiQN3lWmrNDcPn2+qD/Ld8y1zMUu3yxhO7VQA==
X-Received: by 2002:a05:6000:1e94:b0:359:733c:c8d6 with SMTP id ffacd0b85a97d-35e0f33fe46mr1036815f8f.67.1717153713800;
        Fri, 31 May 2024 04:08:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyPtjGaZZ+iE6bdelI20SNufhYgMVEAUA1ZaYY1ludVUASoY25uwdI6BrAId7k3vkY8716Kg==
X-Received: by 2002:a05:6000:1e94:b0:359:733c:c8d6 with SMTP id ffacd0b85a97d-35e0f33fe46mr1036791f8f.67.1717153713290;
        Fri, 31 May 2024 04:08:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:a000:d4df:4b8f:37d4:59e4? (p200300cbc717a000d4df4b8f37d459e4.dip0.t-ipconnect.de. [2003:cb:c717:a000:d4df:4b8f:37d4:59e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd062eba2sm1610511f8f.77.2024.05.31.04.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 04:08:32 -0700 (PDT)
Message-ID: <87ac9610-5650-451f-aa54-e634a6310af4@redhat.com>
Date: Fri, 31 May 2024 13:08:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: swap: reuse exclusive folio directly instead of
 wp page faults
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chrisl@kernel.org, surenb@google.com, kasong@tencent.com,
 minchan@kernel.org, willy@infradead.org, ryan.roberts@arm.com,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
References: <20240531104819.140218-1-21cnbao@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240531104819.140218-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.05.24 12:48, Barry Song wrote:
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
>   mm/memory.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index eef4e482c0c2..e1d2e339958e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4325,9 +4325,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	 */
>   	if (!folio_test_ksm(folio) &&
>   	    (exclusive || folio_ref_count(folio) == 1)) {
> -		if (vmf->flags & FAULT_FLAG_WRITE) {
> -			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
> -			vmf->flags &= ~FAULT_FLAG_WRITE;
> +		if (vma->vm_flags & VM_WRITE) {
> +			pte = pte_mkwrite(pte_mkdirty(pte), vma);
> +			if (vmf->flags & FAULT_FLAG_WRITE)
> +				vmf->flags &= ~FAULT_FLAG_WRITE;

This implies, that even on a read fault, you would mark the pte dirty 
and it would have to be written back to swap if still in the swap cache 
and only read.

That is controversial.

What is less controversial is doing what mprotect() via 
change_pte_range()/can_change_pte_writable() would do: mark the PTE 
writable but not dirty.

I suggest setting the pte only dirty if FAULT_FLAG_WRITE is set.

-- 
Cheers,

David / dhildenb


