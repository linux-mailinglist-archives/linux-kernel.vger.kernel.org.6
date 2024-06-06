Return-Path: <linux-kernel+bounces-205104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045ED8FF718
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731371F234BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881A613C694;
	Thu,  6 Jun 2024 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PUZUJsgX"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC5D4595B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710871; cv=none; b=QnecnLbqJ14UkPbAYOoV11GUPXaU589DGiWO6XxxI5+p0AlLyltoTghlI7cNQ9Ou7ty2qfMZejgQSEIilEk2uRuYlA/ckM/ljRL8gFmz0qy20S+LKaBpuyNMuu33dQy/48RbkkfZJuN3ozdCVia2jNjryh399yfOC30HTkC6lK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710871; c=relaxed/simple;
	bh=vf0Ufb1PUxAG9pmi+PJkLABthEmCYjDOH0lbp8JYi5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CawKdOTvdRr9d/2ZWl/H/hJFXJCXmyDa8qVGl1893UiL8ozE6eIktcFTXjIs3M+VSMXJhLvxY39Ix0K6fLtCitFERvlaM7sivCPlB22PFYp7KZx8KTF9m4qhGyBYrIuO1OEwKTIEFivr0AuxuveF2ZLyeyvoA7H2bCK7z6xCjMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PUZUJsgX; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-37494bf9b1bso888075ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717710869; x=1718315669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7kNACQKOGLncpm7RzMHslqjx6wYTLSw1aGgkKbpYeo=;
        b=PUZUJsgXELXWjPPPPBxpMY8jtc1/zxZzWNonHzmrqXig5sFahwKsVFzhZjdoWMlqgi
         a6EYzVd4OcqcGr2Sg4k6tUyvtmUHBOP1fa3WF/CdQP+Zk93bstNr3KLMjzU0K1L5HRk1
         3Z8ks+4YDvq3oYpW41EHcpOduQ5WpkWcpilh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717710869; x=1718315669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7kNACQKOGLncpm7RzMHslqjx6wYTLSw1aGgkKbpYeo=;
        b=ZXrp9Dng0EMwTOeDEarkIqon+M+mtZNi1q6V4dolHzqElN0wd/SKvOsDMgfT7V5h/Q
         j419gQ0E84ffeA9V8LHqHW0nYSuUEHjKfPsC6kPRCyZkSV+DHi9ZJr1Bal61+C+gCkoY
         +yiLjBgV4TgsLDC29hHksp6NICQl/RvJK8HdpO8RhTHT1gjT6VdlEfVX8g8O4EUJiXvt
         ZAaTM3k1Y0EZsvXbz4HkyMFWWXUXKc08UP3FjsB/qdyN4tgBsL5xWjUNwX0L/q6WjR0w
         dUov4MktKUcvQC07HYs9daTmcNGTFhmK0EjAf+6fDYFV8E6+cMJR7Gj0Avm+3UO0njva
         G+lw==
X-Forwarded-Encrypted: i=1; AJvYcCVwyRrVq3ct/k7cXT1ylz4xvsgkUMCIOOzTN6t+R+JyPLpAg6sp+4ry7Vq7ZMlgedb5h70kYJ0yR32b8zX93MmzDMCn9gbqF3D7RJSG
X-Gm-Message-State: AOJu0Yx8ZbFb1uOhB9moCsNkhayMVrbLivGaogUilalNfct62tY626GR
	yG6Qi/GjtsVmAoEG2GfgNzRT8BoX7gOEU4ZQDoHeW16eIK84s96Xf5oJCLplJFU=
X-Google-Smtp-Source: AGHT+IFeYU1/9CMMpnp75xeWU6hrcbz7tB1Wpo5gtKz1fbyTfMJyQbcsjrriRgqavCvA+akIdoDifA==
X-Received: by 2002:a05:6e02:1a8d:b0:374:9cfb:ee13 with SMTP id e9e14a558f8ab-37580236023mr8495385ab.0.1717710869435;
        Thu, 06 Jun 2024 14:54:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-374bc12e61csm4847025ab.11.2024.06.06.14.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 14:54:29 -0700 (PDT)
Message-ID: <19aeb72f-e1fd-476c-b5d3-ecdd22597cce@linuxfoundation.org>
Date: Thu, 6 Jun 2024 15:54:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/473] 6.1.93-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/24 07:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.93 release.
> There are 473 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.93-rc1.gz
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


