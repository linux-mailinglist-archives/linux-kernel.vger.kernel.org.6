Return-Path: <linux-kernel+bounces-445217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DEF9F12FC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FE0188DA1B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4B91EB9F7;
	Fri, 13 Dec 2024 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dDfFApdg"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF12C1EB9E8
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108669; cv=none; b=SxLMQzh6cyXluZaahV0agTED5pkEExP3ace0qO/CJYhp1WH+GjAMJgG9KPCTcTZMyIz7h+TJzcKE/xZbisGBHvL72LVm0BbTVKX76d79aNxjBwm6e7DRUjyEgRma5ibwxIbV5IE72nGFOaMcOHmRMENezRI/xZqjEebmJWDMSwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108669; c=relaxed/simple;
	bh=hRLG0gI9ivXr3ITGqvUNSsdsw1nIY6Mm8YSBj0Szrdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRwET3KgNn2qcmpb+igFyWm+S1VGY+S6cw99MoHkaH/1+XxnJeyb4aRRD7X3B1ATHu1kHaGdSINVGsnvzUjaoTmaokYyFE4Lw6qxUvpAqYTF7qrVw+tUzlBT9ZcCKjontLznzR6Gjgo8gHC5T3oIElhIffLdxg1vMkjod+7Di9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDfFApdg; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-844d67eb693so137391239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734108667; x=1734713467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/gquvUXG51k/jNV9egwVeYSE5g1NZe8U3pZAMe+4fs=;
        b=dDfFApdgNsRg+y4fjnE+KmM8Kf2Wbbz7Ei80HAD4cijLjpkgnp0AS2OUquRqcC+Of/
         Dvy6OtHMz8pgAEMMYpPVa+m3P8hA8Hz5FlpQJEs3vAjNlibMhiuyaZN7t0LwDHhGBgH6
         nb1zcZ6rVEhzhtyewgCCsbfzHKUGZGfbXGZeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734108667; x=1734713467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/gquvUXG51k/jNV9egwVeYSE5g1NZe8U3pZAMe+4fs=;
        b=C6nq70oV6kSMPo28d0eJ+xcxxnNfKv5pAhQwWIxaX/TYdr2P8fjMJ27NSupr4HKEd5
         nMQTPwXKnFAFW4q1Fw2Vqafua59W/9KKwL1o5rdryKCTl4d4JZiTv55rjKq16yZgls6r
         ea+AqxzAY4ghoe0CPQj2kVFkxTswShWHXMCCHDnYPPAmK3v0JEnJqnYi+Aq927LIf5oC
         LcD4tMmYKsircKgqsPzLofz+XWVoGgPd/GRqbRM9aqldGagtPOM2z4vRrlxom2Ik6kgf
         0KSza3zJPCpvz2On78i48VmEsyLrktbGfCpJR+azLC1BKRElTw4H5aBUmaRuHv9yGhyh
         eYvg==
X-Forwarded-Encrypted: i=1; AJvYcCUltS9QOXCkUfvVCf+WZ9wHZhG81bXyhrSYAWkAYEpPMoeMNQInNKaJzTZ+Z34v2qMLJhZ7VXScAMvR8FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynxGx5PXkbdFJ72TXBN6/tYIZgDv4RS8bkUnpAaXfaVI26bP+7
	Rl5w0kS587kSB38kCnKWMiCQ2efpb0sRI+L+xrzB2j8BAGHNZWbeBZf43Z6VOu4=
X-Gm-Gg: ASbGncurmTDZTJqyhna4D0rMKViBiHGZfXU4gHSZOY+MkE3yhLO+kCnFHkWfOlx/pKo
	bf18z+7GlFQDt18H2LcrlfkGrrwfdEjPe9tV8h/PUJuBsuFWHzLqA0erS+1ALIrx+FOOmNpUvJT
	nbP4E79G8OJo+mEsPBeuBB8rjMb3k8cQe5tzQ/m4s3kv7YFoENQm2dEpemizKVWjM3+fHJ1esCl
	77FE8y4zjsa8/uF7+UUeJgnABx31Gtt53euZUi9bNp6X6nTrAFn7bfLhh6+HuBdHiFb
X-Google-Smtp-Source: AGHT+IG/k5V0zKRAZttbV2EkDVjn7pZoWJlVYqbCK3kD7y+Vax1tiYeztlcHHj03iaiKaDYPjNOHtQ==
X-Received: by 2002:a05:6602:27c6:b0:841:984b:47d2 with SMTP id ca18e2360f4ac-844e88eb5b8mr418899839f.14.1734108666844;
        Fri, 13 Dec 2024 08:51:06 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844738d4e38sm485853439f.18.2024.12.13.08.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 08:51:06 -0800 (PST)
Message-ID: <2a1860e2-8715-4052-9743-63fa8b766f55@linuxfoundation.org>
Date: Fri, 13 Dec 2024 09:51:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/356] 6.6.66-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 07:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.66 release.
> There are 356 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.66-rc1.gz
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

