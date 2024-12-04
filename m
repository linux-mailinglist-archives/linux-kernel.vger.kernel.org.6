Return-Path: <linux-kernel+bounces-431668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145789E4138
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02C0B3AB69
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E614920CCF0;
	Wed,  4 Dec 2024 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YXfjL6Qf"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459A20C49E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331422; cv=none; b=pw/XgXJ7Tqr11RoIpNqKwYVklKz3YrP8xc+H+enSFmLXqWvhn+LhlURQNPRj6AkPPVF3yeymsVFpJM21o8XJ2o8WbpMzRO0htjc7q6Ykcedqr/+qXKSVLm9Xy3P+yXFEatyKhVIW/ipa//Yhf4Ev5H1ZB5DUZJUWvwfUkfaDoLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331422; c=relaxed/simple;
	bh=XaoMXII8e6mfuATSLsXtjEWnRh3UwxsQH2bojJPG7NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuRS0fPJZbMk0YlOjRDcJe/pJWPfF6OOA2vuRiJZkUyRJSsfkKZ/2dGBEiDV883r/b/aTtVL6BOSeSm+0Xq8Qpns7T7SW1eyka5Cl6VwhbIKHTlsukSVSw/AhZ/8y8ZbIG6wzMOEiLtMwhjoUWGEtoNKTIxpkXnsss/jBrLbQ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YXfjL6Qf; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a790d6e782so29209075ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733331419; x=1733936219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iTXrzkVbRdOn7ya7jAgMy2aC6OZ+AghQ3qdoT+WQZ8=;
        b=YXfjL6Qf7iqmC5EujnCqD4rd/5wY14LEHuMK8FfQfxCEbVDn3lObDh9PrpYoRtshh4
         hnd4lH8pIZxucE1n85k50NkzlXbBIzcNJw5We8xQiegZhRmcghhKsAIKPD/TZ5NYf+d2
         lX71pTROwjTskPsblJiRWtUOuMmry6pO/OkdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331419; x=1733936219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iTXrzkVbRdOn7ya7jAgMy2aC6OZ+AghQ3qdoT+WQZ8=;
        b=PEywbWZqQHdr2AXTyG+hrif5fSgRxCcjm05ZZpUDXpMcrlQk4VhT3GM/WtMLgls8gx
         qUIIleirHa86c3KANS3fvx84JWavd6/CLw6QJJM932p5OLakm2ym4HEToRXc0SAhKs0J
         luFsgbRGih3zBWMZ56aKx2iWxX4YtvPztQaIctInUJFsZtoerLaUUS/Uf8ApHuBBFfCo
         QD/PrtzSGmcceChoTeUmYk71g4ShwysZOWSESZz51dyJJEsfQOVWeIzULmMf5VCnEm7O
         wytQ1BqiR39exyTBPziRLHORbtTEXHmZgf0rq9fJeD6qNahIvCvO61G1JLwxq62Li2+p
         cCVg==
X-Forwarded-Encrypted: i=1; AJvYcCWpDngyBpam4mDcJvHCmqLZfdUMMFQ6O3Kon2mWkJTkE7ZydA0I1mvzcJijAkwxuEDgxwVbK6oZptZEHas=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWDcymn5AbqjABJKjEgwPT7RTxaAl0Ea5VEC+7tDm+hTogPR0
	YMnmDD4ciBRED5HWHrtj7dzpuXYjteLKlV4fZkmriYwNWWhqZoypIrfY0ZfHRUI=
X-Gm-Gg: ASbGnctAtU1uC6cvkYKpYC83symn9T2sBD5b4AV43//JKaePh/OP2asrbQEI8154zCz
	Z5S1Q5jBrd80/wTW4SSjRb4nyactEgE03BFia3QyA6JqDi5HT+xjj0IaWcACdiwZX7mY5kT4ln1
	P9SGJwGRPeWsWeRz6YkA8b8PvthzkIR1PvWKlGJNCAzlgjyj3xZnbOjBu/yeBZGNN+oICIapNOa
	OODGXSUf942n37wbFA5PyP6gcH/RTyErIJ94oWiJQpkv5aGwg+Je7s1eBAj5g==
X-Google-Smtp-Source: AGHT+IHYHfBvUu0DZFh16zcxTkFpKxetrmBGHduH1Px3jq7+qvQd558v6EZlAarkWJRanQMBCA2qaQ==
X-Received: by 2002:a05:6e02:174c:b0:3a7:e0c0:5f25 with SMTP id e9e14a558f8ab-3a7f9a2952dmr79789725ab.4.1733331418893;
        Wed, 04 Dec 2024 08:56:58 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7dcc6146fsm26878105ab.74.2024.12.04.08.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 08:56:58 -0800 (PST)
Message-ID: <8e7b4812-bb10-4f5f-92f9-86aa33203c3a@linuxfoundation.org>
Date: Wed, 4 Dec 2024 09:56:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 000/138] 4.19.325-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241203141923.524658091@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241203141923.524658091@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/24 07:30, Greg Kroah-Hartman wrote:
> ------------------
> Note, this is the LAST 4.19.y kernel to be released.  After this one, it
> is end-of-life.  It's been 6 years, everyone should have moved off of it
> by now.
> ------------------
> 
> This is the start of the stable review cycle for the 4.19.325 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 05 Dec 2024 14:18:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.325-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

