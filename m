Return-Path: <linux-kernel+bounces-375220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57629A9351
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328E31F22D90
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778471FDFA5;
	Mon, 21 Oct 2024 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dU3avb9D"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D4ADDAB
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549759; cv=none; b=CnQASjCTdARYKzKG+kFKtzFX4w3AnJdKbngPrv7UbZa+pn1IOrNieukiMF2PfGtpWv6OT4emyRkHt6HUC8Dmev+WzdAwmoF8jmGNP3Dt6UQ57E9cW3KioDGhd0PyTXqsubT0rzlQ2wd4uaBR+2M6725brtNCsm9zjImQT+UoE7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549759; c=relaxed/simple;
	bh=DK5cAoaLipLQJ1Qq11dmR38yV4BdPfJO6Co5qz6yZms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjhNkHbGL/R57wQRAoEsKxxeKPQtr5ds35kyAvQx1EmMXwMLhTAadgxxSwviemS1XW5UM4N8VLrRaAKtNSMDuWQfExBC62RWmY3mI9IPpvNtbPgnv5qDb3PkLX9NlVwfh/bFVq8imMrFF7eIUMgJgrnYe8jPRJLXohJAKbiRB/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dU3avb9D; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83abdaf8a26so127615239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729549757; x=1730154557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TA4XM5hTiGNOd+KQ3u3JDVeWEwmpgPZoFJVi0gICoWw=;
        b=dU3avb9DlJ5lt7m1IhWT0B0X0PRM9XWtSThrVY1rHd1jwO0XBOf9wB9FeH+eAJDzcx
         YERoORGw2jyZ0afLaG0mNh2tWZEfQCVO9+u8nEBwq931ZsbTyU/cuyhCduzSi2GTKz8b
         eiA9OSmNgUOqTlKFLuAO4SX1eW73ANAHLszPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729549757; x=1730154557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TA4XM5hTiGNOd+KQ3u3JDVeWEwmpgPZoFJVi0gICoWw=;
        b=wB768+TGDz3Jx7DZOMWf7PZl5yEFtCajSxscnlwYFbFmzfHKDWdqdwciYnihE1dK2y
         y5e8q7IhBepSUKP0I4JEznCRF5bVjkwWXpie/DVRHbPA0xTEefRw9LT5HQnrKdBu3JkX
         W0O3LYIigttr5VRTWezI1lD/EpoY5fzL4Qv/UWk0M6rVpfdkIugSdiXSBhByNtaDxexN
         cjPDVDcT13m9vfN8l6Fqy7RCCijNyrciyCF/TURWMVxhp4e9gzAkX+Z/60K5l6EQoqhp
         KXK+TBosFBxgeoePz7oRzPjOd0zfg4galPo6THVW0PJREGnMidQ5/5Gw3SAuW/umwT3v
         vaWg==
X-Forwarded-Encrypted: i=1; AJvYcCW118coVq6/OKXYXmn5bM0FEoUfdmowxoSXOdMbZSv6KwCDun9LNZQtsScliFrN6dLR/Its5ANFsqkDyho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXTibeUgCfcmNq8Dlmf7vCOr4lWl6GsDYFCLJviLeolELpl/JR
	Rj0cT119ctv4I+dxqcJwF+L14ZAxlta+bWEDDU7eK1tdGfumLSWJb70kSe+d6wA=
X-Google-Smtp-Source: AGHT+IE+r2Sv2Vi8956gLES8UxPVDLR8WmGuc8PVr3WktKjFjqRF4T4ZtzxG0LU9kkxugixlftUMTA==
X-Received: by 2002:a05:6602:6d16:b0:835:4d27:edf6 with SMTP id ca18e2360f4ac-83aba5f2764mr1039351939f.7.1729549757368;
        Mon, 21 Oct 2024 15:29:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a60947bsm1235916173.116.2024.10.21.15.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 15:29:16 -0700 (PDT)
Message-ID: <6049fc80-b936-496b-b1d0-134de9fc19dc@linuxfoundation.org>
Date: Mon, 21 Oct 2024 16:29:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/135] 6.11.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241021102259.324175287@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241021102259.324175287@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/24 04:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.5 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
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

