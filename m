Return-Path: <linux-kernel+bounces-223553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D31B9114C0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519D61F22381
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750547FBBD;
	Thu, 20 Jun 2024 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OyhJ066I"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5167602B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919359; cv=none; b=OCmkMnzDM4laHn3JTrTgECTO205FsBWzzBMK4OC8EI41DbO2c9C7ZNVVpRM0BYEPNRqOrmAGQ0q6ytOwaOs+P6JAw28G2VhxxfZBxxPAhVd47pzCevMZ3jsuTirVLgh2p23abLETb9C2sVdjeU9M9vWOVtmQithma4TFNFK9AUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919359; c=relaxed/simple;
	bh=ZTcgaK56+v9pAJfpyBCcK7AMQ31SZcS+ia5+MEWwcGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrZRIm4vLIP7Oe6lbjA8K1x42yMVbF3/2bUQJsjnLNsEbuZDLjTbrlWxH6Z9hxujUb7EhMM7boS/KfdeegzsLN1hevta3QpoEKtv4ZlPOxEjMaqEN0oqA7d8W9Nn3TrdFyAqhULWgO7CBHuangCJUyphUdStPcH3JyMJBJ0hHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OyhJ066I; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7ec08f3c98eso2610439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718919357; x=1719524157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9ofIQLYPdOS8TshOJj7rEW8hxg19zcYrASvxB8ul8U=;
        b=OyhJ066Im7YQZNDdXGqDrXmnQOXFJAfE+AD/rBOa0H9UYGUlCOIwmF8Ea5TiZ6C3i9
         V8sADRrxy8jTDhPp/riqmW4VNahzfZlziWUDuLBsrPsjmFcCu+cz7kwj6Ym2u+R3IkR7
         6idCxRIEqigs/DPTo6mpTNXvIjPc/S2pzjVW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718919357; x=1719524157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9ofIQLYPdOS8TshOJj7rEW8hxg19zcYrASvxB8ul8U=;
        b=eQBRxbLE4nCMCPEXGLlAXWNygOI4gVf8uaYl77jT5pYWrMK2EpYHJziDEC1ck0b2Wi
         HxIKOoE9OuVT3nU0H8rF05eB2qTdbHYeDJWLuTcoMdSO7beRE/RkvHdn3d/QrC5xs+0P
         sjoWLKSCUTfVONIRZhV9BS6p0tfWxSlCzXTTR3G+fAvlugW2fMVWjulSYWJkRw6LNx6R
         4q1/ynzHkqMpb6NBBT+R9O7RBT9xFmUuhQKdtMmwW4Q+o/12v4KngYKEXf90XUxj1STY
         52vL9aJ6t2xYqdCTrLWovxCc9TY9HecIJRGz6NOVCgtlQ/1L8ibVClqsSlfnQXukWn9r
         EdpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7GhqknY2PnGeW0mQLO4GtKVRWQjXXPm+hlkxJ0G3iy/kcbdlVBU2P5yuenwSLEP8bysMdM2xmG9yseSgOw4mrvgmeO964sYuRMMJ1
X-Gm-Message-State: AOJu0YxYa7E+9sywflY59bLAzpsQNqgLSQ30EkqPoswDK28mth9BhKV9
	dk4gCC0gUS7fxYuyQxKI+EGXMg4XkpzaTI6ZKlgmPnf6oLXpBVXzbpr/QL808fw=
X-Google-Smtp-Source: AGHT+IHqCribPqhw2Ibl2+02wGY69rP8DtYR7MopXoSYep1ws5H8GQkoWY3heLjFA/IvrIKssmwzyQ==
X-Received: by 2002:a05:6e02:1194:b0:375:a1e3:d66d with SMTP id e9e14a558f8ab-3761d627f10mr55203895ab.1.1718919357283;
        Thu, 20 Jun 2024 14:35:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3762f38bafdsm434325ab.62.2024.06.20.14.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 14:35:56 -0700 (PDT)
Message-ID: <fae309ae-cd1c-46a8-b6a0-e34e7ba7c44e@linuxfoundation.org>
Date: Thu, 20 Jun 2024 15:35:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/267] 6.6.35-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240619125606.345939659@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/24 06:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.35 release.
> There are 267 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.35-rc1.gz
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

