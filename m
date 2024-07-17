Return-Path: <linux-kernel+bounces-255373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3AE933FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1680D2828EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12800181CEC;
	Wed, 17 Jul 2024 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fh9U029Y"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6277D181BBD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230939; cv=none; b=DkjMArtq2nN1ZQhNoMSHPmcQ5JEdFg5Ajsdg3P5qxVz5v8Miip05A14n4JHCHDRhPXxh9yjPCju2oeUFzRjfmaBktCP/4sR1lH4zklfTpCoziUc4Z2rBxOCzdlZBYkCUy2dXmq+uzJ7FZJQ7yQotzs9jUpFHu4B2QhD+Ztg0S3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230939; c=relaxed/simple;
	bh=vuHvG5Bw01x9b75iXfvM8x7eQfEWf59Y3BamQMGwG/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjV1TVrmf12r0xyH2w55RqcVxXW4V0qZ/bh/oxi2mbgK+rlXS+CAC3rkvNb5nu1oDlKi6eu24bj++8iTj3uJnjvKrmCncna47iWDKCCthTDp0+smEn9PhXAaOb44VCTJoMNRfSScT6mRMVHpxf0fgjtouEubOECWdz94rSzLb50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fh9U029Y; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8045e14c32bso4359539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721230935; x=1721835735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cPjwCBYBm9qF0338CZIKw1PFkwmH858FXYIGOpiO0M=;
        b=fh9U029YEAmJbPZ+irdN4d/xbuY0b0l52SMiHBLTliJ1tg4PUXB0A8DJ9iGAIkAXay
         r9dzp29olJ7MHeqRQWVaJuKNkNhMO3iRiinkOX95D3MwNwri/Y5fqJXXwQBoCg16mZHO
         N9Gj/Kt/IlPLNHq+bbemreZjsRjosZ4Iufjf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721230935; x=1721835735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cPjwCBYBm9qF0338CZIKw1PFkwmH858FXYIGOpiO0M=;
        b=DEJnl/wAuej636kvT2wlLiz7m88wZnbtkTWcdFKaZSrFBPghXzFuc3Sr5Na2fTQqR3
         wGrBYtk82ciD+B5Dn9kJ103HuWWtU3+B8nlxUf0LeBxaKR+ilW+/Vav26aoXoKiQpdbE
         +Vuz24elcv2VSf7YYILF8h/3pT0mJzpkh7XcO3u0s9fu9AREKauFp/Bz/RbyVSIzw+4a
         hSDVCjg89aNGwBkTOWszOS35x0DqnKuV8ut8nGjSArgYW0VeogWGkfVcRfrgHMMNBxZ3
         o5mvwMjg+PDmKD03Z2Nv8Gxu02VDe3cCVgHtQlwhFbU44nJmhrrQ8L57Mao1PSDvZnRw
         Jz8A==
X-Forwarded-Encrypted: i=1; AJvYcCUXInoDSPjVRVwyk4EmIbfeIb2yRS1P205evqQi9zZ5kd1zqcT3q7zdgtZOzKlUy3rHV60WfQsj346ErutFuBBjk3XLHausQu3Cchbh
X-Gm-Message-State: AOJu0YwbGY3S0Q2+55AeVL7srQ+ovELJCQe2cHHLuEcbkylOm0FKM2MH
	AnETnFESF9sc8hFDr8XfXKdKU8fSMxKkqAAYrb+miQ+mQvV+xqqN3DwypK2IB3M=
X-Google-Smtp-Source: AGHT+IF/J+Fr5qIJKCpkhnuE7FiXLaULtb21qr9MB3cIRutKC2vqJEtVHOTobpt6Y2/K0mg1P4vPzg==
X-Received: by 2002:a05:6e02:b4f:b0:38e:cdf9:8877 with SMTP id e9e14a558f8ab-395579e88cdmr15685405ab.4.1721230935456;
        Wed, 17 Jul 2024 08:42:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3950aee0d17sm8345205ab.8.2024.07.17.08.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 08:42:14 -0700 (PDT)
Message-ID: <c843e23b-5a8f-4f58-825b-7faaa2988841@linuxfoundation.org>
Date: Wed, 17 Jul 2024 09:42:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/143] 6.9.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240716152755.980289992@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240716152755.980289992@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 09:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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

