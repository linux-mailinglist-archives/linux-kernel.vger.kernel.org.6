Return-Path: <linux-kernel+bounces-349553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2FC98F848
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435E31C2162F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCDB1AD418;
	Thu,  3 Oct 2024 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYiikWV8"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543181AC423
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727988879; cv=none; b=qYdPlk+3wJXqQr4nm4bnkp7wXlvPIMfFlZ5FANqR4OTEDqsqqNUB/MvQB9FXkR6K6a9VvwSN6yk5ISeBf6NpLw/CTL4E6lVq7qlEkw0WxvoVwVxS5ydA98Mzj1tf0q2q4L7429/efTRYMu1CJiYDD9THebfIw8bOPflogBUIloU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727988879; c=relaxed/simple;
	bh=uszalte7XO9gWoLV2ANsEdQbWY4YytMyiL0XukH+s6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mplf7QBH9T9XP1SGem72wT6tdqre3x5FRuKDnq5rb3672AVneypemDb9ruXAks1Fy80Fh5kzrjYgIQZuX493L231kAP7ngqaio+FrX+YJzbUbi6BM2vm88+F68nvOcyVSghGKuorA08DUXyCr1k7j9HxOlhI4jnXAxRujQx83Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYiikWV8; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82ce1cd2026so56899639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 13:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727988877; x=1728593677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nkVnHAarrjh9pxwlEl/XGXl+U0ORYx7Z9Mfm0whWCFo=;
        b=JYiikWV8QGnAsNqliKnk2mEIMC3T9vvQ6IA7A/BV2MkqgTZBJO2EnffVy9JezoOGZ2
         vqfShCUTZcEyY8XrI6YAyF4ynhVG1AJRA4IueIR6tOfmOAyTECWKgkHe/wQuUjVAfPIR
         o66o/4PRu/HSUqnZrc+n9m4CTz0J+zsV6n7Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727988877; x=1728593677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkVnHAarrjh9pxwlEl/XGXl+U0ORYx7Z9Mfm0whWCFo=;
        b=TobfNZQ2DfVO+xQAAcykw4/F/Hmbz1xbnvotSTOoav8y545kVNIBe/aXGj48ExiULt
         DU2CVixzJYorXY3CIVvpFlzKh2aVpC+pPNnqIzhPUvtq5qy/Hl5WiO6xsBDuei7hkcIE
         ZsUFfUmo9TuzRYD2lXyHQ0J672CoL8k8zx3TjitB070c2Bvb4LiuBP3RDN6fr2uST7Ge
         6UB6Jq3BC/bbKFcqTEQ4N2c66Kpkk4TjLXRZMKZEHl+bAy+FQfWgQvp0C5xUDPie9PfE
         9sbZ+pOpVVGS4Mmna8oL9+mK2dDn7KsnNVgFwLGLmVlBCkXNfehBlUAIt9uPKdhVu/xd
         e0EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuMtIizwqwHKurxpqMkB+2q9eBPcW7/rxC+NiTAizndbJw/S7rjr5Gi9Rw+iqsWLo5QRV1Den7o0CG0p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytV5VqzJ8gVg67Qg+5QsFcbBQiZQOJ/tRx11iYPaV8kZ3Jhe35
	0WWQb4CwEJh1qHMiu1DeFE02YKATXVuySbfJCL2QCKienxus0uip6wUgK+f9ovE=
X-Google-Smtp-Source: AGHT+IHcHz5/fRhV6oV+9eeZbEYQcbkgMbnmGgramQS2e2MQ5OmtxRdBopTUS/FIudr8SMUKogEV7Q==
X-Received: by 2002:a05:6e02:12e3:b0:3a3:6b5d:7011 with SMTP id e9e14a558f8ab-3a375bb4be3mr4868385ab.19.1727988877212;
        Thu, 03 Oct 2024 13:54:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37196c1dbsm3574965ab.34.2024.10.03.13.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 13:54:36 -0700 (PDT)
Message-ID: <68a440cc-ee1a-480d-8ee6-25b1e6188ebc@linuxfoundation.org>
Date: Thu, 3 Oct 2024 14:54:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/533] 6.6.54-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241003103209.857606770@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241003103209.857606770@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 04:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.54 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Oct 2024 10:30:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.54-rc2.gz
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


