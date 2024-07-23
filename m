Return-Path: <linux-kernel+bounces-260425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAE093A8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A324C1C22C09
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4520145B1E;
	Tue, 23 Jul 2024 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8QoXZ1P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B013D503
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721770662; cv=none; b=riF/R4JSITjZAiW2b1liWv4wPA0hH8oELHYCJJCO4wiXyQy9CIi416IJSHII4cI8repjSg+EJp35Z4VzOZA3awcNv3c7dgzilJ7gUTNvxkm6ah0lsp2RTDttJZRTUZbqaqColnhhIYlWwbL91Wm1oMtMKZlZ/XSbZ/Kry+uwBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721770662; c=relaxed/simple;
	bh=iLIwmsGaW54x0kiClOqWvNhAsuP5Q1PmRi/ARl/773k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLXxqTp7mdgdFtwZswMA5Gzjnev6cVGT1x6ScfP7WWDuWRH3ftm4jIwFBxR0kUwrAQpueBCRuRlLg9ONPRyOkDC3Ri2DremjoxSeeOrFtiRNLY45bc0tM+Q4SlobQVuRcjLDZu0x3eHSEpkixmwL0BvYVRtNZCWd4fRjue2Ma50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8QoXZ1P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721770658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iQAkQLy5owb3Ohx4ccL2PMDh3alX5rChIh22EsOoE1k=;
	b=U8QoXZ1PD7GPvbM1lhstYayEzm8Q70r6e6LnpiS37r52bpGeXrTC7/Gk6ox1bYMCX/1Srb
	wRh1qYMabzRpOkOVNo3WvndtjTB3h5mcvxS+n//7MhYapn705hYEvHx7FhGIRcHxUKOQxN
	DqlvhNWjp+wD0e4dycPIRRMC1qdM/SU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-XKaCxgMjOAGaqKxe694rZg-1; Tue, 23 Jul 2024 17:36:55 -0400
X-MC-Unique: XKaCxgMjOAGaqKxe694rZg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42725d3ae3eso43835045e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721770614; x=1722375414;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iQAkQLy5owb3Ohx4ccL2PMDh3alX5rChIh22EsOoE1k=;
        b=U+vhRuejTBscPj/OFfaGbASxVjjeCCcO//cJ/DdvXNlTg9xgxfNiemcbOnHFxM5UpZ
         rZfyf+DEoL6AkP95FsWnYOBfdbqv04o3+MM0bhMpW5UKZAw/SUx7SQHGrMasxOn3+Tqo
         pHZK3oJqerP4rawe5bshdZ07SCA1HwmdbELv6onsZZLJMWtXPwiLa2hDgfwglfa0fYLm
         mU96Qz0q9RvJHZSjboPsLXHuuY1hkj5oZMrmm7NjEZP2PjvHFmnESet038SPGLsknCSn
         wI0q0Nky5H8ebbGJV6bAbH7PfVUBIr+rFGNITYta3D2eBt1cYBxoEF6VA69YgMt1CzpA
         ambQ==
X-Forwarded-Encrypted: i=1; AJvYcCV170q+AJJa5uY309qLO22zpf7/Zf/03cX0w13dPzfpLNfwVCIAwGNZa+UBtT/PxJrGzN1UiwFWD4yMsgvHpY5/ui9O90bDvjCeEGrq
X-Gm-Message-State: AOJu0Yw3v4ZnUbLnoOhUtvrOuPcwJdwNbRE02jm2Bg1RG7P56HITa9eX
	OOJKuDc53t5p3ixPhciK/aeGjvz5fi0RsKo9s8X8y46b75LR6Z2XJEaaSYtRe2vzJNQK3opbPdZ
	ncVBYzMJerGGMZ6Lp+U5xbcvA11+lopsKwH3nLgCY5SL9ADNC1Qwc9U4b/w2Rug==
X-Received: by 2002:a5d:6a8a:0:b0:368:8015:8a96 with SMTP id ffacd0b85a97d-369bae135f8mr7228076f8f.16.1721770614308;
        Tue, 23 Jul 2024 14:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKOxWZL2071+o5jNbdmX2PblEO87o9ntamxpRWAj/o2mSsVDtoU7uJhiP2p7dZSYxbVeb0dw==
X-Received: by 2002:a5d:6a8a:0:b0:368:8015:8a96 with SMTP id ffacd0b85a97d-369bae135f8mr7228059f8f.16.1721770613829;
        Tue, 23 Jul 2024 14:36:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:ed00:9dc2:1adb:d133:4434? (p200300cbc72fed009dc21adbd1334434.dip0.t-ipconnect.de. [2003:cb:c72f:ed00:9dc2:1adb:d133:4434])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787eced0sm12397564f8f.98.2024.07.23.14.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 14:36:53 -0700 (PDT)
Message-ID: <f48c1a91-8ed1-447d-93ad-449f28753c5c@redhat.com>
Date: Tue, 23 Jul 2024 23:36:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
To: Peter Xu <peterx@redhat.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "Kirill A . Shutemov"
 <kirill@shutemov.name>, "x86@kernel.org" <x86@kernel.org>,
 "Tian, Kevin" <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>,
 David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <ZpY5uU2NyOoMVu5A@yzhao56-desk> <ZpbDnoQxGubegtu-@x1n>
 <Zpcgmk6wexTKVv2E@yzhao56-desk> <ZpfR_L9wtuXhtSGk@x1n>
 <Zph051h5BsSFMpR6@yzhao56-desk.sh.intel.com> <ZpkglfpbHH7lQSft@x1n>
 <Zpmi2JWirNDiJz+7@yzhao56-desk.sh.intel.com>
 <1a0884cb-39ed-455e-a505-7c1b2a0e5225@redhat.com>
 <Zp3/ha6IXL5AYA8r@yzhao56-desk.sh.intel.com>
 <56c982c4-9863-4134-b088-8dfb4b94c531@redhat.com> <ZqASQCobvpB_VfCL@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZqASQCobvpB_VfCL@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.07.24 22:27, Peter Xu wrote:
> On Mon, Jul 22, 2024 at 11:17:57AM +0200, David Hildenbrand wrote:
>> What we do have is a single VMA, whereby within that VMA we place various
>> different PFN ranges. (randomly looking at drivers/video/fbdev/smscufx.c)
>>
>> These wouldn't have triggered VM_PAT code.
> 
> Right, it looks like VM_PAT is only applying to a whole-vma mapping, even
> though I don't know how that was designed..
> 
> I wished vma->vm_pgoff was for storing the base PFN for VM_SHARED too: now
> it only works like that for CoW mappings in remap_pfn_range_notrack(), then
> it looks like VM_SHARED users of remap_pfn_range() can reuse vm_pgoff, and
> I think VFIO does reuse it at least..
> 
> I am a bit confused on why Linux made that different for VM_SHARED,
> probably since b3b9c2932c32 ("mm, x86, pat: rework linear pfn-mmap
> tracking").  I wished vm_pgoff was always used for internal maintenance
> (even for VM_SHARED) so this issue should be easier to solve.
> 
> Maybe we can still re-define vm_pgoff for VM_SHARED pfnmaps? The caller
> should always be able to encode information in vm_private_data anyway.
> But I think that might break OOT users..

Yeah, I played with this idea when trying to remove the page table walk 
and storing it in the VMA, avoiding consuming more memory. The vm_pgoff 
usage for VM_PFNMAP mappings that I could spot looked nasty enough for 
me to not dare trying.

I wonder if we could just let relevant users do the PAT handling 
manually: I'm also not sure how many remap_pfn_range users end up 
triggering VM_PAT code although they don't really have to (just because 
they happen to cover a full VMA)?

One nasty thing is fork(), I was wondering if relevant users really rely 
on that or if we could force these VMAs to simply not get copied during 
fork. During fork() we have to "duplicate" the reservation ...

No real solution yet :/ Getting id of the page table walk is possible (I 
can try digging up the patch I was able to come up with), but it feels 
like the wrong approach.

The owner of the VMA should have that information ...

-- 
Cheers,

David / dhildenb


