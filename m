Return-Path: <linux-kernel+bounces-331599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8917C97AEBA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1457D1F23AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD42166F11;
	Tue, 17 Sep 2024 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8T807uf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58241165EEF
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568896; cv=none; b=UkB/Mq1gtttVWqhqc1YBifmPkEK01QOVJV190PZezNCjZouTubii33qPI7PCx/JLc/xV1Dq+EGr93cR3KLjaSnHxuA510vdt2rMEAA13o/Boa1Q/UiQDqheElXjdI8C57ZPX6C0L6Q/yH6eNf3zDvVj9tdzvKX2XDvMtit8NoXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568896; c=relaxed/simple;
	bh=Osv1cVv44V8ZT2uEC7kxu/DM3VlIxtAdStlKeMGH/HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfiYFAyMtqDAw9xO7XywISjAR1ztTS7zaZoNhRZxl+zSnGor+F5N04WYplUkgOKHgEya4mQv17dIyOnl6hJaR+3FCLaZy3wiuKpv4/GMrbAZAwIFw8lri6RL+or+P1cs6xPul5DKuztOctrpSMYiRhtbnMt19VRRhnOpHRZdpK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8T807uf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726568894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O4o9FiZpED9lrRymb/v3EzHKuXxo+xVGDeJxVxBPzk0=;
	b=g8T807ufB5DpiFEWaXOr1rItk37pOStKPRJAC09u4nkeliOEPDdLuRuWHVAymPb1k03Pi9
	//Rl9gHRL+ZcCCSn1F0AUxRUP8wpi10sGOa6Ckq0d7pa7Wuvskm1uiHSufGTqmLV5B+smE
	us7WfHTbdo9zSwK0uEi8Qp29AglZRmk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-fzlBnUHGOsOBbEfvUgpLaw-1; Tue, 17 Sep 2024 06:28:12 -0400
X-MC-Unique: fzlBnUHGOsOBbEfvUgpLaw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53660eb17b8so4115175e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726568889; x=1727173689;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4o9FiZpED9lrRymb/v3EzHKuXxo+xVGDeJxVxBPzk0=;
        b=oXtSl3dCssUhcoii1jZ7h5U2oEYBAqRgagB5yS7NuGOfcRs93W8CwKEOJ0VB+QuQHX
         O0YztB43mBGdUbBhyz2VDxLXsaK6gxQ9oF0I242/3CBoJOzul/XuQjPgzCrVYXFkoWrw
         5wNDSruBOb0H5HhEah7HzDEOSZkJ9NZviVhdBiDOX+anQ3XXjdcC5p2pdBQNfbbI0IKd
         W8ejscxix4L73ZMEOZl9niZmFDEC6VnN1ILTY6zQn8tu0xwNxb60bqLJzlvR2V5LcRD2
         qiQY5IudqvqQAYiMdEQPo0gQmMmFFe/Gw9XsMvNXv68AUazFGfv6dRiL19ymzgMYfoZo
         WlTw==
X-Forwarded-Encrypted: i=1; AJvYcCU/4yY8qNt/WWeRSxYErFgbNDtxFUTvmyAaEHBqZd98fCUlp+4YZNA2/lbHytGuIdw3P4jSrx0W+KPn2M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDN416BzyG4jDPvacoykTo/hSvXWovLDUqLqf9TCRovCwiY/3j
	wRcslkEbEsHtDSx3O7o5Nlvh1CdXqIOJqxTBdKLtzXmTEoBArQ9G5HjLU74x73w1T5aty2CISuq
	YCLrNwrwzx+aNDkLdl+16DTmeL8SiEwtDrmOyeOPq96gN8sY0DWTrgY4ifIAY7w==
X-Received: by 2002:a05:6512:110d:b0:536:5816:82ad with SMTP id 2adb3069b0e04-53678ff4b27mr9247028e87.57.1726568889430;
        Tue, 17 Sep 2024 03:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMoCRMKq8JDt/100WcEwqWUtSXK1Q/MWy5NC6pzJHE1KPkoHVicapOoTXtxe/3Z5TPD2volA==
X-Received: by 2002:a05:6512:110d:b0:536:5816:82ad with SMTP id 2adb3069b0e04-53678ff4b27mr9247002e87.57.1726568888853;
        Tue, 17 Sep 2024 03:28:08 -0700 (PDT)
Received: from [192.168.55.136] (tmo-067-108.customers.d1-online.com. [80.187.67.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb49a4esm3560295a12.9.2024.09.17.03.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 03:28:07 -0700 (PDT)
Message-ID: <f9a7ebb4-3d7c-403e-b818-29a6a3b12adc@redhat.com>
Date: Tue, 17 Sep 2024 12:28:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/7] mm: Use ptep_get() for accessing PTE entries
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240917073117.1531207-1-anshuman.khandual@arm.com>
 <20240917073117.1531207-4-anshuman.khandual@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240917073117.1531207-4-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.24 09:31, Anshuman Khandual wrote:
> Convert PTE accesses via ptep_get() helper that defaults as READ_ONCE() but
> also provides the platform an opportunity to override when required. This
> stores read page table entry value in a local variable which can be used in
> multiple instances there after. This helps in avoiding multiple memory load
> operations as well possible race conditions.
> 

Please make it clearer in the subject+description that this really only 
involves set_pte_safe().


> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   include/linux/pgtable.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 2a6a3cccfc36..547eeae8c43f 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1060,7 +1060,8 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
>    */
>   #define set_pte_safe(ptep, pte) \
>   ({ \
> -	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
> +	pte_t __old = ptep_get(ptep); \
> +	WARN_ON_ONCE(pte_present(__old) && !pte_same(__old, pte)); \
>   	set_pte(ptep, pte); \
>   })
>   

I don't think this is necessary. PTE present cannot flip concurrently, 
that's the whole reason of the "safe" part after all.

Can we just move these weird set_pte/pmd_safe() stuff to x86 init code 
and be done with it? Then it's also clear *where* it is getting used and 
for which reason.

-- 
Cheers,

David / dhildenb


