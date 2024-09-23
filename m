Return-Path: <linux-kernel+bounces-335734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE3197E9DA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA531C212D9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB40F1957F9;
	Mon, 23 Sep 2024 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlhjaCDd"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB2EADA
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086957; cv=none; b=IKk/NiI4irB39IHYFC7EDQ4qIEasbhl4V9atMCif4LGUlEt8SmxCUorNuiJwx3UvFHAXLdibePnWaQzAfDdNLxqN+AMWj5/y7vyPaWri3m/JUi63RPXuFBBJ0Hz65V6FdlStTLMntl9SCTt+4b1gmp2YGUbwNploKdEkKfad0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086957; c=relaxed/simple;
	bh=ULEosab4YkH7BBoxzdq2JOjgnOTidIP5JQjnE+lLZyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZO1s0+l6RhTCNhkrnMXfE8m0RJQrNe2nsk7GsW8tAC8v+1MZFhBres3je+0vGKfV6YShEf7BD+DTz61bjwfYbB2XNbrX/8VbSe8sEXsmnYP2HCm9WbKEJzTv9xIHA8Wc7+WYl/26x5VPeAjj1QCDWZP9L9UOXYip26IQBB9NF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlhjaCDd; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f8ca33ef19so5988681fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 03:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727086953; x=1727691753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0uuKdeGezjZc5UnHOkWvAYXuGVRFJ2H/2YngeFELEQ=;
        b=jlhjaCDdJHZFESPmHpL6izXAeiSYqIjMEuBddv0nFoQghIRFvDo3lDtW/Ri84s5/t+
         QHMv8eW8tz+tEa0wOhAtOd6nXqgv90bZVlRTXL0GaBgXMglH5g1/aNu3dJu7fszvrw4o
         Ad+v1Y7+XKtMQhZ8TXlhN1XVwzOFj6TatRNpOjNdnOlUpLqP89Z2pxh0GyY3cxwlIMPt
         39/BQe9TmmGG1VVz9TBXzdOuoa0yExjz/xYrvcReAyObmd8yXbHuqg+V7SDy1FcmB+45
         YPFbwH8UxwonvB+5laRf4mEsR6qhfex8uU2/WLC1PZci+k/F8rSrwbdbHv+Q/eIzMXvl
         IIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727086953; x=1727691753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0uuKdeGezjZc5UnHOkWvAYXuGVRFJ2H/2YngeFELEQ=;
        b=fmKON25rMcQhj9/EZ3cELRa7DDP1RD/lz7Hm5bshpwYu17chAZ09j/nfZnYI09pAw9
         2SLOqQNDBjZH4q/DrMq+1rDTGtEHVxdzBBQpkpdgSX+1K6bsA1yvvnM1Rk9Eg0IWmABN
         rQ5PIu10ewzkDMybuB5gzQV5rexRZyBC2hGc0hNmh5KoRVAVgSPomk1tZfP0wnKq5Sfy
         OfxEsCjrb+jW7agSSrpoQe+b8eynj6qCW7CSDVLGCnhFSV4gVbNCHPg2QFBWmKu/pQj9
         a8LYOpQ+Ig8qqAs3WpHkcz23wLQERIFi0QwksOtI9jfwHdoKv5SdWi4rUQXytW7RYT6O
         KdpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCUubsG2vKOwjzkDYLCM3OJyMCcrbAGltoj9HVLULEBF4iinYb4bTd+BNsenEW94YojuRwacgE79aAycA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPHwzUMknrh0vf+Z2Ho5z3V9hqpwN+spohP0xXLjhwKrQZLB0f
	IZ3sTF3mPJXvX7BgQaoFgaWfiUxjp2ZNM6nTLYcRVeSKWbsRwVar
X-Google-Smtp-Source: AGHT+IGsAWMklqsvh12ib54u9c5KIkHgI6oDOMOya6Vik+HzuQP8fqL/PpJOBar2JIdHosXGpXcp3Q==
X-Received: by 2002:a2e:9e04:0:b0:2f6:6198:1cf9 with SMTP id 38308e7fff4ca-2f7cb358243mr53564731fa.31.1727086952924;
        Mon, 23 Sep 2024 03:22:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:274b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90979ceb67sm878196466b.219.2024.09.23.03.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 03:22:32 -0700 (PDT)
Message-ID: <2c418b81-8f67-4a45-b4d2-d158fa4f05d9@gmail.com>
Date: Mon, 23 Sep 2024 11:22:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io
 devices
To: Barry Song <21cnbao@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song
 <ryncsn@gmail.com>, hanchuanhua@oppo.com, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
 linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org,
 nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org,
 shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, hch@infradead.org, Hailong Liu <hailong.liu@oppo.com>
References: <20240821074541.516249-1-hanchuanhua@oppo.com>
 <20240821074541.516249-3-hanchuanhua@oppo.com>
 <CAMgjq7BpOqgKoeQEPCL9ai3dvVPv7wJe3k_g1hDjAVeCLpZ=7w@mail.gmail.com>
 <CAJD7tka+ZONNFKw=1FM22b-JTPkiKZaKuM3Upyu6pf4=vN_CRg@mail.gmail.com>
 <20240903130757.f584c73f356c03617a2c8804@linux-foundation.org>
 <CAGsJ_4wjgPS1Pj_RbLcpXH3dx2StCdSiUo5AL7vQFPZGyzESAQ@mail.gmail.com>
 <CAJD7tkaXvm95mRH04OX0KJtiBuTaaDyyJQirbAjUV0B+DjaWJA@mail.gmail.com>
 <94eb70cd-b508-42ef-b5d2-acc29e22eb0e@gmail.com>
 <CAGsJ_4yX7xmyDokYgc_H7MaxcOptcLeQs-SB1O22bSRHFdvVhQ@mail.gmail.com>
 <bf232555-3653-40c7-bbdc-a8fe58a93a9e@gmail.com>
 <CAJD7tkYu2v2VnMizVeOTHTNXXbdnd+UqaKhTRfrTC7THUiPPdA@mail.gmail.com>
 <CAGsJ_4wd=6kuwg7v=_ARb+Ay15M8SU776Vjb4rmtiVp8vQg-qA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4wd=6kuwg7v=_ARb+Ay15M8SU776Vjb4rmtiVp8vQg-qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23/09/2024 00:57, Barry Song wrote:
> On Thu, Sep 5, 2024 at 7:36 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>>
>> [..]
>>>>
>>>> On the other hand, if you read the code of zRAM, you will find zRAM has
>>>> exactly the same mechanism as zeromap but zRAM can even do more
>>>> by same_pages filled. since zRAM does the job in swapfile layer, there
>>>> is no this kind of consistency issue like zeromap.
>>>>
>>>> So I feel for zRAM case, we don't need zeromap at all as there are duplicated
>>>> efforts while I really appreciate your job which can benefit all swapfiles.
>>>> i mean, zRAM has the ability to check "zero"(and also non-zero but same
>>>> content). after zeromap checks zeromap, zRAM will check again:
>>>>
>>>
>>> Yes, so there is a reason for having the zeromap patches, which I have outlined
>>> in the coverletter.
>>>
>>> https://lore.kernel.org/all/20240627105730.3110705-1-usamaarif642@gmail.com/
>>>
>>> There are usecases where zswap/zram might not be used in production.
>>> We can reduce I/O and flash wear in those cases by a large amount.
>>>
>>> Also running in Meta production, we found that the number of non-zero filled
>>> complete pages were less than 1%, so essentially its only the zero-filled pages
>>> that matter.
>>>
>>> I believe after zeromap, it might be a good idea to remove the page_same_filled
>>> check from zram code? Its not really a problem if its kept as well as I dont
>>> believe any zero-filled pages should reach zram_write_page?
>>
>> I brought this up before and Sergey pointed out that zram is sometimes
>> used as a block device without swap, and that use case would benefit
>> from having this handling in zram. That being said, I have no idea how
>> many people care about this specific scenario.
> 
> Hi Usama/Yosry,
> 
> We successfully gathered page_same_filled data for zram on Android.
> Interestingly,
> our findings differ from yours on zswap.
> 
> Hailong discovered that around 85-86% of the page_same_filled data
> consists of zeros,
> while about 15% are non-zero. We suspect that on Android or similar
> systems, some
> graphics or media data might be duplicated at times, such as a red
> block displayed
> on the screen.
> 
> Does this suggest that page_same_filled could still provide some
> benefits in zram
> cases?

Hi Barry,

Thanks for the data, its very interesting to know this from mobile side.
Eventhough its not 99% that I observed, I do feel 85% is still quite high. 

The 2 main reasons for the patcheset to store zero pages to be
swapped out in a bitmap were for applications that use swap but
not zswap/zram (reducing I/O and flash wear), and simplifying zswap
code. It also meant fewer zswap_entry structs in memory which would
offset the memory usage by bitmap.

Yosry mentioned that Sergey pointed out that zram is sometimes
used as a block device without swap, and that use case would benefit
from having this handling in zram. Will that case also not go through
swap_writepage and therefore be takencare of by swap_info_struct->zeromap?

Also just curious if there are cases in mobile where only swap is used,
but not zswap/zram?

I think even with 85% zero-filled pages, we could get rid of page_same_filled
especially if the zram without swap case is handled by swap_info_struct->zeromap.
But don't have strong preference.

Thanks,
Usama

> 
> Thanks
> Barry


