Return-Path: <linux-kernel+bounces-289009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0B5954137
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D86D1C228E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46767DA7C;
	Fri, 16 Aug 2024 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sNkoGIeM"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD272770F1
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723786383; cv=none; b=mOMFzjgN2qk68ZtSKI2kL+g/b2x8/9KUnuanQF0KX1ueXUkRHDKlN84PxoacFP7jgYJ//DDTmozz0Hsgm80bqppgciWqw9N8lHzWXKrO/qnGS6nT7INS1qcRENe+8Cu7qtjZDOFaUeoB57c/V2Df3dzNMMEpvaZ7SgpD72zc+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723786383; c=relaxed/simple;
	bh=qnc6//XMdUBGWLw2DHDB96+AbKh8PpznrfXxHZSPshw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9Mds0HHWIKfgxzZE3LUyUf+bu9clgA0PdQRddGWmcGnBkuK3hJ3K2K37RMsB6cvu+oMTTSkV5or2wilnOrhNLJ9K4dv+F5aa08DLJvvG9U0DPS/78xJf11xL9Pl3/jWXZbDhIfm1+HVjhpkhmJJZ/iZSbAqNzkA3RbTsl1pjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sNkoGIeM; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723786372; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nQ2KzZFdpuFa6QSLEKrxpWoq3LE2Ita5QIyj2bUw76M=;
	b=sNkoGIeMRr4od1DoSBVAYBPqiavg0LNE29LmTjCEWRc2UY6+TuOw5Ztqasa7fm+zWYvg+7FXzkUIGwD8hjaQfv5x3h5v5jdRLwBn5IuGie8UvvCGG+jJkOf9prlrYlS8wFnsZaeUt0Vj1c7Cpvs6bbnZBChLpwCwyISf68QR3Jg=
Received: from 30.221.129.229(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCzJ6zW_1723786371)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 13:32:52 +0800
Message-ID: <1c07b6f5-c0ae-4213-8c86-e49ff06bd45a@linux.alibaba.com>
Date: Fri, 16 Aug 2024 13:32:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: fix deadlock in migrate_pages_batch() on
 large folios
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Gao Xiang <xiang@kernel.org>
References: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>
 <87plqx0yh2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d93b06a5-20f2-41bd-a7f5-d06906d88ba4@linux.alibaba.com>
 <20240815220224.d7970835d5c12b4833bd04dc@linux-foundation.org>
 <aa5ac560-1dcc-45b6-8e24-0e9cb59feb18@linux.alibaba.com>
 <fc4981c1-b7f1-4295-a0f8-a293b5610f79@linux.alibaba.com>
 <20240815222504.85e94e909d28bc64bc89b847@linux-foundation.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240815222504.85e94e909d28bc64bc89b847@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/16 13:25, Andrew Morton wrote:
> On Fri, 16 Aug 2024 13:17:04 +0800 Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>>>> does someone want to take a look at developing a v2?
>>>
>>> I've replied your email last week, I'm not sure why it has not
>>> been addressed?
>>>
>>> https://lore.kernel.org/linux-mm/20240729021306.398286-1-hsiangkao@linux.alibaba.com/
>>>
>>> The patch in your queue is already v2? No?
>>
>> Really confused about this, since the comment above was about v1.
>> and v2 is already sent (in July 29) and in -next for two weeks
>> with
>>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>
>> What else I need to do to resolve this already resolved comment
>> so that I could enable large folios without deadlocks anymore?
> 
> Is cool, thanks - I failed to correctly update my notes-to-self.

Many thanks for confirmation and hopefully it could upstream
so I could enable large folios safely.

Thanks,
Gao Xiang

