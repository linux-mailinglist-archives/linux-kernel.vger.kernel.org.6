Return-Path: <linux-kernel+bounces-524177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D49A3E01E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC04D189EBBC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FD920B812;
	Thu, 20 Feb 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PILe3mLY"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C9A20C00D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068028; cv=none; b=k1f6CObJkL3fxN/I/zzbQCFt+pW5RimiUEtxhyxLzKnfMfNGzmmBu+H7k6qj+jifurmmTq9D4bKqx/APBLMKsR7at1v8Yz8KiHP7kAnMtzzamEA1cyNh2xbjEACbS2Ty3fVPUWVPeb34xEmbAG4dz3031reI5IimO0UO9hGdh+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068028; c=relaxed/simple;
	bh=8bQ+eHlnlUU17DnVx6Tg/96s0TIWsZ8zu20MAi+7+NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJ3htzvdBXc507eginmQAy32dNPAtepoCPJRoijBaI/nw6YgRiNT8Wwc947jkgK6gd9RLPGas3y4XoUmt8ldWjtnvQOWE/CCngp6RSpRNwjXvR+72oP/JlFpGnFJx700s/2ZVufs4hfcZ1/PojOmQtQN1/aM4kyAdSu5GV9ciYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PILe3mLY; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d0465a8d34so8476845ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740068025; x=1740672825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/Fj7ezvz/oB9SkmTl6eJBk1br7rLRHa//ITeH4ze3g=;
        b=PILe3mLYdrTPQJnrmJPB/qAsxYRrzMfrtDvmjUCA6BZxXcwCipYIuIuqOEko7bmzHh
         tz/zYzlALslydzAwVTiVA8MEupMCei7LizQJoiQJCJZBnIjYPTWL+jgVopFwhHaDUMq/
         vAZTUUj5i9TUk5G7GmeqVgcTmzgG8ia/rrcSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068025; x=1740672825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/Fj7ezvz/oB9SkmTl6eJBk1br7rLRHa//ITeH4ze3g=;
        b=sZFxT4nddk/wpMeSdSV+yyTam5KT50zmvDT4m8I+CyHda0ThjTFykOt3eMfi23ufFZ
         PH6rmeZP6VV7OJe3rdO6CwJmnjy6kkoJ7msb8mvrDcIcvj/uVf5IpNHuX+qmahNFUuhJ
         XtTA31ZuBVLbnY1V6mPkIpj/Yn1nOp/ruXQyc/8MXtR3DdRHXutAooWlDvZKC7n1I5tn
         TMZhNP4k/EdUfLX2gzvASdx6g6LLTohS+jCHXrFJLgW2Yo9RW+M8uc552Rc2AX2MI5dk
         R3mPmg4k8w4sAoCKBTynUp6dbA0ON4Xsgo5wl549OFBVdr9jWlhn3RVeiJNKCgGWuFap
         GSrg==
X-Forwarded-Encrypted: i=1; AJvYcCVG+AfGZCMa/QOaMtmfQrnjMxvOUwM8YS8dStYtvxoVAD32o9AU5mazzP0zcroOlgWLBOkRkSI3O9klpuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8XKHlpFavkSg430sn/Nq1vVEaZniz223rA7BUu+0AH1E3/k1J
	x3UJnpT/Y7x8dI+NV+0XxKOvfRKb2AFYZD2vI1Vs5ZcQsfBMenQLObl6xAjXIvc=
X-Gm-Gg: ASbGncuHlLcRqV6RsZhR0mp6qKSnsOuexmIR7s1v4Y3dsatCI5Ms/y2YaafVLMsKGUv
	EeYaF6FOO/zk321n+BvkW2d46fcBpm8pT+7j3lsuPjigIc9GOcOzfMb11GjvKQBA/ey9AeqsiMA
	Ba+kwhzxkPcQLiUBykDYduJ33ZzHWCQQY4SrqZDYFJVQRQpxXr6zgDxA/Mo9pxFpXGwpyEaoJCy
	ThXwqSbrN96yYh0dpu22d6rtMTM8Hb19bdjueF6dz+mDFSbePMP+4AsyQYTkyN7qi2Y3BGipoCY
	Oexw887dtNfXkHB2RR7CNe5IgA==
X-Google-Smtp-Source: AGHT+IGcSeYu2MQaV5yGR45eedGFuM3Cc5su9wfHeFkMoBkw+wHJEoPeb8gbQCzXu3GfMbmvhR9FQQ==
X-Received: by 2002:a05:6e02:1849:b0:3ce:8ed9:ca94 with SMTP id e9e14a558f8ab-3d2c25deed3mr30899665ab.14.1740068025107;
        Thu, 20 Feb 2025 08:13:45 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eeb9359772sm966464173.60.2025.02.20.08.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:13:44 -0800 (PST)
Message-ID: <2861e7f2-1f53-4107-8386-e8268d3a2cfd@linuxfoundation.org>
Date: Thu, 20 Feb 2025 09:13:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/230] 6.12.16-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 01:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.16 release.
> There are 230 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

