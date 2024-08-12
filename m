Return-Path: <linux-kernel+bounces-282835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F1C94E930
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048DF1C2166A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3020D16C6BD;
	Mon, 12 Aug 2024 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R20tPfPn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA692E3F7
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453510; cv=none; b=J2uPX8wGGoCKj7RoTaKrpmlhvpYgOXkOvKB5krZi6IvjWL5txRSPoW0bX51wqM93Ug60YL3l00uHFsaD5qmIspC2u/qWjR0iXI+XIcaFza6BYSF1IvWHluqBhHRS9N2XXOEMMrq1Ukr206jhPF5Te2RZCGppD7tWlKi7azk5/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453510; c=relaxed/simple;
	bh=9EtWdtw86F6JhcBPxNRoif5Ci9FyhkXR62CpGJCgx44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roOX6DdNT0c6CLsvaNmbN4psI347WL8GF3xyEo7FSI7ah3dpNDhvtASGWAMwJSN6P8TVesVjlMCC6NNyIme1VE2qaQw49jm8yRHkuHB80sj/ARECO60pKeELVG+IsR9pGueWPNPo4A11yEJ+l4boJ0ZHCO8v5Odzx72+2vIOIts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R20tPfPn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723453506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FQmic4rrhKdKv6gFEUKIhBWO7nEe9F0WUcgCzCN1ejI=;
	b=R20tPfPnvPbZ9yBPFFbpv1PSWswZ7y5M+SQMe+vNGmzxr1KICfPeBbfr5Y2u3bXUGfcHXH
	oocimPgBTOdd3OofjTI9SpK1JCRieNuvn7y9FukAaWDkctCZFblvnV86SF7sy9TPS3wBUm
	ojgM7OsZ2r++1mi49xG21ft+M09EZ6Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-Um_VZ6GMMRmbLX3NDgisrA-1; Mon, 12 Aug 2024 05:05:04 -0400
X-MC-Unique: Um_VZ6GMMRmbLX3NDgisrA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4281f8994adso32347685e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453503; x=1724058303;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FQmic4rrhKdKv6gFEUKIhBWO7nEe9F0WUcgCzCN1ejI=;
        b=dHq01BvQc5E4xdkvJ0sf6ReLLGoPT/ZIvhEMHnfgZ0QlJT6Hlvqv2W9FPCuIAyhrj0
         GU0JvruzFnIQvNHSzyBRCHlCsefQwLmlDXQXHOBjD8nBvyIMtBqeM0b1XknxuXh5MAfq
         1FmUvQXWQZeiWpxqm8MGkaAZXswq4WQEOXPCYF4FDz1FxZdR3gMrvksTNIs9hqFg+73g
         MtbtiFyPiZZmUDuNRGDD96ufu7AZvf1UNJHBW5F9218gyok9HAQ6a8RkGgaWQ79mDGv1
         xNUpvE2Up+B7WXWJeiSvRYwOtvWb5i8nK1PA2YQdORK8bizEYwuIoN5xHIdMshQimfFA
         RJ6A==
X-Forwarded-Encrypted: i=1; AJvYcCU5JnrZRj/q4G856CYu5I4YO+wG7cjM6VGg+ECPlALfbL/BJla8eh5IS4TN2JsHW11VO1SXTICnSyjATm4TMG5m9/TH9dPMxI9gdKmQ
X-Gm-Message-State: AOJu0YyAssYn9nfrz9Vvafgo0ByMRLvucVkDumqTxjIqb+3eh9+/m0jh
	LuDORR85OVvf3l8+FwPiPm/2SknAtnlwqAzhhca8YbgdYaYW8ok0blMP5LLc2xSUIONKblqLxBo
	QyyWi7JZr7eFsaQNJTiyuKSpxO64l1ORpKZYYc2AWNF6HMk3GvsAvIEKWQm1Bcg==
X-Received: by 2002:a05:600c:63cf:b0:426:6551:3174 with SMTP id 5b1f17b1804b1-429c3a51ed8mr63863255e9.29.1723453503543;
        Mon, 12 Aug 2024 02:05:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA7AT4kmOP0pv0NUPTzBt8K9FOVasnWaWdE9V/oQUeFkCKxn4YS7cFmRzPtW7ouIV9SyzpCA==
X-Received: by 2002:a05:600c:63cf:b0:426:6551:3174 with SMTP id 5b1f17b1804b1-429c3a51ed8mr63862995e9.29.1723453502913;
        Mon, 12 Aug 2024 02:05:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7755caasm94489835e9.39.2024.08.12.02.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:05:02 -0700 (PDT)
Message-ID: <3d1abf37-6eb0-4390-9508-6270040823a5@redhat.com>
Date: Mon, 12 Aug 2024 11:05:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, corbet@lwn.net,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ryan.roberts@arm.com
References: <8258bf4c-ecec-4e06-ada0-da9fb99b1219@redhat.com>
 <20240812053636.97700-1-21cnbao@gmail.com>
 <08390990-b47a-4663-8eae-ee51aac55b45@redhat.com>
 <CAGsJ_4ziAchNaqHXmXFLa56t5PxfayDwkrdfR9OzRc35t3PfAg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4ziAchNaqHXmXFLa56t5PxfayDwkrdfR9OzRc35t3PfAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.08.24 10:36, Barry Song wrote:
> On Mon, Aug 12, 2024 at 8:20 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 12.08.24 07:36, Barry Song wrote:
>>> On Sat, Aug 10, 2024 at 1:15 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>>>>>>> -You can change the sysfs boot time defaults of Transparent Hugepage
>>>>>>>>> -Support by passing the parameter ``transparent_hugepage=always`` or
>>>>>>>>> -``transparent_hugepage=madvise`` or ``transparent_hugepage=never``
>>>>>>>>> -to the kernel command line.
>>>>>>>>> +You can change the sysfs boot time default for the top-level "enabled"
>>>>>>>>> +control by passing the parameter ``transparent_hugepage=always`` or
>>>>>>>>> +``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
>>>>>>>>> +kernel command line.
>>>>>>>>> +
>>>>>>>>> +Alternatively, each supported anonymous THP size can be controlled by
>>>>>>>>> +passing ``thp_anon=<size>[KMG]:<state>``, where ``<size>`` is the THP size
>>>>>>>>> +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
>>>>>>>>> +``inherit``.
>>>>>>>>> +
>>>>>>>>> +For example, the following will set 64K THP to ``always``::
>>>>>>>>> +
>>>>>>>>> +     thp_anon=64K:always
>>>>>>>>> +
>>>>>>>>> +``thp_anon=`` may be specified multiple times to configure all THP sizes as
>>>>>>>>> +required. If ``thp_anon=`` is specified at least once, any anon THP sizes
>>>>>>>>> +not explicitly configured on the command line are implicitly set to
>>>>>>>>> +``never``.
>>>>>>>>
>>>>>>>> I suggest documenting that "thp_anon=" will not effect the value of
>>>>>>>> "transparent_hugepage=", or any configured default.
>>>>>
>>>>> Did you see the previous conversation with Barry about whether or not to honour
>>>>> configured defaults when any thp_anon= is provided [1]? Sounds like you also
>>>>> think we should honour the PMD "inherit" default if not explicitly provided on
>>>>> the command line? (see link for justification for the approach I'm currently
>>>>> taking).
>>>>
>>>> I primarily think that we should document it :)
>>>>
>>>> What if someone passes "transparent_hugepage=always" and "thp_anon=..."?
>>>> I would assume that transparent_hugepage would only affect the global
>>>> toggle then?
>>>>
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/linux-mm/CAGsJ_4x8ruPspuk_FQVggJMWcXLbRuZFq44gg-Dt7Ewt3ExqTw@mail.gmail.com/
>>>>>
>>>>>>>>
>>>>>>>> Wondering if a syntax like
>>>>>>>>
>>>>>>>> thp_anon=16K,32K,64K:always;1048K,2048K:madvise
>>>>>
>>>>> Are there examples of that syntax already or have you just made it up? I found
>>>>> examples with the colon (:) but nothing this fancy. I guess that's not a reason
>>>>> not to do it though (other than the risk of screwing up the parser in a subtle way).
>>>>
>>>> I made it up -- mostly ;) I think we are quite flexible on what we can
>>>> do. As always, maybe we can keep it bit consistent with existing stuff.
>>>>
>>>> For hugetlb_cma we have things like
>>>>           "<node>:nn[KMGTPE|[,<node>:nn[KMGTPE]]
>>>>
>>>> "memmap=" options are more ... advanced, including memory ranges. There
>>>> are a bunch more documented in kernel-parameters.txt that have more
>>>> elaborate formats.
>>>>
>>>> Ranges would probably be the most valuable addition. So maybe we should
>>>> start with:
>>>>
>>>>           thp_anon=16K-64K:always,1048K-2048K:madvise
>>>>
>>>> So to enable all THPs it would simply be
>>>>
>>>>           thp_anon=16K-2M:always
>>>>
>>>> Interesting question what would happen if someone passes:
>>>>
>>>>           thp_anon=8K-2M:always
>>>>
>>>> Likely we simply would apply it to any size in the range, even if
>>>> start/end is not a THP size.
>>>>
>>>> But we would want to complain to the user if someone only specifies a
>>>> single one (or a range does not even select a single one) that does not
>>>> exist:
>>>>
>>>>           thp_anon=8K:always
>>>
>>> How about rejecting settings with any illegal size or policy?
>>>
>>> I found there are too many corner cases to say "yes" or "no". It seems
>>> the code could be much cleaner if we simply reject illegal settings.
>>> On the other hand, we should rely on smart users to provide correct
>>> settings, shouldn’t we? While working one the code, I felt that
>>> extracting partial correct settings from incorrect ones and supporting
>>> them might be a bit of over-design.
>>
>> No strong opinion on failing configs. Ignoring non-existing sizes might
>> lead to more portable cmdlines between kernel versions.
> 
> Well, I realized that the code I posted has actually applied the correct
> parts because it modifies the global variable huge_anon_orders_xxx.
> Unless I use temporary variables and then copy the results to
> global ones, the code has been this issue to some extent.
> 
> maybe I should remove the below  "goto err", instead, ignore the
> incorrect strings and go to the next strings to parse.

I'll have to look at the full patch to be able to have an opinion :)

>>>
>>> I have tested the below code by
>>>
>>> "thp_anon=16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never"
>>
>> There are some parameters that separate individual options by ";"
>> already (config_acs). Most parameters use ",". No idea what's better
>> here, and which separator to use for sizes instead when using "," for
>> options. No strong opinion.
> 
> But we have used "," for the purpose "128K,512K:inherit". so here
> we have to use ";" for  "16K-64K:always;128K,512K:inherit"

I know -- I proposed that format -- but I wonder if there is an 
alternative that would let use use "," in-between options.

Staring at various formats in 
Documentation/admin-guide/kernel-parameters.txt, I'm not able to come up 
with something "obviously better".


-- 
Cheers,

David / dhildenb


