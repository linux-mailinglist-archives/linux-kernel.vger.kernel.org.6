Return-Path: <linux-kernel+bounces-549266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754CDA5500A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861E73A6779
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB70B20ADD1;
	Thu,  6 Mar 2025 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J0wMIuyh"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBE331A89
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277020; cv=none; b=rI6DeA9pq6jujSejbXX1P9FlL/+iqCxSdsSR5hkyRV3xhkzaDU6rtDMjQjYmX/hQqChb/r8Gra6B4ITkhUionpVkCOqJ6RuqIM/GS0silo6+d/+swOKSEGfvfnHmEJzrsaQDYYs2q6Yn7GnWb3GRrUb1Gv3QqpVb1VA0TWigCmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277020; c=relaxed/simple;
	bh=xVNSnb0jyNfDW//8xinTnXuPgEPSTDWwEpiqXIaFplw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QA7VnZqPVILCpE5PxEkyNn5QHWKrN2DhW2TGzXCVS5W+OwDWxaou2tu4ki2CDrvxNh9Nl88g5biy1JyM5kMYVEF6p4ULmSLxofmLijPxYshXGOt+nwnlSUI1g1eUHbXs5gG+VdDAee8W19JI+00rmEpqMoTKLhllEg7L05dFAuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J0wMIuyh; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3cfcf8b7455so9322305ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 08:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741277016; x=1741881816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcNdPRCInpMj0KbnCBF2KUxDA1QurFq8iTZjeemnwJ4=;
        b=J0wMIuyhYdwsdaBtaYJBwc5FmTuVswJ6OYz6GiM2dtuGfDIzkPx1wCe15uHd6LWcnj
         X8qtQHgCDqyqum9Fj+dK1OI1Rt59zNJlWQin4hZFVMUtcqHIQaiUkAL3ndJ0ZguZXIAF
         NIMJH0i/KLy2ZJZqsPoJACRePFqRnt9tBOHvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741277016; x=1741881816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcNdPRCInpMj0KbnCBF2KUxDA1QurFq8iTZjeemnwJ4=;
        b=wCaR12yrTOQ9mGlGXcVQBXRCHg6UmFBlp7WeUalJ7ePsG3pybnEi8s45jHZLWSjwzv
         J+cOnxnurfIt1iIHRg3ODbcLxbbCk/1rJGJKbDXuFdJYuAMQDMqI1DG7X+PLrtaDfVBV
         P9ClZmCEL7VjZFUXPxS1N1oJxApx3AOgjI/tBX/Dhgz9vwnFWJkPjF3OOZkSMRKXX0vd
         xFQP+jt9XTXiE7USD8Pq3L5C55flNLokKGptbDQZ84JWSxrcQWpbeecgJpbnCpMWuUbQ
         6do598rbbVJnVuec29iF+DlevQV1e7KZbB6Jwsq3ClT8mksgBpEKdOkTeiEW69xiyrpN
         QFgg==
X-Forwarded-Encrypted: i=1; AJvYcCW1nMh5E+FfOsSl2bqVhEvwq+WNhkwDa7XVTs3A5VEoL7ahwL4qhVgMxbSmbXytrOugyl5dm66Kq5zlsL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNQ5NX56fbMNm7mPGnzvySdH2ELxHSG3keCzp/hlaXHzQylSYx
	eXT04QfhpJ9D8CPhZCADFHE50Wdm7AeloBc2appUdOEoD3hprUpgpvP5/HgoJuw=
X-Gm-Gg: ASbGnctdVrYQyEHkRCPrLWR20ADeEWFtoRSjK93VBxJBBECmkXBonV1WYmQSG+HgR0r
	UisQT+W6eEksgC4ib4400oqQfVUMmYOFy16zHE4jqfTIjZNuHxVDJNNUnmIxCpXwXsa4h5ri/uu
	7OxEgHBVGSOJZHG2+xlyjwtyyhnuYoC4hvd80/6hICoajSF6BCc6FtaX8gZZ0VUakyFCmNfMhnW
	05YJBtktveMj/BVUBAm44aPzxVLcmZ/05t/jPHc1w+ssnPkoyPtnJq3LQ122cs5GJpV/pp19XtL
	0dQgLWfJhY94idEg98gNtOpoIADeFoPZHL56bHdVUDmaTCpFBc13lCA=
X-Google-Smtp-Source: AGHT+IGQHGUCX/DcHAB0f8MKsKPYCnuinUn3LSlGNP0ULjdmmx+23Lb00DxVmOwmlf9J59UO66TIrQ==
X-Received: by 2002:a05:6e02:164a:b0:3d2:b0f1:f5b5 with SMTP id e9e14a558f8ab-3d44187c021mr799245ab.3.1741277016390;
        Thu, 06 Mar 2025 08:03:36 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43b586ba3sm3501015ab.45.2025.03.06.08.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 08:03:35 -0800 (PST)
Message-ID: <dc1e2731-cfeb-422f-8243-95746aafc889@linuxfoundation.org>
Date: Thu, 6 Mar 2025 09:03:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/176] 6.1.130-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 10:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.130 release.
> There are 176 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.130-rc1.gz
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

