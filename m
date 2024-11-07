Return-Path: <linux-kernel+bounces-399265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D09809BFCD0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131C41F22222
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CB185270;
	Thu,  7 Nov 2024 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a1pPIzAa"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B82FB2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730948464; cv=none; b=Z+h95EtkAL9jtka06XPi0xbnb0cx7eYirzlo36BYIfAORk1NrDEx1o1Gpk52pZiXPhu5Yn//0kw0tt+/BioiX9moD+AyujJopZ2iZuw0cKVk3iVhglu7xyqvNMAPQDwyqIAnL2wjTUji9VuoZae0FpMyU5AxGG+R3GORPA686Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730948464; c=relaxed/simple;
	bh=jrp1FFd7zEuBg2O8pmsB8OufTaS/VFGCioZTR7Xt2nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RR1GieZGNWwuz7mPJFBkAfCYhzn38TdA89n7ofbqLH3Nzswp5BARtzz3U8MQiB4J18gFOOs+Kp6fY5opAiqbiwCt15uWNff/bqrMqXz1/x3r/9Pcgq49fSo6cO02aM28BvZPuSgM+bHVSRmnmH1qMF3nIwrb7zc7k2qqlZH1BRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a1pPIzAa; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-83abf71f244so18384939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 19:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730948461; x=1731553261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QO4VEl/tyS3zWW+lWJR3IT8/UZMsZLq/FqWmN9Me+q8=;
        b=a1pPIzAarVX830sNBxQWTioz9RAVC6hd5w+r0WcBNNOXMp9q+l6gD4zS38o2bbyjZV
         BbuCkZ5OtFxc4T5AeAZKNvMRw/3RTv8UPLocjeZVN/eBfzU0e6oxaSXGR7mcQsZU5AQr
         Uw/nw3S3hLzGg8JlJ/ceoCY4dikm4N13SyQD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730948461; x=1731553261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QO4VEl/tyS3zWW+lWJR3IT8/UZMsZLq/FqWmN9Me+q8=;
        b=LPLT6o3JjAQE0y/6RQsTvC0O7Ri/k+NbXtYNVzKHkdb5wtC+ERi7bqky8gzuZ+kDpD
         lIgFyJ4qLHupsybfunC4HxYD+Er9Wh9iCIzW1+3odGmP+5IvshTrqSki1+WS5VoMJv/1
         6pw5JlQ3zYrE8zzWR0FO16L+Sq4XdLEgua0BvJjNBt3DwUZk03CYsVMhWFCTY632GpSO
         WcfzWpNRGSkeA+hSy6tMQiwoyM8VMSsNTkBbOYHgDUVTQNSvnYV41PqCjYJf5A05kwIb
         sZKZ6oianJ8tFcBJSD+x0R4rfNYi8czl5bzTHKTuV8lArYV/GVM8uoqoVG90aLNCc1hw
         rnfA==
X-Forwarded-Encrypted: i=1; AJvYcCWSndMcvwzhXtnU/YkQ8bjzXshaJONlkgQTginm3LI/RMln8gS8tBmaOlMDzq63RkGxSEEW38qoA66Zw1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsihYn5tlvN6R0weq6SqCy4Fm4ZPEUNstkJDlxLG0rjNelo14k
	/JnYUm8/PG7uPyq7hfbfENUbAb5L7V+nKCWfyXvrkLsuTkXHvxzlfNP7h8y9fxAiLXi/Csjrf8c
	f
X-Google-Smtp-Source: AGHT+IG/K/QSHcRVbeZN/O44C4X4DS5NZPSupMVXJsF++kREMfSO45/VPQbs0eqsj+3v7cJlt9IpbQ==
X-Received: by 2002:a05:6602:1403:b0:83a:b364:ff10 with SMTP id ca18e2360f4ac-83df58b64b8mr90628339f.9.1730948461219;
        Wed, 06 Nov 2024 19:01:01 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83df5039a01sm11191539f.14.2024.11.06.19.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 19:01:00 -0800 (PST)
Message-ID: <545d7c6e-2a79-4cfd-a0fd-696a26fb23c1@linuxfoundation.org>
Date: Wed, 6 Nov 2024 20:00:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 000/350] 4.19.323-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 04:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.323 release.
> There are 350 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.323-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

