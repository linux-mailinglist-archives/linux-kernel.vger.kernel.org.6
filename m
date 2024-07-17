Return-Path: <linux-kernel+bounces-254614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BA9933579
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32521B2119B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A44524F;
	Wed, 17 Jul 2024 02:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="b6lk2Rqc"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DCF33D8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721183863; cv=none; b=XIwVjOZNMlC08I2apZ5BCNzP9n2k1dd2jH9OLKqJyVGSm+kHQKNtnY+OEL4Jf8Vyy08CAB7pEOKfzPYmfSeSlihmUw6cc8Mku3MYLPFqEdwnIGxM1C7XVxFFWnTCSznonYabroE9EfbBI6pswZaV21bQb8dBevYkb00pkxtgiZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721183863; c=relaxed/simple;
	bh=FXMPrM1qCGCr3OLFEVevlMz1O9OpTpJhTPTmUE9Ka5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPxhm/CcESXkm5/PmCuEkTfTr/oivahCkF9rDIhRk5Pfo0QSImWBXLO9piz1tkbv3m6Urkx3v1/G20tCagq/gKlKzFK7asmNb1dAAwh3OfOHAHn5P/tHmCGoJ9wTk11rtCq+YtElWMaqAZpJcjo/i38kSVyTyGS/biI6kJn8bcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=b6lk2Rqc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc47aef524so602865ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721183861; x=1721788661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=114ba7afWbegVKrpGjSSbtb2X9YUkmvheq7EXrkXlHA=;
        b=b6lk2Rqcbg+XwHV/7m7gsZuDKdDXCvUK6QhV4boWjQvDexrFfuruqZX5j9FCDcFn8Q
         kYxd7sG0bTSlLSKyZAZYg23x0ByrfXszos1rsCbdOjgkoFyMs53MpCmYG8BLwHgvcWDV
         c8CGNNjsIkxa7OKXKjlII3NiArjWYuH+HN3rYixPkGxJ8VDdCkia8XQ/Jc+x+L8rO6f8
         o80H5W3MPUpHp6vLLkyicD6wiPUlN6vMxCgnBvrP+0UL1rv+zWCYMg3ppC6EYzVgtVaM
         Nv5JiZRbeI7MqeE3ggmI1+eklbQehU3UxPAlGCY7eRN9MM9/hfKSICAlQlklJiQUO90T
         mn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721183861; x=1721788661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=114ba7afWbegVKrpGjSSbtb2X9YUkmvheq7EXrkXlHA=;
        b=iSoVTBH4RnN+knHe3cFhSxaTmp2iNw28VTtTHWJ1d2X88XCuAqOT8ap1QMqaIj159F
         bSkq7LDDOR5/3Pj2933xmTfZmtmjeRkaKKyhcViF4OvRrH4wP4dPdfMlwo2rYKTPH32E
         4NzmF10JUMPC3KremFbDP3T42+jhNX1/+NAz/Xfe+WaURV/w0mB9bI/Nfst+zCW19HRt
         KcoQGi8i0tdNSZ2rme+AbGbW9EX1bEs5nRX2FkpIkJr6oqIrQOg6gjGu6lx8VhPeha/A
         3VO3Jtde+IpjICRL9BVj8nkN45jHcJDpBaU952yWeFDdzzW5vVXrfuUEz0PNONUTs7mI
         OK3g==
X-Forwarded-Encrypted: i=1; AJvYcCUcUo6RgIL0hAfyXYgG123gKPDM7eCLuqW1vPHDpOjExp9tUkP0lZ0RQdn+MbD0sTASM3erI9eScYjOWdYupt7pxrnFdEL9AimuVQ0t
X-Gm-Message-State: AOJu0YwO4WPjllMmQSF80M+eB1d7O4xcNvxuG4M2hKoMe8U/Hlng3XO+
	DQTYV/Qb6b2viC9l9CXj288sIyhJ0v6+2JzaNA0T6Oyc7/UACG+TXh8oA9uPxL8=
X-Google-Smtp-Source: AGHT+IFoQoV9mE+30zu4+WVXGHnLt3EsGGEc8xkdYBi/7jR1nk5tkhHYuIpXRK6XalruUy6GeRmSmw==
X-Received: by 2002:a05:6a21:501:b0:1c2:88eb:1d33 with SMTP id adf61e73a8af0-1c3fddbed90mr369794637.6.1721183860728;
        Tue, 16 Jul 2024 19:37:40 -0700 (PDT)
Received: from [10.255.168.175] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6ff95sm67292495ad.6.2024.07.16.19.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 19:37:40 -0700 (PDT)
Message-ID: <1823a31d-eecd-4877-ae3e-a81f95f06501@bytedance.com>
Date: Wed, 17 Jul 2024 10:37:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: list_lru: Fix NULL pointer dereference in
 list_lru_add()
Content-Language: en-US
To: Youling Tang <youling.tang@linux.dev>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20240712032554.444823-1-youling.tang@linux.dev>
 <sd32qchit33aafht27utinrz5dizw62qbtwdmwbtugqrlglmtx@6aitsotgqnpi>
 <56a81429-4e1e-46f9-8844-acb1afd66952@bytedance.com>
 <68e2ecad-e8ee-4dd5-a49e-8f8507d4e03c@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <68e2ecad-e8ee-4dd5-a49e-8f8507d4e03c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/17 10:25, Youling Tang wrote:
> On 15/07/2024 11:27, Qi Zheng wrote:
>>
>>
>> On 2024/7/12 12:07, Kent Overstreet wrote:
>>> On Fri, Jul 12, 2024 at 11:25:54AM GMT, Youling Tang wrote:
>>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>>
>>>> Note that list_lru_from_memcg_idx() may return NULL, so it is necessary
>>>> to error handle the return value to avoid triggering NULL pointer
>>>> dereference BUG.
>>>>
>>>> The issue was triggered for discussion [1],
>>>> Link [1]: 
>>>> https://lore.kernel.org/linux-bcachefs/84de6cb1-57bd-42f7-8029-4203820ef0b4@linux.dev/T/#m901bb26cdb1d9d4bacebf0d034f0a5a712cc93a6
>>>
>>> I see no explanation for why this is the correct fix, and I doubt it is.
>>> What's the real reason for the NULL lru_list_one, and why doesn't this
>>> come up on other filesystems?
>>
>> Agree, IIRC, the list_lru_one will be pre-allocated in the allocation
>> path of inode/dentry etc.
> Yes, this issue does not fix why lru_list_one is NULL.
> 
> lru_list_one is NULL because the inode is allocated using 
> kmem_cache_alloc()
> instead of kmem_cache_alloc_lru(), and the lru argument passed to
> slab_alloc_node() is NULL. See [1] for the actual fix.
> 
> However, the return value of list_lru_from_memcg_idx() may be NULL. When
> list_lru_one is NULL, the kernel will panic directly. Do we need to add
> error handling when list_lru_one is NULL in list_lru_{add, del}?

Nope, we should pre-allocated the list_lru_one before calling
list_lru_add().

> 
> To avoid hiding the actual BUG(previous changes), we might make the 
> following
> changes,

Even if you do this, you should still modify all callers
to handle this failure.

> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 3fd64736bc45..fa86d3eff90b 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -94,6 +94,9 @@ bool list_lru_add(struct list_lru *lru, struct 
> list_head *item, int nid,
>          spin_lock(&nlru->lock);
>          if (list_empty(item)) {
>                  l = list_lru_from_memcg_idx(lru, nid, 
> memcg_kmem_id(memcg));
> +               if (WARN_ON_ONCE(!l))
> +                       goto out;
> +
>                  list_add_tail(item, &l->list);
>                  /* Set shrinker bit if the first element was added */
>                  if (!l->nr_items++)
> @@ -102,6 +105,7 @@ bool list_lru_add(struct list_lru *lru, struct 
> list_head *item, int nid,
>                  spin_unlock(&nlru->lock);
>                  return true;
>          }
> +out:
>          spin_unlock(&nlru->lock);
>          return false;
>   }
> @@ -126,12 +130,16 @@ bool list_lru_del(struct list_lru *lru, struct 
> list_head *item, int nid,
>          spin_lock(&nlru->lock);
>          if (!list_empty(item)) {
>                  l = list_lru_from_memcg_idx(lru, nid, 
> memcg_kmem_id(memcg));
> +               if (WARN_ON_ONCE(!l))
> +                       goto out;
> +
>                  list_del_init(item);
>                  l->nr_items--;
>                  nlru->nr_items--;
>                  spin_unlock(&nlru->lock);
>                  return true;
>          }
> +out:
>          spin_unlock(&nlru->lock);
>          return false;
>   }
> 
> Link:
> [1]: 
> https://lore.kernel.org/all/20240716025816.52156-1-youling.tang@linux.dev/
> 
> Thanks,
> Youling.

