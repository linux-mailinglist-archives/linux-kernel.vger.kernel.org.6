Return-Path: <linux-kernel+bounces-369410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0CD9A1CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626602840AB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF9E1D2F50;
	Thu, 17 Oct 2024 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rZWTmWRX"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A81D0BAE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729153023; cv=none; b=HbhmYLfqbDZxVPscomlF93SkxgeiRWdC66nPy6KvUSsQ7W1qR4HpVqTohuv1kFIM5riH0tB3EqXfJZ2eizfGfljLHekFExlzsHRY9ILQyuLkWUst+1zZT0q/X9mKTciZV0GmX1K+DPJpd62mXdCVC1osrMNXJww6yZvIr6a8o3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729153023; c=relaxed/simple;
	bh=ndzHZLuEUDR9GYJ68fLnekxC1O5/4uqcnJ/mfgrL+JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfSR2mMbwFl7eIcgG4U0/ugyTcYespJQomMmGe7Q3NRs2L1eO+JuU+iIqaKWkFQewP3NjDNkSk5Bvl11NGUG7E4S4nsGUNLPismlng4hgP0PIfkmRkDAgiYo8/zCkmTX39LH9C7m7ghFWxfuR9M/5RCL1o+FGPdtaXZFgBg1oXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rZWTmWRX; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729153017; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lgdtE/cjkREEUIcIbl6cLW0HqkfNtPyPRowWoZLEyrk=;
	b=rZWTmWRX0v8wx9b5HL7S2YXxpM6BtugtxNFdYy/C4WpEkC9e3vTkysK2Eg5hS9/FeoNJlJyojRGcHDudSH790NCwE4gPNx2g8r0VIpf7zpprsXMEwD3ovht5kQcJ6/H9r4ONx9ebJUFivCQfRjyOh0h7f6W0qwSuRQXqrYsYkkY=
Received: from 30.221.129.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHKAp-e_1729153015 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 16:16:56 +0800
Message-ID: <dcbf0903-67a2-4b8e-b43b-d6b9cf195a5a@linux.alibaba.com>
Date: Thu, 17 Oct 2024 16:16:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fs: erofs: support PG_mappedtodisk flag for folios
 with zero-filled
To: Barry Song <21cnbao@gmail.com>
Cc: xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
References: <20241017074346.35284-1-21cnbao@gmail.com>
 <ca27aa75-40a4-4c82-8d84-7968b2ab89d4@linux.alibaba.com>
 <0fa18bcf-9af6-4c99-ad57-613fa38ff741@linux.alibaba.com>
 <CAGsJ_4yLK3sCeJNdZRKxD2tSdMVFRBp9eq-1mAMu7UT=gqpA_Q@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGsJ_4yLK3sCeJNdZRKxD2tSdMVFRBp9eq-1mAMu7UT=gqpA_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/17 16:09, Barry Song wrote:
> On Thu, Oct 17, 2024 at 9:00 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/10/17 15:58, Gao Xiang wrote:
>>> Hi Barry,
>>>
>>> On 2024/10/17 15:43, Barry Song wrote:
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> When a folio has never been zero-filled, mark it as mappedtodisk
>>>> to allow other software components to recognize and utilize the
>>>> flag.
>>>>
>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>
>>> Thanks for this!
>>>
>>> It looks good to me as an improvement as long as PG_mappedtodisk
>>> is long-term lived and useful to users.
>>>
>>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
> 
> thanks!
> 
>> BTW, I wonder if iomap supports this since uncompressed EROFS
>> relies on iomap paths...
> 
> In the core layer, I only see fs/buffer.c's block_read_full_folio()
> and fs/mpage.c's mpage_readahead() and mpage_readahead()
> supporting this. I haven't found any code in iomap that sets the
> flag.
> 
> I guess erofs doesn't call the above functions for non-compressed
> files?

mpage are obsoleted interfaces (of course EROFS could use
them instead, see my backport to centos 7 [1]), and iomap
is used for recent unencoded I/O use cases.

It would be better to add support for iomap too, but I guess
PG_mappedtodisk has very few users in the upstream kernel,
so they might ask for further use cases tho ;-)

Thanks,
Gao Xiang

[1] https://github.com/erofs/kmod-erofs/blob/main/src/data.c#L249

> 
>>
>> Thanks,
>> Gao Xiang
> 
> Barry


