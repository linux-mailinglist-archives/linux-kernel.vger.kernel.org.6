Return-Path: <linux-kernel+bounces-431662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B89F9E401E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F6B2837B9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABCB20C499;
	Wed,  4 Dec 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OgCO2ob9"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185F20C474
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331193; cv=none; b=m0ZJMl4LfM4hTHji+9PiWxMh/+4uS8s/e2u5Y8et+NbRQKlawTx64r8VSuAmBocki890yHmMnpkyiFzQZfRFQzhsu2ztlhiG3WKH7EnoFkG55cd3etRbJMoQDMUvfCdUURgwla6VTNGLQGc63d+pnF5nBtVJZdVQHGCK44j/03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331193; c=relaxed/simple;
	bh=Ps9s7adSYlhtclfFUDgzrRDE3aRhsegiFXOsPBfWzN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEgFAp+GWfnyTl6wQfc6CBfSyzoB6phcuEvBEYDjsQCONAhR2wq8ebR1ZUyG6IJ1FaFEWBS34UJhfvmjmemrDp/i9PqWkGVSrxG2MUMiBdPRriL0GidjttXgmFSy3F+ib4fD2irwtR3JPL4XJ/npZ8vbNVCKxSMmX55K8gNQy5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OgCO2ob9; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-841aa93433aso239172039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733331190; x=1733935990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWcaZI3k3KA80/qPmq3Cb8KETFjDnLzZkyHlk3Sthqs=;
        b=OgCO2ob97/6VBquzDOD15U4DmLpcgEPWDWd3WlqCpVcKVU5VnuwKMcV4Ghp0m3w3Bb
         a4TUaVOyGYI74F9wrnfvpungeJS+4F/7Rndfcju37SAxmrGpSlllAXSINAE5RROO5k9j
         y8KateVc82vmlihfZgZmeuZUVu34vxFjya+tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331190; x=1733935990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWcaZI3k3KA80/qPmq3Cb8KETFjDnLzZkyHlk3Sthqs=;
        b=t7EflgFL+sVPchJrZ+FaxL61/Sv4Ww17LkJiXEGLZDP3SwdZIyu76oS/7zM3nSOfeW
         2hNy3Cj2alwjJkjw+PEgt9TUa81Iv1ZfJK8IYb7jQcRcgYCVvJM8rCAqh/gKLR2qkbkp
         Q/zjnDFaEvGc/S4LtRFWxFl9gfsGjg9ILmyZ51pqvfTSVBAUX1REwrbJeND117HBsnxf
         Msn+Q9e3ejYl4YJYYPU/VM3rJ+rezDCRWNK6JwEOqfRd2CDdhDYWGkAAqzBKTywjtkq4
         gBl9KbigAh3Qg5O1IJEcOUe8JjC2aJGzt5x9Ku95i0ElPp6ilAKP0LjNwws5z8KBpVK7
         2iuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh3ZEn+TgmXoNrKOkftBj5Kj7dg49sSkXNw9oSFAlJ7Ecl5c+ZBANqC4N2E46Yx4ykB1KUcqcg2MgjB/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwanFQqD7Q7GFi6vAgmFhQtpS70oLpyf+tq/evV+u/Y/0oPjFG1
	PMn5RuJfhy43/wTMrxp7q/oe6WdlRtMTNLzKGdY5/aAgLMLpdkDvYHxxx9X933U=
X-Gm-Gg: ASbGncsdj3NcBLHMZyR/9F1qZTwkMzXL3i1mChBcpLDQGe+ADIxftWjwciTj+GWwGvq
	VTBj0rzv7N3p8hNLdbIA/mpe4N/NvbM2lG2Svq3FLkRrAPA31nWLTN09z4RCFrlkVXE+HD4W5rL
	NuHxBqvRathXH1nFWqCS+N/JzxJrDvYg8cKIEFDtuthLw6J4u0tgOnOs4j1edLe098DfEqBamwf
	3JiwUtY7N3NhWMfUO+6l4UhcVmNoH3oGdeY/9ZGPsoKI2I2ZiPrGf4YNbbXKg==
X-Google-Smtp-Source: AGHT+IEA87B1w0H/p+dtmlOvBnj9D7/7N3X7qqndW5CFH7T9gJxVsQjS87Kn1UsygAlxcq0il9aDEA==
X-Received: by 2002:a05:6602:1649:b0:83a:a305:d9ee with SMTP id ca18e2360f4ac-8445b5cb7cemr763081139f.12.1733331190410;
        Wed, 04 Dec 2024 08:53:10 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84405d1128esm321665439f.0.2024.12.04.08.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 08:53:09 -0800 (PST)
Message-ID: <2ab51fd3-2fe3-47cc-b692-67f9dbe87513@linuxfoundation.org>
Date: Wed, 4 Dec 2024 09:53:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/826] 6.12.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/24 07:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.2 release.
> There are 826 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 05 Dec 2024 14:45:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.2-rc1.gz
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

