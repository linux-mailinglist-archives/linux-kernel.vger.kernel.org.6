Return-Path: <linux-kernel+bounces-245165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B3392AF26
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828341C204FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557B12C80F;
	Tue,  9 Jul 2024 04:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrIiyD5n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9629CEA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 04:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720500651; cv=none; b=XdWCNn5IPCYOK3EHfEVkberuBC0Gyfw3kCR51LCxCkNYjz86RGj5FI3Y4o69g2yk67PauFEl8aEKNQFA01kohWOEgXBr6GN1e3hJtzGxPUOIL5FQwz4SIWc9FETSphCTG6cbtbFplIYkh9VIZfSQcvPn7oKpGw4hZPoGeljAMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720500651; c=relaxed/simple;
	bh=2TNax2EtBrSi2LnXGraodWew7yNXTLfLOxei9yMY6Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukKsNDO2XZlivQ6ODEOv3ZRqOaO6izAjYU4TC2o0eWAa6PAdzrLqKwS2Bo4je9fTx3WwNXLeBsS5a9n6GlvB5OKIN9jAy1YoviK6qrPf5J1MQs3UIsTRoOSaunCqg4c9nrZaNZQ73dTyb7iwg9owE6PaMeePNO0J1AomfpSg80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrIiyD5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4088C32782;
	Tue,  9 Jul 2024 04:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720500650;
	bh=2TNax2EtBrSi2LnXGraodWew7yNXTLfLOxei9yMY6Dg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GrIiyD5nCKp0yLflaiBnxWcooLgyXphyxuUuDskwrolr4M/wWU7q++NWaYz0AOBeP
	 R0JNa7MHFIUiEScS4hx8gGOn9zO88QWa6+9NDzvsY0S45oenzp+AKvtkYf1j895dFS
	 x0r08jhp7k5yOwSOmPVvPDAolASj+viDxk1wlFU4R9kdyxcOYG+DMgPedUGrPq8A5f
	 Yp1g8RCqBsRq+A0X11sX8AU+8BZaRpJ+YOZVBIw6Tg5l1UObWsvtpCxjtwB8bpcPeG
	 76vVshHQ7/P55Oc17VN57Fiw42gBVyH7ltEKy8FAOQO3OniLYqqPukC1kKOMXKMjyp
	 s0pLcus6bPY8Q==
Message-ID: <1543faf3-d721-4e35-b467-08726a7ba27e@kernel.org>
Date: Tue, 9 Jul 2024 13:50:48 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: uapi: Fix compliation warning of using
 IOPRIO_PRIO_DATA
To: Zhiguo Niu <niuzhiguo84@gmail.com>, axboe@kernel.dk,
 Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
 Zhiguo Niu <zhiguo.niu@unisoc.com>, ke.wang@unisoc.com
References: <1717155071-20409-1-git-send-email-zhiguo.niu@unisoc.com>
 <e1719623-a42e-4394-b840-2741975ead37@acm.org>
 <CAHJ8P3KaWbKrGnmqmb_W9xw0k_F7i8oRK+MYscP02-k1XPyWfw@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAHJ8P3KaWbKrGnmqmb_W9xw0k_F7i8oRK+MYscP02-k1XPyWfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/9/24 12:27, Zhiguo Niu wrote:
> kindly ping...
> 
> Bart Van Assche <bvanassche@acm.org> 于2024年6月1日周六 04:13写道：
> 
> 
>>
>> On 5/31/24 04:31, Zhiguo Niu wrote:
>>> Generally, the input of IOPRIO_PRIO_DATA has 16 bits. If use format "%d"
>>> to printk IOPRIO_PRIO_DATA, there will be the following warning or error.
>>>
>>> fs/f2fs/sysfs.c:348:31: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘long unsigned int’ [-Wformat=]
>>>     return sysfs_emit(buf, "%s,%d\n",
>>>                                ~^
>>>                                %ld
>>>
>>> This is because the output of IOPRIO_PRIO_DATA is converted to "UL" from
>>> IOPRIO_PRIO_MASK, which is not reasonable. unsigned int is more suitable.
>>>
>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> ---
>>>   include/uapi/linux/ioprio.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
>>> index bee2bdb0..9ead07f 100644
>>> --- a/include/uapi/linux/ioprio.h
>>> +++ b/include/uapi/linux/ioprio.h
>>> @@ -11,7 +11,7 @@
>>>   #define IOPRIO_CLASS_SHIFT  13
>>>   #define IOPRIO_NR_CLASSES   8
>>>   #define IOPRIO_CLASS_MASK   (IOPRIO_NR_CLASSES - 1)
>>> -#define IOPRIO_PRIO_MASK     ((1UL << IOPRIO_CLASS_SHIFT) - 1)
>>> +#define IOPRIO_PRIO_MASK     ((1U << IOPRIO_CLASS_SHIFT) - 1)
>>>
>>>   #define IOPRIO_PRIO_CLASS(ioprio)   \
>>>       (((ioprio) >> IOPRIO_CLASS_SHIFT) & IOPRIO_CLASS_MASK)
>>
>> This change is safe even if the mask is applied to an expression with more bits
>> than an int because of the integer promotion rules. Hence:
>>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Looks good to me but I think this needs a Fixes tag and Cc-stable.

-- 
Damien Le Moal
Western Digital Research


