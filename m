Return-Path: <linux-kernel+bounces-524189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3AFA3E043
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7672B189F09C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1179A212B14;
	Thu, 20 Feb 2025 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DFr5QnQX"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360C212B04
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068146; cv=none; b=QxYZPuUJifsGbDsgFLaEH2q66vhW0e7096apYVyvoPBHpMqI97LN1vcnA4xgu8XuXw6SsQ/ZTJLIV/Kvy6nKJWdAMGxpKMumlZ6Mv4v44QVDejCGnxVlIqv/8onbb82zmy5R2Mh/dQoWHCmCzjqT3HmsbGiGJDa52PW29n8rSd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068146; c=relaxed/simple;
	bh=TP0WVW5YkfkBapgEr2KnnnXFYymHavrXUZsKj8G43Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Icm4VwAy/0GTLn9TZKJIZCk3EsmHIwDhMb8CTcHBZpYuAe7pklNgqWSkb+BmKEMKXtFQBkikAV44orSItpYC2rHic4cO37YCiBzljQWl0t0yIytwmfNcd8rBlBhP5bAGbx2/msbc7P1HPomtXRsknjPLBjGpKsoYdk4pfhA50Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DFr5QnQX; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-855bd88ee2cso30636039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740068144; x=1740672944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUWqvaHVKogMOF/6atNtzte45Y3jauGYwzzDI4g/w8k=;
        b=DFr5QnQXyYEPd/P77oAQwDRn1e/ZQJQKJinVIUPhD5MxOPM8vSDcY0GnpkSeok9HJ7
         WWJdjerSoYvzWtWwdKPXcIE2sZK65ntF2Dqf80F+GcVso2bOsxB4iG8ueiYLcPLG8NyX
         SMFuGCdU7U4k7eO1X6T39pOh9BhdWDl8zj4Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068144; x=1740672944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUWqvaHVKogMOF/6atNtzte45Y3jauGYwzzDI4g/w8k=;
        b=SxoIvtjBIE5nO3Jnjp3uo+cdJUB7avsRC7e8urN3orvNvfUGV8l50sNujTQ5Ugqnm6
         oIXCAOw/UaDeqx07tfNRf7vgbF34LRbldxBIjxvPVbkGWB/tgyGtq0ZkXqSSuAbtN7Cr
         8E6ae3jwt+XIuWg1893NQ18DW80Zf/Y8jri6DIMiE2Kluhp2YosL7/8rMXIkO28LqnCw
         r4r7JIRV/KUUAazhebMXjIM09lz0mBg+VfqNsH79NKsyXrLpFRXLo2h0IX+7l9c//+ba
         hPZM9lT3XCw1MagD5RYjnE2bnyXTqeXDZbWWgEmF9paZnsdfTHgKK5ysuKAK0XhHQwdm
         JdeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVazV5TRQ/zj/Eh/ljb1DT8VQl/+97W5vuDpBqg1t3Pm+x8C40a1zKmIzu6tkuAhsx9/7B7ybtvKdxoT6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYboTLGH5RUGACMIry59viCSkD3MUg2RtUwvEyrQBoExUXtdlY
	M+l116btU67Gv0F+mpSZf+i8NVfWIUdGaUePaTcO6MqxGYoUIhriRzDIWNFVOMg=
X-Gm-Gg: ASbGncu3Fqo7wUDm8tv4poPavD7Ogqy8x4Y05yXM4/ijU9U9DVavTc4gP6M1Wi8Lh/O
	sk/m+SFPwIJ/oSnkjuilQLqBSS8xnF4P4UYIpQScxvOTLmyTqILAE1puiYhtw22wmtofFvxCwvP
	H5V70ie3+8LxTBCH4jDCjGuzHwEF8Sn4TzrDwZES9wRUawbuD/+EhrHEqnb/EgZT48Lz+KpYQW+
	H2m17NY0kXmZIvAsD9I7txGWlEDQrop6WoigxpZHtinYDtr3ZhtXA5oRpVe7vdxHSD8Tdk6Bar3
	eAGLQaMcUeR8y9LhOxvqHEyDUQ==
X-Google-Smtp-Source: AGHT+IGQfgp9kEAPuFuJ3dTKK7tSi6LyAWjjoabJeKiSVbuCLsWQ1N+U8jlefoqgkObX2pN2M+3XKQ==
X-Received: by 2002:a05:6602:608e:b0:855:ab63:1b89 with SMTP id ca18e2360f4ac-855ab631f4bmr913625339f.11.1740068143751;
        Thu, 20 Feb 2025 08:15:43 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee9c71d225sm1983789173.122.2025.02.20.08.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:15:43 -0800 (PST)
Message-ID: <73312b28-c050-4cc6-8155-c5fbb5f285cf@linuxfoundation.org>
Date: Thu, 20 Feb 2025 09:15:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/578] 6.1.129-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 01:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.129 release.
> There are 578 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.129-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

