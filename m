Return-Path: <linux-kernel+bounces-180333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EC68C6D06
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0662F1C21338
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E3015ADB6;
	Wed, 15 May 2024 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FBHrmERa"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7381315ADA7
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802894; cv=none; b=ovMWXwXP/oH2IgBBkGyWXp4l18i/fyxB8uEI1Eqs4/oVEAdHGnUfHDIXumFbU4xyVpTcp/IE2BlqNLbX0XkFmERvGoegTAHZM0BTl0S1/NUqbydUYoH7VLRS72+Ub0pnM2O0nfLvm3XpjQHr0RIeoVjejdmCSRoTHjuJJBCGrzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802894; c=relaxed/simple;
	bh=RpY1ZLIWGoaTSG2trt5v7gG4sxt/2eeLMWhzG0YEN0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wkc3CR0h7y8hKCyyHwu2q3JIkgE7cxJY1u65D6DkuNn7wl4QLE94+6IJwdSBrAnPl9zDBDyDaI8chNgcvkuZs/nY+seDmRoRi672b0oUL7B/X4EB4AZshg5gJEKML2B9AxCm3hrHRrCTwNeB357Jd6fJb0bqKzORfqOlQwCokPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FBHrmERa; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7e1ba5f5346so43126739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715802888; x=1716407688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bl2K9Oe3kWb4B4ZrUWnPsSq8OrI5PV1sUFttZ0QWN3U=;
        b=FBHrmERaPo3bslvzJKg7CI0QF9sA831aYRUvcOlOwqlVts8d67bRFDkPMYwKuIrPaL
         2heF2L3EY4mdz6UHtgoDEaB5oqVxnwKmw0CzHbBwEvIIwHK4u8B5ZB+TeVrMPsDMWyFS
         YRF0SprgpWhhD1cs8y8hY/lTHtzY+Q/ogqRu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715802888; x=1716407688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bl2K9Oe3kWb4B4ZrUWnPsSq8OrI5PV1sUFttZ0QWN3U=;
        b=AMMJzL52uHO23NWcnzKtLdicuYrv0F1TmEVb6jI3HVgD3HN34LqZhedbwvoRRgSfdH
         7IgSpV1saK7qAgMwp7l9nCqNizTQH1ZpIifaCmc60zCYlloW1NuLf1JXUFw/ermtUo38
         BW9atWaphcWcqFhrEoKNLzgXd0FpefOUMz4Dw1/soPTyJHnem0NVRQmRBouVkOzmUdXA
         +/Ev6p7bTN9LyVnW/Rmg6V6Zfxe+DdexZMfAyNy4+V7P6QJ3PtuyofgY5BKYFW/G1/nQ
         nTS52WCD1oBwCKJzW4mpbeEN9FdKt3V9NVlGrmZvnn7ZN7JBg9oWTavsyn1wl5/KluK0
         GP5g==
X-Forwarded-Encrypted: i=1; AJvYcCVfkdPy1yrGAT1iD/++CPTBp7hyg9BwFuE8oyQv/sheHZe4gyDAQZH7e8+GFttDPlHZy2JJRnnw29IkNJcXPIRTISiSmNsChORVfBD3
X-Gm-Message-State: AOJu0YxYmKj8LVOgr1PnJK0uRykcrg/Wch3XPeksES1pnBgx9ic2xjkX
	GvmQ5GGLUGns9RK42UGCPbanCgbKqHnv7nssiRQIeOiOQq3/9td7D2VZa0VeoLs=
X-Google-Smtp-Source: AGHT+IEt+AFs1YP+RmbhIVtPtEK1Ie3e0g8AnrQnfralB4FlTv2dlK5IMdCEU/UsVRuCWZYJWFA6Ng==
X-Received: by 2002:a6b:d203:0:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7e1b5022577mr1766220139f.0.1715802888578;
        Wed, 15 May 2024 12:54:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4895841e9c9sm3311353173.4.2024.05.15.12.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 12:54:48 -0700 (PDT)
Message-ID: <ee899ee0-f3e9-4f61-b48f-ccd6efa28127@linuxfoundation.org>
Date: Wed, 15 May 2024 13:54:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 0/5] 6.9.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240515082345.213796290@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240515082345.213796290@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 02:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.1 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.1-rc1.gz
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

