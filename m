Return-Path: <linux-kernel+bounces-430043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646169E2BDD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2364C28498A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCD51FE461;
	Tue,  3 Dec 2024 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnmbFfEP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8462613B2B8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733253551; cv=none; b=Wk1u9JTsPl9FTDy1AGG0aJVgh4H/XwrgfqXy7CoEZoF8zG58EQL726A+WbLKEbmlhhuIfuC/YfIAmekK0uEiKg6HJWW7nbdOh0fWmXFdA+dW/QNmUfmtonTcxaP7lP2A2yKpum1Q0yCx7qW6EEmqP+ZJOqZUd7fAZ2WQcdWGYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733253551; c=relaxed/simple;
	bh=yNbqeiij+oZjV8CnzHeRtM/N3KTBbQSz1Fy2J4EW+0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEN9IVyMB6afTz+kUg/GdKJFqNT5AWlQ2tyK2Kkssgb5FOG6WGKGJ+IbfWPpgvgvORvobbgE0kmXfCpOSqX9gi5vRzdH0rbnMRmug14YzoQAx+MbCCue2ehucCkjqru5snqfAGPiCK0lYodz3Bp79//3X7da0HW6GyxeaYSa2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnmbFfEP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733253548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4HYWX4lY+1zgmP6GYTzg/DCn9ab+q4upkCeyneBu0NI=;
	b=SnmbFfEPaltcmYu9k6nbL+NAQz+tu5y5IGNv2K6eMSR27jQ/UHU37FhGFT0o30neDRngOn
	j1jZZWjrzA91dUJJbz45aFXysnGRjq5KIQXi45BPQCJWKWkfuAqY656uw11eW9wrUeNLIL
	cFIElICbAIUclkFKm8jiJg8EWMUiUx0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-ZOYaQvthMb6zsWdxXjhVvg-1; Tue, 03 Dec 2024 14:19:07 -0500
X-MC-Unique: ZOYaQvthMb6zsWdxXjhVvg-1
X-Mimecast-MFC-AGG-ID: ZOYaQvthMb6zsWdxXjhVvg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4349cbf726cso43529875e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 11:19:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733253546; x=1733858346;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4HYWX4lY+1zgmP6GYTzg/DCn9ab+q4upkCeyneBu0NI=;
        b=G81Xa8+nDwBNNrLlk4+FiJRyqN0vgQC8JR87MBL0Nj77LbkDckhJjvFHwfp9r0Cp3W
         /ZUkv8VIo1Tjoss/1GyGcD1/C1ZikBa/Qa6RymZ8g4U4tIL04F65Hp6KurvNatLAw/nR
         QSefXJRXZUpRO80P1j+qardpHu7lq8yK33VzK1f4hqPEXDpqQIottr8DRFldUst04YoJ
         lUV0SAsCbNKIoaXj4YmZ4pMXoLY6fH2rrvofDzkSuLNWTawOobTzjakb5L4tAs1h/ZJm
         9tFCBPl+1vnfZSYBwO5UcwGOQ1ng17kVrKQ3ayGdQk0xkEUI/w1N8JHgYQFopCoekt2r
         XR8A==
X-Forwarded-Encrypted: i=1; AJvYcCWAO1MFoVjnqkjH0MRSinBJ+p23XVhWnqk0lzZETH54QwZivQjboYu/VyivgMwO7aJ0pKROC7kdx4uAWKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkoTqk3whnzDNKLtBa/PfEdEJnzfxn2MwkYsFnwnkcGrK/teYe
	nRm9HML4uTN1NwNqh0k5oP0rOwkg55tD1A9eD+NnYYEgp5n2B3UmZZlCqDn8uoUBi2mQzcQxvub
	GruHe/8fttBdSCySo6G82JfZdsPrteOmDHkAhjV/FiQNmcg6eMb6BmYiKdd9JOw==
X-Gm-Gg: ASbGncttD8KukWwvT88uYc6AcELLQXs17IGeuY8fWIfGU6qcl7AMuJ0A9sb2d9XKlMW
	lU6T3BmZwjzYUuy+BNO5EwxroGopLFvJK/MVLx59O2jDgqBiwOgrkKC4MqO8jTciO5Zfz4Hadon
	GbgbG7S/HHHo6XkGsqfPVPugFCG+LcaSPQwjEy9J+PEsGeHYYSKu8IRTVqU1BNiGKAJF+BBf7dL
	u3POCYx3S6QtpEEywqFNehPgNo13c0lwBF50OZBzuIcipHHdFf/W+V6BDaVIh7AU7bKUmI0BIfK
	oHco+3OlqcL1MfDW6prSnxbnknGODBmJS38cGhVjlVpmlR2jaHKv+L5zDs/L32vJpb/OGxqfe4+
	w3Q==
X-Received: by 2002:a05:600c:5125:b0:434:9da3:602b with SMTP id 5b1f17b1804b1-434d09affa9mr33331625e9.5.1733253546235;
        Tue, 03 Dec 2024 11:19:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhIUyp7FwdbibPnEWnU4E3YEQlfcnkhoAFOBhvJUKIYdte1NbCV16fBdAJsfpJijLKWBL2IA==
X-Received: by 2002:a05:600c:5125:b0:434:9da3:602b with SMTP id 5b1f17b1804b1-434d09affa9mr33331445e9.5.1733253545832;
        Tue, 03 Dec 2024 11:19:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c746:1b00:fd9e:c26c:c552:1de7? (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de. [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa76b52bsm230954065e9.18.2024.12.03.11.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 11:19:04 -0800 (PST)
Message-ID: <d736f1c0-343e-4031-88ba-3b33b73dbeba@redhat.com>
Date: Tue, 3 Dec 2024 20:19:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 4/6] mm/page_alloc: sort out the
 alloc_contig_range() gfp flags mess
To: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-5-david@redhat.com>
 <feffbbe8-4176-48e8-b503-ef53d7914197@suse.cz>
 <96c92857-4850-4f85-9474-ac193c5ea48c@redhat.com>
 <04c1d28e-bbea-4499-9a6d-770f9ca53ba9@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <04c1d28e-bbea-4499-9a6d-770f9ca53ba9@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.12.24 15:24, Vlastimil Babka wrote:
> On 12/3/24 15:12, David Hildenbrand wrote:
>> On 03.12.24 14:55, Vlastimil Babka wrote:
>>> On 12/3/24 10:47, David Hildenbrand wrote:
>>>> It's all a bit complicated for alloc_contig_range(). For example, we don't
>>>> support many flags, so let's start bailing out on unsupported
>>>> ones -- ignoring the placement hints, as we are already given the range
>>>> to allocate.
>>>>
>>>> While we currently set cc.gfp_mask, in __alloc_contig_migrate_range() we
>>>> simply create yet another GFP mask whereby we ignore the reclaim flags
>>>> specify by the caller. That looks very inconsistent.
>>>>
>>>> Let's clean it up, constructing the gfp flags used for
>>>> compaction/migration exactly once. Update the documentation of the
>>>> gfp_mask parameter for alloc_contig_range() and alloc_contig_pages().
>>>>
>>>> Acked-by: Zi Yan <ziy@nvidia.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>
>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>>
>>>> +	/*
>>>> +	 * Flags to control page compaction/migration/reclaim, to free up our
>>>> +	 * page range. Migratable pages are movable, __GFP_MOVABLE is implied
>>>> +	 * for them.
>>>> +	 *
>>>> +	 * Traditionally we always had __GFP_HARDWALL|__GFP_RETRY_MAYFAIL set,
>>>> +	 * keep doing that to not degrade callers.
>>>> +	 */
>>>
>>> Wonder if we could revisit that eventually. Why limit migration targets by
>>> cpuset via __GFP_HARDWALL if we were not called with __GFP_HARDWALL? And why
>>> weaken the attempts with __GFP_RETRY_MAYFAIL if we didn't specify it?
>>
>> See below.
>>
>>>
>>> Unless I'm missing something, cc->gfp is only checked for __GFP_FS and
>>> __GFP_NOWARN in few places, so it's mostly migration_target_control the
>>> callers could meaningfully influence.
>>
>> Note the fist change in the file, where we now use the mask instead of coming up
>> with another one out of the blue. :)
> 
> I know. What I wanted to say - cc->gfp is on its own only checked in few
> places, but now since we also translate it to migration_target_control's
> gfp_mask, it's mostly that part the caller might influence with the passed
> flags. But we still impose own additions to it, limiting that influence.
> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index ce7589a4ec01..54594cc4f650 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6294,7 +6294,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>>    	int ret = 0;
>>    	struct migration_target_control mtc = {
>>    		.nid = zone_to_nid(cc->zone),
>> -		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
>> +		.gfp_mask = cc->gfp_mask,
>>    		.reason = MR_CONTIG_RANGE,
>>    	};
>>
>> GFP_USER contains __GFP_HARDWALL. I am not sure if that matters here, but
> 
> Yeah wonder if GFP_USER was used specifically for that part, or just randomly :)
> 
>> likely the thing we are assuming here is that we are migrating a page, and
>> usually, these are user allocation (except maybe balloon and some other non-lru
>> movable things).
> 
> Yeah and user allocations obey cpuset and mempolicies etc. But these are
> likely somebody elses allocations that were done according to their
> policies. With our migration we might be actually violating those, which
> probably can't be helped (is at least migration within the same node
> preferred? hmm).

I would hope that we handle memory policies somehow (via VMAs? not 
sure). cpuset? I have no idea.

But it doesn't seem to me that our caller's restrictions
> (if those exist, would be enforced by __GFP_HARDWALL) are that relevant for
> somebody else's pages?

It was always set using "GFP_USER | __GFP_MOVABLE | 
__GFP_RETRY_MAYFAIL", and I removed the same flag combination in #2 from 
memory offline code, and we do have the exact same thing in 
do_migrate_range() in mm/memory_hotplug.c.

We should investigate if__GFP_HARDWALL is the right thing to use here, 
and if we can get rid of that by switching to GFP_KERNEL in all these 
places.

I can look into it + send a follow-up patch.

Thanks!

-- 
Cheers,

David / dhildenb


