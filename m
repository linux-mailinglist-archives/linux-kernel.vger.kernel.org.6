Return-Path: <linux-kernel+bounces-399264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F789BFCCC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CD12836B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183CD143888;
	Thu,  7 Nov 2024 02:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZuAz+U1P"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2269A8172D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730948259; cv=none; b=FLnrP9yRDJrFgV26lg3lLbGquBLJqBrtbHYGam9KkpPEfq/kUdNWOdL80SuDyRsMEPub7biXiY36M4w4mUT04kxy7ySm28C2y+BL8mMI6ozEFDiv/JWxbOIXofBwAzXKFK918rR7yN0LZNfvi+7QIYO8lYPHO2lmBMOWXY14pds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730948259; c=relaxed/simple;
	bh=HBVABVvxbDZbSdWxMmhCkzobnKr8e7PlcAHc5r7VUxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYiShJcwAKCJ4Y2zQlEVWE5EtgyPLDsvtAiLcOuuK2S8ZujPViGe4vzd3bwUauN72l9jKhtS3yAw9DvnOxKGCcVvw8Wt7ot3V8oP9oD6PmJWiBBhb8lfgQHgPXwoh/ZCgvwKw8BFz2e0nzWVPerEUxYURURZ6Rnw8PCP2+QggWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZuAz+U1P; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-83a9be2c0e6so19349739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 18:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730948257; x=1731553057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnWx8Kk/qOehULMa0Y04w3YMnjalm73MUZBqHKYkraM=;
        b=ZuAz+U1Peb5IO5nsoDc/rT20r+xTjToVFiX55McJoGXSkFL374lsIKctw5fJ+hcHR6
         VjL5ZcCgm52U2p+6uAn6PVsLjd29qacg07F1IKmKzQ94xE1QcGGpRqkxRx9NdZz6MTwH
         2zBfpTkQQ667TbO+oLu8OuxIvN8z/E5W8gLdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730948257; x=1731553057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnWx8Kk/qOehULMa0Y04w3YMnjalm73MUZBqHKYkraM=;
        b=pGvJ+P4JFrmUTY71WFr03fgDdCm0wtfIMZFYgUY6xe8eLtv7VjBpR+Iw6TORNSQi/n
         bcJp/4Apf7Q5ku3C60VXNFcwhFpd8vmBOaONmdfwOUCLu5jLXCyOSnY4HjoRrYy9F6gB
         6cs8TWh/Zal0iYkmiJ9N2oAxjYlBoVQXIOzSlepNQ14NBISINPQE68OBnXcpqEJDMBwW
         NTnH2Y9tv+6QKxq9ysrz8DY4jTyGU6uIqa1X3q9fRf+VpSAetsGQOIXi4bNkAXERT4YW
         ZUg80mtYu0JpSK0TQFoikWz56HipbzISq0F6vawqGGR3YhrqkdY+b6d3Vp1ajb3VD3UH
         tx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzKi7BmMLBYNUVfonvc3lGRvk2+fbIPWtzQJJ4FFd/XPEacybrOitmR9hul3G1fyOh+YTNpWGHP8dxZZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuCo2vIozd6/Radfgin5je5ESGL42x94FcJl+4uuaC1GmD54+h
	81Ybk9xBuYf9uzg5ECwS5X2X2LrjTtrCgrZ01CjZ8SAJv9X6NoiCCrGnErfjeeo=
X-Google-Smtp-Source: AGHT+IG0JS0I5G++8zt4aSSwZVyZQIhV0US2uvA73OFyCmrguDefvjKXqCjX650GwNJDp4J1SLl+Og==
X-Received: by 2002:a05:6e02:1a6c:b0:3a4:e377:d906 with SMTP id e9e14a558f8ab-3a6b021b260mr241438385ab.1.1730948256767;
        Wed, 06 Nov 2024 18:57:36 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de5f82e81dsm117809173.70.2024.11.06.18.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 18:57:36 -0800 (PST)
Message-ID: <ee29d620-2e82-4b2f-ace7-6be9caecc60e@linuxfoundation.org>
Date: Wed, 6 Nov 2024 19:57:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/462] 5.4.285-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 04:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.285 release.
> There are 462 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.285-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

