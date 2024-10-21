Return-Path: <linux-kernel+bounces-375233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B00569A9378
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF941C22AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B21FEFB3;
	Mon, 21 Oct 2024 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GakT1KdU"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A602CA9
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729550490; cv=none; b=fUqsOWDlX7ABkwm5ytgnJxxwgXKt4p4bsKU0AcMJ5UTDNUwv5ET+hWvQdubYskzn5zmkBF0s7MTUYWe+SdM+TdPii55lk9prtylNxAa2cUgmKAng9KJWE1daV7SzDPMCtAePQYDLvBkkgTEHQDFZf+xCK3Yy1V0Q5PTPnDyq+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729550490; c=relaxed/simple;
	bh=PsPPiiDCrhoSB3wsRMZs3K+SlDE82UI3Dva8qJIqSHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTAV5BKtJFA0DwPOnrhq417p3MdFdnTt4LoO0fcEmi4p8qOSrMRZOla9t5aEqRVLvHth3m72x+eLryf+wJEIR+13tUuJ3QJKeTU6qmMhJOxQ2fgdbnXnoC0ZpqM8o1U6MbtOJwoSPXPVCyEbExpzqzVcxWx6i1wxNuu9g90i7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GakT1KdU; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3b1aa0e80so21091985ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729550488; x=1730155288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8AuINN/VlI7pACZM3YzjmWIoSWBhMxFLVtFg1hkHIQ=;
        b=GakT1KdUnpNvVBsVFJkN7Ub9tCI3NTmXzju3SRh4PWjFU2kE2INyJ87uyKpW1Qnojy
         h/dHdPsj+JBm/wbivW+zICQoXaVljoINCp6uFAlrD7L2Pse+aY27ezZ7DA812szeK9Ts
         uN8lvw7NyvSwcJF82hOw5TbdGny3f0ItSaqVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729550488; x=1730155288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8AuINN/VlI7pACZM3YzjmWIoSWBhMxFLVtFg1hkHIQ=;
        b=eQ4j/wowcxUhpYhsYbd29XIx+sNS4cUJrx06NZiPAB9Lf3LF0YXK3xnOet/RyBpLwq
         l1q5dgNWSG9JBmdKNAVY/oNeRs4PBUhN2igGEPf0BOX123Xf5CBU+IzZI6z+zFewHgkd
         msA0A6TiVhgilNMVbPAjeq1m+Y0xAaGaSCijK1dKUHlqg9o4FFhiFgL9yL4cPJkH/cQ2
         SAXL5qgdubKSRa1RCWmBsIc9gRr/P298W4JKjuSP76gQYaML94pYht4y9BKAceXvfnyL
         RLFbvZkPBwqaQOukYK/5qxIrGtGXInGTJ8FXgZd++4aliBW227CpgKdiwT+kwplm10aA
         GsvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnU/geJcffe/304/TV3a4cKBXmKoUW89wTvCXJ/MHkqxGA95Bjc6xFULN+Ds7fsYjPdwvIgmogkwigPKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXglOkl6tmNG+NfUMz+DpCV9lJ/WiA8fu3Srfnry8PwZcLRuBU
	LZ6hYL2e0c6kw4a198tSdm7zt1AefWEEbK++c33TvBYEnhF9LNUGvcvfCC55e8Q=
X-Google-Smtp-Source: AGHT+IEaAuGxE8Q/sUhf8BHr/cqOHvML05PH0iljxkC4PH34quq5p+P+YnDVd+6lHd10q3fIaxMq+Q==
X-Received: by 2002:a05:6e02:1a81:b0:3a0:abec:da95 with SMTP id e9e14a558f8ab-3a3f40ad623mr111865565ab.22.1729550488238;
        Mon, 21 Oct 2024 15:41:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a6090b5sm1260296173.89.2024.10.21.15.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 15:41:27 -0700 (PDT)
Message-ID: <f1218a73-76db-4f8a-b3c9-19bdd3c026fc@linuxfoundation.org>
Date: Mon, 21 Oct 2024 16:41:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/82] 5.15.169-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241021102247.209765070@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241021102247.209765070@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/24 04:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.169 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.169-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

