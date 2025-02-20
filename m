Return-Path: <linux-kernel+bounces-524174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C9A3E02C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D393A422B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921EC200B9C;
	Thu, 20 Feb 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b0vAPQ2/"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2771FCCFD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067995; cv=none; b=YU16fQvplrNBUAaNovJH93WGIpN/6tnqo0grWdFIB1lwi4KXcQfnIoMr7fHUJZk49JcxTOyFF1f0oMKJOtvjzE71r7MnJCY9SE36NCLXRmU8AY/j+YZJtaHKUS+zGBElfn+b93Ym/7NIptTxuvbtoFOM13vOZSKMyJBmCNFOJt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067995; c=relaxed/simple;
	bh=ge8tDROtqPFb3OtBLB+xMWyNR3arwxc6s3la74fZId4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYKwo6OJ0RL4+3Vl47FeRzJKYAinbBdsTmFuZ4dMD13loKnxOtGsMemuJXtE3su7WqEj6LUrKUhezwexT2EgwBjOlkqCOpvADc8wEPpUG4YsafOS0/jfBdL+FgzS5T3d2Y/kR3+jQlhQqw/QAjZ7iNnzfNKtNBcGLX0GdfMg6hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b0vAPQ2/; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-855a7e3be0eso29896339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740067993; x=1740672793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o64MbyeNKxrYo9iiqLxo3YEJFFUOkSLGKF7YrDzWVuU=;
        b=b0vAPQ2/RzxAogh3CjiBH2LkjKWzTD0GoENlrqJHXZ7HrRcxffR7fwOQ9V3czL3i7a
         k9MBwkdgJNxaz8eiPCWXctZrWtAdf5cG+sjVbM4MU0KZNBt4vlVAAaup4mzGU5H18bjE
         JoLjro84wN4xjg7W4wWzC2MtUST4VsIiVPvzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740067993; x=1740672793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o64MbyeNKxrYo9iiqLxo3YEJFFUOkSLGKF7YrDzWVuU=;
        b=dDdIPqNY3+9JWcFbbzLzvt3sMfCyGfrLB/TyJ1KyCTCSUlYw+bNUD/uXluBmtyWTZk
         +NC5xAjR2Ja7KqRkFLeTnM20nhoVUuwmu79k84GCGCCZuJd9DdPKx91i2iELoLydAbmA
         5cMl2cgJG+QXUMRlSqVdNFAS6+g6loQpONlWBS3eYCQnmrsy3XKHSWIOPFR1XWZOC+J4
         I56elhHdpz2TMoAOLlWyu1yLeYbpzPR1m1idKurKfUcFSw0YCoHO/wRlmTRPuvxmlOUs
         MPtkDJy6NSv8kcSO0Qh03OxqVRs1QMfeV0egnAggAD84xljfj5GRc82KD1J21efLYi4n
         69CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYQsxHoo7EhkMje/KDkOL3MJ8tJBEuj7Oimrty0L1AVdGjgjdFDrRy/7oX2NJl+yrRb2Xg7mypo3y8xI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5KN7lFal8NVpCU6JGgtJMxOdH327qLPxdQvcwWuK5rqRP1JZe
	UyX4h2ObvGIaXkGrvFM522PVTwyLpDO+aGzpOFMWFXB/lOe/KRybWprInbJv+AM=
X-Gm-Gg: ASbGncvcBNQdGUjSRdA1OwyfhO+3Jqui/ZuLA193l55kvDqo9lfxPiGZb7t70jyRDlc
	FACC6yI61P7tjPmUCAp9bG3XSHJ7YgumqT/d99LR3HdkITZEobmWf7qZn7ILEHNhOJuzaudXx87
	3xoVEf74LkBg4qVRb1w/yvcgEuI5StWh9VZPfo5HFFAXfprXSifsPBHZ5SGZSyAhUATAhelVFfP
	rNBIF53bb2QoDCGuU+Zw3125He6ol4WYJk2JXeja9FKZmR2gsO39ldqVfMLtcXWvLhpsJZrUYnJ
	UGLwrzicQUQoNpTDyW+XeZV5CQ==
X-Google-Smtp-Source: AGHT+IFlFgsDehQjT4J7TYSzBZJFTYe25Dkt/CW5UyAf97Mbw/pAy0RXZVZebdzjiAytc48LSVF+oQ==
X-Received: by 2002:a05:6602:1607:b0:855:d60d:1115 with SMTP id ca18e2360f4ac-855d60d1332mr118178739f.13.1740067993088;
        Thu, 20 Feb 2025 08:13:13 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-855921817b2sm180941739f.17.2025.02.20.08.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:13:12 -0800 (PST)
Message-ID: <ec8f098b-c157-4ac3-b109-2e7be64d8747@linuxfoundation.org>
Date: Thu, 20 Feb 2025 09:13:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/274] 6.13.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250219082609.533585153@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250219082609.533585153@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 01:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.4 release.
> There are 274 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
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

