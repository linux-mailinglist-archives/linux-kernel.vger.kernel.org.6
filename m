Return-Path: <linux-kernel+bounces-394841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58199BB4BB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83A91C21E81
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6871B6D1F;
	Mon,  4 Nov 2024 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOXbqgB5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2AD1B6D0F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730723585; cv=none; b=kJG0E5TZvyABW55gSCiatzT8IqEiN6ABpr13t953/H64yqp1yAVPBlCVEpiA9+Pwd2J15aSnmT6OIk8plZCZpLSJlv4/EdHcLI6uAYMQBed/WHFSPRTIO+2lpWkKtmUu+6CR6GXwOTWUoVH3DfiBtPiL80Dc2J5AIKvjkrx5S9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730723585; c=relaxed/simple;
	bh=lJJr/i4BHuNdSJVtWoxwuGtowymnuCLFCsxqfCF6wCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOUeegWy5Y+jMKFec+qdekCKpfBqCqQZl/0pBpvRJDKrKW4ZbeXhGLn7vJqa/5l9UNwNLEDGMhFUq0G11/Or4laUE2W+Nw7RcFfyosGNmKCtC27aU5UV08W10x9hJ8IjwblqkQGTNWfiR/Lvlz3tzVWQ+4UM2RywkFwW1RN8gQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOXbqgB5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730723580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wYU1bYFt4awhT4ggXN0pyIL2cYzKGeU0iBusjO1/9ro=;
	b=AOXbqgB5Hdu3YXyQIqFk2wDN7/Sr+/0Fb1qHUqiIzBCUUZElrqfqpVqPQwhmCQLM93N0EU
	lRKvhnpuJ/CCKDr2IgsOthaII74Dg8+b8/3KX+bO5XJJeC1Cz6jBCWAzTEPblb/vm5uGSb
	K57KwbEONFU2TmFmAznl8+Kmvpm0Qds=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-xIJPPbRTNCOf4lAKQPEdEQ-1; Mon, 04 Nov 2024 07:32:59 -0500
X-MC-Unique: xIJPPbRTNCOf4lAKQPEdEQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-539e03bfd4aso2601315e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 04:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730723577; x=1731328377;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wYU1bYFt4awhT4ggXN0pyIL2cYzKGeU0iBusjO1/9ro=;
        b=YW4fhUOhTFH7syGhfy+pcuiDzmcF6JzyXRee1AGxJg1Wirb6Ctk7pFTqcm3r4YdB1B
         MyJ0RKuTFKmledxS59oVFMH7YeQm346FVfK6TcpEGlaJZ5KvEBgToEVJNLgz7WyBFsxG
         Ze97ifC9UvwyHa2BQExUCH4amvB8MOjlzWyp7HHYJSCFh0/4U739iOlGS9BPr+TKSFEg
         I4oV978LmpxuzqzuJnFGX54QfuHjGfSBii8TFDrreOp2O9XPlXMoS0/HVukHUiFEJB9D
         gbZ6RBl4lEecRf+PgEzSCgT67k/UjryRAbw1INQzntJyyZYC8B9HdUoN+TdehloqAE9D
         k6mA==
X-Forwarded-Encrypted: i=1; AJvYcCWy9UFswywd/IdBBvfxG+V5d31G1CYyb2gj3qJebSqFrdC4NaVO9YHm+ciORNE66/NEwM0O2sh9uV/cutk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1PppgyR6zlISxRVdj4EtyZPjKXqYhfVBdE5mc4dO3HSlEFcc
	mERwsIEk6OyfOQHh0Uli5/oCJZeL+/Yv4bYHuVnA/n+f/TI4ZT21XevIPuyTqzz9zUgeXnfkO5u
	/CUM1ZIpnhhp7wKvusEX16l2zpeVTg4HJOGFD/JX4WvFYAO1/TZzs/iUMay+U+Q==
X-Received: by 2002:a05:6512:1082:b0:539:fcf9:6332 with SMTP id 2adb3069b0e04-53b348e554bmr16047675e87.33.1730723577507;
        Mon, 04 Nov 2024 04:32:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+NlEYont2hkA0etOwQQnOUMeCONRWX8ce5tieOWvFRFKDsYCyyTxer9KqxMybhZxsN093GQ==
X-Received: by 2002:a05:6512:1082:b0:539:fcf9:6332 with SMTP id 2adb3069b0e04-53b348e554bmr16047659e87.33.1730723576937;
        Mon, 04 Nov 2024 04:32:56 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5c6623sm151386035e9.20.2024.11.04.04.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 04:32:56 -0800 (PST)
Message-ID: <3f943f72-59d6-4124-96b2-e0bb8d7a5ebd@redhat.com>
Date: Mon, 4 Nov 2024 13:32:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and swapin
To: Barry Song <21cnbao@gmail.com>, Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Andi Kleen <ak@linux.intel.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20241102101240.35072-1-21cnbao@gmail.com>
 <6c14ab2c-7917-489b-b51e-401d208067f3@gmail.com>
 <CAGsJ_4wpdf6Fky7jj8O6OuLc0WTBjKXTfEqxE0cXiUjxxuLgZA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4wpdf6Fky7jj8O6OuLc0WTBjKXTfEqxE0cXiUjxxuLgZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.11.24 13:59, Barry Song wrote:
> On Sat, Nov 2, 2024 at 8:32 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 02/11/2024 10:12, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> When the proportion of folios from the zero map is small, missing their
>>> accounting may not significantly impact profiling. However, it’s easy
>>> to construct a scenario where this becomes an issue—for example,
>>> allocating 1 GB of memory, writing zeros from userspace, followed by
>>> MADV_PAGEOUT, and then swapping it back in. In this case, the swap-out
>>> and swap-in counts seem to vanish into a black hole, potentially
>>> causing semantic ambiguity.
>>>
>>> We have two ways to address this:
>>>
>>> 1. Add a separate counter specifically for the zero map.
>>> 2. Continue using the current accounting, treating the zero map like
>>> a normal backend. (This aligns with the current behavior of zRAM
>>> when supporting same-page fills at the device level.)
>>>
>>> This patch adopts option 1 as pswpin/pswpout counters are that they
>>> only apply to IO done directly to the backend device (as noted by
>>> Nhat Pham).
>>>
>>> We can find these counters from /proc/vmstat (counters for the whole
>>> system) and memcg's memory.stat (counters for the interested memcg).
>>>
>>> For example:
>>>
>>> $ grep -E 'swpin_zero|swpout_zero' /proc/vmstat
>>> swpin_zero 1648
>>> swpout_zero 33536
>>>
>>> $ grep -E 'swpin_zero|swpout_zero' /sys/fs/cgroup/system.slice/memory.stat
>>> swpin_zero 3905
>>> swpout_zero 3985
>>>
>>> Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
>> I don't think its a hotfix (or even a fix). It was discussed in the initial
>> series to add these as a follow up and Joshua was going to do this soon.
>> Its not fixing any bug in the initial series.
> 
> I would prefer that all kernel versions with zeromap include this
> counter; otherwise,
> it could be confusing to determine where swap-in and swap-out have occurred,
> as shown by the small program below:
> 
> p =malloc(1g);
> write p to zero
> madvise_pageout
> read p;
> 
> Previously, there was 1GB of swap-in and swap-out activity reported, but
> now nothing is shown.
> 
> I don't mean to suggest that there's a bug in the zeromap code; rather,
> having this counter would help clear up any confusion.
> 
> I didn't realize Joshua was handling it. Is he still planning to? If
> so, I can leave it
> with Joshua if that was the plan :-)
> 
>>
>>> Cc: Usama Arif <usamaarif642@gmail.com>
>>> Cc: Chengming Zhou <chengming.zhou@linux.dev>
>>> Cc: Yosry Ahmed <yosryahmed@google.com>
>>> Cc: Nhat Pham <nphamcs@gmail.com>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> Cc: Shakeel Butt <shakeel.butt@linux.dev>
>>> Cc: Andi Kleen <ak@linux.intel.com>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: Chris Li <chrisl@kernel.org>
>>> Cc: "Huang, Ying" <ying.huang@intel.com>
>>> Cc: Kairui Song <kasong@tencent.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> ---
>>>   -v2:
>>>   * add separate counters rather than using pswpin/out; thanks
>>>   for the comments from Usama, David, Yosry and Nhat;
>>>   * Usama also suggested a new counter like swapped_zero, I
>>>   prefer that one be separated as an enhancement patch not
>>>   a hotfix. will probably handle it later on.
>>>
>> I dont think either of them would be a hotfix.
> 
> As mentioned above, this isn't about fixing a bug; it's simply to ensure
> that swap-related metrics don't disappear.

Documentation/process/submitting-patches.rst:

"A Fixes: tag indicates that the patch fixes an issue in a previous 
commit. It is used to make it easy to determine where a bug originated, 
which can help review a bug fix."

If there is no BUG, I'm afraid you are abusing that tag.

Also, I don't really understand the problem? We added an optimization, 
great. Who will be complaining about that?

Above you write "it could be confusing to determine where swap-in and 
swap-out have occurred" -- when is that confusion supposed to happen in 
practice? How will the confused individuals know that they must take a 
look at that new metric, even if it is in place?

I think we should just add the new stats and call it a day.

-- 
Cheers,

David / dhildenb


