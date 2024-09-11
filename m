Return-Path: <linux-kernel+bounces-325225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4CE975671
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124FE288BED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8DA1A3AB7;
	Wed, 11 Sep 2024 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L5SeEiNn"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592AB19CC19
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067306; cv=none; b=qJljSVNY4VgyQaQ5J42D8ZU6oMQdH5vkQ23pw8t+00ZkDh32Ly+5Uprm+YHcPL221seVS2oOTU2JCt7tBZ05Tcgzk50pmc8fQlLC38Pbml5mYmg2L4V/exujFMczgCGM0dJtFZVxk3zN8khnb1KB3pgnGlYw89NTaA4DrIhsV5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067306; c=relaxed/simple;
	bh=xBgg5os0gk8trZVZg0H4rW2Gjl3RmKVNVYj5YhM0ylM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qebd1o1UrcJLXelq/WPktzdaVbRLUYu2PFa3UKRHQUh/CbKVUVI2fyY6QCkNVRxS2sr7Q993R8fkxP+qxL+f4e52SA1QElOCZbtaHNCPP4vJaajxZcWyOAui4qFK8CN0UaXxuK3dTn2jZeoPKaKLOIWOGb2G9SVggEg9I4KTiLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L5SeEiNn; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a043390078so33696375ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726067304; x=1726672104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=noal/gvZ7siOQnpRjSqJbDjWmvI+uJ1GjIEsFnwoiAs=;
        b=L5SeEiNnm2WQX8CPVJYyOTeJHmZayvIS+LD86qWXmpBbjgynymWqhUabduGMc/6DdY
         fryKqOeniwhaP3xIdrKm9w2TMDCgd8y4HTAYoOL0lJfPAYbntWx4x8qbGmtYOtqf+xEb
         BqaxIUiTpmSNRN4VMKSqK/3RGfQ8L6kmQlysc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726067304; x=1726672104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noal/gvZ7siOQnpRjSqJbDjWmvI+uJ1GjIEsFnwoiAs=;
        b=G5F7sMFyS0hGYhEyk8AFcQqzi/RNssJPnmF1YW0C441mlC2apHiqUwvlPSe8oTdekG
         R0PKbsFRFBPKVf5QiLSpS3BqZkQFgB03vhHjGhcZqHyty9gD0dHUgOovpLnenjG0ZD9f
         xktx2auP+1GhhoH0A26jiE2ENBDPNCshmMEkTrtslYAe9SSeulP2WW2h6gm3xdw0bjyz
         as/Pte+hdHBoaTxly6Rn7qBBTI3BZe9okHSPoLzwGUD7/P8eiS5KGFBgTy4fPxfeJ/I6
         d1cAn6YXYIXn2EOfBpq+tWIaCmV1+eh3o/hfyepOGgr0ZVOF4g/MzE3icHwaG4i0Qqiw
         v9cg==
X-Forwarded-Encrypted: i=1; AJvYcCVmkbM7cbsfllt24bIR+OhkVBircMf/vAxRNJzGeqM0QoKbmz+YLfG/8DwU4Dnis2m7ZAwukuXPAthxetE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdxvwKd1Z5Lv+V866Qo46qgC2aQyiKPRBubxu1p6zlWeezCmwv
	Ntn+V/My+VwTqhLYAurg9OsFg/DWjwAjNodnuQDpaB89psACuCdMa0SDBjJfPpVJzWXceLiZZew
	P
X-Google-Smtp-Source: AGHT+IFEhnsGpi2hXP15HfwLXqcPm+UCgf3IMU4rdFoNpO8JwtAvbVGOANJoC8YL6NLJ+WDu4n47Yg==
X-Received: by 2002:a05:6e02:16c9:b0:39d:24de:daa0 with SMTP id e9e14a558f8ab-3a052399154mr166079565ab.20.1726067303868;
        Wed, 11 Sep 2024 08:08:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fc835asm26384145ab.9.2024.09.11.08.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 08:08:23 -0700 (PDT)
Message-ID: <6a9ec038-c00a-4a1d-85e8-adb1d257dc92@linuxfoundation.org>
Date: Wed, 11 Sep 2024 09:08:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/121] 5.4.284-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910092545.737864202@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910092545.737864202@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 03:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.284 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.284-rc1.gz
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

