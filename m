Return-Path: <linux-kernel+bounces-188925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC9D8CE89F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603161C20AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F0D12EBD5;
	Fri, 24 May 2024 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b2MoG3DA"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2B12E1F9
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568002; cv=none; b=RBsgodCGHjFt+pS38eneRuCp9fbabI6FDa02IinMFTH7Wefo9ZeV3RIotJmfQxIAnsuRapuPR34EsevTXB/l8/x57VGfPJyalUqO+oK/KZMVI5N5ois9uAkLfDL20tZEf1Pc2VtqBDRR8wtvRn1p6K9Mj2LXHsu2bPue/uJmpCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568002; c=relaxed/simple;
	bh=uy3Bu+RWC2BwlJbf2rF1oLCzsBktn97cLQW+3/UQOvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQJMDoEnDqPy+h8TA2u5Xs1QWg+Hy74OT8Jl/ivc2+61ny8OgnyhfaZzASk1vTU6cQ6+p31dzWr+ru3NbkJ1rd7HJ+Gc+VAbbpiLo0ab7T2ZzlvgLXxwDqeVCMqTduhxfy7q2BHoLYGZuGsVJdsEc2/wYoaSggDfIRexSmmKJ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b2MoG3DA; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3737b3c6411so807375ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716568000; x=1717172800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsPe10u6HqBDcmGD9Z1JKcdv2q+3cFzOGeNoz7xgfPM=;
        b=b2MoG3DA0N/dGtaNaWgvKcY0kSJpFnq0ZJbLBk6TdyVA0paB8HiXM1QhNAjuVlZS0z
         X9qT/kyY7O7QnU1bxKaVoFO0s5EoQsPCMyhfBOhV3447OMk3x/7VuhASdAUm0clEqXEI
         G/6FYhYaN0ueKBidd62g5t/kbZn3QEu/gKoDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716568000; x=1717172800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsPe10u6HqBDcmGD9Z1JKcdv2q+3cFzOGeNoz7xgfPM=;
        b=A6QCnAugoukaxlOsSKgPrd2gLAEExwZaraGeuAXbfofEi+efjpFsXOCMVTaHn6Ad88
         UwOKkPzFaBhT3qMsr5bu25kuCsvZNoOlbxDEHmvvIBTbw0DJ3ZPrbBVvQ9z440ePCNxi
         tOcxvENgUNahypBZjmdmCbw+g4bgcGSJCe9KL9sUU2KR+T5zQWrh0SuMAzf8+vfjN7F7
         1RW97NsO/9NlbG40FhgseQlXy9vDp/cZZ18muzZzKOhXDcQp7CvaYf6PLCXUfwyYoWlm
         m+NFOG6yBXNTAkuseiE8lDvfA5cq7xt7/uKXgOTjtbxR3xb1/NqAEnED//iJodsonu/S
         Ql2w==
X-Forwarded-Encrypted: i=1; AJvYcCWRm3rkMuVmD7pmmfN9tuWPReaIEgKah/L0BkdeDrwvZKrV4h6aweAGzwkholJyqhZbIkh3xL0z/2AYJYAdxH95+ZgBtdyIg5HdAcA4
X-Gm-Message-State: AOJu0Yy28fzJCH7ZgEjVwkuQmgknGCEcLmkIDmpAsgIyh7fggFV+0pjo
	d2KqwfrjlRVxgTXSZl2V/5CJiB8prPTKRJlrlOv0RuXe4fDZ5ptTeAQhx0HX5gc=
X-Google-Smtp-Source: AGHT+IFZbhef8P56pBniXYHEspKkB2ti3g9EoFPYnn4FxykwHwL2OKJqu0yxdgGOlJl/tpiHmBHLdQ==
X-Received: by 2002:a5d:8783:0:b0:7e1:d865:e700 with SMTP id ca18e2360f4ac-7e8c65599d7mr325855239f.2.1716568000560;
        Fri, 24 May 2024 09:26:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b03ebbf1bfsm438640173.89.2024.05.24.09.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 09:26:40 -0700 (PDT)
Message-ID: <af4aefec-c893-4356-a50b-5f67a3913740@linuxfoundation.org>
Date: Fri, 24 May 2024 10:26:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/18] 4.19.315-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240523130325.727602650@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240523130325.727602650@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 07:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.315 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.315-rc1.gz
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

