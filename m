Return-Path: <linux-kernel+bounces-261169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7817893B38B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93C31C21348
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265A815B13D;
	Wed, 24 Jul 2024 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JJBsegpZ"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D715B102
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834619; cv=none; b=GTx1cC4AA+oHPvKELes41ppy3TAGnFyQ+yTXvlZY5xWqHMMPuLMPkjrj2JdRzsk42N+itfazfR2M1crNi+N32MXlNRhH6TkPTj3ayGfWPSopfE2whfnIGddA/d0RV0gNDQc7zR7yepnwEdFc9yrhgpm7Xzi+wbwciUOB86E6wqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834619; c=relaxed/simple;
	bh=CHwhPKFP37wEpm/ioN5s8uvmJdD/vQ3tGPOtk/Tlpfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dk58lGJIgFBKe5ZT1T9byhWUswtIC104CP31OB6nvZjAtt7eb2e8CUZXWqpMjLdUEwxHkpLJHvjye4qYi73NzjVpo7P5TCG6UKNVBzJ6Ci5Qof6dZOvHCgSiFPIHKMvVgaKT4z5RAdkXr4yXLvGjZa8kVAEx0dxMfKnlE5APobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JJBsegpZ; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7fb3529622dso39000539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721834617; x=1722439417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+2nty6cjNc6kUit4UjMRd4RIDNniOKhIQiJ55zs9FY=;
        b=JJBsegpZX8BEzOyNqh5eAazcHwUOssJn/oF59KsBMteL4JA+/Jg8WYJLRuRsMsvpOr
         vZBcjq5mFmYt7t2vfxjRc2rFnHCiluUd3a/29E+8xYX+w/d5EEvGfgNXWHxyIGYLhopF
         YfQsXnSi8PA82r/HZQrt22Wsn40OSCRyCysHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834617; x=1722439417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+2nty6cjNc6kUit4UjMRd4RIDNniOKhIQiJ55zs9FY=;
        b=kJ0XcT6S2PYjbRFeqTH8FGgFRU2oe2y7zGegYsQM0Xf/JuRUiGIbbGU0uCQtyIsKdh
         Z6QDGI5fPCYUukSGO3F1cVt253r3h6A9m1kHkp8PvBzn7xbw3e/gAGhg8F02gd/m1HYv
         7xdvGZtCKrSV3BnrXkgf1ukA62qGC6gcoKr4JpSAF0vbRgqXET4N8Kd/q1vWZ0HaOEXR
         FBO6x7ycIVR5rJwJfBZuUiL4M+y3JQw1sFRuw/ltFED4kOafNkP2AI85FFg9OjAuZnpo
         FgK8acMI0q03dqQrFnJbJFPqfXVLtg1FNxecvLIKvpKcw+vo8imXJ8rGhaihoO2KtqaH
         xIlg==
X-Forwarded-Encrypted: i=1; AJvYcCW1XoPOypnk36P6lwP/ub5m0UXAOeGy141RKpz5z9K4jassW6SR1hMqivZUc0qyQU5qt+mu+fTR4soGfVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW2gV3O2on3FFf+1zv0fQ2RLwGjUM5fj2uIJpR3rPHiCE6+PwG
	O82qgi/Nv7DUH6KIVsr71+HvVq/0Qo0Vfxdkg+VZfU4qULHclRQnr4+1Y/oM13Q=
X-Google-Smtp-Source: AGHT+IHNPxpp8b1HKi2Mg5Fq3XRzdS+oQvqg3rS2l/yx6aMy6ymrH4MIQSeggOMeI8AVRwRXP5kH7Q==
X-Received: by 2002:a92:c262:0:b0:381:c5f0:20d5 with SMTP id e9e14a558f8ab-39a21777547mr710255ab.0.1721834617131;
        Wed, 24 Jul 2024 08:23:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a188ff9b3sm6772225ab.66.2024.07.24.08.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 08:23:36 -0700 (PDT)
Message-ID: <3915beef-5428-4cc0-a3d5-59cdc1b6b35e@linuxfoundation.org>
Date: Wed, 24 Jul 2024 09:23:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/105] 6.1.101-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240723180402.490567226@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240723180402.490567226@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 12:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.101 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jul 2024 18:03:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.101-rc1.gz
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


