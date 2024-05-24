Return-Path: <linux-kernel+bounces-188803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B118CE72B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABD11F21848
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB1412C47C;
	Fri, 24 May 2024 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PKMpKPBk"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836F84D30
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561328; cv=none; b=tUoScpoVoWOi/6FaFI+yuqM7O6+lOL9QJlRilZFfsxUucDzrq0DoF4uDPDhrWzj5Oo0dcLLOBd+T3ZA6G3RuByycXk0pAW7CyTKKT93NDmn/2+EY+/EqCDpupE4M15OXdeuzvbaA8fTM/VpycPD/SNlKcZEs3xjvPRop2SbI5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561328; c=relaxed/simple;
	bh=O08vWwtBUIpEhU5WTNR5BKBLCurGnvqSyTGFDfuzxvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRJujtmCUgRt/WSwoL8RC20LDJycIn/hsZKQfb2DJW9bhQtzY0H9VdsRo+YmjHlDq43RDkCwgjHF7yo5UMOgANJP76hW8HKKImijfVD4SC20gplHpx3yJUJ3RAnRYJcISkbz7McA9f+fhipFb5uYRTHbB3kOA7OZOclNfFhbXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PKMpKPBk; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7e89ade63cdso3593039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716561325; x=1717166125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jle+hnicjpSclGaYZzjyKVLl1Ha7enj6gT7jZRGY2v0=;
        b=PKMpKPBkJFPnZnyIuYwNPOItKvRhPsuCE3C93acsLze3/0LgvP5k1lereBuiPYVSPa
         eex3AwQU9uRb9RwoJUDh8mZWeWcPVGd5VhPR+d3gFeahpfePDEw7OOyxvdPs9tKnZaxP
         vcj5jftx9kW1qZ5iDmQkzpEa8LjSHMwJMsHfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561325; x=1717166125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jle+hnicjpSclGaYZzjyKVLl1Ha7enj6gT7jZRGY2v0=;
        b=DQT4exMyFUQ6P4ujWmUqLXLG6l6Tvurn6YxSKtxFLjndtiPWicrUL477o4/PvPCPi3
         zGtCPERPAhUFLv/5CB78BSBj1DJZmycNoWe79oq4Wvn3ShOyIm8VdvwYLt8mJwNrWSyN
         alOfK1IMAobBexuOJq8hVKyBhbv9JzOU0mGmXtA6JdNPI84J3UEuYK3Dhm2o429kAbUw
         CIkdyIkTHheZLvOZIAbRkgzfh7BVbaPPcMeIH4mbLbD7u3KJxNaD+u2WLJvcZdPRjC5L
         wQtSoOlhwHqQW4y1WHu4veOUtXof4NONugHKYDW2/vCcYHpxr48qGgufk5aba4OwhUiF
         CgPA==
X-Forwarded-Encrypted: i=1; AJvYcCUCJhsreCZ0waABF2vGP/FOWvsh+djt2p7tuFrkQ8+G4mNhOl9UZtdB6Qouzr2c0CJd/hqIVkC5EQjNLcmD/o04wjRDhhs0l3WOMsFH
X-Gm-Message-State: AOJu0YzEIQ6ufwxFWKfLmNBzUppp1w1HxPBTbW1P3kSnPriMJpEHduOm
	zNAWS0W3EDX7ZYgzYn6Aclprcq/cpiTScT14gSgmRU8o0YdJdIspWIBxWF7GlyI=
X-Google-Smtp-Source: AGHT+IECqnorAkwMxUXRDn2Mq4YCQEosZzpHiwGGIY89LRbKtPXIL14ZxrWcSfKIH4ZIXrhutLmYBA==
X-Received: by 2002:a5d:9354:0:b0:7d9:eeb8:ddeb with SMTP id ca18e2360f4ac-7e8c664ff36mr272174839f.2.1716561324217;
        Fri, 24 May 2024 07:35:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b03ebbf7a6sm385939173.91.2024.05.24.07.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 07:35:23 -0700 (PDT)
Message-ID: <58b5d404-82fe-416e-9110-6fb113e3b8c4@linuxfoundation.org>
Date: Fri, 24 May 2024 08:35:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/102] 6.6.32-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240523130342.462912131@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240523130342.462912131@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 07:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.32 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.32-rc1.gz
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


