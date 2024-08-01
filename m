Return-Path: <linux-kernel+bounces-270744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD689444BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFCC1F22E03
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83DD158555;
	Thu,  1 Aug 2024 06:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZfi5TG/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE4158543
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494976; cv=none; b=QpP1PO6pwYR/FRUuubldk+1/LDaakZQjMQUaXq2uDu65Z4991IQq+jTk6M6C19ofzQdOt8X4FOfiQd9vYbAsvhTzdcifqRhnPLQhsDcu/mFeMOa/FiRXm+rNaGKpGVbry2VY+WlQfdlQqQfHgAChg0F8rsns/1yzvOsvsLnq2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494976; c=relaxed/simple;
	bh=0NUcnVeUAOF7xuFmAc4VvKo/yGebWjMFPHQv2qsmBW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmXvdbA3AlAXmKDyN4CU/IkdBygchHyXAbOBmQLwN0MQGAtnhzLrW4Wa6wuD+77xbHkRxGhySnmgqzugFq0PzjfHvKaWKjUng5y9lhzJEQ+0axXabyPaPV/8bAgQruogJCuB6qHyavR3ufOj+ik+QQjY3aA6zawiIev1dCX9qqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZfi5TG/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722494973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S2NtmIp/4CuiXBD0LbwaFHmPzP6LgL2Oqy8LcjxKKkI=;
	b=UZfi5TG/TEcxQEavMsw6RIc60rmcMn7TqyjLxhjccIFRW9aSF3STQh9OydSEgc9LwfrCnl
	wSdi2FrDooV3JB5m7id7zz61ejbJpPZxNRpdHiclqaqo9mnj9sKqPFQPQYgG2JTRW64qtP
	1ww98uNypvz8MoKxpIvqAuppG1cDT24=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-YvUwR2AeMdq6rDX3CIrY7Q-1; Thu, 01 Aug 2024 02:49:32 -0400
X-MC-Unique: YvUwR2AeMdq6rDX3CIrY7Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3687faecea0so3047263f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722494970; x=1723099770;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S2NtmIp/4CuiXBD0LbwaFHmPzP6LgL2Oqy8LcjxKKkI=;
        b=rTnZ8wnUk76MYaqorKRct7NfUkh6y4dvHaDevXYNzP3oWRifcIBNjgl+hrTFFHBne0
         9loxc2HobndMtZU7SyEiICilLs1Oj6pGNm6xI5tw9R9mdreb+OhndF6tEFF2d/GFvVcK
         YPxmibbJLf/1uRgAKJ3FswF2kEAi7OAfszVxMfs/y5G2PmDfqwkcH8LsofzV6Pn3nqfE
         9gysTRPb8Doie4qMEIUIVeDhMbJbNEZFDbOfXlgeKXIMEAlJ0tv+hknxJ3UeFgQkCYgV
         15UAsEq/RqGSwOzxYeC8W65Irf5wzJIqYGrDr387jqWdcqAB+3XnVmMbnITb/LsFUtng
         RV8g==
X-Forwarded-Encrypted: i=1; AJvYcCVAWLfjTXIrt3eROZ4pg8Doeiw32uZ15Hfezqg6BzMUXFNi9JUoUk3Hopw572VFEtbwVUKeUTQgXXBAxHi6evf+UtEywaRuZK8t1+gx
X-Gm-Message-State: AOJu0YySE2CHa5q05cBmGKFEvD3SRy4rN2aBfKFFB9csgpP3UX1PeSB0
	M4pJ4AhSvWCzoP3BL7RskVpygBzemuZxEW5W83hhIgyuLF+B++h3McitEL66SL99mIS4P/ptUIt
	1Fz7aFxjf7CDwK5AAa/S5PfpZB2YsDAg1pluYCd5/Aa+ZR4MaiSdz2A8cBP+U+g==
X-Received: by 2002:a5d:4ad2:0:b0:367:f13b:ae8c with SMTP id ffacd0b85a97d-36baaf7587dmr760789f8f.47.1722494969942;
        Wed, 31 Jul 2024 23:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpzwZmizh4EyzTYJDbH8miZZukV/0//4Kl+vhqKeiXAb8XuDmeaEzSYjeYH9A66H0Me3EJhw==
X-Received: by 2002:a5d:4ad2:0:b0:367:f13b:ae8c with SMTP id ffacd0b85a97d-36baaf7587dmr760763f8f.47.1722494969434;
        Wed, 31 Jul 2024 23:49:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b3686f73asm18531108f8f.113.2024.07.31.23.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 23:49:29 -0700 (PDT)
Message-ID: <90477952-fde2-41d7-8ff4-2102c45e341d@redhat.com>
Date: Thu, 1 Aug 2024 08:49:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] c0bff412e6: stress-ng.clone.ops_per_sec -2.9%
 regression
To: "Yin, Fengwei" <fengwei.yin@intel.com>,
 kernel test robot <oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Matthew Wilcox <willy@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, WANG Xuerui <kernel@xen0n.name>,
 linux-mm@kvack.org, ying.huang@intel.com, feng.tang@intel.com
References: <202407301049.5051dc19-oliver.sang@intel.com>
 <193e302c-4401-4756-a552-9f1e07ecedcf@redhat.com>
 <439265d8-e71e-41db-8a46-55366fdd334e@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <439265d8-e71e-41db-8a46-55366fdd334e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.24 08:39, Yin, Fengwei wrote:
> Hi David,
> 
> On 7/30/2024 4:11 PM, David Hildenbrand wrote:
>> On 30.07.24 07:00, kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed a -2.9% regression of
>>> stress-ng.clone.ops_per_sec on:
>>
>> Is that test even using hugetlb? Anyhow, this pretty much sounds like
>> noise and can be ignored.
>>
> It's not about hugetlb. It looks like related with the change:

Ah, that makes sense!

> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 888353c209c03..7577fe7debafc 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -1095,7 +1095,12 @@ PAGEFLAG(Isolated, isolated, PF_ANY);
>    static __always_inline int PageAnonExclusive(const struct page *page)
>    {
>           VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
> -       VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
> +       /*
> +        * HugeTLB stores this information on the head page; THP keeps
> it per
> +        * page
> +        */
> +       if (PageHuge(page))
> +               page = compound_head(page);
>           return test_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
> 
> 
> The PageAnonExclusive() function is changed. And the profiling data
> showed it:
> 
>         0.00            +3.9        3.90
> perf-profile.calltrace.cycles-pp.folio_try_dup_anon_rmap_ptes.copy_present_ptes.copy_pte_range.copy_p4d_range.copy_page_range
> 
> According
> https://download.01.org/0day-ci/archive/20240730/202407301049.5051dc19-oliver.sang@intel.com/config-6.9.0-rc4-00197-gc0bff412e67b:
> 	# CONFIG_DEBUG_VM is not set
> So maybe such code change could bring difference?

Yes indeed. fork() can be extremely sensitive to each added instruction.

I even pointed out to Peter why I didn't add the PageHuge check in there 
originally [1].

"Well, and I didn't want to have runtime-hugetlb checks in
PageAnonExclusive code called on certainly-not-hugetlb code paths."


We now have to do a page_folio(page) and then test for hugetlb.

	return folio_test_hugetlb(page_folio(page));

Nowadays, folio_test_hugetlb() will be faster than at c0bff412e6 times, 
so maybe at least part of the overhead is gone.


[1] 
https://lore.kernel.org/r/all/8b0b24bb-3c38-4f27-a2c9-f7d7adc4a115@redhat.com/


-- 
Cheers,

David / dhildenb


