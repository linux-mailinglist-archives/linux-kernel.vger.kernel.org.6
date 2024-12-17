Return-Path: <linux-kernel+bounces-450047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D34B9F5A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2024 00:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E800516AB05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773F61F9ED8;
	Tue, 17 Dec 2024 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QwwCpPxr"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3329718B46E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476804; cv=none; b=bzrOVN3E8RgLiv0pPaqnuU7wdxfcKIWPClNxvvFG6+5xdwIo5Ym+kOk60zfscSMQGdw6Ed8cxDIH+E9WO+gHdaDdkSJBNtztdhd1Zk+hIFgjOB/51mfwSbq282nJdHJdWUoEp5ywG1ghHPdxPPkVuAjL7GJ30gWzWg4x92tFtlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476804; c=relaxed/simple;
	bh=cR99iEt2Ag614J04071UramutW5hM1LKb9eLRFtmkOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bx8GWcB1SmKuqlVcMVIRlqhWt+jJse7iU9lKWQkvyawySa0WpPCs4qPFCvG0TnUsyfE/AaK0f9IJ1zKAKnWQ53suj0NewAHSALy7Ok5ozA7cAxL6NsK/0YwRIloLEtTIfMvSiORENlemUSAsZ7J9n1GxKUYiyj0cY1cjpTo3Hd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QwwCpPxr; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844e7bc6d84so7628039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734476802; x=1735081602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXfHXyPVex2Nr1hfyjAUCuTtuBcvIXAg/0lIIloW4A4=;
        b=QwwCpPxr+4gyl083rU6OoLHVvhuqMw7SbIl1nofJeywsAwkP50hEKS5FHLFVFdp2ZT
         SC0I7kL+PybGAEFioe8GhoZoia3aA5c2zTXLkCC3ppUE4iEvgDhYsaTv5kT54h+LxCqP
         BhkY4qRVpq2FCtAx3QYdcUoKgDkchnh5lTsvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734476802; x=1735081602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXfHXyPVex2Nr1hfyjAUCuTtuBcvIXAg/0lIIloW4A4=;
        b=AfwpmMBmi28Q7VHSQas3a5M8njJC8/Rfh+jdpgI7bYLGLvxCBbHJXprAoXG94wsXx0
         +ibi8HwuBiluTTMS7yjp967dy5Drbh8z2rvbSIaI0H5+uF0H0J7nzTBLSCt5r9GoW4jp
         owucRGrhQnCgmlNw+i4Q43gE27RKwtF8w4aIng5pR7iL0iIQ12ldRNJPDJz1izYtBjqp
         4bivYgYGv6jL0L9QVXMcqonOJDRwhZjPeq7SYqCyrsEkEmUAxhr+3i85bXgECbY8oCMC
         YqHsgX6MVD9sQ5o7HeRVrwgGQef6S1H2vwQiGoKW47sKqS8XyGXFajAZwFkde9IbgxBH
         e3iA==
X-Forwarded-Encrypted: i=1; AJvYcCUdTDprjhvSQMfaQvJa4vxpXSi4mLyX+5n+23Hc9PldpwtqBW5F/5BTZqxmw5BFue+WvCZm6drp4iTvfRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc2H0zv5JWv6Eck+MZVLMAJx7uqo/GT5sxpV57nVEbW/DI8wzF
	GPpQ/jZor+qGbK/n0oJ6lkmQapOZmMUid2oUcP+LzaGc18rbC4/3JP7PgMvi1To=
X-Gm-Gg: ASbGnctSKKMGRr8DJ+lOAHydSCVndgY32EL0PC290stqg9tZphNC1eL5hu+/VXfFSOz
	XEQ2gXtleVrmiG2VisSMLdDgXwgMxOMWuO5wGE6tlqNKFSAnIuRgylMYHWs4BxAaf+AJxBnwxok
	IxrnMoJ2Kxtk5KzPaGVXIqgH/GqMdom8JZwGhgQvp3gELrijEz6GvdjYsygy3v01rshjUkA5jsw
	bybKLh5GHoM0J7h0+4a0KZBy+EwTKrkiLPSk0bfMBRU1nx61hl0t5pbtfC6d4ovj67D
X-Google-Smtp-Source: AGHT+IFyxmU7yFCGp/RCq0l8NrfmfKgDtm6oDQd4bDB4w1nxhIj0cu9yqlIx/+d/pL4cpNwTFaiSzw==
X-Received: by 2002:a5d:93cc:0:b0:82c:ec0f:a081 with SMTP id ca18e2360f4ac-84747e081c2mr438079339f.4.1734476802401;
        Tue, 17 Dec 2024 15:06:42 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844f6239971sm188469139f.10.2024.12.17.15.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 15:06:41 -0800 (PST)
Message-ID: <644fc4d1-9438-4f0a-92ba-d1e4f60e6b84@linuxfoundation.org>
Date: Tue, 17 Dec 2024 16:06:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/51] 5.15.175-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241217170520.301972474@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241217170520.301972474@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 10:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.175 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.175-rc1.gz
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

