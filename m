Return-Path: <linux-kernel+bounces-342592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F39A9890B1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8090E1C211D6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4FC142659;
	Sat, 28 Sep 2024 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="goJ2hNqC"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1FA210FF
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727543657; cv=none; b=P6f5XD5dtLEZTGU/BDmRLgf8/TCnnKA+iwD/wRerTYHfgjkcfRZf7WYJWUE2moRqMBDF+LQeEVSO/L0EuD6YXypH2ZiBrgFXY3zztDuW9yYYqI4ol1I5zEQGYPskB5iJhBQBBTOmUNEwWgMIoSssfLOEnJ574kv5WaFJF2ry5OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727543657; c=relaxed/simple;
	bh=8h0mqtSR3cJMDeaf3gQShuu3Hb4p9VvJuvHRFRnHAPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JS8o1Fyfj5mAkEifRyH+hHCs5KuWvwxuXA1iv9jS7TzEnqeG5tC9ZeaZeyl0MkIXeqlqcn7hr9X/00RwnMEkVA+5cLZcxGEIpGw3rWleGhxoIvKOrkx0U2ZIidKjXnbSJ/N5Vxyo51UNcYmvN3/hPqGWwzawG8KX13DubQQoZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=goJ2hNqC; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82aa7c3b482so116619839f.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 10:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727543654; x=1728148454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLNwBHV8ycc1jDSNmRLEZAE/y0F/roWJNJrPGAjRslk=;
        b=goJ2hNqC3p6zXmejcxBnKLqlx40aVm8ktE4wOMNmHLPhc4KZozZe8BAWd1wGqCtyBF
         PtmVRvxqYs4+h+bpVkrHMYiup085NURLyZYKggeAHA9d5Q9JRUwJbwhpVueLjYUNeBGl
         QEfOXl0qqZ2IfwrdAg7/hQEB+sWR4Ifx+Pmow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727543654; x=1728148454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLNwBHV8ycc1jDSNmRLEZAE/y0F/roWJNJrPGAjRslk=;
        b=uj+0QjsZ8SZcJF5qx7NVFZH/CmmsaIG8NdikvYZCHt8TYKrNCFWReHvqJRmDylPp/3
         v+zYea0qhdGdeALUmUTI3F8gRsyf9xZkoCnJSYSorYH38DzGdvLcPtztLt8BrAeJvoBy
         9VyDZrgIvv+97OP1S9ogYrq87xfXs60kPV9q9iC22CHCL5bpVuCDj1kkbI+ZuN/eFstK
         ujgu8vwXIhUxlB4iVSdvqJF6E8e5obVwbuaabwxzOUhBv8JLlmlur6h7JU+0xOY/yT4t
         Z7aGQdCalXnmFtI8Gf1pb6k/w38T2zPR0uzy5k20P0/nUbN+iYvyhNAHXFlVbej4Rv2/
         A40Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpxCIpM/Z8XlucWYX/mImH/wNkeq5YopoWaE2tDlJf7yWA3oaiTmrZh1JLpdPMGyN1c41omB3mc1gEYWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3PCs/5lI43pPeD6U5USU0LZQ7Sx3zRZEmG3LV6HXvpEdZpa1
	hNHINzBu5MvOEQ2FAjviswsoMkvq1yX7iRX/xEVC9J/TGoA9j+J7919ojq8L8n8=
X-Google-Smtp-Source: AGHT+IE9RveJoVWD7x2Ya2Bk/5CQLau7MKHDHNVEjxKmy7eCb4AU9uRuLzGDwv4IfvytwQOrO/ivTg==
X-Received: by 2002:a05:6602:2c84:b0:807:f0fb:1192 with SMTP id ca18e2360f4ac-834931ae42amr706616839f.1.1727543654576;
        Sat, 28 Sep 2024 10:14:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d88884a6a5sm1185351173.43.2024.09.28.10.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 10:14:14 -0700 (PDT)
Message-ID: <7343743c-c44d-4dff-931f-80f782634fb5@linuxfoundation.org>
Date: Sat, 28 Sep 2024 11:14:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 00/58] 6.10.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240927121718.789211866@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240927121718.789211866@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 06:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.12 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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

