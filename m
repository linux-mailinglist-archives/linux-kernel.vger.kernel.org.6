Return-Path: <linux-kernel+bounces-215656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4725990958E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6EEB22909
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6838BE8;
	Sat, 15 Jun 2024 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Je4NJFVS"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ECE748F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417401; cv=none; b=FyAUkDnvkNSuIAgEK9JmCSED++C1pikXwIAMbhPY8ZUXMBgFkKOV4q3sOHt1rrSh0mvwfnIjwbVBjW0KQSKmxSzkMdHNjeirjOf0wlEo1Zbez0sdt7m+zIkAb5JDsJ/czJ79G95xU0a0Y6rTFYLcewAfEhxiFAR06JGjKCgEdL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417401; c=relaxed/simple;
	bh=jR+r97LLsEqhIqDp9F3OWwf82Sf896rmRh1nFDKfm3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EddAQKFJKAPiVVuBalkBJ2dz2pt8TYKL23dc+22bQ9U0S9WSOPFKDavaSV8R/C3USCELnizXCSjzgIBy5ufDuNzUrzlUKKzybh9SIrIukMpfWRps87tkSPHjA5CXcLW2lnCevgXCTNpe4U5Ue6qHIUQTboeV5ELp+23P1WImbGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Je4NJFVS; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3758686ef2fso1422255ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718417399; x=1719022199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQST+bZ6997ZNOp29xtPW0wBoVz2OQgKR9aErdb1d1Y=;
        b=Je4NJFVSOt09bSGNL9eSAHTSV8tvVWx4iH6O3+8BNCar/uPmnCIR2RorIKVggrCWGL
         x+ZAjEEraIOBd78a7PdGpOaPN2nBripq/ZcSrpAmP9k6euOa54hssM+Y9GvPDcr6SzYk
         jfqRT3NFLxxpJFuB45TvbluHs2y3lMA8Awgtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417399; x=1719022199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQST+bZ6997ZNOp29xtPW0wBoVz2OQgKR9aErdb1d1Y=;
        b=fGSi34+KK/MAFv6IEvjdIj6yFMwgx/39HmK6aHaGNhRsPGTA2O0B/7cxsZjWDt8Slu
         P4uHTH7UGCLWew+dPONWla1OKRRAjnavvnk+9QShYIFOqn6UoZ6cli4qnR4mPW1s+T1z
         +skVYU6eLSCdyN/Uk8CK9xeDhD9XULEq7ScF4MbS5RjIiEdnO5Z9hzVpBKgFPUbvUrrh
         gro25FihWpFbR+6bVImMgrCIoJnNPOcsQZJt2/QOt37ovsfPsWdoiHS//PEBpOTfX01s
         FPY5pReiKYBCknbD2cEqyFa4AthOUG+i9d9wLtqoZLjw8mOFVyMc2m+epTO8QNIHHv0r
         M5lw==
X-Forwarded-Encrypted: i=1; AJvYcCVYCVpZi9gfrV0WCDqBgZmB01k5QkvqxNBqyRHaLQSZv21NOQdhPmJkk0G98KQAojzrVFlKU34wYtUrR/udfp0oDj3zR1+qd0JZP0zP
X-Gm-Message-State: AOJu0YwSL/soljwkU816VAddriNZEABj/nXDJFEnqeB+P7GQ5LqEh8Mr
	6kLfzcvBJRCWWtA7iR5UQoCEgwg38r4nycRi0B0PiGQx7a4GlGkIljTl9Mpa5Jo=
X-Google-Smtp-Source: AGHT+IHYtGoZlwHhsJGiLGXfjFPL0W30A9job+FyKsORYagIgYgv9ouDDpE414yAA9UwHCTtvrucVA==
X-Received: by 2002:a92:280e:0:b0:375:e378:1008 with SMTP id e9e14a558f8ab-375e378111bmr35038535ab.1.1718417399105;
        Fri, 14 Jun 2024 19:09:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-375d866e324sm8883315ab.2.2024.06.14.19.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 19:09:58 -0700 (PDT)
Message-ID: <52466fbb-f0a8-4162-9e6a-d48dee94ccf2@linuxfoundation.org>
Date: Fri, 14 Jun 2024 20:09:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/85] 6.1.94-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240613113214.134806994@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240613113214.134806994@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 05:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.94 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.94-rc1.gz
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

