Return-Path: <linux-kernel+bounces-269810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4CB943711
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972EC28257A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0728E17579;
	Wed, 31 Jul 2024 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a8h4doNa"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231E3D97F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457505; cv=none; b=KW3zSeAVQ2riwRqOjMsSFJXZCNE7oHvZBln6tUwtHYIPuCq8x1rUruVAvAPZIPAi/Tj13xD2cG9Jgkl4TZcNKAw3+x1z+ZhnbrMp2YFPj0d5Xa0Zy/tJHa/BN8Un7gmEz44sswz0lXmWiSQ735fC1aMZlUZ12au/iHNPTH3kybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457505; c=relaxed/simple;
	bh=5iljddl6Dy1+iqapnBBDqeHgVvb6+kC9EnooWBoaZ+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3giq8sqjiLyJs24BUUctg7jyIA6njcFixBmFOoMaZ/gceTD4ecTRgInNgrjCoFfjib8kV8/yhuT9jMtVLWxojbc22vk7dEdHznaLevvyj4kCG2SytZHBA2eh+if/LdkiuMoD71xdwA69QiaRFkxJomMDoZPF8/IrGqM+W/B7Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a8h4doNa; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-81f8add99b6so29495439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722457502; x=1723062302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qNpsP02VSjKsYtcASUUA6qMfypdvykuyxCt7zWGiFLk=;
        b=a8h4doNatuWmRmGXwjWRvKVJ/3qjjMfFJKweCwHIGVMI/QIC1ccOBfAP6/y7pIRK16
         u5kyTnJkx5sPO414swIiDpbwKtDes2xjH9BGMmQLUfA9CYMQbSk3pW9K4qeoH1OyCRQQ
         k3UiVeqo4ZIkBEgrJLwJozoGwEzmsZ1Oqy4EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722457502; x=1723062302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNpsP02VSjKsYtcASUUA6qMfypdvykuyxCt7zWGiFLk=;
        b=o+uKbdVt93jWD6w5dmQI7G+0xrt6jNr8g2nj6/7eyCPn0cBg1gmwDiQHb27ddFHfA3
         3gytZXzishli1ywbkXYuaEmI05XqZCS6RUoxMMqNBsTTDHoE6LxFpwu6Cjwdp1+jvifl
         Z1t+3vn9RR9ysI8XPVeTy2EPghM0Vyg45FeaR0ZEgcUB1ssOdDMkoFgmnNbRTSjtUb8m
         Nikjn6S4eMRVIKQp44RZcs8mDhH4M/j/0hKB0zVrzbF1OPlzOCFF7qG/wi3hBqLpdQv4
         1e7s5JhliaVJdy6joGLjPNXhZt5ehiFfDHVeTi2pZ7xUWUu50SZ0R1o/6n8vZYIam2eM
         t28g==
X-Forwarded-Encrypted: i=1; AJvYcCUfCAIt7KV8NKFiLU/1kvbFxj1sNDWw9KgFerC+n8ASGFCKk+vaCnEWrEhO/RpYzm6pZWNkdDRhwKbiTgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBumOK8s+aZTmJDM1CWeo3QpukXKYe4olrTPROq0vPoQRlxQFo
	hXYJYO/rgWWRmLK9OSOoGcfhJTWr2PTjm/9xH2C9/K9I0Opx65zLvcQfQnOHP44=
X-Google-Smtp-Source: AGHT+IHizPAHD4S5ZiqFk080B6OLpCMsmkSB9xS6xlQxHULKrSv9bR+UjdoWxv8uUQ1IXUjy0JVfbQ==
X-Received: by 2002:a6b:4f0a:0:b0:81f:8295:fec5 with SMTP id ca18e2360f4ac-81fcc1c1b19mr28919539f.1.1722457502455;
        Wed, 31 Jul 2024 13:25:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fbd9a7asm3352896173.96.2024.07.31.13.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 13:25:02 -0700 (PDT)
Message-ID: <d9fea67f-4871-4b26-8a69-f9a8fca8fb13@linuxfoundation.org>
Date: Wed, 31 Jul 2024 14:25:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240731095022.970699670@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240731095022.970699670@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 04:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.3 release.
> There are 809 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Aug 2024 09:47:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.3-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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

