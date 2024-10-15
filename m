Return-Path: <linux-kernel+bounces-365217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0391899DF19
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271661C20FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AB518B46D;
	Tue, 15 Oct 2024 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hu6N4sLN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E2137930
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728976035; cv=none; b=Hyyc/ipNSJgimYkxvf4KzYBO4U9NQcukCqvYnyiu3AyJua08NLxSSK9+ql/KYtX/hlGVDziTZ+18bma8kuQfK6u622ugdibLyXzhhYZ9X2Z229qofeRlqYPtoszBiHdbeKZSAt/bcxTWbSd9X/Kmns08GHf5aASx6uldFKEpYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728976035; c=relaxed/simple;
	bh=Vau35vT80iXgh/mhreniDhSw8wRQxDEAN9NgeqUFqqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyKU01U2HWh3PQxXkdWaGfZNi6g2NZPzpjV5SuNW3lDLfVzF1/iuryas8s49U08U6tGK6scd6qcfGOtWSbP+v0tm9FMOSAxfjmuZcCKV3UhEGc6Sc8pz58NSjlQytJJN/WyA1nMbCiVYeKnolGWQ0U7b2hENoLe5HJcqzFKwR2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hu6N4sLN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728976032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S8SP3ls1XzSuOvGugtLlQ9JcmBzH0b2VShyvU7wyrlM=;
	b=Hu6N4sLNq62Mx/j7DSlkp+QYybxt5Yk8z7he6Erjj+8Lcuht3M43x9rd5NaSZ/B9sFw+t1
	jHsTkFdQ6l2i7Pw4wl4mNL25knkySeW5BLT7dEDUVovihTKvngNBoxmW6U1/sGFZ0n9/ke
	WbLMvkSgHxefoUFZntC8RJBNYCA/x+I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-qihd91AXPQOuPSRe8JDPlg-1; Tue, 15 Oct 2024 03:07:10 -0400
X-MC-Unique: qihd91AXPQOuPSRe8JDPlg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43117b2a901so42269315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728976029; x=1729580829;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S8SP3ls1XzSuOvGugtLlQ9JcmBzH0b2VShyvU7wyrlM=;
        b=wOVUvNyHsCQBruf9BJhulThHkYhRUhOQ3ctW/9TPtYvCYxLSfueQf/Ac485ZA0mlDP
         pLHS+Qsh/73CzGQMTHOeo7PirMRzY99Mtkngc1L7OdFCqo1ee4RhS+Q8pQ1D+d5pr+X2
         prT8R806Ry9FnqmWJ2157xTTeS8PRu/bQUNxfUKkLTYttvlJ1iUxy5B7Xmw+1aXDKohm
         GFp4BVqLUvfnJdLRI6Tl1rsr6QyZw2tcXn0qm3NHzSmutNHyAU7EqP2HO9QGLyilA21J
         UJeQl8i0DB05YOnr/aMyZn5wS0tsqQh1bc6fUeAs6LkJ4Utk7hmuCBzS1EizRt4/IiK1
         ybzA==
X-Forwarded-Encrypted: i=1; AJvYcCXAgC5QOU7onzCTfUS4TCQPwljxqZl8rmBy+qeap4DGdwU8GoxwRhVyBinTN/QGK+7WmVeLNOrufl6l3w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4wR2a7f0Nearlv/TG9KjBQdMeypPjuLt/xoEdSyktzgEo40Vj
	lpr52HjQrhaPk10gxBzwLL0wO8bluPG4ddvNbJCQobykdFxch5k9qongT+1q+Q3ElHTNZ48mR47
	IJVOa7aFaMN6e0oV22PBA1Eeq+XDMCr9NfwAARfl6oN+t2WurDazznbZx78oTEQ==
X-Received: by 2002:a05:600c:1d0b:b0:42b:ac3d:3abc with SMTP id 5b1f17b1804b1-43125607986mr133554105e9.24.1728976029161;
        Tue, 15 Oct 2024 00:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqu/S0Kc2+pJkkPtgy31sSJpbg3Nr0s48dObcTy3PVsaFxtL697Sn6Q0QnObhV4xfE5yqwoQ==
X-Received: by 2002:a05:600c:1d0b:b0:42b:ac3d:3abc with SMTP id 5b1f17b1804b1-43125607986mr133553715e9.24.1728976028762;
        Tue, 15 Oct 2024 00:07:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c730:9700:d653:fb19:75e5:ab5c? (p200300cbc7309700d653fb1975e5ab5c.dip0.t-ipconnect.de. [2003:cb:c730:9700:d653:fb19:75e5:ab5c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f5699fbsm8766475e9.17.2024.10.15.00.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 00:07:08 -0700 (PDT)
Message-ID: <942d18c3-f9a8-482e-a166-c7c9d6fb28d7@redhat.com>
Date: Tue, 15 Oct 2024 09:07:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] resource: Remove dependency on SPARSEMEM from
 GET_FREE_REGION
To: Huang Ying <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Nathan Chancellor <nathan@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20241015051554.294734-1-ying.huang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241015051554.294734-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.24 07:15, Huang Ying wrote:
> We want to use the functions configured via GET_FREE_REGION in
> resource kunit tests.  However, GET_FREE_REGION depends on SPARSEMEM.
> This makes resource kunit tests cannot be built on some architectures
> lacking SPARSEMEM.  In fact, these functions doesn't depend on
> SPARSEMEM now.  So, remove dependency on SPARSEMEM from
> GET_FREE_REGION.
> 
> Link: https://lore.kernel.org/lkml/20240922225041.603186-1-linux@roeck-us.net/
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>   mm/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 4c9f5ea13271..33fa51d608dc 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1085,7 +1085,6 @@ config HMM_MIRROR
>   	depends on MMU
>   
>   config GET_FREE_REGION
> -	depends on SPARSEMEM
>   	bool
>   
>   config DEVICE_PRIVATE

Added by

commit 14b80582c43e4f550acfd93c2b2cadbe36ea0874
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Fri May 20 13:41:24 2022 -0700

     resource: Introduce alloc_free_mem_region()

@Dan, any insight why that dependency was added?

-- 
Cheers,

David / dhildenb


