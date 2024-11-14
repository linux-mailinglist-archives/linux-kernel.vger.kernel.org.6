Return-Path: <linux-kernel+bounces-408873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E869C848E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811C6285266
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0AE1F6665;
	Thu, 14 Nov 2024 08:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzjcvLZQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EC81F5859
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571499; cv=none; b=h4enmIQ5xIXNTqRGC3u6YhKSywdKB/DG4gHoccL76hLlvV7SRblCQ0EKatikRebvkxtmo3LyV1DJIPq/L0/8orzUmeMyaGAHiAscutVqrSgN0TQnVkzFHDksXPxys6ciF+vWmPZiIZ93J/TUj8asDuQ+lW68jizfAyVNwiQeJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571499; c=relaxed/simple;
	bh=BSEZs0jqW2jHNaGrwpGnWyP5zj3sBEJDm/a2eXySBmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPt8MtCku9C8sgz1n+NSb+cLVu6dJuxWsOpLhS4o4uT2TCK87zqa0rrR6NQtHG3pbQxHd9AsZ1kU9daBeCcBUf3elHhopSRup2NTleWWyD1rgFLGwqb9LUDPuEGh8E4b+n6xYQfkButXtdIMsvQzLtDgPfGYQEBfgWsRhjpT910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UzjcvLZQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731571496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YFn1B25xOIEJVLI0NlbbrKG4fTitKkPbUGmnBKaC+Qc=;
	b=UzjcvLZQYk7fb2GPe1LSxL7lVB4RI9R8dW8lxUWTWT57sFF7/G8+UmFabluQlRYoLxeSGA
	HI99DwKfjW+Ti40OYUgpjR8PkaSoBHR8pLNMP4lC+J5bjfBNauMXnTePob0xzOU1rvaHE0
	JWVxLCLSkrt4Sbbdb006pisI7B2ku/E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-F_Spqot6NnqtiwVO1O5nYQ-1; Thu, 14 Nov 2024 03:04:53 -0500
X-MC-Unique: F_Spqot6NnqtiwVO1O5nYQ-1
X-Mimecast-MFC-AGG-ID: F_Spqot6NnqtiwVO1O5nYQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38218576e86so172436f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731571492; x=1732176292;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YFn1B25xOIEJVLI0NlbbrKG4fTitKkPbUGmnBKaC+Qc=;
        b=X8SuFhWOOdK5cgem5MKI7hAscjXpUOWFACRGAP7En/Hjn/JD+YB8hhRehZ/IEgA74P
         PeEwnlDJo5iK6BYhBkhDEWcnSBBEjyOENDKRyFwv4f55YJaUc4ZSfLD9qRrz7gSVmUUN
         yrHViqJNVWstbktYHVmaCooWkKHj3oaSU9XqDFCu9y7vOdYy6G8IlWtING7M1la+OXVd
         u9NKwAcwLBNn7k7AAZ1GKEDk6TuAQLMBLYA84bBUSF4M7HCanFjzinQR/bcxGG6ejaz3
         vxBfl3t2p0Nm/LBQI717QSAuOKeROCjMnx2nZIMpUipj5tQ51zIDTGtfQ3/F4+AxQmPU
         dhRw==
X-Forwarded-Encrypted: i=1; AJvYcCWwEt06VAQT7UjqB1sHoae6pPe/FAyKkw12+9m7rmnSE0v+mf7ETOY3WdjmCuLaBV7IcRwOU/hedlRTFZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWVztAbjMRSkmFbYQtkAb+pvEMWH8CtYim7uI+kJZFf2kDzkRb
	2BgKEaWWF6uOKms3i0TZoU0Epf/l6W4d9CT0P3+KnZFs6J+t1i4qZBtQLt9wUaeBr17MkVs8eqI
	LnYtbEwasd3t8bxllMa08wo9I4Y6wsCx8aUcT/6lFS6H25lfz9VB9PpuaDCztUA==
X-Received: by 2002:a05:6000:2aa:b0:37c:c9bc:1be6 with SMTP id ffacd0b85a97d-3821402219fmr1933097f8f.16.1731571492630;
        Thu, 14 Nov 2024 00:04:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0bIURVv764qy3SJRXm7S+CYzynemUaMTOSUdVgTWGY9/Cuf/kNHKIbJ4cX8wrDs8zoL1i/g==
X-Received: by 2002:a05:6000:2aa:b0:37c:c9bc:1be6 with SMTP id ffacd0b85a97d-3821402219fmr1933056f8f.16.1731571492180;
        Thu, 14 Nov 2024 00:04:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c715:6600:a077:c7da:3362:6896? (p200300cbc7156600a077c7da33626896.dip0.t-ipconnect.de. [2003:cb:c715:6600:a077:c7da:3362:6896])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da244915sm14393875e9.3.2024.11.14.00.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 00:04:50 -0800 (PST)
Message-ID: <c7eeac93-3619-4443-896f-ef2e02f0bef0@redhat.com>
Date: Thu, 14 Nov 2024 09:04:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] mm: introduce skip_none_ptes()
To: Qi Zheng <zhengqi.arch@bytedance.com>, jannh@google.com,
 hughd@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, akpm@linux-foundation.org, peterx@redhat.com
Cc: mgorman@suse.de, catalin.marinas@arm.com, will@kernel.org,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 x86@kernel.org, lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, zokeefe@google.com, rientjes@google.com
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
 <574bc9b646c87d878a5048edb63698a1f8483e10.1731566457.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <574bc9b646c87d878a5048edb63698a1f8483e10.1731566457.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>   static unsigned long zap_pte_range(struct mmu_gather *tlb,
>   				struct vm_area_struct *vma, pmd_t *pmd,
>   				unsigned long addr, unsigned long end,
> @@ -1682,13 +1704,17 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>   		pte_t ptent = ptep_get(pte);
>   		int max_nr;
>   
> -		nr = 1;
> -		if (pte_none(ptent))
> -			continue;
> -
>   		if (need_resched())
>   			break;
>   
> +		nr = skip_none_ptes(pte, addr, end);
> +		if (nr) {
> +			addr += PAGE_SIZE * nr;
> +			if (addr == end)
> +				break;
> +			pte += nr;
> +		}
> +
>   		max_nr = (end - addr) / PAGE_SIZE;

I dislike calculating max_nr twice, once here and once in skip_non_ptes.

Further, you're missing to update ptent here. If you inline it you can 
avoid another ptep_get().

>   		if (pte_present(ptent)) {
>   			nr = zap_present_ptes(tlb, vma, pte, ptent, max_nr,


-- 
Cheers,

David / dhildenb


