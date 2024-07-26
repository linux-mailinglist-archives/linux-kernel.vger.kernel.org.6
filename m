Return-Path: <linux-kernel+bounces-263515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBB493D71A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443B41F24F99
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4EA17D356;
	Fri, 26 Jul 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JAIyH58G"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BB17C7B9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011907; cv=none; b=jXsLM1DbhS3gAcezS3GYtU64ICwrbDYEyywnomC1WkO9SBXRxIMS1d9W0TRQZAVWd7HDEPxP1pirrGYhbqadu+2rGb9PqlcHNOsoABu+RFC4hjVPgGnGjffg/guz+lmPnt/kyDqaxk6tC5xrW6kt/OV4ETjQw/u1ksCzcYINedU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011907; c=relaxed/simple;
	bh=liR4FpGObaLr3N9VLnvUf9D0SqRb/BnbBXVDeZQV/Xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWcJPYiozsY1iNG2r5/CMvhk6p0zZzfvC3KL8tMeReocwEYv+9YOncWQBgGGGeCjHXm8vQCjuJYzGwf5zA8W6Ykxuyia5GlB+VSvG5Yu4UheyrfXtUQO7FWD9A1mngRx4UoLFQjIvF1U1SKFUyIkB6oC9guXkIqMr12KBtDgBus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JAIyH58G; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-81f8ac6b908so7753739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722011905; x=1722616705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SoDlS+0StE2fDyQgsc9/rzf13+hWCe0NS+x2HBh4HKY=;
        b=JAIyH58GOBwqHjcukZc98vEsRE2T36v9N/fRMOhBLL+4lU1eUlZSTAAMbC/XUVZu5z
         4pwjKoD9CwK1U93RZ1crUisAl3gGMQPJDcnZil5hP0BmXTdtmfIWISruU29mBBxOlSsr
         QRp7050vm+50CdsmBL75/g+4Huobki16Yt2+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011905; x=1722616705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SoDlS+0StE2fDyQgsc9/rzf13+hWCe0NS+x2HBh4HKY=;
        b=cr/AMJugpr8ZzqPxwfrgl8jI8AWSblwK3At9I8PUl4THwV6bWEi3PIPnF6MV1yPaUd
         Aupe1qFAEEIfupy+iLOMBjYk3zIN5WlpDwq15ZfF2PdAumXJhjS2x1facdnmZ91AFrk8
         vW6dAZF/qFrbG3ahIW81AlLeUplpmPXLuysO4OA2lYMsL0WyW0JYPx/cP5v7XWf1vFd3
         Q99TiH2G83MQLUOrGA/uGd8uSiAAN6fHSCDRJ8IAoIQohNww07eWmq3MV2Xe+AZHTozZ
         NvEUW1mf8SVw83MzG5EnXXPJkV5UOHHibkW9A8nAv94zcrEctepBr8yh2MNBUODZvVDr
         GKjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwfO6/JcoCFm6dl8ICDzc4H8WeUFKdnW1sB3cTE7klzSKsKyVN6hOP+7b0Okg8x0IxcUdyG6NT59r4tUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGCX/Hi2jpw7U+9xTfrInfn2opXrK6h5wDz6b1GbPki6egBPll
	LDPcpzI4S24Dsbuw75uToLyn3L4XCPhoBJmnckBRVTw5eBKYCk771lOmxiMUd2w=
X-Google-Smtp-Source: AGHT+IHx3H4hFmIxSitK5dI1fIxrAS0E0Olz8bBvOdpIdj2NyJKD2GwHGGm4gzA5iZEK6sPs9CXNaA==
X-Received: by 2002:a5d:8ac2:0:b0:80a:4582:ceca with SMTP id ca18e2360f4ac-81f7d02e3f2mr420233439f.3.1722011905010;
        Fri, 26 Jul 2024 09:38:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d788b40sm115538939f.29.2024.07.26.09.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 09:38:24 -0700 (PDT)
Message-ID: <e4d1e0db-9d0b-4563-95ef-b66517d5fe7a@linuxfoundation.org>
Date: Fri, 26 Jul 2024 10:38:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/87] 5.15.164-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240725142738.422724252@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725142738.422724252@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 08:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.164 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.164-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

