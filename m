Return-Path: <linux-kernel+bounces-385728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1D09B3AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5E01F219C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF51DFE11;
	Mon, 28 Oct 2024 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXuibAU3"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F60A1DFE02
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145606; cv=none; b=i4V7BLxqCLC8U9Va2pPsbLpp8s6MFmVUIX0lGh12aT1+lguzFtWQKEEou4jHSU7qYXwzfGmi7PAloru/knTeAsG62cgHd1mbn33OBgRI4uArzevddeDBjzDaStdtai22RFklHwLeV71j2jP7n/F6uQp+/dB/ZCdq6tQVwV26jOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145606; c=relaxed/simple;
	bh=WLEgACiq7YbBHvhcpQ1VfdTlxzx36+pNe0zNeBHtvnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikrQ1WVCcXzThu5IY9lUIVQzpVN/01sBlmxL35GhwkPTFpmdsBVMcoZ6q7VyNTjjLhzhGO18We2NvyJMdiUL2CuMx0qhxKSBOAASvNW2Ic15MkjoAEWkS42Nd2OaFFnKUf7gr+5YgCbe9Y5WKCzQQ3Fej++7Mzmc2i979QWik7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXuibAU3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314b316495so43502875e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730145602; x=1730750402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cIUekGsdjBLrzdn8D80ojdZOPBDaJKu1O61Vf5DnR7E=;
        b=VXuibAU36dk93eVYqkfakRvsUpaFIczQS8qPG2KKN1p844vzsP0bIDv+FBGjpWubqq
         bteqIcl2L/ESbSCCbQ7FTprd2plDtfCH6zrNYNeVrZdngA5N58oUI1GNKzFvpbb/Hg2i
         XL/v+ug/ArMUSHy8k5kJ+oZ69ZWIgkLi+l/c7zxUJyWuqn0RS/4EM1akmjMUYuaWvE7V
         WY2M+v5+oPiXSqU+X00luUQoLNGHZ4Dh3j02wrFDslOY0vCehNHZIw0IoFTgMHLPbxe/
         JXlmhyVYSUbDiVxrjSmjzi6dUG6f9GLvxEaLPUIpYJoP8DCR0lqtwmkxKxZX4tDtqeFc
         O19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730145602; x=1730750402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIUekGsdjBLrzdn8D80ojdZOPBDaJKu1O61Vf5DnR7E=;
        b=XtOKzCCZG4/3cUA9EHN3IBBdNN0Ra1jZ+cl9qpYV4HlZRcq7n0k+GtPV0sJfYpbM8v
         txyLKijN76jFE2pOy9z+lwLLrfC3ZVs2r09pGUJeCtbObkxhNrRkEAeIUrZhjSmevk5w
         8GkhtP0i5NA2evcRsZz1q82D7Y33r2ZLR2SzOGO46BxKdxSEnytF883pq4S4faW07Zh8
         k9LUhy1ZlJnu1QZQ3Aw+/gZo8df0rJq+7YH3LelQVy11LknFP4sSQjVjx9sBshRcXTlm
         RA2+xQcYRPrL5pzdJHlMsU//rheKKxU78EZl3B3L3L/b0eXcJobVyofSY0TV1bX5xlRy
         6DIg==
X-Forwarded-Encrypted: i=1; AJvYcCXasrb/zQOrLfAj01a2kOAwzE6+xbMY568IDoGlIgHmnd+i/xdcv4VylIGlUBNX73huCDeHLaKFXNQPAO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO+1NqGXSVXrLCJBAjVdPoyr6Bwz4juCpOo9b9wOaq3JUbiV6k
	AyS2xIdU8syNVmH2y5qwx6Stu2LxMsyS2h+uSKJGhfHaPDMSyYbg
X-Google-Smtp-Source: AGHT+IFs1NYcYyNMuGx4j41Mb1jhXv4Eu8GGF3FfsmGpiMZziiqnsiQMQcEQaS7oTxkh6mQERjCFiA==
X-Received: by 2002:a5d:50cf:0:b0:37d:94d6:5e20 with SMTP id ffacd0b85a97d-380610f4e77mr7568641f8f.4.1730145602179;
        Mon, 28 Oct 2024 13:00:02 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b4a3cesm10331501f8f.63.2024.10.28.13.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 13:00:01 -0700 (PDT)
Message-ID: <882008b6-13e0-41d8-91fa-f26c585120d8@gmail.com>
Date: Mon, 28 Oct 2024 20:00:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Barry Song <21cnbao@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>, Chengming Zhou
 <chengming.zhou@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Andi Kleen <ak@linux.intel.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
References: <20241027011959.9226-1-21cnbao@gmail.com>
 <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
 <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
 <678a1e30-4962-48de-b5cb-03a1b4b9db1b@gmail.com>
 <CAKEwX=P2EKkbAgoUJ_RTRwv0DS18HfnEG2gRFmCYyb2R+LsrvA@mail.gmail.com>
 <6303e3c9-85d5-40f5-b265-70ecdb02d5ba@gmail.com>
 <CAJD7tkZpO1nEvdh7qPWt4Pg=FU1KZfEd3vA9ucEpqdc-7kF0Jg@mail.gmail.com>
 <64f12abd-dde3-41a4-b694-cc42784217fb@gmail.com>
 <CAGsJ_4zQmaGxG2Ega61Jm5UMgHH-jtYC4ZCxsRX6+QS9ta25kQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4zQmaGxG2Ega61Jm5UMgHH-jtYC4ZCxsRX6+QS9ta25kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28/10/2024 19:54, Barry Song wrote:
> On Tue, Oct 29, 2024 at 1:20 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 28/10/2024 17:08, Yosry Ahmed wrote:
>>> On Mon, Oct 28, 2024 at 10:00 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 28/10/2024 16:33, Nhat Pham wrote:
>>>>> On Mon, Oct 28, 2024 at 5:23 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>
>>>>>> I wonder if instead of having counters, it might be better to keep track
>>>>>> of the number of zeropages currently stored in zeromap, similar to how
>>>>>> zswap_same_filled_pages did it. It will be more complicated then this
>>>>>> patch, but would give more insight of the current state of the system.
>>>>>>
>>>>>> Joshua (in CC) was going to have a look at that.
>>>>>
>>>>> I don't think one can substitute for the other.
>>>>
>>>> Yes agreed, they have separate uses and provide different information, but
>>>> maybe wasteful to have both types of counters? They are counters so maybe
>>>> dont consume too much resources but I think we should still think about
>>>> it..
>>>
>>> Not for or against here, but I would say that statement is debatable
>>> at best for memcg stats :)
>>>
>>> Each new counter consumes 2 longs per-memcg per-CPU (see
>>> memcg_vmstats_percpu), about 16 bytes, which is not a lot but it can
>>> quickly add up with a large number of CPUs/memcgs/stats.
>>>
>>> Also, when flushing the stats we iterate all of them to propagate
>>> updates from per-CPU counters. This is already a slowpath so adding
>>> one stat is not a big deal, but again because we iterate all stats on
>>> multiple CPUs (and sometimes on each node as well), the overall flush
>>> latency becomes a concern sometimes.
>>>
>>> All of that is not to say we shouldn't add more memcg stats, but we
>>> have to be mindful of the resources.
>>
>> Yes agreed! Plus the cost of incrementing similar counters (which ofcourse is
>> also not much).
>>
>> Not trying to block this patch in anyway. Just think its a good point
>> to discuss here if we are ok with both types of counters. If its too wasteful
>> then which one we should have.
> 
> Hi Usama,
> my point is that with all the below three counters:
> 1. PSWPIN/PSWPOUT
> 2. ZSWPIN/ZSWPOUT
> 3. SWAPIN_SKIP/SWAPOUT_SKIP or (ZEROSWPIN, ZEROSWPOUT what ever)
> 
> Shouldn't we have been able to determine the portion of zeromap
> swap indirectly?
> 

Hmm, I might be wrong, but I would have thought no?

What if you swapout a zero folio, but then discard it?
zeromap_swpout would be incremented, but zeromap_swapin would not.

> Thanks
> Barry


