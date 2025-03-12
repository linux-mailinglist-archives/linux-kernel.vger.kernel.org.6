Return-Path: <linux-kernel+bounces-558533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72912A5E730
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E710189F10F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E624E1EF0B2;
	Wed, 12 Mar 2025 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+AX29wF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA51219E96D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817847; cv=none; b=aeTuZ14x7Uiny6Yb7mrrD38HpM0ES0pj1wKCwVpoTNVyMSth4HcbuTz8MzZZ8vrZ8M0nLoZGFG0FaMKhMvENxhSSqvEVDHY2D00X8BZO9dIbaARSeSOnrBT0tw4tefGc4rW8FBpkS0z8HBRl8g+JPXYJBcHOoGG56ddaonBj9XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817847; c=relaxed/simple;
	bh=4tzBduGpo4HlaH1Lba8OlV8YQVTkSgbFX9CeezO16SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnJDmt38qWWsk2tmC4RQ9OWJqcv77bRO/8tU5FO0HwCwYoUrQlZaljckZBvt3Nnzq9x48GZfttWjLQsViolgdGJuLra6R607zJRYpi7rkBN1fK1iKVGkbM1qTKMx1+00iIxy4rSgAV+f/Ve12FNOXna1AmilHTKsuiHna7umUVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+AX29wF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741817843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GjIBl5yndOQdnleTRVmAst04zzkiJlZJAcEZZ6NnjC8=;
	b=a+AX29wF91m3ImC3olix5lJ3VJzQwi6z+p8YQvDocuhBeUtNEUWdwBim2ub5htH0lXhfaC
	WDCggcnngRWBuXNXqc/bzuxZek/dad8Z1Bqso4p9Ev9kbSG7vkPnaKdJO5lkb0hMeLg2y9
	6SMOJXVDoAy5Oj+veY84SjRz9gJKrtA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-JpR0lgcPPGigH90E7ZVcOQ-1; Wed, 12 Mar 2025 18:17:22 -0400
X-MC-Unique: JpR0lgcPPGigH90E7ZVcOQ-1
X-Mimecast-MFC-AGG-ID: JpR0lgcPPGigH90E7ZVcOQ_1741817841
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39143311936so170178f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741817841; x=1742422641;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GjIBl5yndOQdnleTRVmAst04zzkiJlZJAcEZZ6NnjC8=;
        b=UmAkPrq6KbnFegIDq1eWdAakr0gJMTZszqJBZuNphKZZHn/Lw8hnrJtZSxQNg3Oe0w
         kJ+t+snJ28m09HMWWIL8Lr1eccBNWk1mZIa0NeOBX4SK0v9+9iTVIE+QhNjNOj49AikZ
         TKicX97g5DM7clJnYIn0I8NjUhvh/HsWAV8IePqHIcsPGnatSOrvmH1hByjYIbKWn2Vj
         /EidtTdMywhM58EwOLBiZ3ZRSfh8fc7xrj8/6spWqJzYJLIlRxCbIS9r42NnRNJfNeu9
         gFFe0/vHCxrnmHo4oFBPsNtEz2vVlfwUZN9aciv9e60seozOHnx7pejM17dLbmzMkpTk
         fTYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDDcfy5qvMSSV4XphuAamJ633LJ82urj/XFB2J/ilAst4G/8y1HR3NVuXaoLCWCuOEm1X5Uf6mhxAXOVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD0aqdP2nzeRUMuOtXsOKGWrebeyOkfNXuhsJ1aiGgSjCcONBm
	2V8twbhI7/J9zNafhRmr0F4bGDidkcDGFiEirOkFEUSn5foF65yZZ3oda7UoK23zmnDYhayRWQv
	Sz4+OXIh4wHdpGSYGDJCDWbaUBQid8N0Ef3DZQqX7qNt7/g7jYidLaE8YqCfs4M9vDAhfAQ==
X-Gm-Gg: ASbGncs54ThBo1okaLCO8TzDvfy4qVL82plO8nJZs67erkmApccIeyRgzlFtU7gUI8T
	g5PxVhmAdmZw6UPk+V/5IAQOQZHtmBZWxAVtCsZtLQGQm2zs5d85Sqrm57ZNh693tmJPoyLb76A
	gqGSF3TUt2SaGG+KHlp+3wkhUSjuDixuyUa7r+LddIELatzeUPIetZ/LB7s2es23sWFB5BwZ3oM
	C1yYlyca0BR4F2E0jU0fWzUE1GSCaMI1Zr1jOcVgXxCm4x2UeVUSuxE3yctIoAUQ4v9mF2R2V7D
	8Yot9EmFOSSgvASGC4IDtqtoE0SZYXtbSwD4/AQg56hSsWXfBccrfbUBSCTuUJfTCNqukoF6k6s
	4SVWACV0GBSkg6LPzOBFnLvuR57d2hExwa5LdmVW9BlY=
X-Received: by 2002:a05:6000:156d:b0:391:2192:ccd6 with SMTP id ffacd0b85a97d-3926c1cd9e5mr10444694f8f.39.1741817841285;
        Wed, 12 Mar 2025 15:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7ajs+DbkvWkZrtvS3kgtwWoElT+oDfxGjlF1xcQLWnYsT+dOgzewtbm0o82DOv1DRYwzp5A==
X-Received: by 2002:a05:6000:156d:b0:391:2192:ccd6 with SMTP id ffacd0b85a97d-3926c1cd9e5mr10444674f8f.39.1741817840917;
        Wed, 12 Mar 2025 15:17:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:7c00:4ac1:c2c4:4167:8a0f? (p200300d82f1a7c004ac1c2c441678a0f.dip0.t-ipconnect.de. [2003:d8:2f1a:7c00:4ac1:c2c4:4167:8a0f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c4f9d59dsm62270f8f.0.2025.03.12.15.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 15:17:20 -0700 (PDT)
Message-ID: <26e942e3-4e06-4644-b19b-ae0301bf9b2a@redhat.com>
Date: Wed, 12 Mar 2025 23:17:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/5] vmx_balloon: update the NR_BALLOON_PAGES state
To: Nico Pache <npache@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, jerrin.shaji-george@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, jgross@suse.com, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, akpm@linux-foundation.org,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, nphamcs@gmail.com,
 yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com,
 alexander.atanasov@virtuozzo.com
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-5-npache@redhat.com>
 <20250312025607-mutt-send-email-mst@kernel.org>
 <CAA1CXcDjEErb2L85gi+W=1sFn73VHLto09nG6f1vS+10o4PctA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAA1CXcDjEErb2L85gi+W=1sFn73VHLto09nG6f1vS+10o4PctA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.03.25 21:11, Nico Pache wrote:
> On Wed, Mar 12, 2025 at 12:57 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Tue, Mar 11, 2025 at 06:06:59PM -0600, Nico Pache wrote:
>>> Update the NR_BALLOON_PAGES counter when pages are added to or
>>> removed from the VMware balloon.
>>>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>>   drivers/misc/vmw_balloon.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
>>> index c817d8c21641..2c70b08c6fb3 100644
>>> --- a/drivers/misc/vmw_balloon.c
>>> +++ b/drivers/misc/vmw_balloon.c
>>> @@ -673,6 +673,8 @@ static int vmballoon_alloc_page_list(struct vmballoon *b,
>>>
>>>                        vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
>>>                                                 ctl->page_size);
>>> +                     mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
>>> +                             vmballoon_page_in_frames(ctl->page_size));
>>
>>
>> same issue as virtio I think - this counts frames not pages.
> I agree with the viritio issue since PAGE_SIZE can be larger than
> VIRTIO_BALLOON_PFN_SHIFT, resulting in multiple virtio_balloon pages
> for each page. I fixed that one, thanks!
> 
> For the Vmware one, the code is littered with mentions of counting in
> 4k or 2M but as far as I can tell from looking at the code it actually
> operates in PAGE_SIZE or PMD size chunks and this count would be
> correct.
> Perhaps I am missing something though.

vmballoon_page_in_frames() documents to "Return: the number of 4k 
frames.", because it supports either 4k or 2M chunks IIRC.

I think the catch is that PAGE_SIZE will in these configs always be 4k. 
Otherwise things like vmballoon_mark_page_offline() wouldn't work as 
expected.

So I think this is correct.

-- 
Cheers,

David / dhildenb


