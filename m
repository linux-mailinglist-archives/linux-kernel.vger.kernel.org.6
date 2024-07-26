Return-Path: <linux-kernel+bounces-263497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6753D93D6E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F367FB20D10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C0617BB27;
	Fri, 26 Jul 2024 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BsFuCv5X"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F029429
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011440; cv=none; b=e5kWjE6WEYFu/x8kup5N8ODHL3wYARyGl2dR00XtuMcmyt6H8ihOCWPJP/+o72oihPazh1d+9nfC3ifdBTjhHrbixWKvmJF0MuW+/mBlCB43vUWQqlZWZdI86ka6J5iWLDkgbv15tjWGRwJrWh8ITqDNmq/o8Cins2qDz2t1heo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011440; c=relaxed/simple;
	bh=gDMA28RchPVIUSPpy2NsLvmc9SSvbe4A8VDvVnJjpjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSVH0ST2p3I5RRyay0ega4AHFOhpHAYRC7KTIPv1GB6HnXmtAkJebuyBN2yKMVqMLLVr+rjUBEGdOubXJcZ+KmUJWXVgRRERc8o+r4s7HZM9+kX9JfokxK1oaWGeLSKO3MlrF3WMt3VvKLIdqm4L3ZVzag5C8uE9pqtaKvLkn7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BsFuCv5X; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81f7faff04dso10208739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722011438; x=1722616238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ClLEQhQ1iUwEnkwU32KsyDoCIxPM7UfxUV/C4tGu5Q=;
        b=BsFuCv5X5G1GIa6S5FKQA5oNBgAubuBtt71jqHwbAErJHNbmr8Dvi1REL/V1jsXBkW
         dXSFNrD5XDpJks3J68SNWlBzQ1qRzRe+fIc8fU8rXz3D2fjL9fnZsQnJGkW/0ISxotwb
         WyXVx/TQnJnRDmw/fo9Bc9yEL1scgOXa9GLYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011438; x=1722616238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ClLEQhQ1iUwEnkwU32KsyDoCIxPM7UfxUV/C4tGu5Q=;
        b=fKiUm41OcDu8auc3Bd1vMen1GjemdqUM74KVd6KybAwDoXQaIsZ3wbh3dEIqLZufFF
         Ocy+qo6yTds4e7I2g2hYpvLCmf41utEglK5xsBbbxkpjbNdMjHl4cIRq0hUGeRXpJVKL
         UB+eci+6NKWqPuuey9YNkN2dkBm/RGe1pks1fkgRAuMm7ORDyh/QRgE7fvmsVgljuKim
         h4OeN99EiJ64gf8rCiHocXbgOemN/NQwV+PN/xuMtO9N02uBD8ZjjriSPl2hUhARxcMB
         2GJ7AexSACBIVZalieT/8sjkYoXy/YeRelw3iiCGbDV54yDTrQZ9Y+jtJBGb9/JhDl1J
         54PA==
X-Forwarded-Encrypted: i=1; AJvYcCWL8J4kzcsYcfZVzm6x4cO3sxGHK907ugqvGkE1/P+NqnNPDkZm9yfQ+qgB1rzJUrkYiDbkauNLJP0pCU6QS5mTOvCNb6Z0Ttc59886
X-Gm-Message-State: AOJu0YyzCj7fLvJIOZlFF++MqNIvgMMeMPRQdjMO0jhporQbeE+zrsHb
	WXe6G+/Hygz3tjyJlo6I5yhVkPKOR9nl7hnyLF7mxy4LRTvTXJ5+knxtcj/owgo=
X-Google-Smtp-Source: AGHT+IGMk/YlWYCQcj9bstzUYlzf1B2Mt+8v4lZOdHBd35dUk3+hk5LwYCW4NHTud/bjyL5DiQEYkw==
X-Received: by 2002:a5d:9943:0:b0:80a:9c66:3842 with SMTP id ca18e2360f4ac-81f7d035a19mr440179939f.3.1722011438283;
        Fri, 26 Jul 2024 09:30:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fa98dcdsm911843173.49.2024.07.26.09.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 09:30:37 -0700 (PDT)
Message-ID: <190987c6-d755-4c24-be11-1afb6ade852d@linuxfoundation.org>
Date: Fri, 26 Jul 2024 10:30:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 00/29] 6.9.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240725142731.678993846@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725142731.678993846@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 08:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.12 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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

