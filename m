Return-Path: <linux-kernel+bounces-355941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C988599597C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93060284B89
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2621503D;
	Tue,  8 Oct 2024 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MnWMHDiF"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2754D212D23
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 21:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424728; cv=none; b=WATwvrkuMo9EcRZYhgyUW5eF9R+kiSSQkG8aEpIXUShRFx9PSwS45/kSfScm2jj4cYHGNY+dlF/6AR7gMJI+ooVB8sJBfcodOzqtrYsgzEHKqOBuX5bfjnNMVlbowclHRiCFScxEyVa2MDS0PoqiT001MRZPgKiaV5C0INeAEIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424728; c=relaxed/simple;
	bh=BDDiSW9BBX6xnOUh7/79lZgysI7A7Y8so7jKZf0yTV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsnrZ1m2F25zzGqbG4w2ZrHDEEWpYjj3lr/Q7CaB07gNXZRC0b7NrWmK0Qn1to9n82Pv1MeUHnDnz5zGLBfticqwV79KrpC+4CZ5MNaNacANG7x1xdXeAQ1SPTcJ5dRruoA6nVYRdQbYaw8t0XeFbeB7McxRW/mEDgaqr1Pp3ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MnWMHDiF; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a3938e73d3so3004445ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 14:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728424724; x=1729029524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4S2vT+XJ6lAU0O0Dbvl1xT1xfiGrVvJLydXOgnwn2gQ=;
        b=MnWMHDiFx26k/dK/gWfxZP/Yyudu/dlgANhhPzDR+GEnu5iEouJqJqIgBnjMcsJNGw
         /N5YEZ6nuw25xjV4CLae6VdAeZFI1H+tbuqQLvBdUlvt+502Jd76T0bN3axmgvxAiwfb
         lUQHyWFvGVJtdFQWBr/7VBfH3SibgseTFWJMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728424724; x=1729029524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4S2vT+XJ6lAU0O0Dbvl1xT1xfiGrVvJLydXOgnwn2gQ=;
        b=vBfazoQJMEX6g7EhGQ2FjRcnLf3q5e/uSuOGQTv9YM1y4OF5PFalLyk3p+nwgAO6aS
         MTcOPhbLZfeb2d7gI39aDirAfg8CItPANlZsDMmSiY62TP7+uCvcx+LC9QF/8sZGRvzJ
         ZLEdy84OcFoVarAsyuFbAtDOcOLMklCNGkjtGndA1JGWRfbyWhxf/E4XmOomiKjPzaJs
         NtGM+6pF0HZGevwlTldd3gxxgeUgXizwcJAUien0RHpYEW0p2c0P+T3VPN+T1PSK1zjs
         DEz7idwg2BEl3+w8IeVg1TYkdpLrPTxktpqUPLJrquKCNwjhKbtnqvRzNNUoE/jMHgC9
         0zeg==
X-Forwarded-Encrypted: i=1; AJvYcCUngB760qJng7/n5pahj57u/gb9+80qRvvraZDGRMudcF4S/5oE8yLJVEcrFyDQki6GuyHctdpnYA65uW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPshp4k8A/64PkyPwc+wkGXYX0Bcr+MaOyaaPNR0iTtzEOSt9i
	OUKsKMjTIGGCf3Xko+wI2FTIOuplFJW5Vw1zkd02DLu6UGNi3mjrIbRvaZlEbLw=
X-Google-Smtp-Source: AGHT+IH1ggCXTbeo7PXnHHIwj+SZzzLhpIklALX/d/oiBJ5FvrShbiCfcU7w9a5bCxSKcJUiSz0/Ug==
X-Received: by 2002:a05:6e02:1ca1:b0:3a0:909c:812d with SMTP id e9e14a558f8ab-3a397d0a552mr3176975ab.11.1728424724272;
        Tue, 08 Oct 2024 14:58:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6ebf0998sm1811480173.87.2024.10.08.14.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 14:58:43 -0700 (PDT)
Message-ID: <4882ef4f-37f9-4e89-b8ab-85895eca4cf5@linuxfoundation.org>
Date: Tue, 8 Oct 2024 15:58:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/558] 6.11.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 06:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.3 release.
> There are 558 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.3-rc1.gz
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

