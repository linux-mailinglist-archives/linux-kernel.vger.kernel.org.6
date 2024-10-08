Return-Path: <linux-kernel+bounces-355943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBA399597F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AE41C21CF0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5701F215025;
	Tue,  8 Oct 2024 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RPun93I+"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6FD216446
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424753; cv=none; b=T7VUdvWXLuPHBU/CCzi/Cy4CHC1EZYZaxNBIPXSJPUcj0dBuA6lJk7UtDG8DNvqnfUqoFeN1q4Kgm1z3bM+u57usvuBwtJ1OOf5trWrxq9aRXK4Nur33q9MD0KNBsb3EOBjD7BgM1Ic2iXf8+mYJx+ydKogKZIVWMkyj/YpiyXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424753; c=relaxed/simple;
	bh=uQ/KpIk0W+YBt9/OgdauzL55cI4XSv1lQND1Cb7MKwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmVOY5zFW6Xal+bslULuVizi6lqwUy3tYYrQiPV/KIgzVkXT3+uDH4+ZPEV1XphtJNWZxnUYxSiOyqFNLwLBTx4z1q2EvckLhnB3Yg5W6s+YkjyczKbHU2Q8aaIe5mN/SRiCS8W2c+Kus3/tKLacc6tOcsg4B0Jmsr50gIv1SwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RPun93I+; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a27638f868so25210105ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 14:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728424751; x=1729029551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJx+qK9x7CGLsACm3HeKgqtf2MT9KIQffopF3Jz5VWs=;
        b=RPun93I+zs51ZvOgwhWop7mE3le8BNuzUucLdEWb+OLy2Oucy7Sm4+GVBlI9D9zy5E
         sSthZ12DXn47DiuAJKua51jfFV5611JNxe+cLJLOVR90ypXhIc1BXfKk5DNbK/m3HUzF
         ihRX44BhR7YehYhSxnkVVrrNNcHQP6Y3FFqQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728424751; x=1729029551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJx+qK9x7CGLsACm3HeKgqtf2MT9KIQffopF3Jz5VWs=;
        b=sTNSKEuuHZcq71a8ICAq0XTdC452o+r225iRCx808J7RsaN7kwRBdzItjde9iJebZi
         nQtRbEIkoSeZQFpZA2PRRlyGZ5Rx+nFZzfcpC/aU65pF85aOBLbNULwDoaId+loUPkm6
         lKUy8RCW+oeTUunOFJHIHejQD9A86NbaURluSRWtpkzUQfWpmC7gj2ePHdIspJUR2EDP
         zJNKMuxsCHCv/l3nfdRlAgSnxaonBRBbABKOH75EFtR5qrBpBL+HYd7QGc6CUiNQY39c
         kUQ8yi0PpuSOZ+kYyEbXtTr3Dyqow70aXxPFSarcwIEPdLHf1mL2Im2L4dJ/zyGz9RWy
         jiQg==
X-Forwarded-Encrypted: i=1; AJvYcCWGWoducOSeb2piNHzlgEusF1i3XiO5K8DS+2WJciyjPj0kT7WqizZvhCG49UZbFfW6GzO83kdcBXquHho=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz35sxuHWzlBz0WDGzSC25kC57cZhURDR55iCy4p/JvxeISM3w
	U65HM9UtVtQxJbCBcDLJCRTWHBH8gYdz3FENxXXxoN6MsRu+bTC6aQBiGg4XSDY=
X-Google-Smtp-Source: AGHT+IGLgxzcQdWZneVSWhW62HZHmsGOqji8cjnJIuTkoYxB/qoiwZjKFfT5jisQmK/UwSTC82IpeQ==
X-Received: by 2002:a92:cd83:0:b0:3a2:74f8:675d with SMTP id e9e14a558f8ab-3a397d19ce9mr4507215ab.20.1728424751454;
        Tue, 08 Oct 2024 14:59:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6ec4f62dsm1816011173.156.2024.10.08.14.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 14:59:11 -0700 (PDT)
Message-ID: <2efe3fc4-e860-49ba-aeb9-383bd3257a90@linuxfoundation.org>
Date: Tue, 8 Oct 2024 15:59:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/386] 6.6.55-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 06:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.55 release.
> There are 386 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.55-rc1.gz
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

