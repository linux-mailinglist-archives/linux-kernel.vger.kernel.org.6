Return-Path: <linux-kernel+bounces-316067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9A896CAC0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E4E28780B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2EC176242;
	Wed,  4 Sep 2024 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma3MqKa9"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC747F4D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725492233; cv=none; b=MIXQEmsQx7GhR7cGXQ56SjXk66VIf5r9cNFItiKTgx6WbpkI1pDu85hHasXUp63E8C6IWpdWXXfahpGQcmVHE6EirALl6y0K4/bO7TOWW1C6KujPWopkXiNXAsIFA8eOtv6TbIJaXYuxB705KvakSiFho3sgqqB1Cy0RxvqlZzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725492233; c=relaxed/simple;
	bh=rJcxeUNS/Zz8Jr+GLg5woqYCkVl38jqNpG7X3I7If90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlECEDHWkSIVKM56WpMIgtNzsnuwu9V8ymMY9cuVulj+Qk43ZBZcHgdhCpgS+3P5sYRy13wZtg2zc0yuFKXFJMO9EauUZ0z8GZvEXZIbgij0YKVYK/mBNVhnZO1lBaIHSYpbZf4LC+16Ev4sbQOPbUfMLEMAZ7h1wDTxKdigraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma3MqKa9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42bb8cf8abeso450675e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 16:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725492229; x=1726097029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BiTb7LH4fqeIoEg+GobGmbCm8qwvMMZGYKK0A6xILq0=;
        b=Ma3MqKa95mvulnjg+b9PRLAqpcTIpj6mV3FeZ8Zc2Nr4kynFbOhPLY6Vie28QDkSsU
         L5k3LVWTfqUPAeYKPXs5SX/ZVC30eLwjD8LJHrKUSzPFdkvgBRVqm4/DfEcylWEpoC9v
         Rt6vuQkhGxxISZV7tr2vneGnfZD2R1Cxm9y5R4/YUEDcnn+bOrYDYCw/7mEB5UI3UD8a
         m+yKfazv/FR3mu7mWjnHLxd1eN4qrnnpjucYCju2m+mfVTaIdGAMKPrsXnvVBdUHeh3p
         0KI0PJfxhJCHqTtl4gqma2qHfnXAXbqDG4xEOtF6+y8ji5JtTD3EBYBcFX5/023jabk4
         oMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725492229; x=1726097029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BiTb7LH4fqeIoEg+GobGmbCm8qwvMMZGYKK0A6xILq0=;
        b=wHAzXThhw58J2TU3M6RzUxn/0AfXlvakKiNMsc6e+eq40MMownaQ//1UFZYn1UuKDE
         CwpWlMw2+ZH9EqBW6Yzd9cMiObt3odRmj9qDslZz7JQ2+ijSBdOfHKEYOx7TRDg+3dJS
         qtrqtGi/1tcAK6aZ9sMvC2LgIN79fp/Df9Rkb1C3UwKOMiCkMgDC0yU8ukqz7Ro8xPpH
         d1fR1Iz+OgYUO3Ufo9vpORAGktQK/O9aNiW/KlnfAJe2qqyRngBxilC5dfgM3vVgCTh/
         kTCuDAyh+0Z9YMuTYgMmaHuaEeWkJ0pjAbiARDUTa/UZJ4H22W5i8NPSdXgnTimgohsc
         JuvA==
X-Forwarded-Encrypted: i=1; AJvYcCVs+05ohvrw3xNveuiPnTYtCQV6/rw/xn81D43s/Z2xx8RhTTwwcyIrHbmlBNsJ1oHrj/8DoDQ5DFwh53o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEOJ7bv0IxOxT6iQtgjvhS2I1Zl/DJu/B5vTDK7KVK62JsQmxu
	xsq5LXwA6t8q59vJcAGki4RYmvKIOzmPPl0nNn9WaNmnNcPQBFNU
X-Google-Smtp-Source: AGHT+IFzoYwnFMj2Xh2bpT8OPwF50goTtMqOi3vdctTDCW4lq4WU/KntXi0cjXhqDZ8qjeoAaBzEIQ==
X-Received: by 2002:adf:f747:0:b0:376:27b7:da7d with SMTP id ffacd0b85a97d-376dd71ab0fmr4158311f8f.32.1725492228534;
        Wed, 04 Sep 2024 16:23:48 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b67ff88dsm15059306f8f.26.2024.09.04.16.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 16:23:48 -0700 (PDT)
Message-ID: <bf232555-3653-40c7-bbdc-a8fe58a93a9e@gmail.com>
Date: Thu, 5 Sep 2024 00:23:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io
 devices
To: Barry Song <21cnbao@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Kairui Song <ryncsn@gmail.com>,
 hanchuanhua@oppo.com, linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
 chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, hughd@google.com,
 kaleshsingh@google.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
 minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com,
 senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 xiang@kernel.org, ying.huang@intel.com, hch@infradead.org
References: <20240821074541.516249-1-hanchuanhua@oppo.com>
 <20240821074541.516249-3-hanchuanhua@oppo.com>
 <CAMgjq7BpOqgKoeQEPCL9ai3dvVPv7wJe3k_g1hDjAVeCLpZ=7w@mail.gmail.com>
 <CAJD7tka+ZONNFKw=1FM22b-JTPkiKZaKuM3Upyu6pf4=vN_CRg@mail.gmail.com>
 <20240903130757.f584c73f356c03617a2c8804@linux-foundation.org>
 <CAGsJ_4wjgPS1Pj_RbLcpXH3dx2StCdSiUo5AL7vQFPZGyzESAQ@mail.gmail.com>
 <CAJD7tkaXvm95mRH04OX0KJtiBuTaaDyyJQirbAjUV0B+DjaWJA@mail.gmail.com>
 <94eb70cd-b508-42ef-b5d2-acc29e22eb0e@gmail.com>
 <CAGsJ_4yX7xmyDokYgc_H7MaxcOptcLeQs-SB1O22bSRHFdvVhQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4yX7xmyDokYgc_H7MaxcOptcLeQs-SB1O22bSRHFdvVhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/09/2024 00:10, Barry Song wrote:
> On Thu, Sep 5, 2024 at 9:30 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 03/09/2024 23:05, Yosry Ahmed wrote:
>>> On Tue, Sep 3, 2024 at 2:36 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>
>>>> On Wed, Sep 4, 2024 at 8:08 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>>>
>>>>> On Tue, 3 Sep 2024 11:38:37 -0700 Yosry Ahmed <yosryahmed@google.com> wrote:
>>>>>
>>>>>>> [   39.157954] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000007
>>>>>>> [   39.158288] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
>>>>>>> [   39.158634] R13: 0000000000002b9a R14: 0000000000000000 R15: 00007ffd619d5518
>>>>>>> [   39.158998]  </TASK>
>>>>>>> [   39.159226] ---[ end trace 0000000000000000 ]---
>>>>>>>
>>>>>>> After reverting this or Usama's "mm: store zero pages to be swapped
>>>>>>> out in a bitmap", the problem is gone. I think these two patches may
>>>>>>> have some conflict that needs to be resolved.
>>>>>>
>>>>>> Yup. I saw this conflict coming and specifically asked for this
>>>>>> warning to be added in Usama's patch to catch it [1]. It served its
>>>>>> purpose.
>>>>>>
>>>>>> Usama's patch does not handle large folio swapin, because at the time
>>>>>> it was written we didn't have it. We expected Usama's series to land
>>>>>> sooner than this one, so the warning was to make sure that this series
>>>>>> handles large folio swapin in the zeromap code. Now that they are both
>>>>>> in mm-unstable, we are gonna have to figure this out.
>>>>>>
>>>>>> I suspect Usama's patches are closer to land so it's better to handle
>>>>>> this in this series, but I will leave it up to Usama and
>>>>>> Chuanhua/Barry to figure this out :)
>>>>
>>>> I believe handling this in swap-in might violate layer separation.
>>>> `swap_read_folio()` should be a reliable API to call, regardless of
>>>> whether `zeromap` is present. Therefore, the fix should likely be
>>>> within `zeromap` but not this `swap-in`. I’ll take a look at this with
>>>> Usama :-)
>>>
>>> I meant handling it within this series to avoid blocking Usama
>>> patches, not within this code. Thanks for taking a look, I am sure you
>>> and Usama will figure out the best way forward :)
>>
>> Hi Barry and Yosry,
>>
>> Is the best (and quickest) way forward to have a v8 of this with
>> https://lore.kernel.org/all/20240904055522.2376-1-21cnbao@gmail.com/
>> as the first patch, and using swap_zeromap_entries_count in alloc_swap_folio
>> in this support large folios swap-in patch?
> 
> Yes, Usama. i can actually do a check:
> 
> zeromap_cnt = swap_zeromap_entries_count(entry, nr);
> 
> /* swap_read_folio() can handle inconsistent zeromap in multiple entries */
> if (zeromap_cnt > 0 && zeromap_cnt < nr)
>        try next order;
> 
> On the other hand, if you read the code of zRAM, you will find zRAM has
> exactly the same mechanism as zeromap but zRAM can even do more
> by same_pages filled. since zRAM does the job in swapfile layer, there
> is no this kind of consistency issue like zeromap.
> 
> So I feel for zRAM case, we don't need zeromap at all as there are duplicated
> efforts while I really appreciate your job which can benefit all swapfiles.
> i mean, zRAM has the ability to check "zero"(and also non-zero but same
> content). after zeromap checks zeromap, zRAM will check again:
> 

Yes, so there is a reason for having the zeromap patches, which I have outlined
in the coverletter.

https://lore.kernel.org/all/20240627105730.3110705-1-usamaarif642@gmail.com/

There are usecases where zswap/zram might not be used in production.
We can reduce I/O and flash wear in those cases by a large amount.

Also running in Meta production, we found that the number of non-zero filled
complete pages were less than 1%, so essentially its only the zero-filled pages
that matter.

I believe after zeromap, it might be a good idea to remove the page_same_filled 
check from zram code? Its not really a problem if its kept as well as I dont
believe any zero-filled pages should reach zram_write_page?

> static int zram_write_page(struct zram *zram, struct page *page, u32 index)
> {
>        ...
> 
>         if (page_same_filled(mem, &element)) {
>                 kunmap_local(mem);
>                 /* Free memory associated with this sector now. */
>                 flags = ZRAM_SAME;
>                 atomic64_inc(&zram->stats.same_pages);
>                 goto out;
>         }
>         ...
> }
> 
> So it seems that zeromap might slightly impact my zRAM use case. I'm not
> blaming you, just pointing out that there might be some overlap in effort
> here :-)
> 
>>
>> Thanks,
>> Usama
> 
> Thanks
> Barry


