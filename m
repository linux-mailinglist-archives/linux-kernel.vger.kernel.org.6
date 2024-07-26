Return-Path: <linux-kernel+bounces-263516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAA393D71E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 286C9B23EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0771117A581;
	Fri, 26 Jul 2024 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R25yLhEK"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE18E17C20D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722012024; cv=none; b=gBreqUGDIbGnix5nqxKIDNqIF7bU47kVI/6ACgMGiXcND1jBtJSFPmc/+pNnfyyStrbI98WuBHhDMiUTb8QFFVJ0Ng1gBZKhCaOH/NrAW6eDtcfr9Tge70Lj/LUYfeoQG6tdXCCLL/93PLNI/OKF+/k6cuAJ/XIO09e0YZKtsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722012024; c=relaxed/simple;
	bh=YFkHJmgMoHj+m0y0ahZe+tVJx9yx6DTmVWfvugjJLTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZtXvK77HsZ3FGTommhrpFPN6mr3QVdOj/hWxzE+pvbw/g5MTgNiZZVmfZaJmywL0A+AnSdCRanc6Vjbg1FMXbgSGjnJ1oF0xl12jukBe8zrQY/tkTy8TXSzv/rWmnDB7FoLZXRkgDT8GGfUAgn3MLFIrmNQc4iiQfgArsdD9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R25yLhEK; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81f902e94e6so4455139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722012022; x=1722616822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdeqIp1amBwYh9X1rRkUL9HFaDcjtUcMUkWTNmSG1HQ=;
        b=R25yLhEKQtJvrlEoET7ks7ttJHWboe6iY4OwXH/dLKHgYh56ZgbKeOgBa0G9P1WOG7
         tDdenBNJmkWYDnFv5AGr5I9E0ujzmllqaqEQEyFlSI7n3HYzW1szErabx9eVIRWoH5Uh
         /zJGrqdKB+0civGtBVsuBLTrHgGVBkGp40DXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722012022; x=1722616822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdeqIp1amBwYh9X1rRkUL9HFaDcjtUcMUkWTNmSG1HQ=;
        b=MD8KP110XT1q8zjUAg2ew6UU2bmWGZJb0lmGt2XTmHsRVXwjduYHW1c/mfgjCwQGTd
         EGFOD1JamRhy2d6tzdLNm7Nx+LIiwojgOPKNCWeqVPyy7pSeVqDr3gICp9J6wg8shJF+
         KgYwQ9+5TQsizA3WhwYmleBlx5O+/GXI9FmL7QaVsmjLqAh8AbXiUplAt/B+T2q991IF
         JInVSTCmXB7rgiyVHo+d9UZ0qdlPqez3jEZmAQ9wGNt36ZbZyFOtRNBbukELEqJeLcuq
         t853aNlWJpUv2d9hvZbpLsX3Fxg4trCwkYgRY9JmfxbXPGAm4Z+blM/LfTS3Y6DzcQlg
         a1IA==
X-Forwarded-Encrypted: i=1; AJvYcCWvpDD+izl8jwjFn0urNfU0j/8zr6GZbpRLubNUwb3hdbOQKnmxplrSAFXPSYKQBmtpQqhbdB/aE/56E4b5x9pQpASkTIoWnepjad06
X-Gm-Message-State: AOJu0Yy+fiwUOLqK/mO4pXqtqGFCQrI0wfgUnBBhKq+PIvGMl1GM4LdH
	K3j8uxII94u1Y+t9kzh7MH5ZkYra+Erk9RKLqHUO8BR5VCtBujE1SVvRqrp8HDM=
X-Google-Smtp-Source: AGHT+IEVTuMiNnfHYyl+FJNl81Dbpul+4YdQEdWL60VJeEzpubbsWkDjTyXJMssUsftU8oZSnDHKrg==
X-Received: by 2002:a05:6e02:1aa4:b0:396:94f3:a9de with SMTP id e9e14a558f8ab-39a22d465d2mr48021365ab.5.1722012021928;
        Fri, 26 Jul 2024 09:40:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22e976besm15575205ab.31.2024.07.26.09.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 09:40:21 -0700 (PDT)
Message-ID: <642ef95a-62bf-4a4e-922d-91249d3b8ddb@linuxfoundation.org>
Date: Fri, 26 Jul 2024 10:40:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/43] 5.4.281-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240725142730.471190017@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725142730.471190017@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 08:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.281 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.281-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

