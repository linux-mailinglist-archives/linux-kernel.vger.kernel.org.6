Return-Path: <linux-kernel+bounces-416416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7E69D446E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE594282E92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A5E1C304F;
	Wed, 20 Nov 2024 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VwKPqsNw"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CFA1BBBF8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144933; cv=none; b=ZiAsy3kYSnIDdQJ351yaHWx327btKFECklXMzQFweqFyhBAmWui1KY3CwE+L4JAKl2QJMG+qI3fnuD7KbSTyQU3D3yatUSRLd0ijQ7X1RpRrf4QLv3lf4VqIi3K9LlU13qMajAmL5zqvuhW3ev2quLLAnm25NPpbCQaNEKx4oHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144933; c=relaxed/simple;
	bh=jgDIqGZI7Qz9TWm+MGExUPJL+GPCEewDXf9PNDtwKvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbDjiLG/tNBMQQRVOXgaH+rbzQ+5nCZ3EVGPI6+F3+kvpwEucHbDUsWqfUzOFr1Kwz/lvAnNy/V9XuLlsn0Si+UVqgu2imEIQ7WdVEM69I4nGhXbA3gaQOc87ddGs6Uw737/WlZXMOR511sK3LDZaFJ05rKBecRXKrglb5DBQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VwKPqsNw; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a75cad5eddso967445ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732144931; x=1732749731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNrmDAVT/R4KOHT7JjL9sZNJ7b8BJs3agtROKa254/I=;
        b=VwKPqsNwgkxQWm4q+dIbdoGb9LdNE1Q23U5qq7BNvdutXXx74gU9Tfx9Mv8ZNw3axg
         U0W2j6Kj53MgsIA9JKRxNKfjj3EovPgrdJcKRqz/TguQUULVfZSoSki0r81giAplW/Da
         8XZeJoba9vAh1LFSU+NQDOEddcwGZVEIoZLDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732144931; x=1732749731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNrmDAVT/R4KOHT7JjL9sZNJ7b8BJs3agtROKa254/I=;
        b=bG0WoBYnngXthrI9bEiblmGoghnGZN04LA3o+KY5UfNDTh7TN8Ea2pNUSwvMfvaT6j
         3G9kkZdkTVQV0oF0d3fk2lbQd6nYcIwCrseOvx9Grl9aej6UQ+mvJPycqW42n2EnmtTL
         jABmALsvAN3G0Y961U2FYDio/m1WJiE2XI9Sl9mIc/HRXgNupYK/YXubGgtukuZhJOni
         PSQuojhTWXzFXhwXv5SdgLV8w/5DTGxnBzcQtVRMmVvtcI2hF3Dv63nZf4Yd7uxOZ9c5
         eFOClBHDrqPil0wYNyghmExk7mOCS3cOqwYee0A3UQn4KdKh2VORkfP7vyu1jaAwA2iK
         xtCg==
X-Forwarded-Encrypted: i=1; AJvYcCVz7Cj0Ll1RwRH9J1a0P1qVvRmR71KsN/wv0jMhj/K/HHZk47a2TpYJQXbkEebnKVFQko9TlCP/JihlXR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo4iUuk9bW8Gg/q8Q0K4zfa7CPOHGE6fyaKrVi2XRZyUFAzLbl
	RZagw6T+OmM//WIMIimErD3qElINEBlK8qvTu4SNyquzr6CMY8ScMutTrH836lQ=
X-Gm-Gg: ASbGncttTnxExQelYviu7vyaS0zJLpR3pRaUOpDV2+s0zpA3ZQzGX5EYHBDvqEMnxP+
	5CUPqH7daaAKPzFD/vNtpCA2biUJXRh5m2PbwOkq1zau2TW5kzP8Yzm9HcfGDriQigksAeRX0vm
	kTbCX6jycoRcMDJOu+zUrcYDLjEyLBtVx2S0z9rR7L9ls+n5B3pqUUzwB34YvIfnu2mvW6ns3Dt
	J6eSKchmkGBXbVD5mIPag1MSQon2xzJlowWsSKy9zAL+Jcuji4eKxIjKPqN7A==
X-Google-Smtp-Source: AGHT+IFQ6ZOS1DQSEJHQLfTo8fAp/CwP9Ri+uhc9AlpvsuSdF0Ze58MSF5XAOkYeTL8fNjZ5harxJg==
X-Received: by 2002:a05:6e02:1d89:b0:3a0:9c99:32d6 with SMTP id e9e14a558f8ab-3a78659d25cmr50689465ab.24.1732144929929;
        Wed, 20 Nov 2024 15:22:09 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d6eb77asm3347026173.5.2024.11.20.15.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 15:22:09 -0800 (PST)
Message-ID: <6179b0fd-0427-4179-b8c1-7f488fe6b7b5@linuxfoundation.org>
Date: Wed, 20 Nov 2024 16:22:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/73] 6.1.119-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241120125809.623237564@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241120125809.623237564@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 05:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.119 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Nov 2024 12:57:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.119-rc1.gz
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


