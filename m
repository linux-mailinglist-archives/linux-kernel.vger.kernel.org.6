Return-Path: <linux-kernel+bounces-325407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB05197594C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822941F23D51
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328541B373A;
	Wed, 11 Sep 2024 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TNf3EJ23"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38424D8B9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075537; cv=none; b=lnIA7O54i4zqwvhW0hjYYeW6PBSvqZW2tHLaFupVhUc6fb4TTfkE0F+7hGYiDC3g6jvO6rOyLdeRe7EmKubSSrDeHWjPt2+CdJSc02bXm8pLZGR/pQ6tibjGObBdk7HXn3x41SFzLxN2SD9JflFEbzw7mpfs8wWxpR+ma7BE2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075537; c=relaxed/simple;
	bh=1DE5fZyEHazBhk4YSxji28x2nF2X7K9v2+xK+H0heYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YN4BzlkFVsYptYl9HKP2V7lUywqi9ryCXlfGswGofqFDh9UMiPhXI2gclg33y2zDsCZg1K1iCD/tVDAUjraoVaq76AGPajabNUHvyLcjCX1j8wrhkkpK5V/ekuH+Kb6flcCms5Dw8zizswkac8Ye4kc9ekrRnXx3VfYOaaGmxLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TNf3EJ23; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82aab679b7bso1682539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726075534; x=1726680334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtdVX8O4R5RlEn6XgHHpJbfm7Z1QBa4ZYeeQfbViS0w=;
        b=TNf3EJ23qhHSzUNJ8VGt3l4snw9y+UGwUK4EBPrLIJ+9I+ggm3plVgYmeglIsRN2/o
         9j+tNyFmV+isLxnqql1EPZq1cITD3DY7B9vnbIW4SSrqZngIEp/0fAZb+fBxSIDiSDw6
         J6Th4VQ2yZNcBm+5IUvwg8lsRHBpmiwZLeUQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726075534; x=1726680334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtdVX8O4R5RlEn6XgHHpJbfm7Z1QBa4ZYeeQfbViS0w=;
        b=GZKXQedd0I6MfkFIYhoGkx7dcvlaXipdGyuEC0ZmsM1bMsH/o9V24m9zBGVOyFT7m2
         l/N1WUUroXyd8Rwn2sXW82mSUXN0QCnT8e235HfnzCoCpmzAiw31JHb7KG/5XcFoUCi5
         XUYLW0QtZRqzFqQ2GPAdQBc3ErOZfSHtLnGbmOl+KO41uNymyat66fwmUZHzhXZ0hNpN
         PyTav5FTll38piTSjkXEHOqaQrndFoiz0WfRDhn8rZv7rQ3N3/qFNZra/qBFQm7zDpFH
         qx9jrm0/8oYkbXNjn2hxNlQC0eXD7bwv4ePJ1sn3G4r5BpzscuPEqxVIZaDW8c1TQ/zn
         XCrA==
X-Forwarded-Encrypted: i=1; AJvYcCUv/9asKxmq1Ipnx9cAl/0U3Q4J0C9+86w2B9T37bWrHhfgFvaf/XKozl9G5ZaamoqLugJOmz8pJdvZ8Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGa7yv48RSsMyooJvGfASpusqo23tiB4sBPSmcYx4wk3jLQf4+
	0/30pBcTXYb2KLxMsVI7FqRujpvtHEM/Jcix27hCFn9qYBOpfZxl7mLdhDlC3OQ=
X-Google-Smtp-Source: AGHT+IEzkYDwTXtn8Y+11mQQfMaw9Yt24MtITkri4cToPizDt4VvR3VXvFo4NwxfHzWwKFn8OVgcXA==
X-Received: by 2002:a05:6602:6087:b0:82b:c70f:5061 with SMTP id ca18e2360f4ac-82d1f8de413mr37458539f.7.1726075533508;
        Wed, 11 Sep 2024 10:25:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f954537sm91790173.171.2024.09.11.10.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 10:25:32 -0700 (PDT)
Message-ID: <9bbb8370-758a-46bf-a01d-7e4d4f3c3a68@linuxfoundation.org>
Date: Wed, 11 Sep 2024 11:25:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/212] 5.15.167-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240911130535.165892968@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240911130535.165892968@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 07:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.167 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Sep 2024 13:05:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.167-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

All good without the iio/adc/ad7606 commit

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


