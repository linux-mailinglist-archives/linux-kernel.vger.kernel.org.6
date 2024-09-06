Return-Path: <linux-kernel+bounces-317992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C4A96E6CE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37BD1C211F6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5AC15E96;
	Fri,  6 Sep 2024 00:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eMeB9p90"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1BD531
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725582353; cv=none; b=MjRqcOPz7f0Zx0cJ5CoIUBEeWC51mMStxCE6OttMGSCrpA11YB6zeZBtOG0z2h5exi+TquTT6gRXfZprdAWKDQodg/6UO4sVHYF+kU6PMZ0qpw21EhK4R3Bpd4oS7qjCSgbbzzMEkNSZqdXSr+52LGVEWMKlL9uewAaKDnCDqaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725582353; c=relaxed/simple;
	bh=TceHKBuOWdShqn26e+E2114vw+BkWXu/eFJXoMvYLXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsaKwfD/u1oj49XXiR7eyZeiliLRIxDq/Sw+yJ6npsf6KrHLLgf2zUJjJeJwL5G5LJn7jcbPBg5aj7MqaDw4+uMjrsBzTPtCIfFC1+lbFFK3iH4gTsPFomNmvqsY6QIvJnLGkwF+kVm7fcNCoOGCCmMCpHZBjg8Htnpd6S13fiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eMeB9p90; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-205659dc63aso15062585ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 17:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725582350; x=1726187150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApnYfKTQtuBNhNyBR6dUfgNS3EzyFjj/3NfY//JSza4=;
        b=eMeB9p903JKij/zrPsAXML7Sx8IA19S8P9/UiMfaQfjbDdLGnGiLSEHiTwWEsniZGx
         SJpRvIDgfl/CjVoEnbva7a23gprQ2QRDgCjS1TSt5fv6UnsGPKAjvvElm1VgzL8JIFOF
         hbe1M0Fg2T7yvPXJ6h75b8I31oQVwbo+lXy40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725582350; x=1726187150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApnYfKTQtuBNhNyBR6dUfgNS3EzyFjj/3NfY//JSza4=;
        b=F64KhgvoHjcHUk1crI3U/+r04qbhiMlP4a/SANXLMCtXiZiKyXTnZbZrawb0Itrb88
         2+V8XYIgC6SXu9dwEYSk/07UlnFv0z2uZvtqyQEc9br8lGrNW27y3yAwXyP5QqE4w1yc
         QKENc5flDyQHYXTEFch7bKL+YRorUeAMtau7X0pAPti9kWMh2+zd2qyW2JwUSUbPKWwH
         UQazUCWM9ePZsIpPZiiKUh56y23GIsfUg64ei87SGwA2UiU69MWcmfD+v5sS7+Pmid+X
         jFzmWB89Jl/3p1wNwVeRYigVHPQCBvHemZPDPKXpUDr/eqsi91ZCD5KqneOJXv3p9Wef
         veqg==
X-Forwarded-Encrypted: i=1; AJvYcCWEvKjmn/J+10hthg/quwPFwOdhQdTdnJvSNY7Yvul5QbWj98NUPiApIFzZbxFq+WlprvKcyQShvFUKpCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2GjDXHBEQ8SU+yNkclYe673imvByyNs0igzufLArPb0Qc69Sq
	Bya+4CYFyZd0AOd0qYgJzXvit1huDgbgcLiPqbNz8CYek80XK3M1agfZ/dPo2SE=
X-Google-Smtp-Source: AGHT+IG2trqvH/COo0RmJGlhBeKlb575jX/M+2KRWkBWiacIcq6FUsdWSbhSiWrvOR9/Vv2rNHU6Jg==
X-Received: by 2002:a17:902:ce82:b0:206:a913:96a7 with SMTP id d9443c01a7336-206f05e55b7mr10488645ad.44.1725582350205;
        Thu, 05 Sep 2024 17:25:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea37cc2sm33928925ad.160.2024.09.05.17.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 17:25:49 -0700 (PDT)
Message-ID: <da10663d-0496-4419-9ab7-91da3fd87199@linuxfoundation.org>
Date: Thu, 5 Sep 2024 18:25:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/101] 6.1.109-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240905093716.075835938@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240905093716.075835938@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 03:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.109 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 07 Sep 2024 09:36:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.109-rc1.gz
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


