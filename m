Return-Path: <linux-kernel+bounces-365547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A366299E422
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15643B2384C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBA11EC014;
	Tue, 15 Oct 2024 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSjS2pr4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731171E5727
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988411; cv=none; b=slAYYqr8UvdlXBR/jO4liTD08+wOrX4+ygVUKZypjVTrME1H4jd8Xd7I3wor5SrUBxm4qLKeTTCJwjAQ2VCcprkExNzVPfDdA0jVbStYRQle4b5DwcGAdyc947/DoF+DjDhKl0BCq6MSHFKi8WlPw3EWz0dRN7eyBE2I3EP7UV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988411; c=relaxed/simple;
	bh=Be/C9dHeiyzbKwkG5Ivvq2mk7fcANdPT1HC8X0oXbYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UN+8bEClSFQXGior2l2JEWhpTOnGtcddTUSZKFUxfDT0LSAf976kVaivcwHVsei1XbKZW/SSvBt5lOyoC+aMr5Q7KnDFw7bjuA0VmZDyzL6ProOgo78bOEcWN/sTldDEZqMqGPX2ou07JW+xptYQHb79L53nuOq11BuT6V0T3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSjS2pr4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728988408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rmVwCF3kwaW5cNmBpn+TAV42k6/YVVPhCjEHwXEd0HU=;
	b=cSjS2pr4giIwbkJsi5c3ljoZCaURCuGY7Q6h9lsYBEC2iNE+qrPW5EG42JmWhsizEDy7aN
	2rajYn6UBlREACwFS2RD0Q2LJ0lYe+B7uizYgZLG96zzPaeDO8HrM40J3KSUWajNJLMt8P
	yJIwWDdJhKyvh5pp1yGTGzLGbe3+fPw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-jfgNEGtkM_-fJG69yJigbA-1; Tue, 15 Oct 2024 06:33:27 -0400
X-MC-Unique: jfgNEGtkM_-fJG69yJigbA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43056c979c9so32083435e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728988406; x=1729593206;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmVwCF3kwaW5cNmBpn+TAV42k6/YVVPhCjEHwXEd0HU=;
        b=PuG220uV9FJa09PVfTImSUmytublKH+qxM8wKEJ2GC5FQpgbKb067pbWn3NbZafH3/
         S0wenhjcXrYBydYIra3RtAe3RVJu8TkWE1qjs/eKj3FNyrc38VxrzjptZyRaS8S3MPBn
         GY3miXd7rH+lh4E9mJt4BJbu3kOqfBTbYTtHqvJD/7vDzIH16iZwARFyH87njA3ZeZgZ
         6YDvgX/9z58DFsyP/FYEIS9dTYumha9WiWY/L5a82fvx30MPZSIrbsn/hM7YQPxCXizC
         2F/voUDLkJMo7JHE8amRG9JhJJju0rFMAVpOXFOsFJhNZNg34RlfMeUrkLTIdj3G1s/+
         lZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpC3fKii75O+ll1XCs7h99ZVHNa/lNTouRNUG+nnHHtKzGqMu34gVBxRNaF132BKOUwoWdG6bE8hXU1mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO3oXNxR2wz78N7LgLpdQc0JPxBfgelSXgboGiPOOx7qIrZ60u
	GeFJ6837ftv8nJiQslzXSpW375yTa6mu9kkRBS7G9yb9D1rueff9TB8jvLgYAC/jpkDt7R8rjHt
	w7JMNyQE61ZHzJTbmgo9VfJbOcREcETL1Tin7HXHMhQnp8GKcfl0sQYkmTo+oEw==
X-Received: by 2002:a05:600c:3ba4:b0:42e:93af:61c5 with SMTP id 5b1f17b1804b1-4314a2f2543mr203675e9.14.1728988405962;
        Tue, 15 Oct 2024 03:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE8bMeT4eJxmx0DFHtBYfG+wKdxJPd0lzwNjXMvl5Dlgbi87bcK3e/GXa+XEsiawR8KIiNCg==
X-Received: by 2002:a05:600c:3ba4:b0:42e:93af:61c5 with SMTP id 5b1f17b1804b1-4314a2f2543mr203475e9.14.1728988405462;
        Tue, 15 Oct 2024 03:33:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c730:9700:d653:fb19:75e5:ab5c? (p200300cbc7309700d653fb1975e5ab5c.dip0.t-ipconnect.de. [2003:cb:c730:9700:d653:fb19:75e5:ab5c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f55e054sm13910225e9.4.2024.10.15.03.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 03:33:25 -0700 (PDT)
Message-ID: <3450df1e-dcb2-495a-8fe4-0a6e096429fd@redhat.com>
Date: Tue, 15 Oct 2024 12:33:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] resource: Remove dependency on SPARSEMEM from
 GET_FREE_REGION
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20241015051554.294734-1-ying.huang@intel.com>
 <942d18c3-f9a8-482e-a166-c7c9d6fb28d7@redhat.com>
 <878qup94jb.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <878qup94jb.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.24 10:03, Huang, Ying wrote:
> Hi, David,
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 15.10.24 07:15, Huang Ying wrote:
>>> We want to use the functions configured via GET_FREE_REGION in
>>> resource kunit tests.  However, GET_FREE_REGION depends on SPARSEMEM.
>>> This makes resource kunit tests cannot be built on some architectures
>>> lacking SPARSEMEM.  In fact, these functions doesn't depend on
>>> SPARSEMEM now.  So, remove dependency on SPARSEMEM from
>>> GET_FREE_REGION.
>>> Link:
>>> https://lore.kernel.org/lkml/20240922225041.603186-1-linux@roeck-us.net/
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>> Cc: Nathan Chancellor <nathan@kernel.org>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>>> ---
>>>    mm/Kconfig | 1 -
>>>    1 file changed, 1 deletion(-)
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 4c9f5ea13271..33fa51d608dc 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -1085,7 +1085,6 @@ config HMM_MIRROR
>>>    	depends on MMU
>>>      config GET_FREE_REGION
>>> -	depends on SPARSEMEM
>>>    	bool
>>>      config DEVICE_PRIVATE
>>
>> Added by
>>
>> commit 14b80582c43e4f550acfd93c2b2cadbe36ea0874
>> Author: Dan Williams <dan.j.williams@intel.com>
>> Date:   Fri May 20 13:41:24 2022 -0700
>>
>>      resource: Introduce alloc_free_mem_region()
>>
>> @Dan, any insight why that dependency was added?
> 
> Dan has explain it some what in the following email,
> 
> https://lore.kernel.org/lkml/66f5abd431dce_964f2294b9@dwillia2-xfh.jf.intel.com.notmuch/
> 
> This is reachable from the "Link:" tag in the patch.

That should be part of the patch description then :)

-- 
Cheers,

David / dhildenb


