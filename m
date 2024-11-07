Return-Path: <linux-kernel+bounces-399566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 383899C00E0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B004A1F22BE8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B5D1DF983;
	Thu,  7 Nov 2024 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTQ5B8JX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9757D19CC36
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970524; cv=none; b=PiQ4jAQLZWG4nPkotrOGbjFwzIdj8Eresrtqd3/qAsINmKH3uMGTVRAqYsyzZ4PuPMFQi1Ye1NKpXHa0Ux5zN0wtBzNX2eXX6XK7IIZI6ix3wN0EMiDg9xzXw3gCCkE5hMarwxnLRPsmWCvl1+qLbf+uk2YRYBR0WWLFUy4Nh2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970524; c=relaxed/simple;
	bh=aw8AE5OIPyi2E0eJ7n6EJiugOtNZYzKxN9wuamYqb/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufuVSYk1HoC3mgzgzKGMX/4rhbmapEBO6cPlI5kypaqnvR6yyQyK4vDMZO7uF5TPpgGWOrPGG68LR+S7AJnsnpHeqB726/Z6YBedoW+22TFdjQ3NUzoxkupKEXoAzawZAiCNfov8EmC6YucPQ0wmj8m5wetRyZQbg+UrmqNf/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTQ5B8JX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730970521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0meNM07myzn3is5raBypJ2GqO2kjL/WthYw31DeaoP8=;
	b=KTQ5B8JXbCVxYOTUSpZ6poh2U2wJfED8nnUAMN/ohjiK2DMbXQgWwlxv6Vrp2kngQLc4Xz
	gAUY2ZT8lIEap+qTshvNlxb9MiYNeYdvHXfO1w0G0RePRVpZ+MuuV4YoX5mjosPY/kpWEs
	PN2DhK0Ms0s5Z8vDbK6wriAdKk+3CMg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-N2RqEszCP0WgOzZkeYCCfw-1; Thu, 07 Nov 2024 04:08:38 -0500
X-MC-Unique: N2RqEszCP0WgOzZkeYCCfw-1
X-Mimecast-MFC-AGG-ID: N2RqEszCP0WgOzZkeYCCfw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d52ccc50eso346480f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 01:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730970517; x=1731575317;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0meNM07myzn3is5raBypJ2GqO2kjL/WthYw31DeaoP8=;
        b=LzjBAm5uDVoGqV+6Rs65/mO08HB7epaJy36RLwWzqWXbKHMbgSx6/IxoPvKgtemNe9
         Dl/N6mTQB0SMUsoeuKhp0byaABDtIPm4TmkUU25wK1DDV0Zc+84161TjFH21lolEAp9B
         tw0FMWBOqqs5n1Igq7HdjnJKyfptkbV5Ryn0voQuNi728cp7TJWle6yuc+Ny+0Vq3fHy
         vuKNDBD72e+QzaQ1m1QNwgPy9oz704Z628SS0YNCilxt30cz46SgWUgA4inoTHEB/im8
         JpnyFNF1POZ4tLqrdxfEFTcSjpxGWAAJukAibjRONynE0H/uBiVaQ0sFQFxXl7l2s5wD
         QPug==
X-Gm-Message-State: AOJu0YwnsYom7p9GPNY6XPdF5dxImKfB1LIHi6OCesa9IkMf8hmW6BY6
	Uem0kq90kLdlcQeCnHTdxVBkfTlMd/7F/i5ptDrsu4W9vt1/ee9HZauWF3DPtRJjppWe5O7YmNz
	ZZjm2M1Ab4ZmvzIv0ZlHGWxloBhrHQCv4xQlLHVUCS0SFMPS3uU8WBTylPyPCKA==
X-Received: by 2002:a5d:6083:0:b0:37d:5436:4a1 with SMTP id ffacd0b85a97d-380610f2575mr27034467f8f.3.1730970517009;
        Thu, 07 Nov 2024 01:08:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvCo6R0E36eHL3mVJJdgbo4MIPSW7JGglfq3iQYyLaXodctJtVqRjYr0Br2VH5NzJ1E10zWg==
X-Received: by 2002:a5d:6083:0:b0:37d:5436:4a1 with SMTP id ffacd0b85a97d-380610f2575mr27034434f8f.3.1730970516541;
        Thu, 07 Nov 2024 01:08:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:7900:b88e:c72a:abbd:d3d9? (p200300cbc7087900b88ec72aabbdd3d9.dip0.t-ipconnect.de. [2003:cb:c708:7900:b88e:c72a:abbd:d3d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea5e4sm1156790f8f.77.2024.11.07.01.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 01:08:35 -0800 (PST)
Message-ID: <262aa19c-59fe-420a-aeae-0b1866a3e36b@redhat.com>
Date: Thu, 7 Nov 2024 10:08:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] x86/mm/pat: fix VM_PAT handling when fork() fails in
 copy_page_range()
To: mawupeng <mawupeng1@huawei.com>, peterx@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 xrivendell7@gmail.com, wang1315768607@163.com, fleischermarius@gmail.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 akpm@linux-foundation.org
References: <20241029210331.1339581-1-david@redhat.com> <ZyKl_cRRUmZGbp9G@x1n>
 <8c494db6-1def-44ea-84ef-51d0140bddf3@redhat.com>
 <7e860861-c7cb-401f-ac92-61db92fa4d8b@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7e860861-c7cb-401f-ac92-61db92fa4d8b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.11.24 09:43, mawupeng wrote:
> 
> 
> On 2024/10/31 17:47, David Hildenbrand wrote:
>> On 30.10.24 22:32, Peter Xu wrote:
>>> On Tue, Oct 29, 2024 at 10:03:31PM +0100, David Hildenbrand wrote:
>>>> If track_pfn_copy() fails, we already added the dst VMA to the maple
>>>> tree. As fork() fails, we'll cleanup the maple tree, and stumble over
>>>> the dst VMA for which we neither performed any reservation nor copied
>>>> any page tables.
>>>>
>>>> Consequently untrack_pfn() will see VM_PAT and try obtaining the
>>>> PAT information from the page table -- which fails because the page
>>>> table was not copied.
>>>>
>>>> The easiest fix would be to simply clear the VM_PAT flag of the dst VMA
>>>> if track_pfn_copy() fails. However, the whole thing is about "simply"
>>>> clearing the VM_PAT flag is shaky as well: if we passed track_pfn_copy()
>>>> and performed a reservation, but copying the page tables fails, we'll
>>>> simply clear the VM_PAT flag, not properly undoing the reservation ...
>>>> which is also wrong.
>>>
>>> David,
>>>
>>
>> Hi Peter,
>>
>>> Sorry to not have chance yet reply to your other email..
>>>
>>> The only concern I have with the current fix to fork() is.. we started to
>>> have device drivers providing fault() on PFNMAPs as vfio-pci does, then I
>>> think it means we could potentially start to hit the same issue even
>>> without fork(), but as long as the 1st pgtable entry of the PFNMAP range is
>>> not mapped when the process with VM_PAT vma exit()s, or munmap() the vma.
>>
>> As these drivers are not using remap_pfn_range, there is no way they could currently get VM_PAT set.
>>
>> So what you describe is independent of the current state we are fixing here, and this fix should sort out the issues with current VM_PAT handling.
>>
>> It indeed is an interesting question how to handle reservations when *not* using remap_pfn_range() to cover the whole area.
>>
>> remap_pfn_range() handles VM_PAT automatically because it can do it: it knows that the whole range will map consecutive PFNs with the same protection, and we expect not parts of the range suddenly getting unmapped (and any driver that does that is buggy).
>>
>> This behavior is, however, not guaranteed to be the case when remap_pfn_range() is *not* called on the whole range.
>>
>> For that case (i.e., vfio-pci) I still wonder if the driver shouldn't do the reservation and leave VM_PAT alone.
>>
>> In the driver, we'd do the reservation once and not worry about fork() etc ... and we'd undo the reservation once the last relevant VM_PFNMAP VMA is gone or the driver let's go of the device. I assume there are already mechanisms in place to deal with that to some degree, because the driver cannot go away while any VMA still has the VM_PFNMAP mapping -- otherwise something would be seriously messed up.
>>
>> Long story short: let's look into not using VM_PAT for that use case.
>>
>> Looking at the VM_PAT issues we had over time, not making it more complicated sounds like a very reasonable thing to me :)
> 
> Hi David,
> 
> The VM_PAT reservation do seems complicated. It can trigger the same warning in get_pat_info if remap_p4d_range fails:
> 
> remap_pfn_range
>    remap_pfn_range_notrack
>      remap_pfn_range_internal
>        remap_p4d_range	// page allocation can failed here
>      zap_page_range_single
>        unmap_single_vma
>          untrack_pfn
>            get_pat_info
>              WARN_ON_ONCE(1);
> 
> Any idea on this problem?

In remap_pfn_range(), if remap_pfn_range_notrack() fails, we call 
untrack_pfn(), to undo the tracking.

The problem is that zap_page_range_single() shouldn't do that 
untrack_pfn() call.

That should be fixed by Peter's patch:

https://lore.kernel.org/all/20240712144244.3090089-1-peterx@redhat.com/T/#u

-- 
Cheers,

David / dhildenb


