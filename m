Return-Path: <linux-kernel+bounces-268335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8028494234C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB121F243C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE5518CC01;
	Tue, 30 Jul 2024 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DBs4Klj6"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F8C18E024
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722381101; cv=none; b=hJhJi1lWygV1cbQdAz+u8gJ7FHSXxFvRexeW4YABl+QYkRtmnR892A8qYXTsvVDCELDVn5rU8iT8Ytlobyb3XYXLiqzTH1zDmw9FAVfBnKnGZF7xP3qYzb8uWbvv3OrJ2gZyk7H/ZEcOaDjCwxF0NSWXXVlPUh3rSxKvCSs9tio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722381101; c=relaxed/simple;
	bh=nCeuwLIYjC5AyVwLPKSkgV1ci1aIW383MdR26rf74WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwMuMLFv5d2r1Ls5+YRdUiOXTEJpM6DPOEZQgjclUgSXif+4zJ9InvSGOB/2px2B99vfPFf1o0I4lXqrAo7x2nUyp0JJwwqCpoPcBz6/wkrWjF4RxICv4MDKiJZ0NPuxb1qOQ0fjR6IbeMqi7TidWFgk2sSZWVnNHTNLR5ZSyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DBs4Klj6; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-81f861f36a8so27684539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722381098; x=1722985898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sFwp9JoAZRcGCAmAU/pa0KmQXzJ+i1s34wWpHxxRFHU=;
        b=DBs4Klj6hwnj69hEf+WAkdSqlCrxx9U0D4Myd3mp+hmkMUMgqNAI0nTF5kOQNSRGyM
         mh9o9jTp+fWXBs9j5xu1/RE+194H+gjp3wAIEy9IeJOXzea9B4tLm4SxK0S3dXPgZ/Ri
         fzRt5vYd6itN13eNYXIxBmGckyQIgQaKnrWTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722381098; x=1722985898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFwp9JoAZRcGCAmAU/pa0KmQXzJ+i1s34wWpHxxRFHU=;
        b=ApDWINbXIK2q4Ax3rb89T87O6YwCXdGltY7IKpQgiZesdzVa3MNL3K9rTYnBki/44F
         ao690feepnkY3q5Fve7AhKjJ8Wwqf1IMydjlU7A/JO3RqOCDti1EzMsh4RDdK+mQeW+v
         k2FMVE89dAUauoABBOi7x/zwcc3TpwzuUGJhD5owS+Kv+7uckeCJXLSm3vNWBygGCOz2
         BC1vkZqzJEM5BLMkRQ99tognFcXLKkEF/BLNrWlKCXWswoALzHFTJfRE5BLuT+zsF7Ik
         OqtvbgC9f+MLXARm32hV+zGMx8h3lTwpL5rYnrz3+6p1KLzGqJUwKjfBCCHad9fS0grf
         woiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU99sR7DD7Wpfe3wvyXjToAs2Qr9IDqW8Lr1xaWAmYdyuskkFKymd6zeCatLrflZecl9MwTJezPFV6TiHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrKUTV0lJSY5Z0AtJh6XuAnGXxoaEmKy2riTQJvYD1Emd9WV/t
	8q9Elaoa2/FwczBZTR5nZNkqn43Yx0GNSMLHi59MR4iv9HfThlbRUuJKL2Rv820=
X-Google-Smtp-Source: AGHT+IE6Ubd/KWl1gwVavGozmtWlhzKPtfYc3QbZ3wbPC5xho6UnQTVPsflVhp0HDM1OAKrinyAWHg==
X-Received: by 2002:a05:6e02:1547:b0:39a:f5b4:c63b with SMTP id e9e14a558f8ab-39af5b4c952mr63224755ab.5.1722381098495;
        Tue, 30 Jul 2024 16:11:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22f14094sm50774925ab.60.2024.07.30.16.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 16:11:38 -0700 (PDT)
Message-ID: <585d7d54-2476-468d-9ec8-8988ba607c5c@linuxfoundation.org>
Date: Tue, 30 Jul 2024 17:11:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 09:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.3 release.
> There are 809 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 Aug 2024 15:14:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.3-rc1.gz
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

