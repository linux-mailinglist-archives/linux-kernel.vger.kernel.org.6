Return-Path: <linux-kernel+bounces-188804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA2C8CE72F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 339EDB213D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE39412BF32;
	Fri, 24 May 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jy/+6Zg3"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCEC12C476
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561393; cv=none; b=V5xAHujr9TxKqzG3lZtTu83emCTxx/7nW72877sIiVpffSch4jfFhPy2N5QMDz6mZTm9QyQygzYv7EFTHbQ7fU+avJ53k4FASsG/S/cKex1q279HffhvEhcSJeFGbZHXt2LZZGpV86Q32qOwGAVZlrV9eS22NnSIHUkHdkEN2Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561393; c=relaxed/simple;
	bh=OlcQUkE+10S+V+5BWXkOihQkB/FKpWJlk/l27hzFiPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVWZDVsypikbncqdaLpuePDS59baS/h24es1z5RDQZW88qR2BHEGolWwY5TpVPrhr08+u4fCPCNPOvZT8m8yFYQxpQzSYFJO36MUlcdEkBF8yMAOTt7iUI+LlGcLVamvHY+hUq5nx7uVemAJ6Y3f7EfIwMOYAMR+cQOKQii2SKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jy/+6Zg3; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7e1b8606bfdso6836839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716561391; x=1717166191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0A+T+phTh7w520oILhLQP+E0qPbhhtr/8XZsPjsHfU=;
        b=Jy/+6Zg3zDsJcR7QuJJYfeEImP961hKJjUXeB4LqA0FY1Pxf/sMQnaBTgBdonArzdV
         6qJuS9u7oa0aGMCxYc5CBgwbR+2/tqJQtW5YkIU12UE0iWVJl0SiFq1x6Ze2KWzLi3Tc
         nWyV+mfoD5zFZkzeMd27mEGNWjjl9fQZXzJ7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561391; x=1717166191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0A+T+phTh7w520oILhLQP+E0qPbhhtr/8XZsPjsHfU=;
        b=lIf2FUtLJzgggei1ArurePMGTVqvIT/Y/OrJNnbK3aqunHah75+cgrOO3+gF3BTuC3
         btMFR79kM7IWCD8wqej/ZV/1IBuGK7jKDQwcQu/mOc0r0uV24v1IW5kTU9WoHUnN4QJF
         DHGkRwWb/7EzPCW5kLQVZnTK5XJU0/1XyP5vXWOicftCJYSGnyYnAdbLpeFBzk5l5A+F
         xiDGy6+hio4bzVwdaD5xTMi2O3egKCffLDgq9h7gLTZKU6EF+G9HA4MvQ0kbErRlfw9i
         /lHkVeeqqdc8+7IPHLzynf5B++vzW4D1dub+4bPtRF8TAViDAfiFAm/jQlfrwn5FcWpj
         yJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5kY552WUxhJvLtrkS3QIzYIesLJqtxC+jrxMd16Zcswit2OfQBNSB9X8BE7BtVLSpd9mH13iSAKT8RMYroPOEj8lIWkO6zqcKa8oQ
X-Gm-Message-State: AOJu0YyuZ7qd6ybz57vIvfuGvREZz6FSQeuKjBR9/RqKhE7CRpELEzZg
	XzY0lQV1uguRK6u9G5x4N10NmTFuDjVk4VsXUdu9LSPdVkbywyn5VAxvMI7GuUc=
X-Google-Smtp-Source: AGHT+IGwYTkaXZ6CDxeoD4a8OBX6/giEkKXDWpEKMArNNfaIijvcv/Bg/n/W7nMYYT2ZvRHrGYAcrQ==
X-Received: by 2002:a05:6602:2bc5:b0:7e1:8bc8:8228 with SMTP id ca18e2360f4ac-7e8c14117f4mr274978339f.0.1716561391032;
        Fri, 24 May 2024 07:36:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b03ebbf7a6sm386420173.91.2024.05.24.07.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 07:36:30 -0700 (PDT)
Message-ID: <f1d167fd-dfd0-4400-a1a4-5b3f78b9a59f@linuxfoundation.org>
Date: Fri, 24 May 2024 08:36:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/23] 5.15.160-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240523130327.956341021@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240523130327.956341021@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 07:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.160 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.160-rc1.gz
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

