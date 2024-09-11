Return-Path: <linux-kernel+bounces-325417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D104797596A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42EBAB2596F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6A21B29CA;
	Wed, 11 Sep 2024 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CtAY3Yce"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0738F6D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075789; cv=none; b=WXhjhRYeRoLbQMhEOSCSl2BwrPL4lDjxG0+XbFv+dgJIynQFFq8yFEqjvGYb2h1R+ck01fb8qMjOE/Ohg4FQmcRvbw/+sOstwEj/NCdrUWzEKWHf3YHBcAAAM3qQHxzA60nrZpa6vslF9R3rj0SqInFT2FrZ97FdLAqZlZRTnzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075789; c=relaxed/simple;
	bh=deyId+hbvPtYVLrqOKPCrG62mVsKADAmngzIBDzqIuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzBHas5ntKRxjvweXqEEdPg9ecLVsG97xTD6RWoEfTw+ShhTd7pHO23ik9NBjGAYLkRmFig37mxruVV6Uk+q2KNjiBZQpNZvHeyS2GWiEoLwTxHHdOZkhYIspnxpEHZAC62pu8uxypE/Gp6c//M7b+PGTNrvdCGd5N7tB9sAhwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CtAY3Yce; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39d30564949so279765ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726075787; x=1726680587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XhTcGv+CB7b5Js70j67xVM7T4ZdDcQ6iwfn6qh12PQA=;
        b=CtAY3Yce2ybZtI+rXtXQzbLaiy9kJvKSquncVZ78Nbx3iicyZnFQkMmFb1xmPLf5gL
         38p14PybIDovU3qdRSF4lZp+UYIo2Xi5jI9YODlGPGKMsXxVGYBv05NLwgM47G30G77Y
         /vMUx0zNAwBpPM0oTM2aAeOdZfpDQDvJN5XOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726075787; x=1726680587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XhTcGv+CB7b5Js70j67xVM7T4ZdDcQ6iwfn6qh12PQA=;
        b=oxrGB1nbpFmXBjTMA4a6P/jWTjuHXhddZ4Q3/F9dUNUDHL/D8cHPYUO57K0BM+2gq0
         BST/up6IE1j7YPND+IL+b77cJ7h+XOrbdKIL12VROA9XWgGGHpl3qASgbMX3gUtMM3JX
         E6p1NDd6ofGKpp654uDXl4TIUjqGR6Mwtw/iBcZ5M0jau2Q+ekOJZzhVstDHFLpvNnMs
         i7qZbmrfm5AA54QVORLHgJxydTtKDTX612LGUDFQ3lyZPsOpQDl+24oMF+UWstBok5RA
         yiL9lCKStE3EtX+pSnlOuKfqOt38GTN3JtHDVIpI/17VgUMfzl+MrA7btb7ciMZ3udD8
         XvGw==
X-Forwarded-Encrypted: i=1; AJvYcCURdPr5qyDJQTfQwc1HJNtI04QImi122Nptqn+GoiJbf5qMeTCzXVlGnAejriVJj3v9wJB3m4j3oVvn1Co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0UG0nxYH8IE7oyJbd/nbI5vRPzdDuIsGXVezo4CRrjnX9ODqx
	3rBqE0EzsUUzAGMtUa6klIER8yvh6dkitxqFFixSpJC4iYWIc7lMtAZgsCzX8GI=
X-Google-Smtp-Source: AGHT+IGXlGFn0JYATmp8cePrZBokGVaAbGUtgxCOQUBxYmspTHiO+sJeq9FPmDxQYzyWepKbjXkDkQ==
X-Received: by 2002:a05:6e02:1708:b0:39f:5efe:ae73 with SMTP id e9e14a558f8ab-3a05685605fmr139166385ab.5.1726075786908;
        Wed, 11 Sep 2024 10:29:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f8910fdsm94868173.107.2024.09.11.10.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 10:29:46 -0700 (PDT)
Message-ID: <5734f415-87fc-4897-8241-8d262868757a@linuxfoundation.org>
Date: Wed, 11 Sep 2024 11:29:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/121] 5.4.284-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240911130518.626277627@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240911130518.626277627@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 07:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.284 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Sep 2024 13:05:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.284-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

