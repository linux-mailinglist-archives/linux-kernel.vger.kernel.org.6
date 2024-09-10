Return-Path: <linux-kernel+bounces-323971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F06BC974644
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6666BB247C9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB4B1ABEDC;
	Tue, 10 Sep 2024 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TinxxfrM"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959FB19EEC8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726009996; cv=none; b=sUIo6wugnASS0klZBm/GHugXQpaQXqnOZlZ0lJRElK59Aed4lLoEUlL8Qi4EREM6kwRZxqlxyCUCPsJNmRrCVvnCxHAKJnWu07hDP/zVl6cXkwN3o5ngRA81Tggq37HJnp8/BpQ9rd3AelflAGEwwK8dDttz6RjAx0Y/4dtlBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726009996; c=relaxed/simple;
	bh=skkOgOVrk2rz6JTfzyf0B9szj/KCPd4ttv8afMLEVBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+OcApeKpZ8JsBnHWowkGQUIq7TEqs/degmPvACBbAp5IS8oVNdVBVTO9RPrprXyT12VhHwFA4LTV+uz0Jokz3Te6mw3QCXZhrK2+7snq0Kz1YjRU2cPbQMNHs3u7G12REnsCCbMQeoamFOdJK0zj5iW6I8ENKgfJyv6nICuvys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TinxxfrM; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82cdada0f21so146326639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726009994; x=1726614794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NB2gEKUnRkYZypGTHLojoU4Xifb8ehPDDVLdPZ1Wimc=;
        b=TinxxfrMLWZRjaYgK0Fer54VAxyRzxNaZKPHX4H+m0v2OQusuvM1ByN4mTbcVWTntV
         MxPZlx41U3i3atPTg/xpc5aYQXMdiJgJWV83TGZrCvWnXxn4WgAqYw1bo32KKcciBuqd
         4mTRFUE7UyQSnX7m+Cx5Bm6FI4ymDZYL7Yayo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726009994; x=1726614794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NB2gEKUnRkYZypGTHLojoU4Xifb8ehPDDVLdPZ1Wimc=;
        b=Er19OoE2or6FerjU0z7/LEfK+xSkG6ExsYWIhCmTvVspKNca2UY8jbwGkcpCSinAdp
         iY9izcSDX1s7bfbE1Hb2qvPz6aJELXy/Cn1UfkZcUqfJ1NTawzGJzF/wu7yrxxnbgFMS
         n0AiAzMNMini9WRJmO2QOcEXB5Tg3rmo3EZh+CIV9GX09TagoclpjPD05AedihMvZdZr
         /SOBw5GND4neZGmKOEVRgMS3up8ZZ0uhx5+MS8iw+0VUUvsABAIOl3CcyPw22CNZ0w6i
         N8XkwLzbkPYWMGbZ8AIBYfNkhOnhajz34Ib57rBLn3LVHOYVhoVQsvYFKJRJkFRGLQmI
         Cdbg==
X-Forwarded-Encrypted: i=1; AJvYcCW/G3EGCQVOD4hjC7rvgWxy5mnpglxbeSc7Z/SVgp6fVgIKrBHvgpvbFHFTvu9BoEd3vl5D0hOWZIyfZPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQfh3LOot7PSVXpkoYfpdYNfb8g0DPtE8jQc3qRIQpvOK2eky
	MUHoEkINeqkcs7d8YPuK/0QIPiFbOY3JEO5evqjT/r65sZRopntATe0AY3iwcuw=
X-Google-Smtp-Source: AGHT+IEeEWIUJMqZZjwDZ2RP39n9JJ9BSDpALYkvcGOf6VmhkOy+w1lJvYj/0k3BEF9J+t5LDNTr7g==
X-Received: by 2002:a05:6e02:1fcb:b0:3a0:4c4e:2e53 with SMTP id e9e14a558f8ab-3a04f072f13mr158108345ab.5.1726009993733;
        Tue, 10 Sep 2024 16:13:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d09451da2csm1860392173.27.2024.09.10.16.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 16:13:13 -0700 (PDT)
Message-ID: <2c086ba4-c7bd-47e3-bf12-d3c99a5edcfa@linuxfoundation.org>
Date: Tue, 10 Sep 2024 17:13:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/375] 6.10.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 03:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.10 release.
> There are 375 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.10-rc1.gz
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

