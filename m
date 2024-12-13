Return-Path: <linux-kernel+bounces-445180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964DC9F125C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57053284039
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FDD15573A;
	Fri, 13 Dec 2024 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dHA6TyjE"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3516D9DF
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107975; cv=none; b=tCD6KhTbCqnuhQxm/laEReLne/ZW9eT9xuikfWYrfOu9+AKeYZi2i8TxfAVy4aeoiGshz3pgNFKAmK6jG1nyTwWKFpjJsrpGzEOGP8ed2xWRtuyai1pST1BTXNUbdC2zDYAKRkMIzsRrtoqailpQF48sMoxA/NpOYedPvWZbOi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107975; c=relaxed/simple;
	bh=PK80MB2a82ILZwjtwJVBex8AuectZtBoackRA09LVys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efXHkzUUPR/aMZw+BOLzx80jZ2Mt/+KHLMkyYInJIp3Y5yWbkexgGEkOx25N4irjHDNqqiBPoEKeotH62nImOHkdJWs6wzjhnhRB9VeWn1LbYg2GEkr3iivy+qIet32q7mN6BsKg5qj9HzvvUYmsOvgRR2bBpdacTJjVr6h93Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dHA6TyjE; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844e161a8b4so57740939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734107972; x=1734712772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXrSQne7C8l3nSEcpBw0LjVsuhj/QlI2zejhfnriMQM=;
        b=dHA6TyjE6MBLRzX3Vf8SJdWTPh4zT//3bmmcdpbE+HGo7jzp5VZa/7EKB9e7zx7bSc
         YBODV8ryF/0M+0pEDx2M07fzg96pq4MH39jcbZYHkjVbJXHgXL2JMWgh2BFjVRKkBKpv
         oBRVYw6TCEOhdfogZpzYuQf5KEGbE4tJT4F6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734107972; x=1734712772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXrSQne7C8l3nSEcpBw0LjVsuhj/QlI2zejhfnriMQM=;
        b=kaGW3g1P5amGsENjwvxuIKK4rroOHcPVrriuIFvF6AjIsksAfWESuaz5OuiznqcgwY
         QLv4eLfm1J78FyA0MbZtnlubcqCofodea0RCQ9k0BhKOmJIRv1J4UWkjen0RsSZB8pHr
         kxQjUvcWFPFLk2Y69PYoiCMrByg5vnMbNv5hQNSZkTeJzIqII5ofjFZSyF9uIjcWi3ER
         H4WUg7aEH6iRQkXOlgnMe34VR5m8VvAl6ZsnCnJ8vU0krlt6o77tI2OOtfAh9Rm4CHsT
         GOUwoC/ocEbAJWLpBYsrBwzfOvY2bOSFP0ZBjFSrQpXMa+KvbzZGJ/st2gEbSKRNbb1G
         lFiA==
X-Forwarded-Encrypted: i=1; AJvYcCXJw9cOC26db7D+67dGM9dZU82R58MSqJJQXRFTtHeI4VI6Q1cGCDOzmEa4UFPcSECBWCjo2glBvfJuKnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNS7zRKk5N54QqF1hPbswY+4JZESiLirYUo1Y1vkRBcvkyQcwk
	PmcaA4qKvR2wyJkmbw8R9YdA6vB3WTVmn+MsxK8mb64tCxJBpNiI0DI6yBskSlQMH+tX7kz36ms
	L
X-Gm-Gg: ASbGnctZCcYJdRE9CdDIkmEqthergxFTJZxwD/YbsL2aYKceCpBPogDShI9uOC2HjIc
	uqYknI76OMte8six2Qy27iBnMh7pQlILDc/sP/zkrWs9N7M4RNOty1gqy3tbof0UtnZcuNHZV/L
	CAFIZ0BqPYvDK9daeaZhPdTOOrkWuU4JlN0uuMaYCumUp/diLaHxsR9LfqFJWsOlMpkj9G5pKhg
	0/G6le0kQdzmrBPGttldQWiTuvZvNsHy3OvI5eBp1fGwuHTnRGFCHg4vCUGI52VzXO0
X-Google-Smtp-Source: AGHT+IGa+E1ul3LhwNTm5aeaCTcqWfKGT88TI9k6GZ1imc1TnoEYMDqfzRAhbIePITnmYUeDk5M0Zw==
X-Received: by 2002:a05:6e02:1a8e:b0:3ab:a274:d73 with SMTP id e9e14a558f8ab-3aff53970f9mr32030275ab.7.1734107972634;
        Fri, 13 Dec 2024 08:39:32 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a808d8fa7csm49208315ab.8.2024.12.13.08.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 08:39:31 -0800 (PST)
Message-ID: <26e5acac-0732-4394-9efc-da91630a0a42@linuxfoundation.org>
Date: Fri, 13 Dec 2024 09:39:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/466] 6.12.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 07:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.5 release.
> There are 466 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

