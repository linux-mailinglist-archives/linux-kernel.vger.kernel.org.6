Return-Path: <linux-kernel+bounces-416076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214EE9D408F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE16B29A54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520CE14D70E;
	Wed, 20 Nov 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWPb9Fbn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10D757C93
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119617; cv=none; b=rMb8p1ssRDRgbIr8sjwl1gQmIM1CZcrEYzVY/IMvr1y9po3FJrjzwzY/zWHuVa7UwGDq0gju2m+UwJGz9J1s+0ymDXYKYez6SUNuqRnOslEDYoYy9kRVspekzY8CZkgBHQXcPDq8LwYXeP3vRBDhLgfKLA1jY1GQ7GivWLsUGoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119617; c=relaxed/simple;
	bh=JOyJnEUp6lcgc++FbjC9F3S7PaK46lUElZNQSqdjPIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQ1cmz9SiRtsXMoEdNJbFBEUDNfIsx+hyTBeu3OmdNlrLiwXoegOxAbYcg0reZFWuT3UAm993kNoyxN4lqzxLm6zzZG7oOVx26Ww7qhwQCudMrckFxzdLyKeZMVs4YL8j3H8yixqJM0Pmm+ELEWzcpWC90/PVyfZeGRMB4nu6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWPb9Fbn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732119614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mEq/I4+dfQBoHbyZ6EJfrXkSbqtWWjD0ivJqjS1w7V0=;
	b=iWPb9Fbni9IP9/9DMJK6B8B49hbjPdlq12Q3k70El530tmRPhSoxwgO4dHVqU3wOQiudy+
	L8Xdm+v381fM9EinI6AmuBUVK8aGzl/o9Z+nDjGTRm8ZLydZ2ga/njYum/5IQfeYw61q+X
	4fd1oQUw0ce2cyYkwzaZ6SHpr/FBu8c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-QPdw4cDqOiq_HgIVKkuWjA-1; Wed, 20 Nov 2024 11:20:13 -0500
X-MC-Unique: QPdw4cDqOiq_HgIVKkuWjA-1
X-Mimecast-MFC-AGG-ID: QPdw4cDqOiq_HgIVKkuWjA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4314c6ca114so41138095e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732119612; x=1732724412;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mEq/I4+dfQBoHbyZ6EJfrXkSbqtWWjD0ivJqjS1w7V0=;
        b=UCIM5uf+94ugSz5BNAz/rlvs2auy0pmCjgxpUw60dOT4OowitSIyzm0gaXMD8vXLHh
         ZWA2fC/aQHoKhqlnLYhc47ifAuFWwrQpq2Inysfq3uyLhmn8Nzsxf8ZzcI0WM6cXR08Z
         X6SFUg3B5xEsGLRcztA52mX+AZMlT04wU9qBCE6ATUs8OV1RSPNWDDLyelXWP38p2csF
         UiCbEGcgWeChMbIwJgdlmaojFrHbTaZcC9sw16aim6SMiXkBr9isGFlCkEj9lAGNdrMJ
         DOeesTX8EJxmH6sZz2rM1rSPOuZKKUVzD/q72L0rwxCwETyT8xMLQTtPm/WF3aR9Ikwx
         0rfg==
X-Forwarded-Encrypted: i=1; AJvYcCVDIlAyrHoPD/xiYwoezHMmbUR3pprj/IeinpknY4Ofm1hFaWxXpY1o9+2R9P4vVg+8cSZSzzU/1C9IYBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YykAQL7NFF2qlpZAM+1hEO37ricaZT1bPUc9dsDs4qtmAFwLMTR
	3kL7/7hsSuuF5YsuRYOBIX8FQ+hwYewPS06qEiUspXTkOsrpwPb5zKXcihmupwuPJYkuf0BNR0P
	UYUE5rjWzsPux4maNrE+WCguDsCrgRVDH8xkj2uhRZoAatDdM2vCRhNGaRi1OzA==
X-Received: by 2002:a5d:47ac:0:b0:382:4dad:3879 with SMTP id ffacd0b85a97d-38254a851c6mr3104125f8f.0.1732119612432;
        Wed, 20 Nov 2024 08:20:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmwTRpyYUUui75BprIw01ePkQXnzEg3oP5TbIk+6ErycPws5uB1h3GNxvKhMWsdOI9WE/3iQ==
X-Received: by 2002:a5d:47ac:0:b0:382:4dad:3879 with SMTP id ffacd0b85a97d-38254a851c6mr3104100f8f.0.1732119612003;
        Wed, 20 Nov 2024 08:20:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4200:ce79:acf6:d832:60df? (p200300cbc7054200ce79acf6d83260df.dip0.t-ipconnect.de. [2003:cb:c705:4200:ce79:acf6:d832:60df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45bdbabsm23835385e9.18.2024.11.20.08.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 08:20:11 -0800 (PST)
Message-ID: <9286da7a-9923-4a3b-a769-590e8824fa10@redhat.com>
Date: Wed, 20 Nov 2024 17:20:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] KVM: ioctl for populating guest_memfd
To: kalyazin@amazon.com, pbonzini@redhat.com, corbet@lwn.net,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jthoughton@google.com, brijesh.singh@amd.com, michael.roth@amd.com,
 graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
 nsaenz@amazon.es, xmarcalx@amazon.com,
 Sean Christopherson <seanjc@google.com>, linux-mm@kvack.org
References: <20241024095429.54052-1-kalyazin@amazon.com>
 <08aeaf6e-dc89-413a-86a6-b9772c9b2faf@amazon.com>
 <01b0a528-bec0-41d7-80f6-8afe213bd56b@redhat.com>
 <efe6acf5-8e08-46cd-88e4-ad85d3af2688@redhat.com>
 <55b6b3ec-eaa8-494b-9bc7-741fe0c3bc63@amazon.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <55b6b3ec-eaa8-494b-9bc7-741fe0c3bc63@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.24 16:58, Nikita Kalyazin wrote:
> 
> 
> On 20/11/2024 15:13, David Hildenbrand wrote:
>   > Hi!
> 
> Hi! :)
> 
>   >> Results:
>   >>    - MAP_PRIVATE: 968 ms
>   >>    - MAP_SHARED: 1646 ms
>   >
>   > At least here it is expected to some degree: as soon as the page cache
>   > is involved map/unmap gets slower, because we are effectively
>   > maintaining two datastructures (page tables + page cache) instead of
>   > only a single one (page cache)
>   >
>   > Can you make sure that THP/large folios don't interfere in your
>   > experiments (e.g., madvise(MADV_NOHUGEPAGE))?
> 
> I was using transparent_hugepage=never command line argument in my testing.
> 
> $ cat /sys/kernel/mm/transparent_hugepage/enabled
> always madvise [never]
> 
> Is that sufficient to exclude the THP/large folio factor?

Yes!

> 
>   >> While this logic is intuitive, its performance effect is more
>   >> significant that I would expect.
>   >
>   > Yes. How much of the performance difference would remain if you hack out
>   > the atomic op just to play with it? I suspect there will still be some
>   > difference.
> 
> I have tried that, but could not see any noticeable difference in the
> overall results.
> 
> It looks like a big portion of the bottleneck has moved from
> shmem_get_folio_gfp/folio_mark_uptodate to
> finish_fault/__pte_offset_map_lock somehow.  I have no good explanation
> for why:

That's what I assumed. The profiling results can be rather fuzzy and 
misleading with micro-benchmarks. :(

> 
> Orig:
>                     - 69.62% do_fault
>                        + 44.61% __do_fault
>                        + 20.26% filemap_map_pages
>                        + 3.48% finish_fault
> Hacked:
>                     - 67.39% do_fault
>                        + 32.45% __do_fault
>                        + 21.87% filemap_map_pages
>                        + 11.97% finish_fault
> 
> Orig:
>                        - 3.48% finish_fault
>                           - 1.28% set_pte_range
>                                0.96% folio_add_file_rmap_ptes
>                           - 0.91% __pte_offset_map_lock
>                                0.54% _raw_spin_lock
> Hacked:
>                        - 11.97% finish_fault
>                           - 8.59% __pte_offset_map_lock
>                              - 6.27% _raw_spin_lock
>                                   preempt_count_add
>                                1.00% __pte_offset_map
>                           - 1.28% set_pte_range
>                              - folio_add_file_rmap_ptes
>                                   __mod_node_page_state
> 
>   > Note that we might improve allocation times with guest_memfd when
>   > allocating larger folios.
> 
> I suppose it may not always be an option depending on requirements to
> consistency of the allocation latency.  Eg if a large folio isn't
> available at the time, the performance would degrade to the base case
> (please correct me if I'm missing something).

Yes, there are cons to that.

> 
>> Heh, now I spot that your comment was as reply to a series.
> 
> Yeah, sorry if it wasn't obvious.
> 
>> If your ioctl is supposed to to more than "allocating memory" like
>> MAP_POPULATE/MADV_POPULATE+* ... then POPULATE is a suboptimal choice.
>> Because for allocating memory, we would want to use fallocate() instead.
>> I assume you want to "allocate+copy"?
> 
> Yes, the ultimate use case is "allocate+copy".
> 
>> I'll note that, as we're moving into the direction of moving
>> guest_memfd.c into mm/guestmem.c, we'll likely want to avoid "KVM_*"
>> ioctls, and think about something generic.
> 
> Good point, thanks.  Are we at the stage where some concrete API has
> been proposed yet? I might have missed that.

People are working on it, and we're figuring out some remaining details 
(e.g., page_type to intercept folio_put() ). I assume we'll see a new 
RFC soonish (famous last words), but it's not been proposed yet.

> 
>> Any clue how your new ioctl will interact with the WIP to have shared
>> memory as part of guest_memfd? For example, could it be reasonable to
>> "populate" the shared memory first (via VMA) and then convert that
>> "allocated+filled" memory to private?
> 
> No, I can't immediately see why it shouldn't work.  My main concern
> would probably still be about the latency of the population stage as I
> can't see why it would improve compared to what we have now, because my
 > feeling is this is linked with the sharedness property of guest_memfd.

If the problem is the "pagecache" overhead, then yes, it will be a 
harder nut to crack. But maybe there are some low-hanging fruits to 
optimize? Finding the main cause for the added overhead would be 
interesting.

-- 
Cheers,

David / dhildenb


