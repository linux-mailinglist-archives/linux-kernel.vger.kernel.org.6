Return-Path: <linux-kernel+bounces-280931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFA094D11A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CA71C215AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E3F194C6E;
	Fri,  9 Aug 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Loxum/kw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C52F37
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209689; cv=none; b=dybDliV82BL672yiuaI9NLWrh1MHpU/3OzO00uJuFvRXgw9Ii8HEbDQGeVgeBsp0pAhgsD5FjLqMvpSWVWTtxjUxr9vBuYEMm4CfSusn+fG9BCBp+JkmRJhaCokw1UKuffCYIs5shVfPFS3RWXY2bVBRVpIAfq30pIJRREjfQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209689; c=relaxed/simple;
	bh=aBB6jiDebJjYb4fF3MQ/LSGBIu7rGq3yDeyMlpI0aFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLBI93ESa9+1BdKfCsfxfFVjWoYoaxYtLGGAOap3SrBrGV4Z5isMz3PnaK3CVrgjsBB/lFcy4U6HU1axd6XNuwUtbwpOaI1ecBb8/i9nCrBOmoe9hdVvpMWXXJdcIq8PsD0wig/Gjl1HUeivbkqusbsEk5wnyBvDNQUvzUWFzY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Loxum/kw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723209686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iIbP/V1brlbQvL5M/hSArTJBCUNJ+OODqF9d1S+I4w0=;
	b=Loxum/kw7DTFttgvyNUlbFqPLnqkRFpV57O7K2NMvQAK2fTOjRfiT1u5opLpGtwLfICquH
	uatXphDBUJBhsfhMBeSqnsre9o8YiQKN+NdrpZ5mpg2LqPOUbQ1bSGU6jQv/rVfnFf07Up
	ky4k/ScAmRJssJngyylv9Ir2anWHDxM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-HtXlYmHQOrCs4ogChL6WSQ-1; Fri, 09 Aug 2024 09:21:24 -0400
X-MC-Unique: HtXlYmHQOrCs4ogChL6WSQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3687a1a6846so1137205f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209683; x=1723814483;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iIbP/V1brlbQvL5M/hSArTJBCUNJ+OODqF9d1S+I4w0=;
        b=YlDzSecAEsNDMNX1ypzxGyl1LXEzRluhWuXbCx1aVuX5Y48ypVFCLeVkujEjic5rif
         jsdjY1245QQxtJhvmKe/ib51MWwnulNgUFrNrwpOs7BAWMKx8S2Dsw+bUPDBtxpwPrW2
         7rbbA60RYeZ2bOxtsDJ48swbTWRgD/mi7GyBDAwnY0ncKu61sdr7G01HFaTRfRh/8MOs
         yK+qJxoxz+hcugefTJRbs6TjTWCyXCUsu/4A8uMZISOLpMSktyrG9AGWmELS0PjBg25I
         8j+Oa7rHYD1jD3QcMZu/2X4WcE1N6MGxybNyOujLgmOrDlU2Cuvaw14S2yWsalrLLqUb
         N57A==
X-Forwarded-Encrypted: i=1; AJvYcCXkYvv12rjLUn/Vk4TsgUjkqEwA8lh3x6k33U5znGAPmPF2P0ocJWWVl2D6Zto/PAJLYp2vpxmjMy8dj3zk7hmtW5KuDEttMuQ/H3kM
X-Gm-Message-State: AOJu0Yx2In5C1qaxekEu6Iy/hyogSUcDNXY9e28gMgtokB0gSdYKcf7w
	U4K0/6m+aUCQ6mqC7sK8xtc9QXNVvqaAGWzmCZGFzq8YgYkzAWVaSmPKxaZQrZpNWAD34QDfU2k
	M1pV1f5BWEjelDrjpHEWE6tnv9M4VfZSXuk476dH5yCIGw/aP2mC4n1SKMOrUIA==
X-Received: by 2002:a5d:438e:0:b0:36b:a5aa:6038 with SMTP id ffacd0b85a97d-36d5dd8f894mr1069958f8f.9.1723209683612;
        Fri, 09 Aug 2024 06:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrhSrDFlPuyqM3AoBTzUBZDWMN7a2jqJM69uxK1AgrdEyAnELGcyfvPx3iSzKYEI79wuVxdg==
X-Received: by 2002:a5d:438e:0:b0:36b:a5aa:6038 with SMTP id ffacd0b85a97d-36d5dd8f894mr1069924f8f.9.1723209683072;
        Fri, 09 Aug 2024 06:21:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2718c020sm5322998f8f.55.2024.08.09.06.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 06:21:22 -0700 (PDT)
Message-ID: <3f6e1e0a-6132-4222-abb6-133224e11009@redhat.com>
Date: Fri, 9 Aug 2024 15:21:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: split underutilized THPs
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240807134732.3292797-1-usamaarif642@gmail.com>
 <20240807134732.3292797-5-usamaarif642@gmail.com>
 <5adb120e-5408-43a6-b418-33dc17c086f0@redhat.com>
 <c0ed5796-a6a6-4757-b7df-666ba598d9fe@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c0ed5796-a6a6-4757-b7df-666ba598d9fe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.08.24 12:31, Usama Arif wrote:
> 
> 
> On 08/08/2024 16:55, David Hildenbrand wrote:
>> On 07.08.24 15:46, Usama Arif wrote:
>>> This is an attempt to mitigate the issue of running out of memory when THP
>>> is always enabled. During runtime whenever a THP is being faulted in
>>> (__do_huge_pmd_anonymous_page) or collapsed by khugepaged
>>> (collapse_huge_page), the THP is added to  _deferred_list. Whenever memory
>>> reclaim happens in linux, the kernel runs the deferred_split
>>> shrinker which goes through the _deferred_list.
>>>
>>> If the folio was partially mapped, the shrinker attempts to split it.
>>> A new boolean is added to be able to distinguish between partially
>>> mapped folios and others in the deferred_list at split time in
>>> deferred_split_scan. Its needed as __folio_remove_rmap decrements
>>> the folio mapcount elements, hence it won't be possible to distinguish
>>> between partially mapped folios and others in deferred_split_scan
>>> without the boolean.
>>
>> Just so I get this right: Are you saying that we might now add fully mapped folios to the deferred split queue and that's what you want to distinguish?
> 
> Yes
> 
>>
>> If that's the case, then could we use a bit in folio->_flags_1 instead?
> Yes, thats a good idea. Will create the below flag for the next revision
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 5769fe6e4950..5825bd1cf6db 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -189,6 +189,11 @@ enum pageflags {
>   
>   #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
>   
> +enum folioflags_1 {
> +       /* The first 8 bits of folio->_flags_1 are used to keep track of folio order */
> +       FOLIO_PARTIALLY_MAPPED = 8,     /* folio is partially mapped */
> +}

This might be what you want to achieve:

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a0a29bd092f8..d4722ed60ef8 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -182,6 +182,7 @@ enum pageflags {
         /* At least one page in this folio has the hwpoison flag set */
         PG_has_hwpoisoned = PG_active,
         PG_large_rmappable = PG_workingset, /* anon or file-backed */
+       PG_partially_mapped, /* was identified to be partially mapped */
  };
  
  #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
@@ -861,8 +862,9 @@ static inline void ClearPageCompound(struct page *page)
         ClearPageHead(page);
  }
  FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
+FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
  #else
-FOLIO_FLAG_FALSE(large_rmappable)
+FOLIO_FLAG_FALSE(partially_mapped)
  #endif
  
  #define PG_head_mask ((1UL << PG_head))

The downside is an atomic op to set/clear, but it should likely not really matter
(initially, the flag will be clear, and we should only ever set it once when
partially unmapping). If it hurts, we can reconsider.

[...]

>> I would actually suggest to split decoupling of "_deferred_list" and "partially mapped" into a separate preparation patch.
>>
> Yes, will do. I will split it into 3 patches, 1st one that introduces FOLIO_PARTIALLY_MAPPED and sets/clear it in the right place without introducing any functional change, 2nd to split underutilized THPs and 3rd to add sysfs entry to enable/disable the shrinker. Should make the patches quite small and easy to review.


Great! As always, please shout if you disagree with something I propose :)

-- 
Cheers,

David / dhildenb


