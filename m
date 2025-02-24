Return-Path: <linux-kernel+bounces-530239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 849C8A430F5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5736F7A4464
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89F81DD9D3;
	Mon, 24 Feb 2025 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SX8pR22G"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ADD207DEA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440049; cv=none; b=hk9POJ6vNvtseRcBDqzgRW244D8LlHw9CnsAmHjsJWQX65Ya2Bq6m97GZl9XyLVhGDnLS5EVx8lZ0D8sU8RbH5m0cZPs4s6M9boIt96c82k+x1LE7iCupDpyRHjB+gr3Q4kebu2cFoRkfqTzwC0xxO9tvJ7H+k3mYfT03q4/O1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440049; c=relaxed/simple;
	bh=scb6E/iGLRkq80b8k6U/vzSP1FLlrDnpwz0XioeQPfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiVjZ7d/Lkt32VJXBpFBL4Ljovn7r2dj3j0BYtnYWk2JyHrUYYh+AQcE5MuMrfGzfAtH4OnVC4jPTynM8VNon6DmIEAiFHGI4ojudTPR1nJwjscV+sjl7+sJpKFLEU+aOBvC4CqkRqR5vIVLsKUxKSl/SzirIYgQCsNZFFoMtPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SX8pR22G; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d191bfeafbso17074245ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740440046; x=1741044846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KjhyzijhKip7FfXadwTT9xIm71M/ulVqGAx55Z5jtQ=;
        b=SX8pR22Gj3TXJYmXXCqsCnPFVWWewdXH4TswIyDJfLmoIvbenQb/FJsnKfnnyJzfXW
         utHKS3ze0RCsnbQp4oJ8O1smiEM+hfz9KzjtAGedGp9PVNmKDisl/rNZyeqg1VX14Z5L
         Om+SPYM6xgJWzlV5fMdhFg6HDUwO9x5n/hIpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740440046; x=1741044846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KjhyzijhKip7FfXadwTT9xIm71M/ulVqGAx55Z5jtQ=;
        b=IAJ3z1Jziwhs/pETY5Lbyo5yElzfNmZMxRXi0ljwer4Dp0kCvNLLKfgEfGzpUrYMhC
         yY971s3hLK3PTzNg0ixiVssmlqCtS9wLqq8vcg+FrA+hb2SHYcO12VTqVBR3cXMezcB0
         VhXPOFAXw/T9tVmpadHwQW2GjBo499fBrBiY4vW2q8OQylrKh++i/fpF6+whGu4G33+/
         eMkSdXa+45C253PLTDjqTCHtfEryKimL12ace/Del7VaVuSFfhCcey4GtPBzEYrkVj5q
         r2BpjW0GpsrXiZNSowXI8TJIFUe6Kfd0cuS6aUz2gzSdm9lwps2vKY9aOzADptIlhS6T
         xE8w==
X-Forwarded-Encrypted: i=1; AJvYcCVrTQwC4um2+EStrln5NGco7Yjif0U6v4NkCM5rty66m9Uop+KTDwKWsx6Eu1Sr4icZmwymZVbVbtvimGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuX58SIPLm0LOBeBuTjGrNU1D4YVl8jVD8cjn9BHSlySK0ntFp
	tDuE1d3132gzQdtRSmyYXcnCqb8YNyRahioFFgD5laFH45kTmfBkay9dA8++AH8=
X-Gm-Gg: ASbGncs1VhbFVUYaXgC2QOyUXKiuasAvPIETnHsFsJqS1HtNl8qBfC4y4FwfAyAH3l3
	q+NaWMmmxp3e+rMaD9GoGk4XguwkkKs9048clbMQ0zC6nki5Juts2JkMVeMjj3eBTtrDQbk/9JU
	Zt4hxWshmKN916QnRvz8K7xTUAV4zbxYlyQ3LBwjIJAh2a8r+lqd+UNHsYNhZKouC7HfCakUZH0
	pzKhtJMmstrJR4VJb9Iv3Y2Xf3VEn4SHtEAuhO8pYB2XhlnnZukJnE2jIS3LSXv6D173nS++Lwi
	u6ftrZyYGxc97OAiY+PlHDw4cvNxgIDZEUpA
X-Google-Smtp-Source: AGHT+IGYWotOFGyKz9ftjHFF2iZ8yrfovvsX1YqrefW9illRRiARYFLhIqcWOCsOIn5Zr2EynOZ3XQ==
X-Received: by 2002:a05:6e02:16cf:b0:3d2:bac3:b45f with SMTP id e9e14a558f8ab-3d2fc0d9638mr14385945ab.4.1740440046590;
        Mon, 24 Feb 2025 15:34:06 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f04744ba1bsm131759173.25.2025.02.24.15.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 15:34:06 -0800 (PST)
Message-ID: <8685f243-b3d1-4ce2-bba3-8e9cd8a47caa@linuxfoundation.org>
Date: Mon, 24 Feb 2025 16:34:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/140] 6.6.80-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250224142602.998423469@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250224142602.998423469@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/25 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.80 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Feb 2025 14:25:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.80-rc1.gz
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

