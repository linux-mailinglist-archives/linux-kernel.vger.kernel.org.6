Return-Path: <linux-kernel+bounces-323882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F7E9744A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A8B1C24C13
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEB61AAE08;
	Tue, 10 Sep 2024 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gc6Ucx6s"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C031F951
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002741; cv=none; b=r2WpD++iMrmh9cPDdYe4Iad799z6SaG//SxqHBQIJ4r8eKw3P0eF3/xSiAlWSTKjn0ONzbrihOXSHiAKwG7C76zu5Ediy1yKwFoY3NiJkG7LSuAUmXFPUb4gfW5DmZ0vJoO6gqfGRrtpZyI33kT3nUEAKMkHu/tyfcmSTR12uXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002741; c=relaxed/simple;
	bh=ik3UKsltknlff9FD/NaLT46PtwDaXCHPQhKMj6WoIpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbMSfoL7HyBNspcmvxuzOSkMr7hsDYD9fRJ8WkDF9wNIOMNwh6pGWXG8hj6+9hMrptyRKOVYHgSyAwwBR44xHQM9xsmpAgZ3IVgJbJuL18xoPb5fo4A1MA0f0+u3KyHg6ccR7eAwvuJ1vROoM6inzBDsRSq3V3Y24y7+cyYMtUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gc6Ucx6s; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82aa7c3b3dbso206358739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726002739; x=1726607539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7rPGjGCzv+oasSI6pVCkPDSWf7w4QJh8MFoceYLzhS4=;
        b=gc6Ucx6sw+nXlHdj5XKtTZRxbWiiCgEpQJZKirbbIho8/gEDgg7K7jaVd34cJ+/NjB
         tb2Le5jJDLYbL2WegJcQwxSLEW3BotGYFVdYzrJYk34qF3lnQvE3maNAhBDmS9P89/iB
         7gasOlN/b+pic1ddr7Fy5KZ8dc0srEyXkkYsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726002739; x=1726607539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rPGjGCzv+oasSI6pVCkPDSWf7w4QJh8MFoceYLzhS4=;
        b=Z4OP2mkBK5yj1Gl1bUJsp3tYBXjZWkIytYt1ZvBYlX/37itEy4VLFuvBtSjW5bGAD4
         G+Z+R9ffkV72gsn5pnEcT6ah0xhAUoAOCI/se9i0yjAarqIcUqehuH1BD65QGhPLth8L
         qlxbJyPhG+/g2cobkiFpt6wJH2iFDUecMfYiaDyIuUX+TdOyugCWaaq/Csd8afNh6mhs
         +2ZlO0AnRFvx2PHZCFeYWchfLmhXHSyuSVbLPEVzDi7TV+BZVz0cmoSzgilkCSCgvQ6e
         b0yoBeR7yOwAlISGANPVK+p8QfNJjCa8Hjzl9ugerySRWlD9MNenkkJGmR4nF+IZuhs0
         IAbw==
X-Forwarded-Encrypted: i=1; AJvYcCWD1COuwqA3PZHCY8eUJVKxmUfbBYYUdyRbJFadqYoGss/l72dBT4czfNeoeFEKpZtlZKeG9MMXIwO+UX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz180JIFzAseXDhku14u98qlPZopOADScfCwpt6iz51ObJedHGU
	S5PYZEa8+8ZBH9prYPlhsNyPN7cj4hrpkvtdRLxDSWNOEzu0lUlreYgfMSSmeYA=
X-Google-Smtp-Source: AGHT+IEBXCGJfpx6uQrNCJWbyWaXdkVnusVExeZjTk7LweFyaAVp0ZTqw7/koXWoG3nviMKixvHXGQ==
X-Received: by 2002:a05:6602:1583:b0:82a:ab20:f4bf with SMTP id ca18e2360f4ac-82aab20f590mr1225176939f.1.1726002739074;
        Tue, 10 Sep 2024 14:12:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82aa77b5ed4sm220908339f.53.2024.09.10.14.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 14:12:18 -0700 (PDT)
Message-ID: <cb8e0e51-a934-4aaa-91dc-c4530ece99c7@linuxfoundation.org>
Date: Tue, 10 Sep 2024 15:12:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/214] 5.15.167-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910092558.714365667@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 03:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.167 release.
> There are 214 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.167-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

I am seeing a modpost error when I install the kernel. Looks
ERROR: modpost: module ad7606_par uses symbol ad7606_reset from namespace IIO_AD7606, but does not import it.
make[1]: *** [scripts/Makefile.modpost:133: modules-only.symvers] Error 1
make[1]: *** Deleting file 'modules-only.symvers'
make: *** [Makefile:1825: modules] Error 2

I am seeing a modpost error when I install the kernel. Looks
like thge following commit is the problem.

> 
> Guillaume Stols <gstols@baylibre.com>
>      iio: adc: ad7606: remove frstdata check for serial mode
> 

thanks,
-- Shuah



