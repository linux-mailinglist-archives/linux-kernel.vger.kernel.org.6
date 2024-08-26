Return-Path: <linux-kernel+bounces-301762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B1895F53B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158641F216E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4853E193061;
	Mon, 26 Aug 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKVKhWXH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277D3C17
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686570; cv=none; b=pFntFZmsmC1xnzyPg6a3Rdljv7GLGSxQxhCJA19Uszxv98gMz8pOWa/oRsMYEclcL5OqxufNGJMKG5xA3tXx3+83Ia++nWfNwfgifzxKCqG0CY0KdCwNBDODMqQlVygwjXvP9kFmp5J3HRuh0ub+ae3mVs0GkGdmlBM5NQ9cZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686570; c=relaxed/simple;
	bh=Ul1Bom9UwcbRxnnItH93xcNf283MQTpJap9H12O/nIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4g+qVaxLYeSNX52izSMS5tUSMZ2JkWuuwSpqvr9TzcVqv2hHFZTMFH4VMc3tAHaj3uxrwqbOWaRMnWX8M2nyh0MteTUjondSJH0EJKXjbGqbSQJN518oWmtBqcO8k/oQz0tza6epQ2cIIMz0HIn298GT7bxRyEqpfaNWT0cE7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKVKhWXH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724686567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cESSHXskD+sJaZuUdSBNbOIwRU9Ta6x+vqFCdK1xES8=;
	b=TKVKhWXHz0sQK+VMuJ7S14Wnp+MYR4sez8jRsth5Pk7ORLbl8YU4eb51S2lSwrKQq7tab8
	VNjQo1J0Sl3Qgvqy3RCAAZrL6xiJadd0eY9t/aeoD49x5cLYjW4igZaXE6rLwkg9qx+x+R
	LGmN8inwHLi7hT/A6f6Rm0uSa2Z7Dxg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-tTzmeWlmNaOfK2zd8Eb67Q-1; Mon, 26 Aug 2024 11:36:06 -0400
X-MC-Unique: tTzmeWlmNaOfK2zd8Eb67Q-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-533406f2970so4752911e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724686565; x=1725291365;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cESSHXskD+sJaZuUdSBNbOIwRU9Ta6x+vqFCdK1xES8=;
        b=aaLWxj6z3nruIWtMUPx8V8jQPZuGSuDmO4aDL0gRqsVuZnqESmrhggWOcze03J7B4s
         ChtVA27kitxPfVCl5RbUgibakZQl6TjQlS9v6py6S7Bvp2WKB9cY59Lvp6jXTGJl0fx0
         /0EcZCDzFZX0vk0wT0uq5bN9VNNavCE09RO9S2uS8vKaFtNjUUn3uWhYtW3BVYMuxi0e
         Zyci5P/6zLE8TUm926n9Y/sHMOIxGuzpZjSAoN3zSmHc+U3v85mjMX2L9WFIs9tQsp8p
         pm99x6Mbh9u1ZlLMOfe4LyDQ6g57aSy6EOzv+GljSS62tjp9ichqPcfCXQw//OHUDqa3
         oZVA==
X-Gm-Message-State: AOJu0YytjGfEVUQKVbzTQ07Lp2gLBxciOuRw8ajfCb9bmDmEw3NB6vth
	74yeYxvCFYk0QMqKOnfapn5BL15s75lpv6Y2zE6Ds9tDL9f5LagZlG4cu96IaqnBNFugLzcYoxB
	8IaRAPRTsURdtwOuI5Z1/S8c42Z80qfgv9RgbEwsotgujhdYH6QRR+6kz4VWjbQ==
X-Received: by 2002:a05:6512:10d6:b0:533:44e7:1b1a with SMTP id 2adb3069b0e04-5343877a8d9mr6634915e87.17.1724686564875;
        Mon, 26 Aug 2024 08:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLKIdG1QGRZKHQzLqypoACO2tglz779OzDLGfOoDxl4cCYZ/EqNiXufYNBYiqr6Gj/OyhEXw==
X-Received: by 2002:a05:6512:10d6:b0:533:44e7:1b1a with SMTP id 2adb3069b0e04-5343877a8d9mr6634868e87.17.1724686563811;
        Mon, 26 Aug 2024 08:36:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:1900:16b0:8dc:77e:31af? (p200300cbc737190016b008dc077e31af.dip0.t-ipconnect.de. [2003:cb:c737:1900:16b0:8dc:77e:31af])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea360a9sm1500768e87.63.2024.08.26.08.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 08:36:03 -0700 (PDT)
Message-ID: <ea518cf0-890d-4292-b775-dd3880c85bc6@redhat.com>
Date: Mon, 26 Aug 2024 17:36:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] mm: handle_pte_fault() use
 pte_offset_map_rw_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>, hughd@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <5acabedfae7ded01b075960b4a91f2e15b4d76b5.1724310149.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5acabedfae7ded01b075960b4a91f2e15b4d76b5.1724310149.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.24 09:13, Qi Zheng wrote:
> In handle_pte_fault(), we may modify the vmf->pte after acquiring the
> vmf->ptl, so convert it to using pte_offset_map_rw_nolock(). But since we
> will do the pte_same() check, so there is no need to get pmdval to do
> pmd_same() check, just pass a dummy variable to it.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   mm/memory.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 93c0c25433d02..7b6071a0e21e2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5499,14 +5499,22 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>   		vmf->pte = NULL;
>   		vmf->flags &= ~FAULT_FLAG_ORIG_PTE_VALID;
>   	} else {
> +		pmd_t dummy_pmdval;
> +
>   		/*
>   		 * A regular pmd is established and it can't morph into a huge
>   		 * pmd by anon khugepaged, since that takes mmap_lock in write
>   		 * mode; but shmem or file collapse to THP could still morph
>   		 * it into a huge pmd: just retry later if so.
> +		 *
> +		 * Use the maywrite version to indicate that vmf->pte will be
> +		 * modified, but since we will use pte_same() to detect the
> +		 * change of the pte entry, there is no need to get pmdval, so
> +		 * just pass a dummy variable to it.
>   		 */
> -		vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
> -						 vmf->address, &vmf->ptl);
> +		vmf->pte = pte_offset_map_rw_nolock(vmf->vma->vm_mm, vmf->pmd,
> +						    vmf->address, &dummy_pmdval,
> +						    &vmf->ptl);
>   		if (unlikely(!vmf->pte))
>   			return 0;
>   		vmf->orig_pte = ptep_get_lockless(vmf->pte);

No I understand why we don't need the PMD val in these cases ... the PTE 
would also be pte_none() at the point the page table is freed, so we 
would detect the change as well.

I do enjoy documenting why we use a dummy value, though. Likely without 
that, new users will just pass NULL and call it a day.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


