Return-Path: <linux-kernel+bounces-278592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12D894B242
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFCC2844BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B9E14E2ED;
	Wed,  7 Aug 2024 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cQzAGibC"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35E1487E3
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066802; cv=none; b=V76nFldUjkEhYvbLtY2+rncQtrJL5/GeffpUbb9Cu1Z33WBN2Q74Gm7Vxj7P/EKQIBOZdXVSJkfQ7iGN7yOZ3demK6Gm06bqA+XMuj896NO3PulmK70Qj5vsrnV6XRuR0RbsTFF/M2fW1R+UVcMiJ7zN79B6HH7mBxwoTzwnAqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066802; c=relaxed/simple;
	bh=GDAclEoOcEOWqSuGrmy+DM2Tp6zu1/nfi5udLfWAGYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byaURkgS7XxJOKEZndG2rnFUEKgt9JtScsTiDsHNMV+M+b1pjuiF6NUlHxu5yMU2PukLm+x/zEx5bNUjchvERnBKc2ZUhDUU9Hg/AM/iGd8vorM8BOUKmgA7BsxGSMJq1b4DaxRhI2JMsu3qyksAwo3Qy2QBbCUXzla++tac1r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cQzAGibC; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39b3c36d429so205645ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723066800; x=1723671600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+yt4eOqI9n8STlMoFI1L5lm8J44U6xP2uia/Ec695s=;
        b=cQzAGibCu3mCX2QUVDGg5srFbuFi9WrN0edq978u2qi1zZze9RWgkhMNd95HjmEyCb
         G+9UtkRzP8NyeAMx1FboOxGKlX8kQIcBEuY3hsFkE0OiLMvg64BTyeVZdwbppKojO2/j
         BC41Cw0dbZbO91hgYF2saQmqBBIBfgzmKX7uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723066800; x=1723671600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+yt4eOqI9n8STlMoFI1L5lm8J44U6xP2uia/Ec695s=;
        b=TMJ2sr066/5XPaNQB3+SikeIoxYqAi9F8jMOOkvnVaGDxTU+xgzWVFTL48lCjPp6Rk
         nE53gL/JMzdLz7taBnAlM0VuVcJLrLB6bGowXLdBmSXJgmsrrx75/ZdKyIrHHZW6KXhS
         /U0Vjpp/dHN0eTKH6G0OtO+8/OMF8qwkqOSyFWjiqB56R2ZYEo9IWvPHW7oQTdyZrPAr
         EmRowySsmb7QBe489PO7JlBqLghSNqUmEKSzhr1ZDjdTB1OBNIqgkz8ST2B2VIcQPJ0e
         02Ld2WENAh2VkUbWf/ns3ZtnRnjPQwpNzP3PgIt0ghAN1XdU1idn3EJw5aUHHYsnbEMT
         /ELg==
X-Forwarded-Encrypted: i=1; AJvYcCVNEpCuGdGFCseCO/ZCkvQYaQJ3oQB+0uUQxwMycS+YE1kj/+D/wsckF93pFDKO1Lx/AeMymEYbdhrFdQTXJGp4FLSnRvNzwCfmXK4b
X-Gm-Message-State: AOJu0YxlnT7fcUAffAD0cIbuP8sQXik10StLF9OiIa2gg5WadSDgPhTO
	PAMjPm2jbuSRjJe/CW0Atxmb7TU/O37A8/cpmZPe6FBsJzgXh5VWLe6kCWD/k/I=
X-Google-Smtp-Source: AGHT+IFVLcmbz9Srv9EE1tgNm9JYUFhDPEqrp8BTfDtkNgf7sBQXucPNQavpPInt+I5wDtcoPYzQqw==
X-Received: by 2002:a5d:8559:0:b0:81f:8cd4:2015 with SMTP id ca18e2360f4ac-82253826ac3mr5374039f.2.1723066799915;
        Wed, 07 Aug 2024 14:39:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d69a6ea8sm2984779173.54.2024.08.07.14.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 14:39:59 -0700 (PDT)
Message-ID: <6ebacbf5-2f86-4861-bd15-478e156c9948@linuxfoundation.org>
Date: Wed, 7 Aug 2024 15:39:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240807150039.247123516@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240807150039.247123516@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 08:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.104 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Aug 2024 15:00:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.104-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

