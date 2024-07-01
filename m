Return-Path: <linux-kernel+bounces-235564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E9391D6AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76311C2146A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 03:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC4A1804A;
	Mon,  1 Jul 2024 03:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7nCxv7I"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C72B9C6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 03:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719805212; cv=none; b=ehSCgcV2ANpsXyEr+QnIg4iP8H/JxBM02FGlbJoC9jPgURDbBrV9F0JWMoucb0f1IwOJ7O2pqBCeZ12vLw9IjulBlNrJJZ3wxzXAeknUD4SnR2Y0nUC1g5C5I/S6QAVIhQvGSWrPTabCXJppI7jas61d//sStdmxHaEohIyj1pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719805212; c=relaxed/simple;
	bh=naq1zr9uY5vVAaP6iJ6XkxW31Bou1tERbdmxxtO/6DI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a7uxEgUYQNsyFKZwimYX1r5ig4aauSYUB9kS8qSu9gCMTioYO2KWXZq64zHuENnT+n5wupB8Xviirt6wOazP4h6BO/sUZH/CTG30lObZ67lF2LbQxG7dzu3V3+iZDMu/VjHE/gJSixooar1Ci8WYzA57yRMaXcxDEZSNfPVkixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7nCxv7I; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c92d00059eso1378855a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 20:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719805210; x=1720410010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SgLx/VnUuHyviAFrV554OvWCd0rnqob6XndqOTMcVR8=;
        b=Y7nCxv7IMxBpCx55XO+EXwBxTLSHM/38wPL9kTW4IaPpaeKvf/H62TYg7QzclklBN7
         8Vq/MpiRX7QKQJSFno9bzp6kM/PLGtjPYjQsB8YMQ8ZPKDLXr6OwTHFVOn4ppZiJIsdY
         zuUlLyfMcSHefRNT9DU2v18BzhwNhH48E892KA9LrLk+30YplkhOh7oNwdgA+C8jaJuj
         /2MJEKOw4uXzM2MmQO5huLZG/pINWHffO2SeufGcpw/BtDN6s2W5mvK8VtlMUz2d07gZ
         2VcWeWV71rLayjAC0kMmnQNpGFJIMgdUup995RtUr0tHBT7Ob5ESfFUALCDJ2rEHmayi
         RMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719805210; x=1720410010;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgLx/VnUuHyviAFrV554OvWCd0rnqob6XndqOTMcVR8=;
        b=naSqeMEEJZ3enlKlGj7mhAvOf1l3uz3Fbftz4HX8YYTUgkpOEqeAaHioj5M0lndFX8
         kWdmZ4djmrQPcc2rRJcFv33wpu62glC1y7GeMqX8lUabIXdKi2Ry8nHYdUcAtfAck9/V
         GgBTXM8a5BqAicORPzGKt94pQyQkAZ+6AznD6gNNqEf3MLLKOcQEdAyT1/i3h7wgk8Qz
         lqrxNQHt9PXBaQgxRVTOzie60MGIbfLdg5Mkz1JfbrX4t3ZrFIbhMXPfdBtzkt2R/JdW
         V0sGOFNA/QL457EI0P5NXkUQBMrMHXghY0c7qatzGK47SaXSLo4qUpSguw+R2xUc/w9i
         I/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXciI6Wok6FPX0X2WRkkogEmlyFFO+0GYcriu1acAl6NumC1IFsAGrcv4DNxAjlEWYIfAt0ubMwvt+jlQ6Cer9G8VCOhpAPwoz/ns+J
X-Gm-Message-State: AOJu0Yx6A/IFwjFY2QkNH3nhUmJC3mqu3CDD3kO1TEy+KdesZS2Lo/Nk
	WGjD5ZM3UW83FZ19Q5QZ/aN+47Ui1E1i3Pt7iE/5NK6BsNtwZi79
X-Google-Smtp-Source: AGHT+IERtwgU9u26Oag1D/d5ru5zwJeyeVbrdbzzXf8Yl5ztX9m1ngLjBgRtdpDriKACIEdPWCUkvQ==
X-Received: by 2002:a17:90b:d87:b0:2c8:dad2:83e3 with SMTP id 98e67ed59e1d1-2c93d72d7a7mr2091017a91.6.1719805209925;
        Sun, 30 Jun 2024 20:40:09 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce74143sm5584386a91.27.2024.06.30.20.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 20:40:09 -0700 (PDT)
Message-ID: <429f4ea1-b94a-455a-a4e7-27e1536c0b7c@gmail.com>
Date: Mon, 1 Jul 2024 11:40:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
From: Alex Shi <seakeel@gmail.com>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>, alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin
 <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 willy@infradead.org, senozhatsky@chromium.org, david@redhat.com,
 Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
References: <20240628031138.429622-1-alexs@kernel.org>
 <20240628031138.429622-2-alexs@kernel.org>
 <CAB=+i9RSCkYyqo-qXJNRKjUig7s5ZMGWCKmur1nNcD3KkFnhUg@mail.gmail.com>
 <4418c5c6-60f3-408f-a4ea-8d8ba1cc8afd@gmail.com>
Content-Language: en-US
In-Reply-To: <4418c5c6-60f3-408f-a4ea-8d8ba1cc8afd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ops, 

Sorry for missing Yosry and Nhat. How stupid I am!
Here is the first patch on lore: https://lore.kernel.org/all/20240628031138.429622-1-alexs@kernel.org/

Sorry for this!
Alex

On 7/1/24 11:03 AM, Alex Shi wrote:
> 
> 
> On 6/30/24 9:45 PM, Hyeonggon Yoo wrote:
>> On Fri, Jun 28, 2024 at 12:06 PM <alexs@kernel.org> wrote:
>>>
>>> From: Alex Shi <alexs@kernel.org>
>>>
>>> The 1st patch introduces new memory decriptor zpdesc and rename
>>> zspage.first_page to zspage.first_zpdesc, no functional change.
>>>
>>> Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>> Signed-off-by: Alex Shi <alexs@kernel.org>
>>> ---
>>>  mm/zpdesc.h   | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  mm/zsmalloc.c | 19 ++++++++---------
>>>  2 files changed, 66 insertions(+), 9 deletions(-)
>>>  create mode 100644 mm/zpdesc.h
>>
>> Hi Alex, thanks for your effort in pushing this forward!
>>
>>> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
>>> new file mode 100644
>>> index 000000000000..a1ab5ebaa936
>>> --- /dev/null
>>> +++ b/mm/zpdesc.h
>>> @@ -0,0 +1,56 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/* zpdesc.h: zswap.zpool memory descriptor
>>> + *
>>> + * Written by Alex Shi <alexs@kernel.org>
>>> + *           Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>> + */
>>> +#ifndef __MM_ZPDESC_H__
>>> +#define __MM_ZPDESC_H__
>>> +
>>> +/*
>>> + * struct zpdesc -     Memory descriptor for zpool memory, now is for zsmalloc
>>> + * @flags:             Page flags, PG_private: identifies the first component page
>>> + * @lru:               Indirected used by page migration
>>
>> maybe Indirected -> Indirectly?
> 
> Hi Yoo,
> 
> Thanks for comments! Yes Indirectly is better. I will update it in next version.
> 
>>
>>> + * @next:              Next zpdesc in a zspage in zsmalloc zpool
>>> + * @handle:            For huge zspage in zsmalloc zpool
>>> + * @zspage:            Pointer to zspage in zsmalloc
>>> + *
>>> + * This struct overlays struct page for now. Do not modify without a good
>>> + * understanding of the issues.
>>> + */
>>> +struct zpdesc {
>>> +       unsigned long flags;
>>> +       struct list_head lru;
>>> +       unsigned long _zp_pad_1;
>>
>> for understanding, I think it'd be better to replace _zp_pad_1 with movable ops,
>> because mops reuses this 'mapping' field.
> 
> Right, 'mops' looks a bit more clear.
> 
>>
>>> +       union {
>>> +               /* Next zpdescs in a zspage in zsmalloc zpool */
>>> +               struct zpdesc *next;
>>> +               /* For huge zspage in zsmalloc zpool */
>>> +               unsigned long handle;
>>> +       };
>>> +       struct zspage *zspage;
>>
>> There was a discussion with Yosry on including memcg_data on zpdesc
>> even if it's not used at the moment.
>>
>> Maybe you can look at:
>> https://lore.kernel.org/linux-mm/CAB=+i9Quz9iP2-Lq=oQfKVVnzPDtOaKMm=hUPbnRg5hRxH+qaA@mail.gmail.com/
> 
> Thanks for notice. 
> The memcg_data isn't used for zpdesc. And I have a bit confusion since Yosry said: "I think to drop memcg_data we need to enlighten the code that ...". So we actually don't need to have this unused member, is this right, Yosry?
> 
>>
>>> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
>>> index fec1a39e5bbe..67bb80b7413a 100644
>>> --- a/mm/zsmalloc.c
>>> +++ b/mm/zsmalloc.c
>>> @@ -13,17 +13,17 @@
>>>
>>>  /*
>>>   * Following is how we use various fields and flags of underlying
>>> - * struct page(s) to form a zspage.
>>> + * struct zpdesc(page) to form a zspage.
>>>   *
>>> - * Usage of struct page fields:
>>> - *     page->private: points to zspage
>>> - *     page->index: links together all component pages of a zspage
>>> + * Usage of struct zpdesc fields:
>>> + *     zpdesc->zspage: points to zspage
>>> + *     zpdesc->next: links together all component pages of a zspage
>>>   *             For the huge page, this is always 0, so we use this field
>>>   *             to store handle.
>>>   *     page->page_type: PG_zsmalloc, lower 16 bit locate the first object
>>>   *             offset in a subpage of a zspage
>>>   *
>>> - * Usage of struct page flags:
>>> + * Usage of struct zpdesc(page) flags:
>>>   *     PG_private: identifies the first component page
>>>   *     PG_owner_priv_1: identifies the huge component page
>>
>> the comment for PG_owner_priv_1 can safely be removed as it's not used
>> after commit a41ec880aa7b ("zsmalloc: move huge compressed obj from
>> page to zspage")
> 
> Right, thanks for info!
> 
>>
>>> @@ -948,7 +949,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
>>>                 set_page_private(page, (unsigned long)zspage);
>>>                 page->index = 0;
>>>                 if (i == 0) {
>>> -                       zspage->first_page = page;
>>> +                       zspage->first_zpdesc = page_zpdesc(page);
>>>                         SetPagePrivate(page);
>>>                         if (unlikely(class->objs_per_zspage == 1 &&
>>>                                         class->pages_per_zspage == 1))
>>> @@ -1325,7 +1326,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
>>>                 link->handle = handle;
>>>         else
>>>                 /* record handle to page->index */
>>> -               zspage->first_page->index = handle;
>>> +               zspage->first_zpdesc->handle = handle;
>>
>> FYI this line seems to conflict with
>> bcc6116e39f512 ("mm/zsmalloc: move record_obj() into obj_malloc()")
>> on mm-unstable.
> 
> yes, a new commit made this conflict. will update this in next version.
> 
> Thanks
> Alex
>>
>> Best,
>> Hyeonggon

