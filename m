Return-Path: <linux-kernel+bounces-323910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CC397450D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3325BB24601
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32A31A7040;
	Tue, 10 Sep 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rb7Jvjob"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5019B1AB524
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005147; cv=none; b=nTeDCuQYQSuAW6iDP0+FtO0XvsaKNcMfdNEAE15obOex2Zzxooenu+BA748TUcrIq84UUaGtlYmtetaGg0LjAQh9tYAN7ok0DSwrgbGTXgl2D3wRXYAs6djUAi1dxtBNSGEmg9x+488hdFiO333AAvtzVs00LE0h+vShkK6T3Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005147; c=relaxed/simple;
	bh=o7Tu9mYqHRDbgYmvkBxNamIkhzplwWFRVT9ee/GSxxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrbdKWMCuGMmz7Uu5FlCx2Cij+o+euWrxbrVXR6L5azBSXoA4i2h6jCLPWKf/QqGrne1Gkuf31xO4ruVc8IHK6a2GM0tyK5KnlUhQbf/BsI8dP9gkV5/MYjIjij2lO5siqjgi5MrHAZWkX3+O68gcBes2dK1+9fm3pIJblFgcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rb7Jvjob; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-829f7911eecso359541139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726005144; x=1726609944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=biEgRbHRVhw3nwgyZGGNW3o+GtO6iD/wAg+Ct4J9y1w=;
        b=Rb7JvjobDLEKqNEKDnM9DCCpkAnonV9hYnHRaxKnjTg+P3oXUxrOVakijO5fTzwt5B
         WL7oUmCSTq0gBLiklEaxOMsZuFA0J/eNhjbMsZOA7gXMFq3Rto1tGUQPs5b9WjdXOWoE
         6dTvTdf+sa8/ShYizFrQnp74S7rAy4LmVcTW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726005144; x=1726609944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biEgRbHRVhw3nwgyZGGNW3o+GtO6iD/wAg+Ct4J9y1w=;
        b=Owfx09GiEgK7ajVtzG/dlgSMk9AXoD9Uz4XK0iLi1iz+9TqnaLuNm3zF4/YF+3JC31
         NW6C24unA2RVuKYYIHZIofMN25B/uX8ns6NyRBT8el96XmOJNqVOGTmKiUY5rJ97NEUd
         R6f+mKfWC6a747YP5lqqWAUvV2KoLHrxdSWzAZlyZvlNSj+OHcVkXQm7qUDR8uF9yd2C
         Wh+vNP1A3caQAw4j0QMVMWsoGB0gxup+6dY99mjPvDTpR2wEENJdvkkUDOOtOxmKEjNL
         rnXBAp6Amn66rMeveGyfraxg3YhCoDkYfA36OEGIzp8Et+Nk8nb6zYj1cjnW1a3uq8S3
         /aPg==
X-Forwarded-Encrypted: i=1; AJvYcCUGZoqiG+xK3zxM0ZycxocYpkYJBt8pmYNdk8Vqj7iDSjgTgPwO9gI+wAzI2DiuWmR4dAPemzlTJRGGkFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzueMzMHALzcV1E8dkxB5/kIdojb7qEBfxXPhutdmdsYH5Ye/9J
	me8k2z4USG1VtNnvsguFonPFuSajvF5+cP9IRAAR3Rg0NNqBKjoWVSbcfoCCeXg=
X-Google-Smtp-Source: AGHT+IGJ5zHUhuJP1QGNcsOVIZgc07CdIrjuzckmsmXc99S/dy+ed6BTmnTwBL9Ks7USOrCpKnsE9g==
X-Received: by 2002:a05:6e02:198b:b0:3a0:468c:8e2c with SMTP id e9e14a558f8ab-3a0524a1ca8mr163016615ab.24.1726005144238;
        Tue, 10 Sep 2024 14:52:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d09464b955sm1807894173.135.2024.09.10.14.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 14:52:23 -0700 (PDT)
Message-ID: <ac0c439f-86fe-467d-95c4-b4e9e294010f@linuxfoundation.org>
Date: Tue, 10 Sep 2024 15:52:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/186] 5.10.226-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910092554.645718780@linuxfoundation.org>
 <39d69408-b8aa-4829-b85d-ecae4fa8f97e@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <39d69408-b8aa-4829-b85d-ecae4fa8f97e@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/10/24 15:26, Shuah Khan wrote:
> On 9/10/24 03:31, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.10.226 release.
>> There are 186 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.226-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
> 
>>
>> Guillaume Stols <gstols@baylibre.com>
>>      iio: adc: ad7606: remove frstdata check for serial mode
>>
> 
> 
> Kernel: arch/x86/boot/bzImage is ready  (#210)
> ERROR: modpost: module ad7606_par uses symbol ad7606_reset from namespace IIO_AD7606, but does not import it.
> make[1]: *** [scripts/Makefile.modpost:123: modules-only.symvers] Error 1
> make[1]: *** Deleting file 'modules-only.symvers'
> make: *** [Makefile:1759: modules] Error 2
> 
> Same problem. I am building with this commit now and I will
> update you what happens.
> 

Not so easy. Removing this commit gives me the following error.
  
drivers/iio/adc/ad7606_par.c: In function ‘ad7606_par16_read_block’:
drivers/iio/adc/ad7606_par.c:40:25: error: implicit declaration of function ‘ad7606_reset’; did you mean ‘ad7606_probe’? [-Werror=implicit-function-declaration]
    40 |                         ad7606_reset(st);
       |                         ^~~~~~~~~~~~

thanks,
-- Shuah

