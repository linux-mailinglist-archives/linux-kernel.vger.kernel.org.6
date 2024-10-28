Return-Path: <linux-kernel+bounces-384913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3099C9B3012
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C3C28256D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9293A1D95B1;
	Mon, 28 Oct 2024 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9ywe2ZJ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23617C61
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118197; cv=none; b=rvCitei8SOf+4hu7s0QK3ZkrCevRORJmu/mlO7ZofMKEjIxUDnrF25SogsgDRPKqDT+QzgfKC2Gy0bof6TM8vrOL1j4M0QitzGEohSSFBsn/nj2bbiCDsvWydeEyFjfddu6UpuDvLQkWrnKb3Iqhh7hh96W/bpuXH/xNwjVISVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118197; c=relaxed/simple;
	bh=YeGo71NMQZCHx3vvNXrEmxNOxjUdfm3WVB4LcFNfmK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmjCZago8uvK6K90/eMk5bUmmRlv1gVN79bNpb5+QYrhto3H1VVeyH80kqI3ivH8N1YcjNrbh10CjK25jkLRkNZ0Y5XCTGCVy98vJIyxIzKPZDO2rdzI5Bd1lzG/q9SsokkzZwx0pwm08LxUsMzAkx6Ivfs3eVwlJfI0ZQWXdIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9ywe2ZJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so520230466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730118194; x=1730722994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ga+QC/cz6mBGu37O80ejWdpJXnenUBU6ztw+p/e2ORg=;
        b=R9ywe2ZJZbtNQsbDXmnSdaWdoYSCXNkdji5YFG+B8eYBx+QUyU0H/FkdwHtWxvqYtG
         ldc9koTskWuFnGlEfp/G0tihDaA9YDctZQ7xEsEQkTruWLdnkhOLXNjpzubNBvbLfXMF
         3cASVy2DpdnRHsB1HDF5Vvk+ME9gXoRAzfMfMKyexlvI5n1/EG5KOd6zs/BYruOQnt3y
         qkzOwHU/LWjjYm+GI1r4YEziwk0yRl8Du5B3YB4TDClTQmVgHG8XoiKtJ5NLcKC2f+JT
         XB4b7KUAMuyn092Ci2WiKf7wy8direhapfXAaL0yE4hdKafhqHZNDLa8mQ0x17Tzu4An
         1+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730118194; x=1730722994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ga+QC/cz6mBGu37O80ejWdpJXnenUBU6ztw+p/e2ORg=;
        b=SHO7xiztGyUXRirr7r046RsieoJLe4lgOSInv6Zrs8wzsHwa/ZaJc6RBLjDzko2dz5
         vdjzOpq/wAV66w5mZfiQKH3I109jiaS3e0sCzIGcX+uw5sC2rfz0hoc8qZPs9QQrAmcM
         vPI81FUvE2IME0wFsVDFBnkTp6unT47YI3lHur+W88OFE4q7ot54ydDs21SUZVRfpfVh
         +TwOX+TY9Z9eS1bys0yuV65vINTFGP1UqAfMR46wBbJ/7RjWeGWIUoh4AmjsZDDLl1KK
         4w1BDtD6YU6nj+SMz73hBcNGoRm8/+CE4VHU9mkg7ReW1IAL8UU2YotnRMWqlM/hbWJS
         JNqw==
X-Forwarded-Encrypted: i=1; AJvYcCWjRK+nl1hC2AR6SwOxiAHS52JQP6SOkVD0b1qx6SSbtPj3BFzjUZkZJHONymsPMVizcsC7MZ3OlDJcm2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZMOgIEAauiCy8SPPHtLi6aPk4cBUBIATwNFW3wSwNp7l5fkBS
	n7rhfCvdEaHIxSBJrfwH85GchjHtwISvLTbEKnP86+qddMq7nHZv
X-Google-Smtp-Source: AGHT+IFYjdhxWYM6GXoFR/9NZTPQUJjmCFU0rAVx4YAoHkudOwBd74AhcCJFnvrsWt5R9NYIdRIemg==
X-Received: by 2002:a17:907:9487:b0:a99:c0be:a8ac with SMTP id a640c23a62f3a-a9de5ee477dmr784336266b.37.1730118193712;
        Mon, 28 Oct 2024 05:23:13 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::5:1494])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a086f6dsm371115666b.214.2024.10.28.05.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 05:23:13 -0700 (PDT)
Message-ID: <678a1e30-4962-48de-b5cb-03a1b4b9db1b@gmail.com>
Date: Mon, 28 Oct 2024 12:23:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Barry Song <21cnbao@gmail.com>, Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Andi Kleen <ak@linux.intel.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
References: <20241027011959.9226-1-21cnbao@gmail.com>
 <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
 <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28/10/2024 02:32, Barry Song wrote:
> On Sun, Oct 27, 2024 at 3:45 PM Nhat Pham <nphamcs@gmail.com> wrote:
>>
>> On Sat, Oct 26, 2024 at 6:20 PM Barry Song <21cnbao@gmail.com> wrote:
>>>
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> When the proportion of folios from the zero map is small, missing their
>>> accounting may not significantly impact profiling. However, it’s easy
>>> to construct a scenario where this becomes an issue—for example,
>>> allocating 1 GB of memory, writing zeros from userspace, followed by
>>> MADV_PAGEOUT, and then swapping it back in. In this case, the swap-out
>>> and swap-in counts seem to vanish into a black hole, potentially
>>> causing semantic ambiguity.
>>
>> I agree. It also makes developing around this area more challenging.
>> I'm working on the swap abstraction, and sometimes I can't tell if I
>> screwed up somewhere, or if a proportion of these allocated entries go
>> towards this optimization...
>>
>> Thanks for taking a stab at fixing this, Barry!
>>
>>>
>>> We have two ways to address this:
>>>
>>> 1. Add a separate counter specifically for the zero map.
>>> 2. Continue using the current accounting, treating the zero map like
>>> a normal backend. (This aligns with the current behavior of zRAM
>>> when supporting same-page fills at the device level.)
>>
>> Hmm, my understanding of the pswpout/pswpin counters is that they only
>> apply to IO done directly to the backend device, no? That's why we
>> have a separate set of counters for zswap, and do not count them
>> towards pswp(in|out).
>>
>> For users who have swap files on physical disks, the performance
>> difference between reading directly from the swapfile and going
>> through these optimizations could be really large. I think it makes
>> sense to have a separate set of counters for zero-mapped pages
>> (ideally, both at the host level and at the cgroup level?)
> 
> agree it is better to have a separate counter for zeromap.
> then it raises a question: what is the proper name for it :-)
> 
> zeromap_swpin, zeromap_swpout seems too long? and zswpin
> and zswpout have been used by zswap
> 
> Thanks
> barry

I wonder if instead of having counters, it might be better to keep track
of the number of zeropages currently stored in zeromap, similar to how
zswap_same_filled_pages did it. It will be more complicated then this
patch, but would give more insight of the current state of the system.

Joshua (in CC) was going to have a look at that.

Thanks,
Usama

 


