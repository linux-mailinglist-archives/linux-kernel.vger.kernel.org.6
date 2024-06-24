Return-Path: <linux-kernel+bounces-227522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAD19152A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00141C2105E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1663A19CCFB;
	Mon, 24 Jun 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA0pRI3/"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42341DFEF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243547; cv=none; b=uyAFD3Jf9wFSd3eRFNsb1xib9Yipe/sRkCQf+66mQY0A1GicercQNV0RCinSaP/xNBiBTLBloH77yxmyLm6vIgZ+GaTO4OvgXj3dkKGgt+xn4EARegWU2rY1/TfKDZazaiGehlhtEaQPwjSGiw1QFMpCicQzfpoKysmh4XjVb3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243547; c=relaxed/simple;
	bh=fkGCYYnByBUPtMADuMf2BMlTvJbpDBTQEAVZpRdutEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZZKv9lZEoOIwZ2ZEre/Kr8zJpaCmFNogSZiDIFtl1y9VDOtBCbsuYnnh8/NAG0tMUYwQ2g/Jur3DFte2UOUrwxOEIEZFvTxo9/+gxTtwUfTcCJ7nb1P+giuBUyPzfe8jz/54C91Mgje63LTf4+ExemN0dHmI5+vyI3PRWPvxpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jA0pRI3/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-421bb51d81aso37456965e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719243544; x=1719848344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HPcPd9wy1fSfjdoXcI4T31fTF+D9RtkuwE8EltBejPw=;
        b=jA0pRI3/96l0IJUOF1v8Tpu1q4jdezemAkxLCgez9bBO4UOKeF6ZjXqIWA/t5hXxRq
         NwT1vx8Ow3D0hU0haVWRnzAx3FeHhS89GCG6PfcKqD74myq4vok9gESB713NWyYWtWTq
         ok5Lr7IhuNkP8GaScAHEut91vNbUkV9BPCsgPe7j4SfEdtD4C94n1M11qwWF7pJWHf6D
         CXD8oJ6P/kIiI/8fW37N9+nnX7aMHQjHHNlBMy8rxrtKGQ3+iKkiaaNgcw8Pk1ZxtHcp
         fV+6/2gRKAYTN+/bwbgfoCaElOgwubkULFDvF+dvFHiRV3yYKpx+1Bxr3UKK+MFajf+A
         wLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719243544; x=1719848344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPcPd9wy1fSfjdoXcI4T31fTF+D9RtkuwE8EltBejPw=;
        b=r5oEAtHi4PKS5a1hcya+8LNKJEtP+SWDHqXWMhCNapwMPJirw7pk5WbROpMIb5moou
         KJiYkKu8opUeq1NpEDjSlLK2qw1I2uj/SmB21mc3kYXD4/LIlsvI9mxuZQUWmRipFdqI
         nBtR3t/unsOXubTkAyKG6liFhuECQGEeUaDf4d6AqVOUO82RAtP20R4aNz5ez+szRcp/
         CQ6xKM9VNgOFa/ryM+BDJS61WoVydfP2bsmdibGmfeNe+CAJ/t96W35pl3EriViUHVuJ
         MJL1OQCQcb6r+Kms+73K3Hzy8GUZlywVzNJlcjRfZBbU28iToX7u41odxJiSYTJup+w7
         kSsg==
X-Forwarded-Encrypted: i=1; AJvYcCVju6DN9NcH94JGgyFqreYOv32FMC6bsjrpkuw2TCCjW/EFlCJVe9qV65SFsisYvX9CzILipJZow+/zT3Ayd7kkIHD1cDehKEL1Iqf/
X-Gm-Message-State: AOJu0Yxfen0VtyE9Kb0FNiYnEwTwbRdXbrou3BQCfpLb0V18qbMoz59x
	+OvBYTn9oIMbnXMhtvU3J361ahQOD44Z2GgAyGHVVhbgHBh8kpRn
X-Google-Smtp-Source: AGHT+IEKItbua/CYYFygu+88L+0laEZhLABVve6WLN9uF33edGgRXGcJjBtKahS8k9Dy8kc+1m3BWw==
X-Received: by 2002:a7b:cc89:0:b0:421:7f4d:525f with SMTP id 5b1f17b1804b1-4248cc35da7mr33607055e9.24.1719243543832;
        Mon, 24 Jun 2024 08:39:03 -0700 (PDT)
Received: from ?IPV6:2001:16a2:df66:b900:46d:aa3:6645:bcd8? ([2001:16a2:df66:b900:46d:aa3:6645:bcd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c54c9sm179753455e9.27.2024.06.24.08.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 08:39:03 -0700 (PDT)
Message-ID: <5b3e732c-d23d-41ef-ae5c-947fa3e866ab@gmail.com>
Date: Mon, 24 Jun 2024 18:39:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm] 0fa2857d23:
 WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
To: Hugh Dickins <hughd@google.com>
Cc: Yosry Ahmed <yosryahmed@google.com>,
 kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chengming Zhou <chengming.zhou@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
 David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org
References: <202406241651.963e3e78-oliver.sang@intel.com>
 <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <12fb19d1-3e57-4880-be59-0e83cdc4b7f1@gmail.com>
 <61d19ec8-2ba7-e156-7bb7-f746dae8e120@google.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <61d19ec8-2ba7-e156-7bb7-f746dae8e120@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24/06/2024 18:26, Hugh Dickins wrote:
> On Mon, 24 Jun 2024, Usama Arif wrote:
>> On 24/06/2024 15:05, Yosry Ahmed wrote:
>>> On Mon, Jun 24, 2024 at 1:49 AM kernel test robot <oliver.sang@intel.com>
>>> wrote:
>>>>
>>>> Hello,
>>>>
>>>> kernel test robot noticed
>>>> "WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof" on:
>>>>
>>>> commit: 0fa2857d23aa170e5e28d13c467b303b0065aad8 ("mm: store zero pages to
>>>> be swapped out in a bitmap")
>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>> This is coming from WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp), and
>>> is triggered by the new bitmap_zalloc() call in the swapon path. For a
>>> sufficiently large swapfile, bitmap_zalloc() (which uses kmalloc()
>>> under the hood) cannot be used to allocate the bitmap.
>>>
>>> Usama, I think we want to use a variant of kvmalloc() here.
> Yes, I hit the same problem with swapon in my testing,
> and had been intending to send a patch.
>
>> Yes, just testing with below diff now. The patch is not in mm-stable yet, so
>> will just send another revision with below diff included. Thanks!
>>
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 0b8270359bcf..2263f71baa31 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -2643,7 +2643,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *,
>> specialfile)
>>          free_percpu(p->cluster_next_cpu);
>>          p->cluster_next_cpu = NULL;
>>          vfree(swap_map);
>> -       bitmap_free(p->zeromap);
>> +       kvfree(p->zeromap);
> Yes.
>
>>          kvfree(cluster_info);
>>          /* Destroy swap account information */
>>          swap_cgroup_swapoff(p->type);
>> @@ -3170,7 +3170,7 @@ SYSCALL_DEFINE2(swapon, const char __user *,
>> specialfile, int, swap_flags)
>>                  goto bad_swap_unlock_inode;
>>          }
>>
>> -       p->zeromap = bitmap_zalloc(maxpages, GFP_KERNEL);
>> +       p->zeromap = kvzalloc(DIV_ROUND_UP(maxpages, 8), GFP_KERNEL);
> No, 8 is not right for 32-bit kernels. I think you want
> 	p->zeromap = kvzalloc(BITS_TO_LONGS(maxpages), GFP_KERNEL);
> but please check it carefully, I'm easily confused by such conversions.
>
> Hugh

Ah yes, didnt take into account 32-bit kernel. I think its supposed to be

  p->zeromap = kvzalloc(BITS_TO_LONGS(maxpages) * sizeof(unsigned long), 
GFP_KERNEL);

if using BITS_TO_LONGS.

Will wait sometime incase there are more comments and will send out 
another version.

Thanks!

>>          if (!p->zeromap) {
>>                  error = -ENOMEM;
>>                  goto bad_swap_unlock_inode;

