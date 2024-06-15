Return-Path: <linux-kernel+bounces-215657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC40909595
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340421C21384
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72FF3D60;
	Sat, 15 Jun 2024 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C+PuG0Ni"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36D2749A
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417459; cv=none; b=TVMWUU1II/x57dPmn22VnYrUNhRHBpmBjObwG4xBuI/KXCPf1hKNROaWejmr3qbGorwqDxfSCWWYbD5TP2JY68ClUkJwS/I/L3sCQ0PZSjrQUXMT0XLE8Rq6TiTV61bRJrUNwJecLPLXKZH9LIiZJu84gyGqZWcxUQgMF1RpOiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417459; c=relaxed/simple;
	bh=DXmInziqCWKjxJpwpBGulsCPWOKNAr5TIjnc5FqxXlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/rCPQe3VZwXg//J4nHZiczIasvfVzWUHLi6c1bfnb6po0tHukXfE5rydBoN6c41J5sBL0lbsMXCljluBTJ3MQdubbEq/JRfbhXfv408J9oufezN4d8WYK9ICCrYO8XsEWC6gScF4zaJWw40CeLCmrpzIdw/gtNsyga/VAXKA1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C+PuG0Ni; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7eb85332204so11218939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718417457; x=1719022257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3nS2v4qoTZtVNGX3X2MEYA2M4BO3FR1NxPvnOGys6s=;
        b=C+PuG0Ni5W/dS6RX3ATdjZ6v/rBu4eCnGWz/29IPPfKEWeCf6oJDHYq+MYmr5mG7Pr
         vX6gOUJM/dVDAZ5jNAN5r5MJLzT7pQCUFUYSCpgEye7f+UMpyrpIoUNMVa9JeXyivUoe
         fHn/z5nalqCpj730f0IOYO6Ss7P3voUAeJNmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417457; x=1719022257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3nS2v4qoTZtVNGX3X2MEYA2M4BO3FR1NxPvnOGys6s=;
        b=r+r6M4O563tQYtzYkKcKFjwsZVhV9VuBdg8q4LHs/XY88UQ1Qv/Txt8d+9qihpfo0E
         7oI5UEqqgN6LY8aTtSN/9kU/35thsToLfw9Ri2T8TpIr0+CUFmu9+nhyfzfEeluc5+uB
         zZTCbwtMVJXYYJ0u/MExcKzjUcAMnJemwHFY92h4SniwFrWRbSm8hZ1RcShHM35Zz9DH
         vkmKW9lXQF6h1AK8pVa8j7RHEHFvHvyg6fnDsa7n/I89SzIDl8wnOh6wb3/RjN09Xw8y
         hVoq8t2gvwMipLttNuaOd9dsc4RqsgDJGWhT+p50ixp2OKfviX4wHBmDa/bZl2eNdI63
         pSsg==
X-Forwarded-Encrypted: i=1; AJvYcCUT/iBrHQH3Z+dVewmFreIkLatpdCpCBSS9ayxvJ64Zm5PhqSnVC+lY/0Ll9OQA7Rva5zO148vRcYOucP0EJ3Z8oqaCntbj75ZLIPRQ
X-Gm-Message-State: AOJu0YzKhp23bwholYDoyB+uw2wWV1PMZg1tp5/yqnX8amxVoTvRmTSI
	tD+XE+fx9XTE7L8Y0DgrtJ15Oz0wa3CW+gtzkSFKRnDQwItQ6/eMnsS3lZUf1R0=
X-Google-Smtp-Source: AGHT+IEkZI+trr+spMpD5Uhm6wzSPYBWWnpmmtC5NW5c990CTvY6qKgFjfD2kSBCOb6xgmfk0p/i7Q==
X-Received: by 2002:a6b:6b16:0:b0:7eb:730b:f0c2 with SMTP id ca18e2360f4ac-7ebeaef9959mr402719139f.0.1718417456900;
        Fri, 14 Jun 2024 19:10:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9569ef5f1sm1199962173.114.2024.06.14.19.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 19:10:56 -0700 (PDT)
Message-ID: <0aec1473-b16b-455f-a8f6-495c424d94ad@linuxfoundation.org>
Date: Fri, 14 Jun 2024 20:10:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/402] 5.15.161-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 05:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.161 release.
> There are 402 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.161-rc1.gz
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

