Return-Path: <linux-kernel+bounces-514561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7853BA3588C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE9C188EBC5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D408221D9F;
	Fri, 14 Feb 2025 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daD9jhNL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C289221550
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520723; cv=none; b=PQXznUJ8eXeXz+F0q4jvM3II6F6E7z6WGEz7npMdhP0QXer0rf4n9JgtRxqF0U0tWBHopYbd6zpzri59AGUsRu0rHXmmLHsfm5pE0DOa4DgS/KWSeb+qq+O0U2rBBwtSKuooDd6qLnT/67O6kW3fdfqwoOi2TDn6fHHYiccB+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520723; c=relaxed/simple;
	bh=c83toEbUGxDGViChrV/KOK7NpsU/xF5jHNNacafC6ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYDPRglLDKs8KcAno3J+DjX7g+ugMdyl3WLyFYZG3XhJqELtSOW+Ugph5fA6f1QHUp6XBMiQsuCRIZAi8Di9sUTnV7hitAeBhtfNXiRK81X0gBXXT16hsuXmEzF/nP+X5TrnfdKnlYTf5vYsi6YQK+dexECMqkQT1Sd5zTCeUhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=daD9jhNL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739520720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=svkKqK/BHsrJwB4zl/6h7GqUXx+TvbrSqp2ylJbweyw=;
	b=daD9jhNLTMtR+LSGGpCyVYh4gfMuzzvnEOomo7jEx5FMm19L3vlBV4PEOXmkCxabQs7SZS
	988Sp+g+5Ias0y8faRjF6cF2hS4iHAHVMWkKkJ1S8Ayc1nmZKRvS0qKjteiXZ7/9gMoUys
	Tg7chC9kN4yQU1d4w2cO0DCRlueFkZc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-NsLKR8bCPxmbWZnvbQOHAw-1; Fri, 14 Feb 2025 03:11:59 -0500
X-MC-Unique: NsLKR8bCPxmbWZnvbQOHAw-1
X-Mimecast-MFC-AGG-ID: NsLKR8bCPxmbWZnvbQOHAw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394b2c19ccso14534175e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 00:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739520718; x=1740125518;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=svkKqK/BHsrJwB4zl/6h7GqUXx+TvbrSqp2ylJbweyw=;
        b=YqjKCtZR+cuWiEazR5yZYC2JHYyqjlZJFMIAOqynO2/JZOVqEjaD1KQ5UKmngNQRKK
         LzmvFS3FvgThIE6tclrPh2kZjovQmGsy0IyuoP1Fo2TshXvoVbIhB8aQw2VjJjY237Gd
         bK0ocVWHZCeCU+xYFJt4Vqck8AF60ASJLTPoaKTsqeWAtI6mGelKoVgR+psdxMvACqGt
         YlCr/sPxQNHsdwoOl16DwYGq4z0rCluCg5LjdVEAHZKUY3sOq1qgkIVAhtP/7n6O083i
         bBBd73RmE6exhGzuYoGqnoJVF+0jHvIVrBkDOU71f61b2eEWEH3VtBqDuHcvjNBZFhj3
         0apw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+wVl4fNiuOjTpKcVeGZpZgyWm9oRZBcEGsV3scBk1f07FAd0M7gA1y1Jz40N62C2R6TiFvwX62cFiO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjsWywyr7CJjbdrPUjGAV2dyUHW2QWHc8JiDg0ApPke+GOdpiW
	QIRVEYtcipMr8LHpJwM4SiBi+cxnT0OA6ehGtKfC7I0RqJuHF50xIFkkyqF2I5YkoPhigQgySbK
	LznohzitMymxdGPbyhsCnu+bZSldm420VPP2nnPUFBsi2qt9sF3RxxOFYF2yE9w==
X-Gm-Gg: ASbGncvFmKasHvq1JXYolPq+82eXAhi/DeRuKZ9XneskJ2x6zzTOJ79pUZ6z6kxLXZ9
	sstNM6EZgdE9BFAbABVMxkL/QEqhP+iyTZF0xsT9TtC6poqlCedgkdY8kt+k0fS5jT7t2ZcA8aK
	8MBNVJWt3748SGAXB8j88i51qvcHZoA+eIXL3Tq8pwzpGhD3GAhK0wQGk7aeK/VW1F814eySTEO
	wC2ie9YUbCONn4dviw7F5WRmH9mDUD0sBnnaWofpyJ8P49n7e2on6PM4SsI8ULpZXDiqmH6LVYE
	ncBShzpnUHX3kV1oVsdyS7ueJ90ltlb4Yg==
X-Received: by 2002:a05:600c:458e:b0:434:f4fa:83c4 with SMTP id 5b1f17b1804b1-439601c530amr92220535e9.29.1739520717750;
        Fri, 14 Feb 2025 00:11:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESIpdDMkIV9XZI+zXprC/FkLET0tfjCaeqJLBbz1eYNn1sr4KvPCg+3sfMHk/W96V5Bys/FA==
X-Received: by 2002:a05:600c:458e:b0:434:f4fa:83c4 with SMTP id 5b1f17b1804b1-439601c530amr92220115e9.29.1739520717289;
        Fri, 14 Feb 2025 00:11:57 -0800 (PST)
Received: from [192.168.3.141] (p4ff23654.dip0.t-ipconnect.de. [79.242.54.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915146sm4010991f8f.56.2025.02.14.00.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 00:11:56 -0800 (PST)
Message-ID: <f15bd993-20de-41ae-8631-9ce557cd9d20@redhat.com>
Date: Fri, 14 Feb 2025 09:11:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: pgtable: fix NULL pointer dereference issue
To: Qi Zheng <zhengqi.arch@bytedance.com>, linux@armlinux.org.uk,
 ezra@easyb.ch, hughd@google.com, ryan.roberts@arm.com,
 akpm@linux-foundation.org, muchun.song@linux.dev
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Ezra Buehler
 <ezra.buehler@husqvarnagroup.com>, stable@vger.kernel.org
References: <20250214030349.45524-1-zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250214030349.45524-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.02.25 04:03, Qi Zheng wrote:
> When update_mmu_cache_range() is called by update_mmu_cache(), the vmf
> parameter is NULL, which will cause a NULL pointer dereference issue in
> adjust_pte():
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000030 when read
> Hardware name: Atmel AT91SAM9
> PC is at update_mmu_cache_range+0x1e0/0x278
> LR is at pte_offset_map_rw_nolock+0x18/0x2c
> Call trace:
>   update_mmu_cache_range from remove_migration_pte+0x29c/0x2ec
>   remove_migration_pte from rmap_walk_file+0xcc/0x130
>   rmap_walk_file from remove_migration_ptes+0x90/0xa4
>   remove_migration_ptes from migrate_pages_batch+0x6d4/0x858
>   migrate_pages_batch from migrate_pages+0x188/0x488
>   migrate_pages from compact_zone+0x56c/0x954
>   compact_zone from compact_node+0x90/0xf0
>   compact_node from kcompactd+0x1d4/0x204
>   kcompactd from kthread+0x120/0x12c
>   kthread from ret_from_fork+0x14/0x38
> Exception stack(0xc0d8bfb0 to 0xc0d8bff8)
> 
> To fix it, do not rely on whether 'ptl' is equal to decide whether to hold
> the pte lock, but decide it by whether CONFIG_SPLIT_PTE_PTLOCKS is
> enabled. In addition, if two vmas map to the same PTE page, there is no
> need to hold the pte lock again, otherwise a deadlock will occur. Just add
> the need_lock parameter to let adjust_pte() know this information.
> 
> Reported-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> Closes: https://lore.kernel.org/lkml/CAM1KZSmZ2T_riHvay+7cKEFxoPgeVpHkVFTzVVEQ1BO0cLkHEQ@mail.gmail.com/
> Fixes: fc9c45b71f43 ("arm: adjust_pte() use pte_offset_map_rw_nolock()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
> Changes in v2:
>   - change Ezra's email address (Ezra Buehler)
>   - some cleanups (David Hildenbrand)
> 
>   arch/arm/mm/fault-armv.c | 38 ++++++++++++++++++++++++++------------
>   1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
> index 2bec87c3327d2..ea4c4e15f0d31 100644
> --- a/arch/arm/mm/fault-armv.c
> +++ b/arch/arm/mm/fault-armv.c
> @@ -62,7 +62,7 @@ static int do_adjust_pte(struct vm_area_struct *vma, unsigned long address,
>   }
>   
>   static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
> -		      unsigned long pfn, struct vm_fault *vmf)
> +		      unsigned long pfn, bool need_lock)
>   {
>   	spinlock_t *ptl;
>   	pgd_t *pgd;
> @@ -99,12 +99,11 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
>   	if (!pte)
>   		return 0;
>   
> -	/*
> -	 * If we are using split PTE locks, then we need to take the page
> -	 * lock here.  Otherwise we are using shared mm->page_table_lock
> -	 * which is already locked, thus cannot take it.
> -	 */
> -	if (ptl != vmf->ptl) {
> +	if (need_lock) {
> +		/*
> +		 * Use nested version here to indicate that we are already
> +		 * holding one similar spinlock.
> +		 */
>   		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>   		if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
>   			pte_unmap_unlock(pte, ptl);
> @@ -114,7 +113,7 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
>   
>   	ret = do_adjust_pte(vma, address, pfn, pte);
>   
> -	if (ptl != vmf->ptl)
> +	if (need_lock)
>   		spin_unlock(ptl);
>   	pte_unmap(pte);
>   
> @@ -123,16 +122,18 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
>   
>   static void
>   make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
> -	      unsigned long addr, pte_t *ptep, unsigned long pfn,
> -	      struct vm_fault *vmf)
> +	      unsigned long addr, pte_t *ptep, unsigned long pfn)
>   {
>   	struct mm_struct *mm = vma->vm_mm;
>   	struct vm_area_struct *mpnt;
>   	unsigned long offset;
> +	unsigned long pmd_start_addr, pmd_end_addr;

Nit: reverse christmas tree would make us put this line at the very top.

Maybe do the initialization directly:

const unsigned long pmd_start_addr = ALIGN_DOWN(addr, PMD_SIZE);
const unsigned long pmd_end_addr = pmd_start_addr + PMD_SIZE;

>   	pgoff_t pgoff;
>   	int aliases = 0;
>   
>   	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +	pmd_start_addr = ALIGN_DOWN(addr, PMD_SIZE);
> +	pmd_end_addr = pmd_start_addr + PMD_SIZE;
>   
>   	/*
>   	 * If we have any shared mappings that are in the same mm
> @@ -141,6 +142,14 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
>   	 */
>   	flush_dcache_mmap_lock(mapping);
>   	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
> +		/*
> +		 * If we are using split PTE locks, then we need to take the pte
> +		 * lock. Otherwise we are using shared mm->page_table_lock which
> +		 * is already locked, thus cannot take it.
> +		 */
> +		bool need_lock = IS_ENABLED(CONFIG_SPLIT_PTE_PTLOCKS);
> +		unsigned long mpnt_addr;
> +
>   		/*
>   		 * If this VMA is not in our MM, we can ignore it.
>   		 * Note that we intentionally mask out the VMA
> @@ -151,7 +160,12 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
>   		if (!(mpnt->vm_flags & VM_MAYSHARE))
>   			continue;
>   		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
> -		aliases += adjust_pte(mpnt, mpnt->vm_start + offset, pfn, vmf);
> +		mpnt_addr = mpnt->vm_start + offset;
> +
> +		/* Avoid deadlocks by not grabbing the same PTE lock again. */
> +		if (mpnt_addr >= pmd_start_addr && mpnt_addr < pmd_end_addr)
> +			need_lock = false;
> +		aliases += adjust_pte(mpnt, mpnt_addr, pfn, need_lock);
>   	}
>   	flush_dcache_mmap_unlock(mapping);
>   	if (aliases)
> @@ -194,7 +208,7 @@ void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
>   		__flush_dcache_folio(mapping, folio);
>   	if (mapping) {
>   		if (cache_is_vivt())
> -			make_coherent(mapping, vma, addr, ptep, pfn, vmf);
> +			make_coherent(mapping, vma, addr, ptep, pfn);
>   		else if (vma->vm_flags & VM_EXEC)
>   			__flush_icache_all();
>   	}


Apart from that LGTM. Hoping it will work :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


