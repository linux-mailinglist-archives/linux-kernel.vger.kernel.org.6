Return-Path: <linux-kernel+bounces-260781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2939793AE1F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28FC282FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB5314C59A;
	Wed, 24 Jul 2024 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HW8JSFd+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8831B285
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811240; cv=none; b=Lw85ajalZTc2bfm6sRn7gunFWAtrH0u6O7O4BmyT0pf9ucS5ensqepVBM1eY+Jl3stFnYxpA3CXc0FPAGok0mXEIwXwgflYHKF2fKe4OIdUrkM2vmSW9cme0Q/g8heZ5lPeZFvm1noicvJktd+nJjLR8XDZOWZ8K6EqwlRc8c7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811240; c=relaxed/simple;
	bh=Za7B1mWg6H+NWTuCODsUQOlqC0JjAbMwofiIJFBfGuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6MuSXLSEKhoCogopufMkCkTonXFP/dW5ncwxyHfmQ92ygrwYx8g8T94DHcKBHu8sDG9PbpCVlw1TjclDzTwyyvwRYKZlqpeM6OCglWSAj5/yc3UN8LTeMQbBPDoxZ7+eW7lxn3TvN7j4hal8CIhpvjKqOUTK2u9szY/bkFqqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HW8JSFd+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721811237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AQdhk9iy/6UkW5KLqemLD9ILeQ4ASV21Xquvq6If5Ew=;
	b=HW8JSFd+3GpvVSLMjyUGMUcSzRlkMhYZ5EDBBmPgxol3JXEN1RD1uZYXYIuN67qmaELJxg
	mwnMEVBpDylrkUol0+xmdPcCRrTxzlp76ChQH9O+xYbjOsgCznjCT4ycguZdzN7LOFdEUB
	69X9JMICtAuBfN03DFeDvR/ilJUcbAA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-jMq3mF7DMSeiCdwNpeHWHg-1; Wed, 24 Jul 2024 04:53:56 -0400
X-MC-Unique: jMq3mF7DMSeiCdwNpeHWHg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4265d3bf59dso46490945e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721811235; x=1722416035;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AQdhk9iy/6UkW5KLqemLD9ILeQ4ASV21Xquvq6If5Ew=;
        b=Vn9b1GZp2BEgA8gI6b1bOVd3ulHV4DvhNALvnn8onP3YFgmk4ZMGeK+yKtCsF4eVu6
         qQ7oW8d7Q9MRvDhIHtM5GbC/78h7dqXb1kNA0+AVDjo3vevrysEBYUNkY+0I2bpwsKjX
         Ug5SxVeNvmyvtv1SVXGBeVkQqqrWFsCJeMyWPdk8+510DHJoz3trllz11B3c7Ptn0UVb
         4GhWEy3BLxu2+N70+MMuiY8UGWABwIh912ZlSGqcfXDNFjDj0KQD6NVck5/jtj4rsWEq
         JdMTulM9dFyfIJmrjmb/RKjnWbAf8liZUak6YYeWUX/VmLVC4rZhIikiMd3tk0Yykt5r
         SvQg==
X-Forwarded-Encrypted: i=1; AJvYcCWrf+gve9sK5QvY1nUa8sh3DWi6lwfCJ5EX2xzGDWZ56IC3vU6oR0p0QTS0OOAMGwzovT/VWtW+Iw0TIioAoCXNV6+C4gFsi8DL66g8
X-Gm-Message-State: AOJu0Yxe56DgOUleNNsaYPj5n/E/Ior4vvnDa7HcdbLLWUIhjheSzC2k
	iuZT5D5rNPbnjFTJNTSwpaZDs02dJ0LmG740p0shJlmwi985wDIqOTI2KhtPK9xDKUO7o7Tnmga
	Mk34pp7hRMAp9ZMw2lKkaXc4yWmYp0astSZhLzs8Uw7tKft/wdRZIB4C/LMlp3w==
X-Received: by 2002:a5d:6a0b:0:b0:368:79c6:8845 with SMTP id ffacd0b85a97d-369f0a68d01mr1352162f8f.56.1721811234918;
        Wed, 24 Jul 2024 01:53:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuSbPJjWnJYrQ1zUMydACCEPR70uOi6U0hJxdSf/B19wkRaGQdgcqewvbn02I1Uttfi596aw==
X-Received: by 2002:a5d:6a0b:0:b0:368:79c6:8845 with SMTP id ffacd0b85a97d-369f0a68d01mr1352149f8f.56.1721811234502;
        Wed, 24 Jul 2024 01:53:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:bb00:201f:378f:5564:caeb? (p200300cbc739bb00201f378f5564caeb.dip0.t-ipconnect.de. [2003:cb:c739:bb00:201f:378f:5564:caeb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787cec6bsm13754705f8f.71.2024.07.24.01.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 01:53:54 -0700 (PDT)
Message-ID: <2190c4dc-ae84-4781-8e86-4b2ca99f2237@redhat.com>
Date: Wed, 24 Jul 2024 10:53:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "Kirill A . Shutemov" <kirill@shutemov.name>, "x86@kernel.org"
 <x86@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 Pei Li <peili.dev@gmail.com>, David Wang <00107082@163.com>,
 Bert Karwatzki <spasswolf@web.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <Zpcgmk6wexTKVv2E@yzhao56-desk> <ZpfR_L9wtuXhtSGk@x1n>
 <Zph051h5BsSFMpR6@yzhao56-desk.sh.intel.com> <ZpkglfpbHH7lQSft@x1n>
 <Zpmi2JWirNDiJz+7@yzhao56-desk.sh.intel.com>
 <1a0884cb-39ed-455e-a505-7c1b2a0e5225@redhat.com>
 <Zp3/ha6IXL5AYA8r@yzhao56-desk.sh.intel.com>
 <56c982c4-9863-4134-b088-8dfb4b94c531@redhat.com> <ZqASQCobvpB_VfCL@x1n>
 <f48c1a91-8ed1-447d-93ad-449f28753c5c@redhat.com>
 <20240723214412.GQ3371438@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240723214412.GQ3371438@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.07.24 23:44, Jason Gunthorpe wrote:
> On Tue, Jul 23, 2024 at 11:36:51PM +0200, David Hildenbrand wrote:
>> I wonder if we could just let relevant users do the PAT handling manually:
>> I'm also not sure how many remap_pfn_range users end up triggering VM_PAT
>> code although they don't really have to (just because they happen to cover a
>> full VMA)?
>>
>> One nasty thing is fork(), I was wondering if relevant users really rely on
>> that or if we could force these VMAs to simply not get copied during fork.
>> During fork() we have to "duplicate" the reservation ...
> 
> I admit I barely understand what x86 uses this PAT stuff for -
> allowing WC mappings is part of it?

I'm confused by all of that, but I think yes :)

> 
> If yes, then RDMA would expect WC PFN MAP VMAs to copy their WCness
> during fork..

Okay, that answers that question: we have to support fork().

During fork() we call vm_ops->open when cloning the VMA. So the backend 
can realize when all users (VMAs, whatsoever) are gone to undo any 
registration. Maybe that's a path forward. But still no clue on details 
... one important step might be figuring out who exactly really relies 
on that VM_PAT handling.

-- 
Cheers,

David / dhildenb


