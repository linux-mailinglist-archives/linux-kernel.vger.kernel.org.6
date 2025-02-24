Return-Path: <linux-kernel+bounces-530235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBC0A430E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A7D178D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7545E207DEA;
	Mon, 24 Feb 2025 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OqFrgjlw"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5F01F941
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439892; cv=none; b=M5KcY/WlijmFs04Ukp6z0i5PEu035j3q/1lKtXKmh8JzXMc8tgv/dLS3XNJ/OlNVq6bsxfjgz6G4GiYT3IvShXKAlEN5CF4IsbYZKvDOoMsVFjpBWHldyR55U6GScGdylWfCfJkonA/rr++LkjZlihf/Rzip3VZb5h27SSj7PTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439892; c=relaxed/simple;
	bh=F8UT4UMK4QmeAK+GaOuaql6of5z9HYtWyR13pd9pBfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoTdAcaw0o4k6rb0mBapzgqHm6STA1cQGu5M1AtnrQsxZaMgjvxOhRX1ze2qjPPKlVhX81z0g1jZowE6mZlAtDUyPjFPJu/6QS6wuzFfe6b2Onap7kVXxjIZZwP3zIaU3vPUsyX0pRSMiQE9401rOkgrO5V8jhbU8Y9nrRCmkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OqFrgjlw; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-855a095094fso132029539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740439890; x=1741044690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VuRSt/BHONOE6HTRUiUSM7fHedYhfmWMvn29Sp24F9M=;
        b=OqFrgjlw9Xb4nZaYtbvSN9xtpW6olF7J1pS9YKKO6sNDpfGAyhr/+Q8NNPxLfUgflk
         cD3RzBaLYszhrCstFEHxmWW8QhjQYuYpzsdeu+IYDBsKp91j3S+D5L9aLvfA4F99oL0u
         0dvJ9X5beVdVaMTXUjgvnpZ6bN/4lZRv9g1eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740439890; x=1741044690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VuRSt/BHONOE6HTRUiUSM7fHedYhfmWMvn29Sp24F9M=;
        b=tBnyQ2BS3x5ZuwFcW/EA4uctqmcOCwnUV/2ODNhZP2r0TYIZdPi/fFm9XteIj1S/Ie
         HfX2dfUKojjx7+z5aeO7FwH4zigp7222h7hTV6ryKzpLcMQV83EDgZ77zu2cAnWPF2hh
         h9s+GwUVGLVixAHBHdKjIAMwqoi0qBjrH6rZImpGLCku75DSxSmXOl1aHt0Fs00P2C7l
         XA7l9Gbsp4aW+tEMzBLdd+r40dGIczfCjYhBvaplT7JA1LjO0OuyTJkYWbFYhSgNbAAF
         P5q08Scw7hPc5S01vwce747m8R/w1DDxmehituSN9wqwIeOo4V7s6XypfAvO4jJg/5ib
         DIcA==
X-Forwarded-Encrypted: i=1; AJvYcCWMiBwI0c0iTjDDAsr+81seOvVq6snR124dF3wdj9hWE8C39W2ZPCXEWGgKr9hOI+jDpGuiia+rAgcbDIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUHRzEJJBHwIy7e3sLXTtYq7DXVdu3DLZaBkQfSu5X7zHsSuhw
	hQeX1X3UJQOK0W/t5PBflJ1852c2T04I1H4oqu27daJnGJ/znkmgXy9N40X6kg8=
X-Gm-Gg: ASbGncu4Jqo2Cj1jRumQNEHi2k/iZE5bbDDm8bYAwJTBSDYMKVETsVlPYGuN1DxDRfZ
	0ELGOxd/jG90XdPWNU5dsh3uKeqJCwuFFXdGRtgLRMVzy6RoOPydY/g1oFkpnU/yqhhUbMzjgNu
	rzoa9qiNOSCFAEV8Zz8Ve88rUOz8bVDO+c4lLBlsOkDNW2INgMaBhdQHkWXpl2O0wswkiZ5iMU/
	ndcpZF/s278NZM6wqfS2EMSSKm5UU7R9I0yU02Fk4gaASoUqrLqprNz9piNZ/emWZYWN2lDJDK5
	b8+3VAWcM07aqXc6jkWiYKs2IboH5l6ge9Kf
X-Google-Smtp-Source: AGHT+IG9gf7nMvoYHQuZUgZkRuJLv+urEXbaqRvetCRicjL4lLP+FRGp47rpDpRCVcbY4jajLs3q2g==
X-Received: by 2002:a05:6602:3411:b0:84f:2929:5ec0 with SMTP id ca18e2360f4ac-855da9be5d5mr1898313439f.4.1740439890143;
        Mon, 24 Feb 2025 15:31:30 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f047530437sm126053173.116.2025.02.24.15.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 15:31:29 -0800 (PST)
Message-ID: <a3c8ff01-c9a2-4d1a-b479-a18cbc510023@linuxfoundation.org>
Date: Mon, 24 Feb 2025 16:31:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/154] 6.12.17-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250224142607.058226288@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/25 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.17 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Feb 2025 14:25:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.17-rc1.gz
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

