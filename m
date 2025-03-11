Return-Path: <linux-kernel+bounces-556861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F7DA5CF99
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76DA189D598
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D72126460A;
	Tue, 11 Mar 2025 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UdLwz+qC"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A396B263881
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722087; cv=none; b=AB9aHQHsZDNFmaYNCjxiA95I5LZUAxIOgHjDmQkXVg4Q4cvz4s1QFtufPoOjKWph9HBOuqe4CHVsBlpeTIEnq0ZrkMw2D8iBWYY2WIIHyBfN81XDvyWWdlIf9JA0Eoug20QsAbkdfO+tAJmfMcQbW9okyXafmGFRETr+JDtkcyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722087; c=relaxed/simple;
	bh=er+9jjdFTitNlebJQVzJd8lxcEmN5HEy0TqS1l7wvJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJScIzY7DAsS1GccgF7mZjOX6fy3RIz+BFZ8+YkxMObCB4GqlwBpIH6KyLpJ44xsDusSPKXqmEYM/i9vQB0tP3TqhZKswz87C2BlbLZTv73c+5bRkCgZX6lI1KeIazKBghWCCwYNK0X0iaR1XKdFy7Zcj+tJ03sO6PAkDuGuqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UdLwz+qC; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d3db3b68a7so48439445ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741722085; x=1742326885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ry9akgKcOnrDWDxgZkeI6/C0nkDIdOIWsdgWlSMcY+I=;
        b=UdLwz+qCr3qaR0TXiZl8DuKxkS0+h3OgIBL4r9OVVTqONvYpb6s9YrTGzMWz53sF0Y
         YPccOLKxMYheOd+9Nvux2zEvfK5ndkjUpKYPlVITnjhsQ/Osc4at8Vzoi9+XDRITYbNk
         1arL7k1U6oZIl+RlZkz5szB2m2Kg7OgGqpItg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741722085; x=1742326885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ry9akgKcOnrDWDxgZkeI6/C0nkDIdOIWsdgWlSMcY+I=;
        b=IJfp3Rz65k93bKH4pgd2dQr2MzcFfULmAgX80cvmPy9Q8ZGkRBWG+p/mUVlXgpL0W2
         1yTTXemduGN95id+xRGRozGvBndDydJXIW254pL/6uxKM6iWcMd7Ycwmhkr2nMsbMYVx
         GeY8etlwjYyINBjJzeZWdFMeOBB0P/BuI9Yc9ie+TEgiweytKDGQ8Hm9j7Ke1HNbcVLh
         PEUgeSlJU3/DgdXVsfmuyTyPCP/EEgnlAb1PEq0eb0NX30TeWN86qza9KvfbCRhPm67I
         4q3fQkYbs8ofn4PoN8W1mlsG+UYJ0ZvvhjZo/FCbUsucSUr/H5Ldt0T3LIqEO75mFBJT
         x17Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsd4QNMiWyYdQBng846NR6EVBlFkVCpUQoG3lYk2KODF/a8ciw8pwIvlKOokcZ6fBUA+MOgSMbT9+7MoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3ctXMGRLFSDCP4Jsz0CSwXnOJ1s1I3T09S4ejwBHKEeq+4oF
	vmxIq6J84330RBNI1VaKD6lW3Lh0wls9pvsOJ+F/vDPl+bBokLXtzELJS5TY4zU=
X-Gm-Gg: ASbGncuIQMh4AmcJ2JNKVUKmWIBhB/vZUl5vYgofp0i5LO5MFYq7Y5LiIEJso1k0qnt
	nzg3Ro1X29tLhwFio+KvN1YN9GK4XyYN/NhSFYzG1nxtXXOWaptDsif2Po6uT1hxQGrTMy5Y++4
	sKNxtSMNu9dT5G44QehdHAQ1XAyxlV6SrIWBK18+aHCPdEpnBf4VAg7AJn4bD+TGJGuhQh6GiUM
	+dPFWc/A0Pa76ImhRmxJPLdXZW8RrKGrGE74r8cepZQbOeA4MmPPalracikpa/gmhMt4tag4ku+
	Ro/q/hoOaE5j8jBVaRD25ZVwa3wJahbcPwbCkhNAjKJMaMMDQLt+35s=
X-Google-Smtp-Source: AGHT+IE0dvgigbncy4JGuinRK+9BYgcnzpI1ilanDSCUJgDoIPF/Qbfo09x1YmeA3PCfK6PhoMafpA==
X-Received: by 2002:a05:6e02:1706:b0:3d3:fdcc:8fb0 with SMTP id e9e14a558f8ab-3d44196231bmr217352935ab.20.1741722084502;
        Tue, 11 Mar 2025 12:41:24 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d45dc58885sm10179065ab.46.2025.03.11.12.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 12:41:23 -0700 (PDT)
Message-ID: <3d2699c0-895b-4c78-8ee8-ed062c2eb9d1@linuxfoundation.org>
Date: Tue, 11 Mar 2025 13:41:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/109] 6.1.131-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250310170427.529761261@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250310170427.529761261@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 11:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.131 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.131-rc1.gz
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

