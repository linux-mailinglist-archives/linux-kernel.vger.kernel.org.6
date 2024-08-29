Return-Path: <linux-kernel+bounces-306744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39F89642D4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B206E286248
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F02F2B9CD;
	Thu, 29 Aug 2024 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FzMvWmM6"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7317740
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930156; cv=none; b=Nn+MJ4uISd31I1XJ/WgTmN1epavJ5ZaloGDsKW2rknp37wSegBpT7KtKe5Vx2med2Pf1bJUQRBPTQ1KSDyxtw+ex9Sawy9LSFj7PMhFTcTjXzFekNKM4UcVHUdpTBFcdvHTdl2xZ1SJ4UMNMhIWDflxZo3wlEnIdupCi9PxGxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930156; c=relaxed/simple;
	bh=aC7h6qgfouUl8lP2IAF61qn+UkNs8Gs7bNfgbLB0TLI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=reedIsLrpbFuSeAkoySFqackQyCxOcLj6GWdZLNGe7AyABNEHlXklI1PG/aLXBHhxoZQvRejiTWZEVESYaERH6trpFKfvWdOyBkZQKeYOPfsAvFDee8EC4dUHG/cHwKyNd4pAxk21RXrc9FTzu+wf+HZ2UyfPVthRSWJuYGyEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FzMvWmM6; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724930145; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=zEwB9Si8ou8T0UofhaL2qWYwFGv9oGMQFPNW8VpmMXA=;
	b=FzMvWmM6xUDHqepBhex9HuQTr1INxAU2odHdHwGQ96l8uNyryAlfirVK57ybk5mVM9xwcxNqDs6Qng2/cYItt9IgvvSC1pgIwOi8s2HcU5gRXnRX+IbSHb+hbNaHhybjpXIZN/Do1m/T224jqcLrUxgXFBXIUsbnImzvd2/6CdU=
Received: from 30.221.130.221(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDsuHEm_1724930143)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 19:15:44 +0800
Message-ID: <76c8e7c1-82c0-46bd-9e46-96c8eaac83b1@linux.alibaba.com>
Date: Thu, 29 Aug 2024 19:15:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: [PATCH v2] Prevent entering an infinite loop when
 i is 0
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: liujinbao1 <jinbaoliu365@gmail.com>
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mazhenhua@xiaomi.com,
 liujinbao1 <liujinbao1@xiaomi.com>, Gao Xiang <xiang@kernel.org>,
 Hongzhen Luo <hongzhen@linux.alibaba.com>
References: <20240823030525.4081970-1-jinbaoliu365@gmail.com>
 <b399e356-6e95-489a-a844-3545a6f22e12@linux.alibaba.com>
In-Reply-To: <b399e356-6e95-489a-a844-3545a6f22e12@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi liujinbao1,

Since it's a trivial bug which can be simply fixed, I just
would like to confirm if you still have time and interest to
send a workable patch (after a week).

If you don't have time to follow up, I will ask Hongzhen to
fix this with your "Reported-by:" tomorrow.

Thanks,
Gao Xiang

On 2024/8/23 20:03, Gao Xiang wrote:
> 
> 
> On 2024/8/23 11:05, liujinbao1 wrote:
>> From: liujinbao1 <liujinbao1@xiaomi.com>
>>
>> When i=0 and err is not equal to 0,
>> the while(-1) loop will enter into an
>> infinite loop. This patch avoids this issue.
>>
>> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
>> ---
>>   fs/erofs/decompressor.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>>> Hi,
> 
> The patch is corrupted and the patch subject
> line is also broken.
> 
> I think it should be:
> [PATCH v2] erofs: prevent entering an infinite loop when i is 0
> 
>>>
>>> On 2024/8/22 14:27, liujinbao1 wrote:
>>>> From: liujinbao1 <liujinbao1@xiaomi.com>
>>>>
>>>> When i=0 and err is not equal to 0,
>>>> the while(-1) loop will enter into an
>>>> infinite loop. This patch avoids this issue.
>>>
>>> Missing your Signed-off-by here.
>>>
>>>> ---
>>>>   fs/erofs/decompressor.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c index
>>>> c2253b6a5416..1b2b8cc7911c 100644
>>>> --- a/fs/erofs/decompressor.c
>>>> +++ b/fs/erofs/decompressor.c
>>>> @@ -539,6 +539,8 @@ int __init z_erofs_init_decompressor(void)
>>>>       for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>>>>               err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>>>>               if (err) {
>>>> +                    if (!i)
>>>> +                            return err;
>>>>                       while (--i)
>>>>                               if (z_erofs_decomp[i])
>>>>                                       z_erofs_decomp[i]->exit();
>>>
>>>
>>> Thanks for catching this, how about the following diff (space-demaged).
>>>
>>> If it looks good to you, could you please send another version?
>>
>>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c index c2253b6a5416..c9b2bc1309d2 100644
>>> --- a/fs/erofs/decompressor.c
>>> +++ b/fs/erofs/decompressor.c
>>> @@ -534,18 +534,16 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
>>>
>>> int __init z_erofs_init_decompressor(void)
>>> {
>>> -      int i, err;
>>> +      int i, err = 0;
>>>
>>>         for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>>>                 err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>>> -              if (err) {
>>> +              if (err && i)
>>>                         while (--i)
>>>                                 if (z_erofs_decomp[i])
>>>                                         z_erofs_decomp[i]->exit();
>>> -                      return err;
>> +                        break;
>>> -              }
>>>         }
>>> -      return 0;
>>> +      return err;
>>> }
>>>
>> missing break?
> 
> Why needing a break?
> 
> Thanks,
> Gao Xiang


