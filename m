Return-Path: <linux-kernel+bounces-399250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BED9BFC88
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459791F22598
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28FC282FB;
	Thu,  7 Nov 2024 02:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EbBlB+C6"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F5374CB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946437; cv=none; b=OfVuCqJmIogP1hRuCdPke4Fa1G6+RDaqh16/dfOMYAip6YzUkWReSoXMl3gRQujYEtBOl6ZC7/tAf1nPolD9tLIdBbVgqWVOhA33phv2gh+hXWZ+kuFLOwNpsoZyR5+NuU39/w1BhbeTIMuojJy9uNLD9UGlk/Spg1+AbIuGdlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946437; c=relaxed/simple;
	bh=66r6xIbtsr7gOmnkCVDORMzU1xLzP2MTzmFr5wrTId4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F56NN1FYJ3l3zwpNWx1SuBD07URNXSb9PFJkWHQpZRFxQzNrUqgBbsFStHT0pFBoyH0yYR8MV8wFcltA3yNfUyAsYizfjnp543aPHUtwIycSjGyOd13KsdFKm2u8uDN2GpEw2WXmZwVsD4wO9XJw/ulPW4aE+wwmTxbJuW4rfWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EbBlB+C6; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83aacecc8efso48171839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 18:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730946435; x=1731551235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4FH1qWWHPqfjxtFSCDAPzAW+vNNLwYck5jhkRuC++H4=;
        b=EbBlB+C6mf7iHciSZRpTrepmxQbxceALYBc0Ul39MsefmAqq0ovSsUNmJe9c8DudFD
         8ubTGLqbC7ZxqFLIW+l0avl/RodIQvw+eQATbnuya+CtxxpEKOW14mHemAEro6JaB4LK
         bRk9RAgMTXWudfuFhVXkJHX1Wmx4oEMHy6j70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730946435; x=1731551235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4FH1qWWHPqfjxtFSCDAPzAW+vNNLwYck5jhkRuC++H4=;
        b=FGDcM7jXQBCNLoi8VrBAYA0s25nOmxw4jwLeG0Q+sT89zDWal//ccK2ffg/GR9zge6
         jeKe5G7X2hMYReX1sRkXU3wVgPCCMxNYV8bDl07YPQqEsTE0EE1jSzD4VpWgzNcyDmQc
         493rdegLggqW6HoK1TRayuPNQY4kv/31YfJSAz82bcCNGDR51i2YV0aQpxfgfO037b8o
         3CrSdHR9RUhGrY+HGwxZJ8zMyGFaFnDr4HxAJcZTxtVUPZlV8poIF8TI9CG3SkKk9af4
         XONs48hDfHV2dlLXeN34vHt+XwNS9N0ztnYOy/Vc8knUDXzW0JktDbSUd8GRoMUbUZ6z
         78yw==
X-Forwarded-Encrypted: i=1; AJvYcCXY1V1kXiSuKGzNBz/kdwVwRx6hQ+ZHbHtMSSDZ+9x6kuulZFJ5qd0ICw7ycKTTZRoskJv3K1MxOuCdtYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaIVUNBXys6Pajru9+t4GF42769eJVB18eg1c2z8uArQw7pkQ3
	x+SXAFHD+JtCCLJ8DUG/CyPr628TkZSs1kltU+4hJs/xxXBXQpr5DU5NTSMmbp0=
X-Google-Smtp-Source: AGHT+IESzjzRALUubFg8iGwDGC3CrFswWkMFRdL0oHQ8Pifeb0Ths28JWJDs7h8xJNjRe6OJO4cxpg==
X-Received: by 2002:a05:6e02:1808:b0:3a1:a2b4:6665 with SMTP id e9e14a558f8ab-3a6e8964e55mr14571395ab.12.1730946434806;
        Wed, 06 Nov 2024 18:27:14 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6eacaa0f5sm736305ab.29.2024.11.06.18.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 18:27:14 -0800 (PST)
Message-ID: <0f9b8729-67d6-43ee-a484-4f58bd08ecc0@linuxfoundation.org>
Date: Wed, 6 Nov 2024 19:27:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/151] 6.6.60-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 05:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.60 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.60-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

