Return-Path: <linux-kernel+bounces-215658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AAF909596
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2771F231FA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BEB79F0;
	Sat, 15 Jun 2024 02:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q5U14ZSW"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CE42907
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417528; cv=none; b=iYjnM3ULPvyxXxQhFQZKxeIHaMoy2woAbZPUHsFNdC1yMg0M1vnzikQYbrGmhnK2htANFcYauCf8ITH9ZYxSdqDVBG4oIxSPOWKKwQkiy8m15ODrPv5ltR9ytNFASHyOQzWcCrv22jHiqO+rTFpWxYFkzSMU2W9Y4CIXIGReG10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417528; c=relaxed/simple;
	bh=0HlJM+hydr0oOrnUYCARKSFLYrf+PRSlAOvsNC1aidQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGBTtEHxU3W70Iabw9/QxDlrME0iUwrEQgxWb3QJ1SKSs4MbfIRoni9KuE8bT/adZqz2BugDznn/iY8C5Km0RAsOAdLgBNw4gbTIQgkXBgrCJhOIfYPwZrjL+egu5xyYJxJJE2xNg7ry9Q4DR3NYvzInaH3MW7A2feHr7JC2b4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q5U14ZSW; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7eb8075db92so11393239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718417526; x=1719022326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=repXjSvFkNzm82fDUnLA+bN+roCNKUGFQOpyhe9n1Ls=;
        b=Q5U14ZSWOkmhZQY51QFytuuye4GDC48CnWomK7xc98uC823EUW1yEHETTtPN/TwqrF
         FW4nAbioiSBgSbc018qf0HxC1hTfmLVXNE6I8KDY4yGiKR38FURrXZJ8yZXOL4smw2Jy
         hnwBiUK/Y2YmxfAYo0vcy0GgrsFg6L6Rx5Wyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417526; x=1719022326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=repXjSvFkNzm82fDUnLA+bN+roCNKUGFQOpyhe9n1Ls=;
        b=iIU2IhWJUILJ/fKL7Q++bNLi8InIK+VlGzVjDX5M1n4iYveYGLH0uNvfRfGLg0xRlU
         mt/QYuz6U9CcWoBTbwiOUrvy5lck9M3AGh8oUcV1uQgYm80RsOR2bXhnOR2y4iEbaECd
         AzwCvB2TPhgCjHYExWAz6MXXA6TY0C79Q2nnUCLi/0vDfnLS+GipGeScUjg8rrljaDu4
         Ug1LSbqvYOMJOZe2v+nEkuSuLmKU9cQTfSA9FLiCFP9nUmkhxccrQ69dKVJsvwqP+r2P
         EHKHPt5N8OyaqaZsQUsF7TYto3lvWnKPWea2j4gvKhUccfyulzBKqqCIhErnMCAvPn93
         sSRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmO3vbJMtsxmrbZGjX9yv/fgJWEidpoPGtEdQ951SuNUGZ2Ss62k5VXiY/55i2AbdJJ0DMbOGshmIZ3eKwnZJ6QBwwpuOh4IHoWaIZ
X-Gm-Message-State: AOJu0YwM0zXtZdJbg0QnscDNWd8VAoLySBBMqX0VXJQ5rAuCEUgC0YdY
	vcHF5YyxWF9oSyshaQT613DYUyHRyU4AeoTqyzH2NQNgXJ+a1mAAPiBazXI2YD4=
X-Google-Smtp-Source: AGHT+IHV8vX1HkLcPFfAI9zvZrPEKUy4/PtHR2mGaJiFDLaW2MBRlldZ5Yh18Yt6TmCd9T7bkLfjmA==
X-Received: by 2002:a5e:cb42:0:b0:7e1:b4c8:774d with SMTP id ca18e2360f4ac-7ebeaef21e8mr435884239f.0.1718417526041;
        Fri, 14 Jun 2024 19:12:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956a1f7ecsm1226095173.122.2024.06.14.19.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 19:12:05 -0700 (PDT)
Message-ID: <d97e4128-7463-4583-88a0-bb7d2945036c@linuxfoundation.org>
Date: Fri, 14 Jun 2024 20:12:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/202] 5.4.278-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 05:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.278 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.278-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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


