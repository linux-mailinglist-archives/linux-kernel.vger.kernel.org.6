Return-Path: <linux-kernel+bounces-521249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C4FA3B9D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8036D7A16C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695B11DE4E9;
	Wed, 19 Feb 2025 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cT4wwKf+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2901CAA93
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957412; cv=none; b=KWW4ilGAoVHk//ODF6DVu9U8ChunyhBVst3/agnBt/GfQF52Cru1cTHMdp7XNsRTyhPuLlGqDtfUAKuu9ja1CZTFQAF2Ar41HZeDCezpWYjrY+UOc/tupMtfB5nd+EPB0br3pecbaNSRyJTeLhXBgiTagsXr+j8iA5/3QWREQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957412; c=relaxed/simple;
	bh=BwrkMBkfh1SYfD28nSg6SK6f6HVCmlZD6kv6Sm1q4p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LF5ndGJfucIfHiSnQDg13ixk8wHNaV7efELZ96xIWLdcz9uAu5AQIlJ9H9/tU9ViI1LDYNQPcM3Gq/ScZWCR2RiWwmU/7uJvd1IW6i10zH29avTeR7g68f5E60/zaQIbKFkj9iqcz/OvMZx07uMJa/hkZIDhBiGFTsowCbBNpYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cT4wwKf+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739957409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O6iIs/bRi4LNStonXoF+PjfPP76cxf5o1pRHRm2Ecos=;
	b=cT4wwKf+rpUU0wn2RruEF76U1e0fW574P+1KN0TENKUycQ5CqJe/lqLnbOCyBeW1tgi9G+
	CZlccq2vxFcTA39fhj+zo+PCgT43nXy/TMV1YPEpS2KS5DuBWe1OYsfzyJLrTuwx1jysLL
	KkyC7StVdvsuRGR4Ws3c+kcivmey5/o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-3L3s3lGUPT-uhkTLtxLPtA-1; Wed, 19 Feb 2025 04:30:08 -0500
X-MC-Unique: 3L3s3lGUPT-uhkTLtxLPtA-1
X-Mimecast-MFC-AGG-ID: 3L3s3lGUPT-uhkTLtxLPtA_1739957407
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43942e82719so54086315e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:30:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739957407; x=1740562207;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O6iIs/bRi4LNStonXoF+PjfPP76cxf5o1pRHRm2Ecos=;
        b=imkL72cuTgsWqAvnKZ2Z/zmQwu+WVV7Al7dKe/Y9RmhD+xz+cZJKSFDnOd6RWKOjxj
         Xw3oa2M92qdaXj8h/9JDFN1zZX0gu4fiOGxBUUVoBE0ZQQLVEPnNTUpTvzZ8iGT/vx+R
         c0K3KnxtU/c/1U6+JsAjLWq98eIUdwtK3GlZpAxNydM8fh4T6vG1vtmPNzJNTh8xHEqC
         qolr9ZZg1zqeE75/z9sx9tNuqDuZ0OG8Ru95SA4i+4jhk8VJHJOtTVuvBE/fv00Lr5jD
         IOgaiscjrEJx+pmVK7FYaIPzjMv6f/4co1zdSuOsEvLcJ2GcqB7/niANTB18Y7JMbyyk
         gaMA==
X-Forwarded-Encrypted: i=1; AJvYcCXX+KWb+k9SE9prH48c3wDrFf2aheVd0824ZdpJS4xM6x9D5RXIFL52VrXRxdVjoMiR2qxKG5XOXYyNtC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFYfFevf9Fr6f8LFjwdXt1qtLOktXW7YY8s2adSMjMVeYdhf5
	kSKssWJBkK2P9eNYY0U/rob9U7w/PIP0qesbx5Wc/3alXmWgWY/mag8duAY60ccPXSAa/dkWbtK
	QslFyyHbdSKpH64ncwCU237R8kcB7Z3JRtcdWt+4Ykm2okd4XOW+fpMonqvtVZg==
X-Gm-Gg: ASbGncts1SmDw7aDYd9BbFLD9M8mdJLMHDABK7jUo2jvcKALOIq4bU6MX33Mi8iv/Nw
	DF1elx4EGjTW8Ibpp89IqAKPojKHHA6YxdFyUmPTOtA6GMgjPKag9YKMrP1naqX0ScJa+D6i73Y
	3oWuvP01rvF39+zHXnUSwYbRL5iJLXEqOhp4SyyE28jZS9pPQclIERTKtElEXrcKx47S3jIOKs4
	3a3+JSlk9biPTMT4m+MmT9jVoeNypULEgAYCLjhMu8Ge2MJEYicB6Ip18ciBuaCIuRPRtS+1ZAQ
	NAfARb9ya9b3j+bH2X1kCI7RhIzVqJSDDSaa3oMWoSt4M4aLS/jTbsziHEw/aOfsNwD06CErAnL
	oP/HXqxj83QSnLJaunUrGq1A7srbzZpcT
X-Received: by 2002:a05:600c:350b:b0:439:30bd:7df9 with SMTP id 5b1f17b1804b1-43999d8de25mr23617525e9.9.1739957406836;
        Wed, 19 Feb 2025 01:30:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGcnkciXYFZBMbQtiqRGmrfj7AGbzSt3LRKWsRgsBPbNWJxOgzptCl2hNOgyjgZkRalfiXnQ==
X-Received: by 2002:a05:600c:350b:b0:439:30bd:7df9 with SMTP id 5b1f17b1804b1-43999d8de25mr23617315e9.9.1739957406478;
        Wed, 19 Feb 2025 01:30:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c712:8400:50d0:d1c1:90d6:e2e0? (p200300cbc712840050d0d1c190d6e2e0.dip0.t-ipconnect.de. [2003:cb:c712:8400:50d0:d1c1:90d6:e2e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399be79d92sm10851015e9.0.2025.02.19.01.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 01:30:06 -0800 (PST)
Message-ID: <9a1199e0-38ab-4a5c-afc8-c571187f3377@redhat.com>
Date: Wed, 19 Feb 2025 10:30:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: fix half_ufd_size_MB
 calculation
To: Rafael Aquini <aquini@redhat.com>, linux-kselftest@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>
References: <20250218192251.53243-1-aquini@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250218192251.53243-1-aquini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.02.25 20:22, Rafael Aquini wrote:
> From: Rafael Aquini <raquini@redhat.com>
> 
> We noticed that uffd-stress test was always failing to run when invoked
> for the hugetlb profiles on x86_64 systems with a processor count of 64
> or bigger:
>    ...
>    # ------------------------------------
>    # running ./uffd-stress hugetlb 128 32
>    # ------------------------------------
>    # ERROR: invalid MiB (errno=9, @uffd-stress.c:459)
>    ...
>    # [FAIL]
>    not ok 3 uffd-stress hugetlb 128 32 # exit=1
>    ...
> 
> The problem boils down to how run_vmtests.sh (mis)calculates the size
> of the region it feeds to uffd-stress. The latter expects to see an
> amount of MiB while the former is just giving out the number of free
> hugepages halved down. This measurement discrepancy ends up violating
> uffd-stress' assertion on number of hugetlb pages allocated per CPU,
> causing it to bail out with the error above.
> 
> This commit fixes that issue by adjusting run_vmtests.sh's half_ufd_size_MB
> calculation so it properly renders the region size in MiB, as expected,
> while maintaining all of its original constraints in place.
> 
> Fixes: 2e47a445d7b3 ("selftests/mm: run_vmtests.sh: fix hugetlb mem size calculation")
> Signed-off-by: Rafael Aquini <raquini@redhat.com>
> ---
>   tools/testing/selftests/mm/run_vmtests.sh | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 333c468c2699..157d07e5aaa3 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -304,7 +304,9 @@ uffd_stress_bin=./uffd-stress
>   CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon 20 16
>   # Hugetlb tests require source and destination huge pages. Pass in half
>   # the size of the free pages we have, which is used for *each*.
> -half_ufd_size_MB=$((freepgs / 2))
> +# uffd-stress expects a region expressed in MiB, so we adjust
> +# half_ufd_size_MB accordingly.
> +half_ufd_size_MB=$(((freepgs * hpgsize_KB) / 1024 / 2))

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


