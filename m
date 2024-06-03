Return-Path: <linux-kernel+bounces-198736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A288D7CB9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4844B22452
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624B24BAA6;
	Mon,  3 Jun 2024 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dATJn8J7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E4D15E88
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401007; cv=none; b=Y//SsmAMo8m9RyslCCzHDeEyW6zbowvOWv3r9i7eBPJk422TG/3CtRFkTPjsoT5JviO55pmcMrS+JnBTFh30EUQQS20imuoX9hWP4cmEmNV0QWLcwAs2dbFl5XtoyD1rMgvs7nY+dKS6uvfcIgQRv/3OQZCZb1946gSnoQlkkZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401007; c=relaxed/simple;
	bh=9fEUa8FDwmaLhcJXzAHKhcMaSGB5f5Nva+6gt2SaNrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9Fg8YMFCMGUc8EcV+5Snaw7JKt/1CDqIcOSqeDWX89ZZ09TzoC4pQKm3Vryc6r4H7DymMKQSSnVJLVmmIO6CZ9e9d7lCCO6dsUQOIzk9HbB1XjueA/ddqkReUtxJ1t+seoBQSZuJTUqz/GuYsBzZC3ZXx2SLInewSPPhXIriIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dATJn8J7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FF0C2BD10;
	Mon,  3 Jun 2024 07:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717401007;
	bh=9fEUa8FDwmaLhcJXzAHKhcMaSGB5f5Nva+6gt2SaNrQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dATJn8J7VpQPZCMEgOIQ906FUhnCevaMyL4YtFA2RHURmgdxcuulIQr4uup+CBDfV
	 VWSBR1PkzphKv3Dd+9xsbjYYtJPg9SPLHTm4kRuI8zqMnFgBSkgpITcSppXsQ9Ztw6
	 a3VqLxzbUrXn1uVrL03O/UaSyFgc34jsCgjRIGHiqQxXJspkX0L2SG7qc3la+lJhqc
	 PrGpZRCe7nse4ezR2fT9Dd6VijR3JHzuU8UpDDcONNixidm4N2Ec4JESRIxu7Bixii
	 WNhIpQWLqh8WEViuqf+gRXT1fOGpTjF1uD6uz4mJZk1fIaafg6fBa/85D1N8ip0oMX
	 o5Jo4TojPOsDQ==
Message-ID: <10f4898f-0b8c-4503-8620-3bb566e9a163@kernel.org>
Date: Mon, 3 Jun 2024 15:50:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: use new ioprio Macro to get ckpt thread ioprio data
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com
References: <1717146645-18829-1-git-send-email-zhiguo.niu@unisoc.com>
 <b0c9f3dc-417a-4891-bdf0-25b849828e3b@kernel.org>
 <CAHJ8P3LFkk0YnF-vnsd7wVMHXyhJN43Gfqtq3EBqjxoqgd88mg@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3LFkk0YnF-vnsd7wVMHXyhJN43Gfqtq3EBqjxoqgd88mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/6/3 14:52, Zhiguo Niu wrote:
> On Mon, Jun 3, 2024 at 2:39 PM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/5/31 17:10, Zhiguo Niu wrote:
>>> Use new Macro IOPRIO_PRIO_LEVEL to get ckpt thread ioprio data(level),
>>> it is more accurate and consisten with the way setting ckpt thread
>>> ioprio(IOPRIO_PRIO_VALUE(class, data)).
>>>
>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> ---
>>>    fs/f2fs/sysfs.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>> index 72676c5..55d46da 100644
>>> --- a/fs/f2fs/sysfs.c
>>> +++ b/fs/f2fs/sysfs.c
>>> @@ -340,7 +340,7 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>>>        if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
>>>                struct ckpt_req_control *cprc = &sbi->cprc_info;
>>>                int class = IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio);
>>> -             int data = IOPRIO_PRIO_DATA(cprc->ckpt_thread_ioprio);
>>> +             int data = IOPRIO_PRIO_LEVEL(cprc->ckpt_thread_ioprio);
>>
>> So, can you please use 'level' to instead 'data' in f2fs_sbi_show() and
>> __sbi_store()?
> Hi Chao,
> 
> IOPRIO_PRIO_DATA in the new kernel version includes two parts: level and hint.
> In __sbi_store, " IOPRIO_PRIO_VALUE(class, data)"  is used to set ckpt
> iopriority,
> and it will pass default hint value, we just need to keep class /level right.

Zhiguo,

I think f2fs only support configuring priolevel rather than priolevel and
priohint of ckpt thread via ckpt_thread_ioprio sysfs interface, so it will
be more readable to use 'level' instead of 'data' in context of the interface,
thoughts?

Thanks,

> 
>   #define IOPRIO_PRIO_VALUE(prioclass, priolevel) \
>     ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE)
> so i think this part is not needed to modify.
> 
> thanks!
>>
>> Thanks,
>>
>>>
>>>                if (class != IOPRIO_CLASS_RT && class != IOPRIO_CLASS_BE)
>>>                        return -EINVAL;
>>

