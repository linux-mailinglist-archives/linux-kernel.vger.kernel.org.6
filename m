Return-Path: <linux-kernel+bounces-288994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA7F954102
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89CECB2162B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E116082899;
	Fri, 16 Aug 2024 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LNu3KoHX"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B478C8F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723785431; cv=none; b=O3elwNrPCaan93N05/Odvz4BCFea2qq7kkz+zZtDkKTFKxvfRpm6rXa0b53FAViIWdyqaWrrS74PwW/5r7aZaZ/Vvoz+M5P+6BviKZH7/PQaq9+TrGOFYV8IF7hy+/MSkrXzuysT3xDTbxX2vMtM3lofqXUQZkLfVGk+Sd61NF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723785431; c=relaxed/simple;
	bh=nRAfanlxUVlZDEHmgrm3fNjyplH4PjupK7li4GlesnM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W4w/TfXEID+VkhVqSqqWsjvmls5C/QhwunhUGMPbPCH8ku2Id4RHLASh7iVCcVvk3q1MOtKR4A3AfC4EGTF6mK8arB1w0CTzebb4g14yO8P8MNc+d0SDKz2HrJ3LM4fJpGuPqzyOmUT3LEyEK08W0bLjqLgoz9hZnVOLW/kjgQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LNu3KoHX; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723785426; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=MIt4+z4yVxnBi0/X+/xarmiTleVh8KRAyG6uQFIHiP4=;
	b=LNu3KoHXz0RmeBDRsI3n+38o1jIQ/GAqZrOzOPxIn7kJPyCXbRDwAOGQaKulsVEKQu+gfYr8fFWjT5Qztos9bzrJEkSfocOesBsZnWJJ0Tm5UJPjoYip9XmqTyEyFBpsoFhaQaTesowrpb56WXchtOpr5B6IG2cJZkjYkalCVfs=
Received: from 30.221.129.229(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCzBcHy_1723785425)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 13:17:06 +0800
Message-ID: <fc4981c1-b7f1-4295-a0f8-a293b5610f79@linux.alibaba.com>
Date: Fri, 16 Aug 2024 13:17:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: fix deadlock in migrate_pages_batch() on
 large folios
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Gao Xiang <xiang@kernel.org>
References: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>
 <87plqx0yh2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d93b06a5-20f2-41bd-a7f5-d06906d88ba4@linux.alibaba.com>
 <20240815220224.d7970835d5c12b4833bd04dc@linux-foundation.org>
 <aa5ac560-1dcc-45b6-8e24-0e9cb59feb18@linux.alibaba.com>
In-Reply-To: <aa5ac560-1dcc-45b6-8e24-0e9cb59feb18@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/16 13:12, Gao Xiang wrote:
> 
> Hi Andrew,
> 
> On 2024/8/16 13:02, Andrew Morton wrote:
>> On Mon, 29 Jul 2024 09:58:02 +0800 Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>>> For the fix, I think that we should still respect migrate_mode because
>>>> users may prefer migration success over blocking.
>>>>
>>>> @@ -1492,11 +1492,17 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>>>>        return rc;
>>>>    }
>>>> -static inline int try_split_folio(struct folio *folio, struct list_head *split_folios)
>>>> +static inline int try_split_folio(struct folio *folio, struct list_head *split_folios,
>>>> +                  enum migrate_mode mode)
>>>>    {
>>>>        int rc;
>>>> -    folio_lock(folio);
>>>> +    if (mode == MIGRATE_ASYNC) {
>>>> +        if (!folio_trylock(folio))
>>>> +            return -EAGAIN;
>>>> +    } else {
>>>> +        folio_lock(folio);
>>>> +    }
>>>>        rc = split_folio_to_list(folio, split_folios);
>>>>        folio_unlock(folio);
>>>>        if (!rc)
>>>
>>> Okay, yeah it looks better since it seems I missed the fallback
>>> part in migrate_pages_sync().
>>>
>>> Let me send the next version to follow your advice, thanks.
>>
>> The author seems to have disappeared.  Should we merge this as-is or
>> does someone want to take a look at developing a v2?
> 
> I've replied your email last week, I'm not sure why it has not
> been addressed?
> 
> https://lore.kernel.org/linux-mm/20240729021306.398286-1-hsiangkao@linux.alibaba.com/
> 
> The patch in your queue is already v2? No?

Really confused about this, since the comment above was about v1.
and v2 is already sent (in July 29) and in -next for two weeks
with

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>

What else I need to do to resolve this already resolved comment
so that I could enable large folios without deadlocks anymore?

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang

