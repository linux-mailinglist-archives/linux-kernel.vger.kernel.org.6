Return-Path: <linux-kernel+bounces-263502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5F993D6F2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B30E1F24A41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DC117BB2A;
	Fri, 26 Jul 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UlUawq5f"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28850144D0A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011746; cv=none; b=giurLGFQ7kOzCGCUbuAoJxf9l66jbnzOh0xWaEjbVmIK7+eB6RaGCK0MAlXysqSo8sc0W/nqWsA/nf2SyDaw7bTlPKUrjtOcaLEFjwo1jDDn7DfSwwZjwyGjXrnux8BuMkL8+w0h4g7tIwaIYSdXZW4LvktrKXyQfLqvkLcBjHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011746; c=relaxed/simple;
	bh=XY7HymytUjgM+8NWLDU54wb/4FH5oqVN7Nv9uROTHfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rROqFuqjCJ/MM37BbfI3euqz1ETchmQVxPvMDIFkRlcgTtrljcIzKB20C1l9llTVPLc7RRGr2s+BBw8Olq8jURwTZ2SyY4zOFrGdxg5gb5C395DIpfXtIPqnPfxaa4nnTrnbq917pC/2irBfHFHI2GOfa0xJEGtw7IpRPJ+BM58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UlUawq5f; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81f7faff04dso10263339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722011744; x=1722616544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRqdg9zdgOn42cgCu3J2giuAnSl1Epr3+bFdL3aeFPc=;
        b=UlUawq5fSMJbDGnyKBxDlejZwWUNxu6T9uMZ/8g6YRZnbgb9VPlZc46jYRM33m5YVc
         AotmLSYBaBIBTJmIPXXfYBQXpWTQFkW4BlRJZ/qWTHjigDeojVzotbhyy3Xgd8ryIiji
         VzxDnMlZVDF8Ic/pKr3BwpkqABZMsH0wYzJ8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011744; x=1722616544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRqdg9zdgOn42cgCu3J2giuAnSl1Epr3+bFdL3aeFPc=;
        b=DRaXYc0U+rROodEgD0vhYvIywlvuwHFf8abOpfoXq65ZEMzd8/Ln/ZS3uTPgwcxBja
         3crkKaBr4lRwHonRTYxYfxhh8qcC3wRWRULRU9084BqPLWuhtrqZY+mXHHVp2FQZQtrU
         kkUZO2/4RqbTdNlRmbB09OcrIcDWhDOcwPtW1SrKf04cZc8IZhS5kEhQYRG7L0eeT97a
         rP8p2B4SyKh9p8aUa/YEFSOYIeiWLrDuYGLSs7o8Ff7sbrYhE1qlIRgW198ojPuhB8+w
         MYsXIGrS53hahsgqNn/qSqQX3EzkR9251PxAysEA4IoVHVIPnNGa5ee5UJkyiGc6NUnF
         M+RA==
X-Forwarded-Encrypted: i=1; AJvYcCW94qcUWRvkI1d8F5WvWdAz7TnykNY+jsYjlnYtxBqFnrQ9LV5nq72M9bR2FW1jXQ9me4JLdXfFyuJN15TZnTUZ8/AZwlb8QfO6Cvsx
X-Gm-Message-State: AOJu0YwEi+N5d3+KUiEg8TSYWW5v4wjEad+xw/1fpHaXPTPuSykq6r9q
	YZV109eWVx8gVPmnZgs5YPSev0njX59qy8ME0pmlJDAFpoIeYp7bG48q6uFIZw8=
X-Google-Smtp-Source: AGHT+IFeoDN0Drm6gcoPOSZye7+XsJes/VmkzbaVf1yHuzlZYvG68vGemgBrOcVeA30R2sMZKfn+uA==
X-Received: by 2002:a5e:c70c:0:b0:81f:8cd4:2015 with SMTP id ca18e2360f4ac-81f8cd421e5mr185814939f.2.1722011744093;
        Fri, 26 Jul 2024 09:35:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fa3e10esm936807173.10.2024.07.26.09.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 09:35:43 -0700 (PDT)
Message-ID: <bcffbe4c-3eb3-4c36-8d79-a46ffd6a58f3@linuxfoundation.org>
Date: Fri, 26 Jul 2024 10:35:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/13] 6.1.102-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240725142728.029052310@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725142728.029052310@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 08:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.102 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.102-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

