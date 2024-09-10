Return-Path: <linux-kernel+bounces-323895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC249744C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAECF2885AB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC631AB52C;
	Tue, 10 Sep 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QI9mEU86"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A41AB512
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726003587; cv=none; b=MxCaNeS40bxlfyJtWaGpVFQRCm5mVMD0kTk4PF5whtAZ7S9hhWdNGxnrYCul7av3ebiTSubNy60L29bUhB5PTJWk1FyAGPzp7rFRerkzWFGGZPZV5JtbpJqb19DYMptUhmiX4W0JKHHfo7tvVr9q7I5YERX0aznkAdxuXsPEAb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726003587; c=relaxed/simple;
	bh=+l5e/LnCdd8IAh9budhJNcJYEEVRB02TloD3Js8eMos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kc8hcPqxMKv3/lyds1wfhqCsSrmVjLI7ctJl+gAuoUD1qkQW6XsKbLoTC9n6TVtCajo0Q10N7m8t4x5qYpdmQDrwqpsJ06QMNPsGjTuOAoeMHtGZMBjsM/2oRqI2Z5wMqgL8Y7ECLQL+3LJNQT0umi0StEu6+UTGSl2Bx1Rbhjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QI9mEU86; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82d07f32eeaso40271239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726003585; x=1726608385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IrdxYdiIzLneY1PQkxD+9Iq8WHqwfU8Dic2mnpV1UZs=;
        b=QI9mEU86JsAf+su16Lr+xMPDeRwIqDlGxM7TE6DtDEcdAf1QMjon16MrqiM8oTPK8O
         D6onP2nxrZhtlbqaBUumy77uAsQ77W44hGqEBi5NBiq8Ye4rbRC5acq//r7vJ25yVxVN
         B4jYlPUDIfIo9emHkVMK1F3E5DY7ymfpmmZlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726003585; x=1726608385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrdxYdiIzLneY1PQkxD+9Iq8WHqwfU8Dic2mnpV1UZs=;
        b=M9SfAC00ndXp0yMAk2UDD1TefsXpey5cGp7f4KfWDscvfddWrC2rIdAYK6f81RpdjH
         6IL6rK1wLfBPq9rvQ0NbzYO10QHuEkLBXw+DdckLuw23S5GZW/wkuD6vS7AsfX9OnFOR
         zci+5R4jL/2MKFNdF4XEzYg5CyrKKqpiZB5luj6Q2xYNWYFhjOsPqhRxqUMYAt3HI53/
         LzpHIA85BldmHeGrlMokA3ex5BIlsuwxhCgEEu7giUsIV4cJDXqafWVFO6X3gctwKiiy
         R3kPgWByhc7UkRJckdTkq+/X/PYHEQPV/nU8HsypZrSY9yQdqkI5Jc4g5AjF6/hx8iLi
         IFCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFlT2v4OrI+hFhdzMjkqw/Vav0/13hu3ShphQkljfHPQshK2JdJ/qm8qu1W84mmpAv10hlLWU9v24U/t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTsn3aHR0c5dSOBDPvjdUXlmGpeit2AuFT5nk898dStZ2dflPf
	HaLAsv9oRajRD7Ine7qgKH4lRIU6WEWo1QEOz1iPWr1+RR9E0uCyKGSBfth54NU=
X-Google-Smtp-Source: AGHT+IFGQhVronEsKZ13uyaupXrkLsl0LHSmfNr4fnx1sTDUtu261DIXqt77yBBw8Aew2oRg2s871g==
X-Received: by 2002:a05:6602:13d2:b0:803:cc64:e0bf with SMTP id ca18e2360f4ac-82a96172f24mr2867103439f.2.1726003584725;
        Tue, 10 Sep 2024 14:26:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d09462f370sm1824691173.119.2024.09.10.14.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 14:26:24 -0700 (PDT)
Message-ID: <39d69408-b8aa-4829-b85d-ecae4fa8f97e@linuxfoundation.org>
Date: Tue, 10 Sep 2024 15:26:23 -0600
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
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910092554.645718780@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 03:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.226 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.226-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

> 
> Guillaume Stols <gstols@baylibre.com>
>      iio: adc: ad7606: remove frstdata check for serial mode
> 


Kernel: arch/x86/boot/bzImage is ready  (#210)
ERROR: modpost: module ad7606_par uses symbol ad7606_reset from namespace IIO_AD7606, but does not import it.
make[1]: *** [scripts/Makefile.modpost:123: modules-only.symvers] Error 1
make[1]: *** Deleting file 'modules-only.symvers'
make: *** [Makefile:1759: modules] Error 2

Same problem. I am building with this commit now and I will
update you what happens.

thanks,
-- Shuah

