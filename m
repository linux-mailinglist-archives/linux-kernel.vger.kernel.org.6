Return-Path: <linux-kernel+bounces-259881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F22F939EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C74282EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B154214E2C0;
	Tue, 23 Jul 2024 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKGt9Xca"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A6A3D6A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721729883; cv=none; b=abiu6wl8TMeHf28FOaea9cV5XcdHwMqCwxzt/9LSGhyYFHpkP73y0Nj3+RcrfD9oQdIhjnPk2obt8YQX0d0lVdAy83oYuRps0GGmPKDUgXnzN7Ijdrn1x5a4nhAXbXORkMB63bsUWb8NgPQFyfOnvxBS1x8NICAH5zxXeleZESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721729883; c=relaxed/simple;
	bh=im09KjtOWQwHSVYo+FG41z4PGKxXi8KOicaWFK7K7Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RavrXMBK9gcMRRQ8ibKCz98I0yFKVLt3pQWsBe5za1bvazcFWQlchbx/OcjjqM/fRR1kMM36zHx8/6cHeGMKe4gGB9o7iT5P1nJwx6sSodJdGqIEZSBxUr8ZiKtamb6xSQLXZZO5VbdT2RouxEcUffs9979JPaLy1DCI6EvRW7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKGt9Xca; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721729881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3j4Y7GKdDQsDIXrm9FcVVcCOdvIkQaL9wqx7KuVIzeY=;
	b=dKGt9XcaPbSkJ07MRNauOC7ZYq4yToQ6NKwmRRwcIR0rD5z6j03RRPcUt/mVU5x3XKjEm+
	buXXRlfMnKOXasXkiOEVwp63ctxEMtwXPZiC8RtAgpRjGGgsSpwDgxMQ4asoM56OODIJmO
	o3bdiAlCFh0JB5PGYShlUIJAX4VXpNA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-skkVWJQQNXWIyr_qL9eN-g-1; Tue, 23 Jul 2024 06:18:00 -0400
X-MC-Unique: skkVWJQQNXWIyr_qL9eN-g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36831873b39so2943161f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721729879; x=1722334679;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3j4Y7GKdDQsDIXrm9FcVVcCOdvIkQaL9wqx7KuVIzeY=;
        b=ZYB2BrmafRapfWePhf1sTzalFL6jg+DSZFREwywBVFIQbmyN5+ZY+f2b++M1tx/yoR
         GbvrDsb4TzPb90Pr9w1diouu6JB1Ndn9nQUjwReiCxWuNhgdPEeSKECiZrvj7ypS3Yd3
         YBiLKxL9XMFUukaUfuY9xr5FfdM0KSnCrNe/wY5T8M+ntPp14tEursKmRa9KoBnRo7wP
         5xoHgq195LOvnkl4V7MWg1E4oG/ifLNIvzPaLlD7niZcJEJ7jgni8mVnb/KVuSfIaU3P
         1UErTgRnXp3FpZ+H+ypgfV5tch6sXcA+QYQgN0wXYupSOu5B3S5fD54TlXB6IQLUEF7z
         aoiA==
X-Forwarded-Encrypted: i=1; AJvYcCXpFgG0gKm6mUQh4ds/XxKUYgR9uhv/vR6W0i7xi603AJy0E4fTFj11yU89Y7zw6XU8pJbY5zGAo8swLM8dc5uGls5eOeKEpUz62w8C
X-Gm-Message-State: AOJu0YxqpReQyNBeiuogcdaNEynnttezJyU1BHOy9DJgg7SksfIwpA1e
	RIF4/CvCkGi7NBnTsfjCbqBh+wWckoqWE4QHFBAJ4HYNtNP3qja+ImdrCF7xTMebfoS9V6TLWjZ
	F94DLjhaQO085Nbr7N97Gs5O0TCeFuOS2++KGFTFYAQhXNVCrRZuvZb51am3twg==
X-Received: by 2002:a05:6000:154d:b0:368:4e2e:7596 with SMTP id ffacd0b85a97d-369dec1e50cmr2642401f8f.37.1721729878630;
        Tue, 23 Jul 2024 03:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrm3AC2cxKkpu+sq3Ii9RJOUIHoGm2gLG+gxaEGBnjakrqS9oWSEElkQVsp6V9nna9hmn6Tg==
X-Received: by 2002:a05:6000:154d:b0:368:4e2e:7596 with SMTP id ffacd0b85a97d-369dec1e50cmr2642373f8f.37.1721729878146;
        Tue, 23 Jul 2024 03:17:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:ed00:9dc2:1adb:d133:4434? (p200300cbc72fed009dc21adbd1334434.dip0.t-ipconnect.de. [2003:cb:c72f:ed00:9dc2:1adb:d133:4434])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787cf182sm11120465f8f.82.2024.07.23.03.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 03:17:57 -0700 (PDT)
Message-ID: <1621fcbd-38b5-46a8-8b68-911f2920d52e@redhat.com>
Date: Tue, 23 Jul 2024 12:17:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] memory tiering: count PGPROMOTE_SUCCESS when mem
 tiering is enabled.
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Zi Yan <ziy@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: "Huang, Ying" <ying.huang@intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org
References: <20240722172917.503370-1-ziy@nvidia.com>
 <20240722172917.503370-3-ziy@nvidia.com>
 <5230d72e-81fa-4ef1-b386-90bd3b06bf0e@huawei.com>
 <D2WJLRHB9T9S.DRAUA25VKCBP@nvidia.com>
 <d31b0226-6013-4152-af4b-1526146eb179@huawei.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d31b0226-6013-4152-af4b-1526146eb179@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.07.24 05:24, Kefeng Wang wrote:
> 
> 
> On 2024/7/23 9:54, Zi Yan wrote:
>> On Mon Jul 22, 2024 at 9:48 PM EDT, Kefeng Wang wrote:
>>>
>>>
>>> On 2024/7/23 1:29, Zi Yan wrote:
>>>> memory tiering can be enabled/disabled at runtime and
>>>> sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING is used to check
>>>> it. In migrate_misplaced_folio(), the check is missing when
>>>> PGPROMOTE_SUCCESS is incremented. Add the missing check.
>>>>
>>>> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> Closes: https://lore.kernel.org/linux-mm/f4ae2c9c-fe40-4807-bdb2-64cf2d716c1a@huawei.com/
>>>> Fixes: 33024536bafd ("memory tiering: hot page selection with hint page fault latency")
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>
>>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>
>> Thanks.
>>
>>>> ---
>>>>     mm/migrate.c | 4 +++-
>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index bdbb5bb04c91..b819809da470 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -2630,7 +2630,9 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>>>>     		putback_movable_pages(&migratepages);
>>>>     	if (nr_succeeded) {
>>>>     		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
>>>> -		if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))
>>>> +		if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
>>>> +		    && !node_is_toptier(folio_nid(folio))
>>>> +		    && node_is_toptier(node))
>>>>     			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
>>>>     					    nr_succeeded);
>>>
>>> The should be in advance of patch2, and change above to use
>>> folio_has_cpupid() helper() too.
>>
>> It shares the same logic of !folio_has_cpupid() but it might be confusing to
>> put !folio_has_cpupid(folio) && node_is_toptier(node) here. folio's
>> cpupid has nothing to do with the stats here, thus I did not use the
>> function.
> 
> If folio don't include access time, we do migrate it but it isn't a
> promotion, so don't count it, other comments?
> 
> PS: Could we rename folio_has_cpupid() to folio_has_access_time(), even
> without memory_tiering, we still have cpupid in folio, right?

Maybe call it "folio_use_cpupid()" or sth like that? The "has" is a bit 
misleading, because the folio has a cpuid in any case, no?

-- 
Cheers,

David / dhildenb


