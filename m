Return-Path: <linux-kernel+bounces-260702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E7A93AD2F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23841F2261D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B107A141;
	Wed, 24 Jul 2024 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DceoZyTw"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09CF219FC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721806443; cv=none; b=ukg4T7bh8oEK4AhN/N92chnE3Px9NkXhuK8cJkqc/dz9bmRneLEKUxNej2VNH7KTqwkJzSKQE3bxV3bgFvOCorPwFyGlNT6eFY0An7FYGTxkEBPlYVMRrNL4EXSo2hjndCqQHM5/Q0O8kdnkHeNkqLVmkZ0pdSj6FueVfoVMe0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721806443; c=relaxed/simple;
	bh=i6qjkdUePQuOA+i1d6kmyuaPxep0vlMZsujaMzjzN+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZEnefnwjU2vHFw5655UMf/xFPr/HYR3LcQcc1v8RSUti9Kr7dNkC88gwJvDCqluYGWKlnnR0ucl1cYmMOHCfICy53NPCjFV7kqfIUtUJfv4UMGq8bQDozapWhhblvzCozbUdHJeBMZeIy8LjXVb2zKSj8D+G9bsSFyrUfeGp0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DceoZyTw; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cfce353d-e5b0-47be-9a02-be4558d4dc33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721806437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eg2MuHRu4ooOvmdV8vJNdd7cZLAuF4g4MEIkwqOWBKA=;
	b=DceoZyTw7tNaiJeOpXLh2xDm2mY6q8Uh0yzm7aYYpnK9UuCZzG5y4oMGyOZDSclMGzGyAz
	RzjBzrdKtzviNE0Yxfx5+l8lFLS5RJWpU9V1HJUGRXODN3A0duGcu4zngxPjfzHqPzVKc5
	y1RWI6+H1QvpEFOnHinDw4v/OAEH9A4=
Date: Wed, 24 Jul 2024 15:33:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] fs/direct-io: Remove linux/prefetch.h include
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Youling Tang <tangyouling@kylinos.cn>, Jan Kara <jack@suse.cz>
References: <20240603014834.45294-1-youling.tang@linux.dev>
 <20240603111844.l4g2yk5q6z23cz3n@quack3>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <20240603111844.l4g2yk5q6z23cz3n@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 03/06/2024 19:18, Jan Kara wrote:
> On Mon 03-06-24 09:48:34, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> After commit c22198e78d52 ("direct-io: remove random prefetches"), Nothing
>> in this file needs anything from `linux/prefetch.h`.
>>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
Sorry to bother you, but do we still need this patch?

Thanks,
Youling.

> Looks good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza
>
>> ---
>>   fs/direct-io.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/fs/direct-io.c b/fs/direct-io.c
>> index b0aafe640fa4..bbd05f1a2145 100644
>> --- a/fs/direct-io.c
>> +++ b/fs/direct-io.c
>> @@ -37,7 +37,6 @@
>>   #include <linux/rwsem.h>
>>   #include <linux/uio.h>
>>   #include <linux/atomic.h>
>> -#include <linux/prefetch.h>
>>   
>>   #include "internal.h"
>>   
>> @@ -1121,11 +1120,6 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>>   	struct blk_plug plug;
>>   	unsigned long align = offset | iov_iter_alignment(iter);
>>   
>> -	/*
>> -	 * Avoid references to bdev if not absolutely needed to give
>> -	 * the early prefetch in the caller enough time.
>> -	 */
>> -
>>   	/* watch out for a 0 len io from a tricksy fs */
>>   	if (iov_iter_rw(iter) == READ && !count)
>>   		return 0;
>> -- 
>> 2.34.1
>>


