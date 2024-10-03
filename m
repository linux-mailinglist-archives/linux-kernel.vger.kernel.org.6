Return-Path: <linux-kernel+bounces-348438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEF098E7AE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 02:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 016FCB20BA0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52039479;
	Thu,  3 Oct 2024 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P/U+rNgL"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62341CA84
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914650; cv=none; b=WtM3vZ+edpq7ss5RwDo/vHir5bPeiRvWAkglX9ZHLRmTgN3BQFqmjAzYSGzyZ1+V+caV07MmXQRTG4DA6tMNyNCA2HkyAslcJT25Ivg4sesU0MOIM3nK5XeaHMy8sMoJPl54QpUr0RRmqoUA8QzA1ksH0IZ3+BV/HFvxOJVhnm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914650; c=relaxed/simple;
	bh=AeZplv5sIj1kXLIBoCxANzLbS63O5jg6wjEtDTCyqD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0bj/TzzFalQ1Qv2KHa/POrhtOgnJIF/LVa0Ua+QJ/nchF8HPiKfJYWLtCNCF0AWjlJZ2pvQdY29vB8JrFX5xv8zTZzTmL14M+qcjQ+RAdO/nQ7Rn2Jh3K3ZAzYSiI5GRJHT91Xv720Bk9XASsFoDxKcB56PulIO7lz6Z+42uGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P/U+rNgL; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a33a6c3102so1415195ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 17:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727914648; x=1728519448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ax5xOdilh38TqtVkwQbid1kOmPXA6/vzFRCdYgx7bg4=;
        b=P/U+rNgLlXXtV1zdZSOqycBawedVUG4dx8y32zTtDW5/jhx3gra6wx2oI+pD+aa9yl
         AxhGJUcTJsZp0ccbpH3iWmxZX7esHti+VgdqTOuhShS6avY65nmxyeiIuiLgzrraS7WV
         f1r8n+04WVuaMF2FZddYKQ/SAln5qLsYwSH3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727914648; x=1728519448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ax5xOdilh38TqtVkwQbid1kOmPXA6/vzFRCdYgx7bg4=;
        b=j6nRzDV19DEMKov7Wv/QnKYUxd/mW7bX7DEITgAB+7zIa+1KaQQ+o01ls4zyawt7GR
         qORJMAuBBhSoOm2ejk8PJF1FRR1upKSulZWCedQynSaujARM6iXxbZ5k80FTRSzxZpsc
         khXZ9uAq1qgMD0lQ5u+IRFUmTszVfntguY6XjVVnSUw0SIn5TBL7GrXN6f0iSzJF32Up
         d1YdyXbs1btPV17byzjCttyFOofaDvQWhuHK5avapmEriH0yL787T66B5ieuhJYy72mR
         pcbHggWg39cGLpWJ+uJkXX2SlyBJ/s5j00xn76SaS0gVMgwdNvpr3qYBoOVYH4LZNYbD
         lvpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8qWu0rI88pyYlD4BiNjlOcXDBglOjDa5X2+QyeuOZXOYugDtgaS7YrNS/lNiQGE6AcErssN2O8QHgRVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDaJ5XQYynMy26TycQ+U03y2w6thlJZPdtqkgiJsFluUBRflkd
	2lSu9xL8OMVRyBQiKac3hVWE+WTJwdhzv+Uwrdxc+PF7aq5pwSd5T+qRTw8v7c8=
X-Google-Smtp-Source: AGHT+IFlUB+UhDu8AeilI1lMi1HA6k1HRPe3Oxo9gmhCfAeUkFS86K6LL8sFxhk6yBXLam8yHWP3Iw==
X-Received: by 2002:a05:6e02:b41:b0:3a0:ce5a:1817 with SMTP id e9e14a558f8ab-3a36e1b9fc6mr9998495ab.0.1727914647710;
        Wed, 02 Oct 2024 17:17:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55a63ff4sm45738173.94.2024.10.02.17.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 17:17:27 -0700 (PDT)
Message-ID: <340abd79-d3ec-4669-86d1-d428fcfe628d@linuxfoundation.org>
Date: Wed, 2 Oct 2024 18:17:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/695] 6.11.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 06:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.2 release.
> There are 695 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Oct 2024 12:56:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
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

