Return-Path: <linux-kernel+bounces-255374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7B2933FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2F71C21509
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F283181BBA;
	Wed, 17 Jul 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W7fer3mC"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7BF181BB9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231038; cv=none; b=pFx0JxlV/xOg07PAVXrslp/vl+XW/HvUKiEIAbGwl9dBMTOEefsr+ksK6bNrc4TnzhoCxyKBzt5na6psmJpCzApkAu8nFtCufp/J/znFnzR94lk0+TzL0XzclvAsZ0OIwCNRwUFvX9/oxKzNoMbWiWTsBAONRaJY5wXiTUWsVm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231038; c=relaxed/simple;
	bh=wb1LYv4A0acrrEtIIC/SAaWQ8u2gOiMpH/PnqcW8a6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaG7nJLHd6C7MI1xtG4mNPubYUYJfzd0ddSiiObLn3JWPjOPNTj4+Ckb2LzH6Fy6/0vKDQP2xu5GxvMmT6DPNMuG9dNc7063/B0pIzguoB25JhRw3tDaSWKFmTd/k9q46JrbK7GlkAavy7o/AP329yaAK4WSgnww9zzSMa9EVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W7fer3mC; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7f3c804daf7so4926939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721231036; x=1721835836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhC5AUh0nXY2Z/jAhnsZPgn+TyMTEjILQNMnkrHVTOg=;
        b=W7fer3mCYnFwJLWVm5x0l6nS3QdyVyK/6U2yH0K+IjpAJXtRhKwqaCjN9MrKaBuFsl
         7hLAzQlfSICcm38X/zKxLzRbjB7nzxumvK4GRfcpQFxLnCKMYhHzC+VeCmmEm1f6sgIy
         NxnYqrWpqFDfuHuV0nFKjCBfMKPJzenHJifuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721231036; x=1721835836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhC5AUh0nXY2Z/jAhnsZPgn+TyMTEjILQNMnkrHVTOg=;
        b=YdoeV+VYh+cTXc1LJKr1uW49schrf2zOmJCl2vdli6+mWldJV3lXBZNQ/qkCcLimcc
         93TPy8LpkOjrK8xyqvippj9QpH/tTZ9K5zS1sv9/GKfcO8m9RWu3JGhekM5myKA4lOWa
         Hwqv5MfD+uU7nffrbFDr5dqBR2Wj71Kk2PedxXBT+If+EIwrqM/3IQCdccfrKytAp0rd
         vQ1/j8TLLWtd0FkqhrirsjkMgXqGCrWq5hTRgQFJD3hnWndtmutLMqrTKL74VGmGhhG4
         ruCxHtpHRO2tUY+8cBbp4NiMz2rYfdRY4nlXYdQVlQ85nkbLDbXelMZD/InREIWyoDg/
         F8fA==
X-Forwarded-Encrypted: i=1; AJvYcCU44QKzmDWcJvQH3ok/lsDsjwsjVf0vTrFHNH+pYDvSbYwwoR31FuPSsyZ9h6ry0C1majTSWYX4rbooipEOZ9E17k/JNPQPimnDlXGX
X-Gm-Message-State: AOJu0YyjM4qxnmAk+mtRmIUYNEu8VxgMoZ9z9NIzcgiZmFERcWOzjzLf
	gVO36cUmWszhWkl+04E/K4+9pbbhgPMmA4A+znCBwL9pThhMMtytyu64eA8Gfgg=
X-Google-Smtp-Source: AGHT+IHZXl0hg8iG9vIuc9XxlrCQtDPuT6ZziCdBXxjOkrQv2c9JNy1ocmAplgM+FJOKVBGMYPOa/A==
X-Received: by 2002:a6b:ed13:0:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-81711e195e9mr149045339f.2.1721231036378;
        Wed, 17 Jul 2024 08:43:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-816c17c4e40sm69814039f.12.2024.07.17.08.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 08:43:56 -0700 (PDT)
Message-ID: <a00b55c7-9491-4e63-add7-7f0f8649ae3d@linuxfoundation.org>
Date: Wed, 17 Jul 2024 09:43:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/121] 6.6.41-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240716152751.312512071@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240716152751.312512071@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 09:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.41 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.41-rc1.gz
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

