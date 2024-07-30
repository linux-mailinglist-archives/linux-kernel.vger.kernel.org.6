Return-Path: <linux-kernel+bounces-268338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7791A94235F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344BC285544
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1281192B9D;
	Tue, 30 Jul 2024 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DbrPwNLE"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBF5190468
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722381515; cv=none; b=IHNisC2msuw+ydLGs6LYXhJCVH3rhmQwiMpg2EpYojUj8WueqMOifcVCSUfT3hHPg0gwed+knDHKgKWAsMxRmZE5fgv4a36pczCPclwLIUX3LhvJIJJodf3rhNqLcV0BKfzWVdP9MRKjjgyysQrQUh4nnWOZYFUV6KUwBtqwp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722381515; c=relaxed/simple;
	bh=BHpnOjHsaw3hGBR29qRjNfSHbrZWROLb8eFVAKfMx6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htBoGU4ib77nCRZn5/52GdmQVlqcTrtlMnf46jwvSabzZgEMrpbPKCh0P57H+V4JqA9mRhd7fhqWDPDJE5uIjl8Ma0t9Jv7h50cmgrWTj8Iat4vKVqsfF7YMizcNoyuyH8VW8EYoMm9L/ypBqrRYK9nFxj5906O0IZm3dPefw/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DbrPwNLE; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-81f82478b70so27949439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722381511; x=1722986311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pfnz1Mhod0xB0jg/7UultOZotMIwcjsz34ryNq1e+NQ=;
        b=DbrPwNLEBLlyZpUuqHVqbP+PBXF2ugsjVg7CXEH7zcgRkFq1G/YH5knpgs78iDLW5+
         DM9ithpXkCc+Sgr1Z1hj0kWwulBG9p0f+mL+35MG6TFhtBu4PHEK9wyOr28OMmktc9OA
         Eot9bj7QeMTyM4tvPTiGay865rx60gmQSQBbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722381511; x=1722986311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfnz1Mhod0xB0jg/7UultOZotMIwcjsz34ryNq1e+NQ=;
        b=XK/btk3XB6X925/FogjrEREDfoFd50GY0bqK54Y24IvdKGYj4T31SRfFip40PNT4b1
         JmMMiUMCZpdMty7ZrQ8pQ+VmTJVjJEf5ZtD9ngX8EAqsgz2F2xa+o60XfpmU5Wlqzglv
         pGOqakfCbzF2GikimrWl/pgep80qV3MV6tpkADApPV/KI9urpPht498zgZ8z4FELWquW
         8fMife8Gn6zkL7ExF+Fq12H99D7zacawfy8Wt8vQ0YZketX5DuJnXwJ9tFSZ3lPEtvUP
         cLVGZZ+UXQmKRLVfoRngw3o+4jIYa0+ke4tnb8jD9FUfl/ujmaYHs+zSub2IlltpUbt/
         elYA==
X-Forwarded-Encrypted: i=1; AJvYcCV8gUm2SvwLtek8oLPQ4lDfEvdZyoCpoiYacKOzBqy/ODh0sBnXerHc2Gb2wZoz+529uTZGyNlpfe/Q/N8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+73KptHehfHwqqBrRb9zNGJMzgRf6/s783MVRJOy3i0ogqjne
	dqeOCKVX/qFfEPgnYAJLVb66N33L84pK9AwV4sI/RLzTW25KbogAE87/TWrdhNE=
X-Google-Smtp-Source: AGHT+IFPYVEDGwXLv3ojVCIG4y5kw975DDdJ1Ftcw9CCAG+4ZNh4B/SMv9IBFcQwK8WwRKd2Y5lOAA==
X-Received: by 2002:a5e:c116:0:b0:81f:9219:4494 with SMTP id ca18e2360f4ac-81f92194514mr840008839f.2.1722381511530;
        Tue, 30 Jul 2024 16:18:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fc5c850sm2935042173.167.2024.07.30.16.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 16:18:31 -0700 (PDT)
Message-ID: <061886f7-c5ec-419b-8505-b57638c5cf31@linuxfoundation.org>
Date: Tue, 30 Jul 2024 17:18:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 09:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.103 release.
> There are 440 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 Aug 2024 15:14:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.103-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and failed to boot on my test system. Panic during
boot. I will work on finding the problem commit.

thanks,
-- Shuah


