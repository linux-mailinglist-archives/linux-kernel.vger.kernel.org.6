Return-Path: <linux-kernel+bounces-240328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C73CB926C40
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66EF0B2185C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CDD194A56;
	Wed,  3 Jul 2024 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ab/w6AWR"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6C17B425
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047889; cv=none; b=qqwOFrygDvaY2sK0jj1YSq/m1yhfeaUp/X1zmcpgP4WXszY8qEcNd1oZarVMESaINqH6c0OrY/5my8HMIuM5kjIn/NB7PxHH7gp9e6sVHtnImNBe9QoQ4G851F+eNepOb+cFf06KtQMVvLR7z947P95TrWuKNH39bWSOcDsDmoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047889; c=relaxed/simple;
	bh=XAbTDSCiuix+leu4nt20ZGL6CGC5tq+OVyQUmfdwLc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u93IP/rlMQQZtNNCFFdcf/M/r0FnCuc+xCNcI78kcoc3gjkxgwMUd0lV4hkvGSIKEKNsCK8ISN5qCXXNBFdg3jgYAOKzXYbQF6jyc2hi5KcKcBvPpWX1rDsVfdKGiClvrt/ul4LBXYndmksTWQ0al1ze9KsonqDhEkOlZRMp6jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ab/w6AWR; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3745eb24ffaso36465ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 16:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720047887; x=1720652687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1Gw0ZjNIkvjLQEAJl32qrbP+mBtuKKDlcaDQhvoYrY=;
        b=ab/w6AWRETOw5I0eBH0tEUfrBOvsTjXko/GRjDB6kIDA5RlnSRbt3TX10+UAaMPZ3o
         OdA9hdw5ZkkDjnVO2wDYnkveUIjfnS7ERl3W6dH8UsUSOzOqULjC5/YQVLJt7A2mNKhD
         xWbKeWs4TGRSJI4jPtA43JbHtvhT+PZLayQC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047887; x=1720652687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1Gw0ZjNIkvjLQEAJl32qrbP+mBtuKKDlcaDQhvoYrY=;
        b=o6zYfWdAtqjK8eAlFPBLCjhEn5YnDoDbj4+qmgiEFw69Ze/SZaKoWn2WEh0lIoFnQa
         unp0XjHm2Uk+VmAA+z2bteVnrA1bJvW6MbyE5obHQRnjDuoJysehQpnhINATJvfEvC+9
         eR7rYu17mTALCuPrHLYVHh0rbEytpDLfPyNZK96PVZuVVgBWSPPAFtwAQKNL+NXOpqLE
         ON7lOiIU1CqVXtmozSIBe2+ScAzdgJ/P/+FfrDkDR89OoVI9QmlO8kiQyLIQofqhLqNW
         SEekkY8kcYs8n/sCXpHGx7TjRo5/1wNEVxe14wxWkr0nFLbvOBxNMAwsPCnRLwy96bfa
         4FFw==
X-Forwarded-Encrypted: i=1; AJvYcCVT56hI23xCfNQfYZ0efqtI0pq4qbXXRqUNoub81Pl0JLf1OwD7B+Rfo/9BHSNbSSevhSvcXoBW3uwTbOa9XtqAyT9IaVXZR3OpdD75
X-Gm-Message-State: AOJu0YycWLqGmWCZ3RU10k5HGPM+4EcVrDWQphpBZkAzTurLVKQOnYvj
	flVHUk/OF3gd3cta2gpVfs2/ob6ye2/HvwezD9+zqBMVWjCYsc8etdCOi9/ySYw=
X-Google-Smtp-Source: AGHT+IFDVsmppcbGL+gnyzISDited4s3wOkjFHvBfz84LQnxxLISKA0y1gljgdxrjb0h8+8a01JC5Q==
X-Received: by 2002:a92:c144:0:b0:383:17f9:6223 with SMTP id e9e14a558f8ab-3839a0339b7mr882935ab.2.1720047887367;
        Wed, 03 Jul 2024 16:04:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3838f132c29sm342175ab.5.2024.07.03.16.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 16:04:46 -0700 (PDT)
Message-ID: <c8721a72-17c5-4619-9128-9260214ad0d5@linuxfoundation.org>
Date: Wed, 3 Jul 2024 17:04:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/189] 5.4.279-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240703102841.492044697@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/24 04:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.279 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jul 2024 10:28:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.279-rc1.gz
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

