Return-Path: <linux-kernel+bounces-263499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC78393D6ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D4F2B21E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E21117B422;
	Fri, 26 Jul 2024 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="etxqPV1D"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD17749C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011567; cv=none; b=BVbLzYfbb0Xw73rU8HX0iNjDF4Rc7W9IN8KOa5Mus5LPju2u+crVGJDUtTNfIZKONTd0iPOE9IRylIX6ZAlDb97xiojnIB1jhVSQtyReLItYDdErSd7u+r8+PVr6M7gbKF3wDZZV49bX6gXP33rd+do85WcBvjreI23JWNU7oAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011567; c=relaxed/simple;
	bh=ed1/+nHimax7MGh6USmjQcKvgNVvRIPcXa/dhQA9IPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tV0LaMrMiYVaCTLRgvKYBzSZSRAy0ny2BGPajVLPIzdUVUJ6tEhddFQJFkhPehxQMWTcoQx9h3T/cwAERVqXpI0KJ11JlXHP4Uf/DE+SZLewl+MX+NjUCcd2XHgKCpX4oVi8Wjp63KruJRipYnFR7tLvCR/gYgfsBGpZR8BscKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=etxqPV1D; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-81f82478b70so9352039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722011565; x=1722616365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RGwGXtXruvQ2qv2v/M8Q6U39N2aLr8llneA3JpvprU=;
        b=etxqPV1DAUgJaakTdXnHUu8aXlF6t7F69wp32Yy0SoEpGv/jQ1yUwdBzatxbvcr0TH
         V+haNpXR0D6kYiLg9iuW2cR9Q+TjXslGhyXn0kfvKY60Izn0Gq8+xM/GbAPySx4BeYG0
         PP5TZ71fRdHBFu4/6Gyke5i+ZllWrpMZ320dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011565; x=1722616365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RGwGXtXruvQ2qv2v/M8Q6U39N2aLr8llneA3JpvprU=;
        b=tD/xu547h6kbvCTqS7WqtEPSCS66nfOSarpdACEewgLtHGLBRRA8UELgzH9eKq4+h5
         /s5yU7exa2UFj3gthh0p3l/G4eacrrMkWrqwrz8Gp1YAdUwSFos3qRcMOZfY33lwRNxQ
         hLD/Irhy0/fnahILwFQvSGz5RG7PfFiY51sFHFsN57o9b+87V0wjYMj2c6NZ+yp+n7XR
         kcdrQXVgJFqC0UC5frkSI+h8hWvehzIfnemg5oSQMvITu7rPXq2HduSohwtR3mo14EC4
         x4+UxamIgaa7qBmsmw2MddR0JTJ2q9hiAAEOlxYbxjmcLcsfYCjIdHJUJeFdZYUTpCMS
         vUZA==
X-Forwarded-Encrypted: i=1; AJvYcCV0FEthqdULqd8+KYx53okS3qeP90K2FFi7hzf68INZBEOZmZOU0DS6zbYpqe6osZjDnY0E0wtEIIBf9VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyikaOvmduAS4f0BTqKVFnbkc8wUb1GNKv4PcA17ZMVRlTWqGLd
	uEMFWdWeHhAU58ii2jXQkGf6VEO2buFmawVUnxumFSEqqnervbgzA+Xfq51vOlY=
X-Google-Smtp-Source: AGHT+IG8b7Js40aTaFO3hbThVtKuYG3udcm+PJksP1inMm10ONWrLluUG9TMFNN1qq3nSaJBQDEedQ==
X-Received: by 2002:a5e:8342:0:b0:81f:8f3a:5689 with SMTP id ca18e2360f4ac-81f8f3a5894mr132159539f.0.1722011565323;
        Fri, 26 Jul 2024 09:32:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fa3a36bsm905632173.2.2024.07.26.09.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 09:32:45 -0700 (PDT)
Message-ID: <7426c52c-5c00-4305-b959-db57b4030691@linuxfoundation.org>
Date: Fri, 26 Jul 2024 10:32:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/16] 6.6.43-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240725142728.905379352@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725142728.905379352@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 08:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.43 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.43-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

