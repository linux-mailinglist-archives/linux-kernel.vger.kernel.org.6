Return-Path: <linux-kernel+bounces-411897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A78F9D00DF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 22:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B471F22121
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 21:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6782199243;
	Sat, 16 Nov 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WWlMXgYX"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075201957F4
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731791168; cv=none; b=it/2GOTNabkc6+YIc5Nxok5i4G6VJ2dVsY09e4Rh4L1T8Z3btK5OiVvdKMKHQB+R7Pkke3jsVaOR0GolJoFenYkP3qL14EQDd/2wO8UfL7d8b4ICK4NdxbMPY2De2TL8FV9DXupEYk34NZ0jcwqdb/l5blr4V5ALi+atYrKe7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731791168; c=relaxed/simple;
	bh=wn9xCKXToTyI9t1rtvyW1oEEfrLH5/5AdrmpGh/vjL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3MLh2CQMXe256WmQLc9OkwseqG53OyQArhz5/kvrVN4xhhcUpQbIrgVXXjbMwAp/a5uraqJz3bOWUuV2OBylOfYC11YoEwl+mBg7RR+fRpsU418RmRYD3A/KgIvL7gYTcvOaQ3OLCjHGIm2vfhEdFFlQ6xHn0lbrKU6KOI41y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WWlMXgYX; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83ac4dacaf9so65965039f.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 13:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731791165; x=1732395965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0AbCMuB3hBadpOLkxJkWemVNrqkK9LRa2QCq3z5Qco=;
        b=WWlMXgYXDpWRFsPWMH3jnAYetiwTUZhp9tAPTDnj64fXNdoVPQwhLjMWPCv2nje3lA
         FG0oSWCJxgouN8Cyu550he/ofrS+DakSmX+9H9I6SipH+KgmIvmKhnjfoiAr/4tAfA4N
         C/qTM3jLoxYdYQcFDujr0xR6CLnu7JhRsixd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731791165; x=1732395965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0AbCMuB3hBadpOLkxJkWemVNrqkK9LRa2QCq3z5Qco=;
        b=TmWkjii4DEZVOvaGVSjlHmgbd1JMhxzxStXc7M9QVZiEwIdugdZ+A3OG/Wna4vBvoD
         x3hBU2G68w8ZsHRk3mKdfWhlrst8kZaNguu9TCpnHqTJegqgUr0TJYsmwJXJnByj6LoN
         T+Yu7X2XJDFGyPt+mDrhBcC9UDqss+xsytP8RANT7N/ziEeY40P0tlHL2bILKmUfrZb7
         VUJgPsvnWHhtuO7FuvmTfCKAN5a2zpPlvZWYT/WWX3AK3FzXqIEniF/MsgkzZ+O4B3S/
         9wkMEpU2y/gsjU4+mLGOUxM36W61ovV68ejXvG9iyelvVmps3DV/j45Dj8LQV6EvT204
         tk2A==
X-Forwarded-Encrypted: i=1; AJvYcCVnHHYkgIpW9N86JuIjb/c3aWoyTMh1p+0m/44+6f2F7ziYCZCEAXAvCtaey4kE8jOY9T4aAMrAAUoUJVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfHZLNx6uGKa7q9TsLUMf0qE6CE2Am0qGM31IcowMlMjPJnsmX
	lRlMfmGiwOev9SaCaIB+vj5SvEnusW5uCWaJtOUwyf2vmBN/OaD+XiTvLRGfcAg=
X-Google-Smtp-Source: AGHT+IFLAGWpLruvWVct/AIomQLfHk786eMYKwC2cfKMYTqTaAo0hlwJFI62U1jwxMViXP9d4Ur/sw==
X-Received: by 2002:a05:6602:14d6:b0:82c:eeaa:b1e0 with SMTP id ca18e2360f4ac-83e6c12ffe8mr679102039f.11.1731791165065;
        Sat, 16 Nov 2024 13:06:05 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d6e7374sm1174251173.32.2024.11.16.13.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 13:06:04 -0800 (PST)
Message-ID: <5ea45f0b-bd60-4603-aed0-10f70e77096e@linuxfoundation.org>
Date: Sat, 16 Nov 2024 14:06:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/48] 6.6.62-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241115063722.962047137@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241115063722.962047137@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 23:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.62 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.62-rc1.gz
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

