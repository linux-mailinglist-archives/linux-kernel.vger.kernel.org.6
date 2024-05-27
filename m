Return-Path: <linux-kernel+bounces-190153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B88CFA4C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFCD1C210A2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2687C13C;
	Mon, 27 May 2024 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CLJCQTE/"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BA122338
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795714; cv=none; b=mW5CE8mDMAB+OZclLQtIDa9eIHy8V5Z76vudz6QlmZIijnQLr1G412cC+VxmOFt/ukYGOfrgk//Duvmw1Ob3rulv0d4vHn8CN2+PWIUrfOUtKG33cRVhUbBsQtnbvZ6Ncuo44OjCaBHyMnWgJdqDTZSDo01h2yPy8ursqqnBLmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795714; c=relaxed/simple;
	bh=3Rr1HaG9tG9vsr3RvcnFDKNXwGd3bAmbX0F/s1f15pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciATLMXunvwyK1ZCELXGfqhUnANcj7qGPRaD4gC1D7Ii0ROmZnNMPNfF0KnCSgFLKgna/vIX8PPRV9eGUIA0n6mRMPUmZTdeT7H+MY7qFrHLYJeDZNhSStbqN/vVC8X5tPSVdJGoo5EXSPxKqtA15nzGfNxEn9vLoRTfBjWAO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CLJCQTE/; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: david@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716795709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A8ih7vz66Rx+ZxVaMPrr50Ps6h1emlB7JWpOfQ6g6+8=;
	b=CLJCQTE/vly7FuFm/O96eANqAlO1xjq4WZyQtTRg7+o7S3z8nAA/pw9hHG7z8v6UmUVWEj
	DAsGh4R23PM3h1mMP9uGubp94rSQC5EifT1BGP+atzIxVzxjwpG8oi+kRoBoe5dQpL7jAO
	QeQn9+WSoa/zkivs6BVf4vfdAZon4Es=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: aarcange@redhat.com
X-Envelope-To: hughd@google.com
X-Envelope-To: shr@devkernel.io
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: zhouchengming@bytedance.com
Message-ID: <f839ae47-2776-4684-a331-564554426ae2@linux.dev>
Date: Mon, 27 May 2024 15:41:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] mm/ksm: refactor out try_to_merge_with_zero_page()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com,
 hughd@google.com, shr@devkernel.io
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240524-b4-ksm-scan-optimize-v1-0-053b31bd7ab4@linux.dev>
 <20240524-b4-ksm-scan-optimize-v1-1-053b31bd7ab4@linux.dev>
 <18259f7c-d57e-4504-91ec-90b7c87aad01@redhat.com>
 <36d4f3a6-c426-4455-b5be-2ab503d380ad@linux.dev>
 <18ad1a9f-8f00-41c1-9c77-ac3252061852@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <18ad1a9f-8f00-41c1-9c77-ac3252061852@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/27 15:18, David Hildenbrand wrote:
> Am 27.05.24 um 06:36 schrieb Chengming Zhou:
>> On 2024/5/24 23:12, David Hildenbrand wrote:
>>> On 24.05.24 10:56, Chengming Zhou wrote:
>>>> In preparation for later changes, refactor out a new function called
>>>> try_to_merge_with_zero_page(), which tries to merge with zero page.
>>>>
>>>> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
>>>> ---
>>>>    mm/ksm.c | 67 +++++++++++++++++++++++++++++++++++-----------------------------
>>>>    1 file changed, 37 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>>> index 4dc707d175fa..cbd4ba7ea974 100644
>>>> --- a/mm/ksm.c
>>>> +++ b/mm/ksm.c
>>>> @@ -1531,6 +1531,41 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
>>>>        return err;
>>>>    }
>>>>    +/* This function returns 0 if the pages were merged, -EFAULT otherwise. */
>>>
>>> No it doesn't. Check the "err = 0" case.
>>>
>>
>> Right, how about this: This function returns 0 if the page were merged or the vma
>> is out of date, which means we don't need to continue, -EFAULT otherwise.
> 
> Maybe slightly adjusted:
> 
> This function returns 0 if the pages were merged or if they are no longer merging candidates (e.g., VMA stale), -EFAULT otherwise.
> 

Great, will change to this. Thanks!

