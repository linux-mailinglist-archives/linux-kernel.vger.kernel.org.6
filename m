Return-Path: <linux-kernel+bounces-574741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CDFA6E95D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E261887CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 05:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2DC1AAA11;
	Tue, 25 Mar 2025 05:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jIefvg8L"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D0618C92F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742882029; cv=none; b=fFC9xY183jLlVDxqv7mkR3/9VqTjJeLyCrrZ9qQoMyCT6JMPzQi9VcwI6cSaj0vpfOU8ZbLUJal0LxIhGejmmnbissOyrS7cs4T4Vzf6SO1i/pXfBaOmJiXohRg5O4eoj+UgszkLifaeOCoZqPaqjlUGaxOO4cRFLI0GcmJPIO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742882029; c=relaxed/simple;
	bh=wA7KUqw4HkLkczlrbUOWzqp8BRk8CM+bcIcDVI9glBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGVRwMmYeYj7nCAN1higGlQSS3p6Xm1OnrTadiyY7/z5KojouT9PTcpL7MPXWOO9vCPiPCmi3miGYGimIsPpX5gsEOknRMFGG28GDaga1xn254gUrXZeBmvh6D53lSl5vVb7OMXTJ0oPuSq4JJ41ikBag+0Y3ST7I48CAHQUgvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jIefvg8L; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3baba5be-2ea9-4a21-9c31-c3ded392008d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742882024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpftYX8ZR2ajN6GxHiLf28Hi/NRKx5J6dmni/tAJCKI=;
	b=jIefvg8LkX6uzuKX+R2i4tRskAK31SsJL9AlzMREdz4/3O4HKqzOMtGzU+HC3VUgpfcW5q
	ybY+XpE2HVE0fN/eJKrxPonSlRRkZRiM7uRTpOjhyeLh2ZzKlWfthuej0xk57MqsN8Fdys
	9DJlLTtPu5JG75yU68PExQmdzt2FFHQ=
Date: Tue, 25 Mar 2025 13:53:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] workqueue: Fix incorrect error return value in
 apply_workqueue_attrs_locked
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: tj@kernel.org, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
 Ye Liu <liuye@kylinos.cn>
References: <20250324090748.753195-1-ye.liu@linux.dev>
 <9fc752f5-239d-4734-a437-77a3bccf74ec@stanley.mountain>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <9fc752f5-239d-4734-a437-77a3bccf74ec@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/3/25 13:24, Dan Carpenter 写道:
> On Mon, Mar 24, 2025 at 05:07:48PM +0800, Ye Liu wrote:
> v> From: Ye Liu <liuye@kylinos.cn>
>> Commit 84193c07105c ("workqueue: Generalize unbound CPU pods") introduced
>> a change that caused apply_workqueue_attrs_locked() to return error
>> pointers using PTR_ERR() on failure instead of a negative error code.
> PTR_ERR() does return negative error codes.  Unless you pass it a NULL
> pointer, then it returns success.  Or if you pass it a valid pointer it
> returns garbage.
I misunderstood PTR_ERR(). Thanks for pointing it out.
>> This caused unexpected behavior in functions that rely on the return value
>> of apply_workqueue_attrs_locked, such as alloc_and_link_pwqs().
>>
>> Specifically, alloc_and_link_pwqs() expects apply_workqueue_attrs_locked()
>> to return 0 on success and a negative error code on failure. However,
>> returning PTR_ERR(ctx) instead of -ENOMEM led to incorrect error handling
>> in __alloc_workqueue, potentially causing system instability or crashes.
>>
>> This patch ensures apply_workqueue_attrs_locked() returns a proper negative
>> error code (-ENOMEM) in case of failure, restoring expected behavior.
>>
>> Fixes: 84193c07105c ("workqueue: Generalize unbound CPU pods")
>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>> ---
>>  kernel/workqueue.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index bfe030b443e2..8ba679d9b566 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -5363,7 +5363,7 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
>>  
>>  	ctx = apply_wqattrs_prepare(wq, attrs, wq_unbound_cpumask);
>>  	if (IS_ERR(ctx))
>> -		return PTR_ERR(ctx);
>> +		return -ENOMEM;
>>  
> The original code was correct and the patch is wrong.
Drop it.
> regards,
> dan carpenter
>

Thanks,

Ye Liu


