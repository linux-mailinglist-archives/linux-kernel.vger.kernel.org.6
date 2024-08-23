Return-Path: <linux-kernel+bounces-298829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC9D95CBFA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DE51F24BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7BF184547;
	Fri, 23 Aug 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="suiDXK2G"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5A6184527
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414647; cv=none; b=XzBRji0KwMRAK2nLcJOlzYX8QIDIyPH/oGw0yxwAPleShOUFw9mFoxtECJpdYs6/ZPC9WmVSyz7RNZDOoY4NcNz8GKb0eKjGGI+2JVwJ93ioVC3e5bD8kRnlRomvxI1l2BYulSijpl1hIf1QKtEYx8EX0xtxD2+I1RV0dbtDBMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414647; c=relaxed/simple;
	bh=fyzr7fb2kWsyVTwK9PR+UAPo68zR5RMmPdLXxwui6mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QY98bTv2z25sRCyrDy8nI3I+pjihf7Ocw8dLYb7VCas/nwgdHRMr+3gwmkNtTYeqOXV9JoO+yE2ACs1qy/0nxhfE97J3hdb9WIOMGtGvfkVeJRlmOKHLCs2MX9TtGCKv+1lM7W9SHL+Vdx3x8Kc2nwiW8NfpwlUOjbwXhwL8V8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=suiDXK2G; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724414636; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AQqCQwb+Jccrz3xk4NCyo0ZnAcB4vP2QRPGZr5pucPg=;
	b=suiDXK2GekRFOkVwbw4KPEPCk9nPNiDTwWFA/GLop22m3KHKJcD7/46ref2Ggp5kFL3vIba1Sff/PNYFj1qmiFANuhuV5D20OfzwIGCLplgz41weN6LsdMDt9AhKcvA5iZP+VLiYzmzqpij0gUawFqVHjgUTMdFrWCmes6Fd3g8=
Received: from 172.20.10.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDTYZkX_1724414634)
          by smtp.aliyun-inc.com;
          Fri, 23 Aug 2024 20:03:55 +0800
Message-ID: <b399e356-6e95-489a-a844-3545a6f22e12@linux.alibaba.com>
Date: Fri, 23 Aug 2024 20:03:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: [PATCH v2] Prevent entering an infinite loop when
 i is 0
To: liujinbao1 <jinbaoliu365@gmail.com>, xiang@kernel.org
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mazhenhua@xiaomi.com,
 liujinbao1 <liujinbao1@xiaomi.com>
References: <20240823030525.4081970-1-jinbaoliu365@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240823030525.4081970-1-jinbaoliu365@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/23 11:05, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> When i=0 and err is not equal to 0,
> the while(-1) loop will enter into an
> infinite loop. This patch avoids this issue.
> 
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
> ---
>   fs/erofs/decompressor.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
>> Hi,

The patch is corrupted and the patch subject
line is also broken.

I think it should be:
[PATCH v2] erofs: prevent entering an infinite loop when i is 0

>>
>> On 2024/8/22 14:27, liujinbao1 wrote:
>>> From: liujinbao1 <liujinbao1@xiaomi.com>
>>>
>>> When i=0 and err is not equal to 0,
>>> the while(-1) loop will enter into an
>>> infinite loop. This patch avoids this issue.
>>
>> Missing your Signed-off-by here.
>>
>>> ---
>>>   fs/erofs/decompressor.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c index
>>> c2253b6a5416..1b2b8cc7911c 100644
>>> --- a/fs/erofs/decompressor.c
>>> +++ b/fs/erofs/decompressor.c
>>> @@ -539,6 +539,8 @@ int __init z_erofs_init_decompressor(void)
>>>       for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>>>               err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>>>               if (err) {
>>> +                    if (!i)
>>> +                            return err;
>>>                       while (--i)
>>>                               if (z_erofs_decomp[i])
>>>                                       z_erofs_decomp[i]->exit();
>>
>>
>> Thanks for catching this, how about the following diff (space-demaged).
>>
>> If it looks good to you, could you please send another version?
> 
>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c index c2253b6a5416..c9b2bc1309d2 100644
>> --- a/fs/erofs/decompressor.c
>> +++ b/fs/erofs/decompressor.c
>> @@ -534,18 +534,16 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
>>
>> int __init z_erofs_init_decompressor(void)
>> {
>> -      int i, err;
>> +      int i, err = 0;
>>
>>         for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>>                 err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>> -              if (err) {
>> +              if (err && i)
>>                         while (--i)
>>                                 if (z_erofs_decomp[i])
>>                                         z_erofs_decomp[i]->exit();
>> -                      return err;
> +						break;
>> -              }
>>         }
>> -      return 0;
>> +      return err;
>> }
>>
> missing break?

Why needing a break?

Thanks,
Gao Xiang


