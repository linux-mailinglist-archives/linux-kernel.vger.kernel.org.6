Return-Path: <linux-kernel+bounces-185998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D578CBDF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3DA282307
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5502180C1C;
	Wed, 22 May 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Lq4J5ZNH"
Received: from out199-7.us.a.mail.aliyun.com (out199-7.us.a.mail.aliyun.com [47.90.199.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123F8175B
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716370748; cv=none; b=IP/cYIqEMWb32VrghQeHJb1NJEiQFQttBsL8Vqnw6WH5+dML9Mc8LQKaajU0n5KubJbbGa63XWXJ5MhMRtFYJEciW9kprlQ4DDcZLozCS4usbvYJRk5C+ekXSMpPdGFo3u3vMAU6BL3rPrhGOUBa1tHn9perqabgVeMTEFYcxgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716370748; c=relaxed/simple;
	bh=d0id1LwgFHCw2J6KgH62I0Tt8+BJF4ZBNowvWxLwOaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWk9Xt7hdRErXvCOq94vHrwN9Gwcae2EWe8h0Uikf0v0Yego6xv5OB23HdKs2LccUBbSBNjl2cFYcNEIfFbGH5racDmuyvaX4lkreuRny2EV5hCPmEKo3RnYD0yLrZd6JmTK6AdVQ/70iVGCKi1Eh7Fp5QwU3eWdkm9mswhDkpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Lq4J5ZNH; arc=none smtp.client-ip=47.90.199.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716370728; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BLQEugnL1kRYNRU+br9+o3u5TxKkPi3pJuyhAveE0vw=;
	b=Lq4J5ZNHwef65Q2/EN/mE5xJy12kxXhFO3ZNXiMcEnK6xk1bOw81t3teX3Q6WBarmamnXroW+egyQWbWBKOmYUEOX+WJsgGSpZIuJYCZS5DNwnkFbR5xCYlRL7XpA5OETJV2lg0HsNqJENhmyaq1rmGBg10MEgjYW5X8oRIvy8w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W7-ufZc_1716370726;
Received: from 30.97.56.54(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7-ufZc_1716370726)
          by smtp.aliyun-inc.com;
          Wed, 22 May 2024 17:38:47 +0800
Message-ID: <51ba1fc1-fd77-4601-8d27-459162fd008c@linux.alibaba.com>
Date: Wed, 22 May 2024 17:38:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: drop the 'anon_' prefix for swap-out mTHP counters
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, ying.huang@intel.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <0e2a6f232e7579a2e4407ecf075531980d97f286.1716367360.git.baolin.wang@linux.alibaba.com>
 <22ac01a3-ddbb-4114-88cd-ad1a31982dad@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <22ac01a3-ddbb-4114-88cd-ad1a31982dad@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/22 16:58, David Hildenbrand wrote:
> On 22.05.24 10:51, Baolin Wang wrote:
>> The mTHP swap related counters: 'anon_swpout' and 
>> 'anon_swpout_fallback' are
>> confusing with an 'anon_' prefix, since the shmem can swap out 
>> non-anonymous
>> pages. So drop the 'anon_' prefix to keep consistent with the old swap 
>> counter
>> names.
>>
>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
> 
> Am I daydreaming or did we add the anon_ for a reason and discussed the 
> interaction with shmem? At least I remember some discussion around that.

Do you mean the shmem mTHP allocation counters in previous 
discussion[1]? But for 'anon_swpout' and 'anon_swpout_fallback', I can 
not find previous discussions that provided a reason for adding the 
‘anon_’ prefix. Barry, any comments? Thanks.

[1] 
https://lore.kernel.org/all/05d0096e4ec3e572d1d52d33a31a661321ac1551.1713755580.git.baolin.wang@linux.alibaba.com/

