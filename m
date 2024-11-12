Return-Path: <linux-kernel+bounces-406848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A240B9C650E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596EB1F23E26
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8961E1CDFBD;
	Tue, 12 Nov 2024 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F5CurPFv"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9EF219E4F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453743; cv=none; b=nmb4r1JD5Hq+AXEdhRPc+20SxTbuXLIdSBaTVOTSB6IvcEpks9msROgGHyFbSRZUjJTA22sljjSgimV/NdtO9ptFt2s/atzGS90hY8Vefl4IYrXEYSeOyiOd1IcoSbSEW5sk+XT9IcqKl9lgQAAlpLwajGUuF43/xS8S3UIqbWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453743; c=relaxed/simple;
	bh=NwNK1UsOIIOnZPELwasBAkKZRpPZYiIrk9YgjeocQgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4BZJbPKQKbCsSErSXnS33Bu9AfRQvSD1JR5/pwIXrxZ/5h3LZ1gFKuqQHSCtuWBHzFD5ly8LPiRoyOOqCYxG+16HsKDnhXRnw49iM+O31zhpZx5LO2Uz243MzEHuLJeyBSlUU8b5D2mzoPl2414tEw/LiTlMilgC089kfLVkb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F5CurPFv; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83a9be2c028so216410739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731453740; x=1732058540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3i82h1dy+1mDKQLcjx5GEyyInNzWC0fLINk9aH6mkU=;
        b=F5CurPFv3rvt9NXLqQsO3Rrxb2J2brmtqVVSH09vYcxNOh+uafkpa/WIqJs75+3XRA
         gaaVhUZLMqI4gktZ7xAbaGxnj2PrUFBWo46DITH36TypuW94Ece6ljov+2lC+bXB9LZS
         uuqXXVYu3a2vlpJFIRC4sUHBn4q1iSZSZM3YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731453740; x=1732058540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3i82h1dy+1mDKQLcjx5GEyyInNzWC0fLINk9aH6mkU=;
        b=AcempgYqCE8JXPUUt17Zewz8Wq6AhZ+SedNPHW1ovMvNgbvVwqE607uGIvKWMp7Hd/
         kibIjzl1kljTBKKzn0uSqsxwQk+TBFZ6LmewUYChaa6zawpe5U5cGWcmVxQnOWVvie9I
         q4q7qHFqcVyxzAPmEUhCWt6aMtVfLYUi3vtErWyvP9iCVYNLvwQ9BgAEWjl+iBq5j3H2
         2HScZoB+HAxPkAWYfWv+NOiR9CyJLGq7TpCU33+ZL0ghF3PHZ7OjPILy7pFVyArVNu3u
         9y4+9LL2iUgsjg3+TMvDXni+nPCirWeky7Q2wCexxWeVK/h2ttV1n6zC7Q0KDBGfouVV
         F0FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlWtyHNpcdfuwYCq3pQQrkQKP97+p8FSx6YcFyCAh1vZEL+K9JnMaMwjH4FaOJNda2pIF8IZ6VQ74rV6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmlP4/98tHDW82Zkz1fQ0mGJYYzIjwOXNANgTugo4gWbmlj4h
	9sxOxdOTfAciwbooJVOvGSFHZA3S8ekZaCLbfmYRtrE6Hqz0L6INfcRmKNE+OEI650/m5kzG4tS
	J
X-Google-Smtp-Source: AGHT+IGzLKzOi3wnDvz2whiZjf4QgSZRq9izE8vIf+zuB7DErCoKskY2TnTwp9Uo6MfHt5B8jPVf2Q==
X-Received: by 2002:a05:6e02:1849:b0:3a3:b527:e809 with SMTP id e9e14a558f8ab-3a6f1a256c6mr212414795ab.14.1731453740488;
        Tue, 12 Nov 2024 15:22:20 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6f989b2c7sm24784755ab.79.2024.11.12.15.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 15:22:20 -0800 (PST)
Message-ID: <0372fd67-2f79-4b80-97de-e149bfc533ae@linuxfoundation.org>
Date: Tue, 12 Nov 2024 16:22:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/76] 5.15.172-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241112101839.777512218@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241112101839.777512218@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/24 03:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.172 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.172-rc1.gz
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

