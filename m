Return-Path: <linux-kernel+bounces-556523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7343A5CB16
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89951189E6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7E26039E;
	Tue, 11 Mar 2025 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WhVNdgTZ"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DDD25F987
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711642; cv=none; b=fUkov+QNT8y6UuK/BShz00nxy3BZElRkLWWE3PcgpjgNWhOhxN69oRJV7oMGMA82ucn0BRSvWi/LtH262NVcsXmwU+xUtAqIHVTtl6Sk4fyodwrw5r+p6ZfMpD6qKOYR4HpYnymRHmjvrcczNo/m+KXBQVc21MwAS9AFxH+aQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711642; c=relaxed/simple;
	bh=Lr8zNkZl809MOIhPoVDsIbz+X1gMtYCv3KwPHC+qhBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYClwmyAe7Bj8bgHBRu2RUeWXBUeKj2ZbUN8DU1aI4sDyuUxSlWKTzFaNdChOjCMDWe2zsNLToqmCx1JO/JSr0OQs31wc1fh4IqSnAJ/GGRDjB1/LhYrfOKejKeT3yOXNPB6+SaUa1Y5d61FWxao/4aPeTYawyBpypI8DtWj4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WhVNdgTZ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d46693a5e9so12236035ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741711639; x=1742316439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ya/SCcQg5pOPa0gL5x/xnC2JbLciEJIK5frt9Hsnh0Q=;
        b=WhVNdgTZGscIrlbv1ogV5D0g01Efnnjo2Km5DTLR937E0xghnmOUxseZQCS07oeaQA
         lmozZz7RjNcLNdKwTC+LnCGNGHVhsQwR3lPZ1cziIaCFICknJLOVRHNQ8flzci6hB6gF
         fFpoTQWjSJp/sIvCr6lFZ3SvNUFmjFLxYyC+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711639; x=1742316439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ya/SCcQg5pOPa0gL5x/xnC2JbLciEJIK5frt9Hsnh0Q=;
        b=VTgrGnqcQsW+w9nHo0tb8B0qxgiIuBmTfrEdb3TpLi1eg8XVXx+Hctzv/dU1PgLRBV
         +UErEF26c/jAbtj8MeWZazq/P061Y5R5uNUfuiegraKbO9DjralrU18YkuaJQ1q+i54+
         YajQ9KqVQTVYXVV9n1c8SSpKrNdN2FhFa0nyc177DgHJoPrkUCJdSDSgLf3zBvaRJgEQ
         r43RlO9cBR9EEeMlhr4BhUP1NKGHh2QUvQaOBUKOYeP7JjckHJTqEzo8wOjuGW1kME9q
         16apemPd6jjUp6R4c0c/pZD4h2G4qHlyCozVccrZDnoRI9wYCkBdDigCPzl+YMzV7aRf
         jqWA==
X-Forwarded-Encrypted: i=1; AJvYcCXv4EIxutb/zx8Jshz+ZtrPs7614D/Vs4QyFBKn2QH2rnzV8araTjMI8y5FppwndDtByETQVlUNs2Nt6zE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1HWBCO3Jpt1DobXugHyA3F6xIoHo9iwRIHaCsBCXu2i3NNjw3
	m5rDC6Nd+umdgVsexDhO8kNxTj+r3LH6lI6Kavk5fmwezdDHF3pBkbPnO8dNeF8=
X-Gm-Gg: ASbGncsDYorW/XGweKO3mCCNtzgBHb61Ho53PBimc3R7apfetvgPFmwt2K41blSmmcw
	jQ2UU5zRZEXl4ajfpY0Jy21icc6IJjtUNcQDIpeCzwijmbpiWo/1PrY6p7fltV1XnxB/TOCAVcv
	0pzjd61k7k+wcAMDBu4DqC54AF9gDLOO82ptxyarfSRCwpDphkUQEwzpVr9vZnmdI39GaDrAZAs
	UzYXBwDLbMjTjOcN4B3AeD66ySLoq79YWq9tP4XhI8b7Hq1M87Z1gHAQXG+Ba4s4fLOQGqL4ti6
	6OxbLpo+V5HRx0Fld4R3rzH/RbKSx2QeMPnpougzbdp6+fegFtnu6V4=
X-Google-Smtp-Source: AGHT+IEQgCPhuww2FzPObKtYHJfNUKNZ4AwdoQI2ZwzxZCEL5p9J6b7jq21Rn5Xq7Ea+2Z1UlrfUBA==
X-Received: by 2002:a05:6e02:174a:b0:3d3:e296:1c1c with SMTP id e9e14a558f8ab-3d468921f95mr44132895ab.9.1741711639211;
        Tue, 11 Mar 2025 09:47:19 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209c55460sm2827091173.0.2025.03.11.09.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:47:18 -0700 (PDT)
Message-ID: <eee86dd7-68ce-4147-aeb0-e009aeebb80f@linuxfoundation.org>
Date: Tue, 11 Mar 2025 10:47:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/145] 6.6.83-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250310170434.733307314@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 11:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.83 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.83-rc1.gz
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

