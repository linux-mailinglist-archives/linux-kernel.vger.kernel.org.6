Return-Path: <linux-kernel+bounces-339852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB43D986B62
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67092B22A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9424915B562;
	Thu, 26 Sep 2024 03:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KBJqB8FK"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9501D5ADF
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727321458; cv=none; b=hfodxftRTIv8V6A6nmNP2j0a0g1GZuXkbNCEsvztG6SrbbaldwuhjxSPrQDdqzVtqnmdZdRXoKBgCaMV8gGfFM17RlpCfG+q8kDc//B7v4ErLbQ7tzXufBL0rt6CQQV0hvva1gynbY27ChENInKeacKE3vRqviM8v0vskYnqek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727321458; c=relaxed/simple;
	bh=7A6QZKegRpT77Mx2gEGZNhLlKlywXVDR4Qv8ePFqZa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogkf8K6Qt4PJEVrpp7eEGFndt1drtgbUXPhUduqdFYPThKDgd2jcSgAg49awgcg4GGcDU6oYS9cmzPjXBdBFuOkvIDc3XVJjNlQAsBtMNb7T8+bPAzoQ8pNY0i6t4zzWZoNr5Bzwuo9QJQhP8SLwwaStPQPRMBROdRrxgsxMo64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KBJqB8FK; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727321453; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DUkd02sExFtQTKFdHtMSMZgkd2fbyRROdMO7Fkc14WM=;
	b=KBJqB8FKfYuKL0VD48tfy2p1c/4Z6dLVOkwqRISAoetga02F+EKR0n+SIbuulMnwLduI5t5QYhKRE57XAYXCwp9BDknq40dC3L8TNTB88xe/BuUPNiweo7ZsoMLKWXpwY1F2eGf2nR3kGOwRR16ZRxpQWRY5hSWrCHtBI1pJf6Q=
Received: from 30.74.144.226(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WFlmLMc_1727321450)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 11:30:51 +0800
Message-ID: <26f20b95-9e2f-4e8b-bf34-d13e082192d0@linux.alibaba.com>
Date: Thu, 26 Sep 2024 11:30:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: "Huang, Ying" <ying.huang@intel.com>, Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, hughd@google.com, shakeel.butt@linux.dev,
 ryan.roberts@arm.com, chrisl@kernel.org, david@redhat.com,
 kasong@tencent.com, willy@infradead.org, viro@zeniv.linux.org.uk,
 baohua@kernel.org, chengming.zhou@linux.dev, linux-mm@kvack.org,
 kernel-team@meta.com, linux-kernel@vger.kernel.org
References: <20240923231142.4155415-1-nphamcs@gmail.com>
 <4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
 <CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
 <9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com>
 <CAKEwX=PiOdrR7Ad5XoT8pRZDLB=q6B_fmwQ3ScgWFPNptBuHPw@mail.gmail.com>
 <CAJD7tkZFu3DbovTwyRdQmEG=7nQtmzrjQVgyhE4mNzbCtZxFZA@mail.gmail.com>
 <CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
 <85a2fd61-93d3-4cd9-95a3-e9eaef87286b@linux.alibaba.com>
 <CAKEwX=NB-vf4zTTJ2KaRFGJmcfeDQpLLuiX=Rh6X+49ib8S=wA@mail.gmail.com>
 <87y13fqina.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87y13fqina.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/26 09:59, Huang, Ying wrote:
> Nhat Pham <nphamcs@gmail.com> writes:
> 
>> On Tue, Sep 24, 2024 at 6:53 PM Baolin Wang
>> <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>
>>> One benefit I can mention is that removing 'SWAP_MAP_SHMEM' can help to
>>> batch free shmem swap entries in __swap_entries_free(), similar to the
>>> commit bea67dcc5eea ("mm: attempt to batch free swap entries for
>>> zap_pte_range()") did, which can improve the performance of shmem mTHP
>>> munmap() function based on my testing.
>>
>> Yeah, the problem with having an extraneous state is you have to
>> constantly check for it in code, and/or keep it in mind when you
>> develop things. I've been constantly having to check for this state
>> when I develop code around this area, and it gets old fast.
>>
>> If we can use it to optimize something, I can understand keeping it.
>> But it just seems like dead code to me :)
>>
>> My preference is to do this as simply as possible - add another case
>> (usage == 1, nr > 1, and we need to add swap continuations) in the
>> check in __swap_duplicate()'s first loop, and just WARN right there.
>>
>> That case CANNOT happen UNLESS we introduce a bug, or have a new use
>> case. When we actually have a use case, we can always introduce
>> handling/fallback logic for that case.
>>
>> Barry, Yosry, Baolin, Ying, how do you feel about this?
> 
> Sounds good to me to just WARN now.  We can always improve when it's
> necessary.

+1. Agreed.

