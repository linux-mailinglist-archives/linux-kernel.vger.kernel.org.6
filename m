Return-Path: <linux-kernel+bounces-325411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6527975959
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBE11C21211
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434A91B4C56;
	Wed, 11 Sep 2024 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YT2+92VT"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642D51B375B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075589; cv=none; b=nnEt+izIY9E+pJDxzZtAzOPGzBVxFqMZYT9LErXJxYvbFebac+1FtuHfmAl8RGXO0ZzF3UYmC4QVo6r+yc47/bgIJqrOC4P6b6jDxMCF8k2Zuauj9hCkpsiLouzKetteN9Pd3ORHE0EOHqLlBeTotK0okNGuy1gYee5zdVi9gFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075589; c=relaxed/simple;
	bh=9//KDvyuxplwL9Zi1v0mRliwQlC7afyYXuWA9OrtvW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cU+U5kFVsg1CvJoVfHRFkCWXdFM6LsCE36VkZavO5Z49WIFOPH1SG1nKf62TZpkXuMMOyMvkThB6iTeQM/S7uNc34EEVRa663QZ42RyU/ZmfpOJ+v7+ZPblBQtOuKT1n07+Ul6A87P24VPIF6tN9MJhFnj/2y2kSVUg3Dt9CRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YT2+92VT; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82aa3f65864so1584439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726075586; x=1726680386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2estjfu4vr9z4sdfFnffmLrkqEpyju416gUzpXqiGYE=;
        b=YT2+92VTcCCf75PSnOaeR4AZrfFAD+a+m5xiJ2utY3SD7J1HY1Z2HlnGX2hULSSpAH
         f3c4LQ4r7d97eK8fE323VgcoNU5gdoN6G8NgQeMfEbTtV/qIyF6AVm2SiLWKB0QFC47U
         5ljEA8kRzecAov6AnmLjH/E9ZsDUH1fmDGKLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726075586; x=1726680386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2estjfu4vr9z4sdfFnffmLrkqEpyju416gUzpXqiGYE=;
        b=IHmDctJ/VQLJiS9bLnT0nKUUXtMk6YZS4K3EXCcaj3NkMjwPUaZzXcJEviEw+8CBnR
         fW8W4EonUYBMpID0Y6IazpFeIRiBhZAcBTdRvsfmg8aDAFisjg0B99wM9c7iJY2ewIN/
         1ttLXNYWfL+z4m6gxoOt232rW1XhgT7Tb56PhYRzBgg+fmujRXy2bD84skKeWoDa0LPZ
         S9m4ywmvHEQh7IE+Km1fTL3z9ul1xJFgqyULPY+WqLJxAvt2lZqqhUtdAnhS6TFIputp
         Jw+QfuMk/UFs1sQ77etgMPUoFiQjMJVxys3GONbwiZ3iLAAUA+Dsd9g1Js/gUY5mUQHQ
         GOTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsUVtmahdq7pb82lRF8nHs5ErrXEJL7JY/xlqwZHOzQ4hJF4/F9TM+FU48iMOnaifqNmzghC2ArAXGY4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSNApYjPMYMQMakUlOquCoESs3iV+oyOswcam+MM30rFdVsYBP
	MZD1jQM1+ABEM5xVh3UrGWU5SgHCZH6oyRZZ6kgQSGTXfGdRpuoKNH7C4ub2Aow=
X-Google-Smtp-Source: AGHT+IHht8VaGNScxJ6V1eZ0F9zhycM4mZpeGgCpP59HyZkJsYU+EMu7GQCOHk5/26BckyfsFLyfYw==
X-Received: by 2002:a05:6602:6d8b:b0:82a:a4e7:5544 with SMTP id ca18e2360f4ac-82d1f8e18c6mr33726239f.9.1726075586482;
        Wed, 11 Sep 2024 10:26:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f56a21csm96914173.37.2024.09.11.10.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 10:26:26 -0700 (PDT)
Message-ID: <4de97bb9-0791-42ea-8cb2-7fb5a24be832@linuxfoundation.org>
Date: Wed, 11 Sep 2024 11:26:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/185] 5.10.226-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240911130529.320360981@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240911130529.320360981@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 07:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.226 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Sep 2024 13:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.226-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

All good without the iio/adc/ad7606 commit

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah



