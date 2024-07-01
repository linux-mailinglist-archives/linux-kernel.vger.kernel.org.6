Return-Path: <linux-kernel+bounces-235715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4388191D8D0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5E61F21BB2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A66A6F076;
	Mon,  1 Jul 2024 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FGWVfb7r"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654061FC4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818296; cv=none; b=mwEaolzAAUMI8Csz7qzIuEK1tP8hRKYNLKpWUuV2ZWRrfXRppyxyQgM/Zs/1nn6iNfAuusD4VgKkzT6M6b955F61l+Kt3Lq3TQ3eGYm94UtkCXiiV1H1qeTNYBzx3E7KRepR63SF3vcFaav2Vd8PxjKLB7jih/bXAs7Xa6J5emw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818296; c=relaxed/simple;
	bh=hyCU58NJYbe5kCDnqJOeeNt29ZvqA5b18OhML3X3flU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJZnVSoI6tF60E5Z3qcP7L/7heBvDPXpro5rUsutvhVCZfNclLF5KZHoFlAWS8cMhBCyWu4lQx2W3v7Tc7KRkMs9Cji/FnN7frVPZ9i7l2TOOJ0ixbgRTfahUk3EsTPBTCOjfIuMXkYdA1aGdfnm3L76uTC/h1GUpIU20TzuCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FGWVfb7r; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719818292; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+qYOqVuRx1p/w/RsfmQsFnjToFDa0GRo3Rt9tmJb5XQ=;
	b=FGWVfb7rJr7qMMkFBTOhkMBpGlk/6PgfNyiy/lAiWFLCfocyveMMYUH5MRX9JtGQ7yUj6mGodfgiyVIcF215pPQxduKROt2l87S2/Nctuurpby8HCQRuOD5pz68QSurrmfCLrfd1JP6tTI/hrOfIwSVhGounXfJsHyxNv+A5j50=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W9b2CzI_1719818290;
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9b2CzI_1719818290)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 15:18:11 +0800
Message-ID: <cab761ce-14f6-4105-817c-c7cf6ffac0a7@linux.alibaba.com>
Date: Mon, 1 Jul 2024 15:18:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] support "THPeligible" semantics for mTHP with anonymous
 shmem
To: David Hildenbrand <david@redhat.com>, Bang Li <libang.li@antgroup.com>,
 hughd@google.com, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, wangkefeng.wang@huawei.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <21cnbao@gmail.com>
References: <20240628104926.34209-1-libang.li@antgroup.com>
 <b2e6fac2-7c23-4a92-8d89-ff29b8566967@linux.alibaba.com>
 <2972d75a-ab26-4da7-88fa-81bed955cf52@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <2972d75a-ab26-4da7-88fa-81bed955cf52@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/1 14:55, David Hildenbrand wrote:
> On 01.07.24 08:47, Baolin Wang wrote:
>> CC Barry.
>>
>> On 2024/6/28 18:49, Bang Li wrote:
>>> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
>>> anonymous shmem"), we can configure different policies through
>>> the multi-size THP sysfs interface for anonymous shmem. But
>>> currently "THPeligible" indicates only whether the mapping is
>>> eligible for allocating THP-pages as well as the THP is PMD
>>> mappable or not for anonymous shmem, we need to support semantics
>>> for mTHP with anonymous shmem similar to those for mTHP with
>>> anonymous memory.
>>
>> I did not see a consensus that "THP*" related statistics should contain
>> mTHP in previous discussion [1].
>>
>> In addition, if we all agree that "THPeligible" should include mTHP
>> statistics, you should update the corresponding documentation to keep
>> consistency.
>>
>> [1]
>> https://lore.kernel.org/linux-mm/202406262300.iAURISyJ-lkp@intel.com/T/#md7a77056110cebcc2a9b3cd7e4a8d682667f6ba5
>>
> 
> Fortunately, documentation (Documentation/filesystems/proc.rst) says:
> 
> "THPeligible" indicates whether the mapping is eligible for allocating 
> naturally aligned THP pages of any currently enabled size. 1 if true, 0 
> otherwise."
> 
> So that documentation is already pretty clear (we just have to make sure 
> the other ones are properly documented, for example as raised in reply 
> to [1]).

OK, great. Thanks.

