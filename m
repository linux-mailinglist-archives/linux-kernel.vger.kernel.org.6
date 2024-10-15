Return-Path: <linux-kernel+bounces-366023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF9699EFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7652B1C22BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3121C4A0C;
	Tue, 15 Oct 2024 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S0yriabV"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C71C07D4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003205; cv=none; b=eQLqNko5gKNL/hICylERqPtf1quPaezCianFeynbjQGvawmwYZFMNrShcGYrnORjM4ne1QoR8trOBKDcHRLKvLTxxw0CJjXOd+kfNU63F/m9PhvVrjwCr3Ho2RVlfym8BHWVCxnM31ZvJS5VdhqBXxGBOnuRp7ZPMPJQPrpga3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003205; c=relaxed/simple;
	bh=gEQsPCTYADqg/5dhizFfvZ4cQV1lHlJa0/ecRwJ3WD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ro1MCiZK9x/fX/ADIQPSObLsyJ3Udc4lTi0ld0EMH/35DIxqpV66dj7Qg9PnScRBTJPjqvk9LRye9JMAJ/dMoLF9xQYgE8oyG0RVLFrn9vXPXEeVxPWNuBQrvzUpROh3vJk+UAWKJFy8jrm/W4FK/OLxRliQA3wye+xTP8PFwik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S0yriabV; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8354851fcabso225868839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729003202; x=1729608002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/17tHLWfe/53Rf7b+xc0smi0gst4zLWfVRqbp2qAVs=;
        b=S0yriabVdlGfAPqq3QzCuJ9xI24M723jDcVqvvKeaHYkOleguSh+aDYAPNLU0fjCy0
         wr+L54bdmOxA/SSSCSloVkR0cIUohpZ2IpVRDnxANTlu4jeJuKD4kRfKr+5+f5oEqOGY
         FEI15WzLZumZCUSX9zCi6RI70bXltaCC9zncM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003202; x=1729608002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/17tHLWfe/53Rf7b+xc0smi0gst4zLWfVRqbp2qAVs=;
        b=tr9DjM4vTLOK2ayF9k/r8CybZxiYcYng0fLTQtLUi/baK90QHJs47mugHKeu2uP7PB
         kM+5WsnO7cFnFUG9g7m7lTsKAxC6DTLIDWsnbzUFPQ1jRoneDeOu+ngtn46qw+kYE2E1
         p8cPAfJIwbaTsSdbqGPq0rRnsaMwrAhkUzB4opOMH9G1iQC2mqVcE+UhnFRPeISLK4ce
         c1HOHoB3BzMd4HrPlVSuvOjq4AAC7TE7d8mmJ3Rebdkgsp5HPDrxOVYY6KpN1EQTQt5X
         3Tqc4KFv0Iv/hsWnkyRBB7JYLpRg8UV8FQ2+65TpfxHTkZ1eD9hlp313vR/lbLutfN3I
         l/Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVRXhQyJ6x1Cfb/WxhH6dwDROpt2vUZLpJ+VfnvasAgo0kAZ5jadzWNcKxxql8RmNDPk8d4cHQNcjoiK+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRvCVxdQ/8dLf9V+xSxicXlGx8Gj6TZLFytPgUZY0+LqAHagTL
	vTt7tnkdbcYDKnQOdJdxYao2B2cnjD8oxjY3DEHe1gxqG8hCusr6HGABS6N6+7cznFcaPtrUvKj
	A
X-Google-Smtp-Source: AGHT+IEWRc2j6bG7NtrBwrqjdEIVjwyEUnvvDO8Xs+c5+ba5zr4uxhAk5xGhq6A0cTdDDVSpjzHdXw==
X-Received: by 2002:a05:6602:60ca:b0:82c:fd13:271c with SMTP id ca18e2360f4ac-83792cf4b2cmr1388841039f.4.1729003202534;
        Tue, 15 Oct 2024 07:40:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecb38c56sm333771173.97.2024.10.15.07.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:40:02 -0700 (PDT)
Message-ID: <dbfea7a1-dda3-4964-91ba-36cb25d8ef50@linuxfoundation.org>
Date: Tue, 15 Oct 2024 08:40:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/213] 6.6.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241014141042.954319779@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241014141042.954319779@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 08:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.57 release.
> There are 213 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.57-rc1.gz
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

