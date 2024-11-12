Return-Path: <linux-kernel+bounces-406843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7379C64FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D181F24E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28BE21B42A;
	Tue, 12 Nov 2024 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wu/LtGJG"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7749F21A4B7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453343; cv=none; b=HLAegPQyTePp8kptdYA20Eiw5t0dCmy0a1vx830t/ra1NoLiLwoHW2XJE9tP/T79X5tck0X+6pnnJWB27sZ2gdbU7htVch8/bifAqWcLBuKQ1yJd860MycyGrqg/on9mSGgVGBV/3aoB4DFadDrvZ5q5s9T4QyjMb4QrRpJItag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453343; c=relaxed/simple;
	bh=g/R4ohx7mYN2DbBFxLjMcewmHXuw5CTSU6srdda8FSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IExTBM16IkWLLQF8Ce1aRA+TqmpZVDgtVxhnTX66efG771f0/HksMsvJ2K4mQ0yVH5XC1Ho0HmPCswZGYXhBYo7RcQhDhAlg3OA3cruzlE+W6iIN/bfgnneyofgdU4GQ8ooHEW8YGInHT0ZtY7BjeYLqOK7MZh4TzjufoPBNt+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wu/LtGJG; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83abdaf8a26so237583039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731453339; x=1732058139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnMK2dqBVllbxdNe3R5GvuE8xct6oB+YClxSZXO8Q+I=;
        b=Wu/LtGJGPjd48KzdqF2pSfCXn9Qz7HmLHglIgFYxlsg71M4zNNrnPC7++WbnB2z5dF
         LOatXeOoNzhbrUZu9lMoAQ6ESdb/uHtwgJjkpkdOjz5+pI5+v8KpWzOscbIMTWVFJN+Q
         xoXno1zNLDyFD7Sbv5hjr68faE5yjEC/IE3Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731453339; x=1732058139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnMK2dqBVllbxdNe3R5GvuE8xct6oB+YClxSZXO8Q+I=;
        b=kqNAtpe58aT9Vv0VXQgOF6+nn2EDD0RPETwKQFz38MTWP8LiXSsLlit79uHrrEzXcE
         l4QB8jGOvjKcE8s6+5JiLMwRLP7Py466VD3yjF5gGPEwmCvcXuiXHMN90TtJu2M7lNRt
         Gaectarkq6og0MrbKLdwHZLpO3t7rRxP017NVg/DT9ezYKukAtnNm0NJ9xpJXZfTF57N
         m/RV5U+dNf+JisV/bzQY+1M9y3m+ApkSudSq8s54G2iR6ClfBrrvrisdy0ege7pT304j
         ftL+w4QyEFskYXyHBDvYKdkCND4JDhIDwH0XwhOhapp9WO49L1+8aUN2kJkMYGQG1ZAd
         8CQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsIGptTBPbysE8qynHzWh0Q5WGox6Wh+QCvOsXHp8dEGs56dVBv/JRiCInhoLQEYuvbVmn6KMDQq0H1pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZB9funaureTRUzgcoobQAAnPQiXXZZN1YWLJWEpibeM5FOMU
	hEpdNQoq0nPlED8ltu33H3epukEqPM21R9wVT2MsUHpLGzz48cIayhYABxVHJNE=
X-Google-Smtp-Source: AGHT+IFe9FwwfyF1CfXGat4+I6PP+yEv+9tyc7mkPTeM33S6NC5Vw21jNi6/ApYRZEmQ7fQakABBrA==
X-Received: by 2002:a05:6602:1408:b0:835:4d27:edf6 with SMTP id ca18e2360f4ac-83e032b8401mr2284263439f.7.1731453339562;
        Tue, 12 Nov 2024 15:15:39 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83e13256349sm228310839f.13.2024.11.12.15.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 15:15:38 -0800 (PST)
Message-ID: <2b93e9bc-e36c-4f4a-a137-f35a5742a3ae@linuxfoundation.org>
Date: Tue, 12 Nov 2024 16:15:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/119] 6.6.61-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241112101848.708153352@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/24 03:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.61 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.61-rc1.gz
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


