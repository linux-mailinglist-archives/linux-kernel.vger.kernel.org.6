Return-Path: <linux-kernel+bounces-411899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8705B9D00E2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 22:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346FE1F220C3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 21:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E9D199951;
	Sat, 16 Nov 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JUduwfrx"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3784F9D6
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731791429; cv=none; b=VrkLZ3QqIyx+tgve+VhOSWP+1Nyn4cyZmaxK93mkMiAofIzJmKT5S5hc3hfqYYbBrkVd3eYEwdXLZK9+h+eX5975M/sHsy3X+OHtJz0lLSnR66ahuGOS/Gssa0PKd7XMYv+MANgPHqWg9ddMZKwvj1rBIKZk0P8ioSBa+DCoCmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731791429; c=relaxed/simple;
	bh=eJb1HN3fwnkvx2NdbSKfI8Ywjm148cLmw4I9CYv54FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyvZVM2IA66OF7Aral3o4GRtC7eULhGwLSSwkeOfzciPxQaXMdHK4vbWsbLWDxk/RSMop01Lk/e0BMlAgRf9qft9Uo+rAV1zKKj+DCGADZnV1+r29ZTbZsSKF519mAeU3GcFvNWHauPYRQBYHpJ1CeW02b3C0HCIGCvsPZlmBD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JUduwfrx; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a75cad5eddso1369295ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 13:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731791427; x=1732396227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbBud2naf4JubCnVmY9ZpR/bTsHDUJktK177sfeaBcM=;
        b=JUduwfrxiOv+altWz42usoXUhNaK4i+lwCikqQSvnxTBvCxWz7R8Mu/bqK7MM76bg9
         26hTL8N/bb9PqkCJlZC0MkqZsYzc8A0czHa/dUS7KRYmHlZiGErKTZMjACoNw/Ml6vK8
         sf9oQCPBf+oYE6uXkSxj2MY6yJ9xeYywikYIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731791427; x=1732396227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbBud2naf4JubCnVmY9ZpR/bTsHDUJktK177sfeaBcM=;
        b=RfMHVsQ9WeP0iU/natidbWyC2qcnAcc85sG+kA+3D6v9d9LJQcgv3qKT8aiKoReMEx
         4mEHMAMgudkEV8HWldAdIEW5+UguVz+zxxoaF8Z4V5DXTaYx8Vtl1tixroQr2rTpDd9D
         TP4zhLrk94FqxY9iugIVkLP8Mr/m84a/6rN6Qm4dItqgEYMdnRHpIIfRlnUbYbMZWao+
         9C5ctjrr6uRMunDd4BX9xDTg5tnst1ZmmAr3l9LUgeVW1qrlpkkOwMkHiqdE7t5WuI5x
         QZL2o3TwhvTSU1CWOVXSMG4e+JZozrA2W+UlpkZ5WV7kUSrwa5Tpx61NfYOn8+h67xDW
         8zPA==
X-Forwarded-Encrypted: i=1; AJvYcCVEpchxzSiyB8b0T/YwHOOMi2C4PmOyWQhbfXvcRDCvklSPPSRSS/eNaMOor/zjWha9wfdG+atDDohh9eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPENhm084lxe02R9UQlbTsse4qKi2l3rrvxL/P4APElkv/8nj/
	FVwBj+B9jlQiVpY9O5hps7YW3Z9oxjpkXZFjGU6BYIrQm1zA+KQjVBzJKWeLz2QalHIdRLoD978
	R
X-Google-Smtp-Source: AGHT+IGv8usQ9MgOT1JphpO19XQbtTjj7RUcbeRCZ2oDOI6yUyOM7ELGdnc3WoLZny6B6hwElr5thA==
X-Received: by 2002:a05:6e02:b21:b0:3a5:e1f5:1572 with SMTP id e9e14a558f8ab-3a7480d4ademr52241665ab.22.1731791426914;
        Sat, 16 Nov 2024 13:10:26 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7481159desm11603515ab.49.2024.11.16.13.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 13:10:26 -0800 (PST)
Message-ID: <87ec0578-5355-4a1b-8271-8e5734aae626@linuxfoundation.org>
Date: Sat, 16 Nov 2024 14:10:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/39] 6.1.118-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241115063722.599985562@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241115063722.599985562@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 23:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.118 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.118-rc1.gz
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

