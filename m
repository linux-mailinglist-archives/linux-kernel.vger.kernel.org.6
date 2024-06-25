Return-Path: <linux-kernel+bounces-229738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFFB917375
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9161F22041
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCCC3B7A8;
	Tue, 25 Jun 2024 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h4EGsqg0"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8E217B430
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350948; cv=none; b=Ca50aluiNJMXkO4fVvXG3hLyWYULBM5hoz0/bBKpDnp5VDRDa9JGNsxJuHlAX46NRnE5a8wHn6QMc5YOTE6jlFexa+DvghAJzbfH9KzBqQ+M9GXlr1ZcTCFdEWwyjE1QDu4FLPEec25FSvTgVEWpe87fAtnS1vURUlETA9GFKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350948; c=relaxed/simple;
	bh=jo7jJ49egeKEwb3oq8bBy+Z+1fNQqN/U1oIXzUm5r1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3zcD8STHBcqB7tFuqSi+bnrzm6XTGlQs4f7dJKwPUg3R4cJ56+u8hj8fW+/zHe8XJPaSgMe6YI9txOzymGqrI9tOt2jiO8FLdkZ5yEe1MOagT05jf+Les7TkTG3aJBJzpqy+loETUwJmgMAbUy3B7MhDWGrRwAObw7PYMwoMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h4EGsqg0; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-37621d83ca9so2361745ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719350945; x=1719955745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fjB6d8DPFz3YLiI7wqupsxFA7umSyU9rD25cxR0gLg=;
        b=h4EGsqg0qN3vOyyt5SAjE1quMG97bPp93cejn7S4J5xvFlEClaLfTiPiNw+XJQgefT
         Bu3E8OwNnBgFHLodD8QMVbJJUW7JTtSXjNCCAEtaEzjZ1U7YFe9g+YaAo5hf0xFNDBC9
         IgXAbpkOsJcyKxAh6nK7tHTSkL1NVpTNFYbV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719350945; x=1719955745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fjB6d8DPFz3YLiI7wqupsxFA7umSyU9rD25cxR0gLg=;
        b=fsSQh5pPROzjpFGhL9uolmuS9ica4exUheC8NnNVhh2zINqaTU+uyouwDnwAHgm+9X
         DDH/p2QPzYbITnmSl99oDp6MIgmMyBSSC7lmX3eBB1h1p+A6C1qUG9psW22AOXsqsDuk
         F01oh1f5tviMfegA0N4anON3VCGTTG6If6KxPM61PjuHQbhptwj3qrFQK0luzVitSU3l
         IWRR7tb55W/r6mSJmL//3QqznHJm1ylMErydNto2b+8azZ+Dr61TKydVRLDy3FGiKqCE
         /0kCoY3KqoMyJmmj31hh5yGRTPIK/n02ij8u5K3FevnZ4pwhD+kUpFmGrZHrdW14uJqI
         eX8w==
X-Forwarded-Encrypted: i=1; AJvYcCVFwqkf1xSSZLFNnxbLOuqZvirH4ugG+93Ul3J65RG9mrFpWR/w7L9hl/+dt8yHRJK4psooFQEQLISB6RFzdN52fTGpEdmPn0SmQz+r
X-Gm-Message-State: AOJu0Yw5HaRJx/Spaf7Tc+mKy2qoaVWmZ3E5nujFQdodu9iusheIadEM
	mxZrjYkLCn9dhYpar+h7Q4l6G01Aj+F7vg/ZbfuCwGqQ///36ZWmWl8wl2BnJsU=
X-Google-Smtp-Source: AGHT+IFw8YkcVlThTre7WcW0vXEnonmEPs5gY74qQV7xHiIQ1kebkjQ2oXVGTmaIg5oejXENkkQYtg==
X-Received: by 2002:a05:6602:2d88:b0:7f3:9cda:fe62 with SMTP id ca18e2360f4ac-7f39cdb0084mr1219830039f.1.1719350944712;
        Tue, 25 Jun 2024 14:29:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9d2125a07sm2783018173.146.2024.06.25.14.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 14:29:04 -0700 (PDT)
Message-ID: <839bc86e-d4a7-4022-8a2d-d9b4f91bc040@linuxfoundation.org>
Date: Tue, 25 Jun 2024 15:29:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/131] 6.1.96-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240625085525.931079317@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240625085525.931079317@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 03:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.96 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.96-rc1.gz
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


