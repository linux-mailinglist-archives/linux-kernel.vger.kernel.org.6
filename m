Return-Path: <linux-kernel+bounces-171113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79238BDFE5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015001C23074
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E507F14EC78;
	Tue,  7 May 2024 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIeTu3sE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E586F525
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078368; cv=none; b=pRWclYznAemCv1eyhaWEYZa87ShPbOknklHXjiNw+jEa2ajdUN/3rzmY5F/RHxLxelx00mgDUgNFiIoGiVDXgM36i8SE4UCv+4JPNkv7ZfEjAUqGpJgB/nhf0LRooU4qt5aqh02t8vsn7YoCUQDCmH8k0rnpeM6NUpCVRiVjd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078368; c=relaxed/simple;
	bh=FM5MNR3lSaojn6fJAQy+qylF1waDHJonRq180f2QOqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OuHKEmGhafBbr94BBkP6lqcdSEU1odg8/zPrNWZGQNkCudtKYZvFqvI8CdNDURvWPAY5QmUQ1Gc53bSn2alZ5plyARj4tM9X3sAUwAd9ca0Cex4nFSQ1N9Y0zRalkLm1G+yDfi84UO3Sf4w+p9GAlzPhbzQ8rfaYlbzfVTgshBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIeTu3sE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715078365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1Yc/uGxE+uImxLF2V4o/qVkq/gVCojPxtujzHG2Vph0=;
	b=NIeTu3sESmbaSJODXZ7Wpj2hS4j+Z3oeervZ/o0kAecG0rkPBo9sW14X8YI9AdZD6E6sZk
	xRQk1OAwj7nKM7aU7QrkOuMqNNupVkxmZPnQB5JsfPBhJaNuASwj7O9L8MxDmIT9dtPeLG
	zF975MYZoUuWP277NrBiFtAP4cH3Jg0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Pnr1azmUO8ypc9cDPnyGNA-1; Tue, 07 May 2024 06:39:24 -0400
X-MC-Unique: Pnr1azmUO8ypc9cDPnyGNA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-346c08df987so1702774f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 03:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715078363; x=1715683163;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Yc/uGxE+uImxLF2V4o/qVkq/gVCojPxtujzHG2Vph0=;
        b=hhN8X/Mha1icmvlKRLpeBmD4yi33rIkvdU3OZrJkb1ZjwVeTuWm8Y9uD7PYSg98SxZ
         zC1R6OrdOcPiEe9rjavS7lrPPQ5NubcokvI348gZEl8gnsBYePZlZAuGTjJoH7CifKh3
         rRtrAvXOsqNrieP+CeHmcEK1SgGng/j7QJPkcDZ0jWBozCbt/mdWGxNBTkDweM9CWj2A
         DsWcQhTffrdpp8E2nypuglNvs9Z5YXvLYLCJ+Q9NAqGdtYsNd09HbWZO1IgZPpW2bHKe
         vTZYy94yw92kfCw/D/chQ3npAbo1OA7L+ffYoro+FSE9OrotUWuaPD0BufGBFy0kXl9p
         qJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1d6FfuQ5RYtIjHpcLlGd1+nMjVBvtNYaXuF6I80uBR2WTgxd8PWexYW325TwCGAtw+tPkNyo+U8RS0pVoxFhHPLdrA0yd+KAB8sfH
X-Gm-Message-State: AOJu0YwaZQt1it9w+1/A41pO5zIpo2Fl1UY8qSXKBxnQiYxXQYG7V9wP
	OIYb354vGe+zv82+mlV/6VVtweuaz81vo5gdYpT+XvOlc81WGqpme4sW3zIao9yYI0NezPcPdW/
	p5wTvNShoF89k4AcSyWl/m8qIA549wNe1zJMsXaUs/PDPJptx89gxlSDh+2CmMA==
X-Received: by 2002:adf:fc11:0:b0:34c:f87b:f9fb with SMTP id ffacd0b85a97d-34f81d4a133mr2025084f8f.25.1715078362805;
        Tue, 07 May 2024 03:39:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiRUk/XcvGMfa+jn8kUUanFP+rZ/PEvRCL88y0POGlYEH9ijy0n2iUhTnv1FyAcTnt8DWY9A==
X-Received: by 2002:adf:fc11:0:b0:34c:f87b:f9fb with SMTP id ffacd0b85a97d-34f81d4a133mr2025047f8f.25.1715078362288;
        Tue, 07 May 2024 03:39:22 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b0041be9cb540esm19101350wmo.18.2024.05.07.03.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 03:39:21 -0700 (PDT)
Message-ID: <41c1bd1f-b1d7-4faf-a422-1eff7425b35c@redhat.com>
Date: Tue, 7 May 2024 12:39:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] mm: swap: entirely map large folios found in
 swapcache
To: Barry Song <21cnbao@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, baolin.wang@linux.alibaba.com, chrisl@kernel.org,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
 ziy@nvidia.com
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-7-21cnbao@gmail.com>
 <0b4d4d4b-91d8-4fd5-af4e-aebe9ee08b89@arm.com>
 <CAGsJ_4wm6v+xgh4jQ+u2-EzOXCLsz6L6nRJi_=FfWuGDUjxRYg@mail.gmail.com>
 <ff5b371a-16f6-4d03-b80d-b56af0f488c3@redhat.com>
 <CAGsJ_4z93FwPZx7w2VuCEkHP_JCwkO0whKwymonRJ9bSiKMVyQ@mail.gmail.com>
 <CAGsJ_4xssg3CcjifePMmgk4aqLO+iAon0YdT9p=Uq-D8vFMxyQ@mail.gmail.com>
 <5b770715-7516-42a8-9ea0-3f61572d92af@redhat.com>
 <CAGsJ_4xP1jPjH-SH7BgnFHiT4m+2gB0tP7ie_cUFynVpD_zpxQ@mail.gmail.com>
 <7dc2084e-d8b1-42f7-b854-38981839f82e@redhat.com>
 <CAGsJ_4w4vDu4p-ALrTSKMZhGKDK6TpyDLrAyvY4vkPJEJ3N5Lw@mail.gmail.com>
 <099a2c9e-f85e-4fe7-99dd-81b61115935c@redhat.com>
 <CAGsJ_4wNTgkP7An7ofXkfyhRpF=J-OLWTW7e5hOFef5-CxZe4Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4wNTgkP7An7ofXkfyhRpF=J-OLWTW7e5hOFef5-CxZe4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.05.24 11:24, Barry Song wrote:
> On Tue, May 7, 2024 at 8:59 PM David Hildenbrand <david@redhat.com> wrote:
>>
>>>> Let's assume a single subpage of a large folio is no longer mapped.
>>>> Then, we'd have:
>>>>
>>>> nr_pages == folio_nr_pages(folio) - 1.
>>>>
>>>> You could simply map+reuse most of the folio without COWing.
>>>
>>> yes. This is good but the pte which is no longer mapped could be
>>> anyone within the nr_pages PTEs. so it could be quite tricky for
>>> set_ptes.
>>
>> The swap batching logic should take care of that, otherwise it would be
>> buggy.
> 
> When you mention "it would be buggy," are you also referring to the current
> fallback approach? or only refer to the future patch which might be able
> to map/reuse "nr_pages - 1" pages?

swap_pte_batch() should not skip any holes. So consequently, set_ptes() 
should do the right thing. (regarding your comment "could be quite ricky 
for set_ptes")

So I think that should be working as expected.

> 
> The current patch falls back to setting nr_pages = 1 without mapping or
> reusing nr_pages - 1. I feel your concern doesn't refer to this fallback?
> 
>>
>>>
>>>>
>>>> Once we support COW reuse of PTE-mapped THP we'd do the same. Here, it's
>>>> just easy to detect that the folio is exclusive (folio_ref_count(folio)
>>>> == 1 before mapping anything).
>>>>
>>>> If you really want to mimic what do_wp_page() currently does, you should
>>>> have:
>>>>
>>>> exclusive || (folio_ref_count(folio) == 1 && !folio_test_large(folio))
>>>
>>> I actually dislike the part that do_wp_page() handles the reuse of a large
>>> folio which is entirely mapped. For example, A forks B, B exit, we write
>>> A's large folio, we get nr_pages CoW of small folios. Ideally, we can
>>> reuse the whole folios for writing.
>>
>> Yes, see the link I shared to what I am working on. There isn't really a
>> question if what we do right now needs to be improved and all these
>> scenarios are pretty obvious clear.
> 
> Great! I plan to dedicate more time to reviewing your work.

Nice! And there will be a lot of follow-up optimization work I won't 
tackle immediately regarding COW (COW-reuse around, maybe sometimes we 
want to COW bigger chunks).

I still have making PageAnonExclusive a per-folio flag on my TODO list, 
that will help the COW-reuse around case a lot.

> 
>>
>>>
>>>>
>>>> Personally, I think we should keep it simple here and use:
>>>>
>>>> exclusive || folio_ref_count(folio) == 1
>>>
>>> I feel this is still better than
>>> exclusive || (folio_ref_count(folio) == 1 && !folio_test_large(folio))
>>> as we reuse the whole large folio. the do_wp_page() behaviour
>>> doesn't have this.
>>
>> Yes, but there is the comment "Same logic as in do_wp_page();". We
>> already ran into issues having different COW reuse logic all over the
>> place. For this case here, I don't care if we leave it as
>>
>> "exclusive || folio_ref_count(folio) == 1"
> 
> I'm perfectly fine with using the code for this patchset and maybe
> looking for other
> opportunities for potential optimization as an incremental patchset,
> for example,
> reusing the remaining PTEs as suggested by you -  "simply map+reuse most of
> the folio without COWing."
> 
>>
>> But let's not try inventing new stuff here.
> 
> It seems you ignored and snipped my "16 + 14" pages and "15" pages
> example though. but once we support "simply map+reuse most of the
> folio without COWing", the "16+14" problem can be resolved, instead,
> we consume 16 pages.


Oh, sorry for skipping that, for me it was rather clear: the partially 
mapped folios will be on the deferred split list and the excess memory 
can (and will be) reclaimed when there is need. So this temporary memory 
consumption is usually not a problem in practice. But yes, something to 
optimize (just like COW reuse in general).

-- 
Cheers,

David / dhildenb


