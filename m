Return-Path: <linux-kernel+bounces-246777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBC592C68B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5809B21DF9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261C4187864;
	Tue,  9 Jul 2024 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R/3PAc/V"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC05185633
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720567389; cv=none; b=GhevaZS889MRrWyHlU2UmU1WW3pSFnoi18NI86p2tDFKTULwlworBwM0IxLImAv2gCrTYuM2iWczXXko6muZbcafQUQtSQxs4/Vm4YKGB/t1Y4N0x81q9uRtJVNaEWTXBQ3RcQHs3WZgIKzCT19IK8HgkMHdN9jGogHGRS5mp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720567389; c=relaxed/simple;
	bh=lzNEjgXu4r8j+W7K5icyhFYr8ozl/BnL1z4/q7wYvlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kn+zeUONGA9xPv74SU0Qj3PAdmXZNawSQJwUVJ2b4afKWwAE53b2f2s7XaP+PmmF/F3kuY9Jj30mWzacWgy4LtwBLCIJiGfmV/N4dQNRIKFFMjYXFzcAtNyTlSY4xonptnocXeW5RGQFB8HEeHqV+HG4C5qn/lY/1lWccw5OWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R/3PAc/V; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7f94c2178e5so13457739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 16:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720567387; x=1721172187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZ+w/XkfdHXX4WsNcOeYmZqVtCBCwZdWSjv1UC59168=;
        b=R/3PAc/VMVc7xhnN15P7/s/WZAg41aMxVjOlnqy0ECdj69jRDAcqeqjw8a7ME22LpI
         58GsSvtJot0HCuOYk80M/tPnkQ3MCFcGvcgf7SwW/OhN4nknfPPuHv9Kd9A2mVHPdy96
         4qYkiaiNHBNv/lAhLR+Wv9mrZrjAy0f1Lb84k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720567387; x=1721172187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZ+w/XkfdHXX4WsNcOeYmZqVtCBCwZdWSjv1UC59168=;
        b=HRFhnFoaNnm57XxsRBDt6JO/ohbeNwB6KGEVfikrY2agy++NOsBOOjaG6K1PZri1WC
         pOEGJ4ieIltriLWZke2kid495XJnfW5nB/QN0gEuDyOJMXLrSVwTiQG3NI245Xj6s6sk
         xs03BU/emkNhedI6652XSnIT5DcauRo/rsXjF+u+A75IOy7G+Ie8gTsq4ALuSQGjqUhZ
         ULFJor5rVhfH45Zp+Ev8MG0yQPU9g7qYBlbxudE/eWkm1ZLiOjmpiJod2ntTL3Y/+CM9
         1d5QRsE6l+JJhE50jpY9/BjBTYRkQueArCIve9MtLtg/wcIwc1tKr/NU4VWvuJIsw9BS
         hMiA==
X-Forwarded-Encrypted: i=1; AJvYcCWdbjnUrNt2QOndMg5LWk25QJ4rpkLQ/1z+BiJ6kpfEW537y+KJKhDNYaJ9M7nyRkITmKuQwx8323+80f+HUHJjX73Cv/9qFEYzTAk9
X-Gm-Message-State: AOJu0YyehbEdPVA5ZGi+8Mbl8fmpPbixQUcrpUR1deUQ++rXIR9uR+jt
	Ytkjj8cI4fJ6mKySZnmcb/K9VQmabQa+yhwzx+lUKghSwyEOMOaPBVZt5jiv7Go=
X-Google-Smtp-Source: AGHT+IGfwyA9Frqr4q+phODDSJdDL5G1s9zHOOePe2O2BpV1L9xAItxzzKIkxSk//h0ACflnrrSGIQ==
X-Received: by 2002:a05:6602:20d3:b0:803:f97f:59df with SMTP id ca18e2360f4ac-803f97f5a89mr109895839f.0.1720567387053;
        Tue, 09 Jul 2024 16:23:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffed680fa4sm79331239f.46.2024.07.09.16.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 16:23:05 -0700 (PDT)
Message-ID: <a2178b3a-955b-4689-8b99-6f931ec2fcf1@linuxfoundation.org>
Date: Tue, 9 Jul 2024 17:23:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/139] 6.6.39-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240709110658.146853929@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 05:08, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.39 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.39-rc1.gz
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

