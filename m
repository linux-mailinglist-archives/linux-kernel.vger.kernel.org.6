Return-Path: <linux-kernel+bounces-190232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C3E8CFBB3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A8628237B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090A260882;
	Mon, 27 May 2024 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYpGl9zp"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D89E47F41
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799261; cv=none; b=fKECHuB8XiMwgNhHckJxNM4XdsPtJFSUG5gWCYki9zzs7iLZjTHeA0RtNkIRnnpPMa9PrBX2rwaMC7xHleX0xxH4JXWPcO6nrAlCAgHTGCoV5OAdn/N5iizICyr3sHMHAcdww1tnof/hx7isnDN6KknctkQEdltYh+EVVUtAg1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799261; c=relaxed/simple;
	bh=LnRnA2Jjmv5v1wzM1P4UEYWuVqzhiZ8cKDv1xenj3pE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9QLYc6fZB8IVotP0yOrbJERGqcR/LpL8VjZALwvwKP/pp5HqOZgOGGDxWHLCkVxRpGWOThndhBi1Gn5vtnliTG2pUPbrnf5zitVVIKXtJAi3SFgnkqdoxM0gGZO43oZZpsSggp3hJqGJi4KcN7av1NFxFI1VdoRSRb/5FLfnKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYpGl9zp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f8ea2df4b3so2164873b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716799258; x=1717404058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwVuXWQUZEgL6e/tw+iGOXe1aznzrrLjd63ykG2zqqQ=;
        b=bYpGl9zp2bUmbbYjeGtZhmA8UkJLmMmd2AOzS3TQnggNPI43b/g3TqCojPDZs+kjYP
         MCzxDdAzZCa0flOlv/HEjv8fRQoMo7H1xzSHr4bUD9ITTjVBX4pl+a6502umjvCjMlp4
         8/aMHVPmGG1cgo++vNQcxbrPYa3u1Nj8BXHPOjyc81fEb3r4xzmoV4k2AKG+yV0xfSNX
         E9SDKD3vAmuGnmjmGilpErkD0oiZRDNiLe5LGLfaXE+rSg/Y0EtaqQdn7iCpIphrcMdd
         GBF5F4PAOU+we/FRJfCA2dGJvC4lCcbNyC7vaKMuuXckITEx1Xv9sfJeXvonLUYsy0kv
         A3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716799258; x=1717404058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwVuXWQUZEgL6e/tw+iGOXe1aznzrrLjd63ykG2zqqQ=;
        b=A+YNiem/sbm6HSjzK6YJWNjh57SaS+OsPhUbm5yintv/NwGyD1A8WkmCx3wj61BqaA
         g+B4vRTGWys0Jzqdl6JStyqm3/DehmhwJZzk3vcRB/ZdAuzBzBPF8/2tgPF+yIzYDjuG
         nzNxoV14y2zAMPMyRz+bRoGRwGeRJJyojVYpqMGGmv5F04O9H5hcaDgvy3tatNzA0/C/
         x9fAFOxacpZNb3w3yISr5zhPH9ZKEVnZ9dmU27NLhIG5lwwRfM/xpvh0nQ+b2H62Nd69
         l8weAnAVZZ9xBTfoA41+PGpwUJsqdnQ9cTk+eNlpSQjz3NEI8u18+852swAiUY7jaXJ2
         EfnA==
X-Forwarded-Encrypted: i=1; AJvYcCUgd24q+IL4U4al/dNa6/x7t3HIh+Pry8O9UVqb28fk7TTZ5gGFyYODzGX+M8QojIeer/gmtUMXrO+PJPaFec6cyEXgh7sQvieFeC35
X-Gm-Message-State: AOJu0YxcC6DmaMd411MTMwYFGvK7PT1GPd/sezM/ye71oVexH/1vgoDP
	d95MMSG3z+/WmbT8xYW7ARBPsivqviPvaGzril7e8eX8w8bPDCou
X-Google-Smtp-Source: AGHT+IFE9T0rPP7MwtRJUQicZehQa9jFlvSRFoYunB9B4Qz+S1VqJZB9Znj1JzGeT9hBbKTDRlVOxw==
X-Received: by 2002:a05:6a20:3d88:b0:1af:b86d:b6dc with SMTP id adf61e73a8af0-1b212f63dfdmr9828343637.55.1716799258547;
        Mon, 27 May 2024 01:40:58 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbea891sm4452567b3a.126.2024.05.27.01.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 01:40:58 -0700 (PDT)
Message-ID: <694d1a9c-4e2d-4fd1-8b04-1c753c414761@gmail.com>
Date: Mon, 27 May 2024 17:40:54 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/virtio: pipe assertion in vring_test.c
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 skhan@linuxfoundation.org, Austin Kim <austindh.kim@gmail.com>,
 shjy180909@gmail.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20240527071330.105268-1-yskelg@gmail.com>
 <20240527035009-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <20240527035009-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/27/24 4:52 오후, Michael S. Tsirkin wrote:
> On Mon, May 27, 2024 at 04:13:31PM +0900, yskelg@gmail.com wrote:
>> From: Yunseong Kim <yskelg@gmail.com>
>>
>> The virtio_device need to fail checking when create the geust/host pipe.
> 
> typo

Thank you for code review Michael.

Sorry, there was a typo in my message.

I'll fix it and send you patch version 2.

>>
>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> 
> 
> I guess ... 
> 
>> ---
>>  tools/virtio/vringh_test.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
>> index 98ff808d6f0c..b1af8807c02a 100644
>> --- a/tools/virtio/vringh_test.c
>> +++ b/tools/virtio/vringh_test.c
>> @@ -161,8 +161,8 @@ static int parallel_test(u64 features,
>>  	host_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>>  	guest_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>>  
>> -	pipe(to_guest);
>> -	pipe(to_host);
>> +	assert(pipe(to_guest) == 0);
>> +	assert(pipe(to_host) == 0);
> 
> 
> I don't like == 0, prefer ! .
> Also, calling pipe outside assert is preferable, since in theory
> assert can be compiled out.
> Not an issue here but people tend to copy/paste text.

I agree, it's uncomfortable even if I did it.

I'll fix it as you suggested and send it to patch 2.

Thank you!


Warm Regards,

Yunseong Kim


>>  	CPU_ZERO(&cpu_set);
>>  	find_cpus(&first_cpu, &last_cpu);
>> -- 
>> 2.34.1
> 

