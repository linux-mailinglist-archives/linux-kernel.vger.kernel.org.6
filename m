Return-Path: <linux-kernel+bounces-385468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEC99B3788
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC9728213D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2151DF747;
	Mon, 28 Oct 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1hIO9XF"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ACA1DEFEE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136005; cv=none; b=RngoEjYdXlLOAiXQvQCwNdr/zdsNaCu9T+30YG7lAZY4GPNH+U87PS7Emb2oriVxzP1sEHtwjJ8KePrOHdT3gL0DjektYyAfP6UvKpglCUA5deGw5Z1eHEKQtuGm8/3UwH2QIpdQTe501L55XCMPZDIcicU2Yb2gXEEh/H6gPEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136005; c=relaxed/simple;
	bh=VEhUyVK3jvTUmJ54/f3jkFNzqnn+7h4N9Iv352Qdsb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kl/phN0Bc5LJ2Y5rvDdvk1umhfGr3fRK5xjiGSKFvojtKhdO2Sxq+fLWVrHXTnEXE/LOaZiIP+wW3GpHznfTbTkJOeL/rfaMOVL0jXhrRZ/iwj2DkLhw2gw6jIGpfNj7VyHRo7OLO42nzriybKYMajWHVp2zPdmiLaAkrbbreb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1hIO9XF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso9002833a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730136001; x=1730740801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/eVHk3AW7gexiX7PCuaMlSsl6eHUqJBpZrMSinpxlxM=;
        b=l1hIO9XFj22Esqb58pAWfkbnHa1gKO9QIYfUvf+VP+x2g07i2lTLoUuv/IqaXNuLAg
         mrTXs1YAR2eej+A4mtCSdjYsVnXsQgQlARbHVrFWVclecISXmEZDm8FbUJsQc8Ynu3hI
         JH4n49bSpf3X2CZuMy7pnfRHp5NCRCh0VeZ8GqSgriANjwJqpkM/4HwD7iQy06CwNUc0
         2dKgo67S5910iXAC0FKylcTVi8/xYK8FqlT/UCKgZpB0fXx3LLMi9Og1Xiw5sfc2Dweb
         XwiHJVO8sSAZ388eC1+k0HKDDK4FrVuQ8w8/mi4pSvSiexMqPxjztfvTuCmHAJqqcZ+R
         Rf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730136001; x=1730740801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eVHk3AW7gexiX7PCuaMlSsl6eHUqJBpZrMSinpxlxM=;
        b=XuRMWP6oIQF9X6tYia5PUVtjjJejCeoEV10/7pcYPYTZM+FN4zU4ITMG6fHBfsb4JI
         2VIucGD/bsdoKKe/x+MimhEqGh+pQR7e5shaDbAtiTAvEE1K2mrCxYRr9rcwRrTDc9Vp
         uzwwKV0vUUkfNcdHH21W619a2FNDtQQhuNSWh0ujBf3Dn3b4c7sRACKhngd2Rcgu6C1j
         WM9uJlVXfzkzgEa96uRchvt2e6JY/HMTVetroxIhI/wc1RC/wZ8yK8m1NgB+cj3zPPfc
         mtA0X+x3YZOG4RW3PDO8BAJvDW/CaV6kT9v5+CTyXNohwt4f0KzJ9p1maerms3xv6PEz
         Rs7g==
X-Forwarded-Encrypted: i=1; AJvYcCVxZxqE5B25bl6yCJWuZNuRQMFrLfYZRLPpLvtU6g739YAR+gYWgB88QCxyaH1RUBG4pFCuZ+EDTxLlfnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlkvCZ3968o5Jgqes+19I8b+E7Q0MjeoXaIVU9lDFZQYcIPU/N
	j2HAs9kFeZRu6GFIdcRIz0aJ8EmYBtrloHiDQ1d0AV6eNNNVWjZl
X-Google-Smtp-Source: AGHT+IEscDPCM9cn12k4IcZouQpiYm6zyHeuc25wHiqlz9PCBSKJZWHRvo5xoi99boMMwTEwSJedOg==
X-Received: by 2002:a17:907:9808:b0:a9a:ca:4436 with SMTP id a640c23a62f3a-a9e2274cc43mr25156366b.13.1730136000899;
        Mon, 28 Oct 2024 10:20:00 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::5:1494])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b23027154sm396403866b.146.2024.10.28.10.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 10:20:00 -0700 (PDT)
Message-ID: <64f12abd-dde3-41a4-b694-cc42784217fb@gmail.com>
Date: Mon, 28 Oct 2024 17:19:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Barry Song <21cnbao@gmail.com>,
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkZpO1nEvdh7qPWt4Pg=FU1KZfEd3vA9ucEpqdc-7kF0Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28/10/2024 17:08, Yosry Ahmed wrote:
> On Mon, Oct 28, 2024 at 10:00 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 28/10/2024 16:33, Nhat Pham wrote:
>>> On Mon, Oct 28, 2024 at 5:23 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>> I wonder if instead of having counters, it might be better to keep track
>>>> of the number of zeropages currently stored in zeromap, similar to how
>>>> zswap_same_filled_pages did it. It will be more complicated then this
>>>> patch, but would give more insight of the current state of the system.
>>>>
>>>> Joshua (in CC) was going to have a look at that.
>>>
>>> I don't think one can substitute for the other.
>>
>> Yes agreed, they have separate uses and provide different information, but
>> maybe wasteful to have both types of counters? They are counters so maybe
>> dont consume too much resources but I think we should still think about
>> it..
> 
> Not for or against here, but I would say that statement is debatable
> at best for memcg stats :)
> 
> Each new counter consumes 2 longs per-memcg per-CPU (see
> memcg_vmstats_percpu), about 16 bytes, which is not a lot but it can
> quickly add up with a large number of CPUs/memcgs/stats.
> 
> Also, when flushing the stats we iterate all of them to propagate
> updates from per-CPU counters. This is already a slowpath so adding
> one stat is not a big deal, but again because we iterate all stats on
> multiple CPUs (and sometimes on each node as well), the overall flush
> latency becomes a concern sometimes.
> 
> All of that is not to say we shouldn't add more memcg stats, but we
> have to be mindful of the resources.

Yes agreed! Plus the cost of incrementing similar counters (which ofcourse is
also not much).

Not trying to block this patch in anyway. Just think its a good point
to discuss here if we are ok with both types of counters. If its too wasteful
then which one we should have.
 

