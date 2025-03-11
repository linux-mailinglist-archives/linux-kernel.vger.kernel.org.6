Return-Path: <linux-kernel+bounces-556521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F00A5CB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2A63B8D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763EA260A27;
	Tue, 11 Mar 2025 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KybhA1Q8"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2970F260396
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711491; cv=none; b=QwByFrkLZMyUo5+FFHKQe/o5IYBYKjjrjODquGA8b07Wyd5e7F0YywpKgMMHTop8olBTHBFIxN7ZcWEQ+O2Mbha/TH3Oqm32KwycsUv7m2bay0Jdia1VXnvgLADUWC2aitkXGW38WqWwb1fFi0WnnYtiGHno4A9srLD5oMEAZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711491; c=relaxed/simple;
	bh=CFlZUAocSaDCXWGn3dMPc0Nzh3K2elHq0BNPfszI2Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpGdXHHtj2iINj8cOgGAVbucnxkYkfKBGLpjcW5Kt6fzExSXuB7/b0Ah5nY0q4n8kFFes7xE2gWcFwhA5Qg5TAhbQ74vubZzWObxTvgLGqmvWmuCXewX/IEgLe83U4IyT6K2WYi8BbwX30op++oYlXGnRufx4IRFPNlRaWtuMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KybhA1Q8; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85b44094782so95935039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741711489; x=1742316289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrH+kNIJIiWCh3H6rvZdYxZUqPJqXFDTzqMH9zIOUuE=;
        b=KybhA1Q8CjzcqS+1d/wecNEYPoaeHvaDB4CLHsx7Mt8i/PXHOWYytsTsutuu9X587a
         9zUsKEmqI2aaJXMqLp+4aIzzZuY/Z483XnKiuyXVWjEI9JEcByYBW84OMpPCNydrxcbd
         rxeNc+LBDqbzoYDV6BufUTLH2q028cD60sO7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711489; x=1742316289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrH+kNIJIiWCh3H6rvZdYxZUqPJqXFDTzqMH9zIOUuE=;
        b=tDQ+0CiAj0VSijnK8na1xheWPsd+WZODijnsJQw559sf4yyTifQ7ryJut6egNFfTwC
         KwB+1j0BrnpCMusFWbGUg5rGBTlWY2R7zphNVfuK4O5bbWsfIWHAPtzZaIDlA1Zm9QRW
         IrwlWNHspewzbzNzIccD76Ey5rsspJIgFdBaUKt84xNNIuck/JtCRrKo1txsZgHIG+bk
         53TRJYmYsUtPKmTCT+Ti4DECt1EJ4iTqkblJDDhPSOnyVPcrOEwn0q1aAqT/v9eDB6Lg
         lMUlZ5rbavEIEJv/uR4CfiZNNVHG/VSUYvGxAkR0B6FVUg2lo+iuaTtflAm9Uy99q6RX
         GQ6A==
X-Forwarded-Encrypted: i=1; AJvYcCXJps8/h4OZHIvPKXOvFr6IbnKhzt92vUu/n7CP03ZE04o7Qzxj78MZPG3TAgxk3OPolTzFIYgfpvUpUxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjJm4+X0k5neWSUW3Wd6aBbRp+nCSgXt/gJNJjc1kXlfxOibut
	QH/JrtCqvmQglgrMobuWdJ1NYShmx8Oliuovx8BFA1w7ghtyVdzU8nmP2M19pKTisYW0Xg/Mh3g
	Y
X-Gm-Gg: ASbGncsNkimkEDV4BBAgU8sRrszu8HY1aH8jo4YohrpQpWoi40FnC/h7ue/VS3qekvB
	wJNzVL6AgIMjKO63df8i7LbjIqGTuivrsf3vt2V2CHnVdsFXyoiL9z+JJvS83Yumnd+9/XxgHt4
	Edsqd3g0WWAqEJAAuHtsYrFctzgW6CWbi4laPWLfyk+8owpzMaGUQhJwTtoopNUFsbZwwpnfChd
	a7q3D1/H436e9GnzGoKpKyGdX7rL/M1byuVGsh79pw9Ey4YNPGe8IiOuqFoHQZfPIC4pBe4PBPn
	4Exd+FkyyPn+Axq0rKzyoyW72XHMu0Eo0egqSt78Of8Qz45zbD6gPIc=
X-Google-Smtp-Source: AGHT+IHrb2zFlSXoeeuX8IlI/WoFm/acPhdpIFoy6HtCqLdyW+KyMDolqqVQT4wQsO6WnDlvn4+BoQ==
X-Received: by 2002:a05:6602:3e81:b0:85b:5d92:35b4 with SMTP id ca18e2360f4ac-85b5d923763mr831411739f.3.1741711489174;
        Tue, 11 Mar 2025 09:44:49 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f225d0af78sm1882165173.17.2025.03.11.09.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:44:48 -0700 (PDT)
Message-ID: <df71bef3-822d-40b2-870f-ba7ada74580a@linuxfoundation.org>
Date: Tue, 11 Mar 2025 10:44:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/207] 6.13.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 11:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.7 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
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

