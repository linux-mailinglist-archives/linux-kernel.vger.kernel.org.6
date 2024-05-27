Return-Path: <linux-kernel+bounces-190020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4248CF872
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EA52832D2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1247D512;
	Mon, 27 May 2024 04:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EFeOnbg2"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BDCC129
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716784646; cv=none; b=NQA6nc3lQczwm4GalxMSiQy/bIO03I8Hd2AzHbnbYvi+XhlLgwfZxwyr/9Z0eJ3PGunmGIYGhqIEZv+NmlALJHDYnaKiCtNmgvpnY+qfqzx9WzjnJKkVRfSx8GpKpT+xKM6nPUJ66duicFrPJqd8lNGlRdma2GFtrQrAN4ZVRrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716784646; c=relaxed/simple;
	bh=7+pDpRVpWCQHFQ4LB1/gB/N6+V++iFlL7uGocdiOfEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAgxEjnIHcqaV3Uoq+CBiTSTNwulcFlMJFL9FOFpe0r7sYqHxkcyx26GxOpzU6ebCTjoBFXci1EUWURNmDYmT17V9EUX4AQFZ6rsDNrMlzujeevGH9W6DukbqhtLyvHoDuPhnDgSsbzzjJQzehwRw9tUFB1ZbLibFWuXOt1z4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EFeOnbg2; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: david@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716784641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQyD8u11NrOanpKOcWnKj72z9MQcFgIv9avWEkfCemo=;
	b=EFeOnbg2XZXpvVldwuyvIr1GkjGfEao2bYAagv7mmzP6845rsFBQU0mi4apVb1cJ1d+quj
	++n6mC1Fedu86yjZb3A8McObuIUxU41Lj8Rj8x5JUGEORDtVRU5EX/3XfQwJCnaOpJjNCt
	Fk5a38k9L+jkIUbDHKU4mwGcM29pBRU=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: aarcange@redhat.com
X-Envelope-To: hughd@google.com
X-Envelope-To: shr@devkernel.io
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: zhouchengming@bytedance.com
Message-ID: <36d4f3a6-c426-4455-b5be-2ab503d380ad@linux.dev>
Date: Mon, 27 May 2024 12:36:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] mm/ksm: refactor out try_to_merge_with_zero_page()
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com,
 hughd@google.com, shr@devkernel.io
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240524-b4-ksm-scan-optimize-v1-0-053b31bd7ab4@linux.dev>
 <20240524-b4-ksm-scan-optimize-v1-1-053b31bd7ab4@linux.dev>
 <18259f7c-d57e-4504-91ec-90b7c87aad01@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <18259f7c-d57e-4504-91ec-90b7c87aad01@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/24 23:12, David Hildenbrand wrote:
> On 24.05.24 10:56, Chengming Zhou wrote:
>> In preparation for later changes, refactor out a new function called
>> try_to_merge_with_zero_page(), which tries to merge with zero page.
>>
>> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
>> ---
>>   mm/ksm.c | 67 +++++++++++++++++++++++++++++++++++-----------------------------
>>   1 file changed, 37 insertions(+), 30 deletions(-)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 4dc707d175fa..cbd4ba7ea974 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -1531,6 +1531,41 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
>>       return err;
>>   }
>>   +/* This function returns 0 if the pages were merged, -EFAULT otherwise. */
> 
> No it doesn't. Check the "err = 0" case.
> 

Right, how about this: This function returns 0 if the page were merged or the vma
is out of date, which means we don't need to continue, -EFAULT otherwise.

