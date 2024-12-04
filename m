Return-Path: <linux-kernel+bounces-431664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB4D9E4027
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C22928373A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD70C20CCD3;
	Wed,  4 Dec 2024 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N6ZkR4UC"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B4220C49E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331323; cv=none; b=LDkQTngJlLiLD2u6sbmYAIrcZHU0bUBwFa42429mGK2vhusaBqZr63fRAIE6KKX4t6y6JBPNc6S3sCt8RvyTpX6p151kENA+Lfq2Pgp8+H2iI1AJW9XmkuQqBfvmRozM1HeXkEome7k/b0aCYRXaHxaNf4BzIVPlkXMEJvviUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331323; c=relaxed/simple;
	bh=50xntMHu6DoF5HbqKeUR5WTuI4girmXp5E2jTq+5v/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFdL7BGrvtSOZ4Q8BjGPEvD5ngdvXYAtXcQXWzTGqAGflzccQcAhlQooIJx8twJidCWvei2y9MNvknokq8WQzVbrH2mtsN8N3ZKOQ0CipesODHGG0bLGFG7gvBgDPsrDhJbLgTWe9JEUiIzqaz10vGCZnUl7QeYpVXB6PZ330is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N6ZkR4UC; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8418ecda199so246107639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733331321; x=1733936121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9rvImidU/UNWdG1VLr1J9XNVi7IRCZUz2k0Jnz9nrQ=;
        b=N6ZkR4UC9Lgq49C/EDseGDRNLAYcxjF6gIi24ayZp3U8MU1v3YQAAxV3cChLHUcKhs
         TPMSO6bRBi7lAlORT8ZN7f8FKyuWuvMHMYf2UIZNOHoulTFrUnMj3G88PHuwCS0+ZOBm
         jmpV6KclhoDQ1hAM3Kpk9X3KYxJkodgjycsas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331321; x=1733936121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9rvImidU/UNWdG1VLr1J9XNVi7IRCZUz2k0Jnz9nrQ=;
        b=f97TOhDdynGzLVFjmtp4XWuFvKAIkXNpwjqYKHJGfHEp9I3OUsnj93Yk0PDuP5gzhM
         M93pbZJNt1CWaaBjBVIZz54ZP1nQCqB38ACd8PitaO/3NZfCFC6GIGsujt4Ptmi7ef/M
         NAseKONShQdXjSVq/lwjLyTBa6LEMlZ8fMXHntZUkq3q5fstB87OeRU3i6EzBQe2iF85
         /93ffYwf3nePSdS+wFkOwQih56hIrTEbkMqCwWSJcDXpFEKJ3mJPD7/ajsoIs4uugWVq
         IZEX4MYKnOW1g+nb/bLaRQV8DMSAVYP6HlcfyRtv2ddGv6ozOzg039dxl9KOj3owImHK
         DniA==
X-Forwarded-Encrypted: i=1; AJvYcCXv9VFMq5zvX/DOVQDqjVg5zAL2SpNYbNhZ+cUxeCESal1EJ/WKv+xpse8QdNZGiw/0C856D/ijkVUGN9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZIzlFNm1yDTbPYa6xn+MO1rVPCwCLdC1DGCnjmXi21dc9zDaI
	UI5CZKe6E87a9P2GoxrFsFtkPkqvnmRV83ai9aI083vBoC6m++BgEKRdDHt8x7U=
X-Gm-Gg: ASbGncspIhfTwsVcTbdK+QvFYn1tRC2mDCS/53aQMLFuz9eTJTJSTIPYFT9qTMkQJjY
	5LXFPEb/xV6dvnTASDSKFakEWDNwSoMP6KgBZLum2EHz+6RCiVBmH/UFIwlqg1CJHUUHMZc58LQ
	bT4vGCS0wIUY9xqSDpMtO+CVUH3exfBB3yIQByGAgj+BPOpNHkURZHYaHs/7EB1o22PAqrl5572
	fM4hShCfSoYdQMooWUL9QjqvKQJSR83/qbkf4JzTpeoZrxa1urJ/POOPqrkpA==
X-Google-Smtp-Source: AGHT+IH1/7Y0wwlKffNss3OdZLCieQ6uhiHOEWOAMvcbuYpAzMo+3UlejFx+5ubYj78zQviYx9B+Wg==
X-Received: by 2002:a05:6602:2c8f:b0:841:a9d3:3b30 with SMTP id ca18e2360f4ac-8445b53e299mr913854939f.1.1733331320966;
        Wed, 04 Dec 2024 08:55:20 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84405f97db8sm322266239f.34.2024.12.04.08.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 08:55:20 -0800 (PST)
Message-ID: <0218c67a-20c1-44b4-bacc-d392d8163d96@linuxfoundation.org>
Date: Wed, 4 Dec 2024 09:55:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/817] 6.11.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/24 07:32, Greg Kroah-Hartman wrote:
> -----------
> Note, this is will probably be the last 6.11.y kernel to be released.
> Please move to the 6.12.y branch at this time.
> -----------
> 
> This is the start of the stable review cycle for the 6.11.11 release.
> There are 817 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 05 Dec 2024 14:36:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
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

