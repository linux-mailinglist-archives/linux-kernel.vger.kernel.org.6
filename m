Return-Path: <linux-kernel+bounces-432722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A02E19E4F69
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FBA285B61
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7854A1D4605;
	Thu,  5 Dec 2024 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNH0jcqP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7131CEAD4
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386231; cv=none; b=Q6zKQepY/PXFkmEuHGr5pFBs4+dLulSzsHBHkkOxXD1kP3niPpASNlpHPjLPXNUT9IUa8PKtAbrIE0qiu9ZlsY15d3RcSl7VVwcEbzwNMjw/+y6+7MoYBOV68LGcVBGraJHVFWqYHQFyaM93KUBV0Be4E6ywcC1K5nf/fHrOYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386231; c=relaxed/simple;
	bh=AaejfpshI/j70/aPnw+2SbHvzHsCIkJm51PRjqn5Dyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NyuhAfXy3BeMzh/ciPDDlvTq88W2XCbbHOmiJhnslIZAXvegNBOuPF5hsTu7WH3NuQBqueYcgSjqGlsL6aPwDddxGRipWaNWzerhD64N0ZLJRQny3wDIXWlxR8/xUDX9DvAeSwIFYl9gXQjDBTb1UURrW5ftgbwWMtnN9IaYG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNH0jcqP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733386228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=slMPncPUFapuW6Mvq7gRKO5PZvp1ywMT4KjtePW1i3U=;
	b=QNH0jcqPHNCX9mkn4x+JlyqlPaJcvwsM5PFuJ98UyjUsBuuHo/HWZ894QaDVJ6fCTFndnL
	7FZKFaObnFRl7TDDpT38DMTUIqED6O88a2iEXhdD2UIZuNqrksJCA2OCxrQX11y+95Tqx7
	XXYvQOGws+TMKwd3iXbk70SNpFmJ+eM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-VltAAR2tNTmrBOldm-ENuQ-1; Thu, 05 Dec 2024 03:10:27 -0500
X-MC-Unique: VltAAR2tNTmrBOldm-ENuQ-1
X-Mimecast-MFC-AGG-ID: VltAAR2tNTmrBOldm-ENuQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434a04437cdso3547775e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 00:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733386226; x=1733991026;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=slMPncPUFapuW6Mvq7gRKO5PZvp1ywMT4KjtePW1i3U=;
        b=dbqDBhDgqJrbYQDGqcE5+LDyZPlW7dDXa9ggfkm1venVivKwopY0n8hVefnlGDIK1q
         NOEacILxPy7NxxiL+l8gRHxz7uYGNTcTC7QCsKM/sRWP11168FZE+NjA8Yjsxeo9vvbl
         t1I1UlT5oHDF7aBYxO9kU/Z/uJi/jUbC9JElme+U+rjvEkn4ccEMYy49Nmgv0bWVuPhn
         RInCMXtSI9KVahzRNjCzMsYMQ72uL6hlJjpGd5W0Do89+OJOKLWbG6SQQlI8cSaWyYCN
         oL9ANu4MBC7Hsj9JhtIFVSom7QZrY+Wlou9HMoKONf3gDKb02awn+SKT5UOBfKoBjkkj
         sm0A==
X-Forwarded-Encrypted: i=1; AJvYcCUsybao+3rOvE9rogfHoimA8WX19SCiO3auwpG+iKkHbbpD4YwkrWJbhoiTwwS2g2UkrFd041zJMYd4QmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV9Key+rt1FyXYHioJiLHlDwFg4jajzcyX5vMlZ/x82LhLA1mS
	RHWp/iwiqzvT7VFfKiFLDYYyTFsyqAZ/F/osi5tXfOEdr7UfKP1JQHRg6+Gw7fvazTUtsArOJ/w
	LjFHW+dFqvbu6l8B52KsCat3e0msePzOy02FGCCOtnCnBqMWhX11pqHK/13PjpQ==
X-Gm-Gg: ASbGncskPUEAvdrDpSxuqzH4Z93K/5JcqwGSqj05iqnWElk1pntBGybHHb3cVi+5szS
	ErHs0sLfWgaLFWkdiCnB0EgBjml8UWlL7V63bBEv881l7NbHqnvovaPSoQEApfTS0Ssb21SnM9w
	G5BaV9EsaqSgWtL2/2FJx1bMtbo3z0JqQI8EnIgr1izxjwcmp9Lq1R3BK3d5GRVJTEOq8lacWl2
	CL0gz6G2HojckTe6ICtsBfeHEXD2s0POHp2puOMptQvo40NqbeAmxY75n3Y1NU7RiduBXsGBUES
	xe04LX0GoZXrLp2g0nxHom11ZvkMt5+LtFqP9bpLBoJwWJn+C5EqZ9DlWHu4m2hoFleg4zzWs+e
	ICg==
X-Received: by 2002:a05:600c:46cd:b0:434:882c:f746 with SMTP id 5b1f17b1804b1-434d09c8e42mr88417085e9.17.1733386226129;
        Thu, 05 Dec 2024 00:10:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFM15KEQ4HWgiUco48s1ntHOFiXjyp9MApGl4OaAdjqQ9MxyTsPbAhIx+LHO/GkpFZJSxqveg==
X-Received: by 2002:a05:600c:46cd:b0:434:882c:f746 with SMTP id 5b1f17b1804b1-434d09c8e42mr88416835e9.17.1733386225729;
        Thu, 05 Dec 2024 00:10:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:7e00:75dc:9c40:33fa:b5f8? (p200300cbc70f7e0075dc9c4033fab5f8.dip0.t-ipconnect.de. [2003:cb:c70f:7e00:75dc:9c40:33fa:b5f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0cfdsm53188135e9.33.2024.12.05.00.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 00:10:24 -0800 (PST)
Message-ID: <056a2305-db07-4168-868b-164493ff8587@redhat.com>
Date: Thu, 5 Dec 2024 09:10:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: avoid zeroing user movable page twice with
 init_on_alloc=1
To: Geert Uytterhoeven <geert@linux-m68k.org>, Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko
 <glider@google.com>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
References: <20241011150304.709590-1-ziy@nvidia.com>
 <CAMuHMdV1hRp_NtR5YnJo=HsfgKQeH91J537Gh4gKk3PFZhSkbA@mail.gmail.com>
 <DAFE2913-0B32-484F-83BE-080C60362DB8@nvidia.com>
 <f64f8a9e-fda8-4f7a-85a2-0113de2feb6c@suse.cz>
 <9942C08D-C188-461C-B731-F08DE294CD2B@nvidia.com>
 <Z1CDbrrTn6RgNmYn@casper.infradead.org>
 <09B2AB6A-B122-4287-B97E-F800E511097E@nvidia.com>
 <995E365D-5B83-41B3-A46C-6493D203A761@nvidia.com>
 <CAMuHMdW4=HScVk2C+vkG_JqO9uMCF2VoJTuGqSi1-H=86e2RqQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAMuHMdW4=HScVk2C+vkG_JqO9uMCF2VoJTuGqSi1-H=86e2RqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.12.24 09:04, Geert Uytterhoeven wrote:
> Hi Zi,
> 
> On Wed, Dec 4, 2024 at 7:30 PM Zi Yan <ziy@nvidia.com> wrote:
>> On 4 Dec 2024, at 12:33, Zi Yan wrote:
>>> On 4 Dec 2024, at 11:29, Matthew Wilcox wrote:
>>>> On Wed, Dec 04, 2024 at 11:16:51AM -0500, Zi Yan wrote:
>>>>>> So maybe the clearing done as part of page allocator isn't enough here.
>>>>>>
>>>>> Basically, mips needs to flush data cache if kmap address is aliased to
>>>>
>>>> People use "aliased" in contronym ways.  Do you mean "has a
>>>> non-congruent alias" or "has a congruent alias"?
>>>>
>>>>> userspace address. This means when mips has THP on, the patch below
>>>>> is not enough to fix the issue.
>>>>>
>>>>> In post_alloc_hook(), it does not make sense to pass userspace address
>>>>> in to determine whether to flush dcache or not.
>>>>>
>>>>> One way to fix it is to add something like arch_userpage_post_alloc()
>>>>> to flush dcache if kmap address is aliased to userspace address.
>>>>> But my questions are that
>>>>> 1) if kmap address will always be the same for two separate kmap_local() calls,
>>>>
>>>> No.  It just takes the next address in the stack.
>>>
>>> Hmm, if kmap_local() gives different addresses, wouldn’t init_on_alloc be
>>> causing issues before my patch? In the page allocator, the page is zeroed
>>> from one kmap address without flush, then clear_user_highpage() clears
>>> it again with another kmap address with flush. After returning to userspace,
>>> the user application works on the page but when the cache line used by
>>> init_on_alloc is written back (with 0s) at eviction, user data is corrupted.
>>> Am I missing anything? Or all arch with cache aliasing never enables
>>> init_on_alloc?
>>
>> Hi Geert,
>>
>> Regarding the above concern, have you ever had CONFIG_INIT_ON_ALLOC_DEFAULT_ON
>> for your MIPS machine and encountered any issue? Or let me know if my reasoning
>> above is flawed.
>>
>> To test it, I wonder if you can 1) revert my patch and 2) turn on
>> CONFIG_INIT_ON_ALLOC_DEFAULT_ON for your MIPS machine and run some applications
>> to see if any error happens.
> 
> That seems to work fine...
> 
> Kernel log confirms it's enabled:
> -mem auto-init: stack:off, heap alloc:off, heap free:off
> +mem auto-init: stack:off, heap alloc:on, heap free:off

If I'm not wrong that's expected ... because we'll be double-zeroing 
that memory, clearing the cache :)

I guess the question is, how *effective* is 
CONFIG_INIT_ON_ALLOC_DEFAULT_ON on systems to prevent exposing un-zeroed 
data to userspace, when it doesn't end up doing the flush we really need.

-- 
Cheers,

David / dhildenb


