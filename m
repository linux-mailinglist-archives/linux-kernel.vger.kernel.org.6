Return-Path: <linux-kernel+bounces-278591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB6794B23F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E86D1C212E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD46714A09F;
	Wed,  7 Aug 2024 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gFZ2/WDM"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC478C7D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066677; cv=none; b=sJCYhYvizSG/YQCUxoK9pwfNd+gN6ORQMLENqlTADFTGncxfrpWSd7D6PoRbDhSYLDrhBhfcL3biClfaL8WQW7JYpHqJ0kD8G9qdun4N0xBwIpsIDVpYpU/xwRGky6vjfRn8Gunam6l5jJNOBGdu6F3wlAorD+fLgJEHA6T/+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066677; c=relaxed/simple;
	bh=bPAE0jN6OxJyf1bhY509issRR1SkVegadOe7o/gDdwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAeCHc+yxqwJKBB2tIfP+vlAToWaALSq387SRbaDIgW16lU673fZh3dwgh30/EGW57xMeCFs5IxdKs3Y0s5jYZ+HsrbwUQ2F3RceoT4TR5NpY/5BTmf+4AkzsS3u3Cj7WA65keihSkPazvKEHu7c7icuYGqVNAeu4qZT4ID5pkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gFZ2/WDM; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-81fdf584985so1349039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723066675; x=1723671475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aL0UiaVBU0BhpVk7/KjwpvAladn9QhUC4pdvjmsQDOM=;
        b=gFZ2/WDMb5BHsT7KH2D2XOgMeUSebIf/B9RR7fSf4UnCpu9I/mDTP1pmzmVTDm0kEO
         ErDiwLcACRxk4be756Ubyf5BLuHkDTJ4PHuxlgPtqmb5TxAGyqWs1fwZYC7fCHS2zGR3
         1EzYBAvFJFZ8ecPJ21qguF1VWMDsEsOkyqOS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723066675; x=1723671475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aL0UiaVBU0BhpVk7/KjwpvAladn9QhUC4pdvjmsQDOM=;
        b=a8NemaDMt0MvyFx53kLkUshiQyV3iJ3AeGsEmhQl6ArmXK1tFu8I9QmW9CGpyjm9AG
         AidkoSDHFsJnvuhvMcsRu/k7BrOX5uI7sVi5gtGPxvfxMfjwMjoOf8Keol37PONB8fYZ
         iCuCbPhaXHPD2QCQqg8g2S8fr2rAkrzTWN+tHZZRHIrCrz9NYA2Eu0Woskzb1TS9JsMD
         wefZZDza+rx2n2BcnGK03LSmJPeN9T1fmeWUVioJcjZL+4AZ8qV6QHOgsf4fF342ygb4
         xD+vKhFVei/NMa2VH1S6m5ffoSf7JLXTigBUBEqyme7S3DbglOrvCIzm0iDGgNlXg5lj
         wi2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLJa9v/IjNhszI68Ml6Fx3iHt7iABWxaOr2emmQjs18h0bS3z32gPtP/eEnFnf61PFmWHo2E1doLGszpJN+X6DR7I668o4YCqs0VfQ
X-Gm-Message-State: AOJu0YzMWLaQtd/kvUbUCP8O6KsUT95zinuvMenMEDKCx6u4xLMd/Irr
	+zdcrWS8Ia9Luy4zJ3Xaqm0IxkgKKYISoi4pn7+bHK0muX3Wb8pz7c9xkcHIJ/w9xsQMS72/RyJ
	Q
X-Google-Smtp-Source: AGHT+IGVMtn7MiaIscoViwTPglpD4M3uStUn2uXYBT1vHi6PGkJW0BGpfdtdKAqOky58jq7XY8dxxw==
X-Received: by 2002:a05:6602:2158:b0:81f:a783:e595 with SMTP id ca18e2360f4ac-822537e8030mr5124339f.1.1723066674772;
        Wed, 07 Aug 2024 14:37:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a34c01sm2989918173.119.2024.08.07.14.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 14:37:54 -0700 (PDT)
Message-ID: <045f8971-09a7-4b9c-b753-d991acb6739e@linuxfoundation.org>
Date: Wed, 7 Aug 2024 15:37:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/121] 6.6.45-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240807150019.412911622@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240807150019.412911622@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 08:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.45 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Aug 2024 14:59:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.45-rc1.gz
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


