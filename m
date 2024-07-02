Return-Path: <linux-kernel+bounces-238576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3967E924C42
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 01:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C09282C52
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7400D158853;
	Tue,  2 Jul 2024 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WO4au7BM"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3317A5B4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963818; cv=none; b=XIEbJzabeYkWLxmZzd3pmbo3VIJnjjZ9P0iDQGIOj281QLC8PFh1doK1C8GEUeh2t2QdjWbyoyb31jaIf9E5a67RtXBrb62JE88V7EFmk/VXXOuEgN/oP5XaTNPPs1p/1Y+N9JVz1H1KIzOCV69fGFA2golcTbgPJTaTgyRSsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963818; c=relaxed/simple;
	bh=3rHOtTtX/eBgobiyISQcQyKnKhcM7dv4HpFKtMHXTD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=li8WQLn8bk35TebejHdbIb2TMnK2nRUzmDbxtdpvV4jarrR6h/9V7tkRwu3LxfK6wAH6Avoc5Z+wo+8laIqBJBqjDkIWFA0SCwdwR2VTU5VuacLdg/yb/m+VEIEBfj6iVR05IsNt7HuBNzin/m2Gsauf2+t2Xu7+DKQc7QzQ+Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WO4au7BM; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-24c5ec50da1so693164fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 16:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719963815; x=1720568615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exqubn+2LOYZAY1f3ejUa6v9hn+LU2tgQrcCMEUOeSI=;
        b=WO4au7BM/h/8Abur7V+l9m3SFOecICD/RLbC+q5Dd1jv7nx1fyhP2R5LMvizCerw5F
         qNYBcRjWq0RAPlHTLByReFWrhl0/vWsNxsoZ03j69jUtkMDRtjUYsDy4BRcXTpyXPa/t
         0KNKxNqL/BnkjaRW/C710g6IfSI5+SBdj4pz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719963815; x=1720568615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exqubn+2LOYZAY1f3ejUa6v9hn+LU2tgQrcCMEUOeSI=;
        b=OCIhRtNgLDZpAD+Qe6ECQdLE7XEaKU7Pzqgh3+vKx65ikpaL4dLA4eyMFSwCW6/5Mz
         oj9vvcXa6vmKywSURVz1PfwoFPVzLCEk2yP8e7l79d1Vpim+ag+Qww50I6Luh272W1CR
         JiMIHrgvkmz8wam+GBhC/FmIJW3OjVW6Ii7QSvoim0ScALiFOjJZ1cibwZgF5or6EEfk
         1baFQywHFvJLypbLWSk+kI9ur4KlRbM/aV76jPTr4MvLu9fwBGao6K9z6I3qnGnSwMVd
         rZ8QKG2mxGGJ6nxVNZV9KqgVabxpJhppkj8VRWvRZdmUK097JxTdNUFmhS0vShNGBhVr
         PlCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmVR7pKG4QiXDX282DVD15kWnuRQVHdggINvDEOjmF0JvSp0ipemrp+VdbkFyslSdNl3ordSKeDJ9/CA9o/5dgHq62s2y6lXVtFNWv
X-Gm-Message-State: AOJu0Yw7VvZsi9uJ2vt35/JWMAemZlQhIEehmoBSwMXGbo+56BlX6zkI
	g13tzk1zE7YpAGi0hQDYpArQcFT1ghpk+K4LldEDACMyiSOtlCunUufEFxYFl00=
X-Google-Smtp-Source: AGHT+IEsQU8oJU5zEmQD4zGi0A+8HyFsrUfkPPf+gpNjRM6jiN8rJ10aPicdU+U6OYHOdUy8GK4Vsg==
X-Received: by 2002:a05:6870:8192:b0:24f:e599:9168 with SMTP id 586e51a60fabf-25db33732ffmr10377174fac.1.1719963815229;
        Tue, 02 Jul 2024 16:43:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e0b696ec8sm118546fac.11.2024.07.02.16.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 16:43:34 -0700 (PDT)
Message-ID: <948e3cca-c590-41a4-9805-fc8f6b43643c@linuxfoundation.org>
Date: Tue, 2 Jul 2024 17:43:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/163] 6.6.37-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240702170233.048122282@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 11:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.37 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.37-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


