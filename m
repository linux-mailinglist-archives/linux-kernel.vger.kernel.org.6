Return-Path: <linux-kernel+bounces-399263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864D09BFCCA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B878C1C214DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F61C28689;
	Thu,  7 Nov 2024 02:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Efj76vEP"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D583FE4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730948214; cv=none; b=oShnoQOZg+1HjCT/xaI1gH3ewS/D1YqRWAAxdNnUida0ZEcwhGZtBIvnPSR0sYVO+r7Ekf9tUuzgXaHzKJU7xXz571y1sAjQGAs4/7kgeureKpk0Ld2aW25TxVq7HBhpiW1sVBxoUAjNK3U7ruzq5DSXr3sMNzCdEZjuc1yn+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730948214; c=relaxed/simple;
	bh=iU8Yq5U1yq8Ri6s5bvf1TqjnMP7Fji6Q8Voe/HqPewE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dB9bR1lmRt7UdrHv6ppEZs0V0M76cFE3rO9GyE3/OlAkjKV7w55MZ2+ZuXd/HSZfD/AQNmwd3lelCX1Lf/O+Xhb0ayZd/0iQm31aAUj79xLUf3AHEAzntLrZM4tAqaHca2dzwNckSWFRaFR+jHF5GnZew3fKlX4H3YrdCFxGXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Efj76vEP; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a6e960fa2dso1198645ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 18:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730948211; x=1731553011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDxrDipU5XMaVDAVRRPsfjldbqgDYPtJ2JLlKFXqBUE=;
        b=Efj76vEPf6uBk9ywpaATbQPscq2KzIAS0A5u0jQ9yJK1tOGjh389qePAbkjkzbkM9E
         wBaRJ2UkeFqksPSNqVadxc5ryE4Ih8DQgu9EKMRzl31RnvP5nQ6GPDQiSa6n6maLx7T1
         PafvxTYKWDW2ajI33r59PjLnpn9OK2sIoTHwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730948211; x=1731553011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDxrDipU5XMaVDAVRRPsfjldbqgDYPtJ2JLlKFXqBUE=;
        b=u7qor6eS7L/bCLYG7KB8/nUbSvlIt3ynzYWa6pAKABJSKRuEjC+kiNFdHdTWHHc0Nk
         aQRaZAcvxdgpsoSvJOgYJUh9jl6jZ3rdCzfVODfo9QyA+7l3AByzRcFKuEFXB2oPs1ET
         w6EoR+c2UuYJh7tV5zYvM4LPrwQQvT+EeNVmig0pWqz6GSeruHFf+zKVWct1aS1I5Hne
         wfFHLTA8+FRnqbCHqaGGlRlD1t/+Z+DqzPXp6x0B8cU8HycYGOSADrXffpye3fE4XSCO
         op+f63I2fW/TSgwpAfjxDlPW8bQP9ZYRrwB6BqKKg2Lf4OTLCxSnkL3Wb1aWGPIFnVY2
         D1ow==
X-Forwarded-Encrypted: i=1; AJvYcCVBdbQnw713pwOdsSb6h8kgmVl/H9MIsVfMh6tpHhauepXkTSPuBy2WLpBJ49gufGMo/lNXkdq4LQovN34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3qak+iRaV/yYHT64MCRTrrJ9n9TDEX90JR4oIJllLMhYDPW2
	KR8a+5IgoVAVKE/jdmkTLF4BiJs5pVkOPUfQrgAU1v3omJB4CZTadFaWkZ/sgmI=
X-Google-Smtp-Source: AGHT+IEpTwgqbmmSGMj6ZEB+fBjuiRqUjPz3WQrIx5QDRQA4HP3cesZ8QbsAhbbYstiP5zNb8jiCNA==
X-Received: by 2002:a05:6e02:12e6:b0:3a6:ac17:13de with SMTP id e9e14a558f8ab-3a6b032b298mr242523505ab.20.1730948211539;
        Wed, 06 Nov 2024 18:56:51 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6eacc066asm817945ab.40.2024.11.06.18.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 18:56:51 -0800 (PST)
Message-ID: <0e245d12-c912-4262-8e4e-bf3b4f4d6c8a@linuxfoundation.org>
Date: Wed, 6 Nov 2024 19:56:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/73] 5.15.171-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241106120259.955073160@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241106120259.955073160@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 05:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.171 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.171-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

