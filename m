Return-Path: <linux-kernel+bounces-268336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A6E94234E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B347E1C22FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F1018E024;
	Tue, 30 Jul 2024 23:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YNUdOHb/"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B642518CC01
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722381162; cv=none; b=Bip11fjIvwHKzLLLLV7DS/gTgvIA6IXePO1TcRO/SGCbZ/2R0dK9D2ELVxIHCK5L4zd9AG2fK8RbQwCJfsD4H4wpoPifgttzZ4OZ1T3Ndps1+XdIwLZl01p0ANCTirNtQQcjJemo50JtTc6C6ML29Vq0UHez/s9ZgQt+IHE7bnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722381162; c=relaxed/simple;
	bh=6nOVtisGZrnzIG1KbHoEr3XdAicZOw547gyR8vU/FIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blCEBQMQ4pS+9Q9PoCdrLmjBIxprLR4xBHkhq0UBmV7Q9YO88/gIKLuNFVYEYUoIxHG7HkVNJtJY5abOQbugrg20q9/74tB/ZNsvsjC7aJldk42F4EAq+dJsimHxCsrAt37i0JZaEdJGI6WTSX49SxiBjh06tr0/5OKCfCq3R/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YNUdOHb/; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39a22cfda10so1464705ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722381160; x=1722985960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2P1E71IYkzOdBwnRc4tNA6uPm3qXbUhT69oX7YYVj8=;
        b=YNUdOHb/7aBIAKo3ndYVct/U4NQ67q14IONXc5Pnd+Z+yCzeedkeBFMDbwPTy1O8hg
         fvynmUyQArrbhRRFr2v7iMs4avIhLtsP7hm69qLMG+ykdz+EPU7cF8X+Zq0eNpdCGia/
         8vf2jH83cH9HzyC1vfpu5njHjjV0RixP8g/6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722381160; x=1722985960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2P1E71IYkzOdBwnRc4tNA6uPm3qXbUhT69oX7YYVj8=;
        b=BdLLEs5W4ZWYlhvLR0Ru6VxoHogSUqMsX6oeCGJl3Vgsoi3qPawzp1PlwXTYXQXcgX
         Y3uER8GMmEgB3NRuQtprY7tkMKI4LvvQNiBRpq6d59KxckzjHBh5oKo4Y3wvx7n5ZcYB
         xwt1HwqtwOEx1psNYnC+PSqyFt9sdzHX0x4WqAHz+eP4ih5iQ1CrHHE0n1pHJcoxavZE
         IKy9DIYQDYDGqA/smhiAKtjZkR4YV4WOGKkZM+yYc2+6n7V23U199CVirksTDlsqmj2G
         9/DJxA6XSzBqGiSbOly0/3lMgUC2TK1300lZrSTEGfrBQ7z8RK8exZnTC3hYgFwdtlbL
         dssg==
X-Forwarded-Encrypted: i=1; AJvYcCXonc2yXB7GtocVHHL0rGliKJvOFhvyKSaVLJ7txZlHgqRze9ccOGkjDLHT/ID0jRaSjv2f6hXuoae8sfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/MXhrgFolDNfVAJQlbHx1T/FjQDM4oE3Hvo8OKmVNgnQ/Avu
	vpBb1tBtv1pF7IhwTvEFd7GtCuIo5Y+s6zYjpVEg++2gWXJE+RDCAScOvSAstCg=
X-Google-Smtp-Source: AGHT+IE6YiE9ln1YhYBVo9IaBRhL2NnvcTn0NQcPP1byApuoCU9ZdscozIUjeO+SX5ffsWwUjlgBFA==
X-Received: by 2002:a05:6602:6504:b0:7f9:3fd9:cbb with SMTP id ca18e2360f4ac-81f7cfa447amr1128113339f.1.1722381159820;
        Tue, 30 Jul 2024 16:12:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fafb9c7sm2966159173.82.2024.07.30.16.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 16:12:39 -0700 (PDT)
Message-ID: <9f5f6c00-0134-46e4-8170-757baae16193@linuxfoundation.org>
Date: Tue, 30 Jul 2024 17:12:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/568] 6.6.44-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 09:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.44 release.
> There are 568 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 Aug 2024 15:14:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.44-rc1.gz
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

