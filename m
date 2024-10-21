Return-Path: <linux-kernel+bounces-375226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EF29A9363
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D25F1C22A27
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5CC1FEFA0;
	Mon, 21 Oct 2024 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SnmyeHZ+"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991601E32BA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549997; cv=none; b=nKi0XL/XmY6wa92+A4r2SRI5624IINWI5XJZwqYMZaXCj6BPoB14MbUpF/SSQib0F0JJ2yYAMstTETI8MKoYo9EJXKuAMqnmUh5pEr4sFDYmqwhAG0xmUodSGEln1daRCX6IxJylN09vDR7VIgTnY3GD2lX3+44Wlzk7Y2U3fcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549997; c=relaxed/simple;
	bh=lrwrnJ9sxyVS/b/WeRQ1zGC+n8IdJHwc/MYSyhOj034=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orw+7IKxbEjpIYtgT7BqTH+ldbligwWjQBQJA7IDapQyO/vqyxo/L2UT6Vy4/9/ZpfTmG26L9mKw1kxyKNmcKD0JL1hRZt50h2dhsSmeCzVshjbj2rmNwf7CvQY2Iu8JV1J+dmRUuu65mnhux+PKo1fecCjoouN1wLaEbyuEnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SnmyeHZ+; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-83abcfb9f39so107055639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729549995; x=1730154795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uml1sKj+kvUwOGLK6/8asmpMwnvEywtfjt6wk3MU/qE=;
        b=SnmyeHZ+wxvHx7MBg3X7MPHT18KOlp6/gB6Ennjtj1tIFq5rtr3sGM0KZ3fqbK8d8p
         L/qyyyjiCCEuPNqtJRtt9fWBF6WYvMXMlxKJrlL+9rJnv6YZnO4ZYgq5uM01qzakI0yJ
         LUeBGMyCv2uT6QRcJA4y+8IFTM2SIFdpT5EmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729549995; x=1730154795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uml1sKj+kvUwOGLK6/8asmpMwnvEywtfjt6wk3MU/qE=;
        b=nPMCVZkFTbEUJPZYkLofcJ4FiAW3vk0Ii+ETmBAGyOU/N1UrIQ3bMBWElTiv7sueSS
         +16cQbB94El6PnzLRHMiGEUURpX3bJ5q7u85LOi3AaeCHEe2Rkb4t2B6yCgjphtKQ1wG
         UU5O/APatflfm7PTq2Y2FrT+5OEOffD9rX0f0o4kwsjls8Y72dzZlAfacJufosUn1W/a
         M0vcG1Xpbv2lDNCSDWidlFxEZuU2MxeZQxMYusaVuNMuu8ITmr6Ixp4tuCVx/8LnoW7i
         gueZORnYgVIsrbw8qP2VLuSlw74HzXbD/fzc2svFsMotyto69oR7gtmm5t8Hxe7hYvNL
         UsPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpHE51lKmAxQIVMOmHP0yA4QnKhm1TwV5/+RQgIeoryPiwJZXVwv2etfC4Hyl9jwaCKbW9415D0OUNLgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqHg56Bsbw/gQ3bvFyUzYCMOtnTV6Eix4XSHmdF9Ya8N8vTmIk
	f0sLI7Vh/DJoXKBfXXbrvLiQLQRx5K/T/pv7sepDExSB/bEI1HHytmGdxPKLh4k=
X-Google-Smtp-Source: AGHT+IEJprBi/nPg63JepMRPm5U+FNcv/3C07TNfOCy2tNezSx/w6E0jpGj3z7mxPWwwP8k1cseGRw==
X-Received: by 2002:a05:6e02:1e07:b0:3a0:ce5a:1817 with SMTP id e9e14a558f8ab-3a4cbe359demr8268155ab.0.1729549994578;
        Mon, 21 Oct 2024 15:33:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a65c936sm1258671173.157.2024.10.21.15.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 15:33:14 -0700 (PDT)
Message-ID: <86e869fa-4435-4fe6-a669-4b7a6f1f78cb@linuxfoundation.org>
Date: Mon, 21 Oct 2024 16:33:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/124] 6.6.58-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241021102256.706334758@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241021102256.706334758@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/24 04:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.58 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.58-rc1.gz
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

