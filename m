Return-Path: <linux-kernel+bounces-411902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1A79D00EB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 22:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B6F2841D2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 21:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD7519AA5D;
	Sat, 16 Nov 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FbMoKkH/"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C0B196C9B
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731791794; cv=none; b=NNgHisMJQz+DZG6TDJb75kn5VY7Rhk6ScLxqfBVpmnKWfk8LFSI4POf/2GXNLRDogq7noma7SmqE1py6JJqrK4ACEFFQePUh1Zl3K8Th+KWXfA4lNR1k1E3PIHOh6SCoC8AUDKFPfBnRP3guLfMVZs1qxYV6AwYTJ/K0Dj7dZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731791794; c=relaxed/simple;
	bh=7PMrz2Zm2mvfKq4nmNSmKHiyobn8/8ri+IZxkljJbyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdJiWUhBOhCj29leDudgqokSe+vjic/8fBpd7OFUWrafiY5YOqIYSf6+YxxMvi1wi56A+fieXJd7Rtz56fchWg/XP5O4L6IdUp1+FEa0i9XtH8cBYlNu3mKWrbzls6r2f4Pa+BmosN4HsaCyP+n5ES+zMDn2q1IEHhv3mhfuYm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FbMoKkH/; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83e190085d7so106300339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 13:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731791792; x=1732396592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ThohtjZ3n9Q8TJFQ3v76IV9uxQamdVqCdT9v1KevZbM=;
        b=FbMoKkH/a9aRxfcuaN0ievBSFgDiaFqZ8zrEv9t62KFof+lI/PaaAA76u4qM5H4h6P
         ELnpEXP8hwKDLL1EIWjNnkalaqakriz2F7/s09t84R/t/kHJjhPnX0hpyOh1RfgY0wIZ
         Ui5z/pfWuT7fLq6B0rNuk6hpzmo2/FL2FnRhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731791792; x=1732396592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThohtjZ3n9Q8TJFQ3v76IV9uxQamdVqCdT9v1KevZbM=;
        b=Lv6VTnZXTF1MURPmoXFyVv5vRSyO5Amplezt1vlIs58IMK8QiWW8uLNmXLu+9XP0D6
         fz5wnmkqk1v498C6O4IEn0gUq4kVmiBWY9Kl5SV5keFdgQ+XxRzw4F6OAat60xhNHyuq
         c457H501ha6M2XpeJSsmZx+CdtpId1vJ12fuDoKgAxnjbejBPmNjXrCalFi+zHXbuXKb
         Vc1W0lJtcd4aZUnz/pQEGXMJ1eEWotCMWD42xnWY24E/7DvikjJHRIMtsUXH+mTRaSmz
         6CCiMyQ3BUluDJ0tIUY/1ePUKbnlNvRiiGP9ZgLCWkWwJ+04sMHtyNvWDi3XYD1gNd4O
         pVow==
X-Forwarded-Encrypted: i=1; AJvYcCU5om9WZlpiT2DjbEiaZfPiKfZQknjdwCJiifa0UFH4kAB6UARhncsl/1xGVeiiBV8gL2WagJU21n7hE6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYEHLAlZLHVeoqD3JIhBXC1LW9SNIGZIyalDG3hfIDZaukqngk
	IJyA7rjzyTpCWa0qOi66fi0bmlq3kLrvhRtuW50vjBHL4KEP0T2Z95JfnkgS5SU=
X-Google-Smtp-Source: AGHT+IELWGMLxig5RgGYIn+TwWmLLm0INc8xcQs14z602A4podqiHLfXde+yVDHHN+PzMatqyRdC6Q==
X-Received: by 2002:a05:6602:6c08:b0:82d:9b0:ecb7 with SMTP id ca18e2360f4ac-83e6c299f59mr878007339f.3.1731791790626;
        Sat, 16 Nov 2024 13:16:30 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d6eacebsm1260708173.25.2024.11.16.13.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 13:16:30 -0800 (PST)
Message-ID: <e143fb80-e6d4-43bd-84f0-14a1bac08df3@linuxfoundation.org>
Date: Sat, 16 Nov 2024 14:16:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/67] 5.4.286-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241115120451.517948500@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241115120451.517948500@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/24 05:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.286 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Nov 2024 12:04:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.286-rc2.gz
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

