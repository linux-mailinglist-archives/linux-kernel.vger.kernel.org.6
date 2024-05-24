Return-Path: <linux-kernel+bounces-188802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98C08CE728
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F84B229AF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C9512C493;
	Fri, 24 May 2024 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bfcgLx6q"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1386643
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561289; cv=none; b=Vt/c6g32u2ztgg4PSKXz+ntTnTmHrBooMfSY2lv7bsmvsSqGZMwtyUUdh7cLHGd9ykExhUOInEJIP4OSf7xPD/Xh9+2qcmovIdMKsvNzcFDjjGTUGDeKvuFp3h/wdmOys/kSxXchBbAmQG2ySr+y3NsPW9HGrUWLJZ/dGDn/Dms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561289; c=relaxed/simple;
	bh=1DD7UAPSGWhJO5GHaawnU+uPBfjRKH6R2/isM2cFwEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j29JvMcdDWPyrHzJyHfjyTJCn7Z1ZS/x1cnE2+MOUNPFDuhRal/CALhPwTjKOvKaexFnwtRV8SGm6efOXwLQStHfktn2UlFVIRUKb77rWWkK0oPK1ngi2rwjA00hMzIJB9q7ZUf3BE/k2NpDqAkD/dahkSkdgh4/1O5JGswdJYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bfcgLx6q; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7e8e5875866so3713539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716561286; x=1717166086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RoFzHlSPjkXYNbJlOVt2ll4nOjdL2XVhikUa/6nwY0w=;
        b=bfcgLx6q0kxC37ciMfq4nWxewIUSxW3txMfMVZ3q1YRnIesI1oSiPSXwEZD3lz8CXN
         wPJ+I35jGxCDkROM5SsCW7ShRqLly77YynQloTqzoUNHFupxiz+zQ2WvlXcku8h665FG
         R4BsSMHOo0YRuP7jKlUj0wAd5B8aPS7gtO5XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561286; x=1717166086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RoFzHlSPjkXYNbJlOVt2ll4nOjdL2XVhikUa/6nwY0w=;
        b=n1CSn1gBRRA/reWLxiHboGlL7frUpmZDYWmN8r4JSMtL83imW7SvdKKajG0+etPwU/
         0CFc7sMubdejEcpi9vVOJQnQoq3z+xKvhjTwzWxj7pKwnZByCI8NAM55F0NMrElOxYCp
         3+92eO2kF/x83Hmp2JAXsKa0VqkH8SjJ2GOQVJcrOXEzeeNjg1iv57P/2YguFGkIYUX8
         uN8Rq/5LyhueBIAyq5HPpC39VBC2fu/pc7uX98k6vWgQ/n/Kqv+Lqia5IXTqJcxVz8mi
         cxooKh6Hv6f5O2oLX6pFRzzkC5aR8aCCq0Jb5q4477GQ3leQzvpGJMQTZfTJb6SZ2RzY
         vxSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvqJy/Xi7168A9eFFzhtvRK8wDQteFc/3+OlkXN0/UhIeEVCI5nCu0TPGtRJ4UJf0g/CN+BSqsw79IIP7eiXtpim1dHIzsRRRjUHAO
X-Gm-Message-State: AOJu0Yz1PSBm7JBkgr2DALTs5rjypeaD16I0h6kZJBuKcMGeA1CeuxXh
	aN/65FgwL9lTIob+wxbrObCcLyvPuSdrW3QlsjC+m+ar5jkxX1gxRDkz3cPOwKWdOskByqlkxpC
	Z
X-Google-Smtp-Source: AGHT+IG5MmuONIihQqWnSSKPSxcNAZPcu8epoB+/zUWt7iZIYjsQWJWxkDtGuMf3gKxoQr+OuWUlKA==
X-Received: by 2002:a6b:7d43:0:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7e8c1adcaa7mr293181739f.0.1716561286570;
        Fri, 24 May 2024 07:34:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e9042dec6fsm38761639f.18.2024.05.24.07.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 07:34:46 -0700 (PDT)
Message-ID: <fb55ae97-9770-40c3-84d4-3b714702612f@linuxfoundation.org>
Date: Fri, 24 May 2024 08:34:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 00/23] 6.8.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240523130329.745905823@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240523130329.745905823@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 07:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.11 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
>

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

