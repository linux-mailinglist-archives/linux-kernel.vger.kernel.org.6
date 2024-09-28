Return-Path: <linux-kernel+bounces-342593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82DD9890B2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5791F214D7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C75225D4;
	Sat, 28 Sep 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BmXL/04n"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F875381A
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727543704; cv=none; b=k3PvP5wx8SdDfz+D338pA4xNxArx7EWvvU1hZhjXJSwquN6SCiSoV9yMjcU/vKAmnuG6OQNOtP1dZJMrR5rqw0kvhlTnV0NvJso1kvHktxLSXvLd6fz2e+c2gMXAcbeEHCX//ElMqhd0a9D0EJxP5bHHianOcnbCk0xhT0waL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727543704; c=relaxed/simple;
	bh=Pu1ra73KdXyUjtcpFItrE1RBN62ZbzDM6xOG1WA02fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cO3nuOJcvoIDL8f6Ja4rCeDuS7jf10neWPT2V0iHrXYoOaOGzvF3JEGxO9UCDhDkmWKPDN7Q13lY8AZjY22jqL+71U9/lrXkRx7CFPh4a5pSLAvqKWsW3xlC3Q0xI3jhKFDcLzNP2ITMn8Jkzwrvard8NR+R/Hx0UW2ZXjAFfbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BmXL/04n; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8324124a172so158410139f.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727543702; x=1728148502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxGPjaFWUVuygqvE5pSQf6l07eOds48beRCBcUthdV0=;
        b=BmXL/04nm/ikEppVxEoOvnzpEafxBZ1w6umeeojTCd2RD4r0+fwWVY713csccXCwpP
         YbL9Yf/Lr0g491yzYBLwfDZZ95IzNyaZfP+VgoryW9kvl0DhT/kbU9ImyvqfM9me5zlS
         Nuvo85TDltP2wTFpHO2GIPiV8sY9mYBxtd6Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727543702; x=1728148502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxGPjaFWUVuygqvE5pSQf6l07eOds48beRCBcUthdV0=;
        b=UePQYOT1D+skCkblKGEROlPn8913Z1fcPM36OKAj0+42OCq07ASOzneWKxvqFDIHDK
         NPJNRixctHHgf7SlD5SGf1wBy5inPlDuUFkXO1OuZ7nd0tFFnr/RvGCS19JYceVaXr4f
         OcogyS+HZa3Ydzs4gEautWicSMwbh6F8LbEWPE7G4hcJELFJpr0I9PLNqfXvwphSBxOw
         2+lVQZC/GZ8ERxyp02aRYft/M99+iasTtNp/l3Wly8XL1RzMZm3XOydeFzS3K9lF3lwL
         OJUrHriRTZdbF7YWkuHeuSouzAC3mRcm1qNWvVFhzyroSG0aa9D/OoAs0+6tcBsmDYIi
         XJFg==
X-Forwarded-Encrypted: i=1; AJvYcCV3XuqJZ1RVBcPHBHuQJZXMfOHfBpZVMhL4UyWW+SO5Ae6JY0ayzvJGNf2gtey7t7hSETD568opCng53As=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ46qke7x/guuXIXoUTtXIbaRIJWF5hjjCIMHzRVJkeCggC7ye
	JSwTKUXHnY1MuB5HKDC2rqFNg6CU96111tEdAEzBlOilWBPUfCp4lxS0p+MpStY=
X-Google-Smtp-Source: AGHT+IENEVcL0X5iIGC/9WTT4qo+F5n851jEdlV2hj5sxqNpjLyeGAHMYcoxghnlDVw8QhJIX+ePIg==
X-Received: by 2002:a05:6e02:1fcd:b0:39d:1ca5:3904 with SMTP id e9e14a558f8ab-3a34517f9bbmr51119825ab.14.1727543702425;
        Sat, 28 Sep 2024 10:15:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888d9b33sm1178093173.141.2024.09.28.10.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 10:15:01 -0700 (PDT)
Message-ID: <2189dd09-25f3-4b3a-a799-44626765643d@linuxfoundation.org>
Date: Sat, 28 Sep 2024 11:15:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 00/12] 6.11.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240927121715.213013166@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240927121715.213013166@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 06:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.1 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
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

