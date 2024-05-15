Return-Path: <linux-kernel+bounces-180044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE5A8C693D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8DC1C216D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A1615574C;
	Wed, 15 May 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S4nuTNKJ"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F415572C
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785617; cv=none; b=grE3UPG5L4Wiki2RNh6KwYB9n7ELHKyGrG/+hceU79a9kI7zHGIhHgiCs+Ash5HcnUagc24K31Cuobo/RH9oBrcD+Nol6KGPD1EuhBFxuukSDrAzr1FmMNGJ15fpjYBPc58bB4y0GzbfQSRwQ92Bo/qpHtFmc8oix66fJnbAfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785617; c=relaxed/simple;
	bh=RIAoqjM14Fu2GXpQuniUrr5udioxLXnLSlEc1B8cx3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owhF+Py53WkYIK4eAOfUkSRpHE3RPJcqR7y2ptxo/tlhTUI/btpxhBtH+DCpwEpUergGewv9MYts1rs1swGA3YhXyWxrz3/EwyQaisMsy7B3rtU7O/wvdcgpwsET/ZxNwEjVpH5k8pHXEZ/BdV3guYFVhEDvvVfn52rC5tYxhW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S4nuTNKJ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e1b8606bfdso39666639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715785615; x=1716390415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcYN10FfDn14US5p3x/TxdGIIki13NwqcWmNX431Yx8=;
        b=S4nuTNKJPVHEdwgJr6WwWEJ3KsTAnCEjAfbJB5fHQsEnwzvgUY++Nf943JGEXq8AdD
         H9pm/n1JpmNvM0WUBooUZ1jM2s1w6KGMwuxUvuo/gs4vq3HJKkpj4WKblDNm3G6EKVYz
         gyHOFzhPfYViv0+0KRKRJ2eRVUGOJbR3IVGJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785615; x=1716390415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcYN10FfDn14US5p3x/TxdGIIki13NwqcWmNX431Yx8=;
        b=q1AQFFmcKDzVRe6Ks7TMiOsOaRvnjZQRsi5C7AzRq6ly1FVAPb1EVAYbcEmKh16Arp
         J/Supbb/ZmeGsd5+HbANDPXofIYyY20J5FX6dc5cB9p8VuLZW1g0TQBee2h4pVPHDsdg
         gQwcV8xxEsaDLoLN1zZdlMo7H5U/4kUa/1RdGiqgEa2RL9UiV+Iugij07NlaNGZml0dg
         Zs4unWKRHW+BB0r7mre0Hka0Hym3b7XiWq8ijcewnY0gSRs8u4/jhwJTDqWppBUH9Yvm
         HP2RRczhoBmEwjnFwfU/mOUWPE2YGF/lFofPF5DSTmvzw3h8hwcH25HXtNMlS0lcyNEt
         jO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXwxG1/UQGBFDnpfrOR4aArWu7bNFFfIcCKiW+8aZHTJYBVgBcSceEizBIDdhtqUKqg3uATZUVVQ2RsC/tCU9zZAQqLwpu8jnOoFyr
X-Gm-Message-State: AOJu0YzAU95GFc1FrB8RszZ3Qu6F4vJz6rO3R/6pcH+L9xV0KbwZbB6J
	KNM8JTG7UDMUhWjJX2CtSWfXwg8cZhyrufOFqLrQTnNDv2mIplehtddq7Lqei+k=
X-Google-Smtp-Source: AGHT+IHswPwsFnweSMcvLm+AWWS2t1fafeIrDiKAyKpwgDgiLQqvE94t9I8Os3WbhkkDOZrFGH3Ucw==
X-Received: by 2002:a92:cb0f:0:b0:36c:532c:d088 with SMTP id e9e14a558f8ab-36cc1391118mr158636705ab.0.1715785615724;
        Wed, 15 May 2024 08:06:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4893700e469sm3634804173.30.2024.05.15.08.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 08:06:55 -0700 (PDT)
Message-ID: <97dec171-048e-44c2-bf19-7d1a1c8694d3@linuxfoundation.org>
Date: Wed, 15 May 2024 09:06:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/301] 6.6.31-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/24 04:14, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.31 release.
> There are 301 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.31-rc1.gz
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


