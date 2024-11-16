Return-Path: <linux-kernel+bounces-411896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D6E9D00DD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 22:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B562877D0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 21:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528531991DD;
	Sat, 16 Nov 2024 21:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PGCVNCVd"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E6E1957F4
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731791057; cv=none; b=b2HuBigI1ZBu9tcsVvVrgRb7+B8P2r13Ky8dIorMzspbkEt5w2lBRWRr5kTl0owonjjyH30RIRLPg10j7eRFvdouq5Ophlhd32nZkk2SCT39IU0GFtPWbjBUURK3t/500GaI7PCSyWWcxdtmpc3jQJIdPor1Mh6tfDHTVxBXJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731791057; c=relaxed/simple;
	bh=kKJ3qTQEwhEQ5IX+PHwZJtS5Ex8dRqGOuTPBeS9WNCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0qc5RPeXe+cHrF5DX8i8IdT9IjGJ8GW/0iXPeFos9UIWUfUq0TdCF7p4q4hJnQidRvX0i8ixLeX75JbLxAKh8n1971muA9qE0iZUKk+YyimbrbVgTaQ+e2fNbItWTJ9sSSfAxslEi/WGNvvJw6k13TFTrncluUaWBVczzUhi5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PGCVNCVd; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a4e30bffe3so10463065ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 13:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731791054; x=1732395854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U58JmcjKhSMtIBEtYZmZshd6JtYlfTEpWKxxkoGVqew=;
        b=PGCVNCVde1UIXdpEVsX9YkAkTngk8e1CJm9hk8UZxdIE5rDsoBMnCo3ZKIrpKbmh4C
         HzJoijbgQO89aJCyxP6/NMUhEYqAIMmeZQXk/4HA8K0KyWHorPfswTB2CyDsKxc9Lf/A
         Z6IiScedJIUiWKwC0PoKI/YZYCxb3PVoc7p+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731791054; x=1732395854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U58JmcjKhSMtIBEtYZmZshd6JtYlfTEpWKxxkoGVqew=;
        b=NHTumHIM3AeolxoA5S+SytGWO2ZAvP4ffTiqGm1rjkO11N5ejVMPh3tg+eyLuLhQRQ
         yU5SfGAqBepB3hwnb8kxHa32ZX0cbTlnLhF2I1eZyv2qGYxMivyXnxcyskQIV1rfQXiq
         RH/AJehZPJRBOoLcTl2v1Gc7HAeuqGzlv3IWVeDXZjSM3OgeLRKfVB2zpgjRnX0W98Xa
         HJFJRVxFiNiJlznmoFw6rHJkLqfHLaWnp93zHqggspaoTqUHbK0FCAFyji5chZAU3S0r
         To788RJg94sx5BcZaxF1EtHRQH6muIh1Y/T/rwFaBdp7NkJjA5c40eAQtJxgCu2crjMO
         BEVA==
X-Forwarded-Encrypted: i=1; AJvYcCUhwXXVOIbi2IwiFAk5OR1eIQIEG6p3sjRE53SYW3K5kGSinNaqX2/903R5LiMpC2R7ovAalrq0iHytHts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2p64R301z8nkvXNpYeVTWwYYGYeZF/bJBrV7f9Gw2EnU0crHr
	AfrH6R0NkvqZCbqvgH1Ve2h5jCY2thRM+Rs3QeYvvzpLNX0hszT9DSmlBo/SqMM=
X-Google-Smtp-Source: AGHT+IHN59PuVmN6IviLKx+2Cem2ed/yJl1OmGwJP3wojhFylRkff5In1R2svHIJhjohf75HlacK5g==
X-Received: by 2002:a05:6602:2ccf:b0:83a:a9e9:6dc9 with SMTP id ca18e2360f4ac-83e6c3199a9mr743702639f.12.1731791054017;
        Sat, 16 Nov 2024 13:04:14 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e0756f5f28sm1175069173.159.2024.11.16.13.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 13:04:13 -0800 (PST)
Message-ID: <467eaf93-e41c-4c2f-81d3-03cb1934fc5a@linuxfoundation.org>
Date: Sat, 16 Nov 2024 14:04:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 00/63] 6.11.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241115063725.892410236@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241115063725.892410236@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 23:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.9 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
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

