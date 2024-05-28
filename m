Return-Path: <linux-kernel+bounces-193138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F158D274A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00791B2249A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF5A4EB2E;
	Tue, 28 May 2024 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yx3NRZrn"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A970326AED
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933241; cv=none; b=j+/Cxs+4idRugcWqrQfi1lZ2i4dq4sdv6JZspa2FuMauYKJOml8XWE+RegfRoFe6Cwhi81DjWWMly48CKg7r7mSCe62m9ai6skaJIiPOg69NTovlvCwsofcnMxEs6OZ4Dl3cizeLPeROr5dqHsqZ3HFDApIoMZgQA+K4wQ8EKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933241; c=relaxed/simple;
	bh=1qdczpPOuQX42ByroNXbNe+HO1MN3jMHmqL4n2GjsDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dsmgp/GrVV/zHQCvm/4V7M+lj0SoKW7FwrXLIdp3ysF0q9Id8qB0unbq0IzLOxoeD02u30aT9cSP8KJf3qV940MhwsnB9+5+jq5M0aSMu663XcyZ9gDwZXkP4xkSEORwpflcPrNlmXX5Qoaud08pOT/JRi0RxDDORGuTmcpPeYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yx3NRZrn; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e3b1981fe5so4760639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716933239; x=1717538039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfACfrliUC8RvUZvSpo29lWjHhmcZI934D2GcMw4Ck8=;
        b=Yx3NRZrn3afLgMuuBcgk4TLZNPjCq1y9nv40s95NbtyuA4YGtk0Ee0cwtCbL+9u9H8
         ealRkosxrP7E5P+XUB7u1qRvQ5bjCkHdN8F9capjA7+tr2kbAI4Z4yPBL/1J19h5H/KK
         QBklkEcw5FfudxW18uGiPZ3fS1cjvLxfuqzRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716933239; x=1717538039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfACfrliUC8RvUZvSpo29lWjHhmcZI934D2GcMw4Ck8=;
        b=H1iIJoL28aaxSAMFN5OUZ25NR057ACKZISqk+0QpN/AWSXsDRuA4qcDT1aBhAZuzLK
         o5L9N1qvtAJnbnKBueMSaEv11wU2/M5mrUU+s6oLFJt7f5IVquiTc03nHv1qEd3GKOE2
         clXORUn6nVzHVyCJD/jVriqH6ey/5Uvu0F0BsdOey739u5wrnbOeBlIQ6l0d9PUxxKdL
         ekAboTfczDn09H7UEKucfyojqqF6IG7cQUjSWqs/vc2D+eldCwAqOOf/WMRCJQy40Y/B
         j+aUltJOhCHLCSAV3aHcCuu9gfZi5IljYD8rdezD6poIJhGFeBSY4l9cv7kxhcTobxLV
         L8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/jYgR4a9C0CZtZ3BvJYB9DzFiayxg7sj6K6aJHigwHvvdCcQJFZ2bMs44E/B1j/DHfXriPm44FI65/FO5eR1JZwSq6pVzJLveidl8
X-Gm-Message-State: AOJu0YwCSOt9A79Dh40aKye6UvEalTxD8BBJOCJYnLck/8Ej58l/qo+Q
	XwhZMb82fKJhwj6AvM3pXWWu+9t9bpRGh2tpb/yc7oyvu/5QoRyUxzNdzjaM+jI=
X-Google-Smtp-Source: AGHT+IGlp+f9XTmGdfRN8ZCb2asH0wxF0ge73+1BXthKHmMYyHK/ofz+zklI+icES/RDoyHkhVbhgA==
X-Received: by 2002:a6b:ee11:0:b0:7e1:7e15:6471 with SMTP id ca18e2360f4ac-7e8c5f86536mr1456721639f.1.1716933238758;
        Tue, 28 May 2024 14:53:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b0f70c8acesm611762173.84.2024.05.28.14.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 14:53:58 -0700 (PDT)
Message-ID: <073f7048-5c3c-4581-a6ef-2e46f7d35ade@linuxfoundation.org>
Date: Tue, 28 May 2024 15:53:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/493] 6.8.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/24 12:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.12 release.
> There are 493 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 May 2024 18:53:22 +0000.
> Anything received after that time might be too late.
> 

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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

