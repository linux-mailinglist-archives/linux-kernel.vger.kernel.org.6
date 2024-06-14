Return-Path: <linux-kernel+bounces-214624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05298908739
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C45B22C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710141922D5;
	Fri, 14 Jun 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c44fTUy0"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7BC18FC9F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718356927; cv=none; b=KNJu/Ndn1mWIEAlIhusqCu/v3u29VJ/h1WrjPiK3yWFCQBqgJOo0F/1NGFiNKk0iRsFQCUDBOVCZshU5vGhjEPKhjFjfD7ic7VgVh++v+rNCjA1dlcmgxQlJo+LZ4eYeWnWUijPkB+EiDW3nS9NFKhQ5TDW+fgwTHntCLMQnmoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718356927; c=relaxed/simple;
	bh=dA6jMt0cB3MO5K7bdNWRm691IV8/mImpmV5Wa8j5vyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zwf7bMRWMqdTy1lic7tbNil4zJc2nqJveRwb5R+afm9QXu8yjnlLX5YI808zCefX1T+3CT+8KnqBrTL9rqUfPkU8L7YeRhVyfx8N/h1/i7luwod1uUvdC16vc3YvEXlVOku0QtvKgv8NVA7ubV3ZnGRtQUCCtUvMtTPRlWO97wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c44fTUy0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35f1bc2ab37so1824956f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 02:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718356924; x=1718961724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5zMuaq26uVXSI7TixMTY+2oASK+Pw9TXRfbwHPPXcw=;
        b=c44fTUy03rLq7nPGW5FuFuzAI/zzy0xDKLJu0OggP4l5skQZ9DFz6yiYcbAszislAq
         i5hp1isfr8xbYsAhVnKHZA5Yyv6IoGy1pnV96XZFNfqqi2BSfRmsIKsH9St7zJr4Tn+I
         NUUpljs1rsRxB4NAiVpdUG07P22GXe05ZTrcwHZl3YxAPCX0vJhv3lG+C+m2gXCk5NHT
         yLv6oSCCvXDZuj+KMINEZXAOesU2SglzRY/SQudtRwxXQ6j7Q3UWtFuyFsDNdjLpZJzr
         gfsbcpA9CwX588VmPvet+1osiZFEhMz3Ik6rOGApQ6yF0Ij/wsEkKCuXtbAZpPuD2bEE
         8xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718356924; x=1718961724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5zMuaq26uVXSI7TixMTY+2oASK+Pw9TXRfbwHPPXcw=;
        b=eSSvGysyMlkQkWmb0ajRDe5kXbQj0JnKwQBjagHRrcBCQc2rIJ0ggO0aqNvLZ2FQyU
         dwp+bFoj0hJi15AuIdC6T8sXKCrpFRdmTG4eXaeZyvNPHsiK6zoXzWStYzlUOGQmGq0X
         hytF7qamk/rD/5NjrvhtzuV/aBCE+yXg4YPh5aaXhuYyAGL/edW9uGkl7msiwmQVLsrh
         XzFDH7qfdHfYySRe/q1DiiusmipX6Fn1m6YpXomOqORd2J3tGC0TsaT69UQ5Wm+xcYn8
         ZSTF2jc2E5mCWcvln8i0j1CnvRfLJNlu73/UgtSyapzbHyWivbOicLrPyRzeiadSIGQ8
         v5DA==
X-Forwarded-Encrypted: i=1; AJvYcCVu82BMGttFZSNEJ0ICtQF6D34I09vx/OxhVTP75GVUQottRMX96aSRJS5RfrBRgubaEYm7QU+r8d+IQ4wzoZnfTJEa3EwF0EY/uy2u
X-Gm-Message-State: AOJu0YzTxnv+9+diNEXNNBqiutpONIeWJgmTleMc9N9CfGV1VI4Thqob
	hEy88AeItW1nt7iyMj7wTPwksbkd6mZha3PtMmbmjNoWIkYsR/7V
X-Google-Smtp-Source: AGHT+IG6rBveLT/eg3VVBllWdrtJWTm9L9sPZCw0njzRuK0u1dysIeWh0f/MOLwOzE0dlUNEff1wTw==
X-Received: by 2002:a5d:59a3:0:b0:360:827f:1c3e with SMTP id ffacd0b85a97d-360827f1f6dmr1027155f8f.3.1718356924012;
        Fri, 14 Jun 2024 02:22:04 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b75d:0:64:3301:4710:ec21? ([2a02:6b6a:b75d:0:64:3301:4710:ec21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104b45sm3770586f8f.109.2024.06.14.02.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 02:22:03 -0700 (PDT)
Message-ID: <52df55b7-2e1d-4a95-85bf-19f6680e3fec@gmail.com>
Date: Fri, 14 Jun 2024 10:22:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] mm: store zero pages to be swapped out in a bitmap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
 ying.huang@intel.com, hughd@google.com, willy@infradead.org,
 nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <CAJD7tkZzHhvVNjECqMiFKEu988eteiFk4aGpE=f=gXE4tnF4NA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkZzHhvVNjECqMiFKEu988eteiFk4aGpE=f=gXE4tnF4NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 13/06/2024 22:21, Yosry Ahmed wrote:
> On Mon, Jun 10, 2024 at 5:18 AM Usama Arif <usamaarif642@gmail.com> wrote:
>> Going back to the v1 implementation of the patchseries. The main reason
>> is that a correct version of v2 implementation requires another rmap
>> walk in shrink_folio_list to change the ptes from swap entry to zero pages to
>> work (i.e. more CPU used) [1], is more complex to implement compared to v1
>> and is harder to verify correctness compared to v1, where everything is
>> handled by swap.
>>
>> ---
>> As shown in the patchseries that introduced the zswap same-filled
>> optimization [2], 10-20% of the pages stored in zswap are same-filled.
>> This is also observed across Meta's server fleet.
>> By using VM counters in swap_writepage (not included in this
>> patchseries) it was found that less than 1% of the same-filled
>> pages to be swapped out are non-zero pages.
>>
>> For conventional swap setup (without zswap), rather than reading/writing
>> these pages to flash resulting in increased I/O and flash wear, a bitmap
>> can be used to mark these pages as zero at write time, and the pages can
>> be filled at read time if the bit corresponding to the page is set.
>>
>> When using zswap with swap, this also means that a zswap_entry does not
>> need to be allocated for zero filled pages resulting in memory savings
>> which would offset the memory used for the bitmap.
>>
>> A similar attempt was made earlier in [3] where zswap would only track
>> zero-filled pages instead of same-filled.
>> This patchseries adds zero-filled pages optimization to swap
>> (hence it can be used even if zswap is disabled) and removes the
>> same-filled code from zswap (as only 1% of the same-filled pages are
>> non-zero), simplifying code.
>>
>> This patchseries is based on mm-unstable.
> Aside from saving swap/zswap space and simplifying the zswap code
> (thanks for that!), did you observe any performance benefits from not
> having to go into zswap code for zero-filled pages?
>
> In [3], I observed ~1.5% improvement in kernbench just by optimizing
> zswap's handling of zero-filled pages, and that benchmark only
> produced around 1.5% zero-filled pages. I imagine avoiding the zswap
> code entirely, and for workloads that have 10-20% zero-filled pages,
> the performance improvement should be more pronounced.
>
> When zswap is not being used and all swap activity translates to IO, I
> imagine the benefits will be much more significant.
>
> I am curious if you have any numbers with or without zswap :)

Apart from tracking zero-filled pages (using inaccurate counters not in 
this series) which had the same pattern to zswap_same_filled_pages, the 
nvme writes went down around 5-10% during stable points in the 
production experiment. The performance improved by 2-3% at some points, 
but this is comparing 2 sets of machines running production workloads 
(which can vary between machine sets), so I would take those numbers 
cautiously and which is why I didnt include them in the cover letter.


