Return-Path: <linux-kernel+bounces-229867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A32917555
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B632528201A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F3AA944;
	Wed, 26 Jun 2024 00:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XfuAKime"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBFC8495
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719362947; cv=none; b=cnnMKqS+a8Eg6pDc9W+WUlJoV/OyOwdpV68kTu4vvIHi6JgqZH/p4nkzfu2K8xQ7xTUZZHbZHOJGzyTtcwCoSJRDWMuWzmFC82Zsl8tg8tggAu3CeVBZSV7K4P3QOzlG4C2mpNdcT4oK6c9WmOOjR2MBzM1AeA8qKLI4gazjvho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719362947; c=relaxed/simple;
	bh=pdE+Pqyrk8O1N5KZQqCuSltwFfrXjzVvGuOfV6XKBb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZmH81Ri0ALzH4mHSdYQ0WmR7VjNiCs5rBnDtTY0KJRRF/lVpQavIj24klPDKNSUQwnyHo/ZEIekdXToEa5d0QRTzWPjOGnhUkG/XA5c9klr74rf6baE00wwz2gOcPDpQA4MzpZy5SXy68mRDBI1/9CPy/dspAlN1EWpXF28UHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XfuAKime; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719362944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGPSlA7WTVcLRiVfQ9BUqSjtD+lQaK58jEJVntu2EIE=;
	b=XfuAKimeX6cKobOJR+jJamYMB9ro2ZUoD6J8FG9UIehGLHgUXFVVJ8PYfDwyH+pZ6h2Wuc
	yFz+xBQ8xFI2Q4jhoDODzif+Vg4oXt8eoFgAI/Ykcs2lgXQArCUGqYuIYoojxFi2j/uBQr
	weM31HQfVoF3ZHgg5eNbhiQokAR5ttA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-oF8VAXKQO5KsI6V-aDI9Eg-1; Tue, 25 Jun 2024 20:49:02 -0400
X-MC-Unique: oF8VAXKQO5KsI6V-aDI9Eg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c7c3069ee0so7581964a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719362939; x=1719967739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGPSlA7WTVcLRiVfQ9BUqSjtD+lQaK58jEJVntu2EIE=;
        b=Q1wzMrcrTZM7P0tL80P7Cd9qzjsT3vcDT8g0vwjOzY2el2zCbOkhxCYLZifsCBLDGr
         y9LK2/TYadgKgyDzwdytFYTye5ivrCsogi6uDHzjcOrg7L6wTdUq229qqNYIivbOo61y
         kw/mAxWDW2kPNZHFb8F5d6D03vwezJO1OzdBLCgR8zcxNr8J90RpNste6KIgqh2KY0VQ
         lek6Xu2v218LUIrWeBDk7wC4bORxUrWC7XISj9qJyO5NntgVpIezBrRa/G7MS6+dHTjB
         6IF+tdX8OYt+TL0dT9WzGNThS5IOlG0THbuxTOJ186Qqb2KgmTvH3PSaTYkJbA1Kuh5E
         tzoA==
X-Forwarded-Encrypted: i=1; AJvYcCXtQ3hStLc4Cb+/QGev66VuBNUuoMUIHfs4XYVVWSr6uTPHd3llA1D82xd5l3irwpN8tSnBBO7O9XQh8MaP5LKpVZKL/aQYBj60mOB4
X-Gm-Message-State: AOJu0YyC/Hb2C3Hm8LoMsmpJkPV2Q8w2V9DeikgSj+eu4sdGUIA9uca8
	TPEFRjHtScBioMBIN31iNtfJs3rTBYfizGE7zOTXNvvFKtgkn1nJdSB++0cv/iI+QW/VzlmY0uJ
	CzAnrORqNEhA497/LJkeT7aOYNgRkeQDxCma8ja9FPwSVf+23e1j57ZzU2+suzw==
X-Received: by 2002:a17:903:234f:b0:1fa:3428:53ba with SMTP id d9443c01a7336-1fa34285bb8mr101197235ad.64.1719362939549;
        Tue, 25 Jun 2024 17:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdg8L1rPqETXUNyvWsHJ8NhP8lyoUTGeklOMi0XsgVFGiLooDy8aAoPg4Ip478gQazWq2s7A==
X-Received: by 2002:a17:903:234f:b0:1fa:3428:53ba with SMTP id d9443c01a7336-1fa34285bb8mr101197015ad.64.1719362939087;
        Tue, 25 Jun 2024 17:48:59 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebabc62bsm87382095ad.253.2024.06.25.17.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 17:48:58 -0700 (PDT)
Message-ID: <d2e3e73f-16c1-4bc0-9e7c-52fcade1c2e1@redhat.com>
Date: Wed, 26 Jun 2024 10:48:52 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm/readahead: Limit page cache size in
 page_cache_ra_order()
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
 hughd@google.com, torvalds@linux-foundation.org, zhenyzha@redhat.com,
 shan.gavin@gmail.com
References: <20240625090646.1194644-1-gshan@redhat.com>
 <20240625090646.1194644-4-gshan@redhat.com>
 <6a8fa8aa-fb6f-485b-92b6-868a522bd7fc@redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <6a8fa8aa-fb6f-485b-92b6-868a522bd7fc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/24 4:45 AM, David Hildenbrand wrote:
> On 25.06.24 11:06, Gavin Shan wrote:
>> In page_cache_ra_order(), the maximal order of the page cache to be
>> allocated shouldn't be larger than MAX_PAGECACHE_ORDER. Otherwise,
>> it's possible the large page cache can't be supported by xarray when
>> the corresponding xarray entry is split.
>>
>> For example, HPAGE_PMD_ORDER is 13 on ARM64 when the base page size
>> is 64KB. The PMD-sized page cache can't be supported by xarray.
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
> 
> Heh, you came up with this yourself concurrently :) so feel free to drop that.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

David, thanks for your follow-up and reviews. I will drop that tag in next respin :)

Thanks,
Gavin

>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   mm/readahead.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/readahead.c b/mm/readahead.c
>> index c1b23989d9ca..817b2a352d78 100644
>> --- a/mm/readahead.c
>> +++ b/mm/readahead.c
>> @@ -503,11 +503,11 @@ void page_cache_ra_order(struct readahead_control *ractl,
>>       limit = min(limit, index + ra->size - 1);
>> -    if (new_order < MAX_PAGECACHE_ORDER) {
>> +    if (new_order < MAX_PAGECACHE_ORDER)
>>           new_order += 2;
>> -        new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
>> -        new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>> -    }
>> +
>> +    new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
>> +    new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>>       /* See comment in page_cache_ra_unbounded() */
>>       nofs = memalloc_nofs_save();
> 


