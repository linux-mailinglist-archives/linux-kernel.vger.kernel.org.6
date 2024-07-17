Return-Path: <linux-kernel+bounces-255379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FEE934006
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D25A2B20F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB291802A3;
	Wed, 17 Jul 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M0hpCKu+"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C001E526
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231478; cv=none; b=CpXMLoPlkkeBEqdu8U7N0+16oxPqS8NV0qQd7pI9W5aJV3OpF0P+tvlLErTKjAZEdT2zFTQbDhWeHmo+BMTocaxNq1g49lW8RVUB0dG52lY5miCd40EW9A5Y9plvV5zVP7TWKju7p+BUFkggmGCLcb0MDnXqUAe3CoZm1etkvr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231478; c=relaxed/simple;
	bh=RT2E8IgjQ+esWzustcQ79s/43qy/PvDGd2M3admWG6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9uO0BBDTtEj51W0Z3Cw25Dx1nmoY7T9oL4LmRf7AsD3oivxjWCCZZZjmrlN8zqoDSgZl3d6Apu1qye0sklpZbdWDQZpbBybV43ofAX8gJgH6v1151AflZHpbFYVb8lMeTfebiXABXCRONc6AHgsLAq2eqhAdxHtiWwU0LSNVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M0hpCKu+; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7f3c804daf7so4979839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721231475; x=1721836275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jYnYtQtSATBdLSe4GSr9qVfw3Tn84Itp/iiWILaybaM=;
        b=M0hpCKu+Ihj7msdLyUGbaLGGxU1hUq32brJ0RpPwXUvyB5IvCAH9JzrmECqb0rmXCL
         Ra70cSS4Vzx49H3w51G63HY9zf/5f6P0Bexdb+uYO/TrdVY8ZnItlYGNBLShhOHzPjG2
         GM9d8gz4K3ACEY8AfKXIlXCnGOG/ogUsNLOpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721231475; x=1721836275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYnYtQtSATBdLSe4GSr9qVfw3Tn84Itp/iiWILaybaM=;
        b=N9RVYtZPjY1hGD6h6Jki67VLou3YKGCQ+gc6deGHHEfGf4CkJ2X0mm3njsKtRZw5kc
         JWhuuoIU+j3asEKNhz+jhSd2vCkG1dq4hMaExV/YhrTzPLNfW8hX8SZeqf35pJgK37YB
         /H23rgUzaqYk+LgP3g/IWhufuC3IP8GdqNMPzDVoyvh6EWC1J2+B7Rhvf8o76QfuA961
         xRyJgAzPf3e4eWmKuCKzbEF1ac3HWNrYthq8kvX2JvZrxcHV+4K2XDfT6A8V/CSvfqTN
         XwhrLqH5auq9vMohdAvaQKRSw13MVQ6BIbLYanAQxfOrIgwdCZ0MWVslxGBG1v30OW4m
         tuBw==
X-Forwarded-Encrypted: i=1; AJvYcCVj6PW2vFtR09aM6mE6R3TOdePdeGW/bT20pSFnwcgm5nEm+J3nVDJKbGJwtX04Z5Kpm5ogFHjaVMkQgbYJ6L1z1oWBuu9e5/RSzG8B
X-Gm-Message-State: AOJu0YxOjAPcTyGGkJnz33RRf44/R5Qy52xns5P3Zflb1P7b78DsBXJt
	1ZzojQNWQ/Xtp+p8+vNWpv69/EVR+SG4mV2jO3ebeOwLxEiMcYF9OEkaMNAS7nA=
X-Google-Smtp-Source: AGHT+IGbmhAM61xxYTubsIKvFuOrqkQMdiMfd0yDLTqmjOm0hPcVfZqtZOkHALmz0YTX6MxJcCUh5g==
X-Received: by 2002:a05:6e02:1c23:b0:395:fb15:280f with SMTP id e9e14a558f8ab-395fb152a5emr6780115ab.1.1721231475239;
        Wed, 17 Jul 2024 08:51:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3950aee02b7sm8378585ab.5.2024.07.17.08.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 08:51:14 -0700 (PDT)
Message-ID: <7cbd02fa-cc6a-4dd6-bf97-2bc6b5e14646@linuxfoundation.org>
Date: Wed, 17 Jul 2024 09:51:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/96] 6.1.100-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240716152746.516194097@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240716152746.516194097@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 09:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.100 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.100-rc1.gz
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


