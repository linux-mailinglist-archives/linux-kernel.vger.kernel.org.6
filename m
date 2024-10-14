Return-Path: <linux-kernel+bounces-364713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C55299D842
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E690C282F38
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3801D0159;
	Mon, 14 Oct 2024 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2ST8aRC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7AF14C5AE
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937966; cv=none; b=RuJHJyep8bXtiVfvHYrn/e6T/Z6lNNXpAaQLgBRgYuz/8xb+PR/8xyCr8dhLre65lanrOxcvNGrqnDRCJGOUZR54dNj8Y7YyxwyAlawmRKGaTCqt8kt/JQ8XY0B+xIJIUTMFZNzesxAS+z1HPZ8/IOREnjWL+O1U4bAQahe/nL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937966; c=relaxed/simple;
	bh=BBWv8m+FJiNZQyLDR69iMqI0y2Tck6kmZY6eB39xR98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwhHMLwqlirSdFjvfw9gPV4acuBJiVxKVD10WAPdDBjgjjYIfw5E8bBxq4u/jq0oXAMy5q0sqEY4+A78XfHf7iVJanw+Eu885OzFV2foj5rJ5u9pAXvewLpyKnLtwstlNdOSV5z8OgJ9Mk2hAEli7yxgmXklgz9ORrnmrirNAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2ST8aRC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728937963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iYSwD/C4U7CDnA1i065kPB6l0/mhsEkr4NjLjDag7OY=;
	b=d2ST8aRC0hVpqfPBIkxoJND5+l1Oc4W6upc/WdHWGF97wTrAimBa0adL2FqEvnOrVHePxb
	Y8q6zFZzInMwI25NWbgpsh6flOBbF3dk8l44ih4YcuErjx8ZI5tdnglGKSOgyGlXRx/516
	ctNfdUhSmfN0ohj1aFlSRKVCObJUcSQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-KdFhiWTGMGG99YNXe5YIHA-1; Mon, 14 Oct 2024 16:32:40 -0400
X-MC-Unique: KdFhiWTGMGG99YNXe5YIHA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43117b2a901so38866355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728937959; x=1729542759;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iYSwD/C4U7CDnA1i065kPB6l0/mhsEkr4NjLjDag7OY=;
        b=HVfPn7uPEHrEmL8pN7iea7RTwLbHDQLjS8Vy7F3KVXzF0OywJ4Yw5vB7n62zi9xMuN
         MpBapK0ct26qaxJyPaYsGJZEGKDLuxL1QUSWaPFSp0B3RAbzumac6I+FQ08P4xySLJGl
         a6m7yNipOWUp8urNwYeRqdUwBcHVoM/8IyJoGrWWotSfW5a1NNubOgauz452eXoEtqKF
         Z7MkN8Hj93J0DEEQr9GLVRPHTZkfTVVJ/eTy/yfFYJ4q9Sg/fAv1Hbr+Z70FDrq+d+o9
         nmGcGChKPf75F1aVGezchzLu2vxyKLsKM3aEz6pyq+h9D9TBWrzO2NgsWvoIepRGpo9+
         0+Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWZb3h9yy6buZ5x2mVM/pntOQ2TMFwCpWBZE0qfDlecy5Sscn15+Gbz7GPnPBTcJjefNyx8TXbP13KyJjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFFbhZlQZiXRIz528UfpT8dCMS2MFh1gfwFdNcIIaZRdIY9Go
	+rjY0nuH2aega3G0Z+toKqQ4A5NipiaK41pX7r3YdxRy97rBKdtUjBmMc4j9eytjTExOgFOiqRj
	g91RJYWvXztz8hSs1SL2pinH136SmeHEAGmzjo2engvRXke312YCgGOJGTWeQtg==
X-Received: by 2002:a05:600c:3d89:b0:42e:8d0d:bc95 with SMTP id 5b1f17b1804b1-431255ceac1mr106234015e9.6.1728937959405;
        Mon, 14 Oct 2024 13:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq0m0aS18BUeXh6W+kIpN+6D0hVXo0ZycftiRj3HIxgTiiwKnS80fAE21fY0VFaQLbbhlQZw==
X-Received: by 2002:a05:600c:3d89:b0:42e:8d0d:bc95 with SMTP id 5b1f17b1804b1-431255ceac1mr106233725e9.6.1728937958922;
        Mon, 14 Oct 2024 13:32:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:600:9fbb:f0bf:d958:5c70? (p200300cbc71e06009fbbf0bfd9585c70.dip0.t-ipconnect.de. [2003:cb:c71e:600:9fbb:f0bf:d958:5c70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b4331sm165472335e9.36.2024.10.14.13.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 13:32:38 -0700 (PDT)
Message-ID: <01fbdcef-b923-4bb0-80b0-f1d3e57fe515@redhat.com>
Date: Mon, 14 Oct 2024 22:32:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] memory: extern memory_block_size_bytes and
 set_memory_block_size_order
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 akpm@linux-foundation.org, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, alison.schofield@intel.com, rrichter@amd.com,
 terry.bowman@amd.com, lenb@kernel.org, dave.jiang@intel.com,
 ira.weiny@intel.com
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-2-gourry@gourry.net>
 <039e8c87-c5da-4469-b10e-e57dd5662cff@redhat.com>
 <ZwVG8Z3GRYLoL_Jk@PC2K9PVX.TheFacebook.com>
 <d3203f2c-eff6-4e84-80cd-3c6f58dab292@redhat.com>
 <ZwVOE6JRS8Fd9_a8@PC2K9PVX.TheFacebook.com>
 <2c854e5e-c200-4ed9-bf21-778779af7e5b@redhat.com>
 <Zw0p7-7ymn-0bPiC@PC2K9PVX.TheFacebook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zw0p7-7ymn-0bPiC@PC2K9PVX.TheFacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.24 16:25, Gregory Price wrote:
> On Mon, Oct 14, 2024 at 01:54:27PM +0200, David Hildenbrand wrote:
>> On 08.10.24 17:21, Gregory Price wrote:
>>> On Tue, Oct 08, 2024 at 05:02:33PM +0200, David Hildenbrand wrote:
>>>> On 08.10.24 16:51, Gregory Price wrote:
>>>>>>> +int __weak set_memory_block_size_order(unsigned int order)
>>>>>>> +{
>>>>>>> +	return -ENODEV;
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL_GPL(set_memory_block_size_order);
>>>>>>
>>>>>> I can understand what you are trying to achieve, but letting arbitrary
>>>>>> modules mess with this sounds like a bad idea.
>>>>>>
>>>>>
>>>>> I suppose the alternative is trying to scan the CEDT from inside each
>>>>> machine, rather than the ACPI driver?  Seems less maintainable.
>>>>>
>>>>> I don't entirely disagree with your comment.  I hummed and hawwed over
>>>>> externing this - hence the warning in the x86 machine.
>>>>>
>>>>> Open to better answers.
>>>>
>>>> Maybe an interface to add more restrictions on the maximum size might be
>>>> better (instead of setting the size/order, you would impose another upper
>>>> limit).
>>>
>>> That is effectively what set_memory_block_size_order is, though.  Once
>>> blocks are exposed to the allocators, its no longer safe to change the
>>> size (in part because it was built assuming it wouldn't change, but I
>>> imagine there are other dragons waiting in the shadows to bite me).
>>
>> Yes, we must run very early.
>>
>> How is this supposed to interact with code like
>>
>> set_block_size()
>>
>> that also calls set_memory_block_size_order() on UV systems (assuming there
>> will be CXL support sooner or later?)?
>>
>>
> 
> Tying the other email to this one - just clarifying the way forward here.
> 
> It sounds like you're saying at a minimum drop EXPORT tags to prevent
> modules from calling it - but it also sounds like built-ins need to be
> prevented from touching it as well after a certain point in early boot.

Right, at least the EXPORT is not required.

> 
> Do you think I should go down the advise() path as suggested by Ira,
> just adding a arch_lock_blocksize() bit and have set_..._order check it,
> or should we just move towards each architecture having to go through
> the ACPI:CEDT itself?

Let's summarize what we currently have on x86 is:

1) probe_memory_block_size()

Triggered on first memory_block_size_bytes() invocation. Makes a 
decision based on:

a) Already set size using set_memory_block_size_order()
b) RAM size
c) Bare metal vs. virt (bare metal -> use max)
d) Virt: largest block size aligned to memory end


2) set_memory_block_size_order()

Triggered by set_block_size() on UV systems.


I don't think set_memory_block_size_order() is the right tool to use. We 
just want to leave that alone I think -- it's a direct translation of a 
kernel cmdline parameter that should win.

You essentially want to tweak the b)->d) logic to take other alignment 
into consideration.

Maybe have some simple callback mechanism probe_memory_block_size() that 
can consult other sources for alignment requirements?

If that's not an option, then another way to set further min-alignment 
requirements (whereby we take MIN(old_align, new_align))?

-- 
Cheers,

David / dhildenb


