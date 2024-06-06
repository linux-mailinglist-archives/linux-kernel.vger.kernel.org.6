Return-Path: <linux-kernel+bounces-203851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B6A8FE136
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906431F22073
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4741213DDCD;
	Thu,  6 Jun 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgVWrYex"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D313C814
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663110; cv=none; b=lM13zLf+9vFTMLKuU6dy0xUZtU/gfSWbuyHXU7YcLOhVXehUqECmfgTdAGNS7SoJy58cGqkqnrzJkhaY38xAY02PJSBGzseQJ96us6Iv/ihYssZpOIo9I6qwbBttQOINoTmZix4MkrPCCkOjmrp0n4+XpLm+JsK1M4vMZ2YrIXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663110; c=relaxed/simple;
	bh=4ouCVWSnmJVJL7I1VzyBbiieOOuDzUUROOhXZwCN6Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gX/61rnq/zSHZfl65Ev0fAxfB9YQp1t6crxb70Kk1VLn6yp8maEgUOtzTZEf42lQWdJjOpDoXt4z+JDCasuleU/2A8YoEYUe3nFCP3v238des07fFg/00vJ2UJ8FTVCXJVQhe9m4z6O+S9O700vE2drZ+LnsmUMjOndZQFuIYXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgVWrYex; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717663107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SdfTjzBkoj+tg945aw7yDq4wyxvCMWvvxDmKDLcr7LQ=;
	b=QgVWrYexfRE8wqux/EUAdysysWFU9UezBwhesEglUACytWjd9PF2a1v2Pm6dVFiZGQIAR9
	DqVB6/GZD9mYFUONw31HzlBeSv8m+TLxO7lC4sYGYrkZ4YNhTKmdTCiyqyhDUl57f+KKLM
	Yc2Z60YdRQ1N1oFRLZTODzbH+NWspD0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-0LevJXSJNm-qWqjdeS94Vg-1; Thu, 06 Jun 2024 04:38:25 -0400
X-MC-Unique: 0LevJXSJNm-qWqjdeS94Vg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4215a38713eso6246015e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663104; x=1718267904;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SdfTjzBkoj+tg945aw7yDq4wyxvCMWvvxDmKDLcr7LQ=;
        b=wUjq67jM8kTWiPk6UjqYMy8w6WvZdDFVaq3XHv/rkF7P+LgNknKL9VUgfOoxEtOOkV
         faTwiZT9PzQyc1U+mUsE5sCQP3paJY/oK1LUZHE8GW7KYdjN2pAF5Rd4/B22kMcedgmt
         7XYbeXmBPofbaTEZDlZYnE0hvPwLa4PP8hpIgZ40Ol46WVVzcFhmijVb5Y7JcowAiPFC
         vu+qNHXBfxjTKEZ75paSZf04yW9iPSRI9CXyoEIMHqHab0ZdFoRZTZ1GeOFOe9Bu03Oo
         lt1UyCLBTkKsSUB71g2uGf5UoVD8YO0W002lGAVbROomw/BfUtL8emrJe/2QGJP/oR7q
         gFWg==
X-Forwarded-Encrypted: i=1; AJvYcCWhxFDtuzJvKymdFWrxJbJq1rj48tC/iy1pD4MqudIbIuZOH4A7mbuIrmPtImrPhB3QN/9NeO1KuWDg/uOONRz0i6ltfXNWTbTAblkg
X-Gm-Message-State: AOJu0YyWyVKqOvVEiLySDz2Vp1PEZ/ktQE4pmhYEuPWpcgMYFPFjlz38
	7D6fHLEH+Ipxjn0nBPh9Uzks5vckoc5v1gVSdseenEnPtCqcr3L4S6j7GlHTVCaOpzK86qqntx9
	7nbYG4+2a/VVPGjwrjyHFV0sovG+VCR6Xnr4OTfKVZ+xOLcF2hZCvoxj9zrnzsg==
X-Received: by 2002:a05:600c:470f:b0:421:e89:dd07 with SMTP id 5b1f17b1804b1-421562c66dcmr39690395e9.2.1717663104665;
        Thu, 06 Jun 2024 01:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG0vfg8rzL3R4n6zyUXGIvtkbUgvaQggEVFubg0B7uiu3yJgFpTvvdUb4JsdIyg9r4yJxyuA==
X-Received: by 2002:a05:600c:470f:b0:421:e89:dd07 with SMTP id 5b1f17b1804b1-421562c66dcmr39690175e9.2.1717663104214;
        Thu, 06 Jun 2024 01:38:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:8800:a73c:ec5b:c02c:5e0b? (p200300cbc7108800a73cec5bc02c5e0b.dip0.t-ipconnect.de. [2003:cb:c710:8800:a73c:ec5b:c02c:5e0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215811d981sm46101835e9.25.2024.06.06.01.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 01:38:23 -0700 (PDT)
Message-ID: <d5a22158-e663-43d2-a43e-8ad54bae16c8@redhat.com>
Date: Thu, 6 Jun 2024 10:38:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] add mTHP support for anonymous shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Daniel Gomez <da.gomez@samsung.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>,
 Pankaj Raghav <p.raghav@samsung.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
 <f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
 <db3517d0-54b1-4d3a-b798-1c13572d07be@linux.alibaba.com>
 <CGME20240531111357eucas1p2338be7f326d8d9176d2ee212a10fc9db@eucas1p2.samsung.com>
 <502fb3df-b42b-4f0c-a98d-348c3d544721@redhat.com>
 <slkkien5nc3weyzebdlxs5jjvealqzmctbom7sfvijvkolhsjj@athcc2aqq77p>
 <f11c1b52-67d1-4c2a-834b-47302b0054bc@linux.alibaba.com>
 <5mezgqzg7wmd4iq2d2q3aentziosetwcll3tgdbl3mhriseyv3@pgxsux7qvxno>
 <e7b4aaa1-170d-4500-bf7a-63672e4d81b8@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e7b4aaa1-170d-4500-bf7a-63672e4d81b8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.24 05:31, Baolin Wang wrote:
> 
> 
> On 2024/6/4 20:05, Daniel Gomez wrote:
>> On Tue, Jun 04, 2024 at 05:45:20PM +0800, Baolin Wang wrote:
>>>
>>>
>>> On 2024/6/4 16:18, Daniel Gomez wrote:
>>>> On Fri, May 31, 2024 at 01:13:48PM +0200, David Hildenbrand wrote:
>>>>>>>
>>>>>>> As a default, we should not be using large folios / mTHP for any shmem,
>>>>>>> just like we did with THP via shmem_enabled. This is what this series
>>>>>>> currently does, and is aprt of the whole mTHP user-space interface design.
>>>>>>>
>>>>>>> Further, the mTHP controls should control all of shmem, not only
>>>>>>> "anonymous shmem".
>>>>>>
>>>>>> Yes, that's what I thought and in my TODO list.
>>>>>
>>>>> Good, it would be helpful to coordinate with Daniel and Pankaj.
>>>>
>>>> I've integrated patches 11 and 12 from the lsf RFC thread [1] on top of Baolin's
>>>> v3 patches. You may find a version in my integration branch here [2]. I can
>>>> attach them here if it's preferred.
>>>>
>>>> [1] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
>>>> [2] https://protect2.fireeye.com/v1/url?k=a23e7c06-c3b56926-a23ff749-74fe485fb347-371ca2bfd5d9869f&q=1&e=6974304e-a786-4255-93a7-57498540241c&u=https%3A%2F%2Fgitlab.com%2Fdkruces%2Flinux-next%2F-%2Fcommits%2Fnext-20240604-shmem-mthp
>>>>
>>>> The point here is to combine the large folios strategy I proposed with mTHP
>>>> user controls. Would it make sense to limit the orders to the mapping order
>>>> calculated based on the size and index?
>>>
>>> IMO, for !anon shmem, this change makes sense to me. We should respect the
>>> size and mTHP should act as a order filter.
>>
>> What about respecing the size when within_size flag is enabled? Then, 'always'
>> would allocate mTHP enabled folios, regardless of the size. And 'never'
>> would ignore mTHP and size. So, 'never' can be used for this 'safe' boot case
>> mentioned in the discussion.
> 
> Looks reasonable to me. What do you think, David?
> 

That mimics existing PMD-THP behavior, right?

With "within_size", we must not exceed the size, with "always", we may 
exceed the size.

> And what about 'advise' option? Silimar to 'within_size'?

Good question. What's the behavior of PMD-THP? I would assume it behaves 
like "within_size", because in the common case we mmap (+advise) only 
within the size of the file, not exceeding it.

(the always option, as I learned during the meeting, is primarily 
helpful when writing to tmpfs files in an append-fashion. With 
mmap()+madvise() that doesn't quite happen)

-- 
Cheers,

David / dhildenb


