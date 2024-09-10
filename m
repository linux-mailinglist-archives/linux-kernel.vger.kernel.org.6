Return-Path: <linux-kernel+bounces-323968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C33F974636
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC7C1C25270
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A361ABEDC;
	Tue, 10 Sep 2024 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LG4ThvWQ"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D57017B4FE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726009392; cv=none; b=Ifhnhx1L2Jjq8cjuFkcAEXsR7SZw0Fea/tKX47yyceHtKuRUcn5A58IEJge5Oran0qXnQWBv1pr7MZ3NbCgNy+P1yDnRRMgr23nCPhTb0KgCLhaikFX9mwTrA+Lt8CDlTKW/wXM9TEE9m5WFlYOc5JI3WH1Tl61jaJn8J7HV4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726009392; c=relaxed/simple;
	bh=01XXCU8JIt+/LolNj9F9a66tCdxaL1YDcBc+c1mPPQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdneB3IL6GNv5Tk3eYDwJ93FHR1qsN+B2+DeG3RUv2M61s9cCmyJ0ig7O9FxX+LFvCox6I5/6LLa2JGxEmEdh1V+/fNfEWhwVNXClXb/+DjUrbb/kxXup6NalqCA2FcHT+wG+TtyNbvOX0igR/gNfaQCo8262cLjxJibe1U+JKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LG4ThvWQ; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82aa3f65864so182676339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726009389; x=1726614189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Our0i5FAN8M9eyBuwGhZmOhmd7tZTzv8n7Ma5HUwtUY=;
        b=LG4ThvWQNQYY/X9wrtutguloE+S1nRz9okNIEg7MTk6b2Dp1F9Nf0PNP5Jhl8Ai3Z6
         6j4nKn1MYVUBgfqM2GJhmcvkWgoqp8J4uBBO0UsR2EDHaLQQ02oLHCFlZ1nNf7TWOQfU
         9UFkd57/PRFSOVBHdTcv7/BxMbFdJJSVAZgHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726009389; x=1726614189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Our0i5FAN8M9eyBuwGhZmOhmd7tZTzv8n7Ma5HUwtUY=;
        b=UwH+SQPoDWLUdoxsPp+iffwL5d8trPUzxeqsUwuO/yoxny99kuY9koGouEVOUiaqRZ
         nnaAzntaDEdywOS6YuwGgvKr/ALW2iQD4yX9Qa2jcvMSYd8Wtgqjq/aHZwlEk44jKxxX
         CA2AgPV8KYFBtQYzJZpcOT17/aihKvnw3+xU+v8d2UKP4kFbjpO6U0j5FPDed3szAUj9
         xkQRE5pI+FWkFH+UAyXyzD9fSHPcwZErhiMv6NnUzYtZvPTp/m//ERJmwukoE9ilGQS5
         YGj9vTmDlAJMILYQCWi+a2a4MD5IARaW6bUdzxjjEpnqQN+n2r8jj61R8CIW0XKFWQMx
         hPKw==
X-Forwarded-Encrypted: i=1; AJvYcCUJCqP96fYknc+Gl5CosBHNmSknt/Q6gaOWhAYqPlWAdUz16SqxhjxsSLNvp336Ah+zJZrcVjWrNUvRukE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyleI27UdvdEhbfOtU482jW2SF6tj0WqJQD+yThRf4xt0aqa/mq
	iJ3DO1WVA3PdhM1pwK2rJNejOvUoTQ2zK4hcY3PWfbcW/kw9Qc58SWPW5BKuPBc=
X-Google-Smtp-Source: AGHT+IHTzytd/BXjhulGOFJeDN5N2Y/iSixDSXEeNyCm+5M2O3H39PajIp3Y22RsVR4SC9HtjYRdKQ==
X-Received: by 2002:a05:6602:2dc8:b0:82c:ef21:91de with SMTP id ca18e2360f4ac-82cef219385mr890886539f.14.1726009389357;
        Tue, 10 Sep 2024 16:03:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82aa7385633sm228261539f.33.2024.09.10.16.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 16:03:07 -0700 (PDT)
Message-ID: <f2b4e304-2a9a-46ee-a56f-c7669bb891af@linuxfoundation.org>
Date: Tue, 10 Sep 2024 17:03:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/96] 4.19.322-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910092541.383432924@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910092541.383432924@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/10/24 03:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.322 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.322-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Build failed with on AMD Ryzen 7 4700G with Radeon Graphics

   CC [M]  drivers/gpu/drm/amd/amdgpu/ci_smc.o
net/bridge/br_fdb.c: In function ‘fdb_create’:
net/bridge/br_fdb.c:515:20: error: ‘struct net_bridge_fdb_entry’ has no member n
amed ‘is_sticky’
   515 |                 fdb->is_sticky = 0;
       |                    ^~
make[2]: *** [scripts/Makefile.build:303: net/bridge/br_fdb.o] Error 1
make[1]: *** [scripts/Makefile.build:544: net/bridge] Error 2
make: *** [Makefile:1086: net] Error 2

Possible problem commit:

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
     net: bridge: add support for sticky fdb entries

thanks,
-- Shuah

