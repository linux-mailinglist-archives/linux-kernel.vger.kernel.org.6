Return-Path: <linux-kernel+bounces-180043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DE08C693A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AB31C213AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C8E155750;
	Wed, 15 May 2024 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A5l12RpA"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4EC15572C
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785576; cv=none; b=jvcF0QGFd+h6iP+b9V5aRCN6FVzWx99ZkNtD3i06qZvUJXWa164XaNFPb+LmBa6gRzPiOi8hcQd4gWIKitE+nS+TrdCV+HWwCrIz/T0Hlyp9JFAOuzNbBEILxj3Bj57c6/MwdBz5EKHxW8sGhXAVSWFEHSE1djOMMXwMqkYQoF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785576; c=relaxed/simple;
	bh=dkhstp4krRRf/IIrV8Jp0PkKghXhVUPm8ooq1NqISAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THvG+ZOOmwgCHL5Cf9XivaZFX6N7wGcMzoHQDL1HhLldw3/hb2lDAHG8mxnbhr2LXd8mmU99bGpH+55DV8paxi2mA64Kcd7dCTqxnEzugqHLrAQkwKLnCxarCl+dhiCSLKZWvpZ0mNDJ3gtF7lrRflCyAQCeiiRZMNnNPZKB9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A5l12RpA; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d9d591e660so23681939f.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715785574; x=1716390374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tcxeZUXyQkyFLx7KMiCTRsTvFYAkwjKOXr0GkPeu54A=;
        b=A5l12RpASh3Xomv8TIKvaP3fNvJxGMGO7uzBqNOAMUWiZZMsbwJxEIViin3hiFqUH4
         9tmimvOHe92Fcpb9n/KHzxCEcgVjWCHzvOa8kmXX0CqQsqA4XXs8C05H4njNkRS7zUhH
         MGdQc6177ivJEg4wJvxqZktquDuOE4RoWlKkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785574; x=1716390374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcxeZUXyQkyFLx7KMiCTRsTvFYAkwjKOXr0GkPeu54A=;
        b=drNMzxptX1mhzdUMaWbiRejbPZVN/tKrk+irrEo+4MXYok5yB5I3Wkl7moJlqQ9heF
         4TcPUS+cLJ7o5BNhwfS2ls+CJllPXO65LAOAb4FAQHhJLTpBGEA0Je8R8h1d/CvKnONu
         Y1MeFHNhml7lga/2TdnpMAbhvsy373EzSBv8xwqD2zKcY37vli5QHTFWvsJ1rlM0/d+4
         EXBICEHbkLURDhgezzPtBvD2MnSosfdRwEQKM3UdhSa+h2ZsJByWUQ0JFit/nbQnYUXT
         zchTwpjC/6bR+fEbYcKv75fPNgQ+x+Q7FUlaqVwyqIUyR0wG7Z71yV/ito86fd0LKYCT
         I6cw==
X-Forwarded-Encrypted: i=1; AJvYcCVOMS5xltnkRU3bfPPvxx6lLsBQozty2y8R9gHcO5+n8dK5wO55XkeeQtcPMlGP4otzBvfWTcfFjxjjihfXZJpf0LDA4y2iOw1P1gdE
X-Gm-Message-State: AOJu0Yy+WMjdZwwsybVqRk0rwVmih79m22E9aTGVExxzcQwM3VGi/UCM
	A8EamtNpWs/jNngSOvvtrQO7UFHkpwgKQCCNtYT6ClNP28Nls1D2ehVLSR5hp/k=
X-Google-Smtp-Source: AGHT+IFos5E0NRF0v047mDzN6VC2lHuoSvXNmQBtmU1xGnoWZxhdOZ3kYeOn+XxmLqo5CIB6hHhWvw==
X-Received: by 2002:a92:d3d1:0:b0:36c:5440:7454 with SMTP id e9e14a558f8ab-36cc1444bedmr159110175ab.1.1715785574464;
        Wed, 15 May 2024 08:06:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36db80ab36dsm3707715ab.67.2024.05.15.08.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 08:06:14 -0700 (PDT)
Message-ID: <39e1c8dc-ad54-4c47-921a-0d8d9af513e6@linuxfoundation.org>
Date: Wed, 15 May 2024 09:06:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/336] 6.8.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/24 04:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.10 release.
> There are 336 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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


