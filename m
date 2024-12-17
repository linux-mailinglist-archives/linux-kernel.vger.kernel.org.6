Return-Path: <linux-kernel+bounces-450042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BB69F5A06
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2024 00:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9D1165B56
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A81F8F04;
	Tue, 17 Dec 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="at7AzM/A"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7991F76DA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476432; cv=none; b=oThK0fR+iFqe42+hqJ1Zqbj7qsgfVB5+7Ih5IbtOWEIgyLdm1++A8zLrDffd0zia9iz3W1+WbL0eNPZo93VNdVRVFw5fadZu7QVVaGkFNsGxDMDw2YUiENvadcA6sXJL9ZpEBjuLkK7kQQ+VOFtrgPQ/tqoCBYpur2SmY3th5rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476432; c=relaxed/simple;
	bh=heZCgR36okwrEPenz1vox0Ph/7lggzAvy9tEGMZmPdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivUyl3kA59IGKdX5wpU4P4qqLI7QeUYj/P6Z8+N4USwVKTgm3YYJAJjfchRtC2FKZVIrtpRwJRNt8VpGEGO2GwehOGFsxsITC0cKPDJXmlIwycmOns1ffopbbfq/aQEFtYKA4jLxxC66ZBUpX48Q3uHoZIvM68VcUX1malw0+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=at7AzM/A; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a9d9c86920so19491935ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734476430; x=1735081230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytheTzvx0tqGH28SZa+nd7zFHHJvqM/FuQZdlG8skUY=;
        b=at7AzM/AwxUG5bwkRCuj2WQ+UoPjrHYz3vNjCGKKI7VwZLabi/0swF1bOVYkkes+m+
         CaGYdxw/Hr8YeiLRdHyWbpPPo246CUJpvnNhfGsd5jAfLMDVz61ktqWYvfnzO0EOEFbU
         BU+580/jrAu8+No+lZsleuGSMtODczW3ROE0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734476430; x=1735081230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytheTzvx0tqGH28SZa+nd7zFHHJvqM/FuQZdlG8skUY=;
        b=WLbTKddjQGEY0UBjg2JeZKCqw5ABOJRAWW5N/f5RrScsADtTw2pW5JmEwFK8zr9Snq
         wSM7ast9J56xhYblVThX5/JgL+t0YA7KRDNqnIxvQxutTFboTBHE76zVSploo+VbwYVi
         c72Jvv5uJ0dXHtMNPIleAeiQFSXzseYoAAgUe9oHFyAFCiugSgKxQcymsS9Y/LvOGl2q
         4+eR4PObJxZGvqjxKn33Bq8PDhit1EEKCDxMP+y4iNceLSffFTulFGUVeplXlUPJ9ydK
         UCbN7V1+GB+LBzmjqNmqmDQXS41BKttLP6k6iQvQTXHOv8Be/MYmJxcefOZ+KEzdDVQ3
         1xmw==
X-Forwarded-Encrypted: i=1; AJvYcCXrMTjD9nYSLroNRfDOBegYmK/+jyESXn+8l7ZHeYNfWf+Tbun9/3wlam9QGEWe5CQVGn6Urg/7vej/WBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPbtLMVrO9SZWXJUXzxkNaNF2ZXZLUiuv24seP0BA9ODqIquGf
	qJFBa80D1401YJywCEQzqH0yJesmRp7kPc2x1tNuPntqdz6SVfAtVr7CpiKI6iU=
X-Gm-Gg: ASbGnctG6xz0y7qsut8sWVhZaHkca7CPpxmc6hJGs7I/EOMn8GRS6ygnUAXYR4BF6VM
	uxMGdDsa9d6G1t1Xz7NeTtioGBcswpMF5LYd8e6/+vhIw+FUOEUQFjLFa7CYrXfMg5XDxIGb3Dg
	MRrf9r8A8tdEBEkN0mHcepN3vphdFbsLCvH3BCkcjzXBaxT/3fmZvq0hTKpoY1d6P/8+PMkfbmG
	Hoc42w1Vjigxd07vVV8EJr8+NW6yQmvveh0sb96VCYWIPwl82R0j+pr52KeY7t13tu6
X-Google-Smtp-Source: AGHT+IHj1urYnLVFd1H9Pq3MAXhO6pXENBDFiKLXPXYYGMdBg7DO4d/bKBJ0mtkdDouBQ9AMPQaYbw==
X-Received: by 2002:a05:6e02:148f:b0:3a0:9c99:32d6 with SMTP id e9e14a558f8ab-3bdc4f18812mr5930715ab.24.1734476429636;
        Tue, 17 Dec 2024 15:00:29 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5dd620e20sm1862035173.0.2024.12.17.15.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 15:00:29 -0800 (PST)
Message-ID: <842c3d3d-fa2b-4e30-a042-0cbc45562da2@linuxfoundation.org>
Date: Tue, 17 Dec 2024 16:00:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/109] 6.6.67-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241217170533.329523616@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241217170533.329523616@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 10:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.67 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.67-rc1.gz
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

