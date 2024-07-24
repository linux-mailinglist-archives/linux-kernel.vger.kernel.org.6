Return-Path: <linux-kernel+bounces-261162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A5F93B374
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA5B28321E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2489715B122;
	Wed, 24 Jul 2024 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gTPELX4i"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF3A33FD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834155; cv=none; b=H0Rk9667BqaIOQ2gP9by7+I359ijtCvaGBH5lpdR1IvABJBRkujdqv5GeNoJFv+mjYQpcrxil5079F5qO9xF+UmTue7Sri94nb20nC6ZeVrCzAFRnIcm+raMVeKcpXAcUAtF8jLHqhiNR2Wtuxn+cSFPxtauzLA7gpkpPs3rQtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834155; c=relaxed/simple;
	bh=lGgGD/+IXoF0KJnjpTmdRSHZSZlZGVyJTw4PkaUX1kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtRNOWz/i01ZSedRNUU57m+QAH1mK6IocMr6vYvwRrY3f1IcRAjJUjNl8XbReV1kUxfe9D1B4JThNRLzFVZqimad15AFHvFG0ojs3Tb4QVVWJ4mKIT05yZw/evD7sNddyL8HE6Nyg3nGalZl2+w5DBx5zRk651Lu3cSHJGdA7Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gTPELX4i; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8045e14c32bso37161139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721834153; x=1722438953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJp2TIbNZjY641ZWwyv7gFm6PT+jwbh0kxK3G/HVx84=;
        b=gTPELX4i1tZPar38bhuE7d9TkaYc1mtmElNgaD3a9ZH3Nb93h5xzCSWTbaVLcG+TeU
         tWVoKlOvkdSF89Msqmg2U1a3airdPoilT3vGxerMoNnzARPGcBuPFhGyXnBNMEHgpR/J
         mvf30L7EnlLAri8+6FANjWqAWqcbVvTbmUo4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834153; x=1722438953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJp2TIbNZjY641ZWwyv7gFm6PT+jwbh0kxK3G/HVx84=;
        b=m6l7KJmNM3VETG6TNx3d4HkajnxqPJO+SH2PrZG607l2iqNI0d+TX2hdcl+m6SV6Ao
         FunKw+6sm5GPoxgeV2qyncp54ffrWsJvbCNlmipdihooB6Kxc6OqT9KmxOxHNqdZga2p
         OlZPS7p8hDm4mAs/JlAVOnQqsEbi2m3s8sIaCb2dtblZCVdIvEcWAbZIj9AtkdZJovW4
         vpdNUi4vsW/CwlQXHw5tIKjfXyEjPst9GBfiuL4htcv3lfPWsRoOVmLk74gsMf8pEcSv
         5lbdOnq1lXt4C+AJSJ/hTlct6ioi5fYtGtxjR1tSXfEjvXFQzdUoDzpI+0pbwqhuf4uk
         nCUA==
X-Forwarded-Encrypted: i=1; AJvYcCXAWVCXk4VqEcSUXlvpTb4sSE4y469X8GG6QRaHjRnZqWaRx+jvFF2WS03SPJVfpRD50gSa0PldBg6U8OEgUbWOe6CQHxpdm3uSDvQH
X-Gm-Message-State: AOJu0YxpX3PKEUpCFt8AuaxyDlwXOqGPAOfvVlD0muy3uSETNOp/3OUM
	geuB0B8n+x4zuEveVn3Ap7+Sb7o5+GvoGQHlFhiSIVZE+ZKgQRfG7f9Y218JTY4=
X-Google-Smtp-Source: AGHT+IGRiqaTdECn60Wzc2HMFdnCkr3xP7fGAB/QUdwhu4VgXpKSeXIyj56FGa+6ASLRBRNOfcJT4w==
X-Received: by 2002:a5d:9f5a:0:b0:803:f97f:59e1 with SMTP id ca18e2360f4ac-81f7bc78dfemr14099939f.0.1721834153091;
        Wed, 24 Jul 2024 08:15:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c28c93321asm434572173.87.2024.07.24.08.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 08:15:52 -0700 (PDT)
Message-ID: <f9c063a0-f575-49ab-a5b4-f3b32a6cb486@linuxfoundation.org>
Date: Wed, 24 Jul 2024 09:15:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/163] 6.9.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240723180143.461739294@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240723180143.461739294@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 12:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.11 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jul 2024 18:01:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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

