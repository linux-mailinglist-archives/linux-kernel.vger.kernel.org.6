Return-Path: <linux-kernel+bounces-530232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D17A9A430E0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F63D1899559
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC3320CCCD;
	Mon, 24 Feb 2025 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KgOHKKGt"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2A320969D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439799; cv=none; b=DHyxAjDBJaMghGY/2nWO6bxWQ9hqmNElKh0BkrIXHbK/xnsvkIZ1ALJiqZF5z/HF0mOVqEFwUJlsxYoOuU8RkwNtW5iAMNQJ2ajSiiWG2lo0ggMWbn79neBF2sJafMBLhFC5/DyB/6wCSVS+Q8xtxt0HMR9VDG/YIEZtLObMVP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439799; c=relaxed/simple;
	bh=IXdCBDzCBUbkFfthm9/aQaa+v1dqrKyH+wUiO54d3RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nf52TqyrNjTdjatJIibREq4w8AuzkNbhVecnGSmTzDarPfzANn9uFToYfLgUcmBZezdWe/Sg+Y9oADUgodARf8ZZWVlGQWS9eJmzHONUIWBllzbXmylfgP3xQ4cRVjw5zzaeUuA4103PohT7fi1G7ZcA27xmHGKXDjOqac8i14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KgOHKKGt; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d28792a49dso34149375ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740439795; x=1741044595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIkbRf4FMel4QDOvKceYfh/yaQ7I5vhGFgantHaE9ig=;
        b=KgOHKKGt3A2yiRJan9ep8yumcQzUygd3IbSBerqaIVNwrRSSlFSjQf0YZ4mEDSM7Ha
         veF+voiy5pSLejrpqP83yqoA19iQaEDTQMo6eulWQIHBlKDF1tivSiwQcze2xtXc57uv
         GzFqiA8HS2hetCUnK6OaljpGGid/M2ps2DSL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740439795; x=1741044595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIkbRf4FMel4QDOvKceYfh/yaQ7I5vhGFgantHaE9ig=;
        b=E7AhDwj0lW5V9nPeDBmLZU/5exdKvIZGFUDfZTfJ2o7CthCLHdJzjycRcKz61wHtNG
         wMckenJu9jhI0Xv7QZEP7yz73h+lpjBCT9sHZecpCgP86qDwi6rocCmo7LWMT/Tq1Er1
         q2jA23bVoOPcO1pTKVF8rjzT/mhmxnpzZWKZt3Ut+X6MJAVV6QEEOKO2wl+02JrftUPo
         uzKxhUlb27pqo9Rx0ZJtxS+JD0yRuE9u1K1578JIMmGttiETtv5mhH4MU6A/9eV2SuOH
         ZhtjAEmdeXhcA6vv9AFlzxytO3VRcv2uFXIEM8GdoiizTarxCpJwMPWnwJC4gr42zohI
         IB0A==
X-Forwarded-Encrypted: i=1; AJvYcCWd4BmbNiBhVMw4Ke9LY5f3AcJD3ES0NYlk6u1l9ZLYcDGVsCwIkMEbFopzXdstzAU2R+pPKowNfqMGFnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+ViZXAwCMMfO+xmO3rluMuNCN2n2QrxVymRLSuMS1kuAJ1Zd
	fR2hfBtmaUr9WyPJzv/sokO1QFlmyGrGI3LaeJGPextXv2S4zeFJvW8pwdaywp0=
X-Gm-Gg: ASbGncsPdhvr7te9VTtSzRqTNsWVRCNtkC6WK+GRyA/8PWUJ/BGE7GumphIFyLYMzle
	K+BcUBNK3szQshj5WoZkxIFu7wExNc09M2wuN62kN4ybf3qudypdyoVUn1A9CApAFayv32oV7Ri
	oNEHqiw5uXDeoQe5qBIRVrMbLmD6+vRQTvZrJDjzC7Lqwu9sz8OeUMl+N5O5r0XIJNbLzIZxtZ7
	hwWWGevYIeOp+jU/Pg5r0IQBxNf62EIo/cdKXEyp52OBLDXbgWho70FS0XfKnQxZGuJL6dfCkPX
	2eAQXWLj124iGsKjHBLM/3aIMxGys8PwrIo5
X-Google-Smtp-Source: AGHT+IFHeukUOsy+wlnIGOaJm7Qp4XcZ0fW2Qyx12XDKe2CQzjzBgXCGHcleQ9ZvF+aWz4koZdKKyw==
X-Received: by 2002:a05:6e02:3d83:b0:3d2:b930:ab5b with SMTP id e9e14a558f8ab-3d2cb473053mr135338755ab.10.1740439794863;
        Mon, 24 Feb 2025 15:29:54 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f047530b0fsm126453173.128.2025.02.24.15.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 15:29:54 -0800 (PST)
Message-ID: <23ee8dd6-a4c9-4369-970d-07e5f142c96a@linuxfoundation.org>
Date: Mon, 24 Feb 2025 16:29:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/138] 6.13.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250224142604.442289573@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250224142604.442289573@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/25 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.5 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Feb 2025 14:25:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.5-rc1.gz
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

