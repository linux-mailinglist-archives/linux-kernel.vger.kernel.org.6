Return-Path: <linux-kernel+bounces-549253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8E2A54FAC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62A2188C9B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C341FDE37;
	Thu,  6 Mar 2025 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z5Xnn6Bn"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60750148FF5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276432; cv=none; b=UTzvL4yqg5haaLNyyHyOIh7OQrWPrZlRiqDoZv9zMK3eeJycNB0UW42hoeZ9YDgvWZRkWMG2Qda7Wk/n+weoJ28jvotYcLWTji+BcnwXDhkNoAUQ+RjIteIykRK4D4zHPmJy72amZp+dLr3WvpbGljBu2qgzLdOtFzrJP8ON3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276432; c=relaxed/simple;
	bh=9xApzznU9zToGpRvOyi0B+B9DLKySsAQzusSYJseRe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSMs34BxNHUX7MhkyXFj6yfa5YzdoVmJPu80zAWXpIb7ub/TZTC1zRtsacHDF/hB22HGpCV9MRSVTiK+XhwHjT0Z/cW0U4hr9odls0CzL0SiFP899+P9KvbED6KFHKjnzNChoW7ejM/7VvQQFv5eb8a7f/hRO4rtoMWxZYSNBS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z5Xnn6Bn; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85ad9632156so62066739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741276429; x=1741881229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UGVbwjHGlVQWxl/m59u6FqTt/mVrEMBYDWttRsZVfrg=;
        b=Z5Xnn6BnI85L8JouaY73Qe9pU/dTgAaaAvEgTGyJitZNvK0ciuyChxcpQYmb16TQFA
         SffLqlJ0DCbcCzHNnvFEOn1BI5R+1x52L/tKzo4jFFwVb8bSvh4fgpRyFZt2mcaHfrVp
         ztgVCXv6Icqawfc2nIVwjiQOTt1D/04B2smTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276429; x=1741881229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGVbwjHGlVQWxl/m59u6FqTt/mVrEMBYDWttRsZVfrg=;
        b=iZVxp7lfkZycaDj59FaBz/SzpqKFjBMelFvNNnz8SxX3z+zUyggBcYIfyvKYgDsLpI
         PVpux0asKxjcgDfOiQjGGyaMWGTIjZOwTCG6XQZ6Tj16y4hTP8ItjJzDODDRLMoL9Z4g
         r8+pAIvgqN72SKAmjR11pF/p0xDom8JSSZaSpFi/vU5nZ9nrttnWU1XyaTlf0MzcHeD5
         oiH1HgTwlmX3GxU+JExTvsgtVz790Qr5Pia6ehDCZI5K2zmCjtzfruxOuNFzFbJe3Cyh
         QkcZKK0ZlR46YJJNmn7JyjG0g2K/4qkOjA1bitfE3EyjD/afAJ7PnOsHeJX2xNxF/zcn
         4gGw==
X-Forwarded-Encrypted: i=1; AJvYcCXnJCfJ+68nBGSBNc5DqjzX/zTahG+MHr6vhw6RUtjYPBD0cv4EniQM5Lg8+5qDuJ/TUHTSqo5iv1Um+wE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9iyqd+nW75jFvUzrFvh8Rr1DxnTgjHQwrT+vGOCNM+/T+7wcE
	dq0MvLatAxuBtgzcjAQigwC+cPS+DH9GzZsH7K4cF8z/wish0a8I5SM3WWXnBmM=
X-Gm-Gg: ASbGncuoPpKUQonSLtHJYwszB6gv3zlJMQR94RyrkI9WIX7fk+4HYTNEEfDM+AYGLZp
	8mBawFrMuUHlR4fqLwbGKGndoBuluYfqOAO9a9hS+0lWjPBppm8nrpyFxYFOCs4uxuR+Zr22CaF
	rubH7S0rUTAthfkiceJoo/Vl7HqCG+2fAzniIhtGONXdon+9UwvqRBJnrEfyXmx38Y+4uxXMw6i
	DXHDLU0sHi0CVaxcvnIWNBKjJ4xct+kj2ctLutEmQpBuInxnidNxtl4PFK6jSfCDVT9DPc0FLv9
	vD4+2GAPEoudJrM1xiwhEJsjQU4iUIKNIABhvk0sx4XprBfcLxB3eFk=
X-Google-Smtp-Source: AGHT+IGNfRM6WfvPSmrxwPJSCIIkYyc3wCyGQxjF8B+uwVak9ijJZWpq0YOE6Njzt4Xig2A+t7QPUQ==
X-Received: by 2002:a05:6602:750d:b0:855:2bc8:69df with SMTP id ca18e2360f4ac-85affb86847mr1088552639f.14.1741276429490;
        Thu, 06 Mar 2025 07:53:49 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209e1569dsm400620173.30.2025.03.06.07.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 07:53:49 -0800 (PST)
Message-ID: <0c017b9f-0bc7-4826-89bc-70b9b9d38d4f@linuxfoundation.org>
Date: Thu, 6 Mar 2025 08:53:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/157] 6.13.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250305174505.268725418@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 10:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.6 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
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

