Return-Path: <linux-kernel+bounces-375231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E039A9373
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9057C1C22DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D357F1FEFC6;
	Mon, 21 Oct 2024 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HL0JHm/H"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976801FEFAC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729550170; cv=none; b=qCNlfxzbSmF2t9+GdyzQ90gxKxLuSnewgQumIUb0VyT4fNOiTUneDUL4i19K0y6qCFJWblQO//yfP9sSIw9pEHJ01M1XsgJbNmbnFEbapTeIdDxMBvDZyaqpafnagm53Wl3a7RRvrkxwMrgiLhpfx7qI53GSYmeJvoGe2CveoyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729550170; c=relaxed/simple;
	bh=7ridXmxOHKWZoFTcCWYzOqNgAI+K4jvfNxUVNRtv7CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WO3i3QBxNsL8KcNgRag+p8nKwmIpC3rsUWgTd8TRfl9gXiuSjgPerDvmLFeIuAme8vC1nEHj6AsEW3cWmOKlJF1IllpP6rtKtGm0HEtgSe04/R54J38liWNr8mToScaAA4E8igIFz6FCZx/OPycmXaTxquJG56aY1tQ/sz2Lbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HL0JHm/H; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3bd422b52so17459595ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729550168; x=1730154968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q1oI+BubvD3PxPJMfqOmKVBP9PushioezVB2K9owCDI=;
        b=HL0JHm/HtdsFs1dUe8r6aDCbz8NM1mYKzBLk++cX9nxVvNdOQ2owAsblhAMVSNzR7X
         X8RtrwZgRMQ6cLUV6DfOZSQmJzIuV6FzM8sdefjLrDwnCAyMgKvnKvtz2Jme+pJkv4SR
         PNRp4e38vxwONqtTlSsRFu/1lI7+X9KXMZUkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729550168; x=1730154968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1oI+BubvD3PxPJMfqOmKVBP9PushioezVB2K9owCDI=;
        b=JH6y09RACyBuAKPYz2jzdomIX5NQPPZye0oZ6LJYUGlGAv4LMJ/7W2T3LnXMT1AMgV
         m/+LEc2qsoB7QFJ8lGXVGlLaS1q3vUcY8GInHH1u5Ily5S3koQgdqVz25vXiFLNn7rgg
         QIzZNPMfRRuc2VZSQMLdIzP/347cW566Mboq5c8SQEhynZD9UJQQiYLHDNDnpihCHB4F
         +Slg6ijsKqNukekneLtb1lBYzhyf/DkhobykRH6jI7GNepwg2hyHBS/AN8awgHoqM7NM
         Ker0uIG9L0mpe3IWOOZDen4hR5RjELWVwExu54Ys2UoEX+xoIYD17ngKm1gQ0kzOHX3z
         +Q/g==
X-Forwarded-Encrypted: i=1; AJvYcCWwVOCgcx7VMECthTNkHu3co8OXEoXrvS8H7E8SfkRqMeAijM8AU9Vt1GH/jwcwtPVfRoJivtlnT0PB34Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXhC6PwoYipZrfn8tZS8m0Mcn5cJGo/2SA8Hk3rRiEouVRLbAN
	8rUFjTraI0QFKygW+QYO57UyDXV5vjcmfblZ5pGhoYAsUcZ9wjDpqJlJrWXGDpagUAdMhpdziY6
	x
X-Google-Smtp-Source: AGHT+IHQbwFRjNv3mvRv4eYW87D6KlEthx3nm80SwdMIqSHvZkHg4K6C8J+Gc1bJjQZixmB4IFeUFg==
X-Received: by 2002:a05:6e02:1908:b0:3a0:b384:219b with SMTP id e9e14a558f8ab-3a4cd81a173mr4512455ab.26.1729550167696;
        Mon, 21 Oct 2024 15:36:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a63020asm1268461173.149.2024.10.21.15.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 15:36:07 -0700 (PDT)
Message-ID: <59996bfa-013d-4ade-954b-33974d86cbb9@linuxfoundation.org>
Date: Mon, 21 Oct 2024 16:36:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/91] 6.1.114-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241021102249.791942892@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241021102249.791942892@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/24 04:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.114 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.114-rc1.gz
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

