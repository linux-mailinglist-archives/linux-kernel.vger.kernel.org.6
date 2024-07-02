Return-Path: <linux-kernel+bounces-238570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFAE924C34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 01:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C933283D0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83C617A5BD;
	Tue,  2 Jul 2024 23:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="guAjtI8T"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E6E17A595
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963637; cv=none; b=C9//ni+Ob/99oYel4VaKXYBAvGb4xcfuIsXZLfJM5pRc34QiFJn4BtgmQgnM3JTEMBisXhFNrz2dYY3Lsrr+QTJm90x+3CUpPmM9QNUR2TQQF68+C76PEizVsD0TVxgGPmZVb3ce0z/VVAhPceCWfKOHVGv+AyCZ5W31AA42kP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963637; c=relaxed/simple;
	bh=q/Q++bZUqwx4rHkgKvz/qr06d8ZoEgwD8AdUokHeVi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZL2fJonDFT6kQDID7VeCDmYLy1kczGxgSXcMj2oRqIcVR3+/DKBCAqwQsWvmsL15umSm2CXvz4Gh93ZbOCH/1/GUsfFW5/nyGN5mZPYcf8A24FGeo1+0hJijOTha8KyTi+e/9Y7LX5tO90AoLwpPsmsyVW7Fg3pJTJHuF9yd/Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=guAjtI8T; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-380cdc44559so787035ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719963634; x=1720568434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M1GBiR2qP3dwXuNbCIfCAYqEpvO2cT6fV21GvANeJLs=;
        b=guAjtI8Txfx+2xC7+ga5NwFLyyXBX2x2RwRhWK1UMY14rP9igHRn5JHcfp3sqTywxw
         g93wQRvxbEre98ziohlTCwQ/ZG44ut7yRvMto6wJLeow3XVNJcUsWox8R4YrqB0U67Xq
         VtS2ei8EkfwagPyICYJynqcDn5tn4u/FH4Tkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719963634; x=1720568434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1GBiR2qP3dwXuNbCIfCAYqEpvO2cT6fV21GvANeJLs=;
        b=ik7x97/rMQuzEqHFltA0kv7B7MBWt7Om54MHYAwnunY09pkDnBvOKya45hTvIFZUaF
         ru4/3qL0pprNVajQUbUmK9nHA/vcq6/Ogu2M1+BYdG/1m3rR7zYOSPub3AWX4b/zbEy6
         GgkG3cy8ElYAgCQ2mO8mF6d1MUQuaiJ7vRInIsevgCQLbXdbtpn7NkvBSy7uysrp5hYg
         6N4mq4tcfFC52MsvI7qdSHnGF07amfqOvWgYr5BWh9uYWmf09sJuMmqwWMnX35LDrN1s
         o1PIY/RaT/a0D1RAji94h0bkXhzAPlMUvF01f99t/Y0+6XYfeOQcaAPY+EkbEoVNUyK9
         wQfA==
X-Forwarded-Encrypted: i=1; AJvYcCWx2T91Xd7eIPToDtzZJEg5mPqeel6ZLlH7jGpWnK7J1PDu5Joac8U/SKcmR3yL5OKGg5AlIUbeh7PgarWo9S+6eZKv3BY0vFBz9JnM
X-Gm-Message-State: AOJu0Yz0MsXMF/Xhs8vUyDXP0fRtvhYV2+aOmPSk694pMFnYPC2alB1e
	i7//0zK4zVdscW2x7Rx6Yq7uMptHV5sn7MKEw1koNM9SxFDXJykvL4DkLdAbYiM=
X-Google-Smtp-Source: AGHT+IEROh2kDmfI0/vSuk2WwbomsNqHiQ8Mhs6Xsy7UzYSACQgA31qwiBNSiGoU/iCVvVcaUQXN4A==
X-Received: by 2002:a92:c54d:0:b0:376:3907:4912 with SMTP id e9e14a558f8ab-37cd1b799ecmr112365645ab.1.1719963633925;
        Tue, 02 Jul 2024 16:40:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad22cb662sm25750825ab.7.2024.07.02.16.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 16:40:33 -0700 (PDT)
Message-ID: <857aae90-6251-4532-a8d4-6d2fb8d29114@linuxfoundation.org>
Date: Tue, 2 Jul 2024 17:40:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/222] 6.9.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240702170243.963426416@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 11:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.8 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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

