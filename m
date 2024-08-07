Return-Path: <linux-kernel+bounces-278588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF01C94B239
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4279DB22B2A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EF41494DC;
	Wed,  7 Aug 2024 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IkBMK2Oq"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13E1442FE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066489; cv=none; b=t6Zwp1e0oFisGnRvhN4cE7uqteoiqrk+T6QggL2ZK2Mzasx9swyhwHJRht5K7hPZX56sMa4yGWgXohFBfyXq/y41N4yiguua4EQAO2T4k8AC5nqSW2wzaZquvbzVg/9Rim1rXgtY3bhptK60S/WXwid72rweogXdNcvZ7tLbEss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066489; c=relaxed/simple;
	bh=L5D6Da8d8PDLUP/fPT/55SXNoHUlfgsys/gI4OIfhvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBVtUi7s8EDqqjDz9e/kkw7FCL7krh+lbPa65cQQ8/nvDY/Tzf7ADyA5y++aqR60lPg+3DyOx14Cw0dsfRj3BceXe4OzygFPmGC5Z6XWhG3XqORaaxLS4b9jWj62BtDgs/JxONg5mXKbVKZS7eS5FaR8P29ThzxnZQyLPFZkBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IkBMK2Oq; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-38252b3a90eso280875ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723066486; x=1723671286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzleT9HD4xqdpPEYR+tWtbUQCAn3f2oq3BskLFI5XiQ=;
        b=IkBMK2OqpuG0CJJfzWP9EUDqTADBSqnmqKuJXmCT156WwT7vUpKHC1YUWc+9We93FE
         WLliEPLsrguIIyjmoDx/6+gz3dXk3MSGolXDDOEALen3BASv4BWgHL64T1GIcVLPaDoU
         N2TA3aDUhN74K7yALAbO/ucZ4wr8H04Lllb3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723066486; x=1723671286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzleT9HD4xqdpPEYR+tWtbUQCAn3f2oq3BskLFI5XiQ=;
        b=K5vw2hjUQsG+Pwe5PkoBUBdE2tzqEvO0V568ZnmvjCcJxxMNwUJtuHZaRQVPfgdYRw
         JJWQdZOF9/VijEF6+mhA4oY27JznQ6T2faqIRL1gjk4mvuVK7zhTMvV3Ar7wAxdK5YQ2
         zSHPSl5u9crLN4yclObbvfIR+UQsbZkHGe3tvbAwKVDdZnXOWil0WwhMbQBLCQ/FeCBH
         5xd58d9EJaHiVujQjvT2y1uD4Bl3/nPBAHFrPHHjMPXBKb0WDBcLVVes1rB/Qe3+ObWn
         Kf+tVNPU2rL/1Gy6tRWgPsxSOcVGnoX+05oIDgNFFN/tIrD93VCCZ5JZRzx1TgfmpnrF
         q0wg==
X-Forwarded-Encrypted: i=1; AJvYcCXrWJT8RDjyv/+++iCfZI4vlEprqp+xb9EMT45Yb+DzEV60mUHxtPwvOWFq9+Nf3/ojQ8jb3iAF+j2WcSpdpe96sbHZxoqPYhPKjgcO
X-Gm-Message-State: AOJu0Yxa6lwwjVPv3r0vC+JPY9NMiZS+BndmcoY/4THQiWDWOHfwiHxY
	P/RX2GQkLcDTteHtSdlButaaNJFvMvfY03Ew6aDKT74KhP2qnagXhD0z9aNwlkE=
X-Google-Smtp-Source: AGHT+IE/iAvs+xq+B9OSJ95PcWTsUGdNYYT6r7pEyPXJdr9sdk19BaDRTg4HhsAlyDZFSlhat9MsbQ==
X-Received: by 2002:a05:6e02:16cc:b0:39a:f2f4:7ead with SMTP id e9e14a558f8ab-39b1fb5770bmr135522395ab.1.1723066485702;
        Wed, 07 Aug 2024 14:34:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20ab4f73sm48137485ab.39.2024.08.07.14.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 14:34:45 -0700 (PDT)
Message-ID: <77c85a59-c9bd-4a04-a325-e205aa2e1df3@linuxfoundation.org>
Date: Wed, 7 Aug 2024 15:34:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/123] 6.10.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240807150020.790615758@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 08:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.4 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Aug 2024 14:59:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.4-rc1.gz
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


