Return-Path: <linux-kernel+bounces-253811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170BA932758
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6CE1C21083
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517D719AD4F;
	Tue, 16 Jul 2024 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yo+N+JGO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F2145345
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136139; cv=none; b=ZXIaYrY38H7W79zbneTNr2k8kjUai9h67wULgvENjSQkRJDCKAvjABDNn+2iRHa8NLMHgVj8CMSYe7IjbwwL330DCXew5ihhn49hljJJRWofqtRXW36+ypXZruSutIDEjT2JLq4BUB3hNgUy3MgYY38cA9TrxhcopwGn/TWCN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136139; c=relaxed/simple;
	bh=Alc9vqJ5BpvN2NaZaTUCfR3vCWvedss6z9+NvQtaIhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aA1g6VEJEZEKsJ626xjK6OLD/rgcSSpFLkxX6chdHn5Tdn4KsJmOSNt8LH+a5jIVWnQ9/cpPN0uU+UkzrBAY7/7wtDMKS5QERvvqT51BK7VVY0blF9iLfsKK7OgZt5tTqGfb4rLl+EHl0GfXE+Ph5nBpIEuXpTOeAGl4RjAM2Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yo+N+JGO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721136136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Nrgb/Mh65bVbEYxmC9C7+RX2N1f2oZoQ84ptMXWN1Fs=;
	b=Yo+N+JGO/hTxAQ7MedLWT3xYJ15mlQJ3Hex0aM/M0OSODWxqnMWl0lLx3UiuEk2qpLHHo8
	1A+NxH5XYWh/T2B2cBGUM3+jJLe+LgiX0/MegkC8V1JOoW6a0Uy72vcKG4rH/UCZ0uWGA0
	tDni2LWXloGUuJgE22wFv54PYa0JCBs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-c177zulRNYOfNQ3WNCOg4A-1; Tue, 16 Jul 2024 09:22:15 -0400
X-MC-Unique: c177zulRNYOfNQ3WNCOg4A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-426683d9c4bso35703835e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136134; x=1721740934;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nrgb/Mh65bVbEYxmC9C7+RX2N1f2oZoQ84ptMXWN1Fs=;
        b=cndT21ZqB0+d1SBXmobjKPhk2+mJyZEEhRIkwKotTxKUKRnV85yE1cHKoMBZLOJiyQ
         IyaAtk3gtlsNEwXJLqgavnEoHO3o8zujjSoAvU/QYC8KM3sdlYBZC4fv3m/J7WXYu3WV
         mROgXhdKIfHndSFkFKZ7xHDTsoR2vJlPb3UVujAumQnpBxJOh+g8PXHiwV5zY4rdPR7l
         hiWCpGpcKCV4dZnRsJ144hURRe78QNsXdpZzfIxL/TEJ26f9j7l9cw2lFIm2XCS7UKPR
         iuszGYDFAP2ppQQWLBa4NYCWrvsF3McOfza7gpSgWqFcr8W/7bdB+IBRUrjD6kqTXEol
         c1+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/gZRCubo89PtnkcRDCFPjPUC/t3ZkyAQOS031PiSRKHqoOFMNZSNO17ZMW3gas8FqwwlAytria35C+rIPkztgeEBnM1VKKuHGeLvz
X-Gm-Message-State: AOJu0YyrVX3aPY2doQxlKLxdEkAeQibgGJV1ofanJJTQqECDSGfM/AbY
	nY1Xp18jdcifSluEUQrPGFJYsL2Qr/07D+kbb9DOI4+kIKnDktSFeMZI9qtV0WILDwh23ZOZduc
	w1SugV/S6mJEwnIh1mOXOpqGzlWuf+tDTJudE8E3q2oTZwQ5cjo533iI7zNj6TQ==
X-Received: by 2002:a05:600c:45d3:b0:426:6f48:2dad with SMTP id 5b1f17b1804b1-427ba6fc389mr13875335e9.35.1721136134134;
        Tue, 16 Jul 2024 06:22:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcLKnvj0vQt118VmPlyJIJ5OthADHlSPU/J5Bg8ZHsvr4juoanT3+P+BEG9JC6f8ieiLGE3w==
X-Received: by 2002:a05:600c:45d3:b0:426:6f48:2dad with SMTP id 5b1f17b1804b1-427ba6fc389mr13875135e9.35.1721136133662;
        Tue, 16 Jul 2024 06:22:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f02:7c00:e95e:dbc6:7ea8:d075? (p200300d82f027c00e95edbc67ea8d075.dip0.t-ipconnect.de. [2003:d8:2f02:7c00:e95e:dbc6:7ea8:d075])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5ef4617sm125545885e9.41.2024.07.16.06.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 06:22:13 -0700 (PDT)
Message-ID: <fe313c95-5d49-4b53-9ff4-597fa5c6a898@redhat.com>
Date: Tue, 16 Jul 2024 15:22:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] add mTHP support for anonymous shmem
To: Daniel Gomez <da.gomez@samsung.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Matthew Wilcox <willy@infradead.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>,
 Pankaj Raghav <p.raghav@samsung.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Hugh Dickins <hughd@google.com>
References: <ZobtTmzj0AmNXcav@casper.infradead.org>
 <27beaa0e-697e-4e30-9ac6-5de22228aec1@redhat.com>
 <6d4c0191-18a9-4c8f-8814-d4775557383e@redhat.com>
 <Zob8xI-LWe9H_iJs@casper.infradead.org>
 <e08b8245-bc8c-4a18-a1e0-53a139258826@linux.alibaba.com>
 <e826368d-499a-483b-8991-8c25aff88f00@arm.com>
 <CGME20240705085911eucas1p17f1e79c871c6290b426737ca1738e529@eucas1p1.samsung.com>
 <32f04739-0cd0-4a9e-9419-c5a13c333c28@redhat.com>
 <ihgsmfaqgpjcewxpjnpoo3ibdhm72s2balhpedkgr2aou5l355@ps7vb3l5j54n>
 <e83e1687-3e3c-40d0-bf0e-225871647092@arm.com>
 <pxeazv32rilu75pxzfw6ksx3fmlij5brih2247d73c3vq6mokc@qcnuqbqs4buj>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <pxeazv32rilu75pxzfw6ksx3fmlij5brih2247d73c3vq6mokc@qcnuqbqs4buj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.07.24 15:11, Daniel Gomez wrote:
> On Tue, Jul 09, 2024 at 09:28:48AM GMT, Ryan Roberts wrote:
>> On 07/07/2024 17:39, Daniel Gomez wrote:
>>> On Fri, Jul 05, 2024 at 10:59:02AM GMT, David Hildenbrand wrote:
>>>> On 05.07.24 10:45, Ryan Roberts wrote:
>>>>> On 05/07/2024 06:47, Baolin Wang wrote:
>>>>>>
>>>>>>
>>>>>> On 2024/7/5 03:49, Matthew Wilcox wrote:
>>>>>>> On Thu, Jul 04, 2024 at 09:19:10PM +0200, David Hildenbrand wrote:
>>>>>>>> On 04.07.24 21:03, David Hildenbrand wrote:
>>>>>>>>>> shmem has two uses:
>>>>>>>>>>
>>>>>>>>>>       - MAP_ANONYMOUS | MAP_SHARED (this patch set)
>>>>>>>>>>       - tmpfs
>>>>>>>>>>
>>>>>>>>>> For the second use case we don't want controls *at all*, we want the
>>>>>>>>>> same heiristics used for all other filesystems to apply to tmpfs.
>>>>>>>>>
>>>>>>>>> As discussed in the MM meeting, Hugh had a different opinion on that.
>>>>>>>>
>>>>>>>> FWIW, I just recalled that I wrote a quick summary:
>>>>>>>>
>>>>>>>> https://lkml.kernel.org/r/f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com
>>>>>>>>
>>>>>>>> I believe the meetings are recorded as well, but never looked at recordings.
>>>>>>>
>>>>>>> That's not what I understood Hugh to mean.  To me, it seemed that Hugh
>>>>>>> was expressing an opinion on using shmem as shmem, not as using it as
>>>>>>> tmpfs.
>>>>>>>
>>>>>>> If I misunderstood Hugh, well, I still disagree.  We should not have
>>>>>>> separate controls for this.  tmpfs is just not that special.
>>>>>
>>>>> I wasn't at the meeting that's being referred to, but I thought we previously
>>>>> agreed that tmpfs *is* special because in some configurations its not backed by
>>>>> swap so is locked in ram?
>>>>
>>>> There are multiple things to that, like:
>>>>
>>>> * Machines only having limited/no swap configured
>>>> * tmpfs can be configured to never go to swap
>>>> * memfd/tmpfs files getting used purely for mmap(): there is no real
>>>>    difference to MAP_ANON|MAP_SHARE besides the processes we share that
>>>>    memory with.
>>>>
>>>> Especially when it comes to memory waste concerns and access behavior in
>>>> some cases, tmpfs behaved much more like anonymous memory. But there are for
>>>> sure other use cases where tmpfs is not that special.
>>>
>>> Having controls to select the allowable folio order allocations for
>>> tmpfs does not address any of these issues. The suggested filesystem
>>> approach [1] involves allocating orders in larger chunks, but always
>>> the same size you would allocate when using order-0 folios.
>>
>> Well you can't know that you will never allocate more. If you allocate a 2M
> 
> In the fs large folio approach implementation [1], the allocation of a 2M (or
> any non order-0) occurs when the size of the write/fallocate is 2M (and index
> is aligned).

I don't have time right now follow the discussion in detail here (I 
thought we had a meeting to discuss that and received guidance from 
Hugh?), but I'll point out two things:

(1) We need a reasonable model for handling/allocating of large folios
     during page faults. shmem/tmpfs can be used just like anon-shmem if
     you simply only mmap that thing (hello VMs!).

(2) Hugh gave (IMHO) clear feedback during the meeting how he thinks we
     should approach large folios in shmem.

Maybe I got (2) all wrong and people can point out all the issues in my 
summary from the meeting.

Otherwise, if people don't want to accept the result from that meeting, 
we need further guidance from Hugh.

-- 
Cheers,

David / dhildenb


