Return-Path: <linux-kernel+bounces-390278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B949B77D8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDAB2B214DF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68B197A6A;
	Thu, 31 Oct 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fj3/xpYZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4A195FD5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368040; cv=none; b=N/i5wPMUDSasmJ9eAfqxCtU4SwZ1Sv7zuVAcfE4qTGJKUD7s3jYqeDJCsMCXWW4fdxoQmwbN/kXl2YqSHDBjPz1srCmOzTaEMxzRHw4mFJVyDEtgk1B6saNrZ2ic4iXGOWCZhoKPrCw5AqkmVvIl+y039daQUxKTnjIAjnilUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368040; c=relaxed/simple;
	bh=IHUKVDrLOyLQEgAhmx/9Cc+KSj0EqtYCyP2UGiFLGAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+ia9JLkkfMFQjnp692M8XfmrSi7620e5B/bdE3m7rQyca9A9LLWuqw7yvpQPGZEBy+eLFKvYw0gG2ouNcsWmLmF00A5bl8nq2RKgojlU2WaBthyy2OdaMVw5nJocYu5TGIZWkG590r18vlRr9XwuCyllcePtKakziBgCTFNlPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fj3/xpYZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730368037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=szLJXpeIGaxtSapGr1WMxb8Eb6d8IIH8uh3fLYf3T0k=;
	b=fj3/xpYZWyEvfQ3Yoh2Fj1aK2HUnDtDw4WIRwsmXPtOn6e08rHt2Y7ZrChg2QNbnyRVaId
	IlInBzEWCkvltSFPBlbY4bLB2x19YdgteqGGATgCzYJ2M90foErfpQPYVsNymTKI0UYHX3
	ZKEFvmq7jnUGCHTCl1ZDt0MlkFVBL00=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-1DsuCcZzP4SfJnY2S65Faw-1; Thu, 31 Oct 2024 05:47:12 -0400
X-MC-Unique: 1DsuCcZzP4SfJnY2S65Faw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d5ca5bfc8so385574f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730368031; x=1730972831;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=szLJXpeIGaxtSapGr1WMxb8Eb6d8IIH8uh3fLYf3T0k=;
        b=ew0PW75zfJIreGBCUMgtlsI4tE5RLAfvnFU0qRCO+9S09Qy5CSpoN7WgKgQNcG+Ulv
         GQt8zczB1mM4J+osf01GKh4UPe68QflMdMYOs2a/35Rw7wQGxZq2ewa3TpnMAoEncNcC
         QcaAOaBmuI/PaauKRRGq2mkO8R0b3NrRYqv6EZF2P322eObRCaDOTNu5F0GMM1mdp9p+
         YsbmW9KLCz5YGKhphbrUm8lWuj8P8czWVCPmr5el+2QjNsICRYyaEV3q5kf/QT1JCyIs
         FU5sCw1eQU9Hszv79cESwhcqi2B+ntTIwNkMoZxNNCrASaHaW6ITYqreSiuxvQ/M53pY
         tYJA==
X-Gm-Message-State: AOJu0YzImEtnJYzgCJ9vNz4S+51m/TCCb7/mcvKAaCjWEUa71MemcIXw
	ykC+4hcMkGserL7mi3u0WVgHv8N8r48zK4l2hTDqYH6cIdZpifo/GjozyJReBf7rI1rIgqHJOpY
	hOqyTaxdsBCUeIshc4nwZYR2T6gFAfsCZ5xX3y/6jO+dGdl20Vox88q4FHZQEtw==
X-Received: by 2002:a05:6000:178a:b0:374:babf:ac4f with SMTP id ffacd0b85a97d-381be7652f7mr2419052f8f.12.1730368031588;
        Thu, 31 Oct 2024 02:47:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7OdUi6ghNCi/K53Vk6UtuiuPEOL0drJCIQRlT7o63eRId2vhqrIE3GXQw5KkXSMCuxmO9UQ==
X-Received: by 2002:a05:6000:178a:b0:374:babf:ac4f with SMTP id ffacd0b85a97d-381be7652f7mr2419006f8f.12.1730368031067;
        Thu, 31 Oct 2024 02:47:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe? (p200300cbc70aed007ddf1ea94f7a91fe.dip0.t-ipconnect.de. [2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd910902sm50441765e9.14.2024.10.31.02.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 02:47:10 -0700 (PDT)
Message-ID: <8c494db6-1def-44ea-84ef-51d0140bddf3@redhat.com>
Date: Thu, 31 Oct 2024 10:47:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] x86/mm/pat: fix VM_PAT handling when fork() fails in
 copy_page_range()
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 xingwei lee <xrivendell7@gmail.com>, yuxin wang <wang1315768607@163.com>,
 Marius Fleischer <fleischermarius@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>, Ma Wupeng <mawupeng1@huawei.com>
References: <20241029210331.1339581-1-david@redhat.com> <ZyKl_cRRUmZGbp9G@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZyKl_cRRUmZGbp9G@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.10.24 22:32, Peter Xu wrote:
> On Tue, Oct 29, 2024 at 10:03:31PM +0100, David Hildenbrand wrote:
>> If track_pfn_copy() fails, we already added the dst VMA to the maple
>> tree. As fork() fails, we'll cleanup the maple tree, and stumble over
>> the dst VMA for which we neither performed any reservation nor copied
>> any page tables.
>>
>> Consequently untrack_pfn() will see VM_PAT and try obtaining the
>> PAT information from the page table -- which fails because the page
>> table was not copied.
>>
>> The easiest fix would be to simply clear the VM_PAT flag of the dst VMA
>> if track_pfn_copy() fails. However, the whole thing is about "simply"
>> clearing the VM_PAT flag is shaky as well: if we passed track_pfn_copy()
>> and performed a reservation, but copying the page tables fails, we'll
>> simply clear the VM_PAT flag, not properly undoing the reservation ...
>> which is also wrong.
> 
> David,
> 

Hi Peter,

> Sorry to not have chance yet reply to your other email..
> 
> The only concern I have with the current fix to fork() is.. we started to
> have device drivers providing fault() on PFNMAPs as vfio-pci does, then I
> think it means we could potentially start to hit the same issue even
> without fork(), but as long as the 1st pgtable entry of the PFNMAP range is
> not mapped when the process with VM_PAT vma exit()s, or munmap() the vma.

As these drivers are not using remap_pfn_range, there is no way they 
could currently get VM_PAT set.

So what you describe is independent of the current state we are fixing 
here, and this fix should sort out the issues with current VM_PAT handling.

It indeed is an interesting question how to handle reservations when 
*not* using remap_pfn_range() to cover the whole area.

remap_pfn_range() handles VM_PAT automatically because it can do it: it 
knows that the whole range will map consecutive PFNs with the same 
protection, and we expect not parts of the range suddenly getting 
unmapped (and any driver that does that is buggy).

This behavior is, however, not guaranteed to be the case when 
remap_pfn_range() is *not* called on the whole range.

For that case (i.e., vfio-pci) I still wonder if the driver shouldn't do 
the reservation and leave VM_PAT alone.

In the driver, we'd do the reservation once and not worry about fork() 
etc ... and we'd undo the reservation once the last relevant VM_PFNMAP 
VMA is gone or the driver let's go of the device. I assume there are 
already mechanisms in place to deal with that to some degree, because 
the driver cannot go away while any VMA still has the VM_PFNMAP mapping 
-- otherwise something would be seriously messed up.

Long story short: let's look into not using VM_PAT for that use case.

Looking at the VM_PAT issues we had over time, not making it more 
complicated sounds like a very reasonable thing to me :)

-- 
Cheers,

David / dhildenb


